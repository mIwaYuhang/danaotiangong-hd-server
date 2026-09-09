require("base.notification")

local var_0_0 = require("base.cache")

PalyerEvents = {
	eGold = "eGold",
	eFragmentCanMixture = "eFragmentCanMixture",
	eHeroSoulCanRecruit = "eHeroSoulCanRecruit",
	eSevenLoginNotice = "eSevenLoginNotice",
	ePrestige = "ePrestige",
	eHeroExpPool = "eHeroExpPool",
	eLingZhiNotice = "eLingZhiNotice",
	eActivityCenterNotice = "eActivityCenterNotice",
	eSignMonthNotice = "eSignMonthNotice",
	eLuckyDiskNotice = "eLuckyDiskNotice",
	eDarkHouse = "eDarkHouse",
	eSanHuaNotice = "eSanHuaNotice",
	eNickName = "eNickName",
	eLevel = "eLevel",
	eKnowLedge = "eKnowLedge",
	eHomeTaskNotice = "eHomeTaskNotice",
	eGrowupDisplay = "eGrowupDisplay",
	eSoulJade = "eSoulJade",
	eStoreHasFreeHero = "eStoreHasFreeHero",
	eGuildStatus = "eGuildStatus",
	eMailCount = "eMailCount",
	eLearnExp = "eLearnExp",
	eHonor = "eHonor",
	eGoldGodNotice = "eGoldGodNotice",
	eMisteryStoreRefreshed = "eMisteryStoreRefreshed",
	eVIPLevel = "eVIPLevel",
	eVolumeGift = "eVolumeGift",
	eCoin = "eCoin",
	eTianMingExp = "eTianMingExp",
	eWorldBossNotice = "eWorldBossNotice",
	eDoubleExp = "eDoubleExp",
	eFirstRechargeNotice = "eFirstRechargeNotice",
	eZhaoCaiFuNotice = "eZhaoCaiFuNotice",
	eHaveTaskReward = "eHaveTaskReward",
	eFriendRequest = "eFriendRequest",
	eDailySalaryNotice = "eDailySalaryNotice",
	eVIPExp = "eVIPExp",
	eChargeSuccess = "eChargeSuccess",
	eEquipInheritPoint = "eEquipInheritPoint",
	eTianMingFrag = "eTianMingFrag",
	eLevelGiftDisplay = "eLevelGiftDisplay",
	eCurPower = "eCurPower",
	eExp = "eExp",
	eDuel = "eDuel"
}

local var_0_1 = 1800

Player = {
	isRegister = false,
	troMaxStep = 0,
	bpTime = 0,
	knowledge = 0,
	missionTime = 0,
	prestige = 0,
	friendRequestCnt = 0,
	xmPushTime = 0,
	trainPill = 0,
	zhaoCaiFuCount = 0,
	powerRestoreTotalTime = 0,
	systemMailName = "",
	vipLevelUpExp = 0,
	equipInheritPoint = 0,
	sanHuaCount = 0,
	level = 1,
	worldBossTip = 0,
	learnExp = 0,
	curGold = 0,
	curExp = 0,
	isJiFenRankDisplay = 0,
	isHavePromoterGift = false,
	firstRechargeCount = 1,
	heroExpPool = 0,
	dailySalaryCount = 0,
	powerRestoreTime = 0,
	volumegift = 0,
	transportState = 0,
	sevenLoginCount = 0,
	lingZhiCount = 0,
	playerPromoterId = "",
	isFragmentCanMixture = false,
	mailCount = 0,
	curPower = 0,
	isOpenDestiny = 0,
	isStoreHasFreeHero = 0,
	tianMingFrag = 0,
	isMysteryStoreRefresh = 0,
	tianMingExp = 0,
	levelUpExp = 1,
	signMonthCount = 0,
	serverVipEnable = 1,
	isHaveGuild = false,
	csHaveTime = -1,
	maxPower = 1,
	isRichRankDisplay = 0,
	session = "",
	vipExp = 0,
	soulJade = 0,
	nickName = "",
	doubleExpTime = 0,
	headerTeamIndex = 1,
	luckyDiskCount = 0,
	artifactLevel = 0,
	homeTaskCount = 0,
	isShowSuitProp = 0,
	vipLevel = 0,
	activityCenterCount = 0,
	isHeroSoulCanRecruit = false,
	promoterName = "",
	thirdLoginData = "",
	curCoin = 0,
	guildStatus = false,
	currentTaskStep = 1,
	honor = 0,
	currentMissionID = 0,
	isGoldGodDisplay = 1,
	rpTime = 0,
	networkGlobal = {}
}

function Player.init(arg_1_0)
	arg_1_0.userId = nil
	arg_1_0.session = ""
	arg_1_0.thirdUserId = nil
	arg_1_0.artifactLevel = 0
	arg_1_0.duelObject = nil
	arg_1_0.darkHouse = nil
	arg_1_0.shenQiTimes = nil
	arg_1_0.biwuNXM = nil
	arg_1_0.attrAdditionObj = nil
	arg_1_0.missionData = nil
	arg_1_0.haveHerosId = nil
	arg_1_0.haveEquipsId = nil

	var_0_0.clean()
	arg_1_0:endScheduleGlobal()
	game.deleteRunningNode(Player.newMarqueeLayer)
	EquipHelper:clearData()
	TianmingHelper:clearData()
	MineralHelper:clearData()
	MasterHelper:clearData()
	TransportFriendsHelper:clear()
end

function Player.setServerInfo(arg_2_0, arg_2_1)
	arg_2_0.serverInfo = arg_2_1
end

function Player.setUserId(arg_3_0, arg_3_1)
	arg_3_0.userId = arg_3_1
end

function Player.setRequestSession(arg_4_0, arg_4_1)
	arg_4_0.session = arg_4_1
end

function Player.setThirdUserId(arg_5_0, arg_5_1)
	arg_5_0.thirdUserId = arg_5_1
end

function Player.setThirdLoginData(arg_6_0, arg_6_1)
	arg_6_0.thirdLoginData = arg_6_1
end

function Player.setDeviceToken(arg_7_0, arg_7_1)
	arg_7_0.deviceToken = arg_7_1
end

function Player.setAccount(arg_8_0, arg_8_1)
	arg_8_0.account = arg_8_1
end

function Player.setNickName(arg_9_0, arg_9_1)
	if arg_9_1 ~= arg_9_0.nickName then
		arg_9_0.nickName = arg_9_1

		Notification:postNotification(PalyerEvents.eNickName)
	end
end

function Player.setIsRegister(arg_10_0, arg_10_1)
	arg_10_0.isRegister = arg_10_1
end

function Player.setHeaderTeamIndex(arg_11_0, arg_11_1)
	arg_11_0.headerTeamIndex = arg_11_1
end

function Player.setIsOpenDestiny(arg_12_0, arg_12_1)
	arg_12_0.isOpenDestiny = arg_12_1
end

function Player.setXMPushTime(arg_13_0, arg_13_1)
	arg_13_0.xmPushTime = arg_13_1
end

function Player.setBPTime(arg_14_0, arg_14_1)
	arg_14_0.bpTime = arg_14_1

	print("BPT: " .. arg_14_0.bpTime)
end

function Player.setRPTime(arg_15_0, arg_15_1)
	arg_15_0.rpTime = arg_15_1

	print("RPT: " .. arg_15_0.rpTime)
end

function Player.setLevel(arg_16_0, arg_16_1)
	if arg_16_1 ~= arg_16_0.level and arg_16_1 >= 0 then
		arg_16_0.level = arg_16_1

		Notification:postNotification(PalyerEvents.eLevel)

		if arg_16_1 == GameFeaturesLevel[GameFeatures.ePK].level or arg_16_1 == GameFeaturesLevel[GameFeatures.eSlave1].level then
			Player:scheduleNotify()
		end

		if arg_16_0.level == GameFeaturesLevel[GameFeatures.eShenQi].level then
			Player:setArtifactLevel(1)
		end
	end
