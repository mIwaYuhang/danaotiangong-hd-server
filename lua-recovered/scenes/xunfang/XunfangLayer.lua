local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = require("base.cache")
local var_0_2 = require("scenes.toollayer.ctrl")

require("data.master")

XunfangType = {
	eTypeNone = 3,
	eTypeNormal = 1,
	eTypeAdvanced = 2
}

local var_0_3 = class("XunfangLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create(ccc4(10, 10, 10, 0)))
end)

function var_0_3.ctor(arg_2_0, arg_2_1)
	arg_2_0.xunfangWorld = arg_2_1.type
	arg_2_0.sceneButtons = arg_2_1.sceneButtons
	arg_2_0.callback = arg_2_1.callback
	arg_2_0.normalSpriteList = {}
	arg_2_0.buttonList = {}
	arg_2_0.openCardNum = 0

	var_0_1.set("XufangSuperCallFlag", true)

	arg_2_0.bgSprite = display.newSprite("ui/xunfang/" .. MasterMap[arg_2_0.xunfangWorld * 5].bgImage)

	arg_2_0.bgSprite:align(display.BOTTOM_CENTER, display.cx, 0)
	arg_2_0.bgSprite:setScaleX(Adapter.AutoScaleX)
	arg_2_0.bgSprite:setScaleY(Adapter.AutoScaleY)
	arg_2_0:addChild(arg_2_0.bgSprite)

	local var_2_0 = Adapter.MinScale
	local var_2_1 = CCSizeMake(display.width / var_2_0, display.height / var_2_0)
	local var_2_2 = display.newNode()

	var_2_2:setContentSize(var_2_1)
	var_2_2:setAnchorPoint(ccp(0, 0))
	var_2_2:setScale(var_2_0)
	arg_2_0:addChild(var_2_2)

	arg_2_0.mContainerScale = var_2_0
	arg_2_0.bgSprite = var_2_2
	arg_2_0.mContainerSize = var_2_1

	arg_2_0:showXunfangMaps()

	local function var_2_3(arg_3_0)
		arg_2_0:refreshXunfangInfo()
	end

	MasterHelper:getActiveMasterList(MasterType.eAll, var_2_3)
	arg_2_0:initRequests()
	GuideLayer:stepDone(TaskEntryType.eXunFangNormal, 2)
	GuideLayer:showGuideLayer(arg_2_0, arg_2_0.bgSprite, TaskEntryType.eXunFangNormal, 3, ccp(var_2_1.width / 2 - 120, 190), true)
end

function var_0_3.refreshXunfangInfo(arg_4_0)
	local var_4_0 = ""
	local var_4_1 = 0
	local var_4_2 = 0
	local var_4_3 = arg_4_0.xunfangWorld

	if var_4_3 == MasterType.eLand then
		var_4_0 = string.lf("人界进度")
	elseif var_4_3 == MasterType.eDemon then
		var_4_0 = string.lf("地界进度")
	elseif var_4_3 == MasterType.eHeaven then
		var_4_0 = string.lf("天界进度")
	elseif var_4_3 == MasterType.eOutHeaven then
		var_4_0 = string.lf("重天进度")
	end

	local var_4_4 = 0

	for iter_4_0, iter_4_1 in pairs(BaseMasters) do
		if iter_4_1.type == arg_4_0.xunfangWorld then
			var_4_4 = var_4_4 + 1
		end
	end

	local var_4_5 = MasterHelper:getActiveMasterOfType(arg_4_0.xunfangWorld)

	arg_4_0.progressBar:setProgressValue(1, var_4_5, var_4_4)
	arg_4_0.worldNameLabel:setString(string.lf("%s: %d/%d", var_4_0, var_4_5, var_4_4))
end

