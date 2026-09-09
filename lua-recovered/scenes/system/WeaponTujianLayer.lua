require("base.figure")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("WeaponTujianLayer", function()
	return display.newLayer()
end)
local var_0_2 = {
	tagPageShenqi = 2,
	tagPagePeishi = 4,
	tagPageYiguan = 3,
	tagPageQuanbu = 1
}
local var_0_3 = {
	{
		x = 440,
		isDefault = true,
		tag = var_0_2.tagPageQuanbu,
		titleText = string.lf("全部"),
		normalImage = getQualityButtonImage(QualityType.eOrange)[1],
		highlightedImage = getQualityButtonImage(QualityType.eOrange)[2]
	},
	{
		x = 550,
		isDefault = false,
		tag = var_0_2.tagPageShenqi,
		titleText = string.lf("神器"),
		normalImage = getQualityButtonImage(QualityType.ePurple)[1],
		highlightedImage = getQualityButtonImage(QualityType.ePurple)[2]
	},
	{
		x = 660,
		isDefault = false,
		tag = var_0_2.tagPageYiguan,
		titleText = string.lf("衣冠"),
		normalImage = getQualityButtonImage(QualityType.eBlue)[1],
		highlightedImage = getQualityButtonImage(QualityType.eBlue)[2]
	},
	{
		x = 770,
		isDefault = false,
		tag = var_0_2.tagPagePeishi,
		titleText = string.lf("佩饰"),
		normalImage = getQualityButtonImage(QualityType.eGreen)[1],
		highlightedImage = getQualityButtonImage(QualityType.eGreen)[2]
	}
}
local var_0_4 = {
	[EquipType.eWeapon] = 2,
	[EquipType.eAmulet] = 2,
	[EquipType.eHelmet] = 3,
	[EquipType.eClothes] = 3,
	[EquipType.eNecklace] = 4,
	[EquipType.eRing] = 4
}
local var_0_5 = {
	{}
}

for iter_0_0, iter_0_1 in ipairs(BaseEquips) do
	local var_0_6 = var_0_4[iter_0_1.equipType]

	if var_0_5[var_0_6] == nil then
		var_0_5[var_0_6] = {}
	end

	table.insert(var_0_5[1], iter_0_0)
	table.insert(var_0_5[var_0_6], iter_0_0)
end

local function var_0_7(arg_2_0, arg_2_1)
	if BaseEquips[arg_2_0].quality > BaseEquips[arg_2_1].quality then
		return true
	elseif BaseEquips[arg_2_0].quality < BaseEquips[arg_2_1].quality then
		return false
	end

	if BaseEquips[arg_2_0].profession > BaseEquips[arg_2_1].profession then
		return true
	elseif BaseEquips[arg_2_0].profession < BaseEquips[arg_2_1].profession then
		return false
	end

	return false
end

table.sort(var_0_5[1], var_0_7)
table.sort(var_0_5[2], var_0_7)
table.sort(var_0_5[3], var_0_7)
table.sort(var_0_5[4], var_0_7)

function var_0_1.ctor(arg_3_0)
	arg_3_0._BaseEquipLightKeyTable = {}

	if Player.haveEquipsId then
		for iter_3_0, iter_3_1 in ipairs(Player.haveEquipsId) do
			arg_3_0._BaseEquipLightKeyTable[tonumber(iter_3_1)] = 1
		end
	end

	local function var_3_0(arg_4_0, arg_4_1)
		local var_4_0 = arg_3_0:showSubPageContentLayer(arg_4_1)

		arg_4_0:addChild(var_4_0)
	end

	local var_3_1 = require("scenes.TabLayer").new({
		selectedImage = "ui/common/common_034.png",
		normalImage = "ui/common/common_035.png",
		size = CCSize(860, 465),
		point = CCPoint(20, 0),
		config = var_0_3,
		cellHandler = var_3_0
	})

	arg_3_0:addChild(var_3_1)

	local var_3_2 = Player.haveEquipsId and #Player.haveEquipsId or 0

	arg_3_0.equipNumLabel = ui.newTTFLabel({
		y = 485,
		x = 10,
		text = string.lf("拥有的装备数量: %s", var_3_2),
		size = Adapter.FontSize(20),
		color = ccc3(255, 255, 213),
		align = ui.TEXT_ALIGN_CENTER,
		valign = ui.TEXT_VALIGN_CENTER
	})

	arg_3_0.equipNumLabel:setAnchorPoint(ccp(0, 0.5))
	arg_3_0:addChild(arg_3_0.equipNumLabel)

	local var_3_3 = ui.newTTFLabel({
		y = 485,
		x = 315,
		text = string.lf("选择查看法宝类型:"),
		size = Adapter.FontSize(20),
		color = ccc3(17, 60, 249),
		align = ui.TEXT_ALIGN_CENTER,
		valign = ui.TEXT_VALIGN_CENTER
	})

	var_3_3:setAnchorPoint(ccp(0.5, 0.5))
	arg_3_0:addChild(var_3_3)
