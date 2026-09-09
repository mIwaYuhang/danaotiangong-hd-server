require("base.request")

ZhaoCaiFuRequest = NetworkRequest:new()
ZhaoCaiFuRequest.isNoticeReward = true
ZhaoCaiFuRequest.eGet = 1
ZhaoCaiFuRequest.eUse = 2

function ZhaoCaiFuRequest.requestGetLuckySymbol(arg_1_0)
	arg_1_0.timeoutOperate = TimeoutOperation.eRetry

	local var_1_0 = string.format(ServerUrl.LuckySymbolGet, Player.userId)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)

	arg_1_0.type = ZhaoCaiFuRequest.eGet
end

function ZhaoCaiFuRequest.requestUseLuckySymbol(arg_2_0)
	arg_2_0.timeoutOperate = TimeoutOperation.eExcep

	local var_2_0 = string.format(ServerUrl.LuckySymbolUse, Player.userId)

	arg_2_0:startHttpRequest(var_2_0, false, nil, true)

	arg_2_0.type = ZhaoCaiFuRequest.eUse
end

function ZhaoCaiFuRequest.getResponseContent(arg_3_0)
	return arg_3_0.type, arg_3_0.cache
end

function ZhaoCaiFuRequest.parseJsonValue(arg_4_0, arg_4_1)
	arg_4_0.cache = arg_4_1
end
