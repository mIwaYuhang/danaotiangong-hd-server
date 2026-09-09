"""战三清（/Fightsanqing/*）。

三界（人 1 / 魔 2 / 天 3，按等级段划分）各有三个宝座（rank 1..3 = 太清 / 上清 / 玉清），由玩家占据，机器人补位。
宝座数据存于 ``RealmStore``（``sanqing:<type>``）。玩家只能挑战自己所在界的宝座，且已占座者不能再挑战；
挑战胜利则取代原座主并累计连胜，达到三连胜 / 六连胜 / 占领玉清时自动发放对应宝箱（客户端比较宝箱状态变化弹奖励）。
周六、周日不开放（客户端本地判断，服务端同样校验）。
"""
from copy import deepcopy
import datetime as dt
import json

from ..config import thaw
from ..errors import BusinessError
from .base import Reply, RoleContext
from .battle import BattleEngine, ENEMY_POSITIONS
from .clock import Clock
from .inventory import Ledger
from .player_state import PlayerModel
from .players import PlayerDirectory, RealmStore, ROBOT_BASE

LOG_LOST, LOG_TOOK = 501, 502
THRONES = (1, 2, 3)


class SanqingService:
    def __init__(self, config, model: PlayerModel, ledger: Ledger, engine: BattleEngine, clock: Clock,
                 directory: PlayerDirectory, store: RealmStore):
        self.config = config
        self.model = model
        self.ledger = ledger
        self.engine = engine
        self.clock = clock
        self.directory = directory
        self.store = store

    # ---- 数据 -------------------------------------------------------------

    def realm_of(self, level: int) -> int:
        for kind, (low, high) in self.config['realm_by_level'].items():
            if low <= level <= high:
                return int(kind)
        return 1

    def _thrones(self, db, kind: int) -> dict:
        data = self.store.get(db, f'sanqing:{kind}')
        if data is None:
            data = {'seats': {str(rank): {'playerId': ROBOT_BASE + 7000 + kind * 10 + rank, 'wins': 0, 'since': self.clock.now()}
                              for rank in THRONES}, 'logs': {}}
            self.store.set(db, f'sanqing:{kind}', data)
        return data

    def _save(self, db, kind: int, data: dict):
        self.store.set(db, f'sanqing:{kind}', data)

    def _player(self, state: dict) -> dict:
        return state.setdefault('Sanqing', {'wins': 0, 'chests': {}})

    def _seat_of(self, data: dict, player_id: int):
        return next((int(rank) for rank, seat in data['seats'].items() if seat['playerId'] == player_id), None)

    def _chest_views(self, state: dict) -> list:
        claimed = self._player(state)['chests']
        return [{'type': c['type'], 'state': 1 if str(c['type']) in claimed else 0, 'chest': thaw(c['chest'])}
                for c in self.config['chests']]

    def _log(self, data: dict, holder_id: int, kind: int, content: dict):
        logs = data['logs'].setdefault(str(holder_id), [])
        logs.insert(0, {'Times': self.clock.now(), 'Type': kind, 'Content': json.dumps(content, ensure_ascii=False)})
        del logs[self.config['log_limit']:]

    # ---- 接口 -------------------------------------------------------------

    def info(self, ctx: RoleContext, params) -> dict:
        """``/Fightsanqing/FightsanqingInfo?type``：某一界的三个宝座与我的宝箱状态。"""
        kind = params['type']
        if kind not in THRONES:
            raise BusinessError('三界类型不存在')
        data = self._thrones(ctx.db, kind)
        rows = []
        for rank in THRONES:
            seat = data['seats'][str(rank)]
            profile = self.directory.profile(ctx.db, seat['playerId'])
            rows.append({'rank': rank, 'playerID': seat['playerId'], 'name': profile['Name'], 'playerName': profile['Name'],
                         'avatarID': profile['Avatar'], 'avatarId': profile['Avatar'], 'level': profile['Level'],
                         'battlePower': profile['BattlePower'], 'continueWinTime': seat['wins'],
                         'unionName': self.union_name(ctx.db, seat['playerId'])})
        return {'type': kind, 'myType': self.realm_of(ctx.state['PLevel']), 'sanqings': rows, 'chests': self._chest_views(ctx.state),
                'continueWinTime': self._player(ctx.state)['wins']}

    def union_name(self, db, player_id: int) -> str:
        return ''

    def rotate_info(self, ctx: RoleContext, params) -> list:
        return [dict(item) for item in self.config['marquee']]

    def chest_info(self, ctx: RoleContext, params) -> dict:
        chest = next((c for c in self._chest_views(ctx.state) if c['type'] == params['chestType']), None)
        if chest is None:
            raise BusinessError('宝箱不存在')
        return chest

    def reports(self, ctx: RoleContext, params) -> list:
        holder = params['sanqingPlayerID']
        for kind in THRONES:
            data = self._thrones(ctx.db, kind)
            if str(holder) in data['logs']:
                return deepcopy(data['logs'][str(holder)])
        return []

    def fight(self, ctx: RoleContext, params) -> Reply:
        """``/Fightsanqing/Fightsanqing?type&rank``：挑战宝座。"""
        state, db = ctx.state, ctx.db
        kind, rank = params['type'], params['rank']
        if kind not in THRONES or rank not in THRONES:
            raise BusinessError('宝座不存在')
        if dt.datetime.fromtimestamp(self.clock.now()).weekday() in self.config['closed_weekdays']:
            raise BusinessError('战三清周六、周日不开放')
        if self.realm_of(state['PLevel']) != kind:
            raise BusinessError('您不在该界，无法挑战')
        data = self._thrones(db, kind)
        if self._seat_of(data, ctx.user) is not None:
            raise BusinessError('您已经占领了宝座，不能继续挑战')
        seat = data['seats'][str(rank)]
        holder_id = seat['playerId']
        holder = self.directory.profile(db, holder_id)
        allies = [self.engine.hero_unit(h) for h in self.model.team_heroes(state)]
        enemies = [self.engine.hero_unit(dict(h, battleIx=pos)) for h, pos in zip(self.directory.battle_team(db, holder_id), ENEMY_POSITIONS)]
        for unit in enemies:
            unit.side = 1
        report = self.engine.simulate(allies, enemies)
        me = self._player(state)
        rewards = []
        content = {'PN': state['Name'], 'G': kind, 'R': rank, 'SN': holder['Name'], 'S': len(report.get('battleRecords') or [])}
        if report['isWin']:
            me['wins'] += 1
            data['seats'][str(rank)] = {'playerId': ctx.user, 'wins': me['wins'], 'since': self.clock.now()}
            rewards.extend(thaw(self.config['win_reward']))
            for chest in self.config['chests']:
                reached = (chest['wins'] and me['wins'] >= chest['wins']) or (not chest['wins'] and rank == 1)
                if reached and str(chest['type']) not in me['chests']:
                    me['chests'][str(chest['type'])] = self.clock.day_key()
                    rewards.extend(thaw(chest['chest']))
            self._log(data, ctx.user, LOG_TOOK, content)
            self._log(data, holder_id, LOG_TOOK, content)
            if not self.directory.is_robot(holder_id):
                other = self.directory.load_state(db, holder_id)
                if other is not None:
                    self._player(other)['wins'] = 0
                    self.directory.save_state(db, holder_id, other)
        else:
            me['wins'] = 0
            self._log(data, holder_id, LOG_LOST, content)
            seat['wins'] += 1
        self._save(db, kind, data)
        outcome = self.ledger.apply(state, rewards=rewards)
        report.update(total=1, dropList=[], Reward=deepcopy(outcome.rewards), BattleResult={},
                      enemy={'Name': holder['Name'], 'Vip': holder.get('Vip', 0)})
        return Reply(report, self.ledger.global_for(state, outcome))
