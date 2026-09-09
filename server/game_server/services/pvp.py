"""争霸（/Duel/*）与妖王洞穴（/Worldboss/*）。

争霸：排名表 ``arena_ranks`` 记录真实玩家占据的名次，其余名次由机器人填充（机器人 ID = ROBOT_BASE + 名次，
阵容按英雄模板随名次生成）。新玩家首次进入时排在所有已占名次之后；挑战更靠前的名次，胜利即互换名次
（对手是真实玩家时同样互换）。积分按名次区间随时间累积，可在积分商店兑换。

妖王洞穴：每日固定时段开放；同一场活动的四妖王血量、全部玩家的伤害与银币记录在区服共享存储中，
伤害榜、顶栏事件都来自共享数据；复活冷却、鼓舞、预约、自动开关为玩家个人状态。
"""
from copy import deepcopy
import base64
import datetime as dt
import random

from ..config import thaw
from ..errors import BusinessError
from .base import Reply, RoleContext, global_block
from .battle import BattleEngine, ENEMY_POSITIONS
from .clock import Clock
from .hero_model import new_hero_record
from .inventory import Ledger
from .player_state import PlayerModel
from .players import PlayerDirectory, RealmStore, ROBOT_BASE

PK_SCORE_TYPE = 19
STATE_WORLDBOSS_CLOSED = -1151010


