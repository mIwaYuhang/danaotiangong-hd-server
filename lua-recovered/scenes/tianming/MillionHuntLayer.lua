local var_0_0 = class("MillionHuntLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	local var_2_0 = CCSize(600, 450)
	local var_2_1 = display.newScale9Sprite("ui/common/common_116.png")

	var_2_1:setPreferredSize(var_2_0)
	var_2_1:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_1:setPosition(display.cx, display.cy)
	var_2_1:setScale(Adapter.MinScale)
	arg_2_0:addChild(var_2_1, 100)

	if arg_2_1 == nil or arg_2_1.rewardList == nil then
		return
	end

	arg_2_0.rewardList = arg_2_1.rewardList
	arg_2_0.closeCallback = arg_2_1.closeCallback

	if arg_2_0.rewardList.isGet ~= nil and arg_2_0.rewardList.isGet == 0 then
		addLabelWithColorSize(var_2_1, string.lf("上仙，您上次获得的命格还未领取呢"), ccc3(200, 0, 0), 25, CCPoint(0.5, 1), CCPoint(var_2_0.width / 2, var_2_0.height - 20))
	else
		addLabelWithColorSize(var_2_1, string.lf("上仙，请收取您获得的命格吧"), ccc3(0, 200, 0), 25, CCPoint(0.5, 1), CCPoint(var_2_0.width / 2, var_2_0.height - 20))
	end

	local var_2_2 = CCPoint(0, 1)

	if IPlatform:instance():getConfig("Channel") == "ZSY_VN" then
		var_2_2 = CCPoint(0.1, 1)
	end

	addLabelWithColorSize(var_2_1, string.lf("绿色天命:#00FF00 %d", arg_2_0.rewardList.green), ccc3(200, 170, 100), 20, var_2_2, CCPoint(var_2_0.width * 0.4, var_2_0.height - 70))
	addLabelWithColorSize(var_2_1, string.lf("蓝色天命:#00FF00 %d", arg_2_0.rewardList.blue), ccc3(200, 170, 100), 20, var_2_2, CCPoint(var_2_0.width * 0.4, var_2_0.height - 100))
	addLabelWithColorSize(var_2_1, string.lf("紫色天命:#00FF00 %d", arg_2_0.rewardList.purple), ccc3(200, 170, 100), 20, var_2_2, CCPoint(var_2_0.width * 0.4, var_2_0.height - 130))
	addLabelWithColorSize(var_2_1, string.lf("橙色天命:#00FF00 %d", arg_2_0.rewardList.orange), ccc3(200, 170, 100), 20, var_2_2, CCPoint(var_2_0.width * 0.4, var_2_0.height - 160))
	addLabelWithColorSize(var_2_1, string.lf("天命碎片:#00FF00 %d", arg_2_0.rewardList.fragment), ccc3(200, 170, 100), 20, var_2_2, CCPoint(var_2_0.width * 0.4, var_2_0.height - 190))
	addLabelWithColorSize(var_2_1, string.lf("绿色/蓝色天命自动被转化为天命经验:#00FF00 %d", arg_2_0.rewardList.exp), ccc3(200, 170, 100), 20, CCPoint(0.5, 1), CCPoint(var_2_0.width / 2, var_2_0.height - 220))

	local var_2_3 = string.split(arg_2_0.rewardList.destiny, ",")

	for iter_2_0, iter_2_1 in ipairs(var_2_3) do
		if #iter_2_1 == 0 then
			table.remove(var_2_3, iter_2_0)
		end
	end

	local var_2_4 = table.nums(var_2_3)
	local var_2_5 = 130
	local var_2_6 = 130
	local var_2_7 = var_2_4 <= 4 and var_2_4 * var_2_5 or var_2_0.width - 20

	local function var_2_8(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = CCLayerColor:create(ccc4(46, 39, 29, 0))

		var_4_0:setContentSize(CCSize(var_2_5, var_2_6))
		dump(arg_4_2, arg_4_1)

		local var_4_1 = figure.createHeader({
			isName = true,
			qualityColor = true,
			type = ItemType.eTianMing,
			itemId = tonumber(arg_4_2)
		})

		var_4_1:setPosition(var_2_5 / 2, var_2_6 / 2)
		var_4_0:addChild(var_4_1)

		return var_4_0
	end

	local var_2_9 = createTableView({
		reverse = false,
		direction = kCCScrollViewDirectionHorizontal,
		size = CCSize(var_2_7, var_2_6),
		dataset = var_2_3,
		sizehandler = function(arg_5_0, arg_5_1)
			return CCSize(var_2_5, var_2_6)
		end,
		cellhandler = var_2_8
	})

	var_2_9:setPosition((var_2_0.width - var_2_7) / 2, 80)
	var_2_1:addChild(var_2_9)

	local var_2_10 = ui.newControlButton({
		highlightedImage = "ui/common/common_115.png",
		titleImage = "uilocal/shenqi/shenqi_text_014.png",
		normalImage = "ui/common/common_115.png",
		position = CCPoint(var_2_0.width / 2, 35),
		clickAction = function()
			if arg_2_0.closeCallback then
				arg_2_0.closeCallback(true)
			end

			arg_2_0:removeFromParentAndCleanup(true)
		end
	})

	var_2_1:addChild(var_2_10)
end

return var_0_0
