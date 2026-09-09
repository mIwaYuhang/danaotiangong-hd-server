require("base.figure")

local var_0_0 = require("base.cache")
local var_0_1 = require("scenes.ToolLayer")
local var_0_2 = class("DlgStoreTenHeroesLayer", function()
	return display.newColorLayer(ccc4(0, 0, 0, 160))
end)
local var_0_3 = 150
local var_0_4 = (CONFIG_SCREEN_WIDTH - var_0_3 * 5) / 2 + 50
local var_0_5 = {
	Adapter.AutoPos(var_0_4 + var_0_3 * 0, 370),
	Adapter.AutoPos(var_0_4 + var_0_3 * 1, 370),
	Adapter.AutoPos(var_0_4 + var_0_3 * 2, 370),
	Adapter.AutoPos(var_0_4 + var_0_3 * 3, 370),
	Adapter.AutoPos(var_0_4 + var_0_3 * 4, 370),
	Adapter.AutoPos(var_0_4 + var_0_3 * 0, 100),
	Adapter.AutoPos(var_0_4 + var_0_3 * 1, 100),
	Adapter.AutoPos(var_0_4 + var_0_3 * 2, 100),
	Adapter.AutoPos(var_0_4 + var_0_3 * 3, 100),
	(Adapter.AutoPos(var_0_4 + var_0_3 * 4, 100))
}
local var_0_6 = {
	Adapter.AutoPos(var_0_4 + var_0_3 * 0 - 80, 400),
	Adapter.AutoPos(var_0_4 + var_0_3 * 1 - 80, 400),
	Adapter.AutoPos(var_0_4 + var_0_3 * 2 - 80, 400),
	Adapter.AutoPos(var_0_4 + var_0_3 * 3 - 80, 400),
	Adapter.AutoPos(var_0_4 + var_0_3 * 4 - 150, 400),
	Adapter.AutoPos(var_0_4 + var_0_3 * 0 - 80, 230),
	Adapter.AutoPos(var_0_4 + var_0_3 * 1 - 80, 230),
	Adapter.AutoPos(var_0_4 + var_0_3 * 2 - 80, 230),
	Adapter.AutoPos(var_0_4 + var_0_3 * 3 - 80, 230),
	(Adapter.AutoPos(var_0_4 + var_0_3 * 4 - 150, 230))
}
local var_0_7 = print

