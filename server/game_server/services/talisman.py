"""法宝（装备）接口：列表、锻造、重铸、锁定、喂灵、合成、分解、碎片、穿卸。

变更后的实例通过 ``Global.Talismans`` 按 ``equipUserId`` 增量下发；涉及已穿戴装备时同时下发 ``Global.Slots``。
喂灵进阶档来自模板 ``jieJiAttrs``（``level/mateId/mateCount/equipId/equipCount`` + 该档属性），
属性既读结构化字段（如 ``skilldefense``）也解析 ``desc`` 中的“闪避{+67}”。
"""
from copy import deepcopy
import re

from ..errors import BusinessError
from .base import Reply, RoleContext, global_block
from .equipment import EquipmentModel
from .hero_model import ALL_BATTLE_ATTRS
from .inventory import Ledger, Outcome
from .player_state import PlayerModel

STATE_EQUIP_ERROR = -1117001
ATTR_BY_NAME = {'血量': 'health', '普攻': 'normalAttack', '普防': 'normalDefense', '法攻': 'skillAttack',
                '法防': 'skillDefense', '命中': 'mingzhong', '闪避': 'shanbi', '暴击': 'baoji',
                '韧性': 'renxing', '破击': 'poji', '格挡': 'gedang', '速度': 'speed'}
ATTR_BY_COLUMN = {'health': 'health', 'normalattack': 'normalAttack', 'normaldefense': 'normalDefense',
                  'skillattack': 'skillAttack', 'skilldefense': 'skillDefense', 'speed': 'speed'}
DESC_ATTR = re.compile(r'(血量|普攻|普防|法攻|法防|命中|闪避|暴击|韧性|破击|格挡|速度)\{\+?(\d+)\}')


