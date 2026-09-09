require("network.WorldBossRequest")
require("scenes.team.OthersTeamHelper")
require("scenes.battle.BattleOperator")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = require("base.cache")
local var_0_2 = require("scenes.toollayer.timer")
local var_0_3 = require("scenes.toollayer.ctrl")
local var_0_4 = require("scenes.toollayer.tool")
local var_0_5 = require("scenes.toollayer.model"):extend({
	requestDelay = 5,
	timeDelay = 30,
	timeSync = true,
	requestAuto = false,
	bossList = {},
	ctor = function(arg_1_0)
		local var_1_0 = {
			string.lf("白眉虎王"),
			string.lf("九魅狐王"),
			string.lf("铁臂熊王"),
			string.lf("万灵猴王")
		}
		local var_1_1 = {
			level = 99,
			leftHp = 9999999999,
			state = 1,
			maxHp = 9999999999,
			chestMaxHp = 100,
			chestState = 1,
			chestLeftHp = 0,
			leftHpPrecent = 100
		}

		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			var_1_1.id = iter_1_0
			var_1_1.name = iter_1_1

			arg_1_0:set("boss" .. iter_1_0, copyTable(var_1_1))
		end

		arg_1_0:set("delay", arg_1_0.requestDelay)
		arg_1_0:set("tick", 0)
		arg_1_0:set("auto", false)
		arg_1_0:set("remain", 0)
		arg_1_0:set("ranklist", NULL)
		arg_1_0:set("cost-res", 0)
		arg_1_0:set("cost-enc", 0)
		arg_1_0:set("vip-limit", 3)
		arg_1_0:set("power", Player.team.battlePower)
		arg_1_0:set("hurt", 0)
		arg_1_0:set("rank", 0)
		arg_1_0:set("coin", 0)
		arg_1_0:set("addition", 0)
		arg_1_0:set("time", 0)
	end,
	attach = function(arg_2_0, arg_2_1)
		arg_2_0.timer = var_0_2:new()
		arg_2_0.requestAuto = true
		arg_2_0.timeSync = true
		arg_2_0.updater = WorldBossUpdateRequest:new(arg_2_1)

		arg_2_0.updater:setResponseNormalHandler(function()
			local var_3_0, var_3_1 = arg_2_0.updater:getResponseContent()

			arg_2_0:loadData(var_3_1)
		end)
		arg_2_0.updater:setResponseExceptionHandler(function(arg_4_0)
			if arg_4_0 == -1151010 then
				arg_2_0.timer:stop()
				arg_2_0:trigger("finish")
			end

			arg_2_0.requestAuto = false
			arg_2_0.dirty = true

			print("处理请求发生错误")
		end)

		arg_2_0.request = WorldBossBattleRequest:new(arg_2_1)

		arg_2_0.request:setResponseNormalHandler(function()
			local var_5_0, var_5_1 = arg_2_0.request:getResponseContent()

			if var_5_0 == WorldBossBattleRequest.eEncourage then
				arg_2_0:set("addition", var_5_1)
			elseif var_5_0 == WorldBossBattleRequest.eAutoFight then
				local var_5_2 = not arg_2_0:get("auto")

				arg_2_0:set("auto", var_5_2)

				if var_5_2 then
					arg_2_0:set("delay", 1)
				end
			elseif var_5_0 == WorldBossBattleRequest.eResugence then
				arg_2_0:set("time", 0)

				if arg_2_0:get("auto") then
					arg_2_0:loadData(var_5_1)
					arg_2_0:set("delay", 1)
				else
					arg_2_0:set("delay", 0)
				end
			elseif var_5_0 == WorldBossBattleRequest.eBattle then
				arg_2_0:set("delay", 0)
			end
		end)
		arg_2_0.request:setResponseExceptionHandler(function()
			arg_2_0.dirty = true

			print("处理请求发生错误")
		end)
		arg_2_0.timer:update(handler(arg_2_0, arg_2_0.updateTime))
		arg_2_0.timer:start()
	end,
	sync = function(arg_7_0)
		if arg_7_0.dirty then
			arg_7_0:requestBattleInfo()
		end
	end,
	randomBoss = function(arg_8_0)
		local var_8_0 = 0
		local var_8_1 = 0

		for iter_8_0, iter_8_1 in ipairs(arg_8_0.bossList) do
			if var_8_1 < iter_8_1.leftHp then
				var_8_0 = iter_8_1.id
				var_8_1 = iter_8_1.leftHp
			end
		end

		return var_8_0
	end,
	updateTime = function(arg_9_0, arg_9_1)
		arg_9_1 = 1

		local var_9_0 = arg_9_0:get("remain") - arg_9_1

		if var_9_0 > 0 then
			arg_9_0:set("remain", var_9_0)
		else
			arg_9_0:set("remain", 0)
		end

		local var_9_1 = arg_9_0:get("time") - arg_9_1

		if var_9_1 >= 0 then
			arg_9_0:set("time", var_9_1)
		else
			arg_9_0.timeSync = true

			arg_9_0:set("time", 0)

			if arg_9_0:get("auto") then
				-- block empty
			end
		end

		local var_9_2 = arg_9_0:get("delay") - arg_9_1

		if var_9_2 > 0 then
			arg_9_0:set("delay", var_9_2)
		elseif arg_9_0.requestAuto then
			arg_9_0:requestBattleInfo()
		end
	end,
	loadData = function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_1.bossInfos
		local var_10_1 = arg_10_1.challengeRanks
		local var_10_2 = arg_10_1.playerChallengeInfo
		local var_10_3 = arg_10_1.remainTime
		local var_10_4 = arg_10_1.attackEvents
		local var_10_5 = arg_10_1.isAutofight == 1
		local var_10_6 = 0
		local var_10_7 = 0
		local var_10_8 = true

		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			arg_10_0.bossList[iter_10_0] = iter_10_1

			if iter_10_1.state < 3 then
				var_10_8 = false
			end

			arg_10_0:set("boss" .. iter_10_0, iter_10_1)
		end

		arg_10_0:set("auto", var_10_5)
		arg_10_0:set("ranklist", var_10_1)
		arg_10_0:set("cost-res", arg_10_1.resurgenceCost)
		arg_10_0:set("cost-enc", arg_10_1.encouragingCost)
		arg_10_0:set("power", var_10_2.battlePower)
		arg_10_0:set("hurt", var_10_2.haveHurt)
		arg_10_0:set("rank", var_10_2.hurtRank)
		arg_10_0:set("coin", var_10_2.killTotalGold)
		arg_10_0:set("addition", var_10_2.powerAddition)

		if arg_10_0.timeSync then
			arg_10_0:set("remain", var_10_3)
			arg_10_0:set("time", var_10_2.resurgenceTime)

			arg_10_0.timeSync = false
		end

		local var_10_9 = arg_10_0:get("tick")
		local var_10_10 = {
			{},
			{},
			{},
			{}
		}

		for iter_10_2, iter_10_3 in ipairs(var_10_4) do
			var_10_9 = math.max(var_10_9, iter_10_3.timeTick)

			table.insert(var_10_10[iter_10_3.bossID], iter_10_3)
		end

		arg_10_0:set("tick", var_10_9)

		for iter_10_4, iter_10_5 in ipairs(var_10_10) do
			var_0_4.foreach(iter_10_5, function(arg_11_0, arg_11_1, arg_11_2)
				arg_10_0:trigger("attack:boss" .. arg_11_1.bossID, arg_11_1, arg_11_2)
			end)
		end

		arg_10_0:set("delay", arg_10_0.requestDelay)

		if var_10_8 then
			arg_10_0:trigger("finish")
		elseif #var_10_4 > 0 then
			arg_10_0:trigger("attack")
		end
	end,
	requestBattleInfo = function(arg_12_0)
		arg_12_0.updater:requestBattleInfo(arg_12_0:get("tick"))
	end,
	requestEncourage = function(arg_13_0)
		arg_13_0.request:requestEncourage()
	end,
	requestAutoFight = function(arg_14_0)
		arg_14_0.request:requestAutoFight(not arg_14_0:get("auto"))
	end,
	requestResugence = function(arg_15_0)
		arg_15_0.request:requestResugence(arg_15_0:get("tick"))
	end,
	requestBattle = function(arg_16_0)
		arg_16_0.request:requestBattle(2, arg_16_0:randomBoss())
	end
})
local var_0_6 = class("WorldBossBattleScene", function()
	return require("scenes.worldboss.WorldBossBaseScene").new({
		from = "battle"
	})
end)

