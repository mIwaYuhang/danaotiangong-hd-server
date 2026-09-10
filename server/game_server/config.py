"""配置加载：``data/config/*.json`` → 只读 dataclass。

原则：
- 所有可调参数都来自配置目录，代码中不保留数值默认值；
- 字段缺失、类型错误、取值越界都在启动阶段以 ``ConfigError`` 报出，并指明文件与字段路径；
- JSON 中以下划线开头的键（如 ``_doc``）视为注释，加载时忽略；
- 加载结果是不可变对象（frozen dataclass + 只读映射），业务层不能在运行时改配置。

文件与 dataclass 对应关系：

==================  ===================  ==========================================
文件                dataclass            内容
==================  ===================  ==========================================
server.json         ServerConfig         监听、公网基址、区服、路径、HTTP 限制、日志
auth.json           AuthConfig           票据/会话有效期、PBKDF2、令牌长度
player.json         PlayerConfig         角色初始状态、Notify、昵称、升级、体力、阵容
hero.json           HeroConfig           英雄属性成长、战力、经验、突破、培养、阵位解锁
equipment.json      EquipmentConfig      装备实例、锻造、重铸、碎片
inventory.json      InventoryConfig      账本类型映射、道具效果、随机礼包
battle.json         BattleConfig         关卡阵容生成、NPC 数值、战斗公式、扫荡、章节宝箱
recruitment.json    RecruitmentConfig    卡池、免费间隔、保底、新手首抽
store.json          StoreConfig          商店货架、体力丹阶梯、神秘商店
activities/<活动>.json ActivitiesConfig   一个活动一个文件：签到、征收、七日登录、等级礼包、月卡、
                                         成长计划、充值（伪充值+开关）、财神到、幸运转盘、采灵芝、
                                         天女散花、坊市、分享、跑马灯、系统邮件
missions.json       MissionsConfig       主线与每日任务
features/<系统>.json FeaturesConfig       中期玩法，一个系统一个文件（争霸、妖王、仙盟、运镖等 17 个）
client_routes.json  frozenset[str]       客户端接口路径（仅用于日志脱敏）
==================  ===================  ==========================================

另有 ``data/static/``（由 ``tools/lua_import`` 从客户端 Lua 解包数据生成）：BaseHeros、关卡、NPC、
装备、道具等静态表。它们必须与客户端一致，因此不手工编辑；服务端可调的只是本目录下的规则参数。
"""
from dataclasses import dataclass
import json
from pathlib import Path
from types import MappingProxyType
from typing import Any, Mapping, Tuple
from urllib.parse import urlsplit

from .errors import ConfigError


# ---------------------------------------------------------------------------
# JSON 读取与字段访问
# ---------------------------------------------------------------------------

def _reject_duplicate_keys(pairs):
    result = {}
    for key, value in pairs:
        if key in result:
            raise ValueError(f'重复的 JSON 键: {key}')
        result[key] = value
    return result


def load_json_file(path: Path):
    """读取 JSON 文件；拒绝重复键，错误信息带文件路径。"""
    try:
        return json.loads(path.read_text('utf-8-sig'), object_pairs_hook=_reject_duplicate_keys)
    except OSError as exc:
        raise ConfigError(f'无法读取配置文件 {path}: {exc}') from exc
    except ValueError as exc:
        raise ConfigError(f'配置文件 {path} 不是合法 JSON: {exc}') from exc


def freeze(value):
    """把 JSON 值递归转换为不可变结构（映射 → MappingProxyType，列表 → tuple）。"""
    if isinstance(value, dict):
        return MappingProxyType({k: freeze(v) for k, v in value.items()})
    if isinstance(value, list):
        return tuple(freeze(v) for v in value)
    return value


def thaw(value):
    """``freeze`` 的逆操作：得到可自由修改的普通 dict/list 深拷贝。"""
    if isinstance(value, Mapping):
        return {k: thaw(v) for k, v in value.items()}
    if isinstance(value, (list, tuple)):
        return [thaw(v) for v in value]
    return value


REWARD_FIELDS = ('Type', 'ID', 'Count')


def check_reward(item, source):
    """校验一条奖励 ``{Type, ID, Count[, Level, quality]}``。"""
    if not isinstance(item, dict) or any(type(item.get(f)) is not int for f in REWARD_FIELDS):
        raise ConfigError(f'{source} 必须是含整数 Type/ID/Count 的对象')
    if item['Count'] < 0:
        raise ConfigError(f'{source}.Count 不能为负')


