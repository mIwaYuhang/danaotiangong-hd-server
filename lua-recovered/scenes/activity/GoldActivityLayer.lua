require("network.ActivityRequest")

local var_0_0 = require("framework.scheduler")
local var_0_1 = require("base.cache")
local var_0_2 = require("scenes.toollayer.ctrl")
local var_0_3 = require("scenes.ToolLayer")
local var_0_4 = {
	eTotalConsume = 5,
	eSingleRecharge = 1,
	eDayRecharge = 2,
	eDayConsume = 4,
	eTotalRecharge = 3
}
local var_0_5 = {}
local var_0_6 = class("GoldActivityLayer", function()
	return display.newLayer()
end)

function var_0_6.ctor(arg_2_0)
	arg_2_0:setNodeEventEnabled(true)

	arg_2_0.mCountSeconds = 0
	arg_2_0.nodeSize = CCSize(830, 545)
	arg_2_0.bgSprite = display.newSprite("ui/activity/activity_103.jpg", arg_2_0.nodeSize.width / 2, arg_2_0.nodeSize.height / 2 + 12)

	arg_2_0:addChild(arg_2_0.bgSprite)
	arg_2_0:reuqestAvtiviyInfo()
end

function var_0_6.onExit(arg_3_0)
	arg_3_0:setNodeEventEnabled(false)
	arg_3_0:killTimer()
end

function var_0_6.setTimer(arg_4_0)
	if not arg_4_0.mRemainTimerHandler then
		arg_4_0.mRemainTimerHandler = var_0_0.scheduleGlobal(handler(arg_4_0, arg_4_0.onTimer), 3)
	end
end

function var_0_6.killTimer(arg_5_0)
	if not arg_5_0.mRemainTimerHandler then
		return
	end

	var_0_0.unscheduleGlobal(arg_5_0.mRemainTimerHandler)

	arg_5_0.mRemainTimerHandler = nil
end

function var_0_6.onTimer(arg_6_0)
	arg_6_0.mCountSeconds = arg_6_0.mCountSeconds + 3

	for iter_6_0, iter_6_1 in pairs(arg_6_0.mActivityInfo) do
		for iter_6_2, iter_6_3 in ipairs(iter_6_1) do
			if not tolua.isnull(iter_6_3.timerLabel) then
				local var_6_0 = iter_6_3.endTime - arg_6_0.mCountSeconds
				local var_6_1

				if var_6_0 < 1 then
					var_6_1 = string.lf("活动已结束")
				else
					var_6_1 = string.lf("活动结束时间:#FFE400%s", formatTime(var_6_0))
				end

				iter_6_3.timerLabel:setString(var_6_1)
			end
		end
	end
end

