require("base.figure")
require("network.EnhanceRequest")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("FragmentInfoLayer", function()
	return display.newLayer()
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0:initNetworkRequest()
	arg_2_0:refreshLayer(arg_2_1)
end

function var_0_1.initNetworkRequest(arg_3_0)
	local function var_3_0(arg_4_0)
		local function var_4_0()
			local var_5_0 = arg_3_0.exchangEquipRequest.restable
			local var_5_1 = var_0_0.createTips({
				type = var_0_0.eTypeDialog,
				show = var_0_0.eShowTeamEquip,
				id = var_5_0.Reward[1].ID
			})

			var_5_1.cancelable = true

			var_5_1:show({
				parent = CCDirector:sharedDirector():getRunningScene(),
				x = display.cx,
				y = display.cy,
				align = display.CENTER
			})

			local var_5_2 = var_5_1.container:getContentSize()
			local var_5_3 = display.newSprite("uilocal/task/task_text_002.png", var_5_2.width / 2, var_5_2.height)

			var_5_3:setAnchorPoint(CCPoint(0.5, 0.5))
			var_5_1.container:addChild(var_5_3)
			arg_3_0.recruitCallback({
				fragId = arg_3_0.fragId
			})
		end

		local var_4_1 = CCSkeletonAnimation:createWithFile("effectAni/ui_zhuangbeiqianghua.json", "effectAni/ui_zhuangbeiqianghua.atlas", 1)

		var_4_1:setAnimation("animation", false, 0)
		var_4_1:setPosition(100, arg_3_0.bgSize.height - 100)
		arg_3_0.bgSprite:addChild(var_4_1, 100)
		var_4_1:addAnimationAction("animation", 1, CCCallFunc:create(var_4_0), AAT_Percent)
	end

	arg_3_0.exchangEquipRequest = ExchangEquipRequest:new()

	arg_3_0.exchangEquipRequest:setResponseNormalHandler(var_3_0)

	local function var_3_1(arg_6_0)
		showFlashImage({
			image = "uilocal/enhance/enhance_txt_007.png",
			scale = 0.8,
			parent = arg_3_0.bgSprite,
			position = CCPoint(arg_3_0.bgSize.width / 2, arg_3_0.bgSize.height / 2 - 60),
			callback = function()
				arg_3_0.saleCallback({
					fragId = arg_3_0.fragId
				})
			end
		})
	end

	arg_3_0.sellFragmentRequest = SellFragmentRequest:new()

	arg_3_0.sellFragmentRequest:setResponseNormalHandler(var_3_1)
end

function var_0_1.refreshLayer(arg_8_0, arg_8_1)
	arg_8_0:removeAllChildrenWithCleanup(true)

	arg_8_0.fragId = arg_8_1.fragId
	arg_8_0.fragItem = BaseFragments[arg_8_0.fragId]
	arg_8_0.equipItem = BaseEquips[arg_8_0.fragItem.equipId]
	arg_8_0.recruitCallback = arg_8_1.recruitCallback
	arg_8_0.saleCallback = arg_8_1.saleCallback

	for iter_8_0, iter_8_1 in pairs(Player.fragments) do
		if iter_8_1.ID == arg_8_0.fragId then
			arg_8_0.fragItem.Type = ItemType.eFragment
			arg_8_0.fragItem.Count = iter_8_1.Count
			arg_8_0.fragItem.isInTeam = false

			break
		end
	end

	local var_8_0 = BaseEquips[arg_8_0.fragItem.equipId]
	local var_8_1 = arg_8_1.size ~= nil and arg_8_1.size or CCSize(445, 559)
	local var_8_2 = display.newScale9Sprite("ui/team/team_002.png")

	var_8_2:setPreferredSize(var_8_1)
	var_8_2:setAnchorPoint(CCPoint(0, 0))
	var_8_2:setPosition(CCPoint(506, 6))
	arg_8_0:addChild(var_8_2)

	arg_8_0.bgSprite = var_8_2
	arg_8_0.bgSize = var_8_1

	local var_8_3 = display.newScale9Sprite("ui/common/common_064_3.png", 220, 140)

	var_8_3:setPreferredSize(CCSizeMake(400, 160))
	var_8_2:addChild(var_8_3)

	local var_8_4 = figure.createHeader({
		isName = false,
		count = 0,
		inTeam = false,
		noTypeImage = false,
		itemId = arg_8_0.fragId,
		type = ItemType.eFragment
	})

	var_8_4:setPosition(100, var_8_1.height - 100)
	var_8_2:addChild(var_8_4)

	if not arg_8_0.equipItem or not arg_8_0.equipItem.profession then
		local var_8_5 = HeroProfession.eNone
	end

	local var_8_6 = arg_8_0.fragItem.quality
	local var_8_7 = arg_8_0.fragItem.exchangeCount
	local var_8_8 = arg_8_0.fragItem.price
	local var_8_9 = ui.newTTFLabelWithOutline({
		text = arg_8_0.fragItem.name,
		font = _DEFAULT_FONT,
		size = Adapter.FontSize(25),
		color = getQualityColor(var_8_6),
		align = ui.TEXT_ALIGN_LEFT
	})

	var_8_9:setAnchorPoint(ccp(0, 0.5))
	var_8_9:setPosition(ccp(180, var_8_1.height - 80))
	var_8_2:addChild(var_8_9)

	local var_8_10 = arg_8_0.fragItem.Count >= arg_8_0.fragItem.exchangeCount

	if var_8_10 then
		local var_8_11 = display.newScale9Sprite("ui/enhance/enhance_007.png", 100, 380)

		var_8_2:addChild(var_8_11)
	end

	local var_8_12 = var_8_0 and var_8_0.name or string.lf("装备")
	local var_8_13 = string.lf("%s个碎片可合成%s1个[%s]", arg_8_0.fragItem.exchangeCount, convertColorToLabelString(getQualityColor(var_8_6)), var_8_12)
	local var_8_14 = string.lf("专属: ")

	if arg_8_0.equipItem and arg_8_0.equipItem.herosId and #arg_8_0.equipItem.herosId > 0 then
		for iter_8_2, iter_8_3 in ipairs(arg_8_0.equipItem.herosId) do
			if iter_8_2 == 1 then
				var_8_14 = var_8_14 .. BaseHeros[iter_8_3].name
			else
				var_8_14 = var_8_14 .. ", " .. BaseHeros[iter_8_3].name
			end
		end
	elseif var_8_6 >= QualityType.ePurple and arg_8_0.fragItem.equipId == 0 then
		var_8_14 = var_8_14 .. string.lf("很大概率合成专属装备")
	else
		var_8_14 = var_8_14 .. string.lf("该装备不是专属装备")
	end

	local var_8_15 = var_8_0 and EquipTypeNames[var_8_0.equipType] or string.lf("未知")
	local var_8_16 = var_8_0 and HeroProfessionNames[var_8_0.profession] or string.lf("未知")
	local var_8_17 = {
		{
			fontSize = 20,
			y = 440,
			type = 1,
			x = 180,
			title = string.lf("类型: %s", var_8_15),
			color = ccc3(49, 19, 1),
			size = CCSize(200, 40)
		},
		{
			fontSize = 20,
			y = 410,
			type = 2,
			x = 180,
			title = string.lf("职业: %s", var_8_16),
			color = ccc3(49, 19, 1),
			size = CCSize(200, 40)
		},
		{
			fontSize = 20,
			y = 380,
			type = 3,
			x = 180,
			title = string.lf("拥有: %s", tostring(arg_8_0.fragItem.Count)),
			color = ccc3(49, 19, 1),
			size = CCSize(200, 40)
		},
		{
			fontSize = 20,
			y = 320,
			type = 4,
			x = 40,
			title = var_8_14,
			color = ccc3(49, 19, 1),
			size = CCSize(500, 40)
		},
		{
			fontSize = 20,
			y = 175,
			type = 5,
			x = 160,
			title = var_8_13,
			color = ccc3(255, 238, 179),
			size = CCSize(500, 40)
		},
		{
			fontSize = 20,
			y = 105,
			type = 6,
			x = 160,
			title = string.lf("售价: "),
			color = ccc3(255, 238, 179),
			size = CCSize(200, 40)
		}
	}

	for iter_8_4 = 1, #var_8_17 do
		local var_8_18 = var_8_17[iter_8_4]
		local var_8_19 = ui.newTTFLabel({
			text = var_8_18.title,
			font = _DEFAULT_FONT,
			size = Adapter.FontSize(var_8_18.fontSize),
			color = var_8_18.color,
			align = ui.TEXT_ALIGN_LEFT,
			valign = ui.TEXT_VALIGN_CENTER,
			dimensions = var_8_18.size,
			x = var_8_18.x,
			y = var_8_18.y
		})

		var_8_2:addChild(var_8_19)
		Adapter.NodeAbsScale(var_8_19)
	end

	local var_8_20 = {
		{
			y = 175,
			bgSprite = "ui/common/common_018.png",
			bgSelected = "ui/common/common_018.png",
			type = 1,
			x = 90,
			title = string.lf("合成"),
			callfunc = function()
				arg_8_0:hechengButtonPressed()
			end
		},
		{
			y = 105,
			bgSprite = "ui/common/common_018.png",
			bgSelected = "ui/common/common_018.png",
			type = 2,
			x = 90,
			title = string.lf("出售"),
			callfunc = function()
				arg_8_0:sellButtonPressed()
			end
		}
	}

	for iter_8_5, iter_8_6 in ipairs(var_8_20) do
		local var_8_21 = ui.newControlButton({
			disabledImage = "ui/common/common_079.png",
			clickAction = iter_8_6.callfunc,
			normalImage = iter_8_6.bgSprite,
			highlightedImage = iter_8_6.bgSelected,
			textColor = ColorTable.eTitleButton_Normal,
			position = ccp(iter_8_6.x, iter_8_6.y),
			text = iter_8_6.title,
			fontSize = ColorTable.eTitleButton_FontSize
		})

		if iter_8_6.type == 1 then
			var_8_21:setEnabled(var_8_10)
		end

		var_8_2:addChild(var_8_21, 0)
	end

	local var_8_22 = createItemCountNode({
		color = ccc3(255, 255, 255),
		type = ItemType.eCoin,
		value = arg_8_0.fragItem.price
	})

	var_8_22:setPosition(ccp(230, 105))
	var_8_22:setAnchorPoint(ccp(0.5, 0.5))
	var_8_2:addChild(var_8_22)
end

function var_0_1.hechengButtonPressed(arg_11_0)
	if arg_11_0.fragItem.Count >= arg_11_0.fragItem.exchangeCount then
		arg_11_0.exchangEquipRequest:request(arg_11_0.fragId)
	end
end

function var_0_1.sellButtonPressed(arg_12_0)
	var_0_0.createDialog({
		show = var_0_0.eShowPropSell,
		data = {
			id = arg_12_0.fragId,
			type = ItemType.eFragment,
			count = arg_12_0.fragItem.Count
		},
		callback = function(arg_13_0)
			arg_12_0.sellFragmentRequest:request(arg_12_0.fragId, arg_13_0)
		end
	}):show()
end

return var_0_1
