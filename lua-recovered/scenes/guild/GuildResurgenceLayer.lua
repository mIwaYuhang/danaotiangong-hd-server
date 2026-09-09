local var_0_0 = class("GuildResurgenceLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.isKing = arg_2_1.isKing
	arg_2_0.bossInfo = arg_2_1.bossInfo
	arg_2_0.parentScene = arg_2_1.parentScene

	if arg_2_0.parentScene then
		arg_2_0.parmas = arg_2_1
		arg_2_0.bossInfo = arg_2_1.bossInfo
	end

	if arg_2_0.isKing then
		arg_2_0:initKingNetworkInterface()
	else
		arg_2_0:initNetworkInterface()
	end

	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	local var_2_0 = display.newColorLayer(ccc4(0, 0, 0, 128))

	arg_2_0:addChild(var_2_0)

	arg_2_0.fixOffsety = 0

	if arg_2_0.parentScene then
		if arg_2_0.parmas.result == true then
			arg_2_0.fixOffsety = 60
		else
			arg_2_0.fixOffsety = 100
		end
	end

	arg_2_0.nodeSize = Adapter.MinSize(480, 220 + arg_2_0.fixOffsety)

	local var_2_1 = "ui/common/common_050.png"

	if arg_2_0.parentScene and arg_2_0.parmas.result == true then
		local var_2_2 = display.newSprite("ui/battle/battle_038.png", display.cx, 120 * Adapter.MinScale)

		var_2_2:setAnchorPoint(ccp(0.5, 0))
		var_2_2:setScale(Adapter.MinScale)
		arg_2_0:addChild(var_2_2)

		local var_2_3 = display.newSprite("uilocal/battle/battle_text_001.png")

		var_2_3:align(display.CENTER_BOTTOM, 480, 260)
		var_2_2:addChild(var_2_3)

		arg_2_0.bgSprite = display.newNode()

		arg_2_0.bgSprite:setContentSize(arg_2_0.nodeSize)
		arg_2_0.bgSprite:setPosition(ccp(display.cx, 120 * Adapter.MinScale))
		arg_2_0.bgSprite:setAnchorPoint(ccp(0.5, 0))
		arg_2_0:addChild(arg_2_0.bgSprite)
	else
		arg_2_0.bgSprite = display.newScale9Sprite("ui/common/common_050.png", display.cx, display.cy, arg_2_0.nodeSize)

		arg_2_0:addChild(arg_2_0.bgSprite)
	end

	arg_2_0:initUI()
	arg_2_0:appearAnimation()
end

function var_0_0.startBattle(arg_4_0)
	local var_4_0 = arg_4_0.bossInfo

	local function var_4_1(arg_5_0, arg_5_1, arg_5_2)
		game.enterGuildBossPreviewScene({
			bossInfo = var_4_0,
			resurgenceResult = arg_5_1,
			isKing = arg_4_0.isKing
		})
	end

	if arg_4_0.isKing then
		require("scenes.battle.BattleOperator"):startBattle(eBattleType.guildKing, {
			battleType = 2,
			demonID = arg_4_0.bossInfo.demonID,
			bossInfo = arg_4_0.bossInfo
		}, var_4_1)
	else
		require("scenes.battle.BattleOperator"):startBattle(eBattleType.guildBOSS, {
			battleType = 2,
			demonID = arg_4_0.bossInfo.demonID,
			bossInfo = arg_4_0.bossInfo
		}, var_4_1)
	end
end

function var_0_0.initUI(arg_6_0)
	local var_6_0
	local var_6_1
	local var_6_2
	local var_6_3

	if arg_6_0.parentScene then
		var_6_0 = arg_6_0.parmas.data.DemonChallenge.remainResurgenceTime
		var_6_1 = arg_6_0.parmas.data.DemonChallenge.resurgenceGold
		var_6_2 = arg_6_0.parmas.data.DemonChallenge.resurgenceIngot
		var_6_3 = string.lf("上仙，本次挑战失败，你还可以复活%d次，是否复活？", var_6_0)

		if arg_6_0.parmas.result == true then
			var_6_3 = string.lf("上仙，魔族已经被击杀，掉落的奖励已放入仙盟商店的魔族宝物中，是否前往购买？")
		end
	else
		var_6_0 = arg_6_0.bossInfo.remainResurgenceTime
		var_6_1 = arg_6_0.bossInfo.resurgenceGold
		var_6_2 = arg_6_0.bossInfo.resurgenceIngot
		var_6_3 = string.lf("上仙，上次挑战失败，你还可以复活%d次，是否复活？", var_6_0)
	end

	local var_6_4 = addLabelWithColorSize(arg_6_0.bgSprite, var_6_3, ccc3(255, 255, 255), 20, ccp(0, 0.5), Adapter.MinPos(20, 170 + arg_6_0.fixOffsety))

	var_6_4:setHorizontalAlignment(kCCTextAlignmentLeft)
	var_6_4:setDimensions(Adapter.MinSize(440, 50))

	if arg_6_0.parentScene then
		local var_6_5 = addLabelWithColorSize(arg_6_0.bgSprite, string.lf("获得晶石：%s", arg_6_0.parmas.data.DemonChallenge.challengePlayerCoin), ccc3(255, 255, 255), 20, ccp(0, 0.5), Adapter.MinPos(20, 105 + arg_6_0.fixOffsety))
		local var_6_6 = addLabelWithColorSize(arg_6_0.bgSprite, string.lf("获得银币：%s", arg_6_0.parmas.data.DemonChallenge.challengeGold), ccc3(255, 255, 255), 20, ccp(0, 0.5), Adapter.MinPos(270, 105 + arg_6_0.fixOffsety))
		local var_6_7 = addLabelWithColorSize(arg_6_0.bgSprite, string.lf("魔族剩余血量：%s", arg_6_0.parmas.data.DemonChallenge.leftHP), ccc3(255, 255, 255), 20, ccp(0, 0.5), Adapter.MinPos(20, 70 + arg_6_0.fixOffsety))

		if arg_6_0.parmas.result == true and arg_6_0.parmas.isKing == true then
			var_6_7:setString(string.lf("魔族剩余血量：%0"))
		end

		local var_6_8 = string.lf("伤害：%d", arg_6_0.parmas.data.DemonChallenge.hp)
		local var_6_9 = addLabelWithColorSize(arg_6_0.bgSprite, var_6_8, ccc3(255, 255, 255), 20, ccp(0, 0.5), Adapter.MinPos(270, 70 + arg_6_0.fixOffsety))
	end

	if arg_6_0.parentScene and arg_6_0.parmas.result == true then
		-- block empty
	else
		addLabelWithColorSize(arg_6_0.bgSprite, string.lf("复活消耗:"), ccc3(255, 255, 255), 20, ccp(0, 0.5), Adapter.MinPos(20, 110))

		local var_6_10 = createItemCountNode({
			color = ccc3(255, 255, 0),
			type = ItemType.eCoin,
			value = var_6_1
		})

		var_6_10:setPosition(Adapter.MinPos(135, 110))
		var_6_10:setScale(Adapter.MinScale)
		var_6_10:setAnchorPoint(ccp(0.5, 0.5))
		arg_6_0.bgSprite:addChild(var_6_10)

		if var_6_2 >= 0 then
			local var_6_11 = createItemCountNode({
				color = ccc3(255, 255, 0),
				type = ItemType.eGold,
				value = var_6_2
			})

			var_6_11:setPosition(Adapter.MinPos(260, 110))
			var_6_11:setAnchorPoint(ccp(0.5, 0.5))
			var_6_11:setScale(Adapter.MinScale)
			arg_6_0.bgSprite:addChild(var_6_11)
		end
	end

	local var_6_12 = ui.newControlButton({
		normalImage = "ui/common/common_018.png",
		text = string.lf("确定"),
		scaleX = Adapter.MinScale,
		scaleY = Adapter.MinScale,
		clickAction = function(arg_7_0, arg_7_1)
			if arg_6_0.parentScene then
				game.enterGuildBossPreviewScene({
					bossInfo = arg_6_0.bossInfo,
					isKing = arg_6_0.isKing
				})
			else
				arg_6_0:removeFromParentAndCleanup(true)
			end
		end
	})

	var_6_12:setPosition(arg_6_0.nodeSize.width / 2, 50 * Adapter.MinScale)
	arg_6_0.bgSprite:addChild(var_6_12)

	local var_6_13 = string.lf("复活")
	local var_6_14 = string.lf("放弃复活")

	if arg_6_0.parentScene and arg_6_0.parmas.result == true then
		var_6_13 = string.lf("确定")
		var_6_14 = string.lf("前往")
	end

	local var_6_15 = ui.newControlButton({
		normalImage = "ui/common/common_018.png",
		text = var_6_13,
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		scaleX = Adapter.MinScale,
		scaleY = Adapter.MinScale,
		clickAction = function(arg_8_0, arg_8_1)
			if arg_6_0.parentScene and arg_6_0.parmas.result == true then
				arg_6_0.bossInfo.challengeStatus = DemonChallengeStatus.ePassed

				game.enterGuildBossPreviewScene({
					bossInfo = arg_6_0.bossInfo,
					isKing = arg_6_0.isKing
				})
			else
				local var_8_0

				if arg_6_0.parentScene then
					var_8_0 = arg_6_0.parmas.demonID
				else
					var_8_0 = arg_6_0.bossInfo.demonID
				end

				arg_6_0.resurgenRequest:requestDemonResurgence(var_8_0)
			end
		end
	})

	var_6_15:setPosition(arg_6_0.nodeSize.width / 2 - 100 * Adapter.MinScale, 50 * Adapter.MinScale)
	arg_6_0.bgSprite:addChild(var_6_15)

	local var_6_16 = ui.newControlButton({
		normalImage = "ui/common/common_018.png",
		text = var_6_14,
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		scaleX = Adapter.MinScale,
		scaleY = Adapter.MinScale,
		clickAction = function(arg_9_0, arg_9_1)
			if arg_6_0.parentScene and arg_6_0.parmas.result == true then
				game.enterGuildStoreScene({
					tabPageTag = 3
				})
			else
				arg_6_0:isGiveupRescurgence()
			end
		end
	})

	var_6_16:setPosition(arg_6_0.nodeSize.width / 2 + 100 * Adapter.MinScale, 50 * Adapter.MinScale)
	arg_6_0.bgSprite:addChild(var_6_16)

	if var_6_0 == 0 then
		var_6_15:setEnabled(false)
		var_6_15:setVisible(false)
		var_6_16:setEnabled(false)
		var_6_16:setVisible(false)
		var_6_12:setVisible(true)
	else
		var_6_15:setEnabled(true)
		var_6_16:setEnabled(true)
		var_6_12:setVisible(false)
	end
end

function var_0_0.isGiveupRescurgence(arg_10_0)
	local var_10_0

	if arg_10_0.parentScene then
		var_10_0 = arg_10_0.parmas.data.DemonChallenge.remainChallengeTime
	else
		var_10_0 = arg_10_0.bossInfo.remainChallengeTime
	end

	local var_10_1 = string.lf("是否放弃本次挑战，放弃的话本次挑战将不再继续，您现在还有%d次挑战次数。", var_10_0)

	ui.showMessageBox({
		text = var_10_1,
		title1 = string.lf("取消"),
		parent = arg_10_0,
		title2 = string.lf("确定"),
		action2 = function()
			local var_11_0

			if arg_10_0.parentScene then
				var_11_0 = arg_10_0.parmas.demonID
			else
				var_11_0 = arg_10_0.bossInfo.demonID
			end

			arg_10_0.giveupRequest:requestDemonGiveUp(var_11_0)
		end
	})
end

function var_0_0.initKingNetworkInterface(arg_12_0)
	local function var_12_0()
		if arg_12_0.parentScene then
			arg_12_0.parentScene:reBattle()
			arg_12_0:removeFromParentAndCleanup(true)

			return
		end

		local var_13_0 = arg_12_0.resurgenRequest:getResurgenceResult()

		arg_12_0:startBattle()
	end

	local function var_12_1(arg_14_0)
		if arg_14_0 == -11430020 then
			ui.showMessageBox({
				text = string.lf("上仙，该Boss已被击杀，掉落宝物已放入魔族商店中，是否前往竞拍?"),
				title1 = string.lf("取消"),
				parent = arg_12_0,
				title2 = string.lf("确定"),
				action1 = function()
					arg_12_0.bossInfo.challengeStatus = DemonChallengeStatus.ePassed

					game.enterGuildBossPreviewScene({
						bossInfo = arg_12_0.bossInfo,
						isKing = arg_12_0.isKing
					})
				end,
				action2 = function()
					game.enterGuildStoreScene({
						tabPageTag = 3
					})
				end
			})
		end
	end

	arg_12_0.resurgenRequest = UnionDemonKingResurgenceRequest:new()

	arg_12_0.resurgenRequest:setResponseNormalHandler(var_12_0)
	arg_12_0.resurgenRequest:setResponseExceptionHandler(var_12_1)

	local function var_12_2()
		local var_17_0 = arg_12_0.giveupRequest:getGiveUpResult()

		game.enterGuildBossPreviewScene({
			bossInfo = arg_12_0.bossInfo,
			giveupResult = var_17_0.Result,
			isKing = arg_12_0.isKing
		})
	end

	local function var_12_3(arg_18_0)
		game.enterGuildMapScene()
	end

	arg_12_0.giveupRequest = UnionDemonKingGiveUpRequest:new()

	arg_12_0.giveupRequest:setResponseNormalHandler(var_12_2)
	arg_12_0.giveupRequest:setResponseExceptionHandler(var_12_3)
end

function var_0_0.initNetworkInterface(arg_19_0)
	local function var_19_0()
		if arg_19_0.parentScene then
			arg_19_0.parentScene:reBattle()
			arg_19_0:removeFromParentAndCleanup(true)

			return
		end

		local var_20_0 = arg_19_0.resurgenRequest:getResurgenceResult()

		arg_19_0:startBattle()
	end

	local function var_19_1(arg_21_0)
		if arg_21_0 == -11430020 then
			ui.showMessageBox({
				text = string.lf("上仙，该Boss已被击杀，掉落宝物已放入魔族商店中，是否前往竞拍?"),
				title1 = string.lf("取消"),
				parent = arg_19_0,
				title2 = string.lf("确定"),
				action1 = function()
					arg_19_0.bossInfo.challengeStatus = DemonChallengeStatus.ePassed

					game.enterGuildBossPreviewScene({
						bossInfo = arg_19_0.bossInfo,
						isKing = arg_19_0.isKing
					})
				end,
				action2 = function()
					game.enterGuildStoreScene({
						tabPageTag = 3
					})
				end
			})
		end
	end

	arg_19_0.resurgenRequest = UnionDemonResurgenceRequest:new()

	arg_19_0.resurgenRequest:setResponseNormalHandler(var_19_0)
	arg_19_0.resurgenRequest:setResponseExceptionHandler(var_19_1)

	local function var_19_2()
		local var_24_0 = arg_19_0.giveupRequest:getGiveUpResult()

		game.enterGuildBossPreviewScene({
			bossInfo = arg_19_0.bossInfo,
			giveupResult = var_24_0.Result,
			isKing = arg_19_0.isKing
		})
	end

	local function var_19_3(arg_25_0)
		game.enterGuildMapScene()
	end

	arg_19_0.giveupRequest = UnionDemonGiveUpRequest:new()

	arg_19_0.giveupRequest:setResponseNormalHandler(var_19_2)
	arg_19_0.giveupRequest:setResponseExceptionHandler(var_19_3)
end

function var_0_0.appearAnimation(arg_26_0)
	arg_26_0.bgSprite:setScale(1)
	arg_26_0.bgSprite:setOpacity(120)

	local var_26_0 = CCArray:create()

	var_26_0:addObject(CCScaleBy:create(0.1, 1.1))
	var_26_0:addObject(CCScaleBy:create(0.1, 0.9))

	local var_26_1 = CCArray:create()

	var_26_1:addObject(CCFadeTo:create(0.2, 255))
	var_26_1:addObject(CCSequence:create(var_26_0))
	arg_26_0.bgSprite:runAction(CCSpawn:create(var_26_1))
end

function var_0_0.appearAnimation2(arg_27_0)
	arg_27_0.bgSprite:setPosition(ccp(display.cx, display.height + display.cy))

	local var_27_0 = CCArray:create()

	var_27_0:addObject(CCMoveTo:create(0.1, ccp(display.cx, display.cy)))
	arg_27_0.bgSprite:runAction(CCSequence:create(var_27_0))
end

return var_0_0
