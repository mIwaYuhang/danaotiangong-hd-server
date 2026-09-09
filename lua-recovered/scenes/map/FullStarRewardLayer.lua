FullStarsRewardType = {
	eCopper = 1,
	eGold = 3,
	eSilver = 2
}

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("FullStarRewardLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create(ccc4(10, 10, 10, 180)))
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0.rewardList = arg_2_1.rewardList
	arg_2_0.canGet = arg_2_1.canGet
	arg_2_0.getReward = arg_2_1.getReward
	arg_2_0.chapterId = arg_2_1.chapterId
	arg_2_0.rewardType = arg_2_1.rewardType or FullStarsRewardType.eCopper

	local var_2_0 = CCSize(display.width, display.height)

	arg_2_0:setContentSize(var_2_0)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		return true
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.background = arg_2_0:createDialogBox()

	arg_2_0.background:setAnchorPoint(CCPoint(0.5, 0.5))
	arg_2_0.background:setPosition(var_2_0.width / 2 - 45, var_2_0.height / 2)
	arg_2_0:addChild(arg_2_0.background)
	arg_2_0:setAnchorPoint(CCPoint(0, 0))
	arg_2_0:setPosition(0, 0)
	GuideLayer:removeAllGuideLayer()
end

function var_0_1.createDialogBox(arg_4_0)
	local var_4_0 = display.newSprite("ui/task/task_013.png")

	var_4_0:setScale(Adapter.MinScale)

	local var_4_1 = {
		"uilocal/task/task_text_004.png",
		"uilocal/task/task_text_005.png",
		"uilocal/task/task_text_006.png"
	}
	local var_4_2 = display.newSprite(var_4_1[arg_4_0.rewardType], 491, 328)

	var_4_0:addChild(var_4_2)

	local var_4_3 = arg_4_0.canGet and string.lf("领取") or string.lf("关闭")
	local var_4_4 = ui.newControlButton({
		fontSize = 25,
		normalImage = "ui/common/common_105.png",
		text = var_4_3,
		textColor = ccc3(228, 191, 101),
		position = CCPoint(440, -38),
		clickAction = function(arg_5_0, arg_5_1)
			if arg_4_0.canGet then
				arg_4_0.getReward(arg_4_0.chapterId, arg_4_0.rewardType)
			else
				arg_4_0:removeFromParentAndCleanup(true)
			end
		end
	})

	var_4_0:addChild(var_4_4)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.rewardList) do
		local var_4_5 = {
			isName = true,
			type = iter_4_1.Type,
			itemId = iter_4_1.ID or 1,
			nameColor = ccc3(239, 232, 195),
			count = iter_4_1.Count,
			clickAction = function(arg_6_0, arg_6_1)
				local var_6_0 = arg_6_1.tag

				var_0_0.tipshandler(arg_4_0.rewardList[var_6_0])
			end
		}
		local var_4_6 = figure.createHeader(var_4_5)

		var_4_6:setAnchorPoint(CCPoint(0.5, 0.5))

		local var_4_7 = (iter_4_0 - 1) % 3 * 130 + (iter_4_0 > 3 and 280 or 360)
		local var_4_8 = -math.floor((iter_4_0 - 1) / 3) * 123 + 215

		var_4_6:setPosition(var_4_7, var_4_8)

		var_4_6.headerButton.tag = iter_4_0

		local var_4_9 = getItemQuality(var_4_5.type, var_4_5.itemId)
		local var_4_10 = getQualityColor(var_4_9)

		var_4_6:setNameLabelColor(var_4_10)
		var_4_0:addChild(var_4_6)
	end

	return var_4_0
end

return var_0_1
