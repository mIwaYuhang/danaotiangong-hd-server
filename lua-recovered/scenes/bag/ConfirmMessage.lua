local var_0_0 = class("ConfirmMessage", function()
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

	local var_2_3 = CCLabelTTF:create(string.lf("是否出售"), _FONT_DEFAULT, Adapter.FontSize(26))

	var_2_3:setPosition(display.cx - 70, display.cy + 50)
	arg_2_0:addChild(var_2_3)

	local var_2_4 = CCLabelTTF:create(arg_2_1.item .. " X" .. arg_2_1.count, _FONT_DEFAULT, Adapter.FontSize(26))

	var_2_4:setPosition(display.cx - 20, display.cy + 50)
	arg_2_0:addChild(var_2_4)
	var_2_4:setAnchorPoint(CCPoint(0, 0.5))
	var_2_4:setColor(arg_2_1.color)

	local var_2_5 = CCLabelTTF:create(string.lf("获得金币 %s", 1000 * arg_2_1.count), _FONT_DEFAULT, Adapter.FontSize(26))

	var_2_5:setPosition(display.cx, display.cy)
	arg_2_0:addChild(var_2_5)

	local var_2_6 = ui.newControlButton({
		normalImage = "ui/common/common_018.png",
		highlightedImage = "ui/common/common_018.png",
		text = string.lf("确定"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_5_0, arg_5_1)
			arg_2_1.clicked()
		end,
		position = CCPoint(display.cx, display.cy - 70 * Adapter.MinScale)
	})

	arg_2_0:addChild(var_2_6)
end

return var_0_0