function var_0_2.ctor(arg_2_0, arg_2_1)
	arg_2_0.reward = arg_2_1.retInfo.ActivityRewardLst
	arg_2_0.recruitType = arg_2_1.retInfo.Type

	arg_2_0:addTouchEventListener(function()
		return true
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.back_size = CCSizeMake(CONFIG_SCREEN_WIDTH, CONFIG_SCREEN_HEIGHT)

	local var_2_0 = 9.5

	if arg_2_1.retInfo.bGenericD then
		var_2_0 = 8
	end

	if arg_2_1.retInfo.NeedIngot then
		local var_2_1 = arg_2_1.retInfo.NeedIngot * var_2_0 * (arg_2_1.retInfo.bFTenD or 1)

		if arg_2_1.retInfo.bSTenD and (not arg_2_1.retInfo.VipLv or Player.vipLevel >= arg_2_1.retInfo.VipLv) then
			var_2_1 = var_2_1 * arg_2_1.retInfo.bSTenD
		end

		local var_2_2 = createItemCountNode({
			type = ItemType.eGold,
			value = var_2_1,
			color = ccc3(255, 255, 0)
		})

		var_2_2.itemSprite:setScale(Adapter.MinScale)
		var_2_2:setPosition(Adapter.AutoPos(370, 15))

		local var_2_3 = var_2_2:getContentSize()

		arg_2_0:addChild(var_2_2)

		if arg_2_1.retInfo.TenPrice then
			local var_2_4 = CCSprite:create("ui/store/store_035.png")

			var_2_4:setAnchorPoint(ccp(0.5, 0.5))
			var_2_4:setPosition(ccp(30, var_2_3.height / 2))
			var_2_4:setScaleX(Adapter.MinScale * 0.55)
			var_2_2:addChild(var_2_4)

			local var_2_5 = arg_2_1.retInfo.TenPrice

			addLabelWithColorSize(arg_2_0, string.lf("%d", var_2_5), ccc3(255, 255, 0), 20, ccp(0.5, 0.5), Adapter.AutoPos(480, 15))
		end
	end

	if arg_2_1.retInfo.bSTenD then
		local var_2_6 = string.lf("#5CACEE本次#EEEE00%d#5CACEE折", arg_2_1.retInfo.bSTenD * 10)

		if arg_2_1.retInfo.VipLv then
			var_2_6 = string.lf("#E42020Vip%d及以上", arg_2_1.retInfo.VipLv) .. var_2_6

			if Player.vipLevel >= arg_2_1.retInfo.VipLv then
				var_2_6 = var_2_6 .. string.lf("(已打折)")
			end
		end

		addLabelWithColorSize(arg_2_0, var_2_6, ccc3(228, 32, 32), 22, ccp(0, 0.5), Adapter.AutoPos(450, 15))
	end

	local var_2_7 = ui.newControlButton({
		titleImage = "uilocal/store/store_text_062.png",
		normalImage = "ui/common/common_109.png",
		size = CCSize(150, 60),
		position = Adapter.AutoPos(390, 50),
		clickAction = function()
			arg_2_0:removeFromParentAndCleanup(true)
			CCSpriteFrameCache:sharedSpriteFrameCache():removeUnusedSpriteFrames()
			CCDirector:sharedDirector():purgeCachedData()

			if arg_2_1.recruitAgain then
				arg_2_1.recruitAgain()
			end
		end,
		scaleX = Adapter.MinScale,
		scaleY = Adapter.MinScale
	})

	var_2_7:setEnabled(false)
	var_2_7:setVisible(false)
	arg_2_0:addChild(var_2_7)

	local var_2_8

	if arg_2_0.recruitType == 4 then
		var_2_8 = Adapter.AutoPos(460, 50)
	end

	if arg_2_0.recruitType ~= 4 then
		var_2_8 = Adapter.AutoPos(570, 50)
	end

	local var_2_9 = ui.newControlButton({
		titleImage = "uilocal/store/store_text_023.png",
		normalImage = "ui/common/common_109.png",
		size = CCSize(150, 60),
		position = var_2_8,
		clickAction = function()
			arg_2_0:removeFromParentAndCleanup(true)
			CCSpriteFrameCache:sharedSpriteFrameCache():removeUnusedSpriteFrames()
			CCDirector:sharedDirector():purgeCachedData()
		end,
		scaleX = Adapter.MinScale,
		scaleY = Adapter.MinScale
	})

	var_2_9:setEnabled(false)
	arg_2_0:addChild(var_2_9)

	local function var_2_10()
		for iter_6_0, iter_6_1 in ipairs(arg_2_1.retInfo.Reward or {}) do
			if iter_6_1.Type == ItemType.eEquip then
				arg_2_0:showEquipReward(iter_6_1)

				break
			end
		end

		var_2_9:setEnabled(true)

		if arg_2_0.recruitType ~= 4 then
			var_2_7:setEnabled(true)
			var_2_7:setVisible(true)
		end

		if arg_2_0.reward ~= nil then
			local var_6_0 = require("scenes.store.ShowTaoTieRewardLayer").new({
				arg_2_0.reward
			})

			display.getRunningScene():addChild(var_6_0)
		end
	end

	arg_2_0:showAllHeroes(arg_2_1.retInfo.TenLst, var_2_10)
end

function var_0_2.showEquipReward(arg_7_0, arg_7_1)
	local var_7_0 = display.newSprite("ui/guild/guild_090.png", display.cx, display.cy)

	var_7_0:setScale(Adapter.MinScale)
	arg_7_0:addChild(var_7_0)

	local var_7_1 = var_7_0:getContentSize()
	local var_7_2 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/guild/guild_text_035.png",
		position = ccp(var_7_1.width / 2, 40),
		clickAction = function()
			var_7_0:removeFromParent()
		end
	})

	var_7_0:addChild(var_7_2)
	addLabelWithColorSize(var_7_0, string.lf("获得专属装备"), ccc3(255, 228, 0), 24, ccp(0.5, 1), ccp(var_7_1.width / 2, var_7_1.height - 20))

	local var_7_3 = figure.createHeader({
		isName = true,
		type = arg_7_1.Type,
		itemId = arg_7_1.ID or 0,
		count = arg_7_1.Count,
		nameColor = getQualityColor(getItemQuality(arg_7_1.Type, arg_7_1.ID)),
		equipJieji = arg_7_1.BreakthroughCount,
		countColor = ccc3(255, 228, 0),
		clickAction = function()
			var_0_1.tipshandler(arg_7_1)
		end
	})

	var_7_0:addChild(var_7_3)
	var_7_3:setPosition(var_7_1.width / 2, var_7_1.height / 2 + 20)
end

