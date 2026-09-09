require("data.fuben")
require("network.FubenRequest")

local var_0_0 = class("FubenProgressLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0._copyInfoList = arg_2_1.copyInfoList
	arg_2_0.haveKeys = arg_2_1.haveKeys
	arg_2_0._curCopyID = arg_2_1.curCopyID
	arg_2_0._closeCallback = arg_2_1.closeCallback

	arg_2_0:createNetworkInterface()

	local function var_2_0(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end

	arg_2_0:addTouchEventListener(var_2_0, false, 1, true)
	arg_2_0:setTouchEnabled(true)
	arg_2_0:setOpacity(130)
	arg_2_0:setColor(ccc3(0, 0, 0))

	local var_2_1 = string.format("ui/fuben/fuben_0%d.jpg", 16 + arg_2_0._curCopyID % 6)
	local var_2_2 = display.newSprite(var_2_1, display.cx, display.cy)

	var_2_2:align(display.BOTTOM_CENTER, display.cx, 0)
	var_2_2:setScaleX(Adapter.AutoScaleX)
	var_2_2:setScaleY(Adapter.AutoScaleY)
	arg_2_0:addChild(var_2_2)

	local var_2_3 = display.newSprite("uilocal/fuben/fuben_text_001.png")

	var_2_3:setPosition(136 * Adapter.AutoScaleX, 589 * Adapter.AutoScaleY)
	var_2_3:setScale(Adapter.MinScale)
	arg_2_0:addChild(var_2_3)

	local var_2_4 = display.newSprite("ui/fuben/fuben_010.png", 245, 57)

	var_2_3:addChild(var_2_4)
	addLabelWithColorSize(var_2_4, FubenData[arg_2_0._curCopyID].name, ccc3(255, 235, 190), 18, ccp(0.5, 0.5), ccp(20, 11), _FONT_LISU)

	local function var_2_5()
		GuideLayer:removeGuideLayerIfStepGreaterThan(TaskEntryType.eEntryCopy, 3)
		arg_2_0:removeFromParent()
	end

	addCloseButton(arg_2_0, var_2_5)
	arg_2_0:initUI()

	local var_2_6 = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		highlightedImage = "ui/common/common_019.png",
		text = string.lf("掉落预览"),
		fontSize = ColorTable.eTitleButton_FontSize2,
		textColor = ColorTable.eTitleButton_Normal2,
		anchorPoint = ccp(0.5, 0.5),
		position = ccp(110, -40),
		clickAction = function()
			local var_5_0 = require("scenes.fuben.FubenRewardLayer").new({
				copy = arg_2_0._copyInfoList[arg_2_0._curCopyID]
			})

			arg_2_0:addChild(var_5_0)
		end
	})

	var_2_3:addChild(var_2_6)
	arg_2_0:setNodeEventEnabled(true)
end

function var_0_0.onEnter(arg_6_0)
	local var_6_0 = arg_6_0:getCurrentDisplayRound()

	local function var_6_1()
		print("unEnabledButton")
		arg_6_0._buttonList[1].btn:setEnabled(false)
		arg_6_0._buttonList[2].btn:setEnabled(false)

		arg_6_0._copyInfoList[arg_6_0._curCopyID].IsComplete = 1
		arg_6_0._copyInfoList[arg_6_0._curCopyID].OpenCardNumber = nil
		arg_6_0._copyInfoList[arg_6_0._curCopyID].OpenCardReward = nil

		arg_6_0._closeCallback()
	end

	local var_6_2, var_6_3 = arg_6_0:getOpenCardRewardList()

	if var_6_2 and var_6_2 > 0 then
		local var_6_4 = require("scenes.fuben.FubenRewardLayer").new({
			callBack = var_6_1,
			copy = arg_6_0._copyInfoList[arg_6_0._curCopyID]
		})

		arg_6_0:addChild(var_6_4)
	end
end

