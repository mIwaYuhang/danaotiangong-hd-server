require("network.TeamRequest")

EquipClassType = {
	eEquipPeishi = 3,
	eEquipShenqi = 1,
	eEquipAll = 4,
	eEquipYiguan = 2
}
EquipClassTypeName = {
	string.lf("神器"),
	string.lf("衣冠"),
	string.lf("配饰"),
	(string.lf("全部"))
}

local var_0_0 = {
	[EquipClassType.eEquipShenqi] = {
		EquipType.eWeapon,
		EquipType.eAmulet
	},
	[EquipClassType.eEquipYiguan] = {
		EquipType.eHelmet,
		EquipType.eClothes
	},
	[EquipClassType.eEquipPeishi] = {
		EquipType.eNecklace,
		EquipType.eRing
	},
	[EquipClassType.eEquipAll] = {
		EquipType.eWeapon,
		EquipType.eAmulet,
		EquipType.eHelmet,
		EquipType.eClothes,
		EquipType.eNecklace,
		EquipType.eRing
	}
}

EquipHelper = {
	_originAllCount = 0,
	isRequesting = false,
	_EquipsLockInfo = {}
}

function EquipHelper.getEquipList(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._equipClassType = arg_1_1
	arg_1_0._requestCallbackHandler = arg_1_2
	arg_1_0.equipInteam = arg_1_3

	if arg_1_0._allEquips == nil then
		arg_1_0:requestEquipData()
	else
		arg_1_0:returenNeededEquipList(arg_1_1)
	end
end

function EquipHelper.returenNeededEquipList(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._allEquips) do
		if (arg_2_0:getEquipSubClassID(BaseEquips[iter_2_1.equipId].equipType) == arg_2_1 or arg_2_1 == EquipClassType.eEquipAll) and (arg_2_0.equipInteam == nil or arg_2_0.equipInteam == iter_2_1.isInTeam) then
			table.insert(var_2_0, iter_2_1)
		end
	end

	arg_2_0._requestCallbackHandler(var_2_0)
end

function EquipHelper.createNetRequest(arg_3_0)
	if arg_3_0.equpListRequest == nil then
		local function var_3_0()
			arg_3_0.isRequesting = false

			local var_4_0 = arg_3_0.equpListRequest:getEquipList()

			arg_3_0._allEquips = arg_3_0._allEquips or {}

			for iter_4_0, iter_4_1 in ipairs(var_4_0) do
				table.insert(arg_3_0._allEquips, iter_4_1)
			end

			arg_3_0:returenNeededEquipList(arg_3_0._equipClassType)
		end

		local function var_3_1(arg_5_0)
			arg_3_0.isRequesting = false
		end

		arg_3_0.equpListRequest = EqupListRequest:new()

		arg_3_0.equpListRequest:setResponseNormalHandler(var_3_0)
		arg_3_0.equpListRequest:setResponseExceptionHandler(var_3_1)
	end
end

function EquipHelper.requestEquipData(arg_6_0)
	arg_6_0:createNetRequest()

	if arg_6_0.isRequesting == true then
		return
	end

	arg_6_0.isRequesting = true

	arg_6_0.equpListRequest:request()
end

function EquipHelper.getEquipSubClassID(arg_7_0, arg_7_1)
	local var_7_0

	for iter_7_0, iter_7_1 in ipairs(var_0_0) do
		if arg_7_1 == iter_7_1[1] or arg_7_1 == iter_7_1[2] then
			var_7_0 = iter_7_0

			break
		end
	end

	return var_7_0
end

function EquipHelper.changeOneEquip(arg_8_0, arg_8_1)
	local var_8_0

	if arg_8_0._allEquips == nil then
		return
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._allEquips) do
		if iter_8_1.equipUserId == arg_8_1.equipUserId then
			var_8_0 = iter_8_0

			break
		end
	end

	if var_8_0 ~= nil then
		arg_8_0._allEquips[var_8_0] = arg_8_1
	else
		table.insert(arg_8_0._allEquips, arg_8_1)
	end
end

function EquipHelper.deleteOneEquip(arg_9_0, arg_9_1)
	local var_9_0

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._allEquips) do
		if iter_9_1.equipUserId == arg_9_1 then
			var_9_0 = iter_9_0

			break
		end
	end

	if var_9_0 ~= nil then
		table.remove(arg_9_0._allEquips, var_9_0)
	end
end

function EquipHelper.markEquipInTeamStatus(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0._allEquips == nil then
		return
	end

	local var_10_0

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._allEquips) do
		if iter_10_1.equipUserId == arg_10_1 then
			var_10_0 = iter_10_0

			break
		end
	end

	if var_10_0 ~= nil then
		arg_10_0._allEquips[var_10_0].isInTeam = arg_10_2

		return
	end
