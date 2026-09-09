local var_0_0 = class("BlessInfoLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	addBlackLayer(arg_2_0)

	arg_2_0._closecallback = arg_2_1.closecallback

	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0._blessLevel = 1
	arg_2_0._curExp = 0
	arg_2_0._upgradeExp = 0
	arg_2_0._transportBonus = 0
	arg_2_0._blessTypeEnable = {
		1,
		1,
		1
	}
	arg_2_0._blessControlButton = {}

	arg_2_0:createNetworkRequest()

	local var_2_0 = display.newSprite("ui/common/common_040_3.png", display.cx, display.cy)

	var_2_0:setScale(Adapter.MinScale)
	arg_2_0:addChild(var_2_0)

	local var_2_1 = CCClippingRegionNode:create(CCRect(6, 8, 810, 490))

	var_2_1:setPosition(0, 0)
	var_2_0:addChild(var_2_1)

	local var_2_2 = display.newSprite("ui/transport/transport_033.jpg", 411, 255)

	var_2_0:addChild(var_2_2)

	local function var_2_3()
		if arg_2_0._closecallback then
			arg_2_0._closecallback()
		end

		arg_2_0:removeFromParent()
	end

	local var_2_4 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		position = ccp(790, 530),
		clickAction = var_2_3
	})

	var_2_0:addChild(var_2_4)

	local var_2_5 = display.newSprite("uilocal/transport/transport_text_005.png", 120, 530)

	var_2_0:addChild(var_2_5)

	local var_2_6 = display.newSprite("ui/transport/transport_011.png", 416, 350)

	var_2_0:addChild(var_2_6)

	local var_2_7 = arg_2_0:createButtons()

	var_2_0:addChild(var_2_7)
	arg_2_0.transportBlessInfoRequest:request()
end

function var_0_0.BlessToPusha(arg_5_0, arg_5_1)
	arg_5_0.blessId = arg_5_1

	local var_5_0 = TransportBlessInfo[arg_5_1].BlessType
	local var_5_1 = arg_5_0._blessTypeEnable[arg_5_1]
	local var_5_2 = TransportBlessInfo[arg_5_1].title

	if var_5_1 == 0 then
		ui.showMessageBox({
			text = string.lf("【%s】上香次数已用完.", var_5_2)
		})

		return
	end

	arg_5_0._currentBlessID = var_5_0

	arg_5_0.transportBlessRequest:request(var_5_0)
end

function var_0_0.createButtons(arg_6_0)
	local var_6_0 = CCNode:create()
	local var_6_1 = {
		{
			bgSelected = "ui/common/common_055.png",
			bgSprite = "ui/common/common_019.png",
			disableSprite = "ui/common/common_080.png",
			title = string.lf("上香保佑"),
			callfunc = function()
				arg_6_0:BlessToPusha(1)
			end
		},
		{
			bgSelected = "ui/common/common_055.png",
			bgSprite = "ui/common/common_019.png",
			disableSprite = "ui/common/common_080.png",
			title = string.lf("上香保佑"),
			callfunc = function()
				arg_6_0:BlessToPusha(2)
			end
		},
		{
			bgSelected = "ui/common/common_055.png",
			bgSprite = "ui/common/common_019.png",
			disableSprite = "ui/common/common_080.png",
			title = string.lf("上香保佑"),
			callfunc = function()
				arg_6_0:BlessToPusha(3)
			end
		}
	}

	arg_6_0.buttonPositions = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		local var_6_2 = 140 + (iter_6_0 - 1) * 272
		local var_6_3 = display.newSprite("ui/transport/transport_015.png", var_6_2, 90)

		var_6_0:addChild(var_6_3)

		local var_6_4 = display.newSprite(TransportBlessInfo[iter_6_0].headImage, 58, 72)

		var_6_3:addChild(var_6_4)
		addLabelWithColorSize(var_6_3, TransportBlessInfo[iter_6_0].title, TransportBlessInfo[iter_6_0].color, 20, ccp(0, 0.5), ccp(115, 125))
		addLabelWithColorSize(var_6_3, string.lf("香火值 +%s", TransportBlessInfo[iter_6_0].AddExp), ccc3(234, 194, 71), 18, ccp(0, 0.5), ccp(115, 100))
		addLabelWithColorSize(var_6_3, string.lf("阅历值 +%s", TransportBlessInfo[iter_6_0].AddKonwledge), ccc3(234, 194, 71), 18, ccp(0, 0.5), ccp(115, 75))

		local var_6_5 = createItemCountNode({
			color = ccc3(255, 255, 0),
			type = TransportBlessInfo[iter_6_0].BlessConsume.Type,
			value = TransportBlessInfo[iter_6_0].BlessConsume.Count
		})

		var_6_5:setPosition(ccp(195, 125))
		var_6_5:setAnchorPoint(ccp(0.5, 0.5))

		if iter_6_0 == 1 then
			var_6_5:setPosition(ccp(190, 125))
		end

		var_6_3:addChild(var_6_5)

		local var_6_6 = ui.newControlButton({
			clickAction = iter_6_1.callfunc,
			normalImage = iter_6_1.bgSprite,
			highlightedImage = iter_6_1.bgSelected,
			disabledImage = iter_6_1.disableSprite,
			textColor = ColorTable.eTitleButton_Normal2,
			position = ccp(190, 25),
			text = iter_6_1.title,
			fontSize = ColorTable.eTitleButton_FontSize2,
			fontName = _FONT_LISU
		})

		arg_6_0._blessControlButton[iter_6_0] = var_6_6

		local var_6_7, var_6_8 = var_6_6:getPosition()

		table.insert(arg_6_0.buttonPositions, ccp(var_6_2 + 130, 90))
		var_6_3:addChild(var_6_6)
	end

	arg_6_0.blessLevelLabel = addLabelWithColorSize(var_6_0, string.lf("香火等级:%s", arg_6_0._blessLevel), ccc3(255, 255, 0), 24, ccp(0.5, 0.5), ccp(430, 205))
	arg_6_0.progressBar = require("scenes.ProgressBar").new({
		backImage = "ui/transport/transport_014.png",
		curValue = 0,
		totalValue = 100,
		barImages = {
			"ui/transport/transport_013.png"
		},
		backSize = CCSize(360, 27),
		barSize = CCSize(319, 10),
		barPosition = ccp(-159, 0)
	})

	arg_6_0.progressBar:setPosition(ccp(433, 180))
	var_6_0:addChild(arg_6_0.progressBar)

	local var_6_9 = display.newSprite("ui/transport/transport_032.png", 815, 480)

	var_6_9:setAnchorPoint(ccp(1, 0.5))
	var_6_0:addChild(var_6_9)

	local var_6_10 = string.lf("运送的收益加成+%d%%", arg_6_0._transportBonus)

	arg_6_0.transportBounsLabel = addLabelWithColorSize(var_6_9, var_6_10, ccc3(232, 210, 121), 24, ccp(0.5, 0.5), ccp(133, 17))

	arg_6_0:refreshBlessLevelProgress()

	return var_6_0
