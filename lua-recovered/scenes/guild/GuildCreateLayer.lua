require("network.GuildRequest")

local var_0_0 = class("GuildCreateLayer", function()
	return display.newColorLayer(ccc4(0, 0, 0, 180))
end)

GuildCreateLayerType = {
	eGuildRank = 1,
	eApplyGuild = 0
}

local var_0_1 = require("framework.scheduler")

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.mShowType = arg_2_1 and arg_2_1.type

	if arg_2_0.mShowType == GuildCreateLayerType.eApplyGuild then
		arg_2_0.mCreateNeedCoin = arg_2_1.createNeedCoin
		arg_2_0.mCreateNeedLv = arg_2_1.createNeedLv
	end

	arg_2_0.mShowType = arg_2_0.mShowType or GuildCreateLayerType.eApplyGuild
	arg_2_0.mAllPageGuild = {}
	arg_2_0.mCurrPageGuild = {}
	arg_2_0.mTotalGuildPage = 1
	arg_2_0.mLocalGuildCount = 0

	arg_2_0:setUI()
end

function var_0_0.setUI(arg_3_0)
	arg_3_0:addTouchEventListener(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_3_0:setTouchEnabled(true)

	local var_3_0 = CCTextureCache:sharedTextureCache():addImage("ui/guild/guild_048.png"):getContentSizeInPixels()
	local var_3_1 = display.newSprite("ui/guild/guild_048.png", display.cx, display.cy)

	var_3_1:setScale(Adapter.MinScale)
	arg_3_0:addChild(var_3_1)

	arg_3_0.mBgSprite = var_3_1
	arg_3_0.mGuildTableView = arg_3_0:createGuildTableView()

	arg_3_0.mGuildTableView:setAnchorPoint(ccp(0, 0))
	arg_3_0.mGuildTableView:setPosition(10, 55)
	var_3_1:addChild(arg_3_0.mGuildTableView)

	local var_3_2 = display.newSprite("ui/common/common_100.png", var_3_0.width / 2, 53)

	var_3_2:setScaleX(2)
	var_3_1:addChild(var_3_2)

	local var_3_3 = display.newSprite("ui/common/common_100.png", var_3_0.width / 2, var_3_0.height - 48)

	var_3_3:setScaleX(2)
	var_3_1:addChild(var_3_3)

	if arg_3_0.mShowType == GuildCreateLayerType.eApplyGuild then
		addLabelWithColorSize(var_3_1, string.lf("上仙,你还没有加入任何仙盟呢,是准备自己创建一个仙盟还是加入已有强力仙盟呢?"), ccc3(223, 223, 0), 17, ccp(0, 1), ccp(6, var_3_0.height - 8))
		addLabelWithColorSize(var_3_1, string.lf("(同时只能申请3个仙盟,主动退出仙盟需要冷却24小时)"), ccc3(255, 15, 0), 17, ccp(0, 1), ccp(6, var_3_0.height - 28))

		arg_3_0.mApplyCDTimeLable = addLabelWithColorSize(var_3_1, "", ccc3(228, 0, 0), 17, ccp(1, 1), ccp(var_3_0.width - 6, var_3_0.height - 28))

		arg_3_0:setTimer()
	elseif arg_3_0.mShowType == GuildCreateLayerType.eGuildRank then
		addLabelWithColorSize(var_3_1, string.lf("仙盟排行"), ccc3(255, 255, 0), 24, ccp(0.5, 1), ccp(var_3_0.width / 2, var_3_0.height - 8))
	end

	local var_3_4 = {}

	if arg_3_0.mShowType == GuildCreateLayerType.eApplyGuild then
		local var_3_5 = ui.newControlButton({
			normalImage = "ui/common/common_115.png",
			titleImage = "uilocal/guild/guild_text_021.png",
			clickAction = handler(arg_3_0, arg_3_0.onCreateGuildButtonClicked)
		})

		var_3_1:addChild(var_3_5)
		table.insert(var_3_4, var_3_5)
	end

	local var_3_6 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/guild/guild_text_022.png",
		clickAction = function()
			arg_3_0:killTimer()
			arg_3_0:removeFromParentAndCleanup(true)
		end
	})

	var_3_1:addChild(var_3_6)
	table.insert(var_3_4, var_3_6)

	local var_3_7 = 10
	local var_3_8 = #var_3_4
	local var_3_9 = arg_3_0:getImageSize("ui/common/common_115.png").width
	local var_3_10 = var_3_8 * var_3_9 + (var_3_8 + 1) * var_3_7
	local var_3_11 = (var_3_0.width - var_3_10) / 2

	for iter_3_0, iter_3_1 in ipairs(var_3_4) do
		iter_3_1:setPosition(var_3_11 + iter_3_0 * (var_3_9 + var_3_7) - var_3_9 / 2, 30)
	end

	arg_3_0.mCurrentGuildListPage = 1

	arg_3_0:requestGuildList(1)
	GuideLayer:removeGuideLayerIfStepGreaterThan(TaskEntryType.eXianMeng, 1)
