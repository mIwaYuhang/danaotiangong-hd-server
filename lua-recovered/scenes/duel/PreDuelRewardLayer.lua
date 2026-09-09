require("base.figure")
require("data.duel")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("PreDuelRewardLayer", function()
	return CCLayerColor:create(ccc4(10, 10, 10, 180))
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.scoreCallback = arg_2_1.scoreCallback
	arg_2_0.currentScore = arg_2_1.currentScore

	local var_2_0 = display.newScale9Sprite("ui/duel/duel_018.png")

	arg_2_0.bgSize = CCSize(941, 569)

	var_2_0:setPreferredSize(arg_2_0.bgSize)
	var_2_0:setScale(Adapter.MinScale)
	var_2_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_0:setPosition(display.cx, display.cy)
	arg_2_0:addChild(var_2_0)

	arg_2_0.background = CCNode:create()

	arg_2_0.background:setContentSize(arg_2_0.bgSize)
	var_2_0:addChild(arg_2_0.background)

	local var_2_1 = display.newSprite("uilocal/duel/duel_text_014.png")

	var_2_1:setAnchorPoint(ccp(0.5, 0.5))
	var_2_1:setPosition(470, 520)
	var_2_0:addChild(var_2_1)

	local var_2_2 = string.lf("每日奖励当天结算, 三日奖励3天结算一次, 随后积分重置, 重新开始新的分组比赛~")
	local var_2_3 = ui.newTTFLabel({
		y = 465,
		x = 470,
		text = var_2_2,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(22),
		color = ccc3(255, 255, 0),
		align = ui.TEXT_ALIGN_CENTER,
		valign = ui.TEXT_VALIGN_CENTER,
		dimensions = CCSize(860, 40)
	})

	var_2_0:addChild(var_2_3)

	local var_2_4 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		highlightedImage = "ui/common/btn_closed.png",
		position = ccp(arg_2_0.bgSize.width - 30, arg_2_0.bgSize.height - 20),
		clickAction = function()
			arg_2_0:removeFromParentAndCleanup(true)
		end
	})

	var_2_0:addChild(var_2_4)
	arg_2_0:showRewardInfo()
end

