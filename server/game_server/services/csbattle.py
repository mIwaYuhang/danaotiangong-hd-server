"""诸神之战 / 仙魔争霸（/CSBattle/*，客户端 ZSZZ*）。

按固定周期循环的四阶段赛事（区服共享 ``RealmStore``）：
1 报名（按等级段 人/地/天 三道各选战力最高的若干种子，机器人补位） → 2 竞猜与鼓舞 → 3 筹备 → 4 开战。
进入开战阶段时一次性模拟循环赛：每位种子与同道其他种子各战一场，``KillCount`` 为胜场数，战报保存供回放。
竞猜押注种子，若种子夺冠按倍数返还；鼓舞为本道全部种子增加战力加成并获得银币。结算后奖励进入待领取列表。
``Notify.XMHaveTime`` 为距开战的剩余秒数（-1 表示未开放）。
"""
from copy import deepcopy

from ..config import thaw
from ..errors import BusinessError
from .base import Reply, RoleContext, global_block
from .battle import BattleEngine, ENEMY_POSITIONS
from .clock import Clock
from .inventory import Ledger
from .player_state import PlayerModel
from .players import PlayerDirectory, RealmStore, ROBOT_BASE

PHASE_SIGNUP, PHASE_GAMBLE, PHASE_PREPARE, PHASE_FIGHT = 1, 2, 3, 4
REWARD_ENCOURAGE, REWARD_RANK, REWARD_GAMBLE = 1, 2, 3


