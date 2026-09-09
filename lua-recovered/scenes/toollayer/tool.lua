require("base.functions")

local var_0_0 = {
	getEnergyPrice = function(arg_1_0)
		arg_1_0 = arg_1_0 + 1

		for iter_1_0 = 1, #EnergyChangePrices do
			if arg_1_0 <= EnergyChangePrices[iter_1_0].maxCount then
				return EnergyChangePrices[iter_1_0].price
			end
		end
	end,
	getEnergyTotalCost = function(arg_2_0, arg_2_1)
		if not arg_2_1 or arg_2_1 < 0 then
			arg_2_1 = 0
		end

		local var_2_0 = 1
		local var_2_1 = 0
		local var_2_2 = 0
		local var_2_3 = #EnergyChangePrices

		for iter_2_0 = arg_2_1 + 1, arg_2_1 + arg_2_0 do
			for iter_2_1 = var_2_0, var_2_3 do
				if iter_2_0 <= EnergyChangePrices[iter_2_1].maxCount then
					var_2_2 = EnergyChangePrices[iter_2_1].price
					var_2_0 = iter_2_1

					break
				end
			end

			var_2_1 = var_2_1 + var_2_2
		end

		return var_2_1
	end,
	tokenId = function(arg_3_0)
		for iter_3_0, iter_3_1 in pairs(BaseProps) do
			if iter_3_1.propType == arg_3_0 then
				return iter_3_0
			end
		end
	end
}

