"""v2 冒烟测试：账号→建角→引导→招募→阵容→关卡→成长→法宝→商店→邮件→活动→任务→时间推进→旧存档兼容。"""
import base64
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


def check(name, condition, detail=''):
    (PASSED if condition else FAILED).append(name)
    print(('  PASS ' if condition else '  FAIL ') + name + (f'  -> {str(detail)[:400]}' if detail and not condition else ''))


def get(app, path, **params):
    query = '&'.join(f'{k}={quote(str(v), safe="")}' for k, v in params.items())
    return app.handle('GET', path + ('?' + query if query else ''))[1]


class Player:
    def __init__(self, app, udid, name, hero):
        self.app = app
        ticket = get(app, '/sdk/Default', udid=udid)['Result']['UserID']
        r = get(app, '/Role/partner', userid=json.dumps({'sessionId': ticket}), partnerId='101', serverid='1',
                deviceToken='x', idfa='', mac='')['Result']
        self.user, self.session = r['UserId'], r['Session']
        if name:
            self.call('/Role/Name', deviceToken='x', name=base64.b64encode(name.encode()).decode(), heroProtoID=str(hero))

    def call(self, path, **params):
        return get(self.app, path, user=self.user, session=self.session, version='210', resource='0', _l='Home', **params)

    def role(self):
        return self.call('/Role/Default', deviceToken='x')['Result']

    def grant(self, rewards):
        """测试专用：直接向存档发放物品。"""
        self._ledger(rewards=rewards)

    def consume(self, items):
        self._ledger(consume=items)

    def _ledger(self, rewards=(), consume=()):
        services = self.app.services
        with self.app.storage.transaction() as db:
            ctx = services.roles.open(SessionContext(db=db, user=self.user))
            services.growth.ledger.apply(ctx.state, rewards=rewards, consume=consume)
            ctx.save()


