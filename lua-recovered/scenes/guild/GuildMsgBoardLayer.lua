local var_0_0 = require("framework.scheduler")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = class("GuildMsgBoardLayer", function()
	return display.newColorLayer(ccc4(0, 0, 0, 180))
end)

function var_0_2.ctor(arg_2_0)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.mCellInfo = {}

	local var_2_0 = "ui/guild/guild_086.png"
	local var_2_1 = arg_2_0:getImageSize(var_2_0)

	arg_2_0.mMsgItemWidth = var_2_1.width
	arg_2_0.mMsgItemHeight = var_2_1.height
	arg_2_0.mSingalHeight = var_0_1.newLabel({
		text = "1",
		size = 20,
		color = ccc3(255, 255, 255),
		dimensions = CCSize(arg_2_0.mMsgItemWidth * 0.8, 0)
	}):getContentSize().height

	local var_2_2

	arg_2_0:setUI()

	arg_2_0.mMsgInfo = {}

	arg_2_0:requestMsg()
end

function var_0_2.setUI(arg_4_0)
	local var_4_0 = "ui/guild/guild_085.png"
	local var_4_1 = CCTextureCache:sharedTextureCache():addImage(var_4_0):getContentSizeInPixels()
	local var_4_2 = display.newSprite(var_4_0, display.cx, display.cy)

	var_4_2:setScale(Adapter.MinScale)
	arg_4_0:addChild(var_4_2)

	arg_4_0.mBgSize = var_4_1
	arg_4_0.mBgSprite = var_4_2
	arg_4_0.mMsgTableView = arg_4_0:createMsgTaleView()

	arg_4_0.mMsgTableView:setAnchorPoint(ccp(0, 0))
	arg_4_0.mMsgTableView:setPosition(5, 65)
	var_4_2:addChild(arg_4_0.mMsgTableView)

	arg_4_0.mSpriteNull = display.newSprite("uilocal/guild/guild_text_039.png", var_4_1.width / 2, var_4_1.height - 100)

	var_4_2:addChild(arg_4_0.mSpriteNull)

	local var_4_3 = ui.newControlButton({
		normalImage = "ui/common/common_125.png",
		text = string.lf("留言"),
		position = ccp(var_4_1.width - 50, 30),
		clickAction = handler(arg_4_0, arg_4_0.onBtnSendMsgClicekd)
	})

	var_4_2:addChild(var_4_3)

	local var_4_4 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		position = ccp(var_4_1.width, var_4_1.height - 10),
		clickAction = function()
			arg_4_0:killTimer()
			arg_4_0:removeFromParentAndCleanup(true)
		end
	})

	var_4_2:addChild(var_4_4)

	local function var_4_5(arg_6_0, arg_6_1)
		if arg_6_0 == "began" then
			-- block empty
		elseif arg_6_0 == "changed" then
			-- block empty
		elseif arg_6_0 == "ended" then
			-- block empty
		elseif arg_6_0 == "return" then
			-- block empty
		end
	end

	local var_4_6 = arg_4_0:getImageSize("ui/guild/guild_088.png")
	local var_4_7 = ui.newEditBox({
		image = "ui/guild/guild_088.png",
		y = 10,
		fontSize = 22,
		x = 10,
		multiLines = true,
		listener = var_4_5,
		size = var_4_6,
		fontColor = ccc3(0, 0, 0)
	})

	var_4_7:setAnchorPoint(ccp(0, 0))
	var_4_2:addChild(var_4_7)

	arg_4_0.mMsgEditBox = var_4_7
end

function var_0_2.createMsgTaleView(arg_7_0)
	arg_7_0.mMsgItemContainer = var_0_1.newNode()

	arg_7_0.mMsgItemContainer:setContentSize(CCSizeMake(arg_7_0.mMsgItemWidth, arg_7_0.mBgSize.height - 80))
	arg_7_0.mMsgItemContainer:setAnchorPoint(ccp(0, 0))

	local var_7_0 = CCScrollView:create(CCSizeMake(arg_7_0.mMsgItemWidth, arg_7_0.mBgSize.height - 80), arg_7_0.mMsgItemContainer)

	var_7_0:setDirection(kCCScrollViewDirectionVertical)

	return var_7_0
end

function var_0_2.reloadData(arg_8_0)
	local function var_8_0(arg_9_0)
		local var_9_0 = 0

		for iter_9_0, iter_9_1 in ipairs(arg_9_0) do
			iter_9_1:setPosition(0, var_9_0)

			var_9_0 = var_9_0 + iter_9_1:getContentSize().height + 10
		end

		return var_9_0
	end

	local var_8_1 = arg_8_0:getMsgItemNodes()
	local var_8_2 = var_8_0(var_8_1)

	if var_8_2 == 0 then
		arg_8_0.mSpriteNull:setVisible(true)
	else
		arg_8_0.mSpriteNull:setVisible(false)
	end

	arg_8_0.mMsgItemContainer:setContentSize(CCSizeMake(arg_8_0.mMsgItemWidth, var_8_2))

	local var_8_3 = arg_8_0.mBgSize.height - 80 - var_8_2

	if var_8_3 < 0 then
		var_8_3 = 0
	end

	arg_8_0.mMsgTableView:setContentOffset(ccp(0, var_8_3))
end

function var_0_2.getMsgItemNodes(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.mMsgInfo) do
		if tolua.isnull(arg_10_0.mMsgInfo[iter_10_0].item) then
			arg_10_0.mMsgInfo[iter_10_0].item = arg_10_0:createMsgItem(iter_10_1, iter_10_0)

			arg_10_0.mMsgItemContainer:addChild(arg_10_0.mMsgInfo[iter_10_0].item)
		end

		var_10_0[iter_10_0] = arg_10_0.mMsgInfo[iter_10_0].item
	end

	return var_10_0
