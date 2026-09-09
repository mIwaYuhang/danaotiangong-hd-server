require("base.functions")
require("data.player")
require("data.hero")
require("network.QiShuRequest")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = require("base.cache")
local var_0_2 = require("scenes.toollayer.event")
local var_0_3 = require("scenes.toollayer.model")
local var_0_4 = var_0_3:extend({
	red = "#7A0014",
	green = "#004308",
	ctor = function(arg_1_0)
		arg_1_0:set("id", 0)
		arg_1_0:set("name", "")
		arg_1_0:set("icon", "")
		arg_1_0:set("level", 0)
		arg_1_0:set("max", 0)
		arg_1_0:set("value", 0)
		arg_1_0:set("knowledge", 0)
		arg_1_0:set("limit", 0)
		arg_1_0:set("color", arg_1_0.green)
	end,
	attach = function(arg_2_0, arg_2_1)
		arg_2_0:detach()
	end,
	loadData = function(arg_3_0, arg_3_1)
		local var_3_0 = arg_3_1.BPT

		arg_3_0:set("name", BattleAttrsName[var_3_0])
		arg_3_0:set("icon", getBattleAttrsIconName(var_3_0))
		arg_3_0:set("id", var_3_0)
		arg_3_0:set("level", arg_3_1.Level)
		arg_3_0:set("max", arg_3_1.MaxLevel)
		arg_3_0:set("value", arg_3_1.Value)
		arg_3_0:set("knowledge", arg_3_1.Knowledge)
		arg_3_0:set("limit", arg_3_1.OpenLv)
	end,
	upgrade = function(arg_4_0, arg_4_1)
		arg_4_0:set("level", arg_4_1.Level)
		arg_4_0:set("value", arg_4_1.Value)
		arg_4_0:set("knowledge", arg_4_1.Knowledge)
		arg_4_0:trigger("upgrade")
	end
})
local var_0_5 = var_0_3:extend({
	attach = function(arg_5_0, arg_5_1)
		arg_5_0.request = QiShuRequest:new(arg_5_1)

		arg_5_0.request:setResponseNormalHandler(function()
			local var_6_0, var_6_1 = arg_5_0.request:getResponseContent()
			local var_6_2 = {}

			if var_6_0 == QiShuRequest.eInfo then
				for iter_6_0, iter_6_1 in ipairs(var_6_1) do
					local var_6_3 = var_0_4:new()

					var_6_3:loadData(iter_6_1)
					table.insert(var_6_2, var_6_3)
					arg_5_0:addChild(var_6_3)
				end

				arg_5_0.dirty = false
				arg_5_0.dataset = var_6_2

				arg_5_0:trigger("sync", var_6_2)
			elseif var_6_0 == QiShuRequest.eUpgrade then
				arg_5_0.techValue:upgrade(var_6_1)
				arg_5_0:trigger("upgrade")
			end
		end)
		arg_5_0.request:setResponseExceptionHandler(function()
			arg_5_0.dirty = true

			print("处理请求发生错误")
		end)
	end,
	sync = function(arg_8_0)
		if arg_8_0.dirty then
			arg_8_0.request:requestTechInfo()
		else
			arg_8_0:trigger("sync", arg_8_0.dataset)
		end
	end,
	upgrade = function(arg_9_0, arg_9_1)
		arg_9_0.techValue = arg_9_1

		arg_9_0.request:requestUpgradeTech(arg_9_1:get("id"))
	end,
	isEnabled = function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_1:get("limit")
		local var_10_1 = arg_10_1:get("level")
		local var_10_2 = arg_10_1:get("max")
		local var_10_3 = arg_10_1:get("knowledge")

		return not (var_10_0 > Player.level or var_10_1 == var_10_2 or var_10_3 > Player.knowledge)
	end
})
local var_0_6 = class("QiShuScene", function()
	return display.newScene("QiShuScene")
end)

function var_0_6.ctor(arg_12_0)
	arg_12_0.container = nil
	arg_12_0.tableview = nil
	arg_12_0.tianshu = nil
	arg_12_0.knowledge = nil
	arg_12_0.model = var_0_1.get(arg_12_0)

	if not arg_12_0.model then
		arg_12_0.model = var_0_5:new()

		var_0_1.set(arg_12_0, arg_12_0.model)
	end

	arg_12_0.model:attach(arg_12_0)
	arg_12_0:onEnterAlias()
end

