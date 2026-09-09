require("base.figure")
require("network.ShenqiRequest")
require("scenes.battle.BattleOperator")

local var_0_0 = class("ShenqiRevengeLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	addBlackLayer(arg_2_0)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.enemyList = {}

	local var_2_0 = display.newSprite("ui/shenqi/sq_045.png")

	var_2_0:setScale(Adapter.MinScale)
	var_2_0:setPosition(display.cx, display.cy * 0.94)
	arg_2_0:addChild(var_2_0)

	arg_2_0.background = var_2_0
	arg_2_0.bgSize = var_2_0:getContentSize()

	local var_2_1 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		highlightedImage = "ui/common/common_115.png",
		text = string.lf("关闭"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		position = CCPoint(arg_2_0.bgSize.width / 2, 30),
		clickAction = function()
			arg_2_0:removeFromParentAndCleanup(true)
		end
	})

	var_2_0:addChild(var_2_1)
	arg_2_0:initRequests()

	local var_2_2 = CCSize(465, 110)
	local var_2_3 = createTableView({
		reverse = true,
		size = CCSize(arg_2_0.bgSize.width - 10, arg_2_0.bgSize.height - 60),
		direction = kCCScrollViewDirectionVertical,
		dataset = arg_2_0.enemyList,
		sizehandler = function(arg_5_0, arg_5_1)
			return var_2_2
		end,
		cellhandler = function(arg_6_0, arg_6_1, arg_6_2)
			local var_6_0 = arg_6_1 % 2 == 0 and "ui/shenqi/sq_043.png" or "ui/shenqi/sq_044.png"
			local var_6_1 = display.newSprite(var_6_0, var_2_2.width / 2, var_2_2.height / 2)
			local var_6_2 = figure.createHeader({
				isName = false,
				count = 0,
				inTeam = false,
				itemId = arg_6_2.avatarID,
				type = ItemType.eHero
			})

			var_6_2:setAnchorPoint(CCPoint(0.5, 0.5))
			var_6_2:setPosition(50, var_2_2.height / 2 - 1)
			var_6_1:addChild(var_6_2)

			local var_6_3 = string.lf("%s抢夺了您的#FFFF00%s", getFormatCountDownTime(arg_6_2.time), BaseMates[arg_6_2.fragmentID].name)

			addLabelWithColorSize(var_6_1, string.lf("玩家: %s", arg_6_2.name), ccc3(239, 203, 139), 20, CCPoint(0, 0.5), CCPoint(100, var_2_2.height - 22))
			addLabelWithColorSize(var_6_1, string.lf("等级: Lv%s", arg_6_2.level), ccc3(239, 203, 139), 20, CCPoint(0, 0.5), CCPoint(100, var_2_2.height / 2 - 2))
			addLabelWithColorSize(var_6_1, var_6_3, ccc3(255, 0, 0), 18, CCPoint(0, 0.5), CCPoint(100, 18))

			local var_6_4 = ui.newControlButton({
				fontSize = 20,
				normalImage = "ui/common/common_018.png",
				text = string.lf("复仇"),
				anchorPoint = CCPoint(0.5, 0.5),
				position = CCPoint(var_2_2.width - 60, var_2_2.height / 2 + 5),
				clickAction = function()
					function callback(arg_8_0, arg_8_1)
						game.enterShenqiScene()
					end

					BattleOperator:startBattle(eBattleType.ShenqiRevenge, {
						id = arg_6_2.id
					}, callback)
				end
			})

			var_6_1:addChild(var_6_4)

			return var_6_1
		end
	})

	var_2_3:setPosition(5, 57)
	var_2_0:addChild(var_2_3)

	arg_2_0.tableView = var_2_3
	arg_2_0.noEnemyLabel = addLabelWithColorSize(var_2_0, string.lf("暂无仇人"), ccc3(139, 106, 58), 50, ccp(0.5, 0.5), ccp(arg_2_0.bgSize.width / 2, arg_2_0.bgSize.height / 2), _FONT_LISU)

	arg_2_0.battleReportRequest:request()
end

function var_0_0.initRequests(arg_9_0)
	local function var_9_0()
		local var_10_0 = arg_9_0.battleReportRequest.restable

		if table.nums(var_10_0) > 0 then
			arg_9_0.noEnemyLabel:setVisible(false)
		end

		arg_9_0.enemyList = var_10_0

		arg_9_0.tableView:reloadData(arg_9_0.enemyList)
	end

	arg_9_0.battleReportRequest = BattleReportRequest:new()

	arg_9_0.battleReportRequest:setResponseNormalHandler(var_9_0)
end

return var_0_0
