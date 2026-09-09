require("data.LevelupGift")
require("network.ActivityRequest")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = require("scenes.ToolLayer")
local var_0_2 = class("GrowUpPlanLayer", function()
	return display.newLayer()
end)

function var_0_2.ctor(arg_2_0)
	arg_2_0.nodeSize = CCSize(830, 545)
	arg_2_0.bgSprite = display.newSprite("ui/activity/activity_096.jpg", arg_2_0.nodeSize.width / 2, arg_2_0.nodeSize.height / 2 + 12)

	arg_2_0:addChild(arg_2_0.bgSprite)

	arg_2_0.giftTableView = arg_2_0:createGiftTableView()

	arg_2_0.giftTableView:setAnchorPoint(ccp(0, 0))
	arg_2_0.giftTableView:setPosition(ccp(35, 2))
	arg_2_0.bgSprite:addChild(arg_2_0.giftTableView)
	arg_2_0.giftTableView:reloadData()
	arg_2_0:initNetRequest()

	arg_2_0.btnBuyGrowUpPlan = ui.newControlButton({
		fontSize = 24,
		normalImage = "ui/activity/activity_094.png",
		text = string.lf("立即购买"),
		position = ccp(710, 435),
		clickAction = function()
			if Player.vipLevel < arg_2_0.mVipLevelLimit then
				ui.showMessageBox({
					text = string.lf("上仙！VIP等级达到%d才能购买，立即去提升VIP等级吧", arg_2_0.mVipLevelLimit),
					arg_2_0,
					title1 = string.lf("确定"),
					title2 = string.lf("取消"),
					action1 = function()
						game.enterStoreRechargeScene({
							from = "GrowUpPlanLayer"
						})
					end
				})

				return
			end

			arg_2_0.buyGrowUpPlanRequest:request()
		end
	})

	arg_2_0.btnBuyGrowUpPlan:setTitleForState(CCString:create(string.lf("立即购买")), CCControlStateNormal)
	arg_2_0.btnBuyGrowUpPlan:setTitleForState(CCString:create(string.lf("已购买")), CCControlStateDisabled)
	arg_2_0.btnBuyGrowUpPlan:setVisible(false)
	arg_2_0:addChild(arg_2_0.btnBuyGrowUpPlan)
	arg_2_0:refreshRewardInfo()
end