class Section:
    """带路径信息的 JSON 对象访问器，用于产出可读的错误提示。"""

    def __init__(self, data, source: str):
        if not isinstance(data, dict):
            raise ConfigError(f'{source} 必须是 JSON 对象')
        self.data = data
        self.source = source

    def path(self, key) -> str:
        return f'{self.source}.{key}'

    def has(self, key) -> bool:
        return key in self.data

    def raw(self, key):
        if key not in self.data:
            raise ConfigError(f'{self.source} 缺少字段 {key}')
        return self.data[key]

    def section(self, key) -> 'Section':
        return Section(self.raw(key), self.path(key))

    def sections(self, key) -> Tuple['Section', ...]:
        """对象数组 → Section 元组。"""
        value = self.raw(key)
        if not isinstance(value, list):
            raise ConfigError(f'{self.path(key)} 必须是数组')
        return tuple(Section(item, f'{self.path(key)}[{i}]') for i, item in enumerate(value))

    def integer(self, key, minimum=None, maximum=None) -> int:
        value = self.raw(key)
        if type(value) is not int:
            raise ConfigError(f'{self.path(key)} 必须是整数')
        if minimum is not None and value < minimum:
            raise ConfigError(f'{self.path(key)} 不能小于 {minimum}')
        if maximum is not None and value > maximum:
            raise ConfigError(f'{self.path(key)} 不能大于 {maximum}')
        return value

    def number(self, key, minimum=None, maximum=None) -> float:
        value = self.raw(key)
        if type(value) not in (int, float):
            raise ConfigError(f'{self.path(key)} 必须是数字')
        if minimum is not None and value < minimum:
            raise ConfigError(f'{self.path(key)} 不能小于 {minimum}')
        if maximum is not None and value > maximum:
            raise ConfigError(f'{self.path(key)} 不能大于 {maximum}')
        return value

    def boolean(self, key) -> bool:
        value = self.raw(key)
        if type(value) is not bool:
            raise ConfigError(f'{self.path(key)} 必须是布尔值')
        return value

    def string(self, key, allow_empty=False) -> str:
        value = self.raw(key)
        if not isinstance(value, str):
            raise ConfigError(f'{self.path(key)} 必须是字符串')
        if not allow_empty and not value.strip():
            raise ConfigError(f'{self.path(key)} 不能为空')
        return value

    def integers(self, key, minimum=None, allow_empty=False) -> Tuple[int, ...]:
        value = self.raw(key)
        if not isinstance(value, list) or any(type(v) is not int for v in value):
            raise ConfigError(f'{self.path(key)} 必须是整数数组')
        if not allow_empty and not value:
            raise ConfigError(f'{self.path(key)} 不能为空数组')
        if minimum is not None and any(v < minimum for v in value):
            raise ConfigError(f'{self.path(key)} 中的取值不能小于 {minimum}')
        return tuple(value)

    def strings(self, key, allow_empty=False) -> Tuple[str, ...]:
        value = self.raw(key)
        if not isinstance(value, list) or any(not isinstance(v, str) or not v for v in value):
            raise ConfigError(f'{self.path(key)} 必须是非空字符串数组')
        if not allow_empty and not value:
            raise ConfigError(f'{self.path(key)} 不能为空数组')
        return tuple(value)

    def mapping(self, key) -> Mapping[str, Any]:
        value = self.raw(key)
        if not isinstance(value, dict):
            raise ConfigError(f'{self.path(key)} 必须是 JSON 对象')
        return freeze(value)

    def int_range(self, key) -> Tuple[int, int]:
        value = self.integers(key)
        if len(value) != 2 or value[0] > value[1]:
            raise ConfigError(f'{self.path(key)} 必须是 [下限, 上限] 两个整数')
        return value[0], value[1]

    def int_keyed(self, key, value_kind=None) -> Mapping[int, Any]:
        """键为整数字符串的对象，例如 ``{"5": "BaseProps"}``；值会被冻结。"""
        raw = self.raw(key)
        if not isinstance(raw, dict):
            raise ConfigError(f'{self.path(key)} 必须是 JSON 对象')
        result = {}
        for k, v in raw.items():
            if not k.isdigit() or (value_kind is not None and not isinstance(v, value_kind)):
                raise ConfigError(f'{self.path(key)} 的键必须是整数字符串'
                                  + (f'，值类型应为 {value_kind.__name__}' if value_kind else ''))
            result[int(k)] = freeze(v)
        return MappingProxyType(result)

    def numbers_by_int_key(self, key) -> Mapping[int, float]:
        result = self.int_keyed(key)
        for k, v in result.items():
            if type(v) not in (int, float):
                raise ConfigError(f'{self.path(key)}.{k} 必须是数字')
        return result

    def rewards(self, key, allow_empty=True) -> Tuple[Mapping[str, Any], ...]:
        """奖励数组 ``[{Type, ID, Count}, ...]``。"""
        value = self.raw(key)
        if not isinstance(value, list) or (not allow_empty and not value):
            raise ConfigError(f'{self.path(key)} 必须是奖励数组')
        for i, item in enumerate(value):
            check_reward(item, f'{self.path(key)}[{i}]')
        return freeze(value)

    def reward_groups(self, key) -> Tuple[Tuple[Mapping[str, Any], ...], ...]:
        """奖励数组的数组。"""
        value = self.raw(key)
        if not isinstance(value, list) or not value:
            raise ConfigError(f'{self.path(key)} 必须是非空数组')
        for i, group in enumerate(value):
            if not isinstance(group, list):
                raise ConfigError(f'{self.path(key)}[{i}] 必须是奖励数组')
            for j, item in enumerate(group):
                check_reward(item, f'{self.path(key)}[{i}][{j}]')
        return freeze(value)


# ---------------------------------------------------------------------------
# server.json
# ---------------------------------------------------------------------------

@dataclass(frozen=True)
class ListenConfig:
    host: str
    port: int


@dataclass(frozen=True)
class RealmConfig:
    id: int
    name: str
    state: int
    heat: int
    group_load: int


@dataclass(frozen=True)
class HttpConfig:
    max_workers: int
    request_timeout: float
    max_body_bytes: int
    max_target_length: int
    max_query_fields: int
    max_query_key_length: int
    max_query_value_length: int
    server_header: str


@dataclass(frozen=True)
class LoggingConfig:
    level: str
    format: str
    plain_query_keys: frozenset


@dataclass(frozen=True)
class ServerConfig:
    listen: ListenConfig
    public_url: str
    realm: RealmConfig
    database: Path
    static_data_dir: Path
    http: HttpConfig
    logging: LoggingConfig

    @classmethod
    def load(cls, section: Section, data_dir: Path) -> 'ServerConfig':
        listen, realm, paths = section.section('listen'), section.section('realm'), section.section('paths')
        http, logging_ = section.section('http'), section.section('logging')
        return cls(
            listen=ListenConfig(host=listen.string('host'), port=listen.integer('port', 1, 65535)),
            public_url=validate_public_url(section.string('public_url'), section.path('public_url')),
            realm=RealmConfig(id=realm.integer('id', 1), name=realm.string('name').strip(),
                              state=realm.integer('state', 0), heat=realm.integer('heat', 0),
                              group_load=realm.integer('group_load', 0)),
            database=data_dir / paths.string('database'),
            static_data_dir=data_dir / paths.string('static_data'),
            http=HttpConfig(
                max_workers=http.integer('max_workers', 1),
                request_timeout=http.number('request_timeout_seconds', 0.001),
                max_body_bytes=http.integer('max_body_bytes', 0),
                max_target_length=http.integer('max_target_length', 1),
                max_query_fields=http.integer('max_query_fields', 1),
                max_query_key_length=http.integer('max_query_key_length', 1),
                max_query_value_length=http.integer('max_query_value_length', 1),
                server_header=http.string('server_header')),
            logging=LoggingConfig(level=logging_.string('level').upper(), format=logging_.string('format'),
                                  plain_query_keys=frozenset(logging_.strings('plain_query_keys', allow_empty=True))),
        )


def validate_public_url(url: str, source: str) -> str:
    """公网基址必须是不带认证信息、查询参数和片段的 HTTP(S) 地址；去掉末尾斜杠。"""
    try:
        parts = urlsplit(url)
        parts.port
        valid = (parts.scheme in ('http', 'https') and bool(parts.hostname)
                 and not (parts.query or parts.fragment or parts.username or parts.password))
    except ValueError:
        valid = False
    if not valid or any(c.isspace() or ord(c) < 32 for c in url):
        raise ConfigError(f'{source} 必须是无认证信息、查询参数和片段的 HTTP(S) 基址')
    return url.rstrip('/')


