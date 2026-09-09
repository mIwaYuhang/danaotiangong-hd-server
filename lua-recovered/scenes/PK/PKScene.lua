require("base.define")
require("base.figure")
require("data.player")
require("network.PkRequest")
require("scenes.battle.BattleOperator")
require("scenes.team.OthersTeamHelper")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = require("scenes.ToolLayer")
local var_0_2 = require("scenes.PK.PKMarqueeLayer")
local var_0_3 = require("base.cache")
local var_0_4 = require("scenes.toollayer.timer")
local var_0_5 = require("scenes.toollayer.model"):extend({
	boss = false,
	current = false,
	previous = false,
	rankLayer = false,
	ctor = function(arg_1_0)
		arg_1_0:set("battle_total", 0)
		arg_1_0:set("battle_count", 0)
		arg_1_0:set("battle_time", 0)
		arg_1_0:set("battle_period", 0)
		arg_1_0:set("streak", 0)
		arg_1_0:set("score_bonus", 0)
		arg_1_0:set("score_period", 0)
		arg_1_0:set("score_time", 0)
		arg_1_0:set("score_value", 0)
	end,
	attach = function(arg_2_0, arg_2_1)
		arg_2_0.timer = var_0_4:new()
		arg_2_0.duelInfoRequest = GetDuelInfoRequest:new(arg_2_1)

		arg_2_0.duelInfoRequest:setResponseNormalHandler(function()
			local var_3_0 = arg_2_0.duelInfoRequest:getResponseContent()

			arg_2_0:loadData(var_3_0)
		end)
		arg_2_0.duelInfoRequest:setResponseExceptionHandler(function()
			print("处理请求发生错误")
		end)

		arg_2_0.topTenRequest = DuelTopTenRequest:new(arg_2_1)

		arg_2_0.topTenRequest:setResponseNormalHandler(function()
			local var_5_0 = arg_2_0.topTenRequest:getResponseContent()

			arg_2_0.boss = var_5_0[1]

			arg_2_0:trigger("boss", arg_2_0.boss)
		end)
		arg_2_0.topTenRequest:setResponseExceptionHandler(function()
			print("处理请求发生错误")
		end)
	end,
	loadData = function(arg_7_0, arg_7_1)
		if arg_7_0.current and arg_7_0.rank > arg_7_1.Ranking then
			arg_7_0.previous = {
				rank = arg_7_0.rank,
				data = arg_7_0.current
			}
		else
			arg_7_0.previous = false
		end

		arg_7_0.current = arg_7_1.Targets
		arg_7_0.cooldown = arg_7_1.Cooling
		arg_7_0.cost = arg_7_1.Cost

		arg_7_0:loadScore(arg_7_1)
		arg_7_0:set("streak-list", arg_7_1.ContinueWinEvent)

		local var_7_0
		local var_7_1
		local var_7_2 = 0
		local var_7_3 = 0
		local var_7_4 = tostring(Player.userId)

		for iter_7_0, iter_7_1 in ipairs(arg_7_0.current) do
			if iter_7_1.Ranking == 1 then
				var_7_2, var_7_0 = iter_7_0, iter_7_1
			end

			if iter_7_1.PlayerId == var_7_4 then
				var_7_3, var_7_1 = iter_7_0, iter_7_1

				break
			end
		end

		if var_7_0 then
			arg_7_0.boss = var_7_0

			table.remove(arg_7_0.current, var_7_2)
		else
			arg_7_0.boss = arg_7_1.Champion
		end

		arg_7_0.user = var_7_1
		arg_7_0.index = var_7_3
		arg_7_0.rank = var_7_1.Ranking
		arg_7_0.uid = var_7_1.PlayerId

		arg_7_0:trigger("duel", arg_7_0)
		arg_7_0:trigger("boss", arg_7_0.boss)
	end,
	loadScore = function(arg_8_0, arg_8_1)
		arg_8_0.rank = arg_8_1.Ranking

		arg_8_0:set("streak", arg_8_1.ContinuousTime)

		local var_8_0 = arg_8_1.Residue
		local var_8_1 = arg_8_1.MaxTime
		local var_8_2 = arg_8_1.NextRecoverTime

		arg_8_0:set("battle_count", var_8_0)
		arg_8_0:set("battle_total", var_8_1)
		arg_8_0:set("battle_time", var_8_2)
		arg_8_0:set("battle_period", arg_8_1.RecoverPerTime)

		if var_8_0 < var_8_1 then
			arg_8_0.timer:update(function(arg_9_0)
				local var_9_0 = arg_8_0:get("battle_time") - arg_9_0
				local var_9_1 = false

				if var_9_0 < 0.5 then
					local var_9_2 = arg_8_0:get("battle_count") + 1

					if var_9_2 < arg_8_0:get("battle_total") then
						var_9_0 = arg_8_0:get("battle_period")
					else
						var_9_0 = 0
						var_9_1 = true
					end

					arg_8_0:set("battle_count", var_9_2)
				end

				arg_8_0:set("battle_time", var_9_0)

				return var_9_1
			end)
		end

		arg_8_0:set("score_value", arg_8_1.Score)

		local var_8_3 = arg_8_1.SecondPerTime

		arg_8_0:set("score_period", var_8_3)

		local var_8_4 = arg_8_1.NextTime

		if var_8_4 == 0 then
			var_8_4 = var_8_3
		end

		arg_8_0:set("score_time", var_8_4)
		arg_8_0:set("score_bonus", arg_8_1.ScorePerTime)
		arg_8_0.timer:update(function(arg_10_0)
			local var_10_0 = arg_8_0:get("score_time") - arg_10_0

			if var_10_0 < 0.5 then
				local var_10_1 = arg_8_0:get("score_value") + arg_8_0:get("score_bonus")

				var_10_0 = arg_8_0:get("score_period")

				arg_8_0:set("score_value", var_10_1)
			end

			arg_8_0:set("score_time", var_10_0)
		end)
		arg_8_0.timer:start()
	end,
	sync = function(arg_11_0)
		if arg_11_0.dirty then
			arg_11_0.duelInfoRequest:request()
		else
			arg_11_0:trigger("duel", arg_11_0)
		end
	end,
	topTen = function(arg_12_0)
		arg_12_0.topTenRequest:request()
	end
})
local var_0_6 = class("PKScene", function()
	return display.newScene("PKScene")
end)

