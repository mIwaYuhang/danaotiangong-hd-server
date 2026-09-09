require("base.figure")
require("data.player")
require("network.ZSZZRequest")
require("data.ZSZZReward")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("ZSZZKillListLayer", function()
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

	local var_2_0 = display.newScale9Sprite("ui/xunfang/xunfang_002.png")

	arg_2_0.bgSize = CCSize(760, 600)

	var_2_0:setPreferredSize(arg_2_0.bgSize)
	var_2_0:setScale(Adapter.MinScale)
	var_2_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_0:setPosition(display.cx, display.cy)
	arg_2_0:addChild(var_2_0)

	arg_2_0.background = display.newNode()

	arg_2_0.background:setContentSize(arg_2_0.bgSize)

	arg_2_0.mRankView = arg_2_0:createTableView()

	arg_2_0.mRankView:setPosition(10, 3)
	arg_2_0.background:addChild(arg_2_0.mRankView)
	var_2_0:addChild(arg_2_0.background)
	addLabelWithColorSize(var_2_0, string.lf("诸神之战击杀数全区前10的玩家，10名以后的玩家获得的奖励和第10名一致"), ccc3(255, 255, 255), 20, ccp(0, 0.5), ccp(40, 520))

	local var_2_1 = {
		[MasterType.eLand] = "uilocal/fuben/zszz_text_031.png",
		[MasterType.eDemon] = "uilocal/fuben/zszz_text_028.png",
		[MasterType.eHeaven] = "uilocal/fuben/zszz_text_030.png"
	}
	local var_2_2 = display.newSprite(var_2_1[arg_2_0.pageType], arg_2_0.bgSize.width / 2, arg_2_0.bgSize.height - 30)

	var_2_0:addChild(var_2_2)

	local var_2_3 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		highlightedImage = "ui/common/btn_closed.png",
		position = ccp(arg_2_0.bgSize.width - 20, arg_2_0.bgSize.height - 20),
		clickAction = function()
			if arg_2_0._closecallback then
				arg_2_0._closecallback()
			end

			arg_2_0:removeFromParentAndCleanup(true)
		end
	})

	var_2_0:addChild(var_2_3)
	var_2_3:setTouchPriority(-1)
	arg_2_0:requestRankInfo(arg_2_1.pageType or 1)
end

function var_0_1.createTableView(arg_5_0)
	local var_5_0 = display.newNode()

	var_5_0.dataSrc = {}

	local function var_5_1(arg_6_0)
		return #var_5_0.dataSrc
	end

	local var_5_2 = CCSizeMake(740, 190)

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
		local var_8_3 = display.newSprite("ui/fuben/zszz_016.png")

		var_8_3:setAnchorPoint(ccp(0, 0))
		var_8_3:setPosition(-1, 2)
		var_8_1:addChild(var_8_3)

		local var_8_4 = display.newSprite("ui/fuben/zszz_015.png")

		var_8_4:setPosition(var_5_2.width / 2, (var_5_2.height - 70) / 2 + 12)
		var_8_1:addChild(var_8_4)

		local var_8_5 = display.newSprite("uilocal/fuben/zszz_text_016.png")

		var_8_5:setAnchorPoint(ccp(0.5, 1))
		var_8_5:setPosition(var_5_2.width / 2, var_5_2.height - 5)
		var_8_1:addChild(var_8_5)

		local var_8_6 = CCLabelAtlas:create(var_8_2.Rank, "uilocal/duel/duel_text_019.png", 30, 38, 48)

		if var_8_2.Rank >= 10 then
			var_8_6:setScale(0.6)
		else
			var_8_6:setScale(0.75)
		end

		var_8_6:setAnchorPoint(ccp(0.5, 0))
		var_8_6:setPosition(138, 0)
		var_8_5:addChild(var_8_6)

		local var_8_7 = display.newSprite("uilocal/fuben/zszz_text_044.png")

		var_8_7:setPosition(ccp(50, 60))

		local var_8_8 = display.newSprite("uilocal/fuben/zszz_text_045.png")

		var_8_8:setPosition(ccp(50, 60))

		local var_8_9 = display.newSprite("uilocal/fuben/zszz_text_046.png")

		var_8_9:setPosition(ccp(50, 60))

		if var_8_2.Rank == 1 then
			var_8_4:addChild(var_8_7)
		elseif var_8_2.Rank == 2 then
			var_8_4:addChild(var_8_8)
		elseif var_8_2.Rank == 3 then
			var_8_4:addChild(var_8_9)
		end

		local var_8_10 = "[%s] %s"

		if var_8_2.UnionName ~= nil then
			var_8_10 = var_8_2.UnionName == "" and "[%s] %s(#FF7F50散修#EEB422)" or "[%s] %s(#00FF00%s#EEB422)"
		end

		addLabelWithColorSize(var_8_1, string.lf(var_8_10, var_8_2.ServerName, var_8_2.PlayerName, var_8_2.UnionName), ccc3(238, 180, 34), 18, ccp(0, 0.5), ccp(20, var_5_2.height / 2 + 55))

		if var_8_2.TotalPower then
			addLabelWithColorSize(var_8_1, string.lf("战斗力:#F4F4F4%d", var_8_2.TotalPower), ccc3(255, 227, 0), 18, ccp(0, 0.5), ccp(320, var_5_2.height / 2 + 55))
		end

		if var_8_2.KillCount then
			addLabelWithColorSize(var_8_1, string.lf("击杀数:#F4F4F4%d", var_8_2.KillCount), ccc3(255, 227, 0), 18, ccp(0, 0.5), ccp(480, var_5_2.height / 2 + 55))
		end

		local var_8_11 = arg_5_0:createRewardView(CCSize(var_5_2.width - 10, 110), var_8_2.Reward)

		var_8_11:setPosition(5, 15)
		var_8_1:addChild(var_8_11)

		if var_8_2.PlayerId then
			local var_8_12 = ui.newControlButton({
				fontSize = 18,
				titleImage = "uilocal/fuben/zszz_text_015.png",
				normalImage = "ui/common/common_115.png",
				position = ccp(var_5_2.width - 75, var_5_2.height / 2 + 65),
				clickAction = function()
					arg_5_0:onBtnViewClicked(var_8_2.PlayerId)
				end
			})

			var_8_1:addChild(var_8_12)
		end

		return var_8_1
	end

	local var_5_5 = CCTableView:create(CCSize(var_5_2.width, 500))

	var_5_5:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_5_5:setDirection(kCCScrollViewDirectionVertical)
	var_5_5:registerScriptHandler(var_5_3, CCTableView.kTableCellSizeForIndex)
	var_5_5:registerScriptHandler(var_5_1, CCTableView.kNumberOfCellsInTableView)
	var_5_5:registerScriptHandler(var_5_4, CCTableView.kTableCellSizeAtIndex)
	var_5_0:addChild(var_5_5)

	function var_5_0.reloadData(arg_10_0, arg_10_1)
		var_5_0.dataSrc = arg_10_1

		var_5_5:reloadData()
	end

	return var_5_0
