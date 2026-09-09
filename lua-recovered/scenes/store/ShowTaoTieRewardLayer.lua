require("base.functions")
require("network.StoreRequest")

local var_0_0 = require("base.cache")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = require("scenes.toollayer.tool")
local var_0_3 = require("scenes.ToolLayer")
local var_0_4 = class("ShowTaoTieRewardLayer", function()
	return CCLayerColor:create(ccc4(0, 0, 0, 160))
end)

function var_0_4.ctor(arg_2_0, arg_2_1)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	local var_2_0 = display.newSprite("ui/guild/guild_090.png", display.cx, display.cy)

	var_2_0:setScale(Adapter.MinScale)
	arg_2_0:addChild(var_2_0)

	local var_2_1 = var_2_0:getContentSize()
	local var_2_2 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/activity/activity_text_076.png",
		position = ccp(var_2_1.width / 2, 40),
		clickAction = function()
			arg_2_0:removeFromParentAndCleanup(true)
		end
	})

	var_2_0:addChild(var_2_2)
	addLabelWithColorSize(var_2_0, string.lf("上仙，本次获得:"), ccc3(255, 228, 0), 24, ccp(0.5, 1), ccp(var_2_1.width / 2, var_2_1.height - 20))

	for iter_2_0, iter_2_1 in ipairs(arg_2_1[1]) do
		local var_2_3 = figure.createHeader({
			isName = true,
			type = iter_2_1.Type,
			itemId = iter_2_1.ID or 0,
			count = iter_2_1.Count,
			nameColor = getQualityColor(getItemQuality(iter_2_1.Type, iter_2_1.ID)),
			equipJieji = iter_2_1.BreakthroughCount,
			countColor = ccc3(255, 228, 0),
			clickAction = function()
				var_0_3.tipshandler(iter_2_1)
			end
		})

		var_2_0:addChild(var_2_3)
		var_2_3:setPosition(var_2_1.width / (table.maxn(arg_2_1[1]) + 1) * iter_2_0, var_2_1.height / 2 + 20)
	end
end

return var_0_4