function var_0_6.ctor(arg_14_0, arg_14_1)
	arg_14_0.container = nil
	arg_14_0.tableview = nil
	arg_14_0.boss = {}
	arg_14_0.user = nil
	arg_14_0.rankview = nil
	arg_14_0.model = var_0_3.get(arg_14_0)

	if not arg_14_0.model then
		arg_14_0.model = var_0_5:new()

		var_0_3.set(arg_14_0, arg_14_0.model)
	end

	arg_14_0.model:attach(arg_14_0)
	arg_14_0:onEnterAlias()
end

function var_0_6.onEnterAlias(arg_15_0)
	local var_15_0 = Adapter.AutoScaleY
	local var_15_1 = display.newSprite("ui/PK/PK_013.jpg")
	local var_15_2 = var_15_1:getContentSize()

	var_15_1:setPosition(display.cx, display.cy)
	var_15_1:setScale(var_15_0)
	arg_15_0:addChild(var_15_1)

	local var_15_3 = math.min(var_15_2.width * var_15_0, display.width) / var_15_0
	local var_15_4 = math.min(var_15_2.height * var_15_0, display.height) / var_15_0
	local var_15_5 = CCSize(var_15_3, var_15_4)
	local var_15_6 = CCNode:create()

	var_15_6:setContentSize(var_15_5)

	local var_15_7 = (var_15_2.width - var_15_5.width) / 2
	local var_15_8 = (var_15_2.height - var_15_5.height) / 2

	var_15_6:setPosition(var_15_7, var_15_8)
	var_15_1:addChild(var_15_6)

	arg_15_0.container = var_15_6

	local var_15_9 = ui.newControlButton({
		normalImage = "ui/common/common_070.png",
		clickAction = function()
			game.enterHomeScene({
				showSubLayer = ShowSubLayerType.ePKHome
			})
		end
	})

	var_15_9:setPosition(var_15_5.width - 55, var_15_5.height - 35)
	var_15_6:addChild(var_15_9)

	local var_15_10 = display.newSprite("ui/PK/PK_008.png")

	var_15_10:align(display.LEFT_CENTER, 0, var_15_5.height / 2)
	var_15_6:addChild(var_15_10)

	local var_15_11 = arg_15_0:createHeroNode()
	local var_15_12 = arg_15_0:createPKScoreView()
	local var_15_13 = arg_15_0:createPKToolbar()
	local var_15_14 = arg_15_0:createPKDescView()
	local var_15_15 = arg_15_0:createRankView()

	var_15_11:setPosition(var_15_5.width / 2, 80)
	var_15_12:setPosition(var_15_5.width / 2 - 80, 640)
	var_15_13:setPosition(var_15_5.width, 40)
	var_15_14:setPosition(var_15_5.width / 2 - 40, -85)
	var_15_15:setPosition(-490, 0)
	var_15_6:addChild(var_15_11)
	var_15_6:addChild(var_15_15)
	var_15_6:addChild(var_15_12)
	var_15_6:addChild(var_15_13)
	var_15_6:addChild(var_15_14)

	arg_15_0.rankview = var_15_15
	arg_15_0.toolbar = var_15_13
	arg_15_0.descview = var_15_14
	arg_15_0.scoreview = var_15_12

	arg_15_0.model:on("duel", arg_15_0.onDuel, arg_15_0)
	arg_15_0.model:on("boss", arg_15_0.onBoss, arg_15_0)
	arg_15_0.model:sync()
	GuideLayer:showMissionReward(arg_15_0, TaskType.eTaskTeaching, TaskEntryType.eEntryDuelDefeat, 1)
	GuideLayer:showMissionReward(arg_15_0, TaskType.eTaskTeaching, TaskEntryType.eEntryDuelRanking, 1)
end

function var_0_6.onExit(arg_17_0)
	arg_17_0.model:detach()
end

