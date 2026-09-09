"""仙盟（/Union/*）。

仙盟是区服级共享实体，存放在 ``RealmStore``：``union:<id>`` 为仙盟文档，``union:index`` 为编号列表。
文档字段：``id, name, level, buildings{1 大厅, 2 魔族巢穴, 3 神殿, 5 商店}, coin(仙盟贡献 CurUnionCoin),
tpuc(可分发晶石池), notice, out_notice, apply_status(1 免审), members{user_id: {position, joined}},
applies{user_id: 时间}, logs[], created``。
玩家侧 ``state.Union``：``id``（所属仙盟）、``applies``（已申请编号）、``left_at``（退盟时间，用于冷却）、
``worship``（每日捐献计数）。玩家个人晶石是资源 ``UnionCoin``（ItemType 27）。

客户端身份判断只看 Notify 的 ``IfHaveUnion``/``UnionStatus``，细粒度红点在 ``GetUnionInfo.NotifyUnion``。
"""
from copy import deepcopy
import json

from ..errors import BusinessError
from .base import Reply, RoleContext, decode_text, global_block
from .clock import Clock
from .inventory import Ledger
from .player_state import PlayerModel
from .players import PlayerDirectory, RealmStore

HALL, DEMON_CAVE, TEMPLE, SHOP = 1, 2, 3, 5
BUILDINGS = (HALL, DEMON_CAVE, TEMPLE, SHOP)
LOG_UPGRADE, LOG_BUILDING, LOG_BUY, LOG_AUCTION, LOG_WORSHIP, LOG_GIVE_COIN = 301, 302, 303, 304, 305, 306


def ascii_len(text: str) -> int:
    return sum(2 if ord(ch) > 127 else 1 for ch in text)


