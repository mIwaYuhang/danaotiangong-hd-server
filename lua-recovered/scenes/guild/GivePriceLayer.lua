require("network.GuildRequest")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = require("base.cache")
local var_0_2 = class("GivePriceLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create(ccc4(10, 10, 10, 180)))
end)

function var_0_2.ctor(arg_2_0, arg_2_1)
	arg_2_0.goods = arg_2_1.goods
	arg_2_0.callback = arg_2_1.callback

	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.bgSprite = display.newScale9Sprite("ui/guild/guild_090.png")

	arg_2_0.bgSprite:setContentSize(CCSize(420, 250))
	arg_2_0.bgSprite:align(display.CENTER, display.cx, display.cy)
	arg_2_0.bgSprite:setScale(Adapter.MinScale)
	arg_2_0:addChild(arg_2_0.bgSprite)
	arg_2_0:initRequests()
	arg_2_0:showUI()
end

function var_0_2.initRequests(arg_4_0)
	local function var_4_0()
		local var_5_0 = var_0_1.get("GetPlayerGuildInfoRequest")

		var_5_0.PlayerUnionCoin = var_5_0.PlayerUnionCoin - arg_4_0.giveprice

		var_0_1.set("GetPlayerGuildInfoRequest", var_5_0)
		print("魔族宝物 竞价成功")
		arg_4_0.callback()
		arg_4_0.givePriceButton:setEnabled(true)
		arg_4_0:removeFromParentAndCleanup(true)
	end

	arg_4_0.buyPreciousRequest = BuyPreciousRequest:new()

	arg_4_0.buyPreciousRequest:setResponseNormalHandler(var_4_0)
	arg_4_0.buyPreciousRequest:setResponseExceptionHandler(function()
		print("魔族宝物 竞价失败")
	end)
end

function var_0_2.showUI(arg_7_0)
	local var_7_0 = {
		type = arg_7_0.goods.Reward[1].Type,
		itemId = arg_7_0.goods.Reward[1].ID,
		nameColor = ccc3(239, 232, 195),
		count = arg_7_0.goods.Reward[1].Count,
		clickAction = function()
			print("点击商城物品 ")
		end
	}
	local var_7_1 = figure.createHeader(var_7_0)

	var_7_1:setPosition(55, 185)
	arg_7_0.bgSprite:addChild(var_7_1)

	local var_7_2 = getItemName(arg_7_0.goods.Reward[1].Type, arg_7_0.goods.Reward[1].ID)
	local var_7_3 = var_0_1.get("GetPlayerGuildInfoRequest")
	local var_7_4 = arg_7_0.goods.ActionPlayer and string.lf("#FFFF00已经被 #FF0000%s #FFFF00竞拍", arg_7_0.goods.ActionPlayer) or string.lf("未被竞拍")
	local var_7_5 = {
		{
			y = 200,
			type = 1,
			x = 105,
			text = var_7_2,
			color = ccc3(0, 0, 0),
			size = CCSize(300, 30)
		},
		{
			y = 178,
			type = 2,
			x = 105,
			text = var_7_4,
			color = ccc3(255, 241, 139),
			size = CCSize(300, 30)
		},
		{
			y = 156,
			type = 3,
			x = 105,
			text = string.lf("拥有晶石: "),
			color = ccc3(255, 241, 139),
			size = CCSize(300, 30)
		}
	}
	local var_7_6 = createItemCountNode({
		color = ccc3(0, 255, 0),
		type = ItemType.eGuildCoin,
		value = var_7_3.PlayerUnionCoin or "0"
	})

	var_7_6:setPosition(207, 170)
	var_7_6:setAnchorPoint(ccp(0, 0))
	arg_7_0.bgSprite:addChild(var_7_6)

	for iter_7_0 = 1, #var_7_5 do
		local var_7_7 = var_7_5[iter_7_0]
		local var_7_8 = ui.newTTFLabel({
			text = var_7_7.text,
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(17),
			color = ccc3(245, 255, 10),
			align = ui.TEXT_ALIGN_LEFT,
			valign = ui.TEXT_VALIGN_CENTER,
			dimensions = var_7_7.size
		})

		var_7_8:setAnchorPoint(ccp(0, 0))
		var_7_8:setPosition(var_7_7.x, var_7_7.y)
		arg_7_0.bgSprite:addChild(var_7_8)
	end

	local function var_7_9()
		print("出价ID: " .. arg_7_0.goods.ID .. "    价格: " .. arg_7_0.giveprice)
		arg_7_0.buyPreciousRequest:requestBuyPrecious(arg_7_0.goods.ID, arg_7_0.giveprice)
		arg_7_0.givePriceButton:setEnabled(false)
	end

	arg_7_0.givePriceButton = ui.newControlButton({
		normalImage = "ui/guild/guild_091.png",
		highlightedImage = "ui/guild/guild_091.png",
		text = string.lf("确定出价"),
		clickAction = var_7_9,
		textColor = ColorTable.eTitleButton_Normal,
		position = ccp(120, 35)
	})

	arg_7_0.bgSprite:addChild(arg_7_0.givePriceButton)
	arg_7_0.givePriceButton:setEnabled(true)

	local var_7_10 = ui.newControlButton({
		normalImage = "ui/guild/guild_092.png",
		highlightedImage = "ui/guild/guild_092.png",
		text = string.lf("放弃出价"),
		clickAction = function()
			arg_7_0:removeFromParentAndCleanup(true)
		end,
		textColor = ColorTable.eTitleButton_Normal,
		position = ccp(300, 35)
	})

	arg_7_0.bgSprite:addChild(var_7_10)
	arg_7_0:addCtrlSlider(arg_7_0.bgSprite, CCPoint(210, 95), arg_7_0.goods.AuctionPrice + 1, var_7_3.PlayerUnionCoin)
