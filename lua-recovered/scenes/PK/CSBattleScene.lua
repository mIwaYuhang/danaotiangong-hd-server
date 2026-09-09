require("network.ChampionShipRequest")

local var_0_0 = require("base.cache")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = require("scenes.toollayer.timer")
local var_0_3 = require("scenes.toollayer.model"):extend({
	eighth = false,
	previous = 0,
	attach = function(arg_1_0, arg_1_1)
		arg_1_0.timer = var_0_2:new()
		arg_1_0.request = XMBattleReportRequest:new(arg_1_1)

		arg_1_0.request:setResponseNormalHandler(function()
			local var_2_0, var_2_1 = arg_1_0.request:getResponseContent()
			local var_2_2 = var_2_1.battlereportInfos
			local var_2_3 = var_2_1.gambleInfos
			local var_2_4 = var_2_1.rank
			local var_2_5 = var_2_1.remainTime
			local var_2_6 = #var_2_2
			local var_2_7 = 0
			local var_2_8

			var_2_8 = var_2_6 == 0 and 0 or var_2_2[var_2_6].rank

			if var_2_5 > 0 then
				var_2_5 = var_2_5 + 2

				arg_1_0.timer:after(var_2_5, function()
					arg_1_0:battleInfo()
				end)
				arg_1_0.timer:start()

				arg_1_0.eighth = false
			elseif arg_1_0.remain and arg_1_0.remain > 0 then
				arg_1_0.eighth = true
				arg_1_0.dirty = false

				arg_1_0:trigger("eighth")
			else
				arg_1_0.eighth = true
				arg_1_0.dirty = false
			end

			arg_1_0.remain = var_2_5
			arg_1_0.rank = var_2_4

			arg_1_0:trigger("sync", var_2_2, var_2_6 - arg_1_0.previous)

			arg_1_0.battles = var_2_2
			arg_1_0.previous = var_2_6
		end)
		arg_1_0.request:setResponseExceptionHandler(function()
			arg_1_0.dirty = true
		end)
	end,
	isEnd = function(arg_5_0, arg_5_1)
		local var_5_0 = 0

		for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
			if iter_5_1.rank == 16 then
				var_5_0 = var_5_0 + 1
			end
		end

		return var_5_0 == 8
	end,
	sync = function(arg_6_0)
		if arg_6_0.dirty then
			arg_6_0:battleInfo()
		else
			arg_6_0:trigger("sync", arg_6_0.battles, 0)
		end
	end,
	battleInfo = function(arg_7_0)
		local var_7_0 = 1

		arg_7_0.request:request(var_7_0)
	end
})
local var_0_4 = class("CSBattleScene", function()
	return display.newScene("CSBattleScene")
end)

function var_0_4.ctor(arg_9_0, arg_9_1)
	arg_9_0.model = var_0_0.get(arg_9_0)

	if not arg_9_0.model then
		arg_9_0.model = var_0_3:new()

		var_0_0.set(arg_9_0, arg_9_0.model)
	end

	arg_9_0.model:attach(arg_9_0)
	arg_9_0:onEnterAlias()
end

function var_0_4.onEnterAlias(arg_10_0)
	local var_10_0 = require("scenes.CommonBgLayer").new({
		titleSprite = "uilocal/PK/PK_text_025.png",
		returnAction = function()
			game.enterCSHomeScene()
		end
	})
	local var_10_1 = var_10_0:getBackgroundSprite()
	local var_10_2 = var_10_1:getContentSize()

	arg_10_0:addChild(var_10_0)

	arg_10_0.container = var_10_1

	local var_10_3 = display.newSprite("ui/PK/PK_043.jpg")
	local var_10_4 = var_10_3:getContentSize()

	var_10_3:setPosition(ccp(var_10_2.width / 2, var_10_2.height / 2 - 30))
	var_10_1:addChild(var_10_3)

	local var_10_5 = display.newSprite("ui/PK/PK_045.png")

	var_10_5:setPosition(110, var_10_4.height - 40)
	var_10_3:addChild(var_10_5)

	local var_10_6 = var_10_5:getContentSize()
	local var_10_7 = var_0_1.newLabel({
		text = string.lf("我的排名: 0 强")
	})

	var_10_7:setPosition(var_10_6.width / 2, var_10_6.height / 2)
	var_10_5:addChild(var_10_7)

	arg_10_0.rankLabel = var_10_7

	local var_10_8 = display.newSprite("ui/PK/PK_045.png")

	var_10_8:setPosition(110, var_10_4.height - 100)
	var_10_3:addChild(var_10_8)

	local var_10_9 = var_10_8:getContentSize()
	local var_10_10 = var_0_1.newLabel({
		text = string.lf("战报更新: 00:00:00")
	})

	var_10_10:setPosition(var_10_9.width / 2, var_10_9.height / 2)
	var_10_8:addChild(var_10_10)

	arg_10_0.timeLabel = var_10_10

	local var_10_11 = {
		"uilocal/PK/PK_text_021.png",
		"uilocal/PK/PK_text_023.png",
		"uilocal/PK/PK_text_022.png"
	}
	local var_10_12 = var_0_0.get("cs-dao")
	local var_10_13 = display.newSprite(var_10_11[var_10_12])

	var_10_13:setPosition(var_10_4.width - 110, var_10_4.height - 50)
	var_10_3:addChild(var_10_13)

	local var_10_14 = ui.newControlButton({
		normalImage = "ui/task/task_005.png",
		clickAction = function(arg_12_0, arg_12_1)
			if arg_10_0.model.eighth then
				game.enterCSGambleScene()
			else
				ui.showMessageBox({
					text = string.lf("上仙，8强比赛还没有开始！")
				})
			end
		end
	})

	var_10_14:setPosition(var_10_4.width - 100, var_10_4.height - 130)
	var_10_3:addChild(var_10_14)

	local var_10_15 = var_0_1.newLabel({
		text = string.lf("8强战报"),
		size = ColorTable.eTitleButton_FontSize,
		color = ColorTable.eTitleButton_Normal,
		font = _FONT_PANGWA
	})

	var_10_15:setPosition(100, 30)
	var_10_14:addChild(var_10_15)

	local var_10_16 = arg_10_0:createBattleList()

	var_10_16:setPosition(var_10_4.width / 2, var_10_4.height / 2)
	var_10_3:addChild(var_10_16)
	arg_10_0.model:on("sync", arg_10_0.onSync, arg_10_0)
	arg_10_0.model:on("eighth", arg_10_0.onEighth, arg_10_0)
	arg_10_0.model:sync()
