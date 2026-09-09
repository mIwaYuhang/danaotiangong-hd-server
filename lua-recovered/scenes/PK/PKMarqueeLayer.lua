local var_0_0 = 40
local var_0_1 = 1
local var_0_2 = class("PKMarqueeLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

function var_0_2.ctor(arg_2_0)
	var_0_0 = 40
	var_0_1 = 1
	arg_2_0.showItemList = {}
end

function var_0_2.init(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = CCSize(450, 32)

	if arg_3_2 ~= nil then
		var_3_0 = arg_3_2
	end

	print(var_3_0.width, var_3_0.height)

	arg_3_0.viewRect = CCRect(0, 0, var_3_0.width - 5, var_3_0.height - 2)

	local var_3_1 = display.newScale9Sprite("ui/common/common_052.png")

	var_3_1:setContentSize(var_3_0)
	var_3_1:setPosition(arg_3_1)
	arg_3_0:addChild(var_3_1)

	local var_3_2 = CCRect(0, 0, Adapter.AutoWidth(arg_3_0.viewRect.size.width), Adapter.MinHeight(arg_3_0.viewRect.size.height))

	arg_3_0.dataLayer = CCClippingRegionNode:create(var_3_2)

	arg_3_0.dataLayer:setPosition(0, 0)
	var_3_1:addChild(arg_3_0.dataLayer)
end

function var_0_2.addNotice(arg_4_0, arg_4_1)
	if arg_4_1.repeatNumber > 0 then
		arg_4_1.remainNumber = arg_4_1.repeatNumber
	end

	table.insert(arg_4_0.showItemList, arg_4_1)
end

function var_0_2.clearNotice(arg_5_0)
	arg_5_0.showItemList = {}
	var_0_1 = 1
end

function var_0_2.getItemCount(arg_6_0)
	return table.nums(arg_6_0.showItemList)
end

function var_0_2.start(arg_7_0)
	if table.nums(arg_7_0.showItemList) == 0 then
		local var_7_0 = CCArray:create()

		var_7_0:addObject(CCMoveTo:create(1, CCPoint(display.cx, display.height)))
		var_7_0:addObject(CCCallFunc:create(function()
			arg_7_0:removeFromParent()
		end))
		arg_7_0:runAction(CCSequence:create(var_7_0))

		return
	end

	if table.nums(arg_7_0.showItemList) < var_0_1 then
		var_0_1 = 1
	end

	local var_7_1 = var_0_1 + 1

	if var_7_1 > table.nums(arg_7_0.showItemList) then
		var_7_1 = 1
	end

	local var_7_2 = arg_7_0.showItemList[var_0_1]
	local var_7_3 = arg_7_0.showItemList[var_7_1]
	local var_7_4 = ui.newTTFLabel({
		text = var_7_2.string,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(20),
		align = ui.TEXT_ALIGN_CENTER,
		dimensions = arg_7_0.viewRect.size
	})

	var_7_4:setAnchorPoint(CCPoint(0, 0))
	var_7_4:setPosition(0, arg_7_0.viewRect.origin.y)
	arg_7_0.dataLayer:addChild(var_7_4)

	local var_7_5 = ui.newTTFLabel({
		text = var_7_3.string,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(20),
		align = ui.TEXT_ALIGN_CENTER,
		dimensions = arg_7_0.viewRect.size
	})

	var_7_5:setAnchorPoint(CCPoint(0, 0))
	var_7_5:setPosition(0, arg_7_0.viewRect.origin.y - arg_7_0.viewRect.size.height)
	arg_7_0.dataLayer:addChild(var_7_5)

	if var_7_2.repeatNumber > 0 then
		var_7_2.remainNumber = var_7_2.remainNumber - 1

		if var_7_2.remainNumber == 0 then
			table.remove(arg_7_0.showItemList, var_0_1)
		else
			var_0_1 = var_0_1 + 1
		end
	end

	if table.nums(arg_7_0.showItemList) < var_0_1 then
		var_0_1 = 1
	end

	arg_7_0:labelAction(var_7_4, var_7_5, 2)
end

function var_0_2.labelAction(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_1:getTextureRect()
	local var_9_1, var_9_2 = arg_9_1:getPosition()
	local var_9_3 = CCArray:create()

	var_9_3:addObject(CCDelayTime:create(arg_9_3))
	var_9_3:addObject(CCMoveBy:create(1, CCPoint(0, arg_9_0.viewRect.size.height)))
	var_9_3:addObject(CCCallFunc:create(function()
		arg_9_1:removeFromParentAndCleanup(true)
		arg_9_0:start()
	end))
	arg_9_1:stopAllActions()
	arg_9_1:runAction(CCSequence:create(var_9_3))

	local var_9_4 = CCArray:create()

	var_9_4:addObject(CCDelayTime:create(arg_9_3))
	var_9_4:addObject(CCMoveBy:create(1, CCPoint(0, arg_9_0.viewRect.size.height)))
	var_9_4:addObject(CCCallFunc:create(function()
		arg_9_2:removeFromParentAndCleanup(true)
	end))
	arg_9_2:stopAllActions()
	arg_9_2:runAction(CCSequence:create(var_9_4))
end

return var_0_2
