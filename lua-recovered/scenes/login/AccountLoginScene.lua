require("network.AccountRequest")
require("scenes.login.RegisterAccountScene")

local var_0_0 = class("AccountLoginScene", function()
	return display.newScene("AccountLoginScene")
end)

function var_0_0.ctor(arg_2_0)
	local function var_2_0()
		game.enterStartGameScene()
	end

	local function var_2_1(arg_4_0)
		if arg_4_0 == NetworkState.SdkAccountNotRegistered then
			CCMessageBox(string.lf("账号未注册！"), string.lf("错误"))

			return
		end

		if arg_4_0 == NetworkState.SdkPasswordWrong then
			CCMessageBox(string.lf("密码错误！"), string.lf("错误"))

			return
		end

		if arg_4_0 == NetworkState.SdkForbiddenLogin then
			CCMessageBox(string.lf("禁止登陆！"), string.lf("错误"))

			return
		end
	end

	arg_2_0.accountRequest = AccountRequest:new(arg_2_0)

	arg_2_0.accountRequest:setResponseNormalHandler(var_2_0)
	arg_2_0.accountRequest:setResponseExceptionHandler(var_2_1)
end

function var_0_0.onEnter(arg_5_0)
	local var_5_0 = CCLayerColor:create(ccc4(241, 217, 246, 255), display.width, display.height)

	var_5_0:setCascadeColorEnabled(false)
	arg_5_0:addChild(var_5_0)

	local var_5_1 = display.newLayer()

	arg_5_0:addChild(var_5_1)

	local var_5_2 = display.newScale9Sprite("ui/account/login_header_bg.jpg")

	var_5_2:setPreferredSize(CCSizeMake(display.width, Adapter.AutoPosY(98)))
	var_5_2:setPosition(ccp(0, display.height))
	var_5_2:setAnchorPoint(ccp(0, 1))
	var_5_1:addChild(var_5_2)

	local var_5_3 = ui.newTTFLabel({
		text = string.lf("账号登录"),
		size = Adapter.FontSize(46),
		align = ui.TEXT_ALIGN_CENTER
	})

	var_5_3:setPosition(Adapter.AutoPos(510, 594))
	var_5_1:addChild(var_5_3)

	local function var_5_4()
		game.enterStartGameScene()
	end

	local var_5_5 = CCScale9Sprite:create("uilocal/account/btn_back.png")

	var_5_5:setPreferredSize(Adapter.MinSize(149, 63))

	local var_5_6 = CCControlButton:create("", _FONT_DEFAULT, Adapter.FontSize(30))

	var_5_6:setPosition(Adapter.AutoPos(98, 593))
	var_5_6:setPreferredSize(Adapter.MinSize(149, 63))
	var_5_6:setBackgroundSpriteForState(var_5_5, CCControlStateNormal)
	var_5_6:addHandleOfControlEvent(var_5_4, CCControlEventTouchUpInside)
	var_5_1:addChild(var_5_6)

	local var_5_7 = ui.newTTFLabel({
		text = string.lf("账      号 ："),
		size = Adapter.FontSize(28),
		x = Adapter.AutoPosX(273),
		y = Adapter.AutoPosY(457),
		align = ui.TEXT_ALIGN_CENTER
	})

	var_5_7:setColor(ccc3(101, 48, 116))
	var_5_1:addChild(var_5_7)

	local var_5_8 = ui.newTTFLabel({
		text = string.lf("密      码 ："),
		size = Adapter.FontSize(28),
		x = Adapter.AutoPosX(273),
		y = Adapter.AutoPosY(365),
		align = ui.TEXT_ALIGN_CENTER
	})

	var_5_8:setColor(ccc3(101, 48, 116))
	var_5_1:addChild(var_5_8)

	local var_5_9 = ui.newEditBox({
		image = "ui/account/input_bg.png",
		size = Adapter.MinSize(400, 60),
		x = Adapter.AutoPosX(552),
		y = Adapter.AutoPosY(457)
	})

	var_5_9:setPlaceHolder(string.lf("请输入邮箱地址"))
	var_5_9:setInputMode(kEditBoxInputModeEmailAddr)
	var_5_1:addChild(var_5_9)

	if Player.account then
		var_5_9:setText(Player.account)
	end

	local var_5_10 = ui.newEditBox({
		image = "ui/account/input_bg.png",
		size = Adapter.MinSize(400, 60),
		x = Adapter.AutoPosX(552),
		y = Adapter.AutoPosY(354)
	})

	var_5_10:setInputFlag(kEditBoxInputFlagPassword)
	var_5_1:addChild(var_5_10)

	local function var_5_11()
		game.enterChangePasswordScene()
	end

	local var_5_12 = CCScale9Sprite:create("ui/account/btn_001.png")

	var_5_12:setPreferredSize(Adapter.MinSize(185, 80))

	local var_5_13 = CCScale9Sprite:create("ui/account/btn_002.png")

	var_5_13:setPreferredSize(Adapter.MinSize(185, 80))

	local var_5_14 = CCControlButton:create(string.lf("修改密码"), _FONT_DEFAULT, Adapter.AutoPosY(30))

	var_5_14:setPosition(Adapter.AutoPos(369, 240))
	var_5_14:setPreferredSize(Adapter.MinSize(185, 80))
	var_5_14:setBackgroundSpriteForState(var_5_12, CCControlStateNormal)
	var_5_14:setBackgroundSpriteForState(var_5_13, CCControlStateHighlighted)
	var_5_14:addHandleOfControlEvent(var_5_11, CCControlEventTouchUpInside)
	var_5_1:addChild(var_5_14)

	local function var_5_15()
		local var_8_0 = var_5_9:getText()
		local var_8_1 = var_5_10:getText()

		arg_5_0:loginRequest(var_8_0, var_8_1)
	end

	local var_5_16 = CCScale9Sprite:create("uilocal/account/btn_login.png")

	var_5_16:setPreferredSize(Adapter.MinSize(220, 80))

	local var_5_17 = CCControlButton:create("", _FONT_DEFAULT, Adapter.AutoPosY(30))

	var_5_17:setPosition(Adapter.AutoPos(643, 240))
	var_5_17:setPreferredSize(Adapter.MinSize(220, 80))
	var_5_17:setBackgroundSpriteForState(var_5_16, CCControlStateNormal)
	var_5_17:addHandleOfControlEvent(var_5_15, CCControlEventTouchUpInside)
	var_5_1:addChild(var_5_17)

	local function var_5_18()
		game.enterResetPasswordScene()
	end

	local var_5_19 = CCScale9Sprite:create("ui/account/btn_001.png")

	var_5_19:setPreferredSize(Adapter.MinSize(185, 80))

	local var_5_20 = CCScale9Sprite:create("ui/account/btn_002.png")

	var_5_20:setPreferredSize(Adapter.MinSize(185, 80))

	local var_5_21 = CCControlButton:create(string.lf("昵称登陆"), _FONT_DEFAULT, Adapter.AutoPosY(30))

	var_5_21:setPosition(Adapter.AutoPos(344, 87))
	var_5_21:setPreferredSize(Adapter.MinSize(185, 80))
	var_5_21:setBackgroundSpriteForState(var_5_19, CCControlStateNormal)
	var_5_21:setBackgroundSpriteForState(var_5_20, CCControlStateHighlighted)
	var_5_21:addHandleOfControlEvent(var_5_18, CCControlEventTouchUpInside)
	var_5_1:addChild(var_5_21)

	local function var_5_22()
		game.enterRegisterAccountScene()
	end

	local var_5_23 = CCScale9Sprite:create("uilocal/account/btn_reg.png")

	var_5_23:setPreferredSize(Adapter.MinSize(219, 80))

	local var_5_24 = CCControlButton:create("", _FONT_DEFAULT, Adapter.AutoPosY(30))

	var_5_24:setPosition(Adapter.AutoPos(807, 87))
	var_5_24:setPreferredSize(Adapter.MinSize(219, 80))
	var_5_24:setBackgroundSpriteForState(var_5_23, CCControlStateNormal)
	var_5_24:addHandleOfControlEvent(var_5_22, CCControlEventTouchUpInside)
	var_5_1:addChild(var_5_24)
end

function var_0_0.loginRequest(arg_11_0, arg_11_1, arg_11_2)
	if not matchEmailAddress(arg_11_1) then
		CCMessageBox(string.lf("帐号输入错误！"), string.lf("错误"))

		return
	end

	if not matchValidedString(arg_11_2) then
		CCMessageBox(string.lf("密码输入错误！"), string.lf("错误"))

		return
	end

	if arg_11_0.accountRequest:requestAccountLogin(arg_11_1, arg_11_2) then
		CCMessageBox(string.lf("帐号或密码输入错误！"), string.lf("错误"))
	end
end

return var_0_0
