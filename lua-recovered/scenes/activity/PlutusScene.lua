require("base.figure")
require("data.localdata")
require("network.ActivityRequest")

local var_0_0 = {
	Coin = 2,
	Ingot = 1,
	Power = 3
}
local var_0_1 = {}
local var_0_2 = "KEY_IS_FIRST_GAME"
local var_0_3 = class("PlutusScene", function()
	return display.newScene("PlutusScene")
end)

function var_0_3.ctor(arg_2_0, arg_2_1)
	arg_2_0.rewardList = {}
	arg_2_0.remainTime = arg_2_1.remainTime

	local var_2_0 = display.newSprite("ui/activity/activity_078.jpg")

	var_2_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_0:setPosition(CCPoint(display.cx, display.cy))
	var_2_0:setScale(Adapter.AutoScaleY)
	arg_2_0:addChild(var_2_0)

	arg_2_0.bgSize = CCSize(960, 640)

	arg_2_0:initRequests()

	var_0_1 = {
		[var_0_0.Ingot] = {
			Image = "ui/common/common_130.png",
			minUnit = 1,
			maxScore = 20,
			currScore = 0,
			Tag = var_0_0.Ingot
		},
		[var_0_0.Coin] = {
			Image = "ui/common/common_131.png",
			minUnit = 400,
			maxScore = 20000,
			currScore = 0,
			Tag = var_0_0.Coin
		},
		[var_0_0.Power] = {
			Image = "ui/common/common_132.png",
			minUnit = 0.5,
			maxScore = 15,
			currScore = 0,
			Tag = var_0_0.Power
		}
	}

	arg_2_0:showInitLayer()

	local var_2_1 = LocalData:getGameDataValue(var_0_2)

	if var_2_1 == nil or var_2_1 == true then
		arg_2_0:showGuideLayer()
	else
		arg_2_0:startGame()
	end
end

function var_0_3.initRequests(arg_3_0)
	local function var_3_0()
		Player:setSanHuaCount(Player.sanHuaCount - 1)
		game.enterActivityScene({
			type = ActivityType.eSanHua
		})
	end

	local function var_3_1(arg_5_0)
		game.enterActivityScene({
			type = ActivityType.eSanHua
		})
	end

	arg_3_0.flowersUseRequest = FlowersUseRequest:new()

	arg_3_0.flowersUseRequest:setResponseNormalHandler(var_3_0)
	arg_3_0.flowersUseRequest:setResponseExceptionHandler(var_3_1)
end

function var_0_3.onExit(arg_6_0)
	arg_6_0:removeSchedule()
end

function var_0_3.startGame(arg_7_0)
	arg_7_0:showTouchSprite()

	arg_7_0.gameOver = false

	arg_7_0:addSchedule()
end

function var_0_3.showGuideLayer(arg_8_0)
	local var_8_0 = CCLayerColor:create(ccc4(0, 0, 0, 200))

	var_8_0:setContentSize(CCSize(display.width, display.height))
	arg_8_0:addChild(var_8_0)

	local var_8_1 = display.newSprite("ui/common/common_114.png")

	var_8_1:setAnchorPoint(CCPoint(0.5, 0))
	var_8_1:setPosition(display.cx, 0)
	var_8_1:setScale(Adapter.MinScale)
	var_8_0:addChild(var_8_1)

	local var_8_2 = var_8_1:getContentSize()

	addLabelWithColorSize(var_8_1, string.lf("左右拖动花篮以接住掉下来的元宝、银币和体力，\n当接到的体力达到15点时，游戏结束。"), ccc3(255, 225, 255), 20, CCPoint(0.5, 0.5), CCPoint(var_8_2.width * 0.65, 150))

	local var_8_3 = ui.newControlButton({
		highlightedImage = "ui/common/common_019.png",
		normalImage = "ui/common/common_019.png",
		text = string.lf("确定"),
		fontSize = ColorTable.eTitleButton_FontSize2,
		textColor = ColorTable.eTitleButton_Normal2,
		anchorPoint = CCPoint(0.5, 0),
		position = CCPoint(display.width * 0.6, 10),
		clickAction = function()
			LocalData:saveGameDataValue(var_0_2, false)
			var_8_0:removeFromParentAndCleanup(true)
			arg_8_0:startGame()
		end,
		scaleX = Adapter.MinScale,
		scaleY = Adapter.MinScale
	})

	var_8_0:addChild(var_8_3)
