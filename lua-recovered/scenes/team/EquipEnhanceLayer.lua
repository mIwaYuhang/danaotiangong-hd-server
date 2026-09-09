require("base.functions")
require("scenes.enhance.RefineScene")
require("scenes.team.DlgEquipFeedLayer")
require("data.MineralHelper")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = require("scenes.ProgressBar")
local var_0_2 = require("scenes.toollayer.ctrl")
local var_0_3 = class("EquipEnhanceLayer", function()
	return display.newLayer()
end)
local var_0_4
local var_0_5
local var_0_6
local var_0_7
local var_0_8 = {}
local var_0_9 = {}
local var_0_10 = {}
local var_0_11 = false
local var_0_12 = {
	tagPageInherit = 2,
	tagPageInlay = 3,
	tagPageEnhance = 1
}

local function var_0_13(arg_2_0)
	if arg_2_0 == BattleAttrsType.eMingZhong or arg_2_0 == BattleAttrsType.eShanBi or arg_2_0 == BattleAttrsType.eBaoJi or arg_2_0 == BattleAttrsType.eRenXing or arg_2_0 == BattleAttrsType.ePoJi or arg_2_0 == BattleAttrsType.eGeDang then
		return false
	end

	return true
end

local function var_0_14(arg_3_0)
	if arg_3_0 == "health" then
		return string.lf("生命")
	elseif arg_3_0 == "speed" then
		return string.lf("速度")
	elseif arg_3_0 == "normalattack" then
		return string.lf("普攻")
	elseif arg_3_0 == "normaldefense" then
		return string.lf("普防")
	elseif arg_3_0 == "skillattack" then
		return string.lf("法攻")
	elseif arg_3_0 == "skilldefense" then
		return string.lf("法防")
	else
		return nil
	end
end

