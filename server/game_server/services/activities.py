"""运营活动：签到、征收、七日登录、等级礼包、月卡、成长计划、伪充值与 VIP、跑马灯。

所有奖励数据来自 ``data/config/activities/*.json``（一个活动一个文件）；
领取状态记录在角色状态中并按游戏日 / 月份重置。

伪充值：``/Recharge/GetOrderID?money`` 匹配档位后立即入账（元宝 = Ingot + ExtreIngot），
回包 ``Global.Resource.RL`` 让客户端触发充值成功事件；``recharge.enabled`` 为总开关。
VIP 等级按累计购买的基础元宝对照 ``vip_thresholds`` 计算，``VipExp`` 为到下一级的进度百分比、
``NextVipExp`` 为还差的元宝（客户端「再购买 N 元宝成为 VIPn+1」）。
"""
from copy import deepcopy

from ..config import ActivitiesConfig, thaw
from ..errors import BusinessError
from .base import Reply, RoleContext, SessionContext
from .clock import Clock
from .inventory import Ledger, Outcome

STATE_SIGN_DONE = -1124001
STATE_REWARD_TAKEN = -1131001
STATE_LEVEL_GIFT = -1140001
STATE_NOT_CHARGED = -1105004      # 客户端 PlayerNotCharge：弹「还没有任何充值」并引导去充值页
STATE_GROWUP_BOUGHT = -1141004
STATE_GROWUP_NOT_BOUGHT = -1141005
SEVEN_CLAIMABLE, SEVEN_CLAIMED, SEVEN_LOCKED = 1, 2, 3


