require("data.mineral")

local var_0_0 = class("MineralGetGemLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	local function var_2_0(arg_3_0, arg_3_1, arg_3_2)
		return true
	end

	arg_2_0:addTouchEventListener(var_2_0, false, 1, true)
	arg_2_0:setTouchEnabled(true)
	arg_2_0:setColor(display.COLOR_BLACK)
	arg_2_0:setOpacity(191.25)

	arg_2_0.gems = arg_2_1.data
	arg_2_0.parent = arg_2_1.parent
	arg_2_0.textTitle = arg_2_1.textTitle or nil
	arg_2_0.gemInfo = {}

	arg_2_0:showMineralGetGemInfo()
end

function var_0_0.createCell(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = display.newScale9Sprite("ui/system/system_003.png")

	var_4_0:setPreferredSize(CCSize(450, 40))
	var_4_0:setAnchorPoint(ccp(0, 0))
	var_4_0:setPosition(0, 0)

	local var_4_1 = BaseMineral[arg_4_0.gemInfo[arg_4_2].gemProtoID].name

	addLabelWithColorSize(var_4_0, string.lf("%s 级", arg_4_0.gemInfo[arg_4_2].level), ccc3(255, 255, 0), 20, ccp(0, 0.5), ccp(55, 18))
	addLabelWithColorSize(var_4_0, string.lf("%s ", var_4_1), ccc3(255, 255, 0), 20, ccp(0, 0.5), ccp(150, 18))
	addLabelWithColorSize(var_4_0, string.lf("%s 个", arg_4_0.gemInfo[arg_4_2].cont), ccc3(255, 255, 0), 20, ccp(0, 0.5), ccp(300, 18))

	return var_4_0
end

function var_0_0.setGemInfo(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = false
	local var_5_1 = 0

	for iter_5_0 = 1, #arg_5_0.gems do
		if arg_5_0.gems[iter_5_0].level == arg_5_2 and arg_5_0.gems[iter_5_0].gemProtoID == arg_5_1 then
			var_5_0 = true
			var_5_1 = var_5_1 + 1
		end
	end

	if var_5_0 then
		local var_5_2 = {
			gemProtoID = arg_5_1,
			level = arg_5_2,
			cont = var_5_1
		}

		table.insert(arg_5_0.gemInfo, var_5_2)
	end
end

function var_0_0.showMineralGetGemInfo(arg_6_0)
	if arg_6_0.gems then
		for iter_6_0 = 1, 6 do
			for iter_6_1 = 1, 10 do
				arg_6_0:setGemInfo(iter_6_0, iter_6_1)
			end
		end
	end

	local var_6_0 = CCSize(480, 550)
	local var_6_1 = display.newScale9Sprite("ui/PK/PK_017.png")

	var_6_1:setPreferredSize(var_6_0)
	var_6_1:align(display.CENTER, display.cx, display.cy)
	var_6_1:setScale(Adapter.MinScale)
	arg_6_0:addChild(var_6_1)

	if arg_6_0.textTitle then
		addLabelWithColorSize(var_6_1, arg_6_0.textTitle, ccc3(255, 255, 255), 22, ccp(0.5, 0.5), ccp(var_6_0.width / 2, var_6_0.height - 50))
	end

	addLabelWithColorSize(var_6_1, string.lf("宝石总数：%s", #arg_6_0.gems), ccc3(255, 255, 255), 22, ccp(0.5, 0.5), ccp(var_6_0.width / 2, var_6_0.height - 80))

	local var_6_2 = ui.newControlButton({
		fontSize = 25,
		normalImage = "ui/common/common_019.png",
		text = string.lf("确定"),
		anchorPoint = CCPoint(0.5, 0.5),
		position = CCPoint(var_6_0.width / 2, 50),
		clickAction = function()
			arg_6_0:removeFromParentAndCleanup(true)
		end
	})

	var_6_1:addChild(var_6_2)

	local var_6_3 = CCSize(450, 360)
	local var_6_4 = {
		direction = kCCScrollViewDirectionVertical,
		size = var_6_3,
		sizehandler = function(arg_8_0, arg_8_1)
			return CCSize(450, 40)
		end,
		cellhandler = handler(arg_6_0, arg_6_0.createCell),
		numberhandler = function(arg_9_0)
			return table.maxn(arg_6_0.gemInfo)
		end
	}
	local var_6_5 = createTableView(var_6_4)

	var_6_5:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_6_5:setAnchorPoint(CCPoint(0.5, 0))
	var_6_5:setPosition(var_6_0.width / 2, 100)
	var_6_1:addChild(var_6_5)
end

return var_0_0
