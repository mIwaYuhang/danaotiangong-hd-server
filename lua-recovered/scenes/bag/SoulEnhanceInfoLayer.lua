require("base.figure")
require("network.EnhanceRequest")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("SoulEnhanceInfoLayer", function()
	return display.newLayer()
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0:initNetworkRequest()
	arg_2_0:refreshLayer(arg_2_1)
end

function var_0_1.initNetworkRequest(arg_3_0)
	local function var_3_0(arg_4_0)
		local function var_4_0()
			local var_5_0 = var_0_0.createDialog({
				show = var_0_0.eShowTujianHero,
				id = arg_3_0.soul.figureId
			})

			var_5_0:show()

			local var_5_1 = var_5_0.container:getContentSize()
			local var_5_2 = display.newSprite("uilocal/task/task_text_002.png", var_5_1.width * 0.2, var_5_1.height)

			var_5_2:setAnchorPoint(CCPoint(0.5, 0.5))
			var_5_0.container:addChild(var_5_2)
			arg_3_0.callback(arg_3_0.soul.figureId)
		end

		local var_4_1 = CCSkeletonAnimation:createWithFile("effectAni/ui_zhuangbeiqianghua.json", "effectAni/ui_zhuangbeiqianghua.atlas", 1)

		var_4_1:setAnimation("animation", false, 0)
		var_4_1:setPosition(arg_3_0.headerSize.width / 2, arg_3_0.headerSize.height / 2)
		arg_3_0.headerBack:addChild(var_4_1, 100)
		var_4_1:addAnimationAction("animation", 1, CCCallFunc:create(var_4_0), AAT_Percent)
	end

	arg_3_0.recruitRequest = FigureRecruitRequest:new()

	arg_3_0.recruitRequest:setResponseNormalHandler(var_3_0)
end

function var_0_1.refreshLayer(arg_6_0, arg_6_1)
	arg_6_0:removeAllChildrenWithCleanup(true)

	arg_6_0.soulId = arg_6_1.ID
	arg_6_0.count = arg_6_1.Count
	arg_6_0.callback = arg_6_1.callback
	arg_6_0.soul = BaseSouls[arg_6_0.soulId]
	arg_6_0.figureName = getItemName(ItemType.eSoul, arg_6_1.ID)

	local var_6_0 = CCSize(445, 559)
	local var_6_1 = display.newScale9Sprite("ui/team/team_002.png")

	var_6_1:setPreferredSize(var_6_0)
	var_6_1:setAnchorPoint(CCPoint(0, 0))
	var_6_1:setPosition(CCPoint(506, 6))
	arg_6_0:addChild(var_6_1)

	local var_6_2 = display.newSprite("ui/enhance/enhance_006.png")

	var_6_2:setAnchorPoint(CCPoint(0, 1))
	var_6_2:setPosition(20, var_6_0.height - 40)
	var_6_1:addChild(var_6_2)

	arg_6_0.headerBack = var_6_2
	arg_6_0.headerSize = var_6_2:getContentSize()

	local var_6_3 = figure.createHeader({
		isName = false,
		count = 0,
		inTeam = false,
		noTypeImage = false,
		itemId = arg_6_0.soul.figureId,
		type = ItemType.eHero
	})

	var_6_3:setAnchorPoint(CCPoint(0.5, 0.5))
	var_6_3:setPosition(arg_6_0.headerSize.width / 2, arg_6_0.headerSize.height / 2)
	var_6_2:addChild(var_6_3)

	figureQuality = BaseHeros[arg_6_0.soul.figureId].quality
	profession = BaseHeros[arg_6_0.soul.figureId].profession
	desc = BaseHeros[arg_6_0.soul.figureId].desc
	soulCount = BaseHeros[arg_6_0.soul.figureId].soulCount

	if arg_6_0:isFigureExist(arg_6_0.soul.figureId) == true then
		local var_6_4 = createMarkLabel({
			text = string.lf("已拥有")
		})

		var_6_4:setAnchorPoint(CCPoint(0, 1))
		var_6_4:setPosition(CCPoint(4, var_6_0.height - 5))
		var_6_1:addChild(var_6_4)
	elseif arg_6_0.count >= soulCount then
		local var_6_5 = display.newScale9Sprite("ui/enhance/enhance_000.png", 100, 360)

		var_6_1:addChild(var_6_5)
	end

	local var_6_6 = ui.newTTFLabelWithOutline({
		text = arg_6_0.figureName,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(25),
		color = getQualityColor(figureQuality),
		align = ui.TEXT_ALIGN_LEFT
	})

	var_6_6:setAnchorPoint(ccp(0, 0.5))
	var_6_6:setPosition(ccp(200, 480))
	var_6_1:addChild(var_6_6)

	local var_6_7 = display.newSprite("ui/common/common_soul_big.png", 380, 470)

	var_6_1:addChild(var_6_7)

	local var_6_8 = {
		string.lf("品质: %s", getQualityName(figureQuality)),
		profession and string.lf("职业: %s", HeroProfessionNames[profession]),
		string.lf("拥有数量: %d", arg_6_0.count)
	}
	local var_6_9 = 1

	for iter_6_0 = 1, table.getn(var_6_8) do
		if var_6_8[iter_6_0] ~= nil then
			local var_6_10 = ui.newTTFLabel({
				text = var_6_8[iter_6_0],
				font = _FONT_DEFAULT,
				size = Adapter.FontSize(20),
				color = ccc3(112, 36, 0),
				align = ui.TEXT_ALIGN_LEFT
			})

			var_6_10:setAnchorPoint(ccp(0, 0.5))
			var_6_10:setPosition(ccp(200, 460 - var_6_9 * 30))
			var_6_1:addChild(var_6_10)

			var_6_9 = var_6_9 + 1
		end
	end

	local var_6_11 = ui.newTTFLabel({
		text = desc,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(20),
		color = display.COLOR_BLACK,
		align = ui.TEXT_ALIGN_LEFT,
		valign = ui.TEXT_VALIGN_TOP,
		dimensions = CCSize(360, 150)
	})

	var_6_11:setAnchorPoint(ccp(0.5, 0.5))
	var_6_11:setPosition(ccp(var_6_0.width / 2, 250))
	var_6_1:addChild(var_6_11)

	local var_6_12 = display.newSprite("ui/common/common_064_4.png")
	local var_6_13 = var_6_12:getContentSize()

	var_6_12:setAnchorPoint(CCPoint(0.5, 0))
	var_6_12:setPosition(var_6_0.width / 2, 40)
	var_6_1:addChild(var_6_12)

	local var_6_14 = var_6_13.height / 2
	local var_6_15 = ui.newControlButton({
		disabledImage = "ui/common/common_079.png",
		normalImage = "ui/common/common_018.png",
		text = string.lf("招募"),
		textColor = ColorTable.eTitleButton_Normal,
		fontSize = ColorTable.eTitleButton_FontSize,
		anchorPoint = CCPoint(0.5, 0.5),
		position = CCPoint(100, var_6_14),
		clickAction = function()
			if arg_6_0:isFigureExist(arg_6_0.soul.figureId) == true then
				showFlashNotice(string.lf("该魂魄对应的主将已经存在，不能招募！"))
			else
				arg_6_0.recruitRequest:request(arg_6_0.soulId)
			end
		end
	})

	var_6_15:setEnabled(arg_6_0.count >= soulCount and true or false)
	var_6_12:addChild(var_6_15)

	local var_6_16 = addLabelWithColorSize(var_6_12, string.lf("拥有#E7B85A %d #F3DB97个魂魄可招募一个同名主将。", soulCount), ccc3(243, 216, 151), 20, CCPoint(0, 0.5), CCPoint(160, var_6_14))

	var_6_16:setDimensions(CCSize(230, 60))
	var_6_16:setHorizontalAlignment(kCCTextAlignmentLeft)
	var_6_16:setVerticalAlignment(kCCVerticalTextAlignmentCenter)
end

function var_0_1.isFigureExist(arg_8_0, arg_8_1)
	local var_8_0 = false

	for iter_8_0, iter_8_1 in pairs(Player.ownedHeros) do
		if iter_8_1.heroId == arg_8_1 then
			var_8_0 = true

			break
		end
	end

	return var_8_0
end

return var_0_1
