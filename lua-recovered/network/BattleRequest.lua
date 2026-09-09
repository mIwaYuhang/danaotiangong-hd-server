BattleRequest = NetworkRequest:new()
BattleRequest.timeoutOperate = TimeoutOperation.eRetry
BattleRequest.waitType = WaitShowType.eNormal

function BattleRequest.requestGetBattleInfo(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_1 .. "&ri=" .. arg_1_2 .. "&star=" .. arg_1_3

	return arg_1_0:startHttpRequestWithParams({
		manualGlobal = true,
		url = arg_1_0:addUrlSignString(var_1_0)
	})
end

function BattleRequest.requestSetBattleFormation(arg_2_0, arg_2_1)
	local var_2_0 = string.format(ServerUrl.BattleTeam, Player.userId, arg_2_1)

	arg_2_0:startHttpRequest(arg_2_0:addUrlSignString(var_2_0), false, nil, true)
end

function BattleRequest.parseJsonValue(arg_3_0, arg_3_1)
	arg_3_0.resData = arg_3_1
end

function BattleRequest.getData(arg_4_0)
	return arg_4_0.resData
end

GetMapInfoRequest = NetworkRequest:new()
GetMapInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function GetMapInfoRequest.request(arg_5_0)
	local var_5_0 = string.format(ServerUrl.GetMapInfo, Player.userId)

	arg_5_0:startHttpRequest(var_5_0, false, nil, true)
end

function GetMapInfoRequest.parseJsonValue(arg_6_0, arg_6_1)
	arg_6_0.restable = arg_6_1

	Player:setTaskInfo(arg_6_1)
end

BattleTenRequest = NetworkRequest:new()

function BattleTenRequest.request(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = string.format(ServerUrl.BattleTen, Player.userId, arg_7_1, arg_7_2)

	arg_7_0:startHttpRequest(var_7_0, false, nil, true)
end

function BattleTenRequest.parseJsonValue(arg_8_0, arg_8_1)
	arg_8_0.restable = arg_8_1
end

BuyColdTimeRequest = NetworkRequest:new()

function BuyColdTimeRequest.request(arg_9_0)
	local var_9_0 = string.format(ServerUrl.BuyColdTime, Player.userId)

	arg_9_0:startHttpRequest(var_9_0, false, nil, true)
end

function BuyColdTimeRequest.parseJsonValue(arg_10_0, arg_10_1)
	arg_10_0.restable = arg_10_1
end

FullStarsRewardRequest = NetworkRequest:new()

function FullStarsRewardRequest.request(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = string.format(ServerUrl.FullStarsReward, Player.userId, arg_11_1, arg_11_2)

	arg_11_0:startHttpRequest(var_11_0, false, nil, true)
end

function FullStarsRewardRequest.parseJsonValue(arg_12_0, arg_12_1)
	arg_12_0.restable = arg_12_1
end

StarsRewardStateRequest = NetworkRequest:new()
StarsRewardStateRequest.timeoutOperate = TimeoutOperation.eRetry

function StarsRewardStateRequest.request(arg_13_0, arg_13_1)
	local var_13_0 = string.format(ServerUrl.IsFullStarsReward, Player.userId, arg_13_1)

	arg_13_0:startHttpRequest(var_13_0, false, nil, true)
end

function StarsRewardStateRequest.parseJsonValue(arg_14_0, arg_14_1)
	arg_14_0.restable = arg_14_1
end

function StarsRewardStateRequest.getStarsRewardState(arg_15_0, arg_15_1)
	return arg_15_0.restable.SanXinReward
end

NewStarsRewardStateRequest = NetworkRequest:new()
NewStarsRewardStateRequest.timeoutOperate = TimeoutOperation.eRetry

function NewStarsRewardStateRequest.request(arg_16_0, arg_16_1)
	local var_16_0 = string.format(ServerUrl.IsFullStarsRewardNew, Player.userId, arg_16_1)

	arg_16_0:startHttpRequest(var_16_0, false, nil, true)
end

function NewStarsRewardStateRequest.parseJsonValue(arg_17_0, arg_17_1)
	arg_17_0.restable = arg_17_1
end

function NewStarsRewardStateRequest.getStarsRewardState(arg_18_0, arg_18_1)
	return arg_18_0.restable.SanXinReward
end

function NewStarsRewardStateRequest.getDoubleRewardData(arg_19_0, arg_19_1)
	return arg_19_0.restable.ModulesData
end
