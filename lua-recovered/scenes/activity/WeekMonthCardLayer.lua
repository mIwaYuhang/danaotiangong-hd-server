require("base.functions")
require("data.player")
require("base.figure")
require("network.ActivityRequest")

local var_0_0 = require("framework.scheduler")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = require("base.cache")
local var_0_3 = require("scenes.ToolLayer")
local var_0_4 = class("WeekMonthCardLayer", function()
	return display.newLayer()
end)

function var_0_4.ctor(arg_2_0)
	arg_2_0.nodeSize = CCSizeMake(830, 545)
	arg_2_0.mCDTimerFunctions = {}
	arg_2_0.bgSprite = display.newSprite("ui/activity/activity_127.jpg", arg_2_0.nodeSize.width / 2, arg_2_0.nodeSize.height / 2 + 12)

	local var_2_0 = display.newSprite("uilocal/activity/activity_text_080.png")

	var_2_0:setPosition(ccp(arg_2_0.nodeSize.width / 2 + 190, arg_2_0.nodeSize.height / 2 - 34))
	arg_2_0.bgSprite:addChild(var_2_0)

	local var_2_1 = display.newSprite("uilocal/activity/activity_text_081.png")

	var_2_1:setPosition(ccp(arg_2_0.nodeSize.width / 2 - 200, arg_2_0.nodeSize.height / 2 - 34))
	arg_2_0.bgSprite:addChild(var_2_1)
	arg_2_0:addChild(arg_2_0.bgSprite)
	arg_2_0:setUI()
	arg_2_0:setTimer()
	arg_2_0:requestBaseInfo()
end

