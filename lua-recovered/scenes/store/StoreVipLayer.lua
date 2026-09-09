require("base.functions")
require("network.StoreRequest")

local var_0_0 = require("base.cache")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = require("scenes.toollayer.tool")
local var_0_3 = require("scenes.ToolLayer")
local var_0_4 = {
	28,
	48,
	248,
	480,
	880,
	1980,
	4990,
	9990,
	16880,
	18880,
	23880,
	63880,
	88888
}
local var_0_5 = {
	"uilocal/store/store_text_043.png",
	"uilocal/store/store_text_044.png",
	"uilocal/store/store_text_045.png",
	"uilocal/store/store_text_046.png",
	"uilocal/store/store_text_047.png",
	"uilocal/store/store_text_048.png",
	"uilocal/store/store_text_049.png",
	"uilocal/store/store_text_050.png",
	"uilocal/store/store_text_051.png",
	"uilocal/store/store_text_052.png",
	"uilocal/store/store_text_053.png",
	"uilocal/store/store_text_054.png",
	"uilocal/store/store_text_071.png"
}
local var_0_6 = {
	nil,
	nil,
	nil,
	nil,
	"uilocal/store/icon_sale_5.png",
	"uilocal/store/icon_sale_6.png",
	"uilocal/store/icon_sale_7.png",
	"uilocal/store/icon_sale_8.png",
	"uilocal/store/icon_sale_9.png"
}
local var_0_7 = class("StoreVipLayer", function()
	return display.newScale9Sprite("ui/store/store_012.jpg")
end)

function var_0_7.ctor(arg_2_0, arg_2_1)
	arg_2_0.parent = arg_2_1.parent
	arg_2_0.id = arg_2_1.id

	arg_2_0:initRequests()
	arg_2_0:initLayout()
end

function var_0_7.initLayout(arg_3_0)
	local var_3_0 = CCSize(940, 500)

	arg_3_0:setPreferredSize(var_3_0)
	arg_3_0:setAnchorPoint(CCPoint(0, 0))
	arg_3_0:setPosition(CCPoint(0, 0))

	local var_3_1 = createTableView({
		reverse = false,
		size = CCSize(931, 500),
		direction = kCCScrollViewDirectionHorizontal,
		sizehandler = function(arg_4_0, arg_4_1)
			return CCSize(232, 472)
		end,
		cellhandler = handler(arg_3_0, arg_3_0.createPropCard)
	})

	var_3_1:setAnchorPoint(CCPoint(0, 0))
	var_3_1:setPosition(5, 15)
	arg_3_0:addChild(var_3_1)

	arg_3_0.tableview = var_3_1

	local var_3_2 = var_0_0.get("prop-list")

	if not var_3_2 then
		arg_3_0.propListRequest:request()
	else
		arg_3_0:reloadData(var_3_2)
	end
end