function var_0_6.ctor(arg_18_0, arg_18_1)
	arg_18_0.bosslist = {}
	arg_18_0.model = var_0_1.get(arg_18_0)

	if not arg_18_0.model then
		arg_18_0.model = var_0_5:new()

		var_0_1.set(arg_18_0, arg_18_0.model)
	end

	arg_18_0.model:attach(arg_18_0)
	arg_18_0:setUI()
	arg_18_0:setNotice()
	arg_18_0:setPanel()
	arg_18_0.model:sync()
	arg_18_0.model:on("attack", arg_18_0.shake, arg_18_0)
	arg_18_0.model:on("finish", function()
		game.enterWorldBossHomeScene()
	end)

	if arg_18_1 then
		local var_18_0 = arg_18_1.vipLv
		local var_18_1 = arg_18_1.enter

		if var_18_0 then
			arg_18_0.model:set("vip-limit", var_18_0)
		end

		if var_18_1 then
			arg_18_0:showRankLayer()
		end
	end
end

function var_0_6.onExit(arg_20_0)
	arg_20_0.model:detach()
end

function var_0_6.setUI(arg_21_0)
	local var_21_0 = arg_21_0.mContainer
	local var_21_1 = arg_21_0.mContainerSize
	local var_21_2 = arg_21_0.mPillarPos

	var_21_2[1], var_21_2[3], var_21_2[4] = var_21_2[4], var_21_2[1], var_21_2[3]

	local var_21_3 = {
		2,
		1,
		1,
		2
	}
	local var_21_4 = arg_21_0.bosslist

	for iter_21_0, iter_21_1 in ipairs(var_21_2) do
		local var_21_5 = arg_21_0:createBossNode(iter_21_0)

		var_21_5:setAnchorPoint(ccp(0.5, 0))
		var_21_5:setPosition(iter_21_1.x, iter_21_1.y)
		var_21_0:addChild(var_21_5, var_21_3[iter_21_0])
		table.insert(var_21_4, var_21_5)
	end

	local var_21_6 = var_0_3.newLabel({
		size = 22,
		text = string.lf("正在击杀妖王，结束时间："),
		color = ccc3(155, 205, 155)
	})

	var_21_6:setAnchorPoint(ccp(0, 0.5))
	var_21_6:setPosition(20, var_21_1.height - 20)
	var_21_0:addChild(var_21_6)

	local var_21_7 = var_0_3.newLabel({
		size = 22,
		text = string.lf("00:00:00"),
		color = ccc3(205, 51, 51)
	})

	var_21_7:setAnchorPoint(ccp(0, 0.5))
	var_21_7:setPosition(20, var_21_1.height - 45)
	var_21_0:addChild(var_21_7)
	arg_21_0.model:bind("remain", function(arg_22_0)
		var_21_7:setString(formatTime(arg_22_0))
	end)
