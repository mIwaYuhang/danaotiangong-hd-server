local var_0_0 = require("base.cache")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = require("scenes.toollayer.tool")
local var_0_3 = require("scenes.toollayer.model")
local var_0_4 = require("scenes.ToolLayer")
local var_0_5 = {
	1,
	2,
	3,
	4,
	5,
	6,
	7
}
local var_0_6 = class("GuildPersonnelScene", function()
	return display.newScene("GuildRequestScene")
end)

function var_0_6.ctor(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or {}
	arg_2_0.params = arg_2_1
	arg_2_0.positionId = var_0_0.get("GetPlayerGuildInfoRequest").PositionId

	arg_2_0:initRequest()
	arg_2_0:onEnterAlias()
end

function var_0_6.initRequest(arg_3_0)
	arg_3_0.request = GuildRequest:new()

	arg_3_0.request:setResponseNormalHandler(function()
		local var_4_0, var_4_1 = arg_3_0.request:getResponseContent()

		if var_4_0 == GuildRequest.eUserList then
			local var_4_2 = var_4_1.PlayerUnionInfoList

			table.sort(var_4_2, function(arg_5_0, arg_5_1)
				return arg_5_0.PositionId < arg_5_1.PositionId
			end)
			arg_3_0:reloadData(var_4_2)
		elseif var_4_0 == GuildRequest.eChange then
			arg_3_0.changeNode:setUser()
		end
	end)
	arg_3_0.request:setResponseExceptionHandler(function()
		print("处理请求发生错误")
	end)
end

function var_0_6.onEnterAlias(arg_7_0)
	local var_7_0 = require("scenes.CommonBgLayer").new({
		titleSprite = "uilocal/guild/guild_text_047.png",
		returnAction = function()
			if arg_7_0.params.back then
				arg_7_0.params.back()
			else
				game.enterGuildHomeScene()
			end
		end
	})
	local var_7_1 = var_7_0:getBackgroundSprite()
	local var_7_2 = var_7_1:getContentSize()

	arg_7_0:addChild(var_7_0)

	arg_7_0.container = var_7_1

	local var_7_3 = arg_7_0:createUserListView()

	var_7_3:align(display.CENTER, var_7_2.width / 2, var_7_2.height / 2 - 30)
	var_7_1:addChild(var_7_3)

	arg_7_0.userView = var_7_3

	local var_7_4 = ui.newControlButton({
		normalImage = "ui/enhance/enhance_015.png",
		clickAction = function()
			local var_9_0 = require("scenes.enhance.DlgRuleLayer").new({
				ruleType = DlgRuleType.ruleGuildLimit
			})

			arg_7_0:addChild(var_9_0)
		end
	})

	var_7_4:setPosition(90, 500)
	var_7_1:addChild(var_7_4)
	arg_7_0.request:requestUserList()
end

function var_0_6.createUserListView(arg_10_0)
	local var_10_0 = display.newSprite("ui/guild/guild_081.jpg")
	local var_10_1 = var_10_0:getContentSize()
	local var_10_2 = {}
	local var_10_3 = arg_10_0:createUserItem(1)

	var_10_3:setPosition(var_10_1.width / 2, 360)
	var_10_0:addChild(var_10_3)
	table.insert(var_10_2, var_10_3)

	local var_10_4 = arg_10_0:createUserItem(2)

	var_10_4:setPosition(215, 200)
	var_10_0:addChild(var_10_4)
	table.insert(var_10_2, var_10_4)

	local var_10_5 = arg_10_0:createUserItem(3)

	var_10_5:setPosition(730, 200)
	var_10_0:addChild(var_10_5)
	table.insert(var_10_2, var_10_5)

	local var_10_6 = arg_10_0:createUserItem(4)

	var_10_6:setPosition(100, 50)
	var_10_0:addChild(var_10_6)
	table.insert(var_10_2, var_10_6)

	local var_10_7 = arg_10_0:createUserItem(5)

	var_10_7:setPosition(325, 50)
	var_10_0:addChild(var_10_7)
	table.insert(var_10_2, var_10_7)

	local var_10_8 = arg_10_0:createUserItem(6)

	var_10_8:setPosition(615, 50)
	var_10_0:addChild(var_10_8)
	table.insert(var_10_2, var_10_8)

	local var_10_9 = arg_10_0:createUserItem(7)

	var_10_9:setPosition(840, 50)
	var_10_0:addChild(var_10_9)
	table.insert(var_10_2, var_10_9)

	var_10_0.nodes = var_10_2

	return var_10_0
end

function var_0_6.createUserItem(arg_11_0, arg_11_1)
	local var_11_0
	local var_11_1
	local var_11_2 = arg_11_1 < 2 and "ui/guild/guild_082.png" or arg_11_1 < 4 and "ui/guild/guild_083.png" or "ui/guild/guild_084.png"

	var_11_1 = ui.newControlButton({
		normalImage = var_11_2,
		clickAction = function(arg_12_0, arg_12_1)
			local var_12_0 = var_0_5[arg_11_1]

			if arg_11_0.positionId == 1 or arg_11_0.positionId == 2 and var_12_0 > 3 or arg_11_0.positionId > 2 and var_12_0 > arg_11_0.positionId then
				if var_11_1.user then
					arg_11_0:showTips(var_11_1, var_12_0)
				else
					game.enterGuildMemberScene({
						back = game.enterGuildPersonnelScene,
						position = var_12_0
					})
				end
			end
		end
	})

	local var_11_3 = var_11_1:getContentSize()
	local var_11_4 = var_0_1.newLabel({
		text = ""
	})

	var_11_4:setPosition(var_11_3.width / 2, var_11_3.height / 2 + 2)
	var_11_1:addChild(var_11_4)

	function var_11_1.setUser(arg_13_0, arg_13_1)
		if arg_13_1 then
			var_11_4:setString(arg_13_1.PlayerName)
			var_11_4:setColor(display.COLOR_WHITE)
			var_11_4:stopAllActions()
		else
			var_11_4:setString(string.lf("点击任命"))
			var_11_4:setColor(display.COLOR_GREEN)

			local var_13_0 = CCArray:create()

			var_13_0:addObject(CCDelayTime:create(3))
			var_13_0:addObject(CCJumpBy:create(0.25, ccp(0, 0), Adapter.AutoPosY(15), 1))
			var_11_4:runAction(CCRepeatForever:create(CCSequence:create(var_13_0)))
		end

		arg_13_0.user = arg_13_1
	end

	var_11_1:setUser()

	return var_11_1
end

function var_0_6.reloadData(arg_14_0, arg_14_1)
	local var_14_0 = {}
	local var_14_1 = 0
	local var_14_2 = 1
	local var_14_3 = #var_0_5
	local var_14_4 = 0
	local var_14_5

	for iter_14_0 = 1, var_14_3 do
		local var_14_6 = var_0_5[iter_14_0]

		for iter_14_1, iter_14_2 in ipairs(arg_14_1) do
			if iter_14_2.PositionId == var_14_6 then
				var_14_4, var_14_5 = iter_14_1, iter_14_2

				break
			end
		end

		if var_14_5 then
			table.insert(var_14_0, var_14_5)
			table.remove(arg_14_1, var_14_4)

			var_14_5 = nil
		else
			table.insert(var_14_0, false)
		end
	end

	local var_14_7 = arg_14_0.userView.nodes

	for iter_14_3, iter_14_4 in ipairs(var_14_0) do
		if iter_14_4 then
			var_14_7[iter_14_3]:setUser(iter_14_4)
		end
	end
end

function var_0_6.showTips(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = var_0_4.new({
		type = var_0_4.eTypeTips
	})
	local var_15_1 = var_0_1.newLabel({
		size = 24,
		text = string.lf("重新任命当前职位?")
	})

	var_15_0:addNode(var_15_1)
	var_15_0:addAction({
		text = string.lf("更换"),
		callback = function()
			var_15_0:removeSelf()
			game.enterGuildMemberScene({
				back = game.enterGuildPersonnelScene,
				position = arg_15_2
			})
		end
	})

	if arg_15_1.user and arg_15_2 ~= 1 then
		var_15_0:addAction({
			text = string.lf("卸任"),
			callback = function()
				var_15_0:removeSelf()
				arg_15_0.request:requestChange(arg_15_1.user.PlayerId, 8)

				arg_15_0.changeNode = arg_15_1
			end
		})
	end

	var_15_0:show({
		adjust = true,
		node = arg_15_1,
		parent = arg_15_0.container
	})
end

return var_0_6
