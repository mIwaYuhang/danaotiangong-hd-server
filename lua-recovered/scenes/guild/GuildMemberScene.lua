require("scenes.team.OthersTeamHelper")

local var_0_0 = require("base.cache")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = require("scenes.ToolLayer")
local var_0_3 = require("scenes.toollayer.model"):extend({
	positionId = 0,
	unionCoin = 0,
	TPUC = 0,
	batchFlag = false,
	ctor = function(arg_1_0)
		arg_1_0:set("online", 0)
		arg_1_0:set("total", 0)
	end,
	attach = function(arg_2_0, arg_2_1)
		local var_2_0 = var_0_0.get("GetPlayerGuildInfoRequest")

		arg_2_0.unionCoin = var_2_0.CurUnionCoin
		arg_2_0.positionId = var_2_0.PositionId
		arg_2_0.TPUC = var_2_0.TPUC
		arg_2_0.batchFlag = false
		arg_2_0.request = GuildRequest:new(arg_2_1)

		arg_2_0.request:setResponseNormalHandler(function()
			local var_3_0, var_3_1 = arg_2_0.request:getResponseContent()

			if var_3_0 == GuildRequest.eUserList then
				local var_3_2 = var_3_1.MaxMemberCount
				local var_3_3 = var_3_1.CurMemberCount
				local var_3_4 = var_3_1.PlayerUnionInfoList

				arg_2_0.dataset = var_3_4

				table.sort(var_3_4, function(arg_4_0, arg_4_1)
					return arg_4_0.PositionId < arg_4_1.PositionId
				end)

				local var_3_5 = 0
				local var_3_6 = #var_3_4

				for iter_3_0, iter_3_1 in ipairs(var_3_4) do
					if iter_3_1.Online == 0 then
						var_3_5 = var_3_5 + 1
					end
				end

				arg_2_0:set("online", var_3_5)
				arg_2_0:set("total", var_3_6)
				arg_2_0:trigger("sync", arg_2_0)
			elseif var_3_0 == GuildRequest.eFriend then
				showFlashNotice("好友请求已发送！")
			elseif var_3_0 == GuildRequest.eContact then
				showFlashNotice("消息发送成功！")
			elseif var_3_0 == GuildRequest.eChange then
				arg_2_0:trigger("change")
			elseif var_3_0 == GuildRequest.eQuit then
				arg_2_0:trigger("quit")
			elseif var_3_0 == GuildRequest.eDisband then
				arg_2_0:trigger("disband")
			elseif var_3_0 == GuildRequest.eDistribute then
				arg_2_0.TPUC = arg_2_0.TPUC - arg_2_0:getGiveTotal(arg_2_0.distributeValue)
				var_0_0.get("GetPlayerGuildInfoRequest").TPUC = arg_2_0.TPUC

				arg_2_0:trigger("distribute")
			elseif var_3_0 == GuildRequest.eKickOut then
				local var_3_7 = arg_2_0.kickoutValue

				for iter_3_2, iter_3_3 in ipairs(arg_2_0.dataset) do
					if iter_3_3.PlayerId == var_3_7 then
						table.remove(arg_2_0.dataset, iter_3_2)

						break
					end
				end

				arg_2_0:trigger("sync", arg_2_0)
			end
		end)
		arg_2_0.request:setResponseExceptionHandler(function()
			arg_2_0.dirty = true

			print("处理请求发生错误")
		end)

		arg_2_0.changeLeaderRequest = ChangeGuildLeaderRequest:new(arg_2_1)

		arg_2_0.changeLeaderRequest:setResponseNormalHandler(function()
			arg_2_0:trigger("change")
		end)
		arg_2_0.changeLeaderRequest:setResponseExceptionHandler(function()
			arg_2_0.dirty = true

			print("处理请求发生错误")
		end)
	end,
	sync = function(arg_8_0)
		if arg_8_0.dirty then
			arg_8_0:requestUserList()
		else
			arg_8_0:trigger("sync", arg_8_0)
		end
	end,
	batch = function(arg_9_0)
		local var_9_0 = not arg_9_0.batchFlag

		for iter_9_0, iter_9_1 in ipairs(arg_9_0.dataset) do
			iter_9_1.state = var_9_0
		end

		arg_9_0.batchFlag = var_9_0

		arg_9_0:trigger("sync", arg_9_0)
		arg_9_0:trigger("select")
	end,
	setState = function(arg_10_0, arg_10_1, arg_10_2)
		arg_10_1.state = arg_10_2

		arg_10_0:trigger("select")
	end,
	getGiveTotal = function(arg_11_0, arg_11_1)
		local var_11_0 = 0

		for iter_11_0, iter_11_1 in ipairs(arg_11_0.dataset) do
			if iter_11_1.state then
				var_11_0 = var_11_0 + arg_11_1
			end
		end

		return var_11_0
	end,
	requestUserList = function(arg_12_0)
		arg_12_0.request:requestUserList()
	end,
	requestFriend = function(arg_13_0, arg_13_1, arg_13_2)
		arg_13_0.friendValue = arg_13_1

		arg_13_0.request:requestFriend(arg_13_1, arg_13_2)
	end,
	requestContact = function(arg_14_0, arg_14_1, arg_14_2)
		arg_14_0.contactValue = arg_14_1

		arg_14_0.request:requestContact(arg_14_1, arg_14_2)
	end,
	requestChange = function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_2 == GuildPositionId.eMengZhu then
			arg_15_0.changeLeaderRequest:request(arg_15_1)
		else
			arg_15_0.request:requestChange(arg_15_1, arg_15_2)
		end
	end,
	requestDistribute = function(arg_16_0, arg_16_1)
		local var_16_0 = {}

		for iter_16_0, iter_16_1 in ipairs(arg_16_0.dataset) do
			if iter_16_1.state then
				table.insert(var_16_0, iter_16_1.PlayerId)
			end
		end

		if #var_16_0 > 0 then
			arg_16_0.distributeValue = arg_16_1

			arg_16_0.request:requestDistribute(var_16_0, arg_16_1)
		end
	end,
	requestQuit = function(arg_17_0)
		arg_17_0.request:requestQuit()
	end,
	requestKickout = function(arg_18_0, arg_18_1)
		arg_18_0.kickoutValue = arg_18_1

		arg_18_0.request:requestKickout(arg_18_1)
	end,
	requestDisband = function(arg_19_0)
		arg_19_0.request:requestDisband()
	end
})
local var_0_4 = class("GuildMemberScene", function()
	return display.newScene("GuildMemberScene")
end)

