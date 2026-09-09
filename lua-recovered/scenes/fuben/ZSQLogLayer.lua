require("network.FubenRequest")
require("scenes.team.OthersTeamHelper")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = class("ZSQLogLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create(ccc4(10, 10, 10, 160)))
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		return true
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	local var_2_0 = display.newSprite("ui/fuben/zsq_004.png")
	local var_2_1 = var_2_0:getContentSize()

	var_2_0:align(display.CENTER, display.cx, display.cy)
	var_2_0:setScale(Adapter.MinScale)
	arg_2_0:addChild(var_2_0)

	arg_2_0.bgSprite = var_2_0
	arg_2_0.nodeSize = var_2_1
	arg_2_0.logList = {}

	local var_2_2 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		position = ccp(var_2_1.width - 10, var_2_1.height - 10),
		clickAction = function()
			arg_2_0:removeFromParent()
		end
	})

	var_2_0:addChild(var_2_2, 1)

	arg_2_0.playerId = arg_2_1 and arg_2_1.playerId and arg_2_1.playerId or nil
	arg_2_0.playerName = arg_2_1 and arg_2_1.playerName and arg_2_1.playerName or nil
	arg_2_0.avatarId = arg_2_1 and arg_2_1.avatarId and arg_2_1.avatarId or nil

	if arg_2_0.playerId == nil or arg_2_0.playerName == nil or arg_2_0.avatarId == nil then
		return
	end

	arg_2_0:initRequests()
	arg_2_0.reportsRequest:request(arg_2_0.playerId)
	arg_2_0:showPlayerInfo(var_2_0)
	arg_2_0:createTableView(var_2_0)
end

function var_0_1.initRequests(arg_5_0)
	local function var_5_0()
		arg_5_0.logList = arg_5_0.reportsRequest.restable

		arg_5_0.tableview:reloadData(arg_5_0.logList)
	end

	arg_5_0.reportsRequest = ZSQReportsRequest:new()

	arg_5_0.reportsRequest:setResponseNormalHandler(var_5_0)
end

function var_0_1.showPlayerInfo(arg_7_0, arg_7_1)
	local var_7_0 = {
		isName = false,
		count = 0,
		inTeam = false,
		noTypeImage = false,
		itemId = arg_7_0.avatarId,
		type = ItemType.eHero
	}

	figureNode = figure.createHeader(var_7_0)

	figureNode:setPosition(185, 285)
	arg_7_1:addChild(figureNode)
	addLabelWithColorSize(arg_7_1, arg_7_0.playerName, ccc3(0, 255, 0), 20, CCPoint(0, 0.5), CCPoint(230, 300))

	local var_7_1 = {
		fontSize = 20,
		normalImage = "ui/shenqi/sq_032.png",
		text = string.lf("阵容"),
		position = CCPoint(265, 265),
		clickAction = function()
			OthersTeamHelper:checkOthersTeam(arg_7_0.playerId, arg_7_0.playerName, OthersTeamHelper.eDataFromZSQ)
		end
	}
	local var_7_2 = ui.newControlButton(var_7_1)

	arg_7_1:addChild(var_7_2)
end

function var_0_1.createTableView(arg_9_0, arg_9_1)
	arg_9_0.cellSize = CCSize(450, 50)

	local var_9_0 = createTableView({
		reverse = true,
		size = CCSize(450, 215),
		direction = kCCScrollViewDirectionVertical,
		dataset = arg_9_0.logList,
		sizehandler = function(arg_10_0, arg_10_1)
			return arg_9_0.cellSize
		end,
		cellhandler = handler(arg_9_0, arg_9_0.showLogCell)
	})

	var_9_0:setAnchorPoint(CCPoint(0, 0))
	var_9_0:setPosition(22, 15)
	arg_9_1:addChild(var_9_0)

	arg_9_0.tableview = var_9_0
end

function var_0_1.showLogCell(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = CCLayerColor:create(ccc4(0, 0, 0, 0))

	var_11_0:setContentSize(arg_11_0.cellSize)

	local var_11_1 = getFullLogContent(arg_11_3.Content, arg_11_3.Type)
	local var_11_2 = addLabelWithColorSize(var_11_0, var_11_1, ccc3(247, 211, 91), 18, CCPoint(0.5, 0.5), CCPoint(arg_11_0.cellSize.width / 2, arg_11_0.cellSize.height / 2))

	var_11_2:setDimensions(CCSize(arg_11_0.cellSize.width - 10, arg_11_0.cellSize.height))
	var_11_2:setHorizontalAlignment(kCCTextAlignmentLeft)
	var_11_2:setVerticalAlignment(kCCVerticalTextAlignmentCenter)

	return var_11_0
end

return var_0_1
