local var_0_0 = require("scenes.ToolLayer")

require("base.figure")
require("scenes.battle.BattleOperator")
require("network.DuelRequest")

local var_0_1 = class("DuelReportLayer", function()
	return CCLayerColor:create(ccc4(10, 10, 10, 180))
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.mParams = arg_2_1

	local var_2_0 = display.newScale9Sprite("ui/common/common_040.png")

	arg_2_0.bgSize = CCSize(850, 500)

	var_2_0:setPreferredSize(arg_2_0.bgSize)
	var_2_0:setScale(Adapter.MinScale)
	var_2_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_0:setPosition(CCPoint(display.cx, display.cy))
	arg_2_0:addChild(var_2_0)

	arg_2_0.background = CCLayerColor:create(ccc4(0, 0, 0, 0))

	arg_2_0.background:setContentSize(arg_2_0.bgSize)
	var_2_0:addChild(arg_2_0.background)

	local var_2_1 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		highlightedImage = "ui/common/btn_closed.png",
		position = CCPoint(arg_2_0.bgSize.width - 15, arg_2_0.bgSize.height - 15),
		clickAction = function()
			arg_2_0:removeFromParentAndCleanup(true)
		end
	})

	var_2_0:addChild(var_2_1)

	local var_2_2 = display.newSprite("ui/common/common_069.png")
	local var_2_3 = display.newSprite("ui/common/common_069.png")

	arg_2_0.imgSize = var_2_2:getContentSize()

	var_2_2:setAnchorPoint(CCPoint(0.5, 0))
	var_2_3:setAnchorPoint(CCPoint(0.5, 0))
	var_2_2:setPosition(CCPoint(215, 40))
	var_2_3:setPosition(CCPoint(arg_2_0.bgSize.width - 215, 40))
	arg_2_0.background:addChild(var_2_2)
	arg_2_0.background:addChild(var_2_3)

	arg_2_0.noEnemyLabel = addLabelWithColorSize(arg_2_0.background, string.lf("暂无仇人"), ccc3(139, 106, 58), 50, ccp(0.5, 0.5), ccp(640, 280), _FONT_LISU)

	arg_2_0.noEnemyLabel:setVisible(false)
	addLabelWithColorSize(var_2_2, string.lf("战报"), ccc3(238, 246, 49), 25, CCPoint(0.5, 0.5), CCPoint(arg_2_0.imgSize.width / 2 - 16, arg_2_0.imgSize.height - 5))
	addLabelWithColorSize(var_2_3, string.lf("我的仇人"), ccc3(238, 246, 49), 25, CCPoint(0.5, 0.5), CCPoint(arg_2_0.imgSize.width / 2 - 16, arg_2_0.imgSize.height - 5))

	arg_2_0.reportList = {}

	arg_2_0:initRequests()
	arg_2_0.getEnemyListRequest:request()
end

