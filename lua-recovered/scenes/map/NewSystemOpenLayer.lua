local var_0_0 = class("NewSystemOpenLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.parrent = arg_2_1.parrent

	local function var_2_0(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end

	arg_2_0:addTouchEventListener(var_2_0, false, 0, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.bgSprite = CCSprite:create("ui/battle/battle_066.png")

	arg_2_0.bgSprite:setVisible(false)
	arg_2_0.bgSprite:setPosition(ccp(display.cx, display.cy))
	arg_2_0.bgSprite:setScale(Adapter.MinScale)
	arg_2_0:addChild(arg_2_0.bgSprite)

	local var_2_1 = display.newSprite("uilocal/battle/battle_text_209.png", 330, 333)

	arg_2_0.bgSprite:addChild(var_2_1)

	local var_2_2 = ui.newControlButton({
		fontSize = 28,
		highlightedImage = "ui/common/common_106.png",
		scaleY = 1,
		normalImage = "ui/common/common_105.png",
		scaleX = 1,
		text = string.lf("关闭"),
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_4_0, arg_4_1)
			arg_2_0:close()
		end,
		position = CCPoint(305, 10)
	})

	arg_2_0.bgSprite:addChild(var_2_2)

	local var_2_3 = 290

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.featureList) do
		local var_2_4 = var_2_3 - 147 * (iter_2_0 - 1)
		local var_2_5 = display.newSprite("ui/battle/battle_067.png", 321, var_2_4)

		arg_2_0.bgSprite:addChild(var_2_5)

		local var_2_6 = display.newSprite(iter_2_1.displayBg, 63, 67)

		var_2_5:addChild(var_2_6)

		local var_2_7 = var_2_6:getContentSize()
		local var_2_8 = math.max(var_2_7.width, var_2_7.height)

		if var_2_8 > 150 then
			local var_2_9 = 150 / var_2_8

			var_2_6:setScale(var_2_9)
		end

		addLabelWithColorSize(var_2_5, iter_2_1.name, ccc3(207, 154, 38), 20, CCPoint(0, 1), ccp(133, 100))

		local var_2_10 = addLabelWithColorSize(var_2_5, iter_2_1.desc, ccc3(255, 255, 255), 17, CCPoint(0, 1), ccp(133, 75))

		var_2_10:setHorizontalAlignment(ui.TEXT_ALIGN_LEFT)
		var_2_10:setDimensions(CCSize(380, 60))

		if iter_2_1.taskEntryType ~= nil then
			local var_2_11 = ui.newControlButton({
				normalImage = "ui/common/common_127.png",
				position = CCPoint(578, 68),
				clickAction = function(arg_5_0, arg_5_1)
					if arg_2_0.parrent:getParent().lvlCompliteLayer then
						arg_2_0.parrent:getParent().lvlCompliteLayer:removeFromParentAndCleanup(true)

						arg_2_0.parrent:getParent().lvlCompliteLayer = nil
					end

					arg_2_0:removeFromParentAndCleanup(true)

					if iter_2_1.taskEntryType == TaskEntryType.eGuideXianMoZhengBa or iter_2_1.taskEntryType == TaskEntryType.eMysterystore or iter_2_1.taskEntryType == TaskEntryType.eGuideXiaohuoban then
						Player.currentTaskEntryType = iter_2_1.taskEntryType
						Player.currentTaskStep = 1

						game.enterHomeScene({
							showHomeGuideArrow = true
						})

						return
					end

					game.enterHomeScene({
						taskEntryType = iter_2_1.taskEntryType
					})
				end
			})
			local var_2_12 = display.newSprite("uilocal/battle/battle_text_210.png", 63, 63)

			var_2_11:addChild(var_2_12)
			var_2_5:addChild(var_2_11)
		end
	end
end

function var_0_0.open(arg_6_0)
	arg_6_0.bgSprite:setVisible(true)
	arg_6_0.bgSprite:setScale(1)
	arg_6_0.bgSprite:setOpacity(120)

	local var_6_0 = CCArray:create()

	var_6_0:addObject(CCScaleBy:create(0.1, 1.1))
	var_6_0:addObject(CCScaleBy:create(0.1, 0.9))

	local var_6_1 = CCArray:create()

	var_6_1:addObject(CCFadeTo:create(0.2, 255))
	var_6_1:addObject(CCSequence:create(var_6_0))
	arg_6_0.bgSprite:runAction(CCSpawn:create(var_6_1))
end

function var_0_0.close(arg_7_0)
	local var_7_0 = CCArray:create()

	var_7_0:addObject(CCEaseBackIn:create(CCScaleTo:create(0.5, 0.4)))
	var_7_0:addObject(CCCallFunc:create(function(...)
		arg_7_0:removeFromParentAndCleanup(true)
	end))
	arg_7_0:runAction(CCSequence:create(var_7_0))
end

return var_0_0
