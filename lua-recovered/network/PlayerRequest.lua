require("network.NotifyRequest")

PlayerRequest = NetworkRequest:new()
PlayerRequest.timeoutOperate = TimeoutOperation.eRetry

local function var_0_0(arg_1_0)
	Player:setNickName(arg_1_0.Name)
	Player:setHeaderTeamIndex(arg_1_0.AvatarIndex)
	Player:setIsRegister(arg_1_0.IRegister)
	Player:setLevel(arg_1_0.PLevel)
	Player:setPower(arg_1_0.Energy)
	Player:setMaxPower(arg_1_0.MaxEnergy)
	Player:setSoulJade(arg_1_0.SoulJade)
	Player:setTianMingExp(arg_1_0.DestinyExp)
	Player:setTianMingFrag(arg_1_0.DestinyFragment)
	Player:setPrestige(arg_1_0.Prestige)
	Player:setHonor(arg_1_0.Honor)
	Player:setKnowledge(arg_1_0.Knowledge)
	Player:setVipLevel(arg_1_0.VipLevel)
	Player:setVipExp(arg_1_0.VipExp)
	Player:setVipLevelUpExp(arg_1_0.NextVipExp)
	Player:setTrainPill(arg_1_0.TrainPill)
	Player:setExp(arg_1_0.Exp)
	Player:setLevelUpExp(arg_1_0.NextLvExp)
	Player:setGold(arg_1_0.Ingot)
	Player:setCoin(arg_1_0.Gold)
	Player:setPowerRestoreTime(arg_1_0.ETime)
	Player:setPowerRestoreTotalTime(arg_1_0.ETotalTime)
	Player:setTeam(arg_1_0.team)
	Player:setPartnerTeam(arg_1_0.partnerTeam or {})
	Player:setOwnedHeros(arg_1_0.ownedHeros or {})
	Player:setBag(arg_1_0.Others or {})
	Player:setFragments(arg_1_0.Fragments or {})
	Player:setTaskInfo(arg_1_0.Map)
	Player:setEquipInheritPoint(arg_1_0.RecastStone)
	Player:setDoubleExpTime(arg_1_0.HaveDoubleExpTime)
	Player:setLearnExp(arg_1_0.LearnExp)
	Player:setHeroExpPool(arg_1_0.HeroExp)
	Player:setIsHavePromoterGift((arg_1_0.IsHavePromoter or 0) > 0)
	Player:setPromoterName(arg_1_0.PromoterName or "")
	Player:setPlayerPromoterId(arg_1_0.PromoterId or "")
	Player:setShowSuitProp(arg_1_0.IsShowSuitProp)
	Player:setIsOpenDestiny(arg_1_0.IsOpenDestiny)
	Player:setAttrAdditionObj(arg_1_0.attributeAddition)
	Player:setVolumeGift(arg_1_0.Point)
	parseNotifyRequestJsonValue(arg_1_0.Notify)
	Player:startScheduleGlobal()
	Player:setTroMaxStep(arg_1_0.TiroMaxStep)
	EquipHelper:setOriginAllCount(arg_1_0.TalismanTotalCount)
	Player:setServerVipEnable(arg_1_0.ServerVipEnable)
	Player:setArtifactLevel(arg_1_0.ArtifactLv)
	Player:setSystemMailName(arg_1_0.SystemMailName or "大闹天宫HD运营团队")
	Player:setSystemOpenControllers(arg_1_0.FunctionOpenControllers or {})

	local var_1_0 = {
		accountId = Player.userId,
		playerName = Player.nickName,
		PlayerLevel = Player.level,
		ServerName = Player.serverInfo.ServerName,
		ServerID = Player.serverInfo.ServerID,
		playerGold = Player.curGold
	}

	IPlatform:instance():cpInfo("login", json.encode(var_1_0))
	IPlatform:instance():cpInfo("sdkServerInfo", Player.thirdLoginData)
end

function PlayerRequest.requestPlayerInfo(arg_2_0, arg_2_1)
	local var_2_0 = string.format(ServerUrl.PlayerInfo, arg_2_1, Player.deviceToken)

	arg_2_0:startHttpRequest(var_2_0, false, nil, true)
end

function PlayerRequest.parseJsonValue(arg_3_0, arg_3_1)
	var_0_0(arg_3_1)
end

NicknameRequest = NetworkRequest:new()

function NicknameRequest.requestSetNickname(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = string.format(ServerUrl.SetNicknme, Player.userId, Player.deviceToken, stringBase64AndUrlEncode(arg_4_1), arg_4_2)

	arg_4_0:startHttpRequest(var_4_0, false, nil, true)
end

function NicknameRequest.parseJsonValue(arg_5_0, arg_5_1)
	var_0_0(arg_5_1)
end

TrioMaxStepRequest = NetworkRequest:new()
TrioMaxStepRequest.timeoutOperate = TimeoutOperation.eRetry

function TrioMaxStepRequest.requestSetTrioMaxStep(arg_6_0, arg_6_1)
	local var_6_0 = string.format(ServerUrl.TrioMaxStep, Player.userId, arg_6_1)

	arg_6_0:startHttpRequest(var_6_0, false, nil, true)
end

function TrioMaxStepRequest.parseJsonValue(arg_7_0, arg_7_1)
	return
end

PlayerAvatarRequest = NetworkRequest:new()
PlayerAvatarRequest.timeoutOperate = TimeoutOperation.eRetry

function PlayerAvatarRequest.requestAvatarIndex(arg_8_0, arg_8_1)
	local var_8_0 = string.format(ServerUrl.SetAvatarIndex, Player.userId, arg_8_1)

	arg_8_0:startHttpRequest(var_8_0, false, nil, true)
end

function PlayerAvatarRequest.parseJsonValue(arg_9_0, arg_9_1)
	return
end

OfficialDirectRequest = NetworkRequest:new()
OfficialDirectRequest.timeoutOperate = TimeoutOperation.eRetry

function OfficialDirectRequest.parseJsonValue(arg_10_0, arg_10_1)
	if arg_10_1 and arg_10_1.ID ~= nil then
		Player:setUserId(arg_10_1.ID)
		var_0_0(arg_10_1)
	end

	LocalData:saveLoginAccountData()
	LocalData:saveLoginServerInfo()
end

function OfficialDirectRequest.requestDirectLogin(arg_11_0, arg_11_1)
	local var_11_0 = string.format(ServerUrl.OfficialDirectLogin, stringBase64AndUrlEncode(arg_11_1))

	arg_11_0:startHttpRequest(var_11_0, false, nil, true)
end
