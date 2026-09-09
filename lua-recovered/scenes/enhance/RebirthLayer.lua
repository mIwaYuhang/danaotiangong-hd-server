require("base.figure")

local var_0_0 = {
	eButtonHero = 1,
	eButtonEquip = 2
}
local var_0_1 = {
	sortByQualityDown = 1,
	sortByQualityUp = 2,
	sortByLevelUp = 4,
	sortByLevelDown = 3
}
local var_0_2 = {
	[var_0_1.sortByQualityDown] = string.lf("品质降序"),
	[var_0_1.sortByQualityUp] = string.lf("品质升序"),
	[var_0_1.sortByLevelDown] = string.lf("等级降序"),
	[var_0_1.sortByLevelUp] = string.lf("等级升序")
}
local var_0_3 = 12
local var_0_4 = 1
local var_0_5 = 1
local var_0_6 = var_0_0.eButtonHero
local var_0_7 = var_0_0.eButtonHero
local var_0_8 = {}
local var_0_9 = {}
local var_0_10 = {}

local function var_0_11()
	var_0_8 = {}
	var_0_9 = {}
	var_0_10 = {}
	var_0_5 = 1
	var_0_6 = var_0_0.eButtonHero
	var_0_7 = var_0_0.eButtonHero

	for iter_1_0 = 1, 3 do
		for iter_1_1 = 1, 4 do
			var_0_8[(iter_1_0 - 1) * 4 + iter_1_1] = CCPoint(60 + 111 * (iter_1_1 - 1), 490 - 110 * iter_1_0)
		end
	end
end

local function var_0_12()
	local var_2_0 = table.nums(var_0_9)

	if var_2_0 <= var_0_3 then
		var_0_4 = 1
	else
		var_0_4 = math.ceil(var_2_0 / var_0_3)
	end
end

local var_0_13 = class("RebirthLayer", function()
	return display.newLayer()
end)

function var_0_13.ctor(arg_4_0, arg_4_1)
	var_0_11()

	local var_4_0 = CCScale9Sprite:create("ui/enhance/enhance_009.png")

	var_4_0:setPreferredSize(CCSize(450, 452))
	var_4_0:setAnchorPoint(CCPoint(0, 0))
	var_4_0:setPosition(CCPoint(55, 25))
	arg_4_0:addChild(var_4_0)

	arg_4_0.bgSprite = var_4_0

	local function var_4_1(arg_5_0)
		if arg_4_0.rebirthItem.Type == ItemType.eEquip then
			EquipHelper:deleteOneEquip(arg_4_0.rebirthItem.detail.equipUserId)
		elseif arg_4_0.rebirthItem.Type == ItemType.eHero then
			-- block empty
		end

		arg_4_0.rebirthItem = nil

		arg_4_0:refreshCurrentList()
		arg_4_0:sortCurrentList(arg_4_0.btnSort:getTag())
		arg_4_0:updateItemLayer()
	end

	local function var_4_2(arg_6_0)
		local var_6_0 = arg_4_0:createHeader(arg_6_0.equipItem, arg_6_0.position)
		local var_6_1 = CCArray:create()
		local var_6_2 = CCArray:create()

		var_6_1:addObject(CCMoveTo:create(1, CCPoint(280, 330)))
		var_6_1:addObject(CCScaleTo:create(1, 0.1))
		var_6_2:addObject(CCEaseSineIn:create(CCSpawn:create(var_6_1)))
		var_6_2:addObject(CCCallFunc:create(function()
			var_6_0:removeFromParentAndCleanup(true)

			arg_4_0.rebirthItem = nil

			arg_4_0:updateItemLayer()
		end))
		var_6_0:runAction(CCSequence:create(var_6_2))
	end

	arg_4_0.rebirthItem = nil
	arg_4_0.equipRebirthLayer = require("scenes.enhance.EquipRebirthLayer").new({
		okCallback = var_4_1,
		cancelCallback = var_4_2
	})

	arg_4_0.equipRebirthLayer:setPosition(-55, -5)
	arg_4_0.bgSprite:addChild(arg_4_0.equipRebirthLayer)
	arg_4_0:addTabButtons(var_4_0, arg_4_1 ~= nil and arg_4_1.refineTag or nil)
