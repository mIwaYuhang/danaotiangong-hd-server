local var_0_0 = {
	typeOfDuel = 1,
	typeOfShenqi = 4,
	typeOfDntg = 5,
	typeOfFuben = 6,
	typeOfXunFang = 8,
	typeOfZSZZ = 10,
	typeOfZhanSQ = 9,
	typeOfTianMing = 7,
	typeOfUnknown = 0,
	typeOfChampionShip = 3,
	typeOfDarkHouse = 2
}
local var_0_1 = {
	eShenDian = 2,
	eZhengBa = 1
}
local var_0_2 = class("PKHomeLayer", function()
	return CCLayerColor:create(ccc4(10, 10, 10, 210), display.width, display.height)
end)

function var_0_2.ctor(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or {}

	local var_2_0 = arg_2_1.type or var_0_1.eZhengBa

	arg_2_0.mType = var_2_0

	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		return true
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	local var_2_1 = CCTextureCache:sharedTextureCache():addImage("ui/common/common_040_3.png"):getContentSizeInPixels()
	local var_2_2 = display.newSprite("ui/common/common_040_3.png")

	var_2_2:setScale(Adapter.MinScale)
	var_2_2:setPosition(ccp(display.cx, display.cy))
	arg_2_0:addChild(var_2_2)

	local var_2_3

	if var_2_0 == var_0_1.eZhengBa then
		var_2_3 = "uilocal/PK/PK_text_008.png"
	elseif var_2_0 == var_0_1.eShenDian then
		var_2_3 = "uilocal/home/home_text_028.png"
	end

	local var_2_4 = display.newSprite(var_2_3)

	var_2_4:align(display.LEFT_CENTER, 35, var_2_1.height - 32)
	var_2_2:addChild(var_2_4)

	local var_2_5 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		clickAction = function()
			arg_2_0:removeFromParentAndCleanup(true)
			GuideLayer:removeAllGuideLayer()
		end
	})

	var_2_5:setPosition(var_2_1.width - 36, var_2_1.height - 36)
	var_2_2:addChild(var_2_5)

	local var_2_6 = 1
	local var_2_7
	local var_2_8

	if var_2_0 == var_0_1.eZhengBa then
		arg_2_0.cellSize = CCSize(204, 230)
		arg_2_0.dataList = {
			var_0_0.typeOfDuel,
			var_0_0.typeOfDarkHouse,
			var_0_0.typeOfChampionShip
		}

		if Player.systemOpenControllers.IsShowDntg == 1 then
			table.insert(arg_2_0.dataList, var_0_0.typeOfDntg)
		end

		if Player.systemOpenControllers.IsShowZS == 1 then
			table.insert(arg_2_0.dataList, var_0_0.typeOfZhanSQ)
			table.insert(arg_2_0.dataList, var_0_0.typeOfZSZZ)
		end

		var_2_7 = 3
		var_2_8 = 230
	elseif var_2_0 == var_0_1.eShenDian then
		arg_2_0.cellSize = CCSize(184, 427)
		arg_2_0.dataList = {
			var_0_0.typeOfFuben,
			var_0_0.typeOfTianMing,
			var_0_0.typeOfShenqi,
			var_0_0.typeOfUnknown
		}

		if Player.systemOpenControllers.IsShowXunFang and Player.systemOpenControllers.IsShowXunFang > 0 then
			arg_2_0.dataList[4] = var_0_0.typeOfXunFang
		end

		var_2_8 = 450
		var_2_7 = 4
	end

	local var_2_9 = (var_2_1.width - 20 - arg_2_0.cellSize.width * var_2_7) / (var_2_7 + 1)

	for iter_2_0 = 1, table.nums(arg_2_0.dataList) do
		local var_2_10 = arg_2_0:createTableCell(0, 0, arg_2_0.dataList[iter_2_0])

		var_2_10:setPosition((iter_2_0 - 1) % var_2_7 * (arg_2_0.cellSize.width + var_2_9) + var_2_9 + 10, var_2_1.height - 75 - var_2_8 - math.floor((iter_2_0 - 1) / var_2_7) * (arg_2_0.cellSize.height + 10))
		var_2_2:addChild(var_2_10)
	end

	GuideLayer:showGuideLayer(nil, var_2_2, TaskEntryType.eXianmoFight, 2, nil, true)
	GuideLayer:showGuideLayer(nil, var_2_2, TaskEntryType.eEntryDuelDefeat, 2, nil, true)
	GuideLayer:showGuideLayer(nil, var_2_2, TaskEntryType.eEntryDarkhouseCapture, 2, nil, true)
	GuideLayer:showGuideLayer(nil, var_2_2, TaskEntryType.eEntryDarkhouseBleedWhite, 2, nil, true)
	GuideLayer:showGuideLayer(nil, var_2_2, TaskEntryType.eEntryFukatsuTemple, 2, nil, true)
	GuideLayer:showGuideLayer(nil, var_2_2, TaskEntryType.eShenQi, 2, nil, true)
	GuideLayer:showGuideLayer(nil, var_2_2, TaskEntryType.eGuideXianMoZhengBa, 2, nil, true)
	GuideLayer:showGuideLayer(nil, var_2_2, TaskEntryType.eEntryCopy, 2, nil, true)
	GuideLayer:showGuideLayer(nil, var_2_2, TaskEntryType.eTianMing, 2, nil, true)
	GuideLayer:showGuideLayer(nil, var_2_2, TaskEntryType.eTianMingGu, 2, nil, true)
	GuideLayer:showGuideLayer(nil, var_2_2, TaskEntryType.eXunFangNormal, 2, nil, true)
	GuideLayer:showGuideLayer(nil, var_2_2, TaskEntryType.eBaiShi, 2, nil, true)
