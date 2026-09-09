require("data.fuben")
require("network.FubenRequest")
require("scenes.battle.BattleData")
require("scenes.battle.BattleSkeleton")

local var_0_0 = class("FubenIndexScene", function()
	return display.newScene("FubenIndexScene")
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0._copyInfoList = arg_2_1.copyInfoList
	arg_2_0._curCopyID = arg_2_1.curCopyID
	arg_2_0.haveKeys = arg_2_1.haveKeys or 0

	arg_2_0:createTouchEventLayer()
	arg_2_0:createNetworkInterface()

	arg_2_0.isFlareDisplay = false

	local var_2_0 = display.newSprite("ui/fuben/fuben_001.jpg")

	var_2_0:align(display.BOTTOM_CENTER, display.cx, 0)
	var_2_0:setScaleX(Adapter.AutoScaleX)
	var_2_0:setScaleY(Adapter.AutoScaleY)
	arg_2_0:addChild(var_2_0)

	local var_2_1 = require("scenes.CommonBgLayer").new({
		closeButtonNormalImage = "ui/common/common_061.png",
		isHideBgSprite = true,
		closeButtonPosition = ccp(880000, 600)
	})

	arg_2_0:addChild(var_2_1)

	arg_2_0._bgUISprite = var_2_1:getBackgroundSprite()

	addCloseButton(arg_2_0, arg_2_1.returnAction or function()
		game.enterHomeScene({
			showSubLayer = ShowSubLayerType.eCopyHome
		})
	end)
	GuideLayer:stepDone(TaskEntryType.eEntryCopy, 2)
	arg_2_0:initUI()
end

function var_0_0.onEnter(arg_4_0)
	if arg_4_0._copyInfoList == nil then
		arg_4_0._copyInfoList = {}

		arg_4_0.copyInfoRequest:request()
	end

	arg_4_0:refreshCopyInfo()
end

function var_0_0.showFubenProgress(arg_5_0, arg_5_1)
	local function var_5_0()
		if arg_5_0._copyInfoList[arg_5_1] == nil then
			arg_5_0._enterFubenButton:setEnabled(false)
		else
			arg_5_0._enterFubenButton:setEnabled(true)
		end

		arg_5_0._circleLayer:reloadLayer(arg_5_1)
		arg_5_0.progressLayer:removeFromParent()

		arg_5_0.progressLayer = nil

		GuideLayer:showMissionReward(arg_5_0, TaskType.eTaskTeaching, TaskEntryType.eEntryCopy, 1)
	end

	arg_5_0.progressLayer = require("scenes.fuben.FubenProgressLayer").new({
		copyInfoList = arg_5_0._copyInfoList,
		curCopyID = arg_5_1,
		haveKeys = arg_5_0.haveKeys,
		closeCallback = var_5_0
	})

	arg_5_0:addChild(arg_5_0.progressLayer)
	arg_5_0.progressLayer:setVisible(false)

	local var_5_1 = BattleSkeleton:addEffect({
		effectName = "ui_fuben",
		speed = 1,
		animation = "ui_zhandoukaichang_donghua",
		parent = arg_5_0,
		position = ccp(display.cx, display.cy),
		callbacklist = {
			function()
				arg_5_0.progressLayer:setVisible(true)
			end,
			0.2,
			AAT_Percent
		}
	})

	var_5_1:setScaleX(Adapter.AutoScaleX)
	var_5_1:setScaleY(Adapter.AutoScaleY)
end

function var_0_0.initUI(arg_8_0)
	local var_8_0 = display.newSprite("uilocal/fuben/fuben_text_002.png", 110, 585)

	arg_8_0._bgUISprite:addChild(var_8_0)

	local var_8_1 = display.newSprite("ui/fuben/fuben_009.png", 197, 597)

	arg_8_0._bgUISprite:addChild(var_8_1)

	local var_8_2 = display.newSprite("uilocal/fuben/fuben_text_001.png", 154, 533)

	arg_8_0._bgUISprite:addChild(var_8_2)

	local var_8_3 = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		highlightedImage = "ui/common/common_019.png",
		text = string.lf("掉落预览"),
		fontSize = ColorTable.eTitleButton_FontSize2,
		textColor = ColorTable.eTitleButton_Normal2,
		anchorPoint = ccp(0.5, 0.5),
		position = ccp(110, -40),
		clickAction = function()
			local var_9_0 = require("scenes.fuben.FubenRewardPreviewLayer").new()

			arg_8_0:addChild(var_9_0)
		end
	})

	var_8_2:addChild(var_8_3)

	arg_8_0._circleLayer = require("scenes.CircleLayer").new({
		totalItemNum = 12,
		unlockItemNum = 1,
		longAxias = 410,
		rotateLayerCallback = function(arg_10_0)
			return
		end,
		noneRotateLayerCallback = function(arg_11_0)
			local var_11_0 = display.newSprite("ui/fuben/fuben_001.png")

			arg_11_0:addChild(var_11_0)

			arg_8_0.frameSprite1 = display.newSprite("ui/fuben/fuben_027.png")

			arg_8_0.frameSprite1:setRotation(30)
			arg_11_0:addChild(arg_8_0.frameSprite1)

			arg_8_0.frameSprite2 = display.newSprite("ui/fuben/fuben_028.png")

			arg_11_0:addChild(arg_8_0.frameSprite2)

			arg_8_0.frameSprite3 = display.newSprite("ui/fuben/fuben_029.png")

			arg_8_0.frameSprite3:setRotation(-30)
			arg_11_0:addChild(arg_8_0.frameSprite3)
		end,
		itemContentCallback = function(arg_12_0, arg_12_1)
			arg_8_0:showCopyItemDetail(arg_12_0, arg_12_1)
		end,
		alignCallback = function(arg_13_0)
			if arg_8_0.isFlareDisplay == false then
				arg_8_0:flareAppearAnimation()
			end
		end
	})

	arg_8_0._circleLayer:setPosition(ccp(display.cx - (display.width - 960) / 2, 0))
	arg_8_0._bgUISprite:addChild(arg_8_0._circleLayer)

	arg_8_0._flareSprite = display.newSprite("ui/fuben/fuben_006.png", 0, 386)

	arg_8_0._circleLayer:addChild(arg_8_0._flareSprite)

	arg_8_0._particleEffect = createParticle("ui/common/fuben_open.plist", ccp(110, 250), arg_8_0._flareSprite)
	arg_8_0._fubeDetailSprite = display.newSprite("ui/fuben/fuben_007.png", 759, 480)

	arg_8_0._fubeDetailSprite:setOpacity(0)
	arg_8_0._bgUISprite:addChild(arg_8_0._fubeDetailSprite)

	local var_8_4 = display.newSprite("ui/fuben/fuben_005.png", display.cx, 17 * Adapter.MinScale)

	var_8_4:setScale(Adapter.MinScale)
	arg_8_0:addChild(var_8_4)

	local function var_8_5()
		GuideLayer:stepDone(TaskEntryType.eEntryCopy, 3)

		local var_14_0 = arg_8_0._circleLayer:getCurrentItemIndex()

		if arg_8_0._copyInfoList and arg_8_0._copyInfoList[var_14_0].IsComplete ~= 1 then
			arg_8_0:playBackgroundAlignAnimation()

			return
		end

		if arg_8_0.haveKeys > 0 then
			GuideLayer:removeAllGuideLayer()
			ui.showMessageBox({
				text = string.lf("是否消耗一颗元辰石进入该生肖殿?"),
				action1 = function()
					arg_8_0.openCopyRequest:request(var_14_0)
				end,
				title1 = string.lf("确定"),
				title2 = string.lf("取消")
			})
		else
			local var_14_1 = require("scenes.toollayer.tool")

			if Player:getItemCount(ItemType.eProp, var_14_1.tokenId(PropType.eFuBenJieSuo)) > 0 then
				local var_14_2 = require("scenes.ToolLayer")

				var_14_2.createDialog({
					show = var_14_2.eShowFuBenJieSuo,
					callback = function(arg_16_0, arg_16_1)
						if arg_16_0 then
							arg_8_0.openCopyRequest:request(var_14_0)
						end
					end
				}):show()
			else
				showFlashNotice(string.lf("没有元辰石了，每天晚上12点重置"))
			end
		end
	end

	arg_8_0._enterFubenButton = ui.newControlButton({
		fontSize = 25,
		normalImage = "ui/common/common_027_2.png",
		clickAction = var_8_5,
		text = string.lf("开始挑战"),
		textColor = ccc3(253, 251, 126)
	})

	arg_8_0._enterFubenButton:setTitleForState(CCString:create(string.lf("未解锁")), CCControlStateDisabled)
	arg_8_0._enterFubenButton:setTitleColorForState(ccc3(206, 206, 206), CCControlStateDisabled)
	arg_8_0._enterFubenButton:setPosition(0, 180)
	arg_8_0._circleLayer:addChild(arg_8_0._enterFubenButton)

	local var_8_6 = display.newSprite("ui/fuben/fuben_30.png", display.cx, 40 * Adapter.MinScale)

	var_8_6:setScale(Adapter.MinScale)
	arg_8_0:addChild(var_8_6)

	arg_8_0.bottomStarSprite = display.newSprite("ui/fuben/fuben_31.png", display.cx, 40 * Adapter.MinScale)

	arg_8_0.bottomStarSprite:setScale(Adapter.MinScale)
	arg_8_0:addChild(arg_8_0.bottomStarSprite)
	arg_8_0.bottomStarSprite:setVisible(false)

	arg_8_0.flashStarSprite = display.newSprite("ui/fuben/fuben_32.png", display.cx, 40 * Adapter.MinScale)

	arg_8_0.flashStarSprite:setScale(Adapter.MinScale)
	arg_8_0:addChild(arg_8_0.flashStarSprite)
	arg_8_0.flashStarSprite:setOpacity(0)
