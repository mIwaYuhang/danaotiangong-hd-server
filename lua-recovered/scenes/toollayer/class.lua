NULL = setmetatable({}, {
	__metatable = false,
	__index = function(arg_1_0, arg_1_1)
		return
	end,
	__newindex = function(arg_2_0, arg_2_1, arg_2_2)
		return
	end
})

function copyTable(arg_3_0)
	assert(type(arg_3_0) == "table", "asked to copy a non-table")

	local var_3_0 = {}

	setmetatable(var_3_0, getmetatable(arg_3_0))

	for iter_3_0, iter_3_1 in pairs(arg_3_0) do
		var_3_0[iter_3_0] = iter_3_1
	end

	return var_3_0
end

return {
	extend = function(arg_4_0, arg_4_1)
		arg_4_1 = arg_4_1 or {}

		assert(type(arg_4_1) == "table", "must extend a table, received a " .. type(arg_4_1))

		for iter_4_0, iter_4_1 in pairs(arg_4_0) do
			if iter_4_0 ~= "__index" and not arg_4_1[iter_4_0] and type(iter_4_1) == "table" then
				arg_4_1[iter_4_0] = copyTable(arg_4_0[iter_4_0])
			end
		end

		arg_4_1 = arg_4_1 or {}

		setmetatable(arg_4_1, arg_4_0)

		arg_4_0.__index = arg_4_0
		arg_4_1.prototype = arg_4_0

		return arg_4_1
	end,
	new = function(arg_5_0, arg_5_1)
		arg_5_1 = arg_5_0:extend(arg_5_1)

		local var_5_0
		local var_5_1 = arg_5_1
		local var_5_2 = {}

		while var_5_1 do
			table.insert(var_5_2, var_5_1)

			var_5_1 = var_5_1.prototype
		end

		for iter_5_0 = #var_5_2, 1, -1 do
			if rawget(var_5_2[iter_5_0], "ctor") then
				arg_5_1:ctor()
			end
		end

		return arg_5_1
	end,
	mixin = function(arg_6_0, arg_6_1)
		assert(type(arg_6_1) == "table", "must mix in a table, received a " .. type(arg_6_1))

		for iter_6_0, iter_6_1 in pairs(arg_6_1) do
			arg_6_0[iter_6_0] = arg_6_1[iter_6_0]
		end
	end,
	instanceOf = function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0.prototype

		while var_7_0 do
			if var_7_0 == arg_7_1 then
				return true
			end

			var_7_0 = var_7_0.prototype
		end

		return false
	end
}
