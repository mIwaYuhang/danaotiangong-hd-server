require("data.player")
require("scenes.activity.ActivityScene")
require("scenes.store.StoreScene")
require("network.DailySalaryRequest")

local var_0_0 = require("scenes.toollayer.tool")
local var_0_1 = require("scenes.home.AnnouncementScene")
local var_0_2 = DefaultZOrder.ePopupLayer
local var_0_3 = class("HomeScene", function()
	return display.newScene("HomeScene")
end)

ShowSubLayerType = {
	eCopyHome = 2,
	ePKHome = 1
}

function var_0_3.ctor(arg_2_0, arg_2_1)
	if arg_2_1 then
		arg_2_0.showGuideArrow = arg_2_1.showGuideArrow
		arg_2_0.taskEntryType = arg_2_1.taskEntryType
		arg_2_0.showHomeGuideArrow = arg_2_1.showHomeGuideArrow
		arg_2_0.changeHeroIndex = arg_2_1.changeHeroIndex
	end

	arg_2_0.tableExtendButton = {}

	local var_2_0 = ScrollSprite:create(16, 0, "ui/home/home_017.jpg")

	var_2_0:setScale(Adapter.HeightScale)
	var_2_0:setPosition(ccp(0, 0))
	var_2_0:setAnchorPoint(CCPoint(0, 0))

	local var_2_1 = CCSprite:create("ui/home/home_053.png")

	var_2_1:setScale(Adapter.HeightScale)
	var_2_1:setPosition(ccp(0, 0))
	var_2_1:setAnchorPoint(CCPoint(0, 1))

	local var_2_2 = ScrollSprite:create(16, 0, "ui/home/home_065.png")

	var_2_2:setScale(Adapter.HeightScale)
	var_2_2:setPosition(ccp(0, 0))
	var_2_2:setAnchorPoint(CCPoint(0, 0.5))

	arg_2_0.bg_near_layer = CCLayer:create()

	local var_2_3 = CCSprite:create("ui/home/home_054.png")

	arg_2_0.bg_near_Sprite = var_2_3

	var_2_3:setPosition(0, 0)
	var_2_3:setAnchorPoint(ccp(0, 0))
	var_2_3:setScale(Adapter.HeightScale)
	arg_2_0.bg_near_layer:addChild(var_2_3)

	local var_2_4 = CCSprite:create("ui/home/home_055.png")

	var_2_4:setAnchorPoint(ccp(1, 0))
	var_2_4:setPosition(1920, 0)
	var_2_3:addChild(var_2_4)

	local var_2_5 = CCSprite:create("ui/home/home_052.png")

	var_2_5:setAnchorPoint(ccp(0.5, 0))
	var_2_5:setScale(Adapter.HeightScale)

	arg_2_0.parallaxNode = CCParallaxNode:create()

	arg_2_0.parallaxNode:addChild(var_2_0, 0, ccp(0.7, 1), ccp(0, 0))
	arg_2_0.parallaxNode:addChild(var_2_1, 0, ccp(0.85, 1), ccp(0, display.height))
	arg_2_0.parallaxNode:addChild(var_2_2, 0, ccp(0.7, 1), ccp(0, display.cy))
	arg_2_0.parallaxNode:addChild(arg_2_0.bg_near_layer, 0, ccp(1, 1), ccp(0, 0))
	arg_2_0.parallaxNode:addChild(var_2_5, 0, ccp(1.2, 1), ccp(display.right + 250, 0))
	arg_2_0.parallaxNode:setPosition(game.homeOffset)
	arg_2_0:addChild(arg_2_0.parallaxNode)

	arg_2_0.mainButtonInfos = {}

	local var_2_6 = {
		{
			normalImage = "ui/home/home_016.png",
			clickAction = function()
				print("按下通天塔按钮")
				game.enterTowerFloorScene()
			end,
			position = ccp(Adapter.AutoPosY(141), Adapter.AutoPosY(259))
		},
		{
			normalImage = "ui/home/home_012.png",
			clickAction = function()
				local var_4_0 = BaseStages[Player.taskInfo.MaxPID].chapterId

				if Player.currentMissionStageID and BaseStages[Player.currentMissionStageID] then
					var_4_0 = BaseStages[Player.currentMissionStageID].chapterId
				end

				local var_4_1 = WorldType.eHeaven

				if var_4_0 then
					var_4_1 = BaseChapters[var_4_0].worldType
				end

				game.enterMapWorldScene(var_4_1)
			end,
			position = ccp(Adapter.AutoPosY(595), Adapter.AutoPosY(232))
		},
		{
			normalImage = "ui/home/home_010.png",
			clickAction = function()
				print("HomeScene:enterRefineScene")
				GuideLayer:stepDone(TaskEntryType.eRefining, 1)
				GuideLayer:stepDone(TaskEntryType.eRefining, 2)
				game.enterRefineScene()
			end,
			position = ccp(Adapter.AutoPosY(1738), Adapter.AutoPosY(341))
		},
		{
			normalImage = "ui/home/home_011.png",
			clickAction = function()
				arg_2_0:onShenDianClicked()
			end,
			position = ccp(Adapter.AutoPosY(336), Adapter.AutoPosY(397))
		},
		{
			normalImage = "ui/home/home_013.png",
			clickAction = function()
				game.enterTSCaveScene()
			end,
			position = ccp(Adapter.AutoPosY(1117), Adapter.AutoPosY(292))
		},
		{
			normalImage = "ui/home/home_014.png",
			clickAction = function()
				local var_8_0 = require("scenes.PK.PKHomeLayer").new()

				arg_2_0:addChild(var_8_0, var_0_2)
			end,
			position = ccp(Adapter.AutoPosY(830), Adapter.AutoPosY(385))
		},
		{
			normalImage = "ui/home/home_015.png",
			clickAction = function()
				game.enterTransportScene()
			end,
			position = ccp(Adapter.AutoPosY(1439), Adapter.AutoPosY(281))
		}
	}
	local var_2_7 = {
		x = 0,
		y = 0
	}
	local var_2_8 = {
		x = 0,
		y = 0
	}

	local function var_2_9(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == "began" then
			arg_2_0.parallaxNode:stopAllActions()

			if CCRect(Adapter.AutoPosX(80), Adapter.AutoPosY(115), Adapter.AutoWidth(773), Adapter.AutoHeight(430)):containsPoint(CCPoint(arg_10_1, arg_10_2)) == true then
				var_2_8.x = arg_10_1
				var_2_8.y = arg_10_2
				var_2_7.x = arg_10_1
				var_2_7.y = arg_10_2

				return true
			else
				return false
			end
		elseif arg_10_0 == "moved" then
			local var_10_0 = arg_10_1 - var_2_8.x
			local var_10_1 = arg_10_2 - var_2_8.y

			var_2_8.x = arg_10_1
			var_2_8.y = arg_10_2

			local var_10_2, var_10_3 = arg_2_0.parallaxNode:getPosition()
			local var_10_4 = var_10_2 + var_10_0

			if var_10_4 > 0 then
				var_10_4 = 0
			end

			local var_10_5 = display.width - 1920 * Adapter.HeightScale

			if var_10_4 < var_10_5 then
				var_10_4 = var_10_5
			end

			local var_10_6 = game.homeOffset

			var_10_6.x, var_10_6.y = var_10_4, var_10_3

			arg_2_0.parallaxNode:setPosition(var_10_6)
		elseif arg_10_0 == "ended" then
			local var_10_7, var_10_8 = arg_2_0.parallaxNode:getPosition()
			local var_10_9 = (arg_10_1 - var_2_7.x) / 4 + var_10_7

			if var_10_9 > 0 then
				var_10_9 = -10
			end

			local var_10_10 = display.width - 1920 * Adapter.HeightScale

			if var_10_9 < var_10_10 then
				var_10_9 = var_10_10 + 10
			end

			local var_10_11 = game.homeOffset

			var_10_11.x, var_10_11.y = var_10_9, var_10_8

			local var_10_12 = CCMoveTo:create(0.4, var_10_11)

			arg_2_0.parallaxNode:stopAllActions()
			arg_2_0.parallaxNode:runAction(var_10_12)
		end
	end

	arg_2_0.maskLayer = CCLayer:create()

	arg_2_0.maskLayer:addTouchEventListener(var_2_9, false, -128, false)
	arg_2_0.maskLayer:setTouchEnabled(true)
	arg_2_0.bg_near_layer:addChild(arg_2_0.maskLayer)

	local var_2_10 = {
		"uilocal/home/home_text_007.png",
		"uilocal/home/home_text_001.png",
		"uilocal/home/home_text_002.png",
		"uilocal/home/home_text_027.png",
		"uilocal/home/home_text_003.png",
		"uilocal/home/home_text_004.png",
		"uilocal/home/home_text_006.png"
	}
	local var_2_11 = {
		"uilocal/home/home_text_011.png",
		"",
		"uilocal/home/home_text_017.png",
		"uilocal/home/home_text_010.png",
		"uilocal/home/home_text_025.png",
		"",
		"uilocal/home/home_text_009.png"
	}
	local var_2_12 = {
		GameFeatures.eTower,
		0,
		GameFeatures.eRefine,
		GameFeatures.eFuBen,
		GameFeatures.eQiShuHealth,
		0,
		GameFeatures.eTransport
	}
	local var_2_13 = {
		{
			x = 200,
			y = 148
		},
		{
			x = 125,
			y = 57
		},
		{
			x = 110,
			y = 30
		},
		{
			x = 110,
			y = 18
		},
		{
			x = 148,
			y = 185
		},
		{
			x = 105,
			y = 17
		},
		{
			x = 145,
			y = 70
		}
	}

	table.foreach(var_2_6, function(arg_11_0, arg_11_1)
		arg_11_1.scaleX = Adapter.AutoScaleY
		arg_11_1.scaleY = Adapter.AutoScaleY

		local var_11_0 = ui.newControlButton(arg_11_1)

		arg_2_0.maskLayer:addChild(var_11_0)
		table.insert(arg_2_0.mainButtonInfos, var_11_0)

		local var_11_1 = var_11_0:getContentSize()

		if arg_11_0 == 2 then
			local var_11_2 = createFrameAnimation({
				loop = true,
				delta = 0.15,
				list = {
					"ui/home/bianshe01.png",
					"ui/home/bianshe02.png",
					"ui/home/bianshe03.png",
					"ui/home/bianshe04.png",
					"ui/home/bianshe05.png"
				}
			})

			var_11_2:setPosition(ccp(var_11_1.width / 2, var_11_1.height / 2))
			var_11_0:addChild(var_11_2)
			var_11_2:setScale(Adapter.MinScale)
		end

		local var_11_3 = display.newSprite(var_2_10[arg_11_0], var_11_1.width / 2, var_11_1.height / 2)

		var_11_3:setScale(Adapter.AutoScaleY)
		var_11_3:setPosition(Adapter.AutoPos(var_2_13[arg_11_0].x, var_2_13[arg_11_0].y))
		var_11_0:addChild(var_11_3)

		if var_2_12[arg_11_0] > 0 and GameFeaturesLevel[var_2_12[arg_11_0]].level > Player.level then
			local var_11_4 = display.newSprite(var_2_11[arg_11_0])

			var_11_4:setScale(Adapter.AutoScaleY)
			var_11_4:setPosition(Adapter.AutoPos(var_2_13[arg_11_0].x, var_2_13[arg_11_0].y - 30))
			var_11_0:addChild(var_11_4)
		end
	end)

	arg_2_0.player_info_layer = arg_2_0:createPlayerStatusLayer()

	arg_2_0.player_info_layer:setPosition(ccp(Adapter.MinPosX(185), display.top - Adapter.MinPosY(50)))
	arg_2_0:addChild(arg_2_0.player_info_layer, 1)
	arg_2_0:setPlayerAvatar(Player.headerTeamIndex)

	local var_2_14 = createPlayerAttrNode({
		ItemType.eDoubleExpTime
	}, nil, true, {
		ItemType.eDoubleExpTime
	})

	var_2_14:setPosition(ccp(Adapter.MinPosX(38), display.top - Adapter.MinPosY(182)))
	arg_2_0:addChild(var_2_14)

	local var_2_15 = arg_2_0:create_extend_menu()

	var_2_15:setPosition(ccp(0, Adapter.MinHeight(15)))
	arg_2_0:addChild(var_2_15)

	local var_2_16 = arg_2_0:create_top_menu()

	var_2_16:setPosition(Adapter.AutoPos(905, 593))
	arg_2_0:addChild(var_2_16)

	local var_2_17 = arg_2_0:createLeftMenu()

	var_2_17:setPosition(Adapter.AutoPos(40, 50))
	arg_2_0:addChild(var_2_17)
	arg_2_0:createPlayerExp()
	arg_2_0:initRequests()

	local var_2_18 = var_0_0.getCurrentDate().day

	if Player.missionData == nil or var_2_18 ~= Player.missionTime then
		Player.missionData = nil

		arg_2_0.missionInfoRequest:request()
	else
		arg_2_0:showCanDoAnimations()
	end

	if arg_2_1 then
		if arg_2_1.showSubLayer == ShowSubLayerType.ePKHome then
			local var_2_19 = require("scenes.PK.PKHomeLayer").new()

			arg_2_0:addChild(var_2_19, var_0_2)
		elseif arg_2_1.showSubLayer == ShowSubLayerType.eCopyHome then
			arg_2_0:onShenDianClicked()
		end
	end
end

function var_0_3.showCanDoAnimations(arg_12_0)
	local var_12_0 = ""

	if Player.csHaveTime == 0 then
		var_12_0 = "ui/PK/PK_056.png"
	elseif Player.duelObject and Player.duelObject.Last > 0 then
		var_12_0 = "ui/slave/slave_014.png"
	elseif Player.darkHouse and Player.darkHouse.CanCapture and Player.darkHouse.Last > 0 then
		var_12_0 = "ui/slave/slave_015.png"
	end

	local var_12_1 = false
	local var_12_2 = ""
	local var_12_3 = Player:getTransportState()

	if var_12_3 == 1 then
		var_12_1 = true
		var_12_2 = "ui/home/home_066.png"
	elseif var_12_3 == 3 then
		var_12_1 = true
		var_12_2 = "ui/home/home_067.png"
	end

	local var_12_4 = {
		"ui/slave/slave_014.png",
		"",
		"",
		"ui/shenqi/sq_062.png",
		"ui/slave/slave_014.png",
		var_12_0,
		var_12_2
	}
	local var_12_5 = {
		{
			x = 100,
			y = 350
		},
		{
			x = 115,
			y = 110
		},
		{
			x = 125,
			y = 95
		},
		{
			x = 110,
			y = 150
		},
		{
			x = 125,
			y = 280
		},
		{
			x = 100,
			y = 120
		},
		{
			x = 140,
			y = 200
		}
	}
	local var_12_6 = {
		{
			canShow = false and true or false
		},
		{
			canShow = false
		},
		{
			canShow = false
		},
		{
			canShow = Player.shenQiTimes and Player.shenQiTimes.ATimes >= 10
		},
		{
			canShow = false and true or false
		},
		{
			canShow = string.len(var_12_0) > 0
		},
		{
			canShow = var_12_1
		}
	}

	for iter_12_0 = 1, table.nums(arg_12_0.mainButtonInfos) do
		local var_12_7 = arg_12_0.mainButtonInfos[iter_12_0]
		local var_12_8 = var_12_7:getContentSize()
		local var_12_9 = var_12_4[iter_12_0]
		local var_12_10 = var_12_5[iter_12_0].x
		local var_12_11 = var_12_5[iter_12_0].y

		if #var_12_9 > 0 and var_12_6[iter_12_0].canShow == true then
			local var_12_12 = display.newSprite(var_12_9, var_12_8.width / 2, var_12_8.height / 2)

			var_12_12:setScale(Adapter.AutoScaleY)
			var_12_12:setPosition(Adapter.AutoPos(var_12_10, var_12_11))
			var_12_7:addChild(var_12_12)

			local var_12_13 = CCArray:create()

			var_12_13:addObject(CCMoveTo:create(1, Adapter.AutoPos(var_12_10, var_12_11 + 20)))
			var_12_13:addObject(CCMoveTo:create(1, Adapter.AutoPos(var_12_10, var_12_11)))
			var_12_12:runAction(CCRepeatForever:create(CCSequence:create(var_12_13)))
		end
	end
end

function var_0_3.initRequests(arg_13_0)
	local function var_13_0()
		arg_13_0:showCanDoAnimations()
		Notification:postNotification(PalyerEvents.eHaveTaskReward)
		Notification:postNotification(PalyerEvents.eHomeTaskNotice)
	end

	arg_13_0.missionInfoRequest = MissionInfoRequest:new(arg_13_0)

	arg_13_0.missionInfoRequest:setResponseNormalHandler(var_13_0)
end

function var_0_3.onEnter(arg_15_0)
	print("init mission data")

	if arg_15_0.showHomeGuideArrow == true then
		arg_15_0:showHomeGuideLayer()
	else
		Player.currentTaskEntryType = 0
		Player.currentTaskStep = 0
		Player.currentMissionStageID = nil
	end

	local var_15_0 = Player:getTroMaxStep()

	if var_15_0 == NSStep.XuanJiang then
		GuideLayer:showNewbieGuideLayer(arg_15_0, arg_15_0, 1, function()
			game.enterStoreScene()

			return true
		end)
	end

	if var_15_0 == NSStep.ZhaoJiang or var_15_0 == NSStep.ZhanYi1 or var_15_0 == NSStep.ZhanYi2 or var_15_0 == NSStep.ZhanYi3 or var_15_0 == NSStep.ZhanYi4 or var_15_0 == NSStep.DuanZao2 or var_15_0 == NSStep.ZhanYi5 or var_15_0 == NSStep.ZhanYi6 then
		arg_15_0.parallaxNode:setPosition(ccp(0, 0))
		GuideLayer:showNewbieGuideLayer(arg_15_0, arg_15_0.bg_near_Sprite, 6, function()
			game.enterMapChapterScene({
				stageId = 10010
			})

			return true
		end)
	end

	if var_15_0 == NSStep.ZhanYi4Reward or var_15_0 == NSStep.HuanZhuangbei or var_15_0 == NSStep.DuanZao1 or var_15_0 == NSStep.ZhanYi6Reward then
		GuideLayer:showNewbieGuideLayer(arg_15_0, arg_15_0, 17, function()
			game.enterTeamScene({
				pageType = 1
			})

			return true
		end)
	end

	if arg_15_0.changeHeroIndex ~= nil then
		GuideLayer:showNewbieGuideLayer(arg_15_0, arg_15_0, 271, function()
			game.enterTeamScene({
				pageType = 1,
				changeHeroIndex = arg_15_0.changeHeroIndex
			})

			return true
		end)

		return
	end

	if arg_15_0.showGuideArrow == true then
		Player.currentTaskEntryType = TaskEntryType.eShowEverydayTask
		Player.currentTaskStep = 1

		GuideLayer:showGuideLayer(arg_15_0, arg_15_0, TaskEntryType.eShowEverydayTask, 1, nil, true)
	end

	if arg_15_0.showTaskLayer == true or arg_15_0.taskEntryType ~= nil then
		local var_15_1 = require("scenes.home.HomeTaskLayer").new({
			homeScene = arg_15_0,
			showGuideArrow = arg_15_0.showGuideArrow,
			taskEntryType = arg_15_0.taskEntryType
		})

		arg_15_0:addChild(var_15_1, var_0_2)
	end
end

function var_0_3.showPlayerInfo(arg_20_0)
	local var_20_0 = require("scenes.home.PlayerInfoLayer").new({
		callback = function(arg_21_0)
			arg_20_0:setPlayerAvatar(arg_21_0)
		end
	})

	var_20_0:setPosition(5, Adapter.MinPosY(45))
	arg_20_0:addChild(var_20_0)
end

function var_0_3.setPlayerAvatar(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.player_info_layer
	local var_22_1 = var_22_0.avatarButton

	if var_22_1 then
		var_22_1:removeFromParent()
	end

	local var_22_2 = Player.team.groupList[arg_22_1].heroId
	local var_22_3 = getItemHeaderImagePath(ItemType.eHero, var_22_2)
	local var_22_4 = ui.newControlButton({
		normalImage = var_22_3,
		clickAction = function()
			arg_22_0:showPlayerInfo()
		end
	})

	var_22_4:setPosition(50, 50)
	var_22_0:addChild(var_22_4)

	var_22_0.avatarButton = var_22_4
end

function var_0_3.createPlayerStatusLayer(arg_24_0)
	local var_24_0 = display.newSprite("ui/home/home_047.png")

	var_24_0:setScale(Adapter.MinScale)

	local var_24_1 = require("scenes.ProgressBar").new({
		backImage = "ui/home/home_050.png",
		backSize = CCSize(214, 20),
		barSize = CCSize(214, 20),
		barImages = {
			"ui/home/home_049.png"
		},
		barPosition = ccp(-107, 1),
		curValue = Player.curPower,
		totalValue = Player.maxPower,
		labelColor = ccc3(193, 253, 248)
	})

	var_24_1:setPosition(ccp(233, 24))
	var_24_0:addChild(var_24_1)

	local var_24_2 = display.newSprite("ui/home/home_051.png", 240, 23.5)

	var_24_0:addChild(var_24_2)

	local var_24_3 = string.format("LV%d %s", Player.level, Player.nickName)
	local var_24_4 = CCLabelTTF:create(var_24_3, _FONT_DEFAULT, Adapter.FontSize(20))

	var_24_4:setHorizontalAlignment(kCCTextAlignmentCenter)
	var_24_4:setAnchorPoint(ccp(0, 0.5))
	var_24_4:setPosition(ccp(105, 79))
	var_24_4:setColor(ccc3(241, 250, 140))
	var_24_0:addChild(var_24_4)

	local var_24_5 = CCLabelTTF:create("VIP " .. Player.vipLevel, _FONT_DEFAULT, Adapter.FontSize(18))

	var_24_5:setPosition(ccp(129, 50))
	var_24_5:setColor(ccc3(254, 222, 9))
	var_24_0:addChild(var_24_5)

	if Player:getServerVipEnable() == 0 then
		var_24_5:setOpacity(0)
	end

	local var_24_6 = ui.newControlButton({
		normalImage = "ui/home/home_069.png",
		position = ccp(193, 51),
		clickAction = function()
			game.enterStoreRechargeScene({
				from = "HomeSceneNormal"
			})
		end
	})

	var_24_0:addChild(var_24_6)

	local var_24_7 = createItemCountNode({
		isOutline = true,
		scale = 0.9,
		type = ItemType.eGold,
		value = Player.curGold,
		color = ccc3(241, 252, 203)
	})

	var_24_7:setPosition(ccp(220, 51))
	var_24_0:addChild(var_24_7)

	local var_24_8 = createItemCountNode({
		isOutline = true,
		scale = 0.9,
		type = ItemType.eCoin,
		value = Player.curCoin,
		color = ccc3(241, 252, 203)
	})

	var_24_8:setPosition(ccp(325, 51))
	var_24_0:addChild(var_24_8)

	local var_24_9 = ui.newControlButton({
		normalImage = "ui/home/home_046.png",
		position = ccp(363, 24),
		clickAction = function(arg_26_0, arg_26_1)
			game.enterStoreScene({
				defaultPage = StoreType.eStoreProp
			})
		end
	})

	var_24_0:addChild(var_24_9)

	local var_24_10 = CCSprite:create("ui/home/home_045.png")

	var_24_10:setScale(0.6)
	var_24_10:setPosition(ccp(135, -20))
	var_24_0:addChild(var_24_10)

	local var_24_11 = CCSprite:create("uilocal/home/home_text_000.png")

	var_24_11:setPosition(ccp(85, -20))
	var_24_0:addChild(var_24_11)

	local var_24_12 = CCLabelAtlas:create(tostring(Player.team.battlePower), "ui/home/home_000_small.png", 22, 33, 48, 6)

	var_24_12:setAnchorPoint(ccp(0, 0.5))
	var_24_12:setPosition(ccp(145, -20))
	var_24_0:addChild(var_24_12)
	addObserverToNode(var_24_0, function()
		var_24_1:setProgressValue(1, Player.curPower, Player.maxPower)
		var_24_4:setString(string.format("LV%d %s", Player.level, Player.nickName))
		var_24_7:setValue(tostring(Player.curGold))
		var_24_8:setValue(tostring(Player.curCoin))
		var_24_5:setString("VIP " .. Player.vipLevel)
	end, {
		PalyerEvents.eCoin,
		PalyerEvents.eGold,
		PalyerEvents.eCurPower,
		PalyerEvents.eNickName,
		PalyerEvents.eVIPLevel,
		PalyerEvents.eLevel
	})

	return var_24_0
end

function var_0_3.createPlayerExp(arg_28_0)
	local var_28_0 = display.newSprite("ui/home/home_019_1.png")

	var_28_0:setScale(Adapter.MinScale)
	var_28_0:setAnchorPoint(ccp(0, 0))

	local var_28_1 = var_28_0:getContentSize()
	local var_28_2 = Adapter.MinWidth(var_28_1.width)
	local var_28_3 = Adapter.MinHeight(var_28_1.height)
	local var_28_4 = display.width - var_28_2
	local var_28_5 = require("scenes.ProgressBar").new({
		backImage = "ui/home/home_019_2.png",
		backSize = CCSize(var_28_4, Adapter.MinHeight(15)),
		barSize = CCSize(var_28_4, Adapter.MinHeight(11)),
		barImages = {
			"ui/home/home_019_4.png"
		},
		barPosition = ccp(-var_28_4 / 2, 0),
		percent = Player.curExp / Player.levelUpExp
	})

	var_28_5:setPosition(ccp(display.cx + var_28_2 / 2, var_28_3 / 2))
	arg_28_0:addChild(var_28_5)

	for iter_28_0 = 1, 10 do
		local var_28_6 = display.newSprite("ui/home/home_019_3.png", var_28_4 * (iter_28_0 - 1) / 10 + var_28_2, var_28_3 / 2 + 1)

		var_28_6:setAnchorPoint(ccp(0, 0.5))
		arg_28_0:addChild(var_28_6)
	end

	arg_28_0:addChild(var_28_0)

	local var_28_7 = ui.newTTFLabelWithOutline({
		text = Player.curExp .. "/" .. Player.levelUpExp,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(14)
	})

	var_28_7:setColor(ccc3(255, 255, 255))
	var_28_7:setPosition(ccp(display.cx + var_28_2 / 2 - 50, var_28_3 / 2))
	arg_28_0:addChild(var_28_7)
	addObserverToNode(var_28_0, function()
		var_28_5:setProgressPercent(1, Player.curExp / Player.levelUpExp)
		var_28_7:setString(Player.curExp .. "/" .. Player.levelUpExp)
	end, {
		PalyerEvents.eExp
	})
end

function var_0_3.create_extend_menu(arg_30_0)
	local var_30_0 = CCLayer:create()

	arg_30_0.isView = true

	local var_30_1 = Adapter.AutoPos(912, 45)
	local var_30_2 = display.newScale9Sprite("ui/home/home_043.png", 0, 0, CCSize(display.width, Adapter.MinPosX(129)))

	var_30_2:setAnchorPoint(ccp(0, 0))
	var_30_0:addChild(var_30_2)

	local var_30_3 = CCClippingRegionNode:create(CCRect(0, 0, var_30_1.x, var_30_1.y * 2.5))

	var_30_0:addChild(var_30_3)

	local var_30_4 = CCNode:create()

	var_30_3:addChild(var_30_4)

	local var_30_5 = {
		{
			normalImage = "ui/home/home_068.png",
			clickAction = handler(arg_30_0, arg_30_0.onGuildButtonClicked),
			actionShowFunc = function()
				return Player.guildStatus
			end,
			eventName = PalyerEvents.eGuildStatus
		},
		{
			normalImage = "ui/home/home_032.png",
			clickAction = function()
				game.enterTeamScene({})
			end
		},
		{
			normalImage = "ui/home/home_030.png",
			clickAction = function()
				game.enterEnhanceScene({
					from = "equipscene"
				})
			end,
			actionShowFunc = function()
				return Player.isFragmentCanMixture
			end,
			eventName = PalyerEvents.eFragmentCanMixture
		},
		{
			normalImage = "ui/home/home_058.png",
			clickAction = function()
				game.enterHeroScene()
			end,
			actionShowFunc = function()
				return Player.isHeroSoulCanRecruit
			end,
			eventName = PalyerEvents.eHeroSoulCanRecruit
		},
		{
			normalImage = "ui/home/home_031.png",
			clickAction = function()
				game.enterBagScene()
			end
		},
		{
			normalImage = "ui/home/home_033.png",
			clickAction = function()
				game.enterFriendScene()
			end,
			actionShowFunc = function()
				return (Player.friendRequestCnt or 0) > 0
			end,
			eventName = PalyerEvents.eFriendRequest
		},
		{
			normalImage = "ui/home/home_064.png",
			clickAction = function()
				if Player.level < 80 then
					showFlashNotice(string.lf("您尚未达到%d级，无法使用宝石。", 80))

					return
				end

				game.enterMineralScene()
			end
		}
	}
	local var_30_6 = 273
	local var_30_7 = 90

	table.foreach(var_30_5, function(arg_41_0, arg_41_1)
		arg_41_1.scaleX = Adapter.MinScale
		arg_41_1.scaleY = Adapter.MinScale
		arg_41_1.position = Adapter.AutoPos(var_30_6, 48)

		local var_41_0 = ui.newControlButton(arg_41_1)

		var_30_4:addChild(var_41_0)

		arg_30_0.tableExtendButton[arg_41_0] = var_41_0

		arg_30_0:addButtonAutoActionShow(var_41_0, arg_41_1)

		var_30_6 = var_30_6 + var_30_7
	end)

	local var_30_8 = 0.75

	local function var_30_9(arg_42_0, arg_42_1)
		var_30_4:stopAllActions()

		arg_30_0.isView = not arg_30_0.isView

		if arg_30_0.isView then
			local var_42_0 = CCArray:create()
			local var_42_1, var_42_2 = var_30_4:getPosition()

			var_30_4:runAction(CCEaseBackOut:create(CCMoveTo:create(var_30_8, Adapter.AutoPos(0, 0))))
			var_30_2:runAction(CCMoveTo:create(var_30_8 / 2, ccp(0, 0)))
		else
			local var_42_3 = CCArray:create()
			local var_42_4, var_42_5 = var_30_4:getPosition()

			var_30_4:runAction(CCEaseBackOut:create(CCMoveTo:create(var_30_8, Adapter.AutoPos(var_30_7 * (table.getn(var_30_5) + 1), 0))))

			local var_42_6 = var_30_2:getContentSize()

			var_30_2:runAction(CCMoveTo:create(var_30_8 / 2, ccp(0, -var_42_6.height)))
		end

		arg_30_0.packButton:runAction(CCRotateTo:create(var_30_8 / 2, arg_30_0.isView and 135 or 0))
	end

	arg_30_0.packButton = ui.newControlButton({
		normalImage = "ui/home/home_042.png",
		clickAction = var_30_9,
		position = var_30_1,
		scaleX = Adapter.MinScale,
		scaleY = Adapter.MinScale
	})

	arg_30_0.packButton:setRotation(135)
	var_30_0:addChild(arg_30_0.packButton)

	arg_30_0._packButtonClickAction = var_30_9

	return var_30_0
end

function var_0_3.create_right_extend_menu(arg_43_0)
	local var_43_0 = {}

	if Player.isOpenDestiny > 0 and Player.level >= GameFeaturesLevel[GameFeatures.eMysticStore].level then
		table.insert(var_43_0, {
			normalImage = "ui/home/home_070.png",
			clickAction = function()
				game.enterTianmingRecruitScene()
			end,
			actionShowFunc = function()
				return false
			end
		})
	end

	if Player.level >= GameFeaturesLevel[GameFeatures.eXunfang].level and Player.systemOpenControllers.IsShowXunFang and Player.systemOpenControllers.IsShowXunFang > 0 then
		table.insert(var_43_0, {
			normalImage = "ui/home/home_072.png",
			clickAction = function()
				game.enterXunfangScene({})
			end
		})
	end

	local var_43_1 = CCLayer:create()
	local var_43_2 = CCClippingRegionNode:create(CCRect(display.width - 92 * Adapter.WidthScale, 45 * Adapter.HeightScale, display.width, display.height))

	var_43_1:addChild(var_43_2)

	local var_43_3 = display.newNode()

	var_43_2:addChild(var_43_3)

	local var_43_4 = 90

	for iter_43_0, iter_43_1 in ipairs(var_43_0) do
		iter_43_1.scaleX = Adapter.MinScale
		iter_43_1.scaleY = Adapter.MinScale
		iter_43_1.position = Adapter.AutoPos(912, 138 + var_43_4 * (iter_43_0 - 1))

		local var_43_5 = ui.newControlButton(iter_43_1)

		var_43_3:addChild(var_43_5)

		arg_43_0.tableExtendButton[iter_43_0] = var_43_5

		arg_43_0:addButtonAutoActionShow(var_43_5, iter_43_1)
	end

	local var_43_6 = false

	function var_43_1.showButtons(arg_47_0, arg_47_1)
		local var_47_0 = 0.75

		var_43_3:stopAllActions()

		if arg_47_1 ~= true then
			local var_47_1, var_47_2 = var_43_3:getPosition()

			var_43_3:runAction(CCEaseBackOut:create(CCMoveTo:create(var_47_0, Adapter.AutoPos(0, -45 - 92 * #var_43_0))))
		else
			local var_47_3, var_47_4 = var_43_3:getPosition()

			var_43_3:runAction(CCEaseBackOut:create(CCMoveTo:create(var_47_0, ccp(0, 0))))

			var_43_6 = false
		end
	end

	return var_43_1
end

function var_0_3.create_top_menu(arg_48_0)
	local var_48_0 = display.newLayer()
	local var_48_1 = {
		{
			normalImage = "ui/home/home_071.png",
			clickAction = function()
				game.enterWorldBossHomeScene()
			end,
			position = Adapter.MinPos(-115, 0),
			actionShowFunc = function()
				return Player:getWorldBossTip() > 0
			end,
			eventName = PalyerEvents.eWorldBossTip
		},
		{
			normalImage = "ui/home/home_038.png",
			clickAction = function()
				game.enterZhaoCaiFuScene()
			end,
			position = Adapter.MinPos(-215, 0),
			actionShowFunc = function()
				return Player.zhaoCaiFuCount > 0
			end,
			eventName = PalyerEvents.eZhaoCaiFuNotice
		},
		{
			normalImage = "ui/home/home_040.png",
			clickAction = function()
				game.enterActivityScene({})
			end,
			position = Adapter.MinPos(-315, 0),
			actionShowFunc = function()
				return Player.activityCenterCount > 0
			end,
			eventName = PalyerEvents.eActivityCenterNotice
		}
	}

	if Player.firstRechargeCount > 0 then
		table.insert(var_48_1, {
			normalImage = "ui/home/home_034.png",
			clickAction = function()
				game.enterActivityScene({
					type = ActivityType.eFirstRecharge
				})
			end,
			position = Adapter.MinPos(-420, 0),
			actionShowFunc = function()
				return Player.firstRechargeCount > 0
			end,
			eventName = PalyerEvents.eFirstRechargeNotice
		})
	elseif Player.signMonthCount > 0 then
		table.insert(var_48_1, {
			normalImage = "ui/home/home_039.png",
			clickAction = function()
				game.enterActivityScene({
					type = ActivityType.eSignMonth
				})
			end,
			position = Adapter.MinPos(-420, 0),
			actionShowFunc = function()
				return Player.signMonthCount > 0
			end,
			eventName = PalyerEvents.eSignMonthNotice
		})
	else
		table.insert(var_48_1, {
			normalImage = "ui/home/home_078.png",
			clickAction = function()
				game.enterStoreRechargeScene()
			end,
			position = Adapter.MinPos(-420, 0)
		})
	end

	table.insert(var_48_1, {
		normalImage = "ui/home/home_041.png",
		clickAction = function()
			local var_60_0 = require("scenes.home.HomeTaskLayer").new({
				homeScene = arg_48_0,
				showGuideArrow = arg_48_0.showGuideArrow
			})

			arg_48_0:addChild(var_60_0, var_0_2)
		end,
		position = Adapter.MinPos(-5, -10),
		actionShowFunc = function()
			local var_61_0 = false

			if Player.level < 10 and Player.level >= 5 then
				var_61_0 = true
			end

			return var_61_0
		end,
		eventName = PalyerEvents.eHomeTaskNotice
	})
	table.insert(var_48_1, {
		normalImage = "ui/home/home_036.png",
		clickAction = function()
			Player.isStoreHasFreeHero = 0

			game.enterStoreScene()
		end,
		position = Adapter.MinPos(-5, -125),
		actionShowFunc = function()
			return Player.isStoreHasFreeHero > 0
		end,
		eventName = PalyerEvents.eStoreHasFreeHero
	})

	local var_48_2 = -235

	if Player.level >= GameFeaturesLevel[GameFeatures.eMysticStore].level then
		table.insert(var_48_1, {
			normalImage = "ui/enhance/enhance_012.png",
			clickAction = function()
				Player.isMysteryStoreRefresh = 0

				game.enterMysticStoreScene()
			end,
			position = Adapter.MinPos(0, var_48_2),
			actionShowFunc = function()
				return Player.isMysteryStoreRefresh > 0
			end,
			eventName = PalyerEvents.eMisteryStoreRefreshed
		})

		var_48_2 = var_48_2 - 110
	end

	table.insert(var_48_1, {
		normalImage = "ui/home/home_029.png",
		clickAction = function()
			arg_48_0:addChild(require("scenes.system.SystemLayer").new(), var_0_2)
		end,
		position = Adapter.MinPos(0, var_48_2)
	})
	table.foreach(var_48_1, function(arg_67_0, arg_67_1)
		arg_67_1.scaleX = Adapter.MinScale
		arg_67_1.scaleY = Adapter.MinScale

		local var_67_0 = ui.newControlButton(arg_67_1)

		var_48_0:addChild(var_67_0)

		if arg_67_1.eventName == PalyerEvents.eHomeTaskNotice then
			setMissionStateAnimation(var_67_0)
			addObserverToNode(var_48_0, function()
				setMissionStateAnimation(var_67_0)
			end, {
				PalyerEvents.eHaveTaskReward
			})
		end

		arg_48_0:addButtonAutoActionShow(var_67_0, arg_67_1)
	end)

	return var_48_0
end

function var_0_3.addButtonAutoActionShow(arg_69_0, arg_69_1, arg_69_2)
	if arg_69_2.actionShowFunc and (Player.level >= 10 or arg_69_2.eventName == PalyerEvents.eHomeTaskNotice) then
		local var_69_0 = arg_69_1:getPreferredSize()
		local var_69_1 = ui.createRedPoint({
			parent = arg_69_1,
			position = ccp(var_69_0.width * 0.8, var_69_0.height * 0.75),
			scale = 0.7 * Adapter.MinScale
		})

		var_69_1:setVisible(arg_69_2.actionShowFunc())
		addObserverToNode(var_69_1, function()
			var_69_1:setVisible(arg_69_2.actionShowFunc())
		end, {
			arg_69_2.eventName
		})
	end
end

function var_0_3.showRankInfo(arg_71_0)
	local var_71_0 = require("scenes.home.RankingHomeLayer"):create()

	var_71_0:setPosition(0, 0)

	if var_71_0 ~= nil then
		arg_71_0:addChild(var_71_0, DefaultZOrder.eGameAnnounce)
	end
end

function var_0_3.createLeftMenu(arg_72_0)
	local var_72_0 = CCLayer:create()
	local var_72_1 = {
		{
			normalImage = "ui/guild/guild_047.png",
			clickAction = function()
				arg_72_0:showRankInfo()
			end,
			position = Adapter.MinPos(0, 180)
		},
		{
			normalImage = "ui/home/home_027.png",
			clickAction = function()
				game.enterAnnouncementScene()
			end,
			position = Adapter.MinPos(0, 110)
		},
		{
			normalImage = "ui/home/home_028.png",
			addMailNum = true,
			clickAction = function()
				game.enterMailScene()
			end,
			position = Adapter.MinPos(0, 40)
		}
	}

	table.foreach(var_72_1, function(arg_76_0, arg_76_1)
		arg_76_1.scaleX = Adapter.MinScale
		arg_76_1.scaleY = Adapter.MinScale

		local var_76_0 = ui.newControlButton(arg_76_1)

		var_72_0:addChild(var_76_0)

		if arg_76_1.addMailNum == true then
			local var_76_1 = arg_72_0:createUnreadMailNum()

			var_76_1:setPosition(Adapter.MinPos(68, 20))
			var_76_0:addChild(var_76_1)
		end
	end)

	return var_72_0
end

function var_0_3.createUnreadMailNum(arg_77_0)
	arg_77_0._unreadMailNumNode = createNumberWidthBgSprite("ui/friend/icon_indicator_bubble.png", Player.mailCount or 0)

	arg_77_0._unreadMailNumNode:setScale(Adapter.MinScale)

	local function var_77_0()
		arg_77_0._unreadMailNumNode.numLabel:setString(Player.mailCount or 0)

		if Player.mailCount == nil or Player.mailCount == 0 then
			arg_77_0._unreadMailNumNode:setVisible(false)
		else
			arg_77_0._unreadMailNumNode:setVisible(true)
		end
	end

	var_77_0()
	addObserverToNode(arg_77_0._unreadMailNumNode, var_77_0, {
		PalyerEvents.eMailCount
	})

	return arg_77_0._unreadMailNumNode
end

function var_0_3.showPackButton(arg_79_0)
	if arg_79_0.isView == true then
		return
	else
		arg_79_0._packButtonClickAction(nil, nil)
	end
end

function var_0_3.hidePackButton(arg_80_0)
	if arg_80_0.isView == false then
		return
	else
		arg_80_0._packButtonClickAction(nil, nil)
	end
end

function var_0_3.showHomeGuideLayer(arg_81_0)
	local var_81_0 = TaskEntryData[Player.currentTaskEntryType][Player.currentTaskStep].isInMaskLayer
	local var_81_1 = arg_81_0
	local var_81_2 = TaskEntryData[Player.currentTaskEntryType][Player.currentTaskStep].showPackButton

	if var_81_0 == true then
		var_81_1 = arg_81_0.maskLayer
		GuideLayer._homeGuideLayer = var_81_1

		local var_81_3 = TaskEntryData[Player.currentTaskEntryType][Player.currentTaskStep].pos
		local var_81_4 = display.width - 1920 * Adapter.HeightScale
		local var_81_5 = -var_81_3.x + display.width / 2

		if var_81_5 > 0 then
			var_81_5 = 0
		elseif var_81_5 < var_81_4 then
			var_81_5 = var_81_4
		end

		arg_81_0.parallaxNode:setPosition(ccp(var_81_5, 0))

		if display.getRunningScene().guideLayer ~= nil then
			display.getRunningScene().guideLayer:removeFromParentAndCleanup(true)

			display.getRunningScene().guideLayer = nil
		end
	elseif arg_81_0.maskLayer.guideLayer ~= nil then
		arg_81_0.maskLayer.guideLayer:removeFromParentAndCleanup(true)

		arg_81_0.maskLayer.guideLayer = nil
	end

	if var_81_2 == true then
		arg_81_0:showPackButton()
	end

	GuideLayer:showHomeGuideLayer(var_81_1, nil, true)
end

function var_0_3.onGuildButtonClicked(arg_82_0)
	if Player.isHaveGuild == true then
		game.enterGuildHomeScene()
	else
		local var_82_0 = GameFeaturesLevel[GameFeatures.eGuild].level

		if var_82_0 > Player.level then
			local var_82_1 = GameFeaturesLevel[GameFeatures.eGuild].name

			showFlashNotice(string.lf("您尚未达到%d级，无法进入%s。", var_82_0, var_82_1))
		else
			local var_82_2 = 500000
			local var_82_3 = var_82_0
			local var_82_4 = require("scenes.guild.GuildCreateLayer").new({
				createNeedCoin = var_82_2,
				createNeedLv = var_82_3,
				type = GuildCreateLayerType.eApplyGuild
			})

			arg_82_0:addChild(var_82_4, DefaultZOrder.ePopupLayer)
		end
	end
end

function var_0_3.onShenDianClicked(arg_83_0)
	local var_83_0 = require("scenes.PK.PKHomeLayer").new({
		type = 2
	})

	arg_83_0:addChild(var_83_0, var_0_2)
end

return var_0_3
