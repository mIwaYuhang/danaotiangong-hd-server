"""仙盟扩展：商店（/UnionStore/*）、魔族巢穴（/UnionDemon/*）、留言板（/UnionMessageBoard/*）、仙桃（/Union/Xiantao*）。

全部数据挂在仙盟文档（``UnionService`` 存取）上：
``store``（珍品批次与购买记录、竞拍状态）、``demons``（各节点剩余血量、伤害榜、击杀状态）、``board``（留言）。
玩家侧 ``state.Union`` 增加 ``fix_buys``（固定商品限购计数）、``demon``（每日挑战/复活次数与挑战中状态）、``xiantao``。
"""
import base64
from copy import deepcopy
import datetime as dt
import json

from ..config import thaw
from ..errors import BusinessError
from .base import Reply, RoleContext, global_block
from .battle import BattleEngine
from .clock import Clock
from .inventory import Ledger
from .player_state import PlayerModel
from .players import PlayerDirectory
from .union import UnionService, DEMON_CAVE, SHOP, LOG_BUY, LOG_AUCTION, ascii_len, decode_text

STATUS_CLOSED, STATUS_NEED_PREVIOUS, STATUS_OPEN, STATUS_FIGHTING, STATUS_CLEARED = 0, 1, 2, 3, 4
DEMON_KING_ID = 10
UNION_COIN = 27


