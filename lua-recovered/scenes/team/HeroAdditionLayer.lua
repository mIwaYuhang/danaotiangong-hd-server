require("data.ShenQi")
require("data.MineralHelper")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = {
	AP = string.lf("普攻"),
	B = string.lf("破击"),
	BL = string.lf("格挡"),
	C = string.lf("暴击"),
	D = string.lf("闪避"),
	DEF = string.lf("普防"),
	H = string.lf("命中"),
	HP = string.lf("血量"),
	MAP = string.lf("技攻"),
	MDEF = string.lf("技防"),
	Speed = string.lf("速度"),
	TE = string.lf("韧性")
}
local var_0_2 = class("HeroAdditionLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create(ccc4(10, 10, 10, 160)))
end)

function var_0_2.ctor(arg_2_0, arg_2_1)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		return true
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	local var_2_0 = display.newSprite("ui/team/team_111.png")
	local var_2_1 = var_2_0:getContentSize()

	var_2_0:align(display.CENTER, display.cx, display.cy)
	var_2_0:setScale(Adapter.MinScale)
	arg_2_0:addChild(var_2_0)

	arg_2_0.bgSprite = var_2_0
	arg_2_0.nodeSize = var_2_1

	local var_2_2 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		clickAction = function()
			arg_2_0:removeFromParent()
		end,
		position = ccp(var_2_1.width, var_2_1.height)
	})

	var_2_0:addChild(var_2_2, 1)

	local var_2_3
	local var_2_4 = {}

	if arg_2_1.artifact then
		local var_2_5 = arg_2_0:createArtifactAttr(arg_2_1.artifact, Player.attrAdditionObj.artifact)

		table.insert(var_2_4, var_2_5)
	end

	if arg_2_1.destiny then
		local var_2_6 = arg_2_0:createDestinyAttr(arg_2_1.destiny, Player.attrAdditionObj.destiny)

		table.insert(var_2_4, var_2_6)
	end

	if arg_2_1.destinyHalo then
		local var_2_7 = arg_2_0:createHaloAttr(arg_2_1.destinyHalo, Player.attrAdditionObj.destinyHalo)

		table.insert(var_2_4, var_2_7)
	end

	if arg_2_1.sacrifice then
		local var_2_8 = arg_2_0:createSacrificeAttr(arg_2_1.sacrifice, Player.attrAdditionObj.sacrifice)

		table.insert(var_2_4, var_2_8)
	end

	if arg_2_1.gem then
		local var_2_9 = arg_2_0:createMineralAttr(arg_2_1.gem, Player.attrAdditionObj.gem)

		table.insert(var_2_4, var_2_9)
	end

	if arg_2_1.xf then
		local var_2_10 = arg_2_0:createXfAttr(arg_2_1.xf, Player.attrAdditionObj.xf)

		table.insert(var_2_4, var_2_10)
	end

	local var_2_11 = var_0_0.linearLayout({
		margin = 10,
		direction = "vertical",
		nodes = var_2_4
	})
	local var_2_12 = CCSize(arg_2_0.nodeSize.width - 30, arg_2_0.nodeSize.height - 30)

	arg_2_0.viewSize = var_2_12

	local var_2_13 = CCScrollView:create(var_2_12, var_2_11)

	var_2_13:setPosition(15, 15)
	var_2_13:setDirection(kCCScrollViewDirectionVertical)
	var_2_13:setContentOffset(var_2_13:minContainerOffset())
	var_2_0:addChild(var_2_13)
end

