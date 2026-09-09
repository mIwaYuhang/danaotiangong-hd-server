require("network.PlayerRequest")
require("base.figure")
require("data.task")

local var_0_0 = require("scenes.toollayer.tool")
local var_0_1 = class("NicknameScene", function()
	return display.newScene("NicknameScene")
end)

function var_0_1.ctor(arg_2_0)
	arg_2_0._selectedHeroId = InitHerosConfig[1].heroId

	local function var_2_0()
		local var_3_0 = {
			accountId = Player.userId,
			playerName = Player.nickName,
			PlayerLevel = Player.level,
			ServerName = Player.serverInfo.ServerName,
			ServerID = Player.serverInfo.ServerID
		}

		IPlatform:instance():cpInfo("create_player", json.encode(var_3_0))
		game.enterHomeScene()

		local var_3_1 = Player.systemOpenControllers.IsShowAdvertisement

		if var_3_1 and var_3_1 > 0 then
			Platform.showAdmob()
		end
	end

	local function var_2_1(arg_4_0)
		if arg_4_0 == NetworkState.NameAlreadyExists then
			ui.showMessageBox({
				text = string.lf("上仙，您的角色名已经被人占用了！，T.T")
			})
		end
	end

	arg_2_0.nicknameRequest = NicknameRequest:new(arg_2_0)

	arg_2_0.nicknameRequest:setResponseNormalHandler(var_2_0)
	arg_2_0.nicknameRequest:setResponseExceptionHandler(var_2_1)

	for iter_2_0, iter_2_1 in ipairs(InitHerosConfig) do
		local var_2_2 = iter_2_1.heroId

		iter_2_1.perfectWeaponId = getHeroGroupWeaponId(var_2_2)
	end
end

function var_0_1.onEnter(arg_5_0)
	arg_5_0.background = display.newSprite("ui/account/account_010.jpg")

	arg_5_0.background:setScaleX(Adapter.AutoScaleX)
	arg_5_0.background:setScaleY(Adapter.AutoScaleY)
	arg_5_0.background:setPosition(display.cx, display.cy)
	arg_5_0:addChild(arg_5_0.background)
	arg_5_0:showInitHeros()
	arg_5_0:createTouchEventLayer()

	local var_5_0 = display.newScale9Sprite("ui/fuben/fuben_023.png", display.cx, 48 * Adapter.MinScale)

	var_5_0:setScale(Adapter.MinScale)
	var_5_0:setPreferredSize(CCSize(917, 96))
	arg_5_0:addChild(var_5_0)
	addLabelWithColorSize(var_5_0, string.lf("玩家名"), ccc3(111, 118, 100), 28, ccp(1, 0.5), ccp(340, 50))

	local var_5_1 = ui.newEditBox({
		fontSize = 30,
		y = 49,
		image = "ui/account/account_015.png",
		x = 469,
		size = CCSize(225, 59),
		labelAlignment = kCCTextAlignmentCenter
	})

	var_5_1:setFontColor(ccc3(220, 220, 220))
	var_5_1:setMaxLength(20)
	var_5_0:addChild(var_5_1)

	if IPlatform:instance():getConfig("Channel") ~= "ZSY_VN" then
		var_5_1:setText(var_0_0.getRandomName())

		local var_5_2 = ui.newControlButton({
			normalImage = "ui/account/account_016.png",
			position = ccp(621, 51),
			clickAction = function(arg_6_0, arg_6_1)
				var_5_1:setText(var_0_0.getRandomName())
			end
		})

		var_5_0:addChild(var_5_2)
	end

	local var_5_3 = ui.newControlButton({
		normalImage = "ui/account/account_017.png",
		position = ccp(728, 53),
		clickAction = function(arg_7_0, arg_7_1)
			local var_7_0 = var_5_1:getText()
			local var_7_1 = string.asciilen(var_7_0)

			if IPlatform:instance():getConfig("Channel") == "ZSY_VN" and var_7_1 > 3 and var_7_1 < 11 or var_7_1 > 0 and var_7_1 < 13 then
				if matchValidedString(var_7_0) then
					arg_5_0.nicknameRequest:requestSetNickname(var_7_0, arg_5_0._selectedHeroId)
				else
					CCMessageBox(string.lf("昵称包含非法字符！"), string.lf("错误"))
				end
			elseif IPlatform:instance():getConfig("Channel") == "ZSY_VN" then
				CCMessageBox(string.lf("昵称最多4个中文或10个英文字符！"), string.lf("错误"))
			else
				CCMessageBox(string.lf("昵称最多6个中文或12个英文字符！"), string.lf("错误"))
			end
		end
	})

	var_5_3:setScaleAsSprite(true)
	var_5_0:addChild(var_5_3)

	local var_5_4 = ui.newControlButton({
		normalImage = "ui/common/common_110.png",
		highlightedImage = "ui/common/common_110.png",
		text = string.lf("登出"),
		textColor = ColorTable.eTitleButton_Normal,
		fontSize = ColorTable.eTitleButton_FontSize,
		position = ccp(820, 600),
		clickAction = function(arg_8_0, arg_8_1)
			if IPlatform:instance():getConfig("ThridLogin") == "True" then
				IPlatform:instance():logout()
			else
				game.restartGameEntry()
			end
		end
	})

	var_5_4:setScaleAsSprite(true)
	var_5_0:addChild(var_5_4)
