require("base.functions")
require("base.figure")
require("network.ActivityRequest")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = {
	typeOfRetry = 5,
	typeOfMan = 3,
	typeOfJin = 1,
	typeOfYu = 2,
	typeOfTang = 4
}
local var_0_2 = {
	typeOfThree = 1,
	typeOfFour = 2
}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = {}
local var_0_6
local var_0_7 = class("LuckyDiskLayer", function()
	return display.newLayer()
end)

function var_0_7.ctor(arg_2_0, arg_2_1)
	arg_2_0:setNodeEventEnabled(true)

	var_0_4 = {}
	var_0_3 = {}
	var_0_3 = {
		[var_0_1.typeOfJin] = {
			textImage = "uilocal/activity/activity_text_009.png",
			position = CCPoint(500, 15),
			text = string.lf("金")
		},
		[var_0_1.typeOfYu] = {
			textImage = "uilocal/activity/activity_text_007.png",
			position = CCPoint(600, 15),
			text = string.lf("玉")
		},
		[var_0_1.typeOfMan] = {
			textImage = "uilocal/activity/activity_text_006.png",
			position = CCPoint(700, 15),
			text = string.lf("满")
		},
		[var_0_1.typeOfTang] = {
			textImage = "uilocal/activity/activity_text_008.png",
			position = CCPoint(800, 15),
			text = string.lf("堂")
		}
	}

	if arg_2_1.parent then
		var_0_6 = arg_2_1.parent
	end

	arg_2_0.numberSeekWithAll = 0
	arg_2_0.numberSeekWithCoin = 0
	arg_2_0.seekingGold = 0
	arg_2_0.seekingCoin = 0
	arg_2_0.remainChooseCount = 0
	arg_2_0.numberRefresh = 0
	arg_2_0.baldricRefreshTime = 0
	arg_2_0.clearNumberTime = 0
	arg_2_0.refreshGold = 0

	arg_2_0:initRequests()
	arg_2_0:showInitLayer()
	arg_2_0:createTimers()
	arg_2_0.diskInfoRequest:request()
end

function var_0_7.onExit(arg_3_0)
	if arg_3_0.seekGlobalHandler then
		Player:manualChangeGlobalAttrs(arg_3_0.seekGlobalHandler)
	end
end

function var_0_7.initRequests(arg_4_0)
	local function var_4_0()
		arg_4_0:showDataLayer(arg_4_0.diskInfoRequest.restable)
	end

	arg_4_0.diskInfoRequest = LuckyDiskInfoRequest:new(var_0_6)

	arg_4_0.diskInfoRequest:setResponseNormalHandler(var_4_0)

	local function var_4_1()
		arg_4_0:showDiskReward(arg_4_0.diskSeekRequest.restable)
	end

	local function var_4_2()
		arg_4_0.btnStart:setEnabled(true)
		arg_4_0.btnRefresh:setEnabled(true)
	end

	arg_4_0.diskSeekRequest = LuckyDiskSeekRequest:new()

	arg_4_0.diskSeekRequest:setResponseNormalHandler(var_4_1)
	arg_4_0.diskSeekRequest:setResponseExceptionHandler(var_4_2)

	local function var_4_3()
		arg_4_0:showDataLayer(arg_4_0.diskRefreshRequest.restable)
	end

	arg_4_0.diskRefreshRequest = LuckyDiskRefreshRequest:new()

	arg_4_0.diskRefreshRequest:setResponseNormalHandler(var_4_3)

	local function var_4_4()
		local var_9_0 = arg_4_0.diskRewardRequest.restable

		local function var_9_1()
			var_0_0.createToast({
				show = var_0_0.eShowReward,
				rewards = var_9_0.Reward
			}):show({
				align = display.CENTER,
				x = display.cx,
				y = display.cy
			})
			arg_4_0:showDataLayer(var_9_0)
		end

		local var_9_2 = CCSkeletonAnimation:createWithFile("effectAni/ui_zhuangbeiqianghua.json", "effectAni/ui_zhuangbeiqianghua.atlas", 1)

		var_9_2:setAnimation("animation", false, 0)
		var_9_2:setPosition(var_0_5[arg_4_0.selectedRewardTag].position)
		arg_4_0.container:addChild(var_9_2, 100)
		var_9_2:addAnimationAction("animation", 1, CCCallFunc:create(var_9_1), AAT_Percent)
	end

	arg_4_0.diskRewardRequest = LuckydiskRewardRequest:new()

	arg_4_0.diskRewardRequest:setResponseNormalHandler(var_4_4)
