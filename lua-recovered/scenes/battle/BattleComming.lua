require("scenes.battle.BattleEffectLayer")
require("scenes.battle.BattleBGAnimation")

BattleComming = {}

local var_0_0 = -200 * Adapter.HeightScale
local var_0_1 = 200 * Adapter.HeightScale
local var_0_2 = 600 * Adapter.HeightScale
local var_0_3 = 0.3333333333333333

local function var_0_4(arg_1_0, arg_1_1, arg_1_2)
	return arg_1_0 + (arg_1_1 - arg_1_2 / 2 - 0.5) * 30
end

local var_0_5 = 1
local var_0_6 = 2

function BattleComming.init(arg_2_0, arg_2_1, arg_2_2)
	if BattleSpeed ~= BattleSpeedOriginal then
		var_0_2 = 800 * Adapter.HeightScale
		var_0_3 = 0.25
	end

	arg_2_0.layer = arg_2_1
	arg_2_0.params = arg_2_2
	arg_2_0.bgTag = 1
	arg_2_0.bgTotal = 1
	arg_2_0.bg_sprite = nil
	arg_2_0.bg_nextSprite = nil
	arg_2_0.bg_spriteNext = nil
	arg_2_0.bg_callback = nil
	arg_2_0.stopAnim = 0

	arg_2_0:countTotalScene()

	arg_2_0.bg_sprite = arg_2_0:createBackGroundPic1()
end

function BattleComming.beforeBattleComming(arg_3_0, arg_3_1)
	if BattleData.stage == 0 and arg_3_0.params.comming.playerComming then
		arg_3_1()
	else
		arg_3_1()
	end
end

local var_0_7 = 1136 * Adapter.HeightScale

function BattleComming.afterBattleRequest(arg_4_0, arg_4_1)
	arg_4_0.bg_callback = arg_4_1

	if BattleData.stage == 1 then
		arg_4_0:firstEnemyComming()
		arg_4_0:newFinish()

		return
	end

	local var_4_0 = arg_4_0:displayCarrier(arg_4_0.params.comming.playerComming, var_0_5)

	arg_4_0.layer:addChild(var_4_0, SceneZorder.eBackGroundAnimation)
	var_4_0:setScale(Adapter.MinScale)
	var_4_0:setPosition(var_0_0, display.cy)

	local var_4_1 = CCArray:create()

	var_4_1:addObject(CCEaseSineInOut:create(CCMoveBy:create(var_0_3, CCPoint(0, 20 * Adapter.MinScale))))
	var_4_1:addObject(CCEaseSineInOut:create(CCMoveBy:create(var_0_3, CCPoint(0, -20 * Adapter.MinScale))))
	var_4_0:runAction(CCRepeatForever:create(CCSequence:create(var_4_1)))

	local var_4_2 = CCArray:create()

	var_4_2:addObject(CCMoveTo:create((var_0_1 - var_0_0) / var_0_2, CCPoint(var_0_1, display.cy)))
	var_4_2:addObject(CCCallFunc:create(function()
		arg_4_0.layer.dragLayer:runAction(CCMoveTo:create((display.cx - var_0_1) / var_0_2, CCPoint(display.cx - var_0_1, 0)))
		table.foreach(arg_4_0.layer.heroList, function(arg_6_0, arg_6_1)
			local var_6_0 = CCArray:create()

			var_6_0:addObject(CCEaseSineInOut:create(CCMoveBy:create(var_0_3, CCPoint(0, 20 * Adapter.MinScale))))
			var_6_0:addObject(CCEaseSineInOut:create(CCMoveBy:create(var_0_3, CCPoint(0, -20 * Adapter.MinScale))))

			local var_6_1 = CCRepeatForever:create(CCSequence:create(var_6_0))

			var_6_1:setTag(11123)
			arg_6_1:runAction(var_6_1)
		end)
	end))
	var_4_2:addObject(CCMoveTo:create((display.cx - var_0_1) / var_0_2, CCPoint(display.cx, display.cy)))
	var_4_2:addObject(CCCallFunc:create(function()
		arg_4_0:onSwitchScene(var_4_0)
	end))
	var_4_0:runAction(CCSequence:create(var_4_2))

	local var_4_3 = 1

	table.foreach(arg_4_0.layer.heroList, function(arg_8_0, arg_8_1)
		arg_8_1:runAction(CCJumpTo:create((var_0_1 - var_0_0) / var_0_2, CCPoint(var_0_4(225, var_4_3, table.nums(arg_4_0.layer.heroList)) * Adapter.HeightScale, display.cy), display.cy, 1))
		arg_8_1:runAction(CCScaleTo:create((var_0_1 - var_0_0) / var_0_2, arg_8_1.order_scale_order * orderScale_num(ccp(0, 100))))

		var_4_3 = var_4_3 + 1
	end)
