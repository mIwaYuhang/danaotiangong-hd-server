ArtifactRequest = NetworkRequest:new()
ArtifactRequest.timeoutOperate = TimeoutOperation.eRetry

function ArtifactRequest.requestInfo(arg_1_0)
	local var_1_0 = string.format(ServerUrl.ArtifacthallInfo, Player.userId)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)

	arg_1_0.state = ArtifactRequest.eInfo
end

function ArtifactRequest.parseJsonValue(arg_2_0, arg_2_1)
	arg_2_0.restable = arg_2_1
end

function ArtifactRequest.getArtifactInfo(arg_3_0, arg_3_1)
	return arg_3_0.restable
end

PerfusionRequest = NetworkRequest:new()

function PerfusionRequest.request(arg_4_0)
	local var_4_0 = string.format(ServerUrl.Perfusion, Player.userId)

	arg_4_0:startHttpRequest(var_4_0, false, nil, true)
end

function PerfusionRequest.parseJsonValue(arg_5_0, arg_5_1)
	Player:setArtifactLevel(arg_5_1.step)

	arg_5_0.restable = arg_5_1
end

GetBeRobInfoRequest = NetworkRequest:new()
GetBeRobInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function GetBeRobInfoRequest.request(arg_6_0, arg_6_1)
	local var_6_0 = string.format(ServerUrl.GetBeRobInfo, Player.userId, arg_6_1)

	arg_6_0:startHttpRequest(var_6_0, false, nil, true)
end

function GetBeRobInfoRequest.parseJsonValue(arg_7_0, arg_7_1)
	arg_7_0.restable = arg_7_1
end

RobFragmentRequest = NetworkRequest:new()

function RobFragmentRequest.request(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = string.format(ServerUrl.RobFragment, Player.userId, arg_8_1, arg_8_2, arg_8_3)

	arg_8_0:startHttpRequest(var_8_0, false, nil, true)
end

function RobFragmentRequest.parseJsonValue(arg_9_0, arg_9_1)
	arg_9_0.restable = arg_9_1
end

RevengeRequest = NetworkRequest:new()
RevengeRequest.timeoutOperate = TimeoutOperation.eRetry

function RevengeRequest.request(arg_10_0, arg_10_1)
	local var_10_0 = string.format(ServerUrl.Revenge, Player.userId, arg_10_1)

	arg_10_0:startHttpRequest(var_10_0, false, nil, true)
end

function RevengeRequest.parseJsonValue(arg_11_0, arg_11_1)
	arg_11_0.restable = arg_11_1
end

BattleReportRequest = NetworkRequest:new()
BattleReportRequest.timeoutOperate = TimeoutOperation.eRetry

function BattleReportRequest.request(arg_12_0)
	local var_12_0 = string.format(ServerUrl.BattleReport, Player.userId)

	arg_12_0:startHttpRequest(var_12_0, false, nil, true)
end

function BattleReportRequest.parseJsonValue(arg_13_0, arg_13_1)
	arg_13_0.restable = arg_13_1
end

BattleInfoRequest = NetworkRequest:new()
BattleInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function BattleInfoRequest.request(arg_14_0, arg_14_1)
	local var_14_0 = string.format(ServerUrl.BattleInfo, Player.userId, arg_14_1)

	arg_14_0:startHttpRequest(var_14_0, false, nil, true)
end

function BattleInfoRequest.parseJsonValue(arg_15_0, arg_15_1)
	arg_15_0.restable = arg_15_1
end

RobTenInfoRequest = NetworkRequest:new()
RobTenInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function RobTenInfoRequest.request(arg_16_0, arg_16_1)
	local var_16_0 = string.format(ServerUrl.RobTenInfo, Player.userId, arg_16_1)

	arg_16_0:startHttpRequest(var_16_0, false, nil, true)
end

function RobTenInfoRequest.parseJsonValue(arg_17_0, arg_17_1)
	arg_17_0.restable = arg_17_1
end
