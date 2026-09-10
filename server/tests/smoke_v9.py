"""v9 冒烟：伪充值与 VIP、月卡/点卷、成长计划、财神到、幸运转盘、采灵芝、天女散花、坊市、分享兑换码、仙魔争霸。"""
import dataclasses
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
from game_server.config import load_config, freeze, thaw  # noqa: E402
from game_server.services.clock import Clock  # noqa: E402


def main():
    config = load_config(SERVER_DIR / 'data')
    workdir = Path(tempfile.mkdtemp(prefix='gs_v9_'))
    clock = Clock(config.player.daily_reset_hour)
    clock.freeze(int(dt.datetime(2026, 9, 9, 10, 0).timestamp()))
    try:
        app = Application(config, workdir / 'v9.sqlite3', clock=clock, rng=random.Random(9))
        a = Player(app, 'dev-a', '甲', 101, 45)
        b = Player(app, 'dev-b', '乙', 112, 20)
        a.grant([{'Type': 1, 'ID': 0, 'Count': 3000000}, {'Type': 2, 'ID': 0, 'Count': 2000}])

        print('\n== 伪充值与 VIP ==')
        role = a.role()
        check('ServerVipEnable=1（主界面显示 VIP）', role['ServerVipEnable'] == 1, role['ServerVipEnable'])
        lst = a.call('/Recharge/RechargeLst')['Result']
        check('充值档位 6 档、字段齐全', len(lst) == 6 and all(k in lst[0] for k in ('ID', 'Money', 'Ingot', 'ExtreIngot')), lst[:2])
        ingot_before = a.role()['Ingot']
        body = a.call('/Recharge/GetOrderID', money='648')
        check('下单即到账：订单号 + RL 回执 + 元宝 6480+2000', body['State'] == 1 and isinstance(body['Result'], str)
              and body['Global']['Resource']['RL'][0]['Money'] == 648
              and a.role()['Ingot'] == ingot_before + 8480, body.get('Global', {}).get('Resource', {}).get('RL'))
        role = a.role()
        check('VIP 按累计充值 6480 → VIP5、NextVipExp=3520', role['VipLevel'] == 5 and role['NextVipExp'] == 3520,
              (role['VipLevel'], role['NextVipExp']))
        check('充值档位错误被拒', a.call('/Recharge/GetOrderID', money='7')['State'] == 99)
        first = a.call('/Recharge/firstreward')['Result']
        check('首充奖励列表为数组', isinstance(first, list) and first and 'Type' in first[0], first)
        check('首充红点', a.role()['Notify']['FirstRechargeShow'] == 1)
        body = a.call('/Recharge/GetFirstRechargeReward')
        check('领取首充奖励', body['State'] == 1 and body['Global']['Reward'], body)
        check('首充重复领取被拒', a.call('/Recharge/GetFirstRechargeReward')['State'] == -1131001)
        check('乙未充值领首充 -1105004', b.call('/Recharge/GetFirstRechargeReward')['State'] == -1105004)
        # 内购开关
        patched = dataclasses.replace(app.services.activities.config,
                                      recharge=freeze({**thaw(app.services.activities.config.recharge), 'enabled': False}))
        original = app.services.activities.config
        app.services.activities.config = patched
        check('开关关闭后下单被拒', a.call('/Recharge/GetOrderID', money='30')['State'] == 99
              and '内购' in a.call('/Recharge/GetOrderID', money='30')['Result'])
        app.services.activities.config = original

        print('\n== 月卡 / 点卷 ==')
        info = a.call('/Monthcard/GetMonthcardInfo')['Result']
        check('月卡信息：点卷价与点卡档位', info['MonthCardConsume'] == 30 and len(info['RechargePointInfo']) == 3
              and info['MonthCountdown'] == 0, info)
        check('点卷不足激活月卡被拒', a.call('/Monthcard/GetMonthcardReward')['State'] == 99)
        body = a.call('/Recharge/GetPointOrderID', money='30')
        check('买点卡 30 → 点卷 30', body['State'] == 1 and a.role()['Point'] == 30, a.role()['Point'])
        body = a.call('/Monthcard/GetMonthcardReward')
        check('激活月卡：扣 30 点卷、发 88 元宝', body['State'] == 1 and a.role()['Point'] == 0
              and body['Global']['Reward'][0]['Count'] == 88, body.get('Global'))
        info = a.call('/Monthcard/GetMonthcardInfo')['Result']
        check('月卡生效中、今日已领', info['MonthCountdown'] > 0 and info['HaveMonthCardTimes'] == 0, info)
        check('当日重复领取被拒', a.call('/Monthcard/GetMonthcardReward')['State'] == -1131001)
        a.call('/Recharge/GetPointOrderID', money='30')
        body = a.call('/Monthcard/GetWeekcardReward')
        check('激活周卡：扣 10 点卷、一次性发奖', body['State'] == 1 and a.role()['Point'] == 20, a.role()['Point'])
        check('周卡生效中重复购买被拒', a.call('/Monthcard/GetWeekcardReward')['State'] == -1131001)
        body = a.call('/Monthcard/ChangeIngot', point='20')
        check('点卷兑元宝 20→200', body['State'] == 1 and a.role()['Point'] == 0
              and body['Global']['Reward'][0]['Count'] == 200, body.get('Global'))

        print('\n== 成长计划 ==')
        info = a.call('/LevelGiftBag/GetGrowupInfo')['Result']
        check('成长计划未购买、8 档', info['IsBuy'] == 0 and len(info['Growup']) == 8, info)
        body = a.call('/LevelGiftBag/BuyGrowup')
        check('购买成长计划扣 500 元宝', body['State'] == 1 and body['Global']['Consume'][0]['Count'] == 500, body)
        check('重复购买 -1141004', a.call('/LevelGiftBag/BuyGrowup')['State'] == -1141004)
        check('购买后红点 Growup>0', a.role()['Notify']['Growup'] >= 1)
        body = a.call('/LevelGiftBag/GetGrowupReward', level='10')
        check('领取 10 级档 +100 元宝', body['State'] == 1 and body['Global']['Reward'][0]['Count'] == 100, body)
        check('重复领取被拒', a.call('/LevelGiftBag/GetGrowupReward', level='10')['State'] == -1131001)
        check('等级不足档被拒', a.call('/LevelGiftBag/GetGrowupReward', level='80')['State'] == 99)

        print('\n== 财神到 ==')
        rows = a.call('/FortuneKing/FortuneKingInfo')['Result']
        check('财神到列表非空、字段齐全', rows and all(k in rows[0] for k in ('id', 'type', 'state', 'endTime', 'rewards')), rows[:1])
        single = next(r for r in rows if r['id'] == 1)
        check('单笔充值 648 达标可领', single['state'] == 1, single)
        body = a.call('/FortuneKing/FortuneKingReward', ID='1')
        check('领取财神到奖励', body['State'] == 1 and body['Global']['Reward'], body)
        check('重复领取 -1131001', a.call('/FortuneKing/FortuneKingReward', ID='1')['State'] == -1131001)
        spend = next(r for r in a.call('/FortuneKing/FortuneKingInfo')['Result'] if r['id'] == 5)
        check('当日消费(元宝)达标', spend['state'] == 1, spend)

        print('\n== 幸运转盘 ==')
        info = a.call('/Luckydisk/Luckydisk')['Result']
        check('转盘 18 格、次数 80', len(info['treasuresInfo']) == 18 and info['remainSeekingTreasuresTime'] == 80, info['remainSeekingTreasuresTime'])
        for i in range(5):
            body = a.call('/Luckydisk/SeekingTreasures', index='0')
            check(f'第 {i + 1} 次探宝', body['State'] == 1 and 1 <= body['Result']['index'] <= 16
                  and 'luckydisk' in body['Result'], body.get('Result', {}).get('index'))
        info = a.call('/Luckydisk/Luckydisk')['Result']
        check('转满 5 次进入任选', info['needSeekingTreasureNumber'] == 0, info['needSeekingTreasureNumber'])
        body = a.call('/Luckydisk/SeekingTreasures', index='3')
        check('任选第 3 格', body['State'] == 1 and body['Result']['index'] == 3, body.get('Result'))
        body = a.call('/Luckydisk/Refresh')
        check('刷新奖品', body['State'] == 1 and len(body['Result']['treasuresInfo']) == 18, body['State'])
        a.edit(lambda st: st['Promo']['disk']['words'].update({'1': 1, '2': 1, '3': 1, '4': 1}))
        body = a.call('/Luckydisk/ExchangeTreasures', exchangeType='2')
        check('金玉满堂兑换', body['State'] == 1 and body['Result']['baldric2State'] == 1 and body['Result']['Reward'], body['State'])
        check('重复兑换 -1131001', a.call('/Luckydisk/ExchangeTreasures', exchangeType='2')['State'] == -1131001)

        print('\n== 采灵芝 ==')
        info = a.call('/Pickganoderma/Pickganoderma')['Result']
        check('灵芝 5 株、可服用 5 次', len(info['Ganodermas']) == 5 and info['remainEatTime'] == 5, info)
        body = a.call('/Pickganoderma/Refresh')
        check('免费刷新返回裸类型编号', body['State'] == 1 and body['Result'] in (1, 2, 3, 4, 5), body['Result'])
        body = a.call('/Pickganoderma/Call', type='5')
        check('元宝召唤灵芝王', body['State'] == 1 and body['Global']['Consume'][0]['Count'] == 100, body)
        potency = next(h for h in a.role()['ownedHeros'] if h['heroId'] == 101).get('potency', 0)
        body = a.call('/Pickganoderma/Eat', heroID='101', type='5')
        check('服用 +10 潜力', body['State'] == 1
              and next(h for h in body['Global']['Heros'] if h['heroId'] == 101)['potency'] == potency + 10, body['State'])
        check('剩余服用次数 4', a.call('/Pickganoderma/Pickganoderma')['Result']['remainEatTime'] == 4)

        print('\n== 天女散花 ==')
        info = a.call('/FairySendingFlowers/FlowersInfo')['Result']
        check('10 点不在时段内', info['remainTime'] == 0 and len(info['Times']) == 2, info)
        clock.advance(int(2.5 * 3600))  # 12:30
        info = a.call('/FairySendingFlowers/FlowersInfo')['Result']
        check('12:30 在时段内', info['remainTime'] > 0 and info['isJoin'] == 0, info)
        body = a.call('/FairySendingFlowers/Flowers', ingot='25', gold='50000', energy='20')
        rewards = {r['Type']: r['Count'] for r in body['Global']['Reward']}
        check('散花按封顶发放 20/20000/15', body['State'] == 1 and rewards[2] == 20 and rewards[1] == 20000
              and rewards[9] == 15, rewards)
        check('重复参加 -1129001', a.call('/FairySendingFlowers/Flowers', ingot='1', gold='1', energy='1')['State'] == -1129001)

        print('\n== 西游坊市 / 黑市 ==')
        rows = a.call('/exchange/list', activityid='1')['Result']
        check('坊市 5 项、字段齐全', len(rows) == 5 and all(k in rows[0] for k in ('Id', 'Reward', 'Consume', 'Remain', 'Total', 'LastSecond')), rows[:1])
        body = a.call('/exchange/do', exchangeid='101')
        check('坊市兑换发奖', body['State'] == 1 and body['Result']['Reward'], body['State'])
        check('次数递减', next(r for r in a.call('/exchange/list', activityid='1')['Result'] if r['Id'] == 101)['Remain'] == 4)
        rows = a.call('/exchange/list', activityid='2')['Result']
        check('黑市带 VipLevel', all('VipLevel' in r for r in rows), rows[:1])
        check('甲 VIP5 可兑 VIP3 项', a.call('/exchange/do', exchangeid='203')['State'] == 1)
        check('乙 VIP0 兑 VIP2 项被拒', b.call('/exchange/do', exchangeid='202')['State'] == 99)

        print('\n== 分享与兑换码 ==')
        body = a.call('/ActivityShare/complate')
        check('每日分享领奖', body['State'] == 1 and body['Result'], body)
        body = a.call('/ActivityShare/complate')
        check('重复分享 Result 为空（客户端弹已领取）', body['State'] == 1 and not body['Result'], body)
        body = a.call('/Activegift/check', code='DNTG666')
        check('兑换码发奖', body['State'] == 1 and body['Result']['Reward'], body['State'])
        check('兑换码重复使用被拒', a.call('/Activegift/check', code='DNTG666')['State'] == -1131001)
        check('无效兑换码提示', a.call('/Activegift/check', code='WRONG')['State'] == 99)

        print('\n== 仙魔争霸 ==')
        info = a.call('/Xm/WorshipInfo')['Result']
        check('休赛期：HaveTime=-1、前三展示、地道', info['HaveTime'] == -1 and len(info['WorshipRankInfo']) == 3
              and info['RankType'] == 2, {k: info[k] for k in ('HaveTime', 'RankType')})
        target = info['WorshipRankInfo'][0]['PlayerID']
        body = a.call('/Xm/Worship', beWorshipPlayerID=str(target), worshipType='1')
        check('膜拜发奖', body['State'] == 1 and body['Result']['Reward'], body['State'])
        body = a.call('/Xm/Worship', beWorshipPlayerID=str(target), worshipType='2')
        check('唾弃扣 10 元宝', body['State'] == 1 and body['Global']['Consume'][0]['Count'] == 10, body['State'])
        log = a.call('/Xm/WorshipLog', beWorshipPlayerID=str(target))['Result']
        check('膜拜记录 2 条、计数正确', len(log['WorshipLogInfo']) == 2 and log['WorshipCnt'] == 1 and log['SplitCnt'] == 1, log)
        a.call('/Xm/Worship', beWorshipPlayerID=str(target), worshipType='1')
        check('每日 3 次用完 -1131001', a.call('/Xm/Worship', beWorshipPlayerID=str(target), worshipType='1')['State'] == -1131001)
        rank = a.call('/Xm/RankInfo', type='2')['Result']
        check('排行 8 名、字段齐全', len(rank['playerInfos']) == 8
              and all(k in rank['playerInfos'][0] for k in ('playerID', 'name', 'level', 'battlePower', 'rank')), rank['playerInfos'][:1])
        check('甲在地道榜上', any(r['playerID'] == a.user for r in rank['playerInfos']))
        rewards = a.call('/Xm/RankReward', type='2')['Result']
        check('名次奖励展示', len(rewards['rankRewardInfos']) == 5, rewards)
        seed_robot = next(r['playerID'] for r in rank['playerInfos'] if r['playerID'] != a.user)
        team = a.call('/Xm/TeamInfo', rankPlayerID=str(seed_robot))['Result']
        check('查看种子阵容', team['team']['groupList'] and team['team']['battlePower'] > 0, team['team']['battlePower'])

        clock.advance(int(7 * 3600) + 15 * 60)  # 19:45 准备期
        info = a.call('/Xm/WorshipInfo')['Result']
        check('准备期倒计时', info['HaveTime'] > 0, info['HaveTime'])
        clock.advance(20 * 60)  # 20:05 比赛中
        info = a.call('/Xm/WorshipInfo')['Result']
        check('比赛中 HaveTime=0、当前轮 8 强', info['HaveTime'] == 0 and info['RankingNum'] == 8, info['RankingNum'])
        report = a.call('/Xm/BattlereportInfo', rankPlayerID='0', type='2', rankType='2')['Result']
        check('对阵树 8 场、未揭晓', len(report['battlereportInfos']) == 8
              and all(m['winnerID'] is None for m in report['battlereportInfos']), len(report['battlereportInfos']))
        quarter = next(m for m in report['battlereportInfos'] if m['rank'] == 8)
        body = a.call('/Xm/Gamble', beBetPlayerID=str(quarter['attackPlayerID']), rank='8', gold='10000')
        check('押注扣 10000 银币', body['State'] == 1 and body['Global']['Consume'][0]['Count'] == 10000, body['State'])
        check('同轮重复押注被拒', a.call('/Xm/Gamble', beBetPlayerID=str(quarter['defendPlayerID']), rank='8', gold='10000')['State'] == 99)
        battle = a.call('/Xm/BattleInfo', attackPlayerID=str(quarter['attackPlayerID']),
                        defendPlayerID=str(quarter['defendPlayerID']), type='2')['Result']
        check('对阵战报可回放', 'battleHeros' in battle and any(u['posId'] >= 7 for u in battle['battleHeros']), battle.get('isWin'))
        clock.advance(10 * 60)  # 20:15 四分之一揭晓
        report = a.call('/Xm/BattlereportInfo', rankPlayerID='0', type='2', rankType='2')['Result']
        quarters = [m for m in report['battlereportInfos'] if m['rank'] == 8]
        check('四分之一决赛已揭晓', all(m['winnerID'] for m in quarters), [m['winnerID'] for m in quarters])
        bet_row = report['gambleInfos'][0]
        if bet_row['state'] == 1:
            body = a.call('/Xm/GetGamble', beBetPlayerID=str(bet_row['beBetPlayerID']), rank='8')
            check('押中领取 2 倍返还', body['State'] == 1 and body['Global']['Reward'][0]['Count'] == 20000, body['State'])
        else:
            check('押注未中不可领', a.call('/Xm/GetGamble', beBetPlayerID=str(bet_row['beBetPlayerID']), rank='8')['State'] == 99)
        clock.advance(40 * 60)  # 20:55 决赛揭晓
        rank = a.call('/Xm/RankInfo', type='2')['Result']
        check('决出名次 1..8', sorted(r['rank'] for r in rank['playerInfos']) == list(range(1, 9)),
              sorted(r['rank'] for r in rank['playerInfos']))
        clock.advance(10 * 60)  # 21:05 赛后休赛
        info = a.call('/Xm/WorshipInfo')['Result']
        check('赛后休赛、冠军居首', info['HaveTime'] == -1
              and info['WorshipRankInfo'][0]['PlayerID'] == next(r['playerID'] for r in rank['playerInfos'] if r['rank'] == 1), info['HaveTime'])

        print('\n== Notify 红点 ==')
        notify = a.role()['Notify']
        check('活动红点字段齐备', all(k in notify for k in ('FortuneKingsShow', 'LuckydiskShow', 'PickganodermaShow',
                                                            'FairySendingFlowersShow', 'IVE', 'Growup', 'SignRewardShow',
                                                            'lgbs', 'EverydayRewardShow')), notify)
        check('IVE=1（坊市开启）', notify['IVE'] == 1)
    except Exception:
        traceback.print_exc()
        FAILED.append('异常退出')
    finally:
        shutil.rmtree(workdir, ignore_errors=True)
    print(f'\n通过 {len(PASSED)}，失败 {len(FAILED)}')
    return 1 if FAILED else 0


if __name__ == '__main__':
    sys.exit(main())
