require("base.define")
require("base.figure")
require("data.player")
require("data.task")
require("scenes.GuideLayer")

local var_0_0 = require("base.cache")
local var_0_1 = require("framework.scheduler")

StoreType = {
	eStoreGift = 3,
	eStoreProp = 2,
	eStoreRecharge = 10,
	eStoreHero = 1,
	eStoreRefine = 21,
	eStoreRebirth = 22,
	eStoreSuit = 4,
	eStoreMystic = 5
}

local var_0_2 = {}
local var_0_3 = class("StoreScene", function()
	return display.newScene("StoreScene")
end)

function var_0_3.ctor(arg_2_0, arg_2_1)
	arg_2_0.params = arg_2_1

	if not arg_2_1 then
		local var_2_0 = var_0_0.get("store-tag")

		arg_2_1 = {
			defaultPage = var_2_0
		}

		var_0_0.set("store-tag", false)
	end

	arg_2_0.container = nil
	arg_2_0.tabview = nil
	arg_2_0.defaultPage = arg_2_1.defaultPage or StoreType.eStoreHero
	arg_2_1.parent = arg_2_0
	arg_2_0.params = arg_2_1

	local var_2_1 = require("scenes.CommonBgLayer").new({
		titleSprite = "uilocal/store/store_text_005.png",
		returnAction = function(arg_3_0, arg_3_1)
			if arg_2_0.params.fromChangeFigureScene == true then
				game.enterTeamScene({})

				return
			end

			if arg_2_0.params and arg_2_0.params.returnAction then
				arg_2_0.params.returnAction()
			else
				game.enterHomeScene()
			end
		end
	})
	local var_2_2 = var_2_1:getBackgroundSprite()
	local var_2_3 = var_2_2:getContentSize()

	arg_2_0:addChild(var_2_1)

	arg_2_0.container = var_2_2

	local var_2_4 = createPlayerAttrNode({
		ItemType.eGold,
		ItemType.eCoin
	})

	var_2_4:setPosition(490, 578)
	arg_2_0.container:addChild(var_2_4)

	local var_2_5 = ui.newControlButton({
		normalImage = "ui/common/common_110.png",
		clickAction = function(arg_4_0, arg_4_1)
			local var_4_0 = arg_2_0.tabview:getCurrentTag()

			var_0_0.set("store-tag", var_4_0)
			game.enterStoreRechargeScene()
		end
	})

	var_2_5:setPosition(860, var_2_3.height - 95)
	var_2_2:addChild(var_2_5)

	local var_2_6 = var_2_5:getContentSize()
	local var_2_7 = display.newSprite("uilocal/store/store_text_011.png")

	var_2_7:setPosition(var_2_6.width / 2, var_2_6.height / 2)
	var_2_5:addChild(var_2_7)

	local var_2_8 = {
		80,
		220,
		360,
		500,
		640
	}
	local var_2_9 = {
		{
			tag = 0,
			x = 0,
			storeType = StoreType.eStoreHero,
			titleText = string.lf("点主将")
		},
		{
			tag = 0,
			x = 0,
			storeType = StoreType.eStoreProp,
			titleText = string.lf("道具")
		}
	}

	if Player.serverVipEnable ~= 0 then
		local var_2_10 = {
			tag = 0,
			x = 0,
			storeType = StoreType.eStoreGift,
			titleText = string.lf("VIP礼包")
		}

		table.insert(var_2_9, var_2_10)
	end

	if Player.isShowSuitProp > 0 then
		local var_2_11 = {
			tag = 0,
			x = 0,
			storeType = StoreType.eStoreSuit,
			titleText = string.lf("专属礼包")
		}

		table.insert(var_2_9, var_2_11)
	end

	local var_2_12 = {
		tag = 0,
		x = 0,
		storeType = StoreType.eStoreMystic,
		titleText = string.lf("神秘商店")
	}

	table.insert(var_2_9, var_2_12)

	for iter_2_0, iter_2_1 in ipairs(var_2_9) do
		iter_2_1.tag = iter_2_0
		iter_2_1.x = var_2_8[iter_2_0]

		if iter_2_1.storeType == arg_2_0.defaultPage then
			iter_2_1.isDefault = true
		end
	end

	local var_2_13 = require("scenes.TabLayer").new({
		disabledImage = "ui/common/common_023_2.png",
		selectedImage = "ui/common/common_023.png",
		normalImage = "ui/common/common_022.png",
		size = CCSize(940, 500),
		point = ccp(10, 12),
		config = var_2_9,
		cellHandler = function(arg_5_0, arg_5_1)
			local var_5_0 = var_2_9[arg_5_1].storeType

			var_0_2 = {}

			if var_5_0 == StoreType.eStoreMystic then
				if Player.level < GameFeaturesLevel[GameFeatures.eMysticStore].level then
					showFlashNotice(string.lf("神秘商店暂未开放."))
				else
					game.enterMysticStoreScene({
						curIndex = arg_2_0.curIndex
					})
				end
			else
				({
					[StoreType.eStoreHero] = arg_2_0.createHeroLayer,
					[StoreType.eStoreProp] = arg_2_0.createPropLayer,
					[StoreType.eStoreGift] = arg_2_0.createGiftLayer,
					[StoreType.eStoreSuit] = arg_2_0.createSuitLayer
				})[var_5_0](arg_2_0, arg_5_0)

				arg_2_0.curIndex = arg_5_1
			end

			GuideLayer:removeGuideLayerIfStepGreaterThan(TaskEntryType.eZhaoJiang, 1)
		end
	})

	var_2_2:addChild(var_2_13)

	arg_2_0.tabview = var_2_13

	local var_2_14 = arg_2_0.tabview.menuItems

	var_2_14[#var_2_14]:addHandleOfControlEvent(function(arg_6_0, arg_6_1)
		local var_6_0 = Player.level
		local var_6_1 = GameFeaturesLevel[GameFeatures.eMysticStore].level

		if var_6_0 < var_6_1 then
			showFlashNotice(string.lf("神秘商店 %d级开放！", var_6_1))
		else
			game.enterMysticStoreScene({
				curIndex = arg_2_0.curIndex
			})
		end
	end, CCControlEventTouchUpInside)

	var_0_2 = {}

	arg_2_0:addSchedule()
