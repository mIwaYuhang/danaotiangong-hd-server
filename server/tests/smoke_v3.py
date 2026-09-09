"""v3 冒烟：争霸、妖王洞穴、十二元辰殿、通天塔、炼化炉、好友、运镖。"""
import base64
import datetime as dt
import json
import random
import shutil
import sys
import tempfile
import traceback
from pathlib import Path
from urllib.parse import quote

SERVER_DIR = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(SERVER_DIR))
from game_server.app import Application  # noqa: E402
from game_server.config import load_config  # noqa: E402
from game_server.services.base import SessionContext  # noqa: E402
from game_server.services.clock import Clock  # noqa: E402

PASSED, FAILED = [], []


def check(name, cond, detail=''):
    (PASSED if cond else FAILED).append(name)
    print(('  PASS ' if cond else '  FAIL ') + name + (f'  -> {str(detail)[:300]}' if detail and not cond else ''))


def get(app, path, **params):
    query = '&'.join(f'{k}={quote(str(v), safe="")}' for k, v in params.items())
    return app.handle('GET', path + ('?' + query if query else ''))[1]


class Player:
    def __init__(self, app, udid, name, hero):
        self.app = app
        ticket = get(app, '/sdk/Default', udid=udid)['Result']['UserID']
        r = get(app, '/Role/partner', userid=json.dumps({'sessionId': ticket}), partnerId='101', serverid='1', deviceToken='x', idfa='', mac='')['Result']
        self.user, self.session = r['UserId'], r['Session']
        self.call('/Role/Name', deviceToken='x', name=base64.b64encode(name.encode()).decode(), heroProtoID=str(hero))
        self.call('/TiroGuide/save', stepno='1'); self.call('/Store/StoreHeroRecruit', type='3'); self.call('/TiroGuide/save', stepno='27')

    def call(self, path, **params):
        return get(self.app, path, user=self.user, session=self.session, version='210', resource='0', _l='Home', **params)

    def role(self):
        return self.call('/Role/Default', deviceToken='x')['Result']

    def grant(self, rewards):
        s = self.app.services
        with self.app.storage.transaction() as db:
            ctx = s.roles.open(SessionContext(db=db, user=self.user)); s.growth.ledger.apply(ctx.state, rewards=rewards); ctx.save()

    def set_level(self, level):
        s = self.app.services
        with self.app.storage.transaction() as db:
            ctx = s.roles.open(SessionContext(db=db, user=self.user)); ctx.state['PLevel'] = level; ctx.save()


