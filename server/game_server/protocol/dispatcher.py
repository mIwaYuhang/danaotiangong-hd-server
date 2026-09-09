"""分发器：协议入口 ``handle(method, target) -> (状态码, 响应体, Content-Type)``。

职责：
1. 解析请求地址与查询参数（格式问题 → ``BadRequest``）；
2. 区服列表与健康检查等固定接口；
3. 按路由表定位处理函数，校验公共凭证参数（``user`` / ``session`` / ``serverid``）；
4. 在一个写事务内校验会话、按需加载角色、调用处理函数、落库；
5. 把 ``Reply`` / ``BusinessError`` 封装为客户端协议 ``{State, Result[, Global]}``。

HTTP 层只需关心传输：JSON 序列化与状态码由这里给出。
"""
import json
import zlib

from ..config import HttpConfig, RealmConfig
from ..errors import BadRequest, BusinessError
from ..services.base import SessionContext, as_reply
from .params import Text, Token, UserId
from .request import parse_target
from .router import PUBLIC, ROLE, Router

SERVER_LIST_PATH = '/ServerList.aspx'
HEALTH_PATH = '/health'
#: 客户端 ``network.lua`` 自动附加的公共参数；``sign`` 为旧签名，当前不校验。
COMMON_PARAMS = frozenset(('user', 'session', 'serverid', 'sign', 'version', 'resource', '_l', 'deviceToken'))
NOT_IMPLEMENTED = {'error': 'not_implemented'}


def server_list_payload(realm: RealmConfig, public_url: str) -> dict:
    """``/ServerList.aspx`` 的明文内容（客户端按 ``Code == 0`` 判定成功后 inflate 并解析 ``Data``）。"""
    return {'Code': 0, 'Message': 'OK', 'Data': [{
        'ServerID': realm.id, 'ServerName': realm.name, 'ServerUrl': public_url,
        'ServerState': realm.state, 'ServerHeat': realm.heat, 'GroupLoad': realm.group_load}]}


class Dispatcher:
    def __init__(self, router: Router, storage, account, roles, realm: RealmConfig,
                 public_url: str, limits: HttpConfig, token_length: int, role_hooks=()):
        """``role_hooks``：角色接口前后执行的对象列表，需提供 ``snapshot(state)`` 与 ``sync(snapshot, state, reply)``。"""
        self.router = router
        self.storage = storage
        self.account = account
        self.roles = roles
        self.role_hooks = list(role_hooks)
        self.realm = realm
        self.public_url = public_url
        self.limits = limits
        self.user_param = UserId()
        self.session_param = Token(token_length)
        self.serverid_param = Text(10, required=False)
        self.server_list_blob = zlib.compress(json.dumps(
            server_list_payload(realm, public_url), ensure_ascii=False, separators=(',', ':')).encode('utf-8'))

    # ---- 入口 -------------------------------------------------------------

    def handle(self, method: str, target: str, body: bytes = b''):
        path, query = parse_target(target, self.limits)
        if method == 'POST' and path == SERVER_LIST_PATH:
            return 200, self.server_list_blob, 'application/octet-stream'
        if method not in ('GET', 'POST'):
            return 404, NOT_IMPLEMENTED, None
        if method == 'POST' and body:
            # 客户端少数接口（仙盟公告、分晶石等）用 application/x-www-form-urlencoded 传长文本：
            # 表单字段并入业务参数，URL 上的同名参数优先。
            try:
                form_text = body.decode('utf-8')
            except UnicodeDecodeError:
                raise BadRequest('请求体不是 UTF-8 文本')
            _, form = parse_target(path + '?' + form_text, self.limits)
            query = {**form, **query}
        if path == HEALTH_PATH:
            return 200, {'status': 'ok', 'service': 'local-game-server', 'game_url': self.public_url}, None
        try:
            reply = self.dispatch(path, query)
        except BusinessError as exc:
            return 200, {'State': exc.state, 'Result': str(exc)}, None
        if reply is None:
            return 404, NOT_IMPLEMENTED, None
        return 200, reply.envelope(), None

    # ---- 路由与鉴权 -----------------------------------------------------------

    def dispatch(self, path: str, query: dict):
        route = self.router.match(path)
        if route is None:
            return self.unrouted(path)
        if route.access == PUBLIC:
            return as_reply(route.handler(route.parse(query)))
        user, session = self.credentials(query)
        unexpected = set(query) - COMMON_PARAMS - set(route.params)
        if unexpected:
            raise BadRequest('不支持的业务参数')
        params = route.parse(query)
        with self.storage.transaction() as db:
            self.account.validate_session(db, user, session)
            ctx = SessionContext(db=db, user=user)
            if route.access != ROLE:
                return as_reply(route.handler(ctx, params))
            role_ctx = self.roles.open(ctx)
            snapshots = [hook.snapshot(role_ctx.state) for hook in self.role_hooks]
            reply = as_reply(route.handler(role_ctx, params))
            # 处理函数之后的横切关注点（如任务状态变化推送），基于同一份状态
            for hook, snapshot in zip(self.role_hooks, snapshots):
                reply = hook.sync(snapshot, role_ctx.state, reply)
            role_ctx.save()
            return reply

    def credentials(self, query: dict):
        """校验公共凭证参数，返回 ``(user, session)``。"""
        user = self.user_param.parse(query.get('user'), 'user')
        serverid = self.serverid_param.parse(query.get('serverid'), 'serverid')
        if serverid is not None and serverid != str(self.realm.id):
            raise BusinessError('区服不存在')
        session = self.session_param.parse(query.get('session'), 'session')
        return user, session

    @staticmethod
    def unrouted(path: str):
        """未实现的接口：SDK 与直登给出明确提示，其余返回 404。"""
        if path == '/temp/login.aspx':
            raise BusinessError('昵称直登尚未实现，请使用账号密码登录或游客登录。')
        if path.startswith('/sdk/'):
            raise BusinessError('本地 SDK 接口尚未实现')
        return None
