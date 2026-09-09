local var_0_0 = class("PropsTujianLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0)
	local var_2_0 = arg_2_0:showSubPageContentLayer()

	arg_2_0:addChild(var_2_0)
end

function var_0_0.showSubPageContentLayer(arg_3_0)
	local var_3_0 = display.newNode()
	local var_3_1 = display.newScale9Sprite("ui/team/bg_tab_memoir.png", 480, 265, CCSize(920, 490))

	var_3_0:addChild(var_3_1)

	local var_3_2 = CCScrollView:create(CCSize(822, 440))

	var_3_2:setPosition(70, 32)
	var_3_2:setDirection(kCCScrollViewDirectionVertical)
	var_3_0:addChild(var_3_2)

	local var_3_3 = 0

	for iter_3_0, iter_3_1 in pairs(BaseHeros) do
		local var_3_4 = var_3_3 % 6 * 137
		local var_3_5 = 440 - math.floor(var_3_3 / 6) * 137 - 137
		local var_3_6 = CCSprite:create("header/small_lingbaodaoren.png")

		var_3_6:setPosition(var_3_4, var_3_5)
		var_3_6:ignoreAnchorPointForPosition(false)
		var_3_6:setAnchorPoint(ccp(0.5, 0.5))
		var_3_2:addChild(var_3_6)

		local var_3_7 = ui.newTTFLabel({
			text = iter_3_1.name,
			size = Adapter.FontSize(24),
			x = var_3_4,
			y = var_3_5 - 30,
			color = ccc3(255, 255, 213),
			align = ui.TEXT_ALIGN_CENTER,
			valign = ui.TEXT_VALIGN_CENTER,
			dimensions = CCSize(140, 25)
		})

		var_3_7:ignoreAnchorPointForPosition(false)
		var_3_7:setAnchorPoint(ccp(0.5, 0.5))
		var_3_2:addChild(var_3_7)

		var_3_3 = var_3_3 + 1
	end

	var_3_2:setContentSize(CCSize(822, math.floor(var_3_3 / 6) * 137 + 137))

	return var_3_0
end

return var_0_0
