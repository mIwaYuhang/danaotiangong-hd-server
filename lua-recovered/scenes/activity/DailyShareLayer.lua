require("network.ActivityRequest")

local var_0_0 = require("scenes.toollayer.tool")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = require("scenes.ToolLayer")
local var_0_3 = class("DailyShareLayer", function()
	return display.newLayer()
end)

function var_0_3.ctor(arg_2_0)
	arg_2_0.nodeSize = CCSize(830, 545)
	arg_2_0.container = CCLayerColor:create(ccc4(0, 0, 0, 0))

	arg_2_0.container:setContentSize(arg_2_0.nodeSize)
	arg_2_0:addChild(arg_2_0.container)

	local var_2_0 = display.newSprite("ui/activity/activity_086.jpg", arg_2_0.nodeSize.width / 2, arg_2_0.nodeSize.height / 2 + 12)

	arg_2_0.container:addChild(var_2_0)
	arg_2_0:initNetworkRequest()

	local var_2_1 = IPlatform:instance():getConfig("Channel") == "ZSY_TW"
	local var_2_2 = ui.newEditBox({
		image = "ui/activity/activity_087.png",
		y = 322,
		x = 314,
		size = CCSize(564, 67),
		fontColor = display.COLOR_BLACK
	})

	arg_2_0.container:addChild(var_2_2)

	arg_2_0.editBox = var_2_2

	arg_2_0:createGetButton()

	local var_2_3 = getShareEnabledTable()

	if var_2_1 then
		arg_2_0.editBox:setPosition(314, 282)
		arg_2_0.getButton:setPosition(692, 285)

		var_2_3 = {}
	end

	for iter_2_0 = 1, #var_2_3 do
		local var_2_4 = ui.newControlButton({
			normalImage = var_2_3[iter_2_0].image,
			position = ccp(127 + (iter_2_0 - 1) * 150, 95),
			clickAction = function()
				if tonumber(EditionConfig.__Version) < 200 and var_2_1 == false then
					showFlashNotice(string.lf("该功能需要更新客户端后才能使用!"))
				else
					local var_3_0 = string.lf("我发现了一款超好玩的游戏“大闹天宫HD”，电影形象正版授权！何润东献唱主题曲！还有狂送亿元活动进行中！不容错过！！！")

					IPlatform:instance():AddLuaCallBack(Lua_CallBackType_Share, function(arg_4_0)
						if arg_4_0 == true or arg_4_0 == nil then
							arg_2_0.shareRequest:request()
						end
					end)

					local var_3_1 = CCFileUtils:sharedFileUtils():fullPathForFilename("ui/account/account_009.jpg")

					IPlatform:instance():Share(var_2_3[iter_2_0].type, var_3_0, var_3_1)
				end
			end
		})

		arg_2_0.container:addChild(var_2_4)
	end

	if var_2_1 == false then
		local var_2_5 = createItemCountNode({
			type = ItemType.eCoin,
			value = Player.level * 1000
		})

		var_2_5:setPosition(ccp(354, 196))
		arg_2_0.container:addChild(var_2_5)

		local var_2_6 = createItemCountNode({
			value = 100,
			type = ItemType.eGold
		})

		var_2_6:setPosition(ccp(703, 196))
		arg_2_0.container:addChild(var_2_6)
	end
end

function var_0_3.createGetButton(arg_5_0)
	if not tolua.isnull(arg_5_0.getButton) then
		arg_5_0.getButton:removeFromParent()
	end

	if not tolua.isnull(arg_5_0.btnPreView) then
		arg_5_0.btnPreView:removeFromParent()
	end

	arg_5_0.getButton = ui.newControlButton({
		normalImage = "ui/activity/activity_064.png",
		disabledImage = "ui/activity/activity_065.png",
		clickAction = function(arg_6_0, arg_6_1)
			local var_6_0 = arg_5_0.editBox:getText()

			if var_6_0 and string.len(var_6_0) > 1 then
				arg_5_0.giftRequest:request(var_6_0)
			else
				ui.showMessageBox({
					text = string.lf("上仙！请您输入正确的兑换码!T.T")
				})
			end
		end
	})

	arg_5_0.getButton:setPosition(692, 325)
	arg_5_0.container:addChild(arg_5_0.getButton)

	local var_5_0 = arg_5_0.getButton:getContentSize()
	local var_5_1 = "uilocal/activity/activity_text_031.png"
	local var_5_2 = display.newSprite(var_5_1)

	var_5_2:setPosition(var_5_0.width / 2, var_5_0.height / 2)
	arg_5_0.getButton:addChild(var_5_2)
end

function var_0_3.showPromoterReward(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = display.newLayer()

	var_7_0:addTouchEventListener(function(arg_8_0, arg_8_1, arg_8_2)
		return false
	end, false, 1, true)
	var_7_0:setTouchEnabled(true)
	arg_7_0.container:addChild(var_7_0)

	local var_7_1 = display.newSprite(arg_7_1, arg_7_0.nodeSize.width / 2, arg_7_0.nodeSize.height / 2)

	var_7_0:addChild(var_7_1)

	local var_7_2 = var_7_1:getContentSize()
	local var_7_3 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/guild/guild_text_035.png",
		position = ccp(var_7_2.width / 2, 35),
		clickAction = function()
			var_7_0:removeFromParentAndCleanup(true)
		end
	})

	var_7_1:addChild(var_7_3)

	local var_7_4 = addLabelWithColorSize(var_7_1, arg_7_2, ccc3(212, 212, 212), 20, ccp(0, 1), ccp(15, var_7_2.height - 15))

	var_7_4:setHorizontalAlignment(kCCTextAlignmentLeft)
	var_7_4:setDimensions(CCSizeMake(var_7_2.width - 30, var_7_2.height - 30))

	arg_7_3 = arg_7_3 or PromoterReward

	local var_7_5 = arg_7_0:createRewardsView(CCSizeMake(var_7_2.width - 30, 125), arg_7_3)

	var_7_5:setPosition(15, 65)
	var_7_1:addChild(var_7_5)
