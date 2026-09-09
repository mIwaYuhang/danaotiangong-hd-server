require("base.functions")
require("base.platform")

local var_0_0 = require("scenes.toollayer.tool")
local var_0_1 = require("scenes.toollayer.event")
local var_0_2 = {}

function var_0_2.linearLayout(arg_1_0)
	local var_1_0 = arg_1_0.layout
	local var_1_1 = arg_1_0.parent
	local var_1_2 = arg_1_0.nodes
	local var_1_3 = arg_1_0.align
	local var_1_4 = arg_1_0.margin
	local var_1_5 = arg_1_0.direction
	local var_1_6 = var_1_1 or var_0_2.newNode(arg_1_0.debug)

	if type(var_1_2) ~= "table" or #var_1_2 < 1 then
		return var_1_6
	end

	var_1_5 = var_1_5 or "horizontal"
	var_1_3 = var_1_3 or display.CENTER
	var_1_4 = var_1_4 or 0

	local var_1_7 = -var_1_4
	local var_1_8 = CCSize(0, 0)
	local var_1_9 = display.ANCHOR_POINTS[var_1_3]
	local var_1_10 = {}
	local var_1_11 = #var_1_2
	local var_1_12
	local var_1_13
	local var_1_14
	local var_1_15

	for iter_1_0 = 1, var_1_11 do
		var_1_12 = var_1_2[iter_1_0]

		local var_1_16 = var_1_12:getContentSize()
		local var_1_17, var_1_18 = var_1_12:getScaleX(), var_1_12:getScaleY()

		var_1_16.width = var_1_16.width * var_1_17
		var_1_16.height = var_1_16.height * var_1_18

		if var_1_16.width > var_1_8.width then
			var_1_8.width = var_1_16.width
		end

		if var_1_16.height > var_1_8.height then
			var_1_8.height = var_1_16.height
		end

		table.insert(var_1_10, var_1_16)
	end

	for iter_1_1 = 1, var_1_11 do
		if var_1_5 == "horizontal" then
			local var_1_19

			var_1_12, var_1_19 = var_1_2[iter_1_1], var_1_10[iter_1_1]
			var_1_7 = var_1_7 + var_1_19.width + var_1_4

			var_1_12:setPosition(var_1_7 - var_1_19.width * (1 - var_1_9.x), var_1_8.height * var_1_9.y)
		elseif var_1_5 == "vertical" then
			local var_1_20

			var_1_12, var_1_20 = var_1_2[var_1_11 - iter_1_1 + 1], var_1_10[var_1_11 - iter_1_1 + 1]
			var_1_7 = var_1_7 + var_1_20.height + var_1_4

			var_1_12:setPosition(var_1_8.width * var_1_9.x, var_1_7 - var_1_20.height * (1 - var_1_9.y))
		end

		var_1_12:setAnchorPoint(var_1_9)

		if not var_1_0 then
			var_1_6:addChild(var_1_12)
		end
	end

	if var_1_5 == "horizontal" then
		var_1_8.width = var_1_7
	elseif var_1_5 == "vertical" then
		var_1_8.height = var_1_7
	end

	var_1_6:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
	var_1_6:setContentSize(var_1_8)

	return var_1_6
end

