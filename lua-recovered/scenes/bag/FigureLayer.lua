require("base.figure")
require("network.EnhanceRequest")

local var_0_0 = require("scenes.bag.EnhanceHeroLayer")
local var_0_1 = {
	eButtonSouls = 2,
	eButtonHeros = 1
}
local var_0_2 = {
	sortByQualityDown = 1,
	sortByLevelUp = 4,
	sortByQualityUp = 2,
	sortByCanRecruit = 6,
	sortByInTeam = 5,
	sortByLevelDown = 3
}
local var_0_3 = {
	[var_0_2.sortByQualityDown] = string.lf("品质降序"),
	[var_0_2.sortByQualityUp] = string.lf("品质升序"),
	[var_0_2.sortByLevelDown] = string.lf("等级降序"),
	[var_0_2.sortByLevelUp] = string.lf("等级升序"),
	[var_0_2.sortByInTeam] = string.lf("已上阵优先"),
	[var_0_2.sortByCanRecruit] = string.lf("可招募优先")
}
local var_0_4 = {
	tagPageHeroAttr = 1,
	tagPageSoulAttr = 3,
	tagPageNull = 0
}
local var_0_5 = 16
local var_0_6 = 1
local var_0_7 = 1
local var_0_8 = var_0_1.eButtonHeros
local var_0_9 = var_0_1.eButtonHeros
local var_0_10 = {}
local var_0_11 = {}
local var_0_12 = {}

local function var_0_13()
	var_0_10 = {}
	var_0_11 = {}
	var_0_12 = {}
	var_0_7 = 1
	var_0_8 = var_0_1.eButtonHeros
	var_0_9 = var_0_1.eButtonHeros

	for iter_1_0 = 1, 4 do
		for iter_1_1 = 1, 4 do
			var_0_10[(iter_1_0 - 1) * 4 + iter_1_1] = CCPoint(60 + 111 * (iter_1_1 - 1), 600 - 110 * iter_1_0)
		end
	end
end

local function var_0_14()
	local var_2_0 = table.nums(var_0_11)

	if var_2_0 <= var_0_5 then
		var_0_6 = 1
	else
		var_0_6 = math.ceil(var_2_0 / var_0_5)
	end
end

local var_0_15 = class("FigureLayer", function()
	return display.newLayer()
end)

function var_0_15.ctor(arg_4_0)
	var_0_13()
	arg_4_0:initNetworkRequest()

	local var_4_0 = CCScale9Sprite:create("ui/enhance/enhance_001.png")

	var_4_0:setPreferredSize(CCSize(450, 562))
	var_4_0:setAnchorPoint(CCPoint(0, 0))
	var_4_0:setPosition(CCPoint(55, 5))
	arg_4_0:addChild(var_4_0)

	arg_4_0.bgSprite = var_4_0

	arg_4_0:addTabButtons(var_4_0)
end

function var_0_15.initNetworkRequest(arg_5_0)
	local function var_5_0()
		local function var_6_0()
			arg_5_0:refreshCurrentList()
			arg_5_0:sortCurrentList(arg_5_0.btnSort:getTag())
			arg_5_0:updateItemLayer()
		end

		local var_6_1 = arg_5_0.autoRecruitRequest.restable

		if table.nums(var_6_1.Reward) == 0 then
			return
		end

		local var_6_2 = require("scenes.enhance.DlgResultLayer").new({
			titleText = string.lf("上仙，符合条件的魂魄已招募，请收取主将"),
			rewardList = var_6_1.Reward,
			closeCallback = var_6_0
		})

		CCDirector:sharedDirector():getRunningScene():addChild(var_6_2, DefaultZOrder.ePopupLayer)
	end

	arg_5_0.autoRecruitRequest = AutoRecruitRequest:new()

	arg_5_0.autoRecruitRequest:setResponseNormalHandler(var_5_0)
end