end

function EquipHelper.compareEquipListBeforeEquipChange(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in ipairs(arg_11_2) do
		local var_11_0 = false

		for iter_11_2, iter_11_3 in ipairs(arg_11_1) do
			if iter_11_1.equipId == iter_11_3.equipId and iter_11_1.equipUserId == iter_11_3.equipUserId then
				var_11_0 = true
			end
		end

		if var_11_0 == false then
			arg_11_0:markEquipInTeamStatus(iter_11_1.equipUserId, 1)
		end
	end

	for iter_11_4, iter_11_5 in ipairs(arg_11_1) do
		local var_11_1 = false

		for iter_11_6, iter_11_7 in ipairs(arg_11_2) do
			if iter_11_7.equipId == iter_11_5.equipId and iter_11_7.equipUserId == iter_11_5.equipUserId then
				var_11_1 = true
			end
		end

		if var_11_1 == false then
			arg_11_0:markEquipInTeamStatus(iter_11_5.equipUserId, 0)
		end
	end
end

function EquipHelper.clearData(arg_12_0)
	arg_12_0._originAllCount = 0
	arg_12_0._allEquips = nil
end

function EquipHelper.setOriginAllCount(arg_13_0, arg_13_1)
	arg_13_0._originAllCount = arg_13_1
end

function EquipHelper.getAllEquipCount(arg_14_0)
	return arg_14_0._allEquips and table.nums(arg_14_0._allEquips) or arg_14_0._originAllCount
end

function EquipHelper.getEquipCount(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = 0

	if arg_15_1 == 0 then
		return var_15_0
	end

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._allEquips) do
		if iter_15_1.equipId == arg_15_1 and iter_15_1.isInTeam == 0 then
			var_15_0 = var_15_0 + 1

			if arg_15_3 ~= nil and iter_15_1.equipUserId == arg_15_3 then
				var_15_0 = var_15_0 - 1
			elseif arg_15_2 ~= nil and arg_15_2 == true and (iter_15_1.level > 1 or iter_15_1.BreakthroughCount > 0) then
				var_15_0 = var_15_0 - 1
			end
		end
	end

	return var_15_0
end

function EquipHelper.getSameNameEquip(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = {}

	if arg_16_1 == 0 then
		return var_16_0
	end

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._allEquips) do
		local var_16_1 = 0
		local var_16_2 = true
		local var_16_3 = true

		if arg_16_3 then
			var_16_2 = arg_16_3 == iter_16_1.level
		end

		if arg_16_4 then
			var_16_3 = arg_16_4 == iter_16_1.BreakthroughCount
		end

		if iter_16_1.equipId == arg_16_1 and iter_16_1.isInTeam == 0 and var_16_2 and var_16_3 then
			var_16_1 = 1

			if arg_16_2 ~= nil and iter_16_1.equipUserId == arg_16_2 then
				var_16_1 = 0
			end
		end

		if var_16_1 == 1 then
			local var_16_4 = {
				ID = iter_16_1.equipId,
				Type = ItemType.eEquip
			}

			var_16_4.Count = 1
			var_16_4.detail = iter_16_1

			table.insert(var_16_0, var_16_4)
		end
	end

	return var_16_0
end

function EquipHelper.getAllHeroEquips(arg_17_0, arg_17_1)
	local var_17_0 = {}

	for iter_17_0 = 1, table.getn(arg_17_1) do
		if arg_17_1[iter_17_0].equipList then
			for iter_17_1, iter_17_2 in ipairs(arg_17_1[iter_17_0].equipList) do
				table.insert(var_17_0, iter_17_2)
			end
		end
	end

	return var_17_0
end

function EquipHelper.setInheritLockInfo(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._EquipsLockInfo[arg_18_1] = arg_18_2
end

function EquipHelper.getInheritLockInfo(arg_19_0, arg_19_1)
	return arg_19_0._EquipsLockInfo[arg_19_1]
end

function EquipHelper.equipCanFeed(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	local var_20_0 = BaseEquips[arg_20_1].jieJiAttrs[arg_20_4 + 1]

	if var_20_0 == nil then
		return false
	end

	if arg_20_3 < var_20_0.level then
		return false
	end

	if var_20_0.mateId ~= nil and var_20_0.mateCount ~= nil and Player:getItemCount(ItemType.eMate, var_20_0.mateId) < var_20_0.mateCount then
		return false
	end

	if var_20_0.equipId ~= nil and var_20_0.equipCount ~= nil and EquipHelper:getEquipCount(var_20_0.equipId, true, arg_20_2) < var_20_0.equipCount then
		return false
	end

	return true
end
