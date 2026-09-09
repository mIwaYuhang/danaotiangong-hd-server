require("base.functions")
require("network.DailySalaryRequest")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = require("base.cache")
local var_0_2 = require("scenes.toollayer.timer")
local var_0_3 = require("scenes.toollayer.ctrl")
local var_0_4 = require("scenes.toollayer.model"):extend({
	attach = function(arg_1_0, arg_1_1)
		arg_1_0.timer = var_0_2:new()
		arg_1_0.request = DailyRewardRequest:new(arg_1_1)

		arg_1_0.request:setResponseNormalHandler(function()
			local var_2_0, var_2_1 = arg_1_0.request:getResponseContent()

			if var_2_0 == DailyRewardRequest.eInfo then
				arg_1_0.salary = var_2_1.Salary
				arg_1_0.giftlist = var_2_1.GiftBag

				arg_1_0:trigger("sync", arg_1_0)
			elseif var_2_0 == DailyRewardRequest.eLevy then
				arg_1_0.salary = var_2_1

				arg_1_0:trigger("salary", var_2_1)
				arg_1_0:trigger("levy")
			elseif var_2_0 == DailyRewardRequest.eObtain then
				arg_1_0.obtainValue.DayNuber = arg_1_0.obtainValue.DayNuber + 1

				arg_1_0:trigger("obtain", arg_1_0.obtainValue)
			elseif var_2_0 == DailyRewardRequest.eSalary then
				arg_1_0.salary = var_2_1

				arg_1_0:trigger("salary", var_2_1)
			end
		end)
		arg_1_0.request:setResponseExceptionHandler(function()
			print("请求发生错误")
		end)
	end,
	sync = function(arg_4_0)
		if arg_4_0.dirty then
			arg_4_0:getRewardInfo()
		else
			arg_4_0:trigger("sync", arg_4_0)
		end
	end,
	toLimit = function(arg_5_0, arg_5_1)
		local var_5_0 = {
			vip = arg_5_1.MustPlayerVipLevel,
			level = arg_5_1.MustPlayerLevel,
			count = arg_5_1.MustDayNuber,
			total = arg_5_1.MustNumber
		}
		local var_5_1 = {
			vip = arg_5_1.PlayerVipLevel,
			level = arg_5_1.PlayerLevel,
			count = arg_5_1.DayNuber
		}

		return var_5_0, var_5_1
	end,
	isEabled = function(arg_6_0, arg_6_1)
		local var_6_0, var_6_1 = arg_6_0:toLimit(arg_6_1)

		return not (var_6_0.vip > var_6_1.vip or var_6_0.level > var_6_1.level or var_6_0.count > 0 and var_6_1.count == var_6_0.count or var_6_0.total == 0)
	end,
	getSalaryInfo = function(arg_7_0)
		arg_7_0.request:requestSalaryInfo()
	end,
	getRewardInfo = function(arg_8_0)
		arg_8_0.request:requestRewardInfo()
	end,
	levySalary = function(arg_9_0)
		if isEquipCountNotMax() then
			arg_9_0.request:requestTodaySalary()
		end
	end,
	obtainGift = function(arg_10_0, arg_10_1)
		arg_10_0.obtainValue = arg_10_1

		arg_10_0.request:requestTodayGift(arg_10_1.GifBagID)
	end,
	getIcon = function(arg_11_0, arg_11_1)
		return "libao/" .. arg_11_1
	end
})
local var_0_5 = class("DailyRewardLayer", function()
	return display.newLayer()
end)

function var_0_5.ctor(arg_13_0)
	arg_13_0.model = var_0_1.get(arg_13_0)

	if not arg_13_0.model then
		arg_13_0.model = var_0_4:new()

		var_0_1.set(arg_13_0, arg_13_0.model)
	end

	arg_13_0.model:attach(arg_13_0)

	arg_13_0.salary = nil
	arg_13_0.gift = nil
	arg_13_0.tableview = nil

	arg_13_0:initLayout()
	arg_13_0:setNodeEventEnabled(true)
end

