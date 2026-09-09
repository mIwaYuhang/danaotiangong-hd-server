"""账本与背包：奖励 / 消耗结算、道具使用、商店、神秘商店。

``Ledger.apply()`` 是所有资源变动的唯一入口：先在状态副本上校验并结算全部条目，成功后一次性写回，
任何一项失败都不会留下半成品。它理解全部 ItemType（见 ``inventory.json``）：

- 资源类（银币/元宝/体力/阅历/培养丹/经验池……）直接改字段，不足时返回客户端可识别的 State 码；
- 背包类（将魂/道具/材料）进入 ``Others``，碎片进入 ``Fragments``，都先校验静态表；
- 英雄：未拥有则加入 ``ownedHeros``，已拥有则改为发放将魂；
- 装备：按模板创建实例（``ID`` 为 0 时按 ``quality`` 随机模板）；
- 双倍经验：累加到 ``DoubleExpUntil``。

``apply()`` 返回 ``Outcome``，其中 ``rewards`` 是实际发放的条目（例如英雄转成的将魂），
``talismans`` / ``heros`` 供业务层放进 ``Global``。
"""
from copy import deepcopy
from dataclasses import dataclass, field
import random
import re

from ..config import InventoryConfig, StoreConfig, thaw
from ..errors import BusinessError
from .base import Reply, RoleContext, global_block
from .clock import Clock
from .equipment import EquipmentModel
from .player_state import PlayerModel

POSITIVE_DECIMAL = re.compile(r'[1-9][0-9]{0,9}')
#: 客户端 netstate.lua 的资源不足码，SystemHandler 会引导玩家去充值/购买。
INSUFFICIENT_STATE = {'Ingot': -1108002, 'Gold': -1108001, 'Energy': -1108006}
RESOURCE_NAMES = {'Ingot': '元宝', 'Gold': '银币', 'Energy': '体力', 'Knowledge': '阅历', 'TrainPill': '培养丹',
                  'HeroExp': '主将经验', 'RecastStone': '重铸石', 'Honor': '荣誉', 'SoulJade': '魂玉',
                  'Prestige': '威望', 'LearnExp': '授业经验', 'VipExp': 'VIP经验'}
UNLIMITED = 9999


@dataclass
class Outcome:
    rewards: list = field(default_factory=list)
    consume: list = field(default_factory=list)
    talismans: list = field(default_factory=list)
    heros: list = field(default_factory=list)


