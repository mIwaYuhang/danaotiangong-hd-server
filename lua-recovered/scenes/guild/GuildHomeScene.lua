require("data.player")
require("data.guild")
require("network.GuildRequest")

local var_0_0 = require("base.cache")
local var_0_1 = require("scenes.ToolLayer")
local var_0_2 = {
	tagPageAnnounce = 2,
	tagPageMessage = 1
}
local var_0_3 = {
	tagHall = 3,
	tagBoss = 2,
	tagMsgBoard = 8,
	tagManager = 7,
	tagPeach = 1,
	tagPalace = 5,
	tagMember = 6,
	tagStore = 4
}
local var_0_4 = class("GuildHomeScene", function()
	return display.newScene("GuildHomeScene")
end)

function var_0_4.ctor(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or {}

	local var_2_0 = display.newSprite("ui/guild/guild_012.jpg", display.cx, display.cy)

	var_2_0:setScale(Adapter.AutoScaleY)
	arg_2_0:addChild(var_2_0)

	arg_2_0.bgSprite = var_2_0
	arg_2_0.bgSize = var_2_0:getContentSize()
	arg_2_0.logList = {}
	arg_2_0.mainButtonInfos = {}

	local var_2_1 = CCSprite:create("ui/common/common_061.png"):getTextureRect().size
	local var_2_2 = ui.newControlButton({
		normalImage = "ui/common/common_061.png",
		size = Adapter.MinSize(var_2_1.width, var_2_1.height),
		position = Adapter.AutoPos(900, 600),
		clickAction = arg_2_1.returnAction or function()
			game.enterHomeScene()
		end
	})

	arg_2_0:addChild(var_2_2)
	arg_2_0:showMainMenu()

	local var_2_3 = arg_2_0:createGuildInfo()

	var_2_3:setScale(Adapter.MinScale)
	var_2_3:setAnchorPoint(CCPoint(0.5, 1))
	var_2_3:setPosition(Adapter.AutoPos(480, 640))
	arg_2_0:addChild(var_2_3)
	arg_2_0:initRequests()
	arg_2_0.playerGuildRequest:request()
	arg_2_0.guildLogListRequest:request(0)
	GuideLayer:showMissionReward(arg_2_0, TaskType.eTaskTeaching, TaskEntryType.eXianMeng, 1)
end

function var_0_4.initRequests(arg_4_0)
	local function var_4_0()
		local var_5_0 = arg_4_0.playerGuildRequest.restable

		var_0_0.set("GetPlayerGuildInfoRequest", var_5_0)
		arg_4_0.nameLabel:setString(var_5_0.UnionName)
		arg_4_0.levelLabel:setString(string.lf("等级: #00FF00%s", var_5_0.UnionLv))
		arg_4_0.rankLabel:setString(string.lf("排名: #00FF00%s", var_5_0.UnionRank))
		arg_4_0.guildCoinLabel:setString(string.lf("仙盟贡献: #00FF00%s", var_5_0.CurUnionCoin))
		arg_4_0.positionLabel:setString("#00FF00[" .. GuildPositionName[var_5_0.PositionId] .. "]")
		arg_4_0.myCoinLabel:setValue(var_5_0.PlayerUnionCoin)
		arg_4_0:showLeftMenu(var_5_0)

		local var_5_1 = arg_4_0:createLogView(var_5_0)

		var_5_1:setScale(Adapter.MinScale)
		var_5_1:setAnchorPoint(CCPoint(0.5, 0))
		var_5_1:setPosition(Adapter.AutoPos(480, 0))
		arg_4_0:addChild(var_5_1)

		if var_5_0.NotifyUnion then
			if var_5_0.NotifyUnion.bBossChange ~= nil and var_5_0.NotifyUnion.bBossChange == true then
				arg_4_0:showCanDoAction(var_0_3.tagBoss, true)
			end

			if var_5_0.PositionId == GuildPositionId.eChengYuan then
				-- block empty
			else
				if var_5_0.NotifyUnion.bHavePosition ~= nil and var_5_0.NotifyUnion.bHavePosition == true then
					arg_4_0:showCanDoAction(var_0_3.tagHall, true)
				end

				if var_5_0.NotifyUnion.bNewApply ~= nil and var_5_0.NotifyUnion.bNewApply == true then
					arg_4_0:showCanDoAction(var_0_3.tagHall, true)
				end

				if var_5_0.NotifyUnion.bUpgrade ~= nil and var_5_0.NotifyUnion.bUpgrade == true then
					arg_4_0:showCanDoAction(var_0_3.tagHall, true)
				end
			end

			if var_5_0.NotifyUnion.bWorship ~= nil and var_5_0.NotifyUnion.bWorship == true then
				arg_4_0:showCanDoAction(var_0_3.tagPalace, true)
			end

			if var_5_0.NotifyUnion.IfNewMegBoard ~= nil and var_5_0.NotifyUnion.IfNewMegBoard == true then
				arg_4_0:showCanDoAction(var_0_3.tagMsgBoard, true)
			end
		end
	end

	arg_4_0.playerGuildRequest = GetPlayerGuildInfoRequest:new()

	arg_4_0.playerGuildRequest:setResponseNormalHandler(var_4_0)

	local function var_4_1()
		showFlashImage({
			image = "uilocal/enhance/enhance_txt_007.png",
			scale = 1,
			parent = arg_4_0,
			position = CCPoint(display.cx, display.cy),
			callback = function()
				local var_7_0 = var_0_0.get("GetPlayerGuildInfoRequest")

				var_7_0.Notice = arg_4_0.tmpText

				arg_4_0.tmpLabel:setString(arg_4_0.tmpText)
				var_0_0.set("GetPlayerGuildInfoRequest", var_7_0)

				arg_4_0.tmpText = nil
				arg_4_0.tmpLabel = nil
			end
		})
	end

	arg_4_0.updateNoticeRequest = UpdateGuildNoticeRequest:new()

	arg_4_0.updateNoticeRequest:setResponseNormalHandler(var_4_1)

	local function var_4_2()
		showFlashImage({
			image = "uilocal/enhance/enhance_txt_007.png",
			scale = 1,
			parent = arg_4_0,
			position = CCPoint(display.cx, display.cy),
			callback = function()
				local var_9_0 = var_0_0.get("GetPlayerGuildInfoRequest")

				var_9_0.OutNotice = arg_4_0.tmpText

				var_0_0.set("GetPlayerGuildInfoRequest", var_9_0)

				arg_4_0.tmpText = nil
				arg_4_0.tmpLabel = nil
			end
		})
	end

	arg_4_0.updateOutNoticeRequest = UpdateGuildOutNoticeRequest:new()

	arg_4_0.updateOutNoticeRequest:setResponseNormalHandler(var_4_2)

	local function var_4_3()
		arg_4_0.logList = arg_4_0.guildLogListRequest.restable

		if arg_4_0.tableView ~= nil and table.nums(arg_4_0.logList) > 0 then
			arg_4_0.tableView:reloadData(arg_4_0.logList)
		end
	end

	arg_4_0.guildLogListRequest = GuildLogListRequest:new()

	arg_4_0.guildLogListRequest:setResponseNormalHandler(var_4_3)
end

function var_0_4.showMainMenu(arg_11_0)
	local var_11_0 = {
		{
			normalImage = "ui/guild/guild_009.png",
			textImage = "uilocal/guild/guild_text_002.png",
			canDoImage = "",
			tag = var_0_3.tagPeach,
			position = CCPoint(arg_11_0.bgSize.width / 2 + 300, arg_11_0.bgSize.height / 2 + 80),
			clickAction = function()
				if Player.systemOpenControllers.IsShowXT == 1 then
					game.enterGuildPeachScene()
				else
					showFlashNotice(string.lf("暂未开放"))
				end
			end
		},
		{
			normalImage = "ui/guild/guild_010.png",
			textImage = "uilocal/guild/guild_text_003.png",
			canDoImage = "ui/slave/slave_014.png",
			tag = var_0_3.tagBoss,
			position = CCPoint(arg_11_0.bgSize.width / 2 + 320, arg_11_0.bgSize.height / 2 - 150),
			clickAction = function()
				game.enterGuildMapScene()
			end
		},
		{
			normalImage = "ui/guild/guild_011.png",
			textImage = "uilocal/guild/guild_text_032.png",
			canDoImage = "ui/guild/guild_096.png",
			tag = var_0_3.tagHall,
			position = CCPoint(arg_11_0.bgSize.width / 2 + 0, arg_11_0.bgSize.height / 2 + 40),
			clickAction = function()
				game.enterGuildHallScene()
			end
		},
		{
			normalImage = "ui/guild/guild_014.png",
			textImage = "uilocal/guild/guild_text_004.png",
			canDoImage = "ui/guild/guild_097.png",
			tag = var_0_3.tagStore,
			position = CCPoint(arg_11_0.bgSize.width / 2 - 360, arg_11_0.bgSize.height / 2 - 140),
			clickAction = function()
				game.enterGuildStoreScene()
			end
		},
		{
			normalImage = "ui/guild/guild_076.png",
			textImage = "uilocal/guild/guild_text_001.png",
			canDoImage = "ui/guild/guild_095.png",
			tag = var_0_3.tagPalace,
			position = CCPoint(arg_11_0.bgSize.width / 2 - 280, arg_11_0.bgSize.height / 2 + 40),
			clickAction = function()
				game.enterGuildPalaceScene()
			end
		}
	}

	table.foreach(var_11_0, function(arg_17_0, arg_17_1)
		local var_17_0 = ui.newControlButton(arg_17_1)

		arg_11_0.bgSprite:addChild(var_17_0)
		table.insert(arg_11_0.mainButtonInfos, {
			tag = arg_17_1.tag,
			button = var_17_0
		})

		local var_17_1 = CCSprite:create(arg_17_1.normalImage):getTextureRect().size
		local var_17_2 = display.newSprite(arg_17_1.textImage, var_17_1.width / 2, 20)

		var_17_0:addChild(var_17_2)

		if arg_17_1.canDoImage ~= nil and #arg_17_1.canDoImage > 0 then
			arg_11_0:showCanDoImage(arg_17_1.tag, arg_17_1.canDoImage)
			arg_11_0:showCanDoAction(arg_17_1.tag, false)
		end
	end)
end

function var_0_4.showLeftMenu(arg_18_0, arg_18_1)
	local var_18_0 = {
		{
			normalImage = "ui/guild/guild_004.png",
			tag = var_0_3.tagMember,
			clickAction = function()
				game.enterGuildMemberScene()
			end
		},
		{
			normalImage = "ui/guild/guild_005.png",
			tag = var_0_3.tagMsgBoard,
			clickAction = function()
				local var_20_0 = require("scenes.guild.GuildMsgBoardLayer").new()

				arg_18_0:addChild(var_20_0)
				arg_18_0:showCanDoAction(var_0_3.tagMsgBoard, false)
			end
		}
	}
	local var_18_1 = 590

	for iter_18_0 = 1, table.nums(var_18_0) do
		local var_18_2 = var_18_0[iter_18_0]
		local var_18_3 = CCSprite:create(var_18_2.normalImage):getTextureRect().size
		local var_18_4 = ui.newControlButton({
			normalImage = var_18_2.normalImage,
			size = Adapter.MinSize(var_18_3.width, var_18_3.height),
			position = Adapter.AutoPos(60, var_18_1),
			clickAction = var_18_2.clickAction
		})

		arg_18_0:addChild(var_18_4)

		var_18_1 = var_18_1 - 110

		table.insert(arg_18_0.mainButtonInfos, {
			tag = var_18_2.tag,
			button = var_18_4
		})
		arg_18_0:showCanDoPoint(var_18_2.tag)
		arg_18_0:showCanDoAction(var_18_2.tag, false)
	end
end

function var_0_4.createGuildInfo(arg_21_0)
	local var_21_0 = display.newSprite("ui/guild/guild_008.png")
	local var_21_1 = var_21_0:getContentSize()

	arg_21_0.nameLabel = addLabelWithColorSize(var_21_0, "", ccc3(247, 247, 247), 22, CCPoint(0.5, 0.5), CCPoint(var_21_1.width / 2, 80))
	arg_21_0.levelLabel = addLabelWithColorSize(var_21_0, "", ccc3(247, 247, 247), 20, CCPoint(1, 0.5), CCPoint(var_21_1.width / 2 - 170, 83))
	arg_21_0.rankLabel = addLabelWithColorSize(var_21_0, "", ccc3(247, 247, 247), 20, CCPoint(0, 0.5), CCPoint(var_21_1.width / 2 + 170, 83))
	arg_21_0.guildCoinLabel = addLabelWithColorSize(var_21_0, "", ccc3(247, 211, 91), 20, CCPoint(0.5, 0.5), CCPoint(var_21_1.width / 2, 40))
	arg_21_0.positionLabel = addLabelWithColorSize(var_21_0, "", ccc3(247, 211, 91), 20, CCPoint(1, 0.5), CCPoint(var_21_1.width / 2 - 25, 12))
	arg_21_0.myCoinLabel = createItemCountNode({
		value = 0,
		type = ItemType.eGuildCoin,
		color = ccc3(0, 255, 0)
	})

	arg_21_0.myCoinLabel:setAnchorPoint(CCPoint(0, 0.5))
	arg_21_0.myCoinLabel:setPosition(CCPoint(var_21_1.width / 2, 12))
	var_21_0:addChild(arg_21_0.myCoinLabel)

	local var_21_2 = ui.newControlButton({
		normalImage = "ui/guild/guild_046.png",
		position = CCPoint(var_21_1.width / 2 + 150, var_21_1.height / 2 - 25),
		clickAction = function()
			local var_22_0 = var_0_0.get("GetPlayerGuildInfoRequest")

			if var_22_0 == nil then
				return
			end

			var_0_1.createDialog({
				show = var_0_1.eShowEditBox,
				data = {
					title = string.lf("请输入新的仙盟宣言:"),
					text = var_22_0.OutNotice and var_22_0.OutNotice or ""
				},
				callback = function(arg_23_0)
					if var_22_0.PositionId > GuildPositionId.eZhangLaoRight then
						showFlashNotice(string.lf("只有盟主和长老才能修改对外宣言"))

						return
					end

					if string.asciilen(arg_23_0) > 200 then
						showFlashNotice(string.lf("不能超过100个汉字或200个英文字符"))

						return
					end

					if var_22_0.OutNotice ~= nil and var_22_0.OutNotice == arg_23_0 then
						-- block empty
					else
						arg_21_0.tmpText = arg_23_0

						arg_21_0.updateOutNoticeRequest:request(arg_23_0)
					end
				end
			}):show()
		end
	})

	var_21_0:addChild(var_21_2)

	local var_21_3 = ui.newControlButton({
		normalImage = "ui/guild/guild_047.png",
		position = CCPoint(var_21_1.width / 2 + 220, var_21_1.height / 2 - 25),
		clickAction = function()
			local var_24_0 = require("scenes.guild.GuildCreateLayer").new({
				type = GuildCreateLayerType.eGuildRank
			})

			arg_21_0:addChild(var_24_0, DefaultZOrder.ePopupLayer)
		end
	})

	var_21_0:addChild(var_21_3)

	return var_21_0
end

function var_0_4.createLogView(arg_25_0, arg_25_1)
	local var_25_0 = display.newSprite("ui/guild/guild_007.png")
	local var_25_1 = var_25_0:getContentSize()

	local function var_25_2()
		if arg_25_0.messagePage == nil then
			arg_25_0.messagePage = CCLayerColor:create(ccc4(0, 0, 0, 0))

			arg_25_0.messagePage:setContentSize(var_25_1)
			var_25_0:addChild(arg_25_0.messagePage)

			local var_26_0 = CCSize(var_25_1.width - 10, 60)
			local var_26_1 = createTableView({
				reverse = true,
				direction = kCCScrollViewDirectionVertical,
				size = CCSize(var_25_1.width - 10, var_25_1.height - 10),
				dataset = arg_25_0.logList,
				sizehandler = function(arg_27_0, arg_27_1)
					return var_26_0
				end,
				cellhandler = function(arg_28_0, arg_28_1, arg_28_2)
					local var_28_0 = CCLayerColor:create(arg_28_1 % 2 == 0 and ccc4(46, 39, 29, 0) or ccc4(100, 0, 0, 50))

					var_28_0:setContentSize(var_26_0)

					local var_28_1 = string.lf("【%s】%s", getFormatCountDownTime(arg_28_2.Times), getFullLogContent(arg_28_2.Content, arg_28_2.Type))
					local var_28_2 = addLabelWithColorSize(var_28_0, var_28_1, ccc3(247, 247, 247), 18, CCPoint(0, 0.5), CCPoint(0, var_26_0.height / 2))

					var_28_2:setDimensions(CCSize(var_26_0.width, var_26_0.height))
					var_28_2:setHorizontalAlignment(kCCTextAlignmentLeft)
					var_28_2:setVerticalAlignment(kCCVerticalTextAlignmentCenter)

					return var_28_0
				end
			})

			var_26_1:setPosition(5, 5)
			arg_25_0.messagePage:addChild(var_26_1)

			arg_25_0.tableView = var_26_1
		end

		if arg_25_0.announcePage ~= nil then
			arg_25_0.announcePage:setVisible(false)
		end

		arg_25_0.messagePage:setVisible(true)
	end

	local function var_25_3()
		if arg_25_0.announcePage == nil then
			arg_25_0.announcePage = CCLayerColor:create(ccc4(0, 0, 0, 0))

			arg_25_0.announcePage:setContentSize(var_25_1)
			var_25_0:addChild(arg_25_0.announcePage)

			local var_29_0 = addLabelWithColorSize(arg_25_0.announcePage, arg_25_1.Notice, ccc3(192, 120, 74), 20, CCPoint(0.5, 1), CCPoint(var_25_1.width / 2 - 10, var_25_1.height - 20))

			var_29_0:setDimensions(CCSize(var_25_1.width - 80, 100))
			var_29_0:setHorizontalAlignment(kCCTextAlignmentLeft)
			var_29_0:setVerticalAlignment(kCCVerticalTextAlignmentTop)

			local var_29_1 = ui.newControlButton({
				normalImage = "ui/guild/guild_075.png",
				anchorPoint = CCPoint(0.5, 0.5),
				position = CCPoint(var_25_1.width - 30, var_25_1.height - 30),
				clickAction = function()
					if arg_25_1 == nil then
						return
					end

					if arg_25_1.PositionId == GuildPositionId.eChengYuan then
						showFlashNotice(string.lf("普通成员无权修改公告"))

						return
					end

					var_0_1.createDialog({
						show = var_0_1.eShowEditBox,
						data = {
							title = string.lf("请输入新的仙盟公告:"),
							text = arg_25_1.Notice and arg_25_1.Notice or ""
						},
						callback = function(arg_31_0)
							if string.asciilen(arg_31_0) > 200 then
								showFlashNotice(string.lf("不能超过100个汉字或200个英文字符"))

								return
							end

							if arg_25_1.Notice ~= nil and arg_25_1.Notice == arg_31_0 then
								-- block empty
							else
								arg_25_0.tmpLabel = var_29_0
								arg_25_0.tmpText = arg_31_0

								arg_25_0.updateNoticeRequest:request(arg_31_0)
							end
						end
					}):show()
				end
			})

			arg_25_0.announcePage:addChild(var_29_1)
		end

		if arg_25_0.messagePage ~= nil then
			arg_25_0.messagePage:setVisible(false)
		end

		arg_25_0.announcePage:setVisible(true)
	end

	local var_25_4 = {
		{
			isDefault = true,
			x = 60,
			tag = var_0_2.tagPageMessage,
			titleText = string.lf("消息")
		},
		{
			isDefault = false,
			x = 160,
			tag = var_0_2.tagPageAnnounce,
			titleText = string.lf("公告")
		}
	}

	local function var_25_5(arg_32_0, arg_32_1)
		local var_32_0 = tolua.cast(arg_32_1, "CCControlButton")
		local var_32_1 = var_32_0:getTag()

		if arg_25_0.currTag ~= nil and arg_25_0.currTag == var_32_1 then
			return
		end

		for iter_32_0, iter_32_1 in pairs(var_25_4) do
			if iter_32_1.tag == arg_25_0.currTag then
				iter_32_1.button:setBackgroundSpriteForState(CCScale9Sprite:create("ui/guild/guild_002.png"), CCControlStateNormal)
			end
		end

		arg_25_0.currTag = var_32_1

		var_32_0:setBackgroundSpriteForState(CCScale9Sprite:create("ui/guild/guild_001.png"), CCControlStateNormal)

		if arg_25_0.currTag == var_0_2.tagPageMessage then
			var_25_2()
		else
			var_25_3()
		end
	end

	for iter_25_0, iter_25_1 in pairs(var_25_4) do
		local var_25_6 = ui.newControlButton({
			fontSize = 20,
			normalImage = "ui/guild/guild_002.png",
			highlightedImage = "ui/guild/guild_001.png",
			text = iter_25_1.titleText,
			anchorPoint = CCPoint(0.5, 0),
			position = CCPoint(iter_25_1.x, var_25_1.height - 1),
			clickAction = var_25_5
		})

		var_25_6:setTag(iter_25_1.tag)

		iter_25_1.button = var_25_6

		var_25_0:addChild(var_25_6)

		if iter_25_1.tag == var_0_2.tagPageMessage then
			var_25_5(nil, var_25_6)
		end
	end

	return var_25_0
end

function var_0_4.getTagButton(arg_33_0, arg_33_1)
	local var_33_0

	for iter_33_0, iter_33_1 in pairs(arg_33_0.mainButtonInfos) do
		if iter_33_1.tag == arg_33_1 then
			var_33_0 = iter_33_1.button

			break
		end
	end

	return var_33_0
end

function var_0_4.showCanDoPoint(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0:getTagButton(arg_34_1)

	if var_34_0 ~= nil then
		local var_34_1 = var_34_0:getPreferredSize()

		var_34_0.canDoSprite = ui.createRedPoint({
			parent = var_34_0,
			position = ccp(var_34_1.width * 0.8, var_34_1.height * 0.8),
			scale = 0.7 * Adapter.MinScale
		})
	end
end

function var_0_4.showCanDoImage(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_0:getTagButton(arg_35_1)

	if var_35_0 ~= nil then
		local var_35_1 = var_35_0:getPreferredSize()
		local var_35_2 = var_35_1.width / 2
		local var_35_3 = var_35_1.height / 2
		local var_35_4 = display.newSprite(arg_35_2, var_35_2, var_35_3)

		var_35_0:addChild(var_35_4)

		local var_35_5 = CCArray:create()

		var_35_5:addObject(CCMoveTo:create(1, CCPoint(var_35_2, var_35_3 + 20)))
		var_35_5:addObject(CCMoveTo:create(1, CCPoint(var_35_2, var_35_3)))
		var_35_4:runAction(CCRepeatForever:create(CCSequence:create(var_35_5)))

		var_35_0.canDoSprite = var_35_4
	end
end

function var_0_4.showCanDoAction(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_0:getTagButton(arg_36_1)

	if var_36_0 ~= nil and var_36_0.canDoSprite ~= nil then
		var_36_0.canDoSprite:setVisible(arg_36_2)
	end
end

return var_0_4
