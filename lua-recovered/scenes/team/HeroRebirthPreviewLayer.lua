require("base.figure")

local var_0_0 = require("scenes.team.DlgBreakThroughLayer")
local var_0_1 = class("HeroRebirthPreviewLayer", function()
	return CCLayerColor:create(ccc4(10, 10, 10, 160))
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0.heroId = arg_2_1.heroId
	arg_2_0.curIndex = arg_2_1.curIndex
	arg_2_0.closeCallback = arg_2_1.closeCallback
	arg_2_0.isFromTeam = arg_2_1.isFromTeam or false
	arg_2_0.returnAction = arg_2_1.returnAction

	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	local var_2_0 = display.newSprite("ui/team/team_115.png")

	var_2_0:setScale(Adapter.MinScale)
	var_2_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_0:setPosition(display.cx, display.cy)
	arg_2_0:addChild(var_2_0)

	arg_2_0.background = var_2_0

	local var_2_1 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		highlightedImage = "ui/common/btn_closed.png",
		position = CCPoint(858, 578),
		clickAction = function()
			arg_2_0:removeFromParent()
		end
	})

	arg_2_0.background:addChild(var_2_1)

	local var_2_2 = display.newSprite("uilocal/team/team_text_041.png", 372, 561)

	arg_2_0.background:addChild(var_2_2)
	arg_2_0:showHeroFigure()
	arg_2_0:showHeroAttrs()
	arg_2_0:showObtainButtons()

	if Player:getTroMaxStep() == NSStep.TempStepID then
		GuideLayer:showNewbieGuideLayer(nil, arg_2_0.background, 181, function()
			if arg_2_0.closeCallback then
				arg_2_0.closeCallback()
			end

			arg_2_0:removeFromParentAndCleanup(true)
		end, nil, nil, true)
	end
end

function var_0_1.showHeroFigure(arg_6_0)
	local var_6_0 = {
		{
			bottomImage = "uilocal/team/team_text_039.png",
			backImage = "ui/team/team_114.png",
			rebirthCount = 1,
			pos = ccp(169, 328)
		},
		{
			bottomImage = "uilocal/team/team_text_040.png",
			backImage = "ui/team/team_113.png",
			rebirthCount = 12,
			pos = ccp(704, 328)
		}
	}

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = display.newSprite(iter_6_1.backImage)

		var_6_1:setPosition(iter_6_1.pos)
		arg_6_0.background:addChild(var_6_1)

		local var_6_2 = display.newSprite(iter_6_1.bottomImage)

		var_6_2:setPosition(iter_6_1.pos.x, iter_6_1.pos.y - 176)
		arg_6_0.background:addChild(var_6_2)

		local var_6_3 = {
			isViewQuality = true,
			isViewBaseInfo = false,
			scale = 0.7,
			figId = arg_6_0.heroId,
			equipId = getHeroGroupWeaponId(arg_6_0.heroId),
			pinjie = EquipPinjieType.eShengPin,
			rebirthCount = iter_6_1.rebirthCount
		}
		local var_6_4 = figure.createHero(var_6_3)

		var_6_4:setAnchorPoint(CCPoint(0.5, 0.5))
		var_6_4:setPosition(iter_6_1.pos.x, iter_6_1.pos.y - 121)
		arg_6_0.background:addChild(var_6_4)
	end
end