end

function Player.setVipLevel(arg_17_0, arg_17_1)
	if arg_17_1 ~= arg_17_0.vipLevel and arg_17_1 >= 0 then
		arg_17_0.vipLevel = arg_17_1

		Notification:postNotification(PalyerEvents.eVIPLevel)
		var_0_0.clean()
	end
end

function Player.setVipExp(arg_18_0, arg_18_1)
	if arg_18_1 ~= arg_18_0.vipExp and arg_18_1 >= 0 then
		arg_18_0.vipExp = arg_18_1

		Notification:postNotification(PalyerEvents.eVIPExp)
	end
end

function Player.setVipLevelUpExp(arg_19_0, arg_19_1)
	arg_19_0.vipLevelUpExp = arg_19_1
end

function Player.setPower(arg_20_0, arg_20_1)
	if arg_20_1 ~= arg_20_0.curPower and arg_20_1 >= 0 then
		arg_20_0.curPower = arg_20_1

		if arg_20_0.curPower >= arg_20_0.maxPower then
			arg_20_0.powerRestoreTime = 0
			arg_20_0.powerRestoreTotalTime = 0
		else
			arg_20_0.powerRestoreTime = arg_20_0.powerRestoreTime == 0 and var_0_1 or arg_20_0.powerRestoreTime
			arg_20_0.powerRestoreTotalTime = (arg_20_0.maxPower - arg_20_0.curPower - 1) * var_0_1 + arg_20_0.powerRestoreTime
		end

		Notification:postNotification(PalyerEvents.eCurPower)
	end
end

function Player.setHeroExpPool(arg_21_0, arg_21_1)
	if arg_21_1 ~= arg_21_0.heroExpPool and arg_21_1 >= 0 then
		arg_21_0.heroExpPool = arg_21_1

		Notification:postNotification(PalyerEvents.eHeroExpPool)
	end
end

function Player.setMaxPower(arg_22_0, arg_22_1)
	arg_22_0.maxPower = arg_22_1
end

function Player.setSoulJade(arg_23_0, arg_23_1)
	if arg_23_1 ~= arg_23_0.soulJade and arg_23_1 >= 0 then
		arg_23_0.soulJade = arg_23_1

		Notification:postNotification(PalyerEvents.eSoulJade)
	end
end

function Player.setTrainPill(arg_24_0, arg_24_1)
	arg_24_0.trainPill = arg_24_1
end

function Player.setEquipInheritPoint(arg_25_0, arg_25_1)
	if arg_25_1 ~= arg_25_0.equipInheritPoint and arg_25_1 >= 0 then
		arg_25_0.equipInheritPoint = arg_25_1

		Notification:postNotification(PalyerEvents.eEquipInheritPoint)
	end
end

function Player.setHonor(arg_26_0, arg_26_1)
	if arg_26_1 ~= arg_26_0.honor and arg_26_1 >= 0 then
		arg_26_0.honor = arg_26_1

		Notification:postNotification(PalyerEvents.eHonor)
	end
end

function Player.setPrestige(arg_27_0, arg_27_1)
	if arg_27_1 ~= arg_27_0.prestige and arg_27_1 >= 0 then
		arg_27_0.prestige = arg_27_1

		Notification:postNotification(PalyerEvents.ePrestige)
	end
end

function Player.setDoubleExpTime(arg_28_0, arg_28_1)
	if arg_28_1 ~= arg_28_0.doubleExpTime and arg_28_1 >= 0 then
		arg_28_0.doubleExpTime = arg_28_1

		Notification:postNotification(PalyerEvents.eDoubleExp)
	end
end

function Player.setLearnExp(arg_29_0, arg_29_1)
	if arg_29_1 ~= arg_29_0.learnExp and arg_29_1 >= 0 then
		arg_29_0.learnExp = arg_29_1

		Notification:postNotification(PalyerEvents.eLearnExp)
	end
end

function Player.setIsHavePromoterGift(arg_30_0, arg_30_1)
	arg_30_0.isHavePromoterGift = arg_30_1
end

function Player.setPromoterName(arg_31_0, arg_31_1)
	arg_31_0.promoterName = arg_31_1
end

function Player.setPlayerPromoterId(arg_32_0, arg_32_1)
	arg_32_0.playerPromoterId = arg_32_1
end

function Player.setPowerRestoreTime(arg_33_0, arg_33_1)
	arg_33_0.powerRestoreTime = arg_33_1
end

function Player.setPowerRestoreTotalTime(arg_34_0, arg_34_1)
	arg_34_0.powerRestoreTotalTime = arg_34_1
end

function Player.setExp(arg_35_0, arg_35_1)
	if arg_35_1 ~= arg_35_0.curExp and arg_35_1 >= 0 then
		arg_35_0.curExp = arg_35_1

		Notification:postNotification(PalyerEvents.eExp)
	end
end

function Player.setLevelUpExp(arg_36_0, arg_36_1)
	arg_36_0.levelUpExp = arg_36_1
end

function Player.setGold(arg_37_0, arg_37_1)
	if arg_37_1 ~= arg_37_0.curGold and arg_37_1 >= 0 then
		arg_37_0.curGold = arg_37_1

		Notification:postNotification(PalyerEvents.eGold)
	end
end

function Player.setCoin(arg_38_0, arg_38_1)
	if arg_38_1 ~= arg_38_0.curCoin and arg_38_1 >= 0 then
		arg_38_0.curCoin = arg_38_1

		Notification:postNotification(PalyerEvents.eCoin)
	end
end

function Player.setTotalBattlePower(arg_39_0, arg_39_1)
	if arg_39_0.team.battlePower ~= arg_39_1 and arg_39_1 >= 0 then
		if arg_39_1 > arg_39_0.team.battlePower then
			if not arg_39_0.battlePowerChangeNode then
				arg_39_0.battlePowerChangeNode = arg_39_0.newBattlePowerChangeNode({
					battlePower = arg_39_1,
					playerBattlePower = arg_39_0.team.battlePower
				})

				arg_39_0.battlePowerChangeNode:setNodeEventEnabled(true)

				function arg_39_0.battlePowerChangeNode.onExit(arg_40_0)
					if arg_39_0.battlePowerChangeNode and arg_39_0.battlePowerChangeNode.onOrignExit then
						arg_39_0.battlePowerChangeNode.onOrignExit(arg_39_0.battlePowerChangeNode)
					end

					arg_39_0.battlePowerChangeNode = nil
				end

				game.addNodeToRunningScene({
					layer = arg_39_0.battlePowerChangeNode,
					zOrder = DefaultZOrder.eMsgBox
				})
			else
				arg_39_0.battlePowerChangeNode:reloadNode({
					battlePower = arg_39_1,
					playerBattlePower = arg_39_0.team.battlePower
				})
			end
		end

		arg_39_0.team.battlePower = arg_39_1
	end
end

function Player.setKnowledge(arg_41_0, arg_41_1)
	if arg_41_1 ~= arg_41_0.knowledge then
		arg_41_0.knowledge = arg_41_1

		Notification:postNotification(PalyerEvents.eKnowLedge)
	end
end

function Player.setTeam(arg_42_0, arg_42_1)
	arg_42_0.team = arg_42_1
end

function Player.setPartnerTeam(arg_43_0, arg_43_1)
	arg_43_0.partnerTeam = arg_43_1
end

function Player.updatePartnerTeam(arg_44_0, arg_44_1, arg_44_2)
	for iter_44_0, iter_44_1 in pairs(arg_44_0.partnerTeam) do
		if iter_44_1.Index == arg_44_1 then
			iter_44_1.HeroID = arg_44_2

			break
		end
	end
end

