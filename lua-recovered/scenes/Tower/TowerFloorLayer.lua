require("network.TowerRequest")
require("scenes.battle.BattleOperator")
require("base.figure")

local var_0_0 = 80

ButtonTagType = {
	ePowerBattle = 1,
	eRankTag = 4,
	eBuffTag = 5,
	eCleanoutTag = 6,
	eBloodBattle = 3,
	eDeadBattle = 2
}

local var_0_1 = require("scenes.ToolLayer")
local var_0_2 = require("base.cache")
local var_0_3 = class("TowerFloorLayer", function()
	return display.newLayer()
end)
local var_0_4 = 130 * Adapter.WidthScale
local var_0_5 = 160 * Adapter.HeightScale

local function var_0_6(arg_2_0)
	local var_2_0 = ""
	local var_2_1, var_2_2, var_2_3, var_2_4 = getDateFromSeconds(arg_2_0)

	return (string.format("%02d:%02d:%02d", var_2_2, var_2_3, var_2_4))
end

function var_0_3.ctor(arg_3_0, arg_3_1)
	arg_3_0.towerScene = arg_3_1.towerScene
	arg_3_0._towerInfo = arg_3_1.towerInfo
	arg_3_0._donotRequest = arg_3_1.donotRequest
	arg_3_0._newTowerInfo = arg_3_1.newTowerInfo
	arg_3_0.currentFloor = arg_3_0._newTowerInfo and arg_3_0._newTowerInfo.Floor or arg_3_0._towerInfo.Floor

	arg_3_0:createNetworkInterface()

	local var_3_0 = display.newSprite("ui/tower/tower_044.jpg")

	var_3_0:align(display.BOTTOM_CENTER, display.cx, 0)
	var_3_0:setScaleX(Adapter.AutoScaleX)
	var_3_0:setScaleY(Adapter.AutoScaleY)
	arg_3_0:addChild(var_3_0)
	arg_3_0:showLeftTowers()

	local var_3_1 = require("scenes.CommonBgLayer").new({
		closeButtonNormalImage = "ui/common/common_061.png",
		isHideBgSprite = true,
		closeButtonPosition = ccp(900, 40 * Adapter.HeightScale)
	})

	arg_3_0:addChild(var_3_1)

	arg_3_0._bgUISprite = var_3_1:getBackgroundSprite()

	local function var_3_2()
		local var_4_0 = require("scenes.enhance.DlgRuleLayer").new({
			ruleType = DlgRuleType.ruleTower
		})

		CCDirector:sharedDirector():getRunningScene():addChild(var_4_0)
	end

	local var_3_3 = ui.newControlButton({
		normalImage = "ui/enhance/enhance_015.png",
		highlightedImage = "ui/enhance/enhance_015.png",
		clickAction = var_3_2,
		textColor = ColorTable.eTitleButton_Normal,
		position = ccp(900, 600),
		fontSize = ColorTable.eTitleButton_FontSize
	})

	arg_3_0._bgUISprite:addChild(var_3_3, 1)

	if arg_3_0._towerInfo ~= nil then
		arg_3_0:refreshFloorInfoLayer(arg_3_0._towerInfo)
		arg_3_0:middleTheFloorNoAnimations()
	end

	if arg_3_0._donotRequest == nil then
		arg_3_0.towerInfoRequest:request()
	end

	if arg_3_0._towerInfo.FloorsReward ~= nil and arg_3_0._towerInfo.HaveFloor == 5 then
		arg_3_0:showFloorRewardLayer(arg_3_0._towerInfo)
	end

	if arg_3_0._newTowerInfo and arg_3_0._newTowerInfo.Floor ~= arg_3_0._towerInfo.Floor then
		arg_3_0:climpOneFloor()
	end

	GuideLayer:stepDone(TaskEntryType.eEntryTower, 2)
	GuideLayer:showGuideLayer(arg_3_0, arg_3_0._bgUISprite, TaskEntryType.eEntryTower, 3, nil, true)
end

function var_0_3.showBuffStore(arg_5_0)
	local function var_5_0(arg_6_0)
		arg_5_0._addPowerLabel:setString(arg_6_0.power)

		arg_5_0._towerInfo.AddTotalPower = arg_6_0.power
		arg_5_0._towerInfo.Score = arg_5_0._towerInfo.Score - arg_6_0.score

		arg_5_0._curScoreLabel:setString(string.lf("当前积分: #FFFF40%d", arg_5_0._towerInfo.Score))

		if arg_5_0.startMoppingRequest.restable then
			arg_5_0.startMoppingRequest.restable = nil
		end

		if arg_5_0._newTowerInfo then
			arg_5_0._newTowerInfo.Score = arg_5_0._towerInfo.Score
		end
	end

	local function var_5_1(arg_7_0)
		arg_5_0._towerInfo.RemainBuyBuffTime = arg_7_0.buyTime

		arg_5_0:refreshButtons()
		arg_5_0:setBattleButtonsVisible(true)

		arg_5_0.buffStoreLayer = nil
	end

	arg_5_0:setBattleButtonsVisible(false)

	if arg_5_0.buffStoreLayer then
		return
	end

	arg_5_0.buffStoreLayer = require("scenes.Tower.BuffStoreLayer").new({
		bgSprite = arg_5_0._bgUISprite,
		addPowerChangeHandler = var_5_0,
		buyEnd = var_5_1
	})

	arg_5_0:addChild(arg_5_0.buffStoreLayer)
end

