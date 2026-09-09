require("network.StoreRequest")

local var_0_0 = require("base.cache")
local var_0_1 = class("StoreHeroLayer", function()
	return display.newScale9Sprite("ui/store/store_012.jpg")
end)
local var_0_2 = {
	findInBai = 1,
	findInWan = 3,
	findInQian = 2
}
local var_0_3
local var_0_4 = {}
local var_0_5 = {}

function var_0_1.ctor(arg_2_0, arg_2_1)
	local var_2_0 = CCSize(940, 500)

	arg_2_0:setPreferredSize(var_2_0)
	arg_2_0:setAnchorPoint(CCPoint(0, 0))
	arg_2_0:setPosition(CCPoint(0, 0))

	local var_2_1 = arg_2_0

	arg_2_0.background = CCLayerColor:create(ccc4(0, 0, 0, 0))

	arg_2_0.background:setContentSize(var_2_0)
	var_2_1:addChild(arg_2_0.background)

	arg_2_0.back_size = var_2_0
	arg_2_0.buyHeroNums = 0

	if arg_2_1.parent then
		var_0_3 = arg_2_1.parent
	end

	arg_2_0:showInitLayer()
	arg_2_0:initRequests()
	arg_2_0.heroInfoRequest:request()
end

function var_0_1.initRequests(arg_3_0)
	local function var_3_0()
		for iter_4_0, iter_4_1 in pairs(arg_3_0.heroInfoRequest.restable) do
			if iter_4_1.HaveOrangeTime then
				var_0_5 = iter_4_1
			end

			arg_3_0:showOneType(iter_4_1)
		end

		if Player:getTroMaxStep() == NSStep.XuanJiang then
			GuideLayer:showNewbieGuideLayer(var_0_3, arg_3_0, 2, function()
				arg_3_0.heroRecruitRequest:request(var_0_2.findInWan)

				return false
			end, nil, true)
		end

		GuideLayer:showGuideLayer(var_0_3, arg_3_0.backType1, TaskEntryType.eZhaoJiang, 2, nil, true)
		GuideLayer:showGuideLayer(var_0_3, arg_3_0.backType1, TaskEntryType.eEntryBattleHero, 3, ccp(146, 100), true)
	end

	arg_3_0.heroInfoRequest = StoreHeroInfoRequest:new(var_0_3)

	arg_3_0.heroInfoRequest:setResponseNormalHandler(var_3_0)

	local function var_3_1()
		GuideLayer:removeOneGuideLayer(TaskEntryType.eZhaoJiang)
		GuideLayer:removeOneGuideLayer(TaskEntryType.eEntryBattleHero)

		arg_3_0.buyHeroNums = arg_3_0.buyHeroNums + 1

		if arg_3_0.buyHeroNums > 5 then
			print("释放资源释放资源释放资源")

			arg_3_0.buyHeroNums = 0

			CCSpriteFrameCache:sharedSpriteFrameCache():removeUnusedSpriteFrames()
			CCDirector:sharedDirector():purgeCachedData()
		end

		local var_6_0 = arg_3_0.heroRecruitRequest.restable
		local var_6_1 = var_6_0.Type

		var_0_4[var_6_1].moneyLabel:setString(var_6_0.NeedIngot)

		if var_6_0.HaveTimes == 0 then
			var_0_4[var_6_1].timeLabel:setString(string.lf("现在可以免费获取"))
			var_0_4[var_6_1].moneyLabel:setString(0)
		else
			var_0_4[var_6_1].remainTime = var_6_0.HaveTimes
		end

		if var_6_0.Reward == nil or var_6_0.Reward[1] == nil then
			showFlashNotice(string.lf("主将信息为空，请联系服务端"))

			return
		end

		local var_6_2 = ""

		if var_6_1 == var_0_2.findInBai then
			var_6_2 = "tong"
		elseif var_6_1 == var_0_2.findInQian then
			var_6_2 = "yin"
		elseif var_6_1 == var_0_2.findInWan then
			var_6_2 = "jin"
		end

		local function var_6_3()
			if var_0_4[var_6_0.Type].remainTime > 0 and isMoneyEnough(MoneyType.eGold, var_6_0.NeedIngot) == false then
				return
			end

			arg_3_0:enableRecruitButtons(false)
			arg_3_0.heroRecruitRequest:request(var_6_0.Type)
		end

		local function var_6_4()
			local var_8_0 = false
			local var_8_1 = 1
			local var_8_2 = Player.team.groupList

			for iter_8_0, iter_8_1 in ipairs(var_8_2) do
				if iter_8_1.heroId > 0 then
					local var_8_3 = BaseHeros[iter_8_1.heroId].quality

					if var_8_3 == QualityType.eGreen or var_8_3 == QualityType.eBlue then
						var_8_0 = true
						var_8_1 = iter_8_0

						break
					end
				end
			end

			if var_8_0 == true and var_6_0.IsChange == 1 then
				GuideLayer:showNewbieGuideLayer(nil, arg_3_0.backType3, 270, function()
					game.enterHomeScene({
						changeHeroIndex = var_8_1
					})

					return true
				end)
			else
				GuideLayer:showMissionReward(nil, TaskType.eTaskTeaching, TaskEntryType.eZhaoJiang, 1)
			end
		end

		local function var_6_5()
			local var_10_0 = require("scenes.store.DlgStoreHeroLayer").new({
				heroData = var_6_0,
				repeatCallback = var_6_3,
				closeCallback = var_6_4
			})

			CCDirector:sharedDirector():getRunningScene():addChild(var_10_0)

			if var_6_0.HaveOrangeTime ~= nil then
				var_0_5 = var_6_0

				arg_3_0:showRemainTimes(var_6_0.HaveOrangeTime)
			end

			arg_3_0:enableRecruitButtons(true)

			local var_10_1 = Player:getTroMaxStep()

			if var_10_1 == NSStep.ZhaoJiang or var_10_1 == NSStep.XuanJiang then
				GuideLayer:showNewbieGuideLayer(var_0_3, var_10_0, 3, function()
					GuideLayer:reloadPlayerTeam(function()
						var_10_0:removeFromParent()
						game.enterHomeScene()

						return true
					end)
				end, nil, true)
			end
		end

		local var_6_6 = CCSkeletonAnimation:createWithFile("effectAni/ui_zhujiang.json", "effectAni/ui_zhujiang.atlas", 1)

		var_6_6:setAnimation(var_6_2, false, 0)
		var_6_6:setPosition(arg_3_0.back_size.width / 2 + 10, arg_3_0.back_size.height / 2 + 60)
		arg_3_0.background:addChild(var_6_6, 100)
		var_6_6:addAnimationAction(var_6_2, 1, CCCallFunc:create(var_6_5), AAT_Percent)

		if Player:getTroMaxStep() == NSStep.XuanJiang then
			GuideLayer:saveTrioMaxStep(NSStep.ZhaoJiang, function()
				return
			end)
		end
	end

	local function var_3_2()
		arg_3_0:enableRecruitButtons(true)
	end

	arg_3_0.heroRecruitRequest = StoreHeroRecruitRequest:new()

	arg_3_0.heroRecruitRequest:setResponseNormalHandler(var_3_1)
	arg_3_0.heroRecruitRequest:setResponseExceptionHandler(var_3_2)
