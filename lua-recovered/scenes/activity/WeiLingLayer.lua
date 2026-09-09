require("data.player")
require("base.functions")
require("base.figure")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = class("WeiLingLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create(ccc4(10, 10, 10, 160)))
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0.parent = arg_2_1.parent
	arg_2_0.callback = arg_2_1.callback

	local var_2_0 = CCSize(CONFIG_SCREEN_WIDTH, CONFIG_SCREEN_HEIGHT)

	arg_2_0:setContentSize(var_2_0)

	local var_2_1 = arg_2_0:createPopupBox(arg_2_1, function(arg_3_0, ...)
		if arg_3_0 then
			arg_2_0.callback(...)
		else
			arg_2_0:removeFromParentAndCleanup(true)
		end
	end)

	var_2_1:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_1:setPosition(var_2_0.width / 2, var_2_0.height / 2)
	arg_2_0:addChild(var_2_1)

	arg_2_0.dialog = var_2_1

	arg_2_0:addTouchEventListener(function(arg_4_0, arg_4_1, arg_4_2)
		return true
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)
end

function var_0_1.createTeamList(arg_5_0)
	local var_5_0 = var_0_0.newNode()
	local var_5_1 = CCSize(115, 145)
	local var_5_2 = {}
	local var_5_3 = {}
	local var_5_4 = Player.team.groupList

	for iter_5_0, iter_5_1 in ipairs(var_5_4) do
		if iter_5_1.heroId > 0 then
			local var_5_5 = var_0_0.newNode()

			var_5_5:setContentSize(var_5_1)

			var_5_3.type = ItemType.eHero
			var_5_3.itemId = iter_5_1.heroId
			var_5_3.isName = true

			function var_5_3.clickAction(arg_6_0, arg_6_1)
				arg_6_1 = tolua.cast(arg_6_1, "CCControlButton")

				var_5_0:setIndex(iter_5_0)
			end

			local var_5_6 = BaseHeros[iter_5_1.heroId].quality
			local var_5_7 = getQualityColor(var_5_6)
			local var_5_8 = figure.createHeader(var_5_3)

			var_5_8:setPosition(var_5_1.width / 2, var_5_1.height / 2 + 20)
			var_5_8:setNameLabelColor(var_5_7)
			var_5_5:addChild(var_5_8)

			local var_5_9 = var_0_0.newLabel({
				text = string.lf("潜力：%d", tostring(iter_5_1.potency)),
				color = var_5_7
			})

			var_5_9:setPosition(var_5_1.width / 2, 20)
			var_5_5:addChild(var_5_9)
			table.insert(var_5_2, var_5_5)
		end
	end

	var_0_0.linearLayout({
		margin = 1,
		parent = var_5_0,
		nodes = var_5_2
	})

	local var_5_10 = display.newScale9Sprite("ui/common/bg_common.png")

	var_5_10:setPreferredSize(var_5_1)
	var_5_0:addChild(var_5_10, -1)

	var_5_0.index = -1
	var_5_0.nodes = var_5_2
	var_5_0.cursor = var_5_10
	var_5_0.dataset = var_5_4

	function var_5_0.setIndex(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0.index
		local var_7_1 = arg_7_0.cursor
		local var_7_2, var_7_3 = arg_7_0.nodes[arg_7_1]:getPosition()

		var_7_1:setPosition(var_7_2, var_7_3)

		arg_7_0.index = arg_7_1
	end

	function var_5_0.getHeroId(arg_8_0)
		local var_8_0 = arg_8_0.index

		return arg_8_0.dataset[var_8_0].heroId
	end

	var_5_0:setIndex(1)

	return var_5_0
end

function var_0_1.createPopupBox(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = CCSize(710, 350)
	local var_9_1 = display.newScale9Sprite("ui/common/common_050.png")

	var_9_1:setPreferredSize(var_9_0)

	local var_9_2 = display.newSprite("uilocal/activity/activity_text_015.png")

	var_9_2:setPosition(var_9_0.width / 2, var_9_0.height - 40)
	var_9_1:addChild(var_9_2)

	local var_9_3 = arg_9_0:createTeamList()

	var_9_3:setAnchorPoint(ccp(0.5, 0.5))
	var_9_3:setPosition(var_9_0.width / 2, 200)
	var_9_1:addChild(var_9_3)

	local var_9_4 = ui.newControlButton({
		normalImage = "ui/common/common_018.png",
		highlightedImage = "ui/common/common_018.png",
		text = string.lf("取消"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_10_0, arg_10_1)
			arg_9_2(false)
		end
	})
	local var_9_5 = ui.newControlButton({
		normalImage = "ui/common/common_018.png",
		highlightedImage = "ui/common/common_018.png",
		text = string.lf("确定"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_11_0, arg_11_1)
			local var_11_0 = var_9_3:getHeroId()

			arg_9_2(true, var_11_0)
		end
	})

	var_9_5:setPosition(var_9_0.width / 2 - 100, 50)
	var_9_4:setPosition(var_9_0.width / 2 + 100, 50)
	var_9_1:addChild(var_9_4)
	var_9_1:addChild(var_9_5)

	return var_9_1
end

function var_0_1.showPopupMessage(arg_12_0)
	showFlashImage({
		image = "uilocal/enhance/enhance_txt_007.png",
		scale = 0.8,
		parent = arg_12_0.dialog,
		position = CCPoint(280, 60),
		callback = function()
			arg_12_0:removeFromParentAndCleanup(true)
		end
	})
end

return var_0_1
