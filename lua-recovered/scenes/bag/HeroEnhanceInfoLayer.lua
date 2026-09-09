require("base.figure")
require("scenes.team.TransferEffectScene")

local var_0_0 = class("HeroEnhanceInfoLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	local var_2_0 = CCSize(445, 510)
	local var_2_1 = display.newScale9Sprite("ui/team/team_002.png")

	var_2_1:setPreferredSize(var_2_0)
	var_2_1:setAnchorPoint(CCPoint(0, 0))
	var_2_1:setPosition(CCPoint(0, 2))
	arg_2_0:addChild(var_2_1)

	arg_2_0.background = CCLayerColor:create(ccc4(0, 0, 0, 0))

	arg_2_0.background:setContentSize(var_2_0)
	var_2_1:addChild(arg_2_0.background)
	arg_2_0:refreshLayer(arg_2_1)
end

function var_0_0.refreshLayer(arg_3_0, arg_3_1)
	arg_3_0.background:removeAllChildrenWithCleanup(true)

	local var_3_0 = arg_3_1.heroItem
	local var_3_1 = BaseHeros[var_3_0.heroId]
	local var_3_2 = {
		platTable = true,
		scale = 0.55,
		isViewQuality = true,
		figId = var_3_0.heroId
	}

	arg_3_0.heroNode = figure.createHero(var_3_2)

	arg_3_0.heroNode:setPosition(111, 245)
	arg_3_0.background:addChild(arg_3_0.heroNode)

	local var_3_3 = 191
	local var_3_4 = string.format("【%s】%s", HeroProfessionNames[var_3_1.profession], var_3_1.name)
	local var_3_5 = ui.newTTFLabel({
		text = var_3_4,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(23),
		color = getQualityColor(var_3_1.quality),
		align = ui.TEXT_ALIGN_LEFT
	})

	var_3_5:setAnchorPoint(ccp(0, 0.5))
	var_3_5:setPosition(ccp(var_3_3, 465))
	arg_3_0.background:addChild(var_3_5)

	local var_3_6 = {}

	if var_3_0.rebirthCount > 0 then
		local var_3_7, var_3_8 = getHeroCurrentRebirthCountAttrs(var_3_0.heroId, var_3_0.rebirthCount)

		table.insert(var_3_6, string.lf("已进阶至%s阶段", var_3_8))
	end

	table.insert(var_3_6, string.lf("品质: %s", getQualityName(BaseHeros[var_3_0.heroId].quality)))

	for iter_3_0, iter_3_1 in ipairs(var_3_6) do
		local var_3_9 = ui.newTTFLabel({
			text = var_3_6[iter_3_0],
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(20),
			color = ccc3(127, 32, 9),
			align = ui.TEXT_ALIGN_LEFT
		})

		var_3_9:setAnchorPoint(ccp(0, 0.5))
		var_3_9:setPosition(ccp(var_3_3 + 16, 458 - iter_3_0 * 28))
		arg_3_0.background:addChild(var_3_9)
	end

	local var_3_10 = ui.newTTFLabel({
		text = BaseHeros[var_3_0.heroId].desc,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(20),
		color = ccc3(41, 16, 0),
		align = ui.TEXT_ALIGN_LEFT,
		dimensions = CCSize(216, 172)
	})

	var_3_10:setAnchorPoint(ccp(0, 1))
	var_3_10:setPosition(ccp(var_3_3 + 16, 385))
	arg_3_0.background:addChild(var_3_10)

	local function var_3_11(arg_4_0, arg_4_1)
		game.enterTransferEffectScene({
			isTouchable = false,
			changeType = TransferEffectType.eEnhanceInherit,
			heroInfo = var_3_0
		})
	end

	local var_3_12 = createHeroProgressBar({
		level = var_3_0.level,
		curExp = var_3_0.curExp,
		totalExp = var_3_0.totalExp,
		clickAction = var_3_11
	})

	var_3_12:setPosition(ccp(58, 175))
	arg_3_0.background:addChild(var_3_12)

	local var_3_13 = display.newScale9Sprite("ui/common/common_064_2.png", 221, 86, CCSize(430, 92))

	arg_3_0.background:addChild(var_3_13)

	local var_3_14 = {
		string.lf("根骨: %d", var_3_0.physical),
		string.lf("力量: %d", var_3_0.strength),
		string.lf("法术: %d", var_3_0.mana),
		string.lf("敏捷: %d", var_3_0.agility)
	}

	for iter_3_2 = 1, table.getn(var_3_14) do
		local var_3_15 = 103 + (iter_3_2 - 1) % 2 * 155
		local var_3_16 = 105 - math.floor((iter_3_2 - 1) / 2) * 28
		local var_3_17 = ui.newTTFLabel({
			text = var_3_14[iter_3_2],
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(20),
			color = ccc3(255, 237, 154),
			align = ui.TEXT_ALIGN_LEFT
		})

		var_3_17:setAnchorPoint(ccp(0, 0.5))
		var_3_17:setPosition(ccp(var_3_15, var_3_16))
		arg_3_0.background:addChild(var_3_17)
	end
end

return var_0_0
