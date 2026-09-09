MineralListInfoRequest = NetworkRequest:new()
MineralListInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function MineralListInfoRequest.request(arg_1_0)
	local var_1_0 = string.format(ServerUrl.MineralListInfo, Player.userId)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function MineralListInfoRequest.parseJsonValue(arg_2_0, arg_2_1)
	arg_2_0.restable = arg_2_1
end

MineralPutAllRequest = NetworkRequest:new()

function MineralPutAllRequest.request(arg_3_0)
	local var_3_0 = string.format(ServerUrl.MineralPutAll, Player.userId)

	arg_3_0:startHttpRequest(var_3_0, false, nil, true)
end

function MineralPutAllRequest.parseJsonValue(arg_4_0, arg_4_1)
	arg_4_0.restable = arg_4_1
end

MineralRefineAllRequest = NetworkRequest:new()

function MineralRefineAllRequest.request(arg_5_0)
	local var_5_0 = string.format(ServerUrl.MineralRefineAll, Player.userId)

	arg_5_0:startHttpRequest(var_5_0, false, nil, true)
end

function MineralRefineAllRequest.parseJsonValue(arg_6_0, arg_6_1)
	arg_6_0.restable = arg_6_1
end

MineralRefineRequest = NetworkRequest:new()

function MineralRefineRequest.request(arg_7_0, arg_7_1)
	local var_7_0 = string.format(ServerUrl.MineralRefine, Player.userId, arg_7_1)

	arg_7_0:startHttpRequest(var_7_0, false, nil, true)
end

function MineralRefineRequest.parseJsonValue(arg_8_0, arg_8_1)
	arg_8_0.restable = arg_8_1
end

MineralBuyRequest = NetworkRequest:new()

function MineralBuyRequest.request(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = string.format(ServerUrl.MineralBuy, Player.userId, arg_9_1, arg_9_2, arg_9_3)

	arg_9_0:startHttpRequest(var_9_0, false, nil, true)
end

function MineralBuyRequest.parseJsonValue(arg_10_0, arg_10_1)
	arg_10_0.restable = arg_10_1
end

MineralSellRequest = NetworkRequest:new()

function MineralSellRequest.request(arg_11_0, arg_11_1)
	local var_11_0 = string.format(ServerUrl.MineralSell, Player.userId, arg_11_1)

	arg_11_0:startHttpRequest(var_11_0, false, nil, true)
end

function MineralSellRequest.parseJsonValue(arg_12_0, arg_12_1)
	arg_12_0.restable = arg_12_1
end

MineralInlayRequest = NetworkRequest:new()

function MineralInlayRequest.request(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = string.format(ServerUrl.MineralInlay, Player.userId, arg_13_1, arg_13_2)

	arg_13_0:startHttpRequest(var_13_0, false, nil, true)
end

function MineralInlayRequest.parseJsonValue(arg_14_0, arg_14_1)
	arg_14_0.restable = arg_14_1
end

MineralUnloadRequest = NetworkRequest:new()

function MineralUnloadRequest.request(arg_15_0, arg_15_1)
	local var_15_0 = string.format(ServerUrl.MineralUnload, Player.userId, arg_15_1)

	arg_15_0:startHttpRequest(var_15_0, false, nil, true)
end

function MineralUnloadRequest.parseJsonValue(arg_16_0, arg_16_1)
	arg_16_0.restable = arg_16_1
end

MineralHoleInfoRequest = NetworkRequest:new()
MineralHoleInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function MineralHoleInfoRequest.request(arg_17_0)
	local var_17_0 = string.format(ServerUrl.MineralHoleInfo, Player.userId)

	arg_17_0:startHttpRequest(var_17_0, false, nil, true)
end

function MineralHoleInfoRequest.parseJsonValue(arg_18_0, arg_18_1)
	arg_18_0.restable = arg_18_1
end

GemBuyGoldHoeRequest = NetworkRequest:new()

function GemBuyGoldHoeRequest.request(arg_19_0)
	local var_19_0 = string.format(ServerUrl.GemBuyGoldHoe, Player.userId)

	arg_19_0:startHttpRequest(var_19_0, false, nil, true)
end

function GemBuyGoldHoeRequest.parseJsonValue(arg_20_0, arg_20_1)
	arg_20_0.restable = arg_20_1
end

GemPreviewRequest = NetworkRequest:new()
GemPreviewRequest.timeoutOperate = TimeoutOperation.eRetry

function GemPreviewRequest.request(arg_21_0)
	local var_21_0 = string.format(ServerUrl.GemPreview, Player.userId)

	arg_21_0:startHttpRequest(var_21_0, false, nil, true)
end

function GemPreviewRequest.parseJsonValue(arg_22_0, arg_22_1)
	arg_22_0.restable = arg_22_1
end

GemMineGetRequest = NetworkRequest:new()

function GemMineGetRequest.request(arg_23_0)
	local var_23_0 = string.format(ServerUrl.GemMineGet, Player.userId)

	arg_23_0:startHttpRequest(var_23_0, false, nil, true)
end

function GemMineGetRequest.parseJsonValue(arg_24_0, arg_24_1)
	arg_24_0.restable = arg_24_1
end
