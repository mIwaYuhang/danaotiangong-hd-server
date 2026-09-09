require("network.MailRequest")

local var_0_0 = class("AnnouncementScene", function()
	return display.newScene("AnnouncementScene")
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	local var_2_0 = require("scenes.CommonBgLayer").new({
		bgSprite = "ui/announcement/announcement_001.png",
		closeButtonPosition = ccp(10362, -13),
		returnAction = function(arg_3_0, arg_3_1)
			Platform.removeWebView()
			game.enterHomeScene()
		end
	})

	arg_2_0:addChild(var_2_0)

	arg_2_0.bgSprite = var_2_0:getBackgroundSprite()

	local var_2_1 = ui.newControlButton({
		fontSize = 28,
		normalImage = "ui/common/common_105.png",
		highlightedImage = "ui/common/common_106.png",
		text = string.lf("关闭"),
		textColor = ColorTable.eTitleButton_Normal,
		position = ccp(362.5, -20),
		clickAction = function()
			Platform.removeWebView()
			game.enterHomeScene()
		end
	})

	arg_2_0.bgSprite:addChild(var_2_1)
	arg_2_0:showWebView(arg_2_0.bgSprite)
end

function var_0_0.showWebView(arg_5_0, arg_5_1)
	local var_5_0 = 125 * Adapter.MinScale + (Adapter.AutoScaleX - Adapter.MinScale) * 480
	local var_5_1 = 133 * Adapter.MinScale + (Adapter.AutoScaleY - Adapter.MinScale) * 320
	local var_5_2 = string.format("%s/Announcement/Index?user=%s", Player.serverInfo.ServerUrl, Player.userId)

	Platform.createWebViewWithURL({
		x = var_5_0,
		y = var_5_1,
		width = Adapter.MinWidth(710),
		height = Adapter.MinHeight(430),
		url = var_5_2,
		callBack = showLoginRewardLayer
	})
end

function var_0_0.onExit(arg_6_0)
	Platform.removeWebView()
end

return var_0_0
