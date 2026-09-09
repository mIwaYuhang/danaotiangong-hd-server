local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("EquipPackageLayer", function()
	return display.newLayer()
end)
local var_0_2 = {
	{
		btnSprite = "ui/common/common_073_1.png",
		y = 51,
		tag = 1,
		x = 103.5,
		title = string.lf("神器"),
		equipTypes = {
			EquipType.eWeapon,
			EquipType.eAmulet
		}
	},
	{
		btnSprite = "ui/common/common_073_1.png",
		y = 51,
		tag = 2,
		x = 222.5,
		title = string.lf("衣冠"),
		equipTypes = {
			EquipType.eHelmet,
			EquipType.eClothes
		}
	},
	{
		btnSprite = "ui/common/common_073_1.png",
		y = 51,
		tag = 3,
		x = 341.5,
		title = string.lf("佩饰"),
		equipTypes = {
			EquipType.eNecklace,
			EquipType.eRing
		}
	}
}

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0.team = arg_2_1.team or Player.team
	arg_2_0.getCurrentIndex = arg_2_1.getCurrentIndex
	arg_2_0.appearCallback = arg_2_1.appearCallback
	arg_2_0.closeCallback = arg_2_1.closeCallback
	arg_2_0.teamScene = arg_2_1.teamScene

	local var_2_0 = arg_2_0.getCurrentIndex()

	arg_2_0.curHero = arg_2_0.team.groupList[var_2_0]
	arg_2_0.refreshEquipHandle = arg_2_1.refreshEquipHandle
	arg_2_0._currentSelectIndex = EquipHelper:getEquipSubClassID(arg_2_1.equipType or EquipType.eWeapon)
	arg_2_0._totalPageCount = 1
	arg_2_0._pageCount = 16
	arg_2_0._currentDisplayPage = 1
	arg_2_0._equipDataList = {}

	local var_2_1 = CCSize(445, 550)
	local var_2_2 = display.newScale9Sprite("ui/team/team_002.png")

	var_2_2:setPreferredSize(var_2_1)
	var_2_2:setAnchorPoint(CCPoint(0, 0))
	var_2_2:setPosition(CCPoint(0, 0))
	arg_2_0:addChild(var_2_2)

	arg_2_0.bgSprite = var_2_2
	arg_2_0.background = CCLayerColor:create(ccc4(0, 0, 0, 0))

	arg_2_0.background:setContentSize(var_2_1)
	var_2_2:addChild(arg_2_0.background)

	local var_2_3 = ui.newControlButton({
		normalImage = "ui/team/team_040.png",
		position = ccp(441, 546),
		clickAction = function(arg_3_0, arg_3_1)
			arg_2_0:dismissAnimation()
		end
	})

	var_2_3:setAnchorPoint(ccp(1, 1))
	arg_2_0.background:addChild(var_2_3)

	arg_2_0.itemButtonTable = {}

	local function var_2_4(arg_4_0, arg_4_1)
		local var_4_0 = tolua.cast(arg_4_1, "CCControlButton")
		local var_4_1 = var_4_0:getTag()
		local var_4_2 = false
		local var_4_3 = arg_2_0._equipDataList[var_4_1]
		local var_4_4 = BaseEquips[var_4_3.equipId].equipType
		local var_4_5 = arg_2_0.getCurrentIndex()

		arg_2_0.curHero = arg_2_0.team.groupList[var_4_5]

		if arg_2_0.curHero.heroId ~= 0 then
			var_4_2 = BaseEquips[var_4_3.equipId].profession == BaseHeros[arg_2_0.curHero.heroId].profession
		end

		if var_4_4 ~= EquipType.eWeapon then
			var_4_2 = true
		end

		arg_2_0:createTipsView(arg_2_0._equipDataList[var_4_1], var_4_2, var_4_0:getParent(), arg_2_0.equipsLayer)
	end

	arg_2_0.equipsLayer = require("scenes.SliderLayer").new({
		navOnSprite = "ui/common/common_048.png",
		navOffSprite = "ui/common/common_047.png",
		navMargin = 30,
		size = CCSizeMake(434, 360),
		clipScaleX = Adapter.MinScale,
		clipScaleY = Adapter.MinScale,
		point = ccp(2, 133),
		navPosition = ccp(200, -20),
		numberHandler = function()
			return arg_2_0._totalPageCount
		end,
		changedHandler = function(arg_6_0)
			return
		end,
		cellHandler = function(arg_7_0, arg_7_1)
			local var_7_0 = (arg_7_1 - 1) * arg_2_0._pageCount + 1
			local var_7_1 = arg_7_1 * arg_2_0._pageCount
			local var_7_2 = 0
			local var_7_3 = 0
			local var_7_4 = arg_2_0:getCurrentHeroEquipScore()

			for iter_7_0 = var_7_0, var_7_1 do
				local var_7_5 = (var_7_2 % 4 + 0.5) * 100 + 20
				local var_7_6 = (4 - math.floor(var_7_2 / 4) - 0.5) * 90
				local var_7_7
				local var_7_8 = false

				repeat
					local var_7_9 = false

					if arg_2_0._equipDataList[iter_7_0 + var_7_3] and arg_2_0._equipDataList[iter_7_0 + var_7_3].isInTeam == 1 then
						var_7_3 = var_7_3 + 1
					else
						var_7_9 = true
					end
				until var_7_9 == true

				if iter_7_0 <= #arg_2_0._equipDataList - var_7_3 then
					local var_7_10 = arg_2_0._equipDataList[iter_7_0 + var_7_3]
					local var_7_11 = var_7_10.equipId
					local var_7_12 = arg_2_0:computeEquipScore(var_7_10)
					local var_7_13 = var_7_4[BaseEquips[var_7_11].equipType] or 0

					if arg_2_0.curHero and arg_2_0.curHero.heroId == 0 then
						var_7_13 = 10000
					end

					local var_7_14

					if arg_2_0.curHero.heroId ~= 0 then
						var_7_14 = BaseEquips[var_7_11].profession == BaseHeros[arg_2_0.curHero.heroId].profession
					end

					if BaseEquips[var_7_11].equipType ~= EquipType.eWeapon then
						var_7_14 = true
					end

					local var_7_15 = arg_2_0:isEquipFitWithHero(var_7_11, arg_2_0.curHero.heroId)

					var_7_7 = figure.createHeader({
						type = ItemType.eEquip,
						itemId = var_7_11,
						isAttrUpgrade = var_7_14 and var_7_13 < var_7_12,
						isGroupHero = var_7_15,
						clickAction = var_2_4,
						equipJieji = var_7_10.BreakthroughCount,
						level = var_7_10.level,
						equipType = var_7_10.equipType,
						equipPinJie = var_7_10.pinJie,
						equipGem = var_7_10.gem
					})

					if var_7_14 == false then
						local var_7_16 = display.newSprite("ui/common/mask2.png", 0, 0)

						var_7_7:addChild(var_7_16)
					end
				else
					var_7_7 = figure.createHeader({
						itemId = 0,
						noTypeImage = true,
						type = ItemType.eEquip
					})
				end

				var_7_7:setPosition(var_7_5, var_7_6)
				var_7_7.headerButton:setTag(iter_7_0 + var_7_3)
				arg_7_0:addChild(var_7_7)

				if arg_2_0.itemButtonTable[arg_7_1] == nil then
					arg_2_0.itemButtonTable[arg_7_1] = {}
				end

				arg_2_0.itemButtonTable[arg_7_1][var_7_2] = var_7_7
				var_7_2 = var_7_2 + 1
			end
		end,
		direction = SliderDirection.eHorizontal,
		touchBeginCallback = function(arg_8_0, arg_8_1, arg_8_2)
			local var_8_0 = arg_2_0.equipsLayer:convertToNodeSpace(ccp(arg_8_1, arg_8_2))
			local var_8_1 = 0
			local var_8_2 = 1000

			for iter_8_0 = 0, 15 do
				local var_8_3 = (iter_8_0 % 4 + 0.5) * 100 + 20
				local var_8_4 = (4 - math.floor(iter_8_0 / 4) - 0.5) * 90
				local var_8_5 = ccpDistance(var_8_0, ccp(var_8_3, var_8_4))

				if var_8_5 < var_8_2 then
					var_8_2 = var_8_5
					var_8_1 = iter_8_0
				end
			end

			arg_2_0.buttonIndex = var_8_1

			local var_8_6 = arg_2_0.itemButtonTable[arg_8_0][arg_2_0.buttonIndex].headerButton:getTag()

			if arg_2_0._equipDataList[var_8_6] == nil then
				return false
			end

			local var_8_7 = arg_2_0._equipDataList[var_8_6].equipId

			arg_2_0.itemButtonTable[arg_8_0][arg_2_0.buttonIndex]:setHeaderOpacity(120)

			arg_2_0.touchHeaderButton = figure.createHeader({
				type = ItemType.eEquip,
				itemId = var_8_7,
				level = arg_2_0._equipDataList[var_8_6].level,
				equipType = arg_2_0._equipDataList[var_8_6].equipType
			})

			arg_2_0.touchHeaderButton:setScale(Adapter.MinScale)
			arg_2_0.touchHeaderButton:setPosition(ccp(arg_8_1, arg_8_2))
			display.getRunningScene():addChild(arg_2_0.touchHeaderButton)

			return true
		end,
		touchMoveCallback = function(arg_9_0, arg_9_1, arg_9_2)
			if arg_2_0.touchHeaderButton then
				arg_2_0.touchHeaderButton:setPosition(ccp(arg_9_1, arg_9_2))
			end
		end,
		touchEndCallback = function(arg_10_0, arg_10_1, arg_10_2)
			if arg_2_0.touchHeaderButton then
				arg_2_0.touchHeaderButton:removeFromParent()

				arg_2_0.touchHeaderButton = nil

				arg_2_0.itemButtonTable[arg_10_0][arg_2_0.buttonIndex]:setHeaderOpacity(255)
			end

			local var_10_0 = arg_2_0:convertToNodeSpace(ccp(arg_10_1, arg_10_2))

			print(var_10_0.x, var_10_0.y)

			if var_10_0.x > 0 then
				return
			end

			local var_10_1 = arg_2_0.itemButtonTable[arg_10_0][arg_2_0.buttonIndex].headerButton:getTag()
			local var_10_2 = arg_2_0._equipDataList[var_10_1]

			arg_2_0:equipSelectedEquip(var_10_2)
		end
	})

	arg_2_0.equipsLayer:setPosition((var_2_1.width - 434) / 2, (var_2_1.height - 360) / 2 + 20)
	arg_2_0.background:addChild(arg_2_0.equipsLayer)
	arg_2_0.equipsLayer:reloadData()

	local function var_2_5(arg_11_0, arg_11_1)
		local var_11_0 = tolua.cast(arg_11_1, "CCControlButton"):getTag()

		arg_2_0:highlightTabButton(var_11_0)

		arg_2_0._currentSelectIndex = var_11_0
		arg_2_0._currentSelectType = nil
		arg_2_0._currentDisplayPage = 1

		arg_2_0:requestEquipData()
	end

	for iter_2_0, iter_2_1 in ipairs(var_0_2) do
		local var_2_6 = CCScale9Sprite:create("ui/common/common_073_1.png")
		local var_2_7 = CCScale9Sprite:create("ui/common/common_073_2.png")
		local var_2_8 = CCControlButton:create(iter_2_1.title, _FONT_DEFAULT, Adapter.FontSize(24))

		var_2_8:setPosition(ccp(iter_2_1.x, iter_2_1.y))
		var_2_8:setAnchorPoint(ccp(0.5, 0.5))
		var_2_8:setTag(iter_2_1.tag)
		var_2_8:setPreferredSize(CCSize(100, 50))
		var_2_8:setTitleColorForState(ccc3(255, 227, 150), CCControlStateHighlighted)
		var_2_8:setTitleColorForState(ccc3(196, 151, 79), CCControlStateNormal)
		var_2_8:setBackgroundSpriteForState(var_2_6, CCControlStateNormal)
		var_2_8:setBackgroundSpriteForState(var_2_7, CCControlStateHighlighted)
		var_2_8:addHandleOfControlEvent(var_2_5, CCControlEventTouchUpInside)
		arg_2_0.background:addChild(var_2_8)

		iter_2_1.btn = var_2_8
	end

	local var_2_9 = ui.newControlButton({
		fontSize = 24,
		text = "",
		normalImage = "ui/team/team_110.png",
		highlightedImage = "ui/team/team_110.png",
		textColor = ColorTable.eTitleTabButton_Normal,
		clickAction = function(arg_12_0, arg_12_1)
			if arg_2_0.curHero and arg_2_0.curHero.heroId == 0 then
				ui.showMessageBox({
					text = string.lf("上仙，没有主将上阵，这可怎么穿装备啊~~")
				})

				return
			end

			arg_2_0.heroChangeAllEquipRequest:request(arg_2_0.curHero.heroId)
		end
	})

	var_2_9:setAnchorPoint(ccp(0, 1))
	var_2_9:setPosition(3, 546)
	arg_2_0.background:addChild(var_2_9)
	arg_2_0:requestEquipData()
	arg_2_0:createNetworkRequest()
	arg_2_0:highlightTabButton(arg_2_0._currentSelectIndex)
	arg_2_0:setNodeEventEnabled(true)