function var_0_6.onDuel(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.model.rank
	local var_18_1 = arg_18_1:get("streak-list")

	if var_18_1 and #var_18_1 > 0 then
		arg_18_0:showNoticeView(var_18_1)
	end

	if arg_18_1.previous and var_18_0 > 1 then
		local var_18_2 = {
			rank = var_18_0,
			data = arg_18_1.current
		}

		arg_18_0:createAnimateView(arg_18_1.previous, var_18_2, handler(arg_18_0, arg_18_0.reloadData))
	else
		arg_18_0:reloadData()
	end

	arg_18_0.rankview:runAction(CCMoveBy:create(0.5, ccp(490, 0)))
	arg_18_0.toolbar:runAction(CCMoveBy:create(0.5, ccp(-95, 0)))
	arg_18_0.descview:runAction(CCMoveBy:create(0.5, ccp(0, 85)))
	arg_18_0.scoreview:runAction(CCMoveBy:create(0.5, ccp(0, -40)))

	local var_18_3 = CCArray:create()

	var_18_3:addObject(CCDelayTime:create(0.6))
	var_18_3:addObject(CCCallFunc:create(handler(arg_18_0, arg_18_0.showGuideLayer)))
	arg_18_0:runAction(CCSequence:create(var_18_3))

	if arg_18_0.model.rankLayer then
		local var_18_4 = require("scenes.PK.DlgRankLayer").new({
			type = DlgRankType.rankArena,
			closecallback = function()
				arg_18_0.model.rankLayer = false
			end
		})

		arg_18_0:addChild(var_18_4)
	end

	Player:setDuelObject({
		Last = arg_18_1:get("battle_count")
	})
end

function var_0_6.onBoss(arg_20_0, arg_20_1)
	if arg_20_0.model.rank > 1 then
		arg_20_0.rankview:reloadBoss(arg_20_1)
	elseif arg_20_0.model.previous then
		arg_20_0:createBossAnimate(arg_20_1)
	else
		arg_20_0.rankview:reloadBoss(arg_20_1)
	end
end

function var_0_6.reloadData(arg_21_0)
	local var_21_0 = arg_21_0.model
	local var_21_1 = arg_21_0.tableview
	local var_21_2 = var_21_0.current
	local var_21_3 = var_21_0.rank

	var_21_1:reloadData(var_21_2)

	if var_21_3 > 6 then
		local var_21_4 = ccp(0, (var_21_0.index - #var_21_2) * 97)

		var_21_1:setContentOffset(var_21_4)
	end
end

function var_0_6.createBossAnimate(arg_22_0, arg_22_1)
	local var_22_0 = CCSize(490, 97)
	local var_22_1 = CCParticleFire:create()

	var_22_1:setTextureWithRect(CCTextureCache:sharedTextureCache():addImage("ui/common/fire.png"), CCRect(0, 0, 32, 32))
	var_22_1:setPosition(0, 0)
	var_22_1:setStartSize(90)
	var_22_1:setLifeVar(0)
	var_22_1:setLife(1)
	var_22_1:setAngle(90)
	var_22_1:setSpeed(160)

	local var_22_2 = CCArray:create()
	local var_22_3 = CCMoveBy:create(0.1, ccp(var_22_0.width, 0))
	local var_22_4 = var_22_3:reverse()

	var_22_2:addObject(var_22_3)
	var_22_2:addObject(var_22_4)

	local var_22_5 = CCSequence:create(var_22_2)

	var_22_1:runAction(CCRepeatForever:create(var_22_5))

	local var_22_6 = CCNode:create()

	var_22_6:setContentSize(var_22_0)
	var_22_6:addChild(var_22_1)

	local var_22_7 = arg_22_0:createRankItem(nil, nil, arg_22_1)

	var_22_6:addChild(var_22_7)

	local var_22_8 = ccp(display.cx - var_22_0.width / 2, display.cy - var_22_0.height / 2)
	local var_22_9 = ccp(0, 485)

	var_22_6:setPosition(var_22_8)
	arg_22_0.container:addChild(var_22_6)

	local var_22_10 = CCArray:create()
	local var_22_11 = CCDelayTime:create(1)
	local var_22_12 = CCMoveTo:create(0.5, var_22_9)
	local var_22_13 = CCCallFunc:create(function()
		arg_22_0.rankview:reloadBoss(arg_22_1)
		var_22_6:removeFromParent()
	end)

	var_22_10:addObject(var_22_11)
	var_22_10:addObject(var_22_12)
	var_22_10:addObject(var_22_13)
	var_22_6:runAction(CCSequence:create(var_22_10))
end

function var_0_6.prepareAnimateData(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_1.rank
	local var_24_1 = arg_24_1.data
	local var_24_2 = arg_24_2.rank
	local var_24_3 = arg_24_2.data
	local var_24_4 = 0
	local var_24_5 = 0

	for iter_24_0, iter_24_1 in ipairs(var_24_1) do
		local var_24_6 = iter_24_1.Ranking

		if var_24_6 == var_24_2 then
			var_24_5 = iter_24_0
		elseif var_24_6 == var_24_0 then
			var_24_4 = iter_24_0
		end
	end

	local var_24_7 = var_24_4 - var_24_5 + 1 > 5
	local var_24_8 = {}
	local var_24_9
	local var_24_10 = 0
	local var_24_11 = 0

	for iter_24_2, iter_24_3 in ipairs(var_24_3) do
		local var_24_12 = iter_24_3.Ranking

		if var_24_12 < var_24_2 then
			table.insert(var_24_8, iter_24_3)
		elseif var_24_12 == var_24_2 then
			var_24_11, var_24_9 = iter_24_2, iter_24_3

			if var_24_7 then
				table.insert(var_24_8, false)

				var_24_11 = #var_24_8
			end
		elseif var_24_12 == var_24_0 then
			table.insert(var_24_8, iter_24_3)
			table.insert(var_24_8, var_24_9)

			var_24_10 = #var_24_8
		elseif #var_24_8 < 5 then
			table.insert(var_24_8, iter_24_3)
		else
			break
		end
	end

	local var_24_13 = #var_24_8

	if var_24_10 == 0 then
		local var_24_14 = var_24_9.Ranking

		if var_24_8[var_24_13] then
			var_24_14 = math.max(var_24_14, var_24_8[var_24_13].Ranking)
		end

		local var_24_15 = var_24_14 + 1

		for iter_24_4, iter_24_5 in ipairs(var_24_1) do
			local var_24_16 = iter_24_5.Ranking

			if var_24_16 < var_24_2 then
				-- block empty
			elseif var_24_16 < var_24_0 then
				iter_24_5.Ranking = var_24_16 + 1

				table.insert(var_24_8, iter_24_5)
			elseif var_24_16 == var_24_0 then
				table.insert(var_24_8, var_24_9)

				var_24_10 = #var_24_8
			elseif #var_24_8 < 12 then
				table.insert(var_24_8, iter_24_5)
			end
		end
	end

	if not var_24_7 and var_24_10 - var_24_11 > 5 then
		table.insert(var_24_8, var_24_11, false)

		var_24_10 = var_24_10 + 1
		var_24_7 = true
	end

	return var_24_7, var_24_10, var_24_13, var_24_11, var_24_8
end

function var_0_6.createAnimateView(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = CCSize(490, 484)
	local var_25_1 = CCSize(490, 97)
	local var_25_2 = arg_25_0.rankview

	local function var_25_3(arg_26_0, arg_26_1, arg_26_2)
		local var_26_0 = 0

		arg_26_0 = -10 * arg_26_0 / arg_26_1

		return arg_26_2 * (1 - math.pow(2, arg_26_0))
	end

	local function var_25_4(arg_27_0, ...)
		local var_27_0 = {
			...
		}
		local var_27_1 = CCArray:create()

		var_27_1:addObject(CCDelayTime:create(arg_27_0))

		for iter_27_0 = 1, #var_27_0 do
			var_27_1:addObject(var_27_0[iter_27_0])
		end

		return CCSequence:create(var_27_1)
	end

	local var_25_5 = arg_25_1.rank
	local var_25_6 = arg_25_2.rank
	local var_25_7, var_25_8, var_25_9, var_25_10, var_25_11 = arg_25_0:prepareAnimateData(arg_25_1, arg_25_2)
	local var_25_12 = #var_25_11
	local var_25_13 = {}

	for iter_25_0, iter_25_1 in ipairs(var_25_11) do
		local var_25_14 = arg_25_0:createRankItem(nil, nil, iter_25_1)

		table.insert(var_25_13, var_25_14)
	end

	local var_25_15 = var_0_0.linearLayout({
		direction = "vertical",
		nodes = var_25_13
	})
	local var_25_16 = CCScrollView:create(var_25_0, var_25_15)

	var_25_16:setDirection(kCCScrollViewDirectionVertical)
	var_25_16:setTouchEnabled(false)
	var_25_2:addChild(var_25_16, 17)

	local var_25_17
	local var_25_18
	local var_25_19 = 0
	local var_25_20 = 0
	local var_25_21 = 0.6

	if var_25_8 < var_25_12 then
		local var_25_22 = ((var_25_8 > 5 and var_25_8 or 5) - var_25_12) * var_25_1.height - 1

		var_25_18 = ccp(0, var_25_22)

		var_25_15:setPosition(var_25_18)
	end

	if var_25_7 then
		if var_25_6 > 5 then
			var_25_19 = var_25_8 - var_25_10
		else
			var_25_19 = var_25_8 - 5
		end

		var_25_20 = var_25_19 * 0.15
		var_25_18 = ccp(0, -var_25_19 * var_25_1.height)

		var_25_15:runAction(var_25_4(var_25_21, CCMoveBy:create(var_25_20, var_25_18)))

		local var_25_23 = var_25_13[var_25_8]
		local var_25_24 = var_25_8 - var_25_10

		var_25_20 = var_25_24 * 0.15
		var_25_18 = ccp(0, var_25_24 * var_25_1.height)

		var_25_23:setZOrder(77)
		var_25_23:runAction(var_25_4(var_25_21, CCMoveBy:create(var_25_20, var_25_18)))
	else
		var_25_20 = var_25_3(var_25_8 - var_25_10, 4, 0.6)

		for iter_25_2 = var_25_10, var_25_8 do
			local var_25_25 = var_25_13[iter_25_2]

			if iter_25_2 < var_25_8 then
				var_25_18 = ccp(0, -var_25_1.height)
			else
				var_25_25:setZOrder(77)

				var_25_18 = ccp(0, (var_25_8 - var_25_10) * var_25_1.height)
			end

			local var_25_26 = var_25_4(var_25_21, CCMoveBy:create(var_25_20, var_25_18))

			var_25_25:runAction(var_25_26)
		end

		if var_25_8 > 5 then
			local var_25_27 = ((var_25_10 > 4 and var_25_10 or 5) - var_25_8) * var_25_1.height
			local var_25_28 = ccp(0, var_25_27)

			var_25_21 = var_25_21 + var_25_20

			var_25_15:runAction(var_25_4(var_25_21, CCMoveBy:create(var_25_20, var_25_28)))
		end
	end

	local var_25_29 = var_25_21 + var_25_20

	var_25_2:runAction(var_25_4(var_25_29, CCCallFunc:create(function()
		var_25_16:removeFromParent()

		return arg_25_3 and arg_25_3()
	end)))
end

function var_0_6.createLabel(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1.image or "ui/PK/PK_007.png"
	local var_29_1 = var_0_0.newLabel(arg_29_1)
	local var_29_2 = var_29_1:getContentSize()

	var_29_2.width = var_29_2.width + 20

	local var_29_3 = display.newScale9Sprite(var_29_0)
	local var_29_4 = var_29_3:getOriginalSize()

	if var_29_4.width < var_29_2.width then
		var_29_4.width = var_29_2.width

		var_29_3:setPreferredSize(var_29_4)
	end

	var_29_1:setPosition(var_29_4.width / 2, var_29_4.height / 2)
	var_29_3:addChild(var_29_1)

	var_29_3.label = var_29_1

	function var_29_3.setString(arg_30_0, arg_30_1)
		arg_30_0.label:setString(arg_30_1)
	end

	return var_29_3
end

function var_0_6.createPKDescView(arg_31_0)
	local var_31_0 = CCSize(475, 85)
	local var_31_1 = var_0_0.newNode()

	var_31_1:setContentSize(var_31_0)
	var_31_1:setAnchorPoint(ccp(0, 0))

	local var_31_2 = "#FFFF3C"
	local var_31_3 = "#FFFFFF"
	local var_31_4 = string.lf("等待 %s00:00%s 获得 %s0%s 积分", var_31_2, var_31_3, var_31_2, var_31_3)
	local var_31_5 = arg_31_0:createLabel({
		text = var_31_4
	})

	var_31_5:setPosition(230, 60)
	var_31_1:addChild(var_31_5)
	arg_31_0.model:bind("score_time|score_bonus", function(arg_32_0, arg_32_1)
		local var_32_0 = string.lf("等待 %s%s%s 获得 %s%s%s 积分", var_31_2, formatTime(arg_32_0, {
			hour = true
		}), var_31_3, var_31_2, arg_32_1 * 6 * 12, var_31_3)

		var_31_5:setString(var_32_0)
	end)

	local var_31_6 = arg_31_0:createLabel({
		image = "ui/team/team_016.png",
		text = string.lf("排名越高，积分越多，积分可以兑换各种奖品")
	})

	var_31_6:setAnchorPoint(ccp(0.5, 0))
	var_31_6:setPosition(var_31_0.width / 2, 0)
	var_31_1:addChild(var_31_6)
	print("adaptor", Adapter.WidthScale, Adapter.HeightScale)

	return var_31_1
end

function var_0_6.createPKScoreView(arg_33_0)
	local var_33_0 = CCSize(485, 40)
	local var_33_1 = var_0_0.newNode()

	var_33_1:setContentSize(var_33_0)
	var_33_1:setAnchorPoint(ccp(0, 0))

	local var_33_2 = "#FFFF3C"
	local var_33_3 = "#FFFFFF"
	local var_33_4 = arg_33_0:createLabel({
		text = string.lf("当前积分 0")
	})

	var_33_4:setPosition(340, var_33_0.height / 2)
	var_33_1:addChild(var_33_4)
	arg_33_0.model:bind("score_value", function(arg_34_0, arg_34_1)
		local var_34_0 = string.lf("当前积分 %s%s", var_33_2, arg_34_0)

		var_33_4:setString(var_34_0)

		if arg_34_1 then
			var_33_4.label:runAction(CCBlink:create(0.5, 3))
		end
	end)

	local var_33_5 = arg_33_0:createLabel({
		text = string.lf("挑战次数已恢复满")
	})

	var_33_5:setPosition(150, var_33_0.height / 2)
	var_33_1:addChild(var_33_5)
	arg_33_0.model:bind("battle_time", function(arg_35_0)
		local var_35_0

		if arg_35_0 > 0 then
			var_35_0 = string.lf("恢复时间 %s%s", var_33_2, formatTime(arg_35_0))
		else
			var_35_0 = string.lf("挑战次数已恢复满")
		end

		var_33_5:setString(var_35_0)
	end)

	local var_33_6 = arg_33_0:createLabel({
		text = string.lf("挑战次数 0")
	})

	var_33_6:setPosition(-30, var_33_0.height / 2)
	var_33_1:addChild(var_33_6)
	arg_33_0.model:bind("battle_count", function(arg_36_0)
		local var_36_0 = string.lf("挑战次数 %s%s", var_33_2, arg_36_0)

		var_33_6:setString(var_36_0)
	end)

	return var_33_1
end

function var_0_6.createPKToolbar(arg_37_0)
	local var_37_0 = CCSize(95, 290)
	local var_37_1 = CCNode:create()

	var_37_1:setContentSize(var_37_0)
	var_37_1:setAnchorPoint(ccp(0, 0))

	local function var_37_2(arg_38_0)
		arg_37_0.model:set("score_value", arg_38_0)
	end

	local var_37_3 = ui.newControlButton({
		normalImage = "ui/PK/PK_057.png",
		clickAction = function()
			local var_39_0 = require("scenes.PK.PkRewardLayer").new({
				currentScore = arg_37_0.model:get("score_value"),
				scoreCallback = var_37_2
			})

			arg_37_0:addChild(var_39_0)
			arg_37_0:hideGuideLayer()
		end
	})
	local var_37_4 = ui.newControlButton({
		normalImage = "ui/PK/PK_009.png",
		clickAction = function()
			local var_40_0 = require("scenes.PK.DlgRankLayer").new({
				type = DlgRankType.rankArena,
				closecallback = function()
					arg_37_0.model.rankLayer = false
				end
			})

			arg_37_0:addChild(var_40_0)

			arg_37_0.model.rankLayer = true

			arg_37_0:hideGuideLayer()
		end
	})
	local var_37_5 = ui.newControlButton({
		normalImage = "ui/PK/PK_010.png",
		clickAction = function()
			local var_42_0 = require("scenes.PK.PkExchangeLayer").new({
				currentRank = arg_37_0.model.rank,
				currentScore = arg_37_0.model:get("score_value"),
				scoreCallback = var_37_2
			})

			arg_37_0:addChild(var_42_0)
			arg_37_0:hideGuideLayer()
		end
	})

	var_37_3:setPosition(var_37_0.width / 2, 310)
	var_37_4:setPosition(var_37_0.width / 2, 215)
	var_37_5:setPosition(var_37_0.width / 2, 120)
	var_37_1:addChild(var_37_4)
	var_37_1:addChild(var_37_3)
	var_37_1:addChild(var_37_5)

	if IPlatform:instance():getConfig("Channel") == "ZSY_TW" then
		local var_37_6 = ui.newControlButton({
			normalImage = "uilocal/PK/PK_text_048.png",
			clickAction = function()
				local var_43_0 = require("scenes.PK.LimitRankLayer").new({
					currentRank = arg_37_0.model.rank
				})

				arg_37_0:addChild(var_43_0)
				arg_37_0:hideGuideLayer()
			end
		})

		var_37_6:setPosition(var_37_0.width / 2, 405)
		var_37_1:addChild(var_37_6)
	end

	return var_37_1
end

function var_0_6.createHeroNode(arg_44_0)
	local var_44_0 = CCSize(365, 445)
	local var_44_1 = CCNode:create()

	var_44_1:setContentSize(var_44_0)

	local var_44_2
	local var_44_3
	local var_44_4
	local var_44_5 = Player.team.groupList
	local var_44_6 = var_44_5[Player.headerTeamIndex] or var_44_5[1]

	if not var_44_6 then
		return var_44_1
	end

	for iter_44_0, iter_44_1 in ipairs(var_44_6.equipList) do
		if BaseEquips[iter_44_1.equipId].equipType == EquipType.eWeapon then
			var_44_3 = iter_44_1.equipId
			var_44_4 = iter_44_1.pinJie

			break
		end
	end

	local var_44_7 = {
		isViewBaseInfo = false,
		isViewQuality = false,
		scale = 0.9,
		figId = var_44_6.heroId,
		equipId = var_44_3,
		pinjie = var_44_4,
		clickAction = function()
			print("clickedFunc")
		end
	}
	local var_44_8 = figure.createHero(var_44_7)

	var_44_8:setPosition(var_44_0.width / 2, 65)
	var_44_1:addChild(var_44_8)

	local var_44_9 = display.newSprite("ui/PK/PK_006.png")

	var_44_9:setPosition(110, 430)
	var_44_1:addChild(var_44_9)

	local var_44_10 = CCLabelAtlas:create("0", "uilocal/PK/PK_text_004.png", 35, 53, 48)

	var_44_10:setAnchorPoint(ccp(0.5, 0.5))
	var_44_10:setPosition(40, 35)
	var_44_9:addChild(var_44_10)
	arg_44_0.model:bind("streak", function(arg_46_0)
		var_44_10:setString(arg_46_0)
		var_44_9:setVisible(arg_46_0 > 0)
	end)

	local var_44_11 = display.newSprite("ui/team/team_001.png")

	var_44_11:setPosition(var_44_0.width / 2, 60)
	var_44_1:addChild(var_44_11)

	local var_44_12 = var_44_11:getContentSize()
	local var_44_13 = var_0_0.newLabel({
		size = 24,
		text = Player.nickName,
		font = _FONT_DEFAULT,
		color = ccc3(230, 210, 60)
	})

	var_44_13:setPosition(var_44_12.width / 2, var_44_12.height / 2)
	var_44_11:addChild(var_44_13)

	local var_44_14 = display.newSprite("ui/common/common_067.png")

	var_44_14:setPosition(var_44_0.width / 2, 20)
	var_44_1:addChild(var_44_14)

	local var_44_15 = var_44_14:getContentSize()
	local var_44_16 = CCLabelAtlas:create(tostring(Player.team.battlePower), "ui/home/home_000_small.png", 22, 33, 48, 6)

	var_44_16:setAnchorPoint(ccp(0, 0.5))
	var_44_16:setPosition(var_44_15.width / 2 - 10, var_44_15.height / 2)
	var_44_14:addChild(var_44_16)

	return var_44_1
end

function var_0_6.createRankView(arg_47_0)
	local var_47_0 = CCSize(490, 97)
	local var_47_1 = CCSize(490, 640)
	local var_47_2 = CCNode:create()

	var_47_2:setContentSize(var_47_1)

	local var_47_3 = var_0_0.newLabel({
		size = 28,
		text = string.lf("排名"),
		font = _FONT_DEFAULT,
		color = ccc3(254, 254, 144)
	})
	local var_47_4 = var_0_0.newLabel({
		size = 28,
		text = string.lf("玩家信息"),
		font = _FONT_DEFAULT,
		color = ccc3(254, 254, 144)
	})
	local var_47_5 = display.newSprite("ui/PK/PK_004.png")

	var_47_5:setAnchorPoint(ccp(0.5, 1))
	var_47_5:setPosition(var_47_0.width / 2, var_47_0.height + 485)
	var_47_3:setPosition(50, 600)
	var_47_4:setPosition(200, 600)
	var_47_2:addChild(var_47_3)
	var_47_2:addChild(var_47_4)
	var_47_2:addChild(var_47_5)

	local var_47_6 = {
		direction = kCCScrollViewDirectionVertical,
		size = CCSize(490, 484),
		sizehandler = function(arg_48_0, arg_48_1)
			return CCSize(490, 97)
		end,
		cellhandler = handler(arg_47_0, arg_47_0.createRankItem)
	}
	local var_47_7 = createTableView(var_47_6)

	var_47_7:setPosition(0, 0)
	var_47_2:addChild(var_47_7)

	arg_47_0.boss.parent = var_47_2
	arg_47_0.tableview = var_47_7

	local var_47_8 = arg_47_0

	var_47_2.boss = var_47_5

	function var_47_2.reloadBoss(arg_49_0, arg_49_1)
		local var_49_0 = arg_49_0.boss
		local var_49_1 = var_47_8:createRankItem(1, 1, arg_49_1)

		var_49_1:setAnchorPoint(ccp(0.5, 1))
		var_49_1:setPosition(245, 92)
		var_49_0:removeAllChildrenWithCleanup(true)
		var_49_0:addChild(var_49_1)
	end

	return var_47_2
end

function var_0_6.createRankItem(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	local var_50_0 = CCSize(480, 97)
	local var_50_1 = CCNode:create()

	var_50_1:setContentSize(var_50_0)

	if not arg_50_3 then
		return var_50_1
	end

	local var_50_2 = arg_50_3.PlayerId
	local var_50_3 = arg_50_3.PlayerName
	local var_50_4 = arg_50_3.Avatar
	local var_50_5 = arg_50_3.Ranking
	local var_50_6 = arg_50_3.Level
	local var_50_7 = arg_50_3.Fighting
	local var_50_8 = arg_50_3.ScorePerTime
	local var_50_9 = arg_50_0.model.rank
	local var_50_10 = 20
	local var_50_11
	local var_50_12
	local var_50_13
	local var_50_14 = CCSize(110, 95)
	local var_50_15 = CCNode:create()

	var_50_15:setContentSize(var_50_14)
	var_50_1:addChild(var_50_15)

	if var_50_5 == 1 then
		var_50_13 = ccc3(255, 255, 255)
		var_50_11 = display.newSprite("uilocal/PK/PK_text_001.png")
	else
		var_50_13 = ccc3(254, 254, 144)
		var_50_11 = CCLabelAtlas:create(var_50_5, "uilocal/PK/PK_text_005.png", 27, 37, 48)

		if var_50_5 > 9999 then
			var_50_11:setScale(0.75)
		end
	end

	var_50_11:setAnchorPoint(ccp(0.5, 0.5))
	var_50_11:setPosition(var_50_14.width / 2, var_50_14.height / 2)
	var_50_15:addChild(var_50_11)

	local function var_50_16(arg_51_0, arg_51_1)
		if arg_50_0.model:get("battle_count") > 0 then
			arg_50_0:startBattle(var_50_5, var_50_3)
		else
			var_0_1.createDialog({
				show = var_0_1.eShowChallenge,
				callback = function(arg_52_0, arg_52_1)
					if arg_52_0 then
						arg_50_0:startBattle(var_50_5, var_50_3)
					end
				end
			}):show()
		end
	end

	if var_50_2 == tostring(Player.userId) then
		local var_50_17 = var_50_5 ~= 1 and "ui/PK/PK_005.png" or "ui/PK/PK_004.png"
		local var_50_18 = display.newSprite(var_50_17)

		var_50_18:setPosition(var_50_0.width / 2, var_50_0.height / 2)
		var_50_1:addChild(var_50_18)
	end

	local var_50_19
	local var_50_20
	local var_50_21

	if var_50_5 == 1 and var_50_9 > 10 then
		var_50_21 = ui.newControlButton({
			normalImage = "ui/common/common_073.png",
			titleImage = "uilocal/PK/PK_text_002.png",
			clickAction = function(arg_53_0, arg_53_1)
				OthersTeamHelper:checkOthersTeam(var_50_2, var_50_3, OthersTeamHelper.eDataFromPK)
			end
		})
	elseif var_50_5 ~= var_50_9 then
		var_50_21 = ui.newControlButton({
			normalImage = "ui/common/common_073.png",
			titleImage = "uilocal/PK/PK_text_003.png",
			clickAction = var_50_16
		})
	end

	local var_50_22 = var_0_0.newLabel({
		text = string.lf("积分：%d", var_50_8 * 72),
		size = var_50_10,
		color = var_50_13
	})

	var_50_22:setAnchorPoint(ccp(0, 0.5))
	var_50_22:setPosition(220, 45)
	var_50_1:addChild(var_50_22)

	local var_50_23 = var_0_0.newLabel({
		text = string.lf("战力：%d", var_50_7),
		size = var_50_10,
		color = var_50_13
	})

	var_50_23:setAnchorPoint(ccp(0, 0.5))
	var_50_23:setPosition(240, 20)
	var_50_1:addChild(var_50_23)

	if var_50_21 then
		var_50_21:setPosition(430, 48)
		var_50_1:addChild(var_50_21)
	end

	local var_50_24 = arg_50_0:createHeaderView(arg_50_3)

	var_50_24:setPosition(150, 48)
	var_50_1:addChild(var_50_24)

	local var_50_25 = var_0_0.newLabel({
		text = string.lf("%s  %d级", var_50_3, var_50_6),
		font = _FONT_DEFAULT,
		size = var_50_10,
		color = var_50_13
	})

	var_50_25:setAnchorPoint(ccp(0, 0.5))
	var_50_25:setPosition(200, 70)
	var_50_1:addChild(var_50_25)

	local var_50_26 = display.newSprite("ui/transport/transport_019.png")

	var_50_26:setAnchorPoint(ccp(0.5, 0))
	var_50_26:setPosition(var_50_0.width / 2, 0)
	var_50_1:addChild(var_50_26)

	return var_50_1
end

function var_0_6.createHeaderView(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0 = arg_54_1.PlayerId
	local var_54_1 = arg_54_1.PlayerName
	local var_54_2 = arg_54_1.Avatar or 401

	if var_54_2 == 0 then
		var_54_2 = 401
	end

	arg_54_2 = arg_54_2 or 1

	local var_54_3 = CCSize(82 * arg_54_2, 82 * arg_54_2)
	local var_54_4 = CCScale9Sprite:create("ui/common/bg_common.png")

	var_54_4:setPreferredSize(var_54_3)

	local var_54_5 = ui.newControlButton({
		scaleX = arg_54_2,
		scaleY = arg_54_2,
		normalImage = getItemHeaderImagePath(ItemType.eHero, var_54_2),
		clickAction = function()
			OthersTeamHelper:checkOthersTeam(var_54_0, var_54_1, OthersTeamHelper.eDataFromPK)
		end
	})

	var_54_5:setPosition(var_54_3.width / 2, var_54_3.height / 2)
	var_54_4:addChild(var_54_5)

	return var_54_4
end

function var_0_6.startBattle(arg_56_0, arg_56_1, arg_56_2)
	BattleOperator:startBattle(eBattleType.Challenge, {
		rank = arg_56_1,
		rival = arg_56_2
	}, function(arg_57_0, arg_57_1)
		game.enterPKScene()
	end)
	GuideLayer:stepDone(TaskEntryType.eEntryDuelDefeat, 3)
	arg_56_0:hideGuideLayer()
end

function var_0_6.showNoticeView(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_0.container
	local var_58_1 = var_0_2.new()
	local var_58_2 = var_58_0:getContentSize()

	var_58_1:init(CCPoint(var_58_2.width / 2 + 220, var_58_2.height - 80))

	for iter_58_0, iter_58_1 in ipairs(arg_58_1) do
		var_58_1:addNotice({
			repeatNumber = 2,
			string = string.lf("#FFFF3C%s#FFFFFF 在九天争霸上连败 #FFFF3C%s#FFFFFF 名高手", iter_58_1.PlayerName, iter_58_1.ContinumeTime)
		})
	end

	var_58_0:addChild(var_58_1)
	var_58_1:start()
end

function var_0_6.showGuideLayer(arg_59_0)
	GuideLayer:stepDone(TaskEntryType.eEntryDuelDefeat, 2)
	GuideLayer:showGuideLayer(arg_59_0, arg_59_0.rankview, TaskEntryType.eEntryDuelDefeat, 3, nil, true)
end

function var_0_6.hideGuideLayer(arg_60_0)
	GuideLayer:removeGuideLayer(arg_60_0, TaskEntryType.eEntryDuelDefeat, 3)
end

return var_0_6
