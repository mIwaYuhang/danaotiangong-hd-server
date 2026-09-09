require("base.figure")
require("network.PkRequest")
require("network.TowerRequest")
require("scenes.team.OthersTeamHelper")

DlgRankType = {
	rankArena = 1,
	rankTower = 2
}

local var_0_0 = class("DlgRankLayer", function()
	return CCLayerColor:create(ccc4(10, 10, 10, 160))
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0._closecallback = arg_2_1.closecallback

	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	local var_2_0 = display.newScale9Sprite("ui/common/common_040.png")

	arg_2_0.bgSize = CCSize(850, 500)

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
			if arg_2_0._closecallback then
				arg_2_0._closecallback()
			end

			arg_2_0:removeFromParentAndCleanup(true)
		end
	})

	var_2_0:addChild(var_2_1)

	arg_2_0.rankList = {}

	arg_2_0:initRequests()
	arg_2_0:refreshLayer(arg_2_1)
end

function var_0_0.refreshLayer(arg_5_0, arg_5_1)
	arg_5_0.background:removeAllChildrenWithCleanup(true)

	arg_5_0.nType = arg_5_1.type

	local var_5_0 = ""

	addLabelWithColorSize(arg_5_0.background, string.lf("排名"), ccc3(212, 88, 16), 25, CCPoint(0.5, 0), CCPoint(100, 455))
	addLabelWithColorSize(arg_5_0.background, string.lf("名称"), ccc3(212, 88, 16), 25, CCPoint(0.5, 0), CCPoint(210, 455))
	addLabelWithColorSize(arg_5_0.background, string.lf("等级"), ccc3(212, 88, 16), 25, CCPoint(0.5, 0), CCPoint(400, 455))
	addLabelWithColorSize(arg_5_0.background, string.lf("战力"), ccc3(212, 88, 16), 25, CCPoint(0.5, 0), CCPoint(500, 455))

	if arg_5_0.nType == DlgRankType.rankArena then
		arg_5_0.duelTopTenRequest:request()
	elseif arg_5_0.nType == DlgRankType.rankTower then
		addLabelWithColorSize(arg_5_0.background, string.lf("最高层数"), ccc3(212, 88, 16), 25, CCPoint(0.5, 0), CCPoint(600, 455))
		arg_5_0.rankInfoRequest:request()
	end

	arg_5_0:addTableView()
end

function var_0_0.initRequests(arg_6_0)
	local function var_6_0()
		arg_6_0.rankList = {}

		for iter_7_0, iter_7_1 in pairs(arg_6_0.duelTopTenRequest.restable) do
			local var_7_0 = {
				userId = iter_7_1.PlayerId,
				rank = iter_7_1.Ranking,
				name = iter_7_1.PlayerName,
				level = iter_7_1.Level,
				power = iter_7_1.Fighting
			}

			var_7_0.detail = nil

			table.insert(arg_6_0.rankList, var_7_0)
		end

		arg_6_0.tableView:reloadData()
	end

	arg_6_0.duelTopTenRequest = DuelTopTenRequest:new()

	arg_6_0.duelTopTenRequest:setResponseNormalHandler(var_6_0)

	local function var_6_1()
		arg_6_0.rankList = {}

		for iter_8_0, iter_8_1 in pairs(arg_6_0.rankInfoRequest.restable) do
			local var_8_0 = {
				userId = iter_8_1.playerID,
				rank = iter_8_1.rank,
				name = iter_8_1.name,
				level = iter_8_1.level,
				power = iter_8_1.battlePower,
				detail = iter_8_1.maxFloor
			}

			table.insert(arg_6_0.rankList, var_8_0)
		end

		arg_6_0.tableView:reloadData()
	end

	arg_6_0.rankInfoRequest = RankingInfoRequest:new()

	arg_6_0.rankInfoRequest:setResponseNormalHandler(var_6_1)

	local function var_6_2()
		arg_6_0.rankList = {}

		for iter_9_0, iter_9_1 in pairs(arg_6_0.lastweekRankRequest.restable) do
			local var_9_0 = {
				userId = iter_9_1.playerID,
				rank = iter_9_1.rank,
				name = iter_9_1.name,
				level = iter_9_1.level,
				power = iter_9_1.battlePower,
				detail = iter_9_1.maxFloor
			}

			table.insert(arg_6_0.rankList, var_9_0)
		end

		arg_6_0.tableView:reloadData()
	end

	arg_6_0.lastweekRankRequest = LastWeekRankingRequest:new()

	arg_6_0.lastweekRankRequest:setResponseNormalHandler(var_6_2)
end

