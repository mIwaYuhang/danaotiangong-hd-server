UsePropRequest = NetworkRequest:new()
UsePropRequest.isNoticeReward = true

function UsePropRequest.requestUseProp(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = string.format(ServerUrl.UseProps, Player.userId, arg_1_1, arg_1_2 == nil and 1 or arg_1_2)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function UsePropRequest.requestChangeName(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2 = stringBase64AndUrlEncode(arg_2_2)

	local var_2_0 = string.format(ServerUrl.UseProps, Player.userId, arg_2_1, 1) .. string.format("&name=%s", arg_2_2)

	arg_2_0:startHttpRequest(var_2_0, false, nil, true)
end

function UsePropRequest.requestExpProp(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = string.format(ServerUrl.UseProps, Player.userId, arg_3_1, 1) .. string.format("&heroId=%s", arg_3_2)

	arg_3_0:startHttpRequest(var_3_0, false, nil, true)
end

function UsePropRequest.requestPotencyProp(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = string.format(ServerUrl.UseProps, Player.userId, arg_4_1, arg_4_2) .. string.format("&heroId=%s", arg_4_3)

	arg_4_0:startHttpRequest(var_4_0, false, nil, true)
end

function UsePropRequest.parseJsonValue(arg_5_0, arg_5_1)
	arg_5_0.cache = arg_5_1
end

function UsePropRequest.getResponseContent(arg_6_0)
	return arg_6_0.cache
end

SellPropRequest = NetworkRequest:new()

function SellPropRequest.requestSellProp(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2 = arg_7_2 or 1

	local var_7_0 = string.format(ServerUrl.SellProps, Player.userId, arg_7_1, arg_7_2)

	arg_7_0:startHttpRequest(var_7_0, false, nil, true)
end

function SellPropRequest.parseJsonValue(arg_8_0, arg_8_1)
	arg_8_0.cache = arg_8_1
end

function SellPropRequest.getResponseContent(arg_9_0)
	return arg_9_0.cache
end

UseExpPillRequest = NetworkRequest:new()

function UseExpPillRequest.request(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = string.format(ServerUrl.UseExpPill, Player.userId, tostring(arg_10_1), arg_10_2)

	arg_10_0:startHttpRequest(var_10_0, false, nil, true)
end

function UseExpPillRequest.parseJsonValue(arg_11_0, arg_11_1)
	arg_11_0.restable = arg_11_1
end

GetTypePropsRequest = NetworkRequest:new()
GetTypePropsRequest.timeoutOperate = TimeoutOperation.eRetry

function GetTypePropsRequest.request(arg_12_0, arg_12_1)
	local var_12_0 = string.format(ServerUrl.GetTypeProp, Player.userId, tostring(arg_12_1))

	arg_12_0:startHttpRequest(var_12_0, false, nil, true)
end

function GetTypePropsRequest.parseJsonValue(arg_13_0, arg_13_1)
	Player:setBagItemsCount(arg_13_1)
end

HeroUpdateLevelRequest = NetworkRequest:new()

function HeroUpdateLevelRequest.request(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = string.format(ServerUrl.HeroUpdateLevel, Player.userId, tostring(arg_14_1), tostring(arg_14_2))

	arg_14_0:startHttpRequest(var_14_0, false, nil, true)
end

function HeroUpdateLevelRequest.parseJsonValue(arg_15_0, arg_15_1)
	arg_15_0.restable = arg_15_1
end
