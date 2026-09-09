ProgressBarType = {
	barTypeTimerRadial = 2,
	barTypeSpriteNormal = 1,
	barTypeTimerVertical = 3
}

local var_0_0 = class("ProgressBar", function()
	return CCNode:create()
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.backImage = arg_2_1.backImage
	arg_2_0.backSize = arg_2_1.backSize
	arg_2_0.barType = arg_2_1.barType or ProgressBarType.barTypeSpriteNormal
	arg_2_0.barImages = arg_2_1.barImages
	arg_2_0.barPosition = arg_2_1.barPosition
	arg_2_0.barSize = arg_2_1.barSize or CCTextureCache:sharedTextureCache():addImage(arg_2_0.barImages[1]):getContentSize()
	arg_2_0.curValue = arg_2_1.curValue
	arg_2_0.totalValue = arg_2_1.totalValue

	if arg_2_0.curValue and arg_2_0.totalValue then
		arg_2_0.percent = math.min(arg_2_0.curValue / arg_2_0.totalValue, 1)
	else
		arg_2_0.percent = arg_2_1.percent or 0
	end

	arg_2_0.labelColor = arg_2_1.labelColor

	local var_2_0 = arg_2_0.backSize or CCTextureCache:sharedTextureCache():addImage(arg_2_0.backImage):getContentSize()

	arg_2_0.barPosition = arg_2_0.barPosition or ccp(-var_2_0.width / 2, 0)

	if arg_2_0.backImage then
		arg_2_0.backSprite = display.newScale9Sprite(arg_2_0.backImage, 0, 0, var_2_0)

		arg_2_0:addChild(arg_2_0.backSprite)
	end

	if arg_2_0.barType == ProgressBarType.barTypeSpriteNormal then
		arg_2_0:addProgressBarForNormal()
	elseif arg_2_0.barType == ProgressBarType.barTypeTimerRadial or arg_2_0.barType == ProgressBarType.barTypeTimerVertical then
		arg_2_0:addProgressBarForRadial()
	end

	if arg_2_0.curValue and arg_2_0.totalValue then
		arg_2_0.percentLabel = ui.newTTFLabel({
			text = string.format("%d/%d", arg_2_0.curValue, arg_2_0.totalValue),
			font = _FONT_DEFAULT,
			size = arg_2_1.fontSize or Adapter.FontSize(16),
			color = arg_2_0.labelColor or ccc3(0, 255, 255),
			align = ui.TEXT_ALIGN_CENTER,
			position = ccp(var_2_0.width / 2, var_2_0.height / 2)
		})

		arg_2_0:addChild(arg_2_0.percentLabel)
	end
end

function var_0_0.addProgressBarForNormal(arg_3_0)
	arg_3_0.progressBars = {}

	for iter_3_0 = 1, table.nums(arg_3_0.barImages) do
		local var_3_0 = display.newScale9Sprite(arg_3_0.barImages[iter_3_0], arg_3_0.barPosition.x, arg_3_0.barPosition.y)

		var_3_0:setPreferredSize(CCSize(arg_3_0.barSize.width * arg_3_0.percent, arg_3_0.barSize.height))
		var_3_0:setAnchorPoint(ccp(0, 0.5))
		arg_3_0:addChild(var_3_0)
		table.insert(arg_3_0.progressBars, var_3_0)
	end
end

function var_0_0.addProgressBarForRadial(arg_4_0)
	arg_4_0.progressBars = {}

	for iter_4_0 = 1, table.nums(arg_4_0.barImages) do
		local var_4_0 = CCProgressTimer:create(display.newSprite(arg_4_0.barImages[iter_4_0]))

		if arg_4_0.barType == ProgressBarType.barTypeTimerRadial then
			var_4_0:setType(kCCProgressTimerTypeRadial)
		elseif arg_4_0.barType == ProgressBarType.barTypeTimerVertical then
			var_4_0:setType(kCCProgressTimerTypeBar)
			var_4_0:setMidpoint(CCPoint(0, 0))
			var_4_0:setBarChangeRate(CCPoint(0, 1))
		end

		var_4_0:setPercentage(arg_4_0.percent * 100)
		var_4_0:setPosition(ccp(arg_4_0.barPosition.x, arg_4_0.barPosition.y))
		arg_4_0:addChild(var_4_0)
		table.insert(arg_4_0.progressBars, var_4_0)
	end
end

function var_0_0.setProgressPercent(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.percent = math.min(arg_5_2, 1)

	if arg_5_0.progressBars[arg_5_1] then
		if arg_5_0.barType == ProgressBarType.barTypeSpriteNormal then
			arg_5_0.progressBars[arg_5_1]:setPreferredSize(CCSize(arg_5_0.barSize.width * arg_5_2, arg_5_0.barSize.height))
		elseif arg_5_0.barType == ProgressBarType.barTypeTimerRadial or arg_5_0.barType == ProgressBarType.barTypeTimerVertical then
			arg_5_0.progressBars[arg_5_1]:setPercentage(arg_5_2 * 100)
		end
	end
end

function var_0_0.setProgressValue(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.curValue = arg_6_2
	arg_6_0.totalValue = arg_6_3

	arg_6_0:setProgressPercent(arg_6_1, math.min(arg_6_2 / arg_6_3, 1))

	if arg_6_0.percentLabel then
		arg_6_0.percentLabel:setString(string.format("%d/%d", arg_6_2, arg_6_3))
	end
end

function var_0_0.actionPercent(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	local var_7_0 = arg_7_4 and table.getn(arg_7_4) or 0
	local var_7_1 = var_7_0
	local var_7_2 = arg_7_0.curValue
	local var_7_3 = 0.05
	local var_7_4 = var_7_1 == 0 and arg_7_3 or arg_7_4[1]
	local var_7_5 = CCSequence:createWithTwoActions(CCDelayTime:create(var_7_3), CCCallFunc:create(function()
		var_7_2 = var_7_2 + var_7_4 * var_7_3

		if var_7_2 >= arg_7_2 and var_7_1 <= 0 then
			arg_7_0:setProgressValue(arg_7_1, arg_7_2, arg_7_3)
			arg_7_0:stopAllActions()
		else
			if var_7_2 > var_7_4 and var_7_1 > 0 then
				var_7_2 = var_7_2 - var_7_4
				var_7_1 = var_7_1 - 1
				var_7_4 = var_7_1 == 0 and arg_7_3 or arg_7_4[var_7_0 - var_7_1]
			elseif var_7_1 < 0 then
				var_7_1 = var_7_1 + 1
			end

			if arg_7_5 and var_7_0 > var_7_1 then
				arg_7_5(var_7_0 - var_7_1)
			end

			arg_7_0:setProgressValue(arg_7_1, var_7_2, var_7_4)
		end
	end))

	arg_7_0:runAction(CCRepeatForever:create(var_7_5))
end

function var_0_0.getBackSprite(arg_9_0)
	return arg_9_0.backSprite
end

function var_0_0.getProgressBars(arg_10_0)
	return arg_10_0.progressBars
end

return var_0_0
