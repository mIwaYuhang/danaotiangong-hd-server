require("data.player")
require("network.GuildRequest")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = require("base.cache")
local var_0_2 = class("GuildHallScene", function()
	return display.newScene("GuildHallScene")
end)

function var_0_2.ctor(arg_2_0, arg_2_1)
	local var_2_0 = display.newSprite("ui/guild/guild_056.jpg", display.cx, display.cy)

	var_2_0:setScale(Adapter.AutoScaleY)
	arg_2_0:addChild(var_2_0)

	arg_2_0.bgSprite = var_2_0
	arg_2_0.bgSize = var_2_0:getContentSize()

	local var_2_1 = display.newScale9Sprite("ui/guild/guild_007.png", display.cx, display.height - Adapter.AutoHeight(20))

	var_2_1:setPreferredSize(Adapter.AutoSize(500, 40))

	local var_2_2 = string.lf("盟主十天不上线 其位将自动禅让")
	local var_2_3 = addLabelWithColorSize(var_2_1, var_2_2, ccc3(255, 241, 250), 30, CCPoint(0.5, 0.5), Adapter.AutoPos(250, 20))

	if IPlatform:instance():getConfig("Channel") == "ZSY_VN" then
		var_2_3:setFontSize(20)
	end

	arg_2_0:addChild(var_2_1)

	local var_2_4 = CCSprite:create("ui/common/common_061.png"):getTextureRect().size
	local var_2_5 = ui.newControlButton({
		normalImage = "ui/common/common_061.png",
		size = Adapter.MinSize(var_2_4.width, var_2_4.height),
		position = Adapter.AutoPos(900, 600),
		clickAction = function()
			game.enterGuildHomeScene()
		end
	})

	arg_2_0:addChild(var_2_5)

	local var_2_6 = var_0_1.get("GetPlayerGuildInfoRequest")
	local var_2_7 = CCSprite:create("ui/common/common_110.png"):getTextureRect().size
	local var_2_8 = ui.newControlButton({
		fontSize = 25,
		normalImage = "ui/common/common_110.png",
		text = var_2_6.PositionId == GuildPositionId.eMengZhu and string.lf("解散仙盟") or string.lf("退出仙盟"),
		size = Adapter.MinSize(var_2_7.width, var_2_7.height),
		position = Adapter.AutoPos(80, 460),
		clickAction = function()
			if var_2_6.PositionId == GuildPositionId.eMengZhu then
				ui.showMessageBox({
					text = string.lf("上仙，打江山不易，且行且珍惜，解散后24小时内无法加入其它仙盟，您真的决定要解散这个仙盟吗？"),
					title1 = string.lf("解散仙盟"),
					title2 = string.lf("取消"),
					action1 = function()
						arg_2_0.guildDeleteRequest:requestDisband()
					end
				})
			else
				ui.showMessageBox({
					text = string.lf("上仙，您真的要退出吗？退出后24小时内您将不能申请仙盟。"),
					title1 = string.lf("退出仙盟"),
					title2 = string.lf("取消"),
					action1 = function()
						arg_2_0.guildDeleteRequest:requestQuit()
					end
				})
			end
		end
	})

	arg_2_0:addChild(var_2_8)

	if var_2_6.PositionId == GuildPositionId.eMengZhu then
		local var_2_9 = 1
		local var_2_10 = ui.newControlButton({
			fontSize = 25,
			normalImage = "ui/common/common_110.png",
			text = string.lf("转让盟主"),
			size = Adapter.MinSize(var_2_7.width, var_2_7.height),
			position = Adapter.AutoPos(80, 400),
			clickAction = function()
				game.enterGuildMemberScene({
					back = game.enterGuildHallScene,
					position = var_2_9
				})
			end
		})

		arg_2_0:addChild(var_2_10)
	end

	if var_2_6.PositionId == GuildPositionId.eMengZhu or var_2_6.PositionId == GuildPositionId.eZhangLaoLeft or var_2_6.PositionId == GuildPositionId.eZhangLaoRight then
		local var_2_11 = ui.newControlButton({
			fontSize = 25,
			normalImage = "ui/common/common_110.png",
			text = string.lf("晶石分配"),
			size = Adapter.MinSize(var_2_7.width, var_2_7.height),
			position = Adapter.AutoPos(880, 460),
			clickAction = function()
				game.enterGuildMemberScene({
					distribute = true,
					back = game.enterGuildHallScene
				})
			end
		})

		arg_2_0:addChild(var_2_11)
	end

	arg_2_0.characterList = {
		{
			Image = "ui/guild/guild_060.png",
			textImg = "uilocal/guild/guild_text_043.png",
			Tag = 1,
			title = string.lf("建筑升级"),
			Position = CCPoint(140, 130),
			Text = string.lf("上仙，有建筑可以升级啦"),
			newMsg = var_2_6.NotifyUnion.bUpgrade
		},
		{
			Image = "ui/guild/guild_057.png",
			textImg = "uilocal/guild/guild_text_041.png",
			Tag = 2,
			title = string.lf("职位任免"),
			Position = CCPoint(360, 160),
			Text = string.lf("上仙，还有部分职位空缺呢"),
			newMsg = var_2_6.NotifyUnion.bHavePosition
		},
		{
			Image = "ui/guild/guild_058.png",
			textImg = "uilocal/guild/guild_text_042.png",
			Tag = 3,
			title = string.lf("人事审批"),
			Position = CCPoint(600, 160),
			Text = string.lf("上仙，有新的加入申请哦"),
			newMsg = var_2_6.NotifyUnion.bNewApply
		},
		{
			Image = "ui/guild/guild_059.png",
			newMsg = false,
			textImg = "uilocal/guild/guild_text_040.png",
			Tag = 4,
			title = string.lf("成员列表"),
			Position = CCPoint(820, 130),
			Text = string.lf("上仙，看看您的仙友们吧")
		}
	}

	arg_2_0:showCharacters(var_2_6)
	arg_2_0:showHallInfo(var_2_6)
	arg_2_0:initRequests()