end

function var_0_1.equipSelectedEquip(arg_13_0, arg_13_1)
	arg_13_0._tmpEquipId = arg_13_1.equipId
	arg_13_0._tmpEuipUserId = arg_13_1.equipUserId

	local var_13_0 = BaseEquips[arg_13_1.equipId].equipType
	local var_13_1 = false

	if arg_13_0.curHero.heroId ~= 0 then
		var_13_1 = BaseEquips[arg_13_1.equipId].profession == BaseHeros[arg_13_0.curHero.heroId].profession
	end

	if var_13_0 ~= EquipType.eWeapon then
		var_13_1 = true
	end

	if var_13_1 == false then
		ui.showMessageBox({
			text = string.lf("上仙，主将职业与装备职业不符.")
		})

		return
	end

	if arg_13_0.curHero and arg_13_0.curHero.heroId > 0 then
		arg_13_0.mIsChangingEquipFitWithHero = arg_13_0:isEquipFitWithHero(arg_13_1.equipId, arg_13_0.curHero.heroId)

		arg_13_0.heroChangeEquipRequest:request(arg_13_0.curHero.heroId, var_13_0, arg_13_1.equipUserId)
	else
		ui.showMessageBox({
			text = string.lf("上仙，没有主将上阵，这可怎么穿装备啊~~")
		})
	end
