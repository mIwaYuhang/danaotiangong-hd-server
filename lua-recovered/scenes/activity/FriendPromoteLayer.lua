require("network.ActivityRequest")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("FriendPromoteLayer", function()
	return display.newLayer()
end)

function var_0_1.ctor(arg_2_0)
	arg_2_0.mPromoteInfoData = {}

	arg_2_0:setUI()
	arg_2_0:requestMyPromoteInfo()
end

function var_0_1.setUI(arg_3_0)
	arg_3_0.mBgSize = CCSize(830, 545)
	arg_3_0.mBgSprite = display.newSprite("ui/yaoqingma/yaoqingma_006.jpg", arg_3_0.mBgSize.width / 2, arg_3_0.mBgSize.height / 2 + 12)

	arg_3_0:addChild(arg_3_0.mBgSprite)

	local var_3_0 = display.newSprite("ui/yaoqingma/yaoqingma_005.png", arg_3_0.mBgSize.width / 2, arg_3_0.mBgSize.height - 20)

	arg_3_0.mBgSprite:addChild(var_3_0)

	local var_3_1 = arg_3_0:getImageSize("ui/yaoqingma/yaoqingma_005.png")

	var_3_0:addChild(display.newSprite("uilocal/yaoqingma/yaoqingma_text_002.png", var_3_1.width / 2, var_3_1.height / 2))
	arg_3_0.mBgSprite:addChild(display.newSprite("uilocal/yaoqingma/yaoqingma_text_003.png", arg_3_0.mBgSize.width / 2, arg_3_0.mBgSize.height - 145))

	local var_3_2 = display.newSprite("ui/yaoqingma/yaoqingma_008.png", 170, arg_3_0.mBgSize.height - 80)

	arg_3_0.mBgSprite:addChild(var_3_2)

	arg_3_0.mNewbieRewardView = arg_3_0:createNewbieRewardView()

	arg_3_0.mNewbieRewardView:setPosition(60, arg_3_0.mBgSize.height - 80)
	arg_3_0.mBgSprite:addChild(arg_3_0.mNewbieRewardView)

	local var_3_3 = arg_3_0:getImageSize("ui/yaoqingma/yaoqingma_003.png")
	local var_3_4 = ui.newEditBox({
		fontSize = 22,
		image = "ui/yaoqingma/yaoqingma_003.png",
		multiLines = false,
		size = var_3_3,
		fontColor = ccc3(0, 0, 0),
		x = arg_3_0.mBgSize.width - 180 - var_3_3.width / 2,
		y = arg_3_0.mBgSize.height - 80
	})

	arg_3_0.mBgSprite:addChild(var_3_4)

	local var_3_5 = ui.newControlButton({
		normalImage = "uilocal/yaoqingma/yaoqingma_text_005.png",
		clickAction = function(arg_4_0, arg_4_1)
			if Player.isHavePromoterGift == true then
				showFlashNotice(string.lf("您已将%s设为邀请好友，不可再次设置", Player.promoterName))
			else
				local var_4_0 = var_3_4:getText()

				if var_4_0 and string.len(var_4_0) > 0 then
					arg_3_0:requestSetPromoter(var_4_0)
				else
					ui.showMessageBox({
						text = string.lf("上仙！请您输入正确的邀请码！T.T")
					})
				end
			end
		end
	})

	var_3_5:setPosition(arg_3_0.mBgSize.width - 100, arg_3_0.mBgSize.height - 80)
	arg_3_0.mBgSprite:addChild(var_3_5)

	arg_3_0.mEditBox = var_3_4
	arg_3_0.mBtnGet = var_3_5
	arg_3_0.mBgFrameSprite = var_3_2

	if Player.isHavePromoterGift == true then
		addLabelWithColorSize(arg_3_0.mBgSprite, string.lf("我的邀请者:#F0D000%s", Player.promoterName), ccc3(240, 240, 240), 22, ccp(0.5, 0.5), ccp(arg_3_0.mBgSize.width / 2, arg_3_0.mBgSize.height - 80))
		var_3_2:setPosition(arg_3_0.mBgSize.width / 2, arg_3_0.mBgSize.height - 80)
		arg_3_0.mNewbieRewardView:setVisible(false)
		var_3_4:setVisible(false)
		var_3_5:setVisible(false)
	end

	arg_3_0.mBgSprite:addChild(display.newSprite("ui/yaoqingma/yaoqingma_007.png", 290, arg_3_0.mBgSize.height - 195))
	arg_3_0.mBgSprite:addChild(display.newSprite("ui/yaoqingma/yaoqingma_002.png", 345, arg_3_0.mBgSize.height - 195))
	arg_3_0.mBgSprite:addChild(display.newSprite("uilocal/yaoqingma/yaoqingma_text_004.png", 120, arg_3_0.mBgSize.height - 195))

	arg_3_0.mMyPromoteCode = addLabelWithColorSize(arg_3_0.mBgSprite, Player.playerPromoterId, ccc3(240, 224, 128), 24, ccp(0, 0.5), ccp(230, arg_3_0.mBgSize.height - 195))

	addLabelWithColorSize(arg_3_0.mBgSprite, string.lf("分享到:"), ccc3(240, 240, 240), 22, ccp(1, 0.5), ccp(630, arg_3_0.mBgSize.height - 195))

	local var_3_6 = getShareEnabledTable()

	for iter_3_0 = 1, #var_3_6 do
		local var_3_7 = ui.newControlButton({
			scaleX = 0.28,
			scaleY = 0.28,
			normalImage = var_3_6[iter_3_0].image,
			position = ccp(650 + (iter_3_0 - 1) * 35, arg_3_0.mBgSize.height - 195),
			clickAction = function()
				if tonumber(EditionConfig.__Version) < 200 and IPlatform:instance():getConfig("Channel") ~= "ZSY_TW" then
					showFlashNotice(string.lf("该功能需要更新客户端后才能使用!"))
				else
					local var_5_0 = string.lf("超好玩的“大闹天宫HD”，输码领奖：%s，送西游神将魂魄等豪华奖励，还可与我一起闯三界降妖魔！赶紧下载游戏后在活动中心-每日分享-输码领奖", Player.playerPromoterId)
					local var_5_1 = require("scenes.team.DlgShareLayer").new({
						isShareScreen = false,
						shareText = var_5_0,
						sharePlatform = var_3_6[iter_3_0].type
					})

					display.getRunningScene():addChild(var_5_1, DefaultZOrder.eTaskReward)
				end
			end
		})

		arg_3_0.mBgSprite:addChild(var_3_7)
	end

	local var_3_8 = arg_3_0:getImageSize("ui/yaoqingma/yaoqingma_001.png")

	arg_3_0.mPromoterRewardView = arg_3_0:createPromoterRewardView(CCSizeMake(arg_3_0.mBgSize.width - 60, var_3_8.height))

	arg_3_0.mPromoterRewardView:setPosition(25, 15)
	arg_3_0.mBgSprite:addChild(arg_3_0.mPromoterRewardView)
