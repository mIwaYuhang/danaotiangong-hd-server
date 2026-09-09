local var_0_0 = require("scenes.toollayer.tool")

return (require("scenes.toollayer.event"):extend({
	view = false,
	dirty = true,
	timer = false,
	__data = {},
	__children = {},
	attach = function(arg_1_0, arg_1_1)
		return
	end,
	detach = function(arg_2_0)
		arg_2_0:off()

		if arg_2_0.timer then
			arg_2_0.timer:stop()

			arg_2_0.timer = false
		end

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.__children) do
			iter_2_1:detach()
		end
	end,
	sync = function(arg_3_0)
		return
	end,
	parse = function(arg_4_0, arg_4_1)
		return arg_4_1
	end,
	loadData = function(arg_5_0, arg_5_1)
		return
	end,
	addChild = function(arg_6_0, arg_6_1)
		table.insert(arg_6_0.__children, arg_6_1)
	end,
	get = function(arg_7_0, arg_7_1)
		return arg_7_0.__data[arg_7_1]
	end,
	set = function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_8_0.__data[arg_8_1]

		if not var_0_0.isEqual(var_8_0, arg_8_2) then
			arg_8_0.__data[arg_8_1] = arg_8_2

			if type(arg_8_2) == "table" then
				-- block empty
			elseif type(var_8_0) == "table" then
				-- block empty
			end

			arg_8_0:trigger("change:" .. arg_8_1, arg_8_2, var_8_0)
		end
	end,
	bind = function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_9_1:split("|")
		local var_9_1 = #var_9_0

		if var_9_1 == 1 then
			arg_9_0:on("change:" .. arg_9_1, arg_9_2)
			arg_9_2(arg_9_0:get(arg_9_1))
		elseif var_9_1 > 1 then
			local function var_9_2()
				local var_10_0 = {}

				for iter_10_0, iter_10_1 in ipairs(var_9_0) do
					var_10_0[iter_10_0] = arg_9_0:get(iter_10_1)
				end

				arg_9_2(unpack(var_10_0))
			end

			for iter_9_0, iter_9_1 in ipairs(var_9_0) do
				arg_9_0:on("change:" .. iter_9_1, var_9_2)
			end

			var_9_2()
		end
	end,
	tolua = function(arg_11_0)
		return setmetatable({}, {
			__metatable = false,
			__index = arg_11_0.__data,
			__newindex = function(arg_12_0, arg_12_1, arg_12_2)
				return
			end
		})
	end,
	__tostring = function(arg_13_0)
		return "Model"
	end
}))
