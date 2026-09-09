require("network.ZSZZRequest")

local var_0_0 = class("ZSZZMakeBetLayer", function()
	return display.newColorLayer(ccc4(0, 0, 0, 180))
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.playerInfo

	arg_2_0.mParams = arg_2_1
	arg_2_0.mPlayerInfo = arg_2_1.playerInfo
	arg_2_0.mMakeBetCallBack = arg_2_1.makeBetCallBack
	arg_2_0.mCntOfCoin2Bet = 0
	arg_2_0.mCntOfGold2Bet = 0
	arg_2_0.mMaxCntOfCoin2Bet = arg_2_1.MaxGambleGoldRolled - (var_2_0.SelfGoldRolled or 0)
	arg_2_0.mMaxCntOfGold2Bet = arg_2_1.MaxGambleIngotRolled - (var_2_0.SelfIngotRolled or 0)

	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	local var_2_1 = arg_2_0:getImageSize("ui/fuben/zszz_023.png")
	local var_2_2 = display.newSprite("ui/fuben/zszz_023.png", display.cx, display.cy)

	var_2_2:setScale(Adapter.MinScale)
	arg_2_0:addChild(var_2_2)

	arg_2_0.mBgSprite = var_2_2
	arg_2_0.mBgSize = var_2_1

	local var_2_3 = display.newSprite("ui/fuben/zszz_018.png", 170, var_2_1.height / 2 + 20)

	var_2_3:setScale(0.55)
	var_2_2:addChild(var_2_3)

	local var_2_4 = display.newSprite("ui/fuben/zszz_019.png", var_2_1.width - 170, var_2_1.height / 2 + 20)

	var_2_4:setScale(0.55)
	var_2_2:addChild(var_2_4)

	local var_2_5 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/guild/guild_text_035.png",
		position = ccp(var_2_1.width / 2 - 140, 40),
		clickAction = handler(arg_2_0, arg_2_0.onBtnOKClicked)
	})

	var_2_2:addChild(var_2_5)

	local var_2_6 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/guild/guild_text_036.png",
		position = ccp(var_2_1.width / 2 + 140, 40),
		clickAction = function()
			arg_2_0:removeFromParentAndCleanup(true)
		end
	})

	var_2_2:addChild(var_2_6)

	local var_2_7 = arg_2_0:createHeader(var_2_0)

	var_2_7:setPosition(80, var_2_1.height - 60)
	var_2_2:addChild(var_2_7)
	addLabelWithColorSize(var_2_2, string.format("[%s]%s", var_2_0.ServerName, var_2_0.PlayerName), ccc3(238, 180, 34), 22, ccp(0, 0.5), ccp(150, var_2_1.height - 40))

	if var_2_0.UnionName == "" or var_2_0.UnionName == nil then
		addLabelWithColorSize(var_2_2, string.lf("散修"), ccc3(255, 127, 80), 20, ccp(0, 0.5), ccp(460, var_2_1.height - 40))
	else
		addLabelWithColorSize(var_2_2, string.lf("仙盟：%s", var_2_0.UnionName), ccc3(0, 238, 0), 20, ccp(0, 0.5), ccp(460, var_2_1.height - 40))
	end

	addLabelWithColorSize(var_2_2, string.lf("战斗力:#F0F0F0%s", var_2_0.TotalPower), ccc3(255, 227, 0), 20, ccp(0, 0.5), ccp(150, var_2_1.height - 80))

	local var_2_8 = createItemCountNode({
		carry = 99999999,
		isOutline = true,
		type = ItemType.eCoin,
		value = var_2_0.TotalGoldRolled * arg_2_1.GambleGold
	})

	var_2_8:setPosition(370, var_2_1.height - 80)
	var_2_2:addChild(var_2_8)

	local var_2_9 = createItemCountNode({
		carry = 99999999,
		isOutline = true,
		type = ItemType.eGold,
		value = var_2_0.TotalIngotRolled * arg_2_1.GambleIngot
	})

	var_2_9:setPosition(580, var_2_1.height - 80)
	var_2_2:addChild(var_2_9)

	local var_2_10 = arg_2_0:createSpecialBtn("ui/system/system_005.png", function()
		arg_2_0:onAddBtnClicked(ItemType.eCoin)
	end, CCSize(80, 80))

	var_2_10:setPosition(260, 150)
	var_2_2:addChild(var_2_10)

	local var_2_11 = arg_2_0:createSpecialBtn("ui/system/system_007.png", function()
		arg_2_0:onSubBtnClicked(ItemType.eCoin)
	end, CCSize(80, 80))

	var_2_11:setPosition(80, 150)
	var_2_2:addChild(var_2_11)

	local var_2_12 = arg_2_0:createSpecialBtn("ui/system/system_005.png", function()
		arg_2_0:onAddBtnClicked(ItemType.eGold)
	end, CCSize(80, 80))

	var_2_12:setPosition(660, 150)
	var_2_2:addChild(var_2_12)

	local var_2_13 = arg_2_0:createSpecialBtn("ui/system/system_007.png", function()
		arg_2_0:onSubBtnClicked(ItemType.eGold)
	end, CCSize(80, 80))

	var_2_13:setPosition(480, 150)
	var_2_2:addChild(var_2_13)

	arg_2_0.mLabelBetCoin = addLabelWithColorSize(var_2_2, "", ccc3(244, 244, 244), 22, ccp(0.5, 0.5), ccp(170, 150))
	arg_2_0.mLabelBetGold = addLabelWithColorSize(var_2_2, "", ccc3(244, 244, 244), 22, ccp(0.5, 0.5), ccp(570, 150))

	addLabelWithColorSize(var_2_2, string.lf("总消耗:"), ccc3(244, 244, 244), 22, ccp(0.5, 0.5), ccp(230, 90))

	local var_2_14 = display.newSprite("ui/fuben/zszz_027.png", 355, 90)

	var_2_2:addChild(var_2_14)

	local var_2_15 = display.newSprite("ui/fuben/zszz_027.png", 505, 90)

	var_2_2:addChild(var_2_15)

	local var_2_16 = display.newSprite(getItemIconPath(ItemType.eCoin))

	var_2_16:setPosition(300, 90)
	var_2_2:addChild(var_2_16)

	arg_2_0.mTotalCoinLabel = addLabelWithColorSize(var_2_16, "0", ccc3(255, 255, 255), 19, ccp(0, 0), ccp(25, 0))

	local var_2_17 = display.newSprite(getItemIconPath(ItemType.eGold))

	var_2_17:setPosition(450, 90)
	var_2_2:addChild(var_2_17)

	arg_2_0.mTotalGoldLabel = addLabelWithColorSize(var_2_17, "0", ccc3(255, 255, 255), 19, ccp(0, 0), ccp(25, 0))

	arg_2_0:refreshLabelBetCoin()
	arg_2_0:refreshLabelBetGold()
