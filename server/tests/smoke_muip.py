"""GM 服务（MUIP）冒烟：登录、检索、改数值、发放、邮件、封禁、公告、静态页、玩家自助门户。"""
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


def call(base, method, path, body=None, token=None):
    data = json.dumps(body).encode() if body is not None else None
    req = urllib.request.Request(base + path, data=data, method=method, headers={'Content-Type': 'application/json'})
    if token:
        req.add_header('Authorization', f'Bearer {token}')
    try:
        with urllib.request.urlopen(req, timeout=10) as resp:
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
        check('概览：2 名角色', status == 200 and body['players'] == 2 and body['realm']['id'] == 1 and 'PLevel' in body['editableFields'], body)
        status, body = call(base, 'GET', '/api/players?q=%E7%94%B2', token=token)
        check('按昵称搜索', status == 200 and [p['name'] for p in body['players']] == ['甲'], body)
        status, body = call(base, 'GET', f'/api/players?q={b.user}', token=token)
        check('按 ID 搜索', status == 200 and body['players'][0]['userId'] == b.user, body)
        status, body = call(base, 'GET', f'/api/players/{a.user}', token=token)
        check('玩家详情', status == 200 and body['summary']['level'] == 30 and body['resources']['Gold'] == a.role()['Gold'] and len(body['heroes']) >= 1, body.get('summary'))
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
        status, body = call(base, 'PUT', '/api/announcement', {'html': '<p>new</p>'}, token)
        check('保存公告', status == 200 and announcement.read_text(encoding='utf-8') == '<p>new</p>', body)
        check('读取公告', call(base, 'GET', '/api/announcement', token=token)[1]['html'] == '<p>new</p>')
        check('仙盟列表', call(base, 'GET', '/api/unions', token=token)[1] == {'unions': []})
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