function Player.setBag(arg_45_0, arg_45_1)
	arg_45_0.bag = arg_45_1

	arg_45_0:setIsHeroSoulCanRecruit(arg_45_0:_isHeroSoulCanRecruit())
end

function Player._isHeroSoulCanRecruit(arg_46_0)
	local var_46_0 = false

	for iter_46_0, iter_46_1 in ipairs(arg_46_0.bag) do
		var_46_0 = getItemCanRecruit(iter_46_1)

		if var_46_0 == true then
			break
		end
	end

	return var_46_0
end

function Player.setFragments(arg_47_0, arg_47_1)
	arg_47_0.fragments = arg_47_1

	arg_47_0:setIsFragmentCanMixture(arg_47_0:_isFragmentCanMixture())
end

function Player._isFragmentCanMixture(arg_48_0)
	local var_48_0 = false

	for iter_48_0, iter_48_1 in ipairs(arg_48_0.fragments) do
		iter_48_1.Type = ItemType.eFragment
		var_48_0 = getItemCanMixture(iter_48_1)

		if var_48_0 == true then
			break
		end
	end

	return var_48_0
end

function Player.setTaskInfo(arg_49_0, arg_49_1)
	arg_49_0.taskInfo = arg_49_1
end

function Player.setShowSuitProp(arg_50_0, arg_50_1)
	arg_50_0.isShowSuitProp = arg_50_1 or 0
end

function Player.setSignMonthCount(arg_51_0, arg_51_1)
	if arg_51_0.signMonthCount ~= arg_51_1 then
		arg_51_0.signMonthCount = arg_51_1

		arg_51_0:setActivityCenterCount(arg_51_0.dailySalaryCount + arg_51_0.signMonthCount + arg_51_0.sevenLoginCount + arg_51_0.luckyDiskCount + arg_51_0.lingZhiCount + arg_51_0.sanHuaCount + arg_51_0:getLevelGiftStatus() + arg_51_0:getGrowupStatus() + (arg_51_0:getGoldGodStatus() or 0))
		Notification:postNotification(PalyerEvents.eSignMonthNotice)
	end
end

function Player.setSevenLoginCount(arg_52_0, arg_52_1)
	if arg_52_0.sevenLoginCount ~= arg_52_1 then
		arg_52_0.sevenLoginCount = arg_52_1

		arg_52_0:setActivityCenterCount(arg_52_0.dailySalaryCount + arg_52_0.signMonthCount + arg_52_0.sevenLoginCount + arg_52_0.luckyDiskCount + arg_52_0.lingZhiCount + arg_52_0.sanHuaCount + arg_52_0:getLevelGiftStatus() + arg_52_0:getGrowupStatus() + (arg_52_0:getGoldGodStatus() or 0))
		Notification:postNotification(PalyerEvents.eSevenLoginNotice)
	end
end

function Player.setLuckyDiskCount(arg_53_0, arg_53_1)
	if arg_53_0.luckyDiskCount ~= arg_53_1 then
		arg_53_0.luckyDiskCount = arg_53_1

		arg_53_0:setActivityCenterCount(arg_53_0.dailySalaryCount + arg_53_0.signMonthCount + arg_53_0.sevenLoginCount + arg_53_0.luckyDiskCount + arg_53_0.lingZhiCount + arg_53_0.sanHuaCount + arg_53_0:getLevelGiftStatus() + arg_53_0:getGrowupStatus() + (arg_53_0:getGoldGodStatus() or 0))
		Notification:postNotification(PalyerEvents.eLuckyDiskNotice)
	end
end

function Player.setLingZhiCount(arg_54_0, arg_54_1)
	if arg_54_0.lingZhiCount ~= arg_54_1 then
		arg_54_0.lingZhiCount = arg_54_1

		arg_54_0:setActivityCenterCount(arg_54_0.dailySalaryCount + arg_54_0.signMonthCount + arg_54_0.sevenLoginCount + arg_54_0.luckyDiskCount + arg_54_0.lingZhiCount + arg_54_0.sanHuaCount + arg_54_0:getLevelGiftStatus() + arg_54_0:getGrowupStatus() + (arg_54_0:getGoldGodStatus() or 0))
		Notification:postNotification(PalyerEvents.eLingZhiNotice)
	end
end

function Player.setSanHuaCount(arg_55_0, arg_55_1)
	if arg_55_0.sanHuaCount ~= arg_55_1 then
		arg_55_0.sanHuaCount = arg_55_1

		arg_55_0:setActivityCenterCount(arg_55_0.dailySalaryCount + arg_55_0.signMonthCount + arg_55_0.sevenLoginCount + arg_55_0.luckyDiskCount + arg_55_0.lingZhiCount + arg_55_0.sanHuaCount + arg_55_0:getLevelGiftStatus() + arg_55_0:getGrowupStatus() + (arg_55_0:getGoldGodStatus() or 0))
		Notification:postNotification(PalyerEvents.eSanHuaNotice)
	end
end

function Player.setActivityCenterCount(arg_56_0, arg_56_1)
	if arg_56_0.activityCenterCount ~= arg_56_1 then
		arg_56_0.activityCenterCount = arg_56_1

		Notification:postNotification(PalyerEvents.eActivityCenterNotice)
	end
end

function Player.setZhaoCaiFuCount(arg_57_0, arg_57_1)
	if arg_57_0.zhaoCaiFuCount ~= arg_57_1 then
		arg_57_0.zhaoCaiFuCount = arg_57_1

		Notification:postNotification(PalyerEvents.eZhaoCaiFuNotice)
	end
end

function Player.setDailySalaryCount(arg_58_0, arg_58_1)
	if arg_58_0.dailySalaryCount ~= arg_58_1 then
		arg_58_0.dailySalaryCount = arg_58_1

		arg_58_0:setActivityCenterCount(arg_58_0.dailySalaryCount + arg_58_0.signMonthCount + arg_58_0.sevenLoginCount + arg_58_0.luckyDiskCount + arg_58_0.lingZhiCount + arg_58_0.sanHuaCount + arg_58_0:getLevelGiftStatus() + arg_58_0:getGrowupStatus() + (arg_58_0:getGoldGodStatus() or 0))
		Notification:postNotification(PalyerEvents.eDailySalaryNotice)
	end
end

function Player.setHomeTaskCount(arg_59_0, arg_59_1)
	if arg_59_0.homeTaskCount ~= arg_59_1 then
		arg_59_0.homeTaskCount = arg_59_1

		Notification:postNotification(PalyerEvents.eHomeTaskNotice)
	end
end

function Player.setFirstRechargeCount(arg_60_0, arg_60_1)
	if arg_60_0.firstRechargeCount ~= arg_60_1 then
		arg_60_0.firstRechargeCount = arg_60_1

		arg_60_0:setActivityCenterCount(arg_60_0.dailySalaryCount + arg_60_0.signMonthCount + arg_60_0.sevenLoginCount + arg_60_0.luckyDiskCount + arg_60_0.lingZhiCount + arg_60_0.sanHuaCount + arg_60_0:getLevelGiftStatus() + arg_60_0:getGrowupStatus() + (arg_60_0:getGoldGodStatus() or 0))
		Notification:postNotification(PalyerEvents.eFirstRechargeNotice)
	end
end

function Player.setIsFragmentCanMixture(arg_61_0, arg_61_1)
	if arg_61_0.isFragmentCanMixture ~= arg_61_1 then
		arg_61_0.isFragmentCanMixture = arg_61_1

		Notification:postNotification(PalyerEvents.eFragmentCanMixture)
	end
end

function Player.setIsHeroSoulCanRecruit(arg_62_0, arg_62_1)
	if arg_62_0.isHeroSoulCanRecruit ~= arg_62_1 then
		arg_62_0.isHeroSoulCanRecruit = arg_62_1

		Notification:postNotification(PalyerEvents.eHeroSoulCanRecruit)
	end
