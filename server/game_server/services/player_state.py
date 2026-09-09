"""角色状态模型：初始状态、存档迁移、每日重置、体力恢复、英雄刷新、阵容派生、客户端投影。

状态（``state``）是一个 JSON 字典，持久化在 ``roles.state_json``。持久字段与派生字段的约定：
- 持久：资源、英雄记录（``ownedHeros``，``battleIx`` 0 表示未上阵）、装备实例（``Talismans``）、背包、进度、各系统块；
- 派生（每次 ``tick``/``presentation`` 重算）：英雄展示属性与战力、``team``、``ETime/ETotalTime``、``HaveDoubleExpTime``、``Map.CdTime``。

``_v`` 为状态结构版本，``migrate()`` 负责把旧存档升级到当前版本，只增不删。
"""
import base64
import binascii
from copy import deepcopy
import unicodedata

from ..config import PlayerConfig, thaw
from ..errors import BusinessError
from .clock import Clock
from .equipment import EquipmentModel
from .hero_model import HeroModel, new_hero_record

STATE_VERSION = 2
#: 客户端 netstate.lua：NoNickName，触发选英雄 / 起名流程。
STATE_NO_NICKNAME = -1103002


def empty_slot(position: int) -> dict:
    return dict(heroId=0, battleIx=position, battlePower=0, equipList=[], destinyList=[])


