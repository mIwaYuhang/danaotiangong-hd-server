require("data.LevelupGift")
require("network.ActivityRequest")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = class("LevelupGiftLayer", function()
	return display.newLayer()
end)

function var_0_2.ctor(arg_2_0)
	arg_2_0.nodeSize = CCSize(830, 545)
	arg_2_0.bgSprite = display.newSprite("ui/activity/activity_090.jpg", arg_2_0.nodeSize.width / 2, arg_2_0.nodeSize.height / 2 + 12)

	arg_2_0:addChild(arg_2_0.bgSprite)

	arg_2_0.giftTableView = arg_2_0:createGiftTableView(CCSize(810, 475))

	arg_2_0.giftTableView:setAnchorPoint(ccp(0, 0))
	arg_2_0.giftTableView:setPosition(ccp(10, 40))
	arg_2_0.bgSprite:addChild(arg_2_0.giftTableView)
	arg_2_0.giftTableView:reloadData()
	arg_2_0:refreshGiftInfo()
end

function var_0_2.createGiftTableView(arg_3_0, arg_3_1)
	local var_3_0 = CCTableView:create(arg_3_1)

	var_3_0:ignoreAnchorPointForPosition(false)
	var_3_0:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_3_0:setDirection(kCCScrollViewDirectionVertical)

	local var_3_1 = CCTextureCache:sharedTextureCache():addImage("ui/activity/activity_089.png"):getContentSize()

	local function var_3_2()
		return var_3_1.height, var_3_1.width
	end

	local function var_3_3()
		if arg_3_0.mRewardData then
			return #arg_3_0.mRewardData
		end

		return 0
	end

	local function var_3_4(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_0:cellAtIndex(arg_6_1)
		local var_6_1 = arg_6_1 + 1

		if var_6_0 == nil then
			var_6_0 = CCTableViewCell:new()
		end

		var_6_0:removeAllChildrenWithCleanup(true)

		local var_6_2 = display.newSprite("ui/activity/activity_089.png")

		var_6_2:setAnchorPoint(ccp(0, 0))
		var_6_0:addChild(var_6_2)

		local var_6_3 = CCLabelAtlas:create(tostring(arg_3_0.mRewardData[var_6_1].level), "uilocal/activity/activity_text_061.png", 17, 33, 48)

		var_6_3:setAnchorPoint(ccp(1, 0.5))
		var_6_0:addChild(var_6_3)
		var_6_3:setPosition(ccp(60, var_3_1.height / 2))

		local var_6_4 = display.newSprite("uilocal/activity/activity_text_062.png")

		var_6_4:setAnchorPoint(ccp(0, 0.5))
		var_6_4:setPosition(ccp(60, var_3_1.height / 2))
		var_6_0:addChild(var_6_4)

		local var_6_5 = {}
		local var_6_6 = CCSize(120, 110)

		for iter_6_0, iter_6_1 in ipairs(arg_3_0.mRewardData[var_6_1].rewards) do
			local var_6_7 = display.newNode()

			var_6_7:setContentSize(var_6_6)

			local var_6_8 = figure.createHeader({
				isName = true,
				type = iter_6_1.Type,
				itemId = iter_6_1.ID or 0,
				count = iter_6_1.Count,
				nameColor = getQualityColor(getItemQuality(iter_6_1.Type, iter_6_1.ID)),
				countColor = ccc3(223, 240, 0),
				clickAction = function()
					var_0_0.tipshandler(iter_6_1)
				end
			})

			var_6_8:setPosition(var_6_6.width / 2, var_6_6.height / 2 + 10)
			var_6_7:addChild(var_6_8)
			table.insert(var_6_5, var_6_7)
		end

		local var_6_9 = var_0_1.linearLayout({
			margin = 0,
			direction = "horizontal",
			nodes = var_6_5
		})

		var_6_9:setAnchorPoint(ccp(0, 0.5))
		var_6_9:setPosition(165, var_3_1.height / 2)
		var_6_2:addChild(var_6_9)

		if Player.level >= arg_3_0.mRewardData[var_6_1].level then
			local var_6_10 = ui.newControlButton({
				normalImage = "ui/activity/activity_064.png",
				disabledImage = "ui/activity/activity_065.png",
				position = ccp(var_3_1.width - 80, var_3_1.height / 2),
				clickAction = function()
					arg_3_0:getLeveupGiftBat(arg_3_0.mRewardData[var_6_1].level)
				end
			})

			var_6_2:addChild(var_6_10)

			local var_6_11 = display.newSprite("uilocal/activity/activity_text_031.png")
			local var_6_12 = var_6_10:getContentSize()

			var_6_11:setPosition(var_6_12.width / 2, var_6_12.height / 2)
			var_6_10:addChild(var_6_11)
		end

		return var_6_0
	end

	var_3_0:registerScriptHandler(var_3_2, CCTableView.kTableCellSizeForIndex)
	var_3_0:registerScriptHandler(var_3_3, CCTableView.kNumberOfCellsInTableView)
	var_3_0:registerScriptHandler(var_3_4, CCTableView.kTableCellSizeAtIndex)

	return var_3_0
end

function var_0_2.refreshGiftInfo(arg_9_0)
	local function var_9_0(arg_10_0)
		arg_9_0.mRewardData = {}

		table.foreach(arg_10_0, function(arg_11_0, arg_11_1)
			table.insert(arg_9_0.mRewardData, {
				level = arg_11_1.Level,
				rewards = arg_11_1.RewardResponse,
				canGet = arg_11_1.IsGetStatus == 1
			})
		end)
		table.sort(arg_9_0.mRewardData, function(arg_12_0, arg_12_1)
			return arg_12_0.level < arg_12_1.level
		end)
		arg_9_0.giftTableView:reloadData()
	end

	LevelupGiftData:getLevelupGift(var_9_0)
end

function var_0_2.initGetGiftRequest(arg_13_0)
	if not arg_13_0.getGiftReuquest then
		local function var_13_0()
			showFlashNotice(string.lf("领取礼包成功，道具已收取."))
			LevelupGiftData:removeLevelupGiftBag(arg_13_0.getGiftRequest:getRequestLevel())
			arg_13_0:refreshGiftInfo()

			local var_14_0 = Player:getLevelGiftStatus()

			if var_14_0 > 0 then
				var_14_0 = var_14_0 - 1
			end

			if var_14_0 == 0 then
				var_14_0 = nil
			end

			Player:setLevelGiftStatus(var_14_0)
		end

		local function var_13_1(arg_15_0)
			return
		end

		arg_13_0.getGiftRequest = ActivityGetLevelupGiftRequest:new()

		arg_13_0.getGiftRequest:setResponseNormalHandler(var_13_0)
		arg_13_0.getGiftRequest:setResponseExceptionHandler(var_13_1)
	end
end

function var_0_2.getLeveupGiftBat(arg_16_0, arg_16_1)
	if not arg_16_0.getGiftRequest then
		arg_16_0:initGetGiftRequest()
	end

	arg_16_0.getGiftRequest:request(arg_16_1)
end

return var_0_2
