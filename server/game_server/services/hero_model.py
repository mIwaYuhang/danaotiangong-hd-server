"""英雄属性模型：最终属性、战力、经验曲线、进阶、培养。

客户端不做任何属性计算，只展示服务端下发的数值，因此这里是所有英雄数值的唯一来源。
官方公式未知，这里的公式是显式的本地规则（参数见 ``hero.json``）：

- 主属性(level) = 模板 × (1 + (等级-1) × 成长) × (1 + 进阶次数 × 进阶加成)
- 四维 = 模板四维 × 等级成长 + 培养累计值；每点四维按 ``dimension_effects`` 折算到战斗属性
- 装备加成直接累加到对应属性
- 战力 = Σ 属性 × 权重
- 升级经验 need(level) = round((level × 品质系数 + 5) ^ 2.4)（客户端 TransferEffectScene 同款公式）

英雄记录的持久字段：``heroId, battleIx, level, curExp, rebirthCount, potency, rageTrained,
madSkillLevel, trainDims``；其余展示字段由 ``refresh()`` 每次重算。

``rageSkillLevel``（客户端显示与战斗用的怒气技等级）是派生字段 = ``rageTrained``（技能训练次数）
+ 进阶赠送等级：``rebirthList`` 描述中的「@怒气法术【…】提升N级」按已达成档位累加（超出表长的
档位复用最后一档，通常为每档 +1）。旧存档没有 ``rageTrained`` 时以当时的 ``rageSkillLevel`` 初始化。
"""
import re

from ..config import HeroConfig
from ..errors import BusinessError

#: BaseHeros 列名 → 英雄字段名。
TEMPLATE_COLUMNS = {
    'health': 'health', 'normalattack': 'normalAttack', 'normaldefense': 'normalDefense',
    'skillattack': 'skillAttack', 'skilldefense': 'skillDefense',
}
DIMENSIONS = ('physical', 'strength', 'mana', 'agility')
SECONDARY = ('baoji', 'renxing', 'mingzhong', 'shanbi', 'poji', 'gedang')
PRIMARY = ('health', 'normalAttack', 'normalDefense', 'skillAttack', 'skillDefense')
ALL_BATTLE_ATTRS = PRIMARY + ('speed',) + SECONDARY
POTENCY_PATTERN = re.compile(r'潜力点\{\+?(\d+)\}')
RAGE_BONUS_PATTERN = re.compile(r'怒气法术【[^】]*】提升(\d+)级')


def new_hero_record(hero_id: int, battle_ix: int = 0) -> dict:
    """新获得英雄的持久字段。"""
    return dict(heroId=hero_id, battleIx=battle_ix, level=1, curExp=0, rebirthCount=0, potency=0,
                rageTrained=1, rageSkillLevel=1, madSkillLevel=0,
                trainDims={dim: 0 for dim in DIMENSIONS})