end

function var_0_3.showResultLayer(arg_10_0)
	local var_10_0 = var_0_1[var_0_0.Ingot].currScore
	local var_10_1 = var_0_1[var_0_0.Coin].currScore
	local var_10_2 = math.floor(var_0_1[var_0_0.Power].currScore)

	if var_10_2 > var_0_1[var_0_0.Power].maxScore then
		var_10_2 = var_0_1[var_0_0.Power].maxScore
	end

	local function var_10_3()
		arg_10_0.flowersUseRequest:request(var_10_0, var_10_1, var_10_2)
	end

	local var_10_4 = {
		{
			ID = 0,
			Type = ItemType.ePower,
			Count = var_10_2
		},
		{
			ID = 0,
			Type = ItemType.eGold,
			Count = var_10_0
		},
		{
			ID = 0,
			Type = ItemType.eCoin,
			Count = var_10_1
		}
	}
	local var_10_5 = require("scenes.enhance.DlgResultLayer").new({
		titleText = string.lf("游戏结束，请收取您的奖励"),
		rewardList = var_10_4,
		closeCallback = var_10_3
	})

	CCDirector:sharedDirector():getRunningScene():addChild(var_10_5, 100)
end

function var_0_3.showInitLayer(arg_12_0)
	local var_12_0 = display.newSprite("ui/activity/activity_076.png")

	var_12_0:setAnchorPoint(CCPoint(1, 1))
	var_12_0:setPosition(Adapter.AutoPos(arg_12_0.bgSize.width * 0.34, arg_12_0.bgSize.height * 0.984))
	var_12_0:setScale(Adapter.MinScale)
	arg_12_0:addChild(var_12_0)

	var_0_1[var_0_0.Ingot].label = addLabelWithColorSize(var_12_0, "0", ccc3(255, 225, 255), 20, CCPoint(0, 0.5), CCPoint(50, 33))

	local var_12_1 = display.newSprite("ui/activity/activity_077.png")

	var_12_1:setAnchorPoint(CCPoint(1, 1))
	var_12_1:setPosition(Adapter.AutoPos(arg_12_0.bgSize.width * 0.5, arg_12_0.bgSize.height * 0.984))
	var_12_1:setScale(Adapter.MinScale)
	arg_12_0:addChild(var_12_1)

	var_0_1[var_0_0.Coin].label = addLabelWithColorSize(var_12_1, "0", ccc3(255, 225, 255), 20, CCPoint(0, 0.5), CCPoint(50, 33))

	local var_12_2 = require("scenes.ProgressBar").new({
		backImage = "ui/activity/activity_074.png",
		curValue = 0,
		backSize = CCSize(396, 46),
		barImages = {
			"ui/activity/activity_073.png"
		},
		barSize = CCSize(380, 30),
		barPosition = ccp(-190, 0),
		totalValue = var_0_1[var_0_0.Power].maxScore,
		labelColor = ccc3(255, 225, 255)
	})

	var_12_2:setPosition(Adapter.AutoPos(arg_12_0.bgSize.width * 0.719, arg_12_0.bgSize.height * 0.9375))
	var_12_2:setScale(Adapter.MinScale)
	arg_12_0:addChild(var_12_2)

	local var_12_3 = display.newSprite("ui/activity/activity_075.png", -30, 22)

	var_12_3:setAnchorPoint(CCPoint(1, 1))
	var_12_2:addChild(var_12_3)

	var_0_1[var_0_0.Power].label = var_12_2
end

