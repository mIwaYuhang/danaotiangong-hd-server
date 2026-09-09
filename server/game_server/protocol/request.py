"""请求地址解析：把 ``method`` + ``target`` 变成 ``(path, query)``，任何格式问题都抛 ``BadRequest``。

严格程度刻意高于一般 Web 服务：这是一个只面向已知客户端的本地服务，
不需要容忍畸形输入，越早拒绝越安全。
"""
import re
from urllib.parse import parse_qsl, urlsplit

from ..config import HttpConfig
from ..errors import BadRequest

INVALID_PERCENT = re.compile(r'%(?![0-9a-fA-F]{2})')


def unique_pairs(pairs) -> dict:
    """把键值对列表转成字典，重复键直接拒绝（也用于 JSON 的 ``object_pairs_hook``）。"""
    result = {}
    for key, value in pairs:
        if key in result:
            raise BadRequest('重复参数或 JSON 键')
        result[key] = value
    return result


def parse_target(target: str, limits: HttpConfig):
    """解析请求行中的目标地址。

    返回 ``(path, query)``；``query`` 是 ``{参数名: 字符串值}``。
    """
    if (not isinstance(target, str) or len(target) > limits.max_target_length
            or not target.startswith('/') or target.startswith('//')):
        raise BadRequest('请求地址无效或过长')
    if INVALID_PERCENT.search(target) or any(ord(c) < 33 for c in target):
        raise BadRequest('请求地址编码无效')
    try:
        url = urlsplit(target)
        if url.fragment:
            raise BadRequest('不支持片段')
        query = {}
        if url.query:
            query = unique_pairs(parse_qsl(url.query, keep_blank_values=True, strict_parsing=True,
                                           encoding='utf-8', errors='strict',
                                           max_num_fields=limits.max_query_fields))
        for key, value in query.items():
            if not key or len(key) > limits.max_query_key_length or len(value) > limits.max_query_value_length:
                raise BadRequest('参数过长或名称为空')
    except (ValueError, UnicodeError) as exc:
        raise BadRequest('查询参数无效') from exc
    return url.path, query
