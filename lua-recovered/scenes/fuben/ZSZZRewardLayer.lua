require("base.figure")
require("network.ZSZZRequest")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("ZSZZRewardLayer", function()
	return CCLayerColor:create(ccc4(0, 0, 0, 160))
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	local var_2_0 = display.newSprite("ui/duel/duel_018.png")

	var_2_0:setScale(Adapter.MinScale)
	var_2_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_0:setPosition(display.cx, display.cy - 10)
	arg_2_0:addChild(var_2_0)

	arg_2_0.mBgSprite = var_2_0
	arg_2_0.mBgSize = CCSize(880, 569)

	local var_2_1 = display.newSprite("uilocal/fuben/zszz_text_013.png")

	var_2_1:setAnchorPoint(ccp(0.5, 0.5))
	var_2_1:setPosition(440, 530)
	var_2_0:addChild(var_2_1)

	local var_2_2 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		highlightedImage = "ui/common/btn_closed.png",
		position = ccp(arg_2_0.mBgSize.width - 9, arg_2_0.mBgSize.height),
		clickAction = function()
			arg_2_0:removeFromParentAndCleanup(true)
		end
	})

	var_2_0:addChild(var_2_2)
	addLabelWithColorSize(var_2_0, string.lf("奖励保留到下届开赛，请及时领取"), ccc3(255, 255, 255), 16, ccp(0, 0.5), ccp(321, 490))

	arg_2_0.background = display.newNode()

	arg_2_0.background:setContentSize(arg_2_0.mBgSize)
	var_2_0:addChild(arg_2_0.background)
	arg_2_0:initRequests()
	arg_2_0:refreshLayer(arg_2_1)
end

function var_0_1.refreshLayer(arg_5_0, arg_5_1)
	arg_5_0.background:removeAllChildrenWithCleanup(true)
	arg_5_0.mRewardRequest:request()
end

function var_0_1.initRequests(arg_6_0)
	local function var_6_0()
		local var_7_0 = arg_6_0.mRewardRequest.restable

		if var_7_0 == nil or table.nums(var_7_0) == 0 then
			showFlashNotice(string.lf("暂时没有可领取的奖励"))

			return
		end

		arg_6_0.itemList = var_7_0

		arg_6_0:CreateTableView()
	end

	arg_6_0.mRewardRequest = ZSZZRewardListRequest:new()

	arg_6_0.mRewardRequest:setResponseNormalHandler(var_6_0)

	local function var_6_1()
		local var_8_0 = arg_6_0.mGetRewardRequest.restable

		showFlashNotice(string.lf("领取成功"))
		dump(arg_6_0.itemList)

		for iter_8_0, iter_8_1 in pairs(arg_6_0.itemList) do
			if iter_8_1.Id == arg_6_0.currItemId then
				table.remove(arg_6_0.itemList, iter_8_0)

				break
			end
		end

		arg_6_0.tableview:reloadData()

		if arg_6_0.currOffset ~= nil then
			arg_6_0.tableview:setContentOffset(ccp(arg_6_0.currOffset.x, arg_6_0.currOffset.y + 176))
		end
	end

	arg_6_0.mGetRewardRequest = ZSZZGetRewardRequest:new()

	arg_6_0.mGetRewardRequest:setResponseNormalHandler(var_6_1)
end

