require("network.GuildRequest")

local var_0_0 = require("base.cache")
local var_0_1 = require("scenes.ToolLayer")
local var_0_2 = class("GuildPeachScene", function()
	return display.newScene("GuildPeachScene")
end)

function var_0_2.ctor(arg_2_0)
	arg_2_0.bgSprite = display.newScale9Sprite("ui/peach/peach_1.jpg", display.cx, display.cy)

	arg_2_0.bgSprite:setScaleX(Adapter.AutoScaleX)
	arg_2_0.bgSprite:setScaleY(Adapter.AutoScaleY)
	arg_2_0:addChild(arg_2_0.bgSprite, -2)

	local var_2_0 = CCSprite:create("ui/common/common_061.png"):getTextureRect().size
	local var_2_1 = ui.newControlButton({
		normalImage = "ui/common/common_061.png",
		size = Adapter.MinSize(var_2_0.width, var_2_0.height),
		position = Adapter.AutoPos(900, 600),
		clickAction = function()
			game.enterGuildHomeScene()
		end
	})

	arg_2_0:addChild(var_2_1)
	arg_2_0:initXianTaoInfoNetWork()
	arg_2_0.XianTaoInfoRequest:request()
end

function var_0_2.initXianTaoInfoNetWork(arg_4_0)
	local function var_4_0()
		local var_5_0 = arg_4_0.XianTaoInfoRequest.restable

		dump(var_5_0, "XianTaoInfo")
		arg_4_0:initUI(var_5_0)
	end

	arg_4_0.XianTaoInfoRequest = XianTaoInfoRequest:new()

	arg_4_0.XianTaoInfoRequest:setResponseNormalHandler(var_4_0)
end

function var_0_2.initEatXianTaoNetWork(arg_6_0)
	local function var_6_0()
		local var_7_0 = arg_6_0.EatXianTaoRequest.restable

		dump(var_7_0, "EatXianTao")

		local var_7_1 = CCSkeletonAnimation:createWithFile("ui/peach/ui_taoshu.json", "ui/peach/ui_taoshu.atlas", 1)

		var_7_1:setAnimation("animation", false, 0)
		var_7_1:setScaleX(Adapter.AutoScaleX)
		var_7_1:setScaleY(Adapter.AutoScaleY)
		var_7_1:setPosition(display.cx, display.cy)
		arg_6_0:addChild(var_7_1, -1)

		local function var_7_2()
			local var_8_0 = require("scenes.enhance.DlgResultLayer").new({
				titleText = string.lf("您本次偷吃获得以下物品"),
				rewardList = var_7_0.Reward
			})

			CCDirector:sharedDirector():getRunningScene():addChild(var_8_0, DefaultZOrder.ePopupLayer)
		end

		transition.execute(arg_6_0, transition.sequence({
			CCDelayTime:create(1.5)
		}), {
			onComplete = var_7_2
		})

		local var_7_3 = var_7_0.HaveFreeTime
		local var_7_4 = var_7_3 == 0 and string.lf("下次偷吃需要花费#FF0000%d#F7D35B元宝", var_7_0.Ingot) or string.lf("还可以免费偷吃#00FF00%d次#F7D35B，每次额外获得普通寻访令", var_7_3)

		arg_6_0.eatLabel:setString(var_7_4)
		arg_6_0.haveTiemTips:setString(string.lf("再偷吃#00FF00%d次#F7D35B可获得", var_7_0.HaveTime))

		local var_7_5 = var_7_0.FixReward[1].Type
		local var_7_6 = var_7_0.FixReward[1].ID
		local var_7_7 = var_7_0.FixReward[1].Count

		if arg_6_0.rewardType ~= var_7_5 or arg_6_0.rewardId ~= var_7_6 then
			arg_6_0.rewardType, arg_6_0.rewardId = var_7_5, var_7_6

			if arg_6_0.rewardNode ~= nil then
				arg_6_0.rewardNode:removeFromParentAndCleanup(true)
			end

			arg_6_0.rewardNode = figure.createHeader({
				isName = true,
				inTeam = false,
				itemId = var_7_6,
				type = var_7_5,
				count = var_7_7,
				clickAction = function()
					var_0_1.tipshandler({
						Type = var_7_5,
						ID = var_7_6,
						Count = var_7_7
					})
				end
			})

			arg_6_0.rewardNode:setAnchorPoint(CCPoint(0.5, 0.5))
			arg_6_0.rewardNode:setPosition(Adapter.AutoPos(480, 180))
			arg_6_0:addChild(arg_6_0.rewardNode)
		end

		if var_7_0.Discount < 1 and var_7_0.Discount > 0 then
			if var_7_0.Discount ~= var_0_0.get("GuildPeachDiscountInfo") then
				arg_6_0.btnSteal:removeChildByTag(12)
				var_0_0.set("GuildPeachDiscountInfo", var_7_0.Discount)

				local var_7_8 = var_7_0.Discount * 10
				local var_7_9 = display.newSprite("uilocal/store/icon_sale_" .. var_7_8 .. ".png")

				var_7_9:setRotation(340)
				var_7_9:setScale(Adapter.MinScale * 0.9)
				var_7_9:setPosition(Adapter.AutoPos(30, 50))
				var_7_9:setTag(12)
				arg_6_0.btnSteal:addChild(var_7_9)
			end
		elseif var_7_0.Discount == 1 then
			arg_6_0.btnSteal:removeChildByTag(12)
		end

		arg_6_0.tableview:reloadData(var_7_0.Log)
	end

	arg_6_0.EatXianTaoRequest = EatXianTaoRequest:new()

	arg_6_0.EatXianTaoRequest:setResponseNormalHandler(var_6_0)
