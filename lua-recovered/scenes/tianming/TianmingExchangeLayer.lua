local var_0_0 = require("base.cache")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = require("scenes.toollayer.model")
local var_0_3 = require("scenes.ToolLayer")
local var_0_4 = var_0_2:extend({
	attach = function(arg_1_0, arg_1_1)
		arg_1_0.request = TianmingRequest:new(arg_1_1)

		arg_1_0.request:setResponseNormalHandler(function()
			local var_2_0, var_2_1 = arg_1_0.request:getResponseContent()

			if var_2_0 == TianmingRequest.eExchinfo then
				arg_1_0.dataset = var_2_1

				arg_1_0:trigger("sync", arg_1_0)
			elseif var_2_0 == TianmingRequest.eExchange then
				arg_1_0.request.isNoticeReward = false
			end
		end)
		arg_1_0.request:setResponseExceptionHandler(function()
			arg_1_0.dirty = true

			print("处理请求发生错误")
		end)
	end,
	sync = function(arg_4_0)
		if arg_4_0.dirty then
			arg_4_0:requestExchinfo()
		else
			arg_4_0:trigger("sync", arg_4_0)
		end
	end,
	requestExchinfo = function(arg_5_0)
		arg_5_0.request:requestExchinfo()
	end,
	requestExchange = function(arg_6_0, arg_6_1, arg_6_2)
		arg_6_0.request.isNoticeReward = true

		arg_6_0.request:requestExchange(arg_6_1, arg_6_2)
	end
})
local var_0_5 = class("TianmingExchangeLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create(ccc4(10, 10, 10, 160)))
end)

function var_0_5.ctor(arg_8_0, arg_8_1)
	arg_8_0:setNodeEventEnabled(true)
	arg_8_0:addTouchEventListener(function(arg_9_0, arg_9_1, arg_9_2)
		return true
	end, false, 1, true)
	arg_8_0:setTouchEnabled(true)
	arg_8_0:setScale(Adapter.MinScale)

	arg_8_0.model = var_0_0.get(arg_8_0)

	if not arg_8_0.model then
		arg_8_0.model = var_0_4:new()

		var_0_0.set(arg_8_0, arg_8_0.model)
	end

	arg_8_0.model:attach(arg_8_0)
	arg_8_0:onEnterAlias()
end

function var_0_5.onEnterAlias(arg_10_0)
	local var_10_0 = display.newSprite("ui/tianming/tianming_003.png")
	local var_10_1 = var_10_0:getContentSize()

	var_10_0:setPosition(display.cx, display.cy)
	arg_10_0:addChild(var_10_0)

	local var_10_2 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		clickAction = function()
			arg_10_0:removeFromParent()
		end
	})

	var_10_2:setPosition(var_10_1.width - 15, var_10_1.height - 15)
	var_10_0:addChild(var_10_2)

	local var_10_3 = ccc3(239, 203, 139)
	local var_10_4 = var_0_1.newLabel({
		text = string.lf("碎片可以兑换相应的天命"),
		color = var_10_3
	})

	var_10_4:align(display.LEFT_CENTER, 60, var_10_1.height - 30)
	var_10_0:addChild(var_10_4)

	local var_10_5 = var_0_1.newLabel({
		text = string.lf("天命碎片："),
		color = var_10_3
	})

	var_10_5:align(display.LEFT_CENTER, 600, var_10_1.height - 30)
	var_10_0:addChild(var_10_5)

	local var_10_6 = createPlayerAttrNode({
		ItemType.eTianMingFrag
	})

	var_10_6:setPosition(695, var_10_1.height - 52)
	var_10_0:addChild(var_10_6)
	var_10_6.nodeTable[ItemType.eTianMingFrag].bgSprite:setVisible(false)

	local var_10_7 = arg_10_0:createExchangeView()

	var_10_7:setPosition(20, 8)
	var_10_0:addChild(var_10_7)
	arg_10_0.model:on("sync", arg_10_0.onSync, arg_10_0)
	arg_10_0.model:sync()
end

function var_0_5.onExit(arg_12_0)
	arg_12_0:setNodeEventEnabled(false)
	arg_12_0.model:detach()
end

