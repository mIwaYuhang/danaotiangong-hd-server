"""寻访（/XunFang/*，45 级开放）。

静态表 ``BaseMasters``（师傅卡：type=所属界 1 人/2 地/3 天/4 重天，quality，improveValue 首次获得的全体血量，
resolveLearnExp 分解授业值，needLearnExp 激活所需授业值）、``MasterGroup``（拜师配方：所需师傅卡与前/后排属性加成）。

玩家状态 ``XunFang``：``cards``（师傅 ID → 数量）、``total_hp``（新卡累计的全体血量）、``free``（今日免费寻访计数）、
``high_count``（高级寻访累计次数，决定元宝价）、``apprentices``（界 → 已拜师的配方 ID）。
授业值是资源 ``LearnExp``（ItemType 39）。加成进入英雄属性并写入 ``attributeAddition.xf``。
"""
from ..errors import BusinessError
from .base import Reply, RoleContext, global_block
from .clock import Clock
from .inventory import Ledger
from .player_state import PlayerModel
from .sacrifice import BPT_ATTRS

STATUS_NEW, STATUS_COUNT, STATUS_OVERFLOW = 1, 2, 3
TARGET_FRONT, TARGET_BACK, TARGET_ALL = 0, 1, 2
TYPE_LEARN_EXP = 39


