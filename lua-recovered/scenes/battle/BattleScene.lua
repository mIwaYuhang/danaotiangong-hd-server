require("base.figure")
require("scenes.battle.BattleData")
require("scenes.battle.AnimationManager")
require("scenes.battle.BattleSkeleton")
require("network.BattleRequest")
require("scenes.battle.BattleComming")
require("scenes.battle.BattleTransform")

SceneZorder = {
	eBattleFront = 5,
	eBackGroundAnimation = -1,
	eBattleWeather = 6,
	eBattleState = 3,
	eBattleArea = 2,
	eBattlePreload = 7,
	eShadow = 0,
	eBackGroundPic = -2,
	eBattleEffect = 4,
	eBattleUI = 1
}

local var_0_0 = true
local var_0_1 = false
local var_0_2 = false
local var_0_3 = false
local var_0_4 = true

testSkill = false
testState = false
testDrop = false
testBGA = false
testHPview = false
testhalo = false
isCheckBattle = true
figureTransform = true

local var_0_5 = {}
local var_0_6 = {}

local function var_0_7()
	var_0_5 = {}

	for iter_1_0 = 0, 1 do
		for iter_1_1 = 0, 2 do
			if iter_1_1 == 1 then
				table.insert(var_0_5, Adapter.AutoPos(270 - iter_1_0 * 150, 290 - iter_1_1 * 125))
			else
				table.insert(var_0_5, Adapter.AutoPos(220 - iter_1_0 * 150, 270 - iter_1_1 * 125))
			end
		end
	end

	var_0_6 = {}

	for iter_1_2 = 1, #var_0_5 do
		table.insert(var_0_6, ccp(display.cx * 2 - var_0_5[iter_1_2].x, var_0_5[iter_1_2].y))
	end

	BattleData.pos_Hero = var_0_5
	BattleData.pos_Enemy = var_0_6
end

local var_0_8 = class("BattleScene", function()
	return display.newScene("BattleScene")
end)

function var_0_8.createShadow(arg_3_0, arg_3_1)
	if arg_3_1 then
		table.foreach(arg_3_0.heroList, function(arg_4_0, arg_4_1)
			if not arg_4_1.shadow then
				local var_4_0 = CCSprite:create("ui/battle/bg_battle_position.png")

				var_4_0:setPosition(0, 0)
				arg_4_1:addChild(var_4_0, -1)

				arg_4_1.shadow = var_4_0
			end
		end)
	else
		table.foreach(arg_3_0.enemyList, function(arg_5_0, arg_5_1)
			if not arg_5_1.shadow then
				local var_5_0 = CCSprite:create("ui/battle/bg_battle_position.png")

				var_5_0:setPosition(0, 0)
				arg_5_1:addChild(var_5_0, -1)

				arg_5_1.shadow = var_5_0
			end
		end)
	end
end

function var_0_8.onCreatePlayerFormation(arg_6_0, arg_6_1)
	if arg_6_0.dragLayer == nil then
		arg_6_0.dragLayer = require("scenes.battle.HeroDragLayer").new()

		arg_6_0:addChild(arg_6_0.dragLayer, SceneZorder.eBattleArea)
	end

	arg_6_0.heroList, arg_6_0.maskLayer = arg_6_0.dragLayer:viewHero(arg_6_1, var_0_5, true, false)

	arg_6_0.maskLayer:setTouchEnabled(false)

	for iter_6_0, iter_6_1 in pairs(arg_6_0.heroList) do
		if arg_6_0.params.type == eBattleType.ChampionShip then
			iter_6_1:setVisible(false)
		end

		iter_6_1:setTouchFalse()
	end
end

function var_0_8.onCreateFormationElement(arg_7_0, ...)
	local function var_7_0()
		local var_8_0 = CCNode:create()

		for iter_8_0 = 1, 6 do
			local var_8_1 = CCSprite:create("ui/team/team_029.png")

			var_8_1:setPosition(var_0_5[iter_8_0].x, var_0_5[iter_8_0].y + 5 * Adapter.MinScale)
			var_8_1:setScale(1.5 * FigureSize)
			var_8_0:addChild(var_8_1, -1)
			orderScale(var_8_1, var_0_5[iter_8_0])
		end

		arg_7_0:addChild(var_8_0, SceneZorder.eShadow)

		return var_8_0
	end

	arg_7_0.currentCFormation = arg_7_0:calculateFormation()
	arg_7_0.bgNode = var_7_0()

	arg_7_0.maskLayer:setTouchEnabled(true)

	for iter_7_0, iter_7_1 in pairs(arg_7_0.heroList) do
		iter_7_1:setTouchTrue()
	end
end

function var_0_8.calculateFormation(arg_9_0)
	local var_9_0 = ""

	for iter_9_0 = 1, 6 do
		local var_9_1 = false

		for iter_9_1, iter_9_2 in pairs(Player.team.groupList) do
			if iter_9_2.battleIx == iter_9_0 then
				var_9_0 = var_9_0 .. iter_9_2.heroId
				var_9_1 = true

				break
			end
		end

		if var_9_1 == false then
			var_9_0 = var_9_0 .. 0
		end

		if iter_9_0 ~= 6 then
			var_9_0 = var_9_0 .. ","
		end
	end

	return var_9_0
end