end

function Player.setDuelObject(arg_63_0, arg_63_1)
	if arg_63_0.duelObject == nil or arg_63_0.duelObject.Last ~= arg_63_1.Last then
		if arg_63_0.duelObject then
			arg_63_1.Total = arg_63_0.duelObject.Total
		end

		arg_63_0.duelObject = arg_63_1

		Notification:postNotification(PalyerEvents.eDuel)
	end
end

function Player.setDarkHouse(arg_64_0, arg_64_1)
	if arg_64_0.darkHouse == nil or arg_64_0.darkHouse.Last ~= arg_64_1.Last or arg_64_0.darkHouse.CanCapture ~= arg_64_1.CanCapture then
		if arg_64_0.darkHouse then
			arg_64_1.Total = arg_64_0.darkHouse.Total
		end

		arg_64_0.darkHouse = arg_64_1

		Notification:postNotification(PalyerEvents.eDarkHouse)
	end
end

function Player.setMailCount(arg_65_0, arg_65_1)
	if arg_65_0.mailCount ~= arg_65_1 then
		arg_65_0.mailCount = arg_65_1

		Notification:postNotification(PalyerEvents.eMailCount)
	end
end

function Player.setShenQiTimes(arg_66_0, arg_66_1)
	arg_66_0.shenQiTimes = arg_66_1
end

function Player.setBiwuNXM(arg_67_0, arg_67_1)
	arg_67_0.biwuNXM = arg_67_1

	if arg_67_0.biwuNXM then
		arg_67_0:setBPTime(arg_67_1.BPT or 0)
		arg_67_0:setRPTime(arg_67_1.RPT or 0)
	end
end

function Player.setAttrAdditionObj(arg_68_0, arg_68_1)
	arg_68_0.attrAdditionObj = arg_68_1
end

function Player.setBiwuCurrentTimes(arg_69_0, arg_69_1)
	if arg_69_0.biwuNXM then
		arg_69_0.biwuNXM.Last = arg_69_1
	end
end

function Player.setShenQiCurrentTimes(arg_70_0, arg_70_1)
	if arg_70_0.shenQiTimes then
		arg_70_0.shenQiTimes.ATimes = arg_70_1
	end
end

function Player.setCSHaveTime(arg_71_0, arg_71_1)
	arg_71_0.csHaveTime = arg_71_1
end

function Player.setLevelGiftStatus(arg_72_0, arg_72_1)
	if arg_72_0.isLevelGiftDisplay ~= arg_72_1 then
		arg_72_0.isLevelGiftDisplay = arg_72_1

		arg_72_0:setActivityCenterCount(arg_72_0.dailySalaryCount + arg_72_0.signMonthCount + arg_72_0.sevenLoginCount + arg_72_0.luckyDiskCount + arg_72_0.lingZhiCount + arg_72_0.sanHuaCount + arg_72_0:getLevelGiftStatus() + arg_72_0:getGrowupStatus() + (arg_72_0:getGoldGodStatus() or 0))
		Notification:postNotification(PalyerEvents.eLevelGiftDisplay)
	end
end

function Player.getLevelGiftStatus(arg_73_0)
	if arg_73_0.isLevelGiftDisplay == nil then
		return 0
	else
		return arg_73_0.isLevelGiftDisplay
	end
end

function Player.setGrowupStatus(arg_74_0, arg_74_1)
	if arg_74_0.isGrowupDisplay ~= arg_74_1 then
		arg_74_0.isGrowupDisplay = arg_74_1

		arg_74_0:setActivityCenterCount(arg_74_0.dailySalaryCount + arg_74_0.signMonthCount + arg_74_0.sevenLoginCount + arg_74_0.luckyDiskCount + arg_74_0.lingZhiCount + arg_74_0.sanHuaCount + arg_74_0:getLevelGiftStatus() + arg_74_0:getGrowupStatus() + (arg_74_0:getGoldGodStatus() or 0))
		Notification:postNotification(PalyerEvents.eGrowupDisplay)
	end
end

function Player.getGrowupStatus(arg_75_0)
	if arg_75_0.isGrowupDisplay == nil then
		return 0
	else
		return arg_75_0.isGrowupDisplay
	end
end

function Player.setGoldGodStatus(arg_76_0, arg_76_1)
	if arg_76_0.isGoldGodDisplay ~= arg_76_1 then
		arg_76_0.isGoldGodDisplay = arg_76_1

		arg_76_0:setActivityCenterCount(arg_76_0.dailySalaryCount + arg_76_0.signMonthCount + arg_76_0.sevenLoginCount + arg_76_0.luckyDiskCount + arg_76_0.lingZhiCount + arg_76_0.sanHuaCount + arg_76_0:getLevelGiftStatus() + arg_76_0:getGrowupStatus() + (arg_76_0:getGoldGodStatus() or 0))
		Notification:postNotification(PalyerEvents.eGoldGodNotice)
	end
end

function Player.getGoldGodStatus(arg_77_0)
	return arg_77_0.isGoldGodDisplay
end

function Player.setWorldBossTip(arg_78_0, arg_78_1)
	arg_78_1 = arg_78_1 or 0

	if arg_78_0.worldBossTip ~= arg_78_1 then
		arg_78_0.worldBossTip = arg_78_1

		Notification:postNotification(PalyerEvents.eWorldBossNotice)
	end
end

function Player.getWorldBossTip(arg_79_0)
	return arg_79_0.worldBossTip
end

function Player.setIsRichRankDisplay(arg_80_0, arg_80_1)
	arg_80_0.isRichRankDisplay = arg_80_1
end

function Player.setIsJiFenRankDisplay(arg_81_0, arg_81_1)
	arg_81_0.isJiFenRankDisplay = arg_81_1
end

function Player.setBlackMarketStatus(arg_82_0, arg_82_1)
	arg_82_0.isBlackMarketDisplay = arg_82_1
end

function Player.getBlackMarketStatus(arg_83_0)
	return arg_83_0.isBlackMarketDisplay
end

function Player.setSystemOpenControllers(arg_84_0, arg_84_1)
	arg_84_0.systemOpenControllers = arg_84_1
end

function Player.setMysteryStoreAndStoreStatus(arg_85_0, arg_85_1, arg_85_2)
	if arg_85_0.isStoreHasFreeHero ~= arg_85_1 then
		arg_85_0.isStoreHasFreeHero = arg_85_1

		Notification:postNotification(PalyerEvents.eStoreHasFreeHero)
	end

	if arg_85_0.isMysteryStoreRefresh ~= arg_85_2 then
		arg_85_0.isMysteryStoreRefresh = arg_85_2

		Notification:postNotification(PalyerEvents.eMisteryStoreRefreshed)
	end
end

function Player.setOwnedHeros(arg_86_0, arg_86_1)
	arg_86_0.ownedHeros = arg_86_1

	for iter_86_0, iter_86_1 in ipairs(arg_86_0.ownedHeros) do
		local var_86_0 = false

		for iter_86_2, iter_86_3 in ipairs(arg_86_0.team.groupList) do
			if iter_86_3.heroId == iter_86_1.heroId then
				var_86_0 = true

				break
			end
		end

		iter_86_1.isInTeam = var_86_0
	end
end

function Player.getNotInTeamOwnedHeros(arg_87_0)
	local var_87_0 = {}

	for iter_87_0, iter_87_1 in ipairs(arg_87_0.ownedHeros) do
		local var_87_1 = Player:isHeroInPartnerTeam(iter_87_1.heroId)

		if iter_87_1.isInTeam == false and var_87_1 == false then
			table.insert(var_87_0, iter_87_1)
		end
	end

	return var_87_0
end

