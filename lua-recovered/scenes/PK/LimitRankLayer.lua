require("base.figure")
require("network.PkRequest")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("LimitRankLayer", function()
	return CCLayerColor:create(ccc4(10, 10, 10, 160))
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.scoreCallback = arg_2_1.scoreCallback
	arg_2_0.currentRank = arg_2_1.currentRank

	local var_2_0 = display.newSprite("ui/duel/duel_018.png")

	var_2_0:setScale(Adapter.MinScale)
	var_2_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_0:setPosition(display.cx, display.cy)
	arg_2_0:addChild(var_2_0)

	arg_2_0.background = var_2_0
	arg_2_0.bgSize = var_2_0:getContentSize()

	arg_2_0:initRequests()
	arg_2_0:refreshLayer(arg_2_1)
end

function var_0_1.refreshLayer(arg_4_0, arg_4_1)
	arg_4_0.background:removeAllChildrenWithCleanup(true)

	local var_4_0 = display.newSprite("uilocal/duel/duel_text_018.png", arg_4_0.bgSize.width / 2, arg_4_0.bgSize.height - 10)

	arg_4_0.background:addChild(var_4_0)

	local var_4_1 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		highlightedImage = "ui/common/btn_closed.png",
		position = ccp(arg_4_0.bgSize.width - 30, arg_4_0.bgSize.height - 20),
		clickAction = function()
			arg_4_0:removeFromParentAndCleanup(true)
		end
	})

	arg_4_0.background:addChild(var_4_1)
	arg_4_0.exchangeListRequest:request()
end

function var_0_1.initRequests(arg_6_0)
	local function var_6_0()
		arg_6_0.itemList = arg_6_0.exchangeListRequest.restable

		dump(arg_6_0.itemList, "responseExchangeListSuccess")
		table.sort(arg_6_0.itemList, function(arg_8_0, arg_8_1)
			return arg_8_0.LimitRank > arg_8_1.LimitRank
		end)
		arg_6_0:showExchangeList()
	end

	arg_6_0.exchangeListRequest = LimitRankListRequest:new()

	arg_6_0.exchangeListRequest:setResponseNormalHandler(var_6_0)

	local function var_6_1()
		local var_9_0 = arg_6_0.exchangeItemRequest.restable

		showFlashNotice(string.lf("兑换成功"))

		for iter_9_0, iter_9_1 in ipairs(arg_6_0.itemList) do
			if arg_6_0.currItemId ~= nil and arg_6_0.currItemId == iter_9_1.id then
				table.remove(arg_6_0.itemList, iter_9_0)

				break
			end
		end

		arg_6_0.tableView:reloadData()

		if arg_6_0.currOffset ~= nil then
			arg_6_0.tableView:setContentOffset(arg_6_0.currOffset)

			arg_6_0.currOffset = nil
		end
	end

	arg_6_0.exchangeItemRequest = ExchangeItemRequest:new()

	arg_6_0.exchangeItemRequest:setResponseNormalHandler(var_6_1)
end

function var_0_1.showExchangeList(arg_10_0)
	local function var_10_0(arg_11_0)
		return 180, 702
	end

	local function var_10_1(arg_12_0)
		return table.nums(arg_10_0.itemList)
	end

	local function var_10_2(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_0:cellAtIndex(arg_13_1)
		local var_13_1 = arg_10_0.itemList[arg_13_1 + 1]

		if var_13_0 == nil then
			var_13_0 = CCTableViewCell:new()

			local var_13_2 = display.newSprite("ui/duel/duel_017.png")
			local var_13_3 = var_13_2:getContentSize()

			var_13_2:setAnchorPoint(CCPoint(0.5, 0.5))
			var_13_2:setPosition(351, 90)
			var_13_0:addChild(var_13_2)

			local var_13_4 = string.lf("排名达到第#FF0000 %s #FFFF00名，即可领取以下奖品: ", var_13_1.LimitRank)

			addLabelWithColorSize(var_13_2, var_13_4, ccc3(255, 255, 0), 22, CCPoint(0, 0.5), CCPoint(50, var_13_3.height / 2 + 50))

			for iter_13_0 = 1, table.nums(var_13_1.Reward) do
				local var_13_5 = var_13_1.Reward[iter_13_0]
				local var_13_6 = figure.createHeader({
					type = var_13_5.Type,
					itemId = var_13_5.ID,
					count = var_13_5.Count,
					clickAction = function()
						var_0_0.tipshandler(var_13_5)
					end
				})

				var_13_6:setAnchorPoint(CCPoint(0.5, 0.5))
				var_13_6:setPosition(CCPoint(90 * iter_13_0 + 30 * (iter_13_0 - 1), var_13_3.height / 2 - 20))
				var_13_0:addChild(var_13_6)
			end

			local var_13_7 = ui.newControlButton({
				fontSize = 25,
				disabledImage = "ui/common/common_080.png",
				normalImage = "ui/common/common_019.png",
				text = string.lf("领取"),
				anchorPoint = CCPoint(0.5, 0.5),
				position = CCPoint(600, var_13_3.height / 2 - 10),
				clickAction = function()
					if arg_13_1 >= 2 then
						arg_10_0.currOffset = arg_13_0:getContentOffset()
					end

					arg_10_0.currItemId = var_13_1.id

					arg_10_0.exchangeItemRequest:request(var_13_1.id)
				end
			})

			var_13_7:setEnabled(arg_10_0.currentRank <= var_13_1.LimitRank)
			var_13_2:addChild(var_13_7)
		end

		return var_13_0
	end

	local var_10_3, var_10_4 = var_10_0(nil)
	local var_10_5 = CCTableView:create(CCSize(702, 490))

	var_10_5:setContentSize(CCSize(702, var_10_1(nil) * var_10_3))
	var_10_5:setPosition((arg_10_0.bgSize.width - 702) / 2, 20)
	var_10_5:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_10_5:setDirection(kCCScrollViewDirectionVertical)
	arg_10_0.background:addChild(var_10_5)

	arg_10_0.tableView = var_10_5

	var_10_5:registerScriptHandler(var_10_0, CCTableView.kTableCellSizeForIndex)
	var_10_5:registerScriptHandler(var_10_1, CCTableView.kNumberOfCellsInTableView)
	var_10_5:registerScriptHandler(var_10_2, CCTableView.kTableCellSizeAtIndex)
	var_10_5:reloadData()
	var_10_5:setContentOffset(var_10_5:minContainerOffset())
end

return var_0_1