end

function var_0_1.showInitLayer(arg_15_0)
	arg_15_0.backType1 = display.newSprite("ui/store/store_013.jpg")
	arg_15_0.backType2 = display.newSprite("ui/store/store_014.jpg")
	arg_15_0.backType3 = display.newSprite("ui/store/store_015.jpg")

	arg_15_0.backType1:setAnchorPoint(CCPoint(0, 0))
	arg_15_0.backType2:setAnchorPoint(CCPoint(0.5, 0))
	arg_15_0.backType3:setAnchorPoint(CCPoint(1, 0))
	arg_15_0.backType1:setPosition(CCPoint(10, 5))
	arg_15_0.backType2:setPosition(CCPoint(arg_15_0.back_size.width / 2, 5))
	arg_15_0.backType3:setPosition(CCPoint(arg_15_0.back_size.width - 10, 5))
	arg_15_0.background:addChild(arg_15_0.backType1)
	arg_15_0.background:addChild(arg_15_0.backType2)
	arg_15_0.background:addChild(arg_15_0.backType3)

	local function var_15_0(arg_16_0, arg_16_1)
		local var_16_0 = {
			"uilocal/store/store_text_067.png",
			"uilocal/store/store_text_068.png",
			"uilocal/store/store_text_069.png"
		}
		local var_16_1 = display.newSprite(var_16_0[arg_16_1], 36, 300)

		arg_16_0:addChild(var_16_1)
	end

	var_15_0(arg_15_0.backType1, 1)
	var_15_0(arg_15_0.backType2, 2)
	var_15_0(arg_15_0.backType3, 3)

	var_0_4[var_0_2.findInBai] = {
		background = arg_15_0.backType1
	}
	var_0_4[var_0_2.findInQian] = {
		background = arg_15_0.backType2
	}
	var_0_4[var_0_2.findInWan] = {
		background = arg_15_0.backType3
	}
