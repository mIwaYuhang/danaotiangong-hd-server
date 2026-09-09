ConsumeBangRequest = NetworkRequest:new()
ConsumeBangRequest.timeoutOperate = TimeoutOperation.eRetry

function ConsumeBangRequest.request(arg_1_0)
	local var_1_0 = string.format(ServerUrl.FuHaoBangRankInfo, Player.userId)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function ConsumeBangRequest.parseJsonValue(arg_2_0, arg_2_1)
	arg_2_0.restable = arg_2_1
end

function ConsumeBangRequest.getRankInfo(arg_3_0)
	return arg_3_0.restable
end
