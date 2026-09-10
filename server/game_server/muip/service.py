"""GM 操作实现：全部经由游戏服务层执行，与玩家在线时的规则一致。

另含「玩家自助门户」：玩家用自己的游戏账号（游客设备号或注册邮箱+密码）登录，
在配额内给自己发物品（走系统邮件，与 GM 单发一致），并可一键全满
（解锁全部主将、账户满级、培养拉满、穿戴缘分法宝）。
"""
from copy import deepcopy
import hashlib
import hmac
import json
import re
import secrets
import time

from ..config import thaw
from ..errors import BusinessError
from ..services.base import SessionContext
from ..services.hero_model import DIMENSIONS
from ..services.talisman import ATTR_BY_COLUMN, ATTR_BY_NAME, DESC_ATTR
from .config import PORTAL_DEFAULTS

#: 可直接改写的资源字段 → 中文名（用于校验与前端展示）
EDITABLE_FIELDS = {'PLevel': '等级', 'Gold': '银币', 'Ingot': '元宝', 'Energy': '体力', 'Knowledge': '阅历', 'TrainPill': '培养丹',
                   'HeroExp': '英雄经验池', 'Honor': '荣誉', 'SoulJade': '魂玉', 'Prestige': '威望', 'UnionCoin': '晶石',
                   'RecastStone': '重铸石', 'LearnExp': '授业值', 'DestinyExp': '天命经验', 'DestinyFragment': '天命碎片',
                   'VipLevel': 'VIP 等级', 'VipExp': 'VIP 经验', 'Exp': '当前经验'}
#: 静态表检索：物品类型 → (表名, 名称列)
CATALOG_TABLES = {4: ('BaseSouls', 'name'), 5: ('BaseProps', 'name'), 6: ('BaseMates', 'name'), 7: ('BaseHeros', 'name'),
                  10: ('BaseEquips', 'name')}
RESOURCE_TYPES = {1: '银币', 2: '元宝', 3: '玩家经验', 9: '体力', 11: '培养丹', 14: '荣誉', 18: '阅历', 22: '重铸石', 25: '魂玉',
                  26: '威望', 27: '晶石', 30: '英雄经验', 36: '天命经验', 37: '天命碎片', 39: '授业值'}


class GmError(Exception):
    """GM 请求非法或操作失败（返回 400）。"""


def check_rewards(rewards) -> list:
    if not isinstance(rewards, list) or not rewards:
        raise GmError('奖励列表不能为空')
    cleaned = []
    for item in rewards:
        if not isinstance(item, dict) or any(type(item.get(k)) is not int for k in ('Type', 'ID', 'Count')):
            raise GmError('每条奖励必须是含整数 Type / ID / Count 的对象')
        if item['Count'] <= 0:
            raise GmError('奖励数量必须大于 0')
        cleaned.append({'Type': item['Type'], 'ID': item['ID'], 'Count': item['Count']})
    return cleaned


