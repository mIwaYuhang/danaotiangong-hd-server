local var_0_0 = 40
local var_0_1 = 1
local var_0_2 = {}
local var_0_3 = class("MarqueeLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

function var_0_3.ctor(arg_2_0, arg_2_1)
	arg_2_0.params = arg_2_1 or {}
	var_0_0 = 40

	local var_2_0 = CCSize(650 * Adapter.MinScale, 30 * Adapter.MinScale)
	local var_2_1 = CCArray:create()

	arg_2_0.backSprite = display.newScale9Sprite("ui/common/common_052.png")

	arg_2_0.backSprite:setPreferredSize(var_2_0)
	arg_2_0.backSprite:setAnchorPoint(CCPoint(0.5, 0))
	arg_2_0.backSprite:setPosition(display.cx, display.height)
	var_2_1:addObject(CCMoveTo:create(1, CCPoint(display.cx, display.height - Adapter.MinScale * 65)))
	var_2_1:addObject(CCCallFunc:create(function()
		if table.nums(var_0_2) == 0 then
			for iter_3_0, iter_3_1 in pairs(arg_2_0.params.data) do
				arg_2_0:addNotice({
					string = iter_3_1.content,
					repeatTime = iter_3_1.time,
					repeatNumber = iter_3_1.repeatNumber
				})
			end
		end

		arg_2_0:start()
	end))
	arg_2_0:addChild(arg_2_0.backSprite)
	arg_2_0.backSprite:runAction(CCSequence:create(var_2_1))
	arg_2_0:init(CCRect(var_2_0.width / 2, var_2_0.height / 2, var_2_0.width, var_2_0.height))
end

function var_0_3.init(arg_4_0, arg_4_1)
	arg_4_1.origin.x = arg_4_1.origin.x - arg_4_1.size.width / 2
	arg_4_1.origin.y = arg_4_1.origin.y - arg_4_1.size.height / 2
	arg_4_0.viewRect = arg_4_1
	arg_4_0.dataLayer = CCLayer:create()

	local var_4_0 = CCClippingRegionNode:create(arg_4_1)

	var_4_0:setPosition(0, 0)
	arg_4_0.backSprite:addChild(var_4_0)
	var_4_0:addChild(arg_4_0.dataLayer)
	arg_4_0.dataLayer:setPosition(CCPoint(0, 0))

	arg_4_0.viewRect.origin.x = arg_4_0.viewRect.origin.x + arg_4_1.size.width / 2
	arg_4_0.viewRect.origin.y = arg_4_0.viewRect.origin.y
end

function var_0_3.reloadNode(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getItemCount()

	arg_5_0:clearNotice()

	if arg_5_1 then
		for iter_5_0, iter_5_1 in pairs(arg_5_1.data) do
			arg_5_0:addNotice({
				string = iter_5_1.content,
				repeatTime = iter_5_1.time,
				repeatNumber = iter_5_1.repeatNumber
			})
		end

		if var_5_0 == 0 then
			arg_5_0:start()
		end
	end
end

function var_0_3.addNotice(arg_6_0, arg_6_1)
	if arg_6_1.repeatNumber > 0 then
		arg_6_1.remainNumber = arg_6_1.repeatNumber
	end

	arg_6_1.string = string.gsub(arg_6_1.string, "\n", "")

	table.insert(var_0_2, arg_6_1)
end

function var_0_3.clearNotice(arg_7_0)
	var_0_2 = {}
	var_0_1 = 1
end

function var_0_3.getItemCount(arg_8_0)
	return table.nums(var_0_2)
end

function var_0_3.start(arg_9_0)
	if table.nums(var_0_2) == 0 then
		local var_9_0 = CCArray:create()

		var_9_0:addObject(CCMoveTo:create(1, CCPoint(display.cx, display.height)))

		if arg_9_0.params.callback then
			var_9_0:addObject(CCCallFunc:create(arg_9_0.params.callback))
		end

		arg_9_0:runAction(CCSequence:create(var_9_0))

		return
	end

	if table.nums(var_0_2) < var_0_1 then
		var_0_1 = 1
	end

	local var_9_1 = var_0_1 + 1

	if var_9_1 > table.nums(var_0_2) then
		var_9_1 = 1
	end

	local var_9_2 = var_0_2[var_0_1]
	local var_9_3 = var_0_2[var_9_1]
	local var_9_4 = CCLabelTTF:create(var_9_2.string, _FONT_DEFAULT, Adapter.FontSize(20))

	var_9_4:setAnchorPoint(CCPoint(0.5, 0))
	var_9_4:setPosition(arg_9_0.viewRect.size.width / 2, arg_9_0.viewRect.origin.y)
	arg_9_0.dataLayer:addChild(var_9_4)

	local var_9_5 = CCLabelTTF:create(var_9_3.string, _FONT_DEFAULT, Adapter.FontSize(20))

	var_9_5:setAnchorPoint(CCPoint(0.5, 0))
	var_9_5:setPosition(arg_9_0.viewRect.size.width / 2, arg_9_0.viewRect.origin.y - arg_9_0.viewRect.size.height)
	arg_9_0.dataLayer:addChild(var_9_5)

	if var_9_2.repeatNumber > 0 then
		var_9_2.remainNumber = var_9_2.remainNumber - 1

		if var_9_2.remainNumber == 0 then
			table.remove(var_0_2, var_0_1)
		else
			var_0_1 = var_0_1 + 1
		end
	end

	if table.nums(var_0_2) < var_0_1 then
		var_0_1 = 1
	end

	arg_9_0:labelAction(var_9_4, var_9_5, 2)
end

function var_0_3.labelAction(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_1:getTextureRect()
	local var_10_1, var_10_2 = arg_10_1:getPosition()
	local var_10_3 = CCArray:create()

	var_10_3:addObject(CCDelayTime:create(arg_10_3))
	var_10_3:addObject(CCMoveBy:create(1, CCPoint(0, arg_10_0.viewRect.size.height)))
	var_10_3:addObject(CCCallFunc:create(function()
		arg_10_1:removeFromParentAndCleanup(true)
		arg_10_0:start()
	end))
	arg_10_1:stopAllActions()
	arg_10_1:runAction(CCSequence:create(var_10_3))

	local var_10_4 = CCArray:create()

	var_10_4:addObject(CCDelayTime:create(arg_10_3))
	var_10_4:addObject(CCMoveBy:create(1, CCPoint(0, arg_10_0.viewRect.size.height)))
	var_10_4:addObject(CCCallFunc:create(function()
		arg_10_2:removeFromParentAndCleanup(true)
	end))
	arg_10_2:stopAllActions()
	arg_10_2:runAction(CCSequence:create(var_10_4))
end

return var_0_3