function var_0_2.createArtifactAttr(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = CCSize(arg_5_0.nodeSize.width - 30, 160)
	local var_5_1 = var_0_0.newNode()

	if arg_5_2 then
		local var_5_2 = arg_5_0:getEnableAttrs(arg_5_1.BattleHeroProperty, arg_5_2.BattleHeroProperty)
		local var_5_3 = arg_5_0:addLabelList(var_5_1, var_5_2, var_5_0.width - 30, var_5_0.width / 2)

		var_5_0.height = var_5_0.height + var_5_3
	end

	local var_5_4 = arg_5_1.Artifact
	local var_5_5 = BaseShenQi[var_5_4.Step]
	local var_5_6 = display.newSprite("body/" .. var_5_5.image, var_5_0.width / 2, var_5_0.height - 55)
	local var_5_7 = var_5_6:getContentSize().width
	local var_5_8 = var_5_6:getContentSize().height
	local var_5_9 = 250
	local var_5_10 = 100

	if var_5_10 < var_5_8 and var_5_9 < var_5_7 then
		local var_5_11 = var_5_10 / var_5_8
		local var_5_12 = var_5_9 / var_5_7

		var_5_6:setScale(var_5_12 < var_5_11 and var_5_12 or var_5_11)
	end

	var_5_6:setAnchorPoint(ccp(0.5, 1))
	var_5_1:addChild(var_5_6)

	local var_5_13 = {
		"sq_015.png",
		"sq_014.png",
		"sq_013.png",
		"sq_012.png",
		"sq_011.png",
		"sq_010.png",
		"sq_009.png",
		"sq_008.png",
		"sq_007.png",
		"sq_028.png"
	}
	local var_5_14 = display.newSprite("ui/shenqi/" .. var_5_13[var_5_4.Step], 20, var_5_0.height - 55)

	var_5_14:setAnchorPoint(CCPoint(0, 1))
	var_5_1:addChild(var_5_14)
	addLabelWithColorSize(var_5_1, "+" .. var_5_4.Level, ccc3(247, 211, 91), 25, CCPoint(0, 1), CCPoint(100, var_5_0.height - 60))
	addLabelWithColorSize(var_5_1, var_5_5.name, ccc3(245, 255, 0), 20, CCPoint(0, 1), CCPoint(100, var_5_0.height - 95))
	arg_5_0:addTitleImg(var_5_1, "uilocal/fuben/zszz_text_041.png", var_5_0)
	var_5_1:setContentSize(var_5_0)

	return var_5_1
end

function var_0_2.createDestinyAttr(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = CCSize(arg_6_0.nodeSize.width - 30, 50)
	local var_6_1 = var_0_0.newNode()

	if arg_6_2 then
		local var_6_2 = arg_6_0:getEnableAttrs(arg_6_1, arg_6_2)
		local var_6_3 = arg_6_0:addLabelList(var_6_1, var_6_2, var_6_0.width - 30, var_6_0.width / 2)

		var_6_0.height = var_6_0.height + var_6_3
	end

	arg_6_0:addTitleImg(var_6_1, "uilocal/fuben/zszz_text_038.png", var_6_0)
	var_6_1:setContentSize(var_6_0)

	return var_6_1
end

function var_0_2.createHaloAttr(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = CCSize(arg_7_0.nodeSize.width - 30, 130)
	local var_7_1 = var_0_0.newNode()
	local var_7_2 = {
		"tianming_029.png",
		"tianming_030.png",
		"tianming_031.png",
		"tianming_032.png",
		"tianming_033.png"
	}
	local var_7_3 = 15

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_4 = "ui/tianming/" .. var_7_2[iter_7_0]
		local var_7_5 = display.newSprite(var_7_4, var_7_3, 40)

		var_7_5:setAnchorPoint(CCPoint(0, 0.5))
		var_7_1:addChild(var_7_5)

		local var_7_6 = arg_7_2[iter_7_0]
		local var_7_7

		if iter_7_1 <= var_7_6 then
			var_7_7 = ": " .. iter_7_1 .. "#00FF00 (" .. var_7_6 .. ")"
		else
			var_7_7 = ": " .. iter_7_1 .. "#FF0000 (" .. var_7_6 .. ")"
		end

		addLabelWithColorSize(var_7_1, var_7_7, ccc3(239, 223, 181), 22, CCPoint(0, 0.5), CCPoint(var_7_3 + 70, 40))

		var_7_3 = var_7_3 + 150
	end

	arg_7_0:addTitleImg(var_7_1, "uilocal/fuben/zszz_text_039.png", var_7_0)
	var_7_1:setContentSize(var_7_0)

	return var_7_1
end

function var_0_2.createSacrificeAttr(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = CCSize(arg_8_0.nodeSize.width - 30, 50)
	local var_8_1 = var_0_0.newNode()
	local var_8_2 = arg_8_0:getEnableAttrs(arg_8_1, arg_8_2)
	local var_8_3 = arg_8_0:addLabelList(var_8_1, var_8_2, var_8_0.width - 30, var_8_0.width / 2)

	var_8_0.height = var_8_0.height + var_8_3

	arg_8_0:addTitleImg(var_8_1, "uilocal/fuben/zszz_text_042.png", var_8_0)
	var_8_1:setContentSize(var_8_0)

	return var_8_1
end

function var_0_2.createMineralAttr(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = CCSize(arg_9_0.nodeSize.width - 30, 50)
	local var_9_1 = var_0_0.newNode()

	local function var_9_2(arg_10_0, arg_10_1)
		local var_10_0

		for iter_10_0, iter_10_1 in pairs(arg_10_0.battleProperty or {}) do
			if var_0_1[iter_10_0] ~= nil and iter_10_1 > 0 then
				var_10_0 = iter_10_0

				break
			end
		end

		if var_10_0 == nil then
			for iter_10_2, iter_10_3 in pairs(arg_10_1.battleProperty or {}) do
				if var_0_1[iter_10_2] ~= nil and iter_10_3 > 0 then
					var_10_0 = iter_10_2

					break
				end
			end
		end

		return var_10_0
	end

	local function var_9_3(arg_11_0, arg_11_1)
		return arg_11_0 ~= nil and arg_11_0[arg_11_1] or 0
	end

	local function var_9_4(arg_12_0, arg_12_1)
		local var_12_0 = MineralHelper:getCanInlayType(arg_12_0.type) .. string.lf("%d颗", arg_12_0.count) .. " "
		local var_12_1 = var_9_2(arg_12_0, arg_12_1)

		if var_12_1 == nil then
			var_12_0 = var_12_0 .. "+0 #00FF00(" .. string.lf("%d颗", 0) .. "+0)"
		else
			var_12_0 = var_12_0 .. var_0_1[var_12_1] .. "+" .. var_9_3(arg_12_0.battleProperty, var_12_1)

			if arg_12_1.count >= arg_12_0.count then
				var_12_0 = var_12_0 .. "#00FF00(" .. string.lf("%d颗", arg_12_1.count) .. "+" .. var_9_3(arg_12_1.battleProperty, var_12_1) .. ")"
			else
				var_12_0 = var_12_0 .. "#FF0000(" .. string.lf("%d颗", arg_12_1.count) .. "+" .. var_9_3(arg_12_1.battleProperty, var_12_1) .. ")"
			end
		end

		return var_12_0
	end

	local var_9_5
	local var_9_6 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		local var_9_7 = var_0_0.newLabel({
			size = 20,
			text = var_9_4(iter_9_1, arg_9_2[iter_9_0]),
			color = ccc3(239, 223, 181)
		})

		table.insert(var_9_6, var_9_7)
	end

	local var_9_8 = var_0_0.tableLayout({
		row = 0,
		col = 2,
		nodes = var_9_6,
		size = CCSize(var_9_0.width - 15, 20),
		padding = {
			top = 0,
			bottom = 0,
			left = 15,
			right = 0
		},
		align = display.LEFT_CENTER
	})
	local var_9_9 = var_9_8:getContentSize()

	var_9_8:setAnchorPoint(ccp(0.5, 0))
	var_9_8:setPosition(var_9_0.width / 2, 5)
	var_9_1:addChild(var_9_8)

	var_9_0.height = var_9_0.height + var_9_9.height

	arg_9_0:addTitleImg(var_9_1, "uilocal/fuben/zszz_text_053.png", var_9_0)
	var_9_1:setContentSize(var_9_0)

	return var_9_1
end

function var_0_2.createXfAttr(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = CCSize(arg_13_0.nodeSize.width - 30, 50)
	local var_13_1 = var_0_0.newNode()
	local var_13_2 = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_1.front) do
		local var_13_3 = arg_13_2.front[iter_13_0]

		if var_13_3.AddValue >= iter_13_1.AddValue then
			table.insert(var_13_2, string.lf("前排%s: +%d #00FF00(%d)", BattleAttrsName[iter_13_1.AddAttrEnum], iter_13_1.AddValue, var_13_3.AddValue))
		else
			table.insert(var_13_2, string.lf("前排%s: +%d #FF0000(%d)", BattleAttrsName[iter_13_1.AddAttrEnum], iter_13_1.AddValue, var_13_3.AddValue))
		end
	end

	for iter_13_2, iter_13_3 in pairs(arg_13_1.back) do
		local var_13_4 = arg_13_2.back[iter_13_2]

		if var_13_4.AddValue >= iter_13_3.AddValue then
			table.insert(var_13_2, string.lf("后排%s: +%d #00FF00(%d)", BattleAttrsName[iter_13_3.AddAttrEnum], iter_13_3.AddValue, var_13_4.AddValue))
		else
			table.insert(var_13_2, string.lf("后排%s: +%d #FF0000(%d)", BattleAttrsName[iter_13_3.AddAttrEnum], iter_13_3.AddValue, var_13_4.AddValue))
		end
	end

	table.insert(var_13_2, string.lf("全体血量: +%d #00FF00(%d)", arg_13_1.totalHp, arg_13_2.totalHp))

	local var_13_5 = arg_13_0:addLabelList(var_13_1, var_13_2, var_13_0.width - 30, var_13_0.width / 2)

	var_13_0.height = var_13_0.height + var_13_5

	arg_13_0:addTitleImg(var_13_1, "uilocal/fuben/zszz_text_040.png", var_13_0)
	var_13_1:setContentSize(var_13_0)

	return var_13_1
end

function var_0_2.getEnableAttrs(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(arg_14_1) do
		if var_0_1[iter_14_0] ~= nil then
			local var_14_1 = arg_14_2[iter_14_0]

			if iter_14_1 <= var_14_1 then
				table.insert(var_14_0, string.lf("%s: +%d #00FF00(%d)", var_0_1[iter_14_0], iter_14_1, var_14_1))
			else
				table.insert(var_14_0, string.lf("%s: +%d #FF0000(%d)", var_0_1[iter_14_0], iter_14_1, var_14_1))
			end
		end
	end

	return var_14_0
end

function var_0_2.addTitleImg(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = display.newSprite("ui/team/team_001.png", arg_15_3.width / 2, arg_15_3.height - 5)

	var_15_0:setAnchorPoint(ccp(0.5, 1))
	arg_15_1:addChild(var_15_0)

	local var_15_1 = var_15_0:getContentSize()
	local var_15_2 = display.newSprite(arg_15_2, var_15_1.width / 2, var_15_1.height / 2)

	var_15_2:setAnchorPoint(ccp(0.5, 0.5))
	var_15_0:addChild(var_15_2)
end

function var_0_2.addLabelList(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_2) do
		local var_16_2 = var_0_0.newLabel({
			size = 20,
			text = arg_16_2[iter_16_0],
			color = ccc3(239, 223, 181)
		})

		table.insert(var_16_1, var_16_2)
	end

	local var_16_3 = var_0_0.tableLayout({
		row = 0,
		col = 3,
		nodes = var_16_1,
		size = CCSize(arg_16_3, 20),
		padding = {
			top = 0,
			bottom = 0,
			left = 20,
			right = 0
		},
		align = display.LEFT_CENTER
	})
	local var_16_4 = var_16_3:getContentSize()

	var_16_3:setAnchorPoint(ccp(0.5, 0))
	var_16_3:setPosition(arg_16_4, 5)
	arg_16_1:addChild(var_16_3)

	return var_16_4.height
end

return var_0_2
