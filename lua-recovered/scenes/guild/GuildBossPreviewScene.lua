require("base.figure")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = require("base.cache")
local var_0_2 = class("GuildBossPreviewScene", function()
	return display.newScene("GuildBossPreviewScene")
end)

function var_0_2.ctor(arg_2_0, arg_2_1)
	if arg_2_1.isKing then
		arg_2_0.isKing = true
		arg_2_0.killKey = 0
		arg_2_0.bossInfo = arg_2_1.demonKing or arg_2_1.bossInfo
		arg_2_0.bossInfo.remainChallengeTime = arg_2_1.remainChallengeTime
		arg_2_0.winDemonIDs = arg_2_0.bossInfo.winDemonIDs or arg_2_1.bossInfo.winDemonIDs
		arg_2_0.demonIDs = arg_2_0.bossInfo.demonIDs or arg_2_1.bossInfo.demonIDs
	else
		arg_2_0.isKing = false
		arg_2_0.bossInfo = arg_2_1.bossInfo
	end

	if arg_2_1.resurgenceResult then
		if arg_2_1.resurgenceResult.DemonChallenge.demonState == 0 then
			arg_2_0.bossInfo.challengeStatus = DemonChallengeStatus.ePassed
		else
			arg_2_0.bossInfo.challengeStatus = DemonChallengeStatus.eOpenChallenging
		end
	end

	if arg_2_1.giveupResult then
		arg_2_0:updateBossData(arg_2_1.giveupResult)

		arg_2_0.bossInfo.challengeStatus = DemonChallengeStatus.eOpen
	end

	local var_2_0 = require("scenes.CommonBgLayer").new({
		closeButtonNormalImage = "ui/common/common_061.png",
		closeButtonPosition = ccp(9000000, 40)
	})

	arg_2_0:addChild(var_2_0)

	arg_2_0.bgSprite = var_2_0:getBackgroundSprite()
	arg_2_0.bossInfoBgSprite = display.newSprite("ui/guild/guild_042.png", 286, 386)

	arg_2_0.bgSprite:addChild(arg_2_0.bossInfoBgSprite)

	arg_2_0.rankInfoBgSprite = display.newSprite("ui/guild/guild_038.png", 761, 386)

	arg_2_0.bgSprite:addChild(arg_2_0.rankInfoBgSprite)

	arg_2_0.dropListInfoBgSprite = display.newSprite("ui/guild/guild_037.png", 480, 103)

	arg_2_0.bgSprite:addChild(arg_2_0.dropListInfoBgSprite)

	if arg_2_0.isKing then
		arg_2_0:createKingNetworkRequest()
	else
		arg_2_0:createNetworkRequest()
	end

	arg_2_0:createTouchEventLayer()
	arg_2_0:showBossInfo()

	if arg_2_0.isKing then
		arg_2_0:showKeyInfo()
	else
		arg_2_0:showRankInfo()
	end

	arg_2_0:showDropListInfo()

	local var_2_1 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		position = ccp(619, 30),
		clickAction = function()
			game.enterGuildMapScene()
		end
	})
	local var_2_2 = display.newSprite("uilocal/guild/guild_text_019.png", 71, 25)

	var_2_1:addChild(var_2_2)
	arg_2_0.bgSprite:addChild(var_2_1)

	local var_2_3 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		position = ccp(340, 30),
		clickAction = function()
			if arg_2_0.bossInfo.challengeStatus == DemonChallengeStatus.eOpenChallenging then
				local var_4_0 = require("scenes.guild.GuildResurgenceLayer").new({
					bossInfo = arg_2_0.bossInfo,
					isKing = arg_2_0.isKing
				})

				arg_2_0:addChild(var_4_0)
			elseif arg_2_0.bossInfo.challengeStatus == DemonChallengeStatus.eNotOpen then
				showFlashNotice(string.lf("上仙，该Boss未开放！"))
			elseif arg_2_0.bossInfo.challengeStatus == DemonChallengeStatus.ePassed then
				ui.showMessageBox({
					text = string.lf("上仙，该Boss已被击杀，掉落宝物已放入魔族商店中，是否前往竞拍?"),
					title1 = string.lf("取消"),
					parent = arg_2_0,
					title2 = string.lf("确定"),
					action2 = function()
						game.enterGuildStoreScene({
							tabPageTag = 3
						})
					end
				})
			elseif arg_2_0.bossInfo.challengeStatus == DemonChallengeStatus.eNeedKillLastOne then
				showFlashNotice(string.lf("上仙，需挑战上一Boss！"))
			elseif arg_2_0.bossInfo.challengeStatus == DemonChallengeStatus.eOpen then
				arg_2_0:startBattle()
			end
		end
	})
	local var_2_4 = "uilocal/guild/guild_text_017.png"

	if arg_2_0.bossInfo.challengeStatus == DemonChallengeStatus.eOpenChallenging then
		var_2_4 = "uilocal/guild/guild_text_018.png"
	end

	local var_2_5 = string.split(arg_2_0.winDemonIDs, ",")

	if arg_2_0.isKing and #var_2_5 ~= 5 or arg_2_0.bossInfo.challengeStatus == 0 then
		var_2_4 = "uilocal/guild/guild_text_015.png"

		var_2_3:setEnabled(false)
	end

	local var_2_6 = display.newSprite(var_2_4, 71, 25)

	var_2_3:addChild(var_2_6)
	arg_2_0.bgSprite:addChild(var_2_3)

	if arg_2_1.giveupResult == nil then
		arg_2_0.bossInfoRequest:requestDemonInfo(arg_2_0.bossInfo.demonID)
	else
		arg_2_0.bossInfoBgSprite.reload()
		arg_2_0.dropListInfoBgSprite.reload()

		if arg_2_0.isKing then
			-- block empty
		else
			arg_2_0.rankInfoBgSprite.reload()
		end
	end
