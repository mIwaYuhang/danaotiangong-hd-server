require("network.TeamRequest")

local var_0_0 = class("HeroTrainLayer", function()
	return display.newLayer()
end)
local var_0_1
local var_0_2
local var_0_3 = 1

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.bgSprite = display.newScale9Sprite("ui/team/team_002.png")

	local var_2_0 = arg_2_0.bgSprite:getContentSize()

	if arg_2_1.size then
		var_2_0 = arg_2_1.size
	end

	arg_2_0.back_size = var_2_0

	arg_2_0.bgSprite:setPreferredSize(var_2_0)
	arg_2_0.bgSprite:setAnchorPoint(CCPoint(0, 0))
	arg_2_0.bgSprite:setPosition(CCPoint(0, 2))
	arg_2_0:addChild(arg_2_0.bgSprite)

	arg_2_0.background = CCLayerColor:create(ccc4(0, 0, 0, 0))

	arg_2_0.background:setContentSize(var_2_0)
	arg_2_0.bgSprite:addChild(arg_2_0.background)

	arg_2_0.center_width = arg_2_0.back_size.width / 2

	arg_2_0:initRequests()
	arg_2_0:refreshLayer(arg_2_1)
end

function var_0_0.refreshLayer(arg_3_0, arg_3_1)
	arg_3_0.background:removeAllChildrenWithCleanup(true)

	arg_3_0.resultLayer = display.newScale9Sprite("ui/common/common_064_2.png", arg_3_0.back_size.width / 2, 286, CCSize(430, 140))

	arg_3_0.background:addChild(arg_3_0.resultLayer)

	var_0_1 = arg_3_1.heroItem

	if var_0_1 == nil or var_0_1.heroId <= 0 then
		return
	end

	if arg_3_1.callback then
		var_0_2 = arg_3_1.callback
	end

	arg_3_0:showInfoAttrOld()
	arg_3_0:addCheckboxGroup(arg_3_0.background, CCPoint(arg_3_0.center_width, 133))
	arg_3_0:showTrainButton()
	GuideLayer:stepDone(TaskEntryType.eEntryHeroTrain, 2)
	GuideLayer:removeGuideLayerIfStepGreaterThan(TaskEntryType.eEntryHeroTrain, 2)
end

function var_0_0.initRequests(arg_4_0)
	local function var_4_0()
		arg_4_0.btnTrain:removeFromParentAndCleanup(true)
		arg_4_0:enableCheckbox(false)
		arg_4_0.thePotency:setValue(var_0_1.potency)
		arg_4_0.theTrainPill:setValue(Player.trainPill)
		arg_4_0:showInfoAttrNew()
	end

	arg_4_0.heroTrainRequest = HeroTrainRequest:new()

	arg_4_0.heroTrainRequest:setResponseNormalHandler(var_4_0)

	local function var_4_1()
		if var_0_2 then
			var_0_2({})
		end
	end

	arg_4_0.heroSaveTrainRequest = HeroSaveTrainRequest:new()

	arg_4_0.heroSaveTrainRequest:setResponseNormalHandler(var_4_1)
end

function var_0_0.showInfoAttrOld(arg_7_0)
	local var_7_0 = ccc3(255, 215, 0)
	local var_7_1 = ccc3(255, 150, 0)
	local var_7_2 = ccc3(255, 237, 154)
	local var_7_3 = 60
	local var_7_4 = 253
	local var_7_5 = ccp(0, 0.5)
	local var_7_6 = ui.newTTFLabel({
		y = 115,
		x = 160,
		text = string.lf("当前属性"),
		font = _FONT_LISU,
		color = var_7_0,
		size = Adapter.FontSize(20)
	})

	arg_7_0.resultLayer:addChild(var_7_6)

	local var_7_7 = {
		45,
		45,
		78,
		78
	}

	arg_7_0.newPhysical = addLabelWithColorSize(arg_7_0.resultLayer, string.lf("根骨 %s", var_0_1.physical), var_7_2, 20, var_7_5, CCPoint(var_7_3, var_7_7[4]))
	arg_7_0.newStrength = addLabelWithColorSize(arg_7_0.resultLayer, string.lf("力量 %s", var_0_1.strength), var_7_2, 20, var_7_5, CCPoint(var_7_4, var_7_7[3]))
	arg_7_0.newMana = addLabelWithColorSize(arg_7_0.resultLayer, string.lf("法术 %s", var_0_1.mana), var_7_2, 20, var_7_5, CCPoint(var_7_3, var_7_7[2]))
	arg_7_0.newAgility = addLabelWithColorSize(arg_7_0.resultLayer, string.lf("敏捷 %s", var_0_1.agility), var_7_2, 20, var_7_5, CCPoint(var_7_4, var_7_7[1]))
	arg_7_0.noticeLabel = ui.newTTFLabel({
		y = 200,
		text = string.lf("本次培养消耗#68C83D1#131C67点潜力点，#68C83D10#131C67个培养丹"),
		x = arg_7_0.center_width,
		font = _FONT_LISU,
		color = ccc3(19, 28, 103),
		size = Adapter.FontSize(23),
		align = ui.TEXT_ALIGN_CENTER
	})

	arg_7_0.background:addChild(arg_7_0.noticeLabel)