# ---------------------------------------------------------------------------
# auth.json
# ---------------------------------------------------------------------------

@dataclass(frozen=True)
class AuthConfig:
    ticket_ttl: int
    session_ttl: int
    pbkdf2_iterations: int
    token_bytes: int

    @property
    def token_length(self) -> int:
        """``secrets.token_urlsafe(token_bytes)`` 产出的字符数（去除 Base64 填充）。"""
        return (self.token_bytes * 8 + 5) // 6

    @classmethod
    def load(cls, section: Section) -> 'AuthConfig':
        return cls(ticket_ttl=section.integer('ticket_ttl_seconds', 1),
                   session_ttl=section.integer('session_ttl_seconds', 1),
                   pbkdf2_iterations=section.integer('pbkdf2_iterations', 1000),
                   token_bytes=section.integer('token_bytes', 16))


# ---------------------------------------------------------------------------
# player.json
# ---------------------------------------------------------------------------

@dataclass(frozen=True)
class NicknameRule:
    max_width: int
    ascii_width: int
    wide_width: int


@dataclass(frozen=True)
class LevelUpRule:
    max_level: int
    exp_base: int
    exp_step: int

    def exp_to_next(self, level: int) -> int:
        return self.exp_base + (level - 1) * self.exp_step


@dataclass(frozen=True)
class EnergyRule:
    base_max: int
    per_level: int
    regen_seconds: int
    refill_on_level_up: bool

    def max_for_level(self, level: int) -> int:
        return self.base_max + (level - 1) * self.per_level


@dataclass(frozen=True)
class CinematicRule:
    lead_slot: int
    companion_slots: Tuple[int, ...]


@dataclass(frozen=True)
class PlayerConfig:
    initial_state: Mapping[str, Any]
    notify_defaults: Mapping[str, Any]
    notify_mirrored_fields: Tuple[str, ...]
    nickname: NicknameRule
    level_up: LevelUpRule
    energy: EnergyRule
    daily_reset_hour: int
    team_slots: int
    cinematic: CinematicRule
    recruit_gate_step: int
    guide_protect_until_step: int
    guide_weapon_required_step: int
    starter_weapon_by_profession: Mapping[int, int]
    double_exp_default_seconds: int
    hero_exp_pool_cap: int

    @classmethod
    def load(cls, section: Section) -> 'PlayerConfig':
        nickname, level_up = section.section('nickname'), section.section('level_up')
        energy, cinematic = section.section('energy'), section.section('cinematic')
        team_slots = section.integer('team_slots', 1)
        rule = CinematicRule(lead_slot=cinematic.integer('lead_slot', 1, team_slots),
                             companion_slots=cinematic.integers('companion_slots', 1))
        if rule.lead_slot in rule.companion_slots or max(rule.companion_slots) > team_slots:
            raise ConfigError(f'{cinematic.source} 的阵位必须互不相同且不超过 team_slots')
        initial_state = section.mapping('initial_state')
        for field in ('PLevel', 'Energy', 'TiroMaxStep', 'Exp', 'Gold', 'Ingot'):
            if type(initial_state.get(field)) is not int:
                raise ConfigError(f'{section.path("initial_state")}.{field} 必须是整数')
        return cls(
            initial_state=initial_state,
            notify_defaults=section.mapping('notify_defaults'),
            notify_mirrored_fields=section.strings('notify_mirrored_fields'),
            nickname=NicknameRule(max_width=nickname.integer('max_width', 1),
                                  ascii_width=nickname.integer('ascii_width', 1),
                                  wide_width=nickname.integer('wide_width', 1)),
            level_up=LevelUpRule(max_level=level_up.integer('max_level', 1),
                                 exp_base=level_up.integer('exp_base', 1),
                                 exp_step=level_up.integer('exp_step', 0)),
            energy=EnergyRule(base_max=energy.integer('base_max', 1), per_level=energy.integer('per_level', 0),
                              regen_seconds=energy.integer('regen_seconds', 1),
                              refill_on_level_up=energy.boolean('refill_on_level_up')),
            daily_reset_hour=section.integer('daily_reset_hour', 0, 23),
            team_slots=team_slots,
            cinematic=rule,
            recruit_gate_step=section.section('guide').integer('recruit_gate_step', 0),
            guide_protect_until_step=section.section('guide').integer('protect_until_step', 0),
            guide_weapon_required_step=section.section('guide').integer('weapon_required_step', 0),
            starter_weapon_by_profession=section.int_keyed('starter_weapon_by_profession', int),
            double_exp_default_seconds=section.integer('double_exp_default_seconds', 1),
            hero_exp_pool_cap=section.integer('hero_exp_pool_cap', 1),
        )


# ---------------------------------------------------------------------------
# hero.json
# ---------------------------------------------------------------------------

@dataclass(frozen=True)
class TrainMode:
    potency: int
    train_pill: int
    ingot: int
    min_delta: int
    max_delta: int


@dataclass(frozen=True)
class RageRule:
    max: int
    cost: int
    gain_on_attack: int
    gain_on_hit: int
    initial: int


@dataclass(frozen=True)
class HeroConfig:
    growth_per_level: Mapping[str, float]
    dimension_effects: Mapping[str, Mapping[str, float]]
    base_speed_by_profession: Mapping[int, float]
    rebirth_percent: float
    rebirth_level_gates: Tuple[int, ...]
    gate_step_after_table: int
    rebirth_max_count: int
    rebirth_max_count_orange_rating: int
    rebirth_potency_default: int
    exp_quality_factor: Mapping[int, float]
    battle_power_weights: Mapping[str, float]
    train_normal: TrainMode
    train_special: TrainMode
    train_dimension_cap_per_level: int
    team_slot_unlock_levels: Tuple[int, ...]
    partner_slot_unlock_levels: Tuple[int, ...]
    rage: RageRule
    secondary_attr_scale: int

    @classmethod
    def load(cls, section: Section) -> 'HeroConfig':
        train, rage = section.section('train'), section.section('rage')

        def mode(name):
            m = train.section(name)
            return TrainMode(potency=m.integer('potency', 0), train_pill=m.integer('train_pill', 0),
                             ingot=m.integer('ingot', 0), min_delta=m.integer('min_delta'),
                             max_delta=m.integer('max_delta'))
        growth = section.mapping('growth_per_level')
        for k, v in growth.items():
            if type(v) not in (int, float) or v < 0:
                raise ConfigError(f'{section.path("growth_per_level")}.{k} 必须是非负数字')
        return cls(
            growth_per_level=growth,
            dimension_effects=section.mapping('dimension_effects'),
            base_speed_by_profession=section.numbers_by_int_key('base_speed_by_profession'),
            rebirth_percent=section.number('rebirth_percent', 0),
            rebirth_level_gates=section.integers('rebirth_level_gates', 1),
            gate_step_after_table=section.integer('gate_step_after_table', 1),
            rebirth_max_count=section.integer('rebirth_max_count', 1),
            rebirth_max_count_orange_rating=section.integer('rebirth_max_count_orange_rating', 1),
            rebirth_potency_default=section.integer('rebirth_potency_default', 0),
            exp_quality_factor=section.numbers_by_int_key('exp_quality_factor'),
            battle_power_weights=section.mapping('battle_power_weights'),
            train_normal=mode('normal'), train_special=mode('special'),
            train_dimension_cap_per_level=train.integer('dimension_cap_per_level', 1),
            team_slot_unlock_levels=section.integers('team_slot_unlock_levels', 1),
            partner_slot_unlock_levels=section.integers('partner_slot_unlock_levels', 1),
            rage=RageRule(max=rage.integer('max', 1), cost=rage.integer('cost', 1),
                          gain_on_attack=rage.integer('gain_on_attack', 0), gain_on_hit=rage.integer('gain_on_hit', 0),
                          initial=rage.integer('initial', 0)),
            secondary_attr_scale=section.integer('secondary_attr_scale', 1),
        )


