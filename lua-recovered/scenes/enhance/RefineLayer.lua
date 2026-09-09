require("base.figure")

local var_0_0 = {
	eButtonEquipment = 3,
	eButtonSoul = 2,
	eButtonHero = 1
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
local var_0_11 = {}

local function var_0_12()
	var_0_9 = {}
	var_0_10 = {}
	var_0_11 = {}
	var_0_8 = {}
	var_0_5 = 1
	var_0_6 = var_0_0.eButtonHero
	var_0_7 = var_0_0.eButtonHero

	for iter_1_0 = 1, 3 do
		for iter_1_1 = 1, 4 do
			var_0_9[(iter_1_0 - 1) * 4 + iter_1_1] = CCPoint(60 + 111 * (iter_1_1 - 1), 490 - 110 * iter_1_0)
		end
	end
end

local function var_0_13()
	local var_2_0 = table.nums(var_0_10)

	if var_2_0 <= var_0_3 then
		var_0_4 = 1
	else
		var_0_4 = math.ceil(var_2_0 / var_0_3)
	end
end

local var_0_14 = class("RefineLayer", function()
	return display.newLayer()
end)

function var_0_14.ctor(arg_4_0, arg_4_1)
	var_0_12()

	arg_4_0.rebirthAction = arg_4_1.rebirthAction
	arg_4_0.refineScene = arg_4_1.refineScene
	arg_4_0.parentBgSprite = arg_4_1.parentBgSprite

	local var_4_0 = CCScale9Sprite:create("ui/enhance/enhance_009.png")

	var_4_0:setPreferredSize(CCSize(450, 452))
	var_4_0:setAnchorPoint(CCPoint(0, 0))
	var_4_0:setPosition(CCPoint(55, 25))
	arg_4_0:addChild(var_4_0)

	arg_4_0.bgSprite = var_4_0

	local function var_4_1(arg_5_0)
		for iter_5_0, iter_5_1 in pairs(var_0_8) do
			if iter_5_1.Type == ItemType.eEquip then
				EquipHelper:deleteOneEquip(iter_5_1.ID)
			elseif iter_5_1.Type == ItemType.eHero then
				Player:deleteOwnedFigure(iter_5_1.ID)
			end
		end

		var_0_8 = {}

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

			for iter_7_0 = table.nums(var_0_8), 1, -1 do
				local var_7_0 = var_0_8[iter_7_0]
				local var_7_1 = var_7_0.Type == ItemType.eEquip and arg_6_0.equipItem.detail.equipUserId or arg_6_0.equipItem.ID

				if var_7_0.Type == arg_6_0.equipItem.Type and var_7_0.ID == var_7_1 then
					table.remove(var_0_8, iter_7_0)

					break
				end
			end

			arg_4_0:refreshCurrentList()
			arg_4_0:sortCurrentList(arg_4_0.btnSort:getTag())
			arg_4_0:updateItemLayer()
		end))
		var_6_0:runAction(CCSequence:create(var_6_2))
	end

	arg_4_0.equipRefineLayer = require("scenes.enhance.EquipRefineLayer").new({
		rebirthAction = arg_4_0.rebirthAction,
		okCallback = var_4_1,
		cancelCallback = var_4_2,
		parentBgSprite = arg_4_0.parentBgSprite
	})

	arg_4_0.equipRefineLayer:setPosition(-55, -5)
	arg_4_0.bgSprite:addChild(arg_4_0.equipRefineLayer)
	arg_4_0:addTabButtons(var_4_0, arg_4_1 ~= nil and arg_4_1.refineTag or nil)

	local var_4_3 = GuideLayer:showGuideLayer(arg_4_0.refineScene, arg_4_0.parentBgSprite, TaskEntryType.eRefining, 3, nil, true)

	if var_4_3 then
		var_4_3.guideLable:setString(string.lf("点击任意主将"))
	end
end

function var_0_14.reloadData(arg_8_0)
	var_0_8 = {}

	arg_8_0.equipRefineLayer:removeAllEquips()
	arg_8_0:refreshCurrentList()
	arg_8_0:sortCurrentList(arg_8_0.btnSort:getTag())
	arg_8_0:updateItemLayer()
