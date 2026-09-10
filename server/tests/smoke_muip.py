"""GM 服务（MUIP）冒烟：登录、检索、改档、发放、进度、英雄、VIP、邮件箱、背包、仙盟、争霸榜、门户、一键全满。"""
import base64
import datetime as dt
import json
import random
import shutil
import sys
import tempfile
import threading
import traceback
import urllib.error
import urllib.request
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from smoke_v5 import SERVER_DIR, Player, check, get, PASSED, FAILED  # noqa: E402
from game_server.app import Application  # noqa: E402
from game_server.config import load_config  # noqa: E402
from game_server.muip.config import MuipConfig  # noqa: E402
from game_server.muip.server import serve  # noqa: E402
from game_server.muip.service import GmService  # noqa: E402
from game_server.services.clock import Clock  # noqa: E402


def call(base, method, path, body=None, token=None, timeout=10):
    data = json.dumps(body).encode() if body is not None else None
    req = urllib.request.Request(base + path, data=data, method=method, headers={'Content-Type': 'application/json'})
    if token:
        req.add_header('Authorization', f'Bearer {token}')
    try:
        with urllib.request.urlopen(req, timeout=timeout) as resp:
            raw = resp.read()
            return resp.status, (json.loads(raw) if resp.headers.get('Content-Type', '').startswith('application/json') else raw)
    except urllib.error.HTTPError as exc:
        raw = exc.read()
        return exc.code, (json.loads(raw) if raw[:1] == b'{' else raw)


