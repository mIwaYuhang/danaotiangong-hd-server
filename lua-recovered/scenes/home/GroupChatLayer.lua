local var_0_0 = class("GroupChatLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

ChatType = {
	ePlayer,
	eSystem
}

local var_0_1 = 20

function var_0_0.ctor(arg_2_0)
	return
end

function var_0_0.create(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.ViewSize = arg_3_1
	arg_3_0.FontSize = arg_3_2

	local function var_3_0(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == "began" then
			if CCRect(0, 0, arg_3_1.width + 50 * Adapter.MinScale, arg_3_1.height + 100 * Adapter.MinScale):containsPoint(CCPoint(arg_4_1, arg_4_2)) then
				return true
			end

			return false
		end
	end

	arg_3_0:addTouchEventListener(var_3_0, false, 1, true)
	arg_3_0:setTouchEnabled(true)

	local var_3_1 = CCScale9Sprite:create("ui/bag/bg_change.png")

	var_3_1:setPreferredSize(CCSize(arg_3_1.width + 50 * Adapter.MinScale, arg_3_1.height + 100 * Adapter.MinScale))
	var_3_1:setAnchorPoint(CCPoint(0, 0))
	var_3_1:setPosition(CCPoint(-25 * Adapter.MinScale, -80 * Adapter.MinScale))
	var_3_1:setOpacity(128)
	arg_3_0:addChild(var_3_1)

	arg_3_0.scrollView = arg_3_0:chatScrollView()

	local var_3_2 = ui.newEditBox({
		image = "ui/account/input_bg.png",
		size = CCSize(arg_3_1.width - 80 * Adapter.MinScale, 60 * Adapter.MinScale),
		x = arg_3_1.width / 2 + 60 * Adapter.MinScale,
		y = -35 * Adapter.MinScale
	})

	var_3_2:setPlaceHolder("")
	var_3_2:setInputMode(kEditBoxInputModeEmailAddr)
	arg_3_0:addChild(var_3_2)

	local var_3_3 = ui.newControlButton({
		fontSize = 20,
		normalImage = "ui/account/btn_001.png",
		highlightedImage = "ui/account/btn_002.png",
		text = string.lf("发送"),
		clickAction = function(arg_5_0, arg_5_1)
			arg_3_0:sendChat(var_3_2:getText())
			var_3_2:setText("")
		end,
		scaleX = 0.7 * Adapter.MinScale,
		scaleY = 0.7 * Adapter.MinScale,
		position = CCPoint(40 * Adapter.MinScale, -35 * Adapter.MinScale)
	})

	arg_3_0:addChild(var_3_3)

	local var_3_4

	var_3_4 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		highlightedImage = "ui/common/btn_closed.png",
		clickAction = function(arg_6_0, arg_6_1)
			local var_6_0, var_6_1 = arg_3_0:getPosition()

			arg_3_0:runAction(CCMoveTo:create(0.3, CCPoint(-600, -400)))

			local var_6_2 = CCArray:create()

			var_6_2:addObject(CCScaleTo:create(0.3, 0.1))
			var_6_2:addObject(CCCallFunc:create(function()
				arg_3_0:clear({
					var_3_1,
					var_3_2,
					var_3_3,
					var_3_4
				})
				arg_3_0:setScale(1)
				arg_3_0:setPosition(var_6_0, var_6_1)
				arg_3_0.showBtn:runAction(CCFadeIn:create(0.3))
				arg_3_0.showBtn:setTouchEnabled(true)
				arg_3_0.bg_sprite:runAction(CCFadeIn:create(0.3))
				arg_3_0:refreshSmallLabel()
			end))
			arg_3_0:runAction(CCSequence:create(var_6_2))
		end,
		position = CCPoint(arg_3_1.width - 20 * Adapter.MinScale, arg_3_1.height - 20 * Adapter.MinScale)
	})

	if arg_3_0.chatTable then
		arg_3_0:refreshScrollView()
		arg_3_0:updateProgerssSize()
	end

	arg_3_0:addChild(var_3_4)
end

function var_0_0.chatScrollView(arg_8_0)
	local var_8_0 = CCScrollView:create(arg_8_0.ViewSize)

	var_8_0:setPosition(0, 0)
	var_8_0:setDirection(kCCScrollViewDirectionVertical)
	arg_8_0:addChild(var_8_0)

	return var_8_0
end

function var_0_0.refreshScrollView(arg_9_0)
	if arg_9_0.chatTable then
		if #arg_9_0.chatTable > var_0_1 then
			for iter_9_0 = 1, #arg_9_0.chatTable - var_0_1 do
				if arg_9_0.chatTable[#arg_9_0.chatTable].label then
					arg_9_0.chatTable[#arg_9_0.chatTable].label:removeFromParentAndCleanup(true)
				end

				table.remove(arg_9_0.chatTable, #arg_9_0.chatTable)
			end
		end

		local var_9_0 = 0
		local var_9_1 = 0

		for iter_9_1, iter_9_2 in pairs(arg_9_0.chatTable) do
			if iter_9_2.label then
				iter_9_2.label:setPosition(var_9_0, var_9_1)

				var_9_1 = var_9_1 + iter_9_2.label:getTextureRect().size.height
			else
				arg_9_0:createSingleChat(arg_9_0.scrollView, iter_9_2, arg_9_0.ViewSize.width):setPosition(var_9_0, var_9_1)

				var_9_1 = var_9_1 + iter_9_2.label:getTextureRect().size.height
			end
		end

		arg_9_0.scrollView:setContentSize(CCSize(arg_9_0.ViewSize.width, var_9_1))

		if var_9_1 >= arg_9_0.ViewSize.height then
			arg_9_0.scrollView:setContentOffset(arg_9_0.scrollView:maxContainerOffset())
		else
			arg_9_0.scrollView:setContentOffset(arg_9_0.scrollView:minContainerOffset())
		end
	end
end

function var_0_0.convertChat(arg_10_0, arg_10_1)
	local var_10_0 = ""

	if arg_10_1.chatType == ChatType.ePlayer then
		var_10_0 = var_10_0.lf("[玩家]")
	elseif arg_10_1.chatType == ChatType.eSystem then
		var_10_0 = var_10_0.lf("[系统]")
	end

	return (var_10_0 .. "[" .. arg_10_1.ChatName .. "]") .. ":" .. arg_10_1.ChatContent
end

function var_0_0.createSingleChat(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0:convertChat(arg_11_2)
	local var_11_1 = CCLabelTTF:create(var_11_0, _FONT_DEFAULT, Adapter.FontSize(arg_11_0.FontSize), CCSize(arg_11_3, 0), kCCTextAlignmentLeft)

	var_11_1:enableShadow(CCSize(10, 10), 128, 1)
	arg_11_1:addChild(var_11_1)

	arg_11_2.label = var_11_1

	return var_11_1
end

function var_0_0.pushChat(arg_12_0, arg_12_1)
	if not arg_12_0.chatTable then
		arg_12_0.chatTable = {}
	end

	table.insert(arg_12_0.chatTable, 1, arg_12_1)
	arg_12_0:refreshScrollView()
	arg_12_0:updateProgerssSize()
end

function var_0_0.clear(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in pairs(arg_13_1) do
		iter_13_1:removeFromParentAndCleanup(true)
	end

	if arg_13_0.progress then
		arg_13_0.progress:removeFromParentAndCleanup(true)

		arg_13_0.progress = nil
	end

	if arg_13_0.chatTable then
		for iter_13_2, iter_13_3 in pairs(arg_13_0.chatTable) do
			iter_13_3.label = nil
		end
	end

	arg_13_0.scrollView:removeFromParentAndCleanup(true)
	arg_13_0:removeTouchEventListener()
	arg_13_0:setTouchEnabled(false)
end

function var_0_0.sendChat(arg_14_0, arg_14_1)
	local var_14_0 = {
		ChatPlayerId = 132,
		ChatType = ChatType.ePlayer,
		ChatName = Player.nickName,
		ChatContent = arg_14_1
	}

	arg_14_0:pushChat(var_14_0)
end

local var_0_2 = 0.1

function var_0_0.createProgress(arg_15_0)
	local var_15_0 = CCScale9Sprite:create("ui/home/bg_exp.png")

	var_15_0:setPreferredSize(CCSize(10 * Adapter.MinScale, arg_15_0.ViewSize.height))
	var_15_0:setAnchorPoint(CCPoint(0, 0))
	var_15_0:setPosition(CCPoint(arg_15_0.ViewSize.width, 0))
	arg_15_0:addChild(var_15_0)

	arg_15_0.progress = var_15_0

	arg_15_0.scrollView:registerScriptScrollViewHandler(handler(arg_15_0, arg_15_0.updater))
end

function var_0_0.updater(arg_16_0)
	local var_16_0 = arg_16_0.scrollView:getContentOffset()
	local var_16_1 = arg_16_0.scrollView:getContentSize()
	local var_16_2 = -var_16_0.y / (var_16_1.height - arg_16_0.ViewSize.height)
	local var_16_3 = 0
	local var_16_4 = arg_16_0.ViewSize.height - arg_16_0.progress.height

	var_16_2 = var_16_2 > 1 and 1 or var_16_2
	var_16_2 = var_16_2 < 0 and 0 or var_16_2

	arg_16_0.progress:setPosition(arg_16_0.ViewSize.width, (var_16_4 - var_16_3) * var_16_2 + var_16_3)
end

function var_0_0.updateProgerssSize(arg_17_0)
	local var_17_0 = arg_17_0.scrollView:getContentSize()

	if var_17_0.height > arg_17_0.ViewSize.height then
		if not arg_17_0.progress then
			arg_17_0:createProgress()
		end
	else
		return
	end

	local var_17_1 = arg_17_0.ViewSize.height / var_17_0.height
	local var_17_2 = (var_17_1 > var_0_2 and var_17_1 or var_0_2) * arg_17_0.ViewSize.height

	arg_17_0.progress:setPreferredSize(CCSize(10 * Adapter.MinScale, var_17_2))

	arg_17_0.progress.height = var_17_2
end

function var_0_0.small(arg_18_0)
	arg_18_0.showBtn = ui.newControlButton({
		highlightedImage = "ui/mail/mail_006.png",
		normalImage = "ui/mail/mail_006.png",
		clickAction = function(arg_19_0, arg_19_1)
			arg_18_0:create(Adapter.MinSize(600, 400), 30)
			arg_18_0:setScale(0.1)
			arg_18_0:runAction(CCScaleTo:create(0.3, 1))

			local var_19_0, var_19_1 = arg_18_0:getPosition()

			arg_18_0:setPosition(-600, -400)
			arg_18_0:runAction(CCMoveTo:create(0.3, CCPoint(var_19_0, var_19_1)))
			arg_18_0.showBtn:setTouchEnabled(false)
			arg_18_0.showBtn:runAction(CCFadeOut:create(0.3))
			arg_18_0.bg_sprite:runAction(CCFadeOut:create(0.3))
		end,
		scaleX = 2 * Adapter.MinScale,
		scaleY = 2 * Adapter.MinScale,
		position = CCPoint(0, -20)
	})

	arg_18_0:addChild(arg_18_0.showBtn)

	local var_18_0 = CCSprite:create("ui/home/bg_home_name.png")

	var_18_0:setScaleX(Adapter.MinScale)
	var_18_0:setScaleY(3 * Adapter.MinScale)
	var_18_0:setPosition(100, -20)
	arg_18_0:addChild(var_18_0)

	arg_18_0.bg_sprite = var_18_0

	arg_18_0:refreshSmallLabel()
end

function var_0_0.refreshSmallLabel(arg_20_0)
	if not arg_20_0.slabel then
		arg_20_0.slabel = {}

		for iter_20_0 = 1, 3 do
			arg_20_0.slabel[iter_20_0] = CCLabelTTF:create("", _FONT_DEFAULT, Adapter.FontSize(20), CCSize(300, 0), kCCTextAlignmentLeft)

			arg_20_0.slabel[iter_20_0]:setPosition(150, iter_20_0 * 20 - 55)
			arg_20_0:addChild(arg_20_0.slabel[iter_20_0])
		end
	end

	local var_20_0 = {
		"",
		"",
		""
	}

	if arg_20_0.chatTable then
		if #arg_20_0.chatTable >= 3 then
			var_20_0[3] = arg_20_0:convertChat(arg_20_0.chatTable[3])
			var_20_0[2] = arg_20_0:convertChat(arg_20_0.chatTable[2])
			var_20_0[1] = arg_20_0:convertChat(arg_20_0.chatTable[1])
		elseif #arg_20_0.chatTable == 2 then
			var_20_0[3] = arg_20_0:convertChat(arg_20_0.chatTable[2])
			var_20_0[2] = arg_20_0:convertChat(arg_20_0.chatTable[1])
		elseif #arg_20_0.chatTable == 1 then
			var_20_0[3] = arg_20_0:convertChat(arg_20_0.chatTable[1])
		end

		for iter_20_1 = 1, 3 do
			if string.len(var_20_0[iter_20_1]) > 30 then
				var_20_0[iter_20_1] = string.sub(var_20_0[iter_20_1], 1, 30) .. "..."
			end

			arg_20_0.slabel[iter_20_1]:setString(var_20_0[iter_20_1])
		end
	end
end

return var_0_0
