local var_0_0 = class("ChangePasswordScene", function()
	return display.newScene("ChangePasswordScene")
end)

function var_0_0.ctor(arg_2_0)
	local function var_2_0()
		print("setResponseNormalHandler success!!")
		CCMessageBox(string.lf("正确"), string.lf("修改密码成功！"))
	end

	local function var_2_1(arg_4_0)
		if arg_4_0 == NetworkState.SdkAccountNotRegistered then
			CCMessageBox(string.lf("错误"), string.lf("账号未注册！"))

			return
		end

		if arg_4_0 == NetworkState.SdkPasswordWrong then
			CCMessageBox(string.lf("错误"), string.lf("密码错误！"))

			return
		end
	end

	arg_2_0.accountRequest = AccountRequest:new(arg_2_0)

	arg_2_0.accountRequest:setResponseNormalHandler(var_2_0)
	arg_2_0.accountRequest:setResponseExceptionHandler(var_2_1)
end

function var_0_0.onEnter(arg_5_0)
	local var_5_0 = CCDirector:sharedDirector():getWinSize()
	local var_5_1 = CCLayerColor:create(ccc4(241, 217, 246, 255), var_5_0.width, var_5_0.height)

	var_5_1:setCascadeColorEnabled(false)
	arg_5_0:addChild(var_5_1)

	local var_5_2 = display.newLayer()

	var_5_2:setContentSize(CCSizeMake(display.width, display.height))
	arg_5_0:addChild(var_5_2)

	local var_5_3 = display.newScale9Sprite("ui/account/login_header_bg.jpg")

	var_5_3:setPreferredSize(CCSizeMake(var_5_0.width, Adapter.AutoPosY(98)))
	var_5_3:setPosition(0, var_5_0.height)
	var_5_3:setAnchorPoint(ccp(0, 1))
	var_5_2:addChild(var_5_3)

	local var_5_4 = ui.newTTFLabel({
		text = string.lf("修改密码"),
		size = Adapter.FontSize(46),
		x = Adapter.AutoPosX(510),
		y = Adapter.AutoPosY(594),
		align = ui.TEXT_ALIGN_CENTER
	})

	var_5_2:addChild(var_5_4)

	local function var_5_5()
		print("returnButtonTouchDownAction")
		game.enterAccountLoginScene()
	end

	local var_5_6 = CCScale9Sprite:create("uilocal/account/btn_back.png")

	var_5_6:setPreferredSize(Adapter.MinSize(149, 63))

	local var_5_7 = CCControlButton:create("", _FONT_DEFAULT, Adapter.AutoPosY(30))

	var_5_7:setPosition(Adapter.AutoPos(98, 593))
	var_5_7:setPreferredSize(Adapter.MinSize(149, 63))
	var_5_7:setBackgroundSpriteForState(var_5_6, CCControlStateNormal)
	var_5_7:addHandleOfControlEvent(var_5_5, CCControlEventTouchUpInside)
	var_5_2:addChild(var_5_7)

	local var_5_8 = ui.newTTFLabel({
		text = string.lf("账      号 ："),
		size = Adapter.FontSize(28),
		x = Adapter.AutoPosX(275),
		y = Adapter.AutoPosY(450),
		align = ui.TEXT_ALIGN_CENTER
	})

	var_5_8:setColor(ccc3(101, 48, 116))
	var_5_2:addChild(var_5_8)

	local var_5_9 = ui.newTTFLabel({
		text = string.lf("旧 密 码："),
		size = Adapter.FontSize(28),
		x = Adapter.AutoPosX(275),
		y = Adapter.AutoPosY(370),
		align = ui.TEXT_ALIGN_CENTER
	})

	var_5_9:setColor(ccc3(101, 48, 116))
	var_5_2:addChild(var_5_9)

	local var_5_10 = ui.newTTFLabel({
		text = string.lf("新 密 码："),
		size = Adapter.FontSize(28),
		x = Adapter.AutoPosX(275),
		y = Adapter.AutoPosY(210),
		align = ui.TEXT_ALIGN_CENTER
	})

	var_5_10:setColor(ccc3(101, 48, 116))
	var_5_2:addChild(var_5_10)

	local var_5_11 = ui.newTTFLabel({
		text = string.lf("确认密码："),
		size = Adapter.FontSize(28),
		x = Adapter.AutoPosX(275),
		y = Adapter.AutoPosY(290),
		align = ui.TEXT_ALIGN_CENTER
	})

	var_5_11:setColor(ccc3(101, 48, 116))
	var_5_2:addChild(var_5_11)

	local var_5_12 = ui.newEditBox({
		image = "ui/account/input_bg.png",
		size = Adapter.MinSize(400, 60),
		x = Adapter.AutoPosX(552),
		y = Adapter.AutoPosY(450)
	})

	var_5_2:addChild(var_5_12)

	if Player.account then
		var_5_12:setText(Player.account)
	end

	local var_5_13 = ui.newEditBox({
		image = "ui/account/input_bg.png",
		size = Adapter.MinSize(400, 60),
		x = Adapter.AutoPosX(552),
		y = Adapter.AutoPosY(370)
	})

	var_5_2:addChild(var_5_13)

	local var_5_14 = ui.newEditBox({
		image = "ui/account/input_bg.png",
		size = Adapter.MinSize(400, 60),
		x = Adapter.AutoPosX(552),
		y = Adapter.AutoPosY(290)
	})

	var_5_2:addChild(var_5_14)

	local var_5_15 = ui.newEditBox({
		image = "ui/account/input_bg.png",
		size = Adapter.MinSize(400, 60),
		x = Adapter.AutoPosX(552),
		y = Adapter.AutoPosY(210)
	})

	var_5_2:addChild(var_5_15)

	local function var_5_16()
		var_5_12:setText("")
		var_5_13:setText("")
		var_5_14:setText("")
		var_5_15:setText("")
	end

	local var_5_17 = CCScale9Sprite:create("ui/account/btn_001.png")

	var_5_17:setPreferredSize(Adapter.MinSize(185, 80))

	local var_5_18 = CCScale9Sprite:create("ui/account/btn_002.png")

	var_5_18:setPreferredSize(Adapter.MinSize(185, 80))

	local var_5_19 = CCControlButton:create(string.lf("清除重填"), _FONT_DEFAULT, Adapter.AutoPosY(30))

	var_5_19:setPosition(Adapter.AutoPos(350, 90))
	var_5_19:setPreferredSize(Adapter.MinSize(185, 80))
	var_5_19:setBackgroundSpriteForState(var_5_17, CCControlStateNormal)
	var_5_19:setBackgroundSpriteForState(var_5_18, CCControlStateHighlighted)
	var_5_19:addHandleOfControlEvent(var_5_16, CCControlEventTouchUpInside)
	var_5_2:addChild(var_5_19)

	local function var_5_20()
		local var_8_0 = var_5_12:getText()
		local var_8_1 = var_5_13:getText()
		local var_8_2 = var_5_14:getText()
		local var_8_3 = var_5_15:getText()

		if matchEmailAddress(var_8_0) == false then
			CCMessageBox(string.lf("输入的账号格式不对！"), string.lf("错误"))

			return
		end

		if matchValidedString(var_8_2) == false then
			CCMessageBox(string.lf("输入的密码格式不对！"), string.lf("错误"))

			return
		end

		if var_8_1 == var_8_3 then
			CCMessageBox(string.lf("新密码不能和旧密码相同！"), string.lf("错误"))

			return
		end

		if var_8_2 ~= var_8_3 then
			CCMessageBox(string.lf("两次输入的密码不相同！"), string.lf("错误"))

			return
		end

		if arg_5_0.accountRequest:requestPasswordReset(var_8_0, var_8_1, var_8_2) then
			CCMessageBox(string.lf("帐号或密码输入错误！"), string.lf("错误"))
		end
	end

	local var_5_21 = CCScale9Sprite:create("ui/account/btn_001.png")

	var_5_21:setPreferredSize(Adapter.MinSize(185, 80))

	local var_5_22 = CCScale9Sprite:create("ui/account/btn_002.png")

	var_5_22:setPreferredSize(Adapter.MinSize(185, 80))

	local var_5_23 = CCControlButton:create(string.lf("确认创建"), _FONT_DEFAULT, Adapter.AutoPosY(30))

	var_5_23:setPosition(Adapter.AutoPos(700, 90))
	var_5_23:setPreferredSize(Adapter.MinSize(185, 80))
	var_5_23:setBackgroundSpriteForState(var_5_21, CCControlStateNormal)
	var_5_23:setBackgroundSpriteForState(var_5_22, CCControlStateHighlighted)
	var_5_23:addHandleOfControlEvent(var_5_20, CCControlEventTouchUpInside)
	var_5_2:addChild(var_5_23)
end

return var_0_0