function var_0_3.showTouchSprite(arg_13_0)
	arg_13_0.plutusSprite = display.newSprite("ui/activity/activity_079.png")

	arg_13_0.plutusSprite:setAnchorPoint(CCPoint(0.5, 0))
	arg_13_0.plutusSprite:setPosition(Adapter.AutoPos(arg_13_0.bgSize.width * 0.5, 0))
	arg_13_0.plutusSprite:setScale(Adapter.MinScale)
	arg_13_0:addChild(arg_13_0.plutusSprite)

	arg_13_0.plutusSize = arg_13_0.plutusSprite:getContentSize()
	arg_13_0.leftBorder = arg_13_0.plutusSize.width / 2 * Adapter.MinScale
	arg_13_0.rightBorder = display.width - arg_13_0.plutusSize.width / 2 * Adapter.MinScale

	local var_13_0 = 0

	local function var_13_1(arg_14_0, arg_14_1, arg_14_2)
		if arg_13_0.plutusSprite == nil then
			return false
		end

		if arg_14_0 == "began" then
			local var_14_0 = arg_13_0.plutusSprite:getPositionX()
			local var_14_1 = arg_13_0.plutusSprite:getPositionY()

			if arg_14_1 > var_14_0 + arg_13_0.plutusSize.width / 2 * Adapter.MinScale or arg_14_1 < var_14_0 - arg_13_0.plutusSize.width / 2 * Adapter.MinScale or arg_14_2 < var_14_1 or arg_14_2 > (var_14_1 + arg_13_0.plutusSize.height * 0.6) * Adapter.MinScale then
				return false
			end

			var_13_0 = arg_14_1

			return true
		elseif arg_14_0 == "moved" then
			if var_13_0 > 0 then
				local var_14_2 = var_13_0 - arg_14_1
				local var_14_3 = arg_13_0.plutusSprite:getPositionX() - var_14_2

				if var_14_3 > arg_13_0.leftBorder and var_14_3 < arg_13_0.rightBorder then
					arg_13_0.plutusSprite:setPosition(var_14_3, 0)
				end
			end

			var_13_0 = arg_14_1
		elseif arg_14_0 == "ended" then
			var_13_0 = 0
		end
	end

	arg_13_0.maskLayer = CCLayer:create()

	arg_13_0.maskLayer:addTouchEventListener(var_13_1, false, -128, false)
	arg_13_0.maskLayer:setTouchEnabled(true)
	arg_13_0:addChild(arg_13_0.maskLayer)
end

function var_0_3.createRewards(arg_15_0)
	local var_15_0 = var_0_1[var_0_0.Ingot]
	local var_15_1 = var_0_1[var_0_0.Coin]
	local var_15_2 = var_0_1[var_0_0.Power]
	local var_15_3 = var_15_0.maxScore / var_15_0.minUnit - var_15_0.currScore / var_15_0.minUnit
	local var_15_4 = var_15_1.maxScore / var_15_1.minUnit - var_15_1.currScore / var_15_1.minUnit
	local var_15_5 = var_15_2.maxScore / var_15_2.minUnit - var_15_2.currScore / var_15_2.minUnit
	local var_15_6 = var_15_3 + var_15_4 + var_15_5

	var_15_0.Probability = var_15_3 > 0 and var_15_3 / var_15_6 or 0.02
	var_15_1.Probability = var_15_4 > 0 and var_15_4 / var_15_6 or 0.02
	var_15_2.Probability = 1 - var_15_0.Probability - var_15_1.Probability

	local var_15_7 = math.random(2, 6)

	for iter_15_0 = 1, var_15_7 do
		local var_15_8 = math.random(1, 100) / 100
		local var_15_9
		local var_15_10 = 0

		for iter_15_1 = 1, table.nums(var_0_1) do
			var_15_9 = var_0_1[iter_15_1]

			if var_15_10 <= var_15_8 and var_15_8 <= var_15_10 + var_15_9.Probability then
				break
			end

			var_15_10 = var_15_10 + var_15_9.Probability
		end

		local var_15_11 = math.random(0, display.width)
		local var_15_12 = math.random(1, 10)
		local var_15_13 = math.random(1, 10) * 0.05 + 1.3
		local var_15_14 = display.newSprite(var_15_9.Image, var_15_11, Adapter.AutoPosY(arg_15_0.bgSize.height + 50 * var_15_12))

		var_15_14:setAnchorPoint(CCPoint(0.5, 0))
		var_15_14:setScale(0.2 * Adapter.MinScale)
		arg_15_0:addChild(var_15_14)

		local var_15_15 = {
			item = var_15_9,
			sprite = var_15_14
		}

		table.insert(arg_15_0.rewardList, var_15_15)

		local var_15_16 = CCArray:create()

		var_15_16:addObject(CCMoveTo:create(var_15_13, CCPoint(var_15_11, 0)))
		var_15_16:addObject(CCCallFunc:create(function()
			for iter_16_0, iter_16_1 in ipairs(arg_15_0.rewardList) do
				if iter_16_1.sprite == var_15_14 then
					table.remove(arg_15_0.rewardList, iter_16_0)

					break
				end
			end

			var_15_15.sprite:removeFromParentAndCleanup(true)
		end))
		var_15_14:runAction(CCSequence:create(var_15_16))
	end