class ActivityService:
    def __init__(self, config: ActivitiesConfig, ledger: Ledger, clock: Clock, events=None, model=None):
        self.config = config
        self.ledger = ledger
        self.clock = clock
        self.events = events
        self.model = model  # 用于把“按品质随机装备”解析成具体模板

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
        """客户端字段：ContinuousDay 已连续征收天数、AllDay 连续目标天数、ToDay 今日剩余次数、CountDown 下次可征收倒计时。"""
        rule = self.config.salary
        level = state['PLevel']
        reward = [dict(Type=1, ID=0, Count=rule['base_gold'] + level * rule['gold_per_level']),
                  dict(Type=18, ID=0, Count=rule['base_knowledge'] + level * rule['knowledge_per_level'])]
        streak = state.setdefault('Salary', {'streak': 0, 'last_day': ''})
        taken = state['Daily'].get('salary_taken')
        return {'ContinuousDay': streak['streak'], 'AllDay': rule['streak_target_days'], 'ToDay': 0 if taken else 1,
                'CountDown': self.clock.seconds_until_next_day() if taken else 0, 'Reward': reward}

    def _gift_bags(self, state: dict) -> list:
        """礼包列表：客户端用 ``icon`` 拼图标路径、用 ``ListCrr`` 展示奖励明细，二者缺失会导致界面崩溃。"""
        bags = []
        for bag in self.config.salary_gift_bags:
            item = {k: v for k, v in thaw(bag).items() if k != 'reward'}
            item['ListCrr'] = thaw(bag['reward'])
            item['DayNuber'] = state['Daily'].get('gift_bags', []).count(bag['GifBagID'])  # 今日已领次数
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
        rewards = list(info['Reward'])
        streak = state['Salary']
        yesterday = self.clock.day_key(self.clock.now() - 86400)
        new_streak = streak['streak'] + 1 if streak['last_day'] == yesterday else 1
        rule = self.config.salary
        if new_streak >= rule['streak_target_days']:
            for extra in thaw(rule['streak_reward']):
                if extra.get('Type') == 10 and not extra.get('ID'):
                    extra['ID'] = self.model.equipment.random_template_id(self.ledger.rng, extra.pop('quality', 2))
                rewards.append(extra)
            new_streak = 0
        outcome = self.ledger.apply(state, rewards=rewards)
        state['Daily']['salary_taken'] = True
        state['Salary'] = {'streak': new_streak, 'last_day': self.clock.day_key()}
        return Reply(self._salary(state), self.ledger.global_for(state, outcome))

    def take_gift_bag(self, ctx: RoleContext, params) -> Reply:
        """``/EverydayReward/GetActivity?id``。"""
        state = ctx.state
        bag = next((b for b in self.config.salary_gift_bags if b['GifBagID'] == params['id']), None)
        if bag is None:
            raise BusinessError('礼包不存在')
        claimed = state['Daily'].get('gift_bags', []).count(bag['GifBagID'])
        if bag['MustNumber'] == 0 or (bag['MustDayNuber'] > 0 and claimed >= bag['MustDayNuber']):
            raise BusinessError('今日已领取该礼包', STATE_REWARD_TAKEN)
        if state['PLevel'] < bag['MustPlayerLevel'] or state.get('VipLevel', 0) < bag['MustPlayerVipLevel']:
            raise BusinessError('尚未满足领取条件')
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

    # ---- 成长计划 -----------------------------------------------------------

    def _growup(self, state: dict) -> dict:
        return state.setdefault('Growup', {'bought': False, 'claimed': []})

    def _growup_tiers(self, state: dict) -> list:
        plan = self._growup(state)
        return [thaw(t) for t in self.config.growup['tiers'] if t['Level'] not in plan['claimed']]

    def growup_claimable(self, state: dict) -> int:
        plan = self._growup(state)
        if not plan['bought']:
            return 0
        lead = max([h['level'] for h in state['ownedHeros']] or [1])
        return sum(1 for t in self._growup_tiers(state) if lead >= t['Level'])

    def growup_info(self, ctx: RoleContext, params) -> dict:
        """``/LevelGiftBag/GetGrowupInfo``。"""
        plan = self._growup(ctx.state)
        return {'IsBuy': 1 if plan['bought'] else 0, 'VipLevelLimit': self.config.growup['vip_limit'],
                'Growup': self._growup_tiers(ctx.state)}

    def growup_buy(self, ctx: RoleContext, params) -> Reply:
        """``/LevelGiftBag/BuyGrowup``。"""
        state = ctx.state
        if self._growup(state)['bought']:
            raise BusinessError('成长计划已购买', STATE_GROWUP_BOUGHT)
        if state.get('VipLevel', 0) < self.config.growup['vip_limit']:
            raise BusinessError(f"购买成长计划需要 VIP{self.config.growup['vip_limit']}")
        price = self.config.growup['price_ingot']
        outcome = self.ledger.apply(state, consume=[dict(Type=2, ID=0, Count=price)] if price else [])
        self._growup(state)['bought'] = True
        return Reply({}, self.ledger.global_for(state, outcome))

    def growup_claim(self, ctx: RoleContext, params) -> Reply:
        """``/LevelGiftBag/GetGrowupReward?level``。"""
        state = ctx.state
        plan = self._growup(state)
        if not plan['bought']:
            raise BusinessError('成长计划还未购买', STATE_GROWUP_NOT_BOUGHT)
        level = params['level']
        tier = next((t for t in self.config.growup['tiers'] if t['Level'] == level), None)
        if tier is None or level in plan['claimed']:
            raise BusinessError('该档奖励不存在或已领取', STATE_REWARD_TAKEN)
        lead = max([h['level'] for h in state['ownedHeros']] or [1])
        if lead < level:
            raise BusinessError('主将等级不足')
        outcome = self.ledger.apply(state, rewards=[dict(Type=2, ID=0, Count=tier['Ingot'])])
        self._growup(state)['claimed'].append(level)
        return Reply({}, self.ledger.global_for(state, outcome))

    # ---- 伪充值与 VIP -----------------------------------------------------------

    def _recharge(self, state: dict) -> dict:
        rec = state.setdefault('Recharge', {'total': 0, 'today': 0, 'max_single': 0, 'day': '',
                                            'orders': 0, 'first_claimed': False})
        today = self.clock.day_key()
        if rec.get('day') != today:
            rec['day'] = today
            rec['today'] = 0
        return rec

    def apply_vip(self, state: dict):
        """按累计购买元宝重算 VipLevel / VipExp（进度百分比）/ NextVipExp（距下一级元宝）。"""
        thresholds = list(self.config.recharge['vip_thresholds'])
        total = self._recharge(state)['total']
        level = sum(1 for need in thresholds if total >= need)
        state['VipLevel'] = level
        if level >= len(thresholds):
            state['VipExp'], state['NextVipExp'] = 100, 0
            return
        floor = thresholds[level - 1] if level else 0
        span = thresholds[level] - floor
        state['VipExp'] = int((total - floor) * 100 / span) if span else 0
        state['NextVipExp'] = thresholds[level] - total

    def enrich(self, db, state: dict):
        """加载角色时刷新 VIP 与 ServerVipEnable（主界面 VIP 标签、充值页、分享页签的开关）。"""
        state['ServerVipEnable'] = self.config.recharge['server_vip_enable']
        self.apply_vip(state)

    def recharge_list(self, ctx: RoleContext, params) -> list:
        """``/Recharge/RechargeLst``：充值档位。"""
        return [thaw(p) for p in self.config.recharge['packages']]

    def _place_order(self, ctx: RoleContext, packages, money_raw):
        cfg = self.config.recharge
        if not cfg['enabled']:
            raise BusinessError('上仙，本服尚未开启内购充值。')
        try:
            money = int(float(money_raw or 0))
        except ValueError as exc:
            raise BusinessError('充值金额无效') from exc
        package = next((p for p in packages if int(p['Money']) == money), None)
        if package is None:
            raise BusinessError('充值档位不存在')
        rec = self._recharge(ctx.state)
        rec['orders'] += 1
        order_id = f"GM{ctx.state['ID']}-{self.clock.now()}-{rec['orders']}"
        return package, order_id

    def get_order(self, ctx: RoleContext, params) -> Reply:
        """``/Recharge/GetOrderID?money``：伪充值，下单即到账元宝并推进 VIP。"""
        state = ctx.state
        package, order_id = self._place_order(ctx, self.config.recharge['packages'], params.get('money'))
        gain = int(package['Ingot']) + int(package.get('ExtreIngot') or 0)
        outcome = self.ledger.apply(state, rewards=[dict(Type=2, ID=0, Count=gain)] if gain else [])
        rec = self._recharge(state)
        rec['total'] += int(package['Ingot'])
        rec['today'] += int(package['Ingot'])
        rec['max_single'] = max(rec['max_single'], int(package['Ingot']))
        self.apply_vip(state)
        self._emit(state, 'recharge_ingot', int(package['Ingot']))
        block = self.ledger.global_for(state, outcome)
        block.setdefault('Resource', {})['RL'] = [{'orderId': order_id, 'Money': int(package['Money'])}]
        return Reply(order_id, block)

    def get_point_order(self, ctx: RoleContext, params) -> Reply:
        """``/Recharge/GetPointOrderID?money``：伪充值点卡，直接到账点卷（月卡页使用）。"""
        state = ctx.state
        package, order_id = self._place_order(ctx, self.config.recharge['point_packages'], params.get('money'))
        state['Point'] = state.get('Point', 0) + int(package['Point'])
        rec = self._recharge(state)
        rec['total'] += int(package['Money'])
        rec['today'] += int(package['Money'])
        rec['max_single'] = max(rec['max_single'], int(package['Money']))
        self.apply_vip(state)
        block = self.ledger.global_for(state, Outcome())
        block.setdefault('Resource', {})['RL'] = [{'orderId': order_id, 'Money': int(package['Money'])}]
        return Reply(order_id, block)

    def first_recharge_info(self, ctx: RoleContext, params) -> list:
        """``/Recharge/firstreward``：客户端把 Result 当奖励数组遍历。"""
        return thaw(self.config.recharge['first_recharge_reward'])

    def first_recharge_claim(self, ctx: RoleContext, params) -> Reply:
        """``/Recharge/GetFirstRechargeReward``。"""
        state = ctx.state
        rec = self._recharge(state)
        if rec['total'] <= 0:
            raise BusinessError('您还没有任何充值', STATE_NOT_CHARGED)
        if rec['first_claimed']:
            raise BusinessError('首充奖励已领取', STATE_REWARD_TAKEN)
        outcome = self.ledger.apply(state, rewards=thaw(self.config.recharge['first_recharge_reward']))
        self._recharge(state)['first_claimed'] = True
        return Reply({}, self.ledger.global_for(state, outcome))

    # ---- 月卡 / 周卡 / 点卷 -----------------------------------------------------------

    def _month_card(self, state: dict) -> dict:
        return state.setdefault('MonthCard', {'month_until': 0, 'week_until': 0, 'last_claim': ''})

    def month_card_info(self, ctx: RoleContext, params) -> dict:
        """``/Monthcard/GetMonthcardInfo``。"""
        cfg = self.config.month_card
        card = self._month_card(ctx.state)
        now = self.clock.now()
        month_left = Clock.remaining(card['month_until'], now)
        return {'MonthCardConsume': cfg['MonthCardConsume'], 'WeekCardConsume': cfg['WeekCardConsume'],
                'MonthReward': thaw(cfg['MonthReward']), 'WeekReward': thaw(cfg['WeekReward']),
                'RechargePointInfo': [{'ID': p['ID'], 'Money': p['Money']} for p in self.config.recharge['point_packages']],
                'WeekCountdown': Clock.remaining(card['week_until'], now), 'MonthCountdown': month_left,
                'IsBuyMonthCard': 0,
                'HaveMonthCardTimes': 1 if month_left > 0 and card['last_claim'] != self.clock.day_key() else 0}

    def _spend_points(self, state: dict, count: int):
        if state.get('Point', 0) < count:
            raise BusinessError('点卷不足，请先购买点卡')
        state['Point'] -= count

    def month_card_claim(self, ctx: RoleContext, params) -> Reply:
        """``/Monthcard/GetMonthcardReward``：未激活时扣点卷激活并发当日奖，已激活则每日领一次。"""
        state = ctx.state
        cfg = self.config.month_card
        card = self._month_card(state)
        now, today = self.clock.now(), self.clock.day_key()
        if Clock.remaining(card['month_until'], now) <= 0:
            self._spend_points(state, cfg['MonthCardConsume'])
            card['month_until'] = now + cfg['month_days'] * 86400
        elif card['last_claim'] == today:
            raise BusinessError('今日月卡奖励已领取', STATE_REWARD_TAKEN)
        outcome = self.ledger.apply(state, rewards=thaw(cfg['MonthReward']))
        card = self._month_card(state)
        card['last_claim'] = today
        return Reply({}, self.ledger.global_for(state, outcome))

    def week_card_claim(self, ctx: RoleContext, params) -> Reply:
        """``/Monthcard/GetWeekcardReward``：扣点卷激活周卡并一次性发放奖励。"""
        state = ctx.state
        cfg = self.config.month_card
        card = self._month_card(state)
        if Clock.remaining(card['week_until'], self.clock.now()) > 0:
            raise BusinessError('周卡生效中，无需重复购买', STATE_REWARD_TAKEN)
        self._spend_points(state, cfg['WeekCardConsume'])
        outcome = self.ledger.apply(state, rewards=thaw(cfg['WeekReward']))
        card = self._month_card(state)
        card['week_until'] = self.clock.now() + cfg['week_days'] * 86400
        return Reply({}, self.ledger.global_for(state, outcome))

    def change_ingot(self, ctx: RoleContext, params) -> Reply:
        """``/Monthcard/ChangeIngot?point``：点卷兑换元宝。"""
        state = ctx.state
        point = params['point']
        if point <= 0:
            raise BusinessError('兑换点数无效')
        self._spend_points(state, point)
        outcome = self.ledger.apply(state, rewards=[dict(Type=2, ID=0, Count=point * self.config.month_card['point_to_ingot_rate'])])
        return Reply({}, self.ledger.global_for(state, outcome))

    # ---- Notify 红点 -----------------------------------------------------------

    def notify(self, state: dict) -> dict:
        today = self.clock.day_key()
        sign = state.get('Sign') or {}
        signed = sign.get('month') == self.clock.month_key() and sign.get('last_day') == today
        rec = state.get('Recharge') or {}
        return {'SignRewardShow': 0 if signed else 1,
                'SevenLoginShow': self.seven_day_claimable(state),
                'EverydayRewardShow': 0 if state['Daily'].get('salary_taken') else 1,
                'lgbs': self.level_gift_claimable(state),
                'Growup': self.growup_claimable(state),
                'FirstRechargeShow': 1 if rec.get('total') and not rec.get('first_claimed') else 0}

    # ---- 公告 -------------------------------------------------------------

    def marquee(self, ctx: SessionContext, params) -> list:
        """``/Message/Messages``：跑马灯公告。"""
        now = self.clock.now()
        return [dict(content=item['content'], time=now, repeatNumber=item['repeatNumber']) for item in self.config.marquee]

    def _emit(self, state: dict, kind: str, amount: int):
        if self.events is not None:
            self.events.on(state, kind, amount)