function var_0_6.onEnterAlias(arg_13_0)
	local var_13_0 = display.newSprite("ui/tianshuqishu/tianshu_007.jpg")
	local var_13_1 = var_13_0:getContentSize()

	var_13_0:setScale(Adapter.AutoScaleY)
	var_13_0:setPosition(display.cx, display.cy)
	arg_13_0:addChild(var_13_0)

	local var_13_2 = display.newSprite("ui/tianshuqishu/tianshu_001.png")
	local var_13_3 = var_13_2:getContentSize()

	var_13_2:setPosition(var_13_1.width / 2, var_13_1.height / 2)
	var_13_0:addChild(var_13_2)

	arg_13_0.container = var_13_2

	local var_13_4 = display.newSprite("uilocal/tianshuqishu/tianshu_txt_001.png")

	var_13_4:setPosition(var_13_3.width / 2, var_13_3.height - 49)
	var_13_2:addChild(var_13_4)

	local var_13_5 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		clickAction = function()
			game.enterHomeScene()
		end
	})

	var_13_5:setPosition(var_13_3.width - 75, var_13_3.height - 50)
	var_13_2:addChild(var_13_5)

	local var_13_6 = display.newSprite("ui/tianshuqishu/tianshu_002.png")
	local var_13_7 = var_13_6:getContentSize()
	local var_13_8 = display.newSprite(getItemIconPath(ItemType.eKnowledge, 0))
	local var_13_9 = var_0_0.newLabel({
		text = string.lf("阅历: %d", Player.knowledge),
		color = ccc3(212, 196, 59)
	})

	var_13_8:setAnchorPoint(ccp(0, 0.5))
	var_13_8:setPosition(20, var_13_7.height / 2)
	var_13_6:addChild(var_13_8)
	var_13_9:setAnchorPoint(ccp(0, 0.5))
	var_13_9:setPosition(50, var_13_7.height / 2)
	var_13_6:addChild(var_13_9)
	var_13_6:setPosition(155, var_13_3.height - 87)
	var_13_2:addChild(var_13_6)

	arg_13_0.knowledge = var_13_9

	local var_13_10 = arg_13_0:createQiShuView()
	local var_13_11 = CCSize(804, 393)

	var_13_10:setPosition((var_13_3.width - var_13_11.width) / 2, (var_13_3.height - var_13_11.height) / 2 - 13)
	var_13_2:addChild(var_13_10)

	arg_13_0.tianshu = var_13_10

	local var_13_12 = var_0_0.createIndicator("bottom")

	var_13_12:setPosition(var_13_3.width / 2, 80)
	var_13_2:addChild(var_13_12)
	arg_13_0.model:on("upgrade", arg_13_0.onUpgrade, arg_13_0)
	arg_13_0.model:on("sync", arg_13_0.onSync, arg_13_0)
	arg_13_0.model:sync()
end

function var_0_6.onExit(arg_15_0)
	arg_15_0.model:detach()
end

function var_0_6.onSync(arg_16_0, arg_16_1)
	local var_16_0 = {}
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		table.insert(var_16_1, iter_16_1)

		if #var_16_1 == 3 then
			table.insert(var_16_0, var_16_1)

			var_16_1 = {}
		end
	end

	if #var_16_1 > 0 then
		table.insert(var_16_0, var_16_1)
	end

	arg_16_0.tableview:reloadData(var_16_0)
end

function var_0_6.onUpgrade(arg_17_0)
	local var_17_0 = string.lf("阅历: %d", Player.knowledge)

	arg_17_0.knowledge:setString(var_17_0)
	arg_17_0.knowledge:runAction(CCBlink:create(0.5, 3))
end

function var_0_6.createQiShuView(arg_18_0)
	local var_18_0 = CCSize(804, 393)
	local var_18_1 = {
		direction = kCCScrollViewDirectionVertical,
		size = var_18_0,
		sizehandler = function(arg_19_0, arg_19_1)
			return CCSize(804, 200)
		end,
		cellhandler = handler(arg_18_0, arg_18_0.createQiShuList)
	}
	local var_18_2 = createTableView(var_18_1)

	arg_18_0.tableview = var_18_2

	return var_18_2
end

