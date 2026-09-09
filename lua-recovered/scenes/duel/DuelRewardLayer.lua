require("base.figure")
require("network.DuelRequest")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("DuelRewardLayer", function()
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
	arg_2_0.currentScore = arg_2_1.currentScore

	local var_2_0 = display.newScale9Sprite("ui/duel/duel_018.png")

	arg_2_0.bgSize = CCSize(880, 569)

	var_2_0:setPreferredSize(arg_2_0.bgSize)
	var_2_0:setScale(Adapter.MinScale)
	var_2_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_0:setPosition(display.cx, display.cy)
	arg_2_0:addChild(var_2_0)

	arg_2_0.background = CCNode:create()

	arg_2_0.background:setContentSize(arg_2_0.bgSize)
	var_2_0:addChild(arg_2_0.background)

	local var_2_1 = display.newSprite("uilocal/duel/duel_text_018.png")

	var_2_1:setAnchorPoint(ccp(0.5, 0.5))
	var_2_1:setPosition(440, 560)
	var_2_0:addChild(var_2_1)

	local var_2_2 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		highlightedImage = "ui/common/btn_closed.png",
		position = ccp(arg_2_0.bgSize.width - 30, arg_2_0.bgSize.height - 20),
		clickAction = function()
			arg_2_0:removeFromParentAndCleanup(true)
		end
	})

	var_2_0:addChild(var_2_2)
	arg_2_0:initRequests()
	arg_2_0:refreshLayer(arg_2_1)
end

function var_0_1.refreshLayer(arg_5_0, arg_5_1)
	arg_5_0.background:removeAllChildrenWithCleanup(true)
	arg_5_0.duelListRequest:request()
end

function var_0_1.initRequests(arg_6_0)
	local function var_6_0()
		local var_7_0 = arg_6_0.duelListRequest.restable

		if var_7_0 == nil or table.nums(var_7_0) == 0 then
			showFlashNotice(string.lf("暂时没有可领取的奖励"))

			return
		end

		arg_6_0.itemList = var_7_0

		dump(arg_6_0.itemList)
		arg_6_0:showExchangeList()
	end

	arg_6_0.duelListRequest = DuelGetRewardListRequest:new()

	arg_6_0.duelListRequest:setResponseNormalHandler(var_6_0)

	local function var_6_1()
		local var_8_0 = arg_6_0.duelGetRequest.restable

		showFlashNotice(string.lf("领取成功"))

		for iter_8_0, iter_8_1 in pairs(arg_6_0.itemList) do
			if iter_8_1.ID == arg_6_0.currItemId then
				table.remove(arg_6_0.itemList, iter_8_0)

				break
			end
		end

		arg_6_0.tableView:reloadData()

		if arg_6_0.currOffset ~= nil then
			arg_6_0.tableView:setContentOffset(ccp(arg_6_0.currOffset.x, arg_6_0.currOffset.y + 176))
		end
	end

	arg_6_0.duelGetRequest = DuelGetRewardRequest:new()

	arg_6_0.duelGetRequest:setResponseNormalHandler(var_6_1)
end

