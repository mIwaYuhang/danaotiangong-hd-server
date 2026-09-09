require("base.figure")
require("scenes.battle.BattleData")
require("scenes.battle.HeroTeamInfo")
require("scenes.battle.BattleProgress")
require("scenes.battle.BattleSetup")

local var_0_0 = 100 * Adapter.MinScale
local var_0_1 = class("HeroDragLayer", function()
	return display.newLayer()
end)

function nodeScale(arg_2_0)
	if arg_2_0 == 0 then
		return 0.91 * FigureSize
	elseif arg_2_0 == 1 then
		return 1.18 * FigureSize
	elseif arg_2_0 == 2 then
		return 2 * FigureSize
	elseif arg_2_0 == 3 then
		return 1.04 * FigureSize
	elseif arg_2_0 == 4 then
		return 1.17 * FigureSize
	elseif arg_2_0 == 5 then
		return 1.3 * FigureSize
	end
end

function nodeHeroScale(arg_3_0)
	if arg_3_0 < Setting_rebirth_trans1 then
		return 0
	elseif arg_3_0 >= Setting_rebirth_trans1 and arg_3_0 < Setting_rebirth_trans2 then
		return 3
	elseif arg_3_0 >= Setting_rebirth_trans2 and arg_3_0 < Setting_rebirth_trans3 then
		return 4
	elseif arg_3_0 >= Setting_rebirth_trans3 then
		return 5
	end
end

function nodeCheckRebirthScale(arg_4_0)
	local var_4_0 = arg_4_0.viewParam.rebirthCount

	if var_4_0 < Setting_rebirth_trans1 then
		return 0
	elseif var_4_0 >= Setting_rebirth_trans1 and var_4_0 < Setting_rebirth_trans2 then
		return 1
	elseif var_4_0 >= Setting_rebirth_trans2 and var_4_0 < Setting_rebirth_trans3 then
		return 2
	elseif var_4_0 >= Setting_rebirth_trans3 then
		return 3
	end

	return 0
end

function nodeNpcScale(arg_5_0)
	return arg_5_0
end

function ignoreSetupScale(arg_6_0)
	return nodeScale(arg_6_0) / nodeScale(0)
end

