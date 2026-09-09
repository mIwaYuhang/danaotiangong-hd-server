require("base.functions")
require("network.RankingRequest")
require("scenes.team.OthersTeamHelper")
require("base.figure")

local var_0_0 = require("base.cache")
local var_0_1 = class("nBangLayer", function()
	return display.newLayer()
end)
local var_0_2 = {
	eJiFenBang = 5,
	eXianYuanBang = 3,
	eZhanShenBang = 2,
	eZhiZunBang = 1,
	eFuHaoBang = 4
}
local var_0_3 = {
	eJiFenBang = "uilocal/fuben/zszz_text_052.png",
	eXianYuanBang = "uilocal/fuben/zszz_text_035.png",
	eZhanShenBang = "uilocal/fuben/zszz_text_037.png",
	eZhiZunBang = "uilocal/fuben/zszz_text_036.png",
	eFuHaoBang = "uilocal/fuben/zszz_text_051.png"
}
local var_0_4 = {
	[0] = "uilocal/store/store_text_043.png",
	"uilocal/store/store_text_044.png",
	"uilocal/store/store_text_045.png",
	"uilocal/store/store_text_046.png",
	"uilocal/store/store_text_047.png",
	"uilocal/store/store_text_048.png",
	"uilocal/store/store_text_049.png",
	"uilocal/store/store_text_050.png",
	"uilocal/store/store_text_051.png",
	"uilocal/store/store_text_052.png",
	"uilocal/store/store_text_053.png",
	"uilocal/store/store_text_054.png",
	"uilocal/store/store_text_071.png"
}

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0.tableview = nil
	arg_2_0.tag = 1
	arg_2_0.number = 1
	arg_2_0.type = arg_2_1
	arg_2_0.bangData = {}

	if arg_2_0.type == var_0_2.eZhiZunBang and var_0_0.get("zhiZunBang_info") == nil then
		arg_2_0:requestNetWork(arg_2_0.type)
	elseif arg_2_0.type == var_0_2.eZhanShenBang and var_0_0.get("zhanShenBang_info") == nil then
		arg_2_0:requestNetWork(arg_2_0.type)
	elseif arg_2_0.type == var_0_2.eXianYuanBang and var_0_0.get("xianYuanBang_info") == nil then
		arg_2_0:requestNetWork(arg_2_0.type)
	elseif arg_2_0.type == var_0_2.eFuHaoBang and var_0_0.get("fuHaoBang_info") == nil then
		arg_2_0:requestConsumeNetWork()
	elseif arg_2_0.type == var_0_2.eJiFenBang and var_0_0.get("jiFenBang_info") == nil then
		arg_2_0:requestJiFenNetWork(arg_2_0.type)
	end

	if arg_2_0.type == var_0_2.eZhiZunBang and var_0_0.get("zhiZunBang_info") ~= nil then
		arg_2_0:setData()

		if var_0_0.get("zhiZunBang_RankInfo") == 0 then
			addLabelWithColorSize(arg_2_0, string.lf("我的排名：#00FF00未入榜 "), ccc3(255, 255, 255), 20, ccp(0.5, 0.5), ccp(80, 20))
		elseif var_0_0.get("zhiZunBang_RankInfo") > 0 then
			addLabelWithColorSize(arg_2_0, string.lf(string.lf("我的排名:#00FF00%d", var_0_0.get("zhiZunBang_RankInfo"))), ccc3(255, 255, 255), 20, ccp(0.5, 0.5), ccp(80, 20))
		end

		arg_2_0:onEnterAlias()
		arg_2_0:init()
	elseif arg_2_0.type == var_0_2.eZhanShenBang and var_0_0.get("zhanShenBang_info") ~= nil then
		arg_2_0:setData()

		if var_0_0.get("zhanShenBang_RankInfo") == 0 then
			addLabelWithColorSize(arg_2_0, string.lf("我的排名：#00FF00未入榜 "), ccc3(255, 255, 255), 20, ccp(0.5, 0.5), ccp(80, 20))
		elseif var_0_0.get("zhanShenBang_RankInfo") > 0 then
			addLabelWithColorSize(arg_2_0, string.lf(string.lf("  我的排名:#00FF00%d", var_0_0.get("zhanShenBang_RankInfo"))), ccc3(255, 255, 255), 20, ccp(0.5, 0.5), ccp(80, 20))
		end

		arg_2_0:onEnterAlias()
		arg_2_0:init()
	elseif arg_2_0.type == var_0_2.eXianYuanBang and var_0_0.get("xianYuanBang_info") ~= nil then
		arg_2_0:setData()

		if var_0_0.get("xianYuanBang_RankInfo") == 0 then
			addLabelWithColorSize(arg_2_0, string.lf("我的排名：#00FF00未入榜 "), ccc3(255, 255, 255), 20, ccp(0.5, 0.5), ccp(80, 20))
		elseif var_0_0.get("xianYuanBang_RankInfo") > 0 then
			addLabelWithColorSize(arg_2_0, string.lf(string.lf("  我的排名:#00FF00%d", var_0_0.get("xianYuanBang_RankInfo"))), ccc3(255, 255, 255), 20, ccp(0.5, 0.5), ccp(80, 20))
		end

		arg_2_0:init()
		arg_2_0:onEnterAlias()
	elseif arg_2_0.type == var_0_2.eFuHaoBang and var_0_0.get("fuHaoBang_info") ~= nil then
		arg_2_0:setData()

		if var_0_0.get("fuHaoBang_RankInfo") == 0 then
			addLabelWithColorSize(arg_2_0, string.lf("我的排名：#00FF00未入榜 "), ccc3(255, 255, 255), 20, ccp(0.5, 0.5), ccp(80, 20))
		elseif var_0_0.get("fuHaoBang_RankInfo") > 0 then
			addLabelWithColorSize(arg_2_0, string.lf(string.format("  我的排名:#00FF00%d", var_0_0.get("fuHaoBang_RankInfo"))), ccc3(255, 255, 255), 20, ccp(0.5, 0.5), ccp(80, 20))
		end

		arg_2_0:init()
		arg_2_0:onEnterAlias()
	elseif arg_2_0.type == var_0_2.eJiFenBang and var_0_0.get("jiFenBang_info") ~= nil then
		arg_2_0:setData()

		if var_0_0.get("fuHaoBang_RankInfo") == 0 then
			addLabelWithColorSize(arg_2_0, string.lf("我的排名：#00FF00未入榜 "), ccc3(255, 255, 255), 20, ccp(0.5, 0.5), ccp(80, 20))
		elseif var_0_0.get("fuHaoBang_RankInfo") > 0 then
			addLabelWithColorSize(arg_2_0, string.lf(string.format("  我的排名:#00FF00%d", var_0_0.get("fuHaoBang_RankInfo"))), ccc3(255, 255, 255), 20, ccp(0.5, 0.5), ccp(80, 20))
		end

		arg_2_0:init()
		arg_2_0:onEnterAlias()
	end