function var_0_4.setUI(arg_3_0)
	arg_3_0.monthRewardLabel = addLabelWithColorSize(arg_3_0.bgSprite, "", ccc3(238, 180, 34), 23, ccp(0, 0), ccp(arg_3_0.nodeSize.width / 2 + 208, arg_3_0.nodeSize.height / 2 - 160))
	arg_3_0.havevolumeLabel = addLabelWithColorSize(arg_3_0.bgSprite, string.lf("拥有点卷：%d", Player.volumegift), ccc3(0, 255, 0), 22, ccp(0, 0), ccp(arg_3_0.nodeSize.width / 2 - 160, arg_3_0.nodeSize.height / 2 + 60))

	addObserverToNode(arg_3_0.monthRewardLabel, function()
		arg_3_0.havevolumeLabel:setString(string.lf("拥有点卷：%d", Player.volumegift))
	end, {
		PalyerEvents.eVolumeGift
	})

	arg_3_0.monthcardLabel = addLabelWithColorSize(arg_3_0.bgSprite, string.lf("购买当天立即获得300元宝，随后每天可以获得88元宝（有效期30天）"), ccc3(125, 245, 255), 18, ccp(0, 0), ccp(arg_3_0.nodeSize.width / 2 + 22, arg_3_0.nodeSize.height / 2 - 102))

	arg_3_0.monthcardLabel:setHorizontalAlignment(kCCTextAlignmentLeft)
	arg_3_0.monthcardLabel:setDimensions(CCSizeMake(arg_3_0.nodeSize.width / 2 - 70, arg_3_0.nodeSize.height - 500))

	arg_3_0.weekcardLabel = addLabelWithColorSize(arg_3_0.bgSprite, string.lf("每周只能购买一次周卡礼包"), ccc3(125, 245, 255), 18, ccp(0, 0), ccp(arg_3_0.nodeSize.width / 2 - 310, arg_3_0.nodeSize.height / 2 - 80))
	arg_3_0.monthcardCousume = addLabelWithColorSize(arg_3_0.bgSprite, "", ccc3(125, 245, 255), 18, ccp(0, 0), ccp(arg_3_0.nodeSize.width / 2 + 150, arg_3_0.nodeSize.height / 2 - 195))
	arg_3_0.weekcardCousume = addLabelWithColorSize(arg_3_0.bgSprite, "", ccc3(125, 245, 255), 18, ccp(0, 0), ccp(arg_3_0.nodeSize.width / 2 - 240, arg_3_0.nodeSize.height / 2 - 195))
	arg_3_0.ChangeIngotButton = ui.newControlButton({
		normalImage = "ui/common/common_055.png",
		titleImage = "uilocal/activity/activity_text_071.png",
		clickAction = function()
			arg_3_0:onChangeIngotClick()
		end
	})

	arg_3_0.ChangeIngotButton:setPosition(arg_3_0.nodeSize.width / 2 - 100, arg_3_0.nodeSize.height / 2 + 30)
	arg_3_0.bgSprite:addChild(arg_3_0.ChangeIngotButton)

	arg_3_0.monthactivationButton = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/activity/activity_text_077.png",
		position = ccp(arg_3_0.nodeSize.width / 2 + 200, arg_3_0.nodeSize.height / 2 - 220),
		clickAction = function()
			arg_3_0:onMonthActivationClick()
		end
	})

	arg_3_0.bgSprite:addChild(arg_3_0.monthactivationButton)
	arg_3_0.monthactivationButton:setVisible(false)

	arg_3_0.monthgetRewardButton = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/activity/activity_text_076.png",
		position = ccp(arg_3_0.nodeSize.width / 2 + 200, arg_3_0.nodeSize.height / 2 - 220),
		clickAction = function()
			arg_3_0:onGetMonthRewardClick()
		end
	})

	arg_3_0.bgSprite:addChild(arg_3_0.monthgetRewardButton)
	arg_3_0.monthgetRewardButton:setVisible(false)

	arg_3_0.buyAlready = display.newSprite("uilocal/activity/activity_text_078.png")

	arg_3_0.buyAlready:setScale(1.2)
	arg_3_0.buyAlready:setPosition(arg_3_0.nodeSize.width / 2 + 200, arg_3_0.nodeSize.height / 2 - 220)
	arg_3_0.bgSprite:addChild(arg_3_0.buyAlready)
	arg_3_0.buyAlready:setVisible(false)

	arg_3_0.getMonthAlready = display.newSprite("uilocal/activity/activity_text_079.png")

	arg_3_0.getMonthAlready:setScale(1.2)
	arg_3_0.getMonthAlready:setPosition(arg_3_0.nodeSize.width / 2 + 200, arg_3_0.nodeSize.height / 2 - 220)
	arg_3_0.bgSprite:addChild(arg_3_0.getMonthAlready)
	arg_3_0.getMonthAlready:setVisible(false)

	arg_3_0.weekactivationButton = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/activity/activity_text_077.png",
		position = ccp(arg_3_0.nodeSize.width / 2 - 200, arg_3_0.nodeSize.height / 2 - 220),
		clickAction = function()
			arg_3_0:onWeekActivationClick()
		end
	})

	arg_3_0.bgSprite:addChild(arg_3_0.weekactivationButton)
	arg_3_0.weekactivationButton:setVisible(false)

	arg_3_0.buyWeekAlready = display.newSprite("uilocal/activity/activity_text_078.png")

	arg_3_0.buyWeekAlready:setScale(1.2)
	arg_3_0.buyWeekAlready:setPosition(arg_3_0.nodeSize.width / 2 - 200, arg_3_0.nodeSize.height / 2 - 220)
	arg_3_0.bgSprite:addChild(arg_3_0.buyWeekAlready)
	arg_3_0.buyWeekAlready:setVisible(false)

	arg_3_0.monthRemainTime = arg_3_0:createMonthRemainTime()

	arg_3_0.monthRemainTime:setVisible(false)
	arg_3_0.bgSprite:addChild(arg_3_0.monthRemainTime)

	arg_3_0.weekRemainTime = arg_3_0:createWeekRemainTime()

	arg_3_0.weekRemainTime:setVisible(false)
	arg_3_0.bgSprite:addChild(arg_3_0.weekRemainTime)
end

