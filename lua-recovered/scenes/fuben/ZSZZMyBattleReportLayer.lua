require("data.player")
require("base.figure")
require("network.ZSZZRequest")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("ZSZZMyBattleReportLayer", function()
	return CCLayerColor:create(ccc4(0, 0, 0, 160))
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0:requestReportInfo()
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	local var_2_0 = display.newSprite("ui/fuben/zszz_017.png")

	var_2_0:setScale(Adapter.MinScale)
	var_2_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_0:setPosition(display.cx, display.cy)
	arg_2_0:addChild(var_2_0)

	arg_2_0.mBgSprite = var_2_0
	arg_2_0.mBgSize = CCSize(355, 540)
	arg_2_0.cur_titleLabel = addLabelWithColorSize(var_2_0, string.lf(""), ccc3(255, 204, 100), 18, ccp(0, 0), ccp(17, 28))
	arg_2_0.background = display.newNode()

	arg_2_0.background:setContentSize(arg_2_0.mBgSize)

	arg_2_0.myReport = arg_2_0:CreateTableView()

	arg_2_0.myReport:setPosition(10, 80)
	arg_2_0.background:addChild(arg_2_0.myReport)
	var_2_0:addChild(arg_2_0.background)

	local var_2_1 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		highlightedImage = "ui/common/btn_closed.png",
		position = ccp(arg_2_0.mBgSize.width, arg_2_0.mBgSize.height - 15),
		clickAction = function()
			arg_2_0:removeFromParentAndCleanup(true)
		end
	})

	var_2_0:addChild(var_2_1)
end

function var_0_1.CreateTableView(arg_5_0)
	local var_5_0 = display.newNode()

	var_5_0.dataSrc = {}

	local function var_5_1(arg_6_0)
		return #var_5_0.dataSrc
	end

	local var_5_2 = CCSizeMake(430, 80)

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

		local var_8_2 = addLabelWithColorSize(var_8_1, string.lf(""), ccc3(238, 180, 34), 16, ccp(0, 0), ccp(0, 0))

		var_8_2:setHorizontalAlignment(kCCTextAlignmentLeft)
		var_8_2:setDimensions(CCSizeMake(var_5_2.width - 100, var_5_2.height))

		local var_8_3 = var_5_0.dataSrc[var_8_0]

		dump(var_8_3)

		if var_8_3.IsWin == 1 then
			var_8_2:setString(string.lf("【%s】%s击杀了【%s】%s，获得了%d点击杀数，属性下降了%d%%", var_8_3.AttackServerName, var_8_3.AttackPlayerName, var_8_3.DefendServerName, var_8_3.DefendPlayerName, var_8_3.KillCountChange, var_8_3.PropertyChange))
		else
			var_8_2:setString(string.lf("【%s】%s被【%s】%s击杀了，复活次数-1，属性恢复满值", var_8_3.AttackServerName, var_8_3.AttackPlayerName, var_8_3.DefendServerName, var_8_3.DefendPlayerName))
			var_8_2:setColor(ccc3(238, 44, 44))
		end

		return var_8_1
	end

	local var_5_5 = CCTableView:create(CCSize(var_5_2.width, 410))

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

function var_0_1.requestReportInfo(arg_10_0)
	if not arg_10_0.mReportRequest then
		arg_10_0.mReportRequest = ZSZZBattleReportRequest:new()

		local function var_10_0()
			arg_10_0:onResponseReportInfo(arg_10_0.mReportRequest.restable)
		end

		arg_10_0.mReportRequest:setResponseNormalHandler(var_10_0)
	end

	arg_10_0.mReportRequest:request()
end

function var_0_1.onResponseReportInfo(arg_12_0, arg_12_1)
	arg_12_0.mReportRequest = arg_12_1

	dump(arg_12_1)

	if arg_12_1 ~= nil then
		arg_12_0.cur_titleLabel:setString(string.lf("本次击杀数排名：%d", arg_12_1[1].MyRank))
		arg_12_0.myReport:reloadData(arg_12_1)
	end
end

return var_0_1
