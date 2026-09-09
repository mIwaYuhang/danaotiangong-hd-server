require("network.MineralRequest")

local var_0_0 = require("scenes.toollayer.ctrl")

require("data.MineralHelper")

local var_0_1 = class("MineralHoleLayer", function()
	return CCScale9Sprite:create("ui/friend/friend_003.png")
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1 and arg_2_1.layerSize and arg_2_1.layerSize or CCSize(920, 508)

	arg_2_0:setPreferredSize(var_2_0)

	arg_2_0.size = var_2_0
	arg_2_0.container = arg_2_0
	arg_2_0.totalSeconds = 0
	arg_2_0.useTime = 0
	arg_2_0.goldHoeCount = 0
	arg_2_0.totalCount = 0

	if arg_2_1.gparent then
		gParent = arg_2_1.gparent
	end

	arg_2_0:initRequests()
	arg_2_0.holeInfoRequest:request()
	arg_2_0:onEnterAlias()
	arg_2_0:createTimers()
end

function var_0_1.initRequests(arg_3_0)
	local function var_3_0()
		local var_4_0 = arg_3_0.holeInfoRequest.restable

		arg_3_0:setdata(var_4_0)

		if var_4_0.getGem[totalCount] ~= 0 then
			arg_3_0:refreshPreview(var_4_0.getGem)
		end
	end

	arg_3_0.holeInfoRequest = MineralHoleInfoRequest:new()

	arg_3_0.holeInfoRequest:setResponseNormalHandler(var_3_0)

	local function var_3_1()
		local var_5_0 = arg_3_0.buyHoeRequest.restable

		arg_3_0:setdata(var_5_0.Result)
		showFlashNotice(string.lf("上仙，黄金矿锄升级成功"))
	end

	arg_3_0.buyHoeRequest = GemBuyGoldHoeRequest:new()

	arg_3_0.buyHoeRequest:setResponseNormalHandler(var_3_1)

	local function var_3_2()
		local var_6_0 = arg_3_0.getGemRequest.restable

		if var_6_0 then
			gParent:addChild(require("scenes.mineral.MineralGetGemLayer").new({
				parent = arg_3_0,
				data = var_6_0.Gems,
				textTitle = string.lf("本次采集耗时：%s", formatTime(arg_3_0.totalSeconds))
			}))
			arg_3_0.holeInfoRequest:request()
			showFlashNotice(string.lf("上仙，宝石收取成功~~"))
		else
			showFlashNotice(string.lf("上仙，宝石收取错误~~"))
		end
	end

	arg_3_0.getGemRequest = GemMineGetRequest:new()

	arg_3_0.getGemRequest:setResponseNormalHandler(var_3_2)
end

function var_0_1.setdata(arg_7_0, arg_7_1)
	arg_7_0.totalSeconds = arg_7_1.totalSeconds
	arg_7_0.useTime = arg_7_1.useTime
	arg_7_0.goldHoeCount = arg_7_1.goldHoeCount
	arg_7_0.totalCount = arg_7_1.getGem.totalCount

	if arg_7_1.totalSeconds < 300 then
		arg_7_0.bogieSprite:removeFromParentAndCleanup()

		local var_7_0 = display.newSprite("ui/mineral/mineral_kong.png", 550, 270)

		arg_7_0.container:addChild(var_7_0)

		arg_7_0.bogieSprite = var_7_0
	elseif arg_7_1.totalSeconds < 43200 then
		arg_7_0.bogieSprite:removeFromParentAndCleanup()

		local var_7_1 = display.newSprite("ui/mineral/mineral_shao.png", 550, 270)

		arg_7_0.container:addChild(var_7_1)

		arg_7_0.bogieSprite = var_7_1
	else
		arg_7_0.bogieSprite:removeFromParentAndCleanup()

		local var_7_2 = display.newSprite("ui/mineral/mineral_duo.png", 550, 270)

		arg_7_0.container:addChild(var_7_2)

		arg_7_0.bogieSprite = var_7_2
	end
end

function var_0_1.refreshPreview(arg_8_0, arg_8_1)
	arg_8_0.previewLabel_1:setString(string.lf("宝石总数：%s", arg_8_1.totalCount))

	if arg_8_1.totalCount ~= 0 then
		arg_8_0.previewLabel_2:setString(string.lf("一级宝石总数：%s", arg_8_1.gemLevels[1].count))
		arg_8_0.previewLabel_3:setString(string.lf("二级宝石总数：%s", arg_8_1.gemLevels[2].count))
		arg_8_0.previewLabel_4:setString(string.lf("三级宝石总数：%s", arg_8_1.gemLevels[3].count))
	end
end

function var_0_1.onEnterAlias(arg_9_0)
	local var_9_0 = CCScale9Sprite:create("ui/mineral/mineral_01.jpg")
	local var_9_1 = CCSize(arg_9_0.container.size.width - 10, arg_9_0.container.size.height - 10)

	var_9_0:setPreferredSize(var_9_1)
	var_9_0:setAnchorPoint(ccp(0, 0))
	var_9_0:setPosition(5, 5)
	arg_9_0.container:addChild(var_9_0)

	local var_9_2 = display.newSprite("ui/mineral/mineral_24.png", 260, 210)

	arg_9_0.container:addChild(var_9_2)

	local function var_9_3()
		local var_10_0 = createFrameAnimation({
			loop = false,
			delta = 0.08,
			list = {
				"ui/mineral/mineral_18.png",
				"ui/mineral/mineral_19.png",
				"ui/mineral/mineral_20.png"
			},
			callback = function()
				arg_9_0.bomb:removeFromParentAndCleanup(true)
			end
		})

		var_10_0:setAnchorPoint(ccp(0, 0))
		var_10_0:setPosition(ccp(40, 170))

		arg_9_0.bomb = var_10_0

		arg_9_0.container:addChild(var_10_0)
	end

	local var_9_4 = createFrameAnimation({
		loop = true,
		delta = 0.15,
		list = {
			"ui/mineral/mineral_21.png",
			"ui/mineral/mineral_22.png",
			"ui/mineral/mineral_23.png"
		},
		callback = var_9_3
	})

	var_9_4:setAnchorPoint(ccp(0, 0))
	var_9_4:setPosition(ccp(90, 190))
	arg_9_0.container:addChild(var_9_4)

	local var_9_5 = display.newSprite("ui/mineral/mineral_16.png", 125, 265)

	arg_9_0.container:addChild(var_9_5)

	local var_9_6 = CCArray:create()

	var_9_6:addObject(CCFadeTo:create(0.7, 50))
	var_9_6:addObject(CCFadeTo:create(0.7, 255))
	var_9_5:runAction(CCRepeatForever:create(CCSequence:create(var_9_6)))

	local var_9_7 = display.newSprite("ui/mineral/mineral_17.png", 590, 338)

	arg_9_0.container:addChild(var_9_7)

	local var_9_8 = CCArray:create()

	var_9_8:addObject(CCFadeTo:create(0.7, 100))
	var_9_8:addObject(CCFadeTo:create(0.7, 255))
	var_9_7:runAction(CCRepeatForever:create(CCSequence:create(var_9_8)))

	local var_9_9 = display.newSprite("ui/mineral/mineral_kong.png", 550, 270)

	arg_9_0.container:addChild(var_9_9)

	arg_9_0.bogieSprite = var_9_9

	local var_9_10 = var_0_0.newLabel({
		text = string.lf("宝石总数："),
		color = ccc3(255, 255, 255)
	})

	var_9_10:setPosition(800, 240)
	arg_9_0.container:addChild(var_9_10)

	arg_9_0.previewLabel_1 = var_9_10

	local var_9_11 = var_0_0.newLabel({
		text = string.lf("一级宝石总数：0"),
		color = ccc3(255, 255, 255)
	})

	var_9_11:setPosition(800, 420)
	arg_9_0.container:addChild(var_9_11)

	arg_9_0.previewLabel_2 = var_9_11

	local var_9_12 = var_0_0.newLabel({
		text = string.lf("二级宝石总数：0"),
		color = ccc3(255, 255, 255)
	})

	var_9_12:setPosition(800, 380)
	arg_9_0.container:addChild(var_9_12)

	arg_9_0.previewLabel_3 = var_9_12

	local var_9_13 = var_0_0.newLabel({
		text = string.lf("三级宝石总数：0"),
		color = ccc3(255, 255, 255)
	})

	var_9_13:setPosition(800, 340)
	arg_9_0.container:addChild(var_9_13)

	arg_9_0.previewLabel_4 = var_9_13

	local var_9_14 = var_0_0.newLabel({
		text = string.lf("可用时间：永久有效"),
		color = ccc3(255, 255, 255)
	})

	var_9_14:setAnchorPoint(ccp(0, 0.5))
	var_9_14:setPosition(95, 80)
	arg_9_0.container:addChild(var_9_14)

	arg_9_0.hoeLabel_1 = var_9_14

	local var_9_15 = var_0_0.newLabel({
		text = string.lf("正在使用：普通矿锄"),
		color = ccc3(255, 255, 255)
	})

	var_9_15:setAnchorPoint(ccp(0, 0.5))
	var_9_15:setPosition(95, 106)
	arg_9_0.container:addChild(var_9_15)

	arg_9_0.hoeLabel_2 = var_9_15

	local var_9_16 = var_0_0.newLabel({
		text = string.lf("描述：随机产出1-3级宝石"),
		color = ccc3(255, 255, 255)
	})

	var_9_16:setAnchorPoint(ccp(0, 0.5))
	var_9_16:setPosition(95, 54)
	arg_9_0.container:addChild(var_9_16)

	arg_9_0.hoeLabel_3 = var_9_16

	local var_9_17 = var_0_0.newLabel({
		text = string.lf("可用时间："),
		color = ccc3(255, 255, 255)
	})

	var_9_17:setAnchorPoint(ccp(0, 0.5))
	var_9_17:setPosition(550, 80)

	arg_9_0.bogieLabel_1 = var_9_17

	arg_9_0.container:addChild(var_9_17)

	local var_9_18 = var_0_0.newLabel({
		text = string.lf("矿石宝箱"),
		color = ccc3(255, 255, 255)
	})

	var_9_18:setAnchorPoint(ccp(0, 0.5))
	var_9_18:setPosition(550, 106)
	arg_9_0.container:addChild(var_9_18)

	local var_9_19 = var_0_0.newLabel({
		text = string.lf("描述：装载产出宝石"),
		color = ccc3(255, 255, 255)
	})

	var_9_19:setAnchorPoint(ccp(0, 0.5))
	var_9_19:setPosition(550, 54)
	arg_9_0.container:addChild(var_9_19)

	local var_9_20 = require("scenes.ProgressBar").new({
		backImage = "ui/home/home_050.png",
		percent = 1,
		barImages = {
			"ui/mineral/mineral_09.png"
		},
		barPosition = ccp(-102, 0),
		labelColor = ccc3(193, 253, 248)
	})

	var_9_20:setPosition(ccp(107, 15))

	arg_9_0.bogieProgressBar = var_9_20

	local var_9_21 = display.newSprite("ui/mineral/mineral_03.png", 660, 24)

	arg_9_0.container:addChild(var_9_21)
	var_9_21:addChild(var_9_20)

	local var_9_22 = require("scenes.ProgressBar").new({
		backImage = "ui/home/home_050.png",
		percent = 1,
		barImages = {
			"ui/mineral/mineral_09.png"
		},
		barPosition = ccp(-102, 0),
		labelColor = ccc3(193, 253, 248)
	})

	var_9_22:setPosition(ccp(107, 15))

	arg_9_0.hoeProgressBar = var_9_22

	local var_9_23 = display.newSprite("ui/mineral/mineral_03.png", 205, 24)

	arg_9_0.container:addChild(var_9_23)
	var_9_23:addChild(var_9_22)

	local var_9_24 = ui.newControlButton({
		fontSize = 22,
		normalImage = "ui/common/common_019.png",
		scaleX = 0.8,
		scaleY = 0.8,
		text = string.lf("收取"),
		clickAction = function()
			if arg_9_0.totalSeconds <= 300 then
				showFlashNotice(string.lf("上仙，没有宝石可以收取"))
			elseif #MineralHelper._allMinerals + arg_9_0.totalCount >= 900 then
				ui.showMessageBox({
					type = "dialog",
					animate = "spring",
					text = string.lf("上仙，您的宝石数量已达最大。\n请先合成后再收取。"),
					title1 = string.lf("确定")
				})
			else
				arg_9_0.getGemRequest:request()
			end
		end
	})

	var_9_24:setPosition(840, 60)
	arg_9_0.container:addChild(var_9_24)

	local var_9_25 = ui.newControlButton({
		fontSize = 22,
		normalImage = "ui/common/common_019.png",
		scaleX = 0.8,
		scaleY = 0.8,
		text = string.lf("升级"),
		clickAction = function()
			ui.showMessageBox({
				animate = "spring",
				type = "dialog",
				text = string.lf("是否花费#FFFF00150#FFFFFF元宝升级成黄金矿锄？\n升级后24小时内采矿效率大幅提升"),
				title1 = string.lf("取消"),
				title2 = string.lf("升级"),
				action2 = function()
					arg_9_0.buyHoeRequest:request()
				end
			})
		end
	})

	var_9_25:setPosition(390, 60)
	arg_9_0.container:addChild(var_9_25)
end

function var_0_1.createTimers(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = {}
	local var_15_2 = {}

	local function var_15_3()
		if arg_15_0.useTime <= 0 then
			arg_15_0.hoeLabel_1:setString(string.lf("可用时间：永久有效", formatTime(arg_15_0.useTime)))
			arg_15_0.hoeLabel_2:setString(string.lf("正在使用：普通矿锄", arg_15_0.goldHoeCount))
			arg_15_0.hoeProgressBar:setProgressPercent(1, 1)
		else
			arg_15_0.useTime = arg_15_0.useTime - 1

			arg_15_0.hoeLabel_1:setString(string.lf("可用时间：%s", formatTime(arg_15_0.useTime)))
			arg_15_0.hoeLabel_2:setString(string.lf("正在使用：黄金矿锄（%s）", arg_15_0.goldHoeCount))
			arg_15_0.hoeLabel_3:setString(string.lf("描述：产出几率大幅提升"))
			arg_15_0.hoeProgressBar:setProgressPercent(1, arg_15_0.useTime % 86400 / 86400)
		end
	end

	local function var_15_4()
		if arg_15_0.totalSeconds >= 86400 then
			arg_15_0.bogieLabel_1:setString(string.lf("宝箱已满，请及时收取"))
			arg_15_0.bogieProgressBar:setProgressPercent(1, 0)
		else
			arg_15_0.totalSeconds = arg_15_0.totalSeconds + 1

			arg_15_0.bogieLabel_1:setString(string.lf("可用时间：%s", formatTime(86400 - arg_15_0.totalSeconds)))
			arg_15_0.bogieProgressBar:setProgressPercent(1, (86400 - arg_15_0.totalSeconds) / 86400)
		end
	end

	local function var_15_5()
		if arg_15_0.totalSeconds < 300 then
			arg_15_0.previewLabel_1:setString(string.lf("宝石总数：0"))
			arg_15_0.previewLabel_2:setString(string.lf("一级宝石总数：0"))
			arg_15_0.previewLabel_3:setString(string.lf("二级宝石总数：0"))
			arg_15_0.previewLabel_4:setString(string.lf("三级宝石总数：0"))
			arg_15_0.bogieSprite:removeFromParentAndCleanup()

			local var_18_0 = display.newSprite("ui/mineral/mineral_kong.png", 550, 270)

			arg_15_0.container:addChild(var_18_0)

			arg_15_0.bogieSprite = var_18_0
		elseif arg_15_0.totalSeconds % 300 == 0 then
			arg_15_0.holeInfoRequest:request()

			if arg_15_0.totalSeconds <= 43200 then
				arg_15_0.bogieSprite:removeFromParentAndCleanup()

				local var_18_1 = display.newSprite("ui/mineral/mineral_shao.png", 550, 270)

				arg_15_0.container:addChild(var_18_1)

				arg_15_0.bogieSprite = var_18_1
			else
				arg_15_0.bogieSprite:removeFromParentAndCleanup()

				local var_18_2 = display.newSprite("ui/mineral/mineral_duo.png", 550, 270)

				arg_15_0.container:addChild(var_18_2)

				arg_15_0.bogieSprite = var_18_2
			end
		end
	end

	var_15_0.callback = var_15_3
	var_15_1.callback = var_15_4
	var_15_2.callback = var_15_5

	gParent:addToTimerTable(var_15_0)
	gParent:addToTimerTable(var_15_1)
	gParent:addToTimerTable(var_15_2)
end

return var_0_1