end

function var_0_1.getCurrentHeroEquipScore(arg_14_0)
	local var_14_0 = arg_14_0.getCurrentIndex()

	arg_14_0.curHero = arg_14_0.team.groupList[var_14_0]

	local var_14_1 = {}

	if arg_14_0.curHero.equipList ~= nil then
		for iter_14_0, iter_14_1 in ipairs(arg_14_0.curHero.equipList) do
			var_14_1[BaseEquips[iter_14_1.equipId].equipType] = arg_14_0:computeEquipScore(iter_14_1)
		end
	end

	return var_14_1
end

function var_0_1.computeEquipScore(arg_15_0, arg_15_1)
	local var_15_0 = getEquipAttrTypeList(arg_15_1.equipId)
	local var_15_1 = 0

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		var_15_1 = var_15_1 + getEquipAttrValue(iter_15_1, arg_15_1)
	end

	return var_15_1
end

function var_0_1.onEnter(arg_16_0)
	arg_16_0:setPosition(ccp(display.right, 7))

	local function var_16_0()
		if Player:getTroMaxStep() == NSStep.ZhanYi4Reward then
			GuideLayer:showNewbieGuideLayer(arg_16_0.teamScene, arg_16_0.bgSprite, 21, function()
				arg_16_0:createTipsView(arg_16_0._equipDataList[1], true, arg_16_0.itemButtonTable[1][1], arg_16_0.equipsLayer)

				return true
			end)
		end
	end

	local var_16_1 = CCArray:create()
	local var_16_2 = CCMoveTo:create(0.5, ccp(505, 7))
	local var_16_3 = CCEaseElasticOut:create(var_16_2, 0.9)

	var_16_1:addObject(var_16_3)
	var_16_1:addObject(CCCallFunc:create(var_16_0))
	arg_16_0:runAction(CCSequence:create(var_16_1))

	if arg_16_0.appearCallback then
		arg_16_0.appearCallback()
	end