end

function var_0_2.createTableCell(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = CCLayerColor:create(ccc4(0, 0, 0, 0))

	var_5_0:setContentSize(arg_5_0.cellSize)
	var_5_0:setAnchorPoint(ccp(0.5, 0.5))
	var_5_0:setPosition(0, 0)

	local var_5_1 = "ui/PK/PK_014.png"

	if arg_5_0.mType == var_0_1.eShenDian then
		var_5_1 = "ui/home/home_077.png"
	end

	local var_5_2 = {
		[var_0_0.typeOfUnknown] = {
			Image = var_5_1
		},
		[var_0_0.typeOfDuel] = {
			TitleImg = "uilocal/PK/PK_text_009.png",
			Image = "ui/PK/PK_001.png"
		},
		[var_0_0.typeOfDarkHouse] = {
			TitleImg = "uilocal/PK/PK_text_010.png",
			Image = "ui/PK/PK_003.png"
		},
		[var_0_0.typeOfChampionShip] = {
			TitleImg = "uilocal/PK/PK_text_011.png",
			Image = "ui/PK/PK_044.png"
		},
		[var_0_0.typeOfDntg] = {
			TitleImg = "uilocal/PK/PK_text_033.png",
			Image = "ui/PK/PK_058.png"
		},
		[var_0_0.typeOfZSZZ] = {
			TitleImg = "uilocal/PK/PK_text_046.png",
			Image = "ui/PK/PK_059.png"
		},
		[var_0_0.typeOfZhanSQ] = {
			TitleImg = "uilocal/PK/PK_text_047.png",
			Image = "ui/PK/PK_060.png"
		},
		[var_0_0.typeOfShenqi] = {
			Image = "ui/home/home_076.png"
		},
		[var_0_0.typeOfFuben] = {
			Image = "ui/home/home_075.png"
		},
		[var_0_0.typeOfTianMing] = {
			Image = "ui/home/home_073.png"
		},
		[var_0_0.typeOfXunFang] = {
			Image = "ui/home/home_074.png"
		}
	}
	local var_5_3
	local var_5_4 = arg_5_0.cellSize

	if arg_5_3 ~= var_0_0.typeOfUnknown then
		var_5_3 = ui.newControlButton({
			normalImage = var_5_2[arg_5_3].Image,
			size = var_5_4,
			position = CCPoint(arg_5_0.cellSize.width / 2, arg_5_0.cellSize.height / 2 - 2.5),
			clickAction = function()
				if arg_5_3 == var_0_0.typeOfDarkHouse then
					game.enterSlaveScene({
						isJumpFromPKHomeLayer = true
					})
				elseif arg_5_3 == var_0_0.typeOfDuel then
					game.enterPKScene({
						isJumpFromPKHomeLayer = true
					})
				elseif arg_5_3 == var_0_0.typeOfChampionShip then
					game.enterCSHomeScene({
						isJumpFromPKHomeLayer = true
					})
				elseif arg_5_3 == var_0_0.typeOfShenqi then
					game.enterShenqiScene()
				elseif arg_5_3 == var_0_0.typeOfDntg then
					game.enterDuelRankScene()
				elseif arg_5_3 == var_0_0.typeOfZSZZ then
					game.enterZSZZHomeScene()
				elseif arg_5_3 == var_0_0.typeOfZhanSQ then
					game.enterZSQHomeScene()
				elseif arg_5_3 == var_0_0.typeOfFuben then
					game.enterFubenIndexScene({})
				elseif arg_5_3 == var_0_0.typeOfTianMing then
					game.enterTianmingRecruitScene()
				elseif arg_5_3 == var_0_0.typeOfXunFang then
					game.enterXunfangScene({})
				end
			end
		})
	else
		var_5_3 = display.newScale9Sprite(var_5_2[arg_5_3].Image, arg_5_0.cellSize.width / 2, arg_5_0.cellSize.height / 2 - 2.5, var_5_4)
	end

	var_5_0:addChild(var_5_3)

	if arg_5_3 ~= var_0_0.typeOfUnknown and var_5_2[arg_5_3].TitleImg then
		local var_5_5 = display.newSprite(var_5_2[arg_5_3].TitleImg)

		var_5_5:setAnchorPoint(CCPoint(0.5, 0.5))
		var_5_5:setPosition(var_5_4.width / 2, 150)
		var_5_3:addChild(var_5_5)
	end

	local function var_5_6(arg_7_0, arg_7_1)
		local var_7_0 = display.newSprite("ui/PK/PK_015.png")

		var_7_0:setAnchorPoint(CCPoint(1, 0))
		var_7_0:setPosition(var_5_4.width - 20, 80)
		var_5_3:addChild(var_7_0)

		local var_7_1 = var_7_0:getContentSize()
		local var_7_2 = string.lf("次数: %d/%d", arg_7_0, arg_7_1)

		addLabelWithColorSize(var_7_0, var_7_2, ccc3(255, 255, 0), 20, CCPoint(1, 0), CCPoint(var_7_1.width - 10, 13))
	end

	local function var_5_7(arg_8_0)
		local var_8_0 = CCSize(159, 57)
		local var_8_1 = display.newScale9Sprite("ui/PK/PK_016.png", var_5_4.width / 2, 30, var_8_0)

		var_8_1:setAnchorPoint(CCPoint(0.5, 0))
		var_5_3:addChild(var_8_1)

		local var_8_2 = addLabelWithColorSize(var_8_1, arg_8_0, ccc3(216, 189, 112), 18, CCPoint(0.5, 0.5), CCPoint(var_8_0.width / 2, var_8_0.height / 2))

		var_8_2:setHorizontalAlignment(ui.TEXT_ALIGN_CENTER)
		var_8_2:setVerticalAlignment(ui.TEXT_VALIGN_CENTER)
		var_8_2:setDimensions(var_8_0)
	end

	local function var_5_8(arg_9_0)
		local var_9_0 = display.newSprite(arg_9_0)

		var_9_0:setAnchorPoint(CCPoint(0, 1))
		var_9_0:setPosition(1, var_5_4.height - 4)
		var_5_3:addChild(var_9_0)
	end

	if arg_5_3 == var_0_0.typeOfDarkHouse then
		var_5_7(string.lf("抓其他玩家做奴隶\n获: 阅历、培养丹"))

		if Player.darkHouse == nil then
			return var_5_0
		end

		if Player.darkHouse.CanCapture == true and Player.darkHouse.Last > 0 then
			var_5_8("ui/common/common_107.png")
		end

		var_5_6(Player.darkHouse.Last, Player.darkHouse.Total)
	elseif arg_5_3 == var_0_0.typeOfDuel then
		var_5_7(string.lf("争夺天界排名\n获: 进阶丹、荣誉值"))

		if Player.duelObject == nil then
			return var_5_0
		end

		if Player.duelObject.Last > 0 then
			var_5_8("ui/common/common_108.png")
		end

		var_5_6(Player.duelObject.Last, Player.duelObject.Total)
	elseif arg_5_3 == var_0_0.typeOfChampionShip then
		var_5_7(string.lf("参与仙魔争霸\n可获各种丰厚奖励"))
	elseif arg_5_3 == var_0_0.typeOfShenqi then
		var_5_7(string.lf("挑战其他玩家\n获: 神器碎片"))

		if Player.shenQiTimes == nil then
			return var_5_0
		end

		if Player.shenQiTimes.ATimes > 0 then
			var_5_8("ui/common/common_128.png")
		end

		var_5_6(Player.shenQiTimes.ATimes, Player.shenQiTimes.TotalTimes)
	elseif arg_5_3 == var_0_0.typeOfDntg then
		var_5_7(string.lf("挑战其他玩家\n获: 地藏王魂魄"))

		if Player.biwuNXM == nil then
			return var_5_0
		end

		if Player.biwuNXM.Status > 0 then
			var_5_8("ui/common/common_108.png")
		end

		if Player.biwuNXM.Last and Player.biwuNXM.Total then
			var_5_6(Player.biwuNXM.Last, Player.biwuNXM.Total)
		end
	elseif arg_5_3 == var_0_0.typeOfZSZZ then
		var_5_7(string.lf("跨服挑战\n获: 饕餮、诸神礼包"))
	elseif arg_5_3 == var_0_0.typeOfZhanSQ then
		var_5_7(string.lf("擂台守护战\n获: 诸神之战资格"))
	end

	return var_5_0
end

return var_0_2