end

function var_0_14.addTabButtons(arg_9_0, arg_9_1, arg_9_2)
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
			tag = var_0_0.eButtonSoul,
			titleText = string.lf("魂\n魄")
		},
		{
			isDefault = false,
			y = 148,
			tag = var_0_0.eButtonEquipment,
			titleText = string.lf("装\n备")
		}
	}

	if arg_9_2 ~= nil then
		if arg_9_2 == ItemType.eSoul then
			var_9_0[2].isDefault = true
		elseif arg_9_2 == ItemType.eEquip then
			var_9_0[3].isDefault = true
		elseif arg_9_2 == ItemType.eFragment then
			var_9_0[4].isDefault = true
		else
			var_9_0[1].isDefault = true
		end
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

function var_0_14.addSliderLayer(arg_13_0, arg_13_1, arg_13_2)
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

function var_0_14.pageVert(arg_14_0, arg_14_1, arg_14_2)
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

function var_0_14.pageHori(arg_15_0, arg_15_1, arg_15_2)
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

function var_0_14.limiteVert(arg_16_0, arg_16_1)
	if arg_16_1 == true and var_0_6 >= table.nums(var_0_0) then
		return false
	elseif arg_16_1 == false and var_0_6 <= 1 then
		return false
	else
		return true
	end
end

function var_0_14.limiteHori(arg_17_0, arg_17_1)
	if arg_17_1 == false and var_0_5 >= var_0_4 then
		return false
	elseif arg_17_1 and var_0_5 <= 1 then
		return false
	else
		return true
	end
end

function var_0_14.addInfoFooter(arg_18_0, arg_18_1)
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

function var_0_14.updateItemLayer(arg_19_0)
	local var_19_0 = table.nums(var_0_10)

	for iter_19_0, iter_19_1 in pairs(var_0_11) do
		iter_19_1:removeFromParentAndCleanup(true)
	end

	var_0_11 = {}

	var_0_13()
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

			if var_19_2 <= var_19_0 then
				local var_19_6 = var_0_10[var_19_2]

				var_19_6.pos = var_19_1

				local function var_19_7()
					GuideLayer:stepDone(TaskEntryType.eRefining, 3)
					GuideLayer:showGuideLayer(nil, arg_19_0.parentBgSprite, TaskEntryType.eRefining, 4, nil, true)
					arg_19_0:showItemDetail(var_19_6)
				end

				if var_19_6.detail and var_19_6.detail.pinJie then
					var_19_3.equipPinJie = var_19_6.detail.pinJie
				end

				if var_19_6.detail and var_19_6.detail.equipUserId then
					var_19_4 = var_19_6.detail.equipUserId
				else
					var_19_4 = var_19_6.ID
				end

				if var_0_6 == var_0_0.eButtonEquipment then
					var_19_3.equipJieji = var_19_6.detail and var_19_6.detail.BreakthroughCount and var_19_6.detail.BreakthroughCount or 0
					var_19_3.equipGem = var_19_6.detail and var_19_6.detail.gem or nil
				end

				if var_19_6.Count > 1 then
					var_19_3.count = var_19_6.Count
				end

				var_19_3.itemId = var_19_6.ID
				var_19_3.type = var_19_6.Type
				var_19_3.level = var_19_6.level or var_19_6.detail and var_19_6.detail.level

				if var_19_6.isInTeam == nil then
					-- block empty
				end

				var_19_3.inTeam = var_19_6.isInTeam
				var_19_3.clickAction = var_19_7
			else
				var_19_3.itemId = 0
				var_19_3.noTypeImage = true
				var_19_3.clickAction = nil
			end

			local var_19_8 = figure.createHeader(var_19_3)

			var_19_8:setPosition(var_0_9[var_19_1])
			arg_19_0.itemLayer:addChild(var_19_8)

			if var_19_4 then
				var_19_8.itemId = var_19_4
			end

			table.insert(var_0_11, var_19_8)
		end
	end
end