function var_0_3.showLeftTowers(arg_8_0)
	arg_8_0._towerLayer = require("scenes.RepeatLayer").new({
		position = CCPoint(0, -60 * Adapter.HeightScale),
		size = Adapter.AutoSize(400, 640),
		repeatDirection = RepeatDirection.eVertical,
		conentHandler = function(arg_9_0, arg_9_1)
			arg_8_0:showTowerContent(arg_9_0, arg_9_1)
		end
	})

	arg_8_0:addChild(arg_8_0._towerLayer)

	local var_8_0
	local var_8_1
	local var_8_2 = Player.team.groupList[Player.headerTeamIndex]

	for iter_8_0, iter_8_1 in ipairs(var_8_2.equipList) do
		if BaseEquips[iter_8_1.equipId].equipType == EquipType.eWeapon then
			var_8_0 = iter_8_1.equipId
			var_8_1 = iter_8_1.pinJie

			break
		end
	end

	arg_8_0._figure = figure.createHero({
		isViewQuality = false,
		platTable = false,
		figId = var_8_2.heroId,
		equipId = var_8_0,
		pinjie = var_8_1,
		scale = 0.4 * Adapter.MinScale
	})

	arg_8_0._figure:setPosition(Adapter.AutoPos(350, 50))
	arg_8_0._towerLayer:addChild(arg_8_0._figure)
end

