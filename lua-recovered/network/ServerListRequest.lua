ServerListRequest = NetworkRequest:new()
ServerListRequest.timeoutOperate = TimeoutOperation.eRetry
ServerStateType = {
	eMaintain = 0,
	eNormal = 4,
	eFlow = 1,
	eHot = 2,
	eRecommend = 3
}

function ServerListRequest.requestServerList(arg_1_0, arg_1_1)
	local var_1_0 = {
		PartnerID = tostring(EditionConfig.__PartnerID),
		GameVersionID = EditionConfig.__Version,
		RandNum = tostring(math.random(99, 9999))
	}

	var_1_0.EncryptedString = crypto.md5(var_1_0.PartnerID .. var_1_0.GameVersionID .. var_1_0.RandNum .. EditionConfig.__LoginKEY)

	if device.platform == "android" and io.exists("/sdcard/.hsconfig") then
		var_1_0.Mac = Platform.requestDeviceMAC() or "AABBCCDDEEFF"
	end

	arg_1_0:startThirdHttpRequest(arg_1_1 .. ServerUrl.ServerList, true, var_1_0)
end

function ServerListRequest.parseJsonValue(arg_2_0, arg_2_1)
	arg_2_0.serverData = arg_2_1

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.serverData) do
		iter_2_1.State = ServerStateType.eNormal

		if iter_2_1.ServerState == 2 then
			iter_2_1.State = ServerStateType.eMaintain
		elseif iter_2_1.ServerHeat == 2 then
			iter_2_1.State = ServerStateType.eFlow
		elseif iter_2_1.ServerHeat == 3 then
			iter_2_1.State = ServerStateType.eRecommend
		elseif iter_2_1.GroupLoad == 2 then
			iter_2_1.State = ServerStateType.eHot
		end

		iter_2_1.ServerState = nil
		iter_2_1.ServerHeat = nil
		iter_2_1.GroupLoad = nil
	end
end

function ServerListRequest.getServerData(arg_3_0)
	return arg_3_0.serverData
end