end

function var_0_0.refreshBlessLevelProgress(arg_10_0, arg_10_1)
	arg_10_0.progressBar:setProgressValue(1, arg_10_0._curExp, arg_10_0._upgradeExp)
	arg_10_0:refreshBlessInfo()
end

function var_0_0.refreshBlessInfo(arg_11_0)
	local var_11_0 = string.lf("运送的收益加成+%d%%", arg_11_0._transportBonus)

	arg_11_0.transportBounsLabel:setString(var_11_0)
	arg_11_0.blessLevelLabel:setString(string.lf("香火等级:%s", arg_11_0._blessLevel))
end

function var_0_0.createNetworkRequest(arg_12_0)
	function responseTransportBlessInfoSuccess()
		local var_13_0 = arg_12_0.transportBlessInfoRequest:getTransportBlessInfo()

		arg_12_0._blessLevel = var_13_0.incenseLevel
		arg_12_0._curExp = var_13_0.curExp
		arg_12_0._upgradeExp = var_13_0.upgradeExp
		arg_12_0._transportBonus = var_13_0.transportAddition

		arg_12_0:updateBlessButtonStatus(var_13_0)
		arg_12_0:refreshBlessLevelProgress()
	end

	function responseTransportBlessInfoFailed(arg_14_0)
		return
	end

	arg_12_0.transportBlessInfoRequest = TransportBlessInfoRequest:new(arg_12_0)

	arg_12_0.transportBlessInfoRequest:setResponseNormalHandler(responseTransportBlessInfoSuccess)
	arg_12_0.transportBlessInfoRequest:setResponseExceptionHandler(responseTransportBlessInfoFailed)

	function responseTransportBlessSuccess()
		local var_15_0 = arg_12_0.transportBlessRequest:getBlessResult()

		arg_12_0._blessLevel = var_15_0.incenseLevel
		arg_12_0._curExp = var_15_0.curExp
		arg_12_0._upgradeExp = var_15_0.upgradeExp
		arg_12_0._transportBonus = var_15_0.transportAddition

		arg_12_0:updateBlessButtonStatus(var_15_0)
		arg_12_0:refreshBlessLevelProgress()
		showFlashImage({
			image = "uilocal/enhance/enhance_txt_007.png",
			parent = arg_12_0,
			position = CCPoint(arg_12_0.buttonPositions[arg_12_0.blessId].x, arg_12_0.buttonPositions[arg_12_0.blessId].y)
		})
	end

	function responseTransportBlessFailed(arg_16_0)
		return
	end

	arg_12_0.transportBlessRequest = TransportBlessRequest:new(arg_12_0)

	arg_12_0.transportBlessRequest:setResponseNormalHandler(responseTransportBlessSuccess)
	arg_12_0.transportBlessRequest:setResponseExceptionHandler(responseTransportBlessFailed)
end

function var_0_0.updateBlessButtonStatus(arg_17_0, arg_17_1)
	arg_17_0._blessTypeEnable[1] = arg_17_1.tenEnable
	arg_17_0._blessTypeEnable[2] = arg_17_1.hundredEnable
	arg_17_0._blessTypeEnable[3] = arg_17_1.thousandEnable

	for iter_17_0 = 1, 3 do
		local var_17_0 = arg_17_0._blessTypeEnable[iter_17_0] == 1

		arg_17_0._blessControlButton[iter_17_0]:setEnabled(var_17_0)
	end
end

return var_0_0
