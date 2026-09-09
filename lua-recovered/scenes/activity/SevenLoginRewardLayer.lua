require("base.functions")
require("data.player")
require("network.ActivityRequest")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = require("base.cache")
local var_0_2 = require("scenes.toollayer.event")
local var_0_3 = require("scenes.ToolLayer")
local var_0_4 = require("scenes.toollayer.model"):extend({
	attach = function(arg_1_0, arg_1_1)
		arg_1_0:detach()

		arg_1_0.request = SevenLoginRewardRequest:new(arg_1_1)

		arg_1_0.request:setResponseNormalHandler(function()
			local var_2_0, var_2_1 = arg_1_0.request:getResponseContent()

			if var_2_0 == SevenLoginRewardRequest.eList then
				local var_2_2 = var_2_1.GetSverDaysReward

				arg_1_0.data = var_2_2
				arg_1_0.dirty = false

				arg_1_0:trigger("sync", arg_1_0:parse(var_2_2))
			elseif var_2_0 == SevenLoginRewardRequest.eReward then
				local var_2_3 = arg_1_0.rewardValue.Time

				arg_1_0.firstTime = arg_1_0.firstTime + 1
				arg_1_0.rewardCount = arg_1_0.rewardCount - 1
				arg_1_0.rewardValue.Status = 2
				arg_1_0.data[var_2_3].Status = 2

				arg_1_0:trigger("reward")
				arg_1_0.rewardValue:trigger("obtain", arg_1_0.rewardValue)
			end
		end)
		arg_1_0.request:setResponseExceptionHandler(function()
			print("处理请求发生错误")
		end)
	end,
	sync = function(arg_4_0)
		if arg_4_0.dirty then
			arg_4_0.request:requestList()
		else
			arg_4_0:trigger("sync", arg_4_0:parse(arg_4_0.data))
		end
	end,
	parse = function(arg_5_0, arg_5_1)
		local var_5_0
		local var_5_1 = {}
		local var_5_2 = 0
		local var_5_3 = 0

		for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
			if iter_5_1.Status == 1 then
				if var_5_2 == 0 then
					var_5_2 = iter_5_0
				end

				var_5_3 = var_5_3 + 1
			end

			local var_5_4 = var_0_2:new()

			table.merge(var_5_4, iter_5_1)
			table.insert(var_5_1, var_5_4)
		end

		arg_5_0.firstTime = var_5_2
		arg_5_0.rewardCount = var_5_3

		return var_5_1
	end,
	reward = function(arg_6_0, arg_6_1)
		arg_6_0.rewardValue = arg_6_1

		arg_6_0.request:requestReward(arg_6_1.Time)
	end
})
local var_0_5 = class("SevenLoginRewardLayer", function()
	return display.newLayer()
end)

function var_0_5.ctor(arg_8_0, arg_8_1)
	arg_8_0.parent = arg_8_1.parent.container
	arg_8_0.container = arg_8_0
	arg_8_0.obtain = nil
	arg_8_0.time = 0
	arg_8_0.retry = true
	arg_8_0.model = var_0_1.get(arg_8_0)

	if not arg_8_0.model then
		arg_8_0.model = var_0_4:new()

		var_0_1.set(arg_8_0, arg_8_0.model)
	end

	arg_8_0.model:attach()
	arg_8_0:initLayout()
end

function var_0_5.initLayout(arg_9_0)
	local var_9_0 = display.newSprite("ui/activity/activity_050.jpg")
	local var_9_1 = var_9_0:getContentSize()

	var_9_0:setAnchorPoint(ccp(0, 0))
	var_9_0:setPosition(0, 0)
	arg_9_0:setContentSize(var_9_1)
	arg_9_0:addChild(var_9_0)

	arg_9_0.container = var_9_0

	local var_9_2 = CCSize(811, 410)
	local var_9_3 = {
		direction = kCCScrollViewDirectionVertical,
		size = var_9_2,
		sizehandler = function(arg_10_0, arg_10_1)
			return CCSize(811, 120)
		end,
		cellhandler = handler(arg_9_0, arg_9_0.createRewardItem)
	}
	local var_9_4 = createTableView(var_9_3)

	var_9_4:setPosition((var_9_1.width - var_9_2.width) / 2, 3)
	var_9_0:addChild(var_9_4)

	arg_9_0.tableview = var_9_4

	arg_9_0.model:on("sync", arg_9_0.onSync, arg_9_0)
	arg_9_0.model:on("reward", arg_9_0.onReward, arg_9_0)
	arg_9_0.model:sync()
end

