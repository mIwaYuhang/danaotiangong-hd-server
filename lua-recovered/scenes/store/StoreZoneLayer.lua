require("base.functions")
require("network.StoreRequest")

local var_0_0 = require("base.cache")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = require("scenes.toollayer.tool")
local var_0_3 = require("scenes.toollayer.timer")
local var_0_4 = require("scenes.ToolLayer")
local var_0_5 = require("scenes.toollayer.model"):extend({
	ctor = function(arg_1_0)
		arg_1_0:set("count-down", 0)
		arg_1_0:set("total-count", 0)
		arg_1_0:set("have-count", 0)
		arg_1_0:set("next-total", 0)
		arg_1_0:set("next-level", 0)
	end,
	attach = function(arg_2_0, arg_2_1)
		arg_2_0.timer = var_0_3:new()
		arg_2_0.suitListRequest = SuitListRequest:new(arg_2_1)

		arg_2_0.suitListRequest:setResponseNormalHandler(function()
			local var_3_0 = arg_2_0.suitListRequest:getResponseContent()

			arg_2_0:loadData(var_3_0)
			arg_2_0:trigger("sync", arg_2_0)
		end)
		arg_2_0.suitListRequest:setResponseExceptionHandler(function()
			arg_2_0.dirty = true

			print("请求发生错误")
		end)

		arg_2_0.buyPropRequest = BuyPropRequest:new(arg_2_1)

		arg_2_0.buyPropRequest:setResponseNormalHandler(function()
			local var_5_0 = arg_2_0.buyPropRequest:getResponseContent()

			arg_2_0:set("have-count", arg_2_0:get("have-count") - 1)
			arg_2_0:trigger("buy")
		end)
		arg_2_0.buyPropRequest:setResponseExceptionHandler(function()
			arg_2_0.dirty = true

			print("请求发生错误")
		end)
	end,
	loadData = function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_1.NTC
		local var_7_1 = arg_7_1.NVL

		arg_7_0:set("next-total", var_7_0)
		arg_7_0:set("next-level", var_7_1)

		local var_7_2 = arg_7_1.CountDown

		arg_7_0:set("count-down", var_7_2)

		local var_7_3 = arg_7_1.TotalCount
		local var_7_4 = arg_7_1.HaveCount

		arg_7_0:set("total-count", var_7_3)
		arg_7_0:set("have-count", var_7_4)

		local var_7_5 = arg_7_1.SuitProp

		for iter_7_0, iter_7_1 in ipairs(var_7_5) do
			iter_7_1.id = iter_7_1.PropsID
			iter_7_1.type = ItemType.eProp
			iter_7_1.name = getItemName(iter_7_1.type, iter_7_1.id)
			iter_7_1.priceValue = iter_7_1.Price
			iter_7_1.priceType = iter_7_1.CurrencyType
		end

		arg_7_0.dataset = var_7_5

		if var_7_2 > 0 then
			arg_7_0.timer:update(function(arg_8_0)
				local var_8_0 = arg_7_0:get("count-down") - arg_8_0

				arg_7_0:set("count-down", var_8_0)

				return var_8_0 < 0.5
			end)
			arg_7_0.timer:start()
		end
	end,
	sync = function(arg_9_0)
		if arg_9_0.dirty then
			arg_9_0.suitListRequest:request()
		else
			arg_9_0:trigger("sync", arg_9_0)
		end
	end,
	requestBuy = function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0:get("count-down")
		local var_10_1 = arg_10_0:get("have-count")

		if var_10_0 < 1 then
			arg_10_0:trigger("error", "time")
		elseif var_10_1 < 1 then
			if arg_10_0:get("total-count") > 0 then
				arg_10_0:trigger("error", "count")
			else
				arg_10_0:trigger("error", "vip")
			end
		else
			if type(arg_10_1) == "table" then
				arg_10_1 = arg_10_1.id
			end

			arg_10_0.buyPropRequest:request(arg_10_1, 1)
		end
	end
})
local var_0_6 = class("StoreZoneLayer", function()
	return display.newScale9Sprite("ui/store/store_041.jpg")
end)

function var_0_6.ctor(arg_12_0, arg_12_1)
	local var_12_0 = CCSize(940, 500)

	arg_12_0:setPreferredSize(var_12_0)
	arg_12_0:setAnchorPoint(CCPoint(0, 0))
	arg_12_0:setNodeEventEnabled(true)

	arg_12_0.parent = arg_12_1.parent
	arg_12_0.container = arg_12_0
	arg_12_0.size = var_12_0
	arg_12_0.model = var_0_0.get(arg_12_0)

	if not arg_12_0.model then
		arg_12_0.model = var_0_5:new()

		var_0_0.set(arg_12_0, arg_12_0.model)
	end

	arg_12_0.model:attach(arg_12_0.parent)
	arg_12_0:onEnterAlias()
