require("data.player")
require("base.figure")
require("base.functions")
require("network.PropRequest")
require("network.StoreRequest")

local var_0_0 = require("scenes.toollayer.tool")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = require("scenes.ToolLayer")
local var_0_3 = 4
local var_0_4 = 5
local var_0_5 = 15
local var_0_6
local var_0_7
local var_0_8 = class("BagLayer", function()
	return display.newLayer()
end)

var_0_8.eShowReward = 0
var_0_8.eOpenBox = 1
var_0_8.eOepnHero = 2

function var_0_8.ctor(arg_2_0)
	arg_2_0:initBagRequest()

	arg_2_0.pageData = {}
	arg_2_0.openable = var_0_8.eShowReward
	var_0_6 = {
		id = 0,
		node = false,
		index = 0,
		page = 0
	}
	var_0_7 = {}

	arg_2_0:initLayer()
end

function var_0_8.initLayer(arg_3_0)
	local var_3_0 = CCScale9Sprite:create("ui/bag/bag_001.jpg")

	var_3_0:setPreferredSize(CCSize(598, 562))
	var_3_0:setAnchorPoint(CCPoint(0, 0))
	var_3_0:setPosition(8, 5)
	arg_3_0:addChild(var_3_0)

	arg_3_0.container = var_3_0
	arg_3_0.sliderLayer = arg_3_0:createSliderLayer()

	arg_3_0.sliderLayer:setPosition(4, 90)
	arg_3_0.container:addChild(arg_3_0.sliderLayer)
	arg_3_0:reload()

	local var_3_1 = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		text = string.lf("进入商城"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_4_0, arg_4_1)
			game.enterStoreScene({
				returnAction = game.enterBagScene
			})
		end
	})
	local var_3_2 = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		text = string.lf("查看装备"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_5_0, arg_5_1)
			game.enterEnhanceScene({
				returnAction = game.enterBagScene
			})
		end
	})

	var_3_1:setPosition(160, 45)
	var_3_2:setPosition(450, 45)
	arg_3_0.container:addChild(var_3_1)
	arg_3_0.container:addChild(var_3_2)
end

function var_0_8.initBagRequest(arg_6_0)
	arg_6_0.usePropRequest = UsePropRequest:new()

	arg_6_0.usePropRequest:setResponseNormalHandler(function()
		local var_7_0 = arg_6_0.usePropRequest:getResponseContent()
		local var_7_1 = var_7_0.Reward
		local var_7_2 = var_7_0.Response

		if var_7_1 and #var_7_1 > 0 then
			if var_7_2 == nil then
				if arg_6_0.openable == var_0_8.eOpenBox then
					arg_6_0:openTreasureBox(var_7_1)
				elseif arg_6_0.openable == var_0_8.eOpenHero then
					local var_7_3 = require("scenes.store.DlgStoreHeroLayer").new({
						heroData = var_7_0,
						repeatCallback = repeatCallback,
						closeCallback = closeCallback
					})

					CCDirector:sharedDirector():getRunningScene():addChild(var_7_3)
				end

				arg_6_0.usePropRequest.isNoticeReward = true
			elseif #var_7_2 > 0 then
				local var_7_4 = require("scenes.store.DlgStoreTenHeroesLayer").new({
					retInfo = {
						Type = 4,
						TenLst = var_7_2
					}
				})

				var_7_4:setAnchorPoint(ccp(0, 0))
				CCDirector:sharedDirector():getRunningScene():addChild(var_7_4)

				arg_6_0.usePropRequest.isNoticeReward = true
			end
		elseif arg_6_0.endback then
			arg_6_0.endback()

			arg_6_0.endback = false
		else
			showFlashImage({
				scale = 0.8,
				image = "uilocal/enhance/enhance_txt_007.png",
				parent = arg_6_0.container,
				position = CCPoint(795, 100)
			})
		end

		print("成功使用道具")
		arg_6_0:reload()
	end)
	arg_6_0.usePropRequest:setResponseExceptionHandler(function()
		print("使用道具发生错误")
		arg_6_0:reload()
	end)

	arg_6_0.sellPropRequest = SellPropRequest:new(arg_6_0)

	arg_6_0.sellPropRequest:setResponseNormalHandler(function()
		print("成功出售道具")
		arg_6_0:reload()
	end)
	arg_6_0.sellPropRequest:setResponseExceptionHandler(function()
		print("出售道具发生错误")
		arg_6_0:reload()
	end)