end

function var_0_1.showOneType(arg_17_0, arg_17_1)
	local var_17_0 = var_0_4[arg_17_1.Type].background
	local var_17_1 = var_17_0:getContentSize()
	local var_17_2 = ui.newControlButton({
		highlightedImage = "ui/common/common_109.png",
		titleImage = "uilocal/store/store_text_010.png",
		normalImage = "ui/common/common_109.png",
		size = CCSize(150, 60),
		anchorPoint = CCPoint(0.5, 0),
		position = CCPoint(var_17_1.width / 2, 30),
		clickAction = function()
			if arg_17_1.Type == 1 or arg_17_1.Type == 2 then
				arg_17_0:onClickedRecruitOneHero(arg_17_1)
			else
				arg_17_0:onClickeRecruitHeroBtn(arg_17_1)
			end
		end
	})

	var_17_0:addChild(var_17_2)

	var_0_4[arg_17_1.Type].btnRecruit = var_17_2

	if arg_17_1.Type == var_0_2.findInWan and arg_17_1.HaveOrangeTime ~= nil then
		arg_17_0:showRemainTimes(arg_17_1.HaveOrangeTime)
	end

	local var_17_3 = createItemCountNode({
		type = ItemType.eGold,
		value = arg_17_1.NeedIngot,
		color = ccc3(255, 255, 0)
	})

	var_17_3:setAnchorPoint(CCPoint(0.5, 0))
	var_17_3:setPosition(CCPoint(var_17_1.width / 2 - 20, 20))
	var_17_0:addChild(var_17_3)

	var_0_4[arg_17_1.Type].moneyLabel = var_17_3.originalLabel

	local var_17_4 = addLabelWithColorSize(var_17_0, "", ccc3(255, 255, 255), 20, CCPoint(0.5, 0), CCPoint(var_17_1.width / 2, 95))

	var_0_4[arg_17_1.Type].timeLabel = var_17_4
	var_0_4[arg_17_1.Type].remainTime = arg_17_1.HaveTimes

	if arg_17_1.HaveTimes == 0 then
		var_0_4[arg_17_1.Type].timeLabel:setString(string.lf("现在可以#FF8200免费获取"))
		var_0_4[arg_17_1.Type].moneyLabel:setString(0)
	end

	if arg_17_1.bGenericD and arg_17_1.Type == 3 then
		-- block empty
	end

	local var_17_5 = {}

	local function var_17_6()
		if var_0_4[arg_17_1.Type].remainTime == 0 then
			return
		end

		var_0_4[arg_17_1.Type].remainTime = var_0_4[arg_17_1.Type].remainTime - 1

		if var_0_4[arg_17_1.Type].HaveOrangeTime then
			var_0_5.HaveTimes = var_0_4[arg_17_1.Type].remainTime
		end

		var_17_4:setString(string.lf("%s后可以#FF8200免费获取", formatTime(var_0_4[arg_17_1.Type].remainTime)))

		if var_0_4[arg_17_1.Type].remainTime <= 0 then
			var_17_4:setString(string.lf("现在可以免费获取"))
			var_17_3.originalLabel:setString(0)
		end
	end

	var_17_5.callback = var_17_6

	var_0_3:addToTimerTable(var_17_5)
	var_17_6()
