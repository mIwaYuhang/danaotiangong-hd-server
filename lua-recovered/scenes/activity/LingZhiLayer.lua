require("base.functions")
require("data.player")
require("network.ActivityRequest")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = require("base.cache")
local var_0_2 = require("scenes.activity.WeiLingLayer")
local var_0_3 = require("scenes.ToolLayer")
local var_0_4 = require("scenes.toollayer.model"):extend({
	ctor = function(arg_1_0)
		arg_1_0:set("pick", 0)
		arg_1_0:set("use", 0)
		arg_1_0:set("type", 0)
		arg_1_0:set("cost", 0)
		arg_1_0:set("tween", false)
	end,
	attach = function(arg_2_0, arg_2_1)
		arg_2_0:detach()

		arg_2_0.request = LingZhiRequest:new(arg_2_1)

		arg_2_0.request:setResponseNormalHandler(function()
			local var_3_0, var_3_1 = arg_2_0.request:getResponseContent()

			if var_3_0 == LingZhiRequest.eList then
				arg_2_0.dirty = false

				local var_3_2 = var_3_1.remainFreeRefreshTime
				local var_3_3 = var_3_1.remainEatTime
				local var_3_4 = var_3_1.selectType
				local var_3_5 = var_3_1.refreshCost

				arg_2_0:set("pick", var_3_2)
				arg_2_0:set("use", var_3_3)
				arg_2_0:set("type", var_3_4)
				arg_2_0:set("cost", var_3_5)

				arg_2_0.lingzhi = var_3_1.Ganodermas

				arg_2_0:trigger("sync", arg_2_0)
			elseif var_3_0 == LingZhiRequest.eRefresh then
				local var_3_6 = arg_2_0:get("pick")

				if var_3_6 > 0 then
					arg_2_0:set("pick", var_3_6 - 1)
				end

				arg_2_0:set("type", var_3_1)
				arg_2_0:trigger("refresh")
			elseif var_3_0 == LingZhiRequest.eCall then
				arg_2_0:set("type", arg_2_0.conjureValue)
				arg_2_0:trigger("conjure")
			elseif var_3_0 == LingZhiRequest.eUse then
				arg_2_0:set("use", arg_2_0:get("use") - 1)
				arg_2_0:set("type", 1)
				arg_2_0:trigger("use")
			end
		end)
		arg_2_0.request:setResponseExceptionHandler(function()
			arg_2_0.dirty = true

			print("处理请求发生错误")
		end)
	end,
	sync = function(arg_5_0)
		if arg_5_0.dirty then
			arg_5_0.request:requestLingZhiList()
		else
			arg_5_0:trigger("sync", arg_5_0)
		end
	end,
	refreshLingZhi = function(arg_6_0)
		arg_6_0.request:requestRefreshLingZhi()
	end,
	conjureLingZhi = function(arg_7_0, arg_7_1)
		arg_7_0.conjureValue = arg_7_1

		arg_7_0.request:requestCallLingZhi(arg_7_1)
	end,
	useLingZhi = function(arg_8_0, arg_8_1)
		arg_8_0.request:requestUseLingZhi(arg_8_1, arg_8_0:get("type"))
	end
})
local var_0_5 = class("LingZhiLayer", function()
	return display.newLayer()
end)

function var_0_5.ctor(arg_10_0, arg_10_1)
	arg_10_0.parent = arg_10_1.parent.container
	arg_10_0.weiling = nil
	arg_10_0.container = arg_10_0
	arg_10_0.model = var_0_1.get(arg_10_0)

	if not arg_10_0.model then
		arg_10_0.model = var_0_4:new()

		var_0_1.set(arg_10_0, arg_10_0.model)
	end

	arg_10_0.model:attach()
	arg_10_0:initLayout()
end

