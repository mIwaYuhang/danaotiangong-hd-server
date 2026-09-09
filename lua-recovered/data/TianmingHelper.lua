require("network.TianmingRequest")

TianmingHelper = {
	isRequesting = false
}

function TianmingHelper.getTianmingList(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._requestCallbackHandler = arg_1_1
	arg_1_0.tianmingInteam = arg_1_2

	if arg_1_0._allTianmings == nil then
		arg_1_0:requestTianmingData()
	else
		arg_1_0:returenTianmingList()
	end
end

function TianmingHelper.returenTianmingList(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._allTianmings) do
		if arg_2_0.tianmingInteam == nil or arg_2_0.tianmingInteam == iter_2_1.isInTeam then
			table.insert(var_2_0, iter_2_1)
		end
	end

	arg_2_0._requestCallbackHandler(var_2_0)
end

function TianmingHelper.createNetRequest(arg_3_0)
	if arg_3_0.tianmingListRequest == nil then
		local function var_3_0()
			arg_3_0.isRequesting = false
			arg_3_0._allTianmings = arg_3_0.tianmingListRequest:getTianmingList()

			for iter_4_0, iter_4_1 in ipairs(arg_3_0._allTianmings) do
				iter_4_1.isInTeam = Player:isTianmingInteam(iter_4_1.id)
			end

			arg_3_0:returenTianmingList()
		end

		local function var_3_1(arg_5_0)
			arg_3_0.isRequesting = false
		end

		arg_3_0.tianmingListRequest = TianmingListRequest:new()

		arg_3_0.tianmingListRequest:setResponseNormalHandler(var_3_0)
		arg_3_0.tianmingListRequest:setResponseExceptionHandler(var_3_1)
	end
end

function TianmingHelper.requestTianmingData(arg_6_0)
	arg_6_0:createNetRequest()

	if arg_6_0.isRequesting == true then
		return
	end

	arg_6_0.isRequesting = true

	arg_6_0.tianmingListRequest:request()
end

function TianmingHelper.change(arg_7_0, arg_7_1)
	local var_7_0

	if arg_7_0._allTianmings == nil then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._allTianmings) do
		if iter_7_1.id == arg_7_1.id then
			var_7_0 = iter_7_0

			break
		end
	end

	arg_7_1.isInTeam = Player:isTianmingInteam(arg_7_1.id)

	if var_7_0 ~= nil then
		arg_7_0._allTianmings[var_7_0] = arg_7_1
	else
		table.insert(arg_7_0._allTianmings, arg_7_1)
	end
end

function TianmingHelper.delete(arg_8_0, arg_8_1)
	local var_8_0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._allTianmings) do
		if iter_8_1.id == arg_8_1 then
			var_8_0 = iter_8_0

			break
		end
	end

	if var_8_0 ~= nil then
		table.remove(arg_8_0._allTianmings, var_8_0)
	end
end

function TianmingHelper.markInTeam(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0._allTianmings == nil then
		return
	end

	local var_9_0

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._allTianmings) do
		if iter_9_1.id == arg_9_1 then
			var_9_0 = iter_9_0

			break
		end
	end

	if var_9_0 ~= nil then
		arg_9_0._allTianmings[var_9_0].isInTeam = arg_9_2

		return
	end
end

function TianmingHelper.getAllHeroTianmings(arg_10_0, arg_10_1)
	local var_10_0 = {}

	for iter_10_0 = 1, table.getn(arg_10_1) do
		if arg_10_1[iter_10_0].destinyList then
			for iter_10_1, iter_10_2 in ipairs(arg_10_1[iter_10_0].destinyList) do
				if iter_10_2.destiny then
					table.insert(var_10_0, iter_10_2.destiny)
				end
			end
		end
	end

	return var_10_0
end

function TianmingHelper.compareTianmingListChange(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in ipairs(arg_11_2) do
		local var_11_0 = false

		for iter_11_2, iter_11_3 in ipairs(arg_11_1) do
			if iter_11_1.destinyID == iter_11_3.destinyID and iter_11_1.id == iter_11_3.id then
				var_11_0 = true
			end
		end

		if var_11_0 == false then
			arg_11_0:markInTeam(iter_11_1.id, 1)
		end
	end

	for iter_11_4, iter_11_5 in ipairs(arg_11_1) do
		local var_11_1 = false

		for iter_11_6, iter_11_7 in ipairs(arg_11_2) do
			if iter_11_7.destinyID == iter_11_5.destinyID and iter_11_7.id == iter_11_5.id then
				var_11_1 = true
			end
		end

		if var_11_1 == false then
			arg_11_0:markInTeam(iter_11_5.id, 0)
		end
	end
end

function TianmingHelper.isSameTypeTianming(arg_12_0, arg_12_1, arg_12_2)
	return BaseTianMings[arg_12_1.destinyID].type == BaseTianMings[arg_12_2.destinyID].type
end

function TianmingHelper.getSameTypeTianmingSlot(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = 0

	if arg_13_1 == nil then
		return var_13_0
	end

	local var_13_1 = Player.team.groupList[arg_13_2]

	for iter_13_0, iter_13_1 in ipairs(var_13_1.destinyList) do
		if iter_13_1.destiny ~= nil and TianmingHelper:isSameTypeTianming(iter_13_1.destiny, arg_13_1) then
			var_13_0 = iter_13_0

			break
		end
	end

	return var_13_0
end

function TianmingHelper.getEmptyTianmingSlot(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = 0
	local var_14_1 = Player.team.groupList[arg_14_2]
	local var_14_2 = arg_14_0:getSameTypeTianmingSlot(arg_14_1, arg_14_2)

	if var_14_2 ~= 0 then
		return var_14_2
	end

	for iter_14_0, iter_14_1 in ipairs(var_14_1.destinyList) do
		if iter_14_1.destiny == nil and iter_14_1.state == TianmingSlotStatus.eSlotAvilable then
			var_14_0 = iter_14_0

			break
		end
	end

	return var_14_0
end

function TianmingHelper.clearData(arg_15_0)
	arg_15_0._allTianmings = nil
end