end

function var_0_6.setNotice(arg_23_0)
	local var_23_0 = 30
	local var_23_1 = ccc3(250, 190, 50)
	local var_23_2 = display.newSprite("ui/worldboss/worldboss_020.png")
	local var_23_3 = var_23_2:getContentSize()
	local var_23_4 = CCScrollView:create(var_23_3, var_23_2)

	var_23_4:setTouchEnabled(false)
	var_23_4:setIgnoreAnchorPointForPosition(false)
	var_23_4:setAnchorPoint(ccp(0.5, 1))
	var_23_4:setPosition(arg_23_0.mContainerSize.width / 2, arg_23_0.mContainerSize.height - 10)
	arg_23_0.mContainer:addChild(var_23_4, 7)

	local var_23_5
	local var_23_6 = {}
	local var_23_7 = var_0_3.newLabel({
		text = "",
		color = var_23_1
	})

	var_23_2:addChild(var_23_7)
	table.insert(var_23_6, var_23_7)

	local var_23_8 = var_0_3.newLabel({
		text = "",
		color = var_23_1
	})

	var_23_2:addChild(var_23_8)
	table.insert(var_23_6, var_23_8)

	local var_23_9 = var_0_3.newLabel({
		text = "",
		color = var_23_1
	})

	var_23_2:addChild(var_23_9)
	table.insert(var_23_6, var_23_9)
	var_23_2:scheduleUpdate(function(arg_24_0)
		local var_24_0 = var_23_3.width
		local var_24_1 = 0
		local var_24_2 = 1
		local var_24_3 = 0
		local var_24_4 = 0
		local var_24_5 = 0
		local var_24_6
		local var_24_7 = {}

		for iter_24_0, iter_24_1 in ipairs(var_23_6) do
			local var_24_8 = iter_24_1:getContentSize().width

			var_24_5 = var_24_5 + var_24_8 + var_23_0

			table.insert(var_24_7, var_24_8)
		end

		local var_24_9 = math.max(var_24_0, var_24_5)

		for iter_24_2, iter_24_3 in ipairs(var_23_6) do
			local var_24_10, var_24_11 = iter_24_3:getPosition()
			local var_24_12 = var_24_11
			local var_24_13 = var_24_10 - var_24_2
			local var_24_14 = var_24_7[iter_24_2]

			if var_24_14 <= -var_24_13 then
				var_24_13 = iter_24_2 == 1 and var_24_9 or var_24_1
			end

			iter_24_3:align(display.LEFT_CENTER, var_24_13, var_24_12)

			var_24_1 = var_24_13 + var_24_14 + var_23_0
		end
	end)
	arg_23_0.model:bind("ranklist", function(arg_25_0)
		local var_25_0 = {
			string.lf("第一名：#FADC96"),
			string.lf("第二名：#FADC96"),
			string.lf("第三名：#FADC96")
		}
		local var_25_1
		local var_25_2
		local var_25_3 = 0
		local var_25_4 = var_23_3.height / 2

		for iter_25_0, iter_25_1 in ipairs(arg_25_0) do
			local var_25_5 = var_23_6[iter_25_0]

			var_25_5:setString(var_25_0[iter_25_0] .. (iter_25_1.name or string.lf("虚位以待")))
			var_25_5:align(display.LEFT_CENTER, var_25_3, var_25_4)

			var_25_3 = var_25_3 + var_25_5:getContentSize().width + var_23_0
		end
	end)