end

function var_0_8.createSliderLayer(arg_11_0)
	return (require("scenes.SliderLayer").new({
		navOffSprite = "ui/common/common_047.png",
		navOnSprite = "ui/common/common_048.png",
		navMargin = 30,
		size = CCSize(588, 475),
		point = ccp(0, 0),
		clipScaleX = Adapter.MinScale,
		clipScaleY = Adapter.MinScale,
		numberHandler = handler(arg_11_0, arg_11_0.pageCount),
		cellHandler = handler(arg_11_0, arg_11_0.createSlideCellView),
		changedHandler = function(arg_12_0)
			local var_12_0 = arg_11_0:createDataPage(arg_12_0)

			arg_11_0.pageData[arg_12_0] = var_12_0

			if var_0_6.node then
				if not tolua.isnull(var_0_6.node) then
					var_0_6.node:setSelected(false)
				end

				var_0_6.node = false
			end

			var_0_6.index = 1

			for iter_12_0, iter_12_1 in ipairs(var_12_0) do
				if var_0_6.id == iter_12_1.ID then
					var_0_6.index = iter_12_0

					break
				end
			end

			var_0_6.node = var_0_7[arg_12_0][var_0_6.index]

			var_0_6.node:setSelected(true)

			var_0_6.page = arg_12_0

			arg_11_0:showPropView(arg_11_0.pageData[arg_12_0][var_0_6.index])
		end,
		direction = SliderDirection.eHorizontal,
		navPosition = ccp(220, 0)
	}))
end

function var_0_8.reload(arg_13_0)
	arg_13_0.sliderLayer:reloadData()
end

