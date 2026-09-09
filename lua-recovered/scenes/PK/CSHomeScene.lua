require("base.define")
require("network.ChampionShipRequest")
require("scenes.team.OthersTeamHelper")
require("scenes.battle.BattleOperator")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = 0
local var_0_2 = 0
local var_0_3 = class("CSHomeScene", function()
	return display.newScene("CSHomeScene")
end)

function var_0_3.ctor(arg_2_0, arg_2_1)
	var_0_1 = Player.level > 70 and daoTypes.typeOfTian or Player.level > 40 and daoTypes.typeOfDi or daoTypes.typeOfRen
	arg_2_0.bgSize = CCSize(960, 640)

	arg_2_0:initRequests()
end

function var_0_3.onEnter(arg_3_0)
	local var_3_0 = display.newSprite("ui/PK/PK_020.jpg")

	var_3_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_3_0:setPosition(CCPoint(display.cx, display.cy))
	var_3_0:setScale(Adapter.AutoScaleY)
	arg_3_0:addChild(var_3_0)

	local var_3_1 = CCSprite:create("ui/common/common_070.png"):getTextureRect().size
	local var_3_2 = ui.newControlButton({
		highlightedImage = "ui/common/common_070.png",
		normalImage = "ui/common/common_070.png",
		anchorPoint = CCPoint(1, 1),
		size = Adapter.MinSize(var_3_1.width, var_3_1.height),
		position = Adapter.AutoPos(arg_3_0.bgSize.width - 10, arg_3_0.bgSize.height - 5),
		clickAction = function()
			game.enterHomeScene({
				showSubLayer = ShowSubLayerType.ePKHome
			})
		end
	})

	arg_3_0:addChild(var_3_2)
	arg_3_0.worshipInfoRequest:request()
end

function var_0_3.onExit(arg_5_0)
	arg_5_0:removeSchedule()
end

function var_0_3.initRequests(arg_6_0)
	local function var_6_0()
		local var_7_0 = arg_6_0.worshipInfoRequest.restable

		arg_6_0:showDataInfo(var_7_0)
		arg_6_0:addButtons(var_7_0)
	end

	arg_6_0.worshipInfoRequest = WorshipInfoRequest:new(arg_6_0)

	arg_6_0.worshipInfoRequest:setResponseNormalHandler(var_6_0)

	local function var_6_1()
		local var_8_0 = arg_6_0.worshipUserRequest.restable

		arg_6_0.currBtnSupport:setEnabled(false)
		arg_6_0.currBtnOppose:setEnabled(false)

		arg_6_0.currBtnSupport = nil
		arg_6_0.currBtnOppose = nil

		local function var_8_1()
			var_0_0.createToast({
				show = var_0_0.eShowReward,
				rewards = var_8_0.Reward
			}):show({
				align = display.CENTER,
				x = display.cx,
				y = display.cy
			})
		end

		if arg_6_0.worshipType == worshipTypes.typeOfSupport then
			arg_6_0:runMobaiAnimation(arg_6_0.actionPos, var_8_1)
		else
			arg_6_0:runKoushuiAnimation(arg_6_0.actionPos, var_8_1)
		end
	end

	arg_6_0.worshipUserRequest = WorshipUserRequest:new()

	arg_6_0.worshipUserRequest:setResponseNormalHandler(var_6_1)

	local function var_6_2()
		local var_10_0 = arg_6_0.worshipLogRequest.restable

		var_10_0.AvatarId = arg_6_0.currAvatarId

		local var_10_1 = require("scenes.PK.CSWorshipLayer").new(var_10_0)

		CCDirector:sharedDirector():getRunningScene():addChild(var_10_1)
	end

	arg_6_0.worshipLogRequest = WorshipLogRequest:new()

	arg_6_0.worshipLogRequest:setResponseNormalHandler(var_6_2)
end