function var_0_2.tableLayout(arg_2_0)
	local var_2_0 = arg_2_0.row or 0
	local var_2_1 = arg_2_0.col or 0
	local var_2_2 = arg_2_0.nodes
	local var_2_3 = {}
	local var_2_4 = arg_2_0.align or display.CENTER
	local var_2_5 = arg_2_0.padding or {
		top = 0,
		bottom = 0,
		left = 0,
		right = 0
	}
	local var_2_6 = arg_2_0.spacing or 0
	local var_2_7 = #var_2_2

	if var_2_0 < 1 and var_2_1 > 0 then
		var_2_0 = math.ceil(var_2_7 / var_2_1)
	elseif var_2_1 < 1 and var_2_0 > 0 then
		var_2_1 = math.ceil(var_2_7 / var_2_0)
	end

	local var_2_8 = var_2_0 * var_2_1

	var_0_0.resize(var_2_2, var_2_8)

	local var_2_9
	local var_2_10
	local var_2_11 = 0
	local var_2_12 = var_0_0.array(var_2_0, 0)
	local var_2_13 = 0
	local var_2_14 = var_0_0.array(var_2_1, 0)

	for iter_2_0, iter_2_1 in ipairs(var_2_2) do
		local var_2_15 = math.ceil(iter_2_0 / var_2_1)
		local var_2_16 = (iter_2_0 - 1) % var_2_1 + 1

		if iter_2_1 then
			var_2_10 = iter_2_1:getContentSize()
			var_2_12[var_2_15] = math.max(var_2_12[var_2_15], var_2_10.height)
			var_2_14[var_2_16] = math.max(var_2_14[var_2_16], var_2_10.width)
		else
			var_2_10 = false
		end

		table.insert(var_2_3, var_2_10)
	end

	local var_2_17 = math.max(unpack(var_2_14))
	local var_2_18 = math.max(unpack(var_2_12))
	local var_2_19 = var_2_17 + var_2_5.left + var_2_5.right
	local var_2_20 = var_2_18 + var_2_5.top + var_2_5.bottom
	local var_2_21 = {
		width = 0,
		height = 0,
		width = (var_2_19 + var_2_6) * var_2_1 + var_2_6,
		height = (var_2_20 + var_2_6) * var_2_0 + var_2_6
	}
	local var_2_22 = arg_2_0.size
	local var_2_23 = arg_2_0.parent

	if not var_2_22 then
		if var_2_23 then
			var_2_22 = var_2_23:getContentSize()
		else
			var_2_22 = CCSize(0, 0)
		end
	end

	if arg_2_0.layout then
		var_2_23 = nil
	elseif not var_2_23 then
		var_2_23 = var_0_2.newNode(arg_2_0.debug)
	elseif arg_2_0.debug then
		local var_2_24 = Ctrl.newNode(true)

		var_2_23:addChild(var_2_24)

		var_2_23 = var_2_24
	end

	if var_2_22.width > var_2_21.width then
		var_2_19 = (var_2_22.width - (var_2_1 + 1) * var_2_6) / var_2_1
		var_2_17 = var_2_19 - (var_2_5.left + var_2_5.right)
	else
		var_2_22.width = var_2_21.width
	end

	if var_2_22.height > var_2_21.height then
		var_2_20 = (var_2_22.height - (var_2_0 + 1) * var_2_6) / var_2_0
		var_2_18 = var_2_20 - (var_2_5.top + var_2_5.bottom)
	else
		var_2_22.height = var_2_21.height
	end

	if var_2_23 then
		var_2_23:setContentSize(var_2_22)
	end

	local var_2_25 = display.ANCHOR_POINTS[var_2_4]
	local var_2_26 = var_2_17 * var_2_25.x
	local var_2_27 = var_2_18 * var_2_25.y
	local var_2_28 = -var_2_19
	local var_2_29 = -var_2_20
	local var_2_30

	for iter_2_2 = var_2_8, 1, -1 do
		if var_2_28 + 0.001 < 0 then
			var_2_28 = (var_2_1 - 1) * (var_2_19 + var_2_6) + var_2_6
			var_2_29 = var_2_29 + var_2_20 + var_2_6
		end

		local var_2_31 = var_2_2[iter_2_2]

		if var_2_31 then
			var_2_31:setAnchorPoint(var_2_25)
			var_2_31:setPosition(var_2_28 + var_2_26 + var_2_5.left, var_2_29 + var_2_27 + var_2_5.bottom)

			if var_2_23 then
				var_2_23:addChild(var_2_31)
			end
		end

		var_2_28 = var_2_28 - var_2_19 - var_2_6
	end

	return var_2_23
end

function var_0_2.getPosition(arg_3_0, arg_3_1)
	local var_3_0, var_3_1 = arg_3_0:getPosition()

	if arg_3_1 then
		local var_3_2 = arg_3_0:getParent():convertToWorldSpace(ccp(var_3_0, var_3_1))
		local var_3_3 = arg_3_1:convertToNodeSpace(var_3_2)

		var_3_0, var_3_1 = var_3_3.x, var_3_3.y
	end

	return var_3_0, var_3_1
end

function var_0_2.getRandomColor(arg_4_0)
	local var_4_0 = 180
	local var_4_1 = math.random(100, 200)
	local var_4_2 = var_0_0.shuffle({
		var_4_1 + 40,
		var_4_1 - 40,
		var_4_1
	})

	if arg_4_0 then
		table.insert(var_4_2, var_4_0)

		return ccc4(unpack(var_4_2))
	else
		return ccc3(unpack(var_4_2))
	end
end

function var_0_2.newNode(arg_5_0, ...)
	local var_5_0 = {
		...
	}
	local var_5_1 = false

	if type(arg_5_0) == "table" and arg_5_0.create then
		local var_5_2 = #var_5_0

		if var_5_2 > 0 and type(var_5_0[var_5_2]) == "boolean" then
			var_5_1 = var_5_0[var_5_2]

			table.remove(var_5_0)
		end
	else
		var_5_1 = arg_5_0
		arg_5_0 = CCNode
	end

	if var_5_1 then
		local var_5_3 = display.ANCHOR_POINTS[display.LEFT_BOTTOM]

		arg_5_0 = CCLayerColor:create(var_0_2.getRandomColor(true))

		arg_5_0:setIgnoreAnchorPointForPosition(false)
		arg_5_0:setAnchorPoint(var_5_3)
	else
		arg_5_0 = arg_5_0:create(unpack(var_5_0))
	end

	return CCNodeExtend.extend(arg_5_0)
end

