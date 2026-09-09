require("base.functions")
require("data.player")
require("network.ZhaoCaiFuRequest")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = require("base.cache")
local var_0_2 = require("scenes.toollayer.timer")
local var_0_3 = require("scenes.toollayer.model"):extend({
	ctor = function(arg_1_0)
		arg_1_0:set("LuckyLv", 0)
		arg_1_0:set("LuckyAddtion", 0)
		arg_1_0:set("LuckyRemain", 0)
		arg_1_0:set("Cost", 0)
		arg_1_0:set("Gold", 0)
		arg_1_0:set("UsedTime", 0)
		arg_1_0:set("TotalTime", 0)
	end,
	attach = function(arg_2_0, arg_2_1)
		arg_2_0.timer = var_0_2:new()
		arg_2_0.request = ZhaoCaiFuRequest:new(arg_2_1)

		arg_2_0.request:setResponseNormalHandler(function()
			local var_3_0, var_3_1 = arg_2_0.request:getResponseContent()

			if var_3_0 == ZhaoCaiFuRequest.eGet then
				-- block empty
			elseif var_3_0 == ZhaoCaiFuRequest.eUse then
				var_3_1 = var_3_1.Operator
			end

			if var_3_1.LuckyRemain == 0 then
				arg_2_0.dirty = false
			else
				arg_2_0.dirty = true
			end

			arg_2_0:loadData(var_3_1)
			arg_2_0:trigger("sync", arg_2_0)
		end)
		arg_2_0.request:setResponseExceptionHandler(function()
			print("处理请求发生错误")
		end)
	end,
	loadData = function(arg_5_0, arg_5_1)
		for iter_5_0, iter_5_1 in pairs(arg_5_1) do
			arg_5_0:set(iter_5_0, iter_5_1)
		end

		if arg_5_1.LuckyRemain == 0 then
			arg_5_0.dirty = false
		elseif not arg_5_0.timer:running() then
			arg_5_0.dirty = true

			arg_5_0.timer:update(function(arg_6_0)
				local var_6_0 = arg_5_0:get("LuckyRemain") - arg_6_0
				local var_6_1 = false

				if var_6_0 < 0.5 then
					var_6_0 = 0

					arg_5_0:set("LuckyLv", 0)
					arg_5_0:set("LuckyAddtion", 0)
					arg_5_0.timer:stop()

					arg_5_0.dirty = false
					var_6_1 = true
				end

				arg_5_0:set("LuckyRemain", var_6_0)

				return var_6_1
			end)
			arg_5_0.timer:start()
		end
	end,
	getLuckyCount = function(arg_7_0)
		local var_7_0 = arg_7_0:get("UsedTime")

		return arg_7_0:get("TotalTime") - var_7_0
	end,
	minimumRevenue = function(arg_8_0, arg_8_1)
		return 25000 + arg_8_1 * 200
	end,
	sync = function(arg_9_0)
		if arg_9_0.dirty then
			arg_9_0.request:requestGetLuckySymbol()
		else
			arg_9_0:trigger("sync", arg_9_0)
		end
	end,
	useLuckySymbol = function(arg_10_0)
		arg_10_0.request:requestUseLuckySymbol()
	end
})
local var_0_4 = class("ZhaoCaiFu", function()
	return display.newScene("ZhaoCaiFu")
end)

function var_0_4.ctor(arg_12_0)
	arg_12_0.container = nil
	arg_12_0.model = var_0_1.get(arg_12_0)

	if not arg_12_0.model then
		arg_12_0.model = var_0_3:new()

		var_0_1.set(arg_12_0, arg_12_0.model)
	end

	arg_12_0.model:attach(arg_12_0)
	arg_12_0:onEnterAlias()
end

function var_0_4.onExit(arg_13_0)
	arg_13_0.model:detach()
end