function var_0_2.createGiftTableView(arg_5_0)
	local var_5_0 = CCTextureCache:sharedTextureCache():addImage("ui/activity/activity_091.png"):getContentSize()
	local var_5_1 = CCSizeMake(var_5_0.width + 10, var_5_0.height)

	local function var_5_2()
		return var_5_1.height, var_5_1.width
	end

	local function var_5_3()
		if arg_5_0.mRewardData then
			return #arg_5_0.mRewardData
		end

		return 0
	end

	local function var_5_4(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_0:cellAtIndex(arg_8_1)
		local var_8_1 = arg_8_1 + 1

		if var_8_0 == nil then
			var_8_0 = CCTableViewCell:new()
		end

		var_8_0:removeAllChildrenWithCleanup(true)

		local var_8_2 = arg_5_0.mRewardData[var_8_1].Level
		local var_8_3 = arg_5_0.mRewardData[var_8_1].Ingot
		local var_8_4 = display.newSprite("ui/activity/activity_091.png")

		var_8_4:setAnchorPoint(ccp(0.5, 0))
		var_8_4:setPosition(var_5_1.width / 2, 0)
		var_8_0:addChild(var_8_4)

		local var_8_5 = display.newSprite("ui/activity/activity_092.png")

		var_8_0:addChild(var_8_5)
		var_8_5:setPosition(var_5_1.width / 2, var_5_1.height - 145)

		local var_8_6 = display.newSprite("uilocal/activity/activity_text_063.png")

		var_8_6:setPosition(var_5_1.width / 2, var_5_1.height - 50)
		var_8_0:addChild(var_8_6)

		local var_8_7 = CCLabelAtlas:create(tostring(var_8_2), "uilocal/activity/activity_text_061.png", 17, 33, 48)

		var_8_7:setAnchorPoint(ccp(1, 0.5))
		var_8_7:setPosition(72, var_5_1.height - 33)
		var_8_0:addChild(var_8_7)

		local var_8_8 = var_0_0.newLabel({
			size = 22,
			text = var_8_3,
			color = ccc3(255, 255, 0)
		})

		var_8_8:setPosition(var_5_1.width / 2, 192)
		var_8_0:addChild(var_8_8)

		local var_8_9 = ui.newControlButton({
			normalImage = "ui/activity/activity_093.png",
			position = ccp(var_5_1.width - 80, var_5_1.height / 2),
			clickAction = function()
				arg_5_0:onClickedGetReward(var_8_2)
			end
		})

		var_8_9:setPosition(ccp(var_5_1.width / 2, 115))
		var_8_0:addChild(var_8_9)

		return var_8_0
	end

	local var_5_5 = CCTableView:create(CCSizeMake(var_5_1.width * 5, var_5_1.height))

	var_5_5:ignoreAnchorPointForPosition(false)
	var_5_5:setDirection(kCCScrollViewDirectionHorizontal)
	var_5_5:registerScriptHandler(var_5_2, CCTableView.kTableCellSizeForIndex)
	var_5_5:registerScriptHandler(var_5_3, CCTableView.kNumberOfCellsInTableView)
	var_5_5:registerScriptHandler(var_5_4, CCTableView.kTableCellSizeAtIndex)

	return var_5_5
end

function var_0_2.refreshRewardInfo(arg_10_0, arg_10_1)
	local function var_10_0(arg_11_0)
		arg_10_0.mRewardData = {}
		arg_10_0.mIsBuy = arg_11_0.IsBuy == 1
		arg_10_0.mRewardData = arg_11_0.Growup
		arg_10_0.mVipLevelLimit = arg_11_0.VipLevelLimit

		if arg_10_0.mIsBuy then
			arg_10_0.btnBuyGrowUpPlan:setEnabled(false)
		else
			arg_10_0.btnBuyGrowUpPlan:setEnabled(true)
		end

		arg_10_0.btnBuyGrowUpPlan:setVisible(true)
		arg_10_0.giftTableView:reloadData()
	end

	LevelupGiftData:getGrowUpPlanRewardInfo(var_10_0, arg_10_1)
end

function var_0_2.initNetRequest(arg_12_0)
	if not arg_12_0.getRewardReuquest then
		local function var_12_0()
			showFlashNotice(string.lf("领取成功"))
			LevelupGiftData:removeGrowUpRewardBag(arg_12_0.getRewardReuquest:getRequestLevel())
			arg_12_0:refreshRewardInfo(false)

			local var_13_0 = Player:getGrowupStatus()

			if var_13_0 > 0 then
				var_13_0 = var_13_0 - 1
			end

			if var_13_0 == 0 then
				var_13_0 = nil
			end

			Player:setGrowupStatus(var_13_0)
		end

		local function var_12_1(arg_14_0)
			return
		end

		arg_12_0.getRewardReuquest = ActivityGetGrowUpRewardBagRequest:new()

		arg_12_0.getRewardReuquest:setResponseNormalHandler(var_12_0)
		arg_12_0.getRewardReuquest:setResponseExceptionHandler(var_12_1)
	end

	if not arg_12_0.buyGrowUpPlanRequest then
		local function var_12_2()
			showFlashNotice(string.lf("购买成功"))
			arg_12_0.btnBuyGrowUpPlan:setEnabled(false)
			arg_12_0:refreshRewardInfo(true)
		end

		local function var_12_3(arg_16_0)
			return
		end

		arg_12_0.buyGrowUpPlanRequest = ActivityBuyGrowUpPlanRequest:new()

		arg_12_0.buyGrowUpPlanRequest:setResponseNormalHandler(var_12_2)
		arg_12_0.buyGrowUpPlanRequest:setResponseExceptionHandler(var_12_3)
	end
end

function var_0_2.onClickedGetReward(arg_17_0, arg_17_1)
	if not arg_17_0.mIsBuy then
		showFlashNotice(string.lf("请先购买成长计划"))

		return
	end

	if arg_17_1 > Player.level then
		showFlashNotice(string.lf("未达到指定等级"))

		return
	end

	arg_17_0.getRewardReuquest:request(arg_17_1)
end

return var_0_2
