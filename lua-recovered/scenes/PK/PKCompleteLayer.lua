require("base.functions")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = class("PKCompleteLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create(ccc4(10, 10, 10, 160)))
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	if not arg_2_1.rival then
		arg_2_1.rival = string.lf("神魔仙友")
	end

	if not arg_2_1.reward then
		arg_2_1.reward = {}
	end

	arg_2_0.params = arg_2_1

	arg_2_0:initLayout(arg_2_1)
end

function var_0_1.initLayout(arg_3_0, arg_3_1)
	arg_3_0:addTouchEventListener(handler(arg_3_0, arg_3_0.touchhandler), false, 1, true)
	arg_3_0:setTouchEnabled(true)
	arg_3_0:setAnchorPoint(CCPoint(0, 0))
	arg_3_0:setPosition(0, 0)

	local var_3_0 = arg_3_0:createPopupBox(arg_3_1, function(...)
		arg_3_0:removeFromParentAndCleanup(true)
		arg_3_1.callback(...)
	end)
	local var_3_1 = var_3_0:getContentSize()

	var_3_0:setAnchorPoint(ccp(0.5, 0.5))
	var_3_0:setScale(Adapter.MinScale)
	var_3_0:setPosition(display.cx, display.cy + 50)
	arg_3_0:addChild(var_3_0)
end

function var_0_1.createPopupBox(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0

	if arg_5_1.result or arg_5_1.type == eBattleType.ChampionShip then
		var_5_0 = arg_5_0:createVictoryView(arg_5_1, arg_5_2)
	else
		var_5_0 = arg_5_0:createFailureView(arg_5_1, arg_5_2)
	end

	return var_5_0
end

function var_0_1.createVictoryView(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1.type
	local var_6_1 = arg_6_1.rival
	local var_6_2 = arg_6_1.result
	local var_6_3 = arg_6_1.text
	local var_6_4 = arg_6_1.reward

	if arg_6_1.type == eBattleType.Transport or arg_6_1.type == eBattleType.Challenge or arg_6_1.type == eBattleType.DarkHouseCatch or arg_6_1.type == eBattleType.DarkHouseSave or arg_6_1.type == eBattleType.DuleFightRival or arg_6_1.type == eBattleType.BattleCopy or arg_6_1.type == eBattleType.DuleRevenge then
		var_6_4 = arg_6_1.data.global or {}
	end

	local var_6_5 = display.newSprite("ui/battle/battle_038.png")
	local var_6_6 = var_6_5:getContentSize()
	local var_6_7 = display.newSprite("uilocal/battle/battle_text_001.png")

	var_6_7:align(display.CENTER_BOTTOM, var_6_6.width / 2, 260)
	var_6_5:addChild(var_6_7)

	local var_6_8

	if var_6_3 and var_6_3[1] then
		var_6_8 = var_6_3[1]
	elseif arg_6_1.type == eBattleType.ChampionShip then
		if arg_6_1.result then
			var_6_8 = string.lf("战斗结束！\n挑战方获得胜利！")
		else
			var_6_8 = string.lf("战斗结束！\n防守方获得胜利！")
		end
	else
		var_6_8 = string.lf("恭喜上仙！您法力广大，仙术超群！\n%s 被打得鼻青脸肿，抱头逃窜。", var_6_1)
	end

	local var_6_9 = var_0_0.newLabel({
		size = 22,
		text = var_6_8,
		color = ccc3(238, 190, 98),
		dimensions = CCSize(400, 60),
		align = ui.TEXT_ALIGN_CENTER
	})

	var_6_9:setPosition(var_6_6.width / 2, var_6_6.height / 2 - 40)
	var_6_5:addChild(var_6_9)
	arg_6_0:showRewardNode(var_6_5, 110, var_6_4)

	return var_6_5
end

function var_0_1.createFailureView(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1.type
	local var_7_1 = arg_7_1.rival
	local var_7_2 = arg_7_1.result
	local var_7_3 = arg_7_1.text
	local var_7_4 = arg_7_1.reward
	local var_7_5 = display.newSprite("ui/battle/battle_037.png")
	local var_7_6 = var_7_5:getContentSize()

	if arg_7_1.type == eBattleType.Challenge then
		var_7_4 = arg_7_1.data.global or {}
	elseif arg_7_1.type == eBattleType.DuleFightRival or arg_7_1.type == eBattleType.DuleRevenge then
		var_7_4 = arg_7_1.data.global or {}
	end

	local var_7_7

	if var_7_3 and var_7_3[2] then
		var_7_7 = var_7_3[2]
	else
		var_7_7 = string.lf("很遗憾，您战败了～～\n建议去锻造装备或者换一些更强的战将队伍！")
	end

	local var_7_8 = var_0_0.newLabel({
		text = var_7_7,
		color = ccc3(255, 255, 255),
		dimensions = CCSize(400, 60)
	})

	var_7_8:setPosition(var_7_6.width / 2 + 10, var_7_6.height / 2 + 10)
	var_7_5:addChild(var_7_8)
	arg_7_0:showRewardNode(var_7_5, 130, var_7_4)

	local var_7_9 = ui.newControlButton({
		normalImage = "ui/common/common_018.png",
		text = string.lf("返回"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_8_0, arg_8_1)
			local var_8_0 = arg_7_1.callback
			local var_8_1 = arg_7_1.type == eBattleType.Map and arg_7_1.stageId or arg_7_1

			if var_8_0 then
				var_8_0(arg_7_1.result, arg_7_1.data, var_8_1)
			else
				({
					[eBattleType.Map] = game.enterMapWorldScene,
					[eBattleType.Towr] = game.enterTowerScene,
					[eBattleType.DarkHouseCatch] = game.enterSlaveScene,
					[eBattleType.DarkHouseSave] = game.enterSlaveScene,
					[eBattleType.DarkHouseRevolt] = game.enterSlaveScene,
					[eBattleType.Transport] = game.enterTransportScene,
					[eBattleType.Challenge] = game.enterPKScene,
					[eBattleType.BattleCopy] = game.enterFubenIndexScene,
					[eBattleType.ZSQFight] = game.enterZSQHomeScene,
					[eBattleType.ZSZZBattleRecord] = game.enterZSZZHomeScene
				})[var_7_0]()
			end

			arg_7_0:removeFromParentAndCleanup(true)
		end
	})

	var_7_9:setPosition(var_7_6.width / 2 - 100, 30)
	var_7_5:addChild(var_7_9)

	local var_7_10 = ui.newControlButton({
		normalImage = "ui/common/common_018.png",
		text = string.lf("变强"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_9_0, arg_9_1)
			game.enterTeamScene({})
		end
	})

	var_7_10:setPosition(var_7_6.width / 2 + 100, 30)
	var_7_5:addChild(var_7_10)

	return var_7_5
end

function var_0_1.showRewardNode(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_1:getContentSize()
	local var_10_1 = table.nums(arg_10_3)
	local var_10_2 = 86
	local var_10_3 = (var_10_0.width - var_10_1 * var_10_2 - (var_10_1 - 1) * 20) / 2 + var_10_2 / 2

	for iter_10_0, iter_10_1 in ipairs(arg_10_3) do
		local var_10_4 = figure.createHeader({
			isName = false,
			inTeam = false,
			itemId = iter_10_1.ID,
			type = iter_10_1.Type,
			count = iter_10_1.Count
		})

		var_10_4:setAnchorPoint(CCPoint(0.5, 0.5))
		var_10_4:setPosition(var_10_3, arg_10_2)
		arg_10_1:addChild(var_10_4)
		addLabelWithColorSize(arg_10_1, getItemName(iter_10_1.Type, iter_10_1.ID), ccc3(250, 230, 60), 20, CCPoint(0.5, 0), CCPoint(var_10_3, arg_10_2 - 65))

		var_10_3 = var_10_3 + var_10_2 + 20
	end
end

function var_0_1.touchhandler(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0.params
	local var_11_1 = var_11_0.result
	local var_11_2 = var_11_0.callback

	if var_11_1 or var_11_0.type == eBattleType.ChampionShip then
		if var_11_2 then
			arg_11_0:setTouchEnabled(false)
			arg_11_0:removeFromParentAndCleanup(true)
			var_11_2(var_11_0.result, var_11_0.data, var_11_0)
		else
			arg_11_0:removeFromParent()
		end
	end

	return true
end

return var_0_1
