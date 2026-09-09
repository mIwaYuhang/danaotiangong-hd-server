require("network.ChampionShipRequest")

local var_0_0 = require("base.cache")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = require("scenes.toollayer.tool")
local var_0_3 = require("scenes.toollayer.event")
local var_0_4 = require("scenes.ToolLayer")
local var_0_5 = require("scenes.toollayer.timer")
local var_0_6 = require("scenes.toollayer.model")
local var_0_7 = 1
local var_0_8 = {
	_left = false,
	_parent = false,
	_data = false,
	_right = false,
	setData = function(arg_1_0, arg_1_1)
		arg_1_1:on("gamble", function(...)
			arg_1_0._parent:dispatch(arg_1_0)
		end)

		arg_1_0._data = arg_1_1
	end,
	getData = function(arg_3_0)
		return arg_3_0._data
	end,
	setLeft = function(arg_4_0, arg_4_1)
		arg_4_1._parent = arg_4_0
		arg_4_0._left = arg_4_1
	end,
	getLeft = function(arg_5_0)
		return arg_5_0._left
	end,
	setRight = function(arg_6_0, arg_6_1)
		arg_6_1._parent = arg_6_0
		arg_6_0._right = arg_6_1
	end,
	getRight = function(arg_7_0)
		return arg_7_0._right
	end,
	getSibling = function(arg_8_0, arg_8_1)
		if arg_8_1 then
			if arg_8_1 == arg_8_0._left then
				return arg_8_0._right
			elseif arg_8_1 == arg_8_0._right then
				return arg_8_0._left
			end
		elseif arg_8_0._parent then
			return arg_8_0._parent:getSibling(arg_8_0)
		end
	end,
	dispatch = function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_1 == arg_9_0._left then
			arg_9_0._right._data:trigger("disabled")
		elseif arg_9_1 == arg_9_0._right then
			arg_9_0._left._data:trigger("disabled")
		end
	end,
	new = function(arg_10_0)
		local var_10_0 = {
			id = var_0_7,
			__index = arg_10_0,
			prototype = arg_10_0
		}

		var_0_7 = var_0_7 + 1

		return setmetatable(var_10_0, var_10_0)
	end
}
local var_0_9 = var_0_6:extend({
	attach = function(arg_11_0, arg_11_1)
		arg_11_0.timer = var_0_5:new()
		arg_11_0.battleValue = false
		arg_11_0.rewardRequest = XMGetGambleRequest:new(arg_11_1)

		arg_11_0.rewardRequest:setResponseNormalHandler(function()
			local var_12_0, var_12_1 = arg_11_0.rewardRequest:getResponseContent()

			arg_11_0.rewardValue:trigger("reward")
		end)
		arg_11_0.rewardRequest:setResponseExceptionHandler(function()
			arg_11_0.dirty = true
		end)

		arg_11_0.gambleRequest = XMJoinGambleRequest:new(arg_11_1)

		arg_11_0.gambleRequest:setResponseNormalHandler(function()
			local var_14_0, var_14_1 = arg_11_0.gambleRequest:getResponseContent()

			arg_11_0.gambleValue:trigger("gamble")
		end)
		arg_11_0.gambleRequest:setResponseExceptionHandler(function()
			arg_11_0.gambleValue.gamble = 0
			arg_11_0.dirty = true
		end)

		arg_11_0.battleRequest = XMBattleReportRequest:new(arg_11_1)

		arg_11_0.battleRequest:setResponseNormalHandler(function()
			local var_16_0, var_16_1 = arg_11_0.battleRequest:getResponseContent()
			local var_16_2 = var_16_1.battlereportInfos
			local var_16_3 = var_16_1.gambleInfos
			local var_16_4 = var_16_1.rank
			local var_16_5 = var_16_1.remainTime

			arg_11_0._users = {}

			if var_16_5 > 0 then
				var_16_5 = var_16_5 + 2

				arg_11_0.timer:after(var_16_5, function()
					arg_11_0:battleInfo()
				end)
				arg_11_0.timer:start()
			end

			arg_11_0.remain = var_16_5
			arg_11_0.rank = var_16_4
			arg_11_0.gambleInfos = var_16_3 or {}

			if arg_11_0.battleValue then
				arg_11_0:trigger("user", arg_11_0.battleValue, var_16_2)
			else
				local var_16_6 = arg_11_0:parse(var_16_2)

				if var_16_6 then
					arg_11_0:trigger("sync", var_16_6, arg_11_0.semifinal)
				else
					dump(var_16_2, "data" .. #var_16_2)
				end

				arg_11_0.tree = var_16_6
				arg_11_0.dirty = not arg_11_0.finished and var_16_5 > 0
			end
		end)
		arg_11_0.battleRequest:setResponseExceptionHandler(function()
			arg_11_0.dirty = true
		end)
	end,
	getGambleInfo = function(arg_19_0, arg_19_1)
		for iter_19_0, iter_19_1 in ipairs(arg_19_0.gambleInfos) do
			if iter_19_1.beBetPlayerID == arg_19_1.id and iter_19_1.rank == arg_19_1.rank then
				return iter_19_1
			end
		end
	end,
	touser = function(arg_20_0, arg_20_1, arg_20_2)
		local var_20_0 = false
		local var_20_1 = arg_20_1.rank
		local var_20_2 = arg_20_1.winnerID

		if not var_20_2 then
			if arg_20_2 == 0 then
				return
			end
		else
			var_20_0 = var_20_2 == arg_20_1.defendPlayerID
		end

		if arg_20_2 == -1 then
			arg_20_2 = true
		elseif arg_20_2 == 0 then
			if var_20_1 % 2 == 0 then
				var_20_1 = var_20_1 / 2
			end

			arg_20_2 = var_20_0
		else
			arg_20_2 = false
		end

		local var_20_3
		local var_20_4
		local var_20_5
		local var_20_6

		if arg_20_2 then
			var_20_3 = arg_20_1.defendPlayerID
			var_20_5 = {
				reward = 0,
				gamble = 0,
				id = arg_20_1.defendPlayerID,
				name = arg_20_1.defendName,
				header = arg_20_1.defendAvatarID,
				power = arg_20_1.defendBattlePower,
				rank = var_20_1
			}
		else
			var_20_3 = arg_20_1.attackPlayerID
			var_20_5 = {
				reward = 0,
				gamble = 0,
				id = arg_20_1.attackPlayerID,
				name = arg_20_1.attackName,
				header = arg_20_1.attackAvatarID,
				power = arg_20_1.attackBattlePower,
				rank = var_20_1
			}
			var_20_0 = not var_20_0
		end

		if var_20_2 then
			var_20_5.winner = var_20_0
		end

		local var_20_7 = var_20_3 .. "#" .. var_20_1
		local var_20_8 = arg_20_0._users[var_20_7]

		if not var_20_8 then
			var_20_8 = var_0_3:new(var_20_5)
			arg_20_0._users[var_20_7] = var_20_8

			var_20_8:on("disabled", function()
				var_20_8.gamble = -1
			end)
		end

		return var_20_8
	end,
	prepare = function(arg_22_0, arg_22_1)
		local var_22_0 = #arg_22_1
		local var_22_1 = arg_22_1[var_22_0].rank
		local var_22_2 = var_22_0 == 8
		local var_22_3 = {}

		arg_22_1[4], arg_22_1[2] = arg_22_1[2], arg_22_1[4]

		if var_22_2 then
			local var_22_4 = arg_22_1[8]

			if var_22_4 and var_22_4.rank == 2 then
				local var_22_5 = arg_22_0:touser(var_22_4, -1)
				local var_22_6 = arg_22_0:touser(var_22_4, 1)

				if var_22_4.winnerID == var_22_5.id then
					table.insert(var_22_3, var_22_5)
					table.insert(var_22_3, var_22_6)
				else
					table.insert(var_22_3, var_22_6)
					table.insert(var_22_3, var_22_5)
				end
			end

			local var_22_7 = arg_22_1[7]

			if var_22_7 and var_22_7.rank == 3 then
				local var_22_8 = arg_22_0:touser(var_22_7, -1)
				local var_22_9 = arg_22_0:touser(var_22_7, 1)

				if var_22_7.winnerID == var_22_8.id then
					table.insert(var_22_3, var_22_8)
					table.insert(var_22_3, var_22_9)
				else
					table.insert(var_22_3, var_22_9)
					table.insert(var_22_3, var_22_8)
				end
			end
		else
			local var_22_10 = {
				8,
				8,
				8,
				8,
				4,
				4,
				3,
				2
			}

			for iter_22_0 = 1, #var_22_10 do
				if not arg_22_1[iter_22_0] then
					table.insert(arg_22_1, {
						mock = true,
						rank = var_22_10[iter_22_0]
					})
				end
			end
		end

		if var_22_1 % 2 == 0 then
			if arg_22_1[var_22_0].winnerID then
				var_22_1 = var_22_1 / 2
			end
		elseif var_22_1 == 3 then
			var_22_1 = 2
		end

		arg_22_0.right4WinnerID = arg_22_1[2].winnerID
		arg_22_0.left4WinnerID = arg_22_1[4].winnerID
		arg_22_0.left2WinnerID = arg_22_1[6].winnerID
		arg_22_0.finished = var_22_2
		arg_22_0.semifinal = var_22_3
		arg_22_0.currentRank = var_22_1

		return arg_22_1
	end,
	swapDataByTree = function(arg_23_0, arg_23_1)
		local var_23_0 = arg_23_0.tree

		if type(var_23_0) == "table" then
			local var_23_1
			local var_23_2
			local var_23_3
			local var_23_4
			local var_23_5
			local var_23_6
			local var_23_7
			local var_23_8 = {
				var_23_0
			}
			local var_23_9 = {
				arg_23_1
			}

			while #var_23_9 > 0 do
				local var_23_10 = var_23_8[1]
				local var_23_11 = var_23_9[1]

				table.remove(var_23_8, 1)
				table.remove(var_23_9, 1)

				local var_23_12 = var_23_10:getLeft()
				local var_23_13 = var_23_11:getLeft()

				if var_23_12 then
					local var_23_14 = var_23_12:getData()
					local var_23_15 = var_23_13:getData()

					if var_23_14 and var_23_14.id and var_23_15 and var_23_15.id and var_23_14.id ~= var_23_15.id then
						local var_23_16 = var_23_11:getRight()

						var_23_11:setLeft(var_23_16)
						var_23_11:setRight(var_23_13)
					end
				end

				table.insert(var_23_8, var_23_10:getLeft())
				table.insert(var_23_8, var_23_10:getRight())
				table.insert(var_23_9, var_23_10:getLeft())
				table.insert(var_23_9, var_23_10:getRight())
			end
		end
	end,
	swapDataByUID = function(arg_24_0, arg_24_1, arg_24_2)
		local var_24_0 = arg_24_1.rank

		if var_24_0 == 2 then
			print("swap", arg_24_1.id, arg_24_0.left2WinnerID)

			if arg_24_1.id ~= arg_24_0.left2WinnerID then
				print("######swap user 2 left")

				arg_24_2, arg_24_1 = arg_24_1, arg_24_2
			end
		elseif var_24_0 == 4 then
			if arg_24_1.id == arg_24_0.left4WinnerID or arg_24_2.id == arg_24_0.left4WinnerID then
				if arg_24_1.id ~= arg_24_0.left4WinnerID then
					print("######swap user 4 left")

					arg_24_2, arg_24_1 = arg_24_1, arg_24_2
				end
			elseif (arg_24_1.id == arg_24_0.right4WinnerID or arg_24_2.id == arg_24_0.right4WinnerID) and arg_24_1.id ~= arg_24_0.right4WinnerID then
				print("######swap user 4 right")

				arg_24_2, arg_24_1 = arg_24_1, arg_24_2
			end
		end

		return arg_24_1, arg_24_2
	end,
	parse = function(arg_25_0, arg_25_1)
		if not arg_25_1 or #arg_25_1 < 1 then
			return
		end

		arg_25_1 = arg_25_0:prepare(arg_25_1)

		local var_25_0 = var_0_8:new()
		local var_25_1 = var_25_0
		local var_25_2 = {}
		local var_25_3
		local var_25_4
		local var_25_5 = 0
		local var_25_6 = #arg_25_1
		local var_25_7 = 1
		local var_25_8 = 30

		while var_25_7 < 15 do
			if var_25_8 > 0 then
				var_25_8 = var_25_8 - 1
			else
				break
			end

			for iter_25_0 = var_25_6, 1, -1 do
				local var_25_9 = arg_25_1[iter_25_0]

				if var_25_9.rank % 2 ~= 0 then
					print("do rank 3")
					table.remove(arg_25_1, iter_25_0)

					var_25_6 = var_25_6 - 1

					break
				elseif var_25_9.mock then
					print("do mock")
					var_25_1:setLeft(var_0_8:new())
					var_25_1:setRight(var_0_8:new())
					table.insert(var_25_2, var_25_1:getLeft())
					table.insert(var_25_2, var_25_1:getRight())

					var_25_7 = var_25_7 + 2
					var_25_1 = var_25_2[1]

					table.remove(var_25_2, 1)
					table.remove(arg_25_1, iter_25_0)

					var_25_6 = var_25_6 - 1

					break
				elseif not var_25_4 or var_25_4 == var_25_9.winnerID then
					print("do winner")

					if not var_25_1:getData() then
						local var_25_10 = arg_25_0:touser(var_25_9, 0)

						if var_25_10 then
							var_25_1:setData(var_25_10)
						end
					end

					local var_25_11 = arg_25_0:touser(var_25_9, 1)
					local var_25_12 = arg_25_0:touser(var_25_9, -1)
					local var_25_13, var_25_14 = arg_25_0:swapDataByUID(var_25_11, var_25_12)

					var_25_1:setLeft(var_0_8:new())
					var_25_1:getLeft():setData(var_25_13)
					var_25_1:setRight(var_0_8:new())
					var_25_1:getRight():setData(var_25_14)
					table.insert(var_25_2, var_25_1:getLeft())
					table.insert(var_25_2, var_25_1:getRight())

					var_25_7 = var_25_7 + 2
					var_25_1 = var_25_2[1]

					if var_25_1:getData() then
						var_25_4 = var_25_1:getData().id
					end

					table.remove(var_25_2, 1)
					table.remove(arg_25_1, iter_25_0)

					var_25_6 = var_25_6 - 1

					break
				end
			end
		end

		return var_25_0
	end,
	sync = function(arg_26_0)
		if arg_26_0.dirty then
			arg_26_0:battleInfo()
		else
			arg_26_0:trigger("sync", arg_26_0.tree, arg_26_0.semifinal)
		end
	end,
	battleInfo = function(arg_27_0, arg_27_1)
		local var_27_0 = 0

		if arg_27_1 and arg_27_1.id then
			arg_27_0.battleValue = arg_27_1

			local var_27_1 = 0

			userId = arg_27_1.id

			arg_27_0.battleRequest:request(var_27_1, arg_27_1.id)
		else
			local var_27_2 = 2

			arg_27_0.battleValue = false

			arg_27_0.battleRequest:request(var_27_2)
		end
	end,
	joinGamble = function(arg_28_0, arg_28_1, arg_28_2)
		arg_28_1.gamble = arg_28_2
		arg_28_0.gambleValue = arg_28_1

		arg_28_0.gambleRequest:request(arg_28_1.id, arg_28_1.rank, arg_28_2)
	end,
	getReward = function(arg_29_0, arg_29_1)
		arg_29_0.rewardValue = arg_29_1

		arg_29_0.rewardRequest:request(arg_29_1.id, arg_29_1.rank)
	end
})
local var_0_10 = class("CSGambleScene", function()
	return display.newScene("CSGambleScene")
end)

function var_0_10.ctor(arg_31_0, arg_31_1)
	arg_31_0._lines = {}
	arg_31_0._holders = {}
	arg_31_0._marks = {}

	if arg_31_1 and arg_31_1.from then
		arg_31_0._from = arg_31_1.from
	else
		arg_31_0._from = "CSHomeScene"
	end

	arg_31_0.model = var_0_0.get(arg_31_0)

	if not arg_31_0.model then
		arg_31_0.model = var_0_9:new()

		var_0_0.set(arg_31_0, arg_31_0.model)
	end

	arg_31_0.model:attach(arg_31_0)
	arg_31_0:onEnterAlias()
end

function var_0_10.onEnterAlias(arg_32_0)
	local var_32_0 = require("scenes.CommonBgLayer").new({
		titleSprite = "uilocal/PK/PK_text_025.png",
		returnAction = function()
			game.enterCSHomeScene()
		end
	})
	local var_32_1 = var_32_0:getBackgroundSprite()
	local var_32_2 = var_32_1:getContentSize()

	arg_32_0:addChild(var_32_0)

	local var_32_3 = display.newSprite("ui/PK/PK_043.jpg")

	var_32_3:setPosition(ccp(var_32_2.width / 2, var_32_2.height / 2 - 30))
	var_32_1:addChild(var_32_3)

	local var_32_4 = display.newSprite("ui/PK/PK_042.png")

	var_32_4:setPosition(ccp(var_32_2.width / 2, var_32_2.height / 2 - 30))
	var_32_1:addChild(var_32_4)

	local var_32_5 = var_32_4:getContentSize()

	arg_32_0.container = var_32_4

	local var_32_6 = var_32_5.width / 2
	local var_32_7 = var_32_5.height / 2 + 10

	arg_32_0._cx, arg_32_0._cy = var_32_6, var_32_7

	local var_32_8 = ccc3(220, 250, 190)
	local var_32_9 = var_0_1.newLabel({
		text = string.lf("仙魔争霸排行榜"),
		color = var_32_8
	})

	var_32_9:setPosition(var_32_6 + 15, var_32_5.height - 25)
	var_32_4:addChild(var_32_9)

	arg_32_0.timeLabel = var_32_9

	local var_32_10 = var_0_1.newLabel({
		text = string.lf("我的排名：0"),
		color = var_32_8
	})

	var_32_10:setPosition(var_32_6 + 15, var_32_5.height - 50)
	var_32_4:addChild(var_32_10)

	arg_32_0.rankLabel = var_32_10

	local var_32_11 = ui.newControlButton({
		disabledImage = "ui/common/common_080.png",
		normalImage = "ui/common/common_019.png",
		text = string.lf("512强"),
		fontSize = ColorTable.eTitleButton_FontSize2,
		textColor = ColorTable.eTitleButton_Normal2,
		clickAction = function(arg_34_0, arg_34_1)
			game.enterCSBattleScene()
		end
	})

	var_32_11:setPosition(var_32_6, 70)
	var_32_4:addChild(var_32_11)
	arg_32_0:showHolderView()
	arg_32_0.model:on("user", arg_32_0.onUser, arg_32_0)
	arg_32_0.model:on("sync", arg_32_0.onSync, arg_32_0)
	arg_32_0.model:sync()
end

function var_0_10.onExit(arg_35_0)
	arg_35_0.model:detach()
end

function var_0_10.reset(arg_36_0)
	local var_36_0 = arg_36_0._lines
	local var_36_1 = arg_36_0._holders
	local var_36_2 = arg_36_0._marks

	arg_36_0._colors = {}
	arg_36_0._index = 1

	for iter_36_0 = #var_36_2, 1, -1 do
		var_36_2[iter_36_0]:removeFromParent()
		table.remove(var_36_2, iter_36_0)
	end

	for iter_36_1 = #var_36_0, 1, -1 do
		var_36_0[iter_36_1]:removeFromParent()
		table.remove(var_36_0, iter_36_1)
	end

	for iter_36_2, iter_36_3 in ipairs(var_36_1) do
		if iter_36_3.header then
			iter_36_3.header:removeFromParent()
		end
	end
end

function var_0_10.onSync(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0:reset()

	local var_37_0 = 1
	local var_37_1
	local var_37_2 = {
		arg_37_1
	}
	local var_37_3 = arg_37_0._colors
	local var_37_4 = #arg_37_2
	local var_37_5 = var_0_2.array(var_37_4, 0)
	local var_37_6 = arg_37_0.model.remain
	local var_37_7 = arg_37_0.model.currentRank

	if var_37_6 > 0 then
		arg_37_0.model.timer:schedule(var_37_6, function(arg_38_0, arg_38_1)
			local var_38_0 = var_37_7 == 2 and string.lf("决赛进行中: ") or string.lf("%d强比赛进行中:", var_37_7)

			arg_37_0.timeLabel:setString(var_38_0 .. formatTime(arg_38_1))
		end, function()
			return
		end)
	else
		arg_37_0.timeLabel:setString(string.lf("仙魔争霸排行榜"))
	end

	local var_37_8
	local var_37_9 = arg_37_0.model.rank

	if var_37_9 ~= 0 then
		if var_37_9 == 1 then
			var_37_8 = string.lf("我的排名: 冠军")
		elseif var_37_9 == 2 then
			var_37_8 = string.lf("我的排名: 亚军")
		elseif var_37_9 == 3 then
			var_37_8 = string.lf("我的排名: 季军")
		else
			var_37_8 = string.lf("我的排名: %s强", var_37_9)
		end
	else
		var_37_8 = string.lf("我的排名: 无")
	end

	arg_37_0.rankLabel:setString(var_37_8)

	while #var_37_2 > 0 do
		local var_37_10 = var_37_2[1]

		table.remove(var_37_2, 1)

		if var_37_10:getLeft() then
			table.insert(var_37_2, var_37_10:getLeft())
		end

		if var_37_10:getRight() then
			table.insert(var_37_2, var_37_10:getRight())
		end

		if var_37_10:getData() then
			local var_37_11 = var_37_10:getData().id
			local var_37_12 = arg_37_0:indexToRank(var_37_0)

			arg_37_0:showHeader(var_37_0, var_37_10:getData())

			if var_37_10:getData().winner == false then
				table.insert(var_37_3, false)
			else
				table.insert(var_37_3, true)
			end

			if var_37_4 > 0 then
				for iter_37_0 = 1, #arg_37_2 do
					if arg_37_2[iter_37_0].id == var_37_11 and var_37_5[iter_37_0] == 0 then
						var_37_4 = var_37_4 - 1
						var_37_5[iter_37_0] = var_37_0

						break
					end
				end
			end
		else
			table.insert(var_37_3, true)
		end

		var_37_0 = var_37_0 + 1
	end

	local var_37_13 = 1

	var_0_2.foreach(var_37_5, function(arg_40_0, arg_40_1, arg_40_2)
		local var_40_0 = var_37_13

		var_37_13 = var_37_13 + 1

		arg_37_0:rankAnimation(arg_40_1, var_40_0, arg_40_2)
	end)
	table.insert(var_37_3, 4, true)
	table.insert(var_37_3, 4, true)
	table.insert(var_37_3, 10, true)
	table.insert(var_37_3, 10, true)
	table.insert(var_37_3, 10, true)
	table.insert(var_37_3, 10, true)
	table.insert(var_37_3, 22, var_37_3[14])
	table.insert(var_37_3, 23, var_37_3[15])
	table.insert(var_37_3, 24, var_37_3[16])
	table.insert(var_37_3, 25, var_37_3[17])
	table.insert(var_37_3, 26, var_37_3[18])
	table.insert(var_37_3, 27, var_37_3[19])
	table.insert(var_37_3, 28, var_37_3[20])
	table.insert(var_37_3, 29, var_37_3[21])
	arg_37_0:showGridView()
end

function var_0_10.onUser(arg_41_0, arg_41_1, arg_41_2)
	var_0_4.createDialog({
		data = arg_41_1,
		battle = arg_41_2,
		show = var_0_4.eShowCSBattle
	}):show()
end

function var_0_10.indexToRank(arg_42_0, arg_42_1)
	local var_42_0 = 0

	return arg_42_1 == 1 and 1 or arg_42_1 < 4 and 2 or arg_42_1 < 8 and 4 or 8
end

function var_0_10.showHeader(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = ccc3(0, 195, 10)
	local var_43_1 = ccc3(240, 240, 180)
	local var_43_2 = arg_43_0._holders[arg_43_1]
	local var_43_3, var_43_4 = var_43_2:getPosition()
	local var_43_5 = CCSize(82, 82)
	local var_43_6 = var_0_1.newNode()

	var_43_6:setContentSize(var_43_5)
	var_43_2:addChild(var_43_6)

	var_43_2.header = var_43_6

	local var_43_7 = getItemHeaderImagePath(ItemType.eHero, arg_43_2.header)
	local var_43_8 = ui.newControlButton({
		normalImage = var_43_7,
		clickAction = function(arg_44_0, arg_44_1)
			arg_43_0.model:battleInfo(arg_43_2)
		end
	})

	var_43_8:setPosition(var_43_5.width / 2, var_43_5.height / 2)
	var_43_6:addChild(var_43_8)

	local var_43_9 = CCSize(150, 30)
	local var_43_10 = display.newScale9Sprite("ui/PK/PK_052.png")

	var_43_10:setContentSize(var_43_9)
	var_43_10:setPosition(var_43_5.width / 2, -18)
	var_43_6:addChild(var_43_10)

	local var_43_11 = var_0_1.newLabel({
		text = arg_43_2.name,
		color = Player.userId == arg_43_2.id and var_43_0 or var_43_1
	})

	var_43_11:setPosition(var_43_9.width / 2, var_43_9.height / 2)
	var_43_10:addChild(var_43_11)

	local var_43_12 = not arg_43_0.model.finished and arg_43_1 > 1 and arg_43_0.model.currentRank == arg_43_2.rank and arg_43_2.gamble ~= -1
	local var_43_13 = arg_43_0.model:getGambleInfo(arg_43_2)

	if var_43_13 then
		arg_43_2.gamble = var_43_13.gold
		arg_43_2.reward = var_43_13.state
		var_43_12 = true
	end

	if var_43_12 then
		local var_43_14 = {
			normalImage = "ui/PK/PK_038.png",
			clickAction = function(arg_45_0, arg_45_1)
				var_0_4.createDialog({
					data = arg_43_2,
					show = var_0_4.eShowCSGamble,
					callback = function(arg_46_0)
						if arg_43_2.reward == 1 then
							arg_43_0.model:getReward(arg_43_2)
						elseif arg_43_2.gamble == 0 then
							arg_43_0.model:joinGamble(arg_43_2, arg_46_0)
						end
					end
				}):show()
			end
		}

		if arg_43_2.gamble > 0 and arg_43_2.reward == 1 then
			var_43_14.normalImage = "ui/activity/activity_009.png"
		end

		local var_43_15 = ui.newControlButton(var_43_14)

		var_43_15:setPosition(var_43_3 > 468 and -25 or var_43_5.width + 25, var_43_5.height / 2)
		var_43_6:addChild(var_43_15)

		if arg_43_2.reward == 0 then
			local var_43_16

			if arg_43_2.gamble == 0 then
				var_43_16 = "uilocal/PK/PK_text_026.png"
			else
				var_43_16 = "uilocal/PK/PK_text_028.png"

				arg_43_2:trigger("gamble")
			end

			local var_43_17 = var_43_15:getContentSize()
			local var_43_18 = display.newSprite(var_43_16)

			var_43_18:setPosition(var_43_17.width / 2, var_43_17.height / 2)
			var_43_15:addChild(var_43_18)

			var_43_15.label = var_43_18
		end

		arg_43_2:on("gamble", function()
			var_43_15.label:removeFromParent()

			local var_47_0 = "uilocal/PK/PK_text_028.png"
			local var_47_1 = display.newSprite(var_47_0)
			local var_47_2 = var_43_15:getContentSize()

			var_47_1:setPosition(var_47_2.width / 2, var_47_2.height / 2)
			var_43_15:addChild(var_47_1)

			var_43_15.label = var_47_1
		end)
		arg_43_2:on("reward", function()
			var_43_15:removeFromParent()
		end)
		arg_43_2:on("disabled", function()
			var_43_15:removeFromParent()
		end)
	end
end

function var_0_10.showGridView(arg_50_0, arg_50_1)
	arg_50_0:showRankView(true, arg_50_1)
end

function var_0_10.showHolderView(arg_51_0, arg_51_1)
	arg_51_0:showRankView(false, arg_51_1)
end

function var_0_10.showRankView(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = {
		arg_52_0.showFirst,
		arg_52_0.showSecond,
		arg_52_0.showFourth,
		arg_52_0.showEighth
	}

	var_0_2.foreach(var_52_0, function(arg_53_0, arg_53_1, arg_53_2)
		arg_53_1(arg_52_0, arg_52_1, arg_53_2)
	end, arg_52_2)
end

function var_0_10.showFirst(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0 = arg_54_0._cx
	local var_54_1 = arg_54_0._cy

	if arg_54_1 then
		local var_54_2 = {
			var_54_0,
			var_54_1 - 2,
			var_54_0,
			var_54_1 + 128,
			"back"
		}

		arg_54_0:showLines(var_54_2, arg_54_2)
	else
		local var_54_3 = {
			var_54_0,
			var_54_1 + 128
		}

		arg_54_0:showHolders(var_54_3, arg_54_2)
	end
end

function var_0_10.showSecond(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = arg_55_0._cx
	local var_55_1 = arg_55_0._cy

	if arg_55_1 then
		local var_55_2 = {
			var_55_0 - 130,
			var_55_1,
			var_55_0 - 2,
			var_55_1,
			"back",
			var_55_0 + 2,
			var_55_1,
			var_55_0 + 130,
			var_55_1,
			"to"
		}

		arg_55_0:showLines(var_55_2, arg_55_2)
	else
		local var_55_3 = {
			var_55_0 - 133,
			var_55_1,
			var_55_0 + 133,
			var_55_1
		}

		arg_55_0:showHolders(var_55_3, arg_55_2)
	end
end

function var_0_10.showFourth(arg_56_0, arg_56_1, arg_56_2)
	local var_56_0 = arg_56_0._cx
	local var_56_1 = arg_56_0._cy

	if arg_56_1 then
		local var_56_2 = {
			var_56_0 - 223,
			var_56_1,
			var_56_0 - 130,
			var_56_1,
			"back",
			var_56_0 + 130,
			var_56_1,
			var_56_0 + 222,
			var_56_1,
			"to"
		}
		local var_56_3 = {
			var_56_0 - 220,
			var_56_1 + 2,
			var_56_0 - 220,
			var_56_1 + 133,
			"to",
			var_56_0 - 220,
			var_56_1 - 2,
			var_56_0 - 220,
			var_56_1 - 133,
			"back",
			var_56_0 + 220,
			var_56_1 + 2,
			var_56_0 + 220,
			var_56_1 + 133,
			"to",
			var_56_0 + 220,
			var_56_1 - 2,
			var_56_0 + 220,
			var_56_1 - 133,
			"back"
		}

		var_0_2.foreach({
			var_56_2,
			var_56_3
		}, function(arg_57_0, arg_57_1, arg_57_2)
			arg_56_0:showLines(arg_57_1, arg_57_2)
		end, arg_56_2)
	else
		local var_56_4 = {
			var_56_0 - 220,
			var_56_1 + 133,
			var_56_0 - 220,
			var_56_1 - 133,
			var_56_0 + 220,
			var_56_1 + 133,
			var_56_0 + 220,
			var_56_1 - 133
		}

		arg_56_0:showHolders(var_56_4, arg_56_2)
	end
end

function var_0_10.showEighth(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = arg_58_0._cx
	local var_58_1 = arg_58_0._cy

	if arg_58_1 then
		local var_58_2 = {
			var_58_0 - 220 - 92,
			var_58_1 + 133,
			var_58_0 - 220,
			var_58_1 + 133,
			"back",
			var_58_0 - 220 - 92,
			var_58_1 - 133,
			var_58_0 - 220,
			var_58_1 - 133,
			"back",
			var_58_0 + 220,
			var_58_1 + 133,
			var_58_0 + 220 + 92,
			var_58_1 + 133,
			"to",
			var_58_0 + 220,
			var_58_1 - 133,
			var_58_0 + 220 + 92,
			var_58_1 - 133,
			"to"
		}
		local var_58_3 = {
			var_58_0 - 220 - 90,
			var_58_1 + 135,
			var_58_0 - 220 - 90,
			var_58_1 + 133 + 69,
			"to",
			var_58_0 - 220 - 90,
			var_58_1 + 131,
			var_58_0 - 220 - 90,
			var_58_1 + 133 - 69,
			"back",
			var_58_0 - 220 - 90,
			var_58_1 - 131,
			var_58_0 - 220 - 90,
			var_58_1 - 133 + 69,
			"to",
			var_58_0 - 220 - 90,
			var_58_1 - 135,
			var_58_0 - 220 - 90,
			var_58_1 - 133 - 69,
			"back",
			var_58_0 + 220 + 90,
			var_58_1 + 135,
			var_58_0 + 220 + 90,
			var_58_1 + 133 + 69,
			"to",
			var_58_0 + 220 + 90,
			var_58_1 + 131,
			var_58_0 + 220 + 90,
			var_58_1 + 133 - 69,
			"back",
			var_58_0 + 220 + 90,
			var_58_1 - 131,
			var_58_0 + 220 + 90,
			var_58_1 - 133 + 69,
			"to",
			var_58_0 + 220 + 90,
			var_58_1 - 135,
			var_58_0 + 220 + 90,
			var_58_1 - 133 - 69,
			"back"
		}
		local var_58_4 = {
			var_58_0 - 220 - 90 - 70,
			var_58_1 + 133 + 66,
			var_58_0 - 220 - 90,
			var_58_1 + 133 + 66,
			"back",
			var_58_0 - 220 - 90 - 70,
			var_58_1 + 133 - 67,
			var_58_0 - 220 - 90,
			var_58_1 + 133 - 67,
			"back",
			var_58_0 - 220 - 90 - 70,
			var_58_1 - 133 + 66,
			var_58_0 - 220 - 90,
			var_58_1 - 133 + 66,
			"back",
			var_58_0 - 220 - 90 - 70,
			var_58_1 - 133 - 67,
			var_58_0 - 220 - 90,
			var_58_1 - 133 - 67,
			"back",
			var_58_0 + 220 + 90,
			var_58_1 + 133 + 66,
			var_58_0 + 220 + 90 + 70,
			var_58_1 + 133 + 66,
			"to",
			var_58_0 + 220 + 90,
			var_58_1 + 133 - 67,
			var_58_0 + 220 + 90 + 70,
			var_58_1 + 133 - 67,
			"to",
			var_58_0 + 220 + 90,
			var_58_1 - 133 + 66,
			var_58_0 + 220 + 90 + 70,
			var_58_1 - 133 + 66,
			"to",
			var_58_0 + 220 + 90,
			var_58_1 - 133 - 67,
			var_58_0 + 220 + 90 + 70,
			var_58_1 - 133 - 67,
			"to"
		}

		var_0_2.foreach({
			var_58_2,
			var_58_3,
			var_58_4
		}, function(arg_59_0, arg_59_1, arg_59_2)
			arg_58_0:showLines(arg_59_1, arg_59_2)
		end, arg_58_2)
	else
		local var_58_5 = {
			var_58_0 - 220 - 90 - 70,
			var_58_1 + 133 + 66,
			var_58_0 - 220 - 90 - 70,
			var_58_1 + 133 - 66,
			var_58_0 - 220 - 90 - 70,
			var_58_1 - 133 + 66,
			var_58_0 - 220 - 90 - 70,
			var_58_1 - 133 - 66,
			var_58_0 + 220 + 90 + 70,
			var_58_1 + 133 + 66,
			var_58_0 + 220 + 90 + 70,
			var_58_1 + 133 - 66,
			var_58_0 + 220 + 90 + 70,
			var_58_1 - 133 + 66,
			var_58_0 + 220 + 90 + 70,
			var_58_1 - 133 - 66
		}

		arg_58_0:showHolders(var_58_5, arg_58_2)
	end
end

function var_0_10.showHolders(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = arg_60_0.container
	local var_60_1 = 1
	local var_60_2 = #arg_60_1
	local var_60_3
	local var_60_4 = var_0_2.wait("event", var_60_2 / 2, arg_60_2)

	while var_60_1 <= var_60_2 do
		local var_60_5 = arg_60_0:newHolder(arg_60_1[var_60_1], arg_60_1[var_60_1 + 1])

		var_60_0:addChild(var_60_5, 1)
		var_60_4()

		var_60_1 = var_60_1 + 2
	end
end

function var_0_10.newHolder(arg_61_0, arg_61_1, arg_61_2)
	local var_61_0 = CCSize(82, 82)
	local var_61_1 = CCScale9Sprite:create("ui/common/bg_figure_blue.png")

	var_61_1:setPreferredSize(var_61_0)
	var_61_1:setPosition(arg_61_1, arg_61_2)
	table.insert(arg_61_0._holders, var_61_1)

	return var_61_1
end

function var_0_10.showLines(arg_62_0, arg_62_1, arg_62_2)
	local var_62_0 = arg_62_0.container
	local var_62_1 = arg_62_0._colors
	local var_62_2 = arg_62_0._index
	local var_62_3 = 1
	local var_62_4 = #arg_62_1
	local var_62_5
	local var_62_6 = {
		x = 0,
		y = 0
	}
	local var_62_7 = {
		x = 0,
		y = 0
	}
	local var_62_8 = var_0_2.wait("event", var_62_4 / 5, arg_62_2)

	while var_62_3 <= var_62_4 do
		var_62_6.x, var_62_6.y = arg_62_1[var_62_3], arg_62_1[var_62_3 + 1]
		var_62_7.x, var_62_7.y = arg_62_1[var_62_3 + 2], arg_62_1[var_62_3 + 3]

		local var_62_9 = arg_62_1[var_62_3 + 4]
		local var_62_10 = arg_62_0:newLine(var_62_6, var_62_7, var_62_1[var_62_2])

		arg_62_0:lineAnimation(var_62_10, var_62_9, var_62_8)
		var_62_0:addChild(var_62_10)

		var_62_2 = var_62_2 + 1
		var_62_3 = var_62_3 + 5
	end

	arg_62_0._index = var_62_2
end

function var_0_10.newLine(arg_63_0, arg_63_1, arg_63_2, arg_63_3)
	local var_63_0 = 5
	local var_63_1 = CCPoint(0, 0)
	local var_63_2 = CCSize(0, 0)
	local var_63_3 = "ui/PK/PK_040.png"
	local var_63_4 = "ui/PK/PK_041.png"
	local var_63_5

	if arg_63_1.x == arg_63_2.x then
		local var_63_6 = math.abs(arg_63_1.y - arg_63_2.y)

		var_63_2.width, var_63_2.height = var_63_0, var_63_6
	elseif arg_63_1.y == arg_63_2.y then
		var_63_2.width, var_63_2.height = math.abs(arg_63_1.x - arg_63_2.x), var_63_0
	end

	local var_63_7 = display.newScale9Sprite(arg_63_3 == false and var_63_3 or var_63_4)

	var_63_7:setPreferredSize(var_63_2)

	var_63_1.x, var_63_1.y = (arg_63_1.x + arg_63_2.x) / 2, (arg_63_1.y + arg_63_2.y) / 2

	var_63_7:setPosition(var_63_1)
	table.insert(arg_63_0._lines, var_63_7)

	return var_63_7
end

function var_0_10.lineAnimation(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	local var_64_0 = arg_64_1:getBoundingBox()
	local var_64_1 = var_64_0.origin
	local var_64_2 = var_64_0.size
	local var_64_3 = ccp(0, 0)
	local var_64_4 = 0
	local var_64_5 = 0.4
	local var_64_6
	local var_64_7 = 1
	local var_64_8 = 0
	local var_64_9 = var_64_2.width > var_64_2.height and "width" or "height"

	if arg_64_2 == "to" then
		if var_64_2.width > var_64_2.height then
			var_64_3.x, var_64_3.y = 0, 0.5
		else
			var_64_3.x, var_64_3.y = 0.5, 0
		end
	elseif arg_64_2 == "back" then
		if var_64_2.width > var_64_2.height then
			var_64_3.x, var_64_3.y = 1, 0.5
		else
			var_64_3.x, var_64_3.y = 0.5, 1
		end
	elseif arg_64_2 == "expand" then
		var_64_3.x = 0.5
		var_64_3.y = 0.5
	end

	arg_64_1:setAnchorPoint(var_64_3)

	var_64_1.x, var_64_1.y = var_64_1.x + var_64_2.width * var_64_3.x, var_64_1.y + var_64_2.height * var_64_3.y

	arg_64_1:setPosition(var_64_1.x, var_64_1.y)

	local var_64_10 = var_64_2[var_64_9]

	var_64_2[var_64_9] = var_64_7

	local var_64_11 = (var_64_10 - var_64_7) / var_64_5

	arg_64_1:setContentSize(var_64_2)
	arg_64_1:scheduleUpdate(function(arg_65_0)
		local var_65_0 = var_64_11 * arg_65_0
		local var_65_1 = arg_64_1:getContentSize()
		local var_65_2 = var_65_1[var_64_9] + var_65_0

		if var_65_0 > 0 and var_65_2 < var_64_10 or var_65_0 < 0 and var_65_2 > var_64_10 then
			var_65_1[var_64_9] = var_65_2

			arg_64_1:setContentSize(var_65_1)
		else
			var_65_1[var_64_9] = var_64_10

			arg_64_1:setContentSize(var_65_1)
			arg_64_1:unscheduleUpdate()

			return arg_64_3 and arg_64_3()
		end
	end)
end

function var_0_10.rankAnimation(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
	local var_66_0 = ({
		"uilocal/PK/PK_text_012.png",
		"uilocal/PK/PK_text_013.png",
		"uilocal/PK/PK_text_014.png",
		"uilocal/PK/PK_text_029.png"
	})[arg_66_2]
	local var_66_1 = arg_66_0._holders[arg_66_1]
	local var_66_2 = arg_66_0.container

	if var_66_0 and var_66_1 then
		local var_66_3 = var_66_2:getContentSize()
		local var_66_4 = display.newSprite(var_66_0)
		local var_66_5, var_66_6 = var_66_1:getPosition()
		local var_66_7 = var_66_1:getContentSize()

		var_66_1:setZOrder(16 - arg_66_2)
		var_66_4:setOpacity(0)
		var_66_4:setScale(10)
		var_66_4:setAnchorPoint(ccp(0.5, 0))
		var_66_4:setPosition(var_66_3.width / 2, var_66_3.height / 2 - 50)
		var_66_2:addChild(var_66_4)

		local var_66_8 = CCArray:create()
		local var_66_9 = CCScaleTo:create(0.3, 0.85)
		local var_66_10 = CCMoveTo:create(0.3, ccp(var_66_5, var_66_6 + var_66_7.height / 2 - 10))
		local var_66_11 = CCFadeTo:create(0.3, 255)

		var_66_8:addObject(var_66_9)
		var_66_8:addObject(var_66_10)
		var_66_8:addObject(var_66_11)

		local var_66_12 = CCSpawn:create(var_66_8)
		local var_66_13 = CCCallFunc:create(function()
			var_66_4:removeFromParent()
			var_66_4:setPosition(var_66_7.width / 2, var_66_7.height - 10)
			var_66_1:addChild(var_66_4)

			return arg_66_3 and arg_66_3()
		end)
		local var_66_14 = CCArray:create()

		var_66_14:addObject(var_66_12)
		var_66_14:addObject(var_66_13)
		var_66_4:runAction(CCSequence:create(var_66_14))
		table.insert(arg_66_0._marks, var_66_4)
	end
end

return var_0_10
