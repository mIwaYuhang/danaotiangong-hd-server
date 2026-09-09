TransportBlessInfoRequest = NetworkRequest:new()
TransportBlessInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function TransportBlessInfoRequest.request(arg_1_0)
	local var_1_0 = string.format(ServerUrl.TransportBlessInfo, Player.userId)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function TransportBlessInfoRequest.parseJsonValue(arg_2_0, arg_2_1)
	arg_2_0.restable = arg_2_1
end

function TransportBlessInfoRequest.getTransportBlessInfo(arg_3_0)
	return arg_3_0.restable
end

TransportBlessRequest = NetworkRequest:new()

function TransportBlessRequest.request(arg_4_0, arg_4_1)
	local var_4_0 = string.format(ServerUrl.TransportBless, Player.userId, arg_4_1)

	arg_4_0:startHttpRequest(var_4_0, false, nil, true)
end

function TransportBlessRequest.parseJsonValue(arg_5_0, arg_5_1)
	arg_5_0.restable = arg_5_1
end

function TransportBlessRequest.getBlessResult(arg_6_0)
	return arg_6_0.restable
end

CallHorseRequest = NetworkRequest:new()

function CallHorseRequest.request(arg_7_0, arg_7_1)
	local var_7_0 = string.format(ServerUrl.TransportCallHorse, Player.userId, arg_7_1)

	arg_7_0:startHttpRequest(var_7_0, false, nil, true)
end

function CallHorseRequest.parseJsonValue(arg_8_0, arg_8_1)
	arg_8_0.restable = arg_8_1
end

RefreshHorseRequest = NetworkRequest:new()

function RefreshHorseRequest.request(arg_9_0, arg_9_1)
	local var_9_0 = string.format(ServerUrl.TransportRefreshHorse, Player.userId, arg_9_1)

	arg_9_0:startHttpRequest(var_9_0, false, nil, true)
end

function RefreshHorseRequest.parseJsonValue(arg_10_0, arg_10_1)
	arg_10_0.restable = arg_10_1
end

TransportLogRequest = NetworkRequest:new()
TransportLogRequest.timeoutOperate = TimeoutOperation.eRetry

function TransportLogRequest.request(arg_11_0, arg_11_1)
	local var_11_0 = string.format(ServerUrl.GetTransportLog, Player.userId, arg_11_1)

	arg_11_0:startHttpRequest(var_11_0, false, nil, true)
end

function TransportLogRequest.parseJsonValue(arg_12_0, arg_12_1)
	arg_12_0.restable = arg_12_1
end

TransportRobRequest = NetworkRequest:new()

function TransportRobRequest.request(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = ""

	for iter_13_0 = 1, #arg_13_2 do
		if iter_13_0 < #arg_13_2 then
			var_13_0 = var_13_0 .. arg_13_2[iter_13_0] .. ","
		else
			var_13_0 = var_13_0 .. arg_13_2[iter_13_0]
		end
	end

	local var_13_1 = string.format(ServerUrl.TransportRob, Player.userId, arg_13_1, var_13_0)

	arg_13_0:startHttpRequest(var_13_1, false, nil, true)
end

function TransportRobRequest.parseJsonValue(arg_14_0, arg_14_1)
	arg_14_0.restable = arg_14_1
end

TransportFriendsRequest = NetworkRequest:new()
TransportFriendsRequest.timeoutOperate = TimeoutOperation.eRetry

function TransportFriendsRequest.request(arg_15_0)
	local var_15_0 = string.format(ServerUrl.TransportFriends, Player.userId)

	arg_15_0:startHttpRequest(var_15_0, false, nil, true)
end

function TransportFriendsRequest.parseJsonValue(arg_16_0, arg_16_1)
	arg_16_0.restable = arg_16_1
end

function TransportFriendsRequest.getTransportFriends(arg_17_0)
	return arg_17_0.restable
end

TransportRobFriendsRequest = NetworkRequest:new()

function TransportRobFriendsRequest.request(arg_18_0)
	local var_18_0 = string.format(ServerUrl.TransportRobFriends, Player.userId)

	arg_18_0:startHttpRequest(var_18_0, false, nil, true)
end

function TransportRobFriendsRequest.parseJsonValue(arg_19_0, arg_19_1)
	arg_19_0.restable = arg_19_1
end

function TransportRobFriendsRequest.getTransportRobFriends(arg_20_0)
	return arg_20_0.restable
end

TransportInfoRequest = NetworkRequest:new()
TransportInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function TransportInfoRequest.request(arg_21_0)
	local var_21_0 = string.format(ServerUrl.GetTransportInfo, Player.userId)

	arg_21_0:startHttpRequest(var_21_0, false, nil, true)
end

function TransportInfoRequest.parseJsonValue(arg_22_0, arg_22_1)
	arg_22_0.restable = arg_22_1
end

function TransportInfoRequest.getTransportInfo(arg_23_0)
	return arg_23_0.restable
end

StartTransportRequest = NetworkRequest:new()

function StartTransportRequest.request(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = ""

	for iter_24_0 = 1, #arg_24_2 do
		if iter_24_0 < #arg_24_2 then
			var_24_0 = var_24_0 .. arg_24_2[iter_24_0] .. ","
		else
			var_24_0 = var_24_0 .. arg_24_2[iter_24_0]
		end
	end

	local var_24_1 = string.format(ServerUrl.StartTransport, Player.userId, arg_24_1, var_24_0)

	arg_24_0:startHttpRequest(var_24_1, false, nil, true)
end

function StartTransportRequest.parseJsonValue(arg_25_0, arg_25_1)
	arg_25_0.restable = arg_25_1
end

TransportSelectRequest = NetworkRequest:new()
TransportSelectRequest.timeoutOperate = TimeoutOperation.eRetry

function TransportSelectRequest.request(arg_26_0)
	local var_26_0 = string.format(ServerUrl.GetTransportSelect, Player.userId)

	arg_26_0:startHttpRequest(var_26_0, false, nil, true)
end

function TransportSelectRequest.parseJsonValue(arg_27_0, arg_27_1)
	arg_27_0.restable = arg_27_1
end

EndTransportRequest = NetworkRequest:new()

function EndTransportRequest.request(arg_28_0)
	local var_28_0 = string.format(ServerUrl.EndTransport, Player.userId)

	arg_28_0:startHttpRequest(var_28_0, false, nil, true)
end

function EndTransportRequest.parseJsonValue(arg_29_0, arg_29_1)
	arg_29_0.restable = arg_29_1
end
