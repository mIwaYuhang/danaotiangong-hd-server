require("base.figure")
require("network.EnhanceRequest")

local var_0_0 = {
	eButtonEquipment = 1,
	eButtonFragment = 2
}
local var_0_1 = {
	sortByQualityDown = 1,
	sortByLevelUp = 4,
	sortByQualityUp = 2,
	sortByInTeam = 5,
	sortByCanMixture = 6,
	sortByLevelDown = 3
}
local var_0_2 = {
	[var_0_1.sortByQualityDown] = string.lf("品质降序"),
	[var_0_1.sortByQualityUp] = string.lf("品质升序"),
	[var_0_1.sortByLevelDown] = string.lf("等级降序"),
	[var_0_1.sortByLevelUp] = string.lf("等级升序"),
	[var_0_1.sortByInTeam] = string.lf("已上阵优先"),
	[var_0_1.sortByCanMixture] = string.lf("可合成优先")
}
local var_0_3 = {
	tagPageEquipAttr = 1,
	tagPageFragmentAttr = 2,
	tagPageNull = 0
}
local var_0_4 = 16
local var_0_5 = 1
local var_0_6 = 1
local var_0_7 = var_0_0.eButtonEquipment
local var_0_8 = var_0_0.eButtonEquipment
local var_0_9 = {}
local var_0_10 = {}
local var_0_11 = {}
local var_0_12 = 1
local var_0_13 = false
local var_0_14 = EquipClassType.eEquipAll

local function var_0_15()
	var_0_9 = {}
	var_0_10 = {}
	var_0_11 = {}
	var_0_6 = 1
	var_0_7 = var_0_0.eButtonEquipment
	var_0_8 = var_0_0.eButtonEquipment

	for iter_1_0 = 1, 4 do
		for iter_1_1 = 1, 4 do
			var_0_9[(iter_1_0 - 1) * 4 + iter_1_1] = CCPoint(60 + 111 * (iter_1_1 - 1), 600 - 110 * iter_1_0)
		end
	end
end

local function var_0_16()
	local var_2_0 = table.nums(var_0_10)

	if var_2_0 <= var_0_4 then
		var_0_5 = 1
	else
		var_0_5 = math.ceil(var_2_0 / var_0_4)
	end
end

local var_0_17 = class("EnhanceLayer", function()
	return display.newLayer()
end)

function var_0_17.ctor(arg_4_0, arg_4_1)
	arg_4_0.enhanceScene = arg_4_1.enhanceScene
	arg_4_0.from = arg_4_1.from

	var_0_15()
	arg_4_0:initNetworkRequest()

	local var_4_0 = CCScale9Sprite:create("ui/enhance/enhance_001.png")

	var_4_0:setPreferredSize(CCSize(450, 562))
	var_4_0:setAnchorPoint(CCPoint(0, 0))
	var_4_0:setPosition(CCPoint(55, 5))
	arg_4_0:addChild(var_4_0)

	arg_4_0.bgSprite = var_4_0

	arg_4_0:addTabButtons(var_4_0)
end

function var_0_17.initNetworkRequest(arg_5_0)
	local function var_5_0()
		local function var_6_0()
			arg_5_0:refreshCurrentList()
			arg_5_0:sortCurrentList(arg_5_0.btnSort:getTag())
			arg_5_0:updateItemLayer()
		end

		local var_6_1 = arg_5_0.autoMixtureRequest.restable

		if table.nums(var_6_1.Reward) == 0 then
			return
		end

		local var_6_2 = require("scenes.enhance.DlgResultLayer").new({
			titleText = string.lf("上仙，所有碎片已合成，请收取装备"),
			rewardList = var_6_1.Reward,
			closeCallback = var_6_0
		})

		CCDirector:sharedDirector():getRunningScene():addChild(var_6_2, DefaultZOrder.ePopupLayer)
	end

	arg_5_0.autoMixtureRequest = AutoMixtureRequest:new()

	arg_5_0.autoMixtureRequest:setResponseNormalHandler(var_5_0)
end

