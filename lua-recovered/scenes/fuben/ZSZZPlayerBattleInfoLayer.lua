require("scenes.battle.BattleOperator")
require("data.player")
require("base.figure")
require("scenes.team.OthersTeamHelper")

EnterType = {
	eFightType2 = 2,
	eStartBattleType = 5,
	eFightType3 = 3,
	eKillType = 4,
	eFightType1 = 1
}

local var_0_0 = class("ZSZZPlayerBattleInfoLayer", function()
	return display.newColorLayer(ccc4(0, 0, 0, 180))
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.mParams = arg_2_1

	arg_2_0:setUI()
	arg_2_0:requestBattleInfo(arg_2_1.playerId)
end

function var_0_0.setUI(arg_4_0)
	local var_4_0 = CCTextureCache:sharedTextureCache():addImage("ui/fuben/zszz_023.png"):getContentSizeInPixels()
	local var_4_1 = display.newSprite("ui/fuben/zszz_023.png", display.cx, display.cy)

	var_4_1:setScale(Adapter.MinScale)
	arg_4_0:addChild(var_4_1)

	local var_4_2 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		position = ccp(var_4_0.width - 20, var_4_0.height - 20),
		clickAction = function()
			arg_4_0:removeFromParentAndCleanup(true)
		end
	})

	var_4_1:addChild(var_4_2)

	arg_4_0.mTableView = arg_4_0:createTableView(CCSize(var_4_0.width - 4, var_4_0.height - 4))

	arg_4_0.mTableView:setPosition(2, 2)
	var_4_1:addChild(arg_4_0.mTableView)
end

