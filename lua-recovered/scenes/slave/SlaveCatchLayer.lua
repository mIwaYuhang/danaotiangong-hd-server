require("base.figure")
require("scenes.battle.BattleOperator")

local var_0_0 = {
	typeRandomEnemy = 1,
	typePersonalEnemy = 2
}
local var_0_1
local var_0_2
local var_0_3
local var_0_4 = 0
local var_0_5 = class("SlaveCatchLayer", function()
	return display.newLayer()
end)

function var_0_5.ctor(arg_2_0, arg_2_1)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

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
			GuideLayer:removeAllGuideLayer()
			arg_2_0:removeFromParentAndCleanup(true)
		end
	})

	var_2_0:addChild(var_2_1)

	for iter_2_0, iter_2_1 in pairs(BaseProps) do
		if iter_2_1.propType == PropType.eSuperCatchToken then
			var_0_4 = iter_2_0

			break
		end
	end

	arg_2_0:initRequests()
	arg_2_0:refreshLayer(arg_2_1)
end

function var_0_5.refreshLayer(arg_5_0, arg_5_1)
	arg_5_0.background:removeAllChildrenWithCleanup(true)

	var_0_3 = arg_5_1.location

	local function var_5_0()
		var_0_1 = nil
		var_0_2 = nil

		arg_5_0:showEnemyList(var_0_0.typeRandomEnemy)
		arg_5_0:showEnemyList(var_0_0.typePersonalEnemy)
		arg_5_0.randomListRequest:request()
		arg_5_0.enemyListRequest:request(1)
	end

	local var_5_1 = ui.newControlButton({
		normalImage = "ui/common/common_018.png",
		highlightedImage = "ui/common/common_018.png",
		text = string.lf("换一批"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		anchorPoint = CCPoint(0.5, 1),
		position = CCPoint(arg_5_0.bgSize.width / 2 - 200, arg_5_0.bgSize.height),
		clickAction = function()
			var_5_0()
		end
	})

	arg_5_0.background:addChild(var_5_1)

	local var_5_2 = "ui/common/common_028.png"
	local var_5_3 = "ui/common/common_029.png"

	addLabelWithColorSize(arg_5_0.background, string.lf("使用超级抓捕令"), ccc3(200, 150, 49), 20, CCPoint(1, 1), CCPoint(arg_5_0.bgSize.width / 2 + 150, arg_5_0.bgSize.height - 16))

	arg_5_0.btnProp = ui.newControlButton({
		normalImage = var_5_2,
		anchorPoint = CCPoint(0, 1),
		position = CCPoint(arg_5_0.bgSize.width / 2 + 150, arg_5_0.bgSize.height - 8),
		clickAction = function()
			if arg_5_0.btnProp:getTag() == 1 then
				arg_5_0.btnProp:setTag(0)
				arg_5_0.btnProp:setBackgroundSpriteForState(CCScale9Sprite:create(var_5_2), CCControlStateNormal)

				if arg_5_0.superCatchFlag ~= nil then
					arg_5_0.superCatchFlag:setVisible(false)
				end
			else
				if Player:getItemCount(ItemType.eProp, var_0_4) == 0 then
					showFlashNotice(string.lf("您的超级抓捕令已经用完。"))

					return
				end

				arg_5_0.btnProp:setTag(1)
				arg_5_0.btnProp:setBackgroundSpriteForState(CCScale9Sprite:create(var_5_3), CCControlStateNormal)

				if arg_5_0.superCatchFlag == nil then
					arg_5_0.superCatchFlag = display.newSprite("uilocal/slave/slave_text_006.png")

					arg_5_0.superCatchFlag:setAnchorPoint(CCPoint(0.5, 0))
					arg_5_0.superCatchFlag:setPosition(arg_5_0.bgSize.width / 2, arg_5_0.bgSize.height)
					arg_5_0.background:addChild(arg_5_0.superCatchFlag)
				else
					arg_5_0.superCatchFlag:setVisible(true)
				end
			end
		end
	})

	arg_5_0.btnProp:setTag(0)
	arg_5_0.background:addChild(arg_5_0.btnProp)

	local var_5_4 = display.newSprite(getItemHeaderImagePath(ItemType.eProp, var_0_4))
	local var_5_5 = var_5_4:getContentSize()

	var_5_4:setAnchorPoint(CCPoint(0, 1))
	var_5_4:setPosition(arg_5_0.bgSize.width / 2 + 180, arg_5_0.bgSize.height + 15)
	arg_5_0.background:addChild(var_5_4)

	local var_5_6 = createNumberWidthBgSprite("ui/common/common_017.png", Player:getItemCount(ItemType.eProp, var_0_4))

	var_5_6:setAnchorPoint(CCPoint(1, 0))
	var_5_6:setPosition(var_5_5.width * 3 / 4, 20)
	var_5_4:addChild(var_5_6)

	local var_5_7 = display.newSprite("ui/common/common_069.png")
	local var_5_8 = display.newSprite("ui/common/common_069.png")

	arg_5_0.imgSize = var_5_7:getContentSize()

	var_5_7:setAnchorPoint(CCPoint(0.5, 0))
	var_5_8:setAnchorPoint(CCPoint(0.5, 0))
	var_5_7:setPosition(CCPoint(215, 40))
	var_5_8:setPosition(CCPoint(arg_5_0.bgSize.width - 215, 40))
	arg_5_0.background:addChild(var_5_7)
	arg_5_0.background:addChild(var_5_8)

	arg_5_0.noEnemyLabel = addLabelWithColorSize(arg_5_0.background, string.lf("暂无仇人"), ccc3(139, 106, 58), 50, ccp(0.5, 0.5), ccp(640, 280), _FONT_LISU)

	arg_5_0.noEnemyLabel:setVisible(false)
	addLabelWithColorSize(var_5_7, string.lf("随机选择"), ccc3(238, 246, 49), 25, CCPoint(0.5, 0.5), CCPoint(arg_5_0.imgSize.width / 2 - 16, arg_5_0.imgSize.height - 5))
	addLabelWithColorSize(var_5_8, string.lf("我的仇人"), ccc3(238, 246, 49), 25, CCPoint(0.5, 0.5), CCPoint(arg_5_0.imgSize.width / 2 - 16, arg_5_0.imgSize.height - 5))
	var_5_0()
end

function var_0_5.initRequests(arg_9_0)
	local function var_9_0()
		var_0_1 = arg_9_0.randomListRequest.restable

		arg_9_0:showEnemyList(var_0_0.typeRandomEnemy)
		GuideLayer:showGuideLayer(nil, arg_9_0.background, TaskEntryType.eEntryDarkhouseCapture, 4)
	end

	arg_9_0.randomListRequest = SlaveRandomListRequest:new()

	arg_9_0.randomListRequest:setResponseNormalHandler(var_9_0)

	local function var_9_1()
		var_0_2 = arg_9_0.enemyListRequest.restable

		arg_9_0:showEnemyList(var_0_0.typePersonalEnemy)
	end

	arg_9_0.enemyListRequest = SlaveEnemyListRequest:new()

	arg_9_0.enemyListRequest:setResponseNormalHandler(var_9_1)

	local function var_9_2()
		local function var_12_0()
			game.enterSlaveScene()
		end

		local var_12_1 = arg_9_0.catchRequest.restable
		local var_12_2 = string.lf("恭喜上仙，超级抓捕令让您如虎添翼，轻而易举地战胜了玩家: %s", var_12_1.enemy.Name)
		local var_12_3 = require("scenes.PK.PKCompleteLayer").new({
			result = true,
			text = {
				var_12_2
			},
			reward = var_12_1.Reward,
			callback = var_12_0
		})

		arg_9_0:addChild(var_12_3, 11)
	end

	arg_9_0.catchRequest = SlaveCatchRequest:new()

	arg_9_0.catchRequest:setResponseNormalHandler(var_9_2)
end

function var_0_5.showEnemyList(arg_14_0, arg_14_1)
	local function var_14_0(arg_15_0)
		return 106, 400
	end

	local function var_14_1(arg_16_0)
		if arg_14_1 == var_0_0.typeRandomEnemy then
			return var_0_1 == nil and 0 or table.nums(var_0_1)
		else
			return var_0_2 == nil and 0 or table.nums(var_0_2)
		end
	end

	local function var_14_2(arg_17_0, arg_17_1)
		local var_17_0 = arg_17_0:cellAtIndex(arg_17_1)
		local var_17_1 = arg_14_1 == var_0_0.typeRandomEnemy and var_0_1[arg_17_1 + 1] or var_0_2[arg_17_1 + 1]

		if var_17_0 == nil then
			var_17_0 = CCTableViewCell:new()

			local var_17_2 = display.newSprite(arg_14_1 == var_0_0.typeRandomEnemy and "ui/slave/slave_001.png" or "ui/slave/slave_002.png")
			local var_17_3 = var_17_2:getContentSize()

			var_17_2:setAnchorPoint(CCPoint(0.5, 0.5))
			var_17_2:setPosition(CCPoint(200, 53))
			var_17_0:addChild(var_17_2)

			local var_17_4
			local var_17_5

			for iter_17_0, iter_17_1 in pairs(var_17_1.CaptureMasterInfo) do
				if iter_17_1.type == 1 then
					var_17_4 = iter_17_1
				elseif iter_17_1.type == 2 then
					var_17_5 = iter_17_1
				end
			end

			local var_17_6 = figure.createHeader({
				isName = false,
				count = 0,
				inTeam = false,
				itemId = var_17_4.avatar,
				type = ItemType.eHero
			})

			var_17_6:setAnchorPoint(CCPoint(0.5, 0.5))
			var_17_6:setPosition(60, var_17_3.height / 2)
			var_17_0:addChild(var_17_6)
			addLabelWithColorSize(var_17_0, string.lf("%s(%s级)", var_17_4.name, var_17_4.level), ccc3(255, 225, 255), 20, CCPoint(0, 0.5), CCPoint(120, 75))
			addLabelWithColorSize(var_17_0, string.lf("战力：%s", var_17_4.battlePower), ccc3(255, 225, 255), 20, CCPoint(0, 0.5), CCPoint(120, 30))

			if var_17_1.isCapture == 1 then
				local var_17_7

				if var_17_4.IsUseProp == 1 then
					var_17_7 = createMarkLabel({
						size = 18,
						text = string.lf("超级抓捕")
					})
				else
					var_17_7 = display.newSprite("ui/slave/slave_010.png")
				end

				var_17_7:setAnchorPoint(CCPoint(0, 1))
				var_17_7:setPosition(CCPoint(2, var_17_3.height - 2))
				var_17_0:addChild(var_17_7)
			end

			local var_17_8 = ui.newControlButton({
				fontSize = 20,
				disabledImage = "ui/common/common_078.png",
				normalImage = "ui/common/common_027.png",
				text = string.lf("抓捕"),
				anchorPoint = CCPoint(0.5, 0),
				position = CCPoint(330, 10),
				clickAction = function()
					GuideLayer:stepDone(TaskEntryType.eEntryDarkhouseCapture, 4)
					GuideLayer:removeAllGuideLayer()

					if var_17_1.isCapture == 1 then
						arg_14_0:showQueryDlg(var_17_4, var_17_5, arg_17_0)
					else
						arg_14_0:catchOneEnemy(var_0_3, var_17_4.enemyid)
					end
				end
			})

			var_17_0:addChild(var_17_8)

			if var_17_5 ~= nil and var_17_5.enemyid == Player.userId then
				var_17_8:setEnabled(false)
			end

			if var_17_4.IsUseProp == 1 then
				var_17_8:setEnabled(false)
			end
		end

		return var_17_0
	end

	if arg_14_1 == var_0_0.typePersonalEnemy then
		arg_14_0.noEnemyLabel:setVisible((var_0_2 == nil or table.nums(var_0_2) == 0) and true or false)
	end

	local var_14_3 = arg_14_1 == var_0_0.typeRandomEnemy and arg_14_0.randomTable or arg_14_0.personalTable

	if var_14_3 then
		var_14_3:reloadData()

		return
	end

	local var_14_4, var_14_5 = var_14_0(nil)
	local var_14_6 = CCTableView:create(CCSize(arg_14_0.imgSize.width - 10, 380))

	var_14_6:setContentSize(CCSize(arg_14_0.imgSize.width - 10, var_14_1(nil) * var_14_4))
	var_14_6:setPosition(arg_14_1 == var_0_0.typeRandomEnemy and CCPoint(16, 15) or CCPoint(436, 15))
	var_14_6:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_14_6:setDirection(kCCScrollViewDirectionVertical)
	arg_14_0.background:addChild(var_14_6)
	var_14_6:registerScriptHandler(var_14_0, CCTableView.kTableCellSizeForIndex)
	var_14_6:registerScriptHandler(var_14_1, CCTableView.kNumberOfCellsInTableView)
	var_14_6:registerScriptHandler(var_14_2, CCTableView.kTableCellSizeAtIndex)
	var_14_6:reloadData()
	var_14_6:setContentOffset(var_14_6:minContainerOffset())

	if arg_14_1 == var_0_0.typeRandomEnemy then
		arg_14_0.randomTable = var_14_6
	else
		arg_14_0.personalTable = var_14_6
	end
end

function var_0_5.showQueryDlg(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = require("scenes.ToolLayer").new({
		touchable = true,
		cancelable = true
	})
	local var_19_1 = CCNode:create()
	local var_19_2 = arg_19_3:getContentSize()
	local var_19_3 = CCSize(300, 120)

	var_19_1:setContentSize(var_19_3)
	addLabelWithColorSize(var_19_1, string.lf("该玩家已被俘虏"), ccc3(255, 225, 135), 20, CCPoint(0.5, 1), CCPoint(var_19_3.width / 2, 110))
	addLabelWithColorSize(var_19_1, string.lf("主人：%s（%s级）", arg_19_2.name, arg_19_2.level), ccc3(255, 255, 255), 20, CCPoint(0, 0), CCPoint(20, 40))
	addLabelWithColorSize(var_19_1, string.lf("战力：%s", arg_19_2.battlePower), ccc3(255, 255, 255), 20, CCPoint(0, 0), CCPoint(20, 5))
	var_19_0:addNode(var_19_1)
	var_19_0:addAction({
		text = string.lf("抢夺"),
		callback = function()
			arg_19_0:catchOneEnemy(var_0_3, arg_19_1.enemyid)
		end
	})
	var_19_0:show({
		parent = arg_19_0.background,
		x = arg_19_3:getPositionX(),
		y = arg_19_0.bgSize.height / 2,
		align = display.LEFT_CENTER
	})
end

function var_0_5.catchOneEnemy(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0.btnProp:getTag() == 1 and Player:getItemCount(ItemType.eProp, var_0_4) > 0 then
		arg_21_0.catchRequest:request(arg_21_1, arg_21_2)
	else
		function callback(arg_22_0, arg_22_1)
			game.enterSlaveScene()
		end

		BattleOperator:startBattle(eBattleType.DarkHouseCatch, {
			location = arg_21_1,
			capturePlayerID = arg_21_2
		}, callback)
	end
end

return var_0_5
