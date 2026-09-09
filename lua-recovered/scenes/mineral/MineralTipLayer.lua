require("data.mineral")

local var_0_0 = class("MineralTipLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.mineralItem = arg_2_1.mineralItem
	arg_2_0.buttonItems = arg_2_1.buttonItems
	arg_2_0.buttons = {}
	arg_2_0.buttonArea = {}

	if arg_2_0.mineralItem ~= nil then
		arg_2_0.mineralLevel = arg_2_1.mineralItem.level
		arg_2_0.gemProtoID = arg_2_1.mineralItem.gemProtoID
	else
		arg_2_0.gemProtoID = arg_2_1.mineralId
		arg_2_0.mineralLevel = arg_2_1.level or 1
	end

	assert(arg_2_0.gemProtoID ~= nil and arg_2_0.gemProtoID > 0 and arg_2_0.gemProtoID < 7, "gemProtoID is wrong")

	arg_2_0.waibnode = arg_2_1.node

	if arg_2_1.node then
		local var_2_0 = arg_2_1.node:convertToWorldSpace(ccp(0, 0))

		arg_2_0.posx = var_2_0.x
		arg_2_0.posy = var_2_0.y
	else
		arg_2_0.posx = arg_2_1.x or display.cx
		arg_2_0.posy = arg_2_1.y or display.cy
	end

	arg_2_0:initLayer()

	if arg_2_0.buttonItems ~= nil then
		arg_2_0:addButtons(arg_2_0.buttonItems)
	else
		arg_2_0:addButtons({
			{
				text = string.lf("确定"),
				callback = function()
					arg_2_0:removeLayer()
				end
			}
		})
	end
end

function var_0_0.initLayer(arg_4_0)
	local function var_4_0(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == "began" then
			for iter_5_0, iter_5_1 in ipairs(arg_4_0.buttonArea) do
				if iter_5_1:containsPoint(ccp(arg_5_1, arg_5_2)) then
					return true
				end
			end

			arg_4_0:removeLayer()
		end
	end

	arg_4_0:setTouchEnabled(true)
	arg_4_0:addTouchEventListener(var_4_0, false, 1, true)

	arg_4_0.backGround = display.newScale9Sprite("ui/common/common_116.png")

	arg_4_0.backGround:setPreferredSize(CCSize(340, 280))

	arg_4_0.backSize = arg_4_0.backGround:getContentSize()

	arg_4_0.backGround:setScale(Adapter.MinScale)

	if arg_4_0.waibnode then
		local var_4_1, var_4_2 = arg_4_0:getLocation(arg_4_0.posx, arg_4_0.posy, arg_4_0.backSize.width * Adapter.MinScale, arg_4_0.backSize.height * Adapter.MinScale)

		arg_4_0.backGround:setPosition(ccp(var_4_1, var_4_2))
	else
		arg_4_0.backGround:setPosition(ccp(arg_4_0.posx, arg_4_0.posy))
	end

	arg_4_0.backGround:setAnchorPoint(ccp(0.5, 0.5))
	arg_4_0:addChild(arg_4_0.backGround)

	local var_4_3 = ccc3(239, 223, 181)
	local var_4_4 = 20
	local var_4_5 = figure.createMineralHeader({
		itemId = arg_4_0.gemProtoID,
		level = arg_4_0.mineralLevel
	})

	var_4_5:setPosition(ccp(75, arg_4_0.backSize.height - 55))
	arg_4_0.backGround:addChild(var_4_5)

	local var_4_6 = arg_4_0.mineralLevel .. string.lf("级") .. BaseMineral[arg_4_0.gemProtoID].name

	addLabelWithColorSize(arg_4_0.backGround, var_4_6, arg_4_0:getNameColor(arg_4_0.mineralLevel), var_4_4 + 4, ccp(0, 0), ccp(120, arg_4_0.backSize.height - 70))

	local var_4_7 = display.newSprite("ui/common/common_100.png")

	var_4_7:setPosition(ccp(arg_4_0.backSize.width * 0.5, arg_4_0.backSize.height - 100))
	arg_4_0.backGround:addChild(var_4_7)

	local var_4_8 = {
		{
			text = string.lf("可镶嵌于"),
			point = ccp(60, arg_4_0.backSize.height - 140)
		},
		{
			text = string.lf("出售价格: 540"),
			point = ccp(60, arg_4_0.backSize.height - 200)
		},
		{
			text = MineralHelper:getCanInlayEquip(arg_4_0.gemProtoID),
			point = ccp(145, arg_4_0.backSize.height - 140),
			color = ccc3(0, 255, 0)
		}
	}

	if arg_4_0.mineralItem then
		table.insert(var_4_8, {
			text = MineralHelper:readGemAddValue(arg_4_0.mineralItem),
			point = ccp(60, arg_4_0.backSize.height - 170)
		})
	end

	for iter_4_0, iter_4_1 in ipairs(var_4_8) do
		addLabelWithColorSize(arg_4_0.backGround, iter_4_1.text, iter_4_1.color or var_4_3, var_4_4, ccp(0, 0), iter_4_1.point)
	end

	CCDirector:sharedDirector():getRunningScene():addChild(arg_4_0)
end

function var_0_0.removeLayer(arg_6_0)
	arg_6_0:removeFromParentAndCleanup(true)
end

function var_0_0.addButtons(arg_7_0, arg_7_1)
	local var_7_0 = "ui/common/common_115.png"

	arg_7_0.buttonNum = arg_7_1 ~= nil and #arg_7_1 or 0

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		item = ui.newControlButton({
			normalImage = var_7_0,
			text = iter_7_1.text,
			fontSize = ColorTable.eTitleButton_FontSize,
			textColor = ColorTable.eTitleButton_Normal,
			clickAction = function(arg_8_0, arg_8_1)
				if iter_7_1.callback then
					iter_7_1.callback({
						item = arg_7_0.mineralItem,
						gemProtoID = arg_7_0.gemProtoID
					})
				end

				arg_7_0:removeSelf()
			end
		})

		item:setTitleColorForState(ccc3(100, 100, 100), CCControlStateDisabled)
		table.insert(arg_7_0.buttons, item)
	end

	arg_7_0:initButtons()
end

function var_0_0.initButtons(arg_9_0)
	if arg_9_0.buttonNum == 0 then
		return
	else
		for iter_9_0, iter_9_1 in ipairs(arg_9_0.buttons) do
			local var_9_0 = arg_9_0.backSize.width / (arg_9_0.buttonNum * 2) + arg_9_0.backSize.width * (iter_9_0 - 1) / arg_9_0.buttonNum
			local var_9_1 = arg_9_0.backGround:convertToWorldSpace(ccp(var_9_0, 35))

			iter_9_1:setPosition(ccp(var_9_1.x, var_9_1.y))

			local var_9_2 = iter_9_1:getBoundingBox()

			iter_9_1:setPosition(arg_9_0.backSize.width / (arg_9_0.buttonNum * 2) + arg_9_0.backSize.width * (iter_9_0 - 1) / arg_9_0.buttonNum, 35)
			arg_9_0.backGround:addChild(iter_9_1)
			table.insert(arg_9_0.buttonArea, var_9_2)
		end
	end
end

function var_0_0.getLocation(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0
	local var_10_1

	if arg_10_1 + arg_10_3 + 80 < display.right then
		var_10_0 = arg_10_1 + arg_10_3 * 0.5
	else
		var_10_0 = arg_10_1 - arg_10_3 * 0.5
	end

	if arg_10_2 - arg_10_4 - 80 > display.bottom then
		var_10_1 = arg_10_2 - arg_10_4 * 0.5
	else
		var_10_1 = arg_10_2 + arg_10_4 * 0.5
	end

	return var_10_0, var_10_1
end

function var_0_0.getNameColor(arg_11_0, arg_11_1)
	local var_11_0

	if arg_11_1 == nil or arg_11_1 < 1 then
		var_11_0 = QualityType.eNone
	elseif arg_11_1 == 1 or arg_11_1 == 2 then
		var_11_0 = QualityType.eWhite
	elseif arg_11_1 == 3 or arg_11_1 == 4 then
		var_11_0 = QualityType.eGreen
	elseif arg_11_1 == 5 or arg_11_1 == 6 then
		var_11_0 = QualityType.eBlue
	elseif arg_11_1 == 7 or arg_11_1 == 8 then
		var_11_0 = QualityType.ePurple
	elseif arg_11_1 == 9 then
		var_11_0 = QualityType.eOrange
	elseif arg_11_1 == 10 then
		var_11_0 = QualityType.eRed
	else
		var_11_0 = QualityType.eNone
	end

	return getQualityAttribute(var_11_0, QualityAttr.eColor)
end

return var_0_0
