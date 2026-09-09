require("data.player")

local var_0_0 = class("HeroScene", function()
	return display.newScene("HeroScene")
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	local var_2_0 = require("scenes.CommonBgLayer").new({
		titleSprite = "uilocal/team/team_text_022.png"
	})

	arg_2_0:addChild(var_2_0)

	arg_2_0.bgSprite = var_2_0:getBackgroundSprite()

	local var_2_1 = createPlayerAttrNode({
		ItemType.eGold,
		ItemType.eCoin
	})

	var_2_1:setPosition(490, 578)
	arg_2_0.bgSprite:addChild(var_2_1)

	local var_2_2 = require("scenes.bag.FigureLayer").new({})

	var_2_2:setContentSize(CCSize(CONFIG_SCREEN_WIDTH, CONFIG_SCREEN_HEIGHT))
	arg_2_0.bgSprite:addChild(var_2_2)
end

return var_0_0
