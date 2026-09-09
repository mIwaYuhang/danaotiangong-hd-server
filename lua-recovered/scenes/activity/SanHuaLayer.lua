require("base.functions")
require("data.player")
require("network.ActivityRequest")

local var_0_0
local var_0_1 = class("SanHuaLayer", function()
	return display.newLayer()
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0.isJoin = 0
	arg_2_0.remainTime = 0
	arg_2_0.nodeSize = CCSize(830, 545)
	arg_2_0.container = CCLayerColor:create(ccc4(0, 0, 0, 0))

	arg_2_0.container:setContentSize(arg_2_0.nodeSize)
	arg_2_0:addChild(arg_2_0.container)

	if arg_2_1.parent then
		var_0_0 = arg_2_1.parent
	end

	arg_2_0:initRequests()
	arg_2_0:showInitLayer()
	arg_2_0.flowersInfoRequest:request()
end

function var_0_1.initRequests(arg_3_0)
	local function var_3_0()
		local var_4_0 = arg_3_0.flowersInfoRequest.restable

		arg_3_0.isJoin = var_4_0.isJoin
		arg_3_0.remainTime = var_4_0.remainTime

		local var_4_1 = ""

		for iter_4_0 = 1, table.nums(var_4_0.Times) do
			local var_4_2 = var_4_0.Times[iter_4_0]

			if iter_4_0 == 1 then
				var_4_1 = var_4_2.start .. "~" .. var_4_2["end"]
			else
				var_4_1 = var_4_1 .. "     " .. var_4_2.start .. "~" .. var_4_2["end"]
			end
		end

		arg_3_0.infoLabel:setString(var_4_1)

		if arg_3_0.isJoin == 1 then
			arg_3_0.timeLabel:setString(string.lf("您已经参加了此次活动"))
			arg_3_0.btnUse:setEnabled(false)

			return
		end

		if arg_3_0.remainTime > 0 then
			arg_3_0:createTimer()
			arg_3_0.btnUse:setEnabled(true)
		else
			arg_3_0.timeLabel:setString(string.lf("当前不在游戏时间内"))
			arg_3_0.btnUse:setEnabled(false)
		end
	end

	arg_3_0.flowersInfoRequest = FlowersInfoRequest:new()

	arg_3_0.flowersInfoRequest:setResponseNormalHandler(var_3_0)
end

function var_0_1.showInitLayer(arg_5_0)
	local var_5_0 = display.newSprite("ui/activity/activity_071.jpg")

	var_5_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_5_0:setPosition(CCPoint(arg_5_0.nodeSize.width / 2, arg_5_0.nodeSize.height / 2 + 12))
	arg_5_0.container:addChild(var_5_0)

	local var_5_1 = display.newSprite("ui/activity/activity_072.png")

	var_5_1:setAnchorPoint(CCPoint(0.5, 0.5))
	var_5_1:setPosition(CCPoint(arg_5_0.nodeSize.width / 2, arg_5_0.nodeSize.height / 2 + 12))
	arg_5_0.container:addChild(var_5_1)

	local var_5_2 = display.newSprite("uilocal/activity/activity_text_010.png")

	var_5_2:setAnchorPoint(CCPoint(0.5, 0.5))
	var_5_2:setPosition(CCPoint(arg_5_0.nodeSize.width / 2, arg_5_0.nodeSize.height / 2 + 120))
	arg_5_0.container:addChild(var_5_2)
	addLabelWithColorSize(arg_5_0.container, string.lf("每天有两次免费补充15点体力的机会"), ccc3(255, 225, 225), 30, CCPoint(0.5, 0.5), CCPoint(arg_5_0.nodeSize.width / 2, arg_5_0.nodeSize.height / 2 + 30))

	arg_5_0.infoLabel = addLabelWithColorSize(arg_5_0.container, "", ccc3(255, 255, 255), 25, CCPoint(0.5, 0.5), CCPoint(arg_5_0.nodeSize.width / 2, arg_5_0.nodeSize.height / 2 - 15))
	arg_5_0.btnUse = ui.newControlButton({
		disabledImage = "ui/common/common_078.png",
		titleImage = "uilocal/activity/activity_text_012.png",
		normalImage = "ui/common/common_027.png",
		highlightedImage = "ui/common/common_027.png",
		size = CCSize(150, 65),
		anchorPoint = CCPoint(0.5, 0.5),
		position = CCPoint(arg_5_0.nodeSize.width / 2, arg_5_0.nodeSize.height / 2 - 100),
		clickAction = function()
			if arg_5_0.isJoin == 1 then
				showFlashNotice(string.lf("您已经参加过此次活动"))

				return
			end

			game.enterPlutusScene({
				remainTime = arg_5_0.remainTime
			})
		end
	})

	arg_5_0.btnUse:setEnabled(false)
	arg_5_0.container:addChild(arg_5_0.btnUse)

	arg_5_0.timeLabel = addLabelWithColorSize(arg_5_0.container, "", ccc3(255, 0, 0), 25, CCPoint(0.5, 0.5), CCPoint(arg_5_0.nodeSize.width / 2, arg_5_0.nodeSize.height / 2 - 150))
end

function var_0_1.createTimer(arg_7_0)
	local var_7_0 = {}

	local function var_7_1()
		arg_7_0.timeLabel:setString(string.lf("%s 后游戏结束", formatTime(arg_7_0.remainTime)))

		arg_7_0.remainTime = arg_7_0.remainTime - 1

		if arg_7_0.remainTime <= 0 then
			arg_7_0.timeLabel:setString(string.lf("此次活动已结束"))
			arg_7_0.btnUse:setEnabled(false)
			var_0_0:removeFromTimerTable(var_7_1)
		end
	end

	var_7_0.callback = var_7_1

	var_0_0:addToTimerTable(var_7_0)
end

return var_0_1
