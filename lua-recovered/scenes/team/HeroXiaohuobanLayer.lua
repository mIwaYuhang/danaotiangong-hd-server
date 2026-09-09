require("network.TeamRequest")

local var_0_0 = class("HeroXiaohuobanLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.team = arg_2_1.team or Player.team
	arg_2_0.partnerTeam = arg_2_1.partnerTeam or Player.partnerTeam
	arg_2_0.teamScene = arg_2_1.scene
	arg_2_0.dataType = arg_2_1.dataType or TeamDataType.eTeamPlayer

	if arg_2_0.xhbRequest == nil then
		arg_2_0:createNetworkRequest()
	end

	arg_2_0.curViewSize = CCSize(210, 410)
	arg_2_0.selViewSize = CCSize(300, 210)
	arg_2_0.bgSprite = display.newSprite("ui/team/team_107.png", 309, 293)

	arg_2_0:addChild(arg_2_0.bgSprite)

	arg_2_0.rightBgSize = CCSize(445, 562)
	arg_2_0.rightBgSprite = CCScale9Sprite:create("ui/team/team_002.png")

	arg_2_0.rightBgSprite:setPreferredSize(arg_2_0.rightBgSize)
	arg_2_0.rightBgSprite:setAnchorPoint(ccp(0, 0.5))
	arg_2_0.rightBgSprite:setPosition(508.5, 293)
	arg_2_0:addChild(arg_2_0.rightBgSprite)

	arg_2_0.groupInfoBgSprite = display.newSprite("ui/team/team_108.png")

	arg_2_0.groupInfoBgSprite:setPosition(222, 153)
	arg_2_0.rightBgSprite:addChild(arg_2_0.groupInfoBgSprite)
	arg_2_0:createGroupsInfoScrollView()
	arg_2_0:showCurrentHeroGroupsInfo()
	arg_2_0:reloadXiaohuobanUI()

	if arg_2_0.dataType == TeamDataType.eTeamPlayer then
		arg_2_0.itemButtonTable = {}

		arg_2_0:showHeroPackageLayer()

		if arg_2_0.heroItemTable[1] then
			arg_2_0:showSelectedHeroGroupsInfo(arg_2_0.heroItemTable[1].heroId, false)
			arg_2_0:setHeroPackageSelectStatus(1, 1)
		end

		arg_2_0:createTouchEventLayer()
	end
end

function var_0_0.getSlotPosition(arg_3_0, arg_3_1)
	local var_3_0 = 165 + (arg_3_1 - 1) % 2 * 285
	local var_3_1 = 460 - math.floor((arg_3_1 - 1) / 2) * 110

	return var_3_0, var_3_1
end

function var_0_0.setXhbHeaderButtonSelectStatus(arg_4_0, arg_4_1)
	arg_4_0.curChoosedXiaohuobanIndex = arg_4_1

	for iter_4_0 = 1, table.nums(arg_4_0.xiaohuobanHeaderTable) do
		if arg_4_1 == iter_4_0 then
			arg_4_0.xiaohuobanHeaderTable[iter_4_0]:setSelected(true)
		else
			arg_4_0.xiaohuobanHeaderTable[iter_4_0]:setSelected(false)
		end
	end
end

function var_0_0.reloadXiaohuobanUI(arg_5_0)
	arg_5_0.xiaohuobanHeaderTable = arg_5_0.xiaohuobanHeaderTable or {}

	for iter_5_0 = 1, table.nums(arg_5_0.xiaohuobanHeaderTable) do
		arg_5_0:removeChild(arg_5_0.xiaohuobanHeaderTable[iter_5_0])
	end

	local var_5_0 = {
		GameFeaturesLevel[GameFeatures.eXiaohuoban1].level,
		GameFeaturesLevel[GameFeatures.eXiaohuoban2].level,
		GameFeaturesLevel[GameFeatures.eXiaohuoban3].level,
		GameFeaturesLevel[GameFeatures.eXiaohuoban4].level,
		GameFeaturesLevel[GameFeatures.eXiaohuoban5].level,
		GameFeaturesLevel[GameFeatures.eXiaohuoban6].level,
		GameFeaturesLevel[GameFeatures.eXiaohuoban7].level,
		GameFeaturesLevel[GameFeatures.eXiaohuoban8].level
	}

	for iter_5_1 = 1, 8 do
		local var_5_1, var_5_2 = arg_5_0:getSlotPosition(iter_5_1)
		local var_5_3 = var_5_0[iter_5_1]
		local var_5_4 = ""

		if var_5_3 == -1 then
			var_5_4 = string.lf("暂未开放")
		elseif var_5_3 > Player.level then
			var_5_4 = string.lf("%d级解锁", var_5_3)
		end

		local function var_5_5(arg_6_0, arg_6_1)
			local var_6_0 = tolua.cast(arg_6_1, "CCControlButton")

			if var_6_0.tag ~= arg_5_0.curChoosedXiaohuobanIndex then
				arg_5_0.curChoosedXiaohuobanIndex = var_6_0.tag

				if arg_5_0.partnerTeam[arg_5_0.curChoosedXiaohuobanIndex] then
					if arg_5_0.partnerTeam[arg_5_0.curChoosedXiaohuobanIndex].HeroID == 0 then
						arg_5_0.curChoosedXiaohuobanIndex = -1

						showFlashNotice(string.lf("点击右下方【上阵】按钮上阵小伙伴"))

						return
					end

					local var_6_1 = arg_5_0.heroPackageLayer:getCurrentIndex()

					arg_5_0:setHeroPackageSelectStatus(var_6_1, -1)
					arg_5_0:setXhbHeaderButtonSelectStatus(arg_5_0.curChoosedXiaohuobanIndex)
					arg_5_0:showSelectedHeroGroupsInfo(arg_5_0.partnerTeam[arg_5_0.curChoosedXiaohuobanIndex].HeroID, true)
				else
					showFlashNotice(var_5_4)
				end
			end
		end

		local var_5_6 = {
			type = ItemType.eHero
		}

		if arg_5_0.dataType == TeamDataType.eTeamPlayer then
			var_5_6.clickAction = var_5_5
		end

		var_5_6.isXiaoHuoBan = true

		if var_5_3 <= Player.level and var_5_3 ~= -1 then
			if arg_5_0.partnerTeam[iter_5_1] then
				var_5_6.itemId = arg_5_0.partnerTeam[iter_5_1].HeroID
			else
				var_5_6.itemId = 0
				arg_5_0.partnerTeam[iter_5_1] = {
					HeroID = 0,
					Index = iter_5_1
				}
			end

			var_5_6.isName = true
		else
			var_5_6.itemId = -1
		end

		local var_5_7 = figure.createHeader(var_5_6)

		var_5_7:setPosition(var_5_1, var_5_2)

		var_5_7.headerButton.tag = iter_5_1

		arg_5_0:addChild(var_5_7)

		arg_5_0.xiaohuobanHeaderTable[iter_5_1] = var_5_7

		if not arg_5_0.partnerTeam[iter_5_1] then
			local var_5_8 = display.newSprite("ui/team/team_106.png", 35, 35)

			var_5_7.headerButton:addChild(var_5_8)
			addLabelWithColorSize(var_5_7.headerButton, var_5_4, ccc3(250, 0, 0), 16, ccp(0.5, 0.5), ccp(35, 35))
		end
	end
end

function var_0_0.createNetworkRequest(arg_7_0)
	local function var_7_0()
		arg_7_0:reloadXiaohuobanUI()
		arg_7_0:refreshHeroItemTable()
		arg_7_0.heroPackageLayer:reloadData()
		arg_7_0:showCurrentHeroGroupsInfo()

		if arg_7_0.tmpEffectHeader ~= nil then
			arg_7_0.tmpEffectHeader:removeFromParentAndCleanup(true)

			arg_7_0.tmpEffectHeader = nil
		end
	end

	local function var_7_1(arg_9_0)
		if arg_7_0.tmpEffectHeader ~= nil then
			arg_7_0.tmpEffectHeader:removeFromParentAndCleanup(true)

			arg_7_0.tmpEffectHeader = nil
		end

		arg_7_0:refreshHeroItemTable()
		arg_7_0.heroPackageLayer:reloadData()
	end

	arg_7_0.xhbRequest = ChangeXiaohuobanRequest:new()

	arg_7_0.xhbRequest:setResponseNormalHandler(var_7_0)
	arg_7_0.xhbRequest:setResponseExceptionHandler(var_7_1)
end

function var_0_0.refreshHeroItemTable(arg_10_0)
	arg_10_0.heroItemTable = {}
	arg_10_0.heroItemTable = Player:getNotInTeamOwnedHeros()

	table.sort(arg_10_0.heroItemTable, function(arg_11_0, arg_11_1)
		return BaseHeros[arg_11_0.heroId].quality > BaseHeros[arg_11_1.heroId].quality
	end)

	arg_10_0.totalPageCount = math.ceil(#arg_10_0.heroItemTable / 8)

	if arg_10_0.totalPageCount == 0 then
		arg_10_0.totalPageCount = 1
	end
end

function var_0_0.getPackageHeroPosition(arg_12_0, arg_12_1)
	local var_12_0 = (arg_12_1 % 4 + 0.5) * 100 + 18
	local var_12_1 = (2 - math.floor(arg_12_1 / 4) - 0.5) * 109 + 10

	return var_12_0, var_12_1
end

function var_0_0.setHeroPackageSelectStatus(arg_13_0, arg_13_1, arg_13_2)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.itemButtonTable[arg_13_1]) do
		iter_13_1:setSelected(iter_13_1.headerButton.tag == arg_13_2)
	end
end

function var_0_0.showHeroPackageLayer(arg_14_0)
	arg_14_0:refreshHeroItemTable()

	local function var_14_0(arg_15_0, arg_15_1)
		local var_15_0 = tolua.cast(arg_15_1, "CCControlButton").tag

		arg_14_0.curChoosedHeroPackageIndex = var_15_0

		local var_15_1 = arg_14_0.heroPackageLayer:getCurrentIndex()

		arg_14_0:setHeroPackageSelectStatus(var_15_1, var_15_0)
		arg_14_0:setXhbHeaderButtonSelectStatus(-1)
		arg_14_0:showSelectedHeroGroupsInfo(arg_14_0.heroItemTable[var_15_0].heroId, false)
	end

	arg_14_0.heroPackageLayer = require("scenes.SliderLayer").new({
		navOnSprite = "ui/common/common_048.png",
		navOffSprite = "ui/common/common_047.png",
		navMargin = 30,
		size = CCSizeMake(434, 280),
		clipScaleX = Adapter.MinScale,
		clipScaleY = Adapter.MinScale,
		point = ccp(2, 133),
		navPosition = ccp(200, -17),
		numberHandler = function()
			return arg_14_0.totalPageCount
		end,
		changedHandler = function(arg_17_0)
			if #arg_14_0.heroItemTable > 1 then
				local var_17_0 = (arg_17_0 - 1) * 8 + 1

				arg_14_0.curChoosedHeroPackageIndex = var_17_0

				arg_14_0:showSelectedHeroGroupsInfo(arg_14_0.heroItemTable[var_17_0].heroId, false)
				arg_14_0:setHeroPackageSelectStatus(arg_17_0, var_17_0)
			else
				arg_14_0:showSelectedHeroGroupsInfo(0, false)
			end
		end,
		cellHandler = function(arg_18_0, arg_18_1)
			local var_18_0 = (arg_18_1 - 1) * 8 + 1
			local var_18_1 = arg_18_1 * 8
			local var_18_2 = 0

			arg_14_0.itemButtonTable[arg_18_1] = {}

			for iter_18_0 = var_18_0, var_18_1 do
				local var_18_3, var_18_4 = arg_14_0:getPackageHeroPosition(var_18_2)
				local var_18_5

				if iter_18_0 <= #arg_14_0.heroItemTable then
					var_18_5 = figure.createHeader({
						isName = true,
						type = ItemType.eHero,
						itemId = arg_14_0.heroItemTable[iter_18_0].heroId,
						level = arg_14_0.heroItemTable[iter_18_0].level,
						nameColor = ccc3(0, 0, 0),
						clickAction = var_14_0
					})
				else
					var_18_5 = figure.createHeader({
						itemId = 0,
						type = ItemType.eHero
					})
				end

				var_18_5:setPosition(var_18_3, var_18_4)

				var_18_5.headerButton.tag = iter_18_0

				arg_18_0:addChild(var_18_5)

				arg_14_0.itemButtonTable[arg_18_1][var_18_2] = var_18_5
				var_18_2 = var_18_2 + 1
			end
		end,
		direction = SliderDirection.eHorizontal,
		touchBeginCallback = function(arg_19_0, arg_19_1, arg_19_2)
			local var_19_0 = arg_14_0.heroPackageLayer:convertToNodeSpace(ccp(arg_19_1, arg_19_2))
			local var_19_1 = 0
			local var_19_2 = 1000

			for iter_19_0 = 0, 7 do
				local var_19_3, var_19_4 = arg_14_0:getPackageHeroPosition(iter_19_0)
				local var_19_5 = ccpDistance(var_19_0, ccp(var_19_3, var_19_4))

				if var_19_5 < var_19_2 then
					var_19_2 = var_19_5
					var_19_1 = iter_19_0
				end
			end

			arg_14_0.buttonIndex = var_19_1

			local var_19_6 = arg_14_0.itemButtonTable[arg_19_0][arg_14_0.buttonIndex].headerButton.tag

			if arg_14_0.heroItemTable[var_19_6] == nil then
				return false
			end

			local var_19_7 = arg_14_0.heroItemTable[var_19_6]

			arg_14_0.itemButtonTable[arg_19_0][arg_14_0.buttonIndex]:setHeaderOpacity(120)

			arg_14_0.touchHeaderButton = figure.createHeader({
				type = ItemType.eHero,
				itemId = var_19_7.heroId,
				level = var_19_7.level
			})

			arg_14_0.touchHeaderButton:setScale(Adapter.MinScale)
			arg_14_0.touchHeaderButton:setPosition(ccp(arg_19_1, arg_19_2))
			display.getRunningScene():addChild(arg_14_0.touchHeaderButton)

			return true
		end,
		touchMoveCallback = function(arg_20_0, arg_20_1, arg_20_2)
			if arg_14_0.touchHeaderButton then
				arg_14_0.touchHeaderButton:setPosition(ccp(arg_20_1, arg_20_2))
			end
		end,
		touchEndCallback = function(arg_21_0, arg_21_1, arg_21_2)
			if arg_14_0.touchHeaderButton then
				arg_14_0.touchHeaderButton:removeFromParent()

				arg_14_0.touchHeaderButton = nil

				arg_14_0.itemButtonTable[arg_21_0][arg_14_0.buttonIndex]:setHeaderOpacity(255)
			end

			local var_21_0 = arg_14_0.rightBgSprite:convertToNodeSpace(ccp(arg_21_1, arg_21_2))

			print(var_21_0.x, var_21_0.y, arg_21_1, arg_21_2)

			if var_21_0.x > 0 then
				return
			end

			local var_21_1 = 0
			local var_21_2 = 1000

			for iter_21_0 = 1, #arg_14_0.partnerTeam do
				local var_21_3, var_21_4 = arg_14_0:getSlotPosition(iter_21_0)
				local var_21_5 = arg_14_0:convertToWorldSpace(ccp(var_21_3, var_21_4))
				local var_21_6, var_21_7 = var_21_5.x, var_21_5.y
				local var_21_8 = ccpDistance(ccp(arg_21_1, arg_21_2), ccp(var_21_6, var_21_7))

				if var_21_8 < var_21_2 then
					var_21_2 = var_21_8
					var_21_1 = iter_21_0
				end
			end

			local var_21_9 = arg_14_0.itemButtonTable[arg_21_0][arg_14_0.buttonIndex].headerButton.tag
			local var_21_10 = arg_14_0.heroItemTable[var_21_9]

			if var_21_1 == 0 then
				return
			end

			arg_14_0.xhbRequest:request(var_21_1, var_21_10.heroId)
		end
	})

	arg_14_0.heroPackageLayer:setPosition((arg_14_0.rightBgSize.width - 434) / 2, arg_14_0.rightBgSize.height - 235)
	arg_14_0.rightBgSprite:addChild(arg_14_0.heroPackageLayer)
	arg_14_0.heroPackageLayer:reloadData()
end

function var_0_0.createGroupsInfoScrollView(arg_22_0)
	arg_22_0.curScrollView = CCScrollView:create(arg_22_0.curViewSize)

	arg_22_0.curScrollView:setPosition(93, 66)
	arg_22_0.curScrollView:setDirection(kCCScrollViewDirectionVertical)
	arg_22_0.curScrollView:setContentSize(arg_22_0.curViewSize)
	arg_22_0.curScrollView:setContentOffset(arg_22_0.curScrollView:minContainerOffset())
	arg_22_0.bgSprite:addChild(arg_22_0.curScrollView)

	arg_22_0.selScrollView = CCScrollView:create(arg_22_0.selViewSize)

	arg_22_0.selScrollView:setPosition(ccp(125, 60))
	arg_22_0.selScrollView:setDirection(kCCScrollViewDirectionVertical)
	arg_22_0.selScrollView:setContentSize(arg_22_0.selViewSize)
	arg_22_0.selScrollView:setContentOffset(arg_22_0.selScrollView:minContainerOffset())
	arg_22_0.groupInfoBgSprite:addChild(arg_22_0.selScrollView, 1)
end

function var_0_0.createHeroGroupsInfo(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = 0
	local var_23_1 = display.newNode()

	if arg_23_4 == true then
		arg_23_3 = false
	end

	if arg_23_3 == true or arg_23_4 == true then
		local var_23_2 = display.newSprite("uilocal/team/team_text_032.png", arg_23_1.width / 2 - 20, var_23_0 - 18)

		var_23_1:addChild(var_23_2)
	else
		local var_23_3 = display.newSprite("ui/team/team_105.png", arg_23_1.width / 2, var_23_0 - 22)

		var_23_1:addChild(var_23_3)
		addLabelWithColorSize(var_23_1, BaseHeros[arg_23_2].name, ccc3(255, 255, 0), 23, ccp(0.5, 0.5), ccp(arg_23_1.width / 2, var_23_0 - 22), _FONT_PANGWA)
	end

	local var_23_4 = 45
	local var_23_5 = 0
	local var_23_6 = BaseHeros[arg_23_2].groupAttrs and #BaseHeros[arg_23_2].groupAttrs or 0

	for iter_23_0, iter_23_1 in ipairs(BaseHeros[arg_23_2].groupAttrs or {}) do
		local var_23_7, var_23_8 = Player:isHerosInteam(iter_23_1.heroList, arg_23_0.team, arg_23_0.partnerTeam)

		if arg_23_4 == true then
			var_23_7, var_23_8 = Player:isHerosInteam(iter_23_1.heroList, arg_23_0.team, {})
		end

		if arg_23_3 == true then
			var_23_7 = false
		end

		local var_23_9 = var_23_7 == true and ccc3(255, 228, 0) or ccc3(255, 255, 255)

		if arg_23_3 == true then
			var_23_9 = ccc3(250, 250, 250)
		end

		local var_23_10 = convertColorToLabelString(var_23_9) .. iter_23_1.name .. ":" .. convertColorToLabelString(var_23_9)
		local var_23_11 = string.lf("%s与", var_23_10)

		if var_23_7 == true then
			var_23_5 = var_23_5 + 1
		end

		local var_23_12 = ""

		for iter_23_2, iter_23_3 in pairs(iter_23_1.heroList) do
			local var_23_13 = var_23_8[iter_23_3]

			if arg_23_3 == true then
				var_23_13 = false
			end

			if var_23_13 == true and var_23_7 == false then
				var_23_12 = var_23_12 .. convertColorToLabelString(ccc3(255, 228, 0)) .. BaseHeros[iter_23_3].name .. convertColorToLabelString(var_23_9)
			else
				var_23_12 = var_23_12 .. BaseHeros[iter_23_3].name
			end

			if iter_23_1.heroList[iter_23_2 + 1] ~= nil then
				var_23_12 = var_23_12 .. "、"
			end
		end

		local var_23_14 = string.lf("%s%s上阵, ", var_23_11, var_23_12)
		local var_23_15 = string.lf("%s加%s%%", BattleAttrsName[iter_23_1.addType], iter_23_1.factor * 100)
		local var_23_16 = var_23_14 .. var_23_15
		local var_23_17 = Platform.getStringDrawHeight({
			fontSize = 20,
			text = var_23_16,
			fontName = _FONT_DEFAULT,
			width = arg_23_1.width - 15
		})
		local var_23_18 = addLabelWithColorSize(var_23_1, var_23_16, var_23_9, 20, ccp(0, 1), ccp(10, var_23_0 - var_23_4))

		var_23_18:setHorizontalAlignment(ui.TEXT_ALIGN_LEFT)
		var_23_18:setDimensions(CCSize(arg_23_1.width - 15, var_23_17))

		var_23_4 = var_23_4 + var_23_17 + 5
	end

	if arg_23_3 == true or arg_23_4 == true then
		local var_23_19 = string.format("(%d/%d)", var_23_5, var_23_6)

		addLabelWithColorSize(var_23_1, var_23_19, ccc3(252, 229, 144), 20, ccp(0, 0.5), ccp(arg_23_1.width / 2 + 45, var_23_0 - 17))
	end

	return var_23_4, var_23_1
end

function var_0_0.showCurrentHeroGroupsInfo(arg_24_0)
	arg_24_0.curScrollView:getContainer():removeAllChildrenWithCleanup(true)

	local var_24_0 = 0
	local var_24_1 = display.newNode()

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.team.groupList) do
		if iter_24_1.heroId > 0 then
			local var_24_2, var_24_3 = arg_24_0:createHeroGroupsInfo(arg_24_0.curViewSize, iter_24_1.heroId, false)

			var_24_3:setPosition(0, -var_24_0)
			var_24_1:addChild(var_24_3)

			var_24_0 = var_24_0 + var_24_2
		end
	end

	arg_24_0.curScrollView:getContainer():addChild(var_24_1)

	if var_24_0 > arg_24_0.curViewSize.height then
		var_24_1:setPosition(0, var_24_0)
		arg_24_0.curScrollView:setContentSize(CCSize(arg_24_0.curViewSize.width, var_24_0))
		arg_24_0.curScrollView:setContentOffset(ccp(0, arg_24_0.curViewSize.height - var_24_0))
	else
		var_24_1:setPosition(0, arg_24_0.curViewSize.height)
		arg_24_0.curScrollView:setContentOffset(ccp(0, 0))
	end
end

function var_0_0.showSelectedHeroGroupsInfo(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_0.selHeroFigure ~= nil then
		arg_25_0.selHeroFigure:removeFromParentAndCleanup(true)

		arg_25_0.selHeroFigure = nil
	end

	if arg_25_1 == 0 then
		arg_25_0.selScrollView:getContainer():removeAllChildrenWithCleanup(true)

		if arg_25_0.operateButton ~= nil then
			arg_25_0.operateButton:removeFromParentAndCleanup(true)

			arg_25_0.operateButton = nil
		end

		return
	end

	local var_25_0 = arg_25_2 == true
	local var_25_1, var_25_2 = arg_25_0:createHeroGroupsInfo(arg_25_0.selViewSize, arg_25_1, true, var_25_0)

	arg_25_0.selScrollView:getContainer():removeAllChildrenWithCleanup(true)
	var_25_2:setPosition(ccp(0, var_25_1 + arg_25_0.selViewSize.height))
	arg_25_0.selScrollView:getContainer():addChild(var_25_2)

	if var_25_1 > arg_25_0.selViewSize.height then
		var_25_2:setPosition(0, var_25_1)
		arg_25_0.selScrollView:setContentSize(CCSize(arg_25_0.selViewSize.width, var_25_1))
		arg_25_0.selScrollView:setContentOffset(ccp(0, arg_25_0.selViewSize.height - var_25_1))
	else
		var_25_2:setPosition(0, arg_25_0.selViewSize.height)
		arg_25_0.selScrollView:setContentOffset(ccp(0, 0))
	end

	arg_25_0.selHeroFigure = figure.createHero({
		scale = 0.45,
		platTable = false,
		isViewQuality = false,
		figId = arg_25_1
	})

	arg_25_0.selHeroFigure:setPosition(ccp(60, 90))
	arg_25_0.selHeroFigure.Skeleton:clearAnimation(0)
	arg_25_0.selHeroFigure.Skeleton:setToSetupPose()
	arg_25_0.groupInfoBgSprite:addChild(arg_25_0.selHeroFigure)
	arg_25_0:showOperateButton(arg_25_2)
end

function var_0_0.showOperateButton(arg_26_0, arg_26_1)
	if arg_26_0.operateButton ~= nil then
		arg_26_0.operateButton:removeFromParentAndCleanup(true)

		arg_26_0.operateButton = nil
	end

	local var_26_0 = arg_26_1 == true and string.lf("下阵") or string.lf("上阵")

	arg_26_0.operateButton = ui.newControlButton({
		disabledImage = "ui/common/common_079.png",
		normalImage = "ui/common/common_018.png",
		text = var_26_0,
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_27_0, arg_27_1)
			if arg_26_1 == true then
				arg_26_0.xhbRequest:request(arg_26_0.curChoosedXiaohuobanIndex, 0)
			elseif arg_26_1 == false then
				arg_26_0:putHeroInPartern()
			end
		end
	})

	arg_26_0.operateButton:setPosition(ccp(arg_26_0.rightBgSize.width / 2, 38))
	arg_26_0.rightBgSprite:addChild(arg_26_0.operateButton)
end

function var_0_0.putHeroInPartern(arg_28_0)
	local var_28_0 = 0

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.partnerTeam) do
		if iter_28_1.HeroID == 0 then
			var_28_0 = iter_28_1.Index

			break
		end
	end

	if #arg_28_0.partnerTeam == 1 then
		var_28_0 = 1
	end

	if var_28_0 ~= 0 then
		arg_28_0:playHeroHeaderFlyEffect(arg_28_0.heroItemTable[arg_28_0.curChoosedHeroPackageIndex].heroId, var_28_0)

		return
	end

	arg_28_0:showTouchFiltterLayer()