function var_0_0.initUI(arg_8_0)
	local var_8_0 = arg_8_0:getCurrentDisplayRound()

	arg_8_0._topBgSprite = display.newSprite("ui/fuben/fuben_022.png", 525 * Adapter.AutoScaleX, 596 * Adapter.AutoScaleY)

	arg_8_0._topBgSprite:setScale(Adapter.MinScale)
	arg_8_0:addChild(arg_8_0._topBgSprite)

	arg_8_0._bottomBgSprite = display.newSprite("ui/fuben/fuben_023.png", 480 * Adapter.AutoScaleX, 170 * Adapter.AutoScaleY)

	arg_8_0._bottomBgSprite:setScale(Adapter.MinScale)
	arg_8_0:addChild(arg_8_0._bottomBgSprite)

	arg_8_0._buttonList = {
		{
			y = -35,
			bgSprite = "ui/common/common_110.png",
			bgSelected = "ui/common/common_110.png",
			type = 1,
			x = 295,
			title = string.lf("刷  星"),
			callfunc = function()
				arg_8_0:refreshStar()
			end
		},
		{
			fontSize = 25,
			bgSprite = "ui/common/common_105.png",
			bgSelected = "ui/common/common_105.png",
			type = 2,
			y = -45,
			x = 665,
			title = string.lf("开始挑战"),
			callfunc = function()
				arg_8_0:startBattle()
			end
		}
	}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._buttonList) do
		local var_8_1 = ui.newControlButton({
			clickAction = iter_8_1.callfunc,
			normalImage = iter_8_1.bgSprite,
			highlightedImage = iter_8_1.bgSelected,
			position = ccp(iter_8_1.x, iter_8_1.y),
			text = iter_8_1.title,
			fontSize = iter_8_1.fontSize or 25
		})

		iter_8_1.btn = var_8_1

		arg_8_0._bottomBgSprite:addChild(var_8_1, 0)
	end

	if Player.currentMissionStageID == arg_8_0._curCopyID then
		GuideLayer:showGuideLayer(nil, arg_8_0._bottomBgSprite, TaskEntryType.eEntryCopy, 4)
	end

	addLabelWithColorSize(arg_8_0._topBgSprite, string.lf("星数可用于购买奖励,累计得星:"), ccc3(255, 244, 244), 20, ccp(1, 0.5), ccp(430, 40))
	addLabelWithColorSize(arg_8_0._topBgSprite, arg_8_0._copyInfoList[arg_8_0._curCopyID].StarLevelCount or 0, ccc3(253, 253, 253), 20, ccp(0, 0.5), ccp(470, 41))
	addLabelWithColorSize(arg_8_0._topBgSprite, string.lf("所有战胜奖励在通关BOSS关卡后进行结算"), ccc3(255, 244, 244), 20, ccp(1, 0.5), ccp(500, 13))

	local var_8_2 = display.newSprite("ui/common/common_077.png")

	var_8_2:align(display.CENTER_LEFT, 430, 41)
	arg_8_0._topBgSprite:addChild(var_8_2)

	arg_8_0._monsterTable = {
		{
			pos = Adapter.AutoPos(136, 273)
		},
		{
			pos = Adapter.AutoPos(320, 276)
		},
		{
			pos = Adapter.AutoPos(504, 298)
		},
		{
			pos = Adapter.AutoPos(670, 347)
		},
		{
			pos = Adapter.AutoPos(870, 390)
		}
	}

	for iter_8_2, iter_8_3 in ipairs(FubenData[arg_8_0._curCopyID].rounds) do
		local var_8_3 = 255

		if var_8_0 < iter_8_2 then
			var_8_3 = 130
		end

		local var_8_4 = 0.5

		if iter_8_2 == 5 then
			var_8_4 = 0.65
		end

		local var_8_5 = Adapter.MinScale * var_8_4
		local var_8_6 = figure.createHero({
			isViewQuality = false,
			platTable = false,
			enemyId = iter_8_3.npcid,
			equipId = BaseNPCs[iter_8_3.npcid].equipId,
			scale = var_8_5,
			opacity = var_8_3
		})

		var_8_6:setPosition(arg_8_0._monsterTable[iter_8_2].pos)
		arg_8_0:addChild(var_8_6)

		arg_8_0._monsterTable[iter_8_2].figure = var_8_6

		if iter_8_2 == 5 then
			local var_8_7 = display.newSprite("ui/fuben/fuben_014.png", 0, 0)

			var_8_7:setOpacity(var_8_3)
			var_8_6:addChild(var_8_7)
		end

		if iter_8_2 < var_8_0 then
			local var_8_8 = display.newSprite("ui/fuben/fuben_024.png")

			var_8_8:setPosition(-50, 100)
			var_8_8:setScale(1.5)
			var_8_8:setOpacity(200)
			var_8_6:addChild(var_8_8)
		end
	end

	local var_8_9 = display.newNode()

	var_8_9:setPosition(ccp(0, 0))

	local var_8_10 = arg_8_0._copyInfoList[arg_8_0._curCopyID].StarLevel or 0

	for iter_8_4 = 1, var_8_10 do
		local var_8_11 = display.newSprite("ui/common/common_077.png")

		var_8_11:setScale(Adapter.MinScale)
		var_8_11:setPosition(Adapter.AutoPos(27 * (iter_8_4 - var_8_10 / 2 - 0.5), -15))
		var_8_9:addChild(var_8_11)
	end

	arg_8_0:addChild(var_8_9)
	var_8_9:setPosition(arg_8_0._monsterTable[var_8_0].pos)

	arg_8_0._monsterTable[var_8_0].starNode = var_8_9

	local var_8_12 = FubenData[arg_8_0._curCopyID].rounds[var_8_0].npcid

	arg_8_0._monsterNameLabel = addLabelWithColorSize(arg_8_0._bottomBgSprite, "(" .. var_8_10 .. string.lf("星)") .. BaseNPCs[var_8_12].name, ccc3(40, 244, 44), 25, ccp(0, 0.5), ccp(215, 73))

	if arg_8_0._copyInfoList[arg_8_0._curCopyID].BattlePowerAdvise then
		local var_8_13 = 215 + arg_8_0._monsterNameLabel:getContentSize().width + 50

		arg_8_0._suggestBattlePowerLabel = addLabelWithColorSize(arg_8_0._bottomBgSprite, string.lf("建议战力%s以上玩家挑战", arg_8_0._copyInfoList[arg_8_0._curCopyID].BattlePowerAdvise), ccc3(255, 244, 244), 25, ccp(0, 0.5), ccp(var_8_13, 73))
	end

	local var_8_14 = string.lf("战胜奖励:银币")
	local var_8_15 = addLabelWithColorSize(arg_8_0._bottomBgSprite, var_8_14, ccc3(37, 199, 255), 25, ccp(0, 0.5), ccp(215, 29))
	local var_8_16 = 395

	arg_8_0._rewardGoldNumNode = createItemCountNode({
		scale = 1.25,
		color = ccc3(37, 199, 255),
		type = ItemType.eCoin,
		value = arg_8_0._copyInfoList[arg_8_0._curCopyID].BaseGold
	})

	arg_8_0._rewardGoldNumNode:setPosition(ccp(var_8_16, 29))
	arg_8_0._bottomBgSprite:addChild(arg_8_0._rewardGoldNumNode)

	local var_8_17 = string.lf("阅历")
	local var_8_18 = addLabelWithColorSize(arg_8_0._bottomBgSprite, var_8_17, ccc3(37, 199, 255), 25, ccp(0, 0.5), ccp(510, 29))
	local var_8_19 = 590

	arg_8_0.rewardKnowNumNode = createItemCountNode({
		scale = 1.25,
		color = ccc3(37, 199, 255),
		type = ItemType.eKnowledge,
		value = arg_8_0._copyInfoList[arg_8_0._curCopyID].BaseKnowledge
	})

	arg_8_0.rewardKnowNumNode:setPosition(ccp(var_8_19, 29))
	arg_8_0._bottomBgSprite:addChild(arg_8_0.rewardKnowNumNode)
	addLabelWithColorSize(arg_8_0._bottomBgSprite, string.lf("费用:"), ccc3(37, 199, 255), 25, ccp(1, 0.5), ccp(275, -80))

	local var_8_20 = createItemCountNode({
		scale = 1.25,
		color = ccc3(37, 199, 255),
		type = ItemType.eCoin,
		value = arg_8_0._copyInfoList[arg_8_0._curCopyID].RSL_ConsumeGold
	})

	var_8_20:setPosition(ccp(300, -80))
	arg_8_0._bottomBgSprite:addChild(var_8_20)
