local var_0_0 = require("scenes.ToolLayer")

AddressType = {
	eLihuo = 2,
	eSuoxian = 1
}

local var_0_1 = class("StartTransportLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create(ccc4(10, 10, 10, 150)))
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	addBlackLayer(arg_2_0)

	arg_2_0.callback = arg_2_1.callback

	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.friendIds = {}
	arg_2_0.addValue = 0

	arg_2_0:setBackground()

	arg_2_0.transportInfoLabels = {}
	arg_2_0.gotLabels = {}
	arg_2_0.preCoinLabels = {}

	arg_2_0:initRequests()

	arg_2_0.addressId = AddressType.eSuoxian

	arg_2_0:setHorseList()
	arg_2_0:setButtons()
	arg_2_0:setDesLabels()
	arg_2_0.transportSelectRequest:request()
end

function var_0_1.initRequests(arg_4_0)
	local function var_4_0()
		arg_4_0.transportInfo.HorseType = arg_4_0.callHorseRequest.restable.type

		arg_4_0:refreshTransportInfo()
		arg_4_0.selectCellBg:setPosition(CCPoint(arg_4_0.transportInfo.HorseType * 174 - 155, 375))
	end

	arg_4_0.callHorseRequest = CallHorseRequest:new()

	arg_4_0.callHorseRequest:setResponseNormalHandler(var_4_0)

	local function var_4_1()
		arg_4_0.transportInfo.HorseType = arg_4_0.refreshHorseRequest.restable.type
		arg_4_0.transportInfo.HaveRefreshTime = arg_4_0.transportInfo.HaveRefreshTime > 0 and arg_4_0.transportInfo.HaveRefreshTime - 1 or 0
		arg_4_0.transportInfo.RefreshNeedIngot = arg_4_0.transportInfo.HaveRefreshTime > 0 and 0 or 10

		arg_4_0:showRandomCelleBg(arg_4_0.transportInfo.HorseType)
	end

	arg_4_0.refreshHorseRequest = RefreshHorseRequest:new()

	arg_4_0.refreshHorseRequest:setResponseNormalHandler(var_4_1)

	local function var_4_2()
		local var_7_0 = arg_4_0.transportInfo.AddLst[arg_4_0.addressId]
		local var_7_1 = arg_4_0.transportInfo.HorseLst[arg_4_0.transportInfo.HorseType]
		local var_7_2 = isSelectSuoxian and 1 or 1.6
		local var_7_3 = {
			HaveTime = var_7_0.Times,
			HorseType = arg_4_0.transportInfo.HorseType,
			budgetReward = {}
		}

		var_7_3.budgetReward.Gold = var_7_1.Gold * var_7_2
		var_7_3.budgetReward.Knowledge = var_7_1.Knowledge * var_7_2
		var_7_3.budgetReward.Blessing = arg_4_0.transportInfo.Blessing
		var_7_3.budgetReward.FriendCount = arg_4_0.addValue
		var_7_3.budgetReward.Addition = var_7_1.HaveSreward

		arg_4_0.callback(var_7_3)
		arg_4_0:removeFromParentAndCleanup(true)
	end

	arg_4_0.startTransportRequest = StartTransportRequest:new()

	arg_4_0.startTransportRequest:setResponseNormalHandler(var_4_2)

	local function var_4_3()
		arg_4_0.transportInfo = arg_4_0.transportSelectRequest.restable

		arg_4_0:refreshTransportInfo()
		GuideLayer:showGuideLayer(nil, arg_4_0.bgSprite, TaskEntryType.eEntryTransport, 3)
	end

	arg_4_0.transportSelectRequest = TransportSelectRequest:new()

	arg_4_0.transportSelectRequest:setResponseNormalHandler(var_4_3)
end

function var_0_1.refreshTransportInfo(arg_9_0)
	local var_9_0 = arg_9_0.transportInfo.HorseLst[arg_9_0.transportInfo.HorseType]
	local var_9_1 = arg_9_0.transportInfo.AddLst[arg_9_0.addressId]
	local var_9_2 = arg_9_0.addressId == AddressType.eSuoxian
	local var_9_3 = (var_9_2 and 1 or 2.6) + arg_9_0.transportInfo.Blessing / 100
	local var_9_4 = convertColorToLabelString(ccc3(255, 241, 139))
	local var_9_5 = {
		{
			fontSize = 24,
			y = 560,
			type = 1,
			x = 40,
			title = string.lf("剩余运送次数:%s%s", var_9_4, arg_9_0.transportInfo.HaveTransTime or 111),
			color = ccc3(255, 166, 54),
			size = CCSize(300, 40)
		},
		{
			fontSize = 17,
			y = 175,
			type = 2,
			x = 60,
			title = string.lf("消耗次数:"),
			color = ccc3(188, 42, 18),
			size = CCSize(300, 40)
		},
		{
			fontSize = 20,
			y = 210,
			type = 3,
			x = 330,
			title = string.lf("运送时间:%s%s分钟%s", var_9_4, var_9_1.Times, "" or "0"),
			color = ccc3(255, 166, 54),
			size = CCSize(200, 40)
		},
		{
			fontSize = 20,
			y = 140,
			type = 6,
			x = 330,
			title = string.lf("拜佛收益:%s%s%s", var_9_4, arg_9_0.transportInfo.Blessing, "%" or "0%"),
			color = ccc3(255, 166, 54),
			size = CCSize(200, 40)
		},
		{
			fontSize = 20,
			y = 105,
			type = 7,
			x = 330,
			title = var_9_0.HaveSreward == 1 and string.lf("惊喜收益:%s有", var_9_4) or string.lf("惊喜收益:%s无", var_9_4),
			color = ccc3(255, 166, 54),
			size = CCSize(200, 40)
		},
		{
			fontSize = 20,
			y = 200,
			type = 8,
			x = 650,
			title = string.lf("剩余免费刷新次数:%s", arg_9_0.transportInfo.HaveRefreshTime or 0),
			color = ccc3(255, 166, 54),
			size = CCSize(300, 40)
		},
		{
			fontSize = 24,
			y = 40,
			type = 10,
			x = 820,
			title = string.lf("%d%%", arg_9_0.addValue),
			color = ccc3(255, 166, 54),
			size = CCSize(200, 40)
		}
	}

	for iter_9_0 = 1, #var_9_5 do
		local var_9_6 = var_9_5[iter_9_0]

		if #arg_9_0.transportInfoLabels == #var_9_5 then
			arg_9_0.transportInfoLabels[iter_9_0]:setString(var_9_6.title)

			if iter_9_0 == 2 then
				arg_9_0.transportInfoLabels[2]:setPosition(210, var_9_2 and 175 or 115)
				arg_9_0.addressBg:setPosition(160, var_9_2 and 190 or 130)
				arg_9_0.suoxianLabel:setColor(var_9_2 and ccc3(0, 0, 0) or ccc3(255, 241, 139))
				arg_9_0.lihuoLabel:setColor(var_9_2 and ccc3(255, 241, 139) or ccc3(0, 0, 0))
			end
		else
			local var_9_7 = ui.newTTFLabel({
				text = var_9_6.title,
				font = _FONT_DEFAULT,
				size = Adapter.FontSize(var_9_6.fontSize),
				color = var_9_6.color,
				align = ui.TEXT_ALIGN_LEFT,
				valign = ui.TEXT_VALIGN_CENTER,
				dimensions = var_9_6.size,
				x = var_9_6.x,
				y = var_9_6.y
			})

			arg_9_0.bgSprite:addChild(var_9_7)
			Adapter.NodeAbsScale(var_9_7)
			table.insert(arg_9_0.transportInfoLabels, var_9_7)
		end
	end

	arg_9_0.consumeNumber01:setVisible(var_9_2)
	arg_9_0.consumeNumber02:setVisible(not var_9_2)

	local var_9_8 = {
		{
			fontSize = 20,
			y = 175,
			x = 437,
			type = ItemType.eCoin,
			title = string.format("%d", math.showDecimal(var_9_0.Gold * var_9_3, 0)) or 0,
			color = ccc3(255, 241, 139),
			size = CCSize(300, 40)
		},
		{
			fontSize = 20,
			y = 105,
			x = 737,
			type = ItemType.eGold,
			title = arg_9_0.transportInfo.RefreshNeedIngot or 0,
			color = ccc3(255, 241, 139),
			size = CCSize(100, 40)
		}
	}

	for iter_9_1 = 1, #var_9_8 do
		local var_9_9 = var_9_8[iter_9_1]

		if #arg_9_0.gotLabels == #var_9_8 then
			arg_9_0.gotLabels[iter_9_1]:setValue(var_9_9.title)
		else
			local var_9_10 = createItemCountNode({
				color = var_9_9.color,
				type = var_9_9.type,
				value = var_9_9.title
			})

			var_9_10:setPosition(ccp(var_9_9.x, var_9_9.y))
			var_9_10:setAnchorPoint(ccp(0.5, 0.5))
			arg_9_0.bgSprite:addChild(var_9_10)
			table.insert(arg_9_0.gotLabels, var_9_10)
		end
	end

	for iter_9_2 = 1, 5 do
		local var_9_11 = arg_9_0.transportInfo.HorseLst[iter_9_2]
		local var_9_12 = math.showDecimal(var_9_11.Gold * var_9_3, 0)

		if #arg_9_0.preCoinLabels == 5 then
			arg_9_0.preCoinLabels[iter_9_2]:setValue(string.format("%d", var_9_12) or 0)
		else
			local var_9_13 = createItemCountNode({
				color = ccc3(255, 241, 139),
				type = ItemType.eCoin,
				value = string.format("%d", var_9_12) or 0
			})

			var_9_13:setPosition(ccp(iter_9_2 * 172 - 100, 305))
			var_9_13:setAnchorPoint(ccp(0.5, 0.5))
			arg_9_0.bgSprite:addChild(var_9_13)
			table.insert(arg_9_0.preCoinLabels, var_9_13)
		end
	end

	local var_9_14 = arg_9_0.transportInfo.HorseType

	if not arg_9_0.selectCellBg then
		arg_9_0.selectCellBg = display.newSprite("ui/transport/transport_002.png")

		arg_9_0.selectCellBg:align(display.CENTER_LEFT, 0, 0)
		arg_9_0.selectCellBg:setScale(1)
		arg_9_0.bgSprite:addChild(arg_9_0.selectCellBg)
		arg_9_0.selectCellBg:setPosition(CCPoint(var_9_14 * 174 - 155, 375))
	end
end

function var_0_1.setButtons(arg_10_0)
	local var_10_0 = {
		{
			fontSize = 30,
			bgSprite = "ui/common/common_105.png",
			y = 40,
			type = 1,
			x = 450,
			title = string.lf("开始运镖"),
			callfunc = function()
				arg_10_0:doneButtonPressed()
			end
		},
		{
			y = 40,
			bgSprite = "ui/common/common_019.png",
			bgSelected = "ui/common/common_055.png",
			type = 2,
			x = 740,
			title = string.lf("仙友护卫"),
			callfunc = function()
				arg_10_0:friendGuard()
			end
		},
		{
			y = 155,
			bgSprite = "ui/common/common_019.png",
			bgSelected = "ui/common/common_055.png",
			type = 3,
			disabledImage = "ui/common/common_080.png",
			x = 740,
			title = string.lf("刷新品质"),
			callfunc = function()
				arg_10_0:refreshHorse()
			end
		},
		{
			y = 190,
			bgSprite = "ui/common/common_027.png",
			type = 4,
			x = 235,
			title = string.lf("选定"),
			callfunc = function()
				arg_10_0:selectedSuoxian()
			end
		},
		{
			y = 130,
			bgSprite = "ui/common/common_027.png",
			type = 5,
			x = 235,
			title = string.lf("选定"),
			callfunc = function()
				arg_10_0:selectedLihuo()
			end
		},
		{
			y = 500,
			bgSprite = "ui/transport/transport_022.png",
			type = 6,
			x = 796,
			title = string.lf("召唤我"),
			callfunc = function()
				arg_10_0:callHorse()
			end,
			textColor = display.COLOR_BLACK
		}
	}

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1 = ui.newControlButton({
			clickAction = iter_10_1.callfunc,
			normalImage = iter_10_1.bgSprite,
			highlightedImage = iter_10_1.bgSelected,
			disabledImage = iter_10_1.disabledImage,
			fontName = _FONT_LISU,
			position = ccp(iter_10_1.x, iter_10_1.y),
			text = iter_10_1.title,
			fontSize = iter_10_1.fontSize or 22,
			textColor = iter_10_1.textColor or ColorTable.eTitleTabButton_Selected
		})

		arg_10_0.bgSprite:addChild(var_10_1, 1)

		if iter_10_1.type == 3 then
			arg_10_0.refreshButton = var_10_1
		end
	end
end

function var_0_1.setBackground(arg_17_0)
	arg_17_0.bgSprite = display.newScale9Sprite("ui/transport/transport_010.png", display.cx, display.cy, CCSizeMake(898, 600))

	arg_17_0.bgSprite:setScale(Adapter.MinScale)
	arg_17_0:addChild(arg_17_0.bgSprite)

	local function var_17_0()
		GuideLayer:removeOneGuideLayer(TaskEntryType.eEntryTransport)
		arg_17_0:removeFromParentAndCleanup(true)
	end

	local var_17_1 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		position = ccp(850, 560),
		clickAction = var_17_0
	})

	arg_17_0.bgSprite:addChild(var_17_1)

	for iter_17_0 = 0, 2 do
		local var_17_2 = CCScale9Sprite:create("ui/transport/transport_001.png")

		var_17_2:setPreferredSize(CCSize(285, 160))
		var_17_2:setPosition(CCPoint(160 + 292 * iter_17_0, 160))
		arg_17_0.bgSprite:addChild(var_17_2)
	end
