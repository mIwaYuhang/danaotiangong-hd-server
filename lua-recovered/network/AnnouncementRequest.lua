local var_0_0 = NetworkRequest:new()

var_0_0.timeoutOperate = TimeoutOperation.eNothing
var_0_0.waitType = WaitShowType.eHide

function var_0_0.request(arg_1_0)
	local var_1_0 = string.format(ServerUrl.Announcement, Player.userId)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function var_0_0.parseJsonValue(arg_2_0, arg_2_1)
	arg_2_0.restable = arg_2_1
end

return var_0_0