class GmService:
    def __init__(self, app, announcement_file, mail_title: str, search_limit: int, portal: dict = None):
        self.app = app
        self.services = app.services
        self.model = app.services.growth.model if hasattr(app.services, 'growth') else None
        self.announcement_file = announcement_file
        self.mail_title = mail_title
        self.search_limit = search_limit
        self.portal = {**PORTAL_DEFAULTS, **(portal or {})}
        self.portal_sessions = {}  # token -> {'user': 游戏用户 ID, 'expires': 时间戳}
        self.started_at = int(time.time())

    # ---- 基础 -------------------------------------------------------------

    def _open(self, db, user_id: int):
        row = self.services.roles.repository.find(db, user_id)
        if row is None:
            raise GmError(f'玩家 {user_id} 不存在')
        state = self.services.roles.model.migrate(json.loads(row['state_json']))
        return row, state

    def _save(self, db, user_id: int, state: dict):
        self.services.roles.model.refresh_all(state)
        db.execute('UPDATE roles SET state_json = ? WHERE user_id = ?', (json.dumps(state, ensure_ascii=False), user_id))

    def _summary(self, db, row, state: dict) -> dict:
        team = self.services.roles.model.team(state)
        return {'userId': row['user_id'], 'name': state['Name'], 'level': state['PLevel'], 'vip': state.get('VipLevel', 0),
                'gold': state['Gold'], 'ingot': state['Ingot'], 'battlePower': team['battlePower'],
                'heroCount': len(state['ownedHeros']), 'banned': bool(state.get('Banned')),
                'createdAt': state.get('CreatedAt', 0), 'lastSeenAt': state.get('LastSeenAt', 0),
                'union': self.services.union.union_name(db, state)}

    def _item_name(self, kind, ident) -> str:
        if kind in RESOURCE_TYPES:
            return RESOURCE_TYPES[kind]
        table = CATALOG_TABLES.get(kind) or ({23: ('BaseFragments', 'name')}.get(kind))
        if table is None:
            return f'#{ident}'
        try:
            row = self.services.roles.model.catalog[table[0]].get(str(ident))
        except (KeyError, TypeError):
            return f'#{ident}'
        return str((row or {}).get(table[1], ident))

    def _hero_name(self, hero_id: int) -> str:
        row = self.services.roles.model.catalog['BaseHeros'].get(str(hero_id))
        return str((row or {}).get('name', hero_id))

    def _hero_row(self, hero: dict) -> dict:
        return {'heroId': hero['heroId'], 'name': self._hero_name(hero['heroId']), 'level': hero['level'],
                'rebirthCount': hero.get('rebirthCount', 0), 'battlePower': hero.get('battlePower', 0),
                'battleIx': hero.get('battleIx', 0), 'rageTrained': hero.get('rageTrained', 1)}

    def _mail_row(self, mail: dict) -> dict:
        return {'id': mail['PKID'], 'content': mail.get('MessageContent', ''), 'time': mail.get('SendTime', 0),
                'read': bool(mail.get('ReadingState')), 'hasAttachment': bool(mail.get('HaveAccessory')),
                'claimed': bool(mail.get('IsDealWith')), 'from': mail.get('NickName', ''),
                'attachments': list(mail.get('MailAccessory') or [])}

    def _progress_limits(self) -> dict:
        catalog = self.services.roles.model.catalog
        return {'firstStage': catalog.first_stage_id(), 'lastStage': max(map(int, catalog['BaseStages'])),
                'towerMax': int(self.app.config.features.tower['max_floor']),
                'guideStep': self.app.config.player.guide_protect_until_step,
                'playerMaxLevel': self.app.config.player.level_up.max_level}

    def _arena_rank(self, db, user_id: int) -> int:
        row = db.execute('SELECT rank FROM arena_ranks WHERE server_id = ? AND user_id = ?',
                         (self.services.arena.realm_id, user_id)).fetchone()
        return int(row['rank']) if row else 0

    def _progress(self, db, user_id: int, state: dict) -> dict:
        return {'maxStage': int((state.get('Map') or {}).get('MaxPID') or 0),
                'towerFloor': int((state.get('Tower') or {}).get('floor') or 0),
                'tiroMaxStep': int(state.get('TiroMaxStep') or 0),
                'arenaRank': self._arena_rank(db, user_id),
                'unionId': int((state.get('Union') or {}).get('id') or 0)}

    # ---- 概览 -------------------------------------------------------------

    def status(self) -> dict:
        day_ago = int(time.time()) - 86400
        active = banned = max_level = 0
        with self.app.storage.transaction() as db:
            players = db.execute('SELECT COUNT(*) FROM roles').fetchone()[0]
            accounts = db.execute('SELECT COUNT(*) FROM game_users').fetchone()[0]
            for (state_json,) in db.execute('SELECT state_json FROM roles'):
                state = json.loads(state_json)
                if state.get('LastSeenAt', 0) >= day_ago:
                    active += 1
                if state.get('Banned'):
                    banned += 1
                max_level = max(max_level, int(state.get('PLevel') or 0))
            unions = len(self.services.union._index(db))
        realm = self.app.config.server.realm
        return {'realm': {'id': realm.id, 'name': realm.name}, 'gameUrl': self.app.config.server.public_url,
                'players': players, 'accounts': accounts, 'active24h': active, 'banned': banned, 'maxLevel': max_level,
                'unions': unions, 'uptime': int(time.time()) - self.started_at, 'database': str(self.app.storage.path),
                'editableFields': EDITABLE_FIELDS, 'resourceTypes': RESOURCE_TYPES}

    # ---- 玩家 -------------------------------------------------------------

    def search_players(self, query: str) -> list:
        query = (query or '').strip()
        rows = []
        with self.app.storage.transaction() as db:
            if query.isdigit():
                sql = db.execute('SELECT * FROM roles WHERE user_id = ? OR nickname LIKE ? ORDER BY user_id LIMIT ?',
                                 (int(query), f'%{query}%', self.search_limit))
            elif query:
                sql = db.execute('SELECT * FROM roles WHERE nickname LIKE ? ORDER BY user_id LIMIT ?', (f'%{query}%', self.search_limit))
            else:
                sql = db.execute('SELECT * FROM roles ORDER BY user_id DESC LIMIT ?', (self.search_limit,))
            for row in sql.fetchall():
                state = self.services.roles.model.migrate(json.loads(row['state_json']))
                rows.append(self._summary(db, row, state))
        return rows

    def player_detail(self, user_id: int) -> dict:
        with self.app.storage.transaction() as db:
            row, state = self._open(db, user_id)
            view = self.services.roles.model.presentation(state)
            summary = self._summary(db, row, state)
            heroes = [self._hero_row(h) for h in state['ownedHeros']]
            others = [dict(item, name=self._item_name(item.get('Type'), item.get('ID'))) for item in view.get('Others', [])]
            fragments = [dict(item, name=self._item_name(23, item.get('ID'))) for item in view.get('Fragments', [])]
            mails = [self._mail_row(m) for m in state['Mail']['items'][:80]]
            card = state.get('MonthCard') or {}
            now = self.services.roles.model.clock.now()
            return {'summary': summary, 'resources': {k: state.get(k, 0) for k in EDITABLE_FIELDS},
                    'heroes': heroes, 'others': others, 'fragments': fragments,
                    'talismans': len(state.get('Talismans', {})), 'mails': mails, 'mailCount': len(state['Mail']['items']),
                    'banned': bool(state.get('Banned')), 'progress': self._progress(db, user_id, state),
                    'rechargeTotal': int((state.get('Recharge') or {}).get('total') or 0),
                    'monthCardLeft': max(0, int(card.get('month_until') or 0) - now),
                    'growupBought': bool((state.get('Growup') or {}).get('bought')),
                    'limits': self._progress_limits()}

    def update_player(self, user_id: int, fields: dict) -> dict:
        """改写资源 / 等级 / VIP；``Name`` 改名；``Banned`` 封禁开关。"""
        if not isinstance(fields, dict) or not fields:
            raise GmError('没有要修改的字段')
        with self.app.storage.transaction() as db:
            row, state = self._open(db, user_id)
            for key, value in fields.items():
                if key == 'Name':
                    name = str(value).strip()
                    if not name:
                        raise GmError('昵称不能为空')
                    if name != state['Name'] and self.services.roles.repository.nickname_taken(db, name):
                        raise GmError('昵称已被使用')
                    state['Name'] = name
                    self.services.roles.repository.rename(db, user_id, name)
                elif key == 'Banned':
                    state['Banned'] = 1 if value else 0
                elif key in EDITABLE_FIELDS:
                    if type(value) is not int or value < 0:
                        raise GmError(f'{EDITABLE_FIELDS[key]} 必须是非负整数')
                    state[key] = value
                    if key == 'PLevel':
                        model = self.services.roles.model
                        state['NextLvExp'] = model.config.level_up.exp_to_next(value)
                        state['MaxEnergy'] = model.config.energy.max_for_level(value)
                else:
                    raise GmError(f'不支持修改字段 {key}')
            self._save(db, user_id, state)
            return self._summary(db, row, state)

    def grant(self, user_id: int, rewards) -> dict:
        rewards = check_rewards(rewards)
        with self.app.storage.transaction() as db:
            row, state = self._open(db, user_id)
            try:
                outcome = self.services.growth.ledger.apply(state, rewards=rewards)
            except BusinessError as exc:
                raise GmError(str(exc))
            self._save(db, user_id, state)
            return {'granted': deepcopy(outcome.rewards), 'summary': self._summary(db, row, state)}

    def send_mail(self, user_id: int, content: str, attachments=None) -> dict:
        content = (content or '').strip()
        if not content:
            raise GmError('邮件内容不能为空')
        attachments = check_rewards(attachments) if attachments else []
        with self.app.storage.transaction() as db:
            row, state = self._open(db, user_id)
            mail = self.services.mail.send_system(state, content, attachments)
            self._save(db, user_id, state)
            return {'mail': mail, 'summary': self._summary(db, row, state)}

    def broadcast_mail(self, content: str, attachments=None) -> dict:
        content = (content or '').strip()
        if not content:
            raise GmError('邮件内容不能为空')
        attachments = check_rewards(attachments) if attachments else []
        count = 0
        with self.app.storage.transaction() as db:
            for (user_id,) in db.execute('SELECT user_id FROM roles').fetchall():
                _, state = self._open(db, user_id)
                self.services.mail.send_system(state, content, attachments)
                self._save(db, user_id, state)
                count += 1
        return {'sent': count}

    def reset_daily(self, user_id: int) -> dict:
        """清空每日计数（体力购买、招募、副本次数等），相当于跨天。"""
        with self.app.storage.transaction() as db:
            row, state = self._open(db, user_id)
            for key in ('Daily', 'Slave', 'Artifact', 'Havoc', 'XunFang', 'Fuben', 'Tower', 'Arena', 'Union', 'Destiny', 'Salary'):
                block = state.get(key)
                if isinstance(block, dict):
                    for day_key in ('day', 'last_day'):
                        if day_key in block:
                            block[day_key] = ''
                    for sub in block.values():
                        if isinstance(sub, dict) and 'day' in sub:
                            sub['day'] = ''
            self.services.roles.model.tick(state)
            self._save(db, user_id, state)
            return self._summary(db, row, state)

    def grant_hero(self, user_id: int, hero_id) -> dict:
        try:
            hero_id = int(hero_id)
        except (TypeError, ValueError):
            raise GmError('英雄 ID 必须是整数')
        with self.app.storage.transaction() as db:
            row, state = self._open(db, user_id)
            if str(hero_id) not in self.services.roles.model.catalog['BaseHeros']:
                raise GmError('英雄配置不存在')
            if self.services.roles.model.has_hero(state, hero_id):
                raise GmError('已拥有该主将')
            try:
                self.services.growth.ledger.apply(state, rewards=[dict(Type=7, ID=hero_id, Count=1)])
            except BusinessError as exc:
                raise GmError(str(exc))
            self._save(db, user_id, state)
            return {'heroId': hero_id, 'name': self._hero_name(hero_id), 'summary': self._summary(db, row, state)}

    def update_hero(self, user_id: int, body) -> dict:
        if not isinstance(body, dict):
            raise GmError('请求体必须是 JSON 对象')
        try:
            hero_id = int(body.get('heroId'))
        except (TypeError, ValueError):
            raise GmError('英雄 ID 必须是整数')
        with self.app.storage.transaction() as db:
            row, state = self._open(db, user_id)
            try:
                hero = self.services.roles.model.find_hero(state, hero_id)
            except BusinessError as exc:
                raise GmError(str(exc))
            heroes = self.services.roles.model.heroes
            template = heroes.template(hero_id)
            if 'level' in body:
                if type(body['level']) is not int or not 1 <= body['level'] <= state['PLevel']:
                    raise GmError(f'主将等级须在 1 到账户等级 {state["PLevel"]} 之间')
                hero['level'] = body['level']
                hero['curExp'] = 0
            if 'rebirthCount' in body:
                cap = heroes.rebirth_max(template)
                if type(body['rebirthCount']) is not int or not 0 <= body['rebirthCount'] <= cap:
                    raise GmError(f'进阶次数须在 0 到 {cap} 之间')
                hero['rebirthCount'] = body['rebirthCount']
            if 'rageTrained' in body:
                if type(body['rageTrained']) is not int or not 1 <= body['rageTrained'] <= hero['level']:
                    raise GmError(f'技能训练等级须在 1 到主将等级 {hero["level"]} 之间')
                hero['rageTrained'] = body['rageTrained']
            self._save(db, user_id, state)
            hero = self.services.roles.model.find_hero(state, hero_id)
            return {'hero': self._hero_row(hero), 'summary': self._summary(db, row, state)}

    def set_progress(self, user_id: int, fields) -> dict:
        if not isinstance(fields, dict) or not fields:
            raise GmError('没有要修改的进度')
        catalog = self.services.roles.model.catalog
        stages = set(map(int, catalog['BaseStages']))
        tower_max = int(self.app.config.features.tower['max_floor'])
        with self.app.storage.transaction() as db:
            row, state = self._open(db, user_id)
            if 'maxStage' in fields:
                if type(fields['maxStage']) is not int or fields['maxStage'] not in stages:
                    raise GmError('关卡不存在')
                state.setdefault('Map', {})['MaxPID'] = fields['maxStage']
            if 'towerFloor' in fields:
                if type(fields['towerFloor']) is not int or not 0 <= fields['towerFloor'] <= tower_max:
                    raise GmError(f'通天塔层数须在 0 到 {tower_max} 之间')
                tower = state.setdefault('Tower', {'day': '', 'floor': 0, 'score': 0, 'used': 0, 'buff_times': 0,
                                                   'bought': [], 'reward_floor': 0})
                tower['floor'] = fields['towerFloor']
                tower['reward_floor'] = min(int(tower.get('reward_floor') or 0), fields['towerFloor'])
            if 'tiroMaxStep' in fields:
                if type(fields['tiroMaxStep']) is not int or fields['tiroMaxStep'] < 0:
                    raise GmError('引导进度必须是非负整数')
                state['TiroMaxStep'] = fields['tiroMaxStep']
            self._save(db, user_id, state)
            return {'progress': self._progress(db, user_id, state), 'summary': self._summary(db, row, state)}

    def skip_guide(self, user_id: int) -> dict:
        step = self.app.config.player.guide_protect_until_step
        return self.set_progress(user_id, {'tiroMaxStep': step})

    def clear_mails(self, user_id: int) -> dict:
        with self.app.storage.transaction() as db:
            row, state = self._open(db, user_id)
            removed = len(state['Mail']['items'])
            state['Mail']['items'] = []
            self._save(db, user_id, state)
            return {'removed': removed, 'summary': self._summary(db, row, state)}

    def delete_mail(self, user_id: int, mail_id) -> dict:
        try:
            mail_id = int(mail_id)
        except (TypeError, ValueError):
            raise GmError('邮件 ID 必须是整数')
        with self.app.storage.transaction() as db:
            row, state = self._open(db, user_id)
            before = len(state['Mail']['items'])
            state['Mail']['items'] = [m for m in state['Mail']['items'] if m['PKID'] != mail_id]
            if len(state['Mail']['items']) == before:
                raise GmError('邮件不存在')
            self._save(db, user_id, state)
            return {'removed': 1, 'summary': self._summary(db, row, state)}

    def remove_bag_item(self, user_id: int, item) -> dict:
        if not isinstance(item, dict) or any(type(item.get(k)) is not int for k in ('Type', 'ID', 'Count')):
            raise GmError('须提供整数 Type / ID / Count')
        if item['Count'] <= 0:
            raise GmError('数量必须大于 0')
        with self.app.storage.transaction() as db:
            row, state = self._open(db, user_id)
            try:
                self.services.growth.ledger.apply(state, consume=[dict(Type=item['Type'], ID=item['ID'], Count=item['Count'])])
            except BusinessError as exc:
                raise GmError(str(exc))
            self._save(db, user_id, state)
            return {'summary': self._summary(db, row, state)}

    def credit_recharge(self, user_id: int, ingot) -> dict:
        try:
            ingot = int(ingot)
        except (TypeError, ValueError):
            raise GmError('充值元宝必须是整数')
        if ingot <= 0:
            raise GmError('充值元宝必须大于 0')
        with self.app.storage.transaction() as db:
            row, state = self._open(db, user_id)
            rec = self.services.activities._recharge(state)
            rec['total'] += ingot
            rec['max_single'] = max(int(rec.get('max_single') or 0), ingot)
            self.services.activities.apply_vip(state)
            try:
                self.services.growth.ledger.apply(state, rewards=[dict(Type=2, ID=0, Count=ingot)])
            except BusinessError as exc:
                raise GmError(str(exc))
            self._save(db, user_id, state)
            return {'rechargeTotal': rec['total'], 'vip': state.get('VipLevel', 0),
                    'summary': self._summary(db, row, state)}

    def grant_month_card(self, user_id: int, days) -> dict:
        try:
            days = int(days if days is not None else self.app.config.activities.month_card['month_days'])
        except (TypeError, ValueError, KeyError):
            days = 30
        if days <= 0:
            raise GmError('月卡天数必须大于 0')
        with self.app.storage.transaction() as db:
            row, state = self._open(db, user_id)
            card = self.services.activities._month_card(state)
            now = self.services.roles.model.clock.now()
            card['month_until'] = max(now, int(card.get('month_until') or 0)) + days * 86400
            self._save(db, user_id, state)
            return {'monthCardLeft': card['month_until'] - now, 'summary': self._summary(db, row, state)}

    def grant_growup(self, user_id: int) -> dict:
        with self.app.storage.transaction() as db:
            row, state = self._open(db, user_id)
            state.setdefault('Growup', {'bought': False, 'claimed': []})['bought'] = True
            self._save(db, user_id, state)
            return {'growupBought': True, 'summary': self._summary(db, row, state)}

    def leave_union(self, user_id: int) -> dict:
        with self.app.storage.transaction() as db:
            row, state = self._open(db, user_id)
            info = state.get('Union') or {}
            union_id = int(info.get('id') or 0)
            if not union_id:
                raise GmError('该玩家未加入仙盟')
            union = self.services.union._load(db, union_id)
            if union is None:
                info['id'] = 0
            else:
                if str(user_id) in union['members'] and self.services.union._position(union, user_id) == self.services.union.positions['leader'] and len(union['members']) > 1:
                    raise GmError('盟主请先转让职位或解散仙盟')
                self.services.union._remove_member(db, union, user_id, left=True)
                if union['members']:
                    self.services.union._save(db, union)
                else:
                    self.services.union.store.set(db, 'union:index', [i for i in self.services.union._index(db) if i != union_id])
                    self.services.union.store.delete_prefix(db, f'union:{union_id}')
                # _remove_member 另存了一份状态；这里同步本事务里的 Union，避免 _save 把退盟写回去
                info.update(id=0, left_at=self.services.roles.model.clock.now())
            self._save(db, user_id, state)
            return {'summary': self._summary(db, row, state)}

    def mail_many(self, user_ids, content: str, attachments=None) -> dict:
        content = (content or '').strip()
        if not content:
            raise GmError('邮件内容不能为空')
        if not isinstance(user_ids, list) or not user_ids:
            raise GmError('请提供玩家 ID 列表')
        ids = []
        for raw in user_ids:
            try:
                ids.append(int(raw))
            except (TypeError, ValueError):
                raise GmError('玩家 ID 必须是整数')
        attachments = check_rewards(attachments) if attachments else []
        sent, missing = 0, []
        with self.app.storage.transaction() as db:
            for uid in ids:
                try:
                    _, state = self._open(db, uid)
                except GmError:
                    missing.append(uid)
                    continue
                self.services.mail.send_system(state, content, attachments)
                self._save(db, uid, state)
                sent += 1
        return {'sent': sent, 'missing': missing}

    def union_detail(self, union_id: int) -> dict:
        with self.app.storage.transaction() as db:
            union = self.services.union._load(db, union_id)
            if union is None:
                raise GmError('仙盟不存在')
            members = []
            for uid, member in union['members'].items():
                try:
                    profile = self.services.union.directory.profile(db, int(uid))
                except BusinessError:
                    profile = {'Name': f'#{uid}', 'Level': 0, 'BattlePower': 0}
                members.append({'userId': int(uid), 'name': profile['Name'], 'level': profile.get('Level', 0),
                                'battlePower': profile.get('BattlePower', 0), 'position': member['position']})
            members.sort(key=lambda m: (m['position'], -m['battlePower']))
            return {'id': union['id'], 'name': union['name'], 'level': union['level'], 'coin': union['coin'],
                    'notice': union['notice'], 'outNotice': union.get('out_notice', ''),
                    'members': members, 'created': union['created'], 'leader': self.services.union._leader_name(db, union)}

    def update_union(self, union_id: int, fields) -> dict:
        if not isinstance(fields, dict) or not fields:
            raise GmError('没有要修改的字段')
        with self.app.storage.transaction() as db:
            union = self.services.union._load(db, union_id)
            if union is None:
                raise GmError('仙盟不存在')
            if 'notice' in fields:
                union['notice'] = str(fields['notice'] or '')
            if 'outNotice' in fields:
                union['out_notice'] = str(fields['outNotice'] or '')
            if 'coin' in fields:
                if type(fields['coin']) is not int or fields['coin'] < 0:
                    raise GmError('仙盟贡献必须是非负整数')
                union['coin'] = fields['coin']
            self.services.union._save(db, union)
            return {'id': union['id'], 'notice': union['notice'], 'outNotice': union.get('out_notice', ''),
                    'coin': union['coin']}

    def kick_union_member(self, union_id: int, user_id) -> dict:
        try:
            user_id = int(user_id)
        except (TypeError, ValueError):
            raise GmError('玩家 ID 必须是整数')
        with self.app.storage.transaction() as db:
            union = self.services.union._load(db, union_id)
            if union is None:
                raise GmError('仙盟不存在')
            if str(user_id) not in union['members']:
                raise GmError('该玩家不在此仙盟')
            if self.services.union._position(union, user_id) == self.services.union.positions['leader'] and len(union['members']) > 1:
                raise GmError('不能踢出仍有成员的盟主，请先解散或让其退盟')
            self.services.union._remove_member(db, union, user_id, left=True)
            if union['members']:
                self.services.union._save(db, union)
            else:
                self.services.union.store.set(db, 'union:index', [i for i in self.services.union._index(db) if i != union_id])
                self.services.union.store.delete_prefix(db, f'union:{union_id}')
            return {'kicked': user_id, 'members': len(union['members'])}

    def dissolve_union(self, union_id: int) -> dict:
        with self.app.storage.transaction() as db:
            union = self.services.union._load(db, union_id)
            if union is None:
                raise GmError('仙盟不存在')
            for uid in list(union['members']):
                self.services.union._remove_member(db, union, int(uid), left=False)
            self.services.union.store.set(db, 'union:index', [i for i in self.services.union._index(db) if i != union_id])
            self.services.union.store.delete_prefix(db, f'union:{union_id}')
            return {'dissolved': union_id}

    def arena_ranks(self, limit: int = 30) -> dict:
        limit = max(1, min(int(limit or 30), 80))
        rows = []
        with self.app.storage.transaction() as db:
            for rank in range(1, limit + 1):
                profile = self.services.arena._profile_at(db, rank)
                rows.append({'rank': profile['Ranking'], 'userId': profile['PlayerId'], 'name': profile['PlayerName'],
                             'level': profile['Level'], 'battlePower': profile['Fighting'],
                             'robot': int(profile['PlayerId']) >= 100_000_000})
        return {'ranks': rows}

    def max_out(self, user_id: int) -> dict:
        """一键全满：解锁全部主将、账户满级、培养拉满、穿戴缘分 / 专属法宝。"""
        with self.app.storage.transaction() as db:
            row, state = self._open(db, user_id)
            result = self._apply_max_out(state)
            self._save(db, user_id, state)
            result['summary'] = self._summary(db, row, state)
            return result

    def portal_maxout(self, user_id: int) -> dict:
        if not self.portal['enabled']:
            raise GmError('玩家自助门户未开启')
        if not self.portal.get('maxout'):
            raise GmError('一键全满未开启')
        with self.app.storage.transaction() as db:
            row, state = self._open(db, user_id)
            if state.get('Banned'):
                raise GmError('该角色已被封禁')
            result = self._apply_max_out(state)
            self._save(db, user_id, state)
            return {'player': self._summary(db, row, state), 'quota': self._portal_quota(state), **result}

    def _apply_max_out(self, state: dict) -> dict:
        """就地改写角色状态：满级、全英雄、培养满、缘分法宝穿齐。"""
        model = self.services.roles.model
        heroes = model.heroes
        equipment = model.equipment
        catalog = model.catalog
        player_level = model.config.level_up.max_level
        state['PLevel'] = player_level
        state['Exp'] = 0
        state['NextLvExp'] = model.config.level_up.exp_to_next(player_level)
        state['MaxEnergy'] = model.config.energy.max_for_level(player_level)
        state['Energy'] = state['MaxEnergy']
        state['TiroMaxStep'] = max(int(state.get('TiroMaxStep') or 0), model.config.guide_protect_until_step)

        owned_before = {h['heroId'] for h in state['ownedHeros']}
        for key in catalog['BaseHeros']:
            hero_id = int(key)
            if hero_id not in owned_before:
                model.add_hero(state, hero_id)

        train_cap = player_level * heroes.config.train_dimension_cap_per_level
        for hero in state['ownedHeros']:
            template = heroes.template(hero['heroId'])
            hero['level'] = player_level
            hero['curExp'] = 0
            hero['rebirthCount'] = heroes.rebirth_max(template)
            hero['trainDims'] = {dim: train_cap for dim in DIMENSIONS}
            hero['rageTrained'] = player_level
            hero['potency'] = 0

        try:
            pinjie_table = catalog['EquipPinjieType']
            max_pinjie = max(int(v) for v in pinjie_table.values()) if pinjie_table else 5
        except (KeyError, TypeError, ValueError):
            max_pinjie = 5
        forge_level = equipment.level_cap(player_level)
        slot_types = sorted(equipment.config.main_attributes_by_type)
        exclusive_index, generic_by_type = self._equip_indexes(catalog['BaseEquips'], slot_types)
        equipped = 0
        for hero in state['ownedHeros']:
            loadout = self._fate_loadout(hero['heroId'], catalog, exclusive_index, generic_by_type, slot_types)
            equipped += self._wear_loadout(state, hero, loadout, forge_level, max_pinjie)

        self._fill_team(state, player_level)
        return {'playerLevel': player_level, 'heroes': len(state['ownedHeros']),
                'newHeroes': len(state['ownedHeros']) - len(owned_before), 'talismansEquipped': equipped}

    @staticmethod
    def _exclusive_heroes(template) -> set:
        exclusive = template.get('herosId') or {}
        values = exclusive.values() if isinstance(exclusive, dict) else exclusive
        return {int(v) for v in values if v}

    def _equip_indexes(self, equips, slot_types):
        """专属法宝按英雄+部位建索引；无专属的按部位收集，供空槽补齐。"""
        exclusive_index, generic_by_type = {}, {t: [] for t in slot_types}
        for key, row in equips.items():
            equip_id, equip_type = int(key), int(row['equipType'])
            quality = int(row.get('quality') or 0)
            allowed = self._exclusive_heroes(row)
            if allowed:
                for hero_id in allowed:
                    exclusive_index.setdefault(hero_id, {}).setdefault(equip_type, []).append((quality, equip_id))
            elif equip_type in generic_by_type:
                generic_by_type[equip_type].append((quality, row.get('profession', 4), equip_id))
        return exclusive_index, generic_by_type

    def _fate_loadout(self, hero_id: int, catalog, exclusive_index, generic_by_type, slot_types) -> dict:
        """每个部位优先缘分（groupEquips），其次专属，再补职业匹配的高品质法宝。"""
        model = self.services.roles.model
        equips = catalog['BaseEquips']
        template = catalog['BaseHeros'][str(hero_id)]
        chosen = {}
        for item in model._equip_rows(template.get('groupEquips')):
            equip_id = int(item.get('equipId') or 0)
            row = equips.get(str(equip_id))
            if row:
                chosen[int(row['equipType'])] = equip_id
        exclusive = exclusive_index.get(hero_id, {})
        profession = template.get('profession')
        for equip_type in slot_types:
            if equip_type in chosen:
                continue
            if exclusive.get(equip_type):
                chosen[equip_type] = max(exclusive[equip_type])[1]
                continue
            fillers = generic_by_type.get(equip_type) or []
            if equip_type == 1:
                fillers = [x for x in fillers if x[1] in (0, 4, None, profession)]
            if fillers:
                chosen[equip_type] = max(fillers)[2]
        return chosen

    def _create_talisman(self, state: dict, equip_id: int, level: int, pinjie: int, hero_id: int) -> dict:
        """直接写入法宝实例，不受背包容量限制（一键全满会给全员穿齐）。"""
        equipment = self.services.roles.model.equipment
        bag = equipment.bag(state)
        ids = state.setdefault('NextIds', {})
        ids['equip'] = ids.get('equip', 0) + 1
        instance = equipment.build(equip_id, level, ids['equip'], hero_id, pinjie)
        self._max_feed(instance)
        equipment.compute(instance)
        bag[str(instance['equipUserId'])] = instance
        return instance

    def _max_feed(self, instance: dict):
        """把喂灵档位与加成一次推到模板最后一档（与逐次喂灵结果一致）。"""
        stages = self.services.roles.model.equipment.template(instance['equipId']).get('jieJiAttrs') or {}
        if not stages:
            return
        keys = sorted(int(k) for k in stages)
        bonus = {}
        for key in keys:
            stage = stages[str(key)]
            for column, attr in ATTR_BY_COLUMN.items():
                if stage.get(column) is not None:
                    bonus[attr] = int(stage[column])
            for name, value in DESC_ATTR.findall(str(stage.get('desc', ''))):
                bonus[ATTR_BY_NAME[name]] = bonus.get(ATTR_BY_NAME[name], 0) + int(value)
        instance['BreakthroughCount'] = keys[-1]
        instance['feedBonus'] = bonus

    def _wear_loadout(self, state: dict, hero: dict, loadout: dict, level: int, pinjie: int) -> int:
        equipment = self.services.roles.model.equipment
        bag = equipment.bag(state)
        worn = 0
        for equip_type, equip_id in loadout.items():
            instance = next((x for x in bag.values()
                             if x['equipId'] == equip_id and (not x.get('heroId') or x.get('heroId') == hero['heroId'])), None)
            if instance is None:
                instance = self._create_talisman(state, equip_id, level, pinjie, hero['heroId'])
            else:
                instance['level'] = max(int(instance.get('level') or 1), level)
                instance['pinJie'] = max(int(instance.get('pinJie') or 1), pinjie)
                instance['pinJieLevel'] = 0
                self._max_feed(instance)
                equipment.compute(instance)
            for other in list(equipment.equipped_by(state, hero['heroId'])):
                if other['equipUserId'] != instance['equipUserId'] and equipment.template(other['equipId'])['equipType'] == equip_type:
                    other['heroId'], other['isInTeam'] = 0, 0
            instance['heroId'], instance['isInTeam'] = hero['heroId'], 1
            worn += 1
        return worn

    def _fill_team(self, state: dict, player_level: int):
        """保留已上阵位，空位按品质 / 评级补最强未上阵主将。"""
        heroes = self.services.roles.model.heroes
        unlocked = heroes.unlocked_team_slots(player_level)
        occupied = {h.get('battleIx') for h in state['ownedHeros'] if h.get('battleIx')}
        unused = [h for h in state['ownedHeros'] if not h.get('battleIx')]
        unused.sort(key=lambda h: (heroes.template(h['heroId']).get('quality', 0),
                                   heroes.template(h['heroId']).get('rating', 0)), reverse=True)
        for pos in range(1, unlocked + 1):
            if pos in occupied or not unused:
                continue
            unused.pop(0)['battleIx'] = pos

    # ---- 静态表 -------------------------------------------------------------

    def search_items(self, item_type: int, query: str) -> list:
        catalog = self.services.roles.model.catalog
        if item_type in RESOURCE_TYPES:
            return [{'id': 0, 'name': RESOURCE_TYPES[item_type]}]
        table = CATALOG_TABLES.get(item_type)
        if table is None:
            raise GmError('该物品类型不支持检索')
        name_col = table[1]
        query = (query or '').strip()
        rows = []
        for key, row in catalog[table[0]].items():
            name = str(row.get(name_col, ''))
            if not query or query in name or query == str(key):
                rows.append({'id': int(key), 'name': name, 'quality': row.get('quality', 0)})
            if len(rows) >= 100:
                break
        return sorted(rows, key=lambda r: r['id'])

    # ---- 仙盟 / 公告 -----------------------------------------------------------

    def unions(self) -> list:
        rows = []
        with self.app.storage.transaction() as db:
            union_service = self.services.union
            for union_id in union_service._index(db):
                union = union_service._load(db, union_id)
                if union:
                    rows.append({'id': union['id'], 'name': union['name'], 'level': union['level'], 'coin': union['coin'],
                                 'members': len(union['members']), 'leader': union_service._leader_name(db, union),
                                 'notice': union['notice'], 'created': union['created']})
        return rows

    def get_announcement(self) -> str:
        try:
            return self.announcement_file.read_text(encoding='utf-8')
        except OSError:
            return ''

    def set_announcement(self, html: str) -> dict:
        if not isinstance(html, str):
            raise GmError('公告内容必须是字符串')
        self.announcement_file.write_text(html, encoding='utf-8')
        return {'bytes': len(html.encode('utf-8'))}

    # ---- 玩家自助门户 -----------------------------------------------------------

    def _portal_account(self, db, body: dict) -> int:
        """按登录方式解析出账号 ID：游客设备号，或注册邮箱 + 密码。"""
        udid = str(body.get('udid') or '').strip()
        if udid:
            row = db.execute('SELECT account_id FROM devices WHERE device = ?', (udid,)).fetchone()
            if row is None:
                raise GmError('没有找到该设备号对应的游客账号')
            return row['account_id']
        email = str(body.get('email') or '').strip()
        password = str(body.get('password') or '')
        if not email or not password:
            raise GmError('请填写设备号，或邮箱与密码')
        row = db.execute('SELECT * FROM accounts WHERE email = ?', (email,)).fetchone()
        if row is None:
            raise GmError('账号不存在')
        # 客户端注册时上送的是密码的 MD5；门户里玩家输入明文，这里先 MD5 再比对；
        # 若玩家直接输入 32 位十六进制，也按原样试一次
        account = self.services.account
        candidates = [hashlib.md5(password.encode('utf-8')).hexdigest()]
        if re.fullmatch(r'[0-9a-fA-F]{32}', password):
            candidates.append(password.lower())
        if not any(hmac.compare_digest(account._password_hash(c, row['password_salt']), row['password_hash'])
                   for c in candidates):
            raise GmError('密码错误')
        return row['id']

    def _portal_purge(self):
        now = int(time.time())
        for token in [t for t, s in self.portal_sessions.items() if s['expires'] <= now]:
            self.portal_sessions.pop(token, None)

    def portal_login(self, body) -> dict:
        if not self.portal['enabled']:
            raise GmError('玩家自助门户未开启')
        if not isinstance(body, dict):
            raise GmError('请求体必须是 JSON 对象')
        realm_id = self.app.config.server.realm.id
        with self.app.storage.transaction() as db:
            account_id = self._portal_account(db, body)
            user_row = db.execute('SELECT id FROM game_users WHERE account_id = ? AND server_id = ?',
                                  (account_id, realm_id)).fetchone()
            if user_row is None:
                raise GmError('该账号还没有进入过本服，请先在游戏里创建角色')
            user_id = user_row['id']
            row = self.services.roles.repository.find(db, user_id)
            if row is None:
                raise GmError('该账号在本服还没有角色，请先在游戏里创建角色')
            state = self.services.roles.model.migrate(json.loads(row['state_json']))
            if state.get('Banned'):
                raise GmError('该角色已被封禁')
            self._portal_purge()
            token = secrets.token_urlsafe(24)
            self.portal_sessions[token] = {'user': user_id, 'expires': int(time.time()) + int(self.portal['token_ttl'])}
            return {'token': token, 'player': self._summary(db, row, state), 'quota': self._portal_quota(state)}

    def portal_user(self, token: str):
        """门户令牌 → 游戏用户 ID；无效返回 None。"""
        self._portal_purge()
        session = self.portal_sessions.get(token or '')
        return session['user'] if session else None

    def _portal_quota(self, state: dict) -> dict:
        day = self.services.roles.model.clock.day_key()
        block = state.get('PortalGrants') or {}
        used = block.get('used', 0) if block.get('day') == day else 0
        daily = int(self.portal['daily_mails'])
        return {'daily': daily, 'used': used, 'remaining': max(0, daily - used),
                'maxLines': int(self.portal['max_lines']), 'maxCount': int(self.portal['max_count'])}

    def portal_me(self, user_id: int) -> dict:
        with self.app.storage.transaction() as db:
            row, state = self._open(db, user_id)
            return {'player': self._summary(db, row, state), 'quota': self._portal_quota(state),
                    'resourceTypes': RESOURCE_TYPES}

    def portal_send(self, user_id: int, rewards) -> dict:
        if not self.portal['enabled']:
            raise GmError('玩家自助门户未开启')
        rewards = check_rewards(rewards)
        if len(rewards) > int(self.portal['max_lines']):
            raise GmError(f"一次最多发 {self.portal['max_lines']} 种物品")
        if any(r['Count'] > int(self.portal['max_count']) for r in rewards):
            raise GmError(f"单种物品数量不能超过 {self.portal['max_count']}")
        with self.app.storage.transaction() as db:
            row, state = self._open(db, user_id)
            if state.get('Banned'):
                raise GmError('该角色已被封禁')
            day = self.services.roles.model.clock.day_key()
            block = state.setdefault('PortalGrants', {'day': day, 'used': 0})
            if block.get('day') != day:
                block.update(day=day, used=0)
            if block['used'] >= int(self.portal['daily_mails']):
                raise GmError('今日自助发放次数已用完')
            mail = self.services.mail.send_system(state, str(self.portal['mail_content']), rewards)
            block['used'] += 1
            self._save(db, user_id, state)
            return {'mail': mail, 'quota': self._portal_quota(state), 'player': self._summary(db, row, state)}