function var_0_5.initLayout(arg_14_0)
	local var_14_0 = display.newSprite("ui/activity/activity_121.jpg")
	local var_14_1 = var_14_0:getContentSize()

	var_14_0:setAnchorPoint(ccp(0, 0))
	var_14_0:setPosition(0, 0)
	arg_14_0:setContentSize(var_14_1)
	arg_14_0:addChild(var_14_0)

	arg_14_0.container = var_14_0

	local var_14_2 = arg_14_0:createSalaryView()

	var_14_2:setAnchorPoint(ccp(0.5, 0))
	var_14_2:setPosition(var_14_1.width / 2, 260)
	var_14_0:addChild(var_14_2)

	local var_14_3 = arg_14_0:createGiftView()

	var_14_3:setAnchorPoint(ccp(0.5, 0))
	var_14_3:setPosition(var_14_1.width / 2, 25)
	var_14_0:addChild(var_14_3)

	arg_14_0.salary = var_14_2
	arg_14_0.gift = var_14_3

	arg_14_0.model:on("sync", arg_14_0.onSync, arg_14_0)
	arg_14_0.model:on("salary", arg_14_0.onSalary, arg_14_0)
	arg_14_0.model:on("levy", arg_14_0.onLevy, arg_14_0)
	arg_14_0.model:on("obtain", arg_14_0.onObtain, arg_14_0)
	arg_14_0.model:sync()
end

function var_0_5.onExit(arg_15_0, arg_15_1)
	arg_15_0.model:detach()
	arg_15_0:setNodeEventEnabled(false)

	if arg_15_1 == "exit" then
		arg_15_0:removeFromParentAndCleanup(true)
	end
end

function var_0_5.onSync(arg_16_0, arg_16_1)
	arg_16_0:onSalary(arg_16_1.salary)
	arg_16_0.tableview:reloadData(arg_16_1.giftlist)

	if #arg_16_1.giftlist == 0 then
		arg_16_0.gift.noticeLabel:setVisible(true)
	end
end

function var_0_5.onSalary(arg_17_0, arg_17_1)
	arg_17_0.salary:reloadData(arg_17_1)
end

function var_0_5.onLevy(arg_18_0)
	showFlashImage({
		image = "uilocal/enhance/enhance_txt_007.png",
		scale = 0.8,
		parent = arg_18_0.container,
		position = CCPoint(725, 370)
	})
	Player:setDailySalaryCount(0)
end

function var_0_5.onObtain(arg_19_0, arg_19_1)
	arg_19_1.button:setEnabled(arg_19_0.model:isEabled(arg_19_1))
end