end

function var_0_6.setPanel(arg_26_0)
	local var_26_0 = ccc3(250, 190, 50)
	local var_26_1 = display.newSprite("ui/worldboss/worldboss_023.png")

	var_26_1:setAnchorPoint(ccp(0.5, 0))
	var_26_1:setPosition(arg_26_0.mContainerSize.width / 2, 0)
	arg_26_0.mContainer:addChild(var_26_1)

	local var_26_2
	local var_26_3 = {}
	local var_26_4 = var_0_3.newLabel({
		text = string.lf("造成伤害：#FADC96%s", 0),
		color = var_26_0
	})

	arg_26_0.model:bind("hurt", function(arg_27_0)
		var_26_4:setString(string.lf("造成伤害：#FADC96%s", arg_27_0))
	end)
	table.insert(var_26_3, var_26_4)

	local var_26_5 = var_0_3.newLabel({
		text = string.lf("伤害排名：#FADC96%s", 0),
		color = var_26_0
	})

	arg_26_0.model:bind("rank", function(arg_28_0)
		var_26_5:setString(string.lf("伤害排名：#FADC96%s", arg_28_0))
	end)
	table.insert(var_26_3, var_26_5)

	local var_26_6 = var_0_3.newLabel({
		text = string.lf("银币收益：#FADC96%s", 0),
		color = var_26_0
	})

	arg_26_0.model:bind("coin", function(arg_29_0)
		var_26_6:setString(string.lf("银币收益：#FADC96%s", arg_29_0))
	end)
	table.insert(var_26_3, var_26_6)

	local var_26_7 = var_0_3.newLabel({
		text = string.lf("当前战力：#FADC96%s #00FA46(+%s%%)", 0, 0),
		color = var_26_0
	})

	arg_26_0.model:bind("power|addition", function(arg_30_0, arg_30_1)
		var_26_7:setString(string.lf("当前战力：#FADC96%s #00FA46(+%s%%)", arg_30_0, arg_30_1 * 100))
	end)
	table.insert(var_26_3, var_26_7)

	local var_26_8 = var_0_3.newLabel({
		text = string.lf("复活时间：#FADC96%s", "00:00:00"),
		color = var_26_0
	})

	arg_26_0.model:bind("time", function(arg_31_0)
		local var_31_0 = arg_31_0 > 0 and "#FF0000" or "#FADC96"
		local var_31_1

		if arg_26_0.model:get("auto") == true and arg_31_0 == 0 then
			var_31_1 = string.lf("战斗中")
		else
			var_31_1 = formatTime(arg_31_0)
		end

		var_26_8:setString(string.lf("复活时间：%s%s", var_31_0, var_31_1))
	end)
	table.insert(var_26_3, var_26_8)

	local var_26_9 = var_0_3.linearLayout({
		direction = "vertical",
		nodes = var_26_3,
		align = display.LEFT_CENTER
	})

	var_26_9:setAnchorPoint(ccp(0, 0))
	var_26_9:setPosition(220, 60)
	var_26_1:addChild(var_26_9)

	local var_26_10 = ui.newControlButton({
		normalImage = "ui/worldboss/worldboss_022.png",
		clickAction = function()
			arg_26_0:showRankLayer()
		end
	})

	var_26_10:setPosition(60, 130)
	var_26_1:addChild(var_26_10)

	local var_26_11 = ui.newControlButton({
		normalImage = "ui/worldboss/worldboss_021.png",
		clickAction = function()
			local var_33_0 = string.lf("上仙，消耗#FFFF3C%d元宝#FFFFFF可以鼓舞士气增加战力，确定鼓舞？", arg_26_0.model:get("cost-enc"))

			var_0_0.createDialog({
				show = var_0_0.eShowNoticeBox,
				data = var_33_0,
				callback = function()
					arg_26_0.model:requestEncourage()
				end
			}):show()
		end
	})

	var_26_11:setPosition(160, 130)
	var_26_1:addChild(var_26_11)

	local var_26_12 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		clickAction = function()
			local var_35_0 = arg_26_0.model:get("vip-limit")

			if var_35_0 <= Player.vipLevel then
				arg_26_0.model:requestAutoFight()
			else
				ui.showMessageBox({
					animate = "slide",
					text = string.lf("上仙，VIP%s才能使用自动战斗功能，马上去充值？", var_35_0),
					title1 = string.lf("确定"),
					title2 = string.lf("去充值"),
					action2 = function()
						game.enterStoreRechargeScene({
							backcall = game.enterWorldBossBattleScene
						})
					end
				})
			end
		end
	})

	var_26_12:setPosition(120, 35)
	var_26_1:addChild(var_26_12)

	local var_26_13 = var_26_12:getContentSize()
	local var_26_14 = display.newSprite("uilocal/worldboss/worldboss_text_005.png")

	var_26_14:setPosition(var_26_13.width / 2, var_26_13.height / 2)
	var_26_12:addChild(var_26_14)

	var_26_12.title1 = var_26_14

	local var_26_15 = display.newSprite("uilocal/worldboss/worldboss_text_009.png")

	var_26_15:setPosition(var_26_13.width / 2, var_26_13.height / 2)
	var_26_12:addChild(var_26_15)

	var_26_12.title2 = var_26_15

	arg_26_0.model:bind("auto", function(arg_37_0)
		var_26_14:setVisible(not arg_37_0)
		var_26_15:setVisible(arg_37_0)
	end)

	local var_26_16 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/worldboss/worldboss_text_006.png",
		clickAction = handler(arg_26_0, arg_26_0.onRetryBtnClicked)
	})

	var_26_16:setPosition(360, 35)
	var_26_1:addChild(var_26_16)
