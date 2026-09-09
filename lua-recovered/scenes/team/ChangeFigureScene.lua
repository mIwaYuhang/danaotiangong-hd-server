require("base.functions")
require("network.TeamRequest")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("ChangeFigureScene", function()
	return display.newScene("ChangeFigureScene")
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or {}
	arg_2_0.prevIndex = arg_2_1.prevIndex
	arg_2_0.heroIndex = arg_2_1.heroIndex
	arg_2_0.curHeroInfo = arg_2_1.heroInfo
	arg_2_0.returnTianmingScene = arg_2_1.returnTianmingScene
	arg_2_0.guideChangeHero = arg_2_1.guideChangeHero
	arg_2_0.itemTable = {}
	arg_2_0.qualitys = {
		true,
		true,
		true,
		true
	}
	arg_2_0.professions = {
		true,
		true,
		true
	}
	arg_2_0.tableview = nil
end

function var_0_1.onEnter(arg_3_0)
	local var_3_0 = require("scenes.CommonBgLayer").new({
		titleSprite = "uilocal/team/team_text_004.png",
		returnAction = function()
			if arg_3_0.returnTianmingScene then
				game.enterTianmingScene({})
			else
				game.enterTeamScene({
					index = arg_3_0.prevIndex or arg_3_0.heroIndex
				})
			end
		end
	})
	local var_3_1 = var_3_0:getBackgroundSprite()

	arg_3_0.bgSprite = var_3_1

	local var_3_2 = var_3_1:getContentSize()

	arg_3_0:addChild(var_3_0)

	arg_3_0.tableHeight = 540
	arg_3_0.tableYPos = 25

	arg_3_0:filterHeros()

	arg_3_0.countLabel = ui.newTTFLabel({
		text = string.lf("主将数量: %d", table.nums(Player:getNotInTeamOwnedHeros())),
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(24),
		color = ccc3(219, 174, 115)
	})

	arg_3_0.countLabel:setAnchorPoint(ccp(0, 0.5))
	arg_3_0.countLabel:setPosition(200, var_3_2.height - 36)
	var_3_1:addChild(arg_3_0.countLabel)

	local var_3_3 = ui.newControlButton({
		fontSize = 24,
		normalImage = "ui/common/common_020.png",
		highlightedImage = "ui/common/common_021.png",
		text = string.lf("筛选条件"),
		textColor = ColorTable.eTitleTabButton_Normal,
		clickAction = function(arg_5_0, arg_5_1)
			local function var_5_0(arg_6_0)
				arg_3_0:filterHeros()
			end

			var_0_0.createDialog({
				show = var_0_0.eShowFigureFilter,
				quality = arg_3_0.qualitys,
				profession = arg_3_0.professions,
				callback = var_5_0
			}):show()
		end
	})

	var_3_3:setPosition(500, var_3_2.height - 36)
	var_3_1:addChild(var_3_3)

	local var_3_4 = createTableView({
		reverse = false,
		size = CCSize(940, arg_3_0.tableHeight),
		direction = kCCScrollViewDirectionHorizontal,
		dataset = arg_3_0.itemTable,
		sizehandler = function(arg_7_0, arg_7_1)
			return CCSize(235, arg_3_0.tableHeight)
		end,
		cellhandler = handler(arg_3_0, arg_3_0.createTableCell)
	})

	var_3_4:setAnchorPoint(CCPoint(0, 0))
	var_3_4:setPosition((var_3_2.width - 940) / 2, arg_3_0.tableYPos)
	var_3_1:addChild(var_3_4)

	arg_3_0.tableview = var_3_4

	GuideLayer:showGuideLayer(arg_3_0, arg_3_0.tableview, TaskEntryType.eEntryBattleHero, 3, nil, true)
	arg_3_0:initChangeRequests()
end

function var_0_1.initChangeRequests(arg_8_0)
	local function var_8_0()
		if arg_8_0.returnTianmingScene then
			game.enterTianmingScene({})
		else
			game.enterTeamScene({
				index = arg_8_0.prevIndex or arg_8_0.heroIndex,
				guideChangeHero = arg_8_0.guideChangeHero
			})
		end
	end

	arg_8_0.changeHeroRequest = ChangeHeroRequest:new(arg_8_0)

	arg_8_0.changeHeroRequest:setResponseNormalHandler(var_8_0)
end

function var_0_1.createTableCell(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = CCSize(235, arg_10_0.tableHeight)
	local var_10_1 = display.newScale9Sprite("ui/friend/friend_007.png", 0, 0, CCSize(var_10_0.width - 10, var_10_0.height - 10))

	var_10_1:align(display.LEFT_BOTTOM, 5, 0)

	if arg_10_3.tableIsEmpty then
		addLabelWithColorSize(var_10_1, string.lf("暂\n无"), ccc3(55, 40, 0), 50, CCPoint(0.5, 0.5), CCPoint(var_10_0.width / 2, var_10_0.height / 2 + 50))

		local var_10_2 = ui.newControlButton({
			normalImage = "ui/common/common_019.png",
			text = string.lf("去商城招"),
			fontSize = ColorTable.eTitleButton_FontSize2,
			position = ccp(115, 35),
			textColor = ColorTable.eTitleTabButton_Normal2,
			clickAction = function(arg_11_0, arg_11_1)
				game.enterStoreScene({
					fromChangeFigureScene = true
				})
			end
		})

		var_10_1:addChild(var_10_2)
	else
		arg_10_0:showHeroCell(var_10_1, var_10_0, arg_10_2, arg_10_3)
	end

	return var_10_1
end

function var_0_1.showHeroCell(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = arg_12_4.heroId
	local var_12_1 = getHeroGroupWeaponId(var_12_0)
	local var_12_2 = {
		scale = 0.6,
		isViewBaseInfo = false,
		isViewQuality = true,
		qualityOffsetY = -10,
		figId = var_12_0,
		equipId = var_12_1,
		pinjie = EquipPinjieType.eShengPin,
		rebirthCount = arg_12_4.rebirthCount,
		clickAction = function()
			var_0_0.createTips({
				show = var_0_0.eShowTujianHero,
				id = var_12_0
			}):show({
				x = 0,
				y = 80,
				scroll = {
					index = arg_12_3,
					size = arg_12_2,
					table = arg_12_0.tableview
				}
			})
		end
	}
	local var_12_3 = figure.createHero(var_12_2)

	var_12_3:setAnchorPoint(CCPoint(0, 0))
	var_12_3:setPosition(arg_12_2.width / 2, arg_12_2.height - 280)
	arg_12_1:addChild(var_12_3)

	local var_12_4 = BaseHeros[var_12_0]
	local var_12_5 = string.lf("【%s】%s", HeroProfessionNames[var_12_4.profession], var_12_4.name)

	if IPlatform:instance():getConfig("Channel") == "ZSY_VN" then
		var_12_5 = string.lf("【%s】\n%s", HeroProfessionNames[var_12_4.profession], var_12_4.name)
	end

	local var_12_6 = ui.newTTFLabelWithOutline({
		text = var_12_5,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(25),
		align = ui.TEXT_ALIGN_CENTER,
		color = getQualityColor(var_12_4.quality)
	})

	var_12_6:setAnchorPoint(CCPoint(0.5, 0))
	var_12_6:setPosition(arg_12_2.width / 2 - 10, arg_12_2.height - 325)
	arg_12_1:addChild(var_12_6)

	local var_12_7 = {
		{
			text = string.lf("进阶阶段 #EBDD9E%s", RebirthNames[arg_12_4.rebirthCount + 1] == nil and string.lf("已满级") or RebirthNames[arg_12_4.rebirthCount + 1])
		},
		{
			text = string.lf("主将等级 #EBDD9E%d级", arg_12_4.level)
		},
		{
			text = string.lf("怒击法术 #EBDD9E%d级", arg_12_4.rageSkillLevel)
		}
	}

	for iter_12_0 = 1, #var_12_7 do
		addLabelWithColorSize(arg_12_1, var_12_7[iter_12_0].text, ccc3(192, 120, 74), 20, CCPoint(0, 0.5), CCPoint(45, arg_12_2.height - 330 - iter_12_0 * 30))
	end

	local var_12_8 = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		text = string.lf("选择"),
		textColor = ColorTable.eTitleButton_Normal2,
		fontSize = ColorTable.eTitleButton_FontSize2,
		position = ccp(arg_12_2.width / 2 - 5, 35),
		clickAction = function(arg_14_0, arg_14_1)
			arg_12_0.changeHeroRequest:request(arg_12_0.heroIndex, var_12_2.figId)
		end
	})

	if arg_12_0.guideChangeHero and arg_12_3 == 1 then
		GuideLayer:showNewbieGuideLayer(arg_12_0, arg_12_0.bgSprite, 28, function()
			arg_12_0.changeHeroRequest:request(arg_12_0.heroIndex, var_12_2.figId)

			return true
		end, nil, true, true)
	end

	arg_12_1:addChild(var_12_8)
end

function var_0_1.filterHeros(arg_16_0)
	arg_16_0.itemTable = {}

	local function var_16_0(arg_17_0)
		local var_17_0 = {
			[QualityType.eOrange] = 1,
			[QualityType.ePurple] = 2,
			[QualityType.eBlue] = 3,
			[QualityType.eGreen] = 4
		}

		return arg_16_0.qualitys[var_17_0[arg_17_0]]
	end

	local function var_16_1(arg_18_0)
		local var_18_0 = {
			[HeroProfession.eCommander] = 1,
			[HeroProfession.eWarrior] = 2,
			[HeroProfession.eMage] = 3
		}

		return arg_16_0.professions[var_18_0[arg_18_0]]
	end

	local var_16_2 = Player:getNotInTeamOwnedHeros()

	for iter_16_0, iter_16_1 in pairs(var_16_2) do
		local var_16_3 = BaseHeros[iter_16_1.heroId]

		if var_16_0(var_16_3.quality) == true and var_16_1(var_16_3.profession) == true then
			table.insert(arg_16_0.itemTable, iter_16_1)
		end
	end

	table.sort(arg_16_0.itemTable, function(arg_19_0, arg_19_1)
		return BaseHeros[arg_19_0.heroId].quality > BaseHeros[arg_19_1.heroId].quality
	end)

	if arg_16_0.countLabel then
		arg_16_0.countLabel:setString(string.lf("主将数量: %d", table.nums(arg_16_0.itemTable)))
	end

	local var_16_4 = table.nums(arg_16_0.itemTable)

	if var_16_4 < 4 then
		for iter_16_2 = 1, 4 - var_16_4 do
			table.insert(arg_16_0.itemTable, {
				tableIsEmpty = true
			})
		end
	end

	if arg_16_0.tableview then
		arg_16_0.tableview:reloadData(arg_16_0.itemTable)
	end
end

return var_0_1