end

function var_0_1.onClickeRecruitHeroBtn(arg_20_0, arg_20_1)
	arg_20_1 = var_0_5
	arg_20_1.TenLst = nil
	arg_20_1.Reward = nil
	arg_20_1.Consume = nil

	local var_20_0 = arg_20_1.bGenericD
	local var_20_1 = "ui/store/store_041.png"
	local var_20_2 = display.newColorLayer(ccc4(0, 0, 0, 180))

	var_0_3:addChild(var_20_2)
	var_20_2:setTouchEnabled(true)

	local var_20_3 = display.newSprite(var_20_1, display.cx, display.cy)

	var_20_3:setScale(Adapter.MinScale)
	var_20_2:addChild(var_20_3)

	local var_20_4 = var_20_3:getContentSize()
	local var_20_5 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		position = ccp(var_20_4.width - 8, var_20_4.height - 8),
		clickAction = function()
			var_20_2:removeFromParentAndCleanup(true)
		end
	})

	var_20_3:addChild(var_20_5)

	local var_20_6 = display.newNode()

	var_20_3:addChild(var_20_6)

	local var_20_7 = CCTextureCache:sharedTextureCache():addImage("ui/store/store_038.png"):getContentSizeInPixels()
	local var_20_8 = ui.newControlButton({
		normalImage = "ui/store/store_038.png",
		position = ccp((var_20_4.width - 2 * var_20_7.width) / 4 + var_20_7.width / 2, var_20_4.height / 2 + 30),
		clickAction = function()
			var_20_2:removeFromParentAndCleanup(true)
			arg_20_0:onClickedRecruitOneHero(arg_20_1)
		end
	})

	var_20_6:addChild(var_20_8)

	local var_20_9 = ui.newControlButton({
		normalImage = "ui/store/store_039.png",
		position = ccp((var_20_4.width - 2 * var_20_7.width) / 4 * 3 + var_20_7.width * 1.5, var_20_4.height / 2 + 30),
		clickAction = function()
			var_20_2:removeFromParentAndCleanup(true)
			arg_20_0:onClickedRecruitTenHeroes(arg_20_1)
		end
	})

	var_20_6:addChild(var_20_9)

	local var_20_10 = "ui/store/store_040.png"

	if var_20_0 then
		var_20_10 = "ui/store/store_043.png"
	end

	local var_20_11 = display.newSprite(var_20_10, 38, 38)

	var_20_9:addChild(var_20_11)

	if var_0_5.HaveOrangeTime > 0 then
		local var_20_12 = display.newSprite("uilocal/store/store_text_063.png", 170, 35)

		var_20_6:addChild(var_20_12)

		local var_20_13 = CCLabelAtlas:create(var_0_5.HaveOrangeTime, "uilocal/store/store_text_022.png", 27, 44, 48)

		var_20_13:setAnchorPoint(ccp(0.5, 0.5))
		var_20_13:setPosition(90, 35)
		var_20_6:addChild(var_20_13)
	else
		local var_20_14 = display.newSprite("uilocal/store/store_text_064.png", (var_20_4.width - 2 * var_20_7.width) / 4 + var_20_7.width / 2, 35)

		var_20_6:addChild(var_20_14)
	end

	local var_20_15 = arg_20_1.NeedIngot

	if var_0_5.HaveTimes <= 0 then
		var_20_15 = 0
	end

	local var_20_16 = createItemCountNode({
		type = ItemType.eGold,
		value = var_20_15,
		color = ccc3(255, 255, 0)
	})

	var_20_16:setAnchorPoint(ccp(0.5, 0))
	var_20_16:setPosition(ccp((var_20_4.width - 2 * var_20_7.width) / 4 + var_20_7.width / 2 - 30, var_20_4.height / 2 - 95))
	var_20_6:addChild(var_20_16)

	local var_20_17 = arg_20_0:calcTenHeroCost(arg_20_1)
	local var_20_18 = createItemCountNode({
		type = ItemType.eGold,
		value = var_20_17,
		color = ccc3(255, 255, 0)
	})

	var_20_18:setAnchorPoint(ccp(0.5, 0))
	var_20_18:setPosition(ccp((var_20_4.width - 2 * var_20_7.width) / 4 * 3 + var_20_7.width * 1.5 - 30, var_20_4.height / 2 - 95))

	local var_20_19 = var_20_18:getContentSize()

	var_20_6:addChild(var_20_18)

	if arg_20_1.TenPrice then
		local var_20_20 = CCSprite:create("ui/store/store_035.png")

		var_20_20:setAnchorPoint(ccp(0.5, 0.5))
		var_20_20:setPosition(ccp(30, var_20_19.height / 2))
		var_20_20:setScaleX(0.6)
		var_20_18:addChild(var_20_20)

		local var_20_21 = arg_20_1.TenPrice

		addLabelWithColorSize(var_20_6, string.lf("%d", var_20_21), ccc3(255, 255, 0), 20, ccp(0.5, 0), ccp((var_20_4.width - var_20_7.width) / 4 * 3 + var_20_7.width * 1.5 - 20, var_20_4.height / 2 - 110))
	end

	local var_20_22 = ui.newControlButton({
		normalImage = "ui/common/common_123.png",
		titleImage = "uilocal/store/store_text_061.png",
		position = ccp((var_20_4.width - 2 * var_20_7.width) / 4 + var_20_7.width / 2, var_20_4.height / 2 - 145),
		clickAction = function()
			var_20_2:removeFromParentAndCleanup(true)
			arg_20_0:onClickedRecruitOneHero(arg_20_1)
		end
	})

	var_20_6:addChild(var_20_22)

	local var_20_23 = ui.newControlButton({
		normalImage = "ui/common/common_122.png",
		titleImage = "uilocal/store/store_text_062.png",
		position = ccp((var_20_4.width - 2 * var_20_7.width) / 4 * 3 + var_20_7.width * 1.5, var_20_4.height / 2 - 145),
		clickAction = function()
			var_20_2:removeFromParentAndCleanup(true)
			arg_20_0:onClickedRecruitTenHeroes(arg_20_1)
		end
	})

	if arg_20_1.FESET then
		local var_20_24 = display.newSprite("uilocal/store/store_text_065.png", var_20_4.width / 2, var_20_4.height - 40)

		var_20_6:addChild(var_20_24)
		addLabelWithColorSize(var_20_6, string.lf("(活动时间:%s)", arg_20_1.FESET), ccc3(238, 255, 0), 22, ccp(0.5, 1), ccp(var_20_4.width / 2, var_20_4.height - 60))
	else
		var_20_6:setPosition(0, 30)
	end

	if arg_20_1.bFTenD then
		addLabelWithColorSize(var_20_6, string.lf("每日首抽#EEEE00") .. arg_20_1.bFTenD * 10 .. string.lf("#5CACEE折"), ccc3(92, 172, 238), 22, ccp(0.5, 0.5), ccp((var_20_4.width - 2 * var_20_7.width) / 4 * 3 + var_20_7.width * 1.5, 35))
	elseif arg_20_1.bSTenD then
		local var_20_25 = string.lf("#5CACEE本次#EEEE00%d#5CACEE折", arg_20_1.bSTenD * 10)

		if arg_20_1.VipLv then
			var_20_25 = string.lf("#E42020Vip%d及以上", arg_20_1.VipLv) .. var_20_25

			if Player.vipLevel >= arg_20_1.VipLv then
				var_20_25 = var_20_25 .. string.lf("(已打折)")
			end
		end

		addLabelWithColorSize(var_20_6, var_20_25, ccc3(228, 32, 32), 22, ccp(0.5, 0.5), ccp((var_20_4.width - 2 * var_20_7.width) / 4 * 3 + var_20_7.width * 1.5, 35))
	end

	var_20_6:addChild(var_20_23)
