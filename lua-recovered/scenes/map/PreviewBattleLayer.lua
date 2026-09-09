require("data.map")
require("network.BattleRequest")

local var_0_0 = require("scenes.ToolLayer")

local function var_0_1(arg_1_0)
	local var_1_0 = ""
	local var_1_1, var_1_2, var_1_3, var_1_4 = getDateFromSeconds(arg_1_0)

	return (string.format("%02d:%02d", var_1_3, var_1_4))
end

local var_0_2 = class("PreviewBattleLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create(ccc4(10, 10, 10, 180)))
end)

function var_0_2.ctor(arg_3_0, arg_3_1)
	arg_3_0._closeCallback = arg_3_1.closeCallback

	local var_3_0 = CCSize(display.width, display.height)

	arg_3_0:setContentSize(var_3_0)

	arg_3_0.stageId = arg_3_1.stageId
	arg_3_0.stage = BaseStages[arg_3_0.stageId]
	arg_3_0.background = arg_3_0:createDialogBox()

	arg_3_0.background:setAnchorPoint(CCPoint(0.5, 0.5))
	arg_3_0.background:setPosition(var_3_0.width / 2 - 8, var_3_0.height / 2)
	arg_3_0:addChild(arg_3_0.background)
	arg_3_0:setAnchorPoint(CCPoint(0, 0))
	arg_3_0:setPosition(0, 0)
	arg_3_0:addTouchEventListener(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == "began" then
			local var_4_0 = var_3_0.width
			local var_4_1 = Adapter.MinWidth(arg_3_0.background:getContentSize().width)

			if arg_4_1 <= (var_4_0 - var_4_1) / 2 or arg_4_1 >= (var_4_0 + var_4_1) / 2 then
				if arg_3_0._closeCallback then
					arg_3_0._closeCallback()
				end

				arg_3_0:removeFromParentAndCleanup(true)
			end

			return true
		end
	end, false, 1, true)
	arg_3_0:setTouchEnabled(true)
	arg_3_0:initRequests()
end

function var_0_2.initRequests(arg_5_0)
	local function var_5_0()
		local var_6_0 = Player.taskInfo

		var_6_0.CdTime = arg_5_0.battleTenRequest.restable.cdTime

		for iter_6_0, iter_6_1 in ipairs(var_6_0.Point) do
			if iter_6_1.PID == arg_5_0.stageId then
				iter_6_1.COD = arg_5_0.battleTenRequest.restable.TodayWinCount

				break
			end
		end

		Player:setTaskInfo(var_6_0)
		Player:setTaskTenBattleIngot(arg_5_0.battleTenRequest.restable.BattleTenIngot)

		local var_6_1 = require("scenes.map.BattleTenResultLayer").new({
			resultList = arg_5_0.battleTenRequest.restable.battleResult.Operator,
			stageId = arg_5_0.stageId
		})

		CCDirector:sharedDirector():getRunningScene():addChild(var_6_1)
		arg_5_0:removeFromParentAndCleanup(true)
	end

	arg_5_0.battleTenRequest = BattleTenRequest:new()

	arg_5_0.battleTenRequest:setResponseNormalHandler(var_5_0)

	local function var_5_1()
		local var_7_0 = Player.taskInfo

		var_7_0.CdTime = 0

		Player:setTaskInfo(var_7_0)

		local var_7_1 = 0

		for iter_7_0, iter_7_1 in ipairs(Player.taskInfo.Point) do
			if arg_5_0.stageId == iter_7_1.PID then
				var_7_1 = iter_7_1.COD
			end
		end

		for iter_7_2, iter_7_3 in ipairs(arg_5_0.timeLabels) do
			iter_7_3:setVisible(false)
		end

		for iter_7_4, iter_7_5 in ipairs(arg_5_0.idots) do
			iter_7_5:setVisible(false)
		end

		arg_5_0.timeLabels[1]:stopAllActions()

		arg_5_0.battleCount = arg_5_0.stage.battleMax - var_7_1 >= 10 and 10 or arg_5_0.stage.battleMax - var_7_1

		if isConsumePropEnough(ItemType.ePower, arg_5_0.battleCount) then
			arg_5_0.battleTenRequest:request(arg_5_0.stageId, arg_5_0.starLevel)
		end
	end

	arg_5_0.buyColdTimeRequest = BuyColdTimeRequest:new()

	arg_5_0.buyColdTimeRequest:setResponseNormalHandler(var_5_1)