end

function var_0_1.setHorseList(arg_19_0)
	local var_19_0 = {
		string.lf("木船"),
		string.lf("花船"),
		string.lf("虎船"),
		string.lf("凤船"),
		string.lf("龙船")
	}
	local var_19_1 = {
		ccc3(255, 255, 255),
		ccc3(60, 249, -0),
		ccc3(5, 51, 255),
		ccc3(247, 63, 255),
		ccc3(255, 250, 0)
	}
	local var_19_2 = {
		"transport_008.png",
		"transport_007.png",
		"transport_006.png",
		"transport_005.png",
		"transport_004.png"
	}
	local var_19_3 = {
		"transport_023.png",
		"transport_024.png",
		"transport_025.png",
		"transport_026.png",
		"transport_027.png"
	}

	for iter_19_0 = 0, 4 do
		local var_19_4 = display.newSprite("ui/transport/" .. var_19_3[iter_19_0 + 1])

		var_19_4:setPosition(CCPoint(100 + iter_19_0 * 174, 375))
		arg_19_0.bgSprite:addChild(var_19_4)

		local var_19_5 = display.newSprite("ui/transport/" .. var_19_2[iter_19_0 + 1])

		var_19_5:setPosition(CCPoint(100 + iter_19_0 * 174, 395))
		arg_19_0.bgSprite:addChild(var_19_5)

		local var_19_6 = ui.newTTFLabel({
			y = 265,
			text = var_19_0[iter_19_0 + 1],
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(26),
			color = var_19_1[iter_19_0 + 1],
			align = ui.TEXT_ALIGN_CENTER,
			valign = ui.TEXT_VALIGN_CENTER,
			dimensions = CCSize(200, 40),
			x = 100 + iter_19_0 * 174
		})

		arg_19_0.bgSprite:addChild(var_19_6)
		Adapter.NodeAbsScale(var_19_6)
	end
