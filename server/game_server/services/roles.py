"""角色仓储与角色接口：创建、加载、通知。

``/Role/Name`` 建角，``/Role/Default`` 拉取完整角色，``/Notify/Message`` 拉取状态位与红点。
建角时发放欢迎邮件（``activities.json``）。
"""
import json
import sqlite3

from ..errors import BusinessError
from .base import RoleContext, SessionContext
from .player_state import PlayerModel, STATE_NO_NICKNAME

STATE_NAME_EXISTS = -1103001
STATE_BAD_STARTER = -1103007


class RoleRepository:
    """``roles`` 表的读写；状态 JSON 的迁移由调用方负责。"""

    def __init__(self, realm_id: int):
        self.realm_id = realm_id

    def find(self, db, user: int):
        return db.execute('SELECT * FROM roles WHERE user_id = ? AND server_id = ?', (user, self.realm_id)).fetchone()

    def nickname_taken(self, db, name: str) -> bool:
        return db.execute('SELECT 1 FROM roles WHERE server_id = ? AND nickname_key = ?',
                          (self.realm_id, name.casefold())).fetchone() is not None

    def insert(self, db, user: int, name: str, hero_id: int, state: dict):
        db.execute('''INSERT INTO roles (user_id, server_id, nickname, nickname_key, hero_id, state_json)
                      VALUES (?, ?, ?, ?, ?, ?)''',
                   (user, self.realm_id, name, name.casefold(), hero_id,
                    json.dumps(state, ensure_ascii=False, separators=(',', ':'))))

    def rename(self, db, user: int, name: str):
        db.execute('UPDATE roles SET nickname = ?, nickname_key = ? WHERE user_id = ?', (name, name.casefold(), user))


class RoleService:
    def __init__(self, repository: RoleRepository, model: PlayerModel, mail=None, welcome_mail=None):
        self.repository = repository
        self.model = model
        self.mail = mail
        self.welcome_mail = welcome_mail
        self.enrichers = []  # ``enricher(db, state)``：加载角色时补充需要查库的派生字段（如好友申请数）

    # ---- 供分发器调用 ---------------------------------------------------------

    def open(self, ctx: SessionContext) -> RoleContext:
        """把会话上下文升级为角色上下文：读取并迁移角色状态，没有角色则要求先建角。"""
        row = self.repository.find(ctx.db, ctx.user)
        if row is None:
            raise BusinessError('请先选择初始英雄并设置昵称', STATE_NO_NICKNAME)
        state = self.model.migrate(json.loads(row['state_json']))
        for enricher in self.enrichers:
            enricher(ctx.db, state)
        return RoleContext(db=ctx.db, user=ctx.user, row=row, state=state)

    # ---- 接口处理函数 ---------------------------------------------------------

    def create(self, ctx: SessionContext, params) -> dict:
        """``/Role/Name``：选择初始英雄并设置昵称。重复提交相同内容时幂等返回。"""
        name = self.model.parse_nickname(params['name'])
        hero_id = params['heroProtoID']
        starters = self.model.starter_ids()
        if hero_id not in starters:
            choices = '、'.join(str(i) for i in sorted(starters))
            raise BusinessError(f'初始英雄必须为{choices}', STATE_BAD_STARTER)
        row = self.repository.find(ctx.db, ctx.user)
        if row is not None:
            if row['nickname'] == name and row['hero_id'] == hero_id:
                return self.model.presentation(self.model.migrate(json.loads(row['state_json'])), row['hero_id'])
            raise BusinessError('角色已创建，不能重复选择英雄或修改昵称')
        state = self.model.initial_state(ctx.user, name, hero_id)
        if self.mail is not None and self.welcome_mail is not None:
            self.mail.send_system(state, self.welcome_mail.content, list(self.welcome_mail.attachments))
        try:
            self.repository.insert(ctx.db, ctx.user, name, hero_id, state)
        except sqlite3.IntegrityError as exc:
            if self.repository.nickname_taken(ctx.db, name):
                raise BusinessError('昵称已存在', STATE_NAME_EXISTS) from exc
            raise
        return self.model.presentation(state)

    def load(self, ctx: RoleContext, params) -> dict:
        """``/Role/Default``：完整角色数据。"""
        return self.model.presentation(ctx.state, ctx.hero_id)

    def notify(self, ctx: RoleContext, params) -> dict:
        """``/Notify/Message``：状态位与红点。"""
        return self.model.notify(ctx.state)

    def set_avatar(self, ctx: RoleContext, params) -> dict:
        """``/Role/AvatarIndex?avatarIndex``：头像取上阵主将序号。"""
        index = params['avatarIndex']
        if not 1 <= index <= self.model.config.team_slots:
            raise BusinessError('头像序号无效')
        ctx.state['AvatarIndex'] = index
        return {'AvatarIndex': index}
