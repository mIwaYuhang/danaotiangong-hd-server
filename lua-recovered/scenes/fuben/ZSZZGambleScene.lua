require("network.ZSZZRequest")

local var_0_0 = require("framework.scheduler")
local var_0_1 = class("ZSZZGambleScene", function()
	return display.newScene("ZSZZGambleScene")
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0.mCDTimerBindFunctions = {}
	arg_2_0.mParams = arg_2_1

	arg_2_0:setUI(arg_2_1)

	if arg_2_1.status == 2 then
		arg_2_0.mCountDownView:setRemainTime(arg_2_1.remainTime)
	end

	arg_2_0:requestHomeInfo(arg_2_1.placeType)
	arg_2_0:setTimer()
end

function var_0_1.onExit(arg_3_0)
	arg_3_0:killTimer()
end

function var_0_1.setUI(arg_4_0, arg_4_1)
	local var_4_0 = math.max(Adapter.WidthScale, Adapter.HeightScale)
	local var_4_1 = display.newSprite("ui/fuben/zszz_020.jpg", display.cx, display.cy)

	var_4_1:setScale(var_4_0)
	arg_4_0:addChild(var_4_1)

	local var_4_2 = Adapter.MinScale
	local var_4_3 = CCSizeMake(display.width / var_4_2, display.height / var_4_2)
	local var_4_4 = display.newNode()

	var_4_4:setContentSize(var_4_3)
	var_4_4:setAnchorPoint(ccp(0, 0))
	var_4_4:setScale(var_4_2)
	arg_4_0:addChild(var_4_4)

	arg_4_0.mContainerScale = var_4_2
	arg_4_0.mContainer = var_4_4
	arg_4_0.mContainerSize = var_4_3

	local var_4_5 = ui.newControlButton({
		normalImage = "ui/common/common_061.png",
		position = ccp(var_4_3.width - 60, var_4_3.height - 35),
		clickAction = function()
			game.enterZSZZHomeScene({
				worldType = arg_4_1.placeType
			})
		end
	})

	var_4_4:addChild(var_4_5)

	arg_4_0.mLabelIntroduction = addLabelWithColorSize(var_4_4, string.lf(""), ccc3(244, 244, 244), 20, ccp(1, 0), ccp(var_4_3.width - 25, 15))
	arg_4_0.mTop20View = arg_4_0:createTop20View()

	arg_4_0.mTop20View:setAnchorPoint(ccp(0, 0.5))
	arg_4_0.mTop20View:setPosition(10, var_4_3.height / 2)
	var_4_4:addChild(arg_4_0.mTop20View)

	arg_4_0.mCountDownView = arg_4_0:createCountDownView()

	arg_4_0.mCountDownView:setPosition(var_4_3.width - 380 * Adapter.WidthScale / Adapter.MinScale, var_4_3.height - 50)
	var_4_4:addChild(arg_4_0.mCountDownView)

	arg_4_0.mBetPool = arg_4_0:createBetPool()

	arg_4_0.mBetPool:setPosition(var_4_3.width - 308 * Adapter.WidthScale / Adapter.MinScale, var_4_3.height / 2 - 120)
	var_4_4:addChild(arg_4_0.mBetPool)
end

function var_0_1.createTop20View(arg_6_0)
	local var_6_0 = arg_6_0:getImageSize("ui/fuben/zszz_024.png")
	local var_6_1 = CCSize(var_6_0.width * Adapter.WidthScale / Adapter.MinScale, var_6_0.height * Adapter.HeightScale / Adapter.MinScale)
	local var_6_2 = display.newScale9Sprite("ui/fuben/zszz_024.png", 0, 0, var_6_1)
	local var_6_3 = display.newSprite("uilocal/fuben/zszz_text_009.png", var_6_1.width / 2, var_6_1.height - 20)

	var_6_2:addChild(var_6_3)

	var_6_2.dataSrc = {}

	local var_6_4 = CCSize(var_6_1.width - 4, 100)

	local function var_6_5()
		return var_6_4.height, var_6_4.width
	end

	local function var_6_6()
		return #var_6_2.dataSrc
	end

	local function var_6_7(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_1 + 1
		local var_9_1 = arg_9_0:cellAtIndex(arg_9_1)

		if var_9_1 == nil then
			var_9_1 = CCTableViewCell:new()
		end

		var_9_1:removeAllChildrenWithCleanup(true)

		local var_9_2 = var_6_2.dataSrc[var_9_0] or {}

		dump(var_9_2)

		local var_9_3 = arg_6_0:createHeaderBtn(var_9_2)

		var_9_3:setPosition(50, var_6_4.height / 2)
		var_9_1:addChild(var_9_3)

		local var_9_4 = addLabelWithColorSize(var_9_1, string.format("[%s]%s", var_9_2.ServerName, var_9_2.PlayerName), ccc3(238, 180, 34), 17, ccp(0, 0.5), ccp(100, var_6_4.height - 18))

		if var_9_2.UnionName == "" or var_9_2.UnionName == nil then
			local var_9_5 = addLabelWithColorSize(var_9_1, string.lf("散修"), ccc3(255, 127, 80), 16, ccp(0, 0.5), ccp(100, var_6_4.height - 40))
		else
			guildLabel = addLabelWithColorSize(var_9_1, string.lf("仙盟:%s", var_9_2.UnionName), ccc3(0, 238, 0), 16, ccp(0, 0.5), ccp(100, var_6_4.height - 40))
		end

		local var_9_6 = addLabelWithColorSize(var_9_1, string.lf("战斗力:#F0F0F0%s", var_9_2.TotalPower), ccc3(255, 227, 0), 16, ccp(0, 0.5), ccp(100, var_6_4.height - 60))
		local var_9_7 = "%d(#00FF00%d#F4F4F4)"

		if not var_9_2.SelfGoldRolled then
			var_9_7 = "%d"
		end

		local var_9_8 = display.newSprite(getItemIconPath(ItemType.eCoin))

		var_9_8:setPosition(105, 15)
		var_9_1:addChild(var_9_8)
		addLabelWithColorSize(var_9_8, string.format(var_9_7, var_9_2.TotalGoldRolled, var_9_2.SelfGoldRolled or 0), ccc3(255, 255, 255), 16, ccp(0, 0), ccp(25, 2))

		local var_9_9 = "%d(#00FF00%d#F4F4F4)"

		if not var_9_2.SelfIngotRolled then
			var_9_9 = "%d"
		end

		local var_9_10 = display.newSprite(getItemIconPath(ItemType.eGold))

		var_9_10:setPosition((var_6_4.width - 105) / 2 + 105, 15)
		var_9_1:addChild(var_9_10)
		addLabelWithColorSize(var_9_10, string.format(var_9_9, var_9_2.TotalIngotRolled, var_9_2.SelfIngotRolled or 0), ccc3(255, 255, 255), 16, ccp(0, 0), ccp(25, 2))

		if arg_6_0.mHomeInfo.IsCanGamble == true then
			local var_9_11 = ui.newControlButton({
				titleImage = "uilocal/fuben/zszz_text_027.png",
				normalImage = "ui/duel/duel_003.png",
				scaleX = 0.8,
				scaleY = 0.8,
				position = ccp(var_6_4.width - 40, var_6_4.height - 53),
				clickAction = function()
					arg_6_0:onBtnMakeBetClicked(var_9_2)
				end
			})

			var_9_1:addChild(var_9_11)
		end

		return var_9_1
	end

	local var_6_8 = CCTableView:create(CCSize(var_6_4.width, var_6_1.height - 40))

	var_6_8:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_6_8:setDirection(kCCScrollViewDirectionVertical)
	var_6_8:registerScriptHandler(var_6_5, CCTableView.kTableCellSizeForIndex)
	var_6_8:registerScriptHandler(var_6_6, CCTableView.kNumberOfCellsInTableView)
	var_6_8:registerScriptHandler(var_6_7, CCTableView.kTableCellSizeAtIndex)
	var_6_8:setPosition(2, 2)
	var_6_2:addChild(var_6_8)

	function var_6_2.reloadData(arg_11_0, arg_11_1)
		arg_11_0.dataSrc = arg_11_1 or arg_11_0.dataSrc

		var_6_8:reloadData()
	end

	function var_6_2.getContentOffset(arg_12_0)
		return var_6_8:getContentOffset()
	end

	function var_6_2.setContentOffset(arg_13_0, ...)
		var_6_8:setContentOffset(...)
	end

	var_6_8:reloadData()

	return var_6_2
end

function var_0_1.createHeaderBtn(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.HeadId or 401

	if var_14_0 == 0 then
		var_14_0 = 401
	end

	local var_14_1 = CCSize(87, 87)
	local var_14_2 = CCScale9Sprite:create("ui/common/common_001.png")

	var_14_2:setPreferredSize(var_14_1)

	local var_14_3 = ui.newControlButton({
		normalImage = getItemHeaderImagePath(ItemType.eHero, var_14_0)
	})

	var_14_3:setPosition(var_14_1.width / 2, var_14_1.height / 2)
	var_14_2:addChild(var_14_3)

	if (arg_14_1.SelfGoldRolled or 0) > 0 or (arg_14_1.SelfIngotRolled or 0) > 0 then
		local var_14_4 = display.newSprite("uilocal/fuben/zszz_text_008.png", 55, 75)

		var_14_2:addChild(var_14_4)
	end

	function var_14_2.setBackgroundSpriteForState(arg_15_0, ...)
		var_14_3:setBackgroundSpriteForState(...)
	end

	return var_14_2
end

function var_0_1.createCountDownView(arg_16_0)
	local var_16_0 = display.newNode()
	local var_16_1 = display.newSprite("uilocal/fuben/zszz_text_012.png")
	local var_16_2 = display.newSprite("uilocal/fuben/zszz_text_049.png")
	local var_16_3 = ui.newControlButton({
		normalImage = "ui/enhance/enhance_015.png",
		scaleX = 0.8,
		scaleY = 0.8,
		position = ccp(-170, 0),
		clickAction = function()
			local var_17_0 = require("scenes.enhance.DlgRuleLayer").new({
				ruleType = DlgRuleType.ruleZSZZGameble
			})

			arg_16_0:addChild(var_17_0, DefaultZOrder.ePopupLayer)
		end
	})

	var_16_0:addChild(var_16_3)

	local var_16_4 = display.newSprite("ui/fuben/zszz_021.png", 60, -70)

	var_16_0:addChild(var_16_4)
	addLabelWithColorSize(var_16_4, string.lf("击杀数第一: 奖金池 #00FF00(50%%)#F4F4F4 (按照奖券均分)"), ccc3(255, 220, 130), 18, ccp(0.5, 0.5), ccp(170, 70))
	addLabelWithColorSize(var_16_4, string.lf("击杀数第二: 奖金池 #00FF00(25%%)#F4F4F4 (按照奖券均分)"), ccc3(255, 220, 130), 18, ccp(0.5, 0.5), ccp(170, 45))
	addLabelWithColorSize(var_16_4, string.lf("击杀数第三: 奖金池 #00FF00(15%%)#F4F4F4 (按照奖券均分)"), ccc3(255, 220, 130), 18, ccp(0.5, 0.5), ccp(170, 20))

	if arg_16_0.mParams.status == 1 then
		var_16_2:setPosition(ccp(60, 0))
		var_16_0:addChild(var_16_2)
	else
		var_16_0:addChild(var_16_1)

		local var_16_5 = addLabelWithColorSize(var_16_0, "00:00:00", ccc3(244, 244, 244), 26, ccp(0, 0.5), ccp(80, 0))
		local var_16_6 = 0

		function var_16_0.setRemainTime(arg_18_0, arg_18_1)
			var_16_6 = arg_18_1 - 3600 or 0

			local function var_18_0()
				var_16_6 = var_16_6 - 1

				if var_16_6 > 0 then
					var_16_5:setString(formatTime(var_16_6))
				else
					var_16_5:setString(string.lf("已结束"))
					arg_16_0:dettachCDTimer(var_16_0)
				end
			end

			arg_16_0:dettachCDTimer(var_16_0)
			arg_16_0:attachCDTimer(var_16_0, var_18_0)
		end
	end

	return var_16_0
end

function var_0_1.createBetPool(arg_20_0)
	local var_20_0 = display.newNode()
	local var_20_1 = display.newSprite("ui/fuben/zszz_018.png", -160, -10)

	var_20_0:addChild(var_20_1)

	local var_20_2 = display.newSprite("ui/fuben/zszz_019.png", 160, 0)

	var_20_0:addChild(var_20_2)

	local var_20_3 = display.newSprite("uilocal/fuben/zszz_text_010.png", 70, 362)

	var_20_1:addChild(var_20_3)

	local var_20_4 = display.newSprite("uilocal/fuben/zszz_text_011.png", 70, 362)

	var_20_2:addChild(var_20_4)

	local var_20_5 = display.newSprite(getItemIconPath(ItemType.eCoin))

	var_20_5:setPosition(105, 10)
	var_20_3:addChild(var_20_5)

	local var_20_6 = addLabelWithColorSize(var_20_5, "0", ccc3(255, 255, 255), 20, ccp(0, 0), ccp(25, 2))
	local var_20_7 = display.newSprite(getItemIconPath(ItemType.eGold))

	var_20_7:setPosition(105, 10)
	var_20_4:addChild(var_20_7)

	local var_20_8 = addLabelWithColorSize(var_20_7, "0", ccc3(255, 255, 255), 20, ccp(0, 0), ccp(25, 2))

	function var_20_0.setCoin(arg_21_0, arg_21_1)
		var_20_6:setString(tostring(arg_21_1))
	end

	function var_20_0.setGold(arg_22_0, arg_22_1)
		var_20_8:setString(tostring(arg_22_1))
	end

	return var_20_0
end

function var_0_1.setTimer(arg_23_0)
	if not arg_23_0.mCDTimerHandler then
		arg_23_0.mCDTimerHandler = var_0_0.scheduleGlobal(handler(arg_23_0, arg_23_0.onCDTimer), 1)
	end
end

function var_0_1.killTimer(arg_24_0)
	if arg_24_0.mCDTimerHandler then
		var_0_0.unscheduleGlobal(arg_24_0.mCDTimerHandler)

		arg_24_0.mCDTimerHandler = nil
	end
end

function var_0_1.onCDTimer(arg_25_0)
	table.foreach(arg_25_0.mCDTimerBindFunctions, function(arg_26_0, arg_26_1)
		arg_26_1()
	end)
end

function var_0_1.attachCDTimer(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0.mCDTimerBindFunctions[arg_27_1] = arg_27_2
end

function var_0_1.dettachCDTimer(arg_28_0, arg_28_1)
	arg_28_0.mCDTimerBindFunctions[arg_28_1] = nil
end

function var_0_1.getImageSize(arg_29_0, arg_29_1)
	return CCTextureCache:sharedTextureCache():addImage(arg_29_1):getContentSizeInPixels()
end

function var_0_1.onBtnMakeBetClicked(arg_30_0, arg_30_1)
	if arg_30_0.mHomeInfo.IsCanGamble == false then
		return showFlashNotice(string.lf("不能在当前道下注或下注已达上限"))
	end

	local var_30_0 = require("scenes.fuben.ZSZZMakeBetLayer").new({
		playerInfo = arg_30_1,
		GambleGold = arg_30_0.mHomeInfo.GambleGold,
		GambleIngot = arg_30_0.mHomeInfo.GambleIngot,
		MaxGambleGoldRolled = arg_30_0.mHomeInfo.MaxGambleGoldRolled,
		MaxGambleIngotRolled = arg_30_0.mHomeInfo.MaxGambleIngotRolled,
		makeBetCallBack = function(arg_31_0, arg_31_1)
			arg_30_0.mHomeInfo.TotalGold = arg_30_0.mHomeInfo.TotalGold + arg_30_0.mHomeInfo.GambleGold * arg_31_0
			arg_30_0.mHomeInfo.TotalIngot = arg_30_0.mHomeInfo.TotalIngot + arg_30_0.mHomeInfo.GambleIngot * arg_31_1

			arg_30_0.mBetPool:setCoin(arg_30_0.mHomeInfo.TotalGold)
			arg_30_0.mBetPool:setGold(arg_30_0.mHomeInfo.TotalIngot)

			local var_31_0 = arg_30_0.mTop20View:getContentOffset()

			arg_30_0.mTop20View:reloadData()
			arg_30_0.mTop20View:setContentOffset(var_31_0)
		end
	})

	arg_30_0:addChild(var_30_0, DefaultZOrder.ePopupLayer)
end

function var_0_1.requestHomeInfo(arg_32_0, arg_32_1)
	if not arg_32_0.mHomeInfoRequest then
		arg_32_0.mHomeInfoRequest = ZSZZGetGambleHomeInfoRequest:new()

		local function var_32_0()
			arg_32_0:onResponseHomeInfoSuccess(arg_32_0.mHomeInfoRequest.restable)
		end

		arg_32_0.mHomeInfoRequest:setResponseNormalHandler(var_32_0)
	end

	arg_32_0.mHomeInfoRequest:request(arg_32_1 or 1)
end

function var_0_1.onResponseHomeInfoSuccess(arg_34_0, arg_34_1)
	arg_34_0.mHomeInfo = arg_34_1

	arg_34_0.mBetPool:setCoin(arg_34_1.TotalGold)
	arg_34_0.mBetPool:setGold(arg_34_1.TotalIngot)
	arg_34_0.mTop20View:reloadData(arg_34_1.CurrentGambleList)

	if arg_34_0.mHomeInfo.IsCanGamble == treu then
		arg_34_0.mLabelIntroduction:setString(string.lf("可对每个选手下 银币X注 元宝Y注, 每注:%d银币 %d元宝", arg_34_1.GambleGold, arg_34_1.GambleIngot))
	end
end

return var_0_1