function var_0_3.ctor(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.size or CCSize(445, 510)

	arg_4_0.enhanceScene = arg_4_1.enhanceScene
	arg_4_0.nodeSize = var_4_0

	if arg_4_1.from == "equipscene" then
		arg_4_0.enterFromEquip = true
	else
		arg_4_0.enterFromEquip = false
	end

	arg_4_0.showEquipPackageButton = arg_4_1.showEquipPackageButton
	arg_4_0.showEquipPackageButtonCallback = arg_4_1.showEquipPackageButtonCallback
	arg_4_0.background = CCLayerColor:create(ccc4(0, 0, 0, 0))

	arg_4_0.background:setPosition(509, 12)
	arg_4_0.background:setContentSize(var_4_0)
	arg_4_0:addChild(arg_4_0.background)
	EquipHelper:getEquipList(EquipClassType.eEquipAll, function()
		return
	end)
	arg_4_0:initRequests()
	arg_4_0:refreshLayer(arg_4_1)
end

function var_0_3.refreshLayer(arg_6_0, arg_6_1)
	arg_6_0.background:removeAllChildrenWithCleanup(true)

	if arg_6_1.callback then
		var_0_7 = arg_6_1.callback
	end

	var_0_4 = arg_6_1.equipItem

	if var_0_4 == nil or var_0_4.equipId <= 0 then
		return
	end

	arg_6_0.curTeamHeroId = arg_6_1.heroId or 0
	arg_6_0.heroIndex = arg_6_1.curHeroIndex
	var_0_5 = BaseEquips[var_0_4.equipId]
	var_0_6 = {}

	arg_6_0:showTabButtons(arg_6_0.background)
end

function var_0_3.initRequests(arg_7_0)
	local function var_7_0()
		local var_8_0 = arg_7_0.equipEnhanceRequest.restable

		var_0_10 = var_8_0.Operator.AddLvs

		for iter_8_0, iter_8_1 in pairs(var_0_4) do
			var_0_8[iter_8_0] = iter_8_1
		end

		for iter_8_2, iter_8_3 in pairs(var_0_4) do
			var_0_4[iter_8_2] = var_8_0.Operator.Talisman[iter_8_2]
		end

		if var_0_7 then
			var_0_7(var_0_4)
		end

		local var_8_1 = Player:getTroMaxStep()

		if var_8_1 == NSStep.HuanZhuangbei then
			GuideLayer:saveTrioMaxStep(NSStep.DuanZao1, function()
				GuideLayer:showNewbieGuideLayer(nil, arg_7_0.enhanceScene.bg_far_Sprite, 25, function()
					arg_7_0.equipEnhanceRequest:request(var_0_4.equipUserId, 10)

					return true
				end)
			end)
		end

		if var_8_1 == NSStep.DuanZao1 then
			GuideLayer:saveTrioMaxStep(NSStep.DuanZao2, function()
				GuideLayer:showNewbieGuideLayer(nil, arg_7_0.enhanceScene.bg_far_Sprite, 29, function()
					game.enterHomeScene({})

					return true
				end)
			end)
		end
	end

	arg_7_0.equipEnhanceRequest = EquipEnhanceRequest:new()

	arg_7_0.equipEnhanceRequest:setResponseNormalHandler(var_7_0)

	local function var_7_1()
		var_0_11 = true

		local var_13_0 = arg_7_0.equipInheritRequest.restable

		for iter_13_0, iter_13_1 in pairs(var_0_4) do
			var_0_9[iter_13_0] = iter_13_1
		end

		for iter_13_2, iter_13_3 in pairs(var_0_4) do
			var_0_4[iter_13_2] = var_13_0.Talisman[iter_13_2]
		end

		if var_0_7 then
			var_0_7(var_0_4)
		end

		if not tolua.isnull(arg_7_0.inheritLayer) then
			arg_7_0.inheritLayer.refreshLockedState()
		end
	end

	arg_7_0.equipInheritRequest = EquipInheritRequest:new()

	arg_7_0.equipInheritRequest:setResponseNormalHandler(var_7_1)

	local function var_7_2()
		local var_14_0 = arg_7_0.equipLockInfoRequest.restable
		local var_14_1 = 0

		for iter_14_0, iter_14_1 in ipairs(var_14_0.lockQualifications or {}) do
			if var_14_1 < iter_14_1 then
				var_14_1 = iter_14_1
			end
		end

		local var_14_2 = {
			lockedPinJie = var_14_0.lockQualifications or {},
			lockCost = {
				[2] = var_14_0.lockCost[1],
				[3] = var_14_0.lockCost[2],
				[4] = var_14_0.lockCost[3]
			},
			recastCost = var_14_0.recastCost,
			maxLockedPinJie = var_14_1
		}

		EquipHelper:setInheritLockInfo(var_0_4.equipUserId, var_14_2)

		if not tolua.isnull(arg_7_0.inheritLayer) then
			arg_7_0.inheritLayer.refreshLockedState(true)
		end
	end

	arg_7_0.equipLockInfoRequest = EquipLockInfoRequest:new()

	arg_7_0.equipLockInfoRequest:setResponseNormalHandler(var_7_2)

	local function var_7_3()
		local var_15_0 = EquipHelper:getInheritLockInfo(var_0_4.equipUserId)

		table.insert(var_15_0.lockedPinJie, var_0_4.pinJie)

		var_15_0.maxLockedPinJie = var_0_4.pinJie

		if not tolua.isnull(arg_7_0.inheritLayer.mBtnLock) then
			arg_7_0.inheritLayer.refreshLockedState()
		end
	end

	arg_7_0.equipLockLevelRequest = EquipLockLevelRequest:new()

	arg_7_0.equipLockLevelRequest:setResponseNormalHandler(var_7_3)
end

function var_0_3.showTabButtons(arg_16_0, arg_16_1)
	local var_16_0 = true
	local var_16_1 = 80
	local var_16_2 = {}
	local var_16_3

	var_0_6, var_16_3 = getEquipAttrTypeList(var_0_4.equipId)

	local var_16_4 = 140

	if var_16_3 == true and Player.level >= GameFeaturesLevel[GameFeatures.eEquipInlay].level then
		var_16_4 = 280
	end

	var_16_2[1] = {
		isDefault = false,
		tag = var_0_12.tagPageEnhance,
		x = var_16_1,
		titleText = string.lf("锻造")
	}

	if Player.level >= GameFeaturesLevel[GameFeatures.eEquipInherit].level then
		var_16_2[2] = {
			isDefault = false,
			tag = var_0_12.tagPageInherit,
			x = var_16_1 + var_16_4,
			titleText = string.lf("重铸")
		}
	end

	if var_16_3 == true and Player.level >= GameFeaturesLevel[GameFeatures.eEquipInlay].level then
		var_16_2[3] = {
			isDefault = false,
			tag = var_0_12.tagPageInlay,
			x = var_16_1 + 140,
			titleText = string.lf("喂灵")
		}
	elseif arg_16_0.defaultTag == var_0_12.tagPageInlay then
		arg_16_0.defaultTag = 0
	end

	if arg_16_0.defaultTag and arg_16_0.defaultTag > 0 then
		for iter_16_0, iter_16_1 in pairs(var_16_2) do
			if iter_16_1.tag == arg_16_0.defaultTag then
				iter_16_1.isDefault = true
			end
		end

		arg_16_0.defaultTag = 0
	else
		var_16_2[1].isDefault = true
	end

	local function var_16_5(arg_17_0, arg_17_1)
		arg_16_0.defaultTag = arg_17_1

		if arg_17_1 == var_0_12.tagPageEnhance then
			arg_16_0:showPageEnhance(arg_17_0)
		elseif arg_17_1 == var_0_12.tagPageInherit then
			arg_16_0:showPageInherit(arg_17_0)
			GuideLayer:removeGuideLayer(nil, TaskEntryType.eEntryTalismanRecast, 2)
		elseif arg_17_1 == var_0_12.tagPageInlay then
			arg_16_0:showPageInlay(arg_17_0)
			GuideLayer:removeGuideLayer(nil, TaskEntryType.eEntryTalismanFeed, 2)
		end
	end

	local var_16_6 = arg_16_1:getContentSize()
	local var_16_7 = require("scenes.TabLayer").new({
		disabledImage = "ui/common/common_023_2.png",
		selectedImage = "ui/common/common_023.png",
		normalImage = "ui/common/common_022.png",
		size = var_16_6,
		point = CCPoint(0, 0),
		config = var_16_2,
		cellHandler = var_16_5
	})

	arg_16_1:addChild(var_16_7)

	local var_16_8 = var_16_7:getTabItems()

	for iter_16_2, iter_16_3 in pairs(var_16_8) do
		if iter_16_3:getTag() == var_0_12.tagPageInlay then
			if EquipHelper:equipCanFeed(var_0_4.equipId, var_0_4.equipUserId, var_0_4.level, var_0_4.BreakthroughCount) == true then
				local var_16_9 = iter_16_3:getPreferredSize()

				ui.createRedPoint({
					scale = 0.7,
					parent = iter_16_3,
					position = ccp(var_16_9.width * 0.85, var_16_9.height * 0.9)
				})
			end

			break
		end
	end
end

function var_0_3.showPageEnhance(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1:getContentSize()
	local var_18_1 = CCScale9Sprite:create("ui/team/team_002.png")

	var_18_1:setPosition(var_18_0.width / 2, var_18_0.height / 2 + 3)
	arg_18_1:addChild(var_18_1)

	local var_18_2 = figure.createHeader({
		isName = false,
		itemId = var_0_4.equipId,
		type = ItemType.eEquip,
		level = var_0_4.level,
		equipPinJie = var_0_4.pinJie,
		equipJieji = var_0_4.BreakthroughCount,
		equipGem = var_0_4.gem
	})

	var_18_2:setPosition(CCPoint(83, 420))
	arg_18_1:addChild(var_18_2)

	local var_18_3 = display.newScale9Sprite("ui/common/common_064_2.png", var_18_0.width / 2, 215, CCSize(430, 120))

	arg_18_1:addChild(var_18_3)

	local var_18_4 = var_18_3:getContentSize()
	local var_18_5 = display.newSprite("ui/common/common_049.png")

	var_18_5:align(display.CENTER, var_18_4.width / 2 - 25, var_18_4.height / 2)
	var_18_3:addChild(var_18_5)

	local var_18_6 = BaseEquips[var_0_4.equipId].quality
	local var_18_7 = 136
	local var_18_8 = 298
	local var_18_9 = var_0_2.newLabel({
		size = 25,
		outline = true,
		text = var_0_5.name,
		font = _FONT_DEFAULT,
		align = ui.TEXT_ALIGN_LEFT,
		color = getQualityColor(var_18_6)
	})

	var_18_9:setAnchorPoint(ccp(0, 0.5))
	var_18_9:setPosition(ccp(var_18_7, 451))
	arg_18_1:addChild(var_18_9)

	local var_18_10 = EquipTypeNames[var_0_5.equipType]

	if var_0_5.equipType == EquipType.eWeapon then
		var_18_10 = HeroProfessionNames[var_0_5.profession] .. var_18_10

		local var_18_11 = display.newSprite(getProfessionIconImageName(var_0_5.profession), var_18_8 - 23, 452)

		if IPlatform:instance():getConfig("Channel") == "ZSY_VN" then
			var_18_11:setVisible(false)
		end

		arg_18_1:addChild(var_18_11)
	end

	local var_18_12 = var_0_2.newLabel({
		size = 20,
		outline = true,
		text = var_18_10,
		font = _FONT_DEFAULT,
		align = ui.TEXT_ALIGN_LEFT,
		color = getQualityColor(var_18_6)
	})

	var_18_12:setAnchorPoint(ccp(0, 0.5))
	var_18_12:setPosition(ccp(var_18_8, 451))
	arg_18_1:addChild(var_18_12)

	if IPlatform:instance():getConfig("Channel") == "ZSY_VN" then
		var_18_9:setPosition(ccp(var_18_7, 481))
		var_18_12:setPosition(ccp(var_18_7, 451))
	end

	local var_18_13 = display.newSprite(getPinjieBigImageName(var_0_4.pinJie))

	var_18_13:align(display.BOTTOM_LEFT, 55, 334)
	arg_18_1:addChild(var_18_13)

	local var_18_14 = 408
	local var_18_15 = {
		CCPoint(var_18_7, var_18_14),
		CCPoint(var_18_8, var_18_14),
		CCPoint(var_18_7, var_18_14 - 26),
		CCPoint(var_18_8, var_18_14 - 26),
		CCPoint(var_18_7, var_18_14 - 52)
	}
	local var_18_16 = 0

	for iter_18_0, iter_18_1 in pairs(var_0_6) do
		local var_18_17 = var_0_13(iter_18_1) == true and ccc3(127, 32, 9) or ccc3(41, 16, 0)
		local var_18_18 = getBattleAttrWithStatus(var_0_4, iter_18_1, math.floor(attrStatus.attrCurValue))

		if var_18_18 > 0 then
			var_18_16 = var_18_16 + 1

			local var_18_19 = (var_18_16 - 1) % 2 == 0 and var_18_7 or var_18_8
			local var_18_20 = var_18_14 - math.floor((var_18_16 - 1) / 2) * 26

			addLabelWithColorSize(arg_18_1, BattleAttrsName[iter_18_1] .. ": " .. var_18_18, var_18_17, 20, CCPoint(0, 0), ccp(var_18_19, var_18_20))
		end
	end

	local var_18_21 = var_18_14 - math.floor((var_18_16 + 1) / 2) * 26
	local var_18_22 = 1

	for iter_18_2, iter_18_3 in pairs(var_0_6) do
		if var_0_13(iter_18_3) == true then
			local var_18_23 = getBattleAttrWithStatus(var_0_4, iter_18_3, math.floor(attrStatus.attrInitialValue))
			local var_18_24 = string.lf("初始%s: %d", BattleAttrsName[iter_18_3], math.floor(var_18_23))

			addLabelWithColorSize(arg_18_1, var_18_24, display.COLOR_BLACK, 20, CCPoint(0, 0), ccp(var_18_7, var_18_21))

			local var_18_25 = getBattleAttrWithStatus(var_0_4, iter_18_3, math.floor(attrStatus.attrGrowValue))
			local var_18_26 = string.lf("成长: %d", math.floor(var_18_25))

			addLabelWithColorSize(arg_18_1, var_18_26, display.COLOR_BLACK, 20, CCPoint(0, 0), ccp(var_18_8, var_18_21))

			var_18_21 = var_18_21 - 26
		end
	end

	if var_0_4.gem ~= nil then
		local var_18_27 = var_0_4.gem

		addLabelWithColorSize(arg_18_1, string.lf("已镶嵌:%s级%s  %s", var_18_27.level, BaseMineral[var_18_27.gemProtoID].name, MineralHelper:readGemAddValue(var_18_27)), ccc3(0, 0, 255), 18, CCPoint(0, 0), ccp(var_18_7, var_18_21))
	else
		addLabelWithColorSize(arg_18_1, string.lf("可镶嵌:%s", MineralHelper:getCanInlayType(var_0_5.equipType)), ccc3(0, 0, 255), 20, CCPoint(0, 0), ccp(var_18_7, var_18_21))
	end

	local var_18_28 = var_0_5.herosId
	local var_18_29 = ""
	local var_18_30 = false

	if table.getn(var_18_28) > 0 then
		local function var_18_31(arg_19_0)
			if arg_19_0 == arg_18_0.curTeamHeroId then
				return "#259623" .. BaseHeros[arg_19_0].name, true
			else
				return "#FF0000" .. BaseHeros[arg_19_0].name, false
			end
		end

		for iter_18_4, iter_18_5 in ipairs(var_18_28) do
			local var_18_32, var_18_33 = var_18_31(iter_18_5)

			if iter_18_4 == 1 then
				var_18_30 = var_18_33
				var_18_29 = var_18_29 .. var_18_32
			else
				var_18_29 = var_18_29 .. "、" .. var_18_32
			end
		end
	end

	local var_18_34 = string.len(var_18_29) > 0 and string.lf("专属: %s", var_18_29) or string.lf("专属: 无")
	local var_18_35 = var_18_30 and table.getn(var_18_28) == 1 and ccc3(37, 150, 35) or ccc3(255, 0, 0)

	addLabelWithColorSize(arg_18_1, var_18_34, var_18_35, 20, CCPoint(0, 0), ccp(42, 278))
	addLabelWithColorSize(arg_18_1, string.lf("当前属性"), ccc3(185, 181, 47), 20, CCPoint(0, 0), CCPoint(60, 235))
	addLabelWithColorSize(arg_18_1, string.lf("升级属性"), ccc3(185, 181, 47), 20, CCPoint(0, 0), CCPoint(235, 235))

	local var_18_36 = 205
	local var_18_37 = false
	local var_18_38 = ccc3(255, 237, 154)

	for iter_18_6, iter_18_7 in pairs(var_0_6) do
		if var_0_13(iter_18_7) == true then
			local var_18_39 = BattleAttrsName[iter_18_7]
			local var_18_40 = getBattleAttrWithStatus(var_0_4, iter_18_7, attrStatus.attrCurValue)
			local var_18_41 = var_18_40 + getBattleAttrWithStatus(var_0_4, iter_18_7, math.floor(attrStatus.attrGrowValue))

			addLabelWithColorSize(arg_18_1, var_18_39 .. "+" .. math.floor(var_18_40), var_18_38, 20, CCPoint(0, 0), CCPoint(60, var_18_36))
			addLabelWithColorSize(arg_18_1, var_18_39 .. "+" .. math.floor(var_18_41), var_18_38, 20, CCPoint(0, 0), CCPoint(235, var_18_36))

			if table.nums(var_0_8) > 0 then
				local var_18_42 = var_18_40 - getBattleAttrWithStatus(var_0_8, iter_18_7, attrStatus.attrCurValue)

				addLabelWithColorSize(arg_18_1, "+" .. var_18_42, ccc3(0, 255, 0), 20, CCPoint(0, 0), CCPoint(350, var_18_36))
			end

			var_18_36 = var_18_36 - 25
		end
	end

	if table.nums(var_0_8) > 0 then
		var_18_2:setLevel(var_0_4.level)

		local var_18_43 = "effectAni/ui_zhuangbeiqianghua.json"
		local var_18_44 = "effectAni/ui_zhuangbeiqianghua.atlas"
		local var_18_45 = CCSkeletonAnimation:createWithFile(var_18_43, var_18_44, Adapter.MinScale)

		var_18_45:setPosition(0, 0)
		var_18_2:addChild(var_18_45)
		var_18_45:setToSetupPose()
		var_18_45:setAnimation("animation", loop, 0)

		local var_18_46 = {
			"enhance_txt_005_1.png",
			"enhance_txt_005_2.png",
			"enhance_txt_005_3.png",
			"enhance_txt_005_4.png",
			"enhance_txt_005_5.png"
		}
		local var_18_47 = {}

		for iter_18_8, iter_18_9 in pairs(var_0_10) do
			if iter_18_9 == 1 then
				table.insert(var_18_47, {
					"uilocal/enhance/" .. var_18_46[iter_18_9]
				})
			elseif iter_18_9 > 1 and iter_18_9 <= 5 then
				table.insert(var_18_47, {
					"uilocal/enhance/enhance_txt_004.png",
					"uilocal/enhance/" .. var_18_46[iter_18_9]
				})
			end
		end

		if table.nums(var_18_47) > 0 then
			var_0_2.showSequeneImage({
				y = 140,
				parent = arg_18_1,
				x = var_18_0.width / 2,
				images = var_18_47,
				audio = ButtonAudio.equip_enhance
			})
		end

		var_0_8 = {}
		var_0_10 = {}
	end

	local function var_18_48(arg_20_0)
		if arg_20_0 == QualityType.ePurple then
			return 1.8
		elseif arg_20_0 == QualityType.eBlue then
			return 1
		elseif arg_20_0 == QualityType.eGreen then
			return 0.6
		elseif arg_20_0 == QualityType.eOrange then
			return 2.7
		else
			return 1
		end
	end

	local var_18_49 = math.round((math.pow(var_0_4.level * 0.6 + 12, 2.4) - 200) * var_18_48(var_18_6))

	addLabelWithColorSize(arg_18_1, string.lf("费用"), ccc3(41, 16, 0), 20, CCPoint(1, 0), CCPoint(var_18_0.width / 2 - 42, 103))

	local var_18_50 = createItemCountNode({
		type = ItemType.eCoin,
		value = var_18_49,
		color = ccc3(41, 16, 0)
	})

	var_18_50:setPosition(ccp(var_18_0.width / 2 - 19, 116))
	arg_18_1:addChild(var_18_50)

	local var_18_51 = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		text = string.lf("锻造"),
		textColor = ColorTable.eTitleButton_Normal,
		fontSize = ColorTable.eTitleButton_FontSize2,
		position = CCPoint(var_18_0.width / 2 - 100, 60),
		clickAction = function()
			if var_0_4.level >= Player.level * 3 then
				showFlashNotice(string.lf("装备等级不能超过玩家等级的3倍"))
			else
				arg_18_0.equipEnhanceRequest:request(var_0_4.equipUserId, 1)
			end
		end
	})

	arg_18_1:addChild(var_18_51)

	local var_18_52 = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		text = string.lf("锻造10次"),
		textColor = ColorTable.eTitleButton_Normal,
		fontSize = ColorTable.eTitleButton_FontSize2,
		position = CCPoint(var_18_0.width / 2 + 100, 60),
		clickAction = function()
			if var_0_4.level >= Player.level * 3 then
				showFlashNotice(string.lf("装备等级不能超过玩家等级的3倍"))
			else
				arg_18_0.equipEnhanceRequest:request(var_0_4.equipUserId, 10)
			end
		end
	})

	arg_18_1:addChild(var_18_52)

	if arg_18_0.showEquipPackageButton == true then
		local var_18_53 = ui.newControlButton({
			text = "",
			normalImage = "ui/team/team_075.png",
			textColor = ColorTable.eTitleButton_Normal,
			fontSize = ColorTable.eTitleButton_FontSize2,
			position = CCPoint(var_18_0.width / 2 + 170, 270),
			clickAction = function()
				local var_23_0 = BaseEquips[var_0_4.equipId].equipType

				arg_18_0.showEquipPackageButtonCallback(var_23_0)
			end
		})

		arg_18_1:addChild(var_18_53)
	end

	local var_18_54 = Player:getTroMaxStep()

	if var_18_54 == NSStep.HuanZhuangbei then
		GuideLayer:showNewbieGuideLayer(arg_18_0.enhanceScene, arg_18_0.enhanceScene.bg_far_Sprite, 24, function()
			arg_18_0.equipEnhanceRequest:request(var_0_4.equipUserId, 1)

			return true
		end)
	end

	if var_18_54 == NSStep.DuanZao1 then
		GuideLayer:showNewbieGuideLayer(arg_18_0.enhanceScene, arg_18_0.enhanceScene.bg_far_Sprite, 25, function()
			arg_18_0.equipEnhanceRequest:request(var_0_4.equipUserId, 10)

			return true
		end)
	end
