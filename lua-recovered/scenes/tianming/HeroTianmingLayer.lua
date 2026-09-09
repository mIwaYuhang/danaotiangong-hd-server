require("data.equip")
require("scenes.team.TransferEffectScene")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("HeroTianmingLayer", function()
	return display.newLayer()
end)
local var_0_2 = {
	tagPageTianmingEnhance = 1,
	tagPageTianmingPackage = 2
}

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0.team = arg_2_1.team or Player.team
	arg_2_0.curIndex = arg_2_1.index
	arg_2_0.dataType = arg_2_1.dataType
	arg_2_0.tianmingScene = arg_2_1.scene

	arg_2_0:createNetworkRequest()
	arg_2_0:createHeroAttrUI()
	arg_2_0:changeHeroAttrUI(arg_2_0.curIndex)

	local var_2_0 = arg_2_0.team.groupList[arg_2_0.curIndex]

	arg_2_0:showTypeLayer(var_0_2.tagPageTianmingPackage, {
		heroItem = var_2_0
	})
end

function var_0_1.getSlotPosition(arg_3_0, arg_3_1)
	local var_3_0 = 165 + (arg_3_1 - 1) % 2 * 285
	local var_3_1 = 440 - math.floor((arg_3_1 - 1) / 2) * 103

	return var_3_0, var_3_1
end

function var_0_1.sliderLayerChanged(arg_4_0, arg_4_1)
	arg_4_0.curIndex = arg_4_1

	arg_4_0:changeHeroAttrUI(arg_4_1)

	if arg_4_0.tianmingScene:getTableViewScrollIndex() ~= arg_4_1 then
		arg_4_0.tianmingScene:tableViewScrollToIndex(arg_4_1)
	end

	local var_4_0 = arg_4_0.team.groupList[arg_4_0.curIndex]
	local var_4_1 = var_4_0 and var_4_0.heroId > 0

	local function var_4_2(arg_5_0)
		local var_5_0 = arg_4_0:getTianmingInfoByIndex(arg_4_0.curIndex, arg_4_0.curChoosedTMIndex)

		if var_5_0 ~= nil then
			arg_4_0:showTypeLayer(var_0_2.tagPageTianmingEnhance, {
				tianmingItem = var_5_0
			})
		else
			arg_4_0:showTypeLayer(var_0_2.tagPageTianmingPackage, {})
		end
	end

	if arg_4_0.curShowLayerTag == var_0_2.tagPageTianmingEnhance then
		var_4_2(var_4_1)
	elseif arg_4_0.curShowLayerTag == var_0_2.tagPageTianmingPackage then
		arg_4_0:showTypeLayer(var_0_2.tagPageTianmingPackage, {})
	end

	local var_4_3 = var_4_0 and var_4_0.heroId > 0

	arg_4_0:setTianmingButtonsEnabled(var_4_3)
end

function var_0_1.createHeroAttrUI(arg_6_0)
	arg_6_0.heroAttrNode = CCNode:create()

	arg_6_0.heroAttrNode:setPosition(ccp(174, 513))
	arg_6_0:addChild(arg_6_0.heroAttrNode)

	local var_6_0 = display.newSprite(getProfessionIconImageName(HeroProfession.eNone), 67, 35)

	arg_6_0.heroAttrNode:addChild(var_6_0)

	arg_6_0.heroAttrNode.professionImage = var_6_0
	arg_6_0.heroAttrNode.nameLabel = ui.newTTFLabel({
		text = "",
		y = 35,
		x = 77,
		font = _FONT_PANGWA,
		size = Adapter.FontSize(23),
		align = ui.TEXT_ALIGN_LEFT
	})

	arg_6_0.heroAttrNode.nameLabel:setAnchorPoint(ccp(0, 0.5))
	arg_6_0.heroAttrNode:addChild(arg_6_0.heroAttrNode.nameLabel)
	Adapter.NodeAbsScale(arg_6_0.heroAttrNode.nameLabel)

	local var_6_1 = {
		totalExp = 1,
		curExp = 1,
		level = 0
	}

	arg_6_0.heroProgressBar = createHeroProgressBar(var_6_1)

	arg_6_0.heroProgressBar:setPosition(ccp(-28, 10))
	arg_6_0.heroAttrNode:addChild(arg_6_0.heroProgressBar)

	arg_6_0.battlePowerLabel = ui.newTTFLabel({
		text = "0",
		y = 153,
		x = 301,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(24),
		align = ui.TEXT_ALIGN_CENTER,
		color = ccc3(255, 137, 0)
	})

	arg_6_0:addChild(arg_6_0.battlePowerLabel)
	arg_6_0:createHeroAttrSliderLayer()

	arg_6_0.curChoosedTMIndex = 0