function var_0_2.newLabel(arg_6_0)
	local var_6_0 = type(arg_6_0)

	if var_6_0 == "string" then
		arg_6_0 = {
			text = arg_6_0
		}
	elseif var_6_0 ~= "table" then
		return
	end

	local var_6_1 = arg_6_0.dimensions
	local var_6_2 = arg_6_0.size or 20
	local var_6_3 = arg_6_0.font or _FONT_DEFAULT

	if var_6_1 and var_6_1.height == 0 then
		arg_6_0.fontSize = var_6_2
		arg_6_0.fontName = var_6_3
		arg_6_0.valign = ui.TEXT_VALIGN_TOP
		arg_6_0.width = var_6_1.width
		var_6_1.height = Platform.getStringDrawHeight(arg_6_0)
	end

	arg_6_0.size, arg_6_0.font = Adapter.FontSize(var_6_2), var_6_3

	local var_6_4

	if arg_6_0.outline then
		var_6_4 = ui.newTTFLabelWithOutline(arg_6_0)
	else
		var_6_4 = ui.newTTFLabel(arg_6_0)
	end

	function var_6_4.getContentSize(arg_7_0)
		local var_7_0 = CCNode.getContentSize(arg_7_0)

		if var_6_1 then
			var_7_0.width = var_6_1.width
			var_7_0.height = var_6_1.height
		else
			var_7_0.width = var_7_0.width / Adapter.MinScale
			var_7_0.height = var_7_0.height / Adapter.MinScale
		end

		return var_7_0
	end

	if arg_6_0.outline then
		function var_6_4.setAnchorPoint(arg_8_0, arg_8_1)
			arg_8_0.shadow1:setAnchorPoint(arg_8_1)
			arg_8_0.shadow1:setPosition(1, 0)
			arg_8_0.shadow2:setAnchorPoint(arg_8_1)
			arg_8_0.shadow2:setPosition(-1, 0)
			arg_8_0.shadow3:setAnchorPoint(arg_8_1)
			arg_8_0.shadow3:setPosition(0, -1)
			arg_8_0.shadow4:setAnchorPoint(arg_8_1)
			arg_8_0.shadow4:setPosition(0, 1)
			arg_8_0.label:setAnchorPoint(arg_8_1)
			arg_8_0.label:setPosition(0, 0)
		end

		var_6_4:setAnchorPoint(ccp(0.5, 0.5))
	end

	return var_6_4
end

function var_0_2.newTableView(arg_9_0)
	return createTableView(arg_9_0)
end

function var_0_2.createIndicator(arg_10_0)
	local var_10_0 = 10
	local var_10_1 = 0.4
	local var_10_2 = ccp(0, 0)
	local var_10_3 = ccp(0, 0)
	local var_10_4 = display.newSprite("ui/team/team_087.png")

	var_10_4:setOpacity(200)

	if arg_10_0 == "left" then
		var_10_4:setRotation(180)

		var_10_2.x = -var_10_0
		var_10_3.x = var_10_0
	elseif arg_10_0 == "right" then
		var_10_2.x = var_10_0
		var_10_3.x = -var_10_0
	elseif arg_10_0 == "top" then
		var_10_4:setRotation(-90)

		var_10_2.y = var_10_0
		var_10_3.y = -var_10_0
	elseif arg_10_0 == "bottom" then
		var_10_4:setRotation(90)

		var_10_2.y = -var_10_0
		var_10_3.y = var_10_0
	end

	local var_10_5 = CCArray:create()

	var_10_5:addObject(CCMoveBy:create(var_10_1, var_10_2))
	var_10_5:addObject(CCMoveBy:create(var_10_1, var_10_3))

	local var_10_6 = CCRepeatForever:create(CCSequence:create(var_10_5))

	var_10_4:runAction(var_10_6)

	return var_10_4
end

function var_0_2.newLine(arg_11_0)
	local var_11_0 = ccc4(250, 10, 30, 255)
	local var_11_1 = arg_11_0.from
	local var_11_2 = arg_11_0.to
	local var_11_3 = arg_11_0.color or var_11_0
	local var_11_4 = arg_11_0.width or 5
	local var_11_5 = CCPoint(0, 0)
	local var_11_6 = CCSize(0, 0)
	local var_11_7 = CCLayerColor:create(var_11_3)

	if var_11_1.x == var_11_2.x then
		local var_11_8 = math.abs(var_11_1.y - var_11_2.y)

		var_11_6.width, var_11_6.height = var_11_4, var_11_8
	elseif var_11_1.y == var_11_2.y then
		var_11_6.width, var_11_6.height = math.abs(var_11_1.x - var_11_2.x), var_11_4
	else
		local var_11_9 = 0
		local var_11_10 = 0
		local var_11_11 = 0
		local var_11_12 = 0
		local var_11_13 = var_11_1.x - var_11_2.x
		local var_11_14 = var_11_1.y - var_11_2.y
		local var_11_15 = math.sqrt(var_11_13 * var_11_13 + var_11_14 * var_11_14)

		var_11_6.width, var_11_6.height = var_11_15, var_11_4

		local var_11_16 = math.asin(var_11_14 / var_11_15) / math.pi * 180

		var_11_7:setRotation(var_11_16)
	end

	var_11_5.x, var_11_5.y = (var_11_1.x + var_11_2.x) / 2, (var_11_1.y + var_11_2.y) / 2

	var_11_7:setIgnoreAnchorPointForPosition(false)
	var_11_7:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
	var_11_7:setPosition(var_11_5)
	var_11_7:setContentSize(var_11_6)

	return var_11_7
end

