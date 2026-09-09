"""GM 服务配置：``data/config/muip.json``。"""
from dataclasses import dataclass
import json
from pathlib import Path

from ..errors import ConfigError


@dataclass(frozen=True)
class MuipConfig:
    host: str
    port: int
    token: str
    webui_dir: Path
    search_limit: int
    mail_title: str

    @classmethod
    def load(cls, config_dir: Path) -> 'MuipConfig':
        path = Path(config_dir) / 'muip.json'
        try:
            raw = json.loads(path.read_text(encoding='utf-8'))
        except FileNotFoundError:
            raise ConfigError(f'缺少 GM 配置文件 {path}')
        except json.JSONDecodeError as exc:
            raise ConfigError(f'{path} 不是合法 JSON：{exc}')
        listen = raw.get('listen') or {}
        token = raw.get('token')
        if not isinstance(token, str) or len(token) < 8:
            raise ConfigError('muip.json.token 必须是至少 8 个字符的字符串')
        if not isinstance(listen.get('host'), str) or type(listen.get('port')) is not int:
            raise ConfigError('muip.json.listen 需要 host 字符串与 port 整数')
        return cls(host=listen['host'], port=listen['port'], token=token,
                   webui_dir=(path.parent / raw.get('webui_dir', '../../muip-web/dist')).resolve(),
                   search_limit=int(raw.get('search_limit', 50)), mail_title=str(raw.get('mail_title', '运营团队')))
