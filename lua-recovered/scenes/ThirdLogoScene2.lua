local var_0_0 = class("ThirdLogoScene2", function()
	return display.newScene("ThirdLogoScene2")
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	local var_2_0 = CCLayerColor:create(ccc4(255, 255, 255, 255))

	arg_2_0:addChild(var_2_0)

	local var_2_1 = display.newSprite(arg_2_1.thirdLogo, display.cx, display.cy)

	var_2_1:setScaleX(Adapter.AutoScaleX)
	var_2_1:setScaleY(Adapter.AutoScaleY)
	arg_2_0:addChild(var_2_1)

	local function var_2_2()
		game.restartGameEntry(false)
	end

	local var_2_3 = CCArray:create()

	var_2_3:addObject(CCDelayTime:create(1.5))
	var_2_3:addObject(CCCallFunc:create(var_2_2))
	var_2_1:runAction(CCSequence:create(var_2_3))
end

return var_0_0
