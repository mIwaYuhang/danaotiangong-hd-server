require("base.figure")
require("scenes.team.TeamScene")
require("scenes.team.ChangeFigureScene")

local var_0_0 = class("TianmingScene", function()
	return display.newScene("TianmingScene")
end)

TianmingSlotStatus = {
	eSlotCantuse = 1,
	eSlotAvilable = 2,
	eSlotLocked = 0
}

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.team = arg_2_1.team or Player.team
	arg_2_0.dataType = arg_2_1.dataType or TeamDataType.eTeamPlayer

	if not arg_2_1.index or arg_2_1.index == 7 then
		arg_2_0.curIndex = 1
	else
		arg_2_0.curIndex = arg_2_1.index
	end

	local var_2_0 = "uilocal/team/team_text_025.png"
	local var_2_1 = require("scenes.CommonBgLayer").new({
		titleSprite = var_2_0,
		returnAction = function()
			if arg_2_1.returnAction then
				arg_2_1.returnAction()
			else
				game.enterTianmingRecruitScene()
			end
		end
	})

	arg_2_0:addChild(var_2_1)

	arg_2_0.bg_far_Sprite = var_2_1:getBackgroundSprite()
	arg_2_0.heroBgSprite = display.newSprite("ui/team/team_003.jpg", 308, 294)

	arg_2_0.bg_far_Sprite:addChild(arg_2_0.heroBgSprite)

	arg_2_0.bgFileTable = {
		[QualityType.eGreen] = "ui/team/team_036.jpg",
		[QualityType.eBlue] = "ui/team/team_037.jpg",
		[QualityType.ePurple] = "ui/team/team_038.jpg",
		[QualityType.eOrange] = "ui/team/team_039.jpg"
	}
	arg_2_0.heroQualityBgSprite = display.newSprite(arg_2_0.bgFileTable[QualityType.eGreen], 308, 373)

	arg_2_0.bg_far_Sprite:addChild(arg_2_0.heroQualityBgSprite)
	arg_2_0:createTableView()

	local var_2_2 = display.newSprite("ui/common/common_043.png", 58, 505)

	arg_2_0.bg_far_Sprite:addChild(var_2_2)

	local var_2_3 = display.newSprite("ui/common/common_044.png", 58, 28)

	arg_2_0.bg_far_Sprite:addChild(var_2_3)

	local var_2_4 = createPlayerAttrNode({
		ItemType.eTianMingExp,
		ItemType.eGold,
		ItemType.eCoin
	})

	var_2_4:setPosition(ccp(260, 578))
	arg_2_0.bg_far_Sprite:addChild(var_2_4)
	arg_2_0:showHeroSliderLayer()

	arg_2_0.heroTianmingLayer = require("scenes.tianming.HeroTianmingLayer").new({
		index = arg_2_0.curIndex,
		scene = arg_2_0,
		dataType = arg_2_0.dataType,
		team = arg_2_0.team,
		isShowRebirth = arg_2_0.isShowRebirth
	})

	arg_2_0.heroTianmingLayer:setContentSize(CCSize(CONFIG_SCREEN_WIDTH, CONFIG_SCREEN_HEIGHT))
	arg_2_0.bg_far_Sprite:addChild(arg_2_0.heroTianmingLayer)
	GuideLayer:showGuideLayer(arg_2_0, arg_2_0.bg_far_Sprite, TaskEntryType.eTianMing, 7, nil, true)
end

function var_0_0.showHeroSliderLayer(arg_4_0, arg_4_1)
	if arg_4_0.heroLayer ~= nil then
		return
	end

	local function var_4_0(arg_5_0)
		local var_5_0 = arg_4_0.team.groupList[arg_5_0]

		if var_5_0 and var_5_0.heroId > 0 then
			local var_5_1 = BaseHeros[var_5_0.heroId].quality

			arg_4_0.heroQualityBgSprite:setVisible(true)
			arg_4_0.heroQualityBgSprite:setTexture(CCTextureCache:sharedTextureCache():addImage(arg_4_0.bgFileTable[var_5_1]))
		else
			arg_4_0.heroQualityBgSprite:setVisible(false)
		end

		if arg_4_0.heroTianmingLayer then
			arg_4_0.heroTianmingLayer:sliderLayerChanged(arg_5_0)
		end

		if arg_4_0:getTableViewScrollIndex() ~= arg_5_0 then
			arg_4_0:tableViewScrollToIndex(arg_5_0)
		end
	end

	arg_4_0.heroLayer = arg_4_0:createHeroSliderLayerInTeam(var_4_0)

	arg_4_0.heroLayer:reloadData(arg_4_1 or arg_4_0.curIndex)
	arg_4_0.bg_far_Sprite:addChild(arg_4_0.heroLayer)