end

function var_0_6.onRetryBtnClicked(arg_38_0)
	local var_38_0 = arg_38_0.model:get("auto")

	if arg_38_0.model:get("time") > 0 then
		local var_38_1 = string.lf("上仙，消耗#FFFF3C%d元宝#FFFFFF可以马上复活，确定复活？", arg_38_0.model:get("cost-res"))

		var_0_0.createDialog({
			show = var_0_0.eShowNoticeBox,
			data = var_38_1,
			callback = function()
				arg_38_0.model:requestResugence()
			end
		}):show()
	else
		showFlashNotice(string.lf("上仙，开始战斗吧！"))
	end
end

function var_0_6.createBossNode(arg_40_0, arg_40_1)
	local var_40_0 = ccc3(250, 190, 50)
	local var_40_1 = CCNode:create()
	local var_40_2 = CCSize(280, 420)

	var_40_1:setContentSize(var_40_2)

	local var_40_3 = {
		"ui/worldboss/worldboss_019.png",
		"ui/worldboss/worldboss_017.png",
		"ui/worldboss/worldboss_016.png",
		"ui/worldboss/worldboss_018.png"
	}
	local var_40_4 = "boss" .. arg_40_1
	local var_40_5 = arg_40_0.model:get(var_40_4)
	local var_40_6 = display.newSprite("ui/worldboss/worldboss_015.png")

	var_40_6:setPosition(var_40_2.width / 2, 50)
	var_40_1:addChild(var_40_6)

	local var_40_7 = ui.newControlButton({
		normalImage = var_40_3[arg_40_1],
		clickAction = function()
			arg_40_0:startBattle(arg_40_1)
		end
	})

	var_40_7:setPosition(var_40_2.width / 2, 220)
	var_40_1:addChild(var_40_7)

	local var_40_8 = CCGraySprite:create(var_40_3[arg_40_1])

	var_40_8:setPosition(var_40_2.width / 2, 220)
	var_40_8:setVisible(false)
	var_40_1:addChild(var_40_8)

	local var_40_9 = var_40_7:getContentSize()
	local var_40_10 = arg_40_0:createRageFire(false)

	var_40_10:setPosition(var_40_9.width / 2, var_40_9.height / 4)
	var_40_10:setVisible(false)
	var_40_7:addChild(var_40_10, -1)

	local var_40_11 = arg_40_0:createRageFire(true)

	var_40_11:setPosition(var_40_9.width / 2, var_40_9.height / 4)
	var_40_11:setVisible(false)
	var_40_7:addChild(var_40_11, 1)

	local var_40_12 = require("scenes.ProgressBar").new({
		backImage = "ui/worldboss/worldboss_026.png",
		percent = 1,
		barImages = {
			"ui/worldboss/worldboss_024.png"
		},
		backSize = CCSize(280, 73),
		barSize = CCSize(222, 17),
		barPosition = ccp(-90, -3)
	})

	var_40_12:setPosition(var_40_2.width / 2, 0)
	var_40_12:setScale(0.9)
	var_40_1:addChild(var_40_12)

	local var_40_13 = var_0_3.newLabel({
		text = var_40_5.name,
		color = var_40_0
	})

	var_40_13:setPosition(20, 22)
	var_40_12:addChild(var_40_13)

	local var_40_14 = var_0_3.newLabel({
		size = 14,
		text = string.format("d%%", var_40_5.leftHpPrecent),
		color = var_40_0
	})

	var_40_14:setPosition(-110, -4)
	var_40_12:addChild(var_40_14)

	local var_40_15 = require("scenes.ProgressBar").new({
		backImage = "ui/worldboss/worldboss_027.png",
		barImages = {
			"ui/worldboss/worldboss_028.png"
		},
		backSize = CCSize(21, 76),
		barSize = CCSize(21, 76),
		barPosition = ccp(0, 0),
		barType = ProgressBarType.barTypeTimerVertical,
		percent = var_40_5.chestLeftHp / var_40_5.chestMaxHp
	})

	var_40_15:setPosition(var_40_2.width - 50, 100)
	var_40_1:addChild(var_40_15)

	local var_40_16 = display.newSprite("ui/worldboss/worldboss_029.png")

	var_40_15:addChild(var_40_16)
	arg_40_0.model:on("attack:" .. var_40_4, function(arg_42_0, arg_42_1)
		local var_42_0 = var_40_7:getContentSize()
		local var_42_1 = var_0_3.newLabel({
			size = 30,
			outline = true,
			text = arg_42_0.playerName,
			font = _FONT_LISU,
			color = ccc3(255, 0, 0)
		})
		local var_42_2 = CCLabelAtlas:create("/" .. arg_42_0.hurt, "uilocal/battle/battle_text_010.png", 34, 55, 46)
		local var_42_3 = var_0_3.linearLayout({
			margin = 20,
			direction = "vertical",
			nodes = {
				var_42_1,
				var_42_2
			}
		})

		var_42_3:setOpacity(0)
		var_42_3:setAnchorPoint(ccp(0.5, 0.5))
		var_42_3:setPosition(var_42_0.width / 2, var_42_0.height / 2 - 100)
		var_40_7:addChild(var_42_3)

		local var_42_4 = CCArray:create()
		local var_42_5 = 0.5
		local var_42_6 = CCArray:create()

		var_42_6:addObject(CCFadeIn:create(var_42_5))
		var_42_6:addObject(CCScaleTo:create(var_42_5, 1))
		var_42_6:addObject(CCMoveBy:create(var_42_5, ccp(0, 80)))
		var_42_4:addObject(CCSpawn:create(var_42_6))

		if arg_42_1 then
			local var_42_7 = CCCallFunc:create(function()
				local var_43_0 = CCArray:create()

				var_43_0:addObject(CCFadeTo:create(0.1, 180))
				var_43_0:addObject(CCFadeTo:create(0.1, 255))
				var_40_7:runAction(CCSequence:create(var_43_0))
				arg_42_1()
			end)

			var_42_4:addObject(var_42_7)
		end

		local var_42_8 = 0.6
		local var_42_9 = CCArray:create()

		var_42_9:addObject(CCFadeOut:create(var_42_8))
		var_42_9:addObject(CCScaleTo:create(var_42_8, 0))
		var_42_9:addObject(CCMoveBy:create(var_42_8, ccp(0, 100)))
		var_42_4:addObject(CCSpawn:create(var_42_9))

		local var_42_10 = CCCallFunc:create(function()
			var_42_3:removeFromParent()
		end)

		var_42_4:addObject(var_42_10)
		var_42_3:runAction(CCSequence:create(var_42_4))
	end)
	arg_40_0.model:bind(var_40_4, function(arg_45_0)
		local var_45_0 = arg_45_0.leftHpPrecent

		if var_45_0 >= 0 and var_45_0 <= 100 then
			var_40_14:setString(string.format("%d", var_45_0))
			var_40_12:setProgressPercent(1, var_45_0 / 100)
		end

		local var_45_1 = arg_45_0.chestLeftHp / arg_45_0.chestMaxHp

		if var_45_1 >= 0 and var_45_1 <= 1 then
			var_40_15:setProgressPercent(1, var_45_1)
		end

		local var_45_2 = arg_45_0.state

		var_40_10:setVisible(var_45_2 == 2)
		var_40_11:setVisible(var_45_2 == 2)
		var_40_7:setEnabled(var_45_2 ~= 3)
		var_40_7:setVisible(var_45_2 ~= 3)
		var_40_8:setVisible(var_45_2 == 3)

		local var_45_3 = arg_45_0.chestState
		local var_45_4, var_45_5 = var_40_7:getPosition()

		if var_45_3 == 1 then
			var_40_6:setVisible(true)
			var_40_15:setVisible(true)
			var_40_7:setPosition(var_45_4, 220)
			var_40_8:setPosition(var_45_4, 220)
		else
			var_40_6:setVisible(false)
			var_40_15:setVisible(false)
			var_40_7:setPosition(var_45_4, 130)
			var_40_8:setPosition(var_45_4, 130)
		end
	end)

	return var_40_1