end

function var_0_1.setDesLabels(arg_20_0)
	local var_20_0 = {
		{
			fontSize = 22,
			y = 200,
			type = 2,
			x = 40,
			title = string.lf("1、锁仙岛"),
			color = ccc3(0, 0, 0),
			size = CCSize(160, 40)
		},
		{
			fontSize = 22,
			y = 140,
			type = 3,
			x = 40,
			title = string.lf("2、离火岛"),
			color = ccc3(255, 241, 139),
			size = CCSize(160, 40)
		},
		{
			fontSize = 20,
			y = 175,
			type = 6,
			x = 330,
			title = string.lf("预计收益:"),
			color = ccc3(255, 166, 54),
			size = CCSize(100, 40)
		}
	}

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		local var_20_1 = ui.newTTFLabel({
			text = iter_20_1.title,
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(iter_20_1.fontSize),
			color = iter_20_1.color,
			align = ui.TEXT_ALIGN_LEFT,
			valign = ui.TEXT_VALIGN_CENTER,
			dimensions = iter_20_1.size,
			x = iter_20_1.x,
			y = iter_20_1.y
		})

		arg_20_0.bgSprite:addChild(var_20_1, 1)
		Adapter.NodeAbsScale(var_20_1)

		if iter_20_1.type == 4 then
			arg_20_0.consumeLabel = var_20_1
		elseif iter_20_1.type == 2 then
			arg_20_0.suoxianLabel = var_20_1
		elseif iter_20_1.type == 3 then
			arg_20_0.lihuoLabel = var_20_1
		end
	end

	arg_20_0.addressBg = CCScale9Sprite:create("ui/transport/transport_009.png")

	arg_20_0.addressBg:setPreferredSize(CCSize(260, 60))
	arg_20_0.addressBg:setPosition(160, 190)
	arg_20_0.bgSprite:addChild(arg_20_0.addressBg, 0)

	arg_20_0.consumeNumber01 = display.newSprite("uilocal/transport/transport_text_009.png")

	arg_20_0.consumeNumber01:align(display.CENTER_LEFT, 0, 0)
	arg_20_0.consumeNumber01:setPosition(150, 175)
	arg_20_0.consumeNumber01:setScale(1)
	arg_20_0.bgSprite:addChild(arg_20_0.consumeNumber01)
	arg_20_0.consumeNumber01:setVisible(false)

	arg_20_0.consumeNumber02 = display.newSprite("uilocal/transport/transport_text_010.png")

	arg_20_0.consumeNumber02:align(display.CENTER_LEFT, 0, 0)
	arg_20_0.consumeNumber02:setPosition(150, 115)
	arg_20_0.consumeNumber02:setScale(1)
	arg_20_0.bgSprite:addChild(arg_20_0.consumeNumber02)
	arg_20_0.consumeNumber02:setVisible(false)
