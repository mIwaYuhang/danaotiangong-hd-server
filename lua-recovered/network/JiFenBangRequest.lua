JiFenBangRequest = NetworkRequest:new()
JiFenBangRequest.timeoutOperate = TimeoutOperation.eRetry

function JiFenBangRequest.request(arg_1_0, arg_1_1)
	local var_1_0 = string.format("/ActivityCommonlog/rank?user=%s&type=%s", Player.userId, arg_1_1)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function JiFenBangRequest.parseJsonValue(arg_2_0, arg_2_1)
	arg_2_0.restable = arg_2_1
end

function JiFenBangRequest.getRankInfo(arg_3_0)
	return arg_3_0.restable
end