end

function var_0_1.onClickedRecruitOneHero(arg_26_0, arg_26_1)
	if var_0_4[arg_26_1.Type].remainTime > 0 and isMoneyEnough(MoneyType.eGold, arg_26_1.NeedIngot) == false then
		return
	end

	arg_26_0:enableRecruitButtons(false)
	arg_26_0.heroRecruitRequest:request(arg_26_1.Type)
end

function var_0_1.onClickedRecruitTenHeroes(arg_27_0, arg_27_1)
	if not arg_27_0.recruitTenHeroesRequest then
		local function var_27_0()
			arg_27_0:enableRecruitButtons(true)

			local var_28_0 = arg_27_0.recruitTenHeroesRequest:getTenHeroesInfo()

			if not var_28_0.TenLst then
				showFlashNotice(string.lf("主将信息为空，请联系服务端"))

				return
			end

			var_0_5 = var_28_0

			local var_28_1 = require("scenes.store.DlgStoreTenHeroesLayer").new({
				retInfo = var_28_0,
				recruitAgain = function()
					arg_27_0:onClickedRecruitTenHeroes(arg_27_1)
				end
			})

			var_28_1:setAnchorPoint(ccp(0, 0))
			var_0_3:addChild(var_28_1)
		end

		local function var_27_1()
			arg_27_0:enableRecruitButtons(true)
		end

		arg_27_0.recruitTenHeroesRequest = StoreRecruitTenHeroRequest:new()

		arg_27_0.recruitTenHeroesRequest:setResponseNormalHandler(var_27_0)
		arg_27_0.recruitTenHeroesRequest:setResponseExceptionHandler(var_27_1)
	end

	local var_27_2 = arg_27_0:calcTenHeroCost(arg_27_1)

	if isMoneyEnough(MoneyType.eGold, var_27_2) == false then
		return
	end

	arg_27_0.recruitTenHeroesRequest:request(arg_27_1.Type)
