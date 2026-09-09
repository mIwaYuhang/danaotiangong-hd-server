local var_0_0 = class("EllipseLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.config = {}
	arg_2_0.config._longAxias = arg_2_1.longAxias
	arg_2_0.config._totalItemNum = arg_2_1.totalItemNum
	arg_2_0.config._itemContentCallback = arg_2_1.itemContentCallback
	arg_2_0.config._shortAxias = arg_2_1.shortAxias or arg_2_1.longAxias
	arg_2_0.config._unlockItemNum = arg_2_1.unlockItemNum or arg_2_1.totalItemNum
	arg_2_0.config._alignCallback = arg_2_1.alignCallback or nil
	arg_2_0.config._eachItemAngle = 360 / arg_2_0.config._totalItemNum
	arg_2_0.config._fixAngle = arg_2_1.fixAngle or 0
	arg_2_0._itemNodes = {}
	arg_2_0._curRotationAngle = 0

	arg_2_0:initUI()
end

function var_0_0.getItemZorder(arg_3_0, arg_3_1)
	local var_3_0 = math.floor(arg_3_0.config._totalItemNum / 2)

	arg_3_1 = (arg_3_1 + var_3_0 + arg_3_0.config._totalItemNum - 2) % arg_3_0.config._totalItemNum + 1

	local var_3_1 = (arg_3_1 - var_3_0) * arg_3_0.config._eachItemAngle - arg_3_0._curRotationAngle
	local var_3_2 = toint(var_3_1)

	if var_3_2 <= 0 then
		var_3_2 = var_3_2 + 360
	end

	local var_3_3 = math.abs((var_3_2 - 180) / 2)
	local var_3_4 = 100
	local var_3_5 = (var_3_3 + var_3_4) / (90 + var_3_4)

	return math.abs(math.floor(var_3_2 / arg_3_0.config._eachItemAngle - 0.5)) * 2, var_3_5
end

function var_0_0.getItemPosition(arg_4_0, arg_4_1)
	local var_4_0 = ((arg_4_1 - 4) * arg_4_0.config._eachItemAngle - arg_4_0._curRotationAngle + arg_4_0.config._fixAngle) % 360 * 3.1415 / 180
	local var_4_1 = math.cos(var_4_0) * arg_4_0.config._longAxias
	local var_4_2 = math.sin(var_4_0) * arg_4_0.config._shortAxias

	return var_4_1, var_4_2
end

function var_0_0.getItemAngle(arg_5_0, arg_5_1)
	local var_5_0 = ((arg_5_1 - 1) * arg_5_0.config._eachItemAngle + 720) % 360

	if var_5_0 == 0 then
		var_5_0 = 360
	end

	return var_5_0
end

function var_0_0.getItemScaleFromAngle(arg_6_0, arg_6_1)
	return math.sin(arg_6_1)
end

function var_0_0.getItemIndexFromAngle(arg_7_0, arg_7_1)
	return math.floor(arg_7_1 / arg_7_0.config._eachItemAngle + 0.5) % arg_7_0.config._totalItemNum + 1
end

function var_0_0.initUI(arg_8_0)
	for iter_8_0 = 1, arg_8_0.config._totalItemNum do
		local var_8_0, var_8_1 = arg_8_0:getItemPosition(iter_8_0)
		local var_8_2, var_8_3 = arg_8_0:getItemZorder(iter_8_0)
		local var_8_4 = display.newNode()

		var_8_4:setZOrder(var_8_2)
		var_8_4:setPosition(ccp(var_8_0, var_8_1))
		var_8_4:setScale(var_8_3)
		arg_8_0:addChild(var_8_4)

		arg_8_0._itemNodes[iter_8_0] = var_8_4

		arg_8_0.config._itemContentCallback(var_8_4, iter_8_0)
	end
end

function var_0_0.setRadiansOffset(arg_9_0, arg_9_1)
	arg_9_0._curRotationAngle = arg_9_0._curRotationAngle + arg_9_1
	arg_9_0._curRotationAngle = arg_9_0._curRotationAngle % 360

	arg_9_0:updateAllItemPosition()
end

function var_0_0.updateAllItemPosition(arg_10_0)
	for iter_10_0 = 1, arg_10_0.config._totalItemNum do
		local var_10_0, var_10_1 = arg_10_0:getItemPosition(iter_10_0)
		local var_10_2, var_10_3 = arg_10_0:getItemZorder(iter_10_0)
		local var_10_4 = arg_10_0._itemNodes[iter_10_0]

		var_10_4:setPosition(ccp(var_10_0, var_10_1))
		var_10_4:setScale(var_10_3)
		var_10_4:setZOrder(var_10_2)

		local var_10_5 = arg_10_0:getItemAngle(iter_10_0) + arg_10_0._curRotationAngle

		arg_10_0:getItemScaleFromAngle(var_10_5)
	end
end

function var_0_0.getPreviousItemIndex(arg_11_0, arg_11_1)
	arg_11_1 = arg_11_1 - 1

	if arg_11_1 < 1 then
		arg_11_1 = arg_11_0.config._totalItemNum
	end

	return arg_11_1
end

function var_0_0.getNextItemIndex(arg_12_0, arg_12_1)
	arg_12_1 = arg_12_1 + 1

	if arg_12_1 > arg_12_0.config._totalItemNum then
		arg_12_1 = 1
	end

	return arg_12_1
end

function var_0_0.moveToPreviousItem(arg_13_0)
	local var_13_0 = arg_13_0._curRotationAngle
	local var_13_1 = arg_13_0:getItemIndexFromAngle(var_13_0)
	local var_13_2 = arg_13_0:getPreviousItemIndex(var_13_1)

	if var_13_2 > arg_13_0.config._unlockItemNum then
		var_13_2 = var_13_1
	end

	arg_13_0:moveToIndexItem(var_13_2, true)
end

function var_0_0.moveToNextItem(arg_14_0)
	local var_14_0 = arg_14_0._curRotationAngle
	local var_14_1 = arg_14_0:getItemIndexFromAngle(var_14_0)
	local var_14_2 = arg_14_0:getNextItemIndex(var_14_1)

	if var_14_2 > arg_14_0.config._unlockItemNum then
		var_14_2 = var_14_1
	end

	arg_14_0:moveToIndexItem(var_14_2, true)
end

function var_0_0.moveToIndexItem(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 > arg_15_0.config._unlockItemNum then
		return
	end

	local var_15_0 = arg_15_0:getItemAngle(arg_15_1)
	local var_15_1 = var_15_0 - arg_15_0._curRotationAngle

	if math.abs(var_15_1) > 180 then
		if var_15_1 < 0 then
			var_15_1 = var_15_1 + 360
		end

		if var_15_1 > 0 then
			var_15_1 = var_15_1 - 360
		end
	end

	local var_15_2 = var_15_1 / 15

	if arg_15_2 == false or var_15_2 == 0 then
		arg_15_0._curRotationAngle = var_15_0

		arg_15_0:updateAllItemPosition()

		return
	end

	local var_15_3 = 0.013333333333333334
	local var_15_4 = CCArray:create()

	local function var_15_5()
		arg_15_0._curRotationAngle = arg_15_0._curRotationAngle + var_15_2

		arg_15_0:updateAllItemPosition()
	end

	for iter_15_0 = 1, 15 do
		var_15_4:addObject(CCDelayTime:create(var_15_3))
		var_15_4:addObject(CCCallFunc:create(var_15_5))
	end

	var_15_4:addObject(CCCallFunc:create(handler(arg_15_0, arg_15_0.alignCallback)))
	arg_15_0:runAction(CCSequence:create(var_15_4))
end

function var_0_0.alignTheLayer(arg_17_0)
	local var_17_0 = arg_17_0._curRotationAngle
	local var_17_1 = arg_17_0:getItemIndexFromAngle(var_17_0)

	arg_17_0:moveToIndexItem(var_17_1, true)
end

function var_0_0.alignCallback(arg_18_0)
	local var_18_0 = arg_18_0:getCurrentItemIndex()

	arg_18_0._curRotationAngle = arg_18_0._curRotationAngle + 720
	arg_18_0._curRotationAngle = arg_18_0._curRotationAngle % 360

	if arg_18_0.config._alignCallback ~= nil then
		arg_18_0.config._alignCallback(var_18_0)
	end
end

function var_0_0.getCurrentItemIndex(arg_19_0)
	local var_19_0 = arg_19_0._curRotationAngle

	return (arg_19_0:getItemIndexFromAngle(var_19_0))
end

function var_0_0.reloadLayer(arg_20_0, arg_20_1)
	if arg_20_1 ~= nil then
		arg_20_0._itemNodes[arg_20_1]:removeAllChildrenWithCleanup(true)
		arg_20_0.config._itemContentCallback(arg_20_0._itemNodes[arg_20_1], arg_20_1)

		return
	end

	for iter_20_0 = 1, arg_20_0.config._totalItemNum do
		arg_20_0._itemNodes[iter_20_0]:removeAllChildrenWithCleanup(true)
		arg_20_0.config._itemContentCallback(arg_20_0._itemNodes[iter_20_0], iter_20_0)
	end
end

function var_0_0.getItemNode(arg_21_0, arg_21_1)
	return arg_21_0._itemNodes[arg_21_1]
end

return var_0_0
