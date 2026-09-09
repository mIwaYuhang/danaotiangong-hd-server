require("base.figure")
require("network.SlaveRequest")
require("scenes.battle.BattleOperator")

local var_0_0 = {
	tagForHouse3 = 3,
	tagForHouse2 = 2,
	tagForHouse4 = 4,
	tagForHouse1 = 1
}
local var_0_1 = {
	statusForIdle = 2,
	statusForSlave = 1,
	statusForMoney = 3,
	statusForLock = 4
}
local var_0_2 = {}
local var_0_3
local var_0_4 = 0
local var_0_5 = 0
local var_0_6 = class("SlaveScene", function()
	return display.newScene("SlaveScene")
end)

function var_0_6.ctor(arg_2_0, arg_2_1)
	var_0_3 = nil
	var_0_4 = 0
	var_0_5 = 0

	local var_2_0 = display.newSprite("ui/slave/slave_011.jpg")

	var_2_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_0:setPosition(CCPoint(display.cx, display.cy))
	var_2_0:setScale(Adapter.AutoScaleY)
	arg_2_0:addChild(var_2_0)

	arg_2_0.bgSize = CCSize(960, 640)

	local var_2_1 = CCSprite:create("ui/common/common_070.png"):getTextureRect().size
	local var_2_2 = ui.newControlButton({
		highlightedImage = "ui/common/common_070.png",
		normalImage = "ui/common/common_070.png",
		anchorPoint = CCPoint(1, 1),
		size = Adapter.MinSize(var_2_1.width, var_2_1.height),
		position = Adapter.AutoPos(arg_2_0.bgSize.width - 10, arg_2_0.bgSize.height - 5),
		clickAction = function()
			local var_3_0 = arg_2_0.darkHouseInfoRequest.restable
			local var_3_1 = false

			for iter_3_0, iter_3_1 in pairs(var_3_0.captureInfo.captures) do
				if iter_3_1.state == var_0_1.statusForIdle then
					var_3_1 = true

					break
				end
			end

			Player:setDarkHouse({
				Last = var_3_0.captureInfo.freeCaptureNumber,
				CanCapture = var_3_1
			})
			game.enterHomeScene({
				showSubLayer = ShowSubLayerType.ePKHome
			})
		end
	})

	arg_2_0:addChild(var_2_2)

	local var_2_3 = CCSprite:create("ui/common/common_127.png"):getTextureRect().size

	if Player.level >= GameFeaturesLevel[GameFeatures.eHeroTrain].level then
		local var_2_4 = ui.newControlButton({
			titleImage = "uilocal/slave/slave_text_007.png",
			normalImage = "ui/common/common_127.png",
			scaleX = 0.8 * Adapter.MinScale,
			scaleY = 0.8 * Adapter.MinScale,
			position = Adapter.AutoPos(800, 42),
			clickAction = function()
				game.enterTeamScene({})
			end
		})

		arg_2_0:addChild(var_2_4, 1)
	end

	if Player.level >= GameFeaturesLevel[GameFeatures.eQiShuHealth].level then
		local var_2_5 = ui.newControlButton({
			titleImage = "uilocal/slave/slave_text_008.png",
			normalImage = "ui/common/common_127.png",
			scaleX = 0.8 * Adapter.MinScale,
			scaleY = 0.8 * Adapter.MinScale,
			position = Adapter.AutoPos(900, 42),
			clickAction = function()
				game.enterTSCaveScene()
			end
		})

		arg_2_0:addChild(var_2_5, 1)
	end

	arg_2_0:initRequests()
	arg_2_0:showPlayerData()
	arg_2_0:showMyReport()
	arg_2_0.darkHouseInfoRequest:request()

	if arg_2_1 ~= nil and arg_2_1.showRescue ~= nil and arg_2_1.showRescue == true then
		local var_2_6 = require("scenes.slave.SlaveRescueLayer").new()

		arg_2_0:addChild(var_2_6, DefaultZOrder.ePopupLayer)
	end

	if Player:getCurrentTaskEntryType() == TaskEntryType.eEntryDarkhouseCapture and Player:getCurrentMissionStageID() == 2 then
		Player:setCurrentTaskStep(5)
	end
end

