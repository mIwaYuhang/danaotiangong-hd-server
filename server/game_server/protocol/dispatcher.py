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
from urllib.parse import parse_qsl, unquote_plus
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
MULTIPART_NAME_BARE = re.compile(rb'name=([^;\r\n]+)')
BOUNDARY = re.compile(r'boundary\s*=\s*("?)([^";]+)\1', re.I)


def _multipart_boundary(body: bytes, content_type: str) -> bytes:
    match = BOUNDARY.search(content_type or '')
    if match is not None:
        return b'--' + match.group(2).encode('utf-8')
    line = body.lstrip().split(b'\r\n', 1)[0].split(b'\n', 1)[0]
    if line.startswith(b'--') and len(line) > 2:
        return line
    return b''


def _decode_form_value(raw: str) -> str:
    """表单值解码一次。客户端常先 Base64 再 URL 编码；未编码的原文保持不变。"""
    try:
        return unquote_plus(raw, encoding='utf-8', errors='strict')
    except UnicodeError:
        return raw.replace('+', ' ')


def parse_form_body(body: bytes, content_type: str) -> dict:
    """解析 POST 正文为 ``{字段: 字符串}``，不走 URL 解析（避免 #、竖线、尾部 & 被当成非法查询）。

    支持 multipart/form-data 与 application/x-www-form-urlencoded。
    重复键后者覆盖；空字段名忽略。C++ 层拼表单时常带末尾 ``&``。
    """
    if not body:
        return {}
    kind = (content_type or '').split(';')[0].strip().lower()
    boundary = _multipart_boundary(body, content_type)
    looks_multipart = kind == 'multipart/form-data' or (boundary and body.lstrip().startswith(b'--'))
    try:
        if looks_multipart:
            if not boundary:
                raise BadRequest('multipart 请求缺少 boundary')
            fields = {}
            for part in body.split(boundary)[1:]:
                if part.strip() in (b'', b'--'):
                    continue
                head, sep, value = part.partition(b'\r\n\r\n')
                if not sep:
                    head, sep, value = part.partition(b'\n\n')
                name = MULTIPART_NAME.search(head) or MULTIPART_NAME_BARE.search(head)
                if name is None:
                    continue
                fields[name.group(1).decode('utf-8').strip()] = _decode_form_value(
                    value.rstrip(b'\r\n').decode('utf-8'))
            return fields
        text = body.decode('utf-8')
        fields = {}
        for key, value in parse_qsl(text, keep_blank_values=True, strict_parsing=False,
                                    encoding='utf-8', errors='replace'):
            if key:
                fields[key] = value
        return fields
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
            # 客户端 addPOSTValue：session/version/resource/_l 与公告/留言都在正文。
            # 直接解析表单，禁止再拼回 URL（#、竖线、末尾 & 会让 parse_target 误报 400）。
            query = {**parse_form_body(body, content_type), **query}
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
        # 客户端 POST 常带 scene/_l、多余表单键；官方服忽略未知参数，这里只取路由声明的字段。
        params = route.parse({k: v for k, v in query.items() if k in COMMON_PARAMS or k in route.params})
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