function var_0_3.addButtons(arg_11_0, arg_11_1)
	local var_11_0 = CCSprite:create("ui/common/common_105.png"):getTextureRect().size
	local var_11_1 = ui.newControlButton({
		fontSize = 25,
		normalImage = "ui/common/common_105.png",
		text = string.lf("进入争霸殿"),
		size = Adapter.MinSize(var_11_0.width, var_11_0.height),
		position = Adapter.AutoPos(arg_11_0.bgSize.width * 0.5, arg_11_0.bgSize.height * 0.1),
		clickAction = function()
			if arg_11_1.HaveTime == -1 then
				if arg_11_1.WorshipRankInfo == nil or table.nums(arg_11_1.WorshipRankInfo) == 0 then
					ui.showMessageBox({
						text = string.lf("上仙，本轮比赛即将开始，小的们正在整理大殿，暂时无法进入哦"),
						title1 = string.lf("确定")
					})
				else
					game.enterCSBattleScene()
				end
			elseif arg_11_1.HaveTime == 0 then
				if arg_11_1.NumNoEnough ~= nil and arg_11_1.NumNoEnough == 1 then
					return
				end

				if arg_11_1.RankingNum ~= nil and arg_11_1.RankingNum <= 8 then
					game.enterCSGambleScene()
				else
					game.enterCSBattleScene()
				end
			elseif arg_11_1.HaveTime > 0 then
				ui.showMessageBox({
					text = string.lf("上仙，比赛正在准备中，暂时无法进入哦"),
					title1 = string.lf("确定")
				})
			end
		end
	})

	arg_11_0:addChild(var_11_1)

	local var_11_2 = CCSprite:create("ui/enhance/enhance_015.png"):getTextureRect().size
	local var_11_3 = ui.newControlButton({
		normalImage = "ui/enhance/enhance_015.png",
		anchorPoint = CCPoint(0.5, 0.5),
		size = Adapter.MinSize(var_11_2.width, var_11_2.height),
		position = Adapter.AutoPos(arg_11_0.bgSize.width * 0.36, arg_11_0.bgSize.height * 0.835),
		clickAction = function()
			local var_13_0 = require("scenes.enhance.DlgRuleLayer").new({
				ruleType = DlgRuleType.ruleXianmo
			})

			CCDirector:sharedDirector():getRunningScene():addChild(var_13_0)
		end
	})

	arg_11_0:addChild(var_11_3)

	local var_11_4 = ui.newControlButton({
		fontSize = 22,
		normalImage = "ui/PK/PK_031.png",
		text = string.lf("排名奖励"),
		size = Adapter.MinSize(160, 50),
		position = Adapter.AutoPos(arg_11_0.bgSize.width * 0.9, arg_11_0.bgSize.height * 0.7),
		clickAction = function()
			game.enterCSRankScene()
		end
	})

	arg_11_0:addChild(var_11_4)

	local var_11_5 = arg_11_1.SpitCost ~= nil and arg_11_1.SpitCost or 10
	local var_11_6 = arg_11_1.HaveTime == -1 and arg_11_1.WorshipRankInfo ~= nil and table.nums(arg_11_1.WorshipRankInfo) > 0
	local var_11_7 = arg_11_0.bgSize.width
	local var_11_8 = arg_11_0.bgSize.height
	local var_11_9 = {
		{
			Image2 = "PK_049.png",
			Image1 = "PK_048.png",
			Position = CCPoint(var_11_7 * 0.5, var_11_8 * 0.24),
			btnPos1 = CCPoint(var_11_7 * 0.4375, var_11_8 * 0.37),
			btnPos2 = CCPoint(var_11_7 * 0.5625, var_11_8 * 0.37),
			namePos = CCPoint(var_11_7 * 0.5, var_11_8 * 0.45),
			actionPos = CCPoint(480, 400)
		},
		{
			Image2 = "PK_047.png",
			Image1 = "PK_046.png",
			Position = CCPoint(var_11_7 * 0.15, var_11_8 * 0.08),
			btnPos1 = CCPoint(var_11_7 * 0.125, var_11_8 * 0.17),
			btnPos2 = CCPoint(var_11_7 * 0.25, var_11_8 * 0.17),
			namePos = CCPoint(var_11_7 * 0.1875, var_11_8 * 0.25),
			actionPos = CCPoint(190, 250)
		},
		{
			Image2 = "PK_051.png",
			Image1 = "PK_050.png",
			Position = CCPoint(var_11_7 * 0.8125, var_11_8 * 0.08),
			btnPos1 = CCPoint(var_11_7 * 0.75, var_11_8 * 0.17),
			btnPos2 = CCPoint(var_11_7 * 0.875, var_11_8 * 0.17),
			namePos = CCPoint(var_11_7 * 0.8125, var_11_8 * 0.25),
			actionPos = CCPoint(770, 250)
		}
	}

	for iter_11_0, iter_11_1 in ipairs(var_11_9) do
		local var_11_10 = arg_11_1.WorshipRankInfo ~= nil and arg_11_1.WorshipRankInfo[iter_11_0] or nil
		local var_11_11 = "ui/PK/" .. (var_11_6 == true and var_11_10 ~= nil and iter_11_1.Image1 or iter_11_1.Image2)
		local var_11_12 = CCSprite:create(var_11_11):getTextureRect().size
		local var_11_13 = ui.newControlButton({
			normalImage = var_11_11,
			anchorPoint = CCPoint(0.5, 0),
			size = Adapter.MinSize(var_11_12.width * 0.8, var_11_12.height * 0.8),
			position = Adapter.AutoPos(iter_11_1.Position.x, iter_11_1.Position.y),
			clickAction = function()
				if var_11_6 == true and var_11_10 ~= nil then
					arg_11_0.currAvatarId = var_11_10.AvatarId

					arg_11_0.worshipLogRequest:request(var_11_10.PlayerID)
				end
			end
		})

		var_11_13:setEnabled(var_11_6)
		arg_11_0:addChild(var_11_13)

		if var_11_6 == true and var_11_10 ~= nil then
			local var_11_14 = Adapter.MinSize(180, 40)
			local var_11_15 = display.newScale9Sprite("ui/common/common_064_3.png", Adapter.AutoPosX(iter_11_1.namePos.x), Adapter.AutoPosY(iter_11_1.namePos.y), var_11_14)

			arg_11_0:addChild(var_11_15)
			addLabelWithColorSize(var_11_15, var_11_10.PlayerName, ColorTable.eTitleButton_Normal, 20, CCPoint(0.5, 0.5), CCPoint(var_11_14.width / 2, var_11_14.height / 2))

			local var_11_16
			local var_11_17
			local var_11_18 = CCSprite:create("ui/PK/PK_018.png"):getTextureRect().size

			var_11_16 = ui.newControlButton({
				fontSize = 20,
				disabledImage = "ui/PK/PK_054.png",
				normalImage = "ui/PK/PK_018.png",
				text = string.lf("膜拜"),
				size = Adapter.MinSize(var_11_18.width, var_11_18.height),
				position = Adapter.AutoPos(iter_11_1.btnPos1.x, iter_11_1.btnPos1.y),
				clickAction = function()
					arg_11_0.currBtnSupport, arg_11_0.currBtnOppose = var_11_16, var_11_17
					arg_11_0.worshipType, arg_11_0.actionPos = worshipTypes.typeOfSupport, iter_11_1.actionPos

					arg_11_0.worshipUserRequest:request(var_11_10.PlayerID, worshipTypes.typeOfSupport)
				end
			})
			var_11_17 = ui.newControlButton({
				fontSize = 20,
				disabledImage = "ui/PK/PK_054.png",
				normalImage = "ui/PK/PK_018.png",
				text = string.lf("吐口水"),
				size = Adapter.MinSize(var_11_18.width, var_11_18.height),
				position = Adapter.AutoPos(iter_11_1.btnPos2.x, iter_11_1.btnPos2.y),
				clickAction = function()
					ui.showMessageBox({
						text = string.lf("您是否要花%d元宝向该玩家吐一啪口水？他的对手将会给你大量银币奖励哦~~", var_11_5),
						title1 = string.lf("取消"),
						title2 = string.lf("吐口水"),
						action2 = function()
							if isMoneyEnough(MoneyType.eGold, var_11_5) == false then
								return
							end

							arg_11_0.currBtnSupport, arg_11_0.currBtnOppose = var_11_16, var_11_17
							arg_11_0.worshipType, arg_11_0.actionPos = worshipTypes.typeOfOppose, iter_11_1.actionPos

							arg_11_0.worshipUserRequest:request(var_11_10.PlayerID, worshipTypes.typeOfOppose)
						end
					})
				end
			})

			if var_11_10.HaveWorshipTimes ~= nil and var_11_10.HaveWorshipTimes <= 0 then
				var_11_16:setEnabled(false)
				var_11_17:setEnabled(false)
			end

			arg_11_0:addChild(var_11_16)
			arg_11_0:addChild(var_11_17)

			if var_11_10.BeWorshipType ~= nil and var_11_10.BeWorshipType == worshipTypes.typeOfOppose then
				local var_11_19 = {
					Adapter.AutoPos(iter_11_1.actionPos.x, iter_11_1.actionPos.y),
					Adapter.AutoPos(iter_11_1.actionPos.x - 20, iter_11_1.actionPos.y - 10),
					(Adapter.AutoPos(iter_11_1.actionPos.x + 15, iter_11_1.actionPos.y - 25))
				}

				display.addSpriteFramesWithFile("ui/PK/tu_koushui.plist", "ui/PK/tu_koushui.png")

				for iter_11_2 = 1, table.nums(var_11_19) do
					local var_11_20 = var_11_19[iter_11_2]
					local var_11_21 = display.newSprite("#tu_koushui0005.png")

					var_11_21:setPosition(var_11_20)
					var_11_21:setScale(Adapter.MinScale)
					arg_11_0:addChild(var_11_21)
				end
			end
		end
	end

	if arg_11_1.NumNoEnough ~= nil and arg_11_1.NumNoEnough == 1 then
		local var_11_22 = display.newSprite("uilocal/PK/PK_text_031.png")

		var_11_22:setPosition(Adapter.AutoPos(arg_11_0.bgSize.width * 0.5, arg_11_0.bgSize.height * 0.5))
		var_11_22:setScale(Adapter.MinScale)
		arg_11_0:addChild(var_11_22)
	end