function var_0_6.createQiShuList(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = CCSize(804, 200)
	local var_20_1 = CCNode:create()

	var_20_1:setContentSize(var_20_0)

	local var_20_2 = 0
	local var_20_3 = 0
	local var_20_4 = #arg_20_3
	local var_20_5
	local var_20_6 = arg_20_2 == arg_20_1 and "ui/tianshuqishu/tianshu_004.png" or arg_20_2 == 1 and "ui/tianshuqishu/tianshu_006.png" or "ui/tianshuqishu/tianshu_005.png"

	for iter_20_0 = 1, 3 do
		local var_20_7 = arg_20_3[iter_20_0]

		if var_20_7 then
			local var_20_8 = arg_20_0:createQiShuItem(var_20_7)

			var_20_8.row = arg_20_2
			var_20_8.col = iter_20_0

			var_20_8:setAnchorPoint(ccp(0, 0))
			var_20_8:setPosition(var_20_2, var_20_3)
			var_20_1:addChild(var_20_8)
		end

		var_20_2 = var_20_2 + 268

		if iter_20_0 ~= 3 then
			local var_20_9 = display.newScale9Sprite(var_20_6)

			var_20_9:setPreferredSize(CCSize(2, var_20_0.height))
			var_20_9:setPosition(var_20_2, var_20_0.height / 2)
			var_20_1:addChild(var_20_9)
		end
	end

	if arg_20_2 ~= 1 then
		local var_20_10 = display.newScale9Sprite("ui/tianshuqishu/tianshu_003.png")

		var_20_10:setPreferredSize(CCSize(var_20_0.width, 2))
		var_20_10:setAnchorPoint(ccp(0.5, 0))
		var_20_10:setPosition(var_20_0.width / 2, 0)
		var_20_1:addChild(var_20_10)
	end

	return var_20_1
end

function var_0_6.createQiShuItem(arg_21_0, arg_21_1)
	local var_21_0 = CCSize(268, 200)
	local var_21_1 = CCNode:create()

	var_21_1:setContentSize(var_21_0)
	arg_21_1:attach(var_21_1)

	local var_21_2 = var_0_0.newLabel({
		text = "",
		size = 28,
		color = ccc3(47, 7, 4)
	})

	var_21_2:setPosition(var_21_0.width / 2, 170)
	var_21_1:addChild(var_21_2)
	arg_21_1:bind("name|level", function(arg_22_0, arg_22_1)
		var_21_2:setString(string.lf("%s (%d级)", arg_22_0, arg_22_1))
	end)

	local var_21_3 = display.newSprite(arg_21_1:get("icon"))

	var_21_3:setPosition(60, 100)
	var_21_1:addChild(var_21_3)

	local var_21_4 = var_0_0.newLabel({
		text = "",
		color = ccc3(6, 9, 0)
	})

	var_21_4:setAnchorPoint(ccp(0, 0.5))
	var_21_4:setPosition(110, 130)
	var_21_1:addChild(var_21_4)
	arg_21_1:bind("knowledge|limit|color", function(arg_23_0, arg_23_1, arg_23_2)
		local var_23_0

		if arg_23_1 > Player.level then
			var_23_0 = string.lf("%s开放等级: %d", arg_23_2, arg_23_1)
		else
			var_23_0 = string.lf("消耗阅历: %s%d", arg_23_2, arg_23_0)
		end

		var_21_4:setString(var_23_0)
	end)

	local var_21_5 = var_0_0.newLabel({
		text = "",
		color = ccc3(6, 9, 0)
	})

	var_21_5:setPosition(var_21_0.width / 2, 30)
	var_21_1:addChild(var_21_5)
	arg_21_1:bind("name|value", function(arg_24_0, arg_24_1)
		var_21_5:setString(string.lf("全体%s提升 %s%d", arg_24_0, arg_21_1.green, arg_24_1))
	end)

	local var_21_6 = ui.newControlButton({
		disabledImage = "ui/common/common_079.png",
		normalImage = "ui/common/common_018.png",
		text = string.lf("升级"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_25_0, arg_25_1)
			arg_21_0.model:upgrade(arg_21_1)
		end
	})

	var_21_6:setTitleColorForState(ColorTable.eTitleButton_Disabled, CCControlStateDisabled)
	var_21_6:setPosition(170, 82)
	var_21_1:addChild(var_21_6)
	arg_21_1:on("upgrade", function()
		showFlashImage({
			image = "uilocal/enhance/enhance_txt_007.png",
			scale = 0.8,
			parent = var_21_1,
			position = ccp(170, 80)
		})
	end)

	local function var_21_7()
		local var_27_0 = arg_21_0.model:isEnabled(arg_21_1)

		var_21_6:setEnabled(var_27_0)
		arg_21_1:set("color", var_27_0 and arg_21_1.green or arg_21_1.red)
	end

	arg_21_0.model:on("upgrade", var_21_7)
	var_21_7()

	return var_21_1
end

return var_0_6
