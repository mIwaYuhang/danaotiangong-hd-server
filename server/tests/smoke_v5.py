"""v5 冒烟：小黑屋、神器殿、宝石/矿洞、排行榜（两名玩家）。"""
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
    def __init__(self, app, udid, name, hero, level):
        self.app = app
        ticket = get(app, '/sdk/Default', udid=udid)['Result']['UserID']
        r = get(app, '/Role/partner', userid=json.dumps({'sessionId': ticket}), partnerId='101', serverid='1', deviceToken='x', idfa='', mac='')['Result']
        self.user, self.session = r['UserId'], r['Session']
        self.call('/Role/Name', deviceToken='x', name=base64.b64encode(name.encode()).decode(), heroProtoID=str(hero))
        self.call('/TiroGuide/save', stepno='1'); self.call('/Store/StoreHeroRecruit', type='3'); self.call('/TiroGuide/save', stepno='27')
        self.edit(lambda st: st.update(PLevel=level))
        self.grant([{'Type': 30, 'ID': 0, 'Count': 500000}, {'Type': 2, 'ID': 0, 'Count': 5000}])
        for hid in [h['heroId'] for h in self.role()['ownedHeros']]:
            self.call('/Prop/HeroUpdLevel', heroId=str(hid), addLv='-1')
        self.call('/Team/Change', heroIds=','.join(str(h['heroId']) for h in self.role()['ownedHeros']) + ',0,0,0,0')

    def edit(self, fn):
        s = self.app.services
        with self.app.storage.transaction() as db:
            ctx = s.roles.open(SessionContext(db=db, user=self.user)); fn(ctx.state); ctx.save()

    def grant(self, rewards):
        self.edit(lambda st: self.app.services.growth.ledger.apply(st, rewards=rewards))

    def call(self, path, **params):
        return get(self.app, path, user=self.user, session=self.session, version='210', resource='0', _l='Home', **params)

    def role(self):
        return self.call('/Role/Default', deviceToken='x')['Result']