function var_0_1.createSingleHero(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0

	if arg_7_1 and arg_7_1.heroId > 0 then
		local var_7_1 = nodeHeroScale(0)
		local var_7_2 = {
			isHero = true,
			isViewQuality = false,
			platTable = false,
			scale = 1,
			figId = arg_7_1.heroId,
			clickAction = function(arg_8_0, arg_8_1)
				arg_7_0.selectedHero = nil
				arg_7_0.target = nil

				if arg_7_3 and arg_7_0.disnode then
					arg_7_0.disnode:removeFromParentAndCleanup(true)

					arg_7_0.disnode = nil
				end
			end,
			touchDownAction = function(arg_9_0, arg_9_1)
				local var_9_0 = tolua.cast(arg_9_1, "CCControlButton")

				arg_7_0.selectedHero = var_9_0:getParent().idx

				arg_7_0.buttonList[arg_7_0.selectedHero]:getParent():reorderChild(arg_7_0.buttonList[arg_7_0.selectedHero], 3)

				if arg_7_3 then
					arg_7_0.disnode, w, h = HeroTeamInfo:create({
						heroId = arg_7_1.heroId,
						parent = var_9_0:getParent()
					})

					arg_7_0.disnode:setPosition(200 + w / Adapter.MinScale / ignoreSetupScale(var_7_1), h / Adapter.MinScale / ignoreSetupScale(var_7_1))
					arg_7_0.disnode:setScale(1 / nodeScale(var_7_1) / 1.2)
					arg_7_0.disnode:runAction(CCEaseElasticOut:create(CCScaleTo:create(0.5, 1 / nodeScale(var_7_1))))
				end
			end,
			touchCancelAction = function(arg_10_0, arg_10_1)
				arg_7_0.selectedHero = nil
				arg_7_0.target = nil

				if arg_7_3 and arg_7_0.disnode then
					arg_7_0.disnode:removeFromParentAndCleanup(true)

					arg_7_0.disnode = nil
				end
			end
		}
		local var_7_3 = figure.createHero(var_7_2)

		var_7_3:setPosition(arg_7_2[arg_7_1.battleIx])

		var_7_3.heroId = var_7_2.figId
		var_7_3.idx = arg_7_1.battleIx
		arg_7_0.buttonList[arg_7_1.battleIx] = var_7_3

		arg_7_0:addChild(var_7_3, (arg_7_1.battleIx - 1) % 3)
		var_7_3:setScale(nodeScale(var_7_1) * (arg_7_4 or 1))
		orderScale(var_7_3, arg_7_2[arg_7_1.battleIx])

		var_7_3.figureSize = var_7_1

		function var_7_3.setTouchFalse(arg_11_0)
			var_7_3.clickButton:setTouchEnabled(false)
		end

		function var_7_3.setTouchTrue(arg_12_0)
			var_7_3.clickButton:setTouchEnabled(true)
		end

		var_7_3.prename = arg_7_0:viewHeroInfo(arg_7_1, var_7_3)

		if arg_7_1.equipList then
			local var_7_4
			local var_7_5

			for iter_7_0, iter_7_1 in pairs(arg_7_1.equipList) do
				if BaseEquips[iter_7_1.equipId].equipType == EquipType.eWeapon then
					var_7_4 = iter_7_1.equipId
					var_7_5 = iter_7_1.pinJie

					break
				end
			end

			var_7_3.viewParam = {
				figureNode = var_7_3,
				rebirthCount = arg_7_1.rebirthCount,
				equipId = var_7_4,
				heroId = arg_7_1.heroId,
				pinjie = var_7_5
			}

			figure.setupFigure(var_7_3.viewParam)
		else
			var_7_3.viewParam = {
				figureNode = var_7_3,
				rebirthCount = arg_7_1.rebirthCount,
				equipId = arg_7_1.weaponId,
				heroId = arg_7_1.heroId,
				pinjie = arg_7_1.pinjie
			}

			figure.setupFigure(var_7_3.viewParam)
		end

		if testhalo then
			var_7_3.halo = BattleSkeleton.createHalo(var_7_3, BaseHeros[arg_7_1.heroId].quality)
		end

		return var_7_3
	end
end

function var_0_1.createHero(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	table.foreach(arg_13_1, function(arg_14_0, arg_14_1)
		local var_14_0

		if arg_14_1 and arg_14_1.heroId > 0 then
			local var_14_1 = nodeHeroScale(0)
			local var_14_2 = {
				isHero = true,
				isViewQuality = false,
				platTable = false,
				scale = 1,
				figId = arg_14_1.heroId,
				clickAction = function(arg_15_0, arg_15_1)
					arg_13_0.selectedHero = nil
					arg_13_0.target = nil

					if arg_13_3 and arg_13_0.disnode then
						arg_13_0.disnode:removeFromParentAndCleanup(true)

						arg_13_0.disnode = nil
					end
				end,
				touchDownAction = function(arg_16_0, arg_16_1)
					local var_16_0 = tolua.cast(arg_16_1, "CCControlButton")

					arg_13_0.selectedHero = var_16_0:getParent().idx

					arg_13_0.buttonList[arg_13_0.selectedHero]:getParent():reorderChild(arg_13_0.buttonList[arg_13_0.selectedHero], 3)

					if arg_13_3 then
						arg_13_0.disnode, w, h = HeroTeamInfo:create({
							heroId = arg_14_1.heroId,
							parent = var_16_0:getParent()
						})

						arg_13_0.disnode:setPosition(200 + w / Adapter.MinScale / ignoreSetupScale(var_14_1), h / Adapter.MinScale / ignoreSetupScale(var_14_1))
						arg_13_0.disnode:setScale(1 / nodeScale(var_14_1) / 1.2)
						arg_13_0.disnode:runAction(CCEaseElasticOut:create(CCScaleTo:create(0.5, 1 / nodeScale(var_14_1))))
					end
				end,
				touchCancelAction = function(arg_17_0, arg_17_1)
					arg_13_0.selectedHero = nil
					arg_13_0.target = nil

					if arg_13_3 and arg_13_0.disnode then
						arg_13_0.disnode:removeFromParentAndCleanup(true)

						arg_13_0.disnode = nil
					end
				end
			}
			local var_14_3 = figure.createHero(var_14_2)

			var_14_3:setPosition(arg_13_2[arg_14_1.battleIx])

			var_14_3.heroId = var_14_2.figId
			var_14_3.idx = arg_14_1.battleIx
			arg_13_0.buttonList[arg_14_1.battleIx] = var_14_3

			arg_13_0:addChild(var_14_3, (arg_14_1.battleIx - 1) % 3)
			var_14_3:setScale(nodeScale(var_14_1) * (arg_13_4 or 1))
			orderScale(var_14_3, arg_13_2[arg_14_1.battleIx])

			var_14_3.figureSize = var_14_1

			function var_14_3.setTouchFalse(arg_18_0)
				var_14_3.clickButton:setTouchEnabled(false)
			end

			function var_14_3.setTouchTrue(arg_19_0)
				var_14_3.clickButton:setTouchEnabled(true)
			end

			var_14_3.prename = arg_13_0:viewHeroInfo(arg_14_1, var_14_3)

			if arg_14_1.equipList then
				local var_14_4
				local var_14_5

				for iter_14_0, iter_14_1 in pairs(arg_14_1.equipList) do
					if BaseEquips[iter_14_1.equipId].equipType == EquipType.eWeapon then
						var_14_4 = iter_14_1.equipId
						var_14_5 = iter_14_1.pinJie

						break
					end
				end

				var_14_3.viewParam = {
					figureNode = var_14_3,
					rebirthCount = arg_14_1.rebirthCount,
					equipId = var_14_4,
					heroId = arg_14_1.heroId,
					pinjie = var_14_5
				}

				figure.setupFigure(var_14_3.viewParam)
			else
				var_14_3.viewParam = {
					figureNode = var_14_3,
					rebirthCount = arg_14_1.rebirthCount,
					equipId = arg_14_1.weaponId,
					heroId = arg_14_1.heroId,
					pinjie = arg_14_1.pinjie
				}

				figure.setupFigure(var_14_3.viewParam)
			end

			if testhalo then
				var_14_3.halo = BattleSkeleton.createHalo(var_14_3, BaseHeros[arg_14_1.heroId].quality)
			end
		end
	end)

	return arg_13_0.buttonList
end

function var_0_1.createMaskLayer(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local function var_20_0(arg_21_0, arg_21_1, arg_21_2)
		if arg_21_0 == "began" then
			arg_20_0.touchDown_x = arg_21_1
			arg_20_0.touchDown_y = arg_21_2
			arg_20_0.target = nil

			return true
		elseif arg_21_0 == "moved" then
			if arg_20_0.selectedHero then
				orderScale_stopAction(arg_20_0.buttonList[arg_20_0.selectedHero])

				local var_21_0, var_21_1 = arg_20_0.buttonList[arg_20_0.selectedHero]:getPosition()
				local var_21_2 = arg_20_0:getParent():getScale()

				arg_20_0.buttonList[arg_20_0.selectedHero]:setPosition(var_21_0 + (arg_21_1 - arg_20_0.touchDown_x) / var_21_2, var_21_1 + (arg_21_2 - arg_20_0.touchDown_y) / var_21_2)
				orderScale(arg_20_0.buttonList[arg_20_0.selectedHero], ccp(var_21_0 + (arg_21_1 - arg_20_0.touchDown_x), var_21_1 + (arg_21_2 - arg_20_0.touchDown_y)))

				arg_20_0.touchDown_x = arg_21_1
				arg_20_0.touchDown_y = arg_21_2

				arg_20_0.buttonList[arg_20_0.selectedHero]:getParent():reorderChild(arg_20_0.buttonList[arg_20_0.selectedHero], 3)

				local var_21_3
				local var_21_4
				local var_21_5, var_21_6 = arg_20_0.buttonList[arg_20_0.selectedHero]:getPosition()

				table.foreach(arg_20_2, function(arg_22_0, arg_22_1)
					local var_22_0 = math.pow(arg_22_1.x - var_21_5, 2) + math.pow(arg_22_1.y - var_21_6, 2)

					if var_21_3 == nil and var_22_0 <= var_0_0 * var_0_0 * (arg_20_3 or 1) then
						var_21_3 = var_22_0
						var_21_4 = arg_22_0
					end

					if var_21_3 and var_22_0 <= var_21_3 and var_22_0 <= var_0_0 * var_0_0 * (arg_20_3 or 1) then
						var_21_3 = var_22_0
						var_21_4 = arg_22_0
					end
				end)

				if arg_20_0.target ~= var_21_4 then
					arg_20_0.target = var_21_4

					for iter_21_0, iter_21_1 in pairs(arg_20_0.buttonList) do
						iter_21_1.Skeleton:setOpacity(255)
					end

					if arg_20_0.target and arg_20_0.target ~= arg_20_0.selectedHero and arg_20_0.buttonList[arg_20_0.target] then
						arg_20_0.buttonList[arg_20_0.target].Skeleton:setOpacity(180)
					end
				end
			end
		elseif arg_21_0 == "ended" and arg_20_0.selectedHero then
			orderScale_stopAction(arg_20_0.buttonList[arg_20_0.selectedHero])

			local var_21_7 = arg_20_0.target

			if var_21_7 and var_21_7 ~= arg_20_0.selectedHero then
				local var_21_8 = true

				if arg_20_0.buttonList[var_21_7] then
					orderScale_stopAction(arg_20_0.buttonList[var_21_7])
					arg_20_0.buttonList[var_21_7].Skeleton:setOpacity(255)

					var_21_8 = false
				end

				if var_21_8 then
					orderScale_action(arg_20_0.buttonList[arg_20_0.selectedHero], arg_20_2[var_21_7], 0.2)

					arg_20_0.buttonList[arg_20_0.selectedHero].idx = var_21_7

					local var_21_9 = (var_21_7 - 1) % 3

					arg_20_0.buttonList[arg_20_0.selectedHero]:getParent():reorderChild(arg_20_0.buttonList[arg_20_0.selectedHero], var_21_9)
					Player:setHeroPosition(arg_20_0.buttonList[arg_20_0.selectedHero].heroId, var_21_7)

					arg_20_0.buttonList[var_21_7] = arg_20_0.buttonList[arg_20_0.selectedHero]
					arg_20_0.buttonList[arg_20_0.selectedHero] = nil
				else
					orderScale_action(arg_20_0.buttonList[arg_20_0.selectedHero], arg_20_2[var_21_7], 0.2)
					orderScale_action(arg_20_0.buttonList[var_21_7], arg_20_2[arg_20_0.selectedHero], 0.2)

					arg_20_0.buttonList[arg_20_0.selectedHero].idx, arg_20_0.buttonList[var_21_7].idx = arg_20_0.buttonList[var_21_7].idx, arg_20_0.buttonList[arg_20_0.selectedHero].idx

					local var_21_10 = (var_21_7 - 1) % 3

					arg_20_0.buttonList[arg_20_0.selectedHero]:getParent():reorderChild(arg_20_0.buttonList[arg_20_0.selectedHero], var_21_10)

					local var_21_11 = (arg_20_0.selectedHero - 1) % 3

					arg_20_0.buttonList[var_21_7]:getParent():reorderChild(arg_20_0.buttonList[var_21_7], var_21_11)
					Player:setHeroPosition(arg_20_0.buttonList[arg_20_0.selectedHero].heroId, var_21_7)
					Player:setHeroPosition(arg_20_0.buttonList[var_21_7].heroId, arg_20_0.selectedHero)

					arg_20_0.buttonList[var_21_7], arg_20_0.buttonList[arg_20_0.selectedHero] = arg_20_0.buttonList[arg_20_0.selectedHero], arg_20_0.buttonList[var_21_7]
				end
			else
				orderScale_action(arg_20_0.buttonList[arg_20_0.selectedHero], arg_20_2[arg_20_0.selectedHero], 0.2)

				local var_21_12 = (arg_20_0.selectedHero - 1) % 3

				arg_20_0.buttonList[arg_20_0.selectedHero]:getParent():reorderChild(arg_20_0.buttonList[arg_20_0.selectedHero], var_21_12)
			end
		end
	end

	arg_20_0.maskLayer = CCLayer:create()

	arg_20_0.maskLayer:addTouchEventListener(var_20_0, false, -128, false)
	arg_20_0.maskLayer:setTouchEnabled(true)
	arg_20_0:addChild(arg_20_0.maskLayer)
end

function var_0_1.viewHero(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	arg_23_0.selectedHero = nil
	arg_23_0.buttonList = {}
	arg_23_0.enemyList = {}

	arg_23_0:createHero(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	arg_23_0:createMaskLayer(arg_23_1, arg_23_2, arg_23_4)

	return arg_23_0.buttonList, arg_23_0.maskLayer
end

function var_0_1.viewEnemy(arg_24_0, arg_24_1, arg_24_2)
	table.foreach(arg_24_1, function(arg_25_0, arg_25_1)
		local var_25_0

		if arg_25_1 and (arg_25_1.heroId or arg_25_1.npcId) then
			local var_25_1 = {
				platTable = false,
				isHero = true,
				rotation = true,
				isViewQuality = false
			}

			if arg_25_1.heroId then
				var_25_1.figId = arg_25_1.heroId
				var_25_1.scale = 1
			else
				var_25_1.enemyId = arg_25_1.npcId

				if arg_25_1.npcId == 51000001 then
					arg_25_1.npcSize = 1
					var_25_1.rotation = false
				end

				var_25_1.scale = 1
			end

			local var_25_2 = figure.createHero(var_25_1)

			var_25_2:setPosition(arg_24_2[arg_25_1.battleIx - 6])

			var_25_2.idx = arg_25_1.battleIx

			if arg_25_1.heroId then
				var_25_2.heroId = var_25_1.figId
			else
				var_25_2.heroId = var_25_1.enemyId
			end

			arg_24_0.enemyList[arg_25_1.battleIx] = var_25_2

			arg_24_0:addChild(var_25_2, (arg_25_1.battleIx - 1) % 3)

			if arg_25_1.heroId then
				var_25_2:setScale(nodeScale(0))

				var_25_2.figureSize = 0
			else
				var_25_2:setScale(nodeScale(nodeNpcScale(arg_25_1.npcSize)))

				var_25_2.figureSize = nodeNpcScale(arg_25_1.npcSize)
			end

			orderScale(var_25_2, arg_24_2[arg_25_1.battleIx - 6])

			var_25_2.viewParam = {
				figureNode = var_25_2,
				rebirthCount = arg_25_1.rebirthCount,
				equipId = arg_25_1.weaponId,
				pinjie = arg_25_1.pinjie
			}

			if arg_25_1.heroId then
				var_25_2.viewParam.heroId = var_25_1.figId
			else
				var_25_2.viewParam.enemyId = var_25_1.enemyId
			end

			figure.setupFigure(var_25_2.viewParam)

			if testhalo then
				local var_25_3

				if arg_25_1.heroId then
					var_25_3 = BaseHeros[var_25_1.figId].quality
				else
					var_25_3 = BaseNPCs[var_25_1.enemyId].quality
				end

				var_25_2.halo = BattleSkeleton.createHalo(var_25_2, var_25_3)
			end
		end
	end)

	return arg_24_0.enemyList
end

function updateNodeSize(arg_26_0)
	arg_26_0:setScale(nodeScale(arg_26_0.figureSize))

	arg_26_0.order_scale_order = arg_26_0:getScale()

	orderScale(arg_26_0, BattleData:getPosition(arg_26_0.idx))
	arg_26_0.progressNode:setScale(updateBattleProgressScale(arg_26_0))
end

function var_0_1.viewHeroInfo(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = CCNode:create()

	var_27_0:setPosition(0, 350)
	arg_27_2:addChild(var_27_0)

	return var_27_0
end

function var_0_1.preloadEnemy(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = 0

	for iter_28_0, iter_28_1 in pairs(arg_28_1) do
		if iter_28_1 and (iter_28_1.heroId or iter_28_1.npcId) then
			local var_28_1

			if iter_28_1.heroId then
				local var_28_2 = "heroani/" .. BaseHeros[iter_28_1.heroId].animation .. "-1.png"
				local var_28_3 = "heroani/" .. BaseHeros[iter_28_1.heroId].animation .. ".png"

				if var_28_2 ~= CCFileUtils:sharedFileUtils():fullPathForFilename(var_28_2) then
					var_28_1 = var_28_2
				else
					var_28_1 = var_28_3
				end
			elseif iter_28_1.npcId then
				local var_28_4 = "heroani/" .. BaseNPCs[iter_28_1.npcId].animation .. "-1.png"
				local var_28_5 = "heroani/" .. BaseNPCs[iter_28_1.npcId].animation .. ".png"

				if var_28_4 ~= CCFileUtils:sharedFileUtils():fullPathForFilename(var_28_4) then
					var_28_1 = var_28_4
				else
					var_28_1 = var_28_5
				end
			end

			local function var_28_6(...)
				var_28_0 = var_28_0 + 1

				if var_28_0 >= table.nums(arg_28_1) then
					arg_28_2()
				end
			end

			CCTextureCache:sharedTextureCache():addImageAsync(var_28_1, var_28_6)
		end
	end
end

function var_0_1.hideHeroInfo(arg_30_0, arg_30_1)
	arg_30_1.prename:removeFromParentAndCleanup(true)
end

return var_0_1
