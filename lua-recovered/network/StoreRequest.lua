PropListRequest = NetworkRequest:new()
PropListRequest.timeoutOperate = TimeoutOperation.eRetry

function PropListRequest.request(arg_1_0)
	local var_1_0 = string.format(ServerUrl.GetPropList, Player.userId)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function PropListRequest.getResponseContent(arg_2_0)
	return arg_2_0.restable
end

function PropListRequest.parseJsonValue(arg_3_0, arg_3_1)
	arg_3_0.restable = arg_3_1
end

SuitListRequest = NetworkRequest:new()
SuitListRequest.timeoutOperate = TimeoutOperation.eRetry

function SuitListRequest.request(arg_4_0)
	local var_4_0 = string.format(ServerUrl.GetSuitList, Player.userId)

	arg_4_0:startHttpRequest(var_4_0, false, nil, true)
end

function SuitListRequest.getResponseContent(arg_5_0)
	return arg_5_0.restable
end

function SuitListRequest.parseJsonValue(arg_6_0, arg_6_1)
	arg_6_0.restable = arg_6_1
end

BuyPropRequest = NetworkRequest:new()

function BuyPropRequest.request(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = string.format(ServerUrl.BuyGoods, Player.userId, arg_7_1, arg_7_2)

	arg_7_0:startHttpRequest(var_7_0, false, nil, true)
end

function BuyPropRequest.getResponseContent(arg_8_0)
	return arg_8_0.restable
end

function BuyPropRequest.parseJsonValue(arg_9_0, arg_9_1)
	arg_9_0.restable = arg_9_1
end

RechargeListRequest = NetworkRequest:new()
RechargeListRequest.timeoutOperate = TimeoutOperation.eRetry

function RechargeListRequest.request(arg_10_0)
	local var_10_0 = string.format(ServerUrl.RechargeList, Player.userId)

	arg_10_0:startHttpRequest(var_10_0, false, nil, true)
end

function RechargeListRequest.getResponseContent(arg_11_0)
	return arg_11_0.restable
end

function RechargeListRequest.parseJsonValue(arg_12_0, arg_12_1)
	arg_12_0.restable = arg_12_1
end

StoreHeroInfoRequest = NetworkRequest:new()
StoreHeroInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function StoreHeroInfoRequest.request(arg_13_0)
	local var_13_0 = string.format(ServerUrl.StoreHeroInfo, Player.userId)

	arg_13_0:startHttpRequest(var_13_0, false, nil, true)
end

function StoreHeroInfoRequest.parseJsonValue(arg_14_0, arg_14_1)
	arg_14_0.restable = arg_14_1
end

StoreHeroRecruitRequest = NetworkRequest:new()

function StoreHeroRecruitRequest.request(arg_15_0, arg_15_1)
	local var_15_0 = string.format(ServerUrl.StoreHeroRecruit, Player.userId, arg_15_1)

	arg_15_0:startHttpRequest(var_15_0, false, nil, true)
end

function StoreHeroRecruitRequest.parseJsonValue(arg_16_0, arg_16_1)
	arg_16_0.restable = arg_16_1
end

StoreRecruitTenHeroRequest = NetworkRequest:new()

function StoreRecruitTenHeroRequest.request(arg_17_0, arg_17_1)
	local var_17_0 = string.format(ServerUrl.StoreHeroRecruit, Player.userId, arg_17_1) .. "&count=10"

	arg_17_0:startHttpRequest(var_17_0, false, nil, true)
end

function StoreRecruitTenHeroRequest.parseJsonValue(arg_18_0, arg_18_1)
	arg_18_0.restable = arg_18_1
end

function StoreRecruitTenHeroRequest.getTenHeroesInfo(arg_19_0)
	return arg_19_0.restable
end

MysticStoreRequest = NetworkRequest:new()
MysticStoreRequest.eGet = 1
MysticStoreRequest.eRefresh = 2
MysticStoreRequest.eBuy = 3

function MysticStoreRequest.get(arg_20_0)
	local var_20_0 = string.format(ServerUrl.MysticStoreGet, Player.userId)

	arg_20_0.timeoutOperate = TimeoutOperation.eRetry
	arg_20_0.state = MysticStoreRequest.eGet

	arg_20_0:startHttpRequest(var_20_0, false, nil, true)
end

function MysticStoreRequest.refresh(arg_21_0)
	local var_21_0 = string.format(ServerUrl.MysticStoreRefresh, Player.userId)

	arg_21_0.timeoutOperate = TimeoutOperation.eExcep
	arg_21_0.state = MysticStoreRequest.eRefresh

	arg_21_0:startHttpRequest(var_21_0, false, nil, true)
end

function MysticStoreRequest.buy(arg_22_0, arg_22_1)
	local var_22_0 = string.format(ServerUrl.MysticStoreBuy, Player.userId, arg_22_1)

	arg_22_0.timeoutOperate = TimeoutOperation.eExcep
	arg_22_0.state = MysticStoreRequest.eBuy

	arg_22_0:startHttpRequest(var_22_0, false, nil, true)
end

function MysticStoreRequest.getResponseContent(arg_23_0)
	return arg_23_0.state, arg_23_0.restable
end

function MysticStoreRequest.parseJsonValue(arg_24_0, arg_24_1)
	arg_24_0.restable = arg_24_1
end

GetFirstChargeRewardListRequest = NetworkRequest:new()
GetFirstChargeRewardListRequest.timeoutOperate = TimeoutOperation.eRetry

function GetFirstChargeRewardListRequest.request(arg_25_0)
	local var_25_0 = string.format(ServerUrl.GetFirstChargeRewardList, Player.userId)

	arg_25_0:startHttpRequest(var_25_0, false, nil, true)
end

function GetFirstChargeRewardListRequest.parseJsonValue(arg_26_0, arg_26_1)
	arg_26_0.rewardList = arg_26_1
end

function GetFirstChargeRewardListRequest.getRewardList(arg_27_0)
	return arg_27_0.rewardList
end

GetFirstChargeRewardRequest = NetworkRequest:new()

function GetFirstChargeRewardRequest.request(arg_28_0)
	local var_28_0 = string.format(ServerUrl.GetFirstChargeReward, Player.userId)

	arg_28_0:startHttpRequest(var_28_0, false, nil, true)
end

function GetFirstChargeRewardRequest.parseJsonValue(arg_29_0, arg_29_1)
	arg_29_0.result = arg_29_1
end
