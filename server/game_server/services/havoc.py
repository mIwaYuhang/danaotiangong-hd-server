"""大闹天宫（/XianmoFight/*，41 级开放）：三天一届的异步多人积分赛。

区服共享（``RealmStore``）：``havoc:season`` 记录本届开始时间；``havoc:scores`` 记录每名参赛者的分组与积分。
玩家状态 ``Havoc``：``season``（已抽签的届次）、``group``（天/地/玄/黄 1..4）、``used``（今日已用次数）、
``recover_at``、``logs``、``revenge``（打败过我的人）、``pending``（待领取的日/届奖励）。
每日 23 点结算当日名次奖励（``DuelDailyReward``），第三天 23 点结算本届奖励（``DuelRankReward``）并重置积分。
"""
from copy import deepcopy
import datetime as dt

from ..config import thaw
from ..errors import BusinessError
from .base import Reply, RoleContext, global_block
from .battle import BattleEngine, ENEMY_POSITIONS
from .clock import Clock
from .inventory import Ledger
from .player_state import PlayerModel
from .players import PlayerDirectory, RealmStore, ROBOT_BASE

SETTLE_HOUR = 23


class HavocService:
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

    # ---- 赛季 -------------------------------------------------------------

    def _local(self, ts: int) -> dt.datetime:
        return dt.datetime.fromtimestamp(ts)

    def _season(self, ctx: RoleContext) -> dict:
        """当前届：以某天 23:00 为界；不存在或已过期则开新一届并结算上一届。"""
        db, now = ctx.db, self.clock.now()
        season = self.store.get(db, 'havoc:season')
        if season is None:
            start = self._local(now).replace(hour=SETTLE_HOUR, minute=0, second=0, microsecond=0)
            if start.timestamp() > now:
                start -= dt.timedelta(days=1)
            season = {'index': 1, 'start': int(start.timestamp())}
            self.store.set(db, 'havoc:season', season)
        end = season['start'] + self.config['season_days'] * 86400
        while now >= end:
            self._settle(ctx, season, final=True)
            season = {'index': season['index'] + 1, 'start': end}
            end = season['start'] + self.config['season_days'] * 86400
            self.store.set(db, 'havoc:season', season)
            self.store.set(db, 'havoc:scores', {})
            self.store.set(db, 'havoc:daily_settled', -1)
        return season

    def _scores(self, db) -> dict:
        return self.store.get(db, 'havoc:scores', {})

    def _settle(self, ctx: RoleContext, season: dict, final: bool):
        """给本届所有参赛者写入待领取奖励（当前请求者直接写内存状态，其他玩家写存档）。"""
        db = ctx.db
        scores = self._scores(db)
        table = self.catalog['DuelRankReward' if final else 'DuelDailyReward']
        for group in range(1, self.config['groups'] + 1):
            ranked = sorted((uid for uid, s in scores.items() if s['group'] == group), key=lambda uid: (-scores[uid]['score'], int(uid)))
            for rank, uid in enumerate(ranked, 1):
                if self.directory.is_robot(int(uid)):
                    continue
                reward = self._reward_for(table, rank, 'rankDropList' if final else 'dailyDropList')
                if not reward:
                    continue
                mine = int(uid) == ctx.user
                other = ctx.state if mine else self.directory.load_state(db, int(uid))
                if other is None:
                    continue
                data = self._player(other)
                data['pending'].append({'ID': f"{season['index']}-{'f' if final else 'd'}-{len(data['pending']) + 1}",
                                        'RewardType': 2 if final else 1, 'Rank': rank,
                                        'SpanTime': self._local(self.clock.now()).strftime('%m-%d'), 'Reward': reward})
                if not mine:
                    self.directory.save_state(db, int(uid), other)

    def _reward_for(self, table, rank: int, key: str) -> list:
        for row in table.values():
            if int(row['rankMin']) <= rank <= int(row['rankMax']):
                return [dict(Type=int(r['Type']), ID=int(r['ID']), Count=int(r['Count'])) for r in thaw(row[key]).values()]
        return []

    # ---- 玩家 -------------------------------------------------------------

    def _player(self, state: dict) -> dict:
        data = state.setdefault('Havoc', {'season': 0, 'group': 0, 'day': '', 'used': 0, 'recover_at': 0, 'logs': [],
                                          'revenge': [], 'pending': [], 'settled_day': ''})
        if data.get('day') != self.clock.day_key():
            data.update(day=self.clock.day_key(), used=0, recover_at=0)
        now = self.clock.now()
        while data['used'] > 0 and data['recover_at'] and now >= data['recover_at']:
            data['used'] -= 1
            data['recover_at'] = data['recover_at'] + self.config['recover_seconds'] if data['used'] > 0 else 0
        return data

    def _daily_settle(self, ctx: RoleContext, season: dict):
        """跨过 23 点时结算当日名次奖励（由任意一次访问触发，同一天只执行一次）。"""
        now = self.clock.now()
        day_index = (now - season['start']) // 86400
        marker = self.store.get(ctx.db, 'havoc:daily_settled', -1)
        if day_index > 0 and marker < day_index - 1:
            self._settle(ctx, season, final=False)
            self.store.set(ctx.db, 'havoc:daily_settled', day_index - 1)

    def _open(self, ctx: RoleContext):
        if ctx.state['PLevel'] < self.config['open_level']:
            raise BusinessError('大闹天宫尚未开放')
        season = self._season(ctx)
        self._daily_settle(ctx, season)
        return season, self._player(ctx.state)

    def _can_fight(self) -> int:
        return 0 if self._local(self.clock.now()).hour in self.config['closed_hours'] else 1

    def _ensure_robots(self, db, season: dict, scores: dict):
        """每组放入若干机器人，保证榜单与对手池不空。"""
        changed = False
        for group in range(1, self.config['groups'] + 1):
            for i in range(self.config['robot_candidates']):
                robot_id = ROBOT_BASE + 900 + season['index'] % 50 * 20 + group * 4 + i
                if str(robot_id) not in scores:
                    scores[str(robot_id)] = {'group': group, 'score': i}
                    changed = True
        if changed:
            self.store.set(db, 'havoc:scores', scores)

    def _rank_rows(self, db, scores: dict, group: int) -> list:
        ranked = sorted((uid for uid, s in scores.items() if s['group'] == group), key=lambda uid: (-scores[uid]['score'], int(uid)))
        rows = []
        for rank, uid in enumerate(ranked, 1):
            profile = self.directory.profile(db, int(uid))
            rows.append({'Rank': rank, 'PlayerID': str(uid), 'PlayerName': profile['Name'], 'AvatarID': profile['Avatar'],
                         'Lv': profile['Level'], 'FightScore': scores[uid]['score'], **PlayerDirectory.figure_of(profile)})
        return rows

    def _candidates(self, ctx: RoleContext, scores: dict, group: int, salt: int) -> dict:
        pool = [int(uid) for uid, s in scores.items() if s['group'] == group and int(uid) != ctx.user]
        rng = self.ledger.rng.__class__(ctx.user * 1000 + salt)
        rng.shuffle(pool)
        rows = {}
        for i, uid in enumerate(pool[:self.config['candidates']], 1):
            profile = self.directory.profile(ctx.db, uid)
            rows[str(i)] = {'PlayerID': str(uid), 'AvatarID': profile['Avatar'], 'Lv': profile['Level'], 'PlayerName': profile['Name'],
                            'IsHigh': 1 if scores[str(uid)]['score'] > scores.get(str(ctx.user), {'score': 0})['score'] else 0,
                            **PlayerDirectory.figure_of(profile)}
        return rows

    def _info(self, ctx: RoleContext, season: dict, data: dict) -> dict:
        db, now = ctx.db, self.clock.now()
        scores = self._scores(db)
        self._ensure_robots(db, season, scores)
        balloted = data['season'] == season['index'] and str(ctx.user) in scores
        group = scores[str(ctx.user)]['group'] if balloted else 0
        rows = self._rank_rows(db, scores, group) if balloted else []
        my = next((r for r in rows if r['PlayerID'] == str(ctx.user)), None)
        next_day = season['start'] + ((now - season['start']) // 86400 + 1) * 86400
        return {'BeCanFight': self._can_fight(), 'NoFight': not balloted, 'Type': group, 'CurRank': my['Rank'] if my else 0,
                'FightScore': my['FightScore'] if my else 0, 'HaveTime': self.config['daily_times'] - data['used'],
                'TotalTime': self.config['daily_times'], 'IngotCost': self.config['extra_fight_ingot'],
                'RecoverTime': self.clock.remaining(data['recover_at'], now) if data['used'] else 0,
                'DayCountdown': max(0, next_day - now), 'BigCountdown': max(0, season['start'] + self.config['season_days'] * 86400 - now),
                'ChallengLst': self._candidates(ctx, scores, group, data.get('refresh', 0)) if balloted else {}, 'RankLst': rows[:50]}

    # ---- 接口 -------------------------------------------------------------

    def info(self, ctx: RoleContext, params) -> dict:
        season, data = self._open(ctx)
        return self._info(ctx, season, data)

    def ballot(self, ctx: RoleContext, params) -> dict:
        """``/XianmoFight/Ballot``：抽签进入天/地/玄/黄之一。"""
        season, data = self._open(ctx)
        scores = self._scores(ctx.db)
        if str(ctx.user) not in scores:
            counts = {g: sum(1 for s in scores.values() if s['group'] == g) for g in range(1, self.config['groups'] + 1)}
            group = min(counts, key=lambda g: (counts[g], g))
            scores[str(ctx.user)] = {'group': group, 'score': 0}
            self.store.set(ctx.db, 'havoc:scores', scores)
        data['season'] = season['index']
        data['group'] = scores[str(ctx.user)]['group']
        return self._info(ctx, season, data)

    def refresh(self, ctx: RoleContext, params) -> dict:
        season, data = self._open(ctx)
        data['refresh'] = data.get('refresh', 0) + 1
        return self._info(ctx, season, data)

    def _fight(self, ctx: RoleContext, target_id: int, revenge: bool) -> Reply:
        season, data = self._open(ctx)
        state, db = ctx.state, ctx.db
        if not self._can_fight():
            raise BusinessError('23 点至 24 点为结算时间，暂停挑战')
        scores = self._scores(db)
        if data['season'] != season['index'] or str(ctx.user) not in scores:
            raise BusinessError('请先抽签')
        if str(target_id) not in scores or target_id == ctx.user:
            raise BusinessError('对手不在本届比赛中')
        consume = []
        if data['used'] >= self.config['daily_times']:
            consume.append(dict(Type=2, ID=0, Count=self.config['extra_fight_ingot']))
        else:
            data['used'] += 1
            if not data['recover_at']:
                data['recover_at'] = self.clock.now() + self.config['recover_seconds']
        outcome = self.ledger.apply(state, consume=consume)
        data = self._player(state)
        allies = [self.engine.hero_unit(h) for h in self.model.team_heroes(state)]
        enemies = [self.engine.hero_unit(dict(h, battleIx=pos)) for h, pos in zip(self.directory.battle_team(db, target_id), ENEMY_POSITIONS)]
        for unit in enemies:
            unit.side = 1
        report = self.engine.simulate(allies, enemies)
        profile = self.directory.profile(db, target_id)
        if report['isWin']:
            scores[str(ctx.user)]['score'] += 1
            self.store.set(db, 'havoc:scores', scores)
            if revenge:
                data['revenge'] = [r for r in data['revenge'] if r != target_id]
        data['logs'].insert(0, {'Times': self.clock.now(),
                                'Content': f"{'复仇' if revenge else '挑战'}{profile['Name']}{'胜利' if report['isWin'] else '失败'}",
                                'Type': 1 if report['isWin'] else 2})
        data['logs'] = data['logs'][:self.config['log_limit']]
        if not self.directory.is_robot(target_id):
            other = self.directory.load_state(db, target_id)
            if other is not None:
                theirs = self._player(other)
                theirs['logs'].insert(0, {'Times': self.clock.now(),
                                          'Content': f"{state['Name']}向你发起挑战，你{'落败' if report['isWin'] else '获胜'}",
                                          'Type': 2 if report['isWin'] else 1})
                if report['isWin'] and ctx.user not in theirs['revenge']:
                    theirs['revenge'].insert(0, ctx.user)
                    theirs['revenge'] = theirs['revenge'][:10]
                self.directory.save_state(db, target_id, other)
        report.update(total=1, dropList=[], Reward=[], enemy={'Name': profile['Name'], 'Vip': profile.get('Vip', 0)},
                      BattleResult={'XianMoFight': self._info(ctx, season, data)})
        return Reply(report, self.ledger.global_for(state, outcome))

    def challenge(self, ctx: RoleContext, params) -> Reply:
        return self._fight(ctx, params['bePlayerId'], revenge=False)

    def revenge(self, ctx: RoleContext, params) -> Reply:
        return self._fight(ctx, params['enemyId'], revenge=True)

    def enemies(self, ctx: RoleContext, params) -> dict:
        _, data = self._open(ctx)
        rows = []
        for uid in data['revenge']:
            profile = self.directory.profile(ctx.db, uid)
            rows.append({'PlayerID': str(uid), 'PlayerName': profile['Name'], 'AvatarID': profile['Avatar'], 'Lv': profile['Level'],
                         'Power': profile['BattlePower'], **PlayerDirectory.figure_of(profile)})
        return {'LogLst': [dict(log, Times=self.clock.age(log.get('Times'))) for log in data['logs']], 'RevengeLst': rows}

    def logs(self, ctx: RoleContext, params) -> list:
        _, data = self._open(ctx)
        return [{'Times': self.clock.age(log.get('Times')), 'Type': log.get('Type', 0), 'Content': log['Content']}
                for log in data['logs']]

    def rank_list(self, ctx: RoleContext, params) -> list:
        season, _ = self._open(ctx)
        scores = self._scores(ctx.db)
        self._ensure_robots(ctx.db, season, scores)
        return self._rank_rows(ctx.db, scores, params['type'])[:50]

    def reward_list(self, ctx: RoleContext, params) -> list:
        _, data = self._open(ctx)
        return deepcopy(data['pending'])

    def claim(self, ctx: RoleContext, params) -> Reply:
        _, data = self._open(ctx)
        entry = next((p for p in data['pending'] if p['ID'] == params['ID']), None)
        if entry is None:
            raise BusinessError('奖励不存在或已领取')
        outcome = self.ledger.apply(ctx.state, rewards=entry['Reward'])
        data = self._player(ctx.state)
        data['pending'] = [p for p in data['pending'] if p['ID'] != params['ID']]
        return Reply({'Reward': deepcopy(outcome.rewards)}, self.ledger.global_for(ctx.state, outcome))

    def notify(self, state: dict) -> dict:
        data = self._player(state)
        return {'NXM': {'Last': self.config['daily_times'] - data['used'], 'Total': self.config['daily_times'],
                        'Status': 1 if data['pending'] else 0, 'BPT': 0, 'RPT': 0}}