end

function var_0_2.createDialogBox(arg_8_0)
	local var_8_0 = 0
	local var_8_1 = 0

	for iter_8_0, iter_8_1 in ipairs(Player.taskInfo.Point) do
		if arg_8_0.stageId == iter_8_1.PID then
			var_8_0 = iter_8_1.COD
			var_8_1 = iter_8_1.Star
		end
	end

	local var_8_2 = _FONT_DEFAULT
	local var_8_3 = 25
	local var_8_4 = ccc3(255, 255, 0)
	local var_8_5 = ccc3(241, 233, 114)
	local var_8_6 = display.newScale9Sprite("ui/battle/battle_039.png", display.cx, display.cy)

	var_8_6:setPreferredSize(CCSizeMake(591, 635))
	var_8_6:setScale(Adapter.MinScale)

	local function var_8_7()
		arg_8_0:removeFromParentAndCleanup(true)

		if arg_8_0._closeCallback then
			arg_8_0._closeCallback()
		end
	end

	local var_8_8 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		position = CCPoint(580, 570),
		clickAction = var_8_7
	})

	var_8_6:addChild(var_8_8)

	local var_8_9 = arg_8_0.stage.battleMax - var_8_0 >= 10 and 10 or arg_8_0.stage.battleMax - var_8_0

	arg_8_0.battleCount = var_8_9 == 0 and 10 or var_8_9

	if var_8_9 == 0 then
		-- block empty
	end

	local var_8_10 = true
	local var_8_11 = arg_8_0.stage.battleMax - var_8_0 > 0 and true or false

	arg_8_0.idots = {}
	arg_8_0.timeLabels = {}

	local var_8_12 = Player.taskInfo.CdTime
	local var_8_13 = BaseStages[arg_8_0.stageId]

	for iter_8_2 = 1, 3 do
		local var_8_14 = iter_8_2 <= var_8_1 + 1
		local var_8_15 = ui.newTTFLabel({
			x = 165,
			text = var_8_13.coinMin[iter_8_2],
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(20),
			color = var_8_5,
			align = ui.TEXT_ALIGN_LEFT,
			valign = ui.TEXT_VALIGN_CENTER,
			dimensions = CCSize(160, 40),
			y = 445 - iter_8_2 * 120
		})

		var_8_6:addChild(var_8_15)

		local var_8_16 = ui.newTTFLabel({
			x = 165,
			text = var_8_13.expMin[iter_8_2],
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(20),
			color = var_8_5,
			align = ui.TEXT_ALIGN_LEFT,
			valign = ui.TEXT_VALIGN_CENTER,
			dimensions = CCSize(160, 40),
			y = 407 - iter_8_2 * 120
		})

		var_8_6:addChild(var_8_16)

		local var_8_17 = require("base.cache")
		local var_8_18 = var_8_17.get("NewStarsRewardStateRequest_ModulesData")

		dump(var_8_17.get("NewStarsRewardStateRequest_ModulesData"))

		local var_8_19 = false

		if var_8_18 then
			for iter_8_3 = 1, table.nums(var_8_18) do
				if iter_8_2 == 1 and var_8_18[iter_8_3] == 8004 then
					var_8_19 = true
				elseif iter_8_2 == 2 and var_8_18[iter_8_3] == 8005 then
					var_8_19 = true
				elseif iter_8_2 == 3 and var_8_18[iter_8_3] == 8006 then
					var_8_19 = true
				end
			end
		end

		if var_8_19 then
			local var_8_20 = createMarkLabel({
				y = 23,
				background = "ui/common/common_133.png",
				rotate = -31,
				size = 16,
				x = 28,
				text = string.lf("%d倍", 2)
			})

			var_8_20:setPosition(CCPoint(40, 460 - iter_8_2 * 120))
			var_8_6:addChild(var_8_20)
		end

		local var_8_21 = ui.newControlButton({
			disabledImage = "ui/common/common_080.png",
			normalImage = "ui/common/common_055.png",
			text = string.lf("战%d次", var_8_9),
			fontSize = var_8_3,
			textColor = ccc3(228, 191, 101),
			position = CCPoint(350, 425 - iter_8_2 * 120),
			clickAction = function(arg_10_0, arg_10_1)
				arg_8_0:tenTiemClickAction(iter_8_2)
			end
		})

		var_8_21:setEnabled(var_8_10 and iter_8_2 <= var_8_1 and var_8_11)
		var_8_21:setTag(iter_8_2)
		var_8_6:addChild(var_8_21)

		local var_8_22 = ui.newControlButton({
			disabledImage = "ui/common/common_080.png",
			normalImage = "ui/common/common_019.png",
			text = string.lf("战斗"),
			position = CCPoint(500, 425 - iter_8_2 * 120),
			clickAction = function(arg_11_0, arg_11_1)
				arg_8_0:battleClickAction(iter_8_2)
			end
		})

		var_8_22:setEnabled(var_8_14 and var_8_11)
		var_8_22:setTag(iter_8_2)
		var_8_6:addChild(var_8_22)

		if var_8_10 and iter_8_2 <= var_8_1 then
			local var_8_23 = display.newSprite("ui/common/icon_idot.png", 5, 35)

			var_8_23:setVisible(var_8_12 > 0 and var_8_11)
			var_8_21:addChild(var_8_23)
			table.insert(arg_8_0.idots, var_8_23)

			local var_8_24 = ui.newTTFLabel({
				x = 280,
				text = string.lf("冷却时间: %s", var_0_1(var_8_12)),
				font = _FONT_DEFAULT,
				size = Adapter.FontSize(18),
				color = ccc3(244, 236, 0),
				align = ui.TEXT_ALIGN_LEFT,
				valign = ui.TEXT_VALIGN_CENTER,
				dimensions = CCSize(200, 40),
				y = 467 - iter_8_2 * 120
			})

			var_8_6:addChild(var_8_24)
			var_8_24:setVisible(var_8_12 > 0 and Player.taskInfo.MaxPID >= arg_8_0.stageId and var_8_11)
			table.insert(arg_8_0.timeLabels, var_8_24)
		end

		if Player.taskInfo.MaxPID < arg_8_0.stageId then
			var_8_21:setVisible(false)
			var_8_22:setVisible(false)

			local var_8_25 = string.lf("打通上一个关卡开放")

			if BaseStages[arg_8_0.stageId - 1] then
				var_8_25 = string.lf("打通 \"%s\" 开放", BaseStages[arg_8_0.stageId - 1].stageName)
			end

			local var_8_26 = ui.newTTFLabel({
				x = 300,
				text = var_8_25,
				font = _FONT_DEFAULT,
				size = Adapter.FontSize(24),
				color = var_8_5,
				align = ui.TEXT_ALIGN_LEFT,
				valign = ui.TEXT_VALIGN_CENTER,
				dimensions = CCSize(300, 40),
				y = 425 - iter_8_2 * 120
			})

			if IPlatform:instance():getConfig("Channel") == "ZSY_VN" then
				var_8_26:setDimensions(CCSize(280, 80))
			end

			var_8_6:addChild(var_8_26)
		end
	end

	local var_8_27 = display.newSprite("ui/common/common_005.png", 55, 538)

	var_8_6:addChild(var_8_27)

	local var_8_28 = display.newSprite("header/" .. var_8_13.bossHeader, 55, 538)

	var_8_6:addChild(var_8_28)

	local var_8_29 = ui.newTTFLabel({
		y = 566,
		x = 115,
		text = var_8_13.bossName,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(20),
		color = var_8_5,
		align = ui.TEXT_ALIGN_LEFT,
		valign = ui.TEXT_VALIGN_CENTER,
		dimensions = CCSize(160, 40)
	})

	var_8_6:addChild(var_8_29)

	for iter_8_4 = 1, var_8_1 do
		local var_8_30 = display.newSprite("ui/common/common_077.png", 100 + iter_8_4 * 30, 515)

		var_8_6:addChild(var_8_30)
	end

	local var_8_31 = false

	if Player.taskInfo.MaxPID == arg_8_0.stageId then
		local var_8_32 = display.newSprite("ui/battle/battle_065.png", 490, 540)

		var_8_6:addChild(var_8_32)
	end

	local var_8_33 = ui.newTTFLabel({
		y = 543,
		x = 305,
		text = string.lf("体力: "),
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(20),
		color = var_8_5,
		align = ui.TEXT_ALIGN_LEFT,
		valign = ui.TEXT_VALIGN_CENTER,
		dimensions = CCSize(160, 40)
	})

	var_8_6:addChild(var_8_33)

	local var_8_34 = createItemCountNode({
		type = ItemType.ePower,
		value = arg_8_0.stage.power,
		color = ccc3(148, 203, 221)
	})

	var_8_34:setPosition(ccp(380, 543))
	var_8_6:addChild(var_8_34)

	local var_8_35 = ui.newTTFLabel({
		y = 543,
		x = 115,
		text = string.lf("当前次数:#94CBDD %d/%d", arg_8_0.stage.battleMax - var_8_0, arg_8_0.stage.battleMax),
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(20),
		color = var_8_5,
		align = ui.TEXT_ALIGN_LEFT,
		valign = ui.TEXT_VALIGN_CENTER,
		dimensions = CCSize(220, 40)
	})

	var_8_6:addChild(var_8_35)
	Adapter.NodeAbsScale(var_8_35)

	local var_8_36 = 0.5
	local var_8_37 = CCArray:create()

	var_8_37:addObject(CCDelayTime:create(var_8_36))
	var_8_37:addObject(CCCallFunc:create(function()
		var_8_12 = var_8_12 - var_8_36

		if var_8_12 > 0 then
			for iter_12_0, iter_12_1 in ipairs(arg_8_0.timeLabels) do
				iter_12_1:setString(string.lf("冷却时间: %s", var_0_1(var_8_12)))
			end
		else
			for iter_12_2, iter_12_3 in ipairs(arg_8_0.timeLabels) do
				iter_12_3:setVisible(false)
			end

			for iter_12_4, iter_12_5 in ipairs(arg_8_0.idots) do
				iter_12_5:setVisible(false)
			end

			arg_8_0.timeLabels[1]:stopAllActions()
		end
	end))

	if arg_8_0.timeLabels[1] then
		arg_8_0.timeLabels[1]:runAction(CCRepeatForever:create(CCSequence:create(var_8_37)))
	end

	if #arg_8_0.stage.dropList > 0 and (Player.taskInfo.MaxPID == arg_8_0.stageId or var_8_13.isDropItem) then
		arg_8_0.tableview = arg_8_0:showRewardItems(arg_8_0.stage.dropList)

		var_8_6:addChild(arg_8_0.tableview)
	end

	return var_8_6
