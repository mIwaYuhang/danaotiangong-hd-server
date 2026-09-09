require("network.StoreRequest")
require("data.EquipHelper")

local var_0_0 = require("base.cache")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = require("scenes.toollayer.tool")
local var_0_3 = require("scenes.toollayer.timer")
local var_0_4 = require("scenes.ToolLayer")
local var_0_5 = require("scenes.toollayer.model")
local var_0_6 = var_0_5:extend({
	attach = function(arg_1_0, arg_1_1)
		arg_1_0:detach()
	end,
	loadData = function(arg_2_0, arg_2_1)
		local var_2_0 = arg_2_1.Item[1]
		local var_2_1 = var_2_0.Type
		local var_2_2 = var_2_0.ID
		local var_2_3 = var_2_0.Count

		arg_2_0.id = var_2_2
		arg_2_0.type = var_2_1
		arg_2_0.index = arg_2_1.Index
		arg_2_0.limit = arg_2_1.HaveBuyTimes
		arg_2_0.price = arg_2_1.Price
		arg_2_0.priceType = arg_2_1.PriceType
		arg_2_0.name = getItemName(var_2_1, var_2_2)
		arg_2_0.count = var_2_3
	end,
	update = function(arg_3_0, arg_3_1)
		local var_3_0 = false

		if arg_3_0.index == arg_3_1 then
			arg_3_0.limit = arg_3_0.limit - 1
			var_3_0 = true
		end

		arg_3_0:trigger("update", arg_3_0, var_3_0)
	end
})
local var_0_7 = var_0_5:extend({
	count = 0,
	time = 0,
	token = 0,
	ingot = 0,
	attach = function(arg_4_0, arg_4_1)
		arg_4_0.timer = var_0_3:new()
		arg_4_0.request = MysticStoreRequest:new(arg_4_1)

		arg_4_0.request:setResponseNormalHandler(function()
			local var_5_0, var_5_1 = arg_4_0.request:getResponseContent()

			if var_5_0 == MysticStoreRequest.eGet then
				arg_4_0.mData = var_5_1

				arg_4_0:loadData(var_5_1)
				arg_4_0.waitcall()
			elseif var_5_0 == MysticStoreRequest.eRefresh then
				arg_4_0.mData = var_5_1

				arg_4_0:loadData(var_5_1)
				arg_4_0:trigger("sync", arg_4_0)
			elseif var_5_0 == MysticStoreRequest.eBuy then
				local var_5_2 = arg_4_0.buyValue

				for iter_5_0, iter_5_1 in ipairs(arg_4_0.dataset) do
					iter_5_1:update(var_5_2)
				end
			end
		end)
		arg_4_0.request:setResponseExceptionHandler(function()
			arg_4_0.dirty = true

			print("处理请求发生错误")
		end)
	end,
	loadData = function(arg_7_0, arg_7_1)
		arg_7_0.time = arg_7_1.HaveCDTime
		arg_7_0.count = arg_7_1.HaveRefreshTime
		arg_7_0.ingot = arg_7_1.Ingot

		local var_7_0 = arg_7_1.Info
		local var_7_1
		local var_7_2 = {}

		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			local var_7_3 = var_0_6:new()

			var_7_3:loadData(iter_7_1)
			table.insert(var_7_2, var_7_3)
		end

		arg_7_0.dataset = var_7_2

		local var_7_4 = var_0_2.tokenId(PropType.eMysteryStore)

		arg_7_0.token = Player:getItemCount(ItemType.eProp, var_7_4)
	end,
	sync = function(arg_8_0)
		if arg_8_0.dirty then
			arg_8_0.waitcall = var_0_2.wait("event", 2, function()
				arg_8_0:trigger("sync", arg_8_0)
			end)

			EquipHelper:getEquipList(EquipClassType.eEquipAll, arg_8_0.waitcall)
			arg_8_0.request:get()
		else
			arg_8_0:trigger("sync", arg_8_0)
		end
	end,
	refresh = function(arg_10_0)
		arg_10_0.request:refresh()
	end,
	buy = function(arg_11_0, arg_11_1)
		arg_11_0.buyValue = arg_11_1

		arg_11_0.request:buy(arg_11_1)
	end
})
local var_0_8 = class("MysticStoreScene", function()
	return display.newScene("MysticStoreScene")
end)

