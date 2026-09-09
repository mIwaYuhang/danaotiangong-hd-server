require("network.TeamRequest")

local var_0_0 = class("TianmingUpgradeLayer", function()
	return display.newLayer()
end)
local var_0_1
local var_0_2
local var_0_3 = {}

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.showTianmingPackageButtonCallback = arg_2_1.showTianmingPackageButtonCallback

	local var_2_0 = CCSize(445, 565)

	arg_2_0.bgSprite = display.newScale9Sprite("ui/team/team_002.png")
	arg_2_0.back_size = var_2_0
	arg_2_0.unloadTianming = arg_2_1.unloadTianming

	arg_2_0.bgSprite:setPreferredSize(var_2_0)
	arg_2_0.bgSprite:setAnchorPoint(CCPoint(0, 0))
	arg_2_0.bgSprite:setPosition(CCPoint(503, 7))
	arg_2_0:addChild(arg_2_0.bgSprite)
	arg_2_0:initRequests()
	arg_2_0:showInitLayer()
	arg_2_0:refreshLayer(arg_2_1)
end

function var_0_0.showInitLayer(arg_3_0)
	arg_3_0.attribSize = CCSize(430, 135)
	arg_3_0.attribLayer = CCNode:create()

	arg_3_0.attribLayer:setContentSize(arg_3_0.attribSize)
	arg_3_0.attribLayer:setPosition((arg_3_0.back_size.width - arg_3_0.attribSize.width) / 2, 400)
	arg_3_0.bgSprite:addChild(arg_3_0.attribLayer)

	arg_3_0.resultSize = CCSize(430, 151)

	local var_3_0 = display.newSprite("ui/common/common_064_4.png", arg_3_0.back_size.width / 2, arg_3_0.back_size.height / 2 - 40)

	arg_3_0.bgSprite:addChild(var_3_0)

	arg_3_0.resultLayer = CCNode:create()

	arg_3_0.resultLayer:setContentSize(arg_3_0.resultSize)
	arg_3_0.resultLayer:setPosition(0, 0)
	var_3_0:addChild(arg_3_0.resultLayer)

	local var_3_1 = ui.newControlButton({
		normalImage = "uilocal/tianming/tianming_text_010.png",
		position = CCPoint(arg_3_0.back_size.width - 70, arg_3_0.back_size.height / 2 + 30),
		clickAction = function()
			arg_3_0.showTianmingPackageButtonCallback()
		end
	})

	arg_3_0.bgSprite:addChild(var_3_1)

	local var_3_2 = ui.newControlButton({
		disabledImage = "ui/common/common_080.png",
		titleImage = "uilocal/tianming/tianming_text_006.png",
		normalImage = "ui/common/common_019.png",
		position = CCPoint(arg_3_0.back_size.width / 2 - 120, 60),
		clickAction = function()
			arg_3_0.tianmingUpgradeRequest:request(var_0_1.id)
		end
	})
	local var_3_3 = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		titleImage = "uilocal/tianming/tianming_text_007.png",
		position = CCPoint(arg_3_0.back_size.width / 2 + 120, 60),
		clickAction = function()
			arg_3_0.unloadTianming(var_0_1.id)
		end
	})

	arg_3_0.bgSprite:addChild(var_3_2)
	arg_3_0.bgSprite:addChild(var_3_3)

	arg_3_0.btnUpdate = var_3_2
end

function var_0_0.refreshHeroItem(arg_7_0, arg_7_1)
	arg_7_0:refreshLayer(arg_7_1)
end