function var_0_8.onFinishFormation(arg_10_0)
	local function var_10_0()
		arg_10_0:startComming()
	end

	local function var_10_1(arg_12_0)
		local var_12_0 = NetworkState.ExceptionNames[arg_12_0]

		var_12_0 = var_12_0 or var_12_0.lf("未知错误")

		ui.showMessageBox({
			text = var_12_0.lf("编队：") .. var_12_0,
			action1 = function()
				game.enterHomeScene()
			end
		})
	end

	local var_10_2 = arg_10_0:calculateFormation()

	if var_10_2 ~= arg_10_0.currentCFormation then
		arg_10_0.battleRequest:setResponseNormalHandler(var_10_0)
		arg_10_0.battleRequest:setResponseExceptionHandler(var_10_1)
		arg_10_0.battleRequest:requestSetBattleFormation(var_10_2)
	else
		var_10_0()
	end
end

function var_0_8.onViewProgress_transitory(arg_14_0)
	arg_14_0.progressLayer = require("scenes.battle.BattleProgress").new(arg_14_0.heroList, arg_14_0.enemyList, arg_14_0.uiLayer)

	arg_14_0:addChild(arg_14_0.progressLayer)
	arg_14_0.progressLayer:bindHero()
	arg_14_0.progressLayer:bindEnemy()
end

function var_0_8.onPause(arg_15_0, arg_15_1)
	var_0_2 = true
	arg_15_0.pauseCallback = arg_15_1
end

function var_0_8.onResume(arg_16_0)
	var_0_2 = false

	if var_0_3 then
		var_0_3 = false

		arg_16_0:onStepOver()
	end
end

function var_0_8.awayFromGame(arg_17_0, arg_17_1)
	var_0_0 = arg_17_1
end

function var_0_8.setControl(arg_18_0, arg_18_1)
	var_0_1 = arg_18_1
end

function var_0_8.getAFGstate(arg_19_0)
	return var_0_0
end

function var_0_8.onFinish(arg_20_0, arg_20_1)
	if BattleData.result then
		if BattleData.stage == BattleData.totalStage then
			arg_20_0:onPause()
			arg_20_0.maskLayer:removeTouchEventListener()

			local function var_20_0(...)
				arg_20_0.chatEnd = nil

				arg_20_0.params.battleResult(true, arg_20_0, BattleData.BattleReward, arg_20_0.handler)
			end

			if arg_20_0.params.chatEnd and BattleData.IsFirst then
				local var_20_1 = require("scenes.battle.BattleChatLayer"):new()

				arg_20_0:addChild(var_20_1, SceneZorder.eBattleFront)
				var_20_1:setup(arg_20_0.params.chatEnd, var_20_0)

				var_20_0 = nil
			else
				var_20_0()

				local var_20_2
			end
		else
			local function var_20_3(...)
				if arg_20_1 then
					arg_20_0:init()
				else
					AnimationManager:removeDropAnim(function(...)
						arg_20_0:init()
					end)
				end
			end

			local var_20_4 = CCArray:create()

			var_20_4:addObject(CCCallFunc:create(function(...)
				for iter_24_0, iter_24_1 in pairs(arg_20_0.heroList) do
					if nodeCheckRebirthScale(iter_24_1) > 0 then
						local var_24_0 = {
							figureSize = 0,
							node = iter_24_1
						}

						BattleTransform:upgrade(var_24_0)

						local var_24_1

						var_24_1 = BattleSkeleton:addEffect({
							effectName = "buff_tupo",
							speed = 1.2,
							scale = 2,
							parent = iter_24_1,
							position = ccp(0, 270),
							callbacklist = {
								function()
									var_24_1:removeFromParentAndCleanup(true)
								end,
								1,
								AAT_Percent
							}
						})
					end
				end
			end))
			var_20_4:addObject(CCCallFunc:create(var_20_3))
			CCDirector:sharedDirector():getRunningScene():runAction(CCSequence:create(var_20_4))
		end
	else
		arg_20_0:onPause()
		arg_20_0.maskLayer:removeTouchEventListener()
		arg_20_0.params.battleResult(false, arg_20_0, BattleData.BattleReward, arg_20_0.handler)
	end
end

function var_0_8.onRoundOver(arg_26_0)
	if arg_26_0.params.guider then
		if BattleData.guiderStep == 1 then
			arg_26_0:guiderStage2(handler(arg_26_0, var_0_8.onRoundOver))

			return
		elseif BattleData.guiderStep == 6 then
			arg_26_0:guiderStage5(handler(arg_26_0, var_0_8.onRoundOver))

			return
		end

		BattleData.guiderStep = BattleData.guiderStep + 1
	end

	if BattleData.round >= Setting_canSkip_round then
		arg_26_0.params.canSkip = true

		arg_26_0.uiLayer:buttonVisible(true)
	end

	print("Round " .. BattleData.round .. " Over!!!")

	local var_26_0, var_26_1 = BattleData:roundEnd()

	if var_26_0 then
		for iter_26_0, iter_26_1 in pairs(var_26_1) do
			local var_26_2 = BattleData:getDisplayNode(iter_26_1.position)

			arg_26_0.stateLayer:deleteIconAni(var_26_2, iter_26_1)
		end

		arg_26_0.uiLayer:addRoundView()
		arg_26_0:onRoundBattle_duration(arg_26_0.onRoundOver, arg_26_0.onFinish)
	else
		arg_26_0:onFinish()
	end
end

function var_0_8.onStepOver(arg_27_0)
	if arg_27_0.finishGame then
		arg_27_0.finishGame = false

		arg_27_0:onFinish(true)

		return
	end

	if var_0_2 then
		var_0_3 = true

		if arg_27_0.pauseCallback then
			arg_27_0.pauseCallback()
		end

		return
	end

	if arg_27_0.params.guider and BattleData.guiderStep == 1 then
		arg_27_0.uiLayer:refreshLabel({
			left2 = 3,
			right2 = 6,
			right1 = 6,
			left1 = 3 - BattleData.step
		})
	else
		arg_27_0.uiLayer:refreshLabel()
	end

	if BattleData:addStep() then
		print("Step " .. BattleData.step .. " Over!!!")
		arg_27_0:onStepAction_duration(arg_27_0.roundCallback)
	else
		arg_27_0.roundCallback()
	end
