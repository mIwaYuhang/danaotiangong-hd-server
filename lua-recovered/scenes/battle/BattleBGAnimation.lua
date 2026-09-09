BattleBGAnimation = {}

local var_0_0 = 40

function BattleBGAnimation.midLayer_area(arg_1_0)
	return {
		ccp(0, 320),
		ccp(960, 0)
	}
end

function BattleBGAnimation.backLayer_area(arg_2_0)
	return {
		ccp(0, 640),
		ccp(960, 320)
	}
end

function BattleBGAnimation.frontLayer_area(arg_3_0)
	return {
		ccp(0, 0),
		ccp(960, 480)
	}
end

function BattleBGAnimation.randPos(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1[1]
	local var_4_1 = arg_4_1[2]
	local var_4_2 = math.random(var_4_0.x, var_4_1.x)
	local var_4_3 = math.random(var_4_0.y, var_4_1.y)

	return ccp(var_4_2, var_4_3)
end

local var_0_1 = 100 * Adapter.AutoScaleX

function BattleBGAnimation.moveing(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = math.random(0, 1)
	local var_5_1

	if var_5_0 >= 0.5 then
		arg_5_1:setPosition(arg_5_3.x - var_0_1, arg_5_2 * Adapter.AutoScaleY)
		arg_5_1:setRotationY(0)

		var_5_1 = ccp(arg_5_3.x + var_0_1 + display.width, arg_5_2 * Adapter.AutoScaleY)
	else
		arg_5_1:setPosition(arg_5_3.x + display.width + var_0_1, arg_5_2 * Adapter.AutoScaleY)
		arg_5_1:setRotationY(180)

		var_5_1 = ccp(arg_5_3.x - var_0_1, arg_5_2 * Adapter.AutoScaleY)
	end

	local var_5_2 = math.random(5, 10)
	local var_5_3 = CCArray:create()

	var_5_3:addObject(CCMoveTo:create(var_0_0 * (var_5_2 / 10), var_5_1))
	var_5_3:addObject(CCCallFunc:create(function()
		arg_5_1:removeFromParentAndCleanup(true)
	end))
	arg_5_1:runAction(CCSequence:create(var_5_3))

	local var_5_4 = CCArray:create()

	var_5_4:addObject(CCFadeIn:create(0.2))
	var_5_4:addObject(CCDelayTime:create(var_0_0 * (var_5_2 / 10) - 0.4))
	var_5_4:addObject(CCFadeOut:create(0.2))
	arg_5_1:runAction(CCSequence:create(var_5_4))
	arg_5_1:setScale(Adapter.MinScale * 2 * math.random(5, 10) / 10)
end

function BattleBGAnimation.stay(arg_7_0, arg_7_1, arg_7_2)
	arg_7_1:setPosition(Adapter.AutoPos(arg_7_2.x, arg_7_2.y))
	arg_7_1:setScale(Adapter.MinScale * 2 * math.random(5, 10) / 10)
end

local function var_0_2(arg_8_0, arg_8_1)
	if arg_8_1.y < BattleData.pos_Hero[1].y and arg_8_1.y >= BattleData.pos_Hero[2].y then
		arg_8_0:getParent():reorderChild(arg_8_0, 0)
	elseif arg_8_1.y < BattleData.pos_Hero[2].y and arg_8_1.y >= BattleData.pos_Hero[3].y then
		arg_8_0:getParent():reorderChild(arg_8_0, 1)
	elseif arg_8_1.y <= BattleData.pos_Hero[3].y then
		arg_8_0:getParent():reorderChild(arg_8_0, 2)
	else
		arg_8_0:getParent():reorderChild(arg_8_0, -1)
	end
end

function BattleBGAnimation.createAnimation(arg_9_0, arg_9_1)
	if #arg_9_1 == 0 then
		dump("-------BUG---------")
	elseif #arg_9_1 == 1 then
		local var_9_0 = CCSprite:create(arg_9_1[1])

		var_9_0:setAnchorPoint(ccp(0.5, 0))

		return var_9_0
	else
		local var_9_1 = CCAnimation:create()

		for iter_9_0, iter_9_1 in pairs(arg_9_1) do
			var_9_1:addSpriteFrameWithFileName(iter_9_1)
		end

		var_9_1:setDelayPerUnit(0.3)

		local var_9_2 = CCSprite:create(arg_9_1[1])

		var_9_2:runAction(CCRepeatForever:create(CCAnimate:create(var_9_1)))
		var_9_2:setAnchorPoint(ccp(0.5, 0))

		return var_9_2
	end
end

local var_0_3 = 15
local var_0_4 = 5

function BattleBGAnimation.createManager(arg_10_0, arg_10_1)
	arg_10_0.deltaTime = arg_10_0.deltaTime + arg_10_1

	if arg_10_0.deltaTime >= var_0_3 + var_0_4 then
		if arg_10_0.deltaTime >= var_0_3 + var_0_4 + var_0_4 then
			if math.random(0, 1) >= 0.5 then
				arg_10_0.deltaTime = 0

				return true
			else
				arg_10_0.deltaTime = var_0_3 + var_0_4
			end
		end
	elseif arg_10_0.deltaTime >= var_0_3 then
		if math.random(0, 1) >= 0.5 then
			arg_10_0.deltaTime = 0

			return true
		else
			arg_10_0.deltaTime = var_0_3 + var_0_4
		end
	end

	return false
end

function BattleBGAnimation.init(arg_11_0, arg_11_1, arg_11_2)
	if testBGA then
		arg_11_0.weatherLayer = arg_11_2
		arg_11_1.backAnimationLayer = CCNode:create()

		arg_11_1:addChild(arg_11_1.backAnimationLayer, SceneZorder.eBackGroundAnimation)

		arg_11_1.frontAnimationLayer = CCNode:create()

		arg_11_1:addChild(arg_11_1.frontAnimationLayer, SceneZorder.eBattleFront)

		arg_11_0.frontAnimationLayer = arg_11_1.frontAnimationLayer
		arg_11_0.backAnimationLayer = arg_11_1.backAnimationLayer
		arg_11_0.deltaTime = 0

		local function var_11_0(arg_12_0)
			if arg_11_0:createManager(arg_12_0) then
				if math.random(0, 1) >= 0.5 then
					BattleBGAnimation:backAnimation()
				else
					BattleBGAnimation:frontAnimation()
				end
			end
		end

		arg_11_1.backAnimationLayer:scheduleUpdate(var_11_0)
	end
end

function BattleBGAnimation.backAnimation(arg_13_0)
	if testBGA then
		if arg_13_0.weatherLayer and not arg_13_0.weatherLayer:isAllowAnim() then
			return
		end

		local var_13_0 = arg_13_0.backAnimationLayer
		local var_13_1 = arg_13_0:randPos(arg_13_0.backLayer_area())
		local var_13_2 = arg_13_0:createAnimation({
			"ui/battle/cloud.png"
		})

		var_13_0:addChild(var_13_2)

		local var_13_3, var_13_4 = arg_13_0.backAnimationLayer:getPosition()

		arg_13_0:moveing(var_13_2, var_13_1.y, ccp(-var_13_3, var_13_4))
	end
end

function BattleBGAnimation.frontAnimation(arg_14_0)
	if testBGA then
		if arg_14_0.weatherLayer and not arg_14_0.weatherLayer:isAllowAnim() then
			return
		end

		local var_14_0 = arg_14_0.frontAnimationLayer
		local var_14_1 = arg_14_0:randPos(arg_14_0.frontLayer_area())
		local var_14_2 = arg_14_0:createAnimation({
			"ui/battle/cloud.png"
		})

		var_14_0:addChild(var_14_2)

		local var_14_3, var_14_4 = arg_14_0.backAnimationLayer:getPosition()

		arg_14_0:moveing(var_14_2, var_14_1.y, ccp(-var_14_3, var_14_4))
	end
end

function BattleBGAnimation.clear(arg_15_0, arg_15_1)
	if testBGA then
		local var_15_0 = {}
		local var_15_1 = arg_15_1:getChildren()

		if var_15_1 then
			for iter_15_0 = 0, var_15_1:count() - 1 do
				local var_15_2 = var_15_1:objectAtIndex(iter_15_0)
				local var_15_3, var_15_4 = var_15_2:getPosition()
				local var_15_5, var_15_6 = arg_15_1:getPosition()

				if var_15_3 < -var_15_5 or var_15_3 > -var_15_5 + display.width then
					table.insert(var_15_0, var_15_2)
				end
			end
		end

		for iter_15_1, iter_15_2 in pairs(var_15_0) do
			iter_15_2:removeFromParentAndCleanup(true)
		end
	end
end
