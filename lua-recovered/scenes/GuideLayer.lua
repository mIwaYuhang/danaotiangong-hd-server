require("network.PlayerRequest")

GuideLayer = class("GuideLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

function GuideLayer.ctor(arg_2_0)
	arg_2_0._touchRect = nil
	arg_2_0._curArrowType = TaskArrowDirType.eArrowDirDown
	arg_2_0._isShowingRewardLayer = nil
	arg_2_0._homeGuideLayer = nil
	arg_2_0._arrowSprite = display.newSprite("ui/common/common_104.png", 0, 0)

	arg_2_0._arrowSprite:setVisible(false)
	arg_2_0:addChild(arg_2_0._arrowSprite)

	arg_2_0._textSprite = display.newSprite("ui/common/common_102.png", 0, 0)

	arg_2_0._arrowSprite:addChild(arg_2_0._textSprite)

	arg_2_0.guideLable = addLabelWithColorSize(arg_2_0._textSprite, string.lf("请点击这里"), ccc3(0, 0, 0), 20, ccp(0.5, 0.5), ccp(70, 25))

	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			if arg_2_0._touchRect ~= nil and arg_2_0._touchRect:containsPoint(ccp(arg_3_1, arg_3_2)) then
				Player.currentTaskStep = Player.currentTaskStep + 1

				arg_2_0:hideArrow()
			end

			return true
		end
	end, false, 1, false)
	arg_2_0:setTouchEnabled(true)
end

