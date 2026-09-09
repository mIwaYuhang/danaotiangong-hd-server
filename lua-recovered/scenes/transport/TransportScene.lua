require("network.TransportRequest")
require("network.StoreRequest")

local var_0_0 = class("TransportScene", function()
	return display.newScene("TransportScene")
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0._currentTransportInfo = {}
	arg_2_0._isHiddenLowLevelHorse = false
	arg_2_0._startTransportButton = nil
	arg_2_0._transportLogButton = nil
	arg_2_0._transportCountDownLabel = nil

	arg_2_0:createNetworkRequest()

	arg_2_0.mapLayerTable = {}

	arg_2_0:createMapLayer()

	local var_2_0 = arg_2_0:createUILayer()

	arg_2_0:addChild(var_2_0)

	local var_2_1 = createPlayerAttrNode({
		ItemType.eGold,
		ItemType.eCoin
	})

	var_2_1:setPosition(ccp(20, 578 * Adapter.HeightScale))
	var_2_1:setScale(Adapter.MinScale)
	arg_2_0:addChild(var_2_1)
	arg_2_0.transportInfoRequest:request()
	arg_2_0:schedule(handler(arg_2_0, arg_2_0.refreshTransportTime), 3)
	arg_2_0.mapLayer:reloadData()
end

function var_0_0.onEnter(arg_3_0)
	if arg_3_0._currentTransportInfo.HaveTime == nil or arg_3_0._currentTransportInfo.HaveTime < 0 then
		GuideLayer:showGuideLayer(arg_3_0, arg_3_0, TaskEntryType.eEntryTransport, 2, nil, true)
	end

	GuideLayer:showMissionReward(arg_3_0, TaskType.eTaskTeaching, TaskEntryType.eEntryTransport, 1)
end

function var_0_0.refreshTransportTime(arg_4_0)
	if arg_4_0._currentTransportInfo.horseInfos == nil then
		return
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._currentTransportInfo.horseInfos) do
		iter_4_1.HaveTime = iter_4_1.HaveTime - 3
	end
end

function var_0_0.getTransportInfo(arg_5_0)
	return arg_5_0._currentTransportInfo
end

function var_0_0.createMapLayer(arg_6_0)
	arg_6_0.mapLayer = require("scenes.SliderLayer").new({
		cannotMoveOutSide = true,
		alwaysShowSideLayer = true,
		size = CCSizeMake(display.width, display.height),
		clipScaleX = Adapter.MaxScale,
		clipScaleY = Adapter.MaxScale,
		point = ccp(0, 0),
		numberHandler = function()
			return 2
		end,
		cellHandler = function(arg_8_0, arg_8_1)
			local var_8_0 = require("scenes.transport.TransportMapLayer").new({
				_horseInfoList = arg_6_0._currentTransportInfo.horseInfos,
				_currentMapId = arg_8_1,
				_hideLowLevel = arg_6_0._isHiddenLowLevelHorse,
				_uiNode = arg_6_0.uiNode,
				transportInfoHandler = handler(arg_6_0, arg_6_0.getTransportInfo)
			})

			arg_6_0.mapLayerTable[arg_8_1] = var_8_0

			arg_8_0:addChild(var_8_0)
		end,
		direction = SliderDirection.eHorizontal
	})

	arg_6_0:addChild(arg_6_0.mapLayer)
	arg_6_0.mapLayer:reloadData()
end

function var_0_0.startTransport(arg_9_0)
	GuideLayer:stepDone(TaskEntryType.eEntryTransport, 2)

	local var_9_0 = require("scenes.transport.StartTransportLayer").new({
		callback = handler(arg_9_0, arg_9_0.startTransportCallBack)
	})

	arg_9_0:addChild(var_9_0)
end

function var_0_0.hideLowLevelHorse(arg_10_0)
	arg_10_0._isHiddenLowLevelHorse = not arg_10_0._isHiddenLowLevelHorse

	arg_10_0:refreshMapLayer()
end

function var_0_0.reloadHorseInfoList(arg_11_0)
	print("TransportScene:reloadHorseInfoList")
	arg_11_0.transportInfoRequest:request()
