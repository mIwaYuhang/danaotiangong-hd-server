require("base.figure")
require("network.WorldBossRequest")
require("scenes.team.OthersTeamHelper")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = require("framework.scheduler")
local var_0_2 = class("WorldBossHomeScene", function(arg_1_0)
	return require("scenes.worldboss.WorldBossBaseScene").new(arg_1_0)
end)

function var_0_2.ctor(arg_2_0, arg_2_1)
	Player:setWorldBossTip(0)

	arg_2_0.mPillarPos[1], arg_2_0.mPillarPos[2], arg_2_0.mPillarPos[3] = arg_2_0.mPillarPos[2], arg_2_0.mPillarPos[3], arg_2_0.mPillarPos[1]
	arg_2_0.mCDTimerBindFunctions = {}

	arg_2_0:setUI()

	if not arg_2_1 then
		arg_2_0:requestBaseInfo()
	else
		arg_2_0:onResponseBaseInfo(arg_2_1)

		if arg_2_1.enter == "rankList" then
			arg_2_1.enter = nil

			arg_2_0:onRankBtnClicked()
		end
	end

	arg_2_0:setTimer()
end

function var_0_2.onExit(arg_3_0)
	arg_3_0:killTimer()
end

function var_0_2.setUI(arg_4_0)
	local var_4_0 = arg_4_0.mContainer
	local var_4_1 = arg_4_0.mContainerSize
	local var_4_2 = arg_4_0:getImageSize("ui/task/task_005.png")

	var_4_2.width = var_4_2.width * 0.8
	var_4_2.height = var_4_2.height * 0.8

	local var_4_3 = ui.newControlButton({
		scaleX = 0.8,
		normalImage = "ui/task/task_005.png",
		scaleY = 0.8,
		position = ccp(var_4_1.width - var_4_2.width / 2, var_4_1.height - 62 - var_4_2.height / 2),
		clickAction = handler(arg_4_0, arg_4_0.onRankBtnClicked)
	})

	var_4_0:addChild(var_4_3)
	addLabelWithColorSize(var_4_3, string.lf("伤害排名"), ccc3(224, 211, 0), 22, ccp(0.5, 0.5), ccp(var_4_2.width / 2 - 3, var_4_2.height / 2 - 5))

	local var_4_4 = ui.newControlButton({
		scaleX = 0.8,
		normalImage = "ui/task/task_005.png",
		scaleY = 0.8,
		position = ccp(var_4_1.width - var_4_2.width / 2, var_4_1.height - 62 - var_4_2.height - var_4_2.height / 2),
		clickAction = handler(arg_4_0, arg_4_0.onGetRewardBtnClicked)
	})

	var_4_0:addChild(var_4_4)
	addLabelWithColorSize(var_4_4, string.lf("领取奖励"), ccc3(224, 211, 0), 22, ccp(0.5, 0.5), ccp(var_4_2.width / 2 - 3, var_4_2.height / 2 - 5))

	local var_4_5 = arg_4_0:getImageSize("ui/worldboss/worldboss_023.png")
	local var_4_6 = display.newSprite("ui/worldboss/worldboss_023.png", var_4_1.width / 2, 5)

	var_4_6:setAnchorPoint(ccp(0.5, 0))
	var_4_0:addChild(var_4_6)

	local var_4_7 = addLabelWithColorSize(var_4_6, string.lf("规则:四个妖王血量相差10%以上，低血量的会狂暴攻击宝箱，每损失一个宝箱，所有人将会减少额外的银币收入。尽量保持BOSS血量平衡并击杀，可以获得大量额外银币收入"), ccc3(238, 180, 34), 22, ccp(0.5, 1), ccp(var_4_5.width / 2, var_4_5.height - 10))

	var_4_7:setHorizontalAlignment(kCCTextAlignmentLeft)
	var_4_7:setDimensions(CCSizeMake(var_4_5.width - 20, var_4_5.height))

	arg_4_0.mBtnOrder = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/worldboss/worldboss_text_007.png",
		position = ccp(var_4_5.width / 2, 30),
		clickAction = handler(arg_4_0, arg_4_0.onOrderBtnClicked)
	})

	var_4_6:addChild(arg_4_0.mBtnOrder)
	arg_4_0.mBtnOrder:setVisible(false)

	arg_4_0.mBtnAlreadyOrdered = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/worldboss/worldboss_text_015.png",
		position = ccp(var_4_5.width / 2, 30),
		clickAction = handler(arg_4_0, arg_4_0.onOrderBtnClicked)
	})

	var_4_6:addChild(arg_4_0.mBtnAlreadyOrdered)
	arg_4_0.mBtnAlreadyOrdered:setVisible(false)

	arg_4_0.mBtnEnterBattle = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/worldboss/worldboss_text_012.png",
		position = ccp(var_4_5.width / 2, 30),
		clickAction = function()
			game.enterWorldBossBattleScene({
				vipLv = arg_4_0.mBaseInfo.orderVipLv or 0
			})
		end
	})

	var_4_6:addChild(arg_4_0.mBtnEnterBattle)
	arg_4_0.mBtnEnterBattle:setVisible(false)

	arg_4_0.mRemainTimeView = arg_4_0:createRemainTimeView()

	arg_4_0.mRemainTimeView:setPosition(20, var_4_1.height - 20)
	var_4_0:addChild(arg_4_0.mRemainTimeView)

	arg_4_0.mLastRankView = arg_4_0:createLastRankView()

	arg_4_0.mLastRankView:setPosition(20, var_4_1.height - 80)
	arg_4_0.mLastRankView:setVisible(false)
	var_4_0:addChild(arg_4_0.mLastRankView)
