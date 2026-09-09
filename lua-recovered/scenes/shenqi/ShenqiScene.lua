require("base.define")
require("base.figure")
require("data.player")
require("data.task")
require("scenes.GuideLayer")

local var_0_0 = require("base.cache")
local var_0_1 = class("ShenqiScene", function()
	return display.newScene("ShenqiScene")
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	if not arg_2_1 then
		local var_2_0 = var_0_0.get("store-tag")

		arg_2_1 = {
			defaultPage = var_2_0
		}

		var_0_0.set("store-tag", false)
	end

	local var_2_1 = Adapter.AutoScaleY
	local var_2_2 = display.newSprite("ui/PK/PK_013.jpg")
	local var_2_3 = var_2_2:getContentSize()

	var_2_2:setPosition(display.cx, display.cy)
	var_2_2:setScale(var_2_1)
	arg_2_0:addChild(var_2_2)

	arg_2_1.shenQiScene = arg_2_0

	local var_2_4 = require("scenes.shenqi.ShenqiLayer").new(arg_2_1)

	arg_2_0:addChild(var_2_4)
	GuideLayer:stepDone(TaskEntryType.eShenQi, 2)
end

return var_0_1
