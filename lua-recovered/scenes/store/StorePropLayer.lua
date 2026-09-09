require("base.functions")
require("network.StoreRequest")

local var_0_0 = require("base.cache")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = require("scenes.toollayer.tool")
local var_0_3 = require("scenes.ToolLayer")
local var_0_4 = class("StorePropLayer", function()
	return display.newScale9Sprite("ui/store/store_012.jpg")
end)

function var_0_4.ctor(arg_2_0, arg_2_1)
	arg_2_0.parent = arg_2_1.parent
	arg_2_0.id = arg_2_1.id

	arg_2_0:initRequests()
	arg_2_0:onEnterAlias()
end

function var_0_4.onEnterAlias(arg_3_0)
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

function var_0_4.reloadData(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.id
	local var_5_1 = arg_5_0.tableview
	local var_5_2
	local var_5_3 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_4 = BaseProps[iter_5_1.PropsID].propType

		if var_5_4 ~= PropType.eRandomGift and var_5_4 ~= PropType.eFixGift and var_5_4 ~= PropType.eVipRandomGift then
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

function var_0_4.initRequests(arg_6_0)
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

		arg_6_0.card:addCount(var_9_3)
		arg_6_0.card:refreshLimitLabel(var_9_3)

		if var_9_1.ID == 100001 then
			ui.showMessageBox({
				text = var_9_4,
				title1 = string.lf("确定"),
				title2 = string.lf("去主战场"),
				action2 = function()
					local var_10_0 = BaseStages[Player.taskInfo.MaxPID].chapterId
					local var_10_1 = WorldType.eHeaven

					if var_10_0 then
						var_10_1 = BaseChapters[var_10_0].worldType
					end

					game.enterMapWorldScene(var_10_1)
				end
			})
		else
			ui.showMessageBox({
				text = var_9_4,
				title1 = string.lf("确定"),
				title2 = string.lf("去包裹"),
				action2 = function()
					game.enterBagScene()
				end
			})
		end
	end)
	arg_6_0.buyPropRequest:setResponseExceptionHandler(function()
		print("请求发生错误")
	end)
end