end

function var_0_0.createTianmingChangeButtons(arg_6_0)
	local function var_6_0(arg_7_0, arg_7_1)
		GuideLayer:stepDone(TaskEntryType.eTianMingGu, 3)

		local var_7_0 = require("scenes.tianming.TianmingGuLayer").new()

		arg_6_0:addChild(var_7_0)
	end

	local var_6_1 = ui.newControlButton({
		normalImage = "ui/common/common_018.png",
		text = string.lf("天命蛊"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		position = ccp(61, 543),
		clickAction = var_6_0
	})

	var_6_1:setTouchPriority(-1)
	arg_6_0.bg_far_Sprite:addChild(var_6_1)
end

function var_0_0.getTableViewScrollIndex(arg_8_0)
	return arg_8_0.curIndex
end

function var_0_0.createTableView(arg_9_0)
	local var_9_0 = display.newSprite("ui/team/team_004.png", 60, 300)

	arg_9_0.bg_far_Sprite:addChild(var_9_0)

	local function var_9_1(arg_10_0, arg_10_1)
		return 108, 100
	end

	local function var_9_2(arg_11_0)
		return 6
	end

	local function var_9_3(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_0:cellAtIndex(arg_12_1)

		if var_12_0 == nil then
			var_12_0 = CCTableViewCell:new()

			local var_12_1 = ({
				0,
				0,
				0,
				GameFeaturesLevel[GameFeatures.eTeamHero4].level,
				GameFeaturesLevel[GameFeatures.eTeamHero5].level,
				GameFeaturesLevel[GameFeatures.eTeamHero6].level,
				0
			})[arg_12_1 + 1]
			local var_12_2 = {}

			var_12_2.clickAction, var_12_2.type = function(arg_13_0, arg_13_1)
				if arg_9_0.team.groupList[arg_12_1 + 1] then
					if arg_9_0.team.groupList[arg_12_1 + 1].heroId == 0 then
						game.enterChangeFigureScene({
							returnTianmingScene = true,
							heroIndex = arg_12_1 + 1,
							heroInfo = arg_9_0.team.groupList[arg_12_1 + 1],
							prevIndex = arg_9_0.curIndex
						})
					elseif arg_9_0.curIndex ~= arg_12_1 + 1 then
						arg_9_0.curIndex = arg_12_1 + 1

						arg_9_0:tableViewIndexAlignMiddle(arg_9_0.curIndex)

						local var_13_0 = arg_9_0.tableview:getContentOffset()

						arg_9_0.heroLayer:reloadData(arg_9_0.curIndex)
						arg_9_0.tableview:reloadData()
						arg_9_0.tableview:setContentOffset(var_13_0)
					end
				else
					showFlashNotice(string.lf("需要%d级开放！", var_12_1))
				end
			end, ItemType.eHero

			if arg_9_0.team.groupList[arg_12_1 + 1] then
				var_12_2.itemId = arg_9_0.team.groupList[arg_12_1 + 1].heroId

				if var_12_2.itemId > 0 then
					var_12_2.isName = true
				end
			else
				var_12_2.itemId = -1
			end

			if arg_12_1 + 1 == 7 then
				var_12_2.itemId = 0
				var_12_2.isXiaoHuoBan = true
			end

			local var_12_3 = ccp(49, 62)
			local var_12_4 = figure.createHeader(var_12_2)

			var_12_4:setPosition(var_12_3)
			var_12_0:addChild(var_12_4)

			if arg_12_1 + 1 == 7 then
				local var_12_5 = CCSprite:create("uilocal/team/team_109.png")

				var_12_5:setPosition(ccp(43, 43))
				var_12_4.headerButton:addChild(var_12_5)
			end

			if var_12_0.maskSprite == nil and arg_9_0.curIndex == arg_12_1 + 1 then
				var_12_0.maskSprite = CCSprite:create("ui/common/bg_choosed_cube.png")

				var_12_0.maskSprite:setPosition(var_12_3)
				var_12_0:addChild(var_12_0.maskSprite)
			end

			if var_12_2.itemId < 0 and arg_12_1 + 1 ~= 7 then
				local var_12_6 = ui.newTTFLabel({
					y = 10,
					x = 49,
					text = string.lf("%d级开放", var_12_1),
					font = _FONT_DEFAULT,
					color = ccc3(188, 150, 78),
					size = Adapter.FontSize(20),
					align = ui.TEXT_ALIGN_CENTER
				})

				var_12_0:addChild(var_12_6)
			end
		end

		return var_12_0
	end

	local var_9_4, var_9_5 = var_9_1(nil)

	arg_9_0.tableview = CCTableView:create(CCSize(100, 445))

	arg_9_0.tableview:setContentSize(CCSize(100, var_9_2(0) * var_9_5))
	arg_9_0.tableview:setPosition(10, 45)
	arg_9_0.tableview:setVerticalFillOrder(kCCTableViewFillTopDown)
	arg_9_0.tableview:setDirection(kCCScrollViewDirectionVertical)
	arg_9_0.bg_far_Sprite:addChild(arg_9_0.tableview)

	arg_9_0.tableview.sizeHandler = var_9_1
	arg_9_0.tableview.numHandler = var_9_2

	arg_9_0.tableview:registerScriptHandler(var_9_1, CCTableView.kTableCellSizeForIndex)
	arg_9_0.tableview:registerScriptHandler(var_9_2, CCTableView.kNumberOfCellsInTableView)
	arg_9_0.tableview:registerScriptHandler(var_9_3, CCTableView.kTableCellSizeAtIndex)
	arg_9_0:tableViewScrollToIndex(arg_9_0.curIndex)
end

function var_0_0.tableViewScrollToIndex(arg_14_0, arg_14_1)
	arg_14_0.curIndex = arg_14_1

	arg_14_0.tableview:reloadData()

	local var_14_0, var_14_1 = arg_14_0.tableview.sizeHandler(arg_14_0.tableview)
	local var_14_2 = arg_14_0.tableview:getViewSize()
	local var_14_3 = arg_14_0.tableview.numHandler(arg_14_0.tableview)
	local var_14_4 = var_14_2.height - var_14_3 * var_14_0
	local var_14_5 = var_14_0 * (arg_14_1 - var_14_3)

	var_14_5 = var_14_5 < var_14_4 and var_14_4 or var_14_5

	arg_14_0.tableview:setContentOffset(ccp(0, var_14_5))
end

function var_0_0.tableViewIndexAlignMiddle(arg_15_0, arg_15_1)
	local var_15_0, var_15_1 = arg_15_0.tableview.sizeHandler(arg_15_0.tableview)
	local var_15_2 = arg_15_0.tableview:getContentSize()

	if arg_15_1 == 4 then
		arg_15_0.tableview:setContentOffsetInDuration(ccp(0, -var_15_0 * 1), 0.3)
	elseif arg_15_1 > 4 then
		arg_15_0.tableview:setContentOffsetInDuration(arg_15_0.tableview:maxContainerOffset(), 0.3)
	elseif arg_15_1 <= 3 then
		arg_15_0.tableview:setContentOffsetInDuration(arg_15_0.tableview:minContainerOffset(), 0.3)
	end
end

function var_0_0.createHeroSliderLayerInTeam(arg_16_0, arg_16_1)
	local function var_16_0(arg_17_0, arg_17_1)
		local var_17_0 = arg_16_0.team.groupList[arg_17_1]

		if var_17_0.heroId > 0 then
			local var_17_1
			local var_17_2

			for iter_17_0, iter_17_1 in ipairs(var_17_0.equipList) do
				if BaseEquips[iter_17_1.equipId].equipType == EquipType.eWeapon then
					var_17_1 = iter_17_1.equipId
					var_17_2 = iter_17_1.pinJie

					break
				end
			end

			local var_17_3 = {
				isViewBaseInfo = false,
				scale = 0.65,
				figId = var_17_0.heroId,
				rebirthCount = var_17_0.rebirthCount,
				equipId = var_17_1,
				pinjie = var_17_2
			}
			local var_17_4 = figure.createHero(var_17_3)

			var_17_4:setPosition(135, 50)
			arg_17_0:addChild(var_17_4)
		elseif arg_16_0.dataType == TeamDataType.eTeamPlayer then
			local function var_17_5()
				game.enterChangeFigureScene({
					returnTianmingScene = true,
					heroIndex = arg_17_1,
					heroInfo = arg_16_0.team.groupList[arg_17_1]
				})
			end

			local var_17_6 = ui.newControlButton({
				normalImage = "uilocal/team/btn_hero_unexist.png",
				position = ccp(135, 165),
				clickAction = var_17_5
			})

			arg_17_0:addChild(var_17_6)
		end
	end

	return (require("scenes.SliderLayer").new({
		touchCheckDelayTime = 0.001,
		size = CCSizeMake(310, 342),
		clipScaleX = Adapter.MinScale,
		clipScaleY = Adapter.MinScale,
		point = ccp(165, 170),
		numberHandler = function()
			local var_19_0 = 0

			for iter_19_0, iter_19_1 in ipairs(arg_16_0.team.groupList) do
				if iter_19_1.heroId >= 0 then
					var_19_0 = var_19_0 + 1
				end
			end

			return var_19_0
		end,
		changedHandler = arg_16_1,
		cellHandler = var_16_0,
		direction = SliderDirection.eVertical,
		fillDirection = SliderFillDirection.eTopDown,
		touchBeginCallback = function(arg_20_0, arg_20_1, arg_20_2)
			if arg_16_0.heroTianmingLayer == nil then
				return false
			end

			local var_20_0 = arg_16_0.heroTianmingLayer:convertToNodeSpace(ccp(arg_20_1, arg_20_2))
			local var_20_1 = 0
			local var_20_2 = 40

			for iter_20_0 = 1, 6 do
				local var_20_3 = 165 + (iter_20_0 - 1) % 2 * 285
				local var_20_4 = 440 - math.floor((iter_20_0 - 1) / 2) * 103

				if var_20_2 > ccpDistance(ccp(var_20_3, var_20_4), var_20_0) then
					var_20_1 = iter_20_0

					break
				end
			end

			arg_16_0.tmpTianmingIndex = var_20_1

			local var_20_5 = arg_16_0.heroTianmingLayer:getTianmingInfoByIndex(arg_16_0.curIndex, var_20_1)

			if var_20_5 == nil then
				return false
			end

			arg_16_0.heroTianmingLayer.tianmingHeaderTable[var_20_1]:setHeaderOpacity(120)

			arg_16_0.touchHeaderButton = figure.createHeader({
				type = ItemType.eTianMing,
				itemId = var_20_5.destinyID,
				level = var_20_5.level
			})

			arg_16_0.touchHeaderButton:setScale(Adapter.MinScale)
			arg_16_0.touchHeaderButton:setPosition(ccp(arg_20_1, arg_20_2))
			display.getRunningScene():addChild(arg_16_0.touchHeaderButton)

			return true
		end,
		touchMoveCallback = function(arg_21_0, arg_21_1, arg_21_2)
			if arg_16_0.touchHeaderButton then
				arg_16_0.touchHeaderButton:setPosition(ccp(arg_21_1, arg_21_2))
			end
		end,
		touchEndCallback = function(arg_22_0, arg_22_1, arg_22_2)
			if arg_16_0.touchHeaderButton then
				arg_16_0.heroTianmingLayer.tianmingHeaderTable[arg_16_0.tmpTianmingIndex]:setHeaderOpacity(255)
				arg_16_0.touchHeaderButton:removeFromParent()

				arg_16_0.touchHeaderButton = nil
			end

			local var_22_0 = 165 + (arg_16_0.tmpTianmingIndex - 1) % 2 * 285
			local var_22_1 = 440 - math.floor((arg_16_0.tmpTianmingIndex - 1) / 2) * 103
			local var_22_2 = arg_16_0.heroTianmingLayer:convertToNodeSpace(ccp(arg_22_1, arg_22_2))

			if ccpDistance(ccp(var_22_0, var_22_1), var_22_2) > 50 then
				local var_22_3 = arg_16_0.heroTianmingLayer:getTianmingInfoByIndex(arg_16_0.curIndex, arg_16_0.tmpTianmingIndex)

				arg_16_0.heroTianmingLayer.heroUnloadTianmingRequest:request(arg_16_0.curIndex, var_22_3.id)
			end
		end
	}))
end

function var_0_0.reloadCurrentLayer(arg_23_0)
	arg_23_0.heroLayer:reloadData(arg_23_0.heroLayer:getCurrentIndex())
end

return var_0_0