class ArenaService:
    def __init__(self, config, model: PlayerModel, ledger: Ledger, engine: BattleEngine, clock: Clock,
                 directory: PlayerDirectory, realm_id: int):
        self.config = config
        self.model = model
        self.ledger = ledger
        self.engine = engine
        self.clock = clock
        self.directory = directory
        self.realm_id = realm_id
        self.catalog = model.catalog
        directory.set_robot_provider(self.robot_profile)

    # ---- 排名表 -----------------------------------------------------------

    def rank_of(self, db, user_id: int) -> int:
        row = db.execute('SELECT rank FROM arena_ranks WHERE server_id = ? AND user_id = ?', (self.realm_id, user_id)).fetchone()
        if row:
            return row['rank']
        top = db.execute('SELECT MAX(rank) AS m FROM arena_ranks WHERE server_id = ?', (self.realm_id,)).fetchone()['m'] or 0
        rank = max(top, self.config['initial_rank']) + 1
        db.execute('INSERT INTO arena_ranks(server_id, rank, user_id) VALUES (?, ?, ?)', (self.realm_id, rank, user_id))
        return rank

    def occupant(self, db, rank: int):
        """该名次的真实玩家 ID；没有则为 None（由机器人填充）。"""
        row = db.execute('SELECT user_id FROM arena_ranks WHERE server_id = ? AND rank = ?', (self.realm_id, rank)).fetchone()
        return row['user_id'] if row else None

    def _swap(self, db, user_id: int, old_rank: int, new_rank: int):
        other = self.occupant(db, new_rank)
        db.execute('DELETE FROM arena_ranks WHERE server_id = ? AND rank IN (?, ?)', (self.realm_id, old_rank, new_rank))
        db.execute('INSERT INTO arena_ranks(server_id, rank, user_id) VALUES (?, ?, ?)', (self.realm_id, new_rank, user_id))
        if other is not None:
            db.execute('INSERT INTO arena_ranks(server_id, rank, user_id) VALUES (?, ?, ?)', (self.realm_id, old_rank, other))

    # ---- 玩家个人状态 -----------------------------------------------------------

    def _state(self, state: dict) -> dict:
        arena = state.setdefault('Arena', {'score': 0, 'used': 0, 'recover_at': 0, 'score_at': self.clock.now(),
                                           'streak': 0, 'exchanges': {}, 'limit_claims': [], 'records': []})
        if arena.get('day') != self.clock.day_key():
            arena.update(day=self.clock.day_key(), used=0, exchanges={})
        return arena

    def _score_rate(self, rank: int) -> int:
        for low, high, score in self.config['score_by_rank']:
            if low <= rank <= high:
                return score
        return 0

    def _accrue(self, arena: dict, rank: int):
        now = self.clock.now()
        interval = self.config['score_interval_seconds']
        ticks = (now - arena.get('score_at', now)) // interval
        if ticks > 0:
            arena['score'] += ticks * self._score_rate(rank)
            arena['score_at'] += ticks * interval
        recover = self.config['recover_seconds']
        while arena['used'] > 0 and arena.get('recover_at', 0) and now >= arena['recover_at']:
            arena['used'] -= 1
            arena['recover_at'] = arena['recover_at'] + recover if arena['used'] > 0 else 0

    # ---- 机器人 -------------------------------------------------------------

    def robot_profile(self, robot_id: int):
        rank = robot_id - ROBOT_BASE
        if rank < 1:
            return None
        rng = random.Random(self.realm_id * 7919 + rank)
        names = self.config['robot_names']
        level = max(1, 1 + (self.config['robot_count'] - rank) * 60 // self.config['robot_count'])
        hero_ids = sorted(int(k) for k in self.catalog['BaseHeros'])
        size = min(6, 2 + level // 12)
        heroes = []
        for pos, hero_id in enumerate(rng.sample(hero_ids, size), 1):
            hero = new_hero_record(hero_id, pos)
            hero.update(level=level, rebirthCount=level // 15, rageSkillLevel=max(1, level // 5))
            equips = self._robot_equipment(rng, robot_id, hero_id, pos, level)
            self.model.heroes.refresh(hero, self.model.equipment.bonus_of(equips), equips)
            heroes.append(hero)
        team = {'battlePower': sum(h['battlePower'] for h in heroes), 'groupList': heroes}
        rebirth = int(heroes[0].get('rebirthCount') or 0)
        weapon_id, pinjie = self.model.weapon_of(heroes[0])
        return {'PlayerId': robot_id, 'Name': f'{names[rank % len(names)]}·{rank}', 'Level': level, 'Vip': 0,
                'Avatar': heroes[0]['heroId'], 'RebirthCount': rebirth, 'BreakthroughCount': rebirth,
                'WeaponId': weapon_id, 'PinJie': pinjie,
                'BattlePower': team['battlePower'], 'team': team,
                'partnerTeam': [], 'attributeAddition': {}, 'robot': True}

    def _robot_equipment(self, rng, robot_id: int, hero_id: int, pos: int, level: int) -> list:
        """机器人英雄的整套法宝：部位数与品质随等级提高，武器匹配职业，锻造等级约为英雄等级的两倍。"""
        profession = self.catalog['BaseHeros'][str(hero_id)]['profession']
        quality = 1 + min(3, level // 15)
        parts = min(6, 1 + level // 8)
        equipment = self.model.equipment
        instances = []
        for equip_type in range(1, parts + 1):
            equip_id = equipment.random_template_id(rng, quality, equip_type, profession)
            instances.append(equipment.build(equip_id, max(1, level * 2), robot_id * 100 + pos * 10 + equip_type, hero_id,
                                             pinjie=1 + min(4, level // 20)))
        return instances

    def _profile_at(self, db, rank: int) -> dict:
        user = self.occupant(db, rank)
        profile = self.directory.profile(db, user if user is not None else ROBOT_BASE + rank)
        rebirth = int(profile.get('RebirthCount') or 0)
        return dict(PlayerId=str(profile['PlayerId']), PlayerName=profile['Name'], Avatar=profile['Avatar'], Ranking=rank,
                    Level=profile['Level'], Fighting=profile['BattlePower'], ScorePerTime=self._score_rate(rank),
                    BreakthroughCount=rebirth, rebirthCount=rebirth)

    # ---- 接口 -------------------------------------------------------------

    def _info(self, ctx: RoleContext) -> dict:
        state, cfg, now = ctx.state, self.config, self.clock.now()
        rank = self.rank_of(ctx.db, ctx.user)
        arena = self._state(state)
        self._accrue(arena, rank)
        ranks = sorted({max(1, rank + o) for o in (-1, -2, -3, -5, -8, -12, 1, 2)} - {rank})
        targets = sorted([self._profile_at(ctx.db, r) for r in ranks] + [self._profile_at(ctx.db, rank)], key=lambda t: t['Ranking'])
        champion = next((t for t in targets if t['Ranking'] == 1), None) or self._profile_at(ctx.db, 1)
        return {
            'Ranking': rank, 'Residue': cfg['daily_times'] - arena['used'], 'MaxTime': cfg['daily_times'],
            'NextRecoverTime': Clock.remaining(arena.get('recover_at', 0), now) if arena['used'] else 0,
            'RecoverPerTime': cfg['recover_seconds'], 'Score': arena['score'], 'ScorePerTime': self._score_rate(rank),
            'SecondPerTime': cfg['score_interval_seconds'],
            'NextTime': max(0, arena['score_at'] + cfg['score_interval_seconds'] - now),
            'ContinuousTime': arena['streak'], 'Cooling': 0, 'Cost': cfg['clear_cooldown_ingot'],
            'ContinueWinEvent': [], 'Champion': champion, 'Targets': targets,
        }

    def info(self, ctx: RoleContext, params) -> dict:
        """``/Duel/info``。"""
        return self._info(ctx)

    def challenge(self, ctx: RoleContext, params) -> Reply:
        """``/Duel/Challenge?rank``：挑战指定名次，胜利即互换名次。"""
        state, db = ctx.state, ctx.db
        my_rank = self.rank_of(db, ctx.user)
        arena = self._state(state)
        self._accrue(arena, my_rank)
        rank = params['rank']
        if rank >= my_rank or rank < 1:
            raise BusinessError('只能挑战排名比自己靠前的对手')
        if arena['used'] >= self.config['daily_times']:
            raise BusinessError('今日挑战次数已用完')
        target = self._profile_at(db, rank)
        enemies = [self.engine.hero_unit(dict(h, battleIx=pos)) for h, pos in
                   zip(self.directory.battle_team(db, int(target['PlayerId'])), ENEMY_POSITIONS)]
        for unit in enemies:
            unit.side = 1
        allies = [self.engine.hero_unit(h) for h in self.model.team_heroes(state)]
        report = self.engine.simulate(allies, enemies)
        arena['used'] += 1
        if not arena.get('recover_at'):
            arena['recover_at'] = self.clock.now() + self.config['recover_seconds']
        if report['isWin']:
            self._swap(db, ctx.user, my_rank, rank)
            arena['streak'] += 1
            rewards = thaw(self.config['win_reward'])
        else:
            arena['streak'] = 0
            rewards = thaw(self.config['lose_reward'])
        arena['score'] += sum(r['Count'] for r in rewards if r['Type'] == PK_SCORE_TYPE)
        outcome = self.ledger.apply(state, rewards=[r for r in rewards if r['Type'] != PK_SCORE_TYPE])
        outcome.rewards.extend(r for r in rewards if r['Type'] == PK_SCORE_TYPE)
        report.update(total=1, dropList=[], Reward=deepcopy(outcome.rewards), BattleResult={},
                      enemy={'Name': target['PlayerName'], 'Vip': 0})
        return Reply(report, self.ledger.global_for(state, outcome, Slots=self.model.slots(state)))

    def top_ten(self, ctx: RoleContext, params) -> list:
        """``/Duel/TopTen``。"""
        return [{k: v for k, v in self._profile_at(ctx.db, r).items() if k != 'ScorePerTime'} for r in range(1, 11)]

    def exchanges(self, ctx: RoleContext, params) -> list:
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
        arena = self._state(ctx.state)
        return [dict(id=i['id'], LimitRank=i['LimitRank'], Reward=thaw(i['Reward']))
                for i in self.config['limit_rank_exchanges'] if i['id'] not in arena['limit_claims']]

    def exchange(self, ctx: RoleContext, params) -> Reply:
        """``/Duel/Exchange?id``：积分兑换或排名奖励领取。"""
        state = ctx.state
        arena = self._state(state)
        self._accrue(arena, self.rank_of(ctx.db, ctx.user))
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
            return Reply({'Consume': [dict(Type=PK_SCORE_TYPE, ID=0, Count=item['Score'])], 'Limit': item['daily_limit'] - done - 1,
                          'Reward': deepcopy(outcome.rewards)}, self.ledger.global_for(state, outcome))
        limit = next((i for i in self.config['limit_rank_exchanges'] if i['id'] == item_id), None)
        if limit is None:
            raise BusinessError('商品不存在')
        if item_id in arena['limit_claims']:
            raise BusinessError('奖励已领取')
        if self.rank_of(ctx.db, ctx.user) > limit['LimitRank']:
            raise BusinessError(f'排名需达到 {limit["LimitRank"]} 名')
        arena['limit_claims'].append(item_id)
        outcome = self.ledger.apply(state, rewards=thaw(limit['Reward']))
        return Reply({'Consume': [dict(Type=PK_SCORE_TYPE, ID=0, Count=0)], 'Limit': 0, 'Reward': deepcopy(outcome.rewards)},
                     self.ledger.global_for(state, outcome))

    def clear_cooldown(self, ctx: RoleContext, params) -> Reply:
        """``/Duel/back``：当前没有挑战冷却机制，直接返回。"""
        return Reply({})

    def scores(self, ctx: RoleContext, params) -> list:
        return deepcopy(self._state(ctx.state)['records'])

    def get_score(self, ctx: RoleContext, params) -> Reply:
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
    def __init__(self, config, model: PlayerModel, ledger: Ledger, engine: BattleEngine, clock: Clock, store: RealmStore):
        self.config = config
        self.model = model
        self.ledger = ledger
        self.engine = engine
        self.clock = clock
        self.store = store

    # ---- 活动时段 -----------------------------------------------------------

    def _session(self):
        """返回 ``(是否进行中, 剩余秒数, 本场/下一场开始时间)``。"""
        now = self.clock.now()
        base = dt.datetime.strptime(self.clock.day_key(now), '%Y-%m-%d') + dt.timedelta(hours=self.model.config.daily_reset_hour)
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

    def _shared(self, db, start: int) -> dict:
        """本场活动的共享数据：四妖王血量、各玩家伤害、攻击事件。"""
        key = f'worldboss:{start}'
        data = self.store.get(db, key)
        if data is None:
            hp = self.config['boss_hp_per_player_level'] * 30
            data = {'bosses': {str(b['id']): {'hp': hp, 'max': hp} for b in self.config['bosses']}, 'players': {}, 'events': [], 'tick': 0}
            self.store.set(db, key, data)
        return data

    def _save_shared(self, db, start: int, data: dict):
        self.store.set(db, f'worldboss:{start}', data)

    def _personal(self, state: dict, start: int) -> dict:
        boss = state.setdefault('WorldBoss', {})
        if boss.get('session') != start:
            boss.clear()
            boss.update(session=start, addition=0.0, dead_until=0, auto=0, order=0)
        return boss

    def _require_open(self):
        active, remaining, start = self._session()
        if not active:
            raise BusinessError('活动尚未开始或已结束', STATE_WORLDBOSS_CLOSED)
        return remaining, start

    @staticmethod
    def _ranking(data: dict) -> list:
        return sorted(data['players'].items(), key=lambda kv: -kv[1]['hurt'])

    def _my_rank(self, data: dict, user_id: int) -> int:
        for index, (uid, _) in enumerate(self._ranking(data), 1):
            if uid == str(user_id):
                return index
        return 0

    # ---- 接口 -------------------------------------------------------------

    def activity_info(self, ctx: RoleContext, params) -> dict:
        active, remaining, start = self._session()
        boss = ctx.state.get('WorldBoss') or {}
        last = self.store.get(ctx.db, 'worldboss:last') or {}
        data = self.store.get(ctx.db, f'worldboss:{last.get("start")}') if last.get('start') else None
        ranks = []
        if data:
            for index, (uid, entry) in enumerate(self._ranking(data)[:4], 1):
                ranks.append({'rank': index, 'avatarID': entry.get('avatar', 0), 'level': entry.get('level', 1), 'name': entry.get('name', ''),
                              'rebirthCount': int(entry.get('rebirthCount') or 0),
                              'weaponId': int(entry.get('weaponId') or 0),
                              'pinJie': int(entry.get('pinJie') or 5)})
        return {'isInActivity': 1 if active else 0, 'remainTime': remaining,
                'isOrder': boss.get('order', 0) if boss.get('session') == start else 0,
                'orderVipLv': self.config['order_vip'], 'orderCost': self.config['order_ingot'],
                'isCanGetReward': 1 if ctx.state.get('WorldBossRewards') else 0,
                'lastRank': self._my_rank(data, ctx.user) if data else 0, 'challengeRanks': ranks}

    def boss_info(self, ctx: RoleContext, params) -> dict:
        remaining, start = self._require_open()
        state = ctx.state
        data = self._shared(ctx.db, start)
        boss = self._personal(state, start)
        me = data['players'].get(str(ctx.user), {'hurt': 0, 'gold': 0})
        infos = []
        for b in self.config['bosses']:
            hp = data['bosses'][str(b['id'])]
            infos.append(dict(id=b['id'], name=b['name'], level=state['PLevel'] + 5, leftHp=hp['hp'], maxHp=hp['max'],
                              leftHpPrecent=int(hp['hp'] * 100 / hp['max']) if hp['max'] else 0,
                              state=3 if hp['hp'] <= 0 else 1, chestLeftHp=100, chestMaxHp=100, chestState=1))
        return {'remainTime': remaining, 'isAutofight': boss['auto'], 'resurgenceCost': self.config['resurgence_ingot'],
                'encouragingCost': self.config['encouraging_ingot'], 'bossInfos': infos,
                'challengeRanks': [{'rank': i, 'name': e['name']} for i, (_, e) in enumerate(self._ranking(data)[:4], 1)],
                'playerChallengeInfo': {'battlePower': self.model.team(state)['battlePower'], 'haveHurt': me['hurt'],
                                        'hurtRank': self._my_rank(data, ctx.user), 'killTotalGold': me['gold'],
                                        'powerAddition': boss['addition'],
                                        'resurgenceTime': Clock.remaining(boss['dead_until'], self.clock.now())},
                'attackEvents': [e for e in data['events'] if e['timeTick'] > params.get('timeTick', 0)][-20:]}

    def challenge(self, ctx: RoleContext, params) -> Reply:
        remaining, start = self._require_open()
        state, db = ctx.state, ctx.db
        data = self._shared(db, start)
        boss = self._personal(state, start)
        target = next((b for b in self.config['bosses'] if b['id'] == params['bossID']), None)
        if target is None:
            raise BusinessError('妖王不存在')
        pool = data['bosses'][str(target['id'])]
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
        lead = self.model.avatar_hero(state)
        weapon_id, pinjie = self.model.weapon_of(lead)
        me = data['players'].setdefault(str(ctx.user), {'hurt': 0, 'gold': 0})
        me.update(name=state['Name'], level=state['PLevel'], avatar=lead['heroId'] if lead else 0,
                  rebirthCount=int(lead.get('rebirthCount') or 0) if lead else 0, weaponId=weapon_id, pinJie=pinjie)
        me['hurt'] += damage
        me['gold'] += gold
        data['tick'] += 1
        data['events'].append({'timeTick': data['tick'], 'bossID': target['id'], 'playerName': state['Name'], 'hurt': damage})
        data['events'] = data['events'][-50:]
        self._save_shared(db, start, data)
        self.store.set(db, 'worldboss:last', {'start': start})
        if not report['isWin']:
            boss['dead_until'] = self.clock.now() + self.config['resurgence_seconds']
        outcome = self.ledger.apply(state, rewards=[dict(Type=1, ID=0, Count=gold)] if gold else [])
        state.setdefault('WorldBossRewards', [])
        report.update(total=1, dropList=[], Reward=deepcopy(outcome.rewards), BattleResult={},
                      WorldbossChallenge={'challengeGold': gold, 'hp': damage})
        return Reply(report, self.ledger.global_for(state, outcome))

    def order(self, ctx: RoleContext, params) -> Reply:
        active, remaining, start = self._session()
        boss = self._personal(ctx.state, start)
        if boss.get('order'):
            raise BusinessError('已预约')
        outcome = self.ledger.apply(ctx.state, consume=[dict(Type=2, ID=0, Count=self.config['order_ingot'])])
        self._personal(ctx.state, start)['order'] = 1
        return Reply({}, self.ledger.global_for(ctx.state, outcome))

    def encourage(self, ctx: RoleContext, params) -> Reply:
        remaining, start = self._require_open()
        boss = self._personal(ctx.state, start)
        if boss['addition'] >= self.config['encouraging_max']:
            raise BusinessError('鼓舞已达上限')
        outcome = self.ledger.apply(ctx.state, consume=[dict(Type=2, ID=0, Count=self.config['encouraging_ingot'])])
        boss = self._personal(ctx.state, start)
        boss['addition'] = round(min(self.config['encouraging_max'], boss['addition'] + self.config['encouraging_step']), 2)
        return Reply(boss['addition'], self.ledger.global_for(ctx.state, outcome))

    def autofight(self, ctx: RoleContext, params) -> dict:
        remaining, start = self._require_open()
        self._personal(ctx.state, start)['auto'] = 1 if params['isAutofight'] else 0
        return {}

    def resurgence(self, ctx: RoleContext, params) -> Reply:
        remaining, start = self._require_open()
        boss = self._personal(ctx.state, start)
        if Clock.remaining(boss['dead_until'], self.clock.now()) <= 0:
            raise BusinessError('当前无需复活')
        outcome = self.ledger.apply(ctx.state, consume=[dict(Type=2, ID=0, Count=self.config['resurgence_ingot'])])
        self._personal(ctx.state, start)['dead_until'] = 0
        return Reply(self.boss_info(ctx, {'timeTick': 0}), self.ledger.global_for(ctx.state, outcome))

    def _settle_finished(self, ctx: RoleContext):
        """活动结束后，把上一场自己的伤害结算成待领奖励（每场一次）。"""
        state = ctx.state
        boss = state.get('WorldBoss')
        if not boss or boss.get('settled'):
            return
        active, _, start = self._session()
        if active and boss.get('session') == start:
            return
        data = self.store.get(ctx.db, f'worldboss:{boss.get("session")}')
        if data and str(ctx.user) in data['players']:
            rank = self._my_rank(data, ctx.user)
            when = dt.datetime.fromtimestamp(boss['session']).strftime('%Y-%m-%d %H:%M')
            state.setdefault('WorldBossRewards', []).append(
                {'activityTime': when, 'rank': rank, 'rankReward': thaw(self.config['rank_reward']),
                 'chestReward': thaw(self.config['chest_reward'])})
        boss['settled'] = True

    def reward_list(self, ctx: RoleContext, params) -> list:
        self._settle_finished(ctx)
        return deepcopy(ctx.state.get('WorldBossRewards', []))

    def reward(self, ctx: RoleContext, params) -> Reply:
        self._settle_finished(ctx)
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
        """``/Worldboss/ChallengeRank``：伤害榜，末元素为自己。"""
        active, _, start = self._session()
        data = self.store.get(ctx.db, f'worldboss:{start}') if active else None
        if data is None:
            last = self.store.get(ctx.db, 'worldboss:last') or {}
            data = self.store.get(ctx.db, f'worldboss:{last.get("start")}') if last.get('start') else None
        rows = []
        if data:
            for index, (uid, e) in enumerate(self._ranking(data)[:50], 1):
                rows.append({'rank': index, 'playerID': uid, 'level': e.get('level', 1), 'name': e.get('name', ''),
                             'unionName': '', 'hp': e['hurt'], 'gold': e['gold']})
        mine = next((r for r in rows if r['playerID'] == str(ctx.user)), None)
        rows.append(dict(mine) if mine else {'rank': 0, 'playerID': str(ctx.user), 'level': ctx.state['PLevel'],
                                             'name': ctx.state['Name'], 'unionName': '', 'hp': 0, 'gold': 0})
        return rows

    def notify(self, state: dict) -> dict:
        active, _, _ = self._session()
        return {'IsWorldbossInActivity': 1 if active else 0}
