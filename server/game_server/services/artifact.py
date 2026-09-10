"""神器殿（/Artifacthall/*）与排行榜（/RankList/*、/ActivityCommonlog/rank）。

神器：``BaseShenQi[1..10]`` 为十阶神器（名称、形象、各属性基础值）；每阶 4 片碎片（``BaseMates`` 200200 起），
四片齐备可灌注一次：等级 +1（每阶 10 级），满级进入下一阶（需达到该阶 ``unlockLevel``）。
神器加成对全队生效，同时写入 ``attributeAddition.artifact``。
抢夺：向其他玩家（或机器人）抢碎片，胜利按概率获得；每日次数按时间恢复，十连抢夺花元宝。
"""
from copy import deepcopy

from ..config import thaw
from ..errors import BusinessError
from .base import Reply, RoleContext, global_block
from .battle import BattleEngine, ENEMY_POSITIONS
from .clock import Clock
from .inventory import Ledger
from .player_state import PlayerModel
from .players import PlayerDirectory, ROBOT_BASE

#: BaseShenQi 列名 → 英雄属性名 → 客户端加成面板键名。
SHENQI_ATTRS = {'health': ('health', 'HP'), 'normalAttack': ('normalAttack', 'AP'), 'normalDefense': ('normalDefense', 'DEF'),
                'skillAttack': ('skillAttack', 'MAP'), 'skillDefense': ('skillDefense', 'MDEF'), 'mingZhong': ('mingzhong', 'H'),
                'shanBi': ('shanbi', 'D'), 'baoJi': ('baoji', 'C'), 'renXing': ('renxing', 'TE'), 'poJi': ('poji', 'B'),
                'geDang': ('gedang', 'BL'), 'speed': ('speed', 'Speed')}
#: 面板属性类型编号（BattleAttrsType）。
PROPERTY_TYPE = {'health': 1, 'normalAttack': 2, 'normalDefense': 3, 'skillAttack': 4, 'skillDefense': 5, 'mingzhong': 6,
                 'shanbi': 7, 'baoji': 8, 'renxing': 9, 'poji': 10, 'gedang': 11, 'speed': 12}


