require("base.functions")
require("base.figure")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = class("Tianming")

function var_0_1.ctor(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.type
	local var_1_1 = arg_1_1.id
	local var_1_2 = arg_1_1.player
	local var_1_3 = arg_1_1.heroId
	local var_1_4 = copyTable(BaseTianMings[var_1_1])

	var_1_4.level = 1

	if var_1_2 then
		table.merge(var_1_4, var_1_2)
	end

	var_1_4.id = var_1_1

	table.merge(var_1_4, var_1_4.upgradeData[var_1_4.level])

	if var_1_3 and var_1_3 > 0 then
		arg_1_0.heroId = var_1_3

		if false then
			arg_1_0.mismatch = true
		end
	end

	arg_1_0.model = var_1_4
	arg_1_0.mismatch = false
	arg_1_0.mismatchColor = ccc3(255, 0, 0)
	arg_1_0.qualityColor = nil
end

function var_0_1.createAvatarTitle(arg_2_0)
	local var_2_0 = arg_2_0.model

	return var_0_0.createAvatarTitle({
		Type = ItemType.eTianMing,
		ID = var_2_0.id,
		Color = arg_2_0.mismatch and arg_2_0.mismatchColor or nil
	})
end

function var_0_1.createAttrNode(arg_3_0)
	local var_3_0 = arg_3_0.model
	local var_3_1 = {
		[BattleAttrsType.eHealth] = "health",
		[BattleAttrsType.eNormalAttack] = "normalAttack",
		[BattleAttrsType.eNormalDefense] = "normalDefense",
		[BattleAttrsType.eSkillAttack] = "skillAttack",
		[BattleAttrsType.eSkillDefense] = "skillDefense",
		[BattleAttrsType.eMingZhong] = "mingzhong",
		[BattleAttrsType.eShanBi] = "shanbi",
		[BattleAttrsType.eBaoJi] = "baoji",
		[BattleAttrsType.eRenXing] = "renxing",
		[BattleAttrsType.ePoJi] = "poji",
		[BattleAttrsType.eGeDang] = "gedang",
		[BattleAttrsType.eSpeed] = "speed"
	}
	local var_3_2
	local var_3_3

	if arg_3_0.mismatch then
		var_3_3 = " "
		var_3_2 = arg_3_0.mismatchColor
	else
		var_3_3 = " #77E975"
		var_3_2 = ccc3(239, 223, 181)
	end

	local var_3_4
	local var_3_5
	local var_3_6 = {}
	local var_3_7 = var_0_0.newLabel({
		size = 20,
		text = string.lf("等级: %s%d", var_3_3, var_3_0.level),
		color = var_3_2
	})

	table.insert(var_3_6, var_3_7)

	local var_3_8 = 0

	for iter_3_0 = 1, var_3_0.level - 1 do
		var_3_8 = var_3_8 + (var_3_0.upgradeData[iter_3_0].upgradeExp or 0)
	end

	local var_3_9 = var_0_0.newLabel({
		size = 20,
		text = string.lf("经验: %s%d", var_3_3, var_3_0.exp + var_3_8),
		color = var_3_2
	})

	table.insert(var_3_6, var_3_9)

	for iter_3_1, iter_3_2 in ipairs(var_3_1) do
		local var_3_10 = var_3_0[iter_3_2]

		if var_3_10 and var_3_10 > 0 then
			local var_3_11 = var_0_0.newLabel({
				size = 20,
				text = BattleAttrsName[iter_3_1] .. ": " .. var_3_3 .. var_3_10,
				color = var_3_2
			})

			table.insert(var_3_6, var_3_11)
		end
	end

	return var_0_0.linearLayout({
		margin = 5,
		direction = "vertical",
		nodes = var_3_6,
		align = display.LEFT_CENTER
	})
end

function var_0_1.getCompareTianming(arg_4_0)
	local var_4_0 = arg_4_0.model
	local var_4_1
	local var_4_2 = arg_4_0.heroId
	local var_4_3

	for iter_4_0, iter_4_1 in ipairs(Player.team.groupList) do
		if iter_4_1.heroId == var_4_2 then
			var_4_3 = iter_4_1

			break
		end
	end

	if var_4_3 and var_4_3.heroId > 0 then
		for iter_4_2, iter_4_3 in ipairs(var_4_3.destinyList) do
			iter_4_3 = iter_4_3.destiny

			if iter_4_3 and BaseTianMings[iter_4_3.destinyID].type == var_4_0.type then
				var_4_1 = iter_4_3
			end
		end
	end

	if var_4_1 then
		return var_0_1.new({
			id = var_4_1.destinyID,
			player = var_4_1,
			heroId = arg_4_0.heroId
		})
	end
end

return var_0_1
