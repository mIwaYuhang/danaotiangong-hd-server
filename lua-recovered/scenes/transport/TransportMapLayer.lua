require("data.transport")

local var_0_0
local var_0_1 = 10
local var_0_2 = 250 / var_0_1
local var_0_3 = 3
local var_0_4 = class("TransportMapLayer", function()
	return display.newLayer()
end)

function var_0_4.ctor(arg_2_0, arg_2_1)
	arg_2_0._currentMapId = arg_2_1._currentMapId or TransportDest.LockGodPalace
	arg_2_0._horseInfoList = arg_2_1._horseInfoList or {}
	arg_2_0._hideLowLevel = arg_2_1._hideLowLevel or false
	arg_2_0._uiNode = arg_2_1._uiNode
	arg_2_0.getTransportInfoHandler = arg_2_1.transportInfoHandler
	arg_2_0._horseSpriteList = {}

	if arg_2_0._currentMapId == 1 then
		local var_2_0 = CCScale9Sprite:create("ui/transport/transport_map.jpg")

		var_2_0:setScaleX(Adapter.AutoScaleX)
		var_2_0:setScaleY(Adapter.AutoScaleY)
		var_2_0:setPreferredSize(CCSize(1920, 640))
		var_2_0:setAnchorPoint(ccp(0, 0.5))
		var_2_0:setPosition(ccp(0, display.cy))
		arg_2_0:addChild(var_2_0)

		local var_2_1 = ScrollSprite:create(8, 0, "ui/transport/transport_029.png")

		var_2_1:setAnchorPoint(ccp(0, 1))
		var_2_1:setScaleX(Adapter.AutoScaleX)
		var_2_1:setScaleY(Adapter.AutoScaleY)
		var_2_1:setPosition(ccp(0, 0))

		local var_2_2 = ScrollSprite:create(10, 0, "ui/transport/transport_030.png")

		var_2_2:setAnchorPoint(ccp(0, 0.5))
		var_2_2:setScaleX(Adapter.AutoScaleX)
		var_2_2:setScaleY(Adapter.AutoScaleY)
		var_2_2:setPosition(ccp(0, 0))

		local var_2_3 = ScrollSprite:create(15, 0, "ui/transport/transport_031.png")

		var_2_3:setAnchorPoint(ccp(0, 0))
		var_2_3:setScaleX(Adapter.AutoScaleX)
		var_2_3:setScaleY(Adapter.AutoScaleY)
		var_2_3:setPosition(ccp(0, 0))

		arg_2_0.parallaxNode = CCParallaxNode:create()

		arg_2_0.parallaxNode:addChild(var_2_1, 0, ccp(0.7, 1), ccp(0, display.height))
		arg_2_0.parallaxNode:addChild(var_2_2, 0, ccp(0.85, 1), ccp(0, 480))
		arg_2_0.parallaxNode:addChild(var_2_3, 0, ccp(1, 1), ccp(0, 0))
		arg_2_0:addChild(arg_2_0.parallaxNode)

		local var_2_4 = display.newSprite("ui/transport/transport_map_4.png", display.right, display.cy)

		var_2_4:setAnchorPoint(ccp(1, 0.5))
		var_2_4:setScaleX(Adapter.AutoScaleX)
		var_2_4:setScaleY(Adapter.AutoScaleY)
		arg_2_0:addChild(var_2_4)

		local var_2_5 = display.newSprite("ui/common/common_052.png", display.right - 124 * Adapter.WidthScale, display.cy - 106 * Adapter.HeightScale)

		var_2_5:setScale(Adapter.MinScale)
		arg_2_0:addChild(var_2_5)
		addLabelWithColorSize(arg_2_0, TransportDestData[TransportDest.LockGodPalace].name, ccc3(255, 235, 190), 22, ccp(0.5, 0.5), ccp(display.right - 124 * Adapter.WidthScale, display.cy - 106 * Adapter.HeightScale), _FONT_LISU)

		local var_2_6 = display.newSprite("ui/transport/transport_map_5.png", display.right * 2, display.cy)

		var_2_6:setScaleX(Adapter.AutoScaleX)
		var_2_6:setScaleY(Adapter.AutoScaleY)
		var_2_6:setAnchorPoint(ccp(1, 0.5))
		arg_2_0:addChild(var_2_6)

		local var_2_7 = display.newSprite("ui/common/common_052.png", display.right * 2 - 105 * Adapter.WidthScale, display.cy - 90 * Adapter.HeightScale)

		var_2_7:setScale(Adapter.MinScale)
		arg_2_0:addChild(var_2_7)
		addLabelWithColorSize(arg_2_0, TransportDestData[TransportDest.LeaveFireIsland].name, ccc3(255, 235, 190), 22, ccp(0.5, 0.5), ccp(display.right * 2 - 105 * Adapter.WidthScale, display.cy - 90 * Adapter.HeightScale), _FONT_LISU)
	end

	arg_2_0:refreshHorseList()
	arg_2_0:schedule(handler(arg_2_0, arg_2_0.refreshHorseList), var_0_3)

	local var_2_8 = GuideLayer:showGuideLayer(arg_2_0, arg_2_0, TaskEntryType.eTransportRob, 2, nil, true)

	if var_2_8 then
		var_2_8.guideLable:setString(string.lf("请点击一艘船"))
	end
