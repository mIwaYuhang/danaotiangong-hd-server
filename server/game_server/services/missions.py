"""任务系统：主线与每日任务的状态计算、进度事件、奖励领取。

客户端状态：1 可前往（条件未满足）、2 进行中、3 可领取；已领取的任务不再下发。
条件由 ``missions.json`` 声明；进度既可从角色状态直接推导（等级、通关、英雄数），
也可来自其他服务通过 ``MissionEvents.on()`` 上报的累计计数（``Counters`` / ``Daily``）。
"""
from copy import deepcopy

from ..config import MissionDef, MissionsConfig, thaw
from ..errors import BusinessError
from .base import Reply, RoleContext, global_block
from .inventory import Ledger

ACCEPTABLE, PROCESSING, COMPLETED = 1, 2, 3
STATE_MISSION_UNFINISHED = -1133001
STATE_MISSION_CLAIMED = -1133002


class MissionEvents:
    """其他服务上报进度的入口：``events.on(state, kind, amount)``。"""

    def on(self, state: dict, kind: str, amount: int):
        counters = state.setdefault('Counters', {})
        if kind in ('recruit_today', 'battle_count_today'):
            return  # 已由 Daily 计数
        if kind in ('stage_clear', 'hero_count', 'team_size', 'sign_today'):
            return  # 可直接从状态推导
        counters[kind] = counters.get(kind, 0) + amount


class MissionService:
    def __init__(self, config: MissionsConfig, ledger: Ledger, catalog):
        self.config = config
        self.ledger = ledger
        self.catalog = catalog

    # ---- 进度 -------------------------------------------------------------

    def progress(self, state: dict, mission: MissionDef) -> int:
        kind = mission.kind
        if kind == 'stage_clear':
            return 1 if any(p['PID'] == mission.target and p['Star'] > 0 for p in state['Map']['Point']) else 0
        if kind == 'player_level':
            return state['PLevel']
        if kind == 'hero_count':
            return len(state['ownedHeros'])
        if kind == 'team_size':
            return sum(1 for h in state['ownedHeros'] if h.get('battleIx', 0) > 0)
        if kind == 'battle_count_today':
            return state['Daily'].get('battles', 0)
        if kind == 'recruit_today':
            return state['Daily'].get('recruits', 0)
        if kind == 'sign_today':
            return 1 if state['Daily'].get('sign_done') else 0
        return state.get('Counters', {}).get(kind, 0)

    def satisfied(self, state: dict, mission: MissionDef) -> bool:
        target = mission.target if mission.kind != 'stage_clear' else 1
        return self.progress(state, mission) >= target

    def claimed(self, state: dict, mission: MissionDef) -> bool:
        if mission.daily:
            return mission.mission_id in state['Daily'].get('mission_claims', [])
        return mission.mission_id in state.get('MissionClaims', [])

    def visible(self, state: dict) -> list:
        """当前应下发的任务：最前面的若干条未领取主线 + 全部未领取每日任务。"""
        result = [m for m in self.config.plotline if not self.claimed(state, m)][:self.config.visible_plotline]
        result.extend(m for m in self.config.daily if not self.claimed(state, m))
        return result

    def to_client(self, state: dict, mission: MissionDef) -> dict:
        types, statuses, entries = self.catalog['TaskType'], self.catalog['TaskStatus'], self.catalog['TaskEntryType']
        state_code = COMPLETED if self.satisfied(state, mission) else ACCEPTABLE
        return {'missionID': mission.mission_id, 'name': mission.name, 'description': mission.description,
                'type': types.get('eTaskDaily' if mission.daily else 'eTaskPlotline', 2),
                'state': state_code, 'missionReward': thaw(mission.reward),
                'location': {'Type': entries.get(mission.location_type, 0), 'ID': mission.location_id}}

    def claimable_count(self, state: dict) -> int:
        return sum(1 for m in self.visible(state) if self.satisfied(state, m))

    # ---- 状态同步（分发器钩子）------------------------------------------------------

    def snapshot(self, state: dict) -> dict:
        """当前可见任务的状态快照 ``{missionID: state}``。"""
        return {m.mission_id: (COMPLETED if self.satisfied(state, m) else ACCEPTABLE) for m in self.visible(state)}

    def push(self, state: dict) -> list:
        """``Global.Missions``：客户端按 MissionId 更新状态，未知的用 Detail 插入。"""
        return [{'MissionId': m['missionID'], 'State': m['state'], 'Detail': m}
                for m in (self.to_client(state, x) for x in self.visible(state))]

    def sync(self, before: dict, state: dict, reply: Reply) -> Reply:
        """任务状态相对 ``before`` 有变化时，把完整推送附加到回复的 Global 段。

        客户端只在登录时拉取任务列表，之后完全依赖各接口 Global.Missions 的推送；
        不推送就会出现“打完关卡任务仍显示未完成，重登才刷新”的现象。
        """
        if self.snapshot(state) == before:
            return reply
        if reply.global_ is None:
            reply.global_ = global_block()
        reply.global_['Missions'] = self.push(state)
        return reply

    # ---- 接口 -------------------------------------------------------------

    def list_missions(self, ctx: RoleContext, params) -> list:
        """``/Mission/Missions``。"""
        return [self.to_client(ctx.state, m) for m in self.visible(ctx.state)]

    def claim(self, ctx: RoleContext, params) -> Reply:
        """``/Mission/Reward?missionID``。"""
        state = ctx.state
        mission = next((m for m in self.config.plotline + self.config.daily if m.mission_id == params['missionID']), None)
        if mission is None:
            raise BusinessError('任务不存在')
        if self.claimed(state, mission):
            raise BusinessError('任务奖励已领取', STATE_MISSION_CLAIMED)
        if not self.satisfied(state, mission):
            raise BusinessError('任务尚未完成', STATE_MISSION_UNFINISHED)
        outcome = self.ledger.apply(state, rewards=thaw(mission.reward))
        if mission.daily:
            state['Daily'].setdefault('mission_claims', []).append(mission.mission_id)
        else:
            state.setdefault('MissionClaims', []).append(mission.mission_id)
        return Reply({'Reward': deepcopy(outcome.rewards)},
                     self.ledger.global_for(state, outcome, Missions=self.push(state)))