function var_0_0.refreshLayer(arg_8_0, arg_8_1)
	if arg_8_1.callback then
		arg_8_0.callback = arg_8_1.callback
	end

	var_0_1 = arg_8_1.tianmingItem
	var_0_2 = BaseTianMings[var_0_1.destinyID]
	arg_8_0.quality = var_0_2.quality

	arg_8_0.resultLayer:removeAllChildrenWithCleanup(true)
	arg_8_0.attribLayer:removeAllChildrenWithCleanup(true)

	local var_8_0 = figure.createHeader({
		noTypeImage = false,
		isName = false,
		itemId = var_0_1.destinyID,
		type = ItemType.eTianMing,
		level = var_0_1.level
	})

	var_8_0:setScale(1.2)
	var_8_0:setPosition(100, arg_8_0.attribSize.height / 2)
	arg_8_0.attribLayer:addChild(var_8_0)
	addLabelWithColorSize(arg_8_0.attribLayer, string.format("%s  Lv.%d", var_0_2.name, var_0_1.level), getQualityColor(arg_8_0.quality), 25, CCPoint(0, 0.5), CCPoint(190, arg_8_0.attribSize.height * 0.75))
	addLabelWithColorSize(arg_8_0.attribLayer, string.lf("属性: "), ccc3(67, 33, 0), 20, CCPoint(0, 0.5), CCPoint(190, arg_8_0.attribSize.height * 0.5))

	local var_8_1 = getTianmingAttrList(var_0_1)
	local var_8_2 = arg_8_0.attribSize.height * 0.5

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		local var_8_3 = string.format("%s+%d", iter_8_1.name, var_0_1[iter_8_1.type])

		addLabelWithColorSize(arg_8_0.attribLayer, var_8_3, ccc3(67, 33, 0), 20, CCPoint(0, 0.5), CCPoint(250, var_8_2))

		var_8_2 = var_8_2 - arg_8_0.attribSize.height * 0.25
	end

	if tolua.isnull(arg_8_0.upgradeExpLabel) then
		arg_8_0.upgradeExpLabel = addLabelWithColorSize(arg_8_0.bgSprite, string.lf(" ", var_0_2.upgradeData[var_0_1.level].upgradeExp), ccc3(0, 0, 0), 24, CCPoint(0.5, 0.5), CCPoint(arg_8_0.back_size.width / 2, 110))
	end

	if var_0_2.upgradeData[var_0_1.level].upgradeExp then
		arg_8_0.upgradeExpLabel:setString(string.lf("升级所需经验: %s", var_0_2.upgradeData[var_0_1.level].upgradeExp))
	else
		arg_8_0.upgradeExpLabel:setString(string.lf(" ", var_0_2.upgradeData[var_0_1.level].upgradeExp))
	end

	local var_8_4 = display.newSprite("ui/common/common_049.png")

	var_8_4:setPosition(200, 80)
	arg_8_0.resultLayer:addChild(var_8_4)
	addLabelWithColorSize(arg_8_0.resultLayer, string.lf("当前属性"), ccc3(185, 181, 47), 20, CCPoint(0, 0), CCPoint(60, arg_8_0.resultSize.height - 50))
	addLabelWithColorSize(arg_8_0.resultLayer, string.lf("升级属性"), ccc3(185, 181, 47), 20, CCPoint(0, 0), CCPoint(235, arg_8_0.resultSize.height - 50))
	arg_8_0:showTianmingAttrValue(arg_8_0.resultSize.height - 80)

	local var_8_5 = var_0_2.upgradeData[var_0_1.level]

	if var_8_5 == nil or var_8_5.upgradeExp == nil or Player.tianMingExp < var_8_5.upgradeExp then
		arg_8_0.btnUpdate:setEnabled(false)
	else
		arg_8_0.btnUpdate:setEnabled(true)
	end
end

function var_0_0.getUpgradeData(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.level + 1

	return var_0_2.upgradeData[var_9_0]
end

function var_0_0.showTianmingAttrValue(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getUpgradeData(var_0_1)
	local var_10_1 = getTianmingAttrList(var_0_1)
	local var_10_2 = 0

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		local var_10_3 = var_0_1[iter_10_1.type]
		local var_10_4 = var_10_0 and var_10_0[iter_10_1.type] or var_0_1[iter_10_1.type]
		local var_10_5 = string.format("%s+%d", iter_10_1.name, var_10_3)

		addLabelWithColorSize(arg_10_0.resultLayer, var_10_5, ccc3(185, 181, 47), 20, CCPoint(0, 0), CCPoint(60, arg_10_1 - var_10_2))

		local var_10_6 = string.format("%s+%d", iter_10_1.name, var_10_4)

		addLabelWithColorSize(arg_10_0.resultLayer, var_10_6, ccc3(185, 181, 47), 20, CCPoint(0, 0), CCPoint(235, arg_10_1 - var_10_2))

		if table.nums(var_0_3) > 0 then
			local var_10_7 = var_0_3[iter_10_1.type] and var_0_3[iter_10_1.type] or var_0_1[iter_10_1.type]
			local var_10_8 = string.format("+%d", var_10_3 - var_10_7)

			addLabelWithColorSize(arg_10_0.resultLayer, var_10_8, ccc3(0, 255, 0), 20, CCPoint(0, 0), CCPoint(360, arg_10_1 - var_10_2))
		end

		var_10_2 = var_10_2 + 25
	end

	var_0_3 = {}
end

function var_0_0.initRequests(arg_11_0)
	local function var_11_0()
		for iter_12_0, iter_12_1 in pairs(var_0_1) do
			var_0_3[iter_12_0] = iter_12_1
		end

		if arg_11_0.callback then
			arg_11_0.callback({})
		end
	end

	arg_11_0.tianmingUpgradeRequest = DestinyUpgradeRequest:new()

	arg_11_0.tianmingUpgradeRequest:setResponseNormalHandler(var_11_0)
end

return var_0_0
