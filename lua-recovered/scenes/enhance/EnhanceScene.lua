require("base.figure")

local var_0_0 = class("EnhanceScene", function()
	return display.newScene("EnhanceScene")
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.params = arg_2_1

	local var_2_0 = require("scenes.CommonBgLayer").new({
		titleSprite = "uilocal/enhance/enhance_txt_008.png",
		returnAction = function(arg_3_0, arg_3_1)
			if arg_2_0.params and arg_2_0.params.returnAction then
				arg_2_0.params.returnAction()
			else
				game.enterHomeScene()
			end
		end
	})

	arg_2_0:addChild(var_2_0)

	arg_2_0.bgSprite = var_2_0:getBackgroundSprite()

	local var_2_1 = createPlayerAttrNode({
		ItemType.eEquipInheritPoint,
		ItemType.eGold,
		ItemType.eCoin
	})

	var_2_1:setPosition(260, 578)
	arg_2_0.bgSprite:addChild(var_2_1)

	local var_2_2 = require("scenes.enhance.EnhanceLayer").new({
		enhanceScene = arg_2_0,
		from = arg_2_0.params.from
	})

	var_2_2:setContentSize(CCSize(CONFIG_SCREEN_WIDTH, CONFIG_SCREEN_HEIGHT))
	arg_2_0.bgSprite:addChild(var_2_2)
	GuideLayer:showGuideLayer(arg_2_0, arg_2_0.bgSprite, TaskEntryType.eEntryTalismanFeed, 2, nil, true)
	GuideLayer:showGuideLayer(arg_2_0, arg_2_0.bgSprite, TaskEntryType.eEntryTalismanRecast, 2, nil, true)
end

return var_0_0