function var_0_1.showExchangeList(arg_9_0)
	local function var_9_0(arg_10_0)
		return 176, 702
	end

	local function var_9_1(arg_11_0)
		return table.nums(arg_9_0.itemList)
	end

	local function var_9_2(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_0:cellAtIndex(arg_12_1)
		local var_12_1 = arg_9_0.itemList[arg_12_1 + 1]

		if var_12_0 == nil then
			var_12_0 = CCTableViewCell:new()

			local var_12_2 = var_12_1.RewardType == 2 and "duel_017.png" or "duel_016.png"
			local var_12_3 = display.newSprite("ui/duel/" .. var_12_2)
			local var_12_4 = var_12_3:getContentSize()

			var_12_3:setAnchorPoint(CCPoint(0.5, 0.5))
			var_12_3:setPosition(355, 88)
			var_12_0:addChild(var_12_3)
			addLabelWithColorSize(var_12_3, var_12_1.SpanTime, ccc3(255, 255, 0), 22, CCPoint(0, 1), CCPoint(60, var_12_4.height / 2 + 65))

			local var_12_5 = var_12_1.RewardType == 2 and string.lf("本次比赛中获得第%s名") or string.lf("今天获得第%s名奖励")

			addLabelWithColorSize(var_12_3, string.format(var_12_5, var_12_1.Rank), ccc3(235, 210, 20), 22, CCPoint(0, 1), CCPoint(260, var_12_4.height / 2 + 65))

			local var_12_6 = CCSize(110, 140)
			local var_12_7 = CCSize(480, 160)
			local var_12_8 = var_12_1.Reward
			local var_12_9 = createTableView({
				reverse = true,
				size = var_12_7,
				direction = kCCScrollViewDirectionHorizontal,
				dataset = var_12_8,
				sizehandler = function(arg_13_0, arg_13_1)
					return var_12_6
				end,
				cellhandler = function(arg_14_0, arg_14_1, arg_14_2)
					local var_14_0 = CCLayerColor:create(ccc4(0, 0, 0, 0))

					var_14_0:setContentSize(var_12_6)

					local var_14_1

					if arg_14_2.Type == ItemType.eHero or arg_14_2.Type == ItemType.eSoul or arg_14_2.Type == ItemType.eEquip or arg_14_2.Type == ItemType.eFragment or arg_14_2.Type == ItemType.eProp then
						function var_14_1()
							var_0_0.tipshandler(arg_14_2)
						end
					end

					local var_14_2 = figure.createHeader({
						isName = true,
						inTeam = false,
						itemId = arg_14_2.ID ~= nil and arg_14_2.ID or 0,
						type = arg_14_2.Type,
						count = arg_14_2.Count,
						clickAction = var_14_1
					})

					var_14_2:setAnchorPoint(CCPoint(0.5, 0.5))
					var_14_2:setPosition(var_12_6.width / 2, var_12_6.height / 2 + 10)
					var_14_0:addChild(var_14_2)

					return var_14_0
				end
			})

			var_12_9:setPosition(25, 0)
			var_12_0:addChild(var_12_9)

			local var_12_10 = ui.newControlButton({
				fontSize = 25,
				disabledImage = "ui/common/common_078.png",
				normalImage = "ui/common/common_027.png",
				text = string.lf("领取"),
				anchorPoint = CCPoint(0.5, 0.5),
				position = CCPoint(580, var_12_6.height / 2 - 20),
				clickAction = function()
					arg_9_0.currItemId = var_12_1.ID

					arg_9_0.duelGetRequest:request(var_12_1.ID)

					arg_9_0.currOffset = arg_12_0:getContentOffset()
				end
			})

			var_12_3:addChild(var_12_10)
		end

		return var_12_0
	end

	local var_9_3, var_9_4 = var_9_0(nil)

	arg_9_0.tableView = CCTableView:create(CCSize(710, 515))

	arg_9_0.tableView:setContentSize(CCSize(710, var_9_1(nil) * var_9_3))
	arg_9_0.tableView:setPosition((arg_9_0.bgSize.width - 710) / 2, 8)
	arg_9_0.tableView:setVerticalFillOrder(kCCTableViewFillTopDown)
	arg_9_0.tableView:setDirection(kCCScrollViewDirectionVertical)
	arg_9_0.background:addChild(arg_9_0.tableView)
	arg_9_0.tableView:registerScriptHandler(var_9_0, CCTableView.kTableCellSizeForIndex)
	arg_9_0.tableView:registerScriptHandler(var_9_1, CCTableView.kNumberOfCellsInTableView)
	arg_9_0.tableView:registerScriptHandler(var_9_2, CCTableView.kTableCellSizeAtIndex)
	arg_9_0.tableView:reloadData()
	arg_9_0.tableView:setContentOffset(arg_9_0.tableView:minContainerOffset())
end

return var_0_1
