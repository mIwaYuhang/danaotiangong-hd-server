local var_0_0 = class("PackageOperationLayer", function()
	return CCLayerColor:create()
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.position = arg_2_1.position
	arg_2_0.size = arg_2_1.size
	arg_2_0.contentHandler = arg_2_1.contentHandler
	arg_2_0.buttons = arg_2_1.buttons or {
		{
			btnEnable = true,
			title = string.lf("确定"),
			handler = function()
				arg_2_0:removeFromParentAndCleanup()
			end
		}
	}
	arg_2_0.touchCallback = arg_2_1.touchCallback or nil
	arg_2_0.isSwallow = arg_2_1.isSwallow

	arg_2_0:setContentSize(arg_2_0.size)
	arg_2_0:setPosition(arg_2_0.position)

	local function var_2_0(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == "began" then
			return arg_2_0:onTouchBegan(arg_4_1, arg_4_2)
		elseif arg_4_0 == "moved" then
			arg_2_0:onTouchMoved(arg_4_1, arg_4_2)
		elseif arg_4_0 == "ended" or arg_4_0 == "cancelled" then
			arg_2_0:onTouchEnded(arg_4_1, arg_4_2)
		end
	end

	if arg_2_0.isSwallow == true then
		arg_2_0:addTouchEventListener(var_2_0, false, 1, true)
	else
		arg_2_0:addTouchEventListener(var_2_0, false, 2, false)
	end

	arg_2_0:setTouchEnabled(true)
	arg_2_0:initUI()
end

function var_0_0.initUI(arg_5_0)
	local var_5_0 = display.newScale9Sprite("ui/common/common_050_2.png", 0, 0, arg_5_0.size)

	arg_5_0:addChild(var_5_0)

	local var_5_1 = display.newNode()

	var_5_1:setScale(Adapter.MinScale)
	var_5_0:addChild(var_5_1)

	if arg_5_0.contentHandler ~= nil then
		arg_5_0.contentHandler(var_5_1)
	end

	local var_5_2 = -(#arg_5_0.buttons - 1) * arg_5_0.size.width / 2 * 0.5

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.buttons) do
		local var_5_3 = ui.newControlButton({
			normalImage = iter_5_1.buttonBg or "ui/common/common_018.png",
			disabledImage = iter_5_1.buttonDisableBg or "ui/common/common_018.png",
			position = ccp(5 + iter_5_0 * arg_5_0.size.width / 2 + var_5_2, 30),
			text = iter_5_1.title,
			fontSize = ColorTable.eTitleButton_FontSize,
			textColor = ColorTable.eTitleButton_Normal,
			clickAction = iter_5_1.handler,
			scaleX = Adapter.MinScale,
			scaleY = Adapter.MinScale
		})

		var_5_0:addChild(var_5_3)
		var_5_3:setEnabled(iter_5_1.btnEnable)
	end
end

function var_0_0.onTouchBegan(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.touchCallback ~= nil then
		arg_6_0.touchCallback()
	end

	return true
end

function var_0_0.onTouchMoved(arg_7_0, arg_7_1, arg_7_2)
	return
end

function var_0_0.onTouchEnded(arg_8_0, arg_8_1, arg_8_2)
	return
end

return var_0_0