end

function var_0_6.onEnterAlias(arg_13_0)
	local var_13_0 = arg_13_0.size
	local var_13_1 = arg_13_0.container
	local var_13_2 = arg_13_0:createPropView()

	var_13_2:setPosition(50, 15)
	var_13_1:addChild(var_13_2)

	local var_13_3 = display.newSprite("uilocal/store/store_text_066.png")

	var_13_3:setPosition(var_13_0.width / 2, var_13_0.height - 20)
	var_13_1:addChild(var_13_3)

	local var_13_4 = var_13_3:getContentSize()
	local var_13_5 = var_0_1.newLabel({
		text = "00:00:00"
	})

	var_13_5:align(display.LEFT_CENTER, 160, var_13_4.height / 2)
	var_13_3:addChild(var_13_5)
	arg_13_0.model:bind("count-down", function(arg_14_0)
		var_13_5:setString(formatTime(arg_14_0))
	end)

	local var_13_6 = var_0_1.newLabel({
		text = "购买次数：0/0，达到 VIP0 可购买 0 次",
		color = ccc3(255, 0, 255)
	})

	var_13_6:align(display.RIGHT_CENTER, 630, var_13_4.height / 2)
	var_13_3:addChild(var_13_6)
	arg_13_0.model:bind("have-count|total-count|next-level", function(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = arg_13_0.model:get("next-total")
		local var_15_1

		if arg_15_2 and arg_15_2 > 0 then
			var_15_1 = string.lf("购买次数：%d/%d，VIP%d 可购买 %d 次", arg_15_0, arg_15_1, arg_15_2, var_15_0)
		else
			var_15_1 = string.lf("购买次数：%d/%d，已达到最高级VIP", arg_15_0, arg_15_1)
		end

		var_13_6:setString(var_15_1)
	end)
	arg_13_0.model:on("error", arg_13_0.onError, arg_13_0)
	arg_13_0.model:on("buy", arg_13_0.onBuy, arg_13_0)
	arg_13_0.model:on("sync", arg_13_0.onSync, arg_13_0)
	arg_13_0.model:sync()
end

function var_0_6.onExit(arg_16_0)
	arg_16_0:setNodeEventEnabled(false)
	arg_16_0.model:detach()
end

function var_0_6.onSync(arg_17_0, arg_17_1)
	local var_17_0 = {}
	local var_17_1 = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1.dataset) do
		table.insert(var_17_0, iter_17_1)

		if #var_17_0 == 2 then
			table.insert(var_17_1, var_17_0)

			var_17_0 = {}
		end
	end

	if #var_17_0 > 0 then
		table.insert(var_17_1, var_17_0)
	end

	arg_17_0.tableview:reloadData(var_17_1)
end

function var_0_6.onBuy(arg_18_0)
	arg_18_0.buyNode:buyAction()
end

function var_0_6.onError(arg_19_0, arg_19_1)
	local var_19_0 = {
		animate = "slide"
	}

	if arg_19_1 == "time" then
		var_19_0.text = string.lf("活动已结束，现在不能购买专属礼包！")
	elseif arg_19_1 == "count" or arg_19_1 == "vip" then
		if arg_19_1 == "vip" then
			local var_19_1 = arg_19_0.model:get("next-level")

			var_19_0.text = string.lf("上仙，需要VIP%d才能购买专属礼包哦！马上去充值？", var_19_1)
		elseif arg_19_1 == "count" then
			var_19_0.text = string.lf("上仙，提升VIP等级可以增加购买次数哦！马上去充值？")
		end

		var_19_0.title1 = string.lf("确定")

		function var_19_0.action1()
			game.enterStoreRechargeScene({
				backcall = function()
					game.enterStoreScene({
						defaultPage = StoreType.eStoreSuit
					})
				end
			})
		end

		var_19_0.title2 = string.lf("取消")
	end

	if var_19_0.text then
		ui.showMessageBox(var_19_0)
	end
end

function var_0_6.createPropView(arg_22_0)
	local var_22_0 = CCSize(850, 450)
	local var_22_1 = {
		direction = kCCScrollViewDirectionVertical,
		size = var_22_0,
		sizehandler = function(arg_23_0, arg_23_1)
			return CCSize(850, 156)
		end,
		cellhandler = handler(arg_22_0, arg_22_0.createPropList)
	}
	local var_22_2 = var_0_1.newTableView(var_22_1)

	arg_22_0.tableview = var_22_2

	return var_22_2
