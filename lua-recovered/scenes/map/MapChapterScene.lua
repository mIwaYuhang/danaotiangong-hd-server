require("data.map")
require("scenes.home.HomeScene")

local var_0_0 = require("scenes.ToolLayer")

StarRewardType = {
	eGot = 1,
	eError = 0,
	eNone = 3,
	eCanGet = 2
}

local var_0_1 = require("scenes.map.PreviewBattleLayer")
local var_0_2 = class("MapChapterScene", function()
	return display.newScene("MapChapterScene")
end)

function var_0_2.ctor(arg_2_0, arg_2_1)
	arg_2_0.params = arg_2_1
	arg_2_0.isFirstClearChapter = arg_2_1.isFirstClearChapter
	arg_2_0.returnAction = arg_2_1.returnAction

	local var_2_0 = arg_2_1.stageId
	local var_2_1 = BaseStages[var_2_0]

	arg_2_0.chapterLayer = require("scenes.map.MapChapterLayer").new({
		stageId = var_2_0,
		mapScene = arg_2_0,
		showFirstClearCallBack = handler(arg_2_0, arg_2_0.calledByChapterLayer)
	})

	arg_2_0:addChild(arg_2_0.chapterLayer)

	arg_2_0.chapterId = var_2_1.chapterId

	arg_2_0:setButtons()

	function arg_2_0.getStagesByChapterId(arg_3_0)
		local var_3_0 = {}

		for iter_3_0, iter_3_1 in pairs(BaseStages) do
			if iter_3_1.chapterId == arg_3_0 then
				table.insert(var_3_0, iter_3_0)
			end
		end

		table.sort(var_3_0, function(arg_4_0, arg_4_1)
			return arg_4_0 < arg_4_1
		end)

		return var_3_0
	end

	function arg_2_0.getFirstDoubleStarOrThreeStarChapter()
		local var_5_0
		local var_5_1
		local var_5_2
		local var_5_3 = arg_2_0.getStagesByChapterId(arg_2_0.chapterId)

		for iter_5_0, iter_5_1 in ipairs(var_5_3) do
			for iter_5_2, iter_5_3 in ipairs(Player.taskInfo.Point) do
				if iter_5_3.PID == iter_5_1 and iter_5_3.Star < 3 then
					var_5_0 = iter_5_3

					break
				end
			end

			if var_5_0 ~= nil then
				break
			end
		end

		if var_5_0 then
			var_5_1, var_5_2 = var_5_0.PID, var_5_0.Star + 1
		end

		return var_5_1, var_5_2
	end

	if arg_2_0.getStagesByChapterId(arg_2_0.chapterId)[10] + 1 == Player.taskInfo.MaxPID then
		local var_2_2 = display.newSprite("uilocal/map/map_003.png")

		var_2_2:setAnchorPoint(ccp(0.5, 0.5))
		var_2_2:setPosition(Adapter.AutoPos(480, 520))
		var_2_2:setScale(Adapter.MinScale)
		arg_2_0:addChild(var_2_2)
	end

	local var_2_3 = createPlayerAttrNode({
		ItemType.ePower,
		ItemType.eCoin
	})

	var_2_3:setPosition(ccp(20, 578 * Adapter.HeightScale))
	arg_2_0:addChild(var_2_3)
	arg_2_0:showGuideLayer2()
end

