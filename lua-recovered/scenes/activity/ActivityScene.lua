require("base.functions")

local var_0_0 = class("ActivityScene", function()
	return display.newScene("ActivityScene")
end)

ActivityType = {
	eDailySalary = 13,
	eLingZhi = 5,
	eGrowUpPlan = 10,
	eGoldGod = 1,
	eLuckyDisk = 3,
	eLevelupGift = 9,
	eSanHua = 6,
	eBlackMarket = 11,
	eFriendPromote = 12,
	eSignMonth = 4,
	eFirstRecharge = 7,
	eSevenSignGift = 2,
	eDailyShare = 8,
	eWeekMonthCard = 14
}

local var_0_1 = {
	[ActivityType.eSevenSignGift] = "scenes.activity.SevenLoginRewardLayer",
	[ActivityType.eLuckyDisk] = "scenes.activity.LuckyDiskLayer",
	[ActivityType.eSignMonth] = "scenes.activity.SignMonthLayer",
	[ActivityType.eLingZhi] = "scenes.activity.LingZhiLayer",
	[ActivityType.eSanHua] = "scenes.activity.SanHuaLayer",
	[ActivityType.eFirstRecharge] = "scenes.activity.FirstRechargeLayer",
	[ActivityType.eDailyShare] = "scenes.activity.DailyShareLayer",
	[ActivityType.eLevelupGift] = "scenes.activity.LevelupGiftLayer",
	[ActivityType.eGrowUpPlan] = "scenes.activity.GrowUpPlanLayer",
	[ActivityType.eGoldGod] = "scenes.activity.GoldActivityLayer",
	[ActivityType.eBlackMarket] = "scenes.activity.BlackMarketLayer",
	[ActivityType.eFriendPromote] = "scenes.activity.FriendPromoteLayer",
	[ActivityType.eDailySalary] = "scenes.activity.DailySalaryLayer",
	[ActivityType.eWeekMonthCard] = "scenes.activity.WeekMonthCardLayer"
}
local var_0_2 = {}

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or {}
	arg_2_0.returnAction = arg_2_1.returnAction
	arg_2_0.container = nil

	local var_2_0 = Player:getGoldGodStatus() and ActivityType.eGoldGod or ActivityType.eSevenSignGift

	arg_2_0.showType = arg_2_1.type or var_2_0
	var_0_2 = {}

	arg_2_0:addSchedule()
	arg_2_0:onEnterScene()
end

function var_0_0.onExit(arg_3_0)
	arg_3_0:removeSchedule()
end

function var_0_0.onEnterScene(arg_4_0)
	local var_4_0 = Adapter.MinScale
	local var_4_1 = display.newSprite("ui/activity/activity_047.jpg")
	local var_4_2 = var_4_1:getContentSize()

	var_4_1:setScale(var_4_0)
	var_4_1:setPosition(display.cx, display.cy)
	arg_4_0:addChild(var_4_1)

	local var_4_3 = math.min(var_4_2.width * var_4_0, display.width) / var_4_0
	local var_4_4 = CCSize(var_4_3, 60)
	local var_4_5 = CCNode:create()

	var_4_5:setContentSize(var_4_4)

	local var_4_6 = display.newSprite("ui/activity/activity_055.png")

	var_4_6:setAnchorPoint(ccp(0, 0.5))
	var_4_6:setPosition(-3, var_4_4.height / 2)
	var_4_5:addChild(var_4_6)

	local var_4_7 = display.newSprite("uilocal/activity/activity_text_001.png")

	var_4_7:setAnchorPoint(ccp(0, 0.5))
	var_4_7:setPosition(120, var_4_4.height / 2)
	var_4_5:addChild(var_4_7)

	local var_4_8 = display.newSprite("ui/activity/activity_054.png")

	var_4_8:setAnchorPoint(ccp(1, 0.5))
	var_4_8:setPosition(var_4_4.width + 5, var_4_4.height / 2)
	var_4_5:addChild(var_4_8)

	local var_4_9 = createPlayerAttrNode({
		ItemType.eGold,
		ItemType.eCoin
	})

	var_4_9:setPosition(var_4_4.width - 490, 8)
	var_4_5:addChild(var_4_9)

	local var_4_10 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		clickAction = arg_4_0.returnAction or function()
			game.enterHomeScene()
		end
	})

	var_4_10:setPosition(var_4_4.width - 40, 28)
	var_4_5:addChild(var_4_10)
	var_4_5:setAnchorPoint(ccp(0.5, 1))
	var_4_5:setPosition(var_4_2.width / 2, var_4_2.height)
	var_4_1:addChild(var_4_5)

	local var_4_11 = CCSize(CONFIG_SCREEN_WIDTH, CONFIG_SCREEN_HEIGHT - 60)
	local var_4_12 = CCNode:create()

	var_4_12:setContentSize(var_4_11)
	var_4_12:setPosition((var_4_2.width - var_4_11.width) / 2, 0)
	var_4_1:addChild(var_4_12)

	arg_4_0.container = var_4_12

	arg_4_0:createTableView(arg_4_0.showType)

	local var_4_13 = display.newSprite("ui/common/common_043.png", 66, 564)

	var_4_12:addChild(var_4_13)

	local var_4_14 = display.newSprite("ui/common/common_044.png", 66, 16)

	var_4_12:addChild(var_4_14)
