require("base.request")

SignMonthRequest = NetworkRequest:new()
SignMonthRequest.timeoutOperate = TimeoutOperation.eRetry
SignMonthRequest.eInfo = 1
SignMonthRequest.eSign = 2
SignMonthRequest.eAward = 3
SignMonthRequest.isNoticeReward = true

function SignMonthRequest.requestSignInfo(arg_1_0)
	local var_1_0 = string.format(ServerUrl.SignInfo, Player.userId)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)

	arg_1_0.type = SignMonthRequest.eInfo
end

function SignMonthRequest.requestSignToday(arg_2_0)
	local var_2_0 = string.format(ServerUrl.SignToday, Player.userId)

	arg_2_0:startHttpRequest(var_2_0, false, nil, true)

	arg_2_0.type = SignMonthRequest.eSign
end

function SignMonthRequest.requestSignReward(arg_3_0, arg_3_1)
	local var_3_0 = string.format(ServerUrl.ReceiveReward, Player.userId, arg_3_1)

	arg_3_0:startHttpRequest(var_3_0, false, nil, true)

	arg_3_0.type = SignMonthRequest.eAward
end

function SignMonthRequest.getResponseContent(arg_4_0)
	return arg_4_0.type, arg_4_0.cache
end

function SignMonthRequest.parseJsonValue(arg_5_0, arg_5_1)
	arg_5_0.cache = arg_5_1
end