function var_0_15.addTabButtons(arg_8_0, arg_8_1)
	local var_8_0 = {
		{
			isDefault = true,
			y = 490,
			tag = var_0_1.eButtonHeros,
			titleText = string.lf("主\n将")
		},
		{
			isDefault = false,
			y = 370,
			tag = var_0_1.eButtonSouls,
			titleText = string.lf("主\n将\n魂")
		}
	}

	local function var_8_1(arg_9_0)
		var_0_8 = arg_9_0
		var_0_7 = 1

		if var_0_8 == var_0_1.eButtonHeros then
			arg_8_0.btnAuto:setVisible(false)
			arg_8_0.btnSort:setPosition(arg_8_0.parentSize.width / 2, 20)
		else
			arg_8_0.btnSort:setPosition(arg_8_0.parentSize.width / 2 + 100, 20)
			arg_8_0.btnAuto:setVisible(true)
		end

		local var_9_0 = var_0_8 == var_0_1.eButtonHeros and var_0_2.sortByInTeam or var_0_2.sortByCanRecruit

		arg_8_0:setButtonTag(var_9_0)
		arg_8_0:refreshCurrentList()
		arg_8_0:sortCurrentList(var_9_0)
		arg_8_0:updateItemLayer()
	end

	local function var_8_2(arg_10_0)
		var_0_9 = arg_10_0

		if var_0_8 > var_0_9 then
			arg_8_0.pageLayer:moveVertical(false, true)
		elseif var_0_8 < var_0_9 then
			arg_8_0.pageLayer:moveVertical(true, true)
		end

		var_8_1(arg_10_0)
	end

	local function var_8_3(arg_11_0, arg_11_1)
		arg_8_0:addSliderLayer(arg_11_0, arg_11_1)
		arg_8_0:addInfoFooter(arg_11_0)
		var_8_1(arg_11_1)
	end

	arg_8_0.tabLayer = require("scenes.TabLayer").new({
		isVert = true,
		selectedImage = "ui/common/common_036.png",
		normalImage = "ui/common/common_037.png",
		size = CCSize(450, 562),
		point = CCPoint(0, 0),
		labelAnchorPoint = ccp(0.3, 0.5),
		config = var_8_0,
		cellHandler = var_8_3,
		changedHandler = var_8_2
	})

	arg_8_1:addChild(arg_8_0.tabLayer)

	local var_8_4 = arg_8_0.tabLayer:getTabItems()

	for iter_8_0, iter_8_1 in pairs(var_8_4) do
		if iter_8_1:getTag() == var_0_1.eButtonSouls then
			arg_8_0:addButtonAutoActionShow(iter_8_1, {
				eventName = PalyerEvents.eHeroSoulCanRecruit,
				actionShowFunc = function()
					return Player.isHeroSoulCanRecruit
				end
			})
		end
	end
end

function var_0_15.addSliderLayer(arg_13_0, arg_13_1, arg_13_2)
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

