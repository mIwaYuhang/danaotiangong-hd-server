local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("VipDetailInfoLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create(ccc4(10, 10, 10, 180)))
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0.detailList = arg_2_1.rewardList

	local var_2_0 = CCSize(display.width, display.height)

	arg_2_0:setContentSize(var_2_0)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		return true
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.background = arg_2_0:createDialogBox()

	arg_2_0.background:setAnchorPoint(CCPoint(0.5, 0.5))
	arg_2_0.background:setPosition(display.cx, display.cy)
	arg_2_0:addChild(arg_2_0.background)
	arg_2_0:setAnchorPoint(CCPoint(0, 0))
	arg_2_0:setPosition(0, 0)
end

function var_0_1.createDialogBox(arg_4_0)
	local var_4_0 = display.newSprite("ui/store/store_036.png")

	var_4_0:setScale(Adapter.MinScale)

	local var_4_1 = string.lf("关闭")
	local var_4_2 = ui.newControlButton({
		fontSize = 25,
		normalImage = "ui/common/btn_closed.png",
		textColor = ccc3(228, 191, 101),
		position = CCPoint(660, 320),
		clickAction = function(arg_5_0, arg_5_1)
			arg_4_0:removeFromParentAndCleanup(true)
		end
	})

	var_4_0:addChild(var_4_2)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.detailList) do
		local var_4_3 = {
			isName = true,
			type = iter_4_1.Type,
			itemId = iter_4_1.ID or 1,
			nameColor = ccc3(239, 232, 195),
			count = iter_4_1.Count,
			level = iter_4_1.Level,
			equipJieji = iter_4_1.JieJi,
			clickAction = function(arg_6_0, arg_6_1)
				local var_6_0 = arg_6_1.tag

				var_0_0.tipshandler(arg_4_0.detailList[var_6_0])
			end
		}
		local var_4_4 = figure.createHeader(var_4_3)

		var_4_4:setAnchorPoint(CCPoint(0.5, 0.5))

		local var_4_5 = (iter_4_0 - 1) % 3 * 130 + 210
		local var_4_6 = -math.floor((iter_4_0 - 1) / 3) * 123 + 220

		var_4_4:setPosition(var_4_5, var_4_6)

		var_4_4.headerButton.tag = iter_4_0

		local var_4_7 = getItemQuality(var_4_3.type, var_4_3.itemId)
		local var_4_8 = getQualityColor(var_4_7)

		var_4_4:setNameLabelColor(var_4_8)
		var_4_0:addChild(var_4_4)
	end

	return var_4_0
end

return var_0_1