end

function BattleComming.countTotalScene(arg_9_0)
	arg_9_0.totalBg = {}

	if arg_9_0.params.battleBG.circlePic then
		for iter_9_0, iter_9_1 in pairs(arg_9_0.params.battleBG.circlePic) do
			table.insert(arg_9_0.totalBg, iter_9_1)
		end
	end

	if arg_9_0.params.battleBG.finalPic then
		table.insert(arg_9_0.totalBg, arg_9_0.params.battleBG.finalPic)
	end
end

function BattleComming.createBackGroundPic1(arg_10_0, ...)
	if not arg_10_0.totalBg[arg_10_0.bgTag] then
		arg_10_0.bgTag = 1
	end

	local var_10_0 = CCSprite:create(arg_10_0.totalBg[arg_10_0.bgTag])

	arg_10_0.bgTag = arg_10_0.bgTag + 1

	var_10_0:setPosition(0, display.cy)
	var_10_0:setAnchorPoint(CCPoint(0, 0.5))
	var_10_0:setScale(Adapter.HeightScale)
	arg_10_0.layer:addChild(var_10_0, SceneZorder.eBackGroundPic)

	return var_10_0
end

function BattleComming.onSwitchScene(arg_11_0, arg_11_1)
	local var_11_0, var_11_1 = arg_11_0.bg_sprite:getPosition()
	local var_11_2 = CCArray:create()

	var_11_2:addObject(CCMoveTo:create(var_0_7 / var_0_2, CCPoint(-var_0_7, var_11_1)))
	var_11_2:addObject(CCCallFunc:create(function()
		return
	end))
	arg_11_0.bg_sprite:runAction(CCSequence:create(var_11_2))

	arg_11_0.bg_nextSprite = arg_11_0:createBackGroundPic1()

	arg_11_0.bg_nextSprite:setPosition(CCPoint(var_0_7, var_11_1))

	local var_11_3 = CCArray:create()

	var_11_3:addObject(CCMoveTo:create(var_0_7 / var_0_2, CCPoint(0, var_11_1)))
	var_11_3:addObject(CCCallFunc:create(function()
		return
	end))
	arg_11_0.bg_nextSprite:runAction(CCSequence:create(var_11_3))

	local var_11_4 = CCArray:create()

	var_11_4:addObject(CCDelayTime:create((var_0_7 - display.cx + var_0_1) / var_0_2))
	var_11_4:addObject(CCCallFunc:create(function(...)
		arg_11_0.layer.dragLayer:runAction(CCMoveTo:create((display.cx - var_0_1) / var_0_2, CCPoint(0, 0)))
		arg_11_0:enemyComming()
	end))
	var_11_4:addObject(CCMoveTo:create((display.cx - var_0_1) / var_0_2, CCPoint(var_0_1, display.cy)))
	var_11_4:addObject(CCCallFunc:create(function()
		arg_11_0.layer.dragLayer:stopAllActions()
		arg_11_0.layer.dragLayer:setPosition(0, 0)
		table.foreach(arg_11_0.layer.heroList, function(arg_16_0, arg_16_1)
			arg_16_1:stopActionByTag(11123)
			arg_16_1:runAction(CCJumpTo:create((var_0_1 - var_0_0) / var_0_2, BattleData:getPosition(arg_16_1.idx), display.cy, 1))
			arg_16_1:runAction(CCScaleTo:create((var_0_1 - var_0_0) / var_0_2, arg_16_1.order_scale_order * orderScale_num(BattleData:getPosition(arg_16_1.idx))))
		end)
		arg_11_1:getParent():reorderChild(arg_11_1, SceneZorder.eBattleEffect)
		arg_11_1:runAction(CCMoveBy:create((var_0_1 - var_0_0) / var_0_2, CCPoint(2000 * Adapter.MinScale, 0)))
	end))
	var_11_4:addObject(CCDelayTime:create((var_0_1 - var_0_0) / var_0_2))
	var_11_4:addObject(CCCallFunc:create(function(...)
		if arg_11_0.bg_nextSprite then
			arg_11_0.bg_sprite:removeFromParentAndCleanup()

			arg_11_0.bg_sprite = arg_11_0.bg_nextSprite
		end

		arg_11_0:newFinish()
	end))
	arg_11_1:runAction(CCSequence:create(var_11_4))
end

function BattleComming.newFinish(arg_18_0, ...)
	arg_18_0.bg_callback()
end

