AccountRequest = NetworkRequest:new()
AccountRequest.timeoutOperate = TimeoutOperation.eRetry

function AccountRequest.parseJsonValue(arg_1_0, arg_1_1)
	if arg_1_1 and arg_1_1.UserID ~= nil then
		Player:setThirdUserId(arg_1_1.UserID)
		Player:setAccount(arg_1_0.account)
		LocalData:saveLoginAccountData()
	end
end

function AccountRequest.requestDefaultLogin(arg_2_0)
	local var_2_0 = string.format(ServerUrl.DefaultLogin, Player.deviceToken)

	arg_2_0:startHttpRequest(arg_2_0:addUrlSignString(var_2_0), false, nil, false)
end

function AccountRequest.requestPasswordReset(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = string.format(ServerUrl.PasswordReset, arg_3_1, crypto.md5(arg_3_2), crypto.md5(arg_3_3))

	arg_3_0:startHttpRequest(arg_3_0:addUrlSignString(var_3_0), false, nil, false)
end

function AccountRequest.requestPasswordFind(arg_4_0, arg_4_1)
	local var_4_0 = string.format(ServerUrl.PasswordFind, arg_4_1)

	arg_4_0:startHttpRequest(arg_4_0:addUrlSignString(var_4_0), false, nil, false)
end

function AccountRequest.isAccountExists(arg_5_0, arg_5_1)
	local var_5_0 = string.format(ServerUrl.AccountExists, arg_5_1)

	arg_5_0:startHttpRequest(arg_5_0:addUrlSignString(var_5_0), false, nil, false)
end

function AccountRequest.requestAccountLogin(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.account = arg_6_1

	local var_6_0 = crypto.md5(arg_6_2)
	local var_6_1 = string.format(ServerUrl.AccountLogin, arg_6_1, var_6_0)

	arg_6_0:startHttpRequest(arg_6_0:addUrlSignString(var_6_1), false, nil, false)
end

function AccountRequest.requestRegisterAccount(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.account = arg_7_1

	local var_7_0 = crypto.md5(arg_7_2)
	local var_7_1 = string.format(ServerUrl.RegisterAccount, arg_7_1, var_7_0, arg_7_3, Player.deviceToken)

	arg_7_0:startHttpRequest(arg_7_0:addUrlSignString(var_7_1), false, nil, false)
end

ThirdLoginRequest = NetworkRequest:new()
ThirdLoginRequest.timeoutOperate = TimeoutOperation.eRetry

function ThirdLoginRequest.parseJsonValue(arg_8_0, arg_8_1)
	if arg_8_1 and arg_8_1.UserId ~= nil then
		Player:setUserId(arg_8_1.UserId)
		Player:setRequestSession(arg_8_1.Session)

		if arg_8_1.ExtraData then
			Player:setThirdLoginData(arg_8_1.ExtraData)
		end

		LocalData:saveLoginAccountData()
	end
end

function ThirdLoginRequest.requestThirdLogin(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = string.format(ServerUrl.PartnerLogin, stringBase64AndUrlEncode(arg_9_1, true), arg_9_2, arg_9_3, Player.deviceToken, Platform.requestDeviceIDFV(), Platform.requestDeviceMAC())

	arg_9_0:startHttpRequest(var_9_0, false, nil, true)
end
