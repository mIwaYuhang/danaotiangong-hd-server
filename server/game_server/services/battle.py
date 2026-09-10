"""战斗引擎：阵容构建、回合模拟、客户端可回放的战报。

关卡阵容来自 NPC 表的编号规律（``NPC = 关卡ID×100 + (难度-1)×10 + 位置``，0-6 小怪、7-9 精英），
每波的位置组合与敌方数量上限见 ``battle.json``。NPC 没有基础属性，取同职业同品质英雄模板的平均值
作为 1 级模板，按英雄成长公式成长到 NPC 等级，再乘职责与难度倍率。

战报格式（客户端 ``BattleData:init``）：
- ``battleHeros``：双方单位，``posId`` 1-6 我方、7-12 敌方；
- ``battleRecords``：每次行动一条，``Step=true``，``skillType`` 1 普攻 / 2 怒气技；
  ``health/rage`` 为行动者的增量，``affectList`` 为受击者增量，``effect`` 1 普通 / 2 暴击 / 3 格挡 / 4 闪避。

怒气技的目标与倍率从 ``BaseSkills.desc`` 解析（``{...}`` 内为含 ``sl``=技能等级 的算式），
解析不到的描述退化为单体伤害。
"""
import ast
from dataclasses import dataclass, field
import operator
import random
import re
from typing import List, Optional

from ..config import BattleConfig, HeroConfig
from ..errors import BusinessError
from .hero_model import ALL_BATTLE_ATTRS, HeroModel

FRONT_ROW = {1, 2, 3, 7, 8, 9}
ENEMY_POSITIONS = (7, 8, 9, 10, 11, 12)
SKILL_NORMAL, SKILL_RAGE = 1, 2
EFFECT_NORMAL, EFFECT_CRIT, EFFECT_BLOCK, EFFECT_DODGE = 1, 2, 3, 4
FORMULA = re.compile(r'\{([^{}]*)\}')
SAFE_OPS = {ast.Add: operator.add, ast.Sub: operator.sub, ast.Mult: operator.mul, ast.Div: operator.truediv,
            ast.USub: operator.neg, ast.UAdd: operator.pos}


@dataclass
class Unit:
    pos: int
    side: int                      # 0 我方，1 敌方
    name: str
    attrs: dict
    hero_id: int = 0
    npc_id: int = 0
    skill_id: int = 0
    skill_level: int = 1
    talent_id: int = 0
    rebirth: int = 0
    weapon_id: int = 0
    hp: int = 0
    hp_max: int = 0
    rage: int = 0

    @property
    def alive(self) -> bool:
        return self.hp > 0

    def to_battle_hero(self) -> dict:
        return dict(posId=self.pos, heroId=self.hero_id, npcId=self.npc_id, npcSize=0,
                    health=self.hp, healthMax=self.hp_max, rage=self.rage, weaponId=self.weapon_id,
                    wq=0, rebirthCount=self.rebirth, halolv=0)


@dataclass
class SkillSpec:
    kind: str = 'damage'           # damage / rage / heal
    targeting: str = 'single'      # single / front / back / row / all / highest / lowest / count
    count: int = 1
    percent: float = 100.0
    own_side: bool = False


def _safe_eval(node):
    if isinstance(node, ast.Expression):
        return _safe_eval(node.body)
    if isinstance(node, ast.Constant) and isinstance(node.value, (int, float)):
        return float(node.value)
    if isinstance(node, ast.BinOp) and type(node.op) in SAFE_OPS:
        return SAFE_OPS[type(node.op)](_safe_eval(node.left), _safe_eval(node.right))
    if isinstance(node, ast.UnaryOp) and type(node.op) in SAFE_OPS:
        return SAFE_OPS[type(node.op)](_safe_eval(node.operand))
    raise ValueError('不支持的表达式')