def run(app, clock):
    print('\n== 建角与角色数据 ==')
    p = Player(app, 'v2-device', '测试玩家', 101)
    role = p.role()
    hero = role['team']['groupList'][1]  # 剧情阵容 2 号位
    check('建角成功且英雄带完整属性', role['Name'] == '测试玩家' and hero['heroId'] == 101 and hero['battlePower'] > 0
          and hero['totalExp'] > 0 and hero['rageSkillLevel'] == 1 and 'equipList' in hero, hero)
    check('体力 30/30 且 ETime=0', role['Energy'] == 30 and role['MaxEnergy'] == 30 and role['ETime'] == 0, (role['Energy'], role['MaxEnergy'], role['ETime']))
    check('欢迎邮件红点', role['Notify']['MailCount'] == 1, role['Notify'])
    check('Notify 含签到/征收红点', role['Notify']['SignRewardShow'] == 1 and role['Notify']['EverydayRewardShow'] == 1, role['Notify'])

    print('\n== 引导与新手招募 ==')
    body = p.call('/TiroGuide/save', stepno='1')
    check('引导步骤 1 推送真实阵容', body['State'] == 1 and body['Global']['Slots'][0]['heroId'] == 101, body)
    body = p.call('/Store/StoreHeroRecruitInfo')
    check('招募信息三卡池且 Type3 免费', [x['Type'] for x in body['Result']] == [1, 2, 3] and body['Result'][2]['HaveTimes'] == 0
          and 'HaveOrangeTime' in body['Result'][2], body)
    body = p.call('/Store/StoreHeroRecruit', type='3')
    check('新手首抽得到 102 并进入 Global.Heros', body['State'] == 1 and body['Result']['Reward'][0]['ID'] == 102
          and body['Global']['Heros'][0]['heroId'] == 102, body)
    replay = p.call('/Store/StoreHeroRecruit', type='3')
    check('首抽重试原样重放', replay['Result']['Reward'] == body['Result']['Reward'], replay)
    check('保存引导步骤 5', p.call('/TiroGuide/save', stepno='5')['State'] == 1)

    print('\n== 阵容 ==')
    body = p.call('/Team/Change', heroIds='101,102,0,0,0,0')
    check('布阵两人（1 级仅 3 个阵位）', body['State'] == 1 and [s['heroId'] for s in body['Global']['Slots']] == [101, 102, 0], body)
    body = p.call('/Team/UpdatedTeamHero', index='3', heroID='102')
    check('换位后 102 在 3 号位', [s['heroId'] for s in body['Global']['Slots']] == [101, 0, 102], body)
    body = p.call('/Team/UpdatedTeamHero', index='4', heroID='101')
    check('未解锁阵位被拒', body['State'] == 99 and '级开放' in body['Result'], body)
    body = p.call('/Hero/ChangePartnerID', index='1', upHeroID='102')
    check('小伙伴未解锁被拒', body['State'] == 99, body)
    body = p.call('/Team/TeamNew', playerid=str(p.user))
    check('TeamNew 按解锁阵位下发 3 格且空位占位', len(body['Result']['team']['groupList']) == 3 and body['Result']['team']['groupList'][1]['heroId'] == 0 and body['Result']['team']['battlePower'] > 0, body)
    check('图鉴', p.call('/Handbook/Handbook')['Result']['heros'] == '101,102')

    print('\n== 首章战斗 ==')
    body = p.call('/Battle/fight', cpId='10010', ri='1', star='1')
    check('首关单波胜利', body['State'] == 1 and body['Result']['isWin'] is True and body['Result']['total'] == 1, body.get('Result', body))
    enemies = [h for h in body['Result']['battleHeros'] if h['posId'] >= 7]
    check('首章每波 1 个敌人且 NPC 编号来自 NPC 表', len(enemies) == 1 and all(h['npcId'] // 100 == 10010 for h in enemies), enemies)
    check('BOSS 奔波儿灞在阵中且初始血量为满', enemies[0]['npcId'] == 1001008 and enemies[0]['health'] == enemies[0]['healthMax'] > 0, enemies)
    check('战报含怒气/技能记录', any(r['skillType'] == 2 for r in body['Result']['battleRecords']) or len(body['Result']['battleRecords']) > 0)
    rewards = body['Global']['Reward']
    check('首通奖励含银币/经验/首通武器', {r['Type'] for r in rewards} >= {1, 3, 10}, rewards)
    check('英雄获得经验', body['Result']['BattleResult']['HeroExps'][0]['GetExp'] > 0, body['Result']['BattleResult'])
    check('Global.Slots 随战斗下发', 'Slots' in body['Global'])
    check('战斗结算推送任务状态变化（1001 变为可领取）',
          any(m['MissionId'] == 1001 and m['State'] == 3 and m['Detail']['missionID'] == 1001 for m in body['Global'].get('Missions', [])), body['Global'].get('Missions'))
    body2 = p.call('/MapInfo/GetMapInfo')
    check('无状态变化的接口不附带 Missions', 'Global' not in body2, body2)
    body = p.call('/Battle/fight', cpId='10010', ri='1', star='3')
    check('未通关难度 2 时难度 3 被拒', body['State'] == 99 and '较低难度' in body['Result'], body)
    body = p.call('/Battle/fight', cpId='10010', ri='1', star='2')
    check('难度 2 可挑战', body['State'] == 1, body.get('Result', body))
    # 推进到 10019（3 波）
    for stage in range(10011, 10019):
        wave = 1
        while True:
            body = p.call('/Battle/fight', cpId=str(stage), ri=str(wave), star='1')
            assert body['State'] == 1 and body['Result']['isWin'], (stage, wave, body)
            if wave >= body['Result']['total']:
                break
            wave += 1
    b1 = p.call('/Battle/fight', cpId='10019', ri='1', star='1')
    check('10019 第 1 波（共 3 波）', b1['State'] == 1 and b1['Result']['total'] == 3 and 'dropList' in b1['Result'] and b1['Result']['dropList'] == [], b1.get('Result', b1))
    bad = p.call('/Battle/fight', cpId='10019', ri='3', star='1')
    check('跳波次被拒', bad['State'] == 99 and '流程' in bad['Result'], bad)
    b2 = p.call('/Battle/fight', cpId='10019', ri='2', star='1')
    b3 = p.call('/Battle/fight', cpId='10019', ri='3', star='1')
    check('三波打完结算', b2['State'] == 1 and b3['State'] == 1 and b3['Result']['isWin'] and b3['Result']['BattleResult']['IsFirst'] is True, b3.get('Result', b3))
    hp_wave1 = {h['posId']: h['health'] for h in b1['Result']['battleHeros'] if h['posId'] <= 6}
    hp_wave2 = {h['posId']: h['health'] for h in b2['Result']['battleHeros'] if h['posId'] <= 6}
    check('波次间血量延续', all(hp_wave2[k] <= hp_wave1[k] for k in hp_wave1), (hp_wave1, hp_wave2))
    role = p.role()
    check('通关首章后 MaxPID=10020、玩家升级', role['Map']['MaxPID'] == 10020 and role['PLevel'] > 1, (role['Map']['MaxPID'], role['PLevel']))
    check('升级后体力补满', role['Energy'] == role['MaxEnergy'] and role['MaxEnergy'] > 30, (role['Energy'], role['MaxEnergy']))
    body = p.call('/Battle/IsSXRewarNew', Chapter='1001')
    check('章节累计 11 星 → 一档可领', [s['State'] for s in body['Result']['SanXinReward']] == [0, 2, 2], body)
    body = p.call('/Battle/SXRewar', Chapter='1001', star='1')
    check('领取章节宝箱', body['State'] == 1 and len(body['Global']['Reward']) == 4, body)
    body = p.call('/Battle/BattleTen', cpId='10010', star='1')
    check('扫荡需 20 级', body['State'] == 99 and '20级' in body['Result'], body)

    print('\n== 任务 ==')
    body = p.call('/Mission/Missions')
    ids = {m['missionID']: m['state'] for m in body['Result']}
    check('任务列表含主线与每日', 1001 in ids and 5002 in ids and ids[1001] == 3 and ids[5002] == 3, ids)
    body = p.call('/Mission/Reward', missionID='1001')
    check('领取任务奖励并推送 Missions', body['State'] == 1 and 'Missions' in body['Global'], body)
    body = p.call('/Mission/Reward', missionID='1001')
    check('重复领取被拒', body['State'] == -1133002, body)

    print('\n== 商店与道具 ==')
    goods = p.call('/Prop/GetStorePropLst')['Result']
    energy = next(g for g in goods if g['PropsID'] == 100001)
    check('商店体力丹首档 30 元宝', energy['Price'] == 30 and energy['CurrencyType'] == 2 and energy['TodayHaveBuyCnt'] == 3, energy)
    body = p.call('/Prop/BuyGoods', type='5', id='100001', count='1')
    check('购买体力丹', body['State'] == 1 and body['Global']['Consume'] == [{'Type': 2, 'ID': 0, 'Count': 30}], body)
    goods = p.call('/Prop/GetStorePropLst')['Result']
    check('第二次价格仍为 30（前 3 次同档）', next(g for g in goods if g['PropsID'] == 100001)['Price'] == 30 and next(g for g in goods if g['PropsID'] == 100001)['TotalBuyCnt'] == 1)
    body = p.call('/Prop/UseProps', id='100001', count='1')
    check('使用体力丹 +10（允许超过上限）', body['State'] == 1 and body['Global']['Reward'] == [{'Type': 9, 'ID': 0, 'Count': 10}] and body['Global']['Resource']['Energy'] > body['Global']['Resource']['MaxEnergy'], body)
    p.grant([{'Type': 5, 'ID': 100010, 'Count': 2}, {'Type': 5, 'ID': 100023, 'Count': 1}, {'Type': 5, 'ID': 100024, 'Count': 1}])
    body = p.call('/Prop/UseProps', id='100010', count='1')
    check('经验丹进入经验池', body['State'] == 1 and body['Global']['Resource']['HeroExp'] == 500, body)
    body = p.call('/Prop/UseProps', id='100010', count='1', heroId='102')
    check('经验丹直接喂主将', body['State'] == 1 and body['Global']['Heros'][0]['heroId'] == 102, body)
    body = p.call('/Prop/UseProps', id='100023', count='1')
    check('铜宝箱消耗钥匙并开出奖励', body['State'] == 1 and any(c['ID'] == 100024 for c in body['Global']['Consume']) and body['Global']['Reward'], body)
    body = p.call('/Prop/HeroUpdLevel', heroId='101', addLv='1')
    check('主将等级不能超过玩家等级', body['State'] == -1116001, body)
    body = p.call('/Mysterystore/GetMysterystoreInfo')
    check('神秘商店 6 格', body['State'] == 1 and len(body['Result']['Info']) == 6, body)

    print('\n== 法宝 ==')
    talismans = p.call('/Talisman/Talismans')['Result']
    weapon = next((t for t in talismans if t['equipId'] == 194), None)
    check('建角时按职业发放初始武器（101 御士 → 桃木剑）', weapon is not None and weapon['normalAttack'] > 0 and weapon['heroId'] == 0, talismans)
    amulet = next((t for t in talismans if t['equipId'] == 1), None)
    check('首通灵符在法宝背包', amulet is not None and amulet['skillAttack'] > 0 and amulet['pinJie'] == 1, talismans)
    eid = amulet['equipUserId']
    p.grant([{'Type': 10, 'ID': 200, 'Count': 1}])
    mage_weapon = next(t for t in p.call('/Talisman/Talismans')['Result'] if t['equipId'] == 200)
    body = p.call('/Hero/Change', heroID='101', type='1', id=str(mage_weapon['equipUserId']))
    check('法师武器穿到御士被拒（与客户端一致）', body['State'] == -1117001, body)
    # 引导修补：处于换装备→锻造阶段但主将没有武器的存档，加载时自动补发并穿戴
    g = Player(app, 'v2-weapon-device', '锻造玩家', 128)
    g.call('/TiroGuide/save', stepno='1'); g.call('/Store/StoreHeroRecruit', type='3')
    for t in g.call('/Talisman/Talismans')['Result']:
        g.consume([{'Type': 10, 'ID': t['equipUserId'], 'Count': 1}])
    check('修补前背包无法宝', g.call('/Talisman/Talismans')['Result'] == [])
    g.call('/TiroGuide/save', stepno='15')
    lead = g.role()['team']['groupList'][0]
    check('引导期缺武器时自动补发并穿戴（128 法师 → 雷火珠）', any(e['equipId'] == 200 for e in lead['equipList']), lead['equipList'])
    before = next(h for h in p.role()['ownedHeros'] if h['heroId'] == 101)['battlePower']
    body = p.call('/Hero/Change', heroID='101', type='2', id=str(eid))
    slot = next(s for s in body['Global']['Slots'] if s['heroId'] == 101)
    check('穿戴后 equipList 与战力提升', body['State'] == 1 and slot['equipList'][0]['equipUserId'] == eid and slot['battlePower'] > before, body)
    body = p.call('/Talisman/intensify', playerTalismanId=str(eid), number='1')
    check('锻造 +1 级', body['State'] == 1 and body['Result']['Operator']['Talisman']['level'] == 2 and body['Result']['Operator']['AddLvs'] == [2], body)
    body = p.call('/Talisman/RecastInfo', talismanID=str(eid))
    check('重铸信息', body['State'] == 1 and body['Result']['recastCost'] == 10, body)
    body = p.call('/Talisman/recast', id=str(eid), type='1')
    check('重铸石不足被拒', body['State'] == 99 and '重铸石' in body['Result'], body)
    p.grant([{'Type': 22, 'ID': 0, 'Count': 100}])
    body = p.call('/Talisman/recast', id=str(eid), type='1')
    check('重铸推进品阶进度', body['State'] == 1 and body['Result']['Talisman']['pinJieLevel'] in (0, 1), body)
    body = p.call('/Hero/Unloading', heroID='101', type='2', id=str(eid))
    check('卸下法宝', body['State'] == 1 and next(s for s in body['Global']['Slots'] if s['heroId'] == 101)['equipList'] == [], body)
    body = p.call('/Hero/ChangeAll', heroID='102')
    check('一键穿戴给 102', body['State'] == 1 and next(s for s in body['Global']['Slots'] if s['heroId'] == 102)['equipList'], body)
    p.grant([{'Type': 10, 'ID': 5, 'Count': 1}])
    extra = next(t for t in p.call('/Talisman/Talismans')['Result'] if t['equipId'] == 5)
    body = p.call('/Talisman/DecomposeTalisman', id=str(extra['equipUserId']), type='1')
    check('分解得到碎片', body['State'] == 1 and body['Global']['Reward'] and body['Global']['Reward'][0]['Type'] == 23, body)
    frag = body['Global']['Reward'][0]
    p.grant([{'Type': 23, 'ID': frag['ID'], 'Count': 20}])
    body = p.call('/Talisman/FexchangT', fragmentid=str(frag['ID']))
    check('碎片合成法宝', body['State'] == 1 and body['Global']['Reward'][0]['Type'] == 10, body)
    body = p.call('/Talisman/SellFragment', fragmentid=str(frag['ID']), count='1')
    check('出售碎片', body['State'] == 1 and body['Global']['Reward'][0]['Type'] == 1, body)

    print('\n== 进阶与培养 ==')
    body = p.call('/Hero/Train', heroID='101', count='1', isspecial='false')
    check('无潜力点培养被拒', body['State'] == 99 and '潜力' in body['Result'], body)
    mates = next((x['Count'] for x in p.role()['Others'] if x['ID'] == 200125), 0)
    check('首章首通累计进阶丹 ≥ 60', mates >= 60, mates)
    body = p.call('/Hero/Breakthrough', heroid='101')
    check('进阶成功 rebirthCount=1、潜力 +80、消耗 60', body['State'] == 1 and body['Global']['Heros'][0]['rebirthCount'] == 1
          and body['Global']['Heros'][0]['potency'] == 80 and body['Global']['Consume'] == [{'Type': 6, 'ID': 200125, 'Count': 60}], body)
    slot = next(s for s in body['Global']['Slots'] if s['heroId'] == 101)
    check('进阶后 Slots 带 rebirthCount，阵容立绘才能换皮', slot['rebirthCount'] == 1, slot)
    left = next((x['Count'] for x in p.role()['Others'] if x['ID'] == 200125), 0)
    if left:
        p.consume([{'Type': 6, 'ID': 200125, 'Count': left}])
    body = p.call('/Hero/Breakthrough', heroid='101')
    check('第二次进阶不再受引导保护：材料不足或等级不足', body['State'] in (99, -1116001) and ('不足' in body['Result'] or '级' in body['Result']), body)
    # 引导保护：新号在引导期内材料不足也能完成首次进阶
    q = Player(app, 'v2-guide-device', '引导玩家', 112)
    q.call('/TiroGuide/save', stepno='1')
    body = q.call('/Hero/Breakthrough', heroid='112')
    check('引导期首次进阶自动补齐材料', body['State'] == 1 and body['Global']['Heros'][0]['rebirthCount'] == 1
          and any(r['ID'] == 200125 and r['Count'] == 60 for r in body['Global']['Reward']), body)
    body = p.call('/Hero/Train', heroID='101', count='1', isspecial='false')
    check('培养预览', body['State'] == 1 and set(body['Result']['Operator']['Changed']) == {'Con', 'Str', 'Inte', 'Agility'}, body)
    changed = body['Result']['Operator']['Changed']
    body = p.call('/Hero/SaveTrain', heroID='101')
    check('保存培养', body['State'] == 1 and 'Slots' in body['Global'], body)
    body = p.call('/Hero/SaveTrain', heroID='101')
    check('重复保存被拒', body['State'] == 99, body)
    body = p.call('/Hero/skilltrain', heroid='101')
    check('技能训练（阅历不足或成功）', body['State'] in (1, 99), body)
    p.grant([{'Type': 4, 'ID': 1030, 'Count': 60}])
    body = p.call('/hero/RecruitHero', soulId='1030')
    check('将魂招募 103', body['State'] == 1 and body['Global']['Heros'][0]['heroId'] == 103, body)
    body = p.call('/Prop/HeroUpdLevel', heroId='103', addLv='1')
    check('经验池升级新主将 103', body['State'] == 1 and body['Global']['Heros'][0]['level'] == 2 and body['Global']['Resource']['HeroExp'] < 500, body)
    body = p.call('/Prop/HeroUpdLevel', heroId='103', addLv='-1')
    check('经验池尽量升级', body['State'] == 1 and body['Global']['Heros'][0]['level'] >= 2, body)

    print('\n== 招募卡池 ==')
    body = p.call('/Store/StoreHeroRecruit', type='1')
    check('百里寻将首次免费', body['State'] == 1 and body['Global']['Consume'] == [], body)
    body = p.call('/Store/StoreHeroRecruit', type='1')
    check('第二次扣 100 元宝', body['State'] == 1 and body['Global']['Consume'] == [{'Type': 2, 'ID': 0, 'Count': 100}], body)
    body = p.call('/Store/StoreHeroRecruit', type='3', count='10')
    check('十连元宝不足 -1108002', body['State'] == -1108002, body)
    p.grant([{'Type': 2, 'ID': 0, 'Count': 5000}])
    body = p.call('/Store/StoreHeroRecruit', type='3', count='10')
    check('十连返回 TenLst', body['State'] == 1 and len(body['Result']['TenLst']) == 10 and body['Global']['Consume'][0]['Count'] == 4000, body)
    check('重复英雄转为将魂', any(r['Type'] == 4 for r in body['Result']['TenLst']) or len(p.role()['ownedHeros']) > 3)

    print('\n== 邮件 ==')
    body = p.call('/Mailinfo/GetMailinfoList', index='1', type='0')
    check('邮件列表含欢迎邮件', body['State'] == 1 and body['Result']['MailList'] and body['Result']['MailList'][-1]['HaveAccessory'] == 1, body)
    pkid = body['Result']['MailList'][-1]['PKID']
    body = p.call('/Mailinfo/GetMailinfo', mailId=str(pkid))
    check('邮件详情含附件', body['State'] == 1 and body['Result']['MailAccessory'] and body['Result']['NickName'] == '大闹天宫HD运营团队', body)
    body = p.call('/Mailinfo/DeletePlayerMailId', mailid=str(pkid))
    check('未领附件不能删除', body['State'] == 99, body)
    body = p.call('/Mailinfo/GetPlayerAccessory', mailId=str(pkid))
    check('领取附件', body['State'] == 1 and body['Global']['Reward'], body)
    body = p.call('/Mailinfo/GetPlayerAccessory', mailId=str(pkid))
    check('重复领取 -1109002', body['State'] == -1109002, body)
    check('删除邮件', p.call('/Mailinfo/DeletePlayerMailId', mailid=str(pkid))['State'] == 1)
    check('未读数为 0 或含升级邮件', p.call('/Mailinfo/SeeUnreadMailNumber')['State'] == 1)

    print('\n== 活动 ==')
    body = p.call('/SignMonth/GetSignInfoNew')
    check('签到信息 31 格', body['State'] == 1 and len(body['Result']['SingRewardLst']) == 31 and body['Result']['HaveGetTime'] == 1, body)
    body = p.call('/SignMonth/SignMonthNew')
    check('签到成功', body['State'] == 1 and body['Result']['MonthSignDay'] == 1 and body['Global']['Reward'], body)
    check('重复签到 -1124001', p.call('/SignMonth/SignMonthNew')['State'] == -1124001)
    body = p.call('/PlayerEverydayReward/EveryDayRewarInfo')
    check('每日征收信息：今日可征收 1 次、礼包带 icon/ListCrr', body['State'] == 1 and body['Result']['Salary']['ToDay'] == 1
          and body['Result']['Salary']['AllDay'] == 7 and len(body['Result']['GiftBag']) == 3
          and all('icon' in g and 'ListCrr' in g for g in body['Result']['GiftBag']), body)
    body = p.call('/EverydayReward/GetToDayRewar')
    check('领取征收：剩余 0 次、连续 1 天、倒计时', body['State'] == 1 and body['Result']['ToDay'] == 0
          and body['Result']['ContinuousDay'] == 1 and body['Result']['CountDown'] > 0, body)
    check('重复征收被拒', p.call('/EverydayReward/GetToDayRewar')['State'] == -1131001)
    check('领取每日礼包 1', p.call('/EverydayReward/GetActivity', id='1')['State'] == 1)
    bag = p.call('/PlayerEverydayReward/EveryDayRewarInfo')['Result']['GiftBag'][0]
    check('领取后 DayNuber=1 达到 MustDayNuber（客户端据此禁用按钮）', bag['DayNuber'] == 1 and bag['MustDayNuber'] == 1 and bag['MustNumber'] == -1, bag)
    check('重复领取礼包被拒', p.call('/EverydayReward/GetActivity', id='1')['State'] == -1131001)
    body = p.call('/loginreward/SDHRewards')
    check('七日登录第 1 天可领', body['Result']['GetSverDaysReward'][0]['Status'] == 1 and body['Result']['GetSverDaysReward'][1]['Status'] == 3, body)
    check('领取第 1 天', p.call('/loginreward/getReward', day='1')['State'] == 1)
    check('第 2 天未达', p.call('/loginreward/getReward', day='2')['State'] == 99)
    body = p.call('/LevelGiftBag/GetLevelGiftBagInfo')
    check('等级礼包 5 级可领', body['State'] == 1 and body['Result'][0]['Level'] == 5 and body['Result'][0]['IsGetStatus'] == 1, body)
    check('领取 5 级礼包', p.call('/LevelGiftBag/GetLevelGiftBagReward', level='5')['State'] == 1)
    check('月卡信息', p.call('/Monthcard/GetMonthcardInfo')['Result']['IsBuyMonthCard'] == 0)
    check('跑马灯', p.call('/Message/Messages')['Result'][0]['content'].startswith('欢迎'))
    body = p.call('/Mission/Missions')
    check('每日签到任务可领', next(m['state'] for m in body['Result'] if m['missionID'] == 5001) == 3, body)

    print('\n== 时间推进 ==')
    p.consume([{'Type': 9, 'ID': 0, 'Count': p.role()['Energy'] - 20}])
    role = p.role()
    energy_before, etime = role['Energy'], role['ETime']
    check('体力未满时 ETime>0', energy_before < role['MaxEnergy'] and 0 < etime <= 1800, (energy_before, etime))
    clock.advance(1800 * 2)
    role = p.role()
    check('推进 1 小时后体力 +2', role['Energy'] == min(role['MaxEnergy'], energy_before + 2), (energy_before, role['Energy']))
    clock.advance(86400)
    role = p.role()
    check('跨天后签到红点恢复且 COD 清零', role['Notify']['SignRewardShow'] == 1 and all(pt['COD'] == 0 for pt in role['Map']['Point']), role['Notify'])
    body = p.call('/loginreward/SDHRewards')
    check('第二天七日登录第 2 天可领', body['Result']['GetSverDaysReward'][1]['Status'] == 1, body)
    body = p.call('/Store/StoreHeroRecruitInfo')
    check('隔天百里寻将再次免费', body['Result'][0]['HaveTimes'] == 0, body)


def run_legacy(config, legacy_db, clock):
    print('\n== 旧存档兼容 ==')
    app = Application(config, legacy_db, clock=clock, rng=random.Random(3))
    p = Player(app, 'e3f5536a141811db40efd6400f1d0a4e', None, None)
    role = p.role()
    lead = next(h for h in role['ownedHeros'] if h['battleIx'] == 1)
    check('现有存档加载并刷新属性', role['Name'] and role['team']['groupList'][0]['heroId'] == lead['heroId']
          and role['team']['groupList'][0]['battlePower'] > 0 and lead['totalExp'] > 0, role.get('team'))
    stage = role['Map']['MaxPID']
    body = p.call('/Battle/fight', cpId=str(stage), ri='1', star='1')
    check('现有存档可继续挑战当前关卡', body['State'] == 1 and body['Result']['isWin'] in (True, False), body.get('Result', body))
    body = p.call('/Store/StoreHeroRecruitInfo')
    check('旧存档招募信息', body['State'] == 1 and len(body['Result']) == 3, body)


def main():
    config = load_config(SERVER_DIR / 'data')
    workdir = Path(tempfile.mkdtemp(prefix='gs_v2_'))
    clock = Clock(config.player.daily_reset_hour)
    clock.freeze(1_800_000_000)
    try:
        app = Application(config, workdir / 'fresh.sqlite3', clock=clock, rng=random.Random(7))
        run(app, clock)
        legacy = workdir / 'legacy.sqlite3'
        shutil.copy(SERVER_DIR / 'data' / 'local.sqlite3', legacy)
        run_legacy(config, legacy, clock)
    except Exception:
        traceback.print_exc()
        FAILED.append('未捕获异常')
    finally:
        shutil.rmtree(workdir, ignore_errors=True)
    print(f'\n通过 {len(PASSED)}，失败 {len(FAILED)}')
    if FAILED:
        print('失败项:', FAILED)
        sys.exit(1)


if __name__ == '__main__':
    main()