end

function var_0_0.pushaBaoYou(arg_12_0)
	local function var_12_0()
		if arg_12_0._currentTransportInfo.HaveTime < 0 then
			GuideLayer:showGuideLayer(arg_12_0, arg_12_0, TaskEntryType.eEntryTransport, 2)
		end
	end

	local var_12_1 = require("scenes.transport.BlessInfoLayer").new({
		closecallback = var_12_0
	})

	arg_12_0:addChild(var_12_1)
	GuideLayer:removeGuideLayer(arg_12_0, TaskEntryType.eEntryTransport, 2)
end

function var_0_0.viewTransportLog(arg_14_0)
	local function var_14_0()
		if arg_14_0._currentTransportInfo.HaveTime < 0 then
			GuideLayer:showGuideLayer(arg_14_0, arg_14_0, TaskEntryType.eEntryTransport, 2)
		end
	end

	if arg_14_0._transportLogButton.noticeNode then
		arg_14_0._transportLogButton.noticeNode:removeAllChildrenWithCleanup(true)
	end

	local var_14_1 = require("scenes.slave.DlgReportLayer").new({
		type = DlgReportType.reportTransport,
		closecallback = var_14_0
	})

	arg_14_0:addChild(var_14_1)
	GuideLayer:removeGuideLayer(arg_14_0, TaskEntryType.eEntryTransport, 2)
end