function var_0_0.createTableView(arg_6_0, arg_6_1)
	local var_6_0 = {}
	local var_6_1 = CCSize(arg_6_1.width, arg_6_1.height / 3)

	local function var_6_2()
		return var_6_1.height, var_6_1.width
	end

	local function var_6_3()
		return #var_6_0
	end

	local function var_6_4(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_1 + 1
		local var_9_1 = arg_9_0:cellAtIndex(arg_9_1)

		if var_9_1 == nil then
			var_9_1 = CCTableViewCell:new()
		end

		var_9_1:removeAllChildrenWithCleanup(true)

		local var_9_2 = var_6_0[var_9_0]

		if var_9_2.attackPlayer.PlayerId ~= "" and var_9_2.defendPlayer.PlayerId ~= "" then
			local var_9_3 = display.newSprite("uilocal/fuben/zszz_text_005.png", var_6_1.width / 2 - 20, var_6_1.height / 2)

			var_9_1:addChild(var_9_3)

			local var_9_4 = ui.newControlButton({
				titleImage = "uilocal/fuben/zszz_text_015.png",
				normalImage = "ui/common/common_115.png",
				scaleX = 0.95,
				scaleY = 0.95,
				position = ccp(var_6_1.width / 2 - 20, 30),
				clickAction = function()
					arg_6_0:onBtnViewClicked(arg_6_0.mParams, var_9_2)
				end
			})

			var_9_1:addChild(var_9_4)
		elseif var_9_2.attackPlayer.PlayerId == "" then
			local var_9_5 = display.newSprite("uilocal/fuben/zszz_text_034.png", var_6_1.width / 2 - 170, var_6_1.height / 2)

			var_9_1:addChild(var_9_5)
		elseif var_9_2.defendPlayer.PlayerId == "" then
			local var_9_6 = display.newSprite("uilocal/fuben/zszz_text_034.png", var_6_1.width / 2 + 160, var_6_1.height / 2)

			var_9_1:addChild(var_9_6)
		end

		if var_9_2.attackPlayer.PlayerId ~= "" then
			local var_9_7 = arg_6_0:createHeader(var_9_2.attackPlayer, var_9_2.IsWin == 1)

			var_9_7:setPosition(80, var_6_1.height / 2)
			var_9_1:addChild(var_9_7)
		end

		if var_9_2.defendPlayer.PlayerId ~= "" then
			local var_9_8 = arg_6_0:createHeader(var_9_2.defendPlayer, var_9_2.IsWin ~= 1)

			var_9_8:setPosition(var_6_1.width / 2 + 100, var_6_1.height / 2)
			var_9_1:addChild(var_9_8)
		end

		return var_9_1
	end

	local var_6_5 = CCTableView:create(arg_6_1)

	var_6_5:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_6_5:setDirection(kCCScrollViewDirectionVertical)
	var_6_5:registerScriptHandler(var_6_2, CCTableView.kTableCellSizeForIndex)
	var_6_5:registerScriptHandler(var_6_3, CCTableView.kNumberOfCellsInTableView)
	var_6_5:registerScriptHandler(var_6_4, CCTableView.kTableCellSizeAtIndex)

	local var_6_6 = var_6_5.reloadData

	function var_6_5.reloadData(arg_11_0, arg_11_1)
		var_6_0 = arg_11_1

		var_6_6(arg_11_0)
	end

	return var_6_5
end

function var_0_0.createHeader(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = CCSize(87, 87)
	local var_12_1 = CCScale9Sprite:create("ui/common/common_001.png")

	var_12_1:setPreferredSize(var_12_0)

	local var_12_2 = ui.newControlButton({
		normalImage = getItemHeaderImagePath(ItemType.eHero, arg_12_1.HeadId),
		clickAction = function()
			OthersTeamHelper:checkOthersTeam(arg_12_1.PlayerId, arg_12_1.PlayerName, OthersTeamHelper.eDataFromZSZZ, nil, arg_12_1.ServerId)
		end
	})

	var_12_2:setPosition(var_12_0.width / 2, var_12_0.height / 2)
	var_12_1:addChild(var_12_2)

	local var_12_3

	if arg_12_2 == true then
		var_12_3 = display.newSprite("uilocal/fuben/zszz_text_006.png", 0, 87)
	else
		var_12_3 = display.newSprite("uilocal/fuben/zszz_text_007.png", 0, 87)
	end

	var_12_1:addChild(var_12_3)
	addLabelWithColorSize(var_12_1, string.format("[%s]%s", arg_12_1.ServerName, arg_12_1.PlayerName), ccc3(238, 179, 34), 18, ccp(0, 0.5), ccp(90, 70))
	addLabelWithColorSize(var_12_1, string.lf("战斗力:#F4F4F4%s（%s%%）", arg_12_1.Power, arg_12_1.Addition), ccc3(255, 227, 0), 18, ccp(0, 0.5), ccp(90, 43))

	if arg_12_1.KillCount then
		addLabelWithColorSize(var_12_1, string.lf("击杀数:#F4F4F4%d", arg_12_1.KillCount), ccc3(255, 227, 0), 18, ccp(0, 0.5), ccp(90, 17))
	end

	return var_12_1
end

function var_0_0.onBtnViewClicked(arg_14_0, arg_14_1, arg_14_2)
	local function var_14_0(arg_15_0, arg_15_1)
		if arg_14_1.pageType == EnterType.eFightType1 or arg_14_1.pageType == EnterType.eFightType2 or arg_14_1.pageType == EnterType.eFightType3 then
			game.enterZSZZFightScene({
				pageType = arg_14_1.pageType,
				pageTypein = arg_14_1.pageType
			})
		elseif arg_14_1.pageType == EnterType.eStartBattleType then
			game.enterZSZZFightScene({
				pageTypein = arg_14_1.pageType
			})
		elseif arg_14_1.pageType == EnterType.eKillType then
			game.enterZSZZHomeScene({
				worldType = arg_14_1.type,
				pageTypereturn = arg_14_1.pageType
			})
		end
	end

	BattleOperator:startBattle(eBattleType.ZSZZBattleRecord, {
		recordID = arg_14_2.ID
	}, var_14_0)
end

function var_0_0.requestBattleInfo(arg_16_0, arg_16_1)
	local function var_16_0()
		arg_16_0:onResponseBattleInfo(arg_16_0.mLastRequestPlayerID or Player.userId, arg_16_0.mPlayerBattleInfoRequest.restable)
	end

	if not arg_16_0.mPlayerBattleInfoRequest then
		if not arg_16_1 then
			arg_16_0.mPlayerBattleInfoRequest = ZSZZMyBattleReportRequest:new()
		else
			arg_16_0.mPlayerBattleInfoRequest = ZSZZBattleReportRequest:new()
		end

		arg_16_0.mPlayerBattleInfoRequest:setResponseNormalHandler(var_16_0)
	end

	arg_16_0.mLastRequestPlayerID = arg_16_1

	arg_16_0.mPlayerBattleInfoRequest:request(arg_16_1)
end

function var_0_0.onResponseBattleInfo(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = 0
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_2) do
		if arg_18_1 == iter_18_1.AttackPlayerId and iter_18_1.IsWin == 1 then
			var_18_0 = var_18_0 + 1
		elseif arg_18_1 == iter_18_1.DefendPlayerId and iter_18_1.IsWin == 0 then
			var_18_0 = var_18_0 + 1
		end
	end

	for iter_18_2, iter_18_3 in ipairs(arg_18_2) do
		local var_18_2 = {
			attackPlayer = {
				HeadId = iter_18_3.AttackHeadId,
				ServerName = iter_18_3.AttackServerName,
				PlayerName = iter_18_3.AttackPlayerName,
				Power = iter_18_3.AttackOriginalPower,
				Addition = iter_18_3.AttackEncouragingAddition,
				ServerId = iter_18_3.AttackServerId,
				PlayerId = iter_18_3.AttackPlayerId
			},
			defendPlayer = {
				HeadId = iter_18_3.DefendHeadId,
				ServerName = iter_18_3.DefendServerName,
				PlayerName = iter_18_3.DefendPlayerName,
				Power = iter_18_3.DefendOriginalPower,
				Addition = iter_18_3.DefendEncouragingAddition,
				ServerId = iter_18_3.DefendServerId,
				PlayerId = iter_18_3.DefendPlayerId
			},
			IsWin = iter_18_3.IsWin,
			ID = iter_18_3.Id
		}

		if arg_18_1 == iter_18_3.AttackPlayerId then
			var_18_2.attackPlayer.KillCount = var_18_0
		elseif arg_18_1 == iter_18_3.DefendPlayerId then
			var_18_2.defendPlayer.KillCount = var_18_0
		end

		if arg_18_1 == iter_18_3.AttackPlayerId and iter_18_3.IsWin == 1 then
			var_18_0 = var_18_0 - 1
		elseif arg_18_1 == iter_18_3.DefendPlayerId and iter_18_3.IsWin == 0 then
			var_18_0 = var_18_0 - 1
		end

		table.insert(var_18_1, var_18_2)
	end

	arg_18_0.mTableView:reloadData(var_18_1)
end

return var_0_0