end

function var_0_1.onExit(arg_19_0)
	if arg_19_0.closeCallback then
		arg_19_0.closeCallback()
	end
end

function var_0_1.createNetworkRequest(arg_20_0)
	local function var_20_0()
		EquipHelper:markEquipInTeamStatus(arg_20_0._tmpEuipUserId, 1)
		arg_20_0.refreshEquipHandle()
		arg_20_0.equipsLayer:reloadData()

		if arg_20_0.mIsChangingEquipFitWithHero then
			local var_21_0 = display.newSprite("uilocal/team/team_text_033.png", display.cx - Adapter.MinScale * 180, display.cy - Adapter.MinScale * 105)

			var_21_0:setScale(Adapter.MinScale)
			arg_20_0.teamScene:addChild(var_21_0)
			transition.execute(var_21_0, transition.sequence({
				CCEaseOut:create(CCMoveTo:create(0.5, ccp(display.cx - Adapter.MinScale * 180, display.cy + Adapter.MinScale * 50)), 5),
				CCDelayTime:create(0.5),
				CCEaseIn:create(CCMoveTo:create(0.5, ccp(display.cx - Adapter.MinScale * 180, display.cy + Adapter.MinScale * 200)), 8)
			}), {
				onComplete = function()
					var_21_0:removeFromParentAndCleanup(true)
				end
			})
		end

		if Player:getTroMaxStep() == NSStep.ZhanYi4Reward then
			GuideLayer:saveTrioMaxStep(NSStep.HuanZhuangbei, function()
				game.enterTeamScene({
					pageType = 1
				})
			end)
		end
	end

	local function var_20_1(arg_24_0)
		return
	end

	arg_20_0.heroChangeEquipRequest = HeroChangeEquipRequest:new()

	arg_20_0.heroChangeEquipRequest:setResponseNormalHandler(var_20_0)
	arg_20_0.heroChangeEquipRequest:setResponseExceptionHandler(var_20_1)

	local function var_20_2()
		arg_20_0.refreshEquipHandle()
		arg_20_0:requestEquipData()
	end

	local function var_20_3(arg_26_0)
		return
	end

	arg_20_0.heroChangeAllEquipRequest = ChangeAllEquipRequest:new()

	arg_20_0.heroChangeAllEquipRequest:setResponseNormalHandler(var_20_2)
	arg_20_0.heroChangeAllEquipRequest:setResponseExceptionHandler(var_20_3)
