local var_0_0 = class("MapWorldLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0._worldType = arg_2_1.worldType

	arg_2_0:createMapScrollView()

	if not Player.currentMissionStageID then
		arg_2_0:setCurrentChapterPosition()
	end

	local var_2_0 = createPlayerAttrNode({
		ItemType.ePower,
		ItemType.eCoin,
		ItemType.eDoubleExpTime
	}, nil, false, {
		ItemType.eDoubleExpTime
	})

	var_2_0:setPosition(ccp(20, 578 * Adapter.HeightScale))
	arg_2_0:addChild(var_2_0)
end

function var_0_0.createMapScrollView(arg_3_0)
	local var_3_0 = worldTypeInfo[arg_3_0._worldType].path .. worldTypeInfo[arg_3_0._worldType].bg

	arg_3_0._mapBgSprite = display.newSprite(var_3_0, 0, display.cy)

	arg_3_0._mapBgSprite:setScale(Adapter.AutoScaleY)
	arg_3_0._mapBgSprite:setAnchorPoint(ccp(0, 0.5))

	local var_3_1 = arg_3_0._mapBgSprite:getContentSize()

	arg_3_0.mapScrollView = CCScrollView:create(CCSize(display.width, display.height))

	arg_3_0.mapScrollView:setDirection(kCCScrollViewDirectionHorizontal)
	arg_3_0.mapScrollView:setBounceable(false)
	arg_3_0.mapScrollView:setContentSize(CCSize(var_3_1.width * Adapter.AutoScaleY, display.height))
	arg_3_0.mapScrollView:setContentOffset(arg_3_0.mapScrollView:maxContainerOffset())
	arg_3_0:addChild(arg_3_0.mapScrollView)
	arg_3_0.mapScrollView:getContainer():addChild(arg_3_0._mapBgSprite)
	arg_3_0:createMapArea()

	for iter_3_0, iter_3_1 in ipairs(worldTypeInfo[arg_3_0._worldType].cloudSprite) do
		local var_3_2 = worldTypeInfo[arg_3_0._worldType].path .. iter_3_1.sprite

		if var_3_2 ~= "" then
			local var_3_3 = display.newSprite(var_3_2, iter_3_1.pos[1], iter_3_1.pos[2])

			var_3_3:setAnchorPoint(ccp(0, 0))
			arg_3_0._mapBgSprite:addChild(var_3_3)
		end
	end

	arg_3_0.lineSprite = display.newSprite(worldTypeInfo[arg_3_0._worldType].line, 0, 320)

	arg_3_0.lineSprite:setAnchorPoint(ccp(0, 0.5))
	arg_3_0._mapBgSprite:addChild(arg_3_0.lineSprite)
end

function var_0_0.createMapArea(arg_4_0)
	local var_4_0 = BaseStages[Player.taskInfo.MaxPID].chapterId
	local var_4_1 = {}
	local var_4_2 = {}

	for iter_4_0, iter_4_1 in pairs(BaseChapters) do
		if iter_4_1.worldType == arg_4_0._worldType then
			local var_4_3 = worldTypeInfo[iter_4_1.worldType].path

			var_4_1[iter_4_0] = {
				x = iter_4_1.imagePos[1],
				y = iter_4_1.imagePos[2],
				image = var_4_3 .. iter_4_1.image,
				imageOrder = iter_4_1.imageOrder,
				imagegray = var_4_3 .. iter_4_1.imagegray
			}

			table.insert(var_4_2, iter_4_0)
		end
	end

	table.sort(var_4_2, function(arg_5_0, arg_5_1)
		return var_4_1[arg_5_0].imageOrder > var_4_1[arg_5_1].imageOrder
	end)

	arg_4_0.chapterSpriteTable = {}

	for iter_4_2, iter_4_3 in ipairs(var_4_2) do
		local function var_4_4(arg_6_0, arg_6_1)
			if var_4_0 >= iter_4_3 then
				GuideLayer:stepDone(TaskEntryType.CheckPoint, 1)

				local var_6_0 = {}

				for iter_6_0, iter_6_1 in pairs(BaseStages) do
					if iter_6_1.chapterId == iter_4_3 then
						table.insert(var_6_0, iter_6_0)
					end
				end

				table.sort(var_6_0, function(arg_7_0, arg_7_1)
					return arg_7_0 < arg_7_1
				end)

				local var_6_1 = var_6_0[1]

				if BaseStages[var_6_0[1]].chapterId == BaseStages[Player.taskInfo.MaxPID].chapterId then
					var_6_1 = Player.taskInfo.MaxPID
				end

				game.enterMapChapterScene({
					stageId = var_6_1
				})
			else
				local var_6_2 = string.lf("地图\"%s\"还没有解锁！", BaseChapters[iter_4_3].name)

				arg_4_0:addChild(require("scenes.FlashNotice").new(var_6_2))
			end
		end

		local var_4_5 = ""

		if iter_4_3 <= var_4_0 then
			var_4_5 = var_4_1[iter_4_3].image
		else
			var_4_5 = var_4_1[iter_4_3].imagegray
		end

		local var_4_6 = display.newSprite(var_4_5)
		local var_4_7 = ccp(var_4_1[iter_4_3].x, 640 - var_4_1[iter_4_3].y)
		local var_4_8 = var_4_6:getContentSize()

		var_4_6:setPosition(ccp(var_4_7.x + var_4_8.width / 2, var_4_7.y + var_4_8.height / 2))
		arg_4_0._mapBgSprite:addChild(var_4_6)

		arg_4_0.chapterSpriteTable[iter_4_3] = var_4_6

		local var_4_9 = ui.newControlButton({
			fontSize = 24,
			normalImage = "ui/tower/tower_046.png",
			text = BaseChapters[iter_4_3].name,
			position = ccp(var_4_7.x + var_4_8.width / 2, var_4_7.y + var_4_8.height / 2),
			size = CCSize(200, 200),
			clickAction = var_4_4,
			anchorPoint = CCPoint(0.5, 0.5)
		})

		var_4_9:setOpacity(0)
		arg_4_0._mapBgSprite:addChild(var_4_9)

		local function var_4_10(arg_8_0, arg_8_1)
			arg_4_0.chapterSpriteTable[iter_4_3]:setScale(1.01)
		end

		local function var_4_11(arg_9_0, arg_9_1)
			arg_4_0.chapterSpriteTable[iter_4_3]:setScale(1)
		end

		var_4_9:addHandleOfControlEvent(var_4_10, CCControlEventTouchDown)
		var_4_9:addHandleOfControlEvent(var_4_11, CCControlEventTouchUpOutside)

		if iter_4_3 <= var_4_0 then
			local var_4_12 = var_4_7.x + var_4_8.width / 2
			local var_4_13 = var_4_7.y + var_4_8.height / 2

			if iter_4_3 == var_4_0 then
				display.addSpriteFramesWithFile("ui/map/icon_engagement.plist", "ui/map/icon_engagement.png")

				local var_4_14 = display.newSprite("#icon_engagement1.png")
				local var_4_15 = display.newFrames("icon_engagement%d.png", 1, 3)
				local var_4_16 = display.newAnimation(var_4_15, 0.3333333333333333)

				var_4_14:runAction(CCRepeatForever:create(CCAnimate:create(var_4_16)))
				var_4_14:setPosition(var_4_12 - 60, var_4_13)
				arg_4_0._mapBgSprite:addChild(var_4_14, 1)

				local var_4_17 = string.format("%s (%d/10)", BaseChapters[iter_4_3].name, iter_4_2)

				print(var_4_17)
				var_4_9:setTitleForState(CCString:create(var_4_17), CCControlStateNormal)
				var_4_9:setTitleForState(CCString:create(var_4_17), CCControlStateHighlighted)
			end

			local var_4_18 = 0

			for iter_4_4, iter_4_5 in ipairs(Player.taskInfo.Point) do
				if BaseStages[iter_4_5.PID].chapterId == iter_4_3 then
					var_4_18 = var_4_18 + iter_4_5.Star
				end
			end

			local var_4_19 = "ui/task/task_002.png"
			local var_4_20 = display.newScale9Sprite(var_4_19)

			var_4_20:setPreferredSize(CCSize(110, 25))
			var_4_20:setPosition(ccp(var_4_12 + 5, var_4_13 - 50))
			arg_4_0._mapBgSprite:addChild(var_4_20, 1)

			local var_4_21 = ccc3(0, 255, 0)
			local var_4_22 = ui.newTTFLabel({
				text = "",
				font = _FONT_DEFAULT,
				size = Adapter.FontSize(18),
				color = var_4_21,
				align = ui.TEXT_ALIGN_CENTER,
				valign = ui.TEXT_VALIGN_CENTER,
				x = var_4_12 - 5,
				y = var_4_13 - 50
			})

			var_4_22:setString(string.lf("达成:%d/30", var_4_18))
			arg_4_0._mapBgSprite:addChild(var_4_22, 1)
			Adapter.NodeAbsScale(var_4_22)

			local var_4_23 = display.newScale9Sprite("ui/common/common_077.png")

			var_4_23:align(display.CENTER, 0, 0)
			var_4_23:setPreferredSize(CCSize(35, 35))
			var_4_23:setPosition(var_4_12 + 47, var_4_13 - 49)
			arg_4_0._mapBgSprite:addChild(var_4_23, 1)

			if var_4_18 == 30 then
				local var_4_24 = display.newSprite("ui/battle/battle_fullStar.png", var_4_12 - 5, var_4_13 - 50)

				arg_4_0._mapBgSprite:addChild(var_4_24, 1)
			end
		end
	end
end

function var_0_0.setCurrentChapterPosition(arg_10_0)
	local var_10_0 = BaseStages[Player.taskInfo.MaxPID].chapterId
	local var_10_1 = Adapter.AutoHeight(1920) - display.width
	local var_10_2, var_10_3 = Adapter.AutoHeight(arg_10_0:getChapterBgPosition(var_10_0))
	local var_10_4 = display.width / 2 - var_10_2
	local var_10_5 = clampf(var_10_4, -var_10_1, 0)

	arg_10_0.mapScrollView:setContentOffsetInDuration(ccp(var_10_5, 0), 0.8)
end

function var_0_0.getChapterBgPosition(arg_11_0, arg_11_1)
	if arg_11_0.chapterSpriteTable[arg_11_1] then
		return arg_11_0.chapterSpriteTable[arg_11_1]:getPosition()
	else
		return 0, 0
	end
end

return var_0_0