class UnionStoreService:
    def __init__(self, config, union: UnionService, ledger: Ledger, clock: Clock, directory: PlayerDirectory):
        self.config = config
        self.union = union
        self.ledger = ledger
        self.clock = clock
        self.directory = directory

    # ---- 珍品（定时刷新的一批随机商品） -----------------------------------------------

    def _store(self, ctx: RoleContext, union: dict) -> dict:
        store = union.setdefault('store', {'batch_at': 0, 'zhenpin': [], 'auctions': {}})
        now = self.clock.now()
        if now >= store['batch_at'] + self.config['zhenpin_refresh_seconds']:
            pool = thaw(self.config['zhenpin_pool'])
            picks = self.ledger.rng.sample(pool, min(len(pool), self.config['zhenpin_count']))
            store['zhenpin'] = [dict(item, Index=i, HaveBuyTimes=1) for i, item in enumerate(picks, 1)]
            store['batch_at'] = now
        for i, item in enumerate(thaw(self.config['auction_items']), 1):
            auction = store['auctions'].setdefault(str(i), {'id': i, 'price': item['AuctionPrice'], 'bidder': 0, 'bidder_name': None,
                                                             'end': now + self.config['auction_seconds'], 'reward': item['Reward'], 'paid': {}})
            if now >= auction['end']:
                self._settle_auction(ctx, union, auction, item)
        return store

    def _grant(self, ctx: RoleContext, user_id: int, rewards: list):
        """给某位玩家发放物品：当前请求者直接写内存状态，其他玩家写存档。"""
        if user_id == ctx.user:
            self.ledger.apply(ctx.state, rewards=rewards)
            return
        other = self.directory.load_state(ctx.db, user_id)
        if other is not None:
            self.ledger.apply(other, rewards=rewards)
            self.directory.save_state(ctx.db, user_id, other)

    def _settle_auction(self, ctx: RoleContext, union: dict, auction: dict, item: dict):
        """竞拍到期：最高出价者获得物品，其余出价者退还晶石，然后开新一轮。"""
        if auction['bidder']:
            self.union._log(union, LOG_AUCTION, {'NowTPName': auction['bidder_name'], 'UCoin': auction['price']})
            self._grant(ctx, auction['bidder'], auction['reward'])
        for uid, paid in auction['paid'].items():
            if int(uid) != auction['bidder']:
                self._grant(ctx, int(uid), [dict(Type=UNION_COIN, ID=0, Count=paid)])
        auction.update(price=item['AuctionPrice'], bidder=0, bidder_name=None, end=self.clock.now() + self.config['auction_seconds'], paid={})

    def _open(self, ctx: RoleContext):
        union = self.union._mine(ctx)
        store = self._store(ctx, union)
        return union, store

    def zhenpin_info(self, ctx: RoleContext, params) -> dict:
        union, store = self._open(ctx)
        self.union._save(ctx.db, union)
        return {'HaveTimes': max(0, store['batch_at'] + self.config['zhenpin_refresh_seconds'] - self.clock.now()),
                'ZhenPinLst': [{k: v for k, v in item.items()} for item in store['zhenpin']]}

    def _pay(self, ctx: RoleContext, price: int, price_type: int, rewards: list):
        return self.ledger.apply(ctx.state, consume=[dict(Type=price_type, ID=0, Count=price)], rewards=rewards)

    def buy_zhenpin(self, ctx: RoleContext, params) -> Reply:
        union, store = self._open(ctx)
        item = next((z for z in store['zhenpin'] if z['Index'] == params['index']), None)
        if item is None:
            raise BusinessError('商品不存在')
        if item['HaveBuyTimes'] <= 0:
            raise BusinessError('该珍品已售出')
        if ctx.state.get('UnionCoin', 0) < item['Price'] and item['PriceType'] == UNION_COIN:
            raise BusinessError('晶石不足', -11430026)
        outcome = self._pay(ctx, item['Price'], item['PriceType'], item['RewardItem'])
        item['HaveBuyTimes'] -= 1
        self.union._log(union, LOG_BUY, {'NowTPName': ctx.state['Name'], 'UCoin': item['Price']})
        self.union._save(ctx.db, union)
        return Reply(item['HaveBuyTimes'], self.ledger.global_for(ctx.state, outcome))

    # ---- 固定商品 -------------------------------------------------------------

    def _fix_goods(self, ctx: RoleContext, union: dict) -> list:
        buys = self.union._player(ctx.state).setdefault('fix_buys', {})
        rows = []
        for index, item in enumerate(thaw(self.config['fix_goods']), 1):
            left = -1 if item['Limit'] < 0 else max(0, item['Limit'] - buys.get(str(index), 0))
            rows.append({'Index': index, 'HaveBuyTimes': left, 'Price': item['Price'], 'PriceType': item['PriceType'],
                         'Level': item['Level'], 'RewardItem': item['RewardItem']})
        return rows

    def fix_goods_info(self, ctx: RoleContext, params) -> list:
        union, _ = self._open(ctx)
        return self._fix_goods(ctx, union)

    def buy_fix_goods(self, ctx: RoleContext, params) -> Reply:
        union, _ = self._open(ctx)
        rows = self._fix_goods(ctx, union)
        item = next((r for r in rows if r['Index'] == params['index']), None)
        if item is None:
            raise BusinessError('商品不存在')
        if union['buildings'][str(SHOP)] < item['Level']:
            raise BusinessError('商店等级不足', -11430025)
        if item['HaveBuyTimes'] == 0:
            raise BusinessError('已达限购数量')
        if item['PriceType'] == UNION_COIN and ctx.state.get('UnionCoin', 0) < item['Price']:
            raise BusinessError('晶石不足', -11430026)
        outcome = self._pay(ctx, item['Price'], item['PriceType'], item['RewardItem'])
        buys = self.union._player(ctx.state).setdefault('fix_buys', {})
        buys[str(item['Index'])] = buys.get(str(item['Index']), 0) + 1
        self.union._log(union, LOG_BUY, {'NowTPName': ctx.state['Name'], 'UCoin': item['Price']})
        self.union._save(ctx.db, union)
        left = -1 if item['HaveBuyTimes'] < 0 else item['HaveBuyTimes'] - 1
        return Reply(left, self.ledger.global_for(ctx.state, outcome))

    # ---- 竞拍 -------------------------------------------------------------

    def auction_list(self, ctx: RoleContext, params) -> list:
        union, store = self._open(ctx)
        self.union._save(ctx.db, union)
        return [{'ID': a['id'], 'AuctionPrice': a['price'], 'HaveTimes': max(0, a['end'] - self.clock.now()), 'ActionPlayer': a['bidder_name'],
                 'Reward': [dict(r, Level=0) for r in a['reward']]} for a in sorted(store['auctions'].values(), key=lambda a: a['id'])]

    def bid(self, ctx: RoleContext, params) -> Reply:
        """``/UnionStore/Auction?id&price``：出价冻结晶石，被超越时退还。"""
        union, store = self._open(ctx)
        auction = store['auctions'].get(str(params['id']))
        if auction is None:
            raise BusinessError('竞拍品不存在')
        if auction['bidder'] == ctx.user:
            raise BusinessError('你已是最高出价者')
        floor = auction['price'] + (1 if auction['bidder'] else 0)
        if params['price'] < floor:
            raise BusinessError('出价不能低于当前价')
        if ctx.state.get('UnionCoin', 0) < params['price']:
            raise BusinessError('晶石不足', -11430026)
        outcome = self.ledger.apply(ctx.state, consume=[dict(Type=UNION_COIN, ID=0, Count=params['price'])])
        if auction['bidder']:
            self._grant(ctx, auction['bidder'], [dict(Type=UNION_COIN, ID=0, Count=auction['paid'].get(str(auction['bidder']), 0))])
        auction['paid'] = {str(ctx.user): params['price']}
        auction.update(price=params['price'], bidder=ctx.user, bidder_name=ctx.state['Name'])
        self.union._save(ctx.db, union)
        return Reply({}, self.ledger.global_for(ctx.state, outcome))


