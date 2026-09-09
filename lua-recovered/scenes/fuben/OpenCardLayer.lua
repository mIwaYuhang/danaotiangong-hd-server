local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("OpenCardLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0.copyInfo = arg_2_1.copy

	dump(arg_2_0.copyInfo.OpenCardReward)

	arg_2_0.callBack = arg_2_1.callBack

	local var_2_0 = require("scenes.CommonBgLayer").new({
		titleSprite = "uilocal/fuben/fuben_text_001.png",
		returnAction = backAction
	})

	arg_2_0:addChild(var_2_0)

	arg_2_0.bgSprite = var_2_0:getBackgroundSprite()
	arg_2_0.labels = {}
	arg_2_0.openCardNumber = arg_2_0:getCanOpenCount()
	arg_2_0.controlButton = ui.newControlButton({
		highlightedImage = "ui/common/common_055.png",
		normalImage = "ui/common/common_019.png",
		clickAction = handler(arg_2_0, arg_2_0.sureButtonClicked),
		position = ccp(480, 40),
		text = string.lf("确定"),
		textColor = ColorTable.eTitleButton_Normal2,
		fontSize = ColorTable.eTitleButton_FontSize2
	})

	arg_2_0.controlButton:setEnabled(false)
	arg_2_0.bgSprite:addChild(arg_2_0.controlButton, 0)
	arg_2_0:initRequests()
	arg_2_0:setLabels()
	arg_2_0:showCards()
end

function var_0_1.initRequests(arg_3_0)
	local function var_3_0()
		arg_3_0.openCardNumber = arg_3_0.openCardNumber - 1

		local var_4_0 = arg_3_0.openCardRequest:getRewardLocation()

		for iter_4_0 = 1, #arg_3_0.copyInfo.OpenCardReward do
			if arg_3_0.copyInfo.OpenCardReward[iter_4_0].Location == var_4_0 then
				arg_3_0.copyInfo.OpenCardReward[iter_4_0].Status = 1
				arg_3_0.copyInfo.OpenCardReward[iter_4_0], arg_3_0.copyInfo.OpenCardReward[arg_3_0.location] = arg_3_0.copyInfo.OpenCardReward[arg_3_0.location], arg_3_0.copyInfo.OpenCardReward[iter_4_0]

				local var_4_1 = arg_3_0.copyInfo.OpenCardReward[iter_4_0].Type
				local var_4_2 = arg_3_0.copyInfo.OpenCardReward[iter_4_0].Count

				if var_4_1 == ItemType.eCoin then
					arg_3_0.copyInfo.Gold = arg_3_0.copyInfo.Gold + var_4_2
				elseif var_4_1 == ItemType.eEXP then
					arg_3_0.copyInfo.Exp = arg_3_0.copyInfo.Exp + var_4_2
				elseif var_4_1 == ItemType.eKnowledge then
					arg_3_0.copyInfo.Knowledge = arg_3_0.copyInfo.Knowledge + var_4_2
				end
			end
		end

		local var_4_3 = arg_3_0.bgSprite:getChildByTag(arg_3_0.location)

		arg_3_0:openCard(var_4_3, false)
	end

	arg_3_0.openCardRequest = OpenCardRequest:new()

	arg_3_0.openCardRequest:setResponseNormalHandler(var_3_0)
end

function var_0_1.setLabels(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.labels) do
		iter_5_1:removeFromParent()
	end

	arg_5_0.labels = {}

	local var_5_0 = {
		{
			fontSize = 26,
			y = 600,
			type = 1,
			x = 410,
			title = string.lf("翻牌次数 %d/%d", arg_5_0:getCanOpenCount(), arg_5_0.copyInfo.OpenCardNumber),
			color = ccc3(255, 187, 0),
			size = CCSize(300, 40)
		},
		{
			fontSize = 22,
			y = 100,
			type = 2,
			x = 50,
			title = string.lf("累计奖励:"),
			color = ccc3(253, 149, 1),
			size = CCSize(400, 40)
		},
		{
			fontSize = 22,
			y = 100,
			type = 3,
			x = 145,
			title = string.lf("阅历 %d", arg_5_0.copyInfo.Knowledge),
			color = ccc3(253, 149, 1),
			size = CCSize(400, 40)
		},
		{
			fontSize = 22,
			y = 70,
			type = 3,
			x = 145,
			title = string.lf("银币 %d", arg_5_0.copyInfo.Gold),
			color = ccc3(253, 149, 1),
			size = CCSize(400, 40)
		},
		{
			fontSize = 22,
			y = 40,
			type = 4,
			x = 145,
			title = string.lf("经验 %d", arg_5_0.copyInfo.Exp),
			color = ccc3(253, 149, 1),
			size = CCSize(300, 40)
		}
	}

	for iter_5_2, iter_5_3 in ipairs(var_5_0) do
		local var_5_1 = ui.newTTFLabel({
			text = iter_5_3.title,
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(iter_5_3.fontSize),
			color = iter_5_3.color,
			align = ui.TEXT_ALIGN_LEFT,
			valign = ui.TEXT_VALIGN_CENTER,
			dimensions = iter_5_3.size,
			x = iter_5_3.x,
			y = iter_5_3.y
		})

		arg_5_0.bgSprite:addChild(var_5_1)
		Adapter.NodeAbsScale(var_5_1)
		table.insert(arg_5_0.labels, var_5_1)
	end
end

function var_0_1.showCards(arg_6_0)
	arg_6_0.buttons = {}

	for iter_6_0 = 0, 9 do
		local var_6_0 = 160 + iter_6_0 % 5 * 160
		local var_6_1 = 230 + math.floor(iter_6_0 / 5) * 220
		local var_6_2 = ui.newControlButton({
			fontSize = 24,
			text = "",
			normalImage = "ui/fuben/fuben_013.png",
			scaleX = 1,
			scaleY = 1,
			position = ccp(var_6_0, var_6_1),
			clickAction = handler(arg_6_0, arg_6_0.buttonClicked),
			anchorPoint = CCPoint(0.5, 0.5)
		})

		var_6_2:setTag(iter_6_0 + 1)
		var_6_2:setEnabled(false)
		Adapter.NodeAbsScale(var_6_2)
		arg_6_0.bgSprite:addChild(var_6_2)
		table.insert(arg_6_0.buttons, var_6_2)
		arg_6_0:showCardInfo(var_6_2)
	end

	arg_6_0.delayTime, arg_6_0.orbitTime = 0.6, 0.5

	for iter_6_1 = 1, 10 do
		repeat
			local var_6_3 = arg_6_0.buttons[iter_6_1]

			if arg_6_0.copyInfo.OpenCardReward[iter_6_1].Status == 1 then
				break
			end

			arg_6_0:openCard(var_6_3, true)
		until true
	end

	local var_6_4 = CCArray:create()

	var_6_4:addObject(CCDelayTime:create(arg_6_0.delayTime + arg_6_0.orbitTime * 2))
	var_6_4:addObject(CCCallFunc:create(handler(arg_6_0, arg_6_0.showRandomCard)))
	arg_6_0:runAction(CCSequence:create(var_6_4))
end

function var_0_1.buttonClicked(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = tolua.cast(arg_7_2, "CCControlButton")

	arg_7_0.location = var_7_0:getTag()

	local var_7_1 = arg_7_0:getCanOpenCount()
	local var_7_2 = arg_7_0.copyInfo.OpenCardReward[arg_7_0.location]

	if var_7_1 > 0 and var_7_2.Status == 0 then
		arg_7_0.openCardRequest:request(arg_7_0.copyInfo.CopyID)

		for iter_7_0, iter_7_1 in ipairs(arg_7_0.buttons) do
			iter_7_1:setEnabled(false)
		end
	else
		print("\n\n\n 显示奖励物品Tips")

		local var_7_3

		if var_7_2.Type == ItemType.eProp then
			var_7_3 = BaseProps[var_7_2.ID]
		elseif var_7_2.Type == ItemType.eEquip then
			var_7_3 = BaseEquips[var_7_2.ID]
		elseif var_7_2.Type == ItemType.eFragment then
			var_7_3 = BaseFragments[var_7_2.ID]
		elseif var_7_2.Type == ItemType.eHero then
			var_7_3 = BaseHeros[var_7_2.ID]
		elseif var_7_2.Type == ItemType.eSoul then
			var_7_3 = BaseSouls[var_7_2.ID]
		else
			var_7_3 = BaseMates[var_7_2.ID]
		end

		if var_7_3 == nil then
			return
		end

		print(var_7_3.desc)

		local var_7_4 = ui.newTTFLabel({
			size = 20,
			text = var_7_3.desc or "",
			font = _FONT_DEFAULT,
			color = ccc3(248, 236, 68),
			dimensions = CCSize(160, 120)
		})
		local var_7_5 = var_0_0.new({
			prefer = var_0_0.ePreferTop,
			title = {
				size = 22,
				text = var_7_3.name,
				color = ccc3(248, 236, 68)
			}
		})
		local var_7_6 = {
			x = 0,
			y = 0
		}

		var_7_6.x, var_7_6.y = var_7_0:getPosition()

		var_7_5:addNode(var_7_4)
		var_7_5:show({
			parent = arg_7_0.bgSprite,
			x = var_7_6.x,
			y = var_7_6.y - 50,
			align = display.CENTER_BOTTOM
		})
	end
end

function var_0_1.sureButtonClicked(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.callBack()
	arg_8_0:removeFromParent()
end

function var_0_1.showRandomCard(arg_9_0)
	print("随机打乱效果")

	local var_9_0 = {}

	for iter_9_0 = 1, 10 do
		local var_9_1 = arg_9_0.buttons[iter_9_0]
		local var_9_2 = {
			x = 0,
			y = 0
		}

		var_9_2.x, var_9_2.y = var_9_1:getPosition()

		table.insert(var_9_0, var_9_2)
	end

	local var_9_3 = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		10
	}

	for iter_9_1 = 1, 10 do
		local var_9_4 = math.random(1, table.getn(var_9_3))
		local var_9_5 = var_9_0[var_9_3[var_9_4]].x
		local var_9_6 = var_9_0[var_9_3[var_9_4]].y
		local var_9_7 = CCMoveTo:create(0.3, ccp(var_9_5, var_9_6))

		table.remove(var_9_3, var_9_4)

		local var_9_8, var_9_9 = arg_9_0.buttons[iter_9_1]:getPosition()
		local var_9_10 = CCMoveTo:create(0.1 + 0.1 * (iter_9_1 % 2), ccp(var_9_0[iter_9_1 > 5 and iter_9_1 - 5 or iter_9_1 + 5].x, var_9_0[iter_9_1 > 5 and iter_9_1 - 5 or iter_9_1 + 5].y))
		local var_9_11 = CCMoveTo:create(0.2 + 0.1 * (math.random(1, 2) % 2), ccp(var_9_0[11 - iter_9_1].x, var_9_0[11 - iter_9_1].y))
		local var_9_12 = CCMoveTo:create(0.3, ccp(480, 320))
		local var_9_13 = CCMoveTo:create(0.3, ccp(var_9_8, var_9_9))
		local var_9_14 = CCArray:create()

		var_9_14:addObject(var_9_10)
		var_9_14:addObject(var_9_13)
		var_9_14:addObject(var_9_11)
		var_9_14:addObject(var_9_13)
		var_9_14:addObject(var_9_12)

		for iter_9_2 = 0, 6 do
			local var_9_15 = math.random(-30, 30)
			local var_9_16 = math.random(-20, 20)

			var_9_14:addObject(CCMoveTo:create(0.1, ccp(480 + var_9_15 + (var_9_15 >= 0 and 30 or -30), 320 + var_9_16 + (var_9_16 >= 0 and 0 or -20))))
		end

		var_9_14:addObject(var_9_7)

		if iter_9_1 == 10 then
			var_9_14:addObject(CCCallFunc:create(handler(arg_9_0, arg_9_0.setButtonEnabled)))
		end

		arg_9_0.buttons[iter_9_1]:runAction(CCSequence:create(var_9_14))
	end
end

function var_0_1.setButtonEnabled(arg_10_0)
	if arg_10_0:getCanOpenCount() > 0 then
		arg_10_0.controlButton:setEnabled(false)
	else
		arg_10_0.controlButton:setEnabled(true)
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.buttons) do
		iter_10_1:setEnabled(true)
	end
end

function var_0_1.getCanOpenCount(arg_11_0)
	local var_11_0 = 0

	for iter_11_0 = 1, #arg_11_0.copyInfo.OpenCardReward do
		if arg_11_0.copyInfo.OpenCardReward[iter_11_0].Status == 1 then
			var_11_0 = var_11_0 + 1
		end
	end

	return arg_11_0.copyInfo.OpenCardNumber - var_11_0
end

function var_0_1.showCardInfo(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1:getTag()

	if arg_12_0.copyInfo.OpenCardReward[var_12_0].Status == 1 then
		local var_12_1 = display.newSprite("ui/common/bg_choosed_cube.png")

		var_12_1:align(display.CENTER_LEFT, 73, 100)
		var_12_1:setAnchorPoint(ccp(0.5, 0.5))
		var_12_1:setScale(1.2)
		arg_12_1:addChild(var_12_1)
	end

	local var_12_2 = {
		type = arg_12_0.copyInfo.OpenCardReward[var_12_0].Type,
		itemId = arg_12_0.copyInfo.OpenCardReward[var_12_0].ID
	}

	var_12_2.isName = false

	local var_12_3 = figure.createHeader(var_12_2)

	var_12_3:setPosition(73, 100)
	var_12_3:setAnchorPoint(ccp(0.5, 0.5))
	arg_12_1:addChild(var_12_3)
	Adapter.NodeAbsScale(var_12_3)

	local var_12_4 = getItemName(arg_12_0.copyInfo.OpenCardReward[var_12_0].Type, arg_12_0.copyInfo.OpenCardReward[var_12_0].ID)
	local var_12_5 = ui.newTTFLabel({
		y = 35,
		x = 73,
		text = string.format("%s +%d", var_12_4, arg_12_0.copyInfo.OpenCardReward[var_12_0].Count),
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(20),
		color = ccc3(253, 255, 255),
		align = ui.TEXT_ALIGN_CENTER,
		valign = ui.TEXT_VALIGN_CENTER,
		dimensions = CCSize(200, 40)
	})

	arg_12_1:addChild(var_12_5)
	Adapter.NodeAbsScale(var_12_5)
end

function var_0_1.openCard(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_2

	local function var_13_1()
		if arg_13_0.openCardNumber == 0 then
			arg_13_0.openCardNumber = -1

			for iter_14_0 = 1, 10 do
				repeat
					local var_14_0 = arg_13_0.buttons[iter_14_0]

					if arg_13_0.copyInfo.OpenCardReward[iter_14_0].Status == 1 then
						break
					end

					arg_13_0:openCard(var_14_0, false)
				until true
			end
		end
	end

	local function var_13_2()
		local var_15_0 = var_13_0 and "ui/fuben/fuben_011.png" or "ui/fuben/fuben_013.png"

		arg_13_1:setBackgroundSpriteForState(CCScale9Sprite:create(var_15_0), CCControlStateNormal)
		arg_13_1:setBackgroundSpriteForState(CCScale9Sprite:create(var_15_0), CCControlStateHighlighted)
		arg_13_1:setBackgroundSpriteForState(CCScale9Sprite:create(var_15_0), CCControlStateDisabled)

		if not var_13_0 then
			arg_13_0:showCardInfo(arg_13_1)
			arg_13_0:setLabels()
			arg_13_0:setButtonEnabled()
		end
	end

	local var_13_3 = CCArray:create()
	local var_13_4 = CCOrbitCamera:create(arg_13_0.orbitTime, 1, 0, 0, 90, 0, 0)

	if var_13_0 then
		var_13_3:addObject(CCDelayTime:create(arg_13_0.delayTime))
	end

	var_13_3:addObject(var_13_4)
	var_13_3:addObject(CCCallFunc:create(var_13_2))
	var_13_3:addObject(var_13_4:reverse())
	var_13_3:addObject(CCCallFunc:create(var_13_1))
	arg_13_1:runAction(CCSequence:create(var_13_3))
end

return var_0_1
