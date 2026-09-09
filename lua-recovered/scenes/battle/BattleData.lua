require("data.ShenQi")

BattleDeathType = {
	eLive = 3,
	eDeathing = 2,
	eDead = 1
}
BattleEffectType = {
	eShanBi = 4,
	eGeDang = 3,
	eBaoJi = 2,
	eNormal = 1
}
BattleTalentStep = {
	eNull = 0,
	eBeforeAttack = 1,
	eAfterDead = 4,
	eHurt = 2,
	eAfterHurt = 3
}
BattleStateType = {
	eNormalAttackDown = 5,
	eSilence = 1,
	eShanbiUp = 108,
	eSkillDefenseDown = 4,
	eSkillDefenseUp = 104,
	eDuanxu = 201,
	eDefenseDown = 8,
	eBaojiUp = 109,
	eGedangUp = 111,
	ePojiUp = 112,
	eMingzhongUp = 107,
	eAttackDown = 7,
	eAttackUp = 105,
	eSkillAttackUp = 102,
	eNormalDefenseUp = 103,
	eSkillAttackDown = 6,
	eNormalDefenseDown = 3,
	eRenxingUp = 110,
	eStun = 2,
	eNormalAttackUp = 101,
	eDefenseUp = 106
}
BattleSkillType = {
	eRage = 2,
	eTalent = 3,
	eArtifact = 4,
	eNormal = 1
}
BattlePreBattleType = {
	eNormalDefense = 3,
	eNormalAttack = 2,
	eShanbi = 7,
	ePoji = 10,
	eGedang = 11,
	eRenxing = 9,
	eSpeed = 12,
	eMingzhong = 6,
	eSkillAttack = 4,
	eBaoji = 8,
	eSkillDefense = 5,
	eHealth = 1,
	eRage = 13
}
BattleData = {
	stage,
	totalStage,
	result,
	reward,
	round,
	maxRound,
	step,
	maxStep,
	roundAction = {},
	Heros = {},
	enemy = {},
	numHero,
	numEnemy,
	preBattle,
	BattleReward,
	displayHero = {},
	displayEnemy = {},
	IsFirst
}
FigureSize = 0.5 * Adapter.MinScale

function originalScale()
	return 1 / FigureSize * Adapter.MinScale
end

BattleSpeed = 1
BattleSpeedOriginal = 1

local function var_0_0(arg_2_0, arg_2_1)
	arg_2_0.step = arg_2_1
end

function BattleData.reset(arg_3_0)
	arg_3_0.stage = 0
end