end

function var_0_0.showCopyItemDetail(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = 0

	if arg_17_0._circleLayer ~= nil then
		var_17_0 = arg_17_0._circleLayer:getCurrentItemIndex()
	end

	local var_17_1 = display.newSprite("ui/fuben/fuben_004.png", 0, 0)

	arg_17_1:addChild(var_17_1)

	local function var_17_2(arg_18_0, arg_18_1)
		local var_18_0 = arg_18_1.tag

		var_17_0 = arg_17_0._circleLayer:getCurrentItemIndex()

		if var_18_0 ~= var_17_0 then
			arg_17_0._circleLayer:moveToIndexItem(var_18_0, true)
		end

		if arg_17_0.isFlareDisplay and var_18_0 ~= var_17_0 then
			arg_17_0:flareDisappearAnimation()
		end
	end

	local var_17_3 = "ui/fuben/" .. FubenData[arg_17_2].headImage

	if arg_17_0._copyInfoList and arg_17_0._copyInfoList[arg_17_2] == nil then
		var_17_3 = "ui/fuben/" .. FubenData[arg_17_2].headImageGray
	end

	local var_17_4 = ui.newControlButton({
		text = "",
		normalImage = var_17_3,
		clickAction = var_17_2,
		position = ccp(60, 60)
	})

	var_17_4.tag = arg_17_2

	var_17_1:addChild(var_17_4)

	if arg_17_0._copyInfoList and arg_17_0._copyInfoList[arg_17_2] == nil then
		local var_17_5 = display.newSprite("ui/fuben/fuben_025.png", 43, 43)

		var_17_4:addChild(var_17_5)
		arg_17_0:setTheStoneStatus(false)
	elseif arg_17_0._copyInfoList and arg_17_0._copyInfoList[arg_17_2] and arg_17_0._copyInfoList[arg_17_2].IsComplete ~= 1 then
		display.addSpriteFramesWithFile("ui/map/icon_engagement.plist", "ui/map/icon_engagement.png")

		local var_17_6 = display.newSprite("#icon_engagement1.png")
		local var_17_7 = display.newFrames("icon_engagement%d.png", 1, 3)
		local var_17_8 = display.newAnimation(var_17_7, 0.3333333333333333)

		var_17_6:runAction(CCRepeatForever:create(CCAnimate:create(var_17_8)))
		var_17_6:setPosition(43, 43)
		var_17_4:addChild(var_17_6)
		arg_17_0:setTheStoneStatus(true)

		if arg_17_0._enterFubenButton then
			arg_17_0._enterFubenButton:setEnabled(true)
		end
	else
		arg_17_0:setTheStoneStatus(false)
	end

	local var_17_9 = ccc3(255, 255, 255)

	if var_17_0 == arg_17_2 then
		var_17_9 = ccc3(255, 255, 0)
	end

	addLabelWithColorSize(arg_17_1, FubenData[arg_17_2].name, var_17_9, 25, ccp(0.5, 0.5), ccp(0, -65))
end

function var_0_0.createTouchEventLayer(arg_19_0)
	local var_19_0 = display.newLayer()
	local var_19_1 = {
		x = 0,
		y = 0
	}
	local var_19_2 = {
		x = 0,
		y = 0
	}

	local function var_19_3(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_0 == "began" then
			var_19_1.x = arg_20_1
			var_19_1.y = arg_20_2
			var_19_2.x = arg_20_1
			var_19_2.y = arg_20_2

			return true
		elseif arg_20_0 == "moved" then
			local var_20_0 = arg_20_1 - var_19_1.x

			var_19_1.x = arg_20_1
			var_19_1.y = arg_20_2

			if var_20_0 > 0 then
				arg_19_0._circleLayer:setRadiansOffset(0.6)
			end

			if var_20_0 < 0 then
				arg_19_0._circleLayer:setRadiansOffset(-0.6)
			end

			if arg_19_0.isFlareDisplay then
				arg_19_0:flareDisappearAnimation()
			end
		elseif arg_20_0 == "ended" or arg_20_0 == "cancelled" then
			local var_20_1 = arg_20_1 - var_19_2.x

			if var_20_1 > 20 then
				arg_19_0._circleLayer:moveToPreviousItem()

				return
			end

			if var_20_1 < -20 then
				arg_19_0._circleLayer:moveToNextItem()

				return
			end

			arg_19_0._circleLayer:alignTheLayer(true)
		end
	end

	var_19_0:addTouchEventListener(var_19_3, false, 1, false)
	var_19_0:setTouchEnabled(true)
	arg_19_0:addChild(var_19_0)
end

function var_0_0.flareAppearAnimation(arg_21_0)
	arg_21_0._flareSprite:setOpacity(0)
	arg_21_0._flareSprite:stopAllActions()
	arg_21_0._flareSprite:setScaleX(0.2)

	local var_21_0 = arg_21_0._circleLayer:getCurrentItemIndex()

	if arg_21_0._copyInfoList[var_21_0] == nil then
		arg_21_0._enterFubenButton:setEnabled(false)
	else
		arg_21_0._enterFubenButton:setEnabled(true)
	end

	local var_21_1 = CCArray:create()

	var_21_1:addObject(CCFadeTo:create(0.2, 255))
	var_21_1:addObject(CCScaleTo:create(0.2, 1))

	local var_21_2 = CCSpawn:create(var_21_1)
	local var_21_3 = CCCallFunc:create(handler(arg_21_0, arg_21_0.flareAppearCallback))
	local var_21_4 = CCArray:create()

	var_21_4:addObject(var_21_2)
	var_21_4:addObject(var_21_3)
	arg_21_0._flareSprite:runAction(CCSequence:create(var_21_4))

	arg_21_0.isFlareDisplay = true
end

function var_0_0.flareDisappearAnimation(arg_22_0)
	arg_22_0._particleEffect:setVisible(false)
	arg_22_0._fubeDetailSprite:removeAllChildrenWithCleanup(true)
	arg_22_0._fubeDetailSprite:runAction(CCFadeTo:create(0.2, 0))
	arg_22_0._flareSprite:setOpacity(255)
	arg_22_0._flareSprite:stopAllActions()
	arg_22_0._flareSprite:setScaleX(1)

	local var_22_0 = CCArray:create()

	var_22_0:addObject(CCFadeTo:create(0.2, 0))
	var_22_0:addObject(CCScaleTo:create(0.2, 0.2, 1))

	local var_22_1 = CCSpawn:create(var_22_0)
	local var_22_2 = CCCallFunc:create(handler(arg_22_0, arg_22_0.flareDisappearCallback))
	local var_22_3 = CCArray:create()

	var_22_3:addObject(var_22_1)
	var_22_3:addObject(var_22_2)
	arg_22_0._flareSprite:runAction(CCSequence:create(var_22_3))

	arg_22_0.isFlareDisplay = false
end

function var_0_0.flareAppearCallback(arg_23_0)
	if arg_23_0._copyInfoList == nil then
		return
	end

	local var_23_0 = arg_23_0._circleLayer:getCurrentItemIndex()

	arg_23_0._particleEffect:setVisible(true)

	local var_23_1 = display.newSprite("ui/fuben/fuben_008.png", 82, 82)

	arg_23_0._fubeDetailSprite:addChild(var_23_1)

	local var_23_2 = "ui/fuben/" .. FubenData[var_23_0].headImage
	local var_23_3 = display.newSprite(var_23_2, 45, 58)

	var_23_1:addChild(var_23_3)

	local var_23_4 = display.newSprite("ui/fuben/fuben_010.png", 165, 131)

	arg_23_0._fubeDetailSprite:addChild(var_23_4)
	addLabelWithColorSize(var_23_4, FubenData[var_23_0].name, ccc3(255, 235, 190), 18, ccp(0.5, 0.5), ccp(20, 11), _FONT_LISU)
	addLabelWithColorSize(arg_23_0._fubeDetailSprite, FubenData[var_23_0].bossName, ccc3(255, 235, 254), 25, ccp(0.5, 0.5), ccp(250, 131), _FONT_LISU)

	if arg_23_0._copyInfoList and arg_23_0._copyInfoList[var_23_0] == nil then
		local var_23_5 = FubenData[var_23_0].unlockLevel

		addLabelWithColorSize(arg_23_0._fubeDetailSprite, string.lf("{#FFFF00%s#FF0000级解锁}", tostring(var_23_5)), ccc3(255, 0, 0), 22, ccp(0, 0.5), ccp(135, 89))

		local var_23_6 = display.newSprite("ui/fuben/fuben_025.png", 43, 43)

		var_23_3:addChild(var_23_6)
	else
		addLabelWithColorSize(arg_23_0._fubeDetailSprite, string.lf("{击败BOSS后可得}"), ccc3(36, 237, 254), 22, ccp(0, 0.5), ccp(135, 89))
	end

	local var_23_7 = addLabelWithColorSize(arg_23_0._fubeDetailSprite, FubenData[var_23_0].dropDesc, ccc3(222, 219, 169), 20, ccp(0, 1), ccp(135, 70), _FONT_LISU)

	var_23_7:setHorizontalAlignment(kCCTextAlignmentLeft)
	var_23_7:setDimensions(CCSize(225, 60))
	arg_23_0._fubeDetailSprite:runAction(CCFadeTo:create(0.2, 255))

	if Player.currentMissionStageID == var_23_0 then
		GuideLayer:showGuideLayer(arg_23_0, arg_23_0._bgUISprite, TaskEntryType.eEntryCopy, 3, nil, true)
	else
		GuideLayer:hideGuideLayerIfStepGreaterThan(TaskEntryType.eEntryCopy, 2)
	end
end

function var_0_0.flareDisappearCallback(arg_24_0)
	return
end

function var_0_0.refreshCopyInfo(arg_25_0)
	arg_25_0:refreshKeyNode()
	print("refreshCopyInfo :: 刷新副本信息")
	arg_25_0._circleLayer:setLockItems(12)

	for iter_25_0, iter_25_1 in ipairs(arg_25_0._copyInfoList) do
		if iter_25_1.OpenCardReward ~= nil and iter_25_1.RoundID == nil then
			arg_25_0._curCopyID = iter_25_0

			break
		end
	end

	local var_25_0 = 1

	for iter_25_2, iter_25_3 in ipairs(arg_25_0._copyInfoList) do
		if iter_25_3.RoundID ~= 0 then
			var_25_0 = iter_25_2

			break
		end
	end

	if Player.currentTaskEntryType == TaskEntryType.eEntryCopy then
		local var_25_1 = Player.currentMissionStageID

		if var_25_1 == 0 then
			var_25_1 = 1
		end

		arg_25_0._circleLayer:moveToIndexItem(var_25_1, true)
	else
		arg_25_0._circleLayer:moveToIndexItem(arg_25_0._curCopyID or var_25_0, true)
	end

	if arg_25_0._curCopyID ~= nil then
		arg_25_0:showFubenProgress(arg_25_0._curCopyID)
	end

	if arg_25_0._copyInfoList[arg_25_0._curCopyID or 1] == nil then
		arg_25_0._enterFubenButton:setEnabled(false)
	else
		arg_25_0._enterFubenButton:setEnabled(true)
	end

	arg_25_0._circleLayer:reloadLayer()
end

function var_0_0.createNetworkInterface(arg_26_0)
	arg_26_0.copyInfoRequest = PlayerCopyInfoRequest:new(arg_26_0)

	local function var_26_0()
		local var_27_0 = arg_26_0.copyInfoRequest:getCopyInfo()

		arg_26_0.haveKeys = var_27_0.Key
		arg_26_0._copyInfoList = var_27_0.Copys

		arg_26_0:refreshCopyInfo()
	end

	local function var_26_1(arg_28_0)
		print("responseCopyInfoRequestFail")
	end

	arg_26_0.copyInfoRequest:setResponseNormalHandler(var_26_0)
	arg_26_0.copyInfoRequest:setResponseExceptionHandler(var_26_1)

	arg_26_0.openCopyRequest = OpenCopyRequest:new(arg_26_0)

	local function var_26_2()
		local var_29_0 = arg_26_0.openCopyRequest:getRewardInfo()
		local var_29_1 = arg_26_0._circleLayer:getCurrentItemIndex()

		arg_26_0._copyInfoList[var_29_1] = var_29_0
		arg_26_0.haveKeys = arg_26_0.haveKeys - 1

		arg_26_0:letTheStarFly()
	end

	local function var_26_3(arg_30_0)
		print("responseOpenCopyRequestFail")
	end

	arg_26_0.openCopyRequest:setResponseNormalHandler(var_26_2)
	arg_26_0.openCopyRequest:setResponseExceptionHandler(var_26_3)
end

function var_0_0.playBackgroundAlignAnimation(arg_31_0)
	local var_31_0 = 0.9

	arg_31_0.frameSprite1:runAction(CCRotateBy:create(var_31_0, -90))
	arg_31_0.frameSprite3:runAction(CCRotateBy:create(var_31_0, 90))
	arg_31_0._enterFubenButton:setEnabled(false)

	local function var_31_1()
		local var_32_0 = arg_31_0._circleLayer:getCurrentItemIndex()

		arg_31_0:showFubenProgress(var_32_0)
		arg_31_0._enterFubenButton:setEnabled(true)
	end

	local var_31_2 = CCArray:create()

	var_31_2:addObject(CCDelayTime:create(var_31_0 + 0.1))
	var_31_2:addObject(CCCallFunc:create(var_31_1))
	arg_31_0:runAction(CCSequence:create(var_31_2))
end

function var_0_0.refreshKeyNode(arg_33_0)
	if arg_33_0.keyNode == nil then
		arg_33_0.keyNode = display.newNode()

		arg_33_0:addChild(arg_33_0.keyNode)

		arg_33_0.keyNode.spriteList = {}
	end

	arg_33_0.keyNode:removeAllChildrenWithCleanup(true)

	local var_33_0 = addLabelWithColorSize(arg_33_0.keyNode, string.lf("剩余元辰石:"), labelColor, 25, ccp(0, 0.5), ccp(display.cx - 160, display.top - 40)):getContentSize().width + display.cx - 120

	for iter_33_0 = 1, arg_33_0.haveKeys do
		local var_33_1 = display.newSprite("ui/fuben/fuben_31.png", var_33_0, display.top - 40)

		var_33_1:setScale(Adapter.MinScale)
		arg_33_0.keyNode:addChild(var_33_1)
		table.insert(arg_33_0.keyNode.spriteList, var_33_1)

		var_33_0 = var_33_0 + 50 * Adapter.MinScale
	end
end

function var_0_0.letTheStarFly(arg_34_0)
	local function var_34_0()
		arg_34_0._circleLayer:reloadLayer()

		local var_35_0 = CCArray:create()

		var_35_0:addObject(CCFadeTo:create(0.3, 255))
		var_35_0:addObject(CCFadeTo:create(0.2, 0))
		arg_34_0.flashStarSprite:runAction(CCSequence:create(var_35_0))
		arg_34_0.bottomStarSprite:setVisible(true)
		arg_34_0.lastStarSprite:setVisible(false)
	end

	if table.nums(arg_34_0.keyNode.spriteList) == 0 then
		arg_34_0.bottomStarSprite:setVisible(true)
		arg_34_0:playBackgroundAlignAnimation()
	else
		local var_34_1 = CCArray:create()

		arg_34_0.lastStarSprite = arg_34_0.keyNode.spriteList[#arg_34_0.keyNode.spriteList]

		table.remove(arg_34_0.keyNode.spriteList, #arg_34_0.keyNode.spriteList)
		var_34_1:addObject(CCEaseSineOut:create(CCMoveTo:create(0.5, ccp(display.cx, 40))))
		var_34_1:addObject(CCCallFunc:create(handler(arg_34_0, arg_34_0.playBackgroundAlignAnimation)))
		var_34_1:addObject(CCCallFunc:create(var_34_0))
		arg_34_0.lastStarSprite:runAction(CCSequence:create(var_34_1))
	end
end

function var_0_0.setTheStoneStatus(arg_36_0, arg_36_1)
	if arg_36_0.bottomStarSprite then
		arg_36_0.bottomStarSprite:setVisible(arg_36_1)
	end
end

return var_0_0
