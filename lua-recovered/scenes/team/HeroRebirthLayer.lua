require("network.TeamRequest")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = require("scenes.team.DlgBreakThroughLayer")
local var_0_2 = class("HeroRebirthLayer", function()
	return display.newLayer()
end)
local var_0_3
local var_0_4
local var_0_5 = false
local var_0_6

function var_0_2.ctor(arg_2_0, arg_2_1)
	local var_2_0 = display.newScale9Sprite("ui/team/team_050.jpg")
	local var_2_1 = CCSize(445, 510)

	if arg_2_1.size then
		var_2_1 = arg_2_1.size
	end

	var_2_0:setPreferredSize(var_2_1)
	var_2_0:setAnchorPoint(CCPoint(0, 0))
	var_2_0:setPosition(CCPoint(0, 2))
	arg_2_0:addChild(var_2_0)

	arg_2_0.bgSprite = var_2_0
	arg_2_0.background = CCLayerColor:create(ccc4(0, 0, 0, 0))

	arg_2_0.background:setContentSize(var_2_1)
	var_2_0:addChild(arg_2_0.background)

	arg_2_0.back_size = var_2_1

	arg_2_0:initRequests()
	arg_2_0:refreshLayer(arg_2_1)
	GuideLayer:stepDone(TaskEntryType.eEntryHeroSkill, 2)
	GuideLayer:removeGuideLayerIfStepGreaterThan(TaskEntryType.eEntryHeroSkill, 2)
	GuideLayer:stepDone(TaskEntryType.eEntryHeroBreakthrough, 2)
	GuideLayer:removeGuideLayerIfStepGreaterThan(TaskEntryType.eEntryHeroBreakthrough, 2)
end

function var_0_2.refreshLayer(arg_3_0, arg_3_1)
	arg_3_0.background:removeAllChildrenWithCleanup(true)

	arg_3_0.canBeRebirth = false
	arg_3_0.curIndex = arg_3_1.curIndex
	var_0_3 = arg_3_1.heroItem

	if var_0_3 == nil or var_0_3.heroId <= 0 then
		return
	end

	if arg_3_1.callback then
		var_0_4 = arg_3_1.callback
	end

	arg_3_0.isNeedGeneralSoul = false
	arg_3_0.isNeedCount = nil

	arg_3_0:showRebirthProgress()
	arg_3_0:showRebirthMates()
	arg_3_0:showRebirthButton()
end

function var_0_2.initRequests(arg_4_0)
	local function var_4_0()
		var_0_5 = true
		var_0_6 = var_0_3

		if var_0_4 then
			var_0_4({})
		end
	end

	arg_4_0.heroRebirthRequest = HeroRebirthRequest:new()

	arg_4_0.heroRebirthRequest:setResponseNormalHandler(var_4_0)
end

