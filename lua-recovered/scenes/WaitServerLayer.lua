local var_0_0 = class("WaitServerLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0)
	local function var_2_0(arg_3_0, arg_3_1, arg_3_2)
		return true
	end

	arg_2_0:addTouchEventListener(var_2_0, false, -128, true)
	arg_2_0:setTouchEnabled(true)

	local var_2_1 = CCSkeletonAnimation:createWithFile("ui/common/ui_loading.json", "ui/common/ui_loading.atlas", 1)

	var_2_1:setAnimation("animation", true, 0)
	var_2_1:setScale(Adapter.MinScale)
	var_2_1:setPosition(display.cx, display.cy * 2 / 3)
	arg_2_0:addChild(var_2_1)
end

return var_0_0