function var_0_2.animate(arg_12_0)
	local var_12_0 = arg_12_0.node
	local var_12_1 = arg_12_0.name
	local var_12_2 = arg_12_0.callback
	local var_12_3 = arg_12_0.duration or 0.4
	local var_12_4 = arg_12_0.from
	local var_12_5 = arg_12_0.to
	local var_12_6 = var_12_0:getBoundingBox()
	local var_12_7 = var_12_6.origin
	local var_12_8 = var_12_6.size
	local var_12_9 = ccp(0, 0)
	local var_12_10
	local var_12_11 = var_12_8.width > var_12_8.height and "width" or "height"

	if var_12_1 == "to" then
		if var_12_8.width > var_12_8.height then
			var_12_9.x, var_12_9.y = 0, 0.5
		else
			var_12_9.x, var_12_9.y = 0.5, 0
		end
	elseif var_12_1 == "back" then
		if var_12_8.width > var_12_8.height then
			var_12_9.x, var_12_9.y = 1, 0.5
		else
			var_12_9.x, var_12_9.y = 0.5, 1
		end
	elseif var_12_1 == "expand" then
		var_12_9.x = 0.5
		var_12_9.y = 0.5
	end

	var_12_0:setAnchorPoint(var_12_9)

	var_12_7.x, var_12_7.y = var_12_7.x + var_12_8.width * var_12_9.x, var_12_7.y + var_12_8.height * var_12_9.y

	var_12_0:setPosition(var_12_7.x, var_12_7.y)

	local var_12_12 = var_12_8[var_12_11]

	var_12_8[var_12_11] = var_12_4

	var_12_0:setContentSize(var_12_8)
	var_12_0:scheduleUpdate(function(arg_13_0)
		local var_13_0 = (var_12_12 - var_12_4) / var_12_3 * arg_13_0
		local var_13_1 = var_12_0:getContentSize()
		local var_13_2 = var_13_1[var_12_11] + var_13_0

		if var_13_0 > 0 and var_13_2 < var_12_12 or var_13_0 < 0 and var_13_2 > var_12_12 then
			var_13_1[var_12_11] = var_13_2

			var_12_0:setContentSize(var_13_1)
		else
			var_13_1[var_12_11] = var_12_12

			var_12_0:setContentSize(var_13_1)
			var_12_0:unscheduleUpdate()

			return var_12_2 and var_12_2()
		end
	end)
end

function var_0_2.showSequeneImage(arg_14_0)
	if not arg_14_0.scale then
		arg_14_0.scale = 1
	end

	local function var_14_0(arg_15_0, arg_15_1)
		local var_15_0 = CCArray:create()
		local var_15_1 = CCScaleTo:create(0.1, arg_14_0.scale + 0.5)
		local var_15_2 = CCScaleTo:create(0.3, arg_14_0.scale)
		local var_15_3 = CCFadeOut:create(0.2)
		local var_15_4 = CCCallFunc:create(function()
			arg_15_1()
		end)

		var_15_0:addObject(var_15_1)
		var_15_0:addObject(var_15_2)
		var_15_0:addObject(var_15_4)
		var_15_0:addObject(var_15_3)

		local var_15_5 = CCArray:create()
		local var_15_6 = CCMoveBy:create(0.6, ccp(0, 85))
		local var_15_7 = CCCallFunc:create(function()
			arg_15_0:removeFromParent()
		end)

		var_15_5:addObject(var_15_6)
		var_15_5:addObject(var_15_7)

		local var_15_8 = CCArray:create()

		var_15_8:addObject(CCSequence:create(var_15_0))
		var_15_8:addObject(CCSequence:create(var_15_5))
		arg_15_0:runAction(CCSpawn:create(var_15_8))

		if arg_14_0.audio then
			playEffect(arg_14_0.audio)
		end
	end

	local function var_14_1(arg_18_0, arg_18_1, arg_18_2)
		local var_18_0

		if type(arg_18_1) == "table" then
			local var_18_1
			local var_18_2 = {}

			for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
				local var_18_3 = display.newSprite(iter_18_1)

				table.insert(var_18_2, var_18_3)
			end

			var_18_0 = var_0_2.linearLayout({
				direction = "horizontal",
				nodes = var_18_2
			})
		else
			var_18_0 = display.newSprite(arg_18_1)
		end

		var_18_0:setAnchorPoint(ccp(0.5, 0))
		var_18_0:setPosition(arg_14_0.x, arg_14_0.y)
		arg_14_0.parent:addChild(var_18_0, 77)
		var_14_0(var_18_0, arg_18_2)
	end

	local function var_14_2()
		return arg_14_0.callback and arg_14_0.callback()
	end

	var_0_0.foreach(arg_14_0.images, var_14_1, var_14_2)
end

