"""v6 冒烟：仙盟（创建/列表/申请审批/成员/职位/捐献/建筑/公告 POST/分晶石/退出/解散）。"""
import base64
import datetime as dt
import random
import shutil
import sys
import tempfile
import traceback
from pathlib import Path
from urllib.parse import quote

sys.path.insert(0, str(Path(__file__).parent))
from smoke_v5 import SERVER_DIR, Player, check, get, PASSED, FAILED  # noqa: E402
from game_server.app import Application  # noqa: E402
from game_server.config import load_config  # noqa: E402
from game_server.services.clock import Clock  # noqa: E402


def post(player, path, body: dict, **params):
    query = '&'.join(f'{k}={quote(str(v), safe="")}' for k, v in dict(user=player.user, session=player.session, version='210',
                                                                        resource='0', _l='Home', **params).items())
    raw = '&'.join(f'{k}={quote(str(v), safe="")}' for k, v in body.items()).encode()
    return player.app.handle('POST', path + '?' + query, raw)[1]


def b64(text):
    return base64.b64encode(text.encode()).decode()


def post_client(player, path, body: dict, **params):
    """模拟客户端真实 POST：URL 只有 user，正文 urlencoded 且常带末尾 &，_l 为「场景|场景」。"""
    query = f'user={player.user}'
    fields = dict(session=player.session, version='210', resource='0', _l='GuildHomeScene|HomeScene', **body, **params)
    raw = ('&'.join(f'{k}={quote(str(v), safe="")}' for k, v in fields.items()) + '&').encode()
    return player.app.handle('POST', path + '?' + query, raw, 'application/x-www-form-urlencoded')[1]


def post_multipart(player, path, body: dict, **params):
    """模拟 quick-cocos2d-x addPOSTValue：multipart/form-data，session 等也放在正文里。"""
    boundary = '----quickcocos'
    scene = params.pop('_l', 'Home')
    query = '&'.join(f'{k}={quote(str(v), safe="")}' for k, v in dict(user=player.user, **params).items())
    fields = dict(body, session=player.session, version='210', resource='0', _l=scene)
    raw = ''.join(f'--{boundary}\r\nContent-Disposition: form-data; name="{k}"\r\n\r\n{v}\r\n' for k, v in fields.items()) + f'--{boundary}--\r\n'
    return player.app.handle('POST', path + '?' + query, raw.encode(), f'multipart/form-data; boundary={boundary}')[1]


