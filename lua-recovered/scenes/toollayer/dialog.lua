require("network.PropRequest")

local var_0_0 = require("scenes.toollayer.herobase")
local var_0_1 = require("scenes.toollayer.tool")
local var_0_2 = require("scenes.toollayer.ctrl")
local var_0_3 = require("scenes.toollayer.layer")
local var_0_4 = {}

local function var_0_5(arg_1_0, arg_1_1)
	BattleOperator:startBattle(eBattleType.ChampionShip, {
		attackPlayerID = arg_1_0,
		defendPlayerID = arg_1_1
	}, function(arg_2_0, arg_2_1)
		game.enterCSGambleScene()
	end)
end

local function var_0_6(arg_3_0, arg_3_1)
	local var_3_0 = ccc3(0, 195, 10)
	local var_3_1 = ccc3(240, 240, 180)
	local var_3_2 = arg_3_0:getContentSize()
	local var_3_3 = getItemHeaderImagePath(ItemType.eHero, arg_3_1.header)
	local var_3_4 = ui.newControlButton({
		normalImage = var_3_3,
		clickAction = function(arg_4_0, arg_4_1)
			return
		end
	})

	var_3_4:setPosition(var_3_2.width / 2, var_3_2.height / 2)
	arg_3_0:addChild(var_3_4)

	local var_3_5 = var_0_2.newLabel({
		text = arg_3_1.name,
		color = Player.userId == arg_3_1.id and var_3_0 or var_3_1
	})

	var_3_5:setPosition(var_3_2.width / 2, -12)
	arg_3_0:addChild(var_3_5)

	local var_3_6 = var_0_2.newLabel({
		text = string.lf("战力: %s", arg_3_1.power),
		color = Player.userId == arg_3_1.id and var_3_0 or var_3_1
	})

	var_3_6:setPosition(var_3_2.width / 2, -34)
	arg_3_0:addChild(var_3_6)

	local var_3_7 = display.newSprite(arg_3_1.status and "ui/PK/PK_035.png" or "ui/PK/PK_036.png")

	var_3_7:setPosition(20, 75)
	arg_3_0:addChild(var_3_7)

	local var_3_8 = display.newSprite(arg_3_1.type and "ui/PK/PK_033.png" or "ui/PK/PK_034.png")

	var_3_8:setPosition(80, 10)
	arg_3_0:addChild(var_3_8)
end

local function var_0_7(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = Player.userId == arg_5_2.attackPlayerID or Player.userId == arg_5_2.defendPlayerID
	local var_5_1 = display.newSprite(var_5_0 and "ui/PK/PK_053.png" or "ui/PK/PK_032.png")
	local var_5_2 = var_5_1:getContentSize()
	local var_5_3 = CCSize(82, 82)

	var_5_1:setAnchorPoint(ccp(0, 0))

	local var_5_4 = var_0_2.newLabel({
		text = string.lf("%s强", arg_5_2.rank)
	})

	var_5_4:setPosition(var_5_2.width / 2, var_5_2.height - 20)
	var_5_1:addChild(var_5_4)

	local var_5_5 = 0
	local var_5_6 = CCScale9Sprite:create("ui/common/bg_figure_blue.png")

	var_5_6:setPreferredSize(var_5_3)
	var_5_6:setPosition(70, 95)
	var_5_1:addChild(var_5_6)

	if arg_5_2.attackBattlePower > 0 then
		var_0_6(var_5_6, {
			type = false,
			id = arg_5_2.attackPlayerID,
			name = arg_5_2.attackName,
			header = arg_5_2.attackAvatarID,
			power = arg_5_2.attackBattlePower,
			status = arg_5_2.winnerID == arg_5_2.attackPlayerID
		})

		var_5_5 = var_5_5 + 1
	else
		local var_5_7 = display.newSprite("ui/PK/PK_032_1.png")

		var_5_7:setPosition(var_5_3.width / 2, var_5_3.height / 2)
		var_5_6:addChild(var_5_7)
	end

	local var_5_8 = CCScale9Sprite:create("ui/common/bg_figure_blue.png")

	var_5_8:setPreferredSize(var_5_3)
	var_5_8:setPosition(var_5_2.width - 70, 95)
	var_5_1:addChild(var_5_8)

	if arg_5_2.defendBattlePower > 0 then
		var_0_6(var_5_8, {
			type = true,
			id = arg_5_2.defendPlayerID,
			name = arg_5_2.defendName,
			header = arg_5_2.defendAvatarID,
			power = arg_5_2.defendBattlePower,
			status = arg_5_2.winnerID == arg_5_2.defendPlayerID
		})

		var_5_5 = var_5_5 + 1
	else
		local var_5_9 = display.newSprite("ui/PK/PK_032_1.png")

		var_5_9:setPosition(var_5_3.width / 2, var_5_3.height / 2)
		var_5_8:addChild(var_5_9)
	end

	local var_5_10 = ui.newControlButton({
		normalImage = "ui/PK/PK_031.png",
		text = string.lf("查看"),
		clickAction = function(arg_6_0, arg_6_1)
			var_0_5(arg_5_2.attackPlayerID, arg_5_2.defendPlayerID)
		end
	})

	var_5_10:setEnabled(var_5_5 == 2)
	var_5_10:setPosition(var_5_2.width / 2, 25)
	var_5_1:addChild(var_5_10)

	return var_5_1
end

function var_0_4.createCSBattleDialog(arg_7_0)
	local var_7_0 = arg_7_0.data
	local var_7_1 = arg_7_0.battle

	arg_7_0.closeable = true
	arg_7_0.type = var_0_3.eTypeDialog

	local var_7_2 = var_0_3.new(arg_7_0)
	local var_7_3 = CCSize(442, 100)
	local var_7_4 = var_0_2.newNode()

	var_7_4:setContentSize(var_7_3)
	var_7_2:addNode(var_7_4)

	local var_7_5 = CCSize(82, 82)
	local var_7_6 = ccc3(240, 240, 180)
	local var_7_7 = CCScale9Sprite:create("ui/common/bg_figure_blue.png")

	var_7_7:setPreferredSize(var_7_5)
	var_7_7:setPosition(80, var_7_3.height / 2)
	var_7_4:addChild(var_7_7)

	local var_7_8 = getItemHeaderImagePath(ItemType.eHero, var_7_0.header)
	local var_7_9 = display.newSprite(var_7_8)

	var_7_9:setPosition(var_7_5.width / 2, var_7_5.height / 2)
	var_7_7:addChild(var_7_9)

	local var_7_10 = var_0_2.newLabel({
		text = var_7_0.name,
		color = var_7_6
	})

	var_7_10:setAnchorPoint(ccp(0, 0.5))
	var_7_10:setPosition(130, 65)
	var_7_4:addChild(var_7_10)

	local var_7_11 = var_0_2.newLabel({
		text = string.lf("战力: %s", var_7_0.power),
		color = var_7_6
	})

	var_7_11:setAnchorPoint(ccp(0, 0.5))
	var_7_11:setPosition(130, 35)
	var_7_4:addChild(var_7_11)

	local var_7_12 = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		text = string.lf("阵容"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_8_0, arg_8_1)
			OthersTeamHelper:checkOthersTeam(var_7_0.id, var_7_0.name, OthersTeamHelper.eDataFromCSGamble)
		end
	})

	var_7_12:setPosition(340, var_7_3.height / 2)
	var_7_4:addChild(var_7_12)

	local var_7_13 = CCSize(442, 375)
	local var_7_14 = var_0_2.newNode()

	var_7_14:setContentSize(var_7_13)
	var_7_2:addNode(var_7_14)

	local var_7_15 = display.newSprite("uilocal/PK/PK_text_030.png")

	var_7_15:setPosition(var_7_13.width / 2, var_7_13.height - 10)
	var_7_14:addChild(var_7_15)

	local var_7_16 = {
		reverse = false,
		direction = kCCScrollViewDirectionVertical,
		size = CCSize(442, 350),
		sizehandler = function(arg_9_0, arg_9_1)
			return CCSize(var_7_13.width, 160)
		end,
		cellhandler = var_0_7
	}
	local var_7_17 = createTableView(var_7_16)

	var_7_17:reloadData(var_7_1)
	var_7_14:addChild(var_7_17)

	return var_7_2