end

function var_0_0.createHeader(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.HeadId or 401

	if var_9_0 == 0 then
		var_9_0 = 401
	end

	local var_9_1 = CCSize(87, 87)
	local var_9_2 = CCScale9Sprite:create("ui/common/common_001.png")

	var_9_2:setPreferredSize(var_9_1)

	local var_9_3 = display.newSprite(getItemHeaderImagePath(ItemType.eHero, var_9_0))

	var_9_3:setPosition(var_9_1.width / 2, var_9_1.height / 2)
	var_9_2:addChild(var_9_3)

	if (arg_9_0.mPlayerInfo.SelfGoldRolled or 0) > 0 or (arg_9_0.mPlayerInfo.SelfIngotRolled or 0) > 0 then
		local var_9_4 = display.newSprite("uilocal/fuben/zszz_text_008.png", 55, 75)

		var_9_2:addChild(var_9_4)
	end

	function var_9_2.setBackgroundSpriteForState(arg_10_0, ...)
		var_9_3:setBackgroundSpriteForState(...)
	end

	return var_9_2
end

function var_0_0.createSpecialBtn(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0:getImageSize(arg_11_1)
	local var_11_1 = display.newLayer()

	arg_11_3 = arg_11_3 or var_11_0

	var_11_1:setContentSize(arg_11_3)
	var_11_1:ignoreAnchorPointForPosition(false)
	var_11_1:setAnchorPoint(ccp(0.5, 0.5))

	local var_11_2 = display.newSprite(arg_11_1, arg_11_3.width / 2, arg_11_3.height / 2)

	var_11_1:addChild(var_11_2)

	local var_11_3 = CCRect(0, 0, arg_11_3.width, arg_11_3.height)
	local var_11_4 = false
	local var_11_5 = 0
	local var_11_6 = 0

	var_11_1:addTouchEventListener(function(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = var_11_1:convertToNodeSpace(ccp(arg_12_1, arg_12_2))

		if arg_12_0 == "began" then
			var_11_4 = var_11_3:containsPoint(var_12_0)

			if var_11_4 == true then
				var_11_1:setScale(1.1)
			end
		elseif arg_12_0 == "ended" then
			if var_11_4 and var_11_3:containsPoint(var_12_0) and arg_11_2 then
				local var_12_1 = arg_11_2(var_11_1)
			end

			var_11_4 = false
			var_11_5, var_11_6 = 0, 0

			var_11_1:setScale(1)
		elseif arg_12_0 == "moved" then
			if var_11_4 and var_11_3:containsPoint(var_12_0) then
				var_11_1:setScale(1.1)
			else
				var_11_4 = false

				var_11_1:setScale(1)
			end
		end

		return true
	end, false, 1, false)
	var_11_1:setTouchEnabled(true)

	local function var_11_7(arg_13_0)
		if var_11_4 then
			var_11_5 = var_11_5 + arg_13_0

			if var_11_5 >= 0.8 and var_11_5 - var_11_6 >= 0.05 then
				var_11_6 = var_11_5

				if arg_11_2 then
					local var_13_0 = arg_11_2(var_11_1)
				end
			end
		end
	end

	var_11_1:scheduleUpdate(var_11_7)

	return var_11_1
end

function var_0_0.getImageSize(arg_14_0, arg_14_1)
	return CCTextureCache:sharedTextureCache():addImage(arg_14_1):getContentSizeInPixels()
end

function var_0_0.refreshLabelBetCoin(arg_15_0)
	arg_15_0.mLabelBetCoin:setString(string.format("%d/%d", arg_15_0.mCntOfCoin2Bet, arg_15_0.mMaxCntOfCoin2Bet))
	arg_15_0.mTotalCoinLabel:setString(arg_15_0.mCntOfCoin2Bet * arg_15_0.mParams.GambleGold)
end

function var_0_0.refreshLabelBetGold(arg_16_0)
	arg_16_0.mLabelBetGold:setString(string.format("%d/%d", arg_16_0.mCntOfGold2Bet, arg_16_0.mMaxCntOfGold2Bet))
	arg_16_0.mTotalGoldLabel:setString(arg_16_0.mCntOfGold2Bet * arg_16_0.mParams.GambleIngot)
end

function var_0_0.onAddBtnClicked(arg_17_0, arg_17_1)
	if arg_17_1 == ItemType.eGold then
		if arg_17_0.mCntOfGold2Bet + 0 >= arg_17_0.mMaxCntOfGold2Bet then
			return
		end

		arg_17_0.mCntOfGold2Bet = arg_17_0.mCntOfGold2Bet + 1

		arg_17_0:refreshLabelBetGold()
	elseif arg_17_1 == ItemType.eCoin then
		if arg_17_0.mCntOfCoin2Bet + 0 >= arg_17_0.mMaxCntOfCoin2Bet then
			return
		end

		arg_17_0.mCntOfCoin2Bet = arg_17_0.mCntOfCoin2Bet + 1

		arg_17_0:refreshLabelBetCoin()
	end
end

function var_0_0.onSubBtnClicked(arg_18_0, arg_18_1)
	if arg_18_1 == ItemType.eGold then
		if arg_18_0.mCntOfGold2Bet <= 0 then
			return
		end

		arg_18_0.mCntOfGold2Bet = arg_18_0.mCntOfGold2Bet - 1

		arg_18_0:refreshLabelBetGold()
	elseif arg_18_1 == ItemType.eCoin then
		if arg_18_0.mCntOfCoin2Bet <= 0 then
			return
		end

		arg_18_0.mCntOfCoin2Bet = arg_18_0.mCntOfCoin2Bet - 1

		arg_18_0:refreshLabelBetCoin()
	end
end

function var_0_0.onBtnOKClicked(arg_19_0)
	if arg_19_0.mCntOfCoin2Bet < 1 and arg_19_0.mCntOfGold2Bet < 1 then
		return arg_19_0:removeFromParentAndCleanup(true)
	end

	arg_19_0:makeBet(arg_19_0.mPlayerInfo.PlayerId, arg_19_0.mPlayerInfo.ServerId, arg_19_0.mCntOfCoin2Bet, arg_19_0.mCntOfGold2Bet)
end

function var_0_0.makeBet(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	if not arg_20_0.mMakeBetRequest then
		arg_20_0.mMakeBetRequest = ZSZZMakeBetRequest:new()

		local function var_20_0()
			showFlashNotice(string.lf("下注成功"))

			arg_20_0.mPlayerInfo.TotalGoldRolled = arg_20_0.mPlayerInfo.TotalGoldRolled + arg_20_0.mCntOfCoin2Bet
			arg_20_0.mPlayerInfo.TotalIngotRolled = arg_20_0.mPlayerInfo.TotalIngotRolled + arg_20_0.mCntOfGold2Bet
			arg_20_0.mPlayerInfo.SelfGoldRolled = (arg_20_0.mPlayerInfo.SelfGoldRolled or 0) + arg_20_0.mCntOfCoin2Bet
			arg_20_0.mPlayerInfo.SelfIngotRolled = (arg_20_0.mPlayerInfo.SelfIngotRolled or 0) + arg_20_0.mCntOfGold2Bet

			if arg_20_0.mMakeBetCallBack then
				local var_21_0 = arg_20_0.mMakeBetCallBack(arg_20_0.mCntOfCoin2Bet, arg_20_0.mCntOfGold2Bet)
			end

			arg_20_0:removeFromParentAndCleanup(true)
		end

		arg_20_0.mMakeBetRequest:setResponseNormalHandler(var_20_0)
	end

	arg_20_0.mMakeBetRequest:request(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
end

return var_0_0