end

function var_0_6.startBattle(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0.model:get("auto")

	if arg_46_0.model:get("time") > 0 then
		arg_46_0:onRetryBtnClicked()
	elseif var_46_0 then
		showFlashNotice(string.lf("自动战斗中。。。"))
	else
		local var_46_1 = var_46_0 and 2 or 1

		BattleOperator:startBattle(eBattleType.shijieBOSS, {
			bossId = arg_46_1,
			battleType = var_46_1
		}, function(arg_47_0, arg_47_1)
			game.enterWorldBossBattleScene()
		end)
	end
end

function var_0_6.showRankLayer(arg_48_0)
	local var_48_0 = require("scenes.worldboss.WorldBossDPSRankLayer").new({
		from4OtherTeam = OthersTeamHelper.eDataFromWorldBossBattle,
		closeCallBack = function()
			arg_48_0.model.requestAuto = true
		end
	})

	arg_48_0:addChild(var_48_0)

	arg_48_0.model.requestAuto = false
end

function var_0_6.createRageFire(arg_50_0, arg_50_1)
	local var_50_0 = CCNode:create()
	local var_50_1 = CCSize(160, 240)

	var_50_0:setAnchorPoint(ccp(0.5, 0.5))
	var_50_0:setContentSize(var_50_1)

	local var_50_2 = 16
	local var_50_3 = var_50_1.width
	local var_50_4 = var_50_1.height

	if arg_50_1 then
		var_50_2 = var_50_2 / 2
		var_50_4 = var_50_4 - 100
	end

	for iter_50_0 = 1, var_50_2 do
		local var_50_5 = arg_50_0:createParticleFire(arg_50_1)

		var_50_5:setPosition(math.random(0, var_50_3), math.random(10, var_50_4))
		var_50_0:addChild(var_50_5)
	end

	return var_50_0
end

function var_0_6.createParticleFire(arg_51_0, arg_51_1)
	local var_51_0 = CCParticleFire:create()

	var_51_0:setTextureWithRect(CCTextureCache:sharedTextureCache():addImage("ui/common/fire.png"), CCRect(0, 0, 32, 32))
	var_51_0:setStartSize(arg_51_1 and 40 or 60)
	var_51_0:setLifeVar(0)
	var_51_0:setLife(1)
	var_51_0:setAngle(90)
	var_51_0:setSpeed(arg_51_1 and 90 or 120)

	return var_51_0
end

function var_0_6.shake(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_0.mContainer
	local var_52_1 = math.random(1, 6)
	local var_52_2 = -var_52_1
	local var_52_3, var_52_4 = var_52_0:getPosition()
	local var_52_5 = CCArray:create()

	var_52_5:addObject(CCMoveBy:create(0.05, ccp(var_52_1, var_52_1)))
	var_52_5:addObject(CCMoveBy:create(0.05, ccp(var_52_2, var_52_2)))
	var_52_5:addObject(CCMoveBy:create(0.05, ccp(var_52_1, var_52_2)))
	var_52_5:addObject(CCMoveBy:create(0.05, ccp(var_52_2, var_52_1)))

	if arg_52_1 then
		var_52_5:addObject(CCCallFunc:create(arg_52_1))
	end

	var_52_0:stopAllActions()
	var_52_0:runAction(CCSequence:create(var_52_5))
end

return var_0_6
