local var_0_0 = class("MultipleChoiceLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	local function var_2_0(arg_3_0, arg_3_1, arg_3_2)
		return true
	end

	arg_2_0:addTouchEventListener(var_2_0, false, 0, true)
	arg_2_0:setTouchEnabled(true)
	arg_2_0:setOpacity(128)

	local var_2_1 = CCSprite:create("ui/common/common_050.png")

	var_2_1:setPosition(display.cx, display.cy)
	arg_2_0:addChild(var_2_1)

	local var_2_2 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		highlightedImage = "ui/common/btn_closed.png",
		clickAction = function(arg_4_0, arg_4_1)
			arg_2_0:removeFromParentAndCleanup(true)
		end,
		position = Adapter.AutoPos(600, 440)
	})

	arg_2_0:addChild(var_2_2)

	local var_2_3 = CCLabelTTF:create(arg_2_1.title, _FONT_DEFAULT, Adapter.FontSize(26))

	var_2_3:setPosition(display.cx, display.cy + 75 * Adapter.MinScale)
	arg_2_0:addChild(var_2_3)

	local var_2_4 = CCLabelTTF:create(arg_2_1.name, _FONT_DEFAULT, Adapter.FontSize(26))

	var_2_4:setPosition(display.cx + 20 * Adapter.MinScale, display.cy + 30 * Adapter.MinScale)

	if arg_2_1.color then
		var_2_4:setColor(arg_2_1.color)
	end

	var_2_4:setAnchorPoint(CCPoint(1, 0.5))
	arg_2_0:addChild(var_2_4)

	local var_2_5 = CCLabelTTF:create("X" .. arg_2_1.min, _FONT_DEFAULT, Adapter.FontSize(26))

	var_2_5:setPosition(display.cx + 40 * Adapter.MinScale, display.cy + 30 * Adapter.MinScale)
	arg_2_0:addChild(var_2_5)
	var_2_5:setAnchorPoint(CCPoint(0, 0.5))

	local var_2_6 = CCControlSlider:create("ui/common/bar_common_hp.png", "ui/common/bar_common_exp.png", "ui/common/common_042.png")

	var_2_6:setMinimumValue(arg_2_1.min)
	var_2_6:setMaximumValue(arg_2_1.max)
	var_2_6:setPosition(display.cx, display.cy - 20 * Adapter.MinScale)
	arg_2_0:addChild(var_2_6)
	var_2_6:addHandleOfControlEvent(function(arg_5_0, arg_5_1)
		var_2_5:setString("X" .. math.ceil(var_2_6:getValue()))
	end, CCControlEventValueChanged)

	local var_2_7 = ui.newControlButton({
		normalImage = "ui/common/common_018.png",
		highlightedImage = "ui/common/common_018.png",
		text = arg_2_1.btnName,
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_6_0, arg_6_1)
			arg_2_1.clicked(math.ceil(var_2_6:getValue()))
		end,
		position = CCPoint(display.cx, display.cy - 70 * Adapter.MinScale)
	})

	arg_2_0:addChild(var_2_7)
end

return var_0_0
