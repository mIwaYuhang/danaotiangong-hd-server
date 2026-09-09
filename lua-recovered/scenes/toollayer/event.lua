return (require("scenes.toollayer.class"):extend({
	silent = false,
	__events = {},
	on = function(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
		local var_1_0 = arg_1_0.__events[arg_1_1]

		if not var_1_0 then
			var_1_0 = {}
			arg_1_0.__events[arg_1_1] = var_1_0
		end

		table.insert(var_1_0, {
			arg_1_2,
			arg_1_3
		})
	end,
	once = function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local function var_2_0(...)
			arg_2_0:off(arg_2_1, var_2_0)

			if arg_2_3 then
				arg_2_2(arg_2_3, ...)
			else
				arg_2_2(...)
			end
		end

		arg_2_0:on(arg_2_1, var_2_0)
	end,
	off = function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		if arg_4_1 then
			local var_4_0
			local var_4_1 = arg_4_0.__events[arg_4_1]

			if var_4_1 then
				for iter_4_0 = #var_4_1, 1, -1 do
					local var_4_2 = var_4_1[iter_4_0]

					if arg_4_2 == var_4_2[1] and arg_4_3 == var_4_2[2] then
						table.remove(var_4_1, iter_4_0)
					end
				end
			end
		else
			arg_4_0.__events = {}
		end
	end,
	trigger = function(arg_5_0, arg_5_1, ...)
		local var_5_0 = {
			...
		}
		local var_5_1 = arg_5_0.__events[arg_5_1]
		local var_5_2 = arg_5_0.__events.all

		if arg_5_0.silent then
			return
		end

		if var_5_1 and #var_5_1 > 0 then
			arg_5_0:__triggerEvents(var_5_1, var_5_0)
		end

		if var_5_2 and #var_5_2 > 0 then
			table.insert(var_5_0, 1, arg_5_1)
			arg_5_0:__triggerEvents(var_5_2, var_5_0)
		end
	end,
	__triggerEvents = function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = #arg_6_2
		local var_6_1 = arg_6_2[1]
		local var_6_2 = arg_6_2[2]
		local var_6_3 = arg_6_2[3]

		if var_6_0 < 4 then
			for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
				if iter_6_1[2] then
					iter_6_1[1](iter_6_1[2], var_6_1, var_6_2, var_6_3)
				else
					iter_6_1[1](var_6_1, var_6_2, var_6_3)
				end
			end
		else
			for iter_6_2, iter_6_3 in ipairs(arg_6_1) do
				if iter_6_3[2] then
					iter_6_3[1](iter_6_3[2], arg_6_2)
				else
					iter_6_3[1](arg_6_2)
				end
			end
		end
	end,
	__tostring = function(arg_7_0)
		return "Event"
	end
}))