function var_0_14.showItemDetail(arg_21_0, arg_21_1)
	if arg_21_1 == nil then
		return
	end

	local var_21_0 = arg_21_0:convertPosition(var_0_9[arg_21_1.pos])
	local var_21_1 = arg_21_0.equipRefineLayer:addGridEquip(arg_21_1)

	if var_21_1 == nil then
		return
	end

	local var_21_2 = arg_21_1.Type == ItemType.eEquip and arg_21_1.detail.equipUserId or arg_21_1.ID
	local var_21_3 = arg_21_1.Type == ItemType.eSoul and BaseHeros[BaseSouls[arg_21_1.ID].figureId].soulCount or 1

	table.insert(var_0_8, {
		ID = var_21_2,
		Type = arg_21_1.Type,
		Count = var_21_3
	})
	arg_21_0:refreshCurrentList()
	arg_21_0:sortCurrentList(arg_21_0.btnSort:getTag())
	var_0_13()

	if var_0_5 > var_0_4 then
		var_0_5 = var_0_4
	end

	arg_21_0:updateItemLayer()

	local var_21_4 = arg_21_0:createHeader(arg_21_1, var_21_0)
	local var_21_5 = CCArray:create()

	var_21_5:addObject(CCMoveTo:create(0.5, var_21_1))
	var_21_5:addObject(CCCallFunc:create(function()
		var_21_4:removeFromParentAndCleanup(true)
		arg_21_0.equipRefineLayer:showEquipNode(arg_21_1)
	end))
	var_21_4:runAction(CCSequence:create(var_21_5))
end

function var_0_14.sortButtonAction(arg_23_0, arg_23_1, arg_23_2)
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