function var_0_2.createAvatarTitle(arg_20_0)
	local var_20_0 = getItemName(arg_20_0.Type, arg_20_0.ID)
	local var_20_1 = getItemHeaderImagePath(arg_20_0.Type, arg_20_0.ID)
	local var_20_2 = getItemQuality(arg_20_0.Type, arg_20_0.ID)
	local var_20_3 = getQualityColor(var_20_2)
	local var_20_4 = CCSize(300, 80)
	local var_20_5 = var_0_2.newNode()

	var_20_5:setContentSize(var_20_4)

	local var_20_6 = getQualityBgImageName(var_20_2)
	local var_20_7 = var_20_4.height / 2

	if arg_20_0.Type == ItemType.eEquip then
		local var_20_8 = BaseEquips[arg_20_0.ID].profession

		if arg_20_0.Count > 0 then
			var_20_0 = var_20_0 .. "+" .. arg_20_0.Count
		end

		if var_20_8 == HeroProfession.eNone then
			if IPlatform:instance():getConfig("Channel") == "ZSY_VN" then
				var_20_0 = string.lf("%s\n(通用)", var_20_0)
			else
				var_20_0 = string.lf("%s(通用)", var_20_0)
			end
		elseif IPlatform:instance():getConfig("Channel") == "ZSY_VN" then
			var_20_0 = var_20_0 .. "\n(" .. HeroProfessionNames[var_20_8] .. ")"
		else
			var_20_0 = var_20_0 .. "(" .. HeroProfessionNames[var_20_8] .. ")"
		end

		var_20_7 = var_20_4.height / 7 * 5
	elseif arg_20_0.Type == ItemType.eFragment then
		var_20_7 = var_20_4.height / 7 * 5
	elseif arg_20_0.Type == ItemType.eVIPLevel then
		var_20_0 = var_20_0 .. arg_20_0.Count
	elseif arg_20_0.Type == ItemType.eTianMing then
		local var_20_9 = BaseTianMings[arg_20_0.ID]

		if IPlatform:instance():getConfig("Channel") == "ZSY_VN" then
			var_20_0 = var_20_0 .. "\n(" .. TianMingTypeName[var_20_9.type] .. ")"
		else
			var_20_0 = var_20_0 .. "(" .. TianMingTypeName[var_20_9.type] .. ")"
		end

		var_20_6 = getQualityRoundBgImageName(var_20_2)
	end

	local var_20_10 = display.newSprite(var_20_6)
	local var_20_11 = var_20_10:getContentSize()
	local var_20_12 = display.newSprite(var_20_1)

	var_20_12:setPosition(var_20_11.width / 2, var_20_11.height / 2)
	var_20_10:addChild(var_20_12)
	var_20_10:setPosition(50, var_20_4.height / 2)
	var_20_5:addChild(var_20_10)

	if not arg_20_0.Color then
		arg_20_0.Color = getQualityColor(var_20_2)
	end

	local var_20_13 = var_0_2.newLabel({
		size = 24,
		text = var_20_0,
		color = arg_20_0.Color
	})

	var_20_13:setAnchorPoint(ccp(0, 0.5))
	var_20_13:setPosition(110, var_20_7)
	var_20_5:addChild(var_20_13)

	if arg_20_0.Type == ItemType.eFragment then
		local var_20_14 = BaseFragments[arg_20_0.ID]
		local var_20_15 = var_0_2.newLabel({
			size = 20,
			text = string.lf("合成需要%s个", var_20_14.exchangeCount)
		})

		var_20_15:setAnchorPoint(ccp(0, 0.5))
		var_20_15:setPosition(110, var_20_7 / 5 * 2)
		var_20_5:addChild(var_20_15)
	elseif arg_20_0.Type == ItemType.eEquip then
		local var_20_16 = addQualityStar({
			space = 3,
			scale = 0.9,
			quality = var_20_2
		})

		var_20_16:setPosition(110, var_20_7 * 0.2)
		var_20_5:addChild(var_20_16)
	end

	return var_20_5
end

function var_0_2.createToggleNode(arg_21_0)
	local var_21_0 = type(arg_21_0)
	local var_21_1
	local var_21_2
	local var_21_3
	local var_21_4
	local var_21_5 = "ui/common/common_028.png"
	local var_21_6 = "ui/common/common_029.png"

	if var_21_0 == "function" then
		var_21_4 = arg_21_0
	elseif var_21_0 == "table" then
		var_21_1, var_21_2, var_21_3 = arg_21_0.text, arg_21_0.size, arg_21_0.color
		var_21_4 = arg_21_0.callback
		var_21_5 = arg_21_0.checkoff or var_21_5
		var_21_6 = arg_21_0.checkon or var_21_6
	end

	local var_21_7 = CCMenuItemToggle:create()

	var_21_7:registerScriptTapHandler(var_21_4)

	if var_21_1 then
		local var_21_8 = var_0_2.newLabel({
			text = var_21_1,
			size = var_21_2,
			color = var_21_3
		})

		var_21_8:setAnchorPoint(ccp(0, 0))
		var_21_8:setPosition(50, 10)
		var_21_7:addChild(var_21_8)

		var_21_7.label = var_21_8
	end

	local var_21_9 = ui.newImageMenuItem({
		image = var_21_5
	})
	local var_21_10 = ui.newImageMenuItem({
		image = var_21_6
	})

	var_21_7:addSubItem(var_21_9)
	var_21_7:addSubItem(var_21_10)
	var_21_7:setSelectedIndex(0)

	function var_21_7.setState(arg_22_0, arg_22_1)
		arg_22_0:setSelectedIndex(arg_22_1 and 1 or 0)
	end

	return var_21_7
end

