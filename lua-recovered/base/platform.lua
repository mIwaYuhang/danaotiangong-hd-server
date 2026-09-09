Platform = {
	isWebViewOpen = false
}

function Platform.requestDeviceMAC()
	local var_1_0 = true
	local var_1_1 = "00000000"

	if device.platform == "ios" then
		local var_1_2

		var_1_2, var_1_1 = luaoc.callStaticMethod("PlatformIOS", "requestDeviceMAC")
	elseif device.platform == "android" then
		var_1_1 = IPlatform:instance():getDevicesMAC()
	end

	return var_1_1
end

function Platform.requestDeviceIDFV()
	local var_2_0 = true
	local var_2_1 = "00000000"

	if device.platform == "ios" then
		local var_2_2

		var_2_2, var_2_1 = luaoc.callStaticMethod("PlatformIOS", "requestDeviceIDFV")
	elseif device.platform == "android" then
		var_2_1 = IPlatform:instance():getDeviceUUID()
	end

	return var_2_1
end

function Platform.requestDeviceToken()
	local var_3_0 = true
	local var_3_1 = "00000000"

	if device.platform == "ios" then
		local var_3_2

		var_3_2, var_3_1 = luaoc.callStaticMethod("PlatformIOS", "requestDeviceToken")
	elseif device.platform == "android" then
		var_3_1 = IPlatform:instance():getDeviceUUID()
	end

	return crypto.md5(var_3_1)
end

function Platform.playVideo(arg_4_0)
	if device.platform == "ios" then
		luaoc.callStaticMethod("PlatformIOS", "playVideo", arg_4_0)
	end
end

function Platform.getStringDrawHeight(arg_5_0)
	local var_5_0 = true
	local var_5_1 = 0

	if device.platform == "ios" then
		local var_5_2

		var_5_2, var_5_1 = luaoc.callStaticMethod("PlatformIOS", "getStringDrawHeight", arg_5_0)
	elseif device.platform == "android" then
		local var_5_3 = {
			arg_5_0.text,
			arg_5_0.fontName,
			arg_5_0.fontSize,
			arg_5_0.width
		}
		local var_5_4 = "org/cocos2dx/lib/Cocos2dxBitmap"
		local var_5_5

		var_5_5, var_5_1 = luaj.callStaticMethod(var_5_4, "getTextDrawHeight", var_5_3, "(Ljava/lang/String;Ljava/lang/String;II)I")
	end

	return var_5_1
end

function Platform.createWebViewWithURL(arg_6_0)
	if device.platform == "ios" then
		luaoc.callStaticMethod("PlatformIOS", "createWebViewWithURL", arg_6_0)
	elseif device.platform == "android" then
		local var_6_0 = {
			arg_6_0.x,
			arg_6_0.y,
			arg_6_0.width,
			arg_6_0.height,
			arg_6_0.url
		}

		luaj.callStaticMethod("com/moqikaka/lib/MQHelper", "JniOpenNotice", var_6_0, "(IIIILjava/lang/String;)V")
	end

	Platform.isWebViewOpen = true
end

function Platform.removeWebView()
	if Platform.isWebViewOpen == true then
		if device.platform == "ios" then
			luaoc.callStaticMethod("PlatformIOS", "removeWebView")
		elseif device.platform == "android" then
			local var_7_0 = {
				0,
				0,
				0,
				0,
				""
			}

			luaj.callStaticMethod("com/moqikaka/lib/MQHelper", "JniOpenNotice", var_7_0, "(IIIILjava/lang/String;)V")
		end

		Platform.isWebViewOpen = false
	end
end

function Platform.exitGame()
	if device.platform == "ios" then
		luaoc.callStaticMethod("PlatformIOS", "exitGame")
	elseif device.platform == "android" then
		IPlatform:instance():exitforce()
	end
end

function Platform.showSystemHUD()
	if device.platform == "ios" then
		luaoc.callStaticMethod("PlatformIOS", "showSystemHUD")
	end
end

function Platform.hideSystemHUD()
	if device.platform == "ios" then
		luaoc.callStaticMethod("PlatformIOS", "hideSystemHUD")
	end
end

function Platform.showAdmob()
	if device.platform == "ios" then
		luaoc.callStaticMethod("PlatformIOS", "showAdmob")
	end
end
