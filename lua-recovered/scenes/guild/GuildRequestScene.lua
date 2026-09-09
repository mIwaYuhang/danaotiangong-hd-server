require("network.GuildRequest")

local var_0_0 = require("base.cache")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = require("scenes.toollayer.model")
local var_0_3 = require("scenes.ToolLayer")
local var_0_4 = var_0_2:extend({
	eSortByVip = 2,
	eSortByPower = 3,
	eSortByLevel = 1,
	positionId = math.huge,
	attach = function(arg_1_0, arg_1_1)
		arg_1_0.positionId = var_0_0.get("GetPlayerGuildInfoRequest").PositionId

		arg_1_0:set("filter", arg_1_0.eSortByLevel)

		arg_1_0.request = GuildRequest:new(arg_1_1)

		arg_1_0.request:setResponseNormalHandler(function()
			local var_2_0, var_2_1 = arg_1_0.request:getResponseContent()

			if var_2_0 == GuildRequest.eJoinList then
				local var_2_2 = var_2_1.ApplyMemberCount
				local var_2_3 = var_2_1.UnionApplyList

				arg_1_0.dataset = var_2_3

				arg_1_0:set("status", var_2_1.UnionApplyStatus == 1)
				arg_1_0:trigger("sync", arg_1_0)
			elseif var_2_0 == GuildRequest.eStatus then
				arg_1_0:set("status", not arg_1_0:get("status"))
			elseif var_2_0 == GuildRequest.eRefuse or var_2_0 == GuildRequest.eJoin then
				if var_2_0 == GuildRequest.eJoin then
					userId = arg_1_0.joinValue
					arg_1_0.userlist = false
				else
					userId = arg_1_0.refuseValue
				end

				local var_2_4 = arg_1_0.dataset

				for iter_2_0, iter_2_1 in ipairs(var_2_4) do
					if iter_2_1.PlayerId == userId then
						table.remove(var_2_4, iter_2_0)

						break
					end
				end

				arg_1_0:trigger("sync", arg_1_0)

				var_0_0.get("GetPlayerGuildInfoRequest").NotifyUnion.bNewApply = #var_2_4 > 0
			elseif var_2_0 == GuildRequest.eBatch then
				local var_2_5 = {}

				arg_1_0.dataset = {}

				arg_1_0:trigger("sync", arg_1_0)

				var_0_0.get("GetPlayerGuildInfoRequest").NotifyUnion.bNewApply = false
			end
		end)
		arg_1_0.request:setResponseExceptionHandler(function()
			arg_1_0.dirty = true

			print("处理请求发生错误")
		end)
	end,
	sort = function(arg_4_0)
		local var_4_0 = arg_4_0.dataset
		local var_4_1 = arg_4_0:get("filter")

		if var_4_0 and #var_4_0 > 1 then
			table.sort(var_4_0, function(arg_5_0, arg_5_1)
				local var_5_0 = {
					"PlayerLv",
					"PlayerVipLv",
					"PlayerFap"
				}

				return arg_5_0[var_5_0[var_4_1]] < arg_5_1[var_5_0[var_4_1]]
			end)
			arg_4_0:trigger("sync", arg_4_0)
		end

		var_4_1 = var_4_1 + 1

		if var_4_1 > 3 then
			var_4_1 = 1
		end

		arg_4_0:set("filter", var_4_1)
	end,
	sync = function(arg_6_0)
		if arg_6_0.dirty then
			arg_6_0:requestJoinList()
		else
			arg_6_0:trigger("sync", arg_6_0)
		end
	end,
	isAuthorized = function(arg_7_0)
		return arg_7_0.positionId < 4
	end,
	requestJoinList = function(arg_8_0)
		arg_8_0.request:requestJoinList()
	end,
	requestBatch = function(arg_9_0, arg_9_1)
		if arg_9_0.dataset and #arg_9_0.dataset > 0 then
			arg_9_0.request:requestBatch(arg_9_1)
		end
	end,
	requestStatus = function(arg_10_0)
		local var_10_0 = arg_10_0:get("status")

		arg_10_0.request:requestStatus(not var_10_0)
	end,
	requestJoin = function(arg_11_0, arg_11_1)
		arg_11_0.joinValue = arg_11_1

		arg_11_0.request:requestJoin(arg_11_1)
	end,
	requestRefuse = function(arg_12_0, arg_12_1)
		arg_12_0.refuseValue = arg_12_1

		arg_12_0.request:requestRefuse(arg_12_1)
	end
})
local var_0_5 = class("GuildRequestScene", function()
	return display.newScene("GuildRequestScene")
end)

function var_0_5.ctor(arg_14_0, arg_14_1)
	arg_14_1 = arg_14_1 or {}
	arg_14_0.params = arg_14_1
	arg_14_0.model = var_0_0.get(arg_14_0)

	if not arg_14_0.model then
		arg_14_0.model = var_0_4:new()

		var_0_0.set(arg_14_0, arg_14_0.model)
	end

	arg_14_0.model:attach()
	arg_14_0:onEnterAlias()