end

function var_0_1.createNewbieRewardView(arg_6_0)
	local var_6_0 = display.newNode()
	local var_6_1 = createItemCountNode({
		value = 0,
		carry = 9999,
		type = ItemType.eCoin
	})

	var_6_1:setAnchorPoint(ccp(0, 0.5))
	var_6_1:setPosition(0, 0)
	var_6_0:addChild(var_6_1)

	local var_6_2 = createItemCountNode({
		value = 0,
		carry = 9999,
		type = ItemType.eGold
	})

	var_6_2:setAnchorPoint(ccp(0, 0.5))
	var_6_2:setPosition(100, 0)
	var_6_0:addChild(var_6_2)

	local var_6_3 = createItemCountNode({
		value = 0,
		type = ItemType.ePower
	})

	var_6_3:setAnchorPoint(ccp(0, 0.5))
	var_6_3:setPosition(200, 0)
	var_6_0:addChild(var_6_3)

	local function var_6_4(arg_7_0, arg_7_1)
		arg_7_0:setValue(arg_7_1)

		if arg_7_1 == 0 then
			arg_7_0:setVisible(false)
		else
			arg_7_0:setVisible(true)
		end
	end

	function var_6_0.setCoin(arg_8_0, arg_8_1)
		var_6_4(var_6_1, arg_8_1)
	end

	function var_6_0.setGold(arg_9_0, arg_9_1)
		var_6_4(var_6_2, arg_9_1)
	end

	function var_6_0.setPower(arg_10_0, arg_10_1)
		var_6_4(var_6_3, arg_10_1)
	end

	var_6_0:setCoin(0)
	var_6_0:setGold(0)
	var_6_0:setPower(0)

	return var_6_0