function var_0_2.showRebirthProgress(arg_6_0)
	local var_6_0 = CCSize(arg_6_0.back_size.width - 30, 120)
	local var_6_1 = CCScrollView:create(var_6_0)

	var_6_1:setPosition(15, 135)
	var_6_1:setContentSize(CCSize(arg_6_0:getRebirthDescShowCount() * 75, var_6_0.height))
	var_6_1:setDirection(kCCScrollViewDirectionHorizontal)
	arg_6_0.background:addChild(var_6_1)

	for iter_6_0 = 0, 2 do
		local var_6_2 = display.newSprite("ui/team/team_049.png", iter_6_0 * 299 + 30, 40)

		var_6_2:setOpacity(178)
		var_6_1:addChild(var_6_2)
	end

	local var_6_3 = {
		"ui/team/team_043.png",
		"ui/team/team_044.png",
		"ui/team/team_045.png",
		"ui/team/team_046.png",
		"ui/team/team_047.png",
		"ui/team/team_048.png"
	}

	arg_6_0.previewButtonTable = {}

	for iter_6_1 = 0, arg_6_0:getRebirthDescShowCount() - 1 do
		local var_6_4 = iter_6_1 % 2 == 1
		local var_6_5 = CCPoint(iter_6_1 * 75 + 5, var_6_4 and 40 or 0)
		local var_6_6 = CCSprite:create("ui/team/team_hero_effect1.png")

		var_6_6:setScale(0.8)
		var_6_6:setPosition(var_6_5.x + 32, var_6_5.y + 39)
		var_6_6:runAction(CCRepeatForever:create(CCRotateBy:create(1, 360)))
		var_6_1:getContainer():addChild(var_6_6)
		var_6_6:setVisible(iter_6_1 == 0)

		local var_6_7 = ui.newControlButton({
			normalImage = var_6_3[iter_6_1 % 6 + 1],
			position = var_6_5,
			clickAction = handler(arg_6_0, arg_6_0.showRebirthDescAction)
		})

		var_6_7.tag = iter_6_1 + 1

		var_6_1:addChild(var_6_7)
		table.insert(arg_6_0.previewButtonTable, var_6_7)

		var_6_7.rotateSprite = var_6_6

		local var_6_8 = var_6_7:getPreferredSize()
		local var_6_9 = figure.getRebirthNeedLevel(var_0_3.rebirthCount + iter_6_1)
		local var_6_10, var_6_11 = getHeroCurrentRebirthCountAttrs(var_0_3.heroId, var_0_3.rebirthCount + iter_6_1)

		if not (var_6_9 > var_0_3.level) or not (var_0_3.rebirthCount + iter_6_1 > 1) or var_0_3.rebirthCount >= 26 then
			-- block empty
		else
			var_6_11 = "Lv." .. var_6_9
		end

		local var_6_12 = string.format("+%d\n%s", var_0_3.rebirthCount + iter_6_1, var_6_11)
		local var_6_13 = ui.newTTFLabel({
			y = 44,
			text = var_6_12,
			font = _FONT_LISU,
			size = Adapter.FontSize(20),
			color = ccc3(250, 255, 196),
			x = 10 - Adapter.MinScale * Adapter.MinScale * 5
		})

		var_6_7:addChild(var_6_13)

		var_6_7.showLabel = var_6_13
	end

	arg_6_0.previewSrollView = var_6_1
	arg_6_0.descSliderLayer = arg_6_0:createRebirthDescSlider()

	arg_6_0:showRebirthDescAction("event", arg_6_0.previewButtonTable[1])
end

function var_0_2.getRebirthDescShowCount(arg_7_0)
	if var_0_3.rebirthCount < 12 then
		return 13 - var_0_3.rebirthCount
	else
		return 13
	end
end

function var_0_2.createRebirthDescSlider(arg_8_0)
	local var_8_0 = require("scenes.SliderLayer").new({
		size = CCSize(398, 140),
		point = ccp(20, 0),
		clipScaleX = Adapter.MinScale,
		clipScaleY = Adapter.MinScale,
		numberHandler = function()
			return arg_8_0:getRebirthDescShowCount()
		end,
		cellHandler = handler(arg_8_0, arg_8_0.newRebirthDescHandler),
		changedHandler = function(arg_10_0)
			for iter_10_0, iter_10_1 in ipairs(arg_8_0.previewButtonTable) do
				iter_10_1.rotateSprite:setVisible(iter_10_0 == arg_10_0)
			end

			local var_10_0 = -(arg_10_0 - 1) * 75
			local var_10_1 = arg_8_0.previewSrollView:getContentOffset()
			local var_10_2 = arg_8_0.previewSrollView:minContainerOffset()
			local var_10_3 = arg_8_0.previewSrollView:getViewSize()

			if var_10_0 < var_10_1.x - var_10_3.width then
				if var_10_0 < var_10_2.x then
					arg_8_0.previewSrollView:setContentOffset(var_10_2)
				else
					arg_8_0.previewSrollView:setContentOffset(ccp(var_10_0, var_10_1.y))
				end
			elseif var_10_0 > var_10_1.x then
				arg_8_0.previewSrollView:setContentOffset(ccp(var_10_0, var_10_1.y))
			end
		end,
		direction = SliderDirection.eHorizontal
	})

	arg_8_0.background:addChild(var_8_0)

	return var_8_0
end

