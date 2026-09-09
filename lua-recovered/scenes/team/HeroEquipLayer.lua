require("data.equip")
require("scenes.team.TeamScene")
require("scenes.team.TransferEffectScene")

local var_0_0 = require("scenes.bag.EnhanceHeroLayer")
local var_0_1 = require("scenes.ToolLayer")
local var_0_2 = class("HeroEquipLayer", function()
	return display.newLayer()
end)
local var_0_3 = {
	tagPageEquipEnhance = 3,
	tagPageHeroEnhance = 1,
	tagPageEquipPackage = 2
}

function var_0_2.ctor(arg_2_0, arg_2_1)
	arg_2_0.team = arg_2_1.team or Player.team
	arg_2_0.partnerTeam = arg_2_1.partnerTeam or Player.partnerTeam
	arg_2_0.isShowRebirth = arg_2_1.isShowRebirth or false
	arg_2_0.curIndex = arg_2_1.index
	arg_2_0.dataType = arg_2_1.dataType
	arg_2_0.teamScene = arg_2_1.scene

	if arg_2_0.heroUnloadEquipRequest == nil then
		arg_2_0:createNetworkRequest()
	end

	arg_2_0:createHeroAttrUI()
	arg_2_0:changeHeroAttrUI(arg_2_0.curIndex)

	local var_2_0 = arg_2_0.team.groupList[arg_2_0.curIndex]

	arg_2_0:showTypeLayer(var_0_3.tagPageHeroEnhance, {
		heroItem = var_2_0
	})
end

