local var_0_0 = require("base.cache")

require("network.GuildRequest")

local var_0_1 = class("GuildMapScene", function()
	return display.newScene("GuildMapScene")
end)

function var_0_1.ctor(arg_2_0)
	local var_2_0 = display.newSprite("ui/guild/guild_029.jpg", display.cx, display.cy)

	var_2_0:setScaleX(Adapter.AutoScaleX)
	var_2_0:setScaleY(Adapter.AutoScaleY)
	arg_2_0:addChild(var_2_0)

	local var_2_1 = ui.newControlButton({
		normalImage = "ui/enhance/enhance_015.png",
		position = Adapter.AutoPos(810, 600),
		clickAction = function()
			local var_3_0 = require("scenes.enhance.DlgRuleLayer").new({
				ruleType = DlgRuleType.ruleGuildBoss
			})

			CCDirector:sharedDirector():getRunningScene():addChild(var_3_0)
		end,
		scaleX = Adapter.MinScale,
		scaleY = Adapter.MinScale
	})

	arg_2_0:addChild(var_2_1)

	local var_2_2 = ui.newControlButton({
		normalImage = "ui/common/common_061.png",
		position = Adapter.AutoPos(900, 600),
		clickAction = function()
			game.enterGuildHomeScene()
		end,
		scaleX = Adapter.MinScale,
		scaleY = Adapter.MinScale
	})

	arg_2_0:addChild(var_2_2)
	arg_2_0:initRequests()
	arg_2_0.demonListRequest:request()
end

function var_0_1.initRequests(arg_5_0)
	local function var_5_0()
		arg_5_0.listInfo = arg_5_0.demonListRequest:getDemonListInfo()
		arg_5_0.demonKing = arg_5_0.listInfo.demonKing

		arg_5_0:createBossNodeLines()
		arg_5_0:createBossNodes()
		arg_5_0:createGuildInfo()
	end

	arg_5_0.demonListRequest = GuildDemonListRequest:new()

	arg_5_0.demonListRequest:setResponseNormalHandler(var_5_0)
end

function var_0_1.createBossNodeLines(arg_7_0)
	local var_7_0 = {
		ccp(BaseGuildNodes[1].xPos, BaseGuildNodes[1].yPos),
		ccp(BaseGuildNodes[1].xPos, BaseGuildNodes[2].yPos),
		ccp(BaseGuildNodes[3].xPos, BaseGuildNodes[2].yPos),
		ccp(BaseGuildNodes[3].xPos, BaseGuildNodes[3].yPos),
		ccp(BaseGuildNodes[4].xPos, BaseGuildNodes[3].yPos),
		ccp(BaseGuildNodes[4].xPos, BaseGuildNodes[4].yPos),
		ccp(BaseGuildNodes[5].xPos, BaseGuildNodes[4].yPos),
		ccp(BaseGuildNodes[5].xPos, BaseGuildNodes[5].yPos),
		ccp(BaseGuildNodes[6].xPos, BaseGuildNodes[5].yPos),
		ccp(BaseGuildNodes[6].xPos, BaseGuildNodes[7].yPos),
		ccp(BaseGuildNodes[8].xPos, BaseGuildNodes[7].yPos),
		ccp(BaseGuildNodes[8].xPos, BaseGuildNodes[8].yPos),
		ccp(BaseGuildNodes[9].xPos, BaseGuildNodes[9].yPos)
	}
	local var_7_1 = table.nums(var_7_0)

	for iter_7_0 = 1, var_7_1 do
		if iter_7_0 ~= var_7_1 then
			local var_7_2 = var_7_0[iter_7_0]
			local var_7_3 = var_7_0[iter_7_0 + 1]
			local var_7_4 = math.abs(var_7_2.x - var_7_3.x) + 5
			local var_7_5 = math.abs(var_7_2.y - var_7_3.y) + 5
			local var_7_6 = Adapter.AutoPos((var_7_2.x + var_7_3.x) / 2, (var_7_2.y + var_7_3.y) / 2)
			local var_7_7 = display.newScale9Sprite("ui/PK/PK_041.png", var_7_6.x, var_7_6.y)

			var_7_7:setPreferredSize(Adapter.AutoSize(var_7_4, var_7_5))
			arg_7_0:addChild(var_7_7)
		end
	end
