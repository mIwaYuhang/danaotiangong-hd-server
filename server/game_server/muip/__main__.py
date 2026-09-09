"""命令行入口：``python -m game_server.muip [--data data] [--database path]``。"""
import argparse
from pathlib import Path
import sys

from ..app import Application
from ..config import load_config
from ..errors import ConfigError
from .config import MuipConfig
from .server import serve
from .service import GmService


def main(argv=None) -> int:
    parser = argparse.ArgumentParser(description='大闹天宫HD GM 服务（MUIP）')
    parser.add_argument('--data', default='data', help='数据目录（含 config/ 与 static/），默认 data')
    parser.add_argument('--database', default=None, help='SQLite 存档路径，默认取 server.json 的 database')
    args = parser.parse_args(argv)
    try:
        config = load_config(Path(args.data))
        muip = MuipConfig.load(config.config_dir)
    except ConfigError as exc:
        print(f'配置错误：{exc}', file=sys.stderr)
        return 2
    app = Application(config, Path(args.database) if args.database else None)
    gm = GmService(app, config.config_dir / 'announcement.html', muip.mail_title, muip.search_limit)
    server = serve(gm, muip)
    print(f'GM 服务已启动：http://{muip.host}:{muip.port}/  （前端目录 {muip.webui_dir}，存档 {app.storage.path}）')
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        server.server_close()
    return 0


if __name__ == '__main__':
    sys.exit(main())