class PlayerModel:
    def __init__(self, config: PlayerConfig, catalog, heroes: HeroModel, equipment: EquipmentModel, clock: Clock):
        self.config = config
        self.catalog = catalog
        self.heroes = heroes
        self.equipment = equipment
        self.clock = clock
        self._notify_providers = []
        self._level_up_listeners = []
        self._team_bonus_providers = []
        self._addition_providers = []

    def add_notify_provider(self, provider):
        """注册 ``provider(state) -> dict``，用于填充 Notify 红点计数。"""
        self._notify_providers.append(provider)

    def add_team_bonus_provider(self, provider):
        """注册 ``provider(state) -> {属性名: 数值}``：对全部英雄生效的固定属性加成（神器、祭坛等）。"""
        self._team_bonus_providers.append(provider)

    def add_addition_provider(self, name: str, provider):
        """注册 ``attributeAddition`` 的一个分节：``provider(state) -> 分节内容或 None``。"""
        self._addition_providers.append((name, provider))

    def team_bonus(self, state: dict) -> dict:
        total = {}
        for provider in self._team_bonus_providers:
            for attr, value in (provider(state) or {}).items():
                total[attr] = total.get(attr, 0) + value
        return total

    def attribute_addition(self, state: dict) -> dict:
        """角色的 ``attributeAddition``：各系统提供的加成分节（客户端“属性加成”面板）。"""
        result = {}
        for name, provider in self._addition_providers:
            section = provider(state)
            if section is not None:
                result[name] = section
        return result

    def add_level_up_listener(self, listener):
        """注册 ``listener(state, old_level, new_level)``，玩家升级时回调。"""
        self._level_up_listeners.append(listener)

    # ---- 英雄 -------------------------------------------------------------

    def starter_ids(self) -> set:
        return self.catalog.starter_hero_ids()

    def find_hero(self, state: dict, hero_id: int) -> dict:
        for hero in state['ownedHeros']:
            if hero['heroId'] == hero_id:
                return hero
        raise BusinessError('未拥有该主将')

    def has_hero(self, state: dict, hero_id: int) -> bool:
        return any(h['heroId'] == hero_id for h in state['ownedHeros'])

    def add_hero(self, state: dict, hero_id: int, battle_ix: int = 0) -> dict:
        self.heroes.template(hero_id)
        if self.has_hero(state, hero_id):
            raise BusinessError('已拥有该主将')
        hero = new_hero_record(hero_id, battle_ix)
        state['ownedHeros'].append(hero)
        return self.refresh_hero(state, hero)

    def refresh_hero(self, state: dict, hero: dict, team_bonus: dict = None) -> dict:
        equipped = self.equipment.equipped_by(state, hero['heroId'])
        bonus = dict(self.equipment.bonus_for_hero(state, hero['heroId']))
        for attr, value in (self.team_bonus(state) if team_bonus is None else team_bonus).items():
            bonus[attr] = bonus.get(attr, 0) + value
        return self.heroes.refresh(hero, bonus, [deepcopy(x) for x in equipped])

    def refresh_all(self, state: dict):
        bonus = self.team_bonus(state)
        for hero in state['ownedHeros']:
            self.refresh_hero(state, hero, bonus)
        state['team'] = self.team(state)
        state['attributeAddition'] = self.attribute_addition(state)

    def team_heroes(self, state: dict) -> list:
        return sorted((h for h in state['ownedHeros'] if h.get('battleIx', 0) > 0), key=lambda h: h['battleIx'])

    def unlocked_slots(self, state: dict) -> int:
        """按玩家等级解锁的阵位数（已上阵英雄所在的更高阵位也视为解锁，避免旧存档丢英雄）。"""
        unlocked = self.heroes.unlocked_team_slots(state['PLevel'])
        return max([unlocked] + [h['battleIx'] for h in self.team_heroes(state)])

    def slots(self, state: dict, positions: int = None) -> list:
        """阵位数组：第 i 项就是第 i 格，空位用 ``heroId=0`` 占位。

        客户端 ``TeamScene`` 以 ``groupList[i]`` 是否存在判断阵位是否开放，因此只下发已解锁的阵位；
        ``Global.Slots`` 按 battleIx 逐位替换，空位也必须显式给出才能清掉旧内容。
        """
        count = positions or self.unlocked_slots(state)
        by_position = {h['battleIx']: deepcopy(h) for h in self.team_heroes(state)}
        return [by_position.get(pos, empty_slot(pos)) for pos in range(1, count + 1)]

    def all_slots(self, state: dict) -> list:
        """全部 6 格（含未解锁），用于清除客户端开场剧情阵容在 4/6 号位的投影。"""
        return self.slots(state, self.config.team_slots)

    def team(self, state: dict) -> dict:
        heroes = self.team_heroes(state)
        return {'battlePower': sum(h.get('battlePower', 0) for h in heroes), 'groupList': self.slots(state)}

    # ---- 昵称 -------------------------------------------------------------

    def parse_nickname(self, encoded: str) -> str:
        try:
            name = base64.b64decode(encoded, validate=True).decode('utf-8')
        except (ValueError, UnicodeError, binascii.Error) as exc:
            raise BusinessError('昵称必须为UTF-8的Base64编码') from exc
        rule = self.config.nickname
        name = unicodedata.normalize('NFC', name)
        width = sum(rule.ascii_width if ord(c) < 128 else rule.wide_width for c in name)
        if (not name or width > rule.max_width
                or not all(unicodedata.category(c)[0] in ('L', 'N') for c in name)):
            raise BusinessError(f'昵称须为字母、汉字或数字，最多{rule.max_width // rule.wide_width}中文'
                                f'/{rule.max_width // rule.ascii_width}英文字符')
        return name

    # ---- 初始状态 -----------------------------------------------------------

    def initial_state(self, user: int, name: str, hero_id: int) -> dict:
        now = self.clock.now()
        state = thaw(self.config.initial_state)
        state.update(
            _v=STATE_VERSION, ID=user, Name=name,
            NextLvExp=self.config.level_up.exp_to_next(state['PLevel']),
            MaxEnergy=self.config.energy.max_for_level(state['PLevel']),
            EnergyUpdatedAt=now, DoubleExpUntil=0, CdUntil=0,
            ownedHeros=[new_hero_record(hero_id, battle_ix=1)],
            Talismans={}, NextIds={'equip': 0},
            Map={'MaxPID': self.catalog.first_stage_id(), 'Point': [], 'CdTime': 0, 'BattleTenIngot': 0},
            BattleSession=None, CreatedAt=now,
        )
        self._ensure_blocks(state)
        self.grant_starter_weapon(state, hero_id, equip=False)
        self.refresh_all(state)
        return state

    # ---- 初始武器与引导修补 -----------------------------------------------------------

    def starter_weapon_id(self, hero_id: int):
        profession = self.heroes.template(hero_id).get('profession')
        return self.config.starter_weapon_by_profession.get(profession)

    def grant_starter_weapon(self, state: dict, hero_id: int, equip: bool):
        """按职业发放一把一级武器；``equip`` 为真时直接穿到该英雄身上。"""
        weapon_id = self.starter_weapon_id(hero_id)
        if weapon_id is None:
            return None
        instance = self.equipment.create(state, weapon_id)
        if equip:
            instance['heroId'], instance['isInTeam'] = hero_id, 1
        return instance

    def repair_guide(self, state: dict):
        """引导期修补：进入“换装备→锻造”阶段后，客户端要求首发主将已穿戴武器，否则锻造页为空、引导中断。"""
        step = state.get('TiroMaxStep', 0)
        if not self.config.guide_weapon_required_step <= step < self.config.guide_protect_until_step:
            return
        lead = next((h for h in state['ownedHeros'] if h.get('battleIx') == 1), None)
        if lead is None:
            return
        equips = self.catalog['BaseEquips']
        if any(equips[str(x['equipId'])]['equipType'] == 1 for x in self.equipment.equipped_by(state, lead['heroId'])):
            return
        spare = next((x for x in state.get('Talismans', {}).values()
                      if not x.get('heroId') and equips[str(x['equipId'])]['equipType'] == 1
                      and equips[str(x['equipId'])].get('profession') in (0, 4, self.heroes.template(lead['heroId'])['profession'])), None)
        if spare is not None:
            spare['heroId'], spare['isInTeam'] = lead['heroId'], 1
        else:
            self.grant_starter_weapon(state, lead['heroId'], equip=True)

    def _ensure_blocks(self, state: dict):
        """补齐各系统的状态块（新建与迁移共用）。"""
        today = self.clock.day_key()
        defaults = {
            'Daily': {'day': today, 'battles': 0, 'recruits': 0, 'store_buys': {}, 'sign_done': False,
                      'salary_taken': False, 'gift_bags': [], 'mission_claims': [], 'energy_buys': 0},
            'Sign': {'month': self.clock.month_key(), 'days': 0, 'last_day': ''},
            'Login': {'days': 0, 'last_day': '', 'claimed': []},
            'LevelGiftClaims': [], 'MissionClaims': [], 'LocalChapterClaims': [],
            'Mail': {'next_id': 1, 'items': []},
            'Counters': {'recruit_count': 0, 'intensify_count': 0, 'breakthrough_count': 0, 'equip_count': 0,
                         'mail_read': 0},
            'Recruit': {'last_free': {}, 'orange_counter': 0},
            'TrainPending': {}, 'MysteryStore': None, 'partnerTeam': [], 'Talismans': {}, 'NextIds': {'equip': 0},
            'BattleSession': None, 'Gems': {},
            'GemMine': {'since': self.clock.now(), 'hoe_until': 0, 'hoe_count': 0},
        }
        for key, value in defaults.items():
            state.setdefault(key, value)
        for key in ('EnergyUpdatedAt', 'DoubleExpUntil', 'CdUntil'):
            state.setdefault(key, 0)
        state.setdefault('MaxEnergy', self.config.energy.max_for_level(state['PLevel']))
        state.setdefault('HeroExp', 0)
        state.setdefault('Honor', 0)
        for key in ('ETime', 'ETotalTime', 'HaveDoubleExpTime'):
            state.setdefault(key, 0)

    # ---- 迁移 -------------------------------------------------------------

    def migrate(self, state: dict) -> dict:
        """把任意版本的存档升级到当前结构，然后执行 ``tick``。"""
        version = state.get('_v', 1)
        if version < 2:
            self._migrate_v1_to_v2(state)
        state['_v'] = STATE_VERSION
        self._ensure_blocks(state)
        map_state = state.setdefault('Map', {})
        for key, value in {'MaxPID': self.catalog.first_stage_id(), 'Point': [], 'CdTime': 0, 'BattleTenIngot': 0}.items():
            map_state.setdefault(key, value)
        self.tick(state)
        return state

    def _migrate_v1_to_v2(self, state: dict):
        """v1：阵容英雄整份存在 team.groupList；v2：ownedHeros 为唯一来源，battleIx 标记上阵位。"""
        positions = {}
        for hero in state.get('team', {}).get('groupList', []):
            if hero.get('heroId'):
                positions[hero['heroId']] = hero.get('battleIx', 0)
        owned = state.setdefault('ownedHeros', [])
        for hero in owned:
            hero['battleIx'] = positions.get(hero['heroId'], 0)
            hero.setdefault('trainDims', {'physical': 0, 'strength': 0, 'mana': 0, 'agility': 0})
            hero.setdefault('rageSkillLevel', hero.get('skillLevel', 1))
        if owned and not any(h['battleIx'] for h in owned):
            owned[0]['battleIx'] = 1
        state['EnergyUpdatedAt'] = self.clock.now()

    # ---- 周期性结算 -----------------------------------------------------------

    def tick(self, state: dict):
        """每次加载角色时执行：每日重置、体力恢复、派生字段。"""
        now = self.clock.now()
        today = self.clock.day_key(now)
        state['LastSeenAt'] = now  # 最近活跃时间：仙盟成员列表等处显示在线/离线时长
        daily = state['Daily']
        if daily.get('day') != today:
            state['Daily'] = {'day': today, 'battles': 0, 'recruits': 0, 'store_buys': {}, 'sign_done': False,
                              'salary_taken': False, 'gift_bags': [], 'mission_claims': [], 'energy_buys': 0}
            for point in state['Map']['Point']:
                point['COD'] = 0
        login = state['Login']
        if login.get('last_day') != today:
            login['last_day'] = today
            login['days'] = login.get('days', 0) + 1
        self.regen_energy(state, now)
        state['HaveDoubleExpTime'] = Clock.remaining(state.get('DoubleExpUntil', 0), now)
        state['Map']['CdTime'] = Clock.remaining(state.get('CdUntil', 0), now)
        self.repair_guide(state)
        self.refresh_all(state)

    def regen_energy(self, state: dict, now: int):
        rule = self.config.energy
        state['MaxEnergy'] = rule.max_for_level(state['PLevel'])
        last = state.get('EnergyUpdatedAt') or now
        if state['Energy'] >= state['MaxEnergy']:
            state['EnergyUpdatedAt'] = now
            state['ETime'] = state['ETotalTime'] = 0
            return
        elapsed = max(0, now - last)
        gained = elapsed // rule.regen_seconds
        if gained:
            state['Energy'] = min(state['MaxEnergy'], state['Energy'] + gained)
            last += gained * rule.regen_seconds
            state['EnergyUpdatedAt'] = last
        if state['Energy'] >= state['MaxEnergy']:
            state['EnergyUpdatedAt'] = now
            state['ETime'] = state['ETotalTime'] = 0
        else:
            state['ETime'] = rule.regen_seconds - (now - last)
            state['ETotalTime'] = (state['MaxEnergy'] - state['Energy'] - 1) * rule.regen_seconds + state['ETime']

    # ---- 玩家升级 -----------------------------------------------------------

    def add_player_exp(self, state: dict, amount: int):
        rule = self.config.level_up
        old_level = level = state['PLevel']
        exp = state['Exp'] + amount
        need = rule.exp_to_next(level)
        while exp >= need and level < rule.max_level:
            exp -= need
            level += 1
            need = rule.exp_to_next(level)
        if level >= rule.max_level:
            exp = min(exp, need - 1)
        state.update(PLevel=level, Exp=exp, NextLvExp=need)
        if level != old_level:
            state['MaxEnergy'] = self.config.energy.max_for_level(level)
            if self.config.energy.refill_on_level_up:
                state['Energy'] = max(state['Energy'], state['MaxEnergy'])
            for listener in self._level_up_listeners:
                listener(state, old_level, level)

    # ---- 客户端投影 -----------------------------------------------------------

    def notify(self, state: dict) -> dict:
        result = thaw(self.config.notify_defaults)
        for key in self.config.notify_mirrored_fields:
            result[key] = state[key]
        result['MapBattleTenCDtime'] = state['Map'].get('CdTime', 0)
        for provider in self._notify_providers:
            result.update(provider(state))
        return result

    def presentation(self, state: dict, selected_hero=None) -> dict:
        """``/Role/Default`` 与 ``/Role/Name`` 的角色数据。

        引导未开始（TiroMaxStep 为 0）时返回开场剧情阵容（仅投影，不写回存档）。
        """
        view = deepcopy(state)
        view['team'] = self.team(view)
        if view.get('TiroMaxStep', 0) == 0:
            starters = self.starter_ids()
            selected_hero = selected_hero or next(h['heroId'] for h in view['ownedHeros'] if h['heroId'] in starters)
            lead = self.find_hero(view, selected_hero)
            rule = self.config.cinematic
            cast = [dict(deepcopy(lead), battleIx=rule.lead_slot)]
            for position, hero_id in zip(rule.companion_slots, sorted(starters - {selected_hero})):
                actor = self.heroes.refresh(new_hero_record(hero_id, battle_ix=position))
                cast.append(actor)
            by_position = {hero['battleIx']: hero for hero in cast}
            view['team'] = dict(view['team'], groupList=[
                by_position.get(pos, empty_slot(pos)) for pos in range(1, self.config.team_slots + 1)])
        view['TalismanTotalCount'] = len(view.get('Talismans', {}))
        # 客户端个人信息面板与系统设置里的“角色ID”读取 PromoterId；与其他玩家查看阵容、加好友时用的 playerid 一致。
        view['PromoterId'] = view.get('ID')
        view['Notify'] = self.notify(state)
        for key in ('Talismans', 'NextIds', 'BattleSession', 'Daily', 'Sign', 'Login', 'Mail', 'Counters',
                    'Recruit', 'TrainPending', 'MysteryStore', 'EnergyUpdatedAt', 'DoubleExpUntil', 'CdUntil',
                    'LevelGiftClaims', 'MissionClaims', 'LocalChapterClaims', 'CreatedAt', '_v', 'FriendRequestCount',
                    'Arena', 'WorldBoss', 'WorldBossRewards', 'Fuben', 'Tower', 'Transport', 'Slave', 'Artifact',
                    'Gems', 'GemMine', 'Union', 'LastSeenAt'):
            view.pop(key, None)
        return view
