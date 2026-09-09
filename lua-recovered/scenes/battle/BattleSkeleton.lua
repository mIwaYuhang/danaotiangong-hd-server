BattleSkeleton = {}

local var_0_0 = true
local var_0_1 = 1.1

BattleAttackType = {
	ePuTong = 1,
	eDaZhao = 2
}

function BattleSkeleton.refreshNode(arg_1_0, arg_1_1)
	arg_1_1.Skeleton:setToSetupPose()
	figure.setupFigure(arg_1_1.viewParam)
end

local function var_0_2(arg_2_0)
	local var_2_0 = {}

	for iter_2_0 = 1, table.getn(arg_2_0), 3 do
		for iter_2_1, iter_2_2 in pairs(var_2_0) do
			if iter_2_2 == arg_2_0[iter_2_0 + 1] then
				if var_0_0 then
					dump(arg_2_0)
					dump("-------时刻相同BUG-------")
				end

				return
			end
		end

		table.insert(var_2_0, arg_2_0[iter_2_0 + 1])
	end
end

local function var_0_3(arg_3_0, arg_3_1)
	if arg_3_0.name and var_0_0 then
		dump("------动作打断BUG---------", arg_3_1)
	end

	arg_3_0:addAnimationAction(arg_3_1, 0.001, CCCallFunc:create(function(...)
		arg_3_0.name = arg_3_1
	end), AAT_Percent)
	arg_3_0:addAnimationAction(arg_3_1, 0.999, CCCallFunc:create(function(...)
		arg_3_0.name = nil
	end), AAT_Percent)
end

