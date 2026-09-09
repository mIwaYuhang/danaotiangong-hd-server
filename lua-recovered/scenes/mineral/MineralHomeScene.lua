require("base.functions")

MineralLayerTag = {
	tagInlay = 1,
	tagRefine = 2,
	tagHole = 3
}

local var_0_0 = class("MineralHomeScene", function()
	return display.newScene("MineralHomeScene")
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.default = arg_2_1 and arg_2_1.default and arg_2_1.default or MineralLayerTag.tagInlay
	gTimerTable = {}

	arg_2_0:addSchedule()
	MineralHelper:getMineralList(function(arg_3_0)
		return
	end, 0)
	arg_2_0:onEnterAlias()
end

function var_0_0.onExit(arg_4_0)
	arg_4_0:removeSchedule()
end

function var_0_0.onEnterAlias(arg_5_0)
	local var_5_0 = require("scenes.CommonBgLayer").new({
		titleSprite = "ui/mineral/mineral_10.png"
	})
	local var_5_1 = var_5_0:getBackgroundSprite()
	local var_5_2 = var_5_1:getContentSize()

	arg_5_0:addChild(var_5_0)

	local var_5_3 = ui.newControlButton({
		normalImage = "ui/enhance/enhance_015.png",
		scaleX = 0.9,
		scaleY = 0.9,
		anchorPoint = CCPoint(0.5, 0.5),
		position = CCPoint(840, 605),
		clickAction = function()
			local var_6_0 = require("scenes.enhance.DlgRuleLayer").new({
				ruleType = DlgRuleType.ruleMineral
			})

			CCDirector:sharedDirector():getRunningScene():addChild(var_6_0)
		end
	})

	var_5_1:addChild(var_5_3)

	local var_5_4 = {
		{
			x = 80,
			tag = MineralLayerTag.tagInlay,
			titleText = string.lf("宝石镶嵌")
		},
		{
			x = 240,
			tag = MineralLayerTag.tagRefine,
			titleText = string.lf("宝石合成")
		},
		{
			x = 400,
			tag = MineralLayerTag.tagHole,
			titleText = string.lf("宝石矿洞")
		}
	}

	var_5_4[arg_5_0.default].isDefault = true

	local var_5_5 = addLabelWithColorSize(var_5_1, string.lf(""), ccc3(255, 50, 50), 22, ccp(0, 0.5), ccp(600, 540))
	local var_5_6 = CCSize(920, 508)
	local var_5_7 = require("scenes.TabLayer").new({
		selectedImage = "ui/common/common_023.png",
		normalImage = "ui/common/common_022.png",
		size = var_5_6,
		point = ccp(20, 10),
		config = var_5_4,
		cellHandler = function(arg_7_0, arg_7_1)
			gTimerTable = {}

			local var_7_0

			if arg_7_1 == MineralLayerTag.tagInlay then
				var_5_5:setString("")

				var_7_0 = require("scenes.mineral.MineralInlayLayer").new({
					layerSize = var_5_6,
					gparent = arg_5_0
				})
			elseif arg_7_1 == MineralLayerTag.tagRefine then
				var_5_5:setString("")

				var_7_0 = require("scenes.mineral.MineralRefineLayer").new({
					layerSize = var_5_6,
					gparent = arg_5_0
				})
			elseif arg_7_1 == MineralLayerTag.tagHole then
				var_5_5:setString(string.lf("24小时不收取则无法装载宝石"))

				var_7_0 = require("scenes.mineral.MineralHoleLayer").new({
					layerSize = var_5_6,
					gparent = arg_5_0
				})
			end

			if var_7_0 ~= nil then
				var_7_0:setAnchorPoint(CCPoint(0, 0))
				var_7_0:setPosition(0, 0)
				arg_7_0:addChild(var_7_0)
			end
		end
	})

	var_5_1:addChild(var_5_7)
end

function var_0_0.addSchedule(arg_8_0)
	if arg_8_0.scheduleHandle == nil then
		arg_8_0.scheduleHandle = require("framework.scheduler").scheduleGlobal(handler(arg_8_0, arg_8_0.scheduleCallback), 1)
	end
end

function var_0_0.removeSchedule(arg_9_0)
	if arg_9_0.scheduleHandle then
		require("framework.scheduler").unscheduleGlobal(arg_9_0.scheduleHandle)

		arg_9_0.scheduleHandle = nil
	end
end

function var_0_0.scheduleCallback(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(gTimerTable) do
		if iter_10_1.callback then
			iter_10_1.callback()
		end
	end
end

function var_0_0.addToTimerTable(arg_11_0, arg_11_1)
	if arg_11_1 == nil then
		return
	end

	table.insert(gTimerTable, arg_11_1)
end

function var_0_0.removeFromTimerTable(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in pairs(gTimerTable) do
		if iter_12_1.callback == arg_12_1 then
			table.remove(gTimerTable, iter_12_0)

			break
		end
	end
end

return var_0_0
