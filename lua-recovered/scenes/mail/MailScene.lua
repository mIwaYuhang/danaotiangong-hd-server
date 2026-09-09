require("network.MailRequest")
require("base.functions")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("MailScene", function()
	return display.newScene("MailScene")
end)
local var_0_2 = {
	{
		y = 521,
		type = 0,
		x = 68,
		title = string.lf("全部")
	},
	{
		y = 521,
		type = 1,
		x = 175,
		title = string.lf("系统")
	},
	{
		y = 521,
		type = 2,
		x = 282,
		title = string.lf("战斗")
	},
	{
		y = 521,
		type = 3,
		x = 389,
		title = string.lf("好友")
	},
	{
		y = 521,
		type = 4,
		x = 496,
		title = string.lf("包裹")
	}
}
local var_0_3 = {
	{
		bgSprite = "ui/common/common_019.png",
		bgSelected = "ui/common/common_055.png",
		type = 7,
		y = 50,
		x = 117,
		title = string.lf("清空已读")
	},
	{
		bgSprite = "ui/common/common_019.png",
		bgSelected = "ui/common/common_055.png",
		type = 8,
		y = 50,
		x = 265,
		title = string.lf("全部清空")
	},
	{
		bgSprite = "ui/common/common_018.png",
		bgSelected = "ui/common/common_018.png",
		type = 9,
		y = 50,
		x = 533,
		title = string.lf("提建议!")
	}
}
local var_0_4 = {
	{
		y = 55,
		type = 10,
		x = 696,
		title = string.lf("回复")
	},
	{
		y = 45,
		type = 11,
		x = 779,
		title = string.lf("收附件")
	},
	{
		y = 55,
		type = 12,
		x = 862,
		title = string.lf("删除")
	},
	{
		y = 55,
		type = 13,
		x = 779,
		title = string.lf("确定")
	}
}

var_0_1.mailData = {}
var_0_1.mailContentData = {}
var_0_1.isAnyMoreMail = 0
var_0_1._contentLayer = nil
var_0_1._sendMailLabel = nil
var_0_1._sendMailNameLabel = nil
var_0_1._mailContentLabel = nil
var_0_1._mailContentTextfield = nil
var_0_1._currentMailType = 0
var_0_1._currentMailPage = 1
var_0_1._currentSelectMailIndex = 0
var_0_1._currentSelectMailID = 0
var_0_1._replayToPlayerID = 0
var_0_1._lastTableHeight = 0
var_0_1._lastTableOffset = 0

