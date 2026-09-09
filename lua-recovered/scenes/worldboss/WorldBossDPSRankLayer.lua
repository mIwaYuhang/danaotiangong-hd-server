require("scenes.team.OthersTeamHelper")

local var_0_0 = class("WorldBossDPSRankLayer", function()
	return display.newColorLayer(ccc4(0, 0, 0, 180))
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.mParams = arg_2_1 or {}

	arg_2_0:setUI()
end

function var_0_0.setUI(arg_3_0)
	arg_3_0:addTouchEventListener(function(arg_4_0, arg_4_1, arg_4_2)
		return true
	end, false, 1, true)
	arg_3_0:setTouchEnabled(true)

	local var_3_0 = display.newSprite("ui/worldboss/worldboss_001.png", display.cx, display.cy)

	var_3_0:setScale(Adapter.MinScale)
	arg_3_0:addChild(var_3_0)

	arg_3_0.mBgSprite = var_3_0

	local var_3_1 = var_3_0:getContentSize()

	arg_3_0.mBgSize = var_3_1

	local var_3_2 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		position = ccp(var_3_1.width - 10, var_3_1.height - 10),
		clickAction = function()
			arg_3_0:removeFromParentAndCleanup(true)

			if arg_3_0.mParams and arg_3_0.mParams.closeCallBack then
				arg_3_0.mParams.closeCallBack()
			end
		end
	})

	var_3_2:setTouchPriority(-1)
	var_3_0:addChild(var_3_2)
	var_3_0:addChild(display.newSprite("uilocal/worldboss/worldboss_text_001.png", var_3_1.width / 2, var_3_1.height - 30))
	var_3_0:addChild(display.newSprite("uilocal/worldboss/worldboss_text_002.png", var_3_1.width / 2, var_3_1.height - 60))

	if arg_3_0.mParams.rankLst then
		arg_3_0:createRankView()
		arg_3_0.mRankView:reloadData(arg_3_0.mParams.rankLst)
	else
		arg_3_0:requestRankLst()
	end
end

function var_0_0.createRankView(arg_6_0)
	if arg_6_0.mRankView then
		return
	end

	local var_6_0 = false

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.mParams.rankLst) do
		if iter_6_1.playerID == Player.userId then
			var_6_0 = true

			break
		end
	end

	local var_6_1 = 5

	if not var_6_0 and arg_6_0.mParams.myRank and arg_6_0.mParams.myRank.rank > 0 then
		var_6_1 = 4
	end

	local var_6_2 = arg_6_0:getImageSize("ui/worldboss/worldboss_002.png")

	arg_6_0.mRankView = arg_6_0:createRankTableView(CCSize(var_6_2.width, (var_6_2.height + 5) * var_6_1))

	arg_6_0.mRankView:setPosition(12, 10 + (var_6_1 == 5 and 0 or var_6_2.height + 5))
	arg_6_0.mBgSprite:addChild(arg_6_0.mRankView)

	if var_6_1 == 4 then
		local var_6_3 = arg_6_0:createRankItem(arg_6_0.mParams.myRank)

		var_6_3:setAnchorPoint(ccp(0.5, 0))
		var_6_3:setPosition(arg_6_0.mBgSize.width / 2 + 2, 8)
		arg_6_0.mBgSprite:addChild(var_6_3)
	end
end