function Player.setMissionState(arg_88_0, arg_88_1)
	if arg_88_0.missionData == nil then
		return
	end

	local var_88_0 = false

	for iter_88_0, iter_88_1 in ipairs(arg_88_0.missionData) do
		if iter_88_1.missionID == arg_88_1.MissionId then
			iter_88_1.state = arg_88_1.State
			var_88_0 = true

			if iter_88_1.state == TaskStatus.eCompleted then
				GuideLayer:showMissionReward(nil, TaskType.eTaskTeaching, iter_88_1.location.Type, 0)
			end

			break
		end
	end

	if var_88_0 == false and arg_88_1.Detail then
		table.insert(arg_88_0.missionData, arg_88_1.Detail)
	end

	arg_88_0:setHomeTaskCount(table.getn(arg_88_0.missionData))
end

function Player.deleteCompletedMission(arg_89_0, arg_89_1)
	for iter_89_0, iter_89_1 in ipairs(arg_89_0.missionData) do
		if iter_89_1.missionID == arg_89_1 and iter_89_1.state == TaskStatus.eCompleted then
			table.remove(arg_89_0.missionData, iter_89_0)

			break
		end
	end

	Notification:postNotification(PalyerEvents.eHaveTaskReward)
end

function Player.setCurrentTaskEntryType(arg_90_0, arg_90_1)
	Player.currentTaskEntryType = arg_90_1
end

function Player.getCurrentTaskEntryType(arg_91_0)
	return Player.currentTaskEntryType
end

function Player.setCurrentTaskStep(arg_92_0, arg_92_1)
	Player.currentTaskStep = arg_92_1
end

function Player.getCurrentTaskStep(arg_93_0)
	return Player.currentTaskStep
end

function Player.setCurrentMissionStageID(arg_94_0, arg_94_1)
	Player.currentMissionStageID = arg_94_1
end

function Player.getCurrentMissionStageID(arg_95_0)
	return Player.currentMissionStageID
end

function Player.setTroMaxStep(arg_96_0, arg_96_1)
	arg_96_0.troMaxStep = arg_96_1
end

function Player.getTroMaxStep(arg_97_0)
	return arg_97_0.troMaxStep
end

function Player.setTransportState(arg_98_0, arg_98_1)
	arg_98_0.transportState = arg_98_1
end

function Player.getTransportState(arg_99_0)
	return arg_99_0.transportState
end

function Player.setServerVipEnable(arg_100_0, arg_100_1)
	arg_100_0.serverVipEnable = arg_100_1
end

function Player.getServerVipEnable(arg_101_0)
	return arg_101_0.serverVipEnable
end

function Player.setFriendRequestCnt(arg_102_0, arg_102_1)
	if arg_102_1 ~= arg_102_0.friendRequestCnt then
		arg_102_0.friendRequestCnt = arg_102_1

		Notification:postNotification(PalyerEvents.eFriendRequest)
	end
end

function Player.getFriendRequestCnt(arg_103_0)
	return arg_103_0.friendRequestCnt
end

function Player.setSystemMailName(arg_104_0, arg_104_1)
	arg_104_0.systemMailName = arg_104_1
end

function Player.getSystemMailName(arg_105_0)
	return arg_105_0.systemMailName
end

function Player.setArtifactLevel(arg_106_0, arg_106_1)
	arg_106_0.artifactLevel = arg_106_1
end

function Player.isOpenXiaohuobanSystem(arg_107_0)
	return true
end

function Player.setIsHaveGuild(arg_108_0, arg_108_1)
	arg_108_0.isHaveGuild = arg_108_1
end

function Player.setGuildStatus(arg_109_0, arg_109_1)
	if arg_109_1 ~= arg_109_0.guildStatus then
		arg_109_0.guildStatus = arg_109_1

		Notification:postNotification(PalyerEvents.eGuildStatus)
	end
end

function Player.setTianMingExp(arg_110_0, arg_110_1)
	if arg_110_1 ~= arg_110_0.tianMingExp then
		arg_110_0.tianMingExp = arg_110_1

		Notification:postNotification(PalyerEvents.eTianMingExp)
	end
end

function Player.setTianMingFrag(arg_111_0, arg_111_1)
	if arg_111_1 ~= arg_111_0.tianMingFrag then
		arg_111_0.tianMingFrag = arg_111_1

		Notification:postNotification(PalyerEvents.eTianMingFrag)
	end
end

function Player.setVolumeGift(arg_112_0, arg_112_1)
	if arg_112_1 ~= arg_112_0.volumegift then
		arg_112_0.volumegift = arg_112_1

		Notification:postNotification(PalyerEvents.eVolumeGift)
	end
end

function Player.setHeroPosition(arg_113_0, arg_113_1, arg_113_2)
	if arg_113_2 <= 0 or arg_113_2 > 6 then
		return
	end

	for iter_113_0, iter_113_1 in pairs(Player.team.groupList) do
		if iter_113_1 and iter_113_1.heroId == arg_113_1 then
			iter_113_1.battleIx = arg_113_2

			break
		end
	end
end

function Player.deleteOwnedFigure(arg_114_0, arg_114_1)
	local var_114_0 = arg_114_0.ownedHeros

	for iter_114_0, iter_114_1 in ipairs(var_114_0) do
		if iter_114_1.heroId == arg_114_1 then
			table.remove(var_114_0, iter_114_0)

			break
		end
	end
end

function Player.changeOwnedFigure(arg_115_0, arg_115_1)
	local var_115_0 = false

	arg_115_1.isInTeam = false

	local var_115_1 = arg_115_0.ownedHeros

	for iter_115_0, iter_115_1 in ipairs(var_115_1) do
		if iter_115_1.heroId == arg_115_1.heroId then
			arg_115_1.isInTeam = var_115_1[iter_115_0].isInTeam
			var_115_1[iter_115_0] = arg_115_1
			var_115_0 = true

			break
		end
	end

	if var_115_0 == false then
		arg_115_1.isInTeam = false

		table.insert(var_115_1, arg_115_1)

		if arg_115_0.haveHerosId then
			table.insert(arg_115_0.haveHerosId, arg_115_1.heroId)
		end
	end
end

function Player.getOwnedFigure(arg_116_0, arg_116_1)
	local var_116_0

	for iter_116_0, iter_116_1 in ipairs(arg_116_0.ownedHeros) do
		if iter_116_1.heroId == arg_116_1 then
			var_116_0 = iter_116_1

			break
		end
	end

	return var_116_0
end

function Player.changeBagItem(arg_117_0, arg_117_1, arg_117_2)
	if arg_117_1.Type ~= ItemType.eProp and arg_117_1.Type ~= ItemType.eMate and arg_117_1.Type ~= ItemType.eSoul then
		return
	end

	local var_117_0 = false

	for iter_117_0, iter_117_1 in ipairs(arg_117_0.bag) do
		if iter_117_1.Type == arg_117_1.Type and iter_117_1.ID == arg_117_1.ID then
			iter_117_1.Count = arg_117_2 == true and iter_117_1.Count + arg_117_1.Count or iter_117_1.Count - arg_117_1.Count

			if iter_117_1.Count <= 0 then
				table.remove(arg_117_0.bag, iter_117_0)
			end

			var_117_0 = true

			break
		end
	end

	if var_117_0 == false and arg_117_2 == true then
		table.insert(arg_117_0.bag, arg_117_1)
	end

	arg_117_0:setIsHeroSoulCanRecruit(arg_117_0:_isHeroSoulCanRecruit())
end

function Player.setBagItemsCount(arg_118_0, arg_118_1)
	for iter_118_0, iter_118_1 in ipairs(arg_118_1 or {}) do
		for iter_118_2, iter_118_3 in ipairs(arg_118_0.bag) do
			if iter_118_3.Type == iter_118_1.Type and iter_118_3.ID == iter_118_1.ID then
				iter_118_3.Count = iter_118_1.Count

				break
			end
		end
	end
end

