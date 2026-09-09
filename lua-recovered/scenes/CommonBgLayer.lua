local var_0_0 = class("CommonBgLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0._isHideBgSprite = arg_2_1.isHideBgSprite

	if arg_2_0._isHideBgSprite == nil then
		arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
			if arg_3_0 == "began" then
				return true
			end
		end, false, 1, true)
		arg_2_0:setTouchEnabled(true)

		local var_2_0 = display.newSprite("ui/home/home_057.jpg")

		var_2_0:setPosition(display.cx, display.cy)
		var_2_0:setScale(Adapter.AutoScaleY)
		arg_2_0:addChild(var_2_0)

		local var_2_1 = CCLayerColor:create(ccc4(0, 0, 0, 200))

		arg_2_0:addChild(var_2_1)
	end

	local var_2_2 = arg_2_1.bgSprite or "ui/common/common_040.png"

	arg_2_0.bgSprite = display.newSprite(var_2_2)

	arg_2_0.bgSprite:setPosition(display.cx, display.cy)
	arg_2_0.bgSprite:setScale(Adapter.MinScale)
	arg_2_0:addChild(arg_2_0.bgSprite)

	if arg_2_0._isHideBgSprite ~= nil then
		arg_2_0.bgSprite:setOpacity(0)
	end

	local function var_2_3()
		game.enterHomeScene()
	end

	local var_2_4 = ui.newControlButton({
		normalImage = arg_2_1.closeButtonNormalImage or "ui/common/btn_closed.png",
		position = arg_2_1.closeButtonPosition or ccp(CONFIG_SCREEN_WIDTH - 40, CONFIG_SCREEN_HEIGHT - 34),
		clickAction = arg_2_1.returnAction or var_2_3
	})

	var_2_4:setTouchPriority(-1)
	arg_2_0.bgSprite:addChild(var_2_4, 77)

	if arg_2_1.titleSprite then
		local var_2_5 = display.newSprite(arg_2_1.titleSprite)

		var_2_5:align(display.LEFT_CENTER, 35, CONFIG_SCREEN_HEIGHT - 35)
		arg_2_0.bgSprite:addChild(var_2_5)
	end
end

function var_0_0.getBackgroundSprite(arg_5_0)
	return arg_5_0.bgSprite
end

return var_0_0
