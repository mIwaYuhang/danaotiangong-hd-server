require("base.functions")
require("base.figure")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = require("scenes.toollayer.tool")
local var_0_2 = class("Hero")

function var_0_2.ctor(arg_1_0, arg_1_1)
	arg_1_0.qualityColor = nil

	if not arg_1_1.type then
		arg_1_1.type = ItemType.eHero
	end

	arg_1_0:init(arg_1_1)
end

function var_0_2.init(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.type
	local var_2_1 = arg_2_1.id
	local var_2_2 = arg_2_1.player

	if var_2_2 == nil then
		var_2_2 = true
	end

	if var_2_0 == ItemType.eSoul then
		var_2_1 = BaseSouls[var_2_1].figureId
	end

	local var_2_3 = copyTable(BaseHeros[var_2_1])

	var_2_3.id = var_2_1
	var_2_3.level = 1
	var_2_3.madSkillLevel = 0

	if var_2_2 then
		local var_2_4

		for iter_2_0, iter_2_1 in ipairs(Player.team.groupList) do
			if iter_2_1.heroId == var_2_1 then
				var_2_4 = iter_2_1

				break
			end
		end

		if not var_2_4 then
			for iter_2_2, iter_2_3 in ipairs(Player.ownedHeros) do
				if iter_2_3.heroId == var_2_1 then
					var_2_4 = iter_2_3

					break
				end
			end
		end

		if var_2_4 then
			table.merge(var_2_3, var_2_4)

			if not var_2_3.madSkillLevel then
				var_2_3.madSkillLevel = 0
			end
		end
	end

	arg_2_0.model = var_2_3
	arg_2_0.qualityColor = getQualityColor(var_2_3.quality)
end

function var_0_2.createFigureNode(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.model
	local var_3_1 = getHeroGroupWeaponId(var_3_0.id)
	local var_3_2 = CCSize(220, 280)
	local var_3_3 = var_0_0.newNode()

	var_3_3:setContentSize(var_3_2)

	local var_3_4 = {
		scale = 0.6,
		isViewBaseInfo = false,
		isViewQuality = true,
		qualityOffsetY = 16,
		figId = var_3_0.id,
		equipId = var_3_1
	}
	local var_3_5 = figure.createHero(var_3_4)

	var_3_5:setPosition(var_3_2.width / 2, 0)
	var_3_3:addChild(var_3_5)

	if false then
		local var_3_6 = arg_3_0:createGroupAttrs()

		var_3_6:setAnchorPoint(ccp(0.5, 0.5))
		var_3_6:setPosition(var_3_2.width / 2, -20)
		var_3_3:addChild(var_3_6)
	end

	return var_3_3
end

function var_0_2.createAttrNode(arg_4_0)
	local var_4_0 = arg_4_0.model
	local var_4_1 = {}

	table.insert(var_4_1, string.lf("力量: #20E500%d", var_4_0.strength))
	table.insert(var_4_1, string.lf("根骨: #20E500%d", var_4_0.physical))
	table.insert(var_4_1, string.lf("法术: #20E500%d", var_4_0.mana))
	table.insert(var_4_1, string.lf("敏捷: #20E500%d", var_4_0.agility))

	local var_4_2
	local var_4_3 = {}

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		local var_4_4 = var_0_0.newLabel({
			size = 20,
			text = var_4_1[iter_4_0],
			color = ccc3(239, 223, 181)
		})

		table.insert(var_4_3, var_4_4)
	end

	return var_0_0.tableLayout({
		row = 2,
		col = 2,
		nodes = var_4_3,
		size = CCSize(290, 20),
		padding = {
			top = 0,
			bottom = 0,
			left = 20,
			right = 0
		},
		align = display.LEFT_CENTER
	})
end

function var_0_2.createSkillNode(arg_5_0)
	local var_5_0 = arg_5_0.model
	local var_5_1 = arg_5_0.qualityColor
	local var_5_2 = var_5_0.skillId
	local var_5_3 = BaseSkills[var_5_2]
	local var_5_4 = var_5_0.talentId
	local var_5_5 = BaseSkills[var_5_4]
	local var_5_6
	local var_5_7 = {}
	local var_5_8 = var_0_0.newLabel({
		size = 20,
		text = string.lf("【怒气法术】 ") .. var_5_3.name,
		color = var_5_1
	})

	table.insert(var_5_7, var_5_8)

	local var_5_9 = var_0_0.newLabel({
		size = 18,
		text = getHeroRageSkillDesc(var_5_2, 1, var_5_0.mana * 1.5, "#EFDFB5"),
		color = ccc3(239, 223, 181),
		dimensions = CCSize(280 * Adapter.AutoScaleX, 0),
		align = ui.TEXT_ALIGN_LEFT
	})

	table.insert(var_5_7, var_5_9)

	local var_5_10 = var_0_0.newLabel({
		size = 20,
		text = string.lf("【天赋法术】 ") .. var_5_5.name,
		color = var_5_1
	})

	table.insert(var_5_7, var_5_10)

	local var_5_11 = var_0_0.newLabel({
		size = 18,
		text = getTalentSkillDesc(var_5_4, 1, "#EFDFB5"),
		color = ccc3(239, 223, 181),
		dimensions = CCSize(280 * Adapter.AutoScaleX, 0),
		align = ui.TEXT_ALIGN_LEFT
	})

	table.insert(var_5_7, var_5_11)

	if var_5_0.madSkillLevel > 0 then
		local var_5_12 = var_0_0.newLabel({
			size = 20,
			text = string.lf("【天赋法术】 狂化"),
			color = var_5_1
		})

		table.insert(var_5_7, var_5_12)

		local var_5_13 = var_0_0.newLabel({
			size = 18,
			text = getHeroMadSkillDesc(var_5_0.madSkillLevel, var_5_0.quality),
			color = ccc3(239, 223, 181),
			dimensions = CCSize(280 * Adapter.AutoScaleX, 0),
			align = ui.TEXT_ALIGN_LEFT
		})

		table.insert(var_5_7, var_5_13)
	end

	local var_5_14 = arg_5_0:createPartnerNode()

	table.insert(var_5_7, var_5_14)

	return var_0_0.linearLayout({
		margin = 10,
		direction = "vertical",
		nodes = var_5_7,
		align = display.LEFT_CENTER
	})
end

function var_0_2.createPartnerNode(arg_6_0)
	local var_6_0 = arg_6_0.model
	local var_6_1 = arg_6_0.qualityColor
	local var_6_2 = ccc3(239, 223, 181)
	local var_6_3 = "#EFDFB5"
	local var_6_4
	local var_6_5
	local var_6_6
	local var_6_7 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_0.groupAttrs) do
		for iter_6_2, iter_6_3 in ipairs(iter_6_1.heroList) do
			local var_6_8 = getItemName(ItemType.eHero, iter_6_3)
			local var_6_9 = getItemQuality(ItemType.eHero, iter_6_3)

			var_6_7[iter_6_3] = getQualityColor(var_6_9, true) .. var_6_8 .. var_6_3
		end
	end

	local var_6_10 = #var_6_7
	local var_6_11 = ""
	local var_6_12 = 1

	for iter_6_4, iter_6_5 in pairs(var_6_7) do
		var_6_11 = var_6_11 .. iter_6_5

		if var_6_12 ~= var_6_10 then
			var_6_11 = var_6_11 .. "、"
		end

		var_6_12 = var_6_12 + 1
	end

	local var_6_13 = string.lf("可与 %s 形成缘份效果", var_6_11)

	return var_0_0.newLabel({
		size = 18,
		text = var_6_13,
		color = var_6_2,
		dimensions = CCSize(280 * Adapter.AutoScaleX, 0),
		align = ui.TEXT_ALIGN_LEFT
	})
end

function var_0_2.createGroupAttrs(arg_7_0)
	local var_7_0 = arg_7_0.model
	local var_7_1 = arg_7_0.qualityColor
	local var_7_2 = ccc3(239, 223, 181)
	local var_7_3
	local var_7_4 = {}

	for iter_7_0, iter_7_1 in ipairs(var_7_0.groupAttrs) do
		local var_7_5 = var_0_0.newLabel({
			text = iter_7_1.name,
			color = var_7_2
		})

		table.insert(var_7_4, var_7_5)
	end

	return var_0_0.tableLayout({
		row = 2,
		col = 2,
		nodes = var_7_4,
		size = CCSize(220, 20),
		padding = {
			top = 0,
			bottom = 0,
			left = 10,
			right = 0
		},
		align = display.LEFT_CENTER
	})
end

function var_0_2.createGroupEquipIcons(arg_8_0)
	local var_8_0 = arg_8_0.model
	local var_8_1 = arg_8_0.qualityColor
	local var_8_2 = var_8_0.groupEquips
	local var_8_3
	local var_8_4 = {}
	local var_8_5 = CCSize(280, 10)
	local var_8_6 = convertColorToLabelString(var_8_1)
	local var_8_7 = "#6F6951"
	local var_8_8 = 0
	local var_8_9 = var_0_1.array(6)
	local var_8_10 = var_0_1.array(6)
	local var_8_11 = ccc3(239, 223, 181)
	local var_8_12 = ccc3(111, 105, 81)
	local var_8_13 = ccc3(32, 255, 0)

	if var_8_0.equipList then
		for iter_8_0, iter_8_1 in ipairs(var_8_2) do
			for iter_8_2, iter_8_3 in ipairs(var_8_0.equipList) do
				if iter_8_1.equipId == iter_8_3.equipId then
					var_8_9[getItemBaseData(ItemType.eEquip, iter_8_1.equipId).equipType] = true
					var_8_8 = var_8_8 + 1
				end
			end
		end
	end

	local var_8_14 = CCSize(82, 110)
	local var_8_15
	local var_8_16

	for iter_8_4, iter_8_5 in ipairs(var_8_2) do
		local var_8_17 = getItemBaseData(ItemType.eEquip, iter_8_5.equipId)
		local var_8_18 = var_0_0.newNode()

		var_8_18:setContentSize(var_8_14)

		local var_8_19 = figure.createHeader({
			isName = true,
			type = ItemType.eEquip,
			itemId = iter_8_5.equipId,
			inTeam = var_8_9[var_8_17.equipType],
			clickAction = function()
				require("scenes.ToolLayer").tipshandler({
					Type = ItemType.eEquip,
					ID = iter_8_5.equipId
				})
			end
		})

		var_8_19:setPosition(var_8_14.width / 2, 65)
		var_8_18:addChild(var_8_19)
		table.insert(var_8_4, var_8_18)
	end

	return var_0_0.tableLayout({
		row = 0,
		spacing = 5,
		col = 3,
		nodes = var_8_4,
		padding = {
			top = 0,
			bottom = 0,
			left = 10,
			right = 10
		}
	})
end

function var_0_2.createGroupEquips(arg_10_0)
	local var_10_0 = arg_10_0.model
	local var_10_1 = arg_10_0.qualityColor
	local var_10_2 = var_10_0.groupEquips
	local var_10_3
	local var_10_4 = {}
	local var_10_5 = CCSize(280, 10)
	local var_10_6 = convertColorToLabelString(var_10_1)
	local var_10_7 = "#6F6951"
	local var_10_8 = 0
	local var_10_9 = var_0_1.array(6)
	local var_10_10 = var_0_1.array(6)
	local var_10_11 = ccc3(239, 223, 181)
	local var_10_12 = ccc3(111, 105, 81)
	local var_10_13 = ccc3(32, 255, 0)

	if var_10_0.equipList then
		for iter_10_0, iter_10_1 in ipairs(var_10_2) do
			for iter_10_2, iter_10_3 in ipairs(var_10_0.equipList) do
				if iter_10_1.equipId == iter_10_3.equipId then
					var_10_9[getItemBaseData(ItemType.eEquip, iter_10_1.equipId).equipType] = true
					var_10_8 = var_10_8 + 1
				end
			end
		end
	end

	local var_10_14 = 0

	for iter_10_4, iter_10_5 in ipairs(var_10_2) do
		local var_10_15 = getItemBaseData(ItemType.eEquip, iter_10_5.equipId)
		local var_10_16 = BattleAttrsName[iter_10_5.attrType]
		local var_10_17 = iter_10_5.attrValue
		local var_10_18 = EquipTypeNames[var_10_15.equipType]
		local var_10_19 = var_10_15.name
		local var_10_20 = ""

		if var_10_9[var_10_15.equipType] then
			var_10_19 = getQualityColor(var_10_15.quality, true) .. var_10_19 .. "#EFDFB5"
			var_10_20 = "#20E500"
		end

		local var_10_21 = string.lf("%s-%s：%s装备后%s+%d%%", var_10_18, var_10_19, var_10_20, var_10_16, var_10_17)

		var_10_10[var_10_15.equipType] = var_10_21
		var_10_14 = var_10_14 + 1
	end

	for iter_10_6, iter_10_7 in ipairs(var_10_10) do
		if iter_10_7 then
			local var_10_22 = {
				size = 18,
				text = iter_10_7,
				font = _FONT_DEFAULT,
				color = var_10_11
			}
			local var_10_23 = var_0_0.newLabel(var_10_22)

			table.insert(var_10_4, var_10_23)

			var_10_14 = var_10_14 - 1
		end

		if iter_10_6 % 2 == 0 and var_10_14 > 0 and (iter_10_7 or var_10_10[iter_10_6 - 1]) then
			local var_10_24 = CCNode:create()

			var_10_24:setContentSize(var_10_5)
			table.insert(var_10_4, var_10_24)
		end
	end

	return var_0_0.linearLayout({
		margin = 5,
		direction = "vertical",
		nodes = var_10_4,
		align = display.LEFT_CENTER
	})
end

function var_0_2.createInfoNode(arg_11_0)
	local var_11_0 = CCSize(0, 0)
	local var_11_1 = var_0_0.newNode()
	local var_11_2 = arg_11_0:createSkillNode()
	local var_11_3 = var_11_2:getContentSize()
	local var_11_4 = arg_11_0:createGroupEquips()
	local var_11_5 = var_11_4:getContentSize()

	var_11_0.width = math.max(var_11_3.width, var_11_5.width)
	var_11_0.height = math.max(var_11_3.height, var_11_5.height)

	var_11_1:setContentSize(var_11_0)
	var_11_2:setAnchorPoint(ccp(0, 1))
	var_11_2:setPosition(0, var_11_0.height)
	var_11_2:setVisible(true)
	var_11_1:addChild(var_11_2)
	var_11_4:setAnchorPoint(ccp(0, 1))
	var_11_4:setPosition(0, var_11_0.height)
	var_11_4:setVisible(false)
	var_11_1:addChild(var_11_4)

	function var_11_1.toggle(arg_12_0, arg_12_1)
		var_11_2:setVisible(arg_12_1)
		var_11_4:setVisible(not arg_12_1)
	end

	return var_11_1
end

return var_0_2
