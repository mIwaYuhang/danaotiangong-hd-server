local var_0_0 = {
	eBaowu = 3,
	eDaily = 1,
	eStore = 2
}

require("network.GuildRequest")

local var_0_1 = require("scenes.ToolLayer")
local var_0_2 = require("scenes.toollayer.ctrl")
local var_0_3 = require("base.cache")
local var_0_4 = class("GuildStoreScene", function()
	return display.newScene("GuildStoreScene")
end)

function var_0_4.ctor(arg_2_0, arg_2_1)
	if arg_2_1 and arg_2_1.tabPageTag then
		arg_2_0.defaultTag = arg_2_1.tabPageTag
	else
		arg_2_0.defaultTag = 1
	end

	local var_2_0 = require("scenes.CommonBgLayer").new({
		titleSprite = "uilocal/guild/guild_text_010.png",
		returnAction = function()
			game.enterGuildHomeScene()
		end
	})
	local var_2_1 = var_2_0:getBackgroundSprite()

	arg_2_0:addChild(var_2_0)

	arg_2_0.bgSprite = var_2_1
	arg_2_0.nodeSize = var_2_1:getContentSize()

	arg_2_0:initRequests()

	local var_2_2 = var_0_3.get("GetPlayerGuildInfoRequest")

	arg_2_0.levelLable = var_0_2.newLabel({
		text = string.lf("#FFFF00仙盟商店等级: #00FF00%s", var_2_2.ShopLv)
	})

	arg_2_0.levelLable:setPosition(100, 540)
	arg_2_0.bgSprite:addChild(arg_2_0.levelLable)

	arg_2_0.player_gold = createItemCountNode({
		isOutline = true,
		scale = 0.9,
		type = ItemType.eGold,
		value = Player.curGold,
		color = ccc3(241, 252, 203)
	})

	arg_2_0.player_gold:setPosition(210, 540)
	arg_2_0.bgSprite:addChild(arg_2_0.player_gold)

	arg_2_0.coinLable = createItemCountNode({
		color = ccc3(0, 255, 0),
		type = ItemType.eGuildCoin,
		value = var_2_2.PlayerUnionCoin
	})

	arg_2_0.coinLable:setPosition(ccp(335, 540))
	arg_2_0.coinLable:setAnchorPoint(ccp(0.5, 0.5))
	arg_2_0.bgSprite:addChild(arg_2_0.coinLable)
	arg_2_0:showTabButtons()
end

function var_0_4.refreshUnionCoin(arg_4_0)
	local var_4_0 = var_0_3.get("GetPlayerGuildInfoRequest")

	arg_4_0.levelLable:setString(string.lf("#FFFF00仙盟商店等级: #00FF00%s", var_4_0.ShopLv))
	arg_4_0.coinLable:setValue(var_4_0.PlayerUnionCoin)
	arg_4_0.player_gold:setValue(Player.curGold)
end