function var_0_3.showTowerContent(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = display.newSprite("ui/tower/tower_043.png")

	var_10_0:setScaleX(Adapter.WidthScale)
	var_10_0:setScaleY(Adapter.HeightScale)
	var_10_0:setAnchorPoint(ccp(0, 0))
	var_10_0:setPosition(Adapter.AutoPos(50, 70))
	arg_10_1:addChild(var_10_0)

	local var_10_1 = 4

	for iter_10_0 = 1, var_10_1 do
		local var_10_2 = (arg_10_2 - 1) * var_10_1 + iter_10_0
		local var_10_3, var_10_4 = arg_10_0:getFloorScreenPosition(var_10_2)
		local var_10_5 = ccc3(255, 255, 255)

		if arg_10_0._towerInfo and var_10_2 <= arg_10_0._towerInfo.Floor then
			var_10_5 = ccc3(255, 255, 0)
		end

		if arg_10_0._towerInfo and arg_10_0._figure and arg_10_0._towerInfo.Floor + 1 == var_10_2 then
			arg_10_0._figure:setPosition(ccp(var_10_3, var_10_4))
		end

		if var_10_2 > 2 and (var_10_2 - 1) % 5 == 0 then
			local var_10_6

			if var_10_2 > arg_10_0._towerInfo.Floor then
				if arg_10_0._towerInfo.Floor + 1 == var_10_2 and arg_10_0._towerInfo.FloorsReward == nil then
					var_10_6 = display.newSprite("ui/tower/tower_011_1.png", var_10_3, var_10_4)
				else
					var_10_6 = display.newSprite("ui/tower/tower_011.png", var_10_3, var_10_4)

					display.addSpriteFramesWithFile("ui/map/ui_baoxiang.plist", "ui/map/ui_baoxiang.png")

					local var_10_7 = display.newSprite("#ui_baoxiang_01.png")
					local var_10_8 = display.newFrames("ui_baoxiang_0%d.png", 1, 5)
					local var_10_9 = display.newAnimation(var_10_8, 0.1)

					var_10_7:runAction(CCRepeatForever:create(CCAnimate:create(var_10_9)))
					var_10_7:setPosition(45, 50)
					var_10_6:addChild(var_10_7)
				end
			else
				var_10_6 = display.newSprite("ui/tower/tower_011_1.png", var_10_3, var_10_4)
			end

			var_10_6:setScale(Adapter.MinScale)
			arg_10_1:addChild(var_10_6)
		end

		if var_10_2 > 2 and (var_10_2 - 1) % 3 == 0 and var_10_2 > arg_10_0._towerInfo.Floor + 1 then
			local var_10_10 = arg_10_0:createBuffAdd()

			var_10_10:setScale(Adapter.MinScale)
			var_10_10:setPosition(var_10_3, var_10_4)
			arg_10_1:addChild(var_10_10)

			local var_10_11 = CCArray:create()

			var_10_11:addObject(CCMoveTo:create(1, ccp(var_10_3, var_10_4 + 10)))
			var_10_11:addObject(CCMoveTo:create(1, ccp(var_10_3, var_10_4)))
			var_10_10:runAction(CCRepeatForever:create(CCSequence:create(var_10_11)))

			if var_10_2 - arg_10_0._towerInfo.Floor <= 3 then
				arg_10_0.buffAdd = var_10_10
			end
		end

		local var_10_12 = display.newSprite("ui/common/common_052.png", var_10_3, var_10_4 - 30 * Adapter.WidthScale)

		var_10_12:setScale(Adapter.MinScale)
		arg_10_1:addChild(var_10_12)

		local var_10_13 = ui.newTTFLabelWithOutline({
			text = string.lf("第%s层", var_10_2),
			font = _FONT_LISU,
			size = 22 * Adapter.MinScale,
			color = var_10_5
		})

		var_10_13:setAnchorPoint(ccp(0.5, 0))
		var_10_13:setPosition(ccp(var_10_3 - 30 * Adapter.WidthScale, var_10_4 - 30 * Adapter.WidthScale))
		arg_10_1:addChild(var_10_13)
	end
end

function var_0_3.createBuffAdd(arg_11_0)
	local var_11_0 = display.newSprite("ui/tower/buffadd_ball.png", 0, 0)

	display.addSpriteFramesWithFile("ui/tower/buffadd.plist", "ui/tower/buffadd.png")

	local var_11_1 = display.newSprite("#buffadd1.png")
	local var_11_2 = display.newFrames("buffadd%d.png", 1, 13)
	local var_11_3 = display.newAnimation(var_11_2, 0.07692307692307693)

	var_11_1:runAction(CCRepeatForever:create(CCAnimate:create(var_11_3)))
	var_11_1:setPosition(61, 62)
	var_11_0:addChild(var_11_1, 1)

	return var_11_0
end

function var_0_3.createFloorInfoLayer(arg_12_0)
	arg_12_0._floorInfoLayer = display.newNode()

	arg_12_0._bgUISprite:addChild(arg_12_0._floorInfoLayer)

	local function var_12_0(arg_13_0, arg_13_1)
		local var_13_0 = tolua.cast(arg_13_1, "CCControlButton"):getTag()

		if var_13_0 == ButtonTagType.eRankTag then
			GuideLayer:removeGuideLayer(arg_12_0, TaskEntryType.eEntryTower, 3)

			local var_13_1 = require("scenes.PK.DlgRankLayer").new({
				type = DlgRankType.rankTower
			})

			CCDirector:sharedDirector():getRunningScene():addChild(var_13_1)
		elseif var_13_0 == ButtonTagType.eBuffTag then
			arg_12_0:showBuffStore()
		elseif var_13_0 == ButtonTagType.eCleanoutTag then
			if Player.level < 30 and Player.vipLevel < 5 then
				local var_13_2 = string.lf("30级或VIP5级开放~")

				arg_12_0:addChild(require("scenes.FlashNotice").new(var_13_2))
			elseif arg_12_0._towerInfo.IsMopping > 0 then
				if arg_12_0._towerInfo.Floor >= var_0_0 then
					ui.showMessageBox({
						parent = arg_12_0,
						text = string.lf("上仙，现在通天塔只建设到%d层哦，你已经通关了哦~ ", var_0_0)
					})

					return
				else
					arg_12_0:startMopping()
					print("开始扫荡....... ")
				end
			end
		elseif arg_12_0._towerInfo.RemainTowerChallengeTime <= 0 then
			local var_13_3 = string.lf("挑战次数不足~")

			arg_12_0:addChild(require("scenes.FlashNotice").new(var_13_3))
		else
			local function var_13_4()
				GuideLayer:stepDone(TaskEntryType.eEntryTower, 3)

				local var_14_0 = arg_12_0._towerInfo

				var_14_0.FloorsReward = nil

				local function var_14_1(arg_15_0, arg_15_1)
					game.enterTowerFloorScene({
						donotRequest = true,
						towerInfo = var_14_0,
						newTowerInfo = arg_15_1.Towerinfo,
						battleResult = arg_15_0
					})
				end

				local var_14_2 = arg_12_0._towerInfo.HaveFloor - 1 == 0 and 5 or arg_12_0._towerInfo.HaveFloor - 1
				local var_14_3 = string.lf("恭喜上仙！您法力广大，仙术超群！\n您再登%d层, 就可获取丰厚奖励", var_14_2)
				local var_14_4 = {
					floor = var_14_0.Floor,
					towertype = var_13_0,
					text = {
						var_14_3
					}
				}

				BattleOperator:startBattle(eBattleType.Towr, var_14_4, var_14_1)
			end

			if arg_12_0._towerInfo.Floor >= var_0_0 then
				ui.showMessageBox({
					parent = arg_12_0,
					text = string.lf("上仙，现在通天塔只建设到%d层哦，你已经通关了哦~ ", var_0_0)
				})

				return
			else
				var_13_4()
			end
		end
	end

	arg_12_0.spriteList = {
		{
			bgSprite = "ui/tower/tower_017.png",
			scoreSprite = "uilocal/tower/tower_text_009.png",
			y = 453,
			battleTitleSprite = "uilocal/tower/tower_text_012.png",
			battleBgSprite = "ui/tower/tower_014.png",
			x = 642,
			BattleType = ButtonTagType.eBloodBattle
		},
		{
			bgSprite = "ui/tower/tower_018.png",
			scoreSprite = "uilocal/tower/tower_text_008.png",
			y = 322,
			battleTitleSprite = "uilocal/tower/tower_text_011.png",
			battleBgSprite = "ui/tower/tower_015.png",
			x = 571,
			BattleType = ButtonTagType.eDeadBattle
		},
		{
			bgSprite = "ui/tower/tower_019.png",
			scoreSprite = "uilocal/tower/tower_text_007.png",
			y = 185,
			battleTitleSprite = "uilocal/tower/tower_text_010.png",
			battleBgSprite = "ui/tower/tower_016.png",
			x = 658,
			BattleType = ButtonTagType.ePowerBattle
		}
	}
	arg_12_0.visibleButtons = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.spriteList) do
		local var_12_1 = ui.newControlButton({
			normalImage = iter_12_1.bgSprite,
			clickAction = var_12_0
		})

		var_12_1:setPosition(iter_12_1.x, iter_12_1.y)
		var_12_1:setTag(iter_12_1.BattleType)
		arg_12_0._floorInfoLayer:addChild(var_12_1)
		table.insert(arg_12_0.visibleButtons, var_12_1)

		local var_12_2 = display.newSprite(iter_12_1.battleBgSprite, 323, 48)

		var_12_1:addChild(var_12_2)

		local var_12_3 = display.newSprite(iter_12_1.battleTitleSprite, 55, 41)

		var_12_2:addChild(var_12_3)

		local var_12_4 = display.newSprite("ui/common/common_005.png", 73, 64)

		var_12_1:addChild(var_12_4)

		local var_12_5 = arg_12_0._newTowerInfo and arg_12_0._newTowerInfo.Floor + 1 or arg_12_0._towerInfo.Floor + 1

		var_12_5 = var_12_5 >= var_0_0 and var_0_0 or var_12_5

		local var_12_6 = "header/" .. TowerNPCHeaders[var_12_5][table.getn(arg_12_0.spriteList) + 1 - iter_12_0].image
		local var_12_7 = display.newSprite(var_12_6, 73, 64)

		var_12_1:addChild(var_12_7)
		addLabelWithColorSize(var_12_1, string.lf("战胜奖励"), ccc3(255, 255, 255), 20, ccp(1, 0.5), ccp(200, 37))
		addLabelWithColorSize(var_12_1, string.lf("分"), ccc3(255, 255, 255), 20, ccp(0, 0.5), ccp(240, 37))

		local var_12_8 = display.newSprite(iter_12_1.scoreSprite, 220, 37)

		var_12_1:addChild(var_12_8)
	end

	local var_12_9 = display.newSprite("ui/tower/tower_045.png", 580, 598)

	arg_12_0._floorInfoLayer:addChild(var_12_9)

	arg_12_0.rankButton = ui.newControlButton({
		normalImage = "ui/common/common_020.png",
		fontSize = 25,
		clickAction = var_12_0,
		text = string.lf("排行榜")
	})

	arg_12_0.rankButton:setPosition(73, 29)
	arg_12_0.rankButton:setTag(4)
	var_12_9:addChild(arg_12_0.rankButton)
	arg_12_0.rankButton:setEnabled(true)

	local var_12_10 = arg_12_0._towerInfo.RemainTowerChallengeTime

	arg_12_0.remainLabel = ui.newTTFLabel({
		y = 540,
		x = 380,
		text = string.lf("今日剩余挑战次数: %s", var_12_10 or 0),
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(22),
		color = ccc3(234, 182, 96),
		align = ui.TEXT_ALIGN_LEFT,
		valign = ui.TEXT_VALIGN_CENTER,
		dimensions = CCSize(300, 40)
	})

	arg_12_0._floorInfoLayer:addChild(arg_12_0.remainLabel)
	Adapter.NodeAbsScale(arg_12_0.remainLabel)

	local var_12_11 = arg_12_0._towerInfo.RemainBuyBuffTime

	arg_12_0.buffButton = ui.newControlButton({
		highlightedImage = "ui/common/common_019.png",
		disabledImage = "ui/common/common_080.png",
		fontSize = 22,
		normalImage = "ui/common/common_019.png",
		clickAction = var_12_0,
		text = string.lf("Buff兑换:%s", arg_12_0._towerInfo.RemainBuyBuffTime or 0)
	})

	arg_12_0.buffButton:setPosition(700, 530)
	arg_12_0.buffButton:setTag(5)
	arg_12_0._floorInfoLayer:addChild(arg_12_0.buffButton)
	table.insert(arg_12_0.visibleButtons, arg_12_0.buffButton)
	arg_12_0.buffButton:setEnabled(arg_12_0._towerInfo.RemainBuyBuffTime > 0)

	arg_12_0.moppingButton = ui.newControlButton({
		highlightedImage = "ui/common/common_019.png",
		disabledImage = "ui/common/common_080.png",
		fontSize = 22,
		normalImage = "ui/common/common_019.png",
		clickAction = var_12_0,
		text = string.lf("开始扫荡")
	})

	arg_12_0.moppingButton:setPosition(700, 50)
	arg_12_0.moppingButton:setTag(6)
	arg_12_0._floorInfoLayer:addChild(arg_12_0.moppingButton)
	table.insert(arg_12_0.visibleButtons, arg_12_0.moppingButton)

	local var_12_12 = Player.level < 30 and Player.vipLevel < 5 or arg_12_0._towerInfo.IsMopping > 0

	arg_12_0.moppingButton:setEnabled(var_12_12)
	arg_12_0:setBattleButtonsVisible(true)

	arg_12_0._curFloorLabel = addLabelWithColorSize(var_12_9, string.lf("第#2A94BF #C1B366层"), ccc3(255, 255, 255), 24, ccp(0.5, 0.5), ccp(180, 29))
	arg_12_0._toRewardFloorLabel = addLabelWithColorSize(var_12_9, string.lf("再登#45D326 #C1B366层可领奖"), ccc3(255, 255, 255), 24, ccp(0.5, 0.5), ccp(315, 29))
	arg_12_0._curScoreLabel = addLabelWithColorSize(var_12_9, string.lf("当前积分: #FFFF40"), ccc3(255, 255, 255), 24, ccp(0.5, 0.5), ccp(500, 29))

	if IPlatform:instance():getConfig("Channel") == "ZSY_VN" then
		arg_12_0._curScoreLabel:setPosition(ccp(545, 29))
	end

	local var_12_13 = CCSprite:create("ui/home/home_045.png")

	var_12_13:setPosition(ccp(110, 600))
	arg_12_0._floorInfoLayer:addChild(var_12_13)

	local var_12_14 = CCSprite:create("uilocal/home/home_text_000.png")

	var_12_14:setPosition(ccp(50, 600))
	arg_12_0._floorInfoLayer:addChild(var_12_14)

	local var_12_15 = CCSprite:create("ui/home/home_000_s.png")

	var_12_15:setPosition(ccp(80, 565))
	arg_12_0._floorInfoLayer:addChild(var_12_15)

	arg_12_0._battlePowerLabel = CCLabelAtlas:create(tostring(Player.team.battlePower), "ui/home/home_000_small.png", 22, 33, 48, 6)

	arg_12_0._battlePowerLabel:setScale(Adapter.MinScale)
	arg_12_0._battlePowerLabel:setAnchorPoint(ccp(0, 0.5))
	arg_12_0._battlePowerLabel:setPosition(ccp(90, 600))
	arg_12_0._floorInfoLayer:addChild(arg_12_0._battlePowerLabel)

	arg_12_0._addPowerLabel = CCLabelAtlas:create(tostring(Player.team.battlePower), "ui/home/home_000_small.png", 22, 33, 48, 6)

	arg_12_0._addPowerLabel:setScale(Adapter.MinScale)
	arg_12_0._addPowerLabel:setAnchorPoint(ccp(0, 0.5))
	arg_12_0._addPowerLabel:setPosition(ccp(90, 560))
	arg_12_0._floorInfoLayer:addChild(arg_12_0._addPowerLabel, 2)
