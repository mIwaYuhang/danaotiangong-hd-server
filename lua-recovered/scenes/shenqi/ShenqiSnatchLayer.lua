require("scenes.battle.BattleOperator")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = require("scenes.ToolLayer")
local var_0_2 = class("ShenqiSnatchLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create(ccc4(10, 10, 10, 180)))
end)

function var_0_2.ctor(arg_2_0, arg_2_1)
	arg_2_0.params = clone(arg_2_1)
	arg_2_0.shenQiScene = arg_2_1.shenQiScene
	arg_2_0.remainRobTime = arg_2_0.params.remainRobTime
	arg_2_0.totalRobTime = arg_2_0.params.totalRobTime
	arg_2_0.recoverTime = arg_2_0.params.recoverTime

	local function var_2_0(arg_3_0, arg_3_1, arg_3_2)
		return true
	end

	arg_2_0:addTouchEventListener(var_2_0, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.bgSprite = display.newSprite("ui/shenqi/sq_042.png")

	arg_2_0.bgSprite:setScale(Adapter.MinScale)
	arg_2_0.bgSprite:setAnchorPoint(CCPoint(0.5, 0.5))
	arg_2_0.bgSprite:setPosition(display.width / 2, display.height / 2)
	arg_2_0:addChild(arg_2_0.bgSprite)

	arg_2_0.bgSize = arg_2_0.bgSprite:getContentSize()
	arg_2_0.playerCellNodes = {}
	arg_2_0.playerDataList = {}
	arg_2_0.positionList = {
		CCPoint(arg_2_0.bgSize.width / 2 - 190, 355),
		CCPoint(arg_2_0.bgSize.width / 2 + 190, 355),
		CCPoint(arg_2_0.bgSize.width / 2 - 190, 245),
		CCPoint(arg_2_0.bgSize.width / 2 + 190, 245),
		CCPoint(arg_2_0.bgSize.width / 2 - 190, 135),
		(CCPoint(arg_2_0.bgSize.width / 2 + 190, 135))
	}

	local var_2_1 = ui.newControlButton({
		normalImage = "ui/common/common_110.png",
		titleImage = "uilocal/shenqi/shenqi_text_009.png",
		clickAction = function(arg_4_0, arg_4_1)
			arg_2_0.getBeRobInfoRequest:request(arg_2_0.params.fragmentID)
		end,
		position = CCPoint(660, 40)
	})

	arg_2_0.bgSprite:addChild(var_2_1)

	local var_2_2 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		text = string.lf("关闭"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		position = CCPoint(460, 40),
		clickAction = function()
			arg_2_0:removeFromParentAndCleanup(true)
			GuideLayer:removeOneGuideLayer(TaskEntryType.eShenQi)
		end
	})

	arg_2_0.bgSprite:addChild(var_2_2)
	arg_2_0:initRequests()
	arg_2_0.getBeRobInfoRequest:request(arg_2_0.params.fragmentID)

	if arg_2_0.robLabel then
		arg_2_0.robLabel:setString(string.lf("抢夺次数:#FFFF00%s/%s", arg_2_0.remainRobTime, arg_2_0.totalRobTime))
	else
		arg_2_0.robLabel = var_0_0.newLabel({
			text = string.lf("抢夺次数:#FFFF00%s/%s", arg_2_0.remainRobTime, arg_2_0.totalRobTime),
			color = ccc3(0, 255, 0)
		})

		arg_2_0.robLabel:setAnchorPoint(ccp(0.5, 0.5))
		arg_2_0.robLabel:setPosition(102, 40)
		arg_2_0.bgSprite:addChild(arg_2_0.robLabel)
	end

	local var_2_3, var_2_4, var_2_5, var_2_6 = getDateFromSeconds(arg_2_0.recoverTime)
	local var_2_7 = string.format("%02d:%02d", var_2_5, var_2_6)

	if arg_2_0.recoverTimeLabel then
		arg_2_0.recoverTimeLabel:setString(string.lf("恢复时间:%s", var_2_7))
	else
		arg_2_0.recoverTimeLabel = var_0_0.newLabel({
			text = string.lf("恢复时间:%s", var_2_7),
			color = ccc3(0, 255, 0)
		})

		arg_2_0.recoverTimeLabel:setAnchorPoint(ccp(0.5, 0.5))
		arg_2_0.recoverTimeLabel:setPosition(260, 40)
		arg_2_0.bgSprite:addChild(arg_2_0.recoverTimeLabel)
	end

	arg_2_0:showRecoverTime()

	if Player.currentMissionStageID == 2 then
		GuideLayer:removeOneGuideLayer(TaskEntryType.eShenQi)
	end
end

