require("base.figure")
require("data.MineralHelper")

EnhanceType = {
	eEquipRebirth = 2,
	eEquipRefine = 1,
	eEquipCompound = 3
}

local var_0_0 = class("RefineScene", function()
	return display.newScene("RefineScene")
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	local var_2_0

	if arg_2_1 ~= nil and arg_2_1.refineTag ~= nil then
		var_2_0 = {
			refineTag = arg_2_1.refineTag
		}
	end

	local var_2_1 = require("scenes.CommonBgLayer").new({
		titleSprite = "uilocal/enhance/enhance_txt_009.png",
		returnAction = function(arg_3_0, arg_3_1)
			if arg_2_1 and arg_2_1.transferData then
				game.enterTransferEffectScene(arg_2_1.transferData)
			elseif arg_2_1 and arg_2_1.enterFromFeed then
				if arg_2_1.equipEnhance then
					game.enterEnhanceScene({
						from = "equipscene"
					})
				else
					game.enterTeamScene({})
				end
			elseif arg_2_1 and arg_2_1.mysticStore then
				game.enterMysticStoreScene()
			else
				game.enterHomeScene()
			end
		end
	})

	arg_2_0:addChild(var_2_1)

	arg_2_0.bgSprite = var_2_1:getBackgroundSprite()

	local var_2_2 = display.newScale9Sprite("ui/enhance/enhance_008.jpg", 480, 5, CCSize(950, 570))

	var_2_2:setAnchorPoint(CCPoint(0.5, 0))
	arg_2_0.bgSprite:addChild(var_2_2, 0)

	local var_2_3 = createPlayerAttrNode({
		ItemType.eGold
	})

	var_2_3:setPosition(360, 578)
	arg_2_0.bgSprite:addChild(var_2_3)

	local var_2_4 = createPlayerAttrNode({
		ItemType.eSoulJade
	})

	var_2_4:setPosition(580, 578)
	arg_2_0.bgSprite:addChild(var_2_4)
	var_2_4:setVisible(false)

	local var_2_5 = createPlayerAttrNode({
		ItemType.eHeroExp
	})

	var_2_5:setPosition(580, 578)
	arg_2_0.bgSprite:addChild(var_2_5)
	var_2_5:setVisible(false)

	if Player.level >= 80 then
		MineralHelper:getMineralList(function(arg_4_0)
			return
		end, 0)
	end

	local function var_2_6(arg_5_0)
		local function var_5_0(arg_6_0, arg_6_1)
			if arg_6_0 ~= nil then
				arg_6_0:setVisible(arg_6_1)
			end
		end

		if arg_5_0 == EnhanceType.eEquipRefine then
			var_5_0(arg_2_0.hLightRebirth, false)
			var_5_0(arg_2_0.hLightCompound, false)

			if arg_2_0.hLightRefine == nil then
				arg_2_0.hLightRefine = display.newSprite("ui/team/team_133.png", 130, 530)

				arg_2_0.bgSprite:addChild(arg_2_0.hLightRefine)
			else
				arg_2_0.hLightRefine:setVisible(true)
			end
		elseif arg_5_0 == EnhanceType.eEquipRebirth then
			var_5_0(arg_2_0.hLightRefine, false)
			var_5_0(arg_2_0.hLightCompound, false)

			if arg_2_0.hLightRebirth == nil then
				arg_2_0.hLightRebirth = display.newSprite("ui/team/team_133.png", 285, 530)

				arg_2_0.bgSprite:addChild(arg_2_0.hLightRebirth)
			else
				arg_2_0.hLightRebirth:setVisible(true)
			end
		elseif arg_5_0 == EnhanceType.eEquipCompound then
			var_5_0(arg_2_0.hLightRefine, false)
			var_5_0(arg_2_0.hLightRebirth, false)

			if arg_2_0.hLightCompound == nil then
				arg_2_0.hLightCompound = display.newSprite("ui/team/team_133.png", 430, 530)

				arg_2_0.bgSprite:addChild(arg_2_0.hLightCompound)
			else
				arg_2_0.hLightCompound:setVisible(true)
			end
		end
	end

	local function var_2_7(arg_7_0, arg_7_1, arg_7_2)
		GuideLayer:removeOneGuideLayer(TaskEntryType.eRefining)
		arg_2_0:switchToTypeLayer(var_2_4, var_2_5, EnhanceType.eEquipRebirth)

		if arg_2_0.rebirthLayer == nil then
			if arg_7_2 ~= nil then
				arg_2_0.rebirthLayer = require("scenes.enhance.RebirthLayer").new({
					refineTag = arg_7_2
				})
			else
				arg_2_0.rebirthLayer = require("scenes.enhance.RebirthLayer").new(var_2_0)
			end

			arg_2_0.rebirthLayer:setContentSize(CCSize(CONFIG_SCREEN_WIDTH, CONFIG_SCREEN_HEIGHT))
			arg_2_0.bgSprite:addChild(arg_2_0.rebirthLayer)

			var_2_0 = nil
		else
			arg_2_0.rebirthLayer:reloadData(arg_7_2)
			arg_2_0.rebirthLayer:setVisible(true)
		end

		var_2_6(EnhanceType.eEquipRebirth)
	end

	local function var_2_8(arg_8_0, arg_8_1)
		arg_2_0:switchToTypeLayer(var_2_4, var_2_5, EnhanceType.eEquipRefine)

		if arg_2_0.refineLayer == nil then
			local function var_8_0(arg_9_0)
				var_2_7(nil, nil, arg_9_0)
			end

			if var_2_0 then
				var_2_0.rebirthAction = var_8_0
			else
				var_2_0 = {
					rebirthAction = var_8_0,
					refineScene = arg_2_0,
					parentBgSprite = arg_2_0.bgSprite
				}
			end

			arg_2_0.refineLayer = require("scenes.enhance.RefineLayer").new(var_2_0)

			arg_2_0.refineLayer:setContentSize(CCSize(CONFIG_SCREEN_WIDTH, CONFIG_SCREEN_HEIGHT))
			arg_2_0.bgSprite:addChild(arg_2_0.refineLayer)

			var_2_0 = nil
		else
			arg_2_0.refineLayer:reloadData()
			arg_2_0.refineLayer:setVisible(true)
		end

		var_2_6(EnhanceType.eEquipRefine)
	end

	local function var_2_9(arg_10_0, arg_10_1)
		arg_2_0:switchToTypeLayer(var_2_4, var_2_5, EnhanceType.eEquipCompound)

		if arg_2_0.compositeLayer == nil then
			local function var_10_0(arg_11_0)
				var_2_7(nil, nil, arg_11_0)
			end

			if var_2_0 then
				var_2_0.rebirthAction = var_10_0
			else
				var_2_0 = {
					rebirthAction = var_10_0,
					refineScene = arg_2_0,
					parentBgSprite = arg_2_0.bgSprite
				}
			end

			arg_2_0.compositeLayer = require("scenes.enhance.ComposeLayer").new(var_2_0)

			arg_2_0.compositeLayer:setContentSize(CCSize(CONFIG_SCREEN_WIDTH, CONFIG_SCREEN_HEIGHT))
			arg_2_0.bgSprite:addChild(arg_2_0.compositeLayer)

			var_2_0 = nil
		else
			arg_2_0.compositeLayer:reloadData()
			arg_2_0.compositeLayer:setVisible(true)
		end

		var_2_6(EnhanceType.eEquipCompound)
	end

	arg_2_0.refineButton = ui.newControlButton({
		normalImage = "ui/team/team_136.png",
		position = ccp(130, 530),
		clickAction = var_2_8
	})

	arg_2_0.bgSprite:addChild(arg_2_0.refineButton)

	arg_2_0.rebirthButton = ui.newControlButton({
		normalImage = "ui/team/team_135.png",
		position = ccp(285, 530),
		clickAction = var_2_7
	})

	arg_2_0.bgSprite:addChild(arg_2_0.rebirthButton)

	arg_2_0.compoundButton = ui.newControlButton({
		normalImage = "ui/team/team_134.png",
		position = ccp(430, 530),
		clickAction = var_2_9
	})

	arg_2_0.bgSprite:addChild(arg_2_0.compoundButton)

	if arg_2_1 ~= nil and arg_2_1.defaultType ~= nil then
		if arg_2_1.defaultType == EnhanceType.eEquipRebirth then
			var_2_7("", nil)
		else
			var_2_9("", nil)
		end
	else
		var_2_8("", nil)
	end

	arg_2_0:createTouchEventLayer(arg_2_0.bgSprite)
end

function var_0_0.switchToTypeLayer(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_1:setVisible(arg_12_3 == EnhanceType.eEquipRefine)
	arg_12_2:setVisible(arg_12_3 == EnhanceType.eEquipRebirth)

	local function var_12_0(arg_13_0)
		return arg_13_0 == arg_12_3 and ColorTable.eTitleTabButton_Selected or ColorTable.eTitleTabButton_Normal
	end

	local function var_12_1(arg_14_0, arg_14_1)
		if arg_14_1 == 1 then
			if arg_14_0 then
				return CCScale9Sprite:create("ui/team/team_136.png")
			else
				return CCScale9Sprite:create("ui/team/team_136.png")
			end
		end

		if arg_14_1 == 2 then
			if arg_14_0 then
				return CCScale9Sprite:create("ui/team/team_135.png")
			else
				return CCScale9Sprite:create("ui/team/team_135.png")
			end
		end

		if arg_14_1 == 3 then
			if arg_14_0 then
				return CCScale9Sprite:create("ui/team/team_134.png")
			else
				return CCScale9Sprite:create("ui/team/team_134.png")
			end
		end
	end

	arg_12_0.refineButton:setBackgroundSpriteForState(var_12_1(arg_12_3 == EnhanceType.eEquipRefine, 1), CCControlStateNormal)
	arg_12_0.refineButton:setLabelColorForAllStates(var_12_0(EnhanceType.eEquipRefine))
	arg_12_0.rebirthButton:setBackgroundSpriteForState(var_12_1(arg_12_3 == EnhanceType.eEquipRebirth, 2), CCControlStateNormal)
	arg_12_0.rebirthButton:setLabelColorForAllStates(var_12_0(EnhanceType.eEquipRebirth))
	arg_12_0.compoundButton:setBackgroundSpriteForState(var_12_1(arg_12_3 == EnhanceType.eEquipCompound, 3), CCControlStateNormal)
	arg_12_0.compoundButton:setLabelColorForAllStates(var_12_0(EnhanceType.eEquipCompound))

	if arg_12_0.rebirthLayer ~= nil then
		arg_12_0.rebirthLayer:setVisible(arg_12_3 == EnhanceType.eEquipRebirth)
	end

	if arg_12_0.refineLayer ~= nil then
		arg_12_0.refineLayer:setVisible(arg_12_3 == EnhanceType.eEquipRefine)
	end

	if arg_12_0.compositeLayer ~= nil then
		arg_12_0.compositeLayer:setVisible(arg_12_3 == EnhanceType.eEquipCompound)
	end
end

function var_0_0.touchBeginEvent(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0._touchBeginPos = ccp(arg_15_1, arg_15_2)
	arg_15_0._touchEndPos = ccp(arg_15_1, arg_15_2)
	arg_15_0._isMoveMode = false

	local var_15_0

	if arg_15_0.refineLayer ~= nil then
		var_15_0 = arg_15_0.refineLayer.equipRefineLayer:getNearestGridItem(arg_15_1, arg_15_2)
	end

	arg_15_0.findItem = var_15_0

	if var_15_0 ~= nil then
		local function var_15_1()
			if ccpDistance(arg_15_0._touchBeginPos, arg_15_0._touchEndPos) < 5 then
				arg_15_0._isMoveMode = true

				var_15_0.equipNode:setHeaderOpacity(140)

				arg_15_0.tmpTouchHeaderButton = figure.createHeader({
					type = var_15_0.equipItem.Type,
					itemId = var_15_0.equipItem.ID
				})

				arg_15_0.tmpTouchHeaderButton:setScale(Adapter.MinScale)
				arg_15_0.tmpTouchHeaderButton:setPosition(ccp(arg_15_1, arg_15_2))
				display.getRunningScene():addChild(arg_15_0.tmpTouchHeaderButton)
			end
		end

		local var_15_2 = CCArray:create()

		var_15_2:addObject(CCDelayTime:create(0.1))
		var_15_2:addObject(CCCallFunc:create(var_15_1))

		arg_15_0.checkAction = CCSequence:create(var_15_2)

		arg_15_0:runAction(arg_15_0.checkAction)

		return true
	else
		return false
	end
end

function var_0_0.touchMoveEvent(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0._touchEndPos = ccp(arg_17_1, arg_17_2)

	if arg_17_0._isMoveMode == true then
		if arg_17_0.tmpTouchHeaderButton then
			arg_17_0.tmpTouchHeaderButton:setPosition(ccp(arg_17_1, arg_17_2))
		end

		return
	end
end

function var_0_0.createTouchEventLayer(arg_18_0, arg_18_1)
	local var_18_0 = display.newLayer()

	local function var_18_1(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == "began" then
			return arg_18_0:touchBeginEvent(arg_19_1, arg_19_2)
		elseif arg_19_0 == "moved" then
			arg_18_0:touchMoveEvent(arg_19_1, arg_19_2)
		elseif arg_19_0 == "ended" or arg_19_0 == "cancelled" then
			arg_18_0:stopAction(arg_18_0.checkAction)

			if arg_18_0._isMoveMode == false then
				return
			end

			arg_18_0.findItem.equipNode:setHeaderOpacity(255)

			if arg_18_0.tmpTouchHeaderButton ~= nil then
				arg_18_0.tmpTouchHeaderButton:removeFromParentAndCleanup(true)

				arg_18_0.tmpTouchHeaderButton = nil
			end

			if ccpDistance(arg_18_0._touchBeginPos, arg_18_0._touchEndPos) > 80 and arg_18_0.refineLayer ~= nil then
				arg_18_0.refineLayer.equipRefineLayer:removeItemFromGrid(arg_18_0.findItem)
			end
		end
	end

	var_18_0:addTouchEventListener(var_18_1, false, -128, false)
	var_18_0:setTouchEnabled(true)
	arg_18_1:addChild(var_18_0)
end

return var_0_0