end

function var_0_3.showPageInherit(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1:getContentSize()

	arg_26_0.inheritLayer = require("scenes.enhance.EquipInheritLayer").new({
		parent_size = var_26_0
	})

	arg_26_0.inheritLayer:setPosition(var_26_0.width / 2, var_26_0.height / 2 + 3.5)
	arg_26_1:addChild(arg_26_0.inheritLayer)

	local var_26_1 = false
	local var_26_2
	local var_26_3

	if var_0_9 then
		var_26_2, var_26_3 = var_0_9.pinJie, var_0_9.pinJieLevel
	end

	if var_0_9 == nil or var_0_4.equipUserId ~= var_0_9.equipUserId or var_0_11 == false then
		var_26_2, var_26_3 = nil
		var_26_1 = true
	end

	arg_26_0.inheritLayer:setProgressValue(var_0_4.pinJie, var_0_4.pinJieLevel, var_26_1, var_26_2, var_26_3)

	var_0_11 = false

	local var_26_4 = ui.newControlButton({
		disabledImage = "ui/common/common_080.png",
		normalImage = "ui/common/common_019.png",
		highlightedImage = "ui/common/common_019.png",
		text = string.lf("重铸"),
		fontSize = ColorTable.eTitleButton_FontSize2,
		textColor = ColorTable.eTitleButton_Normal2,
		position = CCPoint(var_26_0.width / 2 - 80, 50),
		clickAction = function()
			arg_26_0.equipInheritRequest:request(var_0_4.equipUserId, 1)
		end
	})

	arg_26_1:addChild(var_26_4)

	local var_26_5 = ui.newControlButton({
		disabledImage = "ui/common/common_080.png",
		normalImage = "ui/common/common_019.png",
		highlightedImage = "ui/common/common_019.png",
		text = string.lf("锁定品阶"),
		fontSize = ColorTable.eTitleButton_FontSize2,
		textColor = ColorTable.eTitleButton_Normal2,
		position = CCPoint(var_26_0.width / 2 + 80, 50),
		clickAction = function()
			arg_26_0:onLockBtnClicked()
		end
	})

	arg_26_1:addChild(var_26_5)

	arg_26_0.inheritLayer.mBtnLock = var_26_5

	if var_0_4.pinJie == 5 and var_0_4.pinJieLevel == 0 then
		var_26_4:setEnabled(false)
	end

	function arg_26_0.inheritLayer.lockPinJie(arg_29_0)
		local var_29_0 = {
			[2] = ccp(-135, 95),
			[3] = ccp(30, 225),
			[4] = ccp(130, 95)
		}

		if type(arg_26_0.inheritLayer.mLockIcon) == "table" then
			for iter_29_0, iter_29_1 in ipairs(arg_26_0.inheritLayer.mLockIcon) do
				if not tolua.isnull(iter_29_1) then
					iter_29_1:removeFromParent()
				end
			end
		end

		arg_26_0.inheritLayer.mLockIcon = {}

		for iter_29_2, iter_29_3 in ipairs(arg_29_0) do
			if iter_29_3 > 1 and iter_29_3 < 5 then
				local var_29_1 = display.newSprite("ui/team/team_123.png", var_29_0[iter_29_3].x, var_29_0[iter_29_3].y)

				arg_26_0.inheritLayer:addChild(var_29_1)
				table.insert(arg_26_0.inheritLayer.mLockIcon, var_29_1)
			end
		end
	end

	function arg_26_0.inheritLayer.refreshLockedState(arg_30_0)
		local var_30_0 = EquipHelper:getInheritLockInfo(var_0_4.equipUserId)

		if var_30_0 then
			arg_26_0.inheritLayer.mStoneNode:setValue(var_30_0.recastCost)

			if var_30_0.maxLockedPinJie < var_0_4.pinJie and var_0_4.pinJie > 1 and var_0_4.pinJie < 5 then
				var_26_5:setEnabled(true)
				arg_26_0.inheritLayer.mGoldNode:setVisible(true)
				arg_26_0.inheritLayer.mGoldNode:setValue(var_30_0.lockCost[var_0_4.pinJie])
			else
				var_26_5:setEnabled(false)
				arg_26_0.inheritLayer.mGoldNode:setVisible(false)
			end

			arg_26_0.inheritLayer.lockPinJie(var_30_0.lockedPinJie)
		elseif arg_30_0 ~= true then
			arg_26_0.equipLockInfoRequest:request(var_0_4.equipUserId)
		end

		if var_0_4.pinJie == 5 or var_0_4.pinJie < 2 then
			var_26_5:setEnabled(false)
			arg_26_0.inheritLayer.mGoldNode:setVisible(false)
		end
	end

	local var_26_6 = figure.createHeader({
		isName = false,
		itemId = var_0_4.equipId,
		type = ItemType.eEquip,
		level = var_0_4.level,
		equipPinJie = var_0_4.pinJie,
		equipJieji = var_0_4.BreakthroughCount,
		equipGem = var_0_4.gem
	})

	var_26_6:setPosition(CCPoint(var_26_0.width / 2, 350))
	arg_26_1:addChild(var_26_6)

	local var_26_7 = {}

	for iter_26_0, iter_26_1 in pairs(var_0_6) do
		if var_0_13(iter_26_1) == true then
			table.insert(var_26_7, iter_26_1)
		end
	end

	local var_26_8 = 130
	local var_26_9 = 5
	local var_26_10 = 150
	local var_26_11 = 260
	local var_26_12 = 260
	local var_26_13 = 30

	if table.getn(var_26_7) == 2 then
		local var_26_14 = 180

		var_26_12 = 285
	end

	local function var_26_15(arg_31_0, arg_31_1)
		if arg_31_0 <= arg_31_1 then
			return ccc3(0, 255, 0)
		else
			return ccc3(255, 0, 0)
		end
	end

	local var_26_16 = var_26_12 - var_26_13
	local var_26_17 = ccc3(255, 237, 154)

	for iter_26_2, iter_26_3 in pairs(var_26_7) do
		local var_26_18 = BattleAttrsName[iter_26_3]
		local var_26_19 = getBattleAttrWithStatus(var_0_4, iter_26_3, attrStatus.attrCurValue)
		local var_26_20 = var_26_19 - getBattleAttrWithStatus(var_0_4, iter_26_3, attrStatus.attrInitialValue)

		addLabelWithColorSize(arg_26_1, string.format("%s+%d(#00FF00+%d#FFED9A)", var_26_18, var_26_19, var_26_20), var_26_17, 20, CCPoint(0, 0), CCPoint(var_26_10, var_26_16))

		var_26_16 = var_26_16 - var_26_13
	end

	local var_26_21 = EquipHelper:getInheritLockInfo(var_0_4.equipUserId)
	local var_26_22 = BaseEquips[var_0_4.equipId].quality
	local var_26_23 = createItemCountNode({
		type = ItemType.eEquipInheritPoint,
		value = var_26_21 and var_26_21.recastCost or 0,
		color = ccc3(41, 16, 0)
	})

	var_26_23:setPosition(ccp(var_26_0.width / 2 - 100, 93))
	arg_26_1:addChild(var_26_23)

	arg_26_0.inheritLayer.mStoneNode = var_26_23

	local var_26_24 = createItemCountNode({
		type = ItemType.eGold,
		value = var_26_21 and var_26_21.lockCost[var_0_4.pinJie] or 0,
		color = ccc3(41, 16, 0)
	})

	var_26_24:setPosition(ccp(var_26_0.width / 2 + 70, 93))
	arg_26_1:addChild(var_26_24)

	arg_26_0.inheritLayer.mGoldNode = var_26_24

	arg_26_0.inheritLayer.refreshLockedState()
end

function var_0_3.onLockBtnClicked(arg_32_0)
	local var_32_0 = EquipHelper:getInheritLockInfo(var_0_4.equipUserId)

	if var_0_4.pinJie < 2 or var_0_4.pinJie > 4 then
		showFlashNotice(string.lf("目前无法锁定"))
	elseif var_32_0 and var_0_4.pinJie <= var_32_0.maxLockedPinJie then
		showFlashNotice(string.lf("目前无法锁定"))
	end

	local var_32_1 = display.newLayer()
	local var_32_2 = display.newSprite("ui/guild/guild_090.png", arg_32_0.nodeSize.width / 2, arg_32_0.nodeSize.height / 2)

	arg_32_0.background:addChild(var_32_1)
	var_32_1:addChild(var_32_2)
	arg_32_0:addTouchEventListener(function(arg_33_0, arg_33_1, arg_33_2)
		if arg_33_0 == "began" then
			return true
		end
	end, false, 1, true)
	var_32_1:setTouchEnabled(true)

	local var_32_3 = var_32_2:getContentSize()
	local var_32_4 = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		text = string.lf("确定"),
		position = ccp(var_32_3.width / 2 - 75, 50),
		clickAction = function()
			var_32_1:removeFromParent()
			arg_32_0.equipLockLevelRequest:request(var_0_4.equipUserId, var_0_4.pinJie)
		end
	})

	var_32_2:addChild(var_32_4)

	local var_32_5 = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		text = string.lf("取消"),
		position = ccp(var_32_3.width / 2 + 75, 50),
		clickAction = function()
			var_32_1:removeFromParent()
		end
	})

	var_32_2:addChild(var_32_5)

	if not var_32_0 then
		return
	end

	local var_32_6 = ui.newTTFLabel({
		size = 24,
		text = string.lf("消耗#DFE400%d元宝#DFDFDF锁定当前品阶\n锁定后重铸失败不会降低品阶", var_32_0.lockCost[var_0_4.pinJie]),
		color = ccc3(223, 223, 223)
	})

	var_32_6:setAnchorPoint(ccp(0.5, 0.5))
	var_32_6:setPosition(var_32_3.width / 2, var_32_3.height / 2 + 40)
	var_32_2:addChild(var_32_6)