function var_0_15.pageVert(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2 then
		var_0_8 = var_0_9
	else
		local var_14_0 = var_0_8

		if arg_14_1 then
			var_0_8 = var_0_8 + 1
		else
			var_0_8 = var_0_8 - 1
		end

		arg_14_0.tabLayer:reloadLayer(var_0_8)
	end
end

function var_0_15.pageHori(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_2 then
		-- block empty
	else
		if arg_15_1 then
			var_0_7 = var_0_7 - 1
		else
			var_0_7 = var_0_7 + 1
		end

		arg_15_0:updateItemLayer()
	end
end

function var_0_15.limiteVert(arg_16_0, arg_16_1)
	if arg_16_1 == true and var_0_8 >= table.nums(var_0_1) then
		return false
	elseif arg_16_1 == false and var_0_8 <= 1 then
		return false
	else
		return true
	end
end

function var_0_15.limiteHori(arg_17_0, arg_17_1)
	if arg_17_1 == false and var_0_7 >= var_0_6 then
		return false
	elseif arg_17_1 and var_0_7 <= 1 then
		return false
	else
		return true
	end
end

function var_0_15.addInfoFooter(arg_18_0, arg_18_1)
	arg_18_0.btnAuto = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		highlightedImage = "ui/common/common_019.png",
		text = string.lf("一键招募"),
		textColor = ColorTable.eTitleButton_Normal2,
		fontSize = ColorTable.eTitleButton_FontSize2,
		anchorPoint = CCPoint(0.5, 0),
		position = CCPoint(arg_18_0.parentSize.width / 2 - 100, 20),
		clickAction = handler(arg_18_0, arg_18_0.autoButtonAction)
	})

	arg_18_1:addChild(arg_18_0.btnAuto)

	arg_18_0.btnSort = ui.newControlButton({
		text = "",
		normalImage = "ui/common/common_019.png",
		highlightedImage = "ui/common/common_019.png",
		textColor = ColorTable.eTitleButton_Normal2,
		fontSize = ColorTable.eTitleButton_FontSize2,
		anchorPoint = CCPoint(0.5, 0),
		position = CCPoint(arg_18_0.parentSize.width / 2 + 100, 20),
		clickAction = handler(arg_18_0, arg_18_0.sortButtonAction)
	})

	arg_18_0:setButtonTag(var_0_8 == var_0_1.eButtonHeros and var_0_2.sortByInTeam or var_0_2.sortByCanRecruit)
	arg_18_1:addChild(arg_18_0.btnSort)

	arg_18_0.pageIndicator = require("scenes.PageIndicator").new({
		positionY = 90,
		pageSpace = 10,
		pageCount = var_0_6,
		pageCurrent = var_0_7,
		pageWidth = arg_18_0.parentSize.width
	})

	arg_18_1:addChild(arg_18_0.pageIndicator)
end

function var_0_15.addSelectedFlag(arg_19_0, arg_19_1)
	if arg_19_0.itemLayer.selected_bg == nil then
		arg_19_0.itemLayer.selected_bg = CCSprite:create("ui/common/bg_choosed_cube.png")

		arg_19_0.itemLayer:addChild(arg_19_0.itemLayer.selected_bg, -1)
	else
		arg_19_0.itemLayer.selected_bg:setTexture(CCTextureCache:sharedTextureCache():addImage("ui/common/bg_choosed_cube.png"))
	end

	arg_19_0.itemLayer.selected_bg:setPosition(arg_19_1)
end

function var_0_15.updateItemLayer(arg_20_0)
	local var_20_0 = table.nums(var_0_11)

	for iter_20_0, iter_20_1 in pairs(var_0_12) do
		iter_20_1:removeFromParentAndCleanup(true)
	end

	var_0_12 = {}

	var_0_14()
	arg_20_0.pageIndicator:updateIndicator(var_0_6, var_0_7)

	if arg_20_0.itemLayer.selected_bg then
		arg_20_0.itemLayer.selected_bg:removeFromParentAndCleanup(true)

		arg_20_0.itemLayer.selected_bg = nil
	end

	for iter_20_2 = 1, 4 do
		for iter_20_3 = 1, 4 do
			local var_20_1 = (iter_20_2 - 1) * 4 + iter_20_3
			local var_20_2 = (var_0_7 - 1) * var_0_5 + var_20_1
			local var_20_3 = {
				itemId = -1,
				isName = false,
				count = 0,
				inTeam = false,
				noTypeImage = false,
				type = ItemType.eHero
			}
			local var_20_4
			local var_20_5

			if var_20_2 <= var_20_0 then
				local var_20_6 = var_0_11[var_20_2]

				var_20_4 = var_20_6.ID
				var_20_6.pos = var_20_1

				local function var_20_7()
					arg_20_0:addSelectedFlag(var_0_10[var_20_1])
					arg_20_0:showItemDetail(var_20_6)
				end

				if var_0_8 == var_0_1.eButtonSouls then
					local var_20_8 = false
					local var_20_9 = BaseSouls[var_20_6.ID].figureId

					for iter_20_4, iter_20_5 in pairs(Player.ownedHeros) do
						if iter_20_5.heroId == var_20_9 then
							var_20_8 = true

							break
						end
					end

					local var_20_10 = BaseHeros[var_20_9].soulCount

					var_20_3.recruitEnabled = var_20_8 == false and var_20_10 <= var_20_6.Count
				end

				if var_20_6.Count > 1 then
					var_20_3.count = var_20_6.Count
				end

				var_20_3.itemId = var_20_6.ID
				var_20_3.type = var_20_6.Type
				var_20_3.level = var_20_6.level or var_20_6.detail and var_20_6.detail.level
				var_20_3.inTeam = var_20_6.isInTeam ~= nil and var_20_6.isInTeam or false

				if var_20_6.Type == ItemType.eHero then
					var_20_3.inParternTeam = Player:isHeroInPartnerTeam(var_20_6.ID)
				end

				var_20_3.clickAction = var_20_7

				if var_20_1 == 1 then
					var_20_7()
				end
			else
				var_20_3.itemId = 0
				var_20_3.noTypeImage = true
				var_20_3.clickAction = nil
			end

			local var_20_11 = figure.createHeader(var_20_3)

			var_20_11:setPosition(var_0_10[var_20_1])
			arg_20_0.itemLayer:addChild(var_20_11)

			if var_20_4 then
				var_20_11.itemId = var_20_4
			end

			table.insert(var_0_12, var_20_11)
		end
	end

	if var_20_0 == 0 then
		arg_20_0:showItemDetail(nil)
	end
