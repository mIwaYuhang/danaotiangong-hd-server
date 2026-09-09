require("base.functions")
require("base.figure")
require("scenes.team.OthersTeamHelper")
require("network.FriendRequest")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = require("scenes.ToolLayer")
local var_0_2 = {
	tagPower = 2,
	tagRequest = 3,
	tagRecommend = 4,
	tagFriend = 1
}

local function var_0_3(arg_1_0, arg_1_1)
	print("do nothing handler")
end

local var_0_4 = class("FriendScene", function()
	return display.newScene("FriendScene")
end)

function var_0_4.ctor(arg_3_0, arg_3_1)
	arg_3_0.container = nil
	arg_3_0.tabview = nil
	arg_3_0.count = {
		total = 0,
		online = 0
	}
	arg_3_0.default = arg_3_1 and arg_3_1.default or var_0_2.tagFriend

	arg_3_0:initRequest()
	arg_3_0:onEnterAlias()
end

function var_0_4.onEnterAlias(arg_4_0)
	local var_4_0 = require("scenes.CommonBgLayer").new({
		titleSprite = "uilocal/friend/friend_text_001.png"
	})
	local var_4_1 = var_4_0:getBackgroundSprite()
	local var_4_2 = var_4_1:getContentSize()

	arg_4_0:addChild(var_4_0)

	arg_4_0.container = var_4_1

	local var_4_3 = var_0_0.newLabel({
		size = 24,
		text = string.lf("好友数量：0 / 0"),
		color = ccc3(219, 174, 115)
	})

	var_4_3:setAnchorPoint(ccp(0, 0.5))
	var_4_3:setPosition(200, var_4_2.height - 40)
	var_4_1:addChild(var_4_3)

	arg_4_0.count.node = var_4_3

	local var_4_4 = {
		{
			x = 440,
			tag = var_0_2.tagFriend,
			titleText = string.lf("好友列表")
		},
		{
			x = 570,
			tag = var_0_2.tagPower,
			titleText = string.lf("收取体力")
		},
		{
			x = 700,
			tag = var_0_2.tagRequest,
			titleText = string.lf("交友请求")
		},
		{
			x = 830,
			tag = var_0_2.tagRecommend,
			titleText = string.lf("推荐好友")
		}
	}

	var_4_4[arg_4_0.default].isDefault = true

	local var_4_5 = require("scenes.TabLayer").new({
		selectedImage = "ui/common/common_023.png",
		normalImage = "ui/common/common_022.png",
		size = CCSize(910, 508),
		point = ccp(25, 10),
		config = var_4_4,
		cellHandler = function(arg_5_0, arg_5_1)
			arg_4_0.request.do_friend_handler = var_0_3
			arg_4_0.request.do_power_handler = var_0_3
			arg_4_0.request.do_request_handler = var_0_3
			arg_4_0.request.do_recommend_handler = var_0_3

			local var_5_0 = ({
				arg_4_0.createFriendLayer,
				arg_4_0.createPowerLayer,
				arg_4_0.createRequestLayer,
				arg_4_0.createRecommendLayer
			})[arg_5_1](arg_4_0)

			var_5_0:setAnchorPoint(CCPoint(0, 0))
			var_5_0:setPosition(0, 0)
			arg_5_0:addChild(var_5_0)

			if arg_5_1 ~= var_0_2.tagRecommend then
				GuideLayer:hideGuideLayerIfStepGreaterThan(TaskEntryType.eEntryFriend, 2)
			end
		end
	})

	var_4_1:addChild(var_4_5)

	arg_4_0.tabview = var_4_5

	GuideLayer:showGuideLayer(arg_4_0, arg_4_0.container, TaskEntryType.eEntryFriend, 2, nil, true)
end

function var_0_4.initRequest(arg_6_0)
	arg_6_0.request = FriendRequest:new(arg_6_0)

	arg_6_0.request:setResponseNormalHandler(function()
		local var_7_0, var_7_1 = arg_6_0.request:getResponseContent()

		if var_7_0 == FriendRequest.eFriendList then
			local var_7_2 = var_7_1.friendList or NULL

			arg_6_0:setFriendCount(#var_7_2, var_7_1.friendCountMax)
			arg_6_0:setBubbleNumber({
				tag = var_0_2.tagRequest,
				set = var_7_1.requestCount
			})
			arg_6_0:setBubbleNumber({
				tag = var_0_2.tagPower,
				set = var_7_1.getEnergyNumber
			})
		elseif var_7_0 == FriendRequest.eRequestList then
			arg_6_0:setBubbleNumber({
				tag = var_0_2.tagRequest,
				set = #var_7_1
			})
		elseif var_7_0 == FriendRequest.eConsent or var_7_0 == FriendRequest.eRefuse then
			arg_6_0:setBubbleNumber({
				inc = -1,
				tag = var_0_2.tagRequest
			})
		elseif var_7_0 == FriendRequest.eGetBackBatch then
			arg_6_0:setBubbleNumber({
				set = 0,
				tag = var_0_2.tagPower
			})
		elseif var_7_0 == FriendRequest.eGetPresent then
			arg_6_0:setBubbleNumber({
				inc = -1,
				tag = var_0_2.tagPower
			})
		end

		arg_6_0.request.do_friend_handler(var_7_0, var_7_1)
		arg_6_0.request.do_power_handler(var_7_0, var_7_1)
		arg_6_0.request.do_request_handler(var_7_0, var_7_1)
		arg_6_0.request.do_recommend_handler(var_7_0, var_7_1)
	end)
	arg_6_0.request:setResponseExceptionHandler(function()
		print("处理请求发生错误")
	end)
end

function var_0_4.setFriendCount(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.count

	arg_9_1 = arg_9_1 or var_9_0.online
	arg_9_2 = arg_9_2 or var_9_0.total

	var_9_0.node:setString(string.lf("好友数量：%s / %s", arg_9_1, arg_9_2))

	var_9_0.online = arg_9_1
	var_9_0.total = arg_9_2
end

function var_0_4.setBubbleNumber(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.tabview
	local var_10_1 = arg_10_1.set
	local var_10_2 = arg_10_1.inc
	local var_10_3 = var_10_0:getBubbleNumber(arg_10_1.tag)

	var_10_1 = var_10_1 or var_10_3
	var_10_2 = var_10_2 or 0

	local var_10_4 = var_10_1 + var_10_2

	if var_10_4 < 0 then
		var_10_4 = 0
	end

	var_10_0:setBubbleNumber(arg_10_1.tag, var_10_4)

	return var_10_3
end

function var_0_4.createPowerLayer(arg_11_0)
	return require("scenes.friend.PowerListLayer").new({
		parent = arg_11_0,
		request = arg_11_0.request
	})
end

function var_0_4.createFriendLayer(arg_12_0)
	return require("scenes.friend.FriendListLayer").new({
		parent = arg_12_0,
		request = arg_12_0.request
	})
end

function var_0_4.createRequestLayer(arg_13_0)
	return require("scenes.friend.RequestListLayer").new({
		parent = arg_13_0,
		request = arg_13_0.request
	})
end

function var_0_4.createRecommendLayer(arg_14_0)
	GuideLayer:stepDone(TaskEntryType.eEntryFriend, 2)
	GuideLayer:showGuideLayer(arg_14_0, arg_14_0.container, TaskEntryType.eEntryFriend, 3)

	return require("scenes.friend.RecommendListLayer").new({
		parent = arg_14_0,
		request = arg_14_0.request
	})
end

return var_0_4