end

function var_0_1.showInitHeros(arg_9_0)
	arg_9_0._ellipseLayer = require("scenes.EllipseLayer").new({
		fixAngle = 270,
		longAxias = 280 * Adapter.MinScale,
		shortAxias = 60 * Adapter.MinScale,
		totalItemNum = #InitHerosConfig,
		unlockItemNum = #InitHerosConfig,
		itemContentCallback = function(arg_10_0, arg_10_1)
			arg_9_0:showHeroDetails(arg_10_0, arg_10_1)
		end,
		alignCallback = function(arg_11_0)
			arg_9_0._selectedHeroId = InitHerosConfig[arg_11_0].heroId

			for iter_11_0 = 1, #InitHerosConfig do
				local var_11_0 = arg_9_0._ellipseLayer:getItemNode(iter_11_0)

				if iter_11_0 == arg_11_0 then
					arg_9_0:playActiveAnimation()
				else
					var_11_0._nameSprite:setColor(ccc3(80, 80, 80))
					var_11_0._platTableSprite:setColor(ccc3(180, 180, 180))
					arg_9_0:updateFigureStatus(var_11_0._figureNode, var_11_0._figureConfig, false)
				end
			end
		end
	})

	arg_9_0._ellipseLayer:setPosition(ccp(display.cx + 10, 200 * Adapter.MinScale))
	arg_9_0:addChild(arg_9_0._ellipseLayer)
	arg_9_0._ellipseLayer:moveToIndexItem(math.random(1, 3), true)
end

