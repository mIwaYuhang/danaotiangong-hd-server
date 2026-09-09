"""业务参数规格：声明式地描述每个接口接受的查询参数。

每个规格是一个 ``Param``，``parse(raw, name)`` 把原始字符串（缺失时为 ``None``）转换为业务值；
格式问题抛 ``BadRequest``（HTTP 400）。是否满足业务规则（例如卡池类型是否开放）由业务层判断，
那类失败要给玩家看得懂的提示，因此用 ``BusinessError``。
"""
import json
import re

from ..errors import BadRequest
from .request import unique_pairs

MAX_INT64 = 9223372036854775807
#: 一般业务整数参数（关卡、章节、步骤……）的上限：十位十进制。
MAX_BUSINESS_INT = 9999999999
DECIMAL = re.compile(r'0|[1-9][0-9]{0,18}')
EMAIL = re.compile(r'[^\s@]+@[^\s@]+')
MD5_HEX = re.compile(r'[0-9a-fA-F]{32}')


def text(raw, name, max_length=256) -> str:
    """非空、不超长、不含控制字符的文本。"""
    if not isinstance(raw, str) or not raw.strip() or len(raw) > max_length:
        raise BadRequest('缺失或超长字段: ' + name)
    if any(ord(c) < 32 or ord(c) == 127 for c in raw):
        raise BadRequest('非法字段: ' + name)
    return raw


class Param:
    """参数规格基类：必填参数缺失即 400；可选参数缺失返回默认值。"""

    def __init__(self, required=True, default=None):
        self.required = required
        self.default = default

    def parse(self, raw, name):
        if raw is None:
            if self.required:
                raise BadRequest('缺失字段: ' + name)
            return self.default
        return self.convert(raw, name)

    def convert(self, raw, name):
        raise NotImplementedError


class Text(Param):
    """普通文本。"""

    def __init__(self, max_length=256, **kwargs):
        super().__init__(**kwargs)
        self.max_length = max_length

    def convert(self, raw, name):
        return text(raw, name, self.max_length)


class Raw(Param):
    """原样传递给业务层的字符串（业务层自行校验并给出玩家可读的提示）。

    客户端 ``stringBase64AndUrlEncode`` 会先 Base64（常见实现按 76 列插入换行）再 URL 编码。
    解码后中间会留下 CR/LF，这里先去掉再校验，避免公告/留言等字段被误判为非法。
    """

    def __init__(self, default=None, max_length=2048):
        super().__init__(required=False, default=default)
        self.max_length = max_length

    def convert(self, raw, name):
        if not raw:
            return raw
        cleaned = raw.replace('\r', '').replace('\n', '')
        if len(cleaned) > self.max_length:
            raise BadRequest('缺失或超长字段: ' + name)
        if any(ord(c) < 32 or ord(c) == 127 for c in cleaned):
            raise BadRequest('非法字段: ' + name)
        return cleaned


class Integer(Param):
    """非负十进制整数（不允许前导零），可指定范围。"""

    def __init__(self, minimum=0, maximum=MAX_BUSINESS_INT, **kwargs):
        super().__init__(**kwargs)
        self.minimum, self.maximum = minimum, maximum

    def convert(self, raw, name):
        value = text(raw, name, 20)
        negative = value.startswith('-') and self.minimum < 0
        digits = value[1:] if negative else value
        if not DECIMAL.fullmatch(digits):
            raise BadRequest(name + ' 必须为整数')
        number = -int(digits) if negative else int(digits)
        if not self.minimum <= number <= self.maximum:
            raise BadRequest(name + ' 超出取值范围')
        return number


class UserId(Integer):
    """正整数用户 ID（int64 范围内）。"""

    def __init__(self):
        super().__init__(minimum=1, maximum=MAX_INT64)


class Token(Param):
    """票据 / 会话令牌：``secrets.token_urlsafe`` 产出的固定长度 URL 安全 Base64。"""

    def __init__(self, length, **kwargs):
        super().__init__(**kwargs)
        self.pattern = re.compile(r'[A-Za-z0-9_-]{%d}' % length)

    def convert(self, raw, name):
        value = text(raw, name, 128)
        if not self.pattern.fullmatch(value):
            raise BadRequest('票据/会话格式无效')
        return value


class Device(Text):
    """设备标识：客户端在取不到设备号时会传字面量 nil。"""

    def convert(self, raw, name):
        value = super().convert(raw, name)
        if value.strip().lower() in ('nil', 'null', 'none'):
            raise BadRequest('设备标识不能为空或 nil')
        return value


class Email(Param):
    def convert(self, raw, name):
        value = text(raw, name, 254).strip().lower()
        if not EMAIL.fullmatch(value):
            raise BadRequest('email 格式无效')
        return value


class Md5Hex(Param):
    """客户端上送的 MD5 十六进制密码。"""

    def convert(self, raw, name):
        value = text(raw, name, 32)
        if not MD5_HEX.fullmatch(value):
            raise BadRequest('pwd 必须为客户端 MD5 十六进制字符串')
        return value


class TicketJson(Param):
    """``/Role/partner`` 的 ``userid``：客户端把 ``{"sessionId": 票据}`` 作为 JSON（不做 Base64）放进 URL。"""

    def __init__(self, token_length, **kwargs):
        super().__init__(**kwargs)
        self.token = Token(token_length)

    def convert(self, raw, name):
        encoded = text(raw, name, 2048)
        try:
            value = json.loads(encoded, object_pairs_hook=unique_pairs,
                               parse_constant=lambda _: _raise(BadRequest('非法 JSON 常量')))
            if not isinstance(value, dict) or set(value) != {'sessionId'}:
                raise BadRequest('userid 必须为包含 sessionId 的 JSON 对象')
            return self.token.parse(value['sessionId'], 'sessionId')
        except (ValueError, RecursionError) as exc:
            raise BadRequest('userid JSON 无效') from exc


def _raise(exc):
    raise exc