end

function var_0_1.createPromoterRewardView(arg_11_0, arg_11_1)
	local var_11_0 = display.newNode()

	var_11_0:setContentSize(arg_11_1)

	local var_11_1 = {}
	local var_11_2 = arg_11_0:getImageSize("ui/yaoqingma/yaoqingma_001.png")

	var_11_2.width = var_11_2.width + 10

	local function var_11_3()
		return var_11_2.height, var_11_2.width
	end

	local function var_11_4()
		if not var_11_1 or type(var_11_1) ~= "table" then
			return 0
		end

		return #var_11_1
	end

	local function var_11_5(arg_14_0)
		arg_14_0 = math.floor(arg_14_0)

		if arg_14_0 > 9999 then
			arg_14_0 = math.floor(arg_14_0 / 10000)

			return string.lf("%s万", arg_14_0)
		end

		return tostring(arg_14_0)
	end

	local function var_11_6(arg_15_0, arg_15_1)
		local var_15_0 = arg_15_0:cellAtIndex(arg_15_1)
		local var_15_1 = arg_15_1 + 1

		if var_15_0 == nil then
			var_15_0 = CCTableViewCell:new()
		end

		var_15_0:removeAllChildrenWithCleanup(true)

		if not var_11_1 then
			return var_15_0
		end

		local var_15_2 = var_11_1[var_15_1]
		local var_15_3 = display.newSprite("ui/yaoqingma/yaoqingma_001.png", var_11_2.width / 2, var_11_2.height / 2)

		var_15_0:addChild(var_15_3)
		addLabelWithColorSize(var_15_0, string.lf("邀请的好友中\n#20A0E0%d#F0F0F0位达到#E0D000%d#F0F0F0级", var_15_2.MemberCount, var_15_2.MemberLevel), ccc3(240, 240, 240), 20, ccp(0.5, 1), ccp(var_11_2.width / 2, var_11_2.height - 30)):setDimensions(CCSizeMake(var_11_2.width - 20, 100))

		local var_15_4 = var_11_2.height - 100

		for iter_15_0, iter_15_1 in ipairs(var_15_2.Reward) do
			local var_15_5

			if iter_15_1.Type == ItemType.eCoin or iter_15_1.Type == ItemType.eGold then
				var_15_5 = addLabelWithColorSize(var_15_0, string.format("%s%s", var_11_5(iter_15_1.Count), getItemName(iter_15_1.Type)), ccc3(240, 224, 0), 20, ccp(0, 1), ccp(0, 0))
			else
				var_15_5 = addLabelWithColorSize(var_15_0, string.format("%sx%s", getItemName(iter_15_1.Type, iter_15_1.ID or 0), iter_15_1.Count), ccc3(240, 224, 0), 20, ccp(0, 1), ccp(0, 0))
			end

			var_15_5:setPosition(28, var_15_4)

			var_15_4 = var_15_4 - 23
		end

		local var_15_6 = ui.newControlButton({
			normalImage = "uilocal/yaoqingma/yaoqingma_text_001.png",
			disabledImage = "uilocal/yaoqingma/yaoqingma_text_006.png",
			position = ccp(var_11_2.width / 2, 60),
			clickAction = function()
				arg_11_0:onGetPromoteRewardBtnClicked(var_15_2)
			end
		})

		var_15_0:addChild(var_15_6)

		if var_15_2.State ~= 1 then
			var_15_6:setEnabled(false)
		end

		return var_15_0
	end

	local var_11_7 = CCTableView:create(arg_11_1)

	var_11_7:ignoreAnchorPointForPosition(false)
	var_11_7:setDirection(kCCScrollViewDirectionHorizontal)
	var_11_7:registerScriptHandler(var_11_3, CCTableView.kTableCellSizeForIndex)
	var_11_7:registerScriptHandler(var_11_4, CCTableView.kNumberOfCellsInTableView)
	var_11_7:registerScriptHandler(var_11_6, CCTableView.kTableCellSizeAtIndex)
	var_11_7:setAnchorPoint(ccp(0, 0))
	var_11_0:addChild(var_11_7)

	function var_11_0.reloadData(arg_17_0, arg_17_1)
		var_11_1 = arg_17_1

		local var_17_0 = var_11_7:getContentOffset()

		var_11_7:reloadData()
		var_11_7:setContentOffset(ccp(var_17_0.x, 0))
	end

	return var_11_0
