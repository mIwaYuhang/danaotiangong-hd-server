Localized = {}

function Localized.initLocalized(arg_1_0, arg_1_1)
	local function var_1_0(arg_2_0, arg_2_1, arg_2_2)
		return string.gsub(arg_2_0, arg_2_1, function(arg_3_0)
			return arg_2_2
		end)
	end

	local var_1_1 = CCFileUtils:sharedFileUtils():fullPathForFilename(arg_1_1)

	if io.exists(var_1_1) then
		local var_1_2 = io.readfile(var_1_1)
		local var_1_3 = string.split(var_1_2, ";")
		local var_1_4 = 0

		for iter_1_0, iter_1_1 in ipairs(var_1_3) do
			local var_1_5 = string.split(iter_1_1, "=")

			if var_1_5[1] and var_1_5[2] then
				local var_1_6 = var_1_0(var_1_5[1], "\n", "")
				local var_1_7 = var_1_5[2]
				local var_1_8 = var_1_0(var_1_6, "\\n", "\n")
				local var_1_9 = var_1_0(var_1_7, "\\n", "\n")

				arg_1_0[var_1_0(var_1_8, "\\\"", "\"")] = var_1_0(var_1_9, "\\\"", "\"")
				var_1_4 = var_1_4 + 1
			end
		end

		if DEBUG > 1 then
			echoInfo("Load localized file with %d lines", var_1_4)
		end
	end
end

function Localized.getLocalizedValue(arg_4_0, arg_4_1)
	if arg_4_0[arg_4_1] == nil then
		return arg_4_1
	else
		return arg_4_0[arg_4_1]
	end
end

function string.lf(arg_5_0, ...)
	local var_5_0 = Localized:getLocalizedValue(arg_5_0)
	local var_5_1 = {
		...
	}

	if table.nums(var_5_1) == 0 then
		return (string.gsub(var_5_0, "%%%%", function(arg_6_0)
			return "%"
		end))
	else
		return string.format(var_5_0, ...)
	end
end