function Player.changeTianmingItem(arg_119_0, arg_119_1, arg_119_2)
	if arg_119_2 == false then
		if arg_119_1.Type == ItemType.eTianMing then
			TianmingHelper:delete(arg_119_1.ID)
		elseif arg_119_1.Type == ItemType.eTianMingExp then
			Player:setTianMingExp(arg_119_0.tianMingExp - arg_119_1.Count)
		elseif arg_119_1.Type == ItemType.eTianMingFrag then
			Player:setTianMingFrag(arg_119_0.tianMingFrag - arg_119_1.Count)
		end
	elseif arg_119_2 == true then
		if arg_119_1.Type == ItemType.eTianMingExp then
			Player:setTianMingExp(arg_119_0.tianMingExp + arg_119_1.Count)
		elseif arg_119_1.Type == ItemType.eTianMingFrag then
			Player:setTianMingFrag(arg_119_0.tianMingFrag + arg_119_1.Count)
		end
	end
end

function Player.changeFragmentsItem(arg_120_0, arg_120_1, arg_120_2)
	if arg_120_1.Type ~= ItemType.eFragment then
		return
	end

	local var_120_0 = false

	for iter_120_0, iter_120_1 in ipairs(arg_120_0.fragments) do
		if iter_120_1.ID == arg_120_1.ID then
			iter_120_1.Count = arg_120_2 == true and iter_120_1.Count + arg_120_1.Count or iter_120_1.Count - arg_120_1.Count

			if iter_120_1.Count <= 0 then
				table.remove(arg_120_0.fragments, iter_120_0)
			end

			var_120_0 = true

			break
		end
	end

	if var_120_0 == false and arg_120_2 == true then
		table.insert(arg_120_0.fragments, arg_120_1)
	end

	if arg_120_2 == true then
		arg_120_0:setIsFragmentCanMixture(arg_120_0:_isFragmentCanMixture())
	end
end

function Player.updateMapPoint(arg_121_0, arg_121_1, arg_121_2, arg_121_3, arg_121_4)
	local var_121_0 = false

	for iter_121_0, iter_121_1 in ipairs(arg_121_0.taskInfo.Point) do
		if iter_121_1.PID == arg_121_1 then
			iter_121_1.Star = arg_121_2
			iter_121_1.COD = arg_121_3
			var_121_0 = true

			break
		end
	end

	if var_121_0 == false then
		table.insert(arg_121_0.taskInfo.Point, {
			PID = arg_121_1,
			Star = arg_121_2,
			COD = arg_121_3
		})
	end

	arg_121_0.taskInfo.MaxPID = arg_121_4 > arg_121_0.taskInfo.MaxPID and arg_121_4 or arg_121_0.taskInfo.MaxPID
end

function Player.updateMapFullStarInfo(arg_122_0, arg_122_1)
	local var_122_0 = false

	for iter_122_0, iter_122_1 in ipairs(arg_122_0.taskInfo.ListSamsung) do
		if iter_122_1 == arg_122_1 then
			var_122_0 = true
		end
	end

	if not var_122_0 then
		table.insert(arg_122_0.taskInfo.ListSamsung, arg_122_1)
	end
end

function Player.setTaskTenBattleRestoreTime(arg_123_0, arg_123_1)
	if arg_123_0.taskInfo then
		arg_123_0.taskInfo.CdTime = arg_123_1
	end
end

function Player.setTaskTenBattleIngot(arg_124_0, arg_124_1)
	if arg_124_0.taskInfo then
		arg_124_0.taskInfo.BattleTenIngot = arg_124_1

		print("冷却消耗元宝: " .. arg_124_0.taskInfo.BattleTenIngot)
	end
end

function Player.getTeamHeroInfoById(arg_125_0, arg_125_1)
	for iter_125_0, iter_125_1 in ipairs(arg_125_0.team.groupList) do
		if iter_125_1.heroId == arg_125_1 then
			return iter_125_1
		end
	end
end

function Player.getItemCount(arg_126_0, arg_126_1, arg_126_2)
	local var_126_0
	local var_126_1

	local function var_126_2(arg_127_0, arg_127_1)
		for iter_127_0, iter_127_1 in ipairs(arg_127_0) do
			if arg_127_1(iter_127_1) then
				return iter_127_1
			end
		end
	end

	if arg_126_1 == ItemType.eSoul or arg_126_1 == ItemType.eProp or arg_126_1 == ItemType.eMate then
		local var_126_3 = var_126_2(Player.bag, function(arg_128_0)
			return arg_128_0.ID == arg_126_2 and arg_128_0.Type == arg_126_1
		end)

		var_126_1 = var_126_3 and var_126_3.Count or 0
	elseif arg_126_1 == ItemType.eFragment then
		local var_126_4 = var_126_2(Player.fragments, function(arg_129_0)
			return arg_129_0.ID == arg_126_2
		end)

		var_126_1 = var_126_4 and var_126_4.Count or 0
	elseif arg_126_1 == ItemType.eHero then
		var_126_1 = var_126_2(Player.ownedHeros, function(arg_130_0)
			return arg_130_0.heroId == arg_126_2
		end) and 1 or 0
	else
		local var_126_5 = ({
			[ItemType.eCoin] = "curCoin",
			[ItemType.eGold] = "curGold",
			[ItemType.eSoulJade] = "soulJade",
			[ItemType.eKnowledge] = "knowledge",
			[ItemType.eTianMingFrag] = "tianMingFrag"
		})[arg_126_1]

		if var_126_5 then
			var_126_1 = Player[var_126_5]
		end
	end

	return var_126_1
end

function Player.newMarqueeLayer(arg_131_0)
	return (require("scenes.home.MarqueeLayer").new(arg_131_0))
end

function Player.startScheduleGlobal(arg_132_0)
	local function var_132_0(arg_133_0)
		arg_132_0.taskInfo.CdTime = arg_132_0.taskInfo.CdTime - arg_133_0

		if arg_132_0.taskInfo.CdTime < 0 then
			arg_132_0.taskInfo.CdTime = 0
		end

		if arg_132_0.doubleExpTime > 0 then
			local var_133_0 = arg_132_0.doubleExpTime - arg_133_0

			if var_133_0 >= 0 then
				arg_132_0:setDoubleExpTime(var_133_0)
			else
				arg_132_0:setDoubleExpTime(0)
			end
		end

		arg_132_0.powerRestoreTime = arg_133_0 > arg_132_0.powerRestoreTime and 0 or arg_132_0.powerRestoreTime - arg_133_0
		arg_132_0.powerRestoreTotalTime = arg_133_0 > arg_132_0.powerRestoreTotalTime and 0 or arg_132_0.powerRestoreTotalTime - arg_133_0

		if arg_132_0.powerRestoreTime == 0 and arg_132_0.curPower < arg_132_0.maxPower then
			arg_132_0:setPower(arg_132_0.curPower + 1)

			arg_132_0.powerRestoreTime = var_0_1
		end
	end

	local function var_132_1()
		if arg_132_0.userId and arg_132_0.session and string.len(arg_132_0.session) > 1 then
			local var_134_0 = require("network.AnnouncementRequest"):new()

			var_134_0:request()

			local function var_134_1()
				game.deleteRunningNode(Player.newMarqueeLayer)
			end

			local function var_134_2()
				local var_136_0 = var_134_0.restable
				local var_136_1 = Player.newMarqueeLayer

				if table.nums(var_136_0) == 0 then
					game.deleteRunningNode(var_136_1)

					return
				end

				if game.isFuncRunningNode(var_136_1) then
					game.reloadRunningNode(var_136_1, {
						data = var_136_0,
						callback = var_134_1
					})
				else
					game.addNodeToRunningSceneWithAutoCreate({
						ctorFunc = var_136_1,
						data = {
							data = var_136_0,
							callback = var_134_1
						},
						zOrder = DefaultZOrder.eGameAnnounce,
						ignoreScenes = {
							"FubenIndexScene",
							"PKScene",
							"AnnouncementScene",
							"ZSQHomeScene"
						}
					})
				end
			end

			var_134_0:setResponseNormalHandler(var_134_2)
		end
	end

	arg_132_0.scheduleHandle = require("framework.scheduler").scheduleGlobal(var_132_0, 1)
	arg_132_0.scheduleNotifyHandle = require("framework.scheduler").scheduleGlobal(handler(arg_132_0, arg_132_0.scheduleNotify), 60)
	arg_132_0.scheduleAnnouncementHandle = require("framework.scheduler").scheduleGlobal(var_132_1, 180)

	var_132_1()