function BattleComming.battleBeforeBegin(arg_19_0, arg_19_1)
	local var_19_0 = 1

	for iter_19_0, iter_19_1 in pairs(arg_19_0.layer.heroList) do
		iter_19_1:setVisible(true)
		iter_19_1:setPosition(CCPoint(var_0_4(-500, var_19_0, table.nums(arg_19_0.layer.heroList)) * Adapter.HeightScale, display.cy))
		iter_19_1:runAction(CCMoveBy:create(700 * Adapter.MinScale / var_0_2, CCPoint(700 * Adapter.MinScale, 0)))

		var_19_0 = var_19_0 + 1

		local var_19_1 = CCArray:create()

		var_19_1:addObject(CCEaseSineInOut:create(CCMoveBy:create(var_0_3, CCPoint(0, 20 * Adapter.MinScale))))
		var_19_1:addObject(CCEaseSineInOut:create(CCMoveBy:create(var_0_3, CCPoint(0, -20 * Adapter.MinScale))))
		iter_19_1:runAction(CCRepeatForever:create(CCSequence:create(var_19_1)))
	end

	local var_19_2 = arg_19_0:displayCarrier(BattleCarrier.eNone, var_0_5)

	arg_19_0.layer:addChild(var_19_2, SceneZorder.eBackGroundAnimation)
	var_19_2:setScale(Adapter.MinScale)
	var_19_2:setPosition(Adapter.HeightScale * -550, display.cy)

	local var_19_3 = CCArray:create()

	var_19_3:addObject(CCEaseSineInOut:create(CCMoveBy:create(var_0_3, CCPoint(0, 20 * Adapter.MinScale))))
	var_19_3:addObject(CCEaseSineInOut:create(CCMoveBy:create(var_0_3, CCPoint(0, -20 * Adapter.MinScale))))
	var_19_2:runAction(CCRepeatForever:create(CCSequence:create(var_19_3)))

	local var_19_4 = CCArray:create()

	var_19_4:addObject(CCMoveBy:create(700 * Adapter.MinScale / var_0_2, CCPoint(700 * Adapter.MinScale, 0)))
	var_19_4:addObject(CCCallFunc:create(function()
		for iter_20_0, iter_20_1 in pairs(arg_19_0.layer.heroList) do
			iter_20_1:stopAllActions()
			iter_20_1:runAction(CCJumpTo:create(1, BattleData:getPosition(iter_20_1.idx), display.cy, 1))
			iter_20_1:runAction(CCScaleTo:create(1, iter_20_1.order_scale_order * orderScale_num(BattleData:getPosition(iter_20_1.idx))))
		end

		var_19_2:getParent():reorderChild(var_19_2, SceneZorder.eBattleEffect)
	end))
	var_19_4:addObject(CCMoveTo:create(1, CCPoint(2000 * Adapter.MinScale, display.cy)))
	var_19_4:addObject(CCCallFunc:create(arg_19_1))
	var_19_4:addObject(CCCallFunc:create(function(...)
		var_19_2:removeFromParentAndCleanup(true)
	end))
	var_19_2:runAction(CCSequence:create(var_19_4))
end

function BattleComming.firstEnemyComming(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0.layer.enemyList) do
		iter_22_1.Skeleton:setOpacity(0)
		iter_22_1.Skeleton:runAction(CCFadeIn:create(0.8 * BattleSpeed))

		if iter_22_1.wing then
			iter_22_1.wing:runAction(CCFadeIn:create(0.8 * BattleSpeed))
		end
	end
end

