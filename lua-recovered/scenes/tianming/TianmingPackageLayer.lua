local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = class("TianmingPackageLayer", function()
	return display.newLayer()
end)
local var_0_3 = {
	{
		btnSprite = "ui/common/common_073_1.png",
		y = 51,
		x = 103.5,
		title = string.lf("蓝色"),
		tag = QualityType.eBlue
	},
	{
		btnSprite = "ui/common/common_073_1.png",
		y = 51,
		x = 222.5,
		title = string.lf("紫色"),
		tag = QualityType.ePurple
	},
	{
		btnSprite = "ui/common/common_073_1.png",
		y = 51,
		x = 341.5,
		title = string.lf("橙色"),
		tag = QualityType.eOrange
	}
}

function var_0_2.ctor(arg_2_0, arg_2_1)
	arg_2_0.team = arg_2_1.team or Player.team
	arg_2_0.getCurrentIndex = arg_2_1.getCurrentIndex
	arg_2_0.appearCallback = arg_2_1.appearCallback
	arg_2_0.closeCallback = arg_2_1.closeCallback
	arg_2_0.tianmingScene = arg_2_1.tianmingScene
	arg_2_0.callShowChangeTianmingHintSprite = arg_2_1.callShowChangeTianmingHintSprite

	local var_2_0 = arg_2_0.getCurrentIndex()

	arg_2_0.curHero = arg_2_0.team.groupList[var_2_0]
	arg_2_0.refreshTianmingHandle = arg_2_1.refreshTianmingHandle
	arg_2_0._totalPageCount = 1
	arg_2_0._pageCount = 16
	arg_2_0._currentDisplayPage = 1
	arg_2_0._tianmingDataList = {}

	local var_2_1 = CCSize(445, 565)
	local var_2_2 = display.newScale9Sprite("ui/team/team_002.png")

	var_2_2:setPreferredSize(var_2_1)
	var_2_2:setAnchorPoint(CCPoint(0, 0))
	var_2_2:setPosition(CCPoint(0, 0))
	arg_2_0:addChild(var_2_2)

	arg_2_0.bgSprite = var_2_2
	arg_2_0.background = CCLayerColor:create(ccc4(0, 0, 0, 0))

	arg_2_0.background:setContentSize(var_2_1)
	var_2_2:addChild(arg_2_0.background)

	arg_2_0.itemButtonTable = {}

	local function var_2_3(arg_3_0, arg_3_1)
		local var_3_0 = tolua.cast(arg_3_1, "CCControlButton")
		local var_3_1 = var_3_0:getTag()

		arg_2_0.curSelectTianmingIndex = var_3_1

		local var_3_2 = arg_2_0._tianmingDataList[var_3_1]

		if var_3_2 then
			arg_2_0:createTipsView(var_3_2, var_3_0:getParent(), arg_2_0.tianmingsLayer)
		end
	end

	arg_2_0.tianmingsLayer = require("scenes.SliderLayer").new({
		navOnSprite = "ui/common/common_048.png",
		navOffSprite = "ui/common/common_047.png",
		navMargin = 30,
		size = CCSizeMake(434, 360),
		clipScaleX = Adapter.MinScale,
		clipScaleY = Adapter.MinScale,
		point = ccp(2, 133),
		navPosition = ccp(200, -20),
		numberHandler = function()
			return arg_2_0._totalPageCount
		end,
		changedHandler = function(arg_5_0)
			return
		end,
		cellHandler = function(arg_6_0, arg_6_1)
			local var_6_0 = (arg_6_1 - 1) * arg_2_0._pageCount + 1
			local var_6_1 = arg_6_1 * arg_2_0._pageCount
			local var_6_2 = 0

			for iter_6_0 = var_6_0, var_6_1 do
				local var_6_3 = (var_6_2 % 4 + 0.5) * 100 + 20
				local var_6_4 = (4 - math.floor(var_6_2 / 4) - 0.5) * 90
				local var_6_5
				local var_6_6 = {
					itemId = 0,
					isName = false,
					noTypeImage = false,
					type = ItemType.eTianMing,
					clickAction = var_2_3
				}

				if iter_6_0 <= #arg_2_0._tianmingDataList then
					local var_6_7 = arg_2_0._tianmingDataList[iter_6_0]

					var_6_6.itemId = var_6_7.destinyID
					var_6_6.level = var_6_7.level
				end

				local var_6_8 = figure.createHeader(var_6_6)

				var_6_8:setPosition(var_6_3, var_6_4)
				var_6_8.headerButton:setTag(iter_6_0)
				arg_6_0:addChild(var_6_8)

				if arg_2_0.itemButtonTable[arg_6_1] == nil then
					arg_2_0.itemButtonTable[arg_6_1] = {}
				end

				arg_2_0.itemButtonTable[arg_6_1][var_6_2] = var_6_8
				var_6_2 = var_6_2 + 1
			end
		end,
		direction = SliderDirection.eHorizontal,
		touchBeginCallback = function(arg_7_0, arg_7_1, arg_7_2)
			local var_7_0 = arg_2_0.tianmingsLayer:convertToNodeSpace(ccp(arg_7_1, arg_7_2))
			local var_7_1 = 0
			local var_7_2 = 1000

			for iter_7_0 = 0, 15 do
				local var_7_3 = (iter_7_0 % 4 + 0.5) * 100 + 20
				local var_7_4 = (4 - math.floor(iter_7_0 / 4) - 0.5) * 90
				local var_7_5 = ccpDistance(var_7_0, ccp(var_7_3, var_7_4))

				if var_7_5 < var_7_2 then
					var_7_2 = var_7_5
					var_7_1 = iter_7_0
				end
			end

			arg_2_0.buttonIndex = var_7_1

			local var_7_6 = arg_2_0.itemButtonTable[arg_7_0][arg_2_0.buttonIndex].headerButton:getTag()

			arg_2_0.curSelectTianmingIndex = var_7_6

			if arg_2_0._tianmingDataList[var_7_6] == nil then
				return false
			end

			arg_2_0.itemButtonTable[arg_7_0][arg_2_0.buttonIndex]:setHeaderOpacity(120)

			local var_7_7 = arg_2_0._tianmingDataList[var_7_6]

			arg_2_0.touchHeaderButton = figure.createHeader({
				type = ItemType.eTianMing,
				itemId = var_7_7.destinyID,
				level = var_7_7.level
			})

			arg_2_0.touchHeaderButton:setScale(Adapter.MinScale)
			arg_2_0.touchHeaderButton:setPosition(ccp(arg_7_1, arg_7_2))
			display.getRunningScene():addChild(arg_2_0.touchHeaderButton)

			return true
		end,
		touchMoveCallback = function(arg_8_0, arg_8_1, arg_8_2)
			if arg_2_0.touchHeaderButton then
				arg_2_0.touchHeaderButton:setPosition(ccp(arg_8_1, arg_8_2))
			end
		end,
		touchEndCallback = function(arg_9_0, arg_9_1, arg_9_2)
			if arg_2_0.touchHeaderButton then
				arg_2_0.touchHeaderButton:removeFromParent()

				arg_2_0.touchHeaderButton = nil

				arg_2_0.itemButtonTable[arg_9_0][arg_2_0.buttonIndex]:setHeaderOpacity(255)
			end

			local var_9_0 = arg_2_0:convertToNodeSpace(ccp(arg_9_1, arg_9_2))
			local var_9_1 = arg_2_0.tianmingsLayer:convertToNodeSpace(ccp(arg_9_1, arg_9_2))

			if var_9_0.x > 0 then
				return
			end

			local var_9_2 = arg_2_0.itemButtonTable[arg_9_0][arg_2_0.buttonIndex].headerButton:getTag()
			local var_9_3 = arg_2_0._tianmingDataList[var_9_2]
			local var_9_4 = arg_2_0.getCurrentIndex()
			local var_9_5 = TianmingHelper:getEmptyTianmingSlot(var_9_3, var_9_4)

			if var_9_5 == 0 then
				local var_9_6 = 40

				for iter_9_0 = 1, 6 do
					local var_9_7 = 165 + (iter_9_0 - 1) % 2 * 285
					local var_9_8 = 440 - math.floor((iter_9_0 - 1) / 2) * 103
					local var_9_9 = ccpDistance(ccp(var_9_7, var_9_8), var_9_0)

					print(var_9_9, var_9_6)

					if var_9_9 < var_9_6 then
						var_9_5 = iter_9_0

						break
					end
				end
			end

			arg_2_0:equipSelectedTianming(var_9_3, var_9_5)
		end
	})

	arg_2_0.tianmingsLayer:setPosition((var_2_1.width - 434) / 2, (var_2_1.height - 360) / 2 + 20)
	arg_2_0.background:addChild(arg_2_0.tianmingsLayer)
	arg_2_0.tianmingsLayer:reloadData()

	local function var_2_4(arg_10_0, arg_10_1)
		local var_10_0 = tolua.cast(arg_10_1, "CCControlButton"):getTag()

		arg_2_0:highlightTabButton(var_10_0)

		arg_2_0._currentSelectIndex = var_10_0
		arg_2_0._currentDisplayPage = 1

		arg_2_0:requestTianmingData()
	end

	for iter_2_0, iter_2_1 in ipairs(var_0_3) do
		local var_2_5 = CCScale9Sprite:create("ui/common/common_073_1.png")
		local var_2_6 = CCScale9Sprite:create("ui/common/common_073_2.png")
		local var_2_7 = CCControlButton:create(iter_2_1.title, _FONT_DEFAULT, Adapter.FontSize(24))

		var_2_7:setPosition(ccp(iter_2_1.x, iter_2_1.y))
		var_2_7:setAnchorPoint(ccp(0.5, 0.5))
		var_2_7:setTag(iter_2_1.tag)
		var_2_7:setPreferredSize(CCSize(100, 50))
		var_2_7:setTitleColorForState(ccc3(255, 227, 150), CCControlStateHighlighted)
		var_2_7:setTitleColorForState(ccc3(196, 151, 79), CCControlStateNormal)
		var_2_7:setBackgroundSpriteForState(var_2_5, CCControlStateNormal)
		var_2_7:setBackgroundSpriteForState(var_2_6, CCControlStateHighlighted)
		var_2_7:addHandleOfControlEvent(var_2_4, CCControlEventTouchUpInside)
		arg_2_0.background:addChild(var_2_7)

		iter_2_1.btn = var_2_7
	end

	local var_2_8 = ui.newControlButton({
		fontSize = 24,
		text = "",
		normalImage = "ui/team/team_110.png",
		highlightedImage = "ui/team/team_110.png",
		textColor = ColorTable.eTitleTabButton_Normal,
		clickAction = function(arg_11_0, arg_11_1)
			if arg_2_0.curHero and arg_2_0.curHero.heroId == 0 then
				ui.showMessageBox({
					text = string.lf("上仙，没有主将上阵，这可怎么穿装备啊~~")
				})

				return
			end

			local var_11_0 = arg_2_0.getCurrentIndex()

			arg_2_0.heroChangeAllTianmingRequest:request(var_11_0)
		end
	})

	var_2_8:setAnchorPoint(ccp(0, 1))
	var_2_8:setPosition(3, 561)
	arg_2_0.background:addChild(var_2_8)

	local var_2_9 = ui.newControlButton({
		normalImage = "uilocal/tianming/tianming_text_027.png",
		highlightedImage = "uilocal/tianming/tianming_text_027.png",
		position = ccp(442, 561),
		clickAction = function(arg_12_0, arg_12_1)
			if #arg_2_0._tianmingDataList > 0 then
				ui.showMessageBox({
					text = string.lf("上仙，您确定要分解背包中所有的天命吗?"),
					title1 = string.lf("确定"),
					action1 = function()
						arg_2_0.tianmingResolveRequest:requestResolveBatch(2)
					end,
					title2 = string.lf("取消")
				})
			end
		end
	})

	var_2_9:setAnchorPoint(ccp(1, 1))
	arg_2_0.background:addChild(var_2_9)
	arg_2_0:requestTianmingData()
	arg_2_0:createNetworkRequest()
	arg_2_0:highlightTabButton(arg_2_0._currentSelectIndex)
	arg_2_0:setNodeEventEnabled(true)