end

function var_0_1.doneButtonPressed(arg_21_0)
	if arg_21_0.transportInfo.HaveTransTime <= 0 then
		var_0_0.createDialog({
			show = var_0_0.eShowTranportEmpty,
			callback = function(arg_22_0, arg_22_1)
				if arg_22_0 then
					arg_21_0.transportInfo.HaveTransTime = arg_21_0.transportInfo.HaveTransTime + 1

					GuideLayer:removeGuideLayer(nil, TaskEntryType.eEntryTransport, 3)
					arg_21_0.startTransportRequest:request(arg_21_0.addressId, arg_21_0.friendIds)
				end
			end
		}):show()
	else
		GuideLayer:removeGuideLayer(nil, TaskEntryType.eEntryTransport, 3)
		arg_21_0.startTransportRequest:request(arg_21_0.addressId, arg_21_0.friendIds)
	end
end

function var_0_1.friendGuard(arg_23_0)
	local function var_23_0(arg_24_0, arg_24_1)
		arg_23_0.friendIds = arg_24_0
		arg_23_0.addValue = toint(arg_24_1)

		arg_23_0:refreshTransportInfo()
	end

	local var_23_1 = require("scenes.transport.TransportFriendsLayer").new({
		_callbackFunc = var_23_0
	})

	var_23_1:setPosition(ccp(449, 300))
	arg_23_0.bgSprite:addChild(var_23_1, 2)
