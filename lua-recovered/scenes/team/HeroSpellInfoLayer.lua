require("network.TeamRequest")
require("scenes.team.TeamScene")

local var_0_0 = class("HeroSpellInfoLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.curHero = arg_2_1.heroItem
	arg_2_0.team = arg_2_1.team or Player.team
	arg_2_0.partnerTeam = arg_2_1.partnerTeam or Player.partnerTeam
	arg_2_0.curIndex = arg_2_1.curIndex and arg_2_1.curIndex or -1

	local var_2_0 = arg_2_1.size or CCSize(445, 510)

	arg_2_0.bgSprite = display.newScale9Sprite("ui/team/team_002.png")

	arg_2_0.bgSprite:setPreferredSize(var_2_0)
	arg_2_0.bgSprite:setAnchorPoint(CCPoint(0, 0))
	arg_2_0.bgSprite:setPosition(CCPoint(0, 2))
	arg_2_0:addChild(arg_2_0.bgSprite)

	arg_2_0.bgSize = arg_2_0.bgSprite:getContentSize()

	if arg_2_0.curHero and arg_2_0.curHero.heroId > 0 then
		arg_2_0.contentNode = arg_2_0:createHeroInfoNode()
	end
end

function var_0_0.refreshLayer(arg_3_0, arg_3_1)
	arg_3_0.curHero = arg_3_1.heroItem
	arg_3_0.curIndex = arg_3_1.curIndex and arg_3_1.curIndex or -1

	if arg_3_0.contentNode then
		arg_3_0.contentNode:removeFromParent()

		arg_3_0.contentNode = nil
	end

	if arg_3_0.curHero and arg_3_0.curHero.heroId > 0 then
		arg_3_0.contentNode = arg_3_0:createHeroInfoNode()
	end
end

function var_0_0.createHeroInfoNode(arg_4_0)
	local var_4_0 = CCSize(420, 500)
	local var_4_1, var_4_2 = arg_4_0:createHeroGroupsInfo(var_4_0)
	local var_4_3 = var_4_1 + 130
	local var_4_4 = arg_4_0.curHero.madSkillLevel

	arg_4_0.viewContentHeight = var_4_4 and var_4_4 > 0 and 755 or 675
	arg_4_0.viewContentHeight = arg_4_0.viewContentHeight + var_4_3

	local var_4_5 = CCScrollView:create(var_4_0)

	var_4_5:setPosition((arg_4_0.bgSize.width - var_4_0.width) / 2 - 10, (arg_4_0.bgSize.height - var_4_0.height) / 2)
	var_4_5:setDirection(kCCScrollViewDirectionVertical)
	var_4_5:setContentSize(CCSize(var_4_0.width, arg_4_0.viewContentHeight))
	arg_4_0.bgSprite:addChild(var_4_5)
	var_4_5:setContentOffset(var_4_5:minContainerOffset())
	var_4_2:setPosition(ccp(0, arg_4_0.viewContentHeight - 130))
	var_4_5:getContainer():addChild(var_4_2)
	arg_4_0:createBaseAttributeUI(var_4_5:getContainer(), var_4_0, arg_4_0.viewContentHeight)
	arg_4_0:createEquipsUI(var_4_5:getContainer(), var_4_0, arg_4_0.viewContentHeight - 10 - var_4_3)
	arg_4_0:createRageSkillUI(var_4_5:getContainer(), var_4_0, arg_4_0.viewContentHeight - 115 - var_4_3)
	arg_4_0:createTalentSkillUI(var_4_5:getContainer(), var_4_0, arg_4_0.viewContentHeight - 330 - var_4_3)

	local var_4_6 = var_4_4 and var_4_4 > 0 and arg_4_0.viewContentHeight - 520 - 80 - var_4_3 or arg_4_0.viewContentHeight - 520 - var_4_3

	arg_4_0:createHeroDescUI(var_4_5:getContainer(), var_4_0, var_4_6)

	return var_4_5
end

function var_0_0.createHeroGroupsInfo(arg_5_0, arg_5_1)
	local var_5_0 = 0
	local var_5_1 = display.newNode()
	local var_5_2 = display.newSprite("ui/common/common_064_2.png", arg_5_1.width / 2, var_5_0 - 22)
	local var_5_3 = display.newSprite("uilocal/team/team_text_032.png", arg_5_1.width / 2 - 20, var_5_0 - 18)

	var_5_1:addChild(var_5_2)
	var_5_1:addChild(var_5_3)

	local var_5_4 = 45
	local var_5_5 = 0
	local var_5_6 = #BaseHeros[arg_5_0.curHero.heroId].groupAttrs

	for iter_5_0, iter_5_1 in ipairs(BaseHeros[arg_5_0.curHero.heroId].groupAttrs) do
		local var_5_7, var_5_8 = Player:isHerosInteam(iter_5_1.heroList, arg_5_0.team, arg_5_0.partnerTeam)
		local var_5_9 = string.lf("与")
		local var_5_10 = var_5_7 == true and ccc3(130, 30, 15) or ccc3(62, 63, 64)
		local var_5_11 = iter_5_1.name .. ":"

		if var_5_7 == true then
			var_5_5 = var_5_5 + 1
		end

		local var_5_12 = ""

		for iter_5_2, iter_5_3 in pairs(iter_5_1.heroList) do
			if var_5_8[iter_5_3] == true and var_5_7 == false then
				var_5_12 = var_5_12 .. convertColorToLabelString(ccc3(130, 30, 15)) .. BaseHeros[iter_5_3].name .. "#3e3f40"
			else
				var_5_12 = var_5_12 .. BaseHeros[iter_5_3].name
			end

			if iter_5_1.heroList[iter_5_2 + 1] ~= nil then
				var_5_12 = var_5_12 .. "、"
			end
		end

		local var_5_13 = string.lf("%s%s上阵, ", var_5_9, var_5_12)
		local var_5_14 = string.lf("%s加%s%%", BattleAttrsName[iter_5_1.addType], iter_5_1.factor * 100)
		local var_5_15 = var_5_13 .. var_5_14
		local var_5_16 = Platform.getStringDrawHeight({
			width = 300,
			fontSize = 20,
			text = var_5_15,
			fontName = _FONT_DEFAULT
		})

		addLabelWithColorSize(var_5_1, var_5_11, var_5_10, 20, ccp(1, 1), ccp(120, var_5_0 - var_5_4))

		local var_5_17 = addLabelWithColorSize(var_5_1, var_5_15, var_5_10, 20, ccp(0, 1), ccp(120, var_5_0 - var_5_4))

		var_5_17:setHorizontalAlignment(ui.TEXT_ALIGN_LEFT)
		var_5_17:setDimensions(CCSize(300, var_5_16))

		var_5_4 = var_5_4 + var_5_16 + 5
	end

	local var_5_18 = string.format("(%d/%d)", var_5_5, var_5_6)

	addLabelWithColorSize(var_5_1, var_5_18, ccc3(252, 229, 144), 20, ccp(0, 0.5), ccp(arg_5_1.width / 2 + 45, var_5_0 - 17))

	return var_5_4, var_5_1
end

function var_0_0.createEquipsUI(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = display.newSprite("ui/common/common_064_2.png", arg_6_2.width / 2, arg_6_3 - 22)
	local var_6_1 = display.newSprite("uilocal/team/team_text_005.png", arg_6_2.width / 2 - 20, arg_6_3 - 18)

	arg_6_1:addChild(var_6_0)
	arg_6_1:addChild(var_6_1)

	local var_6_2 = BaseHeros[arg_6_0.curHero.heroId].groupEquips
	local var_6_3 = table.getn(var_6_2)
	local var_6_4 = BaseHeros[arg_6_0.curHero.heroId].groupEquips

	if var_6_4 ~= nil or table.nums(var_6_4) > 0 then
		local var_6_5 = ui.newControlButton({
			scaleX = 0.8,
			normalImage = "ui/team/team_124.png",
			scaleY = 0.8,
			position = ccp(arg_6_2.width / 2 + 150, arg_6_3 - 18),
			clickAction = function()
				local var_7_0 = require("scenes.team.DlgWhereEquipLayer").new({
					curIndex = arg_6_0.curIndex,
					heroId = arg_6_0.curHero.heroId,
					equipList = var_6_4
				})

				CCDirector:sharedDirector():getRunningScene():addChild(var_7_0, DefaultZOrder.ePopupLayer)
			end
		})

		arg_6_1:addChild(var_6_5)
	end

	local var_6_6 = 0

	for iter_6_0 = 1, var_6_3 do
		local var_6_7 = false

		if arg_6_0.curHero.equipList then
			for iter_6_1, iter_6_2 in ipairs(arg_6_0.curHero.equipList) do
				if iter_6_2.equipId == var_6_4[iter_6_0].equipId then
					var_6_7 = true
					var_6_6 = var_6_6 + 1

					break
				end
			end
		end

		local var_6_8 = var_6_7 == true and ccc3(130, 30, 15) or ccc3(62, 63, 64)
		local var_6_9 = (iter_6_0 - 1) % 3 * 130 + 45
		local var_6_10 = arg_6_3 - 58 - math.floor((iter_6_0 - 1) / 3) * 31

		addLabelWithColorSize(arg_6_1, BaseEquips[var_6_4[iter_6_0].equipId].name, var_6_8, 20, ccp(0, 0.5), ccp(var_6_9, var_6_10))
	end

	local var_6_11 = string.format("(%d/%d)", var_6_6, var_6_3)

	addLabelWithColorSize(arg_6_1, var_6_11, ccc3(252, 229, 144), 20, ccp(0, 0.5), ccp(arg_6_2.width / 2 + 45, arg_6_3 - 17))
end

function var_0_0.createRageSkillUI(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = BaseHeros[arg_8_0.curHero.heroId].skillId or 1
	local var_8_1 = display.newSprite("ui/common/common_064_2.png", arg_8_2.width / 2, arg_8_3 - 22)
	local var_8_2 = display.newSprite("uilocal/team/team_text_001.png", arg_8_2.width / 2, arg_8_3 - 20)

	arg_8_1:addChild(var_8_1)
	arg_8_1:addChild(var_8_2)

	local var_8_3 = arg_8_0.curHero.rageSkillLevel
	local var_8_4 = string.lf("【%s】%d级", BaseSkills[var_8_0].name, var_8_3)

	addLabelWithColorSize(arg_8_1, var_8_4, ccc3(130, 30, 15), 22, ccp(0, 0.5), ccp(30, arg_8_3 - 58), _FONT_LISU)

	local var_8_5 = display.newSprite(getQualityBgImageName(BaseSkills[var_8_0].quality), 377, arg_8_3 - 95)
	local var_8_6 = var_8_5:getContentSize()

	var_8_5:setAnchorPoint(CCPoint(0.5, 0.5))
	arg_8_1:addChild(var_8_5)

	local var_8_7 = display.newSprite("skillicon/" .. BaseSkills[var_8_0].headerImage, var_8_6.width / 2, var_8_6.height / 2)

	var_8_7:setAnchorPoint(CCPoint(0.5, 0.5))
	var_8_5:addChild(var_8_7)

	local var_8_8 = getHeroRageSkillDesc(var_8_0, var_8_3, arg_8_0.curHero.skillAttack, "#000000")
	local var_8_9 = ui.newTTFLabel({
		x = 39,
		text = var_8_8,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(20),
		color = display.COLOR_BLACK,
		align = ui.TEXT_ALIGN_LEFT,
		valign = ui.TEXT_VALIGN_TOP,
		dimensions = CCSize(283, 150),
		y = arg_8_3 - 145
	})

	arg_8_1:addChild(var_8_9)

	local var_8_10 = display.newSprite("uilocal/team/team_text_015.png", arg_8_2.width / 2, arg_8_3 - 195)

	arg_8_1:addChild(var_8_10)
end

function var_0_0.createTalentSkillUI(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_0.curHero.heroId
	local var_9_1 = arg_9_0.curHero.rebirthCount
	local var_9_2 = BaseHeros[var_9_0].talentId or 1
	local var_9_3 = display.newSprite("ui/common/common_064_2.png", arg_9_2.width / 2, arg_9_3 - 22)
	local var_9_4 = display.newSprite("uilocal/team/team_text_002.png", arg_9_2.width / 2, arg_9_3 - 19)

	arg_9_1:addChild(var_9_3)
	arg_9_1:addChild(var_9_4)

	local var_9_5, var_9_6 = getHeroTalentSkillDesc(var_9_0, var_9_1, "#000000")

	addLabelWithColorSize(arg_9_1, "【" .. BaseSkills[var_9_2].name .. "】 " .. var_9_5, ccc3(130, 30, 15), 22, ccp(0, 0.5), ccp(30, arg_9_3 - 60), _FONT_LISU)

	local var_9_7 = ui.newTTFLabel({
		x = 39,
		text = var_9_6,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(20),
		color = display.COLOR_BLACK,
		align = ui.TEXT_ALIGN_LEFT,
		valign = ui.TEXT_VALIGN_TOP,
		dimensions = CCSize(283, 130),
		y = arg_9_3 - 145
	})

	arg_9_1:addChild(var_9_7)

	local var_9_8 = display.newSprite(getQualityBgImageName(BaseSkills[var_9_2].quality), 377, arg_9_3 - 91)
	local var_9_9 = var_9_8:getContentSize()

	var_9_8:setAnchorPoint(CCPoint(0.5, 0.5))
	arg_9_1:addChild(var_9_8)

	local var_9_10 = display.newSprite("skillicon/" .. BaseSkills[var_9_2].headerImage, var_9_9.width / 2, var_9_9.height / 2)

	var_9_10:setAnchorPoint(CCPoint(0.5, 0.5))
	var_9_8:addChild(var_9_10)

	local var_9_11 = arg_9_3 - 175
	local var_9_12 = arg_9_0.curHero.madSkillLevel

	if var_9_12 and var_9_12 > 0 then
		local var_9_13, var_9_14, var_9_15 = getHeroMadSkillDesc(var_9_12, BaseHeros[var_9_0].quality)
		local var_9_16 = string.lf("【%s】%d级", var_9_15, var_9_12)

		addLabelWithColorSize(arg_9_1, var_9_16, ccc3(130, 30, 15), 22, ccp(0, 0.5), ccp(30, arg_9_3 - 170), _FONT_LISU)

		local var_9_17 = display.newSprite(getQualityBgImageName(QualityType.ePurple), 377, arg_9_3 - 205)
		local var_9_18 = var_9_17:getContentSize()

		var_9_17:setAnchorPoint(CCPoint(0.5, 0.5))
		arg_9_1:addChild(var_9_17)

		local var_9_19 = display.newSprite(var_9_14, var_9_18.width / 2, var_9_18.height / 2)

		var_9_19:setAnchorPoint(CCPoint(0.5, 0.5))
		var_9_17:addChild(var_9_19)

		local var_9_20 = ui.newTTFLabel({
			x = 39,
			text = var_9_13,
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(20),
			color = display.COLOR_BLACK,
			align = ui.TEXT_ALIGN_LEFT,
			valign = ui.TEXT_VALIGN_TOP,
			dimensions = CCSize(283, 130),
			y = arg_9_3 - 255
		})

		arg_9_1:addChild(var_9_20)

		var_9_11 = var_9_11 - 80
	end

	local var_9_21 = display.newSprite("uilocal/team/team_text_016.png", arg_9_2.width / 2, var_9_11)

	arg_9_1:addChild(var_9_21)
end

function var_0_0.createHeroDescUI(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = display.newSprite("ui/common/common_064_2.png", arg_10_2.width / 2, arg_10_3 - 22)
	local var_10_1 = display.newSprite("uilocal/team/team_text_000.png", arg_10_2.width / 2, arg_10_3 - 19)

	arg_10_1:addChild(var_10_0)
	arg_10_1:addChild(var_10_1)

	local var_10_2 = arg_10_0.curHero.heroId
	local var_10_3 = ui.newTTFLabel({
		x = 39,
		text = BaseHeros[var_10_2].desc,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(20),
		color = display.COLOR_BLACK,
		align = ui.TEXT_ALIGN_LEFT,
		valign = ui.TEXT_VALIGN_TOP,
		dimensions = CCSize(343, 140),
		y = arg_10_3 - 115
	})

	arg_10_1:addChild(var_10_3)
end

function var_0_0.createBaseAttributeUI(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = display.newSprite("ui/common/common_064_2.png", arg_11_2.width / 2, arg_11_3 - 22)
	local var_11_1 = display.newSprite("uilocal/team/team_text_038.png", arg_11_2.width / 2, arg_11_3 - 19)

	arg_11_1:addChild(var_11_0)
	arg_11_1:addChild(var_11_1)

	local var_11_2 = {
		string.lf("#000000根骨:#803020 %d", arg_11_0.curHero.physical),
		string.lf("#000000力量:#803020 %d", arg_11_0.curHero.strength),
		string.lf("#000000法术:#803020 %d", arg_11_0.curHero.mana),
		string.lf("#000000敏捷:#803020 %d", arg_11_0.curHero.agility),
		string.lf("#000000资质:#803020 %d", BaseHeros[arg_11_0.curHero.heroId].rating)
	}

	for iter_11_0 = 1, table.getn(var_11_2) do
		local var_11_3 = 105 + (iter_11_0 - 1) % 2 * 155
		local var_11_4 = arg_11_3 - 55 - math.floor((iter_11_0 - 1) / 2) * 28
		local var_11_5 = ui.newTTFLabel({
			text = var_11_2[iter_11_0],
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(20),
			color = ccc3(0, 0, 0),
			align = ui.TEXT_ALIGN_LEFT
		})

		var_11_5:setAnchorPoint(ccp(0, 0.5))
		var_11_5:setPosition(ccp(var_11_3, var_11_4))
		arg_11_1:addChild(var_11_5)
	end
end

return var_0_0