function GuideLayer.showArrow(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 == nil then
		arg_4_2 = TaskArrowDirType.eArrowDirDown
	end

	local var_4_0 = TaskArrowRotationAngle[arg_4_2]

	arg_4_0._arrowSprite:setVisible(true)
	arg_4_0._arrowSprite:setPosition(arg_4_1)
	arg_4_0._arrowSprite:setRotation(var_4_0)
	arg_4_0:arrowAnimation(arg_4_2)
end

function GuideLayer.moveArrowTo(arg_5_0, arg_5_1, arg_5_2)
	print("GuideLayer:moveArrowTo")

	if arg_5_2 == nil then
		arg_5_2 = TaskArrowDirType.eArrowDirDown
	end

	arg_5_0._curArrowType = arg_5_2

	local var_5_0 = TaskArrowRotationAngle[arg_5_2]

	arg_5_0._arrowSprite:setVisible(true)
	arg_5_0._arrowSprite:stopAllActions()
	arg_5_0._textSprite:setVisible(false)

	local var_5_1, var_5_2 = arg_5_0._arrowSprite:getPosition()
	local var_5_3 = 0.00075 * ccpDistance(ccp(var_5_1, var_5_2), arg_5_1)
	local var_5_4 = CCArray:create()

	var_5_4:addObject(CCMoveTo:create(var_5_3, arg_5_1))
	var_5_4:addObject(CCRotateTo:create(var_5_3, var_5_0))

	local var_5_5 = CCArray:create()

	var_5_5:addObject(CCSpawn:create(var_5_4))
	var_5_5:addObject(CCCallFunc:create(handler(arg_5_0, arg_5_0.arrowAnimation)))
	arg_5_0._arrowSprite:runAction(CCSequence:create(var_5_5))
end

function GuideLayer.setTouchRect(arg_6_0)
	return
end

function GuideLayer.showHintText(arg_7_0, arg_7_1, arg_7_2)
	return
end

function GuideLayer.arrowAnimation(arg_8_0, arg_8_1)
	print("GuideLayer:arrowAnimation")

	if arg_8_1 == nil then
		arg_8_1 = arg_8_0._curArrowType
	end

	local var_8_0 = TaskTextSpritePos[arg_8_1]
	local var_8_1 = TaskArrowRotationAngle[arg_8_1]

	arg_8_0._arrowSprite:stopAllActions()
	arg_8_0._textSprite:setRotation(-var_8_1)
	arg_8_0._textSprite:setPosition(var_8_0)
	arg_8_0._textSprite:setVisible(true)

	local var_8_2 = 0
	local var_8_3 = 0

	if arg_8_1 == TaskArrowDirType.eArrowDirUp or arg_8_1 == TaskArrowDirType.eArrowDirDown then
		var_8_2, var_8_3 = 0, 20
	elseif arg_8_1 == TaskArrowDirType.eArrowDirLeft or arg_8_1 == TaskArrowDirType.eArrowDirRight then
		var_8_2, var_8_3 = 20, 0
	end

	local var_8_4 = CCArray:create()

	var_8_4:addObject(CCMoveBy:create(0.3, Adapter.MinPos(var_8_2, var_8_3)))
	var_8_4:addObject(CCMoveBy:create(0.3, Adapter.MinPos(-var_8_2, -var_8_3)))
	arg_8_0._arrowSprite:runAction(CCRepeatForever:create(CCSequence:create(var_8_4)))
end

function GuideLayer.hideArrow(arg_9_0)
	print("GuideLayer:hideArrow")
	arg_9_0._arrowSprite:stopAllActions()
	arg_9_0._arrowSprite:setVisible(false)
end

function GuideLayer.showHomeGuideLayer(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if TaskEntryData[Player.currentTaskEntryType] == nil then
		return
	end

	local var_10_0 = arg_10_2 or TaskEntryData[Player.currentTaskEntryType][Player.currentTaskStep].pos
	local var_10_1 = TaskEntryData[Player.currentTaskEntryType][Player.currentTaskStep].arrowType
	local var_10_2 = arg_10_1 or display.getRunningScene()
	local var_10_3

	if var_10_2.guideLayer ~= nil then
		var_10_3 = var_10_2.guideLayer

		var_10_2.guideLayer:showArrow(var_10_0, var_10_1)
	else
		var_10_3 = GuideLayer:new()

		var_10_3:showArrow(var_10_0, var_10_1)

		if arg_10_3 == true then
			var_10_3._arrowSprite:setScale(Adapter.MinScale)
		end

		var_10_2:addChild(var_10_3, 128)

		var_10_2.guideLayer = var_10_3
	end

	arg_10_0:stepDone(Player.currentTaskEntryType, 1)

	return var_10_3
end

function GuideLayer.showGuideLayer(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6)
	if GuideLayer._homeGuideLayer ~= nil then
		arg_11_0:removeHomeGuideLayer()
	end

	if arg_11_3 == Player.currentTaskEntryType then
		print("GuideLayer:showGuideLayer", Player.currentTaskEntryType, Player.currentTaskStep, arg_11_3, arg_11_4, Player.currentTaskStep)
	end

	if arg_11_3 ~= Player.currentTaskEntryType or arg_11_4 ~= Player.currentTaskStep then
		return nil
	end

	local var_11_0 = TaskEntryData[Player.currentTaskEntryType][Player.currentTaskStep].pos
	local var_11_1 = TaskEntryData[Player.currentTaskEntryType][Player.currentTaskStep].arrowType
	local var_11_2 = arg_11_1 or display.getRunningScene()

	print("GuideLayer:loadTask", var_11_0, var_11_1, var_11_2)

	if arg_11_5 ~= nil then
		var_11_0 = arg_11_5
	end

	if arg_11_2 ~= nil then
		var_11_0 = arg_11_2:convertToWorldSpace(var_11_0)
	end

	local var_11_3

	if var_11_2.guideLayer ~= nil then
		var_11_3 = var_11_2.guideLayer

		var_11_2.guideLayer:moveArrowTo(var_11_0, var_11_1)
	else
		var_11_3 = GuideLayer:new()

		var_11_3:showArrow(var_11_0, var_11_1)
		var_11_2:addChild(var_11_3, 128)

		if arg_11_6 == true then
			var_11_3._arrowSprite:setScale(Adapter.MinScale)
		end

		var_11_2.guideLayer = var_11_3
	end

	var_11_3.guideLable:setString(string.lf("请点击这里"))

	return var_11_3
end

function GuideLayer.removeGuideLayer(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_2 == Player.currentTaskEntryType then
		print("GuideLayer:removeGuideLayer", Player.currentTaskEntryType, Player.currentTaskStep, arg_12_2, arg_12_3)
	end

	if arg_12_2 ~= Player.currentTaskEntryType or arg_12_3 ~= Player.currentTaskStep then
		return nil
	end

	local var_12_0 = arg_12_1 or display.getRunningScene()

	print("removeLayer")

	if var_12_0.guideLayer ~= nil then
		print("do removeLayer")
		var_12_0.guideLayer:removeFromParentAndCleanup(true)

		var_12_0.guideLayer = nil
	end
end

function GuideLayer.hideGuideLayer(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_2 == Player.currentTaskEntryType then
		print("GuideLayer:hideGuideLayer", Player.currentTaskEntryType, Player.currentTaskStep, arg_13_2, arg_13_3)
	end

	if arg_13_2 ~= Player.currentTaskEntryType or arg_13_3 ~= Player.currentTaskStep then
		return nil
	end

	local var_13_0 = arg_13_1 or display.getRunningScene()

	if var_13_0.guideLayer ~= nil then
		var_13_0.guideLayer:hideArrow()
	end
end

function GuideLayer.hideGuideLayerIfStepGreaterThan(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == Player.currentTaskEntryType and arg_14_2 < Player.currentTaskStep then
		print("GuideLayer:hideGuideLayerIfStepGreaterThan", Player.currentTaskEntryType, Player.currentTaskStep, arg_14_1, arg_14_2)

		local var_14_0 = display.getRunningScene()

		if var_14_0.guideLayer ~= nil then
			var_14_0.guideLayer:hideArrow()
		end
	end
end

function GuideLayer.removeGuideLayerIfStepGreaterThan(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == Player.currentTaskEntryType then
		print("GuideLayer:removeGuideLayerIfStepGreaterThan", Player.currentTaskEntryType, Player.currentTaskStep, arg_15_1, arg_15_2)
	end

	if arg_15_1 == Player.currentTaskEntryType and arg_15_2 < Player.currentTaskStep then
		local var_15_0 = display.getRunningScene()

		if var_15_0.guideLayer ~= nil then
			var_15_0.guideLayer:removeFromParentAndCleanup(true)

			var_15_0.guideLayer = nil
		end
	end
end

function GuideLayer.rollbackStepTo(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == Player.currentTaskEntryType and Player.currentTaskStep ~= 0 then
		Player.currentTaskStep = arg_16_2
	end
end

function GuideLayer.stepDone(arg_17_0, arg_17_1, arg_17_2)
	print("GuideLayer StepDone:", arg_17_1, Player.currentTaskEntryType, arg_17_2, Player.currentTaskStep)

	if arg_17_1 == Player.currentTaskEntryType and Player.currentTaskStep == arg_17_2 then
		Player.currentTaskStep = arg_17_2 + 1
	end
end

function GuideLayer.showMissionReward(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if arg_18_4 == nil then
		arg_18_4 = 0
	end

	local var_18_0

	for iter_18_0 = #Player.missionData, 1, -1 do
		local var_18_1 = Player.missionData[iter_18_0]
		local var_18_2 = true

		if arg_18_2 ~= nil then
			var_18_2 = arg_18_2 == var_18_1.type
		end

		local var_18_3 = true

		if arg_18_3 ~= nil then
			var_18_3 = arg_18_3 == var_18_1.location.Type
		end

		if var_18_2 and var_18_3 and var_18_1.state == TaskStatus.eCompleted and TaskDisplayType[var_18_1.location.Type] == arg_18_4 and var_18_1.hashasDisplayed == nil then
			var_18_0 = var_18_1

			break
		end
	end

	if var_18_0 and var_18_0.hashasDisplayed == true then
		var_18_0 = nil
	end

	if var_18_0 and var_18_0.hashasDisplayed == nil then
		var_18_0.hashasDisplayed = true
	end

	local var_18_4 = arg_18_1 or display.getRunningScene()

	if var_18_0 ~= nil then
		local var_18_5 = require("scenes.system.TaskRewardLayer").new({
			missionItem = var_18_0
		})

		var_18_4:addChild(var_18_5, DefaultZOrder.eTaskReward)
	end

	return var_18_0
end

function GuideLayer.removeHomeGuideLayer(arg_19_0)
	if GuideLayer._homeGuideLayer and GuideLayer._homeGuideLayer.guideLayer ~= nil then
		GuideLayer._homeGuideLayer.guideLayer:removeFromParentAndCleanup(true)

		GuideLayer._homeGuideLayer.guideLayer = nil
		GuideLayer._homeGuideLayer = nil
	end
end

function GuideLayer.removeOneGuideLayer(arg_20_0, arg_20_1)
	if arg_20_1 == Player.currentTaskEntryType then
		print("GuideLayer:removeOneGuideLayer")

		Player.currentTaskEntryType = 0
		Player.currentTaskStep = 0

		local var_20_0 = display.getRunningScene()

		if var_20_0.guideLayer ~= nil then
			var_20_0.guideLayer:removeFromParentAndCleanup(true)

			var_20_0.guideLayer = nil
		end
	end
end

function GuideLayer.removeAllGuideLayer(arg_21_0)
	local var_21_0 = display.getRunningScene()

	Player.currentTaskEntryType = 0
	Player.currentTaskStep = 0
	Player.currentMissionStageID = nil

	if var_21_0.guideLayer ~= nil then
		var_21_0.guideLayer:removeFromParentAndCleanup(true)

		var_21_0.guideLayer = nil
	end
end

function GuideLayer.showNewbieGuideLayer(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6, arg_22_7)
	print("GuideLayer:showNewbieGuideLayer", arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6, arg_22_7)

	local var_22_0 = arg_22_1 or display.getRunningScene()
	local var_22_1 = NewbieTaskData[arg_22_3]

	if var_22_1 == nil then
		return
	end

	arg_22_5 = arg_22_5 or var_22_1.arrowPos

	if arg_22_2 ~= nil then
		arg_22_5 = arg_22_2:convertToWorldSpace(arg_22_5)
	end

	if var_22_0.newbieGuideLayer ~= nil then
		var_22_0.newbieGuideLayer:removeFromParent()

		var_22_0.newbieGuideLayer = nil

		print("runningScene.newbieGuideLayer:removeFromParent   in showNewbieGuideLayer")
	end

	local var_22_2 = require("scenes.NewbieGuideLayer").new({
		buttonPos = arg_22_5,
		buttonSize = var_22_1.buttonSize,
		callback = arg_22_4,
		arrowType = var_22_1.arrowType,
		noBackground = arg_22_6
	})

	if arg_22_7 == nil then
		var_22_2:showGuideLayer(var_22_1.textPos, var_22_1.text)
	end

	var_22_0.newbieGuideLayer = var_22_2

	var_22_0:addChild(var_22_2, 10)

	return var_22_2
end

function GuideLayer.createNetworkRequest(arg_23_0)
	local function var_23_0()
		if arg_23_0.tioMaxStepCallback then
			arg_23_0.tioMaxStepCallback()
		else
			game.enterHomeScene()
		end
	end

	local function var_23_1(arg_25_0)
		return
	end

	arg_23_0.trioMaxStepRequest = TrioMaxStepRequest:new()

	arg_23_0.trioMaxStepRequest:setResponseNormalHandler(var_23_0)
	arg_23_0.trioMaxStepRequest:setResponseExceptionHandler(var_23_1)
end

function GuideLayer.saveTrioMaxStep(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0.tioMaxStepCallback = arg_26_2

	if arg_26_0.trioMaxStepRequest == nil then
		arg_26_0:createNetworkRequest()
	end

	arg_26_0.trioMaxStepRequest:requestSetTrioMaxStep(arg_26_1)
	Player:setTroMaxStep(arg_26_1)
end

function GuideLayer.reloadPlayerTeam(arg_27_0, arg_27_1)
	local function var_27_0()
		local var_28_0 = arg_27_0.teamRequest:getPlayerTeamAndPartnerTeam()

		Player:setTeam(var_28_0)
		arg_27_1()
	end

	arg_27_0.teamRequest = PlayerTeamRequest:new()

	arg_27_0.teamRequest:setResponseNormalHandler(var_27_0)
	arg_27_0.teamRequest:request(Player.userId)
end