class TalismanService:
    def __init__(self, model: PlayerModel, equipment: EquipmentModel, ledger: Ledger, events=None):
        self.model = model
        self.equipment = equipment
        self.ledger = ledger
        self.catalog = model.catalog
        self.events = events

    # ---- 通用 -------------------------------------------------------------

    def _reply(self, state: dict, result, outcome: Outcome = None, changed=(), slots=False) -> Reply:
        outcome = outcome or Outcome()
        block = self.ledger.global_for(state, outcome)
        talismans = list(block.get('Talismans', [])) + [deepcopy(x) for x in changed]
        if talismans:
            block['Talismans'] = talismans
        if slots:
            block['Slots'] = self.model.slots(state)
        return Reply(result, block)

    def _refresh_owner(self, state: dict, instance: dict):
        if instance.get('heroId'):
            self.model.refresh_hero(state, self.model.find_hero(state, instance['heroId']))

    def list_all(self, ctx: RoleContext, params) -> list:
        """``/Talisman/Talismans``。"""
        return [deepcopy(x) for x in sorted(ctx.state.get('Talismans', {}).values(), key=lambda x: x['equipUserId'])]

    # ---- 锻造 -------------------------------------------------------------

    def intensify(self, ctx: RoleContext, params) -> Reply:
        """``/Talisman/intensify?playerTalismanId&number``。"""
        state = ctx.state
        instance = self.equipment.get(state, params['playerTalismanId'])
        times = params['number']
        if times not in (1, 10):
            raise BusinessError('锻造次数只能为 1 或 10')
        cap = self.equipment.level_cap(state['PLevel'])
        if instance['level'] >= cap:
            raise BusinessError(f'法宝等级不能超过玩家等级的 {self.equipment.config.intensify.level_cap_multiplier} 倍', STATE_EQUIP_ERROR)
        times = min(times, cap - instance['level'])
        probe = dict(instance)
        cost, levels = 0, []
        for _ in range(times):
            cost += self.equipment.intensify_cost(probe)
            probe['level'] += 1
            levels.append(probe['level'])
        outcome = self.ledger.apply(state, consume=[dict(Type=1, ID=0, Count=cost)])
        instance = self.equipment.get(state, params['playerTalismanId'])
        instance['level'] += times
        self.equipment.compute(instance)
        self._refresh_owner(state, instance)
        state['Counters']['intensify_count'] = state['Counters'].get('intensify_count', 0) + times
        self._emit(state, 'intensify_count', times)
        return self._reply(state, {'Operator': {'Talisman': deepcopy(instance), 'AddLvs': levels}}, outcome,
                           changed=[instance], slots=bool(instance.get('heroId')))

    # ---- 重铸与锁定 -----------------------------------------------------------

    def recast_info(self, ctx: RoleContext, params) -> dict:
        """``/Talisman/RecastInfo?talismanID``。"""
        instance = self.equipment.get(ctx.state, params['talismanID'])
        rule = self.equipment.config.recast
        return {'lockQualifications': [instance.get('lock', 0)] if instance.get('lock') else [],
                'lockCost': [int(rule.lock_cost_by_pinjie.get(p, 0)) for p in (2, 3, 4)],
                'recastCost': self.equipment.recast_cost(instance)}

    def recast(self, ctx: RoleContext, params) -> Reply:
        """``/Talisman/recast?id&type``：消耗重铸石推进品阶进度。"""
        state = ctx.state
        instance = self.equipment.get(state, params['id'])
        max_pinjie = max(self.catalog['EquipPinjieType'].values())
        if instance['pinJie'] >= max_pinjie and instance['pinJieLevel'] == 0:
            raise BusinessError('已是最高品阶', STATE_EQUIP_ERROR)
        outcome = self.ledger.apply(state, consume=[dict(Type=22, ID=0, Count=self.equipment.recast_cost(instance))])
        instance = self.equipment.get(state, params['id'])
        rule = self.equipment.config.recast
        if self.ledger.rng.random() < rule.fail_chance_by_pinjie.get(instance['pinJie'], 0):
            if not instance.get('lock') and instance['pinJieLevel'] > 0:
                instance['pinJieLevel'] -= 1
        else:
            instance['pinJieLevel'] += 1
            if instance['pinJieLevel'] >= self.equipment.config.pinjie_level_steps and instance['pinJie'] < max_pinjie:
                instance['pinJie'] += 1
                instance['pinJieLevel'] = 0
        self.equipment.compute(instance)
        self._refresh_owner(state, instance)
        return self._reply(state, {'Talisman': deepcopy(instance)}, outcome, changed=[instance],
                           slots=bool(instance.get('heroId')))

    def lock(self, ctx: RoleContext, params) -> Reply:
        """``/Talisman/Lock?talismanID&lockQualification``。"""
        state = ctx.state
        instance = self.equipment.get(state, params['talismanID'])
        pinjie = params['lockQualification']
        cost = self.equipment.config.recast.lock_cost_by_pinjie.get(pinjie)
        if cost is None:
            raise BusinessError('该品阶不能锁定')
        outcome = self.ledger.apply(state, consume=[dict(Type=2, ID=0, Count=int(cost))] if cost else [])
        instance = self.equipment.get(state, params['talismanID'])
        instance['lock'] = pinjie
        return self._reply(state, {'Talisman': deepcopy(instance)}, outcome, changed=[instance])

    # ---- 喂灵 -------------------------------------------------------------

    def feed(self, ctx: RoleContext, params) -> Reply:
        """``/Talisman/FeedTalismanNewest?id&ids&count``。"""
        state = ctx.state
        instance = self.equipment.get(state, params['id'])
        template = self.equipment.template(instance['equipId'])
        stages = template.get('jieJiAttrs') or {}
        next_stage = instance.get('BreakthroughCount', 0) + 1
        stage = stages.get(str(next_stage))
        if stage is None:
            raise BusinessError('该法宝已无法继续喂灵', STATE_EQUIP_ERROR)
        if instance['level'] < int(stage.get('level', 0)):
            raise BusinessError(f'法宝需要锻造到 {stage["level"]} 级', STATE_EQUIP_ERROR)
        consume = []
        if stage.get('mateId') and stage.get('mateCount'):
            consume.append(dict(Type=6, ID=int(stage['mateId']), Count=int(stage['mateCount'])))
        raw_count = params.get('count', '0')
        meteor_count = 0 if type(raw_count) in (int, str) and str(raw_count) == '0' else self.ledger.positive(raw_count)
        raw_ids = params.get('ids', '')
        if not isinstance(raw_ids, str):
            raise BusinessError('材料法宝编号不合法')
        materials = [self.ledger.positive(x) for x in raw_ids.split(',')] if raw_ids else []
        if len(set(materials)) != len(materials):
            raise BusinessError('不能重复使用同一件材料法宝')
        equip_count = int(stage.get('equipCount') or 0)
        equip_id = int(stage.get('equipId') or 0)
        if len(materials) + meteor_count != equip_count:
            raise BusinessError(f'需要 {equip_count} 件同名法宝或天外陨铁作为材料')
        for ident in materials:
            material = self.equipment.get(state, ident)
            if material['equipId'] != equip_id or ident == instance['equipUserId']:
                raise BusinessError('材料法宝不符合要求')
            if material.get('heroId'):
                raise BusinessError('材料法宝请先卸下')
            consume.append(dict(Type=10, ID=ident, Count=1))
        if meteor_count:
            required = self.equipment.template(equip_id)
            if required['quality'] != self.catalog['QualityType']['eOrange']:
                raise BusinessError('天外陨铁仅可替代橙色装备')
            meteor_ids = [int(k) for k, row in self.catalog['BaseMates'].items()
                          if row.get('mateType') == self.catalog['PropType']['eYunTie']]
            if len(meteor_ids) != 1:
                raise BusinessError('天外陨铁配置不正确')
            consume.append(dict(Type=6, ID=meteor_ids[0], Count=meteor_count))
        if not consume:
            raise BusinessError('喂灵材料配置为空，未提升')
        outcome = self.ledger.apply(state, consume=consume)
        instance = self.equipment.get(state, params['id'])
        instance['BreakthroughCount'] = next_stage
        bonus = instance.setdefault('feedBonus', {})
        for column, attr in ATTR_BY_COLUMN.items():
            if stage.get(column) is not None:
                bonus[attr] = int(stage[column])
        for name, value in DESC_ATTR.findall(str(stage.get('desc', ''))):
            bonus[ATTR_BY_NAME[name]] = bonus.get(ATTR_BY_NAME[name], 0) + int(value)
        self.equipment.compute(instance)
        self._refresh_owner(state, instance)
        return self._reply(state, {'Operator': {'Talisman': deepcopy(instance)}}, outcome, changed=[instance],
                           slots=bool(instance.get('heroId')))

    # ---- 合成 / 分解 -----------------------------------------------------------

    def synthetic_all(self, ctx: RoleContext, params) -> Reply:
        """``/Talisman/SyntheticAll``：把所有数量足够的碎片合成为法宝。"""
        state = ctx.state
        rewards, consume = [], []
        for item in list(state.get('Fragments', [])):
            fragment = self.catalog['BaseFragments'].get(str(item['ID']))
            if not fragment or not fragment.get('equipId'):
                continue
            times = item['Count'] // int(fragment['exchangeCount'])
            if times:
                rewards.append(dict(Type=10, ID=int(fragment['equipId']), Count=times, Level=1))
                consume.append(dict(Type=23, ID=item['ID'], Count=times * int(fragment['exchangeCount'])))
        if not rewards:
            raise BusinessError('没有可合成的碎片')
        outcome = self.ledger.apply(state, rewards=rewards, consume=consume)
        return self._reply(state, {'Reward': deepcopy(outcome.rewards)}, outcome)

    def exchange_fragment(self, ctx: RoleContext, params) -> Reply:
        """``/Talisman/FexchangT?fragmentid``：用碎片换一件法宝。"""
        state = ctx.state
        fragment_id = params['fragmentid']
        fragment = self.equipment.fragment_template(fragment_id)
        need = int(fragment['exchangeCount'])
        if self.ledger.bag_count(state, 23, fragment_id) < need:
            raise BusinessError('碎片数量不足')
        equip_id = int(fragment.get('equipId') or 0) or self.equipment.random_template_id(
            self.ledger.rng, int(fragment.get('equipQuality', fragment.get('quality', 1))), fragment.get('equipType'))
        outcome = self.ledger.apply(state, rewards=[dict(Type=10, ID=equip_id, Count=1, Level=1)],
                                    consume=[dict(Type=23, ID=fragment_id, Count=need)])
        return self._reply(state, {'Reward': deepcopy(outcome.rewards)}, outcome)

    def sell_fragment(self, ctx: RoleContext, params) -> Reply:
        """``/Talisman/SellFragment?fragmentid&count``。"""
        state = ctx.state
        fragment = self.equipment.fragment_template(params['fragmentid'])
        count = params['count']
        price = int(fragment.get(self.equipment.config.fragment_sell_price_field, 0))
        outcome = self.ledger.apply(state, rewards=[dict(Type=1, ID=0, Count=price * count)] if price else [],
                                    consume=[dict(Type=23, ID=params['fragmentid'], Count=count)])
        return self._reply(state, {}, outcome)

    def decompose(self, ctx: RoleContext, params) -> Reply:
        """``/Talisman/DecomposeTalisman?id&type``：分解为碎片。"""
        state = ctx.state
        instance = self.equipment.get(state, params['id'])
        if instance.get('heroId'):
            raise BusinessError('请先卸下法宝')
        fragment_id = self.equipment.fragment_for_equip(instance['equipId'])
        rewards = []
        if fragment_id is not None:
            fragment = self.equipment.fragment_template(fragment_id)
            ratio = self.equipment.config.decompose_fragment_ratio.get(params['type'], 0.5)
            count = max(1, int(int(fragment['exchangeCount']) * ratio))
            rewards.append(dict(Type=23, ID=fragment_id, Count=count))
        outcome = self.ledger.apply(state, rewards=rewards, consume=[dict(Type=10, ID=instance['equipUserId'], Count=1)])
        return self._reply(state, {'Reward': deepcopy(outcome.rewards)}, outcome)

    def compose_soul(self, ctx: RoleContext, params) -> Reply:
        """``/Talisman/ComposeTalismanSoul?ids``：多件法宝合成一件同部位法宝。"""
        state = ctx.state
        ids = [self.ledger.positive(x) for x in (params.get('ids') or '').split(',') if x]
        need = self.equipment.config.compose_required_count
        if len(ids) < need or len(set(ids)) != len(ids):
            raise BusinessError(f'需要 {need} 件不同的法宝')
        instances = [self.equipment.get(state, i) for i in ids]
        if any(x.get('heroId') for x in instances):
            raise BusinessError('请先卸下参与合成的法宝')
        templates = [self.equipment.template(x['equipId']) for x in instances]
        quality = min(t['quality'] for t in templates)
        equip_type = templates[0]['equipType']
        new_id = self.equipment.random_template_id(self.ledger.rng, min(quality + 1, 4), equip_type)
        outcome = self.ledger.apply(state, rewards=[dict(Type=10, ID=new_id, Count=1, Level=1)],
                                    consume=[dict(Type=10, ID=i, Count=1) for i in ids])
        return self._reply(state, {'Reward': deepcopy(outcome.rewards)}, outcome)

    # ---- 穿卸 -------------------------------------------------------------

    def _check_wearable(self, hero: dict, template: dict):
        hero_template = self.model.heroes.template(hero['heroId'])
        profession = template.get('profession', 4)
        # 与客户端一致：只有武器校验职业，其余部位通用
        if template['equipType'] == 1 and profession not in (0, 4, None) and profession != hero_template['profession']:
            raise BusinessError('上仙，主将职业与装备职业不符.', STATE_EQUIP_ERROR)
        exclusive = template.get('herosId') or {}
        allowed = set(int(v) for v in (exclusive.values() if isinstance(exclusive, dict) else exclusive))
        if allowed and hero['heroId'] not in allowed:
            raise BusinessError('该法宝为专属法宝', STATE_EQUIP_ERROR)

    def _wear(self, state: dict, hero: dict, instance: dict, changed: list):
        template = self.equipment.template(instance['equipId'])
        self._check_wearable(hero, template)
        for worn in self.equipment.equipped_by(state, hero['heroId']):
            if self.equipment.template(worn['equipId'])['equipType'] == template['equipType']:
                worn['heroId'], worn['isInTeam'] = 0, 0
                changed.append(worn)
        if instance.get('heroId') and instance['heroId'] != hero['heroId']:
            previous = self.model.find_hero(state, instance['heroId'])
            instance['heroId'] = 0
            self.model.refresh_hero(state, previous)
        instance['heroId'], instance['isInTeam'] = hero['heroId'], 1
        changed.append(instance)
        self.model.refresh_hero(state, hero)

    def equip(self, ctx: RoleContext, params) -> Reply:
        """``/Hero/Change?heroID&type&id``。"""
        state = ctx.state
        hero = self.model.find_hero(state, params['heroID'])
        instance = self.equipment.get(state, params['id'])
        changed = []
        self._wear(state, hero, instance, changed)
        state['Counters']['equip_count'] = state['Counters'].get('equip_count', 0) + 1
        self._emit(state, 'equip_count', 1)
        return self._reply(state, {}, changed=changed, slots=True)

    def unequip(self, ctx: RoleContext, params) -> Reply:
        """``/Hero/Unloading?heroID&type&id``。"""
        state = ctx.state
        hero = self.model.find_hero(state, params['heroID'])
        instance = self.equipment.get(state, params['id'])
        if instance.get('heroId') != hero['heroId']:
            raise BusinessError('该主将未穿戴此法宝')
        instance['heroId'], instance['isInTeam'] = 0, 0
        self.model.refresh_hero(state, hero)
        return self._reply(state, {}, changed=[instance], slots=True)

    def equip_all(self, ctx: RoleContext, params) -> Reply:
        """``/Hero/ChangeAll?heroID``：每个部位穿上背包中主属性最高的可用法宝。"""
        state = ctx.state
        hero = self.model.find_hero(state, params['heroID'])
        changed = []
        for equip_type in sorted(self.equipment.config.main_attributes_by_type):
            candidates = []
            for instance in state.get('Talismans', {}).values():
                if instance.get('heroId'):
                    continue
                template = self.equipment.template(instance['equipId'])
                if template['equipType'] != equip_type:
                    continue
                try:
                    self._check_wearable(hero, template)
                except BusinessError:
                    continue
                score = sum(instance.get(a, 0) for a in self.equipment.main_attributes(template))
                candidates.append((score, instance['equipUserId'], instance))
            if candidates:
                candidates.sort(key=lambda c: (-c[0], c[1]))
                self._wear(state, hero, candidates[0][2], changed)
        if not changed:
            raise BusinessError('没有可穿戴的法宝')
        state['Counters']['equip_count'] = state['Counters'].get('equip_count', 0) + 1
        self._emit(state, 'equip_count', 1)
        return self._reply(state, {}, changed=changed, slots=True)

    def _emit(self, state: dict, kind: str, amount: int):
        if self.events is not None:
            self.events.on(state, kind, amount)
