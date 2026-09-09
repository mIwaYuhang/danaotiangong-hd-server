require("network.ActivityRequest")

local var_0_0 = require("scenes.toollayer.tool")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = require("base.cache")
local var_0_3 = require("scenes.toollayer.model")
local var_0_4 = require("scenes.ToolLayer")
local var_0_5 = var_0_3:extend({
	ctor = function(arg_1_0)
		arg_1_0:set("count", -1)
		arg_1_0:set("sign", 0)
	end,
	attach = function(arg_2_0, arg_2_1)
		arg_2_0.request = SignMonthRequest:new(arg_2_1)

		arg_2_0.request:setResponseNormalHandler(function()
			local var_3_0, var_3_1 = arg_2_0.request:getResponseContent()

			if var_3_0 == SignMonthRequest.eInfo then
				arg_2_0:set("list", var_3_1.SingRewardLst)
				arg_2_0:set("count", var_3_1.MonthSignDay)
				arg_2_0:set("sign", var_3_1.HaveGetTime)
				arg_2_0:set("index", var_3_1.Day)
				arg_2_0:trigger("sync", arg_2_0)

				arg_2_0.dirty = false
				arg_2_0.viplevel = Player.vipLevel
			elseif var_3_0 == SignMonthRequest.eSign then
				arg_2_0:set("sign", var_3_1.HaveGetTime)
				arg_2_0:set("count", var_3_1.MonthSignDay)
				arg_2_0:trigger("sign")
			end
		end)
		arg_2_0.request:setResponseExceptionHandler(function()
			arg_2_0.dirty = true
		end)
	end,
	sync = function(arg_5_0)
		if arg_5_0.dirty or arg_5_0.viplevel ~= Player.vipLevel then
			arg_5_0:requestInfo()
		else
			arg_5_0:trigger("sync", arg_5_0)
		end
	end,
	requestInfo = function(arg_6_0)
		arg_6_0.request:requestInfo()
	end,
	requestSign = function(arg_7_0)
		arg_7_0.request:requestSign()
	end
})
local var_0_6 = class("SignMonthLayer", function()
	return display.newLayer()
end)

function var_0_6.ctor(arg_9_0, arg_9_1)
	arg_9_0:setNodeEventEnabled(true)

	arg_9_0.parent = arg_9_1.parent
	arg_9_0.model = var_0_2.get(arg_9_0)

	if not arg_9_0.model then
		arg_9_0.model = var_0_5:new()

		var_0_2.set(arg_9_0, arg_9_0.model)
	end

	arg_9_0.model:attach()
end

function var_0_6.onEnter(arg_10_0)
	local var_10_0 = display.newSprite("ui/activity/activity_098.jpg")
	local var_10_1 = var_10_0:getContentSize()

	var_10_0:setAnchorPoint(ccp(0, 0))
	var_10_0:setPosition(0, 0)
	arg_10_0:setContentSize(var_10_1)
	arg_10_0:addChild(var_10_0)

	arg_10_0.container = var_10_0

	local var_10_2 = arg_10_0:createCountView()

	var_10_2:setPosition(578, 50)
	var_10_0:addChild(var_10_2)
	arg_10_0.model:on("sync", arg_10_0.onSync, arg_10_0)
	arg_10_0.model:on("sign", arg_10_0.onSign, arg_10_0)
	arg_10_0.model:sync()
end

function var_0_6.onExit(arg_11_0)
	arg_11_0:setNodeEventEnabled(false)
	arg_11_0.model:detach()
end

function var_0_6.onSync(arg_12_0)
	local var_12_0 = arg_12_0:createRewardView()

	var_12_0:setPosition(8, 8)
	arg_12_0.container:addChild(var_12_0)

	arg_12_0.rewardView = var_12_0
end

function var_0_6.onSign(arg_13_0)
	local var_13_0 = arg_13_0.model:get("index")
	local var_13_1 = arg_13_0.rewardView.nodes
	local var_13_2 = arg_13_0.rewardView.cellSize
	local var_13_3 = var_13_1[var_13_0]

	var_13_3.header:stopAllActions()

	if not var_13_3.mask then
		local var_13_4 = display.newSprite("ui/activity/activity_100.png")

		var_13_4:setPosition(var_13_2.width / 2, var_13_2.height / 2)
		var_13_4:setOpacity(160)
		var_13_3:addChild(var_13_4, 1)

		var_13_3.mask = var_13_4
	end

	if not var_13_3.mark then
		local var_13_5 = display.newSprite("ui/activity/activity_102.png")

		arg_13_0:signAnimate(var_13_5, var_13_3, arg_13_0.rewardView)

		var_13_3.mark = var_13_5
	end

	Player:setSignMonthCount(0)
end