function var_0_6.refreshLayer(arg_6_0)
	var_0_2 = {}

	arg_6_0:showMyStatus()
	arg_6_0:showSlaveStatus()

	if var_0_3 and var_0_3.roleInfo and var_0_3.roleInfo.battlePower then
		arg_6_0.labelPower:setString(var_0_3.roleInfo.battlePower)
	end

	if var_0_3 and var_0_3.captureInfo then
		arg_6_0.remainCount:setString(string.lf("今天还可以免费抓捕#00FF00%s/%s#FFFF87次", var_0_3.captureInfo.freeCaptureNumber, var_0_3.captureInfo.totolFreeCaptureNumber))
	end

	if var_0_3 and var_0_3.battleReport and var_0_3.battleReport.Content then
		local var_6_0 = string.format("#00FF00%s: #FFFFFF%s", getFormatCountDownTime(var_0_3.battleReport.Times), getFullLogContent(var_0_3.battleReport.Content, var_0_3.battleReport.Type))

		arg_6_0.labelReport:setString(var_6_0)
	end

	if var_0_4 > 0 or var_0_5 > 0 then
		showFlashText(arg_6_0, string.lf("阅历 +%s，培养丹 +%s", var_0_4, var_0_5), ccc3(0, 255, 0), Adapter.AutoPos(arg_6_0.bgSize.width / 2, arg_6_0.bgSize.height / 2 + 100))

		var_0_4 = 0
		var_0_5 = 0
	end
end

function var_0_6.initRequests(arg_7_0)
	local function var_7_0()
		var_0_3 = arg_7_0.darkHouseInfoRequest.restable

		arg_7_0:refreshLayer()

		local var_8_0 = false

		for iter_8_0, iter_8_1 in pairs(var_0_3.captureInfo.captures) do
			if iter_8_1.state == var_0_1.statusForIdle then
				var_8_0 = true

				break
			end
		end

		Player:setDarkHouse({
			Last = var_0_3.captureInfo.freeCaptureNumber,
			CanCapture = var_8_0
		})
	end

	arg_7_0.darkHouseInfoRequest = DarkHouseInfoRequest:new()

	arg_7_0.darkHouseInfoRequest:setResponseNormalHandler(var_7_0)

	local function var_7_1()
		arg_7_0.darkHouseInfoRequest:request()
	end

	arg_7_0.driveAwayRequest = SlaveDriveRequest:new()

	arg_7_0.driveAwayRequest:setResponseNormalHandler(var_7_1)

	local function var_7_2()
		local var_10_0 = arg_7_0.gainPartRequest.restable.Reward

		for iter_10_0, iter_10_1 in pairs(var_10_0) do
			if iter_10_1.Type == ItemType.eKnowledge then
				var_0_4 = iter_10_1.Count
			elseif iter_10_1.Type == ItemType.eTrainPill then
				var_0_5 = iter_10_1.Count
			end
		end

		arg_7_0.darkHouseInfoRequest:request()
	end

	arg_7_0.gainPartRequest = SlaveGainPartRequest:new()

	arg_7_0.gainPartRequest:setResponseNormalHandler(var_7_2)

	local function var_7_3()
		local var_11_0 = arg_7_0.bleedRequest.restable.Reward

		for iter_11_0, iter_11_1 in pairs(var_11_0) do
			if iter_11_1.Type == ItemType.eKnowledge then
				var_0_4 = iter_11_1.Count
			elseif iter_11_1.Type == ItemType.eTrainPill then
				var_0_5 = iter_11_1.Count
			end
		end

		arg_7_0.darkHouseInfoRequest:request()
	end

	arg_7_0.bleedRequest = SlaveBleedWhiteRequest:new()

	arg_7_0.bleedRequest:setResponseNormalHandler(var_7_3)

	local function var_7_4()
		local var_12_0 = arg_7_0.getAllRequest.restable.Reward

		for iter_12_0, iter_12_1 in pairs(var_12_0) do
			if iter_12_1.Type == ItemType.eKnowledge then
				var_0_4 = iter_12_1.Count
			elseif iter_12_1.Type == ItemType.eTrainPill then
				var_0_5 = iter_12_1.Count
			end
		end

		arg_7_0.darkHouseInfoRequest:request()
	end

	arg_7_0.getAllRequest = SlaveGetAllRequest:new()

	arg_7_0.getAllRequest:setResponseNormalHandler(var_7_4)
end

