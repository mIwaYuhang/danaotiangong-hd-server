local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = require("base.cache")

require("network.XunfangRequest")

ButtonTypeTag = {
	eButtonTujian = 5,
	eButtonHeaven = 3,
	eButtonBaishi = 6,
	eButtonOutHeaven = 4,
	eButtonLand = 1,
	eButtonDemon = 2
}

local var_0_2 = class("XunfangScene", function()
	return display.newScene("XunfangScene")
end)

function var_0_2.ctor(arg_2_0, arg_2_1)
	arg_2_0.sceneButtonList = {}

	local var_2_0 = require("scenes.CommonBgLayer").new({
		closeButtonNormalImage = "ui/common/common_061.png",
		isHideBgSprite = true,
		closeButtonPosition = ccp(880000, 600)
	})

	arg_2_0:addChild(var_2_0)

	arg_2_0.bgSprite = var_2_0:getBackgroundSprite()

	addCloseButton(arg_2_0, arg_2_1.returnAction or function()
		dump(arg_2_0.worldType)
		game.enterHomeScene({
			showSubLayer = ShowSubLayerType.eCopyHome
		})
	end)
	arg_2_0:showUI()

	if var_0_1.get("XufangWorldType") then
		arg_2_0:showLayerByType(var_0_1.get("XufangWorldType"))
	else
		arg_2_0:showLayerByType(MasterType.eLand)
	end

	arg_2_0:initRequests()
	arg_2_0.getXunfangInfoRequest:request()
	GuideLayer:stepDone(TaskEntryType.eBaiShi, 2)
	GuideLayer:showGuideLayer(arg_2_0, arg_2_0.bgSprite, TaskEntryType.eBaiShi, 3, nil, true)
end

function var_0_2.initRequests(arg_4_0)
	local function var_4_0()
		arg_4_0.xunfangInfo = arg_4_0.getXunfangInfoRequest.restable

		var_0_1.set("XunfangInfoRequest", arg_4_0.xunfangInfo)
		arg_4_0.xunfangLayer:refreshXunfangLing()
		arg_4_0:updateXunfangInfo()
	end

	arg_4_0.getXunfangInfoRequest = GetXunfangInfoRequest:new()

	arg_4_0.getXunfangInfoRequest:setResponseNormalHandler(var_4_0)
end

function var_0_2.showLayerByType(arg_6_0, arg_6_1)
	if arg_6_0.xunfangLayer then
		arg_6_0.xunfangLayer:removeFromParentAndCleanup(true)

		arg_6_0.xunfangLayer = nil
	end

	arg_6_0.xunfangLayer = require("scenes.xunfang.XunfangLayer").new({
		callback = handler(arg_6_0, arg_6_0.updateXunfangInfo),
		sceneButtons = arg_6_0.sceneButtonList,
		type = arg_6_1
	})

	arg_6_0:addChild(arg_6_0.xunfangLayer, -1)
	var_0_1.set("XufangWorldType", arg_6_1)
	arg_6_0:setWorldype(arg_6_1)
	arg_6_0:updateXunfangInfo()
end

function var_0_2.setWorldype(arg_7_0, arg_7_1)
	arg_7_0.worldType = arg_7_1

	if arg_7_0.wordSprite then
		arg_7_0.wordSprite:removeFromParentAndCleanup(true)

		arg_7_0.wordSprite = nil
	end

	local var_7_0 = "xunfang_text_021.png"

	if arg_7_1 == MasterType.eLand then
		var_7_0 = "xunfang_text_021.png"
	elseif arg_7_1 == MasterType.eDemon then
		var_7_0 = "xunfang_text_022.png"
	elseif arg_7_1 == MasterType.eHeaven then
		var_7_0 = "xunfang_text_023.png"
	elseif arg_7_1 == MasterType.eOutHeaven then
		var_7_0 = "xunfang_text_024.png"
	end

	arg_7_0.wordSprite = display.newSprite("uilocal/xunfang/" .. var_7_0)

	arg_7_0.wordSprite:setAnchorPoint(CCPoint(0.5, 0.5))
	arg_7_0.wordSprite:setPosition(100, 570)
	arg_7_0.bgSprite:addChild(arg_7_0.wordSprite)
end