end

function var_0_4.onExit(arg_13_0)
	arg_13_0.model:detach()
end

function var_0_4.onEighth(arg_14_0)
	game.enterCSGambleScene()
end

function var_0_4.onSync(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = #arg_15_1
	local var_15_1 = arg_15_0.tableview

	var_15_1:reloadData(arg_15_1)

	if arg_15_0.model.remain > 0 then
		arg_15_0.model.timer:schedule(arg_15_0.model.remain, function(arg_16_0, arg_16_1)
			arg_15_0.timeLabel:setString(string.lf("战报更新: %s", formatTime(arg_16_1)))
		end, function()
			return
		end)
	else
		arg_15_0.timeLabel:setString(string.lf("战报更新完毕"))
	end

	if arg_15_0.model.battleOffset then
		var_15_1:setContentOffset(arg_15_0.model.battleOffset)

		arg_15_0.model.battleOffset = false
	elseif arg_15_2 > 0 then
		local var_15_2 = var_15_1:maxContainerOffset()
		local var_15_3 = var_15_1:minContainerOffset()
		local var_15_4 = var_15_2.y

		var_15_2.y = var_15_4 - math.min(arg_15_2, 5) * 160

		var_15_1:setContentOffset(var_15_2)

		if var_15_3.y > 0 then
			var_15_2.y = var_15_3.y
		else
			var_15_2.y = var_15_4
		end

		var_15_1:setContentOffsetInDuration(var_15_2, 0.8)
	else
		local var_15_5 = var_15_1:minContainerOffset()
		local var_15_6 = var_15_1:maxContainerOffset()

		if var_15_6.y < var_15_5.y then
			var_15_6.y = var_15_5.y
		end

		var_15_1:setContentOffset(var_15_6)
	end

	local var_15_7
	local var_15_8 = arg_15_0.model.rank

	if var_15_8 ~= 0 then
		if var_15_8 == 1 then
			var_15_7 = string.lf("我的排名: 冠军")
		elseif var_15_8 == 2 then
			var_15_7 = string.lf("我的排名: 亚军")
		elseif var_15_8 == 3 then
			var_15_7 = string.lf("我的排名: 季军")
		else
			var_15_7 = string.lf("我的排名: %d 强", var_15_8)
		end
	else
		var_15_7 = string.lf("我的排名: 无")
	end

	arg_15_0.rankLabel:setString(var_15_7)
end

function var_0_4.createBattleList(arg_18_0)
	local var_18_0 = display.newSprite("ui/PK/PK_037.png")
	local var_18_1 = var_18_0:getContentSize()

	var_18_1.height = var_18_1.height - 8

	local var_18_2 = {
		direction = kCCScrollViewDirectionVertical,
		size = var_18_1,
		sizehandler = function(arg_19_0, arg_19_1)
			return CCSize(var_18_1.width, 160)
		end,
		cellhandler = handler(arg_18_0, arg_18_0.createBattleItem)
	}
	local var_18_3 = createTableView(var_18_2)

	var_18_3:setPosition(0, 4)
	var_18_0:addChild(var_18_3)

	arg_18_0.tableview = var_18_3

	return var_18_0
end

function var_0_4.createBattleItem(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = Player.userId == arg_20_3.attackPlayerID or Player.userId == arg_20_3.defendPlayerID
	local var_20_1 = display.newSprite(var_20_0 and "ui/PK/PK_053.png" or "ui/PK/PK_032.png")
	local var_20_2 = var_20_1:getContentSize()
	local var_20_3 = CCSize(82, 82)

	var_20_1:setAnchorPoint(ccp(0, 0))
	var_20_1:setPosition(5, 0)

	local var_20_4 = var_0_1.newLabel({
		text = string.lf("%d强", arg_20_3.rank)
	})

	var_20_4:setPosition(var_20_2.width / 2, var_20_2.height - 20)
	var_20_1:addChild(var_20_4)

	local var_20_5 = 0
	local var_20_6 = CCScale9Sprite:create("ui/common/bg_figure_blue.png")

	var_20_6:setPreferredSize(var_20_3)
	var_20_6:setPosition(70, 95)
	var_20_1:addChild(var_20_6)

	if arg_20_3.attackBattlePower > 0 then
		arg_20_0:showHeader(var_20_6, {
			type = false,
			id = arg_20_3.attackPlayerID,
			name = arg_20_3.attackName,
			header = arg_20_3.attackAvatarID,
			power = arg_20_3.attackBattlePower,
			status = arg_20_3.winnerID == arg_20_3.attackPlayerID
		})

		var_20_5 = var_20_5 + 1
	else
		local var_20_7 = display.newSprite("ui/PK/PK_032_1.png")

		var_20_7:setPosition(var_20_3.width / 2, var_20_3.height / 2)
		var_20_6:addChild(var_20_7)
	end

	local var_20_8 = CCScale9Sprite:create("ui/common/bg_figure_blue.png")

	var_20_8:setPreferredSize(var_20_3)
	var_20_8:setPosition(var_20_2.width - 70, 95)
	var_20_1:addChild(var_20_8)

	if arg_20_3.defendBattlePower > 0 then
		arg_20_0:showHeader(var_20_8, {
			type = true,
			id = arg_20_3.defendPlayerID,
			name = arg_20_3.defendName,
			header = arg_20_3.defendAvatarID,
			power = arg_20_3.defendBattlePower,
			status = arg_20_3.winnerID == arg_20_3.defendPlayerID
		})

		var_20_5 = var_20_5 + 1
	else
		local var_20_9 = display.newSprite("ui/PK/PK_032_1.png")

		var_20_9:setPosition(var_20_3.width / 2, var_20_3.height / 2)
		var_20_8:addChild(var_20_9)
	end

	local var_20_10 = ui.newControlButton({
		normalImage = "ui/PK/PK_031.png",
		text = string.lf("查看"),
		clickAction = function(arg_21_0, arg_21_1)
			arg_20_0.model.battleOffset = arg_20_0.tableview:getContentOffset()

			arg_20_0:startBattle(arg_20_3.attackPlayerID, arg_20_3.defendPlayerID)
		end
	})

	var_20_10:setEnabled(var_20_5 == 2)
	var_20_10:setPosition(var_20_2.width / 2, 25)
	var_20_1:addChild(var_20_10)

	return var_20_1
end

function var_0_4.showHeader(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = ccc3(0, 195, 10)
	local var_22_1 = ccc3(240, 240, 180)
	local var_22_2 = arg_22_1:getContentSize()
	local var_22_3 = Player.userId == arg_22_2.id
	local var_22_4 = getItemHeaderImagePath(ItemType.eHero, arg_22_2.header)
	local var_22_5 = ui.newControlButton({
		normalImage = var_22_4,
		clickAction = function(arg_23_0, arg_23_1)
			return
		end
	})

	var_22_5:setPosition(var_22_2.width / 2, var_22_2.height / 2)
	arg_22_1:addChild(var_22_5)

	local var_22_6 = var_0_1.newLabel({
		text = arg_22_2.name,
		color = var_22_3 and var_22_0 or var_22_1
	})

	var_22_6:setPosition(var_22_2.width / 2, -12)
	arg_22_1:addChild(var_22_6)

	local var_22_7 = var_0_1.newLabel({
		text = string.lf("战力: %d", arg_22_2.power),
		color = var_22_3 and var_22_0 or var_22_1
	})

	var_22_7:setPosition(var_22_2.width / 2, -34)
	arg_22_1:addChild(var_22_7)

	local var_22_8 = display.newSprite(arg_22_2.status and "ui/PK/PK_035.png" or "ui/PK/PK_036.png")

	var_22_8:setPosition(20, 75)
	arg_22_1:addChild(var_22_8)

	local var_22_9 = display.newSprite(arg_22_2.type and "ui/PK/PK_033.png" or "ui/PK/PK_034.png")

	var_22_9:setPosition(80, 10)
	arg_22_1:addChild(var_22_9)
end

function var_0_4.startBattle(arg_24_0, arg_24_1, arg_24_2)
	BattleOperator:startBattle(eBattleType.ChampionShip, {
		rankType = 1,
		attackPlayerID = arg_24_1,
		defendPlayerID = arg_24_2
	}, function(arg_25_0, arg_25_1)
		game.enterCSBattleScene()
	end)
end

return var_0_4
