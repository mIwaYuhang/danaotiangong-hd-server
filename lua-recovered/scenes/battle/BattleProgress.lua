require("scenes.battle.BattleData")

progress_scale = 1.5

local var_0_0 = 1
local var_0_1 = class("BattleProgress", function()
	return display.newLayer()
end)

local function var_0_2(arg_2_0)
	if arg_2_0 < 7 and arg_2_0 > 0 then
		return 7
	end

	return arg_2_0
end

function var_0_1.ctor(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.heroList = arg_3_1
	arg_3_0.enemyList = arg_3_2
	arg_3_0.BatchNode = nil
	arg_3_0.uiLayer = arg_3_3
end

function barScale(arg_4_0)
	return 1
end

function updateBattleProgressScale(arg_5_0)
	return originalScale() * progress_scale / ignoreSetupScale(arg_5_0.figureSize)
end

function var_0_1.bindHero(arg_6_0)
	table.foreach(arg_6_0.heroList, function(arg_7_0, arg_7_1)
		if not arg_7_1.progressNode then
			local var_7_0 = BattleData:findTarget(arg_7_1.idx)
			local var_7_1 = CCNode:create()
			local var_7_2 = 10
			local var_7_3 = CCSprite:create("ui/battle/bg_battle_progressBg.png")

			var_7_3:setScaleY(barScale(arg_7_1))
			var_7_3:setPosition(var_7_2, 0)
			var_7_1:addChild(var_7_3, 1)

			local var_7_4 = CCSprite:create(getProfessionIconImageName(BattleData:getProfession(arg_7_1.idx)))

			var_7_4:setPosition(-35, 0)
			var_7_1:addChild(var_7_4, 0)

			arg_7_1.healthBar_current, arg_7_1.healthBar_count = arg_6_0:viewHp(var_7_1, var_7_0.currentHealth, var_7_0.maxHealth, barScale(arg_7_1), var_7_2)
			arg_7_1.rageBar = arg_6_0:viewRage(var_7_1, var_7_0.rage, barScale(arg_7_1), var_7_2)
			arg_7_1.name = arg_6_0:viewName(var_7_1, BaseHeros[var_7_0.heroId], arg_7_1)

			if testHPview then
				arg_7_1.hpview = arg_6_0:viewHpNumber(var_7_1, var_7_0.currentHealth, var_7_0.maxHealth)
			end

			var_7_1:setPosition(0, 360)
			var_7_1:setScale(updateBattleProgressScale(arg_7_1))
			arg_7_1:addChild(var_7_1, 1)

			arg_7_1.progressNode = var_7_1

			local var_7_5 = createParticleEffect("ui/battle/BattleParticle/fullRage.plist", CCPoint(0, 0 + 0 * Adapter.MinScale), nil)

			var_7_5:setScale(1 / arg_7_1:getScale())
			orderScale(var_7_5, BattleData:getPosition(arg_7_1.idx))
			arg_7_1:addChild(var_7_5, 1)

			arg_7_1.rageBar.particle = var_7_5

			arg_7_1.rageBar.particle:stopSystem()

			if not arg_6_0.BatchNode then
				arg_6_0.BatchNode = CCParticleBatchNode:createWithTexture(var_7_5:getTexture())

				arg_7_1:getParent():addChild(arg_6_0.BatchNode)
				arg_6_0.BatchNode:insertChild(var_7_5, 0)
			else
				arg_6_0.BatchNode:insertChild(var_7_5, 0)
			end
		end
	end)
end

function var_0_1.bindEnemy(arg_8_0)
	table.foreach(arg_8_0.enemyList, function(arg_9_0, arg_9_1)
		local var_9_0 = BattleData:findTarget(arg_9_1.idx)
		local var_9_1 = CCNode:create()
		local var_9_2 = 10
		local var_9_3 = CCSprite:create("ui/battle/bg_battle_progressBg.png")

		var_9_3:setScaleY(barScale(arg_9_1))
		var_9_3:setPosition(var_9_2, 0)
		var_9_1:addChild(var_9_3, 1)

		local var_9_4 = CCSprite:create(getProfessionIconImageName(BattleData:getProfession(arg_9_1.idx)))

		var_9_4:setPosition(-35, 0)
		var_9_1:addChild(var_9_4, 0)

		arg_9_1.healthBar_current, arg_9_1.healthBar_count = arg_8_0:viewHp(var_9_1, var_9_0.currentHealth, var_9_0.maxHealth, barScale(arg_9_1), var_9_2)
		arg_9_1.rageBar = arg_8_0:viewRage(var_9_1, var_9_0.rage, barScale(arg_9_1), var_9_2)

		if var_9_0.heroId then
			arg_9_1.name = arg_8_0:viewName(var_9_1, BaseHeros[var_9_0.heroId], arg_9_1)
		else
			arg_9_1.name = arg_8_0:viewName(var_9_1, BaseNPCs[var_9_0.npcId], arg_9_1)
		end

		if testHPview then
			arg_9_1.hpview = arg_8_0:viewHpNumber(var_9_1, var_9_0.currentHealth, var_9_0.maxHealth)
		end

		var_9_1:setPosition(0, 360)
		arg_9_1:addChild(var_9_1, 1)
		var_9_1:setScale(updateBattleProgressScale(arg_9_1))

		arg_9_1.progressNode = var_9_1

		local var_9_5 = createParticleEffect("ui/battle/BattleParticle/fullRage.plist", CCPoint(0, 0 + 0 * Adapter.MinScale), nil)

		var_9_5:setScale(1 / arg_9_1:getScale())
		orderScale(var_9_5, BattleData:getPosition(arg_9_1.idx))
		arg_9_1:addChild(var_9_5, 1)

		arg_9_1.rageBar.particle = var_9_5

		arg_9_1.rageBar.particle:stopSystem()

		if not arg_8_0.BatchNode then
			arg_8_0.BatchNode = CCParticleBatchNode:createWithTexture(var_9_5:getTexture())

			arg_9_1:getParent():addChild(arg_8_0.BatchNode)
			arg_8_0.BatchNode:insertChild(var_9_5, 0)
		else
			arg_8_0.BatchNode:insertChild(var_9_5, 0)
		end
	end)
end

function var_0_1.ProgressActionHP(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = BattleData:getDisplayNode(arg_10_2)

	arg_10_0:viewLabelAction(var_10_0, arg_10_3, arg_10_4, arg_10_1)

	if not arg_10_3 or arg_10_3 == 0 then
		return true
	end

	local var_10_1 = BattleData:findTarget(arg_10_2)
	local var_10_2 = BattleData:addHealth(var_10_1.battleIx, arg_10_3)
	local var_10_3 = var_10_1.currentHealth / var_10_1.maxHealth * 100

	var_10_0.healthBar_current:setPercentage(var_0_2(var_10_3))

	if testHPview then
		arg_10_0:viewHpNumber(var_10_0, var_10_1.currentHealth, var_10_1.maxHealth)
	end

	arg_10_0.uiLayer:refreshProgress()

	return var_10_2
end

function var_0_1.ProgressSetHP(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = BattleData:getDisplayNode(arg_11_1)

	arg_11_0:viewLabelAction(var_11_0, arg_11_2, arg_11_3)

	if not arg_11_2 or arg_11_2 == 0 then
		return true
	end

	local var_11_1 = BattleData:findTarget(arg_11_1)
	local var_11_2 = BattleData:setHealth(var_11_1.battleIx, arg_11_2)
	local var_11_3 = var_11_1.currentHealth / var_11_1.maxHealth * 100

	var_11_0.healthBar_current:setPercentage(var_0_2(var_11_3))

	if testHPview then
		arg_11_0:viewHpNumber(var_11_0, var_11_1.currentHealth, var_11_1.maxHealth)
	end

	arg_11_0.uiLayer:refreshProgress()

	return var_11_2
end

function var_0_1.viewHpAction(arg_12_0, arg_12_1)
	local var_12_0 = BattleData:findTarget(arg_12_1)
	local var_12_1 = BattleData:getDisplayNode(arg_12_1)
	local var_12_2 = CCArray:create()
	local var_12_3 = var_12_1.healthBar_count:getPercentage()
	local var_12_4 = var_12_0.currentHealth / var_12_0.maxHealth * 100

	var_12_2:addObject(CCProgressFromTo:create(1 * BattleSpeed, var_12_3, var_0_2(var_12_4)))
	var_12_1.healthBar_count:runAction(CCSequence:create(var_12_2))

	local var_12_5 = CCArray:create()
	local var_12_6 = var_12_1.healthBar_current:getPercentage()
	local var_12_7 = var_12_0.currentHealth / var_12_0.maxHealth * 100

	var_12_5:addObject(CCProgressFromTo:create(1 * BattleSpeed, var_12_6, var_0_2(var_12_7)))
	var_12_1.healthBar_current:runAction(CCSequence:create(var_12_5))
end

function var_0_1.updateProgress(arg_13_0, arg_13_1)
	arg_13_0:viewRageAction(arg_13_1)
	arg_13_0:viewHpAction(arg_13_1)

	if testHPview then
		local var_13_0 = BattleData:getDisplayNode(arg_13_1)
		local var_13_1 = BattleData:findTarget(arg_13_1)

		arg_13_0:viewHpNumber(var_13_0, var_13_1.currentHealth, var_13_1.maxHealth)
	end

	arg_13_0.uiLayer:refreshProgress()
end

function var_0_1.ProgressActionRage(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = BattleData:findTarget(arg_14_1)
	local var_14_1 = BattleData:getDisplayNode(arg_14_1)

	arg_14_0:viewRageBarAction(var_14_0, var_14_1, arg_14_2)

	if arg_14_2 ~= 0 and arg_14_3 then
		local var_14_2

		if arg_14_2 > 0 then
			BattleAudio:Sound_playEffect(BattleAudio.status_rage_up)

			var_14_2 = "buff_nuqi_jia"
		else
			BattleAudio:Sound_playEffect(BattleAudio.status_rage_down)

			var_14_2 = "buff_nuqi_jian"
		end

		local var_14_3 = BattleData:getDisplayNode(arg_14_1)
		local var_14_4 = "buff_nuqi"
		local var_14_5 = originalScale() * 1.5
		local var_14_6 = ccp(0, 160)
		local var_14_7

		var_14_7 = BattleSkeleton:addEffect({
			parent = var_14_3,
			effectName = var_14_4,
			position = var_14_6,
			callbacklist = {
				function()
					var_14_7:removeFromParentAndCleanup(true)
				end,
				1,
				AAT_Percent
			},
			scale = var_14_5,
			animation = var_14_2
		})
	end
end

function var_0_1.viewHp(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	local var_16_0 = CCSprite:create("ui/battle/bar_battle_health_second.png")
	local var_16_1 = CCProgressTimer:create(var_16_0)

	var_16_1:setType(kCCProgressTimerTypeBar)
	var_16_1:setMidpoint(CCPoint(0, 0))
	var_16_1:setBarChangeRate(CCPoint(1, 0))
	var_16_1:setPercentage(var_0_2(arg_16_2 / arg_16_3 * 100))
	var_16_1:setPosition(arg_16_5, 3)
	var_16_1:setScaleY(arg_16_4)
	arg_16_1:addChild(var_16_1)

	var_16_1.pic = var_16_0

	local var_16_2 = CCSprite:create("ui/battle/bar_battle_health.png")
	local var_16_3 = CCProgressTimer:create(var_16_2)

	var_16_3:setType(kCCProgressTimerTypeBar)
	var_16_3:setMidpoint(CCPoint(0, 0))
	var_16_3:setBarChangeRate(CCPoint(1, 0))
	var_16_3:setPercentage(var_0_2(arg_16_2 / arg_16_3 * 100))
	var_16_3:setPosition(arg_16_5, 3)
	var_16_3:setScaleY(arg_16_4)
	arg_16_1:addChild(var_16_3)

	var_16_3.pic = var_16_2

	return var_16_3, var_16_1
end

function var_0_1.viewRage(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	if arg_17_2 > 100 then
		local var_17_0 = CCSprite:create("ui/battle/bar_battle_rage1.png")
		local var_17_1 = CCProgressTimer:create(var_17_0)

		var_17_1:setType(kCCProgressTimerTypeBar)
		var_17_1:setMidpoint(CCPoint(0, 0))
		var_17_1:setBarChangeRate(CCPoint(1, 0))
		var_17_1:setPercentage(100)
		var_17_1:setPosition(arg_17_4, -3)
		var_17_1:setScaleY(arg_17_3)
		arg_17_1:addChild(var_17_1)

		arg_17_1.bar1 = var_17_1

		local var_17_2 = CCSprite:create("ui/battle/bar_battle_rage2.png")
		local var_17_3 = CCProgressTimer:create(var_17_2)

		var_17_3:setType(kCCProgressTimerTypeBar)
		var_17_3:setMidpoint(CCPoint(0, 0))
		var_17_3:setBarChangeRate(CCPoint(1, 0))
		var_17_3:setPercentage(arg_17_2 - 100)
		var_17_3:setPosition(arg_17_4, -3)
		var_17_3:setScaleY(arg_17_3)
		arg_17_1:addChild(var_17_3)

		arg_17_1.bar2 = var_17_3
	else
		local var_17_4 = CCSprite:create("ui/battle/bar_battle_rage1.png")
		local var_17_5 = CCProgressTimer:create(var_17_4)

		var_17_5:setType(kCCProgressTimerTypeBar)
		var_17_5:setMidpoint(CCPoint(0, 0))
		var_17_5:setBarChangeRate(CCPoint(1, 0))
		var_17_5:setPercentage(arg_17_2)
		var_17_5:setPosition(arg_17_4, -3)
		var_17_5:setScaleY(arg_17_3)
		arg_17_1:addChild(var_17_5)

		arg_17_1.bar1 = var_17_5

		local var_17_6 = CCSprite:create("ui/battle/bar_battle_rage2.png")
		local var_17_7 = CCProgressTimer:create(var_17_6)

		var_17_7:setType(kCCProgressTimerTypeBar)
		var_17_7:setMidpoint(CCPoint(0, 0))
		var_17_7:setBarChangeRate(CCPoint(1, 0))
		var_17_7:setPercentage(0)
		var_17_7:setPosition(arg_17_4, -3)
		var_17_7:setScaleY(arg_17_3)
		arg_17_1:addChild(var_17_7)

		arg_17_1.bar2 = var_17_7
	end

	return arg_17_1
end

function var_0_1.viewRageBarAction(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if not arg_18_3 or arg_18_3 == 0 then
		return
	end

	BattleData:addRage(arg_18_1.battleIx, arg_18_3)
	arg_18_0:viewRageAction(arg_18_1.battleIx)
end

function var_0_1.viewRageAction(arg_19_0, arg_19_1)
	local var_19_0 = BattleData:getDisplayNode(arg_19_1)
	local var_19_1 = var_19_0.rageBar.bar1:getPercentage() + var_19_0.rageBar.bar2:getPercentage()
	local var_19_2 = BattleData:findTarget(arg_19_1).rage

	if var_19_1 >= 100 and var_19_2 >= 100 then
		local var_19_3 = CCProgressFromTo:create(1 * BattleSpeed, var_19_1 - 100, var_19_2 - 100)

		var_19_0.rageBar.bar2:runAction(var_19_3)
	elseif var_19_1 <= 100 and var_19_2 <= 100 then
		local var_19_4 = CCProgressFromTo:create(1 * BattleSpeed, var_19_1, var_19_2)

		var_19_0.rageBar.bar1:runAction(var_19_4)
	elseif var_19_1 <= 100 and var_19_2 > 100 then
		local var_19_5 = CCArray:create()

		var_19_5:addObject(CCProgressFromTo:create(0.5 * BattleSpeed, var_19_1, 100))
		var_19_5:addObject(CCCallFunc:create(function()
			local var_20_0 = CCProgressFromTo:create(0.5 * BattleSpeed, 0, var_19_2 - 100)

			var_19_0.rageBar.bar2:runAction(var_20_0)
		end))
		var_19_0.rageBar.bar1:runAction(CCSequence:create(var_19_5))
	elseif var_19_1 > 100 and var_19_2 <= 100 then
		local var_19_6 = CCArray:create()

		var_19_6:addObject(CCProgressFromTo:create(0.5 * BattleSpeed, var_19_1 - 100, 0))
		var_19_6:addObject(CCCallFunc:create(function()
			local var_21_0 = CCProgressFromTo:create(0.5 * BattleSpeed, 100, var_19_2)

			var_19_0.rageBar.bar1:runAction(var_21_0)
		end))
		var_19_0.rageBar.bar2:runAction(CCSequence:create(var_19_6))
	end

	if var_19_2 >= 100 then
		var_19_0.rageBar.particle:resetSystem()
	else
		var_19_0.rageBar.particle:stopSystem()
	end
end

function var_0_1.viewMaxHpAction(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_2 and arg_22_2 ~= 0 then
		local var_22_0 = BattleData:findTarget(arg_22_1)
		local var_22_1 = BattleData:getDisplayNode(arg_22_1)

		BattleData:addMaxHp(arg_22_1, arg_22_2)
		var_22_1.healthBar_count:setPercentage(var_0_2(var_22_0.currentHealth / var_22_0.maxHealth * 100))
		var_22_1.healthBar_current:setPercentage(var_0_2(var_22_0.currentHealth / var_22_0.maxHealth * 100))

		if testHPview then
			arg_22_0:viewHpNumber(var_22_1, var_22_0.currentHealth, var_22_0.maxHealth)
		end
	end
end

function var_0_1.viewLabelAction(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = 0

	if arg_23_4 then
		var_23_0 = BattleData:checkRestrain(arg_23_4, arg_23_1.idx)
	end

	arg_23_3 = arg_23_3 or BattleEffectType.eNormal

	local var_23_1 = CCNode:create()
	local var_23_2

	if arg_23_3 == BattleEffectType.eNormal then
		var_23_2 = CCNode:create()

		var_23_1:setPosition(0, 60 * var_0_0)
	elseif arg_23_3 == BattleEffectType.eBaoJi then
		var_23_2 = CCSprite:create("uilocal/battle/battle_text_009.png")

		var_23_2:setScale(var_0_0)

		if arg_23_2 and arg_23_2 ~= 0 then
			var_23_1:setPosition(0, 80 * var_0_0)
		end
	elseif arg_23_3 == BattleEffectType.eGeDang then
		var_23_2 = CCSprite:create("uilocal/battle/battle_text_007.png")

		var_23_2:setScale(var_0_0)

		if arg_23_2 and arg_23_2 ~= 0 then
			var_23_1:setPosition(0, 55 * var_0_0)
		end
	elseif arg_23_3 == BattleEffectType.eShanBi then
		var_23_2 = CCSprite:create("uilocal/battle/battle_text_008.png")

		var_23_2:setScale(var_0_0)
		var_23_1:setPosition(0, 20 * var_0_0)
	else
		dump("----------没有该类型------------", arg_23_3)
	end

	var_23_1:addChild(var_23_2)

	if arg_23_1.talentEffectAction then
		arg_23_1.talentEffectAction = false

		local var_23_3, var_23_4 = var_23_1:getPosition()

		var_23_1:setPosition(var_23_3, var_23_4 + 35 * var_0_0)
	end

	local var_23_5

	if arg_23_2 and arg_23_2 ~= 0 then
		if arg_23_2 > 0 then
			var_23_5 = CCLabelAtlas:create("." .. arg_23_2, "uilocal/battle/battle_text_011.png", 34, 55, 46)
		elseif var_23_0 <= 0 then
			var_23_5 = CCLabelAtlas:create("/" .. -arg_23_2, "uilocal/battle/battle_text_010.png", 34, 55, 46)
		else
			var_23_5 = CCLabelAtlas:create("/" .. -arg_23_2 .. ":", "uilocal/battle/battle_text_173.png", 34, 55, 46)

			local var_23_6 = CCSprite:create("uilocal/battle/battle_text_176.png")

			var_23_6:setPosition(-55, 30)
			var_23_5:addChild(var_23_6)

			local var_23_7 = CCArray:create()

			var_23_7:addObject(CCDelayTime:create(0.7 * BattleSpeed))
			var_23_7:addObject(CCFadeOut:create(0.4 * BattleSpeed))
			var_23_6:runAction(CCSequence:create(var_23_7))
		end

		var_23_5:setAnchorPoint(CCPoint(0.5, 0.5))

		if var_23_0 and var_23_0 > 0 then
			var_23_5:setPosition(60, -50)
		else
			var_23_5:setPosition(0, -50)
		end

		var_23_5:setScale(0.8 * var_0_0)
		var_23_1:addChild(var_23_5)
	end

	if arg_23_2 and arg_23_2 > 0 then
		local var_23_8 = createParticleEffect("ui/battle/BattleParticle/jiaxue.plist", CCPoint(0, 0 + 0 * Adapter.MinScale), arg_23_1)
		local var_23_9 = CCArray:create()

		var_23_9:addObject(CCDelayTime:create(1.7 * BattleSpeed))
		var_23_9:addObject(CCCallFunc:create(function()
			var_23_8:stopSystem()
		end))
		var_23_9:addObject(CCDelayTime:create(2 * BattleSpeed))
		var_23_9:addObject(CCCallFunc:create(function()
			var_23_8:removeFromParentAndCleanup(true)
		end))
		var_23_8:runAction(CCSequence:create(var_23_9))
	end

	arg_23_1.progressNode:addChild(var_23_1)
	var_23_1:setAnchorPoint(CCPoint(0.5, 0.5))
	var_23_1:setScale(0.1)

	local var_23_10 = CCArray:create()

	var_23_10:addObject(CCDelayTime:create(0.7 * BattleSpeed))
	var_23_10:addObject(CCCallFunc:create(function()
		var_23_2:runAction(CCFadeOut:create(0.4 * BattleSpeed))

		if var_23_5 then
			var_23_5:runAction(CCFadeOut:create(0.4 * BattleSpeed))
		end
	end))
	var_23_10:addObject(CCFadeOut:create(0.4 * BattleSpeed))
	var_23_10:addObject(CCCallFunc:create(function()
		var_23_1:removeFromParentAndCleanup(true)
	end))
	var_23_1:runAction(CCSequence:create(var_23_10))
	var_23_1:runAction(CCMoveBy:create(1 * BattleSpeed, CCPoint(0, 30)))

	if arg_23_3 == BattleEffectType.eBaoJi then
		var_23_1:setScale(1.2)
	else
		var_23_1:setScale(0.8)
	end
end

function var_0_1.viewName(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = arg_28_3.viewParam.rebirthCount
	local var_28_1

	if var_28_0 == 0 then
		var_28_1 = arg_28_2.name
	else
		var_28_1 = arg_28_2.name .. "+" .. var_28_0
	end

	local var_28_2 = 2
	local var_28_3 = ui.newTTFLabelWithOutline({
		text = var_28_1,
		font = _FONT_LISU,
		size = Adapter.FontSize(10) * var_28_2,
		align = ui.TEXT_ALIGN_CENTER
	})

	arg_28_1:addChild(var_28_3)

	if testHPview then
		var_28_3:setPosition(0, 40)
	else
		var_28_3:setPosition(0, 20)
	end

	var_28_3:setVisible(false)
	var_28_3:setColor(getQualityColor(arg_28_2.quality))

	return var_28_3
end

function formatViewHp(arg_29_0, arg_29_1)
	local var_29_0 = ""

	if arg_29_0 < 10000 then
		var_29_0 = var_29_0 .. arg_29_0
	else
		var_29_0 = var_29_0 .. string.lf("%.1f万", arg_29_0 / 10000)
	end

	local var_29_1 = var_29_0 .. "/"

	if arg_29_1 < 10000 then
		var_29_1 = var_29_1 .. arg_29_1
	else
		var_29_1 = var_29_1 .. string.lf("%.1f万", arg_29_1 / 10000)
	end

	return var_29_1
end

function var_0_1.viewHpNumber(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = formatViewHp(arg_30_2, arg_30_3)

	if not arg_30_1.hpview then
		local var_30_1 = 2
		local var_30_2 = ui.newTTFLabelWithOutline({
			text = var_30_0,
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(10) * var_30_1,
			align = ui.TEXT_ALIGN_CENTER
		})

		arg_30_1:addChild(var_30_2)
		var_30_2:setPosition(0, 20)
		var_30_2:setVisible(false)

		arg_30_1.hpview = var_30_2

		return var_30_2
	else
		arg_30_1.hpview:setString(var_30_0)
	end
end

local var_0_3 = Player.level * 100
local var_0_4 = 1
local var_0_5 = 8

function var_0_1.dealStandardHP(arg_31_0)
	local var_31_0 = 0
	local var_31_1 = 0

	for iter_31_0, iter_31_1 in pairs(BattleData.Heros) do
		if var_31_0 == 0 then
			var_31_0 = iter_31_1.maxHealth
		end

		if var_31_1 == 0 then
			var_31_1 = iter_31_1.maxHealth
		end

		if var_31_0 < iter_31_1.maxHealth then
			var_31_0 = iter_31_1.maxHealth
		end

		if var_31_1 > iter_31_1.maxHealth then
			var_31_1 = iter_31_1.maxHealth
		end
	end

	for iter_31_2, iter_31_3 in pairs(BattleData.enemy) do
		if var_31_0 < iter_31_3.maxHealth then
			var_31_0 = iter_31_3.maxHealth
		end

		if var_31_1 > iter_31_3.maxHealth then
			var_31_1 = iter_31_3.maxHealth
		end
	end

	local var_31_2 = math.ceil(var_31_0 / var_31_1)

	if var_31_2 >= var_0_4 and var_31_2 <= var_0_5 then
		if var_31_1 >= var_0_3 then
			local var_31_3 = 1

			while true do
				local var_31_4 = math.ceil(var_31_0 / (var_0_3 * var_31_3))

				if var_31_4 >= var_0_4 and var_31_4 <= var_0_5 then
					return var_0_3 * var_31_3
				else
					var_31_3 = var_31_3 + 1
				end
			end
		else
			return var_31_1
		end
	else
		return math.ceil(var_31_0 / var_0_5)
	end
end

function var_0_1.numberOfDisplay(arg_32_0, arg_32_1, arg_32_2)
	return math.ceil(arg_32_2 / arg_32_1)
end

return var_0_1