end

function var_0_1.setTianmingButtonsChoose(arg_7_0, arg_7_1)
	arg_7_0.curChoosedTMIndex = arg_7_1

	if arg_7_0.tmChoosedSprites then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0.tmChoosedSprites) do
			iter_7_1:setVisible(iter_7_0 == arg_7_1)
		end
	end
end

function var_0_1.setTianmingButtonsEnabled(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.tianmingHeaderTable) do
		iter_8_1.headerButton:setEnabled(arg_8_1)
	end
end

function var_0_1.getTianmingInfoByIndex(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 == 0 then
		return nil
	end

	local var_9_0 = arg_9_0.team.groupList[arg_9_1]
	local var_9_1
	local var_9_2

	if var_9_0.destinyList and var_9_0.destinyList[arg_9_2].destiny then
		var_9_1 = var_9_0.destinyList[arg_9_2].destiny
	end

	if var_9_0.destinyList then
		var_9_2 = var_9_0.destinyList[arg_9_2]
	end

	return var_9_1, var_9_2
end

function var_0_1.tianmingButtonTouchUpInsideAction(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = tolua.cast(arg_10_2, "CCControlButton")

	if var_10_0:getTag() ~= arg_10_0.curChoosedTMIndex then
		local var_10_1 = var_10_0:getTag()
		local var_10_2, var_10_3 = arg_10_0:getTianmingInfoByIndex(arg_10_0.curIndex, var_10_1)
		local var_10_4 = var_10_3.state

		if var_10_4 == TianmingSlotStatus.eSlotLocked then
			showFlashNotice(string.lf("未解锁, 等级不足"))

			return
		elseif var_10_4 == TianmingSlotStatus.eSlotCantuse then
			showFlashNotice(string.lf("主将品质太低，不能上阵"))

			return
		end

		if arg_10_0._isChangeTianming == true then
			arg_10_0._isChangeTianming = false

			arg_10_0:changeHeroTianming(arg_10_0.curIndex, var_10_1, arg_10_0._changeTianmingUserId)
		else
			local var_10_5, var_10_6 = var_10_0:getParent():getPosition()

			if arg_10_0.dataType == TeamDataType.eTeamPlayer then
				if var_10_2 then
					arg_10_0:showTypeLayer(var_0_2.tagPageTianmingEnhance, {
						tianmingItem = var_10_2
					})
					arg_10_0:setTianmingButtonsChoose(var_10_1)
				else
					arg_10_0:showTypeLayer(var_0_2.tagPageTianmingPackage, {})
				end
			end
		end
	end
end

function var_0_1.changeHeroAttrUI(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.team.groupList[arg_11_1]

	if var_11_0 and var_11_0.heroId > 0 then
		local var_11_1 = BaseHeros[var_11_0.heroId]

		arg_11_0.heroAttrNode:setVisible(true)

		if var_11_0.rebirthCount > 0 then
			arg_11_0.heroAttrNode.nameLabel:setString(string.format("%s+%d", var_11_1.name, var_11_0.rebirthCount))
		else
			arg_11_0.heroAttrNode.nameLabel:setString(string.format("%s", var_11_1.name))
		end

		arg_11_0.heroAttrNode.nameLabel:setColor(getQualityColor(var_11_1.quality))

		local var_11_2 = CCTextureCache:sharedTextureCache():addImage(getProfessionIconImageName(var_11_1.profession))

		arg_11_0.heroAttrNode.professionImage:setTexture(var_11_2)
		arg_11_0.heroProgressBar.levelNode.numLabel:setString(tostring(var_11_0.level))
		arg_11_0.heroProgressBar.progressBar:setProgressValue(1, var_11_0.curExp, var_11_0.totalExp)
		arg_11_0.battlePowerLabel:setString(string.lf("#FFFF98主将战力 #9EFFFD%d", var_11_0.battlePower))
	else
		arg_11_0.heroAttrNode:setVisible(false)
		arg_11_0.battlePowerLabel:setString(string.lf("#FFFF98主将战力 #9EFFFD%d", 0))
	end

	arg_11_0.heroAttrLayer:reloadData()

	arg_11_0.tianmingHeaderTable = arg_11_0.tianmingHeaderTable or {}

	for iter_11_0 = 1, table.nums(arg_11_0.tianmingHeaderTable) do
		arg_11_0:removeChild(arg_11_0.tianmingHeaderTable[iter_11_0])
	end

	arg_11_0.tianmingHeaderTable = {}

	for iter_11_1 = 1, 6 do
		local var_11_3, var_11_4 = arg_11_0:getSlotPosition(iter_11_1)
		local var_11_5, var_11_6 = arg_11_0:getTianmingInfoByIndex(arg_11_1, iter_11_1)
		local var_11_7 = var_11_5 and var_11_5.destinyID or 0
		local var_11_8 = var_11_5 and var_11_5.level or 0
		local var_11_9 = {
			type = ItemType.eTianMing,
			itemId = var_11_7,
			level = var_11_8,
			clickAction = handler(arg_11_0, arg_11_0.tianmingButtonTouchUpInsideAction)
		}
		local var_11_10 = figure.createHeader(var_11_9)

		var_11_10:setPosition(var_11_3, var_11_4)
		var_11_10.headerButton:setTag(iter_11_1)
		arg_11_0:addChild(var_11_10)

		arg_11_0.tianmingHeaderTable[iter_11_1] = var_11_10

		if var_11_6 then
			local var_11_11 = var_11_6.state

			if var_11_11 == TianmingSlotStatus.eSlotLocked then
				local var_11_12 = TianMingUnlockLevel[iter_11_1]
				local var_11_13 = string.lf("%d级解锁", var_11_12)
				local var_11_14 = display.newSprite("ui/team/team_106.png", 43, 43)

				var_11_10.headerButton:addChild(var_11_14)
				addLabelWithColorSize(var_11_10.headerButton, var_11_13, ccc3(250, 0, 0), 16, ccp(0.5, 0.5), ccp(43, 43))
			elseif var_11_11 == TianmingSlotStatus.eSlotCantuse then
				local var_11_15 = display.newSprite("ui/tianming/tianming_024.png", 43, 43)

				var_11_10.headerButton:addChild(var_11_15)
			end
		end
	end
end

function var_0_1.createHeroAttrSliderLayer(arg_12_0)
	local function var_12_0(arg_13_0, arg_13_1)
		local var_13_0 = arg_12_0.team.groupList[arg_12_0.curIndex]

		if var_13_0 and var_13_0.heroId > 0 then
			local var_13_1 = {}
			local var_13_2 = {
				{
					x = 40,
					y = 65
				},
				{
					x = 200,
					y = 65
				},
				{
					x = 40,
					y = 40
				},
				{
					x = 200,
					y = 40
				},
				{
					x = 40,
					y = 15
				},
				{
					x = 200,
					y = 15
				}
			}

			if arg_13_1 == 1 then
				var_13_1[1] = string.lf("血量 %d", var_13_0.health)
				var_13_1[2] = string.lf("速度 %d", var_13_0.speed)
				var_13_1[3] = string.lf("普攻 %d", var_13_0.normalAttack)
				var_13_1[4] = string.lf("法攻 %d", var_13_0.skillAttack)
				var_13_1[5] = string.lf("普防 %d", var_13_0.normalDefense)
				var_13_1[6] = string.lf("法防 %d", var_13_0.skillDefense)
			elseif arg_13_1 == 2 then
				var_13_1[1] = string.lf("暴击 %d", var_13_0.baoji)
				var_13_1[2] = string.lf("韧性 %d", var_13_0.renxing)
				var_13_1[3] = string.lf("命中 %d", var_13_0.mingzhong)
				var_13_1[4] = string.lf("闪避 %d", var_13_0.shanbi)
				var_13_1[5] = string.lf("破击 %d", var_13_0.poji)
				var_13_1[6] = string.lf("格挡 %d", var_13_0.gedang)
			end

			for iter_13_0 = 1, table.getn(var_13_1) do
				local var_13_3 = ui.newTTFLabel({
					text = "",
					font = _FONT_DEFAULT,
					size = Adapter.FontSize(20),
					color = ccc3(233, 152, 90),
					align = ui.TEXT_ALIGN_LEFT,
					x = var_13_2[iter_13_0].x + 22,
					y = var_13_2[iter_13_0].y + 9
				})

				var_13_3:setString(var_13_1[iter_13_0])
				var_13_3:setAnchorPoint(ccp(0, 0.5))
				arg_13_0:addChild(var_13_3)
				Adapter.NodeAbsScale(var_13_3)
			end

			if arg_13_1 == 2 then
				local var_13_4 = display.newSprite("ui/team/team_087.png", 20, 45)

				var_13_4:setFlipX(true)
				arg_13_0:addChild(var_13_4)
			end

			if arg_13_1 == 1 then
				local var_13_5 = display.newSprite("ui/team/team_087.png", 355, 45)

				arg_13_0:addChild(var_13_5)

				if arg_12_0.dataType == TeamDataType.eTeamPlayer then
					local var_13_6 = ui.newControlButton({
						normalImage = "ui/team/team_098.png",
						clickAction = function(arg_14_0, arg_14_1)
							local var_14_0 = arg_12_0.team.groupList[arg_12_0.curIndex]

							game.enterChangeFigureScene({
								returnTianmingScene = true,
								heroIndex = arg_12_0.curIndex,
								heroInfo = var_14_0
							})
						end
					})

					var_13_6:setPosition(25, 50)
					arg_13_0:addChild(var_13_6)
				end
			end
		end
	end

	arg_12_0.heroAttrLayer = require("scenes.SliderLayer").new({
		size = CCSize(375, 115),
		clipScaleX = Adapter.MinScale,
		clipScaleY = Adapter.MinScale,
		point = ccp(120, 25),
		numberHandler = function()
			return 2
		end,
		changedHandler = function(arg_16_0)
			return
		end,
		cellHandler = var_12_0,
		direction = SliderDirection.eHorizontal
	})

	arg_12_0:addChild(arg_12_0.heroAttrLayer)
end

function var_0_1.showTypeLayer(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.team.groupList[arg_17_0.curIndex]

	local function var_17_1(arg_18_0, arg_18_1)
		if arg_18_0 then
			arg_18_0:setVisible(arg_18_1)
		end
	end

	local function var_17_2(arg_19_0)
		arg_17_0.tianmingScene:reloadCurrentLayer()
	end

	arg_17_0.curShowLayerTag = arg_17_0.curShowLayerTag or var_0_2.tagPageTianmingPackage

	if arg_17_1 == var_0_2.tagPageTianmingEnhance then
		arg_17_2.curIndex = arg_17_0.curIndex

		local function var_17_3(arg_20_0)
			arg_17_0.heroUnloadTianmingRequest:request(arg_17_0.curIndex, arg_20_0)
		end

		if arg_17_0.tianmingEnhanceLayer == nil then
			function arg_17_2.showTianmingPackageButtonCallback()
				arg_17_0:showTypeLayer(var_0_2.tagPageTianmingPackage, {})
				arg_17_0.tianmingPackageLayer:reloadLayer({})
			end

			arg_17_2.callback = var_17_2
			arg_17_2.unloadTianming = var_17_3
			arg_17_2.team = arg_17_0.team
			arg_17_0.tianmingEnhanceLayer = require("scenes.tianming.TianmingUpgradeLayer").new(arg_17_2)

			arg_17_0:addChild(arg_17_0.tianmingEnhanceLayer)
		else
			arg_17_0.tianmingEnhanceLayer:refreshHeroItem(arg_17_2)
		end

		var_17_1(arg_17_0.tianmingEnhanceLayer, false)
		var_17_1(arg_17_0.tianmingEnhanceLayer, true)

		if arg_17_0.tianmingPackageLayer then
			arg_17_0.tianmingPackageLayer:dismissAnimation()
		end
	elseif arg_17_1 == var_0_2.tagPageTianmingPackage then
		local function var_17_4(arg_22_0, arg_22_1)
			local var_22_0 = arg_17_0.team.groupList[arg_17_0.curIndex]

			if var_22_0 and var_22_0.heroId > 0 then
				local var_22_1 = TianmingHelper:getEmptyTianmingSlot(arg_22_0, arg_17_0.curIndex)

				var_22_1 = arg_22_1 or var_22_1

				if var_22_1 == 0 then
					arg_17_0._changeTianmingUserId = arg_22_0.id

					arg_17_0:showChangeTianmingHintSprite(true)
				else
					arg_17_0:changeHeroTianming(arg_17_0.curIndex, var_22_1, arg_22_0.id)
				end
			else
				ui.showMessageBox({
					text = sting.lf("上仙，主将还未上阵哦.")
				})
			end
		end

		local function var_17_5()
			return arg_17_0.curIndex
		end

		local function var_17_6()
			if not arg_17_0.tianmingEnhanceLayer or arg_17_0.tianmingEnhanceLayer:isVisible() == false then
				local var_24_0 = arg_17_0.team.groupList[arg_17_0.curIndex]

				if arg_17_0.curChoosedTMIndex == 0 then
					arg_17_0.curChoosedTMIndex = 1
				end

				local var_24_1 = arg_17_0:getTianmingInfoByIndex(arg_17_0.curIndex, arg_17_0.curChoosedTMIndex)

				if var_24_1 then
					arg_17_0:showTypeLayer(var_0_2.tagPageTianmingEnhance, {
						tianmingItem = var_24_1
					})
				end
			end

			arg_17_0.tianmingPackageLayer = nil
		end

		local function var_17_7()
			var_17_1(arg_17_0.tianmingEnhanceLayer, false)
			var_17_1(arg_17_0.tianmingEnhanceLayer, false)
			arg_17_0.tianmingPackageLayer:reloadLayer({})
		end

		if arg_17_0.tianmingPackageLayer == nil then
			arg_17_0.tianmingPackageLayer = require("scenes.tianming.TianmingPackageLayer").new({
				team = arg_17_0.team,
				getCurrentIndex = var_17_5,
				refreshTianmingHandle = var_17_2,
				closeCallback = var_17_6,
				appearCallback = var_17_7,
				tianmingScene = arg_17_0.tianmingScene,
				callShowChangeTianmingHintSprite = var_17_4
			})

			arg_17_0:addChild(arg_17_0.tianmingPackageLayer, 77)
		else
			arg_17_0.tianmingPackageLayer:reloadLayer({})
		end

		arg_17_0:setTianmingButtonsChoose(0)
	end

	arg_17_0.curShowLayerTag = arg_17_1
end

function var_0_1.createNetworkRequest(arg_26_0)
	local function var_26_0()
		arg_26_0.tianmingScene:reloadCurrentLayer()

		if tianmingPackageLayer then
			arg_26_0.tianmingPackageLayer:reloadLayer({})
		end

		if arg_26_0.tmpEffectHeader ~= nil then
			arg_26_0.tmpEffectHeader:removeFromParentAndCleanup(true)

			arg_26_0.tmpEffectHeader = nil
		end
	end

	local function var_26_1(arg_28_0)
		arg_26_0.tianmingScene:reloadCurrentLayer()

		if arg_26_0.tmpEffectHeader ~= nil then
			arg_26_0.tmpEffectHeader:removeFromParentAndCleanup(true)

			arg_26_0.tmpEffectHeader = nil
		end
	end

	arg_26_0.heroChangeTianmingRequest = TianmingChangeRequest:new()

	arg_26_0.heroChangeTianmingRequest:setResponseNormalHandler(var_26_0)
	arg_26_0.heroChangeTianmingRequest:setResponseExceptionHandler(var_26_1)

	local function var_26_2(arg_29_0)
		return
	end

	arg_26_0.heroUnloadTianmingRequest = DestinyUnloadingRequest:new()

	arg_26_0.heroUnloadTianmingRequest:setResponseNormalHandler(var_26_0)
	arg_26_0.heroUnloadTianmingRequest:setResponseExceptionHandler(var_26_2)
end

function var_0_1.changeHeroTianming(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	arg_30_0:showChangeTianmingHintSprite(false)

	local function var_30_0()
		arg_30_0.heroChangeTianmingRequest:request(arg_30_1, arg_30_2, arg_30_3)
	end

	arg_30_0:playHeroHeaderFlyEffect(arg_30_2, var_30_0)
end

function var_0_1.showChangeTianmingHintSprite(arg_32_0, arg_32_1)
	for iter_32_0, iter_32_1 in ipairs(arg_32_0.tianmingHeaderTable) do
		if arg_32_1 == true then
			arg_32_0._isChangeTianming = true

			arg_32_0:showTouchFiltterLayer()
		elseif arg_32_0._touchLayer ~= nil then
			arg_32_0._touchLayer:removeFromParentAndCleanup(true)

			arg_32_0._touchLayer = nil
		end
	end
end

function var_0_1.showTouchFiltterLayer(arg_33_0)
	if arg_33_0._touchLayer ~= nil then
		return
	end

	arg_33_0._touchLayer = CCLayerColor:create(ccc4(0, 0, 0, 1))

	arg_33_0._touchLayer:setColor(ccc3(0, 0, 0))
	arg_33_0._touchLayer:setOpacity(170)

	local function var_33_0(arg_34_0, arg_34_1, arg_34_2)
		if arg_34_0 == "began" then
			return true
		elseif arg_34_0 == "moved" then
			-- block empty
		elseif arg_34_0 ~= "ended" and arg_34_0 == "cancelled" then
			-- block empty
		end
	end

	arg_33_0._touchLayer:addTouchEventListener(var_33_0, false, 1, true)
	arg_33_0._touchLayer:setTouchEnabled(true)
	CCDirector:sharedDirector():getRunningScene():addChild(arg_33_0._touchLayer)

	local function var_33_1()
		if arg_33_0._touchLayer ~= nil then
			arg_33_0._touchLayer:removeFromParentAndCleanup(true)

			arg_33_0._touchLayer = nil
		end

		arg_33_0._isChangeTianming = false

		arg_33_0.tianmingPackageLayer:reloadLayer({})
	end

	local var_33_2 = require("scenes.CommonBgLayer").new({
		closeButtonNormalImage = "ui/common/common_070.png",
		isHideBgSprite = true,
		returnAction = var_33_1,
		closeButtonPosition = ccp(480, 10000)
	})

	arg_33_0._touchLayer:addChild(var_33_2)

	local var_33_3 = var_33_2:getBackgroundSprite()
	local var_33_4 = createNumberWidthBgSprite("ui/common/common_064_2.png", string.lf("请选择要替换的天命"), 25, 0)
	local var_33_5 = ui.newControlButton({
		fontSize = 22,
		normalImage = "ui/common/common_073_1.png",
		position = ccp(172, 0),
		clickAction = var_33_1,
		text = string.lf("取消")
	})

	var_33_5:setPreferredSize(CCSize(100, 50))
	var_33_4:addChild(var_33_5)
	var_33_4:setPosition(ccp(300, 70))
	var_33_3:addChild(var_33_4)

	local var_33_6 = arg_33_0.team.groupList[arg_33_0.curIndex]

	for iter_33_0 = 1, 6 do
		local var_33_7, var_33_8 = arg_33_0:getSlotPosition(iter_33_0)
		local var_33_9 = arg_33_0:getTianmingInfoByIndex(arg_33_0.curIndex, iter_33_0)

		if var_33_9 then
			local var_33_10 = {
				type = ItemType.eTianMing,
				itemId = var_33_9.destinyID,
				level = var_33_9.level,
				clickAction = handler(arg_33_0, arg_33_0.tianmingButtonTouchUpInsideAction)
			}
			local var_33_11 = figure.createHeader(var_33_10)

			var_33_11:setPosition(var_33_7, var_33_8)
			var_33_11.headerButton:setTag(iter_33_0)

			local var_33_12 = CCArray:create()

			var_33_11:setRotation(3)
			var_33_12:addObject(CCRotateBy:create(0.09, -6))
			var_33_12:addObject(CCRotateBy:create(0.09, 6))
			var_33_11:runAction(CCRepeatForever:create(CCSequence:create(var_33_12)))
			var_33_3:addChild(var_33_11)
		end
	end

	GuideLayer:stepDone(TaskEntryType.eEntryBattleVicehero, 4)
	GuideLayer:showGuideLayer(nil, var_33_3, TaskEntryType.eEntryBattleVicehero, 5)
end

function var_0_1.playHeroHeaderFlyEffect(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0, var_36_1 = arg_36_0.tianmingPackageLayer:getCurTianmingHeaderButton()
	local var_36_2, var_36_3 = var_36_0:getPosition()
	local var_36_4, var_36_5 = arg_36_0:getSlotPosition(arg_36_1)
	local var_36_6 = arg_36_0.tianmingPackageLayer.tianmingsLayer:convertToWorldSpace(ccp(var_36_2, var_36_3))
	local var_36_7 = arg_36_0:convertToNodeSpace(var_36_6)

	var_36_0:setHeaderOpacity(140)

	local var_36_8 = var_36_1 and var_36_1.destinyID or 0
	local var_36_9 = var_36_1 and var_36_1.level or 0
	local var_36_10 = {
		type = ItemType.eTianMing,
		itemId = var_36_8,
		level = var_36_9
	}

	arg_36_0.tmpEffectHeader = figure.createHeader(var_36_10)

	arg_36_0.tmpEffectHeader:setPosition(var_36_7)
	arg_36_0:addChild(arg_36_0.tmpEffectHeader, 77)

	local function var_36_11()
		arg_36_2()
	end

	local var_36_12 = CCArray:create()

	var_36_12:addObject(CCEaseSineOut:create(CCMoveTo:create(0.5, ccp(var_36_4, var_36_5))))
	var_36_12:addObject(CCCallFunc:create(var_36_11))
	arg_36_0.tmpEffectHeader:runAction(CCSequence:create(var_36_12))
end

return var_0_1