def main():
    config = load_config(SERVER_DIR / 'data')
    muip = MuipConfig.load(config.config_dir)
    workdir = Path(tempfile.mkdtemp(prefix='gs_muip_'))
    clock = Clock(config.player.daily_reset_hour)
    clock.freeze(int(dt.datetime(2026, 9, 9, 10, 0).timestamp()))
    server = None
    announcement = workdir / 'announcement.html'
    announcement.write_text('<p>old</p>', encoding='utf-8')
    try:
        app = Application(config, workdir / 'muip.sqlite3', clock=clock, rng=random.Random(21))
        a = Player(app, 'dev-a', '甲', 101, 30)
        b = Player(app, 'dev-b', '乙', 112, 20)
        portal_cfg = {'enabled': True, 'daily_mails': 2, 'max_lines': 3, 'max_count': 1000, 'token_ttl': 3600,
                      'mail_content': '自助补给'}
        gm = GmService(app, announcement, muip.mail_title, muip.search_limit, portal=portal_cfg)
        test_cfg = MuipConfig(host='127.0.0.1', port=0, token=muip.token, webui_dir=muip.webui_dir, search_limit=50,
                              mail_title='GM', portal=portal_cfg)
        server = serve(gm, test_cfg)
        threading.Thread(target=server.serve_forever, daemon=True).start()
        base = f'http://127.0.0.1:{server.server_address[1]}'
        token = muip.token

        status, body = call(base, 'GET', '/api/status')
        check('未登录 401', status == 401, body)
        check('错误令牌 401', call(base, 'POST', '/api/login', {'token': 'bad'})[0] == 401)
        check('登录成功', call(base, 'POST', '/api/login', {'token': token})[1] == {'ok': True})
        status, body = call(base, 'GET', '/api/status', token=token)
        check('概览：2 名角色', status == 200 and body['players'] == 2 and body['realm']['id'] == 1
              and 'PLevel' in body['editableFields'] and body.get('banned') == 0 and body.get('maxLevel') == 30, body)
        status, body = call(base, 'GET', '/api/players?q=%E7%94%B2', token=token)
        check('按昵称搜索', status == 200 and [p['name'] for p in body['players']] == ['甲'], body)
        status, body = call(base, 'GET', f'/api/players?q={b.user}', token=token)
        check('按 ID 搜索', status == 200 and body['players'][0]['userId'] == b.user, body)
        status, body = call(base, 'GET', f'/api/players/{a.user}', token=token)
        check('玩家详情', status == 200 and body['summary']['level'] == 30 and body['resources']['Gold'] == a.role()['Gold'] and len(body['heroes']) >= 1, body.get('summary'))
        check('玩家详情：进度与邮箱结构', isinstance(body.get('mails'), list) and 'mailCount' in body
              and 'progress' in body and 'limits' in body and 'rechargeTotal' in body, list(body))
        status, body = call(base, 'POST', f'/api/players/{a.user}/update', {'fields': {'Gold': 123456, 'PLevel': 45, 'Name': '甲甲'}}, token)
        role = a.role()
        check('改银币 / 等级 / 昵称', status == 200 and role['Gold'] == 123456 and role['PLevel'] == 45 and role['Name'] == '甲甲' and role['MaxEnergy'] > 0, body)
        status, body = call(base, 'POST', f'/api/players/{a.user}/update', {'fields': {'Name': '乙'}}, token)
        check('改成已存在昵称被拒 400', status == 400, body)
        status, body = call(base, 'POST', f'/api/players/{a.user}/grant', {'rewards': [{'Type': 5, 'ID': 100010, 'Count': 3}, {'Type': 2, 'ID': 0, 'Count': 50}]}, token)
        check('发放道具与元宝', status == 200 and any(o['ID'] == 100010 and o['Count'] >= 3 for o in a.role()['Others']), body)
        check('非法奖励 400', call(base, 'POST', f'/api/players/{a.user}/grant', {'rewards': [{'Type': 'x'}]}, token)[0] == 400)
        status, body = call(base, 'POST', f'/api/players/{a.user}/mail', {'content': 'GM 测试邮件', 'attachments': [{'Type': 1, 'ID': 0, 'Count': 1000}]}, token)
        check('单发邮件', status == 200 and body['mail'], body)
        status, body = call(base, 'POST', '/api/mail/broadcast', {'content': '全服公告邮件'}, token)
        check('全服邮件 2 人', status == 200 and body['sent'] == 2, body)
        check('乙收到邮件', b.role()['Notify']['MailCount'] >= 2, b.role()['Notify'])
        status, body = call(base, 'POST', f'/api/players/{b.user}/update', {'fields': {'Banned': True}}, token)
        check('封禁乙', status == 200 and body['banned'] is True, body)
        check('乙被拒绝进入 -1103008', b.call('/Role/Default', deviceToken='x')['State'] == -1103008, b.call('/Role/Default', deviceToken='x'))
        call(base, 'POST', f'/api/players/{b.user}/update', {'fields': {'Banned': False}}, token)
        check('解封后可进入', b.call('/Role/Default', deviceToken='x')['State'] == 1)
        status, body = call(base, 'GET', '/api/items?type=5&q=%E4%BD%93%E5%8A%9B', token=token)
        check('静态表检索道具', status == 200 and body['items'] and all('name' in i for i in body['items']), body)
        status, body = call(base, 'GET', '/api/items?type=1', token=token)
        check('资源类型检索', status == 200 and body['items'] == [{'id': 0, 'name': '银币'}], body)
        status, body = call(base, 'POST', f'/api/players/{a.user}/reset-daily', token=token)
        check('重置每日', status == 200 and body['userId'] == a.user, body)
        status, body = call(base, 'GET', '/api/status', token=token)
        check('概览：改档后最高等级', status == 200 and body.get('maxLevel') == 45 and body.get('banned') == 0, body)
        status, detail = call(base, 'GET', f'/api/players/{a.user}', token=token)
        owned = {h['heroId'] for h in detail['heroes']}
        unused = next(int(k) for k in app.catalog['BaseHeros'] if int(k) not in owned)
        status, body = call(base, 'POST', f'/api/players/{a.user}/hero', {'heroId': unused}, token)
        check('发放主将', status == 200 and body['heroId'] == unused and body['name'], body)
        check('重复发放主将 400', call(base, 'POST', f'/api/players/{a.user}/hero', {'heroId': unused}, token)[0] == 400)
        check('不存在的主将 400', call(base, 'POST', f'/api/players/{a.user}/hero', {'heroId': 999999999}, token)[0] == 400)
        status, body = call(base, 'POST', f'/api/players/{a.user}/hero-update',
                            {'heroId': unused, 'level': 20, 'rebirthCount': 0, 'rageTrained': 8}, token)
        check('改主将等级与技能训练', status == 200 and body['hero']['level'] == 20 and body['hero']['rageTrained'] == 8, body)
        first_stage = app.catalog.first_stage_id()
        next_stage = app.catalog.next_stage_id(first_stage)
        tower_max = int(app.config.features.tower['max_floor'])
        status, body = call(base, 'POST', f'/api/players/{a.user}/progress',
                            {'fields': {'maxStage': next_stage, 'towerFloor': 5, 'tiroMaxStep': 3}}, token)
        check('改关卡/塔/引导', status == 200 and body['progress']['maxStage'] == next_stage
              and body['progress']['towerFloor'] == 5 and body['progress']['tiroMaxStep'] == 3, body)
        check('非法关卡 400', call(base, 'POST', f'/api/players/{a.user}/progress', {'fields': {'maxStage': 0}}, token)[0] == 400)
        check('塔层超限 400', call(base, 'POST', f'/api/players/{a.user}/progress',
                                  {'fields': {'towerFloor': tower_max + 1}}, token)[0] == 400)
        guide_step = app.config.player.guide_protect_until_step
        status, body = call(base, 'POST', f'/api/players/{a.user}/skip-guide', token=token)
        check('跳过引导', status == 200 and body['progress']['tiroMaxStep'] == guide_step, body)
        status, body = call(base, 'POST', f'/api/players/{a.user}/recharge', {'ingot': 1000}, token)
        check('补累计充值并升 VIP', status == 200 and body['rechargeTotal'] >= 1000 and body['vip'] >= 3, body)
        status, body = call(base, 'POST', f'/api/players/{a.user}/month-card', {'days': 30}, token)
        check('开通月卡', status == 200 and body['monthCardLeft'] >= 30 * 86400 - 10, body)
        status, body = call(base, 'POST', f'/api/players/{a.user}/growup', token=token)
        check('开通成长计划', status == 200 and body['growupBought'] is True, body)
        status, detail = call(base, 'GET', f'/api/players/{a.user}', token=token)
        mail_id, mail_count = detail['mails'][0]['id'], detail['mailCount']
        status, body = call(base, 'POST', f'/api/players/{a.user}/delete-mail', {'mailId': mail_id}, token)
        check('删除一封邮件', status == 200 and body['removed'] == 1, body)
        check('邮件数减 1', call(base, 'GET', f'/api/players/{a.user}', token=token)[1]['mailCount'] == mail_count - 1)
        status, body = call(base, 'POST', f'/api/players/{a.user}/clear-mails', token=token)
        check('清空邮箱', status == 200 and body['removed'] >= 1, body)
        check('清空后邮件数为 0', call(base, 'GET', f'/api/players/{a.user}', token=token)[1]['mailCount'] == 0)
        prop = next((o for o in detail['others'] if o.get('ID') == 100010), None)
        check('背包含发放道具', prop is not None and prop['Count'] >= 3, prop)
        status, body = call(base, 'POST', f'/api/players/{a.user}/bag-remove',
                            {'Type': 5, 'ID': 100010, 'Count': (prop or {}).get('Count') or 3}, token)
        check('扣除背包道具', status == 200, body)
        check('道具已扣除', all(o.get('ID') != 100010 for o in call(base, 'GET', f'/api/players/{a.user}', token=token)[1]['others']))
        status, body = call(base, 'POST', '/api/mail/many',
                            {'userIds': [a.user, b.user, 999999], 'content': '指定邮件'}, token)
        check('指定玩家邮件', status == 200 and body['sent'] == 2 and body['missing'] == [999999], body)
        status, body = call(base, 'GET', '/api/ranks?limit=5', token=token)
        check('争霸榜', status == 200 and len(body['ranks']) == 5 and body['ranks'][0]['rank'] == 1
              and 'robot' in body['ranks'][0], body)
        check('仙盟不存在 400', call(base, 'GET', f'/api/unions/1', token=token)[0] == 400)
        check('未入盟退盟 400', call(base, 'POST', f'/api/players/{a.user}/leave-union', token=token)[0] == 400)
        status, body = call(base, 'POST', f'/api/players/{a.user}/max-out', {}, token, timeout=60)
        role = a.role()
        catalog = app.catalog
        hero_total = len(catalog['BaseHeros'])
        max_level = app.config.player.level_up.max_level
        heroes_model = app.services.roles.model.heroes
        equipment = app.services.roles.model.equipment
        check('一键全满：账户满级且解锁全部主将', status == 200 and role['PLevel'] == max_level
              and len(role['ownedHeros']) == hero_total and body.get('heroes') == hero_total, (status, body, len(role['ownedHeros'])))
        sample = role['ownedHeros'][0]
        sample_tmpl = heroes_model.template(sample['heroId'])
        dim_cap = max_level * heroes_model.config.train_dimension_cap_per_level
        check('一键全满：培养拉满', sample['level'] == max_level
              and sample['rebirthCount'] == heroes_model.rebirth_max(sample_tmpl)
              and sample['trainDims']['physical'] == dim_cap and sample.get('rageTrained') == max_level, sample)
        fate_hero, fate_ids = None, set()
        for hero in role['ownedHeros']:
            tmpl = catalog['BaseHeros'][str(hero['heroId'])]
            group = tmpl.get('groupEquips') or {}
            rows = group.values() if isinstance(group, dict) else group
            ids = {int(item['equipId']) for item in (rows or [])
                   if item.get('equipId') and str(item['equipId']) in catalog['BaseEquips']}
            if ids:
                fate_hero, fate_ids = hero, ids
                break
        worn_ids = {int(e['equipId']) for e in (fate_hero.get('equipList') or [])} if fate_hero else set()
        check('一键全满：缘分法宝已穿戴', fate_hero is not None and fate_ids <= worn_ids, (fate_ids, worn_ids))
        try:
            max_pinjie = max(int(v) for v in catalog['EquipPinjieType'].values())
        except KeyError:
            max_pinjie = 5
        forge_cap = equipment.level_cap(max_level)
        check('一键全满：法宝满锻造满品阶', fate_hero and all(e['level'] >= forge_cap and e.get('pinJie', 0) >= max_pinjie
              for e in fate_hero['equipList']), fate_hero.get('equipList') if fate_hero else None)
        status, body = call(base, 'PUT', '/api/announcement', {'html': '<p>new</p>'}, token)
        check('保存公告', status == 200 and announcement.read_text(encoding='utf-8') == '<p>new</p>', body)
        check('读取公告', call(base, 'GET', '/api/announcement', token=token)[1]['html'] == '<p>new</p>')
        call(base, 'POST', f'/api/players/{a.user}/grant', {'rewards': [{'Type': 1, 'ID': 0, 'Count': 1200000}]}, token)
        created = a.call('/Union/CreateUnion', name=base64.b64encode('天庭'.encode()).decode())
        check('游戏内创建仙盟', created['State'] == 1, created)
        union_id = created['Result']['UnionId']
        status, body = call(base, 'GET', '/api/unions', token=token)
        check('仙盟列表', status == 200 and body['unions'] and body['unions'][0]['name'] == '天庭', body)
        status, body = call(base, 'GET', f'/api/unions/{union_id}', token=token)
        check('仙盟详情', status == 200 and body['id'] == union_id and body['members'][0]['userId'] == a.user, body)
        status, body = call(base, 'POST', f'/api/unions/{union_id}/update',
                            {'fields': {'notice': '对内', 'outNotice': '对外', 'coin': 88}}, token)
        check('改仙盟公告与贡献', status == 200 and body['coin'] == 88 and body['notice'] == '对内'
              and body['outNotice'] == '对外', body)
        status, body = call(base, 'POST', f'/api/players/{a.user}/leave-union', token=token)
        check('盟主独自退盟即解散', status == 200, body)
        check('退盟后仙盟列表为空', call(base, 'GET', '/api/unions', token=token)[1] == {'unions': []})
        created = a.call('/Union/CreateUnion', name=base64.b64encode('花果山'.encode()).decode())
        check('再次创建仙盟', created['State'] == 1, created)
        union_id = created['Result']['UnionId']
        status, body = call(base, 'POST', f'/api/unions/{union_id}/dissolve', token=token)
        check('GM 解散仙盟', status == 200 and body['dissolved'] == union_id, body)
        check('解散后仙盟列表为空', call(base, 'GET', '/api/unions', token=token)[1] == {'unions': []})
        status, body = call(base, 'GET', '/')
        check('前端首页可访问（已构建）', status == 200 and b'<div id="app">' in body, (status, body[:80]) if isinstance(body, bytes) else body)
        status, body = call(base, 'GET', '/players')
        check('SPA 路由回退 index.html', status == 200 and b'<div id="app">' in body)
        check('未知 API 404', call(base, 'GET', '/api/nothing', token=token)[0] == 404)

        # ---- 玩家自助门户 ----
        check('门户：未知设备 400', call(base, 'POST', '/api/portal/login', {'udid': 'dev-none'})[0] == 400)
        status, body = call(base, 'POST', '/api/portal/login', {'udid': 'dev-a'})
        check('门户：设备号登录', status == 200 and body['token'] and body['player']['name'] == '甲甲'
              and body['quota']['daily'] == 2, body.get('player'))
        ptoken = body['token']
        check('门户令牌不能访问 GM 接口', call(base, 'GET', '/api/status', token=ptoken)[0] == 401)
        check('无令牌访问门户 401', call(base, 'GET', '/api/portal/me')[0] == 401)
        status, body = call(base, 'GET', '/api/portal/me', token=ptoken)
        check('门户：我的信息', status == 200 and body['player']['userId'] == a.user and body['quota']['used'] == 0
              and body['resourceTypes'], body.get('quota'))
        status, body = call(base, 'GET', '/api/portal/items?type=5&q=', token=ptoken)
        check('门户：道具检索', status == 200 and body['items'], (status, body))
        mails_before = a.role()['Notify']['MailCount']
        status, body = call(base, 'POST', '/api/portal/send', {'rewards': [{'Type': 2, 'ID': 0, 'Count': 100}]}, ptoken)
        check('门户：给自己发元宝（邮件送达）', status == 200 and body['quota']['used'] == 1
              and a.role()['Notify']['MailCount'] == mails_before + 1, body.get('quota'))
        check('门户：单种数量超限 400',
              call(base, 'POST', '/api/portal/send', {'rewards': [{'Type': 1, 'ID': 0, 'Count': 5000}]}, ptoken)[0] == 400)
        check('门户：种数超限 400',
              call(base, 'POST', '/api/portal/send', {'rewards': [{'Type': 1, 'ID': 0, 'Count': 1}] * 4}, ptoken)[0] == 400)
        call(base, 'POST', '/api/portal/send', {'rewards': [{'Type': 1, 'ID': 0, 'Count': 100}]}, ptoken)
        status, body = call(base, 'POST', '/api/portal/send', {'rewards': [{'Type': 1, 'ID': 0, 'Count': 100}]}, ptoken)
        check('门户：每日 2 次用完 400', status == 400 and '用完' in body['error'], body)
        # 邮箱账号：注册 → 进服建角 → 门户用明文密码登录
        md5_123456 = 'e10adc3949ba59abbe56e057f20f883e'
        ticket = get(app, '/sdk/Register', email='p@x.com', pwd=md5_123456)['Result']['UserID']
        r = get(app, '/Role/partner', userid=json.dumps({'sessionId': ticket}), partnerId='101', serverid='1',
                deviceToken='x', idfa='', mac='')['Result']
        get(app, '/Role/Name', user=r['UserId'], session=r['Session'], version='210', resource='0', _l='Home',
            deviceToken='x', name=base64.b64encode('丙'.encode()).decode(), heroProtoID='128')
        status, body = call(base, 'POST', '/api/portal/login', {'email': 'p@x.com', 'password': '123456'})
        check('门户：邮箱+明文密码登录', status == 200 and body['player']['name'] == '丙', body)
        ctoken = body['token']
        status, body = call(base, 'POST', '/api/portal/maxout', {}, ctoken, timeout=60)
        check('门户：一键全满', status == 200 and body['player']['level'] == max_level
              and body['heroes'] == hero_total, body)
        gm.portal['maxout'] = False
        check('门户：一键全满开关关闭后被拒', call(base, 'POST', '/api/portal/maxout', {}, ctoken)[0] == 400)
        gm.portal['maxout'] = True
        check('门户：错误密码 400', call(base, 'POST', '/api/portal/login', {'email': 'p@x.com', 'password': 'bad'})[0] == 400)
        # 封禁角色不能登录门户
        call(base, 'POST', f'/api/players/{b.user}/update', {'fields': {'Banned': True}}, token)
        check('门户：封禁角色拒绝登录', call(base, 'POST', '/api/portal/login', {'udid': 'dev-b'})[0] == 400)
        call(base, 'POST', f'/api/players/{b.user}/update', {'fields': {'Banned': False}}, token)
        # 总开关
        gm.portal['enabled'] = False
        check('门户：开关关闭后登录被拒', call(base, 'POST', '/api/portal/login', {'udid': 'dev-a'})[0] == 400)
        gm.portal['enabled'] = True
    except Exception:
        traceback.print_exc(); FAILED.append('未捕获异常')
    finally:
        if server:
            server.shutdown(); server.server_close()
        shutil.rmtree(workdir, ignore_errors=True)
    print(f'\n通过 {len(PASSED)}，失败 {len(FAILED)}')
    if FAILED:
        print('失败项:', FAILED); sys.exit(1)


if __name__ == '__main__':
    main()
