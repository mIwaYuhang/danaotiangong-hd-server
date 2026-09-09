local var_0_0 = require("scenes.toollayer.herobase")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = class("BaseHeroInfoLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create(ccc4(10, 10, 10, 160)))
end)

function var_0_2.ctor(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or {
		id = 401,
		type = ItemType.eHero
	}

	if arg_2_1.player == nil then
		arg_2_1.player = false
	end

	arg_2_0.params = arg_2_1
	arg_2_0.hero = var_0_0.new({
		type = arg_2_1.type,
		id = arg_2_1.id,
		player = arg_2_1.player
	})

	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		return true
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	local var_2_0 = display.newSprite("ui/team/team_111.png")
	local var_2_1 = var_2_0:getContentSize()

	var_2_0:align(display.CENTER, display.cx, display.cy)
	var_2_0:setScale(Adapter.MinScale)
	arg_2_0:addChild(var_2_0)

	arg_2_0.bgSprite = var_2_0
	arg_2_0.nodeSize = var_2_1

	local var_2_2 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		clickAction = function()
			arg_2_0:removeFromParent()
		end,
		position = ccp(var_2_1.width, var_2_1.height)
	})

	var_2_0:addChild(var_2_2, 1)
	arg_2_0:createHeroAndDesc(var_2_0)

	local var_2_3
	local var_2_4 = {}
	local var_2_5 = arg_2_0:createHeroAttr()

	table.insert(var_2_4, var_2_5)

	local var_2_6 = arg_2_0:createRageSkills()

	table.insert(var_2_4, var_2_6)

	local var_2_7 = arg_2_0:createHeroSkills()

	table.insert(var_2_4, var_2_7)

	local var_2_8 = arg_2_0:createHeroGroupInfo()

	table.insert(var_2_4, var_2_8)

	if #arg_2_0.hero.model.groupEquips > 0 then
		local var_2_9 = arg_2_0:createEquipGroupInfo()

		table.insert(var_2_4, var_2_9)
	end

	local var_2_10 = var_0_1.linearLayout({
		margin = 10,
		direction = "vertical",
		nodes = var_2_4
	})
	local var_2_11 = CCSize(420, 472)

	arg_2_0.viewSize = var_2_11

	local var_2_12 = CCScrollView:create(var_2_11, var_2_10)

	var_2_12:setPosition(350, 5)
	var_2_12:setDirection(kCCScrollViewDirectionVertical)
	var_2_12:setContentOffset(var_2_12:minContainerOffset())
	var_2_0:addChild(var_2_12)
end

function var_0_2.createHeroAndDesc(arg_5_0, arg_5_1)
	local var_5_0 = display.newSprite("ui/team/team_112.png")
	local var_5_1 = var_5_0:getContentSize()

	var_5_0:setPosition(var_5_1.width / 2 + 5, var_5_1.height / 2 + 5)
	arg_5_1:addChild(var_5_0)

	local var_5_2 = arg_5_0.hero
	local var_5_3 = var_5_2.model
	local var_5_4 = var_5_2:createFigureNode()

	var_5_4:setPosition(55, 125)
	var_5_0:addChild(var_5_4)

	local var_5_5 = var_0_1.newLabel({
		text = "LV" .. var_5_3.level .. "  " .. var_5_3.name
	})

	var_5_5:setPosition(var_5_1.width / 2, 445)
	var_5_0:addChild(var_5_5)

	local var_5_6 = var_0_1.newLabel({
		text = var_5_3.pianXiang,
		color = ccc3(241, 250, 140)
	})

	var_5_6:setPosition(var_5_1.width / 2, 400)
	var_5_0:addChild(var_5_6)

	local var_5_7 = addLabelWithColorSize(var_5_0, var_5_3.desc, ccc3(239, 223, 181), 18, CCPoint(0.5, 1), CCPoint(var_5_1.width / 2 + 5, 120))

	var_5_7:setHorizontalAlignment(ui.TEXT_ALIGN_LEFT)
	var_5_7:setVerticalAlignment(ui.TEXT_VALIGN_TOP)
	var_5_7:setDimensions(CCSize(320, 140))

	local var_5_8 = ui.newControlButton({
		normalImage = "ui/team/team_125.png",
		clickAction = function(arg_6_0, arg_6_1)
			local var_6_0 = var_5_3.id
			local var_6_1 = require("scenes.team.HeroRebirthPreviewLayer").new({
				heroId = var_6_0,
				returnAction = function()
					game.enterTujianScene({
						preview = var_6_0
					})
				end
			})

			CCDirector:sharedDirector():getRunningScene():addChild(var_6_1)
		end
	})

	var_5_8:setPosition(40, 280)
	var_5_0:addChild(var_5_8)
