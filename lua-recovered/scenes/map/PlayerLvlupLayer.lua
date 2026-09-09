require("data.feature")

local var_0_0 = class("PlayerLvlupLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)
local var_0_1 = display.cx
local var_0_2 = display.cy + 20

function var_0_0.ctor(arg_2_0, arg_2_1)
	local function var_2_0(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end

	arg_2_0:addTouchEventListener(var_2_0, false, 0, true)
	arg_2_0:setTouchEnabled(true)

	local var_2_1 = Player.level <= getMaxFeatureLevel()
	local var_2_2 = var_2_1
	local var_2_3 = getLevelNewFeatureList(Player.level)
	local var_2_4 = table.getn(var_2_3) == 0 and true or false
	local var_2_5 = var_2_4 and "battle_050.png" or "battle_051.png"

	if not var_2_4 or not ccp(var_0_1, var_0_2 - 70) then
		local var_2_6 = ccp(var_0_1, var_0_2)
	end

	local var_2_7 = CCSprite:create("ui/battle/" .. var_2_5)

	var_2_7:setPosition(var_0_1, var_0_2 - (var_2_4 and 70 or 0))
	arg_2_0:addChild(var_2_7)

	local var_2_8 = ui.newControlButton({
		scaleY = 1,
		normalImage = "ui/common/common_105.png",
		scaleX = 1,
		text = string.lf("确定"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		fontName = _FONT_LISU,
		clickAction = function(arg_4_0, arg_4_1)
			arg_2_0:close()
		end,
		position = CCPoint(var_0_1, var_0_2 - (var_2_4 and 255 or 110))
	})

	arg_2_0:addChild(var_2_8)

	local var_2_9 = ui.newTTFLabelWithOutline({
		text = "LV " .. arg_2_1.levelold .. "  → #30A104" .. arg_2_1.levelnew,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(26),
		align = ui.TEXT_ALIGN_CENTER
	})

	arg_2_0:addChild(var_2_9)
	var_2_9:setColor(ccc3(246, 206, 108))
	var_2_9:setPosition(var_0_1, var_0_2 + 119)

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.reward) do
		local var_2_10 = figure.createHeader({
			isName = true,
			type = iter_2_1.Type,
			itemId = iter_2_1.ID,
			count = iter_2_1.Count
		})

		var_2_10:setPosition(var_0_1 - 150 + 110 * (iter_2_0 - 1), var_0_2 + 8)
		arg_2_0:addChild(var_2_10)
	end

	if var_2_1 then
		if table.getn(var_2_3) == 0 then
			local var_2_11, var_2_12 = getLevelNextFeatureList(Player.level)
			local var_2_13 = var_2_12[1].name

			for iter_2_2, iter_2_3 in ipairs(var_2_12) do
				if iter_2_2 ~= 1 then
					var_2_13 = var_2_13 .. "、" .. iter_2_3.name
				end
			end

			local var_2_14 = ui.newTTFLabel({
				text = string.lf("%d级开放功能 %s !", var_2_11, var_2_13),
				font = _FONT_DEFAULT,
				size = Adapter.FontSize(20),
				align = ui.TEXT_ALIGN_LEFT
			})

			var_2_14:setPosition(var_0_1 - 180, var_0_2 - 145)
			var_2_14:setAnchorPoint(ccp(0, 0.5))
			arg_2_0:addChild(var_2_14)
		elseif Player:getTroMaxStep() >= 25 then
			arg_2_0.newSystemLayer = require("scenes.map.NewSystemOpenLayer").new({
				featureList = var_2_3,
				parrent = arg_2_0
			})

			arg_2_0:addChild(arg_2_0.newSystemLayer, 1)
		end
	end

	arg_2_0:open(var_2_7)
end

function var_0_0.close(arg_5_0)
	local var_5_0 = CCArray:create()

	var_5_0:addObject(CCEaseBackIn:create(CCScaleTo:create(0.5, 0.01)))
	var_5_0:addObject(CCCallFunc:create(function(...)
		arg_5_0:removeFromParentAndCleanup(true)
	end))
	arg_5_0:runAction(CCSequence:create(var_5_0))
end

function var_0_0.open(arg_7_0, arg_7_1)
	local function var_7_0()
		if arg_7_0.newSystemLayer then
			arg_7_0.newSystemLayer:open()
		end
	end

	local var_7_1 = CCArray:create()

	var_7_1:addObject(CCEaseBackOut:create(CCScaleTo:create(0.5, Adapter.MinScale)))
	var_7_1:addObject(CCCallFunc:create(function(...)
		local var_9_0 = CCSkeletonAnimation:createWithFile("uilocal/battle/ui_gongxishengji.json", "uilocal/battle/ui_gongxishengji.atlas", 1)

		var_9_0:setAnimation("animation", false, 0)
		var_9_0:setPosition(var_0_1, var_0_2 + 160)
		arg_7_0:addChild(var_9_0)
	end))
	var_7_1:addObject(CCCallFunc:create(var_7_0))
	arg_7_0:runAction(CCSequence:create(var_7_1))
end

return var_0_0