def evaluate_formula(text: str, sl: int, sa: float = 0.0) -> Optional[float]:
    """求值技能描述中的算式，例如 ``0.80*(100+1*(sl-1))``。"""
    expression = text.replace('sl', str(sl)).replace('sa', str(sa)).replace('（', '(').replace('）', ')')
    expression = re.sub(r'[^0-9.+\-*/() ]', '', expression)
    if not expression.strip():
        return None
    # 描述里偶有多余的括号，逐步去掉直到能解析
    for _ in range(3):
        try:
            return _safe_eval(ast.parse(expression, mode='eval'))
        except (SyntaxError, ValueError):
            expression = expression.replace('(', '', 1) if expression.count('(') > expression.count(')') else expression.rstrip(')')
    return None


def parse_skill(desc, sl: int) -> SkillSpec:
    """从怒气技描述解析目标与倍率。"""
    spec = SkillSpec()
    if not isinstance(desc, str):
        return spec
    match = FORMULA.search(desc)
    value = evaluate_formula(match.group(1), sl) if match else None
    own = '我方' in desc or '自身' in desc
    if own and '怒气' in desc:
        spec.kind, spec.own_side = 'rage', True
        spec.percent = value if value is not None else 30
    elif own and ('回复' in desc or '治疗' in desc):
        spec.kind, spec.own_side = 'heal', True
        spec.percent = value if value is not None else 50
    else:
        spec.kind = 'damage'
        spec.percent = value if value is not None else 100
    if '全体' in desc or '所有' in desc:
        spec.targeting = 'all'
    elif '横排' in desc:
        spec.targeting = 'row'
    elif '前排' in desc:
        spec.targeting = 'front'
    elif '后排' in desc:
        spec.targeting = 'back'
    elif '最多' in desc:
        spec.targeting = 'highest'
    elif '最少' in desc or '最低' in desc:
        spec.targeting = 'lowest'
    else:
        for word, n in (('两名', 2), ('二名', 2), ('三名', 3), ('四名', 4), ('2名', 2), ('3名', 3)):
            if word in desc:
                spec.targeting, spec.count = 'count', n
                break
    return spec


