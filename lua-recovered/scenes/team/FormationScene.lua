require("network.BattleRequest")
require("scenes.battle.BattleData")

local var_0_0 = {}

for iter_0_0 = 0, 1 do
	for iter_0_1 = 0, 2 do
		if iter_0_1 == 1 then
			table.insert(var_0_0, ccp(500 - iter_0_0 * 280, 310 - iter_0_1 * 100))
		else
			table.insert(var_0_0, ccp(430 - iter_0_0 * 280, 300 - iter_0_1 * 100))
		end
	end
end

local var_0_1 = class("FormationScene", function()
	return display.newScene("FormationScene")
end)

function var_0_1.request(arg_2_0, arg_2_1)
	local function var_2_0()
		arg_2_1()
	end

	local function var_2_1()
		return
	end

	arg_2_0.battleRequest:setResponseNormalHandler(var_2_0)
	arg_2_0.battleRequest:setResponseExceptionHandler(var_2_1)

	local var_2_2 = ""

	for iter_2_0 = 1, 6 do
		local var_2_3 = false

		for iter_2_1, iter_2_2 in pairs(Player.team.groupList) do
			if iter_2_2.battleIx == iter_2_0 then
				var_2_2 = var_2_2 .. iter_2_2.heroId
				var_2_3 = true

				break
			end
		end

		if var_2_3 == false then
			var_2_2 = var_2_2 .. 0
		end

		if iter_2_0 ~= 6 then
			var_2_2 = var_2_2 .. ","
		end
	end

	arg_2_0.battleRequest:requestSetBattleFormation(var_2_2)
end

function var_0_1.ctor(arg_5_0)
	BattleData.pos_Hero = var_0_0
	arg_5_0.battleRequest = BattleRequest:new(arg_5_0)
	arg_5_0.battleRequest.waitType = WaitShowType.eNormal

	local var_5_0 = require("scenes.CommonBgLayer").new({
		titleSprite = "uilocal/team/team_text_008.png",
		returnAction = function()
			arg_5_0:request(function()
				game.enterTeamScene({})
			end)
		end
	})

	arg_5_0:addChild(var_5_0)

	arg_5_0.bg_far_Sprite = var_5_0:getBackgroundSprite()

	local var_5_1 = CCSprite:create("ui/team/team_028.png")

	arg_5_0.bg_far_Sprite:addChild(var_5_1)
	var_5_1:setPosition(480, 290)

	if IPlatform:instance():getConfig("Channel") ~= "ZSY_TW" then
		local var_5_2 = var_5_1:getContentSize()
		local var_5_3 = ui.newControlButton({
			normalImage = "uilocal/common/common_text_016.png",
			position = ccp(10, var_5_2.height - 10),
			clickAction = function()
				if tonumber(EditionConfig.__Version) < 200 and IPlatform:instance():getConfig("Channel") ~= "ZSY_TW" then
					showFlashNotice(string.lf("该功能需要更新客户端后才能使用!"))
				else
					local var_8_0 = string.lf("   “大闹天宫HD”里我打造的豪华阵容已上线，你敢不敢来挑战！敢？那就立即下载游戏吧，和我一起玩这款超好玩的游戏")
					local var_8_1 = require("scenes.team.DlgShareLayer").new({
						shareText = var_8_0
					})

					display.getRunningScene():addChild(var_8_1, DefaultZOrder.eTaskReward)
				end
			end
		})

		var_5_3:setAnchorPoint(CCPoint(0, 1))
		var_5_1:addChild(var_5_3)
	end

	local var_5_4 = 0

	for iter_5_0 = 0, table.getn(Player.team.groupList) do
		if Player.team.groupList[iter_5_0] and Player.team.groupList[iter_5_0].heroId > 0 then
			var_5_4 = var_5_4 + 1
		end
	end

	local var_5_5 = CCLabelTTF:create(string.lf("上阵人数：%s/6", var_5_4), _FONT_DEFAULT, Adapter.FontSize(30))

	var_5_5:setPosition(300, 600)
	var_5_5:setColor(ccc3(255, 215, 16))
	arg_5_0.bg_far_Sprite:addChild(var_5_5)

	local var_5_6 = CCLabelTTF:create(string.lf("被克制的职业会降低5%\n的攻击力和防御力。\n\n通常优先攻击前排，建议\n将输出职业安置于后排。"), _FONT_DEFAULT, Adapter.FontSize(18))

	var_5_6:setPosition(810, 175)
	var_5_6:setHorizontalAlignment(kCCTextAlignmentLeft)
	arg_5_0.bg_far_Sprite:addChild(var_5_6)

	local var_5_7 = CCLabelTTF:create(string.lf("自由拖动主将交换位置"), _FONT_DEFAULT, Adapter.FontSize(18))

	var_5_7:setPosition(810, 50)
	var_5_7:setColor(ccc3(237, 97, 22))
	arg_5_0.bg_far_Sprite:addChild(var_5_7)

	local var_5_8 = CCArray:create()

	var_5_8:addObject(CCFadeOut:create(1))
	var_5_8:addObject(CCFadeIn:create(1))
	var_5_7:runAction(CCRepeatForever:create(CCSequence:create(var_5_8)))
	arg_5_0:createBackGround()

	local var_5_9 = require("scenes.battle.HeroDragLayer").new()

	arg_5_0.bg_far_Sprite:addChild(var_5_9)

	local var_5_10, var_5_11 = var_5_9:viewHero(Player.team.groupList, var_0_0, false, 1 / Adapter.MinScale)

	for iter_5_1, iter_5_2 in pairs(var_5_10) do
		local var_5_12 = CCSprite:create("ui/battle/bg_battle_position.png")

		iter_5_2:addChild(var_5_12)

		local var_5_13 = BaseHeros[iter_5_2.heroId]
		local var_5_14 = var_5_13.name
		local var_5_15 = 2
		local var_5_16 = ui.newTTFLabelWithOutline({
			text = var_5_14,
			font = _FONT_LISU,
			size = Adapter.FontSize(20),
			align = ui.TEXT_ALIGN_LEFT
		})

		iter_5_2:addChild(var_5_16)
		var_5_16:setPosition(0, 360)
		var_5_16:setColor(getQualityColor(var_5_13.quality))

		local var_5_17 = CCSprite:create(getProfessionIconImageName(var_5_13.profession))

		var_5_17:setScale(2.5)
		var_5_17:setPosition(-100, 360)
		iter_5_2:addChild(var_5_17, 0)
	end
end

function var_0_1.createBackGround(arg_9_0)
	local var_9_0 = 1

	for iter_9_0 = 0, 1 do
		for iter_9_1 = 0, 2 do
			local var_9_1
			local var_9_2 = iter_9_0 ~= 0 and "ui/team/team_029.png" or "ui/team/team_029.png"
			local var_9_3 = CCSprite:create(var_9_2)

			var_9_3:setPosition(var_0_0[var_9_0])
			arg_9_0.bg_far_Sprite:addChild(var_9_3)

			var_9_0 = var_9_0 + 1
		end
	end
end

return var_0_1