end

function var_0_0.createGuildTableView(arg_6_0)
	local var_6_0 = "ui/guild/guild_049.png"
	local var_6_1 = "ui/mail/mail_016.png"
	local var_6_2 = arg_6_0:getImageSize(var_6_0)

	var_6_2.width = var_6_2.width - 90
	var_6_2.height = var_6_2.height - 6
	var_6_2.height = var_6_2.height * 1.1

	local var_6_3 = arg_6_0:getImageSize(var_6_1).height
	local var_6_4 = 0
	local var_6_5 = 0

	local function var_6_6(arg_7_0, arg_7_1)
		if arg_7_1 == 0 and var_6_4 == 1 then
			return var_6_3, var_6_2.width
		elseif arg_7_1 == #arg_6_0.mCurrPageGuild + var_6_4 and var_6_5 == 1 then
			return var_6_3, var_6_2.width
		else
			return var_6_2.height, var_6_2.width
		end
	end

	local function var_6_7()
		if not arg_6_0.mCurrPageGuild then
			return 0
		end

		local var_8_0 = #arg_6_0.mCurrPageGuild

		var_6_4 = 0
		var_6_5 = 0

		if not arg_6_0:isShowingFirstPage() then
			var_6_4 = 1
			var_8_0 = var_8_0 + 1
		end

		if not arg_6_0:isShowingLastPage() then
			var_6_5 = 1
			var_8_0 = var_8_0 + 1
		end

		return var_8_0
	end

	local function var_6_8(arg_9_0, arg_9_1)
		local var_9_0 = display.newSprite(var_6_0, var_6_2.width / 2, var_6_2.height / 2 + 4)

		var_9_0:setScaleY(1.1)
		arg_9_0:addChild(var_9_0)

		local var_9_1 = arg_6_0:getImageSize("ui/guild/guild_050.png")
		local var_9_2 = display.newSprite("ui/guild/guild_050.png", 70, var_6_2.height / 2 + 10)

		arg_9_0:addChild(var_9_2)

		if arg_6_0.mShowType == GuildCreateLayerType.eApplyGuild and arg_9_1.ApplyStatus == 1 then
			local var_9_3 = display.newSprite("ui/guild/guild_100.png")

			var_9_3:setAnchorPoint(ccp(0, 1))
			var_9_3:setPosition(-4, var_6_2.height)
			arg_9_0:addChild(var_9_3)
		end

		local var_9_4
		local var_9_5
		local var_9_6 = arg_9_1.UnionRank

		if var_9_6 == 1 then
			local var_9_7 = ccc3(255, 255, 255)

			var_9_5 = display.newSprite("uilocal/PK/PK_text_001.png")
		else
			local var_9_8 = ccc3(254, 254, 144)

			var_9_5 = CCLabelAtlas:create(var_9_6, "uilocal/PK/PK_text_005.png", 27, 37, 48)

			if var_9_6 > 9999 then
				var_9_5:setScale(0.75)
			end
		end

		var_9_5:setAnchorPoint(ccp(0.5, 0.5))
		var_9_5:setPosition(var_9_1.width / 2, var_9_1.height / 2)
		var_9_2:addChild(var_9_5)
		addLabelWithColorSize(arg_9_0, arg_9_1.UnionName, ccc3(255, 255, 0), 26, ccp(0.5, 1), ccp(var_6_2.width / 2, var_6_2.height - 8))

		local var_9_9 = {
			70,
			100
		}
		local var_9_10 = addLabelWithColorSize(arg_9_0, string.lf("#FFDE8D仙盟主:#FFE400 %s", arg_9_1.LeaderName), ccc3(255, 255, 0), 22, ccp(0, 0.5), ccp(150, var_6_2.height - var_9_9[1]))
		local var_9_11 = addLabelWithColorSize(arg_9_0, string.lf("#FFDE8D仙盟等级: #FFE400Lv%s", arg_9_1.UnionLv), ccc3(255, 255, 0), 22, ccp(0, 0.5), ccp(var_6_2.width / 2 + 80, var_6_2.height - var_9_9[1]))
		local var_9_12 = addLabelWithColorSize(arg_9_0, string.lf("#FFDE8D成员数量:#FFE400 %d/%d", arg_9_1.MemberCount, arg_9_1.MaxMemberCount or -1), ccc3(255, 255, 0), 22, ccp(0, 0.5), ccp(150, var_6_2.height - var_9_9[2]))

		addLabelWithColorSize(arg_9_0, string.lf("仙盟宣言:"), ccc3(255, 222, 141), 20, ccp(0, 1), ccp(40, var_6_2.height / 2 - 32))

		local var_9_13 = 20
		local var_9_14 = var_6_2.height / 2 - 32

		if string.asciilen(arg_9_1.OutNotice) > 80 then
			var_9_13 = 18
		end

		if string.asciilen(arg_9_1.OutNotice) > 120 then
			var_9_13 = 16
			var_9_14 = var_9_14 + 30

			var_9_10:setPosition(150, var_6_2.height - var_9_9[1] + 8)
			var_9_11:setPosition(var_6_2.width / 2 + 80, var_6_2.height - var_9_9[1] + 8)
			var_9_12:setPosition(150, var_6_2.height - var_9_9[2] + 12)
		end

		local var_9_15 = addLabelWithColorSize(arg_9_0, arg_9_1.OutNotice, ccc3(223, 223, 223), var_9_13, ccp(0, 1), ccp(150, var_9_14))

		var_9_15:setHorizontalAlignment(kCCTextAlignmentLeft)
		var_9_15:setVerticalAlignment(kCCVerticalTextAlignmentTop)

		local var_9_16 = CCSizeMake(var_6_2.width - 80 - 120, 150)

		if string.asciilen(arg_9_1.OutNotice) > 120 then
			var_9_16.width = var_9_16.width - 30
		end

		var_9_15:setDimensions(var_9_16)

		if arg_6_0.mShowType == GuildCreateLayerType.eApplyGuild then
			local var_9_17
			local var_9_18
			local var_9_19

			if arg_9_1.IsApply == 1 then
				var_9_17 = "ui/guild/guild_099.png"
				var_9_19 = "uilocal/guild/guild_text_036.png"

				function var_9_18()
					arg_6_0:onCancelApplyButtonClicked(arg_9_1)
				end
			else
				var_9_17 = "ui/guild/guild_051.png"
				var_9_19 = "uilocal/guild/guild_text_023.png"

				function var_9_18()
					arg_6_0:onApplyGuildButtonClicked(arg_9_1)
				end
			end

			local var_9_20 = var_9_17
			local var_9_21 = arg_6_0:getImageSize(var_9_20)
			local var_9_22 = ui.newControlButton({
				normalImage = var_9_20,
				titleImage = var_9_19,
				position = ccp(var_6_2.width - var_9_21.width / 2, var_6_2.height / 2),
				clickAction = var_9_18
			})

			arg_9_0:addChild(var_9_22)
		end
	end

	local function var_6_9(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_1 + 1
		local var_12_1 = arg_12_0:cellAtIndex(arg_12_1)

		if var_12_1 == nil then
			var_12_1 = CCTableViewCell:new()
		end

		var_12_1:removeAllChildrenWithCleanup(true)

		if var_12_0 == #arg_6_0.mCurrPageGuild + 1 + var_6_4 and var_6_5 == 1 then
			local var_12_2 = ui.newControlButton({
				fontSize = 28,
				scaleX = 1.05,
				normalImage = var_6_1,
				text = string.lf("下一页"),
				textColor = ccc3(232, 230, 133),
				clickAction = handler(arg_6_0, arg_6_0.onGuildListNextPageBtnClicked),
				position = CCPoint(var_6_2.width / 2, var_6_3 / 2)
			})

			var_12_1:addChild(var_12_2)
		elseif var_12_0 == 1 and var_6_4 == 1 then
			local var_12_3 = ui.newControlButton({
				fontSize = 28,
				scaleX = 1.05,
				normalImage = var_6_1,
				text = string.lf("上一页"),
				textColor = ccc3(232, 230, 133),
				clickAction = handler(arg_6_0, arg_6_0.onGuildListPrePageBtnClicked),
				position = CCPoint(var_6_2.width / 2, var_6_3 / 2)
			})

			var_12_1:addChild(var_12_3)
		else
			if var_6_4 == 1 then
				var_12_0 = var_12_0 - 1
			end

			var_6_8(var_12_1, arg_6_0.mCurrPageGuild[var_12_0])
		end

		return var_12_1
	end

	local var_6_10 = CCTableView:create(CCSizeMake(var_6_2.width, 535))

	var_6_10:ignoreAnchorPointForPosition(false)
	var_6_10:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_6_10:setDirection(kCCScrollViewDirectionVertical)
	var_6_10:registerScriptHandler(var_6_6, CCTableView.kTableCellSizeForIndex)
	var_6_10:registerScriptHandler(var_6_7, CCTableView.kNumberOfCellsInTableView)
	var_6_10:registerScriptHandler(var_6_9, CCTableView.kTableCellSizeAtIndex)

	return var_6_10
end

function var_0_0.showInputNameLayer(arg_13_0)
	local var_13_0 = display.newLayer()

	arg_13_0:addTouchEventListener(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == "began" then
			return true
		end
	end, false, 1, true)
	var_13_0:setTouchEnabled(true)
	arg_13_0:addChild(var_13_0)

	arg_13_0.mInputNameLayer = var_13_0

	local var_13_1 = arg_13_0:getImageSize("ui/guild/guild_078.png")
	local var_13_2 = display.newSprite("ui/guild/guild_078.png", display.cx, display.cy)

	var_13_2:setScale(Adapter.MinScale)
	var_13_0:addChild(var_13_2)

	local var_13_3 = display.newSprite("uilocal/guild/guild_text_034.png", var_13_1.width / 2, var_13_1.height - 115)

	var_13_2:addChild(var_13_3)

	local var_13_4 = display.newSprite("uilocal/guild/guild_text_033.png", var_13_1.width / 2, var_13_1.height - 190)

	var_13_2:addChild(var_13_4)

	local var_13_5 = addLabelWithColorSize(var_13_2, string.lf("上仙，创建仙盟是一个责任，仙盟一旦创建，请遵守不离不弃，让仙盟成为西游路上一个避风的港湾，且建且珍惜。"), ccc3(255, 255, 0), 20, ccp(0.5, 1), ccp(var_13_1.width / 2, var_13_1.height - 10))

	var_13_5:setHorizontalAlignment(kCCTextAlignmentLeft)
	var_13_5:setVerticalAlignment(kCCVerticalTextAlignmentTop)
	var_13_5:setDimensions(CCSizeMake(var_13_1.width - 30, 100))

	local function var_13_6(arg_15_0)
		arg_15_0 = math.floor(arg_15_0)

		if arg_15_0 > 9999 then
			arg_15_0 = math.floor(arg_15_0 / 10000)

			return string.lf("%s万", arg_15_0)
		else
			return tostring(arg_15_0)
		end
	end

	local var_13_7
	local var_13_8 = ui.newEditBox({
		image = "ui/guild/guild_079.png",
		multiLines = false,
		size = CCSizeMake(var_13_1.width - 80, 40),
		fontColor = ccc3(0, 0, 0),
		x = var_13_1.width / 2,
		y = var_13_1.height - 190 - 40
	})

	var_13_2:addChild(var_13_8)
	var_13_8:setPlaceHolder(string.lf("输入仙盟名字"))

	local var_13_9 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/guild/guild_text_036.png",
		position = ccp(var_13_1.width / 2 + 100, 35),
		clickAction = function()
			var_13_0:removeFromParentAndCleanup(true)
		end
	})

	var_13_2:addChild(var_13_9)

	local var_13_10 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/guild/guild_text_035.png",
		position = ccp(var_13_1.width / 2 - 100, 35),
		clickAction = function()
			if Player.level < arg_13_0.mCreateNeedLv then
				showFlashNotice(string.lf("玩家需要达到%d级", arg_13_0.mCreateNeedLv))
			elseif Player.curCoin < arg_13_0.mCreateNeedCoin then
				showFlashNotice(string.lf("需要银币 %s", arg_13_0.mCreateNeedCoin))
			else
				local var_17_0 = var_13_8:getText()
				local var_17_1 = string.trim(var_17_0)
				local var_17_2 = string.asciilen(var_17_1)

				if var_17_2 and var_17_2 < 1 then
					var_13_8:setText("")
					showFlashNotice(string.lf("请输入仙盟名"))
				elseif var_17_2 > 14 then
					showFlashNotice(string.lf("仙盟名不能超过7个字"))
				else
					arg_13_0:requestCreateGuild(var_13_8:getText())
				end
			end
		end
	})

	var_13_2:addChild(var_13_10)

	local var_13_11 = "#FF0000"
	local var_13_12 = "#FFE400"

	addLabelWithColorSize(var_13_2, string.lf("等级: %s%d#FFE400/%d", Player.level < arg_13_0.mCreateNeedLv and var_13_11 or var_13_12, Player.level, arg_13_0.mCreateNeedLv), ccc3(255, 228, 0), 20, ccp(0, 0.5), ccp(80, var_13_1.height - 115 - 25))
	addLabelWithColorSize(var_13_2, string.lf("银币: %s%s#FFE400/%s", Player.curCoin < arg_13_0.mCreateNeedCoin and var_13_11 or var_13_12, var_13_6(Player.curCoin), var_13_6(arg_13_0.mCreateNeedCoin)), ccc3(255, 228, 0), 20, ccp(0, 0.5), ccp(var_13_1.width / 2, var_13_1.height - 115 - 25))