class HeroModel:
    def __init__(self, config: HeroConfig, catalog):
        self.config = config
        self.catalog = catalog

    # ---- 模板与经验 -----------------------------------------------------------

    def template(self, hero_id: int) -> dict:
        try:
            return self.catalog['BaseHeros'][str(hero_id)]
        except KeyError as exc:
            raise BusinessError('英雄配置不存在') from exc

    def exp_to_next(self, level: int, quality: int) -> int:
        factor = self.config.exp_quality_factor.get(quality, self.config.exp_quality_factor[max(self.config.exp_quality_factor)])
        return int(round((level * factor + 5) ** 2.4))

    # ---- 属性计算 -----------------------------------------------------------

    def growth(self, attr: str, level: int) -> float:
        return 1 + (level - 1) * self.config.growth_per_level.get(attr, 0)

    def base_attributes(self, template: dict, level: int, rebirth: int, train_dims=None,
                        multiplier: float = 1.0) -> dict:
        """不含装备的属性：模板 × 等级成长 × 进阶加成 × 外部倍率（NPC 使用），再加四维折算。"""
        rebirth_bonus = 1 + rebirth * self.config.rebirth_percent
        attrs = {}
        for column, field in TEMPLATE_COLUMNS.items():
            attrs[field] = float(template[column]) * self.growth(field, level) * rebirth_bonus * multiplier
        for dim in DIMENSIONS:
            attrs[dim] = float(template[dim]) * self.growth(dim, level) * multiplier + (train_dims or {}).get(dim, 0)
        for attr in SECONDARY:
            attrs[attr] = float(template.get(attr, 0)) * multiplier
        attrs['speed'] = float(self.config.base_speed_by_profession.get(template['profession'], 100)) * multiplier
        for dim in DIMENSIONS:
            for target, per_point in self.config.dimension_effects.get(dim, {}).items():
                attrs[target] = attrs.get(target, 0) + attrs[dim] * per_point
        return attrs

    def battle_power(self, attrs: dict) -> int:
        return int(round(sum(attrs.get(k, 0) * w for k, w in self.config.battle_power_weights.items())))

    def refresh(self, hero: dict, equipment_bonus: dict = None, equip_list=None) -> dict:
        """按持久字段重算英雄的全部展示字段（就地修改并返回）。"""
        template = self.template(hero['heroId'])
        hero.setdefault('trainDims', {dim: 0 for dim in DIMENSIONS})
        hero.setdefault('potency', 0)
        hero.setdefault('madSkillLevel', 0)
        hero.setdefault('rebirthCount', 0)
        hero.setdefault('curExp', 0)
        hero.setdefault('level', 1)
        # 旧存档：rageSkillLevel 尚未包含进阶加成，直接作为已训练等级迁移
        hero.setdefault('rageTrained', max(1, int(hero.get('rageSkillLevel') or 1)))
        attrs = self.base_attributes(template, hero['level'], hero['rebirthCount'], hero['trainDims'])
        for attr, value in (equipment_bonus or {}).items():
            attrs[attr] = attrs.get(attr, 0) + value
        for attr in ALL_BATTLE_ATTRS + DIMENSIONS:
            hero[attr] = int(round(attrs.get(attr, 0)))
        hero['battlePower'] = self.battle_power(attrs)
        hero['totalExp'] = self.exp_to_next(hero['level'], template['quality'])
        hero['equipList'] = list(equip_list or [])
        hero.setdefault('destinyList', [])
        hero.setdefault('attributeAddition', {})
        hero['talentLevel'] = self.talent_level(template, hero['rebirthCount'])
        hero['rageSkillLevel'] = hero['rageTrained'] + self.rage_bonus(template, hero['rebirthCount'])
        # 部分界面读 BreakthroughCount（商店预览、神殿），与 rebirthCount 保持同一值
        hero['BreakthroughCount'] = hero['rebirthCount']
        return hero

    def talent_level(self, template: dict, rebirth: int) -> int:
        """天赋档位：取已达成进阶中最大的 talentDescIndex。"""
        best = 0
        for key, stage in template.get('rebirthList', {}).items():
            if int(key) <= rebirth:
                best = max(best, int(stage.get('talentDescIndex', 0)))
        return best

    @staticmethod
    def _stage_rage_bonus(stage: dict) -> int:
        """单个进阶档描述里的怒气技加成：「@怒气法术【…】提升N级」，没有则为 0。"""
        desc = stage.get('desc') or {}
        blocks = desc.values() if isinstance(desc, dict) else desc
        for block in blocks:
            values = block.values() if isinstance(block, dict) else [block]
            for text in values:
                if isinstance(text, str):
                    match = RAGE_BONUS_PATTERN.search(text)
                    if match:
                        return int(match.group(1))
        return 0

    def rage_bonus(self, template: dict, rebirth: int) -> int:
        """进阶累计赠送的怒气技等级；超出表长的档位复用最后一档（客户端 min(count,13) 同款规则）。"""
        stages = template.get('rebirthList') or {}
        if rebirth <= 0 or not stages:
            return 0
        keys = sorted(int(k) for k in stages)
        per_stage = {k: self._stage_rage_bonus(stages[str(k)]) for k in keys}
        last = keys[-1]
        return sum(per_stage[min(k, last)] for k in range(1, rebirth + 1))

    # ---- 升级 -------------------------------------------------------------

    def add_experience(self, hero: dict, amount: int, level_cap: int) -> int:
        """给英雄加经验并升级，不超过 ``level_cap``；返回实际消耗的经验。"""
        quality = self.template(hero['heroId'])['quality']
        exp = hero['curExp'] + amount
        while hero['level'] < level_cap:
            need = self.exp_to_next(hero['level'], quality)
            if exp < need:
                break
            exp -= need
            hero['level'] += 1
        overflow = 0
        if hero['level'] >= level_cap:
            # 已到等级上限：经验最多累积到差 1 点升级，多余部分不消耗
            need = self.exp_to_next(hero['level'], quality)
            overflow = max(0, exp - (need - 1))
            exp -= overflow
        hero['curExp'] = exp
        return amount - overflow

    def exp_needed_for_levels(self, hero: dict, levels: int) -> int:
        """从当前等级再升 ``levels`` 级所需的总经验（扣除已有经验）。"""
        quality = self.template(hero['heroId'])['quality']
        total = -hero['curExp']
        for step in range(levels):
            total += self.exp_to_next(hero['level'] + step, quality)
        return max(0, total)

    # ---- 进阶 -------------------------------------------------------------

    def rebirth_level_gate(self, next_count: int) -> int:
        gates = self.config.rebirth_level_gates
        if next_count <= len(gates):
            return gates[next_count - 1]
        return gates[-1] + (next_count - len(gates)) * self.config.gate_step_after_table

    def rebirth_stage(self, template: dict, next_count: int) -> dict:
        """第 ``next_count`` 次进阶的配置；超出表长时复用最后一阶。"""
        stages = template.get('rebirthList', {})
        if not stages:
            raise BusinessError('该主将无法进阶')
        keys = sorted(int(k) for k in stages)
        key = next_count if next_count in keys else keys[-1]
        return stages[str(key)]

    def rebirth_max(self, template: dict) -> int:
        cfg = self.config
        if template['quality'] >= 4 and template.get('rating', 0) >= cfg.rebirth_max_count_orange_rating:
            return cfg.rebirth_max_count
        return min(cfg.rebirth_max_count, len(template.get('rebirthList', {})))

    def rebirth_potency(self, stage: dict) -> int:
        """从进阶描述“潜力点{+N}”解析奖励潜力，解析不到用默认值。"""
        desc = stage.get('desc', {})
        for block in desc.values() if isinstance(desc, dict) else []:
            values = block.values() if isinstance(block, dict) else [block]
            for text in values:
                if isinstance(text, str):
                    match = POTENCY_PATTERN.search(text)
                    if match:
                        return int(match.group(1))
        return self.config.rebirth_potency_default

    # ---- 阵位 -------------------------------------------------------------

    def unlocked_team_slots(self, player_level: int) -> int:
        return sum(1 for gate in self.config.team_slot_unlock_levels if player_level >= gate)

    def unlocked_partner_slots(self, player_level: int) -> int:
        return sum(1 for gate in self.config.partner_slot_unlock_levels if player_level >= gate)
