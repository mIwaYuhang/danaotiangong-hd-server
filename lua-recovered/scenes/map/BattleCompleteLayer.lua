require("base.figure")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = 2
local var_0_2 = class("BattleCompleteLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

function var_0_2.ctor(arg_2_0, arg_2_1)
	if arg_2_1.stageId then
		arg_2_0.stageId = arg_2_1.stageId
	end

	arg_2_0.callback = arg_2_1.callback
	arg_2_0.oldExp = {
		level = Player.level,
		curExp = Player.curExp,
		levelUpExp = Player.levelUpExp
	}
	arg_2_0.oldGroup = {}

	for iter_2_0, iter_2_1 in pairs(Player.team.groupList) do
		if iter_2_1.heroId ~= 0 then
			local var_2_0 = {
				level = iter_2_1.level,
				curExp = iter_2_1.curExp,
				levelUpExp = iter_2_1.totalExp,
				heroId = iter_2_1.heroId
			}

			table.insert(arg_2_0.oldGroup, var_2_0)
		end
	end

	arg_2_0.viewTable = nil

	arg_2_0:init()
end

function var_0_2.init(arg_3_0)
	print("BattleCompleteLayer:ctor")

	local function var_3_0(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == "began" then
			local var_4_0 = 500 * Adapter.MinScale
			local var_4_1 = 130 * Adapter.MinScale

			if CCRect(display.cx - var_4_0 / 2, display.cy - 170 * Adapter.MinScale - var_4_1 / 2, var_4_0, var_4_1):containsPoint(ccp(arg_4_1, arg_4_2)) then
				-- block empty
			else
				if arg_3_0.viewTable then
					arg_3_0.viewTable:removeFromParentAndCleanup(true)
				end

				arg_3_0:setTouchEnabled(false)
				arg_3_0:removeFromParentAndCleanup(true)

				if arg_3_0.callback then
					arg_3_0.callback()

					arg_3_0.callback = nil
				end
			end

			return true
		end
	end

	arg_3_0:addTouchEventListener(var_3_0, false, 0, false)
	arg_3_0:setTouchEnabled(true)

	arg_3_0.rewardList = {}
	arg_3_0.rewardFirst = {}

	local var_3_1 = 0
	local var_3_2 = 0
	local var_3_3 = 0

	for iter_3_0, iter_3_1 in pairs(BattleData.reward) do
		if iter_3_1.Type == ItemType.eCoin then
			var_3_1 = iter_3_1.Count
		elseif iter_3_1.Type == ItemType.eKnowledge then
			var_3_2 = iter_3_1.Count
		elseif iter_3_1.Type == ItemType.eEXP then
			var_3_3 = iter_3_1.Count
		end

		if iter_3_1.Type == ItemType.eSoul or iter_3_1.Type == ItemType.eProp or iter_3_1.Type == ItemType.eMate or iter_3_1.Type == ItemType.eHero or iter_3_1.Type == ItemType.eEquip or iter_3_1.Type == ItemType.eTrainPill or iter_3_1.Type == ItemType.eFragment then
			table.insert(arg_3_0.rewardList, iter_3_1)
			table.insert(arg_3_0.rewardFirst, true)
		end
	end

	arg_3_0:setColor(display.COLOR_BLACK)
	arg_3_0:setOpacity(191.25)

	local var_3_4 = display.newSprite("ui/battle/battle_000.png")

	var_3_4:setScaleX(1 * Adapter.MinScale)
	var_3_4:setScaleY(1 * Adapter.MinScale)
	var_3_4:setPosition(display.cx, display.cy + 55 * Adapter.MinScale)
	arg_3_0:addChild(var_3_4)
	arg_3_0:createPlayerExp(0, 0, 0)

	arg_3_0.expTable, arg_3_0.headerTable = arg_3_0:createHeader()

	local var_3_5 = require("base.cache").get("BattleDiffculty") or 1

	print("获取 战斗困难等级...." .. var_3_5)
	arg_3_0:sharkStarAction(var_3_5, function(...)
		local var_5_0 = {
			level = BattleData.BattleReward.Level,
			curExp = BattleData.BattleReward.CurExp,
			levelUpExp = BattleData.BattleReward.NextLvExp
		}

		arg_3_0:playerExpAction(arg_3_0.oldExp, var_5_0)
		arg_3_0:labelAction(arg_3_0.playerExp.labelIgnot, var_3_1, 2, "+%d")
		print("knowledge:" .. var_3_2)
		arg_3_0:labelAction(arg_3_0.playerExp.labelExp, var_3_3, 2, "+%d")

		for iter_5_0, iter_5_1 in pairs(Player.team.groupList) do
			if iter_5_1.heroId ~= 0 then
				local var_5_1

				for iter_5_2, iter_5_3 in pairs(arg_3_0.oldGroup) do
					if iter_5_1.heroId == iter_5_3.heroId then
						var_5_1 = iter_5_3
					end
				end

				local var_5_2 = arg_3_0:findHeroInfo(iter_5_1)
				local var_5_3 = {
					level = var_5_2.Level,
					curExp = var_5_2.CurExp,
					levelUpExp = var_5_2.NextLvExp
				}

				arg_3_0:heroExpAction(arg_3_0.expTable[iter_5_0], arg_3_0.headerTable[iter_5_0], var_5_1, var_5_3)
				arg_3_0:labelAction(arg_3_0.expTable[iter_5_0].label, var_5_2.GetExp, 2, string.lf("经验+%d"))
			end
		end
	end)

	local var_3_6 = CCArray:create()

	var_3_6:addObject(CCDelayTime:create(2))
	var_3_6:addObject(CCCallFunc:create(function(...)
		arg_3_0.tableview_num = 0
		arg_3_0.tableview = arg_3_0:createItemTableView()

		local var_6_0 = CCArray:create()

		for iter_6_0 = 1, table.nums(arg_3_0.rewardList) do
			var_6_0:addObject(CCCallFunc:create(function(...)
				arg_3_0.tableview_num = iter_6_0

				arg_3_0.tableview:reloadData()
			end))
			var_6_0:addObject(CCDelayTime:create(1))
		end

		var_6_0:addObject(CCCallFunc:create(function(...)
			return
		end))
		arg_3_0.tableview:runAction(CCSequence:create(var_6_0))
	end))
	arg_3_0:runAction(CCSequence:create(var_3_6))

	local var_3_7 = "effectAni/ui_zhandoushengli.json"
	local var_3_8 = "effectAni/ui_zhandoushengli.atlas"
	local var_3_9 = CCSkeletonAnimation:createWithFile(var_3_7, var_3_8, Adapter.MinScale)

	var_3_9:setPosition(display.cx, display.cy)
	arg_3_0:addChild(var_3_9)
	var_3_9:setAnimation("ui_zhandoushengli", false, 0)
	var_3_9:addAnimationAction("ui_zhandoushengli", 1, CCCallFunc:create(function(...)
		var_3_9:removeFromParentAndCleanup(true)
	end), AAT_Percent)
end

function var_0_2.findHeroInfo(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(BattleData.BattleReward.HeroExps) do
		if arg_10_1.heroId == iter_10_1.Id then
			return iter_10_1
		end
	end

	return {
		GetExp = 0,
		Level = arg_10_1.level,
		CurExp = arg_10_1.curExp,
		NextLvExp = arg_10_1.totalExp
	}
end

function var_0_2.sharkStarAction(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = require("scenes.toollayer.ctrl")
	local var_11_1 = require("scenes.toollayer.tool")

	local function var_11_2()
		local var_12_0 = math.random(-1, 1)
		local var_12_1 = math.random(-1, 1)
		local var_12_2 = math.random(-1, 1)
		local var_12_3 = math.random(-1, 1)
		local var_12_4 = CCArray:create()

		var_12_4:addObject(CCMoveBy:create(0.03, ccp(var_12_0, -var_12_1)))
		var_12_4:addObject(CCMoveBy:create(0.03, ccp(-var_12_0, var_12_1)))
		var_12_4:addObject(CCMoveBy:create(0.03, ccp(var_12_2, -var_12_3)))
		var_12_4:addObject(CCMoveBy:create(0.03, ccp(-var_12_2, var_12_3)))
		arg_11_0:runAction(CCSequence:create(var_12_4))
	end

	local function var_11_3(arg_13_0)
		local var_13_0 = arg_13_0.node
		local var_13_1 = arg_13_0.from
		local var_13_2 = arg_13_0.to
		local var_13_3 = arg_13_0.duration
		local var_13_4 = arg_13_0.delay
		local var_13_5 = arg_13_0.callback
		local var_13_6 = 10
		local var_13_7 = 1

		var_13_0:setScale(var_13_6)
		var_13_0:setPosition(var_13_1)
		var_13_0:setOpacity(0)

		local var_13_8 = CCArray:create()

		if var_13_4 then
			var_13_8:addObject(CCDelayTime:create(var_13_4))
		end

		local var_13_9 = CCArray:create()
		local var_13_10 = CCScaleTo:create(var_13_3, var_13_7)

		var_13_9:addObject(CCEaseIn:create(var_13_10, 8))

		local var_13_11 = CCMoveTo:create(var_13_3, var_13_2)

		var_13_9:addObject(CCEaseIn:create(var_13_11, 8))

		local var_13_12 = CCFadeTo:create(var_13_3, 255)

		var_13_9:addObject(CCEaseIn:create(var_13_12, 8))

		local var_13_13 = CCSpawn:create(var_13_9)

		var_13_8:addObject(var_13_13)
		var_13_8:addObject(CCCallFunc:create(var_11_2))

		if var_13_5 then
			var_13_8:addObject(CCCallFunc:create(var_13_5))
		end

		var_13_0:runAction(CCSequence:create(var_13_8))
	end

	local function var_11_4()
		local var_14_0
		local var_14_1 = {}

		for iter_14_0 = 1, arg_11_1 do
			local var_14_2 = display.newSprite("ui/battle/battle_002.png")

			var_14_2:setVisible(false)
			table.insert(var_14_1, var_14_2)
		end

		local var_14_3 = var_11_0.linearLayout({
			margin = 20,
			nodes = var_14_1
		})

		var_14_3:setScale(Adapter.MinScale)
		var_14_3:setPosition(Adapter.AutoPos(480, 560))
		arg_11_0:addChild(var_14_3)
		var_11_1.foreach(var_14_1, function(arg_15_0, arg_15_1, arg_15_2)
			local var_15_0, var_15_1 = arg_15_1:getPosition()

			arg_15_1:setVisible(true)
			var_11_3({
				duration = 0.3,
				node = arg_15_1,
				from = ccp(var_15_0, var_15_1 - 200),
				to = ccp(var_15_0, var_15_1),
				callback = arg_15_2
			})
		end, arg_11_2)
	end

	local var_11_5 = {
		"battle_text_231.png",
		"battle_text_232.png",
		"battle_text_233.png"
	}
	local var_11_6 = CCSprite:create("uilocal/battle/" .. var_11_5[arg_11_1])
	local var_11_7 = var_11_6:getContentSize()
	local var_11_8 = var_11_7.width / 2
	local var_11_9 = var_11_7.height / 2
	local var_11_10 = var_11_0.newNode()

	var_11_10:setAnchorPoint(ccp(0.5, 0.5))
	var_11_10:setPosition(Adapter.AutoPos(480, 455))
	var_11_10:setScale(Adapter.MinScale)
	var_11_10:setContentSize(var_11_7)
	var_11_10:addChild(var_11_6)
	arg_11_0:addChild(var_11_10)
	var_11_3({
		delay = 0.4,
		duration = 0.6,
		node = var_11_6,
		from = ccp(var_11_8, var_11_9 - 200),
		to = ccp(var_11_8, var_11_9),
		callback = var_11_4
	})
end

function var_0_2.playerExpAction(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = false
	local var_16_1, var_16_2 = arg_16_0.playerExp:getPosition()

	if not arg_16_3 then
		var_16_0 = true
		arg_16_3 = CCArray:create()
	end

	if arg_16_2.level > arg_16_1.level then
		arg_16_3:addObject(CCProgressFromTo:create((1 - arg_16_1.curExp / arg_16_1.levelUpExp) * var_0_1, arg_16_1.curExp / arg_16_1.levelUpExp * 100, 100))

		if arg_16_2.level <= Player.level then
			arg_16_1.level = arg_16_1.level + 1
			arg_16_1.curExp = 0

			local var_16_3 = arg_16_1.level

			arg_16_3:addObject(CCCallFunc:create(function()
				arg_16_0.playerLevel:setString(string.lf("%s级", var_16_3))
				arg_16_0.playerExp:setPercentage(0)
			end))
			arg_16_0:playerExpAction(arg_16_1, arg_16_2, arg_16_3)
		end
	else
		arg_16_3:addObject(CCProgressFromTo:create((arg_16_2.curExp / arg_16_2.levelUpExp - arg_16_1.curExp / arg_16_1.levelUpExp) * var_0_1, arg_16_1.curExp / arg_16_1.levelUpExp * 100, arg_16_2.curExp / arg_16_2.levelUpExp * 100))
	end

	if var_16_0 then
		arg_16_0.playerExp:runAction(CCSequence:create(arg_16_3))
	end
end

function var_0_2.labelAction(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = 0

	local function var_18_1(arg_19_0)
		var_18_0 = var_18_0 + arg_19_0

		if var_18_0 >= arg_18_3 then
			arg_18_1:setString(string.format(arg_18_4, arg_18_2))
			arg_18_1:unscheduleUpdate()

			return
		end

		arg_18_1:setString(string.format(arg_18_4, var_18_0 / arg_18_3 * arg_18_2))
	end

	arg_18_1:scheduleUpdate(var_18_1)
end

function var_0_2.heroExpAction(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	local var_20_0 = false
	local var_20_1, var_20_2 = arg_20_1:getPosition()

	if not arg_20_5 then
		var_20_0 = true
		arg_20_5 = CCArray:create()
	end

	if arg_20_4.level > arg_20_3.level then
		arg_20_5:addObject(CCProgressFromTo:create((1 - arg_20_3.curExp / arg_20_3.levelUpExp) * var_0_1, arg_20_3.curExp / arg_20_3.levelUpExp * 100, 100))
		arg_20_5:addObject(CCCallFunc:create(function(...)
			if not arg_20_1.spriteLevelup then
				local var_21_0 = CCSprite:create("ui/battle/battle_026.png")

				var_21_0:setPosition(Adapter.MinPos(-40, 25))
				var_21_0:setScale(Adapter.MinScale)
				arg_20_1:getParent():addChild(var_21_0)
				var_21_0:setOpacity(0)
				var_21_0:runAction(CCFadeIn:create(0.3))
			end

			arg_20_2:setLevel(arg_20_3.level + 1)
		end))

		arg_20_3.level = arg_20_3.level + 1
		arg_20_3.curExp = 0

		local var_20_3 = arg_20_3.level

		arg_20_5:addObject(CCCallFunc:create(function()
			arg_20_2.number:setString(var_20_3)
			arg_20_1:setPercentage(0)
		end))
		arg_20_0:heroExpAction(arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	else
		arg_20_5:addObject(CCProgressFromTo:create((arg_20_4.curExp / arg_20_4.levelUpExp - arg_20_3.curExp / arg_20_3.levelUpExp) * var_0_1, arg_20_3.curExp / arg_20_3.levelUpExp * 100, arg_20_4.curExp / arg_20_4.levelUpExp * 100))
	end

	if var_20_0 then
		arg_20_1:runAction(CCSequence:create(arg_20_5))
	end
end

function var_0_2.createItemTableView(arg_23_0)
	local var_23_0 = CCNode:create()
	local var_23_1 = CCSprite:create("uilocal/battle/battle_text_002.png")

	var_23_1:setScale(Adapter.MinScale)
	var_23_1:setPosition(0, 60 * Adapter.MinScale)
	var_23_0:addChild(var_23_1)

	local var_23_2 = CCTableView:create(Adapter.MinSize(500, 130))

	var_23_2:setPosition(0, -10 * Adapter.MinScale)
	var_23_2:setViewSize(Adapter.MinSize(500, 130))
	var_23_2:ignoreAnchorPointForPosition(false)
	var_23_2:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_23_2:setDirection(kCCScrollViewDirectionHorizontal)
	var_23_0:addChild(var_23_2)

	arg_23_0.viewTable = var_23_2

	local function var_23_3(arg_24_0, arg_24_1)
		return Adapter.MinScale * 110, Adapter.MinScale * 130
	end

	local function var_23_4(arg_25_0)
		return arg_23_0.tableview_num
	end

	local function var_23_5(arg_26_0, arg_26_1)
		local var_26_0 = arg_26_0:cellAtIndex(arg_26_1)
		local var_26_1 = arg_26_1 + 1

		if var_26_0 == nil then
			var_26_0 = CCTableViewCell:new()

			local var_26_2 = {
				isName = true,
				type = arg_23_0.rewardList[var_26_1].Type,
				itemId = arg_23_0.rewardList[var_26_1].ID,
				count = arg_23_0.rewardList[var_26_1].Count,
				clickAction = function()
					var_0_0.tipshandler(arg_23_0.rewardList[var_26_1])
				end
			}
			local var_26_3 = figure.createHeader(var_26_2)

			var_26_3:setScale(Adapter.MinScale)
			var_26_3:setAnchorPoint(CCPoint(0.5, 0.5))
			var_26_3:setPosition(Adapter.MinScale * 110 / 2, Adapter.MinScale * 130 / 2)
			var_26_0:addChild(var_26_3)

			if arg_23_0.rewardFirst[var_26_1] then
				arg_23_0.rewardFirst[var_26_1] = false

				local var_26_4 = "effectAni/ui_zhuangbeiqianghua.json"
				local var_26_5 = "effectAni/ui_zhuangbeiqianghua.atlas"
				local var_26_6 = CCSkeletonAnimation:createWithFile(var_26_4, var_26_5, Adapter.MinScale)

				var_26_6:setPosition(Adapter.MinScale * 110 / 2, Adapter.MinScale * 130 / 2)
				var_26_0:addChild(var_26_6)
				var_26_6:setAnimation("animation", false, 0)
			end
		end

		return var_26_0
	end

	var_23_2:registerScriptHandler(var_23_3, CCTableView.kTableCellSizeForIndex)
	var_23_2:registerScriptHandler(var_23_4, CCTableView.kNumberOfCellsInTableView)
	var_23_2:registerScriptHandler(var_23_5, CCTableView.kTableCellSizeAtIndex)
	var_23_2:reloadData()
	var_23_2:setScale(0.9)
	var_23_0:setPosition(display.cx, display.cy - 160 * Adapter.MinScale)
	arg_23_0:addChild(var_23_0)

	return var_23_2
end

function var_0_2.createHeader(arg_28_0)
	local var_28_0 = {}
	local var_28_1 = {}

	for iter_28_0, iter_28_1 in pairs(arg_28_0.oldGroup) do
		if iter_28_1 and iter_28_1.heroId ~= 0 then
			local var_28_2 = CCNode:create()
			local var_28_3 = {
				isHero = true,
				type = ItemType.eHero,
				itemId = iter_28_1.heroId,
				level = iter_28_1.level
			}
			local var_28_4 = figure.createHeader(var_28_3)

			var_28_2:addChild(var_28_4)
			var_28_4:setScale(Adapter.MinScale)

			var_28_4.number = var_28_4.levelNode.numLabel
			var_28_1[iter_28_0] = var_28_4

			local var_28_5 = CCSprite:create("ui/battle/battle_007.png")

			var_28_5:setPosition(Adapter.MinPos(0, -48))
			var_28_5:setScaleX(Adapter.MinScale)
			var_28_5:setScaleY(Adapter.MinScale)
			var_28_2:addChild(var_28_5)

			local var_28_6 = CCSprite:create("ui/battle/battle_008.png")
			local var_28_7 = CCProgressTimer:create(var_28_6)

			var_28_7:setType(kCCProgressTimerTypeBar)
			var_28_7:setMidpoint(CCPoint(0, 0))
			var_28_7:setBarChangeRate(CCPoint(1, 0))
			var_28_7:setPercentage(iter_28_1.curExp / iter_28_1.levelUpExp * 100)
			var_28_7:setPosition(Adapter.MinPos(0, -48))
			var_28_7:setScaleX(Adapter.MinScale)
			var_28_7:setScaleY(Adapter.MinScale)
			var_28_2:addChild(var_28_7)

			var_28_7.info = iter_28_1
			var_28_0[iter_28_0] = var_28_7

			local var_28_8 = CCLabelTTF:create(BaseHeros[iter_28_1.heroId].name, _FONT_DEFAULT, Adapter.FontSize(20))

			var_28_2:addChild(var_28_8)
			var_28_8:setColor(getQualityColor(BaseHeros[iter_28_1.heroId].quality))
			var_28_8:setPosition(Adapter.MinPos(0, -68))

			local var_28_9 = CCLabelTTF:create(string.lf("经验+%s", 0), _FONT_DEFAULT, Adapter.FontSize(15))

			var_28_9:setColor(ccc3(255, 255, 255))
			var_28_2:addChild(var_28_9)
			var_28_9:setPosition(Adapter.MinPos(0, -90))

			var_28_7.label = var_28_9

			local var_28_10 = 0
			local var_28_11 = 120
			local var_28_12, var_28_13 = math.modf(#arg_28_0.oldGroup / 2)

			if var_28_13 == 0 then
				if iter_28_0 <= var_28_12 then
					var_28_10 = -var_28_11 / 2 - (iter_28_0 - 1) * var_28_11
				else
					var_28_10 = var_28_11 / 2 + (iter_28_0 - var_28_12 - 1) * var_28_11
				end
			else
				local var_28_14 = var_28_12 + 1

				if iter_28_0 < var_28_14 then
					var_28_10 = -iter_28_0 * var_28_11
				else
					var_28_10 = (iter_28_0 - var_28_14) * var_28_11
				end
			end

			var_28_2:setPosition(var_28_10 * Adapter.MinScale + display.cx, display.cy + 10 * Adapter.MinScale)
			arg_28_0:addChild(var_28_2)
			var_28_2:setScale(0.9)
		end
	end

	return var_28_0, var_28_1
end

function var_0_2.createPlayerExp(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = CCNode:create()
	local var_29_1 = display.newSprite(getItemIconPath(ItemType.eEXP, nil))

	var_29_1:setPosition(Adapter.MinPos(-247, 393))
	var_29_1:setScale(Adapter.MinScale)
	var_29_0:addChild(var_29_1)

	local var_29_2 = CCSprite:create("ui/battle/battle_028.png")

	var_29_2:setPosition(Adapter.MinPos(-90, 393))
	var_29_2:setScaleX(1.5 * Adapter.MinScale)
	var_29_2:setScaleY(Adapter.MinScale)
	var_29_0:addChild(var_29_2)

	local var_29_3 = CCSprite:create("ui/battle/battle_027.png")
	local var_29_4 = CCProgressTimer:create(var_29_3)

	var_29_4:setType(kCCProgressTimerTypeBar)
	var_29_4:setMidpoint(CCPoint(0, 0))
	var_29_4:setBarChangeRate(CCPoint(1, 0))
	var_29_4:setPercentage(Player.curExp / Player.levelUpExp * 100)
	var_29_4:setPosition(Adapter.MinPos(-90, 393))
	var_29_4:setScaleX(1.5 * Adapter.MinScale)
	var_29_4:setScaleY(Adapter.MinScale)
	var_29_0:addChild(var_29_4)

	arg_29_0.playerExp = var_29_4

	local var_29_5 = ui.newTTFLabel({
		text = string.lf("%s级", Player.level),
		size = Adapter.FontSize(28),
		x = 50 * Adapter.MinScale,
		y = 395 * Adapter.MinScale,
		color = ccc3(255, 255, 255)
	})

	var_29_0:addChild(var_29_5)

	arg_29_0.playerLevel = var_29_5

	local var_29_6 = display.newSprite(getItemIconPath(ItemType.eCoin, nil))

	var_29_6:setPosition(150 * Adapter.MinScale, 395 * Adapter.MinScale)
	var_29_6:setScale(Adapter.MinScale)
	var_29_0:addChild(var_29_6)

	local var_29_7 = ui.newTTFLabel({
		text = "+" .. arg_29_1,
		size = Adapter.FontSize(20),
		color = ccc3(255, 255, 255)
	})

	var_29_7:setPosition(165 * Adapter.MinScale, 395 * Adapter.MinScale)
	var_29_7:setAnchorPoint(CCPoint(0, 0.5))

	arg_29_0.playerExp.labelIgnot = var_29_7

	var_29_0:addChild(var_29_7)

	local var_29_8 = display.newSprite(getItemIconPath(ItemType.eEXP, nil))

	var_29_8:setPosition(275 * Adapter.MinScale, 395 * Adapter.MinScale)
	var_29_8:setScale(Adapter.MinScale)
	var_29_0:addChild(var_29_8)

	local var_29_9 = ui.newTTFLabel({
		text = "+" .. arg_29_3,
		size = Adapter.FontSize(20)
	})

	var_29_9:setPosition(297 * Adapter.MinScale, 395 * Adapter.MinScale)
	var_29_9:setAnchorPoint(ccp(0, 0.5))
	var_29_0:addChild(var_29_9)

	arg_29_0.playerExp.labelExp = var_29_9

	var_29_0:setPosition(display.cx, display.cy - 315 * Adapter.MinScale)
	arg_29_0:addChild(var_29_0)
end

return var_0_2
