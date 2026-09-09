"""v4 冒烟：多玩家——阵容互看、争霸真实对手换位、好友申请/同意/赠送、玩家邮件、劫镖、妖王共享血量。"""
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
from game_server.services.players import ROBOT_BASE  # noqa: E402

PASSED, FAILED = [], []


def check(name, cond, detail=''):
    (PASSED if cond else FAILED).append(name)
    print(('  PASS ' if cond else '  FAIL ') + name + (f'  -> {str(detail)[:300]}' if detail and not cond else ''))


def get(app, path, **params):
    query = '&'.join(f'{k}={quote(str(v), safe="")}' for k, v in params.items())
    return app.handle('GET', path + ('?' + query if query else ''))[1]


class Player:
    def __init__(self, app, udid, name, hero, level):
        self.app = app
        ticket = get(app, '/sdk/Default', udid=udid)['Result']['UserID']
        r = get(app, '/Role/partner', userid=json.dumps({'sessionId': ticket}), partnerId='101', serverid='1', deviceToken='x', idfa='', mac='')['Result']
        self.user, self.session = r['UserId'], r['Session']
        self.call('/Role/Name', deviceToken='x', name=base64.b64encode(name.encode()).decode(), heroProtoID=str(hero))
        self.call('/TiroGuide/save', stepno='1'); self.call('/Store/StoreHeroRecruit', type='3'); self.call('/TiroGuide/save', stepno='27')
        s = app.services
        with app.storage.transaction() as db:
            ctx = s.roles.open(SessionContext(db=db, user=self.user)); ctx.state['PLevel'] = level
            s.growth.ledger.apply(ctx.state, rewards=[{'Type': 30, 'ID': 0, 'Count': 500000}, {'Type': 2, 'ID': 0, 'Count': 2000}]); ctx.save()
        for hid in (h['heroId'] for h in self.role()['ownedHeros']):
            self.call('/Prop/HeroUpdLevel', heroId=str(hid), addLv='-1')
        self.call('/Team/Change', heroIds=','.join(str(h['heroId']) for h in self.role()['ownedHeros']) + ',0,0,0,0')

    def call(self, path, **params):
        return get(self.app, path, user=self.user, session=self.session, version='210', resource='0', _l='Home', **params)

    def role(self):
        return self.call('/Role/Default', deviceToken='x')['Result']