end

function var_0_2.createHeroAttr(arg_8_0)
	local var_8_0 = CCSize(420, 40)
	local var_8_1 = var_0_1.newNode()
	local var_8_2 = arg_8_0.hero.model
	local var_8_3 = {}

	table.insert(var_8_3, string.lf("普通攻击: #20E500%d", var_8_2.normalattack))
	table.insert(var_8_3, string.lf("普通防御: #20E500%d", var_8_2.normaldefense))
	table.insert(var_8_3, string.lf("技能攻击: #20E500%d", var_8_2.skillattack))
	table.insert(var_8_3, string.lf("技能防御: #20E500%d", var_8_2.skilldefense))
	table.insert(var_8_3, string.lf("主将资质: #20E500%d", var_8_2.rating))

	local var_8_4
	local var_8_5 = {}

	for iter_8_0, iter_8_1 in ipairs(var_8_3) do
		local var_8_6 = var_0_1.newLabel({
			size = 20,
			text = var_8_3[iter_8_0],
			color = ccc3(239, 223, 181)
		})

		table.insert(var_8_5, var_8_6)
	end

	local var_8_7 = var_0_1.tableLayout({
		row = 0,
		col = 2,
		nodes = var_8_5,
		size = CCSize(350, 20),
		padding = {
			top = 0,
			bottom = 0,
			left = 20,
			right = 0
		},
		align = display.LEFT_CENTER
	})
	local var_8_8 = var_8_7:getContentSize()

	var_8_0.height = var_8_0.height + var_8_8.height

	var_8_7:setAnchorPoint(ccp(0.5, 0))
	var_8_7:setPosition(210, 5)
	var_8_1:addChild(var_8_7)

	local var_8_9 = display.newSprite("uilocal/team/team_text_037.png")

	var_8_9:setPosition(220, var_8_0.height - 20)
	var_8_1:addChild(var_8_9)
	var_8_1:setContentSize(var_8_0)

	return var_8_1
end

function var_0_2.createRageSkills(arg_9_0)
	local var_9_0 = CCSize(420, 120)
	local var_9_1 = var_0_1.newNode()

	var_9_1:setContentSize(var_9_0)

	local var_9_2 = arg_9_0.hero.model
	local var_9_3 = var_9_2.id
	local var_9_4 = var_9_2.rageSkillLevel or 0
	local var_9_5 = BaseHeros[var_9_3].skillId or 1
	local var_9_6 = BaseSkills[var_9_5]
	local var_9_7 = ccc3(239, 223, 181)
	local var_9_8 = getHeroRageSkillDesc(var_9_5, var_9_4, var_9_2.skillAttack, "#EFDFB5")
	local var_9_9 = var_0_1.newLabel({
		size = 22,
		text = string.lf("【%s】 %s级", var_9_6.name, var_9_4),
		font = _FONT_LISU,
		color = ccc3(130, 130, 15)
	})

	var_9_9:align(display.LEFT_CENTER, 10, var_9_0.height - 50)
	var_9_1:addChild(var_9_9)

	local var_9_10 = var_0_1.newLabel({
		size = 18,
		text = var_9_8,
		dimensions = CCSize(283, 0),
		color = var_9_7
	})

	var_9_10:align(display.LEFT_TOP, 15, var_9_0.height - 60)
	var_9_1:addChild(var_9_10)

	local var_9_11 = display.newSprite(getQualityBgImageName(var_9_6.quality))
	local var_9_12 = var_9_11:getContentSize()

	var_9_11:setPosition(377, var_9_0.height - 70)
	var_9_1:addChild(var_9_11)

	local var_9_13 = display.newSprite("skillicon/" .. var_9_6.headerImage)

	var_9_13:setPosition(var_9_12.width / 2, var_9_12.height / 2)
	var_9_11:addChild(var_9_13)

	local var_9_14 = display.newSprite("uilocal/guild/guild_text_049.png")

	var_9_14:setPosition(220, var_9_0.height - 20)
	var_9_1:addChild(var_9_14)

	return var_9_1
