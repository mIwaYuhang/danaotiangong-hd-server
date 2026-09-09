"""玩家目录与区服共享数据：让所有玩法都能以同一种方式访问“其他玩家”。

- ``PlayerDirectory``：按玩家 ID 取公开资料（名字、等级、阵容、战力），真实玩家读自 ``roles`` 表，
  机器人（ID ≥ ``ROBOT_BASE``）由注册的生成器按需构造；也提供跨玩家的状态读写（同一事务内）。
- ``RealmStore``：区服级键值存储（``realm_kv``），用于妖王血量、伤害榜等所有玩家共享的数据。
- ``Friendships``：好友关系与体力赠送的表操作。

所有操作都使用调用方事务中的连接（``ctx.db``），SQLite 的写事务串行化保证了跨玩家更新的一致性。
"""
from copy import deepcopy
import json

from ..errors import BusinessError

#: 机器人玩家 ID 起点；真实玩家 ID 远小于此值。
ROBOT_BASE = 100_000_000
STATUS_PENDING, STATUS_ACCEPTED = 'pending', 'accepted'


class PlayerDirectory:
    def __init__(self, repository, model, realm_id: int):
        self.repository = repository
        self.model = model
        self.realm_id = realm_id
        self._robot_provider = None

    def set_robot_provider(self, provider):
        """注册机器人资料生成器：``provider(robot_id) -> 资料 dict 或 None``。"""
        self._robot_provider = provider

    @staticmethod
    def is_robot(player_id: int) -> bool:
        return player_id >= ROBOT_BASE

    # ---- 真实玩家 -----------------------------------------------------------

    def load_state(self, db, user_id: int):
        """读取并迁移另一名玩家的状态（不落库）；不存在返回 None。"""
        row = self.repository.find(db, user_id)
        if row is None:
            return None
        return self.model.migrate(json.loads(row['state_json']))

    def save_state(self, db, user_id: int, state: dict):
        db.execute('UPDATE roles SET state_json = ? WHERE user_id = ?', (json.dumps(state, ensure_ascii=False), user_id))

    def all_user_ids(self, db) -> list:
        return [r['user_id'] for r in db.execute('SELECT user_id FROM roles WHERE server_id = ? ORDER BY user_id', (self.realm_id,))]

    def profile_from_state(self, state: dict) -> dict:
        team = self.model.team(state)
        lead = self.model.avatar_hero(state)
        rebirth = int(lead.get('rebirthCount') or 0) if lead else 0
        weapon_id, pinjie = self.model.weapon_of(lead)
        return {'PlayerId': state['ID'], 'Name': state['Name'], 'Level': state['PLevel'], 'Vip': state.get('VipLevel', 0),
                'Avatar': lead['heroId'] if lead else 0, 'RebirthCount': rebirth, 'BreakthroughCount': rebirth,
                'WeaponId': weapon_id, 'PinJie': pinjie,
                'BattlePower': team['battlePower'], 'team': team,
                'partnerTeam': deepcopy(state.get('partnerTeam', [])),
                'attributeAddition': deepcopy(state.get('attributeAddition', {})), 'robot': False}

    @staticmethod
    def figure_of(profile: dict) -> dict:
        """立绘字段：进阶次数与手上武器，给好友/仙盟/排行等 3D 展示用。"""
        rebirth = int((profile or {}).get('RebirthCount') or 0)
        weapon = int((profile or {}).get('WeaponId') or 0)
        pinjie = int((profile or {}).get('PinJie') or 1)
        return {'rebirthCount': rebirth, 'BreakthroughCount': rebirth, 'RebirthCount': rebirth,
                'weaponId': weapon, 'WeaponId': weapon, 'pinJie': pinjie, 'PinJie': pinjie}

    # ---- 统一寻址 -----------------------------------------------------------

    def profile(self, db, player_id: int) -> dict:
        """公开资料；真实玩家或机器人都不存在时抛业务错误。"""
        if self.is_robot(player_id):
            profile = self._robot_provider(player_id) if self._robot_provider else None
            if profile is None:
                raise BusinessError('玩家不存在')
            return profile
        state = self.load_state(db, player_id)
        if state is None:
            raise BusinessError('玩家不存在')
        return self.profile_from_state(state)

    def battle_team(self, db, player_id: int) -> list:
        """对方阵容的英雄记录列表（已刷新属性），供战斗引擎生成单位。"""
        if self.is_robot(player_id):
            return [h for h in self.profile(db, player_id)['team']['groupList'] if h.get('heroId')]
        state = self.load_state(db, player_id)
        if state is None:
            raise BusinessError('玩家不存在')
        return self.model.team_heroes(state)


