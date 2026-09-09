"""天命（/Destiny/*，40 级开放）。

静态表 ``BaseTianMings``（天命：品质、类型、分解经验、``upgradeData[1..10]`` 各级属性与升级经验）、
``BaseTianMingGus``（天命蛊 1..5 级：碎片需求与属性）、``TianMingUnlockLevel``（六个槽位的解锁等级）。

玩家状态 ``Destiny``：``bag``（实例 ``{id, destinyID, level, heroId, location}``）、``platform``（猎命台上未收取的天命 ID）、
``calls``（今日元宝猎命次数）。英雄记录 ``destinies``（槽位 → 实例 id）与 ``haloLevel``；展示时生成客户端的 ``destinyList``。
资源：天命经验 ``DestinyExp``（ItemType 36）、天命碎片 ``DestinyFragment``（37）。
"""
from copy import deepcopy

from ..errors import BusinessError
from .base import Reply, RoleContext, global_block
from .clock import Clock
from .inventory import Ledger
from .player_state import PlayerModel

ATTR_KEYS = ('health', 'normalAttack', 'normalDefense', 'skillAttack', 'skillDefense', 'mingzhong', 'shanbi', 'baoji',
             'renxing', 'poji', 'gedang', 'speed')
PROPERTY_KEYS = {'health': 'HP', 'normalAttack': 'AP', 'normalDefense': 'DEF', 'skillAttack': 'MAP', 'skillDefense': 'MDEF',
                 'speed': 'Speed', 'mingzhong': 'H', 'shanbi': 'D', 'baoji': 'C', 'renxing': 'TE', 'poji': 'B', 'gedang': 'BL'}
STATE_LOCKED, STATE_CANT_USE, STATE_AVAILABLE = 0, 1, 2
TYPE_DESTINY, TYPE_EXP, TYPE_FRAGMENT = 35, 36, 37