function var_0_17.addTabButtons(arg_8_0, arg_8_1)
	local var_8_0 = {
		{
			isDefault = true,
			y = 490,
			tag = var_0_0.eButtonEquipment,
			titleText = string.lf("装\n备")
		},
		{
			isDefault = false,
			y = 370,
			tag = var_0_0.eButtonFragment,
			titleText = string.lf("碎\n片")
		}
	}

	local function var_8_1(arg_9_0)
		var_0_7 = arg_9_0
		var_0_6 = 1

		if var_0_7 == var_0_0.eButtonEquipment then
			arg_8_0.btnAuto:setVisible(false)
			arg_8_0.btnSort:setPosition(arg_8_0.parentSize.width / 2, 20)
		else
			arg_8_0.btnSort:setPosition(arg_8_0.parentSize.width / 2 + 100, 20)
			arg_8_0.btnAuto:setVisible(true)
		end

		local var_9_0 = var_0_7 == var_0_0.eButtonEquipment and var_0_1.sortByInTeam or var_0_1.sortByCanMixture

		arg_8_0:setButtonTag(var_9_0)
		arg_8_0:refreshCurrentList()
		arg_8_0:sortCurrentList(var_9_0)
		arg_8_0:updateItemLayer()
	end

	local function var_8_2(arg_10_0)
		var_0_8 = arg_10_0

		if var_0_7 > var_0_8 then
			arg_8_0.pageLayer:moveVertical(false, true)
		elseif var_0_7 < var_0_8 then
			arg_8_0.pageLayer:moveVertical(true, true)
		end

		var_8_1(arg_10_0)

		if arg_10_0 == var_0_0.eButtonFragment then
			GuideLayer:removeGuideLayer(nil, TaskEntryType.eEntryTalismanFeed, 2)
			GuideLayer:removeGuideLayer(nil, TaskEntryType.eEntryTalismanRecast, 2)
			Player:setIsFragmentCanMixture(false)
		end
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
		if iter_8_1:getTag() == var_0_0.eButtonFragment then
			arg_8_0:addButtonAutoActionShow(iter_8_1, {
				eventName = PalyerEvents.eFragmentCanMixture,
				actionShowFunc = function()
					return Player.isFragmentCanMixture
				end
			})
		end
	end
end

function var_0_17.addSliderLayer(arg_13_0, arg_13_1, arg_13_2)
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

