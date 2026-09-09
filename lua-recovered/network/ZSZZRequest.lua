require("base.request")

ZSZZHomeInfoRequest = NetworkRequest:new()
ZSZZHomeInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function ZSZZHomeInfoRequest.request(arg_1_0)
	local var_1_0 = string.format(ServerUrl.ZSZZHomeInfo, Player.userId)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function ZSZZHomeInfoRequest.parseJsonValue(arg_2_0, arg_2_1)
	arg_2_0.restable = arg_2_1
end

ZSZZEncourageRequest = NetworkRequest:new()

function ZSZZEncourageRequest.request(arg_3_0, arg_3_1)
	local var_3_0 = string.format(ServerUrl.ZSZZEncourage, Player.userId, arg_3_1)

	arg_3_0:startHttpRequest(var_3_0, false, nil, true)
end

function ZSZZEncourageRequest.parseJsonValue(arg_4_0, arg_4_1)
	arg_4_0.restable = arg_4_1
end

ZSZZGetEncourageInfoRequest = NetworkRequest:new()
ZSZZGetEncourageInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function ZSZZGetEncourageInfoRequest.request(arg_5_0, arg_5_1)
	local var_5_0 = string.format(ServerUrl.ZSZZGetEncourageInfo, Player.userId, arg_5_1)

	arg_5_0:startHttpRequest(var_5_0, false, nil, true)
end

function ZSZZGetEncourageInfoRequest.parseJsonValue(arg_6_0, arg_6_1)
	arg_6_0.restable = arg_6_1
end

ZSZZGetTop10InfoRequest = NetworkRequest:new()
ZSZZGetTop10InfoRequest.timeoutOperate = TimeoutOperation.eRetry

function ZSZZGetTop10InfoRequest.request(arg_7_0, arg_7_1)
	local var_7_0 = string.format(ServerUrl.ZSZZGetTop10Info, Player.userId, arg_7_1)

	arg_7_0:startHttpRequest(var_7_0, false, nil, true)
end

function ZSZZGetTop10InfoRequest.parseJsonValue(arg_8_0, arg_8_1)
	arg_8_0.restable = arg_8_1
end

ZSZZRewardListRequest = NetworkRequest:new()
ZSZZRewardListRequest.timeoutOperate = TimeoutOperation.eRetry

function ZSZZRewardListRequest.request(arg_9_0)
	local var_9_0 = string.format(ServerUrl.ZSZZGetRewardLst, Player.userId)

	arg_9_0:startHttpRequest(var_9_0, false, nil, true)
end

function ZSZZRewardListRequest.parseJsonValue(arg_10_0, arg_10_1)
	arg_10_0.restable = arg_10_1
end

ZSZZGetRewardRequest = NetworkRequest:new()
ZSZZGetRewardRequest.timeoutOperate = TimeoutOperation.eRetry

function ZSZZGetRewardRequest.request(arg_11_0, arg_11_1)
	local var_11_0 = string.format(ServerUrl.ZSZZGetReward, Player.userId, arg_11_1)

	arg_11_0:startHttpRequest(var_11_0, false, nil, true)
end

function ZSZZGetRewardRequest.parseJsonValue(arg_12_0, arg_12_1)
	arg_12_0.restable = arg_12_1
end

ZSZZBattleReportRequest = NetworkRequest:new()
ZSZZBattleReportRequest.timeoutOperate = TimeoutOperation.eRetry

function ZSZZBattleReportRequest.request(arg_13_0, arg_13_1)
	local var_13_0 = string.format(ServerUrl.ZSZZGetBattleReport, Player.userId, arg_13_1)

	arg_13_0:startHttpRequest(var_13_0, false, nil, true)
end

function ZSZZBattleReportRequest.parseJsonValue(arg_14_0, arg_14_1)
	arg_14_0.restable = arg_14_1
end