function var_0_6.onEnter(arg_13_0)
	arg_13_0:addSchedule()
	GuideLayer:showMissionReward(arg_13_0, TaskType.eTaskTeaching, TaskEntryType.eEntryDarkhouseCapture, 1)
end

function var_0_6.onExit(arg_14_0)
	arg_14_0:removeSchedule()
end

function var_0_6.showPlayerData(arg_15_0)
	local var_15_0 = display.newSprite("ui/common/common_067.png")
	local var_15_1 = var_15_0:getContentSize()

	var_15_0:setAnchorPoint(CCPoint(0, 0))
	var_15_0:setPosition(Adapter.AutoPos(arg_15_0.bgSize.width * 0.08, arg_15_0.bgSize.height * 0.9))
	var_15_0:setScale(Adapter.MinScale)
	arg_15_0:addChild(var_15_0)

	arg_15_0.labelPower = addLabelWithColorSize(var_15_0, "", ccc3(0, 225, 0), 20, CCPoint(0, 0.5), CCPoint(100, var_15_1.height / 2))

	if var_0_3 then
		arg_15_0.labelPower:setString(var_0_3.roleInfo.battlePower)
	end

	local var_15_2 = createPlayerAttrNode({
		ItemType.eGold,
		ItemType.eKnowledge
	})

	var_15_2:setPosition(Adapter.AutoPos(arg_15_0.bgSize.width * 0.375, arg_15_0.bgSize.height * 0.9))
	var_15_2:setScale(Adapter.MinScale)
	arg_15_0:addChild(var_15_2)
end

function var_0_6.showMyReport(arg_16_0)
	local var_16_0 = display.newSprite("ui/slave/slave_006.png")

	var_16_0:setAnchorPoint(CCPoint(0.5, 0))
	var_16_0:setPosition(Adapter.AutoPos(arg_16_0.bgSize.width / 2, 0))
	var_16_0:setScale(Adapter.MinScale)
	arg_16_0:addChild(var_16_0)

	local var_16_1 = var_16_0:getContentSize()
	local var_16_2 = ui.newControlButton({
		highlightedImage = "ui/slave/slave_007.png",
		normalImage = "ui/slave/slave_007.png",
		clickAction = function()
			local var_17_0 = require("scenes.slave.DlgReportLayer").new({
				type = DlgReportType.reportSlave
			})

			arg_16_0:addChild(var_17_0, DefaultZOrder.ePopupLayer)
		end,
		anchorPoint = CCPoint(0, 0.5),
		position = CCPoint(15, var_16_1.height / 2 + 5)
	})

	var_16_0:addChild(var_16_2)

	arg_16_0.labelReport = addLabelWithColorSize(var_16_0, "", ccc3(255, 255, 255), 20, CCPoint(0, 0.5), CCPoint(75, var_16_1.height / 2))

	if var_0_3 then
		arg_16_0.labelReport:setString(getFullLogContent(var_0_3.battleReport.Content, var_0_3.battleReport.Type))
	end
end