function var_0_4.ctor(arg_21_0, arg_21_1)
	arg_21_1 = arg_21_1 or {}
	arg_21_0.params = arg_21_1
	arg_21_0.model = var_0_0.get(arg_21_0)

	if not arg_21_0.model then
		arg_21_0.model = var_0_3:new()

		var_0_0.set(arg_21_0, arg_21_0.model)
	end

	arg_21_0.model:attach(arg_21_0)
	arg_21_0:onEnterAlias()
end

function var_0_4.onEnterAlias(arg_22_0)
	local var_22_0 = require("scenes.CommonBgLayer").new({
		returnAction = function()
			if arg_22_0.params.back then
				arg_22_0.params.back()
			else
				game.enterGuildHomeScene()
			end
		end
	})
	local var_22_1 = var_22_0:getBackgroundSprite()
	local var_22_2 = var_22_1:getContentSize()

	arg_22_0:addChild(var_22_0)

	arg_22_0.container = var_22_1

	local var_22_3 = 30
	local var_22_4 = ccc3(250, 160, 60)

	if IPlatform:instance():getConfig("Channel") == "ZSY_VN" then
		var_22_3 = 18
	end

	local var_22_5 = var_0_1.newLabel({
		text = string.lf("成员"),
		size = var_22_3,
		color = var_22_4
	})

	var_22_5:setPosition(100, var_22_2.height - 35)
	var_22_1:addChild(var_22_5)

	local var_22_6 = var_0_1.newLabel({
		text = string.lf("等级"),
		size = var_22_3,
		color = var_22_4
	})

	var_22_6:setPosition(270, var_22_2.height - 35)
	var_22_1:addChild(var_22_6)

	local var_22_7 = var_0_1.newLabel({
		text = string.lf("职务"),
		size = var_22_3,
		color = var_22_4
	})

	var_22_7:setPosition(390, var_22_2.height - 35)
	var_22_1:addChild(var_22_7)

	local var_22_8 = var_0_1.newLabel({
		text = string.lf("总晶石"),
		size = var_22_3,
		color = var_22_4
	})

	var_22_8:setPosition(510, var_22_2.height - 35)
	var_22_1:addChild(var_22_8)

	local var_22_9 = var_0_1.newLabel({
		text = string.lf("状态"),
		size = var_22_3,
		color = var_22_4
	})

	var_22_9:setPosition(630, var_22_2.height - 35)
	var_22_1:addChild(var_22_9)

	local var_22_10 = CCSize(160, 30)
	local var_22_11 = display.newScale9Sprite("ui/activity/activity_062.png")

	var_22_11:setPreferredSize(var_22_10)
	var_22_11:setPosition(780, var_22_2.height - 36)
	var_22_1:addChild(var_22_11)

	local var_22_12 = var_0_1.newLabel({
		text = "",
		color = ccc3(255, 255, 255)
	})

	var_22_12:setPosition(var_22_10.width / 2, var_22_10.height / 2)
	var_22_11:addChild(var_22_12)
	arg_22_0.model:bind("online|total", function(arg_24_0, arg_24_1)
		var_22_12:setString(string.lf("在线成员：%s / %s", arg_24_0, arg_24_1))
	end)

	local var_22_13 = 10
	local var_22_14 = 6
	local var_22_15 = arg_22_0:createUserView()

	if arg_22_0.params.distribute then
		local var_22_16 = arg_22_0:createDistributeView()

		var_22_16:setPosition(var_22_2.width / 2, 35)
		var_22_1:addChild(var_22_16, 1)

		var_22_14 = var_22_14 + 60
	end

	var_22_15:setPosition(var_22_13, var_22_14)
	var_22_1:addChild(var_22_15)
	arg_22_0.model:on("distribute", arg_22_0.onDistribute, arg_22_0)
	arg_22_0.model:on("disband", arg_22_0.onQuit, arg_22_0)
	arg_22_0.model:on("quit", arg_22_0.onQuit, arg_22_0)
	arg_22_0.model:on("change", arg_22_0.onChange, arg_22_0)
	arg_22_0.model:on("sync", arg_22_0.onSync, arg_22_0)
	arg_22_0.model:sync()
