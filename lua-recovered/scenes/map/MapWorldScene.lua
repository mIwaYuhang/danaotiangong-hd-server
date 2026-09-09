require("scenes.home.HomeScene")

worldTypeInfo = {
	[WorldType.eHeaven] = {
		line = "task/line/xian_tianjie.png",
		bg = "zhangjieda_1_1.jpg",
		path = "task/map/",
		cloudSprite = {
			{
				sprite = "zhangjieda_2_1_1.png",
				pos = {
					478,
					545
				}
			},
			{
				sprite = "zhangjieda_2_1_2.png",
				pos = {
					2,
					0
				}
			},
			{
				sprite = "zhangjieda_2_1_3.png",
				pos = {
					124,
					0
				}
			}
		}
	},
	[WorldType.eLand] = {
		line = "task/line/xian_dijie.png",
		bg = "zhangjieda_1_3.jpg",
		path = "task/map/",
		cloudSprite = {
			{
				sprite = "zhangjieda_2_3_2.png",
				pos = {
					0,
					20
				}
			},
			{
				sprite = "zhangjieda_2_3_3.png",
				pos = {
					0,
					0
				}
			},
			{
				sprite = "zhangjieda_2_3_4.png",
				pos = {
					1874,
					78
				}
			}
		}
	},
	[WorldType.eDemon] = {
		line = "task/line/xian_lingjie.png",
		bg = "zhangjieda_1_2.jpg",
		path = "task/map/",
		cloudSprite = {
			{
				sprite = "zhangjieda_2_2_2.png",
				pos = {
					0,
					24
				}
			},
			{
				sprite = "zhangjieda_2_2_3.png",
				pos = {
					148,
					0
				}
			}
		}
	},
	[WorldType.eOutHeaven] = {
		line = "task/line/xian_chongtian.png",
		bg = "zhangjieda_1_4.jpg",
		path = "task/map/",
		cloudSprite = {
			{
				sprite = "zhangjieda_2_4_1.png",
				pos = {
					0,
					560
				}
			},
			{
				sprite = "zhangjieda_2_4_2.png",
				pos = {
					-25,
					260
				}
			},
			{
				sprite = "zhangjieda_2_4_3.png",
				pos = {
					10,
					0
				}
			},
			{
				sprite = "zhangjieda_2_4_4.png",
				pos = {
					1400,
					540
				}
			},
			{
				sprite = "zhangjieda_2_4_5.png",
				pos = {
					1844,
					88
				}
			},
			{
				sprite = "zhangjieda_2_4_6.png",
				pos = {
					1033,
					0
				}
			}
		}
	}
}