end

function var_0_3.showDataInfo(arg_19_0, arg_19_1)
	local var_19_0 = {
		[daoTypes.typeOfRen] = {
			Image = "PK_text_021.png",
			Title = string.lf("人道")
		},
		[daoTypes.typeOfDi] = {
			Image = "PK_text_023.png",
			Title = string.lf("地道")
		},
		[daoTypes.typeOfTian] = {
			Image = "PK_text_022.png",
			Title = string.lf("天道")
		}
	}

	if arg_19_1.RankType ~= nil then
		var_0_1 = arg_19_1.RankType
	end

	local var_19_1 = var_19_0[var_0_1]
	local var_19_2 = display.newSprite("uilocal/PK/" .. var_19_1.Image)

	var_19_2:setPosition(Adapter.AutoPos(arg_19_0.bgSize.width * 0.9, arg_19_0.bgSize.height * 0.8))
	var_19_2:setScale(Adapter.MinScale)
	arg_19_0:addChild(var_19_2)

	local var_19_3 = display.newSprite("ui/PK/PK_019.png")

	var_19_3:setAnchorPoint(CCPoint(0, 0.5))
	var_19_3:setPosition(Adapter.AutoPos(arg_19_0.bgSize.width * 0.01, arg_19_0.bgSize.height * 0.8))
	var_19_3:setScale(Adapter.MinScale)
	arg_19_0:addChild(var_19_3)

	local var_19_4 = addLabelWithColorSize(var_19_3, "", ccc3(247, 211, 91), 20, CCPoint(0, 0.5), CCPoint(10, 100))
	local var_19_5 = addLabelWithColorSize(var_19_3, "", ccc3(247, 211, 91), 20, CCPoint(0, 0.5), CCPoint(10, 72.5))
	local var_19_6 = addLabelWithColorSize(var_19_3, "", ccc3(247, 211, 91), 20, CCPoint(0, 0.5), CCPoint(10, 47.5))
	local var_19_7 = addLabelWithColorSize(var_19_3, "", ccc3(247, 211, 91), 20, CCPoint(0, 0.5), CCPoint(10, 20))

	if arg_19_1.HaveTime == -1 then
		Player:setPrestige(arg_19_1.Prestige)
		var_19_4:setString(string.lf("当前威望: #FFFFFF%s", arg_19_1.Prestige))
		var_19_5:setString(string.lf("当前") .. var_19_1.Title .. string.lf("排名: #FFFFFF%s", arg_19_1.PrestigeRank > 0 and tostring(arg_19_1.PrestigeRank) or string.lf("无排名")))
		var_19_6:setString(var_19_1.Title .. string.lf("威望门槛: #FFFFFF%s", arg_19_1.LowestPrestige))
		var_19_7:setString(string.lf("下次开赛时间: #FFFFFF%s", arg_19_1.NextRankTime))
	elseif arg_19_1.HaveTime == 0 then
		local var_19_8 = arg_19_1.RankingNum == 2 and string.lf("决赛比赛中") or string.lf("%s强比赛中...", arg_19_1.RankingNum)

		var_19_4:setString(string.lf("当前威望: #FFFFFF%s", var_19_8))
		var_19_5:setString(string.lf("当前") .. var_19_1.Title .. string.lf("排名: #FFFFFF%s", var_19_8))
		var_19_6:setString(var_19_1.Title .. string.lf("威望门槛: #FFFFFF%s", var_19_8))
		var_19_7:setString(string.lf("下次开赛时间: #FFFFFF%s", var_19_8))
	elseif arg_19_1.HaveTime > 0 then
		var_19_4:setString(string.lf("当前威望: #FFFFFF处理中..."))
		var_19_5:setString(string.lf("当前") .. var_19_1.Title .. string.lf("排名: #FFFFFF处理中..."))
		var_19_6:setString(var_19_1.Title .. string.lf("威望门槛: #FFFFFF处理中..."))

		arg_19_0.timeLabel = var_19_7
		arg_19_0.remainTime = arg_19_1.HaveTime

		arg_19_0:addSchedule()
	end
