require("base.figure")
require("network.FriendRequest")
require("scenes.team.OthersTeamHelper")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = require("scenes.ToolLayer")
local var_0_2 = class("FriendListLayer", function()
	return CCScale9Sprite:create("ui/friend/friend_003.png")
end)

function var_0_2.ctor(arg_2_0, arg_2_1)
	local var_2_0 = CCSize(910, 508)

	arg_2_0:setPreferredSize(var_2_0)

	arg_2_0.size = var_2_0
	arg_2_0.container = arg_2_0
	arg_2_0.request = arg_2_1.request
	arg_2_0.request.do_friend_handler = handler(arg_2_0, arg_2_0.requesthandler)

	arg_2_0:onEnterAlias()
end

function var_0_2.requesthandler(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == FriendRequest.eFriendList then
		arg_3_0.dataset = arg_3_2.friendList

		arg_3_0.tableview:reloadData(arg_3_0.dataset)
	elseif arg_3_1 == FriendRequest.eRequest then
		showFlashNotice(string.lf("消息发送成功！"))
	elseif arg_3_1 == FriendRequest.eDelete then
		local var_3_0 = arg_3_0.dataset
		local var_3_1 = arg_3_0.request.friendId

		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			if iter_3_1.userId == var_3_1 then
				table.remove(var_3_0, iter_3_0)

				break
			end
		end

		arg_3_0.tableview:reloadData(var_3_0, true)
	elseif arg_3_1 == FriendRequest.eSendPresent then
		showFlashNotice(string.lf("体力赠送成功！"))

		local var_3_2 = arg_3_0.dataset
		local var_3_3 = arg_3_0.request.friendId

		for iter_3_2, iter_3_3 in ipairs(var_3_2) do
			if iter_3_3.userId == var_3_3 then
				iter_3_3.presentState = 1

				break
			end
		end

		arg_3_0.tableview:reloadData(var_3_2, true)
	end
end

function var_0_2.onEnterAlias(arg_4_0)
	local var_4_0 = arg_4_0.size
	local var_4_1 = arg_4_0.container
	local var_4_2 = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		size = CCSize(140, 52),
		text = string.lf("等级排序"),
		fontSize = ColorTable.eTitleButton_FontSize2,
		textColor = ColorTable.eTitleButton_Normal2,
		clickAction = function(arg_5_0, arg_5_1)
			local var_5_0 = arg_4_0.dataset

			if var_5_0 and #var_5_0 > 1 then
				local var_5_1 = arg_4_0.tableview
				local var_5_2 = arg_4_0.sortfilter

				table.sort(var_5_0, function(arg_6_0, arg_6_1)
					local var_6_0 = arg_6_0.level < arg_6_1.level

					if var_5_2 then
						var_6_0 = not var_6_0
					end

					return var_6_0
				end)
				var_5_1:reloadData()

				arg_4_0.sortfilter = not var_5_2
			end
		end
	})

	var_4_2:setPosition(65, var_4_0.height + 28)
	var_4_1:addChild(var_4_2, 1)

	local var_4_3 = {
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
			return CCSize(228, 480)
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
				return arg_4_0:createFriendCell(arg_9_0, arg_9_1, arg_9_2)
			end
		end
	}
	local var_4_4 = var_0_0.newTableView(var_4_3)

	var_4_4:setAnchorPoint(ccp(0, 0))
	var_4_4:setPosition(6, 10)
	var_4_1:addChild(var_4_4)

	arg_4_0.tableview = var_4_4

	arg_4_0.request:friendList()
end

