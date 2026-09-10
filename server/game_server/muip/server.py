"""GM 服务 HTTP 层：``/api/*`` JSON 接口 + 前端静态文件。

鉴权：除 ``POST /api/login`` 外，所有 ``/api`` 请求需带 ``Authorization: Bearer <token>``。
静态文件：``webui_dir``（Vite 构建产物），未命中的路径回退到 ``index.html`` 以支持前端路由。
"""
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
import json
import mimetypes
from pathlib import Path
import re
from urllib.parse import parse_qs, urlparse

from .config import MuipConfig
from .service import GmError, GmService

MAX_BODY = 2 * 1024 * 1024
PLAYER_ID = re.compile(r'^/api/players/(\d+)(/[a-z-]+)?$')
UNION_ID = re.compile(r'^/api/unions/(\d+)(/[a-z-]+)?$')


def make_handler(gm: GmService, config: MuipConfig):
    webui = config.webui_dir

    class Handler(BaseHTTPRequestHandler):
        server_version = 'MUIP/1.0'

        # ---- 工具 -------------------------------------------------------------

        def log_message(self, fmt, *args):  # 只记录 API 调用，静态文件不刷屏
            if self.path.startswith('/api/'):
                super().log_message(fmt, *args)

        def send_json(self, status: int, payload):
            body = json.dumps(payload, ensure_ascii=False).encode('utf-8')
            self.send_response(status)
            self.send_header('Content-Type', 'application/json; charset=utf-8')
            self.send_header('Content-Length', str(len(body)))
            self.send_header('Cache-Control', 'no-store')
            self.end_headers()
            self.wfile.write(body)

        def read_json(self):
            length = int(self.headers.get('Content-Length') or 0)
            if length > MAX_BODY:
                raise GmError('请求体过大')
            raw = self.rfile.read(length) if length else b''
            if not raw:
                return {}
            try:
                return json.loads(raw.decode('utf-8'))
            except (UnicodeDecodeError, json.JSONDecodeError):
                raise GmError('请求体必须是 UTF-8 JSON')

        def authorized(self) -> bool:
            header = self.headers.get('Authorization', '')
            return header.startswith('Bearer ') and header[7:].strip() == config.token

        # ---- 静态文件 -------------------------------------------------------------

        def serve_static(self, path: str):
            if not webui.is_dir():
                self.send_json(503, {'error': f'前端尚未构建：请在 muip-web 目录执行 npm install && npm run build（期望目录 {webui}）'})
                return
            relative = path.lstrip('/') or 'index.html'
            target = (webui / relative).resolve()
            if webui not in target.parents and target != webui or not target.is_file():
                target = webui / 'index.html'
            data = target.read_bytes()
            content_type = mimetypes.guess_type(str(target))[0] or 'application/octet-stream'
            if content_type.startswith('text/') or content_type == 'application/javascript':
                content_type += '; charset=utf-8'
            self.send_response(200)
            self.send_header('Content-Type', content_type)
            self.send_header('Content-Length', str(len(data)))
            self.send_header('Cache-Control', 'no-cache' if target.name == 'index.html' else 'public, max-age=86400')
            self.end_headers()
            self.wfile.write(data)

        # ---- 路由 -------------------------------------------------------------

        def do_GET(self):
            url = urlparse(self.path)
            if not url.path.startswith('/api/'):
                return self.serve_static(url.path)
            self.handle_api('GET', url.path, parse_qs(url.query), {})

        def do_POST(self):
            url = urlparse(self.path)
            if not url.path.startswith('/api/'):
                return self.send_json(404, {'error': 'not found'})
            try:
                body = self.read_json()
            except GmError as exc:
                return self.send_json(400, {'error': str(exc)})
            self.handle_api('POST', url.path, parse_qs(url.query), body)

        def do_PUT(self):
            self.do_POST()

        def handle_api(self, method: str, path: str, query: dict, body):
            if path.startswith('/api/portal/'):
                return self.handle_portal(method, path, query, body)
            if path == '/api/login' and method == 'POST':
                if isinstance(body, dict) and body.get('token') == config.token:
                    return self.send_json(200, {'ok': True})
                return self.send_json(401, {'error': '令牌错误'})
            if not self.authorized():
                return self.send_json(401, {'error': '未登录或令牌无效'})
            try:
                result = self.dispatch(method, path, query, body)
            except GmError as exc:
                return self.send_json(400, {'error': str(exc)})
            except Exception as exc:  # 记录并返回 500，避免 GM 服务崩溃
                self.log_error('GM 接口异常 %s %s: %r', method, path, exc)
                return self.send_json(500, {'error': f'内部错误：{exc}'})
            if result is None:
                return self.send_json(404, {'error': '接口不存在'})
            self.send_json(200, result)

        def handle_portal(self, method: str, path: str, query: dict, body):
            """玩家自助门户：/api/portal/login 开放，其余接口校验门户令牌（与 GM 令牌互不相通）。"""
            first = lambda key, default='': (query.get(key) or [default])[0]
            try:
                if path == '/api/portal/login' and method == 'POST':
                    return self.send_json(200, gm.portal_login(body))
                header = self.headers.get('Authorization', '')
                token = header[7:].strip() if header.startswith('Bearer ') else ''
                user_id = gm.portal_user(token)
                if user_id is None:
                    return self.send_json(401, {'error': '未登录或登录已过期'})
                if path == '/api/portal/me' and method == 'GET':
                    return self.send_json(200, gm.portal_me(user_id))
                if path == '/api/portal/items' and method == 'GET':
                    try:
                        item_type = int(first('type', '5'))
                    except ValueError:
                        raise GmError('type 必须是整数')
                    return self.send_json(200, {'items': gm.search_items(item_type, first('q'))})
                if path == '/api/portal/send' and method == 'POST':
                    return self.send_json(200, gm.portal_send(user_id, body.get('rewards') if isinstance(body, dict) else None))
                if path == '/api/portal/maxout' and method == 'POST':
                    return self.send_json(200, gm.portal_maxout(user_id))
            except GmError as exc:
                return self.send_json(400, {'error': str(exc)})
            except Exception as exc:
                self.log_error('门户接口异常 %s %s: %r', method, path, exc)
                return self.send_json(500, {'error': f'内部错误：{exc}'})
            return self.send_json(404, {'error': '接口不存在'})

        def dispatch(self, method: str, path: str, query: dict, body):
            first = lambda key, default='': (query.get(key) or [default])[0]
            if path == '/api/status' and method == 'GET':
                return gm.status()
            if path == '/api/players' and method == 'GET':
                return {'players': gm.search_players(first('q'))}
            match = PLAYER_ID.match(path)
            if match:
                user_id, action = int(match.group(1)), match.group(2) or ''
                if method == 'GET' and not action:
                    return gm.player_detail(user_id)
                if method in ('POST', 'PUT') and action == '/update':
                    return gm.update_player(user_id, body.get('fields') if isinstance(body, dict) else None)
                if method == 'POST' and action == '/grant':
                    return gm.grant(user_id, body.get('rewards'))
                if method == 'POST' and action == '/mail':
                    return gm.send_mail(user_id, body.get('content'), body.get('attachments'))
                if method == 'POST' and action == '/reset-daily':
                    return gm.reset_daily(user_id)
                if method == 'POST' and action == '/max-out':
                    return gm.max_out(user_id)
                if method == 'POST' and action == '/hero':
                    return gm.grant_hero(user_id, body.get('heroId') if isinstance(body, dict) else None)
                if method == 'POST' and action == '/hero-update':
                    return gm.update_hero(user_id, body)
                if method == 'POST' and action == '/progress':
                    return gm.set_progress(user_id, body.get('fields') if isinstance(body, dict) else None)
                if method == 'POST' and action == '/skip-guide':
                    return gm.skip_guide(user_id)
                if method == 'POST' and action == '/clear-mails':
                    return gm.clear_mails(user_id)
                if method == 'POST' and action == '/delete-mail':
                    return gm.delete_mail(user_id, body.get('mailId') if isinstance(body, dict) else None)
                if method == 'POST' and action == '/bag-remove':
                    return gm.remove_bag_item(user_id, body)
                if method == 'POST' and action == '/recharge':
                    return gm.credit_recharge(user_id, body.get('ingot') if isinstance(body, dict) else None)
                if method == 'POST' and action == '/month-card':
                    return gm.grant_month_card(user_id, body.get('days') if isinstance(body, dict) else None)
                if method == 'POST' and action == '/growup':
                    return gm.grant_growup(user_id)
                if method == 'POST' and action == '/leave-union':
                    return gm.leave_union(user_id)
                return None
            union_match = UNION_ID.match(path)
            if union_match:
                union_id, action = int(union_match.group(1)), union_match.group(2) or ''
                if method == 'GET' and not action:
                    return gm.union_detail(union_id)
                if method == 'POST' and action == '/update':
                    return gm.update_union(union_id, body.get('fields') if isinstance(body, dict) else None)
                if method == 'POST' and action == '/kick':
                    return gm.kick_union_member(union_id, body.get('userId') if isinstance(body, dict) else None)
                if method == 'POST' and action == '/dissolve':
                    return gm.dissolve_union(union_id)
                return None
            if path == '/api/mail/broadcast' and method == 'POST':
                return gm.broadcast_mail(body.get('content'), body.get('attachments'))
            if path == '/api/mail/many' and method == 'POST':
                return gm.mail_many(body.get('userIds'), body.get('content'), body.get('attachments'))
            if path == '/api/ranks' and method == 'GET':
                try:
                    limit = int(first('limit', '30'))
                except ValueError:
                    raise GmError('limit 必须是整数')
                return gm.arena_ranks(limit)
            if path == '/api/items' and method == 'GET':
                try:
                    item_type = int(first('type', '5'))
                except ValueError:
                    raise GmError('type 必须是整数')
                return {'items': gm.search_items(item_type, first('q'))}
            if path == '/api/unions' and method == 'GET':
                return {'unions': gm.unions()}
            if path == '/api/announcement':
                if method == 'GET':
                    return {'html': gm.get_announcement()}
                return gm.set_announcement(body.get('html') if isinstance(body, dict) else None)
            return None

    return Handler


def serve(gm: GmService, config: MuipConfig) -> ThreadingHTTPServer:
    server = ThreadingHTTPServer((config.host, config.port), make_handler(gm, config))
    server.daemon_threads = True
    return server