end

function var_0_13.reloadData(arg_8_0, arg_8_1)
	arg_8_0.rebirthItem = nil

	arg_8_0.equipRebirthLayer:removeAllEquips()

	if arg_8_1 ~= nil then
		arg_8_0.tabLayer:reloadLayer(arg_8_1 == ItemType.eHero and var_0_0.eButtonHero or var_0_0.eButtonEquip)
	else
		arg_8_0:refreshCurrentList()
		arg_8_0:sortCurrentList(arg_8_0.btnSort:getTag())
		arg_8_0:updateItemLayer()
	end
end

function var_0_13.addTabButtons(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {
		{
			isDefault = false,
			y = 388,
			tag = var_0_0.eButtonHero,
			titleText = string.lf("主\n将")
		},
		{
			isDefault = false,
			y = 268,
			tag = var_0_0.eButtonEquip,
			titleText = string.lf("装\n备")
		}
	}

	if arg_9_2 ~= nil and arg_9_2 == ItemType.eEquip then
		var_9_0[2].isDefault = true
	else
		var_9_0[1].isDefault = true
	end

	local function var_9_1(arg_10_0)
		var_0_6 = arg_10_0
		var_0_5 = 1

		arg_9_0.btnSort:setTag(var_0_1.sortByQualityDown)
		arg_9_0.btnSort:setTitleForState(CCString:create(var_0_2[var_0_1.sortByQualityDown]), CCControlStateNormal)
		arg_9_0:refreshCurrentList()
		arg_9_0:sortCurrentList(var_0_1.sortByQualityDown)
		arg_9_0:updateItemLayer()
	end

	local function var_9_2(arg_11_0)
		var_0_7 = arg_11_0

		if var_0_6 > var_0_7 then
			arg_9_0.pageLayer:moveVertical(false, true)
		elseif var_0_6 < var_0_7 then
			arg_9_0.pageLayer:moveVertical(true, true)
		end

		var_9_1(arg_11_0)
	end

	local function var_9_3(arg_12_0, arg_12_1)
		arg_9_0:addSliderLayer(arg_12_0, arg_12_1)
		arg_9_0:addInfoFooter(arg_12_0)
		var_9_1(arg_12_1)
	end

	arg_9_0.tabLayer = require("scenes.TabLayer").new({
		isVert = true,
		selectedImage = "ui/common/common_036.png",
		normalImage = "ui/common/common_037.png",
		size = CCSize(450, 452),
		point = CCPoint(0, 0),
		labelAnchorPoint = ccp(0.3, 0.5),
		config = var_9_0,
		cellHandler = var_9_3,
		changedHandler = var_9_2
	})

	arg_9_1:addChild(arg_9_0.tabLayer)
end

function var_0_13.addSliderLayer(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.parentSize = arg_13_1:getContentSize()
	arg_13_0.itemLayer = CCNodeExtend.extend(CCLayerColor:create())
	arg_13_0.pageLayer = require("scenes.enhance.PageLayer").new()

	arg_13_0.pageLayer:init(CCRect(arg_13_0.parentSize.width / 2, arg_13_0.parentSize.height / 2 + 10, arg_13_0.parentSize.width - 10, arg_13_0.parentSize.height - 34), arg_13_0.itemLayer, PageActionType.eMoveBoth)
	arg_13_0.pageLayer:setMoveVertical(arg_13_0, arg_13_0.pageVert)
	arg_13_0.pageLayer:setMoveHorizontal(arg_13_0, arg_13_0.pageHori)
	arg_13_0.pageLayer:setLimiteVert(arg_13_0, arg_13_0.limiteVert)
	arg_13_0.pageLayer:setLimiteHori(arg_13_0, arg_13_0.limiteHori)
	arg_13_1:addChild(arg_13_0.pageLayer, 0)
end

function var_0_13.pageVert(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2 then
		var_0_6 = var_0_7
	else
		local var_14_0 = var_0_6

		if arg_14_1 then
			var_0_6 = var_0_6 + 1
		else
			var_0_6 = var_0_6 - 1
		end

		arg_14_0.tabLayer:reloadLayer(var_0_6)
	end
end

function var_0_13.pageHori(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_2 then
		-- block empty
	else
		if arg_15_1 then
			var_0_5 = var_0_5 - 1
		else
			var_0_5 = var_0_5 + 1
		end

		arg_15_0:updateItemLayer()
	end
end

function var_0_13.limiteVert(arg_16_0, arg_16_1)
	if arg_16_1 == true and var_0_6 >= table.nums(var_0_0) then
		return false
	elseif arg_16_1 == false and var_0_6 <= 1 then
		return false
	else
		return true
	end
end

function var_0_13.limiteHori(arg_17_0, arg_17_1)
	if arg_17_1 == false and var_0_5 >= var_0_4 then
		return false
	elseif arg_17_1 and var_0_5 <= 1 then
		return false
	else
		return true
	end
end

function var_0_13.addInfoFooter(arg_18_0, arg_18_1)
	arg_18_0.btnAutoAdd = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		highlightedImage = "ui/common/common_019.png",
		text = string.lf("一键放入"),
		textColor = ColorTable.eTitleButton_Normal2,
		fontSize = ColorTable.eTitleButton_FontSize2,
		anchorPoint = CCPoint(0.5, 0),
		position = CCPoint(arg_18_0.parentSize.width / 2 - 100, 20),
		clickAction = handler(arg_18_0, arg_18_0.autoButtonAction)
	})
	arg_18_0.btnSort = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		highlightedImage = "ui/common/common_019.png",
		text = var_0_2[var_0_1.sortByQualityDown],
		textColor = ColorTable.eTitleButton_Normal2,
		fontSize = ColorTable.eTitleButton_FontSize2,
		anchorPoint = CCPoint(0.5, 0),
		position = CCPoint(arg_18_0.parentSize.width / 2 + 100, 20),
		clickAction = handler(arg_18_0, arg_18_0.sortButtonAction)
	})

	arg_18_0.btnSort:setTag(var_0_1.sortByQualityDown)
	arg_18_1:addChild(arg_18_0.btnAutoAdd)
	arg_18_1:addChild(arg_18_0.btnSort)

	arg_18_0.pageIndicator = require("scenes.PageIndicator").new({
		positionY = 90,
		pageSpace = 10,
		pageCount = var_0_4,
		pageCurrent = var_0_5,
		pageWidth = arg_18_0.parentSize.width
	})

	arg_18_1:addChild(arg_18_0.pageIndicator)
