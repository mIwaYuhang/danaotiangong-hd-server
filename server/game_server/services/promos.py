"""活动中心扩展玩法：财神到、幸运转盘、采灵芝、天女散花、西游坊市/黑市、每日分享与兑换码。

配置见 ``data/config/activities/``（fortune_king / luckydisk / lingzhi / sanhua / exchange / share）。
玩家状态集中在 ``state['Promo']``，按游戏日重置的子块内嵌 ``day`` 字段。

客户端契约要点（来自反编译 Lua）：
- 财神到 ``/FortuneKing/FortuneKingInfo``：Result 为数组，state 1 可领 / 2 已领 / 3 未达标，endTime 为剩余秒；
- 幸运转盘 ``/Luckydisk/SeekingTreasures``：Result 需带 index（中奖格）与 luckydisk（整份信息）；幸运字为
  ``{Type:20, ID:1..4}``，只累计到 jin/yu/man/tang，不进账本；
- 采灵芝 ``/Pickganoderma/Refresh``：Result 是**裸数字**（新的 selectType）；
- 天女散花 ``/FairySendingFlowers/Flowers``：金额由客户端小游戏统计上报，服务端按 caps 封顶；
- 坊市 ``/exchange/list``：activityid 1 坊市 / 2 黑市（客户端写死）。
"""
from copy import deepcopy

from ..config import ActivitiesConfig, thaw
from ..errors import BusinessError
from .base import Reply, RoleContext
from .clock import Clock
from .inventory import Ledger

STATE_REWARD_TAKEN = -1131001
STATE_SANHUA_JOINED = -1129001
STATE_SANHUA_CLOSED = -1129002
STATE_WORD_NOT_ENOUGH = -1128001
STATE_DISK_NO_TIMES = -1128003
STATE_DISK_NO_REFRESH = -1128004
LUCKY_WORD_TYPE = 20
WORD_IDS = ('1', '2', '3', '4')  # 金 / 玉 / 满 / 堂