end

function var_0_2.initRequests(arg_9_0)
	local function var_9_0()
		game.enterHomeScene()
	end

	arg_9_0.guildDeleteRequest = GuildRequest:new()

	arg_9_0.guildDeleteRequest:setResponseNormalHandler(var_9_0)
end

function var_0_2.showHallInfo(arg_11_0, arg_11_1)
	local var_11_0 = display.newSprite("ui/guild/guild_025.png")

	var_11_0:setScale(Adapter.MinScale)
	var_11_0:setAnchorPoint(CCPoint(0, 1))
	var_11_0:setPosition(Adapter.AutoPos(0, 655))
	arg_11_0:addChild(var_11_0)

	local var_11_1 = 134
	local var_11_2 = 30

	addLabelWithColorSize(var_11_0, string.lf("大厅等级:#00FF00 %s", arg_11_1.UnionLv), ccc3(247, 211, 91), 20, CCPoint(0, 0.5), CCPoint(10, var_11_1))

	local var_11_3 = var_11_1 - var_11_2

	addLabelWithColorSize(var_11_0, string.lf("仙盟贡献:#00FF00 %s", arg_11_1.CurUnionCoin), ccc3(247, 211, 91), 20, CCPoint(0, 0.5), CCPoint(10, var_11_3))

	local var_11_4 = var_11_3 - var_11_2

	addLabelWithColorSize(var_11_0, string.lf("仙盟排名:#00FF00 %s", arg_11_1.UnionRank), ccc3(247, 211, 91), 20, CCPoint(0, 0.5), CCPoint(10, var_11_4))

	local var_11_5 = var_11_4 - var_11_2

	addLabelWithColorSize(var_11_0, string.lf("仙盟人数:#00FF00 %s", arg_11_1.MemberCount), ccc3(247, 211, 91), 20, CCPoint(0, 0.5), CCPoint(10, var_11_5))

	local var_11_6 = var_11_5 - var_11_2

	addLabelWithColorSize(var_11_0, string.lf("仙盟晶石:#00FF00 %s", arg_11_1.TPUC), ccc3(247, 211, 91), 20, CCPoint(0, 0.5), CCPoint(10, var_11_6))

	local var_11_7 = var_11_6 - var_11_2