function BattleData.checkWeaponError(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	if BaseEquips[arg_4_2] and BaseEquips[arg_4_2].equipType == EquipType.eWeapon and (arg_4_4 and BaseHeros[arg_4_4].profession == BaseEquips[arg_4_2].profession or arg_4_5 and BaseNPCs[arg_4_5].profession == BaseEquips[arg_4_2].profession) then
		arg_4_1.weaponId = arg_4_2
		arg_4_1.pinjie = arg_4_3

		return
	end

	arg_4_1.weaponId = 0
	arg_4_1.pinjie = 0

	if arg_4_2 ~= 0 then
		dump("----BUG 后台传回来的武器id有错误--------", arg_4_2)
	end
end

function BattleData.init(arg_5_0, arg_5_1)
	arg_5_0.stage = arg_5_0.stage + 1
	arg_5_0.totalStage = arg_5_1.total == 0 and 1 or arg_5_1.total
	arg_5_0.round = 1
	arg_5_0.numHero = 0
	arg_5_0.numEnemy = 0
	arg_5_0.roundAction = {}
	arg_5_0.effectRoundOver = {}
	arg_5_0.Heros = {}
	arg_5_0.enemy = {}
	arg_5_0.preBattle = {}
	arg_5_0.shenqiList = {}

	table.foreach(arg_5_1.battleHeros, function(arg_6_0, arg_6_1)
		if arg_6_1.posId >= 1 and arg_6_1.posId <= 6 then
			local var_6_0 = {
				heroId = arg_6_1.heroId,
				battleIx = arg_6_1.posId,
				currentHealth = arg_6_1.health,
				maxHealth = arg_6_1.healthMax,
				rage = arg_6_1.rage
			}

			var_6_0.isHero = true
			var_6_0.usedSkill = {}
			arg_5_0.Heros[var_6_0.battleIx] = var_6_0
			arg_5_0.numHero = arg_5_0.numHero + 1
			var_6_0.death = BattleDeathType.eLive
			var_6_0.rebirthCount = arg_6_1.rebirthCount

			arg_5_0:checkWeaponError(var_6_0, arg_6_1.weaponId, arg_6_1.wq, var_6_0.heroId, nil)

			var_6_0.skillId = BaseHeros[arg_6_1.heroId].skillId
			var_6_0.talentId = BaseHeros[arg_6_1.heroId].talentId
			var_6_0.halolv = arg_6_1.halolv
		elseif arg_6_1.posId >= 7 and arg_6_1.posId <= 12 then
			local var_6_1 = {}

			if arg_6_1.heroId ~= 0 then
				var_6_1.heroId = arg_6_1.heroId
			elseif arg_6_1.npcId ~= 0 then
				var_6_1.npcId = arg_6_1.npcId
				var_6_1.npcSize = arg_6_1.npcSize
			end

			var_6_1.battleIx = arg_6_1.posId
			var_6_1.currentHealth = arg_6_1.health
			var_6_1.maxHealth = arg_6_1.healthMax
			var_6_1.rage = arg_6_1.rage
			var_6_1.isHero = false
			var_6_1.usedSkill = {}
			arg_5_0.enemy[var_6_1.battleIx] = var_6_1
			arg_5_0.numEnemy = arg_5_0.numEnemy + 1
			var_6_1.death = BattleDeathType.eLive
			var_6_1.rebirthCount = arg_6_1.rebirthCount
			var_6_1.halolv = arg_6_1.halolv

			if arg_6_1.heroId ~= 0 then
				var_6_1.skillId = BaseHeros[arg_6_1.heroId].skillId
				var_6_1.talentId = BaseHeros[arg_6_1.heroId].talentId

				arg_5_0:checkWeaponError(var_6_1, arg_6_1.weaponId, arg_6_1.wq, var_6_1.heroId, var_6_1.npcId)
			elseif arg_6_1.npcId ~= 0 then
				var_6_1.skillId = BaseNPCs[arg_6_1.npcId].skillId
				var_6_1.talentId = BaseNPCs[arg_6_1.npcId].talentId
				var_6_1.weaponId = BaseNPCs[arg_6_1.npcId].equipId
			end

			var_6_1.transformd = false
		end
	end)

	if #arg_5_1.battleRecords == 0 then
		dump("------------battleRecords 服务器端没有返回战斗数据------------------")
	end

	table.foreach(arg_5_1.battleRecords, function(arg_7_0, arg_7_1)
		if BattleData.roundAction[arg_7_1.roundCount] == nil then
			BattleData.roundAction[arg_7_1.roundCount] = {}
		end

		local var_7_0 = {
			skillType = arg_7_1.skillType,
			position = arg_7_1.posId,
			bar = {}
		}

		var_7_0.bar.health = arg_7_1.health
		var_7_0.bar.rage = arg_7_1.rage
		var_7_0.bar.maxHp = arg_7_1.hpmax

		if arg_7_1.ts then
			var_7_0.talentSkill = {
				position = var_7_0.position,
				hasNext = arg_7_1.ts.hns
			}

			var_0_0(var_7_0.talentSkill, arg_7_1.ts.ts)
		end

		var_7_0.affectList = {}

		table.foreach(arg_7_1.affectList, function(arg_8_0, arg_8_1)
			local var_8_0 = {
				position = arg_8_1.posId,
				bar = {}
			}

			var_8_0.bar.health = arg_8_1.health
			var_8_0.bar.rage = arg_8_1.rage
			var_8_0.bar.maxHp = arg_8_1.hpmax
			var_8_0.state = arg_8_1.state
			var_8_0.effect = arg_8_1.effect
			var_8_0.rebirth = arg_8_1.rev

			table.insert(var_7_0.affectList, var_8_0)

			if arg_8_1.ts then
				var_8_0.talentSkill = {
					position = arg_8_1.posId,
					hasNext = arg_8_1.ts.hns
				}

				var_0_0(var_8_0.talentSkill, arg_8_1.ts.ts)
			end

			if arg_8_1.trans then
				var_8_0.trans = {
					npcId = arg_8_1.trans.npcId,
					npcSize = arg_8_1.trans.npcSize,
					health = arg_8_1.trans.health,
					rage = arg_8_1.trans.rage,
					pos = arg_8_1.trans.posId
				}
			end
		end)

		if arg_7_1.Step then
			local var_7_1 = {}

			table.insert(var_7_1, var_7_0)
			table.insert(BattleData.roundAction[arg_7_1.roundCount], var_7_1)
		else
			table.insert(BattleData.roundAction[arg_7_1.roundCount][#BattleData.roundAction[arg_7_1.roundCount]], var_7_0)
		end
	end)

	if arg_5_1.preBattle then
		table.foreach(arg_5_1.preBattle, function(arg_9_0, arg_9_1)
			local var_9_0 = {
				position = arg_9_1.posId,
				skillType = arg_9_1.skillType,
				type = arg_9_1.pt,
				value = arg_9_1.pv
			}

			table.insert(arg_5_0.preBattle, var_9_0)
		end)
	end

	if arg_5_1.battleArtifacts then
		for iter_5_0, iter_5_1 in pairs(arg_5_1.battleArtifacts) do
			local var_5_0 = {
				posId = iter_5_1.posId,
				lv = iter_5_1.Star,
				star = iter_5_1.lv
			}

			table.insert(arg_5_0.shenqiList, var_5_0)
		end
	end

	arg_5_0.result = arg_5_1.isWin
	arg_5_0.reward = arg_5_1.dropList
	arg_5_0.maxRound = table.getn(arg_5_0.roundAction)
	arg_5_0.step = 1
	arg_5_0.maxStep = table.getn(arg_5_0.roundAction[arg_5_0.round])

	if arg_5_1.BattleResult then
		arg_5_0.BattleReward = arg_5_1.BattleResult
		arg_5_0.BattleReward.global = arg_5_1.Reward
		arg_5_0.IsFirst = arg_5_1.BattleResult.IsFirst
	else
		arg_5_0.BattleReward = arg_5_1.Reward
	end

	arg_5_0.globalReward = arg_5_1.Reward
	arg_5_0.enemyName = arg_5_1.enemy
	arg_5_0.playerName = arg_5_1.self and arg_5_1.self.Name or nil
	arg_5_0.kuanghua = arg_5_1.em == 1
	arg_5_0.guanghuan = arg_5_1.ehalo == 1
end

function BattleData.checkBattleFormation(arg_10_0)
	local var_10_0 = 0
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in pairs(arg_10_0.Heros) do
		if iter_10_1.heroId ~= 0 then
			for iter_10_2, iter_10_3 in ipairs(Player.team.groupList) do
				if iter_10_1.heroId == iter_10_3.heroId and iter_10_1.battleIx == iter_10_3.battleIx then
					var_10_0 = var_10_0 + 1

					break
				end
			end

			var_10_1 = var_10_1 + 1
		end
	end

	if var_10_0 == var_10_1 then
		return true
	else
		return false
	end
end

function BattleData.findTarget(arg_11_0, arg_11_1)
	if not arg_11_1 then
		dump("--------BUG 位置id不存在--------")
		arg_11_1()
	end

	if arg_11_1 <= 6 and arg_11_1 >= 1 then
		return arg_11_0.Heros[arg_11_1]
	elseif arg_11_1 >= 7 and arg_11_1 <= 12 then
		return arg_11_0.enemy[arg_11_1]
	end

	return nil
end

function BattleData.getDisplayNode(arg_12_0, arg_12_1)
	local var_12_0
	local var_12_1 = arg_12_0:findTarget(arg_12_1)

	if var_12_1 and var_12_1.isHero then
		var_12_0 = arg_12_0.displayHero[arg_12_1]

		if var_12_0 then
			var_12_0.isHero = true
		end
	else
		var_12_0 = arg_12_0.displayEnemy[arg_12_1]

		if var_12_0 then
			var_12_0.isHero = false
		end
	end

	return var_12_0
end

function BattleData.addHealth(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:findTarget(arg_13_1)

	if var_13_0 then
		var_13_0.currentHealth = var_13_0.currentHealth + arg_13_2
		var_13_0.currentHealth = var_13_0.currentHealth > var_13_0.maxHealth and var_13_0.maxHealth or var_13_0.currentHealth

		return var_13_0.currentHealth > 0
	end
end

function BattleData.setHealth(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0:findTarget(arg_14_1)

	if var_14_0 then
		var_14_0.currentHealth = arg_14_2
	end
end

function BattleData.addMaxHp(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:findTarget(arg_15_1)

	if var_15_0 then
		var_15_0.maxHealth = var_15_0.maxHealth + arg_15_2
	end
end

function BattleData.addRage(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0:findTarget(arg_16_1)

	if var_16_0 then
		var_16_0.rage = var_16_0.rage + arg_16_2
		var_16_0.rage = var_16_0.rage > 200 and 200 or var_16_0.rage
		var_16_0.rage = var_16_0.rage < 0 and 0 or var_16_0.rage
	end
end

function BattleData.addRound(arg_17_0)
	arg_17_0.round = arg_17_0.round + 1

	if arg_17_0.round > 20 or arg_17_0.round > arg_17_0.maxRound then
		return false
	end

	arg_17_0.step = 1
	arg_17_0.maxStep = table.getn(arg_17_0.roundAction[arg_17_0.round])

	return true
end

function BattleData.addStep(arg_18_0)
	arg_18_0.step = arg_18_0.step + 1

	return arg_18_0.step <= arg_18_0.maxStep
end

function BattleData.getPosition(arg_19_0, arg_19_1)
	if arg_19_1 <= 6 and arg_19_1 >= 1 then
		return arg_19_0.pos_Hero[arg_19_1]
	elseif arg_19_1 >= 7 and arg_19_1 <= 12 then
		return arg_19_0.pos_Enemy[arg_19_1 - 6]
	end

	return nil
end

function BattleData.manageState(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0:findTarget(arg_20_1)

	if arg_20_2.round == 0 then
		for iter_20_0, iter_20_1 in pairs(var_20_0.usedSkill) do
			if iter_20_1.id == arg_20_2.id then
				table.remove(var_20_0.usedSkill, iter_20_0)

				break
			end
		end

		return -1
	else
		for iter_20_2, iter_20_3 in pairs(var_20_0.usedSkill) do
			if iter_20_3.id == arg_20_2.id then
				iter_20_3.round = arg_20_2.round

				return 0
			end
		end

		arg_20_2.position = arg_20_1

		table.insert(var_20_0.usedSkill, arg_20_2)

		return 1
	end
end

function BattleData.roundEnd(arg_21_0)
	if arg_21_0:addRound() then
		local var_21_0 = {}

		for iter_21_0, iter_21_1 in pairs(BattleData.Heros) do
			for iter_21_2, iter_21_3 in pairs(iter_21_1.usedSkill) do
				iter_21_3.round = iter_21_3.round - 1

				if iter_21_3.round <= 0 then
					table.insert(var_21_0, iter_21_3)

					iter_21_1.usedSkill[iter_21_2] = nil
				end
			end
		end

		for iter_21_4, iter_21_5 in pairs(BattleData.enemy) do
			for iter_21_6, iter_21_7 in pairs(iter_21_5.usedSkill) do
				iter_21_7.round = iter_21_7.round - 1

				if iter_21_7.round <= 0 then
					table.insert(var_21_0, iter_21_7)

					iter_21_5.usedSkill[iter_21_6] = nil
				end
			end
		end

		return true, var_21_0
	else
		return false
	end
end

function BattleData.getProfession(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:findTarget(arg_22_1)

	if var_22_0 then
		if var_22_0.npcId then
			return BaseNPCs[var_22_0.npcId].profession
		end

		if var_22_0.heroId then
			return BaseHeros[var_22_0.heroId].profession
		end
	end
end

function BattleData.dead(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 <= 6 and arg_23_1 >= 1 then
		arg_23_0.Heros[arg_23_1].death = arg_23_2 and BattleDeathType.eDead or BattleDeathType.eDeathing
	elseif arg_23_1 >= 7 and arg_23_1 <= 12 then
		arg_23_0.enemy[arg_23_1].death = arg_23_2 and BattleDeathType.eDead or BattleDeathType.eDeathing
	end
end

function BattleData.isTeam(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 <= 6 and arg_24_1 >= 1 then
		if arg_24_2 <= 6 and arg_24_2 >= 1 then
			return true
		else
			return false
		end
	elseif arg_24_1 >= 7 and arg_24_1 <= 12 then
		if arg_24_2 >= 7 and arg_24_2 <= 12 then
			return true
		else
			return false
		end
	end
end

function BattleData.HeroHasSecond(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.Heros) do
		if iter_25_1.currentHealth > 0 and iter_25_1.battleIx >= 4 then
			return true
		end
	end

	return false
end

function BattleData.HeroHasFirst(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.Heros) do
		if iter_26_1.currentHealth > 0 and iter_26_1.battleIx < 4 then
			return true
		end
	end

	return false
end

function BattleData.EnemyHasSecond(arg_27_0)
	for iter_27_0, iter_27_1 in pairs(arg_27_0.enemy) do
		if iter_27_1.currentHealth > 0 and iter_27_1.battleIx >= 10 then
			return true
		end
	end

	return false
end

function BattleData.EnemyHasFirst(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0.enemy) do
		if iter_28_1.currentHealth > 0 and iter_28_1.battleIx < 10 then
			return true
		end
	end

	return false
end

function BattleData.countCurrentHP(arg_29_0, arg_29_1)
	local var_29_0 = 0

	if arg_29_1 then
		for iter_29_0, iter_29_1 in pairs(arg_29_0.Heros) do
			if iter_29_1.currentHealth > 0 then
				var_29_0 = var_29_0 + iter_29_1.currentHealth
			end
		end
	else
		for iter_29_2, iter_29_3 in pairs(arg_29_0.enemy) do
			if iter_29_3.currentHealth > 0 then
				var_29_0 = var_29_0 + iter_29_3.currentHealth
			end
		end
	end

	return var_29_0
end

function BattleData.countTotalHP(arg_30_0, arg_30_1)
	local var_30_0 = 0

	if arg_30_1 then
		for iter_30_0, iter_30_1 in pairs(arg_30_0.Heros) do
			var_30_0 = var_30_0 + iter_30_1.maxHealth
		end
	else
		for iter_30_2, iter_30_3 in pairs(arg_30_0.enemy) do
			var_30_0 = var_30_0 + iter_30_3.maxHealth
		end
	end

	return var_30_0
end

function BattleData.checkTransform(arg_31_0)
	local var_31_0 = {}

	for iter_31_0, iter_31_1 in pairs(arg_31_0.enemy) do
		if iter_31_1.npcId then
			local var_31_1 = 0.9

			if var_31_1 ~= 0 and not iter_31_1.transformd then
				local var_31_2 = iter_31_1.currentHealth / iter_31_1.maxHealth

				if var_31_2 > 0 and var_31_2 <= var_31_1 then
					iter_31_1.transformd = true

					table.insert(var_31_0, {
						npcSize = 1,
						skinName = "dengji1",
						animation = "yeshou_fuxi_nan_diji",
						node = BattleData:getDisplayNode(iter_31_1.battleIx),
						equipId = BaseNPCs[iter_31_1.npcId].equipId_trans,
						npcId = iter_31_1.npcId
					})
				end
			end
		end
	end

	return var_31_0
end

function BattleData.checkRestrain(arg_32_0, arg_32_1, arg_32_2)
	if not arg_32_1 or arg_32_0:isTeam(arg_32_1, arg_32_2) then
		return 0
	end

	local var_32_0 = BattleData:getProfession(arg_32_1)
	local var_32_1 = BattleData:getProfession(arg_32_2)

	if var_32_0 == var_32_1 then
		return 0
	end

	if var_32_0 == HeroProfession.eCommander and var_32_1 == HeroProfession.eWarrior then
		return 1
	end

	if var_32_0 == HeroProfession.eMage and var_32_1 == HeroProfession.eCommander then
		return 1
	end

	if var_32_0 == HeroProfession.eWarrior and var_32_1 == HeroProfession.eMage then
		return 1
	end

	return 0
end

function BattleData.transformd(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = arg_33_0:findTarget(arg_33_1)

	var_33_0.npcId = arg_33_2.npcId
	var_33_0.npcSize = arg_33_2.npcSize
	var_33_0.currentHealth = arg_33_2.health
	var_33_0.maxHealth = arg_33_2.health
	var_33_0.rage = arg_33_2.rage

	arg_33_3.progressLayer:updateProgress(arg_33_1)

	for iter_33_0, iter_33_1 in pairs(var_33_0.usedSkill) do
		arg_33_3.stateLayer:deleteIconAni(to_node, iter_33_1)
	end

	var_33_0.usedSkill = {}
	var_33_0.skillId = BaseNPCs[arg_33_2.npcId].skillId
	var_33_0.talentId = BaseNPCs[arg_33_2.npcId].talentId
end

function orderScale_num(arg_34_0)
	return 1 - arg_34_0.y / (BattleData.pos_Hero[1].y + Adapter.AutoScaleY * 50) * 0.19999999999999996
end

function orderScale(arg_35_0, arg_35_1)
	local var_35_0 = orderScale_num(arg_35_1)

	if not arg_35_0.order_scale_order then
		arg_35_0.order_scale_order = arg_35_0:getScale()
	end

	arg_35_0:setScale(arg_35_0.order_scale_order * var_35_0)
end

function orderScale_action(arg_36_0, arg_36_1, arg_36_2)
	arg_36_0:runAction(CCMoveTo:create(arg_36_2, arg_36_1))

	local var_36_0 = orderScale_num(arg_36_1)

	if not arg_36_0.order_scale_order then
		arg_36_0.order_scale_order = arg_36_0:getScale()
	end

	arg_36_0:runAction(CCScaleTo:create(arg_36_2, arg_36_0.order_scale_order * var_36_0))
end

function orderScale_stopAction(arg_37_0)
	arg_37_0:stopAllActions()
end

function BattleData.getEnemyCarrier(arg_38_0, ...)
	if arg_38_0.shenqiList then
		for iter_38_0, iter_38_1 in pairs(arg_38_0.shenqiList) do
			if iter_38_1.posId > 6 then
				return iter_38_1.lv
			end
		end
	end

	return 0
end

BattleCarrier = {
	eNone = 0,
	eYuruyi2 = 8,
	eJian1 = 1,
	eHulu2 = 9,
	eJian2 = 10,
	eHulu1 = 5,
	eYujingping2 = 7,
	eBajiaoshan1 = 2,
	eYujingping1 = 3,
	eBajiaoshan2 = 6,
	eYuruyi1 = 4
}

function queryCarrierFile(arg_39_0)
	if arg_39_0 and type(arg_39_0) == "number" and arg_39_0 ~= 0 then
		return string.format("body/%s", BaseShenQi[arg_39_0].image)
	else
		return "ui/battle/carrierSward.png"
	end
end

function BattleData.initGuider(arg_40_0)
	arg_40_0.stage = 1
	arg_40_0.totalStage = 1
	arg_40_0.round = 1
	arg_40_0.numHero = 0
	arg_40_0.numEnemy = 0
	arg_40_0.roundAction = {}
	arg_40_0.effectRoundOver = {}
	arg_40_0.Heros = {}
	arg_40_0.enemy = {}
	arg_40_0.preBattle = {}
	arg_40_0.enemyName = nil

	local var_40_0 = {}

	var_40_0.heroId = 102
	var_40_0.battleIx = 1
	var_40_0.currentHealth = 375000
	var_40_0.maxHealth = 375000
	var_40_0.rage = 50
	var_40_0.isHero = true
	var_40_0.usedSkill = {}
	arg_40_0.Heros[var_40_0.battleIx] = var_40_0
	var_40_0.death = BattleDeathType.eLive
	var_40_0.rebirthCount = 0

	arg_40_0:checkWeaponError(var_40_0, getHeroGroupWeaponId(var_40_0.heroId), 1, var_40_0.heroId, nil)

	var_40_0.skillId = 31
	var_40_0.talentId = 10034

	local var_40_1 = {}

	var_40_1.heroId = 211
	var_40_1.battleIx = 3
	var_40_1.currentHealth = 234000
	var_40_1.maxHealth = 234000
	var_40_1.rage = 50
	var_40_1.isHero = true
	var_40_1.usedSkill = {}
	arg_40_0.Heros[var_40_1.battleIx] = var_40_1
	var_40_1.death = BattleDeathType.eLive
	var_40_1.rebirthCount = 0

	arg_40_0:checkWeaponError(var_40_1, getHeroGroupWeaponId(var_40_1.heroId), 1, var_40_1.heroId, nil)

	var_40_1.skillId = 25
	var_40_1.talentId = 10028

	local var_40_2 = {}

	var_40_2.heroId = 110
	var_40_2.battleIx = 5
	var_40_2.currentHealth = 283000
	var_40_2.maxHealth = 283000
	var_40_2.rage = 50
	var_40_2.isHero = true
	var_40_2.usedSkill = {}
	arg_40_0.Heros[var_40_2.battleIx] = var_40_2
	var_40_2.death = BattleDeathType.eLive
	var_40_2.rebirthCount = 0

	arg_40_0:checkWeaponError(var_40_2, getHeroGroupWeaponId(var_40_2.heroId), 1, var_40_2.heroId, nil)

	var_40_2.skillId = 42
	var_40_2.talentId = 10048

	for iter_40_0, iter_40_1 in pairs(Player.team.groupList) do
		dump(iter_40_1)

		if iter_40_1.heroId ~= 0 and iter_40_1.battleIx == 2 then
			local var_40_3 = {
				heroId = iter_40_1.heroId
			}

			var_40_3.battleIx = 2
			var_40_3.currentHealth = 175000
			var_40_3.maxHealth = 175000
			var_40_3.rage = 0
			var_40_3.isHero = true
			var_40_3.usedSkill = {}
			arg_40_0.Heros[var_40_3.battleIx] = var_40_3
			var_40_3.death = BattleDeathType.eLive
			var_40_3.rebirthCount = 0

			arg_40_0:checkWeaponError(var_40_3, 0, 0, var_40_3.heroId, nil)

			var_40_3.skillId = 46
			var_40_3.talentId = 10046
		elseif iter_40_1.heroId ~= 0 and iter_40_1.battleIx == 4 then
			local var_40_4 = {
				heroId = iter_40_1.heroId
			}

			var_40_4.battleIx = 4
			var_40_4.currentHealth = 3000
			var_40_4.maxHealth = 3000
			var_40_4.rage = 0
			var_40_4.isHero = true
			var_40_4.usedSkill = {}
			arg_40_0.Heros[var_40_4.battleIx] = var_40_4
			var_40_4.death = BattleDeathType.eLive
			var_40_4.rebirthCount = 0

			arg_40_0:checkWeaponError(var_40_4, 0, 0, var_40_4.heroId, nil)

			var_40_4.skillId = 46
			var_40_4.talentId = 10046
		elseif iter_40_1.heroId ~= 0 and iter_40_1.battleIx == 6 then
			local var_40_5 = {
				heroId = iter_40_1.heroId
			}

			var_40_5.battleIx = 6
			var_40_5.currentHealth = 4000
			var_40_5.maxHealth = 4000
			var_40_5.rage = 0
			var_40_5.isHero = true
			var_40_5.usedSkill = {}
			arg_40_0.Heros[var_40_5.battleIx] = var_40_5
			var_40_5.death = BattleDeathType.eLive
			var_40_5.rebirthCount = 0

			arg_40_0:checkWeaponError(var_40_5, 0, 0, var_40_5.heroId, nil)

			var_40_5.skillId = 46
			var_40_5.talentId = 10046
		end
	end

	arg_40_0.numHero = 3

	local var_40_6 = {}

	var_40_6.npcId = 1000003
	var_40_6.npcSize = 0
	var_40_6.battleIx = 7
	var_40_6.currentHealth = 242000
	var_40_6.maxHealth = 242000
	var_40_6.rage = 50
	var_40_6.isHero = false
	var_40_6.usedSkill = {}
	arg_40_0.enemy[var_40_6.battleIx] = var_40_6
	arg_40_0.numEnemy = arg_40_0.numEnemy + 1
	var_40_6.death = BattleDeathType.eLive
	var_40_6.rebirthCount = 0
	var_40_6.skillId = 34
	var_40_6.talentId = 10046
	var_40_6.weaponId = BaseNPCs[var_40_6.npcId].equipId

	local var_40_7 = {}

	var_40_7.npcId = 1000004
	var_40_7.npcSize = 0
	var_40_7.battleIx = 10
	var_40_7.currentHealth = 350000
	var_40_7.maxHealth = 350000
	var_40_7.rage = 50
	var_40_7.isHero = false
	var_40_7.usedSkill = {}
	arg_40_0.enemy[var_40_7.battleIx] = var_40_7
	arg_40_0.numEnemy = arg_40_0.numEnemy + 1
	var_40_7.death = BattleDeathType.eLive
	var_40_7.rebirthCount = 0
	var_40_7.skillId = 37
	var_40_7.talentId = 10046
	var_40_7.weaponId = BaseNPCs[var_40_7.npcId].equipId

	local var_40_8 = {}

	var_40_8.npcId = 1000001
	var_40_8.npcSize = 0
	var_40_8.battleIx = 9
	var_40_8.currentHealth = 350000
	var_40_8.maxHealth = 350000
	var_40_8.rage = 50
	var_40_8.isHero = false
	var_40_8.usedSkill = {}
	arg_40_0.enemy[var_40_8.battleIx] = var_40_8
	arg_40_0.numEnemy = arg_40_0.numEnemy + 1
	var_40_8.death = BattleDeathType.eLive
	var_40_8.rebirthCount = 0
	var_40_8.skillId = 10
	var_40_8.talentId = 10046
	var_40_8.weaponId = BaseNPCs[var_40_8.npcId].equipId

	local var_40_9 = {}

	var_40_9.npcId = 1000002
	var_40_9.npcSize = 0
	var_40_9.battleIx = 8
	var_40_9.currentHealth = 228000
	var_40_9.maxHealth = 228000
	var_40_9.rage = 25
	var_40_9.isHero = false
	var_40_9.usedSkill = {}
	arg_40_0.enemy[var_40_9.battleIx] = var_40_9
	arg_40_0.numEnemy = arg_40_0.numEnemy + 1
	var_40_9.death = BattleDeathType.eLive
	var_40_9.rebirthCount = 0
	var_40_9.skillId = 32
	var_40_9.talentId = 10046
	var_40_9.weaponId = BaseNPCs[var_40_9.npcId].equipId

	local var_40_10 = {}

	var_40_10.npcId = 1000005
	var_40_10.npcSize = 0
	var_40_10.battleIx = 12
	var_40_10.currentHealth = 325000
	var_40_10.maxHealth = 325000
	var_40_10.rage = 50
	var_40_10.isHero = false
	var_40_10.usedSkill = {}
	arg_40_0.enemy[var_40_10.battleIx] = var_40_10
	arg_40_0.numEnemy = arg_40_0.numEnemy + 1
	var_40_10.death = BattleDeathType.eLive
	var_40_10.rebirthCount = 0
	var_40_10.skillId = 35
	var_40_10.talentId = 10046
	var_40_10.weaponId = BaseNPCs[var_40_10.npcId].equipId

	local var_40_11 = {}

	var_40_11.npcId = 1000006
	var_40_11.npcSize = 0
	var_40_11.battleIx = 11
	var_40_11.currentHealth = 400000
	var_40_11.maxHealth = 400000
	var_40_11.rage = 50
	var_40_11.isHero = false
	var_40_11.usedSkill = {}
	arg_40_0.enemy[var_40_11.battleIx] = var_40_11
	arg_40_0.numEnemy = arg_40_0.numEnemy + 1
	var_40_11.death = BattleDeathType.eLive
	var_40_11.rebirthCount = 0
	var_40_11.skillId = 9
	var_40_11.talentId = 10046
	var_40_11.weaponId = BaseNPCs[var_40_11.npcId].equipId

	local var_40_12 = {
		{
			rage = 25,
			roundCount = 1,
			skillType = 1,
			posId = 7,
			Step = true,
			affectList = {
				{
					rage = 25,
					effect = 1,
					posId = 4,
					health = -5000
				}
			}
		},
		{
			rage = 25,
			roundCount = 1,
			skillType = 1,
			posId = 9,
			Step = true,
			affectList = {
				{
					rage = 25,
					effect = 2,
					posId = 6,
					health = -6000
				}
			}
		},
		{
			rage = -100,
			roundCount = 2,
			skillType = 2,
			posId = 7,
			Step = true,
			affectList = {
				{
					rage = 0,
					effect = 1,
					posId = 4,
					health = -35000
				},
				{
					rage = 0,
					effect = 1,
					posId = 5,
					health = -40000
				},
				{
					rage = 0,
					effect = 1,
					posId = 6,
					health = -50000
				}
			}
		},
		{
			rage = -100,
			roundCount = 2,
			skillType = 2,
			posId = 8,
			Step = true,
			affectList = {
				{
					rage = 0,
					effect = 1,
					posId = 5,
					health = -60000
				}
			}
		},
		{
			rage = -100,
			roundCount = 2,
			skillType = 2,
			posId = 11,
			Step = true,
			affectList = {
				{
					rage = 0,
					effect = 1,
					posId = 1,
					health = -60000
				},
				{
					rage = 0,
					effect = 1,
					posId = 2,
					health = -40000
				},
				{
					rage = 0,
					effect = 1,
					posId = 3,
					health = -70000
				}
			}
		},
		{
			rage = -100,
			roundCount = 3,
			skillType = 2,
			posId = 3,
			Step = true,
			affectList = {
				{
					rage = 0,
					effect = 1,
					posId = 7,
					health = -55000
				},
				{
					rage = 0,
					effect = 1,
					posId = 8,
					health = -60000
				},
				{
					rage = 0,
					effect = 1,
					posId = 9,
					health = -55000
				},
				{
					rage = 0,
					effect = 1,
					posId = 10,
					health = -65000
				},
				{
					rage = 0,
					effect = 1,
					posId = 11,
					health = -50000
				},
				{
					rage = 0,
					effect = 1,
					posId = 12,
					health = -70000
				}
			}
		},
		{
			rage = -100,
			roundCount = 3,
			skillType = 2,
			posId = 1,
			Step = true,
			affectList = {
				{
					rage = 0,
					effect = 1,
					posId = 7,
					health = -40000
				},
				{
					rage = 0,
					effect = 1,
					posId = 8,
					health = -50000
				},
				{
					rage = 0,
					effect = 1,
					posId = 9,
					health = -45000
				},
				{
					rage = 0,
					effect = 1,
					posId = 10,
					health = -50000
				},
				{
					rage = 0,
					effect = 1,
					posId = 11,
					health = -40000
				},
				{
					rage = 0,
					effect = 1,
					posId = 12,
					health = -60000
				}
			}
		},
		{
			rage = -100,
			roundCount = 3,
			skillType = 2,
			posId = 4,
			Step = true,
			affectList = {
				{
					rage = 0,
					effect = 1,
					posId = 7,
					health = -60000
				},
				{
					rage = 0,
					effect = 1,
					posId = 8,
					health = -70000
				},
				{
					rage = 0,
					effect = 1,
					posId = 9,
					health = -75000
				},
				{
					rage = 0,
					effect = 1,
					posId = 10,
					health = -45000
				},
				{
					rage = 0,
					effect = 1,
					posId = 11,
					health = -35000
				},
				{
					rage = 0,
					effect = 1,
					posId = 12,
					health = -50000
				}
			}
		},
		{
			rage = -100,
			roundCount = 3,
			skillType = 2,
			posId = 5,
			Step = true,
			affectList = {
				{
					rage = 0,
					effect = 1,
					posId = 11,
					health = -90000
				}
			}
		},
		{
			rage = -100,
			roundCount = 3,
			skillType = 2,
			posId = 6,
			Step = true,
			affectList = {
				{
					rage = 0,
					effect = 1,
					posId = 10,
					health = -65000
				},
				{
					rage = 0,
					effect = 1,
					posId = 11,
					health = -50000
				},
				{
					rage = 0,
					effect = 1,
					posId = 12,
					health = -80000
				}
			}
		}
	}

	table.foreach(var_40_12, function(arg_41_0, arg_41_1)
		if BattleData.roundAction[arg_41_1.roundCount] == nil then
			BattleData.roundAction[arg_41_1.roundCount] = {}
		end

		local var_41_0 = {
			skillType = arg_41_1.skillType,
			position = arg_41_1.posId,
			bar = {}
		}

		var_41_0.bar.health = arg_41_1.health
		var_41_0.bar.rage = arg_41_1.rage
		var_41_0.bar.maxHp = arg_41_1.hpmax

		if arg_41_1.ts then
			var_41_0.talentSkill = {
				position = var_41_0.position
			}

			var_0_0(var_41_0.talentSkill, arg_41_1.ts.ts)
		end

		var_41_0.affectList = {}

		table.foreach(arg_41_1.affectList, function(arg_42_0, arg_42_1)
			local var_42_0 = {
				position = arg_42_1.posId,
				bar = {}
			}

			var_42_0.bar.health = arg_42_1.health
			var_42_0.bar.rage = arg_42_1.rage
			var_42_0.bar.maxHp = arg_42_1.hpmax
			var_42_0.state = arg_42_1.state
			var_42_0.effect = arg_42_1.effect
			var_42_0.rebirth = arg_42_1.rev

			table.insert(var_41_0.affectList, var_42_0)

			if arg_42_1.ts then
				var_42_0.talentSkill = {
					position = arg_42_1.posId,
					hasNext = arg_42_1.ts.hns
				}

				var_0_0(var_42_0.talentSkill, arg_42_1.ts.ts)
			end
		end)

		if arg_41_1.Step then
			local var_41_1 = {}

			table.insert(var_41_1, var_41_0)
			table.insert(BattleData.roundAction[arg_41_1.roundCount], var_41_1)
		else
			table.insert(BattleData.roundAction[arg_41_1.roundCount][#BattleData.roundAction[arg_41_1.roundCount]], var_41_0)
		end
	end)

	arg_40_0.result = true
	arg_40_0.maxRound = table.getn(arg_40_0.roundAction)
	arg_40_0.step = 1
	arg_40_0.maxStep = table.getn(arg_40_0.roundAction[arg_40_0.round])
	arg_40_0.guiderStep = 1
end