end

function var_0_1.enableRecruitButtons(arg_31_0, arg_31_1)
	var_0_4[var_0_2.findInBai].btnRecruit:setEnabled(arg_31_1)
	var_0_4[var_0_2.findInQian].btnRecruit:setEnabled(arg_31_1)
	var_0_4[var_0_2.findInWan].btnRecruit:setEnabled(arg_31_1)
end

function var_0_1.showRemainTimes(arg_32_0, arg_32_1)
	if arg_32_0.remainLabel ~= nil then
		arg_32_0.remainLabel:removeFromParentAndCleanup(true)

		arg_32_0.remainLabel = nil
	end

	local var_32_0 = arg_32_0.backType3:getContentSize()

	arg_32_0.remainLabel = display.newSprite(arg_32_1 <= 0 and "uilocal/team/team_text_052.png" or "uilocal/team/team_text_051.png")

	arg_32_0.remainLabel:setAnchorPoint(CCPoint(0.5, 0))
	arg_32_0.remainLabel:setPosition(var_32_0.width / 2, 125)
	arg_32_0.backType3:addChild(arg_32_0.remainLabel)

	if arg_32_1 > 0 then
		local var_32_1 = CCLabelAtlas:create(arg_32_1, "uilocal/store/store_text_022.png", 27, 44, 48)

		var_32_1:setAnchorPoint(ccp(0.5, 0.5))
		var_32_1:setPosition(ccp(102, 19))
		arg_32_0.remainLabel:addChild(var_32_1)
	end
end

function var_0_1.calcTenHeroCost(arg_33_0, arg_33_1)
	local var_33_0 = 9.5

	if arg_33_1.bGenericD then
		var_33_0 = 8
	end

	local var_33_1 = arg_33_1.NeedIngot * var_33_0 * (arg_33_1.bFTenD or 1)

	if arg_33_1.bSTenD and (not arg_33_1.VipLv or Player.vipLevel >= arg_33_1.VipLv) then
		var_33_1 = var_33_1 * arg_33_1.bSTenD
	end

	return var_33_1
end

return var_0_1
