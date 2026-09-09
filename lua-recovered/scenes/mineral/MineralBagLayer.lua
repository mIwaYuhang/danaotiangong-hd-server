local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = class("MineralBagLayer", function()
	return display.newLayer()
end)

function var_0_2.ctor(arg_2_0, arg_2_1)
	arg_2_0.showEnterAnimation = arg_2_1.showEnterAnimation
	arg_2_0.showCloseButton = arg_2_1.showCloseButton
	arg_2_0.filterLevel = arg_2_1.filterLevel
	arg_2_0.filterEquipType = arg_2_1.filterEquipType
	arg_2_0.closeCallback = arg_2_1.closeCallback
	arg_2_0.tipsButtonItems = arg_2_1.tipsButtonItems
	arg_2_0._totalPageCount = 1
	arg_2_0._pageCount = 16
	arg_2_0._mineralDataList = {}

	local var_2_0 = CCSize(410, 496)
	local var_2_1 = display.newScale9Sprite("ui/team/team_002.png", 0, 0, var_2_0)

	var_2_1:setAnchorPoint(CCPoint(0, 0))
	arg_2_0:addChild(var_2_1)

	arg_2_0.background = CCLayerColor:create(ccc4(0, 0, 0, 0))

	arg_2_0.background:setContentSize(var_2_0)
	var_2_1:addChild(arg_2_0.background)

	if arg_2_0.showCloseButton ~= nil and arg_2_0.showCloseButton == true then
		local var_2_2 = ui.newControlButton({
			normalImage = "ui/team/team_040.png",
			position = ccp(var_2_0.width - 5, var_2_0.height - 5),
			clickAction = function()
				arg_2_0:dismissAnimation()
			end
		})

		var_2_2:setAnchorPoint(ccp(1, 1))
		var_2_1:addChild(var_2_2)
	end

	local function var_2_3(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == nil or arg_4_1 == nil or arg_4_2 == nil then
			return
		end

		local var_4_0

		var_4_0 = figure.createMineralHeader({
			itemId = arg_4_1.gemProtoID or 0,
			level = arg_4_1.level or 1,
			clickAction = function()
				arg_2_0.lastClickNode = var_4_0

				require("scenes.mineral.MineralTipLayer").new({
					mineralItem = arg_4_1,
					buttonItems = arg_2_0.tipsButtonItems,
					node = var_4_0
				})
			end
		})

		var_4_0:setPosition(arg_4_2)
		arg_4_0:addChild(var_4_0)

		if arg_2_0.filterLevel ~= nil and arg_4_1.level ~= nil and arg_2_0.filterLevel ~= arg_4_1.level then
			var_4_0:setEnabled(false)
		end

		if arg_2_0.filterEquipType ~= nil and arg_2_0.filterEquipType ~= BaseMineral[arg_4_1.gemProtoID].equipType then
			var_4_0:setEnabled(false)
		end
	end

	arg_2_0.sliderLayer = require("scenes.SliderLayer").new({
		navOnSprite = "ui/common/common_048.png",
		navOffSprite = "ui/common/common_047.png",
		navMargin = 30,
		size = CCSizeMake(400, 420),
		point = ccp(5, 75),
		clipScaleX = Adapter.MinScale,
		clipScaleY = Adapter.MinScale,
		navPosition = ccp(200, -30),
		direction = SliderDirection.eHorizontal,
		numberHandler = function()
			return arg_2_0._totalPageCount
		end,
		changedHandler = function(arg_7_0)
			return
		end,
		cellHandler = function(arg_8_0, arg_8_1)
			local var_8_0 = (arg_8_1 - 1) * arg_2_0._pageCount + 1
			local var_8_1 = arg_8_1 * arg_2_0._pageCount
			local var_8_2 = 0

			for iter_8_0 = var_8_0, var_8_1 do
				local var_8_3 = (var_8_2 % 4 + 0.5) * 90 + 21
				local var_8_4 = (4 - math.floor(var_8_2 / 4) - 0.5) * 90

				if iter_8_0 <= #arg_2_0._mineralDataList then
					var_2_3(arg_8_0, arg_2_0._mineralDataList[iter_8_0], CCPoint(var_8_3, var_8_4))
				end

				var_8_2 = var_8_2 + 1
			end
		end,
		touchBeginCallback = function(arg_9_0, arg_9_1, arg_9_2)
			return false
		end,
		touchMoveCallback = function(arg_10_0, arg_10_1, arg_10_2)
			return
		end,
		touchEndCallback = function(arg_11_0, arg_11_1, arg_11_2)
			return
		end
	})

	arg_2_0.background:addChild(arg_2_0.sliderLayer)
	arg_2_0:requestMineralData()
	arg_2_0:setNodeEventEnabled(true)
end

function var_0_2.onEnter(arg_12_0)
	if arg_12_0.showEnterAnimation ~= nil and arg_12_0.showEnterAnimation == true then
		arg_12_0:setPosition(ccp(display.right, 6))

		local var_12_0 = CCArray:create()
		local var_12_1 = CCMoveTo:create(0.5, ccp(506, 6))
		local var_12_2 = CCEaseElasticOut:create(var_12_1, 0.9)

		var_12_0:addObject(var_12_2)
		arg_12_0:runAction(CCSequence:create(var_12_0))
	else
		arg_12_0:setPosition(ccp(506, 6))
	end
end

function var_0_2.onExit(arg_13_0)
	if arg_13_0.closeCallback then
		arg_13_0.closeCallback()
	end
end

function var_0_2.reloadData(arg_14_0, arg_14_1)
	arg_14_0.filterLevel = arg_14_1
	arg_14_0._totalPageCount = math.ceil(#arg_14_0._mineralDataList / arg_14_0._pageCount)

	if arg_14_0._totalPageCount == 0 then
		arg_14_0._totalPageCount = 1
	end

	local var_14_0 = arg_14_0.sliderLayer:getCurrentIndex()

	if var_14_0 > arg_14_0._totalPageCount then
		var_14_0 = arg_14_0._totalPageCount
	end

	arg_14_0.sliderLayer:reloadData(var_14_0)
end

function var_0_2.reloadBagLayer(arg_15_0, arg_15_1)
	arg_15_0.filterLevel = arg_15_1

	arg_15_0:requestMineralData()
end

function var_0_2.addItem(arg_16_0, arg_16_1)
	if arg_16_1 == nil or arg_16_1.id == nil or arg_16_1.gemProtoID == nil then
		return
	end

	table.insert(arg_16_0._mineralDataList, arg_16_1)
	table.sort(arg_16_0._mineralDataList, function(arg_17_0, arg_17_1)
		if arg_17_0.level ~= arg_17_1.level then
			return arg_17_0.level > arg_17_1.level
		else
			return arg_17_0.gemProtoID > arg_17_1.gemProtoID
		end
	end)
end

function var_0_2.delItem(arg_18_0, arg_18_1)
	if arg_18_1 == nil or arg_18_1.id == nil or arg_18_1.gemProtoID == nil then
		return
	end

	for iter_18_0, iter_18_1 in ipairs(arg_18_0._mineralDataList) do
		if iter_18_1.id == arg_18_1.id then
			table.remove(arg_18_0._mineralDataList, iter_18_0)

			break
		end
	end
end

function var_0_2.findItem(arg_19_0, arg_19_1)
	if arg_19_1 == nil then
		return nil
	end

	local var_19_0

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._mineralDataList) do
		if iter_19_1.id == arg_19_1 then
			var_19_0 = iter_19_1

			break
		end
	end

	return var_19_0
end

function var_0_2.requestMineralData(arg_20_0)
	local function var_20_0(arg_21_0, arg_21_1)
		arg_20_0._mineralDataList = arg_21_0

		table.sort(arg_20_0._mineralDataList, function(arg_22_0, arg_22_1)
			if arg_22_0.level ~= arg_22_1.level then
				return arg_22_0.level > arg_22_1.level
			else
				return arg_22_0.gemProtoID > arg_22_1.gemProtoID
			end
		end)

		arg_20_0._totalPageCount = math.ceil(#arg_20_0._mineralDataList / arg_20_0._pageCount)

		if arg_20_0._totalPageCount == 0 then
			arg_20_0._totalPageCount = 1
		end

		local var_21_0 = arg_20_0.sliderLayer:getCurrentIndex()

		if var_21_0 > arg_20_0._totalPageCount then
			var_21_0 = arg_20_0._totalPageCount
		end

		arg_20_0.sliderLayer:reloadData(var_21_0)
	end

	MineralHelper:getMineralList(var_20_0, 0)
end

function var_0_2.dismissAnimation(arg_23_0)
	local var_23_0 = CCArray:create()
	local var_23_1 = CCMoveTo:create(0.5, ccp(display.right, 7))
	local var_23_2 = CCEaseElasticIn:create(var_23_1, 0.9)

	var_23_0:addObject(var_23_2)
	var_23_0:addObject(CCCallFunc:create(handler(arg_23_0, arg_23_0.removeFromParent)))
	arg_23_0:runAction(CCSequence:create(var_23_0))
end

return var_0_2