end

function var_0_2.onEnter(arg_6_0)
	if arg_6_0.bossInfo.challengeStatus == DemonChallengeStatus.ePassed then
		arg_6_0:passEffect()
	end
end

function var_0_2.startBattle(arg_7_0)
	if arg_7_0.bossInfo.remainChallengeTime == 0 then
		showFlashNotice(string.lf("上仙，您的挑战次数已用完了哦！"))

		return
	end

	local var_7_0 = arg_7_0.bossInfo

	local function var_7_1(arg_8_0, arg_8_1, arg_8_2)
		game.enterGuildBossPreviewScene({
			bossInfo = var_7_0,
			resurgenceResult = arg_8_1,
			isKing = arg_7_0.isKing
		})
	end

	if arg_7_0.isKing then
		require("scenes.battle.BattleOperator"):startBattle(eBattleType.guildKing, {
			battleType = 1,
			demonID = arg_7_0.bossInfo.demonID,
			bossInfo = arg_7_0.bossInfo,
			isKing = arg_7_0.isKing
		}, var_7_1)
	else
		require("scenes.battle.BattleOperator"):startBattle(eBattleType.guildBOSS, {
			battleType = 1,
			demonID = arg_7_0.bossInfo.demonID,
			bossInfo = arg_7_0.bossInfo,
			isKing = arg_7_0.isKing
		}, var_7_1)
	end
end

function var_0_2.onExit(arg_9_0)
	if arg_9_0.scheduleHandle then
		require("framework.scheduler").unscheduleGlobal(arg_9_0.scheduleHandle)

		arg_9_0.scheduleHandle = nil
	end
end