function var_0_0.createUILayer(arg_16_0)
	local var_16_0 = {
		{
			fontSize = 30,
			bgSprite = "ui/common/common_105.png",
			bgSelected = "ui/common/common_105.png",
			type = 1,
			title = string.lf("开始运镖"),
			x = 105 * Adapter.WidthScale,
			y = 440 * Adapter.HeightScale,
			callfunc = function()
				arg_16_0:startTransport()
			end
		},
		[7] = {
			fontSize = 25,
			bgSprite = "ui/common/common_105.png",
			bgSelected = "ui/common/common_105.png",
			type = 7,
			title = string.lf("快速运镖"),
			x = 105 * Adapter.WidthScale,
			y = 380 * Adapter.HeightScale,
			callfunc = function()
				arg_16_0:onBtnEndTransportClicked()
			end
		},
		{
			bgSprite = "ui/common/common_019.png",
			bgSelected = "ui/common/common_055.png",
			type = 2,
			title = string.lf("隐藏低级"),
			x = 397 * Adapter.WidthScale,
			y = 40 * Adapter.HeightScale,
			callfunc = function()
				arg_16_0:hideLowLevelHorse()
			end
		},
		{
			bgSprite = "ui/common/common_019.png",
			bgSelected = "ui/common/common_055.png",
			type = 3,
			title = string.lf("换一批"),
			x = 567 * Adapter.WidthScale,
			y = 40 * Adapter.HeightScale,
			callfunc = function()
				arg_16_0:reloadHorseInfoList()
			end
		},
		{
			bgSprite = "uilocal/transport/transport_text_002.png",
			bgSelected = "uilocal/transport/transport_text_002.png",
			type = 4,
			title = "",
			x = 710 * Adapter.WidthScale,
			y = 590 * Adapter.HeightScale,
			callfunc = function()
				arg_16_0:pushaBaoYou()
			end
		},
		{
			bgSprite = "uilocal/transport/transport_text_003.png",
			bgSelected = "uilocal/transport/transport_text_003.png",
			type = 4,
			title = "",
			x = 810 * Adapter.WidthScale,
			y = 590 * Adapter.HeightScale,
			callfunc = function()
				arg_16_0:viewTransportLog()
			end
		},
		{
			bgSprite = "ui/common/common_070.png",
			bgSelected = "ui/common/common_070.png",
			type = 4,
			title = "",
			x = 910 * Adapter.WidthScale,
			y = 590 * Adapter.HeightScale,
			callfunc = function()
				Player:setTransportState(0)
				game.enterHomeScene()
			end
		}
	}

	arg_16_0.uiNode = CCNode:create()

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_1 = ui.newControlButton({
			clickAction = iter_16_1.callfunc,
			normalImage = iter_16_1.bgSprite,
			highlightedImage = iter_16_1.bgSelected,
			position = ccp(iter_16_1.x, iter_16_1.y),
			text = iter_16_1.title,
			scaleX = Adapter.MinScale,
			scaleY = Adapter.MinScale,
			fontSize = iter_16_1.fontSize or 24,
			fontName = _FONT_LISU
		})

		if iter_16_0 == 1 then
			arg_16_0._startTransportButton = var_16_1

			arg_16_0._startTransportButton:setTitleForState(CCString:create(""), CCControlStateDisabled)
		end

		if iter_16_0 == 5 then
			arg_16_0._transportLogButton = var_16_1
		end

		if iter_16_0 == 7 then
			arg_16_0._transprotQuickButton = var_16_1

			arg_16_0._transprotQuickButton:setVisible(false)
		end

		arg_16_0.uiNode:addChild(var_16_1)
	end

	local var_16_2 = display.newScale9Sprite("ui/common/common_064.png", 100 * Adapter.WidthScale, 535 * Adapter.HeightScale)

	var_16_2:setPreferredSize(Adapter.MinSize(347, 43))
	arg_16_0.uiNode:addChild(var_16_2)

	arg_16_0.transportNumLabel = ui.newTTFLabel({
		text = string.lf("今日剩余运镖次数: "),
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(20),
		align = ui.TEXT_ALIGN_CENTER,
		color = display.COLOR_WHITE,
		x = 40 * Adapter.WidthScale,
		y = 535 * Adapter.HeightScale
	})

	arg_16_0.transportNumLabel:setAnchorPoint(ccp(0, 0.5))
	arg_16_0.uiNode:addChild(arg_16_0.transportNumLabel)

	local var_16_3 = display.newScale9Sprite("ui/common/common_064.png", 100 * Adapter.WidthScale, 495 * Adapter.HeightScale)

	var_16_3:setPreferredSize(Adapter.MinSize(347, 43))
	arg_16_0.uiNode:addChild(var_16_3)

	arg_16_0.transportRobNumLabel = ui.newTTFLabel({
		text = string.lf("今日剩余劫镖次数: "),
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(20),
		align = ui.TEXT_ALIGN_CENTER,
		color = display.COLOR_WHITE,
		x = 40 * Adapter.WidthScale,
		y = 495 * Adapter.HeightScale
	})

	arg_16_0.transportRobNumLabel:setAnchorPoint(ccp(0, 0.5))
	arg_16_0.uiNode:addChild(arg_16_0.transportRobNumLabel)

	arg_16_0._transportCountDownLabel = addLabelWithColorSize(arg_16_0.uiNode, "", ccc3(225, 225, 49), 20, ccp(0.5, 0.5), Adapter.AutoPos(105, 437))

	arg_16_0._transportCountDownLabel:setVisible(false)

	return arg_16_0.uiNode
end