function var_0_6.createRewardView(arg_14_0)
	local var_14_0 = CCSize(565, 550)
	local var_14_1 = var_0_1.newNode()

	var_14_1:setContentSize(var_14_0)

	local function var_14_2(arg_15_0)
		local var_15_0 = CCNode.getContentSize(arg_15_0)

		var_15_0.width, var_15_0.height = var_15_0.width - 2, var_15_0.height - 4

		return var_15_0
	end

	local var_14_3 = CCTextureCache:sharedTextureCache():addImage("ui/activity/activity_099.png"):getContentSize()
	local var_14_4
	local var_14_5 = {}

	for iter_14_0 = 1, 36 do
		local var_14_6 = display.newSprite("ui/activity/activity_101.png")

		var_14_6:setVisible(false)

		var_14_6.getContentSize = var_14_2

		table.insert(var_14_5, var_14_6)
	end

	local var_14_7 = arg_14_0.model:get("list")
	local var_14_8 = arg_14_0.model:get("sign")
	local var_14_9 = arg_14_0.model:get("index")
	local var_14_10 = arg_14_0.model:get("count")
	local var_14_11 = #var_14_7
	local var_14_12
	local var_14_13
	local var_14_14

	for iter_14_1, iter_14_2 in ipairs(var_14_7) do
		local var_14_15 = iter_14_2.vip
		local var_14_16 = iter_14_2.reward[1]
		local var_14_17 = var_14_5[iter_14_1]

		if iter_14_1 <= var_14_10 then
			if var_14_9 ~= iter_14_1 or var_14_8 < 1 then
				local var_14_18 = display.newSprite("ui/activity/activity_100.png")

				var_14_18:setPosition(var_14_3.width / 2, var_14_3.height / 2)
				var_14_18:setOpacity(160)
				var_14_17:addChild(var_14_18, 1)

				var_14_17.mask = var_14_18
			end

			local var_14_19 = display.newSprite("ui/activity/activity_102.png")

			var_14_19:setPosition(var_14_3.width / 2, var_14_3.height / 2)
			var_14_17:addChild(var_14_19, 1)

			var_14_17.mark = var_14_19
		end

		local var_14_20 = figure.createHeader({
			type = var_14_16.Type,
			itemId = var_14_16.ID or 0,
			count = var_14_16.Count,
			clickAction = function(arg_16_0, arg_16_1)
				arg_14_0:clickhandler(iter_14_1, var_14_15, var_14_16)
			end
		})

		var_14_20:setPosition(var_14_3.width / 2, var_14_3.height / 2)

		if var_14_15 > 0 then
			local var_14_21 = createMarkLabel({
				size = 14,
				text = string.lf("V%s双倍", tostring(var_14_15)),
				color = ccc3(255, 255, 100)
			})

			var_14_21:setScale(0.7)
			var_14_21:setPosition(-12, 10)
			var_14_20:addChild(var_14_21)
		end

		var_14_17:setVisible(true)
		var_14_17:addChild(var_14_20)

		var_14_17.header = var_14_20
	end

	var_0_1.tableLayout({
		row = 6,
		col = 6,
		parent = var_14_1,
		nodes = var_14_5
	})

	if var_14_8 > 0 then
		local var_14_22 = 0.3
		local var_14_23 = CCArray:create()

		var_14_23:addObject(CCScaleTo:create(var_14_22, 1.05))
		var_14_23:addObject(CCScaleTo:create(var_14_22, 0.95))

		local var_14_24 = CCRepeatForever:create(CCSequence:create(var_14_23))

		var_14_5[var_14_9].header:runAction(var_14_24)
	end

	var_14_1.nodes = var_14_5
	var_14_1.cellSize = var_14_3

	return var_14_1
end

function var_0_6.createCountView(arg_17_0)
	local var_17_0 = CCSize(240, 200)
	local var_17_1 = var_0_1.newNode()

	var_17_1:setContentSize(var_17_0)

	local var_17_2 = var_0_1.newLabel({
		size = 24,
		outline = true,
		text = string.lf("本月累积签到:"),
		color = ccc3(230, 250, 60)
	})

	var_17_2:setPosition(var_17_0.width / 2, 160)
	var_17_1:addChild(var_17_2)

	local var_17_3 = display.newSprite("ui/activity/activity_098.png")

	var_17_3:setPosition(var_17_0.width / 2, 100)
	var_17_1:addChild(var_17_3)

	local var_17_4 = var_0_1.newLabel({
		size = 30,
		outline = true,
		text = string.lf("0 天"),
		color = ccc3(230, 250, 60)
	})

	var_17_4:setPosition(var_17_0.width / 2, 100)
	var_17_1:addChild(var_17_4)
	arg_17_0.model:bind("count", function(arg_18_0)
		var_17_4:setString(string.lf("%s 天", tostring(arg_18_0)))
	end)

	return var_17_1
end