end

function var_0_4.refreshHorseList(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._horseInfoList) do
		local var_3_0 = iter_3_1.PlayerID
		local var_3_1, var_3_2 = arg_3_0:isHorseDisplayThisMap(iter_3_1.AdressId, iter_3_1.HaveTime)
		local var_3_3, var_3_4 = arg_3_0:getRandomPosition(var_3_2)

		if iter_3_1.posy == nil then
			iter_3_1.posy = var_3_4

			if var_3_0 == Player.userId then
				iter_3_1.posy = var_0_0 or var_3_4

				if var_0_0 == nil then
					var_0_0 = var_3_4
				end
			end
		end

		if arg_3_0._hideLowLevel == true and iter_3_1.HourseType == HorseType.WhiteHorse then
			var_3_1 = false
		end

		if var_3_1 == true and arg_3_0._horseSpriteList[var_3_0] == nil then
			local function var_3_5(arg_4_0, arg_4_1)
				local var_4_0, var_4_1 = tolua.cast(arg_4_1, "CCControlButton"):getPosition()

				if var_4_0 < 200 * Adapter.MinScale then
					var_4_0 = 200 * Adapter.MinScale
				end

				if var_4_0 > 800 * Adapter.MinScale then
					var_4_0 = 800 * Adapter.MinScale
				end

				if var_4_1 < 200 * Adapter.MinScale then
					var_4_1 = 200 * Adapter.MinScale
				end

				if var_4_1 > 550 * Adapter.MinScale then
					var_4_1 = 550 * Adapter.MinScale
				end

				GuideLayer:removeGuideLayer(arg_3_0, TaskEntryType.eTransportRob, 2)
				GuideLayer:stepDone(TaskEntryType.eTransportRob, 2)
				arg_3_0:showTransportLayer(var_4_0, var_4_1, iter_3_1)
			end

			local var_3_6 = ui.newControlButton({
				clickAction = var_3_5,
				normalImage = HorseTypeData[iter_3_1.HourseType].horseImage,
				scaleX = Adapter.MinScale,
				scaleY = Adapter.MinScale,
				position = ccp(var_3_3, iter_3_1.posy or var_3_4)
			})

			arg_3_0._horseSpriteList[var_3_0] = var_3_6

			arg_3_0:addChild(var_3_6)
		elseif var_3_1 == true and arg_3_0._horseSpriteList[var_3_0] ~= nil then
			arg_3_0._horseSpriteList[var_3_0]:setPositionX(var_3_3)
		elseif var_3_1 == false and arg_3_0._horseSpriteList[var_3_0] ~= nil then
			arg_3_0._horseSpriteList[var_3_0]:removeFromParent()

			arg_3_0._horseSpriteList[var_3_0] = nil
		end
	end
end

