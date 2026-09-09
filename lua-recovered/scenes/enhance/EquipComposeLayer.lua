require("base.figure")
require("network.EnhanceRequest")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = {}
local var_0_3 = true
local var_0_4 = class("EquipComposeLayer", function()
	return display.newLayer()
end)

function var_0_4.ctor(arg_2_0, arg_2_1)
	arg_2_0.rebirthAction = arg_2_1.rebirthAction
	var_0_2 = {}
	var_0_3 = true

	arg_2_0:initNetworkRequest()
	arg_2_0:refreshLayer(arg_2_1)
end

function var_0_4.initNetworkRequest(arg_3_0)
	local function var_3_0(arg_4_0)
		local var_4_0 = 0

		local function var_4_1()
			var_4_0 = var_4_0 - 1

			if var_4_0 > 0 then
				return
			end

			local var_5_0 = arg_3_0.refineRequest.restable
			local var_5_1 = require("scenes.enhance.DlgResultLayer").new({
				titleText = string.lf("上仙，已合成成功，请收取道具"),
				rewardList = var_5_0.Reward
			})

			CCDirector:sharedDirector():getRunningScene():addChild(var_5_1, DefaultZOrder.ePopupLayer)
			arg_3_0.btnRefine:setEnabled(false)

			var_0_3 = true

			if arg_3_0.okCallback then
				arg_3_0.okCallback({})
			end
		end

		for iter_4_0, iter_4_1 in pairs(var_0_2) do
			if iter_4_1.equipItem ~= nil then
				var_4_0 = var_4_0 + 1

				local var_4_2 = CCSkeletonAnimation:createWithFile("effectAni/ui_zhuangbeiqianghua.json", "effectAni/ui_zhuangbeiqianghua.atlas", 1)

				var_4_2:setAnimation("animation", false, 0)
				var_4_2:setPosition(iter_4_1.position)
				arg_3_0.bgSprite:addChild(var_4_2, 100)
				var_4_2:addAnimationAction("animation", 1, CCCallFunc:create(var_4_1), AAT_Percent)
				arg_3_0:setGridItem(iter_4_0, nil)
			end
		end
	end

	arg_3_0.refineRequest = EquipComposeRequest:new()

	arg_3_0.refineRequest:setResponseNormalHandler(var_3_0)
end

