"""天书洞（/Sacrifice/*，客户端 QiShuRequest，35 级开放）。

十二项战斗属性（BattleAttrsType 1..12）各自独立升级，消耗阅历；每级为全体英雄增加固定数值。
加成通过 ``PlayerModel`` 的全队附加属性进入英雄属性，并写入 ``attributeAddition.sacrifice``。
"""
from ..errors import BusinessError
from .base import Reply, RoleContext
from .inventory import Ledger
from .player_state import PlayerModel

#: BattleAttrsType → (英雄属性名, 属性面板键名)
BPT_ATTRS = {1: ('health', 'HP'), 2: ('normalAttack', 'AP'), 3: ('normalDefense', 'DEF'), 4: ('skillAttack', 'MAP'),
             5: ('skillDefense', 'MDEF'), 6: ('mingzhong', 'H'), 7: ('shanbi', 'D'), 8: ('baoji', 'C'), 9: ('renxing', 'TE'),
             10: ('poji', 'B'), 11: ('gedang', 'BL'), 12: ('speed', 'Speed')}


class SacrificeService:
    def __init__(self, config, model: PlayerModel, ledger: Ledger):
        self.config = config
        self.model = model
        self.ledger = ledger
        model.add_team_bonus_provider(self.team_bonus)
        model.add_addition_provider('sacrifice', self.addition)

    def _levels(self, state: dict) -> dict:
        return state.setdefault('Sacrifice', {})

    def _value(self, bpt: int, level: int) -> int:
        return int(self.config['value_per_level'].get(str(bpt), 1) * level)

    def _cost(self, level: int) -> int:
        return int(self.config['knowledge_base'] * (self.config['knowledge_growth'] ** level))

    def _row(self, state: dict, bpt: int) -> dict:
        level = self._levels(state).get(str(bpt), 0)
        return {'BPT': bpt, 'Level': level, 'MaxLevel': self.config['max_level'], 'Value': self._value(bpt, level),
                'Knowledge': self._cost(level), 'OpenLv': self.config['open_level']}

    def info(self, ctx: RoleContext, params) -> list:
        return [self._row(ctx.state, bpt) for bpt in BPT_ATTRS]

    def upgrade(self, ctx: RoleContext, params) -> Reply:
        """``/Sacrifice/UpdTechnologyMagic?bpt``：消耗阅历提升一级。"""
        state, bpt = ctx.state, params['bpt']
        if bpt not in BPT_ATTRS:
            raise BusinessError('属性类型不存在')
        if state['PLevel'] < self.config['open_level']:
            raise BusinessError('天书洞尚未开放')
        level = self._levels(state).get(str(bpt), 0)
        if level >= self.config['max_level']:
            raise BusinessError('已达最高等级')
        outcome = self.ledger.apply(state, consume=[dict(Type=18, ID=0, Count=self._cost(level))])
        self._levels(state)[str(bpt)] = level + 1
        self.model.refresh_all(state)
        return Reply(self._row(state, bpt), self.ledger.global_for(state, outcome, Slots=self.model.slots(state)))

    def team_bonus(self, state: dict) -> dict:
        return {BPT_ATTRS[int(b)][0]: self._value(int(b), lv) for b, lv in (state.get('Sacrifice') or {}).items() if lv}

    def addition(self, state: dict):
        bonus = self.team_bonus(state)
        return {BPT_ATTRS[b][1]: bonus[a] for b, (a, _) in BPT_ATTRS.items() if a in bonus} or None
