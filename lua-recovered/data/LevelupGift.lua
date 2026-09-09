local var_0_0 = require("base.cache")

require("network.ActivityRequest")

local var_0_1 = require("scenes.toollayer.class"):extend({
	mIsRequesting = false,
	getGiftList = function(arg_1_0, arg_1_1, arg_1_2)
		arg_1_0.mCallBackHandler = arg_1_1

		if arg_1_2 then
			var_0_0.set(arg_1_0.mName, nil)
		end

		if var_0_0.get(arg_1_0.mName) == nil then
			arg_1_0:requestGiftTable()
		else
			arg_1_0:do_getGiftList()
		end
	end,
	do_getGiftList = function(arg_2_0)
		arg_2_0.mCallBackHandler(var_0_0.get(arg_2_0.mName))
	end,
	initNetRequest = function(arg_3_0)
		if arg_3_0.mNetRequest == nil then
			local function var_3_0()
				arg_3_0.mIsRequesting = false

				local var_4_0 = arg_3_0.mNetRequest:getGiftTable()

				var_0_0.set(arg_3_0.mName, var_4_0)
				arg_3_0:do_getGiftList()
			end

			local function var_3_1()
				arg_3_0.isRequesting = false
			end

			arg_3_0.mNetRequest = arg_3_0.mNetWork:new()

			arg_3_0.mNetRequest:setResponseNormalHandler(var_3_0)
			arg_3_0.mNetRequest:setResponseExceptionHandler(var_3_1)
		end
	end,
	requestGiftTable = function(arg_6_0)
		arg_6_0:initNetRequest()

		if arg_6_0.isRequesting == true then
			return
		end

		arg_6_0.mIsRequesting = true

		arg_6_0.mNetRequest:request()
	end,
	new = function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_7_0:extend()

		var_7_0.mNetWork = arg_7_1
		var_7_0.mName = arg_7_2

		return var_7_0
	end
})

LevelupGiftData = {
	mLevelupGiftCache = var_0_1:new(ActivityLevelupGiftRequest, "levelupGiftCache"),
	mGrowUpRewardCache = var_0_1:new(ActivityGrowUpRewardInfoRequest, "growupRewardCache")
}

function LevelupGiftData.getLevelupGift(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.mLevelupGiftCache:getGiftList(arg_8_1, arg_8_2)
end

function LevelupGiftData.removeLevelupGiftBag(arg_9_0, arg_9_1)
	local var_9_0 = var_0_0.get(arg_9_0.mLevelupGiftCache.mName)

	table.foreach(var_9_0, function(arg_10_0, arg_10_1)
		if arg_10_1.Level == arg_9_1 then
			table.remove(var_9_0, arg_10_0)
			var_0_0.set(arg_9_0.mLevelupGiftCache.mName, var_9_0)

			return
		end
	end)
end

function LevelupGiftData.getGrowUpPlanRewardInfo(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.mGrowUpRewardCache:getGiftList(arg_11_1, arg_11_2)
end

function LevelupGiftData.removeGrowUpRewardBag(arg_12_0, arg_12_1)
	local var_12_0 = var_0_0.get(arg_12_0.mGrowUpRewardCache.mName)

	table.foreach(var_12_0.Growup, function(arg_13_0, arg_13_1)
		if arg_13_1.Level == arg_12_1 then
			table.remove(var_12_0.Growup, arg_13_0)
			var_0_0.set(arg_12_0.mGrowUpRewardCache.mName, var_12_0)

			return
		end
	end)
end
