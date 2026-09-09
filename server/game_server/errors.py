"""统一的异常类型。

- ``BadRequest``：请求地址或参数格式非法，由协议层转换为 HTTP 400。
- ``BusinessError``：业务规则拒绝，HTTP 200 且 ``State != 1``，客户端按 State 码提示。
  默认 State 99：客户端会把 ``Result`` 字符串直接弹窗展示，因此消息必须是面向玩家的中文。
- ``ConfigError``：配置文件缺失、格式或取值非法，启动阶段直接失败。
- ``StaticDataError``：静态表缺失、损坏或与清单不一致。
"""


class BadRequest(ValueError):
    """请求格式非法（HTTP 400）。"""


class BusinessError(Exception):
    """业务失败，携带客户端可识别的 State 码。"""

    def __init__(self, message, state=99):
        super().__init__(message)
        self.state = state


class ConfigError(ValueError):
    """配置文件不可用。"""


class StaticDataError(ValueError):
    """静态表不可用。"""