end

function var_0_1.createBossNodes(arg_8_0)
	local function var_8_0(arg_9_0)
		for iter_9_0, iter_9_1 in ipairs(arg_8_0.listInfo.demonInfos) do
			if iter_9_1.demonID == arg_9_0 then
				return iter_9_1
			end
		end
	end

	for iter_8_0, iter_8_1 in pairs(BaseGuildNodes) do
		local var_8_1 = var_8_0(iter_8_0)
		local var_8_2 = ui.newControlButton({
			normalImage = "ui/common/common_003.png",
			clickAction = function(arg_10_0, arg_10_1)
				if iter_8_0 <= 9 then
					local var_10_0 = arg_8_0.listInfo.demonInfos[iter_8_0]

					if var_10_0 == nil then
						showFlashNotice(string.lf("上仙，该Boss未开放！"))

						return
					end

					var_10_0.remainChallengeTime = arg_8_0.listInfo.canChallengeTime

					game.enterGuildBossPreviewScene({
						bossInfo = var_10_0
					})
				else
					game.enterGuildBossPreviewScene({
						isKing = true,
						demonKing = arg_8_0.demonKing,
						demonInfos = arg_8_0.listInfo.demonInfos,
						remainChallengeTime = arg_8_0.listInfo.canChallengeTime
					})
				end
			end,
			scaleX = Adapter.MinScale,
			scaleY = Adapter.MinScale
		})

		var_8_2:setPosition(Adapter.AutoPos(iter_8_1.xPos, iter_8_1.yPos))
		arg_8_0:addChild(var_8_2)

		local var_8_3 = display.newSprite("header/" .. iter_8_1.headerImage, Adapter.MinWidth(43), Adapter.MinHeight(43))

		var_8_3:setScale(Adapter.MinScale)
		var_8_2:addChild(var_8_3)

		local var_8_4 = display.newSprite("ui/guild/guild_031.png", Adapter.MinWidth(43), Adapter.MinHeight(-13))

		var_8_4:setScale(Adapter.MinScale)
		var_8_2:addChild(var_8_4)
		addLabelWithColorSize(var_8_2, iter_8_1.name, ColorTable.eTitleTabButton_Normal, 20, CCPoint(0.5, 0.5), Adapter.MinPos(43, -12))

		if var_8_1 and var_8_1.challengeStatus >= 2 then
			local var_8_5 = var_8_1.leftHPRate or 0
			local var_8_6 = require("scenes.ProgressBar").new({
				backImage = "ui/guild/guild_033.png",
				barImages = {
					"ui/guild/guild_032.png"
				},
				backSize = CCSize(182, 43),
				barSize = CCSize(124, 14),
				barPosition = ccp(-46, 1),
				percent = var_8_5 / 100
			})

			var_8_6:setPosition(ccp(43, -43))
			var_8_3:addChild(var_8_6)

			local var_8_7 = string.format("%.1f%%", var_8_5)

			addLabelWithColorSize(var_8_2, var_8_7, ccc3(0, 255, 0), 15, CCPoint(0.5, 0.5), Adapter.MinPos(-20, -43))
		elseif iter_8_0 <= 9 then
			local var_8_8 = display.newSprite("ui/guild/guild_030.png", Adapter.MinWidth(43), Adapter.MinHeight(-43))

			var_8_8:setScale(Adapter.MinScale)
			var_8_2:addChild(var_8_8)

			if var_8_1 and var_8_1.challengeStatus == 1 then
				addLabelWithColorSize(var_8_2, string.lf("需打过上一魔族"), ColorTable.eTitleTabButton_Normal, 20, CCPoint(0.5, 0.5), Adapter.MinPos(43, -42))
			else
				addLabelWithColorSize(var_8_2, string.lf("%d级巢穴开放", arg_8_0.listInfo.openLvs[iter_8_0].openNeedLv), ColorTable.eTitleTabButton_Normal, 20, CCPoint(0.5, 0.5), Adapter.MinPos(43, -42))
			end
		end

		if var_8_1 and var_8_1.challengeStatus == 4 then
			local var_8_9 = display.newSprite("ui/guild/guild_040.png", 23 * Adapter.MinScale, 23 * Adapter.MinScale)

			var_8_9:setScale(Adapter.MinScale * 0.6)
			var_8_2:addChild(var_8_9)
		end

		if var_8_1 and var_8_1.challengeStatus == 3 then
			display.addSpriteFramesWithFile("ui/map/icon_engagement.plist", "ui/map/icon_engagement.png")

			local var_8_10 = display.newSprite("#icon_engagement1.png")
			local var_8_11 = display.newFrames("icon_engagement%d.png", 1, 3)
			local var_8_12 = display.newAnimation(var_8_11, 0.3333333333333333)

			var_8_10:runAction(CCRepeatForever:create(CCAnimate:create(var_8_12)))
			var_8_10:setPosition(43, 43)
			var_8_2:addChild(var_8_10)
		end

		if iter_8_0 == 10 and arg_8_0.demonKing.challengeStatus == 3 then
			display.addSpriteFramesWithFile("ui/map/icon_engagement.plist", "ui/map/icon_engagement.png")

			local var_8_13 = display.newSprite("#icon_engagement1.png")
			local var_8_14 = display.newFrames("icon_engagement%d.png", 1, 3)
			local var_8_15 = display.newAnimation(var_8_14, 0.3333333333333333)

			var_8_13:runAction(CCRepeatForever:create(CCAnimate:create(var_8_15)))
			var_8_13:setPosition(43, 43)
			var_8_2:addChild(var_8_13)
		end

		local var_8_16 = string.split(arg_8_0.listInfo.demonKing.demonIDs, ",")

		for iter_8_2, iter_8_3 in pairs(var_8_16) do
			if tostring(iter_8_0) == tostring(iter_8_3) then
				local var_8_17 = display.newSprite("ui/guild/guild_031.png", Adapter.MinWidth(43), Adapter.MinHeight(-71))

				var_8_17:setScale(Adapter.MinScale)
				var_8_2:addChild(var_8_17)
				addLabelWithColorSize(var_8_2, string.lf("关键王"), ColorTable.eTitleTabButton_Normal, 20, CCPoint(0.5, 0.5), Adapter.MinPos(43, -70))
			end
		end
	end