end

function var_0_4.createCSGambleDialog(arg_10_0)
	local var_10_0 = arg_10_0.data
	local var_10_1 = arg_10_0.callback
	local var_10_2 = {
		delta = 0,
		min = 0,
		value = 0,
		max = 0
	}

	if Player.level > 70 then
		var_10_2.dao = string.lf("天道")
		var_10_2.min = 30000
		var_10_2.delta = 10000
		var_10_2.max = 100000
	elseif Player.level > 40 then
		var_10_2.dao = string.lf("地道")
		var_10_2.min = 10000
		var_10_2.delta = 10000
		var_10_2.max = 50000
	else
		var_10_2.dao = string.lf("人道")
		var_10_2.min = 10000
		var_10_2.delta = 10000
		var_10_2.max = 30000
	end

	var_10_2.value = var_10_2.min
	arg_10_0.type = var_0_3.eTypeDialog

	local var_10_3 = var_0_3.new(arg_10_0)
	local var_10_4 = "uilocal/common/common_text_006.png"
	local var_10_5 = display.newSprite("ui/common/common_064_2.png")
	local var_10_6 = var_10_5:getContentSize()
	local var_10_7 = display.newSprite(var_10_4)

	var_10_7:setPosition(var_10_6.width / 2, var_10_6.height / 2 + 5)
	var_10_5:addChild(var_10_7)
	var_10_3:addNode(var_10_5)

	var_10_3.padding.top = -16

	local var_10_8 = CCSize(450, 160)
	local var_10_9 = var_0_2.newNode()

	var_10_9:setContentSize(var_10_8)

	local var_10_10 = CCSize(82, 82)
	local var_10_11 = ccc3(198, 161, 78)
	local var_10_12 = CCScale9Sprite:create("ui/common/bg_figure_blue.png")

	var_10_12:setPreferredSize(var_10_10)
	var_10_12:setPosition(80, var_10_8.height - 50)
	var_10_9:addChild(var_10_12)

	local var_10_13 = getItemHeaderImagePath(ItemType.eHero, var_10_0.header)
	local var_10_14 = display.newSprite(var_10_13)

	var_10_14:setPosition(var_10_10.width / 2, var_10_10.height / 2)
	var_10_12:addChild(var_10_14)

	local var_10_15 = var_0_2.newLabel({
		text = var_10_0.name,
		color = var_10_11
	})

	var_10_15:setPosition(var_10_10.width / 2, -20)
	var_10_12:addChild(var_10_15)

	local var_10_16 = var_0_2.newLabel({
		size = 22,
		text = string.lf("下注金额："),
		color = var_10_11
	})

	var_10_16:setPosition(var_10_8.width / 2 - 10, 140)
	var_10_9:addChild(var_10_16)

	local var_10_17 = display.newSprite(getItemHeaderImagePath(ItemType.eCoin))

	var_10_17:setScale(0.5)
	var_10_17:setPosition(180, 100)
	var_10_9:addChild(var_10_17)

	local var_10_18 = display.newSprite("ui/friend/friend_006.png")

	var_10_18:setPosition(310, 100)
	var_10_9:addChild(var_10_18)

	local var_10_19 = var_10_0.gamble > 0 and var_10_0.gamble or var_10_2.value
	local var_10_20 = var_0_2.newLabel({
		text = string.formatNumberThousands(var_10_19)
	})
	local var_10_21 = var_10_18:getContentSize()

	var_10_20:setPosition(var_10_21.width / 2, var_10_21.height / 2)
	var_10_18:addChild(var_10_20)

	if var_10_0.gamble == 0 then
		local var_10_22 = ui.newControlButton({
			disabledImage = "ui/common/common_080.png",
			normalImage = "ui/common/common_109.png",
			text = "+" .. var_10_2.delta,
			size = CCSize(140, 65),
			clickAction = function(arg_11_0, arg_11_1)
				local var_11_0 = var_10_2.value + var_10_2.delta

				if var_11_0 > var_10_2.max then
					local var_11_1 = string.lf("%s 下注的最高金额是 %s !\n上仙，竞猜有风险，下注需谨慎！祝您好运！：）", var_10_2.dao, string.formatNumberThousands(var_10_2.max))

					ui.showMessageBox({
						slide = true,
						text = var_11_1
					})
				else
					var_10_2.value = var_11_0

					var_10_20:setString(string.formatNumberThousands(var_10_2.value))
				end
			end
		})

		var_10_22:setPosition(310, 40)
		var_10_9:addChild(var_10_22)
	else
		local var_10_23 = var_0_2.newLabel({
			size = 22,
			text = string.lf("奖励金额："),
			color = var_10_11
		})

		var_10_23:setPosition(var_10_8.width / 2 - 10, 60)
		var_10_9:addChild(var_10_23)

		local var_10_24 = display.newSprite(getItemHeaderImagePath(ItemType.eCoin))

		var_10_24:setScale(0.5)
		var_10_24:setPosition(180, 20)
		var_10_9:addChild(var_10_24)

		local var_10_25 = display.newSprite("ui/friend/friend_006.png")

		var_10_25:setPosition(310, 20)
		var_10_9:addChild(var_10_25)

		local var_10_26 = var_10_0.gamble * 2

		var_10_20 = var_0_2.newLabel({
			text = string.formatNumberThousands(var_10_26)
		})

		local var_10_27 = var_10_25:getContentSize()

		var_10_20:setPosition(var_10_27.width / 2, var_10_27.height / 2)
		var_10_25:addChild(var_10_20)
	end

	var_10_3:addNode(var_10_9)
	var_10_3:addAction({
		text = var_10_0.gamble > 0 and string.lf("领取") or string.lf("确定"),
		enabled = var_10_0.gamble == 0 or var_10_0.reward == 1,
		callback = function(arg_12_0, arg_12_1)
			var_10_3:removeSelf()

			return var_10_1 and var_10_1(var_10_2.value)
		end
	})
	var_10_3:addAction({
		text = string.lf("取消")
	})

	return var_10_3
