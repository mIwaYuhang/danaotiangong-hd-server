require("data.mineral")

local var_0_0 = class("MineralInlayLayer", function()
	return CCScale9Sprite:create("ui/friend/friend_003.png")
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1 and arg_2_1.layerSize and arg_2_1.layerSize or CCSize(920, 508)

	arg_2_0:setPreferredSize(var_2_0)

	arg_2_0.size = var_2_0
	arg_2_0.container = arg_2_0

	arg_2_0:initRequest()
	arg_2_0:onEnterAlias()
end

function var_0_0.initRequest(arg_3_0)
	local function var_3_0()
		local var_4_0 = arg_3_0.mineralInlayRequest.restable

		arg_3_0:changeMineral()

		arg_3_0.newMineralItem.isBattle = 1

		MineralHelper:setItem(arg_3_0.newMineralItem)

		arg_3_0.oldMineralItem = arg_3_0.newMineralItem
	end

	arg_3_0.mineralInlayRequest = MineralInlayRequest:new()

	arg_3_0.mineralInlayRequest:setResponseNormalHandler(var_3_0)

	local function var_3_1()
		local var_5_0 = arg_3_0.mineralUnloadRequst.restable

		arg_3_0:changeMineral()
	end

	arg_3_0.mineralUnloadRequst = MineralUnloadRequest:new()

	arg_3_0.mineralUnloadRequst:setResponseNormalHandler(var_3_1)
end

function var_0_0.onEnterAlias(arg_6_0)
	local var_6_0 = arg_6_0.size
	local var_6_1 = arg_6_0.container

	arg_6_0.heroBackground = display.newSprite("ui/mineral/mineral_07.jpg")
	arg_6_0.heroBackSize = arg_6_0.heroBackground:getContentSize()

	arg_6_0.heroBackground:setAnchorPoint(ccp(0, 0))
	arg_6_0.heroBackground:setPosition(arg_6_0:getPositionX() + 5, arg_6_0:getPositionY() + 7)
	arg_6_0:addChild(arg_6_0.heroBackground)

	arg_6_0.equipBackground = display.newSprite("ui/mineral/mineral_05.jpg")
	arg_6_0.equipBackSize = arg_6_0.equipBackground:getContentSize()

	arg_6_0.equipBackground:setAnchorPoint(ccp(0, 0))
	arg_6_0.equipBackground:setPosition(arg_6_0.heroBackSize.width + 5, arg_6_0:getPositionY() + 7)
	arg_6_0:addChild(arg_6_0.equipBackground)

	arg_6_0.equipInfoBack = display.newSprite("ui/mineral/mineral_04.jpg")
	arg_6_0.equipinfoSize = arg_6_0.equipInfoBack:getContentSize()

	arg_6_0.equipInfoBack:setScaleX(arg_6_0.equipInfoBack:getScaleX() * 0.95)
	arg_6_0.equipInfoBack:setAnchorPoint(ccp(0, 0))
	arg_6_0.equipInfoBack:setPosition(arg_6_0.equipBackSize.width + arg_6_0.heroBackSize.width + 5, arg_6_0:getPositionY() + 3)
	arg_6_0:addChild(arg_6_0.equipInfoBack)
	arg_6_0:loadHeroListView(Player.team.groupList)

	arg_6_0.selectHeroId = 1

	local var_6_2 = clone(Player.team.groupList[1].equipList) or {}

	for iter_6_0 = #var_6_2, 1, -1 do
		if getItemQuality(ItemType.eEquip, var_6_2[iter_6_0].equipId) ~= QualityType.eOrange then
			table.remove(var_6_2, iter_6_0)
		end
	end

	if #var_6_2 > 0 then
		local var_6_3 = var_6_2[1]

		arg_6_0.currentEquipUserId = var_6_3.equipUserId
		arg_6_0.oldMineralItem = var_6_3.gem
		arg_6_0.selectEquipId = 1

		arg_6_0:loadequipListView(var_6_2)
		arg_6_0:loadequipInfoView(var_6_3)
	else
		arg_6_0:loadequipListView(nil)
		arg_6_0:loadequipInfoView(nil)
	end
end

function var_0_0.loadHeroListView(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.heroBackground ~= nil then
		arg_7_0.heroBackground:removeAllChildrenWithCleanup(true)

		arg_7_0.selectedHeader = nil
		arg_7_0.heroTableView = nil
	end

	if arg_7_1 == nil then
		return
	end

	local var_7_0 = CCSize(90, 110)

	local function var_7_1(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = CCLayerColor:create(ccc4(46, 39, 29, 0))

		var_8_0:setContentSize(var_7_0)

		local var_8_1

		var_8_1 = figure.createHeader({
			isName = true,
			inTeam = false,
			itemId = arg_8_2.heroId ~= nil and arg_8_2.heroId or 0,
			type = ItemType.eHero,
			level = arg_8_2.level ~= nil and arg_8_2.level or 0,
			clickAction = function()
				if arg_7_0.selectedHeader ~= nil then
					arg_7_0.selectedHeader:setSelected(false)
				end

				arg_7_0.selectedHeader = var_8_1

				arg_7_0.selectedHeader:setSelected(true)

				if arg_7_0.selectHeroId == arg_8_0 - arg_8_1 + 1 then
					return
				end

				arg_7_0.selectHeroId = arg_8_0 - arg_8_1 + 1

				local var_9_0 = clone(arg_8_2.equipList) or {}

				for iter_9_0 = #var_9_0, 1, -1 do
					if getItemQuality(ItemType.eEquip, var_9_0[iter_9_0].equipId) ~= QualityType.eOrange then
						table.remove(var_9_0, iter_9_0)
					end
				end

				if #var_9_0 > 0 then
					arg_7_0:loadequipListView(var_9_0)
					arg_7_0:loadequipInfoView(var_9_0[1])

					arg_7_0.currentEquipUserId = var_9_0[1].equipUserId
					arg_7_0.oldMineralItem = var_9_0[1].gem
				else
					arg_7_0:loadequipListView(nil)
					arg_7_0:loadequipInfoView(nil)
				end

				if arg_7_0.bagLayer ~= nil and arg_7_0:getChildByTag(1001) ~= nil then
					arg_7_0.bagLayer:dismissAnimation()

					arg_7_0.bagLayer = nil
				elseif arg_7_0.bagLayer ~= nil then
					arg_7_0.bagLayer = nil
				end
			end
		})

		var_8_1:setAnchorPoint(CCPoint(0.5, 0.5))
		var_8_1:setPosition(arg_7_0.heroBackSize.width / 2, var_7_0.height / 2)
		var_8_0:addChild(var_8_1)

		if arg_8_0 - arg_8_1 + 1 == arg_7_0.selectHeroId and arg_7_0.selectedHeader ~= nil then
			arg_7_0.selectedHeader = var_8_1

			arg_7_0.selectedHeader:setSelected(true)
		end

		if arg_7_0.selectedHeader == nil and arg_8_1 == (arg_7_2 ~= nil and #arg_7_1 - arg_7_2 + 1 or #arg_7_1) then
			arg_7_0.selectedHeader = var_8_1

			arg_7_0.selectedHeader:setSelected(true)
		end

		return var_8_0
	end

	arg_7_0.heroTableView = createTableView({
		reverse = true,
		direction = kCCScrollViewDirectionVertical,
		size = arg_7_0.heroBackSize,
		dataset = arg_7_1,
		sizehandler = function(arg_10_0, arg_10_1)
			return var_7_0
		end,
		cellhandler = var_7_1
	})

	arg_7_0.heroTableView:setPosition(0, 0)
	arg_7_0.heroBackground:addChild(arg_7_0.heroTableView)
end

function var_0_0.loadequipListView(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.equipBackground ~= nil then
		arg_11_0.equipBackground:removeAllChildrenWithCleanup(true)

		arg_11_0.selectedEquipHeader = nil
		arg_11_0.equipTableView = nil
	end

	if arg_11_1 == nil or #arg_11_1 == 0 then
		local var_11_0 = display.newSprite("ui/mineral/mineral_25.png")

		var_11_0:setPosition(arg_11_0.equipBackSize.width * 0.5, arg_11_0.equipBackSize.height * 0.5)
		arg_11_0.equipBackground:addChild(var_11_0)

		return
	end

	local var_11_1 = CCSize(arg_11_0.equipBackSize.width, 120)

	local function var_11_2(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = CCLayerColor:create(ccc4(46, 39, 29, 0))

		var_12_0:setContentSize(var_11_1)

		local var_12_1

		var_12_1 = figure.createHeader({
			isName = true,
			inTeam = false,
			itemId = arg_12_2.equipId ~= nil and arg_12_2.equipId or 0,
			type = ItemType.eEquip,
			level = arg_12_2.level ~= nil and arg_12_2.level or 0,
			equipGem = arg_12_2.gem,
			clickAction = function()
				if arg_11_0.selectedEquipHeader ~= nil then
					arg_11_0.selectedEquipHeader:setSelected(false)
				end

				arg_11_0.selectedEquipHeader = var_12_1

				arg_11_0.selectedEquipHeader:setSelected(true)

				arg_11_0.selectEquipId = arg_12_0 - arg_12_1 + 1

				arg_11_0:loadequipInfoView(arg_12_2)

				arg_11_0.currentEquipUserId = arg_12_2.equipUserId
				arg_11_0.oldMineralItem = arg_12_2.gem

				if arg_11_0.bagLayer ~= nil and arg_11_0:getChildByTag(1001) ~= nil then
					arg_11_0.bagLayer:dismissAnimation()

					arg_11_0.bagLayer = nil
				elseif arg_11_0.bagLayer ~= nil then
					arg_11_0.bagLayer = nil
				end
			end
		})

		var_12_1:setAnchorPoint(CCPoint(0.5, 0.5))
		var_12_1:setPosition(50, var_11_1.height / 2)
		var_12_0:addChild(var_12_1)

		if arg_12_0 - arg_12_1 + 1 == arg_11_0.selectEquipId and arg_11_0.selectedEquipHeader ~= nil then
			arg_11_0.selectedEquipHeader = var_12_1

			arg_11_0.selectedEquipHeader:setSelected(true)
		end

		if arg_11_0.selectedEquipHeader == nil and arg_12_1 == (arg_11_2 ~= nil and #arg_11_1 - arg_11_2 + 1 or #arg_11_1) then
			arg_11_0.selectEquipId = arg_11_2 or 1
			arg_11_0.selectedEquipHeader = var_12_1

			arg_11_0.selectedEquipHeader:setSelected(true)
		end

		local var_12_2 = string.lf("LV" .. arg_12_2.level .. " " .. getItemName(ItemType.eEquip, arg_12_2.equipId) .. "      " .. arg_11_0:getEquipName(arg_12_2))

		addLabelWithColorSize(var_12_0, var_12_2, ccc3(0, 0, 0), 18, ccp(0, 0), ccp(100, 60))

		local var_12_3 = string.lf("品质:") .. EquipPinjieNames[arg_12_2.pinJie]

		addLabelWithColorSize(var_12_0, var_12_3, ccc3(0, 0, 0), 18, ccp(0, 0), ccp(100, 40))

		local var_12_4 = string.lf("可镶嵌宝石:任意") .. arg_11_0:getMineralByEquipType(BaseEquips[arg_12_2.equipId].equipType).name

		addLabelWithColorSize(var_12_0, var_12_4, ccc3(0, 0, 0), 18, ccp(0, 0), ccp(100, 20))

		return var_12_0
	end

	arg_11_0.equipTableView = createTableView({
		reverse = true,
		direction = kCCScrollViewDirectionVertical,
		size = arg_11_0.equipBackSize,
		dataset = arg_11_1,
		sizehandler = function(arg_14_0, arg_14_1)
			return var_11_1
		end,
		cellhandler = var_11_2
	})

	arg_11_0.equipTableView:setPosition(30, 0)
	arg_11_0.equipBackground:addChild(arg_11_0.equipTableView)
end

function var_0_0.loadequipInfoView(arg_15_0, arg_15_1)
	if arg_15_0.equipInfoBack ~= nil then
		arg_15_0.equipInfoBack:removeAllChildrenWithCleanup(true)
	end

	if arg_15_1 == nil then
		local var_15_0 = display.newSprite("ui/mineral/mineral_26.png")

		var_15_0:setPosition(arg_15_0.equipinfoSize.width * 0.5, arg_15_0.equipinfoSize.height * 0.5)
		arg_15_0.equipInfoBack:addChild(var_15_0)

		return
	end

	local var_15_1 = CCNode:create()

	var_15_1:setContentSize(CCSize(arg_15_0.equipinfoSize.width, 120))
	var_15_1:setPosition(0, arg_15_0.equipinfoSize.height - 240)
	arg_15_0.equipInfoBack:addChild(var_15_1)

	local var_15_2 = figure.createHeader({
		inTeam = false,
		isName = false,
		itemId = arg_15_1.equipId ~= nil and arg_15_1.equipId or 0,
		type = ItemType.eEquip
	})

	var_15_2:setPosition(80, 170)
	var_15_1:addChild(var_15_2)

	local var_15_3 = "LV" .. arg_15_1.level .. " " .. getItemName(ItemType.eEquip, arg_15_1.equipId)

	addLabelWithColorSize(var_15_1, var_15_3, ccc3(0, 0, 0), 25, ccp(0, 0), ccp(140, 180))

	local var_15_4, var_15_5 = arg_15_0:getEquipName(arg_15_1)

	addLabelWithColorSize(var_15_1, var_15_4, ccc3(0, 0, 0), 20, ccp(0, 0), ccp(140, 150))

	local var_15_6 = string.lf("品质:") .. EquipPinjieNames[arg_15_1.pinJie]

	addLabelWithColorSize(var_15_1, var_15_6, ccc3(0, 0, 0), 20, ccp(0, 0), ccp(140, 125))

	local var_15_7, var_15_8 = arg_15_0:getEquipName(arg_15_1)

	for iter_15_0 = 1, #var_15_8 do
		addLabelWithColorSize(var_15_1, var_15_8[iter_15_0], ccc3(0, 0, 0), 20, ccp(0, 0), ccp(40, 65 + (iter_15_0 - 1) * 20))
	end

	local var_15_9 = string.lf("可镶嵌宝石:任意") .. arg_15_0:getMineralByEquipType(BaseEquips[arg_15_1.equipId].equipType).name

	addLabelWithColorSize(var_15_1, var_15_9, ccc3(0, 0, 0), 20, ccp(0, 0), ccp(40, 40))

	local var_15_10 = arg_15_1.gem == nil and string.lf("无") or string.lf("%d级%s", arg_15_1.gem.level, arg_15_0:getMineralByEquipType(BaseEquips[arg_15_1.equipId].equipType).name)
	local var_15_11 = string.lf("已镶嵌宝石:") .. var_15_10

	addLabelWithColorSize(var_15_1, var_15_11, ccc3(0, 0, 0), 20, ccp(0, 0), ccp(40, 20))

	local var_15_12 = display.newSprite("ui/mineral/mineral_11.png")

	var_15_12:setPosition(arg_15_0.equipinfoSize.width * 0.5, 175)
	arg_15_0.equipInfoBack:addChild(var_15_12)

	if arg_15_1.gem ~= nil then
		local var_15_13 = arg_15_1.gem.gemProtoID

		arg_15_0.mineralBtn = figure.createMineralHeader({
			itemId = var_15_13,
			level = arg_15_1.gem.level,
			clickAction = function(arg_16_0)
				if arg_15_1.gem == nil then
					return
				end

				arg_15_0:mineralBtnClick(arg_15_1)
			end
		})

		arg_15_0.mineralBtn:setPosition(arg_15_0.equipinfoSize.width * 0.5 + 2, 175)
		arg_15_0.equipInfoBack:addChild(arg_15_0.mineralBtn)
	end

	local var_15_14 = ui.newControlButton({
		fontSize = 28,
		normalImage = "ui/common/common_105.png",
		text = string.lf("镶嵌宝石"),
		textColor = ccc3(255, 255, 255),
		clickAction = function(arg_17_0)
			if arg_15_0.bagLayer ~= nil and arg_15_0:getChildByTag(1001) ~= nil then
				return
			end

			arg_15_0.bagLayer = require("scenes.mineral.MineralBagLayer").new({
				showEnterAnimation = true,
				showCloseButton = true,
				filterEquipType = BaseEquips[arg_15_1.equipId].equipType,
				tipsButtonItems = {
					{
						text = string.lf("镶嵌"),
						callback = function(arg_18_0)
							arg_15_0.bagLayer:dismissAnimation()

							arg_15_0.bagLayer = nil

							if arg_18_0.item == nil then
								return
							end

							arg_15_0.newMineralItem = arg_18_0.item
							arg_15_0.herotableposition = arg_15_0.heroTableView:getContentOffset()
							arg_15_0.equiptableposition = arg_15_0.equipTableView:getContentOffset()

							arg_15_0.mineralInlayRequest:request(arg_15_0.currentEquipUserId, arg_15_0.newMineralItem.id)
						end
					}
				}
			})

			arg_15_0:addChild(arg_15_0.bagLayer, 1, 1001)
		end
	})

	if getItemQuality(ItemType.eEquip, arg_15_1.equipId) == QualityType.eOrange then
		var_15_14:setEnabled(true)
	else
		var_15_14:setEnabled(false)
	end

	var_15_14:setPosition(arg_15_0.equipinfoSize.width * 0.5, 50)
	arg_15_0.equipInfoBack:addChild(var_15_14)
end

function var_0_0.mineralBtnClick(arg_19_0, arg_19_1)
	if arg_19_0.tiplayer then
		arg_19_0.tiplayer = nil
	end

	arg_19_0.tiplayer = require("scenes.mineral.MineralTipLayer").new({
		mineralItem = arg_19_1.gem,
		node = arg_19_0.mineralBtn,
		buttonItems = {
			{
				text = string.lf("卸下"),
				callback = function()
					arg_19_0.herotableposition = arg_19_0.heroTableView:getContentOffset()
					arg_19_0.equiptableposition = arg_19_0.equipTableView:getContentOffset()

					arg_19_0.mineralUnloadRequst:request(arg_19_1.equipUserId)
				end
			}
		}
	})
end

function var_0_0.changeMineral(arg_21_0)
	if arg_21_0.oldMineralItem ~= nil then
		arg_21_0.oldMineralItem.isBattle = 0

		MineralHelper:setItem(arg_21_0.oldMineralItem)
	end

	local var_21_0 = Player.team.groupList

	arg_21_0:loadHeroListView(var_21_0, arg_21_0.selectHeroId)
	arg_21_0.heroTableView:setContentOffset(arg_21_0.herotableposition)

	local var_21_1 = clone(var_21_0[arg_21_0.selectHeroId].equipList) or {}

	for iter_21_0 = #var_21_1, 1, -1 do
		if getItemQuality(ItemType.eEquip, var_21_1[iter_21_0].equipId) ~= QualityType.eOrange then
			table.remove(var_21_1, iter_21_0)
		end
	end

	if #var_21_1 > 0 then
		local var_21_2 = var_21_1[arg_21_0.selectEquipId]

		arg_21_0:loadequipListView(var_21_1, arg_21_0.selectEquipId)
		arg_21_0.equipTableView:setContentOffset(arg_21_0.equiptableposition)
		arg_21_0:loadequipInfoView(var_21_2)
	end
end

function var_0_0.getEquipName(arg_22_0, arg_22_1)
	local var_22_0 = ""
	local var_22_1 = BaseEquips[arg_22_1.equipId].equipType
	local var_22_2 = EquipTypeNames[var_22_1]

	if var_22_1 == EquipType.eWeapon then
		mainInfo = {
			string.lf("普攻:") .. (arg_22_1.normalAttack or 0),
			string.lf("法攻:") .. (arg_22_1.skillAttack or 0)
		}
	elseif var_22_1 == EquipType.eAmulet then
		mainInfo = {
			string.lf("法攻:") .. (arg_22_1.skillAttack or 0)
		}
	elseif var_22_1 == EquipType.eHelmet then
		mainInfo = {
			string.lf("法防:") .. (arg_22_1.skillDefense or 0)
		}
	elseif var_22_1 == EquipType.eClothes then
		mainInfo = {
			string.lf("普防:") .. (arg_22_1.normalDefense or 0)
		}
	elseif var_22_1 == EquipType.eNecklace then
		mainInfo = {
			string.lf("速度:") .. (arg_22_1.speed or 0)
		}
	elseif var_22_1 == EquipType.eRing then
		mainInfo = {
			string.lf("生命:") .. (arg_22_1.health or 0)
		}
	end

	return var_22_2, mainInfo
end

function var_0_0.getMineralByEquipType(arg_23_0, arg_23_1)
	for iter_23_0 = 1, #BaseMineral do
		if BaseMineral[iter_23_0].equipType == arg_23_1 then
			return BaseMineral[iter_23_0], iter_23_0
		end
	end
end

return var_0_0
