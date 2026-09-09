require("base.netstate")
require("zlib")

NetworkMediator = {
	resversion = 0,
	globalHandler = 0,
	waitCount = 0,
	serverSceneName = ""
}

function NetworkMediator.setRequestResVersion(arg_1_0, arg_1_1)
	arg_1_0.resversion = arg_1_1
end

function NetworkMediator.setServerSceneName(arg_2_0, arg_2_1)
	arg_2_0.serverSceneName = arg_2_1
end

function NetworkMediator.initCommunicationEncode(arg_3_0, arg_3_1)
	arg_3_0.DataEncodeClass = CommunicationDataEncodeClass:new()

	arg_3_0.DataEncodeClass:SetKey(arg_3_1)
end

function NetworkMediator.signRequestParam(arg_4_0, arg_4_1)
	return (arg_4_0.DataEncodeClass:EncryptDataAndBase64(arg_4_1, string.len(arg_4_1)))
end

function NetworkMediator.onRequestFinished(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.name == "completed"
	local var_5_1 = arg_5_1.request

	if arg_5_0:doWaitLayerAndTimeOut(var_5_0, var_5_1) == true then
		return
	end

	local var_5_2 = var_5_1.requestHandler
	local var_5_3 = var_5_1:getResponseHeadersString()
	local var_5_4 = string.find(var_5_3, "Content%-Encoding:% gzip")
	local var_5_5

	if var_5_4 and var_5_4 > 0 then
		local var_5_6 = var_5_1:getResponseData()

		var_5_5 = zlib.inflate()(var_5_6)
	else
		var_5_5 = var_5_1:getResponseString()
	end

	local var_5_7

	if EditionConfig.__LoginMode == "local" and EditionConfig.__LocalPlaintext == true then
		var_5_7 = var_5_5
	else
		var_5_7 = arg_5_0.DataEncodeClass:DecryptDataWithBase64(var_5_5)
	end

	if DEBUG > 1 and EditionConfig.__LoginMode ~= "local" then
		echoInfo("Response : %s", var_5_7)
	end

	local var_5_8 = json.decode(var_5_7)
	local var_5_9 = var_5_8.State

	if var_5_8.State == NetworkState.Success then
		if var_5_8.Global then
			Player:addGlobalAttrs(var_5_1.globalHandler, var_5_8.Global, var_5_2.isNoticeReward)

			if var_5_8.Result == nil or type(var_5_8.Result) == "table" then
				var_5_8.Result = var_5_8.Result or {}
				var_5_8.Result.Consume, var_5_8.Result.Reward = var_5_8.Global.Consume, var_5_8.Global.Reward

				if var_5_8.Global.Gems then
					var_5_8.Result.Gems = var_5_8.Global.Gems
				end
			end

			if var_5_2.manualGlobal == false then
				Player:manualChangeGlobalAttrs(var_5_1.globalHandler)
			end
		end

		assert(type(var_5_2.parseJsonValue) == "function", "Can't find func 'parseJsonValue'!")
		var_5_2:parseJsonValue(var_5_8.Result)
		assert(type(var_5_2.normalHandler) == "function", "Can't find func 'normalHandler'!")
		var_5_2.normalHandler()
	else
		local var_5_10 = false

		if type(var_5_2.excepHandler) == "function" then
			var_5_10 = true

			var_5_2.excepHandler(var_5_9)
		end

		if type(NetworkState.SystemHandler[var_5_9]) == "function" then
			NetworkState.SystemHandler[var_5_9](var_5_8.Result)
		elseif NetworkState.ExceptionNames[var_5_9] then
			showFlashNotice(NetworkState.ExceptionNames[var_5_9])
		elseif var_5_10 == false then
			showFlashNotice(string.lf("未处理的错误消息，代码%s", var_5_9))
		end
	end
end

function NetworkMediator.startHttpRequest(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	local var_6_0
	local var_6_1 = arg_6_2

	if arg_6_5 == true then
		if Player.serverInfo then
			var_6_1 = Player.serverInfo.ServerUrl .. arg_6_2
		else
			print("Didn't send this request before choosed server!!!")

			return nil
		end
	end

	if arg_6_3 then
		var_6_0 = network.createHTTPRequest(handler(arg_6_0, arg_6_0.onRequestFinished), var_6_1, "POST")

		for iter_6_0, iter_6_1 in pairs(arg_6_4) do
			var_6_0:addPOSTValue(iter_6_0, iter_6_1)
		end

		if arg_6_5 == true then
			var_6_0:addPOSTValue("session", Player.session)
			var_6_0:addPOSTValue("version", EditionConfig.__Version)
			var_6_0:addPOSTValue("resource", arg_6_0.resversion)
			var_6_0:addPOSTValue("_l", arg_6_0.serverSceneName)
		end

		if DEBUG > 1 and EditionConfig.__LoginMode ~= "local" then
			dump(arg_6_4, "Post Data:")
		end
	else
		if arg_6_5 == true then
			var_6_1 = var_6_1 .. string.format("&session=%s", Player.session)
			var_6_1 = var_6_1 .. string.format("&version=%s", EditionConfig.__Version)
			var_6_1 = var_6_1 .. string.format("&resource=%s", arg_6_0.resversion)
			var_6_1 = var_6_1 .. string.format("&_l=%s", arg_6_0.serverSceneName)
		end

		var_6_0 = network.createHTTPRequest(handler(arg_6_0, arg_6_0.onRequestFinished), var_6_1, "GET")
	end

	if DEBUG > 1 and EditionConfig.__LoginMode ~= "local" then
		echoInfo("Request url : %s", var_6_1)
	end

	if arg_6_1.timeoutOperate == TimeoutOperation.eRetry then
		var_6_0.requestUrl = arg_6_2
		var_6_0.requestType = arg_6_3
		var_6_0.requestData = arg_6_4
		var_6_0.requestAppend = arg_6_5
	end

	var_6_0.requestHandler = arg_6_1

	var_6_0:setTimeout(30)
	var_6_0:start()
	arg_6_0:createWaitShowLayer(arg_6_1.waitType, arg_6_1.targetScene)

	arg_6_0.globalHandler = arg_6_0.globalHandler + 1
	var_6_0.globalHandler = arg_6_0.globalHandler

	return arg_6_0.globalHandler
end

function NetworkMediator.onThirdRequestFinished(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.name == "completed"
	local var_7_1 = arg_7_1.request

	if arg_7_0:doWaitLayerAndTimeOut(var_7_0, var_7_1) == true then
		return
	end

	local var_7_2 = var_7_1.requestHandler
	local var_7_3 = var_7_1:getResponseData()
	local var_7_4 = var_7_3

	if var_7_2.thirdResponseDataInflate == true then
		var_7_4 = zlib.inflate()(var_7_3)
	end

	if DEBUG > 1 and EditionConfig.__LoginMode ~= "local" then
		echoInfo("Response : %s", var_7_4)
	end

	local var_7_5 = json.decode(var_7_4)
	local var_7_6 = var_7_5.Code

	if var_7_5.Code == ThirdNetworkState.MQSuccess then
		assert(type(var_7_2.parseJsonValue) == "function", "Can't find func 'parseJsonValue'!")
		var_7_2:parseJsonValue(var_7_5.Data)
		assert(type(var_7_2.normalHandler) == "function", "Can't find func 'normalHandler'!")
		var_7_2.normalHandler()
	elseif type(var_7_2.excepHandler) == "function" then
		var_7_2.excepHandler(var_7_6)
	elseif type(ThirdNetworkState.SystemHandler[var_7_6]) == "function" then
		ThirdNetworkState.SystemHandler[var_7_6](var_7_5.Data)
	else
		ui.showMessageBox({
			text = string.lf("错误代码:%d, 描述:%s", var_7_6, var_7_5.Message),
			parent = var_7_2.targetScene
		})
	end
end

function NetworkMediator.startThirdHttpRequest(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0

	if arg_8_3 then
		var_8_0 = network.createHTTPRequest(handler(arg_8_0, arg_8_0.onThirdRequestFinished), arg_8_2, "POST")

		for iter_8_0, iter_8_1 in pairs(arg_8_4) do
			var_8_0:addPOSTValue(iter_8_0, iter_8_1)
		end

		if DEBUG > 1 and EditionConfig.__LoginMode ~= "local" then
			dump(arg_8_4, "Post Data:")
		end
	else
		var_8_0 = network.createHTTPRequest(handler(arg_8_0, arg_8_0.onThirdRequestFinished), arg_8_2, "GET")
	end

	if DEBUG > 1 and EditionConfig.__LoginMode ~= "local" then
		echoInfo("Request url : %s", arg_8_2)
	end

	if arg_8_1.timeoutOperate == TimeoutOperation.eRetry then
		var_8_0.requestUrl = arg_8_2
		var_8_0.requestType = arg_8_3
		var_8_0.requestData = arg_8_4
		var_8_0.thirdRequest = true
	end

	var_8_0.requestHandler = arg_8_1

	var_8_0:setTimeout(30)
	var_8_0:start()
	arg_8_0:createWaitShowLayer(arg_8_1.waitType, arg_8_1.targetScene)
end

function NetworkMediator.doWaitLayerAndTimeOut(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2.requestHandler

	if var_9_0 and var_9_0.waitType ~= WaitShowType.eHide then
		arg_9_0.waitCount = arg_9_0.waitCount - 1
		arg_9_0.waitCount = arg_9_0.waitCount < 0 and 0 or arg_9_0.waitCount

		if arg_9_0.waitCount == 0 then
			game.deleteRunningNode(NetworkMediator.newWaitLayer)
		end
	end

	if not arg_9_1 then
		if var_9_0.timeoutOperate == TimeoutOperation.eExcep then
			ui.showMessageBox({
				text = string.lf("上仙！您的网络连接不给力啊，请重新登录！T.T"),
				title1 = string.lf("确定"),
				action1 = function()
					game.restartGameEntry()
				end,
				parent = var_9_0.targetScene
			})
		elseif var_9_0.timeoutOperate == TimeoutOperation.eRetry then
			local var_9_1 = arg_9_2.thirdRequest

			local function var_9_2(arg_11_0, arg_11_1)
				if var_9_1 == true then
					arg_9_0:startThirdHttpRequest(var_9_0, arg_9_2.requestUrl, arg_9_2.requestType, arg_9_2.requestData)
				else
					arg_9_0:startHttpRequest(var_9_0, arg_9_2.requestUrl, arg_9_2.requestType, arg_9_2.requestData, arg_9_2.requestAppend)
				end
			end

			ui.showMessageBox({
				text = string.lf("上仙！您的网络连接不给力啊，请重试！T.T"),
				title1 = string.lf("重试"),
				action1 = var_9_2,
				parent = var_9_0.targetScene
			})
		else
			print("网络不给力啊！！！ 不做处理...")
		end

		return true
	end

	return false
end

function NetworkMediator.createWaitShowLayer(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 ~= WaitShowType.eHide then
		if arg_12_0.waitCount == 0 then
			game.addNodeToRunningSceneWithAutoCreate({
				ctorFunc = NetworkMediator.newWaitLayer,
				scene = arg_12_2,
				zOrder = DefaultZOrder.eMax
			})
		end

		arg_12_0.waitCount = arg_12_0.waitCount + 1
	end
end

function NetworkMediator.newWaitLayer()
	return (require("scenes.WaitServerLayer").new())
end
