require("network.ZSZZRequest")
require("scenes.battle.BattleSkeleton")
require("scenes.battle.BattleData")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = class("ZSZZFightScene", function()
	return display.newScene("ZSZZFightScene")
end)
local var_0_2 = {
	eEmpty = 3,
	eFailed = 2,
	eSuccess = 1
}

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0.mHomeInfo = {}

	arg_2_0:setUI()

	arg_2_0.mparams = arg_2_1

	if arg_2_1.pageTypein == 5 then
		arg_2_0:requestHomeInfo()
	else
		arg_2_0.mShowingTop32Record = true

		arg_2_0:requestTop32Info(arg_2_1.pageType)
	end
end

function var_0_1.setUI(arg_3_0)
	local var_3_0 = math.max(Adapter.WidthScale, Adapter.HeightScale)
	local var_3_1 = display.newSprite("ui/fuben/zszz_001.jpg", display.cx, display.cy)

	var_3_1:setScale(var_3_0)
	arg_3_0:addChild(var_3_1)

	local var_3_2 = Adapter.MinScale
	local var_3_3 = CCSizeMake(display.width / var_3_2, display.height / var_3_2)
	local var_3_4 = display.newNode()

	var_3_4:setContentSize(var_3_3)
	var_3_4:setAnchorPoint(ccp(0, 0))
	var_3_4:setScale(var_3_2)
	arg_3_0:addChild(var_3_4)

	arg_3_0.mContainerScale = var_3_2
	arg_3_0.mContainer = var_3_4
	arg_3_0.mContainerSize = var_3_3
	arg_3_0.mBgSprite = var_3_1
	arg_3_0.EndSprite = display.newSprite("uilocal/fuben/zszz_text_047.png")

	arg_3_0.EndSprite:setPosition(ccp(display.cx, display.cy + 60))
	arg_3_0:addChild(arg_3_0.EndSprite)
	arg_3_0.EndSprite:setVisible(false)

	local var_3_5 = ui.newControlButton({
		normalImage = "ui/common/common_061.png",
		position = ccp(var_3_3.width - 60, var_3_3.height - 35),
		clickAction = function()
			game.enterZSZZHomeScene()
		end
	})

	var_3_4:addChild(var_3_5)

	arg_3_0.mBtnReport = ui.newControlButton({
		normalImage = "uilocal/fuben/zszz_text_001.png",
		position = ccp(var_3_3.width - 60, var_3_3.height - 110),
		clickAction = handler(arg_3_0, arg_3_0.onBtnMyFightReportClicked)
	})

	var_3_4:addChild(arg_3_0.mBtnReport)
	arg_3_0:createFightUI()
	arg_3_0:enableView(false)
end

