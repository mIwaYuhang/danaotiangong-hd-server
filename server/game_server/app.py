"""组装根：把配置、存储、静态表、业务服务、路由表与分发器装配成一个应用。

依赖方向自上而下，服务之间只通过构造参数传递依赖::

    Application
    ├── Config / Storage / Catalog / Clock
    ├── HeroModel ─┐
    ├── EquipmentModel ─┴─ PlayerModel ─┬─ Ledger ─┬─ InventoryService（道具/商店）
    │                                    │          ├─ StageService（关卡）← BattleEngine
    │                                    │          ├─ HeroGrowthService / TalismanService
    │                                    │          ├─ RecruitmentService / MailService
    │                                    │          ├─ ActivityService / MissionService
    │                                    │          ├─ ArenaService / WorldBossService（多玩家：PlayerDirectory / RealmStore）
    │                                    │          ├─ FubenService / TowerService
    │                                    │          └─ RefineService / FriendService / TransportService
    │                                    ├─ TeamService
    │                                    └─ RoleService
    └── Dispatcher(Router)

``Application.handle(method, target)`` 是协议入口，HTTP 层与测试都只依赖它。
"""
from dataclasses import dataclass
from pathlib import Path
import random

from .catalog import Catalog
from .config import Config
from .protocol.dispatcher import Dispatcher
from .protocol.routes import build_router
from .services.account import AccountService
from .services.activities import ActivityService
from .services.artifact import ArtifactService, RankingService
from .services.battle import BattleEngine
from .services.csbattle import CsBattleService
from .services.destiny import DestinyService
from .services.gem import GemService
from .services.havoc import HavocService
from .services.clock import Clock
from .services.dungeons import FubenService, TowerService
from .services.equipment import EquipmentModel
from .services.growth import HeroGrowthService
from .services.hero_model import HeroModel
from .services.inventory import InventoryService, Ledger
from .services.mail import MailService
from .services.missions import MissionEvents, MissionService
from .services.player_state import PlayerModel
from .services.players import Friendships, PlayerDirectory, RealmStore
from .services.pvp import ArenaService, WorldBossService
from .services.recruitment import RecruitmentService
from .services.roles import RoleRepository, RoleService
from .services.sacrifice import SacrificeService
from .services.sanqing import SanqingService
from .services.slave import SlaveService
from .services.social import FriendService, RefineService, TransportService
from .services.stages import StageService
from .services.talisman import TalismanService
from .services.team import TeamService
from .services.union import UnionService
from .services.union_ext import UnionBoardService, UnionDemonService, UnionStoreService, XiantaoService
from .services.xunfang import XunFangService
from .storage import Storage


@dataclass(frozen=True)
class Services:
    account: AccountService
    roles: RoleService
    team: TeamService
    growth: HeroGrowthService
    talisman: TalismanService
    inventory: InventoryService
    recruitment: RecruitmentService
    stages: StageService
    missions: MissionService
    mail: MailService
    activities: ActivityService
    arena: ArenaService
    worldboss: WorldBossService
    fuben: FubenService
    tower: TowerService
    refine: RefineService
    friends: FriendService
    transport: TransportService
    slave: SlaveService
    artifact: ArtifactService
    gem: GemService
    ranking: RankingService
    union: UnionService
    sacrifice: SacrificeService
    destiny: DestinyService
    havoc: HavocService
    xunfang: XunFangService
    union_store: UnionStoreService
    union_demon: UnionDemonService
    union_board: UnionBoardService
    xiantao: XiantaoService
    csbattle: CsBattleService
    sanqing: SanqingService


