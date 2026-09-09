RepeatDirection = {
	eHorizontal = 2,
	eVertical = 1
}

local var_0_0 = class("RepeatLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0._size = arg_2_1.size
	arg_2_0._position = arg_2_1.position
	arg_2_0._conentHandler = arg_2_1.conentHandler
	arg_2_0.clipScaleX = arg_2_1.clipScaleX or 1
	arg_2_0.clipScaleY = arg_2_1.clipScaleY or 1
	arg_2_0._curLayerIndex = arg_2_1.curLayerIndex or 1
	arg_2_0._repeatDirection = arg_2_1.repeatDirection or RepeatDirection.eVertical
	arg_2_0._currentOffset = arg_2_1.currentOffset or 0
	arg_2_0.clipper = CCClippingRegionNode:create(CCRect(1, 0, arg_2_0._size.width * arg_2_0.clipScaleX, arg_2_0._size.height * arg_2_0.clipScaleY))

	arg_2_0.clipper:setPosition(0, 0)
	arg_2_0:addChild(arg_2_0.clipper)

	arg_2_0.curLayer = CCLayerColor:create(ccc4(255, 120, 255, 0), arg_2_0._size.width, arg_2_0._size.height)

	arg_2_0.clipper:addChild(arg_2_0.curLayer)

	arg_2_0.nextLayer = CCLayerColor:create(ccc4(120, 120, 255, 0), arg_2_0._size.width, arg_2_0._size.height)

	arg_2_0.clipper:addChild(arg_2_0.nextLayer)
	arg_2_0:setPosition(arg_2_0._position)
	arg_2_0:resetRepeatLayerOffset(true, true)
end

function var_0_0.resetRepeatLayerOffset(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = 0
	local var_3_1 = 0
	local var_3_2 = 0
	local var_3_3 = 0

	if arg_3_0._repeatDirection == RepeatDirection.eVertical then
		var_3_1 = arg_3_0._currentOffset
		var_3_3 = arg_3_0._size.height + arg_3_0._currentOffset
	else
		var_3_0 = arg_3_0._currentOffset
		var_3_2 = arg_3_0._size.width + arg_3_0._currentOffset
	end

	if arg_3_1 == true then
		arg_3_0.curLayer:removeAllChildrenWithCleanup(true)
		arg_3_0._conentHandler(arg_3_0.curLayer, arg_3_0._curLayerIndex)
	end

	if arg_3_2 == true then
		arg_3_0.nextLayer:removeAllChildrenWithCleanup(true)
		arg_3_0._conentHandler(arg_3_0.nextLayer, arg_3_0._curLayerIndex + 1)
	end

	arg_3_0.curLayer:setPosition(CCPoint(var_3_0, var_3_1))
	arg_3_0.nextLayer:setPosition(CCPoint(var_3_2, var_3_3))
end

function var_0_0.setLayerOffset(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = 0
	local var_4_1 = 0

	if arg_4_0._repeatDirection == RepeatDirection.eVertical then
		var_4_0 = arg_4_2
		var_4_1 = arg_4_0._size.height
	else
		var_4_0 = arg_4_1
		var_4_1 = arg_4_0._size.width
	end

	if var_4_1 <= var_4_0 then
		var_4_0 = var_4_0 - var_4_1
	elseif var_4_0 < -var_4_1 then
		var_4_0 = var_4_0 + var_4_1
	end

	local var_4_2 = 0
	local var_4_3 = arg_4_0._currentOffset + var_4_0
	local var_4_4 = false
	local var_4_5 = false

	if var_4_3 >= 0 then
		var_4_3 = var_4_3 - var_4_1
		var_4_2 = -1
		var_4_4 = true
	elseif var_4_3 < -var_4_1 then
		var_4_3 = var_4_3 + var_4_1
		var_4_2 = 1
		var_4_5 = true
	end

	if arg_4_0._curLayerIndex + var_4_2 < 1 then
		arg_4_0._currentOffset = 0

		arg_4_0:resetRepeatLayerOffset(false, false)

		return
	end

	arg_4_0._currentOffset = var_4_3

	if var_4_2 ~= 0 then
		arg_4_0._curLayerIndex = arg_4_0._curLayerIndex + var_4_2
		arg_4_0.curLayer, arg_4_0.nextLayer = arg_4_0.nextLayer, arg_4_0.curLayer

		arg_4_0:resetRepeatLayerOffset(var_4_4, var_4_5)
	else
		arg_4_0:resetRepeatLayerOffset(false, false)
	end
end

function var_0_0.setIndexAndOffset(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._curLayerIndex = arg_5_1
	arg_5_0._currentOffset = arg_5_2
end

function var_0_0.reloadLayer(arg_6_0)
	arg_6_0:resetRepeatLayerOffset(true, true)
end

return var_0_0
