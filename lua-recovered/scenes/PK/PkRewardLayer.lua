require("base.figure")
require("network.PkRequest")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("PkRewardLayer", function()
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
	arg_5_0.scoreListRequest:request()
end

function var_0_1.initRequests(arg_6_0)
	local function var_6_0()
		local var_7_0 = arg_6_0.scoreListRequest.restable

		if var_7_0 == nil or table.nums(var_7_0) == 0 then
			showFlashNotice(string.lf("暂时没有可领取的积分"))

			return
		end

		arg_6_0.itemList = var_7_0

		arg_6_0:showExchangeList()
	end

	arg_6_0.scoreListRequest = ScoreListRequest:new()

	arg_6_0.scoreListRequest:setResponseNormalHandler(var_6_0)

	local function var_6_1()
		local var_8_0 = arg_6_0.scoreGetRequest.restable

		showFlashNotice(string.lf("领取成功"))

		arg_6_0.currentScore = arg_6_0.currentScore + arg_6_0.getScore

		if arg_6_0.scoreCallback then
			arg_6_0.scoreCallback(arg_6_0.currentScore)
		end

		for iter_8_0, iter_8_1 in pairs(arg_6_0.itemList) do
			if iter_8_1.Id == arg_6_0.currItemId then
				table.remove(arg_6_0.itemList, iter_8_0)

				break
			end
		end

		arg_6_0.tableView:reloadData()

		if arg_6_0.currOffset ~= nil then
			arg_6_0.tableView:setContentOffset(arg_6_0.currOffset)

			arg_6_0.currOffset = nil
		end
	end

	arg_6_0.scoreGetRequest = ScoreGetRequest:new()

	arg_6_0.scoreGetRequest:setResponseNormalHandler(var_6_1)
end

function var_0_1.showExchangeList(arg_9_0)
	local function var_9_0(arg_10_0)
		return 120, 560
	end

	local function var_9_1(arg_11_0)
		return table.nums(arg_9_0.itemList)
	end

	local function var_9_2(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_0:cellAtIndex(arg_12_1)
		local var_12_1 = arg_9_0.itemList[arg_12_1 + 1]

		if var_12_0 == nil then
			var_12_0 = CCTableViewCell:new()

			local var_12_2 = display.newSprite("ui/PK/PK_011.png")
			local var_12_3 = var_12_2:getContentSize()

			var_12_2:setAnchorPoint(CCPoint(0.5, 0.5))
			var_12_2:setPosition(280, 60)
			var_12_0:addChild(var_12_2)

			local var_12_4 = display.newSprite(getItemHeaderImagePath(ItemType.ePKScore, nil), 80, var_12_3.height / 2 + 5)

			var_12_0:addChild(var_12_4)
			addLabelWithColorSize(var_12_2, var_12_1.Time, ccc3(0, 255, 0), 20, CCPoint(0, 1), CCPoint(130, var_12_3.height / 2 + 45))

			local var_12_5 = addLabelWithColorSize(var_12_2, var_12_1.Content, ccc3(34, 21, 7), 18, CCPoint(0, 1), CCPoint(130, var_12_3.height / 2 + 17))

			var_12_5:setDimensions(CCSize(300, var_12_3.height / 2 + 20))
			var_12_5:setHorizontalAlignment(kCCTextAlignmentLeft)
			var_12_5:setVerticalAlignment(kCCVerticalTextAlignmentTop)

			local var_12_6 = ui.newControlButton({
				fontSize = 25,
				disabledImage = "ui/common/common_078.png",
				normalImage = "ui/common/common_027.png",
				text = string.lf("领取"),
				anchorPoint = CCPoint(0.5, 0.5),
				position = CCPoint(475, var_12_3.height / 2),
				clickAction = function()
					arg_9_0.currItemId = var_12_1.Id
					arg_9_0.getScore = var_12_1.Score

					if arg_12_1 >= 4 then
						arg_9_0.currOffset = arg_12_0:getContentOffset()
					end

					arg_9_0.scoreGetRequest:request(var_12_1.Id)
				end
			})

			var_12_2:addChild(var_12_6)
		end

		return var_12_0
	end

	local var_9_3, var_9_4 = var_9_0(nil)
	local var_9_5 = CCTableView:create(CCSize(560, 445))

	var_9_5:setContentSize(CCSize(560, var_9_1(nil) * var_9_3))
	var_9_5:setPosition((arg_9_0.bgSize.width - 560) / 2, 4)
	var_9_5:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_9_5:setDirection(kCCScrollViewDirectionVertical)
	arg_9_0.background:addChild(var_9_5)

	arg_9_0.tableView = var_9_5

	var_9_5:registerScriptHandler(var_9_0, CCTableView.kTableCellSizeForIndex)
	var_9_5:registerScriptHandler(var_9_1, CCTableView.kNumberOfCellsInTableView)
	var_9_5:registerScriptHandler(var_9_2, CCTableView.kTableCellSizeAtIndex)
	var_9_5:reloadData()
	var_9_5:setContentOffset(var_9_5:minContainerOffset())
end

return var_0_1
