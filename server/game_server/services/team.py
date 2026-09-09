"""阵容与小伙伴：布阵、换将、小伙伴、查看阵容、图鉴。

- ``/Team/Change?heroIds``：按 battleIx 1..6 顺序的英雄 ID 列表，空位为 0；
- ``/Team/UpdatedTeamHero?index&heroID``：把英雄放到指定阵位（同一英雄换位时交换）；
- ``/Hero/ChangePartnerID?index&upHeroID``：小伙伴槽位（不占阵位，只参与缘分）；
- 阵位与小伙伴槽位按玩家等级解锁（``hero.json``）。
"""
from copy import deepcopy

from ..errors import BusinessError
from .base import Reply, RoleContext, global_block
from .player_state import PlayerModel

STATE_TEAM_ERROR = -1111001


class TeamService:
    def __init__(self, model: PlayerModel, events=None, directory=None):
        self.model = model
        self.events = events
        self.directory = directory  # 玩家目录：查看其他玩家阵容

    def _apply_formation(self, state: dict, formation: dict):
        """``formation``：battleIx → heroId（0 为空位）。校验后写回 ownedHeros.battleIx。"""
        unlocked = self.model.heroes.unlocked_team_slots(state['PLevel'])
        used = set()
        for position, hero_id in formation.items():
            if not 1 <= position <= self.model.config.team_slots:
                raise BusinessError('阵位不存在', STATE_TEAM_ERROR)
            if hero_id:
                if position > unlocked:
                    raise BusinessError(f'需要{self.model.heroes.config.team_slot_unlock_levels[position - 1]}级开放！')
                if hero_id in used:
                    raise BusinessError('同一主将不能重复上阵', STATE_TEAM_ERROR)
                self.model.find_hero(state, hero_id)
                used.add(hero_id)
        if not used:
            raise BusinessError('至少需要一名主将上阵', STATE_TEAM_ERROR)
        for hero in state['ownedHeros']:
            hero['battleIx'] = next((pos for pos, hid in formation.items() if hid == hero['heroId']), 0)
        self.model.refresh_all(state)
        self._emit(state, 'team_size', len(used))

    def change(self, ctx: RoleContext, params) -> Reply:
        """``/Team/Change``。"""
        raw = [x.strip() for x in (params.get('heroIds') or '').split(',') if x.strip() != '']
        if not raw or len(raw) > self.model.config.team_slots or any(not x.isdigit() for x in raw):
            raise BusinessError('阵容参数无效', STATE_TEAM_ERROR)
        formation = {pos: int(value) for pos, value in enumerate(raw, 1)}
        for pos in range(len(raw) + 1, self.model.config.team_slots + 1):
            formation[pos] = 0
        self._apply_formation(ctx.state, formation)
        return Reply({}, global_block(Slots=self.model.slots(ctx.state)))

    def update_slot(self, ctx: RoleContext, params) -> Reply:
        """``/Team/UpdatedTeamHero``：把 heroID 放到 index 位；heroID 为 0 表示清空该位。"""
        index, hero_id = params['index'], params['heroID']
        state = ctx.state
        formation = {pos: 0 for pos in range(1, self.model.config.team_slots + 1)}
        for hero in self.model.team_heroes(state):
            formation[hero['battleIx']] = hero['heroId']
        if index not in formation:
            raise BusinessError('阵位不存在', STATE_TEAM_ERROR)
        if hero_id:
            previous = formation[index]
            old_position = next((pos for pos, hid in formation.items() if hid == hero_id), None)
            formation[index] = hero_id
            if old_position is not None:
                formation[old_position] = previous
        else:
            formation[index] = 0
        self._apply_formation(state, formation)
        return Reply({}, global_block(Slots=self.model.slots(state)))

    def change_partner(self, ctx: RoleContext, params) -> Reply:
        """``/Hero/ChangePartnerID``。"""
        index, hero_id = params['index'], params['upHeroID']
        state = ctx.state
        unlocked = self.model.heroes.unlocked_partner_slots(state['PLevel'])
        if not 1 <= index <= len(self.model.heroes.config.partner_slot_unlock_levels):
            raise BusinessError('小伙伴位置不存在')
        if index > unlocked:
            raise BusinessError(f'该位置需要 {self.model.heroes.config.partner_slot_unlock_levels[index - 1]} 级开放')
        partners = [p for p in state['partnerTeam'] if p.get('Index') != index]
        if hero_id:
            hero = self.model.find_hero(state, hero_id)
            if hero.get('battleIx', 0) > 0:
                raise BusinessError('上阵主将不能同时担任小伙伴')
            if any(p.get('HeroID') == hero_id for p in partners):
                raise BusinessError('该主将已是小伙伴')
            partners.append({'Index': index, 'HeroID': hero_id})
        state['partnerTeam'] = sorted(partners, key=lambda p: p['Index'])
        return Reply({'Index': index, 'HeroID': hero_id})

    def team_info(self, ctx: RoleContext, params) -> dict:
        """``/Team/TeamNew?playerid``：查看任意玩家（真实玩家或机器人）的阵容。"""
        raw = params.get('playerid') or ''
        if not raw.isdigit():
            raise BusinessError('玩家编号无效')
        player_id = int(raw)
        if player_id == ctx.user or self.directory is None:
            state = ctx.state
            return dict(team=self.model.team(state), partnerTeam=deepcopy(state['partnerTeam']),
                        attributeAddition=deepcopy(state.get('attributeAddition', {})))
        profile = self.directory.profile(ctx.db, player_id)
        return dict(team=profile['team'], partnerTeam=profile['partnerTeam'], attributeAddition=profile['attributeAddition'])

    def handbook(self, ctx: RoleContext, params) -> dict:
        """``/Handbook/Handbook``：图鉴，逗号分隔的已拥有英雄与装备模板 ID。"""
        heroes = sorted(h['heroId'] for h in ctx.state['ownedHeros'])
        equips = sorted({x['equipId'] for x in ctx.state.get('Talismans', {}).values()})
        return {'heros': ','.join(map(str, heroes)), 'talismans': ','.join(map(str, equips))}

    def _emit(self, state: dict, kind: str, amount: int):
        if self.events is not None:
            self.events.on(state, kind, amount)
