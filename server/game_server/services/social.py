"""炼化炉（/RefiningFurnace/*）、好友（/Friend/*）、运镖（/Transport/*）。

炼化：主将/将魂返还魂玉，绿蓝装备返银币，紫橙装备返喂灵石，碎片返银币；重生把主将/装备回到 1 级并返还部分材料。
好友：基于 ``friendships`` 表的真实好友关系（申请 / 同意 / 拒绝 / 删除），推荐列表优先真实玩家、不足时补机器人；
体力赠送记录在 ``friend_presents`` 表，对方领取时获得体力。
运镖：召唤/刷新马匹、选择目的地开始运镖、到时或提前结束领取银币；地图上显示其他玩家在途的镖车，可劫镖（与对方阵容战斗）。
"""
from copy import deepcopy
import json
import math

from ..config import thaw
from ..errors import BusinessError
from .base import Reply, RoleContext, decode_text, global_block
from .battle import BattleEngine, ENEMY_POSITIONS
from .clock import Clock
from .inventory import Ledger
from .player_state import PlayerModel
from .players import Friendships, PlayerDirectory, ROBOT_BASE

HORSE_NAMES = {1: '木船', 2: '花船', 3: '虎船', 4: '凤船', 5: '龙船'}
DEST_NAMES = {1: '锁仙殿', 2: '离火岛'}
DEFAULT_AVATAR = 101
NPC_ROBOT_OFFSET = 200


