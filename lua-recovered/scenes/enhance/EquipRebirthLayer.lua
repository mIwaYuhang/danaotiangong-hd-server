require("base.figure")
require("network.EnhanceRequest")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = true
local var_0_2 = class("EquipRebirthLayer", function()
	return display.newLayer()
end)

function var_0_2.ctor(arg_2_0, arg_2_1)
	arg_2_0:initNetworkRequest()
	arg_2_0:refreshLayer(arg_2_1)
end

function var_0_2.initNetworkRequest(arg_3_0)
	local function var_3_0(arg_4_0)
		local function var_4_0()
			local var_5_0 = arg_3_0.rebirthRequest.restable
			local var_5_1 = require("scenes.enhance.DlgResultLayer").new({
				titleText = string.lf("上仙，已重生成功，请收取道具"),
				rewardList = var_5_0.Reward
			})

			CCDirector:sharedDirector():getRunningScene():addChild(var_5_1, 100)
			arg_3_0.btnRebirth:setEnabled(false)
			arg_3_0.moneyLabel:setValue(0)

			var_0_1 = true
			var_0_1 = true

			if arg_3_0.okCallback then
				arg_3_0.okCallback({})
			end
		end

		if arg_3_0.rebirthItem.detail ~= nil and arg_3_0.rebirthItem.detail.gem ~= nil then
			arg_3_0.rebirthItem.detail.gem.isBattle = 0

			MineralHelper:setItem(arg_3_0.rebirthItem.detail.gem)
		end

		local var_4_1 = CCSkeletonAnimation:createWithFile("effectAni/ui_zhuangbeiqianghua.json", "effectAni/ui_zhuangbeiqianghua.atlas", 1)

		var_4_1:setAnimation("animation", false, 0)
		var_4_1:setPosition(arg_3_0.rebirthPos)
		arg_3_0.bgSprite:addChild(var_4_1, 100)
		var_4_1:addAnimationAction("animation", 1, CCCallFunc:create(var_4_0), AAT_Percent)

		arg_3_0.rebirthItem = nil

		arg_3_0:setRebirthItem(nil)
	end

	arg_3_0.rebirthRequest = EquipRebirthRequest:new()

	arg_3_0.rebirthRequest:setResponseNormalHandler(var_3_0)
end