end

function var_0_0.showInputDeclarationLayer(arg_18_0, arg_18_1)
	local var_18_0 = display.newLayer()

	arg_18_0:addTouchEventListener(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == "began" then
			return true
		end
	end, false, 1, true)
	var_18_0:setTouchEnabled(true)
	arg_18_0:addChild(var_18_0)

	local var_18_1 = arg_18_0:getImageSize("ui/guild/guild_078.png")
	local var_18_2 = display.newSprite("ui/guild/guild_078.png", display.cx, display.cy)

	var_18_2:setScale(Adapter.MinScale)
	var_18_0:addChild(var_18_2)

	local var_18_3 = addLabelWithColorSize(var_18_2, string.lf("盟主，你已成功创建仙盟，写一点霸气侧漏的仙盟宣言震慑震慑其他仙盟吧:"), ccc3(255, 255, 0), 20, ccp(0.5, 1), ccp(var_18_1.width / 2, var_18_1.height - 10))

	var_18_3:setHorizontalAlignment(kCCTextAlignmentLeft)
	var_18_3:setVerticalAlignment(kCCVerticalTextAlignmentTop)
	var_18_3:setDimensions(CCSizeMake(var_18_1.width - 30, 100))

	local var_18_4

	local function var_18_5(arg_20_0, arg_20_1)
		if arg_20_0 == "began" then
			-- block empty
		elseif arg_20_0 == "changed" then
			local var_20_0 = arg_20_1:getText()

			if var_20_0 and string.len(var_20_0) > 0 then
				var_18_4:setEnabled(true)
			else
				var_18_4:setEnabled(false)
			end
		elseif arg_20_0 == "ended" then
			-- block empty
		elseif arg_20_0 == "return" then
			-- block empty
		end
	end

	local var_18_6 = ui.newEditBox({
		image = "ui/guild/guild_080.png",
		y = 60,
		fontSize = 22,
		multiLines = true,
		listener = var_18_5,
		size = CCSizeMake(var_18_1.width - 60, 200),
		fontColor = ccc3(0, 0, 0),
		x = var_18_1.width / 2
	})

	var_18_6:setAnchorPoint(ccp(0.5, 0))
	var_18_2:addChild(var_18_6)
	var_18_6:setText(arg_18_1.OutNotice)

	local var_18_7 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/guild/guild_text_036.png",
		position = ccp(var_18_1.width / 2 + 100, 35),
		clickAction = function()
			game.enterGuildHomeScene()
		end
	})

	var_18_2:addChild(var_18_7)

	var_18_4 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/guild/guild_text_035.png",
		position = ccp(var_18_1.width / 2 - 100, 35),
		clickAction = function()
			local var_22_0 = var_18_6:getText()

			if var_22_0 ~= arg_18_1.OutNotice then
				local var_22_1 = string.trim(var_22_0)
				local var_22_2 = string.asciilen(var_22_1)

				if not var_22_2 or var_22_2 < 1 then
					showFlashNotice(string.lf("请输入宣言"))
				elseif var_22_2 > 200 then
					var_18_6:setText("")
					showFlashNotice(string.lf("超出长度限制(限100字)"))
				else
					arg_18_0:requestUpdateGuildOutNotice(var_22_1)
				end
			else
				game.enterGuildHomeScene()
			end
		end
	})

	var_18_2:addChild(var_18_4)
