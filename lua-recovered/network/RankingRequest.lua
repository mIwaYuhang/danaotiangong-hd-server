RankingRequest = NetworkRequest:new()
RankingRequest.timeoutOperate = TimeoutOperation.eRetry

function RankingRequest.request(arg_1_0, arg_1_1)
	local var_1_0 = string.format(ServerUrl.XianBangRankInfo, Player.userId, arg_1_1)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function RankingRequest.parseJsonValue(arg_2_0, arg_2_1)
	arg_2_0.restable = arg_2_1
end

function RankingRequest.getRankInfo(arg_3_0)
	return arg_3_0.restable
end

ConsumeBangRequest = NetworkRequest:new()
ConsumeBangRequest.timeoutOperate = TimeoutOperation.eRetry

function ConsumeBangRequest.request(arg_4_0)
	local var_4_0 = string.format(ServerUrl.FuHaoBangRankInfo, Player.userId)

	arg_4_0:startHttpRequest(var_4_0, false, nil, true)
end

function ConsumeBangRequest.parseJsonValue(arg_5_0, arg_5_1)
	arg_5_0.restable = arg_5_1
end

function ConsumeBangRequest.getRankInfo(arg_6_0)
	return arg_6_0.restable
end

JiFenBangRequest = NetworkRequest:new()
JiFenBangRequest.timeoutOperate = TimeoutOperation.eRetry

function JiFenBangRequest.request(arg_7_0, arg_7_1)
	local var_7_0 = string.format(ServerUrl.JiFenBangRankInfo, Player.userId, arg_7_1)

	arg_7_0:startHttpRequest(var_7_0, false, nil, true)
end

function JiFenBangRequest.parseJsonValue(arg_8_0, arg_8_1)
	arg_8_0.restable = arg_8_1
end

function JiFenBangRequest.getRankInfo(arg_9_0)
	return arg_9_0.restable
end
