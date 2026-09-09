local var_0_0 = class("WorldBossBattleResultLayer", function()
	return display.newColorLayer(ccc4(0, 0, 0, 180))
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	if arg_2_1.result == true then
		arg_2_0:successUI(arg_2_1)
	else
		arg_2_0:failedUI(arg_2_1)
	end

	local var_2_0 = arg_2_0:createLabel(arg_2_1)

	var_2_0:setPosition(arg_2_0.mBgSize.width / 2, 130)
	arg_2_0.mBgSprite:addChild(var_2_0)

	local var_2_1 = ui.newControlButton({
		normalImage = "ui/common/common_018.png",
		text = string.lf("确定"),
		position = ccp(arg_2_0.mBgSize.width / 2, 60),
		clickAction = function(arg_4_0, arg_4_1)
			game.enterWorldBossBattleScene()
		end
	})

	arg_2_0.mBgSprite:addChild(var_2_1)
end

function var_0_0.successUI(arg_5_0, arg_5_1)
	local var_5_0 = display.newSprite("ui/battle/battle_038.png", display.cx, 180 * Adapter.MinScale)

	var_5_0:setAnchorPoint(ccp(0.5, 0))
	var_5_0:setScale(Adapter.MinScale)
	arg_5_0:addChild(var_5_0)

	local var_5_1 = display.newSprite("uilocal/battle/battle_text_001.png")

	var_5_1:align(display.CENTER_BOTTOM, 480, 260)
	var_5_0:addChild(var_5_1)

	arg_5_0.mBgSprite = var_5_0
	arg_5_0.mBgSize = arg_5_0.mBgSprite:getContentSize()
end

function var_0_0.failedUI(arg_6_0, arg_6_1)
	arg_6_0.mBgSize = CCSize(380, 300)

	local var_6_0 = display.newScale9Sprite("ui/common/common_050.png", display.cx, display.cy, Adapter.MinSize(arg_6_0.mBgSize.width, arg_6_0.mBgSize.height))

	arg_6_0:addChild(var_6_0)

	arg_6_0.mBgSprite = display.newNode()

	arg_6_0.mBgSprite:setAnchorPoint(ccp(0.5, 0.5))
	arg_6_0.mBgSprite:setPosition(display.cx, display.cy)
	arg_6_0.mBgSprite:setContentSize(arg_6_0.mBgSize)
	arg_6_0.mBgSprite:setScale(Adapter.MinScale)
	arg_6_0:addChild(arg_6_0.mBgSprite)
end

function var_0_0.createLabel(arg_7_0, arg_7_1)
	local var_7_0 = display.newNode()
	local var_7_1 = arg_7_1.data.WorldbossChallenge.challengeGold
	local var_7_2 = arg_7_1.data.WorldbossChallenge.hp
	local var_7_3 = ""

	if arg_7_1.result == true then
		var_7_3 = string.lf("上仙，恭喜您击杀一只妖王!")
	else
		var_7_3 = string.lf("上仙，妖王太强大了，继续加油哦!")
	end

	local var_7_4 = addLabelWithColorSize(var_7_0, var_7_3, ccc3(255, 255, 255), 20, ccp(0, 0.5), ccp(0, 100))

	addLabelWithColorSize(var_7_0, string.lf("造成伤害: %d", var_7_2), ccc3(255, 255, 255), 20, ccp(0, 0.5), ccp(0, 40))
	addLabelWithColorSize(var_7_0, string.lf("获得银币: %d", var_7_1), ccc3(255, 255, 255), 20, ccp(0, 0.5), ccp(0, 0))
	var_7_0:setContentSize(CCSizeMake(var_7_4:getContentSize().width / Adapter.MinScale, 100))
	var_7_0:setAnchorPoint(ccp(0.5, 0))

	return var_7_0
end

return var_0_0
