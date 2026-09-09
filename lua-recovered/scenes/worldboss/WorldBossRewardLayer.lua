require("base.figure")
require("network.WorldBossRequest")

local var_0_0 = class("WorldBossRewardLayer", function()
	return CCLayerColor:create(ccc4(0, 0, 0, 160))
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.mRewardList = {}

	arg_2_0:setUI()
	arg_2_0:requestRewardList()
end

function var_0_0.setUI(arg_3_0, arg_3_1)
	arg_3_0:addTouchEventListener(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_3_0:setTouchEnabled(true)

	local var_3_0 = display.newSprite("ui/duel/duel_018.png")

	var_3_0:setScale(Adapter.MinScale)
	var_3_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_3_0:setPosition(display.cx, display.cy)
	arg_3_0:addChild(var_3_0)

	arg_3_0.mBgSprite = var_3_0
	arg_3_0.mBgSize = CCSize(880, 569)

	local var_3_1 = display.newSprite("uilocal/duel/duel_text_018.png")

	var_3_1:setAnchorPoint(ccp(0.5, 0.5))
	var_3_1:setPosition(440, 560)
	var_3_0:addChild(var_3_1)

	local var_3_2 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		highlightedImage = "ui/common/btn_closed.png",
		position = ccp(arg_3_0.mBgSize.width - 15, arg_3_0.mBgSize.height - 15),
		clickAction = function()
			arg_3_0:removeFromParentAndCleanup(true)
		end
	})

	var_3_0:addChild(var_3_2)
	arg_3_0:createRewardView()
end

function var_0_0.createRewardView(arg_6_0)
	local var_6_0 = CCSizeMake(702, 176)

	local function var_6_1(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_1 + 1
		local var_7_1 = arg_7_0:cellAtIndex(arg_7_1)

		if var_7_1 == nil then
			var_7_1 = CCTableViewCell:new()
		end

		local var_7_2 = display.newSprite("ui/duel/duel_016.png")
		local var_7_3 = var_7_2:getContentSize()

		var_7_2:setPosition(355, 88)
		var_7_1:addChild(var_7_2)

		local var_7_4 = arg_6_0.mRewardList[var_7_0]
		local var_7_5 = display.newSprite("ui/worldboss/worldboss_017.png", 60, var_6_0.height / 2 - 20)

		var_7_5:setScale(0.38)
		var_7_2:addChild(var_7_5)
		addLabelWithColorSize(var_7_2, var_7_4.activityTime, ccc3(255, 255, 0), 22, ccp(0, 1), ccp(25, var_6_0.height / 2 + 65))

		local var_7_6

		if var_7_4.rankReward and var_7_4.rankReward[1] and var_7_4.rankReward[1].Count > 0 then
			var_7_6 = string.lf("造成伤害排第%d名,奖励%d银币,再接再厉哦", var_7_4.rank, var_7_4.rankReward[1].Count)
		else
			var_7_6 = string.lf("造成伤害排第%d名,没有排名奖励,加油哦", var_7_4.rank)
		end

		addLabelWithColorSize(var_7_2, var_7_6, ccc3(238, 201, 0), 22, ccp(0, 1), ccp(115, var_6_0.height / 2 + 20))

		if var_7_4.chestReward and var_7_4.chestReward[1] and var_7_4.chestReward[1].Count > 0 then
			var_7_6 = string.lf("获得宝箱奖励%d银币", var_7_4.chestReward[1].Count)
		else
			var_7_6 = string.lf("没有获得宝箱奖励")
		end

		addLabelWithColorSize(var_7_2, var_7_6, ccc3(238, 201, 0), 22, ccp(0, 1), ccp(115, var_6_0.height / 2 - 15))

		local var_7_7 = ui.newControlButton({
			fontSize = 24,
			disabledImage = "ui/common/common_078.png",
			normalImage = "ui/common/common_027.png",
			text = string.lf("领取"),
			textColor = ccc3(198, 216, 229),
			anchorPoint = CCPoint(0.5, 0.5),
			position = CCPoint(620, var_7_3.height / 2 - 35),
			clickAction = function()
				arg_6_0:requestGetReward(var_7_4.activityTime)
			end
		})

		var_7_2:addChild(var_7_7)

		return var_7_1
	end

	local var_6_2 = CCTableView:create(CCSizeMake(710, 515))

	var_6_2:ignoreAnchorPointForPosition(false)
	var_6_2:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_6_2:setDirection(kCCScrollViewDirectionVertical)
	var_6_2:registerScriptHandler(function()
		return var_6_0.height, var_6_0.width
	end, CCTableView.kTableCellSizeForIndex)
	var_6_2:registerScriptHandler(function()
		return table.nums(arg_6_0.mRewardList)
	end, CCTableView.kNumberOfCellsInTableView)
	var_6_2:registerScriptHandler(var_6_1, CCTableView.kTableCellSizeAtIndex)
	var_6_2:setAnchorPoint(ccp(0, 0))
	var_6_2:setPosition((arg_6_0.mBgSize.width - 710) / 2, 8)
	arg_6_0.mBgSprite:addChild(var_6_2)

	arg_6_0.mTableView = var_6_2
end

function var_0_0.requestRewardList(arg_11_0)
	if not arg_11_0.mRewardListRequest then
		local function var_11_0()
			local var_12_0 = arg_11_0.mRewardListRequest.restable

			arg_11_0.mRewardList = {}

			for iter_12_0, iter_12_1 in ipairs(var_12_0 or {}) do
				if iter_12_1.rank > 0 then
					table.insert(arg_11_0.mRewardList, iter_12_1)
				end
			end

			table.sort(arg_11_0.mRewardList, function(arg_13_0, arg_13_1)
				return arg_13_0.rank < arg_13_1.rank
			end)

			if table.nums(arg_11_0.mRewardList) == 0 then
				return showFlashNotice(string.lf("暂时没有可领取的奖励"))
			end

			arg_11_0.mTableView:reloadData()
		end

		arg_11_0.mRewardListRequest = WorldBossRewardListRequest:new()

		arg_11_0.mRewardListRequest:setResponseNormalHandler(var_11_0)
	end

	arg_11_0.mRewardListRequest:request()
end

function var_0_0.requestGetReward(arg_14_0, arg_14_1)
	if not arg_14_0.mGetRewardRequest then
		local function var_14_0()
			showFlashNotice(string.lf("领取成功"))

			for iter_15_0, iter_15_1 in ipairs(arg_14_0.mRewardList) do
				if iter_15_1.activityTime == arg_14_0.mLastGetRewardTime then
					table.remove(arg_14_0.mRewardList, iter_15_0)
					arg_14_0.mTableView:reloadData()

					break
				end
			end
		end

		arg_14_0.mGetRewardRequest = WorldBossGetRewardRequest:new()

		arg_14_0.mGetRewardRequest:setResponseNormalHandler(var_14_0)
	end

	arg_14_0.mLastGetRewardTime = arg_14_1

	arg_14_0.mGetRewardRequest:request(arg_14_1)
end

return var_0_0