# ---------------------------------------------------------------------------
# equipment.json
# ---------------------------------------------------------------------------

@dataclass(frozen=True)
class IntensifyRule:
    cost_a: float
    cost_b: float
    cost_power: float
    cost_c: float
    quality_factor: Mapping[int, float]
    level_cap_multiplier: int


@dataclass(frozen=True)
class RecastRule:
    stone_cost_base: int
    stone_cost_per_pinjie: int
    lock_cost_by_pinjie: Mapping[int, float]
    fail_chance_by_pinjie: Mapping[int, float]


@dataclass(frozen=True)
class EquipmentConfig:
    main_attributes_by_type: Mapping[int, Tuple[str, ...]]
    initial_ratio_of_max: float
    pinjie_bonus: Mapping[int, float]
    pinjie_level_steps: int
    intensify: IntensifyRule
    recast: RecastRule
    fragment_sell_price_field: str
    decompose_fragment_ratio: Mapping[int, float]
    compose_required_count: int
    bag_capacity: int

    @classmethod
    def load(cls, section: Section) -> 'EquipmentConfig':
        intensify, recast = section.section('intensify'), section.section('recast')
        return cls(
            main_attributes_by_type=section.int_keyed('main_attributes_by_type', list),
            initial_ratio_of_max=section.number('initial_ratio_of_max', 0.01, 1),
            pinjie_bonus=section.numbers_by_int_key('pinjie_bonus'),
            pinjie_level_steps=section.integer('pinjie_level_steps', 1),
            intensify=IntensifyRule(cost_a=intensify.number('cost_a', 0), cost_b=intensify.number('cost_b', 0),
                                    cost_power=intensify.number('cost_power', 0.1), cost_c=intensify.number('cost_c', 0),
                                    quality_factor=intensify.numbers_by_int_key('quality_factor'),
                                    level_cap_multiplier=intensify.integer('level_cap_multiplier', 1)),
            recast=RecastRule(stone_cost_base=recast.integer('stone_cost_base', 0),
                              stone_cost_per_pinjie=recast.integer('stone_cost_per_pinjie', 0),
                              lock_cost_by_pinjie=recast.numbers_by_int_key('lock_cost_by_pinjie'),
                              fail_chance_by_pinjie=recast.numbers_by_int_key('fail_chance_by_pinjie')),
            fragment_sell_price_field=section.string('fragment_sell_price_field'),
            decompose_fragment_ratio=section.numbers_by_int_key('decompose_fragment_ratio'),
            compose_required_count=section.section('compose_soul').integer('required_count', 2),
            bag_capacity=section.integer('bag_capacity', 1),
        )


# ---------------------------------------------------------------------------
# inventory.json
# ---------------------------------------------------------------------------

@dataclass(frozen=True)
class SpecialProp:
    rewards: Tuple[Mapping[str, Any], ...]
    cap_energy: bool


@dataclass(frozen=True)
class RandomGift:
    draws: int
    entries: Tuple[Mapping[str, Any], ...]


@dataclass(frozen=True)
class InventoryConfig:
    max_count: int
    max_operation_count: int
    resource_by_type: Mapping[int, str]
    bag_types: Mapping[int, str]
    fragment_type: int
    experience_type: int
    hero_type: int
    equip_type: int
    double_exp_type: int
    resource_fields: Tuple[str, ...]
    prop_effects: Mapping[str, int]
    special_props: Mapping[int, SpecialProp]
    random_gifts: Mapping[int, RandomGift]
    duplicate_soul_count: int

    @classmethod
    def load(cls, section: Section) -> 'InventoryConfig':
        specials = {}
        for key, raw in section.raw('special_props').items():
            if not key.isdigit():
                raise ConfigError(f'{section.path("special_props")} 的键必须是道具 ID 字符串')
            item = Section(raw, f'{section.path("special_props")}.{key}')
            specials[int(key)] = SpecialProp(rewards=item.rewards('rewards', allow_empty=False),
                                             cap_energy=item.boolean('cap_energy'))
        gifts = {}
        for key, raw in section.raw('random_gifts').items():
            if not key.isdigit():
                raise ConfigError(f'{section.path("random_gifts")} 的键必须是道具 ID 字符串')
            item = Section(raw, f'{section.path("random_gifts")}.{key}')
            entries = item.raw('entries')
            if not isinstance(entries, list) or not entries:
                raise ConfigError(f'{item.path("entries")} 必须是非空数组')
            for i, entry in enumerate(entries):
                check_reward(entry, f'{item.path("entries")}[{i}]')
                if type(entry.get('weight')) is not int or entry['weight'] <= 0:
                    raise ConfigError(f'{item.path("entries")}[{i}].weight 必须是正整数')
            gifts[int(key)] = RandomGift(draws=item.integer('draws', 1), entries=freeze(entries))
        effects = section.mapping('prop_effects')
        for k, v in effects.items():
            if type(v) is not int:
                raise ConfigError(f'{section.path("prop_effects")}.{k} 必须是整数')
        return cls(
            max_count=section.integer('max_count', 1),
            max_operation_count=section.integer('max_operation_count', 1),
            resource_by_type=section.int_keyed('resource_by_type', str),
            bag_types=section.int_keyed('bag_types', str),
            fragment_type=section.integer('fragment_type', 1),
            experience_type=section.integer('experience_type', 1),
            hero_type=section.integer('hero_type', 1),
            equip_type=section.integer('equip_type', 1),
            double_exp_type=section.integer('double_exp_type', 1),
            resource_fields=section.strings('resource_fields'),
            prop_effects=effects,
            special_props=MappingProxyType(specials),
            random_gifts=MappingProxyType(gifts),
            duplicate_soul_count=section.integer('duplicate_soul_count', 1),
        )


