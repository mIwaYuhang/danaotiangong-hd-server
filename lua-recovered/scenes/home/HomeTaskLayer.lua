require("data.task")
require("base.figure")
require("network.DailySalaryRequest")

local var_0_0 = class("HomeTaskLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0._homeScene = arg_2_1.homeScene
	arg_2_0._mapChapterScene = arg_2_1.mapChapterScene
	arg_2_0._mapWorldScene = arg_2_1.mapWorldScene
	arg_2_0.showGuideArrow = arg_2_1.showGuideArrow

	arg_2_0:initNetworkInterface()

	arg_2_0.taskEntryType = arg_2_1.taskEntryType or 0
	arg_2_0.taskEntryTypeIndex = -1

	if arg_2_0.showGuideArrow == true then
		Player.currentTaskEntryType = TaskEntryType.eShowEverydayTask
		Player.currentTaskStep = 2
		arg_2_0.taskEntryType = TaskEntryType.CheckPoint
	end

	arg_2_0.taskList = {}

	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 2, true)
	arg_2_0:setTouchEnabled(true)

	local var_2_0 = display.newScale9Sprite("ui/common/common_040_3.png")

	arg_2_0.bgSprite = var_2_0
	arg_2_0.bgSize = CCSize(822, 566)

	var_2_0:setScale(Adapter.MinScale)
	var_2_0:setPreferredSize(arg_2_0.bgSize)
	var_2_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_0:setPosition(CCPoint(display.cx, display.cy))
	arg_2_0:addChild(var_2_0)

	arg_2_0.background = CCLayerColor:create(ccc4(0, 0, 0, 0))

	arg_2_0.background:setContentSize(arg_2_0.bgSize)
	var_2_0:addChild(arg_2_0.background)

	local var_2_1 = display.newSprite("uilocal/task/task_text_001.png")

	var_2_1:setAnchorPoint(CCPoint(CCPoint(0.5, 0.5)))
	var_2_1:setPosition(CCPoint(90, 534))
	var_2_0:addChild(var_2_1)

	local var_2_2 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		highlightedImage = "ui/common/btn_closed.png",
		clickAction = function()
			arg_2_0:removeFromParentAndCleanup(true)
		end,
		position = CCPoint(arg_2_0.bgSize.width - 36, arg_2_0.bgSize.height - 36)
	})

	var_2_0:addChild(var_2_2)
	arg_2_0:showTaskList()
	GuideLayer:removeAllGuideLayer()
	GuideLayer:removeHomeGuideLayer()

	local var_2_3 = Player:getTroMaxStep()

	if var_2_3 == NSStep.ZhanYi4 then
		GuideLayer:showNewbieGuideLayer(nil, arg_2_0.bgSprite, 12, function()
			arg_2_0:DealMissionAction(arg_2_0.taskList[1])

			return true
		end)
	end

	if var_2_3 == NSStep.ZhanYi6 then
		GuideLayer:showNewbieGuideLayer(nil, arg_2_0.bgSprite, 16, function()
			arg_2_0:DealMissionAction(arg_2_0.taskList[1])

			return true
		end)
	end
end

function var_0_0.getTaskTitleSpritePath(arg_7_0, arg_7_1)
	local var_7_0

	return arg_7_1 == TaskType.eTaskTeaching and "ui/task/task_010.png" or arg_7_1 == TaskType.eTaskPlotline and "ui/task/task_009.png" or arg_7_1 == TaskType.eTaskDaily and "ui/task/task_011.png" or "ui/task/task_011.png"
end

