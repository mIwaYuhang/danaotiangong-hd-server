require("base.figure")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("DlgWhereEquipLayer", function()
	return display.newLayer()
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.curIndex = arg_2_1.curIndex
	arg_2_0.heroId = arg_2_1.heroId
	arg_2_0.equipList = arg_2_1.equipList
	arg_2_0.headerList = {}
	arg_2_0.posGetList = {}
	arg_2_0.allPosList = {
		{
			Image = "ui/team/team_121.png",
			Callback = function()
				local var_4_0 = arg_2_0.curIndex

				game.enterMysticStoreScene({
					returnAction = function(arg_5_0, arg_5_1)
						if tonumber(var_4_0) >= 0 then
							game.enterTeamScene({
								isShowRebirth = false,
								index = var_4_0
							})
						else
							game.enterHeroScene()
						end
					end
				})
			end
		},
		{
			Image = "ui/team/team_118.png",
			Callback = function()
				local var_6_0 = arg_2_0.curIndex

				game.enterActivityScene({
					type = ActivityType.eLuckyDisk,
					returnAction = function(arg_7_0, arg_7_1)
						if tonumber(var_6_0) >= 0 then
							game.enterTeamScene({
								isShowRebirth = false,
								index = var_6_0
							})
						else
							game.enterHeroScene()
						end
					end
				})
			end
		},
		{
			Image = "ui/home/home_068.png",
			Callback = function()
				local var_8_0 = arg_2_0.curIndex

				game.enterGuildHomeScene({
					returnAction = function(arg_9_0, arg_9_1)
						if tonumber(var_8_0) >= 0 then
							game.enterTeamScene({
								isShowRebirth = false,
								index = var_8_0
							})
						else
							game.enterHeroScene()
						end
					end
				})
			end
		},
		{
			Image = "ui/team/team_120.png",
			Callback = function()
				local var_10_0 = BaseHeros[arg_2_0.heroId].dropChapterId

				if var_10_0 > 0 then
					Player.currentTaskEntryType = TaskEntryType.CheckPoint
					Player.currentTaskStep = 2
					Player.currentMissionStageID = var_10_0
					Player.taskEntryCheckPointType = TaskEntryCheckPointType.eNone

					local var_10_1 = arg_2_0.curIndex

					game.enterMapChapterScene({
						stageId = var_10_0,
						returnAction = function(arg_11_0, arg_11_1)
							if tonumber(var_10_1) >= 0 then
								game.enterTeamScene({
									isShowRebirth = false,
									index = var_10_1
								})
							else
								game.enterHeroScene()
							end
						end
					})
				end
			end
		},
		{
			Image = "ui/team/team_117.png",
			Callback = function()
				local var_12_0 = arg_2_0.curIndex

				game.enterFubenIndexScene({
					returnAction = function(arg_13_0, arg_13_1)
						if tonumber(var_12_0) >= 0 then
							game.enterTeamScene({
								isShowRebirth = false,
								index = var_12_0
							})
						else
							game.enterHeroScene()
						end
					end
				})
			end
		}
	}

	local var_2_0 = display.newScale9Sprite("ui/team/team_127.png")

	var_2_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_0:setPosition(display.cx, display.cy)
	var_2_0:setScale(Adapter.MinScale)
	arg_2_0:addChild(var_2_0)

	local var_2_1 = var_2_0:getContentSize()
	local var_2_2 = display.newSprite("uilocal/team/team_text_049.png", var_2_1.width / 2, var_2_1.height - 25)

	var_2_0:addChild(var_2_2)

	local var_2_3 = display.newSprite("ui/team/team_128.png", var_2_1.width / 2, var_2_1.height / 2 - 60)

	var_2_3:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_0:addChild(var_2_3)

	local var_2_4 = var_2_3:getContentSize()

	local function var_2_5(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = CCSize(120, 120)
		local var_14_1 = CCLayerColor:create(ccc4(46, 39, 29, 0))

		var_14_1:setContentSize(var_14_0)

		local var_14_2 = ui.newControlButton({
			normalImage = arg_14_2.Image,
			position = CCPoint(var_14_0.width / 2, var_14_0.height / 2),
			clickAction = arg_14_2.Callback
		})

		var_14_1:addChild(var_14_2)

		return var_14_1
	end

	local var_2_6 = createTableView({
		reverse = false,
		direction = kCCScrollViewDirectionHorizontal,
		size = CCSize(var_2_4.width - 20, var_2_4.height - 20),
		dataset = arg_2_0.posGetList,
		sizehandler = function(arg_15_0, arg_15_1)
			return CCSize(120, 120)
		end,
		cellhandler = var_2_5
	})

	var_2_6:setPosition(10, 5)
	var_2_3:addChild(var_2_6)

	arg_2_0.posTableView = var_2_6

	local var_2_7 = table.nums(arg_2_0.equipList)
	local var_2_8 = CCSize(var_2_7 <= 6 and var_2_7 * 100 or var_2_1.width - 20, 150)
	local var_2_9 = CCSize(100, var_2_8.height)

	local function var_2_10(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = arg_16_2.equipId
		local var_16_1 = CCLayerColor:create(ccc4(46, 39, 29, 0))

		var_16_1:setContentSize(var_2_9)

		local function var_16_2(arg_17_0)
			for iter_17_0, iter_17_1 in pairs(arg_2_0.headerList) do
				if iter_17_0 == arg_17_0 then
					iter_17_1:setSelected(true)
				else
					iter_17_1:setSelected(false)
				end
			end

			arg_2_0.posGetList = {}

			local var_17_0 = BaseEquips[arg_17_0].equipType

			if var_17_0 == EquipType.eWeapon then
				table.insert(arg_2_0.posGetList, arg_2_0.allPosList[1])
				table.insert(arg_2_0.posGetList, arg_2_0.allPosList[5])
			elseif var_17_0 == EquipType.eAmulet then
				table.insert(arg_2_0.posGetList, arg_2_0.allPosList[2])
				table.insert(arg_2_0.posGetList, arg_2_0.allPosList[3])
			elseif var_17_0 == EquipType.eHelmet or var_17_0 == EquipType.eClothes then
				table.insert(arg_2_0.posGetList, arg_2_0.allPosList[1])
				table.insert(arg_2_0.posGetList, arg_2_0.allPosList[5])

				if BaseHeros[arg_2_0.heroId].dropChapterId > 0 then
					table.insert(arg_2_0.posGetList, arg_2_0.allPosList[4])
				end
			elseif var_17_0 == EquipType.eNecklace or var_17_0 == EquipType.eRing then
				table.insert(arg_2_0.posGetList, arg_2_0.allPosList[1])
			end

			arg_2_0.posTableView:reloadData(arg_2_0.posGetList)
		end

		local var_16_3 = figure.createHeader({
			isName = false,
			inTeam = false,
			itemId = var_16_0,
			type = ItemType.eEquip,
			clickAction = function()
				var_16_2(var_16_0)
			end
		})

		var_16_3:setAnchorPoint(CCPoint(0.5, 0.5))
		var_16_3:setPosition(var_2_9.width / 2, var_2_9.height / 2 + 15)
		var_16_1:addChild(var_16_3)

		arg_2_0.headerList[var_16_0] = var_16_3

		if arg_16_1 == 1 then
			var_16_2(var_16_0)
		end

		local var_16_4 = getQualityColor(getItemQuality(ItemType.eEquip, var_16_0))

		addLabelWithColorSize(var_16_1, getItemName(ItemType.eEquip, var_16_0), var_16_4, 20, CCPoint(0.5, 0), CCPoint(var_2_9.width / 2, 15))

		return var_16_1
	end

	local var_2_11 = createTableView({
		reverse = false,
		direction = kCCScrollViewDirectionHorizontal,
		size = var_2_8,
		dataset = arg_2_0.equipList,
		sizehandler = function(arg_19_0, arg_19_1)
			return var_2_9
		end,
		cellhandler = var_2_10
	})

	var_2_11:setPosition((var_2_1.width - var_2_8.width) / 2, var_2_1.height / 2 + 20)
	var_2_0:addChild(var_2_11)

	local var_2_12 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/guild/guild_text_022.png",
		position = CCPoint(var_2_1.width / 2, 50),
		clickAction = function()
			arg_2_0:removeFromParentAndCleanup(true)
		end
	})

	var_2_0:addChild(var_2_12)
end

return var_0_1