end

function var_0_2.addCtrlSlider(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = arg_11_3

	arg_11_0.giveprice = var_11_0

	local var_11_1 = addLabelWithColorSize(arg_11_1, string.lf("消耗晶石: %s", var_11_0), ccc3(255, 215, 0), 18, CCPoint(0, 0), CCPoint(105, 134))
	local var_11_2 = arg_11_0:createSliderNode(arg_11_3, arg_11_4, function(arg_12_0, arg_12_1)
		var_11_0 = arg_12_1
		arg_11_0.giveprice = var_11_0

		var_11_1:setString(string.lf("消耗晶石: %s", arg_12_1))
	end)

	var_11_2:setAnchorPoint(CCPoint(0.5, 0.5))
	var_11_2:setPosition(arg_11_2)
	arg_11_1:addChild(var_11_2)

	return var_11_2
end

function var_0_2.createSliderNode(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = display.newSprite("ui/guild/guild_093.png")
	local var_13_1 = var_13_0:getContentSize()
	local var_13_2 = CCControlSlider:create("ui/guild/guild_093.png", "ui/guild/guild_094.png", "ui/guild/guild_089.png")

	var_13_2:setMinimumValue(arg_13_1)
	var_13_2:setMaximumValue(arg_13_2)

	local function var_13_3(arg_14_0)
		return math.floor(arg_14_0)
	end

	local function var_13_4(arg_15_0, arg_15_1)
		arg_15_1 = tolua.cast(arg_15_1, "CCControlSlider")

		local var_15_0 = var_13_3(arg_15_1:getValue())

		print(arg_15_1:getValue())

		return arg_13_3 and arg_13_3(arg_15_1, var_15_0)
	end

	var_13_2:addHandleOfControlEvent(var_13_4, CCControlEventValueChanged)
	var_13_2:setAnchorPoint(ccp(0.5, 0.5))
	var_13_2:setPosition(var_13_1.width / 2, var_13_1.height / 2)
	var_13_0:addChild(var_13_2)

	function var_13_0.getValue(arg_16_0)
		local var_16_0 = var_13_3(var_13_2:getValue())

		print(var_13_2:getValue())

		return var_16_0
	end

	function var_13_0.setValue(arg_17_0, arg_17_1)
		if arg_17_1 < 1 then
			arg_17_1 = 1
		elseif arg_17_1 > arg_13_2 then
			arg_17_1 = arg_13_2
		end
	end

	return var_13_0
end

return var_0_2