local var_0_0 = class("MapWorldScene", function()
	return display.newScene("MapWorldScene")
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.worldType = arg_2_1
	arg_2_0.mapLayer = require("scenes.map.MapWorldLayer").new({
		worldType = arg_2_1
	})

	arg_2_0:addChild(arg_2_0.mapLayer)
	arg_2_0:createNavBar()

	local var_2_0 = ui.newControlButton({
		fontSize = 24,
		text = "",
		normalImage = "ui/common/common_061.png",
		preferredSize = CCSize(67, 66),
		position = Adapter.AutoPos(880, 50),
		clickAction = function(arg_3_0, arg_3_1)
			game.enterHomeScene()
		end,
		anchorPoint = CCPoint(0.5, 0.5),
		scaleX = Adapter.MinScale,
		scaleY = Adapter.MinScale
	})

	Adapter.NodeAbsScale(var_2_0)
	arg_2_0:addChild(var_2_0)

	local function var_2_1(arg_4_0, arg_4_1)
		local var_4_0 = require("scenes.home.HomeTaskLayer").new({
			mapWorldScene = true,
			homeScene = arg_2_0
		})

		arg_2_0:addChild(var_4_0, DefaultZOrder.ePopupLayer)
	end

	local var_2_2 = ui.newControlButton({
		fontSize = 24,
		text = "",
		normalImage = "ui/home/home_059.png",
		position = Adapter.AutoPos(880, 580),
		clickAction = var_2_1,
		anchorPoint = CCPoint(0.5, 0.5),
		scaleX = Adapter.MinScale,
		scaleY = Adapter.MinScale
	})

	arg_2_0:addChild(var_2_2)
	setMissionStateAnimation(var_2_2)
	addObserverToNode(arg_2_0.mapLayer, function()
		setMissionStateAnimation(var_2_2)
	end, {
		PalyerEvents.eHaveTaskReward
	})
	arg_2_0:showGuideLayer()
end

function var_0_0.getWorldBgImageName(arg_6_0, arg_6_1)
	if arg_6_1 == WorldType.eHeaven then
		return "ui/map/map_l_00.png"
	elseif arg_6_1 == WorldType.eLand then
		return "ui/map/map_l_00.png"
	elseif arg_6_1 == WorldType.eDemon then
		return "ui/map/map_l_00.png"
	else
		return "ui/map/map_l_00.png"
	end
end

function var_0_0.createNavBar(arg_7_0)
	local var_7_0 = display.newSprite("ui/worldmap/worldmap_011.png", Adapter.AutoPosX(893), Adapter.AutoPosY(300))

	var_7_0:setScaleX(0.5 * Adapter.AutoScaleX)
	var_7_0:setScaleY(0.8 * Adapter.AutoScaleY)
	arg_7_0:addChild(var_7_0)

	local function var_7_1()
		print("进入重天")
		arg_7_0:removeGuideLayer(WorldType.eOutHeaven)
		game.enterMapWorldScene(WorldType.eOutHeaven)
	end

	local function var_7_2()
		arg_7_0:removeGuideLayer(WorldType.eHeaven)
		game.enterMapWorldScene(WorldType.eHeaven)
	end

	local function var_7_3()
		arg_7_0:removeGuideLayer(WorldType.eLand)
		game.enterMapWorldScene(WorldType.eLand)
	end

	local function var_7_4()
		arg_7_0:removeGuideLayer(WorldType.eDemon)
		game.enterMapWorldScene(WorldType.eDemon)
	end

	arg_7_0.buttonTable = {
		{
			normalImage = "ui/worldmap/worldmap_009.png",
			position = Adapter.AutoPos(893, 142),
			nameText = string.lf("人界"),
			scaleX = Adapter.MinScale,
			scaleY = Adapter.MinScale,
			clickAction = var_7_3
		},
		{
			normalImage = "ui/worldmap/worldmap_008.png",
			position = Adapter.AutoPos(893, 260),
			nameText = string.lf("地界"),
			scaleX = Adapter.MinScale,
			scaleY = Adapter.MinScale,
			clickAction = var_7_4
		},
		{
			normalImage = "ui/worldmap/worldmap_010.png",
			position = Adapter.AutoPos(893, 371),
			nameText = string.lf("天界"),
			scaleX = Adapter.MinScale,
			scaleY = Adapter.MinScale,
			clickAction = var_7_2
		},
		{
			normalImage = "ui/worldmap/worldmap_012.png",
			position = Adapter.AutoPos(893, 472),
			nameText = string.lf("重天"),
			scaleX = Adapter.MinScale,
			scaleY = Adapter.MinScale,
			clickAction = var_7_1
		}
	}

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.buttonTable) do
		local var_7_5 = ui.newControlButton(iter_7_1)

		arg_7_0:addChild(var_7_5)

		if iter_7_1.nameText then
			local var_7_6 = display.newSprite("ui/common/common_052.png", 46, 0)

			var_7_5:addChild(var_7_6)
			addLabelWithColorSize(var_7_5, iter_7_1.nameText, ccc3(255, 235, 190), 22, ccp(0.5, 0.5), ccp(46, 0), _FONT_LISU)
		end
	end
end

function var_0_0.showGuideLayer(arg_12_0, arg_12_1)
	if Player.currentMissionStageID and BaseStages[Player.currentMissionStageID] then
		local var_12_0 = BaseStages[Player.currentMissionStageID].chapterId
		local var_12_1 = BaseChapters[var_12_0].worldType

		if var_12_1 == arg_12_0.worldType then
			local var_12_2, var_12_3 = arg_12_0.mapLayer:getChapterBgPosition(var_12_0)

			arg_12_0.mapLayer:setCurrentChapterPosition(Player.currentMissionStageID)
			GuideLayer:showHomeGuideLayer(arg_12_0.mapLayer._mapBgSprite, ccp(var_12_2, var_12_3), arg_12_1)
		else
			local var_12_4 = arg_12_0.buttonTable[var_12_1].position

			GuideLayer:showHomeGuideLayer(arg_12_0, ccp(var_12_4.x, var_12_4.y + Adapter.MinScale * 30), arg_12_1)
		end
	end
end

function var_0_0.removeGuideLayer(arg_13_0, arg_13_1)
	if Player.currentMissionStageID and BaseStages[Player.currentMissionStageID] then
		local var_13_0 = BaseStages[Player.currentMissionStageID].chapterId

		if arg_13_1 ~= BaseChapters[var_13_0].worldType then
			GuideLayer:removeAllGuideLayer()
		end
	end
end

return var_0_0