function var_0_5.initLayout(arg_11_0)
	local var_11_0 = display.newSprite("ui/activity/activity_056.jpg")
	local var_11_1 = var_11_0:getContentSize()

	var_11_0:setAnchorPoint(ccp(0, 0))
	arg_11_0:addChild(var_11_0)

	arg_11_0.container = var_11_0

	local var_11_2 = display.newSprite("uilocal/activity/activity_text_013.png")

	var_11_2:setPosition(220, 500)
	var_11_0:addChild(var_11_2)

	local var_11_3 = var_0_0.newLabel({
		outline = true,
		text = string.lf("采集灵芝服用后，灵台通明，悟性大增\n可获不少培养用的潜力值")
	})

	var_11_3:setAnchorPoint(ccp(0, 0.5))
	var_11_3:setPosition(325, 500)
	var_11_0:addChild(var_11_3)

	local var_11_4 = ui.newControlButton({
		disabledImage = "ui/common/common_080.png",
		normalImage = "ui/common/common_019.png",
		highlightedImage = "ui/common/common_019.png",
		text = string.lf("选灵芝"),
		fontSize = ColorTable.eTitleButton_FontSize2,
		textColor = ColorTable.eTitleButton_Normal2,
		clickAction = function(arg_12_0, arg_12_1)
			arg_11_0.model:refreshLingZhi()
		end
	})

	var_11_4:setTitleColorForState(ccc3(30, 30, 30), CCControlStateDisabled)
	var_11_4:setPosition(var_11_1.width / 2 - 200, 60)
	var_11_0:addChild(var_11_4)
	arg_11_0.model:bind("type|use", function(arg_13_0, arg_13_1)
		var_11_4:setEnabled(arg_13_0 ~= 5 and arg_13_1 > 0)
	end)

	local var_11_5 = var_0_0.newLabel({
		text = "",
		color = ccc3(250, 230, 60)
	})

	var_11_5:setPosition(var_11_1.width / 2 - 200, 20)
	var_11_0:addChild(var_11_5)
	arg_11_0.model:bind("pick", function(arg_14_0)
		local var_14_0 = string.lf("免费选 %s 次", tostring(arg_14_0))

		var_11_5:setString(var_14_0)
		var_11_5:setVisible(arg_14_0 > 0)
	end)

	local var_11_6 = var_0_0.newLabel({
		text = string.lf("花费："),
		color = ccc3(250, 230, 60)
	})
	local var_11_7 = createItemCountNode({
		value = 0,
		type = ItemType.eGold,
		color = ccc3(250, 230, 60)
	})

	var_11_6:setPosition(var_11_1.width / 2 - 230, 20)
	var_11_7:setPosition(var_11_1.width / 2 - 180, 20)
	var_11_0:addChild(var_11_6)
	var_11_0:addChild(var_11_7)
	var_11_6:setVisible(false)
	var_11_7:setVisible(false)
	arg_11_0.model:bind("pick|cost", function(arg_15_0, arg_15_1)
		var_11_7:setValue(arg_15_1)
		var_11_7:setVisible(arg_15_0 < 1)
		var_11_6:setVisible(arg_15_0 < 1)
	end)

	local var_11_8 = arg_11_0:createLingZhiView()

	var_11_8:setAnchorPoint(ccp(0.5, 0.5))
	var_11_8:setPosition(var_11_1.width / 2, 230)
	var_11_0:addChild(var_11_8)

	arg_11_0.lingzhi = var_11_8

	local var_11_9 = ui.newControlButton({
		fontSize = 24,
		disabledImage = "ui/common/common_080.png",
		normalImage = "ui/common/common_055.png",
		highlightedImage = "ui/common/common_055.png",
		text = string.lf("服用"),
		textColor = ccc3(248, 236, 178),
		clickAction = function(arg_16_0, arg_16_1)
			if arg_11_0.model:get("use") > 0 then
				arg_11_0:showPopupView()
			else
				ui.showMessageBox({
					animate = "slide",
					text = string.lf("上仙，提升VIP等级可以增加服用次数和免费刷新次数哦！")
				})
			end
		end
	})

	var_11_9:setTitleColorForState(ccc3(30, 30, 30), CCControlStateDisabled)
	var_11_9:setPosition(var_11_1.width / 2 + 200, 60)
	var_11_0:addChild(var_11_9)

	local var_11_10 = var_0_0.newLabel({
		text = "",
		color = ccc3(250, 230, 60)
	})

	var_11_10:setPosition(var_11_1.width / 2 + 200, 20)
	var_11_0:addChild(var_11_10)
	arg_11_0.model:bind("use", function(arg_17_0)
		local var_17_0

		if arg_17_0 > 0 then
			var_17_0 = string.lf("可服用 %s 次", tostring(arg_17_0))
		else
			var_17_0 = string.lf("今日可服用次数已用完，T.T")
		end

		var_11_10:setString(var_17_0)
	end)
	arg_11_0.model:on("sync", arg_11_0.onSync, arg_11_0)
	arg_11_0.model:on("use", arg_11_0.onUse, arg_11_0)
	arg_11_0.model:sync()
