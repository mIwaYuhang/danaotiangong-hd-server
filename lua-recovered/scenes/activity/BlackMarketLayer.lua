require("network.ActivityRequest")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = require("scenes.ToolLayer")
local var_0_2 = require("framework.scheduler")
local var_0_3 = {
	BlackMarket = 2,
	NormalShop = 1
}
local var_0_4 = class("BlackMarketLayer", function()
	return display.newLayer()
end)
local var_0_5 = {}

var_0_5.msgUpdateWorkShopLastSecond = 1
var_0_5.msgUpdateWorkShopRemainTime = 2

function var_0_4.ctor(arg_2_0)
	arg_2_0:setNodeEventEnabled(true)

	arg_2_0.currType = nil
	arg_2_0.mShopData = {}
	arg_2_0.mCDLabels = {}

	arg_2_0:initRequests()
	arg_2_0:initUI()
	arg_2_0:setTimer()
end

function var_0_4.initRequests(arg_3_0)
	local function var_3_0()
		arg_3_0.mShopData = arg_3_0.mShopListRequest.restable

		arg_3_0:killTimer()
		arg_3_0.tableView:reloadData(arg_3_0.mShopData)
		arg_3_0:setTimer()
	end

	arg_3_0.mShopListRequest = ActivityWorkShopListRequest:new()

	arg_3_0.mShopListRequest:setResponseNormalHandler(var_3_0)

	local function var_3_1()
		local var_5_0 = arg_3_0.mShopExchangeRequest.restable.Reward

		if var_5_0 then
			local var_5_1 = require("scenes.enhance.DlgResultLayer").new({
				titleText = string.lf("恭喜您获得"),
				rewardList = var_5_0
			})

			CCDirector:sharedDirector():getRunningScene():addChild(var_5_1, DefaultZOrder.ePopupLayer)
		end

		if arg_3_0.mShopExchangeRequest.lastExchangeData.Remain > 0 then
			arg_3_0.mShopExchangeRequest.lastExchangeData.Remain = arg_3_0.mShopExchangeRequest.lastExchangeData.Remain - 1
		end

		repeat
			local var_5_2 = false

			for iter_5_0, iter_5_1 in pairs(arg_3_0.mShopData) do
				if iter_5_1.Remain == 0 then
					table.remove(arg_3_0.mShopData, iter_5_0)

					var_5_2 = true

					break
				end
			end
		until var_5_2 == false

		arg_3_0.tableView:reloadData()
	end

	arg_3_0.mShopExchangeRequest = ActivityWorkShopExchangeRequest:new()

	arg_3_0.mShopExchangeRequest:setResponseNormalHandler(var_3_1)
end

function var_0_4.onExit(arg_6_0)
	arg_6_0:setNodeEventEnabled(false)
	arg_6_0:killTimer()
end

