require("base.request")

local var_0_0 = require("scenes.toollayer.tool")

DailyRewardRequest = NetworkRequest:new()
DailyRewardRequest.timeoutOperate = TimeoutOperation.eRetry
DailyRewardRequest.isNoticeReward = true
DailyRewardRequest.eInfo = 1
DailyRewardRequest.eLevy = 2
DailyRewardRequest.eObtain = 3
DailyRewardRequest.eSalary = 4

function DailyRewardRequest.requestSalaryInfo(arg_1_0)
	local var_1_0 = string.format(ServerUrl.DailySalaryInfo, Player.userId)

	arg_1_0.state = DailyRewardRequest.eSalary

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function DailyRewardRequest.requestRewardInfo(arg_2_0)
	local var_2_0 = string.format(ServerUrl.DailyRewardInfo, Player.userId)

	arg_2_0.state = DailyRewardRequest.eInfo

	arg_2_0:startHttpRequest(var_2_0, false, nil, true)
end

function DailyRewardRequest.requestTodaySalary(arg_3_0)
	local var_3_0 = string.format(ServerUrl.GetTodaySalary, Player.userId)

	arg_3_0.state = DailyRewardRequest.eLevy

	arg_3_0:startHttpRequest(var_3_0, false, nil, true)
end

function DailyRewardRequest.requestTodayGift(arg_4_0, arg_4_1)
	local var_4_0 = string.format(ServerUrl.GetTodayGift, Player.userId, arg_4_1)

	arg_4_0.state = DailyRewardRequest.eObtain

	arg_4_0:startHttpRequest(var_4_0, false, nil, true)
end

function DailyRewardRequest.getResponseContent(arg_5_0)
	return arg_5_0.state, arg_5_0.restable
end

function DailyRewardRequest.parseJsonValue(arg_6_0, arg_6_1)
	arg_6_0.restable = arg_6_1
end

MissionInfoRequest = NetworkRequest:new()
MissionInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function MissionInfoRequest.request(arg_7_0)
	local var_7_0 = string.format(ServerUrl.MissionInfo, Player.userId)

	arg_7_0:startHttpRequest(var_7_0, false, nil, true)
end

function MissionInfoRequest.parseJsonValue(arg_8_0, arg_8_1)
	Player.missionData = arg_8_1
	Player.missionTime = var_0_0.getCurrentDate().day
end

MissionRewardRequest = NetworkRequest:new()

function MissionRewardRequest.request(arg_9_0, arg_9_1)
	local var_9_0 = string.format(ServerUrl.MissionReward, Player.userId, arg_9_1)

	arg_9_0:startHttpRequest(var_9_0, false, nil, true)
end

function MissionRewardRequest.parseJsonValue(arg_10_0, arg_10_1)
	return
end
