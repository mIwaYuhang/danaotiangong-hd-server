local var_0_0 = Adapter.MinScale * 2000
local var_0_1 = 250

require("scenes.battle.BattleSkeleton")
require("scenes.battle.BattleData")
require("scenes.battle.BattleStateLayer")

AnimationManager = {}

function AnimationManager.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.progressLayer = arg_1_1
	arg_1_0.effectLayer = arg_1_2
	arg_1_0.stateLayer = arg_1_3
	arg_1_0.actionOperator = nil
	arg_1_0.rebirth = nil
	arg_1_0.dropAnim = nil
	arg_1_0.droplayer = nil
	arg_1_0.lastTalentSkillView = false
end

function AnimationManager.onActionOver(arg_2_0)
	local var_2_0

	for iter_2_0, iter_2_1 in pairs(arg_2_0.step[arg_2_0.oneStep].affectList) do
		if iter_2_1 and iter_2_1.trans then
			var_2_0 = {
				npcId = iter_2_1.trans.npcId,
				node = BattleData:getDisplayNode(iter_2_1.trans.pos),
				health = iter_2_1.trans.health,
				rage = iter_2_1.trans.rage,
				npcSize = iter_2_1.trans.npcSize,
				pos = iter_2_1.trans.pos
			}
			iter_2_1.trans = nil
		end
	end

	if figureTransform and var_2_0 then
		local var_2_1 = CCArray:create()

		var_2_1:addObject(CCDelayTime:create(1 * BattleSpeed))
		var_2_1:addObject(CCCallFunc:create(function(...)
			local var_3_0 = {}
			local var_3_1 = true

			BattleData:transformd(var_2_0.pos, var_2_0, arg_2_0.progressLayer:getParent())
			BattleTransform:trasform_new(var_2_0, function(...)
				local var_4_0 = {
					{
						npcId = "" .. var_2_0.npcId,
						content = string.lf("你们这是自寻死路！！！")
					}
				}
				local var_4_1 = require("scenes.battle.BattleChatLayer"):new()

				arg_2_0.progressLayer:getParent():addChild(var_4_1, SceneZorder.eBattleFront)
				var_4_1:setup(var_4_0, function(...)
					arg_2_0:onActionOver()
				end)
			end)
		end))
		CCDirector:sharedDirector():getRunningScene():runAction(CCSequence:create(var_2_1))

		return
	end

	arg_2_0.oneStep = arg_2_0.oneStep + 1

	if table.getn(arg_2_0.step) >= arg_2_0.oneStep then
		arg_2_0:onOneStepAction(arg_2_0.step[arg_2_0.oneStep], handler(arg_2_0, AnimationManager.onActionOver))
	else
		arg_2_0:oneStepDelay(arg_2_0.stepCallback)
	end
end