end

function var_0_3.setBattleButtonsVisible(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.visibleButtons) do
		iter_16_1:setVisible(arg_16_1)
	end

	arg_16_0.remainLabel:setVisible(arg_16_1)

	if arg_16_0.extRewardSprite then
		arg_16_0.extRewardSprite:setVisible(arg_16_1)
	end
end

function var_0_3.refreshFloorInfoLayer(arg_17_0, arg_17_1)
	if arg_17_0._floorInfoLayer == nil then
		arg_17_0:createFloorInfoLayer()
	end

	if arg_17_1 == nil then
		return
	end

	arg_17_0._curFloorLabel:setString(string.lf("第#2A94BF%d#C1B366层", arg_17_1.Floor + 1))

	if IPlatform:instance():getConfig("Channel") == "ZSY_VN" then
		arg_17_0._curFloorLabel:setVisible(false)
	end

	local var_17_0 = arg_17_1.HaveFloor == 0 and 5 or arg_17_1.HaveFloor

	arg_17_0._toRewardFloorLabel:setString(string.lf("再登#45D326%d#C1B366层可领奖", var_17_0))
	arg_17_0._curScoreLabel:setString(string.lf("当前积分: #FFFF40%d", arg_17_1.Score))

	if arg_17_1.ExtRewardDifficultyType ~= 0 then
		if arg_17_0.extRewardSprite ~= nil then
			arg_17_0.extRewardSprite:removeAllChildrenWithCleanup(true)

			arg_17_0.extRewardSprite = nil
		end

		local var_17_1 = arg_17_0.spriteList[arg_17_1.ExtRewardDifficultyType].x + 160
		local var_17_2 = arg_17_0.spriteList[arg_17_1.ExtRewardDifficultyType].y - 10
		local var_17_3 = getItemHeaderImagePath(arg_17_1.ExtReward.Type, arg_17_1.ExtReward.ID)

		arg_17_0.extRewardSprite = display.newSprite(var_17_3, var_17_1, var_17_2)

		arg_17_0._floorInfoLayer:addChild(arg_17_0.extRewardSprite)
	elseif arg_17_0.extRewardSprite ~= nil then
		arg_17_0.extRewardSprite:removeAllChildrenWithCleanup(true)

		arg_17_0.extRewardSprite = nil
	end

	local var_17_4 = math.ceil((arg_17_1.Floor + 1) / 4)
	local var_17_5 = 0

	arg_17_0._towerLayer:setIndexAndOffset(var_17_4, var_17_5)
	arg_17_0._towerLayer:reloadLayer()

	local var_17_6, var_17_7 = arg_17_0:getFloorScreenPosition(arg_17_1.Floor + 1)

	arg_17_0._figure:setPosition(ccp(var_17_6, var_17_7))
	arg_17_0._addPowerLabel:setString(arg_17_1.AddTotalPower)
	arg_17_0._battlePowerLabel:setString(tostring(Player.team.battlePower))