function var_0_1.initRequests(arg_5_0)
	local function var_5_0(arg_6_0)
		for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
			local var_6_0 = {
				time = getFormatCountDownTime(iter_6_1.Times),
				content = getFullLogContent(iter_6_1.Content, iter_6_1.Type),
				TriggerPlayerId = iter_6_1.TriggerPlayerId or nil,
				isCanRevolt = iter_6_1.isCanRevolt or nil
			}

			table.insert(arg_5_0.reportList, var_6_0)
		end

		arg_5_0:refreshLayer()
	end

	local function var_5_1()
		dump(arg_5_0.getEnemyListRequest.restable)

		if arg_5_0.getEnemyListRequest.restable.LogLst then
			var_5_0(arg_5_0.getEnemyListRequest.restable.LogLst)
		end

		arg_5_0.revengeList = arg_5_0.getEnemyListRequest.restable.RevengeLst

		arg_5_0.noEnemyLabel:setVisible(#arg_5_0.revengeList < 1)
		arg_5_0:showRevengeList()
	end

	arg_5_0.getEnemyListRequest = DuelGetEnemyListRequest:new()

	arg_5_0.getEnemyListRequest:setResponseNormalHandler(var_5_1)
end

function var_0_1.refreshLayer(arg_8_0, arg_8_1)
	if arg_8_0.logTableview then
		arg_8_0.logTableview:removeFromParentAndCleanup(true)

		arg_8_0.logTableview = nil
	end

	arg_8_0:addLogTableView()
end

function var_0_1.addLogTableView(arg_9_0)
	local var_9_0 = CCSize(400, 100)

	var_9_0.height = 80
	arg_9_0.logTableview = createTableView({
		reverse = true,
		size = CCSize(400, 400),
		direction = kCCScrollViewDirectionVertical,
		dataset = arg_9_0.reportList,
		sizehandler = function(arg_10_0, arg_10_1)
			return var_9_0
		end,
		cellhandler = function(arg_11_0, arg_11_1, arg_11_2)
			local var_11_0 = CCSize(var_9_0.width, var_9_0.height - 6)
			local var_11_1 = display.newScale9Sprite("ui/team/team_093.png")

			var_11_1:setAnchorPoint(ccp(0, 0))
			var_11_1:setContentSize(var_11_0)
			addLabelWithColorSize(var_11_1, arg_11_2.time, ccc3(0, 225, 0), 20, CCPoint(1, 1), CCPoint(100, var_11_0.height - 5))

			local var_11_2 = addLabelWithColorSize(var_11_1, arg_11_2.content, ccc3(255, 225, 255), 18, CCPoint(0, 1), CCPoint(120, var_11_0.height - 5))

			var_11_2:setHorizontalAlignment(ui.TEXT_ALIGN_LEFT)
			var_11_2:setDimensions(CCSize(var_11_0.width - 120, var_11_0.height))

			return var_11_1
		end
	})

	arg_9_0.logTableview:setPosition(15, 4)
	arg_9_0.background:addChild(arg_9_0.logTableview)
end

function var_0_1.showRevengeList(arg_12_0)
	local function var_12_0(arg_13_0)
		return 104, 398
	end

	local function var_12_1(arg_14_0)
		return table.nums(arg_12_0.revengeList)
	end

	local function var_12_2(arg_15_0, arg_15_1)
		local var_15_0 = arg_15_0:cellAtIndex(arg_15_1)

		if var_15_0 == nil then
			var_15_0 = CCTableViewCell:new()

			local var_15_1 = display.newSprite("ui/slave/slave_002.png")
			local var_15_2 = var_15_1:getContentSize()

			var_15_1:setAnchorPoint(CCPoint(0.5, 0.5))
			var_15_1:setPosition(CCPoint(200, 53))
			var_15_0:addChild(var_15_1)
			print(arg_15_1 + 1)

			local var_15_3 = arg_12_0.revengeList[arg_15_1 + 1]
			local var_15_4 = figure.createHeader({
				isName = false,
				count = 0,
				inTeam = false,
				itemId = var_15_3.AvatarID,
				type = ItemType.eHero
			})

			var_15_4:setAnchorPoint(CCPoint(0.5, 0.5))
			var_15_4:setPosition(60, var_15_2.height / 2)
			var_15_0:addChild(var_15_4)
			addLabelWithColorSize(var_15_0, string.lf("%s(%s级)", var_15_3.PlayerName, var_15_3.Lv), ccc3(255, 225, 255), 20, CCPoint(0, 0.5), CCPoint(120, 75))
			addLabelWithColorSize(var_15_0, string.lf("战力：%s", var_15_3.Power), ccc3(255, 225, 255), 20, CCPoint(0, 0.5), CCPoint(120, 30))

			local var_15_5 = ui.newControlButton({
				fontSize = 20,
				disabledImage = "ui/common/common_078.png",
				normalImage = "ui/common/common_027.png",
				text = string.lf("复仇"),
				anchorPoint = CCPoint(0.5, 0),
				position = CCPoint(330, 10),
				clickAction = function()
					arg_12_0:onRivalHeroClicked(var_15_3.PlayerID)
				end
			})

			var_15_0:addChild(var_15_5)
		end

		return var_15_0
	end

	arg_12_0.noEnemyLabel:setVisible(#arg_12_0.revengeList < 1)

	if arg_12_0.revengeTableView then
		arg_12_0.revengeTableView:reloadData()

		return
	end

	local var_12_3, var_12_4 = var_12_0(nil)

	arg_12_0.revengeTableView = CCTableView:create(CCSize(arg_12_0.imgSize.width - 10, 395))

	arg_12_0.revengeTableView:setContentSize(CCSize(arg_12_0.imgSize.width - 10, var_12_1(nil) * var_12_3))
	arg_12_0.revengeTableView:setPosition(436, 6)
	arg_12_0.revengeTableView:setVerticalFillOrder(kCCTableViewFillTopDown)
	arg_12_0.revengeTableView:setDirection(kCCScrollViewDirectionVertical)
	arg_12_0.background:addChild(arg_12_0.revengeTableView)
	arg_12_0.revengeTableView:registerScriptHandler(var_12_0, CCTableView.kTableCellSizeForIndex)
	arg_12_0.revengeTableView:registerScriptHandler(var_12_1, CCTableView.kNumberOfCellsInTableView)
	arg_12_0.revengeTableView:registerScriptHandler(var_12_2, CCTableView.kTableCellSizeAtIndex)
	arg_12_0.revengeTableView:reloadData()
	arg_12_0.revengeTableView:setContentOffset(arg_12_0.revengeTableView:minContainerOffset())
end

function var_0_1.onRivalHeroClicked(arg_17_0, arg_17_1)
	if arg_17_0.mParams and arg_17_0.mParams.haveTime > 0 then
		ui.showMessageBox({
			text = string.lf("消耗一次比赛次数进行复仇?"),
			title1 = string.lf("确定"),
			title2 = string.lf("取消"),
			action1 = function()
				return arg_17_0:revengeRequest(arg_17_1)
			end
		})
	elseif Player.curGold < arg_17_0.mParams.goldCost then
		ui.showMessageBox({
			text = string.lf("元宝不足，去充值吧！"),
			title1 = string.lf("取消"),
			title2 = string.lf("充值"),
			action2 = function()
				game.enterStoreRechargeScene({
					from = "DuelRankScene"
				})
			end
		})
	else
		ui.showMessageBox({
			text = string.lf("消耗%s元宝进行复仇?", arg_17_0.mParams.goldCost),
			title1 = string.lf("确定"),
			title2 = string.lf("取消"),
			action1 = function()
				return arg_17_0:revengeRequest(arg_17_1)
			end
		})
	end
end

function var_0_1.revengeRequest(arg_21_0, arg_21_1)
	BattleOperator:startBattle(eBattleType.DuleRevenge, {
		enemyId = arg_21_1
	}, function(arg_22_0, arg_22_1)
		game.enterDuelRankScene(arg_22_1.XianMoFight)
	end)
end

return var_0_1