function BattleComming.enemyComming(arg_23_0, arg_23_1, arg_23_2)
	arg_23_2 = arg_23_2 or function(...)
		return
	end

	if arg_23_0.params.comming.enemyComming then
		local var_23_0 = 1

		table.foreach(arg_23_0.layer.enemyList, function(arg_25_0, arg_25_1)
			arg_25_1:setVisible(true)
			arg_25_1:setPosition(CCPoint(var_0_4(1200, var_23_0, table.nums(arg_23_0.layer.enemyList)) * Adapter.HeightScale, display.cy))
			arg_25_1:runAction(CCMoveBy:create(500 * Adapter.MinScale / var_0_2, CCPoint(-500 * Adapter.MinScale, 0)))

			var_23_0 = var_23_0 + 1

			local var_25_0 = CCArray:create()

			var_25_0:addObject(CCEaseSineInOut:create(CCMoveBy:create(var_0_3, CCPoint(0, 20 * Adapter.MinScale))))
			var_25_0:addObject(CCEaseSineInOut:create(CCMoveBy:create(var_0_3, CCPoint(0, -20 * Adapter.MinScale))))
			arg_25_1:runAction(CCRepeatForever:create(CCSequence:create(var_25_0)))
		end)

		local var_23_1 = arg_23_0:displayCarrier(arg_23_0.params.comming.enemyComming, var_0_6)

		arg_23_0.layer:addChild(var_23_1, SceneZorder.eBackGroundAnimation)
		var_23_1:setRotationY(-180)
		var_23_1:setScale(Adapter.MinScale)
		var_23_1:setPosition(Adapter.HeightScale * 1200, display.cy)

		local var_23_2 = CCArray:create()

		var_23_2:addObject(CCEaseSineInOut:create(CCMoveBy:create(var_0_3, CCPoint(0, 20 * Adapter.MinScale))))
		var_23_2:addObject(CCEaseSineInOut:create(CCMoveBy:create(var_0_3, CCPoint(0, -20 * Adapter.MinScale))))
		var_23_1:runAction(CCRepeatForever:create(CCSequence:create(var_23_2)))

		local var_23_3 = CCArray:create()

		var_23_3:addObject(CCMoveBy:create(500 * Adapter.MinScale / var_0_2, CCPoint(-500 * Adapter.MinScale, 0)))
		var_23_3:addObject(CCCallFunc:create(function()
			table.foreach(arg_23_0.layer.enemyList, function(arg_27_0, arg_27_1)
				arg_27_1:stopAllActions()
				arg_27_1:runAction(CCJumpTo:create(1, BattleData:getPosition(arg_27_1.idx), display.cy, 1))
				arg_27_1:runAction(CCScaleTo:create(1, arg_27_1.order_scale_order * orderScale_num(BattleData:getPosition(arg_27_1.idx))))
			end)
			var_23_1:getParent():reorderChild(var_23_1, SceneZorder.eBattleEffect)
		end))
		var_23_3:addObject(CCMoveTo:create(1, CCPoint(-800 * Adapter.MinScale, display.cy)))
		var_23_3:addObject(CCCallFunc:create(arg_23_2))
		var_23_3:addObject(CCCallFunc:create(function(...)
			var_23_1:removeFromParentAndCleanup(true)
		end))
		var_23_1:runAction(CCSequence:create(var_23_3))
	else
		table.foreach(arg_23_0.layer.enemyList, function(arg_29_0, arg_29_1)
			arg_29_1:setVisible(arg_23_1)

			if not arg_23_0.params.comming.playerComming then
				arg_29_1.Skeleton:setOpacity(0)
				arg_29_1.Skeleton:runAction(CCFadeIn:create(0.5))
			end
		end)

		local var_23_4 = CCArray:create()

		var_23_4:addObject(CCDelayTime:create(0.5))
		var_23_4:addObject(CCCallFunc:create(arg_23_2))
		CCDirector:sharedDirector():getRunningScene():runAction(CCSequence:create(var_23_4))
	end
end

