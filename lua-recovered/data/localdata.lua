require("data.player")
require("base.platform")

LocalData = {
	data = {},
	fullpath = (EditionConfig.__ResourceUpdaterDir or device.cachePath) .. EditionConfig.__UserData
}

function LocalData.readLocalData(arg_1_0)
	if io.exists(arg_1_0.fullpath) then
		local var_1_0 = io.readfile(arg_1_0.fullpath)

		arg_1_0.data = json.decode(var_1_0) or {}

		if arg_1_0.data.userId then
			Player:setUserId(arg_1_0.data.userId)
			Player:setThirdUserId(arg_1_0.data.thirdUserId)
			Player:setAccount(arg_1_0.data.account)
		end

		if arg_1_0.data.serverInfo then
			Player:setServerInfo(arg_1_0.data.serverInfo)
		end

		if arg_1_0.data.resourceID then
			NetworkMediator:setRequestResVersion(arg_1_0.data.resourceID)
		end
	else
		arg_1_0.data = {}
	end

	if EditionConfig.__LoginMode == "local" then
		-- Persist device/settings separately, but never restore authentication or
		-- an old server URL. Fresh account tickets survive scene reconstruction.
		arg_1_0.data.userId = nil
		arg_1_0.data.thirdUserId = nil
		arg_1_0.data.account = nil
		arg_1_0.data.serverInfo = nil
		Player:setUserId(nil)
		Player:setThirdUserId(nil)
		Player:setAccount(nil)
		Player:setRequestSession("")
		Player:setServerInfo(nil)
	end

	local var_1_1 = arg_1_0.data.setting

	if var_1_1 == nil then
		arg_1_0:restoreSetting()
	else
		arg_1_0:setMusicVolume(var_1_1.musicVolume)
		arg_1_0:setEffectVolume(var_1_1.effectVolume)
	end

	arg_1_0.data.gameData = arg_1_0.data.gameData or {}
	arg_1_0.data.iapData = arg_1_0.data.iapData or {}
	arg_1_0.data.versionID = arg_1_0.data.versionID or EditionConfig.__Version

	Player:setDeviceToken(arg_1_0.data.deviceToken or Platform.requestDeviceToken())
end

function LocalData.getLastServerList(arg_2_0)
	return arg_2_0.data.lastServerList
end

function LocalData.saveLoginAccountData(arg_3_0)
	arg_3_0.data.userId = Player.userId
	arg_3_0.data.thirdUserId = Player.thirdUserId
	arg_3_0.data.deviceToken = Player.deviceToken
	arg_3_0.data.account = Player.account

	arg_3_0:saveLocalData()
end

function LocalData.saveLoginServerInfo(arg_4_0)
	arg_4_0.data.serverInfo = Player.serverInfo

	arg_4_0:saveLocalData()
end

function LocalData.addLastServerName(arg_5_0, arg_5_1)
	arg_5_0.data.lastServerList = arg_5_0.data.lastServerList or {}

	local var_5_0 = arg_5_0.data.lastServerList

	if var_5_0[1] == arg_5_1 or not arg_5_1 then
		return
	end

	if var_5_0[1] then
		var_5_0[2] = var_5_0[1]
	end

	var_5_0[1] = arg_5_1

	arg_5_0:saveLocalData()
end

function LocalData.saveLocalData(arg_6_0)
	local var_6_0 = json.encode(arg_6_0.data)

	io.writefile(arg_6_0.fullpath, var_6_0)
end

function LocalData.saveResourceID(arg_7_0, arg_7_1)
	arg_7_0.data.resourceID = arg_7_1

	arg_7_0:saveLocalData()
end

function LocalData.getResourceID(arg_8_0)
	return arg_8_0.data.resourceID
end

function LocalData.restoreSetting(arg_9_0)
	arg_9_0.data.setting = {}

	local var_9_0 = arg_9_0.data.setting

	arg_9_0:setMusicEnabled(true)
	arg_9_0:setEffectEnabled(true)
	arg_9_0:setPushEnabled(true)
	arg_9_0:setMusicVolume(80)
	arg_9_0:setEffectVolume(80)
end

function LocalData.getSetting(arg_10_0)
	return arg_10_0.data.setting
end

function LocalData.setMusicEnabled(arg_11_0, arg_11_1)
	arg_11_0.data.setting.musicEnabled = arg_11_1
end

function LocalData.setEffectEnabled(arg_12_0, arg_12_1)
	arg_12_0.data.setting.effectEnabled = arg_12_1
end

function LocalData.setPushEnabled(arg_13_0, arg_13_1)
	arg_13_0.data.setting.pushEnabled = arg_13_1
end

function LocalData.setMusicVolume(arg_14_0, arg_14_1)
	arg_14_0.data.setting.musicVolume = arg_14_1

	SimpleAudioEngine:sharedEngine():setBackgroundMusicVolume(arg_14_1 / 100)
end

function LocalData.setEffectVolume(arg_15_0, arg_15_1)
	arg_15_0.data.setting.effectVolume = arg_15_1

	SimpleAudioEngine:sharedEngine():setEffectsVolume(arg_15_1 / 100)
end

function LocalData.addIAPData(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.data.iapData) do
		if iter_16_1.productIdentifier == arg_16_1.productIdentifier then
			return
		end
	end

	table.insert(arg_16_0.data.iapData, arg_16_1)
	arg_16_0:saveLocalData()
end

function LocalData.removeIAPData(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.data.iapData) do
		if iter_17_1.productIdentifier == arg_17_1 then
			table.remove(arg_17_0.data.iapData, iter_17_0)

			break
		end
	end

	arg_17_0:saveLocalData()
end

function LocalData.getIAPList(arg_18_0)
	return arg_18_0.data.iapData
end

function LocalData.saveGameDataValue(arg_19_0, arg_19_1, arg_19_2)
	if type(arg_19_1) == "string" then
		arg_19_0.data.gameData[arg_19_1] = arg_19_2
	else
		print("LocalData:saveLocalValue key must be string!!!")
	end

	arg_19_0:saveLocalData()
end

function LocalData.getGameDataValue(arg_20_0, arg_20_1)
	return arg_20_0.data.gameData[arg_20_1]
end