end

function var_0_1.setData(arg_3_0, arg_3_1)
	local var_3_0
	local var_3_1 = true

	local function var_3_2(arg_4_0)
		if arg_4_0 == var_0_2.eZhiZunBang then
			var_3_0 = var_0_0.get("zhiZunBang_info")
		elseif arg_4_0 == var_0_2.eZhanShenBang then
			var_3_0 = var_0_0.get("zhanShenBang_info")
		elseif arg_4_0 == var_0_2.eXianYuanBang then
			var_3_0 = var_0_0.get("xianYuanBang_info")
		elseif arg_4_0 == var_0_2.eFuHaoBang then
			var_3_0 = var_0_0.get("fuHaoBang_info")
		elseif arg_4_0 == var_0_2.eJiFenBang then
			var_3_0 = var_0_0.get("jiFenBang_info")
		end
	end

	if arg_3_0.type == var_0_2.eZhiZunBang and var_0_0.get("zhiZunBang_info") == nil then
		var_3_0 = arg_3_1.LevelRankResponse

		var_0_0.set("zhiZunBang_info", var_3_0)

		var_3_1 = false
	elseif arg_3_0.type == var_0_2.eZhanShenBang and var_0_0.get("zhanShenBang_info") == nil then
		var_3_0 = arg_3_1.PowerRankResponse

		var_0_0.set("zhanShenBang_info", var_3_0)

		var_3_1 = false
	elseif arg_3_0.type == var_0_2.eXianYuanBang and var_0_0.get("xianYuanBang_info") == nil then
		var_3_0 = arg_3_1.AdvanceRankResponse

		var_0_0.set("xianYuanBang_info", var_3_0)

		var_3_1 = false
	elseif arg_3_0.type == var_0_2.eFuHaoBang and var_0_0.get("fuHaoBang_info") == nil then
		var_3_0 = arg_3_1.ranks

		var_0_0.set("fuHaoBang_info", var_3_0)

		var_3_1 = false
	elseif arg_3_0.type == var_0_2.eJiFenBang and var_0_0.get("jiFenBang_info") == nil then
		var_3_0 = arg_3_1.ranks

		var_0_0.set("jiFenBang_info", var_3_0)

		var_3_1 = false
	end

	if var_3_1 == true then
		var_3_2(arg_3_0.type)
	end

	for iter_3_0 = 1, math.ceil(#var_3_0 / 20) do
		table.insert(arg_3_0.bangData, {})
	end

	local var_3_3 = 1

	for iter_3_1 = 1, #var_3_0 do
		table.insert(arg_3_0.bangData[var_3_3], var_3_0[iter_3_1])

		if iter_3_1 % 20 == 0 then
			var_3_3 = var_3_3 + 1
		end
	end
end

function var_0_1.requestJiFenNetWork(arg_5_0)
	local function var_5_0()
		local var_6_0 = arg_5_0.JiFenRequest:getRankInfo()

		arg_5_0:setData(var_6_0)
		var_0_0.set("startTime", var_6_0.startTime)
		var_0_0.set("endTime", var_6_0.endTime)
		var_0_0.set("fuHaoBang_RankInfo", var_6_0.MyRank)

		if var_6_0.MyRank == 0 then
			addLabelWithColorSize(arg_5_0, string.lf("我的排名：#00FF00未入榜 "), ccc3(255, 255, 255), 20, ccp(0.5, 0.5), ccp(80, 20))
		elseif var_6_0.MyRank > 0 then
			addLabelWithColorSize(arg_5_0, string.lf(string.format("  我的排名:#00FF00%d", var_6_0.MyRank)), ccc3(255, 255, 255), 20, ccp(0.5, 0.5), ccp(80, 20))
		end

		if var_6_0.ranks and table.nums(var_6_0.ranks) ~= 0 then
			arg_5_0:onEnterAlias()
			arg_5_0:init()
		end
	end

	arg_5_0.JiFenRequest = JiFenBangRequest:new()

	arg_5_0.JiFenRequest:setResponseNormalHandler(var_5_0)
	arg_5_0.JiFenRequest:request(var_0_2.eJiFenBang)
end

function var_0_1.requestConsumeNetWork(arg_7_0)
	local function var_7_0()
		local var_8_0 = arg_7_0.ConsumeRequest:getRankInfo()

		arg_7_0:setData(var_8_0)
		var_0_0.set("startTime", var_8_0.startTime)
		var_0_0.set("endTime", var_8_0.endTime)
		var_0_0.set("fuHaoBang_RankInfo", var_8_0.MyRank)

		if var_8_0.MyRank == 0 then
			addLabelWithColorSize(arg_7_0, string.lf("我的排名：#00FF00未入榜 "), ccc3(255, 255, 255), 20, ccp(0.5, 0.5), ccp(80, 20))
		elseif var_8_0.MyRank > 0 then
			addLabelWithColorSize(arg_7_0, string.lf(string.format("  我的排名:#00FF00%d", var_8_0.MyRank)), ccc3(255, 255, 255), 20, ccp(0.5, 0.5), ccp(80, 20))
		end

		if var_8_0.ranks and table.nums(var_8_0.ranks) ~= 0 then
			dump(var_8_0.ranks, "rankInfo.ranks")
			arg_7_0:onEnterAlias()
			arg_7_0:init()
		end
	end

	arg_7_0.ConsumeRequest = ConsumeBangRequest:new()

	arg_7_0.ConsumeRequest:setResponseNormalHandler(var_7_0)
	arg_7_0.ConsumeRequest:request()
end

function var_0_1.requestNetWork(arg_9_0)
	local function var_9_0()
		local var_10_0 = arg_9_0.BangRequest:getRankInfo()

		arg_9_0:setData(var_10_0)

		if arg_9_0.type == var_0_2.eZhiZunBang then
			var_0_0.set("zhiZunBang_RankInfo", var_10_0.MyRank)
		elseif arg_9_0.type == var_0_2.eZhanShenBang then
			var_0_0.set("zhanShenBang_RankInfo", var_10_0.MyRank)
		elseif arg_9_0.type == var_0_2.eXianYuanBang then
			var_0_0.set("xianYuanBang_RankInfo", var_10_0.MyRank)
		end

		if var_10_0.MyRank == 0 then
			addLabelWithColorSize(arg_9_0, string.lf("我的排名：#00FF00未入榜 "), ccc3(255, 255, 255), 20, ccp(0.5, 0.5), ccp(80, 20))
		elseif var_10_0.MyRank > 0 then
			addLabelWithColorSize(arg_9_0, string.lf(string.lf("  我的排名:#00FF00%d", var_10_0.MyRank)), ccc3(255, 255, 255), 20, ccp(0.5, 0.5), ccp(80, 20))
		end

		if var_10_0.PowerRankResponse and table.nums(var_10_0.PowerRankResponse) ~= 0 then
			arg_9_0:onEnterAlias()
			arg_9_0:init()
		elseif var_10_0.LevelRankResponse and table.nums(var_10_0.LevelRankResponse) ~= 0 then
			arg_9_0:onEnterAlias()
			arg_9_0:init()
		elseif var_10_0.AdvanceRankResponse and table.nums(var_10_0.AdvanceRankResponse) ~= 0 then
			arg_9_0:onEnterAlias()
			arg_9_0:init()
		else
			showFlashNotice(string.lf("  暂无相关排行榜信息！ "))
		end
	end

	arg_9_0.BangRequest = RankingRequest:new()

	arg_9_0.BangRequest:setResponseNormalHandler(var_9_0)

	if arg_9_0.type == var_0_2.eZhiZunBang then
		arg_9_0.BangRequest:request(var_0_2.eZhiZunBang)
	elseif arg_9_0.type == var_0_2.eZhanShenBang then
		arg_9_0.BangRequest:request(var_0_2.eZhanShenBang)
	elseif arg_9_0.type == var_0_2.eXianYuanBang then
		arg_9_0.BangRequest:request(var_0_2.eXianYuanBang)
	end
end

function var_0_1.init(arg_11_0)
	local var_11_0

	if arg_11_0.type == var_0_2.eZhiZunBang then
		var_11_0 = display.newScale9Sprite(var_0_3.eZhiZunBang)

		var_11_0:setPosition(420, 490)
	elseif arg_11_0.type == var_0_2.eZhanShenBang then
		var_11_0 = display.newScale9Sprite(var_0_3.eZhanShenBang)

		var_11_0:setPosition(420, 488)
	elseif arg_11_0.type == var_0_2.eXianYuanBang then
		var_11_0 = display.newScale9Sprite(var_0_3.eXianYuanBang)

		var_11_0:setPosition(420, 490)
	elseif arg_11_0.type == var_0_2.eFuHaoBang then
		var_11_0 = display.newScale9Sprite(var_0_3.eFuHaoBang)

		var_11_0:setPosition(420, 490)
		addLabelWithColorSize(arg_11_0, string.lf("活动期间内，消费前十的玩家会获得奖励 "), ccc3(0, 0, 0), 17, ccp(0, 0), ccp(0, 475))
		addLabelWithColorSize(arg_11_0, string.lf("活动时间: %s - %s", var_0_0.get("startTime"), var_0_0.get("endTime")), ccc3(0, 0, 0), 15, ccp(0, 0), ccp(500, 475))
	elseif arg_11_0.type == var_0_2.eJiFenBang then
		var_11_0 = display.newScale9Sprite(var_0_3.eJiFenBang)

		var_11_0:setPosition(420, 490)
		addLabelWithColorSize(arg_11_0, string.lf("活动期间内，抽将会获得积分 "), ccc3(0, 0, 0), 17, ccp(0, 0), ccp(0, 475))
		addLabelWithColorSize(arg_11_0, string.lf("活动时间: %s - %s", var_0_0.get("startTime"), var_0_0.get("endTime")), ccc3(0, 0, 0), 15, ccp(0, 0), ccp(500, 475))
	end

	var_11_0:setScale(1.3)
	arg_11_0:addChild(var_11_0)

	arg_11_0.page = addLabelWithColorSize(arg_11_0, string.lf(string.format("%d/%d", arg_11_0.number, #arg_11_0.bangData)), ccc3(255, 255, 255), 20, ccp(0.5, 0.5), ccp(430, 20))

	local var_11_1 = {
		fontSize = 18,
		disabledImage = "ui/activity/activity_065.png",
		normalImage = "ui/activity/activity_064.png",
		size = CCSize(80, 30),
		text = string.lf("上一页"),
		clickAction = function(arg_12_0, arg_12_1)
			arg_11_0:reloadData(false)
		end
	}
	local var_11_2 = ui.newControlButton(var_11_1)

	var_11_2:setPosition(300, 20)
	arg_11_0:addChild(var_11_2)

	local var_11_3 = {
		fontSize = 18,
		disabledImage = "ui/activity/activity_065.png",
		normalImage = "ui/activity/activity_064.png",
		size = CCSize(80, 30),
		text = string.lf("下一页"),
		clickAction = function(arg_13_0, arg_13_1)
			arg_11_0:reloadData(true)
		end
	}
	local var_11_4 = ui.newControlButton(var_11_3)

	var_11_4:setPosition(560, 20)
	arg_11_0:addChild(var_11_4)
end

function var_0_1.onEnterAlias(arg_14_0)
	local var_14_0 = CCSize(900, 430)
	local var_14_1 = {
		direction = kCCScrollViewDirectionVertical,
		size = var_14_0,
		sizehandler = function(arg_15_0, arg_15_1)
			return CCSize(900, 80)
		end,
		cellhandler = handler(arg_14_0, arg_14_0.createCell),
		numberhandler = function(arg_16_0)
			local var_16_0 = arg_14_0.bangData[arg_14_0:getTag()]

			return var_16_0 and #var_16_0 or 0
		end
	}
	local var_14_2 = createTableView(var_14_1)

	var_14_2:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_14_2:setPosition(5, 45)
	arg_14_0:addChild(var_14_2)

	arg_14_0.tableview = var_14_2
end

function var_0_1.setTag(arg_17_0, arg_17_1)
	arg_17_0.tag = arg_17_1 or 1
end

function var_0_1.getTag(arg_18_0)
	return arg_18_0.tag
end

function var_0_1.reloadData(arg_19_0, arg_19_1)
	if arg_19_1 == true then
		arg_19_0.number = arg_19_0.number + 1

		if arg_19_0.number > #arg_19_0.bangData then
			arg_19_0.number = #arg_19_0.bangData
		end
	elseif arg_19_1 == false then
		arg_19_0.number = arg_19_0.number - 1

		if arg_19_0.number <= 0 then
			arg_19_0.number = 1
		end
	end

	arg_19_0:setTag(arg_19_0.number)
	arg_19_0.page:setString(string.lf(string.format("%d/%d", arg_19_0.number, #arg_19_0.bangData)))
	arg_19_0.tableview:reloadData()
end

function var_0_1.createCell(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = display.newScale9Sprite("ui/system/system_003.png")

	var_20_0:setPreferredSize(CCSize(885, 70))
	var_20_0:setAnchorPoint(ccp(0, 0))
	var_20_0:setPosition(5, 4)

	local var_20_1 = arg_20_0.bangData[arg_20_0:getTag()]
	local var_20_2 = string.format("%d", var_20_1[arg_20_2].Rank)
	local var_20_3 = display.newScale9Sprite("ui/common/common_139.png")
	local var_20_4 = addLabelWithColorSize(var_20_3, var_20_2, ccc3(255, 255, 255), 22, ccp(0.5, 0.5), ccp(50, 35))

	var_20_3:setPosition(CCPoint(40, 30))
	var_20_3:setScale(0.8)
	var_20_0:addChild(var_20_3)

	local var_20_5 = {
		type = ItemType.eHero,
		itemId = var_20_1[arg_20_2].HeadId,
		PlayerName = var_20_1[arg_20_2].PlayerName
	}
	local var_20_6 = figure.createHeader(var_20_5)

	var_20_6:setAnchorPoint(CCPoint(0, 0.5))
	var_20_6:setScale(0.8)
	var_20_6:setPosition(ccp(120, 35))
	var_20_0:addChild(var_20_6)

	local var_20_7 = 11

	if var_20_1[arg_20_2].VipLevel > 12 then
		var_20_7 = 8
	elseif var_20_1[arg_20_2].VipLevel <= 12 then
		var_20_7 = var_20_1[arg_20_2].VipLevel
	end

	local var_20_8 = display.newSprite(var_0_4[var_20_7])

	var_20_8:setScale(1.4)
	var_20_8:setAnchorPoint(CCPoint(0, 0.5))
	var_20_8:setPosition(160, 50)
	var_20_0:addChild(var_20_8)

	local var_20_9 = string.format("%s", var_20_1[arg_20_2].PlayerName)

	addLabelWithColorSize(var_20_0, string.lf(var_20_9), ccc3(0, 255, 0), 20, ccp(0, 0.5), ccp(160, 15))

	if arg_20_0.type == var_0_2.eZhiZunBang or arg_20_0.type == var_0_2.eFuHaoBang or arg_20_0.type == var_0_2.eJiFenBang then
		local var_20_10 = string.lf("#FFFFFF等级:#00FF00%d", var_20_1[arg_20_2].Level)

		addLabelWithColorSize(var_20_0, var_20_10, ccc3(0, 0, 0), 18, ccp(0, 0.5), ccp(260, 35))

		local var_20_11 = var_20_1[arg_20_2].UnionGroup
		local var_20_12

		if var_20_11 and string.len(var_20_11) > 0 then
			var_20_12 = string.lf("仙盟:#00FF00%s", var_20_11)
		else
			var_20_12 = string.lf("仙盟: #00FF00无")
		end

		addLabelWithColorSize(var_20_0, var_20_12, ccc3(0, 0, 0), 18, ccp(0, 0.5), ccp(355, 35))
	end

	if arg_20_0.type == var_0_2.eZhiZunBang then
		local var_20_13 = string.lf("战斗力:#00FF00%d", var_20_1[arg_20_2].Power)

		addLabelWithColorSize(var_20_0, var_20_13, ccc3(0, 0, 0), 18, ccp(0, 0.5), ccp(560, 35))
	elseif arg_20_0.type == var_0_2.eZhanShenBang then
		local var_20_14 = string.lf("战斗力:#00FF00%d", var_20_1[arg_20_2].Power)

		addLabelWithColorSize(var_20_0, var_20_14, ccc3(0, 0, 0), 18, ccp(0, 0.5), ccp(400, 35))
	elseif arg_20_0.type == var_0_2.eXianYuanBang then
		local var_20_15 = string.lf("#FFFFFF平均进阶:#00FF00%d", var_20_1[arg_20_2].AverageAdvance)

		addLabelWithColorSize(var_20_0, var_20_15, ccc3(0, 0, 0), 18, ccp(0, 0.5), ccp(280, 35))

		local var_20_16 = string.lf("最高:#00FF00%s", var_20_1[arg_20_2].MaxAdvanceHero)

		addLabelWithColorSize(var_20_0, var_20_16, ccc3(0, 0, 0), 18, ccp(0, 0.5), ccp(450, 35))
	elseif arg_20_0.type == var_0_2.eFuHaoBang then
		local var_20_17 = string.lf("消费:#00FF00%d元宝", var_20_1[arg_20_2].consume)

		addLabelWithColorSize(var_20_0, var_20_17, ccc3(0, 0, 0), 18, ccp(0, 0.5), ccp(560, 35))
	elseif arg_20_0.type == var_0_2.eJiFenBang then
		local var_20_18 = string.lf("积分:#00FF00%d", var_20_1[arg_20_2].consume)

		addLabelWithColorSize(var_20_0, var_20_18, ccc3(0, 0, 0), 18, ccp(0, 0.5), ccp(560, 35))
	end

	local var_20_19 = var_20_1[arg_20_2].RankChange

	local function var_20_20(arg_21_0, arg_21_1)
		local var_21_0 = string.format(" %d名", arg_21_0)
		local var_21_1 = display.newScale9Sprite("ui/common/common_140.png")
		local var_21_2 = display.newScale9Sprite("ui/common/common_142.png")

		if arg_21_1 == true then
			var_21_1:setScale(1.2)

			if arg_20_0.type == var_0_2.eXianYuanBang then
				var_21_1:setPosition(685, 35)
			elseif arg_20_0.type == var_0_2.eZhiZunBang then
				var_21_1:setPosition(735, 40)
			elseif arg_20_0.type == var_0_2.eZhanShenBang then
				var_21_1:setPosition(615, 40)
			end

			var_20_0:addChild(var_21_1)
		end

		if arg_21_1 == false then
			var_21_2:setScale(1.2)

			if arg_20_0.type == var_0_2.eXianYuanBang then
				var_21_2:setPosition(685, 35)
			elseif arg_20_0.type == var_0_2.eZhiZunBang then
				var_21_2:setPosition(735, 40)
			elseif arg_20_0.type == var_0_2.eZhanShenBang then
				var_21_2:setPosition(615, 40)
			end

			var_20_0:addChild(var_21_2)
		end

		if arg_20_0.type == var_0_2.eXianYuanBang then
			addLabelWithColorSize(var_20_0, tostring(var_21_0), ccc3(0, 0, 0), 18, ccp(0, 0.5), ccp(700, 35))
		elseif arg_20_0.type == var_0_2.eZhanShenBang then
			addLabelWithColorSize(var_20_0, tostring(var_21_0), ccc3(0, 0, 0), 18, ccp(0, 0.5), ccp(630, 35))
		elseif arg_20_0.type == var_0_2.eZhiZunBang then
			addLabelWithColorSize(var_20_0, tostring(var_21_0), ccc3(0, 0, 0), 18, ccp(0, 0.5), ccp(750, 35))
		end
	end

	if var_20_19 and var_20_19 > 0 then
		var_20_20(var_20_19, true)
	elseif var_20_19 and var_20_19 == 0 then
		-- block empty
	elseif var_20_19 and var_20_19 < 0 then
		local var_20_21 = var_20_19 * -1

		var_20_20(var_20_21, false)
	end

	local var_20_22 = ui.newControlButton({
		highlightedImage = "ui/common/common_027_2.png",
		fontSize = 22,
		normalImage = "ui/common/common_027.png",
		size = CCSize(80, 40),
		text = string.lf("查看"),
		clickAction = function()
			OthersTeamHelper:checkOthersTeam(var_20_1[arg_20_2].PlayerId, var_20_1[arg_20_2].PlayerName, OthersTeamHelper.eDataFromPHB)
		end,
		position = ccp(840, 35)
	})

	var_20_0:addChild(var_20_22)

	return var_20_0
end

return var_0_1
