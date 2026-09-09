"""有界线程 HTTP 传输层。

设计要点：
- 并发工作线程数受 ``BoundedSemaphore`` 限制，超出直接断开，避免线程爆炸；
- 每个请求有连接空闲超时与绝对截止时间（应对慢速滴流攻击）；
- 请求体大小、Content-Length 格式、Transfer-Encoding 都做硬性校验；
- 日志绝不记录原始请求行、异常文本或回溯：请求地址与参数中可能包含凭证。
  路径只在命中 ``client_routes.json`` 时明文记录；参数只在白名单内且为纯数字时记录。
- 所有响应都带 ``Connection: close``，客户端每次请求都是短连接。
"""
import json
import logging
from pathlib import Path
import re
import socket
import sqlite3
import threading
import time
import uuid
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from urllib.parse import parse_qsl

from ..config import ServerConfig
from ..errors import BadRequest

LOG = logging.getLogger('game_server.http')
KNOWN_METHODS = frozenset(('GET', 'POST', 'HEAD', 'PUT', 'DELETE', 'OPTIONS', 'PATCH'))
CONTENT_LENGTH = re.compile(r'[0-9]{1,10}')
NUMERIC = re.compile(r'[0-9]{1,19}')


def safe_request_context(method, target, known_paths, plain_keys, max_fields, max_target_length):
    """把请求摘要成可安全写日志的三元组 ``(method, path, query)``。"""
    path, _, query = target.partition('?')
    summary = {}
    try:
        if len(query) > max_target_length:
            raise ValueError()
        for key, value in parse_qsl(query, keep_blank_values=True, max_num_fields=max_fields,
                                    encoding='utf-8', errors='strict'):
            if key in plain_keys:
                summary[key] = value if NUMERIC.fullmatch(value) and int(value) <= 9223372036854775807 else '[redacted]'
            else:
                summary['other'] = '[redacted]'
    except (ValueError, UnicodeError):
        summary = {'query': '[invalid]'}
    return (method if method in KNOWN_METHODS else '[invalid]',
            path if path in known_paths else '[unknown]', summary)


def exception_location(exc) -> str:
    """只记录异常类型与源码位置，不记录异常消息（可能内嵌凭证）。"""
    tb = exc.__traceback__
    while tb and tb.tb_next:
        tb = tb.tb_next
    filename = Path(tb.tb_frame.f_code.co_filename).name if tb else 'unknown'
    filename = re.sub(r'[^A-Za-z0-9_.-]', '_', filename)[:80]
    kind = re.sub(r'[^A-Za-z0-9_]', '_', type(exc).__name__)[:80]
    return f'{kind}@{filename}:{tb.tb_lineno if tb else 0}'


class BoundedHTTPServer(ThreadingHTTPServer):
    """限制并发工作线程数的多线程 HTTP 服务；``server_close`` 会等待工作线程结束。"""
    daemon_threads = False
    block_on_close = True

    def __init__(self, address, handler, max_workers):
        if max_workers < 1:
            raise ValueError('max_workers 必须为正整数')
        self.slots = threading.BoundedSemaphore(max_workers)
        super().__init__(address, handler)

    def process_request(self, request, client_address):
        if not self.slots.acquire(blocking=False):
            self.shutdown_request(request)
            return
        try:
            super().process_request(request, client_address)
        except BaseException:
            self.slots.release()
            raise

    def process_request_thread(self, request, client_address):
        try:
            super().process_request_thread(request, client_address)
        finally:
            self.slots.release()

    def handle_error(self, request, client_address):
        LOG.error('HTTP 工作线程异常')