def main():
    config = load_config(SERVER_DIR / 'data')
    workdir = Path(tempfile.mkdtemp(prefix='gs_v6_'))
    clock = Clock(config.player.daily_reset_hour)
    clock.freeze(int(dt.datetime(2026, 9, 9, 10, 0).timestamp()))
    try:
        app = Application(config, workdir / 'v6.sqlite3', clock=clock, rng=random.Random(6))
        a = Player(app, 'dev-a', '甲', 101, 40)
        b = Player(app, 'dev-b', '乙', 112, 30)
        c = Player(app, 'dev-c', '丙', 128, 20)
        a.grant([{'Type': 1, 'ID': 0, 'Count': 600000}])

        check('无仙盟：Notify.IfHaveUnion=0', a.role()['Notify']['IfHaveUnion'] == 0)
        body = a.call('/Union/GetUnionInfo')
        check('无仙盟时 GetUnionInfo -1143001', body['State'] == -1143001, body)
        body = c.call('/Union/CreateUnion', name=b64('丙盟'))
        check('20 级不能创建 -1143003', body['State'] == -1143003, body)
        body = a.call('/Union/CreateUnion', name=b64('大闹天宫'))
        check('创建仙盟：扣 50 万银币、盟主职位', body['State'] == 1 and body['Result']['PositionId'] == 1 and body['Result']['UnionName'] == '大闹天宫'
              and body['Global']['Consume'][0] == {'Type': 1, 'ID': 0, 'Count': 500000}, body)
        union_id = body['Result']['UnionId']
        check('Notify.IfHaveUnion=1', a.role()['Notify']['IfHaveUnion'] == 1 and a.role()['Notify']['UnionStatus'] == 1)
        body = a.call('/Union/CreateUnion', name=b64('第二个'))
        check('已有仙盟不能再建 -1143002', body['State'] == -1143002, body)

        lst = b.call('/Union/GetAllUnionList', page='1', count='0')['Result']
        check('列表含新盟、盟主名', lst['TotalUnionNum'] == 1 and lst['UnionListInfo'][0]['LeaderName'] == '甲' and lst['UnionListInfo'][0]['MaxMemberCount'] == 20, lst)
        body = b.call('/Union/UnionApply', unionId=str(union_id))
        check('乙申请（需审批）', body['State'] == 1 and body['Result']['Joined'] == 0, body)
        check('列表 IsApply=1', b.call('/Union/GetAllUnionList', page='1')['Result']['UnionListInfo'][0]['IsApply'] == 1)
        check('重复申请 -1143009', b.call('/Union/UnionApply', unionId=str(union_id))['State'] == -1143009)
        applies = a.call('/Union/GetUnionApplyList')['Result']
        check('盟主看到申请', applies['ApplyMemberCount'] == 1 and applies['UnionApplyList'][0]['PlayerName'] == '乙', applies)
        check('盟主红点 bNewApply', a.call('/Union/GetUnionInfo')['Result']['NotifyUnion']['bNewApply'] is True)
        check('乙无权审批 -1143011', b.call('/Union/JoinUnion', playerId=str(b.user))['State'] == -1143001)
        body = a.call('/Union/JoinUnion', playerId=str(b.user))
        check('通过申请', body['State'] == 1, body)
        info = b.call('/Union/GetUnionInfo')['Result']
        check('乙已入盟为普通成员', info['PositionId'] == 8 and info['MemberCount'] == 2, info)
        members = a.call('/Union/GetAllPlayerUnions')['Result']
        check('成员列表 2 人、盟主在前', members['CurMemberCount'] == 2 and members['PlayerUnionInfoList'][0]['PlayerName'] == '甲'
              and members['PlayerUnionInfoList'][1]['PlayerId'] == b.user, members)
        body = a.call('/Union/ChangeUnionPosition', changePlayerId=str(b.user), changePositionId='2')
        check('任命乙为长老', body['State'] == 1 and b.call('/Union/GetUnionInfo')['Result']['PositionId'] == 2, body)

        temple = a.call('/Union/Xm')['Result']
        check('神殿信息：3 档、3 次', len(temple['worshipInfos']) == 3 and temple['canWorshipTime'] == 3, temple)
        check('神殿立绘是真实主将', temple['statueInfos'] and temple['statueInfos'][0]['statueAvatarID'] > 0
              and temple['statueInfos'][0]['positionName'] == '盟主', temple['statueInfos'])
        def set_rebirth(player, hero_id, count):
            model = player.app.services.growth.model
            def fn(st):
                hero = next(h for h in st['ownedHeros'] if h['heroId'] == hero_id)
                hero['rebirthCount'] = count
                model.refresh_hero(st, hero)
            player.edit(fn)
        set_rebirth(a, 101, 12)
        temple = a.call('/Union/Xm')['Result']
        lead = next(h for h in a.role()['team']['groupList'] if h['heroId'] == 101)
        check('进阶 12 后阵容带 rebirthCount', lead['rebirthCount'] == 12, lead)
        # 进阶表第 3/7/11 档各送 5 级怒气技（hero.lua rebirthList 描述「@怒气法术…提升5级」）
        check('进阶 12 怒气技 = 训练 1 + 赠送 15', lead['rageSkillLevel'] == 16, lead['rageSkillLevel'])
        check('神殿立绘带 +12 进阶，才会换 dengji2 皮', temple['statueInfos'][0]['statueAvatarID'] == 101
              and temple['statueInfos'][0]['breakthroughCount'] == 12, temple['statueInfos'][0])
        check('神殿立绘带武器', temple['statueInfos'][0].get('statueWeaponID', 0) > 0, temple['statueInfos'][0])
        members = a.call('/Union/GetAllPlayerUnions')['Result']
        me = next(r for r in members['PlayerUnionInfoList'] if r['PlayerId'] == a.user)
        check('成员列表带 BreakthroughCount', me['BreakthroughCount'] == 12 and me['AvatarId'] == 101, me)
        check('我的晶石是玩家 UnionCoin', temple['curUnionCoin'] == a.role()['UnionCoin'], temple)
        body = a.call('/Union/Worship', index='1')
        check('捐献：扣 50 元宝、得晶石、盟贡献增加', body['State'] == 1 and body['Global']['Consume'][0]['Count'] == 50
              and body['Result']['Result']['curUnionCoin'] == 110 and a.role()['UnionCoin'] == 110, body)
        for _ in range(2):
            a.call('/Union/Worship', index='3')
        check('每日 3 次用完 -1143004', a.call('/Union/Worship', index='3')['State'] == -1143004)
        check('日志记录捐献 305', a.call('/Union/GetUnionLogList', type='0')['Result'][0]['Type'] == 305)

        builds = a.call('/Union/GetUnionBuildInfo')['Result']
        check('建筑 4 座、大厅升级需 1000', len(builds) == 4 and builds[0]['NextNeedCoin'] == 1000 and builds[0]['MaxMember'] == 20, builds)
        check('贡献不足不能升级', a.call('/Union/Upgrade', type='1')['State'] != 1)
        for _ in range(3):
            b.call('/Union/Worship', index='1')
        clock.advance(86400)
        for _ in range(3):
            b.call('/Union/Worship', index='1')
        check('乙两天捐献 6 次后 bUpgrade', a.call('/Union/GetUnionInfo')['Result']['NotifyUnion']['bUpgrade'] is True, a.call('/Union/GetUnionInfo')['Result'])
        body = a.call('/Union/Upgrade', type='1')
        check('升级大厅：仙盟 2 级、人数上限 22', body['State'] == 1 and body['Result']['Level'] == 2 and body['Result']['MaxMember'] == 22
              and a.call('/Union/GetUnionInfo')['Result']['UnionLv'] == 2, body)

        body = post(a, '/Union/UpdateUnionNotice', {'notice': b64('今晚打Boss')})
        check('POST 公告', body['State'] == 1 and a.call('/Union/GetUnionInfo')['Result']['Notice'] == '今晚打Boss', body)
        body = post_client(b, '/Union/UpdateUnionOutNotice', {'outNotice': quote(b64('欢迎加入本盟'), safe='.-')})
        check('客户端真实 POST 对外宣言（URL 仅 user、正文末尾 &、_l 含竖线）',
              body['State'] == 1 and b.call('/Union/GetAllUnionList', page='1')['Result']['UnionListInfo'][0]['OutNotice'] == '欢迎加入本盟', body)
        body = post(b, '/Union/UpdateUnionOutNotice', {'outNotice': b64('欢迎加入')})
        check('长老 POST 对外宣言', body['State'] == 1 and b.call('/Union/GetAllUnionList', page='1')['Result']['UnionListInfo'][0]['OutNotice'] == '欢迎加入', body)
        body = post_multipart(a, '/Union/UpdateUnionNotice', {'notice': quote(b64('多部分表单+公告'), safe='')})
        check('multipart POST 公告（客户端真实格式，值已 URL 编码）', body['State'] == 1 and a.call('/Union/GetUnionInfo')['Result']['Notice'] == '多部分表单+公告', body)
        long_notice = '今晚八点准时开打魔族巢穴各位仙友不要迟到准备复活丹'
        wrapped = '\r\n'.join(b64(long_notice)[i:i + 76] for i in range(0, len(b64(long_notice)), 76))
        body = post_multipart(a, '/Union/UpdateUnionNotice', {'notice': quote(wrapped, safe='.-')})
        check('multipart 公告含 Base64 换行（客户端真实编码）', body['State'] == 1 and a.call('/Union/GetUnionInfo')['Result']['Notice'] == long_notice, body)
        greet = '仰慕大仙久矣，可否加在下为好友？'
        wrapped = '\r\n'.join(b64(greet)[i:i + 76] for i in range(0, len(b64(greet)), 76))
        body = post_multipart(a, '/Friend/AddMail', {'message': quote(wrapped, safe='.-')}, friendId=str(c.user),
                              _l='RecommendListLayer|FriendScene')
        check('multipart 加好友申请存明文（客户端会原样显示 content）',
              body['State'] == 1 and c.call('/Friend/RequestFriends')['Result'][0]['content'] == greet,
              c.call('/Friend/RequestFriends')['Result'])
        note = '上仙，心里想你直痒痒，联络信息要常发！'
        wrapped = '\r\n'.join(b64(note)[i:i + 76] for i in range(0, len(b64(note)), 76))
        body = post_multipart(a, '/Friend/SendMail', {'message': quote(wrapped, safe='.-')}, friendId=str(c.user),
                              _l='FriendScene|HomeScene')
        check('multipart 好友留言不报 400', body['State'] == 1, body)
        mails = c.call('/Mailinfo/GetMailinfoList', index='1', type='3')['Result']['MailList']
        check('好友邮件正文是明文', any(m['MessageContent'] == note for m in mails), mails)
        tpuc = a.call('/Union/GetUnionInfo')['Result']['TPUC']
        body = post(a, '/Union/GiveUnionCoin', {'playerIdList': str(b.user), 'coinCount': '10'})
        check('分晶石给乙', body['State'] == 1 and body['Result']['TPUC'] == tpuc - 10 and b.role()['UnionCoin'] > 0, body)
        check('排行榜 UnionGroup 显示盟名', a.call('/RankList/GetRankList', type='1')['Result']['LevelRankResponse'][0]['UnionGroup'] == '大闹天宫')

        check('盟主不能退出 -11430023', a.call('/Union/LeftUnion')['State'] == -11430023)
        body = b.call('/Union/LeftUnion')
        check('乙退出、冷却 24h', body['State'] == 1 and b.call('/Union/GetAllUnionList', page='1')['Result']['NextJoinTime'] == 86400, b.call('/Union/GetAllUnionList', page='1'))
        check('冷却期不能申请 -1143008', b.call('/Union/UnionApply', unionId=str(union_id))['State'] == -1143008)
        a.call('/Union/ChangeUnionApplyStatus', status='1')
        c.edit(lambda st: st.update(PLevel=26))
        body = c.call('/Union/UnionApply', unionId=str(union_id))
        check('免审直接入盟', body['State'] == 1 and body['Result']['Joined'] == 1 and c.role()['Notify']['IfHaveUnion'] == 1, body)
        body = a.call('/Union/KickOutUnion', kickPlayerId=str(c.user))
        check('踢出丙', body['State'] == 1 and c.role()['Notify']['IfHaveUnion'] == 0, body)
        body = a.call('/Union/DeleteUnion')
        check('解散仙盟', body['State'] == 1 and a.role()['Notify']['IfHaveUnion'] == 0 and b.call('/Union/GetAllUnionList', page='1')['Result']['TotalUnionNum'] == 0, body)
    except Exception:
        traceback.print_exc(); FAILED.append('未捕获异常')
    finally:
        shutil.rmtree(workdir, ignore_errors=True)
    print(f'\n通过 {len(PASSED)}，失败 {len(FAILED)}')
    if FAILED:
        print('失败项:', FAILED); sys.exit(1)


if __name__ == '__main__':
    main()