end

function var_0_15.showItemDetail(arg_22_0, arg_22_1)
	if arg_22_1 == nil then
		arg_22_0:showTypeLayer(var_0_4.tagPageNull, nil)

		return
	end

	if var_0_8 == var_0_1.eButtonHeros then
		arg_22_0:showTypeLayer(var_0_4.tagPageHeroAttr, arg_22_1.ID)
	elseif var_0_8 == var_0_1.eButtonSouls then
		arg_22_0:showTypeLayer(var_0_4.tagPageSoulAttr, arg_22_1)
	end
end

function var_0_15.autoButtonAction(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.autoRecruitRequest:request()
end

function var_0_15.sortButtonAction(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = tolua.cast(arg_24_2, "CCControlButton"):getTag()

	if var_0_8 == var_0_1.eButtonHeros then
		if var_24_0 == var_0_2.sortByInTeam then
			arg_24_0:setButtonTag(var_0_2.sortByQualityDown)
			arg_24_0:sortCurrentList(var_0_2.sortByQualityDown)
		elseif var_24_0 == var_0_2.sortByQualityDown then
			arg_24_0:setButtonTag(var_0_2.sortByQualityUp)
			arg_24_0:sortCurrentList(var_0_2.sortByQualityUp)
		elseif var_24_0 == var_0_2.sortByQualityUp then
			arg_24_0:setButtonTag(var_0_2.sortByLevelDown)
			arg_24_0:sortCurrentList(var_0_2.sortByLevelDown)
		elseif var_24_0 == var_0_2.sortByLevelDown then
			arg_24_0:setButtonTag(var_0_2.sortByLevelUp)
			arg_24_0:sortCurrentList(var_0_2.sortByLevelUp)
		elseif var_24_0 == var_0_2.sortByLevelUp then
			arg_24_0:setButtonTag(var_0_2.sortByInTeam)
			arg_24_0:sortCurrentList(var_0_2.sortByInTeam)
		end
	elseif var_0_8 == var_0_1.eButtonSouls then
		if var_24_0 == var_0_2.sortByCanRecruit then
			arg_24_0:setButtonTag(var_0_2.sortByQualityDown)
			arg_24_0:sortCurrentList(var_0_2.sortByQualityDown)
		elseif var_24_0 == var_0_2.sortByQualityDown then
			arg_24_0:setButtonTag(var_0_2.sortByQualityUp)
			arg_24_0:sortCurrentList(var_0_2.sortByQualityUp)
		elseif var_24_0 == var_0_2.sortByQualityUp then
			arg_24_0:setButtonTag(var_0_2.sortByCanRecruit)
			arg_24_0:sortCurrentList(var_0_2.sortByCanRecruit)
		end
	end

	var_0_7 = 1

	arg_24_0:updateItemLayer()
end

function var_0_15.refreshCurrentList(arg_25_0)
	var_0_11 = {}

	local function var_25_0()
		local var_26_0 = Player.ownedHeros

		for iter_26_0, iter_26_1 in pairs(var_26_0) do
			local var_26_1 = {
				ID = iter_26_1.heroId,
				Type = ItemType.eHero
			}

			var_26_1.Count = 1
			var_26_1.level = iter_26_1.level
			var_26_1.isInTeam = iter_26_1.isInTeam
			var_26_1.detail = iter_26_1

			table.insert(var_0_11, var_26_1)
		end
	end

	local function var_25_1()
		for iter_27_0, iter_27_1 in pairs(Player.bag) do
			if iter_27_1.Type == ItemType.eSoul then
				table.insert(var_0_11, iter_27_1)
			end
		end
	end

	if var_0_8 == var_0_1.eButtonHeros then
		var_25_0()
	elseif var_0_8 == var_0_1.eButtonSouls then
		var_25_1()
	end
end

function var_0_15.sortCurrentList(arg_28_0, arg_28_1)
	if arg_28_1 == var_0_2.sortByQualityDown then
		table.sort(var_0_11, function(arg_29_0, arg_29_1)
			return GlobalSortCallback(arg_29_0, arg_29_1, GlobalSortTypes.sortByQualityDown)
		end)
	elseif arg_28_1 == var_0_2.sortByQualityUp then
		table.sort(var_0_11, function(arg_30_0, arg_30_1)
			return GlobalSortCallback(arg_30_0, arg_30_1, GlobalSortTypes.sortByQualityUp)
		end)
	elseif arg_28_1 == var_0_2.sortByLevelDown then
		table.sort(var_0_11, function(arg_31_0, arg_31_1)
			return GlobalSortCallback(arg_31_0, arg_31_1, GlobalSortTypes.sortByLevelDown)
		end)
	elseif arg_28_1 == var_0_2.sortByLevelUp then
		table.sort(var_0_11, function(arg_32_0, arg_32_1)
			return GlobalSortCallback(arg_32_0, arg_32_1, GlobalSortTypes.sortByLevelUp)
		end)
	elseif arg_28_1 == var_0_2.sortByInTeam then
		table.sort(var_0_11, function(arg_33_0, arg_33_1)
			return GlobalSortCallback(arg_33_0, arg_33_1, GlobalSortTypes.sortByInTeam)
		end)
	elseif arg_28_1 == var_0_2.sortByCanRecruit then
		table.sort(var_0_11, function(arg_34_0, arg_34_1)
			return GlobalSortCallback(arg_34_0, arg_34_1, GlobalSortTypes.sortByRecruit)
		end)
	end
end

function var_0_15.setButtonTag(arg_35_0, arg_35_1)
	arg_35_0.btnSort:setTag(arg_35_1)
	arg_35_0.btnSort:setTitleForState(CCString:create(var_0_3[arg_35_1]), CCControlStateNormal)
end

function var_0_15.showTypeLayer(arg_36_0, arg_36_1, arg_36_2)
	arg_36_0.curShowLayerTag = arg_36_0.curShowLayerTag or var_0_4.tagPageHeroAttr

	local function var_36_0(arg_37_0, arg_37_1)
		if arg_37_0 then
			arg_37_0:setVisible(arg_37_1)
		end
	end

	local function var_36_1(arg_38_0)
		local var_38_0 = Player.ownedHeros

		for iter_38_0, iter_38_1 in pairs(var_38_0) do
			if iter_38_1.heroId == arg_38_0.ID then
				arg_38_0.detail = iter_38_1

				break
			end
		end
	end

	local function var_36_2(arg_39_0)
		local var_39_0

		for iter_39_0, iter_39_1 in pairs(var_0_11) do
			if iter_39_1.ID == arg_39_0 then
				var_39_0 = iter_39_1.detail
			end
		end

		return var_39_0
	end

	local function var_36_3()
		if arg_36_0.nullPageLayer == nil then
			arg_36_0.nullPageLayer = CCScale9Sprite:create("ui/team/team_002.png")

			arg_36_0.nullPageLayer:setPreferredSize(CCSize(444, 559))
			arg_36_0.nullPageLayer:setAnchorPoint(CCPoint(0, 0))
			arg_36_0.nullPageLayer:setPosition(451, 0)
			arg_36_0.bgSprite:addChild(arg_36_0.nullPageLayer)
		end

		var_36_0(arg_36_0.heroAttrLayer, false)
		var_36_0(arg_36_0.soulAttrLayer, false)
		var_36_0(arg_36_0.nullPageLayer, true)
	end

	local function var_36_4(arg_41_0)
		local var_41_0 = true

		for iter_41_0, iter_41_1 in pairs(var_0_11) do
			if iter_41_1.ID == arg_41_0 then
				var_36_1(iter_41_1)

				var_41_0 = false
			end
		end

		if var_41_0 == true then
			arg_36_0:refreshCurrentList()
			arg_36_0:updateItemLayer()
		else
			arg_36_0.heroAttrLayer:refreshHeroItem({
				heroItem = var_36_2(arg_36_2),
				callback = var_36_4
			})
		end
	end

	if arg_36_1 == var_0_4.tagPageHeroAttr then
		if arg_36_0.heroAttrLayer == nil then
			arg_36_0.heroAttrLayer = var_0_0.new({
				heroItem = var_36_2(arg_36_2),
				callback = var_36_4,
				pagesType = var_0_0.ePagesBattle
			})

			arg_36_0.heroAttrLayer:setPosition(-52, -8)
			arg_36_0.bgSprite:addChild(arg_36_0.heroAttrLayer)
		else
			arg_36_0.heroAttrLayer:refreshHeroItem({
				heroItem = var_36_2(arg_36_2),
				callback = var_36_4
			})
		end

		var_36_0(arg_36_0.nullPageLayer, false)
		var_36_0(arg_36_0.heroAttrLayer, true)
		var_36_0(arg_36_0.soulAttrLayer, false)
	elseif arg_36_1 == var_0_4.tagPageSoulAttr then
		function arg_36_2.callback()
			arg_36_0:refreshCurrentList()
			arg_36_0:sortCurrentList(arg_36_0.btnSort:getTag())
			arg_36_0:updateItemLayer()
		end

		if arg_36_0.soulAttrLayer == nil then
			arg_36_0.soulAttrLayer = require("scenes.bag.SoulEnhanceInfoLayer").new(arg_36_2)

			arg_36_0.soulAttrLayer:setPosition(-55, -5)
			arg_36_0.bgSprite:addChild(arg_36_0.soulAttrLayer)
		else
			arg_36_0.soulAttrLayer:refreshLayer(arg_36_2)
		end

		var_36_0(arg_36_0.nullPageLayer, false)
		var_36_0(arg_36_0.heroAttrLayer, false)
		var_36_0(arg_36_0.soulAttrLayer, true)
	elseif arg_36_1 == var_0_4.tagPageNull then
		var_36_3()
	end

	arg_36_0.curShowLayerTag = arg_36_1
end

function var_0_15.addButtonAutoActionShow(arg_43_0, arg_43_1, arg_43_2)
	if arg_43_2.actionShowFunc then
		local var_43_0 = arg_43_1:getPreferredSize()
		local var_43_1 = ui.createRedPoint({
			scale = 0.7,
			parent = arg_43_1,
			position = ccp(var_43_0.width * 0.9, var_43_0.height * 0.9)
		})

		var_43_1:setVisible(arg_43_2.actionShowFunc())
		addObserverToNode(var_43_1, function()
			var_43_1:setVisible(arg_43_2.actionShowFunc())
		end, {
			arg_43_2.eventName
		})
	end
end

return var_0_15
