require("base.figure")
require("scenes.team.ChangeFigureScene")

local var_0_0 = class("TeamScene", function()
	return display.newScene("TeamScene")
end)

TeamDataType = {
	eTeamOthers = 2,
	eTeamPlayer = 1
}

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.team = arg_2_1.team or Player.team
	arg_2_0.partnerTeam = arg_2_1.partnerTeam or Player.partnerTeam
	arg_2_0.dataType = arg_2_1.dataType or TeamDataType.eTeamPlayer
	arg_2_0.isShowRebirth = arg_2_1.isShowRebirth or false
	arg_2_0.changeHeroIndex = arg_2_1.changeHeroIndex
	arg_2_0.guideChangeHero = arg_2_1.guideChangeHero

	if not arg_2_1.index or arg_2_1.index == 7 then
		arg_2_0.curIndex = 1
	else
		arg_2_0.curIndex = arg_2_1.index
	end

	if arg_2_0.changeHeroIndex then
		arg_2_0.curIndex = arg_2_0.changeHeroIndex
	end

	local var_2_0 = "uilocal/team/team_text_025.png"

	if arg_2_0.dataType ~= TeamDataType.eTeamPlayer then
		var_2_0 = "uilocal/team/team_text_025.png"
	end

	local var_2_1 = require("scenes.CommonBgLayer").new({
		titleSprite = var_2_0,
		returnAction = function()
			if arg_2_0.dataType ~= TeamDataType.eTeamPlayer and arg_2_1.returnAction then
				arg_2_1.returnAction()
			else
				local var_3_0 = {}

				if arg_2_0.guideChangeHero then
					var_3_0 = {
						showGuideArrow = true
					}
				end

				game.enterHomeScene(var_3_0)
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

	if arg_2_0.dataType == TeamDataType.eTeamPlayer then
		if Player.level >= GameFeaturesLevel[GameFeatures.eEquipInherit].level then
			local var_2_4 = createPlayerAttrNode({
				ItemType.eEquipInheritPoint,
				ItemType.eGold,
				ItemType.eCoin
			})

			var_2_4:setPosition(ccp(260, 578))
			arg_2_0.bg_far_Sprite:addChild(var_2_4)
		else
			local var_2_5 = createPlayerAttrNode({
				ItemType.eGold,
				ItemType.eCoin
			})

			var_2_5:setPosition(ccp(430, 578))
			arg_2_0.bg_far_Sprite:addChild(var_2_5)
		end
	elseif arg_2_0.dataType == TeamDataType.eTeamOthers and arg_2_1.playerName then
		addLabelWithColorSize(arg_2_0.bg_far_Sprite, arg_2_1.playerName, ccc3(238, 224, 191), 26, ccp(0.5, 0.5), ccp(480, 603))
	end

	arg_2_0:showHeroSliderLayer()
	arg_2_0:createTeamChangeButtons(arg_2_1.pageType)
end

function var_0_0.showHeroSliderLayer(arg_4_0, arg_4_1)
	if arg_4_0.heroLayer ~= nil then
		return
	end

	local function var_4_0(arg_5_0, arg_5_1)
		GuideLayer:removeGuideLayer(arg_4_0, TaskEntryType.eHeroPractice, 2)
		GuideLayer:stepDone(TaskEntryType.eHeroPractice, 2)

		if arg_4_0.heroEquipLayer then
			arg_4_0.heroEquipLayer:heroClicked(arg_5_0, arg_5_1)
			GuideLayer:showGuideLayer(arg_4_0, arg_4_0.bg_far_Sprite, TaskEntryType.eHeroPractice, 3, nil, true)
		end
	end

	local function var_4_1(arg_6_0)
		local var_6_0 = arg_4_0.team.groupList[arg_6_0]

		if var_6_0 and var_6_0.heroId > 0 then
			local var_6_1 = BaseHeros[var_6_0.heroId].quality

			arg_4_0.heroQualityBgSprite:setVisible(true)
			arg_4_0.heroQualityBgSprite:setTexture(CCTextureCache:sharedTextureCache():addImage(arg_4_0.bgFileTable[var_6_1]))
		else
			arg_4_0.heroQualityBgSprite:setVisible(false)
		end

		if arg_4_0.heroEquipLayer then
			arg_4_0.heroEquipLayer:sliderLayerChanged(arg_6_0)
		end
	end

	arg_4_0.heroLayer = arg_4_0:createHeroSliderLayerInTeam(var_4_0, var_4_1)

	arg_4_0.heroLayer:reloadData(arg_4_1 or arg_4_0.curIndex)
	arg_4_0.bg_far_Sprite:addChild(arg_4_0.heroLayer)
end

function var_0_0.onEnter(arg_7_0)
	arg_7_0:showGuideLayer()

	if arg_7_0.dataType == TeamDataType.eTeamPlayer then
		GuideLayer:showMissionReward(arg_7_0, TaskType.eTaskTeaching, TaskEntryType.eEntryBattleHero, 1)
	end
end

function var_0_0.showXiaoHuoBanSystem(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == true then
		arg_8_0.heroBgSprite:setVisible(false)
		arg_8_0.heroQualityBgSprite:setVisible(false)

		if arg_8_0.heroLayer ~= nil then
			arg_8_0.heroLayer:removeFromParentAndCleanup(true)

			arg_8_0.heroLayer = nil
		end

		if arg_8_0.heroEquipLayer ~= nil then
			arg_8_0.heroEquipLayer:removeFromParentAndCleanup(true)

			arg_8_0.heroEquipLayer = nil
		end

		if arg_8_0.xiaohuobanLayer == nil then
			arg_8_0.xiaohuobanLayer = require("scenes.team.HeroXiaohuobanLayer").new({
				scene = arg_8_0,
				team = arg_8_0.team,
				partnerTeam = arg_8_0.partnerTeam,
				dataType = arg_8_0.dataType
			})

			arg_8_0.bg_far_Sprite:addChild(arg_8_0.xiaohuobanLayer)
		end
	else
		arg_8_0.heroBgSprite:setVisible(true)

		if arg_8_0.xiaohuobanLayer ~= nil then
			arg_8_0.xiaohuobanLayer:removeFromParentAndCleanup(true)

			arg_8_0.xiaohuobanLayer = nil
		end

		arg_8_0:showHeroSliderLayer(arg_8_2)
		arg_8_0:showHeroEquipLayer(arg_8_2)
	end
end

function var_0_0.createTableView(arg_9_0)
	local var_9_0 = display.newSprite("ui/team/team_004.png", 60, 300)

	arg_9_0.bg_far_Sprite:addChild(var_9_0)

	local function var_9_1(arg_10_0, arg_10_1)
		return 108, 100
	end

	local function var_9_2(arg_11_0)
		if Player:isOpenXiaohuobanSystem() == true and arg_9_0.dataType == TeamDataType.eTeamPlayer then
			return 7
		else
			return 6
		end
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
				if arg_12_1 + 1 == 7 then
					GuideLayer:stepDone(TaskEntryType.eGuideXiaohuoban, 2)
					GuideLayer:removeGuideLayer(arg_9_0, TaskEntryType.eGuideXiaohuoban, 3)
					arg_9_0:showXiaoHuoBanSystem(true)

					arg_9_0.curIndex = arg_12_1 + 1

					local var_13_0 = arg_9_0.tableview:getContentOffset()

					arg_9_0.tableview:reloadData()
					arg_9_0.tableview:setContentOffset(var_13_0)

					return
				end

				if arg_9_0.team.groupList[arg_12_1 + 1] then
					arg_9_0:showXiaoHuoBanSystem(false, arg_12_1 + 1)

					if arg_9_0.team.groupList[arg_12_1 + 1].heroId == 0 then
						GuideLayer:stepDone(TaskEntryType.eEntryBattleHero, 2)

						if arg_9_0.dataType == TeamDataType.eTeamPlayer then
							game.enterChangeFigureScene({
								heroIndex = arg_12_1 + 1,
								heroInfo = arg_9_0.team.groupList[arg_12_1 + 1],
								prevIndex = arg_9_0.curIndex
							})
						end
					elseif arg_9_0.curIndex ~= arg_12_1 + 1 then
						arg_9_0.curIndex = arg_12_1 + 1

						arg_9_0:tableViewIndexAlignMiddle(arg_9_0.curIndex)

						local var_13_1 = arg_9_0.tableview:getContentOffset()

						arg_9_0.heroLayer:reloadData(arg_9_0.curIndex)
						arg_9_0.tableview:reloadData()
						arg_9_0.tableview:setContentOffset(var_13_1)
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
				local var_12_5 = CCSprite:create("ui/team/team_109.png")

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

function var_0_0.getTableViewScrollIndex(arg_16_0)
	return arg_16_0.curIndex
end

function var_0_0.createTeamChangeButtons(arg_17_0, arg_17_1)
	if arg_17_0.dataType == TeamDataType.eTeamPlayer then
		local function var_17_0(arg_18_0, arg_18_1)
			game.enterFormationScene()
		end

		local var_17_1 = ui.newControlButton({
			normalImage = "ui/common/common_018.png",
			text = string.lf("去布阵"),
			fontSize = ColorTable.eTitleButton_FontSize,
			textColor = ColorTable.eTitleButton_Normal,
			position = ccp(61, 543),
			clickAction = var_17_0
		})

		var_17_1:setTouchPriority(-1)
		arg_17_0.bg_far_Sprite:addChild(var_17_1)
	end

	local function var_17_2(arg_19_0)
		if arg_19_0 then
			return CCScale9Sprite:create("ui/common/common_021.png")
		else
			return CCScale9Sprite:create("ui/common/common_021_2.png")
		end
	end

	;(function(arg_20_0, arg_20_1)
		arg_17_0:showHeroEquipLayer()
		GuideLayer:removeGuideLayer(arg_17_0, TaskEntryType.eEntryBattleVicehero, 3)
		GuideLayer:rollbackStepTo(TaskEntryType.eEntryHeroTrain, 2)
		GuideLayer:showGuideLayer(arg_17_0, arg_17_0.bg_far_Sprite, TaskEntryType.eEntryHeroTrain, 2, nil, true)
	end)("", nil)
end

function var_0_0.showHeroEquipLayer(arg_21_0, arg_21_1)
	if arg_21_0.heroEquipLayer == nil then
		arg_21_0.heroEquipLayer = require("scenes.team.HeroEquipLayer").new({
			index = arg_21_1 or arg_21_0.curIndex,
			scene = arg_21_0,
			dataType = arg_21_0.dataType,
			team = arg_21_0.team,
			partnerTeam = arg_21_0.partnerTeam,
			isShowRebirth = arg_21_0.isShowRebirth
		})

		arg_21_0.heroEquipLayer:setContentSize(CCSize(CONFIG_SCREEN_WIDTH, CONFIG_SCREEN_HEIGHT))
		arg_21_0.bg_far_Sprite:addChild(arg_21_0.heroEquipLayer)
	end
end

function var_0_0.createHeroSliderLayerInTeam(arg_22_0, arg_22_1, arg_22_2)
	local function var_22_0(arg_23_0, arg_23_1)
		local var_23_0 = arg_22_0.team.groupList[arg_23_1]

		if var_23_0.heroId > 0 then
			local var_23_1
			local var_23_2

			for iter_23_0, iter_23_1 in ipairs(var_23_0.equipList) do
				if BaseEquips[iter_23_1.equipId].equipType == EquipType.eWeapon then
					var_23_1 = iter_23_1.equipId
					var_23_2 = iter_23_1.pinJie

					break
				end
			end

			local var_23_3 = {
				qualityOffsetY = 455,
				isViewBaseInfo = false,
				scale = 0.65,
				figId = var_23_0.heroId,
				clickAction = arg_22_1,
				rebirthCount = var_23_0.rebirthCount,
				equipId = var_23_1,
				pinjie = var_23_2
			}
			local var_23_4 = figure.createHero(var_23_3)

			var_23_4:setPosition(135, 20)
			arg_23_0:addChild(var_23_4)
		elseif arg_22_0.dataType == TeamDataType.eTeamPlayer then
			local function var_23_5()
				game.enterChangeFigureScene({
					heroIndex = arg_23_1,
					heroInfo = arg_22_0.team.groupList[arg_23_1]
				})
			end

			local var_23_6 = ui.newControlButton({
				normalImage = "uilocal/team/btn_hero_unexist.png",
				position = ccp(135, 165),
				clickAction = var_23_5
			})

			arg_23_0:addChild(var_23_6)
		end
	end

	return (require("scenes.SliderLayer").new({
		touchCheckDelayTime = 0.001,
		size = CCSizeMake(310, 342),
		clipScaleX = Adapter.MinScale,
		clipScaleY = Adapter.MinScale,
		point = ccp(165, 170),
		numberHandler = function()
			local var_25_0 = 0

			for iter_25_0, iter_25_1 in ipairs(arg_22_0.team.groupList) do
				if iter_25_1.heroId >= 0 then
					var_25_0 = var_25_0 + 1
				end
			end

			return var_25_0
		end,
		changedHandler = arg_22_2,
		cellHandler = var_22_0,
		direction = SliderDirection.eVertical,
		fillDirection = SliderFillDirection.eTopDown,
		touchBeginCallback = function(arg_26_0, arg_26_1, arg_26_2)
			if arg_22_0.heroEquipLayer == nil then
				return false
			end

			local var_26_0 = arg_22_0.heroEquipLayer:convertToNodeSpace(ccp(arg_26_1, arg_26_2))
			local var_26_1 = 0
			local var_26_2 = 40

			for iter_26_0 = 1, 6 do
				local var_26_3 = 165 + (iter_26_0 - 1) % 2 * 285
				local var_26_4 = 440 - math.floor((iter_26_0 - 1) / 2) * 103

				if var_26_2 > ccpDistance(ccp(var_26_3, var_26_4), var_26_0) then
					var_26_1 = iter_26_0

					break
				end
			end

			arg_22_0.tmpEquipIndex = var_26_1

			local var_26_5 = arg_22_0.heroEquipLayer:getEquipInfoByIndex(arg_22_0.curIndex, var_26_1)

			if var_26_5 == nil then
				return false
			end

			local var_26_6 = var_26_5.equipId

			arg_22_0.heroEquipLayer.equipHeaderTable[var_26_1]:setHeaderOpacity(120)

			arg_22_0.touchHeaderButton = figure.createHeader({
				type = ItemType.eEquip,
				itemId = var_26_6,
				level = var_26_5.level,
				equipType = var_26_5.equipType,
				equipGem = var_26_5.gem
			})

			arg_22_0.touchHeaderButton:setScale(Adapter.MinScale)
			arg_22_0.touchHeaderButton:setPosition(ccp(arg_26_1, arg_26_2))
			display.getRunningScene():addChild(arg_22_0.touchHeaderButton)

			return true
		end,
		touchMoveCallback = function(arg_27_0, arg_27_1, arg_27_2)
			if arg_22_0.touchHeaderButton then
				arg_22_0.touchHeaderButton:setPosition(ccp(arg_27_1, arg_27_2))
			end
		end,
		touchEndCallback = function(arg_28_0, arg_28_1, arg_28_2)
			if arg_22_0.touchHeaderButton then
				arg_22_0.heroEquipLayer.equipHeaderTable[arg_22_0.tmpEquipIndex]:setHeaderOpacity(255)
				arg_22_0.touchHeaderButton:removeFromParent()

				arg_22_0.touchHeaderButton = nil
			end

			local var_28_0 = 165 + (arg_22_0.tmpEquipIndex - 1) % 2 * 285
			local var_28_1 = 440 - math.floor((arg_22_0.tmpEquipIndex - 1) / 2) * 103
			local var_28_2 = arg_22_0.heroEquipLayer:convertToNodeSpace(ccp(arg_28_1, arg_28_2))

			if ccpDistance(ccp(var_28_0, var_28_1), var_28_2) > 50 then
				local var_28_3 = arg_22_0.heroEquipLayer:getEquipInfoByIndex(arg_22_0.curIndex, arg_22_0.tmpEquipIndex)
				local var_28_4 = BaseEquips[var_28_3.equipId].equipType

				arg_22_0.heroEquipLayer.heroUnloadEquipRequest:request(arg_22_0.team.groupList[arg_22_0.curIndex].heroId, var_28_4, var_28_3.equipUserId)
			end
		end
	}))
end

function var_0_0.reloadCurrentLayer(arg_29_0)
	arg_29_0.heroLayer:reloadData(arg_29_0.heroLayer:getCurrentIndex())
end

function var_0_0.showGuideLayer(arg_30_0)
	if arg_30_0.dataType ~= TeamDataType.eTeamPlayer then
		return
	end

	GuideLayer:showGuideLayer(arg_30_0, arg_30_0.bg_far_Sprite, TaskEntryType.eEntryBattleVicehero, 2, nil, true)
	GuideLayer:showGuideLayer(arg_30_0, arg_30_0.bg_far_Sprite, TaskEntryType.eEntryHeroSkill, 2, nil, true)
	GuideLayer:showGuideLayer(arg_30_0, arg_30_0.bg_far_Sprite, TaskEntryType.eEntryHeroBreakthrough, 2, nil, true)
	GuideLayer:showGuideLayer(arg_30_0, arg_30_0.bg_far_Sprite, TaskEntryType.eEntryBattleHero, 2, nil, true)
	GuideLayer:showGuideLayer(arg_30_0, arg_30_0.bg_far_Sprite, TaskEntryType.eGuideXiaohuoban, 2, nil, true)
	GuideLayer:showGuideLayer(arg_30_0, arg_30_0.bg_far_Sprite, TaskEntryType.eHeroPractice, 2, nil, true)

	if Player.currentTaskEntryType == TaskEntryType.eGuideXiaohuoban and Player.currentTaskStep == 2 then
		arg_30_0.tableview:setContentOffsetInDuration(arg_30_0.tableview:maxContainerOffset(), 0.1)
	end

	if Player.currentTaskEntryType == TaskEntryType.eEntryBattleHero and Player.currentTaskStep == 2 then
		local var_30_0, var_30_1 = arg_30_0.tableview.sizeHandler(arg_30_0.tableview)
		local var_30_2 = Player:isOpenXiaohuobanSystem() == true and var_30_0 or 0

		if Player.taskBattleHeroID == 4 then
			-- block empty
		elseif Player.taskBattleHeroID == 5 then
			arg_30_0.tableview:setContentOffset(ccp(0, -var_30_0 - var_30_2))
		elseif Player.taskBattleHeroID == 6 then
			arg_30_0.tableview:setContentOffset(ccp(0, 0 - var_30_2))
		end
	end

	local var_30_3 = Player:getTroMaxStep()

	if arg_30_0.changeHeroIndex then
		GuideLayer:showNewbieGuideLayer(arg_30_0, arg_30_0.bg_far_Sprite, 26, function()
			local var_31_0 = arg_30_0.team.groupList[arg_30_0.curIndex]

			game.enterChangeFigureScene({
				guideChangeHero = true,
				heroIndex = arg_30_0.curIndex,
				heroInfo = var_31_0
			})

			return true
		end)
	end

	if var_30_3 == NSStep.ZhanYi4Reward then
		GuideLayer:showNewbieGuideLayer(arg_30_0, arg_30_0.bg_far_Sprite, 20, function()
			arg_30_0.heroEquipLayer:showTypeLayer(2, {})

			return true
		end)
	end

	if var_30_3 == NSStep.HuanZhuangbei then
		local var_30_4 = arg_30_0.heroEquipLayer:getEquipInfoByIndex(arg_30_0.heroEquipLayer.curIndex, EquipType.eWeapon)

		arg_30_0.heroEquipLayer:showTypeLayer(3, {
			equipItem = var_30_4
		})
		arg_30_0.heroEquipLayer:setEquipButtonsChoose(EquipType.eWeapon)

		return true
	end

	if var_30_3 == NSStep.DuanZao1 then
		local var_30_5 = arg_30_0.heroEquipLayer:getEquipInfoByIndex(arg_30_0.heroEquipLayer.curIndex, EquipType.eWeapon)

		arg_30_0.heroEquipLayer:showTypeLayer(3, {
			equipItem = var_30_5
		})
		arg_30_0.heroEquipLayer:setEquipButtonsChoose(EquipType.eWeapon)

		return true
	end

	if var_30_3 == 25 then
		local var_30_6 = arg_30_0.heroEquipLayer:getEquipInfoByIndex(arg_30_0.heroEquipLayer.curIndex, EquipType.eWeapon)

		arg_30_0.heroEquipLayer:showTypeLayer(3, {
			equipItem = var_30_6
		})
		arg_30_0.heroEquipLayer:setEquipButtonsChoose(EquipType.eWeapon)

		return true
	end

	if var_30_3 == NSStep.ZhanYi6Reward then
		arg_30_0.heroEquipLayer.heroEnhanceLayer.heroRebirthLayer:showNewbieGuideLayer(arg_30_0)
	end

	if arg_30_0.guideChangeHero == true then
		GuideLayer:showNewbieGuideLayer(arg_30_0, arg_30_0.bg_far_Sprite, 30, function()
			arg_30_0.heroEquipLayer:heroClicked()
			GuideLayer:showNewbieGuideLayer(arg_30_0, arg_30_0.bg_far_Sprite, 300, function()
				Player:setCurrentTaskEntryType(TaskEntryType.eHeroTransfer)
				Player:setCurrentTaskStep(1)
				game.enterTransferEffectScene({
					changeType = TransferEffectType.eTeamInherit,
					heroIndex = arg_30_0.curIndex
				})
			end)
		end)
	end
end

return var_0_0