end

function var_0_7.showInitLayer(arg_11_0)
	arg_11_0.container = display.newSprite("ui/activity/activity_058.jpg", 0, 0)

	arg_11_0.container:setAnchorPoint(CCPoint(0, 0))
	arg_11_0:addChild(arg_11_0.container)

	arg_11_0.nodeSize = arg_11_0.container:getContentSize()

	local var_11_0 = display.newSprite("ui/activity/activity_026.png", arg_11_0.nodeSize.width / 2 - 158, arg_11_0.nodeSize.height / 2 + 30)

	var_11_0:setAnchorPoint(CCPoint(0.5, 0.5))
	arg_11_0.container:addChild(var_11_0)

	arg_11_0.backDisk = var_11_0
	arg_11_0.numberLabel = addLabelWithColorSize(arg_11_0.container, string.lf("探宝次数: 0"), ccc3(255, 225, 255), 20, CCPoint(0, 0), CCPoint(10, arg_11_0.nodeSize.height - 40))
	arg_11_0.baldricLabel = addLabelWithColorSize(arg_11_0.container, "00:00:00", ccc3(255, 225, 255), 20, CCPoint(0, 0), CCPoint(600, 397))
	arg_11_0.clearLabel = addLabelWithColorSize(arg_11_0.container, "00:00:00", ccc3(255, 225, 255), 20, CCPoint(0, 0), CCPoint(252, 22))

	local var_11_1 = var_11_0:getContentSize()

	var_0_4 = {
		{
			offset = 281,
			position = CCPoint(var_11_1.width / 2 - 170, var_11_1.height / 2 + 37)
		},
		{
			offset = 303.5,
			position = CCPoint(var_11_1.width / 2 - 142, var_11_1.height / 2 + 98)
		},
		{
			offset = 326,
			position = CCPoint(var_11_1.width / 2 - 95, var_11_1.height / 2 + 145)
		},
		{
			offset = 348.5,
			position = CCPoint(var_11_1.width / 2 - 33, var_11_1.height / 2 + 170)
		},
		{
			offset = 11,
			position = CCPoint(var_11_1.width / 2 + 33, var_11_1.height / 2 + 170)
		},
		{
			offset = 33.5,
			position = CCPoint(var_11_1.width / 2 + 95, var_11_1.height / 2 + 145)
		},
		{
			offset = 56,
			position = CCPoint(var_11_1.width / 2 + 142, var_11_1.height / 2 + 98)
		},
		{
			offset = 78.5,
			position = CCPoint(var_11_1.width / 2 + 170, var_11_1.height / 2 + 37)
		},
		{
			offset = 101,
			position = CCPoint(var_11_1.width / 2 + 170, var_11_1.height / 2 - 30)
		},
		{
			offset = 123.5,
			position = CCPoint(var_11_1.width / 2 + 142, var_11_1.height / 2 - 92)
		},
		{
			offset = 146,
			position = CCPoint(var_11_1.width / 2 + 95, var_11_1.height / 2 - 140)
		},
		{
			offset = 168.5,
			position = CCPoint(var_11_1.width / 2 + 33, var_11_1.height / 2 - 165)
		},
		{
			offset = 191,
			position = CCPoint(var_11_1.width / 2 - 33, var_11_1.height / 2 - 165)
		},
		{
			offset = 213.5,
			position = CCPoint(var_11_1.width / 2 - 95, var_11_1.height / 2 - 140)
		},
		{
			offset = 236,
			position = CCPoint(var_11_1.width / 2 - 142, var_11_1.height / 2 - 92)
		},
		{
			offset = 258.5,
			position = CCPoint(var_11_1.width / 2 - 170, var_11_1.height / 2 - 30)
		}
	}
	var_0_5 = {
		{
			tag = var_0_2.typeOfThree,
			position = CCPoint(600, 316)
		},
		{
			tag = var_0_2.typeOfFour,
			position = CCPoint(600, 182)
		}
	}

	arg_11_0:randomDiskOrder()

	arg_11_0.imgPointer = display.newSprite("ui/activity/activity_028.png", var_11_1.width / 2, var_11_1.height / 2)

	arg_11_0.imgPointer:setAnchorPoint(CCPoint(0.5, 0))
	var_11_0:addChild(arg_11_0.imgPointer, 1)

	arg_11_0.btnStart = ui.newControlButton({
		highlightedImage = "ui/activity/activity_027.png",
		normalImage = "ui/activity/activity_027.png",
		anchorPoint = CCPoint(0.5, 0.5),
		position = CCPoint(var_11_1.width / 2, var_11_1.height / 2),
		clickAction = function()
			arg_11_0:btnStartAction(0)
		end
	})

	var_11_0:addChild(arg_11_0.btnStart, 2)

	local var_11_2 = arg_11_0.btnStart:getContentSize()
	local var_11_3 = display.newSprite("uilocal/activity/activity_text_003.png", var_11_2.width / 2, var_11_2.height / 2 + 10)

	var_11_3:setAnchorPoint(CCPoint(0.5, 0.5))
	arg_11_0.btnStart:addChild(var_11_3, 10)

	local var_11_4 = createItemCountNode({
		value = 0,
		type = ItemType.eCoin,
		color = ccc3(255, 255, 255)
	})

	var_11_4:setAnchorPoint(CCPoint(0.5, 0.5))
	var_11_4:setPosition(CCPoint(var_11_2.width / 2 - 32, var_11_2.height / 2 - 25))
	arg_11_0.btnStart:addChild(var_11_4)

	arg_11_0.moneyLabel = var_11_4
	arg_11_0.moneyLabel.isCoin = true

	local var_11_5 = display.newScale9Sprite("ui/activity/activity_081.png", var_11_1.width / 2, var_11_1.height / 2 - 60, CCSize(200, 50))

	var_11_5:setAnchorPoint(CCPoint(0.5, 1))
	var_11_0:addChild(var_11_5)

	arg_11_0.remainChooseLabel = addLabelWithColorSize(var_11_5, "", ccc3(255, 255, 255), 20, CCPoint(0.5, 0.5), CCPoint(100, 25))
	arg_11_0.btnRefresh = ui.newControlButton({
		normalImage = "ui/common/common_018.png",
		highlightedImage = "ui/common/common_018.png",
		text = string.lf("刷新"),
		textColor = ColorTable.eTitleButton_Normal,
		fontSize = ColorTable.eTitleButton_FontSize,
		position = CCPoint(765, 400),
		clickAction = function()
			if arg_11_0.numberRefresh <= 0 then
				showFlashNotice(string.lf("您今日的刷新次数已用完"))

				return
			end

			if isMoneyEnough(MoneyType.eGold, arg_11_0.refreshGold) == false then
				return
			end

			arg_11_0.diskRefreshRequest:request()
		end
	})

	arg_11_0.container:addChild(arg_11_0.btnRefresh)

	arg_11_0.refreshByIngot = createItemCountNode({
		value = 0,
		type = ItemType.eGold,
		color = ccc3(255, 255, 255)
	})

	arg_11_0.refreshByIngot:setAnchorPoint(CCPoint(0, 0))
	arg_11_0.refreshByIngot:setPosition(CCPoint(520, 385))
	arg_11_0.container:addChild(arg_11_0.refreshByIngot)

	local var_11_6 = display.newSprite("icon/icon_lunpanchongzhiling.png", 620, 385)

	arg_11_0.container:addChild(var_11_6, 100)

	arg_11_0.refreshByToken = addLabelWithColorSize(arg_11_0.container, "", ccc3(255, 255, 255), 20, CCPoint(0, 0), CCPoint(640, 372))

	for iter_11_0, iter_11_1 in ipairs(var_0_3) do
		arg_11_0:setGoldItemNumber(iter_11_0, 0)
	end

	addLabelWithColorSize(arg_11_0.container, string.lf("集齐“金玉满堂”任意3字即可领取"), ccc3(255, 255, 35), 20, CCPoint(0, 0), CCPoint(505, 240))
	addLabelWithColorSize(arg_11_0.container, string.lf("集齐“金玉满堂”全部4字即可领取"), ccc3(255, 255, 35), 20, CCPoint(0, 0), CCPoint(505, 108))
