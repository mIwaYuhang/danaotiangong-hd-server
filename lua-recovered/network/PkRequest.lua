GetDuelInfoRequest = NetworkRequest:new()
GetDuelInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function GetDuelInfoRequest.request(arg_1_0)
	local var_1_0 = string.format(ServerUrl.GetDuelInfo, Player.userId)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function GetDuelInfoRequest.getResponseContent(arg_2_0)
	return arg_2_0.restable
end

function GetDuelInfoRequest.parseJsonValue(arg_3_0, arg_3_1)
	arg_3_0.restable = arg_3_1
end

ExchangeListRequest = NetworkRequest:new()
ExchangeListRequest.timeoutOperate = TimeoutOperation.eRetry

function ExchangeListRequest.request(arg_4_0)
	local var_4_0 = string.format(ServerUrl.GetExchangeList, Player.userId)

	arg_4_0:startHttpRequest(var_4_0, false, nil, true)
end

function ExchangeListRequest.parseJsonValue(arg_5_0, arg_5_1)
	arg_5_0.restable = arg_5_1
end

ExchangeItemRequest = NetworkRequest:new()

function ExchangeItemRequest.request(arg_6_0, arg_6_1)
	local var_6_0 = string.format(ServerUrl.RedeemGift, Player.userId, arg_6_1)

	arg_6_0:startHttpRequest(var_6_0, false, nil, true)
end

function ExchangeItemRequest.parseJsonValue(arg_7_0, arg_7_1)
	arg_7_0.restable = arg_7_1
end

DuelTopTenRequest = NetworkRequest:new()
DuelTopTenRequest.timeoutOperate = TimeoutOperation.eRetry

function DuelTopTenRequest.request(arg_8_0)
	local var_8_0 = string.format(ServerUrl.DuelTopTen, Player.userId)

	arg_8_0:startHttpRequest(var_8_0, false, nil, true)
end

function DuelTopTenRequest.getResponseContent(arg_9_0)
	return arg_9_0.restable
end

function DuelTopTenRequest.parseJsonValue(arg_10_0, arg_10_1)
	arg_10_0.restable = arg_10_1
end

ScoreListRequest = NetworkRequest:new()
ScoreListRequest.timeoutOperate = TimeoutOperation.eRetry

function ScoreListRequest.request(arg_11_0)
	local var_11_0 = string.format(ServerUrl.ScoreList, Player.userId)

	arg_11_0:startHttpRequest(var_11_0, false, nil, true)
end

function ScoreListRequest.parseJsonValue(arg_12_0, arg_12_1)
	arg_12_0.restable = arg_12_1
end

ScoreGetRequest = NetworkRequest:new()

function ScoreGetRequest.request(arg_13_0, arg_13_1)
	local var_13_0 = string.format(ServerUrl.ScoreGet, Player.userId, arg_13_1)

	arg_13_0:startHttpRequest(var_13_0, false, nil, true)
end

function ScoreGetRequest.parseJsonValue(arg_14_0, arg_14_1)
	arg_14_0.restable = arg_14_1
end

LimitRankListRequest = NetworkRequest:new()
LimitRankListRequest.timeoutOperate = TimeoutOperation.eRetry

function LimitRankListRequest.request(arg_15_0)
	local var_15_0 = string.format(ServerUrl.LimitRankList, Player.userId)

	arg_15_0:startHttpRequest(var_15_0, false, nil, true)
end

function LimitRankListRequest.parseJsonValue(arg_16_0, arg_16_1)
	arg_16_0.restable = arg_16_1
end
