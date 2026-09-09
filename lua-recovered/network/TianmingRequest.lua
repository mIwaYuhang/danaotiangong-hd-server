TianmingRequest = NetworkRequest:new()
TianmingRequest.timeoutOperate = TimeoutOperation.eRetry
TianmingRequest.eInfo = 1
TianmingRequest.eHunt = 2
TianmingRequest.eHuntAll = 3
TianmingRequest.eResolve = 4
TianmingRequest.eCollect = 5
TianmingRequest.eExchinfo = 6
TianmingRequest.eExchange = 7
TianmingRequest.eSelect = 8
TianmingRequest.eReBatch = 9

function TianmingRequest.requestInfo(arg_1_0)
	local var_1_0 = string.format(ServerUrl.DestinyInfo, Player.userId)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)

	arg_1_0.state = TianmingRequest.eInfo
end

function TianmingRequest.requestHunt(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0

	if arg_2_1 and arg_2_2 then
		var_2_0 = string.format(ServerUrl.DestinyHunt, Player.userId, arg_2_1, arg_2_2)
		arg_2_0.state = TianmingRequest.eHunt
	else
		var_2_0 = string.format(ServerUrl.DestinyHuntAll, Player.userId)
		arg_2_0.state = TianmingRequest.eHuntAll
	end

	arg_2_0:startHttpRequest(var_2_0, false, nil, true)
end

function TianmingRequest.requestResolve(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = string.format(ServerUrl.DestinyResolve, Player.userId, arg_3_1, arg_3_2)

	arg_3_0:startHttpRequest(var_3_0, false, nil, true)

	arg_3_0.state = TianmingRequest.eResolve
end

function TianmingRequest.requestCollect(arg_4_0, arg_4_1)
	local var_4_0 = string.format(ServerUrl.DestinyCollect, Player.userId, arg_4_1)

	arg_4_0:startHttpRequest(var_4_0, false, nil, true)

	arg_4_0.state = TianmingRequest.eCollect
end

function TianmingRequest.requestExchinfo(arg_5_0)
	local var_5_0 = string.format(ServerUrl.DestinyExchinfo, Player.userId)

	arg_5_0:startHttpRequest(var_5_0, false, nil, true)

	arg_5_0.state = TianmingRequest.eExchinfo
end

function TianmingRequest.requestExchange(arg_6_0, arg_6_1, arg_6_2)
	if type(arg_6_2) == "table" then
		arg_6_2 = table.concat(arg_6_2, ",")
	else
		arg_6_2 = ""
	end

	local var_6_0 = string.format(ServerUrl.DestinyExchange, Player.userId, arg_6_1, arg_6_2)

	arg_6_0:startHttpRequest(var_6_0, false, nil, true)

	arg_6_0.state = TianmingRequest.eExchange
end

function TianmingRequest.requestSelect(arg_7_0, arg_7_1)
	local var_7_0 = string.format(ServerUrl.ResolveSelect, Player.userId, arg_7_1)

	arg_7_0:startHttpRequest(var_7_0, false, nil, true)

	arg_7_0.state = TianmingRequest.eSelect
end

function TianmingRequest.requestResolveBatch(arg_8_0, arg_8_1)
	local var_8_0 = string.format(ServerUrl.ResolveBatch, Player.userId, arg_8_1 or 1)

	arg_8_0:startHttpRequest(var_8_0, false, nil, true)

	arg_8_0.state = TianmingRequest.eReBatch
end

function TianmingRequest.parseJsonValue(arg_9_0, arg_9_1)
	arg_9_0.restable = arg_9_1
end

function TianmingRequest.getResponseContent(arg_10_0)
	return arg_10_0.state, arg_10_0.restable
end

TianmingListRequest = NetworkRequest:new()
TianmingListRequest.timeoutOperate = TimeoutOperation.eRetry

function TianmingListRequest.request(arg_11_0)
	local var_11_0 = string.format(ServerUrl.DestinyList, Player.userId)

	arg_11_0:startHttpRequest(var_11_0, false, nil, true)
end

function TianmingListRequest.parseJsonValue(arg_12_0, arg_12_1)
	arg_12_0.restable = arg_12_1
end

function TianmingListRequest.getTianmingList(arg_13_0)
	return arg_13_0.restable
end

TianmingChangeRequest = NetworkRequest:new()
TianmingChangeRequest.timeoutOperate = TimeoutOperation.eRetry

function TianmingChangeRequest.request(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = string.format(ServerUrl.DestinyChange, Player.userId, arg_14_1, arg_14_2, arg_14_3)

	arg_14_0:startHttpRequest(var_14_0, false, nil, true)
end

function TianmingChangeRequest.parseJsonValue(arg_15_0, arg_15_1)
	return
end

DestinyUnloadingRequest = NetworkRequest:new()
TianmingChangeRequest.timeoutOperate = TimeoutOperation.eRetry

function DestinyUnloadingRequest.request(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = string.format(ServerUrl.DestinyUnloading, Player.userId, arg_16_1, arg_16_2)

	arg_16_0:startHttpRequest(var_16_0, false, nil, true)
end

function DestinyUnloadingRequest.parseJsonValue(arg_17_0, arg_17_1)
	return
end

DestinyChangeAllRequest = NetworkRequest:new()
DestinyChangeAllRequest.timeoutOperate = TimeoutOperation.eRetry

function DestinyChangeAllRequest.request(arg_18_0, arg_18_1)
	local var_18_0 = string.format(ServerUrl.DestinyChangeAll, Player.userId, arg_18_1)

	arg_18_0:startHttpRequest(var_18_0, false, nil, true)
end

function DestinyChangeAllRequest.parseJsonValue(arg_19_0, arg_19_1)
	return
end

DestinyUpgradeRequest = NetworkRequest:new()
DestinyUpgradeRequest.timeoutOperate = TimeoutOperation.eRetry

function DestinyUpgradeRequest.request(arg_20_0, arg_20_1)
	local var_20_0 = string.format(ServerUrl.DestinyUpgrade, Player.userId, arg_20_1)

	arg_20_0:startHttpRequest(var_20_0, false, nil, true)
end

function DestinyUpgradeRequest.parseJsonValue(arg_21_0, arg_21_1)
	return
end

DestinyHaloUpgradeRequest = NetworkRequest:new()
DestinyHaloUpgradeRequest.timeoutOperate = TimeoutOperation.eRetry

function DestinyHaloUpgradeRequest.request(arg_22_0, arg_22_1)
	local var_22_0 = string.format(ServerUrl.DestinyHaloUpgrade, Player.userId, arg_22_1)

	arg_22_0:startHttpRequest(var_22_0, false, nil, true)
end

function DestinyHaloUpgradeRequest.parseJsonValue(arg_23_0, arg_23_1)
	return
end

DestinyChangeHaloRequest = NetworkRequest:new()
DestinyChangeHaloRequest.timeoutOperate = TimeoutOperation.eRetry

function DestinyChangeHaloRequest.request(arg_24_0, arg_24_1)
	local var_24_0 = string.format(ServerUrl.DestinyChangeHalo, Player.userId, arg_24_1)

	arg_24_0:startHttpRequest(var_24_0, false, nil, true)
end

function DestinyChangeHaloRequest.parseJsonValue(arg_25_0, arg_25_1)
	return
end

MillionHuntRequest = NetworkRequest:new()
MillionHuntRequest.timeoutOperate = TimeoutOperation.eRetry

function MillionHuntRequest.request(arg_26_0, arg_26_1)
	local var_26_0 = string.format(ServerUrl.MillionHunt, Player.userId, tostring(arg_26_1))

	arg_26_0:startHttpRequest(var_26_0, false, nil, true)
end

function MillionHuntRequest.parseJsonValue(arg_27_0, arg_27_1)
	arg_27_0.restable = arg_27_1
end

GetMillionHuntRequest = NetworkRequest:new()
GetMillionHuntRequest.timeoutOperate = TimeoutOperation.eRetry

function GetMillionHuntRequest.request(arg_28_0)
	local var_28_0 = string.format(ServerUrl.GetMillionHunt, Player.userId)

	arg_28_0:startHttpRequest(var_28_0, false, nil, true)
end

function GetMillionHuntRequest.parseJsonValue(arg_29_0, arg_29_1)
	arg_29_0.restable = arg_29_1
end
