require("base.request")

WorldBossBaseInfoRequest = NetworkRequest:new()
WorldBossBaseInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function WorldBossBaseInfoRequest.request(arg_1_0)
	local var_1_0 = string.format(ServerUrl.WorldBossBaseInfo, Player.userId)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function WorldBossBaseInfoRequest.parseJsonValue(arg_2_0, arg_2_1)
	arg_2_0.restable = arg_2_1
end

WorldBossDPSRankRequest = NetworkRequest:new()
WorldBossDPSRankRequest.timeoutOperate = TimeoutOperation.eRetry

function WorldBossDPSRankRequest.request(arg_3_0)
	local var_3_0 = string.format(ServerUrl.WorldBossDPSRank, Player.userId)

	arg_3_0:startHttpRequest(var_3_0, false, nil, true)
end

function WorldBossDPSRankRequest.parseJsonValue(arg_4_0, arg_4_1)
	arg_4_0.restable = arg_4_1
end

WorldBossOrderRequest = NetworkRequest:new()
WorldBossOrderRequest.timeoutOperate = TimeoutOperation.eRetry

function WorldBossOrderRequest.request(arg_5_0)
	local var_5_0 = string.format(ServerUrl.WorldBossOrder, Player.userId)

	arg_5_0:startHttpRequest(var_5_0, false, nil, true)
end

function WorldBossOrderRequest.parseJsonValue(arg_6_0, arg_6_1)
	arg_6_0.restable = arg_6_1
end

WorldBossEncourageRequest = NetworkRequest:new()

function WorldBossEncourageRequest.request(arg_7_0)
	local var_7_0 = string.format(ServerUrl.WorldBossEncourage, Player.userId)

	arg_7_0:startHttpRequest(var_7_0, false, nil, true)
end

function WorldBossEncourageRequest.parseJsonValue(arg_8_0, arg_8_1)
	arg_8_0.restable = arg_8_1
end

WorldBossAutoFightRequest = NetworkRequest:new()
WorldBossAutoFightRequest.timeoutOperate = TimeoutOperation.eRetry

function WorldBossAutoFightRequest.request(arg_9_0, arg_9_1)
	local var_9_0 = string.format(ServerUrl.WorldBossAutoFight, Player.userId, arg_9_1)

	arg_9_0:startHttpRequest(var_9_0, false, nil, true)
end

function WorldBossAutoFightRequest.parseJsonValue(arg_10_0, arg_10_1)
	arg_10_0.restable = arg_10_1
end

WorldBossResugenceRequest = NetworkRequest:new()
WorldBossResugenceRequest.timeoutOperate = TimeoutOperation.eRetry

function WorldBossResugenceRequest.request(arg_11_0)
	local var_11_0 = string.format(ServerUrl.WorldBossResugence, Player.userId)

	arg_11_0:startHttpRequest(var_11_0, false, nil, true)
end

function WorldBossResugenceRequest.parseJsonValue(arg_12_0, arg_12_1)
	arg_12_0.restable = arg_12_1
end

WorldBossRewardListRequest = NetworkRequest:new()
WorldBossRewardListRequest.timeoutOperate = TimeoutOperation.eRetry

function WorldBossRewardListRequest.request(arg_13_0)
	local var_13_0 = string.format(ServerUrl.WorldBossRewardList, Player.userId)

	arg_13_0:startHttpRequest(var_13_0, false, nil, true)
end

function WorldBossRewardListRequest.parseJsonValue(arg_14_0, arg_14_1)
	arg_14_0.restable = arg_14_1
end

WorldBossGetRewardRequest = NetworkRequest:new()

function WorldBossGetRewardRequest.request(arg_15_0, arg_15_1)
	arg_15_1 = stringBase64AndUrlEncode(arg_15_1, true)

	local var_15_0 = string.format(ServerUrl.WorldBossGetReward, Player.userId, arg_15_1)

	arg_15_0:startHttpRequest(var_15_0, false, nil, true)
end

function WorldBossGetRewardRequest.parseJsonValue(arg_16_0, arg_16_1)
	arg_16_0.restable = arg_16_1
end

WorldBossBattleRequest = NetworkRequest:new()
WorldBossBattleRequest.timeoutOperate = TimeoutOperation.eRetry
WorldBossBattleRequest.eEncourage = 1
WorldBossBattleRequest.eAutoFight = 2
WorldBossBattleRequest.eResugence = 3
WorldBossBattleRequest.eBattle = 4

function WorldBossBattleRequest.requestBattle(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = string.format(ServerUrl.WorldBossChallenge, Player.userId, arg_17_1, arg_17_2)

	arg_17_0:startHttpRequest(var_17_0, false, nil, true)

	arg_17_0.state = WorldBossBattleRequest.eBattle
end

function WorldBossBattleRequest.requestEncourage(arg_18_0)
	local var_18_0 = string.format(ServerUrl.WorldBossEncourage, Player.userId)

	arg_18_0:startHttpRequest(var_18_0, false, nil, true)

	arg_18_0.state = WorldBossBattleRequest.eEncourage
end

function WorldBossBattleRequest.requestAutoFight(arg_19_0, arg_19_1)
	local var_19_0 = string.format(ServerUrl.WorldBossAutoFight, Player.userId, arg_19_1 and 1 or 0)

	arg_19_0:startHttpRequest(var_19_0, false, nil, true)

	arg_19_0.state = WorldBossBattleRequest.eAutoFight
end

function WorldBossBattleRequest.requestResugence(arg_20_0, arg_20_1)
	local var_20_0 = string.format(ServerUrl.WorldBossResugence, Player.userId, arg_20_1)

	arg_20_0:startHttpRequest(var_20_0, false, nil, true)

	arg_20_0.state = WorldBossBattleRequest.eResugence
end

function WorldBossBattleRequest.getResponseContent(arg_21_0)
	return arg_21_0.state, arg_21_0.restable
end

function WorldBossBattleRequest.parseJsonValue(arg_22_0, arg_22_1)
	arg_22_0.restable = arg_22_1
end

WorldBossUpdateRequest = NetworkRequest:new()
WorldBossUpdateRequest.timeoutOperate = TimeoutOperation.eRetry
WorldBossUpdateRequest.waitType = WaitShowType.eHide

function WorldBossUpdateRequest.requestBattleInfo(arg_23_0, arg_23_1)
	local var_23_0 = string.format(ServerUrl.WorldBossBattleInfo, Player.userId, arg_23_1)

	arg_23_0:startHttpRequest(var_23_0, false, nil, true)
end

function WorldBossUpdateRequest.getResponseContent(arg_24_0)
	return true, arg_24_0.restable
end

function WorldBossUpdateRequest.parseJsonValue(arg_25_0, arg_25_1)
	arg_25_0.restable = arg_25_1
end
