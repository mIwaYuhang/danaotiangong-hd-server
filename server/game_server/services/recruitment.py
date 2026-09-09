"""招募（寻将）：三个卡池、免费冷却、元宝单抽/十连、橙色保底、重复英雄转将魂、新手首抽。

协议（客户端 StoreHeroLayer / DlgStoreHeroLayer）：
- ``/Store/StoreHeroRecruitInfo``：``[{Type, NeedIngot, HaveTimes, HaveOrangeTime?, TenPrice, bGenericD, bFTenD, bSTenD, VipLv, FESET}]``，
  ``HaveTimes`` 为距免费的秒数（0 表示可免费）；
- ``/Store/StoreHeroRecruit?type[&count=10]``：``Result`` 含 ``Type/NeedIngot/HaveTimes/Reward/IsChange``，十连另有 ``TenLst``；
  抽到已拥有英雄时 ``Reward`` 为将魂（Type 4）；``IsChange=1`` 触发新手换阵引导。
新手引导期间 Type 3 首抽免费且按配置顺序确定发放（结果记录在状态中，重复请求原样重放）。
"""
from copy import deepcopy

from ..config import RecruitmentConfig
from ..errors import BusinessError
from .base import Reply, RoleContext
from .clock import Clock
from .inventory import Ledger, Outcome
from .player_state import PlayerModel