function var_0_5.createSalaryView(arg_20_0)
	local var_20_0 = display.newSprite("ui/activity/activity_024.png")
	local var_20_1 = var_20_0:getContentSize()
	local var_20_2 = CCSize(668, 42)
	local var_20_3 = CCNode:create()
	local var_20_4 = var_0_3.newLabel({
		text = "",
		size = 18,
		color = ccc3(255, 210, 52)
	})
	local var_20_5 = require("scenes.ProgressBar").new({
		backImage = "ui/common/common_032.png",
		barImages = {
			"ui/common/common_031.png"
		},
		backSize = CCSize(180, 26),
		barSize = CCSize(138, 11),
		barPosition = ccp(-69, 1)
	})
	local var_20_6 = var_0_3.newLabel({
		text = "",
		size = 18,
		color = ccc3(255, 210, 52)
	})

	var_20_4:setAnchorPoint(ccp(0, 0.5))
	var_20_4:setPosition(35, var_20_2.height / 2)
	var_20_3:addChild(var_20_4)
	var_20_5:setPosition(485, var_20_2.height / 2)
	var_20_3:addChild(var_20_5)
	var_20_6:setAnchorPoint(ccp(0, 0.5))
	var_20_6:setPosition(580, var_20_2.height / 2)
	var_20_3:addChild(var_20_6)
	var_20_3:setContentSize(var_20_2)
	var_20_3:setAnchorPoint(ccp(0.5, 0.5))
	var_20_3:setPosition(var_20_1.width / 2, 150)
	var_20_0:addChild(var_20_3)

	local var_20_7 = ItemType.eCoin
	local var_20_8 = display.newSprite(getItemHeaderImagePath(var_20_7))

	var_20_8:setScale(0.5)
	var_20_8:setPosition(65, 90)
	var_20_0:addChild(var_20_8)

	local var_20_9 = var_0_3.newLabel({
		size = 22,
		text = getItemName(var_20_7) .. " 0"
	})

	var_20_9:align(display.LEFT_CENTER, 125, 90)
	var_20_0:addChild(var_20_9)

	local var_20_10 = ItemType.eKnowledge
	local var_20_11 = display.newSprite(getItemHeaderImagePath(var_20_10))

	var_20_11:setScale(0.5)
	var_20_11:setPosition(380, 90)
	var_20_0:addChild(var_20_11)

	local var_20_12 = var_0_3.newLabel({
		size = 22,
		text = getItemName(var_20_10) .. " 0"
	})

	var_20_12:align(display.LEFT_CENTER, 440, 90)
	var_20_0:addChild(var_20_12)

	local var_20_13 = ui.newControlButton({
		disabledImage = "ui/common/common_079.png",
		normalImage = "ui/common/common_018.png",
		text = string.lf("征收"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_21_0, arg_21_1)
			arg_20_0.model:levySalary()
		end
	})

	var_20_13:setTitleColorForState(ColorTable.eTitleButton_Disabled, CCControlStateDisabled)
	var_20_13:setPosition(700, 90)
	var_20_0:addChild(var_20_13)

	local var_20_14 = var_0_3.newLabel({
		text = "",
		size = 18,
		color = ccc3(223, 202, 107)
	})

	var_20_14:setPosition(var_20_1.width / 2, 35)
	var_20_0:addChild(var_20_14)

	local var_20_15 = var_0_3.newLabel({
		text = "",
		size = 18,
		color = ccc3(223, 202, 107)
	})

	var_20_15:setPosition(670, 30)
	var_20_0:addChild(var_20_15)
	var_20_15:setVisible(false)

	var_20_0.streakLabel = var_20_4
	var_20_0.streakCount = var_20_6
	var_20_0.streakRate = var_20_5
	var_20_0.coinLabel = var_20_9
	var_20_0.knowLabel = var_20_12
	var_20_0.countLabel = var_20_14
	var_20_0.timeLabel = var_20_15
	var_20_0.obtain = var_20_13
	var_20_0.parent = arg_20_0

	function var_20_0.reloadData(arg_22_0, arg_22_1)
		local var_22_0 = 0
		local var_22_1 = arg_22_1.ContinuousDay
		local var_22_2 = arg_22_1.AllDay
		local var_22_3 = arg_22_1.ToDay
		local var_22_4 = arg_22_1.CountDown
		local var_22_5 = var_22_3 > 0
		local var_22_6 = string.lf("每连续征收 #FF6F05%s天#FFD234，就可获高级装备等神秘礼物", tostring(var_22_2))

		arg_22_0.streakLabel:setString(var_22_6)

		local var_22_7 = "(" .. var_22_1 .. "/" .. var_22_2 .. ")"

		arg_22_0.streakCount:setString(var_22_7)

		local var_22_8 = string.lf("今日还可征收 %s 次", tostring(var_22_3))

		arg_22_0.countLabel:setString(var_22_8)

		if var_22_4 > 0 and var_22_5 then
			arg_22_0.timeLabel:setVisible(true)
			arg_22_0.parent.model.timer:schedule(var_22_4, function(arg_23_0, arg_23_1)
				arg_22_0.timeLabel:setString(string.lf("下次征收：%s", formatTime(arg_23_1)))
			end, function()
				arg_22_0.timeLabel:setVisible(false)
				arg_22_0.obtain:setEnabled(true)
			end)

			var_22_5 = false

			arg_22_0.parent.model.timer:start()
		end

		if var_22_2 ~= 0 then
			var_22_0 = var_22_1 / var_22_2
		end

		arg_22_0.streakRate:setProgressPercent(1, var_22_0)

		if arg_22_1.Reward then
			local var_22_9 = arg_22_1.Reward[1]
			local var_22_10 = arg_22_1.Reward[2]

			if var_22_9.Type ~= ItemType.eCoin then
				var_22_10, var_22_9 = var_22_9, var_22_10
			end

			if var_22_9.Type ~= var_20_7 then
				local var_22_11, var_22_12 = var_20_8:getPosition()

				var_20_8:removeFromParent()

				var_20_8 = display.newSprite(getItemHeaderImagePath(var_22_9.Type, var_22_9.ID))

				var_20_8:setScale(0.5)
				var_20_8:setPosition(var_22_11, var_22_12)
				var_20_0:addChild(var_20_8)

				var_20_7 = var_22_9.Type
			end

			var_20_9:setString(getItemName(var_22_9.Type, var_22_9.ID) .. "x" .. var_22_9.Count)

			if var_22_10.Type ~= var_20_10 then
				local var_22_13, var_22_14 = var_20_11:getPosition()

				var_20_11:removeFromParent()

				var_20_11 = display.newSprite(getItemHeaderImagePath(var_22_10.Type, var_22_10.ID))

				var_20_11:setScale(0.5)
				var_20_11:setPosition(var_22_13, var_22_14)
				var_20_0:addChild(var_20_11)

				var_20_10 = var_22_10.Type
			end

			var_20_12:setString(getItemName(var_22_10.Type, var_22_10.ID) .. "x" .. var_22_10.Count)
		end

		arg_22_0.obtain:setEnabled(var_22_5)
	end

	var_20_0:reloadData({
		ContinuousDay = 0,
		AllDay = 0,
		ToDay = 0,
		Knowledge = 0,
		Gold = 0,
		CountDown = 0
	})

	return var_20_0
