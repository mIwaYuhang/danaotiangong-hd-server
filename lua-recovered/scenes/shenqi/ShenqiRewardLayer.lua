local var_0_0 = {
	eShenqiReward = 1,
	typeOfUnknown = 0,
	eDuelReward = 2
}
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = require("scenes.ToolLayer")
local var_0_3 = class("ShenqiRewardLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create(ccc4(10, 10, 10, 180)))
end)

function var_0_3.ctor(arg_2_0, arg_2_1)
	arg_2_0.battleType = arg_2_1.battleType or nil
	arg_2_0.params = clone(arg_2_1)
	arg_2_0.unOpen = false

	local var_2_0 = CCTextureCache:sharedTextureCache():addImage("ui/shenqi/sq_029.png"):getContentSizeInPixels().width / 2 - 25

	arg_2_0.bgSprite = display.newSprite("ui/shenqi/sq_029.png")

	arg_2_0.bgSprite:setScale(Adapter.MinScale)
	arg_2_0.bgSprite:setAnchorPoint(CCPoint(0.5, 0.5))
	arg_2_0.bgSprite:setPosition(display.width / 2, display.height / 2)
	arg_2_0:addChild(arg_2_0.bgSprite)

	local var_2_1 = display.newSprite("ui/shenqi/sq_024.png", var_2_0, 410)

	arg_2_0.bgSprite:addChild(var_2_1)

	local var_2_2 = display.newSprite("ui/shenqi/sq_025.png", var_2_0, 200)

	arg_2_0.bgSprite:addChild(var_2_2)

	arg_2_0.pButton = ui.newControlButton({
		highlightedImage = "ui/common/common_019.png",
		disabledImage = "ui/common/common_080.png",
		normalImage = "ui/common/common_019.png",
		text = string.lf("确定"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		fontName = _FONT_LISU,
		clickAction = function(arg_3_0, arg_3_1)
			if arg_2_0.battleType and arg_2_0.battleType == eBattleType.ShenqiRobFragment then
				game.enterShenqiScene()
			else
				game.enterDuelRankScene()
			end
		end,
		position = CCPoint(var_2_0, 40)
	})

	arg_2_0.bgSprite:addChild(arg_2_0.pButton)
	arg_2_0.pButton:setEnabled(false)

	local var_2_3 = display.newSprite(getItemIconPath(ItemType.ePrestige, nil), 320, 265)

	arg_2_0.bgSprite:addChild(var_2_3)

	local var_2_4 = display.newSprite(getItemIconPath(ItemType.eEXP, nil), 492, 265)

	arg_2_0.bgSprite:addChild(var_2_4)

	arg_2_0.resultData = nil

	if arg_2_0.battleType and arg_2_0.battleType == eBattleType.ShenqiRobFragment then
		arg_2_0.resultData = arg_2_0.params.data.RobPlayer

		print("抢夺碎片")
	else
		print("比武战斗奖励 ... ")

		arg_2_0.resultData = arg_2_0.params.data.XianMoBePlayer

		dump(arg_2_0.resultData)
	end

	local var_2_5 = arg_2_0.resultData.prestige
	local var_2_6 = arg_2_0.resultData.exp
	local var_2_7 = ccc3(255, 166, 54)
	local var_2_8 = {
		{
			fontSize = 20,
			y = 266,
			x = 340,
			title = "+" .. var_2_5,
			color = var_2_7,
			size = CCSize(200, 40)
		},
		{
			fontSize = 20,
			y = 266,
			x = 510,
			title = "+" .. var_2_6,
			color = var_2_7,
			size = CCSize(200, 40)
		}
	}

	if arg_2_0.battleType and arg_2_0.battleType == eBattleType.ShenqiRobFragment then
		if arg_2_0.resultData.isGetFragment == 1 then
			table.insert(var_2_8, {
				fontSize = 20,
				y = 300,
				x = 330,
				title = string.lf("获得:#00FF00%s", getItemName(ItemType.eMate, arg_2_0.params.fragmentId)),
				color = var_2_7,
				size = CCSize(250, 40)
			})
		else
			local var_2_9 = display.newSprite("ui/shenqi/sq_061.png", var_2_0, 300)

			arg_2_0.bgSprite:addChild(var_2_9)
		end
	else
		table.insert(var_2_8, {
			fontSize = 20,
			y = 300,
			x = 430,
			align = ui.TEXT_ALIGN_CENTER,
			title = string.lf("比赛积分:#00FF00%s", arg_2_0.resultData.score),
			color = var_2_7,
			size = CCSize(250, 40)
		})
	end

	for iter_2_0 = 1, #var_2_8 do
		local var_2_10 = var_2_8[iter_2_0]
		local var_2_11 = ui.newTTFLabel({
			text = var_2_10.title,
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(var_2_10.fontSize),
			color = var_2_10.color,
			align = var_2_10.align or ui.TEXT_ALIGN_LEFT,
			valign = ui.TEXT_VALIGN_CENTER,
			dimensions = var_2_10.size,
			x = var_2_10.x,
			y = var_2_10.y
		})

		arg_2_0.bgSprite:addChild(var_2_11)
	end

	arg_2_0:showButtonCards()

	local var_2_12 = {
		name = Player.nickName,
		playerID = Player.userId,
		avatarID = Player.team.groupList[Player.headerTeamIndex].heroId,
		battlePower = Player.team.battlePower
	}

	arg_2_0:showHeader(arg_2_0.bgSprite, var_2_12)

	local var_2_13 = {
		name = arg_2_0.resultData.beRobbedPlayer.name,
		playerID = arg_2_0.resultData.beRobbedPlayer.playerID,
		avatarID = arg_2_0.resultData.beRobbedPlayer.avatarID,
		battlePower = arg_2_0.resultData.beRobbedPlayer.battlePower
	}

	arg_2_0:showHeader(arg_2_0.bgSprite, var_2_13)
end

function var_0_3.showHeader(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = ccc3(0, 195, 10)
	local var_4_1 = ccc3(240, 240, 180)
	local var_4_2 = arg_4_1:getContentSize()
	local var_4_3 = getItemHeaderImagePath(ItemType.eHero, arg_4_2.avatarID)
	local var_4_4 = ui.newControlButton({
		normalImage = var_4_3,
		clickAction = function(arg_5_0, arg_5_1)
			return
		end
	})
	local var_4_5 = Player.userId == arg_4_2.playerID and 330 or 560
	local var_4_6 = display.newSprite("ui/common/common_005_2.png", var_4_5, 430)

	arg_4_1:addChild(var_4_6)
	var_4_4:setPosition(var_4_5, 430)
	arg_4_1:addChild(var_4_4)

	local var_4_7 = var_0_1.newLabel({
		text = arg_4_2.name,
		color = var_4_1
	})

	var_4_7:setPosition(var_4_5, 380)
	arg_4_1:addChild(var_4_7)

	local var_4_8 = var_0_1.newLabel({
		text = string.lf("战力: %s", arg_4_2.battlePower),
		color = var_4_1
	})

	var_4_8:setPosition(var_4_5, 360)
	arg_4_1:addChild(var_4_8)
end

function var_0_3.showButtonCards(arg_6_0)
	arg_6_0.buttons = {}

	for iter_6_0 = 1, 3 do
		local var_6_0 = 203 + iter_6_0 * 130 - 25
		local var_6_1 = 155
		local var_6_2 = ui.newControlButton({
			fontSize = 24,
			text = "",
			normalImage = "ui/shenqi/sq_026.png",
			scaleX = 1,
			scaleY = 1,
			position = ccp(var_6_0, var_6_1),
			clickAction = handler(arg_6_0, arg_6_0.buttonClicked),
			anchorPoint = CCPoint(0.5, 0.5)
		})

		var_6_2:setTag(iter_6_0)
		Adapter.NodeAbsScale(var_6_2)
		arg_6_0.bgSprite:addChild(var_6_2)
		table.insert(arg_6_0.buttons, var_6_2)

		local var_6_3 = CCArray:create()

		var_6_3:addObject(CCDelayTime:create(0.3 * iter_6_0))
		var_6_3:addObject(CCScaleTo:create(0.3, 1.15))
		var_6_3:addObject(CCScaleTo:create(0.3, 1))
		var_6_3:addObject(CCDelayTime:create(0.3 * (4 - iter_6_0)))
		var_6_2:runAction(CCRepeatForever:create(CCSequence:create(var_6_3)))
	end
end

function var_0_3.buttonClicked(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = tolua.cast(arg_7_2, "CCControlButton")

	arg_7_0.selectedIndex = var_7_0:getTag()

	arg_7_0:openCard(var_7_0, true)
	arg_7_0:setButtonsEnabled(false)
end

function var_0_3.openCard(arg_8_0, arg_8_1, arg_8_2)
	local function var_8_0()
		for iter_9_0, iter_9_1 in ipairs(arg_8_0.buttons) do
			repeat
				if iter_9_1:getTag() == arg_8_0.selectedIndex then
					break
				end

				arg_8_0:openCard(iter_9_1, false)
			until true
		end
	end

	local function var_8_1()
		arg_8_0.pButton:setEnabled(true)

		for iter_10_0, iter_10_1 in ipairs(arg_8_0.buttons) do
			iter_10_1:setScale(1)
			iter_10_1:stopAllActions()
		end
	end

	local function var_8_2()
		local var_11_0 = "ui/shenqi/sq_030.png"

		arg_8_1:setBackgroundSpriteForState(CCScale9Sprite:create(var_11_0), CCControlStateNormal)
		arg_8_1:setBackgroundSpriteForState(CCScale9Sprite:create(var_11_0), CCControlStateHighlighted)
		arg_8_1:setBackgroundSpriteForState(CCScale9Sprite:create(var_11_0), CCControlStateDisabled)
		arg_8_0:showCardInfo(arg_8_1, arg_8_2)
	end

	local var_8_3 = CCArray:create()
	local var_8_4 = CCOrbitCamera:create(0.4, 1, 0, 0, 90, 0, 0)

	var_8_3:addObject(var_8_4)
	var_8_3:addObject(CCCallFunc:create(var_8_2))
	var_8_3:addObject(var_8_4:reverse())

	if arg_8_2 then
		var_8_3:addObject(CCCallFunc:create(var_8_0))
	else
		var_8_3:addObject(CCCallFunc:create(var_8_1))
	end

	arg_8_1:runAction(CCSequence:create(var_8_3))
end

function var_0_3.setButtonsEnabled(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.buttons) do
		iter_12_1:setEnabled(arg_12_1)
	end
end

function var_0_3.showCardInfo(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1:getTag()
	local var_13_1

	if arg_13_2 then
		var_13_1 = arg_13_0.resultData.openReward[1]
	else
		local var_13_2 = arg_13_0.unOpen == true and 2 or 1

		var_13_1 = arg_13_0.resultData.notOpenRewards[var_13_2][1]
		arg_13_0.unOpen = true
	end

	local var_13_3 = {
		isName = false,
		type = var_13_1.Type,
		itemId = var_13_1.ID,
		count = var_13_1.Count,
		isSelected = arg_13_2,
		clickAction = function(arg_14_0, arg_14_1)
			var_0_2.tipshandler(var_13_1)
		end
	}
	local var_13_4 = figure.createHeader(var_13_3)

	var_13_4:setPosition(60, 70)
	var_13_4:setAnchorPoint(ccp(0.5, 0.5))
	arg_13_1:addChild(var_13_4)
	Adapter.NodeAbsScale(var_13_4)
end

return var_0_3
