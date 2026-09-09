local var_0_0 = class("ResetPasswordSucessScene", function()
	return display.newScene("ResetPasswordSucessScene")
end)

function var_0_0.ctor(arg_2_0)
	return
end

function var_0_0.onEnter(arg_3_0)
	local var_3_0 = CCDirector:sharedDirector():getWinSize()
	local var_3_1 = CCLayerColor:create(ccc4(241, 217, 246, 255), var_3_0.width, var_3_0.height)

	var_3_1:setCascadeColorEnabled(false)
	arg_3_0:addChild(var_3_1)

	local var_3_2 = display.newLayer()

	var_3_2:setContentSize(CCSizeMake(960, 640))
	arg_3_0:addChild(var_3_2)

	local var_3_3 = display.newScale9Sprite("ui/account/login_header_bg.jpg")

	var_3_3:setPreferredSize(CCSizeMake(var_3_0.width, Adapter.AutoPosY(98)))
	var_3_3:setPosition(0, var_3_0.height)
	var_3_3:setAnchorPoint(ccp(0, 1))
	var_3_2:addChild(var_3_3)

	local var_3_4 = ui.newTTFLabel({
		text = string.lf("重置密码"),
		size = Adapter.FontSize(46),
		x = Adapter.AutoPosX(510),
		y = Adapter.AutoPosY(594),
		align = ui.TEXT_ALIGN_CENTER
	})

	var_3_2:addChild(var_3_4)

	local function var_3_5()
		print("returnButtonTouchDownAction")
		game.enterAccountLoginScene()
	end

	local var_3_6 = CCScale9Sprite:create("uilocal/account/btn_back.png")

	var_3_6:setPreferredSize(Adapter.MinSize(149, 63))

	local var_3_7 = CCControlButton:create("", _FONT_DEFAULT, Adapter.AutoPosY(30))

	var_3_7:setPosition(Adapter.AutoPos(98, 593))
	var_3_7:setPreferredSize(Adapter.MinSize(149, 63))
	var_3_7:setBackgroundSpriteForState(var_3_6, CCControlStateNormal)
	var_3_7:addHandleOfControlEvent(var_3_5, CCControlEventTouchUpInside)
	var_3_2:addChild(var_3_7)

	local var_3_8 = ui.newTTFLabel({
		text = string.lf("尊敬的用户您好：\n\r\t您的新密码已经发送到注册邮箱！请及时登录修改。祝您游戏愉快！"),
		size = Adapter.FontSize(30),
		x = Adapter.AutoPosX(480),
		y = Adapter.AutoPosY(300),
		align = ui.TEXT_ALIGN_CENTER
	})

	var_3_8:setHorizontalAlignment(kCCTextAlignmentLeft)
	var_3_8:setVerticalAlignment(kCCVerticalTextAlignmentTop)
	var_3_8:setDimensions(Adapter.AutoSize(520, 200))
	var_3_8:setColor(ccc3(96, 84, 100))
	Adapter.NodeAbsScale(var_3_8)
	var_3_2:addChild(var_3_8)
end

return var_0_0
