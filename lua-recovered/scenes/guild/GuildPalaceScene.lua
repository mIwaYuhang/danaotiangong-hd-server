require("data.player")
require("network.GuildRequest")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = require("base.cache")
local var_0_2 = class("GuildPalaceScene", function()
	return display.newScene("GuildPalaceScene")
end)

function var_0_2.ctor(arg_2_0, arg_2_1)
	local var_2_0 = display.newSprite("ui/guild/guild_026.jpg", display.cx, display.cy)

	var_2_0:setScale(Adapter.AutoScaleY)
	arg_2_0:addChild(var_2_0)

	arg_2_0.bgSprite = var_2_0
	arg_2_0.bgSize = var_2_0:getContentSize()

	local var_2_1 = CCSprite:create("ui/common/common_061.png"):getTextureRect().size
	local var_2_2 = ui.newControlButton({
		normalImage = "ui/common/common_061.png",
		size = Adapter.MinSize(var_2_1.width, var_2_1.height),
		position = Adapter.AutoPos(900, 600),
		clickAction = function()
			game.enterGuildHomeScene()
		end
	})

	arg_2_0:addChild(var_2_2)

	local var_2_3 = CCSprite:create("ui/guild/guild_074.png"):getTextureRect().size
	local var_2_4 = ui.newControlButton({
		normalImage = "ui/guild/guild_074.png",
		size = Adapter.MinSize(var_2_3.width, var_2_3.height),
		position = Adapter.AutoPos(900, 515),
		clickAction = function()
			local var_4_0 = require("scenes.slave.DlgReportLayer").new({
				type = DlgReportType.reportGuildXm
			})

			arg_2_0:addChild(var_4_0)
		end
	})

	arg_2_0:addChild(var_2_4)
	arg_2_0:initRequests()
	arg_2_0.hallInfoRequest:request()
end

function var_0_2.initRequests(arg_5_0)
	local function var_5_0()
		local var_6_0 = arg_5_0.hallInfoRequest.restable

		arg_5_0:showPalaceInfo(var_6_0)
		arg_5_0:showCharacters(var_6_0)
		arg_5_0:showDonates(var_6_0)
	end

	arg_5_0.hallInfoRequest = GetHallInfoRequest:new()

	arg_5_0.hallInfoRequest:setResponseNormalHandler(var_5_0)

	local function var_5_1()
		for iter_7_0, iter_7_1 in pairs(arg_5_0.stoveList) do
			iter_7_1.button:setEnabled(false)
		end

		local var_7_0 = arg_5_0.guildWorshipRequest.restable

		if var_7_0 == nil or var_7_0.Reward == nil then
			return
		end

		local function var_7_1(arg_8_0)
			local var_8_0 = 30

			display.addSpriteFramesWithFile("ui/PK/huaban.plist", "ui/PK/huaban.png")

			for iter_8_0 = 1, var_8_0 do
				local var_8_1 = math.random(Adapter.AutoPosX(50), Adapter.AutoPosX(display.width - 50))
				local var_8_2 = math.random(display.height, display.height + 100)
				local var_8_3 = display.newSprite("#huaban_" .. iter_8_0 % 9 + 1 .. ".png", var_8_1, var_8_2)

				var_8_3:setScale(Adapter.MinScale)
				arg_5_0:addChild(var_8_3)

				local var_8_4 = CCArray:create()

				var_8_4:addObject(CCMoveTo:create(math.random(1, 4), CCPoint(var_8_1, math.random(-50, -50))))
				var_8_4:addObject(CCFadeOut:create(0.5))
				var_8_4:addObject(CCCallFunc:create(function()
					var_8_3:removeFromParentAndCleanup(true)

					var_8_0 = var_8_0 - 1

					if var_8_0 == 0 and arg_8_0 then
						arg_8_0()
					end
				end))
				var_8_3:runAction(CCSequence:create(var_8_4))
			end
		end

		arg_5_0:showPalaceInfo(var_7_0.Result)
		var_7_1(function()
			var_0_0.createToast({
				show = var_0_0.eShowReward,
				rewards = var_7_0.Reward
			}):show({
				align = display.CENTER,
				x = display.cx,
				y = display.cy
			})
		end)
	end

	arg_5_0.guildWorshipRequest = GuildWorshipRequest:new()

	arg_5_0.guildWorshipRequest:setResponseNormalHandler(var_5_1)
end