def build_services(config: Config, storage: Storage, catalog: Catalog, clock: Clock, rng: random.Random) -> Services:
    realm_id = config.server.realm.id
    heroes = HeroModel(config.hero, catalog)
    equipment = EquipmentModel(config.equipment, catalog)
    model = PlayerModel(config.player, catalog, heroes, equipment, clock)
    ledger = Ledger(config.inventory, catalog, model, equipment, clock, rng)
    repository = RoleRepository(realm_id)
    directory = PlayerDirectory(repository, model, realm_id)
    store = RealmStore(realm_id)
    friendships = Friendships(realm_id)
    events = MissionEvents()
    mail = MailService(ledger, clock, config.player.initial_state.get('SystemMailName', '系统'), events, directory)
    activities = ActivityService(config.activities, ledger, clock, events, model)
    missions = MissionService(config.missions, ledger, catalog)
    engine = BattleEngine(config.battle, config.hero, catalog, heroes, rng)
    roles = RoleService(repository, model, mail, config.activities.welcome_mail)
    friends = FriendService(config.features.friends, model, ledger, clock, directory, friendships, mail)
    roles.enrichers.append(friends.enrich)
    services = Services(
        account=AccountService(storage, config.auth, realm_id),
        roles=roles,
        team=TeamService(model, events, directory),
        growth=HeroGrowthService(model, ledger, events),
        talisman=TalismanService(model, equipment, ledger, events),
        inventory=InventoryService(ledger, config.store, repository),
        recruitment=RecruitmentService(config.recruitment, model, ledger, clock, events),
        stages=StageService(config.battle, config.player, config.recruitment.newbie.claim_key,
                            catalog, ledger, model, engine, clock, events),
        missions=missions,
        mail=mail,
        activities=activities,
        arena=ArenaService(config.features.arena, model, ledger, engine, clock, directory, realm_id),
        worldboss=WorldBossService(config.features.worldboss, model, ledger, engine, clock, store),
        fuben=FubenService(config.features.fuben, model, ledger, engine, clock),
        tower=TowerService(config.features.tower, model, ledger, engine, clock),
        refine=RefineService(config.features.refine, model, ledger, equipment),
        friends=friends,
        transport=TransportService(config.features.transport, model, ledger, clock, engine, directory),
        slave=SlaveService(config.features.slave, model, ledger, engine, clock, directory, friendships),
        artifact=ArtifactService(config.features.artifact, model, ledger, engine, clock, directory),
        gem=GemService(config.features.gem, model, ledger, equipment, clock),
        ranking=RankingService(model, directory),
        union=(union := UnionService(config.features.union, model, ledger, clock, directory, store)),
        union_store=UnionStoreService(config.features.union['store'], union, ledger, clock, directory),
        union_demon=UnionDemonService(config.features.union['demon'], union, model, ledger, engine, clock),
        union_board=UnionBoardService(config.features.union, union, clock),
        xiantao=XiantaoService(config.features.union['xiantao'], union, ledger, clock),
        sacrifice=SacrificeService(config.features.sacrifice, model, ledger),
        destiny=DestinyService(config.features.destiny, model, ledger, clock),
        havoc=HavocService(config.features.havoc, model, ledger, engine, clock, directory, store),
        xunfang=XunFangService(config.features.xunfang, model, ledger, clock),
        csbattle=CsBattleService(config.features.csbattle, model, ledger, engine, clock, directory, store, config.server.realm.name),
        sanqing=SanqingService(config.features.sanqing, model, ledger, engine, clock, directory, store),
    )
    services.ranking.union_name = services.union.union_name
    services.sanqing.union_name = lambda db, player_id: ('' if directory.is_robot(player_id) else
                                                         services.union.union_name(db, directory.load_state(db, player_id) or {}))
    for provider in (services.arena.notify, services.worldboss.notify, services.friends.notify,
                     services.slave.notify, services.artifact.notify, services.union.notify,
                     services.destiny.notify, services.havoc.notify, services.csbattle.notify):
        model.add_notify_provider(provider)

    def notify_counts(state):
        return {
            'MailCount': MailService.unread_count(state),
            'MissionShow': missions.claimable_count(state),
            'SignRewardShow': 0 if state['Sign'].get('last_day') == clock.day_key() else 1,
            'EverydayRewardShow': 0 if state['Daily'].get('salary_taken') else 1,
            'SevenLoginShow': activities.seven_day_claimable(state),
            'lgbs': activities.level_gift_claimable(state),
        }
    model.add_notify_provider(notify_counts)

    def level_up_mail(state, old_level, new_level):
        template = config.activities.level_up_mail
        for level in config.activities.level_up_mail_levels:
            if old_level < level <= new_level:
                mail.send_system(state, template.content.replace('{level}', str(level)), list(template.attachments))
    model.add_level_up_listener(level_up_mail)
    return services


class Application:
    def __init__(self, config: Config, database: Path = None, clock: Clock = None, rng: random.Random = None):
        """``database`` 可覆盖配置中的存档路径；``clock`` / ``rng`` 供测试注入。"""
        self.config = config
        self.storage = Storage(database or config.server.database)
        self.catalog = Catalog(config.server.static_data_dir)
        self.clock = clock or Clock(config.player.daily_reset_hour)
        self.rng = rng or random.Random()
        self.services = build_services(config, self.storage, self.catalog, self.clock, self.rng)
        self.router = build_router(self.services, config.auth.token_length)
        self.dispatcher = Dispatcher(
            router=self.router, storage=self.storage,
            account=self.services.account, roles=self.services.roles,
            realm=config.server.realm, public_url=config.server.public_url,
            limits=config.server.http, token_length=config.auth.token_length,
            role_hooks=[self.services.missions], announcement_file=config.config_dir / 'announcement.html')

    def handle(self, method: str, target: str, body: bytes = b'', content_type: str = ''):
        """协议入口：返回 ``(状态码, 响应体, Content-Type)``。POST 表单体（multipart 或 urlencoded）会并入业务参数。"""
        return self.dispatcher.handle(method, target, body, content_type)
