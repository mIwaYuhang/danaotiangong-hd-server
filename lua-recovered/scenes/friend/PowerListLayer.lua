require("network.FriendRequest")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = class("PowerListLayer", function()
	return CCScale9Sprite:create("ui/friend/friend_003.png")
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	local var_2_0 = CCSize(910, 508)

	arg_2_0:setPreferredSize(var_2_0)

	arg_2_0.size = var_2_0
	arg_2_0.container = arg_2_0
	arg_2_0.request = arg_2_1.request
	arg_2_0.request.do_power_handler = handler(arg_2_0, arg_2_0.requesthandler)

	arg_2_0:onEnterAlias()
end

function var_0_1.requesthandler(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == FriendRequest.ePresentInfo then
		local var_3_0 = arg_3_2.presents

		arg_3_0.remainTime = arg_3_2.remainGetTime
		arg_3_0.dataset = var_3_0

		arg_3_0.tableview:reloadData(var_3_0)
	elseif arg_3_1 == FriendRequest.eGetBackBatch then
		showFlashNotice(string.lf("体力领取成功！"))

		local var_3_1 = arg_3_2.remainGetTime
		local var_3_2 = arg_3_2.presents

		arg_3_0.tableview:reloadData(var_3_2)

		arg_3_0.remainTime = var_3_1
		arg_3_0.dataset = var_3_2
	elseif arg_3_1 == FriendRequest.eGetPresent then
		showFlashNotice(string.lf("体力领取成功！"))

		local var_3_3 = arg_3_0.dataset
		local var_3_4 = arg_3_0.request.friendId

		for iter_3_0, iter_3_1 in ipairs(var_3_3) do
			if iter_3_1.id == var_3_4 then
				table.remove(var_3_3, iter_3_0)

				break
			end
		end

		arg_3_0.tableview:reloadData(var_3_3, true)

		arg_3_0.remainTime = arg_3_0.remainTime - 1
	end
end

function var_0_1.onEnterAlias(arg_4_0)
	local var_4_0 = arg_4_0.size
	local var_4_1 = arg_4_0.container
	local var_4_2 = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		size = CCSize(220, 52),
		text = string.lf("一键领取并回赠"),
		fontSize = ColorTable.eTitleButton_FontSize2,
		textColor = ColorTable.eTitleButton_Normal2,
		clickAction = function(arg_5_0, arg_5_1)
			if arg_4_0.remainTime == 0 then
				showFlashNotice(string.lf("今日体力领取次数已用完！"))
			elseif Player.curPower >= Player.maxPower then
				showFlashNotice(string.lf("当前体力已恢复满！"))
			elseif #arg_4_0.dataset > 0 then
				arg_4_0.request:getBackBatch()
			end
		end
	})

	var_4_2:setPosition(105, var_4_0.height + 28)
	var_4_1:addChild(var_4_2, 1)

	local var_4_3 = var_0_0.newLabel({
		size = 50,
		text = string.lf("暂未收到体力赠送"),
		font = _FONT_LISU,
		color = ccc3(219, 174, 115)
	})

	var_4_3:setAnchorPoint(CCPoint(0.5, 0.5))
	var_4_3:setPosition(var_4_0.width / 2, var_4_0.height / 2)
	var_4_1:addChild(var_4_3)

	local var_4_4 = createTableView({
		direction = kCCScrollViewDirectionVertical,
		size = CCSize(870, 496),
		sizehandler = function(arg_6_0, arg_6_1)
			return CCSize(292, 122)
		end,
		cellhandler = handler(arg_4_0, arg_4_0.createRequestCell)
	})

	var_4_4:setAnchorPoint(CCPoint(0, 0))
	var_4_4:setPosition(20, 6)
	var_4_1:addChild(var_4_4)

	local var_4_5 = var_4_4.reloadData

	function var_4_4.reloadData(arg_7_0, arg_7_1)
		arg_7_1 = arg_7_1 or {}

		if #arg_7_1 > 0 then
			var_4_3:setVisible(false)
		else
			var_4_3:setVisible(true)
		end

		var_4_5(arg_7_0, arg_7_1)
	end

	arg_4_0.tableview = var_4_4

	arg_4_0.request:presentInfo()
end

function var_0_1.createRequestCell(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = 22
	local var_8_1 = ccc3(116, 21, 0)
	local var_8_2 = ccc3(0, 0, 0)
	local var_8_3 = ccc3(0, 0, 0)
	local var_8_4 = CCSize(866, 115)
	local var_8_5 = CCScale9Sprite:create("ui/friend/friend_004.png")

	var_8_5:setPreferredSize(var_8_4)
	var_8_5:setAnchorPoint(ccp(0, 0))
	var_8_5:setPosition(0, 0)

	local var_8_6 = arg_8_3.userId
	local var_8_7 = display.newSprite(getItemHeaderImagePath(ItemType.eHero, arg_8_3.headerId))
	local var_8_8 = CCScale9Sprite:create("ui/common/bg_figure_blue.png")
	local var_8_9 = CCSize(82, 82)

	var_8_7:setPosition(var_8_9.width / 2, var_8_9.height / 2)
	var_8_8:setPreferredSize(var_8_9)
	var_8_8:addChild(var_8_7)
	var_8_8:setAnchorPoint(CCPoint(0, 0.5))
	var_8_8:setPosition(40, var_8_4.height / 2)
	var_8_5:addChild(var_8_8)

	local var_8_10 = var_0_0.newLabel({
		text = arg_8_3.name,
		size = var_8_0,
		color = var_8_1
	})

	var_8_10:setAnchorPoint(CCPoint(0, 0.5))
	var_8_10:setPosition(160, 80)
	var_8_5:addChild(var_8_10)

	local var_8_11 = var_0_0.newLabel({
		text = string.lf("等级：%s", arg_8_3.level),
		size = var_8_0,
		color = var_8_2
	})

	var_8_11:setAnchorPoint(CCPoint(0, 0.5))
	var_8_11:setPosition(300, 80)
	var_8_5:addChild(var_8_11)

	local var_8_12 = var_0_0.newLabel({
		text = string.lf("战力：%s", arg_8_3.battlePower),
		size = var_8_0,
		color = var_8_2
	})

	var_8_12:setAnchorPoint(CCPoint(0, 0.5))
	var_8_12:setPosition(460, 80)
	var_8_5:addChild(var_8_12)

	local var_8_13
	local var_8_14 = arg_8_3.days

	if var_8_14 > 0 then
		var_8_13 = string.lf("%s天前", var_8_14)
	else
		var_8_13 = string.lf("今天")
	end

	local var_8_15 = var_0_0.newLabel({
		text = string.lf("体力赠送时间：%s", var_8_13),
		size = var_8_0,
		color = var_8_3
	})

	var_8_15:setAnchorPoint(CCPoint(0, 0.5))
	var_8_15:setPosition(160, 35)
	var_8_5:addChild(var_8_15)

	local var_8_16 = ui.newControlButton({
		normalImage = "ui/common/common_018.png",
		text = string.lf("领取"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_9_0, arg_9_1)
			if arg_8_0.remainTime == 0 then
				showFlashNotice(string.lf("今日体力领取次数已用完！"))
			elseif Player.curPower >= Player.maxPower then
				showFlashNotice(string.lf("当前体力已恢复满！"))
			else
				arg_8_0.request:getPresent(arg_8_3.id)
			end
		end
	})

	var_8_16:setPosition(var_8_4.width - 82, var_8_4.height / 2)
	var_8_5:addChild(var_8_16)

	return var_8_5
end

return var_0_1
