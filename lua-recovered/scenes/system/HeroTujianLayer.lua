require("base.figure")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("HeroTujianLayer", function()
	return display.newLayer()
end)
local var_0_2 = {}

for iter_0_0, iter_0_1 in pairs(BaseHeros) do
	table.insert(var_0_2, iter_0_0)
end

local function var_0_3(arg_2_0, arg_2_1)
	if BaseHeros[arg_2_0].quality > BaseHeros[arg_2_1].quality then
		return true
	elseif BaseHeros[arg_2_0].quality < BaseHeros[arg_2_1].quality then
		return false
	end

	if BaseHeros[arg_2_0].profession > BaseHeros[arg_2_1].profession then
		return true
	elseif BaseHeros[arg_2_0].profession < BaseHeros[arg_2_1].profession then
		return false
	end

	return false
end

table.sort(var_0_2, var_0_3)

local var_0_4 = {}
local var_0_5 = 32
local var_0_6 = 1

function var_0_1.ctor(arg_3_0)
	arg_3_0._BaseHeroLightKeyTable = {}

	if Player.haveHerosId then
		for iter_3_0, iter_3_1 in ipairs(Player.haveHerosId) do
			arg_3_0._BaseHeroLightKeyTable[tonumber(iter_3_1)] = 1
		end
	end

	local var_3_0 = {
		tagPageShushi = 4,
		tagPageZhanshen = 3,
		tagPageTongshuai = 2,
		tagPageQuanbu = 1
	}
	local var_3_1 = {
		{
			x = 440,
			isDefault = true,
			tag = var_3_0.tagPageQuanbu,
			titleText = string.lf("全部"),
			normalImage = getQualityButtonImage(QualityType.eOrange)[1],
			highlightedImage = getQualityButtonImage(QualityType.eOrange)[2]
		},
		{
			x = 550,
			isDefault = false,
			tag = var_3_0.tagPageTongshuai,
			titleText = HeroProfessionNames[HeroProfession.eCommander],
			eType = HeroProfession.eCommander,
			normalImage = getQualityButtonImage(QualityType.ePurple)[1],
			highlightedImage = getQualityButtonImage(QualityType.ePurple)[2]
		},
		{
			x = 660,
			isDefault = false,
			tag = var_3_0.tagPageZhanshen,
			titleText = HeroProfessionNames[HeroProfession.eWarrior],
			eType = HeroProfession.eWarrior,
			normalImage = getQualityButtonImage(QualityType.eBlue)[1],
			highlightedImage = getQualityButtonImage(QualityType.eBlue)[2]
		},
		{
			x = 770,
			isDefault = false,
			tag = var_3_0.tagPageShushi,
			titleText = HeroProfessionNames[HeroProfession.eMage],
			eType = HeroProfession.eMage,
			normalImage = getQualityButtonImage(QualityType.eGreen)[1],
			highlightedImage = getQualityButtonImage(QualityType.eGreen)[2]
		}
	}

	local function var_3_2(arg_4_0, arg_4_1)
		local var_4_0 = arg_3_0:showSubPageContentLayer(var_3_1[arg_4_1].eType)

		arg_4_0:addChild(var_4_0)
	end

	arg_3_0.tabLayer = require("scenes.TabLayer").new({
		selectedImage = "ui/common/common_034.png",
		normalImage = "ui/common/common_035.png",
		size = CCSize(860, 465),
		point = CCPoint(20, 0),
		config = var_3_1,
		cellHandler = var_3_2
	})

	arg_3_0:addChild(arg_3_0.tabLayer)

	local var_3_3 = Player.haveHerosId and #Player.haveHerosId or 0

	arg_3_0.heroNumLabel = ui.newTTFLabel({
		y = 485,
		x = 10,
		text = string.lf("拥有的主将数量: %s", var_3_3),
		size = Adapter.FontSize(20),
		color = ccc3(255, 255, 213),
		align = ui.TEXT_ALIGN_CENTER,
		valign = ui.TEXT_VALIGN_CENTER
	})

	arg_3_0.heroNumLabel:setAnchorPoint(ccp(0, 0.5))
	arg_3_0:addChild(arg_3_0.heroNumLabel)

	local var_3_4 = ui.newTTFLabel({
		y = 485,
		x = 315,
		text = string.lf("选择查看主将类型:"),
		size = Adapter.FontSize(20),
		color = ccc3(17, 60, 249),
		align = ui.TEXT_ALIGN_CENTER,
		valign = ui.TEXT_VALIGN_CENTER
	})

	var_3_4:setAnchorPoint(ccp(0.5, 0.5))
	arg_3_0:addChild(var_3_4)
end

function var_0_1.showSubPageContentLayer(arg_5_0, arg_5_1)
	local var_5_0 = display.newNode()

	arg_5_0:fillterNeedDispalayItem(arg_5_1)

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
			return var_0_6
		end,
		cellHandler = function(arg_7_0, arg_7_1)
			local var_7_0 = (arg_7_1 - 1) * var_0_5 + 1
			local var_7_1 = arg_7_1 * var_0_5
			local var_7_2 = 1
			local var_7_3 = 8
			local var_7_4 = 105
			local var_7_5 = 115

			for iter_7_0 = var_7_0, var_7_1 do
				local var_7_6 = math.ceil(var_7_2 / 8)
				local var_7_7 = (var_7_2 - 1) % 8 * var_7_4 + 50
				local var_7_8 = (4 - var_7_6 + 0.6) * var_7_5 + 15

				if iter_7_0 <= #var_0_4 then
					local var_7_9 = var_0_4[iter_7_0]
					local var_7_10 = figure.createHeader({
						isName = true,
						type = ItemType.eHero,
						itemId = var_7_9,
						nameColor = ccc3(0, 0, 0),
						clickAction = function(arg_8_0, arg_8_1)
							local var_8_0 = require("scenes.team.BaseHeroInfoLayer").new({
								id = var_7_9
							})

							display.getRunningScene():addChild(var_8_0)
						end
					})

					if arg_5_0._BaseHeroLightKeyTable[var_7_9] ~= 1 then
						var_7_10:setHeaderOpacity(140)
					end

					var_7_10.nameLabel:setPosition(var_7_7, var_7_8 - 53)
					var_7_10.qualitySprite:setPosition(var_7_7, var_7_8)
					var_7_10.headerButton:setPosition(var_7_7, var_7_8)
					arg_7_0:addChild(var_7_10)
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
	var_0_0.createDialog({
		player = false,
		show = var_0_0.eShowTujianHero,
		id = arg_9_1
	}):show()
end

function var_0_1.fillterNeedDispalayItem(arg_10_0, arg_10_1)
	var_0_4 = {}

	if arg_10_1 == nil then
		var_0_4 = var_0_2
		var_0_6 = math.ceil(#var_0_4 / var_0_5)

		return
	end

	for iter_10_0, iter_10_1 in ipairs(var_0_2) do
		if BaseHeros[iter_10_1].profession == arg_10_1 then
			table.insert(var_0_4, iter_10_1)
		end
	end

	var_0_6 = math.ceil(#var_0_4 / var_0_5)
end

function var_0_1.reloadLayer(arg_11_0)
	arg_11_0._BaseHeroLightKeyTable = {}

	if Player.haveHerosId then
		for iter_11_0, iter_11_1 in ipairs(Player.haveHerosId) do
			arg_11_0._BaseHeroLightKeyTable[tonumber(iter_11_1)] = 1
		end
	end

	arg_11_0.heroNumLabel:setString(string.lf("拥有的主将数量: %s", #Player.haveHerosId))
	arg_11_0.tabLayer:reloadLayer(1)
end

return var_0_1
