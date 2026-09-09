"""宝石/矿石（/Gem/*）。

宝石实例存放在 ``state.Gems``（``{id: 实例}``），字段与客户端 ``MineralHelper`` 一致：
``id, gemProtoID(1..6 形状，对应部位), level, isBattle`` 以及 12 项战斗属性。
形状决定加成属性，等级决定数值（``gem.json`` 的 ``base_value_by_shape × value_growth^(level-1)``）。
镶嵌到装备后写入装备实例的 ``gem`` 字段并计入装备属性；``attributeAddition.gem`` 汇总各部位已镶宝石。
矿洞按时间产出宝石，金锄头提升效率。
"""
from copy import deepcopy

from ..errors import BusinessError
from .base import Reply, RoleContext, global_block
from .clock import Clock
from .inventory import Ledger
from .player_state import PlayerModel

ATTR_KEYS = ('baoji', 'gedang', 'health', 'mingzhong', 'normalAttack', 'normalDefense', 'poji', 'renxing',
             'shanbi', 'skillAttack', 'skillDefense', 'speed')
#: 客户端“属性加成”面板的键名。
PROPERTY_KEYS = {'normalAttack': 'AP', 'skillAttack': 'MAP', 'normalDefense': 'DEF', 'skillDefense': 'MDEF', 'health': 'HP',
                 'speed': 'Speed', 'baoji': 'C', 'renxing': 'TE', 'mingzhong': 'H', 'shanbi': 'D', 'poji': 'B', 'gedang': 'BL'}


