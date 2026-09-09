require("base.figure")
require("data.hero")

local var_0_0 = require("scenes.ToolLayer")

LINE_PER_NUMBER = 4
OFFSET_X = 200
GOODS_WEITH = 130

local var_0_1 = class("BuffStoreLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0.addPowerChangeHandler = arg_2_1.addPowerChangeHandler
	arg_2_0.bgSprite = arg_2_1.bgSprite
	arg_2_0.buyEnd = arg_2_1.buyEnd

	arg_2_0:initRequests()

	arg_2_0.selectedTag = -1

	arg_2_0:setBackground()
	arg_2_0.getBuffRequest:request()
end

function var_0_1.initRequests(arg_3_0)
	local function var_3_0()
		arg_3_0.buffList = arg_3_0.getBuffRequest:getBuffList()
		arg_3_0.buyTime = arg_3_0.getBuffRequest:getBuyTime()

		arg_3_0:showBuffGoods()
	end

	arg_3_0.getBuffRequest = GetBuffRequest:new()

	arg_3_0.getBuffRequest:setResponseNormalHandler(var_3_0)

	local function var_3_1()
		showFlashImage({
			image = "uilocal/enhance/enhance_txt_007.png",
			parent = arg_3_0,
			position = ccp(180, 180)
		})

		local var_5_0 = 0

		arg_3_0.buffList[math.floor(arg_3_0.selectedTag / LINE_PER_NUMBER) + 1].buffs[arg_3_0.selectedTag % LINE_PER_NUMBER + 1].buyState = 1

		local var_5_1 = var_5_0 + arg_3_0.buffList[math.floor(arg_3_0.selectedTag / LINE_PER_NUMBER) + 1].score
		local var_5_2 = arg_3_0.towerBuyBuffRequest:getPowerAddValue()

		arg_3_0.addPowerChangeHandler({
			power = var_5_2,
			score = var_5_1
		})

		arg_3_0.selectedTag = -1
		arg_3_0.buffList = arg_3_0.towerBuyBuffRequest:getBuffList()
		arg_3_0.buyTime = arg_3_0.towerBuyBuffRequest:getBuyTime()

		arg_3_0:showBuffGoods()
	end

	arg_3_0.towerBuyBuffRequest = TowerBuyBuffRequest:new()

	arg_3_0.towerBuyBuffRequest:setResponseNormalHandler(var_3_1)
end

function var_0_1.setBackground(arg_6_0)
	arg_6_0.contentSprite = display.newSprite("ui/tower/tower_051.png")

	arg_6_0.contentSprite:setPosition(ccp(600, 300))
	arg_6_0.bgSprite:addChild(arg_6_0.contentSprite)
end

function var_0_1.showPoints(arg_7_0)
	local var_7_0 = OFFSET_X - 110
	local var_7_1 = 122
	local var_7_2 = {
		{
			spriteName = "ui/tower/tower_033.png"
		},
		{
			spriteName = "ui/tower/tower_034.png"
		},
		{
			spriteName = "ui/tower/tower_035.png"
		}
	}

	for iter_7_0 = 1, 3 do
		local var_7_3 = display.newSprite(var_7_2[iter_7_0].spriteName)

		var_7_3:setPosition(ccp(var_7_0 - 15, (var_7_1 + 8) * iter_7_0 - 70))
		arg_7_0.contentSprite:addChild(var_7_3)
	end

	local var_7_4 = {
		{
			fontSize = 22,
			type = 1,
			title = string.lf("%s积分", arg_7_0.buffList[1].score),
			color = ccc3(234, 182, 96),
			size = CCSize(200, 40)
		},
		{
			fontSize = 22,
			type = 2,
			title = string.lf("%s积分", arg_7_0.buffList[2].score),
			color = ccc3(97, 207, 48),
			size = CCSize(200, 40)
		},
		{
			fontSize = 22,
			type = 3,
			title = string.lf("%s积分", arg_7_0.buffList[3].score),
			color = ccc3(103, 180, 224),
			size = CCSize(200, 40)
		}
	}

	for iter_7_1 = 1, arg_7_0.rowCount do
		local var_7_5 = var_7_4[iter_7_1]
		local var_7_6 = ui.newTTFLabel({
			text = var_7_5.title,
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(var_7_5.fontSize),
			align = ui.TEXT_ALIGN_LEFT,
			valign = ui.TEXT_VALIGN_CENTER,
			dimensions = var_7_5.size,
			x = var_7_0 - 40,
			y = (var_7_1 + 8) * iter_7_1 - 70
		})

		arg_7_0.contentSprite:addChild(var_7_6)
		Adapter.NodeAbsScale(var_7_6)
	end
end

function var_0_1.getBuffBoughtCount(arg_8_0)
	local var_8_0 = 0

	for iter_8_0 = 1, #arg_8_0.buffList do
		for iter_8_1, iter_8_2 in ipairs(arg_8_0.buffList[iter_8_0].buffs) do
			if iter_8_2.buyState > 0 then
				var_8_0 = var_8_0 + 1
			end
		end
	end

	return var_8_0
end

function var_0_1.showBuffGoods(arg_9_0)
	arg_9_0.rowCount = #arg_9_0.buffList

	arg_9_0.contentSprite:removeAllChildrenWithCleanup(true)

	arg_9_0.choosedBg = nil

	arg_9_0:showPoints()
	arg_9_0:setButtons()

	local var_9_0 = {
		{
			spriteName = "ui/common/common_002.png"
		},
		{
			spriteName = "ui/common/common_001.png"
		},
		{
			spriteName = "ui/common/common_003.png"
		}
	}
	local var_9_1 = {
		{
			color = ccc3(255, 255, 255)
		},
		{
			color = ccc3(255, 255, 255)
		},
		{
			color = ccc3(255, 255, 255)
		}
	}

	for iter_9_0 = 0, arg_9_0.rowCount * LINE_PER_NUMBER - 1 do
		local var_9_2 = OFFSET_X + iter_9_0 % LINE_PER_NUMBER * GOODS_WEITH
		local var_9_3 = 80 + math.floor(iter_9_0 / LINE_PER_NUMBER) * 132
		local var_9_4 = arg_9_0.buffList[math.floor(iter_9_0 / LINE_PER_NUMBER) + 1].buffs[iter_9_0 % LINE_PER_NUMBER + 1].buyState == 0
		local var_9_5 = arg_9_0.buffList[math.floor(iter_9_0 / LINE_PER_NUMBER) + 1].buffs[iter_9_0 % LINE_PER_NUMBER + 1].addtionProperty
		local var_9_6 = arg_9_0.buffList[math.floor(iter_9_0 / LINE_PER_NUMBER) + 1].buffs[iter_9_0 % LINE_PER_NUMBER + 1].addtionRate
		local var_9_7 = arg_9_0.buffList[math.floor(iter_9_0 / LINE_PER_NUMBER) + 1].buffs[iter_9_0 % LINE_PER_NUMBER + 1].addtionName
		local var_9_8 = var_9_4 and getBattleAttrsIconName(var_9_5) or "ui/common/bg_common_headgray.png"
		local var_9_9 = {
			h = 89,
			w = 89,
			tag = iter_9_0,
			x = var_9_2,
			y = var_9_3,
			image = var_9_8,
			listener = handler(arg_9_0, arg_9_0.buttonClickAction)
		}
		local var_9_10 = display.newScale9Sprite(var_9_0[math.floor(iter_9_0 / LINE_PER_NUMBER) + 1].spriteName)

		var_9_10:setPosition(var_9_9.x, var_9_9.y)
		var_9_10:setPreferredSize(CCSizeMake(77, 77))
		arg_9_0.contentSprite:addChild(var_9_10)

		local var_9_11 = ui.newControlButton({
			fontSize = 22,
			clickAction = var_9_9.listener,
			normalImage = var_9_9.image,
			highlightedImage = var_9_9.image,
			position = ccp(var_9_9.x, var_9_9.y)
		})

		var_9_11:setTag(var_9_9.tag)
		var_9_11:setPreferredSize(CCSizeMake(62, 62))
		arg_9_0.contentSprite:addChild(var_9_11, 1)

		local var_9_12 = display.newScale9Sprite("ui/tower/tower_046.png")

		var_9_12:setPosition(var_9_9.x, var_9_9.y - 55)
		var_9_12:setPreferredSize(CCSizeMake(123, 26))
		arg_9_0.contentSprite:addChild(var_9_12)

		local var_9_13 = ui.newTTFLabelWithOutline({
			text = var_9_7 .. " +" .. var_9_6 * 100 .. "%",
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(16),
			color = var_9_1[math.floor(iter_9_0 / LINE_PER_NUMBER) + 1].color,
			align = ui.TEXT_ALIGN_CENTER,
			valign = ui.TEXT_VALIGN_CENTER,
			dimensions = CCSize(200, 40),
			x = var_9_9.x,
			y = var_9_9.y - 55
		})

		arg_9_0.contentSprite:addChild(var_9_13, 1)
		Adapter.NodeAbsScale(var_9_13)
	end
end

function var_0_1.buttonClickAction(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_2:getTag()

	print("buttonTag  " .. var_10_0)

	if not (arg_10_0.buffList[math.floor(var_10_0 / LINE_PER_NUMBER) + 1].buffs[var_10_0 % LINE_PER_NUMBER + 1].buyState == 0) then
		return
	end

	if arg_10_0.buyTime <= 0 then
		local var_10_1 = string.lf("您的购买次数已经达到上限~")

		arg_10_0:addChild(require("scenes.FlashNotice").new(var_10_1))

		return
	end

	if arg_10_0.selectedTag == var_10_0 then
		arg_10_0.selectedTag = -1
	else
		arg_10_0.selectedTag = var_10_0
	end

	arg_10_0:refreshChoosedBgs()
end

function var_0_1.refreshChoosedBgs(arg_11_0)
	if arg_11_0.choosedBg then
		arg_11_0.choosedBg:setVisible(false)
	else
		arg_11_0.choosedBg = display.newScale9Sprite("ui/common/bg_choosed_cube.png")

		arg_11_0.choosedBg:setPosition(ccp(0, 0))
		arg_11_0.choosedBg:setPreferredSize(CCSizeMake(88, 88))
		arg_11_0.contentSprite:addChild(arg_11_0.choosedBg, 1)
		arg_11_0.choosedBg:setVisible(false)
	end

	if arg_11_0.selectedTag > -1 then
		local var_11_0 = arg_11_0.selectedTag

		arg_11_0.choosedBg:setPosition(ccp(OFFSET_X + var_11_0 % LINE_PER_NUMBER * GOODS_WEITH, 80 + math.floor(var_11_0 / LINE_PER_NUMBER) * 132))
		arg_11_0.choosedBg:setVisible(true)
	else
		arg_11_0.choosedBg:setVisible(false)
	end
end

function var_0_1.setButtons(arg_12_0)
	local function var_12_0(arg_13_0, arg_13_1)
		if arg_12_0.selectedTag == -1 then
			local var_13_0 = string.lf("上仙,您没有选中Buff,请选择Buff~")

			arg_12_0:addChild(require("scenes.FlashNotice").new(var_13_0))

			return
		end

		local var_13_1 = ""
		local var_13_2 = arg_12_0.selectedTag
		local var_13_3 = arg_12_0.buffList[math.floor(var_13_2 / LINE_PER_NUMBER) + 1].storeLevel
		local var_13_4 = arg_12_0.buffList[math.floor(var_13_2 / LINE_PER_NUMBER) + 1].buffs[var_13_2 % LINE_PER_NUMBER + 1].index
		local var_13_5 = var_13_1 .. string.format("%d,%d", var_13_3, var_13_4)

		arg_12_0.towerBuyBuffRequest:request(var_13_5)
	end

	local function var_12_1(arg_14_0, arg_14_1)
		arg_12_0:removeBuffStore()
	end

	local function var_12_2(arg_15_0, arg_15_1)
		local var_15_0 = require("scenes.Tower.AddedPropertyLayer").new({})

		arg_12_0:addChild(var_15_0)
	end

	local var_12_3 = {
		{
			y = -35,
			bgSprite = "ui/common/common_018.png",
			bgSelected = "ui/common/common_055.png",
			type = 1,
			x = 200,
			title = string.lf("确定"),
			callfunc = var_12_0
		},
		{
			y = -35,
			bgSprite = "ui/common/common_018.png",
			bgSelected = "ui/common/common_055.png",
			type = 2,
			x = 420,
			title = string.lf("关闭"),
			callfunc = var_12_1
		},
		{
			y = 415,
			bgSprite = "ui/tower/tower_050.png",
			bgSelected = "ui/tower/tower_050.png",
			type = 3,
			x = 580,
			title = string.lf("已加属性"),
			callfunc = var_12_2
		}
	}

	for iter_12_0, iter_12_1 in ipairs(var_12_3) do
		local var_12_4 = ui.newControlButton({
			clickAction = iter_12_1.callfunc,
			normalImage = iter_12_1.bgSprite,
			highlightedImage = iter_12_1.bgSelected,
			textColor = ColorTable.eTitleButton_Normal,
			position = ccp(iter_12_1.x, iter_12_1.y),
			text = iter_12_1.title,
			fontSize = ColorTable.eTitleButton_FontSize
		})

		arg_12_0.contentSprite:addChild(var_12_4, 1)
	end

	local var_12_5 = arg_12_0.buyTime
	local var_12_6 = ui.newTTFLabel({
		y = 420,
		x = 250,
		text = string.lf("剩余兑换次数:%s次", var_12_5),
		font = _FONT_DEFAULT,
		color = ccc3(103, 180, 224),
		size = Adapter.FontSize(22),
		align = ui.TEXT_ALIGN_LEFT,
		valign = ui.TEXT_VALIGN_CENTER,
		dimensions = CCSize(200, 40)
	})

	arg_12_0.contentSprite:addChild(var_12_6)
	Adapter.NodeAbsScale(var_12_6)
end

function var_0_1.removeBuffStore(arg_16_0)
	local var_16_0 = arg_16_0.buyTime

	arg_16_0:buyEnd({
		buyTime = var_16_0
	})
	arg_16_0.contentSprite:removeFromParentAndCleanup(true)
	arg_16_0:removeFromParentAndCleanup(true)
end

return var_0_1