function var_0_8.ctor(arg_13_0, arg_13_1)
	if arg_13_1 ~= nil and arg_13_1.curIndex ~= nil then
		arg_13_0.curIndex = arg_13_1.curIndex
	end

	if arg_13_1 ~= nil and arg_13_1.returnAction ~= nil then
		arg_13_0.returnAction = arg_13_1.returnAction
	end

	arg_13_0.model = var_0_0.get(arg_13_0)

	if not arg_13_0.model then
		arg_13_0.model = var_0_7:new()

		var_0_0.set(arg_13_0, arg_13_0.model)
	end

	arg_13_0.model:attach(arg_13_0)
	arg_13_0:onEnterAlias()
end

function var_0_8.onEnterAlias(arg_14_0)
	local var_14_0 = require("scenes.CommonBgLayer").new({
		titleSprite = "uilocal/store/store_text_021.png",
		returnAction = arg_14_0.returnAction or function()
			if arg_14_0.curIndex == nil then
				game.enterHomeScene()
			elseif arg_14_0.curIndex == StoreType.eStoreRefine then
				game.enterRefineScene()
			elseif arg_14_0.curIndex == StoreType.eStoreRebirth then
				game.enterRefineScene({
					defaultType = EnhanceType.eEquipRebirth
				})
			else
				game.enterStoreScene({
					defaultPage = arg_14_0.curIndex
				})
			end
		end
	})
	local var_14_1 = var_14_0:getBackgroundSprite()
	local var_14_2 = var_14_1:getContentSize()

	arg_14_0:addChild(var_14_0)

	local var_14_3 = display.newSprite("ui/store/store_021.jpg")

	var_14_3:setAnchorPoint(ccp(0.5, 0))
	var_14_3:setPosition(var_14_2.width / 2, 7)
	var_14_1:addChild(var_14_3)

	local var_14_4 = var_14_3

	arg_14_0.container = var_14_4

	local var_14_5 = createPlayerAttrNode({
		ItemType.eSoulJade,
		ItemType.eGold,
		ItemType.eCoin
	})

	var_14_5:setPosition(ccp(290, 578))
	var_14_4:addChild(var_14_5)

	local var_14_6 = arg_14_0:createPropView()

	var_14_6:setPosition(50, 65)
	var_14_4:addChild(var_14_6)

	local var_14_7 = var_0_1.newLabel({
		size = 20,
		text = string.lf("剩余刷新时间: 00:00:00"),
		font = _FONT_DEFAULT,
		color = ccc3(0, 250, 229)
	})

	var_14_7:setAnchorPoint(ccp(0, 0.5))
	var_14_7:setPosition(200, 30)
	var_14_4:addChild(var_14_7)

	arg_14_0.residue = var_14_7

	local var_14_8 = var_0_1.newLabel({
		size = 20,
		text = string.lf("拥有刷新令: 0"),
		font = _FONT_DEFAULT,
		color = ccc3(0, 250, 229)
	})

	var_14_8:setAnchorPoint(ccp(0, 0.5))
	var_14_8:setPosition(440, 30)
	var_14_4:addChild(var_14_8)

	arg_14_0.token = var_14_8

	local var_14_9 = ui.newControlButton({
		normalImage = "ui/common/common_109.png",
		text = string.lf("炼化炉"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_16_0, arg_16_1)
			GuideLayer:stepDone(TaskEntryType.eRefining, 2)
			game.enterRefineScene({
				mysticStore = true
			})
		end
	})

	var_14_9:setPosition(80, 30)
	var_14_4:addChild(var_14_9)
	GuideLayer:showGuideLayer(arg_14_0, var_14_9, TaskEntryType.eRefining, 2, nil, true)

	local var_14_10 = ui.newControlButton({
		normalImage = "ui/common/common_055.png",
		text = string.lf("刷新"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_17_0, arg_17_1)
			if arg_14_0.model.count > 0 then
				if arg_14_0.model.token > 0 or isMoneyEnough(ItemType.eGold, arg_14_0.model.ingot) then
					arg_14_0.model:refresh()
				end
			else
				arg_14_0:showInfoBox(string.lf("上仙，提升VIP等级可以增加刷新次数哦！"))
			end
		end
	})

	var_14_10:setPosition(var_14_2.width - 80, 30)
	var_14_4:addChild(var_14_10)

	arg_14_0.refresh = var_14_10

	local var_14_11 = var_0_1.newLabel({
		size = 20,
		text = string.lf("刷新花费："),
		font = _FONT_DEFAULT,
		color = ccc3(250, 230, 60)
	})
	local var_14_12 = createItemCountNode({
		value = 0,
		type = ItemType.eGold,
		color = ccc3(250, 230, 60)
	})

	var_14_11:setVisible(false)
	var_14_12:setVisible(false)
	var_14_11:setPosition(645, 30)
	var_14_12:setPosition(700, 30)
	var_14_4:addChild(var_14_11)
	var_14_4:addChild(var_14_12)

	arg_14_0.costLabel = var_14_11
	arg_14_0.costValue = var_14_12

	arg_14_0.model:on("sync", arg_14_0.onSync, arg_14_0)
	arg_14_0.model:on("buy", arg_14_0.onBuy, arg_14_0)
	arg_14_0.model:sync()
