DarkHouseInfoRequest = NetworkRequest:new()
DarkHouseInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function DarkHouseInfoRequest.request(arg_1_0)
	local var_1_0 = string.format(ServerUrl.DarkHouseInfo, Player.userId)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function DarkHouseInfoRequest.parseJsonValue(arg_2_0, arg_2_1)
	arg_2_0.restable = arg_2_1
end

SlaveDriveRequest = NetworkRequest:new()

function SlaveDriveRequest.request(arg_3_0)
	local var_3_0 = string.format(ServerUrl.SlaveDrive, Player.userId)

	arg_3_0:startHttpRequest(var_3_0, false, nil, true)
end

function SlaveDriveRequest.parseJsonValue(arg_4_0, arg_4_1)
	arg_4_0.restable = arg_4_1
end

SlaveGainPartRequest = NetworkRequest:new()

function SlaveGainPartRequest.request(arg_5_0, arg_5_1)
	local var_5_0 = string.format(ServerUrl.SlaveGainPart, Player.userId, arg_5_1)

	arg_5_0:startHttpRequest(var_5_0, false, nil, true)
end

function SlaveGainPartRequest.parseJsonValue(arg_6_0, arg_6_1)
	arg_6_0.restable = arg_6_1
end

SlaveBleedWhiteRequest = NetworkRequest:new()

function SlaveBleedWhiteRequest.request(arg_7_0, arg_7_1)
	local var_7_0 = string.format(ServerUrl.SlaveBleedWhite, Player.userId, arg_7_1)

	arg_7_0:startHttpRequest(var_7_0, false, nil, true)
end

function SlaveBleedWhiteRequest.parseJsonValue(arg_8_0, arg_8_1)
	arg_8_0.restable = arg_8_1
end

SlaveGetAllRequest = NetworkRequest:new()

function SlaveGetAllRequest.request(arg_9_0, arg_9_1)
	local var_9_0 = string.format(ServerUrl.SlaveGetAll, Player.userId, arg_9_1)

	arg_9_0:startHttpRequest(var_9_0, false, nil, true)
end

function SlaveGetAllRequest.parseJsonValue(arg_10_0, arg_10_1)
	arg_10_0.restable = arg_10_1
end

SlaveEnemyListRequest = NetworkRequest:new()
SlaveEnemyListRequest.timeoutOperate = TimeoutOperation.eRetry

function SlaveEnemyListRequest.request(arg_11_0, arg_11_1)
	local var_11_0 = string.format(ServerUrl.SlaveEnemyList, Player.userId, arg_11_1)

	arg_11_0:startHttpRequest(var_11_0, false, nil, true)
end

function SlaveEnemyListRequest.parseJsonValue(arg_12_0, arg_12_1)
	arg_12_0.restable = arg_12_1
end

SlaveReportListRequest = NetworkRequest:new()
SlaveReportListRequest.timeoutOperate = TimeoutOperation.eRetry

function SlaveReportListRequest.request(arg_13_0)
	local var_13_0 = string.format(ServerUrl.SlaveReportList, Player.userId)

	arg_13_0:startHttpRequest(var_13_0, false, nil, true)
end

function SlaveReportListRequest.parseJsonValue(arg_14_0, arg_14_1)
	arg_14_0.restable = arg_14_1
end

SlaveRandomListRequest = NetworkRequest:new()
SlaveRandomListRequest.timeoutOperate = TimeoutOperation.eRetry

function SlaveRandomListRequest.request(arg_15_0)
	local var_15_0 = string.format(ServerUrl.SlaveRandomList, Player.userId)

	arg_15_0:startHttpRequest(var_15_0, false, nil, true)
end

function SlaveRandomListRequest.parseJsonValue(arg_16_0, arg_16_1)
	arg_16_0.restable = arg_16_1
end

SlaveFriendListRequest = NetworkRequest:new()
SlaveFriendListRequest.timeoutOperate = TimeoutOperation.eRetry

function SlaveFriendListRequest.request(arg_17_0)
	local var_17_0 = string.format(ServerUrl.SlaveFriendList, Player.userId)

	arg_17_0:startHttpRequest(var_17_0, false, nil, true)
end

function SlaveFriendListRequest.parseJsonValue(arg_18_0, arg_18_1)
	arg_18_0.restable = arg_18_1
end

SlaveCatchRequest = NetworkRequest:new()

function SlaveCatchRequest.request(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = string.format(ServerUrl.DarkHouseCatchBattle, Player.userId, arg_19_1, arg_19_2, 1)

	arg_19_0:startHttpRequest(var_19_0, false, nil, true)
end

function SlaveCatchRequest.parseJsonValue(arg_20_0, arg_20_1)
	arg_20_0.restable = arg_20_1
end
