require("data.player")
require("base.figure")
require("scenes.team.OthersTeamHelper")

local var_0_0 = require("framework.scheduler")
local var_0_1 = class("ZSZZHomeScene", function()
	return display.newScene("ZSZZHomeScene")
end)
local var_0_2 = {
	eButtonLand = 1,
	eButtonDemon = 2,
	eButtonHeaven = 3
}

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0.mParams = arg_2_1 or {}
	arg_2_0.sceneLeftButtonList = {}
	arg_2_0.sceneRightButtonList = {}
	arg_2_0.mCDTimerFunctions = {}

	if Player.level < 40 then
		arg_2_0.worldType = arg_2_1 and arg_2_1.worldType or MasterType.eLand
	elseif Player.level < 70 and Player.level > 39 then
		arg_2_0.worldType = arg_2_1 and arg_2_1.worldType or MasterType.eDemon
	elseif Player.level > 69 then
		arg_2_0.worldType = arg_2_1 and arg_2_1.worldType or MasterType.eHeaven
	end

	arg_2_0:setUI()
	arg_2_0:setTimer()
	arg_2_0:requestBasePlayInfo()
end

function var_0_1.setUI(arg_3_0)
	local var_3_0 = arg_3_0:getImageSize("ui/fuben/zszz_000.jpg")
	local var_3_1 = display.newSprite("ui/fuben/zszz_000.jpg", display.cx, display.cy)

	var_3_1:setScaleX(display.width / var_3_0.width)
	var_3_1:setScaleY(display.height / var_3_0.height)
	arg_3_0:addChild(var_3_1)

	local var_3_2 = CCSizeMake(display.width / Adapter.MinScale, display.height / Adapter.MinScale)
	local var_3_3 = display.newNode()

	var_3_3:setContentSize(var_3_2)
	var_3_3:setAnchorPoint(ccp(0, 0))
	var_3_3:setScale(Adapter.MinScale)
	arg_3_0:addChild(var_3_3)

	arg_3_0.mContainer = var_3_3
	arg_3_0.mContainerSize = var_3_2
	arg_3_0.headlable = addLabelWithColorSize(var_3_3, string.lf("诸神之战开战前，本服玩家可以花费元宝用于提升对应道的本服种子选手的属性，只要种子选手进入人头榜的前10，则所有鼓舞的玩家均可以获得大量银币奖励，否则只能获得保底奖励！"), ccc3(61, 61, 61), 18, ccp(0.5, 1), ccp(var_3_2.width / 2 - 50, var_3_2.height - 10))

	arg_3_0.headlable:setDimensions(CCSize(var_3_2.width - 150, 100))

	local var_3_4 = handler(arg_3_0, arg_3_0.buttonClickAction)

	arg_3_0.leftbuttonTable = {
		{
			normalImage = "ui/worldmap/worldmap_009.png",
			tag = 1,
			position = ccp(60, var_3_2.height - 320),
			nameText = string.lf("人界"),
			clickAction = var_3_4
		},
		{
			normalImage = "ui/worldmap/worldmap_008.png",
			tag = 2,
			position = ccp(60, var_3_2.height - 430),
			nameText = string.lf("地界"),
			clickAction = var_3_4
		},
		{
			normalImage = "ui/worldmap/worldmap_010.png",
			tag = 3,
			position = ccp(60, var_3_2.height - 540),
			nameText = string.lf("天界"),
			clickAction = var_3_4
		}
	}

	function arg_3_0.showFlashLight(arg_4_0, arg_4_1)
		if not arg_4_0.mFlashLightSprite then
			display.addSpriteFramesWithFile("ui/map/ui_baoxiang.plist", "ui/map/ui_baoxiang.png")

			local var_4_0 = display.newSprite("#ui_baoxiang_01.png")
			local var_4_1 = display.newFrames("ui_baoxiang_0%d.png", 1, 5)
			local var_4_2 = display.newAnimation(var_4_1, 0.1)

			var_4_0:runAction(CCRepeatForever:create(CCAnimate:create(var_4_2)))
			var_3_3:addChild(var_4_0, 1)

			arg_4_0.mFlashLightSprite = var_4_0
		end

		if arg_4_1 == MasterType.eLand then
			arg_4_0.mFlashLightSprite:setPosition(arg_4_0.leftbuttonTable[1].position)
		elseif arg_4_1 == MasterType.eDemon then
			arg_4_0.mFlashLightSprite:setPosition(arg_4_0.leftbuttonTable[2].position)
		elseif arg_4_1 == MasterType.eHeaven then
			arg_4_0.mFlashLightSprite:setPosition(arg_4_0.leftbuttonTable[3].position)
		else
			arg_4_0.mFlashLightSprite:setPosition(-20, -200)
		end
	end

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.leftbuttonTable) do
		local var_3_5 = ui.newControlButton(iter_3_1)

		var_3_5:setTag(iter_3_1.tag)
		var_3_3:addChild(var_3_5)
		table.insert(arg_3_0.sceneLeftButtonList, var_3_5)

		if iter_3_1.nameText then
			addLabelWithColorSize(var_3_5, iter_3_1.nameText, ccc3(219, 219, 112), 20, ccp(0.5, 0.5), ccp(46, 0), _FONT_LISU)
		end
	end

	arg_3_0.rightbuttonTable = {
		{
			normalImage = "uilocal/fuben/zszz_text_004.png",
			tag = 1,
			position = ccp(var_3_2.width - 60, var_3_2.height - 140),
			clickAction = handler(arg_3_0, arg_3_0.onGetKillListBtnClicked)
		},
		{
			normalImage = "uilocal/fuben/zszz_text_002.png",
			tag = 2,
			position = ccp(var_3_2.width - 60, var_3_2.height - 340),
			clickAction = handler(arg_3_0, arg_3_0.onEnterGableBtnClicked)
		},
		{
			normalImage = "uilocal/fuben/zszz_text_003.png",
			tag = 3,
			position = ccp(var_3_2.width - 60, var_3_2.height - 440),
			clickAction = handler(arg_3_0, arg_3_0.onGetRewardBtnClicked)
		},
		{
			normalImage = "uilocal/fuben/zszz_text_043.png",
			tag = 4,
			position = ccp(var_3_2.width - 60, var_3_2.height - 240),
			clickAction = handler(arg_3_0, arg_3_0.onTop32InfoViewBtnClicked)
		}
	}

	for iter_3_2, iter_3_3 in ipairs(arg_3_0.rightbuttonTable) do
		local var_3_6 = ui.newControlButton(iter_3_3)

		var_3_6:setTag(iter_3_3.tag)
		var_3_3:addChild(var_3_6, 1)
		table.insert(arg_3_0.sceneRightButtonList, var_3_6)
	end

	arg_3_0.notStart = display.newSprite("uilocal/fuben/zszz_text_019.png")

	arg_3_0.notStart:setPosition(var_3_2.width / 2 + 20, 60)
	var_3_3:addChild(arg_3_0.notStart)
	arg_3_0.notStart:setVisible(true)

	arg_3_0.inspireButton = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/fuben/zszz_text_020.png",
		position = ccp(var_3_2.width / 2 + 20, 60),
		clickAction = function()
			arg_3_0:onInspireBtnClicked(arg_3_0.worldType)
		end
	})

	var_3_3:addChild(arg_3_0.inspireButton)
	arg_3_0.inspireButton:setVisible(false)

	arg_3_0.startBattleButton = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/fuben/zszz_text_021.png",
		position = ccp(var_3_2.width / 2 + 20, 60),
		clickAction = function()
			arg_3_0:OnStartBattleClicked()
		end
	})

	var_3_3:addChild(arg_3_0.startBattleButton)
	arg_3_0.startBattleButton:setVisible(false)

	arg_3_0.inspireRuleButton = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/fuben/zszz_text_018.png",
		position = ccp(100, var_3_2.height - 210),
		clickAction = handler(arg_3_0, arg_3_0.onDuelRulesBtnClicked)
	})

	var_3_3:addChild(arg_3_0.inspireRuleButton)

	arg_3_0.inspireRecordButton = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/fuben/zszz_text_017.png",
		position = ccp(100, var_3_2.height - 160),
		clickAction = function()
			arg_3_0:onGetInspireRecordBtnClicked(arg_3_0.worldType)
		end
	})

	var_3_3:addChild(arg_3_0.inspireRecordButton)

	local var_3_7 = display.newSprite("ui/fuben/zszz_010.png", 110, var_3_2.height - 85)
	local var_3_8 = display.newSprite("ui/fuben/zszz_010.png", 110, var_3_2.height - 120)

	var_3_3:addChild(var_3_7)
	var_3_3:addChild(var_3_8)

	arg_3_0._curinspireCountLabel = addLabelWithColorSize(var_3_7, string.lf("当前鼓舞人数:0"), ccc3(255, 255, 255), 18, ccp(1, 1), ccp(180, 29))
	arg_3_0._curinspireAddLabel = addLabelWithColorSize(var_3_8, string.lf("当前鼓舞加成:0"), ccc3(255, 255, 255), 18, ccp(1, 1), ccp(200, 29))

	local var_3_9 = ccp(var_3_2.width / 2 + 40, var_3_2.height - 110)
	local var_3_10 = display.newSprite("ui/fuben/zszz_009.png", var_3_9.x, var_3_9.y)

	var_3_10:setScaleY(0.4)
	var_3_3:addChild(var_3_10)
	addLabelWithColorSize(var_3_3, string.lf("本服务器有玩家进入人头榜前三，全服都可获得一个【诸神礼包】"), ccc3(118, 238, 0), 18, ccp(0.5, 0.5), var_3_9)

	local var_3_11 = ui.newControlButton({
		normalImage = "ui/common/common_061.png",
		position = ccp(var_3_2.width - 70, var_3_2.height - 40),
		clickAction = handler(arg_3_0, arg_3_0.closeAction)
	})

	var_3_3:addChild(var_3_11)

	arg_3_0.mRemainTime = arg_3_0:createRemainTime()

	var_3_3:addChild(arg_3_0.mRemainTime)
	arg_3_0:placePillar()

	arg_3_0.myOb = arg_3_0:place3Persons()

	var_3_3:addChild(arg_3_0.myOb)
