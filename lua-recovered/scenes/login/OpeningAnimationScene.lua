local var_0_0 = class("OpeningAnimationScene", function()
	return display.newScene("OpeningAnimationScene")
end)
local var_0_1 = 1
local var_0_2 = {
	"piantou1",
	"piantou2(1)",
	"piantou2(2)",
	"piantou3",
	"piantou4",
	"piantou5"
}
local var_0_3 = false

function var_0_0.ctor(arg_2_0, arg_2_1)
	var_0_1 = 1
	var_0_3 = false
	arg_2_0.params = arg_2_1

	arg_2_0:animation()

	local var_2_0

	local function var_2_1(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			var_0_3 = not var_0_3

			var_2_0:setVisible(var_0_3)
		end
	end

	arg_2_0.maskLayer = CCLayer:create()

	arg_2_0.maskLayer:addTouchEventListener(var_2_1, false, 1, false)
	arg_2_0.maskLayer:setTouchEnabled(true)
	arg_2_0:addChild(arg_2_0.maskLayer)

	var_2_0 = ui.newControlButton({
		normalImage = "uilocal/battle/battle_text_167.png",
		clickAction = function(arg_4_0, arg_4_1)
			arg_2_0:finish()
		end,
		scaleX = Adapter.MinScale,
		scaleY = Adapter.MinScale,
		position = ccp(850 * Adapter.AutoScaleX, display.height - 50 * Adapter.AutoScaleY)
	})

	arg_2_0:addChild(var_2_0, 2)
	var_2_0:setVisible(var_0_3)

	local var_2_2 = CCSprite:create("filmAni/jintoukuang.png")

	arg_2_0:addChild(var_2_2, 1)
	var_2_2:setScale(Adapter.MinScale)
	var_2_2:setPosition(display.cx, display.cy)
end

function var_0_0.animation(arg_5_0, ...)
	if var_0_1 <= table.nums(var_0_2) then
		local var_5_0

		var_5_0 = arg_5_0:playFilm(var_0_2[var_0_1], {
			function(...)
				var_5_0:removeFromParentAndCleanup(true)

				var_0_1 = var_0_1 + 1

				arg_5_0:animation()
			end,
			1,
			AAT_Percent
		})

		var_5_0:setScale(Adapter.MinScale)
	else
		arg_5_0:finish()
	end
end

function var_0_0.finish(arg_7_0, ...)
	if arg_7_0.params.callback then
		arg_7_0.params.callback()
	end
end

function var_0_0.playFilm(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = CCSkeletonAnimation:createWithFile("filmAni/" .. arg_8_1 .. ".json", "filmAni/" .. arg_8_1 .. ".atlas", 1)

	var_8_0:setToSetupPose()
	var_8_0:setAnimation("animation", false, 0)

	if arg_8_2 then
		for iter_8_0 = 1, table.getn(arg_8_2), 3 do
			var_8_0:addAnimationAction("animation", arg_8_2[iter_8_0 + 1], CCCallFunc:create(arg_8_2[iter_8_0]), arg_8_2[iter_8_0 + 2])
		end
	end

	var_8_0:setPosition(display.cx, display.cy)
	arg_8_0:addChild(var_8_0)

	return var_8_0
end

return var_0_0