end

function var_0_8.onExit(arg_18_0)
	arg_18_0.model:detach()
end

function var_0_8.onSync(arg_19_0, arg_19_1)
	local var_19_0 = {}
	local var_19_1 = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_1.dataset) do
		table.insert(var_19_0, iter_19_1)

		if #var_19_0 == 2 then
			table.insert(var_19_1, var_19_0)

			var_19_0 = {}
		end
	end

	if #var_19_0 > 0 then
		table.insert(var_19_1, var_19_0)
	end

	if arg_19_1.token < 1 then
		arg_19_0.costLabel:setVisible(true)
		arg_19_0.costValue:setVisible(true)
		arg_19_0.costValue:setValue(arg_19_1.ingot)
	end

	arg_19_0.token:setString(string.lf("拥有刷新令: %s", arg_19_1.token))
	arg_19_0.tableview:reloadData(var_19_1)

	if arg_19_1.time > 0 then
		arg_19_0.model.timer:schedule(arg_19_1.time, function(arg_20_0, arg_20_1)
			arg_19_0.residue:setString(string.lf("剩余刷新时间: %s", formatTime(arg_20_1)))
		end, function()
			arg_19_1.dirty = true

			arg_19_1:sync()
		end)
		arg_19_0.model.timer:start()
	else
		arg_19_0.model:refresh()
	end
end

function var_0_8.onBuy(arg_22_0, arg_22_1)
	return
end

function var_0_8.createPropView(arg_23_0)
	local var_23_0 = CCSize(850, 460)
	local var_23_1 = {
		direction = kCCScrollViewDirectionVertical,
		size = var_23_0,
		sizehandler = function(arg_24_0, arg_24_1)
			return CCSize(850, 115)
		end,
		cellhandler = handler(arg_23_0, arg_23_0.createPropList)
	}
	local var_23_2 = var_0_1.newTableView(var_23_1)

	var_23_2:setTouchEnabled(false)

	arg_23_0.tableview = var_23_2

	return var_23_2
end