function var_0_4.initUI(arg_7_0)
	local var_7_0 = CCSize(830, 545)
	local var_7_1 = display.newSprite("ui/activity/activity_117.jpg", var_7_0.width / 2, var_7_0.height / 2 + 12)

	arg_7_0:addChild(var_7_1)

	local var_7_2 = display.newSprite("ui/activity/activity_110.png", var_7_0.width / 2, 10)
	local var_7_3 = var_7_2:getContentSize()

	var_7_2:setAnchorPoint(ccp(0.5, 0))
	var_7_1:addChild(var_7_2)

	local function var_7_4(arg_8_0)
		if arg_7_0.currType ~= nil and arg_7_0.currType == arg_8_0 then
			return
		end

		if arg_8_0 == var_0_3.NormalShop then
			arg_7_0.mBtnWorkShop:setBackgroundSpriteForState(CCScale9Sprite:create("ui/activity/activity_111.png"), CCControlStateNormal)
			arg_7_0.mBtnWorkShop:setBackgroundSpriteForState(CCScale9Sprite:create("ui/activity/activity_111.png"), CCControlStateHighlighted)
			arg_7_0.mBtnBlackMarket:setBackgroundSpriteForState(CCScale9Sprite:create("ui/activity/activity_123.png"), CCControlStateNormal)
			arg_7_0.mBtnBlackMarket:setBackgroundSpriteForState(CCScale9Sprite:create("ui/activity/activity_123.png"), CCControlStateHighlighted)
		else
			arg_7_0.mBtnWorkShop:setBackgroundSpriteForState(CCScale9Sprite:create("ui/activity/activity_124.png"), CCControlStateNormal)
			arg_7_0.mBtnWorkShop:setBackgroundSpriteForState(CCScale9Sprite:create("ui/activity/activity_124.png"), CCControlStateHighlighted)
			arg_7_0.mBtnBlackMarket:setBackgroundSpriteForState(CCScale9Sprite:create("ui/activity/activity_122.png"), CCControlStateNormal)
			arg_7_0.mBtnBlackMarket:setBackgroundSpriteForState(CCScale9Sprite:create("ui/activity/activity_122.png"), CCControlStateHighlighted)
		end

		arg_7_0.currType = arg_8_0

		arg_7_0.mShopListRequest:request(arg_8_0)
	end

	arg_7_0.mBtnWorkShop = ui.newControlButton({
		normalImage = "ui/activity/activity_111.png",
		anchorPoint = CCPoint(0.5, 0),
		position = ccp(200, var_7_3.height - 3),
		clickAction = function()
			var_7_4(var_0_3.NormalShop)
		end
	})

	arg_7_0.mBtnWorkShop:setTouchPriority(-1)
	var_7_2:addChild(arg_7_0.mBtnWorkShop)

	arg_7_0.mBtnBlackMarket = ui.newControlButton({
		normalImage = "ui/activity/activity_123.png",
		anchorPoint = CCPoint(0.5, 0),
		position = ccp(var_7_3.width - 200, var_7_3.height - 3),
		clickAction = function()
			var_7_4(var_0_3.BlackMarket)
		end
	})

	arg_7_0.mBtnBlackMarket:setTouchPriority(-1)
	var_7_2:addChild(arg_7_0.mBtnBlackMarket)

	arg_7_0.cellSize = CCSize(688, 149)

	local var_7_5 = createTableView({
		reverse = true,
		size = CCSize(688, 410),
		direction = kCCScrollViewDirectionVertical,
		dataset = arg_7_0.logList,
		sizehandler = function(arg_11_0, arg_11_1)
			return arg_7_0.cellSize
		end,
		cellhandler = handler(arg_7_0, arg_7_0.showListCell)
	})

	var_7_5:setAnchorPoint(CCPoint(0, 0))
	var_7_5:setPosition(22.5, 0)
	var_7_2:addChild(var_7_5)

	arg_7_0.tableView = var_7_5

	var_7_4(var_0_3.NormalShop)
end