function var_0_2.createToggleButton(arg_23_0)
	local var_23_0 = type(arg_23_0)
	local var_23_1
	local var_23_2
	local var_23_3
	local var_23_4
	local var_23_5 = "ui/common/common_028.png"
	local var_23_6 = "ui/common/common_029.png"

	if var_23_0 == "function" then
		var_23_4 = arg_23_0
	elseif var_23_0 == "table" then
		var_23_1, var_23_2, var_23_3 = arg_23_0.text, arg_23_0.size, arg_23_0.color
		var_23_4 = arg_23_0.callback
		var_23_5 = arg_23_0.checkoff or var_23_5
		var_23_6 = arg_23_0.checkon or var_23_6
	end

	local var_23_7
	local var_23_8 = ui.newControlButton({
		normalImage = var_23_5,
		disabledImage = var_23_5,
		clickAction = function()
			local var_24_0 = not var_23_7.state

			var_23_7:setState(var_24_0)
			var_23_4(var_24_0, var_23_7)
		end
	})

	if var_23_1 then
		local var_23_9 = var_0_2.newLabel({
			text = var_23_1,
			size = var_23_2,
			color = var_23_3
		})

		var_23_7 = var_0_2.linearLayout({
			margin = 5,
			nodes = {
				var_23_9,
				var_23_8
			}
		})
		var_23_7.label = var_23_9
		var_23_7.button = var_23_8
	else
		var_23_7 = var_23_8
	end

	function var_23_7.setState(arg_25_0, arg_25_1)
		local var_25_0 = arg_25_1 and var_23_6 or var_23_5
		local var_25_1 = arg_25_0.button or arg_25_0
		local var_25_2 = display.newScale9Sprite(var_25_0)

		var_25_1:setBackgroundSpriteForState(var_25_2, CCControlStateNormal)

		local var_25_3 = display.newScale9Sprite(var_25_0)

		var_25_1:setBackgroundSpriteForState(var_25_3, CCControlStateHighlighted)

		local var_25_4 = display.newScale9Sprite(var_25_0)

		var_25_1:setBackgroundSpriteForState(var_25_4, CCControlStateDisabled)

		arg_25_0.state = arg_25_1
	end

	return var_23_7
end

function var_0_2.createSliderNode(arg_26_0, arg_26_1, arg_26_2)
	if not arg_26_2 then
		arg_26_2 = arg_26_1
		arg_26_1 = arg_26_0
		arg_26_0 = 1
	end

	local var_26_0 = arg_26_1

	arg_26_1 = math.min(GameMaxNum.ePropPile, math.max(10, arg_26_1))

	local var_26_1 = display.newSprite("ui/system/system_008.png")
	local var_26_2 = var_26_1:getContentSize()
	local var_26_3 = CCControlSlider:create("ui/system/system_008_0.png", "ui/store/bar_count_slider.png", "ui/system/system_006.png")

	var_26_3:setMinimumValue(arg_26_0 - 1)
	var_26_3:setMaximumValue(arg_26_1 - 1)

	local function var_26_4(arg_27_0)
		return math.floor(arg_27_0 / (arg_26_1 / var_26_0)) + 1
	end

	local function var_26_5(arg_28_0)
		return (arg_28_0 - 0.5) * (arg_26_1 / var_26_0)
	end

	local function var_26_6(arg_29_0, arg_29_1)
		arg_29_1 = tolua.cast(arg_29_1, "CCControlSlider")

		local var_29_0 = var_26_4(arg_29_1:getValue())

		return arg_26_2 and arg_26_2(arg_29_1, var_29_0)
	end

	var_26_3:addHandleOfControlEvent(var_26_6, CCControlEventValueChanged)
	var_26_3:setAnchorPoint(ccp(0.5, 0.5))
	var_26_3:setPosition(var_26_2.width / 2, var_26_2.height / 2)
	var_26_1:addChild(var_26_3)

	function var_26_1.getValue(arg_30_0)
		return (var_26_4(var_26_3:getValue()))
	end

	function var_26_1.setValue(arg_31_0, arg_31_1)
		if arg_31_1 < 1 then
			arg_31_1 = 1
		elseif arg_31_1 > arg_26_1 then
			arg_31_1 = arg_26_1
		end

		var_26_3:setValue(var_26_5(arg_31_1))
	end

	return var_26_1
end

