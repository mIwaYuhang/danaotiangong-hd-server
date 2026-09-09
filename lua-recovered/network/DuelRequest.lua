require("base.request")

DuelInfoRequest = NetworkRequest:new()
DuelInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function DuelInfoRequest.request(arg_1_0)
	local var_1_0 = string.format(ServerUrl.DuelInfo, Player.userId)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function DuelInfoRequest.parseJsonValue(arg_2_0, arg_2_1)
	arg_2_0.restable = arg_2_1
end

DuelChouQianRequest = NetworkRequest:new()
DuelChouQianRequest.timeoutOperate = TimeoutOperation.eRetry

function DuelChouQianRequest.request(arg_3_0)
	local var_3_0 = string.format(ServerUrl.DuelChouQian, Player.userId)

	arg_3_0:startHttpRequest(var_3_0, false, nil, true)
end

function DuelChouQianRequest.parseJsonValue(arg_4_0, arg_4_1)
	arg_4_0.restable = arg_4_1
end

DuelFightRequest = NetworkRequest:new()

function DuelFightRequest.request(arg_5_0, arg_5_1)
	local var_5_0 = string.format(ServerUrl.DuelFight, Player.userId, arg_5_1)

	arg_5_0:startHttpRequest(var_5_0, false, nil, true)
end

function DuelFightRequest.parseJsonValue(arg_6_0, arg_6_1)
	arg_6_0.restable = arg_6_1
end

DuelRefreshRivalRequest = NetworkRequest:new()
DuelRefreshRivalRequest.timeoutOperate = TimeoutOperation.eRetry

function DuelRefreshRivalRequest.request(arg_7_0)
	local var_7_0 = string.format(ServerUrl.DuelRefreshRival, Player.userId)

	arg_7_0:startHttpRequest(var_7_0, false, nil, true)
end

function DuelRefreshRivalRequest.parseJsonValue(arg_8_0, arg_8_1)
	arg_8_0.restable = arg_8_1
end

DuelGetEnemyListRequest = NetworkRequest:new()
DuelGetEnemyListRequest.timeoutOperate = TimeoutOperation.eRetry

function DuelGetEnemyListRequest.request(arg_9_0)
	local var_9_0 = string.format(ServerUrl.DuelGetEnemys, Player.userId)

	arg_9_0:startHttpRequest(var_9_0, false, nil, true)
end

function DuelGetEnemyListRequest.parseJsonValue(arg_10_0, arg_10_1)
	arg_10_0.restable = arg_10_1
end

DuelRevengeRequest = NetworkRequest:new()
DuelRevengeRequest.timeoutOperate = TimeoutOperation.eRetry

function DuelRevengeRequest.request(arg_11_0, arg_11_1)
	local var_11_0 = string.format(ServerUrl.DuelRevenge, Player.userId, arg_11_1)

	arg_11_0:startHttpRequest(var_11_0, false, nil, true)
end

function DuelRevengeRequest.parseJsonValue(arg_12_0, arg_12_1)
	arg_12_0.restable = arg_12_1
end

DuelGetRewardListRequest = NetworkRequest:new()
DuelGetRewardListRequest.timeoutOperate = TimeoutOperation.eRetry

function DuelGetRewardListRequest.request(arg_13_0)
	local var_13_0 = string.format(ServerUrl.DuelGetRewardList, Player.userId)

	arg_13_0:startHttpRequest(var_13_0, false, nil, true)
end

function DuelGetRewardListRequest.parseJsonValue(arg_14_0, arg_14_1)
	arg_14_0.restable = arg_14_1
end

DuelGetRewardRequest = NetworkRequest:new()
DuelGetRewardRequest.timeoutOperate = TimeoutOperation.eRetry

function DuelGetRewardRequest.request(arg_15_0, arg_15_1)
	local var_15_0 = string.format(ServerUrl.DuelGetReward, Player.userId, arg_15_1)

	arg_15_0:startHttpRequest(var_15_0, false, nil, true)
end

function DuelGetRewardRequest.parseJsonValue(arg_16_0, arg_16_1)
	arg_16_0.restable = arg_16_1
end

DuelRankListRequest = NetworkRequest:new()
DuelRankListRequest.timeoutOperate = TimeoutOperation.eRetry

function DuelRankListRequest.request(arg_17_0, arg_17_1)
	local var_17_0 = string.format(ServerUrl.DuelGetRankList, Player.userId, arg_17_1)

	arg_17_0:startHttpRequest(var_17_0, false, nil, true)
end

function DuelRankListRequest.parseJsonValue(arg_18_0, arg_18_1)
	arg_18_0.restable = arg_18_1
end

DuelFightLogRequest = NetworkRequest:new()
DuelFightLogRequest.timeoutOperate = TimeoutOperation.eRetry

function DuelFightLogRequest.request(arg_19_0, arg_19_1)
	local var_19_0 = string.format(ServerUrl.DuelFightLog, Player.userId)

	arg_19_0:startHttpRequest(var_19_0, false, nil, true)
end

function DuelFightLogRequest.parseJsonValue(arg_20_0, arg_20_1)
	arg_20_0.restable = arg_20_1
end
