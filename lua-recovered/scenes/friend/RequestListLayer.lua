require("base.figure")
require("network.FriendRequest")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = class("RequestListLayer", function()
	return CCScale9Sprite:create("ui/friend/friend_003.png")
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	local var_2_0 = CCSize(910, 508)

	arg_2_0:setPreferredSize(var_2_0)

	arg_2_0.size = var_2_0
	arg_2_0.container = arg_2_0
	arg_2_0.request = arg_2_1.request
	arg_2_0.request.do_request_handler = handler(arg_2_0, arg_2_0.requesthandler)

	Player:setFriendRequestCnt(0)
	arg_2_0:onEnterAlias()
end

function var_0_1.requesthandler(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == FriendRequest.eRequestList then
		arg_3_0.dataset = arg_3_2

		arg_3_0.tableview:reloadData(arg_3_2)
	elseif arg_3_1 == FriendRequest.eConsent or arg_3_1 == FriendRequest.eRefuse then
		local var_3_0 = arg_3_0.dataset
		local var_3_1 = arg_3_0.request.friendId

		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			if iter_3_1.userId == var_3_1 then
				table.remove(var_3_0, iter_3_0)

				break
			end
		end

		arg_3_0.tableview:reloadData(var_3_0)
	end
end

function var_0_1.onEnterAlias(arg_4_0)
	local var_4_0 = arg_4_0.size
	local var_4_1 = arg_4_0.container
	local var_4_2 = var_0_0.newLabel({
		size = 50,
		text = string.lf("暂未收到交友请求"),
		font = _FONT_LISU,
		color = ccc3(219, 174, 115)
	})

	var_4_2:setAnchorPoint(CCPoint(0.5, 0.5))
	var_4_2:setPosition(var_4_0.width / 2, var_4_0.height / 2)
	var_4_1:addChild(var_4_2)

	local var_4_3 = createTableView({
		direction = kCCScrollViewDirectionVertical,
		size = CCSize(870, 496),
		sizehandler = function(arg_5_0, arg_5_1)
			return CCSize(292, 122)
		end,
		cellhandler = handler(arg_4_0, arg_4_0.createRequestCell)
	})

	var_4_3:setAnchorPoint(CCPoint(0, 0))
	var_4_3:setPosition(20, 6)
	var_4_1:addChild(var_4_3)

	local var_4_4 = var_4_3.reloadData

	function var_4_3.reloadData(arg_6_0, arg_6_1)
		arg_6_1 = arg_6_1 or {}

		if #arg_6_1 > 0 then
			var_4_2:setVisible(false)
		else
			var_4_2:setVisible(true)
		end

		var_4_4(arg_6_0, arg_6_1)
	end

	arg_4_0.tableview = var_4_3

	arg_4_0.request:requestList()
end

function var_0_1.createRequestCell(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = 22
	local var_7_1 = ccc3(116, 21, 0)
	local var_7_2 = ccc3(0, 0, 0)
	local var_7_3 = ccc3(0, 0, 0)
	local var_7_4 = CCSize(866, 115)
	local var_7_5 = CCScale9Sprite:create("ui/friend/friend_004.png")

	var_7_5:setPreferredSize(var_7_4)
	var_7_5:setAnchorPoint(ccp(0, 0))
	var_7_5:setPosition(0, 0)

	local var_7_6 = arg_7_3.userId
	local var_7_7 = display.newSprite(getItemHeaderImagePath(ItemType.eHero, arg_7_3.headerId))
	local var_7_8 = CCScale9Sprite:create("ui/common/bg_figure_blue.png")
	local var_7_9 = var_7_7:getContentSize()

	var_7_7:setPosition(var_7_9.width / 2, var_7_9.height / 2)
	var_7_8:setPreferredSize(var_7_9)
	var_7_8:addChild(var_7_7)
	var_7_8:setAnchorPoint(CCPoint(0, 0.5))
	var_7_8:setPosition(40, var_7_4.height / 2)
	var_7_5:addChild(var_7_8)

	local var_7_10 = var_0_0.newLabel({
		text = arg_7_3.name,
		size = var_7_0,
		color = var_7_1
	})

	var_7_10:setAnchorPoint(CCPoint(0, 0.5))
	var_7_10:setPosition(160, 80)
	var_7_5:addChild(var_7_10)

	local var_7_11 = var_0_0.newLabel({
		text = string.lf("等级：%s", arg_7_3.level),
		size = var_7_0,
		color = var_7_2
	})

	var_7_11:setAnchorPoint(CCPoint(0, 0.5))
	var_7_11:setPosition(320, 80)
	var_7_5:addChild(var_7_11)

	local var_7_12 = var_0_0.newLabel({
		text = arg_7_3.content,
		size = var_7_0,
		color = var_7_3,
		dimensions = CCSize(425, 60),
		valign = ui.TEXT_ALIGN_LEFT
	})

	var_7_12:setAnchorPoint(CCPoint(0, 0.5))
	var_7_12:setPosition(160, 30)
	var_7_5:addChild(var_7_12)

	local var_7_13 = ui.newControlButton({
		normalImage = "ui/common/common_018.png",
		text = string.lf("同意"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_8_0, arg_8_1)
			arg_7_0.request:consentRequest(var_7_6)
		end
	})
	local var_7_14 = ui.newControlButton({
		normalImage = "ui/common/common_018.png",
		text = string.lf("拒绝"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_9_0, arg_9_1)
			arg_7_0.request:refuseRequest(var_7_6)
		end
	})

	var_7_13:setPosition(var_7_4.width - 210, var_7_4.height / 2)
	var_7_14:setPosition(var_7_4.width - 82, var_7_4.height / 2)
	var_7_5:addChild(var_7_13)
	var_7_5:addChild(var_7_14)

	return var_7_5
end

return var_0_1