function var_0_1.showRewardInfo(arg_5_0)
	local function var_5_0(arg_6_0)
		return 166, 853
	end

	local function var_5_1(arg_7_0)
		return table.nums(DuelRankReward)
	end

	local function var_5_2(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_0:cellAtIndex(arg_8_1)

		if var_8_0 == nil then
			var_8_0 = CCTableViewCell:new()

			local var_8_1 = arg_5_0:showRewardCell(arg_8_1)
			local var_8_2 = var_8_1:getContentSize()

			var_8_0:addChild(var_8_1)
		end

		return var_8_0
	end

	local var_5_3, var_5_4 = var_5_0(nil)
	local var_5_5 = CCTableView:create(CCSize(860, 440))

	var_5_5:setContentSize(CCSize(860, var_5_1(nil) * var_5_3))
	var_5_5:setPosition((arg_5_0.bgSize.width - 860) / 2, 8)
	var_5_5:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_5_5:setDirection(kCCScrollViewDirectionVertical)
	arg_5_0.background:addChild(var_5_5)

	arg_5_0.tableView = var_5_5

	var_5_5:registerScriptHandler(var_5_0, CCTableView.kTableCellSizeForIndex)
	var_5_5:registerScriptHandler(var_5_1, CCTableView.kNumberOfCellsInTableView)
	var_5_5:registerScriptHandler(var_5_2, CCTableView.kTableCellSizeAtIndex)
	var_5_5:reloadData()
	var_5_5:setContentOffset(var_5_5:minContainerOffset())
end

function var_0_1.showRewardCell(arg_9_0, arg_9_1)
	local var_9_0 = display.newSprite("ui/duel/duel_011.png", 430, 83)
	local var_9_1 = var_9_0:getContentSize()

	local function var_9_2(arg_10_0)
		if arg_10_0 == 1 then
			return "uilocal/PK/PK_text_012.png"
		elseif arg_10_0 == 2 then
			return "uilocal/PK/PK_text_013.png"
		elseif arg_10_0 == 3 then
			return "uilocal/PK/PK_text_014.png"
		elseif arg_10_0 == 4 then
			return "uilocal/PK/PK_text_029.png"
		elseif arg_10_0 == 5 then
			return "uilocal/PK/PK_text_044.png"
		elseif arg_10_0 == 6 then
			return "uilocal/PK/PK_text_034.png"
		elseif arg_10_0 == 7 then
			return "uilocal/PK/PK_text_035.png"
		elseif arg_10_0 == 8 then
			return "uilocal/PK/PK_text_036.png"
		elseif arg_10_0 == 9 then
			return "uilocal/PK/PK_text_037.png"
		elseif arg_10_0 == 10 then
			return "uilocal/PK/PK_text_038.png"
		elseif arg_10_0 == 11 then
			return "uilocal/PK/PK_text_039.png"
		elseif arg_10_0 == 12 then
			return "uilocal/PK/PK_text_045.png"
		else
			return "uilocal/PK/PK_text_045.png"
		end
	end

	print(arg_9_1)

	local var_9_3 = display.newSprite(var_9_2(arg_9_1 + 1), 105, var_9_1.height / 2)

	var_9_3:setAnchorPoint(CCPoint(0.5, 0.5))
	var_9_0:addChild(var_9_3)
	addLabelWithColorSize(var_9_0, string.lf("三日奖励"), ccc3(0, 0, 0), 20, CCPoint(0, 1), CCPoint(350, var_9_1.height / 2 + 70))
	addLabelWithColorSize(var_9_0, string.lf("每日奖励"), ccc3(0, 0, 0), 20, CCPoint(0, 1), CCPoint(680, var_9_1.height / 2 + 70))

	local var_9_4 = display.newSprite("ui/common/common_043.png", 200, var_9_1.height / 2 - 10)

	var_9_4:setAnchorPoint(CCPoint(0.5, 0.5))
	var_9_0:addChild(var_9_4)
	var_9_4:setRotation(270)

	local var_9_5 = display.newSprite("ui/common/common_043.png", 570, var_9_1.height / 2 - 10)

	var_9_5:setAnchorPoint(CCPoint(0.5, 0.5))
	var_9_0:addChild(var_9_5)
	var_9_5:setRotation(90)

	local var_9_6 = CCSize(110, 140)

	for iter_9_0 = 1, 2 do
		local var_9_7 = iter_9_0 == 1 and CCSize(320, 160) or CCSize(200, 160)
		local var_9_8 = iter_9_0 == 1 and DuelRankReward[arg_9_1 + 1].rankDropList or DuelDailyReward[arg_9_1 + 1].dailyDropList
		local var_9_9 = iter_9_0 == 1 and 225 or 615
		local var_9_10 = createTableView({
			reverse = true,
			size = var_9_7,
			direction = kCCScrollViewDirectionHorizontal,
			dataset = var_9_8,
			sizehandler = function(arg_11_0, arg_11_1)
				return var_9_6
			end,
			cellhandler = function(arg_12_0, arg_12_1, arg_12_2)
				local var_12_0 = CCLayerColor:create(ccc4(0, 0, 0, 0))

				var_12_0:setContentSize(var_9_6)

				local var_12_1

				if arg_12_2.Type == ItemType.eHero or arg_12_2.Type == ItemType.eSoul or arg_12_2.Type == ItemType.eEquip or arg_12_2.Type == ItemType.eFragment or arg_12_2.Type == ItemType.eProp then
					function var_12_1()
						var_0_0.tipshandler(arg_12_2)
					end
				end

				local var_12_2 = figure.createHeader({
					isName = false,
					inTeam = false,
					itemId = arg_12_2.ID ~= nil and arg_12_2.ID or 0,
					type = arg_12_2.Type,
					count = arg_12_2.Count,
					clickAction = var_12_1
				})

				var_12_2:setAnchorPoint(CCPoint(0.5, 0.5))
				var_12_2:setPosition(var_9_6.width / 2, var_9_6.height / 2 + 10)
				var_12_0:addChild(var_12_2)

				local var_12_3 = getQualityColor(getItemQuality(arg_12_2.Type, arg_12_2.ID))

				addLabelWithColorSize(var_12_0, getItemName(arg_12_2.Type, arg_12_2.ID), var_12_3, 20, CCPoint(0.5, 0), CCPoint(var_9_6.width / 2, 10))

				return var_12_0
			end
		})

		var_9_10:setPosition(var_9_9, 5)
		var_9_0:addChild(var_9_10)
	end

	return var_9_0
end

return var_0_1
