local var_0_0 = class("WorldBossBaseScene", function()
	return display.newScene("WorldBossBaseScene")
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.mParams = arg_2_1 or {}

	arg_2_0:setUI()
end

function var_0_0.setUI(arg_3_0)
	local var_3_0 = arg_3_0:getImageSize("ui/worldboss/worldboss_009.jpg")
	local var_3_1 = display.newSprite("ui/worldboss/worldboss_009.jpg", display.cx, display.cy)

	var_3_1:setScaleX(display.width / var_3_0.width)
	var_3_1:setScaleY(display.height / var_3_0.height)
	arg_3_0:addChild(var_3_1)

	local var_3_2 = CCSizeMake(display.width / Adapter.MinScale, display.height / Adapter.MinScale)
	local var_3_3 = display.newNode()

	var_3_3:setContentSize(var_3_2)
	var_3_3:setAnchorPoint(ccp(0, 0))
	var_3_3:setScale(Adapter.MinScale)
	arg_3_0:addChild(var_3_3)

	arg_3_0.mContainer = var_3_3
	arg_3_0.mContainerSize = var_3_2

	local var_3_4 = ui.newControlButton({
		normalImage = "ui/common/common_061.png",
		position = ccp(var_3_2.width - 55, var_3_2.height - 31),
		clickAction = handler(arg_3_0, arg_3_0.closeAction)
	})

	var_3_3:addChild(var_3_4)
	arg_3_0:palcePillar()
end

function var_0_0.closeAction(arg_4_0)
	if arg_4_0.mParams.from == "battle" then
		game.enterWorldBossHomeScene()
	else
		game.enterHomeScene()
	end
end

function var_0_0.palcePillar(arg_5_0)
	local var_5_0 = CCSpriteBatchNode:create("ui/worldboss/worldboss_030.png", 2)
	local var_5_1 = CCSpriteBatchNode:create("ui/worldboss/worldboss_031.png", 2)

	arg_5_0.mContainer:addChild(var_5_1)
	arg_5_0.mContainer:addChild(var_5_0)

	local var_5_2 = {}
	local var_5_3 = {}
	local var_5_4 = arg_5_0.mContainerSize.width / 4
	local var_5_5 = var_5_4 / 2
	local var_5_6 = CCSprite:createWithTexture(var_5_0:getTexture())

	var_5_6:setAnchorPoint(ccp(0.5, 0))
	var_5_6:setPosition(var_5_5, 0)
	var_5_0:addChild(var_5_6)

	var_5_3[1] = var_5_6
	var_5_2[1] = ccp(var_5_5, 120)

	local var_5_7 = var_5_5 + var_5_4
	local var_5_8 = CCSprite:createWithTexture(var_5_1:getTexture())

	var_5_8:setAnchorPoint(ccp(0.5, 0))
	var_5_8:setPosition(var_5_7 - 10, 0)
	var_5_1:addChild(var_5_8)

	var_5_3[2] = var_5_8
	var_5_2[2] = ccp(var_5_7 - 10, 240)

	local var_5_9 = var_5_7 + var_5_4
	local var_5_10 = CCSprite:createWithTexture(var_5_1:getTexture())

	var_5_10:setAnchorPoint(ccp(0.5, 0))
	var_5_10:setPosition(var_5_9 + 10, 0)
	var_5_1:addChild(var_5_10)

	var_5_3[3] = var_5_10
	var_5_2[3] = ccp(var_5_9 + 10, 240)

	local var_5_11 = var_5_9 + var_5_4
	local var_5_12 = CCSprite:createWithTexture(var_5_0:getTexture())

	var_5_12:setAnchorPoint(ccp(0.5, 0))
	var_5_12:setPosition(var_5_11, 0)
	var_5_0:addChild(var_5_12)

	var_5_3[4] = var_5_12
	var_5_2[4] = ccp(var_5_11, 120)
	arg_5_0.mPillars = var_5_3
	arg_5_0.mPillarPos = var_5_2
end

function var_0_0.getImageSize(arg_6_0, arg_6_1)
	return CCTextureCache:sharedTextureCache():addImage(arg_6_1):getContentSizeInPixels()
end

return var_0_0
