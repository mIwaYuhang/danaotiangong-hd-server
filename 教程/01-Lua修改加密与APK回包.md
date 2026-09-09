# Lua 修改、加密与 APK 回包

## 适用范围与验证状态

本教程针对当前安装包 `104002_20160805165339_oem_5500058.apk`，工作目录为 `D:\cocos2d`，命令使用 Windows PowerShell。

- 引擎具有 quick-cocos2d-x / LuaJIT 特征，不使用 cc-reverse 的 Creator 工程恢复流程。
- `assets/game` 下 351 个 Lua 文件已解密和反编译；不包含目录外的 `assets/game_main.lua` 和框架包。
- 原文件是 `MQKK 标记 + XXTEA 加密的 LuaJIT 字节码`。
- 本次回包使用 `MQKK 标记 + XXTEA 加密的 Lua 源码`，没有重新编译为字节码。
- 用户已反馈修改回包后能观察到游戏请求到达主机，支持当前包的 config.lua 加密源码替换方案可行。此结论不代表所有反编译脚本都能无误执行，也不表示登录和完整游戏服务已实现。

后续教程统一存放在 `D:\cocos2d\教程`，可按 `02-主题.md`、`03-主题.md` 继续编号。

## 一、区分源码、字节码与替换文件

| 路径 | 用途 |
| --- | --- |
| `104002_20160805165339_oem_5500058.apk` | 原始 APK，保留备份，不直接覆盖 |
| `104002_20160805165339_oem_5500058/assets/game` | 原始加密脚本 |
| `lua-decrypted` | 解密后的 LuaJIT 字节码，不适合直接作为文本编辑 |
| `lua-recovered` | 反编译后的可读 Lua，在这里修改 |
| `apk-patch/assets/game/config.lua` | 已生成的第一版加密替换文件 |
| `recover_lua.py` | 目录解密及单文件加密工具 |

加密参数：

```text
sign: MQKK
key:  shenmo_moqikaka_
```

这是脚本文件的加密参数，不要自动将其当成游戏网络通信的参数。不要将含密钥和客户端资源的工作目录公开提供下载。

## 二、修改 Lua 源码

编辑：

```text
D:\cocos2d\lua-recovered\config.lua
```

当前两个本地入口为：

```lua
__OnlineServerAddr = "http://10.0.2.2:21000",
__OnlineSDKAddr = "http://10.0.2.2:21000",
```

保留表中其他字段。不要因为服务端端口是 21000，就修改 `__Version`；它是客户端版本配置，与端口无关。

三个地址来源需要分别处理：

1. `__OnlineServerAddr`：区服入口，客户端请求 `POST /ServerList.aspx`。
2. `__OnlineSDKAddr`：游戏内置账号接口，例如 `/sdk/Default`、`/sdk/login`；不是百度原生 SDK 地址。
3. 区服响应中的 `ServerUrl`：后续登录、角色、战斗等业务基址，也应由本地服务返回 `http://10.0.2.2:21000`。

基础地址不要带末尾斜杠，因为接口路径已经以 `/` 开头。修改地址不会自动关闭百度渠道登录分支。

每次只改必要脚本，尽量保持原变量、字段大小写和逻辑不变。不要为了方便把全部 351 个反编译文件都覆盖回包。

## 三、加密修改后的文件

在 PowerShell 执行以下命令。使用绝对路径，不依赖终端当前目录：

```powershell
python -B "D:\cocos2d\recover_lua.py" "D:\cocos2d\lua-recovered\config.lua" "D:\cocos2d\apk-patch-v2\assets\game\config.lua" --encrypt --sign MQKK --key shenmo_moqikaka_
```

说明：

- `--encrypt` 表示加密单个文件，不自动编译 Lua。
- 输入是可读源码，输出是带 MQKK 标记的加密文件，扩展名仍为 `.lua`。
- 输出父目录会自动创建。
- 输出文件必须不存在，脚本拒绝覆盖；重复操作时使用 `apk-patch-v3` 等新目录，或确认不再需要旧生成文件后自行删除它。
- 脚本会进行加密后解密的往返校验，成功输出包含 `roundtrip_verified: true`。
- 原始源码、原始加密文件和 APK 不会被这个命令修改。

现有第一版 `apk-patch/assets/game/config.lua` 为 940 字节。后续修改内容后大小变化是正常的，不能用文件大小判断是否成功。

### 已完成的算法验证

原始 config 字节码重新加密后，与原包加密 config 逐字节一致；第一版修改源码加密后重新解密，也与输入完全一致。往返验证证明加密和封装正确，但不保证 Lua 逻辑正确。

### 修改其他脚本

例如修改 `lua-recovered/base/network.lua` 后，可执行：

```powershell
python -B "D:\cocos2d\recover_lua.py" "D:\cocos2d\lua-recovered\base\network.lua" "D:\cocos2d\apk-patch-v2\assets\game\base\network.lua" --encrypt --sign MQKK --key shenmo_moqikaka_
```

这只是命令示例，本教程没有实施该脚本修改。其余文件保持原包内容。

## 四、用压缩工具替换 APK 内文件