function var_0_6.showMyStatus(arg_18_0)
	if arg_18_0.myStatusBack == nil then
		arg_18_0.myStatusBack = display.newSprite("ui/slave/slave_003.png")

		arg_18_0.myStatusBack:setAnchorPoint(CCPoint(0.5, 1))
		arg_18_0.myStatusBack:setPosition(Adapter.AutoPos(arg_18_0.bgSize.width / 2, arg_18_0.bgSize.height * 0.86))
		arg_18_0.myStatusBack:setScale(Adapter.MinScale)
		arg_18_0:addChild(arg_18_0.myStatusBack)
	end

	arg_18_0.myStatusBack:removeAllChildrenWithCleanup(true)

	local var_18_0 = arg_18_0.myStatusBack:getContentSize()

	if var_0_3 == ni then
		return
	end

	local var_18_1 = ui.newControlButton({
		fontSize = 25,
		normalImage = "ui/common/common_019.png",
		text = string.lf("救好友"),
		anchorPoint = CCPoint(0.5, 1),
		position = CCPoint(382, var_18_0.height - 10),
		clickAction = function()
			GuideLayer:removeGuideLayer(arg_18_0, TaskEntryType.eEntryDarkhouseCapture, 5)
			GuideLayer:stepDone(TaskEntryType.eEntryDarkhouseCapture, 5)

			local var_19_0 = require("scenes.slave.SlaveRescueLayer").new()

			arg_18_0:addChild(var_19_0, DefaultZOrder.ePopupLayer)
		end
	})

	arg_18_0.myStatusBack:addChild(var_18_1)
	GuideLayer:showGuideLayer(arg_18_0, arg_18_0.myStatusBack, TaskEntryType.eEntryDarkhouseCapture, 5, nil, true)

	if var_0_3.beCapturedInfo.remainFreeTime <= 0 then
		local var_18_2 = display.newSprite("uilocal/slave/slave_text_001.png")

		var_18_2:setAnchorPoint(CCPoint(0, 1))
		var_18_2:setPosition(CCPoint(470, var_18_0.height - 5))
		arg_18_0.myStatusBack:addChild(var_18_2)

		return
	end

	local var_18_3 = ui.newControlButton({
		fontSize = 25,
		disabledImage = "ui/common/common_080.png",
		normalImage = "ui/common/common_055.png",
		size = CCSize(107, 52),
		text = string.lf("驱赶"),
		anchorPoint = CCPoint(0.5, 1),
		position = CCPoint(120, var_18_0.height - 10),
		clickAction = function()
			local function var_20_0()
				arg_18_0.driveAwayRequest:request()
			end

			ui.showMessageBox({
				text = string.lf("您确定要花费#FFFF00%s #FFFFFF元宝驱赶主人，恢复自由之身吗？", var_0_3.beCapturedInfo.driveCost),
				title1 = string.lf("驱赶"),
				title2 = string.lf("取消"),
				action1 = var_20_0
			})
		end
	})
	local var_18_4 = ui.newControlButton({
		fontSize = 25,
		disabledImage = "ui/common/common_080.png",
		normalImage = "ui/common/common_055.png",
		size = CCSize(107, 52),
		text = string.lf("反抗"),
		anchorPoint = CCPoint(0.5, 1),
		position = CCPoint(244, var_18_0.height - 10),
		clickAction = function()
			local function var_22_0(arg_23_0, arg_23_1)
				game.enterSlaveScene()
			end

			BattleOperator:startBattle(eBattleType.DarkHouseRevolt, {}, var_22_0)
		end
	})

	arg_18_0.myStatusBack:addChild(var_18_3)
	arg_18_0.myStatusBack:addChild(var_18_4)

	if var_0_3.beCapturedInfo.isUseProp == 1 then
		local var_18_5 = createMarkLabel({
			size = 18,
			text = string.lf("超级抓捕")
		})

		var_18_5:setAnchorPoint(CCPoint(0, 1))
		var_18_5:setPosition(CCPoint(2, var_18_0.height - 2))
		arg_18_0.myStatusBack:addChild(var_18_5)
		var_18_3:setEnabled(false)
		var_18_4:setEnabled(false)
	end

	local var_18_6 = display.newSprite("uilocal/slave/slave_text_002.png")

	var_18_6:setAnchorPoint(CCPoint(0, 1))
	var_18_6:setPosition(CCPoint(470, var_18_0.height))
	arg_18_0.myStatusBack:addChild(var_18_6)
	addLabelWithColorSize(arg_18_0.myStatusBack, string.lf("您被抓后，收益损失%s", var_0_3.beCapturedInfo.beCapturedEarningsLoss) .. "%", ccc3(255, 225, 135), 20, CCPoint(0, 0), CCPoint(100, 2))

	local var_18_7 = string.lf("【主人】%s(%s级)  战力：%s", var_0_3.beCapturedInfo.name, var_0_3.beCapturedInfo.level, var_0_3.beCapturedInfo.enemyBattlePower)

	addLabelWithColorSize(arg_18_0.myStatusBack, var_18_7, ccc3(255, 225, 135), 20, CCPoint(0, 0), CCPoint(475, 2))
	addLabelWithColorSize(arg_18_0.myStatusBack, string.lf("释放倒计时"), ccc3(238, 246, 49), 20, CCPoint(0, 0), CCPoint(770, 65))

	local var_18_8 = addLabelWithColorSize(arg_18_0.myStatusBack, "", ccc3(238, 246, 49), 20, CCPoint(0, 0), CCPoint(770, 37))
	local var_18_9 = {}

	var_18_9.time, var_18_9.timeLabel = var_0_3.beCapturedInfo.remainFreeTime, var_18_8

	function var_18_9.callback(arg_24_0)
		arg_24_0.time = arg_24_0.time - 1

		if arg_24_0.time <= 0 then
			arg_18_0:removeFromTimerTable(arg_24_0.callback)
			arg_18_0.darkHouseInfoRequest:request()
		else
			arg_24_0.timeLabel:setString(formatTime(arg_24_0.time))
		end
	end

	arg_18_0:addToTimerTable(var_18_9)
