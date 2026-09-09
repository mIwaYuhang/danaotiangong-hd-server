require("base.figure")
require("network.ZSZZRequest")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("ZSZZInspireRecordLayer", function()
	return CCLayerColor:create(ccc4(0, 0, 0, 160))
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.pageType = arg_2_1 and arg_2_1.pageType and arg_2_1.pageType or MasterType.eLand

	local var_2_0 = display.newSprite("ui/fuben/zszz_017.png")

	var_2_0:setScale(Adapter.MinScale)
	var_2_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_0:setPosition(display.cx, display.cy)
	arg_2_0:addChild(var_2_0)

	arg_2_0.mBgSprite = var_2_0
	arg_2_0.mBgSize = CCSize(360, 460)

	local var_2_1 = {
		[MasterType.eLand] = string.lf("人界"),
		[MasterType.eDemon] = string.lf("地界"),
		[MasterType.eHeaven] = string.lf("天界")
	}

	arg_2_0.bottomLabel = addLabelWithColorSize(var_2_0, string.lf("%s的鼓舞记录", var_2_1[arg_2_0.pageType]), ccc3(255, 204, 100), 20, ccp(0, 0), ccp(17, 30))

	local var_2_2 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		highlightedImage = "ui/common/btn_closed.png",
		position = ccp(arg_2_0.mBgSize.width, arg_2_0.mBgSize.height + 70),
		clickAction = function()
			arg_2_0:removeFromParentAndCleanup(true)
		end
	})

	var_2_0:addChild(var_2_2)

	arg_2_0.background = display.newNode()

	arg_2_0.background:setContentSize(arg_2_0.mBgSize)

	arg_2_0.mInsReport = arg_2_0:CreateTableView()

	arg_2_0.mInsReport:setPosition(10, 80)
	arg_2_0.background:addChild(arg_2_0.mInsReport)
	var_2_0:addChild(arg_2_0.background)
	arg_2_0:requestInsireRecordInfo(arg_2_1.pageType or 1)
end

function var_0_1.CreateTableView(arg_5_0)
	local var_5_0 = display.newNode()

	var_5_0.dataSrc = {}

	local function var_5_1(arg_6_0)
		return #var_5_0.dataSrc
	end

	local var_5_2 = CCSizeMake(arg_5_0.mBgSize.width - 20, 80)

	local function var_5_3(arg_7_0)
		return var_5_2.height, var_5_2.width
	end

	local function var_5_4(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_1 + 1
		local var_8_1 = arg_8_0:cellAtIndex(arg_8_1)

		if var_8_1 == nil then
			var_8_1 = CCTableViewCell:new()
		end

		var_8_1:removeAllChildrenWithCleanup(true)

		local var_8_2 = var_5_0.dataSrc[var_8_0]
		local var_8_3 = CCSizeMake(var_5_2.width, var_5_2.height - 6)
		local var_8_4 = display.newScale9Sprite("ui/team/team_093.png")

		var_8_4:setAnchorPoint(ccp(0, 0))
		var_8_4:setContentSize(var_8_3)
		addLabelWithColorSize(var_8_4, getFormatCountDownTime(var_8_2.Time), ccc3(0, 225, 0), 18, ccp(1, 1.6), ccp(90, var_8_3.height))

		if #var_5_0.dataSrc == 400 then
			local var_8_5 = addLabelWithColorSize(var_8_4, string.lf("%s对此道进行了鼓舞，此道的战斗力加成已满，无法继续加成", var_8_2.PlayerName), ccc3(255, 255, 255), 16, ccp(0, 1.2), ccp(120, var_8_3.height + 8))

			var_8_5:setHorizontalAlignment(kCCTextAlignmentLeft)
			var_8_5:setDimensions(CCSizeMake(var_8_3.width - 120, var_8_3.height - 10))
		else
			local var_8_6 = addLabelWithColorSize(var_8_4, string.lf("%s对此道进行了鼓舞，此道的战斗力加成%s%%", var_8_2.PlayerName, var_8_2.PowerAddtion), ccc3(255, 225, 255), 16, ccp(0, 1.2), ccp(120, var_8_3.height + 8))

			var_8_6:setHorizontalAlignment(kCCTextAlignmentLeft)
			var_8_6:setDimensions(CCSizeMake(var_8_3.width - 120, var_8_3.height - 10))
		end

		var_8_1:addChild(var_8_4)

		return var_8_1
	end

	local var_5_5 = CCTableView:create(CCSize(var_5_2.width, 420))

	var_5_5:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_5_5:setDirection(kCCScrollViewDirectionVertical)
	var_5_5:registerScriptHandler(var_5_3, CCTableView.kTableCellSizeForIndex)
	var_5_5:registerScriptHandler(var_5_1, CCTableView.kNumberOfCellsInTableView)
	var_5_5:registerScriptHandler(var_5_4, CCTableView.kTableCellSizeAtIndex)
	var_5_0:addChild(var_5_5)

	function var_5_0.reloadData(arg_9_0, arg_9_1)
		var_5_0.dataSrc = arg_9_1

		var_5_5:reloadData()
	end

	return var_5_0
end

function var_0_1.requestInsireRecordInfo(arg_10_0, arg_10_1)
	if not arg_10_0.mInspireRecordRequest then
		arg_10_0.mInspireRecordRequest = ZSZZGetEncourageInfoRequest:new()

		local function var_10_0()
			arg_10_0:onResponseRecordInfo(arg_10_0.mInspireRecordRequest.restable)
		end

		arg_10_0.mInspireRecordRequest:setResponseNormalHandler(var_10_0)
	end

	arg_10_0.mInspireRecordRequest:request(arg_10_1)
end

function var_0_1.onResponseRecordInfo(arg_12_0, arg_12_1)
	arg_12_0.mInspireRecordRequest = arg_12_1

	dump(arg_12_1)
	arg_12_0.mInsReport:reloadData(arg_12_1)
end

return var_0_1
