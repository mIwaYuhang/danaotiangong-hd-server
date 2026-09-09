require("network.ZSZZRequest")

local var_0_0 = class("ZSZZMoreRankLayer", function()
	return display.newColorLayer(ccc4(0, 0, 0, 180))
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.mParams = arg_2_1

	local var_2_0 = display.newScale9Sprite("ui/xunfang/xunfang_002.png")

	arg_2_0.bgSize = CCSize(760, 600)

	var_2_0:setPreferredSize(arg_2_0.bgSize)
	var_2_0:setScale(Adapter.MinScale)
	var_2_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_0:setPosition(display.cx, display.cy)
	arg_2_0:addChild(var_2_0)

	arg_2_0.background = display.newNode()

	arg_2_0.background:setContentSize(arg_2_0.bgSize)

	local var_2_1 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		highlightedImage = "ui/common/btn_closed.png",
		position = ccp(arg_2_0.bgSize.width - 20, arg_2_0.bgSize.height - 20),
		clickAction = function()
			if arg_2_0._closecallback then
				arg_2_0._closecallback()
			end

			arg_2_0:removeFromParentAndCleanup(true)
		end
	})

	var_2_0:addChild(var_2_1)
	var_2_1:setTouchPriority(-1)

	local var_2_2 = {
		[MasterType.eLand] = "uilocal/fuben/zszz_text_031.png",
		[MasterType.eDemon] = "uilocal/fuben/zszz_text_028.png",
		[MasterType.eHeaven] = "uilocal/fuben/zszz_text_030.png"
	}
	local var_2_3 = display.newSprite(var_2_2[arg_2_1.type], arg_2_0.bgSize.width / 2, arg_2_0.bgSize.height - 30)

	var_2_0:addChild(var_2_3)

	arg_2_0.background = display.newNode()

	arg_2_0.background:setContentSize(arg_2_0.bgSize)

	arg_2_0.mRankView = arg_2_0:createRankTableView()

	arg_2_0.mRankView:setPosition(12, 10)
	arg_2_0.background:addChild(arg_2_0.mRankView)
	var_2_0:addChild(arg_2_0.background)
	arg_2_0.mRankView:reloadData(arg_2_1.rankData)
end