end

function var_0_5.createGiftView(arg_25_0)
	local var_25_0 = display.newSprite("ui/activity/activity_023.png")
	local var_25_1 = var_25_0:getContentSize()
	local var_25_2 = display.newSprite("uilocal/activity/activity_text_039.png")

	var_25_2:setPosition(var_25_1.width / 2, var_25_1.height / 2)
	var_25_0:addChild(var_25_2)

	var_25_0.noticeLabel = var_25_2

	var_25_2:setVisible(false)

	local var_25_3 = {
		reverse = false,
		direction = kCCScrollViewDirectionHorizontal,
		size = CCSize(757, 112),
		sizehandler = function(arg_26_0, arg_26_1)
			return CCSize(234, 112)
		end,
		cellhandler = handler(arg_25_0, arg_25_0.createGiftItem)
	}
	local var_25_4 = createTableView(var_25_3)

	var_25_4:setPosition(11, 45)
	var_25_0:addChild(var_25_4)

	arg_25_0.tableview = var_25_4

	return var_25_0
end

function var_0_5.createGiftItem(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = display.newSprite("ui/activity/activity_021.png")

	var_27_0:setAnchorPoint(ccp(0, 0))
	var_27_0:setPosition(7, 0)

	local var_27_1 = display.newSprite("ui/activity/activity_029.png")
	local var_27_2 = var_0_3.newLabel({
		size = 20,
		text = arg_27_3.Name
	})
	local var_27_3 = var_27_1:getContentSize()

	var_27_2:setPosition(var_27_3.width / 2, 33)
	var_27_1:addChild(var_27_2)
	var_27_1:setPosition(150, 75)
	var_27_0:addChild(var_27_1)

	local var_27_4 = ui.newControlButton({
		normalImage = "ui/common/common_003.png",
		clickAction = function(arg_28_0, arg_28_1)
			arg_28_1 = tolua.cast(arg_28_1, "CCControlButton")

			arg_27_0:createRewardTips(arg_27_2, arg_27_3)
		end
	})

	var_27_4:setPosition(50, 55)
	var_27_0:addChild(var_27_4)

	local var_27_5 = var_27_4:getContentSize()
	local var_27_6 = display.newSprite(arg_27_0.model:getIcon(arg_27_3.icon))

	var_27_6:setPosition(var_27_5.width / 2, var_27_5.height / 2)
	var_27_4:addChild(var_27_6)

	local var_27_7 = ui.newControlButton({
		disabledImage = "ui/common/common_079.png",
		normalImage = "ui/common/common_018.png",
		highlightedImage = "ui/common/common_018.png",
		text = string.lf("领取"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_29_0, arg_29_1)
			arg_29_1 = tolua.cast(arg_29_1, "CCControlButton")
			arg_27_3.button = arg_29_1

			arg_27_0.model:obtainGift(arg_27_3)
		end
	})

	var_27_7:setTitleColorForState(ColorTable.eTitleButton_Disabled, CCControlStateDisabled)
	var_27_7:setPosition(160, 33)
	var_27_0:addChild(var_27_7)

	local var_27_8 = arg_27_0.model:isEabled(arg_27_3)

	var_27_7:setEnabled(var_27_8)

	return var_27_0
end

function var_0_5.createRewardTips(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = {}
	local var_30_1
	local var_30_2
	local var_30_3 = 20
	local var_30_4, var_30_5 = arg_30_0.model:toLimit(arg_30_2)
	local var_30_6 = arg_30_2.ListCrr

	if var_30_4.vip > var_30_5.vip or var_30_4.level > var_30_5.level or var_30_4.count > 0 and var_30_5.count == var_30_4.count or var_30_4.total == 0 then
		local var_30_7
		local var_30_8
		local var_30_9 = ccc3(255, 255, 255)
		local var_30_10 = ccc3(255, 0, 0)

		var_30_2 = string.lf("领取限制")

		local var_30_11 = var_30_4.vip > var_30_5.vip and var_30_10 or var_30_9
		local var_30_12 = var_0_3.newLabel({
			text = string.lf("VIP限制 %s", tostring(var_30_4.vip)),
			font = _FONT_DEFAULT,
			size = var_30_3,
			color = var_30_11
		})

		table.insert(var_30_0, var_30_12)

		local var_30_13 = var_30_4.level > var_30_5.level and var_30_10 or var_30_9
		local var_30_14 = var_0_3.newLabel({
			text = string.lf("等级限制 %s", tostring(var_30_4.level)),
			font = _FONT_DEFAULT,
			size = var_30_3,
			color = var_30_13
		})

		table.insert(var_30_0, var_30_14)

		local var_30_15 = var_30_4.count > 0 and var_30_5.count == var_30_4.count and var_30_10 or var_30_9
		local var_30_16 = var_0_3.newLabel({
			text = string.lf("领取次数 %s", tostring(var_30_4.count)),
			font = _FONT_DEFAULT,
			size = var_30_3,
			color = var_30_15
		})

		table.insert(var_30_0, var_30_16)

		if var_30_4.total ~= -1 then
			local var_30_17 = var_30_4.total == 0 and var_30_10 or var_30_9
			local var_30_18 = string.lf("礼包数量 %s", tostring(var_30_4.total))
			local var_30_19 = var_0_3.newLabel({
				text = var_30_18,
				font = _FONT_DEFAULT,
				size = var_30_3,
				color = var_30_17
			})

			table.insert(var_30_0, var_30_19)
		end
	else
		var_30_2 = arg_30_2.Name

		for iter_30_0, iter_30_1 in ipairs(arg_30_2.ListCrr) do
			local var_30_20 = var_0_3.newLabel({
				text = getItemName(iter_30_1.Type, iter_30_1.ID) .. "x" .. iter_30_1.Count,
				font = _FONT_DEFAULT,
				size = var_30_3
			})

			table.insert(var_30_0, var_30_20)
		end
	end

	local var_30_21 = var_0_3.linearLayout({
		margin = 5,
		direction = "vertical",
		nodes = var_30_0
	})
	local var_30_22 = var_0_0.new({
		prefer = var_0_0.ePreferTop,
		title = {
			size = 22,
			text = var_30_2,
			color = ccc3(248, 236, 68)
		}
	})

	var_30_22:addNode(var_30_21)
	var_30_22:show({
		scroll = {
			index = arg_30_1,
			size = CCSize(230, 93),
			table = arg_30_0.tableview
		}
	})
end

return var_0_5