function var_0_0.showTaskList(arg_8_0)
	arg_8_0:refreshMissionData()

	local var_8_0 = CCSize(779, 174)

	local function var_8_1(arg_9_0)
		return var_8_0.height, var_8_0.width
	end

	local function var_8_2(arg_10_0)
		return #arg_8_0.taskList
	end

	local function var_8_3(arg_11_0, arg_11_1, arg_11_2)
		local var_11_0 = arg_11_2.x
		local var_11_1 = arg_11_2.y

		for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
			local var_11_2 = {
				type = iter_11_1.Type,
				itemId = iter_11_1.ID or 0,
				nameColor = ccc3(239, 232, 195),
				count = iter_11_1.Count
			}
			local var_11_3 = figure.createHeader(var_11_2)

			var_11_3:setAnchorPoint(CCPoint(0.5, 0.5))
			var_11_3:setPosition(var_11_0, var_11_1)
			arg_11_0:addChild(var_11_3)

			var_11_0 = var_11_0 + 120
		end
	end

	local function var_8_4(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_0:cellAtIndex(arg_12_1)
		local var_12_1 = arg_8_0.taskList[arg_12_1 + 1]

		if var_12_0 == nil then
			var_12_0 = CCTableViewCell:new()

			local var_12_2 = display.newSprite("ui/task/task_012.png")
			local var_12_3 = var_12_2:getContentSize()

			var_12_2:setAnchorPoint(CCPoint(0.5, 0.5))
			var_12_2:setPosition(CCPoint(390, 87))
			var_12_0:addChild(var_12_2)

			local var_12_4 = arg_8_0:getTaskTitleSpritePath(var_12_1.type)
			local var_12_5 = display.newSprite(var_12_4, 390, 135)

			var_12_2:addChild(var_12_5)

			local var_12_6 = ui.newTTFLabel({
				text = "",
				font = _FONT_DEFAULT,
				size = Adapter.FontSize(24),
				color = ccc3(229, 207, 132)
			})

			var_12_6:setAnchorPoint(CCPoint(0, 0.5))
			var_12_6:setPosition(115, 19)
			var_12_6:setString("【" .. TaskTypeNames[var_12_1.type] .. "】" .. var_12_1.name)
			var_12_5:addChild(var_12_6)

			if var_12_1.type == TaskType.eTaskTeaching then
				local var_12_7 = display.newSprite("uilocal/home/home_text_026.png", 5, 30)

				var_12_5:addChild(var_12_7)
			end

			local var_12_8 = ui.newTTFLabel({
				text = "",
				font = _FONT_DEFAULT,
				size = Adapter.FontSize(24),
				color = ccc3(0, 0, 0)
			})

			var_12_8:setAnchorPoint(CCPoint(1, 0.5))
			var_12_8:setPosition(750, 19)
			var_12_8:setString(string.lf("要求: %s", var_12_1.description))
			var_12_5:addChild(var_12_8)
			var_8_3(var_12_2, var_12_1.missionReward, CCPoint(61, 68))

			if var_12_1.state == TaskStatus.eCompleted then
				local var_12_9 = display.newSprite("ui/task/task_008.png", 464, 88)

				var_12_2:addChild(var_12_9)
			end

			local var_12_10
			local var_12_11
			local var_12_12

			if var_12_1.state == TaskStatus.eAcceptable then
				var_12_10 = string.lf("立即前往")
				var_12_11 = "ui/task/task_005.png"
				var_12_12 = ccc3(253, 175, 68)
			elseif var_12_1.state == TaskStatus.eProcessing then
				var_12_10 = string.lf("进行中")
				var_12_11 = "ui/task/task_005.png"
				var_12_12 = ccc3(253, 253, 253)
			elseif var_12_1.state == TaskStatus.eCompleted then
				var_12_10 = string.lf("领取奖励")
				var_12_11 = "ui/task/task_006.png"
				var_12_12 = ccc3(253, 253, 253)
			end

			local var_12_13 = ui.newControlButton({
				fontSize = 30,
				normalImage = var_12_11,
				disabledImage = var_12_11,
				text = var_12_10,
				textColor = var_12_12,
				anchorPoint = CCPoint(0.5, 0.5),
				position = CCPoint(646, 70),
				clickAction = function()
					arg_8_0:DealMissionAction(var_12_1)
				end
			})

			if arg_12_1 == 1 then
				arg_8_0.firstButton = var_12_13
			end

			var_12_2:addChild(var_12_13)

			if var_12_1.state == TaskStatus.eProcessing then
				var_12_13:setEnabled(false)
			end

			if arg_8_0.taskEntryTypeIndex == arg_12_1 then
				Player.currentTaskEntryType = TaskEntryType.eShowEverydayTask
				Player.currentTaskStep = 2

				GuideLayer:showGuideLayer(var_12_13, nil, TaskEntryType.eShowEverydayTask, 2, ccp(10, 35))

				arg_8_0.taskEntryTypeIndex = arg_12_1
			end
		end

		return var_12_0
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.taskList) do
		if iter_8_1.location.Type == arg_8_0.taskEntryType then
			arg_8_0.taskEntryTypeIndex = iter_8_0 - 1

			break
		end
	end

	arg_8_0.tableView = CCTableView:create(CCSize(780, 476))

	arg_8_0.tableView:setPosition(CCPoint(21, 20))
	arg_8_0.tableView:setVerticalFillOrder(kCCTableViewFillTopDown)
	arg_8_0.tableView:setDirection(kCCScrollViewDirectionVertical)
	arg_8_0.tableView:registerScriptHandler(var_8_1, CCTableView.kTableCellSizeForIndex)
	arg_8_0.tableView:registerScriptHandler(var_8_2, CCTableView.kNumberOfCellsInTableView)
	arg_8_0.tableView:registerScriptHandler(var_8_4, CCTableView.kTableCellSizeAtIndex)
	arg_8_0.tableView:reloadData()
	arg_8_0.tableView:setContentOffset(arg_8_0.tableView:minContainerOffset())
	arg_8_0.background:addChild(arg_8_0.tableView)

	if arg_8_0.taskEntryTypeIndex > 1 then
		local var_8_5 = (#arg_8_0.taskList - arg_8_0.taskEntryTypeIndex - 2) * var_8_0.height

		arg_8_0.tableView:setContentOffset(CCPoint(0, -var_8_5))
	end
end

function var_0_0.DealMissionAction(arg_14_0, arg_14_1)
	Player:setCurrentTaskEntryType(arg_14_1.location.Type)
	Player:setCurrentTaskStep(1)
	Player:setCurrentMissionStageID(arg_14_1.location.ID)

	if arg_14_1.location.Type == TaskEntryType.CheckPoint and arg_14_1.location.ID < TaskEntryCheckPointType.eMax then
		Player.currentMissionStageID = 10010
		Player.taskEntryCheckPointType = arg_14_1.location.ID
	else
		Player.taskEntryCheckPointType = TaskEntryCheckPointType.eNone
	end

	if arg_14_1.location.Type == TaskEntryType.eEntryBattleHero then
		Player.taskBattleHeroID = arg_14_1.location.ID
	end

	if arg_14_1.state == TaskStatus.eCompleted then
		arg_14_0.missionRewardRequest:request(arg_14_1.missionID)

		arg_14_0._tempMissionID = arg_14_1.missionID

		return
	end

	if arg_14_0._mapWorldScene or arg_14_0._mapChapterScene then
		GuideLayer:removeGuideLayer(parrentLayer, entryType, step)

		if arg_14_0._mapChapterScene then
			Player.currentTaskStep = 2
		end

		arg_14_0._homeScene:showGuideLayer()

		if Player.currentTaskEntryType ~= TaskEntryType.CheckPoint then
			Player.currentTaskStep = 1

			game.enterHomeScene({
				showHomeGuideArrow = true
			})

			return
		end
	else
		arg_14_0._homeScene:showHomeGuideLayer()

		if Player.currentTaskEntryType == TaskEntryType.CheckPoint then
			local var_14_0 = BaseStages[Player.taskInfo.MaxPID].chapterId

			if Player.currentMissionStageID and BaseStages[Player.currentMissionStageID] then
				var_14_0 = BaseStages[Player.currentMissionStageID].chapterId
			end

			local var_14_1 = WorldType.eHeaven

			if var_14_0 then
				var_14_1 = BaseChapters[var_14_0].worldType
			end

			game.enterMapWorldScene(var_14_1)

			return
		end
	end

	arg_14_0:removeFromParentAndCleanup(true)
end

function var_0_0.selectTaskByType(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == nil then
		arg_15_1 = {}
	end

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		if iter_15_1.type == arg_15_2 then
			table.insert(arg_15_0.taskList, iter_15_1)
		end
	end
end

function var_0_0.selectTaskByEntryType(arg_16_0, arg_16_1, arg_16_2)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		if iter_16_1.location.Type == arg_16_2 or iter_16_1.state == TaskStatus.eCompleted then
			table.insert(arg_16_0.taskList, iter_16_1)
		end
	end
end

function var_0_0.refreshMissionData(arg_17_0)
	arg_17_0.taskList = {}

	arg_17_0:selectTaskByType(Player.missionData, TaskType.eTaskTeaching)
	arg_17_0:selectTaskByType(Player.missionData, TaskType.eTaskDaily)
	arg_17_0:selectTaskByType(Player.missionData, TaskType.eTaskPlotline)
	arg_17_0:selectTaskByType(Player.missionData, TaskType.eTaskBranchline)
	arg_17_0:selectTaskByType(Player.missionData, TaskType.eTaskCopy)

	local function var_17_0(arg_18_0, arg_18_1)
		if arg_18_0.state == TaskStatus.eCompleted and arg_18_1.state ~= TaskStatus.eCompleted then
			return true
		elseif arg_18_0.state ~= TaskStatus.eCompleted and arg_18_1.state == TaskStatus.eCompleted then
			return false
		else
			return TaskTypeOrder[arg_18_0.type] < TaskTypeOrder[arg_18_1.type]
		end
	end

	table.sort(arg_17_0.taskList, var_17_0)
	arg_17_0:filtterTaskData()
end

function var_0_0.filtterTaskData(arg_19_0)
	local var_19_0 = false
	local var_19_1 = 1

	while var_19_1 <= #arg_19_0.taskList do
		if arg_19_0.taskList[var_19_1].type == TaskType.eTaskPlotline then
			if var_19_0 == true then
				table.remove(arg_19_0.taskList, var_19_1)

				var_19_1 = var_19_1 - 1
			end

			var_19_0 = true
		end

		var_19_1 = var_19_1 + 1
	end
end

function var_0_0.initNetworkInterface(arg_20_0)
	local function var_20_0()
		arg_20_0.taskEntryType = 0
		arg_20_0.taskEntryTypeIndex = -1

		Player:deleteCompletedMission(arg_20_0._tempMissionID)
		arg_20_0:refreshMissionData()
		arg_20_0.tableView:reloadData()
		showFlashNotice(string.lf("领取奖励成功。"))

		local var_21_0 = Player:getTroMaxStep()

		if var_21_0 == NSStep.ZhanYi4 then
			GuideLayer:saveTrioMaxStep(NSStep.ZhanYi4Reward, function()
				game.enterHomeScene()
			end)
		end

		if var_21_0 == NSStep.ZhanYi6 then
			GuideLayer:saveTrioMaxStep(NSStep.ZhanYi6Reward, function()
				game.enterHomeScene()
			end)
		end
	end

	local function var_20_1(arg_24_0)
		local var_24_0 = {
			[-1133001] = string.lf("玩家任务未完成"),
			[-1133002] = string.lf("玩家任务奖励已领取")
		}

		showFlashNotice(var_24_0[arg_24_0])
	end

	arg_20_0.missionRewardRequest = MissionRewardRequest:new()

	arg_20_0.missionRewardRequest:setResponseNormalHandler(var_20_0)
	arg_20_0.missionRewardRequest:setResponseExceptionHandler(var_20_1)
end

return var_0_0
