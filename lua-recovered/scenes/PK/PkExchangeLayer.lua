require("base.figure")
require("network.PkRequest")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("PkExchangeLayer", function()
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
	arg_2_0.currentRank = arg_2_1.currentRank

	local var_2_0 = display.newScale9Sprite("ui/common/common_040.png")

	arg_2_0.bgSize = CCSize(600, 500)

	var_2_0:setPreferredSize(arg_2_0.bgSize)
	var_2_0:setScale(Adapter.MinScale)
	var_2_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_0:setPosition(display.cx, display.cy)
	arg_2_0:addChild(var_2_0)

	arg_2_0.background = CCNode:create()

	arg_2_0.background:setContentSize(arg_2_0.bgSize)
	var_2_0:addChild(arg_2_0.background)

	local var_2_1 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		highlightedImage = "ui/common/btn_closed.png",
		position = ccp(arg_2_0.bgSize.width - 30, arg_2_0.bgSize.height - 20),
		clickAction = function()
			arg_2_0:removeFromParentAndCleanup(true)
		end
	})

	var_2_0:addChild(var_2_1)
	arg_2_0:initRequests()
	arg_2_0:refreshLayer(arg_2_1)
end

function var_0_1.refreshLayer(arg_5_0, arg_5_1)
	arg_5_0.background:removeAllChildrenWithCleanup(true)
	arg_5_0.exchangeListRequest:request()
end

function var_0_1.initRequests(arg_6_0)
	local function var_6_0()
		arg_6_0.exchangeList = arg_6_0.exchangeListRequest.restable
		arg_6_0.itemList = {}

		local function var_7_0(arg_8_0)
			local var_8_0 = {
				[ItemType.eFragment] = 1,
				[ItemType.eMate] = 2,
				[ItemType.eEquipInheritPoint] = 3
			}

			if var_8_0[arg_8_0] ~= nil then
				return var_8_0[arg_8_0]
			else
				return 100
			end
		end

		table.sort(arg_6_0.exchangeList, function(arg_9_0, arg_9_1)
			if arg_9_0.LimitChallengeTimes ~= arg_9_1.LimitChallengeTimes then
				if arg_9_0.LimitChallengeTimes > 0 and arg_9_1.LimitChallengeTimes > 0 then
					return arg_9_0.LimitChallengeTimes < arg_9_1.LimitChallengeTimes
				else
					return arg_9_0.LimitChallengeTimes > 0
				end
			elseif arg_9_0.LimitContinueWinTimes ~= arg_9_1.LimitContinueWinTimes then
				if arg_9_0.LimitContinueWinTimes > 0 and arg_9_1.LimitContinueWinTimes > 0 then
					return arg_9_0.LimitContinueWinTimes < arg_9_1.LimitContinueWinTimes
				else
					return arg_9_0.LimitContinueWinTimes > 0
				end
			elseif arg_9_0.LimitRank ~= arg_9_1.LimitRank then
				if arg_9_0.LimitRank > 0 and arg_9_1.LimitRank > 0 then
					return arg_9_0.LimitRank > arg_9_1.LimitRank
				else
					return arg_9_0.LimitRank > 0
				end
			elseif arg_9_0.Reward[1].Type ~= arg_9_1.Reward[1].Type then
				return var_7_0(arg_9_0.Reward[1].Type) < var_7_0(arg_9_1.Reward[1].Type)
			else
				return arg_9_0.Reward[1].Count < arg_9_1.Reward[1].Count
			end
		end)
		arg_6_0:filterDatas()
		arg_6_0:showExchangeList()
	end

	arg_6_0.exchangeListRequest = ExchangeListRequest:new()

	arg_6_0.exchangeListRequest:setResponseNormalHandler(var_6_0)

	local function var_6_1()
		local var_10_0 = arg_6_0.exchangeItemRequest.restable

		showFlashNotice(string.lf("兑换成功"))

		local var_10_1 = var_10_0.Consume[1]

		if var_10_1 ~= nil and var_10_1.Type == ItemType.ePKScore and var_10_1.Count > 0 then
			arg_6_0.currentScore = arg_6_0.currentScore - var_10_1.Count
		end

		if arg_6_0.scoreCallback then
			arg_6_0.scoreCallback(arg_6_0.currentScore)
		end

		if var_10_0.Limit == 0 then
			for iter_10_0, iter_10_1 in ipairs(arg_6_0.exchangeList) do
				if arg_6_0.currItemId ~= nil and arg_6_0.currItemId == iter_10_1.id then
					table.remove(arg_6_0.exchangeList, iter_10_0)

					break
				end
			end
		end

		arg_6_0:filterDatas()
		arg_6_0.tableView:reloadData()

		if arg_6_0.currOffset ~= nil then
			arg_6_0.tableView:setContentOffset(arg_6_0.currOffset)

			arg_6_0.currOffset = nil
		end
	end

	arg_6_0.exchangeItemRequest = ExchangeItemRequest:new()

	arg_6_0.exchangeItemRequest:setResponseNormalHandler(var_6_1)