function var_0_1.createFightUI(arg_5_0)
	arg_5_0.mCenterNode = display.newNode()

	arg_5_0.mCenterNode:setPosition(ccp(arg_5_0.mContainerSize.width / 2, arg_5_0.mContainerSize.height / 2))
	arg_5_0.mContainer:addChild(arg_5_0.mCenterNode)

	arg_5_0.mMyFightInfoView = arg_5_0:createMyFightInfoView()

	arg_5_0.mMyFightInfoView:setAnchorPoint(ccp(0, 1))
	arg_5_0.mMyFightInfoView:setPosition(-arg_5_0.mContainerSize.width / 2 + 10, arg_5_0.mContainerSize.height / 2 - 20)
	arg_5_0.mCenterNode:addChild(arg_5_0.mMyFightInfoView)

	arg_5_0.mTop3RankView = arg_5_0:createTop3RankView()

	arg_5_0.mTop3RankView:setAnchorPoint(ccp(0.5, 1))
	arg_5_0.mTop3RankView:setPosition(0, arg_5_0.mContainerSize.height / 2 - 2)
	arg_5_0.mCenterNode:addChild(arg_5_0.mTop3RankView)

	arg_5_0.mCenterView = arg_5_0:createCenterView()

	arg_5_0.mCenterNode:addChild(arg_5_0.mCenterView)

	arg_5_0.mBottomInfoView = arg_5_0:createBottomFightInfoView()

	arg_5_0.mBottomInfoView:setAnchorPoint(ccp(0.5, 0))
	arg_5_0.mBottomInfoView:setPosition(0, -arg_5_0.mContainerSize.height / 2 + 20)
	arg_5_0.mCenterNode:addChild(arg_5_0.mBottomInfoView)

	local function var_5_0(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0, var_6_1 = var_0_0.getPosition(arg_6_0, arg_5_0.mContainer)
		local var_6_2 = arg_6_0.headerInfo

		arg_6_0:removeFromParentAndCleanup(true)

		local var_6_3 = arg_5_0.mLeftView:createHeader(var_6_2)

		var_6_3:setPosition(var_6_0, var_6_1)
		arg_5_0.mContainer:addChild(var_6_3)
		transition.execute(var_6_3, CCMoveTo:create(0.5, arg_6_1), {
			onComplete = function()
				arg_6_2(var_6_3)
				var_6_3:removeFromParentAndCleanup(false)
			end
		})
	end

	local var_5_1, var_5_2 = var_0_0.getPosition(arg_5_0.mCenterView.leftNode, arg_5_0.mContainer)
	local var_5_3 = ccp(var_5_1, var_5_2)

	arg_5_0.mLeftView = arg_5_0:createLeftHeaderView(function(arg_8_0)
		var_5_0(arg_8_0, var_5_3, function(arg_9_0)
			arg_5_0.mCenterView:setLeftHero(arg_9_0.headerInfo)
		end)
	end)

	arg_5_0.mLeftView:setAnchorPoint(ccp(0, 0.5))
	arg_5_0.mLeftView:setPosition(Adapter.MinPos(1, (arg_5_0.mContainerSize.height - 158) / 2))
	arg_5_0:addChild(arg_5_0.mLeftView)
	arg_5_0.mLeftView:setVisible(true)

	local var_5_4, var_5_5 = var_0_0.getPosition(arg_5_0.mCenterView.rightNode, arg_5_0.mContainer)
	local var_5_6 = ccp(var_5_4, var_5_5)

	arg_5_0.mRightView = arg_5_0:createRightHeaderView(function(arg_10_0)
		var_5_0(arg_10_0, var_5_6, function(arg_11_0)
			arg_5_0.mCenterView:setRightHero(arg_11_0.headerInfo)
		end)
	end)

	arg_5_0.mRightView:setAnchorPoint(ccp(1, 0.5))
	arg_5_0.mRightView:setPosition(Adapter.MinPos(arg_5_0.mContainerSize.width - 2, (arg_5_0.mContainerSize.height - 158) / 2))
	arg_5_0:addChild(arg_5_0.mRightView)
	arg_5_0.mRightView:setVisible(true)
end

function var_0_1.createMyFightInfoView(arg_12_0)
	local var_12_0 = arg_12_0:getImageSize("ui/fuben/zszz_006.png")
	local var_12_1 = display.newSprite("ui/fuben/zszz_006.png")
	local var_12_2 = display.newNode()

	var_12_1:addChild(var_12_2)

	local var_12_3 = {}

	for iter_12_0 = 1, 4 do
		var_12_3[iter_12_0] = addLabelWithColorSize(var_12_2, string.lf(""), ccc3(255, 220, 130), 22, ccp(0, 0), ccp(5, 5 + 30 * (iter_12_0 - 1)))
	end

	local var_12_4 = addLabelWithColorSize(var_12_1, string.lf("您未参加本次诸神之战"), ccc3(255, 224, 0), 22, ccp(0, 0.5), ccp(5, var_12_0.height / 2))
	local var_12_5 = display.newSprite("ui/fuben/zszz_008.png")

	var_12_5:setAnchorPoint(ccp(0.5, 0))
	var_12_1:addChild(var_12_5)
	var_12_4:setVisible(false)
	var_12_2:setVisible(false)
	var_12_5:setVisible(false)

	function var_12_1.setInfo(arg_13_0, arg_13_1)
		if not arg_13_1 then
			var_12_2:setVisible(false)
			var_12_5:setVisible(false)
			var_12_4:setVisible(true)
		else
			var_12_3[4]:setString(string.lf("#FFDC82战斗力:#E4E4E4%s(#00FF00%s%%#E4E4E4  )", arg_13_1.OriginalPower, arg_13_1.EncouragingAddition))

			local var_13_0 = var_12_3[4]:getContentSize()

			var_12_5:setPosition(var_13_0.width / Adapter.MinScale - 8, 92)
			var_12_3[3]:setString(string.lf("#FFDC82当前复活次数:#E4E4E4%s", arg_13_1.RebornCount))
			var_12_3[2]:setString(string.lf("#FFDC82击杀数:#E4E4E4%s", arg_13_1.KillCount))
			var_12_3[1]:setString(string.lf("#FFDC82杀戮排名:#E4E4E4%s", arg_13_1.CurrentRank))
			var_12_2:setVisible(true)
			var_12_5:setVisible(true)
			var_12_4:setVisible(false)
		end
	end

	return var_12_1
end

function var_0_1.createTop3RankView(arg_14_0)
	local var_14_0 = arg_14_0:getImageSize("ui/fuben/zszz_005.png")
	local var_14_1 = display.newSprite("ui/fuben/zszz_005.png")
	local var_14_2 = ui.newControlButton({
		normalImage = "ui/duel/duel_008.png",
		position = ccp(var_14_0.width + 15, var_14_0.height / 2),
		clickAction = handler(arg_14_0, arg_14_0.onBtnMoreRankClicked)
	})
	local var_14_3 = display.newSprite("uilocal/fuben/zszz_text_024.png", 85, 28)

	var_14_3:setRotation(-90)
	var_14_2:addChild(var_14_3)
	var_14_2:setRotation(90)
	var_14_1:addChild(var_14_2)

	local var_14_4 = {}
	local var_14_5 = {}

	local function var_14_6(arg_15_0)
		print("clickHeader:", arg_15_0)
	end

	local var_14_7 = {
		90,
		240,
		390
	}

	for iter_14_0 = 1, 3 do
		var_14_4[iter_14_0] = display.newNode()

		var_14_1:addChild(var_14_4[iter_14_0])

		local var_14_8 = var_14_7[iter_14_0]
		local var_14_9 = {
			display.newSprite("ui/fuben/zszz_007.png", var_14_8, var_14_0.height - 53),
			display.newSprite("ui/fuben/zszz_028.png", var_14_8, var_14_0.height - 53),
			(display.newSprite("ui/fuben/zszz_029.png", var_14_8, var_14_0.height - 53))
		}

		var_14_4[iter_14_0]:addChild(var_14_9[iter_14_0])

		var_14_4[iter_14_0].btnHeader = arg_14_0:createHeaderBtn({}, function()
			var_14_6(iter_14_0)
		end)

		var_14_4[iter_14_0].btnHeader:setPosition(var_14_8, var_14_0.height - 55)
		var_14_4[iter_14_0]:addChild(var_14_4[iter_14_0].btnHeader)

		var_14_4[iter_14_0].labelServer = addLabelWithColorSize(var_14_4[iter_14_0], string.lf(""), ccc3(238, 180, 34), 18, ccp(0.5, 1), ccp(var_14_8, var_14_0.height - 53 - 45))
		var_14_4[iter_14_0].labelName = addLabelWithColorSize(var_14_4[iter_14_0], string.lf(""), ccc3(238, 180, 34), 18, ccp(0.5, 1), ccp(var_14_8, var_14_0.height - 53 - 65))
		var_14_4[iter_14_0].labelKillScore = addLabelWithColorSize(var_14_4[iter_14_0], string.lf(""), ccc3(255, 228, 0), 18, ccp(0.5, 1), ccp(var_14_8, var_14_0.height - 53 - 85))

		var_14_4[iter_14_0]:setVisible(false)
	end

	function var_14_1.setInfo(arg_17_0, arg_17_1, arg_17_2)
		if not var_14_4[arg_17_1] then
			return
		end

		if not arg_17_2 then
			var_14_5[arg_17_1] = nil

			var_14_4[arg_17_1]:setVisible(false)
		else
			var_14_5[arg_17_1] = arg_17_2

			var_14_4[arg_17_1]:setVisible(true)

			local var_17_0 = arg_17_2.PlayerHeadId or 401

			if var_17_0 == 0 then
				var_17_0 = 401
			end

			local var_17_1 = getItemHeaderImagePath(ItemType.eHero, var_17_0)

			if var_17_1 then
				var_14_4[arg_17_1].btnHeader:setBackgroundSprite(var_17_1)
			end

			var_14_4[arg_17_1].labelServer:setString(string.format("[%s]", arg_17_2.ServerName))
			var_14_4[arg_17_1].labelName:setString(string.format("%s", arg_17_2.PlayerName))
			var_14_4[arg_17_1].labelKillScore:setString(string.lf("#FFE400击杀数:#E4E4E4%s", arg_17_2.KillCount))
		end
	end

	return var_14_1
end

function var_0_1.createHeaderBtn(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_1.headID or 301

	if var_18_0 == 0 then
		var_18_0 = 301
	end

	local var_18_1 = CCSize(87, 87)
	local var_18_2 = CCScale9Sprite:create("ui/common/common_001.png")

	var_18_2:setPreferredSize(var_18_1)

	local var_18_3 = ui.newControlButton({
		normalImage = getItemHeaderImagePath(ItemType.eHero, var_18_0),
		clickAction = arg_18_2
	})

	var_18_3:setPosition(var_18_1.width / 2, var_18_1.height / 2)
	var_18_2:addChild(var_18_3)

	if arg_18_1.serverID == Player.serverInfo.ServerID then
		local var_18_4 = display.newSprite("uilocal/fuben/zszz_text_026.png", 10, 72)

		var_18_2:addChild(var_18_4)
	end

	function var_18_2.setBackgroundSprite(arg_19_0, arg_19_1)
		var_18_3:setBackgroundSpriteForState(CCScale9Sprite:create(arg_19_1), CCControlStateNormal)
		var_18_3:setBackgroundSpriteForState(CCScale9Sprite:create(arg_19_1), CCControlStateHighlighted)
	end

	return var_18_2
end

function var_0_1.createLeftHeaderView(arg_20_0, arg_20_1)
	return (arg_20_0:createHeaderView("ui/fuben/zszz_003.png", arg_20_1))
end

function var_0_1.createRightHeaderView(arg_21_0, arg_21_1)
	return (arg_21_0:createHeaderView("ui/fuben/zszz_002.png", arg_21_1))
end

function var_0_1.createHeaderView(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0:getImageSize(arg_22_1)
	local var_22_1 = display.newSprite(arg_22_1, var_22_0.width * Adapter.MinScale / 2, var_22_0.height * Adapter.MinScale / 2)

	var_22_1:setScale(Adapter.MinScale)

	local var_22_2 = CCClippingRegionNode:create(CCRect(0, 0, var_22_0.width * Adapter.MinScale, var_22_0.height * Adapter.MinScale))

	var_22_2:addChild(var_22_1)

	local var_22_3 = {}
	local var_22_4 = {
		[0] = 570,
		405,
		250,
		95,
		-50
	}
	local var_22_5 = var_22_0.width / 2

	function var_22_2.createHeader(arg_23_0, arg_23_1)
		local var_23_0 = display.newNode()

		if arg_23_1.result == var_0_2.eEmpty then
			newHeader = display.newSprite("uilocal/fuben/zszz_text_034.png")
			newHeader.headerInfo = arg_23_1

			var_23_0:addChild(newHeader)
		else
			local var_23_1 = arg_22_0:createHeaderBtn(arg_23_1)

			var_23_0:addChild(var_23_1)

			local var_23_2 = addLabelWithColorSize(var_23_0, string.format("[%s]%s", arg_23_1.serverName, arg_23_1.playerName), ccc3(238, 180, 34), 18, ccp(0.5, 1), ccp(0, -45))
			local var_23_3 = addLabelWithColorSize(var_23_0, string.lf("战斗力:#F4F4F4%s(#00FF00%s%%#F4F4F4  )", arg_23_1.power, arg_23_1.addtion), ccc3(255, 228, 0), 18, ccp(0.5, 1), ccp(0, -65)):getContentSize()
			local var_23_4 = display.newSprite("ui/fuben/zszz_008.png", var_23_3.width / Adapter.MinScale / 2 - 12, -60)

			var_23_4:setAnchorPoint(ccp(0.5, 1))
			var_23_0:addChild(var_23_4)
		end

		var_23_0.headerInfo = arg_23_1

		return var_23_0
	end

	local function var_22_6()
		if var_22_3[1] and not var_22_3[1].headerInfo then
			table.remove(var_22_3, 1)

			return var_22_6()
		end
	end

	function var_22_2.pushHeader(arg_25_0, arg_25_1, arg_25_2)
		local var_25_0

		if arg_25_1 then
			var_22_6()

			var_25_0 = arg_25_0:createHeader(arg_25_1)
		else
			var_25_0 = display.newNode()
		end

		var_25_0:setPosition(var_22_5, var_22_4[4])
		var_22_1:addChild(var_25_0)

		arg_25_2 = arg_25_2 or 0.6

		local var_25_1 = #var_22_3

		if var_25_1 >= 3 then
			for iter_25_0 = 2, 3 do
				var_22_3[iter_25_0]:stopAllActions()
				transition.execute(var_22_3[iter_25_0], CCMoveTo:create(arg_25_2, ccp(var_22_5, var_22_4[iter_25_0 - 1])))
			end

			arg_22_2(var_22_3[1])
			table.remove(var_22_3, 1)
			var_25_0:stopAllActions()
			transition.execute(var_25_0, CCMoveTo:create(arg_25_2, ccp(var_22_5, var_22_4[3])))
		else
			var_25_0:setPosition(var_22_5, var_22_4[#var_22_3 + 1])
		end

		table.insert(var_22_3, var_25_0)

		return var_25_1 + 1
	end

	function var_22_2.isEmpty()
		var_22_6()

		return #var_22_3 == 0
	end

	return var_22_2
end

function var_0_1.createCenterView(arg_27_0)
	local var_27_0 = display.newNode()
	local var_27_1 = {}
	local var_27_2 = {}

	var_27_1.node = display.newNode()

	var_27_0:addChild(var_27_1.node)
	var_27_1.node:setPosition(-120, 0)

	var_27_2.node = display.newNode()

	var_27_0:addChild(var_27_2.node)
	var_27_2.node:setPosition(120, 0)

	var_27_1.ready, var_27_2.ready = false, false

	local function var_27_3()
		if var_27_1.ready == false or var_27_2.ready == false then
			return
		end

		var_27_1.ready, var_27_2.ready = false, false

		arg_27_0:fight(var_27_1, var_27_2)
	end

	var_27_0.eLeftHero = 1
	var_27_0.eRightHero = 2

	local function var_27_4(arg_29_0, arg_29_1)
		local var_29_0
		local var_29_1

		if arg_29_0.headID == 0 then
			var_29_0 = display.newSprite("uilocal/fuben/zszz_text_034.png")
			var_29_1 = var_0_2.eEmpty
		else
			local var_29_weapon = arg_29_0.weaponId or arg_29_0.WeaponId

			if not var_29_weapon or var_29_weapon == 0 then
				var_29_weapon = getHeroGroupWeaponId(arg_29_0.headID or 306)
			end

			var_29_0 = figure.createHero({
				scale = 0.7,
				isViewQuality = false,
				platTable = false,
				figId = arg_29_0.headID or 306,
				equipId = var_29_weapon,
				pinjie = arg_29_0.pinJie or arg_29_0.PinJie or EquipPinjieType.eShengPin,
				rebirthCount = arg_29_0.rebirthCount or arg_29_0.BreakthroughCount or 0
			})

			var_29_0:setContentSize(CCSize(150, 220))
			var_29_0:setAnchorPoint(ccp(0.2, 0.5))

			var_29_1 = arg_29_0.result
		end

		local var_29_2

		if arg_29_1 == var_27_0.eLeftHero then
			var_29_2 = var_27_1
		elseif arg_29_1 == var_27_0.eRightHero then
			var_29_0:setRotationY(180)

			var_29_2 = var_27_2
		end

		if not tolua.isnull(var_29_2.hero) then
			var_29_2.hero:removeFromParentAndCleanup(true)
		end

		var_29_2.hero = var_29_0
		var_29_2.info = arg_29_0
		var_29_2.result = var_29_1

		var_29_2.node:addChild(var_29_2.hero)

		var_29_2.ready = true

		var_27_3()
	end

	function var_27_0.setLeftHero(arg_30_0, arg_30_1, arg_30_2)
		var_27_4(arg_30_1, var_27_0.eLeftHero)
	end

	function var_27_0.setRightHero(arg_31_0, arg_31_1, arg_31_2)
		var_27_4(arg_31_1, var_27_0.eRightHero)
	end

	var_27_0.leftNode = var_27_1.node
	var_27_0.rightNode = var_27_2.node

	return var_27_0
end

function var_0_1.createBottomFightInfoView(arg_32_0)
	local var_32_0 = arg_32_0:getImageSize("ui/fuben/zszz_004.png")
	local var_32_1 = CCSize(var_32_0.width * Adapter.WidthScale / Adapter.MinScale, var_32_0.height * Adapter.HeightScale / Adapter.MinScale)
	local var_32_2 = display.newScale9Sprite("ui/fuben/zszz_004.png", 0, 0, CCSize(var_32_1.width + 4, var_32_1.height + 4))

	var_32_2.dataSrc = {}

	local var_32_3 = 52

	local function var_32_4()
		return var_32_3, var_32_1.width
	end

	local function var_32_5()
		return #var_32_2.dataSrc
	end

	local function var_32_6(arg_35_0, arg_35_1)
		local var_35_0 = arg_35_1 + 1
		local var_35_1 = arg_35_0:cellAtIndex(arg_35_1)

		if var_35_1 == nil then
			var_35_1 = CCTableViewCell:new()
		end

		var_35_1:removeAllChildrenWithCleanup(true)

		local var_35_2 = var_32_2.dataSrc[#var_32_2.dataSrc - arg_35_1]

		if type(var_35_2) == "string" then
			local var_35_3 = addLabelWithColorSize(var_35_1, var_35_2, ccc3(238, 180, 34), 18, ccp(0, 0), ccp(0, 0))

			var_35_3:setHorizontalAlignment(kCCTextAlignmentLeft)
			var_35_3:setDimensions(CCSize(var_32_1.width - 5, var_32_3 - 2))
		end

		return var_35_1
	end

	local var_32_7 = CCTableView:create(var_32_1)

	var_32_7:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_32_7:setDirection(kCCScrollViewDirectionVertical)
	var_32_7:registerScriptHandler(var_32_4, CCTableView.kTableCellSizeForIndex)
	var_32_7:registerScriptHandler(var_32_5, CCTableView.kNumberOfCellsInTableView)
	var_32_7:registerScriptHandler(var_32_6, CCTableView.kTableCellSizeAtIndex)
	var_32_7:setPosition(2, 2)
	var_32_2:addChild(var_32_7)

	local var_32_8

	function var_32_2.insertMsg(arg_36_0, arg_36_1)
		table.insert(arg_36_0.dataSrc, arg_36_1)

		var_32_8 = var_32_7:getContentOffset()

		var_32_7:reloadData()

		if var_32_8.y == var_32_1.height - var_32_3 * (#arg_36_0.dataSrc - 1) then
			var_32_7:setContentOffset(ccp(0, var_32_1.height - var_32_3 * #arg_36_0.dataSrc))
		else
			var_32_7:setContentOffset(var_32_8)
		end
	end

	function var_32_2.setMsg(arg_37_0, arg_37_1)
		arg_37_0.dataSrc = arg_37_1

		var_32_7:reloadData()
		var_32_7:setContentOffset(ccp(0, var_32_1.height - var_32_3 * #arg_37_0.dataSrc))
	end

	function var_32_2.cleanMsg(arg_38_0)
		arg_38_0:setMsg({})
	end

	var_32_7:reloadData()

	return var_32_2
end

function var_0_1.getImageSize(arg_39_0, arg_39_1)
	return CCTextureCache:sharedTextureCache():addImage(arg_39_1):getContentSizeInPixels()
end

function var_0_1.shadeScene(arg_40_0)
	local function var_40_0(arg_41_0, arg_41_1)
		local var_41_0 = -arg_41_1
		local var_41_1, var_41_2 = arg_41_0:getPosition()
		local var_41_3 = CCArray:create()

		var_41_3:addObject(CCMoveBy:create(0.02, ccp(arg_41_1, arg_41_1)))
		var_41_3:addObject(CCMoveBy:create(0.02, ccp(var_41_0, var_41_0)))
		var_41_3:addObject(CCMoveBy:create(0.02, ccp(arg_41_1, var_41_0)))
		var_41_3:addObject(CCMoveBy:create(0.02, ccp(var_41_0, arg_41_1)))
		arg_41_0:stopAllActions()
		arg_41_0:runAction(CCSequence:create(var_41_3))
	end

	local var_40_1 = math.random(2, 7) * Adapter.MinScale

	var_40_0(arg_40_0, var_40_1)
end

function var_0_1.heroAttack(arg_42_0, arg_42_1, arg_42_2)
	arg_42_1.Skeleton:setToSetupPose()
	arg_42_1.Skeleton:setAnimation("putong", false, 0)

	if arg_42_2 then
		arg_42_1.Skeleton:addAnimationAction("putong", 1, CCCallFunc:create(arg_42_2), AAT_Percent)
	end
end

function var_0_1.heroWait(arg_43_0, arg_43_1)
	arg_43_1.Skeleton:setToSetupPose()
	arg_43_1.Skeleton:setAnimation("daiji", true, 0)
end

function var_0_1.fight(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = CCArray:create()
	local var_44_1 = CCArray:create()

	if arg_44_1.result ~= var_0_2.eEmpty and arg_44_2.result ~= var_0_2.eEmpty then
		var_44_0:addObject(CCEaseOut:create(CCMoveTo:create(0.2, ccp(120, 0)), 1.35))
		var_44_1:addObject(CCEaseOut:create(CCMoveTo:create(0.2, ccp(-120, 0)), 1.35))
		var_44_0:addObject(CCCallFunc:create(handler(arg_44_0, arg_44_0.shadeScene)))
		var_44_0:addObject(CCCallFunc:create(function()
			arg_44_0:heroAttack(arg_44_1.hero, function()
				arg_44_0:heroWait(arg_44_1.hero)
			end)
		end))
		var_44_1:addObject(CCCallFunc:create(function()
			arg_44_0:heroAttack(arg_44_2.hero, function()
				arg_44_0:heroWait(arg_44_2.hero)
			end)
		end))
		var_44_0:addObject(CCMoveTo:create(0.08, ccp(70, 0)))
		var_44_1:addObject(CCMoveTo:create(0.08, ccp(-70, 0)))
		var_44_0:addObject(CCDelayTime:create(0.32))
		var_44_1:addObject(CCDelayTime:create(0.32))
	end

	var_44_0:addObject(CCCallFunc:create(function()
		arg_44_0.mBottomInfoView:insertMsg(arg_44_0:makeMsg(arg_44_1, arg_44_2))
	end))

	local function var_44_2(arg_50_0, arg_50_1, arg_50_2)
		if arg_50_0.result == var_0_2.eSuccess then
			arg_50_1:addObject(CCCallFunc:create(function()
				arg_44_0:setResultSprite(arg_50_0.hero, arg_50_0.result, arg_50_2)
			end))
			arg_50_1:addObject(CCDelayTime:create(0.4))

			local var_50_0

			if arg_50_2 then
				var_50_0 = ccp(-arg_44_0.mContainerSize.width / 2 - 20, 0)
			else
				var_50_0 = ccp(arg_44_0.mContainerSize.width / 2, 0)
			end

			arg_50_1:addObject(CCEaseOut:create(CCMoveTo:create(1.3, var_50_0), 0.25))
			arg_50_1:addObject(CCDelayTime:create(0.2))
			arg_50_1:addObject(CCCallFunc:create(handler(arg_44_0, arg_44_0.onFightActionEnd)))
		elseif arg_50_0.result == var_0_2.eFailed then
			local var_50_1 = CCArray:create()
			local var_50_2
			local var_50_3

			if arg_50_2 then
				var_50_2 = -1800
				var_50_3 = ccp(-350, 350)
			else
				var_50_2 = 1800
				var_50_3 = ccp(350, 350)
			end

			var_50_1:addObject(CCRotateBy:create(1.3, var_50_2))
			var_50_1:addObject(CCScaleTo:create(1.3, 0))
			var_50_1:addObject(CCEaseOut:create(CCMoveTo:create(1.3, var_50_3), 1.6))
			arg_50_1:addObject(CCSpawn:create(var_50_1))
		else
			arg_50_1:addObject(CCDelayTime:create(0.4))
			arg_50_1:addObject(CCFadeOut:create(1.3))
		end
	end

	var_44_2(arg_44_1, var_44_0, true)
	var_44_2(arg_44_2, var_44_1, false)
	transition.execute(arg_44_1.hero, CCSequence:create(var_44_0), {
		delay = 0.5
	})
	transition.execute(arg_44_2.hero, CCSequence:create(var_44_1), {
		delay = 0.5
	})
end

function var_0_1.setResultSprite(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	local var_52_0 = {
		[1] = "uilocal/fuben/zszz_text_006.png"
	}

	if arg_52_2 ~= var_0_2.eSuccess then
		return
	end

	local var_52_1 = display.newSprite(var_52_0[arg_52_2])

	var_52_1:setScale(6)

	if not arg_52_3 then
		var_52_1:setPosition(-150, 380)
		var_52_1:setRotationY(-180)
		var_52_1:setAnchorPoint(ccp(0.2, 0.5))
	else
		var_52_1:setPosition(150, 380)
		var_52_1:setAnchorPoint(ccp(0.8, 0.5))
	end

	arg_52_1:addChild(var_52_1, 1)

	local var_52_2 = CCArray:create()

	var_52_2:addObject(CCScaleTo:create(0.2, 2))
	var_52_2:addObject(CCMoveTo:create(0.2, ccp(0, 260)))
	transition.execute(var_52_1, CCSpawn:create(var_52_2), {
		onComplete = handler(arg_52_0, arg_52_0.shadeScene)
	})
end

function var_0_1.pushHeaderHelper(arg_53_0, arg_53_1)
	local var_53_0
	local var_53_1

	if arg_53_1 then
		var_53_0 = {
			serverID = arg_53_1.AttackServerId,
			serverName = arg_53_1.AttackServerName,
			playerName = arg_53_1.AttackPlayerName,
			headID = arg_53_1.AttackPlayerHeadId,
			power = arg_53_1.AttackTotalPower,
			addtion = arg_53_1.AttackEncouragingAddition,
			scoreGet = arg_53_1.KillCountChange,
			addtionLose = arg_53_1.PropertyChange
		}
		var_53_1 = {
			serverID = arg_53_1.DefendServerId,
			serverName = arg_53_1.DefendServerName,
			playerName = arg_53_1.DefendPlayerName,
			headID = arg_53_1.DefendPlayerHeadId,
			power = arg_53_1.DefendTotalPower,
			addtion = arg_53_1.DefendEncouragingAddition,
			scoreGet = arg_53_1.KillCountChange,
			addtionLose = arg_53_1.PropertyChange
		}
		var_53_0.result = arg_53_1.IsWin > 0 and var_0_2.eSuccess or var_0_2.eFailed
		var_53_1.result = arg_53_1.IsWin > 0 and var_0_2.eFailed or var_0_2.eSuccess

		if var_53_0.headID == 0 then
			var_53_0.result = var_0_2.eEmpty
			var_53_1.result = var_0_2.eSuccess
		end

		if var_53_1.headID == 0 then
			var_53_1.result = var_0_2.eEmpty
			var_53_0.result = var_0_2.eSuccess
		end
	end

	local var_53_2 = arg_53_0.mLeftView:pushHeader(var_53_0)

	arg_53_0.mRightView:pushHeader(var_53_1)

	if var_53_2 < 4 then
		print("cntOnView", var_53_2)
		arg_53_0:onFightActionEnd()
	end
end

function var_0_1.makeMsg(arg_54_0, arg_54_1, arg_54_2)
	if arg_54_1.result == var_0_2.eSuccess and arg_54_2.result ~= var_0_2.eEmpty then
		return string.lf("#EEB322[%s]%s#00FF00击杀了#EEB322[%s]%s#00FF00获得#FFE300%d点#00FF00击杀数,属性下降#FF0000%d%%", arg_54_1.info.serverName, arg_54_1.info.playerName, arg_54_2.info.serverName, arg_54_2.info.playerName, arg_54_1.info.scoreGet, arg_54_1.info.addtionLose)
	elseif arg_54_1.result == var_0_2.eFailed then
		return string.lf("#EEB322[%s]%s#00FF00被#EEB322[%s]%s#00FF00击杀,#EEB322[%s]%s#00FF00获得#FFE300%d点#00FF00击杀数,属性下降#FF0000%d%%", arg_54_1.info.serverName, arg_54_1.info.playerName, arg_54_2.info.serverName, arg_54_2.info.playerName, arg_54_2.info.serverName, arg_54_2.info.playerName, arg_54_2.info.scoreGet, arg_54_2.info.addtionLose)
	elseif arg_54_1.result == var_0_2.eEmpty then
		return string.lf("#EEB322[%s]%s#00FF00实在太幸运了,在小角落没有被人发现", arg_54_2.info.serverName, arg_54_2.info.playerName)
	elseif arg_54_2.result == var_0_2.eEmpty then
		return string.lf("#EEB322[%s]%s#00FF00实在太幸运了,在小角落没有被人发现", arg_54_1.info.serverName, arg_54_1.info.playerName)
	end
end

function var_0_1.enableView(arg_55_0, arg_55_1)
	arg_55_0.mTop3RankView:setVisible(arg_55_1)
	arg_55_0.mBtnReport:setVisible(arg_55_1)
end

function var_0_1.onBtnMyFightReportClicked(arg_56_0)
	local var_56_0 = require("scenes.fuben.ZSZZPlayerBattleInfoLayer").new({
		from = "ZSZZFightScene",
		type = arg_56_0.mMyType,
		pageType = arg_56_0.mparams.pageTypein
	})

	arg_56_0:addChild(var_56_0)
end

function var_0_1.onBtnMoreRankClicked(arg_57_0)
	arg_57_0:requestRankInfo(arg_57_0.mHomeInfo.Type)
end

function var_0_1.onFightActionEnd(arg_58_0)
	if not arg_58_0.mLeftView:isEmpty() then
		local var_58_0 = arg_58_0.mHomeInfo.CsbattleLogInfo[1]

		if arg_58_0.mHomeInfo.CsbattleLogInfo[1] then
			table.remove(arg_58_0.mHomeInfo.CsbattleLogInfo, 1)
		else
			print("pushing empty info")
		end

		arg_58_0:pushHeaderHelper(var_58_0)
	elseif arg_58_0.mShowingTop32Record == true then
		showFlashNotice(string.lf("战斗回放结束"))
	else
		arg_58_0:requestHomeInfo()
	end
end

function var_0_1.requestHomeInfo(arg_59_0)
	if not arg_59_0.mGetHomeInfoRequest then
		arg_59_0.mGetHomeInfoRequest = ZSZZGetFightHomeInfoRequest:new()

		local function var_59_0()
			arg_59_0:onResponseHomeInfo(arg_59_0.mGetHomeInfoRequest.restable)
		end

		arg_59_0.mGetHomeInfoRequest:setResponseNormalHandler(var_59_0)
		arg_59_0.mGetHomeInfoRequest:setResponseExceptionHandler(function(arg_61_0)
			if arg_61_0 == NetworkState.ZSZZBattleFailed then
				arg_59_0.mLeftView:setVisible(false)
				arg_59_0.mRightView:setVisible(false)
				arg_59_0.mMyFightInfoView:setVisible(false)
				arg_59_0.mBottomInfoView:setVisible(false)
				arg_59_0.EndSprite:setVisible(true)
			end
		end)
	end

	arg_59_0.mGetHomeInfoRequest:request()
end

function var_0_1.requestTop32Info(arg_62_0, arg_62_1)
	if not arg_62_0.mTop32InfoRequest then
		arg_62_0.mTop32InfoRequest = ZSZZGetTop32InfoRequest:new()

		local function var_62_0()
			arg_62_0:onResponseHomeInfo(arg_62_0.mTop32InfoRequest.restable, arg_62_0.mTop32InfoRequest.lastRequestType)
		end

		arg_62_0.mTop32InfoRequest:setResponseNormalHandler(var_62_0)
	end

	arg_62_0.mTop32InfoRequest.lastRequestType = arg_62_1

	arg_62_0.mTop32InfoRequest:request(arg_62_1)
end

function var_0_1.onResponseHomeInfo(arg_64_0, arg_64_1)
	arg_64_0.mHomeInfo = arg_64_1
	arg_64_0.mMyType = arg_64_0.mMyType or arg_64_0.mHomeInfo.Type

	arg_64_0:enableView(true)
	arg_64_0.mMyFightInfoView:setInfo(arg_64_1.MyCsbattleInfo)

	for iter_64_0 = 1, 3 do
		arg_64_0.mTop3RankView:setInfo(iter_64_0, arg_64_1.CsbattleRankInfo[iter_64_0])
	end

	arg_64_1.CsbattleLogInfo = arg_64_1.CsbattleLogInfo or {}

	if #arg_64_1.CsbattleLogInfo > 0 then
		local var_64_0 = arg_64_1.CsbattleLogInfo[1]

		table.remove(arg_64_1.CsbattleLogInfo, 1)
		arg_64_0:pushHeaderHelper(var_64_0)
	else
		arg_64_0.mLeftView:setVisible(false)
		arg_64_0.mRightView:setVisible(false)
		arg_64_0.mMyFightInfoView:setVisible(false)
		arg_64_0.mBottomInfoView:setVisible(false)
		arg_64_0.EndSprite:setVisible(true)
	end
end

function var_0_1.requestRankInfo(arg_65_0, arg_65_1)
	if not arg_65_0.mMoreRankRequest then
		arg_65_0.mMoreRankRequest = ZSZZGetMoreRankRequest:new()

		local function var_65_0()
			arg_65_0:onResponseRankInfo(arg_65_0.mMoreRankRequest.restable)
		end

		arg_65_0.mMoreRankRequest:setResponseNormalHandler(var_65_0)
	end

	if arg_65_0.mShowingTop32Record then
		arg_65_0:onResponseRankInfo(arg_65_0.mHomeInfo.CsbattleRankInfo)
	else
		arg_65_0.mMoreRankRequest:request(arg_65_1)
	end
end

function var_0_1.onResponseRankInfo(arg_67_0, arg_67_1)
	print(arg_67_0.mparams.pageTypein)

	local var_67_0 = require("scenes.fuben.ZSZZMoreRankLayer").new({
		type = arg_67_0.mHomeInfo.Type,
		rankData = arg_67_1,
		pageType = arg_67_0.mparams.pageTypein
	})

	arg_67_0:addChild(var_67_0)
end

return var_0_1