class RealmStore:
    """区服级共享 JSON 键值存储。"""

    def __init__(self, realm_id: int):
        self.realm_id = realm_id

    def get(self, db, key: str, default=None):
        row = db.execute('SELECT value_json FROM realm_kv WHERE server_id = ? AND key = ?', (self.realm_id, key)).fetchone()
        return json.loads(row['value_json']) if row else default

    def set(self, db, key: str, value):
        db.execute('INSERT INTO realm_kv(server_id, key, value_json) VALUES (?, ?, ?) '
                   'ON CONFLICT(server_id, key) DO UPDATE SET value_json = excluded.value_json',
                   (self.realm_id, key, json.dumps(value, ensure_ascii=False)))

    def delete_prefix(self, db, prefix: str):
        db.execute('DELETE FROM realm_kv WHERE server_id = ? AND key LIKE ?', (self.realm_id, prefix + '%'))


class Friendships:
    def __init__(self, realm_id: int):
        self.realm_id = realm_id

    def status(self, db, user_id: int, friend_id: int):
        row = db.execute('SELECT status FROM friendships WHERE server_id = ? AND user_id = ? AND friend_id = ?',
                         (self.realm_id, user_id, friend_id)).fetchone()
        return row['status'] if row else None

    def friends_of(self, db, user_id: int) -> list:
        return [r['friend_id'] for r in db.execute(
            'SELECT friend_id FROM friendships WHERE server_id = ? AND user_id = ? AND status = ? ORDER BY created',
            (self.realm_id, user_id, STATUS_ACCEPTED))]

    def requests_to(self, db, user_id: int) -> list:
        """向我发出的申请：``[(申请人 ID, 留言)]``。"""
        return [(r['user_id'], r['message']) for r in db.execute(
            'SELECT user_id, message FROM friendships WHERE server_id = ? AND friend_id = ? AND status = ? ORDER BY created',
            (self.realm_id, user_id, STATUS_PENDING))]

    def request(self, db, user_id: int, friend_id: int, message: str, now: int):
        if self.status(db, user_id, friend_id) is not None:
            raise BusinessError('已发送过申请或已是好友')
        db.execute('INSERT INTO friendships VALUES (?, ?, ?, ?, ?, ?)',
                   (self.realm_id, user_id, friend_id, STATUS_PENDING, message[:200], now))

    def accept(self, db, user_id: int, requester_id: int, now: int):
        if self.status(db, requester_id, user_id) != STATUS_PENDING:
            raise BusinessError('没有该玩家的好友申请')
        db.execute('UPDATE friendships SET status = ? WHERE server_id = ? AND user_id = ? AND friend_id = ?',
                   (STATUS_ACCEPTED, self.realm_id, requester_id, user_id))
        db.execute('INSERT OR REPLACE INTO friendships VALUES (?, ?, ?, ?, ?, ?)',
                   (self.realm_id, user_id, requester_id, STATUS_ACCEPTED, '', now))

    def remove(self, db, user_id: int, friend_id: int):
        db.execute('DELETE FROM friendships WHERE server_id = ? AND ((user_id = ? AND friend_id = ?) OR (user_id = ? AND friend_id = ?))',
                   (self.realm_id, user_id, friend_id, friend_id, user_id))

    # ---- 体力赠送 -----------------------------------------------------------

    def presented_today(self, db, from_id: int, to_id: int, day: str) -> bool:
        return db.execute('SELECT 1 FROM friend_presents WHERE server_id = ? AND from_id = ? AND to_id = ? AND day = ?',
                          (self.realm_id, from_id, to_id, day)).fetchone() is not None

    def present(self, db, from_id: int, to_id: int, day: str, now: int):
        if self.presented_today(db, from_id, to_id, day):
            raise BusinessError('今日已赠送过该好友')
        db.execute('INSERT INTO friend_presents(server_id, from_id, to_id, day, claimed, created) VALUES (?, ?, ?, ?, 0, ?)',
                   (self.realm_id, from_id, to_id, day, now))

    def unclaimed_presents(self, db, to_id: int) -> list:
        return [dict(r) for r in db.execute(
            'SELECT id, from_id, day, created FROM friend_presents WHERE server_id = ? AND to_id = ? AND claimed = 0 ORDER BY created',
            (self.realm_id, to_id))]

    def claim(self, db, to_id: int, present_ids) -> int:
        count = 0
        for pid in present_ids:
            cursor = db.execute('UPDATE friend_presents SET claimed = 1 WHERE server_id = ? AND to_id = ? AND id = ? AND claimed = 0',
                                (self.realm_id, to_id, pid))
            count += cursor.rowcount
        return count
