require("base.functions")
require("data.MineralHelper")

local var_0_0 = require("scenes.toollayer.tool")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = class("Equip")

function var_0_2.ctor(arg_1_0, arg_1_1)
	arg_1_0.model = {}
	arg_1_0.qualityColor = nil
	arg_1_0.mismatch = false
	arg_1_0.mismatchColor = ccc3(255, 0, 0)

	if not arg_1_1.type or arg_1_1.type ~= ItemType.eFragment then
		arg_1_1.type = ItemType.eEquip
	end

	arg_1_0:init(arg_1_1)
end

function var_0_2.init(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.type
	local var_2_1 = arg_2_1.id
	local var_2_2 = arg_2_1.player
	local var_2_3 = arg_2_1.heroId
	local var_2_4 = arg_2_0.model
	local var_2_5 = getItemBaseData(var_2_0, var_2_1)

	var_2_4.id = var_2_1
	var_2_4.type = var_2_0
	var_2_4.name = var_2_5.name
	var_2_4.quality = var_2_5.quality
	var_2_4.level = 1

	if var_2_0 == ItemType.eFragment then
		var_2_4.equipId = var_2_5.equipId
		var_2_4.exchange = var_2_5.exchangeCount

		if var_2_4.equipId > 0 then
			var_2_5 = getItemBaseData(ItemType.eEquip, var_2_4.id)
		else
			return
		end
	end

	var_2_4.name = var_2_5.name
	var_2_4.herosId = var_2_5.herosId
	var_2_4.profession = var_2_5.profession
	var_2_4.equipType = var_2_5.equipType

	if var_2_2 then
		var_2_5 = var_2_2
		var_2_4.level = var_2_5.level
		var_2_4.pinJie = var_2_5.pinJie
		var_2_4.baoji = var_2_5.baoji
		var_2_4.gedang = var_2_5.gedang
		var_2_4.shanbi = var_2_5.shanbi
		var_2_4.renxing = var_2_5.renxing
		var_2_4.poji = var_2_5.poji
		var_2_4.mingzhong = var_2_5.mingzhong
		var_2_4.health = var_2_5.health
		var_2_4.speed = var_2_5.speed
		var_2_4.normalAttack = var_2_5.normalAttack
		var_2_4.normalDefense = var_2_5.normalDefense
		var_2_4.skillAttack = var_2_5.skillAttack
		var_2_4.skillDefense = var_2_5.skillDefense
		var_2_4.gem = var_2_5.gem
	else
		var_2_4.speed = var_2_5.speedMax
		var_2_4.health = var_2_5.healthMax
		var_2_4.normalAttack = var_2_5.normalAttackMax
		var_2_4.normalDefense = var_2_5.normalDefenseMax
		var_2_4.skillAttack = var_2_5.skillAttackMax
		var_2_4.skillDefense = var_2_5.skillDefenseMax
	end

	var_2_4.BreakthroughCount = var_2_5.BreakthroughCount or 0

	if var_2_3 and var_2_3 > 0 then
		arg_2_0.heroId = var_2_3

		if var_2_4.profession ~= HeroProfession.eNone and var_2_4.profession ~= BaseHeros[var_2_3].profession then
			arg_2_0.mismatch = true
		end
	end

	arg_2_0.qualityColor = getQualityColor(var_2_4.quality)
end

function var_0_2.getAttrList(arg_3_0)
	local var_3_0 = arg_3_0.model
	local var_3_1 = var_3_0.pinJie and var_3_0.equipType or nil
	local var_3_2 = {}

	if not var_3_1 then
		table.insert(var_3_2, BattleAttrsType.eNormalAttack)
		table.insert(var_3_2, BattleAttrsType.eSkillAttack)
		table.insert(var_3_2, BattleAttrsType.eNormalDefense)
		table.insert(var_3_2, BattleAttrsType.eSkillDefense)
		table.insert(var_3_2, BattleAttrsType.eHealth)
		table.insert(var_3_2, BattleAttrsType.eSpeed)
	else
		var_3_2 = getEquipAttrTypeList(var_3_0.id)
	end

	return var_3_2
end

function var_0_2.getCompareEquip(arg_4_0)
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
		for iter_4_2, iter_4_3 in ipairs(var_4_3.equipList) do
			if BaseEquips[iter_4_3.equipId].equipType == var_4_0.equipType then
				var_4_1 = iter_4_3
			end
		end
	end

	if var_4_1 then
		return var_0_2.new({
			id = var_4_1.equipId,
			player = var_4_1,
			heroId = arg_4_0.heroId
		})
	end
end

function var_0_2.createAttrNode(arg_5_0)
	local var_5_0 = {
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
	local var_5_1 = arg_5_0.model
	local var_5_2 = var_5_1.equipType
	local var_5_3 = arg_5_0:getAttrList()

	for iter_5_0 = #var_5_3, 1, -1 do
		local var_5_4 = var_5_1[var_5_0[var_5_3[iter_5_0]]]

		if not var_5_4 or var_5_4 < 1 then
			table.remove(var_5_3, iter_5_0)
		end
	end

	local var_5_5
	local var_5_6

	if arg_5_0.mismatch then
		var_5_6 = " "
		var_5_5 = arg_5_0.mismatchColor
	else
		var_5_6 = " #77E975"
		var_5_5 = ccc3(239, 223, 181)
	end

	local var_5_7 = arg_5_0:createInfoNodes()
	local var_5_8

	for iter_5_1, iter_5_2 in ipairs(var_5_3) do
		local var_5_9 = var_0_1.newLabel({
			size = 20,
			text = BattleAttrsName[iter_5_2] .. ":" .. var_5_6 .. var_5_1[var_5_0[iter_5_2]],
			color = var_5_5
		})

		table.insert(var_5_7, var_5_9)
	end

	return var_0_1.tableLayout({
		row = 0,
		col = 2,
		nodes = var_5_7,
		size = CCSize(280, 0),
		padding = {
			top = 0,
			bottom = 0,
			left = 10,
			right = 0
		},
		align = display.LEFT_CENTER
	})
end

function var_0_2.createAvatarTitle(arg_6_0)
	local var_6_0 = arg_6_0.model

	return var_0_1.createAvatarTitle({
		Type = var_6_0.type,
		ID = var_6_0.id,
		Count = var_6_0.BreakthroughCount,
		Color = arg_6_0.mismatch and arg_6_0.mismatchColor or nil
	})
end

function var_0_2.createInfoNodes(arg_7_0)
	local var_7_0 = arg_7_0.model
	local var_7_1
	local var_7_2
	local var_7_3
	local var_7_4

	if arg_7_0.mismatch then
		var_7_1 = arg_7_0.mismatchColor
		var_7_2 = ""
		var_7_4 = ""
	else
		var_7_1 = ccc3(239, 223, 181)
		var_7_2 = getQualityColor(var_7_0.quality, true)
		var_7_4 = getPinjieColor(var_7_0.pinJie, true)
	end

	local var_7_5 = {}
	local var_7_6 = var_0_1.newLabel({
		text = string.lf("品质: %s", var_7_2 .. getQualityName(var_7_0.quality)),
		color = var_7_1
	})

	table.insert(var_7_5, var_7_6)

	local var_7_7 = var_7_0.pinJie == nil and EquipPinjieNames[EquipPinjieType.eFanPin] or EquipPinjieNames[var_7_0.pinJie]
	local var_7_8 = var_0_1.newLabel({
		text = string.lf("品阶: %s%s", var_7_4, var_7_7),
		color = var_7_1
	})

	table.insert(var_7_5, var_7_8)

	local var_7_9 = var_0_1.newLabel({
		text = string.lf("等级: %s", var_7_0.level),
		color = var_7_1
	})

	table.insert(var_7_5, var_7_9)

	local var_7_10 = var_0_1.newLabel({
		text = string.lf("职业: %s", HeroProfessionNames[var_7_0.profession]),
		color = var_7_1
	})

	table.insert(var_7_5, var_7_10)

	return var_7_5
end

function var_0_2.createPinJieTitle(arg_8_0)
	local var_8_0 = arg_8_0.model
	local var_8_1 = arg_8_0.qualityColor
	local var_8_2 = arg_8_0.mismatch
	local var_8_3 = arg_8_0.mismatchColor
	local var_8_4 = CCSize(300, 30)
	local var_8_5 = CCNode:create()

	var_8_5:setContentSize(var_8_4)

	local var_8_6 = var_8_0.name
	local var_8_7 = var_8_0.profession
	local var_8_8 = var_8_6 .. "(" .. HeroProfessionNames[var_8_7] .. ")"
	local var_8_9 = var_0_1.newLabel({
		size = 22,
		text = var_8_8,
		font = _FONT_DEFAULT,
		color = var_8_2 and var_8_3 or var_8_1
	})
	local var_8_10 = var_8_9:getContentSize().width + 20

	var_8_9:setPosition(var_8_10, var_8_4.height / 2)
	var_8_9:setAnchorPoint(ccp(1, 0.5))
	var_8_5:addChild(var_8_9)

	local var_8_11 = getPinjieBigImageName(var_8_0.pinJie)
	local var_8_12 = display.newSprite(var_8_11)

	var_8_12:setScale(0.7)
	var_8_12:setAnchorPoint(ccp(1, 0.5))
	var_8_12:setPosition(var_8_4.width - 20, var_8_4.height / 2)
	var_8_5:addChild(var_8_12)

	return var_8_5
end

function var_0_2.createOwnedHeroNode(arg_9_0)
	local var_9_0 = arg_9_0.model
	local var_9_1 = arg_9_0.mismatch
	local var_9_2 = arg_9_0.mismatchColor
	local var_9_3 = var_9_0.herosId
	local var_9_4 = ""
	local var_9_5 = false

	if var_9_3 and table.getn(var_9_3) > 0 then
		for iter_9_0, iter_9_1 in ipairs(var_9_3) do
			local var_9_6 = BaseHeros[iter_9_1].name
			local var_9_7 = false

			if iter_9_1 == arg_9_0.heroId then
				var_9_6, var_9_7 = "#259623" .. var_9_6, true
			else
				if not var_9_1 then
					var_9_6 = "#FF0000" .. var_9_6
				end

				var_9_7 = false
			end

			if iter_9_0 == 1 then
				var_9_5 = var_9_7
				var_9_4 = var_9_4 .. var_9_6
			else
				var_9_4 = var_9_4 .. "、" .. var_9_6
			end
		end
	end

	local var_9_8

	if var_9_1 then
		var_9_8 = var_9_2
	elseif var_9_5 and table.getn(var_9_3) == 1 then
		var_9_8 = ccc3(37, 150, 35)
	else
		var_9_8 = ccc3(255, 0, 0)
	end

	local var_9_9 = #var_9_4 > 0 and string.lf("专属: %s", var_9_4) or string.lf("专属: 无")
	local var_9_10 = CCSize(260, 0)
	local var_9_11 = var_0_1.newNode()
	local var_9_12 = {
		size = 20,
		text = var_9_9,
		color = var_9_8
	}

	if #var_9_9 > 60 then
		var_9_12.dimensions = CCSize(260, 0)
	end

	local var_9_13 = var_0_1.newLabel(var_9_12)

	var_9_10.height = var_9_13:getContentSize().height + 2

	var_9_13:setAnchorPoint(ccp(0, 0.5))
	var_9_13:setPosition(0, var_9_10.height / 2)
	var_9_11:setContentSize(var_9_10)
	var_9_11:addChild(var_9_13)

	return var_9_11
end

function var_0_2.createMineralNode(arg_10_0)
	local var_10_0 = arg_10_0.model
	local var_10_1 = arg_10_0.mismatch
	local var_10_2 = arg_10_0.mismatchColor
	local var_10_3 = ""

	if var_10_0.gem then
		var_10_3 = string.lf("已镶嵌:%s级%s  %s", var_10_0.gem.level, BaseMineral[var_10_0.gem.gemProtoID].name, MineralHelper:readGemAddValue(var_10_0.gem))
	else
		var_10_3 = string.lf("可镶嵌:%s", MineralHelper:getCanInlayType(var_10_0.equipType))
	end

	local var_10_4

	if var_10_1 then
		var_10_4 = var_10_2
	elseif var_10_0.gem then
		var_10_4 = ccc3(37, 150, 35)
	else
		var_10_4 = ccc3(255, 0, 0)
	end

	local var_10_5 = CCSize(260, 0)
	local var_10_6 = var_0_1.newNode()
	local var_10_7 = {
		size = 18,
		text = var_10_3,
		color = var_10_4
	}

	if #var_10_3 > 60 then
		var_10_7.dimensions = CCSize(260, 0)
	end

	local var_10_8 = var_0_1.newLabel(var_10_7)

	var_10_5.height = var_10_8:getContentSize().height + 2

	var_10_8:setAnchorPoint(ccp(0, 0.5))
	var_10_8:setPosition(0, var_10_5.height / 2)
	var_10_6:setContentSize(var_10_5)
	var_10_6:addChild(var_10_8)

	return var_10_6
end

function var_0_2.createFragmentDesc(arg_11_0)
	local var_11_0 = CCSize(300, 80)
	local var_11_1 = var_0_1.newNode()

	var_11_1:setContentSize(var_11_0)

	local var_11_2 = var_0_1.newLabel({
		size = 20,
		text = string.lf("通用碎片"),
		font = _FONT_DEFAULT
	})

	var_11_2:setAnchorPoint(ccp(0, 0.5))
	var_11_2:setPosition(30, 55)
	var_11_1:addChild(var_11_2)

	local var_11_3

	if arg_11_0.model.quality == QualityType.eOrange then
		var_11_3 = string.lf("很大概率合成专属装备")
	else
		var_11_3 = string.lf("随机合成%s品质的装备", getQualityName(arg_11_0.model.quality))
	end

	local var_11_4 = var_0_1.newLabel({
		size = 20,
		text = var_11_3
	})

	var_11_4:setAnchorPoint(ccp(0, 0.5))
	var_11_4:setPosition(30, 20)
	var_11_1:addChild(var_11_4)

	return var_11_1
end

return var_0_2