function var_0_2.showAllHeroes(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {}

	for iter_10_0 = 10, 1, -1 do
		var_10_0[iter_10_0] = arg_10_0:createHeroNode(arg_10_1[iter_10_0], var_0_6[iter_10_0])

		var_10_0[iter_10_0]:setPosition(Adapter.AutoPos(480, 150))
		var_10_0[iter_10_0]:setVisible(false)
		var_10_0[iter_10_0]:setZOrder(11 - iter_10_0)
		arg_10_0:addChild(var_10_0[iter_10_0])
	end

	local var_10_1 = 0.2

	arg_10_0.a = 0

	local function var_10_2(arg_11_0)
		local var_11_0 = CCArray:create()

		var_11_0:addObject(CCMoveTo:create(var_10_1, var_0_5[arg_11_0]))
		var_11_0:addObject(CCScaleTo:create(var_10_1, 0.5 * Adapter.MinScale))

		local var_11_1 = transition.sequence({
			CCDelayTime:create(var_10_1 / 2),
			CCCallFunc:create(function()
				var_10_0[arg_11_0]:setZOrder(0)
			end)
		})

		var_11_0:addObject(var_11_1)
		transition.execute(var_10_0[arg_11_0], transition.sequence({
			CCCallFunc:create(function()
				var_10_0[arg_11_0]:setVisible(true)
			end),
			CCDelayTime:create(var_10_1),
			CCSpawn:create(var_11_0)
		}), {
			delay = (var_10_1 + 0) * (arg_11_0 - 1),
			onComplete = function()
				if arg_11_0 == 10 then
					arg_10_2()
				end
			end
		})
	end

	local function var_10_3()
		for iter_15_0 = 1, 10 do
			var_10_2(iter_15_0)
		end
	end

	local var_10_4 = "yin"

	if arg_10_0.recruitType == 1 then
		var_10_4 = "tong"
	elseif arg_10_0.recruitType == 2 then
		var_10_4 = "yin"
	elseif arg_10_0.recruitType == 3 then
		var_10_4 = "jin"
	elseif arg_10_0.recruitType == 4 then
		var_10_4 = "jin"
	end

	local var_10_5 = CCSkeletonAnimation:createWithFile("effectAni/ui_zhujiang.json", "effectAni/ui_zhujiang.atlas", 1)

	var_10_5:setScale(Adapter.MinScale)
	var_10_5:setAnimation(var_10_4, false, 0)
	var_10_5:setPosition(display.cx, display.cy)
	arg_10_0:addChild(var_10_5, 100)
	var_10_5:setTest(2, false, false, true)
	var_10_5:addAnimationAction(var_10_4, 1, CCCallFunc:create(var_10_3), AAT_Percent)
end

function var_0_2.createHeroNode(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0

	if arg_16_1.Type == ItemType.eSoul then
		var_16_0 = BaseSouls[arg_16_1.ID].figureId
	else
		var_16_0 = arg_16_1.ID
	end

	local var_16_1 = BaseHeros[var_16_0]
	local var_16_2 = getHeroGroupWeaponId(var_16_0)
	local var_16_3 = {
		isViewBaseInfo = false,
		figId = var_16_0,
		equipId = var_16_2,
		pinjie = EquipPinjieType.eShengPin,
		scale = 0.9 * Adapter.MinScale,
		rebirthCount = arg_16_1.BreakthroughCount,
		clickAction = function()
			local var_17_0 = var_0_1.createTips({
				player = false,
				show = var_0_1.eShowTujianHero,
				id = var_16_0
			})

			var_17_0:show({
				parent = arg_16_0,
				x = arg_16_2.x,
				y = arg_16_2.y,
				align = display.CENTER_LEFT
			})
			var_17_0.container:setScale(Adapter.MinScale)
		end
	}
	local var_16_4 = figure.createHero(var_16_3)

	if arg_16_1.Type == ItemType.eSoul then
		local var_16_5 = var_16_4:getContentSize()
		local var_16_6 = display.newSprite("uilocal/enhance/enhance_txt_002.png")

		var_16_6:setAnchorPoint(CCPoint(0.5, 0))
		var_16_6:setPosition(CCPoint(var_16_5.width / 2, 40))
		var_16_4:addChild(var_16_6)
	end

	local var_16_7 = display.newSprite(getProfessionIconImageName(var_16_1.profession), -60, 415)

	var_16_4:addChild(var_16_7)
	addLabelWithColorSize(var_16_4, var_16_1.name, getQualityColor(var_16_1.quality), 24, ccp(0, 0.5), ccp(-40, 415))

	return var_16_4
end

return var_0_2
