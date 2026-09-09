"""SQLite 存档：每次操作独占一个连接与一个写事务。

表结构：
- ``accounts``      账号（邮箱 + 加盐 PBKDF2 密码；游客账号邮箱为空）
- ``devices``       设备号 → 账号（游客登录）
- ``tickets``       账号票据（SDK 登录返回的 UserID，只存 SHA-256 摘要）
- ``game_users``    账号在某区服下的游戏用户 ID
- ``sessions``      游戏会话（进入区服返回的 Session，只存摘要）
- ``roles``         角色：昵称、初始英雄与完整状态 JSON
- ``local_battles`` （历史）关卡首次战斗结算
- ``arena_ranks``   争霸排名（未被真实玩家占据的排名由机器人填充）
- ``friendships``   好友关系（pending 申请 / accepted 已互为好友）
- ``friend_presents`` 好友体力赠送
- ``realm_kv``      区服级共享数据（如妖王洞穴每场的血量与伤害榜）

``PRAGMA user_version`` 记录迁移版本；迁移只做增量变更，不会重置已有数据。
"""
from contextlib import contextmanager
from pathlib import Path
import sqlite3

SCHEMA_VERSION = 3

BASE_TABLES = (
    '''CREATE TABLE IF NOT EXISTS accounts (
        id INTEGER PRIMARY KEY, email TEXT UNIQUE,
        password_salt BLOB, password_hash BLOB)''',
    '''CREATE TABLE IF NOT EXISTS devices (
        device TEXT PRIMARY KEY,
        account_id INTEGER NOT NULL REFERENCES accounts(id))''',
    '''CREATE TABLE IF NOT EXISTS tickets (
        digest TEXT PRIMARY KEY,
        account_id INTEGER NOT NULL REFERENCES accounts(id),
        expires INTEGER NOT NULL)''',
    '''CREATE TABLE IF NOT EXISTS game_users (
        id INTEGER PRIMARY KEY,
        account_id INTEGER NOT NULL REFERENCES accounts(id),
        server_id INTEGER NOT NULL,
        UNIQUE(account_id, server_id))''',
    '''CREATE TABLE IF NOT EXISTS sessions (
        digest TEXT PRIMARY KEY,
        user_id INTEGER NOT NULL REFERENCES game_users(id),
        expires INTEGER NOT NULL)''',
    'CREATE INDEX IF NOT EXISTS tickets_expiry ON tickets(expires)',
    'CREATE INDEX IF NOT EXISTS sessions_expiry ON sessions(expires)',
)

# 版本号 → 该版本需要执行的增量迁移语句。
MIGRATIONS = {
    1: (
        '''CREATE TABLE roles (
            user_id INTEGER PRIMARY KEY REFERENCES game_users(id),
            server_id INTEGER NOT NULL,
            nickname TEXT NOT NULL,
            nickname_key TEXT NOT NULL,
            hero_id INTEGER NOT NULL CHECK(hero_id IN (101,112,128)),
            state_json TEXT NOT NULL,
            UNIQUE(server_id, nickname_key))''',
    ),
    2: (
        '''CREATE TABLE local_battles (
            user_id INTEGER NOT NULL REFERENCES roles(user_id),
            cp_id INTEGER NOT NULL, ri INTEGER NOT NULL, star INTEGER NOT NULL,
            response_json TEXT NOT NULL, PRIMARY KEY(user_id, cp_id))''',
    ),
    # v3：多玩家共享数据——争霸排名、好友关系、体力赠送、区服级键值存储
    3: (
        '''CREATE TABLE arena_ranks (
            server_id INTEGER NOT NULL, rank INTEGER NOT NULL,
            user_id INTEGER NOT NULL REFERENCES game_users(id),
            PRIMARY KEY(server_id, rank), UNIQUE(server_id, user_id))''',
        '''CREATE TABLE friendships (
            server_id INTEGER NOT NULL, user_id INTEGER NOT NULL, friend_id INTEGER NOT NULL,
            status TEXT NOT NULL, message TEXT NOT NULL DEFAULT '', created INTEGER NOT NULL,
            PRIMARY KEY(server_id, user_id, friend_id))''',
        '''CREATE TABLE friend_presents (
            id INTEGER PRIMARY KEY, server_id INTEGER NOT NULL,
            from_id INTEGER NOT NULL, to_id INTEGER NOT NULL, day TEXT NOT NULL,
            claimed INTEGER NOT NULL DEFAULT 0, created INTEGER NOT NULL)''',
        'CREATE INDEX friend_presents_to ON friend_presents(server_id, to_id, claimed)',
        '''CREATE TABLE realm_kv (
            server_id INTEGER NOT NULL, key TEXT NOT NULL, value_json TEXT NOT NULL,
            PRIMARY KEY(server_id, key))''',
    ),
}


class Storage:
    """SQLite 文件存档。"""

    def __init__(self, path):
        if str(path) == ':memory:':
            raise ValueError('数据库必须为持久化文件路径')
        self.path = str(Path(path).expanduser().resolve())
        Path(self.path).parent.mkdir(parents=True, exist_ok=True)
        with self.transaction() as db:
            for statement in BASE_TABLES:
                db.execute(statement)
            self._migrate(db)

    @staticmethod
    def _migrate(db):
        version = db.execute('PRAGMA user_version').fetchone()[0]
        if version > SCHEMA_VERSION:
            raise ValueError(f'数据库版本 {version} 高于本服务支持的版本 {SCHEMA_VERSION}')
        for target in range(version + 1, SCHEMA_VERSION + 1):
            for statement in MIGRATIONS[target]:
                db.execute(statement)
            db.execute(f'PRAGMA user_version = {target}')

    @contextmanager
    def transaction(self):
        """打开连接并进入 ``BEGIN IMMEDIATE`` 写事务；退出时提交，异常时回滚。

        使用立即写锁串行化所有“读-改-写”操作（包括并发的游客建号）。
        """
        db = sqlite3.connect(self.path, timeout=15, isolation_level=None)
        db.row_factory = sqlite3.Row
        try:
            db.execute('PRAGMA foreign_keys = ON')
            db.execute('PRAGMA busy_timeout = 15000')
            db.execute('BEGIN IMMEDIATE')
            yield db
            db.commit()
        except BaseException:
            db.rollback()
            raise
        finally:
            db.close()