end

function var_0_4.createHeroListDialog(arg_13_0)
	local var_13_0 = arg_13_0.type
	local var_13_1 = arg_13_0.callback

	arg_13_0.type = var_0_3.eTypeDialog

	local var_13_2 = var_0_3.new(arg_13_0)
	local var_13_3 = CCSize(0, 145)
	local var_13_4 = CCSize(115, 145)
	local var_13_5 = {}

	for iter_13_0, iter_13_1 in ipairs(Player.team.groupList) do
		if iter_13_1.heroId > 0 then
			table.insert(var_13_5, iter_13_1)
		end
	end

	var_13_3.width = var_13_4.width * #var_13_5

	local var_13_6 = 0
	local var_13_7 = var_0_1.array(#var_13_5, 0)
	local var_13_8 = display.newScale9Sprite("ui/common/bg_common.png")

	var_13_8:setZOrder(-1)
	var_13_8:setPreferredSize(var_13_4)
	var_13_8:setPosition(var_13_4.width / 2, var_13_4.height / 2)

	local function var_13_9(arg_14_0)
		local var_14_0 = var_13_7[arg_14_0]

		var_13_8:retain()
		var_13_8:removeFromParent()
		var_14_0:addChild(var_13_8)
		var_13_8:release()

		var_13_6 = arg_14_0
	end

	local var_13_10 = createTableView({
		reverse = false,
		size = var_13_3,
		sizehandler = function()
			return var_13_4
		end,
		touchhandler = function(arg_16_0, arg_16_1)
			var_13_9(arg_16_1:getIdx() + 1)
		end,
		cellhandler = function(arg_17_0, arg_17_1, arg_17_2)
			local var_17_0 = var_0_2.newNode()

			var_17_0:setContentSize(var_13_4)

			local var_17_1 = getItemQuality(ItemType.eHero, arg_17_2.heroId)
			local var_17_2 = getQualityColor(var_17_1)
			local var_17_3 = figure.createHeader({
				isName = true,
				type = ItemType.eHero,
				itemId = arg_17_2.heroId,
				nameColor = var_17_2,
				level = arg_17_2.level,
				clickAction = function(arg_18_0, arg_18_1)
					var_13_9(arg_17_1)
				end
			})

			var_17_3:setPosition(var_13_4.width / 2, var_13_4.height / 2 + 20)
			var_17_3:setNameLabelColor(var_17_2)
			var_17_0:addChild(var_17_3)

			var_17_0.header = var_17_3

			local var_17_4 = var_0_2.newLabel({
				text = "",
				color = var_17_2
			})

			var_17_4:setPosition(var_13_4.width / 2, 20)
			var_17_0:addChild(var_17_4)

			var_17_0.label = var_17_4
			var_17_0.type = var_13_0
			var_13_7[arg_17_1] = var_17_0

			if arg_17_1 == 1 and var_13_6 == 0 then
				var_17_0:addChild(var_13_8)

				var_13_6 = arg_17_1
			elseif var_13_6 == arg_17_1 then
				var_13_9(arg_17_1)
			end

			function var_17_0.updateLabel(arg_19_0, arg_19_1)
				local var_19_0 = arg_19_0.type
				local var_19_1

				if var_19_0 == PropType.ePotencyPill then
					var_19_1 = string.lf("潜力: %s", arg_17_2.potency)
				elseif var_19_0 == PropType.eExp then
					var_19_1 = string.lf("经验: %s%%", math.floor(arg_17_2.curExp / arg_17_2.totalExp * 100))

					arg_19_0.header.levelNode.numLabel:setString(arg_17_2.level)
				end

				arg_19_0.label:setString(var_19_1)

				if arg_19_1 then
					arg_19_0.label:runAction(CCBlink:create(0.5, 3))
				end
			end

			var_17_0:updateLabel()

			return var_17_0
		end
	})

	var_13_10:setTouchEnabled(false)
	var_13_10:reloadData(var_13_5)
	var_13_2:addNode({
		node = var_13_10,
		size = var_13_3
	})
	var_13_2:addAction({
		text = string.lf("确定"),
		callback = function(arg_20_0, arg_20_1)
			var_13_10:reloadData()
			var_13_1(var_13_5[var_13_6].heroId, function()
				var_13_7[var_13_6]:updateLabel(true)
				showFlashImage({
					image = "uilocal/enhance/enhance_txt_007.png",
					scale = 0.8,
					parent = arg_20_1,
					position = ccp(70, 60),
					callback = function(arg_22_0)
						var_13_2:removeSelf()
					end
				})
			end)
		end
	})
	var_13_2:addAction({
		text = string.lf("取消")
	})

	return var_13_2
end

function var_0_4.createFigureDialog(arg_23_0)
	local var_23_0 = var_0_0.new({
		type = arg_23_0.type,
		id = arg_23_0.id,
		player = arg_23_0.player
	})
	local var_23_1 = var_23_0.model
	local var_23_2 = var_23_0.qualityColor
	local var_23_3 = arg_23_0.callback

	arg_23_0.closeable = true
	arg_23_0.type = var_0_3.eTypeDialog

	local var_23_4 = var_0_3.new(arg_23_0)
	local var_23_5 = CCSize(550, 405)
	local var_23_6 = var_0_2.newNode()

	var_23_6:setContentSize(var_23_5)

	local var_23_7 = var_23_0:createFigureNode()
	local var_23_8 = var_23_7:getContentSize()
	local var_23_9 = string.lf("【%s】%s  %d级", HeroProfessionNames[var_23_1.profession], var_23_1.name, var_23_1.level or 1)
	local var_23_10 = var_0_2.newLabel({
		size = 22,
		text = var_23_9,
		color = var_23_2
	})
	local var_23_11 = var_23_0:createAttrNode()
	local var_23_12 = var_23_0:createInfoNode()
	local var_23_13 = CCSize(280, 60)
	local var_23_14 = var_0_2.newNode()
	local var_23_15 = ui.newControlButton({
		disabledImage = "ui/common/common_079.png",
		normalImage = "ui/common/common_018.png",
		text = string.lf("法术"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_24_0, arg_24_1)
			var_23_12:toggle(true)
		end
	})
	local var_23_16 = ui.newControlButton({
		disabledImage = "ui/common/common_079.png",
		normalImage = "ui/common/common_018.png",
		text = string.lf("套装"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_25_0, arg_25_1)
			var_23_12:toggle(false)
		end
	})

	var_23_15:setPosition(var_23_13.width / 2 - 75, 30)
	var_23_16:setPosition(var_23_13.width / 2 + 75, 30)
	var_23_14:addChild(var_23_15)
	var_23_14:addChild(var_23_16)
	var_23_14:setContentSize(var_23_13)

	local var_23_17 = var_0_2.linearLayout({
		margin = 10,
		direction = "vertical",
		nodes = {
			var_23_10,
			var_23_11,
			var_23_12,
			var_23_14
		},
		align = display.LEFT_BOTTOM
	})
	local var_23_18 = var_23_17:getContentSize()

	var_23_5.width = var_23_8.width + 20 + var_23_18.width
	var_23_5.height = math.max(var_23_8.height, var_23_18.height)

	var_23_6:setContentSize(var_23_5)

	local var_23_19 = display.newScale9Sprite("ui/common/common_100.png")

	var_23_19:setContentSize(CCSize(var_23_5.height, 5))
	var_23_19:setRotation(90)
	var_23_7:setAnchorPoint(ccp(0, 0.5))
	var_23_7:setPosition(0, var_23_5.height / 2 + 15)
	var_23_6:addChild(var_23_7)
	var_23_19:setPosition(var_23_8.width, var_23_5.height / 2)
	var_23_6:addChild(var_23_19, -1)
	var_23_17:setAnchorPoint(ccp(0, 0.5))
	var_23_17:setPosition(var_23_8.width + 20, var_23_5.height / 2)
	var_23_6:addChild(var_23_17)
	var_23_4:addNode(var_23_6)

	return var_23_4
end

function var_0_4.createPropDialog(arg_26_0)
	local var_26_0 = {
		[ItemType.eSoul] = BaseSouls,
		[ItemType.eProp] = BaseProps,
		[ItemType.eMate] = BaseMates,
		[ItemType.eHero] = BaseHeros,
		[ItemType.eEquip] = BaseEquips,
		[ItemType.eFragment] = BaseFragments
	}
	local var_26_1 = arg_26_0.show
	local var_26_2 = arg_26_0.callback
	local var_26_3 = arg_26_0.data or {
		id = arg_26_0.id,
		type = arg_26_0.type,
		count = arg_26_0.count
	}
	local var_26_4 = var_26_3.id
	local var_26_5 = var_26_3.price
	local var_26_6 = var_26_3.type or ItemType.eProp
	local var_26_7 = arg_26_0.selectCount or 1
	local var_26_8 = getItemBaseData(var_26_6, var_26_4)
	local var_26_9

	if var_26_8 then
		var_26_9 = var_26_8.name
	end

	local var_26_10 = Player:getItemCount(var_26_6, var_26_4)
	local var_26_11 = var_26_3.limit
	local var_26_12 = var_26_3.count or 0

	arg_26_0.type = var_0_3.eTypeDialog

	local var_26_13 = var_0_3.new(arg_26_0)

	var_26_13.actionIn = var_0_3.springLayer

	local var_26_14 = 20
	local var_26_15 = ccc3(248, 236, 178)
	local var_26_16 = ccc3(255, 0, 0)
	local var_26_17
	local var_26_18
	local var_26_19
	local var_26_20
	local var_26_21
	local var_26_22
	local var_26_23

	if var_26_1 == var_0_3.eShowPropSell then
		var_26_17 = "uilocal/bag/bag_txt_000.png"
		var_26_18 = var_0_2.createSliderNode
		var_26_11 = var_26_10
		var_26_19 = string.lf("出售价格")

		if not var_26_5 then
			var_26_5 = {
				type = ItemType.eCoin,
				value = var_26_8.sellPrice or var_26_8.price
			}
		end
	elseif var_26_1 == var_0_3.eShowPropBuy then
		var_26_17 = "uilocal/bag/bag_txt_002.png"
		var_26_18 = var_0_2.createCounterNode
		var_26_11 = var_26_11 or math.huge
		var_26_19 = string.lf("购买价格")
		var_26_5 = var_26_5 or {
			type = ItemType.eGold,
			value = var_26_8.price
		}

		if var_26_8.propType == PropType.eEnergy then
			var_26_5.value = var_0_1.getEnergyPrice(var_26_12)
		end
	elseif var_26_1 == var_0_3.eShowGiftVolumeBuy then
		var_26_18 = var_0_2.createCounterNode
		var_26_11 = var_26_11 or math.huge
		var_26_9 = string.lf("点卷")
		var_26_19 = string.lf("兑换元宝")
		var_26_5 = var_26_5 or {
			type = ItemType.eGold,
			value = var_26_8.price
		}
	end

	if var_26_17 then
		local var_26_24 = display.newSprite("ui/common/common_064_2.png")
		local var_26_25 = var_26_24:getContentSize()
		local var_26_26 = display.newSprite(var_26_17)

		var_26_26:setPosition(var_26_25.width / 2, var_26_25.height / 2 + 5)
		var_26_24:addChild(var_26_26)
		var_26_13:addNode(var_26_24)

		var_26_13.padding.top = -16
	end

	local var_26_27 = CCSize(420, 130)
	local var_26_28 = var_0_2.newNode()

	var_26_28:setContentSize(var_26_27)

	local var_26_29 = CCSize(420, 50)
	local var_26_30 = CCNode:create()

	var_26_30:setContentSize(var_26_29)

	local var_26_31 = var_0_2.newLabel({
		text = var_26_9 .. "x1",
		size = var_26_14,
		color = var_26_15
	})

	var_26_31:align(display.LEFT_CENTER, 40, var_26_29.height / 2)
	var_26_30:addChild(var_26_31)

	local var_26_32 = var_0_2.newLabel({
		text = var_26_19,
		size = var_26_14,
		color = var_26_15
	})

	var_26_32:align(display.LEFT_CENTER, 220, 25)
	var_26_30:addChild(var_26_32)

	if var_26_5.type == ItemType.eGold then
		var_26_23 = {
			type = ItemType.eGold,
			value = Player.curGold,
			color = var_26_15
		}
	else
		var_26_23 = {
			type = ItemType.eCoin,
			value = Player.curCoin,
			color = var_26_15
		}
	end

	var_26_5.color = var_26_23.value < var_26_5.value and var_26_16 or var_26_15

	local var_26_33 = createItemCountNode(var_26_5)

	var_26_33:setPosition(320, 25)
	var_26_30:addChild(var_26_33)
	var_26_30:setPosition(0, 80)
	var_26_28:addChild(var_26_30)

	local function var_26_34()
		local var_27_0 = true

		if var_26_1 == var_0_3.eShowPropBuy then
			var_27_0 = var_26_33:getValue() <= var_26_23.value
		end

		return var_27_0
	end

	local var_26_35 = var_26_18(1, var_26_11, function(arg_28_0, arg_28_1)
		local var_28_0 = 0

		var_26_7 = arg_28_1

		if var_26_1 == var_0_3.eShowPropBuy and var_26_8.propType == PropType.eEnergy then
			var_28_0 = var_0_1.getEnergyTotalCost(var_26_7, var_26_12)
		else
			var_28_0 = var_26_5.value * var_26_7
		end

		var_26_31:setString(var_26_9 .. "x" .. var_26_7)
		var_26_33:setValue(var_28_0)

		if var_26_34() then
			var_26_33:setColor(var_26_15)
		else
			var_26_33:setColor(var_26_16)
		end
	end, var_26_7)

	var_26_35:setPosition(var_26_27.width / 2, 40)
	var_26_28:addChild(var_26_35)
	var_26_13:addNode(var_26_28)
	var_26_13:addAction({
		text = string.lf("确定"),
		enabled = var_26_11 > 0,
		callback = function(arg_29_0, arg_29_1)
			if var_26_34() then
				var_26_13:removeFromParent()

				return var_26_2 and var_26_2(var_26_7)
			else
				isMoneyEnough(var_26_5.type, math.huge)
			end
		end
	})
	var_26_13:addAction({
		text = string.lf("取消")
	})

	return var_26_13
end

function var_0_4.createRewardDialog(arg_30_0)
	local var_30_0 = arg_30_0.rewards
	local var_30_1 = arg_30_0.callback

	if not var_30_0 then
		return
	end

	arg_30_0.type = var_0_3.eTypeDialog

	local var_30_2 = var_0_3.new(arg_30_0)
	local var_30_3 = "uilocal/bag/bag_txt_004.png"
	local var_30_4 = display.newSprite("ui/common/common_064_2.png")
	local var_30_5 = var_30_4:getContentSize()
	local var_30_6 = display.newSprite(var_30_3)

	var_30_6:setPosition(var_30_5.width / 2, var_30_5.height / 2 + 5)
	var_30_4:addChild(var_30_6)
	var_30_2:addNode(var_30_4)

	var_30_2.padding.top = -16

	local var_30_7 = var_0_2.createRewardList(var_30_0)

	var_30_2:addNode(var_30_7)
	var_30_2:addAction({
		text = string.lf("确定"),
		callback = function()
			var_30_2:removeFromParent()

			return var_30_1 and var_30_1()
		end
	})

	return var_30_2
end

function var_0_4.createOpenFailDialog(arg_32_0)
	arg_32_0.type = var_0_3.eTypeDialog

	local var_32_0 = var_0_3.new(arg_32_0)
	local var_32_1 = "uilocal/common/common_text_006.png"
	local var_32_2 = display.newSprite("ui/common/common_064_2.png")
	local var_32_3 = var_32_2:getContentSize()
	local var_32_4 = display.newSprite(var_32_1)

	var_32_4:setPosition(var_32_3.width / 2, var_32_3.height / 2 + 5)
	var_32_2:addChild(var_32_4)
	var_32_0:addNode(var_32_2)

	var_32_0.padding.top = -16

	local var_32_5 = CCSize(490, 130)
	local var_32_6 = var_0_2.newNode()

	var_32_6:setContentSize(var_32_5)

	local var_32_7 = BaseProps[arg_32_0.id]
	local var_32_8
	local var_32_9 = var_32_7.propType

	if var_32_9 == PropType.eKey then
		var_32_8 = string.lf("上仙，光有#E4BD05钥匙#C6A14E却没#E4BD05宝箱#C6A14E，真是英雄无用武之地啊~江湖传言，宝箱中藏着极品装备噢~现在就去购买一些吧！")
	elseif var_32_9 == PropType.eTreasureBox then
		var_32_8 = string.lf("上仙，光有#E4BD05宝箱#C6A14E却没#E4BD05钥匙#C6A14E，真是英雄无用武之地啊~江湖传言，宝箱中藏着极品装备噢~现在就去购买一些吧！")
	end

	local var_32_10 = var_0_2.newLabel({
		size = 20,
		text = var_32_8,
		color = ccc3(198, 161, 78),
		dimensions = CCSize(440, 50)
	})

	var_32_10:setPosition(var_32_5.width / 2, 80)
	var_32_6:addChild(var_32_10)
	var_32_0:addAction({
		text = string.lf("确定"),
		callback = function(arg_33_0, arg_33_1)
			var_32_0:removeFromParent()
		end
	})
	var_32_0:addAction({
		text = string.lf("去商城"),
		callback = function(arg_34_0, arg_34_1)
			game.enterStoreScene({
				defaultPage = 2,
				id = var_32_7.propValue
			})
		end
	})
	var_32_0:addNode(var_32_6)

	return var_32_0
end

function var_0_4.createFigureFilterDialog(arg_35_0)
	local var_35_0 = arg_35_0.callback
	local var_35_1 = arg_35_0.quality or {
		[QualityType.eGreen] = true,
		[QualityType.eBlue] = true,
		[QualityType.ePurple] = true,
		[QualityType.eOrange] = true
	}
	local var_35_2 = arg_35_0.profession or {
		[HeroProfession.eCommander] = true,
		[HeroProfession.eWarrior] = true,
		[HeroProfession.eMage] = true
	}

	arg_35_0.type = var_0_3.eTypeDialog

	local var_35_3 = var_0_3.new(arg_35_0)
	local var_35_4 = CCSize(440, 340)
	local var_35_5 = var_0_2.newNode()

	var_35_5:setContentSize(var_35_4)

	local function var_35_6(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
		local var_36_0 = CCSize(180, 340)
		local var_36_1 = CCNode:create()
		local var_36_2 = var_0_2.newLabel({
			size = 28,
			text = arg_36_0,
			color = ccc3(239, 223, 181)
		})

		var_36_2:setAnchorPoint(ccp(0.5, 1))
		var_36_2:setPosition(var_36_0.width / 2, var_36_0.height)
		var_36_1:addChild(var_36_2)

		local var_36_3 = CCSize(180, 300)
		local var_36_4 = display.newScale9Sprite("ui/activity/activity_062.png")

		var_36_4:setContentSize(var_36_3)
		var_36_4:setAnchorPoint(ccp(0, 0))
		var_36_4:setPosition(0, 0)
		var_36_1:addChild(var_36_4)

		local var_36_5 = CCSize(180, 300)
		local var_36_6 = CCMenu:create()

		var_36_6:setContentSize(var_36_5)
		var_36_6:setPosition(35, 0)
		var_36_4:addChild(var_36_6)

		local var_36_7 = #arg_36_1
		local var_36_8 = var_36_5.height / var_36_7

		for iter_36_0 = 1, var_36_7 do
			local var_36_9 = var_0_2.createToggleNode({
				size = 24,
				text = arg_36_1[iter_36_0],
				callback = arg_36_3
			})
			local var_36_10 = 30
			local var_36_11 = var_36_8 / 2 + var_36_8 * (var_36_7 - iter_36_0)

			var_36_9:setPosition(var_36_10, var_36_11)
			var_36_9:setTag(iter_36_0)
			var_36_9:setState(arg_36_2[iter_36_0])
			var_36_6:addChild(var_36_9)
		end

		return var_36_1
	end

	local var_35_7 = {
		getQualityName(QualityType.eOrange),
		getQualityName(QualityType.ePurple),
		getQualityName(QualityType.eBlue),
		getQualityName(QualityType.eGreen)
	}
	local var_35_8 = var_35_6(string.lf("品质"), var_35_7, var_35_1, function(arg_37_0, arg_37_1)
		var_35_1[arg_37_0] = not var_35_1[arg_37_0]
	end)

	var_35_8:setAnchorPoint(ccp(0, 0))
	var_35_8:setPosition(20, 0)
	var_35_5:addChild(var_35_8)

	local var_35_9 = {
		HeroProfessionNames[HeroProfession.eCommander],
		HeroProfessionNames[HeroProfession.eWarrior],
		HeroProfessionNames[HeroProfession.eMage]
	}
	local var_35_10 = var_35_6(string.lf("职业"), var_35_9, var_35_2, function(arg_38_0, arg_38_1)
		var_35_2[arg_38_0] = not var_35_2[arg_38_0]
	end)

	var_35_10:setAnchorPoint(ccp(0, 0))
	var_35_10:setPosition(240, 0)
	var_35_5:addChild(var_35_10)
	var_35_3:addNode(var_35_5)
	var_35_3:addAction({
		text = string.lf("确定"),
		callback = function()
			var_35_3:removeFromParent()
			var_35_0(var_35_1, var_35_2)
		end
	})

	return var_35_3
end

function var_0_4.createChangeNameDialog(arg_40_0)
	local var_40_0 = arg_40_0.callback

	arg_40_0.type = var_0_3.eTypeDialog

	local var_40_1 = var_0_3.new(arg_40_0)
	local var_40_2 = "uilocal/common/common_text_006.png"
	local var_40_3 = display.newSprite("ui/common/common_064_2.png")
	local var_40_4 = var_40_3:getContentSize()
	local var_40_5 = display.newSprite(var_40_2)

	var_40_5:setPosition(var_40_4.width / 2, var_40_4.height / 2 + 5)
	var_40_3:addChild(var_40_5)
	var_40_1:addNode(var_40_3)

	var_40_1.padding.top = -16

	local var_40_6 = CCSize(450, 160)
	local var_40_7 = var_0_2.newNode()

	var_40_7:setContentSize(var_40_6)

	local var_40_8 = var_0_2.newLabel({
		size = 22,
		text = string.lf("请输入您的新昵称"),
		color = ccc3(198, 161, 78)
	})

	var_40_8:setPosition(var_40_6.width / 2, 130)
	var_40_7:addChild(var_40_8)

	local var_40_9 = ui.newEditBox({
		image = "ui/friend/friend_006.png",
		size = CCSize(260, 40)
	})

	var_40_9:setFontSize(16)
	var_40_9:setPlaceHolder(string.lf("最多6个中文或12个英文字符"))
	var_40_9:setPlaceholderFontSize(16)
	var_40_9:setPosition(210, 70)
	var_40_7:addChild(var_40_9)

	if IPlatform:instance():getConfig("Channel") ~= "ZSY_VN" then
		local var_40_10 = ui.newControlButton({
			normalImage = "ui/account/btn_random_001.png",
			highlightedImage = "ui/account/btn_random_002.png",
			clickAction = function(arg_41_0, arg_41_1)
				var_40_9:setText(var_0_1.getRandomName())
			end
		})

		var_40_10:setPosition(370, 70)
		var_40_7:addChild(var_40_10)
	end

	var_40_1:addNode(var_40_7)
	var_40_1:addAction({
		text = string.lf("确定"),
		callback = function(arg_42_0, arg_42_1)
			local var_42_0 = var_40_9:getText()
			local var_42_1 = string.asciilen(var_42_0)

			if IPlatform:instance():getConfig("Channel") == "ZSY_VN" and var_42_1 > 3 and var_42_1 < 11 or var_42_1 > 0 and var_42_1 < 13 then
				if matchValidedString(var_42_0) then
					local var_42_2 = UsePropRequest:new()

					var_42_2:setResponseNormalHandler(function()
						local var_43_0 = var_42_2:getResponseContent()

						var_40_1:removeFromParent()
						Player:setNickName(var_42_0)
						var_40_0(true, var_43_0)
					end)
					var_42_2:setResponseExceptionHandler(function()
						var_40_1:removeFromParent()
						var_40_0(false)
					end)
					var_42_2:requestChangeName(100026, var_42_0)
				else
					CCMessageBox(string.lf("昵称包含非法字符！"), string.lf("错误"))
				end
			elseif IPlatform:instance():getConfig("Channel") == "ZSY_VN" then
				CCMessageBox(string.lf("昵称最多4个中文或10个英文字符！"), string.lf("错误"))
			else
				CCMessageBox(string.lf("昵称最多6个中文或12个英文字符！"), string.lf("错误"))
			end
		end
	})
	var_40_1:addAction({
		text = string.lf("取消")
	})

	return var_40_1
end

function var_0_4.createTokenDialog(arg_45_0)
	local var_45_0 = arg_45_0.show
	local var_45_1 = true

	if var_45_0 == var_0_3.eShowChallenge or var_45_0 == var_0_3.eShowShenqiSnatch or var_45_0 == var_0_3.eShowTranportEmpty or var_45_0 == var_0_3.eShowFuBenJieSuo then
		var_45_1 = false
	end

	arg_45_0.type = var_0_3.eTypeDialog
	arg_45_0.closeable = var_45_1

	local var_45_2 = var_0_3.new(arg_45_0)

	var_45_2.padding.top = -16
	var_45_2.actionIn = var_0_3.springLayer

	local function var_45_3(...)
		var_45_2:removeSelf()

		return arg_45_0.callback and arg_45_0.callback(...)
	end

	local var_45_4 = "uilocal/common/common_text_006.png"
	local var_45_5 = display.newSprite("ui/common/common_064_2.png")
	local var_45_6 = var_45_5:getContentSize()
	local var_45_7 = display.newSprite(var_45_4)

	var_45_7:setPosition(var_45_6.width / 2, var_45_6.height / 2 + 5)
	var_45_5:addChild(var_45_7)
	var_45_2:addNode(var_45_5)

	local var_45_8 = CCSize(490, 180)
	local var_45_9 = var_0_2.newNode()

	var_45_9:setContentSize(var_45_8)

	local var_45_10 = 0
	local var_45_11 = 0
	local var_45_12 = 0
	local var_45_13
	local var_45_14 = string.lf("使用")
	local var_45_15

	if var_45_0 == var_0_3.eShowChallenge then
		var_45_10 = PropType.ePkToken
		var_45_15 = string.lf("上仙，今日挑战次数已用完！使用#E4BD05挑战令#C6A14E可以增加挑战次数，挑战令可以通过#E4BD05开宝箱#C6A14E获得。")
	elseif var_45_0 == var_0_3.eShowSlaveCatch then
		var_45_14 = string.lf("抓捕")
		var_45_10 = PropType.eCatchToken
		var_45_15 = string.lf("上仙，今日免费抓捕次数已经用完！提升#E4BD05VIP等级#C6A14E或者在商城购买#E4BD05抓捕令#C6A14E可获得更多的抓捕次数。")
	elseif var_45_0 == var_0_3.eShowPowerEmpty then
		var_45_10 = PropType.eEnergy
		var_45_15 = string.lf("上仙，您的体力不足！体力可以等待自动恢复或者在商城购买#E4BD05体力丹#C6A14E来补充体力。")
	elseif var_45_0 == var_0_3.eShowTranportEmpty then
		var_45_10 = PropType.eTransportToken
		var_45_15 = string.lf("上仙，今日运镖次数已用完！可以提升Vip等级，使用运镖令或者在商城购买#E4BD05运镖令#C6A14E来增加运镖次数。")
	elseif var_45_0 == var_0_3.eShowShenqiSnatch then
		var_45_14 = string.lf("抢夺")
		var_45_10 = PropType.eShenQiSnatch
		var_45_15 = string.lf("上仙，今日抢夺次数已用完！使用#E4BD05神器抢夺令#C6A14E可以增加挑战次数，抢夺令可以从#E4BD05神器抢夺翻牌#C6A14E获得。")
	elseif var_45_0 == var_0_3.eShowFuBenJieSuo then
		var_45_10 = PropType.eFuBenJieSuo
		var_45_15 = string.lf("上仙，今日元辰石已用完！不过发现包裹中还有剩余，是否使用元辰石开启生肖殿？")
	end

	local var_45_16 = var_0_1.tokenId(var_45_10)
	local var_45_17 = getItemName(ItemType.eProp, var_45_16)
	local var_45_18 = Player:getItemCount(ItemType.eProp, var_45_16)
	local var_45_19 = var_0_2.newLabel({
		text = var_45_15,
		color = ccc3(198, 161, 78),
		dimensions = CCSize(440, 60)
	})

	var_45_19:setPosition(var_45_8.width / 2, 140)
	var_45_9:addChild(var_45_19)

	local var_45_20 = getItemHeaderImagePath(ItemType.eProp, var_45_16)
	local var_45_21 = display.newSprite(var_45_20)
	local var_45_22 = var_0_2.newLabel({
		size = 20,
		text = string.lf("拥有 %s：%s", var_45_17, var_45_18),
		color = ccc3(228, 189, 5)
	})

	var_45_21:setPosition(150, 50)
	var_45_22:align(display.LEFT_CENTER, 200, 50)
	var_45_9:addChild(var_45_21)
	var_45_9:addChild(var_45_22)
	var_45_2:addNode(var_45_9)

	local var_45_23 = {
		text = var_45_14,
		enabled = var_45_18 > 0,
		callback = function(arg_47_0, arg_47_1)
			if var_45_0 == var_0_3.eShowSlaveCatch or var_45_0 == var_0_3.eShowShenqiSnatch or var_45_0 == var_0_3.eShowFuBenJieSuo then
				var_45_3(true)
			else
				local var_47_0 = UsePropRequest:new()

				var_47_0:setResponseNormalHandler(function()
					local var_48_0 = var_47_0:getResponseContent()

					var_45_18 = var_45_18 - 1

					if not tolua.isnull(var_45_22) then
						var_45_22:setString(string.lf("拥有 %s：%s", var_45_17, var_45_18))
					end

					var_45_3(true, var_48_0)
				end)
				var_47_0:setResponseExceptionHandler(function()
					var_45_3(false)
				end)

				var_47_0.isNoticeReward = false

				var_47_0:requestUseProp(var_45_16)
			end
		end
	}

	var_45_2:addAction(var_45_23)

	if var_45_1 then
		var_45_23 = {
			text = string.lf("去商城"),
			callback = function(arg_50_0, arg_50_1)
				game.enterStoreScene({
					defaultPage = 2,
					id = var_45_16
				})
			end
		}
	else
		var_45_23 = {
			text = string.lf("取消")
		}
	end

	var_45_2:addAction(var_45_23)

	return var_45_2
end

function var_0_4.createFriendDialog(arg_51_0)
	local var_51_0 = arg_51_0.show
	local var_51_1 = arg_51_0.data
	local var_51_2 = arg_51_0.callback

	arg_51_0.type = var_0_3.eTypeDialog

	local var_51_3 = var_0_3.new(arg_51_0)
	local var_51_4 = "uilocal/common/common_text_006.png"
	local var_51_5 = display.newSprite("ui/common/common_064_2.png")
	local var_51_6 = var_51_5:getContentSize()
	local var_51_7 = display.newSprite(var_51_4)

	var_51_7:setPosition(var_51_6.width / 2, var_51_6.height / 2 + 5)
	var_51_5:addChild(var_51_7)
	var_51_3:addNode(var_51_5)

	var_51_3.padding.top = -16

	local var_51_8 = CCSize(480, 190)
	local var_51_9 = var_0_2.newNode()

	if var_51_0 == var_0_3.eShowEditBox then
		local var_51_10 = var_0_2.newLabel({
			size = 22,
			text = var_51_1.title
		})

		var_51_10:setAnchorPoint(ccp(0.5, 0.5))
		var_51_10:setPosition(var_51_8.width / 2, var_51_8.height - 10)
		var_51_9:addChild(var_51_10)

		local var_51_11 = ui.newEditBox({
			image = "ui/friend/friend_006.png",
			multiLines = true,
			size = CCSize(440, 160),
			fontSize = Adapter.FontSize(24)
		})

		var_51_11:setText(var_51_1.text)
		var_51_11:setAnchorPoint(ccp(0.5, 1))
		var_51_11:setPosition(var_51_8.width / 2, var_51_8.height - 35)
		var_51_9:addChild(var_51_11)

		var_51_9.editbox = var_51_11
	elseif var_51_0 == var_0_3.eShowNoticeBox then
		var_51_8.width, var_51_8.height = 420, 120

		local var_51_12 = var_0_2.newLabel({
			size = 20,
			text = var_51_1,
			dimensions = CCSize(var_51_8.width - 40, 130)
		})

		var_51_12:setPosition(var_51_8.width / 2, 70)
		var_51_9:addChild(var_51_12)

		var_51_3.actionIn = var_0_3.springLayer
	end

	var_51_9:setContentSize(var_51_8)
	var_51_3:addNode(var_51_9)
	var_51_3:addAction({
		text = string.lf("确定"),
		callback = function(arg_52_0, arg_52_1)
			local var_52_0

			if var_51_9.editbox then
				var_52_0 = var_51_9.editbox:getText()

				if #var_52_0 == 0 then
					showFlashNotice(string.lf("不能为空！"))

					return
				end
			end

			var_51_3:removeFromParent()

			return var_51_2 and var_51_2(var_52_0)
		end
	})
	var_51_3:addAction({
		text = string.lf("取消"),
		callback = function(arg_53_0, arg_53_1)
			var_51_3:removeFromParent()
		end
	})

	return var_51_3
end

function var_0_4.createUseExpPill(arg_54_0)
	local var_54_0 = arg_54_0.id
	local var_54_1 = arg_54_0.propType
	local var_54_2 = arg_54_0.heroInfo
	local var_54_3 = arg_54_0.callback
	local var_54_4 = BaseProps[var_54_0]
	local var_54_5 = Player:getItemCount(ItemType.eProp, var_54_0)
	local var_54_6 = 0
	local var_54_7 = BaseHeros[var_54_2.heroId].quality
	local var_54_8 = var_54_2.level
	local var_54_9 = var_54_2.curExp

	arg_54_0.type = var_0_3.eTypeDialog

	local var_54_10 = var_0_3.new(arg_54_0)
	local var_54_11 = 20
	local var_54_12 = ccc3(248, 236, 178)
	local var_54_13 = CCSize(420, 130)
	local var_54_14 = 120
	local var_54_15
	local var_54_16 = var_0_2.newNode()

	var_54_16:setContentSize(var_54_13)

	if var_54_1 == PropType.eExp then
		var_54_15 = createHeroProgressBar({
			level = var_54_8,
			curExp = var_54_9,
			totalExp = var_54_2.totalExp
		})

		var_54_15:setAnchorPoint(CCPoint(0, 0))
		var_54_15:setPosition(CCPoint(50, 80))
		var_54_16:addChild(var_54_15)
	else
		var_54_14 = 100
	end

	local var_54_17 = var_0_2.newLabel({
		text = string.lf("剩余: %s", var_54_5),
		size = var_54_11,
		color = var_54_12
	})

	var_54_17:align(display.LEFT_CENTER, 60, var_54_14)
	var_54_16:addChild(var_54_17)

	local var_54_18 = var_0_2.newLabel({
		text = string.lf("使用: 0"),
		size = var_54_11,
		color = var_54_12
	})

	var_54_18:align(display.LEFT_CENTER, 220, var_54_14)
	var_54_16:addChild(var_54_18)

	local function var_54_19(arg_55_0)
		local var_55_0 = (arg_55_0 - var_54_6) * var_54_4.propValue

		var_54_6 = arg_55_0

		var_54_17:setString(string.lf("剩余: %s", var_54_5 - var_54_6))
		var_54_18:setString(string.lf("使用: %s", var_54_6))

		if var_54_1 == PropType.eExp then
			if var_55_0 >= 0 then
				var_54_15.progressBar:stopAllActions()

				local var_55_1 = tonumber(var_54_15.levelNode.numLabel:getString())
				local var_55_2 = var_55_1 > 0 and var_55_1 or var_54_8
				local var_55_3, var_55_4, var_55_5 = calcLevelWithAddExp(var_54_8, var_54_9, var_55_0, var_54_7)
				local var_55_6 = {}

				for iter_55_0 = var_55_2, var_55_3 - 1 do
					table.insert(var_55_6, getNeedExpWithLevel(iter_55_0, var_54_7))
				end

				var_54_15.progressBar:actionPercent(1, var_55_4, var_55_5, var_55_6, function(arg_56_0)
					var_54_15.levelNode.numLabel:setString(var_55_2 + arg_56_0)
				end)

				var_54_8, var_54_9 = var_55_3, var_55_4
			else
				local var_55_7, var_55_8, var_55_9 = calcLevelWithAddExp(var_54_2.level, var_54_2.curExp, arg_55_0 * var_54_4.propValue, var_54_7)

				var_54_15.progressBar:setProgressValue(1, var_55_8, var_55_9)
				var_54_15.levelNode.numLabel:setString(var_55_7)

				var_54_8, var_54_9 = var_55_7, var_55_8
			end
		end
	end

	local var_54_20 = var_0_2.createCounterNode(0, var_54_5, function(arg_57_0, arg_57_1)
		var_54_19(arg_57_1)
	end)

	var_54_20:setPosition(var_54_13.width / 2, 20)
	var_54_16:addChild(var_54_20)
	var_54_10:addNode(var_54_16)
	var_54_10:addAction({
		text = string.lf("确定"),
		enabled = var_54_5 > 0,
		callback = function(arg_58_0, arg_58_1)
			if var_54_8 > Player.level then
				showFlashNotice(string.lf("主将等级不能超过玩家等级。"))

				return
			end

			var_54_10:removeFromParent()

			return var_54_3 and var_54_3(var_54_6)
		end
	})
	var_54_10:addAction({
		text = string.lf("取消")
	})

	return var_54_10
end

function var_0_4.createUsePotencyPill(arg_59_0)
	local var_59_0 = arg_59_0.id
	local var_59_1 = arg_59_0.propType
	local var_59_2 = arg_59_0.callback
	local var_59_3 = Player:getItemCount(ItemType.eProp, var_59_0)
	local var_59_4 = 0

	arg_59_0.type = var_0_3.eTypeDialog

	local var_59_5 = var_0_3.new(arg_59_0)
	local var_59_6 = 20
	local var_59_7 = ccc3(248, 236, 178)
	local var_59_8 = CCSize(420, 130)
	local var_59_9 = 100
	local var_59_10 = var_0_2.newNode()

	var_59_10:setContentSize(var_59_8)

	local var_59_11 = var_0_2.newLabel({
		text = string.lf("剩余: %s", var_59_3),
		size = var_59_6,
		color = var_59_7
	})

	var_59_11:align(display.LEFT_CENTER, 60, var_59_9)
	var_59_10:addChild(var_59_11)

	local var_59_12 = var_0_2.newLabel({
		text = string.lf("使用: 0"),
		size = var_59_6,
		color = var_59_7
	})

	var_59_12:align(display.LEFT_CENTER, 220, var_59_9)
	var_59_10:addChild(var_59_12)

	local var_59_13 = var_0_2.createCounterNode(0, var_59_3, function(arg_60_0, arg_60_1)
		var_59_4 = arg_60_1

		var_59_11:setString(string.lf("剩余: %s", var_59_3 - var_59_4))
		var_59_12:setString(string.lf("使用: %s", var_59_4))
	end)

	var_59_13:setPosition(var_59_8.width / 2, 20)
	var_59_10:addChild(var_59_13)
	var_59_5:addNode(var_59_10)
	var_59_5:addAction({
		text = string.lf("确定"),
		enabled = var_59_3 > 0,
		callback = function(arg_61_0, arg_61_1)
			var_59_5:removeFromParent()

			return var_59_2 and var_59_2(var_59_4)
		end
	})
	var_59_5:addAction({
		text = string.lf("取消")
	})

	return var_59_5
end

local var_0_8 = {
	eShowChallenge = var_0_4.createTokenDialog,
	eShowSlaveCatch = var_0_4.createTokenDialog,
	eShowPowerEmpty = var_0_4.createTokenDialog,
	eShowTranportEmpty = var_0_4.createTokenDialog,
	eShowShenqiSnatch = var_0_4.createTokenDialog,
	eShowFuBenJieSuo = var_0_4.createTokenDialog,
	eShowReward = var_0_4.createRewardDialog,
	eShowOpenFailed = var_0_4.createOpenFailDialog,
	eShowChangeName = var_0_4.createChangeNameDialog,
	eShowNoticeBox = var_0_4.createFriendDialog,
	eShowEditBox = var_0_4.createFriendDialog,
	eShowPropBuy = var_0_4.createPropDialog,
	eShowPropSell = var_0_4.createPropDialog,
	eShowGiftVolumeBuy = var_0_4.createPropDialog,
	eShowFigureFilter = var_0_4.createFigureFilterDialog,
	eShowTujianHero = var_0_4.createFigureDialog,
	eShowHeroList = var_0_4.createHeroListDialog,
	eShowCSGamble = var_0_4.createCSGambleDialog,
	eShowCSBattle = var_0_4.createCSBattleDialog,
	eUseExpPill = var_0_4.createUseExpPill,
	eUsePotencyPill = var_0_4.createUsePotencyPill
}

for iter_0_0, iter_0_1 in pairs(var_0_8) do
	var_0_3.__register(var_0_3.eTypeDialog, var_0_3[iter_0_0], iter_0_1)
end