class GemService:
    def __init__(self, config, model: PlayerModel, ledger: Ledger, equipment, clock: Clock):
        self.config = config
        self.model = model
        self.ledger = ledger
        self.equipment = equipment
        self.clock = clock
        self.catalog = model.catalog
        model.add_addition_provider('gem', self.addition)

    # ---- 实例 -------------------------------------------------------------

    def bag(self, state: dict) -> dict:
        return state.setdefault('Gems', {})

    def value(self, shape: int, level: int) -> int:
        base = self.config['base_value_by_shape'].get(shape, 10)
        return int(round(base * (self.config['value_growth'] ** (level - 1))))

    def build(self, state: dict, shape: int, level: int) -> dict:
        ids = state.setdefault('NextIds', {})
        ids['gem'] = ids.get('gem', 0) + 1
        gem = dict(id=ids['gem'], gemProtoID=shape, level=level, isBattle=0, **{k: 0 for k in ATTR_KEYS})
        gem[self.config['attr_by_shape'][str(shape)]] = self.value(shape, level)
        return gem

    def create(self, state: dict, shape: int, level: int) -> dict:
        if len(self.bag(state)) >= self.config['bag_capacity']:
            raise BusinessError('宝石背包已满')
        gem = self.build(state, shape, level)
        self.bag(state)[str(gem['id'])] = gem
        return gem

    def get(self, state: dict, gem_id) -> dict:
        gem = self.bag(state).get(str(gem_id))
        if gem is None:
            raise BusinessError('宝石不存在')
        return gem

    # ---- 接口 -------------------------------------------------------------

    def list_all(self, ctx: RoleContext, params) -> list:
        return [deepcopy(g) for g in sorted(self.bag(ctx.state).values(), key=lambda g: g['id'])]

    def _reply(self, state: dict, result, changed_gems=(), changed_equips=(), outcome=None, slots=False) -> Reply:
        block = self.ledger.global_for(state, outcome) if outcome else global_block(self.ledger.resource(state))
        if changed_gems:
            block['Gems'] = [deepcopy(g) for g in changed_gems]
        if changed_equips:
            block['Talismans'] = [deepcopy(e) for e in changed_equips]
        if slots:
            block['Slots'] = self.model.slots(state)
        return Reply(result, block)

    def inlay(self, ctx: RoleContext, params) -> Reply:
        """``/Gem/Change?talismanID&gemID``：镶嵌（同部位形状），原宝石回背包。"""
        state = ctx.state
        instance = self.equipment.get(state, params['talismanID'])
        gem = self.get(state, params['gemID'])
        template = self.equipment.template(instance['equipId'])
        if self.config['shape_to_equip_type'].get(str(gem['gemProtoID'])) != template['equipType']:
            raise BusinessError('宝石形状与部位不匹配')
        if gem['isBattle']:
            raise BusinessError('该宝石已镶嵌')
        changed = [gem]
        if instance.get('gem'):
            old = self.bag(state).get(str(instance['gem']['id']))
            if old:
                old['isBattle'] = 0
                changed.append(old)
        gem['isBattle'] = 1
        instance['gem'] = deepcopy(gem)
        self.equipment.compute(instance)
        if instance.get('heroId'):
            self.model.refresh_all(state)
        return self._reply(state, {}, changed, [instance], slots=True)

    def unload(self, ctx: RoleContext, params) -> Reply:
        """``/Gem/Unloading?talismanID``。"""
        state = ctx.state
        instance = self.equipment.get(state, params['talismanID'])
        if not instance.get('gem'):
            raise BusinessError('该法宝没有镶嵌宝石')
        gem = self.bag(state).get(str(instance['gem']['id']))
        instance['gem'] = None
        self.equipment.compute(instance)
        if gem:
            gem['isBattle'] = 0
        if instance.get('heroId'):
            self.model.refresh_all(state)
        return self._reply(state, {}, [gem] if gem else [], [instance], slots=True)

    def synthetic(self, ctx: RoleContext, params) -> Reply:
        """``/Gem/Synthetic?ids``：2 颗 50% / 3 颗 100%，同形状升级形状不变，异形状随机。"""
        state = ctx.state
        ids = [self.ledger.positive(x) for x in (params.get('ids') or '').split(',') if x]
        if len(ids) not in (2, 3) or len(set(ids)) != len(ids):
            raise BusinessError('请选择 2 或 3 颗宝石')
        gems = [self.get(state, i) for i in ids]
        if any(g['isBattle'] for g in gems):
            raise BusinessError('已镶嵌的宝石不能合成')
        if len({g['level'] for g in gems}) != 1:
            raise BusinessError('必须是同等级宝石')
        if gems[0]['level'] >= self.config['max_level']:
            raise BusinessError('已是最高等级')
        for g in gems:
            self.bag(state).pop(str(g['id']))
        consume = [dict(id=g['id']) for g in gems]
        if len(gems) == 3 or self.ledger.rng.random() < self.config['synthetic_two_chance']:
            shapes = {g['gemProtoID'] for g in gems}
            shape = gems[0]['gemProtoID'] if len(shapes) == 1 else self.ledger.rng.choice(sorted(shapes))
            new = self.create(state, shape, gems[0]['level'] + 1)
            return self._reply(state, {'Gems': [deepcopy(new)], 'Consume': consume}, [new])
        return self._reply(state, {'Consume': consume})

    def put_all(self, ctx: RoleContext, params) -> list:
        """``/Gem/PutAll``：返回建议放入合成炉的低级宝石 id。"""
        low = [g for g in self.bag(ctx.state).values() if not g['isBattle'] and g['level'] <= self.config['auto_synthetic_max_level']]
        return [g['id'] for g in sorted(low, key=lambda g: (g['level'], g['id']))[:3]]

    def synthetic_all(self, ctx: RoleContext, params) -> Reply:
        """``/Gem/SyntheticAll``：把 1..N 级宝石按每 3 颗一组全部合成。"""
        state = ctx.state
        consume, produced = [], []
        for level in range(1, self.config['auto_synthetic_max_level'] + 1):
            while True:
                group = [g for g in self.bag(state).values() if not g['isBattle'] and g['level'] == level][:3]
                if len(group) < 3:
                    break
                for g in group:
                    self.bag(state).pop(str(g['id']))
                    consume.append(dict(id=g['id']))
                shapes = {g['gemProtoID'] for g in group}
                shape = group[0]['gemProtoID'] if len(shapes) == 1 else self.ledger.rng.choice(sorted(shapes))
                produced.append(self.create(state, shape, level + 1))
        if not consume:
            raise BusinessError('没有可合成的宝石')
        return self._reply(state, {'Consume': consume, 'Gems': [deepcopy(g) for g in produced]}, produced)

    def sell(self, ctx: RoleContext, params) -> Reply:
        state = ctx.state
        ids = [self.ledger.positive(x) for x in (params.get('ids') or '').split(',') if x]
        gems = [self.get(state, i) for i in ids]
        if not gems or any(g['isBattle'] for g in gems):
            raise BusinessError('请选择未镶嵌的宝石')
        gold = sum(self.config['sell_price_per_level'] * g['level'] for g in gems)
        for g in gems:
            self.bag(state).pop(str(g['id']))
        outcome = self.ledger.apply(state, rewards=[dict(Type=1, ID=0, Count=gold)])
        return Reply({'Consume': [dict(id=g['id']) for g in gems]}, self.ledger.global_for(state, outcome))

    def buy(self, ctx: RoleContext, params) -> Reply:
        state = ctx.state
        shape, level, count = params['id'], params['level'], params['count']
        if str(shape) not in self.config['attr_by_shape'] or not 1 <= level <= self.config['max_level']:
            raise BusinessError('宝石参数无效')
        outcome = self.ledger.apply(state, consume=[dict(Type=2, ID=0, Count=self.config['buy_ingot_per_level'] * level * count)])
        gems = [self.create(state, shape, level) for _ in range(count)]
        return self._reply(state, {'Gems': [deepcopy(g) for g in gems]}, gems, outcome=outcome)

    # ---- 矿洞 -------------------------------------------------------------

    def _mine(self, state: dict) -> dict:
        mine = state.setdefault('GemMine', {'since': self.clock.now(), 'hoe_until': 0, 'hoe_count': 0})
        return mine

    def _mine_view(self, state: dict) -> dict:
        mine = self._mine(state)
        now = self.clock.now()
        cfg = self.config
        elapsed = min(cfg['mine_full_seconds'], now - mine['since'])
        rate = cfg['gold_hoe_multiplier'] if mine['hoe_until'] > now else 1
        total = int(elapsed // cfg['mine_seconds_per_gem'] * rate)
        weights = cfg['mine_level_weights']
        share = sum(weights.values())
        levels = [{'count': total * w // share} for w in weights.values()]
        levels[0]['count'] += total - sum(l['count'] for l in levels)
        return {'totalSeconds': elapsed, 'useTime': Clock.remaining(mine['hoe_until'], now), 'goldHoeCount': mine['hoe_count'],
                'getGem': {'totalCount': total, 'gemLevels': levels}}

    def mine_info(self, ctx: RoleContext, params) -> dict:
        return self._mine_view(ctx.state)

    def mine_preview(self, ctx: RoleContext, params) -> dict:
        return self._mine_view(ctx.state)['getGem']

    def mine_collect(self, ctx: RoleContext, params) -> Reply:
        """``/Gem/GetGem``：收取矿洞产出。"""
        state = ctx.state
        view = self._mine_view(state)
        if view['totalSeconds'] < self.config['mine_min_seconds'] or view['getGem']['totalCount'] <= 0:
            raise BusinessError('产出不足，稍后再来')
        if len(self.bag(state)) + view['getGem']['totalCount'] > self.config['bag_capacity']:
            raise BusinessError('宝石背包空间不足')
        gems = []
        for level, entry in enumerate(view['getGem']['gemLevels'], 1):
            for _ in range(entry['count']):
                gems.append(self.create(state, self.ledger.rng.randint(1, 6), level))
        self._mine(state)['since'] = self.clock.now()
        return self._reply(state, {'Gems': [deepcopy(g) for g in gems]}, gems)

    def buy_hoe(self, ctx: RoleContext, params) -> Reply:
        state = ctx.state
        outcome = self.ledger.apply(state, consume=[dict(Type=2, ID=0, Count=self.config['gold_hoe_ingot'])])
        mine = self._mine(state)
        mine['hoe_until'] = max(self.clock.now(), mine['hoe_until']) + self.config['gold_hoe_seconds']
        mine['hoe_count'] += 1
        view = self._mine_view(state)
        return Reply({'Result': view, **view}, self.ledger.global_for(state, outcome))

    # ---- 属性加成面板 -----------------------------------------------------------

    def addition(self, state: dict):
        sections = []
        for equip_type in range(1, 7):
            props, count = {}, 0
            for instance in state.get('Talismans', {}).values():
                gem = instance.get('gem')
                if gem and instance.get('heroId') and self.equipment.template(instance['equipId'])['equipType'] == equip_type:
                    count += 1
                    for attr, key in PROPERTY_KEYS.items():
                        if gem.get(attr):
                            props[key] = props.get(key, 0) + gem[attr]
            sections.append({'type': equip_type, 'count': count, 'battleProperty': props})
        return sections if any(s['count'] for s in sections) else None