end

function var_0_4.onExit(arg_25_0)
	arg_25_0.model:detach()
end

function var_0_4.onSync(arg_26_0)
	local var_26_0 = arg_26_0.tableview
	local var_26_1 = var_26_0:getContentOffset()

	var_26_0:reloadData(arg_26_0.model.dataset)

	if var_26_1.y <= 0 then
		var_26_0:setContentOffset(var_26_1)
	end
end

function var_0_4.onChange(arg_27_0)
	game.enterGuildPersonnelScene()
end

function var_0_4.onDistribute(arg_28_0)
	arg_28_0.coinNode:setValue(arg_28_0.model.TPUC)
	arg_28_0.coinNode.originalLabel:runAction(CCBlink:create(0.5, 3))
	showFlashNotice(string.lf("仙盟晶石发放成功！"))
end

function var_0_4.onQuit(arg_29_0)
	game.enterHomeScene()
end

function var_0_4.createUserView(arg_30_0)
	local var_30_0 = CCSize(940, 568)

	if arg_30_0.params.distribute then
		var_30_0.height = var_30_0.height - 60
	end

	local var_30_1 = {
		reverse = true,
		direction = kCCScrollViewDirectionVertical,
		size = var_30_0,
		sizehandler = function(arg_31_0, arg_31_1)
			return CCSize(940, 88)
		end,
		cellhandler = handler(arg_30_0, arg_30_0.createUserItem)
	}
	local var_30_2 = createTableView(var_30_1)

	arg_30_0.tableview = var_30_2

	return var_30_2
