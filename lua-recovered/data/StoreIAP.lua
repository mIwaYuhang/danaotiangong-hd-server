require("network.RechargeRequest")

StoreIAP = {
	iapLoaded = {}
}

function StoreIAP.init(arg_1_0)
	if not arg_1_0.provider then
		arg_1_0.provider = require("framework.api.Store")

		arg_1_0.provider.init(handler(arg_1_0, arg_1_0.transactionCallback))

		arg_1_0.iapRequest = IAPRequest:new()

		arg_1_0.iapRequest:setResponseNormalHandler(function()
			LocalData:removeIAPData(arg_1_0.iapRequest:getIAPProductId())
			ui.showMessageBox({
				text = string.lf("上仙！恭喜您充值成功, 元宝将在几分钟内到账！")
			})
		end)
		arg_1_0.iapRequest:setResponseExceptionHandler(function(arg_3_0)
			ui.showMessageBox({
				text = string.lf("服务器端验证充值失败, 错误号:%s", arg_3_0)
			})
		end)

		local var_1_0 = LocalData:getIAPList()

		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			StoreIAP:submitIAPToServer(iter_1_1)
		end
	end
end

function StoreIAP.canMakePurchases(arg_4_0)
	return arg_4_0.provider and arg_4_0.provider.canMakePurchases() or false
end

function StoreIAP.loadProducts(arg_5_0, arg_5_1)
	local var_5_0 = tostring(arg_5_1[1])

	if not arg_5_0.iapLoaded[var_5_0] or arg_5_0.iapLoaded[var_5_0] == false then
		Platform.showSystemHUD()
		arg_5_0.provider.loadProducts(arg_5_1, function(arg_6_0)
			if arg_6_0.products and table.nums(arg_6_0.products) > 0 then
				arg_5_0.iapLoaded[var_5_0] = true
			end

			Platform.hideSystemHUD()
		end)
	end
end

function StoreIAP.isProductsLoaded(arg_7_0, arg_7_1)
	return arg_7_0.iapLoaded[tostring(arg_7_1)]
end

function StoreIAP.purchaseProduct(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.orderId = arg_8_2

	arg_8_0.provider.purchase(arg_8_1)
	Platform.showSystemHUD()
end

function StoreIAP.transactionCallback(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.transaction

	Platform.hideSystemHUD()

	if var_9_0.state == "purchased" or var_9_0.state == "restored" then
		var_9_0.orderId = arg_9_0.orderId

		LocalData:addIAPData(var_9_0)
		StoreIAP:submitIAPToServer(var_9_0)
	elseif var_9_0.state == "failed" then
		ui.showMessageBox({
			text = string.lf("充值失败, 错误号为:%s, 描述:%s", var_9_0.errorCode, var_9_0.errorString)
		})
	end

	arg_9_0.provider.finishTransaction(var_9_0)
end

function StoreIAP.submitIAPToServer(arg_10_0, arg_10_1)
	arg_10_0.iapRequest:requestIAP(Player.serverInfo.ChargeServerUrl, arg_10_1.productIdentifier, arg_10_1.orderId, arg_10_1.receipt)
end