end

function var_0_1.createRewardView(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = display.newNode()
	local var_11_1 = 0
	local var_11_2 = CCSizeMake(110, 110)

	for iter_11_0, iter_11_1 in ipairs(arg_11_2) do
		local var_11_3 = figure.createHeader({
			isName = true,
			type = iter_11_1.Type,
			itemId = iter_11_1.ID or 0,
			count = iter_11_1.Count,
			nameColor = getQualityColor(getItemQuality(iter_11_1.Type, iter_11_1.ID)),
			equipJieji = iter_11_1.BreakthroughCount,
			countColor = ccc3(255, 228, 0),
			clickAction = function()
				var_0_0.tipshandler(iter_11_1)
			end
		})

		var_11_0:addChild(var_11_3)
		var_11_3:setPosition(80 + var_11_1 + var_11_2.width / 2, var_11_2.height / 2 + 10)

		var_11_1 = var_11_1 + var_11_2.width
	end

	var_11_0:setContentSize(CCSizeMake(var_11_1, var_11_2.height))

	local var_11_4 = CCScrollView:create(arg_11_1, var_11_0)

	var_11_4:setDirection(kCCScrollViewDirectionHorizontal)

	return var_11_4
end

function var_0_1.onBtnViewClicked(arg_13_0, arg_13_1)
	local var_13_0 = require("scenes.fuben.ZSZZPlayerBattleInfoLayer").new({
		pageType = 4,
		from = "ZSZZHomeScene",
		playerId = arg_13_1,
		type = arg_13_0.pageType
	})

	arg_13_0:addChild(var_13_0)
end

function var_0_1.requestRankInfo(arg_14_0, arg_14_1)
	if not arg_14_0.mRankInfoRequest then
		arg_14_0.mRankInfoRequest = ZSZZGetTop10InfoRequest:new()

		local function var_14_0()
			arg_14_0:onResponseInfoSucess(arg_14_0.mRankInfoRequest.restable, arg_14_0.mRankInfoRequest.lastRequestType)
		end

		arg_14_0.mRankInfoRequest:setResponseNormalHandler(var_14_0)
	end

	arg_14_0.mRankInfoRequest.lastRequestType = arg_14_1

	arg_14_0.mRankInfoRequest:request(arg_14_1)
end

function var_0_1.onResponseInfoSucess(arg_16_0, arg_16_1, arg_16_2)
	dump(arg_16_1)

	local var_16_0 = {}

	if #arg_16_1 == 0 then
		arg_16_1 = ZSZZRewardData

		for iter_16_0, iter_16_1 in pairs(ZSZZRewardData) do
			iter_16_1.ServerName = string.lf("服务器")
			iter_16_1.PlayerName = string.lf("第%d名", iter_16_1.Rank)
		end
	end

	for iter_16_2, iter_16_3 in pairs(arg_16_1) do
		if iter_16_3.Type == arg_16_2 then
			table.insert(var_16_0, iter_16_3)
		end
	end

	table.sort(var_16_0, function(arg_17_0, arg_17_1)
		return arg_17_0.Rank < arg_17_1.Rank
	end)
	dump(var_16_0)
	arg_16_0.mRankView:reloadData(var_16_0)
end

return var_0_1