function var_0_4.onEnterAlias(arg_14_0)
	local var_14_0 = Adapter.AutoScaleY
	local var_14_1 = display.newSprite("ui/zhaocaifu/zhaocaifu_005.jpg")
	local var_14_2 = var_14_1:getContentSize()

	var_14_1:setScale(var_14_0)
	var_14_1:setPosition(display.cx, display.cy)
	arg_14_0:addChild(var_14_1)

	local var_14_3 = math.min(var_14_2.width * var_14_0, display.width) / var_14_0
	local var_14_4 = math.min(var_14_2.height * var_14_0, display.height) / var_14_0
	local var_14_5 = CCSize(var_14_3, var_14_4)
	local var_14_6 = CCNode:create()

	var_14_6:setContentSize(var_14_5)
	var_14_6:setPosition((var_14_2.width - var_14_5.width) / 2, (var_14_2.height - var_14_5.height) / 2)
	var_14_1:addChild(var_14_6)

	arg_14_0.container = var_14_6

	if var_14_4 < display.height then
		local var_14_7 = CCSize(display.width, (display.height - var_14_4 * var_14_0) / 2)
		local var_14_8 = CCLayerColor:create(ccc4(0, 0, 0, 255))

		var_14_8:setContentSize(var_14_7)
		arg_14_0:addChild(var_14_8, 77)
	end

	local var_14_9 = display.newSprite("ui/zhaocaifu/zhaocaifu_004.png")

	var_14_9:setPosition(var_14_5.width / 2, var_14_5.height / 2 + 10)
	var_14_6:addChild(var_14_9)

	local var_14_10 = createPlayerAttrNode({
		ItemType.eGold,
		ItemType.eCoin
	})

	var_14_10:setPosition(15, var_14_5.height - 50)
	var_14_6:addChild(var_14_10)

	local var_14_11 = arg_14_0:createLuckyCount()

	var_14_11:setAnchorPoint(ccp(0, 0.5))
	var_14_11:setPosition(var_14_5.width / 2 + 150, 110)
	var_14_6:addChild(var_14_11)

	local var_14_12 = arg_14_0:createLuckySymbol()

	var_14_12:setAnchorPoint(ccp(0.5, 0))
	var_14_12:setPosition(var_14_5.width / 2, 130)
	var_14_6:addChild(var_14_12)

	local var_14_13 = arg_14_0:createLuckyTime()

	var_14_13:setAnchorPoint(ccp(0.5, 0))
	var_14_13:setPosition(var_14_5.width / 2, 270)
	var_14_13:setVisible(false)
	var_14_6:addChild(var_14_13)

	local var_14_14 = arg_14_0:createLuckyRevenue()

	var_14_14:setAnchorPoint(ccp(0.5, 0.5))
	var_14_14:setPosition(var_14_5.width / 2, var_14_5.height / 2 + 85)
	var_14_6:addChild(var_14_14)

	local var_14_15 = ui.newControlButton({
		normalImage = "ui/common/common_061.png",
		clickAction = function(arg_15_0, arg_15_1)
			game.enterHomeScene()
		end
	})

	var_14_15:setPosition(var_14_5.width - 70, var_14_5.height - 40)
	var_14_6:addChild(var_14_15)

	local var_14_16 = ui.newControlButton({
		normalImage = "ui/common/common_105.png",
		highlightedImage = "ui/common/common_105.png",
		disabledImage = "ui/common/common_106.png",
		clickAction = function(arg_16_0, arg_16_1)
			if arg_14_0.model:getLuckyCount() > 0 then
				arg_14_0.model:useLuckySymbol()
			else
				ui.showMessageBox({
					animate = "slide",
					text = string.lf("上仙，提升VIP等级可以增加招财次数哦！")
				})
			end
		end
	})
	local var_14_17 = var_14_16:getContentSize()
	local var_14_18 = display.newSprite("uilocal/common/common_text_007.png")

	var_14_18:setPosition(var_14_17.width / 2, var_14_17.height / 2)
	var_14_16:addChild(var_14_18)
	var_14_16:setTitleColorForState(ccc3(30, 30, 30), CCControlStateDisabled)
	var_14_16:setPosition(var_14_5.width / 2, 110)
	var_14_6:addChild(var_14_16)

	local var_14_19 = var_0_0.newLabel({
		text = string.lf("花费："),
		color = ccc3(40, 40, 40)
	})

	var_14_19:setPosition(var_14_5.width / 2 - 20, 55)
	var_14_6:addChild(var_14_19)

	local var_14_20 = createItemCountNode({
		value = 0,
		type = ItemType.eGold
	})

	var_14_20:setAnchorPoint(ccp(0.5, 0.5))
	var_14_20:setPosition(var_14_5.width / 2 + 20, 55)
	var_14_6:addChild(var_14_20)
	arg_14_0.model:bind("Cost", function(arg_17_0)
		var_14_20:setValue(arg_17_0)
	end)

	local var_14_21 = Player.level
	local var_14_22 = arg_14_0.model:minimumRevenue(var_14_21)
	local var_14_23 = var_0_0.newLabel({
		text = string.lf("%s级招财每次保底可得", var_14_21),
		color = ccc3(40, 40, 40)
	})

	var_14_23:align(display.RIGHT_CENTER, var_14_5.width / 2 + 60, 25)
	var_14_6:addChild(var_14_23)

	local var_14_24 = createItemCountNode({
		type = ItemType.eCoin,
		value = var_14_22,
		color = ccc3(40, 40, 40)
	})

	var_14_24:setPosition(var_14_5.width / 2 + 80, 25)
	var_14_6:addChild(var_14_24)

	local var_14_25 = arg_14_0:createCloudView()

	var_14_25:setPosition(0, -70)
	var_14_6:addChild(var_14_25, -1)
	arg_14_0.model:on("sync", arg_14_0.reloadData, arg_14_0)
	arg_14_0.model:sync()
