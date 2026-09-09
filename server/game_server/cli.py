"""命令行入口：读取 ``data/config``、组装应用、启动 HTTP 服务。

用法（在 server 目录下）::

    python -m game_server                      # 使用 data/config 中的配置
    python -m game_server --port 22000         # 临时覆盖监听端口
    python -m game_server --data-dir D:/other  # 使用另一套 data 目录

命令行参数只用于临时覆盖，正式配置请修改 ``data/config/*.json``。
"""
import argparse
from dataclasses import replace
import logging
from pathlib import Path
import sqlite3

from .app import Application
from .config import Config, load_config, validate_public_url
from .errors import ConfigError, StaticDataError
from .protocol.http_server import make_http_server

DEFAULT_DATA_DIR = Path(__file__).resolve().parents[1] / 'data'
LOG = logging.getLogger('game_server')


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description='大闹天宫HD 游戏服务端')
    parser.add_argument('--data-dir', type=Path, default=DEFAULT_DATA_DIR,
                        help='data 目录，包含 config/、static/ 与存档（默认 server/data）')
    parser.add_argument('--host', help='覆盖 server.json 的 listen.host')
    parser.add_argument('--port', type=int, help='覆盖 server.json 的 listen.port')
    parser.add_argument('--public-url', help='覆盖 server.json 的 public_url（修改端口时通常也要改它）')
    parser.add_argument('--db', type=Path, help='覆盖 SQLite 存档路径')
    return parser


def apply_overrides(config: Config, args) -> Config:
    """把命令行覆盖项合并进配置。"""
    server = config.server
    if args.host is not None or args.port is not None:
        if args.port is not None and not 1 <= args.port <= 65535:
            raise ConfigError('端口必须为 1..65535')
        listen = replace(server.listen,
                         host=args.host if args.host is not None else server.listen.host,
                         port=args.port if args.port is not None else server.listen.port)
        server = replace(server, listen=listen)
    if args.public_url is not None:
        server = replace(server, public_url=validate_public_url(args.public_url, '--public-url'))
    if args.db is not None:
        if str(args.db) == ':memory:':
            raise ConfigError('存档必须为持久化文件路径')
        server = replace(server, database=args.db)
    return replace(config, server=server)


def main(argv=None):
    parser = build_parser()
    args = parser.parse_args(argv)
    try:
        config = apply_overrides(load_config(args.data_dir), args)
    except ConfigError as exc:
        parser.exit(2, f'配置错误: {exc}\n')
    logging.basicConfig(level=config.server.logging.level, format=config.server.logging.format)
    try:
        app = Application(config)
        httpd = make_http_server(app, config.server, config.client_routes)
    except (StaticDataError, ConfigError) as exc:
        parser.exit(1, f'{exc}\n')
    except (OSError, sqlite3.Error, ValueError):
        parser.exit(1, '无法初始化服务；请检查监听地址、端口和数据库路径权限。\n')
    LOG.info('监听 %s:%s，区服「%s」(ID %s)，业务基址 %s',
             config.server.listen.host, config.server.listen.port,
             config.server.realm.name, config.server.realm.id, config.server.public_url)
    LOG.info('仅用于受信任本地测试：已实现账号、角色、背包、新手招募与首章单次结算/重放，非原服规则')
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        LOG.info('收到中断信号，停止服务')
    finally:
        httpd.server_close()


if __name__ == '__main__':
    main()
