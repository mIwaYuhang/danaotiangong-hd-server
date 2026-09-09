"""炼化炉（/RefiningFurnace/*）、好友（/Friend/*）、运镖（/Transport/*）——单机适配版。

炼化：主将/将魂返还魂玉，绿蓝装备返银币，紫橙装备返喂灵石，碎片返银币；重生把主将/装备回到 1 级并返还部分材料。
好友：本地服没有其他玩家，好友列表为空，推荐列表给出机器人，加好友/赠送等操作返回成功但不落地。
运镖：召唤/刷新马匹、选择目的地开始运镖、到时或提前结束领取银币；劫镖对象为空。
"""
from copy import deepcopy
import math

from ..config import thaw
from ..errors import BusinessError
from .base import Reply, RoleContext, global_block
from .clock import Clock
from .inventory import Ledger
from .player_state import PlayerModel


class RefineService:
    def __init__(self, config, model: PlayerModel, ledger: Ledger, equipment):
        self.config = config
        self.model = model
        self.ledger = ledger
        self.equipment = equipment
        self.catalog = model.catalog

    @staticmethod
    def _entries(raw: str) -> list:
        return [part for part in (raw or '').split(';') if part.strip()]

    def refine(self, ctx: RoleContext, params) -> Reply:
        """``/RefiningFurnace/Refine?heros&souls&talismans&fragments``。"""
        state = ctx.state
        cfg = self.config
        rewards, consume, removed_heroes = [], [], []
        for raw in self._entries(params.get('heros')):
            hero = self.model.find_hero(state, self.ledger.positive(raw))
            if hero.get('battleIx', 0) > 0:
                raise BusinessError('上阵主将不能炼化')
            if hero['heroId'] in self.model.starter_ids():
                raise BusinessError('初始主将不能炼化')
            quality = self.model.heroes.template(hero['heroId'])['quality']
            rewards.append(dict(Type=25, ID=0, Count=int(cfg['soul_jade_by_quality'].get(str(quality), 1)) * (1 + hero.get('rebirthCount', 0))))
            removed_heroes.append(hero['heroId'])
        for raw in self._entries(params.get('souls')):
            soul_id, count = (raw.split(',') + ['1'])[:2]
            soul_id, count = self.ledger.positive(soul_id), self.ledger.positive(count)
            figure = self.catalog['BaseSouls'].get(str(soul_id))
            if figure is None:
                raise BusinessError('将魂不存在')
            quality = self.model.heroes.template(int(figure['figureId']))['quality']
            consume.append(dict(Type=4, ID=soul_id, Count=count))
            rewards.append(dict(Type=25, ID=0, Count=max(1, int(cfg['soul_jade_by_quality'].get(str(quality), 1)) * count // 10)))
        for raw in self._entries(params.get('talismans')):
            instance = self.equipment.get(state, self.ledger.positive(raw))
            if instance.get('heroId'):
                raise BusinessError('请先卸下法宝')
            quality = self.equipment.template(instance['equipId'])['quality']
            if str(quality) in cfg['equip_feed_stone_by_quality']:
                rewards.append(dict(Type=6, ID=200128, Count=int(cfg['equip_feed_stone_by_quality'][str(quality)])))
            else:
                rewards.append(dict(Type=1, ID=0, Count=int(cfg['equip_gold_by_quality'].get(str(quality), 500))))
            consume.append(dict(Type=10, ID=instance['equipUserId'], Count=1))
        for raw in self._entries(params.get('fragments')):
            fragment_id, count = (raw.split(',') + ['1'])[:2]
            fragment_id, count = self.ledger.positive(fragment_id), self.ledger.positive(count)
            consume.append(dict(Type=23, ID=fragment_id, Count=count))
            rewards.append(dict(Type=1, ID=0, Count=int(cfg['fragment_gold']) * count))
        if not rewards:
            raise BusinessError('请选择要炼化的物品')
        outcome = self.ledger.apply(state, rewards=rewards, consume=consume)
        for hero_id in removed_heroes:
            state['ownedHeros'] = [h for h in state['ownedHeros'] if h['heroId'] != hero_id]
            state['partnerTeam'] = [p for p in state['partnerTeam'] if p.get('HeroID') != hero_id]
        return Reply({'Reward': deepcopy(outcome.rewards)}, self.ledger.global_for(state, outcome))

    def rebirth(self, ctx: RoleContext, params) -> Reply:
        """``/RefiningFurnace/Rebirth?heroID&talismanID``：重生主将或法宝。"""
        state = ctx.state
        cfg = self.config
        hero_raw, equip_raw = params.get('heroID') or '', params.get('talismanID') or ''
        if hero_raw:
            hero = self.model.find_hero(state, self.ledger.positive(hero_raw))
            template = self.model.heroes.template(hero['heroId'])
            quality = str(template['quality'])
            cost = int(cfg['hero_rebirth_ingot'].get(quality, 0)) + int(cfg['hero_rebirth_ingot_per_stage'].get(quality, 0)) * hero.get('rebirthCount', 0)
            rewards = []
            for stage in range(1, hero.get('rebirthCount', 0) + 1):
                data = self.model.heroes.rebirth_stage(template, stage)
                if data.get('soulId') and data.get('soulCount'):
                    rewards.append(dict(Type=4, ID=int(data['soulId']), Count=int(data['soulCount'])))
            outcome = self.ledger.apply(state, rewards=rewards, consume=[dict(Type=2, ID=0, Count=cost)] if cost else [])
            hero = self.model.find_hero(state, hero['heroId'])
            hero.update(level=1, curExp=0, rebirthCount=0, potency=0, rageSkillLevel=1,
                        trainDims={k: 0 for k in hero.get('trainDims', {})})
            self.model.refresh_hero(state, hero)
            outcome.heros.append(deepcopy(hero))
            return Reply({'Reward': deepcopy(outcome.rewards)}, self.ledger.global_for(state, outcome, Slots=self.model.slots(state)))
        if equip_raw:
            instance = self.equipment.get(state, self.ledger.positive(equip_raw))
            quality = str(self.equipment.template(instance['equipId'])['quality'])
            cost = int(cfg['equip_rebirth_ingot'].get(quality, 0))
            refund = 0
            probe = dict(instance, level=1)
            for _ in range(instance['level'] - 1):
                refund += self.equipment.intensify_cost(probe)
                probe['level'] += 1
            refund = int(refund * cfg['intensify_refund_ratio'])
            outcome = self.ledger.apply(state, rewards=[dict(Type=1, ID=0, Count=refund)] if refund else [],
                                        consume=[dict(Type=2, ID=0, Count=cost)] if cost else [])
            instance = self.equipment.get(state, instance['equipUserId'])
            instance.update(level=1, pinJie=1, pinJieLevel=0)
            self.equipment.compute(instance)
            if instance.get('heroId'):
                self.model.refresh_hero(state, self.model.find_hero(state, instance['heroId']))
            block = self.ledger.global_for(state, outcome, Slots=self.model.slots(state))
            block['Talismans'] = [deepcopy(instance)]
            return Reply({'Reward': deepcopy(outcome.rewards)}, block)
        raise BusinessError('请选择要重生的主将或法宝')


class FriendService:
    def __init__(self, config, model: PlayerModel, ledger: Ledger, clock: Clock):
        self.config = config
        self.model = model
        self.ledger = ledger
        self.clock = clock

    def friends(self, ctx: RoleContext, params) -> dict:
        return {'friendList': [], 'friendCountMax': self.config['friend_count_max'], 'requestCount': 0,
                'getEnergyNumber': self.config['daily_energy_gets']}

    def requests(self, ctx: RoleContext, params) -> list:
        return []

    def recommend(self, ctx: RoleContext, params) -> list:
        return [dict(userId=900000 + i, name=r['name'], level=r['level'], battlePower=r['battlePower'],
                     headerId=r['headerId'], presentState=1) for i, r in enumerate(self.config['recommend_robots'], 1)]

    def presents(self, ctx: RoleContext, params) -> dict:
        return {'presents': [], 'remainGetTime': self.config['daily_energy_gets']}

    def noop(self, ctx: RoleContext, params) -> dict:
        """加好友、赠送、删除等：本地服没有其他玩家，返回成功以免客户端报错。"""
        return {}

    def notify(self, state: dict) -> dict:
        return {'Friend': 0}


class TransportService:
    def __init__(self, config, model: PlayerModel, ledger: Ledger, clock: Clock):
        self.config = config
        self.model = model
        self.ledger = ledger
        self.clock = clock

    def _state(self, state: dict) -> dict:
        tr = state.setdefault('Transport', {'day': '', 'used': 0, 'rob_used': 0, 'refreshes': 0, 'horse': 1,
                                            'run': None, 'reward': None, 'logs': []})
        if tr.get('day') != self.clock.day_key():
            tr.update(day=self.clock.day_key(), used=0, rob_used=0, refreshes=0)
        self._settle(state, tr)
        return tr

    def _settle(self, state: dict, tr: dict):
        run = tr.get('run')
        if run and self.clock.now() >= run['end']:
            self._finish(state, tr)

    def _finish(self, state: dict, tr: dict):
        run = tr['run']
        gold = run['gold']
        self.ledger.apply(state, rewards=[dict(Type=1, ID=0, Count=gold)])
        tr['reward'] = {'BeRobedTime': 0, 'LostGold': 0, 'Gold': gold, 'SurpriseReward': []}
        tr['logs'].insert(0, {'Times': self.clock.now(), 'Content': f'{{"gold":{gold},"address":{run["address"]}}}', 'Type': 101})
        tr['logs'] = tr['logs'][:20]
        tr['run'] = None

    def _horse_gold(self, state: dict, horse: int) -> int:
        base = int(self.config['horses'][str(horse)]['Gold'])
        return base + int(self.config['gold_per_level']) * state['PLevel']

    def _horse_list(self, state: dict) -> dict:
        return {k: dict(Gold=self._horse_gold(state, int(k)), HaveSreward=v['HaveSreward'], CallCost=v['CallCost'])
                for k, v in self.config['horses'].items()}

    def info(self, ctx: RoleContext, params) -> dict:
        """``/Transport/GetPlayerTransportInfo``。"""
        state = ctx.state
        tr = self._state(state)
        cfg = self.config
        run = tr.get('run')
        result = {'HaveTime': Clock.remaining(run['end'], self.clock.now()) if run else (-1 if tr['used'] == 0 and not tr['reward'] else 0),
                  'HaveTransTime': cfg['daily_transport_times'] - tr['used'], 'HaveRobTime': cfg['daily_rob_times'] - tr['rob_used'],
                  'IsHaveUnReadLog': 0, 'horseInfos': [], 'budgetReward': {}}
        if run:
            result['horseInfos'] = [dict(HourseType=run['horse'], AdressId=run['address'], HaveTime=result['HaveTime'],
                                         PlayerID=str(state['ID']), PlayerName=state['Name'], Plv=state['PLevel'],
                                         AvatarId=self.model.team_heroes(state)[0]['heroId'],
                                         TotalPower=self.model.team(state)['battlePower'], BeRobedTime=0,
                                         TotalCanBeRobedTime=3, RobRewardGold=run['gold'] // 10)]
            result['budgetReward'] = {'Gold': run['gold'], 'HaveSreward': cfg['horses'][str(run['horse'])]['HaveSreward'], 'Addition': 0}
        if tr.get('reward'):
            result['getReward'] = tr.pop('reward')
        return result

    def select(self, ctx: RoleContext, params) -> dict:
        """``/Transport/GetPlayerTransportSelect``。"""
        state = ctx.state
        tr = self._state(state)
        cfg = self.config
        return {'HorseType': tr['horse'], 'Blessing': 0, 'HaveTransTime': cfg['daily_transport_times'] - tr['used'],
                'HaveRefreshTime': max(0, cfg['free_refresh_times'] - tr['refreshes']),
                'RefreshNeedIngot': 0 if tr['refreshes'] < cfg['free_refresh_times'] else cfg['refresh_ingot'],
                'HorseLst': self._horse_list(state),
                'AddLst': {k: {'Times': v['seconds'] // 60} for k, v in cfg['destinations'].items()}}

    def _roll_horse(self) -> int:
        weights = self.config['horse_weights']
        return int(self.ledger.rng.choices(list(weights), weights=list(weights.values()), k=1)[0])

    def refresh_horse(self, ctx: RoleContext, params) -> Reply:
        """``/Transport/RefreshHorse?type``：刷新马匹品质（免费次数用完后花元宝）。"""
        tr = self._state(ctx.state)
        cfg = self.config
        cost = 0 if tr['refreshes'] < cfg['free_refresh_times'] else cfg['refresh_ingot']
        outcome = self.ledger.apply(ctx.state, consume=[dict(Type=2, ID=0, Count=cost)] if cost else [])
        tr = self._state(ctx.state)
        tr['refreshes'] += 1
        tr['horse'] = max(tr['horse'], self._roll_horse()) if self.ledger.rng.random() < 0.5 else self._roll_horse()
        return Reply({'type': tr['horse']}, self.ledger.global_for(ctx.state, outcome))

    def call_horse(self, ctx: RoleContext, params) -> Reply:
        """``/Transport/CallHorse?type``：花元宝直接召唤指定品质。"""
        horse = params['type']
        if str(horse) not in self.config['horses']:
            raise BusinessError('马匹类型不存在')
        cost = int(self.config['horses'][str(horse)]['CallCost']) or int(self.config['call_horse_ingot'])
        outcome = self.ledger.apply(ctx.state, consume=[dict(Type=2, ID=0, Count=cost)])
        tr = self._state(ctx.state)
        tr['horse'] = horse
        return Reply({'type': horse}, self.ledger.global_for(ctx.state, outcome))

    def start(self, ctx: RoleContext, params) -> Reply:
        """``/Transport/StartPlayerTransport?addresId&friendIds``。"""
        state = ctx.state
        tr = self._state(state)
        cfg = self.config
        dest = cfg['destinations'].get(str(params['addresId']))
        if dest is None:
            raise BusinessError('目的地不存在')
        if tr.get('run'):
            raise BusinessError('已有镖车在途')
        if tr['used'] + dest['times'] > cfg['daily_transport_times']:
            raise BusinessError('今日运镖次数不足')
        tr['used'] += dest['times']
        now = self.clock.now()
        tr['run'] = {'horse': tr['horse'], 'address': params['addresId'], 'start': now, 'end': now + dest['seconds'],
                     'gold': int(self._horse_gold(state, tr['horse']) * dest['multiplier'])}
        tr['horse'] = 1
        return Reply(self.info(ctx, params))

    def end(self, ctx: RoleContext, params) -> Reply:
        """``/Transport/EndTransport``：提前结束，按剩余分钟收元宝。"""
        state = ctx.state
        tr = self._state(state)
        run = tr.get('run')
        if not run:
            raise BusinessError('当前没有运镖')
        remaining = Clock.remaining(run['end'], self.clock.now())
        cost = math.ceil(remaining / 60) * int(self.config['early_end_ingot_per_minute'])
        outcome = self.ledger.apply(state, consume=[dict(Type=2, ID=0, Count=cost)] if cost else [])
        tr = self._state(state)
        if tr.get('run'):
            self._finish(state, tr)
        block = self.ledger.global_for(state, outcome)
        return Reply(self.info(ctx, params), block)

    def bless_info(self, ctx: RoleContext, params) -> dict:
        return {'incenseLevel': 1, 'curExp': 0, 'upgradeExp': 100, 'transportAddition': 0, 'tenEnable': 1,
                'hundredEnable': 1, 'thousandEnable': 1}

    def bless(self, ctx: RoleContext, params):
        raise BusinessError('本地服暂未开放祝福')

    def friends(self, ctx: RoleContext, params) -> list:
        return []

    def rob(self, ctx: RoleContext, params):
        raise BusinessError('本地服没有可劫的镖车')

    def logs(self, ctx: RoleContext, params) -> list:
        tr = self._state(ctx.state)
        return deepcopy(tr['logs'])
