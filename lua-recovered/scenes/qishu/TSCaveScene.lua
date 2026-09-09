local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = class("TSCaveScene", function()
	return display.newScene("TSCaveScene")
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	return
end

function var_0_1.onEnter(arg_3_0)
	local var_3_0 = Adapter.AutoScaleY
	local var_3_1 = display.newSprite("ui/tianshuqishu/tianshu_007.jpg")
	local var_3_2 = var_3_1:getContentSize()

	var_3_1:setScale(var_3_0)
	var_3_1:setPosition(display.cx, display.cy)
	arg_3_0:addChild(var_3_1)

	local var_3_3 = math.min(var_3_2.width * var_3_0, display.width) / var_3_0
	local var_3_4 = math.min(var_3_2.height * var_3_0, display.height) / var_3_0
	local var_3_5 = CCSize(var_3_3, var_3_4)
	local var_3_6 = CCNode:create()

	var_3_6:setContentSize(var_3_5)
	var_3_6:setAnchorPoint(ccp(0.5, 0.5))
	var_3_6:setPosition(var_3_2.width / 2, var_3_2.height / 2)
	var_3_1:addChild(var_3_6)

	arg_3_0.container = var_3_6

	local var_3_7 = var_0_0.newLabel({
		size = 20,
		text = string.lf("天书记载许多修仙决胜的#DA9B1F奇术法门#D1CF8F，是我冒犯天条盗来，藏于此洞，你我有缘，定要多加习练，切记：#DA9B1F提升阅历#D1CF8F是修炼的要诀！"),
		font = _FONT_DEFAULT,
		color = ccc3(209, 207, 143),
		dimensions = CCSize(420, 135)
	})

	var_3_7:setPosition(500 - (var_3_2.width - var_3_3) / (2 * var_3_0), 485)
	var_3_6:addChild(var_3_7)

	local var_3_8 = ui.newControlButton({
		normalImage = "ui/tianshuqishu/tianshu_008.png",
		clickAction = function(arg_4_0, arg_4_1)
			arg_3_0:createAnimation("popup", arg_4_1, function()
				game.enterQiShuScene()
			end)
		end
	})

	var_3_8:setPosition(var_3_5.width / 2, var_3_5.height / 2 + 10)
	var_3_6:addChild(var_3_8)
	arg_3_0:createAnimation("float", var_3_8, function()
		return
	end)

	local function var_3_9()
		arg_3_0:createAnimation("popup", var_3_8, function()
			print("popup called")
			game.enterQiShuScene()
		end)
	end

	local var_3_10 = CCDelayTime:create(0.2)
	local var_3_11 = CCArray:create()

	var_3_11:addObject(var_3_10)
	var_3_11:addObject(CCCallFunc:create(var_3_9))

	local var_3_12 = CCSequence:create(var_3_11)

	arg_3_0:runAction(var_3_12)
end

function var_0_1.createAnimation(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0

	print("createAnimation name:", arg_9_1)

	if arg_9_1 == "float" then
		local var_9_1 = CCArray:create()
		local var_9_2 = CCMoveBy:create(0.8, ccp(0, 15))
		local var_9_3 = CCMoveBy:create(0.8, ccp(0, -15))

		var_9_1:addObject(var_9_2)
		var_9_1:addObject(var_9_3)

		local var_9_4 = CCSequence:create(var_9_1)

		var_9_0 = CCRepeat:create(var_9_4, 2)
	elseif arg_9_1 == "popup" then
		local var_9_5 = 1
		local var_9_6 = CCArray:create()
		local var_9_7 = CCRotateBy:create(var_9_5, 360)
		local var_9_8 = CCScaleBy:create(var_9_5 - 0.2, 4)
		local var_9_9 = CCFadeOut:create(var_9_5)

		var_9_6:addObject(var_9_7)
		var_9_6:addObject(var_9_8)
		var_9_6:addObject(var_9_9)

		local var_9_10 = CCSpawn:create(var_9_6)

		if arg_9_3 then
			local var_9_11 = CCArray:create()

			var_9_11:addObject(var_9_10)
			var_9_11:addObject(CCCallFunc:create(arg_9_3))

			var_9_0 = CCSequence:create(var_9_11)
		else
			var_9_0 = var_9_10
		end
	end

	arg_9_2:stopAllActions()
	arg_9_2:runAction(var_9_0)
end

return var_0_1