function var_0_1.ctor(arg_2_0)
	arg_2_0.mailRequest = MailRequest:new(arg_2_0)

	local function var_2_0()
		print("responseMailRequestSuccess")

		local var_3_0 = arg_2_0.mailRequest:getMailData()

		if var_3_0 ~= nil then
			if arg_2_0.isAnyMoreMail == 1 then
				for iter_3_0, iter_3_1 in ipairs(var_3_0.MailList) do
					table.insert(arg_2_0.mailData, iter_3_1)
				end
			else
				arg_2_0.mailData = var_3_0.MailList or {}
			end

			arg_2_0.isAnyMoreMail = var_3_0.isnext or 0
		else
			arg_2_0.mailData = {}
		end

		local var_3_1 = arg_2_0.tableView:getContentSize()
		local var_3_2 = 420 - arg_2_0._lastTableHeight

		arg_2_0.tableView:reloadData()

		if arg_2_0._lastTableHeight > 0 then
			if var_3_2 > 0 then
				arg_2_0.tableView:setContentOffset(CCPoint(0, -var_3_2))
			else
				local var_3_3 = arg_2_0.tableView:getContentSize()
				local var_3_4 = arg_2_0._lastTableHeight - var_3_3.height

				arg_2_0.tableView:setContentOffset(CCPoint(0, var_3_4))
			end
		end

		arg_2_0:showDefaultMailContent()
		arg_2_0:refreshTotalUnreadMailNum()
	end

	arg_2_0.mailRequest:setResponseNormalHandler(var_2_0)

	arg_2_0.mailInfoRequest = GetMailInfoRequest:new(arg_2_0)

	local function var_2_1()
		print("responseMailInfoRequestSuccess")

		local var_4_0 = arg_2_0.mailInfoRequest:getMailInfoData()

		if var_4_0 ~= nil then
			arg_2_0.mailContentData[var_4_0.PKID] = var_4_0

			arg_2_0:showMailDetail(var_4_0)

			if arg_2_0.mailData[arg_2_0._currentSelectMailIndex].HaveAccessory == 0 and arg_2_0.mailData[arg_2_0._currentSelectMailIndex].ReadingState == 0 then
				Player.mailCount = Player.mailCount - 1

				if Player.mailCount < 0 then
					Player.mailCount = 0
				end
			end

			arg_2_0.mailData[arg_2_0._currentSelectMailIndex].ReadingState = 1

			if arg_2_0.mailData[arg_2_0._currentSelectMailIndex].HaveAccessory == 0 then
				arg_2_0.mailData[arg_2_0._currentSelectMailIndex].IsDealWith = 1
			end

			arg_2_0.tableView:reloadData()
			arg_2_0.tableView:setContentOffset(CCPoint(0, arg_2_0._lastTableOffset))
			arg_2_0:refreshTotalUnreadMailNum()
		end
	end

	local function var_2_2(arg_5_0)
		print("responseMailInfoRequestFail")
	end

	arg_2_0.mailInfoRequest:setResponseNormalHandler(var_2_1)
	arg_2_0.mailInfoRequest:setResponseExceptionHandler(var_2_2)

	arg_2_0.deleteMailRequest = DeleteMailRequest:new(arg_2_0)

	local function var_2_3()
		print("responseDeleteMailRequestSuccess")

		if arg_2_0._currentSelectMailIndex ~= 0 then
			table.remove(arg_2_0.mailData, arg_2_0._currentSelectMailIndex)

			arg_2_0._currentSelectMailIndex = 0
		end

		arg_2_0.tableView:reloadData()

		arg_2_0._lastTableOffset = arg_2_0._lastTableOffset + 63

		arg_2_0.tableView:setContentOffset(CCPoint(0, arg_2_0._lastTableOffset))
		showFlashNotice(string.lf("邮件删除成功！"))
		arg_2_0:refreshTotalUnreadMailNum()
		arg_2_0:showDefaultMailContent()
	end

	local function var_2_4(arg_7_0)
		print("responseDeleteMailRequestFail")
	end

	arg_2_0.deleteMailRequest:setResponseNormalHandler(var_2_3)
	arg_2_0.deleteMailRequest:setResponseExceptionHandler(var_2_4)

	arg_2_0.deleteAllReadMailRequest = DeleteAllMailRequest:new(arg_2_0)

	local function var_2_5()
		print("responseDeleteAllReadMailRequestSuccess")

		arg_2_0.mailData = {}

		var_0_4[3].btn:setVisible(false)
		arg_2_0._mailContentLabel:setString("")
		arg_2_0._mailAttachmentNode:removeAllChildrenWithCleanup(true)
		arg_2_0.mailRequest:requestMailList(Player.userId, arg_2_0._currentMailPage, arg_2_0._currentMailType)
	end

	local function var_2_6(arg_9_0)
		print("responseDeleteAllReadMailRequestFail")
	end

	arg_2_0.deleteAllReadMailRequest:setResponseNormalHandler(var_2_5)
	arg_2_0.deleteAllReadMailRequest:setResponseExceptionHandler(var_2_6)

	arg_2_0.sendMailRequest = SendMailRequest:new(arg_2_0)

	local function var_2_7()
		ui.showMessageBox({
			text = string.lf("发送成功!正在火箭速度送达！")
		})
		arg_2_0:showDefaultMailContent()
		arg_2_0._mailContentTextfield:setVisible(false)
	end

	local function var_2_8()
		print("responseSendMailRequestFail")
	end

	arg_2_0.sendMailRequest:setResponseNormalHandler(var_2_7)
	arg_2_0.sendMailRequest:setResponseExceptionHandler(var_2_8)

	arg_2_0.getPlayerAccessoryRequest = GetPlayerAccessoryRequest:new(arg_2_0)

	local function var_2_9()
		print("responseGetPlayerAccessoryRequestSuccess")

		arg_2_0.mailData[arg_2_0._currentSelectMailIndex].IsDealWith = 1

		arg_2_0.tableView:reloadData()
		arg_2_0.tableView:setContentOffset(CCPoint(0, arg_2_0._lastTableOffset))

		local var_12_0 = arg_2_0.mailData[arg_2_0._currentSelectMailIndex].PKID

		arg_2_0.mailContentData[var_12_0].IsDealWith = 1
		arg_2_0.mailContentData[var_12_0].MailAccessory = nil

		arg_2_0:showMailDetail(arg_2_0.mailContentData[var_12_0])

		Player.mailCount = Player.mailCount - 1

		if Player.mailCount < 0 then
			Player.mailCount = 0
		end

		arg_2_0:refreshTotalUnreadMailNum()
	end

	local function var_2_10()
		print("responseGetPlayerAccessoryRequestFail")
	end

	arg_2_0.getPlayerAccessoryRequest:setResponseNormalHandler(var_2_9)
	arg_2_0.getPlayerAccessoryRequest:setResponseExceptionHandler(var_2_10)

	arg_2_0.addBugRequest = AddBugRequest:new(arg_2_0)

	local function var_2_11()
		ui.showMessageBox({
			text = string.lf("提交成功!")
		})
		arg_2_0:showDefaultMailContent()
		arg_2_0._mailContentTextfield:setVisible(false)

		arg_2_0.btnTag = 0
	end

	local function var_2_12(arg_15_0)
		var_0_4[4].btn:setEnabled(true)
	end

	arg_2_0.addBugRequest:setResponseNormalHandler(var_2_11)
	arg_2_0.addBugRequest:setResponseExceptionHandler(var_2_12)
	arg_2_0:InitUI()
	arg_2_0.mailRequest:requestMailList(Player.userId, arg_2_0._currentMailPage, arg_2_0._currentMailType)