class RecruitmentService:
    def __init__(self, config: RecruitmentConfig, model: PlayerModel, ledger: Ledger, clock: Clock, events=None):
        self.config = config
        self.model = model
        self.ledger = ledger
        self.clock = clock
        self.catalog = model.catalog
        self.events = events

    # ---- 资格与展示 -----------------------------------------------------------

    def newbie_eligible(self, state: dict) -> bool:
        low, high = self.config.newbie.eligible_step_range
        return low <= state.get('TiroMaxStep', 0) < high and self.config.newbie.claim_key not in state

    def free_remaining(self, state: dict, pool_type: int) -> int:
        pool = self.config.pools[pool_type]
        if pool.free_interval <= 0:
            return 2147483647
        last = state['Recruit']['last_free'].get(str(pool_type), 0)
        return Clock.remaining(last + pool.free_interval, self.clock.now())

    def pool_info(self, state: dict, pool_type: int) -> dict:
        pool = self.config.pools[pool_type]
        remaining = self.free_remaining(state, pool_type)
        if pool_type == 3 and self.newbie_eligible(state):
            remaining = 0
        info = dict(Type=pool_type, NeedIngot=pool.price, HaveTimes=remaining,
                    TenPrice=int(round(pool.price * 10 * pool.ten_discount)), VipLv=state.get('VipLevel', 0))
        info.update(self.config.response_flags)
        if pool.orange_pity:
            info['HaveOrangeTime'] = max(0, pool.orange_pity - state['Recruit'].get('orange_counter', 0))
        return info

    def pools(self, ctx: RoleContext, params) -> list:
        """``/Store/StoreHeroRecruitInfo``。"""
        return [self.pool_info(ctx.state, t) for t in sorted(self.config.pools)]

    # ---- 抽取 -------------------------------------------------------------

    def _roll_hero(self, pool, force_orange=False) -> int:
        heroes = self.catalog['BaseHeros']
        weights = {q: w for q, w in pool.quality_weights.items() if w > 0}
        quality = 4 if force_orange else self.ledger.rng.choices(list(weights), weights=list(weights.values()), k=1)[0]
        candidates = sorted(int(k) for k, v in heroes.items() if v['quality'] == quality)
        if not candidates:
            candidates = sorted(int(k) for k in heroes)
        return self.ledger.rng.choice(candidates)

    def _draw(self, state: dict, pool_type: int, count: int) -> Outcome:
        pool = self.config.pools[pool_type]
        rewards = []
        for _ in range(count):
            force = bool(pool.orange_pity) and state['Recruit'].get('orange_counter', 0) + 1 >= pool.orange_pity
            hero_id = self._roll_hero(pool, force)
            if pool.orange_pity:
                orange = self.catalog['BaseHeros'][str(hero_id)]['quality'] >= 4
                state['Recruit']['orange_counter'] = 0 if orange else state['Recruit'].get('orange_counter', 0) + 1
            rewards.append(dict(Type=7, ID=hero_id, Count=1))
        return self.ledger.apply(state, rewards=rewards)

    def recruit(self, ctx: RoleContext, params) -> Reply:
        """``/Store/StoreHeroRecruit``。"""
        state = ctx.state
        raw_type = params.get('type') or ''
        if not raw_type.isdigit() or int(raw_type) not in self.config.pools:
            raise BusinessError('卡池不存在')
        pool_type = int(raw_type)
        raw_count = params.get('count') or '1'
        if raw_count not in ('1', '10'):
            raise BusinessError('抽取次数只能为 1 或 10')
        count = int(raw_count)
        pool = self.config.pools[pool_type]
        claim_key = self.config.newbie.claim_key
        if pool_type == 3 and count == 1 and claim_key in state and state[claim_key].get('pending_replay'):
            return self._replay(state)
        if pool_type == 3 and count == 1 and self.newbie_eligible(state):
            return self._newbie_recruit(state)

        free = count == 1 and self.free_remaining(state, pool_type) == 0
        if free:
            consume = []
            state['Recruit']['last_free'][str(pool_type)] = self.clock.now()
        else:
            price = pool.price if count == 1 else int(round(pool.price * 10 * pool.ten_discount))
            consume = [dict(Type=2, ID=0, Count=price)] if price else []
        cost_outcome = self.ledger.apply(state, consume=consume)
        outcome = self._draw(state, pool_type, count)
        outcome.consume = cost_outcome.consume
        state['Daily']['recruits'] = state['Daily'].get('recruits', 0) + count
        state['Counters']['recruit_count'] = state['Counters'].get('recruit_count', 0) + count
        self._emit(state, 'recruit_count', count)
        self._emit(state, 'recruit_today', count)
        self._emit(state, 'hero_count', len(state['ownedHeros']))
        result = dict(self.pool_info(state, pool_type), Reward=deepcopy(outcome.rewards[:1]), Consume=deepcopy(outcome.consume), IsChange=0)
        if count > 1:
            result['TenLst'] = deepcopy(outcome.rewards)
        return Reply(result, self.ledger.global_for(state, outcome))

    # ---- 新手首抽 -----------------------------------------------------------

    def _newbie_recruit(self, state: dict) -> Reply:
        newbie = self.config.newbie
        owned = {h['heroId'] for h in state['ownedHeros']}
        heroes = self.catalog['BaseHeros']
        low, high = newbie.quality_range
        hero_id = next((h for h in newbie.candidate_hero_ids
                        if h not in owned and str(h) in heroes and low <= heroes[str(h)]['quality'] <= high), None)
        if hero_id is None:
            raise BusinessError('没有可发放的新手主将')
        outcome = self.ledger.apply(state, rewards=[dict(Type=7, ID=hero_id, Count=1)])
        state['Counters']['recruit_count'] = state['Counters'].get('recruit_count', 0) + 1
        self._emit(state, 'recruit_count', 1)
        self._emit(state, 'hero_count', len(state['ownedHeros']))
        result = dict(self.pool_info(state, 3), Reward=deepcopy(outcome.rewards), Consume=[], IsChange=0)
        block = self.ledger.global_for(state, outcome)
        state[newbie.claim_key] = dict(heroId=hero_id, result=deepcopy(result), global_=deepcopy(block), pending_replay=True)
        result['HaveTimes'] = self.free_remaining(state, 3)
        return Reply(result, block)

    def _replay(self, state: dict) -> Reply:
        """新手首抽的重放：客户端可能因丢包重试，直到引导推进（TiroMaxStep ≥ 门槛）前原样返回。"""
        claim = state[self.config.newbie.claim_key]
        low, high = self.config.newbie.eligible_step_range
        if state.get('TiroMaxStep', 0) >= high:
            claim['pending_replay'] = False
            raise BusinessError('新手首抽已领取')
        if 'response' in claim:  # 旧版存档
            payload = deepcopy(claim['response'])
            return Reply(payload, payload.pop('_global', None))
        return Reply(deepcopy(claim['result']), deepcopy(claim['global_']))

    def _emit(self, state: dict, kind: str, amount: int):
        if self.events is not None:
            self.events.on(state, kind, amount)