function var_0_2.createNumberWidthBgSprite(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = display.newSprite("ui/guild/guild_041.png", arg_10_1.x, arg_10_1.y)

	arg_10_0.bossInfoBgSprite:addChild(var_10_0)

	return (addLabelWithColorSize(var_10_0, arg_10_2, ccc3(250, 255, 0), 16, ccp(0, 0.5), ccp(2, 9)))
end

local function var_0_3(arg_11_0)
	local var_11_0, var_11_1, var_11_2, var_11_3 = getDateFromSeconds(arg_11_0)

	if var_11_0 > 0 then
		return string.lf("%d天后", var_11_0)
	elseif var_11_1 > 0 then
		return string.lf("%d小时后", var_11_1)
	elseif var_11_2 > 0 then
		return string.lf("%d分钟后", var_11_2)
	elseif var_11_3 > 0 then
		return string.lf("%d秒后", var_11_3)
	else
		return string.lf("%d秒后", 1)
	end
end

function var_0_2.showBossInfo(arg_12_0)
	local var_12_0 = BaseGuildNodes[arg_12_0.bossInfo.demonID]
	local var_12_1 = figure.createHero({
		platTable = false,
		isViewQuality = false,
		enemyId = var_12_0.bossID,
		equipId = BaseNPCs[var_12_0.bossID].equipId
	})

	if arg_12_0.isKing then
		var_12_1:setPosition(ccp(175, 70))
		var_12_1:setScale(0.6)
		arg_12_0.bossInfoBgSprite:addChild(var_12_1)
	else
		var_12_1:setPosition(ccp(160, 90))
		var_12_1:setScale(0.7)
		arg_12_0.bossInfoBgSprite:addChild(var_12_1)
	end

	local var_12_2 = require("scenes.ProgressBar").new({
		backImage = "ui/guild/guild_033.png",
		percent = 0,
		barImages = {
			"ui/guild/guild_032.png"
		},
		backSize = CCSize(182, 43),
		barSize = CCSize(124, 14),
		barPosition = ccp(-46, 1)
	})

	var_12_2:setPosition(ccp(144, 32))
	arg_12_0.bossInfoBgSprite:addChild(var_12_2)

	arg_12_0.progressBar = var_12_2

	local var_12_3 = addLabelWithColorSize(var_12_2, "0%", ccc3(227, 229, 100), 15, CCPoint(0.5, 0.5), ccp(-62, 0))

	arg_12_0.percentLabel = var_12_3

	local var_12_4 = addLabelWithColorSize(arg_12_0.bossInfoBgSprite, "", ccc3(227, 229, 0), 20, CCPoint(0, 0.5), ccp(295, 330))

	addLabelWithColorSize(arg_12_0.bossInfoBgSprite, string.lf("总血量:"), ccc3(227, 229, 0), 17, CCPoint(0, 0.5), ccp(295, 304))

	local var_12_5 = arg_12_0:createNumberWidthBgSprite(ccp(440, 304), 0)

	addLabelWithColorSize(arg_12_0.bossInfoBgSprite, string.lf("晶石:"), ccc3(227, 229, 0), 17, CCPoint(0, 0.5), ccp(295, 280))

	local var_12_6 = arg_12_0:createNumberWidthBgSprite(ccp(440, 280), 0)

	addLabelWithColorSize(arg_12_0.bossInfoBgSprite, string.lf("仙盟贡献:"), ccc3(227, 229, 0), 17, CCPoint(0, 0.5), ccp(295, 256))

	local var_12_7 = arg_12_0:createNumberWidthBgSprite(ccp(440, 256), 0)

	addLabelWithColorSize(arg_12_0.bossInfoBgSprite, string.lf("银币:"), ccc3(227, 229, 0), 17, CCPoint(0, 0.5), ccp(295, 232))

	local var_12_8 = arg_12_0:createNumberWidthBgSprite(ccp(440, 232), 0)

	addLabelWithColorSize(arg_12_0.bossInfoBgSprite, string.lf("重置时间:"), ccc3(227, 229, 0), 17, CCPoint(0, 0.5), ccp(295, 208))

	local var_12_9 = 0
	local var_12_10 = arg_12_0:createNumberWidthBgSprite(ccp(440, 208), 0)

	if arg_12_0.isKing then
		var_12_10:setString("打死重置")
	end

	addLabelWithColorSize(arg_12_0.bossInfoBgSprite, var_12_0.skillName .. ":", ccc3(227, 229, 0), 17, CCPoint(0, 0.5), ccp(295, 180))

	local var_12_11 = addLabelWithColorSize(arg_12_0.bossInfoBgSprite, var_12_0.skillDesc, ccc3(54, 166, 222), 17, CCPoint(0, 1), ccp(295, 170))

	var_12_11:setHorizontalAlignment(ui.TEXT_ALIGN_LEFT)
	var_12_11:setDimensions(CCSize(250, 100))
	addLabelWithColorSize(arg_12_0.bossInfoBgSprite, string.lf("建议配置:"), ccc3(227, 229, 0), 17, CCPoint(0, 0.5), ccp(295, 75))

	local var_12_12 = addLabelWithColorSize(arg_12_0.bossInfoBgSprite, var_12_0.recommand, ccc3(31, 133, 38), 17, CCPoint(0, 1), ccp(295, 65))

	var_12_12:setHorizontalAlignment(ui.TEXT_ALIGN_LEFT)
	var_12_12:setDimensions(CCSize(250, 50))

	function arg_12_0.bossInfoBgSprite.reload()
		if arg_12_0.bossInfo.challengeStatus == DemonChallengeStatus.ePassed then
			arg_12_0.bossInfo.leftHPRate = 0
		end

		var_12_2:setProgressValue(1, arg_12_0.bossInfo.leftHPRate, 100)

		local var_13_0 = string.format("%.1f%%", arg_12_0.bossInfo.leftHPRate)

		var_12_3:setString(var_13_0)
		var_12_4:setString(arg_12_0.bossInfo.demonName)
		var_12_5:setString(arg_12_0.bossInfo.totalHP)
		var_12_6:setString(arg_12_0.bossInfo.playerCoin)
		var_12_7:setString(arg_12_0.bossInfo.unionCoin)
		var_12_8:setString(arg_12_0.bossInfo.gold)

		local function var_13_1()
			local var_14_0 = var_12_9
			local var_14_1 = var_0_3(var_14_0)

			var_12_10:setString(var_14_1)

			if var_14_0 <= 0 then
				if arg_12_0.scheduleHandle then
					require("framework.scheduler").unscheduleGlobal(arg_12_0.scheduleHandle)

					arg_12_0.scheduleHandle = nil
				end

				arg_12_0.bossInfoRequest:requestDemonInfo(1)
			end

			var_12_9 = var_12_9 - 1
		end

		if arg_12_0.isKing then
			-- block empty
		else
			var_12_9 = arg_12_0.bossInfo.resetTime

			var_13_1()

			arg_12_0.scheduleHandle = require("framework.scheduler").scheduleGlobal(var_13_1, 1)
		end
	end
end

function var_0_2.createRankItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = display.newColorLayer(ccc4(120, 0, 0, 0))

	var_15_0:setAnchorPoint(ccp(0, 0))
	var_15_0:setPosition(0, 0)

	local var_15_1 = arg_15_1 - arg_15_2 + 1

	addLabelWithColorSize(var_15_0, var_15_1, ccc3(227, 229, 0), 16, CCPoint(0.5, 0.5), ccp(30, 7))
	addLabelWithColorSize(var_15_0, arg_15_3.name, ccc3(227, 229, 0), 16, CCPoint(0.5, 0.5), ccp(145, 7))
	addLabelWithColorSize(var_15_0, arg_15_3.damage, ccc3(227, 229, 0), 16, CCPoint(0.5, 0.5), ccp(290, 7))

	return var_15_0
end

function var_0_2.showRankInfo(arg_16_0)
	addLabelWithColorSize(arg_16_0.rankInfoBgSprite, string.lf("排名"), ccc3(227, 229, 0), 16, CCPoint(0.5, 0.5), ccp(46, 345))
	addLabelWithColorSize(arg_16_0.rankInfoBgSprite, string.lf("玩家"), ccc3(227, 229, 0), 16, CCPoint(0.5, 0.5), ccp(161, 345))
	addLabelWithColorSize(arg_16_0.rankInfoBgSprite, string.lf("伤害"), ccc3(227, 229, 0), 16, CCPoint(0.5, 0.5), ccp(306, 345))

	local var_16_0 = display.newColorLayer(ccc4(77, 21, 10, 255))

	var_16_0:setPosition(16, 15)
	var_16_0:setContentSize(CCSize(360, 24))
	arg_16_0.rankInfoBgSprite:addChild(var_16_0)

	local var_16_1 = addLabelWithColorSize(var_16_0, "", ccc3(227, 229, 0), 16, CCPoint(0.5, 0.5), ccp(30, 12))
	local var_16_2 = addLabelWithColorSize(var_16_0, "", ccc3(227, 229, 0), 16, CCPoint(0.5, 0.5), ccp(145, 12))
	local var_16_3 = addLabelWithColorSize(var_16_0, "", ccc3(227, 229, 0), 16, CCPoint(0.5, 0.5), ccp(290, 12))
	local var_16_4 = {
		reverse = true,
		direction = kCCScrollViewDirectionVertical,
		size = CCSize(360, 290),
		sizehandler = function(arg_17_0, arg_17_1)
			return CCSize(360, 24)
		end,
		cellhandler = handler(arg_16_0, arg_16_0.createRankItem)
	}
	local var_16_5 = createTableView(var_16_4)

	var_16_5:setPosition(16, 41)
	arg_16_0.rankInfoBgSprite:addChild(var_16_5)

	function arg_16_0.rankInfoBgSprite.reload()
		var_16_5:reloadData(arg_16_0.bossInfo.damageRanks)

		local var_18_0 = 0
		local var_18_1 = 0

		if arg_16_0.bossInfo.damageRanks then
			var_18_0 = #arg_16_0.bossInfo.damageRanks

			for iter_18_0, iter_18_1 in ipairs(arg_16_0.bossInfo.damageRanks) do
				if iter_18_1.name == Player.nickName then
					var_18_0 = iter_18_0
					var_18_1 = iter_18_1.damage

					break
				end
			end
		end

		var_16_1:setString(var_18_0)
		var_16_2:setString(Player.nickName)
		var_16_3:setString(var_18_1)
	end
end

function var_0_2.createDropItem(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = {
		type = arg_19_3.Type,
		itemId = arg_19_3.ID or 0,
		level = arg_19_3.Level,
		nameColor = ccc3(239, 232, 195),
		count = arg_19_3.Count,
		clickAction = function()
			var_0_0.tipshandler(arg_19_3)
		end
	}
	local var_19_1 = figure.createHeader(var_19_0)

	var_19_1:setScale(0.8)
	var_19_1:setPosition(50, 50)

	return var_19_1
end

function var_0_2.showDropListInfo(arg_21_0)
	local var_21_0 = addLabelWithColorSize(arg_21_0.dropListInfoBgSprite, string.lf("挑战获得晶石: 0"), ccc3(227, 229, 0), 16, CCPoint(0, 0.5), ccp(30, 165))
	local var_21_1 = addLabelWithColorSize(arg_21_0.dropListInfoBgSprite, string.lf("挑战获得银币: 0"), ccc3(227, 229, 0), 16, CCPoint(0, 0.5), ccp(250, 165))
	local var_21_2 = addLabelWithColorSize(arg_21_0.dropListInfoBgSprite, string.lf("造成伤害百分比: 0.00%%"), ccc3(227, 229, 0), 16, CCPoint(0, 0.5), ccp(496, 165))

	addLabelWithColorSize(arg_21_0.dropListInfoBgSprite, string.lf("击杀后可获得仙盟晶石:"), ccc3(54, 166, 222), 16, CCPoint(0, 0.5), ccp(30, 137))

	local var_21_3 = createItemCountNode({
		value = 0,
		type = ItemType.eGuildCoin,
		color = ccc3(0, 255, 0)
	})

	var_21_3:setPosition(ccp(220, 138))
	arg_21_0.dropListInfoBgSprite:addChild(var_21_3)
	addLabelWithColorSize(arg_21_0.dropListInfoBgSprite, string.lf("击杀掉落列表:"), ccc3(54, 166, 222), 16, CCPoint(0, 0.5), ccp(330, 137))

	local var_21_4 = {
		reverse = false,
		direction = kCCScrollViewDirectionHorizontal,
		size = CCSize(930, 90),
		sizehandler = function(arg_22_0, arg_22_1)
			return CCSize(96, 90)
		end,
		cellhandler = handler(arg_21_0, arg_21_0.createDropItem)
	}
	local var_21_5 = createTableView(var_21_4)

	var_21_5:setPosition(6, 40)
	arg_21_0.dropListInfoBgSprite:addChild(var_21_5)

	function arg_21_0.dropListInfoBgSprite.reload()
		var_21_5:reloadData(arg_21_0.bossInfo.dropGoods)
		var_21_0:setString(string.lf("挑战获得晶石: %s", arg_21_0.bossInfo.challengePlayerCoin))
		var_21_1:setString(string.lf("挑战获得银币: %s", arg_21_0.bossInfo.challengeGold))
		var_21_3:setValue(arg_21_0.bossInfo.playerUnionCoin)

		local var_23_0 = string.lf("造成伤害百分比: %.2f%%", arg_21_0.bossInfo.damageRate)

		var_21_2:setString(var_23_0)
	end
end

function var_0_2.createTouchEventLayer(arg_24_0)
	local function var_24_0(arg_25_0, arg_25_1, arg_25_2)
		if arg_25_0 == "began" then
			return true
		elseif arg_25_0 == "moved" then
			-- block empty
		elseif arg_25_0 ~= "ended" and arg_25_0 == "cancelled" then
			-- block empty
		end
	end

	arg_24_0:addTouchEventListener(var_24_0, false, 1, true)
	arg_24_0:setTouchEnabled(true)
end

function var_0_2.updateBossData(arg_26_0, arg_26_1)
	arg_26_0.bossInfo.challengeGold = arg_26_1.challengeGold
	arg_26_0.bossInfo.challengePlayerCoin = arg_26_1.challengePlayerCoin
	arg_26_0.bossInfo.damageRate = arg_26_1.damageRate
	arg_26_0.bossInfo.demonID = arg_26_1.demonID
	arg_26_0.bossInfo.demonName = arg_26_1.demonName
	arg_26_0.bossInfo.gold = arg_26_1.gold
	arg_26_0.bossInfo.playerCoin = arg_26_1.playerCoin
	arg_26_0.bossInfo.playerUnionCoin = arg_26_1.playerUnionCoin
	arg_26_0.bossInfo.leftHPRate = arg_26_1.leftHPRate
	arg_26_0.bossInfo.resetTime = arg_26_1.resetTime
	arg_26_0.bossInfo.totalHP = arg_26_1.totalHP
	arg_26_0.bossInfo.unionCoin = arg_26_1.unionCoin
	arg_26_0.bossInfo.remainResurgenceTime = arg_26_1.remainResurgenceTime
	arg_26_0.bossInfo.resurgenceGold = arg_26_1.resurgenceGold
	arg_26_0.bossInfo.resurgenceIngot = arg_26_1.resurgenceIngot
	arg_26_0.bossInfo.remainChallengeTime = arg_26_1.remainChallengeTime

	if arg_26_1.damageRanks then
		arg_26_0.bossInfo.damageRanks = arg_26_1.damageRanks
	end

	if arg_26_1.dropGoods then
		arg_26_0.bossInfo.dropGoods = arg_26_1.dropGoods
	end
end

function var_0_2.createNetworkRequest(arg_27_0)
	local function var_27_0()
		local var_28_0 = arg_27_0.bossInfoRequest:getDemonInfo()

		arg_27_0:updateBossData(var_28_0)
		arg_27_0.bossInfoBgSprite.reload()
		arg_27_0.dropListInfoBgSprite.reload()
		arg_27_0.rankInfoBgSprite.reload()
	end

	local function var_27_1(arg_29_0)
		return
	end

	arg_27_0.bossInfoRequest = UnionDemonInfoRequest:new()

	arg_27_0.bossInfoRequest:setResponseNormalHandler(var_27_0)
	arg_27_0.bossInfoRequest:setResponseExceptionHandler(var_27_1)
end

function var_0_2.createKingNetworkRequest(arg_30_0)
	local function var_30_0()
		local var_31_0 = arg_30_0.bossInfoRequest:getDemonInfo()

		arg_30_0:updateBossData(var_31_0)
		arg_30_0.bossInfoBgSprite.reload()
		arg_30_0.dropListInfoBgSprite.reload()
	end

	local function var_30_1(arg_32_0)
		return
	end

	arg_30_0.bossInfoRequest = UnionDemonKingInfoRequest:new()

	arg_30_0.bossInfoRequest:setResponseNormalHandler(var_30_0)
	arg_30_0.bossInfoRequest:setResponseExceptionHandler(var_30_1)
end

function var_0_2.shake(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = math.random(1, 2)
	local var_33_1 = -var_33_0
	local var_33_2, var_33_3 = arg_33_1:getPosition()
	local var_33_4 = CCArray:create()

	var_33_4:addObject(CCMoveBy:create(0.03, ccp(var_33_0, var_33_0)))
	var_33_4:addObject(CCMoveBy:create(0.03, ccp(var_33_1, var_33_1)))
	var_33_4:addObject(CCMoveBy:create(0.03, ccp(var_33_0, var_33_1)))
	var_33_4:addObject(CCMoveBy:create(0.03, ccp(var_33_1, var_33_0)))

	if arg_33_2 then
		var_33_4:addObject(CCCallFunc:create(arg_33_2))
	end

	arg_33_1:stopAllActions()
	arg_33_1:runAction(CCSequence:create(var_33_4))
end

function var_0_2.passEffect(arg_34_0)
	local var_34_0 = display.newSprite("ui/guild/guild_040.png", 480, 320)

	var_34_0:setScale(3)
	var_34_0:setOpacity(0)
	arg_34_0.bgSprite:addChild(var_34_0)

	local var_34_1 = CCArray:create()
	local var_34_2 = CCScaleTo:create(0.5, 1)
	local var_34_3 = CCMoveTo:create(0.5, ccp(60, 500))
	local var_34_4 = CCFadeTo:create(0.5, 255)

	var_34_1:addObject(var_34_2)
	var_34_1:addObject(var_34_3)
	var_34_1:addObject(var_34_4)

	local var_34_5 = CCSpawn:create(var_34_1)
	local var_34_6 = CCCallFunc:create(function()
		arg_34_0:shake(arg_34_0.bgSprite)
	end)
	local var_34_7 = CCArray:create()

	var_34_7:addObject(var_34_5)
	var_34_7:addObject(var_34_6)
	var_34_0:runAction(CCSequence:create(var_34_7))
end

function var_0_2.showKeyInfo(arg_36_0)
	local var_36_0 = addLabelWithColorSize(arg_36_0.rankInfoBgSprite, "仙盟王,传说中强大的仙盟BOSS,仙盟王没有重置时间,挑战指定BOSS后,即可以挑战仙盟王", ccc3(54, 166, 222), 18, CCPoint(0, 1), ccp(20, 355))

	var_36_0:setHorizontalAlignment(ui.TEXT_ALIGN_LEFT)
	var_36_0:setDimensions(CCSize(arg_36_0.rankInfoBgSprite:getContentSize().width - 40, 100))
	addLabelWithColorSize(arg_36_0.rankInfoBgSprite, "本次激活需要击败以下王:", ccc3(54, 166, 222), 18, CCPoint(0, 1), ccp(20, 275))

	for iter_36_0, iter_36_1 in pairs(BaseGuildNodes) do
		local var_36_1 = string.split(arg_36_0.demonIDs, ",")

		for iter_36_2, iter_36_3 in pairs(var_36_1) do
			if tostring(iter_36_0) == tostring(iter_36_3) then
				local var_36_2 = ui.newControlButton({
					normalImage = "ui/common/common_003.png",
					clickAction = function(arg_37_0, arg_37_1)
						return
					end
				})

				if iter_36_2 == 1 then
					var_36_2:setPosition(110, 200)
				elseif iter_36_2 == 2 then
					var_36_2:setPosition(290, 200)
				elseif iter_36_2 == 3 then
					var_36_2:setPosition(110, 80)
				elseif iter_36_2 == 4 then
					var_36_2:setPosition(290, 80)
				end

				arg_36_0.rankInfoBgSprite:addChild(var_36_2)

				local var_36_3 = display.newSprite("header/" .. iter_36_1.headerImage, 43, 43)

				var_36_2:addChild(var_36_3)

				local var_36_4 = display.newSprite("ui/guild/guild_031.png", 43, -13)

				var_36_2:addChild(var_36_4)
				addLabelWithColorSize(var_36_2, iter_36_1.name, ColorTable.eTitleTabButton_Normal, 20, CCPoint(0.5, 0.5), ccp(43, -12))

				local var_36_5 = string.split(arg_36_0.winDemonIDs, ",")

				for iter_36_4, iter_36_5 in pairs(var_36_5) do
					if iter_36_5 == iter_36_3 then
						local var_36_6 = display.newSprite("ui/guild/guild_040.png", 23, 23)

						var_36_6:setScale(0.6)
						var_36_2:addChild(var_36_6)
					end
				end
			end
		end
	end
end

return var_0_2