function var_0_14.autoButtonAction(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0.equipRefineLayer:isItemFull() == true then
		showFlashNotice(string.lf("上仙，炼化炉已满，请立刻开始炼化吧~~"))

		return
	end

	if arg_24_0.equipRefineLayer:canRefineNow() == false then
		print("当前不能炼化")

		return
	end

	if arg_24_0.btnSort:getTag() == var_0_1.sortByQualityDown then
		var_0_5 = var_0_4

		arg_24_0:updateItemLayer()
	end

	local var_24_0 = arg_24_0.btnSort:getTag() == var_0_1.sortByQualityDown and true or false
	local var_24_1 = var_24_0 and table.nums(var_0_10) or 1

	while table.nums(var_0_10) > 0 do
		local var_24_2 = var_0_10[var_24_1]

		arg_24_0:showItemDetail(var_24_2)

		if arg_24_0.equipRefineLayer:isItemFull() == true then
			break
		end

		var_24_1 = var_24_0 and table.nums(var_0_10) or 1
	end

	if arg_24_0.equipRefineLayer:isItemFull() == false then
		showFlashNotice(string.lf("没有更多符合条件的物品了"))
	end
end

function var_0_14.refreshCurrentList(arg_25_0)
	var_0_10 = {}

	if var_0_6 == var_0_0.eButtonHero then
		for iter_25_0, iter_25_1 in pairs(Player:getNotInTeamOwnedHeros()) do
			local var_25_0 = BaseHeros[iter_25_1.heroId]

			if arg_25_0:isInRefineList(iter_25_1.heroId, ItemType.eHero) == false then
				local var_25_1 = {
					ID = iter_25_1.heroId,
					Type = ItemType.eHero
				}

				var_25_1.Count = 1
				var_25_1.level = iter_25_1.level
				var_25_1.isInTeam = false
				var_25_1.detail = iter_25_1

				table.insert(var_0_10, var_25_1)
			end
		end
	elseif var_0_6 == var_0_0.eButtonSoul then
		for iter_25_2, iter_25_3 in pairs(Player.bag) do
			if iter_25_3.Type == ItemType.eSoul then
				local var_25_2 = BaseHeros[BaseSouls[iter_25_3.ID].figureId]
				local var_25_3 = arg_25_0:getRefineItemCount(iter_25_3.ID, ItemType.eSoul)

				if iter_25_3.Count - var_25_3 >= var_25_2.soulCount then
					local var_25_4 = {
						ID = iter_25_3.ID,
						Type = ItemType.eSoul,
						Count = iter_25_3.Count - var_25_3
					}

					var_25_4.isInTeam = false

					table.insert(var_0_10, var_25_4)
				end
			end
		end
	elseif var_0_6 == var_0_0.eButtonEquipment then
		arg_25_0:requestEquipData()
	end
end

function var_0_14.sortCurrentList(arg_26_0, arg_26_1)
	if arg_26_1 == var_0_1.sortByQualityDown then
		table.sort(var_0_10, function(arg_27_0, arg_27_1)
			return GlobalSortCallback(arg_27_0, arg_27_1, GlobalSortTypes.sortByQualityDown)
		end)
	elseif arg_26_1 == var_0_1.sortByQualityUp then
		table.sort(var_0_10, function(arg_28_0, arg_28_1)
			return GlobalSortCallback(arg_28_0, arg_28_1, GlobalSortTypes.sortByQualityUp)
		end)
	elseif arg_26_1 == var_0_1.sortByLevelDown then
		table.sort(var_0_10, function(arg_29_0, arg_29_1)
			return GlobalSortCallback(arg_29_0, arg_29_1, GlobalSortTypes.sortByLevelDown)
		end)
	elseif arg_26_1 == var_0_1.sortByLevelUp then
		table.sort(var_0_10, function(arg_30_0, arg_30_1)
			return GlobalSortCallback(arg_30_0, arg_30_1, GlobalSortTypes.sortByLevelUp)
		end)
	end
end

function var_0_14.requestEquipData(arg_31_0)
	local function var_31_0(arg_32_0)
		var_0_10 = {}

		for iter_32_0, iter_32_1 in ipairs(arg_32_0) do
			if iter_32_1.isInTeam == 0 and arg_31_0:isInRefineList(iter_32_1.equipUserId, ItemType.eEquip) == false then
				local var_32_0 = {
					ID = iter_32_1.equipId,
					Type = ItemType.eEquip
				}

				var_32_0.Count = 1
				var_32_0.detail = iter_32_1

				table.insert(var_0_10, var_32_0)
			end
		end

		arg_31_0:sortCurrentList(var_0_1.sortByQualityDown)
		arg_31_0:updateItemLayer()
	end

	EquipHelper:getEquipList(EquipClassType.eEquipAll, var_31_0)
end

function var_0_14.convertPosition(arg_33_0, arg_33_1)
	return CCPoint(arg_33_1.x + 55, arg_33_1.y + 5)
end

function var_0_14.createHeader(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = {
		isName = false,
		count = 0,
		inTeam = false,
		noTypeImage = false,
		itemId = arg_34_1.ID,
		type = arg_34_1.Type
	}

	if arg_34_1.Type == ItemType.eHero or arg_34_1.Type == ItemType.eEquip then
		var_34_0.level = arg_34_1.detail.level
		var_34_0.equipPinJie = arg_34_1.detail.pinJie ~= nil and arg_34_1.detail.pinJie or nil
		var_34_0.equipGem = arg_34_1.detail ~= nil and arg_34_1.detail.gem or nil
	elseif arg_34_1.Type == ItemType.eSoul then
		var_34_0.count = BaseHeros[BaseSouls[arg_34_1.ID].figureId].soulCount
	elseif arg_34_1.Type == ItemType.eFragment then
		var_34_0.count = 1
	end

	local var_34_1 = figure.createHeader(var_34_0)

	var_34_1:setPosition(arg_34_2)
	arg_34_0.bgSprite:addChild(var_34_1, 1000)

	return var_34_1
end

function var_0_14.isInRefineList(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = false

	for iter_35_0 = table.nums(var_0_8), 1, -1 do
		local var_35_1 = var_0_8[iter_35_0]

		if var_35_1.ID == arg_35_1 and var_35_1.Type == arg_35_2 then
			var_35_0 = true

			break
		end
	end

	return var_35_0
end

function var_0_14.getRefineItemCount(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = 0

	for iter_36_0 = table.nums(var_0_8), 1, -1 do
		local var_36_1 = var_0_8[iter_36_0]

		if var_36_1.ID == arg_36_1 and var_36_1.Type == arg_36_2 then
			var_36_0 = var_36_0 + var_36_1.Count
		end
	end

	return var_36_0
end

return var_0_14