end

function var_0_2.tenTiemClickAction(arg_13_0, arg_13_1)
	GuideLayer:removeAllGuideLayer()

	local var_13_0 = 20

	if var_13_0 > Player.level then
		showFlashNotice(string.lf("%d级后开放~", var_13_0))

		return
	end

	arg_13_0.starLevel = arg_13_1

	if Player.taskInfo.CdTime > 0 and isEquipCountNotMax() then
		local var_13_1 = ""
		local var_13_2 = require("scenes.MessageBoxLayer").new()

		local function var_13_3(arg_14_0, arg_14_1)
			var_13_2:removeFromParentAndCleanup(true)
		end

		local var_13_4 = string.lf("上仙，您是否需要花费#FFFF00%d#FFFFFF元宝，解除冷却时间，以便快速扫荡此处%d次?", Player.taskInfo.BattleTenIngot, arg_13_0.battleCount)

		local function var_13_5()
			arg_13_0.buyColdTimeRequest:request()
			var_13_2:removeFromParentAndCleanup(true)
		end

		var_13_2:setContentAndButtons(var_13_4, string.lf("确定"), var_13_5, string.lf("取消"), var_13_3)
		CCDirector:sharedDirector():getRunningScene():addChild(var_13_2)
	elseif isConsumePropEnough(ItemType.ePower, arg_13_0.battleCount) and isEquipCountNotMax() then
		arg_13_0.battleTenRequest:request(arg_13_0.stageId, arg_13_0.starLevel)
	end