end

function var_0_1.createRemainTime(arg_8_0)
	local var_8_0 = display.newNode()
	local var_8_1 = display.newNode()
	local var_8_2 = display.newNode()
	local var_8_3 = display.newSprite("uilocal/fuben/zszz_text_022.png")
	local var_8_4 = display.newSprite("uilocal/fuben/zszz_text_023.png")

	var_8_1:addChild(var_8_4)
	var_8_2:addChild(var_8_3)
	var_8_0:addChild(var_8_1)
	var_8_0:addChild(var_8_2)
	var_8_1:setPosition(arg_8_0.mContainerSize.width / 2 + 30, arg_8_0.mContainerSize.height - 160)
	var_8_2:setPosition(arg_8_0.mContainerSize.width / 2 - 60, arg_8_0.mContainerSize.height - 160)
	var_8_1:setVisible(false)
	var_8_2:setVisible(false)

	function var_8_0.setBackGround(arg_9_0, arg_9_1)
		if arg_9_1 == 1 then
			var_8_1:setVisible(true)
			var_8_2:setVisible(false)
		elseif arg_9_1 == 2 or arg_9_1 == 3 then
			var_8_1:setVisible(false)
			var_8_2:setVisible(true)
		elseif arg_9_1 == 4 then
			var_8_1:setVisible(false)
			var_8_2:setVisible(false)
		end
	end

	local var_8_5 = addLabelWithColorSize(var_8_1, "", ccc3(0, 0, 0), 22, ccp(0, 0.5), ccp(-130, 0))
	local var_8_6 = addLabelWithColorSize(var_8_1, "", ccc3(0, 0, 0), 22, ccp(0, 0.5), ccp(-74, 0))
	local var_8_7 = addLabelWithColorSize(var_8_2, "", ccc3(0, 0, 0), 22, ccp(0, 0.5), ccp(125, 0))

	function var_8_0.setRemainTime(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_10_2 or -1

		local function var_10_1()
			if var_10_0 > 0 then
				var_10_0 = var_10_0 - 1

				if arg_10_1 == 1 then
					var_8_0:setBackGround(arg_10_1)

					local var_11_0 = math.floor(var_10_0 / 86400)
					local var_11_1

					if var_11_0 >= 1 then
						var_11_1 = math.floor(var_10_0 / 3600 - 24 * var_11_0)
					elseif var_11_0 < 1 then
						var_11_1 = math.ceil(var_10_0 / 3600)
					end

					if var_11_1 < 10 then
						var_8_6:setPosition(ccp(-70, 0))
					end

					var_8_5:setString(var_11_0)
					var_8_6:setString(var_11_1)
				elseif arg_10_1 == 2 then
					var_8_0:setBackGround(arg_10_1)
					var_8_7:setString(formatTime(var_10_0))
				elseif arg_10_1 == 3 then
					var_8_0:setBackGround(arg_10_1)
					var_8_7:setString(formatTime(var_10_0))
				end
			else
				var_8_0:setBackGround(arg_10_1)
				arg_8_0:dettachCDTimer(var_8_0)

				if arg_10_1 ~= 4 then
					arg_8_0:requestBasePlayInfo()
				end
			end
		end

		var_10_1()
		arg_8_0:dettachCDTimer(var_8_0)
		arg_8_0:attachCDTimer(var_8_0, var_10_1)
	end

	return var_8_0
end

function var_0_1.placePillar(arg_12_0)
	local var_12_0 = arg_12_0.mContainerSize.width / 3
	local var_12_1 = arg_12_0.mContainerSize.height / 2
	local var_12_2 = {}
	local var_12_3 = var_12_0 / 2
	local var_12_4 = display.newSprite("ui/fuben/zszz_013.png")
	local var_12_5 = display.newSprite("ui/fuben/zszz_014.png")
	local var_12_6 = display.newSprite("ui/fuben/zszz_012.png")

	var_12_4:setAnchorPoint(ccp(0.5, 0))
	var_12_4:setPosition(var_12_3 + 93, var_12_1 - 288)

	var_12_2[2] = ccp(var_12_3 + 93, var_12_1 - 188)

	local var_12_7 = var_12_3 + var_12_0

	var_12_5:setAnchorPoint(ccp(0.5, 0))
	var_12_5:setPosition(var_12_7 + 24, var_12_1 - 220)

	var_12_2[1] = ccp(var_12_7 + 24, var_12_1 - 120)

	local var_12_8 = var_12_7 + var_12_0

	var_12_6:setAnchorPoint(ccp(0.5, 0))
	var_12_6:setPosition(var_12_8 - 50, var_12_1 - 288)

	var_12_2[3] = ccp(var_12_8 - 50, var_12_1 - 188)

	arg_12_0.mContainer:addChild(var_12_4)
	arg_12_0.mContainer:addChild(var_12_6)
	arg_12_0.mContainer:addChild(var_12_5)

	arg_12_0.mPillarPos = var_12_2
end

function var_0_1.place3Persons(arg_13_0, arg_13_1)
	arg_13_1 = arg_13_1 or {}

	local var_13_0 = display.newNode()
	local var_13_1 = display.newNode()

	function var_13_0.CreateHero(arg_14_0, arg_14_1)
		local var_14_0 = {
			"ui/worldboss/worldboss_010.png",
			"ui/worldboss/worldboss_011.png",
			"ui/worldboss/worldboss_013.png",
			"ui/worldboss/worldboss_012.png"
		}
		local var_14_1 = "uilocal/worldboss/worldboss_text_004.png"

		if not tolua.isnull(var_13_1) then
			var_13_1:removeFromParent()
		end

		var_13_1 = display.newNode()

		for iter_14_0 = 1, 3 do
			local var_14_2 = false

			for iter_14_1, iter_14_2 in ipairs(arg_14_1 or {}) do
				if iter_14_2.Rank == iter_14_0 then
					local var_14_3 = iter_14_2
					local var_14_4 = figure.createHero({
						scale = 0.7,
						isViewQuality = false,
						platTable = false,
						figId = iter_14_2.HeadId,
						equipId = getHeroGroupWeaponId(iter_14_2.HeadId),
						pinjie = EquipPinjieType.eShengPin
					})

					var_14_4:setAnchorPoint(ccp(0.5, 0))
					var_14_4:setPosition(ccp(arg_13_0.mPillarPos[var_14_3.Rank].x, arg_13_0.mPillarPos[var_14_3.Rank].y + 9))
					var_13_1:addChild(var_14_4)

					arg_13_0.pos = var_14_3.Rank

					local var_14_5 = "ui/fuben/zszz_011.png"
					local var_14_6 = display.newSprite("ui/fuben/zszz_011.png")
					local var_14_7 = ui.newControlButton({
						normalImage = var_14_5,
						position = ccp(arg_13_0.mPillarPos[var_14_3.Rank].x, arg_13_0.mPillarPos[var_14_3.Rank].y - 60),
						clickAction = function()
							arg_13_0:onGetTeamBtnClicked(var_14_3)
						end
					})
					local var_14_8 = var_14_7:getContentSize()
					local var_14_9 = var_14_6:getContentSize()

					var_13_1:addChild(var_14_7)

					if var_14_3.ServerName ~= nil then
						var_14_7.PlayerLabel = addLabelWithColorSize(var_14_7, string.format("[%s]:%s", var_14_3.ServerName, var_14_3.PlayerName), ccc3(255, 255, 0), 18, ccp(0.5, 0), ccp(var_14_8.width / 2, 80))
					else
						var_14_7.PlayerLabel = addLabelWithColorSize(var_14_7, string.format("[%s]:%s", Player.serverInfo.ServerName, var_14_3.PlayerName), ccc3(255, 255, 0), 18, ccp(0.5, 0), ccp(var_14_8.width / 2, 80))
					end

					if var_14_3.UnionName == "" or var_14_3.UnionName == nil then
						var_14_7.XianMengLabel = addLabelWithColorSize(var_14_7, string.lf("散修"), ccc3(255, 127, 80), 18, ccp(0.5, 0), ccp(var_14_8.width / 2, 57))
					else
						var_14_7.XianMengLabel = addLabelWithColorSize(var_14_7, string.lf("仙盟: %s", var_14_3.UnionName), ccc3(0, 255, 0), 18, ccp(0.5, 0), ccp(var_14_8.width / 2, 57))
					end

					var_14_7.BattleLabel = addLabelWithColorSize(var_14_7, "", ccc3(255, 255, 255), 18, ccp(0, 0), ccp(var_14_8.width - 200, 28))
					var_14_7.KillValueLabel = addLabelWithColorSize(var_14_7, "", ccc3(255, 255, 255), 18, ccp(0, 0), ccp(var_14_8.width - 200, 5))

					if arg_13_0.mBaseInfo.CSBattleStatus == 1 then
						var_14_7.BattleLabel:setString(string.lf("战力: %d", var_14_3.TotalPower))
						var_14_7.KillValueLabel:setString(string.lf("击杀: %d", var_14_3.KillCount))
					elseif arg_13_0.mBaseInfo.CSBattleStatus == 2 or arg_13_0.mBaseInfo.CSBattleStatus == 3 then
						var_14_7.BattleLabel:setString(string.lf("战力: %d", var_14_3.TotalPower))
					end

					var_14_2 = true

					break
				end
			end

			if var_14_2 == false then
				local var_14_10 = display.newSprite(var_14_0[iter_14_0])

				var_14_10:setAnchorPoint(ccp(0.5, 0))
				var_14_10:setPosition(arg_13_0.mPillarPos[iter_14_0])
				var_13_1:addChild(var_14_10)

				local var_14_11 = display.newSprite(var_14_1)

				var_14_11:setAnchorPoint(ccp(0.5, 0))
				var_14_11:setPosition(ccp(arg_13_0.mPillarPos[iter_14_0].x, arg_13_0.mPillarPos[iter_14_0].y - 30))
				var_13_1:addChild(var_14_11)
			end
		end

		var_13_0:addChild(var_13_1)
	end

	return var_13_0
end

function var_0_1.refreshCountandCombat(arg_16_0, arg_16_1)
	if arg_16_1 ~= nil then
		arg_16_0._curinspireCountLabel:setString(string.lf("当前鼓舞人数:%d", arg_16_1.EncourageCount))
		arg_16_0._curinspireAddLabel:setString(string.lf("当前鼓舞加成为:%s%%", arg_16_1.PowerAddition))
		arg_16_0._curinspireAddLabel:setPosition(ccp(215, 29))
	else
		arg_16_0._curinspireCountLabel:setString(string.lf("当前鼓舞人数:0"))
		arg_16_0._curinspireAddLabel:setString(string.lf("当前鼓舞加成为:0"))
		arg_16_0._curinspireAddLabel:setPosition(ccp(200, 29))
	end
end

function var_0_1.getImageSize(arg_17_0, arg_17_1)
	return CCTextureCache:sharedTextureCache():addImage(arg_17_1):getContentSizeInPixels()
end

function var_0_1.buttonClickAction(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_2:getTag()
	local var_18_1 = arg_18_2

	if var_18_0 == var_0_2.eButtonLand then
		arg_18_0.worldType = var_0_2.eButtonLand

		arg_18_0.myOb:CreateHero(arg_18_0.heroList[var_18_0])
		arg_18_0:refreshCountandCombat(arg_18_0.InspireList[var_18_0][1])
		arg_18_0:showFlashLight(MasterType.eLand)
	elseif var_18_0 == var_0_2.eButtonDemon then
		arg_18_0.worldType = var_0_2.eButtonDemon

		arg_18_0.myOb:CreateHero(arg_18_0.heroList[var_18_0])
		arg_18_0:refreshCountandCombat(arg_18_0.InspireList[var_18_0][1])
		arg_18_0:showFlashLight(MasterType.eDemon)
	elseif var_18_0 == var_0_2.eButtonHeaven then
		arg_18_0.worldType = var_0_2.eButtonHeaven

		arg_18_0.myOb:CreateHero(arg_18_0.heroList[var_18_0])
		arg_18_0:refreshCountandCombat(arg_18_0.InspireList[var_18_0][1])
		arg_18_0:showFlashLight(MasterType.eHeaven)
	end
end

function var_0_1.onInspireBtnClicked(arg_19_0, arg_19_1)
	local var_19_0 = 0

	arg_19_0.Gold = 100

	if arg_19_0.mBaseInfo.CSBattleStatus == 3 then
		showFlashNotice(string.lf("比赛进入筹备期，无法进行鼓舞"))
	elseif arg_19_0.heroList[arg_19_1][1] == nil and arg_19_0.heroList[arg_19_1][2] == nil and arg_19_0.heroList[arg_19_1][3] == nil then
		ui.showMessageBox({
			text = string.lf("上仙，此道无选手，无法进行鼓舞!"),
			title1 = string.lf("确定"),
			action1 = function()
				return
			end
		})
	elseif arg_19_0.mBaseInfo.Encourage ~= nil then
		for iter_19_0, iter_19_1 in ipairs(arg_19_0.mBaseInfo.Encourage) do
			if iter_19_1.Type == arg_19_1 then
				var_19_0 = 1

				if iter_19_1.IsEncouragable == 0 then
					print("此道有鼓舞记录但是不能鼓舞")
					showFlashNotice(string.lf("您已对当前界进行过鼓舞，无法重复鼓舞"))

					break
				else
					print("此道有鼓舞记录但是可以鼓舞")
					ui.showMessageBox({
						text = string.lf("上仙，您是否需要花费#FFFF00%d#FFFFFF元宝进行鼓舞！", arg_19_0.Gold),
						title1 = string.lf("确定"),
						title2 = string.lf("取消"),
						action1 = function()
							if not isMoneyEnough(ItemType.eGold, arg_19_0.Gold) then
								return
							else
								arg_19_0:requestInspireInfo(arg_19_1)
							end
						end
					})

					break
				end
			end
		end

		if var_19_0 == 0 then
			print("此道没有鼓舞记录")
			ui.showMessageBox({
				text = string.lf("上仙，您是否需要花费#FFFF00%d#FFFFFF元宝进行鼓舞！", arg_19_0.Gold),
				title1 = string.lf("确定"),
				title2 = string.lf("取消"),
				action1 = function()
					if not isMoneyEnough(ItemType.eGold, arg_19_0.Gold) then
						return
					else
						arg_19_0:requestInspireInfo(arg_19_1)
					end
				end
			})
		end
	end
end

function var_0_1.OnStartBattleClicked(arg_23_0)
	game.enterZSZZFightScene({
		pageTypein = 5
	})
end

function var_0_1.onGetTeamBtnClicked(arg_24_0, arg_24_1)
	OthersTeamHelper:checkOthersTeam(arg_24_1.PlayerId, arg_24_1.PlayerName, OthersTeamHelper.eDataFromZSZZ, {
		worldType = arg_24_1.Type
	}, arg_24_1.ServerId)
end

function var_0_1.onDuelRulesBtnClicked(arg_25_0)
	local var_25_0 = require("scenes.enhance.DlgRuleLayer").new({
		ruleType = DlgRuleType.ruleInspire
	})

	arg_25_0:addChild(var_25_0)
end

function var_0_1.closeAction(arg_26_0)
	if arg_26_0.mParams.from == "battle" then
		game.enterWorldBossHomeScene()
	else
		game.enterHomeScene({
			showSubLayer = 1
		})
	end
end

function var_0_1.onGetKillListBtnClicked(arg_27_0)
	if arg_27_0.mBaseInfo and arg_27_0.mBaseInfo.CSBattleStatus == 4 then
		showFlashNotice(string.lf("比赛进行中，人头榜暂未选出"))
	else
		local var_27_0 = require("scenes.fuben.ZSZZKillListLayer").new({
			pageType = arg_27_0.worldType
		})

		arg_27_0:addChild(var_27_0)
	end
end

function var_0_1.onEnterGableBtnClicked(arg_28_0)
	if arg_28_0.mBaseInfo.CSBattleStatus == 2 or arg_28_0.mBaseInfo.CSBattleStatus == 1 then
		game.enterZSZZGambleScene({
			remainTime = arg_28_0.mBaseInfo.Countdown,
			placeType = arg_28_0.worldType,
			status = arg_28_0.mBaseInfo.CSBattleStatus
		})
	elseif arg_28_0.mBaseInfo.CSBattleStatus == 3 then
		showFlashNotice(string.lf("比赛进入筹备期，无法进行下注"))
	else
		showFlashNotice(string.lf("当前时段不能下注"))
	end
end

function var_0_1.onGetRewardBtnClicked(arg_29_0)
	if arg_29_0.mBaseInfo.CSBattleStatus == 4 then
		showFlashNotice(string.lf("比赛进行中，无法领奖"))
	else
		local var_29_0 = require("scenes.fuben.ZSZZRewardLayer").new()

		display.getRunningScene():addChild(var_29_0)
	end
end

function var_0_1.onTop32InfoViewBtnClicked(arg_30_0)
	if arg_30_0.mBaseInfo.IsTop32Exists == 0 then
		showFlashNotice(string.lf("暂无记录"))
	else
		game.enterZSZZFightScene({
			pageType = arg_30_0.worldType,
			pageTypein = arg_30_0.worldType
		})
	end
end

function var_0_1.onGetInspireRecordBtnClicked(arg_31_0, arg_31_1)
	if arg_31_0.mBaseInfo.CSBattleStatus ~= 1 then
		if arg_31_0.mBaseInfo.CSBattleStatus == 4 then
			showFlashNotice(string.lf("诸神之战已开赛，鼓舞已结束"))
		elseif arg_31_0.heroList[arg_31_1][1] == nil and arg_31_0.heroList[arg_31_1][2] == nil and arg_31_0.heroList[arg_31_1][3] == nil then
			showFlashNotice(string.lf("此道无任何选手，无鼓舞记录"))
		else
			local var_31_0 = require("scenes.fuben.ZSZZInspireRecordLayer").new({
				pageType = arg_31_0.worldType
			})

			arg_31_0:addChild(var_31_0)
		end
	else
		showFlashNotice(string.lf("暂未开始鼓舞，无任何记录"))
	end
end

function var_0_1.setTimer(arg_32_0)
	if not arg_32_0.mCDTimerHandler then
		arg_32_0.mCDTimerHandler = var_0_0.scheduleGlobal(handler(arg_32_0, arg_32_0.onCDTimer), 1)
	end
end

function var_0_1.killTimer(arg_33_0)
	if arg_33_0.mCDTimerHandler then
		var_0_0.unscheduleGlobal(arg_33_0.mCDTimerHandler)

		arg_33_0.mCDTimerHandler = nil
	end
end

function var_0_1.onCDTimer(arg_34_0)
	table.foreach(arg_34_0.mCDTimerFunctions or {}, function(arg_35_0, arg_35_1)
		arg_35_1()
	end)
end

function var_0_1.attachCDTimer(arg_36_0, arg_36_1, arg_36_2)
	arg_36_0.mCDTimerFunctions[arg_36_1] = arg_36_2
end

function var_0_1.dettachCDTimer(arg_37_0, arg_37_1)
	arg_37_0.mCDTimerFunctions[arg_37_1] = nil
end

function var_0_1.requestBasePlayInfo(arg_38_0)
	if not arg_38_0.mPlayerInfoRequest then
		arg_38_0.mPlayerInfoRequest = ZSZZHomeInfoRequest:new()

		local function var_38_0()
			arg_38_0:onResponseActiInfo(arg_38_0.mPlayerInfoRequest.restable)
		end

		arg_38_0.mPlayerInfoRequest:setResponseNormalHandler(var_38_0)
	end

	arg_38_0.mPlayerInfoRequest:request()
end

function var_0_1.onResponseActiInfo(arg_40_0, arg_40_1)
	dump(arg_40_1.CsbattleRank)

	arg_40_0.mBaseInfo = arg_40_1

	if arg_40_1.CSBattleStatus == 1 then
		arg_40_0.inspireButton:setVisible(false)
		arg_40_0.startBattleButton:setVisible(false)
		arg_40_0.notStart:setVisible(true)
	elseif arg_40_1.CSBattleStatus == 2 or arg_40_1.CSBattleStatus == 3 then
		arg_40_0.inspireButton:setVisible(true)
		arg_40_0.startBattleButton:setVisible(false)
		arg_40_0.notStart:setVisible(false)
	elseif arg_40_1.CSBattleStatus == 4 then
		arg_40_0.inspireButton:setVisible(false)
		arg_40_0.startBattleButton:setVisible(true)
		arg_40_0.notStart:setVisible(false)
	end

	arg_40_0.mRemainTime:setRemainTime(arg_40_1.CSBattleStatus, arg_40_1.Countdown)

	arg_40_0.heroList = {
		{},
		{},
		{}
	}
	arg_40_0.InspireList = {
		{},
		{},
		{}
	}

	if arg_40_1.CsbattleRank ~= nil then
		for iter_40_0, iter_40_1 in ipairs(arg_40_1.CsbattleRank) do
			table.insert(arg_40_0.heroList[iter_40_1.Type], iter_40_1)
		end
	end

	if arg_40_1.Encourage ~= nil then
		for iter_40_2, iter_40_3 in ipairs(arg_40_1.Encourage) do
			table.insert(arg_40_0.InspireList[iter_40_3.Type], iter_40_3)
		end
	end

	arg_40_0.myOb:CreateHero(arg_40_0.heroList[arg_40_0.worldType])
	arg_40_0:showFlashLight(arg_40_0.worldType)
	arg_40_0:refreshCountandCombat(arg_40_0.InspireList[arg_40_0.worldType][1])

	if arg_40_0.mParams.pageTypereturn == 4 then
		arg_40_0:onGetKillListBtnClicked()
	end
end

function var_0_1.requestInspireInfo(arg_41_0, arg_41_1)
	if not arg_41_0.mInspireRequest then
		arg_41_0.mInspireRequest = ZSZZEncourageRequest:new()

		local function var_41_0()
			arg_41_0:onResponseInfoSucess(arg_41_0.mInspireRequest.restable)
		end

		arg_41_0.mInspireRequest:setResponseNormalHandler(var_41_0)
	end

	arg_41_0.mInspireRequest:request(arg_41_1)
end

function var_0_1.onResponseInfoSucess(arg_43_0, arg_43_1)
	local var_43_0

	for iter_43_0, iter_43_1 in ipairs(arg_43_1.Reward) do
		if iter_43_1.Type == ItemType.eCoin then
			var_43_0 = iter_43_1.Count

			break
		end
	end

	arg_43_0:requestBasePlayInfo()

	local var_43_1 = string.lf("鼓舞成功")

	if var_43_0 then
		var_43_1 = string.lf("鼓舞成功,获得%s银币", var_43_0)
	end

	showFlashNotice(var_43_1)
end

return var_0_1
