"""十二元辰殿（/Copy/*）与通天塔（/Tower/*）。

元辰殿：每殿 5 波（``FubenData.rounds``），每次请求打一波；开启消耗元辰石（每日 ``daily_keys``）；
刷星提高奖励与敌方强度；通关后用累计星数在翻牌商店兑换奖励，兑完即结束。

通天塔：每次挑战一层，三种难度决定积分与敌方倍率；每 ``floors_per_reward`` 层可领奖；
每胜 ``buff_exchange_per_floors`` 层获得一次 Buff 兑换；达到等级或 VIP 可扫荡。
"""
from copy import deepcopy

from ..config import thaw
from ..errors import BusinessError
from .base import Reply, RoleContext, global_block
from .battle import BattleEngine, ENEMY_POSITIONS
from .clock import Clock
from .inventory import Ledger
from .player_state import PlayerModel

FUBEN_ROUNDS = 5


class FubenService:
    def __init__(self, config, model: PlayerModel, ledger: Ledger, engine: BattleEngine, clock: Clock):
        self.config = config
        self.model = model
        self.ledger = ledger
        self.engine = engine
        self.clock = clock
        self.catalog = model.catalog

    def _state(self, state: dict) -> dict:
        fuben = state.setdefault('Fuben', {'day': '', 'keys': 0, 'copies': {}})
        today = self.clock.day_key()
        if fuben.get('day') != today:
            fuben.update(day=today, keys=self.config['daily_keys'])
        return fuben

    def _data(self, copy_id: int) -> dict:
        data = self.catalog['FubenData'].get(str(copy_id))
        if data is None:
            raise BusinessError('副本不存在')
        return data

    def _rewards_base(self, copy_id: int, star: int) -> dict:
        cfg = self.config
        growth = 1 + (copy_id - 1) * cfg['per_copy_growth']
        mult = cfg['star_multiplier'].get(str(star), 1.0)
        return dict(BaseGold=int(cfg['base_gold'] * growth * mult), BaseKnowledge=int(cfg['base_knowledge'] * growth * mult),
                    BaseExp=int(cfg['base_exp'] * growth * mult),
                    BattlePowerAdvise=int(1500 * growth * mult), RSL_ConsumeGold=int(cfg['refresh_gold'] * growth))

    def _view(self, copy_id: int, entry: dict) -> dict:
        view = dict(CopyID=copy_id, RoundID=entry.get('round'), StarLevel=entry['star'], StarLevelCount=entry['stars'],
                    IsComplete=entry.get('complete', 0), **self._rewards_base(copy_id, entry['star']))
        if entry.get('cards') is not None:
            view['OpenCardNumber'] = entry['stars']
            view['OpenCardReward'] = deepcopy(entry['cards'])
        return view

    def _entry(self, state: dict, copy_id: int) -> dict:
        entry = self._state(state)['copies'].get(str(copy_id))
        if entry is None:
            raise BusinessError('请先开启该殿')
        return entry

    # ---- 接口 -------------------------------------------------------------

    def info(self, ctx: RoleContext, params) -> dict:
        """``/Copy/PlayerCopyInfo``。"""
        fuben = self._state(ctx.state)
        copies = [self._view(int(k), v) for k, v in sorted(fuben['copies'].items(), key=lambda kv: int(kv[0]))]
        return {'Key': fuben['keys'], 'Copys': copies}

    def open_copy(self, ctx: RoleContext, params) -> Reply:
        """``/Copy/OpenCopy?copyId``：消耗元辰石开启（次数用完时可消耗解锁石道具）。"""
        state = ctx.state
        copy_id = params['copyId']
        data = self._data(copy_id)
        if state['PLevel'] < int(data.get('unlockLevel', 1)):
            raise BusinessError(f'{data["unlockLevel"]}级开放')
        fuben = self._state(state)
        current = fuben['copies'].get(str(copy_id))
        if current and not current.get('complete'):
            raise BusinessError('该殿尚未结束')
        outcome = None
        if fuben['keys'] > 0:
            fuben['keys'] -= 1
        elif self.ledger.bag_count(state, 5, self.config['unlock_prop_id']) > 0:
            outcome = self.ledger.apply(state, consume=[dict(Type=5, ID=self.config['unlock_prop_id'], Count=1)])
            fuben = self._state(state)
        else:
            raise BusinessError('元辰石不足')
        fuben['copies'][str(copy_id)] = {'round': 0, 'star': 1, 'stars': 0, 'complete': 0, 'cards': None}
        block = self.ledger.global_for(state, outcome) if outcome else None
        return Reply(self._view(copy_id, fuben['copies'][str(copy_id)]), block)

    def refresh_star(self, ctx: RoleContext, params) -> Reply:
        """``/Copy/RefreshStarLevel?copyId``：花银币把当前星级 +1（到上限后回到 1）。"""
        state = ctx.state
        copy_id = params['copyId']
        entry = self._entry(state, copy_id)
        if entry.get('round') is None or entry.get('complete'):
            raise BusinessError('当前无法刷新星级')
        cost = self._rewards_base(copy_id, entry['star'])['RSL_ConsumeGold']
        outcome = self.ledger.apply(state, consume=[dict(Type=1, ID=0, Count=cost)])
        entry = self._entry(state, copy_id)
        entry['star'] = entry['star'] + 1 if entry['star'] < self.config['max_star'] else 1
        base = self._rewards_base(copy_id, entry['star'])
        return Reply(dict(StarLevel=entry['star'], BaseExp=base['BaseExp'], BaseGold=base['BaseGold'],
                          BaseKnowledge=base['BaseKnowledge'], BattlePowerAdvise=base['BattlePowerAdvise']),
                     self.ledger.global_for(state, outcome))

    def battle(self, ctx: RoleContext, params) -> Reply:
        """``/Copy/BattleCopy?copyId``：打当前波。"""
        state = ctx.state
        copy_id = params['copyId']
        data = self._data(copy_id)
        entry = self._entry(state, copy_id)
        if entry.get('round') is None or entry.get('complete'):
            raise BusinessError('该殿已通关，请先领取翻牌奖励')
        wave = entry['round'] + 1
        round_data = data['rounds'].get(str(wave))
        if round_data is None:
            raise BusinessError('波次配置缺失')
        cfg = self.config
        level = cfg['npc_level_base'] + cfg['npc_level_per_copy'] * (copy_id - 1) + wave
        mult = cfg['npc_multiplier'] * cfg['star_multiplier'].get(str(entry['star']), 1.0) * (cfg['boss_multiplier'] if round_data.get('isBoss') else 1.0)
        allies = [self.engine.hero_unit(h) for h in self.model.team_heroes(state)]
        enemies = [self.engine.npc_unit(int(round_data['npcid']), int(level), ENEMY_POSITIONS[1], mult)]
        report = self.engine.simulate(allies, enemies)
        rewards = []
        if report['isWin']:
            base = self._rewards_base(copy_id, entry['star'])
            rewards = [dict(Type=1, ID=0, Count=base['BaseGold']), dict(Type=18, ID=0, Count=base['BaseKnowledge']),
                       dict(Type=3, ID=0, Count=base['BaseExp'])]
            entry['stars'] += entry['star']
            entry['round'] = wave
            if wave >= FUBEN_ROUNDS:
                entry['round'] = None
                entry['cards'] = [dict(Location=i + 1, Status=0, **{k: v for k, v in thaw(card).items()})
                                  for i, card in enumerate(cfg['card_rewards'])]
        outcome = self.ledger.apply(state, rewards=rewards)
        entry = self._entry(state, copy_id)
        report.update(total=1, dropList=deepcopy(outcome.rewards), Reward=deepcopy(outcome.rewards),
                      BattleResult={'PlayerCopyInfo': self._view(copy_id, entry)})
        return Reply(report, self.ledger.global_for(state, outcome, Slots=self.model.slots(state)))

    def open_card(self, ctx: RoleContext, params) -> Reply:
        """``/Copy/OpenCard?copyId&selectLocation``：用星数兑换翻牌奖励；星数用完则结束该殿。"""
        state = ctx.state
        copy_id = params['copyId']
        entry = self._entry(state, copy_id)
        cards = entry.get('cards')
        if not cards:
            raise BusinessError('当前没有可兑换的奖励')
        card = next((c for c in cards if c['Location'] == params['selectLocation']), None)
        if card is None:
            raise BusinessError('奖励不存在')
        if card['Last'] <= 0:
            raise BusinessError('该奖励已兑完')
        if entry['stars'] < card['Cost']:
            raise BusinessError('星星不足')
        reward = {k: card[k] for k in ('Type', 'ID', 'Count') if k in card}
        if 'quality' in card:
            reward['quality'] = card['quality']
        outcome = self.ledger.apply(state, rewards=[reward])
        entry = self._entry(state, copy_id)
        card = next(c for c in entry['cards'] if c['Location'] == params['selectLocation'])
        card['Last'] -= 1
        card['Status'] = 1 if card['Last'] <= 0 else 0
        entry['stars'] -= card['Cost']
        if entry['stars'] <= 0 or not any(c['Last'] > 0 and c['Cost'] <= entry['stars'] for c in entry['cards']):
            entry.update(complete=1, cards=None, stars=0)
        return Reply(entry['stars'], self.ledger.global_for(state, outcome))

    def preview(self, ctx: RoleContext, params) -> list:
        """``/Copy/GetPreviewInfo``。"""
        return [{'CopyID': int(k), 'Preview': [{kk: c[kk] for kk in ('Type', 'ID', 'Count')} for c in self.config['card_rewards']]}
                for k in sorted(self.catalog['FubenData'], key=int)]

    def reset(self, ctx: RoleContext, params):
        raise BusinessError('本地服不支持重置副本')