end

function var_0_3.getFloorOriginPosition(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1 % 2
	local var_18_1 = (arg_18_1 - 1) % 4
	local var_18_2 = 100 * Adapter.WidthScale + var_18_0 * var_0_4
	local var_18_3 = 50 * Adapter.HeightScale + var_18_1 * var_0_5

	if var_18_3 < 0 then
		var_18_3 = var_18_3 + var_0_5 * 4
	end

	return var_18_2, var_18_3
end

function var_0_3.getFloorScreenPosition(arg_19_0, arg_19_1)
	local var_19_0 = 0

	if arg_19_0._towerLayer ~= nil then
		var_19_0 = arg_19_0._towerLayer._currentOffset
	end

	local var_19_1 = arg_19_1 % 2
	local var_19_2 = (arg_19_1 - 1) % 4
	local var_19_3 = 100 * Adapter.WidthScale + var_19_1 * var_0_4
	local var_19_4 = 100 * Adapter.HeightScale + var_19_2 * var_0_5 + var_19_0

	if var_19_4 < 0 then
		var_19_4 = var_19_4 + var_0_5 * 4
	end

	return var_19_3, var_19_4
end

function var_0_3.climpOneFloor(arg_20_0)
	if arg_20_0._towerInfo.Floor >= var_0_0 then
		return
	end

	arg_20_0._towerInfo = arg_20_0._newTowerInfo

	local var_20_0, var_20_1 = arg_20_0:getFloorScreenPosition(arg_20_0._newTowerInfo.Floor + 1)

	local function var_20_2()
		if arg_20_0._newTowerInfo and arg_20_0._newTowerInfo.FloorsReward ~= nil and arg_20_0._newTowerInfo.HaveFloor == 5 then
			arg_20_0:showFloorRewardLayer(arg_20_0._newTowerInfo)
		end

		arg_20_0._newTowerInfo = nil

		arg_20_0:middleTheFloor()
	end

	local function var_20_3()
		if arg_20_0.buffAdd and arg_20_0._towerInfo.Floor % 3 == 0 then
			local var_22_0 = arg_20_0:createBuffAdd()

			var_22_0:setPosition(var_20_0 / Adapter.WidthScale, (var_20_1 - 50) / Adapter.WidthScale)
			arg_20_0._bgUISprite:addChild(var_22_0)
			arg_20_0.buffAdd:removeFromParentAndCleanup(true)

			local var_22_1, var_22_2 = arg_20_0.buffButton:getPosition()
			local var_22_3 = CCArray:create()

			var_22_3:addObject(CCDelayTime:create(0.1))
			var_22_3:addObject(CCMoveTo:create(0.5, ccp(var_22_1, var_22_2)))
			var_22_3:addObject(CCFadeOut:create(0.4))
			var_22_3:addObject(CCCallFunc:create(function()
				var_22_0:removeFromParentAndCleanup(true)

				local var_23_0 = string.lf("Buff兑换:%s", arg_20_0._towerInfo.RemainBuyBuffTime or 0)

				arg_20_0.buffButton:setTitleForState(CCString:create(var_23_0), CCControlStateNormal)
				arg_20_0.buffButton:setTitleForState(CCString:create(var_23_0), CCControlStateDisabled)
			end))
			var_22_0:runAction(CCSequence:create(var_22_3))
			arg_20_0:refreshButtons()
		end
	end

	local var_20_4, var_20_5 = arg_20_0:getFloorScreenPosition(arg_20_0._towerInfo.Floor + 1)
	local var_20_6 = CCArray:create()

	var_20_6:addObject(CCDelayTime:create(0.5))
	var_20_6:addObject(CCMoveTo:create(0.5, ccp(var_20_4, var_20_5)))
	var_20_6:addObject(CCCallFunc:create(var_20_2))
	var_20_6:addObject(CCCallFunc:create(var_20_3))
	arg_20_0._figure:runAction(CCSequence:create(var_20_6))
end

function var_0_3.middleTheFloorNoAnimations(arg_24_0)
	if arg_24_0._towerInfo == nil then
		return
	end

	local var_24_0, var_24_1 = arg_24_0:getFloorOriginPosition(arg_24_0._towerInfo.Floor + 1)
	local var_24_2, var_24_3 = arg_24_0:getFloorOriginPosition(arg_24_0._towerInfo.Floor)
	local var_24_4 = 0

	if var_24_1 > 400 * Adapter.HeightScale then
		var_24_4 = var_24_1 - 200 * Adapter.HeightScale
	end

	arg_24_0._towerLayer:setLayerOffset(0, -var_24_4)
	arg_24_0._figure:setPositionY(arg_24_0._figure:getPositionY() - var_24_4)
end

function var_0_3.middleTheFloor(arg_25_0)
	if arg_25_0._towerInfo == nil then
		return
	end

	local var_25_0, var_25_1 = arg_25_0:getFloorOriginPosition(arg_25_0._towerInfo.Floor + 1)
	local var_25_2, var_25_3 = arg_25_0:getFloorOriginPosition(arg_25_0._towerInfo.Floor)
	local var_25_4 = 0

	if var_25_1 > 400 * Adapter.HeightScale then
		var_25_4 = var_25_1 - 200 * Adapter.HeightScale
	end

	if var_25_1 < var_25_3 then
		var_25_4 = 300 * Adapter.HeightScale
	end

	local var_25_5 = var_25_4 / (10 * Adapter.HeightScale)

	local function var_25_6()
		arg_25_0._towerLayer:setLayerOffset(0, -10 * Adapter.HeightScale)
		arg_25_0._figure:setPositionY(arg_25_0._figure:getPositionY() - 10 * Adapter.HeightScale)
	end

	local function var_25_7()
		arg_25_0:refreshFloorInfoLayer(arg_25_0._towerInfo)
		arg_25_0:middleTheFloorNoAnimations()
	end

	local var_25_8 = CCArray:create()

	for iter_25_0 = 1, var_25_5 do
		var_25_8:addObject(CCDelayTime:create(0.03))
		var_25_8:addObject(CCCallFunc:create(var_25_6))
	end

	var_25_8:addObject(CCCallFunc:create(var_25_7))

	local var_25_9 = CCSequence:create(var_25_8)

	arg_25_0:runAction(var_25_9)
end

function var_0_3.showFloorRewardLayer(arg_28_0, arg_28_1)
	arg_28_0._floorRewardLayer = CCLayerColor:create()

	arg_28_0._floorRewardLayer:setColor(ccc3(0, 0, 0))
	arg_28_0._floorRewardLayer:setOpacity(130)

	local function var_28_0(arg_29_0, arg_29_1, arg_29_2)
		if arg_29_0 == "began" then
			return true
		elseif arg_29_0 == "moved" then
			-- block empty
		elseif arg_29_0 ~= "ended" and arg_29_0 == "cancelled" then
			-- block empty
		end
	end

	arg_28_0._floorRewardLayer:addTouchEventListener(var_28_0, false, 1, true)
	arg_28_0._floorRewardLayer:setTouchEnabled(true)
	arg_28_0:addChild(arg_28_0._floorRewardLayer)

	local var_28_1 = display.newSprite("ui/tower/tower_039.png", display.cx - 11, 274 * Adapter.MinScale)

	var_28_1:setScale(Adapter.MinScale)
	arg_28_0._floorRewardLayer:addChild(var_28_1)

	local var_28_2 = display.newSprite("uilocal/tower/tower_text_013.png", 403, 358)

	var_28_1:addChild(var_28_2)

	local var_28_3 = string.lf("%d-%d层得分:", arg_28_1.Floor - 4, arg_28_1.Floor)

	addLabelWithColorSize(var_28_1, var_28_3, ccc3(210, 194, 118), 20, ccp(1, 0.5), ccp(425, 288))
	addLabelWithColorSize(var_28_1, arg_28_1.LastFiveFloorScore, ccc3(63, 201, 229), 20, ccp(0, 0.5), ccp(440, 288))

	arg_28_0.tableview = arg_28_0:showFloorRewardItem(arg_28_1.FloorsReward.Simp)

	var_28_1:addChild(arg_28_0.tableview)
	addLabelWithColorSize(var_28_1, string.lf("登塔层数越高，奖励越丰富(注：宝箱能产出高级装备)"), ccc3(208, 171, 37), 20, ccp(0.5, 0.5), ccp(370, 90), _FONT_LISU)

	local function var_28_4(arg_30_0, arg_30_1)
		arg_28_0.getFloorRewardRequest:request()
	end

	local var_28_5 = ui.newControlButton({
		normalImage = "ui/common/common_105.png",
		fontSize = 25,
		clickAction = var_28_4,
		text = string.lf("领取奖励")
	})

	var_28_5:setPosition(415, 45)
	var_28_1:addChild(var_28_5)
end

function var_0_3.showFloorRewardItem(arg_31_0, arg_31_1)
	local var_31_0 = CCTableView:create(CCSize(600, 200))

	var_31_0:setPosition(415, 200)
	var_31_0:setViewSize(CCSize(500, 200))
	var_31_0:ignoreAnchorPointForPosition(false)
	var_31_0:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_31_0:setDirection(kCCScrollViewDirectionHorizontal)

	local function var_31_1(arg_32_0)
		return 200, 150
	end

	local function var_31_2(arg_33_0)
		return #arg_31_1
	end

	local function var_31_3(arg_34_0, arg_34_1)
		local var_34_0 = arg_34_0:cellAtIndex(arg_34_1)
		local var_34_1 = arg_34_1 + 1

		if var_34_0 == nil then
			var_34_0 = CCTableViewCell:new()

			local var_34_2 = {
				isName = true,
				type = arg_31_1[var_34_1].Type,
				itemId = arg_31_1[var_34_1].ID or 0,
				nameColor = ccc3(239, 232, 195),
				count = arg_31_1[var_34_1].Count,
				clickAction = function()
					var_0_1.tipshandler(arg_31_1[var_34_1])
				end
			}
			local var_34_3 = figure.createHeader(var_34_2)

			var_34_3:setAnchorPoint(CCPoint(0.5, 0.5))
			var_34_3:setPosition(75, 100)
			var_34_0:addChild(var_34_3)
		end

		return var_34_0
	end

	var_31_0:registerScriptHandler(var_31_1, CCTableView.kTableCellSizeForIndex)
	var_31_0:registerScriptHandler(var_31_2, CCTableView.kNumberOfCellsInTableView)
	var_31_0:registerScriptHandler(var_31_3, CCTableView.kTableCellSizeAtIndex)
	var_31_0:reloadData()

	return var_31_0
end

function var_0_3.getCurrentTowerScore(arg_36_0)
	return arg_36_0._towerInfo.Score
end

function var_0_3.setCurrentTowerScore(arg_37_0, arg_37_1)
	arg_37_0._towerInfo.Score = arg_37_1

	arg_37_0._curScoreLabel:setString(string.lf("当前积分: #FFFF40%d", arg_37_1))
end

function var_0_3.startMopping(arg_38_0)
	arg_38_0.startMoppingRequest:request()
end

function var_0_3.refreshButtons(arg_39_0)
	arg_39_0.remainLabel:setString(string.lf("今日剩余挑战次数: %s", arg_39_0._towerInfo.RemainTowerChallengeTime or 0))
	arg_39_0.buffButton:setEnabled(arg_39_0._towerInfo.RemainBuyBuffTime > 0)

	local var_39_0 = Player.level < 30 and Player.vipLevel < 5 or arg_39_0._towerInfo.IsMopping > 0

	arg_39_0.moppingButton:setEnabled(var_39_0)

	local var_39_1 = string.lf("Buff兑换:%s", arg_39_0._towerInfo.RemainBuyBuffTime or 0)

	arg_39_0.buffButton:setTitleForState(CCString:create(var_39_1), CCControlStateNormal)
	arg_39_0.buffButton:setTitleForState(CCString:create(var_39_1), CCControlStateDisabled)
	arg_39_0.rankButton:setEnabled(true)

	local var_39_2 = string.lf("开始扫荡")

	arg_39_0.moppingButton:setTitleForState(CCString:create(var_39_2), CCControlStateNormal)
	arg_39_0.moppingButton:setTitleForState(CCString:create(var_39_2), CCControlStateDisabled)

	if arg_39_0.moppingText then
		arg_39_0.moppingText:setVisible(false)
	end

	arg_39_0.buffButton:setEnabled(arg_39_0._towerInfo.RemainBuyBuffTime > 0)

	local var_39_3 = Player.level < 30 and Player.vipLevel < 5 or arg_39_0._towerInfo.IsMopping > 0 and arg_39_0._towerInfo.RemainTowerChallengeTime > 0

	arg_39_0.moppingButton:setEnabled(var_39_3)

	if arg_39_0.startMoppingRequest.restable then
		arg_39_0._towerInfo.HaveFloor = arg_39_0.startMoppingRequest:getMoppingHaveFloor()

		arg_39_0._toRewardFloorLabel:setString(string.lf("再登#45D326%d#C1B366层可领奖", arg_39_0._towerInfo.HaveFloor))

		arg_39_0._towerInfo.Score = arg_39_0.startMoppingRequest:getMoppingScore()

		arg_39_0._curScoreLabel:setString(string.lf("当前积分: #FFFF40%d", arg_39_0._towerInfo.Score))
	end
end

function var_0_3.createNetworkInterface(arg_40_0)
	arg_40_0.towerInfoRequest = GetTowerInfoRequest:new(arg_40_0.towerScene)

	local function var_40_0()
		local var_41_0 = arg_40_0.towerInfoRequest:getTowerInfo()

		if var_41_0.FloorsReward ~= nil and var_41_0.HaveFloor == 5 then
			arg_40_0:showFloorRewardLayer(var_41_0)
		end

		if arg_40_0._towerInfo ~= nil and var_41_0.Floor > arg_40_0._towerInfo.Floor then
			arg_40_0._newTowerInfo = var_41_0

			arg_40_0:climpOneFloor()

			return
		end

		arg_40_0._towerInfo = var_41_0

		arg_40_0:refreshFloorInfoLayer(arg_40_0._towerInfo)
		arg_40_0:middleTheFloorNoAnimations()
	end

	local function var_40_1(arg_42_0)
		print("responseTowerInfoRequestFail")
	end

	arg_40_0.towerInfoRequest:setResponseNormalHandler(var_40_0)
	arg_40_0.towerInfoRequest:setResponseExceptionHandler(var_40_1)

	arg_40_0.getFloorRewardRequest = GetFloorRewardRequest:new(arg_40_0.towerScene)

	local function var_40_2()
		if arg_40_0._floorRewardLayer then
			arg_40_0._floorRewardLayer:removeFromParentAndCleanup(true)

			arg_40_0._floorRewardLayer = nil
		end

		arg_40_0._towerInfo.FloorsReward = nil

		local var_43_0 = string.lf("恭喜, 你获取奖励成功~")

		arg_40_0:addChild(require("scenes.FlashNotice").new(var_43_0))
		arg_40_0:refreshFloorInfoLayer(arg_40_0._towerInfo)
		arg_40_0:middleTheFloorNoAnimations()
	end

	local function var_40_3(arg_44_0)
		print("responsegetFloorRewardRequestFail")
	end

	arg_40_0.getFloorRewardRequest:setResponseNormalHandler(var_40_2)
	arg_40_0.getFloorRewardRequest:setResponseExceptionHandler(var_40_3)

	local function var_40_4()
		ui.showMessageBox({
			parent = arg_40_0,
			text = string.lf("上仙~扫荡完毕，奖励可以通过邮件领取~ ")
		})
		arg_40_0.rankButton:setEnabled(false)

		arg_40_0._towerInfo.RemainTowerChallengeTime = arg_40_0._towerInfo.RemainTowerChallengeTime - 1

		print(arg_40_0.startMoppingRequest:getMoppingState())

		arg_40_0._towerInfo.IsMopping = arg_40_0.startMoppingRequest:getMoppingState()

		local var_45_0 = arg_40_0._towerInfo.Floor

		arg_40_0._towerInfo.Floor = arg_40_0.startMoppingRequest:getMoppingFloor()
		arg_40_0._towerInfo.HaveFloor = arg_40_0.startMoppingRequest:getMoppingHaveFloor()
		arg_40_0._towerInfo.Score = arg_40_0.startMoppingRequest:getMoppingScore()
		arg_40_0.currentFloor = arg_40_0._towerInfo.Floor

		for iter_45_0 = var_45_0, arg_40_0._towerInfo.Floor do
			if iter_45_0 > 0 and iter_45_0 % 3 == 0 then
				arg_40_0._towerInfo.RemainBuyBuffTime = arg_40_0._towerInfo.RemainBuyBuffTime + 1
			end
		end

		arg_40_0:refreshFloorInfoLayer(arg_40_0._towerInfo)
		arg_40_0:middleTheFloorNoAnimations()
		arg_40_0:refreshButtons()
	end

	arg_40_0.startMoppingRequest = StartMoppingRequest:new(arg_40_0.towerScene)

	arg_40_0.startMoppingRequest:setResponseNormalHandler(var_40_4)
end

return var_0_3
