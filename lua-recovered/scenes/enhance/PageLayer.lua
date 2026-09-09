local var_0_0 = 0.4
local var_0_1 = 25
local var_0_2 = 0.2
local var_0_3 = class("PageLayer", function()
	return display.newLayer()
end)

PageActionType = {
	eMoveHorizontal = 2,
	eMoveBoth = 3,
	eMoveVertical = 1
}

function var_0_3.ctor(arg_2_0)
	arg_2_0.holdOperator = false
end

local var_0_4 = {}

function var_0_3.onTouchBegan(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0.holdOperator then
		return false
	end

	arg_3_0.touchRect = CCRect()
	arg_3_0.touchRect.origin = CCPoint(arg_3_0:convertToWorldSpace(arg_3_0.viewRect.origin))
	arg_3_0.touchRect.size = CCSize(arg_3_0.viewRect.size)
	arg_3_0.touchRect.origin.x = arg_3_0.touchRect.origin.x - arg_3_0.touchRect.size.width / 2
	arg_3_0.touchRect.origin.y = arg_3_0.touchRect.origin.y - arg_3_0.touchRect.size.height / 2

	if arg_3_0.touchRect:containsPoint(CCPoint(arg_3_1, arg_3_2)) then
		arg_3_0.start_pos_x = arg_3_1
		arg_3_0.start_pos_y = arg_3_2

		arg_3_0.dataLayer:stopAllActions()

		var_0_4.pos_x, var_0_4.pos_y = arg_3_1, arg_3_2

		return true
	end

	return false
end

function var_0_3.onTouchMoved(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.holdOperator then
		return
	end

	if arg_4_0.moveType == PageActionType.eMoveVertical then
		arg_4_0.moveVert = true
	elseif arg_4_0.moveType == PageActionType.eMoveHorizontal then
		arg_4_0.moveHori = true
	elseif arg_4_0.moveHori == false and arg_4_0.moveVert == false then
		if math.max(math.abs(arg_4_0.start_pos_x - arg_4_1), math.abs(arg_4_0.start_pos_y - arg_4_2)) > 10 then
			if math.abs(arg_4_0.start_pos_x - arg_4_1) > math.abs(arg_4_0.start_pos_y - arg_4_2) then
				arg_4_0.moveHori = true
			else
				arg_4_0.moveVert = true
			end
		else
			return
		end
	end

	if arg_4_0.moveHori then
		local var_4_0, var_4_1 = arg_4_0.dataLayer:getPosition()

		arg_4_0.dataLayer:setPosition(var_4_0 + (arg_4_1 - arg_4_0.start_pos_x) * (1 - math.abs(var_4_0 / arg_4_0.touchRect.size.width)), var_4_1)
	else
		local var_4_2, var_4_3 = arg_4_0.dataLayer:getPosition()

		arg_4_0.dataLayer:setPosition(var_4_2, var_4_3 + (arg_4_2 - arg_4_0.start_pos_y) * (1 - math.abs(var_4_3 / arg_4_0.touchRect.size.height)))
	end

	var_0_4.pos_x, var_0_4.pos_y = arg_4_0.start_pos_x, arg_4_0.start_pos_y
	arg_4_0.start_pos_x = arg_4_1
	arg_4_0.start_pos_y = arg_4_2
end

function var_0_3.onTouchEnded(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.holdOperator then
		return
	end

	local var_5_0, var_5_1 = arg_5_0.dataLayer:getPosition()

	if arg_5_0.moveHori then
		local var_5_2 = false

		if var_5_0 > arg_5_0.viewRect.size.width * var_0_0 then
			if arg_5_0.limiteHori(arg_5_0.targetLH, true) then
				arg_5_0:moveHorizontal(true, false)
			else
				arg_5_0:moveReturn()
			end
		elseif var_5_0 < -arg_5_0.viewRect.size.width * var_0_0 then
			if arg_5_0.limiteHori(arg_5_0.targetLH, false) then
				arg_5_0:moveHorizontal(false, false)
			else
				arg_5_0:moveReturn()
			end
		elseif var_0_4.pos_x - arg_5_1 < -var_0_1 then
			if arg_5_0.limiteHori(arg_5_0.targetLH, true) then
				arg_5_0:moveHorizontal(true, false)
			else
				arg_5_0:moveReturn()
			end
		elseif var_0_4.pos_x - arg_5_1 > var_0_1 then
			if arg_5_0.limiteHori(arg_5_0.targetLH, false) then
				arg_5_0:moveHorizontal(false, false)
			else
				arg_5_0:moveReturn()
			end
		else
			arg_5_0:moveReturn()
		end
	elseif arg_5_0.moveVert then
		if var_5_1 > arg_5_0.viewRect.size.height * var_0_0 then
			if arg_5_0.limiteVert(arg_5_0.targetLV, true) then
				arg_5_0:moveVertical(true, false)
			else
				arg_5_0:moveReturn()
			end
		elseif var_5_1 < -arg_5_0.viewRect.size.height * var_0_0 then
			if arg_5_0.limiteVert(arg_5_0.targetLV, false) then
				arg_5_0:moveVertical(false, false)
			else
				arg_5_0:moveReturn()
			end
		elseif var_0_4.pos_y - arg_5_2 < -var_0_1 then
			if arg_5_0.limiteVert(arg_5_0.targetLV, true) then
				arg_5_0:moveVertical(true, false)
			else
				arg_5_0:moveReturn()
			end
		elseif var_0_4.pos_y - arg_5_2 > var_0_1 then
			if arg_5_0.limiteVert(arg_5_0.targetLV, false) then
				arg_5_0:moveVertical(false, false)
			else
				arg_5_0:moveReturn()
			end
		else
			arg_5_0:moveReturn()
		end
	end
end

function var_0_3.moveHorizontal(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_2 then
		arg_6_0.holdOperator = true
	end

	arg_6_0.moveHori = true

	local var_6_0, var_6_1 = arg_6_0.dataLayer:getPosition()
	local var_6_2 = (arg_6_0.viewRect.size.width - math.abs(var_6_0)) / arg_6_0.viewRect.size.width * var_0_2
	local var_6_3 = CCArray:create()

	if arg_6_1 then
		var_6_3:addObject(CCMoveTo:create(var_6_2, CCPoint(arg_6_0.viewRect.size.width, 0)))
	else
		var_6_3:addObject(CCMoveTo:create(var_6_2, CCPoint(-arg_6_0.viewRect.size.width, 0)))
	end

	var_6_3:addObject(CCCallFunc:create(function()
		if arg_6_1 then
			arg_6_0.dataLayer:setPosition(-arg_6_0.viewRect.size.width, 0)
		else
			arg_6_0.dataLayer:setPosition(arg_6_0.viewRect.size.width, 0)
		end

		arg_6_0.actionHori(arg_6_0.tagetH, arg_6_1, arg_6_2)

		arg_6_0.holdOperator = true

		arg_6_0:moveReturn()
	end))
	arg_6_0.dataLayer:stopAllActions()
	arg_6_0.dataLayer:runAction(CCSequence:create(var_6_3))
end

function var_0_3.moveVertical(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 then
		arg_8_0.holdOperator = true
	end

	arg_8_0.moveVert = true

	local var_8_0, var_8_1 = arg_8_0.dataLayer:getPosition()
	local var_8_2 = (arg_8_0.viewRect.size.height - math.abs(var_8_1)) / arg_8_0.viewRect.size.height * var_0_2
	local var_8_3 = CCArray:create()

	if arg_8_1 then
		var_8_3:addObject(CCMoveTo:create(var_8_2, CCPoint(0, arg_8_0.viewRect.size.height)))
	else
		var_8_3:addObject(CCMoveTo:create(var_8_2, CCPoint(0, -arg_8_0.viewRect.size.height)))
	end

	var_8_3:addObject(CCCallFunc:create(function()
		if arg_8_1 then
			arg_8_0.dataLayer:setPosition(0, -arg_8_0.viewRect.size.height)
		else
			arg_8_0.dataLayer:setPosition(0, arg_8_0.viewRect.size.height)
		end

		arg_8_0.actionVert(arg_8_0.tagetV, arg_8_1, arg_8_2)

		arg_8_0.holdOperator = true

		arg_8_0:moveReturn()
	end))
	arg_8_0.dataLayer:stopAllActions()
	arg_8_0.dataLayer:runAction(CCSequence:create(var_8_3))
end

function var_0_3.moveReturn(arg_10_0)
	local var_10_0 = CCArray:create()

	var_10_0:addObject(CCMoveTo:create(var_0_2, CCPoint(0, 0)))
	var_10_0:addObject(CCCallFunc:create(function()
		arg_10_0.moveHori = false
		arg_10_0.moveVert = false
		arg_10_0.holdOperator = false
	end))
	arg_10_0.dataLayer:stopAllActions()
	arg_10_0.dataLayer:runAction(CCSequence:create(var_10_0))
end

function var_0_3.setMoveVertical(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.actionVert = arg_12_2
	arg_12_0.tagetV = arg_12_1
end

function var_0_3.setMoveHorizontal(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.actionHori = arg_13_2
	arg_13_0.tagetH = arg_13_1
end

function var_0_3.setLimiteVert(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.limiteVert = arg_14_2
	arg_14_0.targetLV = arg_14_1
end

function var_0_3.setLimiteHori(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.limiteHori = arg_15_2
	arg_15_0.targetLH = arg_15_1
end

function var_0_3.init(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_1.origin.x = arg_16_1.origin.x - arg_16_1.size.width / 2
	arg_16_1.origin.y = arg_16_1.origin.y - arg_16_1.size.height / 2
	arg_16_1.size.width = arg_16_1.size.width * Adapter.MinScale
	arg_16_1.size.height = arg_16_1.size.height * Adapter.MinScale
	arg_16_0.moveType = arg_16_3
	arg_16_0.viewRect = arg_16_1
	arg_16_0.moveHori = false
	arg_16_0.moveVert = false
	arg_16_0.dataLayer = arg_16_2

	local function var_16_0(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == "began" then
			return arg_16_0:onTouchBegan(arg_17_1, arg_17_2)
		elseif arg_17_0 == "moved" then
			arg_16_0:onTouchMoved(arg_17_1, arg_17_2)
		elseif arg_17_0 == "ended" then
			arg_16_0:onTouchEnded(arg_17_1, arg_17_2)
		end
	end

	arg_16_0:addTouchEventListener(var_16_0, false, -128, false)
	arg_16_0:setTouchEnabled(true)

	local var_16_1 = CCClippingRegionNode:create(arg_16_1)

	var_16_1:setPosition(0, 0)
	arg_16_0:addChild(var_16_1)
	var_16_1:addChild(arg_16_0.dataLayer)
	arg_16_0.dataLayer:setPosition(CCPoint(0, 0))

	arg_16_1.size.width = arg_16_1.size.width / Adapter.MinScale
	arg_16_1.size.height = arg_16_1.size.height / Adapter.MinScale
	arg_16_0.viewRect.origin.x = arg_16_0.viewRect.origin.x + arg_16_1.size.width / 2
	arg_16_0.viewRect.origin.y = arg_16_0.viewRect.origin.y + arg_16_1.size.height / 2
end

return var_0_3