# ---------------------------------------------------------------------------
# battle.json
# ---------------------------------------------------------------------------

@dataclass(frozen=True)
class DifficultyRule:
    health_multiplier: float
    attack_multiplier: float
    drop_multiplier: float


@dataclass(frozen=True)
class NpcLevelRule:
    base: float
    per_chapter: float
    per_stage: float
    per_difficulty: float


@dataclass(frozen=True)
class HitFormula:
    defense_ratio: float
    damage_variance: float
    crit_multiplier: float
    block_multiplier: float


@dataclass(frozen=True)
class SweepRule:
    required_level: int
    cooldown_seconds: int
    clear_cd_ingot: int


@dataclass(frozen=True)
class PowerCurve:
    base: float
    per_chapter: float
    max: float

    def multiplier(self, chapter_ordinal: int) -> float:
        return min(self.max, self.base + chapter_ordinal * self.per_chapter)


@dataclass(frozen=True)
class BattleConfig:
    difficulties: Mapping[int, DifficultyRule]
    npc_level: NpcLevelRule
    npc_power: PowerCurve
    npc_role_multiplier: Mapping[str, float]
    waves: Mapping[int, Tuple[Tuple[Any, ...], ...]]
    enemy_cap_base: int
    enemy_cap_per_chapter: int
    round_limit: int
    hit: HitFormula
    hero_exp_ratio: float
    drop_chance: Mapping[int, float]
    sweep: SweepRule
    chapter_star_thresholds: Tuple[int, ...]
    first_clear_bonus: Mapping[int, Tuple[Mapping[str, Any], ...]]

    @classmethod
    def load(cls, section: Section) -> 'BattleConfig':
        difficulties = {}
        for key, raw in section.raw('difficulties').items():
            d = Section(raw, f'{section.path("difficulties")}.{key}')
            difficulties[int(key)] = DifficultyRule(health_multiplier=d.number('health_multiplier', 0.01),
                                                    attack_multiplier=d.number('attack_multiplier', 0.01),
                                                    drop_multiplier=d.number('drop_multiplier', 0))
        if set(difficulties) != {1, 2, 3}:
            raise ConfigError(f'{section.path("difficulties")} 必须包含难度 1、2、3')
        level, hit, sweep, cap = (section.section('npc_level'), section.section('hit_formula'),
                                  section.section('sweep'), section.section('enemy_cap'))
        power = section.section('npc_power_curve')
        waves = {}
        for key, raw in section.raw('waves').items():
            if not key.isdigit() or not isinstance(raw, list) or len(raw) != int(key):
                raise ConfigError(f'{section.path("waves")}.{key} 必须是长度为 {key} 的波次数组')
            for wave in raw:
                if not isinstance(wave, list) or not wave or any(
                        not (type(x) is int and 0 <= x <= 9) and x not in ('boss', 'elite') for x in wave):
                    raise ConfigError(f'{section.path("waves")}.{key} 每波必须是 0..9 / "boss" / "elite" 的非空数组')
            waves[int(key)] = freeze(raw)
        roles = section.mapping('npc_role_multiplier')
        if set(roles) != {'minion', 'elite', 'boss'}:
            raise ConfigError(f'{section.path("npc_role_multiplier")} 必须包含 minion/elite/boss')
        bonus = {}
        for key, raw in section.raw('first_clear_bonus').items():
            if not key.isdigit() or not isinstance(raw, list):
                raise ConfigError(f'{section.path("first_clear_bonus")} 的键必须是关卡 ID，值为奖励数组')
            for i, item in enumerate(raw):
                check_reward(item, f'{section.path("first_clear_bonus")}.{key}[{i}]')
            bonus[int(key)] = freeze(raw)
        return cls(
            difficulties=MappingProxyType(difficulties),
            npc_level=NpcLevelRule(base=level.number('base', 1), per_chapter=level.number('per_chapter', 0),
                                   per_stage=level.number('per_stage', 0), per_difficulty=level.number('per_difficulty', 0)),
            npc_power=PowerCurve(base=power.number('base', 0.01), per_chapter=power.number('per_chapter', 0),
                                 max=power.number('max', 0.01)),
            npc_role_multiplier=roles,
            waves=MappingProxyType(waves),
            enemy_cap_base=cap.integer('cap_base', 1), enemy_cap_per_chapter=cap.integer('cap_per_chapter', 0),
            round_limit=section.integer('round_limit', 1),
            hit=HitFormula(defense_ratio=hit.number('defense_ratio', 0, 1), damage_variance=hit.number('damage_variance', 0, 0.9),
                           crit_multiplier=hit.number('crit_multiplier', 1), block_multiplier=hit.number('block_multiplier', 0, 1)),
            hero_exp_ratio=section.section('player_exp').number('hero_exp_ratio', 0),
            drop_chance=section.numbers_by_int_key('drop_chance'),
            sweep=SweepRule(required_level=sweep.integer('required_level', 1),
                            cooldown_seconds=sweep.integer('cooldown_seconds', 0),
                            clear_cd_ingot=sweep.integer('clear_cd_ingot', 0)),
            chapter_star_thresholds=section.integers('chapter_star_thresholds', 1),
            first_clear_bonus=MappingProxyType(bonus),
        )


# ---------------------------------------------------------------------------
# recruitment.json
# ---------------------------------------------------------------------------

@dataclass(frozen=True)
class RecruitPool:
    name: str
    price: int
    free_interval: int
    quality_weights: Mapping[int, float]
    orange_pity: int
    ten_discount: float


@dataclass(frozen=True)
class NewbieRecruit:
    candidate_hero_ids: Tuple[int, ...]
    quality_range: Tuple[int, int]
    eligible_step_range: Tuple[int, int]
    claim_key: str


