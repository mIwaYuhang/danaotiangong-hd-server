require("base.figure")
require("base.functions")
require("data.equip")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = class("FeedEquipLayer", function()
	return CCLayerColor:create(ccc4(0, 0, 0, 160))
end)
local var_0_3 = 12
local var_0_4 = 1
local var_0_5 = {}
local var_0_6 = {}
local var_0_7 = {}
local var_0_8 = true

function var_0_2.initGlobalData(arg_2_0)
	var_0_5 = {}
	var_0_6 = {}
	var_0_7 = {}

	for iter_2_0 = 1, 3 do
		for iter_2_1 = 1, 3 do
			var_0_5[(iter_2_0 - 1) * 3 + iter_2_1] = CCPoint(60 + 111 * (iter_2_1 - 1) + 25, 600 - 110 * iter_2_0 - 100)
		end
	end
end

function var_0_2.ctor(arg_3_0, arg_3_1)
	arg_3_0:addTouchEventListener(function(arg_4_0, arg_4_1, arg_4_2)
		return true
	end, false, 1, true)
	arg_3_0:setTouchEnabled(true)

	if arg_3_1.enterFromEquip == true then
		arg_3_0.equipEnhance = true
	elseif arg_3_1.enterFromEquip == false then
		arg_3_0.equipEnhance = false
	end

	arg_3_0:initGlobalData()

	arg_3_0.closeAction = arg_3_1.Callback
	arg_3_0.gEquipItem = arg_3_1.Item

	arg_3_0:initNetworkRequest()

	arg_3_0.bgSize = CCSize(780, 500)

	local var_3_0 = display.newScale9Sprite("ui/xunfang/xunfang_002.png")

	var_3_0:setPreferredSize(arg_3_0.bgSize)
	var_3_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_3_0:setPosition(display.cx, display.cy)
	var_3_0:setScale(Adapter.MinScale)

	arg_3_0.bgSprite = var_3_0
	arg_3_0.btnClose = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		highlightedImage = "ui/common/btn_closed.png",
		position = ccp(arg_3_0.bgSize.width - 20, arg_3_0.bgSize.height - 20),
		clickAction = function()
			if arg_3_0.closeAction then
				arg_3_0.closeAction(arg_3_0.gEquipItem)
			end

			arg_3_0:removeFromParentAndCleanup(true)
		end
	})

	var_3_0:addChild(arg_3_0.btnClose)
	arg_3_0.btnClose:setTouchPriority(-1)

	arg_3_0.background = display.newNode()

	arg_3_0.background:addChild(var_3_0)
	arg_3_0:addChild(arg_3_0.background)
	arg_3_0:getSameEquip()
	arg_3_0:initSliderSpace()
	arg_3_0:initFeedSpace()
	arg_3_0:refreshLayer()
end

function var_0_2.refreshLayer(arg_6_0)
	arg_6_0:calcNeedParams()

	if arg_6_0.nextFeedItem ~= nil then
		if arg_6_0.mateNumLabel == nil then
			arg_6_0.mateNumLabel = arg_6_0:addMateItem(arg_6_0.mateBack, ItemType.eMate, arg_6_0.nextFeedItem.mateId, arg_6_0.nextFeedItem.mateCount)
		else
			local var_6_0 = Player:getItemCount(ItemType.eMate, arg_6_0.nextFeedItem.mateId)
			local var_6_1 = arg_6_0.nextFeedItem.mateCount

			arg_6_0.mateNumLabel:setString((var_6_1 <= var_6_0 and "#EEE0BF" or "#B90000") .. var_6_0 .. "/" .. var_6_1)
		end

		arg_6_0.feedInfoLabel:setString(string.lf("进阶+%d后获得\n%s", arg_6_0.gEquipItem.BreakthroughCount + 1, arg_6_0.nextFeedItem.desc))

		for iter_6_0, iter_6_1 in ipairs(var_0_7) do
			if iter_6_0 > arg_6_0.needEquipCount then
				if iter_6_1.isLocked == false then
					local var_6_2 = iter_6_1.backSprite:getContentSize()
					local var_6_3 = display.newSprite("ui/team/team_077.png", var_6_2.width / 2, var_6_2.height / 2)

					iter_6_1.backSprite:addChild(var_6_3)

					iter_6_1.isLocked = true
					iter_6_1.equipNode = var_6_3
				end
			else
				iter_6_1.isLocked = false

				if iter_6_1.equipNode ~= nil then
					iter_6_1.equipNode:removeFromParentAndCleanup(true)

					iter_6_1.equipNode = nil
				end
			end

			iter_6_1.equipItem = nil
		end
	end