end

function var_0_2.show4Persons(arg_6_0, arg_6_1)
	if not tolua.isnull(arg_6_0.m4PersonsView) then
		arg_6_0.m4PersonsView:removeFromParentAndCleanup(true)
	end

	arg_6_0.m4PersonsView = arg_6_0:place4Persons(arg_6_1)
end

function var_0_2.place4Persons(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or {}

	local var_7_0 = display.newNode()
	local var_7_1 = {
		"ui/worldboss/worldboss_010.png",
		"ui/worldboss/worldboss_011.png",
		"ui/worldboss/worldboss_013.png",
		"ui/worldboss/worldboss_012.png"
	}
	local var_7_2 = "uilocal/worldboss/worldboss_text_004.png"
	local var_7_3 = {
		"uilocal/worldboss/worldboss_text_008.png",
		"uilocal/worldboss/worldboss_text_013.png",
		"uilocal/worldboss/worldboss_text_010.png",
		"uilocal/worldboss/worldboss_text_011.png"
	}

	for iter_7_0 = 1, 4 do
		if arg_7_1[iter_7_0] then
			local var_7_4 = arg_7_1[iter_7_0].rank
			local var_7_5 = figure.createHero({
				scale = 0.7,
				isViewQuality = false,
				platTable = false,
				figId = arg_7_1[iter_7_0].avatarID,
				equipId = getHeroGroupWeaponId(arg_7_1[iter_7_0].avatarID),
				pinjie = EquipPinjieType.eShengPin
			})

			var_7_5:setPosition(arg_7_0.mPillarPos[var_7_4].x, arg_7_0.mPillarPos[var_7_4].y + 10)
			var_7_0:addChild(var_7_5)

			local var_7_6 = display.newSprite(var_7_3[var_7_4])

			var_7_6:setAnchorPoint(ccp(0.5, 1))
			var_7_6:setPosition(arg_7_0.mPillarPos[var_7_4])
			var_7_0:addChild(var_7_6)
			addLabelWithColorSize(var_7_0, string.format("Lv%s#EEC900 %s", arg_7_1[iter_7_0].level, arg_7_1[iter_7_0].name), ccc3(128, 201, 160), 22, ccp(0.5, 0.5), ccp(arg_7_0.mPillarPos[iter_7_0].x, arg_7_0.mPillarPos[iter_7_0].y + 245))
		else
			local var_7_7 = display.newSprite(var_7_1[iter_7_0])

			var_7_7:setAnchorPoint(ccp(0.5, 0))
			var_7_7:setPosition(arg_7_0.mPillarPos[iter_7_0])
			var_7_0:addChild(var_7_7)

			local var_7_8 = display.newSprite(var_7_2)

			var_7_8:setAnchorPoint(ccp(0.5, 1))
			var_7_8:setPosition(arg_7_0.mPillarPos[iter_7_0])
			var_7_0:addChild(var_7_8)
		end
	end

	arg_7_0.mContainer:addChild(var_7_0)

	return var_7_0
end

function var_0_2.createRemainTimeView(arg_8_0)
	local var_8_0 = display.newNode()
	local var_8_1 = addLabelWithColorSize(var_8_0, "", ccc3(155, 205, 155), 22, ccp(0, 0.5), ccp(0, 0))
	local var_8_2 = addLabelWithColorSize(var_8_0, "", ccc3(205, 51, 51), 22, ccp(0, 0.5), ccp(0, -25))
	local var_8_3 = 100

	function var_8_0.setRemainTime(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		var_8_3 = arg_9_1 or -1

		if arg_9_2 > 0 then
			var_8_1:setString(string.lf("正在击杀妖王，结束时间:"))
		else
			var_8_1:setString(string.lf("开始倒计时:"))
		end

		var_8_2:setString(formatTime(var_8_3))

		local function var_9_0()
			if var_8_3 > 0 then
				var_8_3 = var_8_3 - 1

				var_8_2:setString(formatTime(var_8_3))
			else
				arg_8_0:dettachCDTimer(var_8_2)

				if arg_9_2 == 1 then
					arg_8_0:requestBaseInfo()
				else
					var_8_2:setString(string.lf("已开始"))

					if arg_9_3 then
						arg_9_3()
					end
				end
			end
		end

		arg_8_0:dettachCDTimer(var_8_2)
		arg_8_0:attachCDTimer(var_8_2, var_9_0)
	end

	function var_8_0.getRemainTime()
		return var_8_3
	end

	return var_8_0
end

function var_0_2.createLastRankView(arg_12_0)
	local var_12_0 = display.newNode()
	local var_12_1 = addLabelWithColorSize(var_12_0, string.lf("上轮伤害排名:"), ccc3(155, 205, 155), 22, ccp(0, 0.5), ccp(0, 0))
	local var_12_2 = addLabelWithColorSize(var_12_0, "", ccc3(205, 51, 51), 22, ccp(0, 0.5), ccp(0, -25))

	function var_12_0.setLastRank(arg_13_0, arg_13_1)
		if (arg_13_1 or 0) < 1 then
			var_12_2:setString(string.lf("无"))
		else
			var_12_2:setString(tostring(arg_13_1))
		end
	end

	var_12_0:setLastRank(0)

	return var_12_0
end

function var_0_2.formatItemValue(arg_14_0, arg_14_1)
	arg_14_1 = math.floor(arg_14_1)

	if arg_14_1 > 9999 then
		arg_14_1 = math.floor(arg_14_1 / 10000)

		return string.lf("%s万", arg_14_1)
	end

	return tostring(arg_14_1)
end

function var_0_2.setTimer(arg_15_0)
	if not arg_15_0.mCDTimerHandler then
		arg_15_0.mCDTimerHandler = var_0_1.scheduleGlobal(handler(arg_15_0, arg_15_0.onCDTimer), 1)
	end
end

function var_0_2.killTimer(arg_16_0)
	if arg_16_0.mCDTimerHandler then
		var_0_1.unscheduleGlobal(arg_16_0.mCDTimerHandler)

		arg_16_0.mCDTimerHandler = nil
	end
end

function var_0_2.onCDTimer(arg_17_0)
	table.foreach(arg_17_0.mCDTimerBindFunctions or {}, function(arg_18_0, arg_18_1)
		arg_18_1()
	end)
end

function var_0_2.attachCDTimer(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0.mCDTimerBindFunctions[arg_19_1] = arg_19_2
end

function var_0_2.dettachCDTimer(arg_20_0, arg_20_1)
	arg_20_0.mCDTimerBindFunctions[arg_20_1] = nil
end

function var_0_2.enableBottomButtons(arg_21_0)
	if arg_21_0.mBaseInfo.isInActivity == 0 then
		if arg_21_0.mBaseInfo.isOrder == 1 then
			arg_21_0.mBtnAlreadyOrdered:setVisible(true)
			arg_21_0.mBtnOrder:setVisible(false)
		else
			arg_21_0.mBtnAlreadyOrdered:setVisible(false)
			arg_21_0.mBtnOrder:setVisible(true)
		end

		arg_21_0.mBtnEnterBattle:setVisible(false)
	else
		arg_21_0.mBtnOrder:setVisible(false)
		arg_21_0.mBtnAlreadyOrdered:setVisible(false)
		arg_21_0.mBtnEnterBattle:setVisible(true)
	end
end

function var_0_2.onRankBtnClicked(arg_22_0)
	local var_22_0 = require("scenes.worldboss.WorldBossDPSRankLayer").new({
		from4OtherTeam = OthersTeamHelper.eDataFromWorldBossHome,
		param4OtherTeam = arg_22_0.mBaseInfo
	})

	arg_22_0:addChild(var_22_0)
end

function var_0_2.onGetRewardBtnClicked(arg_23_0)
	if arg_23_0.mBaseInfo.isCanGetReward == 0 then
		return showFlashNotice(string.lf("暂时没有可领取的奖励"))
	end

	local var_23_0 = require("scenes.worldboss.WorldBossRewardLayer").new()

	arg_23_0:addChild(var_23_0)
end

function var_0_2.onOrderBtnClicked(arg_24_0)
	if arg_24_0.mBaseInfo.isOrder == 1 then
		showFlashNotice(string.lf("上仙，您已预约成功，不可重复预约"))
	elseif Player.vipLevel < arg_24_0.mBaseInfo.orderVipLv then
		showFlashNotice(string.lf("Vip%d及以上才能使用该功能", arg_24_0.mBaseInfo.orderVipLv or 0))
	elseif arg_24_0.mRemainTimeView:getRemainTime() > 0 and arg_24_0.mRemainTimeView:getRemainTime() < 60 then
		showFlashNotice(string.lf("战斗将在一分钟内打响，不可预约"))
	else
		ui.showMessageBox({
			text = string.lf("预约后将在开战时自动战斗，是否使用%d元宝预约?", arg_24_0.mBaseInfo.orderCost),
			title1 = string.lf("确定"),
			action1 = function()
				arg_24_0:requestOrder()
			end,
			title2 = string.lf("取消")
		})
	end
end

function var_0_2.requestBaseInfo(arg_26_0)
	if not arg_26_0.mBaseInfoRequest then
		arg_26_0.mBaseInfoRequest = WorldBossBaseInfoRequest:new()

		local function var_26_0()
			arg_26_0:onResponseBaseInfo(arg_26_0.mBaseInfoRequest.restable)
		end

		arg_26_0.mBaseInfoRequest:setResponseNormalHandler(var_26_0)
	end

	arg_26_0.mBaseInfoRequest:request()
end

function var_0_2.onResponseBaseInfo(arg_28_0, arg_28_1)
	arg_28_0.mBaseInfo = arg_28_1

	if arg_28_1.isInActivity == 1 then
		arg_28_0:show4Persons({})
	else
		table.sort(arg_28_1.challengeRanks, function(arg_29_0, arg_29_1)
			return arg_29_0.rank < arg_29_1.rank
		end)
		arg_28_0:show4Persons(arg_28_1.challengeRanks)
	end

	arg_28_0:enableBottomButtons()

	local function var_28_0()
		if arg_28_0.mBaseInfo.isInActivity == 0 then
			arg_28_0.mBaseInfo.isInActivity = 1

			arg_28_0:enableBottomButtons()
			arg_28_0.mLastRankView:setVisible(false)
			arg_28_0:show4Persons({})
		end
	end

	if arg_28_1.remainTime > 0 then
		arg_28_0.mRemainTimeView:setRemainTime(arg_28_1.remainTime, arg_28_1.isInActivity, var_28_0)
	end

	if arg_28_0.mBaseInfo.isInActivity == 0 then
		arg_28_0.mLastRankView:setVisible(true)
		arg_28_0.mLastRankView:setLastRank(arg_28_1.lastRank)
	else
		arg_28_0.mLastRankView:setVisible(false)
	end
end

function var_0_2.requestOrder(arg_31_0)
	if not arg_31_0.mOrderRequest then
		arg_31_0.mOrderRequest = WorldBossOrderRequest:new()

		local function var_31_0()
			arg_31_0.mBaseInfo.isOrder = 1

			showFlashNotice(string.lf("预约成功，比赛开始后将自动战斗"))
			arg_31_0:enableBottomButtons()
		end

		arg_31_0.mOrderRequest:setResponseNormalHandler(var_31_0)
	end

	arg_31_0.mOrderRequest:request()
end

function var_0_2.requestGetReward(arg_33_0)
	if not arg_33_0.mGetRewardRequest then
		arg_33_0.mGetRewardRequest = WorldBossGetRewardRequest:new()

		local function var_33_0()
			arg_33_0:onResponseGetReward(arg_33_0.mGetRewardRequest.restable.rankReward[1], arg_33_0.mGetRewardRequest.restable.hestReward[1])
		end

		arg_33_0.mGetRewardRequest:setResponseNormalHandler(var_33_0)
	end

	arg_33_0:onResponseGetReward({
		Count = 1000,
		Type = 1
	}, {
		Count = 998,
		Type = 1
	})
end

function var_0_2.onResponseGetReward(arg_35_0, ...)
	var_0_0.createToast({
		show = var_0_0.eShowReward,
		rewards = {
			...
		}
	}):show({
		align = display.CENTER,
		x = display.cx,
		y = display.cy
	})
end

return var_0_2