@dataclass(frozen=True)
class RecruitmentConfig:
    pools: Mapping[int, RecruitPool]
    duplicate_soul_count: int
    newbie: NewbieRecruit
    response_flags: Mapping[str, Any]

    @classmethod
    def load(cls, section: Section) -> 'RecruitmentConfig':
        pools = {}
        for key, raw in section.raw('pools').items():
            p = Section(raw, f'{section.path("pools")}.{key}')
            pools[int(key)] = RecruitPool(name=p.string('name'), price=p.integer('price', 0),
                                          free_interval=p.integer('free_interval_seconds', 0),
                                          quality_weights=p.numbers_by_int_key('quality_weights'),
                                          orange_pity=p.integer('orange_pity', 0),
                                          ten_discount=p.number('ten_discount', 0.01, 1))
        if 3 not in pools:
            raise ConfigError(f'{section.path("pools")} 必须包含卡池 3（新手首抽）')
        newbie = section.section('newbie')
        return cls(
            pools=MappingProxyType(pools),
            duplicate_soul_count=section.integer('duplicate_soul_count', 1),
            newbie=NewbieRecruit(candidate_hero_ids=newbie.integers('candidate_hero_ids', 1),
                                 quality_range=newbie.int_range('candidate_quality_range'),
                                 eligible_step_range=newbie.int_range('eligible_guide_step_range'),
                                 claim_key=newbie.string('claim_key')),
            response_flags=section.mapping('response_flags'),
        )


# ---------------------------------------------------------------------------
# store.json
# ---------------------------------------------------------------------------

@dataclass(frozen=True)
class StoreGood:
    prop_id: int
    price: Any            # None 表示取静态表价格
    currency: Any         # None 表示取静态表 MoneyType
    daily_limit: int
    vip_limit: int


@dataclass(frozen=True)
class MysteryStoreRule:
    shelf_size: int
    refresh_ingot: int
    free_refresh_seconds: int
    pool: Tuple[Mapping[str, Any], ...]


@dataclass(frozen=True)
class StoreConfig:
    goods: Tuple[StoreGood, ...]
    energy_prop_id: int
    energy_daily_limit_by_vip: Tuple[int, ...]
    mystery: MysteryStoreRule

    @classmethod
    def load(cls, section: Section) -> 'StoreConfig':
        goods = []
        for g in section.sections('goods'):
            price = g.raw('price')
            currency = g.raw('currency')
            if price is not None and (type(price) is not int or price < 0):
                raise ConfigError(f'{g.path("price")} 必须是 null 或非负整数')
            if currency not in (None, 1, 2):
                raise ConfigError(f'{g.path("currency")} 必须是 null、1 或 2')
            goods.append(StoreGood(prop_id=g.integer('PropsID', 1), price=price, currency=currency,
                                   daily_limit=g.integer('daily_limit', 0), vip_limit=g.integer('vip_limit', 0)))
        energy, mystery = section.section('energy_pill'), section.section('mystery_store')
        pool = mystery.raw('pool')
        if not isinstance(pool, list) or not pool:
            raise ConfigError(f'{mystery.path("pool")} 必须是非空数组')
        for i, item in enumerate(pool):
            check_reward(item, f'{mystery.path("pool")}[{i}]')
            if type(item.get('Price')) is not int or item.get('PriceType') not in (1, 2):
                raise ConfigError(f'{mystery.path("pool")}[{i}] 需要整数 Price 与 PriceType(1/2)')
        return cls(goods=tuple(goods), energy_prop_id=energy.integer('prop_id', 1),
                   energy_daily_limit_by_vip=energy.integers('daily_limit_by_vip', 0),
                   mystery=MysteryStoreRule(shelf_size=mystery.integer('shelf_size', 1),
                                            refresh_ingot=mystery.integer('refresh_ingot', 0),
                                            free_refresh_seconds=mystery.integer('free_refresh_seconds', 1),
                                            pool=freeze(pool)))


# ---------------------------------------------------------------------------
# activities.json
# ---------------------------------------------------------------------------

@dataclass(frozen=True)
class MailTemplate:
    content: str
    attachments: Tuple[Mapping[str, Any], ...]


#: activities 目录下的活动文件名（不含 .json）。
ACTIVITY_NAMES = ('sign', 'salary', 'seven_login', 'level_gift', 'month_card', 'growup', 'recharge',
                  'fortune_king', 'luckydisk', 'lingzhi', 'sanhua', 'exchange', 'share', 'marquee', 'mail')