end

function var_0_2.initNetworkRequest(arg_7_0)
	local function var_7_0()
		local var_8_0 = arg_7_0.equipFeedRequest.restable

		for iter_8_0, iter_8_1 in pairs(arg_7_0.gEquipItem) do
			arg_7_0.gEquipItem[iter_8_0] = var_8_0.Operator.Talisman[iter_8_0]
		end

		for iter_8_2, iter_8_3 in pairs(var_0_7) do
			if iter_8_3.isLocked == false and iter_8_3.equipItem ~= nil and iter_8_3.equipItem.Type == ItemType.eEquip then
				EquipHelper:deleteOneEquip(iter_8_3.equipItem.detail.equipUserId)
			end
		end

		showFlashImage({
			image = "uilocal/shenqi/shenqi_text_012.png",
			scale = 1,
			parent = arg_7_0.bgSprite,
			position = CCPoint(arg_7_0.bgSize.width / 2, arg_7_0.bgSize.height / 2),
			callback = function()
				arg_7_0:refreshLayer()

				if arg_7_0.closeAction then
					arg_7_0.closeAction(arg_7_0.gEquipItem)
				end
			end
		})
	end

	arg_7_0.equipFeedRequest = EquipFeedRequest:new()

	arg_7_0.equipFeedRequest:setResponseNormalHandler(var_7_0)
end

function var_0_2.initSliderSpace(arg_10_0)
	local var_10_0 = CCScale9Sprite:create("ui/enhance/enhance_009.png")

	var_10_0:setPreferredSize(CCSize(400, 485))

	arg_10_0.ItemBgSize = CCSize(400, 485)

	var_10_0:setAnchorPoint(CCPoint(0, 0))
	var_10_0:setPosition(CCPoint(5, 5))
	arg_10_0.bgSprite:addChild(var_10_0)

	arg_10_0.sliderlayer = require("scenes.SliderLayer").new({
		navOffSprite = "ui/common/common_047.png",
		navOnSprite = "ui/common/common_048.png",
		navMargin = 30,
		size = CCSize(386, 485),
		point = ccp(0, 0),
		clipScaleX = Adapter.MinScale,
		clipScaleY = Adapter.MinScale,
		numberHandler = handler(arg_10_0, arg_10_0.calcCurrentPageCount),
		cellHandler = handler(arg_10_0, arg_10_0.updateItem),
		direction = SliderDirection.eHorizontal,
		navPosition = ccp(0, 100)
	})

	arg_10_0.sliderlayer:setPosition(4, 5)
	arg_10_0:reload()
	var_10_0:addChild(arg_10_0.sliderlayer)
	arg_10_0:addAutoButton(var_10_0)
end

function var_0_2.addAutoButton(arg_11_0, arg_11_1)
	local var_11_0 = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		highlightedImage = "ui/common/common_019.png",
		text = string.lf("一键放入"),
		textColor = ColorTable.eTitleButton_Normal2,
		fontSize = ColorTable.eTitleButton_FontSize2,
		anchorPoint = CCPoint(0.5, 0),
		position = CCPoint(arg_11_0.bgSize.width / 2 - 290, 20),
		clickAction = function()
			if arg_11_0:getEmptyGrid() == nil then
				showFlashNotice(string.lf("上仙，材料已满，请立刻开始喂灵吧~~"))

				return
			end

			local var_12_0 = 1

			while table.nums(var_0_6) > 0 do
				local var_12_1 = var_0_6[var_12_0]

				arg_11_0:showItemDetail(var_12_1)

				if arg_11_0:getEmptyGrid() == nil then
					break
				end

				var_12_0 = 1
			end

			if arg_11_0:getEmptyGrid() ~= nil then
				showFlashNotice(string.lf("没有更多符合条件的材料了"))

				return
			end
		end
	})

	arg_11_1:addChild(var_11_0)

	local var_11_1 = ui.newControlButton({
		highlightedImage = "ui/team/team_134.png",
		normalImage = "ui/team/team_134.png",
		anchorPoint = CCPoint(0.5, 0),
		position = ccp(arg_11_0.bgSize.width / 2 - 90, 10),
		clickAction = function()
			game.enterRefineScene({
				enterFromFeed = true,
				defaultType = EnhanceType.eEquipCompound,
				equipEnhance = arg_11_0.equipEnhance
			})
		end
	})

	arg_11_1:addChild(var_11_1)