end

function var_0_0.showInfoAttrNew(arg_8_0)
	local function var_8_0(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
		arg_9_1:setColor(ccc3(0, 255, 60))
		arg_9_1:setVisible(true)

		if arg_9_2 then
			local var_9_0 = tonumber(arg_9_2)

			if var_9_0 > 0 then
				arg_9_1:setString("(+" .. var_9_0 .. "↑)")
			elseif var_9_0 < 0 then
				arg_9_1:setString("(" .. var_9_0 .. "↓)")
				arg_9_1:setColor(ccc3(255, 0, 20))
			else
				arg_9_1:setString("(+0)")
			end

			arg_9_3:setString(arg_9_0 .. tostring(arg_9_4 + var_9_0))
		else
			arg_9_1:setString("(+0)")
		end
	end

	local var_8_1 = arg_8_0.heroTrainRequest.restable.Operator.Changed
	local var_8_2 = {
		45,
		45,
		78,
		78
	}
	local var_8_3 = addLabelWithColorSize(arg_8_0.resultLayer, "", ccc3(0, 0, 0), 20, CCPoint(0, 0.5), CCPoint(160, var_8_2[4]))
	local var_8_4 = addLabelWithColorSize(arg_8_0.resultLayer, "", ccc3(0, 0, 0), 20, CCPoint(0, 0.5), CCPoint(353, var_8_2[3]))
	local var_8_5 = addLabelWithColorSize(arg_8_0.resultLayer, "", ccc3(0, 0, 0), 20, CCPoint(0, 0.5), CCPoint(160, var_8_2[2]))
	local var_8_6 = addLabelWithColorSize(arg_8_0.resultLayer, "", ccc3(0, 0, 0), 20, CCPoint(0, 0.5), CCPoint(353, var_8_2[1]))

	var_8_0(string.lf("根骨 "), var_8_3, var_8_1.Con, arg_8_0.newPhysical, var_0_1.physical)
	var_8_0(string.lf("力量 "), var_8_4, var_8_1.Str, arg_8_0.newStrength, var_0_1.strength)
	var_8_0(string.lf("法术 "), var_8_5, var_8_1.Inte, arg_8_0.newMana, var_0_1.mana)
	var_8_0(string.lf("敏捷 "), var_8_6, var_8_1.Agility, arg_8_0.newAgility, var_0_1.agility)

	local function var_8_7(arg_10_0, arg_10_1)
		arg_8_0.heroSaveTrainRequest:request(var_0_1.heroId)
	end

	local function var_8_8(arg_11_0, arg_11_1)
		if var_0_2 then
			var_0_2({})
		end
	end

	local var_8_9 = ui.newControlButton({
		normalImage = "ui/common/common_018.png",
		text = string.lf("接受"),
		fontSize = ColorTable.eTitleButton_FontSize,
		position = CCPoint(50, 23),
		clickAction = var_8_7,
		textColor = ColorTable.eTitleButton_Normal,
		anchorPoint = CCPoint(0, 0)
	})
	local var_8_10 = ui.newControlButton({
		normalImage = "ui/common/common_018.png",
		text = string.lf("放弃"),
		fontSize = ColorTable.eTitleButton_FontSize,
		position = CCPoint(250, 23),
		clickAction = var_8_8,
		textColor = ColorTable.eTitleButton_Normal,
		anchorPoint = CCPoint(0, 0)
	})

	arg_8_0.background:addChild(var_8_9)
	arg_8_0.background:addChild(var_8_10)
end

function var_0_0.showTrainButton(arg_12_0)
	local var_12_0 = display.newSprite("ui/common/common_064_2.png")

	var_12_0:align(display.BOTTOM_CENTER, arg_12_0.center_width, 445)
	arg_12_0.background:addChild(var_12_0)

	local var_12_1 = var_12_0:getContentSize()
	local var_12_2 = ui.newTTFLabel({
		y = 431,
		text = string.lf("( 培养可提升或改变主将属性 )"),
		x = arg_12_0.center_width,
		font = _FONT_LISU,
		color = ccc3(41, 16, 0),
		size = Adapter.FontSize(20),
		align = ui.TEXT_ALIGN_CENTER
	})

	arg_12_0.background:addChild(var_12_2)

	local var_12_3 = ui.newTTFLabel({
		y = 400,
		text = string.lf("放弃培养，潜力点全部返还，培养丹不返还。"),
		x = arg_12_0.center_width,
		font = _FONT_LISU,
		color = ccc3(12, 0, 0),
		size = Adapter.FontSize(20),
		align = ui.TEXT_ALIGN_CENTER
	})

	arg_12_0.background:addChild(var_12_3)

	local var_12_4 = ccc3(255, 150, 0)
	local var_12_5 = addLabelWithColorSize(var_12_0, string.lf("潜力点"), var_12_4, 20, CCPoint(0, 0.5), CCPoint(0, var_12_1.height / 2 + 5))
	local var_12_6 = addLabelWithColorSize(var_12_0, string.lf("培养丹"), var_12_4, 20, CCPoint(1, 0.5), CCPoint(var_12_1.width - 120, var_12_1.height / 2 + 5))

	if IPlatform:instance():getConfig("Channel") == "ZSY_VN" then
		var_12_5:setVisible(false)
		var_12_6:setVisible(false)
	end

	arg_12_0.thePotency = createItemCountNode({
		type = ItemType.ePotency,
		value = var_0_1.potency,
		color = var_12_4
	})

	arg_12_0.thePotency:setPosition(CCPoint(70, var_12_1.height / 2 + 5))
	var_12_0:addChild(arg_12_0.thePotency)

	arg_12_0.theTrainPill = createItemCountNode({
		type = ItemType.eTrainPill,
		value = Player.trainPill,
		color = var_12_4
	})

	arg_12_0.theTrainPill:setPosition(CCPoint(var_12_1.width - 110, var_12_1.height / 2 + 5))
	var_12_0:addChild(arg_12_0.theTrainPill)

	local function var_12_7(arg_13_0, arg_13_1)
		local var_13_0 = arg_12_0:getCheckboxSelected()

		if var_13_0 == arg_12_0.checkboxTags.tagCheckNormal1 then
			arg_12_0.heroTrainRequest:request(var_0_1.heroId, 1, false)
		elseif var_13_0 == arg_12_0.checkboxTags.tagCheckNormal10 then
			arg_12_0.heroTrainRequest:request(var_0_1.heroId, 10, false)
		elseif var_13_0 == arg_12_0.checkboxTags.tagCheckSpecial1 then
			arg_12_0.heroTrainRequest:request(var_0_1.heroId, 1, true)
		elseif var_13_0 == arg_12_0.checkboxTags.tagCheckSpecial10 then
			arg_12_0.heroTrainRequest:request(var_0_1.heroId, 10, true)
		end
	end

	arg_12_0.btnTrain = ui.newControlButton({
		normalImage = "ui/common/common_018.png",
		text = string.lf("培养"),
		fontSize = ColorTable.eTitleButton_FontSize,
		position = CCPoint(arg_12_0.center_width, 15),
		clickAction = var_12_7,
		textColor = ColorTable.eTitleButton_Normal,
		anchorPoint = CCPoint(0.5, 0)
	})

	arg_12_0.background:addChild(arg_12_0.btnTrain)
end

function var_0_0.addCheckboxGroup(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = ui.newMenu({})

	arg_14_0.checkboxTags = {
		tagCheckNormal1 = 1,
		tagCheckSpecial10 = 4,
		tagCheckSpecial1 = 2,
		tagCheckNormal10 = 3
	}
	arg_14_0.checkboxGroups = {
		{
			checked = false,
			x = 65,
			tag = arg_14_0.checkboxTags.tagCheckNormal1,
			y = arg_14_2.y,
			text = string.lf("    培养1次"),
			noticeText = string.lf("本次培养消耗#00FF001#131C67点潜力点，#00FF0010#131C67个培养丹")
		},
		{
			goldCount = 2,
			checked = false,
			tag = arg_14_0.checkboxTags.tagCheckSpecial1,
			x = arg_14_2.x,
			y = arg_14_2.y,
			text = string.lf("    精心培养1次"),
			noticeText = string.lf("本次培养消耗#00FF001#131C67点潜力点，#00FF0015#131C67个培养丹")
		},
		{
			checked = false,
			x = 65,
			tag = arg_14_0.checkboxTags.tagCheckNormal10,
			y = arg_14_2.y - 44,
			text = string.lf("    培养10次"),
			noticeText = string.lf("本次培养消耗#00FF0010#131C67点潜力点，#00FF00100#131C67个培养丹")
		},
		{
			goldCount = 20,
			checked = false,
			tag = arg_14_0.checkboxTags.tagCheckSpecial10,
			x = arg_14_2.x,
			y = arg_14_2.y - 44,
			text = string.lf("    精心培养10次"),
			noticeText = string.lf("本次培养消耗#00FF0010#131C67点潜力点，#00FF00150#131C67个培养丹")
		}
	}

	local function var_14_1(arg_15_0, arg_15_1)
		for iter_15_0, iter_15_1 in pairs(arg_14_0.checkboxGroups) do
			if iter_15_0 == arg_15_0 then
				if iter_15_1.checked == false then
					iter_15_1.checked = true

					iter_15_1.ctrlName:setTexture(CCTextureCache:sharedTextureCache():addImage("ui/common/common_042.png"))

					var_0_3 = iter_15_0
				end
			elseif iter_15_1.checked == true then
				iter_15_1.checked = false

				iter_15_1.ctrlName:setTexture(CCTextureCache:sharedTextureCache():addImage("ui/common/common_041.png"))
			end
		end

		arg_14_0.noticeLabel:setString(arg_14_0.checkboxGroups[arg_15_0].noticeText)
	end

	for iter_14_0, iter_14_1 in pairs(arg_14_0.checkboxGroups) do
		iter_14_1.listener = var_14_1
		iter_14_1.color = ccc3(41, 16, 0)
		iter_14_1.size = Adapter.FontSize(20)

		if iter_14_1.tag == var_0_3 then
			iter_14_1.checked = true

			arg_14_0.noticeLabel:setString(iter_14_1.noticeText)
		end

		local var_14_2 = ui.newTTFLabelMenuItem(iter_14_1)

		var_14_2:setAnchorPoint(CCPoint(0, 0))

		local var_14_3

		if iter_14_1.checked == true then
			var_14_3 = display.newSprite("ui/common/common_042.png")
		else
			var_14_3 = display.newSprite("ui/common/common_041.png")
		end

		var_14_3:setTag(iter_14_1.tag)
		var_14_3:setScale(0.7)
		var_14_3:align(display.CENTER_LEFT, -10, 14)
		var_14_2:addChild(var_14_3)

		if iter_14_1.goldCount then
			local var_14_4 = createItemCountNode({
				valueOffset = 15,
				type = ItemType.eGold,
				value = iter_14_1.goldCount,
				color = ccc3(41, 16, 0)
			})

			var_14_4:setPosition(163, 14)
			var_14_2:addChild(var_14_4)
		end

		iter_14_1.ctrlName = var_14_3

		var_14_0:addChild(var_14_2)
	end

	arg_14_1:addChild(var_14_0)
end

function var_0_0.enableCheckbox(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.checkboxGroups) do
		iter_16_1.ctrlName:getParent():setEnabled(arg_16_1)
	end
end

function var_0_0.getCheckboxSelected(arg_17_0)
	local var_17_0 = arg_17_0.checkboxTags.tagCheckError

	for iter_17_0, iter_17_1 in pairs(arg_17_0.checkboxGroups) do
		if iter_17_1.checked == true then
			var_17_0 = iter_17_1.tag
		end
	end

	return var_17_0
end

return var_0_0