1. 复制原始 APK，例如命名为 `game-local-unsigned.apk`，仅操作副本。
2. 用压缩工具打开 APK 副本，进入 `assets/game/`。
3. 将本轮输出的加密 `config.lua` 替换进去。若执行了上述命令，应使用 `apk-patch-v2/assets/game/config.lua`，而不是上一版文件。
4. 确认最终 APK 内路径为 `assets/game/config.lua`，且同一路径只有一个条目。
5. 不要误放成 `apk-patch-v2/assets/game/config.lua`，不要替换成 `lua-recovered` 下的明文，也不要用 `lua-decrypted` 下的原字节码。
6. 保存并关闭压缩工具，避免文件尚未保存就开始签名。

仅替换 assets 不需要先把全部 Android 资源反编译再构建。保持原 APK 结构，不要通过随意解压、全量重压缩来改变无关内容。

## 五、使用 MT 管理器签名并安装

1. 将修改后的 APK 交给 MT 管理器。
2. 使用 APK 签名功能，重新签名并生成安装包；不要仅保留或复制旧签名。
3. 后续版本持续使用同一份本地签名密钥，便于覆盖升级。妥善保管密钥和密码。
4. 如果工具提供 ZIP 对齐，采用先对齐、后签名的流程，或使用工具内置的正确集成流程。
5. 安装签名后的输出 APK，而不是未签名的中间包。
6. 签名完成后不要再次修改 APK；如有修改，必须重新签名。

官方签名与本地签名不同，通常不能直接覆盖安装官方原版。建议使用独立测试模拟器；如果必须卸载原版，先备份数据，卸载可能删除内部存档。重新签名还可能影响渠道 SDK 校验，这不等于 Lua 加密失败。

## 六、验证游戏请求是否到达电脑

### 1. 启动临时 HTTP 监听

在一个空目录打开 PowerShell，手动执行：

```powershell
python -m http.server 21000 --bind 0.0.0.0
```

保持终端打开。这个服务会暴露当前目录，因此不要在含 APK、密钥或其他私密文件的目录运行，不要开放到公网。防火墙只允许必要的受信任网络访问。测试完成后按 `Ctrl+C` 停止。

如端口已占用，先确认是否已有正式服务运行，不要随意结束未知进程。临时服务与正式服务不能同时监听相同地址和端口。

### 2. 验证模拟器网络

在模拟器浏览器访问：

```text
http://10.0.2.2:21000/probe-from-emulator
```

电脑出现以下类型日志，就说明模拟器能够访问主机：

```text
"GET /probe-from-emulator HTTP/1.1" 404 -
```

404 只是因为没有这个文件，不代表连接失败。`10.0.2.2` 通常适用于 Android 官方模拟器，其他模拟器需要核实宿主机地址；真机不能照搬。

### 3. 验证游戏配置生效

强制停止并重新打开修改版游戏，进入选服界面，必要时点击区服入口触发请求。终端出现：

```text
code 501, message Unsupported method ('POST')
"POST /ServerList.aspx HTTP/1.1" 501 -
```

说明游戏的区服请求已到主机。501 是临时服务器不支持 POST，不是重定向失败。

| 观察结果 | 能证明什么 |
| --- | --- |
| `Serving HTTP...` | 主机监听已启动 |
| 浏览器产生 `GET /probe-from-emulator` | 模拟器到主机可达 |
| 游戏产生 `POST /ServerList.aspx` | 当前区服请求已重定向到主机 |
| 返回 200 | 仅说明 HTTP 状态成功，不保证客户端协议正确 |
| 游戏显示本地区服 | 区服响应基本可被客户端使用 |
| 能登录进入角色界面 | 登录及角色初始化进一步跑通 |

原客户端的区服响应处理默认执行 zlib 解压后再解析 JSON，不能简单把普通 JSON 和 HTTP 200 当作接口已实现。真实 Python 服务还需返回正确的成功码、区服字段和响应编码。

## 七、常见问题

### 能安装，但启动报错或闪退

先收集 logcat，确认是 Lua 语法/加载错误、原生错误还是签名/SDK问题。当前 config 已有用户反馈的请求验证，但复杂反编译脚本仍可能存在语义误差。若某条加载链确实只接受字节码，再使用兼容原运行时的 LuaJIT 编译工具，不能用标准 luac 或任意不匹配版本代替。

### 模拟器浏览器能连，游戏没有日志

检查是否安装了正确的签名输出包、APK 内路径是否正确、是否使用本轮生成文件。检查区服缓存和热更新脚本覆盖的可能性，并确认代码执行到了请求。涉及清理缓存或数据时先备份。

### 有请求，但界面仍没有区服

临时 HTTP 服务不会提供真实区服。需要实现 `/ServerList.aspx` 的压缩、成功码和数据结构；区服中的 `ServerUrl` 也要指向本地。

### 区服正常，但仍弹不出百度登录

地址修改不等于 SDK 登录替换。需另外分析或改为本地账号流程，并实现 UserId、Session 和玩家初始化数据。本教程不包含这些服务端功能。

## 每轮修改检查清单

- [ ] 保留原 APK、原脚本和本地签名密钥。
- [ ] 只编辑 `lua-recovered` 内需要改的源码。
- [ ] 使用 `--encrypt` 生成新的加密输出，确认往返校验成功。
- [ ] 替换 APK 内正确路径，确认使用的是本轮生成文件。
- [ ] 完成保存后重新签名，安装签名输出包。
- [ ] 观察实际请求或 logcat，而不只看安装成功。
- [ ] 记录本轮改动和验证结果，区分请求到达、接口正确与游戏可玩。
