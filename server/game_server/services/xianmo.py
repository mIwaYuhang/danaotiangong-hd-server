"""仙魔争霸（/Xm/*，客户端 CS* 场景）：每日一届的三道（人/地/天）八强淘汰赛。

- 每天按 ``features/xianmo.json`` 的 ``fight_hour`` 开赛：开赛前 ``prep_seconds`` 内为准备期
  （``HaveTime`` = 剩余秒），比赛持续 ``fight_duration`` 秒（``HaveTime`` = 0），
  各轮按 ``round_reveal_seconds`` 逐轮揭晓；其余时间休赛（``HaveTime`` = -1）。
- 种子：按 ``dao_bands`` 等级带取战力最高的真实玩家，机器人补位；当届对阵与胜负在建届时用
  确定性随机数一次算好，只是按时间逐轮揭晓。
- 休赛期可对前三名膜拜 / 唾弃（每日合计 ``worship_daily`` 次）；比赛期可对未揭晓的对阵押注银币，
  押中按 ``win_multiplier`` 返还。
- 排名奖励（``/Xm/RankReward``）客户端只展示，没有领取入口。

区服共享数据存在 ``RealmStore``：``xianmo:<日期>`` 为当届数据，``xianmo:worship:<玩家>`` 为膜拜记录。
"""
import datetime as dt
import random
from copy import deepcopy

from ..config import thaw
from ..errors import BusinessError
from .base import Reply, RoleContext
from .battle import BattleEngine, ENEMY_POSITIONS
from .clock import Clock
from .hero_model import new_hero_record
from .inventory import Ledger
from .player_state import PlayerModel
from .players import PlayerDirectory, RealmStore, ROBOT_BASE

STATE_REWARD_TAKEN = -1131001
SUPPORT, OPPOSE = 1, 2
#: 机器人种子 ID 段：ROBOT_BASE + 偏移 + 道×100 + 序号（避开争霸/诸神等其它机器人段）。
ROBOT_OFFSET = 900_000


