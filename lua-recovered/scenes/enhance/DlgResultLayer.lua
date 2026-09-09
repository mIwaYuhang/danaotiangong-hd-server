require("base.figure")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("DlgResultLayer", function()
	return display.newLayer()
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.titleText = arg_2_1.titleText
	arg_2_0.rewardList = arg_2_1.rewardList
	arg_2_0.btnName = arg_2_1.btnName or string.lf("确定")
	arg_2_0.closeCallback = arg_2_1.closeCallback

	local var_2_0 = CCSize(500, 280)
	local var_2_1 = display.newScale9Sprite("ui/common/common_116.png")

	var_2_1:setPreferredSize(var_2_0)
	var_2_1:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_1:setPosition(display.cx, display.cy)
	var_2_1:setScale(Adapter.MinScale)
	arg_2_0:addChild(var_2_1, 100)
	addLabelWithColorSize(var_2_1, arg_2_0.titleText, ccc3(200, 170, 100), 25, CCPoint(0.5, 1), CCPoint(var_2_0.width / 2, var_2_0.height - 20))

	local var_2_2 = table.nums(arg_2_0.rewardList)
	local var_2_3 = 130
	local var_2_4 = CCSize(var_2_2 <= 3 and var_2_2 * var_2_3 or 450, 170)
	local var_2_5 = display.newScale9Sprite("ui/common/common_064_4.png", var_2_0.width / 2, var_2_0.height / 2)

	var_2_5:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_5:setPreferredSize(var_2_4)
	var_2_1:addChild(var_2_5)

	local var_2_6 = CCSize(var_2_4.width, var_2_4.height - 20)
	local var_2_7 = CCSize(var_2_3, var_2_4.height - 20)

	local function var_2_8(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_4_2.Type
		local var_4_1 = arg_4_2.ID
		local var_4_2 = arg_4_2.Count
		local var_4_3 = CCLayerColor:create(ccc4(46, 39, 29, 0))

		var_4_3:setContentSize(var_2_7)

		local var_4_4 = figure.createHeader({
			isName = false,
			inTeam = false,
			itemId = var_4_1 ~= nil and var_4_1 or 0,
			type = var_4_0,
			count = var_4_2,
			clickAction = function()
				if var_4_1 ~= nil and var_4_0 == ItemType.eEquip then
					var_0_0.createTips({
						show = var_0_0.eShowTeamEquip,
						id = var_4_1
					}):show({
						parent = var_2_1,
						x = var_2_0.width / 2,
						y = var_2_0.height,
						align = display.CENTER
					})
				end
			end
		})

		var_4_4:setAnchorPoint(CCPoint(0.5, 0.5))
		var_4_4:setPosition(var_2_7.width / 2, var_2_7.height / 2 + 15)
		var_4_3:addChild(var_4_4)

		local var_4_5 = getQualityColor(getItemQuality(var_4_0, var_4_1))

		addLabelWithColorSize(var_4_3, getItemName(var_4_0, var_4_1), var_4_5, 20, CCPoint(0.5, 0), CCPoint(var_2_7.width / 2, 15))

		return var_4_3
	end

	local var_2_9 = createTableView({
		reverse = false,
		direction = kCCScrollViewDirectionHorizontal,
		size = var_2_6,
		dataset = arg_2_0.rewardList,
		sizehandler = function(arg_6_0, arg_6_1)
			return var_2_7
		end,
		cellhandler = var_2_8
	})

	var_2_9:setPosition(0, 10)
	var_2_5:addChild(var_2_9)

	local var_2_10 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		highlightedImage = "ui/common/common_115.png",
		text = arg_2_0.btnName,
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		position = CCPoint(var_2_0.width / 2, 35),
		clickAction = function()
			if arg_2_0.closeCallback then
				arg_2_0.closeCallback()
			end

			arg_2_0:removeFromParentAndCleanup(true)
		end
	})

	var_2_1:addChild(var_2_10)
end

return var_0_1
