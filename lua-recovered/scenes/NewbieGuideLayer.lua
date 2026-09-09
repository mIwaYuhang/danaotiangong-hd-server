require("data.task")

local var_0_0 = class("NewbieGuideLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.arrowType = arg_2_1.arrowType
	arg_2_0.buttonPos = arg_2_1.buttonPos
	arg_2_0.buttonSize = arg_2_1.buttonSize
	arg_2_0.callback = arg_2_1.callback
	arg_2_0.noBackground = arg_2_1.noBackground

	if arg_2_0.noBackground == nil then
		arg_2_0:createBackgroundLayer(arg_2_0.buttonPos, arg_2_0.buttonSize)
	end

	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 0, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.arrowSprite = display.newSprite("ui/common/common_104.png", 0, 0)

	arg_2_0.arrowSprite:setScale(Adapter.MinScale)
	arg_2_0.arrowSprite:setVisible(false)
	arg_2_0:addChild(arg_2_0.arrowSprite, 1)

	arg_2_0.textSprite = display.newSprite("ui/common/common_102.png", 0, 0)

	arg_2_0.arrowSprite:addChild(arg_2_0.textSprite)
	addLabelWithColorSize(arg_2_0.textSprite, string.lf("请点击这里"), ccc3(0, 0, 0), 20, ccp(0.5, 0.5), ccp(70, 25))
	arg_2_0.arrowSprite:setVisible(false)
	arg_2_0:setRectClickCallback()
end

function var_0_0.showTextDialog(arg_4_0, arg_4_1)
	arg_4_0.bgSprite = display.newSprite("ui/common/common_114.png")

	arg_4_0.bgSprite:setScale(Adapter.MinScale)

	local var_4_0 = addLabelWithColorSize(arg_4_0.bgSprite, arg_4_1, ccc3(255, 255, 255), 23, ccp(0, 0), ccp(280, 55))

	var_4_0:setHorizontalAlignment(kCCTextAlignmentLeft)
	var_4_0:setDimensions(CCSize(400, 120))

	return arg_4_0.bgSprite
end

function var_0_0.showGuideLayer(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2 ~= "" then
		local var_5_0 = arg_5_0:showTextDialog(arg_5_2)

		var_5_0:setPosition(Adapter.AutoPos(arg_5_1.x, arg_5_1.y))
		arg_5_0:addChild(var_5_0)
	end
end

function var_0_0.setRectClickCallback(arg_6_0)
	local function var_6_0()
		if arg_6_0.callback then
			local var_7_0 = arg_6_0.callback(arg_6_0)

			if arg_6_0.bgSprite then
				arg_6_0.bgSprite:setVisible(false)
				arg_6_0.arrowSprite:setVisible(false)
			end

			arg_6_0.responseButton:setEnabled(false)
		end
	end

	arg_6_0.responseButton = ui.newControlButton({
		text = "",
		normalImage = "ui/tower/tower_046.png",
		size = arg_6_0.buttonSize,
		position = arg_6_0.buttonPos,
		clickAction = var_6_0,
		anchorPoint = CCPoint(0.5, 0.5),
		scaleX = Adapter.MinScale,
		scaleY = Adapter.MinScale
	})

	arg_6_0.responseButton:setOpacity(0)
	arg_6_0:add(arg_6_0.responseButton)

	local var_6_1 = ccp(arg_6_0.buttonPos.x, arg_6_0.buttonPos.y)

	if arg_6_0.arrowType == TaskArrowDirType.eArrowDirUp then
		var_6_1.y = var_6_1.y - arg_6_0.buttonSize.height * 0.45 * Adapter.MinScale
	elseif arg_6_0.arrowType == TaskArrowDirType.eArrowDirDown then
		var_6_1.y = var_6_1.y + arg_6_0.buttonSize.height * 0.45 * Adapter.MinScale
	elseif arg_6_0.arrowType == TaskArrowDirType.eArrowDirLeft then
		var_6_1.x = var_6_1.x + arg_6_0.buttonSize.height * 0.45 * Adapter.MinScale
	elseif arg_6_0.arrowType == TaskArrowDirType.eArrowDirRight then
		var_6_1.x = var_6_1.x - arg_6_0.buttonSize.height * 0.45 * Adapter.MinScale
	end

	arg_6_0:arrowAnimation(var_6_1, arg_6_0.arrowType)
end

function var_0_0.arrowAnimation(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 == nil then
		arg_8_2 = arg_8_0._curArrowType
	end

	local var_8_0 = TaskTextSpritePos[arg_8_2]
	local var_8_1 = TaskArrowRotationAngle[arg_8_2]

	arg_8_0.arrowSprite:stopAllActions()
	arg_8_0.arrowSprite:setVisible(true)
	arg_8_0.arrowSprite:setPosition(arg_8_1)
	arg_8_0.arrowSprite:setRotation(var_8_1)
	arg_8_0.textSprite:setRotation(-var_8_1)
	arg_8_0.textSprite:setPosition(var_8_0)
	arg_8_0.textSprite:setVisible(true)

	local var_8_2 = 0
	local var_8_3 = 0

	if arg_8_2 == TaskArrowDirType.eArrowDirUp or arg_8_2 == TaskArrowDirType.eArrowDirDown then
		var_8_2, var_8_3 = 0, 20
	elseif arg_8_2 == TaskArrowDirType.eArrowDirLeft or arg_8_2 == TaskArrowDirType.eArrowDirRight then
		var_8_2, var_8_3 = 20, 0
	end

	local var_8_4 = CCArray:create()

	var_8_4:addObject(CCMoveBy:create(0.3, Adapter.MinPos(var_8_2, var_8_3)))
	var_8_4:addObject(CCMoveBy:create(0.3, Adapter.MinPos(-var_8_2, -var_8_3)))
	arg_8_0.arrowSprite:runAction(CCRepeatForever:create(CCSequence:create(var_8_4)))
end

function var_0_0.createBackgroundLayer(arg_9_0, arg_9_1, arg_9_2)
	local function var_9_0(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = ccBlendFunc:new()

		var_10_0.src = arg_10_1
		var_10_0.dst = arg_10_2

		arg_10_0:setBlendFunc(var_10_0)
	end

	local var_9_1 = display.newColorLayer(ccc4(0, 0, 0, 0))
	local var_9_2
	local var_9_3 = display.newSprite("ui/common/mask.png")
	local var_9_4 = var_9_3:getContentSize()
	local var_9_5 = arg_9_2.width / var_9_4.width
	local var_9_6 = arg_9_2.height / var_9_4.height

	var_9_3:setScaleX(var_9_5 * Adapter.MinScale)
	var_9_3:setScaleY(var_9_6 * Adapter.MinScale)
	var_9_3:setPosition(arg_9_1)
	var_9_0(var_9_3, GL_ZERO, GL_ONE_MINUS_SRC_ALPHA)

	local var_9_7 = CCRenderTexture:create(display.width, display.height)

	arg_9_0:addChild(var_9_7)
	var_9_7:setPosition(display.cx, display.cy)
	var_9_7:begin()
	var_9_1:visit()
	var_9_3:visit()
	var_9_7:endToLua()
end

return var_0_0
