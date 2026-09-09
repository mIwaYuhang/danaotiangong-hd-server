require("network.MineralRequest")

MineralHelper = {
	isRequesting = false
}

function MineralHelper.getMineralList(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._requestCallbackHandler = arg_1_1
	arg_1_0.mineralInteam = arg_1_2

	if arg_1_0._allMinerals == nil then
		arg_1_0:requestMineralData()
	else
		arg_1_0:returenMineralList()
	end
end

function MineralHelper.addItem(arg_2_0, arg_2_1)
	if arg_2_1 == nil then
		return
	end

	for iter_2_0, iter_2_1 in pairs(arg_2_1) do
		arg_2_0:addOneItem(iter_2_1)
	end
end

function MineralHelper.delItem(arg_3_0, arg_3_1)
	if arg_3_1 == nil then
		return
	end

	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		if iter_3_1.id == nil and iter_3_1.ID ~= nil then
			iter_3_1.id = iter_3_1.ID
		end

		arg_3_0:deleteOneItem(iter_3_1)
	end
end

function MineralHelper.setItem(arg_4_0, arg_4_1)
	if arg_4_1 == nil or arg_4_1.id == nil then
		return
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0._allMinerals) do
		if iter_4_1.id == arg_4_1.id then
			arg_4_0._allMinerals[iter_4_0] = arg_4_1

			break
		end
	end
end

function MineralHelper.isEmpty(arg_5_0)
	if arg_5_0._allMinerals == nil or table.maxn(arg_5_0._allMinerals) == 0 then
		return true
	end

	return false
end

function MineralHelper.clearData(arg_6_0)
	arg_6_0._allMinerals = nil
end

function MineralHelper.readGemAddValue(arg_7_0, arg_7_1)
	if arg_7_1 == nil then
		return ""
	end

	if arg_7_1.gemProtoID == nil then
		return ""
	end

	local var_7_0 = ""

	local function var_7_1(arg_8_0, arg_8_1)
		if arg_8_1 == nil or arg_8_1 == 0 then
			return
		end

		if #var_7_0 == 0 then
			var_7_0 = arg_8_0 .. ":+" .. arg_8_1
		else
			var_7_0 = var_7_0 .. ", " .. arg_8_0 .. ":+" .. arg_8_1
		end
	end

	var_7_1(string.lf("暴击"), arg_7_1.baoji)
	var_7_1(string.lf("格挡"), arg_7_1.gedang)
	var_7_1(string.lf("血量"), arg_7_1.health)
	var_7_1(string.lf("命中"), arg_7_1.mingzhong)
	var_7_1(string.lf("普攻"), arg_7_1.normalAttack)
	var_7_1(string.lf("普防"), arg_7_1.normalDefense)
	var_7_1(string.lf("破击"), arg_7_1.poji)
	var_7_1(string.lf("韧性"), arg_7_1.renxing)
	var_7_1(string.lf("闪避"), arg_7_1.shanbi)
	var_7_1(string.lf("法攻"), arg_7_1.skillAttack)
	var_7_1(string.lf("法防"), arg_7_1.skillDefense)
	var_7_1(string.lf("速度"), arg_7_1.speed)

	return var_7_0
end

function MineralHelper.getCanInlayEquip(arg_9_0, arg_9_1)
	if arg_9_1 == nil or arg_9_1 == 0 then
		return nil
	end

	return EquipTypeNames[BaseMineral[arg_9_1].equipType]
end

function MineralHelper.getCanInlayType(arg_10_0, arg_10_1)
	if arg_10_1 == nil or arg_10_1 == 0 then
		return nil
	end

	local var_10_0

	for iter_10_0, iter_10_1 in ipairs(BaseMineral) do
		if iter_10_1.equipType == arg_10_1 then
			var_10_0 = iter_10_1.name

			break
		end
	end

	return var_10_0
end

function MineralHelper.returenMineralList(arg_11_0)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._allMinerals) do
		if arg_11_0.mineralInteam == nil or iter_11_1.isBattle == nil then
			table.insert(var_11_0, iter_11_1)
		elseif arg_11_0.mineralInteam == iter_11_1.isBattle then
			table.insert(var_11_0, iter_11_1)
		end
	end

	arg_11_0._requestCallbackHandler(var_11_0)
end

function MineralHelper.requestMineralData(arg_12_0)
	arg_12_0:createNetRequest()

	if arg_12_0.isRequesting == true then
		return
	end

	arg_12_0.isRequesting = true

	arg_12_0.mineralListRequest:request()
end

function MineralHelper.createNetRequest(arg_13_0)
	if arg_13_0.mineralListRequest == nil then
		local function var_13_0()
			arg_13_0.isRequesting = false
			arg_13_0._allMinerals = arg_13_0.mineralListRequest.restable

			arg_13_0:returenMineralList()
		end

		local function var_13_1(arg_15_0)
			arg_13_0.isRequesting = false
		end

		arg_13_0.mineralListRequest = MineralListInfoRequest:new()

		arg_13_0.mineralListRequest:setResponseNormalHandler(var_13_0)
		arg_13_0.mineralListRequest:setResponseExceptionHandler(var_13_1)
	end
end

function MineralHelper.addOneItem(arg_16_0, arg_16_1)
	if arg_16_1 == nil or arg_16_1.id == nil then
		return
	end

	local var_16_0 = false

	if arg_16_0._allMinerals then
		for iter_16_0, iter_16_1 in ipairs(arg_16_0._allMinerals) do
			if iter_16_1.id == arg_16_1.id then
				var_16_0 = true
				iter_16_1 = arg_16_1

				break
			end
		end

		if var_16_0 == false then
			table.insert(arg_16_0._allMinerals, arg_16_1)
		end
	end
end

function MineralHelper.deleteOneItem(arg_17_0, arg_17_1)
	if arg_17_1 == nil or arg_17_1.id == nil then
		return
	end

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._allMinerals) do
		if iter_17_1.id == arg_17_1.id then
			table.remove(arg_17_0._allMinerals, iter_17_0)

			break
		end
	end
end