end

function var_0_2.income(arg_10_0, arg_10_1)
	local var_10_0 = display.newScale9Sprite("ui/peach/peach_5.png")

	var_10_0:setPreferredSize(Adapter.AutoSize(419, 425))
	var_10_0:setAnchorPoint(CCPoint(0, 1))
	var_10_0:setPosition(Adapter.AutoPos(5, 630))
	arg_10_0:addChild(var_10_0)

	local var_10_1 = Adapter.AutoSize(409, 415)
	local var_10_2 = Adapter.AutoSize(409, 40)

	local function var_10_3(arg_11_0, arg_11_1, arg_11_2)
		local var_11_0 = display.newScale9Sprite("ui/peach/peach_3.png")

		var_11_0:setAnchorPoint(CCPoint(0.5, 0.5))
		var_11_0:setScaleX(Adapter.AutoScaleX)
		var_11_0:setScaleY(Adapter.AutoScaleY)
		var_11_0:setPosition(var_10_2.width / 2, var_10_2.height / 2)

		local var_11_1 = json.decode(arg_11_2)
		local var_11_2 = var_11_1[1]
		local var_11_3 = var_11_2.Count

		table.foreach(var_11_1, function(arg_12_0, arg_12_1)
			if arg_12_0 > 1 then
				var_11_3 = var_11_3 + arg_12_1.Count
			end
		end)

		local var_11_4 = getQualityColor(getItemQuality(var_11_2.Type, var_11_2.ID), true)
		local var_11_5 = getItemName(var_11_2.Type, var_11_2.ID)

		if var_11_2.Type == ItemType.eSoul then
			var_11_5 = var_11_5 .. string.lf("魂魄")
		elseif var_11_2.Type == ItemType.eFragment then
			var_11_5 = var_11_5 .. string.lf("碎片")
		end

		local var_11_6 = string.lf("第%d次偷吃蟠桃，获得%s%sx%s", arg_11_1, var_11_4, var_11_5, var_11_3)

		addLabelWithColorSize(var_11_0, var_11_6, ccc3(247, 211, 91), 20, CCPoint(0, 0.5), CCPoint(0, 15))

		return var_11_0
	end

	local var_10_4 = createTableView({
		reverse = false,
		direction = kCCScrollViewDirectionVertical,
		size = var_10_1,
		dataset = arg_10_1,
		sizehandler = function(arg_13_0, arg_13_1)
			return var_10_2
		end,
		cellhandler = var_10_3
	})

	var_10_4:setPosition(Adapter.AutoPos(5, 5))
	var_10_0:addChild(var_10_4)

	arg_10_0.tableview = var_10_4
