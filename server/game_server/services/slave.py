"""小黑屋（/Darkhouse/*）：抓捕其他玩家为奴隶，随时间榨取阅历与培养丹。

状态 ``state.Slave``：``cages``（笼位 → 奴隶信息或宝箱）、``master``（我被谁抓）、每日免费抓捕次数、战报。
抓捕真实玩家会同时写入对方状态的 ``master``（跨玩家更新）；对方可驱赶（花元宝）或反抗（战斗）脱身，
好友可救援。关押到期后奴隶自动释放，笼位变成待领宝箱。
"""
from copy import deepcopy
import json

from ..errors import BusinessError
from .base import Reply, RoleContext, global_block
from .battle import BattleEngine, ENEMY_POSITIONS
from .clock import Clock
from .inventory import Ledger
from .player_state import PlayerModel
from .players import Friendships, PlayerDirectory, ROBOT_BASE

CAGE_SLAVE, CAGE_EMPTY, CAGE_CHEST = 1, 2, 3
REPORT_CAPTURED, REPORT_RESCUED, REPORT_REVOLT, REPORT_DRIVE = 201, 202, 203, 204


class SlaveService:
    def __init__(self, config, model: PlayerModel, ledger: Ledger, engine: BattleEngine, clock: Clock,
                 directory: PlayerDirectory, friendships: Friendships):
        self.config = config
        self.model = model
        self.ledger = ledger
        self.engine = engine
        self.clock = clock
        self.directory = directory
        self.friendships = friendships

    # ---- 状态 -------------------------------------------------------------

    def _state(self, state: dict) -> dict:
        slave = state.setdefault('Slave', {'day': '', 'used': 0, 'rescues': 0, 'cages': {}, 'master': None, 'reports': []})
        if slave.get('day') != self.clock.day_key():
            slave.update(day=self.clock.day_key(), used=0, rescues=0)
        now = self.clock.now()
        for location, cage in list(slave['cages'].items()):
            if cage.get('state') == CAGE_SLAVE and now >= cage['until']:
                earnings = self._earnings(cage, now)
                slave['cages'][location] = {'state': CAGE_CHEST, 'knowledge': earnings[0], 'pills': earnings[1]}
        master = slave.get('master')
        if master and now >= master['until']:
            slave['master'] = None
        return slave

    def _unlocked(self, state: dict) -> int:
        return sum(1 for gate in self.config['cage_unlock_levels'] if state['PLevel'] >= gate)

    def _earnings(self, cage: dict, now: int):
        hours = (min(now, cage['until']) - cage['collected_at']) / 3600
        return (int(hours * self.config['knowledge_per_hour_per_level'] * cage['level']),
                int(hours * self.config['train_pill_per_hour']))

    def _report(self, slave: dict, kind: int, content: dict):
        slave['reports'].insert(0, {'Times': self.clock.now(), 'Type': kind, 'Content': json.dumps(content, ensure_ascii=False),
                                    'TriggerPlayerId': content.get('playerId', 0), 'isCanRevolt': 0})
        slave['reports'] = slave['reports'][:30]

    def _client_report(self, report: dict) -> dict:
        row = deepcopy(report)
        row['Times'] = self.clock.age(row.get('Times'))
        return row

    def _cage_view(self, location: int, cage: dict) -> dict:
        if cage['state'] == CAGE_EMPTY:
            return dict(location=location, state=CAGE_EMPTY)
        if cage['state'] == CAGE_CHEST:
            return dict(location=location, state=CAGE_CHEST, currentEarnings1=cage['knowledge'], currentEarnings2=cage['pills'])
        now = self.clock.now()
        knowledge, pills = self._earnings(cage, now)
        return dict(location=location, state=CAGE_SLAVE, name=cage['name'], level=cage['level'], avatar=cage['avatar'],
                    isUseProp=cage.get('isUseProp', 0), remainFreeTime=self.clock.remaining(cage['until'], now),
                    currentEarnings1=knowledge, currentEarnings2=pills,
                    bleedWhiteEarnings1=knowledge * self.config['bleed_multiplier'], bleedWhiteEarnings2=pills * self.config['bleed_multiplier'])

    # ---- 接口 -------------------------------------------------------------

    def home(self, ctx: RoleContext, params) -> dict:
        state = ctx.state
        slave = self._state(state)
        captures = []
        for location in range(1, len(self.config['cage_unlock_levels']) + 1):
            if location > self._unlocked(state):
                captures.append(None)
                continue
            cage = slave['cages'].get(str(location))
            captures.append(self._cage_view(location, cage) if cage else dict(location=location, state=CAGE_EMPTY))
        master = slave.get('master')
        be_captured = {'remainFreeTime': 0, 'name': '', 'level': 0, 'enemyBattlePower': 0, 'beCapturedEarningsLoss': 0,
                       'driveCost': 0, 'isUseProp': 0}
        if master:
            be_captured.update(remainFreeTime=self.clock.remaining(master['until'], self.clock.now()), name=master['name'],
                               level=master['level'], enemyBattlePower=master['battlePower'], beCapturedEarningsLoss=10,
                               driveCost=int(self.config['drive_ingot_base'] + self.config['drive_ingot_per_level'] * master['level']),
                               isUseProp=master.get('isUseProp', 0))
        return {'roleInfo': {'battlePower': self.model.team(state)['battlePower']},
                'captureInfo': {'freeCaptureNumber': self.config['daily_free_captures'] - slave['used'],
                                'totolFreeCaptureNumber': self.config['daily_free_captures'], 'getTimes': 1, 'bleedWhiteTimes': 1,
                                'captures': captures},
                'beCapturedInfo': be_captured,
                'battleReport': self._client_report(slave['reports'][0]) if slave['reports'] else None}

    def _candidate(self, db, player_id: int, me: int) -> dict:
        profile = self.directory.profile(db, player_id)
        info = [dict(type=1, enemyid=player_id, name=profile['Name'], level=profile['Level'], battlePower=profile['BattlePower'],
                     avatar=profile['Avatar'], IsUseProp=0)]
        is_captured = 0
        if not self.directory.is_robot(player_id):
            other = self.directory.load_state(db, player_id)
            master = (other or {}).get('Slave', {}).get('master') if other else None
            if master and self.clock.now() < master['until']:
                is_captured = 1
                info[0]['IsUseProp'] = master.get('isUseProp', 0)
                info.append(dict(type=2, enemyid=master['playerId'], name=master['name'], level=master['level'],
                                 battlePower=master['battlePower'], avatar=master.get('avatar', 0)))
        return {'isCapture': is_captured, 'CaptureMasterInfo': info}

    def candidates(self, ctx: RoleContext, params) -> list:
        """``/Darkhouse/RandomCaptur`` 与 ``/Darkhouse/EnemyList``。"""
        db, me = ctx.db, ctx.user
        rows = []
        for user_id in self.directory.all_user_ids(db):
            if user_id != me and not self._is_my_slave(ctx.state, user_id):
                rows.append(self._candidate(db, user_id, me))
            if len(rows) >= 6:
                break
        for i in range(1, self.config['robot_candidates'] + 1):
            if len(rows) >= 6:
                break
            rows.append(self._candidate(db, ROBOT_BASE + 11 * i, me))
        return rows

    def _is_my_slave(self, state: dict, player_id: int) -> bool:
        return any(c.get('playerId') == player_id for c in state.get('Slave', {}).get('cages', {}).values() if c.get('state') == CAGE_SLAVE)

    def capture(self, ctx: RoleContext, params) -> Reply:
        """``/Darkhouse/CatchCapture?location&capturePlayerID&isUseProp``。"""
        state, db = ctx.state, ctx.db
        slave = self._state(state)
        location, target_id = params['location'], params['capturePlayerID']
        if not 1 <= location <= self._unlocked(state):
            raise BusinessError('该笼位尚未开放')
        cage = slave['cages'].get(str(location))
        if cage and cage['state'] != CAGE_EMPTY:
            raise BusinessError('该笼位已有俘虏', -1121001)
        if target_id == ctx.user or self._is_my_slave(state, target_id):
            raise BusinessError('不能抓捕该玩家')
        master = slave.get('master')
        if master and master['playerId'] == target_id:
            raise BusinessError('不能抓捕主人', -1121008)
        consume = []
        if slave['used'] >= self.config['daily_free_captures']:
            if self.ledger.bag_count(state, 5, self.config['capture_prop_id']) <= 0:
                raise BusinessError('今日抓捕次数已用完')
            consume.append(dict(Type=5, ID=self.config['capture_prop_id'], Count=1))
        else:
            slave['used'] += 1
        use_prop = 1 if str(params.get('isUseProp') or '0') == '1' else 0
        if use_prop:
            consume.append(dict(Type=5, ID=self.config['super_capture_prop_id'], Count=1))
        outcome = self.ledger.apply(state, consume=consume)
        slave = self._state(state)
        profile = self.directory.profile(db, target_id)
        if use_prop:
            report = {'isWin': True, 'battleHeros': [], 'battleRecords': [], 'total': 1}
        else:
            allies = [self.engine.hero_unit(h) for h in self.model.team_heroes(state)]
            enemies = [self.engine.hero_unit(dict(h, battleIx=pos)) for h, pos in zip(self.directory.battle_team(db, target_id), ENEMY_POSITIONS)]
            for unit in enemies:
                unit.side = 1
            report = self.engine.simulate(allies, enemies)
            report['total'] = 1
        if report['isWin']:
            now = self.clock.now()
            slave['cages'][str(location)] = {'state': CAGE_SLAVE, 'playerId': target_id, 'name': profile['Name'], 'level': profile['Level'],
                                             'avatar': profile['Avatar'], 'battlePower': profile['BattlePower'], 'isUseProp': use_prop,
                                             'until': now + self.config['hold_seconds'], 'collected_at': now}
            if not self.directory.is_robot(target_id):
                other = self.directory.load_state(db, target_id)
                if other is not None:
                    theirs = self._state(other)
                    theirs['master'] = {'playerId': ctx.user, 'name': state['Name'], 'level': state['PLevel'],
                                        'battlePower': self.model.team(state)['battlePower'], 'isUseProp': use_prop,
                                        'avatar': self.model.team_heroes(state)[0]['heroId'], 'until': now + self.config['hold_seconds']}
                    self._report(theirs, REPORT_CAPTURED, {'NowTPName': state['Name'], 'playerId': ctx.user})
                    self.directory.save_state(db, target_id, other)
            self._report(slave, REPORT_CAPTURED, {'NowTPName': profile['Name'], 'playerId': target_id})
        report.update(dropList=[], Reward=[], BattleResult={}, enemy={'Name': profile['Name'], 'Vip': 0})
        return Reply(report, self.ledger.global_for(state, outcome))

    def _collect(self, ctx: RoleContext, location: int, multiplier: int, release: bool, ingot: int = 0) -> Reply:
        state = ctx.state
        slave = self._state(state)
        cage = slave['cages'].get(str(location))
        if not cage or cage['state'] == CAGE_EMPTY:
            raise BusinessError('该笼位没有俘虏')
        if cage['state'] == CAGE_CHEST:
            knowledge, pills = cage['knowledge'], cage['pills']
            release = True
        else:
            knowledge, pills = self._earnings(cage, self.clock.now())
        rewards = [dict(Type=18, ID=0, Count=knowledge * multiplier), dict(Type=11, ID=0, Count=pills * multiplier)]
        rewards = [r for r in rewards if r['Count'] > 0]
        outcome = self.ledger.apply(state, rewards=rewards, consume=[dict(Type=2, ID=0, Count=ingot)] if ingot else [])
        slave = self._state(state)
        cage = slave['cages'].get(str(location))
        if release:
            if cage and cage.get('playerId') and not self.directory.is_robot(cage['playerId']):
                other = self.directory.load_state(ctx.db, cage['playerId'])
                if other is not None and (other.get('Slave') or {}).get('master', {}) and other['Slave']['master'].get('playerId') == ctx.user:
                    other['Slave']['master'] = None
                    self.directory.save_state(ctx.db, cage['playerId'], other)
            slave['cages'][str(location)] = {'state': CAGE_EMPTY}
        elif cage:
            cage['collected_at'] = self.clock.now()
        return Reply({'Reward': deepcopy(outcome.rewards)}, self.ledger.global_for(state, outcome))

    def gain(self, ctx: RoleContext, params) -> Reply:
        """``/Darkhouse/GainPart?location``：领取当前累计收益。"""
        return self._collect(ctx, params['location'], 1, release=False)

    def bleed(self, ctx: RoleContext, params) -> Reply:
        """``/Darkhouse/BleedWhite?location``：花元宝榨干并释放。"""
        slave = self._state(ctx.state)
        cage = slave['cages'].get(str(params['location']))
        if not cage or cage['state'] != CAGE_SLAVE:
            raise BusinessError('该笼位没有俘虏')
        minutes = self.clock.remaining(cage['until'], self.clock.now()) / 60
        ingot = max(10, int((self.config['bleed_ingot_base'] + cage['level'] * self.config['bleed_ingot_per_level']) * minutes / 300))
        return self._collect(ctx, params['location'], self.config['bleed_multiplier'], release=True, ingot=ingot)

    def get_all(self, ctx: RoleContext, params) -> Reply:
        """``/Darkhouse/GetAll?location``：领取到期宝箱。"""
        return self._collect(ctx, params['location'], 1, release=True)

    def _free_me(self, ctx: RoleContext, kind: int):
        state = ctx.state
        slave = self._state(state)
        master = slave.get('master')
        if not master:
            raise BusinessError('你当前是自由的')
        if not self.directory.is_robot(master['playerId']):
            other = self.directory.load_state(ctx.db, master['playerId'])
            if other is not None:
                theirs = self._state(other)
                for location, cage in theirs['cages'].items():
                    if cage.get('playerId') == ctx.user:
                        theirs['cages'][location] = {'state': CAGE_EMPTY}
                self._report(theirs, kind, {'NowTPName': state['Name'], 'playerId': ctx.user})
                self.directory.save_state(ctx.db, master['playerId'], other)
        slave['master'] = None
        self._report(slave, kind, {'NowTPName': master['name'], 'playerId': master['playerId']})
        return master

    def drive(self, ctx: RoleContext, params) -> Reply:
        """``/Darkhouse/Drive``：花元宝驱赶主人。"""
        slave = self._state(ctx.state)
        master = slave.get('master')
        if not master:
            raise BusinessError('你当前是自由的')
        if master.get('isUseProp'):
            raise BusinessError('超级抓捕期间无法驱赶')
        cost = int(self.config['drive_ingot_base'] + self.config['drive_ingot_per_level'] * master['level'])
        outcome = self.ledger.apply(ctx.state, consume=[dict(Type=2, ID=0, Count=cost)])
        self._free_me(ctx, REPORT_DRIVE)
        return Reply({}, self.ledger.global_for(ctx.state, outcome))

    def revolt(self, ctx: RoleContext, params) -> Reply:
        """``/Darkhouse/Revolt``：与主人战斗，胜利即自由。"""
        state = ctx.state
        slave = self._state(state)
        master = slave.get('master')
        if not master:
            raise BusinessError('你当前是自由的')
        if master.get('isUseProp'):
            raise BusinessError('超级抓捕期间无法反抗')
        allies = [self.engine.hero_unit(h) for h in self.model.team_heroes(state)]
        enemies = [self.engine.hero_unit(dict(h, battleIx=pos)) for h, pos in zip(self.directory.battle_team(ctx.db, master['playerId']), ENEMY_POSITIONS)]
        for unit in enemies:
            unit.side = 1
        report = self.engine.simulate(allies, enemies)
        if report['isWin']:
            self._free_me(ctx, REPORT_REVOLT)
        report.update(total=1, dropList=[], Reward=[], BattleResult={}, enemy={'Name': master['name'], 'Vip': 0})
        return Reply(report, global_block(self.ledger.resource(state)))

    def rescue_list(self, ctx: RoleContext, params) -> dict:
        """``/Darkhouse/GFriendList``：被抓的好友。"""
        rows = []
        for friend_id in self.friendships.friends_of(ctx.db, ctx.user):
            other = self.directory.load_state(ctx.db, friend_id)
            master = (other or {}).get('Slave', {}).get('master') if other else None
            if not master or self.clock.now() >= master['until']:
                continue
            profile = self.directory.profile_from_state(other)
            rows.append(dict(friendID=friend_id, friendName=profile['Name'], friendLevel=profile['Level'], friendAvatar=profile['Avatar'],
                             friendTotal=profile['BattlePower'], masterName=master['name'], masterLevel=master['level'],
                             masterAvatar=master.get('avatar', 0), masterTotal=master['battlePower'],
                             knowledge=self.config['knowledge_per_hour_per_level'] * profile['Level'], trainingPoint=self.config['train_pill_per_hour'],
                             isUseProp=master.get('isUseProp', 0)))
        slave = self._state(ctx.state)
        return {'remainSaveTime': self.config['daily_rescues'] - slave['rescues'], 'friends': rows}

    def rescue(self, ctx: RoleContext, params) -> Reply:
        """``/Darkhouse/SaveFriend?friendID``：与好友的主人战斗，胜利则释放好友。"""
        state, db = ctx.state, ctx.db
        slave = self._state(state)
        if slave['rescues'] >= self.config['daily_rescues']:
            raise BusinessError('今日救援次数已用完')
        friend_id = params['friendID']
        other = self.directory.load_state(db, friend_id)
        master = (other or {}).get('Slave', {}).get('master') if other else None
        if not master or self.clock.now() >= master['until']:
            raise BusinessError('该好友当前是自由的')
        if master.get('isUseProp'):
            raise BusinessError('超级抓捕期间无法救援')
        slave['rescues'] += 1
        allies = [self.engine.hero_unit(h) for h in self.model.team_heroes(state)]
        enemies = [self.engine.hero_unit(dict(h, battleIx=pos)) for h, pos in zip(self.directory.battle_team(db, master['playerId']), ENEMY_POSITIONS)]
        for unit in enemies:
            unit.side = 1
        report = self.engine.simulate(allies, enemies)
        rewards = []
        if report['isWin']:
            other['Slave']['master'] = None
            self._report(other['Slave'], REPORT_RESCUED, {'NowTPName': state['Name'], 'playerId': ctx.user})
            self.directory.save_state(db, friend_id, other)
            if not self.directory.is_robot(master['playerId']):
                owner = self.directory.load_state(db, master['playerId'])
                if owner is not None:
                    theirs = self._state(owner)
                    for location, cage in theirs['cages'].items():
                        if cage.get('playerId') == friend_id:
                            theirs['cages'][location] = {'state': CAGE_EMPTY}
                    self.directory.save_state(db, master['playerId'], owner)
            rewards = [dict(Type=18, ID=0, Count=self.config['knowledge_per_hour_per_level'] * other['PLevel']),
                       dict(Type=11, ID=0, Count=self.config['train_pill_per_hour'])]
        outcome = self.ledger.apply(state, rewards=rewards)
        report.update(total=1, dropList=[], Reward=deepcopy(outcome.rewards), BattleResult={}, enemy={'Name': master['name'], 'Vip': 0})
        return Reply(report, self.ledger.global_for(state, outcome))

    def reports(self, ctx: RoleContext, params) -> list:
        return [self._client_report(row) for row in self._state(ctx.state)['reports']]

    def notify(self, state: dict) -> dict:
        slave = self._state(state)
        empty = any(location <= self._unlocked(state) and slave['cages'].get(str(location), {'state': CAGE_EMPTY}).get('state') == CAGE_EMPTY
                    for location in range(1, len(self.config['cage_unlock_levels']) + 1))
        return {'DarkHouse': {'Last': self.config['daily_free_captures'] - slave['used'], 'Total': self.config['daily_free_captures'],
                              'CanCapture': bool(empty)}}