function var_0_2.createFriendCell(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
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
	local var_10_13 = {
		scale = 0.6,
		isViewBaseInfo = false,
		isViewQuality = false,
		figId = var_10_11,
		equipId = getHeroGroupWeaponId(var_10_11),
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
		font = var_10_0,
		size = var_10_2,
		color = var_10_5
	})

	var_10_15:setPosition(var_10_8.width / 2, 210)
	var_10_9:addChild(var_10_15)

	local var_10_16 = var_0_0.newLabel({
		outline = true,
		text = string.lf("等级：%d", arg_10_3.level),
		font = fontTyep,
		size = var_10_3,
		color = var_10_6
	})

	var_10_16:setAnchorPoint(ccp(0, 0.5))
	var_10_16:setPosition(65, 180)
	var_10_9:addChild(var_10_16)

	local var_10_17 = var_0_0.newLabel({
		outline = true,
		text = string.lf("战力：%d", arg_10_3.battlePower),
		font = var_10_0,
		size = var_10_4,
		color = var_10_7
	})

	var_10_17:setAnchorPoint(ccp(0, 0.5))
	var_10_17:setPosition(65, 155)
	var_10_9:addChild(var_10_17)

	local var_10_18 = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		text = string.lf("操作"),
		fontSize = ColorTable.eTitleButton_FontSize2,
		textColor = ColorTable.eTitleButton_Normal2,
		clickAction = function(arg_12_0, arg_12_1)
			arg_10_0:showTips(arg_10_2, arg_10_3)
		end
	})

	var_10_18:setPosition(var_10_8.width / 2, 105)
	var_10_9:addChild(var_10_18)

	local var_10_19 = ui.newControlButton({
		disabledImage = "ui/common/common_080.png",
		normalImage = "ui/common/common_019.png",
		text = string.lf("赠送体力"),
		fontSize = ColorTable.eTitleButton_FontSize2,
		textColor = ColorTable.eTitleButton_Normal2,
		clickAction = function(arg_13_0, arg_13_1)
			if Player.vipLevel > 2 then
				arg_10_0.request:sendPresent(var_10_10)
			else
				ui.showMessageBox({
					animate = "slide",
					text = string.lf("上仙，VIP3即以上才能赠送体力哦！马上去充值？"),
					title1 = string.lf("确定"),
					action1 = function()
						game.enterStoreRechargeScene({
							backcall = game.enterFriendScene
						})
					end,
					title2 = string.lf("取消")
				})
			end
		end
	})

	var_10_19:setEnabled(arg_10_3.presentState == 0)
	var_10_19:setPosition(var_10_8.width / 2, 35)
	var_10_9:addChild(var_10_19)

	return var_10_9
end

function var_0_2.showTips(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = var_0_1.new({
		type = var_0_1.eTypeTips
	})

	var_15_0.actMargin = 20
	var_15_0.actDirection = "vertical"

	var_15_0:addAction({
		text = string.lf("发送信息"),
		callback = function()
			var_15_0:removeSelf()
			var_0_1.createDialog({
				show = var_0_1.eShowEditBox,
				data = {
					title = string.lf("请输入您给 #C6D27E%s#FFFFFF 的留言：", arg_15_2.name),
					text = string.lf("上仙，心里想你直痒痒，联络信息要常发！")
				},
				callback = function(arg_17_0)
					arg_15_0.request:sendFriend(arg_15_2.userId, arg_17_0)
				end
			}):show()
		end
	})
	var_15_0:addAction({
		text = string.lf("删除好友"),
		callback = function()
			var_15_0:removeSelf()
			var_0_1.createDialog({
				show = var_0_1.eShowNoticeBox,
				data = string.lf("上仙，友情得来不易，佛说前世500次的回眸才换来今世的相识。\n您确定要和 #C6D27E%s#FFFFFF 割袍断义，分道扬镳吗？", arg_15_2.name),
				callback = function()
					arg_15_0.request:deleteFriend(arg_15_2.userId)
				end
			}):show()
		end
	})
	dump(texttest, "texttest")
	var_15_0:show({
		x = 30,
		y = 130,
		scroll = {
			table = arg_15_0.tableview,
			index = arg_15_1,
			size = CCSize(228, 480)
		}
	})
end

return var_0_2