function var_0_1.showObtainButtons(arg_7_0)
	local var_7_0 = arg_7_0.returnAction
	local var_7_1 = ui.newTTFLabel({
		y = 63,
		x = 25,
		text = string.lf("+4#CA4B1F以后需要同名魂,可以通过以下途径获得:"),
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(20),
		color = ccc3(247, 253, 86),
		dimensions = CCSize(210, 50)
	})

	arg_7_0.background:addChild(var_7_1)

	local var_7_2 = {}
	local var_7_3 = BaseHeros[arg_7_0.heroId].dropChapterId

	if var_7_3 > 0 then
		table.insert(var_7_2, {
			image = "ui/team/team_120.png",
			func = function(arg_8_0, arg_8_1)
				Player.currentTaskEntryType = TaskEntryType.CheckPoint
				Player.currentTaskStep = 2
				Player.currentMissionStageID = var_7_3
				Player.taskEntryCheckPointType = TaskEntryCheckPointType.eNone

				local var_8_0 = arg_7_0.curIndex
				local var_8_1 = arg_7_0.isFromTeam

				game.enterMapChapterScene({
					stageId = var_7_3,
					returnAction = function(arg_9_0, arg_9_1)
						if var_8_1 == true then
							game.enterTeamScene({
								isShowRebirth = true,
								index = var_8_0
							})
						elseif var_7_0 then
							var_7_0()
						else
							game.enterHeroScene()
						end
					end
				})
			end
		})
	end

	table.insert(var_7_2, {
		image = "ui/team/team_116.png",
		func = function(arg_10_0, arg_10_1)
			local var_10_0 = arg_7_0.curIndex
			local var_10_1 = arg_7_0.isFromTeam

			game.enterStoreScene({
				returnAction = function(arg_11_0, arg_11_1)
					if var_10_1 == true then
						game.enterTeamScene({
							isShowRebirth = true,
							index = var_10_0
						})
					elseif var_7_0 then
						var_7_0()
					else
						game.enterHeroScene()
					end
				end
			})
		end
	})
	table.insert(var_7_2, {
		image = "ui/team/team_117.png",
		func = function(arg_12_0, arg_12_1)
			local var_12_0 = arg_7_0.curIndex
			local var_12_1 = arg_7_0.isFromTeam

			game.enterFubenIndexScene({
				returnAction = function(arg_13_0, arg_13_1)
					if var_12_1 == true then
						game.enterTeamScene({
							isShowRebirth = true,
							index = var_12_0
						})
					elseif var_7_0 then
						var_7_0()
					else
						game.enterHeroScene()
					end
				end
			})
		end
	})
	table.insert(var_7_2, {
		image = "ui/team/team_118.png",
		func = function(arg_14_0, arg_14_1)
			local var_14_0 = arg_7_0.curIndex
			local var_14_1 = arg_7_0.isFromTeam

			game.enterActivityScene({
				returnAction = function(arg_15_0, arg_15_1)
					if var_14_1 == true then
						game.enterTeamScene({
							isShowRebirth = true,
							index = var_14_0
						})
					elseif var_7_0 then
						var_7_0()
					else
						game.enterHeroScene()
					end
				end
			})
		end
	})
	table.insert(var_7_2, {
		image = "ui/enhance/enhance_012.png",
		func = function(arg_16_0, arg_16_1)
			local var_16_0 = arg_7_0.curIndex
			local var_16_1 = arg_7_0.isFromTeam

			game.enterMysticStoreScene({
				returnAction = function(arg_17_0, arg_17_1)
					if var_16_1 == true then
						game.enterTeamScene({
							isShowRebirth = true,
							index = var_16_0
						})
					elseif var_7_0 then
						var_7_0()
					else
						game.enterHeroScene()
					end
				end
			})
		end
	})

	for iter_7_0, iter_7_1 in ipairs(var_7_2) do
		local var_7_4 = ui.newControlButton({
			normalImage = iter_7_1.image,
			position = ccp(280 + (iter_7_0 - 1) * 127, 64),
			clickAction = iter_7_1.func
		})

		arg_7_0.background:addChild(var_7_4)
	end
end

function var_0_1.showHeroAttrs(arg_18_0)
	local var_18_0 = CCSize(255, 372)
	local var_18_1 = CCScrollView:create(var_18_0)

	var_18_1:setPosition(308, 143)
	var_18_1:setDirection(kCCScrollViewDirectionVertical)

	local var_18_2 = 0
	local var_18_3 = {}
	local var_18_4 = {}

	for iter_18_0 = 1, 12 do
		local var_18_5, var_18_6 = var_0_0.addRebirthDescHandler(iter_18_0, arg_18_0.heroId, var_18_0.width)

		table.insert(var_18_3, var_18_5)
		table.insert(var_18_4, var_18_6)

		var_18_2 = var_18_2 + var_18_6 + 28
	end

	var_18_1:setContentSize(CCSize(var_18_0.width, var_18_2))

	for iter_18_1 = 1, table.nums(var_18_3) do
		local var_18_7 = display.newSprite("uilocal/team/team_text_050.png", 0, var_18_2 - 5)

		var_18_7:setAnchorPoint(ccp(0, 1))
		var_18_1:getContainer():addChild(var_18_7)

		local var_18_8 = CCLabelAtlas:create(string.lf(".%d", iter_18_1), "uilocal/battle/battle_text_010.png", 34, 55, 46)

		var_18_8:setScale(0.5)
		var_18_8:setAnchorPoint(ccp(0, 1))
		var_18_8:setPosition(50, var_18_2 - 2)
		var_18_1:getContainer():addChild(var_18_8)

		var_18_2 = var_18_2 - 28

		var_18_3[iter_18_1]:setPosition(0, var_18_2)
		var_18_1:getContainer():addChild(var_18_3[iter_18_1])

		var_18_2 = var_18_2 - var_18_4[iter_18_1]
	end

	arg_18_0.background:addChild(var_18_1)
	var_18_1:setContentOffset(var_18_1:minContainerOffset())
end

return var_0_1