function var_0_8.pageCount(arg_14_0)
	local var_14_0 = 0
	local var_14_1 = {}
	local var_14_2 = false
	local var_14_3 = 0
	local var_14_4 = 0

	for iter_14_0, iter_14_1 in ipairs(Player.bag) do
		local var_14_5 = false
		local var_14_6, var_14_7 = iter_14_1.Type, iter_14_1.ID

		if var_14_6 == ItemType.eProp then
			var_14_5 = true
		elseif var_14_6 == ItemType.eMate and BaseMates[var_14_7].mateType ~= PropType.eShenQiUpdate then
			var_14_5 = true
		end

		if var_14_5 then
			if iter_14_1.Count > GameMaxNum.ePropPile then
				iter_14_1 = clone(iter_14_1)
			end

			while iter_14_1.Count > GameMaxNum.ePropPile do
				local var_14_8 = clone(iter_14_1)

				var_14_8.Count = GameMaxNum.ePropPile
				iter_14_1.Count = iter_14_1.Count - GameMaxNum.ePropPile

				table.insert(var_14_1, var_14_8)
			end

			table.insert(var_14_1, iter_14_1)
		end
	end

	local var_14_9 = math.ceil(#var_14_1 / (var_0_3 * var_0_4))

	if var_14_9 == 0 then
		var_14_9 = 1
	end

	arg_14_0.proplist = var_14_1

	return var_14_9
end

function var_0_8.createSlideCellView(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = CCNode:create()
	local var_15_1 = arg_15_0:createDataPage(arg_15_2)

	arg_15_0.pageData[arg_15_2] = var_15_1

	for iter_15_0 = 1, var_0_3 * var_0_4 do
		local var_15_2, var_15_3 = arg_15_0:createHeaderByIndex(iter_15_0, var_15_1[iter_15_0], arg_15_2)

		var_15_0:addChild(var_15_2)
	end

	var_15_0:setPosition(25, 0)
	arg_15_1:addChild(var_15_0)
end

function var_0_8.createDataPage(arg_16_0, arg_16_1)
	local var_16_0 = {}
	local var_16_1 = var_0_3 * var_0_4 * (arg_16_1 - 1) + 1
	local var_16_2 = var_0_3 * var_0_4 * arg_16_1
	local var_16_3 = 0

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.proplist) do
		var_16_3 = var_16_3 + 1

		if var_16_1 <= var_16_3 and var_16_3 <= var_16_2 then
			table.insert(var_16_0, iter_16_1)
		end
	end

	return var_16_0
end

function var_0_8.createHeaderByIndex(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = math.floor((arg_17_1 - 1) / var_0_4)
	local var_17_1 = 46 + (arg_17_1 - 1 - var_17_0 * var_0_4) * 111
	local var_17_2 = 400 - var_17_0 * 110

	arg_17_2 = arg_17_2 or {
		ID = 0,
		Count = 0,
		Type = ItemType.eProp
	}

	local var_17_3

	var_17_3 = figure.createHeader({
		type = arg_17_2.Type,
		itemId = arg_17_2.ID,
		count = arg_17_2.Count,
		clickAction = function()
			var_0_6.node:setSelected(false)

			var_0_6.node = var_17_3
			var_0_6.index = arg_17_1
			var_0_6.id = arg_17_2.ID

			var_17_3:setSelected(true)
			arg_17_0:showPropView(arg_17_2)
		end
	})

	var_17_3:setPosition(var_17_1, var_17_2)
	var_17_3.headerButton:setEnabled(arg_17_2.ID ~= 0)

	if not var_0_7[arg_17_3] then
		var_0_7[arg_17_3] = {}
	end

	var_0_7[arg_17_3][arg_17_1] = var_17_3

	return var_17_3, var_17_3.countNode and var_17_3.countNode.numLabel or nil
end

function var_0_8.showPropView(arg_19_0, arg_19_1)
	if arg_19_1 == nil then
		return
	end

	if arg_19_0.propview then
		if arg_19_1 and arg_19_1.ID == arg_19_0.propview.prop_id and arg_19_1.Count == arg_19_0.propview.prop_count then
			return
		end

		arg_19_0.propview:removeFromParent()
	end

	local var_19_0 = arg_19_0:createPropView(arg_19_1)

	var_19_0:setPosition(770, 281)
	arg_19_0.container:addChild(var_19_0)

	arg_19_0.propview = var_19_0
	var_19_0.prop_id = arg_19_1.ID
	var_19_0.prop_count = arg_19_1.Count
end

function var_0_8.createPropView(arg_20_0, arg_20_1)
	local var_20_0 = display.newSprite("ui/bag/bag_002.jpg")
	local var_20_1 = var_20_0:getContentSize()

	if not arg_20_1 then
		return var_20_0
	end

	local var_20_2

	if arg_20_1.Type == ItemType.eProp then
		var_20_2 = BaseProps[arg_20_1.ID]
	else
		var_20_2 = BaseMates[arg_20_1.ID]
	end

	local var_20_3 = display.newSprite("ui/bag/bag_003.png")
	local var_20_4 = var_20_3:getContentSize()

	var_20_3:setPosition(var_20_1.width / 2, 420)
	var_20_0:addChild(var_20_3)

	local var_20_5 = display.newSprite("body/" .. var_20_2.bodyImage)

	var_20_5:setPosition(var_20_4.width / 2, var_20_4.height / 2)
	var_20_3:addChild(var_20_5)

	local var_20_6 = var_0_1.newLabel({
		size = 28,
		outline = true,
		text = var_20_2.name,
		color = getQualityColor(var_20_2.quality)
	})
	local var_20_7 = var_20_6:getContentSize()

	var_20_6:setPosition(var_20_1.width / 2, 310)
	var_20_0:addChild(var_20_6)

	local var_20_8 = var_0_1.newLabel({
		size = 20,
		text = string.lf("道具数量：%s", arg_20_1.Count),
		color = ccc3(53, 26, 1)
	})

	var_20_8:align(display.LEFT_CENTER, 60, 270)
	var_20_0:addChild(var_20_8)

	local var_20_9 = var_0_1.newLabel({
		size = 20,
		text = string.lf("出售价格："),
		color = ccc3(53, 26, 1)
	})
	local var_20_10 = {
		type = ItemType.eCoin,
		value = var_20_2.sellPrice,
		color = ccc3(53, 26, 1)
	}
	local var_20_11 = createItemCountNode(var_20_10)

	var_20_9:align(display.LEFT_CENTER, 60, 230)
	var_20_11:setPosition(var_20_1.width / 2, 230)
	var_20_0:addChild(var_20_9)
	var_20_0:addChild(var_20_11)

	local var_20_12 = var_0_1.newLabel({
		size = 20,
		text = var_20_2.desc,
		color = ccc3(53, 26, 1),
		dimensions = CCSize(220, 250),
		valign = ui.TEXT_VALIGN_TOP
	})

	var_20_12:setAnchorPoint(ccp(0.5, 1))
	var_20_12:setPosition(var_20_1.width / 2, 188)
	var_20_0:addChild(var_20_12)

	local var_20_13 = false
	local var_20_14 = false
	local var_20_15 = false
	local var_20_16 = 0
	local var_20_17 = string.lf("出售")
	local var_20_18 = string.lf("使用")
	local var_20_19 = string.lf("合成")

	if arg_20_1.Type == ItemType.eMate and BaseMates[arg_20_1.ID].mateType == PropType.eGeneralSoulFrag then
		var_20_15 = true
	end

	if arg_20_1.Type == ItemType.eProp then
		local var_20_20 = BaseProps[arg_20_1.ID]

		var_20_13 = ({
			[PropType.eEnergy] = true,
			[PropType.eDoubleExp] = true,
			[PropType.eDoubleSkill] = true,
			[PropType.eExp] = true,
			[PropType.eKnowledge] = true,
			[PropType.eTreasureBox] = true,
			[PropType.eChangeName] = true,
			[PropType.eRandomGift] = true,
			[PropType.eFixGift] = true,
			[PropType.ePotencyPill] = true,
			[PropType.eKey] = true,
			[PropType.eSoulBagFrag] = true,
			[PropType.eZhuanShuLibao] = true,
			[PropType.eVipZhuanShuLibao1] = true,
			[PropType.eVipZhuanShuLibao2] = true,
			[PropType.eVipRandomGift] = true,
			[PropType.eTenHeroGift] = true
		})[var_20_20.propType]
		var_20_16 = Player:getItemCount(ItemType.eProp, arg_20_1.ID)

		if var_20_20.propType == PropType.eTreasureBox or var_20_20.propType == PropType.eKey or var_20_20.propType == PropType.eZhuanShuLibao then
			var_20_14 = true

			if var_20_16 > 9 then
				var_20_16 = 10
				var_20_17 = string.lf("开十次")
			else
				var_20_17 = string.lf("全开")
			end
		elseif var_20_20.propType == PropType.eExp then
			var_20_14 = true
			var_20_16 = math.min(var_20_16, 999)
			var_20_17 = string.lf("全用")
		end
	end

	local var_20_21 = ui.newControlButton({
		disabledImage = "ui/common/common_018.png",
		normalImage = "ui/common/common_018.png",
		highlightedImage = "ui/common/common_018.png",
		text = var_20_17,
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_21_0, arg_21_1)
			if var_20_14 then
				arg_20_0:usehandler(arg_20_1, var_20_16)
			else
				arg_20_0:salehandler(arg_20_1.Type, arg_20_1.ID)
			end
		end
	})

	var_20_0:addChild(var_20_21)

	if var_20_13 then
		local var_20_22 = ui.newControlButton({
			disabledImage = "ui/common/common_018.png",
			normalImage = "ui/common/common_018.png",
			highlightedImage = "ui/common/common_018.png",
			text = var_20_18,
			fontSize = ColorTable.eTitleButton_FontSize,
			textColor = ColorTable.eTitleButton_Normal,
			clickAction = function(arg_22_0, arg_22_1)
				arg_20_0:usehandler(arg_20_1)
			end
		})

		var_20_22:setPosition(var_20_1.width / 2 - 65, 50)
		var_20_0:addChild(var_20_22)
		var_20_21:setPosition(var_20_1.width / 2 + 65, 50)
	else
		var_20_21:setPosition(var_20_1.width / 2, 50)
	end

	if var_20_15 then
		local var_20_23 = ui.newControlButton({
			disabledImage = "ui/common/common_018.png",
			normalImage = "ui/common/common_018.png",
			highlightedImage = "ui/common/common_018.png",
			text = var_20_19,
			fontSize = ColorTable.eTitleButton_FontSize,
			textColor = ColorTable.eTitleButton_Normal,
			clickAction = function(arg_23_0, arg_23_1)
				arg_20_0:hechengHandler(arg_20_1)
			end
		})

		var_20_23:setPosition(var_20_1.width / 2 - 65, 50)
		var_20_0:addChild(var_20_23)
		var_20_21:setPosition(var_20_1.width / 2 + 65, 50)
	end

	return var_20_0
end

function var_0_8.hechengHandler(arg_24_0, arg_24_1)
	if not arg_24_1 then
		return
	end

	if arg_24_1.Type == ItemType.eMate and BaseMates[arg_24_1.ID].mateType == PropType.eGeneralSoulFrag then
		arg_24_0.usePropRequest:requestPotencyProp(arg_24_1.ID)
	end
end

function var_0_8.usehandler(arg_25_0, arg_25_1, arg_25_2)
	arg_25_2 = arg_25_2 or 1

	local var_25_0 = arg_25_1.ID
	local var_25_1 = Player:getItemCount(ItemType.eProp, var_25_0)
	local var_25_2 = BaseProps[var_25_0]
	local var_25_3 = var_25_2.propType
	local var_25_4 = var_25_2.propValue
	local var_25_5 = true
	local var_25_6 = var_0_8.eShowReward

	if var_25_3 == PropType.eKey or var_25_3 == PropType.eTreasureBox then
		local var_25_7 = Player:getItemCount(ItemType.eProp, var_25_4)

		if var_25_7 < 1 then
			var_25_5 = false

			var_0_2.createDialog({
				show = var_0_2.eShowOpenFailed,
				id = var_25_0
			}):show()
		else
			var_25_6 = var_0_8.eOpenBox
		end

		if var_25_1 < arg_25_2 or arg_25_2 == 10 and var_25_7 < arg_25_2 then
			var_25_5 = false

			showFlashNotice("道具数量不足")
		elseif var_25_7 > 0 and var_25_7 < arg_25_2 then
			arg_25_2 = var_25_7
		end
	elseif var_25_3 == PropType.eTenHeroGift then
		-- block empty
	elseif var_25_3 == PropType.eChangeName then
		var_25_5 = false

		var_0_2.createDialog({
			show = var_0_2.eShowChangeName,
			callback = function(arg_26_0, arg_26_1)
				if arg_26_0 then
					arg_25_0:reload()
					showFlashNotice(string.lf("昵称修改成功！"))
				end
			end
		}):show()
	elseif var_25_3 == PropType.eRandomGift or var_25_3 == PropType.eFixGift or var_25_3 == PropType.eZhuanShuLibao or var_25_3 == PropType.eVipZhuanShuLibao1 or var_25_3 == PropType.eVipZhuanShuLibao2 or var_25_3 == PropType.eVipRandomGift then
		var_25_6 = var_0_8.eOpenBox
	elseif var_25_3 == PropType.eSoulBagFrag then
		var_25_6 = var_0_8.eOpenHero
		var_25_5 = var_25_4 <= var_25_1
	elseif var_25_3 == PropType.ePotencyPill then
		var_0_2.createDialog({
			type = var_25_3,
			show = var_0_2.eShowHeroList,
			title = {
				size = 24,
				text = string.lf("请选择服用的战将"),
				color = ccc3(188, 150, 78)
			},
			callback = function(arg_27_0, arg_27_1)
				var_0_2.createDialog({
					id = var_25_0,
					propType = var_25_3,
					show = var_0_2.eUsePotencyPill,
					title = {
						size = 24,
						text = string.lf("请选择服用的数量"),
						color = ccc3(188, 150, 78)
					},
					callback = function(arg_28_0)
						if arg_28_0 > 0 then
							arg_25_0.usePropRequest:requestPotencyProp(var_25_0, arg_28_0, arg_27_0)
						else
							showFlashNotice(string.lf("请至少选择1个或更多的数量"))
						end
					end
				}):show()
			end
		}):show()

		var_25_5 = false
	else
		local var_25_8 = ({
			[PropType.eSuperCatchToken] = game.enterSlaveScene,
			[PropType.eChangeName] = game.enterNicknameScene,
			[PropType.ePotencyPill] = game.enterTeamScene
		})[var_25_3]

		if var_25_8 then
			return var_25_8({
				from = 0
			})
		end

		var_25_6 = var_0_8.eShowReward
	end

	arg_25_0.openable = var_25_6
	arg_25_0.usePropRequest.isNoticeReward = var_25_6 == var_0_8.eShowReward

	if var_25_3 == PropType.eTenHeroGift then
		arg_25_0.usePropRequest.isNoticeReward = false
	end

	if var_25_6 == var_0_8.eShowReward or isEquipCountNotMax() then
		return var_25_5 and arg_25_0.usePropRequest:requestUseProp(var_25_0, arg_25_2)
	end
end

function var_0_8.salehandler(arg_29_0, arg_29_1, arg_29_2)
	var_0_2.createDialog({
		show = var_0_2.eShowPropSell,
		data = {
			id = arg_29_2,
			type = arg_29_1
		},
		callback = function(arg_30_0)
			arg_29_0.sellPropRequest:requestSellProp(arg_29_2, arg_30_0)
		end
	}):show()
end

function var_0_8.createRewardNode(arg_31_0, arg_31_1)
	local var_31_0 = CCSize(120, 120)
	local var_31_1 = var_0_1.newNode()

	var_31_1:setContentSize(var_31_0)

	local var_31_2 = figure.createHeader({
		isName = true,
		type = arg_31_1.Type,
		itemId = arg_31_1.ID,
		count = arg_31_1.Count
	})

	var_31_2:setPosition(var_31_0.width / 2, var_31_0.height / 2 + 10)
	var_31_1:addChild(var_31_2)

	return var_31_1
end

function var_0_8.boxAnimate(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = CCSkeletonAnimation:createWithFile("effectAni/ui_kaibaoxiang.json", "effectAni/ui_kaibaoxiang.atlas", 1)

	var_32_0:setScale(Adapter.MinScale)
	var_32_0:setPosition(display.cx, display.cy)
	arg_32_1:addChild(var_32_0)
	var_32_0:addAnimation("a1", false, 0, 0)
	var_32_0:addAnimation("a2", true, 0, 0)
	var_0_0.wait("time", 2.8, arg_32_2)
end

function var_0_8.rewardAnimate(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = arg_33_1:getContentSize()
	local var_33_1 = ccp(var_33_0.width / 2, var_33_0.height + 120)

	var_0_0.foreach(arg_33_2, function(arg_34_0, arg_34_1, arg_34_2)
		if arg_34_1 then
			local var_34_0, var_34_1 = arg_34_1:getPosition()
			local var_34_2 = CCArray:create()

			var_34_2:addObject(CCMoveTo:create(0.2, ccp(var_34_0, var_34_1)))
			var_34_2:addObject(CCCallFunc:create(arg_34_2))
			arg_34_1:setPosition(var_33_1)
			arg_34_1:setVisible(true)
			arg_34_1:setZOrder(arg_34_0)
			arg_34_1:runAction(CCSequence:create(var_34_2))
		else
			arg_34_2()
		end
	end, arg_33_3)
end

function var_0_8.openTreasureBox(arg_35_0, arg_35_1)
	local var_35_0 = false
	local var_35_1 = CCLayerColor:create(ccc4(10, 10, 10, 200))
	local var_35_2
	local var_35_3 = {}

	for iter_35_0, iter_35_1 in ipairs(arg_35_1) do
		local var_35_4 = arg_35_0:createRewardNode(iter_35_1)

		var_35_4:setVisible(false)
		table.insert(var_35_3, var_35_4)
	end

	local var_35_5 = var_0_1.tableLayout({
		row = 0,
		spacing = 10,
		col = 4,
		nodes = var_35_3,
		padding = {
			top = 0,
			bottom = 0,
			left = 10,
			right = 10
		}
	})

	arg_35_0:boxAnimate(var_35_1, function()
		arg_35_0:rewardAnimate(var_35_5, var_35_3, function()
			var_35_0 = true
		end)
	end)
	var_35_5:setAnchorPoint(ccp(0.5, 0.5))
	var_35_5:setScale(Adapter.MinScale)
	var_35_5:setPosition(display.cx, display.cy - 60)
	var_35_1:addChild(var_35_5)
	var_35_1:addTouchEventListener(function()
		if var_35_0 then
			var_35_1:removeFromParent()
		end
	end, false, 1, true)
	var_35_1:setTouchEnabled(true)
	CCDirector:sharedDirector():getRunningScene():addChild(var_35_1)
end

return var_0_8
