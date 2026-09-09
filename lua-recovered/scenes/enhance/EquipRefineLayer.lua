require("base.figure")
require("network.EnhanceRequest")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = require("scenes.toollayer.ctrl")
local var_0_2 = {}
local var_0_3 = true
local var_0_4 = class("EquipRefineLayer", function()
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
				titleText = string.lf("上仙，已炼化成功，请收取道具"),
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

				if iter_4_1.equipItem.detail ~= nil and iter_4_1.equipItem.detail.gem ~= nil then
					iter_4_1.equipItem.detail.gem.isBattle = 0

					MineralHelper:setItem(iter_4_1.equipItem.detail.gem)
				end

				local var_4_2 = CCSkeletonAnimation:createWithFile("effectAni/ui_zhuangbeiqianghua.json", "effectAni/ui_zhuangbeiqianghua.atlas", 1)

				var_4_2:setAnimation("animation", false, 0)
				var_4_2:setPosition(iter_4_1.position)
				arg_3_0.bgSprite:addChild(var_4_2, 100)
				var_4_2:addAnimationAction("animation", 1, CCCallFunc:create(var_4_1), AAT_Percent)
				arg_3_0:setGridItem(iter_4_0, nil)
			end
		end
	end

	arg_3_0.refineRequest = EquipRefineRequest:new()

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
		text = string.lf("炼化"),
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
				local var_10_1 = ""
				local var_10_2 = ""
				local var_10_3 = ""

				for iter_10_0, iter_10_1 in pairs(var_0_2) do
					if iter_10_1.equipItem ~= nil then
						local var_10_4 = iter_10_1.equipItem.Type

						if var_10_4 == ItemType.eHero then
							var_10_0 = var_10_0 .. iter_10_1.equipItem.ID .. ";"
						elseif var_10_4 == ItemType.eSoul then
							local var_10_5 = BaseHeros[BaseSouls[iter_10_1.equipItem.ID].figureId].soulCount

							var_10_1 = var_10_1 .. iter_10_1.equipItem.ID .. "," .. var_10_5 .. ";"
						elseif var_10_4 == ItemType.eEquip then
							var_10_2 = var_10_2 .. iter_10_1.equipItem.detail.equipUserId .. ";"
						elseif var_10_4 == ItemType.eFragment then
							var_10_3 = var_10_3 .. iter_10_1.equipItem.ID .. "," .. "1" .. ";"
						end
					end
				end

				var_0_3 = false

				arg_6_0.refineRequest:request(var_10_0, var_10_1, var_10_2, var_10_3)
			end

			local var_9_1 = false
			local var_9_2 = false
			local var_9_3 = ItemType.eHero

			for iter_9_0, iter_9_1 in pairs(var_0_2) do
				if iter_9_1.equipItem ~= nil then
					local var_9_4 = iter_9_1.equipItem.Type

					if var_9_4 == ItemType.eHero or var_9_4 == ItemType.eEquip then
						local var_9_5 = var_9_4 == ItemType.eHero and iter_9_1.equipItem.level or iter_9_1.equipItem.detail.level
						local var_9_6 = getItemQuality(iter_9_1.equipItem.Type, iter_9_1.equipItem.ID)

						if var_9_5 > 1 then
							var_9_1 = true
							var_9_3 = var_9_4

							break
						end

						if var_9_6 == QualityType.eOrange then
							var_9_2 = true

							break
						end
					end
				end
			end

			if var_9_1 == true then
				ui.showMessageBox({
					text = string.lf("上仙，炼化炉里有大于1级的主将或装备，建议先重生，这样将返还所有消耗！"),
					title1 = string.lf("继续炼化"),
					title2 = string.lf("去重生"),
					action1 = function()
						var_9_0()
					end,
					action2 = function()
						arg_6_0.rebirthAction(var_9_3)
					end
				})

				return
			end

			if var_9_2 == true then
				ui.showMessageBox({
					text = string.lf("上仙，炼化炉里有橙色的超级主将或装备，您确定要继续炼化吗？"),
					title1 = string.lf("继续炼化"),
					title2 = string.lf("取消"),
					action1 = function()
						var_9_0()
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
	addLabelWithColorSize(arg_6_0.bgSprite, string.lf("大于1级的主将或装备被炼化后，只能得到基础"), ccc3(220, 180, 100), 18, CCPoint(0, 0), CCPoint(33, 45))
	addLabelWithColorSize(arg_6_0.bgSprite, string.lf("收益。建议先将其重生后，再进行炼化。 "), ccc3(220, 180, 100), 18, CCPoint(0, 0), CCPoint(32, 20))

	var_0_2 = {
		{
			tag = 1,
			position = CCPoint(arg_6_0.bgSize.width / 2, arg_6_0.bgSize.height / 2 + 150)
		},
		{
			tag = 2,
			position = CCPoint(arg_6_0.bgSize.width / 2, arg_6_0.bgSize.height / 2 - 50)
		},
		{
			tag = 3,
			position = CCPoint(arg_6_0.bgSize.width / 2 - 140, arg_6_0.bgSize.height / 2 + 50)
		},
		{
			tag = 4,
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
	arg_6_0:setGridItem(4, nil)
end

function var_0_4.canRefineNow(arg_14_0)
	return var_0_3
end

function var_0_4.addGridEquip(arg_15_0, arg_15_1)
	if arg_15_1 == nil or var_0_3 == false then
		return nil
	end

	local var_15_0

	for iter_15_0, iter_15_1 in pairs(var_0_2) do
		if iter_15_1.equipItem == nil then
			var_15_0 = iter_15_1

			break
		end
	end

	if var_15_0 == nil then
		showFlashNotice(string.lf("上仙，炼化炉已满，请立刻开始炼化吧~~"))

		return nil
	end

	arg_15_0.btnRefine:setEnabled(true)

	var_15_0.equipItem = arg_15_1

	arg_15_0:setGridItem(var_15_0.tag, arg_15_1):setVisible(false)

	return arg_15_0:convertPosition(var_15_0.position)
end

function var_0_4.isItemFull(arg_16_0)
	local var_16_0 = true

	for iter_16_0, iter_16_1 in pairs(var_0_2) do
		if iter_16_1.equipItem == nil then
			var_16_0 = false

			break
		end
	end

	return var_16_0
end

function var_0_4.showEquipNode(arg_17_0, arg_17_1)
	if arg_17_1 == nil then
		return
	end

	for iter_17_0, iter_17_1 in pairs(var_0_2) do
		if iter_17_1.equipItem ~= nil and iter_17_1.equipNode ~= nil and iter_17_1.equipItem.Type == arg_17_1.Type and iter_17_1.equipItem.ID == arg_17_1.ID and iter_17_1.equipNode:isVisible() == false then
			if arg_17_1.Type == ItemType.eEquip then
				if iter_17_1.equipItem.detail.equipUserId == arg_17_1.detail.equipUserId then
					iter_17_1.equipNode:setVisible(true)

					break
				end
			else
				iter_17_1.equipNode:setVisible(true)

				break
			end
		end
	end
end

function var_0_4.getNearestGridItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0

	for iter_18_0, iter_18_1 in pairs(var_0_2) do
		if iter_18_1.equipNode ~= nil then
			local var_18_1, var_18_2 = iter_18_1.equipNode:getPosition()
			local var_18_3 = arg_18_0.bgSprite:convertToNodeSpace(ccp(arg_18_1, arg_18_2))

			if ccpDistance(ccp(var_18_1, var_18_2), var_18_3) < 50 then
				var_18_0 = iter_18_1
			end
		end
	end

	return var_18_0
end

function var_0_4.getGridItem(arg_19_0)
	return var_0_2
end

function var_0_4.removeItemFromGrid(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.equipItem

	arg_20_0:setGridItem(arg_20_1.tag, nil)

	if arg_20_0.cancelCallback then
		arg_20_0.cancelCallback({
			equipItem = var_20_0,
			position = arg_20_0:convertPosition(arg_20_1.position)
		})
	end

	local var_20_1 = true

	for iter_20_0, iter_20_1 in pairs(var_0_2) do
		if iter_20_1.equipNode ~= nil then
			var_20_1 = false

			break
		end
	end

	if var_20_1 == true then
		arg_20_0.btnRefine:setEnabled(false)
	end
end

function var_0_4.setGridItem(arg_21_0, arg_21_1, arg_21_2)
	if var_0_2[arg_21_1].equipNode ~= nil then
		var_0_2[arg_21_1].equipNode:removeFromParentAndCleanup(true)

		var_0_2[arg_21_1].equipNode = nil
	end

	if arg_21_2 == nil then
		var_0_2[arg_21_1].equipItem = nil

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

		if var_22_2 == ItemType.eSoul then
			local var_22_9 = display.newSprite("ui/common/common_soul_small.png")

			var_22_9:setAnchorPoint(CCPoint(1, 0))
			var_22_9:setPosition(260, 0)
			var_22_3:addChild(var_22_9)
		end

		if var_22_2 == ItemType.eEquip then
			local var_22_10 = BaseEquips[arg_21_2.ID].herosId
			local var_22_11 = string.lf("该装备不是专属装备")

			if table.nums(var_22_10) > 0 then
				var_22_11 = string.lf("专属: ")

				for iter_22_0, iter_22_1 in ipairs(var_22_10) do
					if iter_22_0 == 1 then
						var_22_11 = var_22_11 .. BaseHeros[iter_22_1].name
					else
						var_22_11 = var_22_11 .. ", " .. BaseHeros[iter_22_1].name
					end
				end
			end

			local var_22_12 = addLabelWithColorSize(var_22_3, var_22_11, var_22_6, 20, CCPoint(0, 1), CCPoint(20, 42))

			var_22_12:setDimensions(CCSize(var_22_7.width - 40, 40))
			var_22_12:setHorizontalAlignment(kCCTextAlignmentLeft)
			var_22_12:setVerticalAlignment(kCCVerticalTextAlignmentCenter)
		end

		local var_22_13 = var_0_0.new(var_22_4)

		var_22_13:addNode(var_22_3)
		var_22_13:addAction({
			text = string.lf("移出炼化炉"),
			callback = function()
				var_22_13:removeFromParentAndCleanup(true)
				arg_21_0:setGridItem(arg_21_1, nil)

				if arg_21_0.cancelCallback then
					arg_21_0.cancelCallback({
						equipItem = arg_21_2,
						position = arg_21_0:convertPosition(var_0_2[arg_21_1].position)
					})
				end

				local var_23_0 = true

				for iter_23_0, iter_23_1 in pairs(var_0_2) do
					if iter_23_1.equipNode ~= nil then
						var_23_0 = false

						break
					end
				end

				if var_23_0 == true then
					arg_21_0.btnRefine:setEnabled(false)
				end
			end
		})
		var_22_13:show({
			parent = arg_21_0.bgSprite,
			x = arg_21_0.bgSize.width / 2 - 130,
			y = arg_21_0.bgSize.height / 2 - 50
		})
	end

	local var_21_1 = {
		isName = false,
		count = 0,
		inTeam = false,
		noTypeImage = false,
		itemId = arg_21_2.ID,
		type = arg_21_2.Type,
		clickAction = var_21_0
	}

	if arg_21_2.Type == ItemType.eHero or arg_21_2.Type == ItemType.eEquip then
		var_21_1.level = arg_21_2.detail.level
		var_21_1.equipPinJie = arg_21_2.detail.pinJie ~= nil and arg_21_2.detail.pinJie or nil
		var_21_1.equipJieji = arg_21_2.detail.BreakthroughCount ~= nil and arg_21_2.detail.BreakthroughCount or nil
		var_21_1.equipGem = arg_21_2.detail and arg_21_2.detail.gem or nil
	elseif arg_21_2.Type == ItemType.eSoul then
		var_21_1.count = BaseHeros[BaseSouls[arg_21_2.ID].figureId].soulCount
	elseif arg_21_2.Type == ItemType.eFragment then
		var_21_1.count = 1
	end

	local var_21_2 = figure.createHeader(var_21_1)

	var_21_2:setPosition(var_0_2[arg_21_1].position)
	arg_21_0.bgSprite:addChild(var_21_2)

	var_0_2[arg_21_1].equipNode = var_21_2

	return var_21_2
end

function var_0_4.removeAllEquips(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(var_0_2) do
		arg_24_0:setGridItem(iter_24_1.tag, nil)
	end

	arg_24_0.btnRefine:setEnabled(false)
end

function var_0_4.convertPosition(arg_25_0, arg_25_1)
	return CCPoint(arg_25_1.x + 450, arg_25_1.y + 1)
end

return var_0_4