end

function var_0_2.createMsgItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = display.newNode()
	local var_11_1 = var_0_1.newLabel({
		size = 20,
		text = crypto.decodeBase64(arg_11_1.Content),
		color = ccc3(255, 255, 255),
		dimensions = CCSize(arg_11_0.mMsgItemWidth * 0.8, 0)
	})

	var_11_1:setVerticalAlignment(kCCVerticalTextAlignmentTop)

	local var_11_2 = var_11_1:getContentSize().height + 45
	local var_11_3 = CCSizeMake(arg_11_0.mMsgItemWidth, var_11_2)

	var_11_0:setContentSize(var_11_3)

	if arg_11_1.IfOneself == true then
		local var_11_4 = display.newScale9Sprite("ui/guild/guild_086.png", var_11_3.width - arg_11_0.mMsgItemWidth * 0.85, 0)

		var_11_4:setAnchorPoint(ccp(0, 0))
		var_11_4:setScaleX(0.85)
		var_11_4:setScaleY(var_11_3.height / arg_11_0.mMsgItemHeight)
		var_11_0:addChild(var_11_4)
		addLabelWithColorSize(var_11_0, string.lf("#FFFFFF[%s]#FFE400我#FFFFFF说:", arg_11_1.SendTime), ccc3(255, 255, 0), 20, ccp(1, 1), ccp(var_11_3.width - 15, var_11_3.height - 5))

		if var_11_3.height - 45 > arg_11_0.mSingalHeight then
			var_11_1:setHorizontalAlignment(kCCTextAlignmentLeft)
		else
			var_11_1:setHorizontalAlignment(kCCTextAlignmentRight)
		end

		var_11_1:setAnchorPoint(ccp(1, 1))
		var_11_1:setPosition(var_11_3.width - 15, var_11_3.height - 35)
	else
		local var_11_5 = display.newSprite("ui/guild/guild_087.png", 0, 0)

		var_11_5:setScaleX(0.85)
		var_11_5:setScaleY(var_11_3.height / arg_11_0.mMsgItemHeight)
		var_11_5:setAnchorPoint(ccp(0, 0))
		var_11_0:addChild(var_11_5)
		addLabelWithColorSize(var_11_0, string.lf("#FFFFFF[%s]#FFE400%s#FFFFFF说:", arg_11_1.SendTime, arg_11_1.PlayerName), ccc3(255, 255, 0), 20, ccp(0, 1), ccp(15, var_11_3.height - 5))
		var_11_1:setHorizontalAlignment(kCCTextAlignmentLeft)
		var_11_1:setAnchorPoint(ccp(0, 1))
		var_11_1:setPosition(15, var_11_3.height - 35)
	end

	var_11_0:addChild(var_11_1)
	var_11_0:setAnchorPoint(ccp(0, 0))
	var_11_0:setPosition(0, var_11_3.height)

	return var_11_0
end

function var_0_2.getImageSize(arg_12_0, arg_12_1)
	return CCTextureCache:sharedTextureCache():addImage(arg_12_1):getContentSizeInPixels()
end

function var_0_2.setTimer(arg_13_0)
	if not arg_13_0.mTimerRefreshMsg then
		arg_13_0.mTimerRefreshMsg = var_0_0.scheduleGlobal(function()
			arg_13_0:requestMsg()
		end, 60)
	end
end

function var_0_2.killTimer(arg_15_0)
	if arg_15_0.mTimerRefreshMsg then
		var_0_0.unscheduleGlobal(arg_15_0.mTimerRefreshMsg)
	end
end

function var_0_2.onBtnSendMsgClicekd(arg_16_0)
	local var_16_0 = arg_16_0.mMsgEditBox:getText()
	local var_16_1 = string.trim(var_16_0)
	local var_16_2 = string.asciilen(var_16_1)

	if var_16_2 < 1 then
		showFlashNotice(string.lf("请输入留言"))
	elseif var_16_2 > 200 then
		showFlashNotice(string.lf("超出长度限制(限100字)"))
	else
		arg_16_0:requestSendMsg(var_16_1)
	end
end

function var_0_2.requestMsg(arg_17_0)
	if not arg_17_0.mMsgRequest then
		arg_17_0.mMsgRequest = GetGuildMsgBoardRequest:new()

		arg_17_0.mMsgRequest:setResponseNormalHandler(function()
			if arg_17_0.mMsgInfo then
				for iter_18_0, iter_18_1 in ipairs(arg_17_0.mMsgInfo) do
					if not tolua.isnull(iter_18_1.item) then
						iter_18_1.item:removeFromParent()
					end
				end
			end

			arg_17_0.mMsgInfo = arg_17_0.mMsgRequest.restable

			if not arg_17_0.mMsgInfo then
				ui.showMessageBox({
					text = string.lf("获取留言板内容出错")
				})
			end

			arg_17_0:setTimer()
			arg_17_0:reloadData()
		end)
	end

	arg_17_0.mMsgRequest:request()
end

function var_0_2.requestSendMsg(arg_19_0, arg_19_1)
	arg_19_0.mTmpSendMsg = arg_19_1

	if not arg_19_0.mSendMsgRequest then
		arg_19_0.mSendMsgRequest = SendGuildMsgBoardRequest:new()

		arg_19_0.mSendMsgRequest:setResponseNormalHandler(function()
			table.insert(arg_19_0.mMsgInfo, 1, arg_19_0.mSendMsgRequest.restable)
			arg_19_0.mMsgEditBox:setText("")
			arg_19_0:reloadData()
		end)
	end

	arg_19_0.mSendMsgRequest:request(arg_19_1)
end

return var_0_2