function var_0_1.showHeroDetails(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = display.newSprite("ui/account/account_011.png", 0, 0)

	var_12_0:setScale(Adapter.MinScale)
	arg_12_1:addChild(var_12_0)

	local function var_12_1()
		if arg_12_0._ellipseLayer:getCurrentItemIndex() ~= arg_12_2 then
			arg_12_0._ellipseLayer:moveToIndexItem(arg_12_2, true)
		else
			local var_13_0 = require("scenes.ToolLayer")

			var_13_0.createDialog({
				player = false,
				show = var_13_0.eShowTujianHero,
				id = InitHerosConfig[arg_12_2].heroId
			}):show()
		end
	end

	local var_12_2 = {
		scale = 1,
		starScale = 0.6,
		qualityOffsetY = 335,
		platTable = false,
		isViewQuality = true,
		figId = InitHerosConfig[arg_12_2].heroId,
		clickAction = var_12_1,
		equipId = InitHerosConfig[arg_12_2].perfectWeaponId,
		pinjie = EquipPinjieType.eFanPin
	}
	local var_12_3 = figure.createHero(var_12_2)

	var_12_3.tag = arg_12_2

	var_12_3:setPosition(ccp(0, 30 * Adapter.MinScale))
	arg_12_1:addChild(var_12_3)
	var_12_3:setScale(Adapter.MinScale)

	var_12_2.figureNode = var_12_3

	local var_12_4 = display.newSprite(InitHerosConfig[arg_12_2].nameSprite, 0, 400 * Adapter.MinScale)

	var_12_4:setScale(Adapter.MinScale)
	arg_12_1:addChild(var_12_4)

	local var_12_5 = display.newSprite(getProfessionIconImageName(BaseHeros[InitHerosConfig[arg_12_2].heroId].profession), 20, 5)

	var_12_5:setAnchorPoint(ccp(1, 0))
	var_12_4:addChild(var_12_5)

	if arg_12_2 ~= 1 then
		arg_12_0:updateFigureStatus(var_12_3, var_12_2, false)
		var_12_4:setColor(ccc3(80, 80, 80))
		var_12_0:setColor(ccc3(180, 180, 180))
	end

	arg_12_1._figureNode = var_12_3
	arg_12_1._figureConfig = var_12_2
	arg_12_1._nameSprite = var_12_4
	arg_12_1._platTableSprite = var_12_0
end

function var_0_1.createTouchEventLayer(arg_14_0)
	local var_14_0 = display.newLayer()
	local var_14_1 = {
		x = 0,
		y = 0
	}
	local var_14_2 = {
		x = 0,
		y = 0
	}

	local function var_14_3(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == "began" then
			var_14_1.x = arg_15_1
			var_14_1.y = arg_15_2
			var_14_2.x = arg_15_1
			var_14_2.y = arg_15_2

			return true
		elseif arg_15_0 == "moved" then
			local var_15_0 = arg_15_1 - var_14_1.x

			var_14_1.x = arg_15_1
			var_14_1.y = arg_15_2

			if var_15_0 > 0 then
				arg_14_0._ellipseLayer:setRadiansOffset(-1)
			end

			if var_15_0 < 0 then
				arg_14_0._ellipseLayer:setRadiansOffset(1)
			end
		elseif arg_15_0 == "ended" or arg_15_0 == "cancelled" then
			local var_15_1 = arg_15_1 - var_14_2.x

			if var_15_1 > 100 then
				arg_14_0._ellipseLayer:moveToPreviousItem()

				return
			end

			if var_15_1 < -100 then
				arg_14_0._ellipseLayer:moveToNextItem()

				return
			end

			arg_14_0._ellipseLayer:alignTheLayer(true)
		end
	end

	var_14_0:addTouchEventListener(var_14_3, false, 1, false)
	var_14_0:setTouchEnabled(true)
	arg_14_0:addChild(var_14_0)
end

function var_0_1.playActiveAnimation(arg_16_0)
	local function var_16_0()
		local var_17_0 = arg_16_0._ellipseLayer:getCurrentItemIndex()
		local var_17_1 = arg_16_0._ellipseLayer:getItemNode(var_17_0)

		arg_16_0:updateFigureStatus(var_17_1._figureNode, var_17_1._figureConfig, true)
		var_17_1._nameSprite:setColor(ccc3(255, 255, 255))
		var_17_1._nameSprite:runAction(CCScaleTo:create(0.2, 1 * Adapter.MinScale))
		var_17_1._platTableSprite:setColor(ccc3(255, 255, 255))
		var_17_1._figureNode:setStarsColor(ccc3(255, 255, 255))

		if var_17_1._skeleton then
			var_17_1._skeleton:removeFromParentAndCleanup(true)
		end
	end

	local var_16_1 = arg_16_0._ellipseLayer:getCurrentItemIndex()
	local var_16_2 = arg_16_0._ellipseLayer:getItemNode(var_16_1)

	display.addSpriteFramesWithFile("ui/common/inithero_light.plist", "ui/common/inithero_light.png")

	local var_16_3 = display.newSprite("#inithero_light01.png")
	local var_16_4 = display.newFrames("inithero_light%02d.png", 1, 11)
	local var_16_5 = display.newAnimation(var_16_4, 0.03333333333333333)

	var_16_2._nameSprite:runAction(CCScaleTo:create(0.2, 1.2 * Adapter.MinScale))
	var_16_3:setPosition(var_16_2._nameSprite:getPosition())
	var_16_2:addChild(var_16_3)
	var_16_3:playOnce(var_16_5, true, var_16_0)
end

function var_0_1.updateFigureStatus(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_3 == true then
		arg_18_2.pinjie = EquipPinjieType.eShengPin
	else
		arg_18_2.pinjie = EquipPinjieType.eFanPin
	end

	if arg_18_3 == true then
		arg_18_1.Skeleton:setColor(ccc3(255, 255, 255))

		local var_18_0 = arg_18_0._ellipseLayer:getCurrentItemIndex()

		if InitHerosConfig[var_18_0].heroId == 306 then
			arg_18_1.Skeleton:setMix("dazhao", "daiji", 0.05, 0, 0)
			arg_18_1.Skeleton:setAnimation("dazhao", false, 0)
			arg_18_1.Skeleton:addAnimation("daiji", true, 0, 0, nil)
		else
			arg_18_1.Skeleton:setMix("putong", "daiji", 0.05, 0, 0)
			arg_18_1.Skeleton:setAnimation("putong", false, 0)
			arg_18_1.Skeleton:addAnimation("daiji", true, 0, 0, nil)
		end
	else
		arg_18_1.Skeleton:setColor(ccc3(80, 80, 80))
		arg_18_1.Skeleton:clearAnimation(0)
		arg_18_1.Skeleton:setToSetupPose()
		arg_18_1:setStarsColor(ccc3(80, 80, 80))
	end

	figure.setupFigure(arg_18_2)
end

return var_0_1
