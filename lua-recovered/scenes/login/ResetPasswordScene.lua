local var_0_0 = class("ResetPasswordScene", function()
	return display.newScene("ResetPasswordScene")
end)

function var_0_0.ctor(arg_2_0)
	local function var_2_0()
		if Player:getTroMaxStep() < 26 then
			game.enterHomeScene()
		else
			game.enterAnnouncementScene()
		end
	end

	arg_2_0.directRequest = OfficialDirectRequest:new(arg_2_0)

	arg_2_0.directRequest:setResponseNormalHandler(var_2_0)
end

function var_0_0.onEnter(arg_4_0)
	local var_4_0 = CCDirector:sharedDirector():getWinSize()
	local var_4_1 = CCLayerColor:create(ccc4(241, 217, 246, 255), var_4_0.width, var_4_0.height)

	var_4_1:setCascadeColorEnabled(false)
	arg_4_0:addChild(var_4_1)

	local var_4_2 = display.newLayer()

	var_4_2:setContentSize(CCSizeMake(960, 640))
	arg_4_0:addChild(var_4_2)

	local var_4_3 = display.newScale9Sprite("ui/account/login_header_bg.jpg")

	var_4_3:setPreferredSize(CCSizeMake(var_4_0.width, Adapter.AutoPosY(98)))
	var_4_3:setPosition(0, var_4_0.height)
	var_4_3:setAnchorPoint(ccp(0, 1))
	var_4_2:addChild(var_4_3)

	local var_4_4 = ui.newTTFLabel({
		text = string.lf("昵称登陆"),
		size = Adapter.FontSize(46),
		x = Adapter.AutoPosX(510),
		y = Adapter.AutoPosY(594),
		align = ui.TEXT_ALIGN_CENTER
	})

	var_4_2:addChild(var_4_4)

	local function var_4_5()
		print("returnButtonTouchDownAction")
		game.enterAccountLoginScene()
	end

	local var_4_6 = CCScale9Sprite:create("uilocal/account/btn_back.png")

	var_4_6:setPreferredSize(Adapter.MinSize(149, 63))

	local var_4_7 = CCControlButton:create("", _FONT_DEFAULT, Adapter.AutoPosY(30))

	var_4_7:setPosition(Adapter.AutoPos(98, 593))
	var_4_7:setPreferredSize(Adapter.MinSize(149, 63))
	var_4_7:setBackgroundSpriteForState(var_4_6, CCControlStateNormal)
	var_4_7:addHandleOfControlEvent(var_4_5, CCControlEventTouchUpInside)
	var_4_2:addChild(var_4_7)

	local var_4_8 = ui.newTTFLabel({
		text = string.lf("昵  称："),
		size = Adapter.FontSize(28),
		x = Adapter.AutoPosX(280),
		y = Adapter.AutoPosY(360),
		align = ui.TEXT_ALIGN_CENTER
	})

	var_4_8:setColor(ccc3(101, 48, 116))
	var_4_2:addChild(var_4_8)

	local var_4_9 = ui.newEditBox({
		image = "ui/account/input_bg.png",
		size = Adapter.MinSize(400, 60),
		x = Adapter.AutoPosX(530),
		y = Adapter.AutoPosY(360)
	})

	var_4_2:addChild(var_4_9)

	local var_4_10 = ui.newTTFLabel({
		text = string.lf("当前选择的服务器: %s", Player.serverInfo.ServerName),
		size = Adapter.FontSize(28),
		x = Adapter.AutoPosX(488),
		y = Adapter.AutoPosY(290),
		align = ui.TEXT_ALIGN_CENTER
	})

	var_4_10:setColor(ccc3(96, 84, 100))
	var_4_2:addChild(var_4_10)

	local function var_4_11()
		local var_6_0 = var_4_9:getText()

		if var_6_0 and string.len(var_6_0) > 0 then
			arg_4_0.directRequest:requestDirectLogin(var_6_0)
		end
	end

	local var_4_12 = CCScale9Sprite:create("ui/account/btn_001.png")

	var_4_12:setPreferredSize(Adapter.MinSize(185, 80))

	local var_4_13 = CCScale9Sprite:create("ui/account/btn_002.png")

	var_4_13:setPreferredSize(Adapter.MinSize(185, 80))

	local var_4_14 = CCControlButton:create(string.lf("登陆"), _FONT_DEFAULT, Adapter.AutoPosY(30))

	var_4_14:setPosition(Adapter.AutoPos(504, 204))
	var_4_14:setPreferredSize(Adapter.MinSize(185, 80))
	var_4_14:setBackgroundSpriteForState(var_4_12, CCControlStateNormal)
	var_4_14:setBackgroundSpriteForState(var_4_13, CCControlStateHighlighted)
	var_4_14:addHandleOfControlEvent(var_4_11, CCControlEventTouchUpInside)
	var_4_2:addChild(var_4_14)
end

return var_0_0