end

function var_0_7.showDataLayer(arg_14_0, arg_14_1)
	arg_14_0.numberSeekWithAll = arg_14_1.remainSeekingTreasuresTime
	arg_14_0.numberSeekWithCoin = arg_14_1.remainTimeUseGold

	arg_14_0.numberLabel:setString(string.lf("探宝次数: %s", tostring(arg_14_0.numberSeekWithAll)))
	Player:setLuckyDiskCount(arg_14_0.numberSeekWithCoin)
	arg_14_0.imgPointer:runAction(CCRotateTo:create(0.5, 0))

	for iter_14_0, iter_14_1 in pairs(var_0_4) do
		iter_14_1.ID, iter_14_1.Type, iter_14_1.Count, iter_14_1.Index = nil
	end

	local var_14_0
	local var_14_1

	for iter_14_2, iter_14_3 in pairs(arg_14_1.treasuresInfo) do
		if iter_14_3.Index <= 16 then
			arg_14_0:setDiskReward(arg_14_0:getFirstBlank(), iter_14_3)
		elseif iter_14_3.Index == 17 then
			var_14_0 = iter_14_3
		elseif iter_14_3.Index == 18 then
			var_14_1 = iter_14_3
		end
	end

	arg_14_0.seekingGold = arg_14_1.seekingTreasuresCost.ingot ~= nil and arg_14_1.seekingTreasuresCost.ingot or 0
	arg_14_0.seekingCoin = arg_14_1.seekingTreasuresCost.gold ~= nil and arg_14_1.seekingTreasuresCost.gold or 0

	arg_14_0:setSeekPrice()

	local var_14_2 = arg_14_1.refreshTokenCount

	arg_14_0.refreshGold = var_14_2 > 0 and 0 or arg_14_1.refreshIngotCost
	arg_14_0.numberRefresh = arg_14_1.remainRefreshTreasuresTime

	arg_14_0.refreshByIngot:setValue(arg_14_0.refreshGold)
	arg_14_0.refreshByToken:setString(var_14_2 .. "/1")

	arg_14_0.remainChooseCount = arg_14_1.needSeekingTreasureNumber

	if arg_14_0.remainChooseCount > 0 then
		arg_14_0.remainChooseLabel:setString(string.lf("#FFFFFF再转#00FF00%s次#FFFFFF就可以任意选择\n一件转盘宝物", arg_14_0.remainChooseCount))
	else
		local var_14_3 = CCArray:create()

		var_14_3:addObject(CCFadeOut:create(1))
		var_14_3:addObject(CCFadeIn:create(1))

		arg_14_0.isChoosed = false

		arg_14_0.remainChooseLabel:setString(string.lf("#00FF00花费%d元宝任意选取\n一件宝物", arg_14_0.seekingGold))
		arg_14_0.remainChooseLabel:runAction(CCRepeatForever:create(CCSequence:create(var_14_3)))
		arg_14_0.btnStart:setEnabled(false)
		arg_14_0.btnRefresh:setEnabled(false)
	end

	arg_14_0.baldricRefreshTime = arg_14_1.treasuresRefreshTime
	arg_14_0.clearNumberTime = arg_14_1.clearWordsTime

	arg_14_0:setGoldItemNumber(var_0_1.typeOfJin, arg_14_1.jin)
	arg_14_0:setGoldItemNumber(var_0_1.typeOfYu, arg_14_1.yu)
	arg_14_0:setGoldItemNumber(var_0_1.typeOfMan, arg_14_1.man)
	arg_14_0:setGoldItemNumber(var_0_1.typeOfTang, arg_14_1.tang)

	local var_14_4 = arg_14_0:addLuckyReward(var_14_0.Treasure[1], var_0_2.typeOfThree, arg_14_1.baldric1State)
	local var_14_5 = arg_14_0:addLuckyReward(var_14_1.Treasure[1], var_0_2.typeOfFour, arg_14_1.baldric2State)