function var_0_2.createCounterNode(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	if not arg_32_2 then
		arg_32_2 = arg_32_1
		arg_32_1 = arg_32_0
		arg_32_0 = 1
	end

	arg_32_1 = math.min(GameMaxNum.ePropPile, arg_32_1)

	local var_32_0 = display.ANCHOR_POINTS[display.CENTER]
	local var_32_1 = CCSize(420, 55)
	local var_32_2 = var_0_2.newNode()

	var_32_2:setAnchorPoint(var_32_0)
	var_32_2:setContentSize(var_32_1)

	local var_32_3 = var_32_1.width / 2
	local var_32_4 = var_32_1.height / 2
	local var_32_5 = arg_32_0
	local var_32_6 = CCSize(100, 35)
	local var_32_7 = display.newScale9Sprite("ui/friend/friend_006.png")

	var_32_7:setContentSize(var_32_6)

	local var_32_8 = CCLabelAtlas:create(var_32_5, "uilocal/PK/PK_text_005.png", 27, 37, 48)

	var_32_8:setAnchorPoint(ccp(0.5, 0.5))
	var_32_8:setPosition(var_32_6.width / 2, var_32_6.height / 2)
	var_32_7:addChild(var_32_8)
	var_32_7:setPosition(var_32_3, var_32_4)
	var_32_2:addChild(var_32_7)

	local function var_32_9(arg_33_0, arg_33_1)
		var_32_5 = var_32_5 + arg_33_1

		var_32_2.add1:setEnabled(var_32_5 < arg_32_1)
		var_32_2.minus1:setEnabled(var_32_5 > arg_32_0)
		var_32_2.add10:setEnabled(var_32_5 + 9 < arg_32_1)
		var_32_2.minus10:setEnabled(var_32_5 - 9 > arg_32_0)
		var_32_8:setString(var_32_5)

		return arg_32_2 and arg_32_2(var_32_2, var_32_5)
	end

	local var_32_10 = ui.newControlButton({
		text = "+",
		fontSize = 28,
		disabledImage = "ui/common/common_078.png",
		normalImage = "ui/common/common_027.png",
		size = CCSize(60, 43),
		fontName = _FONT_LISU,
		clickAction = function(arg_34_0, arg_34_1)
			var_32_9(arg_34_1, 1)
		end
	})

	var_32_10:setEnabled(arg_32_0 < arg_32_1)
	var_32_10:setPosition(var_32_3 + 90, var_32_4)
	var_32_2:addChild(var_32_10)

	var_32_2.add1 = var_32_10

	local var_32_11 = ui.newControlButton({
		text = "-",
		fontSize = 24,
		disabledImage = "ui/common/common_078.png",
		normalImage = "ui/common/common_027.png",
		size = CCSize(60, 43),
		fontName = _FONT_LISU,
		clickAction = function(arg_35_0, arg_35_1)
			var_32_9(arg_35_1, -1)
		end
	})

	var_32_11:setEnabled(false)
	var_32_11:setPosition(var_32_3 - 90, var_32_4)
	var_32_2:addChild(var_32_11)

	var_32_2.minus1 = var_32_11

	local var_32_12 = ui.newControlButton({
		text = "+10",
		fontSize = 24,
		disabledImage = "ui/common/common_078.png",
		normalImage = "ui/common/common_027.png",
		size = CCSize(60, 43),
		fontName = _FONT_LISU,
		clickAction = function(arg_36_0, arg_36_1)
			var_32_9(arg_36_1, 10)
		end
	})

	var_32_12:setEnabled(arg_32_1 > 9 + arg_32_0)
	var_32_12:setPosition(var_32_3 + 180, var_32_4)
	var_32_2:addChild(var_32_12)

	var_32_2.add10 = var_32_12

	local var_32_13 = ui.newControlButton({
		text = "-10",
		fontSize = 24,
		disabledImage = "ui/common/common_078.png",
		normalImage = "ui/common/common_027.png",
		size = CCSize(60, 43),
		fontName = _FONT_LISU,
		clickAction = function(arg_37_0, arg_37_1)
			var_32_9(arg_37_1, -10)
		end
	})

	var_32_13:setEnabled(false)
	var_32_13:setPosition(var_32_3 - 180, var_32_4)
	var_32_2:addChild(var_32_13)

	var_32_2.minus10 = var_32_13

	if arg_32_3 then
		var_32_9(nil, arg_32_3 - 1)
	end

	return var_32_2
end

function var_0_2.createRewardNode(arg_38_0, arg_38_1, arg_38_2)
	if not arg_38_0 or #arg_38_0 < 1 then
		return
	end

	arg_38_1 = arg_38_1 or {
		true,
		true,
		true,
		false
	}
	arg_38_2 = arg_38_2 or 25

	local var_38_0 = {}
	local var_38_1 = ccc3(255, 255, 255)
	local var_38_2
	local var_38_3
	local var_38_4
	local var_38_5
	local var_38_6

	for iter_38_0, iter_38_1 in ipairs(arg_38_0) do
		local var_38_7 = getItemName(iter_38_1.Type, iter_38_1.ID)
		local var_38_8 = ""

		if arg_38_1[1] then
			var_38_4 = display.newSprite(getItemHeaderImagePath(iter_38_1.Type, iter_38_1.ID))
		end

		if arg_38_1[2] then
			var_38_8 = var_38_8 .. string.format("%s%s", var_38_7, iter_38_1.Type == ItemType.eSoul and string.lf("魂魄") or "")
		end

		if arg_38_1[3] then
			var_38_8 = var_38_8 .. "x" .. iter_38_1.Count
		end

		if #var_38_8 > 0 then
			if arg_38_1[2] and arg_38_1[4] then
				var_38_6 = getQualityColor(getItemQuality(iter_38_1.Type, iter_38_1.ID))
			else
				var_38_6 = var_38_1
			end

			var_38_3 = var_0_2.newLabel({
				text = var_38_8,
				font = _FONT_DEFAULT,
				size = arg_38_2,
				color = var_38_6
			})
		end

		if var_38_4 and var_38_3 then
			var_38_2 = var_0_2.linearLayout({
				margin = 10,
				direction = "horizontal",
				nodes = {
					var_38_4,
					var_38_3
				}
			})
		else
			var_38_2 = var_38_4 or var_38_3
		end

		table.insert(var_38_0, var_38_2)
	end

	return var_0_2.linearLayout({
		margin = 2,
		direction = "vertical",
		nodes = var_38_0
	})
end

function var_0_2.createRewardList(arg_39_0)
	local var_39_0 = CCSize(380, 80)
	local var_39_1 = CCSize(380, 200)

	arg_39_0 = arg_39_0 or {}
	var_39_1.height = math.max(70, math.min(#arg_39_0 * 70, 260))

	local function var_39_2(arg_40_0, arg_40_1, arg_40_2)
		local var_40_0 = CCLayerColor:create(ccc4(46, 39, 29, 102))

		var_40_0:setContentSize(var_39_0)

		local var_40_1 = getItemHeaderImagePath(arg_40_2.Type, arg_40_2.ID)
		local var_40_2 = display.newSprite(var_40_1)
		local var_40_3 = getItemQuality(arg_40_2.Type, arg_40_2.ID)
		local var_40_4 = getQualityColor(var_40_3)
		local var_40_5 = var_0_2.newLabel({
			size = 20,
			text = getItemName(arg_40_2.Type, arg_40_2.ID) .. "x" .. arg_40_2.Count,
			font = _FONT_DEFAULT,
			color = var_40_4
		})

		var_40_2:setPosition(40, var_39_0.height / 2)
		var_40_5:align(display.LEFT_CENTER, 100, var_39_0.height / 2)
		var_40_0:addChild(var_40_2)
		var_40_0:addChild(var_40_5)

		return var_40_0
	end

	local function var_39_3(arg_41_0, arg_41_1, arg_41_2)
		local var_41_0 = #arg_41_0
		local var_41_1 = {}

		for iter_41_0, iter_41_1 in ipairs(arg_41_0) do
			local var_41_2 = CCNode:create()

			var_41_2:setContentSize(var_39_0)
			table.insert(var_41_1, var_41_2)

			local var_41_3 = var_39_2(var_41_0, iter_41_0, iter_41_1)

			table.insert(var_41_1, var_41_3)
		end

		local var_41_4 = var_0_2.linearLayout({
			margin = 6,
			direction = "vertical",
			nodes = var_41_1,
			align = display.LEFT_BOTTOM
		})
		local var_41_5 = CCScrollView:create(arg_41_1, var_41_4)

		var_41_5:setTouchEnabled(false)

		local var_41_6 = var_39_0.height + 6

		var_41_4:setPosition(0, -var_41_6 * #var_41_1)

		local var_41_7 = math.max(0.3, 0.2 * var_41_0)

		for iter_41_2 = 1, var_41_0 do
			local var_41_8 = var_41_1[iter_41_2]
			local var_41_9 = var_41_1[iter_41_2 * 2]
			local var_41_10, var_41_11 = var_41_8:getPosition()

			var_41_9:runAction(CCMoveTo:create(0.3 * iter_41_2, ccp(var_41_10, var_41_11)))
		end

		local var_41_12 = CCArray:create()

		var_41_12:addObject(CCMoveTo:create(var_41_7, ccp(0, -var_41_6 * var_41_0)))
		var_41_12:addObject(CCDelayTime:create(0.1 * var_41_0))
		var_41_12:addObject(CCCallFunc:create(function()
			var_41_5:removeFromParent()

			return arg_41_2 and arg_41_2()
		end))
		var_41_4:runAction(CCSequence:create(var_41_12))

		return var_41_5
	end

	local var_39_4 = createTableView({
		direction = kCCScrollViewDirectionVertical,
		size = var_39_1,
		dataset = arg_39_0,
		sizehandler = function(arg_43_0, arg_43_1)
			return CCSize(var_39_0.width, var_39_0.height + 6)
		end,
		cellhandler = var_39_2
	})

	var_39_4:setContentOffset(var_39_4:maxContainerOffset())
	var_39_4:setVisible(false)

	local var_39_5 = var_39_3(arg_39_0, var_39_1, function()
		var_39_4:setVisible(true)
	end)
	local var_39_6 = var_0_2.newNode()

	var_39_6:setContentSize(var_39_1)
	var_39_6:addChild(var_39_4)
	var_39_6:addChild(var_39_5)

	return var_39_6
end

function var_0_2.createCheckBox(arg_45_0)
	local var_45_0 = arg_45_0.imageUncheck or "ui/common/common_028.png"
	local var_45_1 = arg_45_0.imageUncheck or "ui/common/common_029.png"
	local var_45_2 = arg_45_0.callBack or function(arg_46_0, arg_46_1)
		return
	end
	local var_45_3 = arg_45_0.textColor or ccc3(255, 255, 255)
	local var_45_4 = display.newNode()
	local var_45_5
	local var_45_6
	local var_45_7 = false
	local var_45_8 = ui.newControlButton({
		normalImage = var_45_0,
		clickAction = function()
			var_45_4:setCheckedState(true)
		end
	})

	var_45_4:addChild(var_45_8)

	local var_45_9 = ui.newControlButton({
		normalImage = var_45_1,
		clickAction = function()
			var_45_4:setCheckedState(false)
		end
	})

	var_45_9:setVisible(false)
	var_45_4:addChild(var_45_9)

	local var_45_10 = var_45_9:getContentSize()
	local var_45_11 = addLabelWithColorSize(var_45_4, arg_45_0.text or "", var_45_3, 22, ccp(0, 0.5), ccp(10 + var_45_10.width, var_45_10.height / 2)):getContentSize()

	if var_45_11.width > 0 then
		var_45_11.width = var_45_11.width + 10
	end

	local var_45_12 = CCSizeMake(var_45_10.width + var_45_11.width, math.max(var_45_10.height, var_45_11.height))

	var_45_4:setContentSize(var_45_12)
	var_45_4:setAnchorPoint(ccp(0.5, 0.5))
	var_45_8:setPosition(var_45_10.width / 2, var_45_12.height / 2)
	var_45_9:setPosition(var_45_10.width / 2, var_45_12.height / 2)

	function var_45_4.setCheckedState(arg_49_0, arg_49_1)
		var_45_7 = arg_49_1

		var_45_8:setVisible(not var_45_7)
		var_45_9:setVisible(var_45_7)
		var_45_2(arg_49_0, var_45_7)
	end

	function var_45_4.getCheckedState(arg_50_0)
		return var_45_7
	end

	return var_45_4
end

return var_0_2
