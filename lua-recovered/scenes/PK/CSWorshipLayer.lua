local var_0_0 = class("CSWorshipLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	local var_2_0 = display.newSprite("ui/PK/PK_037.png")

	var_2_0:setScale(Adapter.MinScale)
	var_2_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_0:setPosition(display.cx, display.cy)
	arg_2_0:addChild(var_2_0)

	local var_2_1 = var_2_0:getContentSize()
	local var_2_2 = display.newSprite("ui/PK/PK_031.png", var_2_1.width / 2, var_2_1.height - 45)

	var_2_0:addChild(var_2_2)

	local var_2_3 = var_2_2:getContentSize()

	addLabelWithColorSize(var_2_2, arg_2_1.PlayerName, ccc3(255, 255, 0), 25, CCPoint(0.5, 0.5), CCPoint(var_2_3.width / 2, var_2_3.height / 2))

	local var_2_4 = figure.createHeader({
		isName = false,
		count = 0,
		inTeam = false,
		itemId = arg_2_1.AvatarId,
		type = ItemType.eHero,
		level = arg_2_1.Level
	})

	var_2_4:setPosition(100, var_2_1.height - 120)
	var_2_0:addChild(var_2_4)
	addLabelWithColorSize(var_2_0, string.lf("VIP等级 : #00FF00%d", arg_2_1.VipLevel), ccc3(255, 225, 255), 20, CCPoint(0, 0.5), CCPoint(160, var_2_1.height - 90))
	addLabelWithColorSize(var_2_0, string.lf("被膜拜了: #00FF00%d次", arg_2_1.WorshipCnt), ccc3(255, 225, 255), 20, CCPoint(0, 0.5), CCPoint(160, var_2_1.height - 120))
	addLabelWithColorSize(var_2_0, string.lf("被吐口水: #00FF00%d", arg_2_1.SplitCnt), ccc3(255, 225, 255), 20, CCPoint(0, 0.5), CCPoint(160, var_2_1.height - 150))

	local var_2_5 = CCSize(var_2_1.width - 40, 280)
	local var_2_6 = display.newScale9Sprite("ui/PK/PK_019.png", 20, 100, var_2_5)

	var_2_6:setAnchorPoint(CCPoint(0, 0))
	var_2_0:addChild(var_2_6)

	arg_2_0.cellSize = CCSize(var_2_5.width - 20, 50)

	local var_2_7 = arg_2_1.WorshipLogInfo ~= nil and arg_2_1.WorshipLogInfo or {}
	local var_2_8 = createTableView({
		reverse = true,
		size = CCSize(var_2_5.width - 20, var_2_5.height - 20),
		direction = kCCScrollViewDirectionVertical,
		dataset = var_2_7,
		sizehandler = function(arg_4_0, arg_4_1)
			return arg_2_0.cellSize
		end,
		cellhandler = handler(arg_2_0, arg_2_0.showLogCell)
	})

	var_2_8:setPosition(10, 10)
	var_2_6:addChild(var_2_8)

	local var_2_9 = ui.newControlButton({
		fontSize = 25,
		normalImage = "ui/common/common_019.png",
		text = string.lf("关闭"),
		anchorPoint = CCPoint(0.5, 0.5),
		position = CCPoint(var_2_1.width / 2, 45),
		clickAction = function()
			arg_2_0:removeFromParentAndCleanup(true)
		end
	})

	var_2_0:addChild(var_2_9)
end

function var_0_0.showLogCell(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = display.newScale9Sprite(arg_6_2 % 2 == 0 and "ui/PK/PK_023.png" or "ui/PK/PK_024.png", arg_6_0.cellSize.width / 2, arg_6_0.cellSize.height / 2, arg_6_0.cellSize)
	local var_6_1

	if arg_6_3.WorshipType == worshipTypes.typeOfSupport then
		var_6_1 = string.lf("%s被#00FF00%s#FFE1FF膜拜了一次", getFormatCountDownTime(arg_6_3.Times), arg_6_3.Playername)
	else
		var_6_1 = string.lf("%s被#00FF00%s#FFE1FF吐口水一次", getFormatCountDownTime(arg_6_3.Times), arg_6_3.Playername)
	end

	if arg_6_3.WorshipTimes ~= nil and arg_6_3.SplitScale ~= nil then
		var_6_1 = string.lf("%s#00FF00%d/%d#FFE1FF次膜拜后清除", var_6_1, arg_6_3.WorshipTimes, arg_6_3.SplitScale)
	end

	local var_6_2 = ui.newTTFLabel({
		text = "",
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(20),
		color = ccc3(255, 225, 255),
		dimensions = CCSize(arg_6_0.cellSize.width - 20, arg_6_0.cellSize.height),
		align = ui.TEXT_ALIGN_LEFT,
		valign = ui.TEXT_VALIGN_CENTER
	})

	var_6_2:setString(var_6_1)
	var_6_2:setAnchorPoint(CCPoint(0.5, 0.5))
	var_6_2:setPosition(arg_6_0.cellSize.width / 2, arg_6_0.cellSize.height / 2)
	var_6_0:addChild(var_6_2)

	return var_6_0
end

return var_0_0