end

function var_0_1.createGuildInfo(arg_11_0)
	local var_11_0 = var_0_0.get("GetPlayerGuildInfoRequest")
	local var_11_1 = string.lf("建筑等级: #00FF00%d", arg_11_0.listInfo.caveLv)

	addLabelWithColorSize(arg_11_0, var_11_1, ColorTable.eTitleTabButton_Normal, 20, CCPoint(0, 0.5), Adapter.AutoPos(10, 619))

	local var_11_2 = addLabelWithColorSize(arg_11_0, string.lf("我的晶石:"), ColorTable.eTitleTabButton_Normal, 20, CCPoint(0, 0.5), Adapter.AutoPos(10, 595)):getTexture():getContentSize().width
	local var_11_3 = createItemCountNode({
		type = ItemType.eGuildCoin,
		value = arg_11_0.listInfo.curUnionCoin,
		color = ccc3(0, 255, 0),
		scale = Adapter.MinScale
	})

	var_11_3:setPosition(ccp(var_11_2 + Adapter.AutoPosX(25), Adapter.AutoPosY(595)))
	arg_11_0:addChild(var_11_3)

	local var_11_4 = string.lf("今日挑战次数: #00FF00%d/%d", arg_11_0.listInfo.canChallengeTime, arg_11_0.listInfo.challengeTotalTime)

	addLabelWithColorSize(arg_11_0, var_11_4, ColorTable.eTitleTabButton_Normal, 20, CCPoint(0, 0.5), Adapter.AutoPos(10, 571))
end

return var_0_1