end

function var_0_0.createTableView(arg_6_0, arg_6_1)
	local var_6_0 = Player:getServerVipEnable()
	local var_6_1 = {}

	if Player:getGoldGodStatus() ~= nil then
		table.insert(var_6_1, {
			image = "ui/activity/activity_107.png",
			type = ActivityType.eGoldGod,
			actionShowFunc = function()
				return Player:getGoldGodStatus() or 0
			end,
			eventName = PalyerEvents.eGoldGodNotice
		})
	end

	if Player.sevenLoginCount > 0 then
		table.insert(var_6_1, {
			image = "ui/activity/activity_040.png",
			type = ActivityType.eSevenSignGift,
			actionShowFunc = function()
				return Player.sevenLoginCount
			end,
			eventName = PalyerEvents.eSevenLoginNotice
		})
	end

	table.insert(var_6_1, {
		image = "ui/activity/activity_046.png",
		type = ActivityType.eLuckyDisk,
		actionShowFunc = function()
			return Player.luckyDiskCount
		end,
		eventName = PalyerEvents.eLuckyDiskNotice
	})

	if Player:getBlackMarketStatus() ~= nil then
		table.insert(var_6_1, {
			image = "ui/activity/activity_116.png",
			type = ActivityType.eBlackMarket
		})
	end

	table.insert(var_6_1, {
		image = "ui/activity/activity_044.png",
		type = ActivityType.eSignMonth,
		actionShowFunc = function()
			return Player.signMonthCount
		end,
		eventName = PalyerEvents.eSignMonthNotice
	})
	table.insert(var_6_1, {
		image = "ui/activity/activity_043.png",
		type = ActivityType.eLingZhi,
		actionShowFunc = function()
			return Player.lingZhiCount
		end,
		eventName = PalyerEvents.eLingZhiNotice
	})
	table.insert(var_6_1, {
		image = "ui/activity/activity_042.png",
		type = ActivityType.eSanHua,
		actionShowFunc = function()
			return Player.sanHuaCount
		end,
		eventName = PalyerEvents.eSanHuaNotice
	})

	if IPlatform:instance():getConfig("Channel") ~= "ZSY_VN" then
		table.insert(var_6_1, {
			image = "ui/activity/activity_126.png",
			type = ActivityType.eWeekMonthCard
		})
	end

	if Player.firstRechargeCount > 0 then
		table.insert(var_6_1, {
			image = "ui/activity/activity_080.png",
			type = ActivityType.eFirstRecharge,
			actionShowFunc = function()
				return Player.firstRechargeCount
			end,
			eventName = PalyerEvents.eFirstRechargeNotice
		})
	end

	if var_6_0 == true then
		table.insert(var_6_1, {
			image = "ui/activity/activity_082.png",
			type = ActivityType.eDailyShare
		})
		table.insert(var_6_1, {
			image = "ui/activity/activity_119.png",
			type = ActivityType.eFriendPromote
		})
	end

	table.insert(var_6_1, {
		image = "ui/activity/activity_120.png",
		type = ActivityType.eDailySalary,
		eventName = PalyerEvents.eDailySalaryNotice,
		actionShowFunc = function()
			return Player.dailySalaryCount
		end
	})

	if Player.isLevelGiftDisplay then
		table.insert(var_6_1, {
			image = "ui/activity/activity_088.png",
			type = ActivityType.eLevelupGift,
			actionShowFunc = function()
				return Player:getLevelGiftStatus()
			end,
			eventName = PalyerEvents.eLevelGiftDisplay
		})
	end

	if Player.isGrowupDisplay then
		table.insert(var_6_1, {
			image = "ui/activity/activity_095.png",
			type = ActivityType.eGrowUpPlan,
			actionShowFunc = function()
				return Player:getGrowupStatus()
			end,
			eventName = PalyerEvents.eGrowupDisplay
		})
	end

	local var_6_2 = CCSize(125, 117)
	local var_6_3 = CCSize(125, 518)
	local var_6_4 = table.nums(var_6_1)

	local function var_6_5(arg_17_0, arg_17_1)
		arg_6_1 = tolua.cast(arg_17_1, "CCControlButton").tag

		arg_6_0:tableViewChangeToPageLayer(arg_6_1)
	end

	local function var_6_6(arg_18_0, arg_18_1)
		return var_6_2.height, var_6_2.width
	end

	local function var_6_7(arg_19_0)
		return var_6_4
	end

	local function var_6_8(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_0:cellAtIndex(arg_20_1)

		if var_20_0 == nil then
			var_20_0 = CCTableViewCell:new()

			local var_20_1 = ccp(62, 58)
			local var_20_2 = var_6_1[arg_20_1 + 1]
			local var_20_3 = ui.newControlButton({
				normalImage = var_20_2.image,
				position = var_20_1,
				clickAction = var_6_5
			})
			local var_20_4 = var_20_3:getContentSize()

			var_20_3.tag = var_20_2.type

			if var_20_3.tag == arg_6_1 then
				local var_20_5
				local var_20_6 = false

				if arg_6_0.markSprite then
					var_20_5 = arg_6_0.markSprite

					var_20_5:retain()
					var_20_5:removeFromParent()

					var_20_6 = true
				else
					var_20_5 = display.newSprite("ui/activity/activity_059.png")
					arg_6_0.markSprite = var_20_5

					var_20_5:setPosition(var_20_4.width / 2, var_20_4.height / 2)
				end

				var_20_3:addChild(var_20_5)

				if var_20_6 then
					var_20_5:release()
				end
			end

			if var_20_2.actionShowFunc and var_20_2.eventName then
				local var_20_7 = var_20_2.actionShowFunc()
				local var_20_8 = createNumberWidthBgSprite("ui/common/common_112.png", var_20_7)

				var_20_8:setPosition(var_20_4.width - 19, var_20_4.height - 19)
				var_20_8.numLabel:setColor(display.COLOR_WHITE)
				var_20_3:addChild(var_20_8)
				var_20_8:setVisible(var_20_7 > 0)
				addObserverToNode(var_20_8, function()
					local var_21_0 = var_20_2.actionShowFunc()

					var_20_8.numLabel:setString(var_21_0)
					var_20_8:setVisible(var_21_0 > 0)
				end, {
					var_20_2.eventName
				})
			end

			var_20_0:addChild(var_20_3)
		end

		return var_20_0
	end

	arg_6_0.tableview = CCTableView:create(var_6_3)

	arg_6_0.tableview:setPosition(4, 32)
	arg_6_0.tableview:setVerticalFillOrder(kCCTableViewFillTopDown)
	arg_6_0.tableview:setDirection(kCCScrollViewDirectionVertical)
	arg_6_0.container:addChild(arg_6_0.tableview)

	arg_6_0.tableview.sizeHandler = var_6_6
	arg_6_0.tableview.numHandler = var_6_7

	arg_6_0.tableview:registerScriptHandler(var_6_6, CCTableView.kTableCellSizeForIndex)
	arg_6_0.tableview:registerScriptHandler(var_6_7, CCTableView.kNumberOfCellsInTableView)
	arg_6_0.tableview:registerScriptHandler(var_6_8, CCTableView.kTableCellSizeAtIndex)
	arg_6_0:tableViewChangeToPageLayer(arg_6_1)

	local var_6_9 = var_6_3.height - var_6_4 * var_6_2.height
	local var_6_10 = var_6_2.height * (arg_6_0.curType - var_6_4)

	var_6_10 = var_6_10 < var_6_9 and var_6_9 or var_6_10

	arg_6_0.tableview:setContentOffset(ccp(0, var_6_10))
end

function var_0_0.tableViewChangeToPageLayer(arg_22_0, arg_22_1)
	if arg_22_0.curType ~= arg_22_1 then
		if arg_22_0.pageLayer then
			arg_22_0.pageLayer:removeFromParent()

			arg_22_0.pageLayer = nil
		end

		var_0_2 = {}

		local var_22_0 = var_0_1[arg_22_1]

		if var_22_0 then
			arg_22_0.pageLayer = require(var_22_0).new({
				parent = arg_22_0
			})

			arg_22_0.pageLayer:setPosition(130, 4)
			arg_22_0.container:addChild(arg_22_0.pageLayer)

			arg_22_0.curType = arg_22_1

			local var_22_1 = arg_22_0.tableview:getContentOffset()

			arg_22_0.tableview:reloadData()
			arg_22_0.tableview:setContentOffset(var_22_1)
		end
	end
end

function var_0_0.addSchedule(arg_23_0)
	if arg_23_0.scheduleHandle == nil then
		arg_23_0.scheduleHandle = require("framework.scheduler").scheduleGlobal(handler(arg_23_0, arg_23_0.scheduleCallback), 1)
	end
end

function var_0_0.removeSchedule(arg_24_0)
	if arg_24_0.scheduleHandle then
		require("framework.scheduler").unscheduleGlobal(arg_24_0.scheduleHandle)

		arg_24_0.scheduleHandle = nil
	end
end

function var_0_0.scheduleCallback(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in pairs(var_0_2) do
		if iter_25_1.callback then
			iter_25_1.callback()
		end
	end
end

function var_0_0.addToTimerTable(arg_26_0, arg_26_1)
	if arg_26_1 == nil then
		return
	end

	table.insert(var_0_2, arg_26_1)
end

function var_0_0.removeFromTimerTable(arg_27_0, arg_27_1)
	for iter_27_0, iter_27_1 in pairs(var_0_2) do
		if iter_27_1.callback == arg_27_1 then
			table.remove(var_0_2, iter_27_0)

			break
		end
	end
end

return var_0_0