end

function var_0_2.showCharacters(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.characterList) do
		local var_12_0 = display.newSprite("ui/guild/guild_063.png")

		var_12_0:setScale(Adapter.MinScale)
		var_12_0:setPosition(Adapter.AutoPos(iter_12_1.Position.x, iter_12_1.Position.y - 40))
		arg_12_0:addChild(var_12_0)

		local var_12_1 = var_12_0:getContentSize()
		local var_12_2 = display.newSprite("ui/guild/guild_082.png", var_12_1.width / 2, 30)

		var_12_0:addChild(var_12_2)

		local var_12_3 = var_12_2:getContentSize()
		local var_12_4 = display.newSprite(iter_12_1.textImg, var_12_3.width / 2, var_12_3.height / 2)

		var_12_2:addChild(var_12_4)

		local var_12_5 = CCSprite:create(iter_12_1.Image):getTextureRect().size
		local var_12_6 = ui.newControlButton({
			normalImage = iter_12_1.Image,
			size = Adapter.MinSize(var_12_5.width, var_12_5.height),
			position = Adapter.AutoPos(iter_12_1.Position.x, iter_12_1.Position.y + 80),
			clickAction = function()
				if iter_12_1.Tag == 1 then
					game.enterGuildUpgradeScene()
				elseif iter_12_1.Tag == 2 then
					if arg_12_1.PositionId == GuildPositionId.eMengZhu or arg_12_1.PositionId == GuildPositionId.eZhangLaoLeft or arg_12_1.PositionId == GuildPositionId.eZhangLaoRight then
						game.enterGuildPersonnelScene({
							back = game.enterGuildHallScene
						})
					else
						showFlashNotice(string.lf("上仙, 您的职位暂无法进行此操作~"))
					end
				elseif iter_12_1.Tag == 3 then
					if arg_12_1.PositionId == GuildPositionId.eChengYuan then
						showFlashNotice(string.lf("上仙, 您的职位暂无法进行此操作~"))
					else
						game.enterGuildRequestScene({
							back = game.enterGuildHallScene
						})
					end
				elseif iter_12_1.Tag == 4 then
					game.enterGuildMemberScene({
						back = game.enterGuildHallScene
					})
				end
			end
		})

		arg_12_0:addChild(var_12_6)

		if (iter_12_1.Tag == 4 or arg_12_1.PositionId ~= GuildPositionId.eChengYuan) and iter_12_1.newMsg ~= nil and iter_12_1.newMsg == true then
			local var_12_7 = display.newSprite("ui/guild/guild_062.png")

			var_12_7:setScale(Adapter.MinScale)
			var_12_7:setPosition(Adapter.AutoPos(iter_12_1.Position.x, iter_12_1.Position.y + 200))
			arg_12_0:addChild(var_12_7)

			local var_12_8 = var_12_7:getContentSize()
			local var_12_9 = addLabelWithColorSize(var_12_7, iter_12_1.Text, ccc3(247, 247, 247), 20, CCPoint(0, 0), CCPoint(15, 5))

			var_12_9:setDimensions(CCSize(var_12_8.width - 30, var_12_8.height - 10))
			var_12_9:setHorizontalAlignment(kCCTextAlignmentLeft)
			var_12_9:setVerticalAlignment(kCCVerticalTextAlignmentCenter)
		end
	end
end

return var_0_2
