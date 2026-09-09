GetBuffRequest = NetworkRequest:new()
GetBuffRequest.timeoutOperate = TimeoutOperation.eRetry

function GetBuffRequest.request(arg_1_0)
	local var_1_0 = string.format(ServerUrl.GetBuff, Player.userId)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function GetBuffRequest.parseJsonValue(arg_2_0, arg_2_1)
	arg_2_0.restable = arg_2_1
end

function GetBuffRequest.getBuyTime(arg_3_0)
	return arg_3_0.restable.remainBuyTime
end

function GetBuffRequest.getBuffList(arg_4_0)
	return arg_4_0.restable.buffLevels
end

TowerBuyBuffRequest = NetworkRequest:new()

function TowerBuyBuffRequest.request(arg_5_0, arg_5_1)
	local var_5_0 = string.format(ServerUrl.TowerBuyBuff, Player.userId, arg_5_1)

	arg_5_0:startHttpRequest(var_5_0, false, nil, true)
end

function TowerBuyBuffRequest.parseJsonValue(arg_6_0, arg_6_1)
	arg_6_0.restable = arg_6_1
end

function TowerBuyBuffRequest.getBuyTime(arg_7_0)
	return arg_7_0.restable.buffInfo.remainBuyTime
end

function TowerBuyBuffRequest.getBuffList(arg_8_0)
	return arg_8_0.restable.buffInfo.buffLevels
end

function TowerBuyBuffRequest.getPowerAddValue(arg_9_0)
	return arg_9_0.restable.addTotalPower
end

GetTowerInfoRequest = NetworkRequest:new()
GetTowerInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function GetTowerInfoRequest.request(arg_10_0)
	local var_10_0 = string.format(ServerUrl.GetTowerInfo, Player.userId)

	arg_10_0:startHttpRequest(var_10_0, false, nil, true)
end

function GetTowerInfoRequest.parseJsonValue(arg_11_0, arg_11_1)
	arg_11_0.restable = arg_11_1
end

function GetTowerInfoRequest.getTowerInfo(arg_12_0)
	return arg_12_0.restable
end

TowerBattleRequest = NetworkRequest:new()

function TowerBattleRequest.request(arg_13_0, arg_13_1)
	local var_13_0 = string.format(ServerUrl.TowerBattle, Player.userId, arg_13_1)

	arg_13_0:startHttpRequest(var_13_0, false, nil, true)
end

function TowerBattleRequest.parseJsonValue(arg_14_0, arg_14_1)
	arg_14_0.restable = arg_14_1
end

function TowerBattleRequest.getTowerBattleResult(arg_15_0)
	return arg_15_0.restable
end

GetFloorRewardRequest = NetworkRequest:new()

function GetFloorRewardRequest.request(arg_16_0)
	local var_16_0 = string.format(ServerUrl.GetFloorReward, Player.userId)

	arg_16_0:startHttpRequest(var_16_0, false, nil, true)
end

function GetFloorRewardRequest.parseJsonValue(arg_17_0, arg_17_1)
	arg_17_0.restable = arg_17_1
end

function GetFloorRewardRequest.getFloorReward(arg_18_0)
	return arg_18_0.restable.Resource
end

TowerReviveRequest = NetworkRequest:new()

function TowerReviveRequest.request(arg_19_0)
	local var_19_0 = string.format(ServerUrl.TowerRevive, Player.userId)

	arg_19_0:startHttpRequest(var_19_0, false, nil, true)
end

function TowerReviveRequest.parseJsonValue(arg_20_0, arg_20_1)
	arg_20_0.restable = arg_20_1
end

RankingInfoRequest = NetworkRequest:new()
RankingInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function RankingInfoRequest.request(arg_21_0)
	local var_21_0 = string.format(ServerUrl.RankingInfo, Player.userId)

	arg_21_0:startHttpRequest(var_21_0, false, nil, true)
end

function RankingInfoRequest.parseJsonValue(arg_22_0, arg_22_1)
	arg_22_0.restable = arg_22_1
end

function RankingInfoRequest.getRankingInfo(arg_23_0)
	return arg_23_0.restable
end

LastWeekRankingRequest = NetworkRequest:new()
LastWeekRankingRequest.timeoutOperate = TimeoutOperation.eRetry

function LastWeekRankingRequest.request(arg_24_0)
	local var_24_0 = string.format(ServerUrl.LastWeekRanking, Player.userId)

	arg_24_0:startHttpRequest(var_24_0, false, nil, true)
end

function LastWeekRankingRequest.parseJsonValue(arg_25_0, arg_25_1)
	arg_25_0.restable = arg_25_1
end

function LastWeekRankingRequest.getRankingInfo(arg_26_0)
	return arg_26_0.restable
end

BuffAddtionsRequest = NetworkRequest:new()
BuffAddtionsRequest.timeoutOperate = TimeoutOperation.eRetry

function BuffAddtionsRequest.request(arg_27_0)
	local var_27_0 = string.format(ServerUrl.BuffAddtions, Player.userId)

	arg_27_0:startHttpRequest(var_27_0, false, nil, true)
end

function BuffAddtionsRequest.parseJsonValue(arg_28_0, arg_28_1)
	arg_28_0.restable = arg_28_1
end

function BuffAddtionsRequest.getAddedProperty(arg_29_0)
	return arg_29_0.restable
end

StartMoppingRequest = NetworkRequest:new()

function StartMoppingRequest.request(arg_30_0)
	local var_30_0 = string.format(ServerUrl.StartMopping, Player.userId)

	arg_30_0:startHttpRequest(var_30_0, false, nil, true)
end

function StartMoppingRequest.parseJsonValue(arg_31_0, arg_31_1)
	arg_31_0.restable = arg_31_1
end

function StartMoppingRequest.getMoppingScore(arg_32_0, arg_32_1)
	return arg_32_0.restable.score
end

function StartMoppingRequest.getMoppingHaveFloor(arg_33_0, arg_33_1)
	return arg_33_0.restable.haveFloor
end

function StartMoppingRequest.getMoppingState(arg_34_0, arg_34_1)
	return arg_34_0.restable.isMopping
end

function StartMoppingRequest.getMoppingFloor(arg_35_0, arg_35_1)
	return arg_35_0.restable.floor
end

function StartMoppingRequest.getMoppingRemainTime(arg_36_0, arg_36_1)
	return arg_36_0.restable.remainTime
end