class XianmoService:
    def __init__(self, config, model: PlayerModel, ledger: Ledger, engine: BattleEngine, clock: Clock,
                 directory: PlayerDirectory, store: RealmStore):
        self.config = config
        self.model = model
        self.ledger = ledger
        self.engine = engine
        self.clock = clock
        self.directory = directory
        self.store = store
        self.catalog = model.catalog

    # ---- 赛程 -------------------------------------------------------------

    def _fight_start(self, now: int) -> int:
        local = dt.datetime.fromtimestamp(now)
        start = local.replace(hour=self.config['fight_hour'], minute=self.config['fight_minute'],
                              second=0, microsecond=0)
        return int(start.timestamp())

    def _have_time(self, now: int) -> int:
        """-1 休赛 / >0 距开赛秒数（准备期）/ 0 比赛中。"""
        start = self._fight_start(now)
        if start - self.config['prep_seconds'] <= now < start:
            return start - now
        if start <= now < start + self.config['fight_duration']:
            return 0
        return -1

    def _dao_of_level(self, level: int) -> int:
        for index, (low, high) in enumerate(self.config['dao_bands'], 1):
            if low <= level <= high:
                return index
        return len(self.config['dao_bands'])

    # ---- 当届数据 -----------------------------------------------------------

    def _cycle(self, db) -> dict:
        day = self.clock.day_key()
        data = self.store.get(db, f'xianmo:{day}')
        if data is None:
            data = self._build_cycle(db, day)
            self.store.set(db, f'xianmo:{day}', data)
        return data

    def _robot_seed(self, rng: random.Random, dao: int, index: int) -> dict:
        low, high = self.config['dao_bands'][dao - 1]
        level = min(int(high), max(int(low), (int(low) + min(int(high), 120)) // 2 + rng.randint(-3, 3)))
        hero_ids = sorted(int(k) for k, h in self.catalog['BaseHeros'].items() if h.get('quality', 0) >= 4)
        hero_id = hero_ids[rng.randrange(len(hero_ids))] if hero_ids else 101
        record = new_hero_record(hero_id, battle_ix=1)
        record.update(level=level, rebirthCount=level // 15, rageTrained=max(1, level // 5))
        self.model.heroes.refresh(record)
        names = self.config['robot_names']
        return {'PlayerId': ROBOT_BASE + ROBOT_OFFSET + dao * 100 + index, 'Name': f'{names[(index - 1) % len(names)]}·{dao}{index}',
                'Avatar': hero_id, 'Level': level, 'BattlePower': record['battlePower'],
                'RebirthCount': record['rebirthCount'], 'robot': True}

    def _build_cycle(self, db, day: str) -> dict:
        rng = random.Random(f'{self.directory.realm_id}:{day}:xianmo')
        per_dao = int(self.config['seeds_per_dao'])
        profiles = []
        for user_id in self.directory.all_user_ids(db):
            profile = self.directory.profile(db, user_id)
            profiles.append({'PlayerId': user_id, 'Name': profile['Name'], 'Avatar': profile['Avatar'],
                             'Level': profile['Level'], 'BattlePower': profile['BattlePower'],
                             'RebirthCount': int(profile.get('RebirthCount') or 0), 'robot': False})
        start = self._fight_start(self.clock.now())
        reveals = [start + int(s) for s in self.config['round_reveal_seconds']]
        cycle = {'day': day, 'daos': {}}
        for dao in range(1, len(self.config['dao_bands']) + 1):
            low, high = self.config['dao_bands'][dao - 1]
            seeds = sorted((p for p in profiles if low <= p['Level'] <= high),
                           key=lambda p: -p['BattlePower'])[:per_dao]
            index = 1
            while len(seeds) < per_dao:
                seeds.append(self._robot_seed(rng, dao, index))
                index += 1
            seeds.sort(key=lambda p: -p['BattlePower'])
            matches = self._build_bracket(rng, seeds, reveals)
            cycle['daos'][str(dao)] = {'seeds': seeds, 'matches': matches}
        return cycle

    @staticmethod
    def _pick_winner(rng: random.Random, a: dict, b: dict) -> int:
        total = max(1, a['BattlePower'] + b['BattlePower'])
        return a['PlayerId'] if rng.random() < a['BattlePower'] / total else b['PlayerId']

    def _build_bracket(self, rng: random.Random, seeds: list, reveals: list) -> list:
        """四分之一 → 半决 → 决赛 + 季军；胜负建届时算好，按 reveal 时间揭晓。"""
        by_id = {s['PlayerId']: s for s in seeds}
        order = [0, 7, 3, 4, 1, 6, 2, 5][:len(seeds)]
        quarter_pairs = [(seeds[order[i]]['PlayerId'], seeds[order[i + 1]]['PlayerId']) for i in range(0, len(order), 2)]
        matches = []
        winners = []
        for attack, defend in quarter_pairs:
            winner = self._pick_winner(rng, by_id[attack], by_id[defend])
            winners.append(winner)
            matches.append({'rank': 8, 'attack': attack, 'defend': defend, 'winner': winner, 'reveal': reveals[0]})
        semi_winners, semi_losers = [], []
        for i in range(0, len(winners), 2):
            attack, defend = winners[i], winners[i + 1]
            winner = self._pick_winner(rng, by_id[attack], by_id[defend])
            semi_winners.append(winner)
            semi_losers.append(defend if winner == attack else attack)
            matches.append({'rank': 4, 'attack': attack, 'defend': defend, 'winner': winner, 'reveal': reveals[1]})
        final_winner = self._pick_winner(rng, by_id[semi_winners[0]], by_id[semi_winners[1]])
        matches.append({'rank': 2, 'attack': semi_winners[0], 'defend': semi_winners[1],
                        'winner': final_winner, 'reveal': reveals[2]})
        third_winner = self._pick_winner(rng, by_id[semi_losers[0]], by_id[semi_losers[1]])
        matches.append({'rank': 3, 'attack': semi_losers[0], 'defend': semi_losers[1],
                        'winner': third_winner, 'reveal': reveals[2]})
        return matches

    # ---- 名次与展示 -----------------------------------------------------------

    @staticmethod
    def _revealed(match: dict, now: int) -> bool:
        return now >= match['reveal']

    def _rankings(self, dao_data: dict, now: int) -> dict:
        """玩家 ID → 名次；全部揭晓后 1..8，否则按战力种子顺序。"""
        seeds = dao_data['seeds']
        matches = dao_data['matches']
        if all(self._revealed(m, now) for m in matches):
            final = next(m for m in matches if m['rank'] == 2)
            third = next(m for m in matches if m['rank'] == 3)
            champion = final['winner']
            runner = final['defend'] if champion == final['attack'] else final['attack']
            third_w = third['winner']
            third_l = third['defend'] if third_w == third['attack'] else third['attack']
            ranking = {champion: 1, runner: 2, third_w: 3, third_l: 4}
            rest = [s['PlayerId'] for s in seeds if s['PlayerId'] not in ranking]
            for offset, player in enumerate(rest, 5):
                ranking[player] = offset
            return ranking
        return {s['PlayerId']: i for i, s in enumerate(seeds, 1)}

    def _current_round(self, dao_data: dict, now: int) -> int:
        for match in dao_data['matches']:
            if not self._revealed(match, now) and match['rank'] in (8, 4, 2):
                return match['rank']
        return 2

    def _seed(self, cycle: dict, player_id: int):
        for dao_data in cycle['daos'].values():
            for seed in dao_data['seeds']:
                if seed['PlayerId'] == player_id:
                    return seed
        return None

    # ---- 玩家状态 -----------------------------------------------------------

    def _player(self, state: dict) -> dict:
        block = state.setdefault('Xianmo', {})
        today = self.clock.day_key()
        if block.get('day') != today:
            block['day'] = today
            block['worships'] = 0
            block['last_type'] = {}
        block.setdefault('bets', [])
        return block

    # ---- 大厅 -------------------------------------------------------------

    def worship_info(self, ctx: RoleContext, params) -> dict:
        """``/Xm/WorshipInfo``。"""
        state = ctx.state
        now = self.clock.now()
        cycle = self._cycle(ctx.db)
        dao = self._dao_of_level(state['PLevel'])
        dao_data = cycle['daos'][str(dao)]
        have_time = self._have_time(now)
        block = self._player(state)
        remaining = max(0, self.config['worship_daily'] - block['worships'])
        ranking = self._rankings(dao_data, now)
        top3 = sorted(dao_data['seeds'], key=lambda s: ranking.get(s['PlayerId'], 99))[:3]
        rows = [{'PlayerID': s['PlayerId'], 'PlayerName': s['Name'], 'AvatarId': s['Avatar'],
                 'HaveWorshipTimes': remaining,
                 'BeWorshipType': block['last_type'].get(str(s['PlayerId']), 0)} for s in top3]
        next_start = self._fight_start(now)
        if now >= next_start:
            next_start += 86400
        return {'RankType': dao, 'HaveTime': have_time,
                'Prestige': state.get('Prestige', 0), 'PrestigeRank': 0,
                'LowestPrestige': self.config['lowest_prestige'],
                'NextRankTime': dt.datetime.fromtimestamp(next_start).strftime('%m月%d日 %H:%M'),
                'RankingNum': self._current_round(dao_data, now),
                'SpitCost': self.config['spit_cost'],
                'WorshipRankInfo': rows}

    def worship(self, ctx: RoleContext, params) -> Reply:
        """``/Xm/Worship?beWorshipPlayerID&worshipType``：1 膜拜 / 2 唾弃。"""
        state = ctx.state
        target = params['beWorshipPlayerID']
        kind = params['worshipType']
        if kind not in (SUPPORT, OPPOSE):
            raise BusinessError('无效的膜拜类型')
        cycle = self._cycle(ctx.db)
        if self._seed(cycle, target) is None:
            raise BusinessError('该玩家不在争霸榜上')
        block = self._player(state)
        if block['worships'] >= self.config['worship_daily']:
            raise BusinessError('今日膜拜次数已用完', STATE_REWARD_TAKEN)
        consume = [dict(Type=2, ID=0, Count=self.config['spit_cost'])] if kind == OPPOSE and self.config['spit_cost'] else []
        rewards = thaw(self.config['support_reward' if kind == SUPPORT else 'oppose_reward'])
        outcome = self.ledger.apply(state, rewards=rewards, consume=consume)
        block = self._player(state)
        block['worships'] += 1
        block['last_type'][str(target)] = kind
        key = f'xianmo:worship:{target}'
        log = self.store.get(ctx.db, key) or {'WorshipCnt': 0, 'SplitCnt': 0, 'rows': []}
        log['WorshipCnt' if kind == SUPPORT else 'SplitCnt'] += 1
        log['rows'].insert(0, {'Times': self.clock.now(), 'Playername': state['Name'], 'WorshipType': kind})
        log['rows'] = log['rows'][:30]
        self.store.set(ctx.db, key, log)
        return Reply({'Reward': deepcopy(outcome.rewards)}, self.ledger.global_for(state, outcome))

    def worship_log(self, ctx: RoleContext, params) -> dict:
        """``/Xm/WorshipLog?beWorshipPlayerID``。"""
        target = params['beWorshipPlayerID']
        cycle = self._cycle(ctx.db)
        seed = self._seed(cycle, target)
        if seed is None:
            raise BusinessError('该玩家不在争霸榜上')
        log = self.store.get(ctx.db, f'xianmo:worship:{target}') or {'WorshipCnt': 0, 'SplitCnt': 0, 'rows': []}
        vip = 0
        if not seed['robot']:
            other = self.directory.load_state(ctx.db, target)
            vip = (other or {}).get('VipLevel', 0)
        return {'PlayerName': seed['Name'], 'Level': seed['Level'], 'VipLevel': vip,
                'WorshipCnt': log['WorshipCnt'], 'SplitCnt': log['SplitCnt'],
                'AvatarId': seed['Avatar'],
                'WorshipLogInfo': [dict(row, Times=self.clock.age(row.get('Times'))) for row in log['rows']]}

    # ---- 排行与奖励展示 -----------------------------------------------------------

    def rank_info(self, ctx: RoleContext, params) -> dict:
        """``/Xm/RankInfo?type``。"""
        now = self.clock.now()
        cycle = self._cycle(ctx.db)
        dao_data = cycle['daos'][str(params['type'])]
        ranking = self._rankings(dao_data, now)
        rows = [{'playerID': s['PlayerId'], 'name': s['Name'], 'level': s['Level'],
                 'battlePower': s['BattlePower'], 'rank': ranking.get(s['PlayerId'], 0)}
                for s in dao_data['seeds']]
        rows.sort(key=lambda r: r['rank'])
        return {'lastUpdateTime': dt.datetime.fromtimestamp(now).strftime('%Y-%m-%d %H:%M'),
                'playerRank': ranking.get(ctx.user, 0), 'playerInfos': rows}

    def rank_reward(self, ctx: RoleContext, params) -> dict:
        """``/Xm/RankReward?type``：展示名次奖励。"""
        return {'rankRewardInfos': [{'rank': row['rank'], 'reward': thaw(row['reward'])}
                                    for row in self.config['rank_rewards']]}

    def get_rank_reward(self, ctx: RoleContext, params):
        raise BusinessError('排名奖励将在比赛结束后自动发放')

    # ---- 战报与押注 -----------------------------------------------------------

    def _report_rows(self, dao_data: dict, now: int) -> list:
        rows = []
        for match in dao_data['matches']:
            attack = self._seed_row(dao_data, match['attack'])
            defend = self._seed_row(dao_data, match['defend'])
            rows.append({'rank': match['rank'],
                         'attackPlayerID': attack['PlayerId'], 'defendPlayerID': defend['PlayerId'],
                         'attackName': attack['Name'], 'defendName': defend['Name'],
                         'attackAvatarID': attack['Avatar'], 'defendAvatarID': defend['Avatar'],
                         'attackBattlePower': attack['BattlePower'], 'defendBattlePower': defend['BattlePower'],
                         'winnerID': match['winner'] if self._revealed(match, now) else None})
        return rows

    @staticmethod
    def _seed_row(dao_data: dict, player_id: int) -> dict:
        return next(s for s in dao_data['seeds'] if s['PlayerId'] == player_id)

    def _bet_state(self, dao_data: dict, bet: dict, now: int) -> int:
        match = next((m for m in dao_data['matches'] if m['rank'] == bet['rank']
                      and bet['target'] in (m['attack'], m['defend'])), None)
        if match is None or not self._revealed(match, now):
            return 0
        return 1 if match['winner'] == bet['target'] else 0

    def battle_report(self, ctx: RoleContext, params) -> dict:
        """``/Xm/BattlereportInfo?rankPlayerID&type&rankType``：对阵树 + 我的押注。"""
        state = ctx.state
        now = self.clock.now()
        cycle = self._cycle(ctx.db)
        dao = params['type'] or self._dao_of_level(state['PLevel'])
        dao_data = cycle['daos'][str(dao)]
        block = self._player(state)
        today = self.clock.day_key()
        gamble_rows = [{'beBetPlayerID': b['target'], 'rank': b['rank'], 'gold': b['gold'],
                        'state': self._bet_state(dao_data, b, now)}
                       for b in block['bets'] if b['day'] == today and not b['claimed']]
        ranking = self._rankings(dao_data, now)
        next_reveal = min((m['reveal'] for m in dao_data['matches'] if not self._revealed(m, now)), default=0)
        return {'battlereportInfos': self._report_rows(dao_data, now),
                'gambleInfos': gamble_rows,
                'rank': ranking.get(ctx.user, 0) if ctx.user in ranking else 0,
                'remainTime': Clock.remaining(next_reveal, now) if next_reveal else 0}

    def gamble(self, ctx: RoleContext, params) -> Reply:
        """``/Xm/Gamble?beBetPlayerID&rank&gold``。"""
        state = ctx.state
        target, rank, gold = params['beBetPlayerID'], params['rank'], params['gold']
        if gold <= 0:
            raise BusinessError('押注金额无效')
        now = self.clock.now()
        cycle = self._cycle(ctx.db)
        dao = self._dao_of_level(state['PLevel'])
        dao_data = cycle['daos'][str(dao)]
        match = next((m for m in dao_data['matches'] if m['rank'] == rank and target in (m['attack'], m['defend'])), None)
        if match is None:
            raise BusinessError('对阵不存在')
        if self._revealed(match, now):
            raise BusinessError('该场比赛已结束，无法押注')
        block = self._player(state)
        today = self.clock.day_key()
        if any(b['day'] == today and b['rank'] == rank and not b['claimed'] for b in block['bets']):
            raise BusinessError('该轮已押注')
        outcome = self.ledger.apply(state, consume=[dict(Type=1, ID=0, Count=gold)])
        block = self._player(state)
        block['bets'].append({'target': target, 'rank': rank, 'gold': gold, 'day': today, 'claimed': False})
        return Reply({}, self.ledger.global_for(state, outcome))

    def get_gamble(self, ctx: RoleContext, params) -> Reply:
        """``/Xm/GetGamble?beBetPlayerID&rank``：押中领奖。"""
        state = ctx.state
        target, rank = params['beBetPlayerID'], params['rank']
        now = self.clock.now()
        cycle = self._cycle(ctx.db)
        dao = self._dao_of_level(state['PLevel'])
        dao_data = cycle['daos'][str(dao)]
        block = self._player(state)
        today = self.clock.day_key()
        bet = next((b for b in block['bets'] if b['day'] == today and b['target'] == target
                    and b['rank'] == rank and not b['claimed']), None)
        if bet is None:
            raise BusinessError('没有可领取的押注')
        if self._bet_state(dao_data, bet, now) != 1:
            raise BusinessError('押注尚未获胜')
        payout = int(bet['gold'] * self.config['win_multiplier'])
        outcome = self.ledger.apply(state, rewards=[dict(Type=1, ID=0, Count=payout)])
        block = self._player(state)
        for row in block['bets']:
            if row['day'] == today and row['target'] == target and row['rank'] == rank:
                row['claimed'] = True
        return Reply({'Reward': deepcopy(outcome.rewards)}, self.ledger.global_for(state, outcome))

    # ---- 阵容与战斗回放 -----------------------------------------------------------

    def _robot_team_view(self, seed: dict) -> dict:
        record = new_hero_record(seed['Avatar'], battle_ix=1)
        record.update(level=seed['Level'], rebirthCount=seed['Level'] // 15,
                      rageTrained=max(1, seed['Level'] // 5))
        self.model.heroes.refresh(record)
        return {'team': {'battlePower': record['battlePower'], 'groupList': [record]},
                'partnerTeam': [], 'attributeAddition': {}}

    def team_info(self, ctx: RoleContext, params) -> dict:
        """``/Xm/TeamInfo?rankPlayerID``。"""
        target = params['rankPlayerID']
        cycle = self._cycle(ctx.db)
        seed = self._seed(cycle, target)
        if seed is not None and seed['robot']:
            return self._robot_team_view(seed)
        profile = self.directory.profile(ctx.db, target)
        return {'team': profile['team'], 'partnerTeam': profile['partnerTeam'],
                'attributeAddition': profile['attributeAddition']}

    def _units_of(self, db, cycle: dict, player_id: int, side: int):
        seed = self._seed(cycle, player_id)
        base = 1 if side == 0 else ENEMY_POSITIONS[0]
        if seed is not None and seed['robot']:
            unit = self.engine.template_unit(seed['Avatar'], seed['Level'], base, side=side,
                                             rebirth=seed['Level'] // 15)
            return [unit]
        heroes = self.directory.battle_team(db, player_id)
        units = []
        for offset, hero in enumerate(heroes[:6]):
            unit = self.engine.hero_unit(dict(hero, battleIx=base + offset))
            unit.side = side
            unit.pos = base + offset
            units.append(unit)
        return units

    def battle_info(self, ctx: RoleContext, params) -> dict:
        """``/Xm/BattleInfo?attackPlayerID&defendPlayerID&type``：模拟并返回标准战报。"""
        cycle = self._cycle(ctx.db)
        attackers = self._units_of(ctx.db, cycle, params['attackPlayerID'], 0)
        defenders = self._units_of(ctx.db, cycle, params['defendPlayerID'], 1)
        report = self.engine.simulate(attackers, defenders)
        report.update(total=1, Reward=[], BattleResult={})
        return report