function var_0_7.reloadData(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.id
	local var_5_1 = arg_5_0.tableview
	local var_5_2
	local var_5_3 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_4 = BaseProps[iter_5_1.PropsID].propType

		if var_5_4 == PropType.eRandomGift or var_5_4 == PropType.eFixGift or var_5_4 == PropType.eVipRandomGift then
			table.insert(var_5_3, iter_5_1)
		end
	end

	var_5_1:reloadData(var_5_3)

	if var_5_0 then
		local var_5_5 = 0

		for iter_5_2, iter_5_3 in ipairs(var_5_3) do
			if iter_5_3.PropsID == var_5_0 then
				var_5_5 = iter_5_2

				break
			end
		end

		local var_5_6 = CCSize(232, 472)
		local var_5_7 = CCSize(931, 500)
		local var_5_8 = var_5_1:minContainerOffset()
		local var_5_9 = var_5_6.width
		local var_5_10 = var_5_7.width / 2
		local var_5_11 = -var_5_8.x
		local var_5_12 = (var_5_5 - 0.5) * var_5_9

		if var_5_10 <= var_5_12 then
			var_5_12 = var_5_12 - var_5_10

			if var_5_11 < var_5_12 then
				var_5_12 = var_5_11
			end
		else
			var_5_12 = 0
		end

		var_5_1:setContentOffsetInDuration(ccp(-var_5_12, 0), 0.6)

		arg_5_0.id = nil
	end
end

function var_0_7.initRequests(arg_6_0)
	arg_6_0.propListRequest = PropListRequest:new(arg_6_0.parent)

	arg_6_0.propListRequest:setResponseNormalHandler(function()
		local var_7_0 = arg_6_0.propListRequest:getResponseContent()

		var_0_0.set("prop-list", var_7_0)
		arg_6_0:reloadData(var_7_0)
	end)
	arg_6_0.propListRequest:setResponseExceptionHandler(function()
		print("请求发生错误")
	end)

	arg_6_0.buyPropRequest = BuyPropRequest:new(arg_6_0.parent)

	arg_6_0.buyPropRequest:setResponseNormalHandler(function()
		local var_9_0 = arg_6_0.buyPropRequest:getResponseContent().Reward

		if not var_9_0 then
			return
		end

		local var_9_1 = var_9_0[1]
		local var_9_2 = getItemName(ItemType.eProp, var_9_1.ID)
		local var_9_3 = var_9_1.Count
		local var_9_4 = string.lf("您成功购买%sx%d，是否继续购买？", var_9_2, var_9_3)

		arg_6_0.card:done()
		ui.showMessageBox({
			text = var_9_4,
			parent = display.getRunningScene(),
			title1 = string.lf("确定"),
			title2 = string.lf("去包裹"),
			action2 = function()
				game.enterBagScene()
			end
		})
	end)
	arg_6_0.buyPropRequest:setResponseExceptionHandler(function()
		print("请求发生错误")
	end)
end

function var_0_7.createPropCard(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_3.PropsID
	local var_12_1 = BaseProps[var_12_0]
	local var_12_2 = _FONT_DEFAULT
	local var_12_3 = 20
	local var_12_4 = 24
	local var_12_5 = ccc3(34, 20, 0)
	local var_12_6 = ccc3(236, 216, 152)
	local var_12_7 = display.newSprite("ui/store/store_034.png")
	local var_12_8 = var_12_7:getContentSize()

	var_12_7:setAnchorPoint(CCPoint(0, 0))
	var_12_7:setPosition(6, 0)

	if not var_12_1 then
		print("没有对应的道具数据:", var_12_0)

		return var_12_7
	end

	local var_12_9 = arg_12_2
	local var_12_10 = display.newSprite(var_0_5[var_12_9], var_12_8.width / 2, var_12_8.height - 32)

	var_12_10:setAnchorPoint(ccp(1, 0.5))
	var_12_7:addChild(var_12_10)

	local var_12_11 = display.newSprite("uilocal/store/store_text_072.png", var_12_8.width / 2, var_12_8.height - 32)

	var_12_11:setAnchorPoint(ccp(0, 0.5))
	var_12_7:addChild(var_12_11)

	local var_12_12 = ui.newControlButton({
		normalImage = "body/" .. BaseProps[var_12_0].bodyImage,
		clickAction = function(arg_13_0, arg_13_1)
			local var_13_0 = arg_12_3.VipSpecial and arg_12_3.VipSpecial or BaseProps[var_12_0].propValue
			local var_13_1 = require("scenes.store.VipDetailInfoLayer").new({
				rewardList = var_13_0
			})

			display.getRunningScene():addChild(var_13_1)
		end
	})

	var_12_12:setPosition(var_12_8.width / 2, var_12_8.height - 150)
	var_12_7:addChild(var_12_12)

	local var_12_13
	local var_12_14 = var_0_1.newLabel({
		text = var_12_1.desc,
		font = var_12_2,
		size = var_12_3,
		color = var_12_5,
		dimensions = CCSize(180, 0),
		align = ui.TEXT_ALIGN_CENTER
	})

	var_12_14:setAnchorPoint(ccp(0.5, 1))
	var_12_14:setPosition(var_12_8.width / 2, 230)
	var_12_7:addChild(var_12_14)

	local var_12_15 = {
		value = 0,
		isOutline = true,
		type = arg_12_3.CurrencyType == 1 and ItemType.eCoin or ItemType.eGold,
		discount = var_12_13,
		color = ccc3(250, 200, 30)
	}
	local var_12_16 = var_0_1.newLabel({
		outline = true,
		text = string.lf("原价: ")
	})

	var_12_16:setPosition(60, 122)
	var_12_7:addChild(var_12_16)

	var_12_15.value = var_0_4[var_12_9]

	local var_12_17 = createItemCountNode(var_12_15)

	var_12_17:setPosition(110, 122)
	var_12_7:addChild(var_12_17)

	local var_12_18 = display.newSprite("ui/store/store_035.png")

	var_12_18:setPosition(var_12_8.width / 2, 122)
	var_12_7:addChild(var_12_18)

	local var_12_19 = var_0_1.newLabel({
		outline = true,
		text = string.lf("现价: ")
	})

	var_12_19:setPosition(60, 92)
	var_12_7:addChild(var_12_19)

	var_12_15.value = arg_12_3.Price

	local var_12_20 = createItemCountNode(var_12_15)

	var_12_20:setPosition(110, 92)
	var_12_7:addChild(var_12_20)

	local var_12_21 = ui.newControlButton({
		normalImage = "ui/common/common_109.png",
		disabledImage = "ui/common/common_zhihuianniu.png",
		clickAction = function(arg_14_0, arg_14_1)
			if var_12_9 - 1 > Player.vipLevel then
				ui.showMessageBox({
					animate = "slide",
					text = string.lf("上仙，提升#EA8A1EVIP等级#FFFFFF才能购买高等级的VIP礼包，再购买#EA8A1E%d元宝#FFFFFF即可升级！", Player.vipLevelUpExp),
					title1 = string.lf("确定"),
					title2 = string.lf("去充值"),
					action2 = function()
						var_0_0.set("store-tag", StoreType.eStoreGift)
						game.enterStoreRechargeScene()
					end
				})
			elseif arg_12_3.TotalBuyCnt > 0 then
				ui.showMessageBox({
					slide = true,
					text = string.lf("上仙，相同等级的VIP礼包只能购买一次哦！")
				})
			else
				arg_12_0.card = var_12_7

				arg_12_0.buyPropRequest:request(var_12_0)
			end
		end
	})

	var_12_21:setEnabled(arg_12_3.TotalBuyCnt < 1)

	local var_12_22 = var_12_21:getContentSize()
	local var_12_23 = display.newSprite("uilocal/store/store_text_009.png")

	var_12_23:setPosition(var_12_22.width / 2, var_12_22.height / 2)
	var_12_21:addChild(var_12_23)
	var_12_21:setPosition(var_12_8.width / 2, 43)
	var_12_7:addChild(var_12_21, 0, var_12_0)

	function var_12_7.done()
		arg_12_3.TotalBuyCnt = arg_12_3.TotalBuyCnt + 1

		var_12_21:setEnabled(false)
	end

	return var_12_7
end

return var_0_7
