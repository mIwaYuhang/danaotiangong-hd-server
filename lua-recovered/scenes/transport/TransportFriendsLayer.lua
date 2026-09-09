local var_0_0 = class("TransportFriendsLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0._isRobFriends = arg_2_1._isRobFriends or false
	arg_2_0._callbackFunc = arg_2_1._callbackFunc or nil
	arg_2_0._friendList = {}
	arg_2_0._selectedFriendNum = 0
	arg_2_0._selectedFriends = {}
	arg_2_0._addPowerBonus = 0

	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0._bgSprite = display.newSprite("ui/transport/transport_021.png")

	if arg_2_0._isRobFriends == true then
		arg_2_0._bgSprite:setScale(Adapter.MinScale)
	end

	arg_2_0:addChild(arg_2_0._bgSprite)
	addLabelWithColorSize(arg_2_0._bgSprite, string.lf("请选择护卫的仙友"), ccc3(255, 191, 111), 30, ccp(0, 0.5), ccp(45, 465), _FONT_LISU)

	arg_2_0._tableView = arg_2_0:createUI()

	local function var_2_0()
		arg_2_0:removeFromParent()
	end

	local var_2_1 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		position = ccp(510, 460),
		clickAction = var_2_0
	})

	arg_2_0._bgSprite:addChild(var_2_1)

	local function var_2_2()
		if arg_2_0._callbackFunc ~= nil and type(arg_2_0._callbackFunc) == "function" then
			arg_2_0._callbackFunc(arg_2_0._selectedFriends, arg_2_0._addPowerBonus)
		end

		arg_2_0:removeFromParent()
	end

	local var_2_3 = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		text = string.lf("确定"),
		textColor = ColorTable.eTitleButton_Normal2,
		fontSize = ColorTable.eTitleButton_FontSize2,
		position = ccp(410, 30),
		clickAction = var_2_2
	})

	arg_2_0._bgSprite:addChild(var_2_3)
	var_2_3:setTouchPriority(-1)

	arg_2_0._powerBonus = addLabelWithColorSize(arg_2_0._bgSprite, string.lf("战力加成: 0%"), ccc3(240, 198, 39), 26, ccp(0, 0.5), ccp(16, 30))

	local function var_2_4(arg_6_0)
		arg_2_0._friendList = arg_6_0

		local function var_6_0(arg_7_0, arg_7_1)
			if arg_7_0.Power > arg_7_1.Power then
				return true
			elseif arg_7_0.Power < arg_7_1.Power then
				return false
			end

			return false
		end

		table.sort(arg_2_0._friendList, var_6_0)
		arg_2_0._tableView:reloadData()

		if #arg_2_0._friendList == 0 then
			addLabelWithColorSize(arg_2_0._bgSprite, string.lf("暂无仙友"), ccc3(139, 106, 58), 50, ccp(0.5, 0.5), ccp(270, 280), _FONT_LISU)
		end

		arg_2_0:refreshAddPower()
	end

	if arg_2_0._isRobFriends == true then
		TransportFriendsHelper:getTransportRobFriends(var_2_4)
	else
		TransportFriendsHelper:getTransportFriends(var_2_4)
	end
end

function var_0_0.createUI(arg_8_0)
	local var_8_0 = CCTableView:create(CCSize(583, 420))

	var_8_0:setAnchorPoint(CCPoint(0, 0))
	var_8_0:setPosition(21, 72)
	var_8_0:setViewSize(CCSize(500, 360))
	var_8_0:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_8_0:setDirection(kCCScrollViewDirectionVertical)
	arg_8_0._bgSprite:addChild(var_8_0)

	local function var_8_1(arg_9_0)
		local var_9_0 = arg_9_0

		if arg_8_0._friendList[var_9_0].isSelected == true then
			arg_8_0._friendList[var_9_0].isSelected = false
			arg_8_0._selectedFriendNum = arg_8_0._selectedFriendNum - 1
		else
			if arg_8_0._selectedFriendNum >= 3 then
				showFlashNotice(string.lf("最多可以选择3个玩家."))

				return
			end

			arg_8_0._friendList[var_9_0].isSelected = true
			arg_8_0._selectedFriendNum = arg_8_0._selectedFriendNum + 1
		end

		local var_9_1 = arg_8_0._tableView:getContentOffset()

		arg_8_0._tableView:reloadData()
		arg_8_0._tableView:setContentOffset(var_9_1)
		arg_8_0:refreshAddPower()
	end

	local function var_8_2(arg_10_0)
		return 60, 500
	end

	local function var_8_3(arg_11_0)
		return #arg_8_0._friendList
	end

	local function var_8_4(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_0:cellAtIndex(arg_12_1)
		local var_12_1 = arg_12_1 + 1

		if var_12_0 == nil then
			var_12_0 = CCTableViewCell:new()

			var_12_0:setTag(var_12_1)

			local var_12_2 = CCLayerColor:create()

			var_12_0:addChild(var_12_2)

			selectButton = ui.newControlButton({
				normalImage = "ui/transport/transport_020.png",
				position = ccp(250, 30),
				clickAction = function()
					var_8_1(arg_12_1 + 1)
				end
			})

			selectButton:setOpacity(0)
			var_12_2:addChild(selectButton)

			if arg_8_0._friendList[var_12_1].isSelected == true then
				local var_12_3 = display.newSprite("ui/transport/transport_020.png", 250, 30)

				var_12_2:addChild(var_12_3)
			end

			local var_12_4 = display.newSprite("ui/transport/transport_019.png", 250, 0)

			var_12_2:addChild(var_12_4)
			addLabelWithColorSize(var_12_2, "(" .. var_12_1 .. ")", ccc3(240, 198, 39), 22, ccp(0.5, 0.5), ccp(26, 30))
			addLabelWithColorSize(var_12_2, arg_8_0._friendList[var_12_1].Name, ccc3(255, 255, 255), 22, ccp(0, 0.5), ccp(70, 30))
			addLabelWithColorSize(var_12_2, string.lf("战力:"), ccc3(255, 255, 255), 22, ccp(0, 0.5), ccp(260, 30))
			addLabelWithColorSize(var_12_2, arg_8_0._friendList[var_12_1].Power, ccc3(240, 198, 39), 22, ccp(0, 0.5), ccp(325, 30))

			if arg_8_0._friendList[var_12_1].isSelected == true then
				local var_12_5 = display.newSprite("ui/common/common_029.png", 460, 30)

				var_12_2:addChild(var_12_5)
			end
		end

		return var_12_0
	end

	var_8_0:registerScriptHandler(var_8_2, CCTableView.kTableCellSizeForIndex)
	var_8_0:registerScriptHandler(var_8_3, CCTableView.kNumberOfCellsInTableView)
	var_8_0:registerScriptHandler(var_8_4, CCTableView.kTableCellSizeAtIndex)
	var_8_0:reloadData()

	return var_8_0
end

function var_0_0.refreshAddPower(arg_14_0)
	arg_14_0._addPowerBonus = 0
	arg_14_0._selectedFriends = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._friendList) do
		if iter_14_1.isSelected == true then
			arg_14_0._addPowerBonus = arg_14_0._addPowerBonus + getFriendAddPower(iter_14_1.Power, Player.team.battlePower)

			table.insert(arg_14_0._selectedFriends, iter_14_1.Id)
		end
	end

	local var_14_0 = string.lf("战力加成: %d%%", toint(arg_14_0._addPowerBonus))

	arg_14_0._powerBonus:setString(var_14_0)
end

return var_0_0