end

function var_0_13.updateItemLayer(arg_19_0)
	local var_19_0 = table.nums(var_0_9)

	for iter_19_0, iter_19_1 in pairs(var_0_10) do
		iter_19_1:removeFromParentAndCleanup(true)
	end

	var_0_10 = {}

	var_0_12()
	arg_19_0.pageIndicator:updateIndicator(var_0_4, var_0_5)

	for iter_19_2 = 1, 3 do
		for iter_19_3 = 1, 4 do
			local var_19_1 = (iter_19_2 - 1) * 4 + iter_19_3
			local var_19_2 = (var_0_5 - 1) * var_0_3 + var_19_1
			local var_19_3 = {
				itemId = -1,
				isName = false,
				count = 0,
				type = 0,
				inTeam = false,
				noTypeImage = false
			}
			local var_19_4
			local var_19_5
			local var_19_6 = false

			if var_19_2 <= var_19_0 then
				local var_19_7 = var_0_9[var_19_2]

				var_19_7.pos = var_19_1
				var_19_6 = arg_19_0:isInRebirthList(var_19_7)

				local function var_19_8()
					if var_19_6 == false then
						arg_19_0:showItemDetail(var_19_7)
					end
				end

				if var_19_7.detail and var_19_7.detail.pinJie then
					var_19_3.equipPinJie = var_19_7.detail.pinJie
				end

				if var_19_7.detail and var_19_7.detail.equipUserId then
					var_19_4 = var_19_7.detail.equipUserId
				else
					var_19_4 = var_19_7.ID
				end

				if var_0_6 == var_0_0.eButtonEquip then
					var_19_3.equipJieji = var_19_7.detail and var_19_7.detail.BreakthroughCount and var_19_7.detail.BreakthroughCount or 0
					var_19_3.equipGem = var_19_7.detail and var_19_7.detail.gem or nil
				end

				if var_19_7.Count > 1 then
					var_19_3.count = var_19_7.Count
				end

				var_19_3.itemId = var_19_7.ID
				var_19_3.type = var_19_7.Type
				var_19_3.level = var_19_7.level or var_19_7.detail and var_19_7.detail.level

				if var_19_7.isInTeam == nil then
					-- block empty
				end

				var_19_3.inTeam = var_19_7.isInTeam
				var_19_3.clickAction = var_19_8
			else
				var_19_3.itemId = 0
				var_19_3.noTypeImage = true
				var_19_3.clickAction = nil
			end

			local var_19_9 = figure.createHeader(var_19_3)

			var_19_9:setPosition(var_0_8[var_19_1])
			arg_19_0.itemLayer:addChild(var_19_9)

			if var_19_6 == true then
				local var_19_10 = display.newSprite("ui/common/common_029.png")

				var_19_10:setAnchorPoint(CCPoint(1, 1))
				var_19_10:setPosition(0, 0)
				var_19_9:addChild(var_19_10)
			end

			if var_19_4 then
				var_19_9.itemId = var_19_4
			end

			table.insert(var_0_10, var_19_9)
		end
	end
