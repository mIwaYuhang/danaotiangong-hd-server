"""关卡：地图信息、多波次战斗结算、扫荡与冷却、章节宝箱、新手引导。

协议要点（客户端 BattleRequest / BattleData / PreviewBattleLayer）：
- ``/Battle/fight?cpId&ri&star``：``ri`` 为波次索引（从 1 起逐波请求），``star`` 为难度 1/2/3；
  每波返回一份战报，最后一波附带 ``BattleResult`` 与掉落；
- ``Point.Star`` 是该关已通关的最高难度，``COD`` 是今日已挑战次数（上限 ``battleMax``）；
- 可挑战难度 ≤ ``Point.Star + 1``；扫荡要求已通关该难度、玩家等级达标、无冷却；
- 章节宝箱按章节累计星数分三档领取。

多波次之间英雄的血量与怒气通过 ``state.BattleSession`` 延续。
"""
from copy import deepcopy

from ..config import BattleConfig, PlayerConfig, thaw
from ..errors import BusinessError
from .base import Reply, RoleContext, global_block
from .battle import BattleEngine
from .clock import Clock
from .inventory import Ledger
from .player_state import PlayerModel

CLAIMABLE, CLAIMED, LOCKED = 0, 1, 2
CLAIMS_KEY = 'LocalChapterClaims'
MAX_SWEEP = 10