end

function var_0_2.battleClickAction(arg_16_0, arg_16_1)
	GuideLayer:removeAllGuideLayer()
	print("\n\n\n 消耗体力值: " .. arg_16_0.stage.power)

	if isConsumePropEnough(ItemType.ePower, arg_16_0.stage.power) and isEquipCountNotMax() then
		require("base.cache").set("BattleDiffculty", arg_16_1)
		print(" 战斗困难等级...." .. arg_16_1)
		require("scenes.battle.BattleOperator"):startBattle(eBattleType.Map, {
			id = arg_16_0.stageId,
			diffculty = arg_16_1
		}, function(arg_17_0, arg_17_1, arg_17_2)
			print(arg_17_2)

			if arg_17_0 == true then
				local var_17_0 = findChapterLastStageStatus(arg_17_2)

				Player:updateMapPoint(arg_17_2, arg_17_1.Star, arg_17_1.TodayWinCount, arg_17_1.NextCheckpoint)

				local var_17_1 = findChapterLastStageStatus(arg_17_2)
				local var_17_2

				if var_17_0 == nil and var_17_1 ~= nil then
					var_17_2 = true
				end

				game.enterMapChapterScene({
					stageId = arg_17_2,
					isFirstClearChapter = var_17_2
				})
			else
				game.enterMapChapterScene({
					stageId = arg_17_2
				})
			end
		end)
	end
