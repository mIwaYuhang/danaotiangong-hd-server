require("network.XunfangRequest")

MasterHelper = {
	isRequesting = false,
	_requestType = MasterType.eAll
}
addTargetList = {
	[0] = string.lf("前排"),
	string.lf("后排"),
	(string.lf("全体"))
}

function MasterHelper.getAllMasterList(arg_1_0, arg_1_1)
	if arg_1_1 == MasterType.eAll or arg_1_1 == nil then
		return BaseMasters
	else
		local var_1_0 = {}

		for iter_1_0, iter_1_1 in pairs(BaseMasters) do
			if iter_1_1.type == arg_1_1 then
				var_1_0[iter_1_0] = iter_1_1
			end
		end

		return var_1_0
	end
end

function MasterHelper.getActiveMasterList(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._requestCallbackHandler = arg_2_2
	arg_2_0._requestType = arg_2_1

	if arg_2_0._allActiveMasters == nil then
		arg_2_0:_requestActiveMasterData()
	else
		arg_2_0:_returenActiveMasterList()
	end
end

function MasterHelper.getMasterCount(arg_3_0, arg_3_1)
	if arg_3_0._allActiveMasters == nil then
		return nil
	end

	local var_3_0

	for iter_3_0, iter_3_1 in pairs(arg_3_0._allActiveMasters) do
		if iter_3_1.MasterID == arg_3_1 then
			var_3_0 = iter_3_1.Count

			break
		end
	end

	return var_3_0
end

function MasterHelper.getActiveMasterOfType(arg_4_0, arg_4_1)
	if arg_4_0._allActiveMasters == nil then
		return 0
	end

	local var_4_0 = 0

	for iter_4_0, iter_4_1 in pairs(arg_4_0._allActiveMasters) do
		local var_4_1 = BaseMasters[iter_4_1.MasterID]

		if var_4_1 ~= nil and var_4_1.type == arg_4_1 then
			var_4_0 = var_4_0 + 1
		end
	end

	return var_4_0
end

function MasterHelper.addActiveMaster(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._allActiveMasters == nil then
		return
	end

	local var_5_0 = false

	for iter_5_0, iter_5_1 in pairs(arg_5_0._allActiveMasters) do
		if iter_5_1.MasterID == arg_5_1 then
			iter_5_1.Count = iter_5_1.Count + arg_5_2
			var_5_0 = true

			break
		end
	end

	if var_5_0 == false then
		local var_5_1 = {
			MasterID = arg_5_1,
			Count = arg_5_2 - 1
		}

		table.insert(arg_5_0._allActiveMasters, var_5_1)
	end
end

function MasterHelper.deleteActiveMaster(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._allActiveMasters == nil then
		return
	end

	for iter_6_0, iter_6_1 in pairs(arg_6_0._allActiveMasters) do
		if iter_6_1.MasterID == arg_6_1 and arg_6_2 ~= nil then
			iter_6_1.Count = iter_6_1.Count - arg_6_2

			if iter_6_1.Count < 0 then
				iter_6_1.Count = 0
			end

			break
		end
	end
end

function MasterHelper.clearData(arg_7_0)
	arg_7_0._allActiveMasters = nil
end

function MasterHelper.getBackImageByQuality(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {
		[QualityType.eNone] = {
			NormalImage = "ui/xunfang/xunfang_012.png",
			ActivityImage = "ui/xunfang/xunfang_011.png"
		},
		[QualityType.eGreen] = {
			NormalImage = "ui/xunfang/xunfang_014.png",
			ActivityImage = "ui/xunfang/xunfang_013.png"
		},
		[QualityType.eBlue] = {
			NormalImage = "ui/xunfang/xunfang_017.png",
			ActivityImage = "ui/xunfang/xunfang_016.png"
		},
		[QualityType.ePurple] = {
			NormalImage = "ui/xunfang/xunfang_019.png",
			ActivityImage = "ui/xunfang/xunfang_018.png"
		},
		[QualityType.eOrange] = {
			NormalImage = "ui/xunfang/xunfang_021.png",
			ActivityImage = "ui/xunfang/xunfang_020.png"
		}
	}

	if arg_8_2 then
		return var_8_0[arg_8_1].ActivityImage
	else
		return var_8_0[arg_8_1].NormalImage
	end
end

function MasterHelper.getMasterGroupByID(arg_9_0, arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(MasterGroup) do
		for iter_9_2, iter_9_3 in ipairs(iter_9_1.groupCost) do
			if iter_9_3.masterID == arg_9_1 then
				local var_9_1 = {
					groupId = iter_9_0
				}

				table.insert(var_9_0, var_9_1)

				break
			end
		end
	end

	for iter_9_4, iter_9_5 in pairs(var_9_0) do
		for iter_9_6, iter_9_7 in pairs(MasterGroup[iter_9_5.groupId]) do
			iter_9_5[iter_9_6] = iter_9_7
		end
	end

	return var_9_0
end

function MasterHelper._returenActiveMasterList(arg_10_0)
	if arg_10_0._requestType == MasterType.eAll or arg_10_0._requestType == nil then
		arg_10_0._requestCallbackHandler(arg_10_0._allActiveMasters)
	else
		local var_10_0 = {}

		for iter_10_0, iter_10_1 in arg_10_0._allActiveMasters do
			if iter_10_1.type == arg_10_0._requestType then
				var_10_0[iter_10_0] = iter_10_1
			end
		end

		arg_10_0._requestCallbackHandler(var_10_0)
	end
end

function MasterHelper._createNetRequest(arg_11_0)
	if arg_11_0.getHandBookRequest == nil then
		local function var_11_0()
			arg_11_0.isRequesting = false
			arg_11_0._allActiveMasters = arg_11_0.getHandBookRequest.restable

			arg_11_0:_returenActiveMasterList()
		end

		local function var_11_1(arg_13_0)
			arg_11_0.isRequesting = false
		end

		arg_11_0.getHandBookRequest = GetHandBookRequest:new()

		arg_11_0.getHandBookRequest:setResponseNormalHandler(var_11_0)
		arg_11_0.getHandBookRequest:setResponseExceptionHandler(var_11_1)
	end
end

function MasterHelper._requestActiveMasterData(arg_14_0)
	arg_14_0:_createNetRequest()

	if arg_14_0.isRequesting == true then
		return
	end

	arg_14_0.isRequesting = true

	arg_14_0.getHandBookRequest:request()
end