@dataclass(frozen=True)
class ActivitiesConfig:
    sign_rewards: Tuple[Tuple[Mapping[str, Any], ...], ...]
    sign_vip_double_level: int
    salary: Mapping[str, Any]
    salary_gift_bags: Tuple[Mapping[str, Any], ...]
    seven_day_login: Tuple[Tuple[Mapping[str, Any], ...], ...]
    level_gifts: Tuple[Mapping[str, Any], ...]
    month_card: Mapping[str, Any]
    growup: Mapping[str, Any]
    recharge: Mapping[str, Any]
    fortune_king: Mapping[str, Any]
    luckydisk: Mapping[str, Any]
    lingzhi: Mapping[str, Any]
    sanhua: Mapping[str, Any]
    exchange: Mapping[str, Any]
    share: Mapping[str, Any]
    marquee: Tuple[Mapping[str, Any], ...]
    welcome_mail: MailTemplate
    level_up_mail_levels: Tuple[int, ...]
    level_up_mail: MailTemplate

    @classmethod
    def load(cls, sections: Mapping[str, Section]) -> 'ActivitiesConfig':
        sign, salary = sections['sign'], sections['salary']
        bags = []
        for bag in salary.sections('gift_bags'):
            for key in ('GifBagID', 'MustPlayerVipLevel', 'MustPlayerLevel', 'MustDayNuber'):
                bag.integer(key, 0)
            bag.integer('MustNumber', -1)  # 礼包库存，-1 表示不限
            bag.string('Name')
            bag.string('icon')  # 客户端 libao/ 目录下的图标文件名
            bag.rewards('reward', allow_empty=False)
            bags.append(freeze(bag.data))
        gifts = []
        for gift in sections['level_gift'].sections('gifts'):
            gift.integer('Level', 1)
            gift.rewards('reward', allow_empty=False)
            gifts.append(freeze(gift.data))
        for item in sections['marquee'].sections('items'):
            item.string('content')
            item.integer('repeatNumber', 1)
        recharge = sections['recharge']
        recharge.boolean('enabled')
        recharge.integer('server_vip_enable', 0, 1)
        recharge.integers('vip_thresholds', 1)
        recharge.rewards('first_recharge_reward')
        for pkg in recharge.sections('packages'):
            pkg.integer('ID', 0); pkg.integer('Money', 0); pkg.integer('Ingot', 0); pkg.integer('ExtreIngot', 0)
        for pkg in recharge.sections('point_packages'):
            pkg.integer('ID', 0); pkg.integer('Money', 0); pkg.integer('Point', 0)
        month = sections['month_card']
        for key in ('MonthCardConsume', 'WeekCardConsume', 'month_days', 'week_days', 'point_to_ingot_rate'):
            month.integer(key, 0)
        month.rewards('MonthReward', allow_empty=False)
        month.rewards('WeekReward', allow_empty=False)
        growup = sections['growup']
        growup.integer('vip_limit', 0)
        growup.integer('price_ingot', 0)
        for tier in growup.sections('tiers'):
            tier.integer('Level', 1); tier.integer('Ingot', 1)
        for item in sections['fortune_king'].sections('items'):
            item.integer('id', 1); item.integer('type', 1, 5); item.integer('need', 1)
            item.rewards('rewards', allow_empty=False)
        disk = sections['luckydisk']
        for key in ('daily_spins', 'gold_spin_limit', 'spin_cost_gold', 'choose_cost_ingot',
                    'refresh_daily', 'refresh_cost_ingot', 'choose_after'):
            disk.integer(key, 0)
        disk.number('crit_chance', 0, 1)
        for prize in disk.sections('prizes'):
            prize.integer('weight', 1)
            check_reward({k: v for k, v in prize.data.items() if k != 'weight'}, prize.source)
        disk.rewards('exchange_three', allow_empty=False)
        disk.rewards('exchange_four', allow_empty=False)
        zhi = sections['lingzhi']
        for key in ('daily_eat', 'free_refresh', 'refresh_cost_ingot'):
            zhi.integer(key, 0)
        for g in zhi.sections('ganodermas'):
            g.integer('type', 1, 5); g.string('name'); g.integer('addPotential', 1); g.integer('callCost', 0)
        sanhua = sections['sanhua']
        for window in sanhua.sections('windows'):
            window.string('start'); window.string('end')
        for cap in ('ingot', 'gold', 'energy'):
            sanhua.section('caps').integer(cap, 0)
        exchange = sections['exchange']
        for key in ('market', 'black_market'):
            for item in exchange.sections(key):
                item.integer('Id', 1); item.integer('daily_limit', -1)
                item.rewards('Reward', allow_empty=False); item.rewards('Consume', allow_empty=False)
        share = sections['share']
        share.rewards('share_reward', allow_empty=False)

        def mail(sec):
            return MailTemplate(content=sec.string('content'), attachments=sec.rewards('attachments'))
        mails = sections['mail']
        welcome, level_up = mails.section('welcome_mail'), mails.section('level_up_mail')
        return cls(
            sign_rewards=sign.reward_groups('rewards'),
            sign_vip_double_level=sign.integer('vip_double_level', 0),
            salary=MappingProxyType({**{k: salary.integer(k, 0) for k in
                                        ('base_gold', 'gold_per_level', 'base_knowledge', 'knowledge_per_level')},
                                     'streak_target_days': salary.integer('streak_target_days', 1),
                                     'streak_reward': salary.rewards('streak_reward')}),
            salary_gift_bags=tuple(bags),
            seven_day_login=sections['seven_login'].reward_groups('rewards'),
            level_gifts=tuple(sorted(gifts, key=lambda g: g['Level'])),
            month_card=freeze(month.data),
            growup=freeze(growup.data),
            recharge=freeze(recharge.data),
            fortune_king=freeze(sections['fortune_king'].data),
            luckydisk=freeze(disk.data),
            lingzhi=freeze(zhi.data),
            sanhua=freeze(sanhua.data),
            exchange=freeze(exchange.data),
            share=freeze(share.data),
            marquee=freeze(sections['marquee'].raw('items')),
            welcome_mail=mail(welcome),
            level_up_mail_levels=level_up.integers('levels', 1, allow_empty=True),
            level_up_mail=mail(level_up),
        )


# ---------------------------------------------------------------------------
# missions.json
# ---------------------------------------------------------------------------

MISSION_KINDS = frozenset(('stage_clear', 'player_level', 'hero_count', 'team_size', 'recruit_count',
                           'intensify_count', 'breakthrough_count', 'equip_count', 'battle_count_today',
                           'sign_today', 'mail_read', 'recruit_today'))


@dataclass(frozen=True)
class MissionDef:
    mission_id: int
    name: str
    description: str
    reward: Tuple[Mapping[str, Any], ...]
    kind: str
    target: int
    location_type: str
    location_id: int
    daily: bool


@dataclass(frozen=True)
class MissionsConfig:
    visible_plotline: int
    plotline: Tuple[MissionDef, ...]
    daily: Tuple[MissionDef, ...]

    @classmethod
    def load(cls, section: Section) -> 'MissionsConfig':
        def parse(items, daily):
            result, seen = [], set()
            for m in items:
                cond, loc = m.section('condition'), m.section('location')
                kind = cond.string('kind')
                if kind not in MISSION_KINDS:
                    raise ConfigError(f'{cond.path("kind")} 不支持: {kind}')
                mission = MissionDef(mission_id=m.integer('missionID', 1), name=m.string('name'),
                                     description=m.string('description'), reward=m.rewards('reward', allow_empty=False),
                                     kind=kind, target=cond.integer('target', 0),
                                     location_type=loc.string('Type'), location_id=loc.integer('ID', 0), daily=daily)
                if mission.mission_id in seen:
                    raise ConfigError(f'{m.source} 任务 ID 重复: {mission.mission_id}')
                seen.add(mission.mission_id)
                result.append(mission)
            return tuple(result)
        plotline, daily = parse(section.sections('plotline'), False), parse(section.sections('daily'), True)
        if {m.mission_id for m in plotline} & {m.mission_id for m in daily}:
            raise ConfigError(f'{section.source} 主线与每日任务 ID 冲突')
        return cls(visible_plotline=section.integer('visible_plotline', 1), plotline=plotline, daily=daily)


# ---------------------------------------------------------------------------
# features/<系统>.json（中期玩法，一个系统一个文件）
# ---------------------------------------------------------------------------

#: features 目录下的系统文件名（不含 .json），与 FeaturesConfig 字段一一对应。
FEATURE_NAMES = ('arena', 'worldboss', 'fuben', 'tower', 'refine', 'friends', 'transport', 'slave',
                 'artifact', 'gem', 'union', 'sacrifice', 'destiny', 'havoc', 'xunfang', 'csbattle', 'sanqing',
                 'xianmo')


