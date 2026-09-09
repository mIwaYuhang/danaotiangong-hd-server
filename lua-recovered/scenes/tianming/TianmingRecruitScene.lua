require("data.tianming")
require("network.TianmingRequest")

local var_0_0 = require("scenes.toollayer.tool")
local var_0_1 = require("scenes.ToolLayer")
local var_0_2 = require("base.cache")
local var_0_3 = require("scenes.toollayer.ctrl")
local var_0_4 = require("scenes.toollayer.model"):extend({
	showConjureBox = true,
	resolveLimit = QualityType.ePurple,
	ctor = function(arg_1_0)
		arg_1_0:set("ids", NULL)
		arg_1_0:set("types", NULL)
		arg_1_0:set("cost", 0)
		arg_1_0:set("count", 0)
		arg_1_0:set("callTime", 0)
	end,
	attach = function(arg_2_0, arg_2_1)
		arg_2_0.request = TianmingRequest:new(arg_2_1)

		arg_2_0.request:setResponseNormalHandler(function()
			local var_3_0, var_3_1 = arg_2_0.request:getResponseContent()

			if var_3_0 == TianmingRequest.eInfo then
				local var_3_2 = var_3_1.rewards
				local var_3_3 = var_3_1.hunts
				local var_3_4 = var_3_1.huntIDs
				local var_3_5 = var_3_1.call

				arg_2_0.hunts = var_3_3

				arg_2_0:set("ids", var_3_2)
				arg_2_0:set("types", var_3_4)
				arg_2_0:set("cost", var_3_5.ingot)
				arg_2_0:set("count", var_3_5.remainCallTime)
				arg_2_0:set("callTime", var_3_5.callTime)
				arg_2_0:trigger("sync")
			elseif var_3_0 == TianmingRequest.eHunt then
				if arg_2_0.huntType == 2 and arg_2_0.huntValue == 4 then
					arg_2_0:set("callTime", arg_2_0:get("callTime") + 1)
				end

				local var_3_6 = var_3_1.Reward
				local var_3_7 = var_3_1.huntIDs
				local var_3_8 = var_3_1.huntRewards
				local var_3_9 = var_3_1.call
				local var_3_10 = arg_2_0:get("ids")

				if var_3_9 then
					arg_2_0:set("cost", var_3_9.ingot)
					arg_2_0:set("count", var_3_9.remainCallTime)
				end

				arg_2_0:set("types", var_3_7)

				for iter_3_0, iter_3_1 in ipairs(var_3_8) do
					if iter_3_1.Type == ItemType.eTianMing then
						table.insert(var_3_10, iter_3_1.ID)
						arg_2_0:trigger("hunt", iter_3_1.ID)

						if BaseTianMings[iter_3_1.ID].type == TianMingType.eType7 then
							arg_2_1:showGuideLayer(3)
						end
					else
						arg_2_1:showGuideLayer(3)
						arg_2_0:trigger("reward", iter_3_1)
					end
				end
			elseif var_3_0 == TianmingRequest.eHuntAll then
				var_0_0.foreach(var_3_1, function(arg_4_0, arg_4_1, arg_4_2)
					local var_4_0 = arg_4_1.huntRewards
					local var_4_1 = arg_4_1.huntIDs
					local var_4_2 = arg_2_0:get("ids")

					for iter_4_0, iter_4_1 in ipairs(var_4_0) do
						if iter_4_1.Type == ItemType.eTianMing then
							table.insert(var_4_2, iter_4_1.ID)
							arg_2_0:trigger("hunt", iter_4_1.ID, arg_4_2)
						else
							arg_2_0:trigger("reward", iter_4_1, arg_4_2)
						end
					end

					arg_2_0:set("types", var_4_1)
				end, function()
					arg_2_0:trigger("huntAll")
				end)
			elseif var_3_0 == TianmingRequest.eResolve then
				local var_3_11 = arg_2_0:get("ids")
				local var_3_12 = arg_2_0.resolveValue

				table.remove(var_3_11, var_3_12)
				arg_2_0:trigger("resolve", arg_2_0.resolveValue)
			elseif var_3_0 == TianmingRequest.eCollect then
				local var_3_13 = arg_2_0:get("ids")
				local var_3_14 = arg_2_0.collectValue

				table.remove(var_3_13, var_3_14)
				arg_2_0:trigger("collect", arg_2_0.collectValue)
			elseif var_3_0 == TianmingRequest.eSelect then
				arg_2_0.selectValue = arg_2_0:get("filter")

				arg_2_0.request:requestResolveBatch()
			elseif var_3_0 == TianmingRequest.eReBatch then
				local var_3_15 = arg_2_0:get("ids")

				var_0_0.foreach(var_3_15, function(arg_6_0, arg_6_1, arg_6_2)
					if arg_2_0:resolveFilter(arg_6_1) then
						table.remove(var_3_15, arg_6_0)
						arg_2_0:trigger("resolve", arg_6_0, arg_6_2)
					else
						arg_6_2()
					end
				end, function()
					arg_2_0:trigger("resolveBatch")
				end, true)
			end
		end)
		arg_2_0.request:setResponseExceptionHandler(function()
			arg_2_0.dirty = true

			print("处理请求发生错误")
		end)
	end,
	sync = function(arg_9_0)
		if arg_9_0.dirty then
			arg_9_0:requestInfo()
		else
			arg_9_0:trigger("sync", arg_9_0)
		end
	end,
	maxHunt = function(arg_10_0)
		local var_10_0 = arg_10_0:get("types")
		local var_10_1 = 1

		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			var_10_1 = math.max(var_10_1, iter_10_1)
		end

		return var_10_1
	end,
	resolveFilter = function(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_0.resolveLimit
		local var_11_1 = BaseTianMings[arg_11_1]
		local var_11_2 = var_11_1.type

		if var_11_0 > var_11_1.quality or var_11_2 == TianMingType.eType7 then
			return true
		else
			return false
		end
	end,
	requestInfo = function(arg_12_0)
		arg_12_0.request:requestInfo()
	end,
	requestHunt = function(arg_13_0, arg_13_1, arg_13_2)
		if #arg_13_0:get("ids") < 14 then
			local var_13_0

			if arg_13_2 then
				var_13_0 = arg_13_0.hunts[arg_13_2].gold
			else
				var_13_0 = arg_13_0:maxHunt()
				var_13_0 = arg_13_0.hunts[var_13_0].gold
			end

			if arg_13_1 == 2 then
				local var_13_1 = arg_13_0:get("types")

				table.insert(var_13_1, arg_13_2)
				arg_13_0:trigger("change:types", var_13_1)
			elseif var_13_0 > Player.curCoin then
				arg_13_0:trigger("error", "coin")

				return
			end

			arg_13_0.huntValue = arg_13_2
			arg_13_0.huntType = arg_13_1
			arg_13_0.request.isNoticeReward = false

			arg_13_0.request:requestHunt(arg_13_1, arg_13_2)
		else
			arg_13_0:trigger("error", "full")
		end
	end,
	requestResolve = function(arg_14_0, arg_14_1)
		arg_14_0.resolveValue = arg_14_1
		arg_14_0.request.isNoticeReward = true

		arg_14_0.request:requestResolve(1, arg_14_1)
	end,
	requestCollect = function(arg_15_0, arg_15_1)
		arg_15_0.collectValue = arg_15_1

		arg_15_0.request:requestCollect(arg_15_1)
	end,
	requestResolveBatch = function(arg_16_0)
		arg_16_0.request.isNoticeReward = true

		arg_16_0.request:requestResolveBatch()
	end
})
local var_0_5 = class("TianmingRecruitScene", function()
	return display.newScene("TianmingRecruitScene")
end)

function var_0_5.ctor(arg_18_0, arg_18_1)
	arg_18_0.wideScreen = Adapter.AutoScaleX > Adapter.AutoScaleY
	arg_18_0.narrowScreen = Adapter.AutoScaleX < Adapter.AutoScaleY
	arg_18_0.index = 1
	arg_18_0.hunts = {}
	arg_18_0.nodes = {}
	arg_18_0.cells = {}
	arg_18_0.model = var_0_2.get(arg_18_0)

	if not arg_18_0.model then
		arg_18_0.model = var_0_4:new()

		var_0_2.set(arg_18_0, arg_18_0.model)
	end

	arg_18_0.model:attach(arg_18_0)
	arg_18_0:initRequests()
	arg_18_0:onEnterAlias()
end

function var_0_5.showGuideLayer(arg_19_0, arg_19_1, ...)
	if Player:getCurrentTaskEntryType() ~= TaskEntryType.eTianMing then
		return
	end

	local var_19_0 = 0
	local var_19_1 = 0

	if arg_19_1 == 3 then
		local var_19_2 = arg_19_0.hunts[arg_19_0.model:maxHunt()]

		var_19_0, var_19_1 = var_0_3.getPosition(var_19_2, arg_19_0.container)
		var_19_1 = var_19_1 + 30
	elseif arg_19_1 == 4 then
		for iter_19_0, iter_19_1 in ipairs(arg_19_0.cells) do
			if BaseTianMings[iter_19_1.tianming.id].type ~= TianMingType.eType7 then
				var_19_0, var_19_1 = var_0_3.getPosition(arg_19_0.nodes[iter_19_0], arg_19_0.container)
				var_19_1 = var_19_1 - 30

				break
			end
		end
	elseif arg_19_1 == 5 then
		local var_19_3 = unpack(...)

		var_19_0, var_19_1 = var_0_3.getPosition(var_19_3, arg_19_0.container)
		var_19_0 = var_19_0 + 90
		var_19_1 = var_19_1 + 55
	elseif arg_19_1 == 6 then
		var_19_0, var_19_1 = var_0_3.getPosition(arg_19_0.btnBag, arg_19_0.container)
		var_19_0 = var_19_0 + 65
	end

	GuideLayer:showGuideLayer(arg_19_0, arg_19_0.container, TaskEntryType.eTianMing, arg_19_1, ccp(var_19_0, var_19_1), true)
end

function var_0_5.onEnterAlias(arg_20_0)
	local var_20_0 = Adapter.AutoScaleY
	local var_20_1 = display.newSprite("ui/tianming/tianming_000.jpg")
	local var_20_2 = var_20_1:getContentSize()

	var_20_1:setPosition(display.cx, display.cy)
	var_20_1:setScale(var_20_0)
	arg_20_0:addChild(var_20_1)

	local var_20_3 = math.min(var_20_2.width * var_20_0, display.width) / var_20_0
	local var_20_4 = math.min(var_20_2.height * var_20_0, display.height) / var_20_0
	local var_20_5 = CCSize(var_20_3, var_20_4)
	local var_20_6 = CCNode:create()

	var_20_6:setContentSize(var_20_5)

	local var_20_7 = (var_20_2.width - var_20_5.width) / 2
	local var_20_8 = (var_20_2.height - var_20_5.height) / 2

	var_20_6:setPosition(var_20_7, var_20_8)
	var_20_1:addChild(var_20_6)

	arg_20_0.container = var_20_6

	local var_20_9 = ui.newControlButton({
		normalImage = "ui/common/common_061.png",
		clickAction = function()
			game.enterHomeScene({
				showSubLayer = ShowSubLayerType.eCopyHome
			})
		end
	})

	var_20_9:setPosition(var_20_5.width - 55, var_20_5.height - 35)
	var_20_6:addChild(var_20_9)

	local function var_20_10()
		local var_22_0 = require("scenes.enhance.DlgRuleLayer").new({
			ruleType = DlgRuleType.ruleTianming
		})

		CCDirector:sharedDirector():getRunningScene():addChild(var_22_0)
	end

	local var_20_11 = ui.newControlButton({
		normalImage = "ui/enhance/enhance_015.png",
		highlightedImage = "ui/enhance/enhance_015.png",
		scaleX = 0.8,
		scaleY = 0.8,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = handler(arg_20_0, var_20_10),
		position = ccp(var_20_5.width - 55, var_20_5.height - 390),
		fontSize = ColorTable.eTitleButton_FontSize
	})

	var_20_6:addChild(var_20_11, 1)

	local var_20_12 = createPlayerAttrNode({
		ItemType.eGold,
		ItemType.eCoin,
		ItemType.eTianMingExp,
		ItemType.eTianMingFrag
	})

	var_20_12:setPosition(30, 578)
	arg_20_0.container:addChild(var_20_12)

	arg_20_0.attrsNode = var_20_12

	local var_20_13 = 1
	local var_20_14 = ui.newControlButton({
		normalImage = "uilocal/tianming/tianming_text_002.png",
		scaleX = var_20_13,
		scaleY = var_20_13,
		clickAction = function()
			if arg_20_0.model:maxHunt() == 5 then
				showFlashNotice(string.lf("激活最高级天命官，去试试运气吧"))
			else
				arg_20_0:blockTouch(true)
				arg_20_0.model:requestHunt()
			end
		end
	})

	var_20_14:setPosition(60, 520)
	var_20_6:addChild(var_20_14)

	arg_20_0.btnConjure = var_20_14

	local var_20_15 = ui.newControlButton({
		normalImage = "uilocal/tianming/tianming_text_003.png",
		scaleX = var_20_13,
		scaleY = var_20_13,
		clickAction = function()
			local var_24_0 = 0
			local var_24_1 = arg_20_0.model:get("ids")

			for iter_24_0, iter_24_1 in ipairs(var_24_1) do
				if arg_20_0.model:resolveFilter(iter_24_1) then
					var_24_0 = var_24_0 + 1
				end
			end

			if var_24_0 > 0 then
				arg_20_0:blockTouch(true)
				arg_20_0.model:requestResolveBatch()
			end
		end
	})

	var_20_15:setPosition(60, 440)
	var_20_6:addChild(var_20_15)

	arg_20_0.btnResolve = var_20_15

	local var_20_16 = ui.newControlButton({
		normalImage = "uilocal/tianming/tianming_text_001.png",
		scaleX = var_20_13,
		scaleY = var_20_13,
		clickAction = function()
			GuideLayer:stepDone(TaskEntryType.eTianMing, 6)
			GuideLayer:stepDone(TaskEntryType.eTianMingGu, 3)
			game.enterTianmingScene({})
		end
	})

	var_20_16:setPosition(60, 360)
	var_20_6:addChild(var_20_16)

	arg_20_0.btnBag = var_20_16

	local function var_20_17(arg_26_0, arg_26_1)
		GuideLayer:stepDone(TaskEntryType.eTianMingGu, 3)

		local var_26_0 = require("scenes.tianming.TianmingGuLayer").new()

		arg_20_0:addChild(var_26_0)
	end

	arg_20_0.btnTianMingGu = ui.newControlButton({
		normalImage = "uilocal/tianming/tianming_text_026.png",
		position = ccp(61, 280),
		clickAction = var_20_17
	})

	var_20_6:addChild(arg_20_0.btnTianMingGu)

	local var_20_18 = ui.newControlButton({
		normalImage = "ui/common/common_110.png",
		titleImage = "uilocal/tianming/tianming_text_009.png",
		clickAction = function()
			local var_27_0 = require("scenes.tianming.TianmingExchangeLayer").new()

			arg_20_0:addChild(var_27_0)
		end
	})

	var_20_18:setPosition(var_20_5.width - 200, 260)
	var_20_6:addChild(var_20_18)

	local var_20_19 = ui.newControlButton({
		normalImage = "ui/common/common_110.png",
		titleImage = "ui/peach/peach_7.png",
		clickAction = function()
			if isMoneyEnough(MoneyType.eCoin, 1000000) == false then
				return
			end

			arg_20_0.infoMillionHuntRequest:request(1)
		end
	})

	var_20_19:setPosition(var_20_5.width - 600, 260)
	var_20_6:addChild(var_20_19)

	local var_20_20 = ui.newControlButton({
		normalImage = "ui/common/common_110.png",
		titleImage = "ui/peach/peach_6.png",
		clickAction = function()
			if isMoneyEnough(MoneyType.eCoin, 10000000) == false then
				return
			end

			arg_20_0.infoMillionHuntRequest:request(2)
		end
	})

	var_20_20:setPosition(var_20_5.width - 400, 260)
	var_20_6:addChild(var_20_20)

	local var_20_21 = arg_20_0:createZodiacView()

	var_20_21:setPosition(var_20_5.width / 2, 120)
	var_20_6:addChild(var_20_21)

	arg_20_0.zodiacView = var_20_21
	arg_20_0.labelFirst = addLabelWithColorSize(var_20_21, string.lf("每日首次使用元宝猎天命必定点亮亢金龙"), ccc3(227, 208, 0), 24, ccp(0.5, 0), ccp(var_20_21:getContentSize().width / 2, var_20_21:getContentSize().height + 8))

	arg_20_0.labelFirst:setVisible(false)

	local var_20_22 = arg_20_0:createCellView()

	var_20_22:setAnchorPoint(ccp(0.5, 0.5))
	var_20_22:setPosition(var_20_5.width / 2 + 50, 430)
	var_20_6:addChild(var_20_22)

	arg_20_0.cellView = var_20_22

	arg_20_0.model:on("resolveBatch", arg_20_0.onResolveBatch, arg_20_0)
	arg_20_0.model:on("error", arg_20_0.onHuntError, arg_20_0)
	arg_20_0.model:on("huntAll", arg_20_0.onHuntAll, arg_20_0)
	arg_20_0.model:on("reward", arg_20_0.onReward, arg_20_0)
	arg_20_0.model:on("hunt", arg_20_0.onHunt, arg_20_0)
	arg_20_0.model:on("sync", arg_20_0.onSync, arg_20_0)
	arg_20_0.model:on("resolve", arg_20_0.onResolve, arg_20_0)
	arg_20_0.model:on("collect", arg_20_0.onCollect, arg_20_0)
	arg_20_0.model:sync()
end

function var_0_5.onExit(arg_30_0)
	arg_30_0.model:detach()
end

function var_0_5.onSync(arg_31_0)
	local var_31_0 = arg_31_0.model.hunts
	local var_31_1 = arg_31_0.hunts

	for iter_31_0 = 1, #var_31_1 do
		var_31_1[iter_31_0].price:setValue(var_31_0[iter_31_0].gold)
	end

	local var_31_2 = arg_31_0.model:get("ids")

	for iter_31_1, iter_31_2 in ipairs(var_31_2) do
		arg_31_0:addTianming(iter_31_2)
	end

	if arg_31_0.model:get("callTime") == 0 then
		arg_31_0.labelFirst:setVisible(true)
	end

	GuideLayer:stepDone(TaskEntryType.eTianMing, 2)
	GuideLayer:stepDone(TaskEntryType.eTianMingGu, 2)
	arg_31_0:showGuideLayer(3)

	local var_31_3, var_31_4 = var_0_3.getPosition(arg_31_0.btnTianMingGu, arg_31_0.container)
	local var_31_5 = var_31_3 + 65

	GuideLayer:showGuideLayer(arg_31_0, arg_31_0.container, TaskEntryType.eTianMingGu, 3, ccp(var_31_5, var_31_4), true)
end

function var_0_5.onReward(arg_32_0, arg_32_1, arg_32_2)
	var_0_1.createToast({
		show = var_0_1.eShowReward,
		rewards = {
			arg_32_1
		}
	}):show()

	local var_32_0 = arg_32_0.cellView
	local var_32_1
	local var_32_2
	local var_32_3
	local var_32_4, var_32_5 = var_0_3.getPosition(arg_32_0.attrsNode, arg_32_0.cellView)
	local var_32_6 = var_32_5 + 10
	local var_32_7

	if arg_32_1.Type == ItemType.eCoin then
		var_32_4 = var_32_4 + 290
		var_32_7 = "prop/small_yinbia.png"
	else
		var_32_4 = var_32_4 + 640
		var_32_7 = "prop/small_tianming.png"
	end

	local var_32_8, var_32_9 = arg_32_0:fromPosition()
	local var_32_10 = display.newSprite(var_32_7)

	var_32_10:setScale(0.5)
	var_32_10:setPosition(var_32_8, var_32_9)
	var_32_0:addChild(var_32_10)

	local var_32_11 = arg_32_0:createParticleFire()

	var_32_11:setPosition(43, 43)
	var_32_10:addChild(var_32_11, -1)

	local var_32_12 = arg_32_0:createActions({
		delay = 0.15,
		duration = 0.4,
		moveTo = ccp(var_32_4, var_32_6),
		nextcall = arg_32_2,
		callback = function()
			var_32_10:removeFromParent()
		end
	})

	var_32_10:runAction(var_32_12)

	if arg_32_0.model:get("callTime") == 0 then
		arg_32_0.labelFirst:setVisible(true)
	else
		arg_32_0.labelFirst:setVisible(false)
	end
end

function var_0_5.onHunt(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_0.container
	local var_34_1 = arg_34_0:addTianming(arg_34_1)
	local var_34_2, var_34_3 = arg_34_0:fromPosition()
	local var_34_4, var_34_5 = var_34_1:getPosition()
	local var_34_6 = arg_34_0:createParticleFire()

	var_34_6:setPosition(43, 43)
	var_34_1:addChild(var_34_6, -1)
	var_34_1:setPosition(var_34_2, var_34_3)

	local var_34_7 = arg_34_0:createActions({
		delay = 0.2,
		duration = 0.4,
		moveTo = ccp(var_34_4, var_34_5),
		nextcall = arg_34_2,
		callback = function()
			GuideLayer:stepDone(TaskEntryType.eTianMing, 3)
			arg_34_0:showGuideLayer(4)
			var_34_6:removeFromParent()
		end
	})

	var_34_1:runAction(var_34_7)
end

function var_0_5.onResolve(arg_36_0, arg_36_1, arg_36_2)
	arg_36_0:CollectOrResolve(false, arg_36_1, arg_36_2)
end

function var_0_5.onCollect(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0:CollectOrResolve(true, arg_37_1, arg_37_2)
end

function var_0_5.onHuntError(arg_38_0, arg_38_1)
	arg_38_0:blockTouch(false)

	if arg_38_1 == "full" then
		showFlashNotice(string.lf("天命已满，不能继续猎命！"))
	elseif arg_38_1 == "coin" then
		showFlashNotice(string.lf("银币不足，不能继续猎命！"))
	end
end

function var_0_5.onHuntAll(arg_39_0, arg_39_1)
	arg_39_0:blockTouch(false)

	if arg_39_0.model:maxHunt() == 5 then
		showFlashNotice(string.lf("激活最高级天命官，去试试运气吧"))
	end
end

function var_0_5.onResolveBatch(arg_40_0)
	arg_40_0:shrinkCells()
	arg_40_0:blockTouch(false)
	GuideLayer:removeGuideLayer(arg_40_0, TaskEntryType.eTianMing, 4)
end

function var_0_5.createCellView(arg_41_0)
	local var_41_0
	local var_41_1 = arg_41_0.cells

	for iter_41_0 = 1, 14 do
		local var_41_2 = display.newSprite("ui/common/common_011.png")

		var_41_2.index = iter_41_0

		table.insert(var_41_1, var_41_2)
	end

	return (var_0_3.tableLayout({
		col = 7,
		spacing = 20,
		nodes = var_41_1,
		padding = {
			top = 0,
			left = 0,
			bottom = 10,
			right = 0
		}
	}))
end

function var_0_5.node2index(arg_42_0, arg_42_1)
	local var_42_0 = 0
	local var_42_1 = arg_42_0.nodes

	for iter_42_0, iter_42_1 in ipairs(var_42_1) do
		if arg_42_1 == iter_42_1 then
			var_42_0 = iter_42_0

			break
		end
	end

	return var_42_0
end

function var_0_5.fromPosition(arg_43_0)
	local var_43_0 = arg_43_0.model.huntValue or arg_43_0.index
	local var_43_1 = arg_43_0.hunts[var_43_0]
	local var_43_2 = arg_43_0.cellView

	return var_0_3.getPosition(var_43_1, var_43_2)
end

function var_0_5.addTianming(arg_44_0, arg_44_1)
	local var_44_0 = CCNode:create()
	local var_44_1 = arg_44_0.nodes
	local var_44_2 = arg_44_0.cells[#var_44_1 + 1]
	local var_44_3 = figure.createHeader({
		isName = true,
		qualityColor = true,
		type = ItemType.eTianMing,
		itemId = arg_44_1,
		clickAction = function()
			arg_44_0:showTips(var_44_0)
		end
	})

	var_44_3:setPosition(43, 43)
	var_44_0:addChild(var_44_3)

	var_44_0.header = var_44_3
	var_44_0.id = arg_44_1

	var_44_0:setAnchorPoint(ccp(0.5, 0.5))
	var_44_0:setContentSize(CCSize(86, 86))
	var_44_0:setPosition(var_44_2:getPosition())
	arg_44_0.cellView:addChild(var_44_0)

	var_44_2.tianming = var_44_0

	table.insert(var_44_1, var_44_0)

	return var_44_0
end

function var_0_5.delTianming(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = arg_46_0.nodes
	local var_46_1 = arg_46_0.cells[arg_46_1]
	local var_46_2 = var_46_1.tianming

	var_46_1.tianming = nil
	arg_46_1 = arg_46_0:node2index(var_46_2)

	table.remove(var_46_0, arg_46_1)
end

function var_0_5.createActions(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_1.moveTo
	local var_47_1 = arg_47_1.scaleTo
	local var_47_2 = arg_47_1.delay
	local var_47_3 = arg_47_1.nextcall
	local var_47_4 = arg_47_1.duration
	local var_47_5 = arg_47_1.callback
	local var_47_6
	local var_47_7
	local var_47_8
	local var_47_9 = CCMoveTo:create(var_47_4, var_47_0)

	if var_47_5 then
		local var_47_10 = CCArray:create()

		if var_47_1 then
			local var_47_11 = CCArray:create()

			var_47_11:addObject(CCScaleTo:create(var_47_4, var_47_1))
			var_47_11:addObject(var_47_9)

			var_47_9 = CCSpawn:create(var_47_11)
		end

		var_47_10:addObject(var_47_9)
		var_47_10:addObject(CCCallFunc:create(var_47_5))

		var_47_9 = CCSequence:create(var_47_10)
	end

	if var_47_3 then
		local var_47_12 = CCArray:create()

		var_47_12:addObject(CCDelayTime:create(var_47_2))
		var_47_12:addObject(CCCallFunc:create(var_47_3))

		var_47_8 = CCSequence:create(var_47_12)

		local var_47_13 = CCArray:create()

		var_47_13:addObject(var_47_9)
		var_47_13:addObject(var_47_8)

		var_47_8 = CCSpawn:create(var_47_13)
	end

	return var_47_8 or var_47_9
end

function var_0_5.CollectOrResolve(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	local var_48_0 = 0
	local var_48_1 = 0

	if arg_48_1 then
		var_48_0, var_48_1 = var_0_3.getPosition(arg_48_0.btnBag, arg_48_0.cellView)
	else
		var_48_0, var_48_1 = var_0_3.getPosition(arg_48_0.attrsNode, arg_48_0.cellView)
		var_48_0 = var_48_0 + 460
		var_48_1 = var_48_1 + 10
	end

	if type(arg_48_2) == "userdata" then
		arg_48_2 = arg_48_0:node2index(arg_48_2)
	end

	local var_48_2 = arg_48_0.nodes[arg_48_2]
	local var_48_3 = arg_48_0:createParticleFire()

	var_48_3:setPosition(43, 43)
	var_48_2:addChild(var_48_3, -1)
	var_48_2:setZOrder(17)
	arg_48_0:delTianming(arg_48_2)

	local var_48_4 = arg_48_0:createActions({
		scaleTo = 0.5,
		delay = 0.15,
		duration = 0.4,
		moveTo = ccp(var_48_0, var_48_1),
		nextcall = arg_48_3,
		callback = function()
			if not arg_48_3 then
				arg_48_0:shrinkCells()
			end

			var_48_2:removeFromParent()
		end
	})

	var_48_2:runAction(var_48_4)
end

function var_0_5.shrinkCells(arg_50_0)
	local var_50_0 = arg_50_0.cellView
	local var_50_1 = arg_50_0.cells
	local var_50_2 = 0
	local var_50_3 = 0
	local var_50_4 = 0
	local var_50_5 = 0
	local var_50_6 = 0
	local var_50_7 = 0

	for iter_50_0, iter_50_1 in ipairs(var_50_1) do
		local var_50_8 = iter_50_1.tianming

		if var_50_8 then
			if var_50_2 > 0 then
				var_50_3 = iter_50_0
			end
		elseif var_50_2 == 0 then
			var_50_2 = iter_50_0
		end

		if var_50_2 > 0 and var_50_3 > 0 then
			local var_50_9 = var_50_1[var_50_3]
			local var_50_10 = var_50_1[var_50_2]

			var_50_9.tianming = nil
			var_50_10.tianming = var_50_8

			local var_50_11, var_50_12 = var_50_10:getPosition()
			local var_50_13 = arg_50_0:createActions({
				duration = 0.3,
				moveTo = ccp(var_50_11, var_50_12)
			})

			var_50_8:runAction(var_50_13)

			var_50_2 = var_50_2 + 1
			var_50_3 = 0
		end
	end
end

function var_0_5.createZodiacView(arg_51_0)
	local var_51_0
	local var_51_1 = arg_51_0.hunts
	local var_51_2
	local var_51_3
	local var_51_4
	local var_51_5

	if arg_51_0.narrowScreen then
		var_51_2 = 0.8
		var_51_3 = 35
		var_51_5 = 62
	else
		var_51_2 = 1
		var_51_3 = 35
		var_51_5 = 77
	end

	for iter_51_0 = 1, 5 do
		local var_51_6 = arg_51_0:createZodiacNode(iter_51_0, var_51_2)

		table.insert(var_51_1, var_51_6)
	end

	local var_51_7 = {}

	for iter_51_1, iter_51_2 in ipairs(var_51_1) do
		table.insert(var_51_7, iter_51_2)

		if iter_51_1 ~= #var_51_1 then
			table.insert(var_51_7, display.newSprite("ui/tianming/tianming_049.png"))
		end
	end

	local var_51_8 = var_0_3.linearLayout({
		margin = 10,
		nodes = var_51_7
	})
	local var_51_9 = {
		"uilocal/tianming/tianming_text_016.png",
		"uilocal/tianming/tianming_text_017.png",
		"uilocal/tianming/tianming_text_018.png",
		"uilocal/tianming/tianming_text_019.png",
		"uilocal/tianming/tianming_text_020.png"
	}

	for iter_51_3, iter_51_4 in ipairs(var_51_1) do
		local var_51_10, var_51_11 = iter_51_4:getPosition()
		local var_51_12 = display.newSprite(var_51_9[iter_51_3])

		var_51_12:setPosition(var_51_10, var_51_11 - var_51_5)
		var_51_8:addChild(var_51_12)

		iter_51_4.name = var_51_12

		local var_51_13 = createItemCountNode({
			isOutline = true,
			type = ItemType.eCoin,
			value = 10000 + 5000 * iter_51_3
		})

		var_51_13:setPosition(var_51_10 - var_51_3, var_51_11 - var_51_5 - 22)
		var_51_8:addChild(var_51_13)

		iter_51_4.price = var_51_13
	end

	arg_51_0.model:bind("types", function(arg_52_0)
		local var_52_0 = 0
		local var_52_1
		local var_52_2 = {
			false,
			false,
			false,
			false,
			false
		}

		for iter_52_0, iter_52_1 in ipairs(arg_52_0) do
			var_52_2[iter_52_1] = true
			var_52_0 = math.max(var_52_0, iter_52_1)
		end

		for iter_52_2, iter_52_3 in ipairs(var_52_2) do
			local var_52_3 = var_51_1[iter_52_2]

			if not iter_52_3 or not var_52_3.state or arg_51_0.model.huntValue == iter_52_2 then
				var_52_3:setState(iter_52_3)
			end
		end

		arg_51_0.index = var_52_0
	end)

	return var_51_8
end

function var_0_5.createZodiacNode(arg_53_0, arg_53_1, arg_53_2)
	local var_53_0 = {
		"ui/tianming/tianming_045.png",
		"ui/tianming/tianming_046.png",
		"ui/tianming/tianming_002.png",
		"ui/tianming/tianming_047.png",
		"ui/tianming/tianming_048.png"
	}
	local var_53_1 = ui.newControlButton({
		disabledImage = "ui/tianming/tianming_011.png",
		scaleX = arg_53_2,
		scaleY = arg_53_2,
		normalImage = var_53_0[arg_53_1],
		clickAction = function()
			arg_53_0.model:requestHunt(1, arg_53_1)
		end
	})
	local var_53_2 = var_53_1:getContentSize()

	if arg_53_1 == 4 then
		local var_53_3 = string.lf("上仙，消耗#FFFF3C元宝#FFFFFF可以直接点亮并获取该命格，并且还会额外获得一个#FFFF3C命格碎片#FFFFFF！", 0)
		local var_53_4 = createItemCountNode({
			value = 200,
			isOutline = true,
			type = ItemType.eGold,
			color = ccc3(255, 250, 10)
		})

		var_53_4:setPosition(50, 55)
		var_53_1:addChild(var_53_4, 1)

		var_53_1.ingot = var_53_4

		arg_53_0.model:bind("cost", function(arg_55_0)
			var_53_4:setValue(arg_55_0)

			var_53_3 = string.lf("上仙，消耗#FFFF3C%d元宝#FFFFFF可以直接点亮并获取该命格，并且还会额外获得一个#FFFF3C命格碎片#FFFFFF！", arg_55_0)
		end)

		local var_53_5 = ui.newControlButton({
			normalImage = "ui/tianming/tianming_023.png",
			scaleX = arg_53_2,
			scaleY = arg_53_2,
			clickAction = function()
				local var_56_0 = arg_53_0.model:get("count")
				local var_56_1 = arg_53_0.model:get("cost")

				if arg_53_0.model:maxHunt() == 5 then
					showFlashNotice(string.lf("激活最高级天命官，去试试运气吧"))

					return
				end

				if not isMoneyEnough(ItemType.eGold, var_56_1, "TianMingRecruitScene") then
					return
				end

				if var_56_0 < 1 then
					ui.showMessageBox({
						animate = "slide",
						text = string.lf("上仙，今日的猎命召唤次数已用完！")
					})

					return
				end

				if arg_53_0.model.showConjureBox then
					local var_56_2 = var_0_1.createDialog({
						show = var_0_1.eShowNoticeBox,
						data = var_53_3,
						callback = function()
							arg_53_0.model:requestHunt(2, arg_53_1)
						end
					})
					local var_56_3 = var_0_3.createToggleButton({
						text = string.lf("不再显示"),
						callback = function(arg_58_0)
							arg_53_0.model.showConjureBox = not arg_58_0
						end
					})

					var_56_2:addNode(var_56_3)
					var_56_2:show()
				else
					arg_53_0.model:requestHunt(2, arg_53_1)
				end
			end
		})

		var_53_5:setAnchorPoint(ccp(0.5, 0))
		var_53_5:setPosition(var_53_2.width / 2, 5)
		var_53_1:addChild(var_53_5, 1)

		var_53_1.conjure = var_53_5

		local var_53_6 = var_53_5:getContentSize()
		local var_53_7 = display.newSprite("uilocal/tianming/tianming_text_008.png")

		var_53_7:setScale(arg_53_2)
		var_53_7:setPosition(var_53_6.width / 2, 18)
		var_53_5:addChild(var_53_7)

		var_53_5.label = var_53_7
	end

	var_53_1.index = arg_53_1
	var_53_1.state = false

	function var_53_1.setState(arg_59_0, arg_59_1)
		local var_59_0

		if arg_59_1 then
			var_59_0 = ({
				"ui/tianming/tianming_021.png",
				"ui/tianming/tianming_020.png",
				"ui/tianming/tianming_019.png",
				"ui/tianming/tianming_018.png",
				"ui/tianming/tianming_017.png"
			})[arg_59_0.index]
		else
			var_59_0 = ({
				"ui/tianming/tianming_016.png",
				"ui/tianming/tianming_015.png",
				"ui/tianming/tianming_014.png",
				"ui/tianming/tianming_013.png",
				"ui/tianming/tianming_012.png"
			})[arg_59_0.index]
		end

		if arg_59_0.conjure then
			arg_59_0.ingot:setVisible(not arg_59_1)
			arg_59_0.conjure:setVisible(not arg_59_1)
		end

		if arg_59_0.sprite then
			arg_59_0.sprite:removeFromParent()
		end

		local var_59_1 = arg_59_0:getContentSize()
		local var_59_2 = display.newSprite(var_59_0)

		var_59_2:setScale(arg_53_2)
		var_59_2:setPosition(var_59_1.width / 2, var_59_1.height / 2)
		arg_59_0:addChild(var_59_2)

		arg_59_0.sprite = var_59_2

		arg_59_0:setEnabled(arg_59_1)

		arg_59_0.state = arg_59_1

		if arg_59_1 then
			local var_59_3 = CCArray:create()

			var_59_3:addObject(CCScaleTo:create(0.2, 1.08))
			var_59_3:addObject(CCScaleTo:create(0.2, 1))
			arg_59_0:setScale(0.9)
			arg_59_0:stopAllActions()
			arg_59_0:runAction(CCSequence:create(var_59_3))
		end
	end

	var_53_1:setState(false)

	return var_53_1
end

function var_0_5.showTips(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_0:node2index(arg_60_1)
	local var_60_1 = arg_60_0.model:get("ids")[var_60_0]
	local var_60_2 = BaseTianMings[var_60_1]
	local var_60_3 = var_0_1.createTips({
		show = var_0_1.eShowTianming,
		id = var_60_1,
		removehandler = function()
			GuideLayer:removeGuideLayer(arg_60_0, TaskEntryType.eTianMing, 5)
		end
	})

	if var_60_2.type ~= TianMingType.eType7 then
		var_60_3:addAction({
			text = string.lf("收取"),
			callback = function()
				arg_60_0.model:requestCollect(var_60_0)
				var_60_3:removeSelf()
				GuideLayer:stepDone(TaskEntryType.eTianMing, 5)
				arg_60_0:showGuideLayer(6)
			end
		})
	end

	var_60_3:addAction({
		text = string.lf("分解"),
		callback = function()
			GuideLayer:removeGuideLayer(arg_60_0, TaskEntryType.eTianMing, 5)

			if var_60_2.quality == QualityType.eOrange then
				ui.showMessageBox({
					animate = "slide",
					text = string.lf("上仙，高级天命得来不易，确定要分解吗？"),
					title1 = string.lf("确定"),
					action1 = function()
						arg_60_0.model:requestResolve(var_60_0)
					end,
					title2 = string.lf("取消")
				})
			else
				arg_60_0.model:requestResolve(var_60_0)
			end

			var_60_3:removeSelf()
		end
	})
	var_60_3:show({
		adjust = true,
		parent = arg_60_0.cellView,
		node = arg_60_1
	})

	if var_60_2.type ~= TianMingType.eType7 then
		GuideLayer:stepDone(TaskEntryType.eTianMing, 4)
		arg_60_0:showGuideLayer(5, {
			var_60_3.container
		})
	end
end

function var_0_5.createParticleFire(arg_65_0)
	local var_65_0 = CCParticleFire:create()

	var_65_0:setTextureWithRect(CCTextureCache:sharedTextureCache():addImage("ui/common/fire.png"), CCRect(0, 0, 32, 32))
	var_65_0:setStartSize(70)
	var_65_0:setLifeVar(0)
	var_65_0:setLife(0.2)
	var_65_0:setAngle(90)
	var_65_0:setSpeed(100)

	return var_65_0
end

function var_0_5.createTianmingAnimate(arg_66_0, arg_66_1)
	while arg_66_1 > 6 do
		arg_66_1 = arg_66_1 - 6
	end

	local var_66_0 = {
		"mingge1",
		"mingge2",
		"mingge3",
		"mingge4",
		"mingge5",
		"mingge6"
	}
	local var_66_1 = CCSkeletonAnimation:createWithFile("effectAni/ui_mingge.json", "effectAni/ui_mingge.atlas", 1)

	var_66_1:addAnimation(var_66_0[arg_66_1], true, 0, 0)

	var_66_1.index = arg_66_1
	var_66_1.animatelist = var_66_0

	function var_66_1.run(arg_67_0)
		arg_67_0:addAnimation(arg_67_0.animatelist[arg_67_0.index], true, 0, 0)
	end

	return var_66_1
end

function var_0_5.blockTouch(arg_68_0, arg_68_1)
	if arg_68_1 then
		local var_68_0 = CCLayer:create()

		var_68_0:addTouchEventListener(function(arg_69_0, arg_69_1, arg_69_2)
			return true
		end, false, 1, true)
		var_68_0:setTouchEnabled(true)
		arg_68_0:addChild(var_68_0, 7)

		arg_68_0._blocklayer = var_68_0
	elseif arg_68_0._blocklayer then
		arg_68_0._blocklayer:removeFromParent()

		arg_68_0._blocklayer = false
	end
end

function var_0_5.initRequests(arg_70_0)
	local function var_70_0()
		local function var_71_0(arg_72_0)
			if arg_72_0 ~= nil and arg_72_0 == true then
				arg_70_0.getMillionHuntRequest:request()
			end
		end

		local var_71_1 = require("scenes.tianming.MillionHuntLayer").new({
			rewardList = arg_70_0.infoMillionHuntRequest.restable,
			closeCallback = var_71_0
		})

		display.getRunningScene():addChild(var_71_1)
	end

	arg_70_0.infoMillionHuntRequest = MillionHuntRequest:new()

	arg_70_0.infoMillionHuntRequest:setResponseNormalHandler(var_70_0)

	local function var_70_1()
		showFlashImage({
			image = "uilocal/enhance/enhance_txt_007.png",
			scale = 0.8,
			parent = arg_70_0,
			position = CCPoint(display.cx, display.cy)
		})
	end

	arg_70_0.getMillionHuntRequest = GetMillionHuntRequest:new()

	arg_70_0.getMillionHuntRequest:setResponseNormalHandler(var_70_1)
end

return var_0_5