end

function var_0_0.showTouchFiltterLayer(arg_29_0)
	if arg_29_0._touchLayer ~= nil then
		return
	end

	arg_29_0._touchLayer = CCLayerColor:create(ccc4(0, 0, 0, 1))

	arg_29_0._touchLayer:setColor(ccc3(0, 0, 0))
	arg_29_0._touchLayer:setOpacity(170)

	local function var_29_0(arg_30_0, arg_30_1, arg_30_2)
		if arg_30_0 == "began" then
			return true
		elseif arg_30_0 == "moved" then
			-- block empty
		elseif arg_30_0 ~= "ended" and arg_30_0 == "cancelled" then
			-- block empty
		end
	end

	arg_29_0._touchLayer:addTouchEventListener(var_29_0, false, 1, true)
	arg_29_0._touchLayer:setTouchEnabled(true)
	CCDirector:sharedDirector():getRunningScene():addChild(arg_29_0._touchLayer)

	local function var_29_1()
		if arg_29_0._touchLayer ~= nil then
			arg_29_0._touchLayer:removeFromParentAndCleanup(true)

			arg_29_0._touchLayer = nil
		end
	end

	local function var_29_2(arg_32_0, arg_32_1)
		local var_32_0 = tolua.cast(arg_32_1, "CCControlButton").tag
		local var_32_1 = arg_29_0.heroItemTable[arg_29_0.curChoosedHeroPackageIndex].heroId

		if arg_29_0._touchLayer ~= nil then
			arg_29_0._touchLayer:removeFromParentAndCleanup(true)

			arg_29_0._touchLayer = nil
		end

		arg_29_0:playHeroHeaderFlyEffect(var_32_1, var_32_0)
	end

	local var_29_3 = require("scenes.CommonBgLayer").new({
		closeButtonNormalImage = "ui/common/common_070.png",
		isHideBgSprite = true,
		returnAction = var_29_1,
		closeButtonPosition = ccp(480, 10000)
	})

	arg_29_0._touchLayer:addChild(var_29_3)

	local var_29_4 = var_29_3:getBackgroundSprite()
	local var_29_5 = createNumberWidthBgSprite("ui/common/common_064_2.png", string.lf("点击对应头像上阵"), 25, 0)
	local var_29_6 = ui.newControlButton({
		fontSize = 22,
		normalImage = "ui/common/common_073_1.png",
		position = ccp(152, 0),
		clickAction = var_29_1,
		text = string.lf("取消")
	})

	var_29_6:setPreferredSize(CCSize(100, 50))
	var_29_5:addChild(var_29_6)
	var_29_5:setPosition(ccp(300, 70))
	var_29_4:addChild(var_29_5)

	for iter_29_0 = 1, #arg_29_0.partnerTeam do
		local var_29_7, var_29_8 = arg_29_0:getSlotPosition(iter_29_0)
		local var_29_9 = {
			type = ItemType.eHero,
			clickAction = var_29_2
		}

		var_29_9.isXiaoHuoBan = true

		if arg_29_0.partnerTeam[iter_29_0] then
			var_29_9.itemId = arg_29_0.partnerTeam[iter_29_0].HeroID
			var_29_9.isName = true
		else
			var_29_9.itemId = -1
		end

		local var_29_10 = figure.createHeader(var_29_9)

		var_29_10.headerButton.tag = iter_29_0

		var_29_10:setPosition(var_29_7, var_29_8)

		local var_29_11 = CCArray:create()

		var_29_10:setRotation(3)
		var_29_11:addObject(CCRotateBy:create(0.09, -6))
		var_29_11:addObject(CCRotateBy:create(0.09, 6))
		var_29_10:runAction(CCRepeatForever:create(CCSequence:create(var_29_11)))
		var_29_4:addChild(var_29_10)
	end