function var_0_6.clickhandler(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_0.model:get("sign")

	if arg_19_0.model:get("index") == arg_19_1 then
		if var_19_0 > 0 then
			arg_19_0.model:requestSign()
		elseif arg_19_2 > arg_19_0.model.viplevel then
			ui.showMessageBox({
				animate = "slide",
				text = string.lf("上仙！今日签到奖励已领取，提升VIP等级可再领取一次，是否去充值？"),
				title1 = string.lf("确定"),
				title2 = string.lf("取消"),
				action1 = function()
					game.enterStoreRechargeScene({
						from = "SignMonthLayer"
					})
				end
			})
		else
			ui.showMessageBox({
				slide = true,
				text = string.lf("上仙，今日签到奖励已领取，明天请早哟~")
			})
		end
	else
		var_0_4.tipshandler(arg_19_3)
	end
end

function var_0_6.enterAnimate(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0.model:get("sign")
	local var_21_1 = arg_21_0.model:get("index")
	local var_21_2 = 0
	local var_21_3 = 0
	local var_21_4 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		local var_21_5, var_21_6 = iter_21_1:getPosition()

		table.insert(var_21_4, var_21_5)
		table.insert(var_21_4, var_21_6)
	end

	local function var_21_7(arg_22_0, arg_22_1)
		local var_22_0 = math.floor(arg_22_0 / arg_22_1)

		if arg_22_0 % arg_22_1 ~= 0 then
			var_22_0 = var_22_0 + 1
		end

		return var_22_0
	end

	local var_21_8 = 1
	local var_21_9 = 1
	local var_21_10 = #var_21_4

	while var_21_8 < var_21_10 do
		local var_21_11 = var_21_7(var_21_8, 12)

		cell = arg_21_1[(var_21_8 + 1) / 2]

		local var_21_12, var_21_13 = var_21_4[var_21_8], var_21_4[var_21_8 + 1]

		cell:setPosition(var_21_12, var_21_13 + var_21_11 * 20)

		local var_21_14 = CCArray:create()

		var_21_14:addObject(CCDelayTime:create(0.025 * var_21_11))
		var_21_14:addObject(CCMoveTo:create(0.2, ccp(var_21_12, var_21_13)))

		if var_21_8 + 1 == var_21_10 and arg_21_2 then
			var_21_14:addObject(CCCallFunc:create(arg_21_2))
		end

		cell:runAction(CCSequence:create(var_21_14))

		var_21_8 = var_21_8 + 2
	end
end

function var_0_6.signAnimate(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local function var_23_0(arg_24_0, arg_24_1)
		local var_24_0 = math.random(1, 2)
		local var_24_1 = -var_24_0
		local var_24_2, var_24_3 = arg_24_0:getPosition()
		local var_24_4 = CCArray:create()

		var_24_4:addObject(CCMoveBy:create(0.03, ccp(var_24_0, var_24_0)))
		var_24_4:addObject(CCMoveBy:create(0.03, ccp(var_24_1, var_24_1)))
		var_24_4:addObject(CCMoveBy:create(0.03, ccp(var_24_0, var_24_1)))
		var_24_4:addObject(CCMoveBy:create(0.03, ccp(var_24_1, var_24_0)))

		if arg_24_1 then
			var_24_4:addObject(CCCallFunc:create(arg_24_1))
		end

		arg_24_0:stopAllActions()
		arg_24_0:runAction(CCSequence:create(var_24_4))
	end

	local var_23_1 = arg_23_1
	local var_23_2 = arg_23_2
	local var_23_3
	local var_23_4 = arg_23_3:getContentSize()
	local var_23_5, var_23_6 = var_23_2:getPosition()
	local var_23_7 = var_23_2:getContentSize()

	var_23_1:setScale(10)
	var_23_1:setPosition(var_23_4.width / 2, var_23_4.height / 2)
	var_23_1:setOpacity(0)
	arg_23_3:addChild(var_23_1)

	local var_23_8 = CCArray:create()
	local var_23_9 = CCScaleTo:create(0.4, 1)
	local var_23_10 = CCMoveTo:create(0.4, ccp(var_23_5, var_23_6))
	local var_23_11 = CCFadeTo:create(0.4, 255)

	var_23_8:addObject(var_23_9)
	var_23_8:addObject(var_23_10)
	var_23_8:addObject(var_23_11)

	local var_23_12 = CCSpawn:create(var_23_8)
	local var_23_13 = CCCallFunc:create(function()
		local var_25_0 = var_23_2:getContentSize()

		var_23_1:removeFromParent()
		var_23_1:setPosition(var_25_0.width / 2, var_25_0.height / 2)
		var_23_2:addChild(var_23_1, 1)
		var_23_0(arg_23_3)
	end)
	local var_23_14 = CCArray:create()

	var_23_14:addObject(var_23_12)
	var_23_14:addObject(var_23_13)
	var_23_1:runAction(CCSequence:create(var_23_14))
end

return var_0_6