end

function var_0_3.createRewardsView(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = display.newNode()
	local var_10_1 = CCScrollView:create(arg_10_1, var_10_0)

	var_10_1:setDirection(kCCScrollViewDirectionHorizontal)
	var_10_1:setAnchorPoint(ccp(0, 0))
	var_10_1:setPosition(15, 65)

	local var_10_2 = 0
	local var_10_3 = CCSizeMake(140, 125)

	for iter_10_0, iter_10_1 in ipairs(arg_10_2) do
		local var_10_4 = figure.createHeader({
			isName = true,
			type = iter_10_1.Type,
			itemId = iter_10_1.ID or 0,
			count = iter_10_1.Count,
			nameColor = getQualityColor(getItemQuality(iter_10_1.Type, iter_10_1.ID)),
			equipJieji = iter_10_1.BreakthroughCount,
			countColor = ccc3(255, 228, 0),
			clickAction = function()
				var_0_2.tipshandler(iter_10_1)
			end
		})

		var_10_0:addChild(var_10_4)
		var_10_4:setPosition(var_10_2 + var_10_3.width / 2, var_10_3.height / 2)

		var_10_2 = var_10_2 + var_10_3.width
	end

	var_10_0:setContentSize(CCSizeMake(var_10_2, var_10_3.height))

	return var_10_1
end

function var_0_3.initNetworkRequest(arg_12_0)
	arg_12_0.giftRequest = ActivityGiftRequest:new()

	local function var_12_0()
		arg_12_0:openTreasureBox(arg_12_0.giftRequest:getGift())
	end

	arg_12_0.giftRequest:setResponseNormalHandler(var_12_0)

	arg_12_0.shareRequest = SocialShareComplatedRequest:new()

	local function var_12_1()
		if arg_12_0.shareRequest:getRequestReward() == nil then
			ui.showMessageBox({
				text = string.lf("上仙，你今日已领取过分享奖励了！")
			})
		end
	end

	arg_12_0.shareRequest:setResponseNormalHandler(var_12_1)
end

function var_0_3.createRewardNode(arg_15_0, arg_15_1)
	local var_15_0 = CCSize(120, 120)
	local var_15_1 = var_0_1.newNode()

	var_15_1:setContentSize(var_15_0)

	local var_15_2 = figure.createHeader({
		isName = true,
		type = arg_15_1.Type,
		itemId = arg_15_1.ID,
		count = arg_15_1.Count
	})

	var_15_2:setPosition(var_15_0.width / 2, var_15_0.height / 2 + 10)
	var_15_1:addChild(var_15_2)

	return var_15_1
end

function var_0_3.boxAnimate(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = CCSkeletonAnimation:createWithFile("effectAni/ui_kaibaoxiang.json", "effectAni/ui_kaibaoxiang.atlas", 1)

	var_16_0:setScale(Adapter.MinScale)
	var_16_0:setPosition(display.cx, display.cy)
	arg_16_1:addChild(var_16_0)
	var_16_0:addAnimation("a1", false, 0, 0)
	var_16_0:addAnimation("a2", true, 0, 0)
	var_0_0.wait("time", 2.8, arg_16_2)
end

function var_0_3.rewardAnimate(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_1:getContentSize()
	local var_17_1 = ccp(var_17_0.width / 2, var_17_0.height + 120)

	var_0_0.foreach(arg_17_2, function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_1 then
			local var_18_0, var_18_1 = arg_18_1:getPosition()
			local var_18_2 = CCArray:create()

			var_18_2:addObject(CCMoveTo:create(0.2, ccp(var_18_0, var_18_1)))
			var_18_2:addObject(CCCallFunc:create(arg_18_2))
			arg_18_1:setPosition(var_17_1)
			arg_18_1:setVisible(true)
			arg_18_1:setZOrder(arg_18_0)
			arg_18_1:runAction(CCSequence:create(var_18_2))
		else
			arg_18_2()
		end
	end, arg_17_3)
end

function var_0_3.openTreasureBox(arg_19_0, arg_19_1)
	local var_19_0 = false
	local var_19_1 = CCLayerColor:create(ccc4(10, 10, 10, 200))
	local var_19_2
	local var_19_3 = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		local var_19_4 = arg_19_0:createRewardNode(iter_19_1)

		var_19_4:setVisible(false)
		table.insert(var_19_3, var_19_4)
	end

	local var_19_5 = var_0_1.tableLayout({
		row = 0,
		spacing = 10,
		col = 4,
		nodes = var_19_3,
		padding = {
			top = 0,
			bottom = 0,
			left = 10,
			right = 10
		}
	})

	arg_19_0:boxAnimate(var_19_1, function()
		arg_19_0:rewardAnimate(var_19_5, var_19_3, function()
			var_19_0 = true
		end)
	end)
	var_19_5:setAnchorPoint(ccp(0.5, 0.5))
	var_19_5:setScale(Adapter.MinScale)
	var_19_5:setPosition(display.cx, display.cy - 60)
	var_19_1:addChild(var_19_5)
	var_19_1:addTouchEventListener(function()
		if var_19_0 then
			var_19_1:removeFromParent()
		end
	end, false, 1, true)
	var_19_1:setTouchEnabled(true)
	CCDirector:sharedDirector():getRunningScene():addChild(var_19_1)
end

return var_0_3