end

function var_0_1.showSubPageContentLayer(arg_5_0, arg_5_1)
	local var_5_0 = display.newNode()
	local var_5_1 = 8
	local var_5_2 = 105
	local var_5_3 = 115
	local var_5_4 = 32
	local var_5_5 = math.ceil(#var_0_5[arg_5_1] / var_5_4)
	local var_5_6 = var_0_5[arg_5_1]

	arg_5_0._sliderLayer = require("scenes.SliderLayer").new({
		navOnSprite = "ui/common/common_048.png",
		navOffSprite = "ui/common/common_047.png",
		navMargin = 30,
		size = CCSizeMake(830, 475),
		clipScaleX = Adapter.MinScale,
		clipScaleY = Adapter.MinScale,
		point = ccp(-10, -10),
		navPosition = ccp(200, 5),
		numberHandler = function()
			return var_5_5
		end,
		cellHandler = function(arg_7_0, arg_7_1)
			local var_7_0 = (arg_7_1 - 1) * var_5_4 + 1
			local var_7_1 = arg_7_1 * var_5_4
			local var_7_2 = 1

			for iter_7_0 = var_7_0, var_7_1 do
				if iter_7_0 <= #var_5_6 then
					local var_7_3 = math.ceil(var_7_2 / 8)
					local var_7_4 = (var_7_2 - 1) % 8 * var_5_2 + 50
					local var_7_5 = (4 - var_7_3 + 0.6) * var_5_3 + 15
					local var_7_6 = var_5_6[iter_7_0]
					local var_7_7 = figure.createHeader({
						isName = true,
						type = ItemType.eEquip,
						itemId = var_7_6,
						equipType = BaseEquips[var_7_6].equipType,
						nameColor = ccc3(0, 0, 0),
						clickAction = function(arg_8_0, arg_8_1)
							arg_8_1 = tolua.cast(arg_8_1, "CCControlButton")

							arg_5_0:createTipsView(var_7_6, arg_8_1, arg_5_0)
						end
					})

					if arg_5_0._BaseEquipLightKeyTable[var_7_6] ~= 1 then
						var_7_7:setHeaderOpacity(140)
					end

					var_7_7.nameLabel:setPosition(var_7_4, var_7_5 - 53)
					var_7_7.qualitySprite:setPosition(var_7_4, var_7_5)
					var_7_7.headerButton:setPosition(var_7_4, var_7_5)
					arg_7_0:addChild(var_7_7)
				end

				var_7_2 = var_7_2 + 1
			end
		end
	})

	var_5_0:addChild(arg_5_0._sliderLayer)
	arg_5_0._sliderLayer:reloadData()

	return var_5_0
end

function var_0_1.createTipsView(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	var_0_0.createTips({
		show = var_0_0.eShowTeamEquip,
		id = arg_9_1
	}):show({
		adjust = true,
		parent = arg_9_3,
		node = arg_9_2
	})
end

function var_0_1.reloadLayer(arg_10_0)
	arg_10_0._BaseEquipLightKeyTable = {}

	if Player.haveEquipsId then
		for iter_10_0, iter_10_1 in ipairs(Player.haveEquipsId) do
			arg_10_0._BaseEquipLightKeyTable[tonumber(iter_10_1)] = 1
		end
	end

	arg_10_0.equipNumLabel:setString(string.lf("拥有的装备数量: %s", #Player.haveEquipsId))
	arg_10_0.tabLayer:reloadLayer(1)
end

return var_0_1
