require("scenes.battle.HeroDragLayer")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = class("TianmingGuLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)
local var_0_2 = {}

for iter_0_0 = 0, 1 do
	for iter_0_1 = 0, 2 do
		if iter_0_1 == 1 then
			table.insert(var_0_2, ccp(440 - iter_0_0 * 220, 410 - iter_0_1 * 160))
		else
			table.insert(var_0_2, ccp(390 - iter_0_0 * 220, 410 - iter_0_1 * 160))
		end
	end
end

function orderScale_num(arg_2_0)
	return 1 - arg_2_0.y / (var_0_2[1].y + Adapter.AutoScaleY * 50) * 0.19999999999999996
end

function orderScale(arg_3_0, arg_3_1)
	local var_3_0 = orderScale_num(arg_3_1)

	if not arg_3_0.order_scale_order then
		arg_3_0.order_scale_order = arg_3_0:getScale()
	end

	arg_3_0:setScale(arg_3_0.order_scale_order * var_3_0)
end

function var_0_1.ctor(arg_4_0)
	arg_4_0:setColor(display.COLOR_BLACK)
	arg_4_0:setOpacity(120)

	local function var_4_0(arg_5_0, arg_5_1, arg_5_2)
		return true
	end

	arg_4_0:addTouchEventListener(var_4_0, false, 1, true)
	arg_4_0:setTouchEnabled(true)

	local var_4_1 = require("scenes.CommonBgLayer").new({
		closeButtonNormalImage = "ui/common/btn_closed.png",
		isHideBgSprite = true,
		returnAction = function()
			local var_6_0 = arg_4_0:getHeroTianmingGuPosString()

			if var_6_0 == arg_4_0.oldPosString then
				arg_4_0:removeFromParentAndCleanup(true)
			else
				arg_4_0.destinyChangeRequest:request(var_6_0)
			end

			GuideLayer:removeGuideLayer(display.getRunningScene(), TaskEntryType.eTianMingGu, 4)
			GuideLayer:removeGuideLayer(display.getRunningScene(), TaskEntryType.eTianMingGu, 5)
			GuideLayer:stepDone(TaskEntryType.eTianMingGu, 4)
			GuideLayer:stepDone(TaskEntryType.eTianMingGu, 5)
		end
	})

	arg_4_0:addChild(var_4_1)

	local var_4_2 = var_4_1:getBackgroundSprite()

	arg_4_0.bgSprite = display.newSprite("ui/tianming/tianming_036.png", 480, 311)

	var_4_2:addChild(arg_4_0.bgSprite)

	arg_4_0.rightBgSprite = display.newSprite("ui/tianming/tianming_035.png", 711, 280)

	arg_4_0.bgSprite:addChild(arg_4_0.rightBgSprite)
	arg_4_0:createNetworkRequest()

	arg_4_0.heroTianmingGuTable = {}
	arg_4_0.buttonList = {}

	arg_4_0:createBackGround()
	arg_4_0:showHeroFormation()
	arg_4_0:showDefaultTianmingGuInfo()
	arg_4_0:createTouchEventLayer()

	arg_4_0.curHeroIndex = 1
	arg_4_0.oldPosString = arg_4_0:getHeroTianmingGuPosString()
end

function var_0_1.showHeroFormation(arg_7_0)
	arg_7_0:createHero(Player.team.groupList, var_0_2)

	local var_7_0 = CCLabelTTF:create(string.lf("点击拖动天命蛊可以交换位置"), _FONT_DEFAULT, Adapter.FontSize(18))

	var_7_0:setPosition(250, 20)
	var_7_0:setColor(ccc3(237, 97, 22))
	arg_7_0.bgSprite:addChild(var_7_0)

	local var_7_1 = CCArray:create()

	var_7_1:addObject(CCFadeOut:create(1))
	var_7_1:addObject(CCFadeIn:create(1))
	var_7_0:runAction(CCRepeatForever:create(CCSequence:create(var_7_1)))
end

function var_0_1.viewHeroInfo(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = CCNode:create()

	var_8_0:setPosition(0, 330)
	arg_8_2:addChild(var_8_0)

	local var_8_1 = BaseHeros[arg_8_1.heroId]
	local var_8_2 = CCSprite:create(getProfessionIconImageName(var_8_1.profession))

	var_8_2:setScale(2.5)
	var_8_2:setPosition(-130, 40)
	var_8_0:addChild(var_8_2, 0)

	local var_8_3 = arg_8_1.rebirthCount
	local var_8_4

	if var_8_3 == 0 then
		var_8_4 = var_8_1.name
	else
		var_8_4 = var_8_1.name .. "+" .. var_8_3
	end

	local var_8_5 = 2
	local var_8_6 = ui.newTTFLabelWithOutline({
		text = var_8_4,
		font = _FONT_LISU,
		size = Adapter.FontSize(10) * var_8_5,
		align = ui.TEXT_ALIGN_LEFT
	})

	var_8_0:addChild(var_8_6)
	var_8_6:setPosition(0, 40)
	var_8_6:setColor(getQualityColor(var_8_1.quality))

	return var_8_0
end

function var_0_1.createHero(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {}

	table.foreach(arg_9_1, function(arg_10_0, arg_10_1)
		local var_10_0

		arg_9_0.heroTianmingGuTable[arg_10_0] = arg_10_1.haloLevel

		if arg_10_1 and arg_10_1.heroId > 0 then
			local var_10_1 = {
				isHero = true,
				isViewQuality = false,
				platTable = false,
				scale = 1,
				figId = arg_10_1.heroId
			}
			local var_10_2 = figure.createHero(var_10_1)

			var_10_2:setPosition(arg_9_2[arg_10_1.battleIx])

			var_10_2.heroId = var_10_1.figId
			var_10_2.idx = arg_10_1.battleIx
			var_10_2.heroIdx = arg_10_0

			arg_9_0.bgSprite:addChild(var_10_2, (arg_10_1.battleIx - 1) % 3)

			arg_9_0.buttonList[var_10_2.heroIdx] = var_10_2

			var_10_2:setScale(0.35)

			var_10_2.prename = arg_9_0:viewHeroInfo(arg_10_1, var_10_2)
			var_10_2.tmNode = arg_9_0:viewTianmingGuInfo(arg_10_1, var_10_2)

			if arg_10_1.equipList then
				local var_10_3
				local var_10_4

				for iter_10_0, iter_10_1 in pairs(arg_10_1.equipList) do
					if BaseEquips[iter_10_1.equipId].equipType == EquipType.eWeapon then
						var_10_3 = iter_10_1.equipId
						var_10_4 = iter_10_1.pinJie

						break
					end
				end

				var_10_2.viewParam = {
					figureNode = var_10_2,
					rebirthCount = arg_10_1.rebirthCount,
					equipId = var_10_3,
					heroId = arg_10_1.heroId,
					pinjie = var_10_4
				}

				figure.setupFigure(var_10_2.viewParam)
			else
				var_10_2.viewParam = {
					figureNode = var_10_2,
					rebirthCount = arg_10_1.rebirthCount,
					equipId = arg_10_1.weaponId,
					heroId = arg_10_1.heroId,
					pinjie = arg_10_1.pinjie
				}

				figure.setupFigure(var_10_2.viewParam)
			end

			var_9_0[arg_10_0] = var_10_2
		end
	end)

	local var_9_1 = false

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if arg_9_0.heroTianmingGuTable[iter_9_0] == 0 then
			local var_9_2, var_9_3 = var_0_0.getPosition(iter_9_1.tmNode.tmSprite, arg_9_0.bgSprite)
			local var_9_4 = var_9_3 + 30

			GuideLayer:showGuideLayer(display.getRunningScene(), arg_9_0.bgSprite, TaskEntryType.eTianMingGu, 4, ccp(var_9_2, var_9_4), true)

			var_9_1 = true

			break
		end
	end

	if not var_9_1 then
		GuideLayer:removeGuideLayer(display.getRunningScene(), TaskEntryType.eTianMingGu, 4)
	end
end

function var_0_1.createBackGround(arg_11_0)
	local var_11_0 = 1

	for iter_11_0 = 0, 1 do
		for iter_11_1 = 0, 2 do
			local var_11_1
			local var_11_2 = iter_11_0 ~= 0 and "ui/team/team_029.png" or "ui/team/team_029.png"
			local var_11_3 = CCSprite:create(var_11_2)

			var_11_3:setPosition(var_0_2[var_11_0])
			arg_11_0.bgSprite:addChild(var_11_3)

			var_11_0 = var_11_0 + 1
		end
	end
end

function var_0_1.showDefaultTianmingGuInfo(arg_12_0, arg_12_1)
	local var_12_0 = "ui/tianming/tianming_038.png"

	if arg_12_1 == nil then
		var_12_0 = "ui/tianming/tianming_035.png"
	end

	local var_12_1 = display.newSprite(var_12_0)

	arg_12_0.rightBgSprite:setTexture(var_12_1:getTexture())
	arg_12_0.rightBgSprite:removeAllChildrenWithCleanup(true)

	if arg_12_1 == nil then
		local var_12_2 = display.newSprite("uilocal/tianming/tianming_text_011.png", 183, 493)

		arg_12_0.rightBgSprite:addChild(var_12_2)

		local var_12_3 = addLabelWithColorSize(arg_12_0.rightBgSprite, string.lf("装备天命蛊可以削弱敌方阵容对应位置主将的技能效果。\n技能降低效果随天命蛊等级提升而提升。\n天命蛊效果仅对玩家生效。"), ccc3(247, 247, 247), 20, CCPoint(0.5, 1), ccp(183, 480))

		var_12_3:setHorizontalAlignment(ui.TEXT_ALIGN_LEFT)
		var_12_3:setDimensions(CCSize(330, 150))

		local var_12_4 = display.newSprite("uilocal/tianming/tianming_text_012.png", 183, 325)

		arg_12_0.rightBgSprite:addChild(var_12_4)

		local var_12_5 = display.newSprite("ui/tianming/tianming_034.png", 190, 181)

		arg_12_0.rightBgSprite:addChild(var_12_5)

		local var_12_6 = {
			ccp(71, 272),
			ccp(290, 272),
			ccp(183, 183),
			ccp(71, 104),
			ccp(290, 104)
		}

		table.foreach(var_12_6, function(arg_13_0, arg_13_1)
			local var_13_0 = display.newSprite("ui/tianming/tianming_022.png", arg_13_1.x, arg_13_1.y)

			arg_12_0.rightBgSprite:addChild(var_13_0)

			local var_13_1 = "ui/tianming/" .. BaseTianMingGus[arg_13_0].image
			local var_13_2 = display.newSprite(var_13_1, arg_13_1.x, arg_13_1.y)

			arg_12_0.rightBgSprite:addChild(var_13_2)

			local var_13_3 = string.lf("LV%d:降低%d%%", arg_13_0, BaseTianMingGus[arg_13_0].effectRatio * 100)

			addLabelWithColorSize(arg_12_0.rightBgSprite, var_13_3, ccc3(187, 157, 34), 20, CCPoint(0.5, 0.5), ccp(arg_13_1.x, arg_13_1.y - 55))
		end)
	else
		local var_12_7 = display.newSprite("uilocal/tianming/tianming_text_021.png", 183, 510)

		arg_12_0.rightBgSprite:addChild(var_12_7)

		local var_12_8 = arg_12_1 == 0 and 1 or arg_12_1
		local var_12_9 = BaseTianMingGus[var_12_8]
		local var_12_10 = arg_12_0:getTianmingGuHeader(arg_12_1)
		local var_12_11 = display.newSprite(var_12_10, 51, 458)

		arg_12_0.rightBgSprite:addChild(var_12_11)

		local var_12_12 = arg_12_1 == 0 and string.lf("未激活") or var_12_9.name .. "\n" .. var_12_9.desc
		local var_12_13 = addLabelWithColorSize(arg_12_0.rightBgSprite, var_12_12, ccc3(247, 247, 247), 19, CCPoint(0, 0.5), ccp(92, 454))

		var_12_13:setHorizontalAlignment(ui.TEXT_ALIGN_LEFT)
		var_12_13:setVerticalAlignment(ui.TEXT_ALIGN_CENTER)
		var_12_13:setDimensions(CCSize(260, 80))

		local var_12_14 = 400
		local var_12_15 = getTianmingAttrList(var_12_9)

		table.foreach(var_12_15, function(arg_14_0, arg_14_1)
			local var_14_0 = arg_14_0 - 1
			local var_14_1 = var_14_0 % 2 == 0 and 40 or 220
			local var_14_2 = arg_12_1 == 0 and 0 or var_12_9[arg_14_1.type]
			local var_14_3 = string.lf("%s: %d", arg_14_1.name, var_14_2)

			addLabelWithColorSize(arg_12_0.rightBgSprite, var_14_3, ccc3(187, 157, 34), 20, CCPoint(0, 0.5), ccp(var_14_1, var_12_14 - 30 * math.floor(var_14_0 / 2)))
		end)

		local var_12_16 = arg_12_1 == 0 and BaseTianMingGus[1] or BaseTianMingGus[arg_12_1 + 1] or BaseTianMingGus[arg_12_1]

		if arg_12_1 < 5 then
			local var_12_17 = display.newSprite("uilocal/tianming/tianming_text_022.png", 183, 310)

			arg_12_0.rightBgSprite:addChild(var_12_17)

			local var_12_18 = arg_12_0:getTianmingGuHeader(arg_12_1 + 1)
			local var_12_19 = display.newSprite(var_12_18, 51, 270)

			arg_12_0.rightBgSprite:addChild(var_12_19)

			local var_12_20 = addLabelWithColorSize(arg_12_0.rightBgSprite, var_12_16.name .. "\n" .. var_12_16.desc, ccc3(247, 247, 247), 19, CCPoint(0, 1), ccp(92, 295))

			var_12_20:setHorizontalAlignment(ui.TEXT_ALIGN_LEFT)
			var_12_20:setDimensions(CCSize(260, 80))

			local var_12_21 = 210
			local var_12_22 = getTianmingAttrList(var_12_16)

			table.foreach(var_12_22, function(arg_15_0, arg_15_1)
				local var_15_0 = arg_15_0 - 1
				local var_15_1 = var_15_0 % 2 == 0 and 40 or 220
				local var_15_2 = var_12_16[arg_15_1.type]
				local var_15_3 = string.lf("%s: #00FF00%d", arg_15_1.name, var_15_2)

				addLabelWithColorSize(arg_12_0.rightBgSprite, var_15_3, ccc3(187, 157, 34), 20, CCPoint(0, 0.5), ccp(var_15_1, var_12_21 - 30 * math.floor(var_15_0 / 2)))
			end)

			local var_12_23 = display.newScale9Sprite("ui/tianming/tianming_037.png", 177, 81)

			var_12_23:setPreferredSize(CCSizeMake(240, 29))
			arg_12_0.rightBgSprite:addChild(var_12_23)
			addLabelWithColorSize(var_12_23, string.lf("当前消耗:"), ccc3(250, 200, 80), 20, CCPoint(0, 1), ccp(15, 26))

			local var_12_24 = createItemCountNode({
				color = ccc3(175, 169, 107),
				type = ItemType.eTianMingFrag,
				value = var_12_16.needFragNum
			})

			var_12_24:setPosition(ccp(120, 16))
			var_12_24:setAnchorPoint(ccp(0, 0.5))
			var_12_23:addChild(var_12_24)
		else
			local var_12_25 = display.newSprite("uilocal/tianming/tianming_text_023.png", 183, 240)

			arg_12_0.rightBgSprite:addChild(var_12_25)
		end

		local var_12_26 = display.newScale9Sprite("ui/tianming/tianming_037.png", 177, 116)

		var_12_26:setPreferredSize(CCSizeMake(240, 29))
		arg_12_0.rightBgSprite:addChild(var_12_26)
		addLabelWithColorSize(var_12_26, string.lf("当前拥有:"), ccc3(250, 200, 80), 20, CCPoint(0, 1), ccp(15, 26))

		local var_12_27 = createItemCountNode({
			color = ccc3(175, 169, 107),
			type = ItemType.eTianMingFrag,
			value = Player.tianMingFrag
		})

		var_12_27:setPosition(ccp(120, 16))
		var_12_27:setAnchorPoint(ccp(0, 0.5))
		var_12_26:addChild(var_12_27)

		local var_12_28 = arg_12_1 == 0 and string.lf("激活") or string.lf("升级")

		local function var_12_29()
			GuideLayer:removeGuideLayer(display.getRunningScene(), TaskEntryType.eTianMingGu, 5)
			GuideLayer:stepDone(TaskEntryType.eTianMingGu, 5)

			if arg_12_1 >= 5 then
				showFlashNotice(string.lf("上仙，已经到达最高级。 不能%s", var_12_28))

				return
			end

			if Player.tianMingFrag >= var_12_16.needFragNum then
				local var_16_0 = arg_12_0.buttonList[arg_12_0.curHeroIndex].tmNode.heroIdx

				arg_12_0.tianmingGuShengjiRequest:request(var_16_0)
			else
				showFlashNotice(string.lf("上仙，天命碎片不足， 不能%s", var_12_28))
			end
		end

		local var_12_30 = ui.newControlButton({
			normalImage = "ui/common/common_115.png",
			clickAction = var_12_29,
			text = var_12_28
		})

		var_12_30:setScaleAsSprite(true)
		var_12_30:setPosition(ccp(183, 32))
		arg_12_0.rightBgSprite:addChild(var_12_30)
	end

	GuideLayer:showGuideLayer(display.getRunningScene(), arg_12_0.bgSprite, TaskEntryType.eTianMingGu, 5, nil, true)
end

function var_0_1.viewTianmingGuInfo(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0, var_17_1 = arg_17_2:getPosition()
	local var_17_2 = CCNode:create()

	var_17_2:setPosition(var_17_0 - 110, var_17_1 + 40)
	arg_17_0.bgSprite:addChild(var_17_2, 6)

	local var_17_3 = arg_17_1.haloLevel

	local function var_17_4()
		arg_17_0.curHeroIndex = arg_17_2.heroIdx

		local var_18_0 = arg_17_0.buttonList[arg_17_0.curHeroIndex].tmNode.heroIdx
		local var_18_1 = Player.team.groupList[var_18_0].haloLevel

		if var_18_1 == 0 then
			GuideLayer:stepDone(TaskEntryType.eTianMingGu, 4)
		end

		arg_17_0:showDefaultTianmingGuInfo(var_18_1)
	end

	local var_17_5 = "ui/tianming/tianming_039.png"

	if var_17_3 > 0 then
		var_17_5 = "ui/tianming/" .. BaseTianMingGus[var_17_3].image
	end

	local var_17_6 = 1
	local var_17_7 = arg_17_0:getQualityBgSprite(var_17_3)
	local var_17_8 = ui.newControlButton({
		normalImage = "ui/tianming/" .. var_17_7,
		clickAction = var_17_4,
		scaleX = var_17_6,
		scaleY = var_17_6
	})

	var_17_8:setScaleAsSprite(true)
	var_17_8:setPosition(var_17_0 - 110, var_17_1 + 40)

	var_17_2.button = var_17_8
	arg_17_2.button = var_17_8

	arg_17_0.bgSprite:addChild(var_17_8, 3)

	var_17_2.tmSprite = display.newSprite(var_17_5, 0, 20)
	var_17_2.heroIdx = arg_17_2.heroIdx

	var_17_2.tmSprite:setScale(var_17_6)
	var_17_2:addChild(var_17_2.tmSprite)

	function var_17_2.refresh()
		local var_19_0 = Player.team.groupList[arg_17_2.heroIdx].haloLevel
		local var_19_1 = "ui/common/common_136.png"

		if var_19_0 > 0 then
			var_19_1 = "ui/tianming/" .. BaseTianMingGus[var_19_0].image
		end

		var_17_2.tmSprite:removeFromParentAndCleanup(true)

		var_17_2.tmSprite = display.newSprite(var_19_1, 0, 20)

		var_17_2.tmSprite:setScale(var_17_6)
		var_17_2:addChild(var_17_2.tmSprite)
		arg_17_0:showDefaultTianmingGuInfo(var_19_0)
	end

	function var_17_2.setOpacity(arg_20_0, arg_20_1)
		arg_20_0.tmSprite:setOpacity(arg_20_1)
	end

	return var_17_2
end

function var_0_1.touchBeginEvent(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0._touchBeginPos = ccp(arg_21_1, arg_21_2)
	arg_21_0._touchEndPos = ccp(arg_21_1, arg_21_2)
	arg_21_0._isMoveMode = false

	local var_21_0 = 0
	local var_21_1 = 1000

	for iter_21_0, iter_21_1 in pairs(arg_21_0.buttonList) do
		local var_21_2, var_21_3 = iter_21_1.tmNode:getPosition()
		local var_21_4 = arg_21_0.bgSprite:convertToWorldSpace(ccp(var_21_2, var_21_3))
		local var_21_5, var_21_6 = var_21_4.x, var_21_4.y
		local var_21_7 = ccpDistance(ccp(arg_21_1, arg_21_2), ccp(var_21_5, var_21_6))

		if var_21_7 < var_21_1 then
			var_21_1 = var_21_7
			var_21_0 = iter_21_0
		end
	end

	arg_21_0.touchHeroIndex = var_21_0
	arg_21_0.lastTouchHeroIndex = var_21_0

	if var_21_1 <= 43 * Adapter.MinScale then
		local function var_21_8()
			if ccpDistance(arg_21_0._touchBeginPos, arg_21_0._touchEndPos) < 5 then
				arg_21_0._isMoveMode = true
				arg_21_0.tmgTouchHeaderButton = arg_21_0.buttonList[arg_21_0.touchHeroIndex].tmNode

				for iter_22_0, iter_22_1 in pairs(arg_21_0.buttonList) do
					local var_22_0 = arg_21_0.buttonList[iter_22_0].tmNode

					if iter_22_0 == arg_21_0.touchHeroIndex then
						var_22_0:getParent():reorderChild(var_22_0, 7)
					else
						var_22_0:getParent():reorderChild(var_22_0, 6)
					end
				end
			end
		end

		local var_21_9 = CCArray:create()

		var_21_9:addObject(CCDelayTime:create(0.03))
		var_21_9:addObject(CCCallFunc:create(var_21_8))

		arg_21_0.checkAction = CCSequence:create(var_21_9)

		arg_21_0:runAction(arg_21_0.checkAction)

		return true
	else
		if arg_21_0.rightBgSprite:convertToNodeSpace(ccp(arg_21_1, arg_21_2)).x < 0 then
			arg_21_0:showDefaultTianmingGuInfo()
		end

		return false
	end
end

function var_0_1.touchMoveEvent(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0._touchEndPos = ccp(arg_23_1, arg_23_2)

	if arg_23_0._isMoveMode == true then
		if arg_23_0.tmgTouchHeaderButton then
			local var_23_0 = arg_23_0.bgSprite:convertToNodeSpace(ccp(arg_23_1, arg_23_2))

			arg_23_0.tmgTouchHeaderButton:setPosition(var_23_0)
		end

		local var_23_1 = 0
		local var_23_2 = 1000

		for iter_23_0, iter_23_1 in pairs(arg_23_0.buttonList) do
			local var_23_3, var_23_4 = iter_23_1.tmNode:getPosition()
			local var_23_5 = arg_23_0.bgSprite:convertToWorldSpace(ccp(var_23_3, var_23_4))
			local var_23_6, var_23_7 = var_23_5.x, var_23_5.y
			local var_23_8 = ccpDistance(ccp(arg_23_1, arg_23_2), ccp(var_23_6, var_23_7))

			if arg_23_0.touchHeroIndex ~= iter_23_0 and var_23_8 < var_23_2 and var_23_8 < 90 then
				local var_23_9 = var_23_2

				var_23_1 = iter_23_0
			end
		end

		for iter_23_2, iter_23_3 in pairs(arg_23_0.buttonList) do
			iter_23_3.tmNode:setOpacity(255)
		end

		if var_23_1 ~= 0 then
			arg_23_0.buttonList[var_23_1].tmNode:setOpacity(180)

			arg_23_0.lastTouchHeroIndex = var_23_1
		end

		return
	end
end

function var_0_1.createTouchEventLayer(arg_24_0)
	local var_24_0 = display.newLayer()

	local function var_24_1(arg_25_0, arg_25_1, arg_25_2)
		if arg_25_0 == "began" then
			return arg_24_0:touchBeginEvent(arg_25_1, arg_25_2)
		elseif arg_25_0 == "moved" then
			arg_24_0:touchMoveEvent(arg_25_1, arg_25_2)
		elseif arg_25_0 == "ended" or arg_25_0 == "cancelled" then
			arg_24_0:stopAction(arg_24_0.checkAction)

			if arg_24_0._isMoveMode == false then
				return
			end

			for iter_25_0, iter_25_1 in pairs(arg_24_0.buttonList) do
				iter_25_1.tmNode:setOpacity(255)
			end

			if arg_24_0.lastTouchHeroIndex ~= arg_24_0.touchHeroIndex then
				arg_24_0.heroTianmingGuTable[arg_24_0.lastTouchHeroIndex], arg_24_0.heroTianmingGuTable[arg_24_0.touchHeroIndex] = arg_24_0.heroTianmingGuTable[arg_24_0.touchHeroIndex], arg_24_0.heroTianmingGuTable[arg_24_0.lastTouchHeroIndex]
				arg_24_0.buttonList[arg_24_0.lastTouchHeroIndex].tmNode, arg_24_0.buttonList[arg_24_0.touchHeroIndex].tmNode = arg_24_0.buttonList[arg_24_0.touchHeroIndex].tmNode, arg_24_0.buttonList[arg_24_0.lastTouchHeroIndex].tmNode
			end

			arg_24_0:restoreTianmingGuPosition()
		end
	end

	var_24_0:addTouchEventListener(var_24_1, false, 1, false)
	var_24_0:setTouchEnabled(true)
	arg_24_0:addChild(var_24_0)
end

function var_0_1.restoreTianmingGuPosition(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.buttonList) do
		local var_26_0, var_26_1 = iter_26_1:getPosition()
		local var_26_2, var_26_3 = var_26_0 - 110, var_26_1 + 40
		local var_26_4 = CCArray:create()

		var_26_4:addObject(CCMoveTo:create(0.2, ccp(var_26_2, var_26_3)))
		var_26_4:addObject(CCCallFunc:create(handler(arg_26_0, arg_26_0.refreshButtonSprite)))
		iter_26_1.tmNode:stopAllActions()
		iter_26_1.tmNode:runAction(CCSequence:create(var_26_4))
	end
end

function var_0_1.createNetworkRequest(arg_27_0)
	local function var_27_0()
		arg_27_0.buttonList[arg_27_0.curHeroIndex].tmNode:refresh()
		arg_27_0:refreshButtonSprite()

		local var_28_0 = arg_27_0.buttonList[arg_27_0.curHeroIndex].tmNode.heroIdx

		arg_27_0.heroTianmingGuTable[arg_27_0.curHeroIndex] = Player.team.groupList[var_28_0].haloLevel
	end

	local function var_27_1()
		arg_27_0:removeFromParentAndCleanup(true)
	end

	arg_27_0.tianmingGuShengjiRequest = DestinyHaloUpgradeRequest:new()

	arg_27_0.tianmingGuShengjiRequest:setResponseNormalHandler(var_27_0)
	arg_27_0.tianmingGuShengjiRequest:setResponseExceptionHandler(var_27_1)

	local function var_27_2()
		arg_27_0:removeFromParentAndCleanup(true)
	end

	local function var_27_3()
		arg_27_0:removeFromParentAndCleanup(true)
	end

	arg_27_0.destinyChangeRequest = DestinyChangeHaloRequest:new()

	arg_27_0.destinyChangeRequest:setResponseNormalHandler(var_27_2)
	arg_27_0.destinyChangeRequest:setResponseExceptionHandler(var_27_3)
end

function var_0_1.getHeroTianmingGuPosString(arg_32_0)
	local var_32_0 = ""

	for iter_32_0 = 1, 6 do
		local var_32_1 = string.lf("%d", arg_32_0.heroTianmingGuTable[iter_32_0] or "0")

		var_32_0 = var_32_0 .. var_32_1

		if iter_32_0 ~= 6 then
			var_32_0 = var_32_0 .. ","
		end
	end

	return var_32_0
end

function var_0_1.getQualityBgSprite(arg_33_0, arg_33_1)
	if arg_33_1 == 0 then
		arg_33_1 = 1
	end

	return ({
		"tianming_040.png",
		"tianming_041.png",
		"tianming_042.png",
		"tianming_043.png",
		"tianming_044.png"
	})[arg_33_1]
end

function var_0_1.refreshButtonSprite(arg_34_0)
	for iter_34_0, iter_34_1 in pairs(arg_34_0.buttonList) do
		local var_34_0 = iter_34_1.button
		local var_34_1 = iter_34_1.tmNode.heroIdx
		local var_34_2 = Player.team.groupList[var_34_1].haloLevel
		local var_34_3 = arg_34_0:getQualityBgSprite(var_34_2)

		var_34_0:setBackgroundSpriteForState(CCScale9Sprite:create("ui/tianming/" .. var_34_3), CCControlStateNormal)
		var_34_0:setBackgroundSpriteForState(CCScale9Sprite:create("ui/tianming/" .. var_34_3), CCControlStateHighlighted)
	end

	local var_34_4 = arg_34_0.buttonList[arg_34_0.curHeroIndex].tmNode.heroIdx
	local var_34_5 = Player.team.groupList[var_34_4].haloLevel

	arg_34_0:showDefaultTianmingGuInfo(var_34_5)
end

function var_0_1.getTianmingGuHeader(arg_35_0, arg_35_1)
	local var_35_0 = "ui/tianming/tianming_039.png"

	if arg_35_1 > 0 then
		var_35_0 = "ui/tianming/" .. BaseTianMingGus[arg_35_1].image
	end

	return var_35_0
end

return var_0_1