function var_0_2.newRebirthDescHandler(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = var_0_3.rebirthCount + arg_11_2 - 1
	local var_11_1 = var_0_1.addRebirthDescHandler(var_11_0, var_0_3.heroId)

	var_11_1:setPosition(15, 128)
	arg_11_1:addChild(var_11_1)
end

function var_0_2.showRebirthDescAction(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_2.tag

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.previewButtonTable) do
		iter_12_1.rotateSprite:setVisible(iter_12_0 == var_12_0)
	end

	arg_12_0.descSliderLayer:reloadData(var_12_0)
end

function var_0_2.showRebirthMates(arg_13_0)
	local function var_13_0(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6)
		local var_14_0 = CCProgressTimer:create(CCSprite:create(arg_14_5 == true and "ui/team/team_034.png" or "ui/team/team_033.png"))
		local var_14_1 = 0

		if arg_14_6 then
			var_14_0 = CCProgressTimer:create(CCSprite:create(arg_14_5 == true and "ui/team/team_034.png" or "ui/team/team_033.png", CCRect(0, 15, 115, 116)))
			var_14_1 = -16
		end

		local var_14_2 = var_14_0:getContentSize()
		local var_14_3 = arg_14_2 <= arg_14_3 and 1 or arg_14_3 / arg_14_2

		var_14_0:setAnchorPoint(CCPoint(0.5, 0.5))
		var_14_0:setPosition(arg_14_4.x, arg_14_4.y + var_14_1)
		var_14_0:setType(kCCProgressTimerTypeRadial)
		var_14_0:setPercentage(var_14_3 * 100)
		arg_13_0.background:addChild(var_14_0, 5)

		local var_14_4 = display.newSprite("ui/team/team_041.png")

		var_14_4:align(display.BOTTOM_CENTER, var_14_2.width / 2, -8 - var_14_1 * 0.3)
		var_14_0:addChild(var_14_4)

		if ItemType.eMate == arg_14_0 then
			if var_14_3 == 1 then
				addLabelWithColorSize(var_14_0, arg_14_2, ccc3(238, 224, 191), 20, ccp(0.5, 0), ccp(var_14_2.width / 2, -10 - var_14_1 * 0.3))
			else
				addLabelWithColorSize(var_14_0, arg_14_2, ccc3(185, 0, 0), 20, ccp(0.5, 0), ccp(var_14_2.width / 2, -10 - var_14_1 * 0.3))
			end
		elseif var_14_3 == 1 then
			addLabelWithColorSize(var_14_0, arg_14_2 .. "/" .. arg_14_2, ccc3(238, 224, 191), 20, ccp(0.5, 0), ccp(var_14_2.width / 2, -10))
		else
			addLabelWithColorSize(var_14_0, arg_14_3 .. "/" .. arg_14_2, ccc3(185, 0, 0), 20, ccp(0.5, 0), ccp(var_14_2.width / 2, -10))
		end

		local var_14_5 = ui.newControlButton({
			normalImage = getItemHeaderImagePath(arg_14_0, arg_14_1),
			anchorPoint = CCPoint(0.5, 0.5),
			position = CCPoint(var_14_2.width / 2, var_14_2.height / 2 - var_14_1),
			clickAction = function()
				local var_15_0 = var_0_0.new({})
				local var_15_1 = CCNode:create()

				var_15_1:setContentSize(CCSize(160, 100))
				addLabelWithColorSize(var_15_1, getItemName(arg_14_0, arg_14_1), ccc3(253, 187, 47), 20, CCPoint(0.5, 0), CCPoint(80, 75))
				addLabelWithColorSize(var_15_1, string.lf("需求: %s", arg_14_2), ccc3(253, 187, 47), 20, CCPoint(0, 0), CCPoint(10, 40))
				addLabelWithColorSize(var_15_1, string.lf("拥有: %s", arg_14_3), ccc3(253, 187, 47), 20, CCPoint(0, 0), CCPoint(10, 5))
				var_15_0:addNode(var_15_1)
				var_15_0:show({
					parent = arg_13_0.background,
					x = arg_14_4.x,
					y = arg_14_4.y - 110,
					align = display.CENTER_BOTTOM
				})
			end
		})

		var_14_0:addChild(var_14_5)

		if arg_14_0 == ItemType.eSoul then
			local var_14_6 = display.newSprite("ui/common/common_soul_small.png")

			var_14_6:align(display.BOTTOM_LEFT, -7, 6)
			var_14_5:addChild(var_14_6)
		end
	end

	local var_13_1 = getHeroCurrentRebirthCountAttrs(var_0_3.heroId, var_0_3.rebirthCount + 1)
	local var_13_2 = var_13_1.soulId and var_13_1.soulCount or 0
	local var_13_3 = var_13_1.soulId and Player:getItemCount(ItemType.eSoul, var_13_1.soulId) or 0
	local var_13_4 = var_13_1 and var_13_1.mateCount or 0
	local var_13_5 = var_13_1 and Player:getItemCount(ItemType.eMate, var_13_1.mateId) or 0
	local var_13_6 = Player:getItemCount(ItemType.eMate, 200178)

	var_13_0(ItemType.eMate, var_13_1.mateId, var_13_4, var_13_5, CCPoint(79, 315), false)

	local var_13_7 = CCPoint(arg_13_0.back_size.width - 84, 315)

	if var_13_2 > 0 then
		var_13_0(ItemType.eSoul, var_13_1.soulId, var_13_2, var_13_3, CCPoint(arg_13_0.back_size.width - 84, 315), true)
	else
		local var_13_8 = display.newSprite("ui/team/team_077.png", var_13_7.x, var_13_7.y + 1)

		arg_13_0.background:addChild(var_13_8)
	end

	local var_13_9 = CCSprite:create("ui/team/team_102.png", CCRect(0, 24, 134, 134))

	var_13_9:setAnchorPoint(CCPoint(0.5, 0.5))
	var_13_9:setPosition(arg_13_0.back_size.width * 0.5, 440)
	arg_13_0.background:addChild(var_13_9)

	if var_13_3 < var_13_2 then
		var_13_0(ItemType.eMate, 200178, var_13_2 - var_13_3, var_13_6, CCPoint(arg_13_0.back_size.width * 0.5, 465), false, true)
	else
		local var_13_10 = display.newSprite("ui/team/team_077.png", arg_13_0.back_size.width * 0.5, 465)

		arg_13_0.background:addChild(var_13_10)
	end

	if var_13_2 <= var_13_3 + var_13_6 and var_13_4 <= var_13_5 then
		arg_13_0.canBeRebirth = true

		if var_13_3 < var_13_2 then
			arg_13_0.isNeedGeneralSoul = true
			arg_13_0.isNeedCount = var_13_2 - var_13_3
		else
			arg_13_0.isNeedGeneralSoul = false
			arg_13_0.isNeedCount = nil
		end
	end

	local function var_13_11()
		print("dlgBreakThroughLayerCallback")

		local var_16_0 = Player:getTroMaxStep()

		local function var_16_1()
			GuideLayer:showNewbieGuideLayer(nil, arg_13_0.bgSprite, 190, function()
				game.enterHomeScene({
					showGuideArrow = true
				})

				return true
			end)
		end

		if Player:getTroMaxStep() == NSStep.ZhanYi6Reward then
			GuideLayer:saveTrioMaxStep(NSStep.ZhuJiangJinjie, function()
				Player:setTroMaxStep(NSStep.TempStepID)
				GuideLayer:showNewbieGuideLayer(nil, arg_13_0.bgSprite, 180, function()
					local var_20_0 = require("scenes.team.HeroRebirthPreviewLayer").new({
						heroId = var_0_3.heroId,
						curIndex = arg_13_0.curIndex,
						closeCallback = var_16_1
					})

					CCDirector:sharedDirector():getRunningScene():addChild(var_20_0)
				end, nil, true)
			end)
		end
	end

	if var_0_5 == true then
		var_0_5 = false

		showFlashText(arg_13_0.background, string.lf("进阶成功！"), ccc3(0, 255, 0), CCPoint(arg_13_0.back_size.width / 2, arg_13_0.back_size.height / 2))

		local var_13_12 = var_0_1.new({
			oldHero = var_0_6,
			newHero = var_0_3,
			closeCallback = var_13_11
		})

		CCDirector:sharedDirector():getRunningScene():addChild(var_13_12)
	end
end

function var_0_2.showRebirthButton(arg_21_0)
	local function var_21_0(arg_22_0, arg_22_1)
		local var_22_0 = figure.getRebirthNeedLevel(var_0_3.rebirthCount + 1)

		if BaseHeros[var_0_3.heroId].rating == 7 then
			if BaseHeros[var_0_3.heroId].quality == QualityType.eOrange and var_0_3.rebirthCount >= 26 and var_0_3.rebirthCount < 30 then
				var_22_0 = 100
			end
		elseif BaseHeros[var_0_3.heroId].rating == 8 and BaseHeros[var_0_3.heroId].quality == QualityType.eOrange and var_0_3.rebirthCount >= 26 then
			var_22_0 = 100
		end

		if var_22_0 > var_0_3.level then
			if BaseHeros[var_0_3.heroId].rating == 7 and var_0_3.rebirthCount == 30 then
				ui.showMessageBox({
					text = string.lf("该战将进阶已达上限, 无法进阶, 橙7战将进阶上限30!")
				})
			else
				ui.showMessageBox({
					text = string.lf("该战将等级不足, 无法进阶, 需要达到%d级进阶!", var_22_0)
				})
			end
		elseif arg_21_0.isNeedGeneralSoul == true and arg_21_0.isNeedCount ~= nil then
			ui.showMessageBox({
				text = string.lf("魂魄不足,是否消耗%d个万能魂魄进阶", arg_21_0.isNeedCount),
				title1 = string.lf("取消"),
				title2 = string.lf("确定"),
				action2 = function()
					arg_21_0.heroRebirthRequest:request(var_0_3.heroId)

					arg_21_0.isNeedGeneralSoul = false
					arg_21_0.isNeedCount = nil
				end
			})
		else
			arg_21_0.heroRebirthRequest:request(var_0_3.heroId)

			arg_21_0.isNeedCount = nil
		end
	end

	local var_21_1 = CCPoint(arg_21_0.back_size.width / 2, 323)
	local var_21_2 = ui.newControlButton({
		highlightedImage = "ui/team/team_042_2.png",
		disabledImage = "ui/team/team_042_1.png",
		normalImage = "ui/team/team_042_2.png",
		position = var_21_1,
		clickAction = var_21_0
	})

	var_21_2:setEnabled(arg_21_0.canBeRebirth)
	arg_21_0.background:addChild(var_21_2)

	if arg_21_0.canBeRebirth == true then
		local var_21_3 = display.newSprite("ui/team/team_042.png")

		var_21_3:setAnchorPoint(CCPoint(0.5, 0.5))
		var_21_3:setPosition(var_21_1)
		arg_21_0.background:addChild(var_21_3, -1)

		local var_21_4 = CCArray:create()

		var_21_4:addObject(CCFadeIn:create(0.5))
		var_21_4:addObject(CCFadeOut:create(0.5))
		var_21_2:runAction(CCRepeatForever:create(CCSequence:create(var_21_4)))
	end

	local var_21_5 = ui.newControlButton({
		normalImage = "ui/team/team_125.png",
		position = CCPoint(arg_21_0.back_size.width - 70, 458),
		clickAction = function(arg_24_0, arg_24_1)
			local var_24_0 = require("scenes.team.HeroRebirthPreviewLayer").new({
				heroId = var_0_3.heroId,
				curIndex = arg_21_0.curIndex,
				isFromTeam = arg_21_0.curIndex and arg_21_0.curIndex > 0
			})

			CCDirector:sharedDirector():getRunningScene():addChild(var_24_0)
		end
	})

	arg_21_0.background:addChild(var_21_5)
end

function var_0_2.showNewbieGuideLayer(arg_25_0, arg_25_1)
	if Player:getTroMaxStep() == NSStep.ZhanYi6Reward then
		GuideLayer:showNewbieGuideLayer(arg_25_1, arg_25_0.bgSprite, 18, function()
			arg_25_0.heroRebirthRequest:request(var_0_3.heroId)

			return true
		end, nil, true)
	end
end

return var_0_2