class CsBattleService:
    def __init__(self, config, model: PlayerModel, ledger: Ledger, engine: BattleEngine, clock: Clock,
                 directory: PlayerDirectory, store: RealmStore, realm_name: str):
        self.config = config
        self.model = model
        self.ledger = ledger
        self.engine = engine
        self.clock = clock
        self.directory = directory
        self.store = store
        self.realm_name = realm_name

    # ---- 周期与阶段 -------------------------------------------------------------

    def _cycle_at(self, now: int) -> dict:
        """届次由时间唯一确定（按周期长度对齐），因此无需数据库即可计算阶段。"""
        length = self.config['cycle_days'] * 86400
        return {'index': now // length, 'start': now // length * length}

    def _cycle(self, ctx: RoleContext) -> dict:
        cycle = self._cycle_at(self.clock.now())
        stored = self.store.get(ctx.db, 'csbattle:cycle')
        if stored is None or stored['index'] != cycle['index']:
            self.store.set(ctx.db, 'csbattle:cycle', cycle)
            self.store.delete_prefix(ctx.db, 'csbattle:data')
        return cycle

    def _phase(self, cycle: dict):
        elapsed = self.clock.now() - cycle['start']
        for phase in (PHASE_SIGNUP, PHASE_GAMBLE, PHASE_PREPARE, PHASE_FIGHT):
            span = self.config['phase_days'][str(phase)] * 86400
            if elapsed < span:
                return phase, span - elapsed
            elapsed -= span
        return PHASE_FIGHT, max(0, cycle['start'] + self.config['cycle_days'] * 86400 - self.clock.now())

    def _data(self, ctx: RoleContext, cycle: dict) -> dict:
        data = self.store.get(ctx.db, 'csbattle:data')
        if data is None:
            data = {'seeds': self._pick_seeds(ctx), 'bets': {}, 'encourage': {}, 'logs': [], 'reports': {}, 'fought': False}
            self.store.set(ctx.db, 'csbattle:data', data)
        phase, _ = self._phase(cycle)
        if phase == PHASE_FIGHT and not data['fought']:
            self._run_tournament(ctx, data)
            self.store.set(ctx.db, 'csbattle:data', data)
        return data

    def _type_of_level(self, level: int) -> int:
        for kind, (low, high) in self.config['type_level_bands'].items():
            if low <= level <= high:
                return int(kind)
        return 1

    def _seed_view(self, db, player_id: int, kind: int) -> dict:
        profile = self.directory.profile(db, player_id)
        return {'Type': kind, 'PlayerId': str(player_id), 'ServerId': self.directory.realm_id, 'ServerName': self.realm_name,
                'PlayerName': profile['Name'], 'HeadId': profile['Avatar'], 'UnionName': '', 'TotalPower': profile['BattlePower'],
                'KillCount': 0, 'Rank': 0, 'Level': profile['Level'], **PlayerDirectory.figure_of(profile)}

    def _pick_seeds(self, ctx: RoleContext) -> dict:
        db = ctx.db
        by_type = {str(k): [] for k in (1, 2, 3)}
        for user_id in self.directory.all_user_ids(db):
            profile = self.directory.profile(db, user_id)
            by_type[str(self._type_of_level(profile['Level']))].append(self._seed_view(db, user_id, self._type_of_level(profile['Level'])))
        for kind, rows in by_type.items():
            rows.sort(key=lambda r: -r['TotalPower'])
            del rows[self.config['seeds_per_type']:]
            index = 1
            while len(rows) < self.config['seeds_per_type']:
                rows.append(self._seed_view(db, ROBOT_BASE + 5000 + int(kind) * 100 + index, int(kind)))
                index += 1
            for rank, row in enumerate(rows, 1):
                row['Rank'] = rank
        return by_type

    def _addition(self, data: dict, kind: int) -> int:
        return len(data['encourage'].get(str(kind), [])) * self.config['encourage_addition_percent']

    def _run_tournament(self, ctx: RoleContext, data: dict):
        """开战：每道种子循环赛，胜场即 KillCount；战报以 Id 保存供回放。"""
        db = ctx.db
        for kind, seeds in data['seeds'].items():
            addition = self._addition(data, int(kind))
            for i, attacker in enumerate(seeds):
                for defender in seeds[i + 1:]:
                    allies = [self.engine.hero_unit(dict(h)) for h in self.directory.battle_team(db, int(attacker['PlayerId']))]
                    enemies = [self.engine.hero_unit(dict(h, battleIx=pos)) for h, pos in zip(self.directory.battle_team(db, int(defender['PlayerId'])), ENEMY_POSITIONS)]
                    for unit in enemies:
                        unit.side = 1
                    report = self.engine.simulate(allies, enemies)
                    winner, loser = (attacker, defender) if report['isWin'] else (defender, attacker)
                    winner['KillCount'] += 1
                    log_id = f"{kind}-{len(data['logs']) + 1}"
                    # 客户端战报列表读 ``Id``，回放入口读 ``ID``，两者都给。
                    data['logs'].append({'Id': log_id, 'ID': log_id, 'Type': int(kind), 'IsWin': 1 if report['isWin'] else 0,
                                         **{f'Attack{k}': v for k, v in self._side(attacker, addition).items()},
                                         **{f'Defend{k}': v for k, v in self._side(defender, addition).items()},
                                         'KillCountChange': 1, 'PropertyChange': 0})
                    # 回放走通用战斗场景，需要与其它战斗回复相同的外围字段。
                    report.update(total=1, dropList=[], Reward=[], BattleResult={}, enemy={'Name': defender['PlayerName'], 'Vip': 0})
                    data['reports'][log_id] = report
            seeds.sort(key=lambda s: (-s['KillCount'], -s['TotalPower']))
            for rank, seed in enumerate(seeds, 1):
                seed['Rank'] = rank
        data['fought'] = True
        self._settle(ctx, data)

    @staticmethod
    def _side(seed: dict, addition: int) -> dict:
        return {'PlayerId': seed['PlayerId'], 'ServerId': seed['ServerId'], 'ServerName': seed['ServerName'], 'PlayerName': seed['PlayerName'],
                'HeadId': seed['HeadId'], 'PlayerHeadId': seed['HeadId'], 'OriginalPower': seed['TotalPower'], 'TotalPower': seed['TotalPower'],
                'EncouragingAddition': addition}

    def _grant_pending(self, ctx: RoleContext, user_id: int, entry: dict):
        if user_id == ctx.user:
            self._player(ctx.state)['pending'].append(entry)
            return
        other = self.directory.load_state(ctx.db, user_id)
        if other is not None:
            self._player(other)['pending'].append(entry)
            self.directory.save_state(ctx.db, user_id, other)

    def _settle(self, ctx: RoleContext, data: dict):
        counter = 0
        for kind, seeds in data['seeds'].items():
            champion = seeds[0]
            for seed in seeds:
                if self.directory.is_robot(int(seed['PlayerId'])):
                    continue
                rewards = next((thaw(r['rewards']) for r in self.config['rank_rewards'] if r['rank_min'] <= seed['Rank'] <= r['rank_max']), [])
                if rewards:
                    counter += 1
                    self._grant_pending(ctx, int(seed['PlayerId']), {'Id': counter, 'CSBattleRewardType': REWARD_RANK, 'CSBattleType': int(kind),
                                                                      'Rank': seed['Rank'], 'RewradResponse': rewards})
            for user_id, bets in data['bets'].get(kind, {}).items():
                for bet in bets:
                    if bet['target'] == champion['PlayerId']:
                        counter += 1
                        payout = [dict(Type=1, ID=0, Count=bet['gold'] * self.config['gamble_gold'] * self.config['gamble_payout']),
                                  dict(Type=2, ID=0, Count=bet['ingot'] * self.config['gamble_ingot'] * self.config['gamble_payout'])]
                        self._grant_pending(ctx, int(user_id), {'Id': counter, 'CSBattleRewardType': REWARD_GAMBLE, 'CSBattleType': int(kind),
                                                                'Rank': 1, 'BeServerName': champion['ServerName'], 'BePlayerName': champion['PlayerName'],
                                                                'RewradResponse': [p for p in payout if p['Count'] > 0]})
            for user_id in data['encourage'].get(kind, []):
                counter += 1
                self._grant_pending(ctx, int(user_id), {'Id': counter, 'CSBattleRewardType': REWARD_ENCOURAGE, 'CSBattleType': int(kind),
                                                        'Rank': 1, 'RewradResponse': thaw(self.config['encourager_reward'])})

    # ---- 玩家 -------------------------------------------------------------

    def _player(self, state: dict) -> dict:
        return state.setdefault('CsBattle', {'pending': [], 'claimed': 0})

    def _open(self, ctx: RoleContext):
        if ctx.state['PLevel'] < self.config['open_level']:
            raise BusinessError('诸神之战尚未开放')
        cycle = self._cycle(ctx)
        data = self._data(ctx, cycle)
        phase, countdown = self._phase(cycle)
        return cycle, data, phase, countdown

    def home(self, ctx: RoleContext, params) -> dict:
        _, data, phase, countdown = self._open(ctx)
        my_encouraged = {kind: ctx.user in [int(u) for u in users] for kind, users in data['encourage'].items()}
        return {'CSBattleStatus': phase, 'Countdown': countdown, 'IsTop32Exists': 1 if data['fought'] else 0,
                'CsbattleRank': [deepcopy(s) for seeds in data['seeds'].values() for s in seeds],
                'Encourage': [{'Type': k, 'IsEncouragable': 0 if (phase != PHASE_GAMBLE or my_encouraged.get(str(k))) else 1,
                               'EncourageCount': len(data['encourage'].get(str(k), [])), 'PowerAddition': self._addition(data, k)} for k in (1, 2, 3)]}

    def _my_seed(self, data: dict, user_id: int):
        for kind, seeds in data['seeds'].items():
            for seed in seeds:
                if seed['PlayerId'] == str(user_id):
                    return int(kind), seed
        return None, None

    def fight_info(self, ctx: RoleContext, params) -> dict:
        _, data, _, _ = self._open(ctx)
        kind, mine = self._my_seed(data, ctx.user)
        kind = kind or params.get('type') or self._type_of_level(ctx.state['PLevel'])
        seeds = data['seeds'][str(kind)]
        return {'Type': kind,
                'MyCsbattleInfo': {'OriginalPower': mine['TotalPower'], 'EncouragingAddition': self._addition(data, kind), 'RebornCount': 0,
                                   'KillCount': mine['KillCount'], 'CurrentRank': mine['Rank']} if mine else None,
                'CsbattleRankInfo': [{'ServerName': s['ServerName'], 'PlayerName': s['PlayerName'], 'KillCount': s['KillCount'],
                                      'PlayerHeadId': s['HeadId'], 'PlayerId': s['PlayerId']} for s in seeds[:3]],
                'CsbattleLogInfo': [l for l in data['logs'] if l['Type'] == kind]}

    def top32(self, ctx: RoleContext, params) -> dict:
        return self.fight_info(ctx, params)

    def rank_list(self, ctx: RoleContext, params) -> list:
        _, data, _, _ = self._open(ctx)
        kind = params['type']
        rows = []
        for seed in data['seeds'].get(str(kind), []):
            reward = next((thaw(r['rewards']) for r in self.config['rank_rewards'] if r['rank_min'] <= seed['Rank'] <= r['rank_max']), [])
            rows.append({'Rank': seed['Rank'], 'PlayerId': seed['PlayerId'], 'ServerId': seed['ServerId'], 'ServerName': seed['ServerName'],
                         'PlayerName': seed['PlayerName'], 'UnionName': '', 'TotalPower': seed['TotalPower'], 'KillCount': seed['KillCount'],
                         'PlayerHeadId': seed['HeadId'], 'Reward': reward})
        return rows

    def battle_reports(self, ctx: RoleContext, params) -> list:
        _, data, _, _ = self._open(ctx)
        target = str(params.get('PlayerID') or ctx.user)
        kind, mine = self._my_seed(data, int(target)) if target.isdigit() else (None, None)
        rows = [dict(l, MyRank=mine['Rank'] if mine else 0) for l in data['logs'] if target in (l['AttackPlayerId'], l['DefendPlayerId'])]
        return rows

    def battle_log(self, ctx: RoleContext, params) -> dict:
        _, data, _, _ = self._open(ctx)
        report = data['reports'].get(str(params['id']))
        if report is None:
            raise BusinessError('战报不存在')
        return deepcopy(report)

    def team_info(self, ctx: RoleContext, params) -> dict:
        profile = self.directory.profile(ctx.db, params['playerID'])
        return {'Name': profile['Name'], 'PLevel': profile['Level'], 'team': profile['team'], 'partnerTeam': profile['partnerTeam'],
                'attributeAddition': profile['attributeAddition']}

    # ---- 竞猜 / 鼓舞 -------------------------------------------------------------

    def gamble_info(self, ctx: RoleContext, params) -> dict:
        _, data, phase, _ = self._open(ctx)
        kind = str(params['type'])
        bets = data['bets'].get(kind, {})
        rows = []
        for seed in data['seeds'].get(kind, []):
            total_gold = sum(b['gold'] for user_bets in bets.values() for b in user_bets if b['target'] == seed['PlayerId'])
            total_ingot = sum(b['ingot'] for user_bets in bets.values() for b in user_bets if b['target'] == seed['PlayerId'])
            mine = [b for b in bets.get(str(ctx.user), []) if b['target'] == seed['PlayerId']]
            rows.append({'PlayerId': seed['PlayerId'], 'ServerId': seed['ServerId'], 'ServerName': seed['ServerName'], 'PlayerName': seed['PlayerName'],
                         'HeadId': seed['HeadId'], 'UnionName': '', 'TotalPower': seed['TotalPower'], 'TotalGoldRolled': total_gold,
                         'TotalIngotRolled': total_ingot, 'SelfGoldRolled': sum(b['gold'] for b in mine), 'SelfIngotRolled': sum(b['ingot'] for b in mine)})
        cfg = self.config
        return {'IsCanGamble': phase == PHASE_GAMBLE, 'GambleGold': cfg['gamble_gold'], 'GambleIngot': cfg['gamble_ingot'],
                'MaxGambleGoldRolled': cfg['max_gold_rolled'], 'MaxGambleIngotRolled': cfg['max_ingot_rolled'],
                'TotalGold': sum(r['TotalGoldRolled'] for r in rows) * cfg['gamble_gold'],
                'TotalIngot': sum(r['TotalIngotRolled'] for r in rows) * cfg['gamble_ingot'], 'CurrentGambleList': rows}

    def gamble(self, ctx: RoleContext, params) -> Reply:
        """``/CSBattle/Gamble?bePlayerId&beServerId&goldRolled&ingotRolled``：注数 × 每注金额。"""
        _, data, phase, _ = self._open(ctx)
        if phase != PHASE_GAMBLE:
            raise BusinessError('当前不在竞猜阶段')
        target = str(params['bePlayerId'])
        kind = next((k for k, seeds in data['seeds'].items() if any(s['PlayerId'] == target for s in seeds)), None)
        if kind is None:
            raise BusinessError('该选手不在本届比赛中')
        gold, ingot = params.get('goldRolled') or 0, params.get('ingotRolled') or 0
        if gold <= 0 and ingot <= 0:
            raise BusinessError('请选择押注数量')
        mine = data['bets'].setdefault(kind, {}).setdefault(str(ctx.user), [])
        already = [b for b in mine if b['target'] == target]
        if sum(b['gold'] for b in already) + gold > self.config['max_gold_rolled'] or sum(b['ingot'] for b in already) + ingot > self.config['max_ingot_rolled']:
            raise BusinessError('押注已达上限')
        consume = [dict(Type=1, ID=0, Count=gold * self.config['gamble_gold']), dict(Type=2, ID=0, Count=ingot * self.config['gamble_ingot'])]
        outcome = self.ledger.apply(ctx.state, consume=[c for c in consume if c['Count'] > 0])
        mine.append({'target': target, 'gold': gold, 'ingot': ingot})
        self.store.set(ctx.db, 'csbattle:data', data)
        return Reply({}, self.ledger.global_for(ctx.state, outcome))

    def encourage_info(self, ctx: RoleContext, params) -> list:
        _, data, _, _ = self._open(ctx)
        rows = []
        for user_id in data['encourage'].get(str(params['type']), []):
            profile = self.directory.profile(ctx.db, int(user_id))
            rows.append({'PlayerName': profile['Name'], 'Time': 0, 'PowerAddtion': self.config['encourage_addition_percent']})
        return rows

    def encourage(self, ctx: RoleContext, params) -> Reply:
        """``/CSBattle/Encouraging?type``：花元宝为本道种子鼓舞，获得银币。"""
        _, data, phase, _ = self._open(ctx)
        if phase != PHASE_GAMBLE:
            raise BusinessError('当前不能鼓舞')
        users = data['encourage'].setdefault(str(params['type']), [])
        if ctx.user in [int(u) for u in users]:
            raise BusinessError('你已鼓舞过本道')
        outcome = self.ledger.apply(ctx.state, consume=[dict(Type=2, ID=0, Count=self.config['encourage_ingot'])],
                                    rewards=[dict(Type=1, ID=0, Count=self.config['encourage_reward_gold'])])
        users.append(ctx.user)
        self.store.set(ctx.db, 'csbattle:data', data)
        return Reply({'Reward': deepcopy(outcome.rewards)}, self.ledger.global_for(ctx.state, outcome))

    # ---- 奖励 -------------------------------------------------------------

    def reward_list(self, ctx: RoleContext, params) -> list:
        self._open(ctx)
        return deepcopy(self._player(ctx.state)['pending'])

    def claim(self, ctx: RoleContext, params) -> Reply:
        self._open(ctx)
        data = self._player(ctx.state)
        entry = next((p for p in data['pending'] if p['Id'] == params['id']), None)
        if entry is None:
            raise BusinessError('奖励不存在或已领取')
        outcome = self.ledger.apply(ctx.state, rewards=entry['RewradResponse'])
        data = self._player(ctx.state)
        data['pending'] = [p for p in data['pending'] if p['Id'] != params['id']]
        return Reply({}, self.ledger.global_for(ctx.state, outcome))

    def notify(self, state: dict) -> dict:
        if state['PLevel'] < self.config['open_level']:
            return {'XMHaveTime': -1}
        phase, countdown = self._phase(self._cycle_at(self.clock.now()))
        if phase == PHASE_FIGHT:
            return {'XMHaveTime': 0}
        remaining = countdown + sum(self.config['phase_days'][str(p)] * 86400 for p in range(phase + 1, PHASE_FIGHT))
        return {'XMHaveTime': remaining}
