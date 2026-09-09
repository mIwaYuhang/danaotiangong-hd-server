require("base.figure")
require("network.FriendRequest")
require("scenes.team.OthersTeamHelper")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = require("scenes.ToolLayer")
local var_0_2 = class("RecommendListLayer", function()
	return CCScale9Sprite:create("ui/friend/friend_003.png")
end)

function var_0_2.ctor(arg_2_0, arg_2_1)
	local var_2_0 = CCSize(910, 508)

	arg_2_0:setPreferredSize(var_2_0)

	arg_2_0.size = var_2_0
	arg_2_0.container = arg_2_0
	arg_2_0.request = arg_2_1.request
	arg_2_0.request.do_recommend_handler = handler(arg_2_0, arg_2_0.requesthandler)

	arg_2_0:onEnterAlias()
end

function var_0_2.requesthandler(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == FriendRequest.eRecommendList then
		arg_3_0.dataset = arg_3_2

		arg_3_0.tableview:reloadData(arg_3_2)

		arg_3_0.request.cache_recommend = arg_3_2
	elseif arg_3_1 == FriendRequest.eRequest then
		local var_3_0 = arg_3_0.dataset
		local var_3_1 = arg_3_0.request.friendId

		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			if iter_3_1.userId == var_3_1 then
				table.remove(var_3_0, iter_3_0)

				break
			end
		end

		if #var_3_0 > 0 then
			arg_3_0.tableview:reloadData(var_3_0)
		else
			arg_3_0.request:recommendList()
		end

		showFlashNotice(string.lf("好友请求已发送！"))
	end
end

function var_0_2.onEnterAlias(arg_4_0)
	local var_4_0 = arg_4_0.size
	local var_4_1 = arg_4_0.container
	local var_4_2 = ui.newEditBox({
		fontSize = 20,
		image = "ui/friend/friend_006.png",
		multiLines = false,
		size = CCSize(120, 40)
	})

	var_4_2:setPlaceHolder(string.lf("输入名字"))
	var_4_2:setAnchorPoint(CCPoint(0, 0.5))
	var_4_2:setPosition(0, var_4_0.height + 28)
	var_4_2:setInputMode(kEditBoxInputModeAny)
	var_4_2:setReturnType(kKeyboardReturnTypeSearch)
	var_4_2:setMaxLength(20)
	var_4_1:addChild(var_4_2)

	local var_4_3 = ui.newControlButton({
		normalImage = "ui/common/common_018.png",
		position = CCPoint(180, var_4_0.height + 28),
		size = CCSize(115, 52),
		text = string.lf("搜索"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_5_0, arg_5_1)
			local var_5_0 = var_4_2:getText()
			local var_5_1

			if #var_5_0 < 1 then
				return
			end

			if string.find(string.lower(var_5_0), "lv.") then
				var_5_1 = string.match(var_5_0, "%d+")
				var_5_0 = ""
			end

			arg_4_0.request:recommendList(var_5_0, var_5_1)
		end
	})
	local var_4_4 = ui.newControlButton({
		normalImage = "ui/common/common_018.png",
		position = CCPoint(290, var_4_0.height + 28),
		size = CCSize(115, 52),
		text = string.lf("换一批"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_6_0, arg_6_1)
			arg_4_0.request:recommendList()
		end
	})

	var_4_1:addChild(var_4_3, 1)
	var_4_1:addChild(var_4_4, 1)

	local var_4_5 = {
		direction = kCCScrollViewDirectionHorizontal,
		size = CCSize(898, 490),
		numberhandler = function(arg_7_0, arg_7_1)
			local var_7_0 = arg_7_1 and #arg_7_1 or 0

			if var_7_0 < 4 then
				var_7_0 = 4
			end

			return var_7_0
		end,
		sizehandler = function(arg_8_0, arg_8_1)
			return CCSize(228, 490)
		end,
		cellhandler = function(arg_9_0, arg_9_1, arg_9_2)
			if not arg_9_2 then
				local var_9_0 = CCSize(218, 490)
				local var_9_1 = CCScale9Sprite:create("ui/friend/friend_002.png")

				var_9_1:setPreferredSize(var_9_0)
				var_9_1:setAnchorPoint(ccp(0, 0))
				var_9_1:setPosition(0, 0)

				local var_9_2 = var_0_0.newLabel({
					size = 50,
					text = string.lf("暂\n无"),
					font = _FONT_LISU,
					color = ccc3(55, 40, 0),
					align = ui.TEXT_ALIGN_CENTER
				})

				var_9_2:setAnchorPoint(CCPoint(0.5, 0.5))
				var_9_2:setPosition(var_9_0.width / 2, var_9_0.height / 2 + 50)
				var_9_1:addChild(var_9_2)

				return var_9_1
			else
				return arg_4_0:createRecommendCell(arg_9_0, arg_9_1, arg_9_2)
			end
		end
	}
	local var_4_6 = var_0_0.newTableView(var_4_5)

	var_4_6:setAnchorPoint(CCPoint(0, 0))
	var_4_6:setPosition(6, 10)
	var_4_1:addChild(var_4_6)

	arg_4_0.tableview = var_4_6

	local var_4_7 = arg_4_0.request.cache_recommend

	if not var_4_7 then
		arg_4_0.request:recommendList()
	else
		arg_4_0.tableview:reloadData(var_4_7)
	end
end

function var_0_2.createRecommendCell(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = _FONT_DEFAULT
	local var_10_1 = 24
	local var_10_2 = 24
	local var_10_3 = 18
	local var_10_4 = 18
	local var_10_5 = ccc3(255, 255, 60)
	local var_10_6 = ccc3(255, 255, 255)
	local var_10_7 = ccc3(255, 255, 255)
	local var_10_8 = CCSize(218, 490)
	local var_10_9 = CCScale9Sprite:create("ui/friend/friend_002.png")

	var_10_9:setPreferredSize(var_10_8)
	var_10_9:setAnchorPoint(ccp(0, 0))
	var_10_9:setPosition(0, 0)

	local var_10_10 = arg_10_3.userId
	local var_10_11 = arg_10_3.headerId
	local var_10_12 = arg_10_3.name
	local var_10_weapon = arg_10_3.weaponId

	if not var_10_weapon or var_10_weapon == 0 then
		var_10_weapon = getHeroGroupWeaponId(var_10_11)
	end

	local var_10_13 = {
		scale = 0.6,
		isViewBaseInfo = false,
		isViewQuality = false,
		figId = var_10_11,
		equipId = var_10_weapon,
		pinjie = arg_10_3.pinJie,
		rebirthCount = arg_10_3.rebirthCount or arg_10_3.BreakthroughCount or 0,
		clickAction = function()
			OthersTeamHelper:checkOthersTeam(var_10_10, var_10_12, OthersTeamHelper.eDataFromFriend)
		end
	}
	local var_10_14 = figure.createHero(var_10_13)

	var_10_14:setPosition(var_10_8.width / 2, var_10_8.height - 275)
	var_10_9:addChild(var_10_14)

	local var_10_15 = var_0_0.newLabel({
		outline = true,
		text = var_10_12,
		size = var_10_1,
		color = var_10_5
	})

	var_10_15:setPosition(var_10_8.width / 2, 210)
	var_10_9:addChild(var_10_15)

	local var_10_16 = var_0_0.newLabel({
		outline = true,
		text = string.lf("等级：%s", arg_10_3.level),
		size = var_10_3,
		color = var_10_6
	})

	var_10_16:setAnchorPoint(ccp(0, 0.5))
	var_10_16:setPosition(65, 180)
	var_10_9:addChild(var_10_16)

	local var_10_17 = var_0_0.newLabel({
		outline = true,
		text = string.lf("战力：%s", arg_10_3.battlePower),
		size = var_10_4,
		color = var_10_7
	})

	var_10_17:setAnchorPoint(ccp(0, 0.5))
	var_10_17:setPosition(65, 155)
	var_10_9:addChild(var_10_17)

	local var_10_18 = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		text = string.lf("结识"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_12_0, arg_12_1)
			var_0_1.createDialog({
				show = var_0_1.eShowEditBox,
				data = {
					title = string.lf("上仙，先给 #C6D27E%s 同学发封结交信函吧！", var_10_12),
					text = string.lf("仰慕大仙久矣，可否加在下为好友？")
				},
				callback = function(arg_13_0)
					arg_10_0.request:requestFriend(var_10_10, arg_13_0)
				end
			}):show()
			GuideLayer:stepDone(TaskEntryType.eEntryFriend, 3)
			GuideLayer:removeAllGuideLayer()
		end
	})

	var_10_18:setPosition(var_10_8.width / 2, 105)
	var_10_9:addChild(var_10_18)

	return var_10_9
end

return var_0_2