end

function var_0_1.InitUI(arg_16_0)
	local var_16_0 = require("scenes.CommonBgLayer").new({
		titleSprite = "uilocal/mail/mail_txt_001.png"
	})

	arg_16_0:addChild(var_16_0)

	arg_16_0._bgSprite = var_16_0:getBackgroundSprite()

	addLabelWithColorSize(arg_16_0._bgSprite, string.lf("未读邮件"), ccc3(203, 160, 57), 25, ccp(1, 0.5), ccp(340, 605))

	local var_16_1 = display.newScale9Sprite("ui/common/bg_headtex_bg.png")

	var_16_1:setPreferredSize(CCSize(70, 30))
	var_16_1:setPosition(ccp(390, 605))
	arg_16_0._bgSprite:addChild(var_16_1)

	arg_16_0.unreadMailLabel = addLabelWithColorSize(var_16_1, Player.mailCount, ccc3(246, 231, 0), 26, ccp(0.5, 0.5), ccp(35, 15))

	local var_16_2 = createPlayerAttrNode({
		ItemType.eGold,
		ItemType.eCoin
	})

	var_16_2:setPosition(ccp(500, 578))
	arg_16_0._bgSprite:addChild(var_16_2)

	arg_16_0.tableView = arg_16_0:createMailTableView()

	local function var_16_3(arg_17_0, arg_17_1)
		local var_17_0 = tolua.cast(arg_17_1, "CCControlButton"):getTag()

		print("btnTag" .. var_17_0)

		arg_16_0.btnTag = var_17_0

		if var_17_0 >= 0 and var_17_0 <= 4 then
			arg_16_0:highlightTabButton(var_17_0)
			arg_16_0._mailContentTextfield:setVisible(false)

			if arg_16_0._currentMailType == var_17_0 then
				return
			end

			arg_16_0._currentMailType = var_17_0
			arg_16_0.isAnyMoreMail = 0
			arg_16_0._currentMailPage = 1

			arg_16_0.mailRequest:requestMailList(Player.userId, arg_16_0._currentMailPage, arg_16_0._currentMailType)
		end

		if var_17_0 == 7 then
			arg_16_0:clearMail(false)
		end

		if var_17_0 == 8 then
			arg_16_0:clearMail(true)
		end

		if var_17_0 == 9 then
			local var_17_1 = Player:getSystemMailName()

			arg_16_0._replayToPlayerID = 0

			arg_16_0:replayMail()
			arg_16_0._sendMailNameLabel:setString(string.lf("收件人:#FF0000%s", var_17_1))
			arg_16_0._mailContentLabel:setString("")
		end
	end

	for iter_16_0, iter_16_1 in ipairs(var_0_2) do
		local var_16_4 = CCScale9Sprite:create("ui/common/common_035.png")

		var_16_4:setPreferredSize(CCSize(116, 47))

		local var_16_5 = CCScale9Sprite:create("ui/common/common_034.png")

		var_16_5:setPreferredSize(CCSize(116, 47))

		local var_16_6 = CCControlButton:create(iter_16_1.title, _FONT_DEFAULT, Adapter.FontSize(24))

		var_16_6:setPosition(ccp(iter_16_1.x, iter_16_1.y))
		var_16_6:setAnchorPoint(ccp(0.5, 0))
		var_16_6:setTag(iter_16_1.type)
		var_16_6:setPreferredSize(CCSize(116, 47))
		var_16_6:setBackgroundSpriteForState(var_16_4, CCControlStateNormal)
		var_16_6:setBackgroundSpriteForState(var_16_5, CCControlStateHighlighted)
		var_16_6:addHandleOfControlEvent(var_16_3, CCControlEventTouchUpInside)
		arg_16_0._bgSprite:addChild(var_16_6)

		iter_16_1.btn = var_16_6
	end

	for iter_16_2, iter_16_3 in ipairs(var_0_3) do
		local var_16_7 = ui.newControlButton({
			normalImage = iter_16_3.bgSprite,
			highlightedImage = iter_16_3.bgSelected,
			text = iter_16_3.title,
			fontSize = ColorTable.eTitleButton_FontSize2,
			textColor = ColorTable.eTitleButton_Normal2,
			clickAction = var_16_3,
			position = ccp(iter_16_3.x, iter_16_3.y)
		})

		var_16_7:setTag(iter_16_3.type)
		arg_16_0._bgSprite:addChild(var_16_7)
	end

	arg_16_0._contentLayer = arg_16_0:createMailContentLayer()

	local function var_16_8(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == "began" then
			return arg_16_0:onTouchBegan(arg_18_1, arg_18_2)
		elseif arg_18_0 == "moved" then
			arg_16_0:onTouchMoved(arg_18_1, arg_18_2)
		elseif arg_18_0 == "ended" then
			arg_16_0:onTouchEnded(arg_18_1, arg_18_2)
		end
	end

	var_16_0:addTouchEventListener(var_16_8, false, -128, false)
	var_16_0:setTouchEnabled(true)
	arg_16_0:highlightTabButton(arg_16_0._currentMailType)
end

function var_0_1.onExit(arg_19_0)
	return
end

function var_0_1.createMailTableView(arg_20_0)
	local var_20_0 = CCScale9Sprite:create("ui/mail/mail_012.jpg")

	var_20_0:setPreferredSize(CCSize(602, 511))
	var_20_0:setPosition(308, 266)
	arg_20_0._bgSprite:addChild(var_20_0)

	local var_20_1 = CCTableView:create(CCSize(591, 420))

	var_20_1:setAnchorPoint(CCPoint(0, 0))
	var_20_1:setPosition(12, 85)
	var_20_1:setViewSize(CCSize(591, 434))
	var_20_1:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_20_1:setDirection(kCCScrollViewDirectionVertical)
	arg_20_0._bgSprite:addChild(var_20_1)

	local function var_20_2(arg_21_0)
		return 63, 591
	end

	local function var_20_3(arg_22_0)
		local var_22_0 = 0

		if arg_20_0.isAnyMoreMail == 1 then
			var_22_0 = #arg_20_0.mailData + 1
		else
			var_22_0 = #arg_20_0.mailData
		end

		return var_22_0
	end

	local function var_20_4(arg_23_0)
		local var_23_0 = arg_20_0.tableView:getContentOffset()

		arg_20_0._lastTableOffset = var_23_0.y

		local var_23_1 = arg_23_0

		arg_20_0._currentSelectMailID = arg_20_0.mailData[var_23_1].PKID
		arg_20_0._currentSelectMailIndex = var_23_1

		if arg_20_0.mailContentData[arg_20_0._currentSelectMailID] == nil then
			arg_20_0.mailInfoRequest:requestMailInfo(Player.userId, arg_20_0._currentSelectMailID)
		else
			arg_20_0:showMailDetail(arg_20_0.mailContentData[arg_20_0._currentSelectMailID])
		end

		var_20_1:reloadData()
		arg_20_0.tableView:setContentOffset(CCPoint(0, arg_20_0._lastTableOffset))
	end

	local function var_20_5(arg_24_0, arg_24_1)
		local var_24_0 = arg_24_0:cellAtIndex(arg_24_1)
		local var_24_1 = arg_24_1 + 1

		if var_24_0 == nil then
			var_24_0 = CCTableViewCell:new()

			local var_24_2 = CCLayerColor:create()

			var_24_0:addChild(var_24_2)

			if arg_24_1 < #arg_20_0.mailData then
				var_24_0:setTag(var_24_1)

				local var_24_3 = ""
				local var_24_4 = ""
				local var_24_5

				if arg_20_0.mailData[var_24_1].ReadingState == 0 or arg_20_0.mailData[var_24_1].IsDealWith == 0 then
					var_24_3 = "ui/mail/mail_013.png"
					var_24_5 = "ui/mail/mail_014.jpg"
				else
					var_24_3 = "ui/mail/mail_015.png"
					var_24_5 = "ui/mail/mail_019.jpg"
				end

				selectButton = ui.newControlButton({
					normalImage = var_24_5,
					position = ccp(296, 29.5),
					clickAction = function()
						var_20_4(arg_24_1 + 1)
					end
				})

				var_24_2:addChild(selectButton)

				local var_24_6 = CCSprite:create(var_24_3)

				var_24_6:setAnchorPoint(CCPoint(0, 0.5))
				var_24_6:setPosition(CCPoint(8, 30))
				var_24_2:addChild(var_24_6)

				if arg_20_0._currentSelectMailIndex - 1 == arg_24_1 then
					local var_24_7 = display.newSprite("ui/mail/mail_016.png", 0, 0)

					var_24_7:setAnchorPoint(CCPoint(0, 0))
					var_24_2:addChild(var_24_7)
				end

				if arg_20_0.mailData[var_24_1].HaveAccessory == 1 then
					local var_24_8 = CCSprite:create("ui/mail/mail_attachment.png")

					var_24_8:setAnchorPoint(CCPoint(0, 0.5))
					var_24_8:setPosition(CCPoint(29, 25))
					var_24_0:addChild(var_24_8)
				end

				local var_24_9 = CCLabelTTF:create(arg_20_0.mailData[var_24_1].MessageContent, _FONT_DEFAULT, Adapter.FontSize(22))

				var_24_9:setAnchorPoint(CCPoint(0, 0.5))
				var_24_9:setPosition(70, 25)
				var_24_2:addChild(var_24_9)

				local var_24_10 = CCLabelTTF:create(var_0_1:getMailSendTime(arg_20_0.mailData[var_24_1].SendTime), _FONT_DEFAULT, Adapter.FontSize(24))

				var_24_10:setAnchorPoint(CCPoint(1, 0.5))
				var_24_10:setPosition(560, 25)
				var_24_2:addChild(var_24_10)
			else
				local function var_24_11()
					print("onButtonMoreClicked")

					local var_26_0 = arg_20_0.tableView:getContentSize()

					arg_20_0._lastTableHeight = var_26_0.height
					arg_20_0._currentMailPage = arg_20_0._currentMailPage + 1

					arg_20_0.mailRequest:requestMailList(Player.userId, arg_20_0._currentMailPage, arg_20_0._currentMailType)
				end

				local var_24_12 = ui.newControlButton({
					fontSize = 28,
					normalImage = "ui/mail/mail_016.jpg",
					highlightedImage = "ui/mail/mail_016.jpg",
					text = string.lf("更多邮件"),
					textColor = ccc3(232, 230, 133),
					clickAction = var_24_11,
					position = CCPoint(292, 30)
				})
				local var_24_13 = display.newSprite("ui/mail/mail_020.png", 360, 30)

				var_24_12:addChild(var_24_13)
				var_24_2:addChild(var_24_12)
			end
		end

		return var_24_0
	end

	var_20_1:registerScriptHandler(var_20_2, CCTableView.kTableCellSizeForIndex)
	var_20_1:registerScriptHandler(var_20_3, CCTableView.kNumberOfCellsInTableView)
	var_20_1:registerScriptHandler(var_20_5, CCTableView.kTableCellSizeAtIndex)
	var_20_1:reloadData()

	return var_20_1
end

function var_0_1.createMailContentLayer(arg_27_0)
	local var_27_0 = CCLayer:create()

	arg_27_0._bgSprite:addChild(var_27_0)

	local var_27_1 = CCSprite:create("ui/mail/mail_018.jpg")

	var_27_1:setPosition(783, 544)
	var_27_0:addChild(var_27_1)

	local var_27_2 = CCSprite:create("ui/mail/mail_017.jpg")

	var_27_2:setPosition(783, 264)
	var_27_0:addChild(var_27_2)

	arg_27_0._sendMailNameLabel = ui.newTTFLabel({
		text = "",
		y = 20,
		x = 5,
		size = Adapter.FontSize(24),
		color = ccc3(0, 0, 0)
	})

	arg_27_0._sendMailNameLabel:setAnchorPoint(ccp(0, 0.5))
	var_27_1:addChild(arg_27_0._sendMailNameLabel)

	arg_27_0.mailContetnSize = CCSize(320, 340)
	arg_27_0.mailContentScrollView = CCScrollView:create(arg_27_0.mailContetnSize)

	arg_27_0.mailContentScrollView:setDirection(kCCScrollViewDirectionVertical)
	arg_27_0.mailContentScrollView:setPosition(ccp(12, 155))
	arg_27_0.mailContentScrollView:setContentSize(arg_27_0.mailContetnSize)
	var_27_2:addChild(arg_27_0.mailContentScrollView)

	arg_27_0._mailContentLabel = ui.newTTFLabel({
		text = "",
		y = 0,
		x = 0,
		size = Adapter.FontSize(24),
		color = ccc3(0, 0, 0),
		align = ui.TEXT_ALIGN_LEFT
	})

	arg_27_0._mailContentLabel:setAnchorPoint(ccp(0, 1))
	arg_27_0.mailContentScrollView:getContainer():addChild(arg_27_0._mailContentLabel)

	arg_27_0._mailContentTextfield = ui.newEditBox({
		image = "ui/account/input_bg.png",
		y = 305,
		multiLines = true,
		x = 783,
		size = CCSize(332, 420),
		fontSize = Adapter.FontSize(24)
	})

	arg_27_0._mailContentTextfield:setPlaceHolder(string.lf("请输入建议内容"))
	arg_27_0._mailContentTextfield:setAnchorPoint(ccp(0.5, 0.5))
	arg_27_0._mailContentTextfield:setVisible(false)
	var_27_0:addChild(arg_27_0._mailContentTextfield)

	arg_27_0._mailAttachmentNode = display.newNode()

	var_27_2:addChild(arg_27_0._mailAttachmentNode)

	local function var_27_3(arg_28_0, arg_28_1)
		local var_28_0 = tolua.cast(arg_28_1, "CCControlButton").tag

		if var_28_0 == 10 then
			print("回复按钮")
			arg_27_0:replayMail()
		end

		if var_28_0 == 11 then
			print("收包裹按钮")
			arg_27_0.getPlayerAccessoryRequest:requestMailAccessory(arg_27_0._currentSelectMailID)
		end

		if var_28_0 == 12 then
			print("删除按钮")
			arg_27_0.deleteMailRequest:requestDeleteMail(Player.userId, arg_27_0._currentSelectMailID)
		end

		if var_28_0 == 13 then
			var_0_4[4].btn:setEnabled(false)

			local var_28_1 = arg_27_0._mailContentTextfield:getText()

			if arg_27_0.btnTag == 9 then
				arg_27_0.addBugRequest:requestAddBug(var_28_1)
			else
				arg_27_0.sendMailRequest:sendMailToPlayer(Player.userId, arg_27_0._replayToPlayerID, var_28_1)
			end
		end
	end

	for iter_27_0, iter_27_1 in ipairs(var_0_4) do
		local var_27_4 = ui.newControlButton({
			normalImage = "ui/common/common_019.png",
			highlightedImage = "ui/common/common_019.png",
			text = iter_27_1.title,
			fontSize = ColorTable.eTitleButton_FontSize2,
			textColor = ColorTable.eTitleButton_Normal2,
			clickAction = var_27_3,
			position = CCPoint(iter_27_1.x, iter_27_1.y)
		})

		var_27_4.tag = iter_27_1.type

		arg_27_0._bgSprite:addChild(var_27_4)
		var_27_4:setVisible(false)

		iter_27_1.btn = var_27_4
	end

	return var_27_0
end

function var_0_1.highlightTabButton(arg_29_0, arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(var_0_2) do
		if iter_29_1.type == arg_29_1 then
			iter_29_1.btn:setHighlighted(true)
		else
			iter_29_1.btn:setHighlighted(false)
		end
	end
end

function var_0_1.clearMail(arg_30_0, arg_30_1)
	local var_30_0 = string.lf("是否清空")
	local var_30_1

	if arg_30_0._currentMailType ~= 0 then
		var_30_0 = var_30_0 .. "[" .. var_0_2[arg_30_0._currentMailType + 1].title .. "]"
	end

	if arg_30_1 == true then
		var_30_0 = var_30_0 .. string.lf("全部邮件")
	else
		var_30_0 = var_30_0 .. string.lf("已读邮件")
	end

	local var_30_2 = require("scenes.MessageBoxLayer").new()

	local function var_30_3()
		print("MailScene:clearAllMail")
		arg_30_0.deleteAllReadMailRequest:requestDeleteAllMail(Player.userId, arg_30_0._currentMailType, arg_30_1)
		var_30_2:removeFromParentAndCleanup()
	end

	var_30_2:setContentAndButtons(var_30_0, string.lf("确定"), var_30_3, string.lf("取消"))
	arg_30_0:addChild(var_30_2)
end

function var_0_1.getMailSendTime(arg_32_0, arg_32_1)
	local var_32_0, var_32_1, var_32_2, var_32_3 = getDateFromSeconds(arg_32_1)

	if var_32_0 > 0 then
		return string.lf("%s天前", tostring(var_32_0))
	end

	if var_32_1 > 0 then
		return string.lf("%s小时前", tostring(var_32_1))
	end

	if var_32_2 > 0 then
		return string.lf("%s分前", tostring(var_32_2))
	end

	if var_32_3 > 0 then
		return string.lf("%s秒前", tostring(var_32_3))
	end

	return string.lf("刚刚")
end

function var_0_1.showDefaultMailContent(arg_33_0)
	var_0_4[1].btn:setVisible(false)
	var_0_4[2].btn:setVisible(false)
	var_0_4[3].btn:setVisible(false)
	var_0_4[4].btn:setVisible(false)
	arg_33_0._sendMailNameLabel:setString(string.lf("发件人:"))
	arg_33_0._mailContentLabel:setString("")
	arg_33_0._mailAttachmentNode:removeAllChildrenWithCleanup(true)
end

function var_0_1.showMailDetail(arg_34_0, arg_34_1)
	arg_34_0.btnTag = 0

	if arg_34_1 == nil then
		return
	end

	arg_34_0._replayToPlayerID = arg_34_1.PlayerID

	local var_34_0

	if arg_34_1.MailType == 1 then
		local var_34_1 = Player:getSystemMailName()

		var_34_0 = string.lf("发件人: #FF0000%s", var_34_1)
	else
		var_34_0 = string.lf("发件人:%s", arg_34_1.NickName)
	end

	arg_34_0._sendMailNameLabel:setString(var_34_0)

	local var_34_2 = Platform.getStringDrawHeight({
		fontSize = 24,
		text = arg_34_1.MessageContent,
		fontName = _FONT_DEFAULT,
		width = arg_34_0.mailContetnSize.width - 10
	})

	arg_34_0._mailContentLabel:setString(arg_34_1.MessageContent)
	arg_34_0._mailContentLabel:setDimensions(Adapter.MinSize(arg_34_0.mailContetnSize.width - 10, var_34_2))
	arg_34_0._mailContentLabel:setHorizontalAlignment(kCCTextAlignmentLeft)

	if var_34_2 > arg_34_0.mailContetnSize.height then
		arg_34_0._mailContentLabel:setPosition(0, var_34_2)
		arg_34_0.mailContentScrollView:setContentSize(CCSize(arg_34_0.mailContetnSize.width, var_34_2))
		arg_34_0.mailContentScrollView:setContentOffset(ccp(0, arg_34_0.mailContetnSize.height - var_34_2))
	else
		arg_34_0._mailContentLabel:setPosition(0, arg_34_0.mailContetnSize.height)
		arg_34_0.mailContentScrollView:setContentOffset(ccp(0, 0))
	end

	arg_34_0._mailAttachmentNode:removeAllChildrenWithCleanup(true)

	local var_34_3 = 20

	if arg_34_1.MailAccessory ~= nil and arg_34_1.IsDealWith == 0 then
		if var_34_3 < #arg_34_1.MailAccessory then
			local var_34_4 = var_34_3
		end

		addLabelWithColorSize(arg_34_0._mailAttachmentNode, string.lf("附件:"), ccc3(0, 10, 0), 22, ccp(0, 0.5), ccp(10, 136))

		local var_34_5 = arg_34_0:showMailAttachment(arg_34_1.MailAccessory)

		arg_34_0._mailAttachmentNode:addChild(var_34_5)
	end

	if arg_34_1.IsDealWith == 0 and arg_34_1.MailAccessory ~= nil then
		var_0_4[1].btn:setVisible(false)
		var_0_4[2].btn:setVisible(true)
		var_0_4[3].btn:setVisible(false)
	else
		var_0_4[1].btn:setVisible(false)
		var_0_4[2].btn:setVisible(false)
		var_0_4[3].btn:setVisible(true)
		var_0_4[3].btn:setPosition(ccp(var_0_4[2].x, var_0_4[2].y))
	end

	if arg_34_1.MailType == 3 then
		var_0_4[1].btn:setVisible(true)
		var_0_4[2].btn:setVisible(false)
		var_0_4[3].btn:setVisible(true)
		var_0_4[1].btn:setPosition(ccp(var_0_4[1].x, var_0_4[1].y))
		var_0_4[3].btn:setPosition(ccp(var_0_4[3].x, var_0_4[3].y))
	end

	var_0_4[4].btn:setVisible(false)
	arg_34_0._mailContentTextfield:setVisible(false)
end

function var_0_1.showMailAttachment(arg_35_0, arg_35_1)
	local var_35_0 = CCSize(320, 130)
	local var_35_1 = CCTableView:create(var_35_0)

	var_35_1:setPosition(10, 30)
	var_35_1:setViewSize(var_35_0)
	var_35_1:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_35_1:setDirection(kCCScrollViewDirectionHorizontal)

	local function var_35_2(arg_36_0)
		return var_35_0.height, 60
	end

	local function var_35_3(arg_37_0)
		return #arg_35_1
	end

	local function var_35_4(arg_38_0, arg_38_1)
		local var_38_0 = arg_38_0:cellAtIndex(arg_38_1)
		local var_38_1 = arg_38_1 + 1

		if var_38_0 == nil then
			var_38_0 = CCTableViewCell:new()

			local var_38_2
			local var_38_3 = arg_35_1[var_38_1] or {}
			local var_38_4 = {
				type = var_38_3.Type,
				itemId = var_38_3.ID or 0,
				nameColor = ccc3(239, 232, 195),
				level = var_38_3.Level,
				count = var_38_3.Count,
				clickAction = function()
					if var_38_3.Type == ItemType.eMineral then
						require("scenes.mineral.MineralTipLayer").new({
							mineralId = var_38_3.ID,
							level = var_38_3.Level,
							node = var_38_2
						})
					else
						var_0_0.tipshandler(var_38_3)
					end
				end
			}

			var_38_2 = figure.createHeader(var_38_4)

			var_38_2:setScale(0.6)
			var_38_2:setAnchorPoint(CCPoint(0.5, 0.5))
			var_38_2:setPosition(30, var_35_0.height / 2)
			var_38_0:addChild(var_38_2)
		end

		return var_38_0
	end

	var_35_1:registerScriptHandler(var_35_2, CCTableView.kTableCellSizeForIndex)
	var_35_1:registerScriptHandler(var_35_3, CCTableView.kNumberOfCellsInTableView)
	var_35_1:registerScriptHandler(var_35_4, CCTableView.kTableCellSizeAtIndex)
	var_35_1:reloadData()

	return var_35_1
end

function var_0_1.replayMail(arg_40_0)
	arg_40_0:showDefaultMailContent()
	var_0_4[1].btn:setVisible(false)
	var_0_4[2].btn:setVisible(false)
	var_0_4[3].btn:setVisible(false)
	var_0_4[4].btn:setVisible(true)
	var_0_4[4].btn:setEnabled(true)
	arg_40_0._mailContentTextfield:setText("")
	arg_40_0._mailContentTextfield:setVisible(true)
end

function var_0_1.refreshTotalUnreadMailNum(arg_41_0)
	arg_41_0.unreadMailLabel:setString(Player.mailCount)
end

function var_0_1.onTouchBegan(arg_42_0, arg_42_1, arg_42_2)
	return CCRect(20, 103, 583, 420):containsPoint(CCPoint(arg_42_1, arg_42_2))
end

function var_0_1.onTouchMoved(arg_43_0, arg_43_1, arg_43_2)
	return
end

function var_0_1.onTouchEnded(arg_44_0, arg_44_1, arg_44_2)
	return
end

return var_0_1