end

function var_0_0.getImageSize(arg_23_0, arg_23_1)
	return CCTextureCache:sharedTextureCache():addImage(arg_23_1):getContentSize()
end

function var_0_0.isShowingFirstPage(arg_24_0)
	if arg_24_0.mCurrentGuildListPage and arg_24_0.mCurrentGuildListPage == 1 then
		return true
	end

	return false
end

function var_0_0.isShowingLastPage(arg_25_0)
	if arg_25_0.mCurrentGuildListPage and arg_25_0.mCurrentGuildListPage == arg_25_0.mTotalGuildPage then
		return true
	end

	return false
end

function var_0_0.setTimer(arg_26_0)
	if arg_26_0.mShowType == GuildCreateLayerType.eApplyGuild then
		arg_26_0.mApplyCDTimerHandler = var_0_1.scheduleGlobal(handler(arg_26_0, arg_26_0.onTimerApplyCDTime), 1)
	end
end

function var_0_0.killTimer(arg_27_0)
	if arg_27_0.mApplyCDTimerHandler then
		var_0_1.unscheduleGlobal(arg_27_0.mApplyCDTimerHandler)

		arg_27_0.mApplyCDTimerHandler = nil
	end
end

function var_0_0.onCreateGuildButtonClicked(arg_28_0)
	arg_28_0:showInputNameLayer()
