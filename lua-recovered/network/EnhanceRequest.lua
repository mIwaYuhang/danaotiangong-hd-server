FigureRecruitRequest = NetworkRequest:new()

function FigureRecruitRequest.request(arg_1_0, arg_1_1)
	local var_1_0 = string.format(ServerUrl.FigureRecruit, Player.userId, arg_1_1)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function FigureRecruitRequest.parseJsonValue(arg_2_0, arg_2_1)
	arg_2_0.cache = arg_2_1
end

AutoRecruitRequest = NetworkRequest:new()

function AutoRecruitRequest.request(arg_3_0)
	local var_3_0 = string.format(ServerUrl.AutoRecruit, Player.userId)

	arg_3_0:startHttpRequest(var_3_0, false, nil, true)
end

function AutoRecruitRequest.parseJsonValue(arg_4_0, arg_4_1)
	arg_4_0.restable = arg_4_1
end

EquipResolveRequest = NetworkRequest:new()
EquipResolveType = {
	ePerfect = 2,
	eNormal = 1
}

function EquipResolveRequest.request(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.equipUserId = arg_5_2

	local var_5_0 = string.format(ServerUrl.EquipResolve, Player.userId, arg_5_2, arg_5_3)

	arg_5_0:startHttpRequest(var_5_0, false, nil, true)
end

function EquipResolveRequest.parseJsonValue(arg_6_0, arg_6_1)
	EquipHelper:deleteOneEquip(arg_6_0.equipUserId)
end

ExchangEquipRequest = NetworkRequest:new()

function ExchangEquipRequest.request(arg_7_0, arg_7_1)
	local var_7_0 = string.format(ServerUrl.ExchangEquip, Player.userId, arg_7_1)

	arg_7_0:startHttpRequest(var_7_0, false, nil, true)
end

function ExchangEquipRequest.parseJsonValue(arg_8_0, arg_8_1)
	arg_8_0.restable = arg_8_1
end

AutoMixtureRequest = NetworkRequest:new()

function AutoMixtureRequest.request(arg_9_0)
	local var_9_0 = string.format(ServerUrl.AutoMixture, Player.userId)

	arg_9_0:startHttpRequest(var_9_0, false, nil, true)
end

function AutoMixtureRequest.parseJsonValue(arg_10_0, arg_10_1)
	arg_10_0.restable = arg_10_1
end

SellFragmentRequest = NetworkRequest:new()

function SellFragmentRequest.request(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = string.format(ServerUrl.SellFragment, Player.userId, arg_11_1, arg_11_2)

	arg_11_0:startHttpRequest(var_11_0, false, nil, true)
end

function SellFragmentRequest.parseJsonValue(arg_12_0, arg_12_1)
	arg_12_0.restable = arg_12_1
end

EquipRefineRequest = NetworkRequest:new()

function EquipRefineRequest.request(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = string.format(ServerUrl.EquipRefine, Player.userId, arg_13_1, arg_13_2, arg_13_3, arg_13_4)

	arg_13_0:startHttpRequest(var_13_0, false, nil, true)
end

function EquipRefineRequest.parseJsonValue(arg_14_0, arg_14_1)
	arg_14_0.restable = arg_14_1
end

EquipRebirthRequest = NetworkRequest:new()

function EquipRebirthRequest.request(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = string.format(ServerUrl.EquipRebirth, Player.userId, arg_15_1, arg_15_2)

	arg_15_0:startHttpRequest(var_15_0, false, nil, true)
end

function EquipRebirthRequest.parseJsonValue(arg_16_0, arg_16_1)
	arg_16_0.restable = arg_16_1
end

EquipComposeRequest = NetworkRequest:new()

function EquipComposeRequest.request(arg_17_0, arg_17_1)
	local var_17_0 = string.format(ServerUrl.EquipCompose, Player.userId, arg_17_1)

	arg_17_0:startHttpRequest(var_17_0, false, nil, true)
end

function EquipComposeRequest.parseJsonValue(arg_18_0, arg_18_1)
	arg_18_0.restable = arg_18_1
end