function var_0_4.refreshLayer(arg_6_0, arg_6_1)
	arg_6_0:removeAllChildrenWithCleanup(true)

	arg_6_0.okCallback = arg_6_1.okCallback
	arg_6_0.cancelCallback = arg_6_1.cancelCallback
	arg_6_0.parentBgSprite = arg_6_1.parentBgSprite
	arg_6_0.bgSize = CCSize(444, 559)
	arg_6_0.bgSprite = CCLayerColor:create(ccc4(0, 0, 0, 0))

	arg_6_0.bgSprite:setContentSize(arg_6_0.bgSize)
	arg_6_0.bgSprite:setAnchorPoint(CCPoint(0, 0))
	arg_6_0.bgSprite:setPosition(CCPoint(506, 6))
	arg_6_0:addChild(arg_6_0.bgSprite)

	local var_6_0 = display.newSprite("ui/enhance/enhance_013.png")

	var_6_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_6_0:setPosition(arg_6_0.bgSize.width / 2, arg_6_0.bgSize.height / 2 - 20)
	arg_6_0.bgSprite:addChild(var_6_0)

	local var_6_1 = ui.newControlButton({
		normalImage = "ui/enhance/enhance_015.png",
		scaleX = 0.9,
		scaleY = 0.9,
		anchorPoint = CCPoint(0.5, 0.5),
		position = CCPoint(320, arg_6_0.bgSize.height + 20),
		clickAction = function()
			local var_7_0 = require("scenes.enhance.DlgRuleLayer").new({
				ruleType = DlgRuleType.ruleRefine
			})

			CCDirector:sharedDirector():getRunningScene():addChild(var_7_0)
		end
	})

	arg_6_0.bgSprite:addChild(var_6_1)

	local var_6_2 = ui.newControlButton({
		normalImage = "ui/enhance/enhance_012.png",
		anchorPoint = CCPoint(0.5, 0.5),
		position = CCPoint(arg_6_0.bgSize.width - 60, arg_6_0.bgSize.height - 60),
		clickAction = function()
			game.enterMysticStoreScene({
				curIndex = StoreType.eStoreRefine
			})
		end
	})

	arg_6_0.bgSprite:addChild(var_6_2)

	arg_6_0.btnRefine = ui.newControlButton({
		disabledImage = "ui/team/team_055.png",
		normalImage = "ui/team/team_053.png",
		text = string.lf("合成"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		anchorPoint = CCPoint(0.5, 0.5),
		position = CCPoint(arg_6_0.bgSize.width / 2, 120),
		clickAction = function()
			if var_0_3 == false then
				return
			end

			GuideLayer:removeGuideLayer(nil, TaskEntryType.eRefining, 4)

			local function var_9_0()
				local var_10_0 = ""
				local var_10_1 = 0

				for iter_10_0, iter_10_1 in ipairs(var_0_2) do
					if iter_10_1.equipItem ~= nil and iter_10_1.equipItem.Type == ItemType.eEquip then
						if var_10_1 == 0 then
							var_10_0 = iter_10_1.equipItem.detail.equipUserId
						else
							var_10_0 = var_10_0 .. "," .. iter_10_1.equipItem.detail.equipUserId
						end

						var_10_1 = var_10_1 + 1
					end
				end

				if var_10_1 < 3 then
					showFlashNotice(string.lf("上仙，合成所需的材料不够哦~"))

					return
				end

				var_0_3 = false

				arg_6_0.refineRequest:request(var_10_0)
			end

			local var_9_1 = false

			for iter_9_0, iter_9_1 in pairs(var_0_2) do
				if iter_9_1.equipItem ~= nil and iter_9_1.equipItem.Type == ItemType.eEquip and (iter_9_1.equipItem.detail.level > 1 or iter_9_1.equipItem.detail.BreakthroughCount > 0) then
					var_9_1 = true

					break
				end
			end

			if var_9_1 == true then
				ui.showMessageBox({
					text = string.lf("上仙，合成炉里有等级大于1级或进阶大于1级的装备，建议先重生，这样将返还所有消耗！"),
					title1 = string.lf("继续合成"),
					title2 = string.lf("去重生"),
					action1 = function()
						var_9_0()
					end,
					action2 = function()
						arg_6_0.rebirthAction(ItemType.eEquip)
					end
				})

				return
			end

			var_9_0()
		end
	})

	arg_6_0.btnRefine:setEnabled(false)
	arg_6_0.bgSprite:addChild(arg_6_0.btnRefine)

	local var_6_3 = display.newSprite("ui/enhance/enhance_011.png", arg_6_0.bgSize.width / 2 + 5, 20)

	var_6_3:setAnchorPoint(CCPoint(0.5, 0))
	arg_6_0.bgSprite:addChild(var_6_3)
	addLabelWithColorSize(arg_6_0.bgSprite, string.lf("已锻造或已喂灵装备合成时不返还已消耗的银币、"), ccc3(220, 180, 100), 18, CCPoint(0, 0), CCPoint(33, 45))
	addLabelWithColorSize(arg_6_0.bgSprite, string.lf("喂灵石和装备。建议先将其重生，再进行合成"), ccc3(220, 180, 100), 18, CCPoint(0, 0), CCPoint(32, 20))

	var_0_2 = {
		{
			tag = 1,
			position = CCPoint(arg_6_0.bgSize.width / 2, arg_6_0.bgSize.height / 2 + 150)
		},
		{
			tag = 2,
			position = CCPoint(arg_6_0.bgSize.width / 2 - 140, arg_6_0.bgSize.height / 2 + 50)
		},
		{
			tag = 3,
			position = CCPoint(arg_6_0.bgSize.width / 2 + 140, arg_6_0.bgSize.height / 2 + 50)
		}
	}

	for iter_6_0, iter_6_1 in pairs(var_0_2) do
		local var_6_4 = display.newSprite("ui/enhance/enhance_010.png")

		var_6_4:setAnchorPoint(CCPoint(0.5, 0.5))
		var_6_4:setPosition(iter_6_1.position)
		arg_6_0.bgSprite:addChild(var_6_4)
	end

	arg_6_0:setGridItem(1, nil)
	arg_6_0:setGridItem(2, nil)
	arg_6_0:setGridItem(3, nil)
end

function var_0_4.canRefineNow(arg_13_0)
	return var_0_3
end

function var_0_4.addGridEquip(arg_14_0, arg_14_1)
	if arg_14_1 == nil or var_0_3 == false then
		return nil
	end

	local var_14_0

	for iter_14_0, iter_14_1 in pairs(var_0_2) do
		if iter_14_1.equipItem == nil then
			var_14_0 = iter_14_1

			break
		end
	end

	if var_14_0 == nil then
		showFlashNotice(string.lf("上仙，合成炉已满，请立刻开始合成吧~~"))

		return nil
	end

	arg_14_0.btnRefine:setEnabled(true)

	var_14_0.equipItem = arg_14_1

	arg_14_0:setGridItem(var_14_0.tag, arg_14_1):setVisible(false)

	return arg_14_0:convertPosition(var_14_0.position)
end

function var_0_4.isItemFull(arg_15_0)
	local var_15_0 = true

	for iter_15_0, iter_15_1 in pairs(var_0_2) do
		if iter_15_1.equipItem == nil then
			var_15_0 = false

			break
		end
	end

	return var_15_0
end

function var_0_4.showEquipNode(arg_16_0, arg_16_1)
	if arg_16_1 == nil then
		return
	end

	for iter_16_0, iter_16_1 in pairs(var_0_2) do
		if iter_16_1.equipItem ~= nil and iter_16_1.equipNode ~= nil and iter_16_1.equipItem.Type == arg_16_1.Type and iter_16_1.equipItem.ID == arg_16_1.ID and iter_16_1.equipNode:isVisible() == false then
			if arg_16_1.Type == ItemType.eEquip then
				if iter_16_1.equipItem.detail.equipUserId == arg_16_1.detail.equipUserId then
					iter_16_1.equipNode:setVisible(true)

					break
				end
			else
				iter_16_1.equipNode:setVisible(true)

				break
			end
		end
	end
end

function var_0_4.getNearestGridItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0

	for iter_17_0, iter_17_1 in pairs(var_0_2) do
		if iter_17_1.equipNode ~= nil then
			local var_17_1, var_17_2 = iter_17_1.equipNode:getPosition()
			local var_17_3 = arg_17_0.bgSprite:convertToNodeSpace(ccp(arg_17_1, arg_17_2))

			if ccpDistance(ccp(var_17_1, var_17_2), var_17_3) < 50 then
				var_17_0 = iter_17_1
			end
		end
	end

	return var_17_0
end

function var_0_4.getGridItem(arg_18_0)
	return var_0_2
end

function var_0_4.removeItemFromGrid(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1.equipItem

	arg_19_0:setGridItem(arg_19_1.tag, nil)

	if arg_19_0.cancelCallback then
		arg_19_0.cancelCallback({
			equipItem = var_19_0,
			position = arg_19_0:convertPosition(arg_19_1.position)
		})
	end

	local var_19_1 = true

	for iter_19_0, iter_19_1 in pairs(var_0_2) do
		if iter_19_1.equipNode ~= nil then
			var_19_1 = false

			break
		end
	end

	if var_19_1 == true then
		arg_19_0.btnRefine:setEnabled(false)
	end
end

function var_0_4.setGridItem(arg_20_0, arg_20_1, arg_20_2)
	if var_0_2[arg_20_1].equipNode ~= nil then
		var_0_2[arg_20_1].equipNode:removeFromParentAndCleanup(true)

		var_0_2[arg_20_1].equipNode = nil
	end

	if arg_20_2 == nil then
		var_0_2[arg_20_1].equipItem = nil

		return nil
	end

	local function var_20_0()
		local var_21_0
		local var_21_1 = arg_20_2.ID
		local var_21_2 = arg_20_2.Type
		local var_21_3 = CCNode:create()
		local var_21_4 = {
			touchable = true,
			penetrable = false,
			cancelable = true
		}
		local var_21_5 = getItemQuality(var_21_2, var_21_1)
		local var_21_6 = getQualityColor(var_21_5)
		local var_21_7 = var_21_2 == ItemType.eEquip and CCSize(260, 80) or CCSize(260, 40)

		var_21_4.title = {
			size = 22,
			text = getItemName(var_21_2, var_21_1),
			color = var_21_6
		}

		var_21_3:setContentSize(var_21_7)

		local var_21_8 = string.lf("品质: %s", tostring(getQualityAttribute(var_21_5, QualityAttr.eName)))

		addLabelWithColorSize(var_21_3, var_21_8, var_21_6, 22, CCPoint(0, 0), CCPoint(20, var_21_2 == ItemType.eEquip and 45 or 0))

		if var_21_2 == ItemType.eSoul then
			local var_21_9 = display.newSprite("ui/common/common_soul_small.png")

			var_21_9:setAnchorPoint(CCPoint(1, 0))
			var_21_9:setPosition(260, 0)
			var_21_3:addChild(var_21_9)
		end

		if var_21_2 == ItemType.eEquip then
			local var_21_10 = BaseEquips[arg_20_2.ID].herosId
			local var_21_11 = string.lf("该装备不是专属装备")

			if table.nums(var_21_10) > 0 then
				var_21_11 = string.lf("专属: ")

				for iter_21_0, iter_21_1 in ipairs(var_21_10) do
					if iter_21_0 == 1 then
						var_21_11 = var_21_11 .. BaseHeros[iter_21_1].name
					else
						var_21_11 = var_21_11 .. ", " .. BaseHeros[iter_21_1].name
					end
				end
			end

			local var_21_12 = addLabelWithColorSize(var_21_3, var_21_11, var_21_6, 20, CCPoint(0, 1), CCPoint(20, 42))

			var_21_12:setDimensions(CCSize(var_21_7.width - 40, 40))
			var_21_12:setHorizontalAlignment(kCCTextAlignmentLeft)
			var_21_12:setVerticalAlignment(kCCVerticalTextAlignmentCenter)
		end

		local var_21_13 = var_0_0.new(var_21_4)

		var_21_13:addNode(var_21_3)
		var_21_13:addAction({
			text = string.lf("移出合成炉"),
			callback = function()
				var_21_13:removeFromParentAndCleanup(true)
				arg_20_0:setGridItem(arg_20_1, nil)

				if arg_20_0.cancelCallback then
					arg_20_0.cancelCallback({
						equipItem = arg_20_2,
						position = arg_20_0:convertPosition(var_0_2[arg_20_1].position)
					})
				end

				local var_22_0 = true

				for iter_22_0, iter_22_1 in pairs(var_0_2) do
					if iter_22_1.equipNode ~= nil then
						var_22_0 = false

						break
					end
				end

				if var_22_0 == true then
					arg_20_0.btnRefine:setEnabled(false)
				end
			end
		})
		var_21_13:show({
			parent = arg_20_0.bgSprite,
			x = arg_20_0.bgSize.width / 2 - 130,
			y = arg_20_0.bgSize.height / 2 - 50
		})
	end

	local var_20_1 = {
		isName = false,
		count = 0,
		inTeam = false,
		noTypeImage = false,
		itemId = arg_20_2.ID,
		type = arg_20_2.Type,
		clickAction = var_20_0
	}

	if arg_20_2.Type == ItemType.eHero or arg_20_2.Type == ItemType.eEquip then
		var_20_1.level = arg_20_2.detail.level
		var_20_1.equipPinJie = arg_20_2.detail.pinJie ~= nil and arg_20_2.detail.pinJie or nil
		var_20_1.equipJieji = arg_20_2.detail.BreakthroughCount ~= nil and arg_20_2.detail.BreakthroughCount or nil
		var_20_1.equipGem = arg_20_2.detail ~= nil and arg_20_2.detail.gem or nil
	elseif arg_20_2.Type == ItemType.eSoul then
		var_20_1.count = BaseHeros[BaseSouls[arg_20_2.ID].figureId].soulCount
	elseif arg_20_2.Type == ItemType.eFragment then
		var_20_1.count = 1
	end

	local var_20_2 = figure.createHeader(var_20_1)

	var_20_2:setPosition(var_0_2[arg_20_1].position)
	arg_20_0.bgSprite:addChild(var_20_2)

	var_0_2[arg_20_1].equipNode = var_20_2

	return var_20_2
end

function var_0_4.removeAllEquips(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(var_0_2) do
		arg_23_0:setGridItem(iter_23_1.tag, nil)
	end

	arg_23_0.btnRefine:setEnabled(false)
end

function var_0_4.convertPosition(arg_24_0, arg_24_1)
	return CCPoint(arg_24_1.x + 450, arg_24_1.y + 1)
end

return var_0_4