class StageService:
    def __init__(self, rules: BattleConfig, player: PlayerConfig, recruit_claim_key: str,
                 catalog, ledger: Ledger, model: PlayerModel, engine: BattleEngine, clock: Clock, events=None):
        self.rules = rules
        self.player = player
        self.recruit_claim_key = recruit_claim_key
        self.catalog = catalog
        self.ledger = ledger
        self.model = model
        self.engine = engine
        self.clock = clock
        self.events = events  # 任务进度回调：events.on(state, kind, amount)

    # ---- 通用 -------------------------------------------------------------

    def stage(self, stage_id: int) -> dict:
        stage = self.catalog['BaseStages'].get(str(stage_id))
        if stage is None:
            raise BusinessError('关卡不存在')
        return stage

    @staticmethod
    def point(state: dict, stage_id: int):
        return next((p for p in state['Map']['Point'] if p['PID'] == stage_id), None)

    def ensure_point(self, state: dict, stage_id: int) -> dict:
        point = self.point(state, stage_id)
        if point is None:
            point = {'PID': stage_id, 'Star': 0, 'COD': 0}
            state['Map']['Point'].append(point)
        return point

    def map_info(self, ctx: RoleContext, params) -> dict:
        """``/MapInfo/GetMapInfo``。"""
        ctx.state['Map']['CdTime'] = Clock.remaining(ctx.state.get('CdUntil', 0), self.clock.now())
        ctx.state['Map']['BattleTenIngot'] = self.rules.sweep.clear_cd_ingot
        return deepcopy(ctx.state['Map'])

    def _check_entry(self, state: dict, stage_id: int, stage: dict, difficulty: int, sweeping=False):
        if difficulty not in self.rules.difficulties:
            raise BusinessError('难度不存在')
        if stage_id > state['Map']['MaxPID']:
            raise BusinessError('关卡尚未解锁')
        point = self.point(state, stage_id)
        star = point['Star'] if point else 0
        if sweeping:
            if star < difficulty:
                raise BusinessError('请先通关该难度后再扫荡')
        elif difficulty > star + 1:
            raise BusinessError('请先通关较低难度')
        if (point['COD'] if point else 0) >= stage['battleMax']:
            raise BusinessError('今日挑战次数已用完')

    # ---- 战斗 -------------------------------------------------------------

    def fight(self, ctx: RoleContext, params) -> Reply:
        """``/Battle/fight``：一次请求结算一波。"""
        stage_id, wave, difficulty = params['cpId'], params['ri'], params['star']
        state = ctx.state
        stage = self.stage(stage_id)
        total = self.engine.stage_waves(stage)
        session = state.get('BattleSession')
        if wave == 1:
            self._check_entry(state, stage_id, stage, difficulty)
            heroes = self.model.team_heroes(state)
            if not heroes:
                raise BusinessError('请先布置阵容')
            self.ledger.apply(state, consume=[dict(Type=9, ID=0, Count=stage['power'])])
            state['Daily']['battles'] = state['Daily'].get('battles', 0) + 1
            self._emit(state, 'battle_count_today', 1)
            session = {'cpId': stage_id, 'star': difficulty, 'wave': 0, 'total': total, 'units': {}}
        elif (not session or session['cpId'] != stage_id or session['star'] != difficulty
              or session['wave'] != wave - 1):
            raise BusinessError('战斗流程不一致，请重新进入关卡')
        if wave > total:
            raise BusinessError('波次超出范围')

        allies = [self.engine.hero_unit(h) for h in self.model.team_heroes(state)]
        for unit in allies:
            saved = session['units'].get(str(unit.pos))
            if saved:
                unit.hp, unit.rage = saved['hp'], saved['rage']
        enemies = self.engine.enemy_units(stage_id, stage, difficulty, wave)
        report = self.engine.simulate([u for u in allies if u.alive] or allies, enemies)
        # 不下发 enemy：该字段是 PVP 对手的 {Name, Vip} 对象，关卡战斗由客户端按 BaseStages.battleName 显示波次名
        report.update(total=total, dropList=[], Reward=[])
        session['units'] = {str(u.pos): {'hp': u.hp, 'rage': u.rage} for u in allies}
        session['wave'] = wave

        if not report['isWin']:
            state['BattleSession'] = None
            report['BattleResult'] = self._battle_result(state, stage_id, False, [])
            return Reply(report, global_block(self.ledger.resource(state)))
        if wave < total:
            state['BattleSession'] = session
            report['BattleResult'] = self._battle_result(state, stage_id, False, [])
            return Reply(report, global_block(self.ledger.resource(state)))

        state['BattleSession'] = None
        outcome, hero_exps, first = self._settle(state, stage_id, stage, difficulty, allow_first_bonus=True)
        report['dropList'] = deepcopy(outcome.rewards)
        report['BattleResult'] = self._battle_result(state, stage_id, first, hero_exps)
        return Reply(report, self.ledger.global_for(state, outcome, Slots=self.model.slots(state)))

    def _settle(self, state: dict, stage_id: int, stage: dict, difficulty: int, allow_first_bonus: bool):
        """通关结算：银币、玩家经验、英雄经验、掉落、进度。返回 ``(Outcome, HeroExps, 是否首通)``。"""
        rule = self.rules.difficulties[difficulty]
        point = self.ensure_point(state, stage_id)
        first = point['Star'] == 0
        exp = int(stage['expMin'][str(difficulty)])
        if state.get('HaveDoubleExpTime', 0) > 0:
            exp *= 2
        rewards = [dict(Type=1, ID=0, Count=int(stage['coinMin'][str(difficulty)])),
                   dict(Type=3, ID=0, Count=exp)]
        for item in stage.get('dropList', {}).values():
            chance = self.rules.drop_chance.get(item['Type'], 0) * rule.drop_multiplier
            if self.ledger.rng.random() < chance:
                rewards.append(dict(Type=item['Type'], ID=item['ID'], Count=item['Count'], Level=item.get('Level')))
        if first and allow_first_bonus:
            rewards.extend(thaw(self.rules.first_clear_bonus.get(stage_id, ())))
        outcome = self.ledger.apply(state, rewards=rewards)
        hero_exp = int(exp * self.rules.hero_exp_ratio)
        hero_exps = []
        for hero in self.model.team_heroes(state):
            gained = self.model.heroes.add_experience(hero, hero_exp, state['PLevel'])
            self.model.refresh_hero(state, hero)
            hero_exps.append(dict(Id=hero['heroId'], Level=hero['level'], CurExp=hero['curExp'],
                                  NextLvExp=hero['totalExp'], GetExp=gained))
        point = self.ensure_point(state, stage_id)
        point['Star'] = max(point['Star'], difficulty)
        point['COD'] = point.get('COD', 0) + 1
        state['Map']['MaxPID'] = max(state['Map']['MaxPID'], self.catalog.next_stage_id(stage_id))
        self._emit(state, 'stage_clear', stage_id)
        return outcome, hero_exps, first

    def _battle_result(self, state: dict, stage_id: int, first: bool, hero_exps: list) -> dict:
        point = self.point(state, stage_id)
        return dict(IsFirst=first, IsSkip=False, Star=point['Star'] if point else 0,
                    TodayWinCount=point.get('COD', 0) if point else 0, NextCheckpoint=state['Map']['MaxPID'],
                    Level=state['PLevel'], CurExp=state['Exp'], NextLvExp=state['NextLvExp'],
                    HeroExps=hero_exps or [dict(Id=h['heroId'], Level=h['level'], CurExp=h['curExp'],
                                                NextLvExp=h['totalExp'], GetExp=0)
                                           for h in self.model.team_heroes(state)])

    # ---- 扫荡 -------------------------------------------------------------

    def sweep(self, ctx: RoleContext, params) -> Reply:
        """``/Battle/BattleTen``：一次扫荡至多 10 次，不模拟战斗。"""
        stage_id, difficulty = params['cpId'], params['star']
        state = ctx.state
        stage = self.stage(stage_id)
        rule = self.rules.sweep
        if state['PLevel'] < rule.required_level:
            raise BusinessError(f'{rule.required_level}级开放扫荡')
        if Clock.remaining(state.get('CdUntil', 0), self.clock.now()) > 0:
            raise BusinessError('扫荡冷却中')
        self._check_entry(state, stage_id, stage, difficulty, sweeping=True)
        point = self.ensure_point(state, stage_id)
        times = min(MAX_SWEEP, stage['battleMax'] - point['COD'])
        if times <= 0:
            raise BusinessError('今日挑战次数已用完')
        self.ledger.apply(state, consume=[dict(Type=9, ID=0, Count=stage['power'] * times)])
        operators, rewards, consume, talismans = [], [], [], []
        for _ in range(times):
            outcome, hero_exps, _first = self._settle(state, stage_id, stage, difficulty, allow_first_bonus=False)
            rewards.extend(outcome.rewards)
            talismans.extend(outcome.talismans)
            operators.append({'Operator': {'GetExp': next((r['Count'] for r in outcome.rewards if r['Type'] == 3), 0),
                                           'HeroExps': hero_exps, 'dropList': deepcopy(outcome.rewards)}})
        state['Daily']['battles'] = state['Daily'].get('battles', 0) + times
        self._emit(state, 'battle_count_today', times)
        state['CdUntil'] = self.clock.now() + rule.cooldown_seconds
        state['Map']['CdTime'] = rule.cooldown_seconds
        block = global_block(self.ledger.resource(state), rewards, consume, Slots=self.model.slots(state))
        if talismans:
            block['Talismans'] = talismans
        point = self.ensure_point(state, stage_id)
        return Reply({'cdTime': rule.cooldown_seconds, 'TodayWinCount': point['COD'],
                      'BattleTenIngot': rule.clear_cd_ingot, 'battleResult': {'Operator': operators}}, block)

    def clear_cooldown(self, ctx: RoleContext, params) -> Reply:
        """``/Battle/SubCdTime``：花元宝清除扫荡冷却。"""
        state = ctx.state
        if Clock.remaining(state.get('CdUntil', 0), self.clock.now()) <= 0:
            raise BusinessError('当前没有冷却')
        outcome = self.ledger.apply(state, consume=[dict(Type=2, ID=0, Count=self.rules.sweep.clear_cd_ingot)])
        state['CdUntil'] = 0
        state['Map']['CdTime'] = 0
        return Reply({'CdTime': 0}, self.ledger.global_for(state, outcome))

    # ---- 章节宝箱 -----------------------------------------------------------

    def _chapter_statuses(self, state: dict, chapter: int) -> list:
        if str(chapter) not in self.catalog['BaseChapters']:
            raise BusinessError('章节不存在')
        stage_ids = {int(k) for k, v in self.catalog['BaseStages'].items() if v['chapterId'] == chapter}
        stars = sum(p['Star'] for p in state['Map']['Point'] if p['PID'] in stage_ids)
        claims = state.get(CLAIMS_KEY, [])
        statuses = []
        for tier, threshold in enumerate(self.rules.chapter_star_thresholds, 1):
            if f'{chapter}:{tier}' in claims:
                status = CLAIMED
            elif stars >= threshold:
                status = CLAIMABLE
            else:
                status = LOCKED
            statuses.append({'Star': tier, 'State': status})
        return statuses

    def chapter_status(self, ctx: RoleContext, params) -> dict:
        """``/Battle/IsSXRewar`` 与 ``/Battle/IsSXRewarNew``。"""
        return {'SanXinReward': self._chapter_statuses(ctx.state, params['Chapter']), 'ModulesData': []}

    def chapter_reward(self, ctx: RoleContext, params) -> Reply:
        """``/Battle/SXRewar``：领取章节宝箱。"""
        chapter, tier = params['Chapter'], params['star']
        statuses = {s['Star']: s['State'] for s in self._chapter_statuses(ctx.state, chapter)}
        if statuses.get(tier) != CLAIMABLE:
            raise BusinessError('章节奖励未达标或已领取，未发放')
        drops = self.catalog['BaseChapters'][str(chapter)].get('dropList', {}).get(str(tier), {})
        rewards = [dict(Type=x['Type'], ID=x['ID'], Count=x['Count'], Level=x.get('Level')) for x in drops.values()]
        outcome = self.ledger.apply(ctx.state, rewards=rewards)
        ctx.state.setdefault(CLAIMS_KEY, []).append(f'{chapter}:{tier}')
        return Reply({}, self.ledger.global_for(ctx.state, outcome))

    # ---- 新手引导 -----------------------------------------------------------

    def save_guide(self, ctx: RoleContext, params) -> Reply:
        """``/TiroGuide/save``：记录已完成的最大引导步骤，并推送真实阵容。"""
        step = params['stepno']
        state = ctx.state
        if step not in self.catalog['NSStep'].values() and step not in (0, 1):
            raise BusinessError('引导步骤无效')
        gate = self.player.recruit_gate_step
        if step >= gate and state.get('TiroMaxStep', 0) < gate and self.recruit_claim_key not in state:
            raise BusinessError('请先完成新手首抽再保存后续引导')
        state['TiroMaxStep'] = max(state.get('TiroMaxStep', 0), step)
        result = {'TiroMaxStep': state['TiroMaxStep']}
        if state['TiroMaxStep'] >= 1:
            # 下发全部 6 格：开场剧情阵容占用了 2/4/6 号位，必须逐位覆盖才能清掉
            return Reply(result, global_block(Slots=self.model.all_slots(state)))
        return Reply(result)

    def _emit(self, state: dict, kind: str, amount: int):
        if self.events is not None:
            self.events.on(state, kind, amount)
