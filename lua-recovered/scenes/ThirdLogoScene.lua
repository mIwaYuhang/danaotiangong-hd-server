local var_0_0 = class("ThirdLogoScene", function()
	return display.newScene("ThirdLogoScene")
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	local var_2_0 = CCLayerColor:create(ccc4(255, 255, 255, 255))

	arg_2_0:addChild(var_2_0)

	local var_2_1 = display.newSprite(arg_2_1.thirdLogo, display.cx, display.cy)

	var_2_1:setScaleX(Adapter.AutoScaleX)
	var_2_1:setScaleY(Adapter.AutoScaleY)
	arg_2_0:addChild(var_2_1)

	local function var_2_2()
		local var_3_0 = IPlatform:instance():getConfig("ThridLogo2")

		if var_3_0 ~= "" then
			local var_3_1 = CCFileUtils:sharedFileUtils():fullPathForFilename(var_3_0)

			if io.exists(var_3_1) then
				game.enterThirdLogoScene2({
					thirdLogo = var_3_0
				})

				return
			end
		else
			if tonumber(EditionConfig.__Version) > 204 and device.platform == "android" then
				IPlatform:instance():init()
			end

			game.restartGameEntry(false)
		end
	end

	local var_2_3 = CCArray:create()

	var_2_3:addObject(CCDelayTime:create(1.5))
	var_2_3:addObject(CCCallFunc:create(var_2_2))
	var_2_1:runAction(CCSequence:create(var_2_3))
end

return var_0_0