class UnionService:
    def __init__(self, config, model: PlayerModel, ledger: Ledger, clock: Clock, directory: PlayerDirectory, store: RealmStore):
        self.config = config
        self.model = model
        self.ledger = ledger
        self.clock = clock
        self.directory = directory
        self.store = store
        self.positions = config['positions']

    # ---- 存取 -------------------------------------------------------------

    def _index(self, db) -> list:
        return self.store.get(db, 'union:index', [])

    def _load(self, db, union_id: int):
        return self.store.get(db, f'union:{union_id}')

    def _save(self, db, union: dict):
        self.store.set(db, f'union:{union["id"]}', union)

    def _player(self, state: dict) -> dict:
        info = state.setdefault('Union', {'id': 0, 'applies': [], 'left_at': 0, 'worship': {'day': '', 'used': 0}})
        if info['worship'].get('day') != self.clock.day_key():
            info['worship'] = {'day': self.clock.day_key(), 'used': 0}
        return info

    def _mine(self, ctx: RoleContext) -> dict:
        info = self._player(ctx.state)
        union = self._load(ctx.db, info['id']) if info['id'] else None
        if union is None or str(ctx.user) not in union['members']:
            info['id'] = 0
            raise BusinessError('你还没有加入仙盟', -1143001)
        return union

    def _position(self, union: dict, user_id: int) -> int:
        return union['members'][str(user_id)]['position']

    def _require(self, union: dict, user_id: int, max_position: int):
        if self._position(union, user_id) > max_position:
            raise BusinessError('权限不足', -1143011)

    def _max_members(self, union: dict) -> int:
        levels = self.config['members_by_hall_level']
        return levels[min(len(levels), union['buildings'][str(HALL)]) - 1]

    def _log(self, union: dict, kind: int, content: dict):
        union['logs'].insert(0, {'Times': self.clock.now(), 'Type': kind, 'Content': json.dumps(content, ensure_ascii=False)})
        union['logs'] = union['logs'][:self.config['log_limit']]

    def _rank_of(self, db, union_id: int) -> int:
        unions = [u for u in (self._load(db, i) for i in self._index(db)) if u]
        unions.sort(key=lambda u: (-u['level'], -u['coin'], u['created']))
        return next((i for i, u in enumerate(unions, 1) if u['id'] == union_id), 0)

    def _leader_name(self, db, union: dict) -> str:
        leader = next((int(uid) for uid, m in union['members'].items() if m['position'] == self.positions['leader']), None)
        return self.directory.profile(db, leader)['Name'] if leader else ''

    def _member_statue(self, db, user_id: int, position: int):
        """神殿立绘：``statueAvatarID`` 必须是 ``BaseHeros`` 里的主将 ID，0 会让客户端 ``getHeroGroupWeaponId`` 报错，整页空白。"""
        try:
            profile = self.directory.profile(db, user_id)
        except BusinessError:
            return None
        avatar = int(profile.get('Avatar') or 0)
        if avatar <= 0:
            return None
        rebirth = int(profile.get('RebirthCount') or profile.get('BreakthroughCount') or 0)
        names = {1: '盟主', 2: '长老', 3: '长老', 4: '青龙护法', 5: '白虎护法', 6: '朱雀护法', 7: '玄武护法', 8: '普通成员'}
        return {'positionName': names.get(position, '普通成员'), 'statueName': profile['Name'],
                'statueAvatarID': avatar, 'breakthroughCount': rebirth,
                'statueWeaponID': int(profile.get('WeaponId') or 0),
                'statuePinJie': int(profile.get('PinJie') or 5)}

    def _statues(self, db, union: dict) -> list:
        members = [(int(uid), m['position']) for uid, m in union['members'].items()]
        order = []
        leader = next((uid for uid, pos in members if pos == self.positions['leader']), None)
        if leader:
            order.append((leader, self.positions['leader']))
        for uid, pos in members:
            if pos in self.positions['elders']:
                order.append((uid, pos))
        statues = []
        for uid, pos in order:
            item = self._member_statue(db, uid, pos)
            if item:
                statues.append(item)
        return statues

    def _info(self, ctx: RoleContext, union: dict) -> dict:
        me = union['members'][str(ctx.user)]
        return {'UnionId': union['id'], 'UnionName': union['name'], 'UnionLv': union['level'], 'UnionRank': self._rank_of(ctx.db, union['id']),
                'PositionId': me['position'], 'CurUnionCoin': union['coin'], 'PlayerUnionCoin': ctx.state.get('UnionCoin', 0),
                'TPUC': union['tpuc'], 'MemberCount': len(union['members']), 'MaxMemberCount': self._max_members(union),
                'HallLv': union['buildings'][str(TEMPLE)], 'ShopLv': union['buildings'][str(SHOP)],
                'BossCaveLv': union['buildings'][str(DEMON_CAVE)], 'Notice': union['notice'], 'OutNotice': union['out_notice'],
                'NotifyUnion': {'bWorship': self._player(ctx.state)['worship']['used'] < self.config['daily_worship_times'],
                                'bNewApply': me['position'] <= max(self.positions['elders']) and bool(union['applies']),
                                'bUpgrade': union['coin'] >= self._upgrade_cost(union, HALL) and union['level'] < self.config['max_level'],
                                'bHavePosition': False, 'bBossChange': False, 'IfNewMegBoard': False}}

    # ---- 创建 / 列表 / 申请 -----------------------------------------------------

    def create(self, ctx: RoleContext, params) -> Reply:
        state, db = ctx.state, ctx.db
        info = self._player(state)
        if info['id']:
            raise BusinessError('你已经加入了仙盟', -1143002)
        if state['PLevel'] < self.config['create_level']:
            raise BusinessError('等级不足，无法创建仙盟', -1143003)
        name = decode_text(params['name']).strip()
        if not name or len(name) > self.config['name_max_chars']:
            raise BusinessError('仙盟名称长度不合法')
        if any((u := self._load(db, i)) and u['name'] == name for i in self._index(db)):
            raise BusinessError('仙盟名称已被使用', -11430032)
        outcome = self.ledger.apply(state, consume=[dict(Type=1, ID=0, Count=self.config['create_gold'])])
        info = self._player(state)  # 账本结算会整体写回状态，需重新取块
        index = self._index(db)
        union_id = (max(index) + 1) if index else 1
        union = {'id': union_id, 'name': name, 'level': 1, 'buildings': {str(b): 1 for b in BUILDINGS}, 'coin': 0, 'tpuc': 0,
                 'notice': '', 'out_notice': '', 'apply_status': 0, 'created': self.clock.now(), 'logs': [],
                 'members': {str(ctx.user): {'position': self.positions['leader'], 'joined': self.clock.now()}}, 'applies': {}}
        self._save(db, union)
        self.store.set(db, 'union:index', index + [union_id])
        info.update(id=union_id, applies=[])
        self._withdraw_applies(db, ctx.user, [])
        return Reply(self._info(ctx, union), self.ledger.global_for(state, outcome))

    def list_all(self, ctx: RoleContext, params) -> dict:
        db = ctx.db
        info = self._player(ctx.state)
        unions = [u for u in (self._load(db, i) for i in self._index(db)) if u]
        unions.sort(key=lambda u: (-u['level'], -u['coin'], u['created']))
        page, count = max(1, params.get('page') or 1), params.get('count') or 20
        rows = []
        for rank, union in enumerate(unions, 1):
            rows.append({'UnionId': union['id'], 'UnionName': union['name'], 'UnionLv': union['level'], 'UnionRank': rank,
                         'LeaderName': self._leader_name(db, union), 'MemberCount': len(union['members']),
                         'MaxMemberCount': self._max_members(union), 'OutNotice': union['out_notice'],
                         'ApplyStatus': union['apply_status'], 'IsApply': 1 if union['id'] in info['applies'] else 0})
        cooldown = self.clock.remaining(info['left_at'] + self.config['rejoin_cooldown_seconds'], self.clock.now()) if info['left_at'] else 0
        return {'TotalUnionNum': len(rows), 'NextJoinTime': cooldown, 'UnionListInfo': rows[(page - 1) * count: page * count]}

    def _join(self, db, state: dict, union: dict, user_id: int):
        if len(union['members']) >= self._max_members(union):
            raise BusinessError('仙盟成员已满', -1143006)
        union['members'][str(user_id)] = {'position': self.positions['member'], 'joined': self.clock.now()}
        union['applies'].pop(str(user_id), None)
        self._save(db, union)
        info = self._player(state)
        info.update(id=union['id'], applies=[])
        self._withdraw_applies(db, user_id, [union['id']])

    def _withdraw_applies(self, db, user_id: int, keep: list):
        for union_id in self._index(db):
            if union_id in keep:
                continue
            union = self._load(db, union_id)
            if union and str(user_id) in union['applies']:
                union['applies'].pop(str(user_id))
                self._save(db, union)

    def apply(self, ctx: RoleContext, params) -> dict:
        state, db = ctx.state, ctx.db
        info = self._player(state)
        if info['id']:
            raise BusinessError('你已经加入了仙盟', -1143002)
        if state['PLevel'] < self.config['create_level']:
            raise BusinessError('等级不足', -11430025)
        if info['left_at'] and self.clock.now() < info['left_at'] + self.config['rejoin_cooldown_seconds']:
            raise BusinessError('退出仙盟后 24 小时内不能加入', -1143008)
        union = self._load(db, params['unionId'])
        if union is None:
            raise BusinessError('仙盟不存在', -1143010)
        if union['id'] in info['applies']:
            raise BusinessError('已经申请过该仙盟', -1143009)
        if union['apply_status'] == 1:
            self._join(db, state, union, ctx.user)
            return {'Joined': 1}
        if len(info['applies']) >= self.config['max_applies']:
            raise BusinessError('同时申请的仙盟数量已达上限', -1143007)
        if len(union['members']) >= self._max_members(union):
            raise BusinessError('仙盟成员已满', -1143006)
        union['applies'][str(ctx.user)] = self.clock.now()
        self._save(db, union)
        info['applies'].append(union['id'])
        return {'Joined': 0}

    def cancel_apply(self, ctx: RoleContext, params) -> dict:
        info = self._player(ctx.state)
        union = self._load(ctx.db, params['unionId'])
        if union and str(ctx.user) in union['applies']:
            union['applies'].pop(str(ctx.user))
            self._save(ctx.db, union)
        if params['unionId'] in info['applies']:
            info['applies'].remove(params['unionId'])
        return {}

    # ---- 信息 / 成员 ----------------------------------------------------------

    def info(self, ctx: RoleContext, params) -> dict:
        return self._info(ctx, self._mine(ctx))

    def members(self, ctx: RoleContext, params) -> dict:
        union = self._mine(ctx)
        rows = []
        for uid, member in union['members'].items():
            profile = self.directory.profile(ctx.db, int(uid))
            other = self.directory.load_state(ctx.db, int(uid))
            rebirth = int(profile.get('RebirthCount') or 0)
            rows.append({'PlayerId': int(uid), 'PlayerName': profile['Name'], 'AvatarId': profile['Avatar'], 'PlayerLevel': profile['Level'],
                         'PlayerLv': profile['Level'], 'PlayerFap': profile['BattlePower'], 'PositionId': member['position'],
                         'Online': 0 if int(uid) == ctx.user else max(0, self.clock.now() - (other or {}).get('LastSeenAt', union['created'])),
                         'UnionCoin': (other or {}).get('UnionCoin', 0), 'IsFriend': 0,
                         'BreakthroughCount': rebirth, 'rebirthCount': rebirth,
                         'weaponId': int(profile.get('WeaponId') or 0), 'pinJie': int(profile.get('PinJie') or 1)})
        rows.sort(key=lambda r: (r['PositionId'], -r['PlayerFap']))
        return {'MaxMemberCount': self._max_members(union), 'CurMemberCount': len(rows), 'PlayerUnionInfoList': rows}

    def leave(self, ctx: RoleContext, params) -> dict:
        union = self._mine(ctx)
        if self._position(union, ctx.user) == self.positions['leader']:
            raise BusinessError('盟主不能退出仙盟，请先转让盟主', -11430023)
        union['members'].pop(str(ctx.user))
        self._save(ctx.db, union)
        info = self._player(ctx.state)
        info.update(id=0, left_at=self.clock.now())
        return {}

    def _remove_member(self, db, union: dict, user_id: int, left: bool):
        union['members'].pop(str(user_id), None)
        other = self.directory.load_state(db, user_id)
        if other is not None:
            info = self._player(other)
            info.update(id=0, left_at=self.clock.now() if left else 0)
            self.directory.save_state(db, user_id, other)

    def kick(self, ctx: RoleContext, params) -> dict:
        union = self._mine(ctx)
        target = params['kickPlayerId']
        self._require(union, ctx.user, max(self.positions['elders']))
        if str(target) not in union['members'] or self._position(union, target) <= self._position(union, ctx.user):
            raise BusinessError('权限不足', -1143011)
        self._remove_member(ctx.db, union, target, left=True)
        self._save(ctx.db, union)
        return {}

    def dissolve(self, ctx: RoleContext, params) -> dict:
        union = self._mine(ctx)
        if self._position(union, ctx.user) != self.positions['leader']:
            raise BusinessError('只有盟主可以解散仙盟', -1143014)
        if union['level'] > self.config['no_dissolve_above_level']:
            raise BusinessError('高于 11 级的仙盟不能解散', -11430031)
        if len(union['members']) > 1:
            raise BusinessError('仙盟内还有其他成员，无法解散', -1143015)
        for uid in list(union['applies']):
            other = self.directory.load_state(ctx.db, int(uid))
            if other is not None and union['id'] in self._player(other)['applies']:
                self._player(other)['applies'].remove(union['id'])
                self.directory.save_state(ctx.db, int(uid), other)
        self.store.set(db := ctx.db, 'union:index', [i for i in self._index(db) if i != union['id']])
        self.store.delete_prefix(db, f'union:{union["id"]}')
        self._player(ctx.state).update(id=0, left_at=0)
        return {}

    def change_position(self, ctx: RoleContext, params) -> dict:
        union = self._mine(ctx)
        target, position = params['changePlayerId'], params['changePositionId']
        self._require(union, ctx.user, self.positions['leader'])
        if str(target) not in union['members'] or target == ctx.user:
            raise BusinessError('该玩家不在仙盟中', -1143010)
        if position not in (*self.positions['elders'], *self.positions['guardians'], self.positions['member']):
            raise BusinessError('职位不存在')
        if position != self.positions['member'] and any(m['position'] == position for m in union['members'].values()):
            raise BusinessError('该职位已有人担任', -1143012)
        union['members'][str(target)]['position'] = position
        self._save(ctx.db, union)
        return {}

    def change_leader(self, ctx: RoleContext, params) -> dict:
        union = self._mine(ctx)
        target = params['changePlayerId']
        self._require(union, ctx.user, self.positions['leader'])
        if str(target) not in union['members'] or target == ctx.user:
            raise BusinessError('该玩家不在仙盟中', -1143010)
        union['members'][str(target)]['position'] = self.positions['leader']
        union['members'][str(ctx.user)]['position'] = self.positions['member']
        self._save(ctx.db, union)
        return {}

    # ---- 申请审批 -------------------------------------------------------------

    def apply_list(self, ctx: RoleContext, params) -> dict:
        union = self._mine(ctx)
        rows = []
        for uid in union['applies']:
            profile = self.directory.profile(ctx.db, int(uid))
            other = self.directory.load_state(ctx.db, int(uid))
            rebirth = int(profile.get('RebirthCount') or 0)
            rows.append({'PlayerId': int(uid), 'AvatarId': profile['Avatar'], 'PlayerName': profile['Name'], 'PlayerLv': profile['Level'],
                         'PlayerFap': profile['BattlePower'], 'PlayerVipLv': (other or {}).get('VipLevel', 0),
                         'BreakthroughCount': rebirth, 'rebirthCount': rebirth,
                         'weaponId': int(profile.get('WeaponId') or 0), 'pinJie': int(profile.get('PinJie') or 1)})
        return {'ApplyMemberCount': len(rows), 'UnionApplyList': rows, 'UnionApplyStatus': union['apply_status']}

    def approve(self, ctx: RoleContext, params) -> dict:
        union = self._mine(ctx)
        self._require(union, ctx.user, max(self.positions['elders']))
        targets = [params['playerId']] if params.get('playerId') else [int(uid) for uid in union['applies']]
        for target in targets:
            if str(target) not in union['applies']:
                continue
            other = self.directory.load_state(ctx.db, target)
            if other is None or self._player(other)['id']:
                union['applies'].pop(str(target), None)
                continue
            if len(union['members']) >= self._max_members(union):
                self._save(ctx.db, union)
                raise BusinessError('仙盟成员已满', -1143006)
            self._join(ctx.db, other, union, target)
            self.directory.save_state(ctx.db, target, other)
        self._save(ctx.db, union)
        return {}

    def refuse(self, ctx: RoleContext, params) -> dict:
        union = self._mine(ctx)
        self._require(union, ctx.user, max(self.positions['elders']))
        targets = [params['refusePlayerId']] if params.get('refusePlayerId') else [int(uid) for uid in union['applies']]
        for target in targets:
            if union['applies'].pop(str(target), None) is not None:
                other = self.directory.load_state(ctx.db, target)
                if other is not None and union['id'] in self._player(other)['applies']:
                    self._player(other)['applies'].remove(union['id'])
                    self.directory.save_state(ctx.db, target, other)
        self._save(ctx.db, union)
        return {}

    def change_apply_status(self, ctx: RoleContext, params) -> dict:
        union = self._mine(ctx)
        self._require(union, ctx.user, max(self.positions['elders']))
        union['apply_status'] = 1 if params['status'] == 1 else 0
        self._save(ctx.db, union)
        return {'UnionApplyStatus': union['apply_status']}

    # ---- 公告 / 日志 / 分晶石 -------------------------------------------------------

    def _set_text(self, ctx: RoleContext, field: str, raw: str, max_position: int) -> dict:
        union = self._mine(ctx)
        self._require(union, ctx.user, max_position)
        text = decode_text(raw).strip()
        if ascii_len(text) > self.config['notice_max_ascii']:
            raise BusinessError('内容过长（最多 100 汉字或 200 英文字符）', -1143016)
        union[field] = text
        self._save(ctx.db, union)
        return {field: text}

    def update_notice(self, ctx: RoleContext, params) -> dict:
        return self._set_text(ctx, 'notice', params.get('notice') or '', max(self.positions['guardians']))

    def update_out_notice(self, ctx: RoleContext, params) -> dict:
        return self._set_text(ctx, 'out_notice', params.get('outNotice') or '', max(self.positions['elders']))

    def logs(self, ctx: RoleContext, params) -> list:
        return deepcopy(self._mine(ctx)['logs'])

    def give_coin(self, ctx: RoleContext, params) -> dict:
        union = self._mine(ctx)
        self._require(union, ctx.user, max(self.positions['elders']))
        targets = [int(x) for x in (params.get('playerIdList') or '').split(',') if x.strip().isdigit()]
        count = params['coinCount']
        targets = [t for t in targets if str(t) in union['members']]
        if not targets or count <= 0:
            raise BusinessError('请选择成员')
        if union['tpuc'] < count * len(targets):
            raise BusinessError('仙盟晶石不足', -11430033)
        union['tpuc'] -= count * len(targets)
        for target in targets:
            if target == ctx.user:
                self.ledger.apply(ctx.state, rewards=[dict(Type=27, ID=0, Count=count)])
            else:
                other = self.directory.load_state(ctx.db, target)
                if other is not None:
                    self.ledger.apply(other, rewards=[dict(Type=27, ID=0, Count=count)])
                    self.directory.save_state(ctx.db, target, other)
        self._log(union, LOG_GIVE_COIN, {'NowTPName': ctx.state['Name'], 'UCoin': count * len(targets)})
        self._save(ctx.db, union)
        return {'TPUC': union['tpuc']}

    # ---- 神殿捐献 -------------------------------------------------------------

    def _temple(self, ctx: RoleContext, union: dict) -> dict:
        used = self._player(ctx.state)['worship']['used']
        return {'additionRate': f"{union['buildings'][str(TEMPLE)] * 10}%", 'xmTempleLv': union['buildings'][str(TEMPLE)],
                'canWorshipTime': max(0, self.config['daily_worship_times'] - used),
                'curUnionCoin': int(ctx.state.get('UnionCoin') or 0),
                'isWorship': 1 if used < self.config['daily_worship_times'] else 0,
                'statueInfos': self._statues(ctx.db, union),
                'worshipInfos': [dict(o) for o in self.config['worship_options']]}

    def temple(self, ctx: RoleContext, params) -> dict:
        return self._temple(ctx, self._mine(ctx))

    def worship(self, ctx: RoleContext, params) -> Reply:
        union = self._mine(ctx)
        info = self._player(ctx.state)
        if info['worship']['used'] >= self.config['daily_worship_times']:
            raise BusinessError('今日捐献次数已用完', -1143004)
        options = self.config['worship_options']
        index = params['index']
        if not 1 <= index <= len(options):
            raise BusinessError('捐献档位不存在')
        option = options[index - 1]
        consume = []
        if option['costGold']:
            consume.append(dict(Type=1, ID=0, Count=option['costGold']))
        if option['costIngot']:
            consume.append(dict(Type=2, ID=0, Count=option['costIngot']))
        bonus = 1 + union['buildings'][str(TEMPLE)] * 0.1
        outcome = self.ledger.apply(ctx.state, consume=consume, rewards=[dict(Type=27, ID=0, Count=int(option['playerCoin'] * bonus))])
        info = self._player(ctx.state)  # 账本结算会整体写回状态，需重新取块
        info['worship']['used'] += 1
        gained = int(option['unionCoin'] * bonus)
        union['coin'] += gained
        union['tpuc'] += int(gained * self.config['worship_tpuc_ratio'])
        self._log(union, LOG_WORSHIP, {'PN': ctx.state['Name'], 'UCoin': gained})
        self._save(ctx.db, union)
        return Reply({'Result': self._temple(ctx, union), 'Reward': deepcopy(outcome.rewards)}, self.ledger.global_for(ctx.state, outcome))

    # ---- 建筑 -------------------------------------------------------------

    def _upgrade_cost(self, union: dict, building: int) -> int:
        level = union['buildings'][str(building)]
        return int(self.config['building_upgrade_coin_base'] * (self.config['building_upgrade_coin_growth'] ** (level - 1)))

    def _building_view(self, union: dict, building: int) -> dict:
        level = union['buildings'][str(building)]
        view = {'Type': building, 'Level': level, 'NextNeedCoin': self._upgrade_cost(union, building),
                'OpenUnionLv': self.config['building_open_union_level'].get(str(building), 1)}
        if building == HALL:
            levels = self.config['members_by_hall_level']
            view.update(MaxMember=levels[min(len(levels), level) - 1], CurMember=len(union['members']),
                        NextMaxMember=levels[min(len(levels), level + 1) - 1])
        return view

    def buildings(self, ctx: RoleContext, params) -> list:
        union = self._mine(ctx)
        return [self._building_view(union, b) for b in BUILDINGS]

    def upgrade(self, ctx: RoleContext, params) -> dict:
        union = self._mine(ctx)
        self._require(union, ctx.user, max(self.positions['elders']))
        building = params['type']
        if building not in BUILDINGS:
            raise BusinessError('建筑不存在')
        level = union['buildings'][str(building)]
        if level >= self.config['max_level']:
            raise BusinessError('已达最高等级')
        if building != HALL and level >= union['level']:
            raise BusinessError('建筑等级不能超过仙盟等级')
        if union['level'] < self.config['building_open_union_level'].get(str(building), 1):
            raise BusinessError('仙盟等级不足，建筑尚未开放')
        cost = self._upgrade_cost(union, building)
        if union['coin'] < cost:
            raise BusinessError('仙盟贡献不足')
        union['coin'] -= cost
        union['buildings'][str(building)] = level + 1
        if building == HALL:
            union['level'] = level + 1
            self._log(union, LOG_UPGRADE, {'NowTPName': ctx.state['Name'], 'Level': level + 1})
        else:
            self._log(union, LOG_BUILDING, {'NowTPName': ctx.state['Name'], 'Type': building, 'Level': level + 1})
        self._save(ctx.db, union)
        return self._building_view(union, building)

    # ---- Notify -----------------------------------------------------------------

    def notify(self, state: dict) -> dict:
        info = state.get('Union') or {}
        has_union = 1 if info.get('id') else 0
        return {'IfHaveUnion': has_union, 'UnionStatus': has_union}

    def union_name(self, db, state: dict) -> str:
        info = state.get('Union') or {}
        union = self._load(db, info['id']) if info.get('id') else None
        return union['name'] if union else ''