end

function var_0_5.onEnterAlias(arg_15_0)
	local var_15_0 = require("scenes.CommonBgLayer").new({
		titleSprite = "uilocal/guild/guild_text_048.png",
		returnAction = function()
			if arg_15_0.params.back then
				arg_15_0.params.back()
			else
				game.enterGuildHomeScene()
			end
		end
	})
	local var_15_1 = var_15_0:getBackgroundSprite()
	local var_15_2 = var_15_1:getContentSize()

	arg_15_0:addChild(var_15_0)

	arg_15_0.container = var_15_1

	local var_15_3 = ui.newControlButton({
		normalImage = "ui/guild/guild_055.png",
		disabledImage = "ui/guild/guild_055.png",
		clickAction = function()
			arg_15_0.model:requestStatus()
		end
	})

	var_15_3:setPosition(510, 548)
	var_15_1:addChild(var_15_3)
	arg_15_0.model:bind("status", function(arg_18_0)
		local var_18_0 = arg_18_0 and "ui/guild/guild_055.png" or "ui/guild/guild_054.png"
		local var_18_1 = display.newScale9Sprite(var_18_0)

		var_15_3:setBackgroundSpriteForState(var_18_1, CCControlStateNormal)

		local var_18_2 = display.newScale9Sprite(var_18_0)

		var_15_3:setBackgroundSpriteForState(var_18_2, CCControlStateHighlighted)

		local var_18_3 = display.newScale9Sprite(var_18_0)

		var_15_3:setBackgroundSpriteForState(var_18_3, CCControlStateDisabled)
	end)
	var_15_3:setEnabled(arg_15_0.model:isAuthorized())

	local var_15_4 = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		text = "",
		size = CCSize(140, 52),
		clickAction = function(arg_19_0, arg_19_1)
			arg_15_0.model:sort()
		end
	})

	var_15_4:setPosition(100, 546)
	var_15_1:addChild(var_15_4)
	arg_15_0.model:bind("filter", function(arg_20_0)
		local var_20_0 = {
			[var_0_4.eSortByLevel] = string.lf("等级排序"),
			[var_0_4.eSortByVip] = string.lf("VIP 排序"),
			[var_0_4.eSortByPower] = string.lf("战力排序")
		}

		var_15_4:setTitleForState(CCString:create(var_20_0[arg_20_0]), CCControlStateNormal)
	end)

	local var_15_5 = var_0_1.newLabel({
		size = 24,
		text = string.lf("请求数量: 0"),
		color = ccc3(219, 174, 115)
	})

	var_15_5:align(display.LEFT_CENTER, 200, 546)
	var_15_1:addChild(var_15_5)

	arg_15_0.txtCount = var_15_5

	local var_15_6 = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		size = CCSize(140, 52),
		text = string.lf("一键通过"),
		clickAction = function(arg_21_0, arg_21_1)
			arg_15_0.model:requestBatch(true)
		end
	})

	var_15_6:setPosition(680, 546)
	var_15_6:setVisible(arg_15_0.model:isAuthorized())
	var_15_1:addChild(var_15_6)

	local var_15_7 = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		size = CCSize(140, 52),
		text = string.lf("一键拒绝"),
		clickAction = function(arg_22_0, arg_22_1)
			arg_15_0.model:requestBatch(false)
		end
	})

	var_15_7:setPosition(850, 546)
	var_15_7:setVisible(arg_15_0.model:isAuthorized())
	var_15_1:addChild(var_15_7)

	local var_15_8 = arg_15_0:createMemberView()

	var_15_8:setAnchorPoint(ccp(0, 0))
	var_15_8:setPosition(22, 12)
	var_15_1:addChild(var_15_8)
	arg_15_0.model:on("sync", arg_15_0.onSync, arg_15_0)
	arg_15_0.model:sync()
end

function var_0_5.onExit(arg_23_0)
	arg_23_0.model:detach()
end

function var_0_5.onSync(arg_24_0)
	local var_24_0 = arg_24_0.model.dataset

	arg_24_0.tableview:reloadData(var_24_0)

	local var_24_1 = #var_24_0

	arg_24_0.txtCount:setString(string.lf("请求数量: %s", var_24_1))
end

function var_0_5.onQuit(arg_25_0)
	game.enterHomeScene()
end

