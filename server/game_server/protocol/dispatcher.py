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
import re
from urllib.parse import quote
import zlib

from ..config import HttpConfig, RealmConfig
from ..errors import BadRequest, BusinessError
from ..services.base import SessionContext, as_reply
from .params import Text, Token, UserId
from .request import parse_target
from .router import PUBLIC, ROLE, Router

SERVER_LIST_PATH = '/ServerList.aspx'
HEALTH_PATH = '/health'
ANNOUNCEMENT_PATH = '/Announcement/Index'
FALLBACK_ANNOUNCEMENT = '<!DOCTYPE html><html lang="zh-CN"><head><meta charset="utf-8"><title>公告</title></head>' \
                        '<body style="font-family:sans-serif;padding:16px">暂无公告。</body></html>'
#: 客户端 ``network.lua`` 自动附加的公共参数；``sign`` 为旧签名，当前不校验。
COMMON_PARAMS = frozenset(('user', 'session', 'serverid', 'sign', 'version', 'resource', '_l', 'deviceToken'))
NOT_IMPLEMENTED = {'error': 'not_implemented'}


def server_list_payload(realm: RealmConfig, public_url: str) -> dict:
    """``/ServerList.aspx`` 的明文内容（客户端按 ``Code == 0`` 判定成功后 inflate 并解析 ``Data``）。"""
    return {'Code': 0, 'Message': 'OK', 'Data': [{
        'ServerID': realm.id, 'ServerName': realm.name, 'ServerUrl': public_url,
        'ServerState': realm.state, 'ServerHeat': realm.heat, 'GroupLoad': realm.group_load}]}


MULTIPART_NAME = re.compile(rb'name="([^"]*)"')
BOUNDARY = re.compile(r'boundary=("?)([^";]+)\1')
QUERY_SAFE = re.compile(r'^[A-Za-z0-9._~%+-]*$')


def form_query(fields: dict) -> str:
    """把表单字段拼成查询串以复用参数校验。

    客户端在放入 multipart 之前已对值做过 URL 编码（``stringBase64AndUrlEncode``），这类值原样拼接、只解码一次；
    含有其它字符的值再做一次编码，保证解析后得到原文。
    """
    parts = []
    for key, value in fields.items():
        parts.append(f'{quote(key, safe="")}={value if QUERY_SAFE.match(value) else quote(value, safe="")}')
    return '&'.join(parts)


def form_body_as_query(body: bytes, content_type: str) -> str:
    """把 POST 正文转成查询串：multipart/form-data 逐字段拼接；application/x-www-form-urlencoded 本身就是查询串。"""
    kind = (content_type or '').split(';')[0].strip().lower()
    try:
        if kind != 'multipart/form-data':
            return body.decode('utf-8')
        match = BOUNDARY.search(content_type)
        if match is None:
            raise BadRequest('multipart 请求缺少 boundary')
        boundary = b'--' + match.group(2).encode('utf-8')
        fields = {}
        for part in body.split(boundary)[1:]:
            if part.strip() in (b'', b'--'):
                continue
            head, _, value = part.partition(b'\r\n\r\n')
            name = MULTIPART_NAME.search(head)
            if name is not None:
                fields[name.group(1).decode('utf-8')] = value.rstrip(b'\r\n').decode('utf-8')
        return form_query(fields)
    except UnicodeDecodeError:
        raise BadRequest('请求体不是 UTF-8 文本')


class Dispatcher:
    def __init__(self, router: Router, storage, account, roles, realm: RealmConfig,
                 public_url: str, limits: HttpConfig, token_length: int, role_hooks=(), announcement_file=None):
        """``role_hooks``：角色接口前后执行的对象列表，需提供 ``snapshot(state)`` 与 ``sync(snapshot, state, reply)``。
        ``announcement_file``：公告页 HTML 文件路径（客户端 WebView 打开 ``/Announcement/Index``）。"""
        self.router = router
        self.announcement_file = announcement_file
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

    def announcement_html(self) -> bytes:
        try:
            return self.announcement_file.read_bytes() if self.announcement_file else FALLBACK_ANNOUNCEMENT.encode('utf-8')
        except OSError:
            return FALLBACK_ANNOUNCEMENT.encode('utf-8')

    def handle(self, method: str, target: str, body: bytes = b'', content_type: str = ''):
        path, query = parse_target(target, self.limits)
        if method == 'POST' and path == SERVER_LIST_PATH:
            return 200, self.server_list_blob, 'application/octet-stream'
        if method not in ('GET', 'POST'):
            return 404, NOT_IMPLEMENTED, None
        if path == ANNOUNCEMENT_PATH:
            # 客户端用内嵌 WebView 打开公告页：直接返回 HTML（每次读取文件，改公告无需重启）。
            return 200, self.announcement_html(), 'text/html; charset=utf-8'
        if method == 'POST' and body:
            # 客户端的 POST 接口（加好友留言、仙盟公告、分晶石等）由 quick-cocos2d-x 的 addPOSTValue 发出：
            # 正文是 multipart/form-data，且 session/version/resource/_l 也放在正文里。
            # 表单字段并入业务参数并走同一套参数校验，URL 上的同名参数优先。
            _, form = parse_target(path + '?' + form_body_as_query(body, content_type), self.limits)
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