function var_0_0.addPlayerRankInfo(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0
	local var_10_1

	if arg_10_3 == 0 then
		var_10_0 = display.newSprite("ui/system/system_001.png")
	elseif arg_10_3 == 1 then
		var_10_0 = display.newSprite("ui/system/system_002.png")
	elseif arg_10_3 == 2 then
		var_10_0 = display.newSprite("ui/system/system_003.png")
	else
		var_10_0 = display.newSprite("ui/system/system_004.png")
	end

	var_10_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_10_0:setPosition(CCPoint(405, 35))
	arg_10_1:addChild(var_10_0)

	local var_10_2 = var_10_0:getContentSize()
	local var_10_3

	if arg_10_2 == 1 then
		var_10_3 = display.newSprite("uilocal/tower/tower_text_003.png")
	elseif arg_10_2 == 2 then
		var_10_3 = display.newSprite("uilocal/tower/tower_text_004.png")
	elseif arg_10_2 == 3 then
		var_10_3 = display.newSprite("uilocal/tower/tower_text_005.png")
	else
		var_10_3 = CCLabelAtlas:create(tostring(arg_10_2), "uilocal/PK/PK_text_005.png", 27.1, 37, 48)
	end

	var_10_3:setAnchorPoint(CCPoint(0.5, 0.5))
	var_10_3:setPosition(CCPoint(70, var_10_2.height / 2))
	var_10_0:addChild(var_10_3)

	return var_10_0, var_10_2
end

function var_0_0.addTableView(arg_11_0)
	local function var_11_0(arg_12_0)
		return 70, 810
	end

	local function var_11_1(arg_13_0)
		return table.nums(arg_11_0.rankList)
	end

	local function var_11_2(arg_14_0, arg_14_1)
		local var_14_0 = arg_14_0:cellAtIndex(arg_14_1)
		local var_14_1 = arg_11_0.rankList[arg_14_1 + 1]

		if var_14_0 == nil then
			var_14_0 = CCTableViewCell:new()

			local var_14_2
			local var_14_3
			local var_14_4, var_14_5 = arg_11_0:addPlayerRankInfo(var_14_0, var_14_1.rank, arg_14_1)

			addLabelWithColorSize(var_14_4, var_14_1.name, ccc3(255, 255, 255), 25, CCPoint(0, 0.5), CCPoint(160, var_14_5.height / 2))
			addLabelWithColorSize(var_14_4, var_14_1.level, ccc3(255, 255, 255), 25, CCPoint(0.5, 0.5), CCPoint(375, var_14_5.height / 2))
			addLabelWithColorSize(var_14_4, var_14_1.power, ccc3(255, 255, 255), 25, CCPoint(0.5, 0.5), CCPoint(475, var_14_5.height / 2))

			if var_14_1.detail then
				addLabelWithColorSize(var_14_4, var_14_1.detail, ccc3(255, 255, 255), 25, CCPoint(0.5, 0.5), CCPoint(580, var_14_5.height / 2))
			end

			local var_14_6 = ui.newControlButton({
				fontSize = 25,
				normalImage = "ui/common/common_027.png",
				highlightedImage = "ui/common/common_027.png",
				text = string.lf("阵容"),
				position = CCPoint(720, var_14_5.height / 2),
				clickAction = function()
					if arg_11_0.nType == DlgRankType.rankTower then
						OthersTeamHelper:checkOthersTeam(var_14_1.userId, var_14_1.name, OthersTeamHelper.eDataFromTower)
					elseif arg_11_0.nType == DlgRankType.rankArena then
						OthersTeamHelper:checkOthersTeam(var_14_1.userId, var_14_1.name, OthersTeamHelper.eDataFromPK)
					end
				end,
				anchorPoint = CCPoint(0.5, 0.5)
			})

			var_14_4:addChild(var_14_6)
		end

		return var_14_0
	end

	if arg_11_0.tableView then
		arg_11_0.tableView:reloadData()

		return
	end

	local var_11_3, var_11_4 = var_11_0(nil)

	arg_11_0.tableView = CCTableView:create(CCSize(810, 443))

	arg_11_0.tableView:setContentSize(CCSize(810, var_11_1(nil) * var_11_3))
	arg_11_0.tableView:setPosition(CCPoint(20, 5))
	arg_11_0.tableView:setVerticalFillOrder(kCCTableViewFillTopDown)
	arg_11_0.tableView:setDirection(kCCScrollViewDirectionVertical)
	arg_11_0.background:addChild(arg_11_0.tableView)
	arg_11_0.tableView:registerScriptHandler(var_11_0, CCTableView.kTableCellSizeForIndex)
	arg_11_0.tableView:registerScriptHandler(var_11_1, CCTableView.kNumberOfCellsInTableView)
	arg_11_0.tableView:registerScriptHandler(var_11_2, CCTableView.kTableCellSizeAtIndex)
	arg_11_0.tableView:reloadData()
	arg_11_0.tableView:setContentOffset(arg_11_0.tableView:minContainerOffset())
end

return var_0_0