class XunFangService:
    def __init__(self, config, model: PlayerModel, ledger: Ledger, clock: Clock):
        self.config = config
        self.model = model
        self.ledger = ledger
        self.clock = clock
        self.catalog = model.catalog
        model.add_hero_bonus_provider(self.hero_bonus)
        model.add_addition_provider('xf', self.addition)

    # ---- 数据 -------------------------------------------------------------

    def _state(self, state: dict) -> dict:
        data = state.setdefault('XunFang', {'cards': {}, 'total_hp': 0, 'free': {'day': '', 'used': 0}, 'high_count': 0, 'apprentices': {}})
        if data['free'].get('day') != self.clock.day_key():
            data['free'] = {'day': self.clock.day_key(), 'used': 0}
        return data

    def master(self, master_id: int) -> dict:
        row = self.catalog['BaseMasters'].get(str(master_id))
        if row is None:
            raise BusinessError('师傅不存在')
        return row

    def _groups_of(self, population: int) -> dict:
        return {k: v for k, v in self.catalog['MasterGroup'].items() if str(k).startswith(str(population))}

    def _high_price(self, data: dict) -> int:
        return self.config['high_ingot_base'] + self.config['high_ingot_step'] * data['high_count']

    def _progress(self, data: dict) -> dict:
        progress = {}
        for population in range(1, 5):
            masters = [k for k, r in self.catalog['BaseMasters'].items() if int(r.get('type', 0)) == population]
            progress[str(population)] = {'IsHaveApprentice': str(population) in data['apprentices'],
                                         'ApprenticedCount': sum(1 for m in masters if data['cards'].get(m, 0) > 0),
                                         'TotalCount': len(masters)}
        return progress

    def _group_view(self, group_id, row: dict) -> dict:
        target = max(TARGET_FRONT, min(TARGET_ALL, int(row.get('improveTargetType', 1)) - 1))
        return {'ID': int(group_id), 'Consume': [{'ID': int(c['masterID']), 'Count': int(c['needCount'])} for c in row['groupCost'].values()],
                'AddTargetEnum': target, 'AddAttrEnum': int(row['improvePropertyType']), 'AddValue': int(row['improveValue'])}

    def _row_bonus(self, data: dict) -> tuple:
        """当前拜师带来的（前排加成列表, 后排加成列表）。"""
        front, back = [], []
        for group_id in data['apprentices'].values():
            row = self.catalog['MasterGroup'].get(str(group_id))
            if not row:
                continue
            view = self._group_view(group_id, row)
            entry = {'AddAttrEnum': view['AddAttrEnum'], 'AddValue': view['AddValue']}
            if view['AddTargetEnum'] in (TARGET_FRONT, TARGET_ALL):
                front.append(entry)
            if view['AddTargetEnum'] in (TARGET_BACK, TARGET_ALL):
                back.append(entry)
        return front, back

    # ---- 英雄加成 -------------------------------------------------------------

    def hero_bonus(self, state: dict, hero: dict) -> dict:
        data = state.get('XunFang')
        if not data:
            return {}
        bonus = {'health': data['total_hp']} if data['total_hp'] else {}
        if hero.get('battleIx'):
            front, back = self._row_bonus(data)
            for entry in (front if hero['battleIx'] in self.config['front_positions'] else back):
                attr = BPT_ATTRS[entry['AddAttrEnum']][0]
                bonus[attr] = bonus.get(attr, 0) + entry['AddValue']
        return bonus

    def addition(self, state: dict):
        data = state.get('XunFang')
        if not data or (not data['total_hp'] and not data['apprentices']):
            return None
        front, back = self._row_bonus(data)
        return {'front': front, 'back': back, 'totalHp': data['total_hp']}

    # ---- 接口 -------------------------------------------------------------

    def info(self, ctx: RoleContext, params) -> dict:
        data = self._state(ctx.state)
        return {'AttrList': [{'AddAttrEnum': 1, 'AddValue': data['total_hp']}],
                'HaveFreeXunFangLing': max(0, self.config['daily_free_visits'] - data['free']['used']),
                'HighNextPrice': self._high_price(data), 'ApprenticeProgress': self._progress(data)}

    def _draw(self, state: dict, population: int) -> dict:
        data = self._state(state)
        weights = self.config['quality_weights']
        quality = int(self.ledger.rng.choices([int(q) for q in weights], weights=list(weights.values()))[0])
        pool = sorted(int(k) for k, r in self.catalog['BaseMasters'].items()
                      if int(r.get('type', 0)) == population and int(r.get('quality', 0)) == quality)
        if not pool:
            pool = sorted(int(k) for k, r in self.catalog['BaseMasters'].items() if int(r.get('type', 0)) == population)
        master_id = self.ledger.rng.choice(pool)
        row = self.master(master_id)
        count = data['cards'].get(str(master_id), 0)
        if count == 0:
            data['cards'][str(master_id)] = 1
            data['total_hp'] += int(row['improveValue'])
            return {'Id': master_id, 'Status': STATUS_NEW, 'Count': int(row['improveValue'])}
        if count < self.config['card_max_count']:
            data['cards'][str(master_id)] = count + 1
            return {'Id': master_id, 'Status': STATUS_COUNT, 'Count': 1}
        self.ledger.apply(state, rewards=[dict(Type=TYPE_LEARN_EXP, ID=0, Count=int(row['resolveLearnExp']))])
        return {'Id': master_id, 'Status': STATUS_OVERFLOW, 'Count': int(row['resolveLearnExp'])}

    def visit(self, ctx: RoleContext, params) -> Reply:
        """``/XunFang/XunFangMaster?populationID&xunFangType``：1 普通（免费次数/寻访令）、2 高级（高级令/元宝，五张）。"""
        state = ctx.state
        population, kind = params['populationID'], params['xunFangType']
        if state['PLevel'] < self.config['open_level']:
            raise BusinessError('寻访尚未开放')
        gate = self.config['population_unlock_levels'].get(str(population))
        if gate is None or state['PLevel'] < gate:
            raise BusinessError('该界尚未开放')
        data = self._state(state)
        consume = []
        if kind == 1:
            if data['free']['used'] < self.config['daily_free_visits']:
                data['free']['used'] += 1
            elif self.ledger.bag_count(state, 5, self.config['normal_prop_id']) > 0:
                consume.append(dict(Type=5, ID=self.config['normal_prop_id'], Count=1))
            else:
                raise BusinessError('寻访令不足')
            cards = 1
        else:
            if self.ledger.bag_count(state, 5, self.config['high_prop_id']) > 0:
                consume.append(dict(Type=5, ID=self.config['high_prop_id'], Count=1))
            else:
                consume.append(dict(Type=2, ID=0, Count=self._high_price(data)))
            data['high_count'] += 1
            cards = self.config['high_cards']
        outcome = self.ledger.apply(state, consume=consume)
        opened = [self._draw(state, population) for _ in range(cards)]
        data = self._state(state)
        self.model.refresh_all(state)
        result = {'OpenCard': opened, 'IsHaveApprentice': str(population) in data['apprentices'],
                  'AttrList': [{'AddAttrEnum': 1, 'AddValue': data['total_hp']}],
                  'HaveFreeXunFangLing': max(0, self.config['daily_free_visits'] - data['free']['used']), 'HighNextPrice': self._high_price(data)}
        return Reply(result, self.ledger.global_for(state, outcome, Slots=self.model.slots(state)))

    def handbook(self, ctx: RoleContext, params) -> list:
        data = self._state(ctx.state)
        return [{'MasterID': int(m), 'Count': c} for m, c in sorted(data['cards'].items(), key=lambda kv: int(kv[0]))]

    def apprentice_info(self, ctx: RoleContext, params) -> dict:
        data = self._state(ctx.state)
        front, back = self._row_bonus(data)
        return {'ApprenticeList': [self._group_view(k, r) for k, r in sorted(self._groups_of(params['populationID']).items(), key=lambda kv: int(kv[0]))],
                'Front': front, 'Back': back}

    def become_apprentice(self, ctx: RoleContext, params) -> Reply:
        """``/XunFang/ToBeApprentice?ID``：消耗配方所需师傅卡，获得前/后排属性加成（每界一位）。"""
        state = ctx.state
        row = self.catalog['MasterGroup'].get(str(params['ID']))
        if row is None:
            raise BusinessError('拜师配方不存在')
        population = str(params['ID'])[0]
        data = self._state(state)
        for cost in row['groupCost'].values():
            if data['cards'].get(str(int(cost['masterID'])), 0) < int(cost['needCount']):
                raise BusinessError('师傅卡不足')
        for cost in row['groupCost'].values():
            data['cards'][str(int(cost['masterID']))] -= int(cost['needCount'])
        data['apprentices'][population] = int(params['ID'])
        self.model.refresh_all(state)
        block = global_block(self.ledger.resource(state))
        block['Slots'] = self.model.slots(state)
        return Reply({'ApprenticeList': [self._group_view(k, r) for k, r in self._groups_of(int(population)).items()],
                      'Front': self._row_bonus(data)[0], 'Back': self._row_bonus(data)[1]}, block)

    def exchange(self, ctx: RoleContext, params) -> Reply:
        """``/XunFang/ExchangeLearnExp?fromMasterID&toMasterID&count``：分解师傅卡换授业值，或用授业值激活师傅卡。"""
        state = ctx.state
        data = self._state(state)
        count = params['count']
        if params['fromMasterID']:
            master_id = params['fromMasterID']
            if data['cards'].get(str(master_id), 0) < count:
                raise BusinessError('师傅卡不足')
            data['cards'][str(master_id)] -= count
            outcome = self.ledger.apply(state, rewards=[dict(Type=TYPE_LEARN_EXP, ID=0, Count=int(self.master(master_id)['resolveLearnExp']) * count)])
        elif params['toMasterID']:
            master_id = params['toMasterID']
            row = self.master(master_id)
            outcome = self.ledger.apply(state, consume=[dict(Type=TYPE_LEARN_EXP, ID=0, Count=int(row['needLearnExp']) * count)])
            data = self._state(state)
            if data['cards'].get(str(master_id), 0) == 0:
                data['total_hp'] += int(row['improveValue'])
            data['cards'][str(master_id)] = data['cards'].get(str(master_id), 0) + count
            self.model.refresh_all(state)
        else:
            raise BusinessError('参数无效')
        return Reply({'AttrList': [{'AddAttrEnum': 1, 'AddValue': self._state(state)['total_hp']}]},
                     self.ledger.global_for(state, outcome, Slots=self.model.slots(state)))
