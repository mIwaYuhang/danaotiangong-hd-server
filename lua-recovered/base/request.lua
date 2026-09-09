require("base.network")
require("base.serverurl")

TimeoutOperation = {
	eRetry = 3,
	eNothing = 1,
	eExcep = 2
}
WaitShowType = {
	eHide = 2,
	eTransparent = 3,
	eNormal = 1
}
NetworkRequest = {
	timeoutOperate = TimeoutOperation.eExcep,
	waitType = WaitShowType.eNormal
}
NetworkRequest.isNoticeReward = false
NetworkRequest.thirdResponseDataInflate = true

function NetworkRequest.new(arg_1_0, arg_1_1)
	o = {}

	setmetatable(o, arg_1_0)

	arg_1_0.__index = arg_1_0

	return o
end

function NetworkRequest.startHttpRequestWithParams(arg_2_0, arg_2_1)
	arg_2_1.fillUrl = arg_2_1.fillUrl or true
	arg_2_0.manualGlobal = arg_2_1.manualGlobal or false

	if arg_2_1.postData then
		return NetworkMediator:startHttpRequest(arg_2_0, arg_2_1.url, true, arg_2_1.postData, arg_2_1.fillUrl)
	else
		return NetworkMediator:startHttpRequest(arg_2_0, arg_2_1.url, false, nil, arg_2_1.fillUrl)
	end
end

function NetworkRequest.startHttpRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.manualGlobal = false

	NetworkMediator:startHttpRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
end

function NetworkRequest.startThirdHttpRequest(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	NetworkMediator:startThirdHttpRequest(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
end

function NetworkRequest.addUrlSignString(arg_5_0, arg_5_1)
	local var_5_0 = string.find(arg_5_1, "?") + 1
	local var_5_1 = string.sub(arg_5_1, var_5_0)
	local var_5_2 = NetworkMediator:signRequestParam(var_5_1)
	local var_5_3 = string.gsub(var_5_2, "\r\n", "")
	local var_5_4 = crypto.md5(var_5_3, false)

	signUrl = arg_5_1 .. "&sign=" .. var_5_4

	return signUrl
end

function NetworkRequest.setResponseNormalHandler(arg_6_0, arg_6_1)
	arg_6_0.normalHandler = arg_6_1
end

function NetworkRequest.setResponseExceptionHandler(arg_7_0, arg_7_1)
	arg_7_0.excepHandler = arg_7_1
end
