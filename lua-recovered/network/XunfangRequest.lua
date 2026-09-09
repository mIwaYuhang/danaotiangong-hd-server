GetXunfangInfoRequest = NetworkRequest:new()
GetXunfangInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function GetXunfangInfoRequest.request(arg_1_0)
	local var_1_0 = string.format(ServerUrl.XunfangBaseInfo, Player.userId)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function GetXunfangInfoRequest.parseJsonValue(arg_2_0, arg_2_1)
	arg_2_0.restable = arg_2_1
end

function GetXunfangInfoRequest.getAttrList(arg_3_0)
	return arg_3_0.restable.AttrList
end

XunfangRequest = NetworkRequest:new()
XunfangRequest.timeoutOperate = TimeoutOperation.eRetry

function XunfangRequest.request(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = string.format(ServerUrl.Xunfang, Player.userId, arg_4_1, arg_4_2)

	arg_4_0:startHttpRequest(var_4_0, false, nil, true)
end

function XunfangRequest.parseJsonValue(arg_5_0, arg_5_1)
	arg_5_0.restable = arg_5_1
end

function XunfangRequest.getXunfangResult(arg_6_0)
	return arg_6_0.restable
end

function XunfangRequest.getOpenCardList(arg_7_0)
	return arg_7_0.restable.OpenCard
end

GetHandBookRequest = NetworkRequest:new()
GetHandBookRequest.timeoutOperate = TimeoutOperation.eRetry

function GetHandBookRequest.request(arg_8_0)
	local var_8_0 = string.format(ServerUrl.XFGetHandBookDetail, Player.userId)

	arg_8_0:startHttpRequest(var_8_0, false, nil, true)
end

function GetHandBookRequest.parseJsonValue(arg_9_0, arg_9_1)
	arg_9_0.restable = arg_9_1
end

ExchangeLearnExpRequest = NetworkRequest:new()

function ExchangeLearnExpRequest.request(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = string.format(ServerUrl.XFExchangeLearnExp, Player.userId, arg_10_1, arg_10_2, arg_10_3)

	arg_10_0:startHttpRequest(var_10_0, false, nil, true)
end

function ExchangeLearnExpRequest.parseJsonValue(arg_11_0, arg_11_1)
	arg_11_0.restable = arg_11_1
end

GetApprenticeInfoRequest = NetworkRequest:new()
GetApprenticeInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function GetApprenticeInfoRequest.request(arg_12_0, arg_12_1)
	local var_12_0 = string.format(ServerUrl.XFGetApprenticeInfo, Player.userId, arg_12_1)

	arg_12_0:startHttpRequest(var_12_0, false, nil, true)
end

function GetApprenticeInfoRequest.parseJsonValue(arg_13_0, arg_13_1)
	arg_13_0.restable = arg_13_1
end

ToBeApprenticeRequest = NetworkRequest:new()

function ToBeApprenticeRequest.request(arg_14_0, arg_14_1)
	local var_14_0 = string.format(ServerUrl.XFToBeApprentice, Player.userId, arg_14_1)

	arg_14_0:startHttpRequest(var_14_0, false, nil, true)
end

function ToBeApprenticeRequest.parseJsonValue(arg_15_0, arg_15_1)
	arg_15_0.restable = arg_15_1
end