end

function var_0_4.createUserItem(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = arg_32_3.PlayerId
	local var_32_1 = arg_32_3.PositionId
	local var_32_2 = arg_32_3.PlayerName
	local var_32_3 = arg_32_3.PlayerLevel or arg_32_3.PlayerLv

	if not arg_32_3.PlayerFap then
		local var_32_4 = 0
	end

	local var_32_5 = arg_32_3.Online
	local var_32_6 = arg_32_3.UnionCoin or 0

	if not arg_32_3.IsFriend then
		local var_32_7 = 0
	end

	if #var_32_2 < 1 then
		var_32_2 = "神魔仙友"
	end

	local var_32_8
	local var_32_9 = var_32_1 < 2 and "ui/system/system_001.png" or var_32_1 < 3 and "ui/system/system_002.png" or var_32_1 < 7 and "ui/system/system_003.png" or "ui/system/system_004.png"
	local var_32_10 = CCSize(940, 80)
	local var_32_11 = display.newScale9Sprite(var_32_9)

	var_32_11:setPreferredSize(var_32_10)
	var_32_11:setPosition(var_32_10.width / 2, 44)

	local var_32_12 = arg_32_0:createHeaderView(arg_32_3, 0.9)

	var_32_12:setPosition(60, var_32_10.height / 2)
	var_32_11:addChild(var_32_12)

	local var_32_13 = 22
	local var_32_14 = ccc3(100, 250, 50)
	local var_32_15 = ccc3(255, 255, 255)
	local var_32_16 = var_0_1.newLabel({
		text = var_32_2,
		color = var_32_0 == Player.userId and var_32_15 or var_32_14,
		size = var_32_13
	})

	var_32_16:align(display.LEFT_CENTER, 110, var_32_10.height / 2)
	var_32_11:addChild(var_32_16)

	local var_32_17 = var_0_1.newLabel({
		text = var_32_3,
		color = ccc3(250, 250, 60),
		size = var_32_13
	})

	var_32_17:setPosition(260, var_32_10.height / 2)
	var_32_11:addChild(var_32_17)

	local var_32_18 = var_0_1.newLabel({
		text = GuildPositionName[var_32_1],
		color = ccc3(250, 250, 160),
		size = var_32_13
	})

	var_32_18:setPosition(380, var_32_10.height / 2)
	var_32_11:addChild(var_32_18)

	local var_32_19 = var_0_1.newLabel({
		text = var_32_6,
		color = ccc3(100, 250, 250),
		size = var_32_13
	})

	var_32_19:setPosition(500, var_32_10.height / 2)
	var_32_11:addChild(var_32_19)

	local var_32_20
	local var_32_21 = 3600
	local var_32_22 = 24 * var_32_21
	local var_32_23 = 30 * var_32_22
	local var_32_24 = ccc3(180, 0, 0)

	if var_32_5 == 0 then
		var_32_20 = string.lf("在线")
		var_32_24.r = 0
		var_32_24.g = 180
	elseif var_32_5 < var_32_21 then
		var_32_20 = string.lf("离线")
	elseif var_32_5 < var_32_22 then
		var_32_20 = string.lf("离线 %s 小时", math.floor(var_32_5 / var_32_21))
	elseif var_32_5 < var_32_23 then
		var_32_20 = string.lf("离线 %s 天", math.floor(var_32_5 / var_32_22))
	else
		var_32_20 = string.lf("离线 %s 月", math.floor(var_32_5 / var_32_23))
	end

	if var_32_0 == Player.userId then
		var_32_20 = string.lf("在线")
	end

	local var_32_25 = var_0_1.newLabel({
		text = var_32_20,
		color = var_32_24,
		size = var_32_13
	})

	var_32_25:setPosition(620, var_32_10.height / 2)
	var_32_11:addChild(var_32_25)

	local var_32_26

	if arg_32_0.params.position then
		if var_32_1 > arg_32_0.model.positionId then
			var_32_26 = {
				fontSize = 25,
				normalImage = "ui/common/common_027.png",
				text = string.lf("任命"),
				clickAction = function()
					arg_32_0.model:requestChange(var_32_0, arg_32_0.params.position)
				end
			}
		end
	elseif arg_32_0.params.distribute then
		local var_32_27 = var_0_1.createToggleButton(function(arg_34_0)
			arg_32_0.model:setState(arg_32_3, arg_34_0)
		end)

		var_32_27:setState(arg_32_3.state)
		var_32_27:setPosition(880, var_32_10.height / 2)
		var_32_11:addChild(var_32_27)
	else
		var_32_26 = {
			fontSize = 25,
			normalImage = "ui/common/common_027.png",
			text = var_32_0 == Player.userId and string.lf("操作") or string.lf("查看"),
			clickAction = function()
				arg_32_0:createActionTips(arg_32_2, arg_32_3)
			end
		}
	end

	if var_32_26 then
		local var_32_28 = ui.newControlButton(var_32_26)

		var_32_28:setPosition(880, var_32_10.height / 2)
		var_32_11:addChild(var_32_28)
	end

	return var_32_11
end

function var_0_4.createHeaderView(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_1.PlayerId
	local var_36_1 = arg_36_1.PlayerName
	local var_36_2 = arg_36_1.AvatarId or 401

	arg_36_2 = arg_36_2 or 1

	local var_36_3 = CCSize(82 * arg_36_2, 82 * arg_36_2)
	local var_36_4 = CCScale9Sprite:create("ui/common/bg_common.png")

	var_36_4:setPreferredSize(var_36_3)

	local var_36_5 = ui.newControlButton({
		scaleX = arg_36_2,
		scaleY = arg_36_2,
		normalImage = getItemHeaderImagePath(ItemType.eHero, var_36_2),
		clickAction = function()
			OthersTeamHelper:checkOthersTeam(var_36_0, var_36_1, OthersTeamHelper.eDataFromGuildMember)
		end
	})

	var_36_5:setPosition(var_36_3.width / 2, var_36_3.height / 2)
	var_36_4:addChild(var_36_5)

	return var_36_4
end

function var_0_4.createDistributeView(arg_38_0)
	local var_38_0 = CCSize(950, 60)
	local var_38_1 = display.newScale9Sprite("ui/guild/guild_082.png")

	var_38_1:setPreferredSize(var_38_0)

	local var_38_2 = var_0_1.newLabel({
		text = string.lf("仙盟晶石")
	})

	var_38_2:setPosition(60, 30)
	var_38_1:addChild(var_38_2)

	local var_38_3 = createItemCountNode({
		type = ItemType.eGuildCoin,
		value = arg_38_0.model.TPUC,
		color = ccc3(0, 255, 0)
	})

	var_38_3:setPosition(120, 30)
	var_38_1:addChild(var_38_3)

	arg_38_0.coinNode = var_38_3

	local var_38_4 = var_0_1.newLabel({
		text = string.lf("发放数量")
	})

	var_38_4:setPosition(300, 30)
	var_38_1:addChild(var_38_4)

	local var_38_5 = createItemCountNode({
		value = 0,
		type = ItemType.eGuildCoin,
		color = ccc3(0, 255, 0)
	})

	var_38_5:setPosition(360, 30)
	var_38_1:addChild(var_38_5)

	local function var_38_6(arg_39_0)
		local var_39_0 = arg_39_0:getText():trim()

		if #var_39_0 > 0 and var_39_0:match("%d+") then
			local var_39_1 = tonumber(var_39_0)

			if var_39_1 and var_39_1 > 0 then
				return math.floor(var_39_1)
			end
		end

		return 0
	end

	local var_38_7 = ui.newEditBox({
		fontSize = 20,
		image = "ui/friend/friend_006.png",
		multiLines = false,
		size = CCSize(200, 40),
		listener = function(arg_40_0, arg_40_1)
			if arg_40_0 == "changed" then
				local var_40_0 = var_38_6(arg_40_1)
				local var_40_1 = arg_38_0.model:getGiveTotal(var_40_0)

				var_38_5:setColor(var_40_1 > arg_38_0.model.TPUC and display.COLOR_RED or display.COLOR_GREEN)
				var_38_5:setValue(var_40_1)
			end
		end
	})

	var_38_7:setPlaceHolder(string.lf("输入分发数量"))
	var_38_7:setAnchorPoint(ccp(0, 0.5))
	var_38_7:setPosition(480, 30)
	var_38_7:setInputMode(kEditBoxInputModeAny)
	var_38_7:setReturnType(kKeyboardReturnTypeSearch)
	var_38_7:setMaxLength(20)
	var_38_1:addChild(var_38_7)
	arg_38_0.model:on("select", function()
		local var_41_0 = var_38_6(var_38_7)

		if var_41_0 then
			local var_41_1 = arg_38_0.model:getGiveTotal(var_41_0)

			var_38_5:setColor(var_41_1 > arg_38_0.model.TPUC and display.COLOR_RED or display.COLOR_GREEN)
			var_38_5:setValue(var_41_1)
		end
	end)

	local var_38_8 = ui.newControlButton({
		fontSize = 25,
		normalImage = "ui/common/common_027.png",
		text = string.lf("确定"),
		clickAction = function()
			local var_42_0 = var_38_6(var_38_7)

			if var_42_0 and var_42_0 > 0 then
				arg_38_0.model:requestDistribute(var_42_0)
			else
				showFlashNotice(string.lf("上仙，请输入分发的晶石数量！"))
			end
		end
	})

	var_38_8:setPosition(740, 30)
	var_38_1:addChild(var_38_8)

	local var_38_9 = var_0_1.newLabel({
		text = string.lf("全选")
	})

	var_38_9:setPosition(var_38_0.width - 90, 30)
	var_38_1:addChild(var_38_9)

	local var_38_10 = var_0_1.createToggleButton(function()
		var_38_9:setString(arg_38_0.model.batchFlag and string.lf("全选") or string.lf("取消"))
		arg_38_0.model:batch()
	end)

	var_38_10:setTouchPriority(-1)
	var_38_10:setPosition(var_38_0.width - 40, 30)
	var_38_1:addChild(var_38_10)

	return var_38_1
end

function var_0_4.createActionTips(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = var_0_2.new({
		type = var_0_2.eTypeTips
	})

	var_44_0.actMargin = 20

	local var_44_1 = arg_44_2.PlayerId
	local var_44_2 = arg_44_2.PositionId
	local var_44_3 = arg_44_2.PlayerLevel or arg_44_2.PlayerLv
	local var_44_4 = arg_44_2.PlayerFap or 0
	local var_44_5 = arg_44_2.IsFriend or 0
	local var_44_6 = arg_44_2.PlayerName
	local var_44_7 = CCSize(300, 120)
	local var_44_8 = var_0_1.newNode()

	var_44_8:setContentSize(var_44_7)
	var_44_0:addNode(var_44_8)
	var_44_0:addSeparator()

	local var_44_9 = arg_44_0:createHeaderView(arg_44_2, 1.1)

	var_44_9:setPosition(75, var_44_7.height / 2)
	var_44_8:addChild(var_44_9)

	local var_44_10 = {}
	local var_44_11 = var_0_1.newLabel({
		text = var_44_6,
		color = ccc3(100, 250, 50)
	})

	table.insert(var_44_10, var_44_11)

	local var_44_12 = var_0_1.newLabel({
		text = string.lf("等级: %s", var_44_3),
		color = ccc3(250, 250, 60)
	})

	table.insert(var_44_10, var_44_12)

	local var_44_13 = var_0_1.newLabel({
		text = string.lf("职位: %s", GuildPositionName[var_44_2]),
		color = ccc3(250, 250, 160)
	})

	table.insert(var_44_10, var_44_13)

	local var_44_14 = var_0_1.newLabel({
		text = string.lf("战力: %s", var_44_4),
		color = ccc3(100, 250, 250)
	})

	table.insert(var_44_10, var_44_14)

	local var_44_15 = var_0_1.linearLayout({
		margin = 0,
		direction = "vertical",
		nodes = var_44_10,
		align = display.LEFT_CENTER
	})

	var_44_15:setAnchorPoint(ccp(0, 0.5))
	var_44_15:setPosition(150, var_44_7.height / 2)
	var_44_8:addChild(var_44_15)

	if var_44_1 == Player.userId then
		var_44_0:addAction({
			text = var_44_2 > 1 and string.lf("退出仙盟") or string.lf("解散仙盟"),
			callback = function()
				var_44_0:removeSelf()

				local var_45_0
				local var_45_1

				if var_44_2 > 1 then
					var_45_0 = string.lf("上仙，确定要退出仙盟吗？T.T")
					var_45_1 = arg_44_0.model.requestQuit
				else
					var_45_0 = string.lf("上仙，确定要解散仙盟吗？T.T")
					var_45_1 = arg_44_0.model.requestDisband
				end

				var_0_2.createDialog({
					show = var_0_2.eShowNoticeBox,
					data = var_45_0,
					callback = function()
						var_45_1(arg_44_0.model)
					end
				}):show()
			end
		})
	elseif var_44_5 == 0 then
		var_44_0:addAction({
			text = string.lf("结识"),
			callback = function()
				var_44_0:removeSelf()
				var_0_2.createDialog({
					show = var_0_2.eShowEditBox,
					data = {
						title = string.lf("上仙，先给 #C6D27E%s 同学发封结交信函吧！", var_44_6),
						text = string.lf("仰慕大仙久矣，可否加在下为好友？")
					},
					callback = function(arg_48_0)
						arg_44_0.model:requestFriend(var_44_1, arg_48_0)
					end
				}):show()
			end
		})
	else
		var_44_0:addAction({
			text = string.lf("联络"),
			callback = function()
				var_44_0:removeSelf()
				var_0_2.createDialog({
					show = var_0_2.eShowEditBox,
					data = {
						title = string.lf("请输入您给 #C6D27E%s#FFFFFF 的留言：", var_44_6),
						text = string.lf("上仙，心里想你直痒痒，联络信息要常发！")
					},
					callback = function(arg_50_0)
						arg_44_0.model:requestContact(var_44_1, arg_50_0)
					end
				}):show()
			end
		})
	end

	if var_44_2 > arg_44_0.model.positionId then
		var_44_0:addAction({
			text = string.lf("踢除"),
			callback = function()
				var_44_0:removeSelf()
				arg_44_0.model:requestKickout(var_44_1)
			end
		})
	end

	var_44_0:show({
		x = 500,
		y = 4,
		scroll = {
			table = arg_44_0.tableview,
			index = arg_44_1,
			size = {
				width = 940,
				height = 88
			}
		}
	})
end

return var_0_4
