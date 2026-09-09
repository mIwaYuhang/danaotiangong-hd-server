"""运营活动：签到、每日征收与活动礼包、七日登录、等级礼包、月卡、跑马灯、充值桩。

所有奖励数据来自 ``activities.json``；领取状态记录在角色状态中并按游戏日 / 月份重置。
"""
from copy import deepcopy

from ..config import ActivitiesConfig, thaw
from ..errors import BusinessError
from .base import Reply, RoleContext, SessionContext
from .clock import Clock
from .inventory import Ledger

STATE_SIGN_DONE = -1124001
STATE_REWARD_TAKEN = -1131001
STATE_LEVEL_GIFT = -1140001
SEVEN_CLAIMABLE, SEVEN_CLAIMED, SEVEN_LOCKED = 1, 2, 3


class ActivityService:
    def __init__(self, config: ActivitiesConfig, ledger: Ledger, clock: Clock, events=None):
        self.config = config
        self.ledger = ledger
        self.clock = clock
        self.events = events

    # ---- 签到 -------------------------------------------------------------

    def _sign(self, state: dict) -> dict:
        sign = state['Sign']
        month = self.clock.month_key()
        if sign.get('month') != month:
            state['Sign'] = sign = {'month': month, 'days': 0, 'last_day': ''}
        return sign

    def sign_info(self, ctx: RoleContext, params) -> dict:
        """``/SignMonth/GetSignInfoNew``。"""
        sign = self._sign(ctx.state)
        rewards = self.config.sign_rewards
        return {'SingRewardLst': [{'vip': self.config.sign_vip_double_level, 'reward': thaw(rewards[i % len(rewards)])}
                                  for i in range(31)],
                'MonthSignDay': sign['days'], 'HaveGetTime': 0 if sign['last_day'] == self.clock.day_key() else 1,
                'Day': self.clock.day_of_month()}

    def sign(self, ctx: RoleContext, params) -> Reply:
        """``/SignMonth/SignMonthNew``。"""
        state = ctx.state
        sign = self._sign(state)
        today = self.clock.day_key()
        if sign['last_day'] == today:
            raise BusinessError('今日已签到', STATE_SIGN_DONE)
        rewards = self.config.sign_rewards
        reward = thaw(rewards[sign['days'] % len(rewards)])
        if state.get('VipLevel', 0) >= self.config.sign_vip_double_level:
            reward = reward + deepcopy(reward)
        outcome = self.ledger.apply(state, rewards=reward)
        sign = self._sign(state)
        sign['days'] += 1
        sign['last_day'] = today
        state['Daily']['sign_done'] = True
        self._emit(state, 'sign_today', 1)
        return Reply({'HaveGetTime': 0, 'MonthSignDay': sign['days']}, self.ledger.global_for(state, outcome))

    # ---- 每日征收 -----------------------------------------------------------

    def _salary(self, state: dict) -> dict:
        rule = self.config.salary
        level = state['PLevel']
        reward = [dict(Type=1, ID=0, Count=rule['base_gold'] + level * rule['gold_per_level']),
                  dict(Type=18, ID=0, Count=rule['base_knowledge'] + level * rule['knowledge_per_level'])]
        return {'ContinuousDay': state['Login'].get('days', 1), 'AllDay': state['Login'].get('days', 1),
                'ToDay': 1 if state['Daily'].get('salary_taken') else 0,
                'CountDown': self.clock.seconds_until_next_day(), 'Reward': reward}

    def _gift_bags(self, state: dict) -> list:
        bags = []
        for bag in self.config.salary_gift_bags:
            item = {k: v for k, v in thaw(bag).items() if k != 'reward'}
            item['DayNuber'] = 1 if bag['GifBagID'] in state['Daily'].get('gift_bags', []) else 0
            item['PlayerVipLevel'] = state.get('VipLevel', 0)
            item['PlayerLevel'] = state['PLevel']
            bags.append(item)
        return bags

    def salary_info(self, ctx: RoleContext, params) -> dict:
        """``/EverydayReward/GetDayRewar``。"""
        return self._salary(ctx.state)

    def everyday_info(self, ctx: RoleContext, params) -> dict:
        """``/PlayerEverydayReward/EveryDayRewarInfo``。"""
        return {'Salary': self._salary(ctx.state), 'GiftBag': self._gift_bags(ctx.state)}

    def take_salary(self, ctx: RoleContext, params) -> Reply:
        """``/EverydayReward/GetToDayRewar``。"""
        state = ctx.state
        if state['Daily'].get('salary_taken'):
            raise BusinessError('今日已领取', STATE_REWARD_TAKEN)
        info = self._salary(state)
        outcome = self.ledger.apply(state, rewards=info['Reward'])
        state['Daily']['salary_taken'] = True
        return Reply(self._salary(state), self.ledger.global_for(state, outcome))

    def take_gift_bag(self, ctx: RoleContext, params) -> Reply:
        """``/EverydayReward/GetActivity?id``。"""
        state = ctx.state
        bag = next((b for b in self.config.salary_gift_bags if b['GifBagID'] == params['id']), None)
        if bag is None:
            raise BusinessError('礼包不存在')
        if bag['GifBagID'] in state['Daily'].get('gift_bags', []):
            raise BusinessError('今日已领取该礼包', STATE_REWARD_TAKEN)
        if state['PLevel'] < bag['MustPlayerLevel'] or state.get('VipLevel', 0) < bag['MustPlayerVipLevel']:
            raise BusinessError('尚未满足领取条件')
        if state['Login'].get('days', 0) < bag['MustDayNuber']:
            raise BusinessError('登录天数不足')
        outcome = self.ledger.apply(state, rewards=thaw(bag['reward']))
        state['Daily'].setdefault('gift_bags', []).append(bag['GifBagID'])
        return Reply({}, self.ledger.global_for(state, outcome))

    # ---- 七日登录 -----------------------------------------------------------

    def _seven(self, state: dict) -> list:
        days = state['Login'].get('days', 0)
        claimed = state['Login'].get('claimed', [])
        result = []
        for index, reward in enumerate(self.config.seven_day_login, 1):
            status = SEVEN_CLAIMED if index in claimed else (SEVEN_CLAIMABLE if days >= index else SEVEN_LOCKED)
            result.append({'Time': index, 'Status': status, 'RewardS': thaw(reward)})
        return result

    def seven_day_info(self, ctx: RoleContext, params) -> dict:
        """``/loginreward/SDHRewards``。"""
        return {'GetSverDaysReward': self._seven(ctx.state)}

    def seven_day_claim(self, ctx: RoleContext, params) -> Reply:
        """``/loginreward/getReward?day``。"""
        state = ctx.state
        day = params['day']
        entry = next((e for e in self._seven(state) if e['Time'] == day), None)
        if entry is None:
            raise BusinessError('奖励不存在')
        if entry['Status'] == SEVEN_CLAIMED:
            raise BusinessError('奖励已领取', STATE_REWARD_TAKEN)
        if entry['Status'] == SEVEN_LOCKED:
            raise BusinessError('登录天数不足')
        outcome = self.ledger.apply(state, rewards=entry['RewardS'])
        state['Login'].setdefault('claimed', []).append(day)
        return Reply({'GetSverDaysReward': self._seven(state)}, self.ledger.global_for(state, outcome))

    def seven_day_claimable(self, state: dict) -> int:
        return sum(1 for e in self._seven(state) if e['Status'] == SEVEN_CLAIMABLE)

    # ---- 等级礼包 -----------------------------------------------------------

    def _level_gifts(self, state: dict) -> list:
        claimed = state.get('LevelGiftClaims', [])
        return [{'Level': g['Level'], 'RewardResponse': thaw(g['reward']),
                 'IsGetStatus': 1 if state['PLevel'] >= g['Level'] else 0}
                for g in self.config.level_gifts if g['Level'] not in claimed]

    def level_gift_info(self, ctx: RoleContext, params) -> list:
        """``/LevelGiftBag/GetLevelGiftBagInfo``。"""
        return self._level_gifts(ctx.state)

    def level_gift_claim(self, ctx: RoleContext, params) -> Reply:
        """``/LevelGiftBag/GetLevelGiftBagReward?level``。"""
        state = ctx.state
        level = params['level']
        gift = next((g for g in self.config.level_gifts if g['Level'] == level), None)
        if gift is None or level in state.get('LevelGiftClaims', []):
            raise BusinessError('礼包不存在或已领取', STATE_LEVEL_GIFT)
        if state['PLevel'] < level:
            raise BusinessError('等级不足')
        outcome = self.ledger.apply(state, rewards=thaw(gift['reward']))
        state.setdefault('LevelGiftClaims', []).append(level)
        return Reply({}, self.ledger.global_for(state, outcome))

    def level_gift_claimable(self, state: dict) -> int:
        return sum(1 for g in self._level_gifts(state) if g['IsGetStatus'])

    def growup_info(self, ctx: RoleContext, params) -> dict:
        """``/LevelGiftBag/GetGrowupInfo``：成长计划（本地服未开放购买）。"""
        return {'IsBuy': 0, 'Rewards': [], 'Price': 0}

    # ---- 月卡与充值桩 -----------------------------------------------------------

    def month_card_info(self, ctx: RoleContext, params) -> dict:
        """``/Monthcard/GetMonthcardInfo``。"""
        info = thaw(self.config.month_card)
        info.update(WeekCountdown=0, MonthCountdown=0, IsBuyMonthCard=0, HaveMonthCardTimes=0)
        return info

    def unavailable(self, ctx: RoleContext, params):
        """需要支付渠道的功能。"""
        raise BusinessError('本地服没有支付渠道，该功能未开放')

    def recharge_list(self, ctx: RoleContext, params) -> list:
        """``/Recharge/RechargeLst``。"""
        return []

    def first_recharge_info(self, ctx: RoleContext, params) -> dict:
        """``/Recharge/firstreward``。"""
        return {'IsRecharge': 0, 'IsGet': 0, 'Reward': []}

    # ---- 公告 -------------------------------------------------------------

    def marquee(self, ctx: SessionContext, params) -> list:
        """``/Message/Messages``：跑马灯公告。"""
        now = self.clock.now()
        return [dict(content=item['content'], time=now, repeatNumber=item['repeatNumber']) for item in self.config.marquee]

    def _emit(self, state: dict, kind: str, amount: int):
        if self.events is not None:
            self.events.on(state, kind, amount)
