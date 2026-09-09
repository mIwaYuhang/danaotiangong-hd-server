require("data.vip")
require("data.player")
require("network.StoreRequest")
require("network.RechargeRequest")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = require("base.cache")
local var_0_2 = require("scenes.SliderLayer")
local var_0_3 = class("StoreRechargeScene", function()
	return display.newScene("StoreRechargeScene")
end)

function var_0_3.ctor(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or {}
	arg_2_0.params = arg_2_1
	arg_2_0.hideUI = arg_2_1.hideUI or false

	local var_2_0 = {}

	for iter_2_0 = 0, #VipPrivileges do
		table.insert(var_2_0, VipPrivileges[iter_2_0].desc)
	end

	if arg_2_0:isUseIAPPurchases(true) then
		StoreIAP:init()
	end

	arg_2_0.viplist = var_2_0

	arg_2_0:initRequest()

	arg_2_0.buttonTable = {}

	if not arg_2_0.hideUI then
		arg_2_0:initMainUI()
	end
end

function var_0_3.delayCallSetObtainButtonEnable(arg_3_0)
	arg_3_0:setObtainButtonEnable(true)
end

function var_0_3.initRequest(arg_4_0)
	arg_4_0.rechargeListRequest = RechargeListRequest:new(arg_4_0)

	arg_4_0.rechargeListRequest:setResponseNormalHandler(function()
		local var_5_0 = arg_4_0.rechargeListRequest:getResponseContent()

		var_0_1.set("recharge-list", var_5_0)
		arg_4_0:reloadIAPProducts()
		arg_4_0.tableview:reloadData(var_5_0)
	end)
	arg_4_0.rechargeListRequest:setResponseExceptionHandler(function()
		print("请求发生错误")
	end)

	local function var_4_0(arg_7_0, arg_7_1)
		local var_7_0 = CCArray:create()

		var_7_0:addObject(CCDelayTime:create(0.8))
		var_7_0:addObject(CCCallFunc:create(handler(arg_4_0, arg_4_0.delayCallSetObtainButtonEnable)))
		arg_4_0:runAction(CCSequence:create(var_7_0))

		if arg_4_0:isUseIAPPurchases(true) and StoreIAP:canMakePurchases() then
			StoreIAP:purchaseProduct(arg_7_1.ID, arg_7_0)
		elseif device.platform == "android" or arg_4_0:isUseIAPPurchases(false) == false and device.platform == "ios" then
			IPlatform:instance():AddLuaCallBack(Lua_CallBackType_ReCharge, function()
				if IPlatform:instance():getConfig("Channel") == "ZSY_VN" then
					Platform.showSystemHUD()
				end

				require("framework.scheduler").performWithDelayGlobal(function()
					if IPlatform:instance():getConfig("Channel") == "ZSY_VN" then
						Platform.hideSystemHUD()
					end

					Player:scheduleNotify()
				end, 3)
			end)

			arg_7_1.payer_vipLevel = Player.vipLevel
			arg_7_1.payer_curGold = Player.curGold
			arg_7_1.player_userid = Player.userId
			arg_7_1.player_nickname = Player.nickName
			arg_7_1.player_servername = Player.serverInfo.ServerName
			arg_7_1.player_serverid = Player.serverInfo.ServerID
			arg_7_1.player_userlevel = Player.level
			arg_7_1.user_ext_data = Player.thirdLoginData

			IPlatform:instance():recharge(json.encode(arg_7_1), arg_7_0)
		else
			ui.showMessageBox({
				text = string.lf("你的设备暂时不能充值,请确认是否禁用了购买功能!")
			})
		end

		local var_7_1 = {
			orderId = arg_7_0,
			totalGold = tostring(arg_7_1.Ingot + arg_7_1.ExtreIngot),
			currencyAmount = arg_7_1.Money
		}

		IPlatform:instance():cpInfo("onChargeRequest", json.encode(var_7_1))
	end

	arg_4_0.orderIdRequest = OrderIdRequest:new()

	arg_4_0.orderIdRequest:setResponseNormalHandler(function()
		local var_10_0, var_10_1 = arg_4_0.orderIdRequest:getOrderIdAndProductData()

		var_4_0(var_10_0, var_10_1)
	end)

	arg_4_0.orderPointIdRequest = OrderPointIdRequest:new()

	arg_4_0.orderPointIdRequest:setResponseNormalHandler(function()
		local var_11_0, var_11_1 = arg_4_0.orderPointIdRequest:getOrderIdAndProductData()

		var_4_0(var_11_0, var_11_1)
	end)
end

function var_0_3.initMainUI(arg_12_0)
	local var_12_0 = require("scenes.CommonBgLayer").new({
		titleSprite = "uilocal/store/store_text_005.png",
		returnAction = function()
			local var_13_0 = arg_12_0.params.from
			local var_13_1 = arg_12_0.params.backcall

			if var_13_1 then
				var_13_1()
			elseif var_13_0 then
				if var_13_0 == "SignMonthLayer" then
					game.enterActivityScene({
						type = ActivityType.eSignMonth
					})
				elseif var_13_0 == "GrowUpPlanLayer" then
					game.enterActivityScene({
						type = ActivityType.eGrowUpPlan
					})
				elseif var_13_0 == "GoldActivityLayer" then
					game.enterActivityScene({
						type = ActivityType.eGoldGod
					})
				elseif var_13_0 == "HomeSceneNormal" then
					game.enterHomeScene()
				elseif var_13_0 == "DuelRankScene" then
					game.enterDuelRankScene()
				elseif var_13_0 == "TianMingRecruitScene" then
					game.enterTianmingRecruitScene()
				end
			else
				game.enterStoreScene()
			end
		end
	})
	local var_12_1 = var_12_0:getBackgroundSprite()
	local var_12_2 = var_12_1:getContentSize()

	arg_12_0:addChild(var_12_0)

	arg_12_0.container = var_12_1

	local var_12_3 = createPlayerAttrNode({
		ItemType.eGold,
		ItemType.eCoin
	})

	var_12_3:setPosition(490, 578)
	arg_12_0.container:addChild(var_12_3)

	local var_12_4 = display.newSprite("uilocal/store/store_text_060.png", 480, 538)

	arg_12_0.container:addChild(var_12_4)

	local var_12_5 = arg_12_0:createMainView()

	var_12_5:setAnchorPoint(ccp(0, 0))
	var_12_5:setPosition(10, 15)
	var_12_1:addChild(var_12_5)
end

function var_0_3.createMainView(arg_14_0)
	local var_14_0 = CCSize(940, 500)
	local var_14_1 = display.newScale9Sprite("ui/store/store_012.jpg")

	var_14_1:setPreferredSize(var_14_0)

	local var_14_2 = arg_14_0:createVIPView()

	var_14_2:setAnchorPoint(ccp(0, 0))
	var_14_2:setPosition(5, 1)
	var_14_1:addChild(var_14_2)

	if Player:getServerVipEnable() == 0 then
		local var_14_3 = display.newScale9Sprite("ui/store/store_033.jpg")

		var_14_3:setAnchorPoint(ccp(0, 0))
		var_14_3:setPosition(5, 1)
		var_14_1:addChild(var_14_3)
	end

	if IPlatform:instance():getConfig("Channel") == "ZSY_VN" then
		local var_14_4 = arg_14_0:createVNView()

		var_14_4:setAnchorPoint(ccp(0, 0))
		var_14_4:setPosition(470, 1)
		var_14_1:addChild(var_14_4)
	else
		local var_14_5 = arg_14_0:createCardView()

		var_14_5:setAnchorPoint(CCPoint(0, 0))
		var_14_5:setPosition(470, 3)
		var_14_1:addChild(var_14_5)
	end

	return var_14_1
end

function var_0_3.createVNView(arg_15_0)
	local var_15_0 = display.newNode()
	local var_15_1 = display.newSprite("ui/store/store_009.jpg")
	local var_15_2 = var_15_1:getContentSize()

	var_15_1:setAnchorPoint(CCPoint(0, 1))
	var_15_1:setPosition(0, 490)
	var_15_0:addChild(var_15_1)

	local var_15_3 = display.newSprite("ui/store/store_019.png")

	var_15_3:setPosition(70, var_15_2.height / 2)
	var_15_1:addChild(var_15_3)

	local var_15_4 = ui.newControlButton({
		normalImage = "ui/store/store_016.png",
		clickAction = function(arg_16_0, arg_16_1)
			arg_15_0:setObtainButtonEnable(false)
			arg_15_0.orderIdRequest:requestServerList({
				Ingot = 0,
				Money = 0,
				ExtreIngot = 0
			})
		end
	})

	var_15_4:setAnchorPoint(CCPoint(1, 0.5))
	var_15_4:setPosition(var_15_2.width - 10, var_15_2.height / 2)
	var_15_1:addChild(var_15_4)

	local var_15_5 = display.newSprite("ui/store/store_044.png")

	var_15_5:setAnchorPoint(CCPoint(0, 0))
	var_15_5:setPosition(0, 0)
	var_15_5:setScaleY(0.7)
	var_15_5:setScaleX(0.9)
	var_15_0:addChild(var_15_5)

	return var_15_0
end

function var_0_3.createVIPView(arg_17_0)
	local var_17_0 = display.newSprite("ui/store/store_010.jpg")
	local var_17_1 = var_17_0:getContentSize()

	arg_17_0.vipview = var_17_0

	local var_17_2 = arg_17_0:createUserView()

	var_17_2:setAnchorPoint(ccp(0, 0))
	var_17_2:setPosition(24, 385)
	var_17_0:addChild(var_17_2)

	local var_17_3 = var_0_0.createIndicator("left")

	var_17_3:setPosition(30, 200)
	var_17_0:addChild(var_17_3)

	var_17_0.leftIndicator = var_17_3

	local var_17_4 = var_0_0.createIndicator("right")

	var_17_4:setPosition(433, 200)
	var_17_0:addChild(var_17_4)

	var_17_0.rightIndicator = var_17_4

	local var_17_5 = {
		navOffSprite = "ui/common/common_047.png",
		navOnSprite = "ui/common/common_048.png",
		navMargin = 30,
		size = CCSize(360, 280),
		point = ccp(60, 60),
		navPosition = ccp(0, -20),
		numberHandler = function()
			return #arg_17_0.viplist
		end,
		changedHandler = function(arg_19_0)
			arg_17_0:showVipTitle(arg_19_0)
		end,
		cellHandler = function(arg_20_0, arg_20_1)
			local var_20_0 = arg_17_0.viplist[arg_20_1]
			local var_20_1 = arg_17_0:createSlideCellView(arg_20_0, arg_20_1, var_20_0)

			arg_20_0:addChild(var_20_1)
		end,
		direction = SliderDirection.eHorizontal,
		clipScaleX = Adapter.MinScale,
		clipScaleY = Adapter.MinScale
	}
	local var_17_6 = var_0_2.new(var_17_5)

	var_17_6:setPosition(40, 53)
	var_17_0:addChild(var_17_6)

	arg_17_0.slideview = var_17_6

	arg_17_0.slideview:reloadData(Player.vipLevel + 1)

	return var_17_0
end

function var_0_3.createUserView(arg_21_0)
	local var_21_0 = ccc3(255, 241, 156)
	local var_21_1 = CCSize(390, 90)
	local var_21_2 = display.newNode()

	var_21_2:setContentSize(var_21_1)

	local var_21_3 = CCLabelAtlas:create(tostring(Player.vipLevel), "uilocal/store/store_text_059.png", 34, 54, 48)

	var_21_3:setAnchorPoint(ccp(0, 0.5))
	var_21_3:setPosition(115, 42)
	var_21_2:addChild(var_21_3)

	local var_21_4 = var_0_0.newLabel({
		text = "",
		color = var_21_0
	})

	var_21_4:setPosition(285, 80)
	var_21_2:addChild(var_21_4)

	local var_21_5 = require("scenes.ProgressBar").new({
		backImage = "ui/common/common_032.png",
		percent = 0,
		barImages = {
			"ui/common/common_031.png"
		},
		backSize = CCSize(250, 26),
		barSize = CCSize(218, 11),
		barPosition = ccp(-103, 0)
	})

	var_21_5:setPosition(295, 50)
	var_21_2:addChild(var_21_5)

	local var_21_6 = var_0_0.newLabel({
		text = "",
		color = var_21_0
	})

	var_21_6:setPosition(295, 15)
	var_21_2:addChild(var_21_6)

	local function var_21_7()
		var_21_4:setString(string.lf("当前VIP等级 %s", Player.vipLevel))
		var_21_5:setProgressPercent(1, Player.vipExp * 0.01)

		local var_22_0

		if Player.vipLevel < table.maxn(VipPrivileges) then
			var_22_0 = string.lf("再购买 #FF6F05%d元宝#FFF19C 成为 VIP%d", Player.vipLevelUpExp, Player.vipLevel + 1)
		else
			var_22_0 = string.lf("您已经成为最高级 VIP 用户")
		end

		var_21_6:setString(var_22_0)
	end

	addObserverToNode(var_21_2, var_21_7, PalyerEvents.eChargeSuccess)
	var_21_7()

	return var_21_2
end

function var_0_3.showVipTitle(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.vipview
	local var_23_1 = var_23_0.title

	if not var_23_1 then
		var_23_1 = display.newSprite()

		var_23_1:setPosition(240, 357)
		var_23_0:addChild(var_23_1)

		var_23_0.title = var_23_1
	end

	local var_23_2 = {
		"store_text_024.png",
		"store_text_025.png",
		"store_text_026.png",
		"store_text_057.png",
		"store_text_027.png",
		"store_text_028.png",
		"store_text_029.png",
		"store_text_030.png",
		"store_text_031.png",
		"store_text_032.png",
		"store_text_055.png",
		"store_text_056.png",
		"store_text_070.png"
	}
	local var_23_3 = CCTextureCache:sharedTextureCache():addImage("uilocal/store/" .. var_23_2[arg_23_1])

	var_23_1:setTexture(var_23_3)
	var_23_0.leftIndicator:setVisible(arg_23_1 ~= 1)
	var_23_0.rightIndicator:setVisible(arg_23_1 ~= #arg_23_0.viplist)
end

function var_0_3.createSlideCellView(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = CCSize(360, 280)
	local var_24_1 = var_0_0.newNode()

	var_24_1:setContentSize(var_24_0)
	var_24_1:setAnchorPoint(ccp(0, 0))
	var_24_1:setPosition(0, 0)

	local var_24_2 = var_0_0.newLabel({
		size = 18,
		text = arg_24_3,
		dimensions = CCSize(300, 280),
		color = ccc3(240, 235, 200)
	})

	var_24_2:setAnchorPoint(ccp(0.5, 1))
	var_24_2:setPosition(var_24_0.width / 2 + 60, var_24_0.height)
	var_24_1:addChild(var_24_2)

	return var_24_1
end

function var_0_3.createCardView(arg_25_0)
	local var_25_0 = CCSize(459, 491)
	local var_25_1 = {
		direction = kCCScrollViewDirectionVertical,
		size = var_25_0,
		sizehandler = function(arg_26_0, arg_26_1)
			return CCSize(456, 139)
		end,
		cellhandler = handler(arg_25_0, arg_25_0.createCardCell)
	}
	local var_25_2 = createTableView(var_25_1)

	arg_25_0.tableview = var_25_2

	local var_25_3 = var_0_1.get("recharge-list")

	if not var_25_3 then
		arg_25_0.rechargeListRequest:request()
	else
		var_25_2:reloadData(var_25_3)
		arg_25_0:reloadIAPProducts()
	end

	return var_25_2
end

function var_0_3.createCardCell(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = display.newSprite("ui/store/store_009.jpg")
	local var_27_1 = var_27_0:getContentSize()

	var_27_0:setAnchorPoint(CCPoint(0, 0))
	var_27_0:setPosition(0, 1)

	local var_27_2

	arg_27_2 = arg_27_1 - arg_27_2 + 1

	local var_27_3 = arg_27_2 == 1 and "ui/store/store_017.png" or arg_27_2 == 2 and "ui/store/store_018.png" or arg_27_2 == 3 and "ui/store/store_019.png" or "ui/store/store_020.png"
	local var_27_4 = display.newSprite(var_27_3)

	var_27_4:setPosition(70, var_27_1.height / 2)
	var_27_0:addChild(var_27_4)

	local var_27_5 = arg_27_3.Ingot >= 1000 and 0.58 or 1
	local var_27_6 = CCLabelAtlas:create(tostring(arg_27_3.Ingot), "uilocal/common/common_num_1.png", 28, 36, 48)

	var_27_6:setAnchorPoint(ccp(1, 0.5))
	var_27_6:setScale(var_27_5)
	var_27_6:setPosition(220, 85)
	var_27_0:addChild(var_27_6)

	local var_27_7 = display.newSprite("uilocal/store/store_text_058.png")

	var_27_7:setAnchorPoint(ccp(0.5, 0.5))
	var_27_7:setPosition(240, 85)
	var_27_0:addChild(var_27_7)

	local var_27_8 = arg_27_3.ExtreIngot >= 10000 and 0.75 or arg_27_3.ExtreIngot >= 1000 and 0.9 or 1
	local var_27_9 = CCLabelAtlas:create(tostring(arg_27_3.ExtreIngot), "uilocal/common/common_num_1.png", 28, 36, 48)

	var_27_9:setAnchorPoint(ccp(0, 0.5))
	var_27_9:setScale(0.75 * var_27_8)
	var_27_9:setPosition(260, 85)
	var_27_0:addChild(var_27_9)

	local var_27_10 = string.lf("仅售  ￥%d", arg_27_3.Money)

	if IPlatform:instance():getConfig("Channel") == "91" then
		var_27_10 = string.lf("仅售  %d个91豆", arg_27_3.Money)
	elseif IPlatform:instance():getConfig("Channel") == "ZSY_TW" then
		var_27_10 = string.lf("仅售  NT$%d", arg_27_3.Money)
	end

	local var_27_11 = var_0_0.newLabel({
		size = 24,
		outline = true,
		text = var_27_10,
		color = ccc3(248, 236, 178)
	})

	var_27_11:setPosition(220, 35)
	var_27_0:addChild(var_27_11)

	local var_27_12 = ui.newControlButton({
		normalImage = "ui/store/store_016.png",
		clickAction = function(arg_28_0, arg_28_1)
			arg_27_0:setObtainButtonEnable(false)
			arg_27_0.orderIdRequest:requestServerList(clone(arg_27_3))
		end
	})

	var_27_12:setPosition(var_27_1.width - 65, var_27_1.height / 2)
	var_27_0:addChild(var_27_12)
	table.insert(arg_27_0.buttonTable, var_27_12)

	return var_27_0
end

function var_0_3.startPurchase(arg_29_0, arg_29_1)
	arg_29_0.orderPointIdRequest:requestOrderId(arg_29_1)
end

function var_0_3.isUseIAPPurchases(arg_30_0, arg_30_1)
	local var_30_0 = IPlatform:instance():getConfig("Channel")
	local var_30_1 = var_30_0 == "ZSY" or var_30_0 == "ZSY_TW"

	if arg_30_1 == true then
		return device.platform == "ios" and var_30_1
	else
		return var_30_1
	end
end

function var_0_3.reloadIAPProducts(arg_31_0)
	local var_31_0 = var_0_1.get("recharge-list")

	if arg_31_0:isUseIAPPurchases(true) and StoreIAP:canMakePurchases() and table.getn(var_31_0) > 0 and not StoreIAP:isProductsLoaded(var_31_0[1].ID) then
		StoreIAP:loadProducts(arg_31_0:getProductIds())
	end
end

function var_0_3.loadIAPProducts(arg_32_0, arg_32_1)
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in ipairs(arg_32_1 or {}) do
		table.insert(var_32_0, iter_32_1.ID)
	end

	if arg_32_0:isUseIAPPurchases(true) and StoreIAP:canMakePurchases() and table.getn(var_32_0) > 0 and not StoreIAP:isProductsLoaded(var_32_0[1]) then
		StoreIAP:loadProducts(var_32_0)
	end
end

function var_0_3.getProductIds(arg_33_0)
	local var_33_0 = var_0_1.get("recharge-list")
	local var_33_1 = {}

	for iter_33_0, iter_33_1 in ipairs(var_33_0) do
		table.insert(var_33_1, iter_33_1.ID)
	end

	return var_33_1
end

function var_0_3.setObtainButtonEnable(arg_34_0, arg_34_1)
	for iter_34_0, iter_34_1 in ipairs(arg_34_0.buttonTable) do
		iter_34_1:setEnabled(arg_34_1)
	end
end

return var_0_3
