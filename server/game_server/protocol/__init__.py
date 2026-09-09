"""协议层：把客户端的 HTTP 请求翻译成业务调用，再把业务结果封装为客户端协议。

- ``request``      请求地址与查询参数的严格解析
- ``params``       业务参数规格（文本、整数、令牌、邮箱……）
- ``router``       路由定义：路径 → 处理函数 + 访问级别 + 参数规格
- ``routes``       路由表：已实现的全部接口一览
- ``dispatcher``   分发器：鉴权、事务、角色加载与落库、响应封装
- ``http_server``  有界线程 HTTP 服务与脱敏日志

客户端协议摘要（``base/network.lua``）：
- 区服列表 ``POST /ServerList.aspx``：zlib 压缩的 ``{Code, Message, Data}``；
- 其余接口均为 GET，响应 ``{State, Result[, Global]}``，``State == 1`` 成功；
- ``State == 99`` 时客户端把 ``Result`` 字符串弹窗展示。
"""
