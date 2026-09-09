"""账号、票据与会话（本地测试用途，不是百度 SDK 鉴权；客户端 sign 参数被忽略）。

两级凭证：
- 票据（客户端字段 ``UserID``）：SDK 登录（游客 / 邮箱）后发放，账号级，用于 ``/Role/partner`` 进入区服；
  有效期内可重复使用，便于客户端重试与断线重连。
- 会话（客户端字段 ``Session``）：进入区服后发放，区服用户级，用于所有业务接口。

安全说明：
- 设备号是弱凭证，只在本地受信环境使用；
- 密码由客户端 MD5 后上送，服务端再做随机盐 PBKDF2-HMAC-SHA256 存储；
- 数据库只存令牌的 SHA-256 摘要。
"""
import hashlib
import hmac
import secrets
import time

from ..config import AuthConfig
from ..errors import BusinessError

#: 客户端 netstate.lua 中定义的账号相关 State 码。
STATE_ACCOUNT_NOT_EXISTS = -1102001
STATE_PASSWORD_ERROR = -1102002
STATE_ACCOUNT_EXISTS = -1102007


def digest(token: str) -> str:
    return hashlib.sha256(token.encode('utf-8')).hexdigest()


class AccountService:
    def __init__(self, storage, config: AuthConfig, realm_id: int):
        self.storage = storage
        self.config = config
        self.realm_id = realm_id

    # ---- 工具 -----------------------------------------------------------

    def _password_hash(self, password: str, salt: bytes) -> bytes:
        return hashlib.pbkdf2_hmac('sha256', password.lower().encode('ascii'), salt, self.config.pbkdf2_iterations)

    def _issue_ticket(self, db, account_id: int) -> dict:
        """发放账号票据，顺带清理过期票据与会话。"""
        now = int(time.time())
        db.execute('DELETE FROM tickets WHERE expires <= ?', (now,))
        db.execute('DELETE FROM sessions WHERE expires <= ?', (now,))
        token = secrets.token_urlsafe(self.config.token_bytes)
        db.execute('INSERT INTO tickets VALUES (?, ?, ?)',
                   (digest(token), account_id, now + self.config.ticket_ttl))
        return {'UserID': token}

    # ---- 公开接口处理函数 ---------------------------------------------------

    def guest_login(self, params) -> dict:
        """``/sdk/Default``：按设备号建号或找回游客账号。"""
        device = params['udid']
        with self.storage.transaction() as db:
            row = db.execute('SELECT account_id FROM devices WHERE device = ?', (device,)).fetchone()
            if row is None:
                account_id = db.execute('INSERT INTO accounts DEFAULT VALUES').lastrowid
                db.execute('INSERT INTO devices VALUES (?, ?)', (device, account_id))
            else:
                account_id = row['account_id']
            return self._issue_ticket(db, account_id)

    def register(self, params) -> dict:
        """``/sdk/Register``：邮箱注册。"""
        email, password = params['email'], params['pwd']
        salt = secrets.token_bytes(16)
        hashed = self._password_hash(password, salt)
        with self.storage.transaction() as db:
            if db.execute('SELECT id FROM accounts WHERE email = ?', (email,)).fetchone():
                raise BusinessError('账号已存在', STATE_ACCOUNT_EXISTS)
            account_id = db.execute(
                'INSERT INTO accounts(email, password_salt, password_hash) VALUES (?, ?, ?)',
                (email, salt, hashed)).lastrowid
            return self._issue_ticket(db, account_id)

    def login(self, params) -> dict:
        """``/sdk/login``：邮箱登录。PBKDF2 计算放在写事务之外，避免长时间持锁。"""
        email, password = params['email'], params['pwd']
        with self.storage.transaction() as db:
            row = db.execute('SELECT * FROM accounts WHERE email = ?', (email,)).fetchone()
        if row is None:
            raise BusinessError('账号不存在', STATE_ACCOUNT_NOT_EXISTS)
        if not hmac.compare_digest(self._password_hash(password, row['password_salt']), row['password_hash']):
            raise BusinessError('密码错误', STATE_PASSWORD_ERROR)
        with self.storage.transaction() as db:
            return self._issue_ticket(db, row['id'])

    def enter_realm(self, params) -> dict:
        """``/Role/partner``：用票据换取本区服的游戏用户 ID 与会话。"""
        if params['serverid'] != str(self.realm_id):
            raise BusinessError('区服不存在')
        ticket = params['userid']  # 协议层已把 {"sessionId": 票据} 解析为票据字符串
        now = int(time.time())
        with self.storage.transaction() as db:
            row = db.execute('SELECT account_id FROM tickets WHERE digest = ? AND expires > ?',
                             (digest(ticket), now)).fetchone()
            if row is None:
                raise BusinessError('账号票据无效或已过期')
            db.execute('INSERT OR IGNORE INTO game_users(account_id, server_id) VALUES (?, ?)',
                       (row['account_id'], self.realm_id))
            user = db.execute('SELECT id FROM game_users WHERE account_id = ? AND server_id = ?',
                              (row['account_id'], self.realm_id)).fetchone()['id']
            token = secrets.token_urlsafe(self.config.token_bytes)
            db.execute('DELETE FROM sessions WHERE expires <= ?', (now,))
            db.execute('INSERT INTO sessions VALUES (?, ?, ?)',
                       (digest(token), user, now + self.config.session_ttl))
            return {'UserId': user, 'Session': token}

    # ---- 供分发器调用 ---------------------------------------------------------

    def validate_session(self, db, user: int, session: str):
        """在调用方的事务内校验会话是否有效、是否属于该用户与本区服。"""
        row = db.execute('''SELECT g.id FROM sessions s JOIN game_users g ON g.id = s.user_id
            WHERE s.digest = ? AND s.expires > ? AND g.id = ? AND g.server_id = ?''',
            (digest(session), int(time.time()), user, self.realm_id)).fetchone()
        if row is None:
            raise BusinessError('游戏会话无效、已过期或与用户/区服不匹配')