end

function var_0_0.onApplyGuildButtonClicked(arg_29_0, arg_29_1)
	if arg_29_0.mApplyCDTimeCount and arg_29_0.mApplyCDTimeCount > 0 then
		showFlashNotice(string.lf("上次离开仙盟时间尚未冷却"))
	elseif arg_29_1.IsApply == 1 then
		showFlashNotice(string.lf("您已申请该联盟,请等待审批。"))
	else
		arg_29_0:requestApplyGuild(arg_29_1)
	end
end

function var_0_0.onCancelApplyButtonClicked(arg_30_0, arg_30_1)
	if arg_30_1.IsApply == 1 then
		arg_30_0:requestCancelApply(arg_30_1.UnionId)
	else
		arg_30_0.mGuildTableView:reloadData()
	end
end

function var_0_0.onGuildListPrePageBtnClicked(arg_31_0)
	if arg_31_0:isShowingFirstPage() then
		showFlashNotice(string.lf("已是第一页"))
	else
		arg_31_0:requestGuildList(arg_31_0.mCurrentGuildListPage - 1)
	end
end

function var_0_0.onGuildListNextPageBtnClicked(arg_32_0)
	if arg_32_0:isShowingLastPage() then
		showFlashNotice(string.lf("已是最后一页"))
	else
		arg_32_0:requestGuildList(arg_32_0.mCurrentGuildListPage + 1)
	end
