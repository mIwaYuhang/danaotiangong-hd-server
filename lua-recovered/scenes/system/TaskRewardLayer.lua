local var_0_0 = class("TaskRewardLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	GuideLayer._isShowingRewardLayer = true

	arg_2_0:initNetworkInterface()
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, -1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0._missionItem = arg_2_1.missionItem

	local var_2_0 = display.newColorLayer(ccc4(0, 0, 0, 128))

	arg_2_0:addChild(var_2_0)

	arg_2_0._rewardDisplayHeight = math.floor(#arg_2_0._missionItem.missionReward / 2) * 30
	arg_2_0._bgSprite = display.newScale9Sprite("ui/common/common_050.png", display.cx, display.cy, Adapter.MinSize(460, 250 + arg_2_0._rewardDisplayHeight))
	arg_2_0._backNodeSize = arg_2_0._bgSprite:getContentSize()

	arg_2_0:addChild(arg_2_0._bgSprite)
	arg_2_0:initUI()
	arg_2_0:appearAnimation()
	GuideLayer:removeAllGuideLayer()
	arg_2_0:setNodeEventEnabled(true)
end

function var_0_0.onExit(arg_4_0)
	print("TaskRewardLayer:onExit")

	GuideLayer._isShowingRewardLayer = nil
end

function var_0_0.initUI(arg_5_0)
	local var_5_0 = display.newSprite("uilocal/task/task_text_003.png", arg_5_0._backNodeSize.width / 2, arg_5_0._backNodeSize.height)

	var_5_0:setScale(Adapter.MinScale)
	arg_5_0._bgSprite:addChild(var_5_0)

	local var_5_1 = "【" .. TaskTypeNames[arg_5_0._missionItem.type] .. "】" .. arg_5_0._missionItem.name

	addLabelWithColorSize(arg_5_0._bgSprite, var_5_1, ccc3(249, 247, 196), 25, ccp(0.5, 0.5), ccp(arg_5_0._backNodeSize.width / 2, arg_5_0._backNodeSize.height - 60 * Adapter.MinScale))
	addLabelWithColorSize(arg_5_0._bgSprite, string.lf("要求："), ccc3(211, 211, 89), 20, ccp(0, 0.5), ccp(30 * Adapter.MinScale, arg_5_0._backNodeSize.height - 100 * Adapter.MinScale))

	local var_5_2 = addLabelWithColorSize(arg_5_0._bgSprite, arg_5_0._missionItem.description, ccc3(211, 211, 89), 20, ccp(0, 1), ccp(100 * Adapter.MinScale, arg_5_0._backNodeSize.height - 86 * Adapter.MinScale))

	var_5_2:setDimensions(CCSize(350, 60))
	var_5_2:setHorizontalAlignment(kCCTextAlignmentLeft)
	addLabelWithColorSize(arg_5_0._bgSprite, string.lf("奖励："), ccc3(211, 211, 89), 20, ccp(0, 0.5), ccp(30 * Adapter.MinScale, arg_5_0._backNodeSize.height - 150 * Adapter.MinScale))

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._missionItem.missionReward) do
		local var_5_3 = math.ceil(iter_5_0 / 2) - 1
		local var_5_4 = (iter_5_0 - 1) % 4
		local var_5_5 = 140 * Adapter.MinScale + var_5_4 * 90 * Adapter.MinScale
		local var_5_6 = arg_5_0._backNodeSize.height - 170 * Adapter.MinScale - var_5_3 * 30 * Adapter.MinScale
		local var_5_7 = {
			type = iter_5_1.Type,
			itemId = iter_5_1.ID or 0,
			nameColor = ccc3(239, 232, 195),
			count = iter_5_1.Count
		}
		local var_5_8 = figure.createHeader(var_5_7)

		var_5_8:setAnchorPoint(CCPoint(0.5, 0.5))
		var_5_8:setPosition(var_5_5, var_5_6)
		var_5_8:setScale(0.9 * Adapter.MinScale)
		arg_5_0._bgSprite:addChild(var_5_8)
	end

	local var_5_9 = ui.newControlButton({
		highlightedImage = "ui/common/common_105.png",
		titleImage = "uilocal/store/store_text_023.png",
		normalImage = "ui/common/common_105.png",
		clickAction = function()
			arg_5_0:removeFromParent()
		end,
		anchorPoint = CCPoint(0.5, 0.5),
		scaleX = Adapter.MinScale,
		scaleY = Adapter.MinScale,
		position = CCPoint(arg_5_0._backNodeSize.width / 2, 5)
	})

	arg_5_0._bgSprite:addChild(var_5_9)
end

function var_0_0.initNetworkInterface(arg_7_0)
	local function var_7_0()
		Player:deleteCompletedMission(arg_7_0._missionItem.missionID)
		arg_7_0:removeFromParentAndCleanup(true)
	end

	local function var_7_1(arg_9_0)
		local var_9_0 = {
			[-1133001] = string.lf("玩家任务未完成"),
			[-1133002] = string.lf("玩家任务奖励已领取")
		}

		showFlashNotice(var_9_0[arg_9_0])
		arg_7_0:removeFromParentAndCleanup(true)
	end

	arg_7_0.missionRewardRequest = MissionRewardRequest:new()

	arg_7_0.missionRewardRequest:setResponseNormalHandler(var_7_0)
	arg_7_0.missionRewardRequest:setResponseExceptionHandler(var_7_1)
end

function var_0_0.appearAnimation(arg_10_0)
	arg_10_0._bgSprite:setScale(1)
	arg_10_0._bgSprite:setOpacity(120)

	local var_10_0 = CCArray:create()

	var_10_0:addObject(CCScaleBy:create(0.1, 1.1))
	var_10_0:addObject(CCScaleBy:create(0.1, 0.9))

	local var_10_1 = CCArray:create()

	var_10_1:addObject(CCFadeTo:create(0.2, 255))
	var_10_1:addObject(CCSequence:create(var_10_0))
	arg_10_0._bgSprite:runAction(CCSpawn:create(var_10_1))
end

function var_0_0.appearAnimation2(arg_11_0)
	arg_11_0._bgSprite:setPosition(ccp(display.cx, display.height + display.cy))

	local var_11_0 = CCArray:create()

	var_11_0:addObject(CCMoveTo:create(0.1, ccp(display.cx, display.cy)))
	arg_11_0._bgSprite:runAction(CCSequence:create(var_11_0))
end

return var_0_0