function var_0_2.showFirstClearTips(arg_6_0, arg_6_1)
	local var_6_0 = display.newColorLayer(ccc4(0, 0, 0, 180))

	var_6_0:addTouchEventListener(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == "began" then
			return true
		end
	end, false, 1, true)
	var_6_0:setTouchEnabled(true)
	arg_6_0:addChild(var_6_0, DefaultZOrder.eTaskReward)

	local var_6_1 = display.newNode()

	var_6_0:addChild(var_6_1)
	var_6_1:setPosition(display.cx, display.cy)

	local var_6_2 = CCTextureCache:sharedTextureCache():addImage("ui/battle/battle_064.png"):getContentSize()
	local var_6_3 = display.newSprite("ui/battle/battle_064.png", 0, 0)

	var_6_3:setAnchorPoint(ccp(0.5, 0.3))
	var_6_3:setScale(Adapter.MinScale)
	var_6_1:addChild(var_6_3)

	local var_6_4 = string.lf("上仙，恭喜通关该地图，你已获得了至少10星了，继续挑战本章节可以获得更多的星星，就能领取其他宝箱了！")
	local var_6_5 = addLabelWithColorSize(var_6_3, var_6_4, ccc3(255, 255, 255), 20, ccp(0.5, 0), ccp(var_6_2.width / 2, 110))

	var_6_5:setHorizontalAlignment(ui.TEXT_ALIGN_LEFT)
	var_6_5:setDimensions(CCSizeMake(450, 100))

	local var_6_6 = ui.newControlButton({
		normalImage = "ui/common/common_105.png",
		titleImage = "uilocal/map/map_text_001.png",
		position = ccp(var_6_2.width / 2 - 110, 60),
		clickAction = function()
			Player.currentTaskEntryType = TaskEntryType.CheckPoint
			Player.currentTaskStep = 2

			local var_8_0, var_8_1 = arg_6_0.getFirstDoubleStarOrThreeStarChapter()

			if var_8_0 ~= nil and var_8_1 ~= nil then
				Player.currentMissionStageID = var_8_0
				Player.taskEntryCheckPointType = var_8_1

				arg_6_0:showGuideLayer()
			end

			var_6_0:removeFromParentAndCleanup(true)
		end
	})

	var_6_3:addChild(var_6_6)

	local var_6_7 = ui.newControlButton({
		normalImage = "ui/common/common_105.png",
		titleImage = "uilocal/map/map_text_002.png",
		position = ccp(var_6_2.width / 2 + 110, 60),
		clickAction = function()
			local var_9_0 = arg_6_0.chapterId + 1

			if BaseChapters[var_9_0] == nil then
				var_9_0 = arg_6_0.chapterId + 1000 - 9
			end

			print("newC:", var_9_0)

			local var_9_1 = arg_6_0.getStagesByChapterId(var_9_0)[1]

			Player.currentTaskEntryType = TaskEntryType.CheckPoint
			Player.currentTaskStep = 2
			Player.currentMissionStageID = var_9_1
			Player.taskEntryCheckPointType = TaskEntryCheckPointType.eNone

			if BaseChapters[var_9_0] then
				local var_9_2 = BaseChapters[var_9_0].worldType

				game.enterMapWorldScene(var_9_2)
			else
				showFlashNotice(string.lf("已是最后一章"))
			end
		end
	})

	var_6_3:addChild(var_6_7)

	if IPlatform:instance():getConfig("Channel") ~= "ZSY_TW" then
		local var_6_8 = ui.newControlButton({
			normalImage = "uilocal/common/common_text_016.png",
			anchorPoint = CCPoint(0.5, 0),
			position = Adapter.AutoPos(var_6_2.width / 2, -60),
			clickAction = function()
				if tonumber(EditionConfig.__Version) < 200 and IPlatform:instance():getConfig("Channel") ~= "ZSY_TW" then
					showFlashNotice(string.lf("该功能需要更新客户端后才能使用!"))
				else
					local var_10_0 = string.lf("超好玩“大闹天宫HD”，我在西游降魔路上所向披靡，勇闯天、地、人三界！刚刚我又顺利闯 关，获得了海量奖励。等你加入和我一起一闯到底！")
					local var_10_1 = require("scenes.team.DlgShareLayer").new({
						shareText = var_10_0
					})

					display.getRunningScene():addChild(var_10_1, DefaultZOrder.eTaskReward)
				end
			end,
			scaleX = Adapter.MinScale,
			scaleY = Adapter.MinScale
		})

		var_6_3:addChild(var_6_8)
	end

	var_6_1:setOpacity(0)
	var_6_1:setVisible(false)

	local var_6_9 = CCArray:create()
	local var_6_10 = 0.4

	var_6_9:addObject(CCCallFunc:create(function()
		var_6_1:setVisible(true)
	end))
	var_6_9:addObject(CCFadeIn:create(var_6_10))
	var_6_9:addObject(CCScaleTo:create(var_6_10, 1.05))
	transition.execute(var_6_1, transition.sequence({
		CCSpawn:create(var_6_9),
		CCScaleTo:create(0.1, 0.95),
		CCScaleTo:create(0.1, 1)
	}), {
		delay = 0.05
	})