function var_0_1.CreateTableView(arg_9_0)
	local function var_9_0(arg_10_0)
		return 176, 702
	end

	local function var_9_1(arg_11_0)
		return table.nums(arg_9_0.itemList)
	end

	local function var_9_2(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_1 + 1
		local var_12_1 = 3
		local var_12_2 = arg_12_0:cellAtIndex(arg_12_1)

		if var_12_2 == nil then
			var_12_2 = CCTableViewCell:new()
		end

		var_12_2:removeAllChildrenWithCleanup(true)

		local var_12_3 = display.newSprite("ui/duel/duel_017.png")
		local var_12_4 = var_12_3:getContentSize()

		var_12_3:setAnchorPoint(ccp(0.5, 0.5))
		var_12_3:setPosition(355, 88)
		var_12_2:addChild(var_12_3)

		local var_12_5 = arg_9_0.itemList[var_12_0]

		dump(var_12_5)

		local var_12_6

		if var_12_5.CSBattleRewardType == 1 then
			var_12_6 = string.lf("上仙目光如炬，鼓舞的种子选手进入其所在道的前十，特此奖励")
		elseif var_12_5.CSBattleRewardType == 2 then
			if var_12_5.CSBattleType == 1 then
				daoText = string.lf("人界")
			elseif var_12_5.CSBattleType == 2 then
				daoText = string.lf("地界")
			elseif var_12_5.CSBattleType == 3 then
				daoText = string.lf("天界")
			end

			var_12_6 = string.lf("上仙，您在本次%s--诸神之战中排名第 %d，可以获得以下奖励", daoText, var_12_5.Rank)
		elseif var_12_5.CSBattleRewardType == 3 then
			var_12_6 = string.lf("上仙，您下注的玩家#00FF00【%s】%s#EEB422获得了本次诸神之战的第%d名，您获得如下奖励", var_12_5.BeServerName, var_12_5.BePlayerName, var_12_5.Rank)
		end

		arg_9_0.rewardLabel = addLabelWithColorSize(var_12_3, var_12_6, ccc3(235, 210, 20), 18, ccp(0, 1), ccp(60, var_12_4.height / 2 + 75))

		arg_9_0.rewardLabel:setHorizontalAlignment(kCCTextAlignmentLeft)
		arg_9_0.rewardLabel:setDimensions(CCSizeMake(var_12_4.width - 100, var_12_4.height))

		local var_12_7 = arg_9_0:createRewardView(var_12_5.RewradResponse)

		var_12_7:setPosition(30, 12)
		var_12_2:addChild(var_12_7)

		local var_12_8 = ui.newControlButton({
			fontSize = 25,
			disabledImage = "ui/common/common_078.png",
			normalImage = "ui/common/common_027.png",
			text = string.lf("领取"),
			anchorPoint = CCPoint(0.5, 0.5),
			position = CCPoint(630, var_12_4.height / 2 - 20),
			clickAction = function()
				arg_9_0.currItemId = var_12_5.Id

				arg_9_0.mGetRewardRequest:request(arg_9_0.currItemId)

				arg_9_0.currOffset = arg_12_0:getContentOffset()
			end
		})

		var_12_3:addChild(var_12_8)

		return var_12_2
	end

	local var_9_3, var_9_4 = var_9_0(nil)

	arg_9_0.tableview = CCTableView:create(CCSize(710, 460))

	arg_9_0.tableview:setContentSize(CCSize(710, var_9_1(nil) * var_9_3))
	arg_9_0.tableview:setVerticalFillOrder(kCCTableViewFillTopDown)
	arg_9_0.tableview:setDirection(kCCScrollViewDirectionVertical)
	arg_9_0.tableview:setPosition((arg_9_0.mBgSize.width - 710) / 2, 10)
	arg_9_0.background:addChild(arg_9_0.tableview)
	arg_9_0.tableview:registerScriptHandler(var_9_0, CCTableView.kTableCellSizeForIndex)
	arg_9_0.tableview:registerScriptHandler(var_9_1, CCTableView.kNumberOfCellsInTableView)
	arg_9_0.tableview:registerScriptHandler(var_9_2, CCTableView.kTableCellSizeAtIndex)
	arg_9_0.tableview:reloadData()
	arg_9_0.tableview:setContentOffset(arg_9_0.tableview:minContainerOffset())
end

function var_0_1.createRewardView(arg_14_0, arg_14_1)
	local var_14_0 = display.newNode()
	local var_14_1 = 0
	local var_14_2 = CCSizeMake(110, 110)

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		local var_14_3 = figure.createHeader({
			isName = true,
			type = iter_14_1.Type,
			itemId = iter_14_1.ID or 0,
			count = iter_14_1.Count,
			nameColor = getQualityColor(getItemQuality(iter_14_1.Type, iter_14_1.ID)),
			equipJieji = iter_14_1.BreakthroughCount,
			countColor = ccc3(255, 228, 0),
			clickAction = function()
				var_0_0.tipshandler(iter_14_1)
			end
		})

		var_14_0:addChild(var_14_3)
		var_14_3:setPosition(var_14_1 + var_14_2.width / 2, var_14_2.height / 2 + 10)

		var_14_1 = var_14_1 + var_14_2.width
	end

	var_14_0:setContentSize(CCSizeMake(var_14_1, var_14_2.height))

	return var_14_0
end

return var_0_1