end

function var_0_0.playHeroHeaderFlyEffect(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0
	local var_33_1 = arg_33_0.heroPackageLayer:getCurrentIndex()

	for iter_33_0, iter_33_1 in pairs(arg_33_0.itemButtonTable[var_33_1]) do
		if iter_33_1.headerButton.tag == arg_33_0.curChoosedHeroPackageIndex then
			var_33_0 = iter_33_1

			break
		end
	end

	local var_33_2, var_33_3 = var_33_0:getPosition()
	local var_33_4, var_33_5 = arg_33_0:getSlotPosition(arg_33_2)
	local var_33_6 = arg_33_0.heroPackageLayer:convertToWorldSpace(ccp(var_33_2, var_33_3))
	local var_33_7 = arg_33_0:convertToNodeSpace(var_33_6)

	var_33_0:setHeaderOpacity(140)

	local var_33_8 = {
		type = ItemType.eHero
	}

	var_33_8.isXiaoHuoBan = true
	var_33_8.itemId = arg_33_1
	arg_33_0.tmpEffectHeader = figure.createHeader(var_33_8)

	arg_33_0.tmpEffectHeader:setPosition(var_33_7)
	arg_33_0:addChild(arg_33_0.tmpEffectHeader)

	local function var_33_9()
		arg_33_0.xhbRequest:request(arg_33_2, arg_33_1)
	end

	local var_33_10 = CCArray:create()

	var_33_10:addObject(CCEaseSineOut:create(CCMoveTo:create(0.5, ccp(var_33_4, var_33_5))))
	var_33_10:addObject(CCCallFunc:create(var_33_9))
	arg_33_0.tmpEffectHeader:runAction(CCSequence:create(var_33_10))
end

function var_0_0.touchBeginEvent(arg_35_0, arg_35_1, arg_35_2)
	arg_35_0._touchBeginPos = ccp(arg_35_1, arg_35_2)
	arg_35_0._touchEndPos = ccp(arg_35_1, arg_35_2)
	arg_35_0._isMoveMode = false

	local var_35_0 = 0
	local var_35_1 = 1000

	for iter_35_0 = 1, #arg_35_0.partnerTeam do
		local var_35_2, var_35_3 = arg_35_0:getSlotPosition(iter_35_0)
		local var_35_4 = arg_35_0:convertToWorldSpace(ccp(var_35_2, var_35_3))
		local var_35_5, var_35_6 = var_35_4.x, var_35_4.y
		local var_35_7 = ccpDistance(ccp(arg_35_1, arg_35_2), ccp(var_35_5, var_35_6))

		if var_35_7 < var_35_1 then
			var_35_1 = var_35_7
			var_35_0 = iter_35_0
		end
	end

	arg_35_0.touchXhbIndex = var_35_0

	if var_35_1 <= 43 * Adapter.MinScale then
		local function var_35_8()
			if ccpDistance(arg_35_0._touchBeginPos, arg_35_0._touchEndPos) < 5 then
				if arg_35_0.partnerTeam[arg_35_0.touchXhbIndex].HeroID == 0 then
					return
				end

				arg_35_0._isMoveMode = true

				arg_35_0.xiaohuobanHeaderTable[arg_35_0.touchXhbIndex]:setHeaderOpacity(120)

				arg_35_0.xhbTouchHeaderButton = figure.createHeader({
					type = ItemType.eHero,
					itemId = arg_35_0.partnerTeam[arg_35_0.touchXhbIndex].HeroID
				})

				arg_35_0.xhbTouchHeaderButton:setScale(Adapter.MinScale)
				arg_35_0.xhbTouchHeaderButton:setPosition(ccp(arg_35_1, arg_35_2))
				display.getRunningScene():addChild(arg_35_0.xhbTouchHeaderButton)
			end
		end

		local var_35_9 = CCArray:create()

		var_35_9:addObject(CCDelayTime:create(0.12))
		var_35_9:addObject(CCCallFunc:create(var_35_8))

		arg_35_0.checkAction = CCSequence:create(var_35_9)

		arg_35_0:runAction(arg_35_0.checkAction)

		return true
	else
		return false
	end
end

function var_0_0.touchMoveEvent(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0._touchEndPos = ccp(arg_37_1, arg_37_2)

	if arg_37_0._isMoveMode == true then
		if arg_37_0.xhbTouchHeaderButton then
			arg_37_0.xhbTouchHeaderButton:setPosition(ccp(arg_37_1, arg_37_2))
		end

		return
	end
end

function var_0_0.createTouchEventLayer(arg_38_0)
	local var_38_0 = display.newLayer()

	local function var_38_1(arg_39_0, arg_39_1, arg_39_2)
		if arg_39_0 == "began" then
			return arg_38_0:touchBeginEvent(arg_39_1, arg_39_2)
		elseif arg_39_0 == "moved" then
			arg_38_0:touchMoveEvent(arg_39_1, arg_39_2)
		elseif arg_39_0 == "ended" or arg_39_0 == "cancelled" then
			arg_38_0:stopAction(arg_38_0.checkAction)

			if arg_38_0._isMoveMode == false then
				return
			end

			arg_38_0.xiaohuobanHeaderTable[arg_38_0.touchXhbIndex]:setHeaderOpacity(255)

			if arg_38_0.xhbTouchHeaderButton ~= nil then
				arg_38_0.xhbTouchHeaderButton:removeFromParentAndCleanup(true)

				arg_38_0.xhbTouchHeaderButton = nil
			end

			if ccpDistance(arg_38_0._touchBeginPos, arg_38_0._touchEndPos) > 80 * Adapter.MinScale then
				arg_38_0.xhbRequest:request(arg_38_0.touchXhbIndex, 0)
			end
		end
	end

	var_38_0:addTouchEventListener(var_38_1, false, -1, false)
	var_38_0:setTouchEnabled(true)
	arg_38_0:addChild(var_38_0)
end

return var_0_0
