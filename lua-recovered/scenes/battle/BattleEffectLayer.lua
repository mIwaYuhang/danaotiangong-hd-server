require("scenes.battle.BattleData")
require("scenes.battle.EffectConfig")

local var_0_0 = 40
local var_0_1 = class("BattleEffectLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

function shakeVertical(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_2 or 0.04

	if arg_2_0.shakePos then
		-- block empty
	else
		local var_2_1, var_2_2 = arg_2_0:getPosition()

		arg_2_0.shakePos = ccp(var_2_1, var_2_2)
	end

	arg_2_0:stopActionByTag(1123)

	local var_2_3 = CCArray:create()
	local var_2_4 = math.random(0, 1) == 0 and -1 or 1
	local var_2_5 = math.random(-10, 10) / 20

	var_2_3:addObject(CCMoveTo:create(var_2_0 * BattleSpeed, CCPoint(arg_2_0.shakePos.x + var_2_5 * arg_2_1, arg_2_0.shakePos.y + arg_2_1 * var_2_4)))
	var_2_3:addObject(CCMoveTo:create(var_2_0 * BattleSpeed / 2, CCPoint(arg_2_0.shakePos.x, arg_2_0.shakePos.y)))
	var_2_3:addObject(CCCallFunc:create(function()
		arg_2_0.shakePos = nil
	end))

	local var_2_6 = CCSequence:create(var_2_3)

	var_2_6:setTag(1123)
	arg_2_0:runAction(var_2_6)
end

function shakeHorizontal(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_2 or 0.04

	if arg_4_0.shakePos then
		-- block empty
	else
		local var_4_1, var_4_2 = arg_4_0:getPosition()

		arg_4_0.shakePos = ccp(var_4_1, var_4_2)
	end

	arg_4_0:stopActionByTag(1123)

	local var_4_3 = CCArray:create()
	local var_4_4 = math.random(0, 1) == 0 and -1 or 1
	local var_4_5 = math.random(-10, 10) / 20

	var_4_3:addObject(CCMoveTo:create(var_4_0 * BattleSpeed, CCPoint(arg_4_0.shakePos.x + arg_4_1 * var_4_4, arg_4_0.shakePos.y + var_4_5 * arg_4_1)))
	var_4_3:addObject(CCMoveTo:create(var_4_0 * BattleSpeed / 2, CCPoint(arg_4_0.shakePos.x, arg_4_0.shakePos.y)))
	var_4_3:addObject(CCCallFunc:create(function()
		arg_4_0.shakePos = nil
	end))

	local var_4_6 = CCSequence:create(var_4_3)

	var_4_6:setTag(1123)
	arg_4_0:runAction(var_4_6)
end

function shakeVertical_allways(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_2 or 0.04
	local var_6_1 = CCArray:create()

	var_6_1:addObject(CCMoveBy:create(var_6_0 * BattleSpeed, CCPoint(0, arg_6_1)))
	var_6_1:addObject(CCMoveBy:create(var_6_0 * 2 * BattleSpeed, CCPoint(0, -arg_6_1 * 2)))
	var_6_1:addObject(CCMoveBy:create(var_6_0 * BattleSpeed, CCPoint(0, arg_6_1)))

	local var_6_2 = CCRepeatForever:create(CCSequence:create(var_6_1))

	var_6_2:setTag(1111333)
	arg_6_0:runAction(var_6_2)
end

function shakeHorizontal_allways(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2 or 0.04
	local var_7_1 = CCArray:create()

	var_7_1:addObject(CCMoveBy:create(var_7_0 * BattleSpeed, CCPoint(arg_7_1, 0)))
	var_7_1:addObject(CCMoveBy:create(var_7_0 * 2 * BattleSpeed, CCPoint(-arg_7_1 * 2, 0)))
	var_7_1:addObject(CCMoveBy:create(var_7_0 * BattleSpeed, CCPoint(arg_7_1, 0)))

	local var_7_2 = CCRepeatForever:create(CCSequence:create(var_7_1))

	var_7_2:setTag(1111333)
	arg_7_0:runAction(var_7_2)
end

function createParticleEffect(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = arg_8_3 and 1 or Adapter.MinScale
	local var_8_1 = CCParticleSystemQuad:create(arg_8_0)

	var_8_1:setStartSize(var_8_1:getStartSize() * originalScale() / 2 * var_8_0)
	var_8_1:setStartSizeVar(var_8_1:getStartSizeVar() * originalScale() / 2 * var_8_0)
	var_8_1:setEndSize(var_8_1:getEndSize() * originalScale() / 2 * var_8_0)
	var_8_1:setEndSizeVar(var_8_1:getEndSizeVar() * originalScale() / 2 * var_8_0)
	var_8_1:setSpeed(var_8_1:getSpeed() * originalScale() / 2 * var_8_0)
	var_8_1:setSpeedVar(var_8_1:getSpeedVar() * originalScale() / 2 * var_8_0)

	if var_8_1:getDuration() ~= -1 then
		var_8_1:setDuration(var_8_1:getDuration() * BattleSpeed)
	end

	local var_8_2 = var_8_1:getPosVar()

	var_8_1:setPosVar(ccp(var_8_2.x * originalScale() / 2 * var_8_0, var_8_2.y * originalScale() / 2 * var_8_0))

	if arg_8_2 then
		var_8_1:setScale(1 / arg_8_2:getScale())
		arg_8_2:addChild(var_8_1)
	end

	var_8_1:setPosition(arg_8_1)

	if not arg_8_4 then
		var_8_1:setPositionType(kCCPositionTypeRelative)
	end

	return var_8_1
end

function var_0_1.ctor(arg_9_0)
	arg_9_0:setNodeEventEnabled(true)
end

function var_0_1.querySkill(arg_10_0, arg_10_1)
	local var_10_0
	local var_10_1 = BattleData:findTarget(arg_10_1)

	if not var_10_1.skillId then
		if var_10_1.heroId then
			var_10_0 = BaseSkills[BaseHeros[var_10_1.heroId].skillId]
			var_10_0.id = BaseHeros[var_10_1.heroId].skillId
		else
			var_10_0 = BaseSkills[BaseNPCs[var_10_1.npcId].skillId]
			var_10_0.id = BaseNPCs[var_10_1.npcId].skillId
		end
	else
		var_10_0 = BaseSkills[var_10_1.skillId]
		var_10_0.id = var_10_1.skillId
	end

	return var_10_0
end

function var_0_1.queryTalent(arg_11_0, arg_11_1)
	local var_11_0 = BattleData:findTarget(arg_11_1)
	local var_11_1

	if not var_11_0.talentId then
		if var_11_0.heroId then
			var_11_1 = BaseSkills[BaseHeros[var_11_0.heroId].talentId]
			var_11_1.id = BaseHeros[var_11_0.heroId].talentId
		else
			var_11_1 = BaseSkills[BaseNPCs[var_11_0.npcId].talentId]
			var_11_1.id = BaseNPCs[var_11_0.npcId].talentId
		end
	else
		var_11_1 = BaseSkills[var_11_0.talentId]
		var_11_1.id = var_11_0.talentId
	end

	return var_11_1
end

function var_0_1.NormalAni1(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	table.insert(arg_12_3, function()
		local var_13_0
		local var_13_1 = arg_12_1 == BattleAttackType.eDaZhao and "faqi_pugong_01_new" or "faqi_pugong_02"

		table.foreach(arg_12_2.affectList, function(arg_14_0, arg_14_1)
			local var_14_0 = BattleData:getDisplayNode(arg_12_2.position)
			local var_14_1 = BattleData:getPosition(arg_12_2.position)
			local var_14_2 = BattleData:getPosition(arg_14_1.position)
			local var_14_3 = originalScale() * 1.2
			local var_14_4 = ccp(0, 100)
			local var_14_5

			var_14_5 = BattleSkeleton:addEffect({
				parent = BattleData:getDisplayNode(arg_14_1.position),
				effectName = var_13_1,
				position = var_14_4,
				callbacklist = {
					function()
						arg_12_5(arg_14_1, true)

						if arg_12_1 == BattleAttackType.eDaZhao then
							BattleAudio:Sound_playEffect(BattleAudio.action_fashi_pugong2)
						else
							BattleAudio:Sound_playEffect(BattleAudio.action_fashi_pugong1)
						end
					end,
					0,
					AAT_Percent,
					function()
						arg_12_4()
						var_14_5:removeFromParentAndCleanup(true)
					end,
					0.8,
					AAT_Percent
				},
				scale = var_14_3
			})
		end)
	end)
	table.insert(arg_12_3, 0)
	table.insert(arg_12_3, AAT_Percent)
end

function var_0_1.NormalAni(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	local var_17_0 = BattleData:getProfession(arg_17_2.position)

	table.insert(arg_17_3, function()
		table.foreach(arg_17_2.affectList, function(arg_19_0, arg_19_1)
			if BattleData:isTeam(arg_17_2.position, arg_19_1.position) then
				return
			end

			if arg_19_1.effect == BattleEffectType.eShanBi or arg_19_1.effect == BattleEffectType.eGeDang then
				if arg_19_1.effect == BattleEffectType.eShanBi then
					BattleAudio:Sound_playEffect(BattleAudio.action_shanbi)
				elseif arg_19_1.effect == BattleEffectType.eGeDang then
					BattleAudio:Sound_playEffect(BattleAudio.action_gedang)
				end
			elseif var_17_0 == HeroProfession.eCommander then
				if arg_17_1 == BattleAttackType.eDaZhao then
					BattleAudio:Sound_playEffect(BattleAudio.action_yushi_pugong2)
				elseif arg_17_1 == BattleAttackType.ePuTong then
					BattleAudio:Sound_playEffect(BattleAudio.action_yushi_pugong1)
				end
			elseif var_17_0 == HeroProfession.eWarrior then
				if arg_17_1 == BattleAttackType.eDaZhao then
					BattleAudio:Sound_playEffect(BattleAudio.action_zhanshen_pugong2)
				elseif arg_17_1 == BattleAttackType.ePuTong then
					BattleAudio:Sound_playEffect(BattleAudio.action_zhanshen_pugong1)
				end
			end

			if (arg_19_1.effect == BattleEffectType.eShanBi or arg_19_1.effect == BattleEffectType.eGeDang) and var_17_0 ~= HeroProfession.eMage then
				return
			end

			local var_19_0
			local var_19_1 = BattleData:findTarget(arg_17_2.position)
			local var_19_2 = ccp(BattleData:getPosition(arg_19_1.position).x, BattleData:getPosition(arg_19_1.position).y)
			local var_19_3 = BattleData:getDisplayNode(arg_17_2.position):getScale() * 2.5

			if var_17_0 == HeroProfession.eCommander then
				if arg_17_1 == BattleAttackType.eDaZhao then
					var_19_0 = "duanbing_pugong_02"
				elseif arg_17_1 == BattleAttackType.ePuTong then
					var_19_0 = "duanbing_pugong_01"
				end
			elseif var_17_0 == HeroProfession.eWarrior then
				if arg_17_1 == BattleAttackType.eDaZhao then
					var_19_0 = "changbing_pugong_02"
				elseif arg_17_1 == BattleAttackType.ePuTong then
					var_19_0 = "changbing_pugong_01"
				end
			elseif var_17_0 == HeroProfession.eMage then
				if arg_17_1 == BattleAttackType.eDaZhao then
					var_19_0 = "faqi_pugong_01"
				elseif arg_17_1 == BattleAttackType.ePuTong then
					var_19_0 = "faqi_pugong_01"
				end
			else
				var_19_0 = "changbing_pugong_01"
			end

			local var_19_4 = 1 * ignoreSetupScale(BattleData:getDisplayNode(arg_17_2.position).figureSize)

			if var_17_0 == HeroProfession.eCommander and arg_17_1 == BattleAttackType.ePuTong then
				var_19_2 = ccp(var_19_2.x + (var_19_1.isHero and -5 or 5) * Adapter.MinScale * orderScale_num(var_19_2), var_19_2.y + 60 * Adapter.MinScale * orderScale_num(var_19_2) * var_19_4)
			elseif var_17_0 == HeroProfession.eCommander and arg_17_1 == BattleAttackType.eDaZhao then
				var_19_2 = ccp(var_19_2.x + (var_19_1.isHero and 15 or -15) * Adapter.MinScale * orderScale_num(var_19_2), var_19_2.y + 140 * Adapter.MinScale * orderScale_num(var_19_2) * var_19_4)
			elseif var_17_0 == HeroProfession.eWarrior and arg_17_1 == BattleAttackType.ePuTong then
				var_19_2 = ccp(var_19_2.x + (var_19_1.isHero and 5 or -5) * Adapter.MinScale * orderScale_num(var_19_2), var_19_2.y + 60 * Adapter.MinScale * orderScale_num(var_19_2) * var_19_4)
			elseif var_17_0 == HeroProfession.eWarrior and arg_17_1 == BattleAttackType.eDaZhao then
				var_19_2 = ccp(var_19_2.x + (var_19_1.isHero and 10 or -10) * Adapter.MinScale * orderScale_num(var_19_2), var_19_2.y + 60 * Adapter.MinScale * orderScale_num(var_19_2) * var_19_4)
			else
				var_19_2 = ccp(var_19_2.x + (var_19_1.isHero and 15 or -15) * Adapter.MinScale * orderScale_num(var_19_2), var_19_2.y + 80 * Adapter.MinScale * orderScale_num(var_19_2) * var_19_4)
			end

			local var_19_5

			var_19_5 = BattleSkeleton:addEffect({
				parent = arg_17_0,
				effectName = var_19_0,
				position = var_19_2,
				callbacklist = {
					function()
						var_19_5:removeFromParentAndCleanup(true)
					end,
					1,
					AAT_Percent
				},
				scale = var_19_3
			})

			if not var_19_1.isHero then
				var_19_5:setRotationY(180)
			end
		end)
	end)

	local var_17_1 = 0

	if var_17_0 == HeroProfession.eCommander then
		if arg_17_1 == BattleAttackType.eDaZhao then
			var_17_1 = 0.5789473684210527
		elseif arg_17_1 == BattleAttackType.ePuTong then
			var_17_1 = 0.5714285714285714
		end
	elseif var_17_0 == HeroProfession.eWarrior then
		if arg_17_1 == BattleAttackType.eDaZhao then
			var_17_1 = 0.6666666666666666
		elseif arg_17_1 == BattleAttackType.ePuTong then
			var_17_1 = 0.43478260869565216
		end
	else
		var_17_1 = 0.2
	end

	table.insert(arg_17_3, var_17_1)
	table.insert(arg_17_3, AAT_Percent)
	table.insert(arg_17_3, function()
		table.foreach(arg_17_2.affectList, function(arg_22_0, arg_22_1)
			arg_17_5(arg_22_1, true)
		end)
	end)

	local var_17_2 = 0

	if var_17_0 == HeroProfession.eCommander then
		if arg_17_1 == BattleAttackType.eDaZhao then
			var_17_2 = 0.6842105263157895
		elseif arg_17_1 == BattleAttackType.ePuTong then
			var_17_2 = 0.6190476190476191
		end
	elseif var_17_0 == HeroProfession.eWarrior then
		if arg_17_1 == BattleAttackType.eDaZhao then
			var_17_2 = 0.7142857142857143
		elseif arg_17_1 == BattleAttackType.ePuTong then
			var_17_2 = 0.5217391304347826
		end
	else
		var_17_2 = 0.2
	end

	table.insert(arg_17_3, var_17_2)
	table.insert(arg_17_3, AAT_Percent)
	table.insert(arg_17_3, arg_17_4)
	table.insert(arg_17_3, 1)
	table.insert(arg_17_3, AAT_Percent)
end

function var_0_1.RageAni_first(arg_23_0, arg_23_1)
	local var_23_0
	local var_23_1 = BattleData:findTarget(arg_23_1)
	local var_23_2 = originalScale()

	if BattleData:getProfession(arg_23_1) == HeroProfession.eCommander then
		var_23_0 = "duanbing_yinchang"

		BattleAudio:Sound_playEffect(BattleAudio.action_yushi_chufa)

		var_23_2 = var_23_2 * 1.1
	elseif BattleData:getProfession(arg_23_1) == HeroProfession.eWarrior then
		var_23_0 = "changbing_chufa"

		BattleAudio:Sound_playEffect(BattleAudio.action_zhanshen_chufa)

		var_23_2 = var_23_2 * 2.5
	elseif BattleData:getProfession(arg_23_1) == HeroProfession.eMage then
		var_23_0 = "faqi_chufa"

		BattleAudio:Sound_playEffect(BattleAudio.action_fashi_chufa)

		var_23_2 = var_23_2 * 1
	end

	local var_23_3 = ccp(0, 150)
	local var_23_4

	var_23_4 = BattleSkeleton:addEffect({
		parent = BattleData:getDisplayNode(arg_23_1),
		effectName = var_23_0,
		position = var_23_3,
		callbacklist = {
			function()
				var_23_4:removeFromParentAndCleanup(true)
			end,
			1,
			AAT_Percent
		},
		scale = var_23_2
	})

	if not var_23_1.isHero then
		var_23_4:setRotationY(180)
	end
end

function var_0_1.RageAni_second(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5)
	if not arg_25_0.maskLayer then
		local var_25_0 = CCLayerColor:create()

		var_25_0:setOpacity(0)
		arg_25_0:getParent():addChild(var_25_0, SceneZorder.eBackGroundAnimation)

		arg_25_0.maskLayer = var_25_0
	end

	arg_25_0.maskLayer:runAction(CCFadeTo:create(0.2 * BattleSpeed, 191.25))

	local function var_25_1()
		local var_26_0 = CCArray:create()

		var_26_0:addObject(CCDelayTime:create(0.2 * BattleSpeed))
		var_26_0:addObject(CCCallFunc:create(function()
			local var_27_0

			if EffectConfig[arg_25_0:querySkill(arg_25_1.position).id] then
				var_27_0 = EffectConfig[arg_25_0:querySkill(arg_25_1.position).id]
			else
				local var_27_1 = 0

				for iter_27_0, iter_27_1 in pairs(EffectConfig) do
					var_27_1 = var_27_1 + 1
				end

				local var_27_2 = math.random(1, var_27_1)

				for iter_27_2, iter_27_3 in pairs(EffectConfig) do
					var_27_2 = var_27_2 - 1

					if var_27_2 == 0 then
						var_27_0 = iter_27_3

						break
					end
				end
			end

			if testSkill then
				var_27_0 = EffectConfig[testSkillId]
			end

			var_27_0(arg_25_1, arg_25_0, arg_25_4, function()
				arg_25_3(true)
				arg_25_0.maskLayer:runAction(CCFadeOut:create(0.2))
			end)
		end))
		arg_25_0.maskLayer:runAction(CCSequence:create(var_26_0))
	end

	table.insert(arg_25_2, function()
		local var_29_0 = BattleData:findTarget(arg_25_1.position)
		local var_29_1

		if var_29_0.heroId then
			var_29_1 = BaseHeros[var_29_0.heroId].quality
		else
			var_29_1 = BaseNPCs[var_29_0.npcId].quality
		end

		local var_29_2 = string.format("ui/battle/bg_skill_%d.png", var_29_1)
		local var_29_3 = CCSprite:create(var_29_2)

		var_29_3:setScale(display.width / 960)
		var_29_3:setPosition(Adapter.AutoPos(-960, 450))
		arg_25_0:addChild(var_29_3)

		local var_29_4 = CCArray:create()

		var_29_4:addObject(CCMoveTo:create(4 / var_0_0 * BattleSpeed, CCPoint(display.cx, 450 * Adapter.AutoScaleY)))
		var_29_4:addObject(CCDelayTime:create(24 / var_0_0 * BattleSpeed))
		var_29_4:addObject(CCFadeOut:create(5 / var_0_0 * BattleSpeed))
		var_29_4:addObject(CCCallFunc:create(function()
			var_29_3:removeFromParentAndCleanup(true)
		end))
		var_29_3:runAction(CCSequence:create(var_29_4))

		local var_29_5 = BattleSkeleton.copy(BattleData:getDisplayNode(arg_25_1.position), true)

		var_29_5:setPosition(Adapter.AutoPos(-760, 350))
		var_29_5:setScale(0.8 * Adapter.MinScale)
		arg_25_0:addChild(var_29_5)

		local var_29_6 = CCArray:create()

		var_29_6:addObject(CCDelayTime:create(4 / var_0_0 * BattleSpeed))
		var_29_6:addObject(CCMoveTo:create(3 / var_0_0 * BattleSpeed, Adapter.AutoPos(200, 350)))
		var_29_6:addObject(CCMoveBy:create(11 / var_0_0 * BattleSpeed, Adapter.AutoPos(20, 0)))
		var_29_6:addObject(CCCallFunc:create(function()
			var_29_5:runAction(CCMoveBy:create(18 / var_0_0 * BattleSpeed, Adapter.AutoPos(6.6, 0)))
			var_29_5.Skeleton:runAction(CCFadeOut:create(18 / var_0_0 * BattleSpeed))

			if var_29_5.wing then
				var_29_5.wing:runAction(CCFadeOut:create(18 / var_0_0 * BattleSpeed))
			end
		end))
		var_29_6:addObject(CCDelayTime:create(18 / var_0_0 * BattleSpeed))
		var_29_6:addObject(CCCallFunc:create(function()
			var_29_5:removeFromParentAndCleanup(true)
		end))
		var_29_5:runAction(CCSequence:create(var_29_6))

		local var_29_7 = CCSprite:create("ui/battle/bg_skill_01.png")

		var_29_7:setScale(Adapter.MinScale * 2)
		var_29_7:setPosition(Adapter.AutoPos(-960, 450))
		arg_25_0:addChild(var_29_7)

		local var_29_8 = CCArray:create()

		var_29_8:addObject(CCMoveTo:create(4 / var_0_0 * BattleSpeed, Adapter.AutoPos(200, 450)))
		var_29_8:addObject(CCMoveTo:create(22 / var_0_0 * BattleSpeed, Adapter.AutoPos(display.width, 450)))
		var_29_8:addObject(CCFadeOut:create(6 / var_0_0 * BattleSpeed))
		var_29_8:addObject(CCCallFunc:create(function()
			var_29_7:removeFromParentAndCleanup(true)
		end))
		var_29_7:runAction(CCSequence:create(var_29_8))

		local var_29_9 = CCSprite:create("uilocal/battle/" .. arg_25_0:querySkill(arg_25_1.position).skillNameImage)

		var_29_9:setScale(Adapter.MinScale)
		arg_25_0:addChild(var_29_9)
		var_29_9:setPosition(display.width, 450 * Adapter.AutoScaleY)

		local var_29_10 = CCArray:create()

		var_29_10:addObject(CCDelayTime:create(4 / var_0_0 * BattleSpeed))
		var_29_10:addObject(CCMoveTo:create(3 / var_0_0 * BattleSpeed, Adapter.AutoPos(660, 450)))
		var_29_10:addObject(CCMoveBy:create(19 / var_0_0 * BattleSpeed, Adapter.AutoPos(-20, 0)))
		var_29_10:addObject(CCCallFunc:create(function()
			var_29_9:runAction(CCFadeOut:create(6 / var_0_0 * BattleSpeed))
			var_29_9:runAction(CCMoveBy:create(6 / var_0_0 * BattleSpeed, Adapter.AutoPos(-9.473684210526315, 0)))
		end))
		var_29_10:addObject(CCDelayTime:create(6 / var_0_0 * BattleSpeed))
		var_29_10:addObject(CCCallFunc:create(function()
			var_29_9:removeFromParentAndCleanup(true)
		end))
		var_29_9:runAction(CCSequence:create(var_29_10))

		if not arg_25_5 then
			local var_29_11 = originalScale() * 0.7
			local var_29_12 = ccp(0, 210)
			local var_29_13 = BattleData:findTarget(arg_25_1.position)
			local var_29_14

			if BattleData:getProfession(arg_25_1.position) == HeroProfession.eCommander then
				var_29_14 = "teji_weapon"
				var_29_12 = ccp(0, 190)
			elseif BattleData:getProfession(arg_25_1.position) == HeroProfession.eWarrior then
				var_29_14 = "teji_longweapon"
			elseif BattleData:getProfession(arg_25_1.position) == HeroProfession.eMage then
				var_29_14 = "faqi_linghunchuqiao"
				var_29_11 = var_29_11 * 1.7
			end

			local var_29_15

			var_29_15 = BattleSkeleton:addEffect({
				parent = BattleData:getDisplayNode(arg_25_1.position),
				effectName = var_29_14,
				position = var_29_12,
				callbacklist = {
					function()
						var_29_15:removeFromParentAndCleanup(true)
					end,
					1,
					AAT_Percent
				},
				scale = var_29_11
			})

			if not var_29_13.isHero then
				var_29_15:setRotationY(180)
			end
		end
	end)
	table.insert(arg_25_2, 0)
	table.insert(arg_25_2, AAT_Percent)
	table.insert(arg_25_2, var_25_1)
	table.insert(arg_25_2, 0.7)
	table.insert(arg_25_2, AAT_Percent)
	table.insert(arg_25_2, function(...)
		arg_25_3(false)
	end)
	table.insert(arg_25_2, 1)
	table.insert(arg_25_2, AAT_Percent)
end

function var_0_1.talentAni(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4)
	table.insert(arg_38_2, function()
		local var_39_0 = BattleData:getDisplayNode(arg_38_1.position)

		arg_38_0:talentAniFirst(var_39_0)
	end)
	table.insert(arg_38_2, 0.2)
	table.insert(arg_38_2, AAT_Percent)
	table.insert(arg_38_2, function()
		table.foreach(arg_38_1.affectList, function(arg_41_0, arg_41_1)
			arg_38_4(arg_41_1, true)
		end)
	end)
	table.insert(arg_38_2, 0.3)
	table.insert(arg_38_2, AAT_Percent)
	table.insert(arg_38_2, arg_38_3)
	table.insert(arg_38_2, 1)
	table.insert(arg_38_2, AAT_Percent)
end

function var_0_1.talentAniFirst(arg_42_0, arg_42_1)
	local var_42_0 = CCSprite:create("uilocal/battle/" .. arg_42_0:queryTalent(arg_42_1.idx).skillNameImage)

	var_42_0:setScale(0.1)
	arg_42_1.progressNode:addChild(var_42_0)
	var_42_0:setOpacity(0)
	var_42_0:setPosition(CCPoint(0, 10))

	local var_42_1 = CCArray:create()

	var_42_1:addObject(CCFadeIn:create(0.3 * BattleSpeed))
	var_42_1:addObject(CCDelayTime:create(0.5 * BattleSpeed))
	var_42_1:addObject(CCFadeOut:create(0.3 * BattleSpeed))
	var_42_1:addObject(CCCallFunc:create(function()
		var_42_0:removeFromParentAndCleanup(true)

		arg_42_1.talentEffectAction = nil
	end))
	var_42_0:runAction(CCSequence:create(var_42_1))
	var_42_0:runAction(CCMoveBy:create(1 * BattleSpeed, CCPoint(0, 30)))

	arg_42_1.talentEffectAction = true

	var_42_0:runAction(CCEaseElasticOut:create(CCScaleTo:create(0.5 * BattleSpeed, 0.8)))

	if BattleData:findTarget(arg_42_1.idx).talentId == 10019 and arg_42_1.talentEffect then
		if not arg_42_1.talentEffect.ccount then
			arg_42_1.talentEffect.ccount = 0
		end

		if arg_42_1.talentEffect.ccount < 1 then
			-- block empty
		else
			arg_42_1.talentEffect:setOpacity(0)
		end

		arg_42_1.talentEffect.ccount = arg_42_1.talentEffect.ccount + 1
	end
end

function var_0_1.onExit(arg_44_0)
	if arg_44_0.maskLayer then
		arg_44_0.maskLayer:removeFromParentAndCleanup(true)

		arg_44_0.maskLayer = nil
	end
end

local function var_0_2(arg_45_0)
	if not arg_45_0.node or not arg_45_0.endPos then
		dump("--------ERROR------")

		return
	end

	local var_45_0, var_45_1 = arg_45_0.node:getPosition()
	local var_45_2 = 0

	local function var_45_3(arg_46_0)
		var_45_2 = var_45_2 + arg_46_0

		if var_45_2 >= arg_45_0.time then
			arg_45_0.node:unscheduleUpdate()
			arg_45_0.node:setPosition(arg_45_0.endPos())

			if arg_45_0.callback then
				arg_45_0.callback()
			end
		else
			local var_46_0 = (arg_45_0.endPos().x - var_45_0) / arg_45_0.time
			local var_46_1 = (arg_45_0.endPos().y - var_45_1 - 0.5 * arg_45_0.gravity * arg_45_0.time * arg_45_0.time) / arg_45_0.time
			local var_46_2 = var_46_0 * var_45_2
			local var_46_3 = var_46_1 * var_45_2 + 0.5 * arg_45_0.gravity * var_45_2 * var_45_2

			arg_45_0.node:setPosition(ccp(var_45_0 + var_46_2, var_45_1 + var_46_3))
		end
	end

	arg_45_0.node:scheduleUpdate(var_45_3)
end

function var_0_1.shenqiAniFirst(arg_47_0, arg_47_1, arg_47_2)
	arg_47_0:getParent().uiLayer:shenqiAnimation(arg_47_1, arg_47_2)
end

function var_0_1.shenqiAniSecond(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	if not arg_48_0.maskLayer then
		local var_48_0 = CCLayerColor:create()

		var_48_0:setOpacity(0)
		arg_48_0:getParent():addChild(var_48_0, SceneZorder.eBackGroundAnimation)

		arg_48_0.maskLayer = var_48_0
	end

	arg_48_0.maskLayer:runAction(CCFadeTo:create(0.2 * BattleSpeed, 191.25))

	local var_48_1 = arg_48_1.lv

	local function var_48_2()
		local var_49_0 = CCArray:create()

		var_49_0:addObject(CCDelayTime:create(0.2 * BattleSpeed))
		var_49_0:addObject(CCCallFunc:create(function()
			local var_50_0

			if var_48_1 == BattleCarrier.eYuruyi1 or var_48_1 == BattleCarrier.eYuruyi2 then
				var_50_0 = shenqiConfig[1]
			elseif var_48_1 == BattleCarrier.eJian1 or var_48_1 == BattleCarrier.eJian2 then
				var_50_0 = shenqiConfig[2]
			elseif var_48_1 == BattleCarrier.eHulu1 or var_48_1 == BattleCarrier.eHulu2 then
				var_50_0 = shenqiConfig[3]
			elseif var_48_1 == BattleCarrier.eBajiaoshan1 or var_48_1 == BattleCarrier.eBajiaoshan2 then
				var_50_0 = shenqiConfig[4]
			elseif var_48_1 == BattleCarrier.eYujingping1 or var_48_1 == BattleCarrier.eYujingping2 then
				var_50_0 = shenqiConfig[5]
			end

			var_50_0(var_48_1, arg_48_4, arg_48_0, arg_48_2, function()
				arg_48_3(true)
				arg_48_0.maskLayer:runAction(CCFadeOut:create(0.2))
				arg_48_0:getParent().uiLayer:shenqiEnd(arg_48_1)
			end)
		end))
		arg_48_0.maskLayer:runAction(CCSequence:create(var_49_0))
	end

	local var_48_3 = string.format("ui/battle/bg_skill_4.png")
	local var_48_4 = CCSprite:create(var_48_3)

	var_48_4:setScale(display.width / 960)
	var_48_4:setPosition(Adapter.AutoPos(-960, 450))
	arg_48_0:addChild(var_48_4)

	local var_48_5 = CCArray:create()

	var_48_5:addObject(CCMoveTo:create(4 / var_0_0 * BattleSpeed, CCPoint(display.cx, 450 * Adapter.AutoScaleY)))
	var_48_5:addObject(CCDelayTime:create(24 / var_0_0 * BattleSpeed))
	var_48_5:addObject(CCFadeOut:create(5 / var_0_0 * BattleSpeed))
	var_48_5:addObject(CCCallFunc:create(function()
		var_48_4:removeFromParentAndCleanup(true)
	end))
	var_48_4:runAction(CCSequence:create(var_48_5))

	local var_48_6 = CCSprite:create("ui/battle/bg_skill_01.png")

	var_48_6:setScale(Adapter.MinScale * 2)
	var_48_6:setPosition(Adapter.AutoPos(-960, 450))
	arg_48_0:addChild(var_48_6)

	local var_48_7 = CCArray:create()

	var_48_7:addObject(CCMoveTo:create(4 / var_0_0 * BattleSpeed, Adapter.AutoPos(200, 450)))
	var_48_7:addObject(CCMoveTo:create(22 / var_0_0 * BattleSpeed, Adapter.AutoPos(display.width, 450)))
	var_48_7:addObject(CCFadeOut:create(6 / var_0_0 * BattleSpeed))
	var_48_7:addObject(CCCallFunc:create(function()
		var_48_6:removeFromParentAndCleanup(true)
	end))
	var_48_6:runAction(CCSequence:create(var_48_7))

	local function var_48_8(arg_54_0)
		return string.format("uilocal/battle/battle_text_%d.png", arg_54_0 + 176)
	end

	local var_48_9 = CCSprite:create(var_48_8(var_48_1))

	var_48_9:setScale(Adapter.MinScale)
	arg_48_0:addChild(var_48_9)
	var_48_9:setPosition(display.width, 450 * Adapter.AutoScaleY)

	local var_48_10 = CCArray:create()

	var_48_10:addObject(CCDelayTime:create(4 / var_0_0 * BattleSpeed))
	var_48_10:addObject(CCMoveTo:create(3 / var_0_0 * BattleSpeed, Adapter.AutoPos(480, 450)))
	var_48_10:addObject(CCMoveBy:create(19 / var_0_0 * BattleSpeed, Adapter.AutoPos(-20, 0)))
	var_48_10:addObject(CCCallFunc:create(function()
		var_48_2()
		var_48_9:runAction(CCFadeOut:create(6 / var_0_0 * BattleSpeed))
		var_48_9:runAction(CCMoveBy:create(6 / var_0_0 * BattleSpeed, Adapter.AutoPos(-9.473684210526315, 0)))
	end))
	var_48_10:addObject(CCDelayTime:create(6 / var_0_0 * BattleSpeed))
	var_48_10:addObject(CCCallFunc:create(function()
		var_48_9:removeFromParentAndCleanup(true)
	end))
	var_48_9:runAction(CCSequence:create(var_48_10))
end

return var_0_1
