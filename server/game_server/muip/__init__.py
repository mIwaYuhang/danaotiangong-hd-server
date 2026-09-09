"""MUIP：面向运营 / GM 的管理服务（Management UI Protocol）。

与游戏服共用同一份配置与 SQLite 存档，独立进程、独立端口运行::

    python -m game_server.muip --data data

组成::

    muip/
    ├── config.py    读取 data/config/muip.json（监听地址、令牌、前端目录）
    ├── service.py   GM 操作：玩家检索 / 资源与等级修改 / 发放物品 / 邮件（单发、全服）/ 封禁 / 公告 / 仙盟概览 / 静态表检索
    ├── server.py    HTTP：/api/* JSON 接口（Bearer 令牌鉴权）+ 前端静态文件（Vue 3 + Element Plus，位于 server/muip-web）
    └── __main__.py  命令行入口

所有 GM 写操作都通过游戏服务层（账本、邮件、角色投影）完成，保证与玩家在线时的数据规则一致。
"""