end

function var_0_6.showSlaveStatus(arg_25_0)
	if arg_25_0.slaveBack == nil then
		arg_25_0.slaveBack = display.newSprite("ui/slave/slave_004.png")

		arg_25_0.slaveBack:setAnchorPoint(CCPoint(0.5, 1))
		arg_25_0.slaveBack:setPosition(Adapter.AutoPos(arg_25_0.bgSize.width / 2, arg_25_0.bgSize.height * 0.69))
		arg_25_0.slaveBack:setScale(Adapter.MinScale)
		arg_25_0:addChild(arg_25_0.slaveBack)
	end

	arg_25_0.slaveBack:removeAllChildrenWithCleanup(true)

	local var_25_0 = arg_25_0.slaveBack:getContentSize()

	local function var_25_1(arg_26_0, arg_26_1, arg_26_2)
		local var_26_0 = display.newSprite("ui/slave/slave_012.png")
		local var_26_1 = var_26_0:getContentSize()

		var_26_0:setAnchorPoint(CCPoint(0.5, 0.5))
		var_26_0:setPosition(arg_26_2)
		arg_25_0.slaveBack:addChild(var_26_0)

		if arg_26_0 == var_0_0.tagForHouse1 then
			GuideLayer:stepDone(TaskEntryType.eEntryDarkhouseCapture, 2)
			GuideLayer:showGuideLayer(arg_25_0, var_26_0, TaskEntryType.eEntryDarkhouseCapture, 3, nil, true)
		end

		if arg_26_1 == nil then
			arg_25_0:addBlackHouseForLock(var_26_0, var_26_1, arg_26_0)
		elseif arg_26_1.state == var_0_1.statusForMoney then
			arg_25_0:addBlackHouseForMoney(var_26_0, var_26_1, arg_26_1)
		elseif arg_26_1.state == var_0_1.statusForIdle then
			arg_25_0:addBlackHouseForIdle(var_26_0, var_26_1, arg_26_1)
		elseif arg_26_1.state == var_0_1.statusForSlave then
			arg_25_0:addBlackHouseForSlave(var_26_0, var_26_1, arg_26_0, arg_26_1)
		end
	end

	if var_0_3.captureInfo.getTimes then
		arg_25_0.getSlaveTimes = var_0_3.captureInfo.getTimes
	end

	if var_0_3.captureInfo.bleedWhiteTimes then
		arg_25_0.bleedWhiteTimes = var_0_3.captureInfo.bleedWhiteTimes
	end

	var_25_1(var_0_0.tagForHouse1, var_0_3 ~= nil and var_0_3.captureInfo.captures[1] or nil, CCPoint(var_25_0.width / 2 - 345, var_25_0.height / 2))
	var_25_1(var_0_0.tagForHouse2, var_0_3 ~= nil and var_0_3.captureInfo.captures[2] or nil, CCPoint(var_25_0.width / 2 - 115, var_25_0.height / 2))
	var_25_1(var_0_0.tagForHouse3, var_0_3 ~= nil and var_0_3.captureInfo.captures[3] or nil, CCPoint(var_25_0.width / 2 + 115, var_25_0.height / 2))
	var_25_1(var_0_0.tagForHouse4, var_0_3 ~= nil and var_0_3.captureInfo.captures[4] or nil, CCPoint(var_25_0.width / 2 + 345, var_25_0.height / 2))

	local var_25_2 = var_0_3 == nil and 0 or var_0_3.captureInfo.freeCaptureNumber
	local var_25_3 = var_0_3 == nil and 0 or var_0_3.captureInfo.totolFreeCaptureNumber
	local var_25_4 = string.lf("今天还可以免费抓捕#00FF00%s/%s#FFFF87次", var_25_2, var_25_3)

	arg_25_0.remainCount = addLabelWithColorSize(arg_25_0.slaveBack, var_25_4, ccc3(255, 225, 135), 20, CCPoint(0.5, 0), CCPoint(var_25_0.width / 2, -30))