function var_0_4.unionCoinEnough(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2 = arg_5_2 or ItemType.eGuildCoin

	if arg_5_2 == ItemType.eGuildCoin then
		if arg_5_1 <= var_0_3.get("GetPlayerGuildInfoRequest").PlayerUnionCoin then
			return true
		else
			showFlashNotice(string.lf("晶石不足~"))

			return false
		end
	else
		return isMoneyEnough(arg_5_2, arg_5_1)
	end
end

function var_0_4.initRequests(arg_6_0)
	local function var_6_0()
		arg_6_0.zhenpinList = arg_6_0.getZhenpinRequest:getZhenpinList()
		arg_6_0.zhenpinCoolTime = arg_6_0.getZhenpinRequest:getZhenpinCoolTime()

		arg_6_0:showDailyGoods(arg_6_0.container)
		print(arg_6_0.zhenpinCoolTime)
	end

	arg_6_0.getZhenpinRequest = GetZhenpinRequest:new()

	arg_6_0.getZhenpinRequest:setResponseNormalHandler(var_6_0)

	local function var_6_1()
		local var_8_0 = 0
		local var_8_1 = 0

		for iter_8_0, iter_8_1 in ipairs(arg_6_0.zhenpinList) do
			if iter_8_1.Index == arg_6_0.zhenpinIndex then
				iter_8_1.HaveBuyTimes = arg_6_0.buyZhenpinRequest.restable
				var_8_1 = iter_8_1.PriceType

				print(var_8_1)

				var_8_0 = iter_8_1.Price

				print(var_8_0)
			end
		end

		if var_8_1 == ItemType.eGuildCoin then
			local var_8_2 = var_0_3.get("GetPlayerGuildInfoRequest")

			var_8_2.PlayerUnionCoin = var_8_2.PlayerUnionCoin - var_8_0

			var_0_3.set("GetPlayerGuildInfoRequest", var_8_2)
		end

		arg_6_0:showDailyGoods(arg_6_0.container)
		showFlashImage({
			image = "uilocal/enhance/enhance_txt_007.png",
			scale = 1,
			parent = arg_6_0.container,
			position = CCPoint(440 + 190 * arg_6_0.zhenpinIndex, 200),
			callback = function()
				arg_6_0:removeFromParentAndCleanup(true)
			end
		})
		arg_6_0:refreshUnionCoin()
	end

	arg_6_0.buyZhenpinRequest = BuyZhenpinRequest:new()

	arg_6_0.buyZhenpinRequest:setResponseNormalHandler(var_6_1)
	arg_6_0.buyZhenpinRequest:setResponseExceptionHandler(function()
		print("购买珍品失败")
	end)

	local function var_6_2()
		arg_6_0.fixGoodList = arg_6_0.getFixGoodRequest:getFixGoodList()

		arg_6_0:showStoreGoods(arg_6_0.container)
	end

	arg_6_0.getFixGoodRequest = GetFixGoodRequest:new()

	arg_6_0.getFixGoodRequest:setResponseNormalHandler(var_6_2)

	local function var_6_3()
		dump(arg_6_0.buyFixGoodsRequest.restable)

		local var_12_0 = 0
		local var_12_1 = 0

		for iter_12_0, iter_12_1 in ipairs(arg_6_0.fixGoodList) do
			if iter_12_1.Index == arg_6_0.fixGoodIndex then
				iter_12_1.HaveBuyTimes = arg_6_0.buyFixGoodsRequest.restable
				var_12_1 = iter_12_1.PriceType
				var_12_0 = iter_12_1.Price
			end
		end

		if var_12_1 == ItemType.eGuildCoin then
			local var_12_2 = var_0_3.get("GetPlayerGuildInfoRequest")

			var_12_2.PlayerUnionCoin = var_12_2.PlayerUnionCoin - var_12_0

			var_0_3.set("GetPlayerGuildInfoRequest", var_12_2)
		end

		arg_6_0:showStoreGoods(arg_6_0.container)
		arg_6_0.tableView:reloadData()
		arg_6_0.tableView:setContentOffset(arg_6_0.lastOffset)

		arg_6_0.lastOffset = nil

		showFlashImage({
			image = "uilocal/enhance/enhance_txt_007.png",
			scale = 1,
			parent = arg_6_0.container,
			position = CCPoint(600, 200),
			callback = function()
				arg_6_0:removeFromParentAndCleanup(true)
			end
		})
		arg_6_0:refreshUnionCoin()
	end

	arg_6_0.buyFixGoodsRequest = BuyFixGoodsRequest:new()

	arg_6_0.buyFixGoodsRequest:setResponseNormalHandler(var_6_3)
	arg_6_0.buyFixGoodsRequest:setResponseExceptionHandler(function()
		print("购买商品失败")
	end)

	local function var_6_4()
		arg_6_0.preciousList = arg_6_0.getPreciousRequest:getPreciousList()

		arg_6_0:showEvilGoods(arg_6_0.container)

		if arg_6_0.tableView then
			arg_6_0.tableView:reloadData()

			if arg_6_0.lastOffset then
				arg_6_0.tableView:setContentOffset(arg_6_0.lastOffset)

				arg_6_0.lastOffset = nil
			end
		end

		arg_6_0:refreshUnionCoin()
	end

	arg_6_0.getPreciousRequest = GetPreciousRequest:new()

	arg_6_0.getPreciousRequest:setResponseNormalHandler(var_6_4)
end

function var_0_4.showTabButtons(arg_16_0)
	local var_16_0 = "ui/guild/guild_017.jpg"
	local var_16_1 = CCSprite:create(var_16_0):getTextureRect().size
	local var_16_2 = {
		{
			isDefault = false,
			x = 510,
			tag = var_0_0.eDaily,
			titleText = string.lf("每日珍品")
		},
		{
			isDefault = false,
			x = 680,
			tag = var_0_0.eStore,
			titleText = string.lf("商店物品")
		},
		{
			isDefault = false,
			x = 850,
			tag = var_0_0.eBaowu,
			titleText = string.lf("魔族宝物")
		}
	}

	if arg_16_0.defaultTag and arg_16_0.defaultTag > 0 then
		for iter_16_0, iter_16_1 in pairs(var_16_2) do
			if iter_16_1.tag == arg_16_0.defaultTag then
				iter_16_1.isDefault = true
			end
		end

		arg_16_0.defaultTag = 0
	else
		var_16_2[1].isDefault = true
	end

	local function var_16_3(arg_17_0, arg_17_1)
		arg_16_0.container = nil
		arg_16_0.container = display.newSprite(var_16_0, var_16_1.width / 2, var_16_1.height / 2)

		arg_17_0:addChild(arg_16_0.container)

		arg_16_0.defaultTag = arg_17_1

		if arg_17_1 == var_0_0.eDaily then
			arg_16_0.getZhenpinRequest:requestZhenpinList()
		elseif arg_17_1 == var_0_0.eStore then
			arg_16_0.getFixGoodRequest:requestFixGoodList()
		elseif arg_17_1 == var_0_0.eBaowu then
			arg_16_0.getPreciousRequest:requestPreciousList()
		end
	end

	local var_16_4 = require("scenes.TabLayer").new({
		disabledImage = "ui/common/common_023_2.png",
		selectedImage = "ui/common/common_023.png",
		normalImage = "ui/common/common_022.png",
		size = var_16_1,
		point = CCPoint((arg_16_0.nodeSize.width - var_16_1.width) / 2, 10),
		config = var_16_2,
		cellHandler = var_16_3
	})

	arg_16_0.bgSprite:addChild(var_16_4)
end

function var_0_4.showDailyGoods(arg_18_0, arg_18_1)
	arg_18_1:removeAllChildrenWithCleanup(true)

	local var_18_0 = display.newScale9Sprite("ui/common/common_052.png")

	var_18_0:setPreferredSize(CCSize(200, 25))
	var_18_0:setPosition(800, 470)
	arg_18_1:addChild(var_18_0)

	local var_18_1, var_18_2, var_18_3, var_18_4 = getDateFromSeconds(arg_18_0.zhenpinCoolTime)
	local var_18_5 = string.format("%02d:%02d:%02d", var_18_2, var_18_3, var_18_4)
	local var_18_6 = var_0_2.newLabel({
		text = var_18_5,
		color = ccc3(255, 255, 0)
	})

	var_18_6:setPosition(800, 470)
	arg_18_1:addChild(var_18_6)

	local var_18_7 = arg_18_0.zhenpinCoolTime
	local var_18_8 = 0.5
	local var_18_9 = CCArray:create()

	var_18_9:addObject(CCCallFunc:create(function()
		var_18_7 = var_18_7 - var_18_8

		if var_18_7 > 0 then
			arg_18_0.zhenpinCoolTime = var_18_7

			local var_19_0, var_19_1, var_19_2, var_19_3 = getDateFromSeconds(arg_18_0.zhenpinCoolTime)
			local var_19_4 = string.format("%02d:%02d:%02d", var_19_1, var_19_2, var_19_3)

			var_18_6:setString(string.lf("倒计时: %s", var_19_4))
			var_18_6:setVisible(true)
		else
			arg_18_0.zhenpinCoolTime = 86400
			var_18_7 = arg_18_0.zhenpinCoolTime
		end
	end))
	var_18_9:addObject(CCDelayTime:create(var_18_8))
	var_18_6:runAction(CCRepeatForever:create(CCSequence:create(var_18_9)))

	local var_18_10 = {
		{
			y = 470,
			type = 1,
			uiName = "guild_text_011.png",
			x = 360,
			color = ccc3(0, 0, 0),
			size = CCSize(160, 40)
		},
		{
			y = 430,
			type = 2,
			uiName = "guild_text_012.png",
			x = 570,
			color = ccc3(255, 241, 139),
			size = CCSize(160, 40)
		},
		{
			y = 95,
			type = 3,
			uiName = "guild_text_014.png",
			x = 115,
			color = ccc3(255, 166, 54),
			size = CCSize(100, 40)
		}
	}

	for iter_18_0 = 1, #var_18_10 do
		local var_18_11 = var_18_10[iter_18_0]
		local var_18_12 = display.newSprite("uilocal/guild/" .. var_18_11.uiName, var_18_11.x, var_18_11.y)

		arg_18_1:addChild(var_18_12)
	end

	if #arg_18_0.zhenpinList < 1 then
		return
	end

	for iter_18_1 = 1, 3 do
		local var_18_13 = arg_18_0.zhenpinList[iter_18_1]

		print(var_18_13.HaveBuyTimes)

		local var_18_14 = var_18_13.HaveBuyTimes > 0
		local var_18_15 = getItemName(var_18_13.RewardItem[1].Type, var_18_13.RewardItem[1].ID)
		local var_18_16 = var_18_13.Price
		local var_18_17 = display.newSprite("ui/guild/guild_022.png", 250 + 190 * iter_18_1, 200)

		arg_18_1:addChild(var_18_17)

		local var_18_18 = {
			type = var_18_13.RewardItem[1].Type,
			itemId = var_18_13.RewardItem[1].ID,
			nameColor = ccc3(239, 232, 195),
			count = var_18_13.RewardItem[1].Count,
			clickAction = function()
				print("点击每日物品 ")
				var_0_1.tipshandler(var_18_13.RewardItem[1])
			end
		}
		local var_18_19 = figure.createHeader(var_18_18)

		var_18_19:setAnchorPoint(CCPoint(0.5, 0.5))
		var_18_19:setPosition(75, 300)
		var_18_17:addChild(var_18_19)

		local var_18_20 = ui.newTTFLabel({
			text = var_18_15,
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(20),
			color = ccc3(245, 255, 10),
			align = ui.TEXT_ALIGN_CENTER,
			valign = ui.TEXT_VALIGN_CENTER,
			dimensions = CCSize(300, 30)
		})

		var_18_20:setAnchorPoint(ccp(0.5, 0.5))
		var_18_20:setPosition(75, 360)
		var_18_17:addChild(var_18_20)

		local var_18_21 = createItemCountNode({
			color = ccc3(245, 255, 10),
			type = var_18_13.PriceType,
			value = var_18_16
		})

		var_18_21:setPosition(ccp(52, 240))
		var_18_21:setAnchorPoint(ccp(0.5, 0.5))
		var_18_17:addChild(var_18_21)

		local var_18_22 = display.newSprite("uilocal/guild/guild_text_013.png", 70, 200)

		var_18_17:addChild(var_18_22)

		local function var_18_23()
			arg_18_0.zhenpinIndex = nil

			if var_18_14 then
				if arg_18_0:unionCoinEnough(var_18_13.Price, var_18_13.PriceType) then
					arg_18_0.buyZhenpinRequest:requestBuyZhenpin(var_18_13.Index)

					arg_18_0.zhenpinIndex = var_18_13.Index
				end
			else
				ui.showMessageBox({
					text = string.lf("该珍品已经卖光了~下手要快呀！T.T")
				})
			end
		end

		local var_18_24 = ui.newControlButton({
			disabledImage = "ui/guild/guild_045.png",
			normalImage = "ui/guild/guild_021.png",
			highlightedImage = "ui/guild/guild_021.png",
			clickAction = var_18_23,
			textColor = ColorTable.eTitleButton_Normal,
			position = ccp(75, 115)
		})

		var_18_17:addChild(var_18_24)
		var_18_24:setEnabled(var_18_14)
	end
end

function var_0_4.showStoreGoods(arg_22_0, arg_22_1)
	arg_22_1:removeAllChildrenWithCleanup(true)

	arg_22_0.tableView = nil
	arg_22_0.tableView = arg_22_0:showStoreGoodsTableView(arg_22_0.fixGoodList)

	arg_22_0.container:addChild(arg_22_0.tableView)
end

function var_0_4.showStoreGoodsTableView(arg_23_0, arg_23_1)
	local var_23_0 = var_0_3.get("GetPlayerGuildInfoRequest")
	local var_23_1 = CCTableView:create(CCSize(600, 600))

	var_23_1:setPosition(600, 250)
	var_23_1:setViewSize(CCSize(600, 490))
	var_23_1:ignoreAnchorPointForPosition(false)
	var_23_1:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_23_1:setDirection(kCCScrollViewDirectionVertical)

	local function var_23_2(arg_24_0)
		return 170, 290
	end

	local function var_23_3(arg_25_0)
		return #arg_23_1 / 2 + (#arg_23_1 % 2 == 1 and 1 or 0)
	end

	local function var_23_4(arg_26_0, arg_26_1)
		local var_26_0 = arg_26_0:cellAtIndex(arg_26_1)

		if var_26_0 == nil then
			var_26_0 = CCTableViewCell:new()

			for iter_26_0 = 1, 2 do
				local var_26_1 = arg_26_1 * 2 + iter_26_0

				if var_26_1 > #arg_23_1 then
					return var_26_0
				end

				local var_26_2 = arg_23_1[var_26_1]
				local var_26_3 = display.newSprite("ui/guild/guild_018.png", (iter_26_0 - 1) * 310, 0)

				var_26_3:setAnchorPoint(CCPoint(0, 0))
				var_26_0:addChild(var_26_3)

				local var_26_4 = {
					type = var_26_2.RewardItem[1].Type,
					itemId = var_26_2.RewardItem[1].ID,
					nameColor = ccc3(239, 232, 195),
					count = var_26_2.RewardItem[1].Count,
					clickAction = function()
						print("点击商城物品 ")
						var_0_1.tipshandler(var_26_2.RewardItem[1])
					end
				}
				local var_26_5 = figure.createHeader(var_26_4)

				var_26_5:setPosition(55, 95)
				var_26_3:addChild(var_26_5)

				local var_26_6 = getItemName(var_26_2.RewardItem[1].Type, var_26_2.RewardItem[1].ID)
				local var_26_7 = var_26_2.HaveBuyTimes >= 0 and string.lf("个人今日限购: %s", var_26_2.HaveBuyTimes) or string.lf("今日不限购")
				local var_26_8 = var_26_2.HaveBuyTimes < 0 or var_26_2.HaveBuyTimes > 0
				local var_26_9 = createItemCountNode({
					color = ccc3(0, 255, 0),
					type = var_26_2.PriceType,
					value = var_26_2.Price
				})
				local var_26_10 = {
					{
						y = 110,
						type = 1,
						x = 105,
						text = var_26_6,
						color = ccc3(0, 0, 0),
						size = CCSize(300, 30)
					},
					{
						y = 88,
						type = 2,
						x = 105,
						text = string.lf("晶石: "),
						color = ccc3(255, 241, 139),
						size = CCSize(300, 30)
					},
					{
						y = 66,
						type = 3,
						x = 105,
						text = var_26_7,
						color = ccc3(255, 241, 139),
						size = CCSize(300, 30)
					},
					{
						y = 44,
						type = 4,
						x = 105,
						text = string.lf("#FFFF00需要#FF0000%d级商店#FFFF00开放", var_26_2.Level),
						color = ccc3(255, 241, 139),
						size = CCSize(300, 30)
					}
				}

				if var_26_2.PriceType == 2 then
					var_26_10[2].text = string.lf("元宝: ")
				end

				var_26_9:setPosition(180, 105)
				var_26_9:setAnchorPoint(ccp(0, 0))
				var_26_3:addChild(var_26_9)

				for iter_26_1 = 1, #var_26_10 do
					local var_26_11 = var_26_10[iter_26_1]

					if iter_26_1 < 4 or var_26_2.Level > var_23_0.ShopLv then
						local var_26_12 = ui.newTTFLabel({
							text = var_26_11.text,
							font = _FONT_DEFAULT,
							size = Adapter.FontSize(17),
							color = ccc3(245, 255, 10),
							align = ui.TEXT_ALIGN_LEFT,
							valign = ui.TEXT_VALIGN_CENTER,
							dimensions = var_26_11.size
						})

						var_26_12:setAnchorPoint(ccp(0, 0))
						var_26_12:setPosition(var_26_11.x, var_26_11.y)
						var_26_3:addChild(var_26_12)
					end
				end

				local function var_26_13()
					if var_23_0.ShopLv < var_26_2.Level then
						showFlashNotice(string.lf("需要%d级商店开放", var_26_2.Level))

						return
					end

					if var_26_8 then
						if arg_23_0:unionCoinEnough(var_26_2.Price, var_26_2.PriceType) then
							arg_23_0.fixGoodIndex = var_26_2.Index

							arg_23_0.buyFixGoodsRequest:requestBuyFixGoods(arg_23_0.fixGoodIndex)

							arg_23_0.lastOffset = var_23_1:getContentOffset()
						end
					else
						ui.showMessageBox({
							text = string.lf("该物品已经卖光了~")
						})
					end
				end

				local var_26_14 = ui.newControlButton({
					text = "",
					normalImage = "ui/guild/guild_019.png",
					highlightedImage = "ui/guild/guild_019.png",
					clickAction = var_26_13,
					textColor = ColorTable.eTitleButton_Normal,
					position = ccp(145, 25)
				})
				local var_26_15 = var_23_0.ShopLv >= var_26_2.Level and "guild_text_016.png" or "guild_text_015.png"
				local var_26_16 = display.newSprite("uilocal/guild/" .. var_26_15, 120, 19)

				var_26_14:addChild(var_26_16)
				var_26_3:addChild(var_26_14)
			end
		end

		return var_26_0
	end

	var_23_1:registerScriptHandler(var_23_2, CCTableView.kTableCellSizeForIndex)
	var_23_1:registerScriptHandler(var_23_3, CCTableView.kNumberOfCellsInTableView)
	var_23_1:registerScriptHandler(var_23_4, CCTableView.kTableCellSizeAtIndex)
	var_23_1:reloadData()

	return var_23_1
end

function var_0_4.showEvilGoods(arg_29_0, arg_29_1)
	arg_29_1:removeAllChildrenWithCleanup(true)

	local var_29_0 = display.newSprite("uilocal/guild/guild_text_009.png", 560, 475)

	arg_29_1:addChild(var_29_0)

	arg_29_0.tableView = nil

	if #arg_29_0.preciousList > 0 then
		arg_29_0.tableView = arg_29_0:showEvilGoodsTableView(arg_29_0.preciousList)

		arg_29_0.container:addChild(arg_29_0.tableView)
	else
		local var_29_1 = display.newSprite("uilocal/guild/guild_text_046.png", 620, 250)

		arg_29_1:addChild(var_29_1)
	end
end

function var_0_4.showEvilGoodsTableView(arg_30_0, arg_30_1)
	local var_30_0 = CCTableView:create(CCSize(600, 600))

	var_30_0:setPosition(600, 225)
	var_30_0:setViewSize(CCSize(600, 450))
	var_30_0:ignoreAnchorPointForPosition(false)
	var_30_0:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_30_0:setDirection(kCCScrollViewDirectionVertical)

	local function var_30_1(arg_31_0)
		return 170, 290
	end

	local function var_30_2(arg_32_0)
		return #arg_30_1 / 2 + (#arg_30_1 % 2 == 1 and 1 or 0)
	end

	local function var_30_3(arg_33_0, arg_33_1)
		local var_33_0 = arg_33_0:cellAtIndex(arg_33_1)

		if var_33_0 == nil then
			var_33_0 = CCTableViewCell:new()

			for iter_33_0 = 1, 2 do
				local var_33_1 = arg_33_1 * 2 + iter_33_0

				if var_33_1 > #arg_30_1 then
					return var_33_0
				end

				local var_33_2 = arg_30_1[var_33_1]
				local var_33_3 = Player.nickName == var_33_2.ActionPlayer
				local var_33_4 = display.newSprite("ui/guild/guild_018.png", (iter_33_0 - 1) * 310, 0)

				var_33_4:setAnchorPoint(CCPoint(0, 0))
				var_33_0:addChild(var_33_4)

				local var_33_5 = {
					type = var_33_2.Reward[1].Type,
					itemId = var_33_2.Reward[1].ID,
					nameColor = ccc3(239, 232, 195),
					count = var_33_2.Reward[1].Count,
					level = var_33_2.Reward[1].Level,
					clickAction = function()
						print("点击商城物品 ")
						var_0_1.tipshandler(var_33_2.Reward[1])
					end
				}
				local var_33_6 = figure.createHeader(var_33_5)

				var_33_6:setPosition(55, 95)
				var_33_4:addChild(var_33_6)

				if var_33_3 then
					local var_33_7 = display.newSprite("ui/guild/guild_020.png", 0, 105)

					var_33_7:setAnchorPoint(CCPoint(0, 0))
					var_33_4:addChild(var_33_7)
				end

				local var_33_8 = getItemName(var_33_2.Reward[1].Type, var_33_2.Reward[1].ID)
				local var_33_9 = ""
				local var_33_10 = ""

				if var_33_2.ActionPlayer ~= nil then
					var_33_9 = string.lf("已有玩家出价")
					var_33_10 = string.lf("最高价: ")
				else
					var_33_9 = string.lf("暂无玩家出价")
					var_33_10 = string.lf("起拍价: ")
				end

				local var_33_11 = {
					{
						y = 110,
						type = 1,
						x = 105,
						text = var_33_8,
						color = ccc3(0, 0, 0),
						size = CCSize(300, 30)
					},
					{
						text = "",
						y = 88,
						type = 2,
						x = 105,
						color = ccc3(255, 241, 139),
						size = CCSize(300, 30)
					},
					{
						y = 66,
						type = 3,
						x = 105,
						text = var_33_9,
						color = ccc3(255, 241, 139),
						size = CCSize(300, 30)
					},
					{
						y = 42,
						type = 4,
						x = 105,
						text = var_33_10,
						color = ccc3(255, 241, 139),
						size = CCSize(300, 30)
					}
				}
				local var_33_12 = createItemCountNode({
					color = ccc3(0, 255, 0),
					type = ItemType.eGuildCoin,
					value = var_33_2.AuctionPrice
				})

				var_33_12:setPosition(180, 56)
				var_33_12:setAnchorPoint(ccp(0, 0))
				var_33_4:addChild(var_33_12)

				for iter_33_1 = 1, #var_33_11 do
					local var_33_13 = var_33_11[iter_33_1]
					local var_33_14 = ui.newTTFLabel({
						text = var_33_13.text,
						font = _FONT_DEFAULT,
						size = Adapter.FontSize(17),
						color = ccc3(245, 255, 10),
						align = ui.TEXT_ALIGN_LEFT,
						valign = ui.TEXT_VALIGN_CENTER,
						dimensions = var_33_13.size
					})

					var_33_14:setAnchorPoint(ccp(0, 0))
					var_33_14:setPosition(var_33_13.x, var_33_13.y)
					var_33_4:addChild(var_33_14)

					if var_33_13.type == 2 then
						local var_33_15 = var_33_2.HaveTimes
						local var_33_16 = 0.5
						local var_33_17 = CCArray:create()

						var_33_17:addObject(CCCallFunc:create(function()
							var_33_15 = var_33_15 - var_33_16

							if var_33_15 > 0 then
								var_33_2.HaveTimes = var_33_15

								local var_35_0, var_35_1, var_35_2, var_35_3 = getDateFromSeconds(var_33_2.HaveTimes)
								local var_35_4 = string.lf("%d天%d:%02d:%02d", var_35_0, var_35_1, var_35_2, var_35_3)

								var_33_14:setString(string.lf("剩余时间: %s", var_35_4))
								var_33_14:setVisible(true)
							else
								var_33_14:setString(string.lf("剩余时间: %s", 0))
								var_33_14:stopAllActions()
								arg_30_0.getPreciousRequest:requestPreciousList()
							end
						end))
						var_33_17:addObject(CCDelayTime:create(var_33_16))
						var_33_14:runAction(CCRepeatForever:create(CCSequence:create(var_33_17)))
					end
				end

				local function var_33_18()
					local var_36_0 = var_0_3.get("GetPlayerGuildInfoRequest")

					if var_33_3 then
						showFlashNotice(string.lf("您已经出价~"))
					elseif var_36_0.PlayerUnionCoin > var_33_2.AuctionPrice then
						local function var_36_1()
							arg_30_0.getPreciousRequest:requestPreciousList()
						end

						local var_36_2 = require("scenes.guild.GivePriceLayer").new({
							goods = var_33_2,
							callback = var_36_1
						})

						arg_30_0:addChild(var_36_2)

						arg_30_0.lastOffset = var_30_0:getContentOffset()
					else
						showFlashNotice(string.lf("晶石不足~"))
					end
				end

				local var_33_19 = ui.newControlButton({
					text = "",
					normalImage = "ui/guild/guild_019.png",
					highlightedImage = "ui/guild/guild_019.png",
					clickAction = var_33_18,
					textColor = ColorTable.eTitleButton_Normal,
					position = ccp(145, 25)
				})
				local var_33_20 = display.newSprite("uilocal/guild/guild_text_008.png", 120, 19)

				var_33_19:addChild(var_33_20)
				var_33_4:addChild(var_33_19)
			end
		end

		return var_33_0
	end

	var_30_0:registerScriptHandler(var_30_1, CCTableView.kTableCellSizeForIndex)
	var_30_0:registerScriptHandler(var_30_2, CCTableView.kNumberOfCellsInTableView)
	var_30_0:registerScriptHandler(var_30_3, CCTableView.kTableCellSizeAtIndex)
	var_30_0:reloadData()

	return var_30_0
end

return var_0_4