function var_0_4.createMonthRemainTime(arg_9_0)
	local var_9_0 = display.newNode()
	local var_9_1 = addLabelWithColorSize(var_9_0, "", ccc3(0, 255, 0), 22, ccp(0, 0.5), ccp(arg_9_0.nodeSize.width / 2 + 50, arg_9_0.nodeSize.height / 2 - 190))

	function var_9_0.setRemainTime(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_1 or -1

		local function var_10_1()
			if var_10_0 > 0 then
				var_10_0 = var_10_0 - 1

				if var_10_0 < 86400 then
					var_9_1:setPosition(ccp(arg_9_0.nodeSize.width / 2 + 80, arg_9_0.nodeSize.height / 2 - 190))
				end

				var_9_1:setString(string.lf("月卡剩余时间：%s", formatTime(var_10_0)))
			else
				arg_9_0:dettachCDTimer(var_9_0)
				arg_9_0:requestBaseInfo()
			end
		end

		var_10_1()
		arg_9_0:dettachCDTimer(var_9_0)
		arg_9_0:attachCDTimer(var_9_0, var_10_1)
	end

	return var_9_0
end

function var_0_4.createWeekRemainTime(arg_12_0)
	local var_12_0 = display.newNode()
	local var_12_1 = addLabelWithColorSize(var_12_0, "", ccc3(0, 255, 0), 22, ccp(0, 0.5), ccp(arg_12_0.nodeSize.width / 2 - 330, arg_12_0.nodeSize.height / 2 - 190))

	function var_12_0.setRemainTime(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_1 or -1

		local function var_13_1()
			if var_13_0 > 0 then
				var_13_0 = var_13_0 - 1

				if var_13_0 < 86400 then
					var_12_1:setPosition(ccp(arg_12_0.nodeSize.width / 2 - 300, arg_12_0.nodeSize.height / 2 - 190))
				end

				var_12_1:setString(string.lf("周卡剩余时间：%s", formatTime(var_13_0)))
			else
				arg_12_0:dettachCDTimer(var_12_0)
				arg_12_0:requestBaseInfo()
			end
		end

		var_13_1()
		arg_12_0:dettachCDTimer(var_12_0)
		arg_12_0:attachCDTimer(var_12_0, var_13_1)
	end

	return var_12_0
end

function var_0_4.onMonthActivationClick(arg_15_0)
	print(Player.volumegift)

	if Player.volumegift < arg_15_0.mInfo.MonthCardConsume then
		ui.showMessageBox({
			text = string.lf("上仙，您的点卷不足，请充值点卷后再激活！"),
			title1 = string.lf("确定"),
			action1 = function()
				return
			end
		})
	else
		arg_15_0:requestMonthInfo()
	end
end

function var_0_4.onWeekActivationClick(arg_17_0)
	print(Player.volumegift)

	if Player.volumegift < arg_17_0.mInfo.MonthCardConsume then
		ui.showMessageBox({
			text = string.lf("上仙，您的点卷不足，请充值点卷后再激活！"),
			title1 = string.lf("确定"),
			action1 = function()
				return
			end
		})
	else
		arg_17_0:requestWeekInfo()
	end
end

function var_0_4.onGetMonthRewardClick(arg_19_0)
	arg_19_0:requestMonthInfo()
end

function var_0_4.onBuyThirtyVolumeClick(arg_20_0, arg_20_1)
	arg_20_0:BuyVolume(arg_20_1)
end

function var_0_4.onBuyFiftyVolumeClick(arg_21_0, arg_21_1)
	arg_21_0:BuyVolume(arg_21_1)
end

function var_0_4.onBuyNinetyVolumeClick(arg_22_0, arg_22_1)
	arg_22_0:BuyVolume(arg_22_1)
end

function var_0_4.onBuyHundredVolumeClick(arg_23_0, arg_23_1)
	arg_23_0:BuyVolume(arg_23_1)
end

function var_0_4.BuyVolume(arg_24_0, arg_24_1)
	if arg_24_1 then
		arg_24_0.rechargeBlock:startPurchase(arg_24_1)
	end
end

function var_0_4.onChangeIngotClick(arg_25_0)
	if IPlatform:instance():getConfig("Channel") == "ZSY_TW" then
		if Player.volumegift < 10 then
			ui.showMessageBox({
				text = string.lf("上仙，您不足10点卷")
			})
		else
			ui.showMessageBox({
				text = string.lf("上仙，您是否花费10点卷兑换14元宝？"),
				title1 = string.lf("取消"),
				title2 = string.lf("确定"),
				action2 = function()
					arg_25_0:requestChangeIngot(10)
				end
			})
		end
	else
		local var_25_0 = {
			value = 10,
			type = ItemType.eGold,
			color = ccc3(250, 200, 30)
		}

		var_0_3.createDialog({
			selectCount = Player.volumegift,
			show = var_0_3.eShowGiftVolumeBuy,
			data = {
				price = var_25_0,
				limit = Player.volumegift
			},
			callback = function(arg_27_0)
				arg_25_0:requestChangeIngot(arg_27_0)
			end
		}):show()
	end
end

function var_0_4.setTimer(arg_28_0)
	if not arg_28_0.mCDTimerHandler then
		arg_28_0.mCDTimerHandler = var_0_0.scheduleGlobal(handler(arg_28_0, arg_28_0.onCDTimer), 1)
	end
end

function var_0_4.killTimer(arg_29_0)
	if arg_29_0.mCDTimerHandler then
		var_0_0.unscheduleGlobal(arg_29_0.mCDTimerHandler)

		arg_29_0.mCDTimerHandler = nil
	end
end

function var_0_4.onCDTimer(arg_30_0)
	table.foreach(arg_30_0.mCDTimerFunctions or {}, function(arg_31_0, arg_31_1)
		arg_31_1()
	end)
end

function var_0_4.attachCDTimer(arg_32_0, arg_32_1, arg_32_2)
	arg_32_0.mCDTimerFunctions[arg_32_1] = arg_32_2
end

function var_0_4.dettachCDTimer(arg_33_0, arg_33_1)
	arg_33_0.mCDTimerFunctions[arg_33_1] = nil
end

function var_0_4.requestBaseInfo(arg_34_0)
	if not arg_34_0.mMonthInfoRequest then
		arg_34_0.rechargeBlock = require("scenes.store.StoreRechargeScene").new({
			hideUI = true
		})

		arg_34_0:addChild(arg_34_0.rechargeBlock)

		arg_34_0.mMonthInfoRequest = ActivityMonthInfoRequest:new()

		local function var_34_0()
			arg_34_0:onResponseActiInfo(arg_34_0.mMonthInfoRequest.restable)
			arg_34_0.rechargeBlock:loadIAPProducts(arg_34_0.mMonthInfoRequest.restable.RechargePointInfo)
		end

		arg_34_0.mMonthInfoRequest:setResponseNormalHandler(var_34_0)
	end

	arg_34_0.mMonthInfoRequest:request()
end

function var_0_4.onResponseActiInfo(arg_36_0, arg_36_1)
	arg_36_0.mInfo = arg_36_1
	arg_36_0.weekRewardList = arg_36_0:createRewardView(arg_36_0.mInfo.WeekReward)

	arg_36_0.bgSprite:addChild(arg_36_0.weekRewardList)
	arg_36_0.weekRewardList:setPosition(ccp(arg_36_0.nodeSize.width / 2 - 360, arg_36_0.nodeSize.height / 2 - 185))
	arg_36_0.monthRewardLabel:setString(string.lf("%d", arg_36_1.MonthReward[1].Count))
	arg_36_0.monthcardCousume:setString(string.lf("消耗%d点卷", arg_36_1.MonthCardConsume))
	arg_36_0.weekcardCousume:setString(string.lf("消耗%d点卷", arg_36_1.WeekCardConsume))

	local var_36_0 = {}
	local var_36_1 = buyBtn

	for iter_36_0, iter_36_1 in ipairs(arg_36_0.mInfo.RechargePointInfo) do
		if iter_36_1.Money ~= nil then
			table.insert(var_36_0, iter_36_1.Money)
		end
	end

	for iter_36_2 = 1, table.maxn(var_36_0) do
		buyBtn = ui.newControlButton({
			fontSize = 24,
			normalImage = "ui/common/common_110.png",
			text = string.lf("买%d点卷", var_36_0[iter_36_2]),
			clickAction = function()
				arg_36_0:onBuyThirtyVolumeClick(arg_36_0.mInfo.RechargePointInfo[iter_36_2])
			end
		})

		buyBtn:setPosition(arg_36_0.nodeSize.width / 2 + 100 + (iter_36_2 - 1) * 200, arg_36_0.nodeSize.height / 2 + 30)
		arg_36_0.bgSprite:addChild(buyBtn)
	end

	if arg_36_1.WeekCountdown > 0 then
		arg_36_0.weekcardCousume:setVisible(false)
		arg_36_0.weekRemainTime:setVisible(true)
		arg_36_0.weekRemainTime:setRemainTime(arg_36_1.WeekCountdown)
		arg_36_0.buyWeekAlready:setVisible(true)
		arg_36_0.weekactivationButton:setVisible(false)
	else
		arg_36_0.weekcardCousume:setVisible(true)
		arg_36_0.weekRemainTime:setVisible(false)
		arg_36_0.weekactivationButton:setVisible(true)
		arg_36_0.buyWeekAlready:setVisible(false)
	end

	if arg_36_1.MonthCountdown > 0 then
		arg_36_0.monthcardCousume:setVisible(false)
		arg_36_0.monthRemainTime:setVisible(true)
		arg_36_0.monthRemainTime:setRemainTime(arg_36_1.MonthCountdown)

		if arg_36_1.IsBuyMonthCard == 1 then
			arg_36_0.buyAlready:setVisible(true)
			arg_36_0.monthgetRewardButton:setVisible(false)
			arg_36_0.monthactivationButton:setVisible(false)
			arg_36_0.getMonthAlready:setVisible(false)
		elseif arg_36_1.HaveMonthCardTimes > 0 then
			arg_36_0.monthgetRewardButton:setVisible(true)
			arg_36_0.buyAlready:setVisible(false)
			arg_36_0.monthactivationButton:setVisible(false)
			arg_36_0.getMonthAlready:setVisible(false)
		elseif arg_36_1.HaveMonthCardTimes == 0 then
			arg_36_0.monthgetRewardButton:setVisible(false)
			arg_36_0.buyAlready:setVisible(false)
			arg_36_0.monthactivationButton:setVisible(false)
			arg_36_0.getMonthAlready:setVisible(true)
		end
	else
		arg_36_0.getMonthAlready:setVisible(false)
		arg_36_0.monthcardCousume:setVisible(true)
		arg_36_0.monthRemainTime:setVisible(false)
		arg_36_0.monthactivationButton:setVisible(true)
		arg_36_0.buyAlready:setVisible(false)
	end
end

function var_0_4.requestMonthInfo(arg_38_0)
	if not arg_38_0.mMonthGetRequest then
		arg_38_0.mMonthGetRequest = ActivityMonthRewardRequest:new()

		local function var_38_0()
			arg_38_0:onResponseGetMonthInfo(arg_38_0.mMonthGetRequest.restable)
		end

		arg_38_0.mMonthGetRequest:setResponseNormalHandler(var_38_0)
	end

	arg_38_0.mMonthGetRequest:request()
end

function var_0_4.onResponseGetMonthInfo(arg_40_0, arg_40_1)
	if arg_40_0.mInfo.MonthCountdown > 0 then
		showFlashNotice(string.lf("上仙领取成功！获得88元宝！"))
	else
		showFlashNotice(string.lf("上仙购买成功！获得300元宝！"))
	end

	arg_40_0:requestBaseInfo()
end

function var_0_4.requestWeekInfo(arg_41_0)
	if not arg_41_0.mWeekGetRequest then
		arg_41_0.mWeekGetRequest = ActivityWeekRewardRequest:new()

		local function var_41_0()
			arg_41_0:onResponseGetWeekInfo(arg_41_0.mWeekGetRequest.restable)
		end

		arg_41_0.mWeekGetRequest:setResponseNormalHandler(var_41_0)
	end

	arg_41_0.mWeekGetRequest:request()
end

function var_0_4.onResponseGetWeekInfo(arg_43_0, arg_43_1)
	showFlashNotice(string.lf("上仙购买成功！奖励已发放！"))
	arg_43_0:requestBaseInfo()
end

function var_0_4.requestChangeIngot(arg_44_0, arg_44_1)
	if not arg_44_0.mChangeIngotRequest then
		arg_44_0.mChangeIngotRequest = ActivityChangeIngotRequest:new()

		local function var_44_0()
			arg_44_0:onResponseChangeIngot(arg_44_0.mChangeIngotRequest.restable)
		end

		arg_44_0.mChangeIngotRequest:setResponseNormalHandler(var_44_0)
	end

	arg_44_0.mChangeIngotRequest:request(arg_44_1)
end

function var_0_4.onResponseChangeIngot(arg_46_0, arg_46_1)
	showFlashNotice(string.lf("上仙兑换成功！"))
	arg_46_0:requestBaseInfo()
end

function var_0_4.createRewardView(arg_47_0, arg_47_1)
	local var_47_0 = display.newNode()
	local var_47_1 = 0
	local var_47_2 = CCSizeMake(110, 110)

	for iter_47_0, iter_47_1 in ipairs(arg_47_1) do
		local var_47_3 = figure.createHeader({
			type = iter_47_1.Type,
			itemId = iter_47_1.ID or 0,
			count = iter_47_1.Count,
			nameColor = getQualityColor(getItemQuality(iter_47_1.Type, iter_47_1.ID)),
			equipJieji = iter_47_1.BreakthroughCount,
			countColor = ccc3(255, 228, 0),
			clickAction = function()
				var_0_3.tipshandler(iter_47_1)
			end
		})

		var_47_3:setScale(0.9)
		var_47_0:addChild(var_47_3)
		var_47_3:setPosition(var_47_1 + var_47_2.width / 2, var_47_2.height / 2 + 10)

		var_47_1 = var_47_1 + var_47_2.width
	end

	var_47_0:setContentSize(CCSizeMake(var_47_1, var_47_2.height))

	return var_47_0
end

return var_0_4