function var_0_2.heroClicked(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0.team.groupList[arg_3_0.curIndex]

	if var_3_0 and var_3_0.heroId > 0 then
		local var_3_1 = {
			show = var_0_1.eShowTeamHero,
			id = var_3_0.heroId
		}

		if arg_3_0.dataType == TeamDataType.eTeamPlayer then
			function var_3_1.callback(arg_4_0, arg_4_1)
				if arg_4_0 then
					game.enterChangeFigureScene({
						heroIndex = arg_3_0.curIndex,
						heroInfo = var_3_0
					})
				else
					game.enterTransferEffectScene({
						changeType = TransferEffectType.eTeamInherit,
						heroIndex = arg_3_0.curIndex
					})
				end
			end

			arg_3_0:showTypeLayer(var_0_3.tagPageHeroEnhance, {
				heroItem = var_3_0
			})
		end

		local var_3_2 = var_0_1.createTips(var_3_1)
		local var_3_3 = arg_3_0.teamScene.bg_far_Sprite

		var_3_2:show({
			x = 390,
			y = 330,
			parent = var_3_3,
			align = display.LEFT_CENTER
		})

		return var_3_2
	end
end

function var_0_2.sliderLayerChanged(arg_5_0, arg_5_1)
	arg_5_0.curIndex = arg_5_1

	arg_5_0:changeHeroAttrUI(arg_5_1)

	if arg_5_0.teamScene:getTableViewScrollIndex() ~= arg_5_1 then
		arg_5_0.teamScene:tableViewScrollToIndex(arg_5_1)
	end

	local var_5_0 = arg_5_0.team.groupList[arg_5_0.curIndex]
	local var_5_1 = var_5_0 and var_5_0.heroId > 0

	local function var_5_2(arg_6_0)
		if arg_6_0 == false and arg_5_0.dataType == TeamDataType.eTeamPlayer then
			arg_5_0:showTypeLayer(var_0_3.tagPageEquipPackage, {
				equipType = EquipType.eWeapon
			})
		else
			arg_5_0:showTypeLayer(var_0_3.tagPageHeroEnhance, {
				heroItem = var_5_0
			})
		end
	end

	if arg_5_0.curShowLayerTag == var_0_3.tagPageHeroEnhance then
		var_5_2(var_5_1)
	elseif arg_5_0.curShowLayerTag == var_0_3.tagPageEquipEnhance then
		local var_5_3 = arg_5_0:getEquipInfoByIndex(arg_5_0.curIndex, arg_5_0.curChoosedEquipIndex)

		if var_5_3 then
			arg_5_0:showTypeLayer(arg_5_0.curShowLayerTag, {
				equipItem = var_5_3
			})
		else
			var_5_2(var_5_1)
		end
	elseif arg_5_0.curShowLayerTag == var_0_3.tagPageEquipPackage then
		local var_5_4 = EquipType.eWeapon

		if arg_5_0.equipPackageLayer then
			var_5_4 = arg_5_0.equipPackageLayer:getLastEquipedEquipType()
		end

		arg_5_0:showTypeLayer(var_0_3.tagPageEquipPackage, {
			equipType = var_5_4
		})
	end

	local var_5_5 = var_5_0 and var_5_0.heroId > 0

	arg_5_0:setEquipButtonsEnabled(var_5_5)
end

function var_0_2.createHeroAttrUI(arg_7_0)
	arg_7_0.heroAttrNode = CCNode:create()

	arg_7_0.heroAttrNode:setPosition(ccp(174, 513))
	arg_7_0:addChild(arg_7_0.heroAttrNode)

	local var_7_0 = display.newSprite(getProfessionIconImageName(HeroProfession.eNone), 67, 35)

	arg_7_0.heroAttrNode:addChild(var_7_0)

	arg_7_0.heroAttrNode.professionImage = var_7_0
	arg_7_0.heroAttrNode.nameLabel = ui.newTTFLabel({
		text = "xx",
		y = 35,
		x = 77,
		font = _FONT_PANGWA,
		size = Adapter.FontSize(23),
		align = ui.TEXT_ALIGN_LEFT
	})

	arg_7_0.heroAttrNode.nameLabel:setAnchorPoint(ccp(0, 0.5))
	arg_7_0.heroAttrNode:addChild(arg_7_0.heroAttrNode.nameLabel)
	Adapter.NodeAbsScale(arg_7_0.heroAttrNode.nameLabel)

	local var_7_1 = {
		totalExp = 1,
		curExp = 1,
		level = 0
	}

	if arg_7_0.dataType == TeamDataType.eTeamPlayer then
		function var_7_1.clickAction(arg_8_0, arg_8_1)
			local var_8_0 = arg_7_0.team.groupList[arg_7_0.curIndex]

			if var_8_0 and var_8_0.heroId > 0 then
				game.enterTransferEffectScene({
					changeType = TransferEffectType.eTeamInherit,
					heroIndex = arg_7_0.curIndex
				})
			end
		end
	end

	arg_7_0.heroProgressBar = createHeroProgressBar(var_7_1)

	arg_7_0.heroProgressBar:setPosition(ccp(-28, 10))
	arg_7_0.heroAttrNode:addChild(arg_7_0.heroProgressBar)

	arg_7_0.battlePowerLabel = ui.newTTFLabel({
		text = "00",
		y = 153,
		x = 301,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(24),
		align = ui.TEXT_ALIGN_CENTER,
		color = ccc3(255, 137, 0)
	})

	arg_7_0:addChild(arg_7_0.battlePowerLabel)
	arg_7_0:createHeroAttrSliderLayer()

	arg_7_0.curChoosedEquipIndex = 0
	arg_7_0.equipChoosedSprites = {}
end

function var_0_2.setEquipButtonsChoose(arg_9_0, arg_9_1)
	arg_9_0.curChoosedEquipIndex = arg_9_1

	if arg_9_0.equipChoosedSprites then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0.equipChoosedSprites) do
			iter_9_1:setVisible(iter_9_0 == arg_9_1)
		end
	end
end

function var_0_2.setEquipButtonsEnabled(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.equipHeaderTable) do
		iter_10_1.headerButton:setEnabled(arg_10_1)
	end
end