function BattleComming.displayCarrier(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = CCNode:create()
	local var_30_1 = queryCarrierFile(arg_30_1)
	local var_30_2 = CCSprite:create(var_30_1)

	if arg_30_1 == BattleCarrier.eBajiaoshan1 then
		if arg_30_2 == var_0_5 then
			var_30_2:setPosition(0, -30)
		else
			var_30_2:setPosition(-40, 0)
		end
	elseif arg_30_1 == BattleCarrier.eBajiaoshan2 then
		if arg_30_2 == var_0_5 then
			var_30_2:setPosition(-70, 0)
		else
			var_30_2:setPosition(-100, 0)
		end
	elseif arg_30_1 == BattleCarrier.eHulu1 then
		if arg_30_2 == var_0_5 then
			var_30_2:setPosition(20, -30)
		else
			var_30_2:setPosition(-40, -30)
		end
	elseif arg_30_1 == BattleCarrier.eHulu2 then
		if arg_30_2 == var_0_5 then
			var_30_2:setPosition(-100, -60)
		else
			var_30_2:setPosition(-180, -60)
		end
	elseif arg_30_1 == BattleCarrier.eJian1 then
		if arg_30_2 == var_0_5 then
			var_30_2:setPosition(0, 0)
		else
			var_30_2:setPosition(-40, 0)
		end
	elseif arg_30_1 == BattleCarrier.eJian2 then
		if arg_30_2 == var_0_5 then
			var_30_2:setPosition(-50, 0)
		else
			var_30_2:setPosition(-60, 0)
		end
	elseif arg_30_1 == BattleCarrier.eYujingping1 then
		if arg_30_2 == var_0_5 then
			var_30_2:setPosition(30, -30)
		else
			var_30_2:setPosition(-30, -30)
		end
	elseif arg_30_1 == BattleCarrier.eYujingping2 then
		if arg_30_2 == var_0_5 then
			var_30_2:setPosition(0, -60)
		else
			var_30_2:setPosition(-90, -60)
		end
	elseif arg_30_1 == BattleCarrier.eYuruyi1 then
		if arg_30_2 == var_0_5 then
			var_30_2:setPosition(0, -30)
		else
			var_30_2:setPosition(-30, -30)
		end
	elseif arg_30_1 == BattleCarrier.eYuruyi2 then
		if arg_30_2 == var_0_5 then
			var_30_2:setPosition(0, -10)
		else
			var_30_2:setPosition(-60, -10)
		end
	elseif arg_30_2 == var_0_5 then
		var_30_2:setPosition(0, 0)
	else
		var_30_2:setPosition(-40, 0)
	end

	var_30_0:addChild(var_30_2)

	local var_30_3 = Adapter.MinScale

	return var_30_0
end

function BattleComming.guiderComming(arg_31_0, arg_31_1)
	local var_31_0 = 1

	for iter_31_0, iter_31_1 in pairs(arg_31_0.layer.heroList) do
		if iter_31_1.idx ~= 2 then
			iter_31_1:setVisible(true)
			iter_31_1:setPosition(CCPoint(var_0_4(-500, var_31_0, table.nums(arg_31_0.layer.heroList)) * Adapter.HeightScale, display.cy))
			iter_31_1:runAction(CCMoveBy:create(700 * Adapter.MinScale / var_0_2, CCPoint(700 * Adapter.MinScale, 0)))

			var_31_0 = var_31_0 + 1

			local var_31_1 = CCArray:create()

			var_31_1:addObject(CCEaseSineInOut:create(CCMoveBy:create(var_0_3, CCPoint(0, 20 * Adapter.MinScale))))
			var_31_1:addObject(CCEaseSineInOut:create(CCMoveBy:create(var_0_3, CCPoint(0, -20 * Adapter.MinScale))))
			iter_31_1:runAction(CCRepeatForever:create(CCSequence:create(var_31_1)))
		end

		iter_31_1:setTouchFalse()
	end

	local var_31_2 = arg_31_0:displayCarrier(BattleCarrier.eNone, var_0_5)

	arg_31_0.layer:addChild(var_31_2, SceneZorder.eBackGroundAnimation)
	var_31_2:setScale(Adapter.MinScale)
	var_31_2:setPosition(Adapter.HeightScale * -550, display.cy)

	local var_31_3 = CCArray:create()

	var_31_3:addObject(CCEaseSineInOut:create(CCMoveBy:create(var_0_3, CCPoint(0, 20 * Adapter.MinScale))))
	var_31_3:addObject(CCEaseSineInOut:create(CCMoveBy:create(var_0_3, CCPoint(0, -20 * Adapter.MinScale))))
	var_31_2:runAction(CCRepeatForever:create(CCSequence:create(var_31_3)))

	local var_31_4 = CCArray:create()

	var_31_4:addObject(CCMoveBy:create(700 * Adapter.MinScale / var_0_2, CCPoint(700 * Adapter.MinScale, 0)))
	var_31_4:addObject(CCCallFunc:create(function()
		for iter_32_0, iter_32_1 in pairs(arg_31_0.layer.heroList) do
			if iter_32_1.idx ~= 2 then
				iter_32_1:stopAllActions()
				iter_32_1:runAction(CCJumpTo:create(1, BattleData:getPosition(iter_32_1.idx), display.cy, 1))
				iter_32_1:runAction(CCScaleTo:create(1, iter_32_1.order_scale_order * orderScale_num(BattleData:getPosition(iter_32_1.idx))))
			end
		end

		var_31_2:getParent():reorderChild(var_31_2, SceneZorder.eBattleEffect)
	end))
	var_31_4:addObject(CCMoveTo:create(1, CCPoint(2000 * Adapter.MinScale, display.cy)))
	var_31_4:addObject(CCCallFunc:create(arg_31_1))
	var_31_4:addObject(CCCallFunc:create(function(...)
		var_31_2:removeFromParentAndCleanup(true)
	end))
	var_31_2:runAction(CCSequence:create(var_31_4))
end

function BattleComming.guiderOut(arg_34_0)
	for iter_34_0, iter_34_1 in pairs(arg_34_0.layer.enemyList) do
		iter_34_1:runAction(CCJumpTo:create(0.5, ccp(1700 * Adapter.HeightScale, 400 * Adapter.HeightScale), display.cy, 1))
	end
end