end

function var_0_1.showRewards(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = display.newLayer()

	var_18_0:addTouchEventListener(function(arg_19_0, arg_19_1, arg_19_2)
		return false
	end, false, 1, true)
	var_18_0:setTouchEnabled(true)
	arg_18_0.mBgSprite:addChild(var_18_0)

	local var_18_1 = display.newSprite(arg_18_1, arg_18_0.mBgSize.width / 2, arg_18_0.mBgSize.height / 2)

	var_18_0:addChild(var_18_1)

	local var_18_2 = var_18_1:getContentSize()
	local var_18_3 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/guild/guild_text_035.png",
		position = ccp(var_18_2.width / 2, 35),
		clickAction = function()
			var_18_0:removeFromParentAndCleanup(true)
		end
	})

	var_18_1:addChild(var_18_3)

	local var_18_4 = addLabelWithColorSize(var_18_1, arg_18_2, ccc3(212, 212, 212), 20, ccp(0, 1), ccp(15, var_18_2.height - 15))

	var_18_4:setHorizontalAlignment(kCCTextAlignmentLeft)
	var_18_4:setDimensions(CCSizeMake(var_18_2.width - 30, var_18_2.height - 30))

	arg_18_3 = arg_18_3 or {}

	local var_18_5 = arg_18_0:createRewardsView(CCSizeMake(var_18_2.width - 30, 125), arg_18_3)

	var_18_5:setPosition(15, 65)
	var_18_1:addChild(var_18_5)
end