function var_0_4.isHorseDisplayThisMap(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = false
	local var_5_1 = 0
	local var_5_2 = TransportDestData[TransportDest.LeaveFireIsland].transportSecond - TransportDestData[TransportDest.LockGodPalace].transportSecond

	if arg_5_0._currentMapId == TransportDest.LockGodPalace then
		if arg_5_1 == TransportDest.LockGodPalace and arg_5_2 > 0 then
			var_5_0 = true
			var_5_1 = arg_5_2 / TransportDestData[TransportDest.LockGodPalace].transportSecond
		elseif arg_5_1 == TransportDest.LeaveFireIsland and var_5_2 < arg_5_2 then
			var_5_0 = true
			var_5_1 = (arg_5_2 - var_5_2) / TransportDestData[TransportDest.LockGodPalace].transportSecond
		end
	elseif arg_5_0._currentMapId == TransportDest.LeaveFireIsland and arg_5_1 == TransportDest.LeaveFireIsland and arg_5_2 > 0 and arg_5_2 < var_5_2 then
		var_5_0 = true
		var_5_1 = arg_5_2 / var_5_2
	end

	return var_5_0, var_5_1
end

function var_0_4.getRandomPosition(arg_6_0, arg_6_1)
	local var_6_0 = (1 - arg_6_1) * 890 * Adapter.WidthScale
	local var_6_1 = math.random(1, var_0_1) * var_0_2 + 100

	return var_6_0, var_6_1 * Adapter.HeightScale
end

function var_0_4.startRobHorse(arg_7_0, arg_7_1)
	local function var_7_0(arg_8_0, arg_8_1)
		game.enterTransportScene()
	end

	require("scenes.battle.BattleOperator"):startBattle(eBattleType.Transport, {
		enemyid = arg_7_0.robedPlayerID,
		friendIds = arg_7_1
	}, var_7_0)
end

function var_0_4.showTransportLayer(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = true

	if arg_9_3.BeRobedTime >= arg_9_3.TotalCanBeRobedTime then
		var_9_0 = false
	end

	if arg_9_3.PlayerID == Player.userId then
		var_9_0 = false
	end

	if arg_9_0._operateLayer ~= nil then
		arg_9_0._operateLayer:removeFromParent()

		arg_9_0._operateLayer = nil
	end

	arg_9_0._operateLayer = require("scenes.team.PackageOperationLayer").new({
		position = CCPoint(arg_9_1, arg_9_2),
		size = Adapter.MinSize(390, 250),
		contentHandler = function(arg_10_0)
			arg_9_0:showTransportDetails(arg_10_0, arg_9_3)
		end,
		touchCallback = function()
			arg_9_0._operateLayer:removeFromParent()

			arg_9_0._operateLayer = nil
		end,
		buttons = {
			{
				buttonBg = "ui/common/common_019.png",
				buttonDisableBg = "ui/common/common_080.png",
				title = string.lf("拦截他"),
				btnEnable = var_9_0,
				handler = function()
					if arg_9_0.getTransportInfoHandler().HaveRobTime <= 0 then
						showFlashNotice(string.lf("您今日的劫镖次数已用完."))

						return
					end

					arg_9_0.robedPlayerID = arg_9_3.PlayerID

					local var_12_0 = require("scenes.transport.TransportFriendsLayer").new({
						_isRobFriends = true,
						_callbackFunc = handler(arg_9_0, arg_9_0.startRobHorse)
					})

					var_12_0:setPosition(ccp(display.cx, display.cy))
					arg_9_0._uiNode:addChild(var_12_0)
					arg_9_0._operateLayer:removeFromParent()

					arg_9_0._operateLayer = nil
				end
			}
		}
	})

	arg_9_0._uiNode:addChild(arg_9_0._operateLayer)
end

function var_0_4.showTransportDetails(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = display.newSprite("ui/common/common_064_2.png", 198, 245)

	arg_13_1:addChild(var_13_0)

	local var_13_1 = display.newSprite("uilocal/transport/transport_text_008.png", 198, 245)

	arg_13_1:addChild(var_13_1)

	local var_13_2 = figure.createHeader({
		type = ItemType.eHero,
		itemId = arg_13_2.AvatarId
	})

	var_13_2:setPosition(ccp(80, 174))
	arg_13_1:addChild(var_13_2)

	local var_13_3 = string.format("Lv.%d", arg_13_2.Plv)

	addLabelWithColorSize(arg_13_1, var_13_3, ccc3(33, 142, 34), 20, ccp(0.5, 0.5), ccp(80, 119))

	local var_13_4 = string.format("%s", arg_13_2.PlayerName)

	addLabelWithColorSize(arg_13_1, var_13_4, ccc3(228, 167, 38), 25, ccp(0, 0.5), ccp(146, 201))
	addLabelWithColorSize(arg_13_1, string.lf("总战力:"), ccc3(242, 189, 70), 20, ccp(0, 0.5), ccp(148, 159))
	addLabelWithColorSize(arg_13_1, arg_13_2.TotalPower, ccc3(255, 255, 255), 20, ccp(0, 0.5), ccp(227, 159))
	addLabelWithColorSize(arg_13_1, string.lf("被劫数:"), ccc3(242, 189, 70), 20, ccp(0, 0.5), ccp(148, 124))

	local var_13_5 = string.lf("%d/%d次", arg_13_2.BeRobedTime, arg_13_2.TotalCanBeRobedTime)

	addLabelWithColorSize(arg_13_1, var_13_5, ccc3(255, 255, 255), 20, ccp(0, 0.5), ccp(227, 124))
	addLabelWithColorSize(arg_13_1, string.lf("拦截可得:"), ccc3(242, 189, 70), 20, ccp(0, 0.5), ccp(148, 89))

	local var_13_6 = createItemCountNode({
		color = ccc3(255, 255, 255),
		type = ItemType.eCoin,
		value = arg_13_2.RobRewardGold
	})

	var_13_6:setPosition(ccp(260, 89))
	var_13_6:setAnchorPoint(ccp(0.5, 0.5))
	arg_13_1:addChild(var_13_6)
end

function var_0_4.reloadLayer(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0._horseInfoList = arg_14_1
	arg_14_0._hideLowLevel = arg_14_2

	arg_14_0:removeAllHorseSprite()
	arg_14_0:refreshHorseList()
end

function var_0_4.removeAllHorseSprite(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0._horseSpriteList) do
		iter_15_1:removeFromParentAndCleanup(true)
	end

	arg_15_0._horseSpriteList = {}
end

return var_0_4