function var_0_2.showRecoverTime(arg_6_0)
	if arg_6_0.remainRobTime == arg_6_0.totalRobTime then
		arg_6_0.recoverTime = 0
	end

	local var_6_0 = arg_6_0.recoverTime
	local var_6_1 = 0.5
	local var_6_2 = CCArray:create()

	var_6_2:addObject(CCCallFunc:create(function()
		var_6_0 = var_6_0 - var_6_1

		if var_6_0 > 0 then
			arg_6_0.recoverTime = var_6_0

			local var_7_0, var_7_1, var_7_2, var_7_3 = getDateFromSeconds(arg_6_0.recoverTime)
			local var_7_4 = string.format("%02d:%02d", var_7_2, var_7_3)

			arg_6_0.recoverTimeLabel:setString(string.lf("恢复时间:%s", var_7_4))
			arg_6_0.recoverTimeLabel:setVisible(true)
		elseif arg_6_0.remainRobTime < arg_6_0.totalRobTime then
			arg_6_0.remainRobTime = arg_6_0.remainRobTime + 1

			arg_6_0.robLabel:setString(string.lf("抢夺次数:#FFFF00%s/%s", arg_6_0.remainRobTime, arg_6_0.totalRobTime))

			if arg_6_0.remainRobTime < arg_6_0.totalRobTime then
				arg_6_0.recoverTime = 900
				var_6_0 = arg_6_0.recoverTime
			else
				arg_6_0.bgSprite:stopAllActions()
				arg_6_0.recoverTimeLabel:setVisible(false)
			end
		else
			arg_6_0.bgSprite:stopAllActions()
			arg_6_0.recoverTimeLabel:setVisible(false)
		end
	end))
	var_6_2:addObject(CCDelayTime:create(var_6_1))
	arg_6_0.bgSprite:runAction(CCRepeatForever:create(CCSequence:create(var_6_2)))
end

function var_0_2.initRequests(arg_8_0)
	local function var_8_0()
		local var_9_0 = arg_8_0.getBeRobInfoRequest.restable

		arg_8_0.playerDataList = var_9_0

		arg_8_0:reloadPlayersInfo()
	end

	arg_8_0.getBeRobInfoRequest = GetBeRobInfoRequest:new()

	arg_8_0.getBeRobInfoRequest:setResponseNormalHandler(var_8_0)
end

function var_0_2.updateRestoreTime(arg_10_0)
	return
end

function var_0_2.reloadPlayersInfo(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.playerCellNodes) do
		iter_11_1:removeFromParentAndCleanup(true)
	end

	arg_11_0.playerCellNodes = {}

	for iter_11_2 = 1, table.nums(arg_11_0.playerDataList) do
		local var_11_0 = arg_11_0.playerDataList[iter_11_2]
		local var_11_1 = arg_11_0.positionList[iter_11_2]
		local var_11_2 = display.newSprite(iter_11_2 % 2 == 1 and "ui/shenqi/sq_040.png" or "ui/shenqi/sq_041.png", var_11_1.x, var_11_1.y)

		arg_11_0.bgSprite:addChild(var_11_2)

		arg_11_0.playerCellNodes[iter_11_2] = var_11_2

		local var_11_3 = var_11_2:getContentSize()
		local var_11_4 = figure.createHeader({
			type = ItemType.eHero,
			itemId = var_11_0.avatarID
		})

		var_11_4:setPosition(CCPoint(50, var_11_3.height / 2))
		var_11_2:addChild(var_11_4)
		addLabelWithColorSize(var_11_2, string.lf("玩家: %s", var_11_0.name), ccc3(239, 203, 139), 20, ccp(0, 0.5), CCPoint(100, var_11_3.height - 20))
		addLabelWithColorSize(var_11_2, string.lf("等级: Lv%s", var_11_0.level), ccc3(239, 203, 139), 20, ccp(0, 0.5), CCPoint(100, var_11_3.height / 2))

		local var_11_5 = {
			"ui/shenqi/sq_037.png",
			"ui/shenqi/sq_038.png",
			"ui/shenqi/sq_039.png"
		}
		local var_11_6 = display.newSprite(var_11_5[var_11_0.type], 100, 20)

		var_11_6:setAnchorPoint(CCPoint(0, 0.5))
		var_11_2:addChild(var_11_6)

		local var_11_7 = ui.newControlButton({
			normalImage = "ui/common/common_018.png",
			text = string.lf("抢夺"),
			fontSize = ColorTable.eTitleButton_FontSize,
			textColor = ColorTable.eTitleButton_Normal,
			position = CCPoint(var_11_3.width - 60, var_11_3.height / 2),
			clickAction = function(arg_12_0, arg_12_1)
				function callback(arg_13_0, arg_13_1)
					game.enterShenqiScene()
				end

				if arg_11_0.remainRobTime < 1 then
					var_0_1.createDialog({
						show = var_0_1.eShowShenqiSnatch,
						callback = function(arg_14_0, arg_14_1)
							if arg_14_0 then
								arg_11_0.remainRobTime = arg_11_0.remainRobTime + 1

								BattleOperator:startBattle(eBattleType.ShenqiRobFragment, {
									fragmentId = arg_11_0.params.fragmentID,
									playerId = var_11_0.playerID,
									robType = var_11_0.type
								}, callback)
							end
						end
					}):show()
				else
					GuideLayer:stepDone(TaskEntryType.eShenQi, 4)
					BattleOperator:startBattle(eBattleType.ShenqiRobFragment, {
						fragmentId = arg_11_0.params.fragmentID,
						playerId = var_11_0.playerID,
						robType = var_11_0.type
					}, callback)
				end
			end
		})

		var_11_2:addChild(var_11_7)

		if iter_11_2 == 1 then
			GuideLayer:showGuideLayer(arg_11_0.shenQiScene, var_11_7, TaskEntryType.eShenQi, 4, nil, true)
		end
	end
end

return var_0_2
