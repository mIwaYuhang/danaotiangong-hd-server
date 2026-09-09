require("data.ShenQi")
require("data.item")
require("data.hero")
require("network.ShenqiRequest")
require("network.PropRequest")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = class("ShenqiLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0.shenQiScene = arg_2_1.shenQiScene
	arg_2_0.lastPointPass = false

	local var_2_0 = require("scenes.CommonBgLayer").new({
		isHideBgSprite = true,
		closeButtonPosition = ccp(-700, 100)
	})
	local var_2_1 = var_2_0:getBackgroundSprite()
	local var_2_2 = var_2_1:getContentSize()

	arg_2_0:addChild(var_2_0)

	arg_2_0.bgSprite = var_2_1

	local var_2_3 = ui.newControlButton({
		normalImage = "ui/common/common_125.png",
		text = string.lf("关闭"),
		clickAction = function()
			game.enterHomeScene({
				showSubLayer = ShowSubLayerType.eCopyHome
			})
		end
	})

	var_2_3:setPosition(var_2_2.width - 55, var_2_2.height - 35)
	var_2_1:addChild(var_2_3)

	local function var_2_4()
		GuideLayer:removeAllGuideLayer()

		local var_4_0 = require("scenes.enhance.DlgRuleLayer").new({
			ruleType = DlgRuleType.ruleShenqi
		})

		CCDirector:sharedDirector():getRunningScene():addChild(var_4_0)
	end

	local var_2_5 = ui.newControlButton({
		normalImage = "ui/common/common_125.png",
		highlightedImage = "ui/common/common_125.png",
		text = string.lf("帮助"),
		clickAction = var_2_4,
		textColor = ColorTable.eTitleButton_Normal,
		position = ccp(var_2_2.width - 155, var_2_2.height - 35),
		fontSize = ColorTable.eTitleButton_FontSize
	})

	arg_2_0.bgSprite:addChild(var_2_5, 1)

	arg_2_0.pointList = {
		{
			x = 20,
			y = 35
		},
		{
			x = 72,
			y = 63
		},
		{
			x = 156,
			y = 32
		},
		{
			x = 240,
			y = 48
		},
		{
			x = 285,
			y = 33
		},
		{
			x = 350,
			y = 63
		},
		{
			x = 430,
			y = 31
		},
		{
			x = 515,
			y = 47
		},
		{
			x = 565,
			y = 35
		},
		{
			x = 625,
			y = 65
		}
	}

	arg_2_0:initRequests()

	local var_2_6 = createPlayerAttrNode({
		ItemType.eGold,
		ItemType.eCoin
	})

	var_2_6:setPosition(ccp(20, 580))
	arg_2_0.bgSprite:addChild(var_2_6)

	local var_2_7 = BaseProps[110062]
	local var_2_8 = Player:getItemCount(ItemType.eProp, 110062)
	local var_2_9 = display.newSprite("ui/common/common_063.png", 520, 600)

	arg_2_0.bgSprite:addChild(var_2_9)

	local var_2_10 = display.newSprite("icon/" .. var_2_7.iconImage, 22, 22)

	var_2_9:addChild(var_2_10)

	arg_2_0.lingLabel = var_0_0.newLabel({
		size = 20,
		text = string.format("%s: %s", var_2_7.name, var_2_8),
		color = ccc3(245, 198, 30)
	})

	arg_2_0.lingLabel:setAnchorPoint(ccp(0.5, 0.5))
	arg_2_0.lingLabel:setPosition(105, 18)
	var_2_9:addChild(arg_2_0.lingLabel)
	arg_2_0.artifactRequest:requestInfo()
end

function var_0_1.initRequests(arg_5_0)
	local function var_5_0()
		arg_5_0:createShenqiUI()

		arg_5_0.shenqiData = arg_5_0.artifactRequest:getArtifactInfo()
		arg_5_0.artifactList = arg_5_0.shenqiData.artifacts
		arg_5_0.artifactIndex = arg_5_0.shenqiData.currentStep
		arg_5_0.artifactInfo = arg_5_0.artifactList[arg_5_0.artifactIndex]
		arg_5_0.lastPointPass = arg_5_0.artifactInfo.step == 10 and arg_5_0.artifactInfo.level == 10 and arg_5_0.artifactInfo.perfusionNode == 10

		local var_6_0 = arg_5_0.artifactInfo.fragments
		local var_6_1 = arg_5_0.artifactInfo.additions

		arg_5_0:showShenqiInfo(arg_5_0.artifactIndex)
		arg_5_0:showShenqiValue(var_6_1)
		arg_5_0:showFragmentInfo(var_6_0)
		Player:setShenQiCurrentTimes(arg_5_0.shenqiData.remainRobTime)
		arg_5_0:showRecoverTime()
	end

	arg_5_0.artifactRequest = ArtifactRequest:new()

	arg_5_0.artifactRequest:setResponseNormalHandler(var_5_0)

	local function var_5_1()
		local var_7_0 = "shenqi_text_013.png"
		local var_7_1 = arg_5_0.artifactList[arg_5_0.shenqiData.currentStep]

		if var_7_1.perfusionNode == #var_7_1.perfusionss - 1 then
			var_7_0 = "shenqi_text_012.png"

			if var_7_1.level == 10 then
				var_7_0 = var_7_1.step ~= 10 and "shenqi_text_011.png" or "shenqi_text_013.png"
			end
		end

		showFlashImage({
			parent = arg_5_0.bgSprite,
			position = CCPoint(arg_5_0.perfusionButton:getPositionX(), arg_5_0.perfusionButton:getPositionY()),
			image = "uilocal/shenqi/" .. var_7_0
		})

		local var_7_2 = arg_5_0.perfusionRequest.restable

		arg_5_0.shenqiData.currentStep = var_7_2.step
		arg_5_0.artifactList[var_7_2.step] = var_7_2

		arg_5_0:showAnimation(arg_5_0.bgSprite, function()
			if var_7_2.level == 1 and var_7_2.perfusionNode == 0 then
				arg_5_0.shenqiInfoLayer:actionMovePrev()
			else
				arg_5_0:reloadShenqiInfoLayer()
			end
		end)

		if var_7_2.level == 1 and var_7_2.perfusionNode == 0 then
			arg_5_0.artifactList[var_7_2.step - 1].perfusionNode = arg_5_0.artifactList[var_7_2.step - 1].perfusionNode + 1
		end

		arg_5_0.lastPointPass = var_7_2.step == 10 and var_7_2.level == 10 and var_7_2.perfusionNode == 10
	end

	local function var_5_2(arg_9_0)
		arg_5_0.perfusionButton:setEnabled(arg_5_0.shenqiData.currentStep == arg_5_0.artifactIndex and not arg_5_0.lastPointPass)

		if arg_9_0 == NetworkState.ShenQiMateNotEnough then
			local var_9_0 = GetTypePropsRequest:new()

			var_9_0:setResponseNormalHandler(function()
				arg_5_0:showFragmentInfo(arg_5_0.artifactList[arg_5_0.artifactIndex].fragments)
			end)
			var_9_0:request(PropType.eShenQiUpdate)
		end
	end

	arg_5_0.perfusionRequest = PerfusionRequest:new()

	arg_5_0.perfusionRequest:setResponseNormalHandler(var_5_1)
	arg_5_0.perfusionRequest:setResponseExceptionHandler(var_5_2)

	local function var_5_3()
		dump(arg_5_0.robTenInfoRequest.restable)

		arg_5_0.robTenData = arg_5_0.robTenInfoRequest.restable

		local function var_11_0()
			game.enterShenqiScene()
		end

		local var_11_1 = require("scenes.shenqi.ShenqiRobTenLayer").new({
			data = arg_5_0.robTenData,
			callBack = var_11_0
		})

		CCDirector:sharedDirector():getRunningScene():addChild(var_11_1)
	end

	local function var_5_4()
		return
	end

	arg_5_0.robTenInfoRequest = RobTenInfoRequest:new()

	arg_5_0.robTenInfoRequest:setResponseNormalHandler(var_5_3)
	arg_5_0.robTenInfoRequest:setResponseExceptionHandler(var_5_4)
end

function var_0_1.showRecoverTime(arg_14_0)
	if arg_14_0.shenqiData.remainRobTime == arg_14_0.shenqiData.totalRobTime then
		arg_14_0.shenqiData.remainRecoverTime = 0
	end

	local var_14_0 = arg_14_0.shenqiData.remainRecoverTime
	local var_14_1 = 0.5
	local var_14_2 = CCArray:create()

	var_14_2:addObject(CCCallFunc:create(function()
		var_14_0 = var_14_0 - var_14_1

		if var_14_0 > 0 then
			arg_14_0.shenqiData.remainRecoverTime = var_14_0

			local var_15_0, var_15_1, var_15_2, var_15_3 = getDateFromSeconds(arg_14_0.shenqiData.remainRecoverTime)
			local var_15_4 = string.format("%02d:%02d", var_15_2, var_15_3)

			arg_14_0.recoverTimeLabel:setString(string.lf("恢复时间:%s", var_15_4))
			arg_14_0.recoverTimeLabel:setVisible(true)
		elseif arg_14_0.shenqiData.remainRobTime < arg_14_0.shenqiData.totalRobTime then
			arg_14_0.shenqiData.remainRobTime = arg_14_0.shenqiData.remainRobTime + 1

			Player:setShenQiCurrentTimes(arg_14_0.shenqiData.remainRobTime)
			arg_14_0.robLabel:setString(string.lf("抢夺次数:#FFFF00%s/%s", arg_14_0.shenqiData.remainRobTime, arg_14_0.shenqiData.totalRobTime))

			if arg_14_0.shenqiData.remainRobTime < arg_14_0.shenqiData.totalRobTime then
				arg_14_0.shenqiData.remainRecoverTime = 900
				var_14_0 = arg_14_0.shenqiData.remainRecoverTime
			else
				arg_14_0.bgSprite:stopAllActions()
				arg_14_0.recoverTimeLabel:setVisible(false)
			end
		else
			arg_14_0.bgSprite:stopAllActions()
			arg_14_0.recoverTimeLabel:setVisible(false)
		end
	end))
	var_14_2:addObject(CCDelayTime:create(var_14_1))
	arg_14_0.bgSprite:runAction(CCRepeatForever:create(CCSequence:create(var_14_2)))
end

function var_0_1.createShenqiUI(arg_16_0)
	local var_16_0 = BaseProps[110062]
	local var_16_1 = Player:getItemCount(ItemType.eProp, 110062)

	arg_16_0.lingLabel:setString(string.format("%s: %s", var_16_0.name, var_16_1))

	if not arg_16_0.bgSprite2 then
		arg_16_0.bgSprite2 = display.newSprite("ui/shenqi/sq_051.png", 815, 410)
		arg_16_0.bgSprite3 = display.newSprite("ui/shenqi/sq_052.png", 480, 125)

		arg_16_0.bgSprite:addChild(arg_16_0.bgSprite2)
		arg_16_0.bgSprite:addChild(arg_16_0.bgSprite3)
	end

	if not arg_16_0.revengeButton then
		arg_16_0.revengeButton = ui.newControlButton({
			normalImage = "ui/shenqi/sq_032.png",
			scaleX = 1,
			scaleY = 1,
			text = string.lf("复仇"),
			clickAction = function(arg_17_0, arg_17_1)
				local var_17_0 = require("scenes.shenqi.ShenqiRevengeLayer").new({})

				CCDirector:sharedDirector():getRunningScene():addChild(var_17_0, DefaultZOrder.ePopupLayer)
			end
		})

		arg_16_0.revengeButton:setPosition(870, 220)
		arg_16_0.bgSprite:addChild(arg_16_0.revengeButton)
	end

	if arg_16_0.textInfo then
		arg_16_0.skillName:setString(string.lf("点击以下碎片可以抢夺，灌注碎片可使神器升级!"))
	else
		arg_16_0.textInfo = var_0_0.newLabel({
			text = string.lf("点击以下碎片可以抢夺，灌注碎片可使神器升级!"),
			color = ccc3(255, 255, 255)
		})

		arg_16_0.textInfo:setAnchorPoint(ccp(0.5, 0.5))
		arg_16_0.textInfo:setPosition(300, 220)
		arg_16_0.bgSprite:addChild(arg_16_0.textInfo)
	end
end

function var_0_1.showShenqiInfo(arg_18_0, arg_18_1)
	arg_18_0.shenqiInfoLayer = arg_18_0:createShenqiInfoLayer()

	arg_18_0.shenqiInfoLayer:setPosition(5, 248)
	arg_18_0.bgSprite:addChild(arg_18_0.shenqiInfoLayer)
	arg_18_0:reloadShenqiInfoLayer(arg_18_1)
end

function var_0_1.createShenqiInfoLayer(arg_19_0)
	local function var_19_0(arg_20_0, arg_20_1)
		local var_20_0

		if arg_19_0.artifactList and #arg_19_0.artifactList > 0 then
			var_20_0 = arg_19_0.artifactList[arg_20_1]
		end

		local var_20_1 = BaseShenQi[arg_20_1]
		local var_20_2 = var_20_1.name
		local var_20_3 = var_20_0.step
		local var_20_4 = var_20_0.level
		local var_20_5 = display.newSprite("ui/shenqi/sq_050.png", 0, 0)

		var_20_5:setAnchorPoint(ccp(0, 0))
		arg_20_0:addChild(var_20_5)

		if arg_20_1 < 10 then
			local var_20_6 = var_0_0.newLabel({
				text = string.lf("神器+10后进阶"),
				color = ccc3(133, 224, 178)
			})

			var_20_6:setAnchorPoint(ccp(0.5, 0.5))
			var_20_6:setPosition(570, 270)
			arg_20_0:addChild(var_20_6)
		end

		local var_20_7 = ui.newTTFLabel({
			text = var_20_2,
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(22),
			color = ccc3(245, 255, 0),
			align = ui.TEXT_ALIGN_CENTER,
			valign = ui.TEXT_VALIGN_CENTER,
			dimensions = CCSize(220, 30)
		})

		var_20_7:setAnchorPoint(ccp(0.5, 0.5))
		var_20_7:setPosition(340, 300)
		arg_20_0:addChild(var_20_7)

		local var_20_8 = {
			"sq_015.png",
			"sq_014.png",
			"sq_013.png",
			"sq_012.png",
			"sq_011.png",
			"sq_010.png",
			"sq_009.png",
			"sq_008.png",
			"sq_007.png",
			"sq_028.png"
		}
		local var_20_9 = display.newSprite("ui/shenqi/" .. var_20_8[var_20_3], 60, 270)

		arg_20_0:addChild(var_20_9)

		local var_20_10 = var_0_0.newLabel({
			size = 24,
			text = "+" .. var_20_4,
			color = ccc3(245, 198, 30)
		})

		var_20_10:setAnchorPoint(ccp(0.5, 0.5))
		var_20_10:setPosition(60, 250)
		arg_20_0:addChild(var_20_10)

		if arg_19_0.shenqiData.currentStep == arg_20_1 then
			local var_20_11 = display.newSprite("ui/shenqi/sq_054.png", 60, 200)

			var_20_11:setAnchorPoint(ccp(0.5, 0.5))
			arg_20_0:addChild(var_20_11)
		end

		local var_20_12 = display.newSprite("body/" .. var_20_1.image, 330, 180)
		local var_20_13 = var_20_12:getContentSize().width
		local var_20_14 = var_20_12:getContentSize().height
		local var_20_15 = 500
		local var_20_16 = 200

		if var_20_16 < var_20_14 and var_20_15 < var_20_13 then
			local var_20_17 = var_20_16 / var_20_14
			local var_20_18 = var_20_15 / var_20_13

			var_20_12:setScale(var_20_18 < var_20_17 and var_20_18 or var_20_17)
		end

		var_20_12:setAnchorPoint(ccp(0.5, 0.5))
		arg_20_0:addChild(var_20_12)

		local var_20_19 = var_20_0.perfusionss
		local var_20_20 = var_20_0.perfusionNode
		local var_20_21 = #var_20_19

		for iter_20_0 = 1, #BaseShenQiPoints[var_20_21] do
			local var_20_22 = var_20_19[iter_20_0][1]
			local var_20_23 = BaseShenQiPoints[var_20_21][iter_20_0]
			local var_20_24 = iter_20_0 <= var_20_20 and ccc4(255, 255, 0, 255) or ccc4(81, 41, 45, 255)

			if iter_20_0 > 1 then
				local var_20_25 = BaseShenQiPoints[var_20_21][iter_20_0 - 1]
				local var_20_26 = var_0_0.newLine({
					width = 3,
					from = {
						x = var_20_25.x + 15,
						y = var_20_25.y + 15
					},
					to = {
						x = var_20_23.x + 15,
						y = var_20_23.y + 15
					},
					color = var_20_24
				})

				arg_20_0:addChild(var_20_26)
			end

			local var_20_27 = iter_20_0 <= var_20_20 and "ui/shenqi/sq_034.png" or "ui/shenqi/sq_035.png"
			local var_20_28 = display.newSprite(var_20_27)

			var_20_28:setPosition(var_20_23)
			var_20_28:setAnchorPoint(ccp(0, 0))
			arg_20_0:addChild(var_20_28, 2)

			local var_20_29 = ui.newTTFLabel({
				text = string.format("%s:+%d", BattleAttrsName[var_20_22.battlePropertyType], var_20_22.value),
				font = _FONT_DEFAULT,
				size = Adapter.FontSize(17),
				color = ccc3(245, 255, 0),
				align = ui.TEXT_ALIGN_CENTER,
				valign = ui.TEXT_VALIGN_CENTER,
				dimensions = CCSize(200, 30)
			})

			var_20_29:setAnchorPoint(ccp(0.5, 0.5))

			local var_20_30 = var_20_23.x + 12

			if #BaseShenQiPoints[var_20_21] == 10 then
				if iter_20_0 == 1 then
					var_20_30 = var_20_23.x + 35
				elseif iter_20_0 == 10 then
					var_20_30 = var_20_23.x - 5
				end
			end

			local var_20_31 = BaseShenQiPoints[var_20_21][1].y > BaseShenQiPoints[var_20_21][2].y and 1 or 0

			var_20_29:setPosition(var_20_30, var_20_23.y - (iter_20_0 % 2 == var_20_31 and -35 or 5))
			arg_20_0:addChild(var_20_29)
		end

		if Player.level < var_20_1.unlockLevel then
			local var_20_32 = display.newSprite("ui/shenqi/sq_046.png", 335, 165)

			var_20_32:setAnchorPoint(ccp(0.5, 0.5))

			local var_20_33 = CCLabelAtlas:create(var_20_1.unlockLevel, "uilocal/shenqi/shenqi_text_007.png", 27.5, 34, 48)

			var_20_33:setAnchorPoint(ccp(0.5, 0.5))
			var_20_33:setPosition(380, 168)
			var_20_32:addChild(var_20_33)
			arg_20_0:addChild(var_20_32, 2)
		end

		if not (arg_20_1 <= arg_19_0.shenqiData.currentStep) and Player.level >= var_20_1.unlockLevel then
			local var_20_34 = CCLayerColor:create(ccc4(0, 0, 0, 150))

			var_20_34:setContentSize(CCSize(658, 312))
			var_20_34:setPosition(7, 6)
			arg_20_0:addChild(var_20_34, 2)
		end
	end

	local function var_19_1(arg_21_0)
		arg_19_0.artifactIndex = arg_21_0

		if arg_19_0.artifactList and #arg_19_0.artifactList > 0 then
			arg_19_0.artifactInfo = arg_19_0.artifactList[arg_19_0.artifactIndex]

			local var_21_0 = arg_19_0.artifactInfo.additions
			local var_21_1 = arg_19_0.artifactInfo.fragments

			arg_19_0:showShenqiValue(var_21_0)
			arg_19_0:showFragmentInfo(var_21_1)
		end

		GuideLayer:removeGuideLayerIfStepGreaterThan(TaskEntryType.eShenQi, 3)
	end

	return (require("scenes.SliderLayer").new({
		size = CCSize(670, 330),
		point = ccp(0, 0),
		clipScaleX = Adapter.MinScale,
		clipScaleY = Adapter.MinScale,
		numberHandler = function()
			return 10
		end,
		cellHandler = var_19_0,
		changedHandler = var_19_1,
		direction = SliderDirection.eHorizontal
	}))
end

function var_0_1.reloadShenqiInfoLayer(arg_23_0, arg_23_1)
	arg_23_0.shenqiInfoLayer:reloadData(arg_23_1)
end

function var_0_1.showShenqiValue(arg_24_0, arg_24_1)
	local var_24_0 = BaseShenQi[arg_24_0.artifactIndex]

	if arg_24_0.skillIcon then
		arg_24_0.skillIcon:removeFromParentAndCleanup(true)

		arg_24_0.skillIcon = nil
	end

	arg_24_0.skillIcon = display.newSprite("skillicon/" .. var_24_0.skillImage, 740, 520)

	arg_24_0.bgSprite:addChild(arg_24_0.skillIcon)

	if arg_24_0.skillName then
		arg_24_0.skillName:setString(var_24_0.skillName)
	else
		arg_24_0.skillName = var_0_0.newLabel({
			text = var_24_0.skillName,
			color = ccc3(255, 255, 0)
		})

		arg_24_0.skillName:setAnchorPoint(ccp(0.5, 0.5))
		arg_24_0.skillName:setPosition(830, 545)
		arg_24_0.bgSprite:addChild(arg_24_0.skillName)
	end

	if arg_24_0.skillDec then
		arg_24_0.skillDec:setString(string.lf("开场攻击对方%d人, 造成%d%%伤害", var_24_0.hurtCount, var_24_0.hurtValue * 100))
	else
		arg_24_0.skillDec = ui.newTTFLabel({
			text = string.lf("开场攻击对方%d人, 造成%d%%伤害", var_24_0.hurtCount, var_24_0.hurtValue * 100),
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(20),
			align = ui.TEXT_ALIGN_LEFT,
			valign = ui.TEXT_VALIGN_TOP,
			color = ccc3(245, 255, 0),
			dimensions = CCSize(170, 120)
		})

		arg_24_0.skillDec:setAnchorPoint(ccp(0.5, 0.5))
		arg_24_0.skillDec:setPosition(870, 460)
		arg_24_0.bgSprite:addChild(arg_24_0.skillDec)
	end

	local var_24_1 = {
		var_24_0.health,
		var_24_0.normalAttack,
		var_24_0.normalDefense,
		var_24_0.skillAttack,
		var_24_0.skillDefense,
		var_24_0.mingZhong,
		var_24_0.shanBi,
		var_24_0.baoJi,
		var_24_0.renXing,
		var_24_0.poJi,
		var_24_0.geDang,
		var_24_0.speed
	}

	if arg_24_1 then
		table.sort(arg_24_1, function(arg_25_0, arg_25_1)
			return arg_25_0.battlePropertyType < arg_25_1.battlePropertyType
		end)
	end

	local var_24_2 = arg_24_0.artifactIndex == arg_24_0.shenqiData.currentStep
	local var_24_3 = {}

	for iter_24_0 = 1, #var_24_1 do
		local var_24_4

		if var_24_2 then
			var_24_4 = string.format("%s: %d+(#00FF00%d#E9A636)", BattleAttrsName[iter_24_0], var_24_1[iter_24_0], arg_24_1[iter_24_0].value)
		else
			var_24_4 = string.format("%s: %d", BattleAttrsName[iter_24_0], var_24_1[iter_24_0])
		end

		table.insert(var_24_3, var_24_4)
	end

	if arg_24_0.valueScrollView then
		arg_24_0.valueScrollView:getContainer():removeAllChildrenWithCleanup(true)
	else
		arg_24_0.valueScrollView = CCScrollView:create(CCSize(250, 210))

		arg_24_0.valueScrollView:setDirection(kCCScrollViewDirectionVertical)
		arg_24_0.valueScrollView:setBounceable(false)
		arg_24_0.valueScrollView:setContentSize(CCSize(250, 360))
		arg_24_0.valueScrollView:setPosition(700, 257)
		arg_24_0.valueScrollView:setContentOffset(arg_24_0.valueScrollView:minContainerOffset())
		arg_24_0.bgSprite:addChild(arg_24_0.valueScrollView)
	end

	for iter_24_1 = 1, #var_24_1 do
		local var_24_5 = ui.newTTFLabel({
			text = var_24_3[iter_24_1],
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(20),
			align = ui.TEXT_ALIGN_LEFT,
			valign = ui.TEXT_VALIGN_CENTER,
			color = ccc3(245, 255, 0),
			dimensions = CCSize(250, 30)
		})

		var_24_5:setAnchorPoint(ccp(0, 0.5))
		var_24_5:setPosition(10, 360 - 30 * iter_24_1)
		arg_24_0.valueScrollView:addChild(var_24_5)
	end
end

function var_0_1.showFragmentInfo(arg_26_0, arg_26_1)
	if arg_26_0.fragmentBgs then
		for iter_26_0, iter_26_1 in ipairs(arg_26_0.fragmentBgs) do
			iter_26_1:removeFromParentAndCleanup(true)
		end
	end

	arg_26_0.fragmentBgs = {}

	if arg_26_0.perfusionButton then
		arg_26_0.perfusionButton:removeFromParentAndCleanup(true)

		arg_26_0.perfusionButton = nil
	end

	if arg_26_0.tenButton then
		arg_26_0.tenButton:removeFromParentAndCleanup(true)

		arg_26_0.tenButton = nil
	end

	arg_26_0.fragmentEn = true

	local var_26_0 = {}

	for iter_26_2, iter_26_3 in ipairs(arg_26_1) do
		local var_26_1 = BaseMates[iter_26_3.fragmentID]

		var_26_1.fragmentID = iter_26_3.fragmentID
		var_26_1.count = Player:getItemCount(ItemType.eMate, var_26_1.fragmentID)
		var_26_1.needCount = iter_26_3.needCount

		if var_26_1.count < var_26_1.needCount then
			arg_26_0.fragmentEn = false
		end

		table.insert(var_26_0, var_26_1)
	end

	table.sort(var_26_0, function(arg_27_0, arg_27_1)
		return arg_27_0.fragmentID < arg_27_1.fragmentID
	end)

	local var_26_2 = false

	for iter_26_4 = 1, #var_26_0 do
		local var_26_3 = display.newSprite("ui/team/team_102.png", iter_26_4 * 170 - 50, 120)

		arg_26_0.bgSprite:addChild(var_26_3)
		table.insert(arg_26_0.fragmentBgs, var_26_3)

		local var_26_4 = arg_26_0:addFragmentButton(var_26_3, var_26_0[iter_26_4])

		if iter_26_4 == 1 and Player.currentMissionStageID == 2 then
			GuideLayer:showGuideLayer(arg_26_0.shenQiScene, arg_26_0.bgSprite, TaskEntryType.eShenQi, 3, ccp(880, 150), true)
		end

		if var_26_2 == false and var_26_4 == false then
			if Player.currentMissionStageID == 1 or Player.currentMissionStageID == 3 then
				GuideLayer:showGuideLayer(arg_26_0.shenQiScene, var_26_3, TaskEntryType.eShenQi, 3, nil, true)
				GuideLayer:stepDone(TaskEntryType.eShenQi, 3)
			end

			var_26_2 = true
		end
	end

	if var_26_2 == false and Player.currentMissionStageID == 1 then
		GuideLayer:showGuideLayer(arg_26_0.shenQiScene, arg_26_0.bgSprite, TaskEntryType.eShenQi, 3, ccp(760, 150), true)
	end

	local var_26_5 = arg_26_0.artifactInfo.level == 10 and arg_26_0.artifactInfo.perfusionNode == #arg_26_0.artifactInfo.perfusionss - 1 and arg_26_0.shenqiData.currentStep ~= 10 and "ui/shenqi/sq_048.png" or "ui/shenqi/sq_031.png"

	arg_26_0.perfusionButton = ui.newControlButton({
		text = "",
		scaleX = 1,
		disabledImage = "ui/shenqi/sq_049.png",
		scaleY = 1,
		normalImage = var_26_5,
		highlightedImage = var_26_5,
		clickAction = function(arg_28_0, arg_28_1)
			if arg_26_0.fragmentEn then
				arg_26_0.perfusionRequest:request()
				arg_26_0.perfusionButton:setEnabled(false)
			else
				showFlashNotice(string.lf("材料不足, 抢夺可获取碎片~"))
			end

			GuideLayer:removeOneGuideLayer(TaskEntryType.eShenQi)
		end
	})

	arg_26_0.perfusionButton:setPosition(760, 120)
	arg_26_0.bgSprite:addChild(arg_26_0.perfusionButton)
	arg_26_0.perfusionButton:setEnabled(arg_26_0.shenqiData.currentStep == arg_26_0.artifactIndex and not arg_26_0.lastPointPass)

	arg_26_0.tenButton = ui.newControlButton({
		text = "",
		scaleX = 1,
		disabledImage = "ui/shenqi/sq_063.png",
		normalImage = "ui/shenqi/sq_063.png",
		highlightedImage = "ui/shenqi/sq_063.png",
		scaleY = 1,
		clickAction = function(arg_29_0, arg_29_1)
			local var_29_0 = Player:getItemCount(ItemType.eProp, 110062)

			if arg_26_0.shenqiData.remainRobTime + var_29_0 >= 10 then
				local var_29_1 = arg_26_0.shenqiData.robTenCost
				local var_29_2 = 10

				if isMoneyEnough(MoneyType.eGold, var_29_1) == false then
					return
				end

				local var_29_3 = ""
				local var_29_4 = require("scenes.MessageBoxLayer").new()

				local function var_29_5(arg_30_0, arg_30_1)
					var_29_4:removeFromParentAndCleanup(true)
				end

				local var_29_6 = string.lf("上仙，您是否需要花费#FFFF00%d#FFFFFF元宝，来抢夺%d次?", var_29_1, var_29_2)

				local function var_29_7()
					arg_26_0.robTenInfoRequest:request(var_29_2)
					var_29_4:removeFromParentAndCleanup(true)
				end

				var_29_4:setContentAndButtons(var_29_6, string.lf("确定"), var_29_7, string.lf("取消"), var_29_5)
				CCDirector:sharedDirector():getRunningScene():addChild(var_29_4)
			else
				showFlashNotice(string.lf("抢夺次数不足十次, 无法抢夺~"))
			end

			if Player.currentMissionStageID == 2 then
				GuideLayer:removeOneGuideLayer(TaskEntryType.eShenQi)
			end
		end
	})

	arg_26_0.tenButton:setPosition(880, 120)
	arg_26_0.bgSprite:addChild(arg_26_0.tenButton)
	arg_26_0.tenButton:setEnabled(arg_26_0.shenqiData.currentStep == arg_26_0.artifactIndex)

	if arg_26_0.fragmentEn == true and Player.currentMissionStageID == 1 then
		GuideLayer:showGuideLayer(arg_26_0.shenQiScene, arg_26_0.perfusionButton, TaskEntryType.eShenQi, 5, nil, true)
	end

	if arg_26_0.robLabel then
		arg_26_0.robLabel:setString(string.lf("抢夺次数:#FFFF00%s/%s", arg_26_0.shenqiData.remainRobTime, arg_26_0.shenqiData.totalRobTime))
	else
		arg_26_0.robLabel = var_0_0.newLabel({
			text = string.lf("抢夺次数:#FFFF00%s/%s", arg_26_0.shenqiData.remainRobTime, arg_26_0.shenqiData.totalRobTime),
			color = ccc3(0, 255, 0)
		})

		arg_26_0.robLabel:setAnchorPoint(ccp(0.5, 0.5))
		arg_26_0.robLabel:setPosition(600, 220)
		arg_26_0.bgSprite:addChild(arg_26_0.robLabel)
	end

	local var_26_6, var_26_7, var_26_8, var_26_9 = getDateFromSeconds(arg_26_0.shenqiData.remainRecoverTime)
	local var_26_10 = string.format("%02d:%02d", var_26_8, var_26_9)

	if arg_26_0.recoverTimeLabel then
		arg_26_0.recoverTimeLabel:setString(string.lf("恢复时间:%s", var_26_10))
	else
		arg_26_0.recoverTimeLabel = var_0_0.newLabel({
			text = string.lf("恢复时间:%s", var_26_10),
			color = ccc3(0, 255, 0)
		})

		arg_26_0.recoverTimeLabel:setAnchorPoint(ccp(0.5, 0.5))
		arg_26_0.recoverTimeLabel:setPosition(750, 220)
		arg_26_0.bgSprite:addChild(arg_26_0.recoverTimeLabel)
	end
end

function var_0_1.addFragmentButton(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_2.headerImage
	local var_32_1 = arg_32_2.name
	local var_32_2 = arg_32_2.count >= arg_32_2.needCount
	local var_32_3 = arg_32_0.artifactIndex <= arg_32_0.shenqiData.currentStep
	local var_32_4 = ui.newControlButton({
		text = "",
		scaleX = 1,
		scaleY = 1,
		normalImage = "prop/" .. var_32_0,
		clickAction = function(arg_33_0, arg_33_1)
			if arg_32_0.lastPointPass then
				local var_33_0 = require("scenes.shenqi.ShenqiSnatchLayer").new({
					fragmentID = arg_32_2.fragmentID,
					remainRobTime = arg_32_0.shenqiData.remainRobTime,
					totalRobTime = arg_32_0.shenqiData.totalRobTime,
					recoverTime = arg_32_0.shenqiData.remainRecoverTime,
					shenQiScene = arg_32_0.shenQiScene
				})

				arg_32_0:addChild(var_33_0, 11)
			elseif var_32_2 then
				showFlashNotice(string.lf("碎片足够, 不可以抢夺~"))
			else
				local var_33_1 = require("scenes.shenqi.ShenqiSnatchLayer").new({
					fragmentID = arg_32_2.fragmentID,
					remainRobTime = arg_32_0.shenqiData.remainRobTime,
					totalRobTime = arg_32_0.shenqiData.totalRobTime,
					recoverTime = arg_32_0.shenqiData.remainRecoverTime,
					shenQiScene = arg_32_0.shenQiScene
				})

				arg_32_0:addChild(var_33_1, 11)
			end
		end
	})

	var_32_4:setPosition(68, 67)
	arg_32_1:addChild(var_32_4)
	var_32_4:setEnabled(arg_32_0.shenqiData.currentStep == arg_32_0.artifactIndex)
	var_32_4:setOpacity(var_32_3 and 255 or 180)

	local var_32_5 = var_32_2 and ccc3(0, 255, 0) or ccc3(255, 0, 0)
	local var_32_6 = var_0_0.newLabel({
		text = arg_32_2.count .. "/" .. arg_32_2.needCount,
		color = var_32_5
	})

	var_32_6:setAnchorPoint(ccp(0.5, 0.5))
	var_32_6:setPosition(110, 10)
	arg_32_1:addChild(var_32_6)
	var_32_6:setVisible(var_32_3)

	local var_32_7 = var_0_0.newLabel({
		size = 18,
		text = var_32_1,
		color = ccc3(245, 255, 0)
	})

	var_32_7:setAnchorPoint(ccp(0.5, 0.5))
	var_32_7:setPosition(65, -20)
	arg_32_1:addChild(var_32_7)

	return var_32_2
end

function var_0_1.showAnimation(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_0.artifactInfo.perfusionNode + 1
	local var_34_1 = #arg_34_0.artifactInfo.perfusionss
	local var_34_2 = BaseShenQiPoints[var_34_1][var_34_0]
	local var_34_3 = var_34_2.x + 20
	local var_34_4 = var_34_2.y + 260
	local var_34_5 = arg_34_0.artifactInfo.perfusionss[var_34_0][1]
	local var_34_6 = 0
	local var_34_7 = arg_34_0.valueScrollView:minContainerOffset()

	if var_34_5.battlePropertyType <= 7 then
		var_34_6 = 480 - var_34_5.battlePropertyType * 30
	else
		var_34_7 = arg_34_0.valueScrollView:maxContainerOffset()
		var_34_6 = 480 - (var_34_5.battlePropertyType - 5) * 30
	end

	local function var_34_8()
		if arg_34_0.artifactInfo.level == 1 and arg_34_0.artifactInfo.perfusionNode == 0 then
			arg_34_0:reloadShenqiInfoLayer()
		end
	end

	local function var_34_9()
		local var_36_0 = CCSkeletonAnimation:createWithFile("ui/shenqi/ui_shenqiweiling.json", "ui/shenqi/ui_shenqiweiling.atlas", 1)

		var_36_0:setAnimation("ui_shenqiweiling_shanliang", false, 0, 0)
		var_36_0:setPosition(340, 410)
		var_36_0:addAnimationAction("ui_shenqiweiling_shanliang", 1, CCCallFunc:create(function()
			var_34_8()
		end), AAT_Percent)
		arg_34_1:addChild(var_36_0)
	end

	local function var_34_10()
		arg_34_2()
		arg_34_0.perfusionButton:setEnabled(arg_34_0.shenqiData.currentStep == arg_34_0.artifactIndex and not arg_34_0.lastPointPass)

		local var_38_0 = CCSkeletonAnimation:createWithFile("ui/shenqi/ui_shenqiweiling.json", "ui/shenqi/ui_shenqiweiling.atlas", 1)

		var_38_0:setAnimation("ui_shenqiweiling_shuaxin", false, 0, 0)

		if var_34_0 == var_34_1 then
			var_38_0:addAnimationAction("ui_shenqiweiling_shuaxin", 1, CCCallFunc:create(function()
				var_38_0:removeFromParent()
				var_34_9()
			end), AAT_Percent)
		end

		var_38_0:setPosition(800, var_34_6)
		arg_34_1:addChild(var_38_0)
	end

	local function var_34_11()
		arg_34_0.valueScrollView:setContentOffsetInDuration(var_34_7, 0.5)

		local var_40_0 = display.newSprite("ui/shenqi/sq_ball.png", var_34_3, var_34_4)

		arg_34_0.bgSprite:addChild(var_40_0)

		local var_40_1 = CCArray:create()

		var_40_1:addObject(CCDelayTime:create(0.1))
		var_40_1:addObject(CCMoveTo:create(0.5, ccp(800, var_34_6)))
		var_40_1:addObject(CCFadeOut:create(0.4))
		var_40_1:addObject(CCCallFunc:create(function()
			var_34_10()
		end))
		var_40_0:runAction(CCSequence:create(var_40_1))
	end

	local function var_34_12()
		local var_42_0 = CCSkeletonAnimation:createWithFile("ui/shenqi/ui_shenqiweiling.json", "ui/shenqi/ui_shenqiweiling.atlas", 1)

		var_42_0:setAnimation("ui_shenqiweiling_shanbao", false, 0, 0)
		var_42_0:setPosition(var_34_3, var_34_4)
		var_42_0:addAnimationAction("ui_shenqiweiling_shanbao", 1, CCCallFunc:create(function()
			var_42_0:removeFromParent()
			var_34_11()
		end), AAT_Percent)
		arg_34_1:addChild(var_42_0)
	end

	for iter_34_0 = 1, 4 do
		local var_34_13 = CCSkeletonAnimation:createWithFile("ui/shenqi/ui_shenqiweiling.json", "ui/shenqi/ui_shenqiweiling.atlas", 1)

		var_34_13:setAnimation("ui_shenqiweiling_bao", false, 0, 0)
		var_34_13:setPosition(iter_34_0 * 170 - 50, 120)
		arg_34_1:addChild(var_34_13)
		var_34_13:addAnimationAction("ui_shenqiweiling_bao", 1, CCCallFunc:create(function()
			var_34_13:removeFromParent()

			if iter_34_0 == 4 then
				var_34_12()
			end
		end), AAT_Percent)
	end
end

return var_0_1