end

function var_0_7.showDiskReward(arg_15_0, arg_15_1)
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in ipairs(var_0_4) do
		if iter_15_1.Index ~= nil and iter_15_1.Index == arg_15_1.index then
			var_15_0 = iter_15_0

			break
		end
	end

	local function var_15_1(arg_16_0)
		local function var_16_0()
			arg_15_0.btnStart:setEnabled(true)
			arg_15_0.btnRefresh:setEnabled(true)
			Player:manualChangeGlobalAttrs(arg_15_0.seekGlobalHandler)
			arg_15_0:showDataLayer(arg_15_1.luckydisk)

			if arg_15_1.Crit ~= nil and arg_15_1.Crit > 1 then
				local var_17_0 = require("scenes.enhance.DlgResultLayer").new({
					titleText = string.lf("恭喜您触发#00FF00%s倍#C8AA64暴击，获得以下奖品:", arg_15_1.Crit),
					rewardList = arg_15_1.Reward
				})

				CCDirector:sharedDirector():getRunningScene():addChild(var_17_0, DefaultZOrder.ePopupLayer)
			else
				var_0_0.createToast({
					show = var_0_0.eShowReward,
					rewards = arg_15_1.Reward
				}):show({
					align = display.CENTER,
					x = display.cx,
					y = display.cy
				})
			end
		end

		local var_16_1 = CCSkeletonAnimation:createWithFile("effectAni/ui_zhuangbeiqianghua.json", "effectAni/ui_zhuangbeiqianghua.atlas", 1)

		var_16_1:setAnimation("animation", false, 0)
		var_16_1:setPosition(var_0_4[arg_16_0].position)
		var_16_1:setScale(0.8)
		arg_15_0.backDisk:addChild(var_16_1, 100)
		var_16_1:addAnimationAction("animation", 1, CCCallFunc:create(var_16_0), AAT_Percent)
	end

	if arg_15_0.remainChooseCount > 0 then
		local var_15_2 = CCRotateTo:create(5, 2520 + var_0_4[var_15_0].offset)
		local var_15_3 = CCEaseSineOut:create(var_15_2)
		local var_15_4 = CCArray:create()

		var_15_4:addObject(var_15_3)
		var_15_4:addObject(CCCallFunc:create(function()
			var_15_1(var_15_0)
		end))
		arg_15_0.imgPointer:runAction(CCSequence:create(var_15_4))
	else
		var_15_1(var_15_0)
	end