function var_0_3.initRequests(arg_5_0)
	local function var_5_0()
		local var_6_0 = var_0_1.get("XunfangInfoRequest")

		var_6_0.ApprenticeProgress[arg_5_0.xunfangWorld].IsHaveApprentice = arg_5_0.xunfangRequest.restable.IsHaveApprentice
		var_6_0.AttrList = arg_5_0.xunfangRequest.restable.AttrList
		var_6_0.HaveFreeXunFangLing = arg_5_0.xunfangRequest.restable.HaveFreeXunFangLing
		var_6_0.HighNextPrice = arg_5_0.xunfangRequest.restable.HighNextPrice

		var_0_1.set("XunfangInfoRequest", var_6_0)

		arg_5_0.cardList = arg_5_0.xunfangRequest:getOpenCardList()

		arg_5_0:refreshXunfangLing()
		arg_5_0:showXunfangAnimation()
	end

	arg_5_0.xunfangRequest = XunfangRequest:new()

	arg_5_0.xunfangRequest:setResponseNormalHandler(var_5_0)
	arg_5_0.xunfangRequest:setResponseExceptionHandler(function()
		for iter_7_0, iter_7_1 in ipairs(arg_5_0.buttonList) do
			iter_7_1:setEnabled(true)
		end

		for iter_7_2, iter_7_3 in ipairs(arg_5_0.sceneButtons) do
			iter_7_3:setEnabled(true)
		end

		print("处理请求发生错误")
	end)
end

function var_0_3.showXunfangMaps(arg_8_0)
	local var_8_0 = handler(arg_8_0, arg_8_0.buttonClickAction)
	local var_8_1 = {
		{
			normalImage = "ui/xunfang/xunfang_005.png",
			tag = 1,
			position = ccp(arg_8_0.mContainerSize.width / 2 + 120, 130),
			clickAction = var_8_0
		},
		{
			normalImage = "ui/xunfang/xunfang_006.png",
			tag = 2,
			position = ccp(arg_8_0.mContainerSize.width / 2 - 120, 130),
			clickAction = var_8_0
		}
	}

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		local var_8_2 = ui.newControlButton(iter_8_1)

		var_8_2:setTag(iter_8_1.tag)
		arg_8_0.bgSprite:addChild(var_8_2, 1)
		table.insert(arg_8_0.buttonList, var_8_2)
	end

	local var_8_3 = arg_8_0.mContainerSize.width / 2
	local var_8_4 = arg_8_0.mContainerSize.height - 90
	local var_8_5 = display.newSprite("ui/xunfang/xunfang_022.png", var_8_3, var_8_4)

	arg_8_0.bgSprite:addChild(var_8_5, 1)

	arg_8_0.progressBar = require("scenes.ProgressBar").new({
		backImage = "ui/xunfang/xunfang_024.png",
		barImages = {
			"ui/xunfang/xunfang_023.png"
		},
		backSize = CCSize(416, 55),
		barSize = CCSize(388, 18),
		barPosition = ccp(-194, 0),
		labelColor = ccc3(255, 255, 0)
	})

	arg_8_0.progressBar:setPosition(ccp(var_8_3, var_8_4))
	arg_8_0.bgSprite:addChild(arg_8_0.progressBar, 1)
	arg_8_0.progressBar:setProgressValue(1, 6, 27)

	arg_8_0.worldNameLabel = ui.newTTFLabel({
		text = "",
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(20),
		color = ccc3(255, 255, 0),
		align = ui.TEXT_ALIGN_CENTER
	})

	arg_8_0.worldNameLabel:setPosition(ccp(var_8_3, var_8_4))
	arg_8_0.bgSprite:addChild(arg_8_0.worldNameLabel, 1)

	if arg_8_0.xunfangWorld == MasterType.eHeaven then
		local var_8_6 = display.newSprite("ui/xunfang/xunfang_030.png")

		var_8_6:setAnchorPoint(CCPoint(0.5, 0.5))
		var_8_6:setPosition(display.width / 2, display.height / 2)
		arg_8_0.bgSprite:addChild(var_8_6)
	end

	arg_8_0.mapImageList = {}

	for iter_8_2, iter_8_3 in ipairs(MasterMap) do
		if iter_8_3.mapID == arg_8_0.xunfangWorld then
			table.insert(arg_8_0.mapImageList, iter_8_3)
		end
	end

	table.sort(arg_8_0.mapImageList, function(arg_9_0, arg_9_1)
		return arg_9_0.imgSort > arg_9_1.imgSort
	end)

	local var_8_7 = display.newNode()

	for iter_8_4, iter_8_5 in ipairs(arg_8_0.mapImageList) do
		local var_8_8 = iter_8_5
		local var_8_9 = display.newSprite("ui/xunfang/" .. var_8_8.blinkImage)

		var_8_9:setAnchorPoint(ccp(0, 0))
		var_8_9:setPosition(ccp(var_8_8.imgPos.x, 640 - var_8_8.imgPos.y))
		var_8_7:addChild(var_8_9)

		local var_8_10 = display.newSprite("ui/xunfang/" .. var_8_8.normalImage)

		var_8_10:setAnchorPoint(ccp(0, 0))
		var_8_10:setPosition(ccp(var_8_8.imgPos.x, 640 - var_8_8.imgPos.y))
		var_8_7:addChild(var_8_10)
		table.insert(arg_8_0.normalSpriteList, var_8_10)
	end

	var_8_7:setPosition((arg_8_0.mContainerSize.width - CONFIG_SCREEN_WIDTH) / 2, (arg_8_0.mContainerSize.height - CONFIG_SCREEN_HEIGHT) / 2)
	arg_8_0.bgSprite:addChild(var_8_7)

	arg_8_0.commonXunFangLabel = ui.newTTFLabel({
		text = "",
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(22),
		color = ccc3(26, 14, 0),
		align = ui.TEXT_ALIGN_LEFT
	})

	arg_8_0.commonXunFangLabel:setAnchorPoint(ccp(0.5, 0.5))
	arg_8_0.commonXunFangLabel:setPosition(ccp(arg_8_0.mContainerSize.width / 2 - 120, 50))
	arg_8_0.bgSprite:addChild(arg_8_0.commonXunFangLabel)

	arg_8_0.superXunFangLabel = ui.newTTFLabel({
		text = "",
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(22),
		color = ccc3(26, 14, 0),
		align = ui.TEXT_ALIGN_LEFT
	})

	arg_8_0.superXunFangLabel:setAnchorPoint(ccp(0.5, 0.5))
	arg_8_0.superXunFangLabel:setPosition(ccp(arg_8_0.mContainerSize.width / 2 + 120, 50))
	arg_8_0.bgSprite:addChild(arg_8_0.superXunFangLabel)
	arg_8_0:refreshXunfangLing()