end

function var_0_0.onTimerApplyCDTime(arg_33_0)
	if arg_33_0.mApplyCDTimeCount and arg_33_0.mApplyCDTimeLable then
		arg_33_0.mApplyCDTimeCount = arg_33_0.mApplyCDTimeCount - 1

		if arg_33_0.mApplyCDTimeCount < 1 then
			arg_33_0.mApplyCDTimeLable:setString(string.lf("已冷却"))
			arg_33_0:killTimer()
		else
			arg_33_0.mApplyCDTimeLable:setString(string.lf("冷却时间: %s", formatTime(arg_33_0.mApplyCDTimeCount)))
		end
	end
end

function var_0_0.requestGuildList(arg_34_0, arg_34_1)
	if not arg_34_0.mGetGuildListRequest then
		arg_34_0.mGetGuildListRequest = GetGuildListRequest:new()

		arg_34_0.mGetGuildListRequest:setResponseNormalHandler(function()
			local var_35_0 = arg_34_0.mGetGuildListRequest:getResult()

			arg_34_0.mLocalGuildCount = arg_34_0.mLocalGuildCount + #var_35_0.UnionListInfo

			if arg_34_0.mLocalGuildCount < var_35_0.TotalUnionNum then
				arg_34_0.mTotalGuildPage = arg_34_0.mTotalGuildPage + 1
			end

			if var_35_0.UnionListInfo[1] and var_35_0.UnionListInfo[1].UnionRank then
				table.sort(var_35_0.UnionListInfo, function(arg_36_0, arg_36_1)
					return arg_36_0.UnionRank < arg_36_1.UnionRank
				end)
			end

			arg_34_0.mApplyCDTimeCount = var_35_0.NextJoinTime
			arg_34_0.mAllPageGuild[arg_34_0.mRequestingPage] = var_35_0.UnionListInfo

			arg_34_0:responseGuildList(arg_34_0.mRequestingPage, var_35_0.UnionListInfo)
		end)
	end

	if arg_34_0.mAllPageGuild[arg_34_1] then
		arg_34_0:responseGuildList(arg_34_1, arg_34_0.mAllPageGuild[arg_34_1])
	else
		arg_34_0.mRequestingPage = arg_34_1

		arg_34_0.mGetGuildListRequest:request(arg_34_1, 0)
	end
