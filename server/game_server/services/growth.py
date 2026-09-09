"""英雄成长：经验池升级、进阶、培养、将魂招募、技能训练。

- ``/Prop/HeroUpdLevel?heroId&addLv``：用经验池（``HeroExp``）升级，``addLv=-1`` 表示尽量升到玩家等级；
- ``/Prop/UseExpPill?heroId&props``：``props`` 为 ``道具ID:数量`` 逗号串，直接给英雄加经验；
- ``/Hero/Breakthrough?heroid``：消耗 ``rebirthList`` 中的材料与将魂，``rebirthCount+1``，奖励潜力点；
  引导期内初始英雄的首次进阶若材料不足，服务端补齐差额（客户端引导会强制进阶，失败会卡死）；
- ``/Hero/Train`` / ``/Hero/SaveTrain``：培养预览（随机四维增量）与保存；
- ``/hero/RecruitHero?soulId`` / ``/Hero/RecruitAll``：将魂数量达到 ``soulCount`` 即可招募；
- ``/Hero/skilltrain?heroid``：消耗阅历提升怒气技等级（客户端无对应界面，按推断实现）。
"""
from copy import deepcopy

from ..errors import BusinessError
from .base import Reply, RoleContext, global_block
from .inventory import Ledger, Outcome
from .player_state import PlayerModel

STATE_HERO_ERROR = -1116001
UNIVERSAL_SOUL_MATE = 200178
SKILL_TRAIN_KNOWLEDGE_BASE = 100


