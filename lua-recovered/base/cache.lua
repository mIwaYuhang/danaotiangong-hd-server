local var_0_0 = require("scenes.toollayer.tool")
local var_0_1 = {}

function var_0_1.set(arg_1_0, arg_1_1)
	if not var_0_1._cache then
		var_0_1._cache = {}
	end

	arg_1_0 = var_0_1._key(arg_1_0)
	var_0_1._cache[arg_1_0] = arg_1_1

	if not var_0_1._time then
		var_0_1._time = {}
	end

	var_0_1._time[arg_1_0] = var_0_0.getCurrentDate().day
end

function var_0_1.get(arg_2_0)
	local var_2_0 = var_0_1._cache

	if var_2_0 then
		arg_2_0 = var_0_1._key(arg_2_0)

		if var_0_1._time and var_0_1._time[arg_2_0] == var_0_0.getCurrentDate().day then
			return var_2_0[arg_2_0]
		end
	end
end

function var_0_1.clean()
	var_0_1._cache = nil
end

function var_0_1._key(arg_4_0)
	local var_4_0

	if arg_4_0.__cname then
		var_4_0 = arg_4_0.__cname
	elseif type(arg_4_0) ~= "string" then
		var_4_0 = tostring(arg_4_0)
	else
		var_4_0 = arg_4_0
	end

	return var_0_0.hash(var_4_0)
end

return var_0_1
