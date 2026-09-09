"""装备（法宝）实例模型。

实例存放在角色状态 ``Talismans``（``{equipUserId 字符串: 实例}``），``NextIds.equip`` 为自增 ID。
实例字段（客户端 EquipHelper / HeroEquipLayer 读取）：

- ``equipUserId`` 唯一实例 ID，``equipId`` 模板 ID（BaseEquips）
- ``level`` 锻造等级，``pinJie`` 品阶 1..5，``pinJieLevel`` 品阶内进度，``BreakthroughCount`` 喂灵阶数
- ``isInTeam`` 0/1，``heroId`` 绑定英雄（0 为背包）
- 主属性当前值 ``health/normalAttack/...``，初始值 ``*Initial``，每级成长 ``*Grow``
- 副属性 ``baoji/renxing/mingzhong/shanbi/poji/gedang``，``gem`` 宝石（未实现，恒为 None）

模板只提供各主属性的上限 ``*Max`` 与成长上限 ``*GrowMax``，初始值按比例取自上限（见 ``equipment.json``）。
"""
from ..config import EquipmentConfig
from ..errors import BusinessError
from .hero_model import ALL_BATTLE_ATTRS, SECONDARY

STATE_EQUIP_BAG_FULL = -1117011
#: 模板列名（小写）→ 实例字段名。
TEMPLATE_ATTRS = {
    'health': 'health', 'speed': 'speed', 'normalAttack': 'normalAttack', 'normalDefense': 'normalDefense',
    'skillAttack': 'skillAttack', 'skillDefense': 'skillDefense',
}


class EquipmentModel:
    def __init__(self, config: EquipmentConfig, catalog):
        self.config = config
        self.catalog = catalog

    # ---- 模板 -------------------------------------------------------------

    def template(self, equip_id: int) -> dict:
        try:
            return self.catalog['BaseEquips'][str(equip_id)]
        except KeyError as exc:
            raise BusinessError('装备配置不存在') from exc

    def main_attributes(self, template: dict):
        return self.config.main_attributes_by_type.get(template['equipType'], ())

    # ---- 实例 -------------------------------------------------------------

    @staticmethod
    def bag(state: dict) -> dict:
        return state.setdefault('Talismans', {})

    def create(self, state: dict, equip_id: int, level: int = 1) -> dict:
        """按模板创建实例并放入背包。"""
        template = self.template(equip_id)
        bag = self.bag(state)
        if len(bag) >= self.config.bag_capacity:
            raise BusinessError('法宝背包已满', STATE_EQUIP_BAG_FULL)
        ids = state.setdefault('NextIds', {})
        ids['equip'] = ids.get('equip', 0) + 1
        instance = dict(equipUserId=ids['equip'], equipId=equip_id, level=max(1, level), pinJie=1, pinJieLevel=0,
                        BreakthroughCount=0, isInTeam=0, heroId=0, gem=None)
        ratio = self.config.initial_ratio_of_max
        for attr in ALL_BATTLE_ATTRS:
            max_value = template.get(f'{attr}Max')
            if max_value is not None:
                instance[f'{attr}Initial'] = int(round(float(max_value) * ratio))
                instance[f'{attr}Grow'] = round(float(template.get(f'{attr}GrowMax', 0)) * ratio, 2)
        for attr in SECONDARY:
            instance[attr] = 0
        self.compute(instance)
        bag[str(instance['equipUserId'])] = instance
        return instance

    def compute(self, instance: dict) -> dict:
        """当前属性 = (初始 + 成长 × (等级-1)) × (1 + 品阶加成) + 喂灵加成。"""
        bonus = 1 + self.config.pinjie_bonus.get(instance.get('pinJie', 1), 0)
        feed = instance.get('feedBonus', {})
        for attr in ALL_BATTLE_ATTRS:
            initial = instance.get(f'{attr}Initial')
            if initial is not None:
                grow = instance.get(f'{attr}Grow', 0)
                instance[attr] = int(round((initial + grow * (instance['level'] - 1)) * bonus))
            elif attr in feed:
                instance[attr] = 0
            if attr in feed:
                instance[attr] = instance.get(attr, 0) + int(feed[attr])
        return instance

    def get(self, state: dict, equip_user_id) -> dict:
        instance = self.bag(state).get(str(equip_user_id))
        if instance is None:
            raise BusinessError('法宝不存在')
        return instance

    def remove(self, state: dict, equip_user_id) -> dict:
        instance = self.get(state, equip_user_id)
        if instance.get('heroId'):
            raise BusinessError('请先卸下法宝')
        return self.bag(state).pop(str(equip_user_id))

    def equipped_by(self, state: dict, hero_id: int) -> list:
        """英雄已穿戴的实例列表（按部位排序）。"""
        return sorted((x for x in self.bag(state).values() if x.get('heroId') == hero_id),
                      key=lambda x: self.template(x['equipId'])['equipType'])

    def bonus_for_hero(self, state: dict, hero_id: int) -> dict:
        total = {}
        for instance in self.equipped_by(state, hero_id):
            for attr in ALL_BATTLE_ATTRS:
                value = instance.get(attr)
                if value:
                    total[attr] = total.get(attr, 0) + value
        return total

    # ---- 锻造 / 重铸 -----------------------------------------------------------

    def intensify_cost(self, instance: dict) -> int:
        rule = self.config.intensify
        quality = self.template(instance['equipId'])['quality']
        factor = rule.quality_factor.get(quality, rule.quality_factor[max(rule.quality_factor)])
        base = (instance['level'] * rule.cost_a + rule.cost_b) ** rule.cost_power - rule.cost_c
        return max(1, int(round(base * factor)))

    def level_cap(self, player_level: int) -> int:
        return player_level * self.config.intensify.level_cap_multiplier

    def recast_cost(self, instance: dict) -> int:
        rule = self.config.recast
        return rule.stone_cost_base + rule.stone_cost_per_pinjie * (instance['pinJie'] - 1)

    def fragment_template(self, fragment_id: int) -> dict:
        try:
            return self.catalog['BaseFragments'][str(fragment_id)]
        except KeyError as exc:
            raise BusinessError('碎片配置不存在') from exc

    def fragment_for_equip(self, equip_id: int):
        """找到合成目标为该装备的碎片 ID（没有则返回 None）。"""
        for key, fragment in self.catalog['BaseFragments'].items():
            if fragment.get('equipId') == equip_id:
                return int(key)
        return None

    def random_template_id(self, rng, quality: int, equip_type: int = None) -> int:
        """随机一件指定品质（与部位）的装备模板；没有则逐级降低品质。"""
        equips = self.catalog['BaseEquips']
        for q in range(quality, 0, -1):
            candidates = [int(k) for k, v in equips.items()
                          if v['quality'] == q and (equip_type is None or v['equipType'] == equip_type)]
            if candidates:
                return rng.choice(sorted(candidates))
        raise BusinessError('没有可用的装备模板')