end

function var_0_2.showRewardItems(arg_18_0, arg_18_1)
	local var_18_0 = CCTableView:create(CCSize(600, 200))

	var_18_0:setPosition(297, 435)
	var_18_0:setViewSize(CCSize(563, 200))
	var_18_0:ignoreAnchorPointForPosition(false)
	var_18_0:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_18_0:setDirection(kCCScrollViewDirectionHorizontal)

	local function var_18_1(arg_19_0)
		return 200, 120
	end

	local function var_18_2(arg_20_0)
		return #arg_18_1
	end

	local function var_18_3(arg_21_0, arg_21_1)
		local var_21_0 = arg_21_0:cellAtIndex(arg_21_1)
		local var_21_1 = arg_21_1 + 1

		if var_21_0 == nil then
			var_21_0 = CCTableViewCell:new()

			local var_21_2 = {
				isName = true,
				type = arg_18_1[var_21_1].Type,
				itemId = arg_18_1[var_21_1].ID or 1,
				nameColor = ccc3(239, 232, 195),
				count = arg_18_1[var_21_1].Count,
				level = arg_18_1[var_21_1].Level,
				clickAction = function()
					var_0_0.tipshandler(arg_18_1[var_21_1])
				end
			}
			local var_21_3 = figure.createHeader(var_21_2)

			var_21_3:setAnchorPoint(CCPoint(0.5, 0.5))
			var_21_3:setPosition(75, 100)

			local var_21_4 = getItemQuality(var_21_2.type, var_21_2.itemId)
			local var_21_5 = getQualityColor(var_21_4)

			var_21_3:setNameLabelColor(var_21_5)
			var_21_0:addChild(var_21_3)
		end

		return var_21_0
	end

	var_18_0:registerScriptHandler(var_18_1, CCTableView.kTableCellSizeForIndex)
	var_18_0:registerScriptHandler(var_18_2, CCTableView.kNumberOfCellsInTableView)
	var_18_0:registerScriptHandler(var_18_3, CCTableView.kTableCellSizeAtIndex)
	var_18_0:reloadData()

	return var_18_0
end

return var_0_2