end

function var_0_2.updateItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = display.newNode()
	local var_14_1 = table.nums(var_0_6)

	for iter_14_0 = 1, 3 do
		for iter_14_1 = 1, 3 do
			local var_14_2 = (iter_14_0 - 1) * 3 + iter_14_1
			local var_14_3 = (arg_14_2 - 1) * var_0_3 + var_14_2
			local var_14_4 = {
				itemId = -1,
				noTypeImage = false,
				isName = false,
				type = 0
			}
			local var_14_5
			local var_14_6

			if var_14_3 <= var_14_1 then
				local var_14_7 = var_0_6[var_14_3]

				var_14_7.pos = var_14_2

				local function var_14_8()
					arg_14_0:showItemDetail(var_14_7)
				end

				if var_14_7.detail and var_14_7.detail.pinJie then
					var_14_4.equipPinJie = var_14_7.detail.pinJie
				end

				if var_14_7.detail and var_14_7.detail.equipUserId then
					var_14_5 = var_14_7.detail.equipUserId
				else
					var_14_5 = var_14_7.ID
				end

				var_14_4.equipJieji = var_14_7.detail and var_14_7.detail.BreakthroughCount and var_14_7.detail.BreakthroughCount or 0
				var_14_4.equipGem = var_14_7.detail and var_14_7.detail.gem or nil

				if var_14_7.Count > 1 then
					var_14_4.count = var_14_7.Count
				end

				var_14_4.itemId = var_14_7.ID
				var_14_4.type = var_14_7.Type
				var_14_4.level = var_14_7.level or var_14_7.detail and var_14_7.detail.level

				if var_14_7.isInTeam == nil then
					-- block empty
				end

				var_14_4.inTeam = var_14_7.isInTeam
				var_14_4.clickAction = var_14_8
			else
				var_14_4.itemId = 0
				var_14_4.noTypeImage = true
				var_14_4.clickAction = nil
			end

			local var_14_9 = figure.createHeader(var_14_4)

			var_14_9:setPosition(var_0_5[var_14_2])
			var_14_0:addChild(var_14_9)

			if var_14_5 then
				var_14_9.itemId = var_14_5
			end
		end
	end

	arg_14_1:addChild(var_14_0)
end

function var_0_2.showItemDetail(arg_16_0, arg_16_1)
	if arg_16_1 == nil then
		return
	end

	local var_16_0 = var_0_5[arg_16_1.pos]
	local var_16_1 = arg_16_0:addItemToEmptyGrid(arg_16_1)

	if var_16_1 == nil then
		return
	end

	for iter_16_0, iter_16_1 in ipairs(var_0_6) do
		if iter_16_1.Type == arg_16_1.Type and iter_16_1.ID == arg_16_1.ID then
			if iter_16_1.Type == ItemType.eEquip then
				if iter_16_1.detail.equipUserId == arg_16_1.detail.equipUserId then
					table.remove(var_0_6, iter_16_0)

					break
				end
			else
				if iter_16_1.Count > 1 then
					iter_16_1.Count = iter_16_1.Count - 1

					break
				end

				table.remove(var_0_6, iter_16_0)

				break
			end
		end
	end

	local var_16_2 = figure.createHeader({
		isName = false,
		count = 0,
		inTeam = false,
		noTypeImage = false,
		itemId = arg_16_1.ID,
		type = arg_16_1.Type
	})

	var_16_2:setPosition(var_16_0)
	arg_16_0.bgSprite:addChild(var_16_2, 1000)

	local var_16_3 = CCArray:create()

	var_16_3:addObject(CCMoveTo:create(0.5, var_16_1))
	var_16_3:addObject(CCCallFunc:create(function()
		arg_16_0:reload()
		var_16_2:removeFromParentAndCleanup(true)

		for iter_17_0, iter_17_1 in pairs(var_0_7) do
			if iter_17_1.isLocked == false and iter_17_1.equipItem ~= nil and iter_17_1.equipNode ~= nil and iter_17_1.equipItem.Type == arg_16_1.Type and iter_17_1.equipItem.ID == arg_16_1.ID and iter_17_1.equipNode:isVisible() == false then
				iter_17_1.equipNode:setVisible(true)

				break
			end
		end
	end))
	var_16_2:runAction(CCSequence:create(var_16_3))
end