class RefineService:
    def __init__(self, config, model: PlayerModel, ledger: Ledger, equipment):
        self.config = config
        self.model = model
        self.ledger = ledger
        self.equipment = equipment
        self.catalog = model.catalog

    @staticmethod
    def _entries(raw: str) -> list:
        return [part for part in (raw or '').split(';') if part.strip()]

    def refine(self, ctx: RoleContext, params) -> Reply:
        """``/RefiningFurnace/Refine?heros&souls&talismans&fragments``。"""
        state = ctx.state
        cfg = self.config
        rewards, consume, removed_heroes = [], [], []
        for raw in self._entries(params.get('heros')):
            hero = self.model.find_hero(state, self.ledger.positive(raw))
            if hero.get('battleIx', 0) > 0:
                raise BusinessError('上阵主将不能炼化')
            if hero['heroId'] in self.model.starter_ids():
                raise BusinessError('初始主将不能炼化')
            quality = self.model.heroes.template(hero['heroId'])['quality']
            rewards.append(dict(Type=25, ID=0, Count=int(cfg['soul_jade_by_quality'].get(str(quality), 1)) * (1 + hero.get('rebirthCount', 0))))
            removed_heroes.append(hero['heroId'])
        for raw in self._entries(params.get('souls')):
            soul_id, count = (raw.split(',') + ['1'])[:2]
            soul_id, count = self.ledger.positive(soul_id), self.ledger.positive(count)
            figure = self.catalog['BaseSouls'].get(str(soul_id))
            if figure is None:
                raise BusinessError('将魂不存在')
            quality = self.model.heroes.template(int(figure['figureId']))['quality']
            consume.append(dict(Type=4, ID=soul_id, Count=count))
            rewards.append(dict(Type=25, ID=0, Count=max(1, int(cfg['soul_jade_by_quality'].get(str(quality), 1)) * count // 10)))
        for raw in self._entries(params.get('talismans')):
            instance = self.equipment.get(state, self.ledger.positive(raw))
            if instance.get('heroId'):
                raise BusinessError('请先卸下法宝')
            quality = self.equipment.template(instance['equipId'])['quality']
            if str(quality) in cfg['equip_feed_stone_by_quality']:
                rewards.append(dict(Type=6, ID=200128, Count=int(cfg['equip_feed_stone_by_quality'][str(quality)])))
            else:
                rewards.append(dict(Type=1, ID=0, Count=int(cfg['equip_gold_by_quality'].get(str(quality), 500))))
            consume.append(dict(Type=10, ID=instance['equipUserId'], Count=1))
        for raw in self._entries(params.get('fragments')):
            fragment_id, count = (raw.split(',') + ['1'])[:2]
            fragment_id, count = self.ledger.positive(fragment_id), self.ledger.positive(count)
            consume.append(dict(Type=23, ID=fragment_id, Count=count))
            rewards.append(dict(Type=1, ID=0, Count=int(cfg['fragment_gold']) * count))
        if not rewards:
            raise BusinessError('请选择要炼化的物品')
        outcome = self.ledger.apply(state, rewards=rewards, consume=consume)
        for hero_id in removed_heroes:
            state['ownedHeros'] = [h for h in state['ownedHeros'] if h['heroId'] != hero_id]
            state['partnerTeam'] = [p for p in state['partnerTeam'] if p.get('HeroID') != hero_id]
        return Reply({'Reward': deepcopy(outcome.rewards)}, self.ledger.global_for(state, outcome))

    def rebirth(self, ctx: RoleContext, params) -> Reply:
        """``/RefiningFurnace/Rebirth?heroID&talismanID``：重生主将或法宝。"""
        state = ctx.state
        cfg = self.config
        hero_raw, equip_raw = params.get('heroID') or '', params.get('talismanID') or ''
        if hero_raw:
            hero = self.model.find_hero(state, self.ledger.positive(hero_raw))
            template = self.model.heroes.template(hero['heroId'])
            quality = str(template['quality'])
            cost = int(cfg['hero_rebirth_ingot'].get(quality, 0)) + int(cfg['hero_rebirth_ingot_per_stage'].get(quality, 0)) * hero.get('rebirthCount', 0)
            rewards = []
            for stage in range(1, hero.get('rebirthCount', 0) + 1):
                data = self.model.heroes.rebirth_stage(template, stage)
                if data.get('soulId') and data.get('soulCount'):
                    rewards.append(dict(Type=4, ID=int(data['soulId']), Count=int(data['soulCount'])))
            outcome = self.ledger.apply(state, rewards=rewards, consume=[dict(Type=2, ID=0, Count=cost)] if cost else [])
            hero = self.model.find_hero(state, hero['heroId'])
            hero.update(level=1, curExp=0, rebirthCount=0, potency=0, rageSkillLevel=1,
                        trainDims={k: 0 for k in hero.get('trainDims', {})})
            self.model.refresh_hero(state, hero)
            outcome.heros.append(deepcopy(hero))
            return Reply({'Reward': deepcopy(outcome.rewards)}, self.ledger.global_for(state, outcome, Slots=self.model.slots(state)))
        if equip_raw:
            instance = self.equipment.get(state, self.ledger.positive(equip_raw))
            quality = str(self.equipment.template(instance['equipId'])['quality'])
            cost = int(cfg['equip_rebirth_ingot'].get(quality, 0))
            refund = 0
            probe = dict(instance, level=1)
            for _ in range(instance['level'] - 1):
                refund += self.equipment.intensify_cost(probe)
                probe['level'] += 1
            refund = int(refund * cfg['intensify_refund_ratio'])
            outcome = self.ledger.apply(state, rewards=[dict(Type=1, ID=0, Count=refund)] if refund else [],
                                        consume=[dict(Type=2, ID=0, Count=cost)] if cost else [])
            instance = self.equipment.get(state, instance['equipUserId'])
            instance.update(level=1, pinJie=1, pinJieLevel=0)
            self.equipment.compute(instance)
            if instance.get('heroId'):
                self.model.refresh_hero(state, self.model.find_hero(state, instance['heroId']))
            block = self.ledger.global_for(state, outcome, Slots=self.model.slots(state))
            block['Talismans'] = [deepcopy(instance)]
            return Reply({'Reward': deepcopy(outcome.rewards)}, block)
        raise BusinessError('请选择要重生的主将或法宝')


class FriendService:
    def __init__(self, config, model: PlayerModel, ledger: Ledger, clock: Clock, directory: PlayerDirectory,
                 friendships: Friendships, mail):
        self.config = config
        self.model = model
        self.ledger = ledger
        self.clock = clock
        self.directory = directory
        self.friendships = friendships
        self.mail = mail

    def enrich(self, db, state: dict):
        """加载角色时写入待处理的好友申请数，供 Notify 红点使用。"""
        state['FriendRequestCount'] = len(self.friendships.requests_to(db, state['ID']))

    def notify(self, state: dict) -> dict:
        return {'Friend': state.get('FriendRequestCount', 0)}

    def _card(self, db, player_id: int, me: int) -> dict:
        profile = self.directory.profile(db, player_id)
        rebirth = int(profile.get('RebirthCount') or 0)
        return dict(userId=player_id, name=profile['Name'], level=profile['Level'], battlePower=profile['BattlePower'],
                    headerId=profile['Avatar'], rebirthCount=rebirth, BreakthroughCount=rebirth,
                    weaponId=int(profile.get('WeaponId') or 0), pinJie=int(profile.get('PinJie') or 1),
                    presentState=1 if self.friendships.presented_today(db, me, player_id, self.clock.day_key()) else 0)

    def friends(self, ctx: RoleContext, params) -> dict:
        """``/Friend/Friends``。"""
        cards = []
        for friend_id in self.friendships.friends_of(ctx.db, ctx.user):
            try:
                cards.append(self._card(ctx.db, friend_id, ctx.user))
            except BusinessError:
                continue
        return {'friendList': cards, 'friendCountMax': self.config['friend_count_max'],
                'requestCount': len(self.friendships.requests_to(ctx.db, ctx.user)),
                'getEnergyNumber': self._remaining_gets(ctx.state)}

    def requests(self, ctx: RoleContext, params) -> list:
        """``/Friend/RequestFriends``：收到的申请。"""
        rows = []
        for requester, message in self.friendships.requests_to(ctx.db, ctx.user):
            try:
                rows.append(dict(self._card(ctx.db, requester, ctx.user), content=message))
            except BusinessError:
                continue
        return rows

    def recommend(self, ctx: RoleContext, params) -> list:
        """``/Friend/RecommendFriends``：优先其他真实玩家，不足时补机器人。"""
        db, me = ctx.db, ctx.user
        known = set(self.friendships.friends_of(db, me)) | {r for r, _ in self.friendships.requests_to(db, me)}
        rows = []
        for user_id in self.directory.all_user_ids(db):
            if user_id != me and user_id not in known and self.friendships.status(db, me, user_id) is None:
                rows.append(self._card(db, user_id, me))
            if len(rows) >= 8:
                break
        for index, robot in enumerate(self.config['recommend_robots'], 1):
            if len(rows) >= 8:
                break
            rows.append(dict(userId=ROBOT_BASE + index, name=robot['name'], level=robot['level'],
                             battlePower=robot['battlePower'], headerId=robot['headerId'], presentState=1,
                             **PlayerDirectory.figure_of({})))
        return rows

    def add_request(self, ctx: RoleContext, params) -> dict:
        """``/Friend/AddMail?friendId``：发送申请；机器人自动同意。"""
        friend_id = self.ledger.positive(params.get('friendId') or '0')
        if friend_id == ctx.user:
            raise BusinessError('不能添加自己')
        if len(self.friendships.friends_of(ctx.db, ctx.user)) >= self.config['friend_count_max']:
            raise BusinessError('好友数量已达上限')
        now = self.clock.now()
        if self.directory.is_robot(friend_id):
            self.friendships.request(ctx.db, friend_id, ctx.user, '', now)
            self.friendships.accept(ctx.db, ctx.user, friend_id, now)
        else:
            self.directory.profile(ctx.db, friend_id)
            self.friendships.request(ctx.db, ctx.user, friend_id, decode_text(params.get('message') or ''), now)
        return {}

    def accept(self, ctx: RoleContext, params) -> dict:
        self.friendships.accept(ctx.db, ctx.user, self.ledger.positive(params.get('friendId') or '0'), self.clock.now())
        return {}

    def remove(self, ctx: RoleContext, params) -> dict:
        self.friendships.remove(ctx.db, ctx.user, self.ledger.positive(params.get('friendId') or '0'))
        return {}

    def present(self, ctx: RoleContext, params) -> dict:
        """``/Friend/Present?frinendID``：赠送体力（对方领取时获得）。"""
        friend_id = self.ledger.positive(params.get('frinendID') or '0')
        if self.friendships.status(ctx.db, ctx.user, friend_id) != 'accepted':
            raise BusinessError('对方不是你的好友')
        self.friendships.present(ctx.db, ctx.user, friend_id, self.clock.day_key(), self.clock.now())
        return {}

    def _remaining_gets(self, state: dict) -> int:
        return max(0, self.config['daily_energy_gets'] - state['Daily'].get('friend_gets', 0))

    def presents(self, ctx: RoleContext, params) -> dict:
        """``/Friend/PresentsInfo``。"""
        rows = []
        today = self.clock.day_key()
        for present in self.friendships.unclaimed_presents(ctx.db, ctx.user):
            try:
                profile = self.directory.profile(ctx.db, present['from_id'])
            except BusinessError:
                continue
            rows.append(dict(id=present['id'], userId=present['from_id'], name=profile['Name'], level=profile['Level'],
                             battlePower=profile['BattlePower'], headerId=profile['Avatar'],
                             days=0 if present['day'] == today else 1))
        return {'presents': rows, 'remainGetTime': self._remaining_gets(ctx.state)}

    def _claim(self, ctx: RoleContext, present_ids) -> Reply:
        state = ctx.state
        remaining = self._remaining_gets(state)
        if remaining <= 0:
            raise BusinessError('今日领取体力次数已用完')
        count = self.friendships.claim(ctx.db, ctx.user, list(present_ids)[:remaining])
        if count == 0:
            raise BusinessError('没有可领取的体力')
        outcome = self.ledger.apply(state, rewards=[dict(Type=9, ID=0, Count=self.config['present_energy'] * count)])
        state['Daily']['friend_gets'] = state['Daily'].get('friend_gets', 0) + count
        return Reply(self.presents(ctx, {}), self.ledger.global_for(state, outcome))

    def get_present(self, ctx: RoleContext, params) -> Reply:
        return self._claim(ctx, [self.ledger.positive(params.get('id') or '0')])

    def get_all_presents(self, ctx: RoleContext, params) -> Reply:
        return self._claim(ctx, [p['id'] for p in self.friendships.unclaimed_presents(ctx.db, ctx.user)])

    def send_mail(self, ctx: RoleContext, params) -> dict:
        """``/Friend/SendMail?friendId``：给好友发站内信。"""
        friend_id = self.ledger.positive(params.get('friendId') or '0')
        if self.directory.is_robot(friend_id):
            return {}
        target = self.directory.load_state(ctx.db, friend_id)
        if target is None:
            raise BusinessError('玩家不存在')
        self.mail.send_player(target, ctx.state, decode_text(params.get('message') or params.get('mailContent') or ''))
        self.directory.save_state(ctx.db, friend_id, target)
        return {}

class TransportService:
    def __init__(self, config, model: PlayerModel, ledger: Ledger, clock: Clock, engine: BattleEngine,
                 directory: PlayerDirectory, friendships: Friendships = None):
        self.config = config
        self.model = model
        self.ledger = ledger
        self.clock = clock
        self.engine = engine
        self.directory = directory
        self.friendships = friendships

    def _state(self, state: dict) -> dict:
        tr = state.setdefault('Transport', {'day': '', 'used': 0, 'rob_used': 0, 'refreshes': 0, 'horse': 1,
                                            'run': None, 'reward': None, 'logs': [], 'unread': 0,
                                            'bless': {'level': 1, 'exp': 0, 'used': {}}, 'npcs': []})
        tr.setdefault('bless', {'level': 1, 'exp': 0, 'used': {}})
        tr.setdefault('npcs', [])
        if tr.get('day') != self.clock.day_key():
            tr.update(day=self.clock.day_key(), used=0, rob_used=0, refreshes=0)
            tr['bless']['used'] = {}
        self._settle(state, tr)
        return state['Transport']

    def _settle(self, state: dict, tr: dict):
        run = tr.get('run')
        if run and self.clock.now() >= run['end']:
            self._finish(state, tr)

    def _pending_reward(self, tr: dict):
        reward = tr.get('reward')
        if not isinstance(reward, dict) or 'Gold' not in reward:
            if reward:
                tr['reward'] = None
            return None
        return reward

    def _finish(self, state: dict, tr: dict):
        """到站结算。``ledger.apply`` 会 deepcopy 后整表写回，必须改回写后的 ``Transport``，否则 run 清不掉，进镖局会反复弹 getReward。"""
        run = tr['run']
        gold = max(0, int(run.get('gold') or 0) - int(run.get('lost') or 0))
        surprise = []
        horse_id = int(run.get('horse') or 1)
        address = int(run.get('address') or 1)
        horse_cfg = self.config['horses'].get(str(horse_id)) or self.config['horses']['1']
        if int(horse_cfg.get('HaveSreward') or 0):
            surprise = [dict(item) for item in self.config.get('surprise_reward') or [{'Type': 2, 'ID': 0, 'Count': 10}]]
        rewards = ([dict(Type=1, ID=0, Count=gold)] if gold else []) + surprise
        self.ledger.apply(state, rewards=rewards)
        tr = state['Transport']
        tr['reward'] = {'BeRobedTime': int(run.get('robbed') or 0), 'LostGold': int(run.get('lost') or 0),
                        'Gold': gold, 'SurpriseReward': surprise if surprise else None}
        if surprise:
            extra = '、'.join(str(item.get('Count', 0)) for item in surprise)
            self._log(tr, 103, {'HORSE': HORSE_NAMES.get(horse_id, HORSE_NAMES[1]),
                                'ADDR': DEST_NAMES.get(address, DEST_NAMES[1]), 'GD': gold, 'EXT': extra})
        else:
            self._log(tr, 104, {'HORSE': HORSE_NAMES.get(horse_id, HORSE_NAMES[1]),
                                'ADDR': DEST_NAMES.get(address, DEST_NAMES[1]), 'GD': gold})
        tr['run'] = None

    def _log(self, tr: dict, kind: int, content: dict, now: int = 0):
        tr.setdefault('logs', []).insert(0, {'Times': now or self.clock.now(),
                                             'Content': json.dumps(content, ensure_ascii=False), 'Type': kind})
        tr['logs'] = tr['logs'][:30]
        tr['unread'] = tr.get('unread', 0) + 1

    def _horse_gold(self, state: dict, horse: int) -> int:
        return int(self.config['horses'][str(horse)]['Gold']) + int(self.config['gold_per_level']) * state['PLevel']

    def _horse_list(self, state: dict) -> list:
        """JSON 数组，对应客户端 ``HorseLst[1..5]``（对象键 ``\"1\"`` 在 Lua 里取不到）。"""
        rows = []
        for index in range(1, 6):
            item = self.config['horses'][str(index)]
            rows.append(dict(Gold=self._horse_gold(state, index), HaveSreward=item['HaveSreward'],
                             CallCost=item['CallCost'], Knowledge=int(item.get('Knowledge') or 0)))
        return rows

    def _dest_list(self) -> list:
        rows = []
        for index in (1, 2):
            dest = self.config['destinations'][str(index)]
            rows.append({'Times': dest['seconds'] // 60})
        return rows

    def _avatar(self, state: dict) -> int:
        lead = self.model.team_heroes(state)
        hero_id = int(lead[0]['heroId']) if lead else 0
        return hero_id if hero_id > 0 else DEFAULT_AVATAR

    def _horse_info(self, state: dict, run: dict) -> dict:
        return dict(HourseType=int(run['horse']), AdressId=int(run['address']),
                    HaveTime=Clock.remaining(run['end'], self.clock.now()),
                    PlayerID=str(state['ID']), PlayerName=state['Name'], Plv=state['PLevel'],
                    AvatarId=self._avatar(state), TotalPower=self.model.team(state)['battlePower'],
                    BeRobedTime=run.get('robbed', 0), TotalCanBeRobedTime=self.config['max_robbed_times'],
                    RobRewardGold=int(run['gold'] * self.config['rob_ratio']))

    def _npc_info(self, npc: dict) -> dict:
        return dict(HourseType=int(npc['horse']), AdressId=int(npc['address']),
                    HaveTime=Clock.remaining(npc['end'], self.clock.now()),
                    PlayerID=str(npc['id']), PlayerName=npc['name'], Plv=npc['level'],
                    AvatarId=int(npc['avatar'] or DEFAULT_AVATAR), TotalPower=npc['power'],
                    BeRobedTime=npc.get('robbed', 0), TotalCanBeRobedTime=self.config['max_robbed_times'],
                    RobRewardGold=int(npc['gold'] * self.config['rob_ratio']))

    def _roll_horse(self) -> int:
        weights = self.config['horse_weights']
        return int(self.ledger.rng.choices(list(weights), weights=list(weights.values()), k=1)[0])

    def _refresh_npcs(self, ctx: RoleContext, tr: dict):
        """地图 NPC 镖车；存在 ``tr.npcs`` 里，劫镖时按 ID 查找。"""
        now = self.clock.now()
        count = int(self.config.get('npc_count') or 8)
        npcs = []
        for index in range(count):
            robot_id = ROBOT_BASE + NPC_ROBOT_OFFSET + index + 1
            try:
                profile = self.directory.profile(ctx.db, robot_id)
            except BusinessError:
                continue
            horse = 1 + (index % 5)
            address = 1 if index % 3 else 2
            dest = self.config['destinations'][str(address)]
            remain = max(30, int(dest['seconds'] * (0.25 + 0.7 * ((index * 37) % 100) / 100)))
            gold = int(self._horse_gold(ctx.state, horse) * dest['multiplier'] * 0.6)
            npcs.append({'id': robot_id, 'name': profile['Name'], 'level': profile['Level'],
                         'avatar': int(profile.get('Avatar') or DEFAULT_AVATAR), 'power': profile['BattlePower'],
                         'horse': horse, 'address': address, 'end': now + remain, 'gold': gold, 'robbed': 0, 'lost': 0})
        tr['npcs'] = npcs

    def _others_running(self, db, me: int) -> list:
        result = []
        for user_id in self.directory.all_user_ids(db):
            if user_id == me:
                continue
            other = self.directory.load_state(db, user_id)
            run = (other or {}).get('Transport', {}).get('run')
            if run and self.clock.now() < run['end']:
                result.append((other, run))
        return result

    def _bless_view(self, bless: dict) -> dict:
        cfg = self.config.get('bless') or {}
        level = max(1, int(bless.get('level') or 1))
        used = bless.get('used') or {}
        return {'incenseLevel': level, 'curExp': int(bless.get('exp') or 0),
                'upgradeExp': int(cfg.get('exp_per_level') or 2000) * level,
                'transportAddition': (level - 1) * int(cfg.get('addition_per_level') or 2),
                'tenEnable': 0 if used.get('4') else 1, 'hundredEnable': 0 if used.get('5') else 1,
                'thousandEnable': 0 if used.get('6') else 1}

    def _friend_ids(self, raw) -> list:
        return [self.ledger.positive(part) for part in str(raw or '').split(',') if part.strip()][:3]

    def _friend_bonus(self, db, my_power: int, friend_ids) -> float:
        bonus = 0.0
        for friend_id in friend_ids:
            try:
                profile = self.directory.profile(db, friend_id)
            except BusinessError:
                continue
            ratio = profile['BattlePower'] / max(1, my_power) * 0.1
            bonus += min(0.2, max(0.01, ratio)) * 100
        return bonus

    def info(self, ctx: RoleContext, params) -> dict:
        """``/Transport/GetPlayerTransportInfo``。"""
        state = ctx.state
        tr = self._state(state)
        cfg = self.config
        run = tr.get('run')
        pending = self._pending_reward(tr)
        have_time = Clock.remaining(run['end'], self.clock.now()) if run else (0 if pending else -1)
        result = {'HaveTime': have_time,
                  'HaveTransTime': max(0, cfg['daily_transport_times'] - tr['used']),
                  'HaveRobTime': max(0, cfg['daily_rob_times'] - tr['rob_used']),
                  'IsHaveUnReadLog': 1 if tr.get('unread') else 0, 'horseInfos': [], 'budgetReward': {}}
        if run:
            result['horseInfos'].append(self._horse_info(state, run))
            result['budgetReward'] = {'Gold': run['gold'],
                                      'HaveSreward': cfg['horses'][str(run['horse'])]['HaveSreward'],
                                      'Addition': int(run.get('addition') or 0)}
        for other, other_run in self._others_running(ctx.db, ctx.user):
            result['horseInfos'].append(self._horse_info(other, other_run))
        self._refresh_npcs(ctx, tr)
        result['horseInfos'].extend(self._npc_info(npc) for npc in tr['npcs']
                                    if Clock.remaining(npc['end'], self.clock.now()) > 0)
        if pending:
            result['getReward'] = tr.pop('reward')
        return result

    def select(self, ctx: RoleContext, params) -> dict:
        state = ctx.state
        tr = self._state(state)
        cfg = self.config
        return {'HorseType': tr['horse'], 'Blessing': self._bless_view(tr['bless'])['transportAddition'],
                'HaveTransTime': max(0, cfg['daily_transport_times'] - tr['used']),
                'HaveRefreshTime': max(0, cfg['free_refresh_times'] - tr['refreshes']),
                'RefreshNeedIngot': 0 if tr['refreshes'] < cfg['free_refresh_times'] else cfg['refresh_ingot'],
                'HorseLst': self._horse_list(state), 'AddLst': self._dest_list()}

    def refresh_horse(self, ctx: RoleContext, params) -> Reply:
        tr = self._state(ctx.state)
        cfg = self.config
        cost = 0 if tr['refreshes'] < cfg['free_refresh_times'] else cfg['refresh_ingot']
        outcome = self.ledger.apply(ctx.state, consume=[dict(Type=2, ID=0, Count=cost)] if cost else [])
        tr = self._state(ctx.state)
        tr['refreshes'] += 1
        tr['horse'] = self._roll_horse()
        return Reply({'type': tr['horse']}, self.ledger.global_for(ctx.state, outcome))

    def call_horse(self, ctx: RoleContext, params) -> Reply:
        horse = params['type']
        if str(horse) not in self.config['horses']:
            raise BusinessError('马匹类型不存在')
        cost = int(self.config['horses'][str(horse)]['CallCost']) or int(self.config['call_horse_ingot'])
        outcome = self.ledger.apply(ctx.state, consume=[dict(Type=2, ID=0, Count=cost)])
        self._state(ctx.state)['horse'] = horse
        return Reply({'type': horse}, self.ledger.global_for(ctx.state, outcome))

    def start(self, ctx: RoleContext, params) -> Reply:
        state = ctx.state
        tr = self._state(state)
        cfg = self.config
        dest = cfg['destinations'].get(str(params['addresId']))
        if dest is None:
            raise BusinessError('目的地不存在')
        if tr.get('run'):
            raise BusinessError('已有镖车在途')
        if tr['used'] + dest['times'] > cfg['daily_transport_times']:
            raise BusinessError('今日运镖次数不足')
        friends = self._friend_ids(params.get('friendIds'))
        addition = self._friend_bonus(ctx.db, self.model.team(state)['battlePower'], friends)
        blessing = self._bless_view(tr['bless'])['transportAddition']
        gold = int(self._horse_gold(state, tr['horse']) * dest['multiplier'] * (1 + blessing / 100) * (1 + addition / 100))
        tr['used'] += dest['times']
        now = self.clock.now()
        tr['run'] = {'horse': tr['horse'], 'address': params['addresId'], 'start': now, 'end': now + dest['seconds'],
                     'gold': gold, 'robbed': 0, 'lost': 0, 'addition': int(addition), 'friends': friends}
        tr['horse'] = 1
        return Reply(self.info(ctx, params))

    def end(self, ctx: RoleContext, params) -> Reply:
        state = ctx.state
        tr = self._state(state)
        run = tr.get('run')
        if not run:
            raise BusinessError('当前没有运镖')
        cost = math.ceil(Clock.remaining(run['end'], self.clock.now()) / 60) * int(self.config['early_end_ingot_per_minute'])
        outcome = self.ledger.apply(state, consume=[dict(Type=2, ID=0, Count=cost)] if cost else [])
        tr = self._state(state)
        if tr.get('run'):
            self._finish(state, tr)
        return Reply(self.info(ctx, params), self.ledger.global_for(state, outcome))

    def bless_info(self, ctx: RoleContext, params) -> dict:
        return self._bless_view(self._state(ctx.state)['bless'])

    def bless(self, ctx: RoleContext, params) -> Reply:
        """``/Transport/Bless?type``：type 为客户端 ``BlessType`` 4/5/6。"""
        kind = str(self.ledger.positive(params.get('type') or '0'))
        options = (self.config.get('bless') or {}).get('types') or {}
        option = options.get(kind)
        if option is None:
            raise BusinessError('香型不存在')
        tr = self._state(ctx.state)
        bless = tr['bless']
        if bless.get('used', {}).get(kind):
            raise BusinessError('该香今日已上过')
        consume = [dict(Type=int(option['consume']['Type']), ID=0, Count=int(option['consume']['Count']))]
        rewards = [dict(Type=18, ID=0, Count=int(option['knowledge']))]
        outcome = self.ledger.apply(ctx.state, consume=consume, rewards=rewards)
        tr = self._state(ctx.state)
        bless = tr['bless']
        bless.setdefault('used', {})[kind] = 1
        bless['exp'] = int(bless.get('exp') or 0) + int(option['exp'])
        cfg = self.config.get('bless') or {}
        per = int(cfg.get('exp_per_level') or 2000)
        cap = int(cfg.get('max_level') or 20)
        while bless['level'] < cap and bless['exp'] >= per * bless['level']:
            bless['exp'] -= per * bless['level']
            bless['level'] += 1
        return Reply(self._bless_view(bless), self.ledger.global_for(ctx.state, outcome))

    def helpers(self, ctx: RoleContext, params) -> list:
        """``/Transport/Friends`` 与 ``/Transport/RobFriends``：护送/拦截时可邀请的好友。"""
        rows = []
        if self.friendships is None:
            return rows
        for friend_id in self.friendships.friends_of(ctx.db, ctx.user):
            try:
                profile = self.directory.profile(ctx.db, friend_id)
            except BusinessError:
                continue
            rows.append(dict(Id=friend_id, Name=profile['Name'], Power=profile['BattlePower']))
        return rows

    def _lookup_cart(self, ctx: RoleContext, enemy_id: int):
        if self.directory.is_robot(enemy_id):
            for npc in self._state(ctx.state).get('npcs') or []:
                if int(npc['id']) == enemy_id and self.clock.now() < npc['end']:
                    return None, npc
            raise BusinessError('对方的镖车已到达')
        other = self.directory.load_state(ctx.db, enemy_id)
        run = (other or {}).get('Transport', {}).get('run')
        if not run or self.clock.now() >= run['end']:
            raise BusinessError('对方的镖车已到达')
        return other, run

    def rob(self, ctx: RoleContext, params) -> Reply:
        """``/Transport/Rob?enemyid``：与对方阵容战斗，胜利夺取镖银的一部分。"""
        state, db = ctx.state, ctx.db
        tr = self._state(state)
        if tr['rob_used'] >= self.config['daily_rob_times']:
            raise BusinessError('今日劫镖次数已用完')
        enemy_id = self.ledger.positive(params.get('enemyid') or '0')
        other, run = self._lookup_cart(ctx, enemy_id)
        if run.get('robbed', 0) >= self.config['max_robbed_times']:
            raise BusinessError('该镖车已被劫过多次')
        allies = [self.engine.hero_unit(h) for h in self.model.team_heroes(state)]
        if other is None:
            heroes = self.directory.battle_team(db, enemy_id)
            enemy_name = self.directory.profile(db, enemy_id)['Name']
        else:
            heroes = self.model.team_heroes(other)
            enemy_name = other['Name']
        enemies = [self.engine.hero_unit(dict(h, battleIx=pos)) for h, pos in zip(heroes, ENEMY_POSITIONS)]
        for unit in enemies:
            unit.side = 1
        report = self.engine.simulate(allies, enemies)
        tr['rob_used'] += 1
        rewards = []
        if report['isWin']:
            stolen = int(run['gold'] * self.config['rob_ratio'])
            run['robbed'] = run.get('robbed', 0) + 1
            run['lost'] = run.get('lost', 0) + stolen
            if other is not None:
                other['Transport']['run'] = run
                self._log(other['Transport'], 101, {'PN': state['Name'], 'GD': stolen}, self.clock.now())
                self.directory.save_state(db, enemy_id, other)
            rewards = [dict(Type=1, ID=0, Count=stolen)]
        elif other is not None:
            self._log(other['Transport'], 102, {'PN': state['Name']}, self.clock.now())
            self.directory.save_state(db, enemy_id, other)
        outcome = self.ledger.apply(state, rewards=rewards)
        report.update(total=1, dropList=[], Reward=deepcopy(outcome.rewards), BattleResult={},
                      enemy={'Name': enemy_name, 'Vip': 0})
        return Reply(report, self.ledger.global_for(state, outcome))

    def logs(self, ctx: RoleContext, params) -> list:
        tr = self._state(ctx.state)
        tr['unread'] = 0
        return deepcopy(tr.get('logs', []))