end

function Player.scheduleNotify(arg_137_0)
	if arg_137_0.userId and arg_137_0.session and string.len(arg_137_0.session) > 1 then
		local var_137_0 = require("network.NotifyRequest"):new()

		var_137_0:requestNotifyInfo()

		local function var_137_1()
			return
		end

		var_137_0:setResponseNormalHandler(var_137_1)
	end
end

function Player.endScheduleGlobal(arg_139_0)
	if arg_139_0.scheduleHandle then
		require("framework.scheduler").unscheduleGlobal(arg_139_0.scheduleHandle)
	end

	if arg_139_0.scheduleNotifyHandle then
		require("framework.scheduler").unscheduleGlobal(arg_139_0.scheduleNotifyHandle)
	end

	if arg_139_0.scheduleAnnouncementHandle then
		require("framework.scheduler").unscheduleGlobal(arg_139_0.scheduleAnnouncementHandle)
	end
end

function Player.manualChangeGlobalAttrs(arg_140_0, arg_140_1)
	if arg_140_0.networkGlobal[arg_140_1] == nil then
		return nil, nil
	end

	local var_140_0 = arg_140_0.networkGlobal[arg_140_1]

	if var_140_0.Slots then
		local var_140_1 = EquipHelper:getAllHeroEquips(arg_140_0.team.groupList)
		local var_140_2 = TianmingHelper:getAllHeroTianmings(arg_140_0.team.groupList)

		for iter_140_0, iter_140_1 in ipairs(var_140_0.Slots) do
			local var_140_3 = false

			for iter_140_2 = 1, table.getn(arg_140_0.team.groupList) do
				if arg_140_0.team.groupList[iter_140_2].battleIx == iter_140_1.battleIx then
					var_140_3 = true
					arg_140_0.team.groupList[iter_140_2] = iter_140_1

					break
				end
			end

			if var_140_3 == false then
				table.insert(arg_140_0.team.groupList, iter_140_1)
			end
		end

		local var_140_4 = EquipHelper:getAllHeroEquips(arg_140_0.team.groupList)
		local var_140_5 = TianmingHelper:getAllHeroTianmings(arg_140_0.team.groupList)

		EquipHelper:compareEquipListBeforeEquipChange(var_140_1, var_140_4)
		TianmingHelper:compareTianmingListChange(var_140_2, var_140_5)

		local var_140_6 = 0

		for iter_140_3, iter_140_4 in ipairs(arg_140_0.team.groupList) do
			var_140_6 = var_140_6 + iter_140_4.battlePower
		end

		arg_140_0:setTotalBattlePower(var_140_6)
	end

	local var_140_7 = arg_140_0.level

	if var_140_0.Resource then
		if var_140_0.Resource.Ingot then
			arg_140_0:setGold(var_140_0.Resource.Ingot)
		end

		if var_140_0.Resource.Gold then
			arg_140_0:setCoin(var_140_0.Resource.Gold)
		end

		if var_140_0.Resource.Energy then
			arg_140_0:setPower(var_140_0.Resource.Energy)
		end

		if var_140_0.Resource.MaxEnergy then
			arg_140_0:setMaxPower(var_140_0.Resource.MaxEnergy)
		end

		if var_140_0.Resource.HeroExp then
			arg_140_0:setHeroExpPool(var_140_0.Resource.HeroExp)
		end

		if var_140_0.Resource.Honor then
			arg_140_0:setHonor(var_140_0.Resource.Honor)
		end

		if var_140_0.Resource.SoulJade then
			arg_140_0:setSoulJade(var_140_0.Resource.SoulJade)
		end

		if var_140_0.Resource.Prestige then
			arg_140_0:setPrestige(var_140_0.Resource.Prestige)
		end

		if var_140_0.Resource.Exp then
			arg_140_0:setExp(var_140_0.Resource.Exp)
		end

		if var_140_0.Resource.NextLvExp then
			arg_140_0:setLevelUpExp(var_140_0.Resource.NextLvExp)
		end

		if var_140_0.Resource.Level then
			arg_140_0:setLevel(var_140_0.Resource.Level)
		end

		if var_140_0.Resource.Knowledge then
			arg_140_0:setKnowledge(var_140_0.Resource.Knowledge)
		end

		if var_140_0.Resource.TrainPill then
			arg_140_0:setTrainPill(var_140_0.Resource.TrainPill)
		end

		if var_140_0.Resource.VipLevel then
			arg_140_0:setVipLevel(var_140_0.Resource.VipLevel)
		end

		if var_140_0.Resource.VipExp then
			arg_140_0:setVipExp(var_140_0.Resource.VipExp)
		end

		if var_140_0.Resource.NextVipExp then
			arg_140_0:setVipLevelUpExp(var_140_0.Resource.NextVipExp)
		end

		if var_140_0.Resource.RecastStone then
			arg_140_0:setEquipInheritPoint(var_140_0.Resource.RecastStone)
		end

		if var_140_0.Resource.HaveDoubleExpTime then
			arg_140_0:setDoubleExpTime(var_140_0.Resource.HaveDoubleExpTime)
		end

		if var_140_0.Resource.LearnExp then
			arg_140_0:setLearnExp(var_140_0.Resource.LearnExp)
		end

		if var_140_0.Resource.Point then
			arg_140_0:setVolumeGift(var_140_0.Resource.Point)
		end

		if var_140_0.Resource.RL then
			for iter_140_5, iter_140_6 in ipairs(var_140_0.Resource.RL) do
				local var_140_8 = {
					currencyType = "CNY",
					orderId = iter_140_6.orderId,
					currencyAmount = iter_140_6.Money,
					paymentType = IPlatform:instance():getConfig("Channel")
				}

				IPlatform:instance():cpInfo("onChargeOnlySuccess", json.encode(var_140_8))
			end

			Notification:postNotification(PalyerEvents.eChargeSuccess)
		end
	end

	if var_140_0.Heros then
		for iter_140_7, iter_140_8 in ipairs(var_140_0.Heros) do
			arg_140_0:changeOwnedFigure(iter_140_8)

			for iter_140_9, iter_140_10 in ipairs(arg_140_0.team.groupList) do
				if iter_140_10.heroId == iter_140_8.heroId then
					iter_140_10.curExp = iter_140_8.curExp
					iter_140_10.potency = iter_140_8.potency

					break
				end
			end
		end
	end

	if var_140_0.ViceHeros then
		for iter_140_11, iter_140_12 in ipairs(var_140_0.ViceHeros) do
			arg_140_0:changeOwnedFigure(iter_140_12)
		end
	end

	if var_140_0.Destinys then
		for iter_140_13, iter_140_14 in ipairs(var_140_0.Destinys) do
			TianmingHelper:change(iter_140_14)
		end
	end

	if var_140_0.Gems then
		MineralHelper:addItem(var_140_0.Gems)
	end

	if var_140_0.Talismans then
		for iter_140_15, iter_140_16 in ipairs(var_140_0.Talismans) do
			EquipHelper:changeOneEquip(iter_140_16)

			if arg_140_0.haveEquipsId then
				table.insert(arg_140_0.haveEquipsId, iter_140_16.equipId)
			end
		end
	end

	if var_140_0.Slots then
		arg_140_0:setOwnedHeros(arg_140_0.ownedHeros)
	end

	if var_140_0.Missions then
		for iter_140_17, iter_140_18 in ipairs(var_140_0.Missions) do
			arg_140_0:setMissionState(iter_140_18)
		end
	end

	if var_140_0.Consume then
		for iter_140_19, iter_140_20 in ipairs(var_140_0.Consume) do
			arg_140_0:changeBagItem(iter_140_20, false)
			arg_140_0:changeFragmentsItem(iter_140_20, false)
			arg_140_0:changeTianmingItem(iter_140_20, false)

			if iter_140_20.Type == ItemType.eMaster then
				MasterHelper:deleteActiveMaster(iter_140_20.ID, iter_140_20.Count)
			end
		end
	end

	if var_140_0.Reward then
		for iter_140_21, iter_140_22 in ipairs(var_140_0.Reward) do
			arg_140_0:changeBagItem(iter_140_22, true)
			arg_140_0:changeFragmentsItem(iter_140_22, true)
			arg_140_0:changeTianmingItem(iter_140_22, true)

			if iter_140_22.Type == ItemType.eMaster then
				MasterHelper:addActiveMaster(iter_140_22.ID, iter_140_22.Count)
			end
		end

		if var_140_0.isNoticeReward == true then
			local var_140_9 = var_140_0.Reward

			if var_140_9 and #var_140_9 > 0 then
				local var_140_10 = require("scenes.ToolLayer")

				var_140_10.createToast({
					show = var_140_10.eShowReward,
					rewards = var_140_9
				}):show()
			end
		end
	end

	if var_140_0.LvUpReward and var_140_7 < arg_140_0.level then
		local var_140_11 = require("scenes.map.PlayerLvlupLayer").new({
			levelnew = arg_140_0.level,
			levelold = var_140_7,
			reward = var_140_0.LvUpReward
		})

		var_140_11:setScale(Adapter.MinScale)
		game.addNodeToRunningScene({
			layer = var_140_11,
			zOrder = DefaultZOrder.eLevelUp
		})

		local var_140_12 = {
			level = arg_140_0.level
		}

		IPlatform:instance():cpInfo("setLevel", json.encode(var_140_12))
	end

	local var_140_13 = clone(var_140_0.Consume)
	local var_140_14 = clone(var_140_0.Reward)

	arg_140_0.networkGlobal[arg_140_1] = nil

	return var_140_13, var_140_14
