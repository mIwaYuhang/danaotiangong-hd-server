"""路由定义：一个接口 = 路径 + 访问级别 + 处理函数 + 业务参数规格。

访问级别：
- ``PUBLIC``   无需凭证（SDK 登录、进入区服），处理函数签名 ``handler(params)``；
- ``SESSION``  需要有效会话，角色可以不存在（建角、公告），签名 ``handler(ctx: SessionContext, params)``；
- ``ROLE``     需要有效会话且角色已存在，分发器负责加载与落库，签名 ``handler(ctx: RoleContext, params)``。
"""
from dataclasses import dataclass
from typing import Callable, Mapping, Optional

from .params import Param

PUBLIC, SESSION, ROLE = 'public', 'session', 'role'


@dataclass(frozen=True)
class Route:
    path: str
    access: str
    handler: Callable
    params: Mapping[str, Param]

    def parse(self, query: dict) -> dict:
        """按规格解析业务参数；缺失的可选参数取默认值。"""
        return {name: spec.parse(query.get(name), name) for name, spec in self.params.items()}


class Router:
    def __init__(self):
        self._routes = {}

    def add(self, access: str, path: str, handler: Callable, **params: Param) -> Route:
        if path in self._routes:
            raise ValueError(f'重复注册路由: {path}')
        route = Route(path=path, access=access, handler=handler, params=params)
        self._routes[path] = route
        return route

    def public(self, path, handler, **params):
        return self.add(PUBLIC, path, handler, **params)

    def session(self, path, handler, **params):
        return self.add(SESSION, path, handler, **params)

    def role(self, path, handler, **params):
        return self.add(ROLE, path, handler, **params)

    def match(self, path: str) -> Optional[Route]:
        return self._routes.get(path)

    def paths(self) -> frozenset:
        return frozenset(self._routes)