function var_0_8.createPropList(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = CCSize(850, 115)
	local var_25_1 = var_0_1.newNode()

	var_25_1:setContentSize(var_25_0)

	local var_25_2 = display.newScale9Sprite("ui/store/store_023.png")

	var_25_2:setContentSize(CCSize(var_25_0.width, 48))
	var_25_2:setPosition(var_25_0.width / 2, 13)
	var_25_1:addChild(var_25_2)

	local var_25_3
	local var_25_4 = 10
	local var_25_5 = 18

	for iter_25_0, iter_25_1 in ipairs(arg_25_3) do
		local var_25_6 = arg_25_0:createPropItem(iter_25_1)

		var_25_6:setPosition(var_25_4, var_25_5)
		var_25_1:addChild(var_25_6)

		var_25_4 = var_25_4 + 420
	end

	return var_25_1
end

function var_0_8.createPropItem(arg_26_0, arg_26_1)
	local var_26_0 = CCSize(420, 110)
	local var_26_1 = var_0_1.newNode()

	var_26_1:setContentSize(var_26_0)

	local function var_26_2(arg_27_0)
		local var_27_0
		local var_27_1 = 0
		local var_27_2 = true

		if arg_27_0.type == ItemType.eFragment then
			local var_27_3 = 0
			local var_27_4 = Player:getItemCount(arg_27_0.type, arg_27_0.id)
			local var_27_5 = BaseFragments[arg_27_0.id].exchangeCount

			var_27_0 = string.lf("(已拥有: %s/%s)", var_27_4, var_27_5)
		elseif arg_27_0.type == ItemType.eHero then
			local var_27_6 = Player:getItemCount(arg_27_0.type, arg_27_0.id)

			var_27_2 = var_27_6 < 1
			var_27_0 = var_27_6 > 0 and string.lf("(已拥有)") or string.lf("(未拥有)")
		elseif arg_27_0.type == ItemType.eEquip then
			var_27_0 = arg_26_0:getEquipData(arg_27_0.id) and string.lf("(已拥有)") or string.lf("(未拥有)")
		elseif arg_27_0.type == ItemType.eSoul or arg_27_0.type == ItemType.eMate then
			local var_27_7 = Player:getItemCount(arg_27_0.type, arg_27_0.id)

			var_27_0 = string.lf("(已拥有: %s)", var_27_7)
		end

		return var_27_0, var_27_2
	end

	local var_26_3
	local var_26_4
	local var_26_5
	local var_26_6

	if arg_26_0.model.mData.IngotD ~= nil then
		local var_26_7 = arg_26_0.model.mData.IngotD * 10

		var_26_3 = display.newSprite("uilocal/store/icon_sale_" .. var_26_7 .. ".png")

		var_26_3:setRotation(60)
		var_26_3:setScale(0.7)
	end

	if arg_26_0.model.mData.SoulJadeD ~= nil then
		local var_26_8 = arg_26_0.model.mData.SoulJadeD * 10

		var_26_4 = display.newSprite("uilocal/store/icon_sale_" .. var_26_8 .. ".png")

		var_26_4:setRotation(60)
		var_26_4:setScale(0.7)
	end

	local var_26_9 = figure.createHeader({
		isName = false,
		inTeam = false,
		isStoreBkground = true,
		itemId = arg_26_1.id,
		type = arg_26_1.type,
		count = arg_26_1.count,
		clickAction = function()
			var_0_4.tipshandler({
				Type = arg_26_1.type,
				ID = arg_26_1.id,
				Count = arg_26_1.count
			})
		end
	})

	if arg_26_1.priceType == 2 and var_26_3 ~= nil then
		arg_26_1.price = math.floor(arg_26_1.price * arg_26_0.model.mData.IngotD)

		var_26_9:addChild(var_26_3)
		var_26_3:setPosition(38, 30)
	end

	if arg_26_1.priceType == 25 and var_26_4 ~= nil then
		arg_26_1.price = math.floor(arg_26_1.price * arg_26_0.model.mData.SoulJadeD)

		var_26_9:addChild(var_26_4)
		var_26_4:setPosition(38, 30)
	end

	var_26_9:setPosition(70, var_26_0.height / 2)
	var_26_9:setScale(0.9)
	var_26_1:addChild(var_26_9)

	local var_26_10, var_26_11 = var_26_2(arg_26_1)

	if var_26_10 then
		local var_26_12 = var_0_1.newLabel({
			size = 20,
			text = var_26_10,
			font = _FONT_DEFAULT,
			color = ccc3(120, 230, 90)
		})

		var_26_12:setAnchorPoint(ccp(0, 0.5))
		var_26_12:setPosition(130, 25)
		var_26_1:addChild(var_26_12)

		var_26_1.desc = var_26_12
	end

	local var_26_13 = arg_26_1.name
	local var_26_14 = getItemQuality(arg_26_1.type, arg_26_1.id)
	local var_26_15 = getQualityColor(var_26_14)

	if arg_26_1.type ~= ItemType.eHero then
		var_26_13 = var_26_13 .. "x" .. arg_26_1.count
	end

	if arg_26_1.type == ItemType.eTrainPill then
		var_26_15.r = var_26_15.r + 50
		var_26_15.g = var_26_15.g + 50
		var_26_15.b = var_26_15.b + 20
	end

	local var_26_16 = var_0_1.newLabel({
		size = 24,
		outline = true,
		text = var_26_13,
		color = var_26_15
	})

	var_26_16:setAnchorPoint(ccp(0, 0.5))
	var_26_16:setPosition(130, 85)
	var_26_1:addChild(var_26_16)

	local var_26_17 = getItemName(arg_26_1.priceType)
	local var_26_18 = var_0_1.newLabel({
		text = string.lf("消耗%s", var_26_17)
	})

	var_26_18:setAnchorPoint(ccp(0, 0.5))
	var_26_18:setPosition(130, 55)
	var_26_1:addChild(var_26_18)

	local var_26_19 = var_26_18:getContentSize()
	local var_26_20 = display.newSprite(getItemIconPath(arg_26_1.priceType))

	var_26_20:setPosition(var_26_19.width + 143, 55)
	var_26_1:addChild(var_26_20)

	local var_26_21 = var_0_1.newLabel({
		text = ": " .. arg_26_1.price
	})

	var_26_21:setAnchorPoint(ccp(0, 0.5))
	var_26_21:setPosition(238, 55)
	var_26_1:addChild(var_26_21)

	local var_26_22 = ui.newControlButton({
		normalImage = "ui/store/store_022.png",
		text = string.lf("购买"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_29_0, arg_29_1)
			local var_29_0 = true

			if arg_26_1.priceType == ItemType.eGold then
				var_29_0 = isMoneyEnough(ItemType.eGold, arg_26_1.price)
			elseif arg_26_1.priceType == ItemType.eSoulJade and Player.soulJade < arg_26_1.price then
				var_29_0 = false

				arg_26_0:showInfoBox(string.lf("上仙，魂玉可以通过炼化四星级或者五星级战将获得哦！"))
			end

			if var_29_0 then
				if arg_26_1.limit < 1 then
					arg_26_0:showInfoBox(string.lf("上仙，该道具购买次数已用完，不能购买了！"))
				elseif var_26_1.notice then
					arg_26_0:showInfoBox(string.lf("上仙，已拥有的主将购买后会自动转为魂魄哦！"), function()
						arg_26_0.model:buy(arg_26_1.index)
					end)
				elseif arg_26_1.type ~= ItemType.eEquip then
					arg_26_0.model:buy(arg_26_1.index)
				elseif isEquipCountNotMax() then
					arg_26_0.model:buy(arg_26_1.index)
				end
			end
		end
	})

	var_26_22:setTitleColorForState(ccc3(120, 120, 120), CCControlStateDisabled)
	var_26_22:setPosition(365, var_26_0.height / 2)
	var_26_22:setEnabled(arg_26_1.limit > 0)
	var_26_1:addChild(var_26_22)

	var_26_1.notice = not var_26_11

	arg_26_1:attach(var_26_1)
	arg_26_1:on("update", function(arg_31_0, arg_31_1)
		if var_26_1.desc then
			local var_31_0, var_31_1 = var_26_2(arg_31_0)

			var_26_1.desc:setString(var_31_0)

			var_26_1.notice = not var_31_1
		end

		var_26_22:setEnabled(arg_31_0.limit > 0)

		if arg_31_1 then
			showFlashImage({
				image = "uilocal/enhance/enhance_txt_007.png",
				scale = 0.8,
				parent = var_26_1,
				position = ccp(160, 20)
			})
		end
	end)

	return var_26_1
end

function var_0_8.showInfoBox(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = {
		animate = "slide",
		text = arg_32_1,
		title1 = string.lf("确定")
	}

	if arg_32_2 then
		var_32_0.action1 = arg_32_2
		var_32_0.title2 = string.lf("取消")
	end

	ui.showMessageBox(var_32_0)
end

function var_0_8.getEquipData(arg_33_0, arg_33_1)
	for iter_33_0, iter_33_1 in ipairs(EquipHelper._allEquips) do
		if iter_33_1.equipId == arg_33_1 then
			return iter_33_1
		end
	end
end

return var_0_8