class DestinyService:
    def __init__(self, config, model: PlayerModel, ledger: Ledger, clock: Clock):
        self.config = config
        self.model = model
        self.ledger = ledger
        self.clock = clock
        self.catalog = model.catalog
        model.add_hero_bonus_provider(self.hero_bonus)
        model.add_addition_provider('destiny', self.addition)
        model.add_addition_provider('destinyHalo', self.halo_addition)

    # ---- 数据 -------------------------------------------------------------

    def _state(self, state: dict) -> dict:
        data = state.setdefault('Destiny', {'bag': {}, 'platform': [], 'next_id': 0, 'calls': {'day': '', 'used': 0}})
        if data['calls'].get('day') != self.clock.day_key():
            data['calls'] = {'day': self.clock.day_key(), 'used': 0}
        return data

    def template(self, destiny_id: int) -> dict:
        row = self.catalog['BaseTianMings'].get(str(destiny_id))
        if row is None:
            raise BusinessError('天命不存在')
        return row

    def unlock_levels(self) -> list:
        table = self.catalog['TianMingUnlockLevel']
        return [int(table[str(i)]) for i in range(1, len(table) + 1)]

    def attrs_of(self, instance: dict) -> dict:
        row = self.template(instance['destinyID'])['upgradeData'].get(str(instance['level']), {})
        return {k: int(v) for k, v in row.items() if k in ATTR_KEYS and v}

    def halo_attrs(self, level: int) -> dict:
        row = self.catalog['BaseTianMingGus'].get(str(level), {}) if level else {}
        return {k: int(v) for k, v in row.items() if k in ATTR_KEYS and v}

    def view(self, instance: dict) -> dict:
        return dict(id=instance['id'], destinyID=instance['destinyID'], level=instance['level'], **self.attrs_of(instance))

    def _instance(self, state: dict, instance_id) -> dict:
        instance = self._state(state)['bag'].get(str(instance_id))
        if instance is None:
            raise BusinessError('天命不存在')
        return instance

    def _create(self, state: dict, destiny_id: int) -> dict:
        data = self._state(state)
        data['next_id'] += 1
        instance = {'id': data['next_id'], 'destinyID': destiny_id, 'level': 1, 'heroId': 0, 'location': 0}
        data['bag'][str(instance['id'])] = instance
        return instance

    def _random_destiny(self, weights) -> int:
        quality = int(self.ledger.rng.choices([int(q) for q in weights], weights=list(weights.values()))[0])
        pool = [int(k) for k, r in self.catalog['BaseTianMings'].items() if int(r.get('quality', 0)) == quality]
        if not pool:
            pool = [int(k) for k in self.catalog['BaseTianMings']]
        return self.ledger.rng.choice(sorted(pool))

    # ---- 英雄加成与展示 ------------------------------------------------------------

    def hero_bonus(self, state: dict, hero: dict) -> dict:
        data = state.get('Destiny') or {'bag': {}}
        unlock = self.unlock_levels()
        slots, bonus = [], {}
        for location in range(1, len(unlock) + 1):
            instance = data['bag'].get(str((hero.get('destinies') or {}).get(str(location), 0)))
            if state['PLevel'] < unlock[location - 1]:
                slots.append({'state': STATE_LOCKED, 'destiny': None})
                continue
            slots.append({'state': STATE_AVAILABLE, 'destiny': self.view(instance) if instance else None})
            if instance:
                for attr, value in self.attrs_of(instance).items():
                    bonus[attr] = bonus.get(attr, 0) + value
        for attr, value in self.halo_attrs(hero.get('haloLevel', 0)).items():
            bonus[attr] = bonus.get(attr, 0) + value
        hero['destinyList'] = slots
        hero['haloLevel'] = hero.get('haloLevel', 0)
        return bonus

    def addition(self, state: dict):
        total = {}
        for hero in state['ownedHeros']:
            for location, instance_id in (hero.get('destinies') or {}).items():
                instance = (state.get('Destiny') or {'bag': {}})['bag'].get(str(instance_id))
                if instance:
                    for attr, value in self.attrs_of(instance).items():
                        total[PROPERTY_KEYS[attr]] = total.get(PROPERTY_KEYS[attr], 0) + value
        return total or None

    def halo_addition(self, state: dict):
        levels = [h.get('haloLevel', 0) for h in state['ownedHeros']]
        return [sum(1 for lv in levels if lv >= i) for i in range(1, 6)] if any(levels) else None

    # ---- 猎命台 -------------------------------------------------------------

    def _call_view(self, data: dict) -> dict:
        return {'ingot': self.config['call_ingot'], 'remainCallTime': max(0, self.config['daily_calls'] - data['calls']['used']),
                'callTime': data['calls']['used']}

    def info(self, ctx: RoleContext, params) -> dict:
        data = self._state(ctx.state)
        return {'rewards': list(data['platform']), 'hunts': {'1': {'gold': self.config['hunt_gold']}, '2': {'gold': self.config['hunt_gold']}},
                'huntIDs': list(data['platform']), 'call': self._call_view(data)}

    def _hunt_once(self, state: dict, kind: int) -> dict:
        data = self._state(state)
        if len(data['platform']) >= self.config['platform_size']:
            raise BusinessError('猎命台已满，请先收取或分解')
        if kind == 2:
            if data['calls']['used'] >= self.config['daily_calls']:
                raise BusinessError('今日元宝猎命次数已用完')
            outcome = self.ledger.apply(state, consume=[dict(Type=2, ID=0, Count=self.config['call_ingot'])])
            data = self._state(state)
            data['calls']['used'] += 1
            weights = self.config['quality_weights_ingot']
        else:
            outcome = self.ledger.apply(state, consume=[dict(Type=1, ID=0, Count=self.config['hunt_gold'])])
            data = self._state(state)
            weights = self.config['quality_weights_gold']
        destiny_id = self._random_destiny(weights)
        data['platform'].append(destiny_id)
        return {'outcome': outcome, 'destiny_id': destiny_id}

    def hunt(self, ctx: RoleContext, params) -> Reply:
        """``/Destiny/Hunt?type&id``：type 1 银币猎命、2 元宝猎命。"""
        if ctx.state['PLevel'] < self.config['open_level']:
            raise BusinessError('天命尚未开放')
        result = self._hunt_once(ctx.state, params['type'])
        data = self._state(ctx.state)
        return Reply({'Reward': [], 'huntIDs': list(data['platform']), 'huntRewards': [dict(Type=TYPE_DESTINY, ID=result['destiny_id'], Count=1)],
                      'call': self._call_view(data)}, self.ledger.global_for(ctx.state, result['outcome']))

    def hunt_all(self, ctx: RoleContext, params) -> Reply:
        """``/Destiny/HuntAll``：银币猎命直到台满。"""
        state = ctx.state
        data = self._state(state)
        rewards, consume = [], []
        while len(data['platform']) < self.config['platform_size'] and state['Gold'] >= self.config['hunt_gold']:
            result = self._hunt_once(state, 1)
            data = self._state(state)
            rewards.append(dict(Type=TYPE_DESTINY, ID=result['destiny_id'], Count=1))
            consume.extend(result['outcome'].consume)
        if not rewards:
            raise BusinessError('银币不足或猎命台已满', -1108001)
        block = global_block(self.ledger.resource(state))
        block['Consume'] = [dict(Type=1, ID=0, Count=sum(c['Count'] for c in consume))]
        return Reply({'Reward': [], 'huntIDs': list(data['platform']), 'huntRewards': rewards, 'call': self._call_view(data)}, block)

    def _take(self, state: dict, index: int) -> int:
        data = self._state(state)
        if not 1 <= index <= len(data['platform']):
            raise BusinessError('该位置没有天命')
        return data['platform'].pop(index - 1)

    def collect(self, ctx: RoleContext, params) -> Reply:
        """``/Destiny/Get?index``：把猎命台上的天命收入背包。"""
        destiny_id = self._take(ctx.state, params['index'])
        instance = self._create(ctx.state, destiny_id)
        block = global_block(self.ledger.resource(ctx.state))
        block['Destinys'] = [self.view(instance)]
        data = self._state(ctx.state)
        return Reply({'huntIDs': list(data['platform']), 'Destinys': [self.view(instance)]}, block)

    def _decompose_exp(self, state: dict, destiny_ids) -> Reply:
        exp = sum(int(self.template(d)['exp']) for d in destiny_ids)
        outcome = self.ledger.apply(state, rewards=[dict(Type=TYPE_EXP, ID=0, Count=exp)] if exp else [])
        return Reply({'Reward': deepcopy(outcome.rewards), 'huntIDs': list(self._state(state)['platform'])}, self.ledger.global_for(state, outcome))

    def decompose(self, ctx: RoleContext, params) -> Reply:
        """``/Destiny/Decompose?type&indexOrID``：type 1 猎命台位置、2 背包实例。"""
        state = ctx.state
        if params['type'] == 1:
            return self._decompose_exp(state, [self._take(state, params['indexOrID'])])
        instance = self._instance(state, params['indexOrID'])
        if instance['heroId']:
            raise BusinessError('已装备的天命不能分解')
        self._state(state)['bag'].pop(str(instance['id']))
        return self._decompose_exp(state, [instance['destinyID']])

    def decompose_all(self, ctx: RoleContext, params) -> Reply:
        """``/Destiny/DecomposeAll?type`` 与 ``/Destiny/Select?quality``：批量分解不高于所选品质的天命。"""
        state = ctx.state
        data = self._state(state)
        quality = params.get('quality') or data.get('select_quality') or 1
        if params.get('type') == 2:
            picked = [i for i in data['bag'].values() if not i['heroId'] and int(self.template(i['destinyID'])['quality']) <= quality]
            for instance in picked:
                data['bag'].pop(str(instance['id']))
            ids = [i['destinyID'] for i in picked]
        else:
            ids = [d for d in data['platform'] if int(self.template(d)['quality']) <= quality]
            data['platform'] = [d for d in data['platform'] if int(self.template(d)['quality']) > quality]
        if not ids:
            raise BusinessError('没有可分解的天命')
        return self._decompose_exp(state, ids)

    def select_quality(self, ctx: RoleContext, params) -> dict:
        self._state(ctx.state)['select_quality'] = params['quality']
        return {'quality': params['quality']}

    def bag(self, ctx: RoleContext, params) -> list:
        return [self.view(i) for i in sorted(self._state(ctx.state)['bag'].values(), key=lambda i: i['id']) if not i['heroId']]

    # ---- 穿戴 / 升级 / 天命蛊 ------------------------------------------------------

    def _hero_at(self, state: dict, index: int) -> dict:
        hero = next((h for h in state['ownedHeros'] if h.get('battleIx') == index), None)
        if hero is None:
            hero = self.model.find_hero(state, index)
        return hero

    def _reply_slots(self, state: dict, instances, outcome=None) -> Reply:
        self.model.refresh_all(state)
        block = self.ledger.global_for(state, outcome) if outcome else global_block(self.ledger.resource(state))
        block['Slots'] = self.model.slots(state)
        block['Destinys'] = [self.view(i) for i in instances]
        return Reply({}, block)

    def equip(self, ctx: RoleContext, params) -> Reply:
        """``/Destiny/Change?index&location&destinyID``：给英雄的某个槽位穿戴天命。"""
        state = ctx.state
        hero = self._hero_at(state, params['index'])
        location = params['location']
        unlock = self.unlock_levels()
        if not 1 <= location <= len(unlock) or state['PLevel'] < unlock[location - 1]:
            raise BusinessError('该天命槽位尚未解锁')
        instance = self._instance(state, params['destinyID'])
        if instance['heroId']:
            raise BusinessError('该天命已被装备')
        destinies = hero.setdefault('destinies', {})
        changed = [instance]
        old = self._state(state)['bag'].get(str(destinies.get(str(location), 0)))
        if old:
            old.update(heroId=0, location=0)
            changed.append(old)
        instance.update(heroId=hero['heroId'], location=location)
        destinies[str(location)] = instance['id']
        return self._reply_slots(state, changed)

    def unequip(self, ctx: RoleContext, params) -> Reply:
        state = ctx.state
        instance = self._instance(state, params['destinyID'])
        if not instance['heroId']:
            raise BusinessError('该天命未装备')
        hero = self.model.find_hero(state, instance['heroId'])
        hero.get('destinies', {}).pop(str(instance['location']), None)
        instance.update(heroId=0, location=0)
        return self._reply_slots(state, [instance])

    def equip_all(self, ctx: RoleContext, params) -> Reply:
        """``/Destiny/ChangeAll?index``：把背包里最强的天命填入空槽。"""
        state = ctx.state
        hero = self._hero_at(state, params['index'])
        unlock = self.unlock_levels()
        destinies = hero.setdefault('destinies', {})
        spare = sorted((i for i in self._state(state)['bag'].values() if not i['heroId']),
                       key=lambda i: (-int(self.template(i['destinyID'])['quality']), -i['level']))
        changed = []
        for location in range(1, len(unlock) + 1):
            if state['PLevel'] < unlock[location - 1] or destinies.get(str(location)) or not spare:
                continue
            instance = spare.pop(0)
            instance.update(heroId=hero['heroId'], location=location)
            destinies[str(location)] = instance['id']
            changed.append(instance)
        if not changed:
            raise BusinessError('没有可装备的天命')
        return self._reply_slots(state, changed)

    def upgrade(self, ctx: RoleContext, params) -> Reply:
        """``/Destiny/Upgrade?id``：消耗天命经验升一级。"""
        state = ctx.state
        instance = self._instance(state, params['id'])
        if instance['level'] >= self.config['max_level']:
            raise BusinessError('天命已满级')
        need = int(self.template(instance['destinyID'])['upgradeData'][str(instance['level'])].get('upgradeExp', 0))
        outcome = self.ledger.apply(state, consume=[dict(Type=TYPE_EXP, ID=0, Count=need)])
        instance = self._instance(state, params['id'])
        instance['level'] += 1
        return self._reply_slots(state, [instance], outcome)

    def halo_upgrade(self, ctx: RoleContext, params) -> Reply:
        """``/Destiny/HaloUpgrade?index``：消耗天命碎片提升英雄的天命蛊等级。"""
        state = ctx.state
        hero = self._hero_at(state, params['index'])
        level = hero.get('haloLevel', 0)
        row = self.catalog['BaseTianMingGus'].get(str(level + 1))
        if row is None:
            raise BusinessError('天命蛊已满级')
        outcome = self.ledger.apply(state, consume=[dict(Type=TYPE_FRAGMENT, ID=0, Count=int(row['needFragNum']))])
        hero = self.model.find_hero(state, hero['heroId'])
        hero['haloLevel'] = level + 1
        return self._reply_slots(state, [], outcome)

    def change_halo(self, ctx: RoleContext, params) -> Reply:
        """``/Destiny/ChangeHalo?afterLevel``：按阵位重排天命蛊等级（必须是当前等级的重新分配）。"""
        state = ctx.state
        wanted = [int(x) for x in (params.get('afterLevel') or '').split(',') if x.strip().lstrip('-').isdigit()]
        team = [h for h in state['ownedHeros'] if h.get('battleIx')]
        team.sort(key=lambda h: h['battleIx'])
        if len(wanted) < len(team) or sorted(wanted[:len(team)]) != sorted(h.get('haloLevel', 0) for h in team):
            raise BusinessError('天命蛊分配不合法')
        for hero, level in zip(team, wanted):
            hero['haloLevel'] = level
        return self._reply_slots(state, [])

    # ---- 兑换 / 百万猎命 -----------------------------------------------------------

    def exchange_info(self, ctx: RoleContext, params) -> list:
        exchanges = []
        for ex in self.config['exchanges']:
            pool = sorted(int(k) for k, r in self.catalog['BaseTianMings'].items() if int(r.get('quality', 0)) == ex['quality'])
            exchanges.append({'id': ex['id'], 'fragment': ex['fragment'], 'destinys': [{'destinyID': d} for d in pool], 'needDestinys': []})
        return [{'openLevel': self.config['open_level'], 'exchanges': exchanges}]

    def exchange(self, ctx: RoleContext, params) -> Reply:
        """``/Destiny/Exchange?exchangeID&destinyIDs``：用天命碎片兑换指定品质的天命。"""
        state = ctx.state
        ex = next((e for e in self.config['exchanges'] if e['id'] == params['exchangeID']), None)
        if ex is None:
            raise BusinessError('兑换项不存在')
        wanted = [int(x) for x in (params.get('destinyIDs') or '').split(',') if x.strip().isdigit()]
        destiny_id = wanted[0] if wanted else self._random_destiny({str(ex['quality']): 1})
        if int(self.template(destiny_id)['quality']) != ex['quality']:
            raise BusinessError('该天命不属于此兑换项')
        outcome = self.ledger.apply(state, consume=[dict(Type=TYPE_FRAGMENT, ID=0, Count=ex['fragment'])])
        instance = self._create(state, destiny_id)
        block = self.ledger.global_for(state, outcome)
        block['Destinys'] = [self.view(instance)]
        return Reply({'Destinys': [self.view(instance)]}, block)

    def million_hunt(self, ctx: RoleContext, params) -> dict:
        data = self._state(ctx.state)
        counts = data.setdefault('million', {'green': 0, 'blue': 0, 'purple': 0, 'orange': 0, 'fragment': 0, 'exp': 0, 'destiny': 0, 'isGet': 0})
        return dict(counts)

    def notify(self, state: dict) -> dict:
        return {'IsOpenDestiny': 1 if state['PLevel'] >= self.config['open_level'] else 0}
