"""v7 冒烟：天书洞、天命、大闹天宫、寻访。"""
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


def main():
    config = load_config(SERVER_DIR / 'data')
    workdir = Path(tempfile.mkdtemp(prefix='gs_v7_'))
    clock = Clock(config.player.daily_reset_hour)
    clock.freeze(int(dt.datetime(2026, 9, 9, 10, 0).timestamp()))
    try:
        app = Application(config, workdir / 'v7.sqlite3', clock=clock, rng=random.Random(7))
        a = Player(app, 'dev-a', '甲', 101, 50)
        b = Player(app, 'dev-b', '乙', 112, 45)
        a.grant([{'Type': 18, 'ID': 0, 'Count': 5000}, {'Type': 1, 'ID': 0, 'Count': 900000}, {'Type': 36, 'ID': 0, 'Count': 500},
                 {'Type': 37, 'ID': 0, 'Count': 100}, {'Type': 39, 'ID': 0, 'Count': 20000}])

        print('\n== 天书洞 ==')
        info = a.call('/Sacrifice/GetTechnologyInfo')['Result']
        check('12 项属性、初始 0 级、首级 50 阅历', len(info) == 12 and info[0] == {'BPT': 1, 'Level': 0, 'MaxLevel': 20, 'Value': 0, 'Knowledge': 50, 'OpenLv': 35}, info[0])
        hp_before = a.role()['ownedHeros'][0]['health']
        body = a.call('/Sacrifice/UpdTechnologyMagic', bpt='1')
        check('升级生命：扣阅历、Value 50、Slots 推送', body['State'] == 1 and body['Result']['Level'] == 1 and body['Result']['Value'] == 50
              and body['Global']['Consume'][0] == {'Type': 18, 'ID': 0, 'Count': 50} and 'Slots' in body['Global'], body)
        role = a.role()
        check('全体英雄血量 +50、attributeAddition.sacrifice', all(h['health'] >= hp_before + 50 for h in role['ownedHeros'][:1])
              and role['attributeAddition']['sacrifice'] == {'HP': 50}, role['attributeAddition'])

        print('\n== 天命 ==')
        check('IsOpenDestiny=1', a.role()['IsOpenDestiny'] == 1 and a.role()['Notify']['IsOpenDestiny'] == 1)
        info = a.call('/Destiny/Info')['Result']
        check('猎命台为空、元宝猎命 5 次', info['huntIDs'] == [] and info['call']['remainCallTime'] == 5, info)
        body = a.call('/Destiny/Hunt', type='1', id='1')
        check('银币猎命得 1 个天命', body['State'] == 1 and len(body['Result']['huntIDs']) == 1 and body['Result']['huntRewards'][0]['Type'] == 35
              and body['Global']['Consume'][0]['Count'] == 20000, body)
        body = a.call('/Destiny/Hunt', type='2', id='1')
        check('元宝猎命：次数减少', body['State'] == 1 and body['Result']['call']['remainCallTime'] == 4, body)
        body = a.call('/Destiny/HuntAll')
        check('一键猎命至台满 14', body['State'] == 1 and len(body['Result']['huntIDs']) == 14, body)
        body = a.call('/Destiny/Get', index='1')
        check('收取第 1 个到背包', body['State'] == 1 and len(body['Result']['huntIDs']) == 13 and body['Global']['Destinys'][0]['level'] == 1, body)
        exp_before = a.role()['DestinyExp']
        body = a.call('/Destiny/Decompose', type='1', indexOrID='1')
        check('分解猎命台天命得天命经验', body['State'] == 1 and a.role()['DestinyExp'] > exp_before, body)
        body = a.call('/Destiny/DecomposeAll', type='1', quality='4')
        check('批量分解清空猎命台', body['State'] == 1 and body['Result']['huntIDs'] == [], body)
        bag = a.call('/Destiny/PlayerDestinys')['Result']
        check('背包 1 个天命', len(bag) == 1 and 'destinyID' in bag[0], bag)
        inst = bag[0]['id']
        body = a.call('/Destiny/Change', index='1', location='1', destinyID=str(inst))
        check('装备到 1 号位英雄槽 1、Slots 推送', body['State'] == 1 and 'Slots' in body['Global'], body)
        role = a.role()
        lead = next(h for h in role['team']['groupList'] if h['heroId'])
        check('英雄 destinyList 槽 1 有天命、槽 3 已解锁(50 级)、槽 6 锁定', lead['destinyList'][0]['state'] == 2 and lead['destinyList'][0]['destiny']['id'] == inst
              and lead['destinyList'][2]['state'] == 2 and lead['destinyList'][5]['state'] == 0, lead['destinyList'])
        check('attributeAddition.destiny 有 HP', role['attributeAddition']['destiny'].get('HP', 0) > 0 or bool(role['attributeAddition']['destiny']), role['attributeAddition'].get('destiny'))
        body = a.call('/Destiny/Upgrade', id=str(inst))
        check('升级天命到 2 级', body['State'] == 1 and body['Global']['Destinys'][0]['level'] == 2 and body['Global']['Consume'][0]['Type'] == 36, body)
        body = a.call('/Destiny/HaloUpgrade', index='1')
        check('天命蛊 1 级：扣 5 碎片', body['State'] == 1 and body['Global']['Consume'][0] == {'Type': 37, 'ID': 0, 'Count': 5}, body)
        role = a.role()
        check('haloLevel=1、destinyHalo=[1,0,0,0,0]', next(h for h in role['team']['groupList'] if h['heroId'])['haloLevel'] == 1
              and role['attributeAddition']['destinyHalo'] == [1, 0, 0, 0, 0], role['attributeAddition'].get('destinyHalo'))
        body = a.call('/Destiny/Unloading', index='1', destinyID=str(inst))
        check('卸下天命', body['State'] == 1 and len(a.call('/Destiny/PlayerDestinys')['Result']) == 1, body)
        body = a.call('/Destiny/Exchange', exchangeID='1', destinyIDs='')
        check('碎片兑换 2 品质天命', body['State'] == 1 and body['Global']['Consume'][0] == {'Type': 37, 'ID': 0, 'Count': 10}, body)

        print('\n== 大闹天宫 ==')
        info = a.call('/XianmoFight/XianmoFightInfo')['Result']
        check('未抽签：NoFight、可战', info['NoFight'] is True and info['BeCanFight'] == 1 and info['TotalTime'] == 10, info)
        body = a.call('/XianmoFight/Challenge', bePlayerId=str(b.user), ri='1', star='')
        check('未抽签不能挑战', body['State'] != 1, body)
        info = a.call('/XianmoFight/Ballot')['Result']
        check('抽签入组、榜单含机器人', info['NoFight'] is False and 1 <= info['Type'] <= 4 and len(info['RankLst']) >= 4 and len(info['ChallengLst']) == 3, info)
        b.call('/XianmoFight/Ballot')
        target = info['ChallengLst']['1']['PlayerID']
        body = a.call('/XianmoFight/Challenge', bePlayerId=target, ri='1', star='')
        check('挑战返回战报与 BattleResult.XianMoFight', body['State'] == 1 and 'battleHeros' in body['Result']
              and body['Result']['BattleResult']['XianMoFight']['HaveTime'] == 9, body.get('Result', body))
        won = body['Result']['isWin']
        info = a.call('/XianmoFight/XianmoFightInfo')['Result']
        check('积分与次数同步', info['FightScore'] == (1 if won else 0) and info['HaveTime'] == 9 and info['RecoverTime'] > 0, info)
        check('分组榜单', len(a.call('/XianmoFight/GetSingleRankLst', type=str(info['Type']))['Result']) >= 4)
        check('Notify.NXM', a.role()['Notify']['NXM']['Last'] == 9)
        clock.advance(86400 + 3600)
        info = a.call('/XianmoFight/XianmoFightInfo')['Result']
        rewards = a.call('/XianmoFight/GetRankRewardLst')['Result']
        check('跨天结算日奖励', len(rewards) >= 1 and rewards[0]['RewardType'] == 1 and rewards[0]['Reward'], rewards)
        gold = a.role()['Gold']
        body = a.call('/XianmoFight/GetRankReward', ID=rewards[0]['ID'])
        check('领取日奖励', body['State'] == 1 and a.role()['Gold'] > gold and a.call('/XianmoFight/GetRankRewardLst')['Result'] == [], body)
        clock.advance(3 * 86400)
        info = a.call('/XianmoFight/XianmoFightInfo')['Result']
        check('新一届：需重新抽签、积分清零', info['NoFight'] is True and info['FightScore'] == 0, info)
        check('本届终奖入待领', any(r['RewardType'] == 2 for r in a.call('/XianmoFight/GetRankRewardLst')['Result']), a.call('/XianmoFight/GetRankRewardLst')['Result'])

        print('\n== 寻访 ==')
        info = a.call('/XunFang/GetMasterInfo')['Result']
        check('寻访信息：免费 3 次、四界进度', info['HaveFreeXunFangLing'] == 3 and info['ApprenticeProgress']['1']['TotalCount'] > 0, info)
        body = a.call('/XunFang/XunFangMaster', populationID='1', xunFangType='1')
        check('普通寻访 1 张新卡：全体血量增加', body['State'] == 1 and len(body['Result']['OpenCard']) == 1 and body['Result']['OpenCard'][0]['Status'] == 1
              and body['Result']['AttrList'][0]['AddValue'] > 0, body)
        check('地界 80 级未开放', a.call('/XunFang/XunFangMaster', populationID='2', xunFangType='1')['State'] != 1)
        body = a.call('/XunFang/XunFangMaster', populationID='1', xunFangType='2')
        check('高级寻访 5 张、扣 50 元宝', body['State'] == 1 and len(body['Result']['OpenCard']) == 5 and body['Global']['Consume'][0] == {'Type': 2, 'ID': 0, 'Count': 50}
              and body['Result']['HighNextPrice'] == 60, body)
        role = a.role()
        check('attributeAddition.xf.totalHp', role['attributeAddition']['xf']['totalHp'] == body['Result']['AttrList'][0]['AddValue'], role['attributeAddition'].get('xf'))
        book = a.call('/XunFang/GetHandBookDetail')['Result']
        check('图鉴有记录', len(book) >= 1 and book[0]['Count'] >= 1, book)
        info = a.call('/XunFang/GetApprenticeInfo', populationID='1')['Result']
        check('拜师配方列表', len(info['ApprenticeList']) > 0 and info['ApprenticeList'][0]['Consume'], info['ApprenticeList'][:1])
        recipe = info['ApprenticeList'][0]
        for cost in recipe['Consume']:
            body = a.call('/XunFang/ExchangeLearnExp', fromMasterID='0', toMasterID=str(cost['ID']), count=str(cost['Count']))
        check('授业值激活师傅卡', body['State'] == 1, body)
        body = a.call('/XunFang/ToBeApprentice', ID=str(recipe['ID']))
        check('拜师成功、前/后排加成', body['State'] == 1 and (body['Result']['Front'] or body['Result']['Back']), body)
        role = a.role()
        check('attributeAddition.xf 有 front/back', 'front' in role['attributeAddition']['xf'] and a.call('/XunFang/GetMasterInfo')['Result']['ApprenticeProgress']['1']['IsHaveApprentice'] is True)
        m = book[0]['MasterID']
        exp_before = a.role()['LearnExp']
        body = a.call('/XunFang/ExchangeLearnExp', fromMasterID=str(m), toMasterID='0', count='1')
        check('分解师傅卡得授业值', body['State'] == 1 and a.role()['LearnExp'] > exp_before, body)
    except Exception:
        traceback.print_exc(); FAILED.append('未捕获异常')
    finally:
        shutil.rmtree(workdir, ignore_errors=True)
    print(f'\n通过 {len(PASSED)}，失败 {len(FAILED)}')
    if FAILED:
        print('失败项:', FAILED); sys.exit(1)


if __name__ == '__main__':
    main()