end

function var_0_0.refreshStar(arg_11_0)
	print("开始刷星 按钮")
	arg_11_0.refreshStarRequest:request(arg_11_0._copyInfoList[arg_11_0._curCopyID].CopyID)
end

function var_0_0.startBattle(arg_12_0)
	GuideLayer:removeOneGuideLayer(TaskEntryType.eEntryCopy)

	local var_12_0 = arg_12_0._copyInfoList
	local var_12_1 = arg_12_0._curCopyID
	local var_12_2 = arg_12_0.haveKeys

	local function var_12_3(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_1.PlayerCopyInfo ~= nil then
			var_12_0[var_12_1] = arg_13_1.PlayerCopyInfo
		end

		game.enterFubenIndexScene({
			copyInfoList = var_12_0,
			curCopyID = var_12_1,
			haveKeys = var_12_2
		})
	end

	require("scenes.battle.BattleOperator"):startBattle(eBattleType.BattleCopy, {
		star = arg_12_0._copyInfoList[arg_12_0._curCopyID].StarLevel,
		copyId = arg_12_0._copyInfoList[arg_12_0._curCopyID].CopyID,
		index = arg_12_0._copyInfoList[arg_12_0._curCopyID].RoundID
	}, var_12_3)
end

function var_0_0.getCurrentDisplayRound(arg_14_0)
	local var_14_0 = 0

	return arg_14_0._copyInfoList[arg_14_0._curCopyID].RoundID == nil and 5 or 1 + arg_14_0._copyInfoList[arg_14_0._curCopyID].RoundID
end

function var_0_0.getOpenCardRewardList(arg_15_0)
	if arg_15_0._copyInfoList[arg_15_0._curCopyID].OpenCardNumber then
		return arg_15_0._copyInfoList[arg_15_0._curCopyID].OpenCardNumber, arg_15_0._copyInfoList[arg_15_0._curCopyID].OpenCardReward
	end

	return nil, nil
end

function var_0_0.createNetworkInterface(arg_16_0)
	arg_16_0.refreshStarRequest = RefreshStarRequest:new(arg_16_0)

	local function var_16_0()
		local var_17_0 = arg_16_0.refreshStarRequest:getStarCount()
		local var_17_1 = arg_16_0:getCurrentDisplayRound()

		arg_16_0._copyInfoList[arg_16_0._curCopyID].BaseExp = var_17_0.BaseExp
		arg_16_0._copyInfoList[arg_16_0._curCopyID].BaseGold = var_17_0.BaseGold
		arg_16_0._copyInfoList[arg_16_0._curCopyID].BaseKnowledge = var_17_0.BaseKnowledge
		arg_16_0._copyInfoList[arg_16_0._curCopyID].StarLevel = var_17_0.StarLevel
		arg_16_0._copyInfoList[arg_16_0._curCopyID].BattlePowerAdvise = var_17_0.BattlePowerAdvise

		local var_17_2 = arg_16_0._monsterTable[var_17_1].starNode

		var_17_2:removeAllChildrenWithCleanup(true)

		local var_17_3 = arg_16_0._copyInfoList[arg_16_0._curCopyID].StarLevel

		for iter_17_0 = 1, var_17_3 do
			local var_17_4 = display.newSprite("ui/common/common_077.png")

			var_17_4:setScale(Adapter.MinScale)
			var_17_4:setPosition(Adapter.AutoPos(27 * (iter_17_0 - var_17_3 / 2 - 0.5), -15))
			var_17_2:addChild(var_17_4)
		end

		local var_17_5 = FubenData[arg_16_0._curCopyID].rounds[var_17_1].npcid

		arg_16_0._monsterNameLabel:setString("(" .. var_17_3 .. string.lf("星)") .. BaseNPCs[var_17_5].name)
		arg_16_0._rewardGoldNumNode:setValue(arg_16_0._copyInfoList[arg_16_0._curCopyID].BaseGold)
		arg_16_0.rewardKnowNumNode:setValue(arg_16_0._copyInfoList[arg_16_0._curCopyID].BaseKnowledge)

		if arg_16_0._suggestBattlePowerLabel then
			arg_16_0._suggestBattlePowerLabel:setString(string.lf("建议战力%s以上玩家挑战", arg_16_0._copyInfoList[arg_16_0._curCopyID].BattlePowerAdvise))
		end
	end

	local function var_16_1(arg_18_0)
		print("responseRefreshStarRequestFail")
	end

	arg_16_0.refreshStarRequest:setResponseNormalHandler(var_16_0)
	arg_16_0.refreshStarRequest:setResponseExceptionHandler(var_16_1)
end

return var_0_0
