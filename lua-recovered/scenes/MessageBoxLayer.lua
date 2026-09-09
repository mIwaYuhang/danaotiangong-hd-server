local var_0_0 = class("MessageBoxLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

function var_0_0.backTouchUpInsideAction(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0.slide then
		arg_2_0:slidelayer()
	else
		arg_2_0:removeFromParent()
	end
end

function var_0_0.ctor(arg_3_0, arg_3_1)
	arg_3_1 = arg_3_1 or {}

	local function var_3_0(arg_4_0, arg_4_1, arg_4_2)
		return true
	end

	arg_3_0:addTouchEventListener(var_3_0, false, -128, true)
	arg_3_0:setTouchEnabled(true)
	arg_3_0:setColor(display.COLOR_BLACK)
	arg_3_0:setOpacity(191.25)

	local var_3_1
	local var_3_2 = arg_3_1.type or "guide"
	local var_3_3 = {
		text = "",
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(26),
		dimensions = CCSize(420, 120),
		align = ui.TEXT_ALIGN_LEFT,
		valign = ui.TEXT_VALIGN_TOP
	}
	local var_3_4 = ui.newTTFLabel(var_3_3)

	if var_3_2 == "guide" then
		var_3_1 = display.newSprite("ui/common/common_114.png")
		arg_3_0.buttonBg = "ui/common/common_115.png"
		arg_3_0.buttonOff = 0

		var_3_4:setAnchorPoint(ccp(0, 0))
		var_3_4:setPosition(280, 60)
	elseif var_3_2 == "dialog" then
		local var_3_5 = CCSize(500, 280)

		var_3_1 = display.newScale9Sprite("ui/common/common_050.png")

		var_3_1:setPreferredSize(var_3_5)

		arg_3_0.buttonBg = "ui/common/common_018.png"
		arg_3_0.buttonOff = -220

		local var_3_6 = display.newSprite("ui/common/common_064_2.png")
		local var_3_7 = var_3_6:getContentSize()

		var_3_6:setPosition(var_3_5.width / 2, var_3_5.height - 10)
		var_3_1:addChild(var_3_6)

		local var_3_8 = display.newSprite("uilocal/common/common_text_006.png")

		var_3_8:setPosition(var_3_7.width / 2, var_3_7.height / 2 + 5)
		var_3_6:addChild(var_3_8)
		var_3_4:setPosition(var_3_5.width / 2, var_3_5.height / 2)
	end

	var_3_1:setScale(Adapter.MinScale)
	var_3_1:setPosition(display.cx, display.cy)
	arg_3_0:addChild(var_3_1)

	arg_3_0.bgSprite = var_3_1

	Adapter.NodeAbsScale(var_3_4)
	var_3_1:addChild(var_3_4)

	arg_3_0.msgLabel = var_3_4

	if arg_3_1.animate == "slide" then
		arg_3_0.slide = true

		arg_3_0:slidelayer(true)
	elseif arg_3_1.slide then
		arg_3_0.slide = true

		arg_3_0:slidelayer(true)
	end
end

function var_0_0.setContentAndButtons(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	arg_5_0.msgLabel:setString(arg_5_1)

	local var_5_0 = {}

	if arg_5_2 then
		var_5_0[1] = {
			title = arg_5_2,
			func = arg_5_3
		}

		if arg_5_4 then
			var_5_0[2] = {
				title = arg_5_4,
				func = arg_5_5
			}
		end

		for iter_5_0 = 1, table.getn(var_5_0) do
			local var_5_1 = ui.newControlButton({
				fontSize = 28,
				normalImage = arg_5_0.buttonBg,
				text = var_5_0[iter_5_0].title,
				textColor = ColorTable.eTitleButton_Normal,
				clickAction = handler(arg_5_0, arg_5_0.backTouchUpInsideAction)
			})

			if table.getn(var_5_0) == 1 then
				var_5_1:setPosition(ccp(480 + arg_5_0.buttonOff, 50))
			else
				var_5_1:setPosition(ccp((iter_5_0 - 1) * 230 + 365 + arg_5_0.buttonOff, 50))
			end

			local var_5_2 = var_5_0[iter_5_0].func

			if var_5_2 then
				var_5_1:addHandleOfControlEvent(function(arg_6_0, arg_6_1)
					arg_5_0:backTouchUpInsideAction(arg_6_0, arg_6_1)
					var_5_2(arg_6_0, arg_6_1)
				end, CCControlEventTouchUpInside)
			else
				var_5_1:addHandleOfControlEvent(handler(arg_5_0, arg_5_0.backTouchUpInsideAction), CCControlEventTouchUpInside)
			end

			arg_5_0.bgSprite:addChild(var_5_1)
		end
	else
		print("MessageBoxLayer:setButtons 缺少第一个参数！！！")
	end
end

function var_0_0.slidelayer(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.bgSprite
	local var_7_1 = var_7_0:getContentSize()

	if arg_7_1 then
		local var_7_2 = CCMoveTo:create(0.4, ccp(display.cx, display.cy))
		local var_7_3 = CCEaseSineOut:create(var_7_2)

		var_7_0:setPosition(display.cx, display.height + var_7_1.height / 2)
		var_7_0:runAction(var_7_3)
	else
		local var_7_4 = CCArray:create()

		var_7_4:addObject(CCMoveTo:create(0.4, ccp(display.cx, display.height + var_7_1.height / 2)))
		var_7_4:addObject(CCCallFunc:create(function()
			arg_7_0:removeFromParent()
		end))

		local var_7_5 = CCEaseSineOut:create(CCSequence:create(var_7_4))

		var_7_0:runAction(var_7_5)
	end
end

return var_0_0