end

function var_0_6.createPropList(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = CCSize(850, 156)
	local var_24_1 = var_0_1.newNode()

	var_24_1:setContentSize(var_24_0)

	local var_24_2 = display.newScale9Sprite("ui/store/store_023.png")

	var_24_2:setContentSize(CCSize(var_24_0.width, 48))
	var_24_2:setPosition(var_24_0.width / 2, 13)
	var_24_1:addChild(var_24_2)

	local var_24_3
	local var_24_4 = 10
	local var_24_5 = 18

	for iter_24_0, iter_24_1 in ipairs(arg_24_3) do
		local var_24_6 = arg_24_0:createPropItem(iter_24_1)

		var_24_6:setPosition(var_24_4, var_24_5)
		var_24_1:addChild(var_24_6)

		var_24_4 = var_24_4 + 420
	end

	return var_24_1
end

function var_0_6.createPropItem(arg_25_0, arg_25_1)
	local var_25_0 = CCSize(420, 145)
	local var_25_1 = var_0_1.newNode()

	var_25_1:setContentSize(var_25_0)

	local var_25_2 = figure.createHeader({
		isName = false,
		inTeam = false,
		isStoreBkground = true,
		itemId = arg_25_1.id,
		type = arg_25_1.type,
		count = arg_25_1.count,
		clickAction = function()
			var_0_4.tipshandler({
				Type = arg_25_1.type,
				ID = arg_25_1.id,
				Count = arg_25_1.count
			})
		end
	})

	var_25_2:setPosition(75, var_25_0.height / 2)
	var_25_1:addChild(var_25_2)

	local var_25_3 = Player:getItemCount(arg_25_1.type, arg_25_1.id)
	local var_25_4 = var_0_1.newLabel({
		text = string.lf("(已拥有: %s)", var_25_3),
		color = ccc3(120, 230, 90)
	})

	var_25_4:setAnchorPoint(ccp(0, 0.5))
	var_25_4:setPosition(155, 40)
	var_25_1:addChild(var_25_4)

	local var_25_5 = getItemQuality(arg_25_1.type, arg_25_1.id)
	local var_25_6 = getQualityColor(var_25_5)
	local var_25_7 = var_0_1.newLabel({
		size = 24,
		outline = true,
		text = arg_25_1.name,
		color = var_25_6
	})

	var_25_7:setAnchorPoint(ccp(0, 0.5))
	var_25_7:setPosition(155, 110)
	var_25_1:addChild(var_25_7)

	local var_25_8 = getItemName(arg_25_1.priceType)
	local var_25_9 = var_0_1.newLabel({
		text = string.lf("消耗%s", var_25_8)
	})

	var_25_9:setAnchorPoint(ccp(0, 0.5))
	var_25_9:setPosition(155, 75)
	var_25_1:addChild(var_25_9)

	local var_25_10 = var_25_9:getContentSize()
	local var_25_11 = display.newSprite(getItemIconPath(arg_25_1.priceType))

	var_25_11:setPosition(var_25_10.width + 168, 75)
	var_25_1:addChild(var_25_11)

	local var_25_12 = var_0_1.newLabel({
		text = ": " .. arg_25_1.priceValue
	})

	var_25_12:setAnchorPoint(ccp(0, 0.5))
	var_25_12:setPosition(263, 75)
	var_25_1:addChild(var_25_12)

	local var_25_13 = ui.newControlButton({
		normalImage = "ui/store/store_022.png",
		text = string.lf("购买"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_27_0, arg_27_1)
			if isMoneyEnough(arg_25_1.priceType, arg_25_1.priceValue) then
				arg_25_0.model:requestBuy(arg_25_1)

				arg_25_0.buyNode = var_25_1
			end
		end
	})

	var_25_13:setTitleColorForState(ccc3(120, 120, 120), CCControlStateDisabled)
	var_25_13:setPosition(365, var_25_0.height / 2)
	var_25_1:addChild(var_25_13)

	function var_25_1.buyAction(arg_28_0)
		local var_28_0 = Player:getItemCount(arg_25_1.type, arg_25_1.id)

		var_25_4:setString(string.lf("(已拥有: %s)", var_28_0))
		showFlashImage({
			image = "uilocal/enhance/enhance_txt_007.png",
			scale = 0.8,
			parent = var_25_1,
			position = ccp(160, 20)
		})
	end

	return var_25_1
end

return var_0_6
