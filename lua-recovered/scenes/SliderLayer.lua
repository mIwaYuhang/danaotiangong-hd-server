local var_0_0 = class("SliderLayer", function()
	return display.newLayer()
end)
local var_0_1 = 0.4
local var_0_2 = 25
local var_0_3 = 0.2

SliderDirection = {
	eHorizontal = 2,
	eBoth = 3,
	eVertical = 1
}
SliderFillDirection = {
	eButtonUp = 2,
	eTopDown = 1
}

local var_0_4 = "ui/common/common_048.png"
local var_0_5 = "ui/common/common_047.png"
local var_0_6 = 5
local var_0_7 = ccc4(255, 255, 255, 0)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.size = arg_2_1.size
	arg_2_0.clipScaleX = arg_2_1.clipScaleX or 1
	arg_2_0.clipScaleY = arg_2_1.clipScaleY or 1
	arg_2_0.point = arg_2_1.point
	arg_2_0.numberHandler = arg_2_1.numberHandler
	arg_2_0.cellHandler = arg_2_1.cellHandler
	arg_2_0.changedHandler = arg_2_1.changedHandler
	arg_2_0.direction = arg_2_1.direction or SliderDirection.eHorizontal
	arg_2_0.fillDirection = arg_2_1.fillDirection or SliderFillDirection.eButtonUp
	arg_2_0.navOnSprite = arg_2_1.navOnSprite
	arg_2_0.navOffSprite = arg_2_1.navOffSprite
	arg_2_0.navPosition = arg_2_1.navPosition
	arg_2_0.navMargin = arg_2_1.navMargin
	arg_2_0.cannotMoveOutSide = arg_2_1.cannotMoveOutSide or false
	arg_2_0.alwaysShowSideLayer = arg_2_1.alwaysShowSideLayer or false
	arg_2_0._touchCheckDelayTime = arg_2_1.touchCheckDelayTime or 0.25
	arg_2_0._touchBeginCallback = arg_2_1.touchBeginCallback or nil
	arg_2_0._touchMoveCallback = arg_2_1.touchMoveCallback or nil
	arg_2_0._touchEndCallback = arg_2_1.touchEndCallback or nil

	arg_2_0:setContentSize(arg_2_0.size)
	arg_2_0:setPosition(arg_2_0.point)

	local function var_2_0(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return arg_2_0:onTouchBegan(arg_3_1, arg_3_2)
		elseif arg_3_0 == "moved" then
			arg_2_0:onTouchMoved(arg_3_1, arg_3_2)
		elseif arg_3_0 == "ended" or arg_3_0 == "cancelled" then
			arg_2_0:onTouchEnded(arg_3_1, arg_3_2)
		end
	end

	arg_2_0:addTouchEventListener(var_2_0, false, -128, false)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.curIndex = 1
	arg_2_0._isMoveMode = false
	arg_2_0._touchBeginPos = nil
	arg_2_0._touchEndPos = nil
	arg_2_0._curNavigatorIndex = 1
end

function var_0_0.reloadData(arg_4_0, arg_4_1)
	arg_4_0.curIndex = arg_4_1 or arg_4_0.curIndex
	arg_4_0._curNavigatorIndex = arg_4_1 or arg_4_0.curIndex
	arg_4_0.cellNum = arg_4_0.numberHandler()

	if arg_4_0.clipper == nil then
		arg_4_0.clipper = CCClippingRegionNode:create(CCRect(1, 0, arg_4_0.size.width * arg_4_0.clipScaleX, arg_4_0.size.height * arg_4_0.clipScaleY))

		arg_4_0.clipper:setPosition(0, 0)
		arg_4_0:addChild(arg_4_0.clipper)
	end

	arg_4_0.clipper:removeAllChildrenWithCleanup(true)

	arg_4_0.nextLayer = nil
	arg_4_0.prevLayer = nil
	arg_4_0.curIndex = arg_4_0.curIndex > arg_4_0.cellNum and arg_4_0.cellNum or arg_4_0.curIndex
	arg_4_0.curIndex = arg_4_0.curIndex == 0 and 1 or arg_4_0.curIndex

	if arg_4_0.cellNum > 0 then
		arg_4_0.curLayer = CCLayerColor:create(var_0_7, arg_4_0.size.width, arg_4_0.size.height)

		arg_4_0.clipper:addChild(arg_4_0.curLayer)
		arg_4_0.cellHandler(arg_4_0.curLayer, arg_4_0.curIndex)

		if arg_4_0.changedHandler then
			arg_4_0.changedHandler(arg_4_0.curIndex)
		end

		if arg_4_0.navPosition and arg_4_0.navMargin then
			arg_4_0:removeNavigators()
			arg_4_0:createNavigators()
			arg_4_0:refreshNavigators()
		end

		arg_4_0:createScrollDirectionLayers()
	end
end

function var_0_0.setBackgroundColor(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:reloadData(arg_5_0.curIndex)

	if arg_5_0.curLayer then
		arg_5_0.curLayer:setColor(arg_5_1)
		arg_5_0.curLayer:setOpacity(arg_5_2)
	end
end

function var_0_0.createNavigators(arg_6_0)
	arg_6_0._navigatorNode = display.newNode()

	arg_6_0:addChild(arg_6_0._navigatorNode)

	local var_6_0 = math.min(var_0_6, arg_6_0.cellNum)
	local var_6_1 = (arg_6_0.size.width - var_6_0 * arg_6_0.navMargin) / 2

	if var_6_0 % 2 == 0 then
		var_6_1 = (arg_6_0.size.width - (var_6_0 + 1) * arg_6_0.navMargin) / 2
	end

	if arg_6_0.navigator == nil then
		arg_6_0.navigator = {}

		for iter_6_0 = 1, var_6_0 do
			local var_6_2

			if iter_6_0 == arg_6_0._curNavigatorIndex then
				var_6_2 = display.newSprite(arg_6_0.navOnSprite, var_6_1 + (iter_6_0 - 0.5) * arg_6_0.navMargin, arg_6_0.navPosition.y)
			else
				var_6_2 = display.newSprite(arg_6_0.navOffSprite, var_6_1 + (iter_6_0 - 0.5) * arg_6_0.navMargin, arg_6_0.navPosition.y)
			end

			arg_6_0._navigatorNode:addChild(var_6_2)

			arg_6_0.navigator[iter_6_0] = var_6_2
		end

		arg_6_0._leftMore = display.newSprite("ui/common/common_111.png", var_6_1 - arg_6_0.navMargin / 2, arg_6_0.navPosition.y)

		arg_6_0._leftMore:setFlipX(true)
		arg_6_0._navigatorNode:addChild(arg_6_0._leftMore)

		arg_6_0._rightMore = display.newSprite("ui/common/common_111.png", var_6_1 + arg_6_0.navMargin * (var_6_0 + 0.5), arg_6_0.navPosition.y)

		arg_6_0._navigatorNode:addChild(arg_6_0._rightMore)
	end
end

function var_0_0.refreshNavigators(arg_7_0)
	if arg_7_0.navigator ~= nil then
		local var_7_0 = math.min(var_0_6, arg_7_0.cellNum)

		if var_7_0 < arg_7_0._curNavigatorIndex then
			arg_7_0._curNavigatorIndex = (arg_7_0.curIndex - 1) % var_0_6 + 1
		end

		if var_7_0 < arg_7_0.curIndex or arg_7_0.curIndex > arg_7_0._curNavigatorIndex and var_7_0 > arg_7_0._curNavigatorIndex then
			arg_7_0._leftMore:setVisible(true)
		else
			arg_7_0._leftMore:setVisible(false)
		end

		if var_7_0 < arg_7_0.cellNum and arg_7_0.curIndex ~= arg_7_0.cellNum then
			arg_7_0._rightMore:setVisible(true)
		else
			arg_7_0._rightMore:setVisible(false)
		end

		if arg_7_0._showRightMore == true then
			arg_7_0._showRightMore = nil

			arg_7_0._rightMore:setVisible(true)
		end

		for iter_7_0, iter_7_1 in ipairs(arg_7_0.navigator) do
			if iter_7_1 ~= nil then
				local var_7_1

				if iter_7_0 == arg_7_0._curNavigatorIndex or var_7_0 < arg_7_0.curIndex and iter_7_0 == var_7_0 and arg_7_0._curNavigatorIndex == var_7_0 then
					var_7_1 = display.newSprite(arg_7_0.navOnSprite)
				else
					var_7_1 = display.newSprite(arg_7_0.navOffSprite)
				end

				iter_7_1:setTexture(var_7_1:getTexture())
			end
		end
	end
end

function var_0_0.removeNavigators(arg_8_0)
	if arg_8_0.navigator ~= nil then
		arg_8_0._navigatorNode:removeFromParent()
	end

	arg_8_0.navigator = nil
end

function var_0_0.isScrollLayerToBorder(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.curIndex > 1
	local var_9_1 = arg_9_0.cellNum > arg_9_0.curIndex

	if arg_9_1 then
		if arg_9_0.fillDirection == SliderFillDirection.eTopDown then
			return var_9_0
		else
			return var_9_1
		end
	elseif arg_9_0.fillDirection == SliderFillDirection.eTopDown then
		return var_9_1
	else
		return var_9_0
	end
end

function var_0_0.createScrollDirectionLayers(arg_10_0)
	if arg_10_0:isScrollLayerToBorder(true) and arg_10_0.nextLayer == nil then
		arg_10_0.nextLayer = CCLayerColor:create(var_0_7, arg_10_0.size.width, arg_10_0.size.height)

		arg_10_0.nextLayer:setPosition(ccp(arg_10_0.size.width, 0))

		if arg_10_0.direction == SliderDirection.eVertical then
			arg_10_0.nextLayer:setPosition(ccp(0, arg_10_0.size.height))
		end

		arg_10_0.clipper:addChild(arg_10_0.nextLayer)

		if arg_10_0.fillDirection == SliderFillDirection.eTopDown then
			arg_10_0.cellHandler(arg_10_0.nextLayer, arg_10_0.curIndex - 1)
		else
			arg_10_0.cellHandler(arg_10_0.nextLayer, arg_10_0.curIndex + 1)
		end
	end

	if arg_10_0:isScrollLayerToBorder(false) and arg_10_0.prevLayer == nil then
		arg_10_0.prevLayer = CCLayerColor:create(var_0_7, arg_10_0.size.width, arg_10_0.size.height)

		arg_10_0.prevLayer:setPosition(ccp(-arg_10_0.size.width, 0))

		if arg_10_0.direction == SliderDirection.eVertical then
			arg_10_0.prevLayer:setPosition(ccp(0, -arg_10_0.size.height))
		end

		arg_10_0.clipper:addChild(arg_10_0.prevLayer)

		if arg_10_0.fillDirection == SliderFillDirection.eTopDown then
			arg_10_0.cellHandler(arg_10_0.prevLayer, arg_10_0.curIndex + 1)
		else
			arg_10_0.cellHandler(arg_10_0.prevLayer, arg_10_0.curIndex - 1)
		end
	end

	arg_10_0:setScrollLayersVisible(arg_10_0.alwaysShowSideLayer)
	arg_10_0:refreshNavigators()
end

function var_0_0.onTouchBegan(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._isMoveMode = false
	arg_11_0._touchBeginPos = ccp(arg_11_1, arg_11_2)
	arg_11_0._touchEndPos = ccp(arg_11_1, arg_11_2)
	arg_11_0._moveDirection = arg_11_0.direction ~= SliderDirection.eBoth and arg_11_0.direction or nil

	local var_11_0 = arg_11_0:convertToNodeSpace(CCPoint(arg_11_1, arg_11_2))

	if CCRect(0, 0, arg_11_0.size.width, arg_11_0.size.height):containsPoint(var_11_0) then
		local function var_11_1()
			local var_12_0 = ccpDistance(arg_11_0._touchBeginPos, arg_11_0._touchEndPos)

			print("distance:", var_12_0)

			if var_12_0 < 5 then
				arg_11_0._isMoveMode = true

				if arg_11_0._touchBeginCallback and arg_11_0._touchBeginCallback(arg_11_0.curIndex, arg_11_1, arg_11_2) == false then
					arg_11_0._isMoveMode = false
				end
			end
		end

		local var_11_2 = CCArray:create()

		var_11_2:addObject(CCDelayTime:create(arg_11_0._touchCheckDelayTime))
		var_11_2:addObject(CCCallFunc:create(var_11_1))

		arg_11_0.checkAction = CCSequence:create(var_11_2)

		arg_11_0:runAction(arg_11_0.checkAction)

		arg_11_0._lastTouchPoint = var_11_0
		arg_11_0._touchBeginTime = cc_timeval:new()

		CCTime:gettimeofdayCocos2d(arg_11_0._touchBeginTime, nil)

		arg_11_0._touchBeginPoint = var_11_0

		return true
	else
		return false
	end
end

function var_0_0.onTouchMoved(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0._isMoveMode == true then
		if arg_13_0._touchMoveCallback then
			arg_13_0._touchMoveCallback(arg_13_0.curIndex, arg_13_1, arg_13_2)
		end

		return
	end

	arg_13_0._touchEndPos = ccp(arg_13_1, arg_13_2)

	if arg_13_0._lastTouchPoint ~= nil then
		local var_13_0 = arg_13_0.clipper:convertToNodeSpace(CCPoint(arg_13_1, arg_13_2))
		local var_13_1 = var_13_0.x - arg_13_0._lastTouchPoint.x
		local var_13_2 = var_13_0.y - arg_13_0._lastTouchPoint.y

		if arg_13_0._moveDirection == nil then
			arg_13_0._moveDirection = math.abs(var_13_1) > math.abs(var_13_2) and SliderDirection.eHorizontal or SliderDirection.eVertical
		end

		local var_13_3, var_13_4 = arg_13_0.curLayer:getPosition()

		if arg_13_0._moveDirection == SliderDirection.eVertical then
			local var_13_5 = ccp(var_13_3, var_13_4 + var_13_2 * (1 - math.abs(var_13_4 / arg_13_0.size.height)))

			if arg_13_0.cannotMoveOutSide == true and (arg_13_0.prevLayer == nil and var_13_5.y > 0 or arg_13_0.nextLayer == nil and var_13_5.y < 0) then
				var_13_5.y = 0
			end

			arg_13_0.curLayer:setPosition(var_13_5)

			if arg_13_0.nextLayer then
				arg_13_0.nextLayer:setPosition(ccp(var_13_5.x, var_13_5.y + arg_13_0.size.height))
			end

			if arg_13_0.prevLayer then
				arg_13_0.prevLayer:setPosition(ccp(var_13_5.x, var_13_5.y - arg_13_0.size.height))
			end
		elseif arg_13_0._moveDirection == SliderDirection.eHorizontal then
			local var_13_6 = ccp(var_13_3 + var_13_1 * (1 - math.abs(var_13_3 / arg_13_0.size.width)), var_13_4)

			if arg_13_0.cannotMoveOutSide == true and (arg_13_0.prevLayer == nil and var_13_6.x > 0 or arg_13_0.nextLayer == nil and var_13_6.x < 0) then
				var_13_6.x = 0
			end

			arg_13_0.curLayer:setPosition(var_13_6)

			if arg_13_0.nextLayer then
				arg_13_0.nextLayer:setPosition(ccp(var_13_6.x + arg_13_0.size.width, var_13_6.y))
			end

			if arg_13_0.prevLayer then
				arg_13_0.prevLayer:setPosition(ccp(var_13_6.x - arg_13_0.size.width, var_13_6.y))
			end
		end

		arg_13_0:setScrollLayersVisible(true)

		arg_13_0._lastTouchPoint = var_13_0
	end
end

function var_0_0.onTouchEnded(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0._isMoveMode == true then
		if arg_14_0._touchEndCallback then
			arg_14_0._touchEndCallback(arg_14_0.curIndex, arg_14_1, arg_14_2)
		end

		return
	end

	arg_14_0:stopAction(arg_14_0.checkAction)

	local var_14_0 = arg_14_0.clipper:convertToNodeSpace(CCPoint(arg_14_1, arg_14_2))
	local var_14_1 = var_14_0.x - arg_14_0._touchBeginPoint.x
	local var_14_2 = var_14_0.y - arg_14_0._touchBeginPoint.y
	local var_14_3 = cc_timeval:new()

	CCTime:gettimeofdayCocos2d(var_14_3, nil)

	local var_14_4 = CCTime:timersubCocos2d(arg_14_0._touchBeginTime, var_14_3)
	local var_14_5, var_14_6 = arg_14_0.curLayer:getPosition()

	if arg_14_0._moveDirection == SliderDirection.eHorizontal then
		if (var_14_5 > arg_14_0.size.width * var_0_1 or var_14_1 > var_0_2 and var_14_4 < 250) and arg_14_0.curIndex > 1 then
			arg_14_0:actionMoveNext()
		elseif (var_14_5 < -arg_14_0.size.width * var_0_1 or var_14_1 < -var_0_2 and var_14_4 < 250) and arg_14_0.cellNum > arg_14_0.curIndex then
			arg_14_0:actionMovePrev()
		else
			arg_14_0:actionMoveReturn()
		end
	elseif arg_14_0._moveDirection == SliderDirection.eVertical then
		if (var_14_6 > arg_14_0.size.height * var_0_1 or var_14_2 > var_0_2 and var_14_4 < 250) and arg_14_0:isScrollLayerToBorder(false) then
			arg_14_0:actionMoveNext()
		elseif (var_14_6 < -arg_14_0.size.height * var_0_1 or var_14_2 < -var_0_2 and var_14_4 < 250) and arg_14_0:isScrollLayerToBorder(true) then
			arg_14_0:actionMovePrev()
		else
			arg_14_0:actionMoveReturn()
		end
	end

	arg_14_0._touchBeginPoint = nil
	arg_14_0._touchBeginTime = nil
	arg_14_0._lastTouchPoint = nil
end

function var_0_0.actionMoveReturn(arg_15_0)
	arg_15_0:setScrollLayersVisible(true)

	local var_15_0 = CCMoveTo:create(var_0_3, CCPoint(0, 0))

	arg_15_0.curLayer:stopAllActions()
	arg_15_0.curLayer:runAction(CCSequence:createWithTwoActions(var_15_0, CCCallFunc:create(function()
		arg_15_0:setScrollLayersVisible(arg_15_0.alwaysShowSideLayer)
	end)))

	if arg_15_0._moveDirection == SliderDirection.eHorizontal then
		if arg_15_0.nextLayer then
			local var_15_1 = CCMoveTo:create(var_0_3, CCPoint(arg_15_0.size.width, 0))

			arg_15_0.nextLayer:stopAllActions()
			arg_15_0.nextLayer:runAction(var_15_1)
		end

		if arg_15_0.prevLayer then
			local var_15_2 = CCMoveTo:create(var_0_3, CCPoint(-arg_15_0.size.width, 0))

			arg_15_0.prevLayer:stopAllActions()
			arg_15_0.prevLayer:runAction(var_15_2)
		end
	elseif arg_15_0._moveDirection == SliderDirection.eVertical then
		if arg_15_0.nextLayer then
			local var_15_3 = CCMoveTo:create(var_0_3, CCPoint(0, arg_15_0.size.height))

			arg_15_0.nextLayer:stopAllActions()
			arg_15_0.nextLayer:runAction(var_15_3)
		end

		if arg_15_0.prevLayer then
			local var_15_4 = CCMoveTo:create(var_0_3, CCPoint(0, -arg_15_0.size.height))

			arg_15_0.prevLayer:stopAllActions()
			arg_15_0.prevLayer:runAction(var_15_4)
		end
	end
end

function var_0_0.actionMoveNext(arg_17_0)
	arg_17_0:setScrollLayersVisible(true)

	local var_17_0 = CCPoint(0, 0)

	if arg_17_0._moveDirection == SliderDirection.eHorizontal then
		var_17_0 = CCPoint(arg_17_0.size.width, 0)
	elseif arg_17_0._moveDirection == SliderDirection.eVertical then
		var_17_0 = CCPoint(0, arg_17_0.size.height)
	end

	local var_17_1 = CCMoveTo:create(var_0_3, var_17_0)

	arg_17_0.curLayer:stopAllActions()
	arg_17_0.curLayer:runAction(CCSequence:createWithTwoActions(var_17_1, CCCallFunc:create(function()
		if arg_17_0.nextLayer then
			arg_17_0.nextLayer:removeFromParent()

			arg_17_0.nextLayer = nil
		end

		arg_17_0.nextLayer = arg_17_0.curLayer

		if arg_17_0.fillDirection == SliderFillDirection.eTopDown then
			arg_17_0.curIndex = arg_17_0.curIndex + 1

			arg_17_0:setNextNavigatorIndex()
		else
			arg_17_0.curIndex = arg_17_0.curIndex - 1

			arg_17_0:setPrevNavigatorIndex()
		end

		if arg_17_0.changedHandler then
			arg_17_0.changedHandler(arg_17_0.curIndex)
		end
	end)))

	if arg_17_0.prevLayer then
		local var_17_2 = CCMoveTo:create(var_0_3, CCPoint(0, 0))

		arg_17_0.prevLayer:stopAllActions()
		arg_17_0.prevLayer:runAction(CCSequence:createWithTwoActions(var_17_2, CCCallFunc:create(function()
			arg_17_0.curLayer = arg_17_0.prevLayer
			arg_17_0.prevLayer = nil

			arg_17_0:createScrollDirectionLayers()
		end)))
	end
end

function var_0_0.actionMovePrev(arg_20_0)
	arg_20_0:setScrollLayersVisible(true)

	local var_20_0 = CCPoint(0, 0)

	if arg_20_0._moveDirection == SliderDirection.eHorizontal then
		var_20_0 = CCPoint(-arg_20_0.size.width, 0)
	elseif arg_20_0._moveDirection == SliderDirection.eVertical then
		var_20_0 = CCPoint(0, -arg_20_0.size.height)
	end

	local var_20_1 = CCMoveTo:create(var_0_3, var_20_0)

	arg_20_0.curLayer:stopAllActions()
	arg_20_0.curLayer:runAction(CCSequence:createWithTwoActions(var_20_1, CCCallFunc:create(function()
		if arg_20_0.prevLayer then
			arg_20_0.prevLayer:removeFromParent()

			arg_20_0.prevLayer = nil
		end

		arg_20_0.prevLayer = arg_20_0.curLayer

		if arg_20_0.fillDirection == SliderFillDirection.eTopDown then
			arg_20_0.curIndex = arg_20_0.curIndex - 1

			arg_20_0:setPrevNavigatorIndex()
		else
			arg_20_0.curIndex = arg_20_0.curIndex + 1

			arg_20_0:setNextNavigatorIndex()
		end

		if arg_20_0.changedHandler then
			arg_20_0.changedHandler(arg_20_0.curIndex)
		end
	end)))

	if arg_20_0.nextLayer then
		local var_20_2 = CCMoveTo:create(var_0_3, CCPoint(0, 0))

		arg_20_0.nextLayer:stopAllActions()
		arg_20_0.nextLayer:runAction(CCSequence:createWithTwoActions(var_20_2, CCCallFunc:create(function()
			arg_20_0.curLayer = arg_20_0.nextLayer
			arg_20_0.nextLayer = nil

			arg_20_0:createScrollDirectionLayers()
		end)))
	end
end

function var_0_0.setScrollLayersVisible(arg_23_0, arg_23_1)
	if arg_23_0.nextLayer then
		arg_23_0.nextLayer:setVisible(arg_23_1)
	end

	if arg_23_0.prevLayer then
		arg_23_0.prevLayer:setVisible(arg_23_1)
	end
end

function var_0_0.setPrevNavigatorIndex(arg_24_0)
	local var_24_0 = math.min(var_0_6, arg_24_0.cellNum)

	arg_24_0._curNavigatorIndex = arg_24_0._curNavigatorIndex - 1

	if arg_24_0._curNavigatorIndex < 1 then
		if arg_24_0.curIndex > 1 then
			arg_24_0._curNavigatorIndex = math.min(var_24_0, arg_24_0.curIndex)
		else
			arg_24_0._curNavigatorIndex = 1
		end
	end
end

function var_0_0.setNextNavigatorIndex(arg_25_0)
	local var_25_0 = math.min(var_0_6, arg_25_0.cellNum)

	arg_25_0._curNavigatorIndex = arg_25_0._curNavigatorIndex + 1

	if arg_25_0._curNavigatorIndex > var_0_6 then
		if arg_25_0.curIndex < arg_25_0.cellNum then
			arg_25_0._curNavigatorIndex = math.max(var_25_0 - (arg_25_0.cellNum - arg_25_0.curIndex), 1)
		else
			arg_25_0._curNavigatorIndex = var_0_6
		end
	end
end

function var_0_0.getCurrentIndex(arg_26_0)
	return arg_26_0.curIndex
end

function var_0_0.getCurrentLayer(arg_27_0)
	return arg_27_0.curLayer
end

function var_0_0.showRightMoreNavigator(arg_28_0)
	arg_28_0._rightMore:setVisible(true)

	arg_28_0._showRightMore = true
end

return var_0_0
