local var_0_0 = class("BattleTenResultLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create(ccc4(10, 10, 10, 180)))
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	local var_2_0 = CCSize(display.width, display.height)

	arg_2_0:setContentSize(var_2_0)

	arg_2_0.resultList = arg_2_1.resultList
	arg_2_0.stageId = arg_2_1.stageId

	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		return true
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	local var_2_1 = CCSize(display.width, display.height)

	arg_2_0:setContentSize(var_2_1)

	arg_2_0.bgSprite = arg_2_0:createDialogBox()

	arg_2_0.bgSprite:setAnchorPoint(CCPoint(0.5, 0.5))
	arg_2_0.bgSprite:setPosition(var_2_1.width / 2, var_2_1.height / 2)
	arg_2_0:addChild(arg_2_0.bgSprite)
	arg_2_0:setAnchorPoint(CCPoint(0, 0))
	arg_2_0:setPosition(0, 0)
	arg_2_0:showRewardInfo()
end

function var_0_0.createDialogBox(arg_4_0)
	local var_4_0 = CCSize(784, 542)
	local var_4_1 = CCScale9Sprite:create("ui/shenqi/sq_064.jpg")

	var_4_1:setPreferredSize(var_4_0)
	var_4_1:setScale(Adapter.MinScale)

	local var_4_2 = var_4_1:getContentSize()
	local var_4_3 = var_4_2.width / 2
	local var_4_4 = 530
	local var_4_5 = display.newSprite("ui/common/common_064_2.png", var_4_3, var_4_4)

	var_4_1:addChild(var_4_5)

	local var_4_6 = display.newSprite("uilocal/map/map_002.png", var_4_3, var_4_4 + 3)

	var_4_1:addChild(var_4_6)

	arg_4_0.doneButton = ui.newControlButton({
		disabledImage = "ui/common/common_080.png",
		normalImage = "ui/common/common_019.png",
		text = string.lf("完成战斗"),
		textColor = ColorTable.eTitleButton_Normal2,
		fontSize = ColorTable.eTitleButton_FontSize2,
		position = CCPoint(var_4_2.width / 2, 50),
		clickAction = function(arg_5_0, arg_5_1)
			if arg_4_0.callBack then
				arg_4_0.callBack()
			end

			arg_4_0:removeFromParentAndCleanup(true)
		end,
		anchorPoint = CCPoint(0.5, 0.5)
	})

	var_4_1:addChild(arg_4_0.doneButton)
	arg_4_0.doneButton:setEnabled(false)

	return var_4_1
end

function var_0_0.showRewardInfo(arg_6_0)
	local var_6_0 = 180

	if arg_6_0.scrollView then
		arg_6_0.scrollView:getContainer():removeAllChildrenWithCleanup(true)
	else
		arg_6_0.scrollView = CCScrollView:create(CCSize(750, 400))

		arg_6_0.scrollView:setDirection(kCCScrollViewDirectionVertical)
		arg_6_0.scrollView:setBounceable(false)
		arg_6_0.scrollView:setContentSize(CCSize(750, var_6_0 * 10))
		arg_6_0.scrollView:setPosition(15, 100)
		arg_6_0.scrollView:setAnchorPoint(ccp(0, 0))
		arg_6_0.scrollView:setContentOffset(arg_6_0.scrollView:minContainerOffset())
		arg_6_0.bgSprite:addChild(arg_6_0.scrollView)
	end

	local var_6_1 = #arg_6_0.resultList / 2
	local var_6_2 = var_6_1
	local var_6_3 = 0.5
	local var_6_4 = CCArray:create()

	var_6_4:addObject(CCCallFunc:create(function()
		var_6_1 = var_6_1 - var_6_3

		if var_6_1 >= 0 then
			local var_7_0 = (var_6_2 - var_6_1) * 2
			local var_7_1 = display.newSprite("ui/shenqi/sq_065.png", 0, var_6_0 * 10 - var_6_0 * var_7_0)

			arg_6_0.scrollView:addChild(var_7_1)

			local var_7_2 = arg_6_0.resultList[var_7_0].Operator.dropList
			local var_7_3 = (string.lf("扫荡 \"%s\" 第%d次...", BaseStages[arg_6_0.stageId].stageName, var_7_0) .. string.lf("  主角Exp #00FF00+%d", arg_6_0.resultList[var_7_0].Operator.GetExp)) .. string.lf("  所有主将Exp #00FF00+%d", arg_6_0.resultList[var_7_0].Operator.HeroExps[1].GetExp)
			local var_7_4 = ui.newTTFLabel({
				text = var_7_3,
				font = _FONT_DEFAULT,
				size = Adapter.FontSize(20),
				align = ui.TEXT_ALIGN_CENTER,
				valign = ui.TEXT_VALIGN_CENTER,
				color = ccc3(245, 255, 0),
				dimensions = CCSize(740, 40)
			})

			var_7_4:setAnchorPoint(ccp(0, 0))
			var_7_4:setPosition(5, var_6_0 * 10 - var_6_0 * var_7_0 + 120)
			arg_6_0.scrollView:addChild(var_7_4)

			for iter_7_0 = 1, #var_7_2 do
				local var_7_5 = var_7_2[iter_7_0]
				local var_7_6 = {
					isName = true,
					type = var_7_5.Type,
					itemId = var_7_5.ID,
					count = var_7_5.Count,
					clickAction = function(arg_8_0, arg_8_1)
						ToolLayer.tipshandler(var_7_5)
					end
				}
				local var_7_7 = iter_7_0 * var_6_0 - 75
				local var_7_8 = var_6_0 * 10 - var_6_0 * var_7_0 + 75
				local var_7_9 = figure.createHeader(var_7_6)

				var_7_9:setPosition(var_7_7, var_7_8)
				var_7_9:setAnchorPoint(ccp(0.5, 0.5))
				arg_6_0.scrollView:addChild(var_7_9)
				Adapter.NodeAbsScale(var_7_9)
			end

			if var_7_0 > 2 then
				local var_7_10 = ccp(0, -(var_6_0 * 10 - var_6_0 * var_7_0))

				arg_6_0.scrollView:setContentOffsetInDuration(var_7_10, 0.3)
			end
		else
			arg_6_0.doneButton:setEnabled(true)
			arg_6_0.bgSprite:stopAllActions()
			showFlashImage({
				image = "uilocal/enhance/enhance_txt_007.png",
				parent = arg_6_0.bgSprite,
				position = CCPoint(arg_6_0.doneButton:getPositionX(), arg_6_0.doneButton:getPositionY())
			})
		end
	end))
	var_6_4:addObject(CCDelayTime:create(var_6_3))
	arg_6_0.bgSprite:runAction(CCRepeatForever:create(CCSequence:create(var_6_4)))
end

return var_0_0