end

function var_0_1.highlightTabButton(arg_27_0, arg_27_1)
	for iter_27_0, iter_27_1 in ipairs(var_0_2) do
		if iter_27_1.tag == arg_27_1 then
			iter_27_1.btn:setHighlighted(true)
		else
			iter_27_1.btn:setHighlighted(false)
		end
	end
end

function var_0_1.requestEquipData(arg_28_0)
	local function var_28_0(arg_29_0, arg_29_1)
		arg_28_0._equipDataList = arg_29_0

		arg_28_0:sortEquipData()

		arg_28_0._totalPageCount = math.ceil(#arg_28_0._equipDataList / arg_28_0._pageCount)

		if arg_28_0._totalPageCount == 0 then
			arg_28_0._totalPageCount = 1
		end

		arg_28_0.equipsLayer:reloadData(1)
	end

	EquipHelper:getEquipList(4, var_28_0, 0)
end

function var_0_1.sortEquipData(arg_30_0)
	local function var_30_0(arg_31_0, arg_31_1)
		local var_31_0 = arg_31_0
		local var_31_1 = arg_31_1

		if arg_30_0._currentSelectType ~= nil then
			local var_31_2 = arg_30_0._currentSelectType == BaseEquips[var_31_0.equipId].equipType
			local var_31_3 = arg_30_0._currentSelectType == BaseEquips[var_31_1.equipId].equipType

			if var_31_2 ~= var_31_3 then
				if var_31_2 == true and var_31_3 == false then
					return true
				end

				if var_31_2 == false and var_31_3 == true then
					return false
				end
			end
		end

		local var_31_4 = EquipHelper:getEquipSubClassID(BaseEquips[var_31_0.equipId].equipType)
		local var_31_5 = EquipHelper:getEquipSubClassID(BaseEquips[var_31_1.equipId].equipType)
		local var_31_6 = var_31_4 == arg_30_0._currentSelectIndex
		local var_31_7 = var_31_5 == arg_30_0._currentSelectIndex

		if var_31_6 ~= var_31_7 then
			if var_31_6 == true and var_31_7 == false then
				return true
			end

			if var_31_6 == false and var_31_7 == true then
				return false
			end

			return var_31_0.equipType > var_31_1.equipType
		end

		local var_31_8 = arg_30_0:isEquipFitWithHero(var_31_0.equipId, arg_30_0.curHero.heroId)
		local var_31_9 = arg_30_0:isEquipFitWithHero(var_31_1.equipId, arg_30_0.curHero.heroId)

		if var_31_8 == true and var_31_9 == true then
			return var_31_0.level > var_31_1.level
		elseif var_31_8 == true then
			return true
		elseif var_31_9 == true then
			return false
		end

		if arg_30_0.curHero.heroId > 0 then
			local var_31_10 = BaseHeros[arg_30_0.curHero.heroId].profession
			local var_31_11 = BaseEquips[var_31_0.equipId].profession == var_31_10
			local var_31_12 = BaseEquips[var_31_1.equipId].profession == var_31_10

			if BaseEquips[var_31_0.equipId].equipType ~= EquipType.eWeapon then
				var_31_11 = true
			end

			if BaseEquips[var_31_1.equipId].equipType ~= EquipType.eWeapon then
				var_31_12 = true
			end

			if var_31_11 == true and var_31_12 == false then
				return true
			end

			if var_31_11 == false and var_31_12 == true then
				return false
			end
		end

		if var_31_0.level > var_31_1.level then
			return true
		elseif var_31_0.level == var_31_1.level then
			return var_31_0.equipId > var_31_1.equipId
		else
			return false
		end

		return true
	end

	local var_30_1 = arg_30_0.getCurrentIndex()

	arg_30_0.curHero = arg_30_0.team.groupList[var_30_1]

	table.sort(arg_30_0._equipDataList, var_30_0)
end

function var_0_1.reloadLayer(arg_32_0, arg_32_1)
	if arg_32_1 then
		arg_32_0._currentSelectIndex = EquipHelper:getEquipSubClassID(arg_32_1.equipType)
		arg_32_0._currentSelectType = arg_32_1.equipType

		arg_32_0:highlightTabButton(arg_32_0._currentSelectIndex)
		arg_32_0:requestEquipData()
	else
		arg_32_0._currentSelectType = nil

		arg_32_0.equipsLayer:reloadData()
	end
end

function var_0_1.dismissAnimation(arg_33_0)
	local var_33_0 = CCArray:create()
	local var_33_1 = CCMoveTo:create(0.5, ccp(display.right, 7))
	local var_33_2 = CCEaseElasticIn:create(var_33_1, 0.9)

	var_33_0:addObject(var_33_2)
	var_33_0:addObject(CCCallFunc:create(handler(arg_33_0, arg_33_0.removeFromParent)))
	arg_33_0:runAction(CCSequence:create(var_33_0))
end

function var_0_1.createTipsView(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	if arg_34_0.curHero.heroId == 0 then
		return
	end

	arg_34_0._tips = var_0_0.createTips({
		cancelable = true,
		swallow = true,
		touchable = true,
		show = var_0_0.eShowTeamEquip,
		data = arg_34_1,
		heroId = arg_34_0.curHero.heroId
	})

	arg_34_0._tips:addAction({
		text = string.lf("装上"),
		enabled = arg_34_2,
		callback = function(arg_35_0, arg_35_1)
			arg_34_0:equipSelectedEquip(arg_34_1)
			arg_34_0._tips:removeSelf()
		end
	})
	arg_34_0._tips:show({
		limit = true,
		parent = arg_34_4,
		node = arg_34_3
	})

	if Player:getTroMaxStep() == NSStep.ZhanYi4Reward then
		GuideLayer:showNewbieGuideLayer(arg_34_0.teamScene, arg_34_0._tips.container, 22, function()
			arg_34_0:equipSelectedEquip(arg_34_0._equipDataList[1])

			return true
		end, nil, nil, true)
	end
end

function var_0_1.getLastEquipedEquipType(arg_37_0)
	if arg_37_0._tmpEquipId ~= nil then
		return BaseEquips[arg_37_0._tmpEquipId].equipType
	else
		return EquipType.eWeapon
	end
end

function var_0_1.isEquipFitWithHero(arg_38_0, arg_38_1, arg_38_2)
	arg_38_2 = arg_38_2 or arg_38_0.curHero.heroId

	for iter_38_0, iter_38_1 in ipairs(BaseEquips[arg_38_1].herosId) do
		if arg_38_2 == iter_38_1 then
			return true
		end
	end

	return false
end

return var_0_1