end

function var_0_3.refreshXunfangLing(arg_10_0)
	local var_10_0 = ""
	local var_10_1 = var_0_1.get("XunfangInfoRequest")
	local var_10_2 = 0

	if var_10_1 and var_10_1.HaveFreeXunFangLing > 0 then
		local var_10_3 = var_10_1.HaveFreeXunFangLing

		var_10_0 = string.lf("免费寻访:%d", var_10_3)
	else
		local var_10_4 = Player:getItemCount(ItemType.eProp, 140010)

		var_10_0 = string.lf("普通寻访令:%d", var_10_4)
	end

	arg_10_0.commonXunFangLabel:setString(var_10_0)

	local var_10_5 = Player:getItemCount(ItemType.eProp, 140011)
	local var_10_6 = ""

	if var_10_5 > 0 then
		var_10_6 = string.lf("高级寻访令:%d", var_10_5)
	elseif var_10_1 then
		local var_10_7 = var_10_1.HighNextPrice

		var_10_6 = string.lf("消耗元宝:%d", var_10_7)
	else
		local var_10_8 = 0

		var_10_6 = string.lf("高级寻访令:%d", var_10_8)
	end

	arg_10_0.superXunFangLabel:setString(var_10_6)
end

function var_0_3.buttonClickAction(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2:getTag() == 1 and XunfangType.eTypeAdvanced or XunfangType.eTypeNormal

	local function var_11_1()
		arg_11_0.xunfangRequest:request(arg_11_0.xunfangWorld, var_11_0)
		arg_11_0:cleanRewardButtons()

		for iter_12_0, iter_12_1 in ipairs(arg_11_0.normalSpriteList) do
			iter_12_1:setVisible(true)
		end

		for iter_12_2, iter_12_3 in ipairs(arg_11_0.buttonList) do
			iter_12_3:setEnabled(false)
		end

		for iter_12_4, iter_12_5 in ipairs(arg_11_0.sceneButtons) do
			iter_12_5:setEnabled(false)
		end
	end

	local var_11_2 = var_0_1.get("XunfangInfoRequest").HighNextPrice

	if var_11_0 == XunfangType.eTypeAdvanced then
		local var_11_3 = Player:getItemCount(ItemType.eProp, 140011)

		print("高级寻访令个数: " .. var_11_3)

		local function var_11_4()
			var_11_1()
			arg_11_0.callback()
		end

		if var_11_3 > 0 then
			var_11_4()
		elseif isMoneyEnough(MoneyType.eGold, var_11_2) == true then
			if var_0_1.get("XufangSuperCallFlag") then
				local var_11_5 = var_0_0.createDialog({
					show = var_0_0.eShowNoticeBox,
					data = string.lf("上仙，您是否需要花费#FFFF00%d#FFFFFF元宝, 进行高级寻访?", var_11_2),
					callback = function()
						var_11_4()
					end
				})
				local var_11_6 = var_0_2.createToggleButton({
					text = string.lf("不再显示"),
					callback = function(arg_15_0)
						local var_15_0 = not arg_15_0

						var_0_1.set("XufangSuperCallFlag", var_15_0)
					end
				})

				var_11_5:addNode(var_11_6)
				var_11_5:show()
			else
				var_11_4()
			end
		elseif isMoneyEnough(MoneyType.eGold, var_11_2) == false and var_11_3 < 0 then
			showFlashNotice(string.lf("元宝和寻访次数均不足, 无法进行~"))
		elseif var_11_3 < 0 then
			showFlashNotice(string.lf("寻访次数不足, 无法进行~"))
		else
			showFlashNotice(string.lf("元宝不足, 无法进行~"))
		end
	else
		local var_11_7 = var_0_1.get("XunfangInfoRequest").HaveFreeXunFangLing
		local var_11_8 = Player:getItemCount(ItemType.eProp, 140010)

		arg_11_0.commonXunFangLabel:setString(string.lf("普通寻访令:%d", var_11_8))

		if var_11_8 > 0 or var_11_7 > 0 then
			var_11_1()
			arg_11_0.callback()
		else
			showFlashNotice(string.lf("寻访次数不足, 无法进行~"))
		end
	end

	GuideLayer:removeGuideLayer(arg_11_0, TaskEntryType.eXunFangNormal, 3)
	GuideLayer:stepDone(TaskEntryType.eXunFangNormal, 3)
end

function var_0_3.showXunfangAnimation(arg_16_0)
	local var_16_0 = 1
	local var_16_1 = 10

	local function var_16_2()
		var_16_1 = var_16_1 - 1

		local var_17_0 = math.random(1, 5)

		var_16_0 = var_16_0 == var_17_0 and math.random(1, 5) or var_17_0

		local var_17_1 = arg_16_0.normalSpriteList[var_16_0]
		local var_17_2 = CCArray:create()

		var_17_2:addObject(CCFadeOut:create(0.1))
		var_17_2:addObject(CCFadeIn:create(0.1))
		var_17_2:addObject(CCCallFunc:create(function()
			var_16_2()
		end))
		var_17_1:runAction(CCSequence:create(var_17_2))

		if var_16_1 <= 0 then
			var_17_1:stopAllActions()
			var_17_1:setVisible(false)

			if arg_16_0.cardList and table.nums(arg_16_0.cardList) == 5 then
				arg_16_0:showFiveCards()

				for iter_17_0, iter_17_1 in ipairs(arg_16_0.normalSpriteList) do
					iter_17_1:setVisible(false)
				end

				arg_16_0:openCard(button)
			elseif arg_16_0.cardList and table.nums(arg_16_0.cardList) == 1 then
				arg_16_0:showCardByPosition(arg_16_0.mapImageList[var_16_0].imgPos)

				local var_17_3, var_17_4 = arg_16_0.normalSpriteList[var_16_0]:getPosition()

				arg_16_0:openCard(button)
			else
				print("后台返回信息出错")
			end
		end
	end

	var_16_2()
end

function var_0_3.showCardByPosition(arg_19_0, arg_19_1)
	if arg_19_0.rewardLayer then
		arg_19_0.rewardLayer:removeFromParentAndCleanup(true)

		arg_19_0.rewardLayer = nil
	end

	arg_19_0.rewardLayer = CCLayerColor:create(ccc4(10, 10, 10, 200))

	local var_19_0 = CCSizeMake(display.width / Adapter.MinScale, display.height / Adapter.MinScale)

	arg_19_0.rewardLayer:setContentSize(var_19_0)
	arg_19_0.rewardLayer:setAnchorPoint(ccp(0, 0))
	arg_19_0.rewardLayer:setScale(Adapter.MinScale)
	arg_19_0:addChild(arg_19_0.rewardLayer, 1)
	arg_19_0:rewardLayerTouched(arg_19_0.rewardLayer)

	local var_19_1 = var_19_0.width / 2
	local var_19_2 = var_19_0.height / 2
	local var_19_3 = {
		"xunfang_014.png",
		"xunfang_017.png",
		"xunfang_019.png",
		"xunfang_021.png"
	}
	local var_19_4 = BaseMasters[arg_19_0.cardList[1].Id].quality
	local var_19_5 = ui.newControlButton({
		fontSize = 24,
		text = "",
		scaleX = 1,
		scaleY = 1,
		normalImage = "ui/xunfang/" .. var_19_3[var_19_4],
		position = ccp(var_19_1, var_19_2),
		clickAction = handler(arg_19_0, arg_19_0.cardBtnClicked),
		anchorPoint = CCPoint(0.5, 0.5)
	})

	var_19_5:setTag(1)
	arg_19_0.rewardLayer:addChild(var_19_5, 2)
	var_19_5:setScale(0.4)

	local var_19_6 = CCArray:create()

	var_19_6:addObject(CCMoveTo:create(0.2, ccp(var_19_1, var_19_2)))
	var_19_6:addObject(CCScaleTo:create(0.2, 1))
	var_19_6:addObject(CCCallFunc:create(function()
		return
	end))
	var_19_5:runAction(CCSequence:create(var_19_6))
	table.insert(arg_19_0.rewardButtons, var_19_5)
end

function var_0_3.cleanRewardButtons(arg_21_0)
	if arg_21_0.rewardButtons then
		for iter_21_0, iter_21_1 in ipairs(arg_21_0.rewardButtons) do
			iter_21_1:removeFromParentAndCleanup(true)
		end
	end

	if arg_21_0.rewardLayer then
		arg_21_0.rewardLayer:removeFromParentAndCleanup(true)

		arg_21_0.rewardLayer = nil
	end

	arg_21_0.rewardButtons = {}
	arg_21_0.openCardNum = 0
end

function var_0_3.rewardLayerTouched(arg_22_0, arg_22_1)
	local function var_22_0(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_0 == "began" then
			if arg_22_0.openCardNum >= table.nums(arg_22_0.rewardButtons) then
				arg_22_0:cleanRewardButtons()

				for iter_23_0, iter_23_1 in ipairs(arg_22_0.normalSpriteList) do
					iter_23_1:setVisible(true)
				end

				for iter_23_2, iter_23_3 in ipairs(arg_22_0.buttonList) do
					iter_23_3:setEnabled(true)
				end

				for iter_23_4, iter_23_5 in ipairs(arg_22_0.sceneButtons) do
					iter_23_5:setEnabled(true)
				end

				arg_22_0.callback()
				arg_22_0:refreshXunfangInfo()
			end

			return true
		elseif arg_23_0 == "moved" then
			-- block empty
		elseif arg_23_0 ~= "ended" and arg_23_0 == "cancelled" then
			-- block empty
		end
	end

	arg_22_1:addTouchEventListener(var_22_0, false, 1, true)
	arg_22_1:setTouchEnabled(true)
end

function var_0_3.showFiveCards(arg_24_0)
	if arg_24_0.rewardLayer then
		arg_24_0.rewardLayer:removeFromParentAndCleanup(true)

		arg_24_0.rewardLayer = nil
	end

	arg_24_0.rewardLayer = CCLayerColor:create(ccc4(10, 10, 10, 200))

	local var_24_0 = CCSizeMake(display.width / Adapter.MinScale, display.height / Adapter.MinScale)

	arg_24_0.rewardLayer:setContentSize(var_24_0)
	arg_24_0.rewardLayer:setAnchorPoint(ccp(0, 0))
	arg_24_0.rewardLayer:setScale(Adapter.MinScale)
	arg_24_0:addChild(arg_24_0.rewardLayer, 1)
	arg_24_0:rewardLayerTouched(arg_24_0.rewardLayer)

	local var_24_1 = {
		ccp(var_24_0.width / 2 - 220, var_24_0.height / 2 + 130),
		ccp(var_24_0.width / 2 - 220, var_24_0.height / 2 - 110),
		ccp(var_24_0.width / 2, var_24_0.height / 2),
		ccp(var_24_0.width / 2 + 220, var_24_0.height / 2 + 130),
		ccp(var_24_0.width / 2 + 220, var_24_0.height / 2 - 110)
	}
	local var_24_2 = {
		"xunfang_014.png",
		"xunfang_017.png",
		"xunfang_019.png",
		"xunfang_021.png"
	}

	for iter_24_0 = 1, table.nums(arg_24_0.mapImageList) do
		local var_24_3 = arg_24_0.mapImageList[iter_24_0]
		local var_24_4 = BaseMasters[arg_24_0.cardList[iter_24_0].Id].quality
		local var_24_5 = ui.newControlButton({
			fontSize = 24,
			text = "",
			scaleX = 1,
			scaleY = 1,
			normalImage = "ui/xunfang/" .. var_24_2[var_24_4],
			position = ccp(var_24_0.width / 2, var_24_0.height / 2),
			clickAction = handler(arg_24_0, arg_24_0.cardBtnClicked),
			anchorPoint = CCPoint(0.5, 0.5)
		})

		var_24_5:setTag(iter_24_0)
		arg_24_0.rewardLayer:addChild(var_24_5, 2)
		var_24_5:setScale(0.4)

		local var_24_6 = CCArray:create()

		var_24_6:addObject(CCMoveTo:create(0.2, ccp(var_24_1[iter_24_0].x, var_24_1[iter_24_0].y)))
		var_24_6:addObject(CCScaleTo:create(0.2, 1))
		var_24_6:addObject(CCCallFunc:create(function()
			return
		end))
		var_24_5:runAction(CCSequence:create(var_24_6))
		table.insert(arg_24_0.rewardButtons, var_24_5)
	end
end

function var_0_3.cardBtnClicked(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_2

	if arg_26_0.openCardNum >= table.nums(arg_26_0.rewardButtons) then
		arg_26_0:cleanRewardButtons()

		for iter_26_0, iter_26_1 in ipairs(arg_26_0.normalSpriteList) do
			iter_26_1:setVisible(true)
		end

		for iter_26_2, iter_26_3 in ipairs(arg_26_0.buttonList) do
			iter_26_3:setEnabled(true)
		end

		for iter_26_4, iter_26_5 in ipairs(arg_26_0.sceneButtons) do
			iter_26_5:setEnabled(true)
		end

		arg_26_0.callback()
		arg_26_0:refreshXunfangInfo()
	end
end

function var_0_3.openCard(arg_27_0, arg_27_1)
	local var_27_0 = {
		"xunfang_013.png",
		"xunfang_016.png",
		"xunfang_018.png",
		"xunfang_020.png"
	}

	local function var_27_1()
		for iter_28_0, iter_28_1 in ipairs(arg_27_0.buttons) do
			iter_28_1:stopAllActions()
		end
	end

	for iter_27_0, iter_27_1 in ipairs(arg_27_0.rewardButtons) do
		iter_27_1:setEnabled(false)
	end

	for iter_27_2, iter_27_3 in ipairs(arg_27_0.rewardButtons) do
		local var_27_2 = CCArray:create()

		var_27_2:addObject(CCDelayTime:create(0.2 * iter_27_2))

		local var_27_3 = CCOrbitCamera:create(0.5, 1, 0, 0, 90, 0, 0)

		var_27_2:addObject(var_27_3)
		var_27_2:addObject(CCCallFunc:create(function()
			local var_29_0 = BaseMasters[arg_27_0.cardList[iter_27_2].Id].quality
			local var_29_1 = "ui/xunfang/" .. var_27_0[var_29_0]

			iter_27_3:setBackgroundSpriteForState(CCScale9Sprite:create(var_29_1), CCControlStateNormal)
			iter_27_3:setBackgroundSpriteForState(CCScale9Sprite:create(var_29_1), CCControlStateHighlighted)
			iter_27_3:setBackgroundSpriteForState(CCScale9Sprite:create(var_29_1), CCControlStateDisabled)
			arg_27_0:showCardInfo(iter_27_3, iter_27_2)
		end))
		var_27_2:addObject(var_27_3:reverse())
		var_27_2:addObject(CCCallFunc:create(function()
			iter_27_3:stopAllActions()

			if iter_27_2 == table.nums(arg_27_0.rewardButtons) then
				for iter_30_0, iter_30_1 in ipairs(arg_27_0.rewardButtons) do
					iter_30_1:setEnabled(true)
				end
			end

			arg_27_0.openCardNum = arg_27_0.openCardNum + 1
		end))
		iter_27_3:runAction(CCSequence:create(var_27_2))
	end
end

function var_0_3.showCardInfo(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0.cardList[arg_31_2]
	local var_31_1 = {
		isName = true,
		type = ItemType.eMaster,
		itemId = var_31_0.Id,
		nameColor = ccc3(255, 233, 143),
		clickAction = function(arg_32_0, arg_32_1)
			var_0_0.tipshandler(var_31_0)
		end
	}
	local var_31_2 = figure.createHeader(var_31_1)

	var_31_2:setPosition(88, 160)
	var_31_2:setAnchorPoint(ccp(0.5, 0.5))
	arg_31_1:addChild(var_31_2)
	Adapter.NodeAbsScale(var_31_2)

	local var_31_3 = ""
	local var_31_4 = getItemName(var_31_1.type, var_31_1.itemId)

	if var_31_0.Status == 1 then
		var_31_3 = string.lf("全体血量+#00FF00%d", var_31_0.Count)
	elseif var_31_0.Status == 2 then
		var_31_3 = string.lf("拥有数量:#00FF00+1")
	elseif var_31_0.Status == 3 then
		var_31_3 = string.lf("超出所需上限\n授业值+#00FF00%d", var_31_0.Count)
	end

	local var_31_5 = ui.newTTFLabel({
		y = 60,
		x = 87,
		text = var_31_3,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(16),
		color = ccc3(253, 255, 255),
		align = ui.TEXT_ALIGN_CENTER,
		valign = ui.TEXT_VALIGN_CENTER,
		dimensions = CCSize(150, 180)
	})

	arg_31_1:addChild(var_31_5)
	Adapter.NodeAbsScale(var_31_5)
end

return var_0_3