end

function var_0_5.onSync(arg_18_0, arg_18_1)
	arg_18_0.lingzhi:reloadData(arg_18_1.lingzhi)
end

function var_0_5.onRefresh(arg_19_0)
	return
end

function var_0_5.onConjure(arg_20_0)
	return
end

function var_0_5.onUse(arg_21_0)
	Player:setLingZhiCount(arg_21_0.model:get("use"))
	arg_21_0.endback(true)
end

function var_0_5.showPopupView(arg_22_0)
	var_0_3.createDialog({
		type = PropType.ePotencyPill,
		show = var_0_3.eShowHeroList,
		title = {
			image = "uilocal/activity/activity_text_015.png"
		},
		callback = function(arg_23_0, arg_23_1)
			arg_22_0.model:useLingZhi(arg_23_0)

			arg_22_0.endback = arg_23_1
		end
	}):show()
end

function var_0_5.createLingZhiView(arg_24_0)
	local var_24_0 = {
		ccp(35, 185),
		ccp(150, 135),
		ccp(300, 95),
		ccp(450, 135),
		ccp(565, 185)
	}
	local var_24_1 = CCSize(600, 200)
	local var_24_2 = CCNode:create()

	var_24_2:setContentSize(var_24_1)

	local var_24_3 = display.newSprite("ui/activity/activity_038.png")

	var_24_2:addChild(var_24_3)
	var_24_3:setVisible(false)

	local var_24_4 = {}

	for iter_24_0 = 1, 5 do
		local var_24_5 = display.newSprite("ui/common/common_011.png")

		var_24_5:setPosition(var_24_0[iter_24_0])
		var_24_2:addChild(var_24_5)
		table.insert(var_24_4, var_24_5)
	end

	local var_24_6 = arg_24_0
	local var_24_7 = {}

	function var_24_2.reloadData(arg_25_0, arg_25_1)
		for iter_25_0 = #var_24_7, 1, -1 do
			var_24_7[iter_25_0]:removeFromParent()
			table.remove(var_24_7, iter_25_0)
		end

		for iter_25_1, iter_25_2 in ipairs(arg_25_1) do
			local var_25_0 = var_24_6:createLingZhiItem(arg_25_1[iter_25_1])

			var_25_0:setPosition(-20, -75)
			var_24_4[iter_25_1]:addChild(var_25_0)
			table.insert(var_24_7, var_25_0)
		end
	end

	arg_24_0.model:bind("type", function(arg_26_0, arg_26_1)
		if arg_26_0 < 1 then
			return
		end

		arg_26_1 = arg_26_1 or 0

		if arg_26_1 > 0 then
			arg_24_0.model:set("tween", true)
			arg_24_0:animate("move", var_24_3, var_24_4, arg_26_1, arg_26_0, function()
				arg_24_0.model:set("tween", false)
				arg_24_0:animate("blink", var_24_3)
			end)
		else
			local var_26_0, var_26_1 = var_24_4[arg_26_0]:getPosition()

			var_24_3:setPosition(var_26_0, var_26_1)
			arg_24_0:animate("blink", var_24_3)
			var_24_3:setVisible(true)
		end
	end)

	return var_24_2
end