def make_http_server(application, config: ServerConfig, known_paths) -> BoundedHTTPServer:
    """创建 HTTP 服务；``application.handle(method, target)`` 返回 ``(状态码, 响应体, Content-Type)``。"""
    http = config.http
    timeout = http.request_timeout
    plain_keys = config.logging.plain_query_keys

    class Handler(BaseHTTPRequestHandler):
        server_version = http.server_header

        def version_string(self):
            # 不暴露 Python 版本，只返回配置中的 Server 头。
            return self.server_version

        def setup(self):
            super().setup()
            self.connection.settimeout(timeout)
            # 请求行解析失败时基类不会初始化这些字段，先给默认值。
            self.command = None
            self.requestline = ''
            self.request_version = 'HTTP/1.0'

        def handle_one_request(self):
            self.request_id = uuid.uuid4().hex[:16]
            self.started = time.monotonic()
            self.status = '-'
            self.business_state = '-'
            self.response_size = 0
            self.failure = '-'
            self.path = ''

            def expire():
                try:
                    self.connection.shutdown(socket.SHUT_RDWR)
                except OSError:
                    pass

            deadline = threading.Timer(timeout, expire)
            deadline.daemon = True
            deadline.start()
            try:
                super().handle_one_request()
            except (OSError, ConnectionError):
                pass
            finally:
                deadline.cancel()
                if self.status != '-' or self.requestline:
                    self._log_summary()

        def _log_summary(self):
            words = self.requestline.split()
            target = self.path or (words[1] if len(words) >= 2 else '')
            method, path, query = safe_request_context(
                self.command or (words[0] if words else ''), target,
                known_paths, plain_keys, http.max_query_fields, http.max_target_length)
            LOG.info('HTTP id=%s method=%s path=%s query=%s status=%s State=%s elapsed_ms=%.2f bytes=%s error=%s',
                     self.request_id, method, path, json.dumps(query, sort_keys=True),
                     self.status, self.business_state,
                     (time.monotonic() - self.started) * 1000, self.response_size, self.failure)

        def log_message(self, fmt, *args):
            # 基类日志会输出原始请求行，统一改为 handle_one_request 结束时的脱敏摘要。
            pass

        def reply(self, status, data, content_type=None):
            body = data if content_type else json.dumps(data, ensure_ascii=False).encode('utf-8')
            self.status = int(status)
            self.response_size = len(body)
            if isinstance(data, dict) and type(data.get('State')) is int:
                self.business_state = data['State']
            self.send_response(status)
            self.send_header('X-Request-ID', self.request_id)
            self.send_header('Content-Type', content_type or 'application/json; charset=utf-8')
            self.send_header('Content-Length', str(len(body)))
            self.send_header('Cache-Control', 'no-store')
            self.send_header('Connection', 'close')
            self.end_headers()
            self.close_connection = True
            # 区服列表由客户端显式 inflate，不能声明 Content-Encoding。
            self.wfile.write(body)

        def send_error(self, code, message=None, explain=None):
            # 畸形请求行可能让基类退回 HTTP/0.9（无状态行），强制回到 HTTP/1.0。
            if self.request_version == 'HTTP/0.9':
                self.request_version = 'HTTP/1.0'
            self.reply(code, {'error': 'invalid_http_request'})

        def dispatch(self):
            try:
                if self.headers.get_all('Transfer-Encoding'):
                    self.reply(400, {'error': 'transfer_encoding_not_supported'})
                    return
                lengths = self.headers.get_all('Content-Length', [])
                if len(lengths) > 1 or (lengths and not CONTENT_LENGTH.fullmatch(lengths[0])):
                    self.reply(400, {'error': 'invalid_content_length'})
                    return
                length = int(lengths[0]) if lengths else 0
                if length > http.max_body_bytes:
                    self.reply(413, {'error': 'request_too_large'})
                    return
                body = self.rfile.read(length)
                if len(body) != length:
                    self.reply(400, {'error': 'incomplete_request'})
                    return
                try:
                    status, data, content_type = application.handle(self.command, self.path, body)
                    if isinstance(data, dict) and type(data.get('State')) is int:
                        self.business_state = data['State']
                    if not content_type:
                        data = json.dumps(data, ensure_ascii=False).encode('utf-8')
                        content_type = 'application/json; charset=utf-8'
                except (BadRequest, sqlite3.Error):
                    raise
                except Exception as exc:  # 业务层未预期的异常：只记录位置，不泄露内容
                    self.failure = exception_location(exc)
                    self.reply(500, {'error': 'internal_server_error'})
                    return
                self.reply(status, data, content_type)
            except BadRequest as exc:
                self.failure = exception_location(exc)
                self.reply(400, {'State': 99, 'Result': '请求参数格式无效'})
            except socket.timeout:
                self.reply(408, {'error': 'request_timeout'})
            except sqlite3.Error as exc:
                self.failure = exception_location(exc)
                self.reply(503, {'State': 99, 'Result': '本地存储暂不可用'})

        def do_GET(self):
            self.safe_dispatch()

        def do_POST(self):
            self.safe_dispatch()

        def safe_dispatch(self):
            try:
                self.dispatch()
            except (OSError, ConnectionError):
                pass

    return BoundedHTTPServer((config.listen.host, config.listen.port), Handler, http.max_workers)
