require("base.request")

QiShuRequest = NetworkRequest:new()
QiShuRequest.eInfo = 1
QiShuRequest.eUpgrade = 2

function QiShuRequest.requestTechInfo(arg_1_0)
	local var_1_0 = string.format(ServerUrl.GetTechInfo, Player.userId)

	arg_1_0.timeoutOperate = TimeoutOperation.eRetry
	arg_1_0.state = QiShuRequest.eInfo

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function QiShuRequest.requestUpgradeTech(arg_2_0, arg_2_1)
	local var_2_0 = string.format(ServerUrl.UpgradeTech, Player.userId, arg_2_1)

	arg_2_0.timeoutOperate = TimeoutOperation.eExcep
	arg_2_0.state = QiShuRequest.eUpgrade

	arg_2_0:startHttpRequest(var_2_0, false, nil, true)
end

function QiShuRequest.getResponseContent(arg_3_0)
	return arg_3_0.state, arg_3_0.restable
end

function QiShuRequest.parseJsonValue(arg_4_0, arg_4_1)
	arg_4_0.restable = arg_4_1
end