function var_0_4.createPropCard(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = {
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
	local var_13_1 = arg_13_3.PropsID
	local var_13_2 = BaseProps[var_13_1]
	local var_13_3 = _FONT_DEFAULT
	local var_13_4 = 20
	local var_13_5 = 24
	local var_13_6 = ccc3(34, 20, 0)
	local var_13_7 = ccc3(236, 216, 152)
	local var_13_8 = display.newSprite("ui/store/store_007.png")
	local var_13_9 = var_13_8:getContentSize()

	var_13_8:setAnchorPoint(CCPoint(0, 0))
	var_13_8:setPosition(6, 0)

	if not var_13_2 then
		print("没有对应的道具数据:", var_13_1)

		return var_13_8
	end

	local var_13_10 = 30
	local var_13_11 = arg_13_3.TodayHaveBuyCnt
	local var_13_12 = arg_13_3.TotalBuyCnt

	if var_13_11 then
		local var_13_13 = var_0_1.newLabel({
			size = 16,
			text = string.lf("购买数量限制: %d/%d", var_13_12, var_13_12 + var_13_11),
			color = var_13_7
		})

		var_13_13:setPosition(var_13_9.width / 2, var_13_9.height - 50)

		var_13_8.limitLabel = var_13_13

		var_13_8:addChild(var_13_13)

		var_13_10 = 25
	end

	local var_13_14 = var_0_1.newLabel({
		outline = true,
		text = var_13_2.name,
		font = var_13_3,
		size = var_13_5,
		color = var_13_7
	})
	local var_13_15 = var_13_14:getContentSize()

	var_13_14:setPosition(var_13_9.width / 2, var_13_9.height - var_13_10)
	var_13_8:addChild(var_13_14)

	local var_13_16 = display.newSprite("body/" .. BaseProps[var_13_1].bodyImage)

	var_13_16:setPosition(var_13_9.width / 2, var_13_9.height - 150)
	var_13_8:addChild(var_13_16)

	local var_13_17 = CCSize(110, 28)
	local var_13_18 = display.newScale9Sprite("ui/common/common_052.png")
	local var_13_19 = var_0_1.newLabel({
		text = "",
		size = 20,
		font = _FONT_DEFAULT
	})

	var_13_19:setPosition(var_13_17.width / 2, var_13_17.height / 2)
	var_13_18:addChild(var_13_19)
	var_13_18:setContentSize(var_13_17)
	var_13_18:setPosition(150, 257)
	var_13_8:addChild(var_13_18)

	var_13_8.count = 0
	var_13_8.countLabel = var_13_19
	var_13_8.countSprite = var_13_18

	local var_13_20 = arg_13_3.Discount
	local var_13_21 = arg_13_3.VipDis

	if var_13_21 then
		if Player.vipLevel < var_13_21.VipLv then
			var_13_20 = var_13_21.Dis
		else
			var_13_20 = var_13_21.VipDis
		end

		local var_13_22 = string.lf("V%d %s折", var_13_21.VipLv, var_0_2.number2local(var_13_21.VipDis * 10))
		local var_13_23 = createMarkLabel({
			text = var_13_22
		})

		var_13_23:setPosition(40, var_13_9.height - 43)
		var_13_8:addChild(var_13_23)
	end

	if var_13_20 and var_13_20 > 0.4 and var_13_20 < 1 then
		local var_13_24 = var_13_16:getContentSize()
		local var_13_25 = math.floor(var_13_20 * 10)
		local var_13_26 = display.newSprite(var_13_0[var_13_25])

		var_13_26:setAnchorPoint(CCPoint(0.5, 0.5))
		var_13_26:setPosition(var_13_24.width - 30, 50)
		var_13_16:addChild(var_13_26)
	end

	local var_13_27 = var_0_1.newLabel({
		text = var_13_2.desc,
		font = var_13_3,
		size = var_13_4,
		color = var_13_6,
		dimensions = CCSize(180, 0),
		align = ui.TEXT_ALIGN_CENTER
	})

	var_13_27:setAnchorPoint(ccp(0.5, 1))
	var_13_27:setPosition(var_13_9.width / 2, 230)
	var_13_8:addChild(var_13_27)

	local var_13_28 = {
		isOutline = true,
		type = arg_13_3.CurrencyType == 1 and ItemType.eCoin or ItemType.eGold,
		value = arg_13_3.Price,
		discount = var_13_20,
		color = ccc3(250, 200, 30)
	}
	local var_13_29 = createItemCountNode(var_13_28)

	if var_13_20 then
		var_13_29:setPosition(75, 92)
	else
		var_13_29:setPosition(90, 92)
	end

	var_13_8:addChild(var_13_29)

	var_13_8.ingot = var_13_29

	local var_13_30 = ui.newControlButton({
		normalImage = "ui/common/common_109.png",
		clickAction = function(arg_14_0, arg_14_1)
			local var_14_0 = arg_13_3.PropsID
			local var_14_1 = clone(var_13_28)
			local var_14_2 = arg_13_3.VipLvLimit or 0

			if var_14_2 > Player.vipLevel then
				ui.showMessageBox({
					animate = "slide",
					text = string.lf("上仙，VIP%d即以上才能购买当前道具哦！马上去充值？", var_14_2),
					title1 = string.lf("确定"),
					action1 = function()
						game.enterStoreRechargeScene({
							backcall = function()
								game.enterStoreScene({
									defaultPage = StoreType.eStoreProp
								})
							end
						})
					end,
					title2 = string.lf("取消")
				})
			else
				var_0_3.createDialog({
					show = var_0_3.eShowPropBuy,
					data = {
						id = var_14_0,
						price = var_14_1,
						count = arg_13_3.TotalBuyCnt,
						limit = var_13_11
					},
					callback = function(arg_17_0)
						arg_13_0.card = var_13_8

						arg_13_0.buyPropRequest:request(var_14_0, arg_17_0)
					end
				}):show()
			end
		end
	})
	local var_13_31 = var_13_30:getContentSize()
	local var_13_32 = display.newSprite("uilocal/store/store_text_009.png")

	var_13_32:setPosition(var_13_31.width / 2, var_13_31.height / 2)
	var_13_30:addChild(var_13_32)
	var_13_30:setPosition(var_13_9.width / 2, 43)
	var_13_8:addChild(var_13_30, 0, var_13_1)

	function var_13_8.addCount(arg_18_0, arg_18_1, arg_18_2)
		if not arg_18_2 then
			arg_13_3.TotalBuyCnt = arg_13_3.TotalBuyCnt + arg_18_1
		end

		arg_18_1 = arg_18_0.count + arg_18_1
		arg_18_0.count = arg_18_1

		arg_18_0.countLabel:setString(string.lf("拥有：%d", arg_18_1))
		arg_18_0.countSprite:setVisible(arg_18_1 > 0)

		if var_13_2.propType == PropType.eEnergy then
			arg_18_0.ingot:setValue(var_0_2.getEnergyPrice(arg_13_3.TotalBuyCnt))
		end
	end

	function var_13_8.refreshLimitLabel(arg_19_0, arg_19_1)
		if arg_19_0.limitLabel then
			print(arg_19_1)

			arg_13_3.TodayHaveBuyCnt = arg_13_3.TodayHaveBuyCnt - arg_19_1
			var_13_11 = var_13_11 - arg_19_1

			local var_19_0 = arg_13_3.TodayHaveBuyCnt
			local var_19_1 = arg_13_3.TotalBuyCnt

			arg_19_0.limitLabel:setString(string.lf("购买数量限制: %d/%d", var_19_1, var_19_1 + var_19_0))
		end
	end

	local var_13_33 = Player:getItemCount(ItemType.eProp, var_13_1)

	var_13_8:addCount(var_13_33, true)

	return var_13_8
end

return var_0_4
