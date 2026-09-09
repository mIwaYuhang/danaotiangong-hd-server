require("network.RankingRequest")

local var_0_0 = require("base.cache")
local var_0_1 = class("RankingLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

function var_0_1.ctor(arg_2_0)
	arg_2_0:init()
end

function var_0_1.create(arg_3_0)
	return (var_0_1:new())
end

function var_0_1.init(arg_4_0)
	local var_4_0 = display.newSprite("ui/common/common_040.png", display.cx, display.cy)

	var_4_0:setScale(Adapter.MinScale * 0.9)
	arg_4_0:addChild(var_4_0)

	local var_4_1 = display.newSprite("uilocal/fuben/zszz_text_050.png")

	var_4_1:setAnchorPoint(ccp(0, 0.5))
	var_4_1:setPosition(40, 600)
	var_4_0:addChild(var_4_1)

	local var_4_2 = addLabelWithColorSize(var_4_0, string.lf("排行榜每日晚12点刷新"), ccc3(255, 255, 255), 24, ccp(0, 0.5), ccp(630, 550))

	local function var_4_3()
		var_0_0.set("zhiZunBang_info", nil)
		var_0_0.set("zhanShenBang_info", nil)
		var_0_0.set("xianYuanBang_info", nil)
		var_0_0.set("fuHaoBang_info", nil)
		var_0_0.set("jiFenBang_info", nil)
		arg_4_0:removeFromParent()
	end

	local var_4_4 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		position = ccp(900, 600),
		clickAction = var_4_3
	})

	var_4_0:addChild(var_4_4)

	arg_4_0.bgTable = display.newScale9Sprite("ui/team/team_065.png")

	arg_4_0.bgTable:setPosition(480, 270)
	arg_4_0.bgTable:setPreferredSize(CCSize(935.0000000000001, 517))
	var_4_0:addChild(arg_4_0.bgTable)

	local var_4_5 = {
		etagXianYuan = 3,
		etagZhiZun = 2,
		etagZhanShen = 1
	}
	local var_4_6 = {
		{
			layerName = "BangLayer",
			y = 520,
			isDefault = true,
			titleSize = 20,
			x = 40,
			tag = var_4_5.etagZhanShen,
			titleText = string.lf("至尊榜")
		},
		{
			layerName = "BangLayer",
			y = 520,
			isDefault = false,
			titleSize = 20,
			x = 150,
			tag = var_4_5.etagZhiZun,
			titleText = string.lf("战神榜")
		},
		{
			layerName = "BangLayer",
			y = 520,
			isDefault = false,
			titleSize = 20,
			x = 260,
			tag = var_4_5.etagXianYuan,
			titleText = string.lf("仙缘榜")
		}
	}

	if Player.isRichRankDisplay == 1 then
		var_4_5.etagFuHao = 4
		var_4_6[4] = {
			layerName = "BangLayer",
			y = 520,
			isDefault = false,
			titleSize = 20,
			x = 370,
			tag = var_4_5.etagFuHao,
			titleText = string.lf("富豪榜")
		}
	end

	if Player.isJiFenRankDisplay == 1 then
		var_4_5.etagJiFen = 5
		var_4_6[5] = {
			layerName = "BangLayer",
			y = 520,
			isDefault = false,
			titleSize = 20,
			x = 370,
			tag = var_4_5.etagJiFen,
			titleText = string.lf("寻仙榜")
		}

		if Player.isRichRankDisplay == 1 then
			var_4_6[5].x = 480
		end
	end

	local function var_4_7(arg_6_0, arg_6_1)
		if arg_6_1 == 4 then
			var_4_2:setString("本榜即时刷新")
		else
			var_4_2:setString("排行榜每日晚12点刷新")
		end

		arg_4_0.dataLayer = require("scenes.home." .. var_4_6[arg_6_1].layerName).new(arg_6_1)

		arg_6_0:addChild(arg_4_0.dataLayer)
	end

	arg_4_0.tabLayer = require("scenes.TabLayer").new({
		selectedImage = "ui/common/common_034.png",
		normalImage = "ui/common/common_035.png",
		size = CCSize(880, 620),
		point = ccp(15, 0),
		config = var_4_6,
		cellHandler = var_4_7
	})

	arg_4_0.bgTable:addChild(arg_4_0.tabLayer)

	arg_4_0.container = var_4_0

	arg_4_0:addTouchEventListener(handler(arg_4_0, arg_4_0.touchhandler), false, 1, true)
	arg_4_0:setTouchEnabled(true)
end

function var_0_1.touchhandler(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_1 == "began" then
		return true
	end
end

return var_0_1
