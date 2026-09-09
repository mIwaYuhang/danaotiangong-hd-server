local var_0_0 = require("framework.scheduler")

return (require("scenes.toollayer.class"):extend({
	__tid = 0,
	__handlers = {},
	update = function(arg_1_0, arg_1_1)
		table.insert(arg_1_0.__handlers, arg_1_1)
	end,
	schedule = function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		table.insert(arg_2_0.__handlers, {
			arg_2_1,
			arg_2_2,
			arg_2_3
		})

		if arg_2_2 then
			arg_2_2(0, arg_2_1)
		end
	end,
	after = function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_0:schedule(arg_3_1, false, arg_3_2)
	end,
	start = function(arg_4_0, arg_4_1)
		if arg_4_0.__tid == 0 then
			arg_4_1 = arg_4_1 or 1
			arg_4_0.__tid = var_0_0.scheduleGlobal(handler(arg_4_0, arg_4_0.__timehandler), arg_4_1)
		end
	end,
	stop = function(arg_5_0)
		local var_5_0 = arg_5_0.__tid

		if var_5_0 > 0 then
			var_0_0.unscheduleGlobal(var_5_0)

			arg_5_0.__tid = 0
		end
	end,
	running = function(arg_6_0)
		return arg_6_0.__tid > 0
	end,
	__timehandler = function(arg_7_0, arg_7_1)
		local var_7_0
		local var_7_1
		local var_7_2 = arg_7_0.__handlers

		for iter_7_0 = #var_7_2, 1, -1 do
			local var_7_3 = var_7_2[iter_7_0]
			local var_7_4 = type(var_7_3)

			if var_7_4 == "table" then
				var_7_3[1] = var_7_3[1] - arg_7_1

				if var_7_3[1] > 0.3 then
					if var_7_3[2] then
						var_7_3[2](arg_7_1, var_7_3[1])
					end
				else
					if var_7_3[2] then
						var_7_3[2](arg_7_1, 0)
					end

					if var_7_3[3] then
						var_7_3[3]()
					end

					table.remove(var_7_2, iter_7_0)
				end
			elseif var_7_4 == "function" and var_7_3(arg_7_1) then
				table.remove(var_7_2, iter_7_0)
			end
		end
	end,
	__tostring = function(arg_8_0)
		return "Timer"
	end
}))
