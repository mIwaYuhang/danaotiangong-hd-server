local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = class("MLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

var_0_1.eTypeTips = 1
var_0_1.eTypeToast = 2
var_0_1.eTypeDialog = 3
var_0_1.ePreferNone = 0
var_0_1.ePreferTop = 1
var_0_1.ePreferRight = 2
var_0_1.ePreferBottom = 3
var_0_1.ePreferLeft = 4
var_0_1.ePreferHorizontal = 5
var_0_1.ePreferVertical = 6

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or {}
	arg_2_0.type = arg_2_1.type or var_0_1.eTypeTips
	arg_2_0.title = arg_2_1.title
	arg_2_0.prefer = arg_2_1.prefer or var_0_1.ePreferTop
	arg_2_0.align = arg_2_1.align or display.LEFT_BOTTOM
	arg_2_0.wait = arg_2_1.wait or 0
	arg_2_0.removehandler = arg_2_1.removehandler
	arg_2_0.closeable = arg_2_1.closeable or false
	arg_2_0.penetrable = arg_2_1.penetrable or false
	arg_2_0.touchable = arg_2_1.touchable
	arg_2_0.cancelable = arg_2_1.cancelable
	arg_2_0.swallow = arg_2_1.swallow
	arg_2_0.tipsTag = 1389873929
	arg_2_0.bundle = {}
	arg_2_0.actMargin = 0
	arg_2_0.actNormal = 0
	arg_2_0.actDisabled = 0
	arg_2_0.actDirection = "horizontal"
	arg_2_0.actions = {}
	arg_2_0.hotspot = nil
	arg_2_0.actionIn = false
	arg_2_0.actionOut = false
	arg_2_0.attached = {}
	arg_2_0.removeFromParent = arg_2_0.removeSelf
	arg_2_0.removeFromParentAndCleanup = arg_2_0.removeSelf

	arg_2_0:init()
end

function var_0_1.addNode(arg_3_0, arg_3_1)
	local var_3_0
	local var_3_1
	local var_3_2
	local var_3_3
	local var_3_4
	local var_3_5 = arg_3_0.bundle
	local var_3_6 = arg_3_1.index or #var_3_5 + 1

	if type(arg_3_1) == "table" then
		var_3_0, var_3_1 = arg_3_1.node, arg_3_1.size
		var_3_2, var_3_3 = arg_3_1.align, arg_3_1.zorder
		var_3_4 = arg_3_1.adapt
	else
		var_3_0 = arg_3_1
	end

	var_3_2 = var_3_2 or display.CENTER
	var_3_1 = var_3_1 or var_3_0:getContentSize()
	var_3_3 = var_3_3 or 0

	if type(var_3_4) ~= "boolean" then
		var_3_4 = false
	end

	table.insert(arg_3_0.bundle, var_3_6, {
		node = var_3_0,
		size = var_3_1,
		align = var_3_2,
		zorder = var_3_3,
		adapt = var_3_4
	})
end

function var_0_1.addSeparator(arg_4_0, arg_4_1)
	arg_4_1 = arg_4_1 or {}

	local var_4_0 = arg_4_0.sepsize
	local var_4_1 = display.newScale9Sprite(arg_4_0.separator)

	if not var_4_0 then
		var_4_0 = var_4_1:getOriginalSize()
		arg_4_0.sepsize = var_4_0
	end

	arg_4_1.node = var_4_1
	arg_4_1.size = var_4_0
	arg_4_1.align = display.CENTER
	arg_4_1.adapt = true

	arg_4_0:addNode(arg_4_1)
end

function var_0_1.addAction(arg_5_0, arg_5_1)
	table.insert(arg_5_0.actions, arg_5_1)
end

function var_0_1.show(arg_6_0, arg_6_1)
	arg_6_1 = arg_6_1 or {}

	local var_6_0 = arg_6_1.x
	local var_6_1 = arg_6_1.y
	local var_6_2 = arg_6_1.adjust
	local var_6_3 = arg_6_1.align or arg_6_0.align
	local var_6_4 = arg_6_1.node
	local var_6_5 = arg_6_1.viewSize
	local var_6_6 = arg_6_1.scroll
	local var_6_7 = arg_6_1.parent
	local var_6_8 = false

	if not var_6_7 then
		if var_6_6 then
			var_6_7 = var_6_6.table:getParent()
		else
			var_6_7 = CCDirector:sharedDirector():getRunningScene()
			var_6_8 = true
		end
	end

	local var_6_9, var_6_10 = arg_6_0:creator(arg_6_0.type)

	arg_6_0.container, arg_6_0.size = var_6_9, var_6_10

	if var_6_6 then
		print("tips scroll")

		local var_6_11 = var_6_6.index
		local var_6_12 = var_6_6.table
		local var_6_13 = var_6_6.size.width
		local var_6_14 = var_6_6.size.height
		local var_6_15 = var_6_12:getDirection()
		local var_6_16 = var_6_12:getBoundingBox()
		local var_6_17 = var_6_16.origin.x
		local var_6_18 = var_6_16.origin.y
		local var_6_19 = var_6_12:getContentOffset()

		if var_6_15 == kCCScrollViewDirectionHorizontal then
			var_6_0 = var_6_0 or 0
			var_6_1 = var_6_1 or var_6_14
			var_6_0 = var_6_13 * (var_6_11 - 1) + var_6_17 + var_6_19.x + var_6_0
			var_6_1 = var_6_14 + var_6_18 + var_6_19.y + (var_6_1 - var_6_14)
		else
			var_6_0 = var_6_0 or var_6_13
			var_6_1 = var_6_1 or 0
			var_6_0 = var_6_13 + var_6_17 + var_6_19.x + (var_6_0 - var_6_13)
			var_6_1 = var_6_14 * (var_6_11 - 1) + var_6_18 + var_6_19.y + var_6_1
		end

		local var_6_20 = var_6_7:convertToWorldSpace(ccp(0, 0))
		local var_6_21 = {
			top = 0,
			right = 0,
			x = 0,
			y = 0,
			x = -var_6_20.x,
			y = -var_6_20.y
		}

		var_6_21.right = var_6_21.x + display.width / Adapter.MinScale
		var_6_21.top = var_6_21.y + display.height / Adapter.MinScale

		if var_6_0 < var_6_21.x then
			var_6_0 = var_6_21.x
		end

		if var_6_1 < var_6_21.y then
			var_6_1 = var_6_21.y
		end

		if var_6_21.right < var_6_0 + var_6_10.width then
			var_6_0 = var_6_21.right - var_6_10.width
		end

		if var_6_21.top < var_6_1 + var_6_10.height then
			var_6_1 = var_6_21.top - var_6_10.height
		end
	elseif var_6_4 then
		print("tips node")

		local var_6_22 = arg_6_1.offset or ccp(0, 0)
		local var_6_23 = var_6_4:getBoundingBox()
		local var_6_24 = 0
		local var_6_25 = var_6_23.origin.x
		local var_6_26 = var_6_23.origin.y

		if var_6_2 then
			local var_6_27 = 0
			local var_6_28 = 0
			local var_6_29 = 0
			local var_6_30
			local var_6_31 = var_6_4:getParent()

			while var_6_31 ~= var_6_7 and var_6_29 < 64 do
				local var_6_32 = var_6_31:getBoundingBox()
				local var_6_33 = var_6_32.origin.x
				local var_6_34 = var_6_32.origin.y

				var_6_25, var_6_26 = var_6_25 + var_6_33, var_6_26 + var_6_34
				var_6_31 = var_6_31:getParent()
			end

			var_6_23.origin.x, var_6_23.origin.y = var_6_25, var_6_26
		end

		if not var_6_5 then
			if arg_6_1.limit then
				var_6_5 = var_6_7:getContentSize()
			else
				local var_6_35 = var_6_7:convertToWorldSpace(ccp(0, 0))

				var_6_22.x, var_6_22.y = var_6_35.x / Adapter.MinScale, var_6_35.y / Adapter.MinScale
				var_6_5 = CCSize(display.width, display.height)
			end
		end

		if Adapter.MinScale > 1 then
			var_6_5.width = var_6_5.width / Adapter.MinScale
			var_6_5.height = var_6_5.height / Adapter.MinScale
		end

		if arg_6_1.prefer then
			arg_6_0.prefer = arg_6_1.prefer
		end

		local var_6_36

		var_6_36, var_6_0, var_6_1 = arg_6_0:initPosition(var_6_23, var_6_5, var_6_22)
	elseif not var_6_0 or not var_6_1 then
		print("tips x y")

		var_6_5 = var_6_5 or var_6_7:getContentSize()
		var_6_0 = var_6_0 or var_6_5.width / 2
		var_6_1 = var_6_1 or var_6_5.height / 2
	end

	var_6_9:setAnchorPoint(display.ANCHOR_POINTS[var_6_3])
	var_6_9:setPosition(var_6_0, var_6_1)

	if arg_6_0.__attach then
		return arg_6_0.super:addChild(var_6_9)
	elseif arg_6_0.wrapper then
		var_6_8 = false

		arg_6_0.wrapper:addChild(var_6_9)
	else
		arg_6_0:addChild(var_6_9)
	end

	local var_6_37 = var_6_7:getChildByTag(arg_6_0.tipsTag)

	if var_6_37 then
		var_6_37:removeFromParent()
	end

	arg_6_0:addTouchEventListener(handler(arg_6_0, arg_6_0._touchhandler), false, 1, arg_6_0.swallow)
	arg_6_0:setTouchEnabled(true)

	if var_6_8 then
		arg_6_0:setScale(Adapter.MinScale)
	end

	var_6_7:addChild(arg_6_0, DefaultZOrder.eMsgBox, arg_6_0.tipsTag)

	if arg_6_0.actionIn then
		arg_6_0.actionIn(arg_6_0, var_6_9)
	end

	local var_6_38 = arg_6_0.attached

	if #var_6_38 > 0 then
		local var_6_39 = arg_6_0.container

		for iter_6_0, iter_6_1 in ipairs(var_6_38) do
			iter_6_1:show({
				parent = arg_6_0,
				node = var_6_39,
				prefer = var_0_1.ePreferLeft
			})

			var_6_39 = iter_6_1
		end
	end
end

function var_0_1.attach(arg_7_0)
	local var_7_0 = {
		__attach = true,
		__index = arg_7_0,
		super = arg_7_0,
		bundle = {},
		actions = {}
	}
	local var_7_1 = setmetatable(var_7_0, var_7_0)

	table.insert(arg_7_0.attached, var_7_1)

	return var_7_1
end

function var_0_1.creator(arg_8_0, arg_8_1)
	local var_8_0
	local var_8_1
	local var_8_2
	local var_8_3

	if arg_8_1 == var_0_1.eTypeTips then
		var_8_0 = CCRect(15, 12, 243, 201)
		var_8_3 = "ui/common/common_116.png"
	elseif arg_8_1 == var_0_1.eTypeToast then
		var_8_0 = CCRect(165, 18, 17, 7)
		var_8_3 = "ui/common/common_064_2.png"
	else
		var_8_0 = CCRect(20, 20, 217, 150)
		var_8_3 = "ui/common/common_050.png"
	end

	local var_8_4 = display.newScale9Sprite(var_8_3)

	var_8_4:setCapInsets(var_8_0)
	arg_8_0:initNodes()

	local var_8_5 = arg_8_0:layout(var_8_4, arg_8_0.bundle)

	if arg_8_0.closeable then
		local var_8_6 = ui.newControlButton({
			normalImage = "ui/common/btn_closed.png",
			highlightedImage = "ui/common/btn_closed.png",
			clickAction = function(arg_9_0, arg_9_1)
				arg_8_0:removeFromParent()
			end
		})

		var_8_6:setPosition(var_8_5.width - 5, var_8_5.height - 5)
		var_8_4:addChild(var_8_6)
	end

	return var_8_4, var_8_5
end

function var_0_1.layout(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.padding
	local var_10_1 = arg_10_0.margin
	local var_10_2 = arg_10_0.minWidth
	local var_10_3 = arg_10_0.minHeight
	local var_10_4 = #arg_10_2
	local var_10_5 = CCSize(0, 0)
	local var_10_6
	local var_10_7
	local var_10_8
	local var_10_9
	local var_10_10
	local var_10_11
	local var_10_12

	for iter_10_0 = 1, var_10_4 do
		local var_10_13 = arg_10_2[iter_10_0]
		local var_10_14 = var_10_13.size

		if var_10_13.adapt then
			var_10_3 = var_10_3 + 5
		elseif var_10_2 < var_10_14.width then
			var_10_2 = var_10_14.width
		end

		var_10_3 = var_10_3 + var_10_14.height + var_10_1
	end

	local var_10_15 = arg_10_0.sepsize
	local var_10_16 = arg_10_0.sepcap

	if var_10_15 then
		local var_10_17 = var_10_15.width - var_10_2

		if var_10_17 > 0 then
			var_10_16.origin.x = var_10_2 / 2
			var_10_16.size.width = var_10_17
		else
			var_10_16.origin.x = var_10_15.width / 5 * 2
			var_10_16.size.width = var_10_15.width / 5
		end

		var_10_16.origin.y = 0
		var_10_16.size.height = var_10_15.height
	end

	local var_10_18 = 0
	local var_10_19 = var_10_0.right
	local var_10_20 = var_10_0.bottom

	for iter_10_1 = var_10_4, 1, -1 do
		local var_10_21 = arg_10_2[iter_10_1]
		local var_10_22, var_10_23, var_10_24, var_10_25, var_10_26 = var_10_21.node, var_10_21.size, var_10_21.align, var_10_21.adapt, var_10_21.zorder
		local var_10_27 = display.ANCHOR_POINTS[var_10_24]

		if var_10_25 then
			var_10_18 = var_10_19 + var_10_2 * var_10_27.x

			var_10_22:setCapInsets(var_10_16)
			var_10_22:setContentSize(CCSize(var_10_2, var_10_15.height))

			var_10_20 = var_10_20 + 5
		else
			var_10_18 = var_10_19 + (var_10_2 - var_10_23.width) * var_10_27.x

			var_10_22:setAnchorPoint(ccp(0, 0))
		end

		var_10_22:setPosition(var_10_18, var_10_20)
		arg_10_1:addChild(var_10_22, var_10_26)

		var_10_20 = var_10_20 + var_10_23.height + var_10_1
	end

	local var_10_28 = var_10_2 + var_10_0.left + var_10_0.right
	local var_10_29 = var_10_3 + var_10_0.top + var_10_0.bottom

	var_10_5.width, var_10_5.height = var_10_28, var_10_29

	arg_10_1:setContentSize(var_10_5)

	return var_10_5
end

function var_0_1.init(arg_11_0)
	local var_11_0 = arg_11_0.type

	arg_11_0.sepsize = nil
	arg_11_0.sepcap = CCRect(0, 0, 0, 0)
	arg_11_0.separator = "ui/common/common_100.png"

	if var_11_0 == var_0_1.eTypeTips then
		arg_11_0.minWidth = 120
		arg_11_0.minHeight = 0
		arg_11_0.padding = {
			top = 10,
			left = 10,
			bottom = 10,
			right = 10
		}
		arg_11_0.margin = 0
		arg_11_0.delay = 10
		arg_11_0.touchable = true
		arg_11_0.cancelable = true
		arg_11_0.swallow = true
		arg_11_0.actNormal = "ui/common/common_115.png"
		arg_11_0.actDisabled = arg_11_0.actNormal
		arg_11_0.actMargin = 0
	elseif var_11_0 == var_0_1.eTypeToast then
		arg_11_0.minWidth = 330
		arg_11_0.minHeight = 0
		arg_11_0.padding = {
			top = 10,
			left = 14,
			bottom = 25,
			right = 14
		}
		arg_11_0.margin = 10
		arg_11_0.delay = 1.5
		arg_11_0.align = display.CENTER
		arg_11_0.actionIn = arg_11_0.popupLayer
		arg_11_0.touchable = true
		arg_11_0.swallow = false
		arg_11_0.cancelable = false
	else
		arg_11_0.minWidth = 120
		arg_11_0.minHeight = 0
		arg_11_0.padding = {
			top = 15,
			left = 14,
			bottom = 15,
			right = 14
		}
		arg_11_0.margin = 5
		arg_11_0.align = display.CENTER
		arg_11_0.touchable = true
		arg_11_0.swallow = true
		arg_11_0.cancelable = false
		arg_11_0.actNormal = "ui/common/common_018.png"
		arg_11_0.actDisabled = "ui/common/common_079.png"
		arg_11_0.actMargin = 80

		arg_11_0:setColor(ccc3(10, 10, 10))
		arg_11_0:setOpacity(160)

		local var_11_1 = var_0_0.newNode()

		var_11_1:setContentSize(CCSize(display.width, display.height))
		var_11_1:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
		var_11_1:setPosition(display.cx, display.cy)
		var_11_1:setScale(Adapter.MinScale)
		arg_11_0:addChild(var_11_1)

		arg_11_0.wrapper = var_11_1
	end
end

function var_0_1.initNodes(arg_12_0)
	local var_12_0 = arg_12_0.title

	if var_12_0 then
		local var_12_1

		if var_12_0.node then
			var_12_1 = var_12_0.node
		elseif var_12_0.image then
			var_12_1 = display.newSprite(var_12_0.image)
		else
			var_12_0.font = _FONT_DEFAULT
			var_12_1 = var_0_0.newLabel(var_12_0)
		end

		if var_12_1 then
			arg_12_0:addNode({
				index = 1,
				node = var_12_1
			})
			arg_12_0:addSeparator({
				index = 2
			})
		end
	end

	local var_12_2 = arg_12_0.actions

	if #var_12_2 > 0 then
		local var_12_3 = arg_12_0:createActionsNode(var_12_2)

		arg_12_0:addNode({
			zorder = 7,
			node = var_12_3
		})

		arg_12_0.hotspot = var_12_3
	end
end

function var_0_1.createActionsNode(arg_13_0, arg_13_1)
	local var_13_0
	local var_13_1
	local var_13_2 = {}
	local var_13_3 = arg_13_0.actNormal
	local var_13_4 = arg_13_0.actDisabled
	local var_13_5 = arg_13_0.actMargin
	local var_13_6 = arg_13_0.actDirection

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		local var_13_7 = ui.newControlButton({
			normalImage = var_13_3,
			disabledImage = var_13_4,
			text = iter_13_1.text,
			fontSize = ColorTable.eTitleButton_FontSize,
			textColor = ColorTable.eTitleButton_Normal,
			clickAction = function(arg_14_0, arg_14_1)
				if iter_13_1.callback then
					iter_13_1.callback(arg_14_0, arg_14_1)
				else
					arg_13_0:removeSelf()
				end
			end
		})

		if iter_13_1.enabled ~= nil then
			var_13_7:setEnabled(iter_13_1.enabled)
		end

		var_13_7:setTitleColorForState(ccc3(100, 100, 100), CCControlStateDisabled)
		table.insert(var_13_2, var_13_7)
	end

	local var_13_8 = var_0_0.linearLayout({
		nodes = var_13_2,
		direction = var_13_6,
		margin = var_13_5
	})
	local var_13_9 = var_13_8:getContentSize()

	var_13_9.height = var_13_9.height + 10

	var_13_8:setContentSize(var_13_9)

	return var_13_8
end

function var_0_1.initPosition(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = 5
	local var_15_1 = arg_15_0.size
	local var_15_2 = arg_15_0.prefer
	local var_15_3 = arg_15_1.origin.x
	local var_15_4 = arg_15_1.origin.y
	local var_15_5 = {
		width = arg_15_1.size.width,
		height = arg_15_1.size.height
	}
	local var_15_6 = {
		width = arg_15_2.width,
		height = arg_15_2.height
	}
	local var_15_7 = {
		width = 0,
		height = 0,
		x = 0,
		y = 0,
		x = -arg_15_3.x,
		y = -arg_15_3.y,
		width = var_15_6.width,
		height = var_15_6.height
	}

	var_15_7.right = var_15_7.x + var_15_7.width
	var_15_7.top = var_15_7.y + var_15_7.height

	local function var_15_8()
		local var_16_0 = 0
		local var_16_1 = 0
		local var_16_2 = var_15_3 + var_15_5.width + var_15_0 + var_15_1.width < var_15_7.right

		if var_16_2 then
			var_16_0 = var_15_3 + var_15_5.width + var_15_0
			var_16_1 = var_15_4 + var_15_5.height

			if var_16_1 > var_15_7.top then
				var_16_1 = var_15_7.top
			end

			var_16_1 = var_16_1 - var_15_1.height

			if var_16_1 < var_15_7.y then
				var_16_1 = var_15_7.y
			end
		end

		print("right:", var_16_2)

		return var_16_2, var_0_1.ePreferRight, var_16_0, var_16_1
	end

	local function var_15_9()
		local var_17_0 = 0
		local var_17_1 = 0
		local var_17_2 = var_15_3 - var_15_0 - var_15_1.width > var_15_7.x

		if var_17_2 then
			var_17_0 = var_15_3 - var_15_1.width - var_15_0
			var_17_1 = var_15_4 + var_15_5.height

			if var_17_1 > var_15_7.top then
				var_17_1 = var_15_7.top
			end

			var_17_1 = var_17_1 - var_15_1.height

			if var_17_1 < var_15_7.y then
				var_17_1 = var_15_7.y
			end
		end

		print("left:", var_17_2)

		return var_17_2, var_0_1.ePreferLeft, var_17_0, var_17_1
	end

	local function var_15_10()
		local var_18_0 = 0
		local var_18_1 = 0
		local var_18_2 = var_15_4 + var_15_5.height + var_15_0 + var_15_1.height < var_15_7.top

		if var_18_2 then
			var_18_0 = var_15_3 + (var_15_5.width - var_15_1.width) / 2

			if var_18_0 < var_15_7.x then
				var_18_0 = var_15_7.x
			elseif var_18_0 > var_15_7.right - var_15_1.width then
				var_18_0 = var_15_7.right - var_15_1.width
			end

			var_18_1 = var_15_4 + var_15_5.height + var_15_0
		end

		print("top:", var_18_2)

		return var_18_2, var_0_1.ePreferTop, var_18_0, var_18_1
	end

	local function var_15_11()
		local var_19_0 = 0
		local var_19_1 = 0
		local var_19_2 = var_15_4 - var_15_0 - var_15_1.height > var_15_7.y

		if var_19_2 then
			var_19_0 = var_15_3 + (var_15_5.width - var_15_1.width) / 2

			if var_19_0 < var_15_7.x then
				var_19_0 = var_15_7.x
			elseif var_19_0 > var_15_7.right - var_15_1.width then
				var_19_0 = var_15_7.right - var_15_1.width
			end

			var_19_1 = var_15_4 - var_15_1.height - var_15_0
		end

		print("bottom:", var_19_2)

		return var_19_2, var_0_1.ePreferBottom, var_19_0, var_19_1
	end

	local var_15_12 = false
	local var_15_13 = var_0_1.ePreferNone
	local var_15_14 = 0
	local var_15_15 = 0
	local var_15_16 = {
		{
			var_15_10,
			var_15_11,
			var_15_8,
			var_15_9
		},
		{
			var_15_8,
			var_15_9,
			var_15_10,
			var_15_11
		},
		{
			var_15_11,
			var_15_10,
			var_15_8,
			var_15_9
		},
		{
			var_15_9,
			var_15_8,
			var_15_10,
			var_15_11
		},
		{
			var_15_8,
			var_15_9,
			var_15_10,
			var_15_11
		},
		{
			var_15_10,
			var_15_11,
			var_15_8,
			var_15_9
		}
	}

	for iter_15_0, iter_15_1 in ipairs(var_15_16[var_15_2]) do
		local var_15_17, var_15_18, var_15_19, var_15_20 = iter_15_1()

		var_15_15 = var_15_20
		var_15_14 = var_15_19
		var_15_13 = var_15_18

		if var_15_17 then
			break
		end
	end

	return var_15_13, var_15_14, var_15_15
end

function var_0_1.popupLayer(arg_20_0, arg_20_1)
	local var_20_0, var_20_1 = arg_20_1:getPosition()
	local var_20_2 = CCArray:create()
	local var_20_3 = CCArray:create()
	local var_20_4 = CCArray:create()

	if arg_20_0.wait > 0 then
		local var_20_5 = CCDelayTime:create(arg_20_0.wait)
		local var_20_6 = CCCallFunc:create(function()
			arg_20_0:setVisible(true)
		end)

		var_20_2:addObject(var_20_5)
		var_20_2:addObject(var_20_6)
		arg_20_0:setVisible(false)
	end

	local var_20_7 = CCMoveTo:create(0.15, ccp(var_20_0, var_20_1))
	local var_20_8 = CCFadeIn:create(0.15)

	var_20_3:addObject(var_20_7)
	var_20_3:addObject(var_20_8)
	var_20_2:addObject(CCSpawn:create(var_20_3))

	local var_20_9 = CCDelayTime:create(arg_20_0.delay)

	var_20_2:addObject(var_20_9)

	local var_20_10 = CCMoveTo:create(0.3, ccp(var_20_0, var_20_1 + 120))
	local var_20_11 = CCFadeOut:create(0.3)

	var_20_4:addObject(var_20_10)
	var_20_4:addObject(var_20_11)
	var_20_2:addObject(CCSpawn:create(var_20_4))

	local var_20_12 = CCCallFunc:create(function()
		arg_20_0:removeFromParent()
	end)

	var_20_2:addObject(var_20_12)
	arg_20_1:setOpacity(0)
	arg_20_1:setPosition(var_20_0, var_20_1 - 40)
	arg_20_1:stopAllActions()
	arg_20_1:runAction(CCSequence:create(var_20_2))
end

function var_0_1.fadeoutLayer(arg_23_0, arg_23_1)
	local var_23_0 = 0.3
	local var_23_1 = arg_23_1:getAnchorPoint()
	local var_23_2, var_23_3 = arg_23_1:getPosition()
	local var_23_4 = arg_23_1:getContentSize()

	arg_23_1:setPosition(var_23_2 - var_23_4.width * var_23_1.x + var_23_4.width, var_23_3 - var_23_4.height * var_23_1.y)

	var_23_1.x, var_23_1.y = 1, 0

	arg_23_1:setAnchorPoint(var_23_1)

	local var_23_5 = CCArray:create()

	var_23_5:addObject(CCFadeOut:create(var_23_0))
	var_23_5:addObject(CCRotateTo:create(var_23_0, -20))

	local var_23_6 = CCSpawn:create(var_23_5)
	local var_23_7 = CCCallFunc:create(function()
		arg_23_0:removeSelf()
	end)
	local var_23_8 = CCArray:create()

	var_23_8:addObject(var_23_6)
	var_23_8:addObject(var_23_7)
	arg_23_1:runAction(CCSequence:create(var_23_8))
end

function var_0_1.popinLayer(arg_25_0, arg_25_1)
	local var_25_0 = 0.2
	local var_25_1 = 20
	local var_25_2, var_25_3 = arg_25_1:getPosition()

	arg_25_1:setPosition(var_25_2, var_25_3 + var_25_1)

	local var_25_4 = CCArray:create()

	var_25_4:addObject(CCFadeIn:create(var_25_0))
	var_25_4:addObject(CCMoveBy:create(var_25_0, ccp(0, -var_25_1)))
	arg_25_1:setOpacity(0)
	arg_25_1:runAction(CCSpawn:create(var_25_4))

	local var_25_5 = arg_25_0:getOpacity()

	arg_25_0:setOpacity(0)
	arg_25_0:runAction(CCFadeTo:create(var_25_0, var_25_5))
end

function var_0_1.popoutLayer(arg_26_0, arg_26_1)
	local var_26_0 = 0.2
	local var_26_1 = 40
	local var_26_2 = CCArray:create()

	var_26_2:addObject(CCFadeOut:create(var_26_0))
	var_26_2:addObject(CCMoveBy:create(var_26_0, ccp(0, var_26_1)))

	local var_26_3 = CCSpawn:create(var_26_2)
	local var_26_4 = CCCallFunc:create(function()
		arg_26_0:removeSelf()
	end)
	local var_26_5 = CCArray:create()

	var_26_5:addObject(var_26_3)
	var_26_5:addObject(var_26_4)
	arg_26_1:runAction(CCSequence:create(var_26_5))
	arg_26_0:runAction(CCFadeTo:create(var_26_0, 0))
end

function var_0_1.springLayer(arg_28_0, arg_28_1)
	local var_28_0 = CCArray:create()

	var_28_0:addObject(CCScaleTo:create(0.1, 1.06))
	var_28_0:addObject(CCScaleTo:create(0.06, 0.96))
	var_28_0:addObject(CCScaleTo:create(0.04, 1))
	arg_28_1:stopAllActions()
	arg_28_1:runAction(CCSequence:create(var_28_0))
end

function var_0_1.delayRemove(arg_29_0, arg_29_1)
	local var_29_0 = CCArray:create()
	local var_29_1 = CCFadeIn:create(0.15)
	local var_29_2 = CCDelayTime:create(arg_29_0.delay)
	local var_29_3 = CCFadeOut:create(1)
	local var_29_4 = CCCallFunc:create(function()
		arg_29_0:removeFromParent()
	end)

	var_29_0:addObject(var_29_1)
	var_29_0:addObject(var_29_2)
	var_29_0:addObject(var_29_3)
	var_29_0:addObject(var_29_4)
	arg_29_1:stopAllActions()
	arg_29_1:runAction(CCSequence:create(var_29_0))
end

function var_0_1._touchhandler(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if arg_31_1 == "began" then
		local var_31_0 = false
		local var_31_1 = ccp(arg_31_2, arg_31_3)
		local var_31_2 = arg_31_0.container:convertToNodeSpace(var_31_1)
		local var_31_3 = arg_31_0.container:getBoundingBox()

		var_31_3.origin.x, var_31_3.origin.y = 0, 0

		if arg_31_0.touchable then
			if not arg_31_0.cancelable then
				var_31_0 = true
			elseif arg_31_0.hotspot and arg_31_0.hotspot:getBoundingBox():containsPoint(var_31_2) then
				var_31_0 = true
			end
		elseif not arg_31_0.penetrable and var_31_3:containsPoint(var_31_2) then
			var_31_0 = true
		end

		if not var_31_0 then
			arg_31_0:removeSelf()
		end

		return var_31_0
	elseif arg_31_1 == "moved" then
		-- block empty
	elseif arg_31_1 == "ended" then
		-- block empty
	end
end

function var_0_1.removeSelf(arg_32_0, arg_32_1)
	if not tolua.isnull(arg_32_0) then
		if arg_32_0.actionOut then
			arg_32_0.actionOut(arg_32_0, arg_32_0.container)

			arg_32_0.actionOut = false
		else
			local var_32_0 = arg_32_0.removehandler

			if arg_32_1 ~= false then
				arg_32_1 = true
			end

			CCNode.removeFromParentAndCleanup(arg_32_0, arg_32_1)

			return var_32_0 and var_32_0()
		end
	end
end

var_0_1.__handlers = {}

function var_0_1.__register(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = var_0_1.__handlers[arg_33_0]

	if not var_33_0 then
		var_33_0 = {}
		var_0_1.__handlers[arg_33_0] = var_33_0
	end

	var_33_0[arg_33_1] = arg_33_2
end

function var_0_1.__layerCreator(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_1.show
	local var_34_1 = var_0_1.__handlers[arg_34_0][var_34_0]

	return var_34_1 and var_34_1(arg_34_1)
end

function var_0_1.createTips(arg_35_0)
	return var_0_1.__layerCreator(var_0_1.eTypeTips, arg_35_0)
end

function var_0_1.createToast(arg_36_0)
	return var_0_1.__layerCreator(var_0_1.eTypeToast, arg_36_0)
end

function var_0_1.createDialog(arg_37_0)
	return var_0_1.__layerCreator(var_0_1.eTypeDialog, arg_37_0)
end

return var_0_1