function var_0_2.initFeedSpace(arg_18_0)
	arg_18_0.mateBack = display.newSprite("ui/common/common_005.png", arg_18_0.bgSize.width / 2 + 200, arg_18_0.bgSize.height / 2 - 18)

	arg_18_0.bgSprite:addChild(arg_18_0.mateBack)

	arg_18_0.feedInfoLabel = addLabelWithColorSize(arg_18_0.bgSprite, "", ccc3(0, 255, 0), 19, ccp(0.5, 1), ccp(arg_18_0.bgSize.width / 2 + 200, arg_18_0.bgSize.height - 60))
	var_0_7 = {
		{
			tag = 1,
			isLocked = false,
			position = CCPoint(arg_18_0.bgSize.width / 2 + 200, arg_18_0.bgSize.height / 2 + 80)
		},
		{
			tag = 2,
			isLocked = false,
			position = CCPoint(arg_18_0.bgSize.width / 2 + 200, arg_18_0.bgSize.height / 2 - 120)
		},
		{
			tag = 3,
			isLocked = false,
			position = CCPoint(arg_18_0.bgSize.width / 2 + 100, arg_18_0.bgSize.height / 2 - 18)
		},
		{
			tag = 4,
			isLocked = false,
			position = CCPoint(arg_18_0.bgSize.width / 2 + 300, arg_18_0.bgSize.height / 2 - 18)
		}
	}

	for iter_18_0, iter_18_1 in ipairs(var_0_7) do
		local var_18_0 = display.newSprite("ui/enhance/enhance_010.png")

		var_18_0:setAnchorPoint(CCPoint(0.5, 0.5))
		var_18_0:setPosition(iter_18_1.position)
		arg_18_0.bgSprite:addChild(var_18_0)

		iter_18_1.backSprite = var_18_0
	end

	arg_18_0:addFeedButton()
end

