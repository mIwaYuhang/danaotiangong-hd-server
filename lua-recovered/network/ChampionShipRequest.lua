local var_0_0 = require("base.cache")

daoTypes = {
	typeOfRen = 1,
	typeOfDi = 2,
	typeOfTian = 3
}
worshipTypes = {
	typeOfOppose = 2,
	typeOfSupport = 1
}
WorshipInfoRequest = NetworkRequest:new()
WorshipInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function WorshipInfoRequest.request(arg_1_0)
	local var_1_0 = string.format(ServerUrl.WorshipInfo, Player.userId)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function WorshipInfoRequest.parseJsonValue(arg_2_0, arg_2_1)
	arg_2_0.restable = arg_2_1

	var_0_0.set("cs-dao", arg_2_1.RankType)
end

WorshipUserRequest = NetworkRequest:new()

function WorshipUserRequest.request(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = string.format(ServerUrl.WorshipUser, Player.userId, arg_3_1, arg_3_2)

	arg_3_0:startHttpRequest(var_3_0, false, nil, true)
end

function WorshipUserRequest.parseJsonValue(arg_4_0, arg_4_1)
	arg_4_0.restable = arg_4_1
end

WorshipLogRequest = NetworkRequest:new()
WorshipLogRequest.timeoutOperate = TimeoutOperation.eRetry

function WorshipLogRequest.request(arg_5_0, arg_5_1)
	local var_5_0 = string.format(ServerUrl.WorshipLog, Player.userId, arg_5_1)

	arg_5_0:startHttpRequest(var_5_0, false, nil, true)
end

function WorshipLogRequest.parseJsonValue(arg_6_0, arg_6_1)
	arg_6_0.restable = arg_6_1
end

XMRankInfoRequest = NetworkRequest:new()
XMRankInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function XMRankInfoRequest.request(arg_7_0, arg_7_1)
	local var_7_0 = string.format(ServerUrl.XMRankInfo, Player.userId, arg_7_1)

	arg_7_0:startHttpRequest(var_7_0, false, nil, true)
end

function XMRankInfoRequest.getResponseContent(arg_8_0)
	return nil, arg_8_0.restable
end

function XMRankInfoRequest.parseJsonValue(arg_9_0, arg_9_1)
	arg_9_0.restable = arg_9_1
end

XMTeamInfoRequest = NetworkRequest:new()
XMTeamInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function XMTeamInfoRequest.request(arg_10_0, arg_10_1)
	local var_10_0 = string.format(ServerUrl.XMTeamInfo, Player.userId, arg_10_1)

	arg_10_0:startHttpRequest(var_10_0, false, nil, true)
end

function XMTeamInfoRequest.parseJsonValue(arg_11_0, arg_11_1)
	arg_11_0.restable = arg_11_1
end

XMBattleReportRequest = NetworkRequest:new()
XMBattleReportRequest.timeoutOperate = TimeoutOperation.eRetry

function XMBattleReportRequest.request(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2 = arg_12_2 or Player.userId

	local var_12_0 = var_0_0.get("cs-dao")
	local var_12_1 = string.format(ServerUrl.XMBattleReport, Player.userId, arg_12_2, var_12_0, arg_12_1)

	arg_12_0:startHttpRequest(var_12_1, false, nil, true)
end

function XMBattleReportRequest.getResponseContent(arg_13_0)
	return nil, arg_13_0.restable
end

function XMBattleReportRequest.parseJsonValue(arg_14_0, arg_14_1)
	arg_14_0.restable = arg_14_1
end

XMBattleInfoRequest = NetworkRequest:new()
XMBattleInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function XMBattleInfoRequest.request(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = var_0_0.get("cs-dao")
	local var_15_1 = string.format(ServerUrl.XMBattleInfo, Player.userId, arg_15_1, arg_15_2, var_15_0)

	arg_15_0:startHttpRequest(var_15_1, false, nil, true)
end

function XMBattleInfoRequest.parseJsonValue(arg_16_0, arg_16_1)
	arg_16_0.restable = arg_16_1
end

XMJoinGambleRequest = NetworkRequest:new()

function XMJoinGambleRequest.request(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = string.format(ServerUrl.XMJoinGamble, Player.userId, arg_17_1, arg_17_2, arg_17_3)

	arg_17_0:startHttpRequest(var_17_0, false, nil, true)
end

function XMJoinGambleRequest.getResponseContent(arg_18_0)
	return nil, arg_18_0.restable
end

function XMJoinGambleRequest.parseJsonValue(arg_19_0, arg_19_1)
	arg_19_0.restable = arg_19_1
end

XMGetGambleRequest = NetworkRequest:new()
XMGetGambleRequest.isNoticeReward = true

function XMGetGambleRequest.request(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = string.format(ServerUrl.XMGetGamble, Player.userId, arg_20_1, arg_20_2)

	arg_20_0:startHttpRequest(var_20_0, false, nil, true)
end

function XMGetGambleRequest.getResponseContent(arg_21_0)
	return nil, arg_21_0.restable
end

function XMGetGambleRequest.parseJsonValue(arg_22_0, arg_22_1)
	arg_22_0.restable = arg_22_1
end

XMRankRewardInfoRequest = NetworkRequest:new()

function XMRankRewardInfoRequest.request(arg_23_0, arg_23_1)
	local var_23_0 = string.format(ServerUrl.XMRankRewardInfo, Player.userId, arg_23_1)

	arg_23_0:startHttpRequest(var_23_0, false, nil, true)
end

function XMRankRewardInfoRequest.parseJsonValue(arg_24_0, arg_24_1)
	arg_24_0.restable = arg_24_1
end

XMRankRewardGetRequest = NetworkRequest:new()

function XMRankRewardGetRequest.request(arg_25_0)
	local var_25_0 = string.format(ServerUrl.XMRankRewardGet, Player.userId)

	arg_25_0:startHttpRequest(var_25_0, false, nil, true)
end

function XMRankRewardGetRequest.parseJsonValue(arg_26_0, arg_26_1)
	arg_26_0.restable = arg_26_1
end