end

function var_0_2.createHeroSkills(arg_10_0)
	local var_10_0 = CCSize(420, 120)
	local var_10_1 = var_0_1.newNode()
	local var_10_2 = arg_10_0.hero.model
	local var_10_3 = ccc3(239, 223, 181)
	local var_10_4 = var_10_2.madSkillLevel

	if var_10_4 > 0 then
		var_10_0.height = var_10_0.height + 120

		local var_10_5, var_10_6, var_10_7 = getHeroMadSkillDesc(var_10_4, BaseHeros[var_10_2.id].quality)
		local var_10_8 = var_0_1.newLabel({
			size = 22,
			text = string.lf("【%s】%d级", var_10_7, var_10_4),
			color = ccc3(130, 130, 15),
			font = _FONT_LISU
		})

		var_10_8:align(display.LEFT_CENTER, 10, var_10_0.height - 155)
		var_10_1:addChild(var_10_8)

		local var_10_9 = display.newSprite(getQualityBgImageName(QualityType.ePurple))
		local var_10_10 = var_10_9:getContentSize()

		var_10_9:setPosition(377, var_10_0.height - 180)
		var_10_1:addChild(var_10_9)

		local var_10_11 = display.newSprite(var_10_6)

		var_10_11:setPosition(var_10_10.width / 2, var_10_10.height / 2)
		var_10_9:addChild(var_10_11)

		local var_10_12 = var_0_1.newLabel({
			size = 18,
			text = var_10_5,
			dimensions = CCSize(283, 0),
			color = var_10_3
		})

		var_10_12:align(display.LEFT_TOP, 15, var_10_0.height - 160)
		var_10_1:addChild(var_10_12)
	end

	local var_10_13 = var_10_2.id
	local var_10_14 = var_10_2.rebirthCount or 0
	local var_10_15 = var_10_2.talentId or 1
	local var_10_16 = BaseSkills[var_10_15]
	local var_10_17, var_10_18 = getHeroTalentSkillDesc(var_10_13, var_10_14, "#EFDFB5")
	local var_10_19 = var_0_1.newLabel({
		size = 22,
		text = "【" .. var_10_16.name .. "】 " .. var_10_17,
		font = _FONT_LISU,
		color = ccc3(130, 130, 15)
	})

	var_10_19:align(display.LEFT_CENTER, 10, var_10_0.height - 50)
	var_10_1:addChild(var_10_19)

	local var_10_20 = var_0_1.newLabel({
		size = 18,
		text = var_10_18,
		dimensions = CCSize(283, 0),
		color = var_10_3
	})

	var_10_20:align(display.LEFT_TOP, 15, var_10_0.height - 60)
	var_10_1:addChild(var_10_20)

	local var_10_21 = display.newSprite(getQualityBgImageName(var_10_16.quality))
	local var_10_22 = var_10_21:getContentSize()

	var_10_21:setPosition(377, var_10_0.height - 70)
	var_10_1:addChild(var_10_21)

	local var_10_23 = display.newSprite("skillicon/" .. var_10_16.headerImage)

	var_10_23:setPosition(var_10_22.width / 2, var_10_22.height / 2)
	var_10_21:addChild(var_10_23)

	local var_10_24 = display.newSprite("uilocal/team/team_text_034.png")

	var_10_24:setPosition(220, var_10_0.height - 20)
	var_10_1:addChild(var_10_24)
	var_10_1:setContentSize(var_10_0)

	return var_10_1