function var_0_2.showPalaceInfo(arg_11_0, arg_11_1)
	if arg_11_0.labelContainer == nil then
		local var_11_0 = display.newSprite("ui/guild/guild_025.png")

		var_11_0:setScale(Adapter.MinScale)
		var_11_0:setAnchorPoint(CCPoint(0, 1))
		var_11_0:setPosition(Adapter.AutoPos(0, 640))
		arg_11_0:addChild(var_11_0)

		arg_11_0.labelContainer = var_11_0
	end

	arg_11_0.labelContainer:removeAllChildrenWithCleanup(true)
	addLabelWithColorSize(arg_11_0.labelContainer, string.lf("收益增幅:#00FF00 %s", tostring(arg_11_1.additionRate)), ccc3(247, 211, 91), 20, CCPoint(0, 0.5), CCPoint(10, 145))
	addLabelWithColorSize(arg_11_0.labelContainer, string.lf("神殿等级:#00FF00 %s", arg_11_1.xmTempleLv), ccc3(247, 211, 91), 20, CCPoint(0, 0.5), CCPoint(10, 117))
	addLabelWithColorSize(arg_11_0.labelContainer, string.lf("我的晶石:#00FF00 "), ccc3(247, 211, 91), 20, CCPoint(0, 0.5), CCPoint(10, 89))
	addLabelWithColorSize(arg_11_0.labelContainer, string.lf("剩余捐献次数:#00FF00 %s", arg_11_1.canWorshipTime), ccc3(247, 211, 91), 20, CCPoint(0, 0.5), CCPoint(10, 61))

	local var_11_1 = createItemCountNode({
		type = ItemType.eGuildCoin,
		value = arg_11_1.curUnionCoin,
		color = ccc3(0, 255, 0)
	})

	var_11_1:setPosition(CCPoint(120, 89))
	arg_11_0.labelContainer:addChild(var_11_1)
end

function var_0_2.showCharacters(arg_12_0, arg_12_1)
	local var_12_0 = {
		{
			Image = "ui/PK/PK_047.png",
			backImage = "ui/guild/guild_023.png",
			Position = CCPoint(160, 200)
		},
		{
			Image = "ui/PK/PK_051.png",
			backImage = "ui/guild/guild_023.png",
			Position = CCPoint(800, 200)
		},
		{
			Image = "ui/PK/PK_049.png",
			backImage = "ui/guild/guild_024.png",
			Position = CCPoint(480, 250)
		}
	}
	local var_12_1 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_1.statueInfos) do
		table.insert(var_12_1, iter_12_1)
	end

	for iter_12_2, iter_12_3 in pairs(var_12_1) do
		if iter_12_3.positionName == string.lf("盟主") then
			var_12_0[3].name = iter_12_3.statueName
			var_12_0[3].avatar = iter_12_3.statueAvatarID
			var_12_0[3].rebirthCount = iter_12_3.breakthroughCount == nil and 0 or iter_12_3.breakthroughCount

			table.remove(var_12_1, iter_12_2)

			break
		end
	end

	for iter_12_4, iter_12_5 in pairs(var_12_1) do
		var_12_0[iter_12_4].name = iter_12_5.statueName
		var_12_0[iter_12_4].avatar = iter_12_5.statueAvatarID
		var_12_0[iter_12_4].rebirthCount = iter_12_5.breakthroughCount == nil and 0 or iter_12_5.breakthroughCount
	end

	for iter_12_6, iter_12_7 in pairs(var_12_0) do
		if iter_12_7.name ~= nil and iter_12_7.avatar ~= nil then
			local var_12_weapon = iter_12_7.statueWeaponID

			if not var_12_weapon or var_12_weapon == 0 then
				var_12_weapon = getHeroGroupWeaponId(iter_12_7.avatar)
			end

			local var_12_2 = {
				isViewQuality = false,
				isViewBaseInfo = false,
				figId = iter_12_7.avatar,
				equipId = var_12_weapon,
				pinjie = iter_12_7.statuePinJie or EquipPinjieType.eShengPin,
				scale = Adapter.MinScale * 0.8,
				rebirthCount = iter_12_7.rebirthCount
			}
			local var_12_3 = figure.createHero(var_12_2)

			var_12_3:setPosition(Adapter.AutoPos(iter_12_7.Position.x, iter_12_7.Position.y - 10))
			arg_12_0:addChild(var_12_3)

			local var_12_4 = display.newSprite(iter_12_7.backImage)

			var_12_4:setScale(Adapter.MinScale)
			var_12_4:setPosition(Adapter.AutoPos(iter_12_7.Position.x - 20, iter_12_7.Position.y))
			arg_12_0:addChild(var_12_4)

			local var_12_5 = var_12_4:getContentSize()

			addLabelWithColorSize(var_12_4, iter_12_7.name, ccc3(247, 211, 91), 20, CCPoint(0.5, 0.5), CCPoint(var_12_5.width / 2 + 30, var_12_5.height / 2 - 16))
		else
			local var_12_6 = display.newSprite("ui/guild/guild_027.png")

			var_12_6:setScale(Adapter.MinScale)
			var_12_6:setPosition(Adapter.AutoPos(iter_12_7.Position.x, iter_12_7.Position.y - 15))
			arg_12_0:addChild(var_12_6)

			local var_12_7 = CCSprite:create(iter_12_7.Image):getTextureRect().size
			local var_12_8 = display.newSprite(iter_12_7.Image)

			var_12_8:setScale(Adapter.MinScale * 0.7)
			var_12_8:setPosition(Adapter.AutoPos(iter_12_7.Position.x, iter_12_7.Position.y + 140))
			arg_12_0:addChild(var_12_8)
		end
	end
