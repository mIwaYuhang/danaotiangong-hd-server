PlayerTeamRequest = NetworkRequest:new()
PlayerTeamRequest.timeoutOperate = TimeoutOperation.eRetry

function PlayerTeamRequest.request(arg_1_0, arg_1_1)
	local var_1_0 = string.format(ServerUrl.PlayerTeam, Player.userId, arg_1_1 or "")

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function PlayerTeamRequest.requestZSZZ(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = string.format(ServerUrl.ZSZZGetTeamInfo, Player.userId, arg_2_1, arg_2_2)

	arg_2_0:startHttpRequest(var_2_0, false, nil, true)
end

function PlayerTeamRequest.parseJsonValue(arg_3_0, arg_3_1)
	arg_3_0.restable = arg_3_1
end

function PlayerTeamRequest.getPlayerTeamAndPartnerTeam(arg_4_0)
	return arg_4_0.restable.team, arg_4_0.restable.partnerTeam, arg_4_0.restable.attributeAddition
end

ChangeHeroRequest = NetworkRequest:new()

function ChangeHeroRequest.request(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = string.format(ServerUrl.ChangeHero, Player.userId, arg_5_1, arg_5_2)

	arg_5_0:startHttpRequest(var_5_0, false, nil, true)
end

function ChangeHeroRequest.parseJsonValue(arg_6_0, arg_6_1)
	return
end

ChangeXiaohuobanRequest = NetworkRequest:new()

function ChangeXiaohuobanRequest.request(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = string.format(ServerUrl.ChangeXiaohuoban, Player.userId, arg_7_1, arg_7_2)

	arg_7_0:startHttpRequest(var_7_0, false, nil, true)
end

function ChangeXiaohuobanRequest.parseJsonValue(arg_8_0, arg_8_1)
	Player:updatePartnerTeam(arg_8_1.Index, arg_8_1.HeroID)
end

HeroTrainRequest = NetworkRequest:new()

function HeroTrainRequest.request(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = string.format(ServerUrl.HeroTrain, Player.userId, arg_9_1, arg_9_2, tostring(arg_9_3))

	arg_9_0:startHttpRequest(var_9_0, false, nil, true)
end

function HeroTrainRequest.parseJsonValue(arg_10_0, arg_10_1)
	arg_10_0.restable = arg_10_1
end

HeroSaveTrainRequest = NetworkRequest:new()

function HeroSaveTrainRequest.request(arg_11_0, arg_11_1)
	local var_11_0 = string.format(ServerUrl.HeroSaveTrain, Player.userId, arg_11_1)

	arg_11_0:startHttpRequest(var_11_0, false, nil, true)
end

function HeroSaveTrainRequest.parseJsonValue(arg_12_0, arg_12_1)
	return
end

HeroRebirthRequest = NetworkRequest:new()

function HeroRebirthRequest.request(arg_13_0, arg_13_1)
	local var_13_0 = string.format(ServerUrl.HeroRebirth, Player.userId, arg_13_1)

	arg_13_0:startHttpRequest(var_13_0, false, nil, true)
end

function HeroRebirthRequest.parseJsonValue(arg_14_0, arg_14_1)
	return
end

HeroUnloadEquipRequest = NetworkRequest:new()

function HeroUnloadEquipRequest.request(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = string.format(ServerUrl.HeroUnloadEquip, Player.userId, arg_15_1, arg_15_2, arg_15_3)

	arg_15_0:startHttpRequest(var_15_0, false, nil, true)
end

function HeroUnloadEquipRequest.parseJsonValue(arg_16_0, arg_16_1)
	return
end

HeroChangeEquipRequest = NetworkRequest:new()

function HeroChangeEquipRequest.request(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = string.format(ServerUrl.HeroChangeEquip, Player.userId, arg_17_1, arg_17_2, arg_17_3)

	arg_17_0:startHttpRequest(var_17_0, false, nil, true)
end

function HeroChangeEquipRequest.parseJsonValue(arg_18_0, arg_18_1)
	return
end

EqupListRequest = NetworkRequest:new()
EqupListRequest.timeoutOperate = TimeoutOperation.eRetry

function EqupListRequest.request(arg_19_0)
	local var_19_0 = string.format(ServerUrl.UserEquipList, Player.userId)

	arg_19_0:startHttpRequest(var_19_0, false, nil, true)
end

function EqupListRequest.parseJsonValue(arg_20_0, arg_20_1)
	arg_20_0.restable = arg_20_1
end

function EqupListRequest.getEquipList(arg_21_0)
	return arg_21_0.restable
end

EquipEnhanceRequest = NetworkRequest:new()

function EquipEnhanceRequest.request(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = string.format(ServerUrl.EquipEnhance, Player.userId, arg_22_1, tostring(arg_22_2))

	arg_22_0:startHttpRequest(var_22_0, false, nil, true)
end

function EquipEnhanceRequest.parseJsonValue(arg_23_0, arg_23_1)
	arg_23_0.restable = arg_23_1

	EquipHelper:changeOneEquip(arg_23_1.Operator.Talisman)
end

EquipInheritRequest = NetworkRequest:new()

function EquipInheritRequest.request(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_2 == nil then
		arg_24_2 = 1
	end

	local var_24_0 = string.format(ServerUrl.EquipInherit, Player.userId, arg_24_1, arg_24_2)

	arg_24_0:startHttpRequest(var_24_0, false, nil, true)
end

function EquipInheritRequest.parseJsonValue(arg_25_0, arg_25_1)
	arg_25_0.restable = arg_25_1

	EquipHelper:changeOneEquip(arg_25_1.Talisman)
end

EquipLockInfoRequest = NetworkRequest:new()
EquipLockInfoRequest.timeoutOperate = EquipLockInfoRequest.eRetry

function EquipLockInfoRequest.request(arg_26_0, arg_26_1)
	local var_26_0 = string.format(ServerUrl.EquipLockInfo, Player.userId, arg_26_1)

	arg_26_0:startHttpRequest(var_26_0, false, nil, true)
end

function EquipLockInfoRequest.parseJsonValue(arg_27_0, arg_27_1)
	arg_27_0.restable = arg_27_1
end

EquipLockLevelRequest = NetworkRequest:new()

function EquipLockLevelRequest.request(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = string.format(ServerUrl.EquipLockLevel, Player.userId, arg_28_1, arg_28_2)

	arg_28_0:startHttpRequest(var_28_0, false, nil, true)
end

function EquipLockLevelRequest.parseJsonValue(arg_29_0, arg_29_1)
	arg_29_0.restable = arg_29_1
end

EquipFeedRequest = NetworkRequest:new()

function EquipFeedRequest.request(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = string.format(ServerUrl.EquipFeed, Player.userId, arg_30_1, arg_30_2, arg_30_3)

	arg_30_0:startHttpRequest(var_30_0, false, nil, true)
end

function EquipFeedRequest.parseJsonValue(arg_31_0, arg_31_1)
	arg_31_0.restable = arg_31_1

	if arg_31_1.Consume then
		for iter_31_0, iter_31_1 in pairs(arg_31_1.Consume) do
			if iter_31_1.Type == ItemType.eEquip then
				EquipHelper:deleteOneEquip(iter_31_1.ID)
			end
		end
	end

	if arg_31_1.Operator.Talisman then
		EquipHelper:changeOneEquip(arg_31_1.Operator.Talisman)
	end
end

HeroRageSkillTrainRequest = NetworkRequest:new()

function HeroRageSkillTrainRequest.request(arg_32_0, arg_32_1)
	local var_32_0 = string.format(ServerUrl.HeroRageSkillTrain, Player.userId, arg_32_1)

	arg_32_0:startHttpRequest(var_32_0, false, nil, true)
end

function HeroRageSkillTrainRequest.parseJsonValue(arg_33_0, arg_33_1)
	arg_33_0.trainResult = arg_33_1
end

function HeroRageSkillTrainRequest.getTrainResult(arg_34_0)
	return arg_34_0.trainResult
end

InheritPreviewRequest = NetworkRequest:new()

function InheritPreviewRequest.request(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = string.format(ServerUrl.InheritPreview, Player.userId, arg_35_1, arg_35_2)

	arg_35_0:startHttpRequest(var_35_0, false, nil, true)
end

function InheritPreviewRequest.parseJsonValue(arg_36_0, arg_36_1)
	arg_36_0.restable = arg_36_1
end

HeroInheritRequest = NetworkRequest:new()

function HeroInheritRequest.request(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = string.format(ServerUrl.HeroInherit, Player.userId, arg_37_1, arg_37_2, tostring(arg_37_3))

	arg_37_0:startHttpRequest(var_37_0, false, nil, true)
end

function HeroInheritRequest.parseJsonValue(arg_38_0, arg_38_1)
	arg_38_0.restable = arg_38_1
end

ChangeAllEquipRequest = NetworkRequest:new()

function ChangeAllEquipRequest.request(arg_39_0, arg_39_1)
	local var_39_0 = string.format(ServerUrl.ChangeAllEquip, Player.userId, arg_39_1)

	arg_39_0:startHttpRequest(var_39_0, false, nil, true)
end

function ChangeAllEquipRequest.parseJsonValue(arg_40_0, arg_40_1)
	arg_40_0.restable = arg_40_1
end
