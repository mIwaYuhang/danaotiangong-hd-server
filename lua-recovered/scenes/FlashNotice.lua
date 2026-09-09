local var_0_0 = class("FlashNoticeLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if arg_2_1 == nil then
		arg_2_1 = ""
	end

	arg_2_2 = arg_2_2 or CCPoint(display.cx, display.cy)
	arg_2_3 = arg_2_3 or ccp(display.cx, display.cy + 100)
	arg_2_0.flashEndpos = arg_2_3

	local var_2_0 = Adapter.AutoSize(530, 55)

	arg_2_0.bgSprite = display.newScale9Sprite("ui/common/common_064_2.png", arg_2_2.x, arg_2_2.y, var_2_0)

	arg_2_0:addChild(arg_2_0.bgSprite)

	local var_2_1 = ui.newTTFLabel({
		text = arg_2_1,
		size = Adapter.FontSize(26),
		x = var_2_0.width / 2,
		y = var_2_0.height / 2 + 5,
		dimensions = var_2_0,
		align = ui.TEXT_ALIGN_CENTER,
		valign = ui.TEXT_VALIGN_CENTER
	})

	var_2_1:setAnchorPoint(ccp(0.5, 0.5))
	arg_2_0.bgSprite:addChild(var_2_1)

	local var_2_2 = arg_2_4 or 0.3
	local var_2_3 = CCMoveTo:create(0.25, arg_2_0.flashEndpos)
	local var_2_4 = CCDelayTime:create(var_2_2)
	local var_2_5 = CCFadeOut:create(1)
	local var_2_6 = CCArray:create()

	var_2_6:addObject(var_2_3)
	var_2_6:addObject(var_2_4)
	var_2_6:addObject(var_2_5)
	var_2_6:addObject(CCCallFunc:create(function()
		arg_2_0:removeFromParentAndCleanup(true)
	end))

	local var_2_7 = CCSequence:create(var_2_6)

	arg_2_0.bgSprite:runAction(var_2_7)
end

function var_0_0.onExit(arg_4_0)
	print("FlashNoticeLayer:onExit")
end

function var_0_0.onEnter(arg_5_0)
	print("FlashNoticeLayer:onEnter")
end

return var_0_0