end

function var_0_1.showExchangeList(arg_11_0)
	local function var_11_0(arg_12_0)
		return 120, 560
	end

	local function var_11_1(arg_13_0)
		return table.nums(arg_11_0.itemList)
	end

	local function var_11_2(arg_14_0, arg_14_1)
		local var_14_0 = arg_14_0:cellAtIndex(arg_14_1)
		local var_14_1 = arg_11_0.itemList[arg_14_1 + 1]
		local var_14_2 = var_14_1.Reward[1]

		if var_14_0 == nil then
			var_14_0 = CCTableViewCell:new()

			local var_14_3 = display.newSprite("ui/PK/PK_011.png")
			local var_14_4 = var_14_3:getContentSize()

			var_14_3:setAnchorPoint(CCPoint(0.5, 0.5))
			var_14_3:setPosition(280, 60)
			var_14_0:addChild(var_14_3)

			local var_14_5 = {
				type = var_14_2.Type,
				itemId = var_14_2.ID,
				count = var_14_2.Count,
				clickAction = function()
					var_0_0.tipshandler(var_14_2)
				end
			}
			local var_14_6 = figure.createHeader(var_14_5)

			var_14_6:setAnchorPoint(CCPoint(0.5, 0.5))
			var_14_6:setPosition(CCPoint(80, var_14_4.height / 2))
			var_14_0:addChild(var_14_6)

			local var_14_7 = display.newSprite("ui/PK/PK_012.png")

			var_14_7:setAnchorPoint(CCPoint(0, 0.5))
			var_14_7:setPosition(CCPoint(100, var_14_4.height / 2 + 18))
			var_14_3:addChild(var_14_7)
			addLabelWithColorSize(var_14_3, getItemName(var_14_2.Type, var_14_2.ID) .. "x" .. var_14_2.Count, ccc3(246, 236, 102), 20, CCPoint(0, 0.5), CCPoint(180, var_14_4.height / 2 + 16))

			local var_14_8 = ui.newControlButton({
				fontSize = 25,
				disabledImage = "ui/common/common_078.png",
				normalImage = "ui/common/common_027.png",
				text = string.lf("兑换"),
				anchorPoint = CCPoint(0.5, 0.5),
				position = CCPoint(475, var_14_4.height / 2 + 10),
				clickAction = function()
					if arg_14_1 >= 4 then
						arg_11_0.currOffset = arg_14_0:getContentOffset()
					end

					arg_11_0.currItemId = var_14_1.id

					arg_11_0.exchangeItemRequest:request(var_14_1.id)
				end
			})

			var_14_3:addChild(var_14_8)

			local var_14_9 = addLabelWithColorSize(var_14_3, "", ccc3(34, 21, 7), 18, CCPoint(0.5, 0.5), CCPoint(270, var_14_4.height / 2 - 12))
			local var_14_10 = require("scenes.ProgressBar").new({
				backImage = "ui/common/common_032.png",
				curValue = 1,
				totalValue = 1,
				backSize = CCSize(280, 29),
				barSize = CCSize(238, 10),
				barImages = {
					"ui/common/common_031.png"
				},
				barPosition = ccp(-119, 0)
			})

			var_14_10:setPosition(CCPoint(270, var_14_4.height / 2 - 35))
			var_14_3:addChild(var_14_10)

			if var_14_1.LimitChallengeTimes > 0 then
				var_14_9:setString(string.lf("需完成挑战 %d次", var_14_1.LimitChallengeTimes))
				var_14_10:setProgressValue(1, var_14_1.TotalChallengeTimes, var_14_1.MaxLimitChallengeTimes)
				var_14_8:setEnabled(var_14_1.TotalChallengeTimes >= var_14_1.LimitChallengeTimes and true or false)
			elseif var_14_1.LimitContinueWinTimes > 0 then
				var_14_9:setString(string.lf("需连胜 %d场", var_14_1.LimitContinueWinTimes))
				var_14_10:setProgressValue(1, var_14_1.HighestContinueWinTimes, var_14_1.MaxLimitContinueWinTimes)
				var_14_8:setEnabled(var_14_1.HighestContinueWinTimes >= var_14_1.LimitContinueWinTimes and true or false)
			elseif var_14_1.LimitRank > 0 then
				var_14_9:setString(string.lf("需排名达到第 %d 名，现在是第 %d 名", var_14_1.LimitRank, arg_11_0.currentRank))
				var_14_9:setPosition(300, var_14_4.height / 2 - 35)
				var_14_10:setVisible(false)
				var_14_8:setEnabled(arg_11_0.currentRank <= var_14_1.LimitRank and true or false)
			else
				var_14_9:setString(string.lf("需 %d 积分", var_14_1.Score))
				var_14_10:setProgressValue(1, arg_11_0.currentScore, var_14_1.Score)
				var_14_8:setEnabled(arg_11_0.currentScore >= var_14_1.Score and true or false)
			end
		end

		return var_14_0
	end

	local var_11_3, var_11_4 = var_11_0(nil)
	local var_11_5 = CCTableView:create(CCSize(560, 445))

	var_11_5:setContentSize(CCSize(560, var_11_1(nil) * var_11_3))
	var_11_5:setPosition((arg_11_0.bgSize.width - 560) / 2, 4)
	var_11_5:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_11_5:setDirection(kCCScrollViewDirectionVertical)
	arg_11_0.background:addChild(var_11_5)

	arg_11_0.tableView = var_11_5

	var_11_5:registerScriptHandler(var_11_0, CCTableView.kTableCellSizeForIndex)
	var_11_5:registerScriptHandler(var_11_1, CCTableView.kNumberOfCellsInTableView)
	var_11_5:registerScriptHandler(var_11_2, CCTableView.kTableCellSizeAtIndex)
	var_11_5:reloadData()
	var_11_5:setContentOffset(var_11_5:minContainerOffset())
end

function var_0_1.filterDatas(arg_17_0)
	local var_17_0 = false
	local var_17_1 = false
	local var_17_2 = false

	arg_17_0.itemList = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.exchangeList) do
		if iter_17_1.LimitChallengeTimes > 0 then
			if var_17_0 == false then
				var_17_0 = true

				table.insert(arg_17_0.itemList, iter_17_1)
			end
		elseif iter_17_1.LimitContinueWinTimes > 0 then
			if var_17_1 == false then
				var_17_1 = true

				table.insert(arg_17_0.itemList, iter_17_1)
			end
		elseif iter_17_1.LimitRank > 0 then
			if var_17_2 == false then
				var_17_2 = true

				table.insert(arg_17_0.itemList, iter_17_1)
			end
		else
			table.insert(arg_17_0.itemList, iter_17_1)
		end
	end
end

return var_0_1