class PromoService:
    def __init__(self, config: ActivitiesConfig, ledger: Ledger, clock: Clock, model):
        self.config = config
        self.ledger = ledger
        self.clock = clock
        self.model = model

    # ---- 公共状态块 -----------------------------------------------------------

    def _promo(self, state: dict) -> dict:
        promo = state.setdefault('Promo', {})
        today = self.clock.day_key()
        if promo.get('day') != today:
            promo.update(day=today, fortune_daily=[], disk=None, lingzhi=None,
                         exchange_used={}, share_done=False, sanhua=[])
        for key, default in (('fortune_daily', []), ('exchange_used', {}), ('sanhua', []),
                             ('fortune_once', []), ('codes', []), ('share_done', False)):
            promo.setdefault(key, default)
        return promo

    # ---- 财神到 -----------------------------------------------------------

    def _fortune_progress(self, state: dict, kind: int) -> int:
        rec = state.get('Recharge') or {}
        if kind == 1:
            return rec.get('max_single', 0)
        if kind == 2:
            return rec.get('today', 0) if rec.get('day') == self.clock.day_key() else 0
        if kind == 3:
            return rec.get('total', 0)
        if kind == 4:
            return state.get('Daily', {}).get('ingot_spent', 0)
        return state.get('Counters', {}).get('ingot_spent_total', 0)

    def _fortune_rows(self, state: dict) -> list:
        promo = self._promo(state)
        rows = []
        until_tomorrow = self.clock.seconds_until_next_day()
        for item in self.config.fortune_king['items']:
            daily = item['type'] in (1, 2, 4)
            claimed = item['id'] in (promo['fortune_daily'] if daily else promo['fortune_once'])
            progress = self._fortune_progress(state, item['type'])
            status = 2 if claimed else (1 if progress >= item['need'] else 3)
            rows.append({'id': item['id'], 'type': item['type'], 'state': status,
                         'endTime': until_tomorrow if daily else 30 * 86400,
                         'totalNeedNum': item['need'], 'remainNeedNum': max(0, item['need'] - progress),
                         'rewards': thaw(item['rewards'])})
        return rows

    def fortune_claimable(self, state: dict) -> int:
        return sum(1 for row in self._fortune_rows(state) if row['state'] == 1)

    def fortune_info(self, ctx: RoleContext, params) -> list:
        """``/FortuneKing/FortuneKingInfo``。"""
        return [row for row in self._fortune_rows(ctx.state) if row['state'] in (1, 3)]

    def fortune_claim(self, ctx: RoleContext, params) -> Reply:
        """``/FortuneKing/FortuneKingReward?ID``。"""
        state = ctx.state
        row = next((r for r in self._fortune_rows(state) if r['id'] == params['ID']), None)
        if row is None:
            raise BusinessError('活动不存在')
        if row['state'] == 2:
            raise BusinessError('奖励已领取', STATE_REWARD_TAKEN)
        if row['state'] != 1:
            raise BusinessError('不满足领取条件')
        outcome = self.ledger.apply(state, rewards=row['rewards'])
        promo = self._promo(state)
        item = next(i for i in self.config.fortune_king['items'] if i['id'] == params['ID'])
        (promo['fortune_daily'] if item['type'] in (1, 2, 4) else promo['fortune_once']).append(item['id'])
        return Reply({'ok': 1}, self.ledger.global_for(state, outcome))

    # ---- 幸运转盘 -----------------------------------------------------------

    def _new_layout(self) -> list:
        """16 格布局：12 个按权重抽取的奖品 + 金玉满堂四字，随机排列。"""
        cfg = self.config.luckydisk
        entries = [thaw(p) for p in cfg['prizes']]
        weights = [e.pop('weight') for e in entries]
        picks = [deepcopy(self.ledger.rng.choices(entries, weights=weights, k=1)[0]) for _ in range(12)]
        slots = picks + [dict(Type=LUCKY_WORD_TYPE, ID=int(w), Count=1) for w in WORD_IDS]
        self.ledger.rng.shuffle(slots)
        return slots

    def _disk(self, state: dict) -> dict:
        promo = self._promo(state)
        if not promo.get('disk'):
            promo['disk'] = {'layout': self._new_layout(), 'spins': 0, 'gold_spins': 0, 'refreshes': 0,
                             'since_choice': 0, 'words': {w: 0 for w in WORD_IDS}, 'b1': 0, 'b2': 0}
        return promo['disk']

    def _disk_info(self, state: dict) -> dict:
        cfg = self.config.luckydisk
        disk = self._disk(state)
        rows = [{'Index': i + 1, 'Treasure': [deepcopy(t)]} for i, t in enumerate(disk['layout'])]
        rows.append({'Index': 17, 'Treasure': thaw(cfg['exchange_three'])[:1]})
        rows.append({'Index': 18, 'Treasure': thaw(cfg['exchange_four'])[:1]})
        gold_left = max(0, cfg['gold_spin_limit'] - disk['gold_spins'])
        until_tomorrow = self.clock.seconds_until_next_day()
        return {'remainSeekingTreasuresTime': max(0, cfg['daily_spins'] - disk['spins']),
                'remainTimeUseGold': gold_left,
                'treasuresInfo': rows,
                'seekingTreasuresCost': {'gold': cfg['spin_cost_gold']} if gold_left else {'ingot': cfg['choose_cost_ingot']},
                'refreshTokenCount': 0, 'refreshIngotCost': cfg['refresh_cost_ingot'],
                'remainRefreshTreasuresTime': max(0, cfg['refresh_daily'] - disk['refreshes']),
                'needSeekingTreasureNumber': max(0, cfg['choose_after'] - disk['since_choice']),
                'treasuresRefreshTime': until_tomorrow, 'clearWordsTime': until_tomorrow,
                'jin': disk['words']['1'], 'yu': disk['words']['2'], 'man': disk['words']['3'], 'tang': disk['words']['4'],
                'baldric1State': disk['b1'], 'baldric2State': disk['b2']}

    def disk_words_left(self, state: dict) -> int:
        cfg = self.config.luckydisk
        disk = (state.get('Promo') or {}).get('disk')
        if not disk or (state.get('Promo') or {}).get('day') != self.clock.day_key():
            return cfg['daily_spins']
        return max(0, cfg['daily_spins'] - disk['spins'])

    def disk_info(self, ctx: RoleContext, params) -> dict:
        """``/Luckydisk/Luckydisk``。"""
        return self._disk_info(ctx.state)

    def disk_seek(self, ctx: RoleContext, params) -> Reply:
        """``/Luckydisk/SeekingTreasures?index``：index 0 随机转，任选模式传格号。"""
        state = ctx.state
        cfg = self.config.luckydisk
        disk = self._disk(state)
        if disk['spins'] >= cfg['daily_spins']:
            raise BusinessError('今日探宝次数已用完', STATE_DISK_NO_TIMES)
        index = params['index']
        if index:
            if disk['since_choice'] < cfg['choose_after']:
                raise BusinessError(f"还需探宝 {cfg['choose_after'] - disk['since_choice']} 次才能任选")
            if not 1 <= index <= 16:
                raise BusinessError('转盘格不存在')
            consume = [dict(Type=2, ID=0, Count=cfg['choose_cost_ingot'])]
            landed = index
        else:
            if disk['gold_spins'] < cfg['gold_spin_limit']:
                consume = [dict(Type=1, ID=0, Count=cfg['spin_cost_gold'])]
            else:
                consume = [dict(Type=2, ID=0, Count=cfg['choose_cost_ingot'])]
            landed = self.ledger.rng.randint(1, 16)
        prize = deepcopy(self._disk(state)['layout'][landed - 1])
        crit = 0
        rewards = []
        if prize['Type'] == LUCKY_WORD_TYPE:
            pass  # 幸运字只累计，不走账本
        else:
            if self.ledger.rng.random() < cfg['crit_chance']:
                crit = 2
                prize['Count'] *= 2
            rewards = [prize]
        outcome = self.ledger.apply(state, rewards=rewards, consume=consume)
        disk = self._disk(state)
        disk['spins'] += 1
        if not index:
            if disk['gold_spins'] < cfg['gold_spin_limit']:
                disk['gold_spins'] += 1
            disk['since_choice'] += 1
        else:
            disk['since_choice'] = 0
        if prize['Type'] == LUCKY_WORD_TYPE:
            disk['words'][str(prize['ID'])] += 1
        result = {'index': landed, 'luckydisk': self._disk_info(state)}
        if crit:
            result['Crit'] = crit
        return Reply(result, self.ledger.global_for(state, outcome))

    def disk_refresh(self, ctx: RoleContext, params) -> Reply:
        """``/Luckydisk/Refresh``。"""
        state = ctx.state
        cfg = self.config.luckydisk
        disk = self._disk(state)
        if disk['refreshes'] >= cfg['refresh_daily']:
            raise BusinessError('今日刷新次数已用完', STATE_DISK_NO_REFRESH)
        outcome = self.ledger.apply(state, consume=[dict(Type=2, ID=0, Count=cfg['refresh_cost_ingot'])])
        disk = self._disk(state)
        disk['refreshes'] += 1
        disk['layout'] = self._new_layout()
        return Reply(self._disk_info(state), self.ledger.global_for(state, outcome))

    def disk_exchange(self, ctx: RoleContext, params) -> Reply:
        """``/Luckydisk/ExchangeTreasures?exchangeType``：1 任意三字 / 2 金玉满堂。"""
        state = ctx.state
        cfg = self.config.luckydisk
        disk = self._disk(state)
        kind = params['exchangeType']
        if kind == 2:
            if disk['b2']:
                raise BusinessError('该奖励已兑换', STATE_REWARD_TAKEN)
            if any(disk['words'][w] < 1 for w in WORD_IDS):
                raise BusinessError('幸运字不足', STATE_WORD_NOT_ENOUGH)
            spend = list(WORD_IDS)
            rewards = thaw(cfg['exchange_four'])
        else:
            if disk['b1']:
                raise BusinessError('该奖励已兑换', STATE_REWARD_TAKEN)
            owned = [w for w in WORD_IDS if disk['words'][w] >= 1]
            if len(owned) < 3:
                raise BusinessError('幸运字不足', STATE_WORD_NOT_ENOUGH)
            spend = owned[:3]
            rewards = thaw(cfg['exchange_three'])
        outcome = self.ledger.apply(state, rewards=rewards)
        disk = self._disk(state)
        for word in spend:
            disk['words'][word] -= 1
        disk['b2' if kind == 2 else 'b1'] = 1
        result = self._disk_info(state)
        result['Reward'] = deepcopy(outcome.rewards)
        return Reply(result, self.ledger.global_for(state, outcome))

    # ---- 采灵芝 -----------------------------------------------------------

    def _lingzhi(self, state: dict) -> dict:
        promo = self._promo(state)
        if not promo.get('lingzhi'):
            promo['lingzhi'] = {'eats': 0, 'refreshes': 0, 'selected': 1}
        return promo['lingzhi']

    def _ganoderma(self, kind: int) -> dict:
        row = next((g for g in self.config.lingzhi['ganodermas'] if g['type'] == kind), None)
        if row is None:
            raise BusinessError('没有该灵芝', -1130001)
        return row

    def lingzhi_left(self, state: dict) -> int:
        promo = state.get('Promo') or {}
        block = promo.get('lingzhi') if promo.get('day') == self.clock.day_key() else None
        return max(0, self.config.lingzhi['daily_eat'] - (block or {}).get('eats', 0))

    def lingzhi_info(self, ctx: RoleContext, params) -> dict:
        """``/Pickganoderma/Pickganoderma``。"""
        cfg = self.config.lingzhi
        block = self._lingzhi(ctx.state)
        return {'remainFreeRefreshTime': max(0, cfg['free_refresh'] - block['refreshes']),
                'remainEatTime': max(0, cfg['daily_eat'] - block['eats']),
                'selectType': block['selected'], 'refreshCost': cfg['refresh_cost_ingot'],
                'Ganodermas': [thaw(g) for g in cfg['ganodermas']]}

    def lingzhi_refresh(self, ctx: RoleContext, params) -> Reply:
        """``/Pickganoderma/Refresh``：Result 为新的 selectType（裸数字）。"""
        state = ctx.state
        cfg = self.config.lingzhi
        block = self._lingzhi(state)
        consume = [] if block['refreshes'] < cfg['free_refresh'] else [dict(Type=2, ID=0, Count=cfg['refresh_cost_ingot'])]
        outcome = self.ledger.apply(state, consume=consume)
        block = self._lingzhi(state)
        block['refreshes'] += 1
        block['selected'] = self.ledger.rng.randint(1, len(cfg['ganodermas']))
        return Reply(block['selected'], self.ledger.global_for(state, outcome))

    def lingzhi_call(self, ctx: RoleContext, params) -> Reply:
        """``/Pickganoderma/Call?type``：花元宝直接指定灵芝。"""
        state = ctx.state
        row = self._ganoderma(params['type'])
        cost = int(row.get('callCost') or 0)
        if cost <= 0:
            raise BusinessError('该灵芝不支持召唤')
        outcome = self.ledger.apply(state, consume=[dict(Type=2, ID=0, Count=cost)])
        self._lingzhi(state)['selected'] = row['type']
        return Reply({}, self.ledger.global_for(state, outcome))

    def lingzhi_eat(self, ctx: RoleContext, params) -> Reply:
        """``/Pickganoderma/Eat?heroID&type``：给主将加潜力。"""
        state = ctx.state
        cfg = self.config.lingzhi
        block = self._lingzhi(state)
        if block['eats'] >= cfg['daily_eat']:
            raise BusinessError('今日服用次数已达上限', -1130002)
        row = self._ganoderma(params['type'])
        hero = self.model.find_hero(state, params['heroID'])
        hero['potency'] = hero.get('potency', 0) + int(row['addPotential'])
        self.model.refresh_hero(state, hero)
        block['eats'] += 1
        block['selected'] = 1
        outcome = self.ledger.apply(state)
        outcome.heros.append(deepcopy(hero))
        return Reply({}, self.ledger.global_for(state, outcome, Slots=self.model.slots(state)))

    # ---- 天女散花 -----------------------------------------------------------

    def _sanhua_window(self):
        """当前所在的活动时段：(编号, 剩余秒)；不在时段内返回 (None, 0)。"""
        import datetime as dt
        now = self.clock.now()
        local = dt.datetime.fromtimestamp(now)
        for index, window in enumerate(self.config.sanhua['windows']):
            start_h, start_m = _parse_hm(window['start'])
            end_h, end_m = _parse_hm(window['end'])
            start = local.replace(hour=start_h, minute=start_m, second=0, microsecond=0)
            end = local.replace(hour=end_h, minute=end_m, second=0, microsecond=0)
            if start <= local < end:
                return index, int((end - local).total_seconds())
        return None, 0

    def sanhua_open(self, state: dict) -> bool:
        index, _ = self._sanhua_window()
        return index is not None and index not in self._promo(state)['sanhua']

    def sanhua_info(self, ctx: RoleContext, params) -> dict:
        """``/FairySendingFlowers/FlowersInfo``。"""
        index, remain = self._sanhua_window()
        joined = index is not None and index in self._promo(ctx.state)['sanhua']
        return {'isJoin': 1 if joined else 0, 'remainTime': remain,
                'Times': [{'start': w['start'], 'end': w['end']} for w in self.config.sanhua['windows']]}

    def sanhua_use(self, ctx: RoleContext, params) -> Reply:
        """``/FairySendingFlowers/Flowers?ingot&gold&energy``：按客户端上报的接花结果发奖（封顶）。"""
        state = ctx.state
        index, _ = self._sanhua_window()
        if index is None:
            raise BusinessError('天女散花没在活动时间内', STATE_SANHUA_CLOSED)
        promo = self._promo(state)
        if index in promo['sanhua']:
            raise BusinessError('您已参与这次天女散花活动', STATE_SANHUA_JOINED)
        caps = self.config.sanhua['caps']
        rewards = []
        for key, item_type in (('ingot', 2), ('gold', 1), ('energy', 9)):
            try:
                amount = min(int(float(params.get(key) or 0)), int(caps[key]))
            except ValueError:
                amount = 0
            if amount > 0:
                rewards.append(dict(Type=item_type, ID=0, Count=amount))
        outcome = self.ledger.apply(state, rewards=rewards)
        self._promo(state)['sanhua'].append(index)
        return Reply({}, self.ledger.global_for(state, outcome))

    # ---- 西游坊市 / 黑市 -----------------------------------------------------------

    def _exchange_items(self, activity_id: int):
        if activity_id == 2:
            return self.config.exchange['black_market']
        return self.config.exchange['market']

    def exchange_list(self, ctx: RoleContext, params) -> list:
        """``/exchange/list?activityid``。"""
        used = self._promo(ctx.state)['exchange_used']
        rows = []
        remain_seconds = self.clock.seconds_until_next_day()
        for item in self._exchange_items(params['activityid']):
            limit = int(item['daily_limit'])
            done = used.get(str(item['Id']), 0)
            row = {'Id': item['Id'], 'Reward': thaw(item['Reward']), 'Consume': thaw(item['Consume']),
                   'LastSecond': remain_seconds, 'Total': limit,
                   'Remain': 1 if limit < 0 else max(0, limit - done)}
            if 'VipLevel' in item:
                row['VipLevel'] = item['VipLevel']
            rows.append(row)
        return rows

    def exchange_do(self, ctx: RoleContext, params) -> Reply:
        """``/exchange/do?exchangeid``。"""
        state = ctx.state
        target = params['exchangeid']
        item = next((i for lst in ('market', 'black_market') for i in self.config.exchange[lst] if i['Id'] == target), None)
        if item is None:
            raise BusinessError('兑换项不存在')
        promo = self._promo(state)
        limit = int(item['daily_limit'])
        if limit >= 0 and promo['exchange_used'].get(str(target), 0) >= limit:
            raise BusinessError('今日兑换次数已用完', STATE_REWARD_TAKEN)
        if state.get('VipLevel', 0) < int(item.get('VipLevel') or 0):
            raise BusinessError(f"需要 VIP{item['VipLevel']} 才能兑换")
        outcome = self.ledger.apply(state, rewards=thaw(item['Reward']), consume=thaw(item['Consume']))
        promo = self._promo(state)
        promo['exchange_used'][str(target)] = promo['exchange_used'].get(str(target), 0) + 1
        return Reply({'Reward': deepcopy(outcome.rewards)}, self.ledger.global_for(state, outcome))

    # ---- 每日分享 / 兑换码 / 推广 -----------------------------------------------------------

    def share_complete(self, ctx: RoleContext, params) -> Reply:
        """``/ActivityShare/complate``：每日一次；重复领取 Result 为空（客户端弹「已领取」）。"""
        state = ctx.state
        promo = self._promo(state)
        if promo['share_done']:
            return Reply(None)
        outcome = self.ledger.apply(state, rewards=thaw(self.config.share['share_reward']))
        self._promo(state)['share_done'] = True
        return Reply(deepcopy(outcome.rewards), self.ledger.global_for(state, outcome))

    def gift_code(self, ctx: RoleContext, params) -> Reply:
        """``/Activegift/check?code``。"""
        state = ctx.state
        code = (params.get('code') or '').strip()
        rewards = self.config.share['gift_codes'].get(code)
        if rewards is None:
            raise BusinessError('上仙，兑换码无效！')
        promo = self._promo(state)
        if code in promo['codes']:
            raise BusinessError('该兑换码已使用', STATE_REWARD_TAKEN)
        outcome = self.ledger.apply(state, rewards=thaw(rewards))
        self._promo(state)['codes'].append(code)
        return Reply({'Reward': deepcopy(outcome.rewards)}, self.ledger.global_for(state, outcome))

    def promoter_add(self, ctx: RoleContext, params) -> dict:
        """``/promoter/add?token``：绑定推广人（输入对方角色 ID）。"""
        raise BusinessError('上仙，本服暂未开启好友推广活动')

    def promoter_rewards(self, ctx: RoleContext, params) -> list:
        return []

    def promoter_claim(self, ctx: RoleContext, params):
        raise BusinessError('暂无可领取的奖励')

    # ---- Notify 红点 -----------------------------------------------------------

    def notify(self, state: dict) -> dict:
        return {'FortuneKingsShow': self.fortune_claimable(state),
                'LuckydiskShow': self.disk_words_left(state),
                'PickganodermaShow': self.lingzhi_left(state),
                'FairySendingFlowersShow': 1 if self.sanhua_open(state) else 0,
                'IVE': 1}


def _parse_hm(text: str):
    hour, _, minute = text.partition(':')
    return int(hour), int(minute or 0)
