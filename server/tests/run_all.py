"""依次运行全部冒烟脚本，输出每套的通过/失败数；任一失败则退出码非 0。

用法（在 server 目录下）::

    python -B tests/run_all.py            # 全部
    python -B tests/run_all.py v6 v8      # 只跑指定几套

各脚本内容：
    v2  账号 / 引导 / 关卡 / 招募 / 成长 / 法宝 / 邮件 / 活动 / 任务
    v3  争霸 / 妖王 / 十二元辰殿 / 通天塔 / 炼化 / 好友 / 运镖
    v4  多玩家：机器人装备、跨玩家交互
    v5  小黑屋 / 神器殿 / 宝石 / 排行榜
    v6  仙盟核心
    v7  天书洞 / 天命 / 大闹天宫 / 寻访
    v8  仙盟商店 / 魔族巢穴 / 留言板 / 仙桃 / 百万猎命 / 诸神之战 / 战三清
    v9  伪充值与 VIP / 月卡点卷 / 成长计划 / 财神到 / 幸运转盘 / 采灵芝 / 天女散花 / 坊市 / 分享 / 仙魔争霸
    muip GM 服务：登录、玩家检索与修改、发放、邮件、封禁、公告、静态页、玩家门户、一键全满
"""
import re
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent


def main(argv):
    wanted = set(argv) or None
    def order(path: Path):
        match = re.search(r'v(\d+)$', path.stem)
        return (0, int(match.group(1))) if match else (1, 0)
    scripts = sorted(HERE.glob('smoke_*.py'), key=order)
    failed = []
    for script in scripts:
        tag = script.stem.split('_')[1]
        if wanted and tag not in wanted:
            continue
        proc = subprocess.run([sys.executable, '-B', str(script)], capture_output=True, text=True, encoding='utf-8', errors='replace')
        summary = next((line for line in proc.stdout.splitlines() if line.startswith('通过')), '（无汇总输出）')
        status = 'OK ' if proc.returncode == 0 else 'BAD'
        print(f'{status} {tag}: {summary}')
        if proc.returncode != 0:
            failed.append(tag)
            print('\n'.join(line for line in (proc.stdout + proc.stderr).splitlines() if 'FAIL' in line or 'Error' in line or 'Traceback' in line)[:4000])
    if failed:
        print('失败:', ', '.join(failed))
        return 1
    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
