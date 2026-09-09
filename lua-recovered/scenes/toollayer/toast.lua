local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = require("scenes.toollayer.layer")
local var_0_2 = {
	createRewardToast = function(arg_1_0)
		local var_1_0 = arg_1_0.rewards

		arg_1_0.type = var_0_1.eTypeToast

		local var_1_1 = var_0_1.new(arg_1_0)

		if var_1_0 and #var_1_0 > 0 then
			local var_1_2 = var_0_0.createRewardNode(var_1_0)

			var_1_1:addNode(var_1_2)
		end

		return var_1_1
	end
}
local var_0_3 = {
	eShowReward = var_0_2.createRewardToast
}

for iter_0_0, iter_0_1 in pairs(var_0_3) do
	var_0_1.__register(var_0_1.eTypeToast, var_0_1[iter_0_0], iter_0_1)
end