function var_0_5.createLingZhiItem(arg_28_0, arg_28_1)
	local var_28_0 = {
		"ui/activity/activity_032.png",
		"ui/activity/activity_033.png",
		"ui/activity/activity_034.png",
		"ui/activity/activity_035.png",
		"ui/activity/activity_036.png"
	}
	local var_28_1 = CCSize(120, 215)
	local var_28_2 = CCNode:create()

	var_28_2:setContentSize(var_28_1)

	local var_28_3 = arg_28_1.callCost

	if var_28_3 and var_28_3 > 0 then
		local var_28_4 = createItemCountNode({
			type = ItemType.eGold,
			value = var_28_3
		})

		var_28_4:setPosition(45, 200)
		var_28_2:addChild(var_28_4)

		local var_28_5 = ui.newControlButton({
			fontSize = 20,
			normalImage = "ui/transport/transport_022.png",
			text = string.lf("召唤"),
			textColor = ccc3(102, 76, 51),
			clickAction = function(arg_29_0, arg_29_1)
				arg_28_0.model:conjureLingZhi(arg_28_1.type)
			end
		})

		var_28_5:setPosition(var_28_1.width / 2, 170)
		var_28_2:addChild(var_28_5, 1)

		var_28_2.cost = var_28_4
		var_28_2.conjure = var_28_5

		arg_28_0.model:bind("type|tween", function(arg_30_0, arg_30_1)
			local var_30_0 = arg_28_1.type ~= arg_30_0 and not arg_30_1

			var_28_4:setVisible(var_30_0)
			var_28_5:setVisible(var_30_0)
		end)
	end

	local var_28_6 = display.newSprite(var_28_0[arg_28_1.type])

	var_28_6:setPosition(var_28_1.width / 2, 105)
	var_28_2:addChild(var_28_6)

	local var_28_7 = display.newSprite("ui/activity/activity_062.png")
	local var_28_8 = var_28_7:getContentSize()
	local var_28_9 = var_0_0.newLabel({
		text = arg_28_1.name
	})

	var_28_9:setPosition(var_28_8.width / 2, 40)
	var_28_7:addChild(var_28_9)

	local var_28_10 = var_0_0.newLabel({
		text = string.lf("潜力+%s", tostring(arg_28_1.addPotential))
	})

	var_28_10:setPosition(var_28_8.width / 2, 15)
	var_28_7:addChild(var_28_10)
	var_28_7:setAnchorPoint(ccp(0.5, 0))
	var_28_7:setPosition(var_28_1.width / 2, 0)
	var_28_2:addChild(var_28_7)

	return var_28_2
end