end

function var_0_2.setButtons(arg_12_0)
	local function var_12_0(arg_13_0, arg_13_1)
		local var_13_0 = WorldType.eHeaven

		if arg_12_0.chapterId then
			var_13_0 = BaseChapters[arg_12_0.chapterId].worldType
		end

		game.enterMapWorldScene(var_13_0)
	end

	local function var_12_1(arg_14_0, arg_14_1)
		game.enterHomeScene()
	end

	local var_12_2 = ui.newControlButton({
		normalImage = "ui/common/common_061.png",
		preferredSize = CCSize(67, 66),
		position = Adapter.AutoPos(750, 50),
		clickAction = arg_12_0.returnAction or var_12_1,
		anchorPoint = CCPoint(0.5, 0.5),
		scaleX = Adapter.MinScale,
		scaleY = Adapter.MinScale
	})

	Adapter.NodeAbsScale(var_12_2)
	arg_12_0:addChild(var_12_2)

	arg_12_0.mapButton = ui.newControlButton({
		fontSize = 24,
		text = "",
		normalImage = "uilocal/map/map_001.png",
		preferredSize = CCSize(67, 66),
		position = Adapter.AutoPos(880, 50),
		clickAction = var_12_0,
		anchorPoint = CCPoint(0.5, 0.5),
		scaleX = Adapter.MinScale,
		scaleY = Adapter.MinScale
	})

	Adapter.NodeAbsScale(arg_12_0.mapButton)
	arg_12_0:addChild(arg_12_0.mapButton)

	local function var_12_3(arg_15_0, arg_15_1)
		local var_15_0 = require("scenes.home.HomeTaskLayer").new({
			mapChapterScene = true,
			homeScene = arg_12_0
		})

		arg_12_0:addChild(var_15_0, DefaultZOrder.ePopupLayer)
	end

	arg_12_0.taskButton = ui.newControlButton({
		fontSize = 24,
		text = "",
		normalImage = "ui/home/home_059.png",
		preferredSize = CCSize(67, 66),
		position = Adapter.AutoPos(850, 550),
		clickAction = var_12_3,
		anchorPoint = CCPoint(0.5, 0.5),
		scaleX = Adapter.MinScale,
		scaleY = Adapter.MinScale
	})

	Adapter.NodeAbsScale(arg_12_0.taskButton)
	arg_12_0:addChild(arg_12_0.taskButton)

	local var_12_4 = display.newNode()

	arg_12_0:addChild(var_12_4)
	setMissionStateAnimation(arg_12_0.taskButton)
	addObserverToNode(var_12_4, function()
		setMissionStateAnimation(arg_12_0.taskButton)
	end, {
		PalyerEvents.eHaveTaskReward
	})
end

function var_0_2.showGuideLayer(arg_17_0)
	if Player.currentTaskEntryType == TaskEntryType.CheckPoint and Player.currentMissionStageID then
		if arg_17_0.chapterId == BaseStages[Player.currentMissionStageID].chapterId then
			arg_17_0.chapterLayer:setCurrentStagePosition(Player.currentMissionStageID)
		else
			GuideLayer:showGuideLayer(arg_17_0, arg_17_0.mapButton, TaskEntryType.CheckPoint, 2, Adapter.AutoPos(40, 80), true)
		end
	end
end

function var_0_2.showGuideLayer2(arg_18_0)
	if Player.currentTaskEntryType == TaskEntryType.CheckPoint and Player.currentMissionStageID and arg_18_0.chapterId == BaseStages[Player.currentMissionStageID].chapterId then
		arg_18_0.chapterLayer:setCurrentStagePosition(Player.currentMissionStageID)
	end
end

function var_0_2.calledByChapterLayer(arg_19_0)
	if arg_19_0.isFirstClearChapter == true then
		arg_19_0.isFirstClearChapter = false

		arg_19_0:showFirstClearTips(arg_19_0.params)
	end
end

return var_0_2