function var_0_0.getRandomName()
	local var_4_0 = var_0_0._firstname
	local var_4_1 = var_0_0._lastname

	if not var_4_0 then
		local var_4_2 = CCFileUtils:sharedFileUtils():fullPathForFilename("support/random_name1.txt")
		local var_4_3 = CCFileUtils:sharedFileUtils():fullPathForFilename("support/random_name2.txt")
		local var_4_4 = io.readfile(var_4_2)
		local var_4_5 = io.readfile(var_4_3)

		var_4_0, var_4_1 = {}, {}

		for iter_4_0 in var_4_4:gmatch("%S+") do
			table.insert(var_4_0, iter_4_0)
			table.insert(var_4_1, iter_4_0)
		end

		for iter_4_1 in var_4_5:gmatch("%S+") do
			table.insert(var_4_1, iter_4_1)
		end

		var_0_0._firstname, var_0_0._lastname = var_4_0, var_4_1
	end

	local var_4_6 = math.random(1, #var_4_0)
	local var_4_7 = math.random(1, #var_4_1)

	return var_4_0[var_4_6] .. var_4_1[var_4_7]
end

function var_0_0.getCurrentDate()
	return os.date("*t")
end

function var_0_0.number2local(arg_6_0)
	local var_6_0 = {
		string.lf("十"),
		string.lf("百"),
		string.lf("千"),
		string.lf("万"),
		""
	}
	local var_6_1 = {
		[0] = "",
		string.lf("一"),
		string.lf("二"),
		string.lf("三"),
		string.lf("四"),
		string.lf("五"),
		string.lf("六"),
		string.lf("七"),
		string.lf("八"),
		string.lf("九")
	}
	local var_6_2 = {}
	local var_6_3 = {}

	string.gsub(math.floor(arg_6_0), ".", function(arg_7_0)
		table.insert(var_6_2, 1, tonumber(arg_7_0))
	end)

	for iter_6_0, iter_6_1 in ipairs(var_6_2) do
		table.insert(var_6_3, 1, var_6_1[iter_6_1])
		table.insert(var_6_3, 1, var_6_0[iter_6_0])
	end

	table.remove(var_6_3, 1)

	return table.concat(var_6_3)
end

function var_0_0.isLeapYear(arg_8_0)
	return arg_8_0 % 4 == 0 and (arg_8_0 % 100 ~= 0 or arg_8_0 % 400 == 0)
end

function var_0_0.getMonthDays(arg_9_0, arg_9_1)
	local var_9_0 = {
		31,
		28,
		31,
		30,
		31,
		30,
		31,
		31,
		30,
		31,
		30,
		31
	}

	if arg_9_1 == 2 and var_0_0.isLeapYear(arg_9_0) then
		return 29
	else
		return var_9_0[arg_9_1]
	end
end

function var_0_0.greater(arg_10_0, arg_10_1)
	return arg_10_1 < arg_10_0
end

function var_0_0.less(arg_11_0, arg_11_1)
	return arg_11_0 < arg_11_1
end

function var_0_0.sign(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0[arg_12_1] = arg_12_2
end

function var_0_0.push(arg_13_0, arg_13_1, arg_13_2)
	table.insert(arg_13_0, arg_13_2)
end

function var_0_0.log(...)
	local var_14_0 = {
		...
	}

	if #var_14_0 > 0 then
		local var_14_1 = var_14_0[1]
		local var_14_2 = type(var_14_1)
		local var_14_3

		if var_14_2 == "string" then
			if string.match(var_14_1, "%%[-#+%.%*%d]*[a-zA-Z%%]") then
				var_14_3 = string.format(...)
			else
				return print(...)
			end
		elseif var_14_2 == "table" then
			var_14_3 = var_0_0.tostring(var_14_1)
		elseif var_14_2 == "userdata" then
			var_14_3 = tolua.type(var_14_1)
		end

		print(var_14_3)
	else
		print("########################################")
	end
end

function var_0_0.hash(arg_15_0)
	local var_15_0 = 0
	local var_15_1 = #arg_15_0

	for iter_15_0 = 1, var_15_1 do
		var_15_0 = 31 * var_15_0 + string.byte(arg_15_0, iter_15_0)
	end

	return var_15_0
end

local var_0_1 = 1

function var_0_0.uniqueId(arg_16_0)
	local var_16_0 = var_0_1 + 1

	var_0_1 = var_16_0

	return arg_16_0 and arg_16_0 .. var_16_0 or var_16_0
end

function var_0_0.array(arg_17_0, arg_17_1)
	local var_17_0 = {}

	arg_17_1 = arg_17_1 or false

	if arg_17_0 and arg_17_0 > 0 then
		for iter_17_0 = 1, arg_17_0 do
			table.insert(var_17_0, arg_17_1)
		end
	end

	return var_17_0
end

function var_0_0.resize(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = #arg_18_0
	local var_18_1 = 0
	local var_18_2

	if arg_18_1 < var_18_0 then
		var_18_1 = var_18_0 - arg_18_1
		var_18_2 = table.remove
		arg_18_2 = nil
	else
		var_18_1 = arg_18_1 - var_18_0
		var_18_2 = table.insert
		arg_18_2 = arg_18_2 or false
	end

	for iter_18_0 = 1, var_18_1 do
		var_18_2(arg_18_0, arg_18_2)
	end

	return arg_18_0
end

function var_0_0.sum(...)
	local var_19_0 = 0
	local var_19_1 = {
		...
	}

	for iter_19_0, iter_19_1 in ipairs(var_19_1) do
		if type(iter_19_1) == "table" then
			var_19_0 = var_0_0.sum(unpack(iter_19_1))
		else
			var_19_0 = var_19_0 + iter_19_1
		end
	end

	return var_19_0
end

function var_0_0.shuffle(arg_20_0)
	local var_20_0 = #arg_20_0
	local var_20_1 = {}
	local var_20_2 = {}

	for iter_20_0 = 1, var_20_0 do
		var_20_1[iter_20_0] = {
			rnd = math.random(),
			idx = iter_20_0
		}
	end

	table.sort(var_20_1, function(arg_21_0, arg_21_1)
		return arg_21_0.rnd < arg_21_1.rnd
	end)

	for iter_20_1 = 1, var_20_0 do
		var_20_2[iter_20_1] = arg_20_0[var_20_1[iter_20_1].idx]
	end

	return var_20_2
end

function var_0_0.foreach(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = 1
	local var_22_1 = #arg_22_0
	local var_22_2 = 1
	local var_22_3 = var_0_0.greater

	if arg_22_3 then
		var_22_0, var_22_1 = var_22_1, var_22_0
		var_22_2 = -1
		var_22_3 = var_0_0.less
	end

	local function var_22_4()
		if var_22_3(var_22_0, var_22_1) then
			return arg_22_2 and arg_22_2()
		else
			local var_23_0 = var_22_0
			local var_23_1 = arg_22_0[var_22_0]

			var_22_0 = var_22_0 + var_22_2

			arg_22_1(var_23_0, var_23_1, var_22_4)
		end
	end

	var_22_4()
end

function var_0_0.wait(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0 == "event" then
		local var_24_0 = 0

		if type(arg_24_1) == "function" then
			arg_24_2 = arg_24_1
			arg_24_1 = 1
		end

		return function()
			var_24_0 = var_24_0 + 1

			if var_24_0 == arg_24_1 then
				return arg_24_2 and arg_24_2()
			end
		end
	elseif arg_24_0 == "time" then
		local var_24_1 = CCArray:create()
		local var_24_2 = CCDirector:sharedDirector():getRunningScene()

		var_24_1:addObject(CCDelayTime:create(arg_24_1))
		var_24_1:addObject(CCCallFunc:create(arg_24_2))
		var_24_2:runAction(CCSequence:create(var_24_1))
	else
		return arg_24_2 and arg_24_2()
	end
end

function var_0_0.defaults(arg_26_0, ...)
	local var_26_0 = {
		...
	}

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		if iter_26_1 then
			for iter_26_2, iter_26_3 in pairs(iter_26_1) do
				if not arg_26_0[iter_26_2] then
					arg_26_0[iter_26_2] = iter_26_3
				end
			end
		end
	end

	return arg_26_0
end

local function var_0_2(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if type(arg_27_0) ~= "table" or type(arg_27_1) ~= "table" then
		return arg_27_0 == arg_27_1
	end

	local var_27_0 = 0
	local var_27_1 = true

	for iter_27_0 = #arg_27_2, 1, -1 do
		if arg_27_2[iter_27_0] == arg_27_0 then
			return arg_27_3[iter_27_0] == arg_27_1
		end
	end

	table.insert(arg_27_2, arg_27_0)
	table.insert(arg_27_3, arg_27_1)

	for iter_27_1, iter_27_2 in pairs(arg_27_0) do
		var_27_0 = var_27_0 + 1
		var_27_1 = not not arg_27_1[iter_27_1] and var_0_2(arg_27_0[iter_27_1], arg_27_1[iter_27_1], arg_27_2, arg_27_3)

		if not var_27_1 then
			break
		end
	end

	if var_27_1 then
		for iter_27_3, iter_27_4 in pairs(arg_27_1) do
			if var_27_0 == 0 then
				var_27_1 = false

				break
			end

			var_27_0 = var_27_0 - 1
		end
	end

	return var_27_1
end

function var_0_0.isEqual(arg_28_0, arg_28_1)
	return var_0_2(arg_28_0, arg_28_1, {}, {})
end

function var_0_0.isArraylike(arg_29_0)
	local var_29_0 = #arg_29_0

	if type(arg_29_0) == "table" then
		return var_29_0 == 0 or var_29_0 > 0 and arg_29_0[var_29_0]
	else
		return false
	end
end

function var_0_0.tostring(arg_30_0, arg_30_1, arg_30_2)
	arg_30_2 = arg_30_2 or {}
	arg_30_1 = arg_30_1 or 0

	if type(arg_30_0) == "table" then
		local var_30_0 = {}

		for iter_30_0, iter_30_1 in pairs(arg_30_0) do
			table.insert(var_30_0, string.rep(" ", arg_30_1))

			if type(iter_30_1) == "table" and not arg_30_2[iter_30_1] then
				arg_30_2[iter_30_1] = true

				table.insert(var_30_0, string.format("[%s] = {\n", tostring(iter_30_0)))
				table.insert(var_30_0, string.rep(" ", arg_30_1))
				table.insert(var_30_0, "}\n")
			else
				table.insert(var_30_0, string.format("[%s] = \"%s\"\n", tostring(iter_30_0), tostring(iter_30_1)))
			end
		end

		return table.concat(var_30_0)
	else
		return tostring(arg_30_0)
	end
end

return var_0_0