function var_0_5.onSync(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.dataset

	arg_13_0.tableview:reloadData(var_13_0)
end

function var_0_5.createExchangeView(arg_14_0)
	local var_14_0 = CCSize(830, 470)
	local var_14_1 = {
		reverse = true,
		direction = kCCScrollViewDirectionVertical,
		size = var_14_0,
		sizehandler = function(arg_15_0, arg_15_1)
			return CCSize(830, 150)
		end,
		cellhandler = handler(arg_14_0, arg_14_0.createExchangeItem)
	}
	local var_14_2 = var_0_1.newTableView(var_14_1)

	arg_14_0.tableview = var_14_2

	return var_14_2
end

function var_0_5.createExchangeItem(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = CCSize(830, 150)
	local var_16_1 = var_0_1.newNode()

	var_16_1:setContentSize(var_16_0)

	local var_16_2 = display.newSprite("ui/tianming/tianming_027.png")

	var_16_2:setPosition(var_16_0.width / 2, var_16_0.height / 2)
	var_16_1:addChild(var_16_2)

	local var_16_3 = display.newSprite("ui/tianming/tianming_026.png")

	var_16_3:setPosition(32, 58)
	var_16_2:addChild(var_16_3)

	local var_16_4 = ui.newControlButton({
		normalImage = "ui/tianming/tianming_017.png",
		clickAction = function()
			return
		end
	})

	var_16_4:setPosition(50, 50)
	var_16_3:addChild(var_16_4)

	local var_16_5 = arg_16_3.openLevel

	if var_16_5 > Player.level then
		local var_16_6 = var_0_1.newLabel({
			text = string.lf("%s级开放", var_16_5),
			color = ccc3(255, 0, 0)
		})

		var_16_6:setPosition(50, -10)
		var_16_3:addChild(var_16_6)
	end

	local var_16_7
	local var_16_8 = {}

	for iter_16_0 = 1, 7 do
		local var_16_9 = display.newSprite("ui/common/common_011.png")

		table.insert(var_16_8, var_16_9)
	end

	local var_16_10 = arg_16_3.exchanges

	for iter_16_1, iter_16_2 in ipairs(var_16_10) do
		local var_16_11 = iter_16_2.id
		local var_16_12 = iter_16_2.destinys[1]
		local var_16_13 = iter_16_2.fragment
		local var_16_14 = iter_16_2.needDestinys

		if iter_16_1 > 7 then
			break
		end

		local var_16_15 = figure.createHeader({
			isName = true,
			qualityColor = true,
			type = ItemType.eTianMing,
			itemId = var_16_12.destinyID,
			clickAction = function(arg_18_0, arg_18_1)
				local var_18_0, var_18_1 = var_0_1.getPosition(arg_18_1, var_16_1)
				local var_18_2 = Player.tianMingFrag >= iter_16_2.fragment and var_16_5 <= Player.level

				arg_16_0:showTips(arg_16_2, iter_16_2, var_18_0, var_18_1, var_18_2)
			end
		})

		var_16_15:setPosition(43, 43)
		var_16_8[iter_16_1]:addChild(var_16_15)

		local var_16_16 = createItemCountNode({
			type = ItemType.eTianMingFrag,
			value = var_16_13,
			color = var_16_13 > Player.tianMingFrag and display.COLOR_RED or display.COLOR_WHITE
		})

		var_16_16:setPosition(25, -35)
		var_16_8[iter_16_1]:addChild(var_16_16)

		iter_16_2.destinyID = var_16_12.destinyID
	end

	local var_16_17 = var_0_1.linearLayout({
		margin = 10,
		nodes = var_16_8
	})

	var_16_17:setPosition(var_16_0.width / 2 + 40, var_16_0.height / 2)
	var_16_1:addChild(var_16_17)

	return var_16_1
end

function var_0_5.showTips(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	local var_19_0 = var_0_3.createTips({
		show = var_0_3.eShowTianming,
		data = arg_19_2
	})

	print("enabled", arg_19_5)
	var_19_0:addAction({
		enabled = arg_19_5,
		text = string.lf("兑换"),
		callback = function()
			var_19_0:removeSelf()
			arg_19_0.model:requestExchange(arg_19_2.id)
		end
	})
	var_19_0:show({
		y = 0,
		x = arg_19_3 + 43,
		scroll = {
			table = arg_19_0.tableview,
			index = arg_19_1,
			size = CCSize(830, 150)
		}
	})
end

return var_0_5