class UnionDemonService:
    """魔族巢穴：十个节点（10 号为魔王），血量按节点递增，由全盟成员共同击杀；每人每日 3 次挑战、2 次复活。"""

    def __init__(self, config, union: UnionService, model: PlayerModel, ledger: Ledger, engine: BattleEngine, clock: Clock):
        self.config = config
        self.union = union
        self.model = model
        self.ledger = ledger
        self.engine = engine
        self.clock = clock

    def _hp(self, demon_id: int) -> int:
        return int(self.config['hp_base'] * (self.config['hp_growth'] ** (demon_id - 1)))

    def _demons(self, union: dict) -> dict:
        data = union.setdefault('demons', {'day': '', 'nodes': {}})
        if data['day'] != self.clock.day_key():
            data['day'] = self.clock.day_key()
            data['nodes'] = {str(i): {'hp': self._hp(i), 'ranks': {}, 'killed': 0} for i in range(1, DEMON_KING_ID + 1)}
        return data

    def _mine(self, state: dict) -> dict:
        info = self.union._player(state)
        demon = info.setdefault('demon', {'day': '', 'used': 0, 'resurgences': 0, 'fighting': 0})
        if demon['day'] != self.clock.day_key():
            demon.update(day=self.clock.day_key(), used=0, resurgences=0, fighting=0)
        return demon

    def _open_level_for(self, demon_id: int) -> int:
        return 1 if demon_id <= 2 else (demon_id - 1) // 2 + 1

    def _status(self, union: dict, data: dict, demon_id: int, mine: dict) -> int:
        node = data['nodes'][str(demon_id)]
        if node['killed']:
            return STATUS_CLEARED
        if union['buildings'][str(DEMON_CAVE)] < self._open_level_for(demon_id):
            return STATUS_CLOSED
        if demon_id == DEMON_KING_ID:
            wins = sum(1 for i in range(1, DEMON_KING_ID) if data['nodes'][str(i)]['killed'])
            if wins < self.config['king_requires_wins']:
                return STATUS_NEED_PREVIOUS
        elif demon_id > 1 and not data['nodes'][str(demon_id - 1)]['killed']:
            return STATUS_NEED_PREVIOUS
        return STATUS_FIGHTING if mine.get('fighting') == demon_id else STATUS_OPEN

    def list_all(self, ctx: RoleContext, params) -> dict:
        union = self.union._mine(ctx)
        data = self._demons(union)
        mine = self._mine(ctx.state)
        self.union._save(ctx.db, union)
        infos = [{'demonID': i, 'challengeStatus': self._status(union, data, i, mine),
                  'leftHPRate': round(100 * data['nodes'][str(i)]['hp'] / self._hp(i), 1)} for i in range(1, DEMON_KING_ID)]
        won = [i for i in range(1, DEMON_KING_ID) if data['nodes'][str(i)]['killed']]
        return {'caveLv': union['buildings'][str(DEMON_CAVE)], 'canChallengeTime': self.config['daily_challenges'] - mine['used'],
                'challengeTotalTime': self.config['daily_challenges'], 'curUnionCoin': union['coin'],
                'openLvs': [{'openNeedLv': self._open_level_for(i)} for i in range(1, DEMON_KING_ID + 1)], 'demonInfos': infos,
                'demonKing': {'demonID': DEMON_KING_ID, 'challengeStatus': self._status(union, data, DEMON_KING_ID, mine),
                              'demonIDs': ','.join(str(i) for i in range(1, DEMON_KING_ID)), 'winDemonIDs': ','.join(str(i) for i in won)}}

    def _detail(self, ctx: RoleContext, union: dict, demon_id: int) -> dict:
        data = self._demons(union)
        node = data['nodes'][str(demon_id)]
        mine = self._mine(ctx.state)
        cfg = self.config
        ranks = sorted(node['ranks'].values(), key=lambda r: -r['damage'])
        reset = self.clock.seconds_until_next_day()
        return {'demonID': demon_id, 'demonName': f"魔族第 {demon_id} 关" if demon_id < DEMON_KING_ID else '仙盟妖王',
                'challengeStatus': self._status(union, data, demon_id, mine), 'leftHPRate': round(100 * node['hp'] / self._hp(demon_id), 1),
                'totalHP': self._hp(demon_id), 'gold': int(self._hp(demon_id) * cfg['gold_per_damage']), 'playerCoin': cfg['player_coin_per_kill'],
                'unionCoin': cfg['union_coin_per_kill'], 'playerUnionCoin': ctx.state.get('UnionCoin', 0),
                'challengeGold': 0, 'challengePlayerCoin': cfg['player_coin_per_challenge'], 'damageRate': 1.0, 'resetTime': reset,
                'remainChallengeTime': cfg['daily_challenges'] - mine['used'], 'remainResurgenceTime': cfg['daily_resurgences'] - mine['resurgences'],
                'resurgenceGold': cfg['resurgence_gold'], 'resurgenceIngot': cfg['resurgence_ingot'],
                'damageRanks': [{'name': r['name'], 'damage': r['damage']} for r in ranks[:20]],
                'dropGoods': [dict(Type=UNION_COIN, ID=0, Level=0, Count=cfg['player_coin_per_kill'])],
                'demonIDs': ','.join(str(i) for i in range(1, DEMON_KING_ID)),
                'winDemonIDs': ','.join(str(i) for i in range(1, DEMON_KING_ID) if data['nodes'][str(i)]['killed'])}

    def detail(self, ctx: RoleContext, params) -> dict:
        union = self.union._mine(ctx)
        demon_id = params.get('demonID') or params.get('demonKingID')
        if not 1 <= demon_id <= DEMON_KING_ID:
            raise BusinessError('魔族不存在')
        view = self._detail(ctx, union, demon_id)
        self.union._save(ctx.db, union)
        return view

    def challenge(self, ctx: RoleContext, params) -> Reply:
        """``/UnionDemon/Challenge?demonID&type``：type 1 首次开打（消耗次数）、2 复活后续打。"""
        state = ctx.state
        union = self.union._mine(ctx)
        demon_id = params.get('demonID') or params.get('demonKingID')
        data = self._demons(union)
        mine = self._mine(state)
        node = data['nodes'].get(str(demon_id))
        if node is None:
            raise BusinessError('魔族不存在', -11430027)
        status = self._status(union, data, demon_id, mine)
        if status == STATUS_CLEARED:
            raise BusinessError('该魔族已被击杀', -11430020)
        if status in (STATUS_CLOSED, STATUS_NEED_PREVIOUS):
            raise BusinessError('该魔族尚未开放', -11430021)
        if (params.get('type') or 1) == 2:
            if mine.get('fighting') != demon_id:
                raise BusinessError('当前不在挑战中', -11430029)
        else:
            if mine['used'] >= self.config['daily_challenges']:
                raise BusinessError('今日挑战次数已用完', -11430019)
            mine['used'] += 1
            mine['fighting'] = demon_id
        allies = [self.engine.hero_unit(h) for h in self.model.team_heroes(state)]
        npc_id = self.config['npc_ids'][(demon_id - 1) % len(self.config['npc_ids'])]
        enemy = self.engine.npc_unit(npc_id, state['PLevel'] + self.config['npc_level_offset'], 8, self.config['attr_multiplier'], hp_override=node['hp'])
        report = self.engine.simulate(allies, [enemy])
        damage = node['hp'] - max(0, enemy.hp)
        node['hp'] = max(0, enemy.hp)
        rank = node['ranks'].setdefault(str(ctx.user), {'name': state['Name'], 'damage': 0})
        rank['damage'] += damage
        rewards = [dict(Type=1, ID=0, Count=int(damage * self.config['gold_per_damage'])),
                   dict(Type=UNION_COIN, ID=0, Count=self.config['player_coin_per_challenge'])]
        killed = node['hp'] <= 0
        if killed:
            node['killed'] = 1
            union['coin'] += self.config['union_coin_per_kill']
            rewards.append(dict(Type=UNION_COIN, ID=0, Count=self.config['player_coin_per_kill']))
            mine['fighting'] = 0
        elif not report['isWin']:
            pass  # 失败但魔族未死：保持挑战中，可复活续打或放弃
        else:
            mine['fighting'] = 0
        outcome = self.ledger.apply(state, rewards=[r for r in rewards if r['Count'] > 0])
        mine = self._mine(state)
        self.union._save(ctx.db, union)
        report.update(total=1, dropList=[], Reward=deepcopy(outcome.rewards),
                      DemonChallenge={'hp': damage, 'leftHP': node['hp'], 'challengePlayerCoin': self.config['player_coin_per_challenge'],
                                      'challengeGold': int(damage * self.config['gold_per_damage']),
                                      'remainResurgenceTime': self.config['daily_resurgences'] - mine['resurgences'],
                                      'resurgenceGold': self.config['resurgence_gold'], 'resurgenceIngot': self.config['resurgence_ingot'],
                                      'remainChallengeTime': self.config['daily_challenges'] - mine['used'], 'demonState': 0 if killed else 1})
        return Reply(report, self.ledger.global_for(state, outcome))

    def give_up(self, ctx: RoleContext, params) -> dict:
        union = self.union._mine(ctx)
        demon_id = params.get('demonID') or params.get('demonKingID')
        mine = self._mine(ctx.state)
        if mine.get('fighting') != demon_id:
            raise BusinessError('当前不在挑战中', -11430029)
        mine['fighting'] = 0
        return self._detail(ctx, union, demon_id)

    def resurgence(self, ctx: RoleContext, params) -> Reply:
        """``/UnionDemon/Resurgence?demonID``：花银币（不足时元宝）复活，随后以 type=2 续打。"""
        state = ctx.state
        demon_id = params.get('demonID') or params.get('demonKingID')
        mine = self._mine(state)
        if mine.get('fighting') != demon_id:
            raise BusinessError('当前不在挑战中', -11430029)
        if mine['resurgences'] >= self.config['daily_resurgences']:
            raise BusinessError('今日复活次数已用完', -11430022)
        cost = dict(Type=1, ID=0, Count=self.config['resurgence_gold'])
        if state['Gold'] < cost['Count']:
            cost = dict(Type=2, ID=0, Count=self.config['resurgence_ingot'])
        outcome = self.ledger.apply(state, consume=[cost])
        self._mine(state)['resurgences'] += 1
        return Reply({}, self.ledger.global_for(state, outcome))