class TowerService:
    def __init__(self, config, model: PlayerModel, ledger: Ledger, engine: BattleEngine, clock: Clock):
        self.config = config
        self.model = model
        self.ledger = ledger
        self.engine = engine
        self.clock = clock
        self.catalog = model.catalog

    def _state(self, state: dict) -> dict:
        tower = state.setdefault('Tower', {'day': '', 'floor': 0, 'score': 0, 'used': 0, 'buff_times': 0,
                                           'bought': [], 'reward_floor': 0})
        if tower.get('day') != self.clock.day_key():
            tower.update(day=self.clock.day_key(), used=0)
        return tower

    def _info(self, tower: dict) -> dict:
        cfg = self.config
        pending = tower['floor'] - tower['reward_floor']
        have = cfg['floors_per_reward'] - pending % cfg['floors_per_reward'] if pending % cfg['floors_per_reward'] else cfg['floors_per_reward']
        info = dict(Floor=tower['floor'], HaveFloor=have, Score=tower['score'],
                    RemainTowerChallengeTime=cfg['daily_times'] - tower['used'], RemainBuyBuffTime=tower['buff_times'],
                    IsMopping=1 if tower['floor'] > 0 else 0, AddTotalPower=self._buff_power(tower), LastFiveFloorScore=0)
        if pending >= cfg['floors_per_reward']:
            info['HaveFloor'] = cfg['floors_per_reward']
            info['FloorsReward'] = {'Simp': self._floor_reward(tower['reward_floor'] + cfg['floors_per_reward'])}
        return info

    def _floor_reward(self, floor: int) -> list:
        growth = 1 + (floor // self.config['floors_per_reward']) * self.config['floor_reward_growth']
        return [dict(r, Count=int(r['Count'] * growth)) for r in thaw(self.config['floor_reward'])]

    def _buff_power(self, tower: dict) -> int:
        return sum(int(b['addtionRate'] * 1000) for b in self._bought_buffs(tower))

    def _bought_buffs(self, tower: dict) -> list:
        result = []
        for level in self.config['buff_store']:
            for buff in level['buffs']:
                if f'{level["storeLevel"]},{buff["index"]}' in tower['bought']:
                    result.append(buff)
        return result

    def _attr_bonus(self, tower: dict) -> dict:
        names = {1: 'health', 2: 'normalAttack', 3: 'normalDefense', 4: 'skillAttack', 5: 'skillDefense'}
        bonus = {}
        for buff in self._bought_buffs(tower):
            targets = names.values() if buff['addtionProperty'] == 99 else [names.get(buff['addtionProperty'])]
            for attr in targets:
                if attr:
                    bonus[attr] = bonus.get(attr, 0) + buff['addtionRate']
        return bonus

    def _floor_npc(self, floor: int) -> int:
        """按层数取一个真实 NPC 编号（用于模型渲染）：借用主线关卡的精英位。"""
        stages = sorted(int(k) for k in self.catalog['BaseStages'])
        stage = stages[min(len(stages) - 1, floor * 5)]
        return stage * 100 + 7 + (floor % 3)

    # ---- 接口 -------------------------------------------------------------

    def info(self, ctx: RoleContext, params) -> dict:
        """``/Tower/GetTowerInfo``。"""
        return self._info(self._state(ctx.state))

    def battle(self, ctx: RoleContext, params) -> Reply:
        """``/Tower/TowerBattle?type``：挑战下一层。"""
        state = ctx.state
        tower = self._state(state)
        cfg = self.config
        kind = cfg['types'].get(str(params['type']))
        if kind is None:
            raise BusinessError('难度不存在')
        if tower['used'] >= cfg['daily_times']:
            raise BusinessError('今日挑战次数已用完')
        if tower['floor'] >= cfg['max_floor']:
            raise BusinessError('已登顶')
        floor = tower['floor'] + 1
        allies = [self.engine.hero_unit(h) for h in self.model.team_heroes(state)]
        for unit in allies:
            for attr, rate in self._attr_bonus(tower).items():
                unit.attrs[attr] *= 1 + rate
            unit.hp = unit.hp_max = max(1, int(unit.attrs['health']))
        level = int(cfg['npc_level_base'] + cfg['npc_level_per_floor'] * floor)
        enemy = self.engine.npc_unit(self._floor_npc(floor), level, 8, cfg['npc_multiplier'] * kind['multiplier'])
        header = self.catalog['TowerNPCHeaders'].get(str(floor), {}).get(str(params['type']))
        if header:
            enemy.name = header['name']
        report = self.engine.simulate(allies, [enemy])
        tower['used'] += 1
        if report['isWin']:
            tower['floor'] = floor
            tower['score'] += kind['score']
            if floor % cfg['buff_exchange_per_floors'] == 0:
                tower['buff_times'] += 1
        report.update(total=1, dropList=[], Reward=[], BattleResult={}, Towerinfo=self._info(tower))
        return Reply(report, global_block(self.ledger.resource(state)))

    def mopping(self, ctx: RoleContext, params) -> Reply:
        """``/Tower/Mopping``：扫荡到已达最高层，消耗一次挑战。"""
        state = ctx.state
        tower = self._state(state)
        cfg = self.config
        if state['PLevel'] < cfg['sweep_level'] and state.get('VipLevel', 0) < cfg['sweep_vip']:
            raise BusinessError(f'{cfg["sweep_level"]}级或VIP{cfg["sweep_vip"]}开放扫荡')
        if tower['used'] >= cfg['daily_times']:
            raise BusinessError('今日挑战次数已用完')
        if tower['floor'] <= 0:
            raise BusinessError('尚无可扫荡的层数')
        tower['used'] += 1
        tower['score'] += cfg['types']['1']['score'] * tower['floor']
        tower['buff_times'] += tower['floor'] // cfg['buff_exchange_per_floors']
        info = self._info(tower)
        return Reply({'floor': tower['floor'], 'haveFloor': info['HaveFloor'], 'score': tower['score'], 'isMopping': 1},
                     global_block(self.ledger.resource(state)))

    def buffs(self, ctx: RoleContext, params) -> dict:
        """``/Tower/Buffs``。"""
        tower = self._state(ctx.state)
        levels = []
        for level in thaw(self.config['buff_store']):
            for buff in level['buffs']:
                buff['buyState'] = 1 if f'{level["storeLevel"]},{buff["index"]}' in tower['bought'] else 0
            levels.append(level)
        return {'remainBuyTime': tower['buff_times'], 'buffLevels': levels}

    def buy_buff(self, ctx: RoleContext, params) -> Reply:
        """``/Tower/Buy?buyBuff=storeLevel,index``。"""
        tower = self._state(ctx.state)
        key = (params.get('buyBuff') or '').strip()
        parts = key.split(',')
        if len(parts) != 2 or not all(p.isdigit() for p in parts):
            raise BusinessError('参数无效')
        level = next((l for l in self.config['buff_store'] if l['storeLevel'] == int(parts[0])), None)
        buff = next((b for b in (level['buffs'] if level else []) if b['index'] == int(parts[1])), None)
        if buff is None:
            raise BusinessError('Buff 不存在')
        if key in tower['bought']:
            raise BusinessError('已购买')
        if tower['buff_times'] <= 0:
            raise BusinessError('兑换次数不足')
        if tower['score'] < level['score']:
            raise BusinessError('积分不足')
        tower['score'] -= level['score']
        tower['buff_times'] -= 1
        tower['bought'].append(key)
        return Reply({'buffInfo': self.buffs(ctx, params), 'addTotalPower': self._buff_power(tower)})

    def buff_additions(self, ctx: RoleContext, params) -> list:
        """``/Tower/BuffPropertyAddtions``。"""
        return [dict(addtionProperty=b['addtionProperty'], addtionRate=b['addtionRate'], range=b.get('range', 2))
                for b in self._bought_buffs(self._state(ctx.state))]

    def floor_reward(self, ctx: RoleContext, params) -> Reply:
        """``/Tower/GetFloorReward``。"""
        state = ctx.state
        tower = self._state(state)
        cfg = self.config
        if tower['floor'] - tower['reward_floor'] < cfg['floors_per_reward']:
            raise BusinessError('尚未达到可领奖层数')
        tower['reward_floor'] += cfg['floors_per_reward']
        outcome = self.ledger.apply(state, rewards=self._floor_reward(tower['reward_floor']))
        return Reply({'Resource': deepcopy(outcome.rewards)}, self.ledger.global_for(state, outcome))

    def rank(self, ctx: RoleContext, params) -> list:
        """``/Tower/RankInfo`` 与 ``/Tower/LWRanking``：本地服只有自己。"""
        tower = self._state(ctx.state)
        return [dict(playerID=str(ctx.state['ID']), rank=1, name=ctx.state['Name'], level=ctx.state['PLevel'],
                     battlePower=self.model.team(ctx.state)['battlePower'], maxFloor=tower['floor'])]

    def revive(self, ctx: RoleContext, params) -> Reply:
        return Reply({})
