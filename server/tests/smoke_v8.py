"""v8 冒烟：仙盟商店/魔族巢穴/留言板/仙桃、百万猎命、诸神之战。"""
import base64
import datetime as dt
import random
import shutil
import sys
import tempfile
import traceback
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from smoke_v5 import SERVER_DIR, Player, check, PASSED, FAILED  # noqa: E402
from game_server.app import Application  # noqa: E402
from game_server.config import load_config  # noqa: E402
from game_server.services.clock import Clock  # noqa: E402


def b64(text):
    return base64.b64encode(text.encode()).decode()


def main():
    config = load_config(SERVER_DIR / 'data')
    workdir = Path(tempfile.mkdtemp(prefix='gs_v8_'))
    clock = Clock(config.player.daily_reset_hour)
    # 周期按 7 天对齐到纪元：选一个处于第 1 阶段开头的时刻
    cycle_len = 7 * 86400
    base = int(dt.datetime(2026, 9, 9, 10, 0).timestamp())
    clock.freeze(base - base % cycle_len + 3600)
    try:
        app = Application(config, workdir / 'v8.sqlite3', clock=clock, rng=random.Random(8))
        a = Player(app, 'dev-a', '甲', 101, 50)
        b = Player(app, 'dev-b', '乙', 112, 45)
        a.grant([{'Type': 1, 'ID': 0, 'Count': 20000000}, {'Type': 27, 'ID': 0, 'Count': 1000}, {'Type': 2, 'ID': 0, 'Count': 5000}])
        b.grant([{'Type': 27, 'ID': 0, 'Count': 500}])
        role = a.role()
        check('功能开关下发为对象', role['FunctionOpenControllers']['IsShowZS'] == 1 and role['FunctionOpenControllers']['IsShowXunFang'] == 1, role['FunctionOpenControllers'])

        print('\n== 仙盟扩展 ==')
        union_id = a.call('/Union/CreateUnion', name=b64('天庭'))['Result']['UnionId']
        a.call('/Union/ChangeUnionApplyStatus', status='1'); b.call('/Union/UnionApply', unionId=str(union_id))
        info = a.call('/UnionStore/ZhenPinInfo')['Result']
        check('珍品 4 件、有刷新倒计时', len(info['ZhenPinLst']) == 4 and info['HaveTimes'] > 0 and info['ZhenPinLst'][0]['HaveBuyTimes'] == 1, info)
        item = info['ZhenPinLst'][0]
        coin = a.role()['UnionCoin']
        body = a.call('/UnionStore/BuyZhenPin', index=str(item['Index']))
        check('购买珍品：Result=剩余次数 0、扣晶石', body['State'] == 1 and body['Result'] == 0 and a.role()['UnionCoin'] == coin - item['Price'], body)
        check('售出后不能再买', a.call('/UnionStore/BuyZhenPin', index=str(item['Index']))['State'] != 1)
        goods = a.call('/UnionStore/FixGoodsInfo')['Result']
        check('固定商品 4 件、限购字段', len(goods) == 4 and goods[0]['HaveBuyTimes'] == 5 and goods[3]['HaveBuyTimes'] == -1, goods)
        body = a.call('/UnionStore/BuyFixGoods', index='1')
        check('购买固定商品：剩余 4', body['State'] == 1 and body['Result'] == 4, body)
        check('商店等级不足 -11430025', a.call('/UnionStore/BuyFixGoods', index='3')['State'] == -11430025)
        auctions = a.call('/UnionStore/GetUnionStoreLst')['Result']
        check('竞拍 3 件、无人出价', len(auctions) == 3 and auctions[0]['ActionPlayer'] is None and auctions[0]['AuctionPrice'] == 100, auctions)
        body = b.call('/UnionStore/Auction', id='1', price='100')
        check('乙起拍 100', body['State'] == 1 and a.call('/UnionStore/GetUnionStoreLst')['Result'][0]['ActionPlayer'] == '乙', body)
        check('低于当前价被拒', a.call('/UnionStore/Auction', id='1', price='100')['State'] != 1)
        b_coin = b.role()['UnionCoin']
        body = a.call('/UnionStore/Auction', id='1', price='150')
        check('甲加价 150、乙退回晶石', body['State'] == 1 and b.role()['UnionCoin'] == b_coin + 100, body)
        clock.advance(86400 + 1)
        a.call('/UnionStore/GetUnionStoreLst')
        check('到期结算：甲获得竞拍品、日志 304', any(l['Type'] == 304 for l in a.call('/Union/GetUnionLogList', type='0')['Result'])
              and any(o.get('ID') == 200204 for o in a.role()['Others']), a.role()['Others'][:3])

        demons = a.call('/UnionDemon/Demons')['Result']
        check('魔族列表：1 号可挑战、2 号需先打 1 号、魔王未开', demons['demonInfos'][0]['challengeStatus'] == 2 and demons['demonInfos'][1]['challengeStatus'] == 1
              and demons['demonKing']['challengeStatus'] == 0 and demons['canChallengeTime'] == 3, demons)
        detail = a.call('/UnionDemon/Demon', demonID='1', type='1')['Result']
        check('魔族详情', detail['leftHPRate'] == 100.0 and detail['remainChallengeTime'] == 3 and detail['damageRanks'] == [], detail)
        body = a.call('/UnionDemon/Challenge', demonID='1', type='1', ri='1', star='')
        check('挑战魔族返回 DemonChallenge', body['State'] == 1 and 'DemonChallenge' in body['Result'] and body['Result']['DemonChallenge']['hp'] > 0
              and body['Result']['DemonChallenge']['remainChallengeTime'] == 2, body.get('Result', {}).get('DemonChallenge', body))
        detail = a.call('/UnionDemon/Demon', demonID='1', type='1')['Result']
        check('伤害榜有甲、血量下降', detail['damageRanks'][0]['name'] == '甲' and detail['leftHPRate'] < 100, detail['damageRanks'])
        if body['Result']['DemonChallenge']['demonState'] != 0:
            body = a.call('/UnionDemon/Resurgence', demonID='1')
            check('复活续打', body['State'] == 1, body)
            body = a.call('/UnionDemon/Challenge', demonID='1', type='2', ri='1', star='')
            check('复活后 type=2 不扣次数', body['State'] == 1 and body['Result']['DemonChallenge']['remainChallengeTime'] == 2, body.get('Result', {}).get('DemonChallenge'))
        check('乙挑战 2 号被拒 -11430021', b.call('/UnionDemon/Challenge', demonID='2', type='1', ri='1', star='')['State'] == -11430021)

        body = a.call('/UnionMessageBoard/AddUnionMes', unionContent=b64('大家好'))
        check('留言：Base64 内容、IfOneself', body['State'] == 1 and base64.b64decode(body['Result']['Content']).decode() == '大家好' and body['Result']['IfOneself'] is True, body)
        board = b.call('/UnionMessageBoard/GetUnionMes')['Result']
        check('乙看到留言且 IfOneself=false', len(board) == 1 and board[0]['IfOneself'] is False and board[0]['PlayerName'] == '甲', board)

        info = a.call('/Union/XiantaoInfo')['Result']
        check('仙桃：免费 2 次', info['HaveFreeTime'] == 2 and info['Ingot'] == 20, info)
        a.call('/Union/EatXiantao'); a.call('/Union/EatXiantao')
        ingot = a.role()['Ingot']
        body = a.call('/Union/EatXiantao')
        check('第 3 次吃桃扣 20 元宝、有 Reward 与日志', body['State'] == 1 and a.role()['Ingot'] == ingot - 20 and body['Result']['Reward'] and len(body['Result']['Log']) == 3, body)

        print('\n== 百万猎命 ==')
        body = a.call('/Destiny/MillionHunt', type='1')
        check('百万猎命：扣 100 万银币、统计字段', body['State'] == 1 and body['Global']['Consume'][0]['Count'] == 1000000 and body['Result']['isGet'] == 0
              and body['Result']['green'] + body['Result']['blue'] + body['Result']['purple'] + body['Result']['orange'] == 50, body)
        check('未领取不能再猎', a.call('/Destiny/MillionHunt', type='1')['State'] != 1)
        kept = body['Result']['destiny']
        body = a.call('/Destiny/GetMillionHunt')
        check('领取：isGet=1、紫橙天命入背包', body['State'] == 1 and body['Result']['isGet'] == 1
              and len(a.call('/Destiny/PlayerDestinys')['Result']) == (len(kept.split(',')) if kept else 0), body)

        print('\n== 战三清 ==')
        # 当前冻结时刻为周期起点 +1 天 +1h；确保不是周末再测
        weekday = dt.datetime.fromtimestamp(clock.now()).weekday()
        if weekday >= 5:
            clock.advance((7 - weekday) * 86400)
        check('跑马灯', len(a.call('/Fightsanqing/RotateInfo')['Result']) >= 1)
        info = a.call('/Fightsanqing/FightsanqingInfo', type='2')['Result']
        check('魔界三座由机器人占据、我在魔界(50级)、宝箱 3 个未开', len(info['sanqings']) == 3 and info['sanqings'][0]['rank'] == 1
              and info['myType'] == 2 and [c['state'] for c in info['chests']] == [0, 0, 0], info)
        check('人界不能挑战', a.call('/Fightsanqing/Fightsanqing', type='1', rank='3', ri='1', star='')['State'] != 1)
        body = a.call('/Fightsanqing/Fightsanqing', type='2', rank='3', ri='1', star='')
        check('挑战魔界玉清返回战报', body['State'] == 1 and 'battleHeros' in body['Result'] and body['Result']['enemy']['Name'], body.get('Result', body))
        if body['Result']['isWin']:
            info = a.call('/Fightsanqing/FightsanqingInfo', type='2')['Result']
            check('胜利后占据 3 号宝座、连胜 1', info['sanqings'][2]['playerID'] == a.user and info['sanqings'][2]['continueWinTime'] == 1, info['sanqings'][2])
            check('已占座不能再挑战', a.call('/Fightsanqing/Fightsanqing', type='2', rank='1', ri='1', star='')['State'] != 1)
            logs = a.call('/Fightsanqing/Reports', sanqingPlayerID=str(a.user))['Result']
            check('战报 502 占领', logs and logs[0]['Type'] == 502 and '"G": 2' in logs[0]['Content'], logs)

        print('\n== 诸神之战 ==')
        home = a.call('/CSBattle/GetCsbattleHomeInfo')['Result']
        # 时间线：周期起点 +1h 创建；竞拍测试已推进 1 天 → 此刻为第 1 天 +1h（阶段 1：0–3 天）
        check('阶段 1 报名、三道各 8 种子、乙在人界(≤45)、甲在地界', home['CSBattleStatus'] == 1 and len(home['CsbattleRank']) == 24
              and '乙' in {s['PlayerName'] for s in home['CsbattleRank'] if s['Type'] == 1}
              and '甲' in {s['PlayerName'] for s in home['CsbattleRank'] if s['Type'] == 2}, [(s['Type'], s['PlayerName']) for s in home['CsbattleRank'][:10]])
        check('XMHaveTime 为距开战秒数', a.role()['Notify']['XMHaveTime'] > 0)
        check('阶段 1 不能竞猜', a.call('/CSBattle/Gamble', bePlayerId=str(b.user), beServerId='1', goldRolled='1', ingotRolled='0')['State'] != 1)
        clock.advance(3 * 86400)
        home = a.call('/CSBattle/GetCsbattleHomeInfo')['Result']
        check('阶段 2 竞猜、可鼓舞', home['CSBattleStatus'] == 2 and home['Encourage'][1]['IsEncouragable'] == 1, home['Encourage'])
        ginfo = a.call('/CSBattle/GetGambleHomeInfo', type='2')['Result']
        check('竞猜信息 8 位选手', ginfo['IsCanGamble'] is True and len(ginfo['CurrentGambleList']) == 8, ginfo)
        gold = a.role()['Gold']
        body = a.call('/CSBattle/Gamble', bePlayerId=str(a.user), beServerId='1', goldRolled='2', ingotRolled='1')
        check('押注自己 2 金注 1 元宝注', body['State'] == 1 and a.role()['Gold'] == gold - 2000, body)
        check('押注显示 Self', next(r for r in a.call('/CSBattle/GetGambleHomeInfo', type='2')['Result']['CurrentGambleList'] if r['PlayerId'] == str(a.user))['SelfGoldRolled'] == 2)
        body = a.call('/CSBattle/Encouraging', type='2')
        check('鼓舞：扣 100 元宝得银币、加成 1%', body['State'] == 1 and body['Result']['Reward'][0]['Count'] == 5000
              and a.call('/CSBattle/GetCsbattleHomeInfo')['Result']['Encourage'][1]['PowerAddition'] == 1, body)
        check('重复鼓舞被拒', a.call('/CSBattle/Encouraging', type='2')['State'] != 1)
        clock.advance(2 * 86400)  # 第 4 天 → 第 6 天：阶段 4 开战
        home = a.call('/CSBattle/GetCsbattleHomeInfo')['Result']
        check('阶段 4 开战、有 32 强记录、XMHaveTime=0', home['CSBattleStatus'] == 4 and home['IsTop32Exists'] == 1 and a.role()['Notify']['XMHaveTime'] == 0, home['CSBattleStatus'])
        fight = a.call('/CSBattle/GetCSbattleInfo')['Result']
        check('开战信息：我的成绩、前三、对阵日志 28 场', fight['Type'] == 2 and fight['MyCsbattleInfo'] is not None and len(fight['CsbattleRankInfo']) == 3
              and len(fight['CsbattleLogInfo']) == 28, (fight['MyCsbattleInfo'], len(fight['CsbattleLogInfo'])))
        ranks = a.call('/CSBattle/GetTopTenRankList', type='2')['Result']
        check('排行按胜场', ranks[0]['Rank'] == 1 and ranks[0]['KillCount'] >= ranks[-1]['KillCount'], ranks[:2])
        mine = a.call('/CSBattle/GetBattleReport')['Result']
        check('我的战报 7 场、可回放', len(mine) == 7 and 'battleHeros' in a.call('/CSBattle/GetBattleLog', id=mine[0]['Id'])['Result'], mine[:1])
        rewards = a.call('/CSBattle/GetRewardInfo')['Result']
        check('待领奖励含名次奖与鼓舞奖', any(r['CSBattleRewardType'] == 2 for r in rewards) and any(r['CSBattleRewardType'] == 1 for r in rewards), rewards)
        body = a.call('/CSBattle/Reward', id=str(rewards[0]['Id']))
        check('领取奖励', body['State'] == 1 and len(a.call('/CSBattle/GetRewardInfo')['Result']) == len(rewards) - 1, body)
        clock.advance(2 * 86400)  # 第 8 天：新一届
        home = a.call('/CSBattle/GetCsbattleHomeInfo')['Result']
        check('新一届重置为阶段 1', home['CSBattleStatus'] == 1 and home['IsTop32Exists'] == 0, home['CSBattleStatus'])
    except Exception:
        traceback.print_exc(); FAILED.append('未捕获异常')
    finally:
        shutil.rmtree(workdir, ignore_errors=True)
    print(f'\n通过 {len(PASSED)}，失败 {len(FAILED)}')
    if FAILED:
        print('失败项:', FAILED); sys.exit(1)


if __name__ == '__main__':
    main()