class HeroGrowthService:
    def __init__(self, model: PlayerModel, ledger: Ledger, events=None):
        self.model = model
        self.heroes = model.heroes
        self.ledger = ledger
        self.catalog = model.catalog
        self.events = events

    # ---- 升级 -------------------------------------------------------------

    def level_up(self, ctx: RoleContext, params) -> Reply:
        """``/Prop/HeroUpdLevel``。"""
        state = ctx.state
        hero = self.model.find_hero(state, params['heroId'])
        add = params['addLv']
        cap = state['PLevel']
        if hero['level'] >= cap:
            raise BusinessError('主将等级不能超过玩家等级', STATE_HERO_ERROR)
        levels = (cap - hero['level']) if add < 0 else min(add, cap - hero['level'])
        if levels <= 0:
            raise BusinessError('升级数量无效')
        pool = state.get('HeroExp', 0)
        if pool <= 0:
            raise BusinessError('主将经验池不足')
        need = self.heroes.exp_needed_for_levels(hero, levels)
        if add > 0 and pool < need:
            raise BusinessError('主将经验池不足')
        spend = min(pool, need)
        used = self.heroes.add_experience(hero, spend, cap)
        outcome = self.ledger.apply(state, consume=[dict(Type=30, ID=0, Count=used)] if used else [])
        hero = self.model.find_hero(state, hero['heroId'])
        self.model.refresh_hero(state, hero)
        outcome.heros.append(deepcopy(hero))
        return Reply({'Level': hero['level'], 'CurExp': hero['curExp'], 'NextLvExp': hero['totalExp']},
                     self.ledger.global_for(state, outcome, Slots=self.model.slots(state)))

    def use_exp_pills(self, ctx: RoleContext, params) -> Reply:
        """``/Prop/UseExpPill``：``props=道具ID:数量,...``。"""
        state = ctx.state
        hero = self.model.find_hero(state, params['heroId'])
        consume, total = [], 0
        exp_type = self.ledger.config.prop_effects.get('exp')
        for part in (params.get('props') or '').split(','):
            if not part:
                continue
            pieces = part.split(':')
            prop_id = self.ledger.positive(pieces[0])
            count = self.ledger.positive(pieces[1] if len(pieces) > 1 else '1', self.ledger.config.max_operation_count)
            prop = self.catalog['BaseProps'].get(str(prop_id))
            if prop is None or prop['propType'] != exp_type:
                raise BusinessError('不是经验丹')
            total += self.ledger.positive(prop['propValue']) * count
            consume.append(dict(Type=5, ID=prop_id, Count=count))
        if not consume:
            raise BusinessError('请选择经验丹')
        if hero['level'] >= state['PLevel']:
            raise BusinessError('主将等级不能超过玩家等级', STATE_HERO_ERROR)
        outcome = self.ledger.apply(state, consume=consume)
        hero = self.model.find_hero(state, hero['heroId'])
        used = self.heroes.add_experience(hero, total, state['PLevel'])
        self.model.refresh_hero(state, hero)
        outcome.heros.append(deepcopy(hero))
        return Reply({'GetExp': used}, self.ledger.global_for(state, outcome, Slots=self.model.slots(state)))

    # ---- 进阶 -------------------------------------------------------------

    def breakthrough(self, ctx: RoleContext, params) -> Reply:
        """``/Hero/Breakthrough``。"""
        state = ctx.state
        hero = self.model.find_hero(state, params['heroid'])
        template = self.heroes.template(hero['heroId'])
        next_count = hero.get('rebirthCount', 0) + 1
        if next_count > self.heroes.rebirth_max(template):
            raise BusinessError('已达进阶上限', STATE_HERO_ERROR)
        gate = self.heroes.rebirth_level_gate(next_count)
        if hero['level'] < gate:
            raise BusinessError(f'主将需要达到 {gate} 级才能进阶', STATE_HERO_ERROR)
        stage = self.heroes.rebirth_stage(template, next_count)
        consume, gifts = [], []
        if stage.get('mateId') and stage.get('mateCount'):
            mate_id, need = int(stage['mateId']), int(stage['mateCount'])
            have = self.ledger.bag_count(state, 6, mate_id)
            if have < need and self._guide_protected(state, hero):
                # 引导期的首次进阶是强制流程，材料不足时补齐，避免客户端卡死
                gifts.append(dict(Type=6, ID=mate_id, Count=need - have))
            consume.append(dict(Type=6, ID=mate_id, Count=need))
        if stage.get('soulId') and stage.get('soulCount'):
            soul_id, need = int(stage['soulId']), int(stage['soulCount'])
            have = self.ledger.bag_count(state, 4, soul_id)
            if have >= need:
                consume.append(dict(Type=4, ID=soul_id, Count=need))
            else:
                # 不足部分用万能魂补齐
                if have:
                    consume.append(dict(Type=4, ID=soul_id, Count=have))
                consume.append(dict(Type=6, ID=UNIVERSAL_SOUL_MATE, Count=need - have))
        if gifts:
            self.ledger.apply(state, rewards=gifts)
        outcome = self.ledger.apply(state, consume=consume)
        outcome.rewards.extend(gifts)
        hero = self.model.find_hero(state, hero['heroId'])
        hero['rebirthCount'] = next_count
        hero['potency'] = hero.get('potency', 0) + self.heroes.rebirth_potency(stage)
        self.model.refresh_hero(state, hero)
        state['Counters']['breakthrough_count'] = state['Counters'].get('breakthrough_count', 0) + 1
        self._emit(state, 'breakthrough_count', 1)
        outcome.heros.append(deepcopy(hero))
        return Reply({'RebirthCount': next_count}, self.ledger.global_for(state, outcome, Slots=self.model.slots(state)))

    def _guide_protected(self, state: dict, hero: dict) -> bool:
        """引导期（TiroMaxStep 未到 protect_until_step）内初始英雄的首次进阶受保护。"""
        return (state.get('TiroMaxStep', 0) < self.model.config.guide_protect_until_step
                and hero.get('rebirthCount', 0) == 0 and hero['heroId'] in self.model.starter_ids())

    # ---- 培养 -------------------------------------------------------------

    def train(self, ctx: RoleContext, params) -> Reply:
        """``/Hero/Train?heroID&count&isspecial``：生成四维增量预览，暂存到 ``TrainPending``。"""
        state = ctx.state
        hero = self.model.find_hero(state, params['heroID'])
        count = params['count']
        if count not in (1, 10):
            raise BusinessError('培养次数只能为 1 或 10')
        special = str(params.get('isspecial') or '').lower() == 'true'
        mode = self.heroes.config.train_special if special else self.heroes.config.train_normal
        consume = [dict(Type=11, ID=0, Count=mode.train_pill * count)]
        if mode.ingot * count:
            consume.append(dict(Type=2, ID=0, Count=mode.ingot * count))
        if hero.get('potency', 0) < mode.potency * count:
            raise BusinessError('潜力点不足，请先进阶获取潜力')
        outcome = self.ledger.apply(state, consume=consume)
        hero = self.model.find_hero(state, hero['heroId'])
        hero['potency'] -= mode.potency * count
        cap = hero['level'] * self.heroes.config.train_dimension_cap_per_level
        rng = self.ledger.rng
        changed = {}
        for dim, key in (('physical', 'Con'), ('strength', 'Str'), ('mana', 'Inte'), ('agility', 'Agility')):
            delta = sum(rng.randint(mode.min_delta, mode.max_delta) for _ in range(count))
            current = hero['trainDims'].get(dim, 0)
            delta = max(-current, min(delta, cap - current))
            changed[key] = delta
        state['TrainPending'][str(hero['heroId'])] = changed
        self.model.refresh_hero(state, hero)
        outcome.heros.append(deepcopy(hero))
        return Reply({'Operator': {'Changed': changed}}, self.ledger.global_for(state, outcome))

    def save_train(self, ctx: RoleContext, params) -> Reply:
        """``/Hero/SaveTrain?heroID``：接受培养预览。"""
        state = ctx.state
        hero = self.model.find_hero(state, params['heroID'])
        pending = state['TrainPending'].pop(str(hero['heroId']), None)
        if pending is None:
            raise BusinessError('没有待保存的培养结果')
        for dim, key in (('physical', 'Con'), ('strength', 'Str'), ('mana', 'Inte'), ('agility', 'Agility')):
            hero['trainDims'][dim] = hero['trainDims'].get(dim, 0) + pending.get(key, 0)
        self.model.refresh_hero(state, hero)
        return Reply({}, global_block(self.ledger.resource(state), Slots=self.model.slots(state), Heros=[deepcopy(hero)]))

    # ---- 将魂招募 -----------------------------------------------------------

    def _recruitable(self, state: dict, soul_id: int):
        soul = self.catalog['BaseSouls'].get(str(soul_id))
        if soul is None:
            raise BusinessError('将魂不存在')
        hero_id = int(soul['figureId'])
        template = self.heroes.template(hero_id)
        need = int(template.get('soulCount', 0)) or 1
        return hero_id, need

    def recruit_by_soul(self, ctx: RoleContext, params) -> Reply:
        """``/hero/RecruitHero?soulId``。"""
        state = ctx.state
        soul_id = params['soulId']
        hero_id, need = self._recruitable(state, soul_id)
        if self.model.has_hero(state, hero_id):
            raise BusinessError('已拥有该主将', STATE_HERO_ERROR)
        if self.ledger.bag_count(state, 4, soul_id) < need:
            raise BusinessError('将魂数量不足')
        outcome = self.ledger.apply(state, rewards=[dict(Type=7, ID=hero_id, Count=1)],
                                    consume=[dict(Type=4, ID=soul_id, Count=need)])
        self._emit(state, 'hero_count', len(state['ownedHeros']))
        return Reply({'Reward': deepcopy(outcome.rewards)}, self.ledger.global_for(state, outcome))

    def recruit_all(self, ctx: RoleContext, params) -> Reply:
        """``/Hero/RecruitAll``：招募所有将魂足够的主将。"""
        state = ctx.state
        rewards, consume = [], []
        for item in list(state.get('Others', [])):
            if item['Type'] != 4:
                continue
            hero_id, need = self._recruitable(state, item['ID'])
            if item['Count'] >= need and not self.model.has_hero(state, hero_id):
                rewards.append(dict(Type=7, ID=hero_id, Count=1))
                consume.append(dict(Type=4, ID=item['ID'], Count=need))
        if not rewards:
            raise BusinessError('没有可招募的主将')
        outcome = self.ledger.apply(state, rewards=rewards, consume=consume)
        self._emit(state, 'hero_count', len(state['ownedHeros']))
        return Reply({'Reward': deepcopy(outcome.rewards)}, self.ledger.global_for(state, outcome))

    # ---- 技能训练 -----------------------------------------------------------

    def skill_train(self, ctx: RoleContext, params) -> Reply:
        """``/Hero/skilltrain?heroid``：怒气技等级不超过主将等级，每级消耗阅历 = 100 × 当前等级。"""
        state = ctx.state
        hero = self.model.find_hero(state, params['heroid'])
        level = hero.get('rageSkillLevel', 1)
        if level >= hero['level']:
            raise BusinessError('技能等级不能超过主将等级', STATE_HERO_ERROR)
        outcome = self.ledger.apply(state, consume=[dict(Type=18, ID=0, Count=SKILL_TRAIN_KNOWLEDGE_BASE * level)])
        hero = self.model.find_hero(state, hero['heroId'])
        hero['rageSkillLevel'] = level + 1
        self.model.refresh_hero(state, hero)
        outcome.heros.append(deepcopy(hero))
        return Reply({'SkillLevel': hero['rageSkillLevel']},
                     self.ledger.global_for(state, outcome, Slots=self.model.slots(state)))

    def transfer_stub(self, ctx: RoleContext, params):
        """``/hero/transferpower``：客户端无对应界面，缺少可验证的协议。"""
        raise BusinessError('主将继承功能尚未开放')

    def _emit(self, state: dict, kind: str, amount: int):
        if self.events is not None:
            self.events.on(state, kind, amount)