function var_0_0.findHorseInfo(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = false

	if arg_24_2 == nil then
		return var_24_0
	end

	for iter_24_0, iter_24_1 in ipairs(arg_24_2) do
		if iter_24_1.PlayerID == arg_24_1.PlayerID then
			var_24_0 = true
		end
	end

	return var_24_0
end

function var_0_0.createNetworkRequest(arg_25_0)
	local function var_25_0()
		local var_26_0 = arg_25_0._currentTransportInfo

		arg_25_0._currentTransportInfo = arg_25_0.transportInfoRequest:getTransportInfo()

		dump(arg_25_0._currentTransportInfo)
		arg_25_0:refreshMapLayer()
		arg_25_0:showRoblogNotice()
		arg_25_0.transportNumLabel:setString(string.lf("今日剩余运镖次数: %s", arg_25_0._currentTransportInfo.HaveTransTime))
		arg_25_0.transportRobNumLabel:setString(string.lf("今日剩余劫镖次数: %s", arg_25_0._currentTransportInfo.HaveRobTime))

		if arg_25_0._currentTransportInfo.HaveTime < 0 then
			print("self._currentTransportInfo.HaveTime")

			return
		end

		if arg_25_0._currentTransportInfo.HaveTime == 0 then
			arg_25_0:showGetReward()
			arg_25_0._transprotQuickButton:setVisible(false)

			return
		end

		if arg_25_0._currentTransportInfo.HaveTime > 0 then
			arg_25_0._startTransportButton:setEnabled(false)
			arg_25_0._transportCountDownLabel:setVisible(true)
			arg_25_0._transprotQuickButton:setVisible(true)
			arg_25_0:showTransportCountDownTime()

			if arg_25_0.countDownScheduleHandler ~= nil then
				arg_25_0:stopAction(arg_25_0.countDownScheduleHandler)

				arg_25_0.countDownScheduleHandler = nil
			end

			arg_25_0.countDownScheduleHandler = arg_25_0:schedule(handler(arg_25_0, arg_25_0.showTransportCountDownTime), 1)

			arg_25_0:showBudgetReward()

			return
		end
	end

	local function var_25_1(arg_27_0)
		return
	end

	arg_25_0.transportInfoRequest = TransportInfoRequest:new(arg_25_0)

	arg_25_0.transportInfoRequest:setResponseNormalHandler(var_25_0)
	arg_25_0.transportInfoRequest:setResponseExceptionHandler(var_25_1)

	local function var_25_2()
		arg_25_0.transportInfoRequest.restable = arg_25_0.endtransportRequest.restable

		var_25_0()
	end

	arg_25_0.endtransportRequest = EndTransportRequest:new(arg_25_0)

	arg_25_0.endtransportRequest:setResponseNormalHandler(var_25_2)
end

function var_0_0.showGetRewardDetail(arg_29_0, arg_29_1)
	local var_29_0 = display.newSprite("ui/common/common_064_2.png", 199, 231)

	arg_29_1:addChild(var_29_0)

	local var_29_1 = display.newSprite("uilocal/transport/transport_text_007.png", 199, 231)

	arg_29_1:addChild(var_29_1)

	local var_29_2 = string.lf("%d次", arg_29_0._currentTransportInfo.getReward.BeRobedTime)
	local var_29_3 = {
		{
			x = 37,
			y = 180,
			title = string.lf("被劫次数:"),
			color = ccc3(118, 112, 112)
		},
		{
			x = 137,
			y = 180,
			title = var_29_2,
			color = ccc3(118, 112, 112)
		},
		{
			x = 190,
			y = 180,
			title = string.lf("损失:"),
			color = ccc3(118, 112, 112)
		},
		{
			x = 37,
			y = 147,
			title = string.lf("普通收益:"),
			color = ccc3(39, 234, 48)
		},
		{
			x = 37,
			y = 114,
			title = string.lf("惊喜收益:"),
			color = ccc3(178, 127, 21)
		}
	}

	for iter_29_0, iter_29_1 in ipairs(var_29_3) do
		if iter_29_0 == 5 and arg_29_0._currentTransportInfo.getReward.SurpriseReward == nil then
			break
		end

		local var_29_4 = addLabelWithColorSize(arg_29_1, iter_29_1.title, iter_29_1.color, 20, ccp(0, 0.5), ccp(iter_29_1.x, iter_29_1.y))
	end

	local var_29_5 = createItemCountNode({
		color = ccc3(118, 112, 112),
		type = ItemType.eCoin,
		value = arg_29_0._currentTransportInfo.getReward.LostGold
	})

	var_29_5:setPosition(ccp(270, 180))
	var_29_5:setAnchorPoint(ccp(0.5, 0.5))
	arg_29_1:addChild(var_29_5)

	local var_29_6 = createItemCountNode({
		color = ccc3(39, 234, 48),
		type = ItemType.eCoin,
		value = arg_29_0._currentTransportInfo.getReward.Gold
	})

	var_29_6:setPosition(ccp(150, 147))
	var_29_6:setAnchorPoint(ccp(0.5, 0.5))
	arg_29_1:addChild(var_29_6)

	if arg_29_0._currentTransportInfo.getReward.SurpriseReward ~= nil then
		for iter_29_2, iter_29_3 in ipairs(arg_29_0._currentTransportInfo.getReward.SurpriseReward) do
			local var_29_7 = math.ceil(iter_29_2 / 2) - 1
			local var_29_8 = 190 + (iter_29_2 - 1) % 2 * 110
			local var_29_9 = 114 - var_29_7 * 30

			if iter_29_3.Type == ItemType.eGold then
				local var_29_10 = createItemCountNode({
					color = ccc3(178, 127, 21),
					type = iter_29_3.Type,
					value = iter_29_3.Count
				})

				var_29_10:setPosition(ccp(var_29_8 - 30, var_29_9))
				var_29_10:setAnchorPoint(ccp(0.5, 0.5))
				arg_29_1:addChild(var_29_10)
			else
				local var_29_11 = getItemName(iter_29_3.Type, iter_29_3.ID)
				local var_29_12

				if iter_29_3.Type == ItemType.eTransportTimes then
					var_29_12 = string.format("%s +%d", var_29_11, iter_29_3.Count)
				else
					var_29_12 = string.format("%s x%d", var_29_11, iter_29_3.Count)
				end

				addLabelWithColorSize(arg_29_1, var_29_12, ccc3(178, 127, 21), 20, ccp(0.5, 0.5), ccp(var_29_8, var_29_9))
			end
		end
	end
end

function var_0_0.showGetReward(arg_30_0)
	if arg_30_0.budgetRewardNode ~= nil then
		arg_30_0.budgetRewardNode:removeFromParent()

		arg_30_0.budgetRewardNode = nil
	end

	if arg_30_0._currentTransportInfo.getReward ~= nil then
		arg_30_0._operateLayer = require("scenes.team.PackageOperationLayer").new({
			isSwallow = true,
			position = CCPoint(display.cx, display.cy),
			size = Adapter.MinSize(390, 230),
			contentHandler = function(arg_31_0)
				arg_30_0:showGetRewardDetail(arg_31_0)
			end,
			touchCallback = function()
				return
			end,
			buttons = {
				{
					btnEnable = true,
					buttonBg = "ui/common/common_055.png",
					title = string.lf("领取奖励"),
					handler = function()
						arg_30_0._operateLayer:removeFromParent()

						arg_30_0._operateLayer = nil
					end
				}
			}
		})

		arg_30_0.uiNode:addChild(arg_30_0._operateLayer)
	end
end

function var_0_0.showTransportCountDownTime(arg_34_0)
	local var_34_0 = math.floor(arg_34_0._currentTransportInfo.HaveTime / 60)
	local var_34_1 = arg_34_0._currentTransportInfo.HaveTime % 60

	arg_34_0._transportCountDownLabel:setString(string.lf("剩余%02d:%02d", var_34_0, var_34_1))

	arg_34_0.NessGold = 0

	if var_34_1 ~= 0 then
		arg_34_0.NessGold = (var_34_0 + 1) * 10
	elseif var_34_1 == 0 then
		arg_34_0.NessGold = var_34_0 * 10
	end

	if arg_34_0._currentTransportInfo.HaveTime <= 0 then
		arg_34_0.transportInfoRequest:request()
		arg_34_0._startTransportButton:setEnabled(true)
		arg_34_0._transportCountDownLabel:setVisible(false)
		arg_34_0:stopAction(arg_34_0.countDownScheduleHandler)
	end

	arg_34_0._currentTransportInfo.HaveTime = arg_34_0._currentTransportInfo.HaveTime - 1
end

function var_0_0.showBudgetReward(arg_35_0)
	if arg_35_0.budgetRewardNode ~= nil then
		arg_35_0.budgetRewardNode:removeFromParent()

		arg_35_0.budgetRewardNode = nil
	end

	arg_35_0.budgetRewardNode = display.newScale9Sprite("ui/common/common_052.png", display.cx, 480 * Adapter.HeightScale, CCSizeMake(420, 100))

	arg_35_0.budgetRewardNode:setScale(Adapter.MinScale)
	arg_35_0.budgetRewardNode:setAnchorPoint(ccp(0.5, 0.5))
	arg_35_0.uiNode:addChild(arg_35_0.budgetRewardNode)

	if arg_35_0._currentTransportInfo.budgetReward ~= nil and table.nums(arg_35_0._currentTransportInfo.budgetReward) > 0 then
		local var_35_0 = {
			{
				x = 25,
				y = 74,
				title = string.lf("预计收益:"),
				color = ccc3(225, 225, 46)
			},
			{
				x = 25,
				y = 32,
				title = string.lf("好友战力加成:"),
				color = ccc3(225, 225, 46)
			},
			{
				x = 250,
				y = 32,
				title = string.lf("惊喜收益:"),
				color = ccc3(225, 225, 46)
			}
		}

		for iter_35_0, iter_35_1 in ipairs(var_35_0) do
			local var_35_1 = addLabelWithColorSize(arg_35_0.budgetRewardNode, iter_35_1.title, iter_35_1.color, 20, ccp(0, 0.5), ccp(iter_35_1.x, iter_35_1.y))
		end

		local var_35_2 = createItemCountNode({
			color = ccc3(255, 255, 0),
			type = ItemType.eCoin,
			value = arg_35_0._currentTransportInfo.budgetReward.Gold
		})

		var_35_2:setPosition(ccp(135, 74))
		var_35_2:setAnchorPoint(ccp(0.5, 0.5))
		arg_35_0.budgetRewardNode:addChild(var_35_2)

		local var_35_3 = arg_35_0._currentTransportInfo.budgetReward.HaveSreward == 1 and string.lf("有") or string.lf("无")
		local var_35_4 = string.format("+%d%%", arg_35_0._currentTransportInfo.budgetReward.Addition)
		local var_35_5 = {
			{
				x = 180,
				y = 32,
				title = var_35_4,
				color = ccc3(255, 241, 139)
			},
			{
				x = 350,
				y = 32,
				title = var_35_3,
				color = ccc3(255, 241, 139)
			}
		}

		for iter_35_2, iter_35_3 in ipairs(var_35_5) do
			local var_35_6 = addLabelWithColorSize(arg_35_0.budgetRewardNode, iter_35_3.title, iter_35_3.color, 20, ccp(0, 0.5), ccp(iter_35_3.x, iter_35_3.y))
		end
	end
end

function var_0_0.onBtnEndTransportClicked(arg_36_0)
	ui.showMessageBox({
		text = string.lf("上仙，您是否需要花费#FFFF00%d#FFFFFF元宝直接完成运镖！", arg_36_0.NessGold),
		title1 = string.lf("确定"),
		title2 = string.lf("取消"),
		action1 = function()
			if not isMoneyEnough(ItemType.eGold, arg_36_0.NessGold) then
				return
			else
				arg_36_0.endtransportRequest:request()
			end
		end
	})
end

function var_0_0.startTransportCallBack(arg_38_0, arg_38_1)
	arg_38_0.transportInfoRequest:request()
end

function var_0_0.refreshMapLayer(arg_39_0)
	for iter_39_0, iter_39_1 in ipairs(arg_39_0.mapLayerTable) do
		iter_39_1:reloadLayer(arg_39_0._currentTransportInfo.horseInfos, arg_39_0._isHiddenLowLevelHorse)
	end
end

function var_0_0.showRoblogNotice(arg_40_0)
	if arg_40_0._transportLogButton.noticeNode == nil then
		arg_40_0._transportLogButton.noticeNode = display.newNode()

		arg_40_0._transportLogButton:addChild(arg_40_0._transportLogButton.noticeNode)
	end

	arg_40_0._transportLogButton.noticeNode:removeAllChildrenWithCleanup(true)

	if arg_40_0._currentTransportInfo.IsHaveUnReadLog == nil or arg_40_0._currentTransportInfo.IsHaveUnReadLog == 0 then
		return
	end

	local var_40_0 = arg_40_0._transportLogButton:getPreferredSize()

	ui.createRedPoint({
		parent = arg_40_0._transportLogButton.noticeNode,
		position = ccp(var_40_0.width * 0.8, var_40_0.height * 0.75),
		scale = 0.7 * Adapter.MinScale
	})
end

return var_0_0
