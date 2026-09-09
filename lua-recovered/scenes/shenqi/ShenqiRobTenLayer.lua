local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("ShenqiRobTenLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create(ccc4(10, 10, 10, 180)))
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0.robTenData = arg_2_1.data
	arg_2_0.callBack = arg_2_1.callBack

	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		return true
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	local var_2_0 = CCSize(display.width, display.height)

	arg_2_0:setContentSize(var_2_0)

	arg_2_0.bgSprite = arg_2_0:createDialogBox()

	arg_2_0.bgSprite:setAnchorPoint(CCPoint(0.5, 0.5))
	arg_2_0.bgSprite:setPosition(var_2_0.width / 2, var_2_0.height / 2)
	arg_2_0:addChild(arg_2_0.bgSprite)
	arg_2_0:setAnchorPoint(CCPoint(0, 0))
	arg_2_0:setPosition(0, 0)
	dump(arg_2_0.robTenData)
	arg_2_0:showRewardInfo(arg_2_0.robTenData)
end

function var_0_1.createDialogBox(arg_4_0)
	local var_4_0 = CCSize(784, 542)
	local var_4_1 = CCScale9Sprite:create("ui/shenqi/sq_064.jpg")

	var_4_1:setPreferredSize(var_4_0)
	var_4_1:setScale(Adapter.MinScale)

	local var_4_2 = var_4_1:getContentSize()
	local var_4_3 = 150
	local var_4_4 = 500
	local var_4_5 = display.newSprite("uilocal/shenqi/shenqi_text_010.png", var_4_3, var_4_4)

	var_4_1:addChild(var_4_5)

	arg_4_0.getButton = ui.newControlButton({
		disabledImage = "ui/common/common_064_4.png",
		titleImage = "uilocal/shenqi/shenqi_text_014.png",
		normalImage = "ui/common/common_115.png",
		position = CCPoint(var_4_2.width / 2, 40),
		clickAction = function(arg_5_0, arg_5_1)
			if arg_4_0.callBack then
				arg_4_0.callBack()
			end

			arg_4_0:removeFromParentAndCleanup(true)
		end,
		anchorPoint = CCPoint(0.5, 0.5)
	})

	var_4_1:addChild(arg_4_0.getButton)
	arg_4_0.getButton:setEnabled(false)

	return var_4_1
end

function var_0_1.showRewardInfo(arg_6_0)
	local var_6_0 = 180

	if arg_6_0.scrollView then
		arg_6_0.scrollView:getContainer():removeAllChildrenWithCleanup(true)
	else
		arg_6_0.scrollView = CCScrollView:create(CCSize(750, 380))

		arg_6_0.scrollView:setDirection(kCCScrollViewDirectionVertical)
		arg_6_0.scrollView:setBounceable(false)
		arg_6_0.scrollView:setContentSize(CCSize(750, var_6_0 * 10))
		arg_6_0.scrollView:setPosition(15, 80)
		arg_6_0.scrollView:setAnchorPoint(ccp(0, 0))
		arg_6_0.scrollView:setContentOffset(arg_6_0.scrollView:minContainerOffset())
		arg_6_0.bgSprite:addChild(arg_6_0.scrollView)
	end

	local var_6_1 = #arg_6_0.robTenData.robTenRewards / 2
	local var_6_2 = var_6_1
	local var_6_3 = 0.5
	local var_6_4 = CCArray:create()

	var_6_4:addObject(CCCallFunc:create(function()
		var_6_1 = var_6_1 - var_6_3

		if var_6_1 >= 0 then
			local var_7_0 = (var_6_2 - var_6_1) * 2
			local var_7_1 = display.newSprite("ui/shenqi/sq_065.png", 0, var_6_0 * 10 - var_6_0 * var_7_0)

			arg_6_0.scrollView:addChild(var_7_1)

			local var_7_2 = arg_6_0.robTenData.robTenRewards[var_7_0]
			local var_7_3 = {}
			local var_7_4 = ""

			if var_7_2.rob then
				local var_7_5 = getItemName(var_7_2.rob[1].Type, var_7_2.rob[1].ID)

				var_7_4 = string.lf("您成功抢夺了%d个%s", var_7_2.rob[1].Count, var_7_5)

				table.insert(var_7_3, var_7_2.rob[1])
			else
				var_7_4 = string.lf("您未抢到任何碎片")
			end

			if var_7_2.open then
				local var_7_6 = getItemName(var_7_2.open[1].Type, var_7_2.open[1].ID)

				var_7_4 = var_7_4 .. string.lf(", 翻牌获得%d个%s", var_7_2.open[1].Count, var_7_6)

				table.insert(var_7_3, var_7_2.open[1])
			else
				var_7_4 = var_7_4 .. string.lf("")
			end

			for iter_7_0, iter_7_1 in ipairs(var_7_2.prestigeAndExp) do
				table.insert(var_7_3, iter_7_1)
			end

			local var_7_7 = ui.newTTFLabel({
				text = var_7_4,
				font = _FONT_DEFAULT,
				size = Adapter.FontSize(20),
				align = ui.TEXT_ALIGN_CENTER,
				valign = ui.TEXT_VALIGN_CENTER,
				color = ccc3(245, 255, 0),
				dimensions = CCSize(740, 40)
			})

			var_7_7:setAnchorPoint(ccp(0, 0))
			var_7_7:setPosition(5, var_6_0 * 10 - var_6_0 * var_7_0 + 120)
			arg_6_0.scrollView:addChild(var_7_7)

			for iter_7_2 = 1, #var_7_3 do
				local var_7_8 = var_7_3[iter_7_2]
				local var_7_9 = {
					isName = true,
					type = var_7_8.Type,
					itemId = var_7_8.ID,
					count = var_7_8.Count,
					clickAction = function(arg_8_0, arg_8_1)
						var_0_0.tipshandler(var_7_8)
					end
				}
				local var_7_10 = iter_7_2 * var_6_0 - 75
				local var_7_11 = var_6_0 * 10 - var_6_0 * var_7_0 + 75
				local var_7_12 = figure.createHeader(var_7_9)

				var_7_12:setPosition(var_7_10, var_7_11)
				var_7_12:setAnchorPoint(ccp(0.5, 0.5))
				arg_6_0.scrollView:addChild(var_7_12)
				Adapter.NodeAbsScale(var_7_12)
			end

			if var_7_0 > 2 then
				local var_7_13 = ccp(0, -(var_6_0 * 10 - var_6_0 * var_7_0))

				arg_6_0.scrollView:setContentOffsetInDuration(var_7_13, 0.3)
			end
		else
			arg_6_0.getButton:setEnabled(true)
			arg_6_0.bgSprite:stopAllActions()
			showFlashImage({
				image = "uilocal/shenqi/shenqi_text_015.png",
				parent = arg_6_0.bgSprite,
				position = CCPoint(arg_6_0.getButton:getPositionX(), arg_6_0.getButton:getPositionY())
			})
		end
	end))
	var_6_4:addObject(CCDelayTime:create(var_6_3))
	arg_6_0.bgSprite:runAction(CCRepeatForever:create(CCSequence:create(var_6_4)))
end

function var_0_1.runAction(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.node
	local var_9_1 = arg_9_1.from
	local var_9_2 = arg_9_1.to
	local var_9_3 = arg_9_1.duration
	local var_9_4 = arg_9_1.delay
	local var_9_5 = arg_9_1.callback
	local var_9_6 = 10
	local var_9_7 = 1

	var_9_0:setScale(var_9_6)
	var_9_0:setPosition(var_9_1)
	var_9_0:setOpacity(1)

	local var_9_8 = CCArray:create()

	if var_9_4 then
		var_9_8:addObject(CCDelayTime:create(var_9_4))
	end

	var_9_8:addObject(CCScaleTo:create(var_9_3, var_9_7))
	var_9_8:addObject(CCMoveTo:create(var_9_3, var_9_2))
	var_9_8:addObject(CCFadeTo:create(var_9_3, 255))

	if var_9_5 then
		var_9_8:addObject(CCCallFunc:create(var_9_5))
	end

	var_9_0:runAction(CCSequence:create(var_9_8))
end

return var_0_1