end

function Player.addGlobalAttrs(arg_141_0, arg_141_1, arg_141_2, arg_141_3)
	arg_141_2.isNoticeReward = arg_141_3
	arg_141_0.networkGlobal[arg_141_1] = arg_141_2
end

function Player.newBattlePowerChangeNode(arg_142_0)
	local var_142_0 = arg_142_0.playerBattlePower
	local var_142_1 = display.newSprite("ui/home/home_045.png")

	var_142_1.battlePower = arg_142_0.battlePower or var_142_0
	var_142_1.offset = var_142_1.battlePower - var_142_0

	function var_142_1.onOrignExit(arg_143_0)
		if arg_143_0.actionHandle then
			require("framework.scheduler").unscheduleGlobal(arg_143_0.actionHandle)

			arg_143_0.actionHandle = nil
		end
	end

	var_142_1.noticeSprite = CCSprite:create("uilocal/home/home_text_000.png")

	var_142_1.noticeSprite:setPosition(ccp(143, 33))
	var_142_1:addChild(var_142_1.noticeSprite)

	var_142_1.valueLabel = CCLabelAtlas:create(tostring(Player.team.battlePower), "ui/home/home_000_big.png", 34, 50, 48, 6)

	var_142_1.valueLabel:setAnchorPoint(CCPoint(0, 0.5))
	var_142_1.valueLabel:setPosition(ccp(183, 33))
	var_142_1.valueLabel:setString(tostring(var_142_0))
	var_142_1:addChild(var_142_1.valueLabel)

	var_142_1.aniTime, var_142_1.timeBattlePower = 0, 0

	function var_142_1.valueActionUpdate(arg_144_0)
		var_142_1.aniTime = var_142_1.aniTime + arg_144_0
		var_142_1.timeBattlePower = math.floor(var_142_1.battlePower - var_142_1.offset * (1 - var_142_1.aniTime))

		var_142_1.valueLabel:setString(tostring(var_142_1.timeBattlePower))

		if var_142_1.aniTime > 1 and var_142_1.actionHandle then
			var_142_1.valueLabel:setString(tostring(var_142_1.battlePower))
			require("framework.scheduler").unscheduleGlobal(var_142_1.actionHandle)

			var_142_1.actionHandle = nil

			var_142_1.noticeSprite:runAction(CCFadeOut:create(1.5))
			var_142_1.valueLabel:runAction(CCFadeOut:create(1.5))

			local var_144_0 = CCFadeOut:create(1.5)

			var_142_1:runAction(CCSequence:createWithTwoActions(var_144_0, CCCallFunc:create(function()
				var_142_1:removeFromParent()
			end)))
		end
	end

	var_142_1.actionHandle = require("framework.scheduler").scheduleUpdateGlobal(var_142_1.valueActionUpdate)

	var_142_1:setPosition(ccp(display.cx, display.height - 50))

	function var_142_1.reloadNode(arg_146_0, arg_146_1)
		arg_146_0:stopAllActions()
		arg_146_0.noticeSprite:stopAllActions()
		arg_146_0.valueLabel:stopAllActions()
		arg_146_0:setOpacity(255)
		arg_146_0.noticeSprite:setOpacity(255)
		arg_146_0.valueLabel:setOpacity(255)

		arg_146_0.battlePower = arg_146_1.battlePower
		arg_146_0.offset = arg_146_1.battlePower - arg_146_0.timeBattlePower
		arg_146_0.aniTime = 0

		if not arg_146_0.actionHandle then
			arg_146_0.actionHandle = require("framework.scheduler").scheduleUpdateGlobal(arg_146_0.valueActionUpdate)
		end
	end

	return var_142_1
end

function Player.isHeroInPartnerTeam(arg_147_0, arg_147_1)
	local var_147_0 = false

	for iter_147_0, iter_147_1 in pairs(arg_147_0.partnerTeam) do
		if iter_147_1.HeroID == arg_147_1 then
			var_147_0 = true

			break
		end
	end

	return var_147_0
end

function Player.isHerosInteam(arg_148_0, arg_148_1, arg_148_2, arg_148_3)
	local var_148_0 = true
	local var_148_1 = {}

	for iter_148_0, iter_148_1 in ipairs(arg_148_1) do
		local var_148_2 = false

		for iter_148_2, iter_148_3 in ipairs(arg_148_2 and arg_148_2.groupList or arg_148_0.team.groupList) do
			if iter_148_3.heroId == iter_148_1 then
				var_148_2 = true

				break
			end
		end

		if var_148_2 == false then
			for iter_148_4, iter_148_5 in pairs(arg_148_3 or arg_148_0.partnerTeam) do
				if iter_148_5.HeroID == iter_148_1 then
					var_148_2 = true

					break
				end
			end
		end

		var_148_1[iter_148_1] = var_148_2

		if var_148_2 == false then
			var_148_0 = false
		end
	end

	return var_148_0, var_148_1
end

function Player.isTianmingInteam(arg_149_0, arg_149_1)
	local var_149_0 = 0

	for iter_149_0, iter_149_1 in ipairs(arg_149_0.team.groupList) do
		if iter_149_1.destinyList then
			for iter_149_2, iter_149_3 in ipairs(iter_149_1.destinyList) do
				if iter_149_3.destiny and iter_149_3.destiny.id == arg_149_1 then
					var_149_0 = 1

					break
				end
			end
		end
	end

	return var_149_0
end