end

function var_0_3.showPageInlay(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_1:getContentSize()
	local var_36_1 = var_0_4.BreakthroughCount ~= nil and var_0_4.BreakthroughCount or 0
	local var_36_2 = BaseEquips[var_0_4.equipId].jieJiAttrs
	local var_36_3 = var_36_2[var_36_1]
	local var_36_4 = var_36_2[var_36_1 + 1]
	local var_36_5 = CCScale9Sprite:create("ui/team/team_002.png")

	var_36_5:setPosition(var_36_0.width / 2, var_36_0.height / 2 + 3)
	arg_36_1:addChild(var_36_5)

	local var_36_6 = display.newSprite("ui/team/team_104.png", var_36_0.width / 2, var_36_0.height / 2 + 80)

	var_36_5:addChild(var_36_6)

	local var_36_7 = display.newSprite("ui/team/team_101.png", var_36_0.width / 2, var_36_0.height / 2 - 165)

	var_36_5:addChild(var_36_7)

	local var_36_8 = BaseEquips[var_0_4.equipId].quality
	local var_36_9 = figure.createHeader({
		isName = false,
		itemId = var_0_4.equipId,
		type = ItemType.eEquip,
		level = var_0_4.level,
		equipPinJie = var_0_4.pinJie,
		equipJieji = var_0_4.BreakthroughCount,
		equipGem = var_0_4.gem
	})

	var_36_9:setPosition(CCPoint(70, var_36_0.height - 60))
	var_36_5:addChild(var_36_9)

	local var_36_10 = display.newSprite("ui/team/team_087.png", 270, var_36_0.height - 60)

	var_36_5:addChild(var_36_10)

	if var_36_3 ~= nil then
		local var_36_11 = var_36_0.height - 30

		addLabelWithColorSize(var_36_5, string.lf("%s阶", var_36_1), ccc3(255, 255, 0), 20, CCPoint(0, 0.5), CCPoint(125, var_36_11))

		for iter_36_0, iter_36_1 in pairs(var_36_3) do
			if iter_36_0 ~= "desc" and iter_36_0 ~= "mateId" and iter_36_0 ~= "mateCount" and iter_36_0 ~= "equipId" and iter_36_0 ~= "equipCount" and iter_36_0 ~= "level" then
				var_36_11 = var_36_11 - 30

				addLabelWithColorSize(var_36_5, var_0_14(iter_36_0) .. ": " .. iter_36_1, ccc3(255, 255, 0), 20, CCPoint(0, 0.5), CCPoint(125, var_36_11))
			end
		end
	else
		addLabelWithColorSize(var_36_5, string.lf("0阶"), ccc3(255, 255, 0), 20, CCPoint(0, 0.5), CCPoint(125, var_36_0.height - 30))
	end

	if var_36_4 ~= nil then
		local var_36_12 = var_36_0.height - 30

		addLabelWithColorSize(var_36_5, string.lf("%s阶", var_36_1 + 1), ccc3(255, 255, 0), 20, CCPoint(0, 0.5), CCPoint(295, var_36_12))

		for iter_36_2, iter_36_3 in pairs(var_36_4) do
			if iter_36_2 ~= "desc" and iter_36_2 ~= "mateId" and iter_36_2 ~= "mateCount" and iter_36_2 ~= "equipId" and iter_36_2 ~= "equipCount" and iter_36_2 ~= "level" then
				var_36_12 = var_36_12 - 30

				addLabelWithColorSize(var_36_5, var_0_14(iter_36_2) .. ": " .. iter_36_3, ccc3(255, 255, 0), 20, CCPoint(0, 0.5), CCPoint(295, var_36_12))
			end
		end
	else
		addLabelWithColorSize(var_36_5, string.lf("已满阶"), ccc3(255, 255, 0), 20, CCPoint(0, 0.5), CCPoint(295, var_36_0.height - 60))
	end

	local var_36_13 = CCSize(var_36_0.width - 50, 40)
	local var_36_14 = createTableView({
		reverse = true,
		size = CCSize(var_36_0.width - 50, 200),
		direction = kCCScrollViewDirectionVertical,
		dataset = var_36_2,
		sizehandler = function(arg_37_0, arg_37_1)
			return var_36_13
		end,
		cellhandler = function(arg_38_0, arg_38_1, arg_38_2)
			local var_38_0 = CCLayerColor:create(ccc4(0, 0, 0, 0))

			var_38_0:setContentSize(var_36_13)

			local var_38_1 = arg_38_0 - arg_38_1 + 1

			if var_38_1 <= var_36_1 then
				addLabelWithColorSize(var_38_0, "[+" .. var_38_1 .. "] " .. arg_38_2.desc, ccc3(0, 255, 0), 19, CCPoint(0, 0.5), CCPoint(10, var_36_13.height / 2))
			else
				local var_38_2 = ""

				if arg_38_2.level > var_0_4.level then
					var_38_2 = "Lv." .. arg_38_2.level
				end

				local var_38_3 = var_38_2 .. "#FFFF00[+" .. var_38_1 .. "] " .. arg_38_2.desc

				addLabelWithColorSize(var_38_0, var_38_3, ccc3(255, 0, 0), 19, CCPoint(0, 0.5), CCPoint(10, var_36_13.height / 2))
			end

			return var_38_0
		end
	})

	var_36_14:setPosition(25, 180)
	var_36_5:addChild(var_36_14)

	if var_36_1 >= 5 then
		var_36_14:setContentOffset(CCPoint(0, 0))
	end

	local var_36_15 = ui.newControlButton({
		highlightedImage = "ui/team/team_103.png",
		normalImage = "ui/team/team_103.png",
		anchorPoint = CCPoint(0.5, 0.5),
		position = CCPoint(var_36_0.width / 2, 90),
		clickAction = function()
			if var_36_4 ~= nil then
				local function var_39_0(arg_40_0)
					if var_0_7 and arg_40_0 then
						var_0_7(arg_40_0, true)
					end
				end

				local var_39_1 = require("scenes.team.FeedEquipLayer").new({
					Item = var_0_4,
					Callback = var_39_0,
					enterFromEquip = arg_36_0.enterFromEquip
				})

				display.getRunningScene():addChild(var_39_1, DefaultZOrder.ePopupLayer)
			else
				showFlashNotice(string.lf("装备已满阶，无法继续喂灵"))
			end
		end
	})

	arg_36_1:addChild(var_36_15)
end

return var_0_3