end

function var_0_3.addSchedule(arg_20_0)
	if arg_20_0.scheduleHandle == nil then
		arg_20_0.scheduleHandle = require("framework.scheduler").scheduleGlobal(handler(arg_20_0, arg_20_0.scheduleCallback), 1)
	end
end

function var_0_3.removeSchedule(arg_21_0)
	if arg_21_0.scheduleHandle then
		require("framework.scheduler").unscheduleGlobal(arg_21_0.scheduleHandle)

		arg_21_0.scheduleHandle = nil
	end
end

function var_0_3.scheduleCallback(arg_22_0, arg_22_1)
	if arg_22_0.remainTime <= 0 then
		arg_22_0:removeSchedule()
		arg_22_0:onEnter()

		return
	end

	if arg_22_0.timeLabel ~= nil then
		arg_22_0.timeLabel:setString(string.lf("下次开赛时间: #FFFFFF%s", formatTime(arg_22_0.remainTime)))
	end

	arg_22_0.remainTime = arg_22_0.remainTime - 1
end

function var_0_3.runMobaiAnimation(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = 9

	display.addSpriteFramesWithFile("ui/PK/huaban.plist", "ui/PK/huaban.png")

	for iter_23_0 = 1, 9 do
		local var_23_1 = math.random(Adapter.AutoPosX(arg_23_1.x - 150), Adapter.AutoPosX(arg_23_1.x + 150))
		local var_23_2 = math.random(display.height, display.height + 100)
		local var_23_3 = display.newSprite("#huaban_" .. iter_23_0 .. ".png", var_23_1, var_23_2)

		var_23_3:setScale(Adapter.MinScale)
		arg_23_0:addChild(var_23_3)

		local var_23_4 = CCArray:create()

		var_23_4:addObject(CCMoveTo:create(math.random(1.5, 3), CCPoint(var_23_1, math.random(Adapter.AutoPosY(arg_23_1.y - 200), Adapter.AutoPosY(arg_23_1.y - 150)))))
		var_23_4:addObject(CCFadeOut:create(0.5))
		var_23_4:addObject(CCCallFunc:create(function()
			var_23_3:removeFromParentAndCleanup(true)

			var_23_0 = var_23_0 - 1

			if var_23_0 == 0 and arg_23_2 then
				arg_23_2()
			end
		end))
		var_23_3:runAction(CCSequence:create(var_23_4))
	end
end

function var_0_3.runKoushuiAnimation(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = {
		Adapter.AutoPos(arg_25_1.x, arg_25_1.y),
		Adapter.AutoPos(arg_25_1.x - 20, arg_25_1.y - 10),
		(Adapter.AutoPos(arg_25_1.x + 15, arg_25_1.y - 25))
	}

	display.addSpriteFramesWithFile("ui/PK/tu_koushui.plist", "ui/PK/tu_koushui.png")

	local function var_25_1(arg_26_0)
		local var_26_0 = display.newSprite("#tu_koushui0001.png")
		local var_26_1 = display.newFrames("tu_koushui000%d.png", 1, 5)
		local var_26_2 = display.newAnimation(var_26_1, 0.125)

		var_26_0:setScale(30)
		var_26_0:setPosition(arg_25_0.bgSize.width / 2, arg_25_0.bgSize.height / 2)
		var_26_0:setOpacity(0)
		arg_25_0:addChild(var_26_0)

		local var_26_3 = CCArray:create()
		local var_26_4 = CCArray:create()

		var_26_3:addObject(CCMoveTo:create(0.2, arg_26_0))
		var_26_3:addObject(CCScaleTo:create(0.2, Adapter.MinScale))
		var_26_3:addObject(CCFadeTo:create(0.2, 255))
		var_26_4:addObject(CCSpawn:create(var_26_3))
		var_26_4:addObject(CCAnimate:create(var_26_2))
		var_26_4:addObject(CCCallFunc:create(function()
			table.remove(var_25_0, table.nums(var_25_0))

			if table.nums(var_25_0) > 0 then
				var_25_1(var_25_0[table.nums(var_25_0)])
			elseif arg_25_2 then
				arg_25_2()
			end
		end))
		var_26_0:runAction(CCSequence:create(var_26_4))
	end

	var_25_1(var_25_0[table.nums(var_25_0)])
end

return var_0_3
