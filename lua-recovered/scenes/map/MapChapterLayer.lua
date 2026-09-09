require("data.map")

StarRewardType = {
	eGot = 1,
	eNone = 2,
	eCanGet = 0
}

local var_0_0 = require("scenes.map.PreviewBattleLayer")
local var_0_1 = class("MapChapterLayer", function()
	return display.newLayer()
end)

function var_0_1.getStagesByChapterId(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(BaseStages) do
		if iter_2_1.chapterId == arg_2_1 then
			table.insert(var_2_0, iter_2_0)
		end
	end

	table.sort(var_2_0, function(arg_3_0, arg_3_1)
		return arg_3_0 < arg_3_1
	end)

	return var_2_0
end

function var_0_1.ctor(arg_4_0, arg_4_1)
	arg_4_0.chapterButton = {}
	arg_4_0.buttons = {}
	arg_4_0.arrows = {}
	arg_4_0.effects = {}
	arg_4_0.callParentShowFirstClearTips = arg_4_1.showFirstClearCallBack
	arg_4_0.stageId = arg_4_1.stageId
	arg_4_0.mapScene = arg_4_1.mapScene
	arg_4_0.chapterId = BaseStages[arg_4_0.stageId].chapterId
	arg_4_0._mapBgSprite = CCScale9Sprite:create("ui/transport/transport_map.jpg")

	arg_4_0._mapBgSprite:setPreferredSize(CCSize(Adapter.AutoHeight(1920), Adapter.AutoHeight(640)))

	arg_4_0.chapterScrollView = CCScrollView:create(CCSize(display.width, display.height))

	arg_4_0.chapterScrollView:setDirection(kCCScrollViewDirectionHorizontal)
	arg_4_0.chapterScrollView:setBounceable(false)
	arg_4_0.chapterScrollView:setContentSize(CCSize(Adapter.AutoHeight(1920), display.height))
	arg_4_0.chapterScrollView:setContentOffset(arg_4_0.chapterScrollView:maxContainerOffset())
	arg_4_0:addChild(arg_4_0.chapterScrollView)

	local var_4_0 = display.newSprite("task/map/" .. BaseChapters[arg_4_0.chapterId].bigImage1)

	var_4_0:setScale(Adapter.AutoScaleY)
	arg_4_0.chapterScrollView:addChild(var_4_0)

	local var_4_1 = display.newSprite("task/map/" .. BaseChapters[arg_4_0.chapterId].bigImage2)

	var_4_1:setPosition(ccp(Adapter.AutoHeight(1920) / 2, 0))
	var_4_1:setScale(Adapter.AutoScaleY)
	arg_4_0.chapterScrollView:addChild(var_4_1)
	arg_4_0:setStageTitle(var_4_0, arg_4_0.chapterId, 1)
	arg_4_0:setStageTitle(var_4_1, arg_4_0.chapterId, 2)

	if not Player.currentMissionStageID then
		arg_4_0:setCurrentStagePosition(arg_4_0.stageId)
	end

	arg_4_0:initRequests()
	arg_4_0.starsRewardStateRequest:request(arg_4_0.chapterId)
	arg_4_0:showNewbieGuideLayer()
end

function var_0_1.initRequests(arg_5_0)
	local function var_5_0()
		arg_5_0.rewardState = arg_5_0.starsRewardStateRequest:getStarsRewardState()

		arg_5_0:showStarRewardInfo()

		arg_5_0.doubleRewardData = arg_5_0.starsRewardStateRequest:getDoubleRewardData() or {}

		require("base.cache").set("NewStarsRewardStateRequest_ModulesData", arg_5_0.doubleRewardData)
	end

	arg_5_0.starsRewardStateRequest = NewStarsRewardStateRequest:new()

	arg_5_0.starsRewardStateRequest:setResponseNormalHandler(var_5_0)

	local function var_5_1()
		arg_5_0.mIsShowingStarReward = false

		arg_5_0.fullStarRewardLayer:removeFromParentAndCleanup(true)

		local var_7_0 = string.lf("恭喜, 您获取奖励成功~")

		arg_5_0:addChild(require("scenes.FlashNotice").new(var_7_0))

		local var_7_1 = CCArray:create()

		var_7_1:addObject(CCDelayTime:create(0.8))
		var_7_1:addObject(CCCallFunc:create(function()
			arg_5_0.starsRewardStateRequest:request(arg_5_0.chapterId)
		end))
		arg_5_0:runAction(CCSequence:create(var_7_1))
	end

	local function var_5_2(arg_9_0)
		if arg_9_0 == NetworkState.StarRewardFailed then
			arg_5_0.fullStarRewardLayer:removeFromParentAndCleanup(true)

			arg_5_0.fullStarRewardLayer = nil
		end
	end

	arg_5_0.fullStarsRewardRequest = FullStarsRewardRequest:new()

	arg_5_0.fullStarsRewardRequest:setResponseNormalHandler(var_5_1)
	arg_5_0.fullStarsRewardRequest:setResponseExceptionHandler(var_5_2)
end

function var_0_1.showStarRewardInfo(arg_10_0)
	for iter_10_0 = 1, 3 do
		if iter_10_0 <= #arg_10_0.buttons and arg_10_0.buttons[iter_10_0] then
			arg_10_0.buttons[iter_10_0]:removeFromParentAndCleanup(true)
		end

		if iter_10_0 <= #arg_10_0.arrows and arg_10_0.arrows[iter_10_0] then
			arg_10_0.arrows[iter_10_0]:removeFromParentAndCleanup(true)
		end

		if iter_10_0 <= #arg_10_0.effects and arg_10_0.effects[iter_10_0] then
			arg_10_0.effects[iter_10_0]:removeFromParentAndCleanup(true)
		end
	end

	arg_10_0.buttons = {}
	arg_10_0.arrows = {}
	arg_10_0.effects = {}

	local var_10_0 = {
		"ui/task/task_018.png",
		"ui/task/task_016.png",
		"ui/task/task_014.png"
	}
	local var_10_1 = {
		"ui/task/task_022.png",
		"ui/task/task_023.png",
		"ui/task/task_024.png"
	}
	local var_10_2 = 50

	for iter_10_1 = 1, 3 do
		local var_10_3 = StarRewardType.eCanGet == arg_10_0:getChapterStarState(iter_10_1)
		local var_10_4 = arg_10_0:getChapterStarState(iter_10_1) == StarRewardType.eGot and var_10_1[iter_10_1] or var_10_0[iter_10_1]
		local var_10_5 = ui.newControlButton({
			normalImage = var_10_4,
			highlightedImage = var_10_4,
			position = ccp(Adapter.MinPosX(var_10_2), Adapter.MinPosY(50)),
			clickAction = function(arg_11_0, arg_11_1)
				arg_10_0:onBottomStarRewardBtnClicked(iter_10_1, var_10_3)
			end,
			scaleX = Adapter.MinScale,
			scaleY = Adapter.MinScale
		})

		arg_10_0:addChild(var_10_5, 1)
		table.insert(arg_10_0.buttons, var_10_5)

		if iter_10_1 == 1 or iter_10_1 == 2 then
			local var_10_6 = display.newSprite("ui/task/task_020.png", Adapter.MinPosX(var_10_2 + 75), Adapter.MinPosX(50))

			var_10_6:setScale(Adapter.MinScale)
			arg_10_0:addChild(var_10_6, 1)
			table.insert(arg_10_0.arrows, var_10_6)
		end

		if var_10_3 then
			display.addSpriteFramesWithFile("ui/map/ui_baoxiang.plist", "ui/map/ui_baoxiang.png")

			local var_10_7 = display.newSprite("#ui_baoxiang_01.png")
			local var_10_8 = display.newFrames("ui_baoxiang_0%d.png", 1, 5)
			local var_10_9 = display.newAnimation(var_10_8, 0.1)

			var_10_7:runAction(CCRepeatForever:create(CCAnimate:create(var_10_9)))
			var_10_7:setPosition(Adapter.MinPosX(var_10_2), Adapter.MinPosY(50))
			var_10_7:setScale(Adapter.MinScale)
			arg_10_0:addChild(var_10_7, 1)
			table.insert(arg_10_0.effects, var_10_7)
		end

		if var_10_3 == true and arg_10_0.mIsShowingStarReward ~= true then
			arg_10_0:onBottomStarRewardBtnClicked(iter_10_1, var_10_3)
		end

		var_10_2 = var_10_2 + 150
	end

	local var_10_10 = 0

	for iter_10_2, iter_10_3 in ipairs(Player.taskInfo.Point) do
		if BaseStages[iter_10_3.PID].chapterId == arg_10_0.chapterId then
			var_10_10 = var_10_10 + iter_10_3.Star
		end
	end

	if arg_10_0.starText then
		arg_10_0.starText:removeFromParentAndCleanup(true)
	end

	arg_10_0.starText = ui.newTTFLabel({
		text = "",
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(22),
		color = ccc3(255, 255, 0),
		align = ui.TEXT_ALIGN_CENTER,
		valign = ui.TEXT_VALIGN_CENTER,
		x = Adapter.MinPosX(440),
		y = Adapter.MinPosY(50)
	})

	arg_10_0.starText:setString(string.format("%d/30", var_10_10))
	arg_10_0:addChild(arg_10_0.starText, 1)
	Adapter.NodeAbsScale(arg_10_0.starText)

	if arg_10_0.starSprite then
		arg_10_0.starSprite:removeFromParentAndCleanup(true)
	end

	arg_10_0.starSprite = display.newSprite("ui/common/common_077.png")

	arg_10_0.starSprite:align(display.CENTER, 0, 0)
	arg_10_0.starSprite:setScale(Adapter.MinScale)
	arg_10_0.starSprite:setPosition(Adapter.MinPosX(490), Adapter.MinPosY(53))
	arg_10_0:addChild(arg_10_0.starSprite, 1)

	if arg_10_0.mIsShowingStarReward ~= true and arg_10_0.callParentShowFirstClearTips then
		arg_10_0.callParentShowFirstClearTips()
	end
end

function var_0_1.setStageTitle(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = BaseChapters[arg_12_2]
	local var_12_1 = arg_12_3 % 2 == 1 and var_12_0.lineImage1 or var_12_0.lineImage2
	local var_12_2 = display.newSprite("task/line/" .. var_12_1)

	var_12_2:setAnchorPoint(ccp(0, 0))
	arg_12_1:addChild(var_12_2)

	local var_12_3 = arg_12_0:getStagesByChapterId(arg_12_2)

	for iter_12_0 = 1, 10 do
		local var_12_4

		var_12_4 = arg_12_3 % 2 == 1 and iter_12_0 or 5 + iter_12_0

		local var_12_5 = BaseStages[var_12_3[iter_12_0]]

		if var_12_5.isLeftStages == true and arg_12_3 % 2 == 1 or var_12_5.isLeftStages == false and arg_12_3 % 2 == 0 then
			local var_12_6 = var_12_5.imagePos[1]
			local var_12_7 = var_12_5.imagePos[2]
			local var_12_8 = Player.taskInfo.MaxPID >= var_12_3[iter_12_0]
			local var_12_9 = "task/ico/" .. var_12_5.stageImage
			local var_12_10 = ui.newControlButton({
				clickAction = handler(arg_12_0, arg_12_0.buttonAction),
				normalImage = var_12_9,
				highlightedImage = var_12_9,
				position = ccp(var_12_6, var_12_7)
			})

			var_12_10.tag = var_12_3[iter_12_0]

			var_12_2:addChild(var_12_10, 1)

			local var_12_11 = var_12_5.imagePos[2] - 60
			local var_12_12 = iter_12_0 == 10 and "task_003.png" or "task_002.png"
			local var_12_13 = display.newSprite("ui/task/" .. var_12_12)

			var_12_13:align(display.CENTER, 0, 0)
			var_12_13:setPosition(var_12_6, var_12_11)
			var_12_2:addChild(var_12_13)

			local var_12_14 = ui.newTTFLabel({
				text = "",
				font = _FONT_LISU,
				size = Adapter.FontSize(20),
				color = ccc3(255, 255, 0),
				align = ui.TEXT_ALIGN_CENTER,
				valign = ui.TEXT_VALIGN_CENTER,
				x = var_12_6,
				y = var_12_11
			})

			var_12_14:setString(var_12_5.stageName)
			var_12_2:addChild(var_12_14)
			Adapter.NodeAbsScale(var_12_14)

			if var_12_8 then
				local var_12_15 = 0

				for iter_12_1, iter_12_2 in ipairs(Player.taskInfo.Point) do
					if var_12_3[iter_12_0] == iter_12_2.PID then
						var_12_15 = iter_12_2.Star
					end
				end

				arg_12_0:setStageStarLevelByPosition(var_12_2, var_12_15, ccp(var_12_6, var_12_11))
			end

			if Player.taskInfo.MaxPID == var_12_3[iter_12_0] then
				arg_12_0:setStageBattlingByPosition(var_12_2, ccp(var_12_6, var_12_11))
			end

			var_12_13.tag = arg_12_3
			arg_12_0.chapterButton[var_12_3[iter_12_0]] = var_12_13
		end
	end
end

function var_0_1.getFullStarReward(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.fullStarsRewardRequest:request(arg_13_1, arg_13_2)
end

function var_0_1.buttonAction(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_2.tag

	local function var_14_1()
		if Player.currentMissionStageID then
			local var_15_0 = BaseStages[Player.currentMissionStageID].imagePos

			GuideLayer:hideGuideLayer(arg_14_0.mapScene, TaskEntryType.CheckPoint, 3)
		end
	end

	local var_14_2 = var_0_0.new({
		closeCallback = var_14_1,
		stageId = var_14_0
	})

	CCDirector:sharedDirector():getRunningScene():addChild(var_14_2)

	if var_14_0 == Player.currentMissionStageID and var_14_0 <= Player.taskInfo.MaxPID then
		GuideLayer:hideGuideLayer(arg_14_0.chapterScrollView, TaskEntryType.CheckPoint, 2)
		GuideLayer:stepDone(TaskEntryType.CheckPoint, 2)

		if Player.taskEntryCheckPointType == TaskEntryCheckPointType.eFirstBattleDoubleStar then
			GuideLayer:showGuideLayer(arg_14_0.mapScene, var_14_2.background, TaskEntryType.CheckPoint, 3, ccp(500, 240), true)
		elseif Player.taskEntryCheckPointType == TaskEntryCheckPointType.eFirstBattleThreeStar then
			GuideLayer:showGuideLayer(arg_14_0.mapScene, var_14_2.background, TaskEntryType.CheckPoint, 3, ccp(500, 120), true)
		else
			GuideLayer:showGuideLayer(arg_14_0.mapScene, var_14_2.background, TaskEntryType.CheckPoint, 3, nil, true)
		end
	else
		GuideLayer:removeGuideLayer(arg_14_0.chapterScrollView, TaskEntryType.CheckPoint, 2)
		GuideLayer:removeGuideLayer(arg_14_0.mapScene, TaskEntryType.CheckPoint, 2)
	end
end

function var_0_1.setStageBattlingByPosition(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_2.x
	local var_16_1 = arg_16_2.y

	display.addSpriteFramesWithFile("ui/map/icon_engagement.plist", "ui/map/icon_engagement.png")

	local var_16_2 = display.newSprite("#icon_engagement1.png")
	local var_16_3 = display.newFrames("icon_engagement%d.png", 1, 3)
	local var_16_4 = display.newAnimation(var_16_3, 0.3333333333333333)

	var_16_2:runAction(CCRepeatForever:create(CCAnimate:create(var_16_4)))
	var_16_2:setPosition(var_16_0, var_16_1 + 50)
	arg_16_1:addChild(var_16_2, 1)
end

function var_0_1.setStageStarLevelByPosition(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	for iter_17_0 = 1, 3 do
		local var_17_0 = arg_17_2 < iter_17_0
		local var_17_1

		if var_17_0 then
			var_17_1 = display.newSprite("ui/common/common_077_2.png")
		else
			var_17_1 = display.newSprite("ui/common/common_077.png")
		end

		var_17_1:setPosition(arg_17_3.x + 30 * (iter_17_0 - 2), arg_17_3.y + 120)
		arg_17_1:addChild(var_17_1)
	end
end

function var_0_1.getChapterStarState(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.rewardState) do
		if iter_18_1.Star == arg_18_1 and iter_18_1.State == 0 then
			return StarRewardType.eCanGet
		elseif iter_18_1.Star == arg_18_1 and iter_18_1.State == 1 then
			return StarRewardType.eGot
		end
	end

	return StarRewardType.eNone
end

function var_0_1.setCurrentStagePosition(arg_19_0, arg_19_1)
	local var_19_0 = Player:getTroMaxStep()

	if var_19_0 < 26 then
		if var_19_0 == NSStep.DuanZao2 then
			arg_19_0.chapterScrollView:setContentOffset(ccp(-Adapter.AutoHeight(300), 0))
		elseif var_19_0 == NSStep.ZhanYi5 or var_19_0 == NSStep.ZhanYi6 then
			arg_19_0.chapterScrollView:setContentOffset(ccp(-Adapter.AutoHeight(520), 0))
		end

		return
	end

	local var_19_1
	local var_19_2 = BaseStages[arg_19_1]
	local var_19_3 = Adapter.AutoHeight(1920) - display.width
	local var_19_4 = Adapter.AutoHeight(var_19_2.imagePos[1] + (var_19_2.isLeftStages and 0 or 960))
	local var_19_5 = 0

	if var_19_4 > Adapter.AutoHeight(480) then
		var_19_5 = Adapter.AutoHeight(480) - var_19_4
	end

	if var_19_4 > var_19_3 + Adapter.AutoHeight(280) then
		var_19_5 = -var_19_3
	end

	chapterBg_X = clampf(var_19_5, -var_19_3, 0)

	if Player.currentMissionStageID then
		arg_19_0.chapterScrollView:setContentOffsetInDuration(ccp(chapterBg_X, 0), 0.5)

		local var_19_6 = CCArray:create()

		var_19_6:addObject(CCDelayTime:create(0.52))
		var_19_6:addObject(CCCallFunc:create(handler(arg_19_0, arg_19_0.showGuideLayer)))
		arg_19_0:runAction(CCSequence:create(var_19_6))
	else
		arg_19_0.chapterScrollView:setContentOffsetInDuration(ccp(chapterBg_X, 0), 0.8)
	end
end

function var_0_1.showNewbieGuideLayer(arg_20_0)
	local var_20_0 = Player:getTroMaxStep()

	if var_20_0 == NSStep.ZhaoJiang then
		GuideLayer:showNewbieGuideLayer(arg_20_0.mapScene, arg_20_0, 7, function()
			require("scenes.battle.BattleOperator"):startBattle(eBattleType.Map, {
				id = 10010
			}, function(arg_22_0, arg_22_1, arg_22_2)
				if arg_22_0 == true then
					GuideLayer:saveTrioMaxStep(NSStep.ZhanYi1, function()
						Player:updateMapPoint(arg_22_2, arg_22_1.Star, arg_22_1.TodayWinCount, arg_22_1.NextCheckpoint)
						game.enterMapChapterScene({
							stageId = arg_22_2
						})
					end)
				end
			end)

			return true
		end, nil, true, true)
	end

	if var_20_0 == NSStep.ZhanYi1 then
		GuideLayer:showNewbieGuideLayer(arg_20_0.mapScene, arg_20_0, 8, function()
			require("scenes.battle.BattleOperator"):startBattle(eBattleType.Map, {
				id = 10011
			}, function(arg_25_0, arg_25_1, arg_25_2)
				if arg_25_0 == true then
					GuideLayer:saveTrioMaxStep(NSStep.ZhanYi2, function()
						Player:updateMapPoint(arg_25_2, arg_25_1.Star, arg_25_1.TodayWinCount, arg_25_1.NextCheckpoint)
						game.enterMapChapterScene({
							stageId = arg_25_2
						})
					end)
				end
			end)

			return true
		end, nil, true, true)
	end

	if var_20_0 == NSStep.ZhanYi2 then
		GuideLayer:showNewbieGuideLayer(arg_20_0.mapScene, arg_20_0, 9, function()
			require("scenes.battle.BattleOperator"):startBattle(eBattleType.Map, {
				id = 10012
			}, function(arg_28_0, arg_28_1, arg_28_2)
				if arg_28_0 == true then
					GuideLayer:saveTrioMaxStep(NSStep.ZhanYi3, function()
						Player:updateMapPoint(arg_28_2, arg_28_1.Star, arg_28_1.TodayWinCount, arg_28_1.NextCheckpoint)
						game.enterMapChapterScene({
							stageId = arg_28_2
						})
					end)
				end
			end)

			return true
		end, nil, true, true)
	end

	if var_20_0 == NSStep.ZhanYi3 then
		GuideLayer:showNewbieGuideLayer(arg_20_0.mapScene, arg_20_0, 10, function()
			require("scenes.battle.BattleOperator"):startBattle(eBattleType.Map, {
				id = 10013
			}, function(arg_31_0, arg_31_1, arg_31_2)
				if arg_31_0 == true then
					GuideLayer:saveTrioMaxStep(NSStep.ZhanYi4, function()
						Player:updateMapPoint(arg_31_2, arg_31_1.Star, arg_31_1.TodayWinCount, arg_31_1.NextCheckpoint)
						game.enterMapChapterScene({
							stageId = arg_31_2
						})
					end)
				end
			end)

			return true
		end, nil, true, true)
	end

	if var_20_0 == NSStep.ZhanYi4 then
		GuideLayer:showNewbieGuideLayer(arg_20_0.mapScene, arg_20_0, 11, function()
			local var_33_0 = require("scenes.home.HomeTaskLayer").new({
				mapChapterScene = true,
				homeScene = arg_20_0
			})

			arg_20_0:addChild(var_33_0, DefaultZOrder.ePopupLayer)

			return true
		end)
	end

	if var_20_0 == NSStep.DuanZao2 then
		GuideLayer:showNewbieGuideLayer(arg_20_0.mapScene, arg_20_0, 14, function()
			require("scenes.battle.BattleOperator"):startBattle(eBattleType.Map, {
				id = 10014
			}, function(arg_35_0, arg_35_1, arg_35_2)
				if arg_35_0 == true then
					GuideLayer:saveTrioMaxStep(NSStep.ZhanYi5, function()
						Player:updateMapPoint(arg_35_2, arg_35_1.Star, arg_35_1.TodayWinCount, arg_35_1.NextCheckpoint)
						game.enterMapChapterScene({
							stageId = arg_35_2
						})
					end)
				end
			end)

			return true
		end)
	end

	if var_20_0 == NSStep.ZhanYi5 then
		GuideLayer:showNewbieGuideLayer(arg_20_0.mapScene, arg_20_0, 140, function()
			require("scenes.battle.BattleOperator"):startBattle(eBattleType.Map, {
				id = 10015
			}, function(arg_38_0, arg_38_1, arg_38_2)
				if arg_38_0 == true then
					GuideLayer:saveTrioMaxStep(NSStep.ZhanYi6, function()
						Player:updateMapPoint(arg_38_2, arg_38_1.Star, arg_38_1.TodayWinCount, arg_38_1.NextCheckpoint)
						game.enterMapChapterScene({
							stageId = arg_38_2
						})
					end)
				end
			end)

			return true
		end)
	end

	if var_20_0 == NSStep.ZhanYi6 then
		GuideLayer:showNewbieGuideLayer(arg_20_0.mapScene, arg_20_0, 15, function()
			local var_40_0 = require("scenes.home.HomeTaskLayer").new({
				mapChapterScene = true,
				homeScene = arg_20_0
			})

			arg_20_0:addChild(var_40_0, DefaultZOrder.ePopupLayer)

			return true
		end, nil, true, true)
	end
end

function var_0_1.showGuideLayer(arg_41_0)
	if Player.currentMissionStageID then
		if Player.taskEntryCheckPointType ~= TaskEntryCheckPointType.eNone and Player.taskEntryCheckPointType > TaskEntryCheckPointType.eFirstBattleThreeStar then
			local var_41_0 = 50

			if TaskEntryCheckPointType.eDoubleStarTreasureBox == Player.taskEntryCheckPointType then
				var_41_0 = 200
			elseif TaskEntryCheckPointType.eThreeStarTreasureBox == Player.taskEntryCheckPointType then
				var_41_0 = 350
			end

			GuideLayer:showGuideLayer(arg_41_0.mapScene, nil, TaskEntryType.CheckPoint, 2, ccp(Adapter.MinPosX(var_41_0), Adapter.MinPosY(80)), true)
		elseif arg_41_0.chapterId == BaseStages[Player.currentMissionStageID].chapterId then
			local var_41_1, var_41_2 = arg_41_0.chapterButton[Player.currentMissionStageID]:getPosition()

			if arg_41_0.chapterButton[Player.currentMissionStageID].tag == 2 then
				var_41_1 = var_41_1 + 960
			end

			local var_41_3 = CCPoint(var_41_1 * Adapter.AutoScaleY, (var_41_2 + 120) * Adapter.AutoScaleY)
			local var_41_4 = GuideLayer:showGuideLayer(arg_41_0.chapterScrollView, nil, TaskEntryType.CheckPoint, 2, var_41_3, true)

			if Player.taskInfo.MaxPID >= Player.currentMissionStageID == false and var_41_4 ~= nil then
				var_41_4.guideLable:setString(string.lf("任务目标"))
			end
		else
			arg_41_0:getParent():showGuideLayer()
		end
	end
end

function var_0_1.showNewbieGuideLayer2(arg_42_0)
	GuideLayer:showNewbieGuideLayer(arg_42_0.mapScene, arg_42_0, 14, function()
		require("scenes.battle.BattleOperator"):startBattle(eBattleType.Map, {
			id = 10014
		}, function(arg_44_0, arg_44_1, arg_44_2)
			if arg_44_0 == true then
				GuideLayer:saveTrioMaxStep(NSStep.ZhanYi5, function()
					Player:updateMapPoint(arg_44_2, arg_44_1.Star, arg_44_1.TodayWinCount, arg_44_1.NextCheckpoint)
					game.enterMapChapterScene({
						stageId = arg_44_2
					})
				end)
			end
		end)

		return true
	end)
end

function var_0_1.onBottomStarRewardBtnClicked(arg_46_0, arg_46_1, arg_46_2)
	arg_46_0.mIsShowingStarReward = true

	local var_46_0 = BaseChapters[arg_46_0.chapterId].dropList[arg_46_1]

	arg_46_0.fullStarRewardLayer = require("scenes.map.FullStarRewardLayer").new({
		rewardList = var_46_0,
		canGet = arg_46_2,
		getReward = handler(arg_46_0, arg_46_0.getFullStarReward),
		chapterId = arg_46_0.chapterId,
		rewardType = arg_46_1
	})

	arg_46_0:addChild(arg_46_0.fullStarRewardLayer, 2)
end

return var_0_1