function var_0_0.createRankTableView(arg_7_0, arg_7_1)
	local var_7_0 = display.newNode()

	var_7_0:setContentSize(arg_7_1)

	local var_7_1 = {}
	local var_7_2 = arg_7_0:getImageSize("ui/worldboss/worldboss_002.png")

	var_7_2.height = var_7_2.height + 5

	local function var_7_3(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_1 + 1
		local var_8_1 = arg_8_0:cellAtIndex(arg_8_1)

		if var_8_1 == nil then
			var_8_1 = CCTableViewCell:new()
		end

		var_8_1:removeAllChildrenWithCleanup(true)

		local var_8_2 = var_7_1[var_8_0]
		local var_8_3 = arg_7_0:createRankItem(var_8_2)

		var_8_3:setPosition(var_7_2.width / 2, var_7_2.height / 2)
		var_8_1:addChild(var_8_3)

		return var_8_1
	end

	local var_7_4 = CCTableView:create(arg_7_1)

	var_7_4:ignoreAnchorPointForPosition(false)
	var_7_4:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_7_4:setDirection(kCCScrollViewDirectionVertical)
	var_7_4:registerScriptHandler(function()
		return var_7_2.height, var_7_2.width
	end, CCTableView.kTableCellSizeForIndex)
	var_7_4:registerScriptHandler(function()
		return #var_7_1
	end, CCTableView.kNumberOfCellsInTableView)
	var_7_4:registerScriptHandler(var_7_3, CCTableView.kTableCellSizeAtIndex)
	var_7_4:setAnchorPoint(ccp(0, 0))
	var_7_0:addChild(var_7_4)

	function var_7_0.reloadData(arg_11_0, arg_11_1)
		var_7_1 = arg_11_1 or {}

		var_7_4:reloadData()
	end

	return var_7_0
end

function var_0_0.createRankItem(arg_12_0, arg_12_1)
	local var_12_0 = "ui/worldboss/worldboss_002.png"

	if arg_12_1.playerID == Player.userId then
		var_12_0 = "ui/worldboss/worldboss_003.png"
	end

	local var_12_1 = {
		"ui/worldboss/worldboss_004.png",
		"ui/worldboss/worldboss_007.png",
		"ui/worldboss/worldboss_006.png",
		"ui/worldboss/worldboss_005.png"
	}
	local var_12_2 = arg_12_0:getImageSize("ui/worldboss/worldboss_002.png")
	local var_12_3 = display.newSprite(var_12_0)
	local var_12_4 = display.newSprite(var_12_1[arg_12_1.rank] or "ui/guild/guild_050.png", 49, var_12_2.height / 2)

	var_12_3:addChild(var_12_4)

	local var_12_5 = arg_12_1.rank > 9999 and 22 or 28

	if arg_12_1.rank > 4 then
		addLabelWithColorSize(var_12_4, arg_12_1.rank, ccc3(240, 208, 0), var_12_5, ccp(0.5, 0.5), ccp(35, 37))
	end

	local var_12_6 = string.format("Lv%d  %s [%s]", arg_12_1.level, arg_12_1.name, arg_12_1.unionName or string.lf("无"))

	addLabelWithColorSize(var_12_4, var_12_6, ccc3(238, 238, 0), 22, ccp(0, 0.5), ccp(90, var_12_2.height - 30))
	addLabelWithColorSize(var_12_4, string.lf("伤害血量:#EEEE00 %d", arg_12_1.hp), ccc3(205, 133, 0), 22, ccp(0, 0.5), ccp(90, var_12_2.height - 58))

	if not arg_12_1.gold or arg_12_1.gold == 0 then
		var_12_6 = string.lf("奖励:#EEEE00 无")
	elseif arg_12_1.gold > 0 then
		var_12_6 = string.lf("奖励:#EEEE00 %s银币", arg_12_0:formatItemValue(arg_12_1.gold))
	else
		var_12_6 = string.lf("BOSS未被击杀，无奖励")
	end

	addLabelWithColorSize(var_12_4, var_12_6, ccc3(205, 133, 0), 22, ccp(0, 0.5), ccp(90, var_12_2.height - 86))

	if arg_12_1.playerID ~= Player.userId then
		local var_12_7 = ui.newControlButton({
			normalImage = "ui/guild/guild_051.png",
			titleImage = "uilocal/worldboss/worldboss_text_014.png",
			position = ccp(var_12_2.width - 40, var_12_2.height / 2),
			clickAction = function()
				arg_12_0.mParams.param4OtherTeam = arg_12_0.mParams.param4OtherTeam or {}
				arg_12_0.mParams.param4OtherTeam.enter = "rankList", OthersTeamHelper:checkOthersTeam(arg_12_1.playerID, arg_12_1.name, arg_12_0.mParams.from4OtherTeam, arg_12_0.mParams.param4OtherTeam)
			end
		})

		var_12_3:addChild(var_12_7)
	end

	return var_12_3
end

function var_0_0.getImageSize(arg_14_0, arg_14_1)
	return CCTextureCache:sharedTextureCache():addImage(arg_14_1):getContentSizeInPixels()
end

function var_0_0.formatItemValue(arg_15_0, arg_15_1)
	arg_15_1 = math.floor(arg_15_1)

	if arg_15_1 > 9999 then
		arg_15_1 = math.floor(arg_15_1 / 10000)

		return string.lf("%s万", arg_15_1)
	end

	return tostring(arg_15_1)
end

function var_0_0.requestRankLst(arg_16_0)
	if not arg_16_0.mRankLstRequest then
		arg_16_0.mRankLstRequest = WorldBossDPSRankRequest:new()

		local function var_16_0()
			arg_16_0.mParams.rankLst = arg_16_0.mRankLstRequest.restable
			arg_16_0.mParams.myRank = arg_16_0.mRankLstRequest.restable[#arg_16_0.mRankLstRequest.restable]

			table.remove(arg_16_0.mParams.rankLst, #arg_16_0.mRankLstRequest.restable)
			table.sort(arg_16_0.mParams.rankLst, function(arg_18_0, arg_18_1)
				return arg_18_0.rank < arg_18_1.rank
			end)

			if #arg_16_0.mParams.rankLst == 0 then
				showFlashNotice(string.lf("暂无排名"))
			end

			arg_16_0:createRankView()
			arg_16_0.mRankView:reloadData(arg_16_0.mParams.rankLst)
		end

		arg_16_0.mRankLstRequest:setResponseNormalHandler(var_16_0)
	end

	arg_16_0.mRankLstRequest:request()
end

return var_0_0