class UnionBoardService:
    def __init__(self, config, union: UnionService, clock: Clock):
        self.config = config
        self.union = union
        self.clock = clock

    def _view(self, entry: dict, user_id: int) -> dict:
        return {'PlayerName': entry['name'], 'SendTime': dt.datetime.fromtimestamp(entry['time']).strftime('%m-%d %H:%M'),
                'Content': base64.b64encode(entry['content'].encode('utf-8')).decode('ascii'), 'IfOneself': entry['user'] == user_id}

    def list_all(self, ctx: RoleContext, params) -> list:
        union = self.union._mine(ctx)
        return [self._view(e, ctx.user) for e in union.get('board', [])]

    def add(self, ctx: RoleContext, params) -> dict:
        union = self.union._mine(ctx)
        text = decode_text(params.get('unionContent') or '').strip()
        if not text:
            raise BusinessError('留言不能为空')
        if ascii_len(text) > self.config['notice_max_ascii']:
            raise BusinessError('留言过长', -1143016)
        entry = {'user': ctx.user, 'name': ctx.state['Name'], 'time': self.clock.now(), 'content': text}
        board = union.setdefault('board', [])
        board.insert(0, entry)
        union['board'] = board[:self.config['message_board_limit']]
        self.union._save(ctx.db, union)
        return self._view(entry, ctx.user)