end

function var_0_8.onStepAction_duration(arg_28_0, arg_28_1)
	if arg_28_0.finishGame then
		arg_28_0.finishGame = false

		arg_28_0:onFinish(true)

		return
	end

	arg_28_0.roundCallback = arg_28_1

	if BattleData.step <= BattleData.maxStep then
		AnimationManager:onStepAction(BattleData.roundAction[BattleData.round][BattleData.step], handler(arg_28_0, var_0_8.onStepOver))
	else
		arg_28_1()
	end
end

function var_0_8.onRoundBattle_duration(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_0.finishGame then
		arg_29_0.finishGame = false

		arg_29_0:onFinish(true)

		return
	end

	if BattleData.round <= BattleData.maxRound then
		arg_29_0:onStepAction_duration(handler(arg_29_0, arg_29_0.onRoundOver))
	else
		arg_29_2()
	end
end

function var_0_8.startBattle(arg_30_0)
	if arg_30_0.params.guider then
		for iter_30_0, iter_30_1 in pairs(arg_30_0.enemyList) do
			iter_30_1.viewParam.viewEffect = false

			figure.setupFigure(iter_30_1.viewParam)
		end
	end

	BattleComming:enemyComming(arg_30_0.params.type ~= eBattleType.ChampionShip, function()
		if isCheckBattle and not BattleData:checkBattleFormation() or arg_30_0.params.type == eBattleType.ChampionShip then
			for iter_31_0, iter_31_1 in pairs(arg_30_0.heroList) do
				iter_31_1:removeFromParentAndCleanup(true)
			end

			arg_30_0.heroList, arg_30_0.maskLayer = arg_30_0.dragLayer:viewHero(BattleData.Heros, var_0_5, true)

			for iter_31_2, iter_31_3 in pairs(arg_30_0.heroList) do
				if arg_30_0.params.guider and iter_31_3.idx ~= 2 and iter_31_3.idx ~= 4 and iter_31_3.idx ~= 6 then
					iter_31_3:setVisible(false)
				end

				iter_31_3:setTouchFalse()
			end

			arg_30_0.maskLayer:setTouchEnabled(false)
			arg_30_0.maskLayer:removeFromParentAndCleanup(true)
			arg_30_0:createShadow(true)

			if arg_30_0.params.type == eBattleType.ChampionShip then
				for iter_31_4, iter_31_5 in pairs(arg_30_0.enemyList) do
					iter_31_5:setVisible(true)
				end
			end
		end

		arg_30_0:createShadow(false)
		arg_30_0:onViewProgress_transitory()
		arg_30_0:viewHeroName()
		AnimationManager:init(arg_30_0.progressLayer, arg_30_0.effectLayer, arg_30_0.stateLayer)

		BattleData.displayHero = arg_30_0.heroList
		BattleData.displayEnemy = arg_30_0.enemyList

		for iter_31_6, iter_31_7 in pairs(arg_30_0.heroList) do
			BattleSkeleton.updateSpeed(iter_31_7.Skeleton)
		end

		for iter_31_8, iter_31_9 in pairs(arg_30_0.enemyList) do
			BattleSkeleton.updateSpeed(iter_31_9.Skeleton)
		end

		local function var_31_0(...)
			arg_30_0.params.chatBegin = nil

			arg_30_0:onBeforeBattle_duration(function()
				arg_30_0:onRoundBattle_duration(handler(arg_30_0, arg_30_0.onRoundOver), handler(arg_30_0, arg_30_0.onFinish))
			end)
		end

		arg_30_0.uiLayer:battle(arg_30_0.params)

		if arg_30_0.params.guider then
			arg_30_0:guiderStage1(var_31_0)
		elseif arg_30_0.params.chatBegin and BattleData.IsFirst then
			local var_31_1 = require("scenes.battle.BattleChatLayer"):new()

			arg_30_0:addChild(var_31_1, SceneZorder.eBattleFront)
			var_31_1:setup(arg_30_0.params.chatBegin, var_31_0)
		else
			var_31_0()
		end
	end)
end

function var_0_8.rebirthScale(arg_34_0, arg_34_1)
	if arg_34_0.finishGame then
		arg_34_0.finishGame = false

		arg_34_0:onFinish(true)

		return
	end

	local function var_34_0(arg_35_0)
		local var_35_0 = {
			node = arg_35_0,
			figureSize = arg_35_0.viewParam.rebirthCount
		}

		BattleTransform:upgrade(var_35_0)

		local var_35_1

		var_35_1 = BattleSkeleton:addEffect({
			effectName = "buff_tupo",
			speed = 1.2,
			scale = 2,
			parent = arg_35_0,
			position = ccp(0, 270),
			callbacklist = {
				function()
					var_35_1:removeFromParentAndCleanup(true)
				end,
				1,
				AAT_Percent
			}
		})

		local var_35_2 = "uilocal/battle/battle_text_168.png"
		local var_35_3 = nodeCheckRebirthScale(arg_35_0)

		if var_35_3 == 1 then
			var_35_2 = "uilocal/battle/battle_text_168.png"
		elseif var_35_3 == 2 then
			var_35_2 = "uilocal/battle/battle_text_169.png"
		elseif var_35_3 == 3 then
			var_35_2 = "uilocal/battle/battle_text_170.png"
		end

		local var_35_4 = CCSprite:create(var_35_2)

		var_35_4:setScale(0.1)
		arg_35_0.progressNode:addChild(var_35_4)
		var_35_4:setOpacity(0)
		var_35_4:setPosition(CCPoint(0, 10))

		local var_35_5 = CCArray:create()

		var_35_5:addObject(CCFadeIn:create(0.3 * BattleSpeed))
		var_35_5:addObject(CCDelayTime:create(0.5 * BattleSpeed))
		var_35_5:addObject(CCFadeOut:create(0.3 * BattleSpeed))
		var_35_5:addObject(CCCallFunc:create(function()
			var_35_4:removeFromParentAndCleanup(true)
		end))
		var_35_4:runAction(CCSequence:create(var_35_5))
		var_35_4:runAction(CCMoveBy:create(1 * BattleSpeed, CCPoint(0, 30)))
		var_35_4:runAction(CCEaseElasticOut:create(CCScaleTo:create(0.5 * BattleSpeed, 0.6)))
	end

	if not arg_34_0.params.guider and BattleData.kuanghua then
		local var_34_1 = CCArray:create()

		var_34_1:addObject(CCCallFunc:create(function(...)
			for iter_38_0, iter_38_1 in pairs(arg_34_0.heroList) do
				if nodeCheckRebirthScale(iter_38_1) > 0 then
					var_34_0(iter_38_1)
				end
			end

			for iter_38_2, iter_38_3 in pairs(arg_34_0.enemyList) do
				if iter_38_3.viewParam.heroId and nodeCheckRebirthScale(iter_38_3) > 0 then
					var_34_0(iter_38_3)
				end
			end
		end))
		var_34_1:addObject(CCDelayTime:create(1))
		var_34_1:addObject(CCCallFunc:create(arg_34_1))
		CCDirector:sharedDirector():getRunningScene():runAction(CCSequence:create(var_34_1))
	else
		arg_34_1()
	end
end

function var_0_8.newEffect(arg_39_0, arg_39_1)
	local function var_39_0(arg_40_0)
		if arg_40_0 > 6 then
			return BattleData:getDisplayNode(arg_40_0 - 6)
		else
			return BattleData:getDisplayNode(arg_40_0 + 6)
		end
	end

	local function var_39_1(arg_41_0, arg_41_1)
		local var_41_0
		local var_41_1 = arg_41_1 == 1 and "uilocal/battle/battle_text_234.png" or arg_41_1 == 2 and "uilocal/battle/battle_text_235.png" or arg_41_1 == 3 and "uilocal/battle/battle_text_236.png" or arg_41_1 == 4 and "uilocal/battle/battle_text_237.png" or arg_41_1 == 5 and "uilocal/battle/battle_text_238.png" or "uilocal/battle/battle_text_238.png"
		local var_41_2 = CCSprite:create(var_41_1)

		var_41_2:setScale(0.1)
		arg_41_0.progressNode:addChild(var_41_2)
		var_41_2:setOpacity(0)
		var_41_2:setPosition(CCPoint(0, 10))

		local var_41_3 = CCArray:create()

		var_41_3:addObject(CCFadeIn:create(0.3 * BattleSpeed))
		var_41_3:addObject(CCDelayTime:create(0.5 * BattleSpeed))
		var_41_3:addObject(CCFadeOut:create(0.3 * BattleSpeed))
		var_41_3:addObject(CCCallFunc:create(function()
			var_41_2:removeFromParentAndCleanup(true)
		end))
		var_41_2:runAction(CCSequence:create(var_41_3))
		var_41_2:runAction(CCMoveBy:create(1 * BattleSpeed, CCPoint(0, 30)))
		var_41_2:runAction(CCEaseElasticOut:create(CCScaleTo:create(0.5 * BattleSpeed, 0.6)))
	end

	local function var_39_2(arg_43_0)
		if not arg_43_0 then
			return
		end

		local var_43_0 = CCSprite:create("uilocal/battle/battle_text_239.png")

		var_43_0:setScale(0.1)
		arg_43_0.progressNode:addChild(var_43_0)
		var_43_0:setOpacity(0)
		var_43_0:setPosition(CCPoint(0, 10))

		local var_43_1 = CCArray:create()

		var_43_1:addObject(CCFadeIn:create(0.3 * BattleSpeed))
		var_43_1:addObject(CCDelayTime:create(0.5 * BattleSpeed))
		var_43_1:addObject(CCFadeOut:create(0.3 * BattleSpeed))
		var_43_1:addObject(CCCallFunc:create(function()
			var_43_0:removeFromParentAndCleanup(true)
		end))
		var_43_0:runAction(CCSequence:create(var_43_1))
		var_43_0:runAction(CCMoveBy:create(1 * BattleSpeed, CCPoint(0, 30)))
		var_43_0:runAction(CCEaseElasticOut:create(CCScaleTo:create(0.5 * BattleSpeed, 0.6)))
	end

	if not arg_39_0.params.guider and BattleData.guanghuan then
		local var_39_3 = {}
		local var_39_4 = {}

		for iter_39_0, iter_39_1 in pairs(BattleData.Heros) do
			if iter_39_1.halolv > 0 then
				table.insert(var_39_3, {
					id = iter_39_1.battleIx,
					lv = iter_39_1.halolv
				})
			end
		end

		for iter_39_2, iter_39_3 in pairs(BattleData.enemy) do
			if iter_39_3.halolv > 0 then
				table.insert(var_39_4, {
					id = iter_39_3.battleIx,
					lv = iter_39_3.halolv
				})
			end
		end

		if table.nums(var_39_3) ~= 0 or table.nums(var_39_4) ~= 0 then
			local var_39_5 = CCArray:create()

			var_39_5:addObject(CCCallFunc:create(function(...)
				for iter_45_0, iter_45_1 in pairs(var_39_3) do
					var_39_1(BattleData:getDisplayNode(iter_45_1.id), iter_45_1.lv)
				end

				for iter_45_2, iter_45_3 in pairs(var_39_4) do
					var_39_1(BattleData:getDisplayNode(iter_45_3.id), iter_45_3.lv)
				end
			end))
			var_39_5:addObject(CCDelayTime:create(1))
			var_39_5:addObject(CCCallFunc:create(function()
				for iter_46_0, iter_46_1 in pairs(var_39_3) do
					var_39_2(var_39_0(iter_46_1.id))
				end

				for iter_46_2, iter_46_3 in pairs(var_39_4) do
					var_39_2(var_39_0(iter_46_3.id))
				end
			end))
			var_39_5:addObject(CCDelayTime:create(1))
			var_39_5:addObject(CCCallFunc:create(arg_39_1))
			CCDirector:sharedDirector():getRunningScene():runAction(CCSequence:create(var_39_5))
		else
			arg_39_1()
		end
	else
		arg_39_1()
	end
end

function var_0_8.onBeforeBattle_duration(arg_47_0, arg_47_1)
	if arg_47_0.finishGame then
		arg_47_0.finishGame = false

		arg_47_0:onFinish(true)

		return
	end

	BattleAudio:Sound_playEffect(BattleAudio.schedule_kaizhan)

	local var_47_0 = CCSprite:create("ui/battle/bg_startBattle.png")

	var_47_0:setPosition(display.cx, display.cy)
	var_47_0:setScale(10 * Adapter.MinScale)

	local var_47_1 = CCArray:create()

	var_47_1:addObject(CCEaseElasticInOut:create(CCScaleBy:create(0.3, 0.1), 0.3 * Adapter.MinScale))
	var_47_1:addObject(CCFadeOut:create(0.6))
	var_47_1:addObject(CCCallFunc:create(function()
		var_47_0:removeFromParentAndCleanup(true)
		AnimationManager:preBattleView(function(...)
			arg_47_0:rebirthScale(function()
				arg_47_0:newEffect(arg_47_1)
			end)
		end)
	end))
	var_47_0:runAction(CCSequence:create(var_47_1))
	arg_47_0:addChild(var_47_0, SceneZorder.eBattleEffect)
end

function var_0_8.battleInfoRequest(arg_51_0)
	local function var_51_0()
		local var_52_0 = arg_51_0.battleRequest:getData()

		if var_52_0.BattleResult and var_52_0.BattleResult.IsSkip then
			arg_51_0.params.canSkip = true
		end

		BattleData:init(var_52_0)

		arg_51_0.enemyList = arg_51_0.dragLayer:viewEnemy(BattleData.enemy, var_0_6)

		for iter_52_0, iter_52_1 in pairs(arg_51_0.enemyList) do
			iter_52_1:setVisible(false)
		end

		if arg_51_0.params.comming.enemyComming then
			arg_51_0.params.comming.enemyComming = BattleData:getEnemyCarrier()
		end

		BattleComming:afterBattleRequest(function(...)
			arg_51_0.effectLayer = require("scenes.battle.BattleEffectLayer").new()

			arg_51_0:addChild(arg_51_0.effectLayer, SceneZorder.eBattleEffect)

			arg_51_0.stateLayer = require("scenes.battle.BattleStateLayer").new()

			arg_51_0:addChild(arg_51_0.stateLayer, SceneZorder.eBattleState)
			arg_51_0:createShadow(true)
			arg_51_0:startBattle()
		end)
	end

	local function var_51_1(arg_54_0)
		local var_54_0 = NetworkState.ExceptionNames[arg_54_0] or string.lf("未知错误")

		ui.showMessageBox({
			text = string.lf("战斗：%s", var_54_0),
			action1 = function()
				if arg_54_0 == NetworkState.TransportRobed then
					game.enterTransportScene()

					return
				elseif arg_54_0 == NetworkState.ShenQiFragmentNull then
					game.enterShenqiScene()

					return
				end

				game.enterHomeScene()
			end
		})
	end

	arg_51_0.battleRequest:setResponseNormalHandler(var_51_0)
	arg_51_0.battleRequest:setResponseExceptionHandler(var_51_1)

	arg_51_0.handler = arg_51_0.battleRequest:requestGetBattleInfo(arg_51_0.params.params, BattleData.stage + 1, arg_51_0.params.diffculty)
end

function var_0_8.clear(arg_56_0)
	if arg_56_0.uiLayer then
		arg_56_0.uiLayer:removeFromParentAndCleanup(true)

		arg_56_0.uiLayer = nil
	end

	if arg_56_0.bgNode then
		arg_56_0.bgNode:removeFromParentAndCleanup(true)

		arg_56_0.bgNode = nil
	end

	if arg_56_0.maskLayer then
		arg_56_0.maskLayer:removeFromParentAndCleanup(true)

		arg_56_0.maskLayer = nil
	end

	if arg_56_0.heroList then
		table.foreach(arg_56_0.heroList, function(arg_57_0, arg_57_1)
			arg_57_1:removeFromParentAndCleanup(true)
		end)

		arg_56_0.heroList = nil
	end

	if arg_56_0.enemyList then
		table.foreach(arg_56_0.enemyList, function(arg_58_0, arg_58_1)
			arg_58_1:removeFromParentAndCleanup(true)
		end)

		arg_56_0.enemyList = nil
	end

	if arg_56_0.dragLayer then
		arg_56_0.dragLayer:removeFromParentAndCleanup(true)

		arg_56_0.dragLayer = nil
	end

	if arg_56_0.progressLayer then
		arg_56_0.progressLayer:removeFromParentAndCleanup(true)

		arg_56_0.progressLayer = nil
	end

	if arg_56_0.effectLayer then
		arg_56_0.effectLayer:removeFromParentAndCleanup(true)

		arg_56_0.effectLayer = nil
	end

	if arg_56_0.stateLayer then
		arg_56_0.stateLayer:removeFromParentAndCleanup(true)

		arg_56_0.stateLayer = nil
	end
end

function var_0_8.ctor(arg_59_0, arg_59_1)
	dump("进入战斗界面，有bug请@hanye")

	if not var_0_4 then
		local var_59_0 = require("scenes.battle.BattleWeather").new()

		arg_59_0:addChild(var_59_0, SceneZorder.eBattleWeather)
		var_59_0:manager()

		arg_59_0.weatherLayer = var_59_0
	end

	var_0_2 = false
	arg_59_0.battleRequest = BattleRequest:new(arg_59_0)

	BattleBGAnimation:init(arg_59_0, arg_59_0.weatherLayer)

	if arg_59_1.comming.playerComming then
		arg_59_1.comming.playerComming = Player.artifactLevel
	end

	BattleComming:init(arg_59_0, arg_59_1)
	BattleData:reset()

	arg_59_0.params = arg_59_1
	arg_59_0.battleRequestData = {
		arg_59_1.type,
		arg_59_1.id
	}
	arg_59_0.params.oskip = arg_59_0.params.canSkip
end

function var_0_8.init(arg_60_0)
	arg_60_0.params.canSkip = arg_60_0.params.oskip

	var_0_7()
	arg_60_0:clear()

	local var_60_0 = require("scenes.battle.BattleUILayer").new()

	arg_60_0:addChild(var_60_0, SceneZorder.eBattleUI)

	arg_60_0.uiLayer = var_60_0

	if not arg_60_0.params.guider and var_0_1 == false and var_0_0 == false then
		arg_60_0:onCreatePlayerFormation(Player.team.groupList)
		BattleComming:beforeBattleComming(function(...)
			arg_60_0.uiLayer:init(arg_60_0.heroList)
			arg_60_0:onCreateFormationElement()
		end)
	elseif arg_60_0.params.guider then
		arg_60_0:guierInit()
	else
		arg_60_0:onCreatePlayerFormation(Player.team.groupList)
		BattleComming:beforeBattleComming(function(...)
			arg_60_0:startComming()
		end)
	end
end

function var_0_8.reBattle(arg_63_0)
	arg_63_0.params.canSkip = true
	var_0_2 = false

	BattleData:reset()
	arg_63_0:clear()

	local var_63_0 = require("scenes.battle.BattleUILayer").new()

	arg_63_0:addChild(var_63_0, SceneZorder.eBattleUI)

	arg_63_0.uiLayer = var_63_0

	arg_63_0:onCreatePlayerFormation(Player.team.groupList)
	BattleComming:beforeBattleComming(function(...)
		arg_63_0:startComming()
	end)
end

function var_0_8.startComming(arg_65_0)
	if arg_65_0.heroList then
		for iter_65_0, iter_65_1 in pairs(arg_65_0.heroList) do
			iter_65_1:setTouchFalse()
			arg_65_0.dragLayer:hideHeroInfo(iter_65_1)
		end
	end

	arg_65_0:battleInfoRequest()

	if arg_65_0.bgNode then
		arg_65_0.bgNode:removeFromParentAndCleanup(true)

		arg_65_0.bgNode = nil
	end

	if arg_65_0.maskLayer then
		arg_65_0.maskLayer:removeFromParentAndCleanup(true)

		arg_65_0.maskLayer = nil
	end
end

function var_0_8.viewHeroName(arg_66_0)
	if arg_66_0.maskLayer then
		arg_66_0.maskLayer:removeFromParentAndCleanup(true)

		arg_66_0.maskLayer = nil
	end

	local function var_66_0(arg_67_0, arg_67_1, arg_67_2)
		if arg_67_0 == "began" then
			for iter_67_0, iter_67_1 in pairs(arg_66_0.heroList) do
				iter_67_1.name:setVisible(true)

				if testHPview then
					iter_67_1.hpview:setVisible(true)
				end
			end

			for iter_67_2, iter_67_3 in pairs(arg_66_0.enemyList) do
				iter_67_3.name:setVisible(true)

				if testHPview then
					iter_67_3.hpview:setVisible(true)
				end
			end

			arg_66_0.uiLayer.total_left:setVisible(true)
			arg_66_0.uiLayer.total_right:setVisible(true)

			return true
		elseif arg_67_0 == "moved" then
			-- block empty
		elseif arg_67_0 == "ended" then
			for iter_67_4, iter_67_5 in pairs(arg_66_0.heroList) do
				iter_67_5.name:setVisible(false)

				if testHPview then
					iter_67_5.hpview:setVisible(false)
				end
			end

			for iter_67_6, iter_67_7 in pairs(arg_66_0.enemyList) do
				iter_67_7.name:setVisible(false)

				if testHPview then
					iter_67_7.hpview:setVisible(false)
				end
			end

			arg_66_0.uiLayer.total_left:setVisible(false)
			arg_66_0.uiLayer.total_right:setVisible(false)
		end
	end

	arg_66_0.maskLayer = CCLayer:create()

	arg_66_0.maskLayer:addTouchEventListener(var_66_0, false, 1, false)
	arg_66_0.maskLayer:setTouchEnabled(true)
	arg_66_0:addChild(arg_66_0.maskLayer)
end

function var_0_8.onEnter(arg_68_0)
	arg_68_0.params.scene_target = arg_68_0

	local var_68_0 = require("scenes.battle.BattlePreLayer").new(arg_68_0.params)

	arg_68_0:addChild(var_68_0, SceneZorder.eBattlePreload)
end

function var_0_8.onExit(arg_69_0)
	BattleData:reset()
end

function var_0_8.guiderStage1(arg_70_0, arg_70_1)
	arg_70_0.uiLayer:refreshLabel({
		left2 = 3,
		right2 = 6,
		left1 = 3,
		right1 = 6
	})

	BattleData.guiderStep = 1

	local var_70_0 = {
		{
			npcId = "" .. 0,
			content = string.lf("我滴那个神呐！你们这些妖魔追我干嘛啊？我给你们跪了行不？")
		},
		{
			npcId = "" .. 1000006,
			content = string.lf("瞧你那怂样，鸿钧老儿的护卫就这么点节操么，交出鸿钧老祖神魂，可以放你走！")
		}
	}
	local var_70_1 = require("scenes.battle.BattleChatLayer"):new()

	arg_70_0:addChild(var_70_1, SceneZorder.eBattleFront)
	var_70_1:setup(var_70_0, arg_70_1)
end

function var_0_8.guiderStage2(arg_71_0, arg_71_1)
	BattleData.guiderStep = BattleData.guiderStep + 1

	local var_71_0 = {
		{
			npcId = "" .. 0,
			content = string.lf("哎呀！下手也太歹毒了吧，这招我只能用一次，你们看好了！急急如律令，走过路过不要错过，大仙召唤！")
		}
	}
	local var_71_1 = require("scenes.battle.BattleChatLayer"):new()

	arg_71_0:addChild(var_71_1, SceneZorder.eBattleFront)
	var_71_1:setup(var_71_0, function(...)
		arg_71_0.uiLayer:refreshLabel({
			left2 = 6,
			right2 = 6,
			left1 = 6,
			right1 = 6
		})

		local var_72_0 = {}

		var_72_0.heroId = 103
		var_72_0.battleIx = 6
		var_72_0.currentHealth = 225000
		var_72_0.maxHealth = 225000
		var_72_0.rage = 50
		var_72_0.isHero = true
		var_72_0.usedSkill = {}
		BattleData.Heros[var_72_0.battleIx] = var_72_0
		var_72_0.death = BattleDeathType.eLive
		var_72_0.rebirthCount = 0

		BattleData:checkWeaponError(var_72_0, getHeroGroupWeaponId(var_72_0.heroId), 1, var_72_0.heroId, nil)

		var_72_0.skillId = 44
		var_72_0.talentId = 10046

		local var_72_1 = {}

		var_72_1.heroId = 107
		var_72_1.battleIx = 4
		var_72_1.currentHealth = 300000
		var_72_1.maxHealth = 300000
		var_72_1.rage = 50
		var_72_1.isHero = true
		var_72_1.usedSkill = {}
		BattleData.Heros[var_72_1.battleIx] = var_72_1
		var_72_1.death = BattleDeathType.eLive
		var_72_1.rebirthCount = 0

		BattleData:checkWeaponError(var_72_1, getHeroGroupWeaponId(var_72_1.heroId), 1, var_72_1.heroId, nil)

		var_72_1.skillId = 48
		var_72_1.talentId = 10047
		BattleData.numHero = 6

		for iter_72_0, iter_72_1 in pairs(arg_71_0.heroList) do
			if iter_72_1.idx == 4 then
				if iter_72_1.kulouske then
					iter_72_1.kulouske:removeFromParentAndCleanup(true)
				end

				iter_72_1:removeFromParentAndCleanup(true)

				arg_71_0.heroList[iter_72_0] = arg_71_0.dragLayer:createSingleHero(BattleData.Heros[4], var_0_5, true, false)
			end

			if iter_72_1.idx == 6 then
				if iter_72_1.kulouske then
					iter_72_1.kulouske:removeFromParentAndCleanup(true)
				end

				iter_72_1:removeFromParentAndCleanup(true)

				arg_71_0.heroList[iter_72_0] = arg_71_0.dragLayer:createSingleHero(BattleData.Heros[6], var_0_5, true, false)
			end
		end

		arg_71_0.progressLayer:bindHero()
		arg_71_0:createShadow(true)

		for iter_72_2, iter_72_3 in pairs(arg_71_0.heroList) do
			if iter_72_3.idx ~= 2 then
				iter_72_3.healthBar_current:getParent():setVisible(false)
				iter_72_3.shadow:setVisible(false)
			end
		end

		BattleComming:guiderComming(function(...)
			for iter_73_0, iter_73_1 in pairs(arg_71_0.heroList) do
				if iter_73_1.idx ~= 2 then
					iter_73_1.healthBar_current:getParent():setVisible(true)
					iter_73_1.shadow:setVisible(true)
				end
			end

			local var_73_0 = CCArray:create()

			var_73_0:addObject(CCDelayTime:create(0.5))
			var_73_0:addObject(CCCallFunc:create(function(...)
				arg_71_0:guiderStage3(function(...)
					arg_71_0:guiderStage4(arg_71_1)
				end)
			end))
			CCDirector:sharedDirector():getRunningScene():runAction(CCSequence:create(var_73_0))
		end)
	end)
end

function var_0_8.guiderStage3(arg_76_0, arg_76_1)
	BattleData.guiderStep = BattleData.guiderStep + 1

	local var_76_0 = {
		{
			npcId = "" .. 1000006,
			content = string.lf("小样~居然敢招人，妈咪妈咪轰~变身~~~~~~~~~~~~")
		}
	}
	local var_76_1 = require("scenes.battle.BattleChatLayer"):new()

	arg_76_0:addChild(var_76_1, SceneZorder.eBattleFront)
	var_76_1:setup(var_76_0, function(...)
		local var_77_0 = {
			rage = 100,
			npcId = 1000007,
			health = 450000,
			pos = 11,
			npcSize = 2,
			node = BattleData:getDisplayNode(11)
		}

		BattleData:transformd(var_77_0.pos, var_77_0, arg_76_0)
		BattleTransform:trasform_new(var_77_0, arg_76_1)
	end)
end

function var_0_8.guiderStage4(arg_78_0, arg_78_1)
	BattleData.guiderStep = BattleData.guiderStep + 1

	local var_78_0 = {
		{
			npcId = "" .. 0,
			content = string.lf("老大们，对面都变身了，你们还不变身，能打过么！求变身~~菠萝菠萝蜜！")
		}
	}
	local var_78_1 = require("scenes.battle.BattleChatLayer"):new()

	arg_78_0:addChild(var_78_1, SceneZorder.eBattleFront)
	var_78_1:setup(var_78_0, function(...)
		for iter_79_0, iter_79_1 in pairs(arg_78_0.heroList) do
			local var_79_0 = CCArray:create()

			var_79_0:addObject(CCDelayTime:create(0.5))
			var_79_0:addObject(CCCallFunc:create(function(...)
				local var_80_0 = {
					figureSize = 20,
					pinjie = 5,
					rebirthCount = 20,
					node = iter_79_1
				}

				if iter_79_1.idx == 2 then
					var_80_0.equipId = getHeroGroupWeaponId(iter_79_1.heroId)
				end

				BattleTransform:upgrade(var_80_0)

				local var_80_1

				var_80_1 = BattleSkeleton:addEffect({
					effectName = "buff_tupo",
					speed = 1.2,
					scale = 2,
					parent = iter_79_1,
					position = ccp(0, 270),
					callbacklist = {
						function()
							var_80_1:removeFromParentAndCleanup(true)
						end,
						1,
						AAT_Percent
					}
				})
			end))
			CCDirector:sharedDirector():getRunningScene():runAction(CCSequence:create(var_79_0))
		end

		local var_79_1 = CCArray:create()

		var_79_1:addObject(CCDelayTime:create(1.5))
		var_79_1:addObject(CCCallFunc:create(arg_78_1))
		CCDirector:sharedDirector():getRunningScene():runAction(CCSequence:create(var_79_1))
	end)
end

function var_0_8.guiderStage5(arg_82_0, arg_82_1)
	BattleData.guiderStep = BattleData.guiderStep + 1

	local var_82_0 = {
		{
			npcId = "" .. 1000007,
			content = string.lf("没想到鸿钧老祖只剩一丝神魄，竟然还有如此威力！今日于我不利，咱们撤，改日再约！")
		}
	}
	local var_82_1 = require("scenes.battle.BattleChatLayer"):new()

	arg_82_0:addChild(var_82_1, SceneZorder.eBattleFront)
	var_82_1:setup(var_82_0, function(...)
		BattleComming:guiderOut()

		local var_83_0 = CCArray:create()

		var_83_0:addObject(CCDelayTime:create(1.5))
		var_83_0:addObject(CCCallFunc:create(function(...)
			local var_84_0 = {
				{
					equipId = 165,
					heroId = 107,
					pinjie = 1,
					rebirthCount = 2,
					name = string.lf("众仙"),
					content = string.lf("A玩家名字A，我看你这样下去不是办法，我们不能每次都来帮你，你的简历我帮你投到\"大闹天宫商城\"了，你先去找几个合伙人吧！")
				}
			}
			local var_84_1 = require("scenes.battle.BattleChatLayer"):new()

			arg_82_0:addChild(var_84_1, SceneZorder.eBattleFront)
			var_84_1:setup(var_84_0, function(...)
				BattleComming:guiderOut()

				local var_85_0 = CCArray:create()

				var_85_0:addObject(CCDelayTime:create(0.5))
				var_85_0:addObject(CCCallFunc:create(arg_82_1))
				CCDirector:sharedDirector():getRunningScene():runAction(CCSequence:create(var_85_0))
			end)
		end))
		CCDirector:sharedDirector():getRunningScene():runAction(CCSequence:create(var_83_0))
	end)
end

function var_0_8.guierInit(arg_86_0, ...)
	BattleData:initGuider()

	arg_86_0.effectLayer = require("scenes.battle.BattleEffectLayer").new()

	arg_86_0:addChild(arg_86_0.effectLayer, SceneZorder.eBattleEffect)

	arg_86_0.stateLayer = require("scenes.battle.BattleStateLayer").new()

	arg_86_0:addChild(arg_86_0.stateLayer, SceneZorder.eBattleState)
	arg_86_0:onCreatePlayerFormation(BattleData.Heros)

	for iter_86_0, iter_86_1 in pairs(arg_86_0.heroList) do
		if iter_86_0 ~= 2 and iter_86_0 ~= 4 and iter_86_0 ~= 6 then
			iter_86_1:setVisible(false)
		end
	end

	arg_86_0.enemyList = arg_86_0.dragLayer:viewEnemy(BattleData.enemy, var_0_6)

	for iter_86_2, iter_86_3 in pairs(arg_86_0.enemyList) do
		iter_86_3:setVisible(false)
	end

	local function var_86_0()
		if arg_86_0.bgNode then
			arg_86_0.bgNode:removeFromParentAndCleanup(true)

			arg_86_0.bgNode = nil
		end

		if arg_86_0.maskLayer then
			arg_86_0.maskLayer:removeFromParentAndCleanup(true)

			arg_86_0.maskLayer = nil
		end

		arg_86_0:createShadow(true)
		arg_86_0:startBattle()
	end

	BattleComming:beforeBattleComming(var_86_0)
end

return var_0_8