end

function var_0_7.createTimers(arg_19_0)
	local var_19_0 = {}
	local var_19_1 = {}

	local function var_19_2()
		if arg_19_0.baldricRefreshTime <= 0 then
			arg_19_0.diskInfoRequest:request()
		else
			arg_19_0.baldricRefreshTime = arg_19_0.baldricRefreshTime - 1

			arg_19_0.baldricLabel:setString(formatTime(arg_19_0.baldricRefreshTime))
		end
	end

	var_19_1.callback, var_19_0.callback = function()
		if arg_19_0.clearNumberTime <= 0 then
			arg_19_0.diskInfoRequest:request()
		else
			arg_19_0.clearNumberTime = arg_19_0.clearNumberTime - 1

			arg_19_0.clearLabel:setString(formatTime(arg_19_0.clearNumberTime))
		end
	end, var_19_2

	var_0_6:addToTimerTable(var_19_0)
	var_0_6:addToTimerTable(var_19_1)
end

function var_0_7.btnStartAction(arg_22_0, arg_22_1)
	if arg_22_0.numberSeekWithAll <= 0 then
		showFlashNotice(string.lf("今日探宝次数已用完，上仙请明天再来吧"))

		return
	end

	if arg_22_0.numberSeekWithCoin > 0 then
		if isMoneyEnough(MoneyType.eCoin, tonumber(arg_22_0.seekingCoin)) == false then
			return
		end

		arg_22_0.seekGlobalHandler = arg_22_0.diskSeekRequest:request(arg_22_1)

		Player:setCoin(Player.curCoin - arg_22_0.seekingCoin)
		arg_22_0.btnStart:setEnabled(false)
		arg_22_0.btnRefresh:setEnabled(false)
	else
		if isMoneyEnough(MoneyType.eGold, arg_22_0.seekingGold) == false then
			return
		end

		arg_22_0.seekGlobalHandler = arg_22_0.diskSeekRequest:request(arg_22_1)

		Player:setGold(Player.curGold - arg_22_0.seekingGold)
		arg_22_0.btnStart:setEnabled(false)
		arg_22_0.btnRefresh:setEnabled(false)
	end
end

function var_0_7.btnRewardAction(arg_23_0, arg_23_1)
	if arg_23_0:getGoldTypeNumber() < (arg_23_1 == var_0_2.typeOfThree and 3 or 4) then
		showFlashNotice(string.lf("您收集到的字数不够"))
	else
		arg_23_0.diskRewardRequest:request(arg_23_1)
	end
end