ZSZZMyBattleReportRequest = NetworkRequest:new()
ZSZZMyBattleReportRequest.timeoutOperate = TimeoutOperation.eRetry

function ZSZZMyBattleReportRequest.request(arg_15_0)
	local var_15_0 = string.format(ServerUrl.ZSZZGetMyBattleReport, Player.userId)

	arg_15_0:startHttpRequest(var_15_0, false, nil, true)
end

function ZSZZMyBattleReportRequest.parseJsonValue(arg_16_0, arg_16_1)
	arg_16_0.restable = arg_16_1
end

ZSZZGetTop32InfoRequest = NetworkRequest:new()
ZSZZGetTop32InfoRequest.timeoutOperate = TimeoutOperation.eRetry

function ZSZZGetTop32InfoRequest.request(arg_17_0, arg_17_1)
	local var_17_0 = string.format(ServerUrl.ZSZZGetTop32Info, Player.userId, arg_17_1)

	arg_17_0:startHttpRequest(var_17_0, false, nil, true)
end

function ZSZZGetTop32InfoRequest.parseJsonValue(arg_18_0, arg_18_1)
	arg_18_0.restable = arg_18_1
end

ZSZZGetGambleHomeInfoRequest = NetworkRequest:new()
ZSZZGetGambleHomeInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function ZSZZGetGambleHomeInfoRequest.request(arg_19_0, arg_19_1)
	local var_19_0 = string.format(ServerUrl.ZSZZGetGambleHomeInfo, Player.userId, arg_19_1)

	arg_19_0:startHttpRequest(var_19_0, false, nil, true)
end

function ZSZZGetGambleHomeInfoRequest.parseJsonValue(arg_20_0, arg_20_1)
	arg_20_0.restable = arg_20_1
end

ZSZZMakeBetRequest = NetworkRequest:new()

function ZSZZMakeBetRequest.request(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	local var_21_0 = string.format(ServerUrl.ZSZZMakeBet, Player.userId, arg_21_1, arg_21_2, arg_21_3, arg_21_4)

	arg_21_0:startHttpRequest(var_21_0, false, nil, true)
end

function ZSZZMakeBetRequest.parseJsonValue(arg_22_0, arg_22_1)
	arg_22_0.restable = arg_22_1
end

ZSZZGetFightHomeInfoRequest = NetworkRequest:new()
ZSZZGetFightHomeInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function ZSZZGetFightHomeInfoRequest.request(arg_23_0)
	local var_23_0 = string.format(ServerUrl.ZSZZGetFightHomeInfo, Player.userId)

	arg_23_0:startHttpRequest(var_23_0, false, nil, true)
end

function ZSZZGetFightHomeInfoRequest.parseJsonValue(arg_24_0, arg_24_1)
	arg_24_0.restable = arg_24_1
end

ZSZZGetMoreRankRequest = NetworkRequest:new()
ZSZZGetMoreRankRequest.timeoutOperate = TimeoutOperation.eRetry

function ZSZZGetMoreRankRequest.request(arg_25_0, arg_25_1)
	local var_25_0 = string.format(ServerUrl.ZSZZGetMoreRankInfo, Player.userId, arg_25_1)

	arg_25_0:startHttpRequest(var_25_0, false, nil, true)
end

function ZSZZGetMoreRankRequest.parseJsonValue(arg_26_0, arg_26_1)
	arg_26_0.restable = arg_26_1
end

ZSZZBattleRecordRequet = NetworkRequest:new()
ZSZZBattleRecordRequet.timeoutOperate = TimeoutOperation.eRetry

function ZSZZBattleRecordRequet.request(arg_27_0, arg_27_1)
	local var_27_0 = string.format(ServerUrl.ZSZZBattleRecord, Player.userId, arg_27_1)

	arg_27_0:startHttpRequest(var_27_0, false, nil, true)
end

function ZSZZBattleRecordRequet.parseJsonValue(arg_28_0, arg_28_1)
	arg_28_0.restable = arg_28_1
end
