require("network.TowerRequest")

local var_0_0 = class("AddedPropertyLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create(ccc4(10, 10, 10, 180)))
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		return true
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.bgSprite = display.newScale9Sprite("ui/common/common_116.png", display.cx, display.cy)

	arg_2_0.bgSprite:setPreferredSize(CCSizeMake(461, 437))
	arg_2_0.bgSprite:setAnchorPoint(ccp(0.5, 0.5))
	arg_2_0.bgSprite:setPosition(Adapter.AutoPos(480, 280))
	arg_2_0.bgSprite:setScale(Adapter.MinScale)
	arg_2_0:addChild(arg_2_0.bgSprite)

	local function var_2_0()
		arg_2_0:removeFromParentAndCleanup(true)
	end

	local var_2_1 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		position = ccp(450, 420),
		clickAction = var_2_0
	})

	arg_2_0.bgSprite:addChild(var_2_1)
	arg_2_0:initRequests()
	arg_2_0.buffAddtionsRequest:request()
	arg_2_0:showTitleSprite()
end

function var_0_0.initRequests(arg_5_0)
	local function var_5_0()
		arg_5_0.addedBuffList = arg_5_0.buffAddtionsRequest:getAddedProperty()

		arg_5_0:showAddedBuffInfo()
	end

	arg_5_0.buffAddtionsRequest = BuffAddtionsRequest:new()

	arg_5_0.buffAddtionsRequest:setResponseNormalHandler(var_5_0)
end

function var_0_0.showTitleSprite(arg_7_0)
	local var_7_0 = {
		{
			spriteName = "ui/tower/tower_054.png"
		},
		{
			spriteName = "ui/tower/tower_053.png"
		}
	}

	for iter_7_0 = 1, 2 do
		local var_7_1 = display.newSprite(var_7_0[iter_7_0].spriteName)

		var_7_1:setPosition(ccp(190, 205 * iter_7_0))
		arg_7_0.bgSprite:addChild(var_7_1)
	end
end

function var_0_0.showAddedBuffInfo(arg_8_0)
	dump(arg_8_0.addedBuffList)

	local var_8_0 = 0
	local var_8_1 = 0

	for iter_8_0, iter_8_1 in ipairs(Player.team.groupList) do
		local var_8_2 = 0
		local var_8_3 = 0
		local var_8_4

		if iter_8_1.battleIx < 4 then
			var_8_0 = var_8_0 + 1
			var_8_2 = var_8_0 * 120 - 10
			var_8_4 = 345
		else
			var_8_1 = var_8_1 + 1
			var_8_2 = var_8_1 * 120 - 10
			var_8_4 = 140
		end

		local var_8_5 = {
			type = ItemType.eHero,
			itemId = iter_8_1.heroId
		}

		var_8_5.isName = false

		local var_8_6 = figure.createHeader(var_8_5)

		var_8_6:setPosition(var_8_2, var_8_4)
		arg_8_0.bgSprite:addChild(var_8_6)
		Adapter.NodeAbsScale(var_8_6)
	end

	AddRangeType = {
		eFront = 0,
		eBack = 1,
		eAll = 2
	}

	local var_8_7 = {}
	local var_8_8 = {}

	for iter_8_2, iter_8_3 in ipairs(arg_8_0.addedBuffList) do
		local var_8_9 = iter_8_3.addtionProperty
		local var_8_10 = iter_8_3.addtionRate

		if iter_8_3.range == AddRangeType.eFront or iter_8_3.range == AddRangeType.eAll then
			local var_8_11 = false

			for iter_8_4, iter_8_5 in ipairs(var_8_7) do
				if iter_8_5.addtionProperty == var_8_9 then
					iter_8_5.addtionRate = iter_8_5.addtionRate + var_8_10
					var_8_11 = true
				end
			end

			if not var_8_11 then
				table.insert(var_8_7, iter_8_3)
			end
		elseif iter_8_3.range == AddRangeType.eBack or iter_8_3.range == AddRangeType.eAll then
			local var_8_12 = false

			for iter_8_6, iter_8_7 in ipairs(var_8_8) do
				if iter_8_7.addtionProperty == var_8_9 then
					iter_8_7.addtionRate = iter_8_7.addtionRate + var_8_10
					var_8_12 = true
				end
			end

			if not var_8_12 then
				table.insert(var_8_8, iter_8_3)
			end
		end

		print(BattleAttrsName[var_8_9])
	end

	local var_8_13 = ""
	local var_8_14 = ""
	local var_8_15 = 1

	for iter_8_8 = 1, #var_8_7 do
		local var_8_16 = var_8_7[iter_8_8]

		var_8_13 = var_8_13 .. "#FFFFFF" .. BattleAttrsName[var_8_16.addtionProperty] .. " #00FF00+" .. var_8_16.addtionRate * 100 .. "%" .. "   "

		if var_8_15 % 3 == 0 then
			var_8_13 = var_8_13 .. "\n"
		end

		var_8_15 = var_8_15 + 1
	end

	local var_8_17 = 1

	for iter_8_9 = 1, #var_8_8 do
		local var_8_18 = var_8_8[iter_8_9]

		var_8_14 = var_8_14 .. "#FFFFFF" .. BattleAttrsName[var_8_18.addtionProperty] .. " #00FF00+" .. var_8_18.addtionRate * 100 .. "%" .. "   "

		if var_8_17 % 3 == 0 then
			var_8_14 = var_8_14 .. "\n"
		end

		var_8_17 = var_8_17 + 1
	end

	print(var_8_13)
	print(var_8_14)

	local var_8_19 = {
		{
			x = 20,
			y = 205,
			title = var_8_13,
			size = CCSize(400, 200)
		},
		{
			x = 20,
			y = 0,
			title = var_8_14,
			size = CCSize(400, 200)
		}
	}

	for iter_8_10, iter_8_11 in ipairs(var_8_19) do
		local var_8_20 = ui.newTTFLabel({
			text = iter_8_11.title,
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(20),
			align = ui.TEXT_ALIGN_LEFT,
			valign = ui.TEXT_VALIGN_TOP,
			dimensions = iter_8_11.size,
			x = iter_8_11.x,
			y = iter_8_11.y
		})

		arg_8_0.bgSprite:addChild(var_8_20)
		Adapter.NodeAbsScale(var_8_20)
	end
end

return var_0_0
