require("base.figure")

local var_0_0 = class("SlaveRescueLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	local var_2_0 = display.newScale9Sprite("ui/common/common_040.png")

	arg_2_0.bgSize = CCSize(850, 500)

	var_2_0:setPreferredSize(arg_2_0.bgSize)
	var_2_0:setScale(Adapter.MinScale)
	var_2_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_0:setPosition(CCPoint(display.cx, display.cy))
	arg_2_0:addChild(var_2_0)

	arg_2_0.background = CCLayerColor:create(ccc4(0, 0, 0, 0))

	arg_2_0.background:setContentSize(arg_2_0.bgSize)
	var_2_0:addChild(arg_2_0.background)

	local var_2_1 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		highlightedImage = "ui/common/btn_closed.png",
		position = CCPoint(arg_2_0.bgSize.width - 15, arg_2_0.bgSize.height - 15),
		clickAction = function()
			arg_2_0:removeFromParentAndCleanup(true)
		end
	})

	var_2_0:addChild(var_2_1)
	arg_2_0:initRequests()
	arg_2_0.friendListRequest:request()
end

function var_0_0.initRequests(arg_5_0)
	local function var_5_0()
		local var_6_0 = arg_5_0.friendListRequest.restable

		arg_5_0.remainSaveTime = var_6_0.remainSaveTime
		arg_5_0.friendList = var_6_0.friends

		addLabelWithColorSize(arg_5_0.background, string.lf("您的剩余解救次数：%s", arg_5_0.remainSaveTime), ccc3(255, 255, 0), 20, CCPoint(0.5, 0.5), CCPoint(arg_5_0.bgSize.width / 2, arg_5_0.bgSize.height - 30))

		if table.nums(arg_5_0.friendList) == 0 then
			showFlashNotice(string.lf("暂时没有好友被俘虏"))
		else
			arg_5_0:showAllFriends()
		end
	end

	arg_5_0.friendListRequest = SlaveFriendListRequest:new()

	arg_5_0.friendListRequest:setResponseNormalHandler(var_5_0)
end