end

function var_0_1.refreshHorse(arg_25_0)
	if arg_25_0.transportInfo.HorseType == 5 then
		local var_25_0 = string.lf("已是最高级别~")

		arg_25_0:addChild(require("scenes.FlashNotice").new(var_25_0))

		return
	end

	if arg_25_0.transportInfo.HaveTransTime <= 0 then
		var_0_0.createDialog({
			show = var_0_0.eShowTranportEmpty,
			callback = function(arg_26_0, arg_26_1)
				if arg_26_0 then
					arg_25_0.transportInfo.HaveTransTime = arg_25_0.transportInfo.HaveTransTime + 1

					arg_25_0.refreshHorseRequest:request(0)
					arg_25_0.refreshButton:setEnabled(false)
				end
			end
		}):show()
	else
		arg_25_0.refreshHorseRequest:request(0)
		arg_25_0.refreshButton:setEnabled(false)
	end
end

function var_0_1.selectedSuoxian(arg_27_0)
	arg_27_0.addressId = AddressType.eSuoxian

	arg_27_0:refreshTransportInfo()
end

function var_0_1.selectedLihuo(arg_28_0)
	if arg_28_0.transportInfo.HaveTransTime <= 1 then
		arg_28_0.dialog = var_0_0.createDialog({
			show = var_0_0.eShowTranportEmpty,
			callback = function(arg_29_0, arg_29_1)
				if arg_29_0 then
					arg_28_0.transportInfo.HaveTransTime = arg_28_0.transportInfo.HaveTransTime + 1

					if arg_28_0.transportInfo.HaveTransTime <= 1 then
						arg_28_0.addressId = AddressType.eSuoxian
					else
						arg_28_0.addressId = AddressType.eLihuo
					end

					arg_28_0:refreshTransportInfo()
				end
			end
		})

		arg_28_0.dialog:show()
	else
		arg_28_0.addressId = AddressType.eLihuo

		arg_28_0:refreshTransportInfo()
	end