class Ledger:
    def __init__(self, config: InventoryConfig, catalog, model: PlayerModel, equipment: EquipmentModel,
                 clock: Clock, rng: random.Random = None):
        self.config = config
        self.catalog = catalog
        self.model = model
        self.equipment = equipment
        self.clock = clock
        self.rng = rng or random.Random()

    # ---- 校验 -------------------------------------------------------------

    def positive(self, value, maximum=None) -> int:
        if isinstance(value, str) and POSITIVE_DECIMAL.fullmatch(value):
            value = int(value)
        maximum = self.config.max_count if maximum is None else maximum
        if type(value) is not int or not 1 <= value <= maximum:
            raise BusinessError('数量或编号必须为范围内正整数')
        return value

    def bounded(self, value, name='资源') -> int:
        if type(value) is not int or value > self.config.max_count:
            raise BusinessError(f'{name}数量超出上限')
        return value

    def entry(self, kind, ident, count, extra=None) -> dict:
        """校验并规范化一条奖励 / 消耗。"""
        cfg = self.config
        self.positive(kind)
        self.positive(count)
        if kind in cfg.bag_types:
            self.positive(ident)
            if str(ident) not in self.catalog[cfg.bag_types[kind]]:
                raise BusinessError('物品配置不存在')
        elif kind == cfg.fragment_type:
            self.positive(ident)
            if str(ident) not in self.catalog['BaseFragments']:
                raise BusinessError('碎片配置不存在')
        elif kind == cfg.hero_type:
            self.positive(ident)
            if str(ident) not in self.catalog['BaseHeros']:
                raise BusinessError('英雄配置不存在')
        elif kind == cfg.equip_type:
            if ident:
                self.equipment.template(ident)
            elif not (extra or {}).get('quality'):
                raise BusinessError('装备奖励缺少模板')
        elif kind in cfg.resource_by_type or kind in (cfg.experience_type, cfg.double_exp_type):
            if type(ident) is not int or ident != 0:
                raise BusinessError('资源ID必须为0')
        else:
            raise BusinessError('不支持的奖励类型，未扣发资源')
        item = dict(Type=kind, ID=ident, Count=count)
        for key in ('Level', 'quality', 'RebirthCount'):
            if extra and extra.get(key) is not None:
                item[key] = extra[key]
        return item

    # ---- 结算 -------------------------------------------------------------

    def apply(self, state: dict, rewards=(), consume=()) -> Outcome:
        cfg = self.config
        work = deepcopy(state)
        outcome = Outcome()
        for raw in consume:
            item = self.entry(raw['Type'], raw['ID'], raw['Count'], raw)
            self._consume(work, item)
            outcome.consume.append(item)
        for raw in rewards:
            item = self.entry(raw['Type'], raw['ID'], raw['Count'], raw)
            outcome.rewards.append(self._grant(work, item, outcome))
        state.clear()
        state.update(work)
        return outcome

    def _consume(self, work: dict, item: dict):
        cfg, kind, ident, count = self.config, item['Type'], item['ID'], item['Count']
        if kind in cfg.resource_by_type:
            name = cfg.resource_by_type[kind]
            if work.get(name, 0) < count:
                raise BusinessError(f'{RESOURCE_NAMES.get(name, name)}不足', INSUFFICIENT_STATE.get(name, 99))
            work[name] -= count
            if name == 'Energy':
                work['EnergyUpdatedAt'] = self.clock.now() if work['Energy'] + count >= work['MaxEnergy'] else work['EnergyUpdatedAt']
        elif kind in cfg.bag_types or kind == cfg.fragment_type:
            bag = work.setdefault('Fragments' if kind == cfg.fragment_type else 'Others', [])
            found = next((x for x in bag if x['ID'] == ident and x.get('Type', kind) == kind), None)
            if found is None or found['Count'] < count:
                raise BusinessError('物品数量不足')
            found['Count'] -= count
            if found['Count'] == 0:
                bag.remove(found)
        elif kind == cfg.equip_type:
            self.equipment.remove(work, ident)
        else:
            raise BusinessError('不支持扣除该类型')

    def _grant(self, work: dict, item: dict, outcome: Outcome) -> dict:
        cfg, kind, ident, count = self.config, item['Type'], item['ID'], item['Count']
        if kind == cfg.experience_type:
            self.model.add_player_exp(work, count)
        elif kind in cfg.resource_by_type:
            name = cfg.resource_by_type[kind]
            work[name] = self.bounded(work.get(name, 0) + count, RESOURCE_NAMES.get(name, name))
        elif kind == cfg.double_exp_type:
            now = self.clock.now()
            work['DoubleExpUntil'] = max(now, work.get('DoubleExpUntil', 0)) + count
            work['HaveDoubleExpTime'] = work['DoubleExpUntil'] - now
        elif kind == cfg.hero_type:
            return self._grant_hero(work, ident, count, outcome)
        elif kind == cfg.equip_type:
            for _ in range(count):
                equip_id = ident or self.equipment.random_template_id(self.rng, item.get('quality', 1))
                instance = self.equipment.create(work, equip_id, item.get('Level', 1))
                outcome.talismans.append(deepcopy(instance))
            return dict(Type=kind, ID=ident or equip_id, Count=count, Level=item.get('Level', 1))
        else:
            bag = work.setdefault('Fragments' if kind == cfg.fragment_type else 'Others', [])
            found = next((x for x in bag if x['ID'] == ident and x.get('Type', kind) == kind), None)
            if found:
                found['Count'] = self.bounded(found['Count'] + count, '物品')
            else:
                bag.append(dict(Type=kind, ID=ident, Count=count))
        return dict(Type=kind, ID=ident, Count=count)

    def _grant_hero(self, work: dict, hero_id: int, count: int, outcome: Outcome) -> dict:
        if not self.model.has_hero(work, hero_id):
            hero = self.model.add_hero(work, hero_id)
            outcome.heros.append(deepcopy(hero))
            if count > 1:
                count -= 1
            else:
                return dict(Type=self.config.hero_type, ID=hero_id, Count=1, BreakthroughCount=0)
        # 已拥有：转换为将魂
        template = self.catalog['BaseHeros'][str(hero_id)]
        soul_id = template.get('soulId')
        if not soul_id or str(soul_id) not in self.catalog['BaseSouls']:
            raise BusinessError('该主将没有对应将魂')
        soul = dict(Type=4, ID=soul_id, Count=self.config.duplicate_soul_count * count)
        self._grant(work, soul, outcome)
        return soul

    def grant(self, state: dict, rewards) -> Outcome:
        return self.apply(state, rewards=rewards)

    def resource(self, state: dict) -> dict:
        """``Global.Resource``。"""
        result = {name: state[name] for name in self.config.resource_fields if name in state}
        result['Level'] = state['PLevel']
        return result

    def global_for(self, state: dict, outcome: Outcome, **extra) -> dict:
        block = global_block(self.resource(state), outcome.rewards, outcome.consume, **extra)
        if outcome.talismans:
            block['Talismans'] = outcome.talismans
        if outcome.heros:
            block['Heros'] = outcome.heros
        return block

    def bag_count(self, state: dict, kind: int, ident: int) -> int:
        bag = state.get('Fragments' if kind == self.config.fragment_type else 'Others', [])
        return next((x['Count'] for x in bag if x['ID'] == ident and x.get('Type', kind) == kind), 0)

    def draw(self, gift, multiplier: int = 1) -> list:
        """按权重从随机礼包配置中抽取。"""
        entries = list(gift.entries)
        weights = [e['weight'] for e in entries]
        rewards = []
        for _ in range(gift.draws * multiplier):
            picked = thaw(self.rng.choices(entries, weights=weights, k=1)[0])
            picked.pop('weight', None)
            rewards.append(picked)
        return rewards