function var_0_2.refreshLayer(arg_6_0, arg_6_1)
	arg_6_0:removeAllChildrenWithCleanup(true)

	arg_6_0.okCallback = arg_6_1.okCallback
	arg_6_0.cancelCallback = arg_6_1.cancelCallback
	arg_6_0.bgSize = CCSize(444, 559)
	arg_6_0.bgSprite = CCLayerColor:create(ccc4(0, 0, 0, 0))

	arg_6_0.bgSprite:setContentSize(arg_6_0.bgSize)
	arg_6_0.bgSprite:setAnchorPoint(CCPoint(0, 0))
	arg_6_0.bgSprite:setPosition(CCPoint(506, 6))
	arg_6_0:addChild(arg_6_0.bgSprite)

	arg_6_0.rebirthItem = nil
	arg_6_0.rebirthNode = nil
	arg_6_0.rebirthPos = CCPoint(arg_6_0.bgSize.width / 2, arg_6_0.bgSize.height / 2 + 30)

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
				curIndex = StoreType.eStoreRebirth
			})
		end
	})

	arg_6_0.bgSprite:addChild(var_6_2)

	arg_6_0.btnRebirth = ui.newControlButton({
		disabledImage = "ui/team/team_055.png",
		normalImage = "ui/team/team_053.png",
		text = string.lf("重生"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		anchorPoint = CCPoint(0.5, 0.5),
		position = CCPoint(arg_6_0.bgSize.width / 2, 120),
		clickAction = function()
			if var_0_1 == false then
				return
			end

			if arg_6_0.rebirthItem == nil then
				return
			end

			local var_9_0 = arg_6_0.moneyLabel:getValue()

			if isMoneyEnough(MoneyType.eGold, tonumber(var_9_0)) == false then
				return
			end

			var_0_1 = false

			if arg_6_0.rebirthItem.Type == ItemType.eHero then
				arg_6_0.rebirthRequest:request(arg_6_0.rebirthItem.ID, "")
			else
				arg_6_0.rebirthRequest:request("", arg_6_0.rebirthItem.detail.equipUserId)
			end
		end
	})

	arg_6_0.btnRebirth:setEnabled(false)
	arg_6_0.bgSprite:addChild(arg_6_0.btnRebirth)

	local var_6_3 = createItemCountNode({
		value = 0,
		type = ItemType.eGold,
		color = ccc3(255, 255, 255)
	})

	var_6_3:setAnchorPoint(CCPoint(0.5, 0.5))
	var_6_3:setPosition(CCPoint(arg_6_0.bgSize.width / 2 - 20, 70))
	arg_6_0.bgSprite:addChild(var_6_3)

	arg_6_0.moneyLabel = var_6_3

	local var_6_4 = display.newSprite("ui/enhance/enhance_010.png")

	var_6_4:setAnchorPoint(CCPoint(0.5, 0.5))
	var_6_4:setPosition(arg_6_0.rebirthPos)
	arg_6_0.bgSprite:addChild(var_6_4)
	arg_6_0:setRebirthItem(nil)
end

function var_0_2.canRebirthNow(arg_10_0)
	return var_0_1
end

function var_0_2.addGridEquip(arg_11_0, arg_11_1)
	if arg_11_1 == nil or var_0_1 == false then
		return nil
	end

	if arg_11_0.rebirthItem ~= nil then
		showFlashNotice(string.lf("上仙，重生炉已满，请立刻开始重生吧~~"))

		return nil
	end

	arg_11_0.rebirthItem = arg_11_1

	return arg_11_0:convertPosition(arg_11_0.rebirthPos)
end

function var_0_2.isItemFull(arg_12_0)
	return arg_12_0.rebirthItem ~= nil
end

function var_0_2.showGridEquip(arg_13_0, arg_13_1)
	arg_13_0.rebirthItem = arg_13_1

	arg_13_0:setRebirthItem(arg_13_1)
	arg_13_0.moneyLabel:setValue(arg_13_0:calcNeedIngot(arg_13_1))
	arg_13_0.btnRebirth:setEnabled(true)
end

function var_0_2.setRebirthItem(arg_14_0, arg_14_1)
	if arg_14_0.rebirthNode ~= nil then
		arg_14_0.rebirthNode:removeFromParentAndCleanup(true)

		arg_14_0.rebirthNode = nil
	end

	if arg_14_1 == nil then
		arg_14_0.rebirthItem = nil

		return
	end

	local function var_14_0()
		local var_15_0
		local var_15_1 = arg_14_1.ID
		local var_15_2 = arg_14_1.Type
		local var_15_3 = CCNode:create()
		local var_15_4 = {
			touchable = true,
			penetrable = false,
			cancelable = true
		}
		local var_15_5 = getItemQuality(var_15_2, var_15_1)
		local var_15_6 = getQualityColor(var_15_5)
		local var_15_7 = var_15_2 == ItemType.eEquip and CCSize(260, 80) or CCSize(260, 40)

		var_15_4.title = {
			size = 22,
			text = getItemName(var_15_2, var_15_1),
			color = var_15_6
		}

		var_15_3:setContentSize(var_15_7)

		local var_15_8 = string.lf("品质: %s", tostring(getQualityAttribute(var_15_5, QualityAttr.eName)))

		addLabelWithColorSize(var_15_3, var_15_8, var_15_6, 22, CCPoint(0, 0), CCPoint(20, var_15_2 == ItemType.eEquip and 45 or 0))

		if var_15_2 == ItemType.eSoul then
			local var_15_9 = display.newSprite("ui/common/common_soul_small.png")

			var_15_9:setAnchorPoint(CCPoint(1, 0))
			var_15_9:setPosition(260, 0)
			var_15_3:addChild(var_15_9)
		end

		if var_15_2 == ItemType.eEquip then
			local var_15_10 = BaseEquips[arg_14_1.ID].herosId
			local var_15_11 = string.lf("该装备不是专属装备")

			if table.nums(var_15_10) > 0 then
				var_15_11 = string.lf("专属: ")

				for iter_15_0, iter_15_1 in ipairs(var_15_10) do
					if iter_15_0 == 1 then
						var_15_11 = var_15_11 .. BaseHeros[iter_15_1].name
					else
						var_15_11 = var_15_11 .. ", " .. BaseHeros[iter_15_1].name
					end
				end
			end

			local var_15_12 = addLabelWithColorSize(var_15_3, var_15_11, var_15_6, 20, CCPoint(0, 1), CCPoint(20, 42))

			var_15_12:setDimensions(CCSize(var_15_7.width - 40, 40))
			var_15_12:setHorizontalAlignment(kCCTextAlignmentLeft)
			var_15_12:setVerticalAlignment(kCCVerticalTextAlignmentCenter)
		end

		local var_15_13 = var_0_0.new(var_15_4)

		var_15_13:addNode(var_15_3)
		var_15_13:addAction({
			text = string.lf("移出重生炉"),
			callback = function()
				var_15_13:removeFromParentAndCleanup(true)

				arg_14_0.rebirthItem = nil

				arg_14_0:setRebirthItem(nil)

				if arg_14_0.cancelCallback then
					arg_14_0.cancelCallback({
						equipItem = arg_14_1,
						position = arg_14_0:convertPosition(arg_14_0.rebirthPos)
					})
				end

				arg_14_0.btnRebirth:setEnabled(false)
				arg_14_0.moneyLabel:setValue(0)
			end
		})
		var_15_13:show({
			parent = arg_14_0.bgSprite,
			x = arg_14_0.bgSize.width / 2 - 130,
			y = arg_14_0.bgSize.height / 2 - 50
		})
	end

	local var_14_1 = {
		isName = false,
		count = 0,
		noTypeImage = false,
		inTeam = false,
		itemId = arg_14_0.rebirthItem.ID,
		type = arg_14_0.rebirthItem.Type,
		level = arg_14_0.rebirthItem.detail.level,
		equipPinJie = arg_14_0.rebirthItem.Type == ItemType.eEquip and arg_14_0.rebirthItem.detail.pinJie or nil,
		equipJieji = arg_14_1.detail.BreakthroughCount ~= nil and arg_14_1.detail.BreakthroughCount or nil,
		equipGem = arg_14_1.detail and arg_14_1.detail.gem or nil,
		clickAction = var_14_0
	}
	local var_14_2 = figure.createHeader(var_14_1)

	var_14_2:setAnchorPoint(CCPoint(0.5, 0.5))
	var_14_2:setPosition(arg_14_0.rebirthPos)
	arg_14_0.bgSprite:addChild(var_14_2)

	arg_14_0.rebirthNode = var_14_2
end

function var_0_2.removeAllEquips(arg_17_0)
	arg_17_0.rebirthItem = nil

	arg_17_0:setRebirthItem(nil)
	arg_17_0.btnRebirth:setEnabled(false)
	arg_17_0.moneyLabel:setValue(0)
end

function var_0_2.convertPosition(arg_18_0, arg_18_1)
	return CCPoint(arg_18_1.x + 450, arg_18_1.y + 1)
end

function var_0_2.calcNeedIngot(arg_19_0, arg_19_1)
	local var_19_0 = 0

	if arg_19_1.Type == ItemType.eHero then
		local var_19_1 = {
			[QualityType.ePurple] = {
				30,
				50,
				56,
				62,
				68,
				74,
				80,
				86,
				92,
				98,
				104,
				110,
				116,
				122
			},
			[QualityType.eOrange] = {
				60,
				100,
				110,
				120,
				130,
				140,
				150,
				160,
				170,
				180,
				190,
				200,
				210,
				220
			}
		}
		local var_19_2 = BaseHeros[arg_19_1.ID].quality

		if var_19_2 == QualityType.eGreen or var_19_2 == QualityType.eBlue then
			var_19_0 = 0
		else
			local var_19_3 = var_19_1[var_19_2]

			var_19_0 = var_19_3[arg_19_1.detail.rebirthCount + 1 > table.getn(var_19_3) and table.getn(var_19_3) or arg_19_1.detail.rebirthCount + 1]
		end
	elseif arg_19_1.Type == ItemType.eEquip then
		var_19_0 = ({
			[QualityType.eGreen] = 0,
			[QualityType.eBlue] = 0,
			[QualityType.ePurple] = 40,
			[QualityType.eOrange] = 80
		})[BaseEquips[arg_19_1.ID].quality]
	end

	return var_19_0
end

return var_0_2