function var_0_5.createMemberView(arg_26_0)
	local var_26_0 = CCSize(915, 508)
	local var_26_1 = CCScale9Sprite:create("ui/friend/friend_003.png")

	var_26_1:setPreferredSize(var_26_0)

	local var_26_2 = {
		direction = kCCScrollViewDirectionHorizontal,
		size = CCSize(903, 490),
		numberhandler = function(arg_27_0, arg_27_1)
			local var_27_0 = arg_27_1 and #arg_27_1 or 0

			if var_27_0 < 4 then
				var_27_0 = 4
			end

			return var_27_0
		end,
		sizehandler = function(arg_28_0, arg_28_1)
			return CCSize(228, 480)
		end,
		cellhandler = function(arg_29_0, arg_29_1, arg_29_2)
			if not arg_29_2 then
				local var_29_0 = CCSize(218, 490)
				local var_29_1 = CCScale9Sprite:create("ui/guild/guild_053.png")

				var_29_1:setPreferredSize(var_29_0)
				var_29_1:setAnchorPoint(ccp(0, 0))
				var_29_1:setPosition(0, 0)

				local var_29_2 = var_0_1.newLabel({
					size = 50,
					text = string.lf("暂\n无"),
					font = _FONT_LISU,
					color = ccc3(255, 240, 100),
					align = ui.TEXT_ALIGN_CENTER
				})

				var_29_2:setAnchorPoint(CCPoint(0.5, 0.5))
				var_29_2:setPosition(var_29_0.width / 2, var_29_0.height / 2 + 50)
				var_29_1:addChild(var_29_2)

				return var_29_1
			else
				return arg_26_0:createMemberCell(arg_29_0, arg_29_1, arg_29_2)
			end
		end
	}
	local var_26_3 = createTableView(var_26_2)

	var_26_3:setAnchorPoint(CCPoint(0, 0))
	var_26_3:setPosition(6, 9)
	var_26_1:addChild(var_26_3)

	arg_26_0.tableview = var_26_3

	return var_26_1
end

function var_0_5.createMemberCell(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = ccc3(255, 255, 60)
	local var_30_1 = CCSize(218, 490)
	local var_30_2 = CCScale9Sprite:create("ui/guild/guild_053.png")

	var_30_2:setPreferredSize(var_30_1)
	var_30_2:setAnchorPoint(ccp(0, 0))
	var_30_2:setPosition(0, 0)

	local var_30_3 = arg_30_3.PlayerId
	local var_30_4 = arg_30_3.AvatarId or 401
	local var_30_5 = arg_30_3.PlayerName
	local var_30_6 = arg_30_3.PlayerLv or 0
	local var_30_7 = arg_30_3.PlayerFap or 0
	local var_30_8 = arg_30_3.PlayerVipLv or 0

	if not arg_30_3.IsFriend then
		local var_30_9 = 0
	end

	local var_30_10 = {
		scale = 0.5,
		isViewBaseInfo = false,
		isViewQuality = false,
		figId = var_30_4,
		equipId = getHeroGroupWeaponId(var_30_4),
		clickAction = function()
			OthersTeamHelper:checkOthersTeam(var_30_3, var_30_5, OthersTeamHelper.eDataFromGuildRequest)
		end
	}
	local var_30_11 = figure.createHero(var_30_10)

	var_30_11:setPosition(var_30_1.width / 2, var_30_1.height - 245)
	var_30_2:addChild(var_30_11)

	local var_30_12 = var_0_1.newLabel({
		size = 24,
		outline = true,
		text = var_30_5,
		color = var_30_0
	})

	var_30_12:setPosition(var_30_1.width / 2, 235)
	var_30_2:addChild(var_30_12)

	local var_30_13 = var_0_1.newLabel({
		size = 18,
		outline = true,
		text = "V I P：" .. var_30_8
	})

	var_30_13:setAnchorPoint(ccp(0, 0.5))
	var_30_13:setPosition(65, 205)
	var_30_2:addChild(var_30_13)

	local var_30_14 = var_0_1.newLabel({
		size = 18,
		outline = true,
		text = string.lf("等级：%s", var_30_6)
	})

	var_30_14:setAnchorPoint(ccp(0, 0.5))
	var_30_14:setPosition(65, 180)
	var_30_2:addChild(var_30_14)

	local var_30_15 = var_0_1.newLabel({
		size = 18,
		outline = true,
		text = string.lf("战力：%s", var_30_7)
	})

	var_30_15:setAnchorPoint(ccp(0, 0.5))
	var_30_15:setPosition(65, 155)
	var_30_2:addChild(var_30_15)

	local var_30_16 = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		text = string.lf("同意加入"),
		fontSize = ColorTable.eTitleButton_FontSize2,
		textColor = ColorTable.eTitleButton_Normal2,
		clickAction = function(arg_32_0, arg_32_1)
			arg_30_0.model:requestJoin(var_30_3)
		end
	})

	var_30_16:setPosition(var_30_1.width / 2, 105)
	var_30_16:setVisible(arg_30_0.model:isAuthorized())
	var_30_2:addChild(var_30_16)

	local var_30_17 = ui.newControlButton({
		normalImage = "ui/common/common_055.png",
		text = string.lf("拒绝申请"),
		fontSize = ColorTable.eTitleButton_FontSize2,
		textColor = ColorTable.eTitleButton_Normal2,
		clickAction = function(arg_33_0, arg_33_1)
			arg_30_0.model:requestRefuse(var_30_3)
		end
	})

	var_30_17:setPosition(var_30_1.width / 2, 35)
	var_30_17:setVisible(arg_30_0.model:isAuthorized())
	var_30_2:addChild(var_30_17)

	return var_30_2
end

return var_0_5