function var_0_17.pageVert(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2 then
		var_0_7 = var_0_8
	else
		local var_14_0 = var_0_7

		if arg_14_1 then
			var_0_7 = var_0_7 + 1
		else
			var_0_7 = var_0_7 - 1
		end

		arg_14_0.tabLayer:reloadLayer(var_0_7)
	end
end

function var_0_17.pageHori(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_2 then
		-- block empty
	else
		if arg_15_1 then
			var_0_6 = var_0_6 - 1
		else
			var_0_6 = var_0_6 + 1
		end

		if var_0_14 == EquipClassType.eEquipAll and #var_0_10 / var_0_4 == var_0_6 and var_0_13 == true then
			var_0_12 = var_0_12 + 1

			arg_15_0:requestEquipData()
		end

		arg_15_0:updateItemLayer()
	end
end

function var_0_17.limiteVert(arg_16_0, arg_16_1)
	if arg_16_1 == true and var_0_7 >= table.nums(var_0_0) then
		return false
	elseif arg_16_1 == false and var_0_7 <= 1 then
		return false
	else
		return true
	end
end

function var_0_17.limiteHori(arg_17_0, arg_17_1)
	if arg_17_1 == false and var_0_6 >= var_0_5 then
		return false
	elseif arg_17_1 and var_0_6 <= 1 then
		return false
	else
		return true
	end
end

function var_0_17.addInfoFooter(arg_18_0, arg_18_1)
	arg_18_0.btnAuto = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		highlightedImage = "ui/common/common_019.png",
		text = string.lf("一键合成"),
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

	arg_18_0:setButtonTag(var_0_7 == var_0_0.eButtonEquipment and var_0_1.sortByInTeam or var_0_1.sortByCanMixture)
	arg_18_1:addChild(arg_18_0.btnSort)

	arg_18_0.pageIndicator = require("scenes.PageIndicator").new({
		positionY = 90,
		pageSpace = 10,
		pageCount = var_0_5,
		pageCurrent = var_0_6,
		pageWidth = arg_18_0.parentSize.width
	})

	arg_18_1:addChild(arg_18_0.pageIndicator)
end

function var_0_17.addSelectedFlag(arg_19_0, arg_19_1)
	if arg_19_0.itemLayer.selected_bg == nil then
		arg_19_0.itemLayer.selected_bg = CCSprite:create("ui/common/bg_choosed_cube.png")

		arg_19_0.itemLayer:addChild(arg_19_0.itemLayer.selected_bg, -1)
	end

	arg_19_0.itemLayer.selected_bg:setPosition(arg_19_1)
end

function var_0_17.updateItemLayer(arg_20_0)
	local var_20_0 = table.nums(var_0_10)

	for iter_20_0, iter_20_1 in pairs(var_0_11) do
		iter_20_1:removeFromParentAndCleanup(true)
	end

	var_0_11 = {}

	var_0_16()
	arg_20_0.pageIndicator:updateIndicator(var_0_5, var_0_6)

	if arg_20_0.itemLayer.selected_bg then
		arg_20_0.itemLayer.selected_bg:removeFromParentAndCleanup(true)

		arg_20_0.itemLayer.selected_bg = nil
	end

	for iter_20_2 = 1, 4 do
		for iter_20_3 = 1, 4 do
			local var_20_1 = (iter_20_2 - 1) * 4 + iter_20_3
			local var_20_2 = (var_0_6 - 1) * var_0_4 + var_20_1
			local var_20_3 = {
				itemId = -1,
				isName = false,
				count = 0,
				inTeam = false,
				noTypeImage = false,
				type = ItemType.eEquip
			}
			local var_20_4
			local var_20_5

			if var_20_2 <= var_20_0 then
				local var_20_6 = var_0_10[var_20_2]

				var_20_6.pos = var_20_1

				local function var_20_7()
					arg_20_0:addSelectedFlag(var_0_9[var_20_1])
					arg_20_0:showItemDetail(var_20_6)
				end

				if var_20_6.detail and var_20_6.detail.pinJie then
					var_20_3.equipPinJie = var_20_6.detail.pinJie
				end

				if var_20_6.detail and var_20_6.detail.equipUserId then
					var_20_4 = var_20_6.detail.equipUserId
				else
					var_20_4 = var_20_6.ID
				end

				if var_0_7 == var_0_0.eButtonFragment then
					local var_20_8 = BaseFragments[var_20_6.ID]

					if var_20_6.Count >= var_20_8.exchangeCount then
						var_20_3.mixtureEnabled = true
					end
				elseif var_0_7 == var_0_0.eButtonEquipment then
					var_20_3.equipJieji = var_20_6.detail and var_20_6.detail.BreakthroughCount and var_20_6.detail.BreakthroughCount or 0
					var_20_3.equipGem = var_20_6.detail and var_20_6.detail.gem or nil
				end

				if var_20_6.Count > 1 then
					var_20_3.count = var_20_6.Count
				end

				var_20_3.itemId = var_20_6.ID
				var_20_3.type = var_20_6.Type
				var_20_3.level = var_20_6.level or var_20_6.detail and var_20_6.detail.level
				var_20_3.inTeam = var_20_6.isInTeam ~= nil and var_20_6.isInTeam or false
				var_20_3.clickAction = var_20_7

				if var_20_1 == 1 then
					var_20_7()
				end
			else
				var_20_3.itemId = 0
				var_20_3.noTypeImage = true
				var_20_3.clickAction = nil
			end

			local var_20_9 = figure.createHeader(var_20_3)

			var_20_9:setPosition(var_0_9[var_20_1])
			arg_20_0.itemLayer:addChild(var_20_9)

			if var_20_4 then
				var_20_9.itemId = var_20_4
			end

			table.insert(var_0_11, var_20_9)
		end
	end

	if var_20_0 == 0 then
		arg_20_0:showItemDetail(nil)
	end
end

function var_0_17.showItemDetail(arg_22_0, arg_22_1)
	if arg_22_1 == nil then
		arg_22_0:showTypeLayer(var_0_3.tagPageNull, nil)

		return
	end

	if var_0_7 == var_0_0.eButtonFragment then
		arg_22_0:showTypeLayer(var_0_3.tagPageFragmentAttr, arg_22_1.ID)
	else
		arg_22_0:showTypeLayer(var_0_3.tagPageEquipAttr, arg_22_1.detail)
	end
end

function var_0_17.autoButtonAction(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.autoMixtureRequest:request()
end

function var_0_17.sortButtonAction(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = tolua.cast(arg_24_2, "CCControlButton"):getTag()

	if var_0_7 == var_0_0.eButtonEquipment then
		if var_24_0 == var_0_1.sortByInTeam then
			arg_24_0:setButtonTag(var_0_1.sortByQualityDown)
			arg_24_0:sortCurrentList(var_0_1.sortByQualityDown)
		elseif var_24_0 == var_0_1.sortByQualityDown then
			arg_24_0:setButtonTag(var_0_1.sortByQualityUp)
			arg_24_0:sortCurrentList(var_0_1.sortByQualityUp)
		elseif var_24_0 == var_0_1.sortByQualityUp then
			arg_24_0:setButtonTag(var_0_1.sortByLevelDown)
			arg_24_0:sortCurrentList(var_0_1.sortByLevelDown)
		elseif var_24_0 == var_0_1.sortByLevelDown then
			arg_24_0:setButtonTag(var_0_1.sortByLevelUp)
			arg_24_0:sortCurrentList(var_0_1.sortByLevelUp)
		elseif var_24_0 == var_0_1.sortByLevelUp then
			arg_24_0:setButtonTag(var_0_1.sortByInTeam)
			arg_24_0:sortCurrentList(var_0_1.sortByInTeam)
		end
	elseif var_0_7 == var_0_0.eButtonFragment then
		if var_24_0 == var_0_1.sortByCanMixture then
			arg_24_0:setButtonTag(var_0_1.sortByQualityDown)
			arg_24_0:sortCurrentList(var_0_1.sortByQualityDown)
		elseif var_24_0 == var_0_1.sortByQualityDown then
			arg_24_0:setButtonTag(var_0_1.sortByQualityUp)
			arg_24_0:sortCurrentList(var_0_1.sortByQualityUp)
		elseif var_24_0 == var_0_1.sortByQualityUp then
			arg_24_0:setButtonTag(var_0_1.sortByCanMixture)
			arg_24_0:sortCurrentList(var_0_1.sortByCanMixture)
		end
	end

	var_0_6 = 1

	arg_24_0:updateItemLayer()
end

function var_0_17.refreshCurrentList(arg_25_0)
	var_0_10 = {}

	if var_0_7 == var_0_0.eButtonEquipment then
		var_0_14 = EquipClassType.eEquipAll

		arg_25_0:requestEquipData()
	elseif var_0_7 == var_0_0.eButtonFragment then
		for iter_25_0, iter_25_1 in pairs(Player.fragments) do
			local var_25_0 = {
				ID = iter_25_1.ID,
				Type = ItemType.eFragment,
				Count = iter_25_1.Count
			}

			var_25_0.isInTeam = false

			table.insert(var_0_10, var_25_0)
		end
	end
end

function var_0_17.sortCurrentList(arg_26_0, arg_26_1)
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
	elseif arg_26_1 == var_0_1.sortByInTeam then
		table.sort(var_0_10, function(arg_31_0, arg_31_1)
			return GlobalSortCallback(arg_31_0, arg_31_1, GlobalSortTypes.sortByInTeam)
		end)
	elseif arg_26_1 == var_0_1.sortByCanMixture then
		table.sort(var_0_10, function(arg_32_0, arg_32_1)
			return GlobalSortCallback(arg_32_0, arg_32_1, GlobalSortTypes.sortByMixture)
		end)
	end
end

function var_0_17.setButtonTag(arg_33_0, arg_33_1)
	arg_33_0.btnSort:setTag(arg_33_1)
	arg_33_0.btnSort:setTitleForState(CCString:create(var_0_2[arg_33_1]), CCControlStateNormal)
end

function var_0_17.showTypeLayer(arg_34_0, arg_34_1, arg_34_2)
	local function var_34_0(arg_35_0, arg_35_1)
		if arg_35_0 then
			arg_35_0:setVisible(arg_35_1)
		end
	end

	local function var_34_1()
		if arg_34_0.nullPageLayer == nil then
			arg_34_0.nullPageLayer = CCScale9Sprite:create("ui/team/team_002.png")

			arg_34_0.nullPageLayer:setPreferredSize(CCSize(444, 559))
			arg_34_0.nullPageLayer:setAnchorPoint(CCPoint(0, 0))
			arg_34_0.nullPageLayer:setPosition(451, 0)
			arg_34_0.bgSprite:addChild(arg_34_0.nullPageLayer)
		end

		var_34_0(arg_34_0.nullPageLayer, true)
		var_34_0(arg_34_0.equipAttrLayer, false)
		var_34_0(arg_34_0.fragmentAttrLayer, false)
	end

	if arg_34_1 == var_0_3.tagPageEquipAttr then
		local function var_34_2(arg_37_0, arg_37_1)
			if arg_37_1 ~= nil and arg_37_1 == true then
				arg_34_0:refreshCurrentList()
				arg_34_0:sortCurrentList(arg_34_0.btnSort:getTag())
				arg_34_0:updateItemLayer()

				local var_37_0

				for iter_37_0, iter_37_1 in pairs(var_0_10) do
					if iter_37_1.detail.equipUserId == arg_37_0.equipUserId then
						var_37_0 = iter_37_1

						break
					end
				end

				if var_37_0 ~= nil and var_37_0.pos ~= nil then
					arg_34_0:showItemDetail(var_37_0)
					arg_34_0:addSelectedFlag(var_0_9[var_37_0.pos])
				end
			else
				for iter_37_2, iter_37_3 in pairs(var_0_10) do
					if iter_37_3.detail.equipUserId == arg_37_0.equipUserId then
						iter_37_3.detail = arg_37_0

						break
					end
				end

				for iter_37_4, iter_37_5 in pairs(var_0_11) do
					if iter_37_5.itemId == arg_37_0.equipUserId then
						iter_37_5.pinjieSprite:setTexture(CCTextureCache:sharedTextureCache():addImage(getPinjieSmallImageName(arg_37_0.pinJie)))
						iter_37_5.levelNode.numLabel:setString(arg_37_0.level)
					end
				end

				arg_34_0.equipAttrLayer:refreshLayer({
					equipItem = arg_37_0
				})
			end
		end

		if arg_34_0.equipAttrLayer == nil then
			arg_34_0.equipAttrLayer = require("scenes.team.EquipEnhanceLayer").new({
				equipItem = arg_34_2,
				callback = var_34_2,
				size = CCSize(445, 510),
				from = arg_34_0.from,
				enhanceScene = arg_34_0.enhanceScene
			})

			arg_34_0.equipAttrLayer:setPosition(-3, -9)
			arg_34_0:addChild(arg_34_0.equipAttrLayer)
		else
			arg_34_0.equipAttrLayer:refreshLayer({
				equipItem = arg_34_2
			})
		end

		var_34_0(arg_34_0.nullPageLayer, false)
		var_34_0(arg_34_0.equipAttrLayer, true)
		var_34_0(arg_34_0.fragmentAttrLayer, false)
	elseif arg_34_1 == var_0_3.tagPageFragmentAttr then
		local function var_34_3(arg_38_0)
			arg_34_0:refreshCurrentList()
			arg_34_0:sortCurrentList(arg_34_0.btnSort:getTag())
			arg_34_0:updateItemLayer()

			local var_38_0

			for iter_38_0, iter_38_1 in pairs(var_0_10) do
				if iter_38_1.ID == arg_38_0.fragId then
					var_38_0 = iter_38_1

					break
				end
			end

			if var_38_0 ~= nil and var_38_0.pos ~= nil then
				arg_34_0:showItemDetail(var_38_0)
				arg_34_0:addSelectedFlag(var_0_9[var_38_0.pos])
			end
		end

		if arg_34_0.fragmentAttrLayer ~= nil then
			arg_34_0.fragmentAttrLayer:removeFromParentAndCleanup(true)

			arg_34_0.fragmentAttrLayer = nil
		end

		arg_34_0.fragmentAttrLayer = require("scenes.enhance.FragmentInfoLayer").new({
			fragId = arg_34_2,
			recruitCallback = var_34_3,
			saleCallback = var_34_3,
			size = CCSize(444, 559)
		})

		arg_34_0.fragmentAttrLayer:setPosition(-55, -5)
		arg_34_0.bgSprite:addChild(arg_34_0.fragmentAttrLayer)
		var_34_0(arg_34_0.nullPageLayer, false)
		var_34_0(arg_34_0.equipAttrLayer, false)
		var_34_0(arg_34_0.fragmentAttrLayer, true)
	elseif arg_34_1 == var_0_3.tagPageNull then
		var_34_1()
	end
end

function var_0_17.requestEquipData(arg_39_0)
	local function var_39_0(arg_40_0, arg_40_1)
		var_0_10 = {}
		var_0_13 = arg_40_1

		for iter_40_0, iter_40_1 in ipairs(arg_40_0) do
			local var_40_0 = {
				ID = iter_40_1.equipId,
				Type = ItemType.eEquip
			}

			var_40_0.Count = 1
			var_40_0.isInTeam = iter_40_1.isInTeam == 1
			var_40_0.detail = iter_40_1

			table.insert(var_0_10, var_40_0)
		end

		arg_39_0:sortCurrentList(arg_39_0.btnSort:getTag())
		arg_39_0:updateItemLayer()
	end

	EquipHelper:getEquipList(var_0_14, var_39_0)
end

function var_0_17.addButtonAutoActionShow(arg_41_0, arg_41_1, arg_41_2)
	if arg_41_2.actionShowFunc then
		local var_41_0 = arg_41_1:getPreferredSize()
		local var_41_1 = ui.createRedPoint({
			scale = 0.7,
			parent = arg_41_1,
			position = ccp(var_41_0.width * 0.9, var_41_0.height * 0.9)
		})

		var_41_1:setVisible(arg_41_2.actionShowFunc())
		addObserverToNode(var_41_1, function()
			var_41_1:setVisible(arg_41_2.actionShowFunc())
		end, {
			arg_41_2.eventName
		})
	end
end

return var_0_17