end

function var_0_1.callHorse(arg_30_0)
	if arg_30_0.transportInfo.HaveTransTime <= 0 then
		var_0_0.createDialog({
			show = var_0_0.eShowTranportEmpty,
			callback = function(arg_31_0, arg_31_1)
				if arg_31_0 then
					arg_30_0.transportInfo.HaveTransTime = arg_30_0.transportInfo.HaveTransTime + 1
				end
			end
		}):show()

		return
	end

	if arg_30_0.transportInfo.HorseType == 5 then
		local var_30_0 = string.lf("已是最高级别~")

		arg_30_0:addChild(require("scenes.FlashNotice").new(var_30_0))

		return
	end

	local var_30_1 = require("scenes.MessageBoxLayer").new()

	local function var_30_2(arg_32_0, arg_32_1)
		var_30_1:removeFromParentAndCleanup(true)
	end

	local var_30_3 = 5

	local function var_30_4()
		var_30_3 = 5

		arg_30_0.callHorseRequest:request(var_30_3)
		var_30_1:removeFromParentAndCleanup(true)
	end

	local var_30_5 = string.lf("上仙，您是否花费 #FFFF00%d#FFFFFF 元宝召唤龙船？", arg_30_0.transportInfo.HorseLst[var_30_3].CallCost)

	var_30_1:setContentAndButtons(var_30_5, string.lf("确定"), var_30_4, string.lf("取消"), var_30_2)
	CCDirector:sharedDirector():getRunningScene():addChild(var_30_1)
end

function var_0_1.showRandomCelleBg(arg_34_0, arg_34_1)
	local var_34_0 = 0.03

	local function var_34_1()
		local var_35_0 = CCSkeletonAnimation:createWithFile("effectAni/ui_yunbiao.json", "effectAni/ui_yunbiao.atlas", 1)
		local var_35_1 = CCCallFunc:create(function()
			var_35_0:removeFromParentAndCleanup(true)
		end)

		var_35_0:setAnimation("animation", false, 0)
		var_35_0:setPosition(0, 262)
		var_35_0:addAnimationAction("animation", 1, var_35_1, AAT_Percent)
		arg_34_0.selectCellBg:addChild(var_35_0)
	end

	local var_34_2 = CCArray:create()

	var_34_2:addObject(CCMoveTo:create(var_34_0, ccp(arg_34_1 * 174 - 155, 375)))
	var_34_2:addObject(CCCallFunc:create(var_34_1))
	arg_34_0.selectCellBg:runAction(CCSequence:create(var_34_2))
	arg_34_0.refreshButton:setEnabled(true)
	arg_34_0:refreshTransportInfo()
end

return var_0_1
