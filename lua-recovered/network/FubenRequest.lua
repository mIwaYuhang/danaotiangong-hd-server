PlayerCopyInfoRequest = NetworkRequest:new()
PlayerCopyInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function PlayerCopyInfoRequest.request(arg_1_0)
	local var_1_0 = string.format(ServerUrl.PlayerCopyInfo, Player.userId)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function PlayerCopyInfoRequest.parseJsonValue(arg_2_0, arg_2_1)
	arg_2_0.restable = arg_2_1
end

function PlayerCopyInfoRequest.getCopyInfo(arg_3_0)
	return arg_3_0.restable
end

OpenCopyRequest = NetworkRequest:new()
OpenCopyRequest.timeoutOperate = TimeoutOperation.eRetry

function OpenCopyRequest.request(arg_4_0, arg_4_1)
	local var_4_0 = string.format(ServerUrl.OpenCopy, Player.userId, arg_4_1)

	arg_4_0:startHttpRequest(var_4_0, false, nil, true)
end

function OpenCopyRequest.parseJsonValue(arg_5_0, arg_5_1)
	arg_5_0.restable = arg_5_1
end

function OpenCopyRequest.getRewardInfo(arg_6_0)
	return arg_6_0.restable
end

RefreshStarRequest = NetworkRequest:new()

function RefreshStarRequest.request(arg_7_0, arg_7_1)
	local var_7_0 = string.format(ServerUrl.RefreshStar, Player.userId, arg_7_1)

	arg_7_0:startHttpRequest(var_7_0, false, nil, true)
end

function RefreshStarRequest.parseJsonValue(arg_8_0, arg_8_1)
	arg_8_0.restable = arg_8_1
end

function RefreshStarRequest.getStarCount(arg_9_0)
	return arg_9_0.restable
end

BattleCopyRequest = NetworkRequest:new()
BattleCopyRequest.timeoutOperate = TimeoutOperation.eRetry

function BattleCopyRequest.request(arg_10_0, arg_10_1)
	local var_10_0 = string.format(ServerUrl.BattleCopy, Player.userId, arg_10_1)

	arg_10_0:startHttpRequest(var_10_0, false, nil, true)
end

function BattleCopyRequest.parseJsonValue(arg_11_0, arg_11_1)
	arg_11_0.restable = arg_11_1
end

function BattleCopyRequest.getBattleResult(arg_12_0)
	return arg_12_0.restable
end

function BattleCopyRequest.getPlayerCopyInfo(arg_13_0)
	return arg_13_0.restable.BattleResult.PlayerCopyInfo
end

OpenCardRequest = NetworkRequest:new()
OpenCardRequest.timeoutOperate = TimeoutOperation.eRetry

function OpenCardRequest.request(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = string.format(ServerUrl.OpenCard, Player.userId, arg_14_1, arg_14_2)

	arg_14_0:startHttpRequest(var_14_0, false, nil, true)
end

function OpenCardRequest.parseJsonValue(arg_15_0, arg_15_1)
	arg_15_0.restable = arg_15_1
end

GetPreviewInfoRequest = NetworkRequest:new()
GetPreviewInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function GetPreviewInfoRequest.request(arg_16_0)
	local var_16_0 = string.format(ServerUrl.GetPreviewInfo, Player.userId)

	arg_16_0:startHttpRequest(var_16_0, false, nil, true)
end

function GetPreviewInfoRequest.parseJsonValue(arg_17_0, arg_17_1)
	arg_17_0.restable = arg_17_1
end

function GetPreviewInfoRequest.getDropList(arg_18_0)
	return arg_18_0.restable
end

OpenCardRequest = NetworkRequest:new()
OpenCardRequest.timeoutOperate = TimeoutOperation.eRetry

function OpenCardRequest.request(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = string.format(ServerUrl.OpenCard, Player.userId, arg_19_1, arg_19_2)

	arg_19_0:startHttpRequest(var_19_0, false, nil, true)
end

function OpenCardRequest.parseJsonValue(arg_20_0, arg_20_1)
	arg_20_0.restable = arg_20_1
end

ZSQGetSanqingInfoRequest = NetworkRequest:new()
ZSQGetSanqingInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function ZSQGetSanqingInfoRequest.request(arg_21_0, arg_21_1)
	local var_21_0 = string.format(ServerUrl.ZSQGetSanqingInfo, Player.userId, arg_21_1)

	arg_21_0:startHttpRequest(var_21_0, false, nil, true)
end

function ZSQGetSanqingInfoRequest.parseJsonValue(arg_22_0, arg_22_1)
	arg_22_0.restable = arg_22_1
end

ZSQGetChestInfoRequest = NetworkRequest:new()
ZSQGetChestInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function ZSQGetChestInfoRequest.request(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = string.format(ServerUrl.ZSQGetChestInfo, Player.userId, arg_23_1, arg_23_2)

	arg_23_0:startHttpRequest(var_23_0, false, nil, true)
end

function ZSQGetChestInfoRequest.parseJsonValue(arg_24_0, arg_24_1)
	arg_24_0.restable = arg_24_1
end

ZSQRotateInfoRequest = NetworkRequest:new()
ZSQRotateInfoRequest.timeoutOperate = TimeoutOperation.eRetry
ZSQRotateInfoRequest.waitType = WaitShowType.eHide

function ZSQRotateInfoRequest.request(arg_25_0)
	local var_25_0 = string.format(ServerUrl.ZSQRotateInfo, Player.userId)

	arg_25_0:startHttpRequest(var_25_0, false, nil, true)
end

function ZSQRotateInfoRequest.parseJsonValue(arg_26_0, arg_26_1)
	arg_26_0.restable = arg_26_1
end

ZSQReportsRequest = NetworkRequest:new()
ZSQReportsRequest.timeoutOperate = TimeoutOperation.eRetry

function ZSQReportsRequest.request(arg_27_0, arg_27_1)
	local var_27_0 = string.format(ServerUrl.ZSQReports, Player.userId, arg_27_1)

	arg_27_0:startHttpRequest(var_27_0, false, nil, true)
end

function ZSQReportsRequest.parseJsonValue(arg_28_0, arg_28_1)
	arg_28_0.restable = arg_28_1
end