def main():
    config = load_config(SERVER_DIR / 'data')
    workdir = Path(tempfile.mkdtemp(prefix='gs_v4_'))
    clock = Clock(config.player.daily_reset_hour)
    clock.freeze(int(dt.datetime(2026, 9, 9, 12, 30).timestamp()))
    try:
        app = Application(config, workdir / 'v4.sqlite3', clock=clock, rng=random.Random(21))
        a = Player(app, 'dev-a', '甲', 101, 30)
        b = Player(app, 'dev-b', '乙', 112, 12)
        check('区服名与系统邮件署名已更名', config.server.realm.name == '一区·黑风山' and a.role()['SystemMailName'] == '大闹天宫HD运营团队')

        print('\n== 阵容互看 ==')
        team = a.call('/Team/TeamNew', playerid=str(b.user))
        check('甲可查看乙的阵容', team['State'] == 1 and team['Result']['team']['groupList'][0]['heroId'] == 112 and team['Result']['team']['battlePower'] > 0, team)
        robot = a.call('/Team/TeamNew', playerid=str(ROBOT_BASE + 5))
        heroes = robot['Result']['team']['groupList']
        check('可查看机器人阵容', robot['State'] == 1 and heroes, robot)
        equips = app.catalog['BaseEquips']
        weapons_ok = all(any(equips[str(e['equipId'])]['equipType'] == 1 and equips[str(e['equipId'])]['profession'] in (4, app.catalog['BaseHeros'][str(h['heroId'])]['profession'])
                             for e in h['equipList']) for h in heroes)
        check('机器人英雄有整套法宝且武器匹配职业', all(len(h['equipList']) == 6 and h['equipList'][0]['level'] > 1 for h in heroes) and weapons_ok,
              [(h['heroId'], [(e['equipId'], e['level']) for e in h['equipList']]) for h in heroes])
        check('机器人法宝为已穿戴状态且计入战力', all(e['isInTeam'] == 1 and e['heroId'] == h['heroId'] for h in heroes for e in h['equipList']) and heroes[0]['battlePower'] > 0)

        print('\n== 争霸：真实对手 ==')
        ia, ib = a.call('/Duel/info')['Result'], b.call('/Duel/info')['Result']
        check('甲乙依次排在机器人之后', ia['Ranking'] == 201 and ib['Ranking'] == 202, (ia['Ranking'], ib['Ranking']))
        check('乙的对手列表包含甲', any(t['PlayerId'] == str(a.user) and t['Ranking'] == 201 for t in ib['Targets']), ib['Targets'])
        body = b.call('/Duel/Challenge', rank='201', ri='1', star='')
        check('乙挑战甲：战报 enemy 为甲', body['State'] == 1 and body['Result']['enemy']['Name'] == '甲', body.get('Result', body))
        ra, rb = a.call('/Duel/info')['Result']['Ranking'], b.call('/Duel/info')['Result']['Ranking']
        won = body['Result']['isWin']
        check('胜利则互换名次，失败则不变', (won and (ra, rb) == (202, 201)) or (not won and (ra, rb) == (201, 202)), (won, ra, rb))
        body = a.call('/Duel/Challenge', rank='195', ri='1', star='')
        check('甲挑战机器人名次', body['State'] == 1 and (not body['Result']['isWin'] or a.call('/Duel/info')['Result']['Ranking'] == 195), body.get('Result', body))

        print('\n== 好友 ==')
        rec = a.call('/Friend/RecommendFriends', name='', level='')['Result']
        check('推荐列表包含乙且机器人补位', any(r['userId'] == b.user for r in rec) and len(rec) >= 4, rec)
        check('甲申请加乙', a.call('/Friend/AddMail', friendId=str(b.user), message='你好')['State'] == 1)
        reqs = b.call('/Friend/RequestFriends')['Result']
        check('乙收到申请且红点为 1', len(reqs) == 1 and reqs[0]['userId'] == a.user and b.role()['Notify']['Friend'] == 1, reqs)
        check('乙同意', b.call('/Friend/Add', friendId=str(a.user))['State'] == 1)
        fa, fb = a.call('/Friend/Friends')['Result'], b.call('/Friend/Friends')['Result']
        check('双方互为好友', [f['userId'] for f in fa['friendList']] == [b.user] and [f['userId'] for f in fb['friendList']] == [a.user], (fa, fb))
        check('甲赠送体力', a.call('/Friend/Present', frinendID=str(b.user))['State'] == 1)
        check('重复赠送被拒', a.call('/Friend/Present', frinendID=str(b.user))['State'] == 99)
        presents = b.call('/Friend/PresentsInfo')['Result']
        check('乙看到 1 份体力', len(presents['presents']) == 1 and presents['presents'][0]['userId'] == a.user, presents)
        energy = b.role()['Energy']
        body = b.call('/Friend/GetAllBackPresent')
        check('一键领取 +2 体力', body['State'] == 1 and body['Global']['Resource']['Energy'] == energy + 2, body)
        check('甲给乙发站内信', a.call('/Friend/SendMail', friendId=str(b.user), message='一起打副本')['State'] == 1)
        mails = b.call('/Mailinfo/GetMailinfoList', index='1', type='3')['Result']['MailList']
        check('乙收到好友邮件', len(mails) == 1 and mails[0]['MessageContent'] == '一起打副本', mails)
        check('机器人好友申请自动同意', a.call('/Friend/AddMail', friendId=str(ROBOT_BASE + 1))['State'] == 1 and len(a.call('/Friend/Friends')['Result']['friendList']) == 2)

        print('\n== 运镖与劫镖 ==')
        body = a.call('/Transport/StartPlayerTransport', addresId='1', friendIds='')
        check('甲开始运镖', body['State'] == 1 and body['Result']['horseInfos'][0]['PlayerID'] == str(a.user), body)
        info = b.call('/Transport/GetPlayerTransportInfo')['Result']
        check('乙看到甲的镖车', any(h['PlayerID'] == str(a.user) for h in info['horseInfos']), info)
        helpers = b.call('/Transport/RobFriends')['Result']
        check('拦截邀请好友含甲', any(h.get('Id') == a.user for h in helpers), helpers)
        body = b.call('/Transport/Rob', enemyid=str(a.user), friendIds='')
        check('劫镖战斗返回战报', body['State'] == 1 and 'battleHeros' in body['Result'], body.get('Result', body))
        if body['Result']['isWin']:
            check('劫镖成功获得银币', body['Global']['Reward'] and body['Global']['Reward'][0]['Type'] == 1, body['Global'])
            check('甲的镖车记录被劫', a.call('/Transport/GetPlayerTransportInfo')['Result']['horseInfos'][0]['BeRobedTime'] == 1)
            logs = a.call('/TransportLog/GetPlayerTransportLogList', page='1')['Result']
            check('甲被劫日志 101', logs and logs[0]['Type'] == 101 and 'PN' in logs[0]['Content'], logs)

        print('\n== 妖王共享 ==')
        before = a.call('/Worldboss/WorldbossInfo', timeTick='0')['Result']['bossInfos'][0]['leftHp']
        a.call('/Worldboss/Challenge', type='1', bossID='1', ri='1', star='')
        binfo = b.call('/Worldboss/WorldbossInfo', timeTick='0')['Result']
        check('乙看到甲打掉的血量与榜单', binfo['bossInfos'][0]['leftHp'] < before and binfo['challengeRanks'][0]['name'] == '甲', binfo['bossInfos'][0])
        b.call('/Worldboss/Challenge', type='1', bossID='2', ri='1', star='')
        rank = a.call('/Worldboss/ChallengeRank')['Result']
        check('伤害榜含两人且末元素为自己', len(rank) == 3 and rank[-1]['playerID'] == str(a.user), rank)
    except Exception:
        traceback.print_exc(); FAILED.append('未捕获异常')
    finally:
        shutil.rmtree(workdir, ignore_errors=True)
    print(f'\n通过 {len(PASSED)}，失败 {len(FAILED)}')
    if FAILED:
        print('失败项:', FAILED); sys.exit(1)


if __name__ == '__main__':
    main()