end

function var_0_13.showItemDetail(arg_21_0, arg_21_1)
	if arg_21_1 == nil then
		return
	end

	local var_21_0 = arg_21_0:convertPosition(var_0_8[arg_21_1.pos])
	local var_21_1 = arg_21_0.equipRebirthLayer:addGridEquip(arg_21_1)

	if var_21_1 == nil then
		return
	end

	arg_21_0.rebirthItem = arg_21_1

	arg_21_0:updateItemLayer()

	local var_21_2 = arg_21_0:createHeader(arg_21_1, var_21_0)
	local var_21_3 = CCArray:create()

	var_21_3:addObject(CCMoveTo:create(0.5, var_21_1))
	var_21_3:addObject(CCCallFunc:create(function()
		var_21_2:removeFromParentAndCleanup(true)
		arg_21_0.equipRebirthLayer:showGridEquip(arg_21_1)
	end))
	var_21_2:runAction(CCSequence:create(var_21_3))
end

function var_0_13.sortButtonAction(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = tolua.cast(arg_23_2, "CCControlButton")

	if var_23_0:getTag() == var_0_1.sortByQualityDown then
		var_23_0:setTag(var_0_1.sortByQualityUp)
		var_23_0:setTitleForState(CCString:create(var_0_2[var_0_1.sortByQualityUp]), CCControlStateNormal)
		arg_23_0:sortCurrentList(var_0_1.sortByQualityUp)
	elseif var_23_0:getTag() == var_0_1.sortByQualityUp then
		var_23_0:setTag(var_0_1.sortByQualityDown)
		var_23_0:setTitleForState(CCString:create(var_0_2[var_0_1.sortByQualityDown]), CCControlStateNormal)
		arg_23_0:sortCurrentList(var_0_1.sortByQualityDown)
	end

	var_0_5 = 1

	arg_23_0:updateItemLayer()
end

function var_0_13.autoButtonAction(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0.equipRebirthLayer:isItemFull() == true then
		showFlashNotice(string.lf("上仙，重生炉已满，请立刻开始重生吧~~"))

		return
	end

	if arg_24_0.equipRebirthLayer:canRebirthNow() == false then
		print("现在不能重生！！！")

		return
	end

	if arg_24_0.btnSort:getTag() == var_0_1.sortByQualityDown then
		var_0_5 = var_0_4

		arg_24_0:updateItemLayer()
	end

	for iter_24_0 = 1, table.nums(var_0_9) do
		local var_24_0 = arg_24_0.btnSort:getTag() == var_0_1.sortByQualityDown and var_0_9[table.nums(var_0_9) - iter_24_0 + 1] or var_0_9[iter_24_0]

		if arg_24_0:isInRebirthList(var_24_0) == false then
			arg_24_0:showItemDetail(var_24_0)

			if arg_24_0.equipRebirthLayer:isItemFull() == true then
				break
			end
		end
	end

	if arg_24_0.equipRebirthLayer:isItemFull() == false then
		showFlashNotice(string.lf("没有更多符合条件的物品了"))
	end
end

function var_0_13.refreshCurrentList(arg_25_0)
	var_0_9 = {}

	if var_0_6 == var_0_0.eButtonHero then
		for iter_25_0, iter_25_1 in pairs(Player:getNotInTeamOwnedHeros()) do
			if iter_25_1.isInTeam == false and iter_25_1.level > 1 then
				local var_25_0 = {
					ID = iter_25_1.heroId,
					Type = ItemType.eHero
				}

				var_25_0.Count = 1
				var_25_0.level = iter_25_1.level
				var_25_0.isInTeam = false
				var_25_0.detail = iter_25_1

				table.insert(var_0_9, var_25_0)
			end
		end
	elseif var_0_6 == var_0_0.eButtonEquip then
		arg_25_0:requestEquipData()
	end
end

function var_0_13.sortCurrentList(arg_26_0, arg_26_1)
	if arg_26_1 == var_0_1.sortByQualityDown then
		table.sort(var_0_9, function(arg_27_0, arg_27_1)
			return GlobalSortCallback(arg_27_0, arg_27_1, GlobalSortTypes.sortByQualityDown)
		end)
	elseif arg_26_1 == var_0_1.sortByQualityUp then
		table.sort(var_0_9, function(arg_28_0, arg_28_1)
			return GlobalSortCallback(arg_28_0, arg_28_1, GlobalSortTypes.sortByQualityUp)
		end)
	elseif arg_26_1 == var_0_1.sortByLevelDown then
		table.sort(var_0_9, function(arg_29_0, arg_29_1)
			return GlobalSortCallback(arg_29_0, arg_29_1, GlobalSortTypes.sortByLevelDown)
		end)
	elseif arg_26_1 == var_0_1.sortByLevelUp then
		table.sort(var_0_9, function(arg_30_0, arg_30_1)
			return GlobalSortCallback(arg_30_0, arg_30_1, GlobalSortTypes.sortByLevelUp)
		end)
	end
end

function var_0_13.requestEquipData(arg_31_0)
	local function var_31_0(arg_32_0)
		var_0_9 = {}

		for iter_32_0, iter_32_1 in ipairs(arg_32_0) do
			local var_32_0 = {}

			if iter_32_1.isInTeam == 0 and (iter_32_1.level > 1 or iter_32_1.BreakthroughCount > 0) then
				var_32_0.ID = iter_32_1.equipId
				var_32_0.Type = ItemType.eEquip
				var_32_0.Count = 1
				var_32_0.detail = iter_32_1

				table.insert(var_0_9, var_32_0)
			end
		end

		arg_31_0:sortCurrentList(var_0_1.sortByQualityDown)
		arg_31_0:updateItemLayer()
	end

	EquipHelper:getEquipList(EquipClassType.eEquipAll, var_31_0)
end

function var_0_13.convertPosition(arg_33_0, arg_33_1)
	return CCPoint(arg_33_1.x + 55, arg_33_1.y + 5)
end

function var_0_13.createHeader(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = {
		isName = false,
		noTypeImage = false,
		inTeam = false,
		itemId = arg_34_1.ID,
		type = arg_34_1.Type,
		equipPinJie = var_0_6 == var_0_0.eButtonEquip and arg_34_1.detail.pinJie or nil,
		equipGem = var_0_6 == var_0_0.eButtonEquip and arg_34_1.detail.gem or nil,
		level = arg_34_1.detail.level,
		count = arg_34_1.Count
	}
	local var_34_1 = figure.createHeader(var_34_0)

	var_34_1:setPosition(arg_34_2)
	arg_34_0.bgSprite:addChild(var_34_1, 1000)

	return var_34_1
end

function var_0_13.isInRebirthList(arg_35_0, arg_35_1)
	if arg_35_0.rebirthItem == nil then
		return false
	end

	if var_0_6 == var_0_0.eButtonEquip then
		return arg_35_1.detail.equipUserId == arg_35_0.rebirthItem.detail.equipUserId
	else
		return arg_35_1.Type == arg_35_0.rebirthItem.Type and arg_35_1.ID == arg_35_0.rebirthItem.ID
	end
end

return var_0_13
