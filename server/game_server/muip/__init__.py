"""MUIP：面向运营 / GM 的管理服务（Management UI Protocol）。

与游戏服共用同一份配置与 SQLite 存档，独立进程、独立端口运行::

    python -m game_server.muip --data data

组成::

    muip/
    ├── config.py    读取 data/config/muip.json（监听地址、令牌、前端目录、玩家门户配额）
    ├── service.py   GM 操作：玩家检索 / 资源与等级修改 / 发放物品 / 邮件（单发、全服）/ 封禁 / 公告 / 仙盟概览 / 静态表检索 / 一键全满
    │                玩家自助门户：游戏账号（设备号或邮箱+密码）登录，在配额内给自己发物品（走系统邮件），并可一键全满
    ├── server.py    HTTP：/api/* JSON 接口（GM Bearer 令牌）+ /api/portal/*（玩家门户令牌）+ 前端静态文件
    └── __main__.py  命令行入口

前端（server/muip-web，Vue 3 + Element Plus）：/ 为 GM 后台，/player 为玩家自助门户。
所有写操作都通过游戏服务层（账本、邮件、角色投影）完成，保证与玩家在线时的数据规则一致。
"""