function var_0_7.setDiskReward(arg_24_0, arg_24_1, arg_24_2)
	local function var_24_0(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
		local var_25_0 = arg_25_0:getContentSize()

		arg_25_0:removeAllChildrenWithCleanup(true)

		local var_25_1 = arg_25_1 == ItemType.eLuckyWord and var_0_3[arg_25_2].textImage or getItemHeaderImagePath(arg_25_1, arg_25_2)
		local var_25_2 = ui.newControlButton({
			normalImage = var_25_1,
			size = (arg_25_1 == ItemType.eGold or arg_25_1 == ItemType.eCoin) and CCSize(var_25_0.width * 0.7, var_25_0.height * 0.7) or nil,
			anchorPoint = CCPoint(0.5, 0.5),
			position = CCPoint(var_25_0.width / 2, var_25_0.height / 2),
			clickAction = function()
				if arg_24_0.remainChooseCount == 0 then
					if arg_24_0.isChoosed ~= nil and arg_24_0.isChoosed == true then
						return
					end

					arg_24_0.remainChooseLabel:stopAllActions()
					arg_24_0.remainChooseLabel:setOpacity(255)

					arg_24_0.isChoosed = true

					arg_24_0:btnStartAction(arg_24_2.Index)
				elseif arg_25_1 == ItemType.eLuckyWord then
					arg_24_0:showCommonTips(arg_25_1, arg_25_2, arg_25_3, var_0_4[arg_24_1].position)
				else
					arg_24_0:showEquipAndFragment({
						Type = arg_25_1,
						ID = arg_25_2,
						Count = arg_25_3
					})
				end
			end
		})

		arg_25_0:addChild(var_25_2)

		local var_25_3 = var_25_2:getContentSize()

		if arg_25_1 == ItemType.eSoul then
			local var_25_4 = display.newSprite("uilocal/common/common_text_012.png", 0, var_25_3.height - 5)

			var_25_4:setAnchorPoint(CCPoint(0, 1))
			var_25_2:addChild(var_25_4)
		elseif arg_25_1 == ItemType.eFragment then
			local var_25_5 = display.newSprite("uilocal/common/common_text_011.png", 0, var_25_3.height - 5)

			var_25_5:setAnchorPoint(CCPoint(0, 1))
			var_25_2:addChild(var_25_5)
		end

		if arg_25_3 ~= nil and arg_25_3 > 1 then
			addLabelWithColorSize(arg_25_0, arg_25_3, ccc3(0, 255, 0), 18, CCPoint(0.5, 0.5), CCPoint(var_25_0.width / 2, var_25_0.height / 2 - 30))
		end
	end

	local var_24_1 = arg_24_2.Treasure[1]

	var_0_4[arg_24_1].Type = var_24_1.Type
	var_0_4[arg_24_1].ID = var_24_1.ID ~= nil and var_24_1.ID or 0
	var_0_4[arg_24_1].Count = var_24_1.Count
	var_0_4[arg_24_1].Index = arg_24_2.Index

	if var_0_4[arg_24_1].background then
		var_24_0(var_0_4[arg_24_1].background, var_24_1.Type, var_24_1.ID, var_24_1.Count)

		return
	end

	local var_24_2 = display.newSprite("ui/common/common_011.png")
	local var_24_3 = var_24_2:getContentSize()

	var_24_2:setScale(0.8)
	var_24_2:setAnchorPoint(CCPoint(0.5, 0.5))
	var_24_2:setPosition(var_0_4[arg_24_1].position)
	arg_24_0.backDisk:addChild(var_24_2, 0)

	var_0_4[arg_24_1].background = var_24_2

	var_24_0(var_24_2, var_24_1.Type, var_24_1.ID, var_24_1.Count)
end

function var_0_7.setGoldItemNumber(arg_27_0, arg_27_1, arg_27_2)
	if var_0_3[arg_27_1].numLabel then
		var_0_3[arg_27_1].numLabel:setString(arg_27_2)

		return
	end

	local var_27_0 = display.newSprite("ui/common/common_011.png")
	local var_27_1 = var_27_0:getContentSize()

	var_27_0:setAnchorPoint(CCPoint(1, 0))
	var_27_0:setPosition(var_0_3[arg_27_1].position)
	arg_27_0.container:addChild(var_27_0, 1)

	local var_27_2 = display.newSprite(var_0_3[arg_27_1].textImage)

	var_27_2:setAnchorPoint(CCPoint(0.5, 0.5))
	var_27_2:setPosition(CCPoint(var_27_1.width / 2, var_27_1.height / 2))
	var_27_0:addChild(var_27_2)

	local var_27_3 = createNumberWidthBgSprite("ui/common/common_017.png", arg_27_2)

	var_27_3:setScale(1.25)
	var_27_3:setPosition(CCPoint(var_27_1.width - 10, 10))
	var_27_0:addChild(var_27_3)

	var_0_3[arg_27_1].numLabel = var_27_3.numLabel
end

function var_0_7.getGoldItemNumber(arg_28_0, arg_28_1)
	local var_28_0 = 0

	if var_0_3[arg_28_1].numLabel then
		var_28_0 = tonumber(var_0_3[arg_28_1].numLabel:getString())
	end

	return var_28_0
end

function var_0_7.getGoldTypeNumber(arg_29_0)
	return 0 + (arg_29_0:getGoldItemNumber(var_0_1.typeOfJin) > 0 and 1 or 0) + (arg_29_0:getGoldItemNumber(var_0_1.typeOfYu) > 0 and 1 or 0) + (arg_29_0:getGoldItemNumber(var_0_1.typeOfMan) > 0 and 1 or 0) + (arg_29_0:getGoldItemNumber(var_0_1.typeOfTang) > 0 and 1 or 0)
end

function var_0_7.addLuckyReward(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = arg_30_0:getGoldTypeNumber()
	local var_30_1 = var_0_5[arg_30_2].position
	local var_30_2

	var_30_2 = figure.createHeader({
		isName = false,
		inTeam = false,
		itemId = arg_30_1.ID,
		type = arg_30_1.Type,
		count = arg_30_1.Count,
		clickAction = function()
			local var_31_0

			local function var_31_1()
				if var_31_0 ~= nil then
					var_31_0:removeFromParentAndCleanup(true)

					var_31_0 = nil
				end

				arg_30_0.selectedRewardTag = arg_30_2

				arg_30_0:btnRewardAction(arg_30_2)
			end

			local var_31_2 = var_30_2.isReceived ~= nil and var_30_2.isReceived or 0

			if arg_30_2 == var_0_2.typeOfThree then
				var_31_0 = arg_30_0:showEquipAndFragment(arg_30_1, var_30_0 >= 3 and var_31_2 == 0 and string.lf("兑奖") or nil, var_30_0 >= 3 and var_31_2 == 0 and var_31_1 or nil)
			else
				var_31_0 = arg_30_0:showEquipAndFragment(arg_30_1, var_30_0 >= 4 and var_31_2 == 0 and string.lf("兑奖") or nil, var_30_0 >= 4 and var_31_2 == 0 and var_31_1 or nil)
			end

			if var_31_2 == 1 then
				local var_31_3 = var_31_0.container:getContentSize()
				local var_31_4 = createMarkLabel({
					size = 18,
					text = string.lf("已兑换")
				})

				var_31_4:setRotation(90)
				var_31_4:setAnchorPoint(CCPoint(1, 1))
				var_31_4:setPosition(CCPoint(var_31_3.width - 4, var_31_3.height - var_31_4:getContentSize().height - 1))
				var_31_0.container:addChild(var_31_4)
			end
		end
	})

	var_30_2:setTag(arg_30_2)
	var_30_2:setAnchorPoint(CCPoint(0.5, 0.5))
	var_30_2:setPosition(var_30_1)
	arg_30_0.container:addChild(var_30_2)

	if var_0_5[arg_30_2].figureNode ~= nil then
		var_0_5[arg_30_2].figureNode:removeFromParentAndCleanup(true)
	end

	var_0_5[arg_30_2].figureNode = var_30_2

	if arg_30_3 ~= nil then
		var_30_2.isReceived = arg_30_3

		if arg_30_3 == 1 then
			local var_30_3 = display.newSprite("ui/common/mask2.png", 0, 0)

			var_30_2:addChild(var_30_3)
		end
	end

	return var_30_2
end

function var_0_7.showCommonTips(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5, arg_33_6)
	local var_33_0 = CCNode:create()
	local var_33_1 = {}
	local var_33_2 = getItemQuality(arg_33_1, arg_33_2)
	local var_33_3 = getQualityColor(var_33_2)
	local var_33_4

	if arg_33_1 == ItemType.eGold or arg_33_1 == ItemType.eCoin then
		var_33_4 = getItemName(arg_33_1, arg_33_2) .. "#00FF00x" .. arg_33_3
	elseif arg_33_1 == ItemType.eLuckyWord then
		var_33_4 = string.lf("幸运字: %s", var_0_3[arg_33_2].text)
	else
		var_33_4 = string.lf("品质: %s", getQualityAttribute(var_33_2, QualityAttr.eName))
	end

	var_33_1.title = {
		size = 22,
		text = getItemName(arg_33_1, arg_33_2),
		color = var_33_3
	}

	var_33_0:setContentSize(CCSize(260, 40))
	addLabelWithColorSize(var_33_0, var_33_4, var_33_3, 22, CCPoint(0, 0), CCPoint(20, 0))

	if arg_33_1 == ItemType.eSoul then
		local var_33_5 = display.newSprite("ui/common/common_soul_small.png")

		var_33_5:setAnchorPoint(CCPoint(1, 0))
		var_33_5:setPosition(260, 0)
		var_33_0:addChild(var_33_5)
	end

	local var_33_6 = var_0_0.new(var_33_1)

	var_33_6:addNode(var_33_0)

	if arg_33_5 ~= nil and arg_33_6 ~= nil then
		var_33_6:addAction({
			text = arg_33_5,
			callback = arg_33_6
		})
	end

	var_33_6:show({
		parent = arg_33_0.container,
		x = arg_33_4.x,
		y = arg_33_4.y - 50,
		align = display.CENTER_BOTTOM
	})

	return var_33_6
end

function var_0_7.setSeekPrice(arg_34_0)
	if arg_34_0.numberSeekWithCoin > 0 then
		arg_34_0.moneyLabel:setValue(arg_34_0.seekingCoin)
	elseif arg_34_0.moneyLabel.isCoin == true then
		local var_34_0 = createItemCountNode({
			type = ItemType.eGold,
			value = arg_34_0.seekingGold,
			color = ccc3(255, 255, 255)
		})

		var_34_0:setAnchorPoint(CCPoint(0.5, 0.5))
		var_34_0:setPosition(arg_34_0.moneyLabel:getPositionX() + 15, arg_34_0.moneyLabel:getPositionY())
		arg_34_0.moneyLabel:getParent():addChild(var_34_0)
		arg_34_0.moneyLabel:removeFromParentAndCleanup(true)

		arg_34_0.moneyLabel = var_34_0
		arg_34_0.moneyLabel.isCoin = false
	else
		arg_34_0.moneyLabel:setValue(arg_34_0.seekingGold)
	end
end

function var_0_7.randomDiskOrder(arg_35_0)
	local var_35_0 = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		10,
		11,
		12,
		13,
		14,
		15,
		16
	}
	local var_35_1 = {}

	for iter_35_0, iter_35_1 in pairs(var_0_4) do
		var_35_1[iter_35_0] = iter_35_1
	end

	var_0_4 = {}

	for iter_35_2 = 1, table.nums(var_35_0) do
		local var_35_2 = math.random(1, table.nums(var_35_1))
		local var_35_3 = var_35_1[var_35_2]
		local var_35_4 = {
			offset = var_35_3.offset,
			position = var_35_3.position
		}

		if var_35_3.background then
			var_35_4.background = var_35_3.background
		end

		var_0_4[var_35_0[iter_35_2]] = var_35_4

		table.remove(var_35_1, var_35_2)
	end
end

function var_0_7.getFirstBlank(arg_36_0)
	local var_36_0 = 0

	for iter_36_0, iter_36_1 in ipairs(var_0_4) do
		if iter_36_1.Type == nil then
			var_36_0 = iter_36_0

			break
		end
	end

	return var_36_0
end

function var_0_7.showEquipAndFragment(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = ({
		[ItemType.eSoul] = var_0_0.eShowTujianHero,
		[ItemType.eHero] = var_0_0.eShowTujianHero,
		[ItemType.eProp] = var_0_0.eShowPropInfo,
		[ItemType.eMate] = var_0_0.eShowPropInfo,
		[ItemType.eEquip] = var_0_0.eShowTeamEquip,
		[ItemType.eFragment] = var_0_0.eShowTeamEquip,
		[ItemType.eVIPLevel] = var_0_0.eShowPropInfo
	})[arg_37_1.Type]

	if var_37_0 then
		local var_37_1
		local var_37_2

		if var_37_0 == var_0_0.eShowTujianHero then
			var_37_1 = var_0_0.createDialog
		else
			var_37_1 = var_0_0.createTips
		end

		local var_37_3 = var_37_1({
			player = false,
			show = var_37_0,
			type = arg_37_1.Type,
			id = arg_37_1.ID,
			data = arg_37_1,
			align = display.CENTER
		})

		if var_37_0 ~= var_0_0.eShowTujianHero then
			var_37_3:addAction({
				text = arg_37_2 or string.lf("确定"),
				callback = arg_37_3
			})

			if arg_37_2 then
				var_37_3.actMargin = 50

				var_37_3:addAction({
					text = string.lf("取消")
				})
			end
		end

		var_37_3.margin = 0
		var_37_3.actionIn = var_0_0.popinLayer
		var_37_3.actionOut = var_0_0.popoutLayer

		var_37_3:show()

		return var_37_3
	else
		local var_37_4 = getItemName(arg_37_1.Type, arg_37_1.ID)

		if arg_37_1.Count and arg_37_1.Count > 1 then
			var_37_4 = var_37_4 .. "x" .. arg_37_1.Count
		end

		showFlashNotice(var_37_4)
	end
end

return var_0_7
