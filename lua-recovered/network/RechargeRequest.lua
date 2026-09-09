OrderIdRequest = NetworkRequest:new()
OrderIdRequest.timeoutOperate = TimeoutOperation.eRetry

function OrderIdRequest.requestServerList(arg_1_0, arg_1_1)
	arg_1_0.productData = arg_1_1

	local var_1_0 = string.format(ServerUrl.GetOrderId, Player.userId, tostring(arg_1_0.productData.Money))

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function OrderIdRequest.parseJsonValue(arg_2_0, arg_2_1)
	arg_2_0.serverData = arg_2_1
end

function OrderIdRequest.getOrderIdAndProductData(arg_3_0)
	return arg_3_0.serverData, arg_3_0.productData
end

OrderPointIdRequest = NetworkRequest:new()
OrderPointIdRequest.timeoutOperate = TimeoutOperation.eRetry

function OrderPointIdRequest.requestOrderId(arg_4_0, arg_4_1)
	arg_4_0.productData = arg_4_1

	local var_4_0 = string.format(ServerUrl.GetPointOrderId, Player.userId, tostring(arg_4_0.productData.Money))

	arg_4_0:startHttpRequest(var_4_0, false, nil, true)
end

function OrderPointIdRequest.parseJsonValue(arg_5_0, arg_5_1)
	arg_5_0.serverData = arg_5_1
end

function OrderPointIdRequest.getOrderIdAndProductData(arg_6_0)
	return arg_6_0.serverData, arg_6_0.productData
end

IAPRequest = NetworkRequest:new()
IAPRequest.timeoutOperate = TimeoutOperation.eRetry
IAPRequest.thirdResponseDataInflate = false

function IAPRequest.requestIAP(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0.productId = arg_7_2

	local var_7_0 = {
		ProductID = arg_7_2,
		OrderID = arg_7_3,
		ReceiptData = crypto.encodeBase64(arg_7_4)
	}

	arg_7_0:startThirdHttpRequest(arg_7_1, true, var_7_0)
end

function IAPRequest.parseJsonValue(arg_8_0, arg_8_1)
	arg_8_0.serverData = arg_8_1
end

function IAPRequest.getIAPProductId(arg_9_0)
	return arg_9_0.productId
end