def main():
    config = load_config(SERVER_DIR / 'data')
    workdir = Path(tempfile.mkdtemp(prefix='gs_v5_'))
    clock = Clock(config.player.daily_reset_hour)
    clock.freeze(int(dt.datetime(2026, 9, 9, 10, 0).timestamp()))
    try:
        app = Application(config, workdir / 'v5.sqlite3', clock=clock, rng=random.Random(5))
        a = Player(app, 'dev-a', '甲', 101, 40)
        b = Player(app, 'dev-b', '乙', 112, 22)

        print('\n== 小黑屋 ==')
        home = a.call('/Darkhouse/Darkhouse')['Result']
        check('主界面：4 笼全开(40级)、免费 5 次', home['captureInfo']['freeCaptureNumber'] == 5 and all(c and c['state'] == 2 for c in home['captureInfo']['captures']), home)
        cands = a.call('/Darkhouse/RandomCaptur')['Result']
        check('候选含乙与机器人', any(c['CaptureMasterInfo'][0]['enemyid'] == b.user for c in cands) and len(cands) >= 5, cands[:2])
        body = a.call('/Darkhouse/CatchCapture', location='1', capturePlayerID=str(b.user), isUseProp='0', ri='1', star='')
        check('抓捕乙返回战报', body['State'] == 1 and 'battleHeros' in body['Result'] and body['Result']['enemy']['Name'] == '乙', body.get('Result', body))
        if body['Result']['isWin']:
            home = a.call('/Darkhouse/Darkhouse')['Result']
            check('乙进入 1 号笼', home['captureInfo']['captures'][0]['state'] == 1 and home['captureInfo']['captures'][0]['name'] == '乙', home['captureInfo']['captures'][0])
            bhome = b.call('/Darkhouse/Darkhouse')['Result']
            check('乙看到自己被甲抓', bhome['beCapturedInfo']['name'] == '甲' and bhome['beCapturedInfo']['remainFreeTime'] > 0 and bhome['beCapturedInfo']['driveCost'] > 0, bhome['beCapturedInfo'])
            clock.advance(3600)
            body = a.call('/Darkhouse/GainPart', location='1')
            check('榨取一小时收益', body['State'] == 1 and any(r['Type'] == 18 for r in body['Global']['Reward']), body)
            check('乙的战报有被抓记录', b.call('/Darkhouse/ReortList')['Result'][0]['Type'] == 201)
            body = b.call('/Darkhouse/Drive')
            check('乙驱赶主人', body['State'] == 1 and b.call('/Darkhouse/Darkhouse')['Result']['beCapturedInfo']['remainFreeTime'] == 0, body)
            check('甲的笼位清空', a.call('/Darkhouse/Darkhouse')['Result']['captureInfo']['captures'][0]['state'] == 2)
        check('Notify.DarkHouse', a.role()['Notify']['DarkHouse']['Total'] == 5 and a.role()['Notify']['DarkHouse']['CanCapture'] is True)

        print('\n== 神器殿 ==')
        info = a.call('/Artifacthall/Info')['Result']
        check('神器信息 10 阶、当前 1 阶 0 级', info['currentStep'] == 1 and len(info['artifacts']) == 10 and info['artifacts'][0]['level'] == 0, info['artifacts'][0])
        body = a.call('/Artifacthall/Perfusion')
        check('碎片不足 -1108005', body['State'] == -1108005, body)
        a.grant([{'Type': 6, 'ID': f, 'Count': 1} for f in (200200, 200201, 200202, 200203)])
        power_before = a.role()['team']['battlePower']
        body = a.call('/Artifacthall/Perfusion')
        check('灌注成功 1 级并推送 Slots', body['State'] == 1 and body['Result']['level'] == 1 and 'Slots' in body['Global'], body)
        role = a.role()
        check('神器加成进入战力与 attributeAddition.artifact', role['team']['battlePower'] > power_before and role['attributeAddition']['artifact']['Artifact'] == {'Step': 1, 'Level': 1}
              and role['attributeAddition']['artifact']['BattleHeroProperty'].get('HP'), role.get('attributeAddition'))
        cands = a.call('/Artifacthall/BeRobbed', fragmentID='200200')['Result']
        check('抢夺候选 6 人', len(cands) == 6, cands)
        body = a.call('/Artifacthall/Rob', fragmentID='200200', beRobbedPlayerID=cands[-1]['playerID'], type='1', ri='1', star='')
        check('抢夺返回 RobPlayer', body['State'] == 1 and 'RobPlayer' in body['Result'] and body['Result']['RobPlayer']['isGetFragment'] in (0, 1), body.get('Result', body))
        check('抢夺次数减少', a.call('/Artifacthall/Info')['Result']['remainRobTime'] == 9)
        body = a.call('/Artifacthall/RobTen', number='10')
        check('十连抢夺', body['State'] == 1 and len(body['Result']['robTenRewards']) == 10 and body['Global']['Consume'][0]['Count'] == 50, body)
        check('Notify.ATimes', a.role()['Notify']['ATimes']['ATimes'] == 9)

        print('\n== 宝石 ==')
        check('宝石列表为空', a.call('/Gem/Gems')['Result'] == [])
        body = a.call('/Gem/Buy', id='3', level='2', count='3')
        check('购买 3 颗武器宝石', body['State'] == 1 and len(body['Result']['Gems']) == 3 and body['Result']['Gems'][0]['normalAttack'] > 0, body)
        gems = a.call('/Gem/Gems')['Result']
        weapon = next(t for t in a.call('/Talisman/Talismans')['Result'] if t['equipId'] == 194)
        atk_before = weapon['normalAttack']
        body = a.call('/Gem/Change', talismanID=str(weapon['equipUserId']), gemID=str(gems[0]['id']))
        check('镶嵌到武器：装备属性提升、Gems isBattle=1、Slots 推送', body['State'] == 1 and body['Global']['Talismans'][0]['normalAttack'] > atk_before
              and body['Global']['Gems'][0]['isBattle'] == 1 and 'Slots' in body['Global'], body)
        a.call('/Hero/Change', heroID='101', type='1', id=str(weapon['equipUserId']))
        role = a.role()
        check('attributeAddition.gem 汇总武器部位', any(s['type'] == 1 and s['count'] == 1 and s['battleProperty'].get('AP') for s in role['attributeAddition']['gem']), role['attributeAddition'].get('gem'))
        body = a.call('/Gem/Synthetic', ids=f"{gems[1]['id']},{gems[2]['id']}")
        check('两颗合成（成功或失败均消耗）', body['State'] == 1 and len(body['Result']['Consume']) == 2, body)
        body = a.call('/Gem/Unloading', talismanID=str(weapon['equipUserId']))
        check('卸下宝石', body['State'] == 1 and body['Global']['Gems'][0]['isBattle'] == 0, body)
        info = a.call('/Gem/GemMineInfo')['Result']
        check('矿洞信息', info['totalSeconds'] == 3600 and info['getGem']['totalCount'] == 12, info)
        body = a.call('/Gem/GetGem')
        check('收取矿洞 12 颗', body['State'] == 1 and len(body['Result']['Gems']) == 12, body)
        body = a.call('/Gem/BuyGoldHoe')
        check('金锄头', body['State'] == 1 and body['Result']['useTime'] == 86400 and body['Global']['Consume'][0]['Count'] == 150, body)

        print('\n== 排行榜 ==')
        body = a.call('/RankList/GetRankList', type='1')
        check('等级榜甲第一乙第二', body['Result']['MyRank'] == 1 and [r['PlayerName'] for r in body['Result']['LevelRankResponse']] == ['甲', '乙'], body)
        body = b.call('/RankList/GetRankList', type='2')
        check('战力榜乙 MyRank=2', body['Result']['MyRank'] == 2 and 'PowerRankResponse' in body['Result'], body)
        check('富豪榜空', a.call('/RankList/ConsumeRank')['Result']['ranks'] == [])
    except Exception:
        traceback.print_exc(); FAILED.append('未捕获异常')
    finally:
        shutil.rmtree(workdir, ignore_errors=True)
    print(f'\n通过 {len(PASSED)}，失败 {len(FAILED)}')
    if FAILED:
        print('失败项:', FAILED); sys.exit(1)


if __name__ == '__main__':
    main()