end

function var_0_2.createHeroGroupInfo(arg_11_0)
	local var_11_0 = CCSize(420, 40)
	local var_11_1 = var_0_1.newNode()
	local var_11_2 = arg_11_0.hero.model
	local var_11_3 = ccc3(239, 223, 181)
	local var_11_4 = ccc3(111, 105, 81)
	local var_11_5 = ccc3(32, 255, 0)
	local var_11_6
	local var_11_7 = {}
	local var_11_8 = 18
	local var_11_9 = convertColorToLabelString(var_11_5)
	local var_11_10 = "#EFDFB5"

	for iter_11_0, iter_11_1 in ipairs(var_11_2.groupAttrs) do
		local var_11_11, var_11_12 = Player:isHerosInteam(iter_11_1.heroList)
		local var_11_13 = var_11_11 == true and var_11_5 or var_11_3
		local var_11_14 = {
			string.lf("与")
		}
		local var_11_15 = {}

		for iter_11_2, iter_11_3 in pairs(iter_11_1.heroList) do
			if var_11_12[iter_11_3] == true and var_11_11 == false then
				table.insert(var_11_15, var_11_9)
				table.insert(var_11_15, BaseHeros[iter_11_3].name)
				table.insert(var_11_15, var_11_10)
			else
				table.insert(var_11_15, BaseHeros[iter_11_3].name)
			end

			if iter_11_1.heroList[iter_11_2 + 1] ~= nil then
				table.insert(var_11_15, "、")
			end
		end

		table.insert(var_11_14, table.concat(var_11_15))
		table.insert(var_11_14, string.lf("上阵, "))

		local var_11_16 = {
			BattleAttrsName[iter_11_1.addType],
			string.lf("加"),
			iter_11_1.factor * 100,
			"%"
		}

		table.insert(var_11_14, table.concat(var_11_16))

		local var_11_17 = var_0_1.newLabel({
			text = iter_11_1.name .. "：",
			color = var_11_13,
			size = var_11_8
		})
		local var_11_18 = var_0_1.newLabel({
			text = table.concat(var_11_14),
			color = var_11_13,
			size = var_11_8,
			dimensions = CCSize(300, 0)
		})
		local var_11_19 = var_0_1.linearLayout({
			direction = "horizontal",
			nodes = {
				var_11_17,
				var_11_18
			},
			align = display.LEFT_TOP
		})

		table.insert(var_11_7, var_11_19)
	end

	local var_11_20 = var_0_1.linearLayout({
		margin = 5,
		direction = "vertical",
		nodes = var_11_7
	})
	local var_11_21 = var_11_20:getContentSize()

	var_11_0.height = var_11_0.height + var_11_21.height + 10

	var_11_20:align(display.LEFT_TOP, 10, var_11_0.height - 40)
	var_11_1:addChild(var_11_20)

	local var_11_22 = display.newSprite("uilocal/team/team_text_035.png")

	var_11_22:setPosition(220, var_11_0.height - 20)
	var_11_1:addChild(var_11_22)
	var_11_1:setContentSize(var_11_0)

	return var_11_1
end

function var_0_2.createEquipGroupInfo(arg_12_0)
	local var_12_0 = CCSize(420, 40)
	local var_12_1 = var_0_1.newNode()
	local var_12_2 = arg_12_0.hero
	local var_12_3 = var_12_2.model
	local var_12_4 = var_12_2:createGroupEquipIcons()
	local var_12_5 = var_12_4:getContentSize()

	var_12_0.height = var_12_0.height + var_12_5.height

	var_12_4:align(display.CENTER_TOP, var_12_0.width / 2, var_12_0.height - 40)
	var_12_1:addChild(var_12_4)

	local var_12_6 = display.newSprite("uilocal/team/team_text_036.png")

	var_12_6:setPosition(220, var_12_0.height - 20)
	var_12_1:addChild(var_12_6)
	var_12_1:setContentSize(var_12_0)

	return var_12_1
end

return var_0_2
