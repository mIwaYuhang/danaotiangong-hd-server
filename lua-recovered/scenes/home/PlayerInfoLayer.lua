require("network.PlayerRequest")

local var_0_0 = require("scenes.toollayer.event")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = require("scenes.toollayer.timer")
local var_0_3 = class("PlayerInfoLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

function var_0_3.ctor(arg_2_0, arg_2_1)
	arg_2_0:setNodeEventEnabled(true)

	arg_2_0.timer = var_0_2:new()
	arg_2_0.index = Player.headerTeamIndex
	arg_2_0.callback = arg_2_1.callback

	arg_2_0:init()
end

function var_0_3.init(arg_3_0)
	local var_3_0 = display.newSprite("ui/home/home_060.png")

	var_3_0:setAnchorPoint(ccp(0, 0))
	var_3_0:setScale(Adapter.AutoScaleY)

	local var_3_1 = var_3_0:getContentSize()

	arg_3_0:addChild(var_3_0)

	arg_3_0.container = var_3_0

	local var_3_2 = arg_3_0:createCountNode()

	var_3_2:setPosition(22, 378)
	var_3_0:addChild(var_3_2)

	local var_3_3 = arg_3_0:createInfoNode()

	var_3_3:setPosition(20, 282)
	var_3_0:addChild(var_3_3)

	local var_3_4 = var_0_1.newLabel({
		size = 20,
		text = string.lf("请选择头像"),
		font = _FONT_DEFAULT
	})

	var_3_4:setPosition(var_3_1.width / 2, 268)
	var_3_0:addChild(var_3_4)

	local var_3_5 = arg_3_0:createAvatarList()

	var_3_5:setPosition(11, 60)
	var_3_0:addChild(var_3_5)

	local var_3_6 = ui.newControlButton({
		disabledImage = "ui/common/common_115.png",
		normalImage = "ui/common/common_115.png",
		text = string.lf("确定"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function()
			arg_3_0.request:requestAvatarIndex(arg_3_0.index)
		end
	})

	var_3_6:setPosition(var_3_1.width / 2, 35)
	var_3_0:addChild(var_3_6)
	arg_3_0:addTouchEventListener(handler(arg_3_0, arg_3_0.touchhandler), false, 1, true)
	arg_3_0:setTouchEnabled(true)

	arg_3_0.request = PlayerAvatarRequest:new()

	arg_3_0.request:setResponseNormalHandler(function()
		arg_3_0:onExit(true)
	end)
	arg_3_0.request:setResponseExceptionHandler(function()
		print("网络请求发生错误")
		arg_3_0.callback(Player.headerTeamIndex)
	end)
end

function var_0_3.onExit(arg_7_0, arg_7_1)
	arg_7_0:setNodeEventEnabled(false)

	if arg_7_1 then
		Player:setHeaderTeamIndex(arg_7_0.index)
	else
		arg_7_0.callback(Player.headerTeamIndex)
	end

	arg_7_0.timer:stop()
	arg_7_0:removeFromParent()
end

function var_0_3.createCountNode(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = {
		"curGold",
		"curCoin",
		"knowledge",
		"soulJade"
	}
	local var_8_2 = ccc3(235, 251, 166)

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		local var_8_3 = var_0_1.newLabel({
			text = Player[iter_8_1],
			color = var_8_2
		})

		table.insert(var_8_0, var_8_3)
	end

	return var_0_1.tableLayout({
		row = 2,
		col = 2,
		nodes = var_8_0,
		size = CCSize(300, 55),
		padding = {
			top = 0,
			bottom = 0,
			left = 30,
			right = 0
		},
		align = display.LEFT_CENTER
	})
end

function var_0_3.createInfoNode(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = 16
	local var_9_2 = ccc3(235, 251, 166)
	local var_9_3 = 0

	for iter_9_0, iter_9_1 in ipairs(Player.team.groupList) do
		if iter_9_1.heroId and iter_9_1.heroId > 0 then
			var_9_3 = var_9_3 + 1
		end
	end

	local var_9_4 = {
		string.lf("上阵主将:"),
		var_9_3,
		string.lf("当前体力:"),
		Player.curPower,
		string.lf("角色ID:"),
		Player.playerPromoterId,
		string.lf("体力恢复时间:"),
		formatTime(Player.powerRestoreTime),
		string.lf("体力全部回满:"),
		formatTime(Player.powerRestoreTotalTime)
	}
	local var_9_5
	local var_9_6

	for iter_9_2, iter_9_3 in ipairs(var_9_4) do
		if iter_9_2 % 2 == 0 then
			var_9_5 = var_9_2
		else
			var_9_5 = nil
		end

		local var_9_7 = var_0_1.newLabel({
			text = iter_9_3,
			size = var_9_1,
			color = var_9_5
		})

		table.insert(var_9_0, var_9_7)
	end

	var_9_0[1] = var_0_1.linearLayout({
		margin = 10,
		nodes = {
			var_9_0[1],
			var_9_0[2]
		}
	})

	table.remove(var_9_0, 2)

	var_9_0[2] = var_0_1.linearLayout({
		margin = 10,
		nodes = {
			var_9_0[2],
			var_9_0[3]
		}
	})

	table.remove(var_9_0, 3)

	if Player.powerRestoreTotalTime > 0 then
		arg_9_0.timer:update(function()
			if Player.powerRestoreTotalTime > 0 then
				var_9_0[6]:setString(formatTime(Player.powerRestoreTime))
				var_9_0[8]:setString(formatTime(Player.powerRestoreTotalTime))
			else
				var_9_0[6]:setString(string.lf("体力已回满"))
				var_9_0[8]:setString(string.lf("体力已回满"))
				arg_9_0.timer:stop()
			end
		end)
		arg_9_0.timer:start()
	else
		var_9_0[6]:setString(string.lf("体力已回满"))
		var_9_0[8]:setString(string.lf("体力已回满"))
	end

	return var_0_1.tableLayout({
		row = 0,
		col = 2,
		nodes = var_9_0,
		size = CCSize(300, 50),
		align = display.LEFT_CENTER
	})
end

function var_0_3.createAvatarList(arg_11_0)
	local var_11_0 = {}
	local var_11_1
	local var_11_2
	local var_11_3
	local var_11_4

	for iter_11_0 = 1, 6 do
		local var_11_5 = display.newSprite("ui/home/home_061.png")

		table.insert(var_11_0, var_11_5)
	end

	local var_11_6 = var_11_0[1]:getContentSize()

	for iter_11_1, iter_11_2 in ipairs(Player.team.groupList) do
		if iter_11_2.heroId < 1 then
			break
		end

		local var_11_7 = getItemHeaderImagePath(ItemType.eHero, iter_11_2.heroId)
		local var_11_8 = ui.newControlButton({
			normalImage = var_11_7,
			clickAction = function(arg_12_0, arg_12_1)
				arg_12_1 = tolua.cast(arg_12_1, "CCControlButton")
				arg_11_0.index = arg_12_1:getTag()

				arg_11_0.callback(arg_11_0.index)
			end
		})

		var_11_8:setTag(iter_11_1)
		var_11_8:setPosition(var_11_6.width / 2, var_11_6.height / 2)
		var_11_0[iter_11_1]:addChild(var_11_8)
	end

	return var_0_1.tableLayout({
		row = 2,
		col = 3,
		nodes = var_11_0,
		size = CCSize(320, 190)
	})
end

function var_0_3.touchhandler(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_1 == "began" then
		local var_13_0 = arg_13_0:convertToNodeSpace(ccp(arg_13_2, arg_13_3))

		if arg_13_0.container:getBoundingBox():containsPoint(var_13_0) then
			return true
		else
			arg_13_0:onExit()

			return false
		end
	end
end

return var_0_3