end

function var_0_4.reloadData(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1:getLuckyCount()

	Player:setZhaoCaiFuCount(var_18_0)
end

function var_0_4.createLuckyTime(arg_19_0)
	local var_19_0 = CCSize(300, 40)
	local var_19_1 = display.newScale9Sprite("ui/common/bg_headtex_bg.png")

	var_19_1:setPreferredSize(var_19_0)

	local var_19_2 = var_0_0.newLabel({
		size = 24,
		text = string.lf("00:00:00 后加成失效"),
		color = ccc3(255, 255, 255)
	})

	var_19_2:setPosition(var_19_0.width / 2, var_19_0.height / 2)
	var_19_1:addChild(var_19_2)
	arg_19_0.model:bind("LuckyRemain", function(arg_20_0)
		var_19_2:setString(string.lf("%s 后加成失效", formatTime(arg_20_0)))
		var_19_1:setVisible(arg_20_0 > 0)
	end)

	return var_19_1
end

function var_0_4.createLuckyRevenue(arg_21_0)
	local var_21_0 = CCSize(380, 60)
	local var_21_1 = CCNode:create()

	var_21_1:setContentSize(var_21_0)

	local var_21_2 = CCSkeletonAnimation:createWithFile("ui/zhaocaifu/ui_zhaocaifu.json", "ui/zhaocaifu/ui_zhaocaifu.atlas", 1)

	var_21_2:setPosition(var_21_0.width / 2, var_21_0.height / 2)
	var_21_2:setScale(0.6)
	var_21_2:setVisible(false)
	var_21_1:addChild(var_21_2)
	arg_21_0.model:bind("LuckyAddtion", function(arg_22_0)
		local var_22_0 = ({
			"ui_zhaocaifu_10",
			"ui_zhaocaifu_20",
			nil,
			"ui_zhaocaifu_40",
			nil,
			"ui_zhaocaifu_60",
			nil,
			"ui_zhaocaifu_80"
		})[arg_22_0 * 10]

		if var_22_0 then
			local var_22_1 = CCCallFunc:create(function()
				return
			end)

			var_21_2:setVisible(true)
			var_21_2:setAnimation(var_22_0, false, 0)
			var_21_2:addAnimationAction(var_22_0, 1, var_22_1, AAT_Percent)
		else
			var_21_2:setVisible(false)
		end
	end)

	return var_21_1
end

function var_0_4.createLuckyCount(arg_24_0)
	local var_24_0 = CCSize(160, 40)
	local var_24_1 = display.newScale9Sprite("ui/common/bg_headtex_bg.png")

	var_24_1:setPreferredSize(var_24_0)

	local var_24_2 = var_0_0.newLabel({
		size = 22,
		text = string.lf("剩余次数: 0"),
		color = ccc3(250, 250, 250)
	})

	var_24_2:setPosition(var_24_0.width / 2, var_24_0.height / 2)
	var_24_1:addChild(var_24_2)
	arg_24_0.model:bind("UsedTime|TotalTime", function(arg_25_0, arg_25_1)
		var_24_2:setString(string.lf("剩余次数: %s", arg_25_1 - arg_25_0))
	end)

	return var_24_1
end

function var_0_4.createLuckySymbol(arg_26_0)
	local var_26_0 = CCSize(114, 120)
	local var_26_1 = CCSize(720, 180)
	local var_26_2 = CCNode:create()

	var_26_2:setContentSize(var_26_1)

	local var_26_3 = 0
	local var_26_4 = 0
	local var_26_5 = var_26_1.width / 2
	local var_26_6 = var_26_1.height + 40
	local var_26_7 = {
		-360,
		-180,
		0,
		180,
		360
	}
	local var_26_8 = {}

	for iter_26_0, iter_26_1 in ipairs(var_26_7) do
		local var_26_9 = iter_26_1
		local var_26_10 = math.sqrt((1 - var_26_9 * var_26_9 / 230400) * 25600)

		table.insert(var_26_8, ccp(var_26_5 + var_26_9, var_26_6 - var_26_10))
	end

	local var_26_11 = {}

	for iter_26_2 = 1, 5 do
		local var_26_12 = ui.newControlButton({
			normalImage = "ui/zhaocaifu/zhaocaifu_003.png",
			highlightedImage = "ui/zhaocaifu/zhaocaifu_002.png"
		})

		var_26_12:setEnabled(false)
		var_26_12:setPosition(var_26_8[iter_26_2])
		var_26_2:addChild(var_26_12)
		table.insert(var_26_11, var_26_12)
	end

	arg_26_0.model:bind("LuckyLv", function(arg_27_0, arg_27_1)
		local var_27_0 = 0
		local var_27_1 = 0

		if not arg_27_1 and arg_27_0 < 1 then
			return
		elseif arg_27_1 and arg_27_1 < arg_27_0 or arg_27_0 > 0 then
			var_27_1 = arg_27_0
		else
			var_27_0 = arg_27_1
		end

		arg_26_0:animate("level", var_26_11, var_27_0, var_27_1)
	end)

	return var_26_2
end

function var_0_4.animate(arg_28_0, arg_28_1, ...)
	local var_28_0 = {
		...
	}

	if arg_28_1 == "level" then
		local function var_28_1(arg_29_0, arg_29_1, arg_29_2)
			local var_29_0
			local var_29_1 = arg_29_1 < arg_29_2

			if arg_29_1 < arg_29_2 then
				arg_29_1 = arg_29_1 + 1
				var_29_0 = arg_29_0[arg_29_1]
			else
				var_29_0 = arg_29_0[arg_29_1]
				arg_29_1 = arg_29_1 - 1
			end

			var_29_0:setHighlighted(var_29_1)
			var_29_0:setScale(0.6)

			local var_29_2 = CCArray:create()
			local var_29_3 = CCScaleTo:create(0.2, 1.08)

			var_29_2:addObject(var_29_3)

			if arg_29_1 ~= arg_29_2 then
				local var_29_4 = CCCallFunc:create(function()
					var_28_1(arg_29_0, arg_29_1, arg_29_2)
				end)

				var_29_2:addObject(var_29_4)
			end

			local var_29_5 = CCScaleTo:create(0.2, 1)

			var_29_2:addObject(var_29_5)
			var_29_0:stopAllActions()
			var_29_0:runAction(CCSequence:create(var_29_2))
		end

		local var_28_2 = var_28_0[1]
		local var_28_3 = var_28_0[2]
		local var_28_4 = var_28_0[3]

		var_28_1(var_28_2, var_28_3, var_28_4)
	end
end

function var_0_4.createCloudView(arg_31_0)
	local var_31_0 = CCSize(display.width, 170)
	local var_31_1 = CCNode:create()
	local var_31_2 = {
		"ui/zhaocaifu/zhaocaifu_007.png",
		"ui/zhaocaifu/zhaocaifu_008.png",
		"ui/zhaocaifu/zhaocaifu_009.png",
		"ui/zhaocaifu/zhaocaifu_010.png"
	}
	local var_31_3
	local var_31_4
	local var_31_5 = {}

	for iter_31_0 = 1, 28 do
		local var_31_6 = display.newSprite(var_31_2[math.random(1, 4)])

		var_31_6.xdelta = math.random(10, 20) / 100

		var_31_6:setOpacity(math.random(100, 240))
		table.insert(var_31_5, var_31_6)
	end

	var_31_1:setContentSize(var_31_0)

	local var_31_7 = 0
	local var_31_8 = 0
	local var_31_9 = var_31_0.width + 170
	local var_31_10 = var_31_0.height / 2
	local var_31_11 = #var_31_5 + 1

	for iter_31_1, iter_31_2 in ipairs(var_31_5) do
		local var_31_12 = var_31_9 / var_31_11 * iter_31_1 + math.random(-30, 30)
		local var_31_13 = var_31_10 + math.random(-20, 20)

		iter_31_2:setPosition(var_31_12, var_31_13)
		var_31_1:addChild(iter_31_2)

		local var_31_14 = math.random(10, 30)
		local var_31_15 = CCRotateBy:create(var_31_14, 180)
		local var_31_16 = CCRepeatForever:create(var_31_15)

		iter_31_2:runAction(var_31_16)
	end

	local function var_31_17(arg_32_0)
		local var_32_0
		local var_32_1
		local var_32_2 = 0
		local var_32_3 = 0

		for iter_32_0, iter_32_1 in ipairs(var_31_5) do
			local var_32_4, var_32_5 = iter_32_1:getPosition()
			local var_32_6 = iter_32_1:getContentSize()

			if var_32_4 + var_32_6.width / 2 > 0 then
				var_32_4 = var_32_4 - iter_32_1.xdelta
			else
				var_32_4 = var_32_6.width / 2 + var_31_0.width
				iter_32_1.xdelta = math.random(10, 20) / 100

				iter_32_1:setOpacity(math.random(100, 240))
			end

			iter_32_1:setPosition(var_32_4, var_32_5)
		end
	end

	var_31_1:scheduleUpdate(var_31_17)

	return var_31_1
end

return var_0_4
