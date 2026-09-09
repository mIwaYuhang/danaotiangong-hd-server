require("scenes.enhance.RefineScene")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = class("DlgEquipFeedLayer", function()
	return display.newLayer()
end)

attrStatus = {
	attrLevel = 4,
	attrGrowValue = 3,
	attrCurValue = 1,
	attrCurExp = 5,
	attrTotalExp = 6,
	attrInitialValue = 2
}

function getBattleAttrWithStatus(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0

	if arg_2_1 == BattleAttrsType.eHealth then
		if arg_2_2 == attrStatus.attrCurValue then
			var_2_0 = arg_2_0.health
		elseif arg_2_2 == attrStatus.attrInitialValue then
			var_2_0 = arg_2_0.healthInitial
		elseif arg_2_2 == attrStatus.attrGrowValue then
			var_2_0 = arg_2_0.healthGrow
		end
	elseif arg_2_1 == BattleAttrsType.eSpeed then
		if arg_2_2 == attrStatus.attrCurValue then
			var_2_0 = arg_2_0.speed
		elseif arg_2_2 == attrStatus.attrInitialValue then
			var_2_0 = arg_2_0.speedInitial
		elseif arg_2_2 == attrStatus.attrGrowValue then
			var_2_0 = arg_2_0.speedGrow
		end
	elseif arg_2_1 == BattleAttrsType.eNormalAttack then
		if arg_2_2 == attrStatus.attrCurValue then
			var_2_0 = arg_2_0.normalAttack
		elseif arg_2_2 == attrStatus.attrInitialValue then
			var_2_0 = arg_2_0.normalAttackInitial
		elseif arg_2_2 == attrStatus.attrGrowValue then
			var_2_0 = arg_2_0.normalAttackGrow
		end
	elseif arg_2_1 == BattleAttrsType.eNormalDefense then
		if arg_2_2 == attrStatus.attrCurValue then
			var_2_0 = arg_2_0.normalDefense
		elseif arg_2_2 == attrStatus.attrInitialValue then
			var_2_0 = arg_2_0.normalDefenseInitial
		elseif arg_2_2 == attrStatus.attrGrowValue then
			var_2_0 = arg_2_0.normalDefenseGrow
		end
	elseif arg_2_1 == BattleAttrsType.eSkillAttack then
		if arg_2_2 == attrStatus.attrCurValue then
			var_2_0 = arg_2_0.skillAttack
		elseif arg_2_2 == attrStatus.attrInitialValue then
			var_2_0 = arg_2_0.skillAttackInitial
		elseif arg_2_2 == attrStatus.attrGrowValue then
			var_2_0 = arg_2_0.skillAttackGrow
		end
	elseif arg_2_1 == BattleAttrsType.eSkillDefense then
		if arg_2_2 == attrStatus.attrCurValue then
			var_2_0 = arg_2_0.skillDefense
		elseif arg_2_2 == attrStatus.attrInitialValue then
			var_2_0 = arg_2_0.skillDefenseInitial
		elseif arg_2_2 == attrStatus.attrGrowValue then
			var_2_0 = arg_2_0.skillDefenseGrow
		end
	elseif arg_2_1 == BattleAttrsType.eMingZhong then
		if arg_2_2 == attrStatus.attrCurValue then
			var_2_0 = arg_2_0.mingzhong
		elseif arg_2_2 == attrStatus.attrLevel then
			var_2_0 = arg_2_0.mingzhongLevel
		elseif arg_2_2 == attrStatus.attrCurExp then
			var_2_0 = arg_2_0.mingzhongCurExp
		end
	elseif arg_2_1 == BattleAttrsType.eShanBi then
		if arg_2_2 == attrStatus.attrCurValue then
			var_2_0 = arg_2_0.shanbi
		elseif arg_2_2 == attrStatus.attrLevel then
			var_2_0 = arg_2_0.shanbiLevel
		elseif arg_2_2 == attrStatus.attrCurExp then
			var_2_0 = arg_2_0.shanbiCurExp
		end
	elseif arg_2_1 == BattleAttrsType.eBaoJi then
		if arg_2_2 == attrStatus.attrCurValue then
			var_2_0 = arg_2_0.baoji
		elseif arg_2_2 == attrStatus.attrLevel then
			var_2_0 = arg_2_0.baojiLevel
		elseif arg_2_2 == attrStatus.attrCurExp then
			var_2_0 = arg_2_0.baojiCurExp
		end
	elseif arg_2_1 == BattleAttrsType.eRenXing then
		if arg_2_2 == attrStatus.attrCurValue then
			var_2_0 = arg_2_0.renxing
		elseif arg_2_2 == attrStatus.attrLevel then
			var_2_0 = arg_2_0.renxingLevel
		elseif arg_2_2 == attrStatus.attrCurExp then
			var_2_0 = arg_2_0.renxingCurExp
		end
	elseif arg_2_1 == BattleAttrsType.ePoJi then
		if arg_2_2 == attrStatus.attrCurValue then
			var_2_0 = arg_2_0.poji
		elseif arg_2_2 == attrStatus.attrLevel then
			var_2_0 = arg_2_0.pojiLevel
		elseif arg_2_2 == attrStatus.attrCurExp then
			var_2_0 = arg_2_0.pojiCurExp
		end
	elseif arg_2_1 == BattleAttrsType.eGeDang then
		if arg_2_2 == attrStatus.attrCurValue then
			var_2_0 = arg_2_0.gedang
		elseif arg_2_2 == attrStatus.attrLevel then
			var_2_0 = arg_2_0.gedangLevel
		elseif arg_2_2 == attrStatus.attrCurExp then
			var_2_0 = arg_2_0.gedangCurExp
		end
	elseif arg_2_2 == attrStatus.attrLevel then
		var_2_0 = arg_2_0.level
	end

	return var_2_0
end

function var_0_1.ctor(arg_3_0, arg_3_1)
	arg_3_0:addTouchEventListener(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_3_0:setTouchEnabled(true)

	arg_3_0.equipId = arg_3_1.equipId
	arg_3_0.equipUserId = arg_3_1.equipUserId
	arg_3_0.rebirthParams = arg_3_1.rebirthParams

	local var_3_0 = CCSize(500, 280)
	local var_3_1 = display.newScale9Sprite("ui/common/common_116.png")

	var_3_1:setPreferredSize(var_3_0)
	var_3_1:setAnchorPoint(CCPoint(0.5, 0.5))
	var_3_1:setPosition(display.cx, display.cy)
	var_3_1:setScale(Adapter.MinScale)
	arg_3_0:addChild(var_3_1, 100)
	addLabelWithColorSize(var_3_1, string.lf("上仙，只有1级0阶的装备才能作为喂灵升阶材料，"), ccc3(200, 170, 100), 20, CCPoint(0.5, 1), CCPoint(var_3_0.width / 2, var_3_0.height - 20))
	addLabelWithColorSize(var_3_1, string.lf("您的以下装备重生后即可使用: "), ccc3(200, 170, 100), 20, CCPoint(0.5, 1), CCPoint(var_3_0.width / 2, var_3_0.height - 50))

	arg_3_0.equipList = {}

	local function var_3_2(arg_5_0)
		for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
			local var_5_0 = {}

			if iter_5_1.equipId == arg_3_0.equipId and iter_5_1.equipUserId ~= arg_3_0.equipUserId and iter_5_1.isInTeam == 0 and (iter_5_1.level > 1 or iter_5_1.BreakthroughCount > 0) then
				var_5_0.ID = iter_5_1.equipId
				var_5_0.Type = ItemType.eEquip
				var_5_0.Count = 1
				var_5_0.Level = iter_5_1.level
				var_5_0.BreakthroughCount = iter_5_1.BreakthroughCount

				table.insert(arg_3_0.equipList, var_5_0)
			end
		end
	end

	EquipHelper:getEquipList(EquipClassType.eEquipAll, var_3_2)

	local var_3_3 = table.nums(arg_3_0.equipList)
	local var_3_4 = 130
	local var_3_5 = CCSize(var_3_3 <= 3 and var_3_3 * var_3_4 or 450, 160)
	local var_3_6 = display.newScale9Sprite("ui/common/common_064_4.png", var_3_0.width / 2, var_3_0.height / 2 - 10)

	var_3_6:setAnchorPoint(CCPoint(0.5, 0.5))
	var_3_6:setPreferredSize(var_3_5)
	var_3_1:addChild(var_3_6)

	local var_3_7 = CCSize(var_3_5.width, var_3_5.height - 20)
	local var_3_8 = CCSize(var_3_4, var_3_5.height - 20)

	local function var_3_9(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = CCLayerColor:create(ccc4(46, 39, 29, 0))

		var_6_0:setContentSize(var_3_8)

		local var_6_1 = figure.createHeader({
			isName = true,
			inTeam = false,
			itemId = arg_6_2.ID,
			type = arg_6_2.Type,
			count = arg_6_2.Count,
			level = arg_6_2.Level,
			equipJieji = arg_6_2.BreakthroughCount,
			equipGem = arg_6_2.gem
		})

		var_6_1:setAnchorPoint(CCPoint(0.5, 0.5))
		var_6_1:setPosition(var_3_8.width / 2, var_3_8.height / 2 + 10)
		var_6_0:addChild(var_6_1)

		return var_6_0
	end

	local var_3_10 = createTableView({
		reverse = false,
		direction = kCCScrollViewDirectionHorizontal,
		size = var_3_7,
		dataset = arg_3_0.equipList,
		sizehandler = function(arg_7_0, arg_7_1)
			return var_3_8
		end,
		cellhandler = var_3_9
	})

	var_3_10:setPosition(0, 10)
	var_3_6:addChild(var_3_10)

	local var_3_11 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		highlightedImage = "ui/common/common_115.png",
		text = string.lf("去重生"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		position = CCPoint(var_3_0.width / 2 - 100, 35),
		clickAction = function()
			game.enterRefineScene(arg_3_0.rebirthParams)
		end
	})

	var_3_1:addChild(var_3_11)

	local var_3_12 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		highlightedImage = "ui/common/common_115.png",
		text = string.lf("关闭"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		position = CCPoint(var_3_0.width / 2 + 100, 35),
		clickAction = function()
			arg_3_0:removeFromParentAndCleanup(true)
		end
	})

	var_3_1:addChild(var_3_12)
end

return var_0_1