function BattleSkeleton.actionAttack(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = BattleData:getProfession(arg_6_2.idx)

	if var_6_0 == HeroProfession.eCommander then
		arg_6_0.updateSpeed(arg_6_2.Skeleton, var_0_1)
	elseif var_6_0 == HeroProfession.eWarrior then
		arg_6_0.updateSpeed(arg_6_2.Skeleton, var_0_1)
	elseif var_6_0 == HeroProfession.eMage then
		arg_6_0.updateSpeed(arg_6_2.Skeleton, var_0_1)
	else
		arg_6_0.updateSpeed(arg_6_2.Skeleton, var_0_1)
	end

	local var_6_1 = ""

	if arg_6_1 == BattleAttackType.ePuTong then
		var_6_1 = "putong"
	elseif arg_6_1 == BattleAttackType.eDaZhao then
		var_6_1 = "dazhao"
	end

	arg_6_0:refreshNode(arg_6_2)
	arg_6_2.Skeleton:setAnimation(var_6_1, false, 0)

	if arg_6_3 then
		var_0_2(arg_6_3)

		for iter_6_0 = 1, table.getn(arg_6_3), 3 do
			arg_6_2.Skeleton:addAnimationAction(var_6_1, arg_6_3[iter_6_0 + 1], CCCallFunc:create(arg_6_3[iter_6_0]), arg_6_3[iter_6_0 + 2])
		end
	end

	var_0_3(arg_6_2.Skeleton, var_6_1)
end

function BattleSkeleton.actionSkillFirst(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.updateSpeed(arg_7_1.Skeleton, var_0_1)
	arg_7_0:refreshNode(arg_7_1)
	arg_7_1.Skeleton:setAnimation("chufa", false, 0)

	if arg_7_2 then
		var_0_2(arg_7_2)

		for iter_7_0 = 1, table.getn(arg_7_2), 3 do
			arg_7_1.Skeleton:addAnimationAction("chufa", arg_7_2[iter_7_0 + 1], CCCallFunc:create(arg_7_2[iter_7_0]), arg_7_2[iter_7_0 + 2])
		end
	end

	var_0_3(arg_7_1.Skeleton, "chufa")
end

function BattleSkeleton.actionSkillSecond(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.updateSpeed(arg_8_1.Skeleton, var_0_1)
	arg_8_0:refreshNode(arg_8_1)
	arg_8_1.Skeleton:setAnimation("teji", false, 0)

	if arg_8_2 then
		var_0_2(arg_8_2)

		for iter_8_0 = 1, table.getn(arg_8_2), 3 do
			arg_8_1.Skeleton:addAnimationAction("teji", arg_8_2[iter_8_0 + 1], CCCallFunc:create(arg_8_2[iter_8_0]), arg_8_2[iter_8_0 + 2])
		end
	end

	var_0_3(arg_8_1.Skeleton, "teji")
end

function BattleSkeleton.actionInjured(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.updateSpeed(arg_9_1.Skeleton, var_0_1)
	arg_9_0:refreshNode(arg_9_1)
	arg_9_1.Skeleton:setAnimation("aida", false, 0)
	arg_9_1.Skeleton:addAnimationAction("aida", 0, CCCallFunc:create(function(...)
		local var_10_0 = CCArray:create()

		var_10_0:addObject(CCCallFunc:create(function(...)
			arg_9_1.Skeleton:setColor(ccc3(255, 0, 0))
		end))
		var_10_0:addObject(CCDelayTime:create(0.1 * BattleSpeed))
		var_10_0:addObject(CCCallFunc:create(function(...)
			arg_9_1.Skeleton:setColor(ccc3(255, 255, 255))
		end))
		var_10_0:addObject(CCDelayTime:create(0.1 * BattleSpeed))
		arg_9_1.Skeleton:runAction(CCRepeat:create(CCSequence:create(var_10_0), 3))
	end), AAT_Percent)

	if arg_9_2 then
		arg_9_1.Skeleton:addAnimationAction("aida", arg_9_2.time, CCCallFunc:create(arg_9_2.callback), arg_9_2.type)
	end

	var_0_3(arg_9_1.Skeleton, "aida")
end

function BattleSkeleton.actionWait(arg_13_0, arg_13_1)
	if arg_13_1.Skeleton.name then
		if var_0_0 then
			dump("------动作打断BUG---------", arg_13_1.Skeleton.name)
		end
	else
		arg_13_0.updateSpeed(arg_13_1.Skeleton)
		arg_13_0:refreshNode(arg_13_1)
		arg_13_1.Skeleton:setAnimation("daiji", true, 0)
	end
end

function BattleSkeleton.actionGedang(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.updateSpeed(arg_14_1.Skeleton, var_0_1)
	arg_14_0:refreshNode(arg_14_1)
	arg_14_1.Skeleton:setAnimation("gedang", false, 0)

	if arg_14_2 then
		arg_14_1.Skeleton:addAnimationAction("gedang", arg_14_2.time, CCCallFunc:create(arg_14_2.callback), arg_14_2.type)
	end

	var_0_3(arg_14_1.Skeleton, "gedang")
end

function BattleSkeleton.addEffect(arg_15_0, arg_15_1)
	if arg_15_1.loop == nil then
		arg_15_1.loop = false
	end

	if not arg_15_1.scale then
		arg_15_1.scale = 1
	end

	if not arg_15_1.animation then
		arg_15_1.animation = "animation"
	end

	local var_15_0 = CCSkeletonAnimation:createWithFile("effectAni/" .. arg_15_1.effectName .. ".json", "effectAni/" .. arg_15_1.effectName .. ".atlas", 1)

	arg_15_0.updateSpeed(var_15_0, arg_15_1.speed)
	var_15_0:setToSetupPose()

	if not arg_15_1.stop then
		var_15_0:setAnimation(arg_15_1.animation, arg_15_1.loop, 0)
	end

	if arg_15_1.position then
		var_15_0:setPosition(arg_15_1.position)
	end

	if arg_15_1.callbacklist then
		for iter_15_0 = 1, table.getn(arg_15_1.callbacklist), 3 do
			var_15_0:addAnimationAction(arg_15_1.animation, arg_15_1.callbacklist[iter_15_0 + 1], CCCallFunc:create(arg_15_1.callbacklist[iter_15_0]), arg_15_1.callbacklist[iter_15_0 + 2])
		end
	end

	if arg_15_1.parent then
		arg_15_1.parent:addChild(var_15_0)
	end

	var_15_0:setScale(arg_15_1.scale)

	if arg_15_1.skin then
		var_15_0:setSkin(arg_15_1.skin)
		var_15_0:setToSetupPose()
	end

	local var_15_1 = ccBlendFunc:new()

	var_15_1.src, var_15_1.dst = GL_ONE, GL_ONE_MINUS_SRC_ALPHA

	var_15_0:setBlendFunc(var_15_1)

	return var_15_0
end

function BattleSkeleton.copy(arg_16_0, arg_16_1)
	local var_16_0 = BattleData:findTarget(arg_16_0.idx)
	local var_16_1 = {
		platTable = false,
		scale = 1,
		isViewQuality = false
	}

	if not arg_16_1 and not arg_16_0.isHero then
		var_16_1.rotation = true
	end

	if arg_16_0.trasformId then
		var_16_1.transAnim = arg_16_0.trasformId
	elseif var_16_0.heroId then
		var_16_1.figId = var_16_0.heroId
	else
		var_16_1.enemyId = var_16_0.npcId

		if arg_16_0.Skeleton.trasformId then
			var_16_1.enemyId = arg_16_0.Skeleton.trasformId
		end
	end

	local var_16_2 = figure.createHero(var_16_1)

	var_16_2:setPosition(arg_16_0:getPosition())
	var_16_2:setScale(arg_16_0:getScale())

	if not arg_16_1 then
		arg_16_0:getParent():addChild(var_16_2, (arg_16_0.idx - 1) % 3)
	end

	if arg_16_0.trasformId then
		local var_16_3 = {
			figureNode = var_16_2,
			skinName = arg_16_0.viewParam.skinName,
			equipId = arg_16_0.viewParam.equipId,
			heroId = arg_16_0.viewParam.heroId,
			enemyId = arg_16_0.viewParam.enemyId,
			pinjie = arg_16_0.viewParam.pinjie,
			wing = arg_16_0.viewParam.wing
		}

		figure.setupFigure(var_16_3)
	else
		local var_16_4 = {
			figureNode = var_16_2,
			rebirthCount = arg_16_0.viewParam.rebirthCount,
			equipId = arg_16_0.viewParam.equipId,
			heroId = arg_16_0.viewParam.heroId,
			enemyId = arg_16_0.viewParam.enemyId,
			pinjie = arg_16_0.viewParam.pinjie,
			wing = arg_16_0.viewParam.wing
		}

		figure.setupFigure(var_16_4)
	end

	return var_16_2
end

function BattleSkeleton.updateSpeed(arg_17_0, arg_17_1)
	if not arg_17_0 then
		return
	end

	if arg_17_1 then
		arg_17_0:setTest(1 / BattleSpeed * arg_17_1, false, false, true)
	else
		arg_17_0:setTest(1 / BattleSpeed, false, false, true)
	end
end

function BattleSkeleton.setHide(arg_18_0, arg_18_1)
	arg_18_0.Skeleton:setVisible(arg_18_1)
	arg_18_0.shadow:setVisible(arg_18_1)
	arg_18_0.shadow:setVisible(arg_18_1)
	arg_18_0.progressNode:setVisible(arg_18_1)

	if arg_18_0.wing then
		arg_18_0.wing:setVisible(arg_18_1)
	end

	if arg_18_0.stateicon then
		for iter_18_0, iter_18_1 in pairs(arg_18_0.stateicon) do
			iter_18_1:setVisible(arg_18_1)
		end
	end

	if arg_18_0.wing then
		arg_18_0.wing:setVisible(arg_18_1)
	end
end

function BattleSkeleton.createHalo(arg_19_0, arg_19_1)
	local var_19_0 = CCNode:create()

	arg_19_0:addChild(var_19_0, -10)
	var_19_0:setScale(0.9)

	local var_19_1

	if arg_19_1 == QualityType.eGreen then
		var_19_1 = "ui/battle/halo1.png"
	elseif arg_19_1 == QualityType.eBlue then
		var_19_1 = "ui/battle/halo2.png"
	elseif arg_19_1 == QualityType.ePurple then
		var_19_1 = "ui/battle/halo3.png"
	elseif arg_19_1 == QualityType.eOrange then
		var_19_1 = "ui/battle/halo4.png"
	end

	local var_19_2 = CCSprite:create(var_19_1)

	var_19_0:addChild(var_19_2)
	var_19_2:runAction(CCRepeatForever:create(CCRotateBy:create(1, 90)))
	var_19_2:setPosition(0, 50)
	var_19_2:setOpacity(200)
	var_19_0:getCamera():setEyeXYZ(0, -180, 70)
	arg_19_0:getCamera():setEyeXYZ(0, 0, 100)

	return var_19_0
end

function BattleSkeleton.createStun(arg_20_0)
	local var_20_0 = CCNode:create()

	arg_20_0:addChild(var_20_0, 2)

	local var_20_1 = CCSprite:create("ui/battle/stun.png")

	var_20_0:addChild(var_20_1)
	var_20_1:runAction(CCRepeatForever:create(CCRotateBy:create(1, 180)))
	var_20_1:setPosition(0, 550)
	var_20_1:setOpacity(200)
	var_20_0:getCamera():setEyeXYZ(0, -180, 70)
	arg_20_0:getCamera():setEyeXYZ(0, 0, 100)

	return var_20_0
end

function BattleSkeleton.actionList(arg_21_0, arg_21_1)
	if arg_21_1 then
		local var_21_0 = {}

		for iter_21_0 = 1, table.getn(arg_21_1), 3 do
			local var_21_1 = {
				time = arg_21_1[iter_21_0 + 1],
				func = arg_21_1[iter_21_0]
			}

			table.insert(var_21_0, var_21_1)
		end

		table.sort(var_21_0, function(arg_22_0, arg_22_1)
			return arg_22_0.time < arg_22_1.time
		end)

		local var_21_2 = {}
		local var_21_3 = 1
		local var_21_4

		while var_21_3 <= table.getn(var_21_0) do
			if var_21_4 then
				if var_21_4.time == var_21_0[var_21_3].time then
					function var_21_4.func(...)
						var_21_4.func()
						var_21_0[var_21_3].func()
					end
				else
					table.insert(var_21_2, var_21_4)

					var_21_4 = var_21_0[var_21_3]
				end
			else
				var_21_4 = var_21_0[var_21_3]
			end

			var_21_3 = var_21_3 + 1
		end

		table.insert(var_21_2, var_21_4)

		local var_21_5 = CCArray:create()
		local var_21_6 = 0

		for iter_21_1, iter_21_2 in pairs(var_21_2) do
			var_21_5:addObject(CCDelayTime:create((iter_21_2.time - var_21_6) * arg_21_0))
			var_21_5:addObject(CCCallFunc:create(iter_21_2.func))

			var_21_6 = iter_21_2.time
		end

		return var_21_5
	end
end