function var_0_2.getEquipInfoByIndex(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.team.groupList[arg_11_1]
	local var_11_1

	if var_11_0 and var_11_0.heroId > 0 then
		for iter_11_0, iter_11_1 in ipairs(var_11_0.equipList) do
			if BaseEquips[iter_11_1.equipId].equipType == arg_11_2 then
				var_11_1 = iter_11_1

				break
			end
		end
	end

	return var_11_1
end

function var_0_2.changeHeroAttrUI(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.team.groupList[arg_12_1]

	if var_12_0 and var_12_0.heroId > 0 then
		local var_12_1 = BaseHeros[var_12_0.heroId]

		arg_12_0.heroAttrNode:setVisible(true)

		if var_12_0.rebirthCount > 0 then
			arg_12_0.heroAttrNode.nameLabel:setString(string.format("%s+%d", var_12_1.name, var_12_0.rebirthCount))
		else
			arg_12_0.heroAttrNode.nameLabel:setString(string.format("%s", var_12_1.name))
		end

		arg_12_0.heroAttrNode.nameLabel:setColor(getQualityColor(var_12_1.quality))

		local var_12_2 = CCTextureCache:sharedTextureCache():addImage(getProfessionIconImageName(var_12_1.profession))

		arg_12_0.heroAttrNode.professionImage:setTexture(var_12_2)
		arg_12_0.heroProgressBar.levelNode.numLabel:setString(tostring(var_12_0.level))
		arg_12_0.heroProgressBar.progressBar:setProgressValue(1, var_12_0.curExp, var_12_0.totalExp)
		arg_12_0.battlePowerLabel:setString(string.lf("#FFFF98主将战力 #9EFFFD%d", var_12_0.battlePower))
	else
		arg_12_0.heroAttrNode:setVisible(false)
		arg_12_0.battlePowerLabel:setString(string.lf("#FFFF98主将战力 #9EFFFD%d", 0))
	end

	arg_12_0.heroAttrLayer:reloadData()

	arg_12_0.equipHeaderTable = arg_12_0.equipHeaderTable or {}

	for iter_12_0 = 1, table.nums(arg_12_0.equipHeaderTable) do
		arg_12_0:removeChild(arg_12_0.equipHeaderTable[iter_12_0])
	end

	for iter_12_1 = 1, 6 do
		local var_12_3 = 165 + (iter_12_1 - 1) % 2 * 285
		local var_12_4 = 440 - math.floor((iter_12_1 - 1) / 2) * 103

		if arg_12_0.equipChoosedSprites[iter_12_1] == nil then
			arg_12_0.equipChoosedSprites[iter_12_1] = display.newSprite("ui/common/bg_choosed_cube.png", var_12_3, var_12_4)

			arg_12_0:addChild(arg_12_0.equipChoosedSprites[iter_12_1])
			arg_12_0.equipChoosedSprites[iter_12_1]:setPosition(var_12_3, var_12_4)
			arg_12_0.equipChoosedSprites[iter_12_1]:setVisible(false)
		end

		local function var_12_5(arg_13_0, arg_13_1)
			local var_13_0 = tolua.cast(arg_13_1, "CCControlButton")

			if var_13_0:getTag() ~= arg_12_0.curChoosedEquipIndex then
				local var_13_1 = var_13_0:getTag()
				local var_13_2 = arg_12_0:getEquipInfoByIndex(arg_12_0.curIndex, var_13_1)
				local var_13_3, var_13_4 = var_13_0:getParent():getPosition()

				if arg_12_0.dataType == TeamDataType.eTeamPlayer then
					if var_13_2 then
						arg_12_0:showTypeLayer(var_0_3.tagPageEquipEnhance, {
							equipItem = var_13_2,
							equipType = var_13_1
						})
						arg_12_0:setEquipButtonsChoose(var_13_1)
					else
						arg_12_0:showTypeLayer(var_0_3.tagPageEquipPackage, {
							equipType = var_13_1
						})
					end
				elseif var_13_2 then
					var_0_1.createTips({
						cancelable = true,
						touchable = true,
						show = var_0_1.eShowTeamEquip,
						data = var_13_2,
						curTeamHeroId = var_12_0.heroId
					}):show({
						parent = arg_12_0.teamScene.bg_far_Sprite,
						x = var_13_3,
						y = var_13_4
					})
				end
			end
		end

		local var_12_6 = arg_12_0:getEquipInfoByIndex(arg_12_1, iter_12_1)
		local var_12_7 = var_12_6 and var_12_6.equipId or 0
		local var_12_8 = var_12_6 and var_12_6.level or 0
		local var_12_9 = var_12_6 and var_12_6.BreakthroughCount or 0
		local var_12_10 = var_12_6 and var_12_6.pinJie or EquipPinjieType.eFanPin
		local var_12_11 = {
			type = ItemType.eEquip,
			itemId = var_12_7,
			level = var_12_8,
			equipType = iter_12_1,
			clickAction = var_12_5,
			equipJieji = var_12_9,
			equipPinJie = var_12_10,
			equipGem = var_12_6 and var_12_6.gem or nil
		}

		if var_12_7 > 0 then
			local var_12_12 = false

			for iter_12_2, iter_12_3 in ipairs(BaseEquips[var_12_7].herosId) do
				if var_12_0.heroId == iter_12_3 then
					var_12_12 = true

					break
				end
			end

			var_12_11.isGroupHero = var_12_12
		end

		local var_12_13 = figure.createHeader(var_12_11)

		var_12_13:setPosition(var_12_3, var_12_4)
		var_12_13.headerButton:setTag(iter_12_1)
		arg_12_0:addChild(var_12_13)

		arg_12_0.equipHeaderTable[iter_12_1] = var_12_13
	end
end

function var_0_2.createHeroAttrSliderLayer(arg_14_0)
	local function var_14_0(arg_15_0, arg_15_1)
		local var_15_0 = arg_14_0.team.groupList[arg_14_0.curIndex]

		if var_15_0 and var_15_0.heroId > 0 then
			local var_15_1 = {}
			local var_15_2 = {
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

			if arg_15_1 == 1 then
				var_15_1[1] = string.lf("血量 %d", var_15_0.health)
				var_15_1[2] = string.lf("速度 %d", var_15_0.speed)
				var_15_1[3] = string.lf("普攻 %d", var_15_0.normalAttack)
				var_15_1[4] = string.lf("法攻 %d", var_15_0.skillAttack)
				var_15_1[5] = string.lf("普防 %d", var_15_0.normalDefense)
				var_15_1[6] = string.lf("法防 %d", var_15_0.skillDefense)
			elseif arg_15_1 == 2 then
				var_15_1[1] = string.lf("暴击 %d", var_15_0.baoji)
				var_15_1[2] = string.lf("韧性 %d", var_15_0.renxing)
				var_15_1[3] = string.lf("命中 %d", var_15_0.mingzhong)
				var_15_1[4] = string.lf("闪避 %d", var_15_0.shanbi)
				var_15_1[5] = string.lf("破击 %d", var_15_0.poji)
				var_15_1[6] = string.lf("格挡 %d", var_15_0.gedang)
			end

			for iter_15_0 = 1, table.getn(var_15_1) do
				local var_15_3 = ui.newTTFLabel({
					text = "",
					font = _FONT_DEFAULT,
					size = Adapter.FontSize(20),
					color = ccc3(233, 152, 90),
					align = ui.TEXT_ALIGN_LEFT,
					x = var_15_2[iter_15_0].x + 22,
					y = var_15_2[iter_15_0].y + 9
				})

				var_15_3:setString(var_15_1[iter_15_0])
				var_15_3:setAnchorPoint(ccp(0, 0.5))
				arg_15_0:addChild(var_15_3)
				Adapter.NodeAbsScale(var_15_3)
			end

			if arg_15_1 == 2 then
				local var_15_4 = display.newSprite("ui/team/team_087.png", 20, 45)

				var_15_4:setFlipX(true)
				arg_15_0:addChild(var_15_4)
			end

			if arg_15_1 == 1 then
				local var_15_5 = display.newSprite("ui/team/team_087.png", 355, 45)

				arg_15_0:addChild(var_15_5)

				if arg_14_0.dataType == TeamDataType.eTeamPlayer then
					local var_15_6 = ui.newControlButton({
						normalImage = "ui/team/team_098.png",
						clickAction = function(arg_16_0, arg_16_1)
							local var_16_0 = arg_14_0.team.groupList[arg_14_0.curIndex]

							game.enterChangeFigureScene({
								heroIndex = arg_14_0.curIndex,
								heroInfo = var_16_0
							})
						end
					})

					var_15_6:setPosition(25, 50)
					arg_15_0:addChild(var_15_6)
				end
			end
		end
	end

	arg_14_0.heroAttrLayer = require("scenes.SliderLayer").new({
		size = CCSize(375, 115),
		clipScaleX = Adapter.MinScale,
		clipScaleY = Adapter.MinScale,
		point = ccp(120, 25),
		numberHandler = function()
			return 2
		end,
		changedHandler = function(arg_18_0)
			return
		end,
		cellHandler = var_14_0,
		direction = SliderDirection.eHorizontal
	})

	arg_14_0:addChild(arg_14_0.heroAttrLayer)
end

function var_0_2.showTypeLayer(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.team.groupList[arg_19_0.curIndex]

	local function var_19_1(arg_20_0, arg_20_1)
		if arg_20_0 then
			arg_20_0:setVisible(arg_20_1)
		end
	end

	local function var_19_2(arg_21_0)
		arg_19_0.teamScene:reloadCurrentLayer()
	end

	arg_19_0.curShowLayerTag = arg_19_0.curShowLayerTag or var_0_3.tagPageSpellInfo

	if arg_19_1 == var_0_3.tagPageHeroEnhance then
		arg_19_2.curIndex = arg_19_0.curIndex
		arg_19_2.isShowRebirth = arg_19_0.isShowRebirth

		if arg_19_0.heroEnhanceLayer == nil then
			arg_19_2.callback = var_19_2
			arg_19_2.pagesType = arg_19_0.dataType == TeamDataType.eTeamPlayer and var_0_0.ePagesPlayerTeam or var_0_0.ePagesFriendTeam
			arg_19_2.team = arg_19_0.team
			arg_19_2.partnerTeam = arg_19_0.partnerTeam
			arg_19_0.heroEnhanceLayer = var_0_0.new(arg_19_2)

			arg_19_0:addChild(arg_19_0.heroEnhanceLayer)
		else
			arg_19_0.heroEnhanceLayer:refreshHeroItem(arg_19_2)
		end

		var_19_1(arg_19_0.equipEnhanceLayer, false)
		var_19_1(arg_19_0.heroEnhanceLayer, true)

		if arg_19_0.equipPackageLayer then
			arg_19_0.equipPackageLayer:dismissAnimation()
		end

		arg_19_0:setEquipButtonsChoose(0)
	elseif arg_19_1 == var_0_3.tagPageEquipEnhance then
		arg_19_2.callback = var_19_2
		arg_19_2.heroId = var_19_0.heroId
		arg_19_2.enhanceScene = arg_19_0.teamScene
		arg_19_2.curHeroIndex = arg_19_0.curIndex
		arg_19_2.showEquipPackageButton = true

		function arg_19_2.showEquipPackageButtonCallback(arg_22_0)
			arg_19_0:showTypeLayer(var_0_3.tagPageEquipPackage, {
				equipType = arg_22_0
			})
			arg_19_0.equipPackageLayer:reloadLayer({
				equipType = arg_22_0
			})
		end

		if arg_19_0.equipEnhanceLayer == nil then
			arg_19_0.equipEnhanceLayer = require("scenes.team.EquipEnhanceLayer").new(arg_19_2)

			arg_19_0.equipEnhanceLayer:setPosition(-6, 0)
			arg_19_0:addChild(arg_19_0.equipEnhanceLayer)
		else
			arg_19_0.equipEnhanceLayer:refreshLayer(arg_19_2)
		end

		var_19_1(arg_19_0.equipEnhanceLayer, true)
		var_19_1(arg_19_0.heroEnhanceLayer, false)

		if arg_19_0.equipPackageLayer then
			arg_19_0.equipPackageLayer:dismissAnimation()
		end
	elseif arg_19_1 == var_0_3.tagPageEquipPackage then
		local function var_19_3()
			return arg_19_0.curIndex
		end

		local function var_19_4()
			if not arg_19_0.equipEnhanceLayer or arg_19_0.equipEnhanceLayer:isVisible() == false then
				local var_24_0 = arg_19_0.team.groupList[arg_19_0.curIndex]

				arg_19_0:showTypeLayer(var_0_3.tagPageHeroEnhance, {
					heroItem = var_24_0
				})
			end

			arg_19_0.equipPackageLayer = nil
		end

		local function var_19_5()
			var_19_1(arg_19_0.equipEnhanceLayer, false)
			var_19_1(arg_19_0.heroEnhanceLayer, false)
		end

		if arg_19_0.equipPackageLayer == nil then
			arg_19_0.equipPackageLayer = require("scenes.team.EquipPackageLayer").new({
				team = arg_19_0.team,
				equipType = arg_19_2.equipType,
				getCurrentIndex = var_19_3,
				refreshEquipHandle = var_19_2,
				closeCallback = var_19_4,
				appearCallback = var_19_5,
				teamScene = arg_19_0.teamScene
			})

			arg_19_0:addChild(arg_19_0.equipPackageLayer, 77)
		else
			arg_19_0.equipPackageLayer:reloadLayer({
				equipType = arg_19_2.equipType
			})
		end

		arg_19_0:setEquipButtonsChoose(0)
	end

	arg_19_0.curShowLayerTag = arg_19_1
end

function var_0_2.createNetworkRequest(arg_26_0)
	local function var_26_0()
		arg_26_0.teamScene:reloadCurrentLayer()
	end

	local function var_26_1(arg_28_0)
		return
	end

	arg_26_0.heroUnloadEquipRequest = HeroUnloadEquipRequest:new()

	arg_26_0.heroUnloadEquipRequest:setResponseNormalHandler(var_26_0)
	arg_26_0.heroUnloadEquipRequest:setResponseExceptionHandler(var_26_1)
end

return var_0_2
