"""业务处理函数共用的上下文与回复类型。"""
from dataclasses import dataclass, field
import json
from typing import Any, Optional


@dataclass
class Reply:
    """带可选 ``Global`` 段的业务回复。

    客户端 ``network.lua`` 在 ``State == 1`` 时：
    - 若存在 ``Global``，先用其中的 ``Resource/Slots/Heros/Reward/Consume`` 更新玩家数据；
    - 再把 ``Result`` 交给请求对象的 ``parseJsonValue``。
    """
    result: Any = None
    global_: Optional[dict] = None

    def envelope(self) -> dict:
        body = {'State': 1, 'Result': self.result}
        if self.global_ is not None:
            body['Global'] = self.global_
        return body


def as_reply(value) -> Reply:
    """处理函数可以直接返回普通值，这里统一包装为 ``Reply``。"""
    return value if isinstance(value, Reply) else Reply(value)


def global_block(resource=None, reward=(), consume=(), **extra) -> dict:
    """构造 ``Global`` 段；``Reward/Consume`` 总是存在，客户端会无条件读取。"""
    block = {'Reward': list(reward), 'Consume': list(consume)}
    if resource is not None:
        block['Resource'] = resource
    block.update(extra)
    return block


@dataclass
class SessionContext:
    """已通过会话校验、位于写事务中的请求上下文。"""
    db: Any
    user: int


@dataclass
class RoleContext(SessionContext):
    """在会话上下文之上加载了角色的请求上下文。

    ``state`` 是已完成迁移的可变角色状态；处理函数直接修改它，
    分发器在处理函数返回后调用 ``save()`` 落库，因此无需手动写库。
    """
    row: Any = None
    state: dict = field(default_factory=dict)

    @property
    def hero_id(self) -> int:
        """建角时选择的初始英雄。"""
        return self.row['hero_id']

    def save(self):
        self.db.execute('UPDATE roles SET state_json = ? WHERE user_id = ?',
                        (json.dumps(self.state, ensure_ascii=False), self.user))