end

function var_0_0.responseGuildList(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0.mAllPageGuild[arg_37_1] = arg_37_2
	arg_37_0.mCurrentGuildListPage = arg_37_1
	arg_37_0.mCurrPageGuild = arg_37_2

	arg_37_0.mGuildTableView:reloadData()
end

function var_0_0.requestCreateGuild(arg_38_0, arg_38_1)
	if not arg_38_0.mCreateGuildRequest then
		arg_38_0.mCreateGuildRequest = CreateGuildRequest:new()

		arg_38_0.mCreateGuildRequest:setResponseNormalHandler(function()
			arg_38_0:responseCreteGuild(arg_38_0.mCreateGuildRequest:getResult())
		end)
	end

	arg_38_0.mCreateGuildRequest:request(arg_38_1)
end

function var_0_0.responseCreteGuild(arg_40_0, arg_40_1)
	if not arg_40_1 then
		ui.showMessageBox({
			text = string.lf("获取仙盟数据出错"),
			action1 = function()
				arg_40_0:killTimer()
				game.enterHomeScene()
			end
		})

		return
	end

	Player:setIsHaveGuild(true)
	arg_40_0:killTimer()
	arg_40_0.mInputNameLayer:removeFromParentAndCleanup(true)
	arg_40_0:showInputDeclarationLayer(arg_40_1)
end

function var_0_0.requestApplyGuild(arg_42_0, arg_42_1)
	arg_42_0.mLastAplyGuildInfo = arg_42_1

	if not arg_42_0.mApplyGuildRequest then
		arg_42_0.mApplyGuildRequest = JoinGuildRequest:new()

		arg_42_0.mApplyGuildRequest:setResponseNormalHandler(function()
			showFlashNotice(string.lf("申请成功，请等待盟主审核"))

			for iter_43_0, iter_43_1 in ipairs(arg_42_0.mCurrPageGuild) do
				if iter_43_1.UnionId == arg_42_0.mLastAplyGuildInfo.UnionId then
					iter_43_1.IsApply = 1

					if arg_42_0.mLastAplyGuildInfo.ApplyStatus == 1 then
						Player:setIsHaveGuild(true)
						arg_42_0:killTimer()
						game.enterGuildHomeScene()
					end

					break
				end
			end

			local var_43_0 = arg_42_0.mGuildTableView:getContentOffset()

			arg_42_0.mGuildTableView:reloadData()
			arg_42_0.mGuildTableView:setContentOffset(var_43_0)
		end)
	end

	arg_42_0.mApplyGuildRequest:request(arg_42_1.UnionId)
end

function var_0_0.requestUpdateGuildOutNotice(arg_44_0, arg_44_1)
	if not arg_44_0.mUpdateOutNoticeRequest then
		arg_44_0.mUpdateOutNoticeRequest = UpdateGuildOutNoticeRequest:new()

		arg_44_0.mUpdateOutNoticeRequest:setResponseNormalHandler(function()
			game.enterGuildHomeScene()
		end)
	end

	arg_44_0.mUpdateOutNoticeRequest:request(arg_44_1)
end

function var_0_0.requestCancelApply(arg_46_0, arg_46_1)
	arg_46_0.mLastCancelAplyGuildID = arg_46_1

	if not arg_46_0.mCancelApplyRequest then
		arg_46_0.mCancelApplyRequest = CancelApplyGuildRequest:new()

		arg_46_0.mCancelApplyRequest:setResponseNormalHandler(function()
			showFlashNotice(string.lf("已取消"))

			for iter_47_0, iter_47_1 in ipairs(arg_46_0.mCurrPageGuild) do
				if iter_47_1.UnionId == arg_46_0.mLastCancelAplyGuildID then
					iter_47_1.IsApply = 0

					break
				end
			end

			local var_47_0 = arg_46_0.mGuildTableView:getContentOffset()

			arg_46_0.mGuildTableView:reloadData()
			arg_46_0.mGuildTableView:setContentOffset(var_47_0)
		end)
	end

	arg_46_0.mCancelApplyRequest:request(arg_46_1)
end

return var_0_0