end

function var_0_2.equipSelectedTianming(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0.curHero and arg_14_0.curHero.heroId > 0 then
		arg_14_0.callShowChangeTianmingHintSprite(arg_14_1, arg_14_2)
	else
		ui.showMessageBox({
			text = string.lf("上仙，没有主将上阵，这可怎么上阵天命啊~~")
		})
	end
end

function var_0_2.onEnter(arg_15_0)
	arg_15_0:setPosition(ccp(display.right, 7))

	local function var_15_0()
		return
	end

	local var_15_1 = CCArray:create()
	local var_15_2 = CCMoveTo:create(0.5, ccp(505, 7))
	local var_15_3 = CCEaseElasticOut:create(var_15_2, 0.9)

	var_15_1:addObject(var_15_3)
	var_15_1:addObject(CCCallFunc:create(var_15_0))
	arg_15_0:runAction(CCSequence:create(var_15_1))

	if arg_15_0.appearCallback then
		arg_15_0.appearCallback()
	end
end

function var_0_2.onExit(arg_17_0)
	if arg_17_0.closeCallback then
		arg_17_0.closeCallback()
	end
end

function var_0_2.createNetworkRequest(arg_18_0)
	local function var_18_0()
		arg_18_0.refreshTianmingHandle()
		arg_18_0:requestTianmingData()
	end

	local function var_18_1(arg_20_0)
		return
	end

	arg_18_0.heroChangeAllTianmingRequest = DestinyChangeAllRequest:new()

	arg_18_0.heroChangeAllTianmingRequest:setResponseNormalHandler(var_18_0)
	arg_18_0.heroChangeAllTianmingRequest:setResponseExceptionHandler(var_18_1)

	local function var_18_2()
		arg_18_0:requestTianmingData()
	end

	local function var_18_3()
		return
	end

	arg_18_0.tianmingResolveRequest = TianmingRequest:new()

	arg_18_0.tianmingResolveRequest:setResponseNormalHandler(var_18_0)
	arg_18_0.tianmingResolveRequest:setResponseExceptionHandler(var_18_1)
end

function var_0_2.highlightTabButton(arg_23_0, arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(var_0_3) do
		if iter_23_1.tag == arg_23_1 then
			iter_23_1.btn:setHighlighted(true)
		else
			iter_23_1.btn:setHighlighted(false)
		end
	end
end

function var_0_2.requestTianmingData(arg_24_0)
	local function var_24_0(arg_25_0, arg_25_1)
		arg_24_0._tianmingDataList = arg_25_0

		arg_24_0:sortTianmingData()

		arg_24_0._totalPageCount = math.ceil(#arg_24_0._tianmingDataList / arg_24_0._pageCount)

		if arg_24_0._totalPageCount == 0 then
			arg_24_0._totalPageCount = 1
		end

		local var_25_0 = arg_24_0.tianmingsLayer:getCurrentIndex()

		arg_24_0.tianmingsLayer:reloadData(var_25_0)
	end

	TianmingHelper:getTianmingList(var_24_0, 0)
end

function var_0_2.sortTianmingData(arg_26_0)
	local function var_26_0(arg_27_0, arg_27_1)
		local var_27_0 = arg_27_0
		local var_27_1 = arg_27_1
		local var_27_2 = BaseTianMings[var_27_0.destinyID]
		local var_27_3 = BaseTianMings[var_27_1.destinyID]

		if arg_26_0._currentSelectIndex then
			if var_27_2.quality ~= var_27_3.quality then
				if var_27_2.quality == arg_26_0._currentSelectIndex then
					return true
				elseif var_27_3.quality == arg_26_0._currentSelectIndex then
					return false
				else
					return var_27_2.quality > var_27_3.quality
				end
			elseif var_27_0.level > var_27_1.level then
				return true
			elseif var_27_0.level == var_27_1.level then
				return var_27_0.destinyID > var_27_1.destinyID
			else
				return false
			end
		elseif var_27_2.quality ~= var_27_3.quality then
			return var_27_2.quality > var_27_3.quality
		elseif var_27_0.level > var_27_1.level then
			return true
		elseif var_27_0.level == var_27_1.level then
			return var_27_0.destinyID > var_27_1.destinyID
		else
			return false
		end

		return true
	end

	table.sort(arg_26_0._tianmingDataList, var_26_0)
end

function var_0_2.reloadLayer(arg_28_0, arg_28_1)
	arg_28_0:requestTianmingData()
end

function var_0_2.dismissAnimation(arg_29_0)
	local var_29_0 = CCArray:create()
	local var_29_1 = CCMoveTo:create(0.5, ccp(display.right, 7))
	local var_29_2 = CCEaseElasticIn:create(var_29_1, 0.9)

	var_29_0:addObject(var_29_2)
	var_29_0:addObject(CCCallFunc:create(handler(arg_29_0, arg_29_0.removeFromParent)))
	arg_29_0:runAction(CCSequence:create(var_29_0))
end

function var_0_2.createTipsView(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = arg_30_0.getCurrentIndex()

	arg_30_0.curHero = arg_30_0.team.groupList[var_30_0]

	if arg_30_0.curHero.heroId == 0 then
		return
	end

	arg_30_0._tips = var_0_0.createTips({
		cancelable = true,
		swallow = true,
		touchable = true,
		show = var_0_0.eShowTianming,
		data = arg_30_1,
		heroId = arg_30_0.curHero.heroId,
		removehandler = function()
			GuideLayer:removeGuideLayer(arg_30_0.tianmingScene, TaskEntryType.eTianMing, 8)
		end
	})

	local var_30_1 = BaseTianMings[arg_30_1.destinyID].type

	if var_30_1 ~= TianMingType.eType7 then
		arg_30_0._tips:addAction({
			text = string.lf("装上"),
			callback = function(arg_32_0, arg_32_1)
				arg_30_0:equipSelectedTianming(arg_30_1)
				arg_30_0._tips:removeSelf()
				GuideLayer:removeGuideLayer(arg_30_0.tianmingScene, TaskEntryType.eTianMing, 8)
				GuideLayer:stepDone(TaskEntryType.eTianMing, 8)
			end
		})
	end

	arg_30_0._tips:addAction({
		text = string.lf("分解"),
		callback = function()
			if BaseTianMings[arg_30_1.destinyID].quality == QualityType.eOrange then
				ui.showMessageBox({
					animate = "slide",
					text = string.lf("上仙，高级天命得来不易，确定要分解吗？"),
					title1 = string.lf("确定"),
					action1 = function()
						arg_30_0.tianmingResolveRequest:requestResolve(2, arg_30_1.id)
					end,
					title2 = string.lf("取消")
				})
			else
				arg_30_0.tianmingResolveRequest:requestResolve(2, arg_30_1.id)
			end

			arg_30_0._tips:removeSelf()
			GuideLayer:removeGuideLayer(arg_30_0.tianmingScene, TaskEntryType.eTianMing, 8)
		end
	})
	arg_30_0._tips:show({
		limit = true,
		parent = arg_30_3,
		node = arg_30_2
	})

	if var_30_1 ~= TianMingType.eType7 then
		local var_30_2, var_30_3 = var_0_1.getPosition(arg_30_0._tips.container, arg_30_0.tianmingScene.bg_far_Sprite)
		local var_30_4 = var_30_2 + 90
		local var_30_5 = var_30_3 + 55

		GuideLayer:stepDone(TaskEntryType.eTianMing, 7)
		GuideLayer:showGuideLayer(arg_30_0.tianmingScene, arg_30_0.tianmingScene.bg_far_Sprite, TaskEntryType.eTianMing, 8, ccp(var_30_4, var_30_5), true)
	end
end

function var_0_2.getCurTianmingHeaderButton(arg_35_0)
	local var_35_0
	local var_35_1 = arg_35_0.tianmingsLayer:getCurrentIndex()

	for iter_35_0, iter_35_1 in pairs(arg_35_0.itemButtonTable[var_35_1]) do
		if iter_35_1.headerButton:getTag() == arg_35_0.curSelectTianmingIndex then
			var_35_0 = iter_35_1

			break
		end
	end

	return var_35_0, arg_35_0._tianmingDataList[arg_35_0.curSelectTianmingIndex]
end

return var_0_2