function var_0_0.createRankTableView(arg_4_0)
	local var_4_0 = display.newNode()

	var_4_0.dataSrc = {}

	local function var_4_1(arg_5_0)
		return #var_4_0.dataSrc
	end

	local var_4_2 = CCSizeMake(740, 100)

	local function var_4_3(arg_6_0)
		return var_4_2.height, var_4_2.width
	end

	local function var_4_4(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_1 + 1
		local var_7_1 = arg_7_0:cellAtIndex(arg_7_1)

		if var_7_1 == nil then
			var_7_1 = CCTableViewCell:new()
		end

		var_7_1:removeAllChildrenWithCleanup(true)

		local var_7_2 = var_4_0.dataSrc[var_7_0]

		dump(var_7_2)

		local var_7_3 = display.newSprite("ui/fuben/zszz_016.png")

		var_7_3:setAnchorPoint(ccp(0, 0))
		var_7_3:setPosition(-18, 10)
		var_7_1:addChild(var_7_3)

		local var_7_4 = display.newSprite("uilocal/fuben/zszz_text_016.png")

		var_7_4:setAnchorPoint(ccp(0.5, 1))
		var_7_4:setPosition(var_4_2.width / 2, var_4_2.height - 5)
		var_7_1:addChild(var_7_4)

		local var_7_5 = CCLabelAtlas:create(var_7_0, "uilocal/duel/duel_text_019.png", 30, 38, 48)

		if var_7_0 >= 10 then
			var_7_5:setScale(0.45)
		else
			var_7_5:setScale(0.75)
		end

		var_7_5:setAnchorPoint(ccp(0.5, 0))
		var_7_5:setPosition(138, 0)
		var_7_4:addChild(var_7_5)
		addLabelWithColorSize(var_7_1, string.lf("[%s] %s", var_7_2.ServerName, var_7_2.PlayerName), ccc3(238, 180, 34), 18, ccp(0, 0.5), ccp(100, var_4_2.height / 2 - 10))
		addLabelWithColorSize(var_7_1, string.lf("击杀数:#F4F4F4%d", var_7_2.KillCount), ccc3(255, 227, 0), 18, ccp(0, 0.5), ccp(400, var_4_2.height / 2 - 10))

		local var_7_6 = ui.newControlButton({
			fontSize = 18,
			titleImage = "uilocal/fuben/zszz_text_015.png",
			normalImage = "ui/common/common_115.png",
			position = ccp(var_4_2.width - 75, var_4_2.height / 2),
			clickAction = function()
				arg_4_0:onBtnViewClicked(var_7_2.PlayerId)
			end
		})

		var_7_1:addChild(var_7_6)

		return var_7_1
	end

	local var_4_5 = CCTableView:create(CCSize(var_4_2.width, 530))

	var_4_5:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_4_5:setDirection(kCCScrollViewDirectionVertical)
	var_4_5:registerScriptHandler(var_4_3, CCTableView.kTableCellSizeForIndex)
	var_4_5:registerScriptHandler(var_4_1, CCTableView.kNumberOfCellsInTableView)
	var_4_5:registerScriptHandler(var_4_4, CCTableView.kTableCellSizeAtIndex)
	var_4_0:addChild(var_4_5)

	function var_4_0.reloadData(arg_9_0, arg_9_1)
		var_4_0.dataSrc = arg_9_1

		var_4_5:reloadData()
	end

	return var_4_0
end

function var_0_0.onBtnViewClicked(arg_10_0, arg_10_1)
	local var_10_0 = require("scenes.fuben.ZSZZPlayerBattleInfoLayer").new({
		from = "ZSZZFightScene",
		playerId = arg_10_1,
		type = arg_10_0.mParams.type,
		pageType = arg_10_0.mParams.pageType
	})

	arg_10_0:addChild(var_10_0)
end

function var_0_0.createRankItem(arg_11_0, arg_11_1)
	local var_11_0 = "ui/worldboss/worldboss_002.png"

	if arg_11_1.PlayerId == Player.userId and arg_11_1.ServerId == Player.serverInfo.ServerID then
		var_11_0 = "ui/worldboss/worldboss_003.png"
	end

	local var_11_1 = {
		"ui/worldboss/worldboss_004.png",
		"ui/worldboss/worldboss_007.png",
		"ui/worldboss/worldboss_006.png",
		"ui/worldboss/worldboss_005.png"
	}
	local var_11_2 = arg_11_0:getImageSize("ui/worldboss/worldboss_002.png")
	local var_11_3 = display.newSprite(var_11_0)
	local var_11_4 = display.newSprite(var_11_1[arg_11_1.Rank] or "ui/guild/guild_050.png", 49, var_11_2.height / 2)

	var_11_3:addChild(var_11_4)

	local var_11_5 = arg_11_1.Rank > 9999 and 22 or 28

	if arg_11_1.Rank > 4 then
		addLabelWithColorSize(var_11_4, arg_11_1.Rank, ccc3(240, 208, 0), var_11_5, ccp(0.5, 0.5), ccp(35, 37))
	end

	addLabelWithColorSize(var_11_4, string.format("[%s]#F4F4F4%s", arg_11_1.ServerName, arg_11_1.PlayerName), ccc3(255, 228, 34), 22, ccp(0, 0.5), ccp(90, var_11_2.height - 30))
	addLabelWithColorSize(var_11_4, string.lf("击杀数:#F4F4F4%s", arg_11_1.KillCount), ccc3(255, 227, 0), 22, ccp(0, 0.5), ccp(90, var_11_2.height - 58))

	local var_11_6 = ui.newControlButton({
		normalImage = "ui/guild/guild_051.png",
		titleImage = "uilocal/fuben/zszz_text_015.png",
		position = ccp(var_11_2.width - 40, var_11_2.height / 2),
		clickAction = function()
			print(arg_11_0.mParams.pageType)

			local var_12_0

			if arg_11_1.PlayerId == Player.userId and arg_11_1.ServerId == Player.serverInfo.ServerID then
				var_12_0 = require("").new({
					from = "ZSZZFightScene"
				})
			else
				var_12_0 = require("scenes.fuben.ZSZZPlayerBattleInfoLayer").new({
					from = "ZSZZFightScene",
					playerId = arg_11_1.PlayerId,
					type = arg_11_0.mParams.type,
					pageType = arg_11_0.mParams.pageType
				})
			end

			arg_11_0:addChild(var_12_0)
		end
	})

	var_11_3:addChild(var_11_6)

	return var_11_3
end

function var_0_0.getImageSize(arg_13_0, arg_13_1)
	return CCTextureCache:sharedTextureCache():addImage(arg_13_1):getContentSizeInPixels()
end

return var_0_0
