local var_0_0 = class("CircleLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.config = {}
	arg_2_0.config._longAxias = arg_2_1.longAxias
	arg_2_0.config._totalItemNum = arg_2_1.totalItemNum
	arg_2_0.config._itemContentCallback = arg_2_1.itemContentCallback
	arg_2_0.config._shortAxias = arg_2_1.shortAxias or arg_2_1.longAxias
	arg_2_0.config._unlockItemNum = arg_2_1.unlockItemNum or arg_2_0._totalItemNum
	arg_2_0.config._alignCallback = arg_2_1.alignCallback or nil
	arg_2_0.config._rotateLayerCallback = arg_2_1.rotateLayerCallback or nil
	arg_2_0.config._noneRotateLayerCallback = arg_2_1.noneRotateLayerCallback or nil
	arg_2_0.config._eachItemAngle = 360 / arg_2_0.config._totalItemNum
	arg_2_0._itemNodes = {}
	arg_2_0._previousIndex = nil

	arg_2_0:initUI()
	arg_2_0:moveToIndexItem(1, false)
end

function var_0_0.getItemPosition(arg_3_0, arg_3_1)
	local var_3_0 = (arg_3_0.config._totalItemNum - arg_3_1 + 1) * arg_3_0.config._eachItemAngle % 360 * 3.1415 / 180
	local var_3_1 = math.cos(var_3_0) * arg_3_0.config._longAxias + arg_3_0.config._longAxias
	local var_3_2 = math.sin(var_3_0) * arg_3_0.config._shortAxias + arg_3_0.config._shortAxias

	return var_3_1, var_3_2
end

function var_0_0.getItemAngle(arg_4_0, arg_4_1)
	return (arg_4_0.config._totalItemNum - arg_4_1 + 1) * arg_4_0.config._eachItemAngle % 360
end

function var_0_0.getItemIndexFromAngle(arg_5_0, arg_5_1)
	local var_5_0 = math.floor(arg_5_1 / arg_5_0.config._eachItemAngle + 0.5)
	local var_5_1 = arg_5_0.config._totalItemNum - var_5_0

	return (arg_5_0.config._totalItemNum + var_5_1) % arg_5_0.config._totalItemNum + 1
end

function var_0_0.initUI(arg_6_0)
	if arg_6_0.config._noneRotateLayerCallback ~= nil then
		arg_6_0.config._noneRotateLayerCallback(arg_6_0)
	end

	arg_6_0._rotateLayer = display.newNode()

	arg_6_0._rotateLayer:setContentSize(CCSize(arg_6_0.config._longAxias * 2, arg_6_0.config._shortAxias * 2))
	arg_6_0._rotateLayer:setAnchorPoint(ccp(0.5, 0.5))
	arg_6_0:addChild(arg_6_0._rotateLayer)

	if arg_6_0.config._rotateLayerCallback ~= nil then
		arg_6_0.config._rotateLayerCallback(arg_6_0._rotateLayer)
	end

	for iter_6_0 = 1, arg_6_0.config._totalItemNum do
		local var_6_0, var_6_1 = arg_6_0:getItemPosition(iter_6_0)
		local var_6_2 = display.newNode()

		var_6_2:setPosition(ccp(var_6_0, var_6_1))
		arg_6_0._rotateLayer:addChild(var_6_2)
		var_6_2:setRotation(arg_6_0.config._eachItemAngle * (iter_6_0 - 1) + 90)

		arg_6_0._itemNodes[iter_6_0] = var_6_2

		arg_6_0.config._itemContentCallback(var_6_2, iter_6_0)
	end
end

function var_0_0.getOriginIndex(arg_7_0, arg_7_1)
	arg_7_1 = (arg_7_1 + 2 + arg_7_0.config._totalItemNum) % arg_7_0.config._totalItemNum + 1

	return arg_7_1
end

function var_0_0.getFixedIndex(arg_8_0, arg_8_1)
	return (arg_8_1 - 4 + arg_8_0.config._totalItemNum) % arg_8_0.config._totalItemNum + 1
end

function var_0_0.getPreviousItemIndex(arg_9_0, arg_9_1)
	arg_9_1 = arg_9_1 - 1

	if arg_9_1 < 1 then
		arg_9_1 = arg_9_0.config._totalItemNum
	end

	return arg_9_1
end

function var_0_0.getNextItemIndex(arg_10_0, arg_10_1)
	arg_10_1 = arg_10_1 + 1

	if arg_10_1 > arg_10_0.config._totalItemNum then
		arg_10_1 = 1
	end

	return arg_10_1
end

function var_0_0.moveToPreviousItem(arg_11_0)
	local var_11_0 = arg_11_0._rotateLayer:getRotation()
	local var_11_1 = arg_11_0:getItemIndexFromAngle(var_11_0)
	local var_11_2 = arg_11_0:getPreviousItemIndex(var_11_1)

	arg_11_0._previousIndex = arg_11_0:getFixedIndex(var_11_1)

	if arg_11_0:getFixedIndex(var_11_2) > arg_11_0.config._unlockItemNum then
		var_11_2 = var_11_1
	end

	local var_11_3 = arg_11_0:getItemAngle(var_11_2)
	local var_11_4 = CCArray:create()

	var_11_4:addObject(CCRotateTo:create(0.2, var_11_3))
	var_11_4:addObject(CCCallFunc:create(handler(arg_11_0, arg_11_0.alignCallback)))
	arg_11_0._rotateLayer:runAction(CCSequence:create(var_11_4))
end

function var_0_0.moveToNextItem(arg_12_0)
	local var_12_0 = arg_12_0._rotateLayer:getRotation()
	local var_12_1 = arg_12_0:getItemIndexFromAngle(var_12_0)
	local var_12_2 = arg_12_0:getNextItemIndex(var_12_1)

	arg_12_0._previousIndex = arg_12_0:getFixedIndex(var_12_1)

	if arg_12_0:getFixedIndex(var_12_2) > arg_12_0.config._unlockItemNum then
		var_12_2 = var_12_1
	end

	local var_12_3 = arg_12_0:getItemAngle(var_12_2)
	local var_12_4 = CCArray:create()

	var_12_4:addObject(CCRotateTo:create(0.2, var_12_3))
	var_12_4:addObject(CCCallFunc:create(handler(arg_12_0, arg_12_0.alignCallback)))
	arg_12_0._rotateLayer:runAction(CCSequence:create(var_12_4))
end

function var_0_0.moveToIndexItem(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 > arg_13_0.config._unlockItemNum then
		return
	end

	local var_13_0 = arg_13_0._rotateLayer:getRotation()
	local var_13_1 = arg_13_0:getItemIndexFromAngle(var_13_0)

	arg_13_0._previousIndex = arg_13_0:getFixedIndex(var_13_1)

	local var_13_2 = arg_13_0:getOriginIndex(arg_13_1)
	local var_13_3 = arg_13_0:getItemAngle(var_13_2)
	local var_13_4 = 0

	if arg_13_2 == true then
		var_13_4 = 0.2
	else
		arg_13_0._rotateLayer:setRotation(var_13_3)

		return
	end

	local var_13_5 = CCArray:create()

	var_13_5:addObject(CCRotateTo:create(var_13_4, var_13_3))
	var_13_5:addObject(CCCallFunc:create(handler(arg_13_0, arg_13_0.alignCallback)))
	arg_13_0._rotateLayer:stopAllActions()
	arg_13_0._rotateLayer:runAction(CCSequence:create(var_13_5))
end

function var_0_0.alignTheLayer(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._rotateLayer:getRotation() % 360
	local var_14_1 = arg_14_0:getItemIndexFromAngle(var_14_0)
	local var_14_2 = arg_14_0:getItemAngle(var_14_1)
	local var_14_3 = CCRotateTo:create(0.2, var_14_2)

	arg_14_0._rotateLayer:runAction(var_14_3)
	arg_14_0:alignCallback()
end

function var_0_0.setLockItems(arg_15_0, arg_15_1)
	arg_15_0.config._unlockItemNum = arg_15_1
end

function var_0_0.getCurrentItemIndex(arg_16_0)
	local var_16_0 = arg_16_0._rotateLayer:getRotation()
	local var_16_1 = arg_16_0:getItemIndexFromAngle(var_16_0)

	return (arg_16_0:getFixedIndex(var_16_1))
end

function var_0_0.reloadLayer(arg_17_0, arg_17_1)
	if arg_17_1 ~= nil then
		arg_17_0._itemNodes[arg_17_1]:removeAllChildrenWithCleanup(true)
		arg_17_0.config._itemContentCallback(arg_17_0._itemNodes[arg_17_1], arg_17_1)

		return
	end

	for iter_17_0 = 1, arg_17_0.config._totalItemNum do
		arg_17_0._itemNodes[iter_17_0]:removeAllChildrenWithCleanup(true)
		arg_17_0.config._itemContentCallback(arg_17_0._itemNodes[iter_17_0], iter_17_0)
	end
end

function var_0_0.alignCallback(arg_18_0)
	local var_18_0 = arg_18_0._rotateLayer:getRotation() % 360
	local var_18_1 = arg_18_0:getItemIndexFromAngle(var_18_0)
	local var_18_2 = arg_18_0:getFixedIndex(var_18_1)

	if arg_18_0._previousIndex ~= nil then
		arg_18_0:reloadLayer(arg_18_0._previousIndex)

		if arg_18_0._previousIndex ~= var_18_2 then
			arg_18_0:reloadLayer(var_18_2)
		end

		arg_18_0._previousIndex = nil
	end

	if arg_18_0.config._alignCallback ~= nil then
		arg_18_0.config._alignCallback(var_18_2)
	end
end

function var_0_0.setRadiansOffset(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._rotateLayer:getRotation() + arg_19_1
	local var_19_1 = arg_19_0:getItemIndexFromAngle(var_19_0)

	if arg_19_0:getFixedIndex(var_19_1) > arg_19_0.config._unlockItemNum then
		return
	end

	arg_19_0._rotateLayer:setRotation(var_19_0)
end

return var_0_0