function var_0_5.onSync(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.tableview

	var_11_0:reloadData(arg_11_1)

	if arg_11_0.model.firstTime > 4 then
		var_11_0:setContentOffset(var_11_0:maxContainerOffset())
	end

	Player:setSevenLoginCount(arg_11_0.model.rewardCount)
end

function var_0_5.onReward(arg_12_0, arg_12_1)
	Player:setSevenLoginCount(arg_12_0.model.rewardCount)
end

function var_0_5.createRewardItem(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = display.newSprite("ui/activity/activity_067.png")
	local var_13_1 = var_13_0:getContentSize()

	var_13_0:setAnchorPoint(ccp(0, 0))
	var_13_0:setPosition(5, 4)

	local var_13_2 = {
		"uilocal/activity/activity_text_032.png",
		"uilocal/activity/activity_text_033.png",
		"uilocal/activity/activity_text_034.png",
		"uilocal/activity/activity_text_035.png",
		"uilocal/activity/activity_text_036.png",
		"uilocal/activity/activity_text_037.png",
		"uilocal/activity/activity_text_038.png"
	}
	local var_13_3 = display.newSprite(var_13_2[arg_13_3.Time])

	var_13_3:setAnchorPoint(ccp(0, 0.5))
	var_13_3:setPosition(0, var_13_1.height / 2)
	var_13_0:addChild(var_13_3)

	local var_13_4 = {}
	local var_13_5
	local var_13_6 = CCSize(120, 110)
	local var_13_7
	local var_13_8
	local var_13_9

	for iter_13_0, iter_13_1 in ipairs(arg_13_3.RewardS) do
		local var_13_10 = var_0_0.newNode()

		var_13_10:setContentSize(var_13_6)

		local var_13_11 = figure.createHeader({
			type = iter_13_1.Type,
			itemId = iter_13_1.ID or 0,
			clickAction = function(arg_14_0, arg_14_1)
				var_0_3.tipshandler(iter_13_1)
			end
		})

		var_13_11:setPosition(var_13_6.width / 2, var_13_6.height / 2 + 10)
		var_13_10:addChild(var_13_11)

		local var_13_12 = getItemName(iter_13_1.Type, iter_13_1.ID)

		if iter_13_1.Type == ItemType.eVIPLevel then
			var_13_12 = var_13_12 .. iter_13_1.Count
		else
			var_13_12 = var_13_12 .. "x" .. iter_13_1.Count
		end

		local var_13_13 = var_0_0.newLabel({
			size = 18,
			text = var_13_12
		})

		var_13_13:setPosition(var_13_6.width / 2, 10)
		var_13_10:addChild(var_13_13)
		table.insert(var_13_4, var_13_10)
	end

	local var_13_14 = var_0_0.linearLayout({
		margin = 20,
		direction = "horizontal",
		nodes = var_13_4
	})

	var_13_14:setAnchorPoint(ccp(0, 0.5))
	var_13_14:setPosition(195, var_13_1.height / 2)
	var_13_0:addChild(var_13_14)

	local var_13_15 = arg_13_3.Status
	local var_13_16 = ui.newControlButton({
		normalImage = "ui/activity/activity_064.png",
		disabledImage = "ui/activity/activity_065.png",
		clickAction = function(arg_15_0, arg_15_1)
			arg_13_0.model:reward(arg_13_3)
		end
	})

	var_13_16:setPosition(var_13_1.width - 120, var_13_1.height / 2)
	var_13_0:addChild(var_13_16)

	function var_13_16.setStatus(arg_16_0, arg_16_1)
		local var_16_0 = arg_16_0:getContentSize()
		local var_16_1
		local var_16_2 = false

		if arg_16_1 == 1 then
			var_16_1 = "uilocal/activity/activity_text_031.png"
			var_16_2 = true
		elseif arg_16_1 == 2 then
			var_16_1 = "uilocal/activity/activity_text_029.png"
		elseif arg_16_1 == 3 then
			var_16_1 = "uilocal/activity/activity_text_030.png"
		end

		arg_16_0:setEnabled(var_16_2)

		local var_16_3 = arg_16_0.child

		if var_16_3 then
			var_16_3:removeFromParent()
		end

		local var_16_4 = display.newSprite(var_16_1)

		var_16_4:setPosition(var_16_0.width / 2, var_16_0.height / 2)
		arg_16_0:addChild(var_16_4)

		arg_16_0.child = var_16_4
	end

	var_13_16:setStatus(var_13_15)
	arg_13_3:on("obtain", function(arg_17_0)
		var_13_16:setStatus(arg_17_0.Status)
	end)

	return var_13_0
end

return var_0_5