function var_0_5.animate(arg_31_0, arg_31_1, ...)
	local var_31_0 = {
		...
	}
	local var_31_1
	local var_31_2

	if arg_31_1 == "swing" then
		local var_31_3 = var_31_0[1]
		local var_31_4 = var_31_0[2]
		local var_31_5 = var_31_0[3]
		local var_31_6 = var_31_0[4]
		local var_31_7 = var_31_0[5]
		local var_31_8 = arg_31_0:generator(var_31_5, var_31_6, 1, #var_31_4)
		local var_31_9 = CCArray:create()

		for iter_31_0, iter_31_1 in ipairs(var_31_8) do
			x, y = var_31_4[iter_31_1]:getPosition()
			step = CCMoveTo:create(0.2, ccp(x, y))

			var_31_9:addObject(step)
		end

		var_31_3:setZOrder(10)
		var_31_9:addObject(CCCallFunc:create(function()
			var_31_3:setZOrder(-1)

			if var_31_7 then
				var_31_7()
			end
		end))

		var_31_1 = var_31_3
		var_31_2 = CCEaseSineOut:create(CCSequence:create(var_31_9))
	elseif arg_31_1 == "move" then
		local var_31_10 = var_31_0[1]
		local var_31_11 = var_31_0[2]
		local var_31_12 = var_31_0[3]
		local var_31_13 = var_31_0[4]
		local var_31_14 = var_31_0[5]
		local var_31_15 = CCArray:create()

		for iter_31_2 = var_31_12, var_31_13, var_31_13 < var_31_12 and -1 or 1 do
			local var_31_16, var_31_17 = var_31_11[iter_31_2]:getPosition()
			local var_31_18 = CCMoveTo:create(0.2, ccp(var_31_16, var_31_17))

			var_31_15:addObject(var_31_18)
		end

		var_31_10:setZOrder(10)
		var_31_15:addObject(CCCallFunc:create(function()
			var_31_10:setZOrder(-1)

			if var_31_14 then
				var_31_14()
			end
		end))

		var_31_1 = var_31_10
		var_31_2 = CCSequence:create(var_31_15)
	elseif arg_31_1 == "blink" then
		local var_31_19 = var_31_0[1]
		local var_31_20 = CCArray:create()
		local var_31_21 = CCScaleTo:create(0.5, 1.08)
		local var_31_22 = CCScaleTo:create(0.5, 0.88)

		var_31_20:addObject(var_31_21)
		var_31_20:addObject(var_31_22)

		local var_31_23 = CCSequence:create(var_31_20)

		var_31_2, var_31_1 = CCRepeatForever:create(var_31_23), var_31_19
	end

	var_31_1:stopAllActions()
	var_31_1:runAction(var_31_2)
end

function var_0_5.generator(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	local function var_34_0(arg_35_0, arg_35_1)
		local var_35_0 = #arg_35_1
		local var_35_1 = string.lf("%s(%s): ", arg_35_0, tostring(var_35_0))

		for iter_35_0, iter_35_1 in ipairs(arg_35_1) do
			var_35_1 = var_35_1 .. iter_35_1

			if iter_35_0 ~= var_35_0 then
				var_35_1 = var_35_1 .. ", "
			end
		end

		print(var_35_1)
	end

	local function var_34_1(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
		if not arg_36_2 and not arg_36_3 then
			for iter_36_0, iter_36_1 in ipairs(arg_36_1) do
				table.insert(arg_36_0, iter_36_1)
			end
		else
			arg_36_2 = arg_36_2 or 1
			arg_36_3 = arg_36_3 or #arg_36_1

			for iter_36_2 = arg_36_2, arg_36_3 do
				table.insert(arg_36_0, arg_36_1[iter_36_2])
			end
		end
	end

	local function var_34_2(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
		if arg_37_2 == arg_37_3 then
			return arg_37_2
		end

		local var_37_0 = arg_37_3 < arg_37_2 and -1 or 1
		local var_37_1 = arg_37_3
		local var_37_2 = {}

		for iter_37_0 = arg_37_2 + var_37_0, arg_37_3, var_37_0 do
			table.insert(var_37_2, iter_37_0)
		end

		if arg_37_1 < #arg_37_0 + #var_37_2 then
			var_37_1 = arg_37_2
		else
			var_34_1(arg_37_0, var_37_2)
		end

		return var_37_1
	end

	local var_34_3 = arg_34_4 * 3 + 1
	local var_34_4 = {}
	local var_34_5 = {}
	local var_34_6 = 0
	local var_34_7 = 0
	local var_34_8 = var_34_3 - math.abs(arg_34_2 - arg_34_1)
	local var_34_9 = var_34_2(var_34_4, var_34_8, arg_34_1, arg_34_3)

	while arg_34_3 == var_34_9 do
		var_34_9 = var_34_2(var_34_4, var_34_8, arg_34_3, arg_34_4)

		if arg_34_4 ~= var_34_9 then
			break
		end

		var_34_9 = var_34_2(var_34_4, var_34_8, arg_34_4, arg_34_3)
	end

	local var_34_10 = var_34_2(var_34_4, var_34_8 + #var_34_4, var_34_9, arg_34_2)
	local var_34_11 = var_34_3 - math.abs(arg_34_2 - arg_34_1)
	local var_34_12 = var_34_2(var_34_5, var_34_11, arg_34_1, arg_34_4)

	while arg_34_4 == var_34_12 do
		var_34_12 = var_34_2(var_34_5, var_34_11, arg_34_4, arg_34_3)

		if arg_34_3 ~= var_34_12 then
			break
		end

		var_34_12 = var_34_2(var_34_5, var_34_11, arg_34_3, arg_34_4)
	end

	local var_34_13 = var_34_2(var_34_5, var_34_11 + #var_34_5, var_34_12, arg_34_2)

	if math.abs(var_34_3 - #var_34_5) < math.abs(var_34_3 - #var_34_4) then
		var_34_0("right", var_34_5)

		return var_34_5
	else
		var_34_0("left", var_34_4)

		return var_34_4
	end
end

return var_0_5