function var_0_0.showAllFriends(arg_7_0)
	addLabelWithColorSize(arg_7_0.background, string.lf("被捕好友"), ccc3(238, 246, 49), 25, CCPoint(0.5, 1), CCPoint(arg_7_0.bgSize.width / 2 - 160, arg_7_0.bgSize.height - 55))
	addLabelWithColorSize(arg_7_0.background, string.lf("好友主人"), ccc3(238, 246, 49), 25, CCPoint(0.5, 1), CCPoint(arg_7_0.bgSize.width / 2 + 160, arg_7_0.bgSize.height - 55))

	local function var_7_0(arg_8_0)
		return 120, 800
	end

	local function var_7_1(arg_9_0)
		return table.nums(arg_7_0.friendList)
	end

	local function var_7_2(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0:cellAtIndex(arg_10_1)
		local var_10_1 = arg_7_0.friendList[arg_10_1 + 1]

		if var_10_0 == nil then
			var_10_0 = CCTableViewCell:new()

			local var_10_2 = display.newSprite("ui/slave/slave_009.png")

			var_10_2:setAnchorPoint(CCPoint(0.5, 0.5))
			var_10_2:setPosition(CCPoint(400, 60))
			var_10_0:addChild(var_10_2)

			local var_10_3 = figure.createHeader({
				isName = false,
				count = 0,
				inTeam = false,
				itemId = var_10_1.friendAvatar,
				type = ItemType.eHero
			})

			var_10_3:setAnchorPoint(CCPoint(0.5, 0.5))
			var_10_3:setPosition(80, 70)
			var_10_0:addChild(var_10_3)

			local var_10_4 = figure.createHeader({
				isName = false,
				count = 0,
				inTeam = false,
				itemId = var_10_1.masterAvatar,
				type = ItemType.eHero
			})

			var_10_4:setAnchorPoint(CCPoint(0.5, 0.5))
			var_10_4:setPosition(420, 70)
			var_10_0:addChild(var_10_4)
			addLabelWithColorSize(var_10_0, string.lf("%s(%s级)", var_10_1.friendName, var_10_1.friendLevel), ccc3(0, 0, 0), 20, CCPoint(0, 0.5), CCPoint(130, 90))
			addLabelWithColorSize(var_10_0, string.lf("%s(%s级)", var_10_1.masterName, var_10_1.masterLevel), ccc3(0, 0, 0), 20, CCPoint(0, 0.5), CCPoint(470, 90))
			addLabelWithColorSize(var_10_0, string.lf("战力：%s", var_10_1.friendTotal), ccc3(0, 0, 0), 20, CCPoint(0, 0.5), CCPoint(130, 50))
			addLabelWithColorSize(var_10_0, string.lf("战力：%s", var_10_1.masterTotal), ccc3(0, 0, 0), 20, CCPoint(0, 0.5), CCPoint(470, 50))

			local var_10_5 = 270

			addLabelWithColorSize(var_10_0, string.lf("解救成功后奖励 "), ccc3(0, 0, 0), 20, CCPoint(1, 0), CCPoint(var_10_5, 5))
			addLabelWithColorSize(var_10_0, string.lf("阅历"), ccc3(255, 0, 0), 20, CCPoint(1, 0), CCPoint(var_10_5 + 50, 5))
			addLabelWithColorSize(var_10_0, var_10_1.knowledge, ccc3(0, 0, 255), 20, CCPoint(0, 0), CCPoint(var_10_5 + 90, 5))
			addLabelWithColorSize(var_10_0, string.lf("培养丹"), ccc3(255, 0, 0), 20, CCPoint(1, 0), CCPoint(var_10_5 + 250, 5))
			addLabelWithColorSize(var_10_0, var_10_1.trainingPoint, ccc3(0, 0, 255), 20, CCPoint(0, 0), CCPoint(var_10_5 + 290, 5))

			local var_10_6 = display.newSprite("icon/icon_yuelizhi.png", var_10_5 + 70, 18)
			local var_10_7 = display.newSprite("icon/icon_peiyangdan.png", var_10_5 + 270, 18)

			var_10_0:addChild(var_10_6)
			var_10_0:addChild(var_10_7)

			local var_10_8 = ui.newControlButton({
				disabledImage = "ui/common/common_079.png",
				normalImage = "ui/common/common_018.png",
				text = string.lf("解救"),
				textColor = ColorTable.eTitleButton_Normal,
				fontSize = ColorTable.eTitleButton_FontSize,
				anchorPoint = CCPoint(0.5, 0.5),
				position = CCPoint(730, 60),
				clickAction = function()
					if arg_7_0.remainSaveTime <= 0 then
						showFlashNotice("您的解救次数已经用完了")

						return
					end

					function callback(arg_12_0, arg_12_1)
						game.enterSlaveScene({
							showRescue = true
						})
					end

					BattleOperator:startBattle(eBattleType.DarkHouseSave, {
						friendID = var_10_1.friendID
					}, callback)
				end
			})

			var_10_0:addChild(var_10_8)

			if var_10_1.isUseProp == 1 then
				local var_10_9 = createMarkLabel({
					size = 18,
					text = string.lf("超级抓捕")
				})

				var_10_9:setAnchorPoint(CCPoint(0, 1))
				var_10_9:setPosition(CCPoint(7, 115))
				var_10_0:addChild(var_10_9)
				var_10_8:setEnabled(false)
			end
		end

		return var_10_0
	end

	local var_7_3, var_7_4 = var_7_0(nil)
	local var_7_5 = CCTableView:create(CCSize(800, 395))

	var_7_5:setContentSize(CCSize(800, var_7_1(nil) * var_7_3))
	var_7_5:setPosition(CCPoint(25, 15))
	var_7_5:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_7_5:setDirection(kCCScrollViewDirectionVertical)
	arg_7_0.background:addChild(var_7_5)
	var_7_5:registerScriptHandler(var_7_0, CCTableView.kTableCellSizeForIndex)
	var_7_5:registerScriptHandler(var_7_1, CCTableView.kNumberOfCellsInTableView)
	var_7_5:registerScriptHandler(var_7_2, CCTableView.kTableCellSizeAtIndex)
	var_7_5:reloadData()
	var_7_5:setContentOffset(var_7_5:minContainerOffset())
end

return var_0_0