function var_0_1.createRewardsView(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = display.newNode()
	local var_21_1 = CCScrollView:create(arg_21_1, var_21_0)

	var_21_1:setDirection(kCCScrollViewDirectionHorizontal)
	var_21_1:setAnchorPoint(ccp(0, 0))
	var_21_1:setPosition(15, 65)

	local var_21_2 = 0
	local var_21_3 = CCSizeMake(140, 125)

	for iter_21_0, iter_21_1 in ipairs(arg_21_2) do
		local var_21_4 = figure.createHeader({
			isName = true,
			type = iter_21_1.Type,
			itemId = iter_21_1.ID or 0,
			count = iter_21_1.Count,
			nameColor = getQualityColor(getItemQuality(iter_21_1.Type, iter_21_1.ID)),
			equipJieji = iter_21_1.BreakthroughCount,
			countColor = ccc3(255, 228, 0),
			clickAction = function()
				var_0_0.tipshandler(iter_21_1)
			end
		})

		var_21_0:addChild(var_21_4)
		var_21_4:setPosition(var_21_2 + var_21_3.width / 2, var_21_3.height / 2)

		var_21_2 = var_21_2 + var_21_3.width
	end

	var_21_0:setContentSize(CCSizeMake(var_21_2, var_21_3.height))

	return var_21_1
end

function var_0_1.getImageSize(arg_23_0, arg_23_1)
	return CCTextureCache:sharedTextureCache():addImage(arg_23_1):getContentSizeInPixels()
end

function var_0_1.onGetPromoteRewardBtnClicked(arg_24_0, arg_24_1)
	if arg_24_1.State == 0 then
		return showFlashNotice(string.lf("未达到领取条件"))
	elseif arg_24_1.State == 1 then
		arg_24_0:requestGetPromoteReward(arg_24_1)
	elseif arg_24_1.State == 2 then
		return showFlashNotice(string.lf("不可重复领取"))
	end
end

function var_0_1.requestMyPromoteInfo(arg_25_0)
	if not arg_25_0.mPromoteInfoRequest then
		local function var_25_0()
			arg_25_0:onResponseMyPromoteInfo(arg_25_0.mPromoteInfoRequest.restable)
		end

		arg_25_0.mPromoteInfoRequest = ActivityPromoteReward:new()

		arg_25_0.mPromoteInfoRequest:setResponseNormalHandler(var_25_0)
	end

	arg_25_0.mPromoteInfoRequest:request()
end

function var_0_1.onResponseMyPromoteInfo(arg_27_0, arg_27_1)
	arg_27_0.mPromoteInfoData = arg_27_1

	arg_27_0.mNewbieRewardView:setCoin(0)
	arg_27_0.mNewbieRewardView:setGold(0)
	arg_27_0.mNewbieRewardView:setPower(0)

	for iter_27_0, iter_27_1 in ipairs(arg_27_0.mPromoteInfoData.Tiro) do
		if iter_27_1.Type == ItemType.eCoin then
			arg_27_0.mNewbieRewardView:setCoin(iter_27_1.Count)
		elseif iter_27_1.Type == ItemType.eGold then
			arg_27_0.mNewbieRewardView:setGold(iter_27_1.Count)
		elseif iter_27_1.Type == ItemType.ePower then
			arg_27_0.mNewbieRewardView:setPower(iter_27_1.Power)
		end
	end

	local var_27_0 = {}

	for iter_27_2, iter_27_3 in ipairs(arg_27_1.PromoterRewards) do
		if iter_27_3.State == 0 or iter_27_3.State == 1 then
			table.insert(var_27_0, iter_27_3)
		end
	end

	arg_27_0.mPromoteInfoData.PromoterRewards = var_27_0

	arg_27_0.mPromoterRewardView:reloadData(arg_27_0.mPromoteInfoData.PromoterRewards)
end

function var_0_1.requestGetPromoteReward(arg_28_0, arg_28_1)
	if not arg_28_0.mGetPromoteRewardRequest then
		local function var_28_0()
			arg_28_0.mLastRequestPromoteReward.State = 3

			arg_28_0:onResponseMyPromoteInfo(arg_28_0.mPromoteInfoData)
			arg_28_0:showRewards("ui/guild/guild_090.png", string.lf("恭喜获得下列奖励:"), arg_28_0.mLastRequestPromoteReward.Reward)
		end

		arg_28_0.mGetPromoteRewardRequest = ActivityGetPromoteReward:new()

		arg_28_0.mGetPromoteRewardRequest:setResponseNormalHandler(var_28_0)
	end

	arg_28_0.mLastRequestPromoteReward = arg_28_1

	arg_28_0.mGetPromoteRewardRequest:request(arg_28_1.Id)
end

function var_0_1.requestSetPromoter(arg_30_0, arg_30_1)
	if not arg_30_0.mSetPromoterRequest then
		local function var_30_0()
			arg_30_0:showRewards("ui/guild/guild_090.png", string.lf("恭喜获得下列奖励:"), arg_30_0.mSetPromoterRequest.restable.Reward)
			Player:setIsHavePromoterGift(true)
			Player:setPromoterName(arg_30_1)
			addLabelWithColorSize(arg_30_0.mBgSprite, string.lf("我的邀请者:#F0D000%s", Player.promoterName), ccc3(240, 240, 240), 22, ccp(0.5, 0.5), ccp(arg_30_0.mBgSize.width / 2, arg_30_0.mBgSize.height - 80))
			arg_30_0.mBgFrameSprite:setPosition(arg_30_0.mBgSize.width / 2, arg_30_0.mBgSize.height - 80)
			arg_30_0.mNewbieRewardView:setVisible(false)
			arg_30_0.mEditBox:setVisible(false)
			arg_30_0.mBtnGet:setVisible(false)
		end

		arg_30_0.mSetPromoterRequest = ActivityFriendPromoter:new()

		arg_30_0.mSetPromoterRequest:setResponseNormalHandler(var_30_0)
	end

	arg_30_0.mSetPromoterRequest:request(arg_30_1)
end

return var_0_1
