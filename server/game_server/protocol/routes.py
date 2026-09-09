"""路由表：服务端已实现的全部接口一览。

参数名与客户端 ``base/serverurl.lua`` 中的查询参数一致。
所有需要会话的接口，分发器都会额外校验 ``user`` / ``session`` / ``serverid``，
并拒绝未在此声明也不在公共参数集合中的参数。
"""
from .params import Device, Email, Integer, Md5Hex, Raw, Text, TicketJson
from .router import Router


def build_router(services, token_length: int) -> Router:
    """``services`` 是 ``app.Services``，``token_length`` 是票据 / 会话令牌长度。"""
    r = Router()
    s = services

    # ---- SDK 账号（无需凭证）----------------------------------------------
    r.public('/sdk/Default', s.account.guest_login, udid=Device(256))
    r.public('/sdk/Register', s.account.register, email=Email(), pwd=Md5Hex())
    r.public('/sdk/login', s.account.login, email=Email(), pwd=Md5Hex())
    r.public('/Role/partner', s.account.enter_realm, serverid=Text(10), userid=TicketJson(token_length))

    # ---- 角色 -------------------------------------------------------------
    r.session('/Role/Name', s.roles.create, name=Text(256), heroProtoID=Integer())
    r.session('/Message/Messages', s.activities.marquee)
    r.role('/Role/Default', s.roles.load)
    r.role('/Notify/Message', s.roles.notify)
    r.role('/Role/AvatarIndex', s.roles.set_avatar, avatarIndex=Integer())
    r.role('/TiroGuide/save', s.stages.save_guide, stepno=Integer())

    # ---- 阵容与图鉴 -----------------------------------------------------------
    r.role('/Team/TeamNew', s.team.team_info, playerid=Raw(default=''))
    r.role('/Team/Change', s.team.change, heroIds=Raw(default=''))
    r.role('/Team/UpdatedTeamHero', s.team.update_slot, index=Integer(), heroID=Integer())
    r.role('/Hero/ChangePartnerID', s.team.change_partner, index=Integer(), upHeroID=Integer())
    r.role('/Handbook/Handbook', s.team.handbook)

    # ---- 英雄成长 -----------------------------------------------------------
    r.role('/Prop/HeroUpdLevel', s.growth.level_up, heroId=Integer(), addLv=Integer(minimum=-1))
    r.role('/Prop/UseExpPill', s.growth.use_exp_pills, heroId=Integer(), props=Raw(default=''))
    r.role('/Hero/Breakthrough', s.growth.breakthrough, heroid=Integer())
    r.role('/Hero/Train', s.growth.train, heroID=Integer(), count=Integer(), isspecial=Raw(default=''))
    r.role('/Hero/SaveTrain', s.growth.save_train, heroID=Integer())
    r.role('/hero/RecruitHero', s.growth.recruit_by_soul, soulId=Integer())
    r.role('/Hero/RecruitAll', s.growth.recruit_all)
    r.role('/Hero/skilltrain', s.growth.skill_train, heroid=Integer())
    r.role('/hero/transferpower', s.growth.transfer_stub, heroid=Integer(), toheroid=Integer(), costIngot=Integer())
    r.role('/hero/Previewtransferpower', s.growth.transfer_stub, heroid=Integer(), toheroid=Integer())

    # ---- 法宝 -------------------------------------------------------------
    r.role('/Talisman/Talismans', s.talisman.list_all)
    r.role('/Talisman/intensify', s.talisman.intensify, playerTalismanId=Integer(), number=Integer())
    r.role('/Talisman/RecastInfo', s.talisman.recast_info, talismanID=Integer())
    r.role('/Talisman/recast', s.talisman.recast, id=Integer(), type=Integer(default=1, required=False))
    r.role('/Talisman/Lock', s.talisman.lock, talismanID=Integer(), lockQualification=Integer())
    r.role('/Talisman/FeedTalismanNewest', s.talisman.feed, id=Integer(), ids=Raw(default=''), count=Raw(default='0'))
    r.role('/Talisman/SyntheticAll', s.talisman.synthetic_all)
    r.role('/Talisman/DecomposeTalisman', s.talisman.decompose, id=Integer(), type=Integer(default=1, required=False))
    r.role('/Talisman/ComposeTalismanSoul', s.talisman.compose_soul, ids=Raw(default=''))
    r.role('/Talisman/SellFragment', s.talisman.sell_fragment, fragmentid=Integer(), count=Integer(minimum=1))
    r.role('/Talisman/FexchangT', s.talisman.exchange_fragment, fragmentid=Integer())
    r.role('/Hero/Change', s.talisman.equip, heroID=Integer(), type=Integer(), id=Integer())
    r.role('/Hero/Unloading', s.talisman.unequip, heroID=Integer(), type=Integer(), id=Integer())
    r.role('/Hero/ChangeAll', s.talisman.equip_all, heroID=Integer())

    # ---- 背包与商店 -----------------------------------------------------------
    r.role('/Prop/GetSinglePropLst', s.inventory.list_props, propType=Raw())
    r.role('/Prop/GetStorePropLst', s.inventory.store_list)
    r.role('/Prop/UseProps', s.inventory.use_props, id=Raw(), count=Raw(), name=Raw(), heroId=Raw())
    r.role('/Prop/SellProps', s.inventory.sell_props, id=Raw(), count=Raw())
    r.role('/Prop/BuyGoods', s.inventory.buy_goods, type=Raw(), id=Raw(), count=Raw())
    r.role('/Prop/StoreSuitPropList', s.inventory.suit_list)
    r.role('/Mysterystore/GetMysterystoreInfo', s.inventory.mystery_info)
    r.role('/Mysterystore/RefreshMysterystore', s.inventory.mystery_refresh)
    r.role('/Mysterystore/BuyMysterystore', s.inventory.mystery_buy, Index=Raw())

    # ---- 招募 -------------------------------------------------------------
    r.role('/Store/StoreHeroRecruitInfo', s.recruitment.pools)
    r.role('/Store/StoreHeroRecruit', s.recruitment.recruit, type=Raw(default=''), count=Raw(default='1'))

    # ---- 关卡 -------------------------------------------------------------
    r.role('/MapInfo/GetMapInfo', s.stages.map_info)
    r.role('/Battle/fight', s.stages.fight, cpId=Integer(), ri=Integer(minimum=1), star=Integer(minimum=1))
    r.role('/Battle/BattleTen', s.stages.sweep, cpId=Integer(), star=Integer(minimum=1))
    r.role('/Battle/SubCdTime', s.stages.clear_cooldown)
    r.role('/Battle/IsSXRewar', s.stages.chapter_status, Chapter=Integer())
    r.role('/Battle/IsSXRewarNew', s.stages.chapter_status, Chapter=Integer())
    r.role('/Battle/SXRewar', s.stages.chapter_reward, Chapter=Integer(), star=Integer())

    # ---- 任务 -------------------------------------------------------------
    r.role('/Mission/Missions', s.missions.list_missions)
    r.role('/Mission/Reward', s.missions.claim, missionID=Integer())

    # ---- 邮件 -------------------------------------------------------------
    r.role('/Mailinfo/GetMailinfoList', s.mail.list_mails, index=Integer(), type=Integer())
    r.role('/Mailinfo/GetMailinfo', s.mail.detail, mailId=Integer())
    r.role('/Mailinfo/GetPlayerAccessory', s.mail.take_attachment, mailId=Integer())
    r.role('/Mailinfo/SeeUnreadMailNumber', s.mail.unread)
    r.role('/Mailinfo/DeletePlayerMailId', s.mail.delete, mailid=Integer())
    r.role('/Mailinfo/ClickPlayerMail', s.mail.clear, mailType=Integer())
    r.role('/Mailinfo/ClickPlayerMailRead', s.mail.clear_read, mailType=Integer())
    r.role('/Mailinfo/SendMail', s.mail.send, toplayerid=Integer(), mailContent=Raw(default=''), message=Raw(default=''))

    # ---- 活动 -------------------------------------------------------------
    r.role('/SignMonth/GetSignInfoNew', s.activities.sign_info)
    r.role('/SignMonth/SignMonthNew', s.activities.sign)
    r.role('/EverydayReward/GetDayRewar', s.activities.salary_info)
    r.role('/EverydayReward/GetToDayRewar', s.activities.take_salary)
    r.role('/EverydayReward/GetActivity', s.activities.take_gift_bag, id=Integer())
    r.role('/PlayerEverydayReward/EveryDayRewarInfo', s.activities.everyday_info)
    r.role('/loginreward/SDHRewards', s.activities.seven_day_info)
    r.role('/loginreward/getReward', s.activities.seven_day_claim, day=Integer())
    r.role('/LevelGiftBag/GetLevelGiftBagInfo', s.activities.level_gift_info)
    r.role('/LevelGiftBag/GetLevelGiftBagReward', s.activities.level_gift_claim, level=Integer())
    r.role('/LevelGiftBag/GetGrowupInfo', s.activities.growup_info)
    r.role('/LevelGiftBag/BuyGrowup', s.activities.unavailable)
    r.role('/LevelGiftBag/GetGrowupReward', s.activities.unavailable, level=Integer())
    r.role('/Monthcard/GetMonthcardInfo', s.activities.month_card_info)
    r.role('/Monthcard/GetMonthcardReward', s.activities.unavailable)
    r.role('/Monthcard/GetWeekcardReward', s.activities.unavailable)
    r.role('/Monthcard/ChangeIngot', s.activities.unavailable, point=Integer())
    r.role('/Recharge/RechargeLst', s.activities.recharge_list)
    r.role('/Recharge/firstreward', s.activities.first_recharge_info)
    r.role('/Recharge/GetFirstRechargeReward', s.activities.unavailable)
    r.role('/Recharge/GetOrderID', s.activities.unavailable, money=Raw(default=''))
    r.role('/Recharge/GetPointOrderID', s.activities.unavailable, money=Raw(default=''))

    # ---- 争霸 -------------------------------------------------------------
    r.role('/Duel/info', s.arena.info)
    r.role('/Duel/Challenge', s.arena.challenge, rank=Integer(minimum=1), ri=Raw(default=''), star=Raw(default=''))
    r.role('/Duel/TopTen', s.arena.top_ten)
    r.role('/Duel/Exchanges', s.arena.exchanges)
    r.role('/Duel/LimitRankExchanges', s.arena.limit_rank_exchanges)
    r.role('/Duel/Exchange', s.arena.exchange, id=Integer())
    r.role('/Duel/back', s.arena.clear_cooldown)
    r.role('/duel/scores', s.arena.scores)
    r.role('/duel/getscore', s.arena.get_score, id=Integer())

    # ---- 妖王洞穴 -----------------------------------------------------------
    r.role('/Worldboss/ActivityInfo', s.worldboss.activity_info)
    r.role('/Worldboss/WorldbossInfo', s.worldboss.boss_info, timeTick=Integer(default=0, required=False))
    r.role('/Worldboss/Challenge', s.worldboss.challenge, type=Integer(), bossID=Integer(), ri=Raw(default=''), star=Raw(default=''))
    r.role('/Worldboss/Order', s.worldboss.order)
    r.role('/Worldboss/Encouraging', s.worldboss.encourage)
    r.role('/Worldboss/AutofightControl', s.worldboss.autofight, isAutofight=Integer())
    r.role('/Worldboss/Resurgence', s.worldboss.resurgence, timeTick=Integer(default=0, required=False))
    r.role('/Worldboss/RewardList', s.worldboss.reward_list)
    r.role('/Worldboss/Reward', s.worldboss.reward, time=Raw(default=''))
    r.role('/Worldboss/ChallengeRank', s.worldboss.challenge_rank)

    # ---- 十二元辰殿 -----------------------------------------------------------
    r.role('/Copy/PlayerCopyInfo', s.fuben.info)
    r.role('/Copy/OpenCopy', s.fuben.open_copy, copyId=Integer(minimum=1))
    r.role('/Copy/RefreshStarLevel', s.fuben.refresh_star, copyId=Integer(minimum=1))
    r.role('/Copy/BattleCopy', s.fuben.battle, copyId=Integer(minimum=1), ri=Raw(default=''), star=Raw(default=''))
    r.role('/Copy/OpenCard', s.fuben.open_card, copyId=Integer(minimum=1), selectLocation=Integer(minimum=1))
    r.role('/Copy/GetPreviewInfo', s.fuben.preview)
    r.role('/Copy/ResetCopy', s.fuben.reset, copyID=Integer())

    # ---- 通天塔 -------------------------------------------------------------
    r.role('/Tower/GetTowerInfo', s.tower.info)
    r.role('/Tower/TowerBattle', s.tower.battle, type=Integer(minimum=1), ri=Raw(default=''), star=Raw(default=''))
    r.role('/Tower/Mopping', s.tower.mopping)
    r.role('/Tower/TowerRevive', s.tower.revive)
    r.role('/Tower/Buffs', s.tower.buffs)
    r.role('/Tower/Buy', s.tower.buy_buff, buyBuff=Raw(default=''))
    r.role('/Tower/BuffPropertyAddtions', s.tower.buff_additions)
    r.role('/Tower/GetFloorReward', s.tower.floor_reward)
    r.role('/Tower/RankInfo', s.tower.rank)
    r.role('/Tower/LWRanking', s.tower.rank)

    # ---- 炼化炉 -------------------------------------------------------------
    r.role('/RefiningFurnace/Refine', s.refine.refine, heros=Raw(default=''), souls=Raw(default=''),
           talismans=Raw(default=''), fragments=Raw(default=''))
    r.role('/RefiningFurnace/Rebirth', s.refine.rebirth, heroID=Raw(default=''), talismanID=Raw(default=''))

    # ---- 好友 -------------------------------------------------------------
    r.role('/Friend/Friends', s.friends.friends)
    r.role('/Friend/RequestFriends', s.friends.requests)
    r.role('/Friend/RecommendFriends', s.friends.recommend, name=Raw(default=''), level=Raw(default=''))
    r.role('/Friend/PresentsInfo', s.friends.presents)
    r.role('/Friend/GetAllBackPresent', s.friends.get_all_presents)
    r.role('/Friend/AddMail', s.friends.add_request, friendId=Raw(default=''), message=Raw(default=''))
    r.role('/Friend/Add', s.friends.accept, friendId=Raw(default=''))
    r.role('/Friend/Reject', s.friends.remove, friendId=Raw(default=''))
    r.role('/Friend/Delete', s.friends.remove, friendId=Raw(default=''))
    r.role('/Friend/Present', s.friends.present, frinendID=Raw(default=''))
    r.role('/Friend/Get', s.friends.get_present, id=Raw(default=''))
    r.role('/Friend/SendMail', s.friends.send_mail, friendId=Raw(default=''), message=Raw(default=''))

    # ---- 运镖 -------------------------------------------------------------
    r.role('/Transport/GetPlayerTransportInfo', s.transport.info)
    r.role('/Transport/GetPlayerTransportSelect', s.transport.select)
    r.role('/Transport/StartPlayerTransport', s.transport.start, addresId=Integer(minimum=1), friendIds=Raw(default=''))
    r.role('/Transport/EndTransport', s.transport.end)
    r.role('/Transport/CallHorse', s.transport.call_horse, type=Integer(minimum=1))
    r.role('/Transport/RefreshHorse', s.transport.refresh_horse, type=Raw(default=''))
    r.role('/Transport/Bless', s.transport.bless, type=Raw(default=''))
    r.role('/Transport/BlessInfo', s.transport.bless_info)
    r.role('/Transport/Friends', s.transport.rob_targets)
    r.role('/Transport/RobFriends', s.transport.rob_targets)
    r.role('/Transport/Rob', s.transport.rob, enemyid=Raw(default=''), friendIds=Raw(default=''))
    r.role('/TransportLog/GetPlayerTransportLogList', s.transport.logs, page=Raw(default=''))

    # ---- 小黑屋 -------------------------------------------------------------
    r.role('/Darkhouse/Darkhouse', s.slave.home)
    r.role('/Darkhouse/RandomCaptur', s.slave.candidates)
    r.role('/Darkhouse/EnemyList', s.slave.candidates, page=Raw(default=''))
    r.role('/Darkhouse/CatchCapture', s.slave.capture, location=Integer(minimum=1), capturePlayerID=Integer(minimum=1),
           isUseProp=Raw(default='0'), ri=Raw(default=''), star=Raw(default=''))
    r.role('/Darkhouse/GainPart', s.slave.gain, location=Integer(minimum=1))
    r.role('/Darkhouse/BleedWhite', s.slave.bleed, location=Integer(minimum=1))
    r.role('/Darkhouse/GetAll', s.slave.get_all, location=Integer(minimum=1))
    r.role('/Darkhouse/Drive', s.slave.drive)
    r.role('/Darkhouse/Revolt', s.slave.revolt, ri=Raw(default=''), star=Raw(default=''))
    r.role('/Darkhouse/GFriendList', s.slave.rescue_list)
    r.role('/Darkhouse/SaveFriend', s.slave.rescue, friendID=Integer(minimum=1), ri=Raw(default=''), star=Raw(default=''))
    r.role('/Darkhouse/ReortList', s.slave.reports)

    # ---- 神器殿 -------------------------------------------------------------
    r.role('/Artifacthall/Info', s.artifact.info)
    r.role('/Artifacthall/Perfusion', s.artifact.perfusion)
    r.role('/Artifacthall/BeRobbed', s.artifact.be_robbed_candidates, fragmentID=Integer(minimum=1))
    r.role('/Artifacthall/Rob', s.artifact.rob, fragmentID=Integer(minimum=1), beRobbedPlayerID=Integer(minimum=1),
           type=Integer(default=1, required=False), ri=Raw(default=''), star=Raw(default=''))
    r.role('/Artifacthall/RobTen', s.artifact.rob_ten, number=Integer(default=10, required=False))
    r.role('/Artifacthall/Battlereport', s.artifact.battle_reports)
    r.role('/Artifacthall/Revenge', s.artifact.revenge, id=Integer(minimum=1), ri=Raw(default=''), star=Raw(default=''))

    # ---- 宝石与矿洞 -----------------------------------------------------------
    r.role('/Gem/Gems', s.gem.list_all)
    r.role('/Gem/Change', s.gem.inlay, talismanID=Integer(minimum=1), gemID=Integer(minimum=1))
    r.role('/Gem/Unloading', s.gem.unload, talismanID=Integer(minimum=1))
    r.role('/Gem/Synthetic', s.gem.synthetic, ids=Raw(default=''))
    r.role('/Gem/SyntheticAll', s.gem.synthetic_all)
    r.role('/Gem/PutAll', s.gem.put_all)
    r.role('/Gem/Sell', s.gem.sell, ids=Raw(default=''))
    r.role('/Gem/Buy', s.gem.buy, id=Integer(minimum=1), level=Integer(minimum=1), count=Integer(minimum=1))
    r.role('/Gem/GemMineInfo', s.gem.mine_info)
    r.role('/Gem/GetGem', s.gem.mine_collect)
    r.role('/Gem/Preview', s.gem.mine_preview)
    r.role('/Gem/BuyGoldHoe', s.gem.buy_hoe)

    # ---- 仙盟 -------------------------------------------------------------
    r.role('/Union/CreateUnion', s.union.create, name=Raw())
    r.role('/Union/GetAllUnionList', s.union.list_all, page=Integer(default=1, required=False), count=Integer(default=20, required=False))
    r.role('/Union/UnionApply', s.union.apply, unionId=Integer(minimum=1))
    r.role('/Union/CancelUnionApply', s.union.cancel_apply, unionId=Integer(minimum=1))
    r.role('/Union/GetUnionInfo', s.union.info)
    r.role('/Union/GetPlayerUnionInfo', s.union.info)
    r.role('/Union/GetAllPlayerUnions', s.union.members)
    r.role('/Union/LeftUnion', s.union.leave)
    r.role('/Union/KickOutUnion', s.union.kick, kickPlayerId=Integer(minimum=1))
    r.role('/Union/DeleteUnion', s.union.dissolve)
    r.role('/Union/ChangeUnionPosition', s.union.change_position, changePlayerId=Integer(minimum=1), changePositionId=Integer(minimum=1))
    r.role('/Union/ChangeUnionLeader', s.union.change_leader, changePlayerId=Integer(minimum=1))
    r.role('/Union/GetUnionApplyList', s.union.apply_list)
    r.role('/Union/JoinUnion', s.union.approve, playerId=Integer(minimum=1))
    r.role('/Union/OneKeyUnionApply', s.union.approve)
    r.role('/Union/RefuseUnionApply', s.union.refuse, refusePlayerId=Integer(minimum=1))
    r.role('/Union/OnKeyRefuse', s.union.refuse)
    r.role('/Union/ChangeUnionApplyStatus', s.union.change_apply_status, status=Integer())
    r.role('/Union/UpdateUnionNotice', s.union.update_notice, notice=Raw(default=''))
    r.role('/Union/UpdateUnionOutNotice', s.union.update_out_notice, outNotice=Raw(default=''))
    r.role('/Union/GetUnionLogList', s.union.logs, type=Raw(default=''))
    r.role('/Union/GiveUnionCoin', s.union.give_coin, playerIdList=Raw(default=''), coinCount=Integer(minimum=1))
    r.role('/Union/Xm', s.union.temple)
    r.role('/Union/Worship', s.union.worship, index=Integer(minimum=1))
    r.role('/Union/GetUnionBuildInfo', s.union.buildings)
    r.role('/Union/Upgrade', s.union.upgrade, type=Integer(minimum=1))

    # ---- 天书洞 -------------------------------------------------------------
    r.role('/Sacrifice/GetTechnologyInfo', s.sacrifice.info)
    r.role('/Sacrifice/UpdTechnologyMagic', s.sacrifice.upgrade, bpt=Integer(minimum=1))

    # ---- 天命 -------------------------------------------------------------
    r.role('/Destiny/Info', s.destiny.info)
    r.role('/Destiny/Hunt', s.destiny.hunt, type=Integer(minimum=1), id=Raw(default=''))
    r.role('/Destiny/HuntAll', s.destiny.hunt_all)
    r.role('/Destiny/Get', s.destiny.collect, index=Integer(minimum=1))
    r.role('/Destiny/Decompose', s.destiny.decompose, type=Integer(minimum=1), indexOrID=Integer(minimum=1))
    r.role('/Destiny/Select', s.destiny.select_quality, quality=Integer(minimum=1))
    r.role('/Destiny/DecomposeAll', s.destiny.decompose_all, type=Integer(minimum=1), quality=Integer(required=False, default=0))
    r.role('/Destiny/PlayerDestinys', s.destiny.bag)
    r.role('/Destiny/Change', s.destiny.equip, index=Integer(minimum=1), location=Integer(minimum=1), destinyID=Integer(minimum=1))
    r.role('/Destiny/Unloading', s.destiny.unequip, index=Integer(minimum=0, required=False, default=0), destinyID=Integer(minimum=1))
    r.role('/Destiny/ChangeAll', s.destiny.equip_all, index=Integer(minimum=1))
    r.role('/Destiny/Upgrade', s.destiny.upgrade, id=Integer(minimum=1))
    r.role('/Destiny/HaloUpgrade', s.destiny.halo_upgrade, index=Integer(minimum=1))
    r.role('/Destiny/ChangeHalo', s.destiny.change_halo, afterLevel=Raw(default=''))
    r.role('/Destiny/ExchangeInfo', s.destiny.exchange_info)
    r.role('/Destiny/Exchange', s.destiny.exchange, exchangeID=Integer(minimum=1), destinyIDs=Raw(default=''))
    r.role('/Destiny/MillionHunt', s.destiny.million_hunt, type=Integer(minimum=1, required=False, default=1))
    r.role('/Destiny/GetMillionHunt', s.destiny.million_claim)

    # ---- 仙盟扩展：商店 / 魔族巢穴 / 留言板 / 仙桃 -----------------------------------------------
    r.role('/UnionStore/ZhenPinInfo', s.union_store.zhenpin_info)
    r.role('/UnionStore/BuyZhenPin', s.union_store.buy_zhenpin, index=Integer(minimum=1))
    r.role('/UnionStore/FixGoodsInfo', s.union_store.fix_goods_info)
    r.role('/UnionStore/BuyFixGoods', s.union_store.buy_fix_goods, index=Integer(minimum=1))
    r.role('/UnionStore/GetUnionStoreLst', s.union_store.auction_list)
    r.role('/UnionStore/Auction', s.union_store.bid, id=Integer(minimum=1), price=Integer(minimum=1))
    r.role('/UnionDemon/Demons', s.union_demon.list_all)
    r.role('/UnionDemon/Demon', s.union_demon.detail, demonID=Integer(minimum=1), type=Raw(default=''))
    r.role('/UnionDemon/DemonKing', s.union_demon.detail, demonKingID=Integer(minimum=1), type=Raw(default=''))
    r.role('/UnionDemon/Challenge', s.union_demon.challenge, demonID=Integer(minimum=1), type=Integer(default=1, required=False),
           ri=Raw(default=''), star=Raw(default=''))
    r.role('/UnionDemon/ChallengeKing', s.union_demon.challenge, demonKingID=Integer(minimum=1), type=Integer(default=1, required=False),
           ri=Raw(default=''), star=Raw(default=''))
    r.role('/UnionDemon/GiveUp', s.union_demon.give_up, demonID=Integer(minimum=1))
    r.role('/UnionDemon/GiveUpKing', s.union_demon.give_up, demonKingID=Integer(minimum=1))
    r.role('/UnionDemon/Resurgence', s.union_demon.resurgence, demonID=Integer(minimum=1))
    r.role('/UnionDemon/ResurgenceKing', s.union_demon.resurgence, demonKingID=Integer(minimum=1))
    r.role('/UnionMessageBoard/GetUnionMes', s.union_board.list_all)
    r.role('/UnionMessageBoard/AddUnionMes', s.union_board.add, unionContent=Raw(default=''))
    r.role('/Union/XiantaoInfo', s.xiantao.info)
    r.role('/Union/EatXiantao', s.xiantao.eat)

    # ---- 大闹天宫 -------------------------------------------------------------
    r.role('/XianmoFight/XianmoFightInfo', s.havoc.info)
    r.role('/XianmoFight/Ballot', s.havoc.ballot)
    r.role('/XianmoFight/Challenge', s.havoc.challenge, bePlayerId=Integer(minimum=1), ri=Raw(default=''), star=Raw(default=''))
    r.role('/XianmoFight/RefreshChallenge', s.havoc.refresh)
    r.role('/XianmoFight/GetEnemys', s.havoc.enemies)
    r.role('/XianmoFight/Revenge', s.havoc.revenge, enemyId=Integer(minimum=1), ri=Raw(default=''), star=Raw(default=''))
    r.role('/XianmoFight/GetSingleRankLst', s.havoc.rank_list, type=Integer(minimum=1))
    r.role('/XianmoFight/GetRankRewardLst', s.havoc.reward_list)
    r.role('/XianmoFight/GetRankReward', s.havoc.claim, ID=Raw())
    r.role('/XianmoFight/XianmoFightLog', s.havoc.logs)

    # ---- 寻访 -------------------------------------------------------------
    r.role('/XunFang/GetMasterInfo', s.xunfang.info)
    r.role('/XunFang/XunFangMaster', s.xunfang.visit, populationID=Integer(minimum=1), xunFangType=Integer(minimum=1))
    r.role('/XunFang/GetHandBookDetail', s.xunfang.handbook)
    r.role('/XunFang/GetApprenticeInfo', s.xunfang.apprentice_info, populationID=Integer(minimum=1))
    r.role('/XunFang/ToBeApprentice', s.xunfang.become_apprentice, ID=Integer(minimum=1))
    r.role('/XunFang/ExchangeLearnExp', s.xunfang.exchange, fromMasterID=Integer(minimum=0), toMasterID=Integer(minimum=0), count=Integer(minimum=1))

    # ---- 诸神之战 / 仙魔争霸 -----------------------------------------------------------
    r.role('/CSBattle/GetCsbattleHomeInfo', s.csbattle.home)
    r.role('/CSBattle/GetCSbattleInfo', s.csbattle.fight_info, type=Integer(required=False, default=0))
    r.role('/CSBattle/GetTop32CsbattleReport', s.csbattle.top32, type=Integer(required=False, default=0))
    r.role('/CSBattle/GetTopTenRankList', s.csbattle.rank_list, type=Integer(minimum=1))
    r.role('/CSBattle/GetMoreRankInfo', s.csbattle.rank_list, type=Integer(minimum=1))
    r.role('/CSBattle/GetBattleReport', s.csbattle.battle_reports, PlayerID=Raw(default=''))
    r.role('/CSBattle/GetBattleLog', s.csbattle.battle_log, id=Raw())
    r.role('/CSBattle/GetNewTeamInfo', s.csbattle.team_info, playerID=Integer(minimum=1), serverID=Raw(default=''))
    r.role('/CSBattle/GetGambleHomeInfo', s.csbattle.gamble_info, type=Integer(minimum=1))
    r.role('/CSBattle/Gamble', s.csbattle.gamble, bePlayerId=Integer(minimum=1), beServerId=Raw(default=''),
           goldRolled=Integer(minimum=0, required=False, default=0), ingotRolled=Integer(minimum=0, required=False, default=0))
    r.role('/CSBattle/GetEncourageInfo', s.csbattle.encourage_info, type=Integer(minimum=1))
    r.role('/CSBattle/Encouraging', s.csbattle.encourage, type=Integer(minimum=1))
    r.role('/CSBattle/GetRewardInfo', s.csbattle.reward_list)
    r.role('/CSBattle/Reward', s.csbattle.claim, id=Integer(minimum=1))

    # ---- 排行榜 -------------------------------------------------------------
    r.role('/RankList/GetRankList', s.ranking.rank_list, type=Integer(minimum=1))
    r.role('/RankList/ConsumeRank', s.ranking.consume_rank)
    r.role('/ActivityCommonlog/rank', s.ranking.consume_rank, type=Raw(default=''))
    return r