end

function var_0_3.onExit(arg_7_0)
	arg_7_0:removeSchedule()
end

function var_0_3.createHeroLayer(arg_8_0, arg_8_1)
	local var_8_0 = require("scenes.store.StoreHeroLayer").new(arg_8_0.params)

	var_8_0:setPosition(0, 4)
	arg_8_1:addChild(var_8_0)
end

function var_0_3.createPropLayer(arg_9_0, arg_9_1)
	local var_9_0 = require("scenes.store.StorePropLayer").new(arg_9_0.params)

	var_9_0:setPosition(0, 4)
	arg_9_1:addChild(var_9_0)
end

function var_0_3.createGiftLayer(arg_10_0, arg_10_1)
	local var_10_0 = require("scenes.store.StoreVipLayer").new(arg_10_0.params)

	var_10_0:setPosition(0, 4)
	arg_10_1:addChild(var_10_0)
end

function var_0_3.createSuitLayer(arg_11_0, arg_11_1)
	local var_11_0 = require("scenes.store.StoreZoneLayer").new(arg_11_0.params)

	var_11_0:setPosition(0, 4)
	arg_11_1:addChild(var_11_0)
end

function var_0_3.addSchedule(arg_12_0)
	if arg_12_0.scheduleHandle == nil then
		arg_12_0.scheduleHandle = require("framework.scheduler").scheduleGlobal(handler(arg_12_0, arg_12_0.scheduleCallback), 1)
	end
end

function var_0_3.removeSchedule(arg_13_0)
	if arg_13_0.scheduleHandle then
		require("framework.scheduler").unscheduleGlobal(arg_13_0.scheduleHandle)

		arg_13_0.scheduleHandle = nil
	end
end

function var_0_3.scheduleCallback(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in pairs(var_0_2) do
		if iter_14_1.callback then
			iter_14_1.callback()
		end
	end
end

function var_0_3.addToTimerTable(arg_15_0, arg_15_1)
	if arg_15_1 == nil then
		return
	end

	table.insert(var_0_2, arg_15_1)
end

function var_0_3.removeFromTimerTable(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in pairs(var_0_2) do
		if iter_16_1.callback == arg_16_1 then
			table.remove(var_0_2, iter_16_0)

			break
		end
	end
end

return var_0_3