end

function var_0_2.rewardThing(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.FixReward[1].Type
	local var_14_1 = arg_14_1.FixReward[1].ID
	local var_14_2 = arg_14_1.FixReward[1].Count

	arg_14_0.rewardType, arg_14_0.rewardId = var_14_0, var_14_1
	arg_14_0.rewardNode = figure.createHeader({
		isName = true,
		inTeam = false,
		itemId = var_14_1,
		type = var_14_0,
		count = var_14_2,
		clickAction = function()
			var_0_1.tipshandler({
				Type = var_14_0,
				ID = var_14_1,
				Count = var_14_2
			})
		end
	})

	arg_14_0.rewardNode:setAnchorPoint(CCPoint(0.5, 0.5))
	arg_14_0.rewardNode:setPosition(Adapter.AutoPos(480, 185))
	arg_14_0:addChild(arg_14_0.rewardNode)

	local var_14_3 = arg_14_1.HaveTime
	local var_14_4 = display.newSprite("ui/peach/peach_2.png")

	var_14_4:setAnchorPoint(CCPoint(0.5, 0.5))
	var_14_4:setPosition(Adapter.AutoPos(480, 250))
	var_14_4:setScale(Adapter.MinScale * 1.3)
	arg_14_0:addChild(var_14_4)

	arg_14_0.haveTiemTips = addLabelWithColorSize(var_14_4, string.lf("再偷吃#00FF00%d次#F7D35B可获得", var_14_3), ccc3(247, 211, 91), 20, CCPoint(0.5, 0.5), CCPoint(80, 15))
end

function var_0_2.initUI(arg_16_0, arg_16_1)
	arg_16_0:income(arg_16_1.Log)
	arg_16_0:rewardThing(arg_16_1)
	arg_16_0:initEatXianTaoNetWork()

	local var_16_0 = CCSprite:create("ui/common/common_105.png"):getTextureRect().size

	arg_16_0.btnSteal = ui.newControlButton({
		normalImage = "ui/common/common_105.png",
		titleImage = "ui/peach/peach_4.png",
		size = Adapter.MinSize(var_16_0.width, var_16_0.height),
		clickAction = function()
			arg_16_0.EatXianTaoRequest:request()
		end
	})

	arg_16_0.btnSteal:setPosition(Adapter.AutoPos(480, 40))
	arg_16_0:addChild(arg_16_0.btnSteal)

	if arg_16_1.Discount < 1 and arg_16_1.Discount > 0 then
		var_0_0.set("GuildPeachDiscountInfo", arg_16_1.Discount)

		local var_16_1 = arg_16_1.Discount * 10
		local var_16_2 = display.newSprite("uilocal/store/icon_sale_" .. var_16_1 .. ".png")

		var_16_2:setRotation(340)
		var_16_2:setScale(Adapter.MinScale * 0.9)
		var_16_2:setPosition(Adapter.AutoPos(35, 50))
		var_16_2:setTag(12)
		arg_16_0.btnSteal:addChild(var_16_2)
	end

	local var_16_3 = display.newSprite("ui/peach/peach_3.png")

	var_16_3:setAnchorPoint(CCPoint(0.5, 0.5))
	var_16_3:setPosition(Adapter.AutoPos(480, 100))
	var_16_3:setScale(Adapter.MinScale)
	arg_16_0:addChild(var_16_3)

	local var_16_4 = var_16_3:getContentSize()
	local var_16_5 = arg_16_1.HaveFreeTime
	local var_16_6 = var_16_5 == 0 and string.lf("下次偷吃需要花费#FF0000%d#F7D35B元宝", arg_16_1.Ingot) or string.lf("还可以免费偷吃#00FF00%d次#F7D35B，每次额外获得普通寻访令", var_16_5)

	arg_16_0.eatLabel = addLabelWithColorSize(var_16_3, var_16_6, ccc3(247, 211, 91), 20, CCPoint(0.5, 0.5), CCPoint(var_16_4.width / 2, 15))
end

return var_0_2