class XiantaoService:
    """仙桃：每日免费吃若干次，之后花元宝；随机奖励，累计若干次给固定奖励。"""

    def __init__(self, config, union: UnionService, ledger: Ledger, clock: Clock):
        self.config = config
        self.union = union
        self.ledger = ledger
        self.clock = clock

    def _mine(self, state: dict) -> dict:
        info = self.union._player(state)
        data = info.setdefault('xiantao', {'day': '', 'eaten': 0, 'log': []})
        if data['day'] != self.clock.day_key():
            data.update(day=self.clock.day_key(), eaten=0)
        return data

    def _view(self, data: dict) -> dict:
        cfg = self.config
        return {'HaveFreeTime': max(0, cfg['daily_free'] - data['eaten']), 'Ingot': cfg['ingot'],
                'HaveTime': cfg['fixed_reward_every'] - data['eaten'] % cfg['fixed_reward_every'], 'Discount': 1,
                'FixReward': thaw(cfg['fixed_reward']), 'Log': list(data['log'])}

    def info(self, ctx: RoleContext, params) -> dict:
        self.union._mine(ctx)
        return self._view(self._mine(ctx.state))

    def eat(self, ctx: RoleContext, params) -> Reply:
        self.union._mine(ctx)
        state = ctx.state
        data = self._mine(state)
        cfg = self.config
        consume = [] if data['eaten'] < cfg['daily_free'] else [dict(Type=2, ID=0, Count=cfg['ingot'])]
        rewards = list(self.ledger.rng.choice(thaw(cfg['random_rewards'])))
        if (data['eaten'] + 1) % cfg['fixed_reward_every'] == 0:
            rewards.extend(thaw(cfg['fixed_reward']))
        outcome = self.ledger.apply(state, consume=consume, rewards=rewards)
        data = self._mine(state)
        data['eaten'] += 1
        data['log'].insert(0, json.dumps(outcome.rewards, ensure_ascii=False))
        data['log'] = data['log'][:20]
        view = self._view(data)
        view['Reward'] = deepcopy(outcome.rewards)
        return Reply(view, self.ledger.global_for(state, outcome))