function var_0_2.addFeedButton(arg_19_0)
	local var_19_0 = ui.newControlButton({
		disabledImage = "ui/team/team_055.png",
		normalImage = "ui/team/team_053.png",
		text = string.lf("喂灵"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		anchorPoint = CCPoint(0.5, 0.5),
		position = CCPoint(arg_19_0.bgSize.width / 2 + 200, arg_19_0.bgSize.height / 2 - 205),
		clickAction = function()
			if arg_19_0.gEquipItem.level < arg_19_0.nextFeedItem.level then
				showFlashNotice(string.lf("装备需要达到%s级才能继续喂灵", arg_19_0.nextFeedItem.level))

				return
			end

			if Player:getItemCount(ItemType.eMate, arg_19_0.nextFeedItem.mateId) < arg_19_0.nextFeedItem.mateCount then
				showFlashNotice(string.lf("上仙，您的喂灵石不够用了哦~"))

				return
			end

			if arg_19_0:getEmptyGrid() ~= nil then
				showFlashNotice(string.lf("上仙，您的喂灵材料不齐全哦~"))

				return
			end

			local var_20_0 = ""
			local var_20_1 = 0

			for iter_20_0, iter_20_1 in pairs(var_0_7) do
				if iter_20_1.isLocked == false and iter_20_1.equipItem ~= nil then
					if iter_20_1.equipItem.Type == ItemType.eEquip then
						if #var_20_0 == 0 then
							var_20_0 = iter_20_1.equipItem.detail.equipUserId
						else
							var_20_0 = var_20_0 .. "," .. iter_20_1.equipItem.detail.equipUserId
						end
					else
						var_20_1 = var_20_1 + 1
					end
				end
			end

			print(var_20_1, var_20_0)
			arg_19_0.equipFeedRequest:request(arg_19_0.gEquipItem.equipUserId, var_20_0, var_20_1)
		end
	})

	arg_19_0.bgSprite:addChild(var_19_0)
end

function var_0_2.setGridItem(arg_21_0, arg_21_1, arg_21_2)
	if var_0_7[arg_21_1].equipNode ~= nil then
		var_0_7[arg_21_1].equipNode:removeFromParentAndCleanup(true)

		var_0_7[arg_21_1].equipNode = nil
	end

	if arg_21_2 == nil then
		var_0_7[arg_21_1].equipItem = nil

		return nil
	end

	local function var_21_0()
		local var_22_0
		local var_22_1 = arg_21_2.ID
		local var_22_2 = arg_21_2.Type
		local var_22_3 = CCNode:create()
		local var_22_4 = {
			touchable = true,
			penetrable = false,
			cancelable = true
		}
		local var_22_5 = getItemQuality(var_22_2, var_22_1)
		local var_22_6 = getQualityColor(var_22_5)
		local var_22_7 = var_22_2 == ItemType.eEquip and CCSize(260, 80) or CCSize(260, 40)

		var_22_4.title = {
			size = 22,
			text = getItemName(var_22_2, var_22_1),
			color = var_22_6
		}

		var_22_3:setContentSize(var_22_7)

		local var_22_8 = string.lf("品质: %s", tostring(getQualityAttribute(var_22_5, QualityAttr.eName)))

		addLabelWithColorSize(var_22_3, var_22_8, var_22_6, 22, CCPoint(0, 0), CCPoint(20, var_22_2 == ItemType.eEquip and 45 or 0))

		if var_22_2 == ItemType.eEquip then
			local var_22_9 = BaseEquips[arg_21_2.ID].herosId
			local var_22_10 = string.lf("该装备不是专属装备")

			if table.nums(var_22_9) > 0 then
				var_22_10 = string.lf("专属: ")

				for iter_22_0, iter_22_1 in ipairs(var_22_9) do
					if iter_22_0 == 1 then
						var_22_10 = var_22_10 .. BaseHeros[iter_22_1].name
					else
						var_22_10 = var_22_10 .. ", " .. BaseHeros[iter_22_1].name
					end
				end
			end

			local var_22_11 = addLabelWithColorSize(var_22_3, var_22_10, var_22_6, 20, CCPoint(0, 1), CCPoint(20, 42))

			var_22_11:setDimensions(CCSize(var_22_7.width - 40, 40))
			var_22_11:setHorizontalAlignment(kCCTextAlignmentLeft)
			var_22_11:setVerticalAlignment(kCCVerticalTextAlignmentCenter)
		end

		local var_22_12 = var_0_0.new(var_22_4)

		var_22_12:addNode(var_22_3)
		var_22_12:addAction({
			text = string.lf("移出喂灵炉"),
			callback = function()
				var_22_12:removeFromParentAndCleanup(true)
				arg_21_0:setGridItem(arg_21_1, nil)

				if arg_21_2.Type == ItemType.eEquip then
					table.insert(var_0_6, arg_21_2)
				else
					local var_23_0 = false

					for iter_23_0, iter_23_1 in pairs(var_0_6) do
						if iter_23_1.Type == arg_21_2.Type and iter_23_1.ID == arg_21_2.ID then
							iter_23_1.Count = iter_23_1.Count + 1
							var_23_0 = true

							break
						end
					end

					if var_23_0 == false then
						table.insert(var_0_6, arg_21_2)
					end
				end

				arg_21_0:reload()
			end
		})
		var_22_12:show({
			parent = arg_21_0.bgSprite,
			x = arg_21_0.bgSize.width / 2 - 130,
			y = arg_21_0.bgSize.height / 2 - 50
		})
	end

	local var_21_1 = {
		count = 1,
		isName = false,
		inTeam = false,
		noTypeImage = false,
		itemId = arg_21_2.ID,
		type = arg_21_2.Type,
		level = arg_21_2.detail ~= nil and arg_21_2.detail.level ~= nil and arg_21_2.detail.level or nil,
		equipPinJie = arg_21_2.detail ~= nil and arg_21_2.detail.pinJie ~= nil and arg_21_2.detail.pinJie or nil,
		equipJieji = arg_21_2.detail ~= nil and arg_21_2.detail.BreakthroughCount ~= nil and arg_21_2.detail.BreakthroughCount or nil,
		equipGem = arg_21_2.detail and arg_21_2.detail.gem or nil,
		clickAction = var_21_0
	}
	local var_21_2 = figure.createHeader(var_21_1)

	var_21_2:setPosition(var_0_7[arg_21_1].position)
	arg_21_0.bgSprite:addChild(var_21_2)

	var_0_7[arg_21_1].equipNode = var_21_2

	return var_21_2
end

function var_0_2.getEmptyGrid(arg_24_0)
	local var_24_0

	for iter_24_0, iter_24_1 in pairs(var_0_7) do
		if iter_24_1.equipItem == nil and iter_24_1.isLocked == false then
			var_24_0 = iter_24_1

			break
		end
	end

	return var_24_0
end

function var_0_2.addItemToEmptyGrid(arg_25_0, arg_25_1)
	if arg_25_1 == nil then
		return nil
	end

	local var_25_0 = arg_25_0:getEmptyGrid()

	if var_25_0 == nil then
		showFlashNotice(string.lf("上仙，材料已满，请立刻开始喂灵吧~~"))

		return nil
	end

	var_25_0.equipItem = arg_25_1

	arg_25_0:setGridItem(var_25_0.tag, arg_25_1):setVisible(false)

	return var_25_0.position
end

function var_0_2.calcNeedParams(arg_26_0)
	local var_26_0 = arg_26_0.gEquipItem.BreakthroughCount ~= nil and arg_26_0.gEquipItem.BreakthroughCount or 0
	local var_26_1 = BaseEquips[arg_26_0.gEquipItem.equipId].jieJiAttrs

	arg_26_0.currLevel = var_26_0
	arg_26_0.currFeedItem = var_26_1[var_26_0]
	arg_26_0.nextFeedItem = var_26_1[var_26_0 + 1]

	if arg_26_0.nextFeedItem ~= nil then
		arg_26_0.needEquipId = arg_26_0.nextFeedItem.equipId
		arg_26_0.needEquipCount = arg_26_0.nextFeedItem.equipCount ~= nil and arg_26_0.nextFeedItem.equipCount or 0
	else
		ui.showMessageBox({
			text = string.lf("上仙，恭喜您的装备喂灵至满阶！"),
			title1 = string.lf("确定"),
			action1 = function()
				arg_26_0:removeFromParentAndCleanup(true)
			end
		})
	end
end

function var_0_2.reload(arg_28_0)
	arg_28_0.sliderlayer:reloadData()
end

function var_0_2.getSameEquip(arg_29_0)
	var_0_6 = EquipHelper:getSameNameEquip(arg_29_0.gEquipItem.equipId, arg_29_0.gEquipItem.equipUserId, 1, 0)

	local var_29_0

	for iter_29_0, iter_29_1 in pairs(BaseMates) do
		if iter_29_1.mateType == PropType.eYunTie then
			var_29_0 = iter_29_0

			break
		end
	end

	local var_29_1 = Player:getItemCount(ItemType.eMate, var_29_0)

	if var_29_1 > 0 then
		table.insert(var_0_6, {
			ID = var_29_0,
			Type = ItemType.eMate,
			Count = var_29_1
		})
	end
end

function var_0_2.calcCurrentPageCount(arg_30_0)
	local var_30_0 = table.nums(var_0_6)

	if var_30_0 <= var_0_3 then
		var_0_4 = 1
	else
		var_0_4 = math.ceil(var_30_0 / var_0_3)

		if var_0_4 == 0 then
			var_0_4 = 1
		end
	end

	return var_0_4
end

function var_0_2.addMateItem(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	local var_31_0 = arg_31_1:getContentSize()
	local var_31_1 = 0

	if arg_31_2 == ItemType.eEquip then
		var_31_1 = EquipHelper:getEquipCount(arg_31_3, true, gEquipItem.equipUserId)
	else
		var_31_1 = Player:getItemCount(arg_31_2, arg_31_3)
	end

	local var_31_2 = ui.newControlButton({
		normalImage = getItemHeaderImagePath(arg_31_2, arg_31_3),
		anchorPoint = CCPoint(0.5, 0.5),
		position = CCPoint(var_31_0.width / 2, var_31_0.height / 2),
		clickAction = function()
			local var_32_0 = var_0_0.new({})
			local var_32_1 = CCNode:create()

			var_32_1:setContentSize(CCSize(160, 100))
			addLabelWithColorSize(var_32_1, getItemName(arg_31_2, arg_31_3), ccc3(253, 187, 47), 20, CCPoint(0.5, 0), CCPoint(80, 75))
			addLabelWithColorSize(var_32_1, string.lf("需求: %s", arg_31_4), ccc3(253, 187, 47), 20, CCPoint(0, 0), CCPoint(10, 40))
			addLabelWithColorSize(var_32_1, string.lf("拥有: %s", var_31_1), ccc3(253, 187, 47), 20, CCPoint(0, 0), CCPoint(10, 5))
			var_32_0:addNode(var_32_1)
			var_32_0:show({
				x = arg_31_1:getPositionX() + 80,
				y = arg_31_1:getPositionY() + 100,
				align = display.CENTER_BOTTOM
			})
		end
	})

	arg_31_1:addChild(var_31_2)

	return addLabelWithColorSize(arg_31_1, var_31_1 .. "/" .. arg_31_4, arg_31_4 <= var_31_1 and ccc3(238, 224, 191) or ccc3(185, 0, 0), 18, ccp(0.5, 0), ccp(var_31_0.width / 2, 0))
end

return var_0_2
