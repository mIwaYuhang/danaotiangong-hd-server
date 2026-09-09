require("network.SystemRequest")

local var_0_0 = class("TujianScene", function()
	return display.newScene("TujianScene")
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	local var_2_0 = require("scenes.CommonBgLayer").new({
		titleSprite = "uilocal/system/system_text_001.png"
	})

	arg_2_0:addChild(var_2_0)

	arg_2_0._bgSprite = var_2_0:getBackgroundSprite()

	local var_2_1 = display.newScale9Sprite("ui/team/team_065.png", 502, 287, CCSize(870, 540))

	arg_2_0._bgSprite:addChild(var_2_1)

	local var_2_2 = {
		tagPageHeros = 1,
		tagPageWeapon = 2,
		tagPageProps = 3
	}
	local var_2_3 = {
		{
			layerName = "HeroTujianLayer",
			y = 445,
			isDefault = true,
			x = -10,
			tag = var_2_2.tagPageHeros,
			titleText = string.lf("主\n将")
		},
		{
			layerName = "WeaponTujianLayer",
			y = 325,
			isDefault = false,
			x = -10,
			tag = var_2_2.tagPageWeapon,
			titleText = string.lf("法\n宝")
		}
	}

	local function var_2_4(arg_3_0, arg_3_1)
		local var_3_0 = require("scenes.system." .. var_2_3[arg_3_1].layerName).new()

		arg_3_0:addChild(var_3_0)
	end

	arg_2_0.tabLayer = require("scenes.TabLayer").new({
		isVert = true,
		selectedImage = "ui/common/common_036.png",
		normalImage = "ui/common/common_037.png",
		size = CCSize(870, 540),
		point = CCPoint(78, 40),
		labelAnchorPoint = ccp(0.3, 0.5),
		config = var_2_3,
		cellHandler = var_2_4
	})

	arg_2_0._bgSprite:addChild(arg_2_0.tabLayer)
	arg_2_0:createNetworkInterface()

	if Player.haveHerosId == nil then
		arg_2_0.tujianRequest:request()
	end

	if arg_2_1 and arg_2_1.preview then
		local var_2_5 = require("scenes.team.BaseHeroInfoLayer").new({
			id = arg_2_1.preview
		})

		arg_2_0:addChild(var_2_5)
	end
end

function var_0_0.createNetworkInterface(arg_4_0)
	local function var_4_0()
		local var_5_0 = arg_4_0.tujianRequest:getTujianInfo()

		Player.haveHerosId = string.len(var_5_0.heros) > 0 and string.split(var_5_0.heros, ",") or {}
		Player.haveEquipsId = string.len(var_5_0.talismans) > 0 and string.split(var_5_0.talismans, ",") or {}

		arg_4_0.tabLayer:reloadLayer(1)
	end

	arg_4_0.tujianRequest = TujianRequest:new()

	arg_4_0.tujianRequest:setResponseNormalHandler(var_4_0)
end

return var_0_0