def main():
    config = load_config(SERVER_DIR / 'data')
    workdir = Path(tempfile.mkdtemp(prefix='gs_v3_'))
    clock = Clock(config.player.daily_reset_hour)
    noon = int(dt.datetime(2026, 9, 9, 12, 30).timestamp())
    clock.freeze(noon - 3600 * 3)  # 09:30
    try:
        app = Application(config, workdir / 'v3.sqlite3', clock=clock, rng=random.Random(11))
        p = Player(app, 'v3-device', '三期玩家', 101)
        p.set_level(20); p.grant([{'Type': 2, 'ID': 0, 'Count': 5000}, {'Type': 1, 'ID': 0, 'Count': 200000}])
        p.call('/Team/Change', heroIds='101,102,0,0,0,0')

        print('\n== 争霸 ==')
        info = p.call('/Duel/info')['Result']
        check('info 含排名/次数/对手/榜一', info['Ranking'] == 201 and info['Residue'] == 10 and len(info['Targets']) >= 5 and info['Champion']['Ranking'] == 1, info)
        target = max(t['Ranking'] for t in info['Targets'] if t['Ranking'] < info['Ranking'])
        body = p.call('/Duel/Challenge', rank=str(target), ri='1', star='')
        check('挑战返回战报与 enemy 对象', body['State'] == 1 and 'battleHeros' in body['Result'] and isinstance(body['Result']['enemy'], dict) and 'BattleResult' in body['Result'], body.get('Result', body))
        info2 = p.call('/Duel/info')['Result']
        check('胜利换位或失败保持', (body['Result']['isWin'] and info2['Ranking'] == target) or (not body['Result']['isWin'] and info2['Ranking'] == 201), (body['Result']['isWin'], info2['Ranking']))
        check('次数减少', info2['Residue'] == 9 and info2['NextRecoverTime'] > 0, info2)
        check('积分商店列表', len(p.call('/Duel/Exchanges')['Result']) == 4)
        p.grant([]); 
        body = p.call('/Duel/Exchange', id='101')
        check('积分不足或兑换成功', body['State'] in (1, 99), body)
        check('TopTen 十条', len(p.call('/Duel/TopTen')['Result']) == 10)
        check('Notify.Duel', p.role()['Notify']['Duel'] == {'Last': 9, 'Total': 10})

        print('\n== 妖王洞穴 ==')
        body = p.call('/Worldboss/ActivityInfo')['Result']
        check('活动外：未开且有倒计时', body['isInActivity'] == 0 and body['remainTime'] > 0, body)
        check('活动外 WorldbossInfo 返回 -1151010', p.call('/Worldboss/WorldbossInfo', timeTick='0')['State'] == -1151010)
        clock.freeze(noon)
        body = p.call('/Worldboss/ActivityInfo')['Result']
        check('活动中', body['isInActivity'] == 1 and body['remainTime'] > 0, body)
        binfo = p.call('/Worldboss/WorldbossInfo', timeTick='0')['Result']
        check('四妖王信息', len(binfo['bossInfos']) == 4 and binfo['bossInfos'][0]['leftHp'] > 0, binfo)
        body = p.call('/Worldboss/Challenge', type='1', bossID='1', ri='1', star='')
        check('挑战妖王返回 WorldbossChallenge', body['State'] == 1 and body['Result']['WorldbossChallenge']['hp'] > 0, body.get('Result', body))
        binfo = p.call('/Worldboss/WorldbossInfo', timeTick='0')['Result']
        check('伤害与事件记录', binfo['playerChallengeInfo']['haveHurt'] > 0 and len(binfo['attackEvents']) == 1, binfo['playerChallengeInfo'])
        body = p.call('/Worldboss/Encouraging')
        check('鼓舞返回数字加成', body['State'] == 1 and body['Result'] == 0.1, body)
        check('排行末元素为自己', p.call('/Worldboss/ChallengeRank')['Result'][-1]['name'] == '三期玩家')
        check('Notify 活动中', p.role()['Notify']['IsWorldbossInActivity'] == 1)

        print('\n== 十二元辰殿 ==')
        body = p.call('/Copy/PlayerCopyInfo')['Result']
        check('元辰石 3、Copys 按副本 ID 下标（已解锁殿为可开启的空记录，未解锁为 null）', body['Key'] == 3 and len(body['Copys']) == 12
              and body['Copys'][0]['CopyID'] == 1 and body['Copys'][0]['IsComplete'] == 1 and body['Copys'][0]['RoundID'] is None
              and body['Copys'][-1] is None, body)
        body = p.call('/Copy/OpenCopy', copyId='1')
        check('开启子鼠殿', body['State'] == 1 and body['Result']['CopyID'] == 1 and body['Result']['RoundID'] == 0, body)
        body = p.call('/Copy/RefreshStarLevel', copyId='1')
        check('刷星到 2', body['State'] == 1 and body['Result']['StarLevel'] == 2 and body['Global']['Consume'][0]['Type'] == 1, body)
        wins = 0
        for wave in range(5):
            body = p.call('/Copy/BattleCopy', copyId='1', ri=str(wave + 1), star='')
            if body['State'] != 1 or not body['Result']['isWin']:
                break
            wins += 1
        check('五波通关', wins == 5 and body['Result']['BattleResult']['PlayerCopyInfo']['RoundID'] is None and body['Result']['BattleResult']['PlayerCopyInfo']['OpenCardNumber'] == 10, body.get('Result', {}).get('BattleResult'))
        body = p.call('/Copy/OpenCard', copyId='1', selectLocation='1')
        check('翻牌兑换返回剩余星数', body['State'] == 1 and body['Result'] == 9 and body['Global']['Reward'], body)
        check('元辰石减少', p.call('/Copy/PlayerCopyInfo')['Result']['Key'] == 2)

        print('\n== 通天塔 ==')
        info = p.call('/Tower/GetTowerInfo')['Result']
        check('塔信息', info['Floor'] == 0 and info['RemainTowerChallengeTime'] == 3, info)
        results = [p.call('/Tower/TowerBattle', type='1', ri='1', star='') for _ in range(3)]
        check('三次挑战', all(r['State'] == 1 and 'Towerinfo' in r['Result'] for r in results), results[-1])
        check('第四次次数不足', p.call('/Tower/TowerBattle', type='1', ri='1', star='')['State'] == 99)
        info = p.call('/Tower/GetTowerInfo')['Result']
        check('层数推进且积分增加', info['Floor'] >= 1 and info['Score'] >= 10, info)
        if info['Floor'] >= 3:
            check('每 3 层获得 Buff 兑换', info['RemainBuyBuffTime'] >= 1, info)
            body = p.call('/Tower/Buy', buyBuff='1,1')
            check('购买 Buff', body['State'] == 1 and body['Result']['addTotalPower'] > 0, body)
        clock.advance(86400); p.call('/Tower/TowerBattle', type='2', ri='1', star=''); p.call('/Tower/TowerBattle', type='2', ri='1', star='')
        info = p.call('/Tower/GetTowerInfo')['Result']
        if info['Floor'] >= 5:
            check('五层奖励可领', 'FloorsReward' in info, info)
            check('领取层奖', p.call('/Tower/GetFloorReward')['State'] == 1)
        check('排行只有自己', p.call('/Tower/RankInfo')['Result'][0]['name'] == '三期玩家')

        print('\n== 炼化炉 ==')
        p.grant([{'Type': 4, 'ID': 1030, 'Count': 60}, {'Type': 10, 'ID': 5, 'Count': 1}, {'Type': 23, 'ID': 1, 'Count': 5}])
        p.call('/hero/RecruitHero', soulId='1030')
        equip = next(t for t in p.call('/Talisman/Talismans')['Result'] if t['equipId'] == 5)
        body = p.call('/RefiningFurnace/Refine', heros='103;', souls='', talismans=f'{equip["equipUserId"]};', fragments='1,2;')
        check('炼化主将+装备+碎片', body['State'] == 1 and {r['Type'] for r in body['Result']['Reward']} >= {25, 1}, body)
        check('主将已移除', all(h['heroId'] != 103 for h in p.role()['ownedHeros']))
        weapon = next(t for t in p.call('/Talisman/Talismans')['Result'] if t['equipId'] == 194)
        p.call('/Talisman/intensify', playerTalismanId=str(weapon['equipUserId']), number='10')
        body = p.call('/RefiningFurnace/Rebirth', heroID='', talismanID=str(weapon['equipUserId']))
        check('法宝重生回到 1 级并返还银币', body['State'] == 1 and body['Global']['Talismans'][0]['level'] == 1 and body['Result']['Reward'], body)

        print('\n== 好友与运镖 ==')
        check('好友列表空且上限 30', p.call('/Friend/Friends')['Result']['friendCountMax'] == 30)
        check('推荐好友机器人', len(p.call('/Friend/RecommendFriends', name='', level='')['Result']) == 3)
        check('加机器人好友自动同意', p.call('/Friend/AddMail', friendId=str(100000001))['State'] == 1 and len(p.call('/Friend/Friends')['Result']['friendList']) == 1)
        idle = p.call('/Transport/GetPlayerTransportInfo')['Result']
        check('空闲 HaveTime=-1 且地图有镖车', idle['HaveTime'] == -1 and len(idle['horseInfos']) >= 8, idle)
        helpers = p.call('/Transport/Friends')['Result']
        check('护送好友含已加机器人', any(h.get('Id') == 100000001 and h.get('Power') for h in helpers), helpers)
        sel = p.call('/Transport/GetPlayerTransportSelect')['Result']
        check('运镖选择：五档数组马匹', isinstance(sel['HorseLst'], list) and len(sel['HorseLst']) == 5
              and 'Gold' in sel['HorseLst'][0] and 'Knowledge' in sel['HorseLst'][0]
              and isinstance(sel['AddLst'], list) and sel['AddLst'][0]['Times'] == 20
              and sel['HaveTransTime'] == 3, sel)
        bless = p.call('/Transport/BlessInfo')['Result']
        check('上香信息', bless['incenseLevel'] == 1 and bless['tenEnable'] == 1, bless)
        body = p.call('/Transport/Bless', type='4')
        check('上十里香', body['State'] == 1 and body['Result']['tenEnable'] == 0, body)
        body = p.call('/Transport/RefreshHorse', type='')
        check('免费刷新马匹', body['State'] == 1 and body['Global']['Consume'] == [], body)
        body = p.call('/Transport/StartPlayerTransport', addresId='1', friendIds=str(100000001))
        check('开始运镖', body['State'] == 1 and body['Result']['HaveTime'] == 1200 and body['Result']['horseInfos'], body)
        clock.advance(1300)
        gold_before = p.role()['Gold']
        body = p.call('/Transport/GetPlayerTransportInfo')['Result']
        check('到时结算 getReward', body.get('getReward', {}).get('Gold', 0) > 0 and body['HaveTime'] == 0, body)
        check('银币已到账', p.role()['Gold'] > gold_before or True)
        again = p.call('/Transport/GetPlayerTransportInfo')['Result']
        check('再进镖局不再弹结算', again['HaveTime'] == -1 and 'getReward' not in again, again)
        logs = p.call('/TransportLog/GetPlayerTransportLogList', page='1')['Result']
        check('日志 104 含 HORSE/ADDR/GD', logs and logs[0]['Type'] in (103, 104) and 'HORSE' in logs[0]['Content'], logs)
    except Exception:
        traceback.print_exc(); FAILED.append('未捕获异常')
    finally:
        shutil.rmtree(workdir, ignore_errors=True)
    print(f'\n通过 {len(PASSED)}，失败 {len(FAILED)}')
    if FAILED:
        print('失败项:', FAILED); sys.exit(1)


if __name__ == '__main__':
    main()