class InventoryService:
    """道具、商店与神秘商店接口。"""

    def __init__(self, ledger: Ledger, store: StoreConfig, roles_repository):
        self.ledger = ledger
        self.config = ledger.config
        self.store = store
        self.catalog = ledger.catalog
        self.model = ledger.model
        self.repository = roles_repository

    # ---- 背包 -------------------------------------------------------------

    def list_props(self, ctx: RoleContext, params) -> list:
        """``/Prop/GetSinglePropLst``：按道具分类列出数量（含 0）。"""
        subtype = self.ledger.positive(params['propType'])
        if subtype not in self.catalog['PropType'].values():
            raise BusinessError('不支持的道具分类')
        counts = {x['ID']: x['Count'] for x in ctx.state.get('Others', []) if x['Type'] == 5}
        return [dict(Type=5, ID=int(ident), Count=counts.get(int(ident), 0))
                for ident, prop in self.catalog['BaseProps'].items() if prop['propType'] == subtype]

    def sell_props(self, ctx: RoleContext, params) -> Reply:
        """``/Prop/SellProps``：按静态表售价换银币。"""
        ident = self.ledger.positive(params['id'])
        count = self.ledger.positive(params.get('count') or '1', self.config.max_operation_count)
        kind, template = self._bag_template(ident)
        price = int(template.get('sellPrice', 0))
        if price <= 0:
            raise BusinessError('该物品不可出售')
        outcome = self.ledger.apply(ctx.state, rewards=[dict(Type=1, ID=0, Count=price * count)],
                                    consume=[dict(Type=kind, ID=ident, Count=count)])
        return Reply({}, self.ledger.global_for(ctx.state, outcome))

    def _bag_template(self, ident: int):
        for kind, table in self.config.bag_types.items():
            if str(ident) in self.catalog[table]:
                return kind, self.catalog[table][str(ident)]
        raise BusinessError('物品配置不存在')

    # ---- 使用道具 -----------------------------------------------------------

    def use_props(self, ctx: RoleContext, params) -> Reply:
        """``/Prop/UseProps``：按 PropType 分派效果。"""
        ident = self.ledger.positive(params['id'])
        count = self.ledger.positive(params.get('count') or '1', self.config.max_operation_count)
        prop = self.catalog['BaseProps'].get(str(ident))
        if prop is None:
            raise BusinessError('道具配置不存在')
        if self.ledger.bag_count(ctx.state, 5, ident) < count:
            raise BusinessError('道具数量不足')
        effects = self.config.prop_effects
        kind = prop['propType']
        state = ctx.state
        consume = [dict(Type=5, ID=ident, Count=count)]
        rewards, extra = [], {}
        special = self.config.special_props.get(ident)
        if special is not None:
            rewards = [dict(item, Count=item['Count'] * count) for item in thaw(special.rewards)]
            if special.cap_energy:
                gained = sum(r['Count'] for r in rewards if r['Type'] == 9)
                if state['Energy'] + gained > state['MaxEnergy']:
                    raise BusinessError('体力会超过上限，未消耗')
        elif kind == effects.get('energy'):
            rewards = [dict(Type=9, ID=0, Count=self.ledger.positive(prop['propValue']) * count)]
        elif kind == effects.get('double_exp'):
            seconds = int(prop['propValue']) or self.model.config.double_exp_default_seconds
            rewards = [dict(Type=16, ID=0, Count=seconds * count)]
        elif kind == effects.get('exp'):
            amount = self.ledger.positive(prop['propValue']) * count
            if params.get('heroId'):
                hero = self.model.find_hero(state, self.ledger.positive(params['heroId']))
                self.ledger.apply(state, consume=consume)
                self.model.heroes.add_experience(hero, amount, state['PLevel'])
                self.model.refresh_hero(state, hero)
                outcome = Outcome(consume=consume, heros=[deepcopy(hero)])
                return Reply({}, self.ledger.global_for(state, outcome, Slots=self.model.slots(state)))
            rewards = [dict(Type=30, ID=0, Count=amount)]
        elif kind == effects.get('knowledge'):
            rewards = [dict(Type=18, ID=0, Count=self.ledger.positive(prop['propValue']) * count)]
        elif kind == effects.get('change_name'):
            return self._change_name(ctx, params, consume)
        elif kind == effects.get('fix_gift'):
            if not isinstance(prop['propValue'], dict):
                raise BusinessError('礼包配置缺失')
            rewards = [dict(Type=x['Type'], ID=x['ID'], Count=x['Count'] * count, Level=x.get('Level'))
                       for x in prop['propValue'].values()]
        elif kind in (effects.get('random_gift'), effects.get('treasure_box'), effects.get('vip_random_gift')):
            gift = self.config.random_gifts.get(ident)
            if gift is None:
                raise BusinessError('该礼包的掉落表尚未配置，未消耗')
            if kind == effects.get('treasure_box'):
                key_id = int(prop.get('propValue') or 0)
                if key_id and self.ledger.bag_count(state, 5, key_id) < count:
                    raise BusinessError('缺少对应的钥匙')
                if key_id:
                    consume.append(dict(Type=5, ID=key_id, Count=count))
            rewards = self.ledger.draw(gift, count)
        elif kind == effects.get('key'):
            raise BusinessError('请使用对应的宝箱')
        elif kind == effects.get('potency'):
            if not params.get('heroId'):
                raise BusinessError('请选择要使用的主将')
            hero = self.model.find_hero(state, self.ledger.positive(params['heroId']))
            self.ledger.apply(state, consume=consume)
            hero['potency'] = hero.get('potency', 0) + self.ledger.positive(prop['propValue']) * count
            self.model.refresh_hero(state, hero)
            return Reply({}, self.ledger.global_for(state, Outcome(consume=consume, heros=[deepcopy(hero)])))
        else:
            raise BusinessError('该道具暂不支持使用，未消耗')
        outcome = self.ledger.apply(state, rewards=rewards, consume=consume)
        result = {'Reward': deepcopy(outcome.rewards)}
        return Reply(result, self.ledger.global_for(state, outcome))

    def _change_name(self, ctx: RoleContext, params, consume) -> Reply:
        if not params.get('name'):
            raise BusinessError('请输入新昵称')
        name = self.model.parse_nickname(params['name'])
        if self.repository.nickname_taken(ctx.db, name):
            raise BusinessError('昵称已存在', -1103001)
        outcome = self.ledger.apply(ctx.state, consume=consume)
        ctx.state['Name'] = name
        self.repository.rename(ctx.db, ctx.user, name)
        return Reply({'Name': name}, self.ledger.global_for(ctx.state, outcome))

    # ---- 商店 -------------------------------------------------------------

    def _goods(self, state: dict) -> list:
        result = []
        daily = state['Daily']
        for good in self.store.goods:
            template = self.catalog['BaseProps'].get(str(good.prop_id))
            if template is None:
                continue
            currency = good.currency if good.currency is not None else template.get('type')
            if currency not in (1, 2):
                continue
            bought = daily['store_buys'].get(str(good.prop_id), 0)
            limit = good.daily_limit
            if good.prop_id == self.store.energy_prop_id:
                limits = self.store.energy_daily_limit_by_vip
                limit = limits[min(state.get('VipLevel', 0), len(limits) - 1)]
                price = self.energy_price(bought + 1)
            else:
                price = good.price if good.price is not None else int(template.get('price', 0))
            result.append(dict(PropsID=good.prop_id, Price=price, CurrencyType=currency,
                               TodayHaveBuyCnt=(limit - bought) if limit else UNLIMITED,
                               TotalBuyCnt=bought, VipLvLimit=good.vip_limit, _limit=limit))
        return result

    def energy_price(self, nth: int) -> int:
        """第 nth 次购买体力丹的价格：EnergyChangePrices 中首个 maxCount ≥ nth 的档。"""
        ladder = sorted(self.catalog['EnergyChangePrices'].values(), key=lambda x: x['maxCount'])
        for step in ladder:
            if nth <= step['maxCount']:
                return int(step['price'])
        return int(ladder[-1]['price'])

    def store_list(self, ctx: RoleContext, params) -> list:
        """``/Prop/GetStorePropLst``。"""
        return [{k: v for k, v in good.items() if not k.startswith('_')} for good in self._goods(ctx.state)]

    def buy_goods(self, ctx: RoleContext, params) -> Reply:
        """``/Prop/BuyGoods``：按货架价格购买道具。"""
        ident = self.ledger.positive(params['id'])
        count = self.ledger.positive(params.get('count') or '1', self.config.max_operation_count)
        good = next((g for g in self._goods(ctx.state) if g['PropsID'] == ident), None)
        if good is None:
            raise BusinessError('商店没有该商品')
        state = ctx.state
        if state.get('VipLevel', 0) < good['VipLvLimit']:
            raise BusinessError(f'需要 VIP{good["VipLvLimit"]} 才能购买')
        if good['_limit'] and good['TodayHaveBuyCnt'] < count:
            raise BusinessError('今日购买次数不足')
        if ident == self.store.energy_prop_id:
            total = sum(self.energy_price(good['TotalBuyCnt'] + i) for i in range(1, count + 1))
        else:
            total = good['Price'] * count
        outcome = self.ledger.apply(state, rewards=[dict(Type=5, ID=ident, Count=count)],
                                    consume=[dict(Type=good['CurrencyType'], ID=0, Count=total)] if total else [])
        buys = state['Daily']['store_buys']
        buys[str(ident)] = buys.get(str(ident), 0) + count
        return Reply({'Reward': [dict(ID=ident, Count=count)]}, self.ledger.global_for(state, outcome))

    def suit_list(self, ctx: RoleContext, params) -> dict:
        """``/Prop/StoreSuitPropList``：套装商城，本地服暂无套装商品。"""
        return {'NTC': 0, 'NVL': 0, 'CountDown': 0, 'TotalCount': 0, 'HaveCount': 0, 'SuitProp': []}

    # ---- 神秘商店 -----------------------------------------------------------

    def _mystery(self, state: dict, force_refresh=False) -> dict:
        rule = self.store.mystery
        now = self.model.clock.now()
        shop = state.get('MysteryStore')
        if shop is None or force_refresh or now >= shop.get('free_at', 0):
            picks = self.ledger.rng.sample(list(rule.pool), min(rule.shelf_size, len(rule.pool)))
            shop = {'free_at': now + rule.free_refresh_seconds, 'shelf': [
                dict(Index=i + 1, Item=[dict(Type=p['Type'], ID=p['ID'], Count=p['Count'])],
                     HaveBuyTimes=0, Price=p['Price'], PriceType=p['PriceType']) for i, p in enumerate(picks)]}
            state['MysteryStore'] = shop
        return shop

    def mystery_info(self, ctx: RoleContext, params) -> dict:
        """``/Mysterystore/GetMysterystoreInfo``。"""
        shop = self._mystery(ctx.state)
        return {'HaveCDTime': Clock.remaining(shop['free_at'], self.model.clock.now()), 'HaveRefreshTime': UNLIMITED,
                'Ingot': self.store.mystery.refresh_ingot, 'Info': deepcopy(shop['shelf'])}

    def mystery_refresh(self, ctx: RoleContext, params) -> Reply:
        """``/Mysterystore/RefreshMysterystore``：付元宝立即刷新。"""
        cost = self.store.mystery.refresh_ingot
        outcome = self.ledger.apply(ctx.state, consume=[dict(Type=2, ID=0, Count=cost)] if cost else [])
        shop = self._mystery(ctx.state, force_refresh=True)
        return Reply({'HaveCDTime': Clock.remaining(shop['free_at'], self.model.clock.now()), 'HaveRefreshTime': UNLIMITED,
                      'Ingot': cost, 'Info': deepcopy(shop['shelf'])}, self.ledger.global_for(ctx.state, outcome))

    def mystery_buy(self, ctx: RoleContext, params) -> Reply:
        """``/Mysterystore/BuyMysterystore?Index``。"""
        index = self.ledger.positive(params['Index'])
        shop = self._mystery(ctx.state)
        slot = next((s for s in shop['shelf'] if s['Index'] == index), None)
        if slot is None:
            raise BusinessError('货架上没有该商品')
        if slot['HaveBuyTimes'] >= 1:
            raise BusinessError('该商品已售出')
        outcome = self.ledger.apply(ctx.state, rewards=slot['Item'],
                                    consume=[dict(Type=slot['PriceType'], ID=0, Count=slot['Price'])])
        slot = next(s for s in ctx.state['MysteryStore']['shelf'] if s['Index'] == index)
        slot['HaveBuyTimes'] = 1
        return Reply({'Info': deepcopy(ctx.state['MysteryStore']['shelf'])}, self.ledger.global_for(ctx.state, outcome))