end

function var_0_6.addBlackHouseForSlave(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0 = display.newSprite("ui/slave/slave_005.png", arg_27_2.width / 2, arg_27_2.height - 35)

	var_27_0:setAnchorPoint(CCPoint(0.5, 1))
	arg_27_1:addChild(var_27_0)

	local var_27_1 = var_27_0:getContentSize()

	if arg_27_4.isUseProp == 1 then
		local var_27_2 = createMarkLabel({
			size = 18,
			text = string.lf("超级抓捕")
		})

		var_27_2:setAnchorPoint(CCPoint(0, 1))
		var_27_2:setPosition(CCPoint(0, var_27_1.height))
		var_27_0:addChild(var_27_2)
	end

	local var_27_3 = getItemHeaderImagePath(ItemType.eHero, arg_27_4.avatar ~= nil and arg_27_4.avatar ~= 0 and arg_27_4.avatar or 501)

	if var_27_3 ~= nil then
		local var_27_4 = display.newSprite(var_27_3, var_27_1.width / 2 + 5, 20)

		var_27_4:setAnchorPoint(CCPoint(0.5, 0))
		var_27_0:addChild(var_27_4)
	end

	local var_27_5 = display.newSprite("ui/slave/slave_008.png", var_27_1.width / 2, 15)

	var_27_5:setAnchorPoint(CCPoint(0.5, 0))
	var_27_0:addChild(var_27_5)
	addLabelWithColorSize(arg_27_1, string.lf("%s(%s级)", arg_27_4.name, arg_27_4.level), ccc3(238, 246, 49), 20, CCPoint(0.5, 1), CCPoint(arg_27_2.width / 2, 175))

	local var_27_6 = display.newSprite("icon/icon_yuelizhi.png", 110, 128)
	local var_27_7 = display.newSprite("icon/icon_yuelizhi.png", 110, 58)
	local var_27_8 = display.newSprite("icon/icon_peiyangdan.png", 110, 92)
	local var_27_9 = display.newSprite("icon/icon_peiyangdan.png", 110, 22)

	arg_27_1:addChild(var_27_6)
	arg_27_1:addChild(var_27_7)
	arg_27_1:addChild(var_27_8)
	arg_27_1:addChild(var_27_9)

	local var_27_10 = {}
	local var_27_11 = addLabelWithColorSize(arg_27_1, "", ccc3(238, 246, 49), 20, CCPoint(0.5, 1), CCPoint(arg_27_2.width / 2, arg_27_2.height - 10))
	local var_27_12 = addLabelWithColorSize(arg_27_1, arg_27_4.currentEarnings1, ccc3(255, 255, 255), 20, CCPoint(0, 0.5), CCPoint(130, 128))
	local var_27_13 = addLabelWithColorSize(arg_27_1, arg_27_4.currentEarnings2, ccc3(255, 255, 255), 20, CCPoint(0, 0.5), CCPoint(130, 92))

	addLabelWithColorSize(arg_27_1, arg_27_4.bleedWhiteEarnings1, ccc3(255, 255, 255), 20, CCPoint(0, 0.5), CCPoint(130, 58))
	addLabelWithColorSize(arg_27_1, arg_27_4.bleedWhiteEarnings2, ccc3(255, 255, 255), 20, CCPoint(0, 0.5), CCPoint(130, 22))

	local var_27_14 = 90 - (arg_27_4.level - 20) * 1

	if var_27_14 < 50 then
		var_27_14 = 50
	end

	var_27_10.item, var_27_10.time = arg_27_4, arg_27_4.remainFreeTime

	function var_27_10.callback(arg_28_0)
		arg_28_0.time = arg_28_0.time - 1

		if arg_28_0.item.level >= 25 then
			arg_28_0.item.currentEarnings1 = arg_28_0.item.currentEarnings1 + ((arg_28_0.item.level - 25) * 2 + 10) / 60
		elseif arg_28_0.item.level <= 15 then
			arg_28_0.item.currentEarnings1 = arg_28_0.item.currentEarnings1 + 0.016666666666666666
		else
			arg_28_0.item.currentEarnings1 = arg_28_0.item.currentEarnings1 + (arg_28_0.item.level - 15) / 60
		end

		if arg_28_0.time <= 0 then
			arg_27_0:removeFromTimerTable(arg_28_0.callback)
			arg_27_0.darkHouseInfoRequest:request()
		else
			var_27_11:setString(string.lf("%s后释放", formatTime(arg_28_0.time)))
			var_27_12:setString(math.ceil(arg_28_0.item.currentEarnings1))

			local var_28_0 = arg_28_0.item.bleedWhiteEarnings2 - math.ceil(arg_28_0.time / var_27_14)

			if var_28_0 > arg_28_0.item.currentEarnings2 then
				arg_28_0.item.currentEarnings2 = var_28_0

				var_27_13:setString(var_28_0)
			end
		end
	end

	arg_27_0:addToTimerTable(var_27_10)

	local var_27_15 = ui.newControlButton({
		normalImage = "ui/common/common_018.png",
		size = CCSize(90, 50),
		text = string.lf("收获"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		anchorPoint = CCPoint(0.5, 0),
		position = CCPoint(50, 85),
		clickAction = function()
			arg_27_0.gainPartRequest:request(arg_27_4.location)
		end
	})
	local var_27_16 = ui.newControlButton({
		normalImage = "ui/common/common_018.png",
		size = CCSize(90, 50),
		text = string.lf("榨干"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		anchorPoint = CCPoint(0.5, 0),
		position = CCPoint(50, 15),
		clickAction = function()
			local var_30_0 = math.floor((20 + arg_27_4.level * 0.4) * (var_27_10.time / 60 / 300))

			if var_30_0 < 10 then
				var_30_0 = 10
			end

			local var_30_1 = string.lf("您确定要花费#FFFF00%s#FFFFFF元宝榨干该俘虏吗？", var_30_0)

			local function var_30_2()
				if isMoneyEnough(MoneyType.eGold, var_30_0) == false then
					return
				end

				arg_27_0.bleedRequest:request(arg_27_4.location)
			end

			ui.showMessageBox({
				text = var_30_1,
				title1 = string.lf("榨干"),
				title2 = string.lf("取消"),
				action1 = var_30_2
			})
		end
	})

	arg_27_1:addChild(var_27_15)
	arg_27_1:addChild(var_27_16)

	if arg_27_0.getSlaveTimes ~= nil and arg_27_0.getSlaveTimes > 1 then
		local var_27_17 = createMarkLabel({
			y = 23,
			background = "ui/common/common_133.png",
			rotate = -31,
			size = 16,
			x = 28,
			text = string.lf("%d倍", arg_27_0.getSlaveTimes)
		})

		var_27_17:setPosition(CCPoint(20, var_27_15:getContentSize().height - 5))
		var_27_15:addChild(var_27_17)
	end

	if arg_27_0.bleedWhiteTimes ~= nil and arg_27_0.bleedWhiteTimes > 1 then
		local var_27_18 = createMarkLabel({
			y = 23,
			background = "ui/common/common_133.png",
			rotate = -31,
			size = 16,
			x = 28,
			text = string.lf("%d倍", arg_27_0.bleedWhiteTimes)
		})

		var_27_18:setPosition(CCPoint(20, var_27_16:getContentSize().height - 5))
		var_27_16:addChild(var_27_18)
	end
end

function var_0_6.addBlackHouseForMoney(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = ui.newControlButton({
		normalImage = "ui/activity/activity_009.png",
		anchorPoint = CCPoint(0.5, 1),
		position = CCPoint(arg_32_2.width / 2, arg_32_2.height - 40),
		clickAction = function()
			arg_32_0.getAllRequest:request(arg_32_3.location)
		end
	})

	arg_32_1:addChild(var_32_0)

	local var_32_1 = display.newSprite("icon/icon_yuelizhi.png", 80, 158)
	local var_32_2 = display.newSprite("icon/icon_peiyangdan.png", 80, 122)

	arg_32_1:addChild(var_32_1)
	arg_32_1:addChild(var_32_2)
	addLabelWithColorSize(arg_32_1, arg_32_3.currentEarnings1, ccc3(255, 255, 255), 20, CCPoint(0, 0.5), CCPoint(100, 158))
	addLabelWithColorSize(arg_32_1, arg_32_3.currentEarnings2, ccc3(255, 255, 255), 20, CCPoint(0, 0.5), CCPoint(100, 122))
	addLabelWithColorSize(arg_32_1, string.lf("点击宝箱领取收益"), ccc3(255, 225, 135), 20, CCPoint(0.5, 0), CCPoint(arg_32_2.width / 2, 20))
end

function var_0_6.addBlackHouseForIdle(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = ui.newControlButton({
		normalImage = "ui/slave/slave_005.png",
		anchorPoint = CCPoint(0.5, 1),
		position = CCPoint(arg_34_2.width / 2, arg_34_2.height - 40),
		clickAction = function()
			GuideLayer:stepDone(TaskEntryType.eEntryDarkhouseCapture, 3)

			if var_0_3.captureInfo.freeCaptureNumber == 0 then
				local var_35_0 = require("scenes.ToolLayer")

				var_35_0.createDialog({
					show = var_35_0.eShowSlaveCatch,
					callback = function(arg_36_0, arg_36_1)
						local var_36_0 = require("scenes.slave.SlaveCatchLayer").new({
							location = arg_34_3.location
						})

						arg_34_0:addChild(var_36_0, DefaultZOrder.ePopupLayer)
					end
				}):show({
					parent = arg_34_0
				})
			else
				local var_35_1 = require("scenes.slave.SlaveCatchLayer").new({
					location = arg_34_3.location
				})

				arg_34_0:addChild(var_35_1, DefaultZOrder.ePopupLayer)
			end
		end
	})

	arg_34_1:addChild(var_34_0)
	addLabelWithColorSize(arg_34_1, string.lf("点击牢笼去抓捕"), ccc3(255, 225, 135), 20, CCPoint(0.5, 0), CCPoint(arg_34_2.width / 2, 20))
end

function var_0_6.addBlackHouseForLock(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = ui.newControlButton({
		normalImage = "ui/slave/slave_005.png",
		titleImage = "ui/common/common_012.png",
		position = CCPoint(arg_37_2.width / 2, arg_37_2.height - 40),
		anchorPoint = CCPoint(0.5, 1)
	})

	arg_37_1:addChild(var_37_0)

	local var_37_1 = {
		GameFeaturesLevel[GameFeatures.eSlave1].level,
		GameFeaturesLevel[GameFeatures.eSlave2].level,
		GameFeaturesLevel[GameFeatures.eSlave3].level,
		GameFeaturesLevel[GameFeatures.eSlave4].level
	}
	local var_37_2 = {
		var_0_0.tagForHouse1,
		var_0_0.tagForHouse2,
		var_0_0.tagForHouse3,
		var_0_0.tagForHouse4
	}
	local var_37_3 = {}

	for iter_37_0, iter_37_1 in ipairs(var_37_2) do
		var_37_3[iter_37_1] = string.lf("等级%d级可解锁", var_37_1[iter_37_0])
	end

	addLabelWithColorSize(arg_37_1, var_37_3[arg_37_3], ccc3(255, 225, 135), 20, CCPoint(0.5, 0), CCPoint(arg_37_2.width / 2, 20))
end

function var_0_6.addSchedule(arg_38_0)
	if arg_38_0.scheduleHandle == nil then
		arg_38_0.scheduleHandle = require("framework.scheduler").scheduleGlobal(handler(arg_38_0, arg_38_0.scheduleCallback), 1)
	end
end

function var_0_6.removeSchedule(arg_39_0)
	if arg_39_0.scheduleHandle then
		require("framework.scheduler").unscheduleGlobal(arg_39_0.scheduleHandle)

		arg_39_0.scheduleHandle = nil
	end
end

function var_0_6.scheduleCallback(arg_40_0, arg_40_1)
	for iter_40_0, iter_40_1 in pairs(var_0_2) do
		if iter_40_1.callback then
			iter_40_1.callback(iter_40_1)
		end
	end
end

function var_0_6.addToTimerTable(arg_41_0, arg_41_1)
	if arg_41_1 == nil then
		return
	end

	table.insert(var_0_2, arg_41_1)
end

function var_0_6.removeFromTimerTable(arg_42_0, arg_42_1)
	for iter_42_0, iter_42_1 in pairs(var_0_2) do
		if iter_42_1.callback == arg_42_1 then
			table.remove(var_0_2, iter_42_0)

			break
		end
	end
end

return var_0_6
