require("scenes.battle.BattleData")

local var_0_0 = class("BattleUILayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0)
	return
end

function var_0_0.afkButton(arg_3_0, arg_3_1)
	arg_3_0.afkType = arg_3_1

	local var_3_0 = {
		[2] = "ui/battle/battle_031.png",
		[1] = "ui/battle/battle_036.png"
	}
	local var_3_1 = arg_3_0:getParent():getAFGstate() and 1 or 2
	local var_3_2

	var_3_2 = ui.newControlButton({
		normalImage = var_3_0[var_3_1],
		highlightedImage = var_3_0[var_3_1],
		clickAction = function(arg_4_0, arg_4_1)
			if arg_3_0:getParent():getAFGstate() then
				arg_3_0:getParent():awayFromGame(false)
			else
				arg_3_0:getParent():awayFromGame(true)
			end

			local var_4_0 = arg_3_0:getParent():getAFGstate() and 1 or 2

			var_3_2:setBackgroundSpriteForState(CCScale9Sprite:create(var_3_0[var_4_0]), CCControlStateNormal)
			var_3_2:setBackgroundSpriteForState(CCScale9Sprite:create(var_3_0[var_4_0]), CCControlStateHighlighted)
			var_3_2:setScaleAsSprite(true)

			if arg_3_0.afkType then
				for iter_4_0, iter_4_1 in pairs(arg_3_0.heroList) do
					iter_4_1.clickButton:setEnabled(false)
				end

				arg_3_0.startButton:setVisible(false)
				arg_3_0:getParent():onFinishFormation()
				var_3_2:setVisible(false)
			end
		end,
		scaleX = 1 * Adapter.MinScale,
		scaleY = 1 * Adapter.MinScale,
		position = CCPoint(Adapter.AutoPos(850, 500))
	})

	arg_3_0:addChild(var_3_2)

	arg_3_0.tuoguan = var_3_2
end

function var_0_0.init(arg_5_0, arg_5_1)
	arg_5_0.heroList = arg_5_1

	arg_5_0:afkButton(true)

	local var_5_0 = ui.newControlButton({
		normalImage = "ui/battle/icon_go.png",
		clickAction = function(arg_6_0, arg_6_1)
			for iter_6_0, iter_6_1 in pairs(arg_5_1) do
				iter_6_1.clickButton:setEnabled(false)
			end

			tolua.cast(arg_6_1, "CCControlButton"):setVisible(false)
			arg_5_0.tuoguan:setVisible(false)
			arg_5_0:getParent():onFinishFormation()
		end,
		scaleX = Adapter.MinScale,
		scaleY = Adapter.MinScale,
		position = CCPoint(750 * Adapter.AutoScaleX, display.cy)
	})

	arg_5_0:addChild(var_5_0)

	arg_5_0.startButton = var_5_0

	local var_5_1 = CCArray:create()

	var_5_1:addObject(CCMoveBy:create(0.3, Adapter.MinPos(50, 0)))
	var_5_1:addObject(CCMoveBy:create(0.3, Adapter.MinPos(-50, 0)))
	var_5_0:runAction(CCRepeatForever:create(CCSequence:create(var_5_1)))

	local var_5_2 = CCArray:create()

	var_5_2:addObject(CCScaleTo:create(0.3, 0.95))
	var_5_2:addObject(CCScaleTo:create(0.3, 1))
	var_5_0:runAction(CCRepeatForever:create(CCSequence:create(var_5_2)))
end

function var_0_0.battle(arg_7_0, arg_7_1)
	if arg_7_0.tuoguan then
		arg_7_0.tuoguan:removeFromParentAndCleanup(true)
	end

	arg_7_0:afkButton(false)

	local var_7_0 = {
		"ui/battle/battle_032.png",
		"ui/battle/battle_034.png",
		"ui/battle/battle_035.png"
	}

	local function var_7_1()
		if BattleSpeed == BattleSpeedOriginal then
			return 1
		elseif BattleSpeed == 0.5 then
			return 2
		end
	end

	local var_7_2 = var_7_1()
	local var_7_3

	var_7_3 = ui.newControlButton({
		normalImage = var_7_0[var_7_2],
		highlightedImage = var_7_0[var_7_2],
		clickAction = function(arg_9_0, arg_9_1)
			if BattleSpeed == BattleSpeedOriginal then
				BattleSpeed = 0.5
			else
				BattleSpeed = BattleSpeedOriginal
			end

			var_7_2 = var_7_1()

			var_7_3:setBackgroundSpriteForState(CCScale9Sprite:create(var_7_0[var_7_2]), CCControlStateNormal)
			var_7_3:setBackgroundSpriteForState(CCScale9Sprite:create(var_7_0[var_7_2]), CCControlStateHighlighted)
			var_7_3:setScaleAsSprite(true)

			for iter_9_0, iter_9_1 in pairs(BattleData.displayHero) do
				BattleSkeleton.updateSpeed(iter_9_1.Skeleton)
			end

			for iter_9_2, iter_9_3 in pairs(BattleData.displayEnemy) do
				BattleSkeleton.updateSpeed(iter_9_3.Skeleton)
			end
		end,
		scaleX = 1 * Adapter.MinScale,
		scaleY = 1 * Adapter.MinScale,
		position = CCPoint(Adapter.AutoPos(100, 500))
	})

	arg_7_0:addChild(var_7_3)

	arg_7_0.sudu = var_7_3

	local var_7_4 = ui.newControlButton({
		highlightedImage = "ui/battle/battle_033.png",
		normalImage = "ui/battle/battle_033.png",
		clickAction = function(arg_10_0, arg_10_1)
			arg_7_0:getParent().finishGame = true

			local var_10_0 = tolua.cast(arg_10_1, "CCControlButton")

			arg_7_0.tiaoguo = nil

			var_10_0:removeFromParentAndCleanup(true)
		end,
		scaleX = 1 * Adapter.MinScale,
		scaleY = 1 * Adapter.MinScale,
		position = CCPoint(Adapter.AutoPos(480, 100))
	})

	arg_7_0:addChild(var_7_4)

	if arg_7_0:getParent().params.canSkip then
		var_7_4:setVisible(true)
	else
		var_7_4:setVisible(false)
	end

	arg_7_0.tiaoguo = var_7_4

	local var_7_5 = CCSprite:create("ui/battle/battle_017.png")

	var_7_5:setPosition(display.cx, display.height)
	var_7_5:setAnchorPoint(CCPoint(0.5, 1))
	var_7_5:setScale(Adapter.MinScale)
	arg_7_0:addChild(var_7_5)

	local var_7_6 = CCLabelTTF:create(string.lf("回合数\n%d/20", BattleData.round), _FONT_DEFAULT, Adapter.FontSize(27))

	var_7_6:setColor(ccc3(255, 248, 165))

	local var_7_7, var_7_8 = var_7_5:getPosition()

	var_7_6:setPosition(var_7_7, var_7_8 - 70 * Adapter.MinScale)
	arg_7_0:addChild(var_7_6, 10)
	Adapter.NodeAbsScale(var_7_6)

	arg_7_0.heroCount = var_7_6

	local var_7_9 = CCSprite:create("ui/battle/battle_012.png")

	var_7_9:setScale(Adapter.MinScale)
	arg_7_0:addChild(var_7_9)

	local var_7_10 = CCSprite:create("ui/battle/battle_010.png")
	local var_7_11 = CCProgressTimer:create(var_7_10)

	var_7_11:setType(kCCProgressTimerTypeBar)
	var_7_11:setMidpoint(CCPoint(0, 0))
	var_7_11:setBarChangeRate(CCPoint(1, 0))
	var_7_11:setPercentage(100)

	arg_7_0.leftBar = var_7_11

	local var_7_12, var_7_13 = var_7_5:getPosition()

	var_7_11:setPosition(var_7_12 - 260 * Adapter.MinScale, var_7_13 - 85 * Adapter.MinScale)
	var_7_9:setPosition(var_7_12 - 260 * Adapter.MinScale, var_7_13 - 85 * Adapter.MinScale)
	arg_7_0:addChild(var_7_11)
	var_7_11:setRotationY(180)
	var_7_11:setScale(Adapter.MinScale)

	local var_7_14 = ui.newTTFLabelWithOutline({
		text = formatViewHp(BattleData:countCurrentHP(true), BattleData:countTotalHP(true)),
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(20),
		align = ui.TEXT_ALIGN_CENTER
	})

	arg_7_0:addChild(var_7_14)
	var_7_14:setPosition(var_7_12 - 260 * Adapter.MinScale, var_7_13 - 85 * Adapter.MinScale)
	var_7_14:setVisible(false)

	arg_7_0.total_left = var_7_14

	local var_7_15 = CCSprite:create("ui/battle/battle_012.png")

	var_7_15:setScale(Adapter.MinScale)
	arg_7_0:addChild(var_7_15)

	local var_7_16 = CCSprite:create("ui/battle/battle_011.png")
	local var_7_17 = CCProgressTimer:create(var_7_16)

	var_7_17:setType(kCCProgressTimerTypeBar)
	var_7_17:setMidpoint(CCPoint(0, 0))
	var_7_17:setBarChangeRate(CCPoint(1, 0))
	var_7_17:setPercentage(100)

	arg_7_0.rightBar = var_7_17

	local var_7_18, var_7_19 = var_7_5:getPosition()

	var_7_17:setPosition(var_7_18 + 260 * Adapter.MinScale, var_7_19 - 85 * Adapter.MinScale)
	var_7_15:setPosition(var_7_18 + 260 * Adapter.MinScale, var_7_19 - 85 * Adapter.MinScale)
	arg_7_0:addChild(var_7_17)
	var_7_17:setScale(Adapter.MinScale)

	local var_7_20 = ui.newTTFLabelWithOutline({
		text = formatViewHp(BattleData:countCurrentHP(false), BattleData:countTotalHP(false)),
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(20),
		align = ui.TEXT_ALIGN_CENTER
	})

	arg_7_0:addChild(var_7_20)
	var_7_20:setPosition(var_7_18 + 260 * Adapter.MinScale, var_7_19 - 85 * Adapter.MinScale)
	var_7_20:setVisible(false)

	arg_7_0.total_right = var_7_20

	local var_7_21 = ui.newTTFLabelWithOutline({
		text = BattleData.playerName or Player.nickName,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(26),
		align = ui.TEXT_ALIGN_CENTER
	})

	var_7_21:setColor(ccc3(255, 248, 165))
	var_7_21:setPosition(var_7_18 - 260 * Adapter.MinScale, var_7_19 - 50 * Adapter.MinScale)
	arg_7_0:addChild(var_7_21, 10)
	Adapter.NodeAbsScale(var_7_21)

	arg_7_0.label_name_left = var_7_21

	local var_7_22
	local var_7_23

	if BattleData.enemyName then
		var_7_22 = BattleData.enemyName.Name

		local var_7_24 = BattleData.enemyName.Vip
	elseif type(arg_7_1.battlename) == "table" then
		var_7_22 = arg_7_1.battlename[BattleData.stage]
	else
		var_7_22 = arg_7_1.battlename
	end

	local var_7_25 = ui.newTTFLabelWithOutline({
		text = var_7_22,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(26),
		align = ui.TEXT_ALIGN_CENTER
	})

	var_7_25:setColor(ccc3(255, 248, 165))
	var_7_25:setPosition(var_7_18 + 260 * Adapter.MinScale, var_7_19 - 50 * Adapter.MinScale)
	arg_7_0:addChild(var_7_25, 10)
	Adapter.NodeAbsScale(var_7_25)

	arg_7_0.label_name_right = var_7_25

	local var_7_26 = ui.newTTFLabelWithOutline({
		text = string.lf("出战   %d/%d", BattleData.numHero, BattleData.numHero),
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(20),
		align = ui.TEXT_ALIGN_CENTER
	})

	var_7_26:setColor(ccc3(255, 248, 165))
	var_7_26:setPosition(var_7_18 - 180 * Adapter.MinScale, var_7_19 - 15 * Adapter.MinScale)
	arg_7_0:addChild(var_7_26, 10)
	Adapter.NodeAbsScale(var_7_26)

	arg_7_0.label_left = var_7_26

	local var_7_27 = ui.newTTFLabelWithOutline({
		text = string.lf("%d/%d   出战", BattleData.numEnemy, BattleData.numEnemy),
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(20),
		align = ui.TEXT_ALIGN_CENTER
	})

	var_7_27:setColor(ccc3(255, 248, 165))
	var_7_27:setPosition(var_7_18 + 180 * Adapter.MinScale, var_7_19 - 15 * Adapter.MinScale)
	arg_7_0:addChild(var_7_27, 10)
	Adapter.NodeAbsScale(var_7_27)

	arg_7_0.label_right = var_7_27

	local function var_7_28(arg_11_0)
		local var_11_0 = 0

		if arg_11_0 == BattleCarrier.eBajiaoshan1 then
			var_11_0 = 53
		elseif arg_11_0 == BattleCarrier.eBajiaoshan2 then
			var_11_0 = 58
		elseif arg_11_0 == BattleCarrier.eHulu1 then
			var_11_0 = 56
		elseif arg_11_0 == BattleCarrier.eHulu2 then
			var_11_0 = 61
		elseif arg_11_0 == BattleCarrier.eJian1 then
			var_11_0 = 57
		elseif arg_11_0 == BattleCarrier.eJian2 then
			var_11_0 = 62
		elseif arg_11_0 == BattleCarrier.eYujingping1 then
			var_11_0 = 54
		elseif arg_11_0 == BattleCarrier.eYujingping2 then
			var_11_0 = 59
		elseif arg_11_0 == BattleCarrier.eYuruyi1 then
			var_11_0 = 55
		elseif arg_11_0 == BattleCarrier.eYuruyi2 then
			var_11_0 = 60
		end

		return string.format("ui/battle/battle_0%d.png", var_11_0)
	end

	local function var_7_29(arg_12_0, arg_12_1)
		return string.format("%s +%d", BaseShenQi[arg_12_0].name, arg_12_1)
	end

	local var_7_30 = 0
	local var_7_31 = 0

	if BattleData.shenqiList then
		for iter_7_0, iter_7_1 in pairs(BattleData.shenqiList) do
			if iter_7_1.posId <= 6 then
				var_7_31 = iter_7_1.lv
				var_7_30 = iter_7_1.star

				break
			end
		end
	end

	if var_7_31 ~= 0 then
		local var_7_32 = CCSprite:create("ui/battle/battle_063.png")

		var_7_32:setPosition(Adapter.AutoPos(300, 500))
		var_7_32:setScale(Adapter.MinScale)
		arg_7_0:addChild(var_7_32)

		arg_7_0.shenqiBG1 = var_7_32

		local var_7_33 = CCSprite:create(var_7_28(var_7_31))

		var_7_33:setPosition(Adapter.AutoPos(300, 500))
		var_7_33:setScale(Adapter.MinScale)
		arg_7_0:addChild(var_7_33)

		arg_7_0.shenqiIcon1 = var_7_33

		local var_7_34 = ui.newTTFLabelWithOutline({
			text = var_7_29(var_7_31, var_7_30),
			font = _FONT_LISU,
			size = Adapter.FontSize(15),
			align = ui.TEXT_ALIGN_CENTER
		})

		arg_7_0:addChild(var_7_34)
		var_7_34:setColor(ccc3(189, 168, 50))
		var_7_34:setPosition(Adapter.AutoPos(300, 470))
	end

	local var_7_35 = 0
	local var_7_36 = 0

	if BattleData.shenqiList then
		for iter_7_2, iter_7_3 in pairs(BattleData.shenqiList) do
			if iter_7_3.posId > 6 then
				var_7_36 = iter_7_3.star
				var_7_35 = iter_7_3.lv

				break
			end
		end
	end

	if var_7_35 ~= 0 then
		local var_7_37 = CCSprite:create("ui/battle/battle_063.png")

		var_7_37:setPosition(Adapter.AutoPos(660, 500))
		var_7_37:setScale(Adapter.MinScale)
		arg_7_0:addChild(var_7_37)

		arg_7_0.shenqiBG2 = var_7_37

		local var_7_38 = CCSprite:create(var_7_28(var_7_35))

		var_7_38:setPosition(Adapter.AutoPos(660, 500))
		var_7_38:setScale(Adapter.MinScale)
		arg_7_0:addChild(var_7_38)

		arg_7_0.shenqiIcon2 = var_7_38

		local var_7_39 = ui.newTTFLabelWithOutline({
			text = var_7_29(var_7_35, var_7_36),
			font = _FONT_LISU,
			size = Adapter.FontSize(15),
			align = ui.TEXT_ALIGN_CENTER
		})

		arg_7_0:addChild(var_7_39)
		var_7_39:setColor(ccc3(189, 168, 50))
		var_7_39:setPosition(Adapter.AutoPos(660, 470))
	end

	arg_7_0:refreshLabel()
	arg_7_0:refreshProgress()
end

function var_0_0.shenqiAnimation(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0
	local var_13_1
	local var_13_2 = arg_13_1.posId <= 6 and true or false

	if var_13_2 and arg_13_0.shenqiIcon1 then
		var_13_0 = arg_13_0.shenqiIcon1

		local var_13_3 = arg_13_0.shenqiBG1
	end

	if not var_13_2 and arg_13_0.shenqiIcon2 then
		var_13_0 = arg_13_0.shenqiIcon2

		local var_13_4 = arg_13_0.shenqiBG2
	end

	var_13_0:runAction(CCFadeOut:create(0.4 * BattleSpeed))

	local var_13_5 = CCSprite:create(queryCarrierFile(arg_13_1.lv))

	var_13_5:setPosition(var_13_0:getPosition())
	var_13_5:setScale(0.1 * Adapter.MinScale)
	arg_13_0:addChild(var_13_5)
	var_13_5:runAction(CCScaleTo:create(0.4 * BattleSpeed, 1 * Adapter.MinScale))

	local var_13_6 = CCArray:create()

	var_13_6:addObject(CCFadeTo:create(0.4 * BattleSpeed, 128))
	var_13_6:addObject(CCCallFunc:create(function(...)
		var_13_5:runAction(CCFadeTo:create(0.1 * BattleSpeed, 0))
	end))
	var_13_6:addObject(CCScaleTo:create(0.1 * BattleSpeed, 1.2 * Adapter.MinScale))
	var_13_6:addObject(CCCallFunc:create(function(...)
		if arg_13_2 then
			arg_13_2()
		end
	end))
	var_13_5:runAction(CCSequence:create(var_13_6))
end

function var_0_0.shenqiEnd(arg_16_0, arg_16_1)
	local var_16_0
	local var_16_1
	local var_16_2 = arg_16_1.posId <= 6 and true or false

	if var_16_2 and arg_16_0.shenqiIcon1 then
		var_16_0 = arg_16_0.shenqiIcon1

		local var_16_3 = arg_16_0.shenqiBG1
	end

	if not var_16_2 and arg_16_0.shenqiIcon2 then
		var_16_0 = arg_16_0.shenqiIcon2

		local var_16_4 = arg_16_0.shenqiBG2
	end

	var_16_0:setScale(0.1)
	var_16_0:setOpacity(255)
	var_16_0:runAction(CCEaseElasticOut:create(CCScaleTo:create(0.5 * BattleSpeed, 1 * Adapter.MinScale)))
end

function var_0_0.createVip(arg_17_0, arg_17_1)
	local var_17_0 = CCNode:create()
	local var_17_1 = ui.newTTFLabelWithOutline({
		text = "VIP" .. arg_17_1,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(20),
		align = ui.TEXT_ALIGN_CENTER
	})

	var_17_0:addChild(var_17_1)
	var_17_1:setColor(ccc3(255, 248, 165))

	return var_17_0
end

function var_0_0.addRoundView(arg_18_0)
	arg_18_0.heroCount:setString(string.lf("回合数\n%d/20", BattleData.round))
	arg_18_0.heroCount:stopAllActions()
	arg_18_0.heroCount:setColor(ccc3(255, 255, 255))

	if BattleData.round < 10 then
		local var_18_0 = CCArray:create()

		var_18_0:addObject(CCCallFunc:create(function(...)
			arg_18_0.heroCount:setColor(ccc3(255, 0, 0))
		end))
		var_18_0:addObject(CCDelayTime:create(0.2))
		var_18_0:addObject(CCCallFunc:create(function(...)
			arg_18_0.heroCount:setColor(ccc3(255, 255, 255))
		end))
		arg_18_0.heroCount:runAction(CCSequence:create(var_18_0))
	elseif BattleData.round < 15 then
		local var_18_1 = CCArray:create()

		var_18_1:addObject(CCCallFunc:create(function(...)
			arg_18_0.heroCount:setColor(ccc3(255, 0, 0))
		end))
		var_18_1:addObject(CCDelayTime:create(0.2))
		var_18_1:addObject(CCCallFunc:create(function(...)
			arg_18_0.heroCount:setColor(ccc3(255, 255, 255))
		end))
		var_18_1:addObject(CCDelayTime:create(5))
		arg_18_0.heroCount:runAction(CCRepeatForever:create(CCSequence:create(var_18_1)))
	elseif BattleData.round < 20 then
		local var_18_2 = CCArray:create()

		var_18_2:addObject(CCCallFunc:create(function(...)
			arg_18_0.heroCount:setColor(ccc3(255, 0, 0))
		end))
		var_18_2:addObject(CCDelayTime:create(0.2))
		var_18_2:addObject(CCCallFunc:create(function(...)
			arg_18_0.heroCount:setColor(ccc3(255, 255, 255))
		end))
		var_18_2:addObject(CCDelayTime:create(5 * (20 - BattleData.round) / 5))
		arg_18_0.heroCount:runAction(CCRepeatForever:create(CCSequence:create(var_18_2)))
	else
		arg_18_0.heroCount:setColor(ccc3(255, 0, 0))
	end
end

function var_0_0.buttonVisible(arg_25_0, arg_25_1)
	if arg_25_0.tiaoguo then
		arg_25_0.tiaoguo:setVisible(arg_25_1)
	end

	arg_25_0.sudu:setVisible(arg_25_1)
	arg_25_0.tuoguan:setVisible(arg_25_1)

	if arg_25_1 and arg_25_0:getParent().params.canSkip then
		if arg_25_0.tiaoguo then
			arg_25_0.tiaoguo:setVisible(true)
		end
	elseif arg_25_0.tiaoguo then
		arg_25_0.tiaoguo:setVisible(false)
	end
end

function var_0_0.refreshLabel(arg_26_0, arg_26_1)
	if arg_26_1 and arg_26_1.left1 and arg_26_1.left2 then
		arg_26_0.label_left:setString(string.lf("出战   %s/%s", arg_26_1.left1, arg_26_1.left2))
	else
		local var_26_0 = 0

		table.foreach(BattleData.Heros, function(arg_27_0, arg_27_1)
			if arg_27_1.currentHealth > 0 then
				var_26_0 = var_26_0 + 1
			end
		end)
		arg_26_0.label_left:setString(string.lf("出战   %d/%d", var_26_0, BattleData.numHero))
	end

	if arg_26_1 and arg_26_1.right1 and arg_26_1.right2 then
		arg_26_0.label_right:setString(string.lf("%s/%s   出战", arg_26_1.right1, arg_26_1.right2))
	else
		local var_26_1 = 0

		table.foreach(BattleData.enemy, function(arg_28_0, arg_28_1)
			if arg_28_1.currentHealth > 0 then
				var_26_1 = var_26_1 + 1
			end
		end)
		arg_26_0.label_right:setString(string.lf("%s/%s   出战", var_26_1, BattleData.numEnemy))
	end
end

function var_0_0.refreshProgress(arg_29_0)
	local var_29_0 = BattleData:countCurrentHP(true)
	local var_29_1 = BattleData:countTotalHP(true)

	arg_29_0.total_left:setString(formatViewHp(var_29_0, var_29_1))
	arg_29_0.leftBar:runAction(CCProgressFromTo:create(0.5 * BattleSpeed, arg_29_0.leftBar:getPercentage(), var_29_0 / var_29_1 * 100))

	local var_29_2 = BattleData:countCurrentHP(false)
	local var_29_3 = BattleData:countTotalHP(false)

	arg_29_0.total_right:setString(formatViewHp(var_29_2, var_29_3))
	arg_29_0.rightBar:runAction(CCProgressFromTo:create(0.5 * BattleSpeed, arg_29_0.rightBar:getPercentage(), var_29_2 / var_29_3 * 100))
end

return var_0_0
