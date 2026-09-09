require("data.player")

local var_0_0 = class("BagScene", function()
	return display.newScene("BagScene")
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	local var_2_0 = require("scenes.CommonBgLayer").new({
		titleSprite = "uilocal/bag/bag_txt_005.png"
	})

	arg_2_0:addChild(var_2_0)

	arg_2_0.bgSprite = var_2_0:getBackgroundSprite()

	if arg_2_0.figureLayer ~= nil then
		arg_2_0.figureLayer:setVisible(false)
	end

	if arg_2_0.bagLayer == nil then
		arg_2_0.bagLayer = require("scenes.bag.BagLayer").new({})

		arg_2_0.bagLayer:setContentSize(CCSize(CONFIG_SCREEN_WIDTH, CONFIG_SCREEN_HEIGHT))
		arg_2_0.bgSprite:addChild(arg_2_0.bagLayer)
	end

	arg_2_0.bagLayer:setVisible(true)

	local var_2_1 = createPlayerAttrNode({
		ItemType.eGold,
		ItemType.eCoin
	})

	var_2_1:setPosition(490, 578)
	arg_2_0.bgSprite:addChild(var_2_1)
end

return var_0_0