function var_0_6.createActivityTableView(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = CCTextureCache:sharedTextureCache():addImage("ui/activity/activity_106.png"):getContentSize()

	local function var_7_1()
		return var_7_0.height, var_7_0.width
	end

	local function var_7_2()
		if not arg_7_0.mActivityInfo or not arg_7_0.mActivityInfo[arg_7_2] then
			return 0
		end

		return #arg_7_0.mActivityInfo[arg_7_2]
	end

	local function var_7_3(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0:cellAtIndex(arg_10_1)
		local var_10_1 = arg_10_1 + 1

		if var_10_0 == nil then
			var_10_0 = CCTableViewCell:new()
		end

		var_10_0:removeAllChildrenWithCleanup(true)

		local var_10_2 = arg_7_0.mActivityInfo[arg_7_2][var_10_1]
		local var_10_3 = display.newSprite("ui/activity/activity_106.png", var_7_0.width / 2, var_7_0.height / 2)

		var_10_0:addChild(var_10_3)

		var_10_2.timerLabel = addLabelWithColorSize(var_10_0, string.lf("活动结束时间:#FFE400%s", formatTime(var_10_2.endTime - arg_7_0.mCountSeconds)), ccc3(223, 223, 207), 20, ccp(0, 1), ccp(15, var_7_0.height - 5))

		local var_10_4 = ""

		if arg_7_2 == var_0_4.eSingleRecharge then
			var_10_4 = string.lf("单笔充值达#FFD700%d元宝#FF1493可以领取", var_10_2.totalNeedNum)
		elseif arg_7_2 == var_0_4.eDayRecharge then
			var_10_4 = string.lf("当日充值达#FFD700%d元宝#FF1493可以领取,您还需充值#FFD700%d元宝", var_10_2.totalNeedNum, var_10_2.remainNeedNum)
		elseif arg_7_2 == var_0_4.eTotalRecharge then
			var_10_4 = string.lf("充值达#FFD700%d元宝#FF1493可以领取,您还需充值#FFD700%d元宝", var_10_2.totalNeedNum, var_10_2.remainNeedNum)
		elseif arg_7_2 == var_0_4.eDayConsume then
			var_10_4 = string.lf("当日消费达#FFD700%d元宝#FF1493可以领取,您还需消费#FFD700%d元宝", var_10_2.totalNeedNum, var_10_2.remainNeedNum)
		elseif arg_7_2 == var_0_4.eTotalConsume then
			var_10_4 = string.lf("消费达#FFD700%d元宝#FF1493可以领取,您还需消费#FFD700%d元宝", var_10_2.totalNeedNum, var_10_2.remainNeedNum)
		end

		if var_10_2.state == 1 then
			var_10_4 = string.lf("可领取")
		end

		addLabelWithColorSize(var_10_0, var_10_4, ccc3(255, 20, 147), 20, ccp(1, 1), ccp(var_7_0.width - 15, var_7_0.height - 5))

		if var_10_2.consume then
			local var_10_5 = arg_7_0:createExchangView(CCSizeMake(var_7_0.width - 420, var_7_0.height - 25), var_10_2.consume)

			var_10_5:setAnchorPoint(ccp(0, 0))
			var_10_5:setPosition(5, 5)
			var_10_0:addChild(var_10_5)

			local var_10_6 = arg_7_0:createRewardView(CCSizeMake(var_7_0.width * 0.23, var_7_0.height - 25), var_10_2.rewards)

			var_10_6:setAnchorPoint(ccp(0, 0))
			var_10_6:setPosition(var_7_0.width * 0.55, 0)
			var_10_0:addChild(var_10_6)
		else
			local var_10_7 = arg_7_0:createRewardView(CCSizeMake(var_7_0.width - 255, var_7_0.height - 25), var_10_2.rewards)

			var_10_7:setAnchorPoint(ccp(0, 0))
			var_10_7:setPosition(5, 5)
			var_10_0:addChild(var_10_7)
		end

		if var_10_2.consume then
			local var_10_8 = display.newSprite("ui/activity/activity_113.png", var_7_0.width * 0.5, var_7_0.height / 2 - 5)

			var_10_0:addChild(var_10_8)
		end

		local var_10_9 = {
			"uilocal/activity/activity_text_031.png",
			nil,
			"uilocal/activity/activity_text_030.png"
		}
		local var_10_10 = ui.newControlButton({
			normalImage = "ui/activity/activity_064.png",
			titleImage = var_10_9[var_10_2.state],
			position = ccp(var_7_0.width - 75, (var_7_0.height - 25) / 2),
			clickAction = function()
				arg_7_0:onBtnGetRewardClicked(var_10_2)
			end
		})

		var_10_10:setTouchPriority(-1)
		var_10_0:addChild(var_10_10)

		return var_10_0
	end

	local var_7_4 = CCTableView:create(arg_7_1)

	var_7_4:ignoreAnchorPointForPosition(false)
	var_7_4:setDirection(kCCScrollViewDirectionVertical)
	var_7_4:registerScriptHandler(var_7_1, CCTableView.kTableCellSizeForIndex)
	var_7_4:registerScriptHandler(var_7_2, CCTableView.kNumberOfCellsInTableView)
	var_7_4:registerScriptHandler(var_7_3, CCTableView.kTableCellSizeAtIndex)

	return var_7_4
end

function var_0_6.createRewardView(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = display.newNode()
	local var_12_1 = 0
	local var_12_2 = CCSizeMake(100, 60)

	for iter_12_0, iter_12_1 in ipairs(arg_12_2) do
		local var_12_3 = figure.createHeader({
			isName = true,
			type = iter_12_1.Type,
			itemId = iter_12_1.ID or 0,
			count = iter_12_1.Count,
			level = iter_12_1.Level,
			nameColor = getQualityColor(getItemQuality(iter_12_1.Type, iter_12_1.ID)),
			equipJieji = iter_12_1.BreakthroughCount,
			countColor = ccc3(255, 228, 0),
			clickAction = function()
				var_0_3.tipshandler(iter_12_1)
			end
		})

		var_12_0:addChild(var_12_3)
		var_12_3:setScale(0.85)
		var_12_3:setPosition(var_12_1 + var_12_2.width / 2, var_12_2.height / 2 + 25)

		var_12_1 = var_12_1 + var_12_2.width
	end

	var_12_0:setContentSize(CCSizeMake(var_12_1, var_12_2.height))

	local var_12_4 = CCSizeMake(Adapter.MinScale * arg_12_1.width, Adapter.MinScale * arg_12_1.height)
	local var_12_5 = CCScrollView:create(arg_12_1, var_12_0)

	var_12_5:setDirection(kCCScrollViewDirectionHorizontal)

	return var_12_5
end

function var_0_6.createExchangView(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = display.newNode()
	local var_14_1 = 0
	local var_14_2 = CCSizeMake(100, 60)

	for iter_14_0, iter_14_1 in ipairs(arg_14_2) do
		local var_14_3 = figure.createHeader({
			isName = true,
			type = iter_14_1.Type,
			itemId = iter_14_1.ID or 0,
			count = iter_14_1.Count,
			nameColor = getQualityColor(getItemQuality(iter_14_1.Type, iter_14_1.ID)),
			equipJieji = iter_14_1.BreakthroughCount,
			countColor = ccc3(255, 228, 0),
			clickAction = function()
				var_0_3.tipshandler(iter_14_1)
			end
		})

		var_14_0:addChild(var_14_3)
		var_14_3:setScale(0.85)
		var_14_3:setPosition(var_14_1 + var_14_2.width / 2, var_14_2.height / 2 + 25)

		var_14_1 = var_14_1 + var_14_2.width
	end

	var_14_0:setContentSize(CCSizeMake(var_14_1, var_14_2.height))

	local var_14_4 = CCSizeMake(Adapter.MinScale * arg_14_1.width, Adapter.MinScale * arg_14_1.height)
	local var_14_5 = CCScrollView:create(arg_14_1, var_14_0)

	var_14_5:setDirection(kCCScrollViewDirectionHorizontal)

	return var_14_5
end

function var_0_6.createTabLayer(arg_16_0)
	local var_16_0 = {
		[var_0_4.eSingleRecharge] = "uilocal/activity/activity_text_064.png",
		[var_0_4.eDayRecharge] = "uilocal/activity/activity_text_065.png",
		[var_0_4.eTotalRecharge] = "uilocal/activity/activity_text_066.png",
		[var_0_4.eDayConsume] = "uilocal/activity/activity_text_067.png",
		[var_0_4.eTotalConsume] = "uilocal/activity/activity_text_068.png"
	}
	local var_16_1 = CCTextureCache:sharedTextureCache():addImage("ui/activity/activity_106.png"):getContentSizeInPixels()

	var_16_1.height = 323
	arg_16_0.mActivityTableView = {}

	local function var_16_2(arg_17_0)
		local var_17_0 = arg_16_0.mTabButtonType[arg_17_0]
		local var_17_1 = var_0_2.newNode()

		var_17_1:setContentSize(var_16_1)
		var_17_1:setPosition(0, -3)

		arg_16_0.mActivityTableView[var_17_0] = arg_16_0:createActivityTableView(var_16_1, var_17_0)

		arg_16_0.mActivityTableView[var_17_0]:setAnchorPoint(ccp(0, 0))
		var_17_1:addChild(arg_16_0.mActivityTableView[var_17_0])

		if arg_16_0.mActivityInfo and arg_16_0.mActivityInfo[var_17_0] then
			arg_16_0.mActivityTableView[var_17_0]:reloadData()
		end

		return var_17_1
	end

	local function var_16_3(arg_18_0)
		return var_16_0[arg_16_0.mTabButtonType[arg_18_0]]
	end

	local function var_16_4(arg_19_0, arg_19_1)
		print("switch to index:" .. arg_19_1)
	end

	arg_16_0.mTabButtonType = {}

	for iter_16_0 = 1, #var_0_5 do
		local var_16_5 = var_0_5[iter_16_0]

		if arg_16_0.mActivityInfo[var_16_5] and #arg_16_0.mActivityInfo[var_16_5] then
			table.insert(arg_16_0.mTabButtonType, var_16_5)
		end
	end

	return arg_16_0:do_createTab({
		numberOfTab = #arg_16_0.mTabButtonType,
		sizeOfLayer = var_16_1,
		tabButtonSpriteAtIndex = var_16_3,
		tabLayerAtIndex = var_16_2,
		onCurselChanged = var_16_4
	})
end

function var_0_6.do_createTab(arg_20_0, arg_20_1)
	local var_20_0 = display.newNode()
	local var_20_1 = 5
	local var_20_2 = var_20_1 * (arg_20_1.numberOfTab - 1)
	local var_20_3 = CCSizeMake(0, 0)
	local var_20_4 = {}

	var_20_0.mTabs = var_20_4

	local function var_20_5(arg_21_0, arg_21_1)
		local var_21_0 = arg_21_0.mActiveLayerIndex

		if arg_21_1 == var_21_0 or not arg_21_0.mTabs[arg_21_1] then
			return
		end

		arg_21_0.mActiveLayerIndex = arg_21_1

		if var_21_0 then
			arg_21_0.mTabs[var_21_0].btn:setEnabled(true)
			arg_21_0.mTabs[var_21_0].layer:setVisible(false)
		end

		if not arg_21_0.mTabs[arg_21_1].layer then
			local var_21_1 = arg_20_1.tabLayerAtIndex(arg_21_1)

			var_21_1:setVisible(false)
			var_20_0:addChild(var_21_1)

			arg_21_0.mTabs[arg_21_1].layer = var_21_1
		end

		arg_21_0.mTabs[arg_21_1].layer:setVisible(true)
		arg_21_0.mTabs[arg_21_1].btn:setEnabled(false)

		if arg_20_1.onCurselChanged then
			arg_20_1.onCurselChanged(var_21_0, arg_21_1)
		end
	end

	for iter_20_0 = 1, arg_20_1.numberOfTab do
		local var_20_6

		if arg_20_1.tabButtonSpriteAtIndex then
			local var_20_7 = arg_20_1.tabButtonSpriteAtIndex(iter_20_0)

			var_20_6 = ui.newControlButton({
				normalImage = "ui/activity/activity_105.png",
				disabledImage = "ui/activity/activity_104.png",
				clickAction = function()
					var_20_0:setSelectedTab(iter_20_0)
				end
			})

			var_20_6:setTouchPriority(-1)

			local var_20_8 = var_20_6:getContentSize()
			local var_20_9 = display.newSprite(var_20_7, var_20_8.width / 2, var_20_8.height / 2 - 15)

			var_20_6:addChild(var_20_9)
		end

		var_20_3 = var_20_6:getContentSize()
		var_20_2 = var_20_2 + var_20_3.width
		var_20_4[iter_20_0] = {
			btn = var_20_6,
			btnSize = var_20_3,
			layerSize = arg_20_1.sizeOfLayer
		}

		var_20_0:addChild(var_20_6)
		var_20_6:setEnabled(true)
	end

	local var_20_10 = var_20_3.height + arg_20_1.sizeOfLayer.height

	var_20_0:setContentSize(CCSizeMake(math.max(arg_20_1.sizeOfLayer.width, var_20_2), var_20_10))

	local var_20_11 = 0

	for iter_20_1 = 1, arg_20_1.numberOfTab do
		var_20_4[iter_20_1].btn:setPosition(var_20_11 + var_20_3.width / 2, var_20_10 - var_20_3.height / 2)

		var_20_11 = var_20_11 + var_20_3.width + var_20_1
	end

	function var_20_0.setSelectedTab(arg_23_0, arg_23_1)
		var_20_5(arg_23_0, arg_23_1)
	end

	function var_20_0.getSelectedTab(arg_24_0)
		return arg_24_0.mActiveLayerIndex
	end

	var_20_0:setSelectedTab(1)

	return var_20_0
end

function var_0_6.refreshUI(arg_25_0)
	local var_25_0 = -1
	local var_25_1 = -1

	if not tolua.isnull(arg_25_0.mActivityTabCtrl) then
		var_25_1 = arg_25_0.mActivityTabCtrl:getSelectedTab()
		var_25_0 = arg_25_0.mTabButtonType[var_25_1]

		arg_25_0.mActivityTabCtrl:removeFromParent()
	end

	arg_25_0.mActivityTabCtrl = arg_25_0:createTabLayer()

	arg_25_0.mActivityTabCtrl:setAnchorPoint(ccp(0, 0))
	arg_25_0.mActivityTabCtrl:setPosition(ccp(15, 10))
	arg_25_0.bgSprite:addChild(arg_25_0.mActivityTabCtrl)

	for iter_25_0, iter_25_1 in pairs(arg_25_0.mActivityTableView) do
		iter_25_1:reloadData()
	end

	if var_25_0 ~= -1 and arg_25_0.mActivityInfo[var_25_0] and #arg_25_0.mActivityInfo[var_25_0] > 0 then
		arg_25_0.mActivityTabCtrl:setSelectedTab(var_25_1)
	end
end

function var_0_6.onBtnGetRewardClicked(arg_26_0, arg_26_1)
	if arg_26_1.state == 3 then
		if arg_26_1.type == var_0_4.eSingleRecharge or arg_26_1.type == var_0_4.eDayRecharge or arg_26_1.type == var_0_4.eTotalRecharge then
			ui.showMessageBox({
				text = string.lf("未达到领取条件，去充值吧！"),
				title1 = string.lf("取消"),
				title2 = string.lf("充值"),
				action2 = function()
					game.enterStoreRechargeScene({
						from = "GoldActivityLayer"
					})
				end
			})
		else
			showFlashNotice(string.lf("不满足领取条件"))
		end

		return
	end

	arg_26_0:requestGetReward(arg_26_1)
end

function var_0_6.reuqestAvtiviyInfo(arg_28_0)
	if not arg_28_0.mActivityRequest then
		arg_28_0.mActivityRequest = ActivityGoldGodGetInfoRequest:new()

		local function var_28_0()
			if not arg_28_0.mActivityRequest.restable then
				showFlashNotice(string.lf("暂无活动"))
				Player:setGoldGodStatus(0)

				return
			end

			arg_28_0.mActivityInfo = {}
			var_0_5 = {}

			local var_29_0 = 1

			for iter_29_0, iter_29_1 in ipairs(arg_28_0.mActivityRequest.restable) do
				if not arg_28_0.mActivityInfo[iter_29_1.type] then
					var_0_5[var_29_0] = iter_29_1.type
					var_29_0 = var_29_0 + 1
					arg_28_0.mActivityInfo[iter_29_1.type] = {}
				end

				if iter_29_1.state == 1 or iter_29_1.state == 3 then
					table.insert(arg_28_0.mActivityInfo[iter_29_1.type], 1, iter_29_1)
				end
			end

			arg_28_0:refreshUI()
			arg_28_0:setTimer()
		end

		arg_28_0.mActivityRequest:setResponseNormalHandler(var_28_0)
	end

	arg_28_0.mActivityRequest:request()
end

function var_0_6.requestGetReward(arg_30_0, arg_30_1)
	if not arg_30_0.mGetRewardRequest then
		arg_30_0.mGetRewardRequest = ActivityGoldGodGetRewardRequest:new()

		local function var_30_0()
			if not arg_30_0.mGetRewardRequest.restable then
				return
			end

			for iter_31_0, iter_31_1 in ipairs(arg_30_0.mActivityInfo[arg_30_0.mLastRequestReward.type]) do
				if iter_31_1.id == arg_30_0.mLastRequestReward.id then
					table.remove(arg_30_0.mActivityInfo[arg_30_0.mLastRequestReward.type], iter_31_0)

					break
				end
			end

			arg_30_0:refreshUI()
			showFlashNotice(string.lf("领取成功，道具已收取"))
		end

		arg_30_0.mGetRewardRequest:setResponseNormalHandler(var_30_0)
	end

	arg_30_0.mLastRequestReward = arg_30_1

	arg_30_0.mGetRewardRequest:request(arg_30_1.id)
end

return var_0_6
