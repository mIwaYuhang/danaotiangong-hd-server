DEBUG_FPS = DEBUG == 2
CONFIG_SCREEN_WIDTH = 960
CONFIG_SCREEN_HEIGHT = 640

function CONFIG_SCREEN_AUTOSCALE(arg_1_0, arg_1_1)
	return
end

if not getEditionConfig then
	function getEditionConfig(arg_2_0)
		local var_2_0 = IPlatform:instance():getConfig(arg_2_0)

		return string.len(var_2_0) > 0 and var_2_0 or nil
	end
end

local var_0_0 = IPlatform:instance():getConfig("__PartnerID")
local var_0_1 = IPlatform:instance():getConfig("__LoginKEY")

EditionConfig = {
	__LoginMode = "local",
	__LocalPlaintext = true,
	__OnlineServerAddr = "http://10.0.2.2:21000",
	__OnlineSDKAddr = "http://10.0.2.2:21000",
	__Version = getEditionConfig("__Version") or "210",
	__PartnerID = string.len(var_0_0) > 0 and var_0_0 or "101",
	__LoginKEY = string.len(var_0_1) > 0 and var_0_1 or "a0482eaf-14e8-4a65-950e-864214f62da5",
	__ResourceUpdaterDir = getEditionConfig("__ResourceUpdaterDir"),
	__UserData = getEditionConfig("__UserData") or "UserData.txt"
}

-- config is loaded before data.localdata captures its fullpath.
if EditionConfig.__LoginMode == "local" then
	EditionConfig.__UserData = "UserData.local-login-v1.txt"
end