function AnimationManager.onStepAction(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.oneStep = 1
	arg_6_0.step = arg_6_1
	arg_6_0.stepCallback = arg_6_2

	if table.getn(arg_6_1) >= arg_6_0.oneStep then
		arg_6_0:onOneStepAction(arg_6_1[arg_6_0.oneStep], handler(arg_6_0, AnimationManager.onActionOver))
	end
end

ProgressViewType = {
	eProcess = 2,
	eEnd = 3,
	eBegin = 1,
	eSimple = 4
}

function AnimationManager.actionProgress(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0.progressLayer:viewMaxHpAction(arg_7_2.position, arg_7_2.bar.maxHp)

	local var_7_0 = arg_7_0.progressLayer:ProgressActionHP(arg_7_1, arg_7_2.position, arg_7_2.bar.health, arg_7_2.effect)

	arg_7_0.progressLayer:ProgressActionRage(arg_7_2.position, arg_7_2.bar.rage, arg_7_4)

	if arg_7_3 then
		arg_7_0.progressLayer:viewHpAction(arg_7_2.position)
	end

	if arg_7_3 and not var_7_0 then
		if arg_7_2.talentSkill then
			if arg_7_2.talentSkill.step == BattleTalentStep.eAfterDead then
				if arg_7_2.rebirth then
					local function var_7_1(arg_8_0, arg_8_1)
						local var_8_0 = BattleData:getDisplayNode(arg_8_0.position)

						var_8_0.Skeleton:setOpacity(255)
						arg_7_0:usedTalentSkill(var_8_0, function()
							arg_7_0.progressLayer:ProgressSetHP(arg_8_0.position, arg_8_0.rebirth.health)
							arg_7_0.progressLayer:viewHpAction(arg_8_0.position)

							local var_9_0

							var_9_0 = BattleSkeleton:addEffect({
								effectName = "buff_chongsheng",
								parent = var_8_0,
								position = ccp(0, 150),
								scale = originalScale(),
								callbacklist = {
									function(...)
										var_9_0:removeFromParentAndCleanup(true)

										if arg_8_0.talentSkill and arg_8_0.talentSkill.hasNext then
											-- block empty
										else
											BattleSkeleton:actionWait(var_8_0)
										end

										arg_8_1()
									end,
									1,
									AAT_Percent
								}
							})

							BattleAudio:Sound_playEffect(BattleAudio.status_chongsheng)
						end)
					end

					if not arg_7_0.rebirth then
						arg_7_0.rebirth = {}
					end

					table.insert(arg_7_0.rebirth, {
						data = arg_7_2,
						func = var_7_1
					})
					BattleData:getDisplayNode(arg_7_2.position).Skeleton:setOpacity(200)
				else
					BattleData:dead(arg_7_2.position, false)
				end
			elseif not arg_7_2.trans then
				arg_7_0:death(BattleData:getDisplayNode(arg_7_2.position), 0.8 * BattleSpeed)
			end
		elseif not arg_7_2.trans then
			arg_7_0:death(BattleData:getDisplayNode(arg_7_2.position), 0.8 * BattleSpeed)
		end
	end
end

function AnimationManager.onOneStepAction(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(BattleData.Heros) do
		if iter_11_1.currentHealth <= 0 and iter_11_1.death == BattleDeathType.eDeathing then
			table.insert(var_11_0, iter_11_1.battleIx)
		end
	end

	for iter_11_2, iter_11_3 in pairs(BattleData.enemy) do
		if iter_11_3.currentHealth <= 0 and iter_11_3.death == BattleDeathType.eDeathing then
			table.insert(var_11_0, iter_11_3.battleIx)
		end
	end

	local function var_11_1()
		if arg_11_1.talentSkill then
			if arg_11_1.talentSkill.step == BattleTalentStep.eAfterHurt and arg_11_1.talentSkill.hasNext ~= true then
				local var_12_0 = BattleData:getDisplayNode(arg_11_1.position)

				arg_11_0:usedTalentSkill(var_12_0, arg_11_2)
			else
				arg_11_2()
			end
		else
			arg_11_2()
		end
	end

	local function var_11_2()
		arg_11_0:onAttackAction(arg_11_1, function()
			for iter_14_0, iter_14_1 in pairs(var_11_0) do
				arg_11_0:death(BattleData:getDisplayNode(iter_14_1))
			end

			if arg_11_0.rebirth then
				local var_14_0 = false

				for iter_14_2, iter_14_3 in pairs(arg_11_0.rebirth) do
					iter_14_3.func(iter_14_3.data, function()
						if not var_14_0 then
							var_14_0 = true

							var_11_1()
						end
					end)
				end

				arg_11_0.rebirth = nil
			else
				var_11_1()
			end
		end)
	end

	if testSkill and arg_11_1.skillType == BattleSkillType.eNormal or not testSkill and arg_11_1.skillType == BattleSkillType.eRage then
		var_11_2()
	elseif arg_11_1.talentSkill then
		if arg_11_1.talentSkill.step == BattleTalentStep.eBeforeAttack and arg_11_1.talentSkill.hasNext ~= true then
			local var_11_3 = BattleData:getDisplayNode(arg_11_1.position)

			arg_11_0:usedTalentSkill(var_11_3, var_11_2)
		else
			var_11_2()
		end
	elseif arg_11_0.lastTalentSkillView then
		arg_11_0.lastTalentSkillView = false

		if arg_11_1.skillType ~= BattleSkillType.eTalent then
			local var_11_4 = BattleData:getDisplayNode(arg_11_1.position)

			arg_11_0:usedTalentSkill(var_11_4, var_11_2)
		else
			var_11_2()
		end
	else
		var_11_2()
	end
end

function AnimationManager.usedTalentSkill(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = {
		function()
			arg_16_0.effectLayer:talentAniFirst(arg_16_1)
		end,
		0.2,
		AAT_Percent,
		function()
			if arg_16_2 then
				arg_16_2()
			end
		end,
		1,
		AAT_Percent
	}

	BattleSkeleton:actionSkillFirst(arg_16_1, var_16_0)
end

function NodeStopShake(arg_19_0)
	arg_19_0:stopActionByTag(1111333)
end

function AnimationManager.onAttackAction(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1.skillType ~= BattleSkillType.eArtifact and BattleData:getDisplayNode(arg_20_1.position) or nil

	if testSkill and arg_20_1.skillType == BattleSkillType.eRage or not testSkill and arg_20_1.skillType == BattleSkillType.eNormal then
		local var_20_1 = BattleData:getDisplayNode(arg_20_1.affectList[1].position)

		if BattleData:getProfession(arg_20_1.position) == HeroProfession.eMage then
			local var_20_2 = math.random(1, 2)
			local var_20_3 = {
				function(...)
					local var_21_0 = BattleData:getPosition(var_20_1.idx)
					local var_21_1, var_21_2 = var_20_0:getPosition()
					local var_21_3 = var_20_0:getScale() * 2
					local var_21_4 = var_21_2 + 80 * var_21_3
					local var_21_5 = var_21_1 + (var_20_0.isHero and 30 or -30) * var_21_3
					local var_21_6 = CCSprite:create(var_20_0.Skeleton.weaponPicPath)

					var_21_6:setScale(var_21_3)
					var_21_6:setAnchorPoint(ccp(0.5, 0.5))
					var_21_6:setPosition(var_21_5, var_21_4)

					local var_21_7 = var_20_0.viewParam.equipId

					var_20_0.viewParam.equipId = -1

					figure.setupFigure(var_20_0.viewParam)
					var_20_0:getParent():addChild(var_21_6, 2)

					local var_21_8 = var_20_1:getScale() * 2
					local var_21_9 = CCArray:create()

					var_21_9:addObject(CCCallFunc:create(function(...)
						orderScale_action(var_21_6, CCPoint(var_21_0.x, var_21_0.y + 80 * var_21_8), 0.1 * BattleSpeed)
					end))
					var_21_9:addObject(CCDelayTime:create(0.2 * BattleSpeed))
					var_21_9:addObject(CCCallFunc:create(function()
						var_21_6:getParent():reorderChild(var_21_6, -1)
						arg_20_0:actionProgress(arg_20_1.position, arg_20_1, true, false)

						local var_23_0 = {}

						local function var_23_1(arg_24_0)
							var_21_6:removeFromParentAndCleanup(true)

							var_20_0.viewParam.equipId = var_21_7

							figure.setupFigure(var_20_0.viewParam)
							arg_20_0:oneActionDelay(var_20_0, arg_20_2)
						end

						local function var_23_2(arg_25_0, arg_25_1, arg_25_2)
							local var_25_0 = BattleData:getDisplayNode(arg_25_0.position)

							arg_20_0:actionPassive(var_20_0, var_25_0, arg_25_0, arg_25_1, arg_25_2)
						end

						arg_20_0.effectLayer:NormalAni1(var_20_2, arg_20_1, var_23_0, var_23_1, var_23_2)

						local var_23_3 = BattleSkeleton.actionList(0.8 * BattleSpeed, var_23_0)

						CCDirector:sharedDirector():getRunningScene():runAction(CCSequence:create(var_23_3))
					end))
					var_20_0:runAction(CCSequence:create(var_21_9))
				end,
				0,
				AAT_Percent,
				function(...)
					BattleSkeleton:actionWait(var_20_0)
				end,
				1,
				AAT_Percent
			}

			BattleSkeleton:actionAttack(var_20_2, var_20_0, var_20_3)
		else
			arg_20_0:actionMoveTo(0.2 * BattleSpeed, var_20_0, var_20_1, function()
				arg_20_0:actionProgress(arg_20_1.position, arg_20_1, true, false)

				local var_27_0 = {}

				local function var_27_1(arg_28_0)
					arg_20_0:actionMoveBack(0.2 * BattleSpeed, var_20_0, function()
						arg_20_0:oneActionDelay(var_20_0, arg_20_2)
					end)
					BattleSkeleton:actionWait(var_20_0)
				end

				local function var_27_2(arg_30_0, arg_30_1, arg_30_2)
					local var_30_0 = BattleData:getDisplayNode(arg_30_0.position)

					arg_20_0:actionPassive(var_20_0, var_30_0, arg_30_0, arg_30_1, arg_30_2)
				end

				local var_27_3 = math.random(1, 2)

				arg_20_0.effectLayer:NormalAni(var_27_3, arg_20_1, var_27_0, var_27_1, var_27_2)
				BattleSkeleton:actionAttack(var_27_3, var_20_0, var_27_0)
			end)
		end
	elseif testSkill and arg_20_1.skillType == BattleSkillType.eNormal or not testSkill and arg_20_1.skillType == BattleSkillType.eRage then
		local var_20_4 = isRecoverSkill(BattleData:findTarget(arg_20_1.position).skillId)
		local var_20_5 = {
			function()
				arg_20_0.effectLayer:RageAni_first(arg_20_1.position)
			end,
			0,
			AAT_Percent,
			function()
				arg_20_0:actionProgress(arg_20_1.position, arg_20_1, true, false)

				local var_32_0 = {}

				local function var_32_1(arg_33_0)
					if arg_33_0 then
						arg_20_0:oneActionDelay(var_20_0, arg_20_2)
					else
						BattleSkeleton:actionWait(var_20_0)
					end
				end

				local function var_32_2(arg_34_0, arg_34_1, arg_34_2)
					local var_34_0 = BattleData:getDisplayNode(arg_34_0.position)

					arg_20_0:actionPassive(var_20_0, var_34_0, arg_34_0, arg_34_1, arg_34_2)
				end

				arg_20_0.effectLayer:RageAni_second(arg_20_1, var_32_0, var_32_1, var_32_2, var_20_4)

				if var_20_4 then
					local var_32_3 = BattleSkeleton.actionList(0.8 * BattleSpeed, var_32_0)

					CCDirector:sharedDirector():getRunningScene():runAction(CCSequence:create(var_32_3))
				else
					BattleSkeleton:actionSkillSecond(var_20_0, var_32_0)
				end
			end,
			1,
			AAT_Percent
		}

		BattleSkeleton:actionSkillFirst(var_20_0, var_20_5)
	elseif arg_20_1.skillType == BattleSkillType.eArtifact then
		local var_20_6 = 0
		local var_20_7

		for iter_20_0, iter_20_1 in pairs(BattleData.shenqiList) do
			if iter_20_1.posId == arg_20_1.position then
				local var_20_8 = iter_20_1.lv

				var_20_7 = iter_20_1
			end
		end

		arg_20_0.effectLayer:shenqiAniFirst(var_20_7, function(...)
			local function var_35_0(arg_36_0)
				arg_20_0:oneActionDelay(arg_20_0.effectLayer, arg_20_2)
			end

			local function var_35_1(arg_37_0, arg_37_1, arg_37_2)
				local var_37_0 = BattleData:getDisplayNode(arg_37_0.position)

				arg_20_0:actionPassive(nil, var_37_0, arg_37_0, arg_37_1, arg_37_2)
			end

			arg_20_0.effectLayer:shenqiAniSecond(var_20_7, var_35_1, var_35_0, arg_20_1)
		end)
	else
		arg_20_0:actionProgress(arg_20_1.position, arg_20_1, true, false)

		local var_20_9 = {}

		local function var_20_10(arg_38_0)
			arg_20_0:oneActionDelay(var_20_0, arg_20_2)
			BattleSkeleton:actionWait(var_20_0)
		end

		local function var_20_11(arg_39_0, arg_39_1, arg_39_2)
			local var_39_0 = BattleData:getDisplayNode(arg_39_0.position)

			arg_20_0:actionPassive(var_20_0, var_39_0, arg_39_0, arg_39_1, arg_39_2)
		end

		arg_20_0.effectLayer:talentAni(arg_20_1, var_20_9, var_20_10, var_20_11)
		BattleSkeleton:actionSkillFirst(var_20_0, var_20_9)
	end
end

function AnimationManager.actionPassive(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4, arg_40_5)
	if arg_40_3.talentSkill and arg_40_4 then
		if arg_40_3.talentSkill.step == BattleTalentStep.eHurt and arg_40_3.talentSkill.hasNext ~= true then
			arg_40_0.effectLayer:talentAniFirst(arg_40_2)
		end

		if arg_40_3.talentSkill.step == BattleTalentStep.eAfterHurt then
			if arg_40_3.talentSkill.hasNext == true then
				arg_40_0.lastTalentSkillView = true
			else
				arg_40_0.effectLayer:talentAniFirst(arg_40_2)
			end
		end
	end

	local var_40_0

	if arg_40_1 then
		if not arg_40_0.actionOperator then
			arg_40_0.actionOperator = {}
		end

		if not arg_40_4 then
			if not arg_40_0.actionOperator[arg_40_1.idx] then
				arg_40_0.actionOperator[arg_40_1.idx] = true
				var_40_0 = ProgressViewType.eBegin
			else
				arg_40_0.actionOperator[arg_40_1.idx] = true
				var_40_0 = ProgressViewType.eProcess
			end
		elseif not arg_40_0.actionOperator[arg_40_1.idx] then
			arg_40_0.actionOperator[arg_40_1.idx] = nil
			var_40_0 = ProgressViewType.eSimple
		else
			arg_40_0.actionOperator[arg_40_1.idx] = nil
			var_40_0 = ProgressViewType.eEnd
		end
	else
		var_40_0 = ProgressViewType.eSimple
	end

	arg_40_0:actionState(arg_40_2, arg_40_3, nil)

	if arg_40_1 and (arg_40_1.isHero and arg_40_2.isHero or not arg_40_1.isHero and not arg_40_2.isHero) then
		arg_40_0:actionProgress(arg_40_1.idx, arg_40_3, arg_40_4, arg_40_5)

		return
	end

	arg_40_2.Skeleton:setOpacity(255)

	if arg_40_1 then
		arg_40_0:actionProgress(arg_40_1.idx, arg_40_3, arg_40_4, arg_40_5)
	else
		arg_40_0:actionProgress(nil, arg_40_3, arg_40_4, arg_40_5)
	end

	if arg_40_3.effect == BattleEffectType.eNormal or arg_40_3.effect == BattleEffectType.eBaoJi then
		if var_40_0 == ProgressViewType.eBegin then
			NodeStopShake(arg_40_2)
			BattleSkeleton:actionInjured(arg_40_2, nil)
			shakeHorizontal(arg_40_2, 5)
		elseif var_40_0 == ProgressViewType.eProcess then
			BattleSkeleton:actionInjured(arg_40_2, nil)
		elseif var_40_0 == ProgressViewType.eEnd then
			BattleSkeleton:actionWait(arg_40_2)
			arg_40_2:setPosition(BattleData:getPosition(arg_40_3.position))
			NodeStopShake(arg_40_2)
		elseif var_40_0 == ProgressViewType.eSimple then
			NodeStopShake(arg_40_2)

			local var_40_1 = {}

			var_40_1.time = 1
			var_40_1.type = AAT_Percent

			function var_40_1.callback()
				BattleSkeleton:actionWait(arg_40_2)
				NodeStopShake(arg_40_2)
				arg_40_2:setPosition(BattleData:getPosition(arg_40_3.position))
			end

			BattleSkeleton:actionInjured(arg_40_2, var_40_1)
			arg_40_2:setPosition(BattleData:getPosition(arg_40_3.position))
			shakeHorizontal(arg_40_2, 5)
		end
	elseif arg_40_3.effect == BattleEffectType.eGeDang then
		if var_40_0 == ProgressViewType.eBegin then
			NodeStopShake(arg_40_2)
			BattleSkeleton:actionGedang(arg_40_2, nil)

			local var_40_2 = CCPoint(arg_40_2.isHero and -200 or 200, 190)
			local var_40_3 = originalScale() * 0.7
			local var_40_4

			var_40_4 = BattleSkeleton:addEffect({
				effectName = "gedang",
				parent = arg_40_2,
				position = var_40_2,
				callbacklist = {
					function()
						var_40_4:removeFromParentAndCleanup(true)
					end,
					1,
					AAT_Percent
				},
				scale = var_40_3
			})

			if not arg_40_2.isHero then
				var_40_4:setRotationY(180)
			end
		elseif var_40_0 == ProgressViewType.eProcess then
			-- block empty
		elseif var_40_0 == ProgressViewType.eEnd then
			BattleSkeleton:actionWait(arg_40_2)
			NodeStopShake(arg_40_2)
			arg_40_2:setPosition(BattleData:getPosition(arg_40_3.position))
		elseif var_40_0 == ProgressViewType.eSimple then
			NodeStopShake(arg_40_2)

			local var_40_5 = {}

			var_40_5.time = 1
			var_40_5.type = AAT_Percent

			function var_40_5.callback()
				BattleSkeleton:actionWait(arg_40_2)
			end

			BattleSkeleton:actionGedang(arg_40_2, var_40_5)

			local var_40_6 = CCPoint(arg_40_2.isHero and -200 or 200, 190)
			local var_40_7 = originalScale() * 0.7
			local var_40_8

			var_40_8 = BattleSkeleton:addEffect({
				effectName = "gedang",
				parent = arg_40_2,
				position = var_40_6,
				callbacklist = {
					function()
						var_40_8:removeFromParentAndCleanup(true)
					end,
					1,
					AAT_Percent
				},
				scale = var_40_7
			})

			if not arg_40_2.isHero then
				var_40_8:setRotationY(180)
			end
		end
	elseif arg_40_3.effect == BattleEffectType.eShanBi then
		NodeStopShake(arg_40_2)

		if var_40_0 == ProgressViewType.eBegin then
			local var_40_9, var_40_10 = arg_40_2:getPosition()
			local var_40_11 = createParticleEffect("ui/battle/BattleParticle/shanbi.plist", CCPoint(var_40_9, var_40_10 + 50 * Adapter.MinScale), arg_40_0.progressLayer)

			BattleSkeleton.setHide(arg_40_2, false)

			local var_40_12 = BattleSkeleton.copy(arg_40_2)

			var_40_12.Skeleton:setTest(1 / BattleSpeed, false, false, false)
			var_40_12.Skeleton:setOpacity(0)

			local var_40_13 = CCArray:create()

			var_40_13:addObject(CCMoveBy:create(0.05 * BattleSpeed, CCPoint((arg_40_2.isHero and -var_0_1 or var_0_1) * arg_40_2:getScale(), 0)))
			var_40_13:addObject(CCDelayTime:create(0.3 * BattleSpeed))
			var_40_13:addObject(CCCallFunc:create(function()
				var_40_11:removeFromParentAndCleanup(true)
				arg_40_0.progressLayer:ProgressActionRage(arg_40_3.position, arg_40_3.bar.rage)
			end))
			var_40_12:runAction(CCSequence:create(var_40_13))

			arg_40_2.copyNode = var_40_12
		elseif var_40_0 == ProgressViewType.eProcess then
			-- block empty
		elseif var_40_0 == ProgressViewType.eEnd then
			local var_40_14 = CCArray:create()

			var_40_14:addObject(CCMoveBy:create(0.05 * BattleSpeed, CCPoint((arg_40_2.isHero and var_0_1 or -var_0_1) * arg_40_2:getScale(), 0)))
			var_40_14:addObject(CCCallFunc:create(function()
				arg_40_2.copyNode:removeFromParentAndCleanup(true)

				arg_40_2.copyNode = nil

				BattleSkeleton.setHide(arg_40_2, true)
			end))
			arg_40_2.copyNode:runAction(CCSequence:create(var_40_14))
		elseif var_40_0 == ProgressViewType.eSimple then
			local var_40_15, var_40_16 = arg_40_2:getPosition()
			local var_40_17 = createParticleEffect("ui/battle/BattleParticle/shanbi.plist", CCPoint(var_40_15, var_40_16 + 50 * Adapter.MinScale), arg_40_0.progressLayer)

			BattleSkeleton.setHide(arg_40_2, false)

			local var_40_18 = BattleSkeleton.copy(arg_40_2)

			var_40_18.Skeleton:setTest(1 / BattleSpeed, false, false, false)
			var_40_18.Skeleton:setOpacity(0)

			local var_40_19 = CCArray:create()

			var_40_19:addObject(CCMoveBy:create(0.05 * BattleSpeed, CCPoint((arg_40_2.isHero and -var_0_1 or var_0_1) * arg_40_2:getScale(), 0)))
			var_40_19:addObject(CCDelayTime:create(0.3 * BattleSpeed))
			var_40_19:addObject(CCCallFunc:create(function()
				var_40_17:removeFromParentAndCleanup(true)
				arg_40_0.progressLayer:ProgressActionRage(arg_40_3.position, arg_40_3.bar.rage)
			end))
			var_40_19:addObject(CCMoveBy:create(0.05 * BattleSpeed, CCPoint((arg_40_2.isHero and var_0_1 or -var_0_1) * arg_40_2:getScale(), 0)))
			var_40_19:addObject(CCCallFunc:create(function()
				var_40_18:removeFromParentAndCleanup(true)
				BattleSkeleton.setHide(arg_40_2, true)
			end))
			var_40_18:runAction(CCSequence:create(var_40_19))
		end
	end
end

function AnimationManager.actionState(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	if testState then
		arg_49_2.state = {
			{
				round = 2,
				id = math.random(1, 1010),
				type = BattleStateType.eDuanxu
			}
		}
	end

	if arg_49_2.state and table.getn(arg_49_2.state) > 0 then
		for iter_49_0, iter_49_1 in pairs(arg_49_2.state) do
			if StateLayerType[iter_49_1.type] then
				local var_49_0 = BattleData:manageState(arg_49_1.idx, iter_49_1)

				if var_49_0 == 1 then
					arg_49_0.stateLayer:addIconAni(arg_49_1, iter_49_1)
				elseif var_49_0 == -1 then
					arg_49_0.stateLayer:deleteIconAni(arg_49_1, iter_49_1)
				end
			end
		end
	end
end

function AnimationManager.actionMoveTo(arg_50_0, arg_50_1, arg_50_2, arg_50_3, arg_50_4)
	if BattleData:getProfession(arg_50_2.idx) == HeroProfession.eMage then
		local var_50_0 = CCSprite:create("ui/battle/bg_battle_position.png")

		var_50_0:setScale(arg_50_2:getScale())
		var_50_0:setPosition(arg_50_2:getPosition())
		arg_50_2:getParent():addChild(var_50_0, -1)

		arg_50_2.tmpShadow = var_50_0

		var_50_0:runAction(CCScaleTo:create(arg_50_1, 0.6 * arg_50_2:getScale()))
		arg_50_2.shadow:setVisible(false)

		local var_50_1 = CCSprite:create("ui/battle/cloud.png")

		var_50_1:setScale(0.01)
		var_50_1:setPosition(Adapter.MinPos(arg_50_2.isHero and -20 or 20, 0))

		if not arg_50_2.isHero then
			var_50_1:setRotationY(180)
		end

		var_50_1:runAction(CCScaleTo:create(arg_50_1, originalScale()))
		arg_50_2:addChild(var_50_1, -1)

		arg_50_2.cloud = var_50_1

		arg_50_2:stopAllActions()
		arg_50_2.shadow:setVisible(false)

		local var_50_2 = BattleData:getPosition(arg_50_2.idx)
		local var_50_3 = CCArray:create()

		var_50_3:addObject(CCMoveTo:create(arg_50_1, CCPoint(var_50_2.x, var_50_2.y + 70 * arg_50_2:getScale())))

		if arg_50_4 then
			var_50_3:addObject(CCCallFunc:create(function()
				local var_51_0 = CCArray:create()

				var_51_0:addObject(CCEaseSineInOut:create(CCMoveBy:create(0.2 * BattleSpeed, CCPoint(0, 10 * Adapter.MinScale))))
				var_51_0:addObject(CCEaseSineInOut:create(CCMoveBy:create(0.2 * BattleSpeed, CCPoint(0, -10 * Adapter.MinScale))))

				local var_51_1 = CCRepeatForever:create(CCSequence:create(var_51_0))

				var_51_1:setTag(3345)
				arg_50_2:runAction(var_51_1)

				local var_51_2 = CCArray:create()

				var_51_2:addObject(CCEaseSineInOut:create(CCScaleTo:create(0.2 * BattleSpeed, 0.5 * arg_50_2:getScale())))
				var_51_2:addObject(CCEaseSineInOut:create(CCScaleTo:create(0.2 * BattleSpeed, 0.6 * arg_50_2:getScale())))
				var_50_0:runAction(CCRepeatForever:create(CCSequence:create(var_51_2)))
				arg_50_4()
			end))
		end

		arg_50_2:runAction(CCSequence:create(var_50_3))
	else
		arg_50_2:stopAllActions()

		local var_50_4 = BattleData:getPosition(arg_50_3.idx)
		local var_50_5 = CCArray:create()

		var_50_5:addObject(CCCallFunc:create(function(...)
			orderScale_action(arg_50_2, CCPoint(var_50_4.x + (arg_50_3.isHero and var_0_1 or -var_0_1) * arg_50_2:getScale(), var_50_4.y), arg_50_1)
		end))
		var_50_5:addObject(CCDelayTime:create(arg_50_1))

		if arg_50_4 then
			var_50_5:addObject(CCCallFunc:create(function()
				arg_50_2:getParent():reorderChild(arg_50_2, (arg_50_3.idx - 1) % 3)
				arg_50_4()
			end))
		end

		arg_50_2:runAction(CCSequence:create(var_50_5))
	end
end

function AnimationManager.actionMoveBack(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = CCArray:create()
	local var_54_1, var_54_2 = arg_54_2:getPosition()
	local var_54_3 = BattleData:getPosition(arg_54_2.idx)

	if BattleData:getProfession(arg_54_2.idx) == HeroProfession.eMage then
		var_54_0:addObject(CCCallFunc:create(function()
			arg_54_2.tmpShadow:stopAllActions()
			arg_54_2.tmpShadow:runAction(CCScaleTo:create(arg_54_1, arg_54_2:getScale()))
			arg_54_2.cloud:runAction(CCFadeOut:create(arg_54_1))
			arg_54_2:stopActionByTag(3345)
		end))
		var_54_0:addObject(CCMoveTo:create(arg_54_1, var_54_3))
	else
		orderScale_action(arg_54_2, var_54_3, arg_54_1)
	end

	if arg_54_3 then
		var_54_0:addObject(CCCallFunc:create(function()
			if BattleData:getProfession(arg_54_2.idx) == HeroProfession.eMage then
				arg_54_2.tmpShadow:removeFromParentAndCleanup(true)
				arg_54_2.shadow:setVisible(true)
				arg_54_2.cloud:removeFromParentAndCleanup(true)
			end

			arg_54_2:getParent():reorderChild(arg_54_2, (arg_54_2.idx - 1) % 3)
			arg_54_3()
		end))
	end

	arg_54_2:runAction(CCSequence:create(var_54_0))
end

function AnimationManager.death(arg_57_0, arg_57_1, arg_57_2)
	arg_57_1:stopAllActions()
	arg_57_1.rageBar.particle:stopSystem()

	local var_57_0 = CCArray:create()

	if arg_57_2 then
		var_57_0:addObject(CCDelayTime:create(arg_57_2 * BattleSpeed))
	end

	var_57_0:addObject(CCCallFunc:create(function()
		local var_58_0, var_58_1 = arg_57_1:getPosition()
		local var_58_2
		local var_58_3 = BattleSkeleton:addEffect({
			effectName = "koulou",
			parent = arg_57_1:getParent(),
			position = ccp(var_58_0, var_58_1 + 5 * Adapter.MinScale),
			scale = arg_57_1:getScale() * 1.2
		})
		local var_58_4 = createParticleEffect("ui/battle/BattleParticle/death.plist", CCPoint(var_58_0, var_58_1 + 50 * Adapter.MinScale), arg_57_1:getParent())

		if not arg_57_1.isHero then
			var_58_3:setRotationY(180)
		else
			var_58_4:setRotationY(180)
		end

		orderScale(var_58_3, ccp(var_58_0, var_58_1))

		arg_57_1.kulouske = var_58_3

		local var_58_5 = CCSprite:create("ui/battle/bg_battle_position.png")

		var_58_5:setPosition(var_58_0, var_58_1)
		var_58_5:setScale(FigureSize * ignoreSetupScale(arg_57_1.figureSize))
		arg_57_1:getParent():addChild(var_58_5, -1)
		orderScale(var_58_5, ccp(var_58_0, var_58_1))

		if testDrop then
			arg_57_0:deadDrop(arg_57_1)
		end

		arg_57_1.healthBar_current:getParent():setVisible(false)
		arg_57_1.Skeleton:runAction(CCFadeOut:create(0.2 * BattleSpeed))

		if arg_57_1.halo then
			arg_57_1.halo:setVisible(false)
		end

		arg_57_1.shadow:setVisible(false)

		if arg_57_1.stateicon then
			for iter_58_0, iter_58_1 in pairs(arg_57_1.stateicon) do
				iter_58_1:setVisible(false)
			end
		end

		if arg_57_1.talentEffect then
			local var_58_6 = CCArray:create()

			var_58_6:addObject(CCFadeTo:create(0.2 * BattleSpeed, 0))
			var_58_6:addObject(CCCallFunc:create(function()
				arg_57_1.talentEffect:removeFromParentAndCleanup(true)
			end))
			arg_57_1.talentEffect:runAction(CCSequence:create(var_58_6))
		end

		if arg_57_1.wing then
			arg_57_1.wing:setVisible(false)
		end
	end))
	arg_57_1.Skeleton:runAction(CCSequence:create(var_57_0))

	if arg_57_1.Skeleton.weaponEffect then
		local var_57_1 = arg_57_1.Skeleton:getSlotNode(arg_57_1.Skeleton.weaponEffect)

		var_57_1:unscheduleUpdate()
		var_57_1:removeAllChildren()
		var_57_1:setVisible(false)

		arg_57_1.Skeleton.weaponEffect = nil
	end

	BattleData:dead(arg_57_1.idx, true)
end

function AnimationManager.deadDrop(arg_60_0, arg_60_1)
	if BattleData.reward and table.getn(BattleData.reward) > 0 then
		for iter_60_0, iter_60_1 in pairs(BattleData.enemy) do
			if arg_60_1.idx == iter_60_1.battleIx and iter_60_1.dropId then
				if not arg_60_0.dropAnim then
					arg_60_0.dropAnim = {}
					arg_60_0.droplayer = CCLayer:create()

					arg_60_1:getParent():getParent():addChild(arg_60_0.droplayer, SceneZorder.eBackGroundAnimation)
				end

				local var_60_0 = BattleData.reward[iter_60_1.dropId]
				local var_60_1
				local var_60_2 = var_60_0.Type == ItemType.eCoin and "ui/tower/tower_021.png" or "ui/other/small_box1.png"
				local var_60_3, var_60_4 = arg_60_1:getPosition()
				local var_60_5 = CCSprite:create(var_60_2)
				local var_60_6 = CCArray:create()

				var_60_6:addObject(CCFadeIn:create(0.3 * BattleSpeed))
				var_60_6:addObject(CCCallFunc:create(function(...)
					var_60_5:removeFromParentAndCleanup(true)

					local var_61_0

					var_61_0 = ui.newControlButton({
						normalImage = var_60_2,
						clickAction = function(arg_62_0, arg_62_1)
							var_61_0:removeFromParentAndCleanup(true)
							var_61_0.particle:removeFromParentAndCleanup(true)

							if var_60_0.Type == ItemType.eCoin then
								arg_60_0:getCoin(arg_60_0.droplayer, var_60_3, var_60_4, var_60_0)
							else
								arg_60_0:getTreasure(arg_60_0.droplayer, var_60_3, var_60_4, var_60_0)
							end
						end,
						scaleX = Adapter.MinScale,
						scaleY = Adapter.MinScale,
						position = CCPoint(var_60_3, var_60_4 + 40 * Adapter.MinScale)
					})

					if arg_60_0.droplayer then
						arg_60_0.droplayer:addChild(var_61_0)
						table.insert(arg_60_0.dropAnim, var_61_0)

						var_61_0.particle = createParticleEffect("ui/battle/BattleParticle/coin.plist", CCPoint(var_60_3, var_60_4 + 0 * Adapter.MinScale), arg_60_0.droplayer)
					end
				end))
				var_60_5:runAction(CCMoveTo:create(0.3 * BattleSpeed, CCPoint(0, -100)))
				var_60_5:runAction(CCSequence:create(var_60_6))

				local var_60_7, var_60_8 = arg_60_1:getPosition()

				var_60_5:setPosition(var_60_7, var_60_8 + 140 * Adapter.MinScale)
				var_60_5:setScale(Adapter.MinScale)
				var_60_5:setOpacity(0)
				arg_60_0.droplayer:addChild(var_60_5)
			end
		end
	end
end

function AnimationManager.getCoin(arg_63_0, arg_63_1, arg_63_2, arg_63_3, arg_63_4)
	local var_63_0 = CCLabelTTF:create("+" .. arg_63_4.Count, _FONT_DEFAULT, Adapter.FontSize(25))

	var_63_0:setPosition(arg_63_2, arg_63_3 + 40 * Adapter.MinScale)
	var_63_0:setColor(ccc3(255, 255, 0))
	arg_63_1:addChild(var_63_0)

	local var_63_1 = CCArray:create()

	var_63_1:addObject(CCMoveBy:create(0.6 * BattleSpeed, ccp(0, 50 * Adapter.MinScale)))
	var_63_1:addObject(CCCallFunc:create(function()
		var_63_0:removeFromParentAndCleanup(true)
	end))
	var_63_0:runAction(CCSequence:create(var_63_1))

	for iter_63_0 = 1, 10 do
		local var_63_2 = CCSprite:create("ui/common/common_057.png")

		var_63_2:setPosition(arg_63_2 + math.random(-30, 30) * Adapter.MinScale, arg_63_3 + 40 * Adapter.MinScale)
		arg_63_1:addChild(var_63_2)
		var_63_2:runAction(CCRepeatForever:create(CCRotateTo:create(math.random(5, 10) / 10 * BattleSpeed, 180)))

		local var_63_3 = CCArray:create()

		var_63_3:addObject(CCMoveTo:create(1 * BattleSpeed * math.random(5, 10) / 10, ccp(display.cx, display.height)))
		var_63_3:addObject(CCCallFunc:create(function()
			var_63_2:removeFromParentAndCleanup(true)
		end))
		var_63_2:runAction(CCSequence:create(var_63_3))
	end
end

function AnimationManager.getTreasure(arg_66_0, arg_66_1, arg_66_2, arg_66_3, arg_66_4)
	local var_66_0 = {
		count = 1,
		type = arg_66_4.Type,
		itemId = arg_66_4.ID
	}
	local var_66_1 = figure.createHeader(var_66_0)

	var_66_1:setScale(Adapter.MinScale)
	var_66_1:setAnchorPoint(CCPoint(0.5, 0.5))
	var_66_1:setPosition(arg_66_2, arg_66_3)
	arg_66_1:addChild(var_66_1)

	local var_66_2 = CCArray:create()

	var_66_2:addObject(CCMoveTo:create(1 * BattleSpeed * math.random(5, 10) / 10, ccp(display.cx, display.height)))
	var_66_2:addObject(CCCallFunc:create(function()
		var_66_1:removeFromParentAndCleanup(true)
	end))
	var_66_1:runAction(CCSequence:create(var_66_2))
end

function AnimationManager.removeDropAnim(arg_68_0, arg_68_1)
	local var_68_0 = CCArray:create()

	var_68_0:addObject(CCDelayTime:create(0.6 * BattleSpeed))
	var_68_0:addObject(CCCallFunc:create(function(...)
		if arg_68_0.dropAnim and arg_68_0.droplayer then
			arg_68_0.droplayer:removeFromParentAndCleanup(true)

			arg_68_0.dropAnim = nil
		end

		arg_68_1()
	end))
	CCDirector:sharedDirector():getRunningScene():runAction(CCSequence:create(var_68_0))
end

function AnimationManager.oneStepDelay(arg_70_0, arg_70_1)
	local var_70_0 = CCArray:create()

	var_70_0:addObject(CCDelayTime:create(0.2 * BattleSpeed))
	var_70_0:addObject(CCCallFunc:create(arg_70_1))
	CCDirector:sharedDirector():getRunningScene():runAction(CCSequence:create(var_70_0))
end

function AnimationManager.oneActionDelay(arg_71_0, arg_71_1, arg_71_2)
	for iter_71_0, iter_71_1 in pairs(BattleData.displayHero) do
		iter_71_1:stopActionByTag(1111333)
		iter_71_1:stopActionByTag(1123)
	end

	for iter_71_2, iter_71_3 in pairs(BattleData.displayEnemy) do
		iter_71_3:stopActionByTag(1111333)
		iter_71_3:stopActionByTag(1123)
	end

	local var_71_0 = CCArray:create()

	var_71_0:addObject(CCDelayTime:create(0.05 * BattleSpeed))
	var_71_0:addObject(CCCallFunc:create(arg_71_2))
	arg_71_1:runAction(CCSequence:create(var_71_0))
end

function AnimationManager.preBattleView(arg_72_0, arg_72_1)
	local var_72_0 = {}

	for iter_72_0, iter_72_1 in pairs(BattleData.preBattle) do
		if var_72_0[iter_72_1.position] then
			var_72_0[iter_72_1.position] = var_72_0[iter_72_1.position] + 1
		else
			var_72_0[iter_72_1.position] = 1
		end

		local var_72_1 = BattleData:getDisplayNode(iter_72_1.position)

		if var_72_0[iter_72_1.position] == 1 then
			local var_72_2 = {
				function(...)
					local var_73_0

					var_73_0 = BattleSkeleton:addEffect({
						effectName = "buff_tongyi",
						parent = var_72_1,
						position = ccp(0, 150),
						scale = originalScale(),
						callbacklist = {
							function(...)
								var_73_0:removeFromParentAndCleanup(true)
							end,
							1,
							AAT_Percent
						}
					})
				end,
				0,
				AAT_Percent,
				function()
					BattleSkeleton:actionWait(var_72_1)
				end,
				1,
				AAT_Percent
			}

			BattleSkeleton:actionSkillFirst(var_72_1, var_72_2)
		end

		local var_72_3 = ""

		if iter_72_1.value < 0 then
			if iter_72_1.type == BattlePreBattleType.eHealth then
				var_72_3 = "battle_text_165.png"

				arg_72_0.progressLayer:viewMaxHpAction(iter_72_1.position, iter_72_1.value)
			elseif iter_72_1.type == BattlePreBattleType.eNormalAttack then
				var_72_3 = "battle_text_104.png"
			elseif iter_72_1.type == BattlePreBattleType.eNormalDefense then
				var_72_3 = "battle_text_105.png"
			elseif iter_72_1.type == BattlePreBattleType.eSkillAttack then
				var_72_3 = "battle_text_106.png"
			elseif iter_72_1.type == BattlePreBattleType.eSkillDefense then
				var_72_3 = "battle_text_107.png"
			elseif iter_72_1.type == BattlePreBattleType.eMingzhong then
				var_72_3 = "battle_text_108.png"
			elseif iter_72_1.type == BattlePreBattleType.eShanbi then
				var_72_3 = "battle_text_109.png"
			elseif iter_72_1.type == BattlePreBattleType.eBaoji then
				var_72_3 = "battle_text_110.png"
			elseif iter_72_1.type == BattlePreBattleType.eRenxing then
				var_72_3 = "battle_text_111.png"
			elseif iter_72_1.type == BattlePreBattleType.eGedang then
				var_72_3 = "battle_text_112.png"
			elseif iter_72_1.type == BattlePreBattleType.ePoji then
				var_72_3 = "battle_text_113.png"
			elseif iter_72_1.type == BattlePreBattleType.eSpeed then
				var_72_3 = "battle_text_114.png"
			elseif iter_72_1.type == BattlePreBattleType.eRage then
				var_72_3 = "battle_text_115.png"

				arg_72_0.progressLayer:ProgressActionRage(iter_72_1.position, iter_72_1.value, true)
			end
		elseif iter_72_1.type == BattlePreBattleType.eHealth then
			var_72_3 = "battle_text_164.png"

			arg_72_0.progressLayer:viewMaxHpAction(iter_72_1.position, iter_72_1.value)
		elseif iter_72_1.type == BattlePreBattleType.eNormalAttack then
			var_72_3 = "battle_text_092.png"
		elseif iter_72_1.type == BattlePreBattleType.eNormalDefense then
			var_72_3 = "battle_text_093.png"
		elseif iter_72_1.type == BattlePreBattleType.eSkillAttack then
			var_72_3 = "battle_text_094.png"
		elseif iter_72_1.type == BattlePreBattleType.eSkillDefense then
			var_72_3 = "battle_text_095.png"
		elseif iter_72_1.type == BattlePreBattleType.eMingzhong then
			var_72_3 = "battle_text_096.png"
		elseif iter_72_1.type == BattlePreBattleType.eShanbi then
			var_72_3 = "battle_text_097.png"
		elseif iter_72_1.type == BattlePreBattleType.eBaoji then
			var_72_3 = "battle_text_098.png"
		elseif iter_72_1.type == BattlePreBattleType.eRenxing then
			var_72_3 = "battle_text_099.png"
		elseif iter_72_1.type == BattlePreBattleType.eGedang then
			var_72_3 = "battle_text_100.png"
		elseif iter_72_1.type == BattlePreBattleType.ePoji then
			var_72_3 = "battle_text_101.png"
		elseif iter_72_1.type == BattlePreBattleType.eSpeed then
			var_72_3 = "battle_text_102.png"
		elseif iter_72_1.type == BattlePreBattleType.eRage then
			var_72_3 = "battle_text_103.png"

			arg_72_0.progressLayer:ProgressActionRage(iter_72_1.position, iter_72_1.value, true)
		end

		local var_72_4 = "uilocal/battle/" .. var_72_3
		local var_72_5, var_72_6 = var_72_1:getPosition()
		local var_72_7 = CCSprite:create(var_72_4)

		var_72_7:setScale(0.8 * Adapter.MinScale)
		arg_72_0.effectLayer:addChild(var_72_7)
		var_72_7:setOpacity(0)
		var_72_7:setPosition(CCPoint(var_72_5, var_72_6 + (380 + 100 * (var_72_0[iter_72_1.position] - 1)) * var_72_1:getScale()))

		local var_72_8 = CCArray:create()

		var_72_8:addObject(CCFadeIn:create(0.3))
		var_72_8:addObject(CCDelayTime:create(0.5))
		var_72_8:addObject(CCFadeOut:create(0.3))
		var_72_8:addObject(CCCallFunc:create(function()
			var_72_7:removeFromParentAndCleanup(true)
		end))
		var_72_7:runAction(CCSequence:create(var_72_8))
		var_72_7:runAction(CCMoveBy:create(1.1, CCPoint(0, 100 * var_72_1:getScale())))
	end

	for iter_72_2, iter_72_3 in pairs(BattleData.Heros) do
		if iter_72_3.talentId == 10019 and iter_72_3.rebirthCount >= 1 then
			local var_72_9 = BattleData:getDisplayNode(iter_72_3.battleIx)

			var_72_9.talentEffect = BattleSkeleton:addEffect({
				effectName = "buff_mianyi",
				loop = true,
				animation = "buff_mianyi_xunhuan",
				parent = var_72_9,
				position = ccp(0, 150),
				scale = originalScale()
			})

			local var_72_10 = getHeroCurrentRebirthCountAttrs(iter_72_3.heroId, iter_72_3.rebirthCount).talentDescIndex

			if not var_72_10 or var_72_10 == 0 then
				var_72_10 = 0
			end

			if var_72_10 > table.nums(BaseSkills[iter_72_3.talentId].desc) then
				var_72_10 = table.nums(BaseSkills[iter_72_3.talentId].desc)
			end

			var_72_9.talentEffect.count = var_72_10 - 1 + 2
		end

		if iter_72_3.currentHealth <= 0 then
			arg_72_0:death(BattleData:getDisplayNode(iter_72_3.battleIx), 0.8 * BattleSpeed)
		end
	end

	for iter_72_4, iter_72_5 in pairs(BattleData.enemy) do
		if iter_72_5.talentId == 10019 then
			local var_72_11 = BattleData:getDisplayNode(iter_72_5.battleIx)

			var_72_11.talentEffect = BattleSkeleton:addEffect({
				effectName = "buff_mianyi",
				loop = true,
				animation = "buff_mianyi_xunhuan",
				parent = var_72_11,
				position = ccp(0, 150),
				scale = originalScale()
			})

			local var_72_12 = 2

			if not var_72_12 or var_72_12 == 0 then
				var_72_12 = 0
			end

			if var_72_12 > table.nums(BaseSkills[iter_72_5.talentId].desc) then
				var_72_12 = table.nums(BaseSkills[iter_72_5.talentId].desc)
			end

			var_72_11.talentEffect.count = var_72_12 - 1 + 2
		end

		if iter_72_5.currentHealth <= 0 then
			arg_72_0:death(BattleData:getDisplayNode(iter_72_5.battleIx), 0.8 * BattleSpeed)
		end
	end

	if not BattleData.preBattle or #BattleData.preBattle == 0 then
		arg_72_1()
	else
		BattleAudio:Sound_playEffect(BattleAudio.status_tianfuji)

		local var_72_13 = CCArray:create()

		var_72_13:addObject(CCDelayTime:create(1 * BattleSpeed))
		var_72_13:addObject(CCCallFunc:create(function(...)
			arg_72_1()
		end))
		CCDirector:sharedDirector():getRunningScene():runAction(CCSequence:create(var_72_13))
	end
end
