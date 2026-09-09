require("base.figure")
require("network.ActivityRequest")

local var_0_0 = class("DlgShareLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.shareText = arg_2_1.shareText
	arg_2_0.closeCallback = arg_2_1.closeCallback
	arg_2_0.sharePlatform = arg_2_1.sharePlatform
	arg_2_0.isShareScreen = arg_2_1.isShareScreen == nil and true or arg_2_1.isShareScreen

	arg_2_0:initNetworkRequest()

	if arg_2_0.isShareScreen then
		local var_2_0 = "screenshot.jpg"

		local function var_2_1(arg_4_0)
			arg_2_0:initShareUI()

			if arg_4_0 == false then
				showFlashNotice(string.lf("上仙，屏幕截取失败了!"))
			else
				arg_2_0:showScreenCapture(CCFileUtils:sharedFileUtils():getWritablePath() .. var_2_0)
			end
		end

		IPlatform:instance():AddLuaCallBack(Lua_CallBackType_ScreenCapture, var_2_1)
		IPlatform:instance():ScreenCapture(var_2_0)
	else
		if arg_2_0.sharePlatform ~= SHARE_TYPE_FACEBOOK then
			arg_2_0:setVisible(false)
		else
			arg_2_0:initShareUI()
		end

		arg_2_0:sendShareContent(arg_2_0.sharePlatform)
	end
end

function var_0_0.initNetworkRequest(arg_5_0)
	arg_5_0.shareRequest = SocialShareComplatedRequest:new()

	local function var_5_0()
		if arg_5_0.shareRequest:getRequestReward() == nil then
			ui.showMessageBox({
				text = string.lf("上仙，你今日已领取过分享奖励了！")
			})
		end

		arg_5_0:closeShareLayer()
	end

	arg_5_0.shareRequest:setResponseNormalHandler(var_5_0)
end

function var_0_0.initShareUI(arg_7_0)
	local var_7_0 = CCSize(500, 280)
	local var_7_1 = display.newScale9Sprite("ui/common/common_116.png")

	var_7_1:setPreferredSize(var_7_0)
	var_7_1:setAnchorPoint(CCPoint(0.5, 0.5))
	var_7_1:setPosition(display.cx, display.cy)
	var_7_1:setScale(Adapter.MinScale)
	arg_7_0:addChild(var_7_1)

	arg_7_0.background = var_7_1
	arg_7_0.backSize = var_7_0

	local var_7_2 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		position = CCPoint(var_7_0.width - 15, var_7_0.height - 15),
		clickAction = function()
			arg_7_0:closeShareLayer()
		end
	})

	var_7_1:addChild(var_7_2)

	local var_7_3 = addLabelWithColorSize(var_7_1, arg_7_0.shareText, ccc3(200, 170, 100), 25, CCPoint(0, 1), CCPoint(25, var_7_0.height - 20))

	var_7_3:setDimensions(CCSize(var_7_0.width - 70, 150))
	var_7_3:setHorizontalAlignment(kCCTextAlignmentLeft)
	var_7_3:setVerticalAlignment(kCCVerticalTextAlignmentTop)

	local var_7_4 = getShareEnabledTable()

	for iter_7_0 = 1, #var_7_4 do
		local var_7_5 = ui.newControlButton({
			normalImage = var_7_4[iter_7_0].image,
			size = CCSize(80, 80),
			position = CCPoint(var_7_0.width / 2 - 300 + 200 * iter_7_0, 65),
			clickAction = function()
				arg_7_0:sendShareContent(var_7_4[iter_7_0].type)
			end
		})

		var_7_1:addChild(var_7_5)
	end
end

function var_0_0.sendShareContent(arg_10_0, arg_10_1)
	if arg_10_1 == nil then
		return
	end

	IPlatform:instance():AddLuaCallBack(Lua_CallBackType_Share, function(arg_11_0)
		if arg_11_0 == true or arg_11_0 == nil then
			arg_10_0.shareRequest:request()
		elseif arg_10_0.isShareScreen == false then
			arg_10_0:closeShareLayer()
		end
	end)

	local var_10_0 = CCFileUtils:sharedFileUtils():fullPathForFilename("ui/account/account_009.jpg")

	IPlatform:instance():Share(arg_10_1, arg_10_0.shareText, arg_10_0.imagePath or var_10_0)
end

function var_0_0.showScreenCapture(arg_12_0, arg_12_1)
	if arg_12_1 == nil or #arg_12_1 == 0 then
		return
	end

	arg_12_0.imagePath = arg_12_1
end

function var_0_0.closeShareLayer(arg_13_0)
	if arg_13_0.closeCallback then
		arg_13_0.closeCallback({})
	end

	arg_13_0:removeFromParentAndCleanup(true)
end

return var_0_0