@dataclass(frozen=True)
class FeaturesConfig:
    """争霸、妖王洞穴、十二元辰殿、通天塔、炼化炉、好友、运镖等玩法参数（只读映射，各服务自行读取）。"""
    arena: Mapping[str, Any]
    worldboss: Mapping[str, Any]
    fuben: Mapping[str, Any]
    tower: Mapping[str, Any]
    refine: Mapping[str, Any]
    friends: Mapping[str, Any]
    transport: Mapping[str, Any]
    slave: Mapping[str, Any]
    artifact: Mapping[str, Any]
    gem: Mapping[str, Any]
    union: Mapping[str, Any]
    sacrifice: Mapping[str, Any]
    destiny: Mapping[str, Any]
    havoc: Mapping[str, Any]
    xunfang: Mapping[str, Any]
    csbattle: Mapping[str, Any]
    sanqing: Mapping[str, Any]
    xianmo: Mapping[str, Any]

    @classmethod
    def load(cls, sections: Mapping[str, Section]) -> 'FeaturesConfig':
        arena, boss, fuben, tower = sections['arena'], sections['worldboss'], sections['fuben'], sections['tower']
        arena.integer('robot_count', 1); arena.strings('robot_names'); arena.integer('daily_times', 1)
        arena.rewards('win_reward'); arena.rewards('lose_reward')
        for item in arena.sections('exchanges'):
            item.integer('id', 1); item.integer('Score', 0); item.rewards('Reward', allow_empty=False)
        for item in arena.sections('limit_rank_exchanges'):
            item.integer('id', 1); item.integer('LimitRank', 1); item.rewards('Reward', allow_empty=False)
        for s in boss.sections('sessions'):
            s.integer('start_hour', 0, 23); s.integer('start_minute', 0, 59); s.integer('duration_minutes', 1)
        for b in boss.sections('bosses'):
            b.integer('id', 1); b.string('name'); b.integer('npc_id', 1)
        boss.rewards('rank_reward'); boss.rewards('chest_reward')
        fuben.integer('daily_keys', 0); fuben.numbers_by_int_key('star_multiplier')
        for i, card in enumerate(fuben.raw('card_rewards')):
            check_reward(card, f'{fuben.path("card_rewards")}[{i}]')
            if type(card.get('Cost')) is not int or type(card.get('Last')) is not int:
                raise ConfigError(f'{fuben.path("card_rewards")}[{i}] 需要整数 Cost 与 Last')
        tower.integer('max_floor', 1); tower.integer('daily_times', 1); tower.rewards('floor_reward')
        for level in tower.sections('buff_store'):
            level.integer('storeLevel', 1); level.integer('score', 0)
            for buff in level.sections('buffs'):
                buff.integer('index', 1); buff.integer('addtionProperty', 1); buff.number('addtionRate', 0)
        slave, artifact, gem = sections['slave'], sections['artifact'], sections['gem']
        slave.integers('cage_unlock_levels', 1); slave.integer('daily_free_captures', 0); slave.integer('hold_seconds', 1)
        artifact.integer('max_step', 1); artifact.integer('daily_rob_times', 1); artifact.number('rob_success_chance', 0, 1)
        gem.integer('max_level', 1); gem.numbers_by_int_key('base_value_by_shape'); gem.integer('bag_capacity', 1)
        union = sections['union']
        union.integer('create_level', 1); union.integer('create_gold', 0); union.integers('members_by_hall_level', 1)
        sections['sacrifice'].integer('max_level', 1)
        sections['destiny'].integer('platform_size', 1)
        sections['havoc'].integer('daily_times', 1)
        sections['xunfang'].integer('daily_free_visits', 0)
        sections['csbattle'].integer('seeds_per_type', 2)
        for chest in sections['sanqing'].sections('chests'):
            chest.integer('type', 1); chest.rewards('chest', allow_empty=False)
        xianmo = sections['xianmo']
        xianmo.integer('open_level', 1); xianmo.integer('seeds_per_dao', 4)
        xianmo.integer('worship_daily', 1); xianmo.integer('spit_cost', 0)
        for row in xianmo.sections('rank_rewards'):
            row.integer('rank', 1); row.rewards('reward', allow_empty=False)
        return cls(**{name: freeze(sections[name].data) for name in FEATURE_NAMES})


# ---------------------------------------------------------------------------
# 汇总
# ---------------------------------------------------------------------------

@dataclass(frozen=True)
class Config:
    server: ServerConfig
    auth: AuthConfig
    player: PlayerConfig
    hero: HeroConfig
    equipment: EquipmentConfig
    inventory: InventoryConfig
    battle: BattleConfig
    recruitment: RecruitmentConfig
    store: StoreConfig
    activities: ActivitiesConfig
    missions: MissionsConfig
    features: FeaturesConfig
    client_routes: frozenset
    config_dir: Path


def _read_section(config_dir: Path, name: str) -> Section:
    path = config_dir / f'{name}.json'
    data = load_json_file(path)
    if not isinstance(data, dict):
        raise ConfigError(f'配置文件 {path} 顶层必须是 JSON 对象')
    return Section({k: v for k, v in data.items() if not k.startswith('_')}, f'{name}.json')


def load_config(data_dir: Path) -> Config:
    """加载 ``data_dir/config`` 下的全部配置文件。"""
    data_dir = Path(data_dir)
    config_dir = data_dir / 'config'
    if not config_dir.is_dir():
        raise ConfigError(f'配置目录不存在: {config_dir}')
    routes = _read_section(config_dir, 'client_routes').strings('paths')
    if any(not path.startswith('/') for path in routes):
        raise ConfigError('client_routes.json.paths 中的路径必须以 / 开头')
    read = lambda name: _read_section(config_dir, name)  # noqa: E731
    return Config(
        server=ServerConfig.load(read('server'), data_dir),
        auth=AuthConfig.load(read('auth')),
        player=PlayerConfig.load(read('player')),
        hero=HeroConfig.load(read('hero')),
        equipment=EquipmentConfig.load(read('equipment')),
        inventory=InventoryConfig.load(read('inventory')),
        battle=BattleConfig.load(read('battle')),
        recruitment=RecruitmentConfig.load(read('recruitment')),
        store=StoreConfig.load(read('store')),
        activities=ActivitiesConfig.load({name: read(f'activities/{name}') for name in ACTIVITY_NAMES}),
        missions=MissionsConfig.load(read('missions')),
        features=FeaturesConfig.load({name: read(f'features/{name}') for name in FEATURE_NAMES}),
        client_routes=frozenset(routes),
        config_dir=config_dir,
    )