function var_0_4.showListCell(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = display.newSprite("ui/activity/activity_115.png", arg_12_0.cellSize.width / 2, arg_12_0.cellSize.height / 2)
	local var_12_1 = arg_12_0.cellSize
	local var_12_2 = IPlatform:instance():getConfig("Channel") == "ZSY_TW"
	local var_12_3 = "uilocal/activity/activity_text_070.png"

	if arg_12_0.currType == var_0_3.NormalShop then
		var_12_3 = "uilocal/activity/activity_text_069.png"
	elseif arg_12_3.VipLevel then
		local var_12_4 = {
			[0] = "uilocal/store/store_text_043.png",
			"uilocal/store/store_text_044.png",
			"uilocal/store/store_text_045.png",
			"uilocal/store/store_text_046.png",
			"uilocal/store/store_text_047.png",
			"uilocal/store/store_text_048.png",
			"uilocal/store/store_text_049.png",
			"uilocal/store/store_text_050.png",
			"uilocal/store/store_text_051.png",
			"uilocal/store/store_text_052.png",
			"uilocal/store/store_text_053.png",
			"uilocal/store/store_text_054.png",
			"uilocal/store/store_text_071.png"
		}
		local var_12_5 = display.newSprite(var_12_4[arg_12_3.VipLevel], 215, var_12_1.height - 27)

		var_12_5:setAnchorPoint(ccp(1, 0.5))
		var_12_0:addChild(var_12_5)
		var_12_5:setVisible(not var_12_2)
	end

	local var_12_6 = display.newSprite(var_12_3, var_12_1.width / 2, var_12_1.height - 30)

	var_12_0:addChild(var_12_6)
	var_12_6:setVisible(not var_12_2)

	local var_12_7 = arg_12_0.currType == var_0_3.NormalShop and var_12_1.width - 240 or 125
	local var_12_8 = display.newSprite("ui/activity/activity_113.png", var_12_7, var_12_1.height / 2 - 5)

	var_12_0:addChild(var_12_8)

	local var_12_9 = var_12_1.width - 180

	for iter_12_0, iter_12_1 in ipairs(arg_12_3.Reward) do
		local var_12_10 = display.newSprite("ui/duel/duel_007.png", var_12_9, 8)

		var_12_10:setAnchorPoint(ccp(0.5, 0))
		var_12_10:setScaleX(0.5)
		var_12_10:setScaleY(0.85)
		var_12_0:addChild(var_12_10)

		local var_12_11 = iter_12_1

		var_12_11.ID = var_12_11.ID or var_12_11.Id or 0

		local var_12_12 = figure.createHeader({
			isName = true,
			type = var_12_11.Type,
			itemId = var_12_11.ID,
			count = var_12_11.Count,
			countColor = ccc3(255, 228, 0),
			nameColor = getQualityColor(getItemQuality(var_12_11.Type, var_12_11.ID)),
			equipJieji = var_12_11.BreakthroughCount,
			clickAction = function()
				var_0_1.tipshandler(var_12_11)
			end
		})

		var_12_12:setScale(0.85)
		var_12_12:setPosition(var_12_9, var_12_1.height / 2 - 10)
		var_12_0:addChild(var_12_12)

		var_12_9 = var_12_9 - 100
	end

	local var_12_13 = addLabelWithColorSize(var_12_6, " ", ccc3(228, 228, 228), 24, ccp(0, 0), ccp(380, -2))
	local var_12_14 = addLabelWithColorSize(var_12_6, " ", ccc3(228, 228, 228), 24, ccp(0, 0), ccp(183, -2))

	arg_12_3.ViewCtrls = {}
	arg_12_3.ViewCtrls.cdTimeLabel = var_12_13

	function arg_12_3.onCDTimer(arg_14_0)
		if arg_14_0.LastSecond > 0 then
			arg_14_0.ViewCtrls.cdTimeLabel:setString(formatTime(arg_14_0.LastSecond))
		else
			arg_14_0.ViewCtrls.cdTimeLabel:setString(string.lf("已结束"))
		end
	end

	arg_12_3.onCDTimer(arg_12_3)

	arg_12_3.ViewCtrls.remainTimeLabel = var_12_14

	function arg_12_3.onRemainTimeUpdate(arg_15_0)
		local var_15_0 = string.format("%d/%d", arg_15_0.Remain, arg_15_0.Total)

		if arg_15_0.Total == -1 then
			var_15_0 = string.lf("无限制")
		elseif arg_15_0.Remain == 0 then
			var_15_0 = string.lf("已完毕")
		end

		arg_15_0.ViewCtrls.remainTimeLabel:setString(var_15_0)

		if not tolua.isnull(arg_15_0.ViewCtrls.costView) then
			arg_15_0.ViewCtrls.costView:removeFromParent()
		end

		local var_15_1
		local var_15_2

		arg_15_0.ViewCtrls.costView, arg_15_0.ViewCtrls.isEnoughCost, var_15_2 = arg_12_0:createCostView(CCSizeMake(var_12_1.width - 260, var_12_1.height - 50), arg_15_0.Consume)

		arg_15_0.ViewCtrls.costView:setPosition(10, 0)
		var_12_0:addChild(arg_15_0.ViewCtrls.costView)

		local var_15_3 = #arg_15_0.Reward
		local var_15_4 = var_12_1.width - 130 - var_15_2 - var_15_3 * 100

		var_12_8:setPosition(var_15_2 + var_15_4 / 2, var_12_1.height / 2 - 5)
	end

	arg_12_3.onRemainTimeUpdate(arg_12_3)

	if arg_12_0.currType ~= var_0_3.NormalShop then
		var_12_13:setVisible(false)
		var_12_14:setVisible(false)
	end

	local var_12_15 = ui.newControlButton({
		normalImage = "ui/activity/activity_114.png",
		position = ccp(var_12_1.width - 70, var_12_1.height / 2 - 10),
		clickAction = function()
			if arg_12_3.LastSecond < 1 then
				arg_12_0:blinkSprite(var_12_13)
				showFlashNotice(string.lf("此项活动已结束"))
			elseif arg_12_3.Remain == 0 then
				arg_12_0:blinkSprite(var_12_14)
				showFlashNotice(string.lf("兑换次数不足"))
			elseif not arg_12_3.ViewCtrls.isEnoughCost then
				arg_12_3.ViewCtrls.costView:blinkNotEnough()
				showFlashNotice(string.lf("%s不足", arg_12_3.ViewCtrls.costView:getNeedCostNames()))
			else
				if arg_12_2 >= 3 then
					arg_12_0.currOffset = arg_12_0.tableView:getContentOffset()
				end

				arg_12_0.mShopExchangeRequest.lastExchangeData = arg_12_3

				arg_12_0.mShopExchangeRequest:request(arg_12_3.Id)
			end
		end
	})

	var_12_0:addChild(var_12_15)

	return var_12_0
end

function var_0_4.createCostView(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = display.newNode()

	var_17_0:setContentSize(arg_17_1)

	local var_17_1 = 0
	local var_17_2 = CCSizeMake(106, 80)
	local var_17_3 = ""
	local var_17_4 = true
	local var_17_5 = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_2) do
		local var_17_6 = display.newSprite("ui/duel/duel_007.png", var_17_1 + var_17_2.width / 2, 8)

		var_17_6:setScaleX(0.5)
		var_17_6:setScaleY(0.85)
		var_17_6:setAnchorPoint(ccp(0.5, 0))
		var_17_0:addChild(var_17_6)

		iter_17_1.ID = iter_17_1.ID or iter_17_1.Id or 0

		local var_17_7 = figure.createHeader({
			isName = true,
			type = iter_17_1.Type,
			itemId = iter_17_1.ID,
			nameColor = getQualityColor(getItemQuality(iter_17_1.Type, iter_17_1.ID)),
			clickAction = function()
				var_0_1.tipshandler(iter_17_1)
			end
		})

		var_17_0:addChild(var_17_7)
		var_17_7:setScale(0.85)
		var_17_7:setPosition(var_17_1 + var_17_2.width / 2, var_17_2.height / 2 + 25)

		local var_17_8 = Player:getItemCount(iter_17_1.Type, iter_17_1.ID)
		local var_17_9 = var_17_8 < iter_17_1.Count and ccc3(255, 16, 16) or ccc3(0, 144, 32)
		local var_17_10 = string.format("%s/%s", arg_17_0:formatItemValue(var_17_8), arg_17_0:formatItemValue(iter_17_1.Count))

		if iter_17_1.Type == ItemType.eCoin or iter_17_1.Type == ItemType.eGold then
			var_17_10 = arg_17_0:formatItemValue(iter_17_1.Count)
		end

		local var_17_11 = addLabelWithColorSize(var_17_0, var_17_10, var_17_9, 20, ccp(1, 0), ccp(var_17_1 + var_17_2.width / 2 + 30, 27))

		if var_17_8 < 1 then
			var_17_7:setOpacity(60)
		end

		if var_17_8 < iter_17_1.Count then
			var_17_4 = false

			table.insert(var_17_5, {
				countLabel = var_17_11
			})

			if var_17_3 == "" then
				var_17_3 = getItemName(iter_17_1.Type, iter_17_1.ID)
			else
				var_17_3 = string.lf("%s、%s", var_17_3, getItemName(iter_17_1.Type, iter_17_1.ID))
			end
		end
	end

	local var_17_12 = var_17_1 + var_17_2.width

	function var_17_0.blinkNotEnough(arg_19_0)
		for iter_19_0, iter_19_1 in pairs(var_17_5) do
			if not tolua.isnull(iter_19_1.countLabel) then
				arg_17_0:blinkSprite(iter_19_1.countLabel)
			end
		end
	end

	function var_17_0.getNeedCostNames(arg_20_0)
		return var_17_3
	end

	return var_17_0, var_17_4, var_17_12
end

function var_0_4.getImageSize(arg_21_0, arg_21_1)
	return CCTextureCache:sharedTextureCache():addImage(arg_21_1):getContentSizeInPixels()
end

function var_0_4.formatItemValue(arg_22_0, arg_22_1)
	arg_22_1 = math.floor(arg_22_1)

	if arg_22_1 > 9999 then
		arg_22_1 = math.floor(arg_22_1 / 10000)

		return string.lf("%s万", arg_22_1)
	end

	return tostring(arg_22_1)
end

function var_0_4.blinkSprite(arg_23_0, arg_23_1)
	return transition.execute(arg_23_1, CCBlink:create(0.5, 3), {
		onComplete = function()
			arg_23_1:setVisible(true)
		end
	})
end

function var_0_4.setTimer(arg_25_0)
	if not arg_25_0.mRefreshCDTimerHandler then
		arg_25_0.mRefreshCDTimerHandler = var_0_2.scheduleGlobal(handler(arg_25_0, arg_25_0.onRefreshCDTimer), 1)
	end
end

function var_0_4.killTimer(arg_26_0)
	if arg_26_0.mRefreshCDTimerHandler then
		var_0_2.unscheduleGlobal(arg_26_0.mRefreshCDTimerHandler)

		arg_26_0.mRefreshCDTimerHandler = nil
	end
end

function var_0_4.onRefreshCDTimer(arg_27_0)
	for iter_27_0, iter_27_1 in pairs(arg_27_0.mShopData or {}) do
		if iter_27_1.LastSecond > 0 then
			iter_27_1.LastSecond = iter_27_1.LastSecond - 1

			if iter_27_1.onCDTimer then
				iter_27_1.onCDTimer(iter_27_1)
			end
		end
	end
end

return var_0_4