end

function var_0_3.getOneReward(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0.gameOver == true then
		return
	end

	local var_17_0 = var_0_1[arg_17_1]

	var_17_0.currScore = var_17_0.currScore + var_17_0.minUnit

	local var_17_1 = arg_17_1 == var_0_0.Power and ccc3(255, 0, 255) or arg_17_1 == var_0_0.Ingot and ccc3(255, 255, 0) or ccc3(0, 255, 0)

	arg_17_2:setVisible(false)
	showFlashText(arg_17_2:getParent(), "+" .. var_17_0.minUnit, var_17_1, CCPoint(arg_17_2:getPositionX(), arg_17_2:getPositionY()))

	if arg_17_1 == var_0_0.Power then
		if var_17_0.currScore < var_17_0.maxScore then
			var_17_0.label:setProgressValue(1, var_17_0.currScore, var_17_0.maxScore)
		else
			var_17_0.label:setProgressValue(1, var_17_0.maxScore, var_17_0.maxScore)

			var_17_0.currScore = var_17_0.maxScore
			arg_17_0.gameOver = true
		end
	else
		var_17_0.label:stopAllActions()
		var_17_0.label:runAction(CCBlink:create(0.5, 2))
		var_17_0.label:setString(var_17_0.currScore)
	end
end

function var_0_3.addSchedule(arg_18_0)
	if arg_18_0.scheduleHandle == nil then
		arg_18_0.scheduleHandle = require("framework.scheduler").scheduleGlobal(handler(arg_18_0, arg_18_0.scheduleCallback), 0.25)
	end
end

function var_0_3.removeSchedule(arg_19_0)
	if arg_19_0.scheduleHandle then
		require("framework.scheduler").unscheduleGlobal(arg_19_0.scheduleHandle)

		arg_19_0.scheduleHandle = nil
	end
end

function var_0_3.scheduleCallback(arg_20_0, arg_20_1)
	if arg_20_0.tempTimes == nil then
		arg_20_0.tempTimes = 0
	else
		arg_20_0.tempTimes = arg_20_0.tempTimes + arg_20_1
	end

	if arg_20_0.gameOver == true then
		for iter_20_0, iter_20_1 in pairs(arg_20_0.rewardList) do
			iter_20_1.sprite:removeFromParentAndCleanup(true)
		end

		arg_20_0.plutusSprite:removeFromParentAndCleanup(true)

		arg_20_0.plutusSprite = nil
		arg_20_0.rewardList = {}

		arg_20_0:removeSchedule()
		arg_20_0:showResultLayer()

		return
	end

	local var_20_0 = arg_20_0.plutusSprite:getPositionX()

	for iter_20_2, iter_20_3 in ipairs(arg_20_0.rewardList) do
		if iter_20_3.sprite:isVisible() == true then
			local var_20_1 = iter_20_3.sprite:getPositionX()

			if iter_20_3.sprite:getPositionY() < arg_20_0.plutusSize.height * 0.6 * Adapter.MinScale and var_20_1 > var_20_0 - arg_20_0.plutusSize.width / 2 * Adapter.MinScale and var_20_1 < var_20_0 + arg_20_0.plutusSize.width / 2 * Adapter.MinScale then
				arg_20_0:getOneReward(iter_20_3.item.Tag, iter_20_3.sprite)
			end
		end
	end

	if arg_20_0.tempTimes >= 0.6 then
		arg_20_0:createRewards()

		if arg_20_0.remainTime == 0 then
			arg_20_0.gameOver = true
		else
			arg_20_0.remainTime = arg_20_0.remainTime - 1
		end

		arg_20_0.tempTimes = 0
	end
end

return var_0_3