class BattleEngine:
    def __init__(self, config: BattleConfig, hero_config: HeroConfig, catalog, heroes: HeroModel,
                 rng: random.Random = None):
        self.config = config
        self.hero_config = hero_config
        self.catalog = catalog
        self.heroes = heroes
        self.rng = rng or random.Random()
        self._archetypes = {}

    # ---- 阵容构建 -----------------------------------------------------------

    def hero_unit(self, hero: dict) -> Unit:
        template = self.heroes.template(hero['heroId'])
        attrs = {attr: float(hero.get(attr, 0)) for attr in ALL_BATTLE_ATTRS}
        weapon = next((e['equipId'] for e in hero.get('equipList', [])
                       if self.catalog['BaseEquips'].get(str(e.get('equipId')), {}).get('equipType') == 1), 0)
        return Unit(pos=hero['battleIx'], side=0, name=template['name'], attrs=attrs, hero_id=hero['heroId'],
                    skill_id=template.get('skillId', 0), skill_level=hero.get('rageSkillLevel', 1),
                    talent_id=template.get('talentId', 0), rebirth=hero.get('rebirthCount', 0), weapon_id=weapon,
                    hp=int(attrs['health']), hp_max=int(attrs['health']), rage=self.hero_config.rage.initial)

    def archetype(self, profession: int, quality: int) -> dict:
        """同职业同品质英雄模板的平均值（NPC 的 1 级模板）。"""
        key = (profession, quality)
        if key not in self._archetypes:
            heroes = self.catalog['BaseHeros']
            for q in list(range(quality, 0, -1)) + list(range(quality + 1, 8)):
                group = [h for h in heroes.values() if h['profession'] == profession and h['quality'] == q]
                if not group:
                    group = [h for h in heroes.values() if h['quality'] == q]
                if group:
                    break
            fields = ('health', 'normalattack', 'normaldefense', 'skillattack', 'skilldefense',
                      'physical', 'strength', 'mana', 'agility', 'baoji', 'renxing', 'mingzhong', 'shanbi', 'poji', 'gedang')
            self._archetypes[key] = {f: sum(float(h.get(f, 0)) for h in group) / len(group) for f in fields}
            self._archetypes[key]['profession'] = profession
        return self._archetypes[key]

    def stage_waves(self, stage: dict) -> int:
        return max(1, len([w for w in stage['battleName'].split(',') if w.strip()]))

    def chapter_ordinal(self, chapter_id: int) -> int:
        chapters = sorted(int(k) for k in self.catalog['BaseChapters'])
        return chapters.index(chapter_id) if chapter_id in chapters else 0

    def npc_level(self, stage_id: int, chapter_id: int, difficulty: int) -> int:
        rule = self.config.npc_level
        level = (rule.base + self.chapter_ordinal(chapter_id) * rule.per_chapter
                 + (stage_id % 10) * rule.per_stage + (difficulty - 1) * rule.per_difficulty)
        return max(1, int(level))

    def enemy_units(self, stage_id: int, stage: dict, difficulty: int, wave_index: int) -> List[Unit]:
        """第 ``wave_index``（从 1 起）波的敌方单位。"""
        total = self.stage_waves(stage)
        layouts = self.config.waves.get(total) or self.config.waves[max(self.config.waves)]
        layout = layouts[min(wave_index, len(layouts)) - 1]
        cap = min(len(ENEMY_POSITIONS),
                  self.config.enemy_cap_base + self.chapter_ordinal(stage['chapterId']) * self.config.enemy_cap_per_chapter)
        npcs = self.catalog['BaseNPCs']
        base = stage_id * 100 + (difficulty - 1) * 10
        elites = [slot for slot in (7, 8, 9) if str(base + slot) in npcs]
        boss = next((slot for slot in elites if npcs[str(base + slot)]['name'] == stage.get('bossName')), elites[0] if elites else 7)
        others = [slot for slot in elites if slot != boss]
        slots = []
        for spec in layout:
            if spec == 'boss':
                slots.append(boss)
            elif spec == 'elite':
                slots.append(others.pop(0) if others else boss)
            else:
                slots.append(spec)
        level = self.npc_level(stage_id, stage['chapterId'], difficulty)
        rule = self.config.difficulties[difficulty]
        power = self.config.npc_power.multiplier(self.chapter_ordinal(stage['chapterId']))
        units = []
        for position, slot in zip(ENEMY_POSITIONS, slots[:cap]):
            npc_id = base + slot
            npc = npcs.get(str(npc_id))
            if npc is None:
                continue
            role = 'boss' if slot == boss else ('elite' if slot in (7, 8, 9) else 'minion')
            template = self.archetype(npc.get('profession', 1), npc.get('quality', 1))
            attrs = self.heroes.base_attributes(template, level, 0, None, power * self.config.npc_role_multiplier[role])
            attrs['health'] *= rule.health_multiplier
            for attack in ('normalAttack', 'skillAttack'):
                attrs[attack] *= rule.attack_multiplier
            hp = max(1, int(attrs['health']))
            units.append(Unit(pos=position, side=1, name=npc['name'], attrs=attrs, npc_id=npc_id,
                              skill_id=npc.get('skillId', 0), skill_level=max(1, level // 10),
                              talent_id=npc.get('talentId', 0), weapon_id=npc.get('equipId', 0), hp=hp, hp_max=hp))
        if not units:
            raise BusinessError('本关缺少可用的NPC配置')
        return units

    def template_unit(self, hero_id: int, level: int, pos: int, side: int = 1, rebirth: int = 0,
                      multiplier: float = 1.0, rage_level: int = 1) -> Unit:
        """按英雄模板生成一个指定等级的单位（争霸机器人、他人阵容等）；怒气技吃进阶赠送等级。"""
        template = self.heroes.template(hero_id)
        attrs = self.heroes.base_attributes(template, max(1, level), rebirth, None, multiplier)
        hp = max(1, int(attrs['health']))
        return Unit(pos=pos, side=side, name=template['name'], attrs=attrs, hero_id=hero_id,
                    skill_id=template.get('skillId', 0), skill_level=rage_level + self.heroes.rage_bonus(template, rebirth),
                    talent_id=template.get('talentId', 0),
                    rebirth=rebirth, hp=hp, hp_max=hp, rage=self.hero_config.rage.initial)

    def npc_unit(self, npc_id: int, level: int, pos: int, multiplier: float = 1.0, hp_override: int = None) -> Unit:
        """按 NPC 编号生成敌方单位（副本、爬塔、妖王）；属性取同职业同品质英雄模板平均值成长。"""
        npc = self.catalog['BaseNPCs'].get(str(npc_id))
        if npc is None:
            raise BusinessError('NPC 配置不存在')
        template = self.archetype(npc.get('profession', 1), npc.get('quality', 1))
        attrs = self.heroes.base_attributes(template, max(1, level), 0, None, multiplier)
        hp = hp_override if hp_override is not None else max(1, int(attrs['health']))
        attrs['health'] = hp
        return Unit(pos=pos, side=1, name=npc['name'], attrs=attrs, npc_id=npc_id,
                    skill_id=npc.get('skillId', 0), skill_level=max(1, level // 10),
                    talent_id=npc.get('talentId', 0), weapon_id=npc.get('equipId', 0), hp=hp, hp_max=hp)

    # ---- 模拟 -------------------------------------------------------------

    def simulate(self, allies: List[Unit], enemies: List[Unit]) -> dict:
        units = allies + enemies
        # 客户端把 battleHeros 当作开场状态，必须在模拟前快照（血量、怒气均为初始值）。
        battle_heroes = [u.to_battle_hero() for u in units]
        records = []
        rage = self.hero_config.rage
        winner = None
        for round_no in range(1, self.config.round_limit + 1):
            order = sorted((u for u in units if u.alive), key=lambda u: (-u.attrs.get('speed', 0), u.pos))
            for actor in order:
                if not actor.alive:
                    continue
                foes = [u for u in units if u.side != actor.side and u.alive]
                friends = [u for u in units if u.side == actor.side and u.alive]
                if not foes:
                    break
                spec = None
                if actor.skill_id and actor.rage >= rage.cost:
                    skill = self.catalog['BaseSkills'].get(str(actor.skill_id))
                    if skill and skill.get('type') == SKILL_RAGE:
                        spec = parse_skill(skill.get('desc'), actor.skill_level)
                if spec is not None:
                    records.append(self._cast(round_no, actor, spec, foes, friends))
                else:
                    records.append(self._attack(round_no, actor, foes))
            if not any(u.alive for u in enemies):
                winner = 0
                break
            if not any(u.alive for u in allies):
                winner = 1
                break
        return dict(battleHeros=battle_heroes, battleRecords=records, isWin=winner == 0,
                    preBattle=[], battleArtifacts=[], em=0, ehalo=0)

    def _pick_default(self, foes: List[Unit]) -> Unit:
        front = [u for u in foes if u.pos in FRONT_ROW]
        pool = front or foes
        return min(pool, key=lambda u: u.pos)

    def _select(self, spec: SkillSpec, foes: List[Unit], friends: List[Unit]) -> List[Unit]:
        pool = friends if spec.own_side else foes
        if not pool:
            return []
        if spec.targeting == 'all':
            return list(pool)
        if spec.targeting == 'front':
            chosen = [u for u in pool if u.pos in FRONT_ROW]
            return chosen or [u for u in pool if u.pos not in FRONT_ROW]
        if spec.targeting == 'back':
            chosen = [u for u in pool if u.pos not in FRONT_ROW]
            return chosen or [u for u in pool if u.pos in FRONT_ROW]
        if spec.targeting == 'row':
            primary = self._pick_default(pool)
            return [u for u in pool if (u.pos in FRONT_ROW) == (primary.pos in FRONT_ROW)]
        if spec.targeting == 'highest':
            return [max(pool, key=lambda u: u.hp)]
        if spec.targeting == 'lowest':
            return [min(pool, key=lambda u: u.hp)]
        if spec.targeting == 'count':
            ordered = sorted(pool, key=lambda u: u.pos)
            return ordered[:spec.count]
        return [self._pick_default(pool)]

    def _roll(self, chance: float) -> bool:
        return chance > 0 and self.rng.random() < min(0.95, chance)

    def _hit(self, actor: Unit, target: Unit, attack_attr: str, defense_attr: str, percent: float):
        """计算一次攻击的伤害与效果；返回 ``(伤害, effect)``。"""
        hit_rule = self.config.hit
        scale = self.hero_config.secondary_attr_scale
        if self._roll((target.attrs.get('shanbi', 0) - actor.attrs.get('mingzhong', 0)) / scale):
            return 0, EFFECT_DODGE
        raw = actor.attrs.get(attack_attr, 0) * percent / 100 - target.attrs.get(defense_attr, 0) * hit_rule.defense_ratio
        damage = max(1.0, raw) * self.rng.uniform(1 - hit_rule.damage_variance, 1 + hit_rule.damage_variance)
        effect = EFFECT_NORMAL
        if self._roll((target.attrs.get('gedang', 0) - actor.attrs.get('poji', 0)) / scale):
            damage *= hit_rule.block_multiplier
            effect = EFFECT_BLOCK
        elif self._roll((actor.attrs.get('baoji', 0) - target.attrs.get('renxing', 0)) / scale):
            damage *= hit_rule.crit_multiplier
            effect = EFFECT_CRIT
        return max(1, int(round(damage))), effect

    def _gain_rage(self, unit: Unit, amount: int) -> int:
        before = unit.rage
        unit.rage = max(0, min(self.hero_config.rage.max, unit.rage + amount))
        return unit.rage - before

    def _attack(self, round_no: int, actor: Unit, foes: List[Unit]) -> dict:
        target = self._pick_default(foes)
        damage, effect = self._hit(actor, target, 'normalAttack', 'normalDefense', 100)
        dealt = min(target.hp, damage)
        target.hp -= dealt
        actor_rage = self._gain_rage(actor, self.hero_config.rage.gain_on_attack)
        target_rage = self._gain_rage(target, self.hero_config.rage.gain_on_hit) if target.alive else 0
        return dict(roundCount=round_no, Step=True, skillType=SKILL_NORMAL, posId=actor.pos, health=0,
                    rage=actor_rage, hpmax=0,
                    affectList=[dict(posId=target.pos, health=-dealt, rage=target_rage, hpmax=0, effect=effect, state=[])])

    def _cast(self, round_no: int, actor: Unit, spec: SkillSpec, foes: List[Unit], friends: List[Unit]) -> dict:
        targets = self._select(spec, foes, friends)
        affects = []
        for target in targets:
            if spec.kind == 'rage':
                gained = self._gain_rage(target, int(spec.percent))
                affects.append(dict(posId=target.pos, health=0, rage=gained, hpmax=0, effect=EFFECT_NORMAL, state=[]))
            elif spec.kind == 'heal':
                amount = int(actor.attrs.get('skillAttack', 0) * spec.percent / 100)
                healed = min(target.hp_max - target.hp, amount)
                target.hp += healed
                affects.append(dict(posId=target.pos, health=healed, rage=0, hpmax=0, effect=EFFECT_NORMAL, state=[]))
            else:
                damage, effect = self._hit(actor, target, 'skillAttack', 'skillDefense', spec.percent)
                dealt = min(target.hp, damage)
                target.hp -= dealt
                target_rage = self._gain_rage(target, self.hero_config.rage.gain_on_hit) if target.alive else 0
                affects.append(dict(posId=target.pos, health=-dealt, rage=target_rage, hpmax=0, effect=effect, state=[]))
        actor_rage = self._gain_rage(actor, -self.hero_config.rage.cost)
        return dict(roundCount=round_no, Step=True, skillType=SKILL_RAGE, posId=actor.pos, health=0,
                    rage=actor_rage, hpmax=0, affectList=affects)
