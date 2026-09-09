local var_0_0 = class("BattleChatLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

function var_0_0.ctor(arg_2_0, ...)
	arg_2_0.operator = false

	local function var_2_0(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			if arg_2_0.operator then
				arg_2_0:finishAnimation(arg_2_0.content, arg_2_0.content.text)
			else
				arg_2_0.step = arg_2_0.step + 1

				arg_2_0:view()
			end

			return true
		elseif arg_3_0 == "moved" then
			-- block empty
		elseif arg_3_0 == "ended" then
			-- block empty
		end
	end

	arg_2_0:addTouchEventListener(var_2_0, false, 1, true)
	arg_2_0:setTouchEnabled(true)
end

function var_0_0.show(arg_4_0, arg_4_1)
	arg_4_0:clear()

	if arg_4_0.header and (arg_4_0.header.heroId ~= arg_4_1.heroId or arg_4_0.header.npcId ~= arg_4_1.npcId) then
		arg_4_0.header:removeFromParentAndCleanup(true)
		arg_4_0.name:removeFromParentAndCleanup(true)

		arg_4_0.header = nil
	end

	if not arg_4_0.header then
		local var_4_0 = {
			platTable = false,
			isHero = true,
			scale = 1,
			isViewQuality = false
		}

		if arg_4_1.heroId then
			var_4_0.figId = arg_4_1.heroId
		elseif arg_4_1.npcId then
			var_4_0.enemyId = arg_4_1.npcId
		elseif arg_4_1.animation then
			var_4_0.transAnim = arg_4_1.animation
		end

		local var_4_1 = figure.createHero(var_4_0)

		var_4_1:setScale(Adapter.MinScale)
		arg_4_0:addChild(var_4_1, 2)

		var_4_1.heroId = arg_4_1.heroId
		var_4_1.viewParam = {
			figureNode = var_4_1,
			rebirthCount = arg_4_1.rebirthCount,
			equipId = arg_4_1.equipId,
			heroId = arg_4_1.heroId,
			enemyId = arg_4_1.transId or arg_4_1.npcId,
			pingjie = arg_4_1.pinjie,
			skinName = arg_4_1.skinName
		}

		figure.setupFigure(var_4_1.viewParam)

		arg_4_0.header = var_4_1

		local var_4_2 = ui.newTTFLabel({
			text = arg_4_1.name,
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(33),
			align = ui.TEXT_ALIGN_CENTER
		})

		arg_4_0:addChild(var_4_2, 3)

		arg_4_0.name = var_4_2

		if arg_4_1.heroId then
			var_4_1:setPosition(Adapter.AutoPos(-500, 50))
			var_4_1:runAction(CCMoveTo:create(0.3, Adapter.AutoPos(150, 50)))
			var_4_2:setPosition(Adapter.AutoPos(300, 200))
		else
			var_4_1:setPosition(Adapter.AutoPos(1200, 50))
			var_4_1:runAction(CCMoveTo:create(0.3, Adapter.AutoPos(850, 50)))
			var_4_1:setRotationY(180)
			var_4_2:setPosition(Adapter.AutoPos(700, 200))
		end
	end

	if not arg_4_0.bgSprite then
		local var_4_3 = CCSprite:create("ui/battle/battle_019.png")

		var_4_3:setScaleX(Adapter.AutoScaleX)
		var_4_3:setScaleY(Adapter.AutoScaleY)
		var_4_3:setPosition(Adapter.AutoPos(480, 150))
		arg_4_0:addChild(var_4_3, 1)
		var_4_3:setOpacity(0)
		var_4_3:runAction(CCFadeIn:create(0.3))

		arg_4_0.bgSprite = var_4_3
	end

	if not arg_4_0.content then
		local var_4_4 = ui.newTTFLabel({
			text = "",
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(26),
			align = ui.TEXT_ALIGN_LEFT,
			valign = ui.TEXT_VALIGN_TOP,
			dimensions = Adapter.AutoSize(550, 120)
		})

		arg_4_0:addChild(var_4_4, 3)

		arg_4_0.content = var_4_4
		arg_4_0.content.text = arg_4_1.content
	else
		arg_4_0.content:setString("")
	end

	if arg_4_1.heroId then
		arg_4_0.content:setPosition(Adapter.AutoPos(650, 130))
	else
		arg_4_0.content:setPosition(Adapter.AutoPos(320, 130))
	end

	local var_4_5 = CCArray:create()

	var_4_5:addObject(CCDelayTime:create(0.3))
	var_4_5:addObject(CCCallFunc:create(function()
		arg_4_0:labelAnimation(arg_4_0.content, arg_4_1.content, 0.1, function(...)
			arg_4_0.operator = false
		end)
	end))
	arg_4_0.content:runAction(CCSequence:create(var_4_5))

	arg_4_0.operator = true
end

function var_0_0.clear(arg_7_0)
	if arg_7_0.header then
		arg_7_0.header:removeFromParentAndCleanup(true)

		arg_7_0.header = nil
	end

	if arg_7_0.name then
		arg_7_0.name:removeFromParentAndCleanup(true)

		arg_7_0.name = nil
	end

	if arg_7_0.bgSprite then
		arg_7_0.bgSprite:removeFromParentAndCleanup(true)

		arg_7_0.bgSprite = nil
	end

	if arg_7_0.content then
		arg_7_0.content:removeFromParentAndCleanup(true)

		arg_7_0.content = nil
	end

	arg_7_0.operator = false
end

function var_0_0.setup(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:getParent().uiLayer:buttonVisible(false)

	arg_8_0.params = arg_8_1
	arg_8_0.callback = arg_8_2
	arg_8_0.step = 1

	arg_8_0:view()
end

function var_0_0.view(arg_9_0)
	local var_9_0 = arg_9_0.params
	local var_9_1 = arg_9_0.step

	if var_9_1 <= #var_9_0 then
		var_9_0[var_9_1].content = string.gsub(var_9_0[var_9_1].content, "A玩家名字A", Player.nickName)

		local var_9_2 = {}

		if var_9_0[var_9_1].npcId == "0" then
			if var_9_0[var_9_1].name and var_9_0[var_9_1].name ~= "" then
				var_9_2.name = var_9_0[var_9_1].name
			else
				var_9_2.name = Player.nickName
			end

			var_9_2.content = var_9_0[var_9_1].content

			local var_9_3 = Player.team.groupList[1]

			var_9_2.heroId = var_9_3.heroId

			for iter_9_0, iter_9_1 in pairs(var_9_3.equipList) do
				if BaseEquips[iter_9_1.equipId].equipType == EquipType.eWeapon then
					var_9_2.equipId = iter_9_1.equipId
					var_9_2.pinjie = iter_9_1.pinJie

					break
				end
			end

			var_9_2.rebirthCount = var_9_3.rebirthCount

			arg_9_0:show(var_9_2)
		elseif var_9_0[var_9_1].heroId then
			var_9_2.name = var_9_0[var_9_1].name or Player.nickName
			var_9_2.content = var_9_0[var_9_1].content
			var_9_2.heroId = var_9_0[var_9_1].heroId
			var_9_2.equipId = var_9_0[var_9_1].equipId
			var_9_2.pinjie = var_9_0[var_9_1].pinjie
			var_9_2.rebirthCount = var_9_0[var_9_1].rebirthCount

			arg_9_0:show(var_9_2)
		else
			if var_9_0[var_9_1].npcId then
				var_9_2.npcId = tonumber(var_9_0[var_9_1].npcId)
				var_9_2.name = var_9_0[var_9_1].name or BaseNPCs[var_9_2.npcId].name
				var_9_2.equipId = BaseNPCs[var_9_2.npcId].equipId
			else
				var_9_2.transId = var_9_0[var_9_1].transId
				var_9_2.animation = var_9_0[var_9_1].animation
				var_9_2.skinName = var_9_0[var_9_1].skinName
				var_9_2.equipId = var_9_0[var_9_1].equipId
				var_9_2.name = var_9_0[var_9_1].name
			end

			var_9_2.content = var_9_0[var_9_1].content

			arg_9_0:show(var_9_2)
		end
	else
		arg_9_0:getParent().uiLayer:buttonVisible(true)
		arg_9_0:removeFromParentAndCleanup(true)
		arg_9_0.callback()

		arg_9_0.callback = nil
	end
end

function var_0_0.labelAnimation(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = arg_10_0:utf8_StringOfChar(arg_10_2)
	local var_10_1 = 0
	local var_10_2 = 0

	local function var_10_3(arg_11_0)
		var_10_2 = var_10_2 + arg_11_0 * 2

		if var_10_2 >= arg_10_3 then
			var_10_2 = 0

			if var_10_1 + 1 <= #var_10_0 then
				var_10_1 = var_10_1 + 1

				arg_10_1:setString(string.sub(arg_10_2, 1, var_10_0[var_10_1] + 1))
			else
				arg_10_0:finishAnimation(arg_10_1, arg_10_2, arg_10_4)
			end
		end
	end

	arg_10_1:scheduleUpdate(var_10_3)
end

function var_0_0.finishAnimation(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_1:unscheduleUpdate()
	arg_12_1:setString(arg_12_2)

	arg_12_0.operator = false

	if arg_12_3 then
		arg_12_3()
	end
end

function var_0_0.utf8_StringOfChar(arg_13_0, arg_13_1)
	arg_13_0.data32 = {}

	for iter_13_0 = 1, 32 do
		arg_13_0.data32[iter_13_0] = 2^(32 - iter_13_0)
	end

	local function var_13_0(arg_14_0)
		local var_14_0 = {}

		for iter_14_0 = 1, 32 do
			if arg_14_0 >= arg_13_0.data32[iter_14_0] then
				var_14_0[iter_14_0] = 1
				arg_14_0 = arg_14_0 - arg_13_0.data32[iter_14_0]
			else
				var_14_0[iter_14_0] = 0
			end
		end

		return var_14_0
	end

	local function var_13_1(arg_15_0)
		local var_15_0 = 0

		for iter_15_0 = 1, 32 do
			if arg_15_0[iter_15_0] == 1 then
				var_15_0 = var_15_0 + 2^(32 - iter_15_0)
			end
		end

		return var_15_0
	end

	local function var_13_2(arg_16_0, arg_16_1)
		local var_16_0 = var_13_0(arg_16_0)
		local var_16_1 = var_13_0(arg_16_1)
		local var_16_2 = {}

		for iter_16_0 = 1, 32 do
			if var_16_0[iter_16_0] == 1 and var_16_1[iter_16_0] == 1 then
				var_16_2[iter_16_0] = 1
			else
				var_16_2[iter_16_0] = 0
			end
		end

		return var_13_1(var_16_2)
	end

	local var_13_3 = 1
	local var_13_4 = {}

	while true do
		if var_13_3 + 1 <= string.len(arg_13_1) then
			local var_13_5 = string.sub(arg_13_1, var_13_3, var_13_3 + 1)
			local var_13_6 = string.byte(var_13_5)

			if var_13_2(var_13_6, 192) ~= 128 then
				table.insert(var_13_4, var_13_3 + 1)
			end

			var_13_3 = var_13_3 + 1
		else
			break
		end
	end

	return var_13_4
end

return var_0_0
