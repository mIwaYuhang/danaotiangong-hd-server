"""争霸（/Duel/*）与妖王洞穴（/Worldboss/*）——单机适配版。

争霸：``robot_count`` 个机器人组成排行榜，机器人阵容按英雄模板随等级生成；
玩家挑战排名更靠前的对手（``/Duel/Challenge?rank``），胜利则互换排名。
积分按排名区间随时间累积，可在积分商店兑换。

妖王洞穴：每日固定时段开放（``features.json.worldboss.sessions``），四妖王共享一次活动内的血量；
玩家伤害换银币，死亡后按冷却复活或花元宝立即复活。
"""
from copy import deepcopy
import random

from ..config import thaw
from ..errors import BusinessError
from .base import Reply, RoleContext, global_block
from .battle import BattleEngine, ENEMY_POSITIONS
from .clock import Clock
from .inventory import Ledger
from .player_state import PlayerModel

PK_SCORE_TYPE = 19
STATE_WORLDBOSS_CLOSED = -1151010


class ArenaService:
    def __init__(self, config, model: PlayerModel, ledger: Ledger, engine: BattleEngine, clock: Clock):
        self.config = config
        self.model = model
        self.ledger = ledger
        self.engine = engine
        self.clock = clock
        self.catalog = model.catalog

    # ---- 状态与机器人 -----------------------------------------------------------

    def _state(self, state: dict) -> dict:
        cfg = self.config
        arena = state.setdefault('Arena', {
            'rank': cfg['initial_rank'], 'score': 0, 'used': 0, 'recover_at': 0, 'score_at': self.clock.now(),
            'streak': 0, 'exchanges': {}, 'exchange_day': '', 'limit_claims': [], 'records': [], 'next_record': 1,
            'seed': random.randint(1, 10 ** 9)})
        today = self.clock.day_key()
        if arena.get('day') != today:
            arena.update(day=today, used=0, exchanges={})
        self._accrue(state, arena)
        return arena

    def _score_rate(self, rank: int) -> int:
        for low, high, score in self.config['score_by_rank']:
            if low <= rank <= high:
                return score
        return 0

    def _accrue(self, state: dict, arena: dict):
        """按时间累积积分与恢复挑战次数。"""
        now = self.clock.now()
        interval = self.config['score_interval_seconds']
        ticks = (now - arena.get('score_at', now)) // interval
        if ticks > 0:
            arena['score'] += ticks * self._score_rate(arena['rank'])
            arena['score_at'] += ticks * interval
        recover = self.config['recover_seconds']
        while arena['used'] > 0 and arena.get('recover_at', 0) and now >= arena['recover_at']:
            arena['used'] -= 1
            arena['recover_at'] = arena['recover_at'] + recover if arena['used'] > 0 else 0

    def _robot(self, arena: dict, rank: int, player_level: int) -> dict:
        """按排名确定性生成机器人：排名越靠前等级越高。"""
        rng = random.Random(arena['seed'] * 1000 + rank)
        names = self.config['robot_names']
        level = max(1, player_level + (self.config['initial_rank'] // 2 - rank) // 20)
        heroes = sorted(int(k) for k in self.catalog['BaseHeros'])
        team = rng.sample(heroes, min(3 + level // 15, 6))
        power = sum(self.model.heroes.battle_power(self.engine.template_unit(h, level, i + 1).attrs) for i, h in enumerate(team))
        return dict(PlayerId=str(100000 + rank), PlayerName=f'{names[rank % len(names)]}{rank}', Avatar=team[0],
                    Ranking=rank, Level=level, Fighting=int(power), ScorePerTime=self._score_rate(rank), team=team)

    def _targets(self, state: dict, arena: dict) -> list:
        """自己 + 前后若干名对手。"""
        rank = arena['rank']
        offsets = (-1, -2, -3, -5, -8, -12, 1, 2)
        ranks = sorted({max(1, min(self.config['robot_count'], rank + o)) for o in offsets} - {rank})
        targets = [self._robot(arena, r, state['PLevel']) for r in ranks]
        me = dict(PlayerId=str(state['ID']), PlayerName=state['Name'], Avatar=self.model.team_heroes(state)[0]['heroId'],
                  Ranking=rank, Level=state['PLevel'], Fighting=self.model.team(state)['battlePower'],
                  ScorePerTime=self._score_rate(rank))
        return sorted(targets + [me], key=lambda t: t['Ranking'])

    def _info(self, state: dict, arena: dict) -> dict:
        cfg = self.config
        now = self.clock.now()
        targets = self._targets(state, arena)
        champion = next((t for t in targets if t['Ranking'] == 1), None) or self._robot(arena, 1, state['PLevel'])
        return {
            'Ranking': arena['rank'], 'Residue': cfg['daily_times'] - arena['used'], 'MaxTime': cfg['daily_times'],
            'NextRecoverTime': Clock.remaining(arena.get('recover_at', 0), now) if arena['used'] else 0,
            'RecoverPerTime': cfg['recover_seconds'], 'Score': arena['score'],
            'ScorePerTime': self._score_rate(arena['rank']), 'SecondPerTime': cfg['score_interval_seconds'],
            'NextTime': max(0, arena['score_at'] + cfg['score_interval_seconds'] - now),
            'ContinuousTime': arena['streak'], 'Cooling': 0, 'Cost': cfg['clear_cooldown_ingot'],
            'ContinueWinEvent': [], 'Champion': {k: v for k, v in champion.items() if k != 'team'},
            'Targets': [{k: v for k, v in t.items() if k != 'team'} for t in targets],
        }

    # ---- 接口 -------------------------------------------------------------

    def info(self, ctx: RoleContext, params) -> dict:
        """``/Duel/info``。"""
        return self._info(ctx.state, self._state(ctx.state))

    def challenge(self, ctx: RoleContext, params) -> Reply:
        """``/Duel/Challenge?rank``：挑战指定排名的对手，胜利则互换排名。"""
        state = ctx.state
        arena = self._state(state)
        rank = params['rank']
        if rank >= arena['rank'] or rank < 1:
            raise BusinessError('只能挑战排名比自己靠前的对手')
        if arena['used'] >= self.config['daily_times']:
            raise BusinessError('今日挑战次数已用完')
        robot = self._robot(arena, rank, state['PLevel'])
        allies = [self.engine.hero_unit(h) for h in self.model.team_heroes(state)]
        enemies = [self.engine.template_unit(h, robot['Level'], pos) for h, pos in zip(robot['team'], ENEMY_POSITIONS)]
        report = self.engine.simulate(allies, enemies)
        arena['used'] += 1
        if not arena.get('recover_at'):
            arena['recover_at'] = self.clock.now() + self.config['recover_seconds']
        if report['isWin']:
            arena['rank'], arena['streak'] = rank, arena['streak'] + 1
            rewards = thaw(self.config['win_reward'])
        else:
            arena['streak'] = 0
            rewards = thaw(self.config['lose_reward'])
        score = sum(r['Count'] for r in rewards if r['Type'] == PK_SCORE_TYPE)
        arena['score'] += score
        outcome = self.ledger.apply(state, rewards=[dict(r) for r in rewards if r['Type'] != PK_SCORE_TYPE])
        outcome.rewards.extend(r for r in rewards if r['Type'] == PK_SCORE_TYPE)
        report.update(total=1, dropList=[], Reward=deepcopy(outcome.rewards), BattleResult={},
                      enemy={'Name': robot['PlayerName'], 'Vip': 0})
        self.model.refresh_all(state)
        return Reply(report, self.ledger.global_for(state, outcome, Slots=self.model.slots(state)))

    def top_ten(self, ctx: RoleContext, params) -> list:
        """``/Duel/TopTen``。"""
        arena = self._state(ctx.state)
        rows = []
        for rank in range(1, 11):
            if rank == arena['rank']:
                rows.append(dict(PlayerId=str(ctx.state['ID']), Ranking=rank, PlayerName=ctx.state['Name'],
                                 Level=ctx.state['PLevel'], Fighting=self.model.team(ctx.state)['battlePower']))
            else:
                robot = self._robot(arena, rank, ctx.state['PLevel'])
                rows.append({k: robot[k] for k in ('PlayerId', 'Ranking', 'PlayerName', 'Level', 'Fighting')})
        return rows

    def exchanges(self, ctx: RoleContext, params) -> list:
        """``/Duel/Exchanges``：积分商店。"""
        arena = self._state(ctx.state)
        rows = []
        for item in self.config['exchanges']:
            left = item['daily_limit'] - arena['exchanges'].get(str(item['id']), 0)
            if left > 0:
                rows.append(dict(id=item['id'], Score=item['Score'], Reward=thaw(item['Reward']),
                                 LimitChallengeTimes=0, TotalChallengeTimes=0, MaxLimitChallengeTimes=0,
                                 LimitContinueWinTimes=0, HighestContinueWinTimes=0, MaxLimitContinueWinTimes=0, LimitRank=0))
        return rows

    def limit_rank_exchanges(self, ctx: RoleContext, params) -> list:
        """``/Duel/LimitRankExchanges``：排名达标奖励。"""
        arena = self._state(ctx.state)
        return [dict(id=i['id'], LimitRank=i['LimitRank'], Reward=thaw(i['Reward']))
                for i in self.config['limit_rank_exchanges'] if i['id'] not in arena['limit_claims']]

    def exchange(self, ctx: RoleContext, params) -> Reply:
        """``/Duel/Exchange?id``：兑换积分商品或领取排名奖励。"""
        state = ctx.state
        arena = self._state(state)
        item_id = params['id']
        item = next((i for i in self.config['exchanges'] if i['id'] == item_id), None)
        if item is not None:
            done = arena['exchanges'].get(str(item_id), 0)
            if done >= item['daily_limit']:
                raise BusinessError('今日兑换次数已用完')
            if arena['score'] < item['Score']:
                raise BusinessError('积分不足')
            arena['score'] -= item['Score']
            arena['exchanges'][str(item_id)] = done + 1
            outcome = self.ledger.apply(state, rewards=thaw(item['Reward']))
            consume = [dict(Type=PK_SCORE_TYPE, ID=0, Count=item['Score'])]
            return Reply({'Consume': consume, 'Limit': item['daily_limit'] - done - 1, 'Reward': deepcopy(outcome.rewards)},
                         self.ledger.global_for(state, outcome))
        limit = next((i for i in self.config['limit_rank_exchanges'] if i['id'] == item_id), None)
        if limit is None:
            raise BusinessError('商品不存在')
        if item_id in arena['limit_claims']:
            raise BusinessError('奖励已领取')
        if arena['rank'] > limit['LimitRank']:
            raise BusinessError(f'排名需达到 {limit["LimitRank"]} 名')
        arena['limit_claims'].append(item_id)
        outcome = self.ledger.apply(state, rewards=thaw(limit['Reward']))
        return Reply({'Consume': [dict(Type=PK_SCORE_TYPE, ID=0, Count=0)], 'Limit': 0, 'Reward': deepcopy(outcome.rewards)},
                     self.ledger.global_for(state, outcome))

    def clear_cooldown(self, ctx: RoleContext, params) -> Reply:
        """``/Duel/back``：本地服无挑战冷却，直接返回。"""
        return Reply({})

    def scores(self, ctx: RoleContext, params) -> list:
        """``/duel/scores``：可领取的积分记录。"""
        return deepcopy(self._state(ctx.state)['records'])

    def get_score(self, ctx: RoleContext, params) -> Reply:
        """``/duel/getscore?id``。"""
        arena = self._state(ctx.state)
        record = next((r for r in arena['records'] if r['Id'] == params['id']), None)
        if record is None:
            raise BusinessError('积分记录不存在')
        arena['records'].remove(record)
        arena['score'] += record['Score']
        return Reply({'Score': arena['score']})

    def notify(self, state: dict) -> dict:
        arena = self._state(state)
        return {'Duel': {'Last': self.config['daily_times'] - arena['used'], 'Total': self.config['daily_times']}}


class WorldBossService:
    def __init__(self, config, model: PlayerModel, ledger: Ledger, engine: BattleEngine, clock: Clock):
        self.config = config
        self.model = model
        self.ledger = ledger
        self.engine = engine
        self.clock = clock

    # ---- 活动时段 -----------------------------------------------------------

    def _session(self):
        """返回 ``(是否进行中, 剩余秒数, 本场开始时间)``。"""
        now = self.clock.now()
        day = self.clock.day_key(now)
        import datetime as dt
        base = dt.datetime.strptime(day, '%Y-%m-%d') + dt.timedelta(hours=self.model.config.daily_reset_hour)
        upcoming = None
        for s in self.config['sessions']:
            start = int((base + dt.timedelta(hours=s['start_hour'], minutes=s['start_minute'])).timestamp())
            end = start + s['duration_minutes'] * 60
            if start <= now < end:
                return True, end - now, start
            if now < start and (upcoming is None or start < upcoming):
                upcoming = start
        if upcoming is None:
            first = self.config['sessions'][0]
            upcoming = int((base + dt.timedelta(days=1, hours=first['start_hour'], minutes=first['start_minute'])).timestamp())
        return False, upcoming - now, upcoming

    def _state(self, state: dict, start: int) -> dict:
        boss = state.setdefault('WorldBoss', {})
        if boss.get('session') != start:
            hp = self.config['boss_hp_per_player_level'] * max(1, state['PLevel'])
            boss.clear()
            boss.update(session=start, hurt=0, gold=0, addition=0.0, dead_until=0, auto=0, order=0, events=[], tick=0,
                        bosses={str(b['id']): {'hp': hp, 'max': hp} for b in self.config['bosses']})
        return boss

    def _require_open(self, state: dict) -> dict:
        active, remaining, start = self._session()
        if not active:
            raise BusinessError('活动尚未开始或已结束', STATE_WORLDBOSS_CLOSED)
        return self._state(state, start)

    # ---- 接口 -------------------------------------------------------------

    def activity_info(self, ctx: RoleContext, params) -> dict:
        """``/Worldboss/ActivityInfo``。"""
        active, remaining, start = self._session()
        boss = ctx.state.get('WorldBoss') or {}
        return {'isInActivity': 1 if active else 0, 'remainTime': remaining, 'isOrder': boss.get('order', 0),
                'orderVipLv': self.config['order_vip'], 'orderCost': self.config['order_ingot'],
                'isCanGetReward': 1 if ctx.state.get('WorldBossRewards') else 0,
                'lastRank': 1 if boss.get('hurt') else 0,
                'challengeRanks': [{'rank': 1, 'avatarID': self.model.team_heroes(ctx.state)[0]['heroId'],
                                    'level': ctx.state['PLevel'], 'name': ctx.state['Name']}] if boss.get('hurt') else []}

    def boss_info(self, ctx: RoleContext, params) -> dict:
        """``/Worldboss/WorldbossInfo?timeTick``。"""
        state = ctx.state
        boss = self._require_open(state)
        active, remaining, _ = self._session()
        infos = []
        for b in self.config['bosses']:
            hp = boss['bosses'][str(b['id'])]
            infos.append(dict(id=b['id'], name=b['name'], level=state['PLevel'] + 10, leftHp=hp['hp'], maxHp=hp['max'],
                              leftHpPrecent=int(hp['hp'] * 100 / hp['max']) if hp['max'] else 0,
                              state=3 if hp['hp'] <= 0 else 1, chestLeftHp=100, chestMaxHp=100, chestState=1))
        return {'remainTime': remaining, 'isAutofight': boss['auto'], 'resurgenceCost': self.config['resurgence_ingot'],
                'encouragingCost': self.config['encouraging_ingot'], 'bossInfos': infos,
                'challengeRanks': [{'rank': 1, 'name': state['Name']}] if boss['hurt'] else [],
                'playerChallengeInfo': {'battlePower': self.model.team(state)['battlePower'], 'haveHurt': boss['hurt'],
                                        'hurtRank': 1 if boss['hurt'] else 0, 'killTotalGold': boss['gold'],
                                        'powerAddition': boss['addition'],
                                        'resurgenceTime': Clock.remaining(boss['dead_until'], self.clock.now())},
                'attackEvents': [e for e in boss['events'] if e['timeTick'] > params.get('timeTick', 0)][-20:]}

    def challenge(self, ctx: RoleContext, params) -> Reply:
        """``/Worldboss/Challenge?type&bossID``。"""
        state = ctx.state
        boss = self._require_open(state)
        target = next((b for b in self.config['bosses'] if b['id'] == params['bossID']), None)
        if target is None:
            raise BusinessError('妖王不存在')
        pool = boss['bosses'][str(target['id'])]
        if pool['hp'] <= 0:
            raise BusinessError('该妖王已被击杀')
        if Clock.remaining(boss['dead_until'], self.clock.now()) > 0:
            raise BusinessError('复活冷却中')
        allies = [self.engine.hero_unit(h) for h in self.model.team_heroes(state)]
        for unit in allies:
            for attr in ('normalAttack', 'skillAttack'):
                unit.attrs[attr] *= 1 + boss['addition']
        enemy = self.engine.npc_unit(target['npc_id'], state['PLevel'] + 5, 8, self.config['boss_attr_multiplier'], hp_override=pool['hp'])
        report = self.engine.simulate(allies, [enemy])
        damage = pool['hp'] - max(0, enemy.hp)
        pool['hp'] = max(0, enemy.hp)
        gold = int(damage * self.config['gold_per_damage'])
        boss['hurt'] += damage
        boss['gold'] += gold
        boss['tick'] += 1
        boss['events'].append({'timeTick': boss['tick'], 'bossID': target['id'], 'playerName': state['Name'], 'hurt': damage})
        boss['events'] = boss['events'][-50:]
        if not report['isWin']:
            boss['dead_until'] = self.clock.now() + self.config['resurgence_seconds']
        outcome = self.ledger.apply(state, rewards=[dict(Type=1, ID=0, Count=gold)] if gold else [])
        state.setdefault('WorldBossRewards', [])
        report.update(total=1, dropList=[], Reward=deepcopy(outcome.rewards), BattleResult={},
                      WorldbossChallenge={'challengeGold': gold, 'hp': damage})
        return Reply(report, self.ledger.global_for(state, outcome))

    def order(self, ctx: RoleContext, params) -> Reply:
        """``/Worldboss/Order``：预约。"""
        active, remaining, start = self._session()
        boss = self._state(ctx.state, start)
        if boss.get('order'):
            raise BusinessError('已预约')
        outcome = self.ledger.apply(ctx.state, consume=[dict(Type=2, ID=0, Count=self.config['order_ingot'])])
        boss['order'] = 1
        return Reply({}, self.ledger.global_for(ctx.state, outcome))

    def encourage(self, ctx: RoleContext, params) -> Reply:
        """``/Worldboss/Encouraging``：花元宝鼓舞，返回新加成。"""
        boss = self._require_open(ctx.state)
        if boss['addition'] >= self.config['encouraging_max']:
            raise BusinessError('鼓舞已达上限')
        outcome = self.ledger.apply(ctx.state, consume=[dict(Type=2, ID=0, Count=self.config['encouraging_ingot'])])
        boss['addition'] = round(min(self.config['encouraging_max'], boss['addition'] + self.config['encouraging_step']), 2)
        return Reply(boss['addition'], self.ledger.global_for(ctx.state, outcome))

    def autofight(self, ctx: RoleContext, params) -> dict:
        """``/Worldboss/AutofightControl?isAutofight``（本地服不代打，仅记录开关）。"""
        boss = self._require_open(ctx.state)
        boss['auto'] = 1 if params['isAutofight'] else 0
        return {}

    def resurgence(self, ctx: RoleContext, params) -> Reply:
        """``/Worldboss/Resurgence``：花元宝立即复活。"""
        boss = self._require_open(ctx.state)
        if Clock.remaining(boss['dead_until'], self.clock.now()) <= 0:
            raise BusinessError('当前无需复活')
        outcome = self.ledger.apply(ctx.state, consume=[dict(Type=2, ID=0, Count=self.config['resurgence_ingot'])])
        boss['dead_until'] = 0
        return Reply(self.boss_info(ctx, {'timeTick': 0}), self.ledger.global_for(ctx.state, outcome))

    def reward_list(self, ctx: RoleContext, params) -> list:
        """``/Worldboss/RewardList``：可领取的场次奖励。"""
        self._settle_finished(ctx.state)
        return deepcopy(ctx.state.get('WorldBossRewards', []))

    def _settle_finished(self, state: dict):
        """活动结束后把本场伤害结算成待领奖励。"""
        boss = state.get('WorldBoss')
        active, _, start = self._session()
        if boss and boss.get('hurt') and not boss.get('settled') and (not active or boss.get('session') != start):
            import datetime as dt
            when = dt.datetime.fromtimestamp(boss['session']).strftime('%Y-%m-%d %H:%M')
            state.setdefault('WorldBossRewards', []).append(
                {'activityTime': when, 'rank': 1, 'rankReward': thaw(self.config['rank_reward']),
                 'chestReward': thaw(self.config['chest_reward'])})
            boss['settled'] = True

    def reward(self, ctx: RoleContext, params) -> Reply:
        """``/Worldboss/Reward?time``。"""
        import base64
        self._settle_finished(ctx.state)
        raw = params.get('time') or ''
        try:
            when = base64.b64decode(raw + '=' * (-len(raw) % 4)).decode('utf-8')
        except Exception:
            when = raw
        rewards = ctx.state.get('WorldBossRewards', [])
        entry = next((r for r in rewards if r['activityTime'] in (when, raw)), None)
        if entry is None:
            raise BusinessError('没有可领取的奖励')
        rewards.remove(entry)
        outcome = self.ledger.apply(ctx.state, rewards=entry['rankReward'] + entry['chestReward'])
        return Reply({}, self.ledger.global_for(ctx.state, outcome))

    def challenge_rank(self, ctx: RoleContext, params) -> list:
        """``/Worldboss/ChallengeRank``：末元素为自己。"""
        boss = ctx.state.get('WorldBoss') or {}
        me = {'rank': 1 if boss.get('hurt') else 0, 'playerID': str(ctx.state['ID']), 'level': ctx.state['PLevel'],
              'name': ctx.state['Name'], 'unionName': '', 'hp': boss.get('hurt', 0), 'gold': boss.get('gold', 0)}
        return ([dict(me)] if boss.get('hurt') else []) + [me]

    def notify(self, state: dict) -> dict:
        active, _, _ = self._session()
        return {'IsWorldbossInActivity': 1 if active else 0}