class ArtifactService:
    def __init__(self, config, model: PlayerModel, ledger: Ledger, engine: BattleEngine, clock: Clock,
                 directory: PlayerDirectory):
        self.config = config
        self.model = model
        self.ledger = ledger
        self.engine = engine
        self.clock = clock
        self.directory = directory
        self.catalog = model.catalog
        model.add_team_bonus_provider(self.team_bonus)
        model.add_addition_provider('artifact', self.addition)

    # ---- 数据 -------------------------------------------------------------

    def _table(self):
        return self.catalog['BaseShenQi'] if 'BaseShenQi' in self.catalog else {}

    def _state(self, state: dict) -> dict:
        art = state.setdefault('Artifact', {'step': 1, 'level': 0, 'node': 0, 'rob_used': 0, 'recover_at': 0,
                                            'day': '', 'be_robbed': 0, 'reports': [], 'next_report': 1})
        if art.get('day') != self.clock.day_key():
            art.update(day=self.clock.day_key(), rob_used=0, be_robbed=0)
        now, cfg = self.clock.now(), self.config
        while art['rob_used'] > 0 and art.get('recover_at', 0) and now >= art['recover_at']:
            art['rob_used'] -= 1
            art['recover_at'] = art['recover_at'] + cfg['rob_recover_seconds'] if art['rob_used'] > 0 else 0
        return art

    def fragments_of(self, step: int) -> list:
        base = self.config['fragment_base_id'] + (step - 1) * self.config['fragments_per_step']
        return [base + i for i in range(self.config['fragments_per_step'])]

    def _attrs(self, step: int, level: int) -> dict:
        """当前阶与等级的属性加成：基础值 × (等级 × attr_scale_per_level)。"""
        row = self._table().get(str(step))
        if not row or level <= 0:
            return {}
        scale = level * self.config['attr_scale_per_level']
        return {attr: int(round(float(row.get(column, 0)) * scale)) for column, (attr, _) in SHENQI_ATTRS.items() if row.get(column)}

    def team_bonus(self, state: dict) -> dict:
        art = state.get('Artifact')
        return self._attrs(art['step'], art['level']) if art else {}

    def addition(self, state: dict):
        art = state.get('Artifact')
        if not art or art['level'] <= 0:
            return None
        return {'Artifact': {'Step': art['step'], 'Level': art['level']},
                'BattleHeroProperty': {SHENQI_ATTRS[c][1]: v for c, (a, _) in SHENQI_ATTRS.items()
                                       for v in [self._attrs(art['step'], art['level']).get(a, 0)] if v}}

    def _artifact_view(self, state: dict, step: int) -> dict:
        art = self._state(state)
        level = art['level'] if step == art['step'] else (self.config['max_level'] if step < art['step'] else 0)
        node = art['node'] if step == art['step'] else (self.config['perfusion_nodes'] if step < art['step'] else 0)
        attrs = self._attrs(step, level)
        row = self._table().get(str(step), {})
        nodes = []
        for i in range(self.config['perfusion_nodes']):
            column, (attr, _) = list(SHENQI_ATTRS.items())[i % len(SHENQI_ATTRS)]
            nodes.append([{'battlePropertyType': PROPERTY_TYPE[attr], 'value': int(round(float(row.get(column, 0)) * self.config['attr_scale_per_level']))}])
        return {'step': step, 'level': level, 'perfusionNode': node,
                'fragments': [{'fragmentID': f, 'needCount': 1} for f in self.fragments_of(step)],
                'additions': [{'battlePropertyType': PROPERTY_TYPE[a], 'value': v} for a, v in attrs.items()],
                'perfusionss': nodes}

    # ---- 接口 -------------------------------------------------------------

    def info(self, ctx: RoleContext, params) -> dict:
        art = self._state(ctx.state)
        return {'currentStep': art['step'], 'remainRobTime': self.config['daily_rob_times'] - art['rob_used'],
                'totalRobTime': self.config['daily_rob_times'],
                'remainRecoverTime': self.clock.remaining(art.get('recover_at', 0), self.clock.now()) if art['rob_used'] else 0,
                'robTenCost': self.config['rob_ten_ingot'],
                'artifacts': [self._artifact_view(ctx.state, s) for s in range(1, self.config['max_step'] + 1)]}

    def perfusion(self, ctx: RoleContext, params) -> Reply:
        """``/Artifacthall/Perfusion``：消耗当前阶四片碎片，等级 +1；满级后进入下一阶。"""
        state = ctx.state
        art = self._state(state)
        cfg = self.config
        if art['step'] >= cfg['max_step'] and art['level'] >= cfg['max_level']:
            raise BusinessError('神器已满阶满级')
        fragments = self.fragments_of(art['step'])
        if any(self.ledger.bag_count(state, 6, f) < 1 for f in fragments):
            raise BusinessError('碎片不足', -1108005)
        outcome = self.ledger.apply(state, consume=[dict(Type=6, ID=f, Count=1) for f in fragments])
        art = self._state(state)
        art['level'] += 1
        art['node'] = min(cfg['perfusion_nodes'], art['node'] + 1)
        if art['level'] >= cfg['max_level'] and art['step'] < cfg['max_step']:
            row = self._table().get(str(art['step'] + 1), {})
            if state['PLevel'] >= int(row.get('unlockLevel', 0)):
                art.update(step=art['step'] + 1, level=0, node=0)
        state['ArtifactLv'] = art['step']
        self.model.refresh_all(state)
        return Reply(self._artifact_view(state, art['step']), self.ledger.global_for(state, outcome, Slots=self.model.slots(state)))

    def be_robbed_candidates(self, ctx: RoleContext, params) -> list:
        """``/Artifacthall/BeRobbed?fragmentID``：可抢该碎片的玩家（真实玩家优先，机器人补位）。"""
        db, me = ctx.db, ctx.user
        rows = []
        for user_id in self.directory.all_user_ids(db):
            if user_id == me:
                continue
            other = self.directory.load_state(db, user_id)
            if other and self.ledger.bag_count(other, 6, params['fragmentID']) > 0:
                profile = self.directory.profile_from_state(other)
                rows.append(dict(playerID=str(user_id), name=profile['Name'], avatarID=profile['Avatar'], level=profile['Level'],
                                 type=1 if profile['BattlePower'] < self.model.team(ctx.state)['battlePower'] else 3,
                                 **PlayerDirectory.figure_of(profile)))
            if len(rows) >= 6:
                break
        rank = 1
        while len(rows) < 6:
            profile = self.directory.profile(db, ROBOT_BASE + rank * 7)
            rows.append(dict(playerID=str(profile['PlayerId']), name=profile['Name'], avatarID=profile['Avatar'], level=profile['Level'],
                             type=min(3, 1 + rank // 3), **PlayerDirectory.figure_of(profile)))
            rank += 1
        return rows

    def _rob_once(self, ctx: RoleContext, fragment_id: int, target_id: int, kind: int) -> dict:
        state, db = ctx.state, ctx.db
        allies = [self.engine.hero_unit(h) for h in self.model.team_heroes(state)]
        enemies = [self.engine.hero_unit(dict(h, battleIx=pos)) for h, pos in zip(self.directory.battle_team(db, target_id), ENEMY_POSITIONS)]
        for unit in enemies:
            unit.side = 1
        report = self.engine.simulate(allies, enemies)
        got, rewards = 0, []
        if report['isWin']:
            chance = self.config['fragment_drop_chance_by_type'].get(str(kind), self.config['rob_success_chance'])
            if self.ledger.rng.random() < chance:
                got = 1
                rewards.append(dict(Type=6, ID=fragment_id, Count=1))
                if not self.directory.is_robot(target_id):
                    other = self.directory.load_state(db, target_id)
                    if other and self.ledger.bag_count(other, 6, fragment_id) > 0:
                        self.ledger.apply(other, consume=[dict(Type=6, ID=fragment_id, Count=1)])
                        self._state(other)['reports'].insert(0, {'id': self._state(other)['next_report'], 'avatarID': self.model.team_heroes(state)[0]['heroId'],
                                                                 'name': state['Name'], 'level': state['PLevel'], 'time': self.clock.now(),
                                                                 'fragmentID': fragment_id, 'robber': ctx.user})
                        self._state(other)['next_report'] += 1
                        self._state(other)['reports'] = self._state(other)['reports'][:20]
                        self.directory.save_state(db, target_id, other)
            rewards.append(dict(Type=26, ID=0, Count=self.config['rob_prestige']))
            rewards.append(dict(Type=3, ID=0, Count=self.config['rob_exp']))
        return {'report': report, 'rewards': rewards, 'got': got}

    def rob(self, ctx: RoleContext, params) -> Reply:
        """``/Artifacthall/Rob?fragmentID&beRobbedPlayerID&type``。"""
        state = ctx.state
        art = self._state(state)
        if art['rob_used'] >= self.config['daily_rob_times']:
            if self.ledger.bag_count(state, 5, self.config['rob_token_prop_id']) <= 0:
                raise BusinessError('抢夺次数不足', -1139003)
            self.ledger.apply(state, consume=[dict(Type=5, ID=self.config['rob_token_prop_id'], Count=1)])
        else:
            art['rob_used'] += 1
            if not art.get('recover_at'):
                art['recover_at'] = self.clock.now() + self.config['rob_recover_seconds']
        target_id = params['beRobbedPlayerID']
        profile = self.directory.profile(ctx.db, target_id)
        result = self._rob_once(ctx, params['fragmentID'], target_id, params.get('type') or 1)
        outcome = self.ledger.apply(state, rewards=result['rewards'])
        report = result['report']
        report.update(total=1, dropList=[], Reward=deepcopy(outcome.rewards), BattleResult={}, enemy={'Name': profile['Name'], 'Vip': 0},
                      RobPlayer={'prestige': self.config['rob_prestige'], 'exp': self.config['rob_exp'], 'isGetFragment': result['got'],
                                 'beRobbedPlayer': {'name': profile['Name'], 'playerID': str(target_id), 'avatarID': profile['Avatar'],
                                                    'battlePower': profile['BattlePower']},
                                 'openReward': [r for r in outcome.rewards if r['Type'] == 6], 'notOpenRewards': []})
        return Reply(report, self.ledger.global_for(state, outcome))

    def rob_ten(self, ctx: RoleContext, params) -> Reply:
        """``/Artifacthall/RobTen?number``：花元宝对机器人连续抢夺当前阶缺失的碎片。"""
        state = ctx.state
        art = self._state(state)
        missing = [f for f in self.fragments_of(art['step']) if self.ledger.bag_count(state, 6, f) < 1]
        if not missing:
            raise BusinessError('当前阶碎片已集齐', -1139015)
        cost_outcome = self.ledger.apply(state, consume=[dict(Type=2, ID=0, Count=self.config['rob_ten_ingot'])])
        results = []
        rewards = []
        for i in range(params.get('number') or 10):
            fragment_id = missing[i % len(missing)]
            result = self._rob_once(ctx, fragment_id, ROBOT_BASE + 3 + i, 1)
            rewards.extend(result['rewards'])
            results.append({'rob': [r for r in result['rewards'] if r['Type'] == 6], 'open': [],
                            'prestigeAndExp': [r for r in result['rewards'] if r['Type'] != 6]})
        outcome = self.ledger.apply(state, rewards=rewards)
        outcome.consume = cost_outcome.consume
        return Reply({'robTenRewards': results}, self.ledger.global_for(state, outcome))

    def battle_reports(self, ctx: RoleContext, params) -> list:
        rows = []
        for report in self._state(ctx.state)['reports']:
            row = {k: v for k, v in report.items() if k != 'robber'}
            row['time'] = self.clock.age(report.get('time'))
            rows.append(row)
        return rows

    def revenge(self, ctx: RoleContext, params) -> Reply:
        """``/Artifacthall/Revenge?id``：向抢过自己的玩家复仇。"""
        state = ctx.state
        art = self._state(state)
        record = next((r for r in art['reports'] if r['id'] == params['id']), None)
        if record is None:
            raise BusinessError('战报不存在')
        art['reports'].remove(record)
        target_id = record['robber']
        profile = self.directory.profile(ctx.db, target_id)
        result = self._rob_once(ctx, record['fragmentID'], target_id, 1)
        outcome = self.ledger.apply(state, rewards=result['rewards'])
        report = result['report']
        report.update(total=1, dropList=[], Reward=deepcopy(outcome.rewards), BattleResult={}, enemy={'Name': profile['Name'], 'Vip': 0},
                      RobPlayer={'prestige': self.config['rob_prestige'], 'exp': self.config['rob_exp'], 'isGetFragment': result['got'],
                                 'beRobbedPlayer': {'name': profile['Name'], 'playerID': str(target_id), 'avatarID': profile['Avatar'],
                                                    'battlePower': profile['BattlePower']},
                                 'openReward': [r for r in outcome.rewards if r['Type'] == 6], 'notOpenRewards': []})
        return Reply(report, self.ledger.global_for(state, outcome))

    def notify(self, state: dict) -> dict:
        art = self._state(state)
        return {'ATimes': {'ATimes': self.config['daily_rob_times'] - art['rob_used'], 'TotalTimes': self.config['daily_rob_times']}}


class RankingService:
    """排行榜：基于全部玩家存档实时计算。"""

    def __init__(self, model: PlayerModel, directory: PlayerDirectory):
        self.model = model
        self.directory = directory
        #: ``(db, state) -> 仙盟名``，由组装根注入仙盟服务后填充。
        self.union_name = lambda db, state: ''

    def _rows(self, db):
        rows = []
        for user_id in self.directory.all_user_ids(db):
            state = self.directory.load_state(db, user_id)
            if state is None:
                continue
            team = self.model.team(state)
            heroes = state['ownedHeros']
            rows.append(dict(PlayerId=user_id, HeadId=next((h['heroId'] for h in team['groupList'] if h['heroId']), 0),
                             PlayerName=state['Name'], VipLevel=state.get('VipLevel', 0), Level=state['PLevel'],
                             UnionGroup=self.union_name(db, state),
                             Power=team['battlePower'], RankChange=0,
                             AverageAdvance=round(sum(h.get('rebirthCount', 0) for h in heroes) / max(1, len(heroes)), 1),
                             MaxAdvanceHero=max(heroes, key=lambda h: h.get('rebirthCount', 0))['heroId'] if heroes else 0))
        return rows

    def rank_list(self, ctx: RoleContext, params) -> dict:
        kind = params['type']
        key = {1: lambda r: (-r['Level'], -r['Power']), 2: lambda r: -r['Power'], 3: lambda r: -r['AverageAdvance']}.get(kind)
        if key is None:
            raise BusinessError('排行榜类型不存在')
        rows = sorted(self._rows(ctx.db), key=key)
        for index, row in enumerate(rows, 1):
            row['Rank'] = index
        my_rank = next((r['Rank'] for r in rows if r['PlayerId'] == ctx.user), 0)
        name = {1: 'LevelRankResponse', 2: 'PowerRankResponse', 3: 'AdvanceRankResponse'}[kind]
        return {'MyRank': my_rank, name: rows[:50]}

    def consume_rank(self, ctx: RoleContext, params) -> dict:
        return {'MyRank': 0, 'startTime': '', 'endTime': '', 'ranks': []}