end

function var_0_2.showDonates(arg_13_0, arg_13_1)
	local var_13_0 = display.newScale9Sprite("ui/guild/guild_007.png")

	var_13_0:setPreferredSize(Adapter.AutoSize(930, 150))
	var_13_0:setAnchorPoint(CCPoint(0.5, 0))
	var_13_0:setPosition(ccp(display.cx, 0))
	arg_13_0:addChild(var_13_0)

	arg_13_0.stoveList = {
		{
			Tag = 1,
			Image = "ui/guild/guild_071.png",
			Position = CCPoint(780, 75),
			text = string.lf("大量")
		},
		{
			Tag = 2,
			Image = "ui/guild/guild_072.png",
			Position = CCPoint(480, 75),
			text = string.lf("中量")
		},
		{
			Tag = 3,
			Image = "ui/guild/guild_073.png",
			Position = CCPoint(180, 75),
			text = string.lf("少量")
		}
	}

	for iter_13_0 = 1, table.nums(arg_13_1.worshipInfos) do
		local var_13_1 = arg_13_1.worshipInfos[iter_13_0]

		arg_13_0.stoveList[iter_13_0].costGold = var_13_1.costGold
		arg_13_0.stoveList[iter_13_0].costIngot = var_13_1.costIngot
		arg_13_0.stoveList[iter_13_0].playerCoin = var_13_1.playerCoin
		arg_13_0.stoveList[iter_13_0].unionCoin = var_13_1.unionCoin
	end

	for iter_13_1, iter_13_2 in pairs(arg_13_0.stoveList) do
		local var_13_2 = display.newSprite(iter_13_2.Image)

		var_13_2:setScale(Adapter.MinScale)
		var_13_2:setPosition(Adapter.AutoPos(iter_13_2.Position.x - 100, iter_13_2.Position.y))
		arg_13_0:addChild(var_13_2)

		local var_13_3 = string.lf("%s香火:#00FF00 %s", iter_13_2.text, iter_13_2.costGold > 0 and iter_13_2.costGold .. string.lf("银币") or iter_13_2.costIngot .. string.lf("元宝"))

		addLabelWithColorSize(arg_13_0, var_13_3, ccc3(247, 211, 91), 20, CCPoint(0, 0.5), Adapter.AutoPos(iter_13_2.Position.x - 40, iter_13_2.Position.y + 55))
		addLabelWithColorSize(arg_13_0, string.lf("仙盟贡献:#00FF00 +%s", iter_13_2.unionCoin), ccc3(247, 211, 91), 20, CCPoint(0, 0.5), Adapter.AutoPos(iter_13_2.Position.x - 40, iter_13_2.Position.y + 27.5))
		addLabelWithColorSize(arg_13_0, string.lf("我的晶石:#00FF00 +%s", iter_13_2.playerCoin), ccc3(247, 211, 91), 20, CCPoint(0, 0.5), Adapter.AutoPos(iter_13_2.Position.x - 40, iter_13_2.Position.y))

		local var_13_4 = CCSprite:create("ui/PK/PK_018.png"):getTextureRect().size
		local var_13_5 = ui.newControlButton({
			fontSize = 20,
			disabledImage = "ui/PK/PK_054.png",
			normalImage = "ui/PK/PK_018.png",
			text = string.lf("捐献"),
			size = Adapter.MinSize(var_13_4.width, var_13_4.height),
			position = Adapter.AutoPos(iter_13_2.Position.x + 40, iter_13_2.Position.y - 45),
			clickAction = function()
				arg_13_0.guildWorshipRequest:request(iter_13_2.Tag)
			end
		})

		var_13_5:setEnabled(arg_13_1.isWorship > 0)
		arg_13_0:addChild(var_13_5)

		iter_13_2.button = var_13_5
	end
end

return var_0_2