function var_0_2.buttonClickAction(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_2:getTag()
	local var_8_1 = arg_8_2
	local var_8_2 = Player.level
	local var_8_3 = 0

	if var_8_0 == ButtonTypeTag.eButtonLand then
		local var_8_4 = 70

		if var_8_2 < var_8_4 then
			showFlashNotice(string.lf("需要%d级开放", var_8_4))
		else
			arg_8_0:showLayerByType(MasterType.eLand)
		end
	elseif var_8_0 == ButtonTypeTag.eButtonDemon then
		local var_8_5 = 80

		if var_8_2 < var_8_5 then
			showFlashNotice(string.lf("需要%d级开放", var_8_5))
		else
			arg_8_0:showLayerByType(MasterType.eDemon)
		end
	elseif var_8_0 == ButtonTypeTag.eButtonHeaven then
		local var_8_6 = 90

		if var_8_2 < var_8_6 then
			showFlashNotice(string.lf("需要%d级开放", var_8_6))
		else
			arg_8_0:showLayerByType(MasterType.eHeaven)
		end
	elseif var_8_0 == ButtonTypeTag.eButtonOutHeaven then
		local var_8_7 = 100

		if var_8_2 < var_8_7 then
			showFlashNotice(string.lf("需要%d级开放", var_8_7))
		else
			arg_8_0:showLayerByType(MasterType.eOutHeaven)
		end
	elseif var_8_0 == ButtonTypeTag.eButtonTujian then
		local var_8_8 = require("scenes.xunfang.XFTujianLayer").new({
			callback = handler(arg_8_0, arg_8_0.updateXunfangInfo),
			pageType = arg_8_0.worldType
		})

		display.getRunningScene():addChild(var_8_8, DefaultZOrder.ePopupLayer)
	elseif var_8_0 == ButtonTypeTag.eButtonBaishi then
		local var_8_9 = require("scenes.xunfang.XFBaishiLayer").new({
			callback = handler(arg_8_0, arg_8_0.updateXunfangInfo),
			pageType = arg_8_0.worldType
		})

		display.getRunningScene():addChild(var_8_9, DefaultZOrder.ePopupLayer)
		GuideLayer:removeGuideLayer(arg_8_0, TaskEntryType.eBaiShi, 3)
		GuideLayer:stepDone(TaskEntryType.eBaiShi, 3)
	end
end

function var_0_2.showUI(arg_9_0)
	local var_9_0 = handler(arg_9_0, arg_9_0.buttonClickAction)

	arg_9_0.buttonTable = {
		{
			normalImage = "ui/worldmap/worldmap_009.png",
			tag = 1,
			position = ccp(90, 470),
			nameText = string.lf("人界"),
			clickAction = var_9_0
		},
		{
			normalImage = "ui/worldmap/worldmap_008.png",
			tag = 2,
			position = ccp(90, 360),
			nameText = string.lf("地界"),
			clickAction = var_9_0
		},
		{
			normalImage = "ui/worldmap/worldmap_010.png",
			tag = 3,
			position = ccp(90, 250),
			nameText = string.lf("天界"),
			clickAction = var_9_0
		},
		{
			normalImage = "ui/worldmap/worldmap_012.png",
			tag = 4,
			position = ccp(90, 140),
			nameText = string.lf("重天"),
			clickAction = var_9_0
		},
		{
			normalImage = "ui/xunfang/xunfang_001.png",
			tag = 5,
			position = ccp(890, 400),
			clickAction = var_9_0
		},
		{
			normalImage = "ui/xunfang/xunfang_007.png",
			nameText = "",
			tag = 6,
			position = ccp(890, 280),
			clickAction = var_9_0
		}
	}

	function arg_9_0.showFlashLight(arg_10_0, arg_10_1, arg_10_2)
		if not arg_10_0.mFlashLightSprite then
			display.addSpriteFramesWithFile("ui/map/ui_baoxiang.plist", "ui/map/ui_baoxiang.png")

			local var_10_0 = display.newSprite("#ui_baoxiang_01.png")
			local var_10_1 = display.newFrames("ui_baoxiang_0%d.png", 1, 5)
			local var_10_2 = display.newAnimation(var_10_1, 0.1)

			var_10_0:runAction(CCRepeatForever:create(CCAnimate:create(var_10_2)))
			arg_10_0.bgSprite:addChild(var_10_0, 1)

			arg_10_0.mFlashLightSprite = var_10_0
		end

		if arg_10_1 == MasterType.eLand and arg_10_2 then
			arg_10_0.mFlashLightSprite:setPosition(arg_10_0.buttonTable[6].position)
		elseif arg_10_1 == MasterType.eDemon and arg_10_2 then
			arg_10_0.mFlashLightSprite:setPosition(arg_10_0.buttonTable[6].position)
		elseif arg_10_1 == MasterType.eHeaven and arg_10_2 then
			arg_10_0.mFlashLightSprite:setPosition(arg_10_0.buttonTable[6].position)
		elseif arg_10_1 == MasterType.eOutHeaven and arg_10_2 then
			arg_10_0.mFlashLightSprite:setPosition(arg_10_0.buttonTable[6].position)
		else
			arg_10_0.mFlashLightSprite:setPosition(-20, -200)
		end
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.buttonTable) do
		local var_9_1 = ui.newControlButton(iter_9_1)

		var_9_1:setTag(iter_9_1.tag)
		arg_9_0.bgSprite:addChild(var_9_1)
		table.insert(arg_9_0.sceneButtonList, var_9_1)

		if iter_9_1.nameText then
			local var_9_2 = display.newSprite("ui/common/common_052.png", 46, 0)

			var_9_1:addChild(var_9_2)
			addLabelWithColorSize(var_9_1, iter_9_1.nameText, ccc3(255, 235, 190), 22, ccp(0.5, 0.5), ccp(46, 0), _FONT_LISU)
		end
	end

	local function var_9_3()
		local var_11_0 = require("scenes.enhance.DlgRuleLayer").new({
			ruleType = DlgRuleType.ruleXunfang
		})

		CCDirector:sharedDirector():getRunningScene():addChild(var_11_0)
	end

	local var_9_4 = ui.newControlButton({
		normalImage = "ui/enhance/enhance_015.png",
		clickAction = var_9_3,
		position = ccp(890, 500)
	})

	arg_9_0.bgSprite:addChild(var_9_4, 1)

	local var_9_5 = createPlayerAttrNode({
		ItemType.eGold,
		ItemType.eLearnExp
	})

	var_9_5:setPosition(ccp(Adapter.AutoWidth(300), display.top - Adapter.MinHeight(50)))
	var_9_5:setScale(Adapter.MinScale)
	arg_9_0:addChild(var_9_5)

	local var_9_6 = display.newSprite("uilocal/xunfang/xunfang_text_029.png")

	var_9_6:setScale(Adapter.MinScale)
	var_9_6:setPosition(ccp(Adapter.AutoWidth(500), display.top - Adapter.MinHeight(140)))
	arg_9_0:addChild(var_9_6)

	arg_9_0.addHealthLabel = ui.newTTFLabel({
		text = "",
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(22),
		color = ccc3(255, 0, 0),
		dimensions = CCSize(260, 40),
		align = ui.TEXT_ALIGN_LEFT
	})

	arg_9_0.addHealthLabel:setAnchorPoint(CCPoint(0, 0))
	arg_9_0.addHealthLabel:setPosition(ccp(70, -7))
	var_9_6:addChild(arg_9_0.addHealthLabel)

	arg_9_0.baishiLabel = ui.newTTFLabel({
		text = "",
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(22),
		color = ccc3(255, 255, 0),
		dimensions = CCSize(100, 40),
		align = ui.TEXT_ALIGN_CENTER
	})

	arg_9_0.baishiLabel:setPosition(ccp(890, 226))
	arg_9_0.bgSprite:addChild(arg_9_0.baishiLabel)
end

function var_0_2.updateXunfangInfo(arg_12_0)
	arg_12_0.xunfangLayer:refreshXunfangInfo()

	local var_12_0 = var_0_1.get("XunfangInfoRequest")

	if var_12_0 then
		arg_12_0.addHealthLabel:setString(string.lf(" +%d", var_12_0.AttrList[1].AddValue))

		local var_12_1 = var_12_0.ApprenticeProgress[arg_12_0.worldType]

		arg_12_0.IsHaveLight = var_12_0.ApprenticeProgress[arg_12_0.worldType].IsHaveApprentice

		arg_12_0:showFlashLight(arg_12_0.worldType, arg_12_0.IsHaveLight)
		arg_12_0.baishiLabel:setString(string.format("%d/%d", var_12_1.ApprenticedCount, var_12_1.TotalCount))
	end
end

return var_0_2
