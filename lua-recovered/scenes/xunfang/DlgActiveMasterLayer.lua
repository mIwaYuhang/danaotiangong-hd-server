local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = {
	typeOfExchange = 2,
	typeOfResolve = 3,
	typeOfActive = 1
}
local var_0_2 = class("DlgActiveMasterLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create(ccc4(10, 10, 10, 160)))
end)

function var_0_2.ctor(arg_2_0, arg_2_1)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		return true
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.closeAction = arg_2_1 and arg_2_1.closeAction and arg_2_1.closeAction or nil
	arg_2_0.isActivity = arg_2_1 and arg_2_1.isActivity and arg_2_1.isActivity or false
	arg_2_0.isInTujian = arg_2_1 and arg_2_1.isInTujian and arg_2_1.isInTujian or false
	arg_2_0.masterId = arg_2_1 and arg_2_1.masterId and arg_2_1.masterId or 101
	arg_2_0.masterItem = getItemBaseData(ItemType.eMaster, arg_2_0.masterId)
	arg_2_0.requestType = var_0_1.typeOfActive

	local var_2_0 = display.newSprite("ui/xunfang/xunfang_044.png")
	local var_2_1 = var_2_0:getContentSize()

	var_2_0:align(display.CENTER, display.cx, display.cy)
	var_2_0:setScale(Adapter.MinScale)
	arg_2_0:addChild(var_2_0)

	arg_2_0.bgSprite = var_2_0
	arg_2_0.nodeSize = var_2_1

	local var_2_2 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		clickAction = function()
			arg_2_0:removeFromParent()
		end,
		position = ccp(var_2_1.width, var_2_1.height)
	})

	var_2_0:addChild(var_2_2, 1)

	arg_2_0.groupList = MasterHelper:getMasterGroupByID(arg_2_0.masterId)

	arg_2_0:initRequests()
	arg_2_0:createMasterAndDesc(var_2_0)
	arg_2_0:createImpartAttr(var_2_0)
	arg_2_0:createMasterCombo(var_2_0)
	arg_2_0:createActiveMaster(var_2_0)
end

function var_0_2.initRequests(arg_5_0)
	local function var_5_0()
		local var_6_0

		if arg_5_0.requestType == var_0_1.typeOfActive then
			var_6_0 = "uilocal/xunfang/xunfang_text_025.png"
		elseif arg_5_0.requestType == var_0_1.typeOfExchange then
			var_6_0 = "uilocal/xunfang/xunfang_text_026.png"
		elseif arg_5_0.requestType == var_0_1.typeOfResolve then
			var_6_0 = "uilocal/xunfang/xunfang_text_027.png"
		end

		showFlashImage({
			scale = 0.8,
			parent = arg_5_0.bgSprite,
			position = CCPoint(arg_5_0.nodeSize.width / 2, arg_5_0.nodeSize.height / 2),
			image = var_6_0,
			callback = function()
				if arg_5_0.closeAction then
					arg_5_0.closeAction(arg_5_0.masterId)
				end

				if arg_5_0.countLabel ~= nil then
					local var_7_0 = MasterHelper:getMasterCount(arg_5_0.masterId)

					arg_5_0.countLabel:setString(string.lf("拥有: %s", var_7_0 == nil and 0 or var_7_0))
				end

				if arg_5_0.textLabel ~= nil then
					local var_7_1 = Player.learnExp
					local var_7_2 = arg_5_0.masterItem.needLearnExp
					local var_7_3 = string.lf("%s需要授业值:%s %s/%s", arg_5_0.isActivity == true and "兑换" or "激活", var_7_2 <= var_7_1 and "#00FF00" or "#FF0000", var_7_1, var_7_2)

					arg_5_0.textLabel:setString(var_7_3)
				end

				if arg_5_0.requestType == var_0_1.typeOfActive then
					arg_5_0:removeFromParentAndCleanup(true)
				end
			end
		})
	end

	arg_5_0.activeMasterRequest = ExchangeLearnExpRequest:new()

	arg_5_0.activeMasterRequest:setResponseNormalHandler(var_5_0)
end

function var_0_2.createMasterAndDesc(arg_8_0, arg_8_1)
	addLabelWithColorSize(arg_8_1, arg_8_0.masterItem.name, getQualityColor(arg_8_0.masterItem.quality), 25, CCPoint(0.5, 0.5), CCPoint(170, 445))

	local var_8_0 = display.newSprite(MasterHelper:getBackImageByQuality(arg_8_0.masterItem.quality, true), 170, 265)

	var_8_0:setScale(1.25)
	arg_8_1:addChild(var_8_0)

	local var_8_1 = display.newSprite("master/" .. arg_8_0.masterItem.headerImage, 170, 265)

	arg_8_1:addChild(var_8_1)

	local var_8_2 = addLabelWithColorSize(arg_8_1, arg_8_0.masterItem.story, ccc3(243, 216, 151), 20, CCPoint(0, 0), CCPoint(30, 20))

	var_8_2:setDimensions(CCSize(280, 100))
	var_8_2:setHorizontalAlignment(kCCTextAlignmentLeft)
	var_8_2:setVerticalAlignment(kCCVerticalTextAlignmentCenter)

	if arg_8_0.isActivity == true then
		local var_8_3 = display.newSprite("uilocal/xunfang/xunfang_text_001.png", 30, 440)

		var_8_3:setAnchorPoint(CCPoint(0, 1))
		arg_8_1:addChild(var_8_3)

		if arg_8_0.isInTujian == false then
			local var_8_4 = MasterHelper:getMasterCount(arg_8_0.masterId)

			arg_8_0.countLabel = addLabelWithColorSize(var_8_0, 0, ccc3(0, 255, 0), 20, CCPoint(1, 0), CCPoint(150, 15))

			arg_8_0.countLabel:setString(string.lf("拥有: %s", var_8_4 == nil and 0 or var_8_4))
		end
	end
end

function var_0_2.createImpartAttr(arg_9_0, arg_9_1)
	local var_9_0 = display.newSprite("uilocal/xunfang/xunfang_text_016.png", 555, 450)

	arg_9_1:addChild(var_9_0)

	local var_9_1 = string.lf("%s: #00FF00+%s", BattleAttrsName[arg_9_0.masterItem.improveProperty], arg_9_0.masterItem.improveValue)

	addLabelWithColorSize(arg_9_1, var_9_1, ccc3(247, 211, 91), 20, CCPoint(0, 0.5), CCPoint(400, 420))
end

function var_0_2.createMasterCombo(arg_10_0, arg_10_1)
	local var_10_0 = display.newSprite("uilocal/xunfang/xunfang_text_014.png", 555, 390)

	arg_10_1:addChild(var_10_0)

	if arg_10_0.groupList == nil or table.nums(arg_10_0.groupList) == 0 then
		var_10_0:setPosition(555, 365)

		local var_10_1 = display.newSprite("uilocal/xunfang/xunfang_text_019.png", 555, 250)

		arg_10_1:addChild(var_10_1)
	else
		arg_10_0.cellSize = CCSize(400, 105)

		local var_10_2 = 210
		local var_10_3 = 160

		if arg_10_0.isActivity == true and arg_10_0.isInTujian == true then
			var_10_2 = 340
			var_10_3 = 30
		end

		local var_10_4 = createTableView({
			reverse = true,
			size = CCSize(400, var_10_2),
			direction = kCCScrollViewDirectionVertical,
			dataset = arg_10_0.groupList,
			sizehandler = function(arg_11_0, arg_11_1)
				return arg_10_0.cellSize
			end,
			cellhandler = handler(arg_10_0, arg_10_0.createTableCell)
		})

		var_10_4:setAnchorPoint(CCPoint(0, 0))
		var_10_4:setPosition(357, var_10_3)
		arg_10_1:addChild(var_10_4)
	end
end

function var_0_2.createTableCell(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = CCLayerColor:create(ccc4(0, 0, 0, 0))

	var_12_0:setContentSize(arg_12_0.cellSize)

	local var_12_1 = display.newSprite("ui/xunfang/xunfang_004.png", arg_12_0.cellSize.width / 2, 2)

	var_12_1:setScale(0.56)
	var_12_0:addChild(var_12_1)

	local var_12_2 = string.lf("%s+%d", BattleAttrsName[arg_12_3.improvePropertyType], arg_12_3.improveValue)

	addLabelWithColorSize(var_12_0, arg_12_3.name, ccc3(130, 30, 15), 22, CCPoint(0, 0.5), CCPoint(0, arg_12_0.cellSize.height * 0.8))
	addLabelWithColorSize(var_12_0, addTargetList[arg_12_3.improveTargetType], ccc3(0, 255, 0), 18, CCPoint(0, 0.5), CCPoint(0, arg_12_0.cellSize.height * 0.5))
	addLabelWithColorSize(var_12_0, var_12_2, ccc3(0, 255, 0), 18, CCPoint(0, 0.5), CCPoint(0, arg_12_0.cellSize.height * 0.25))

	local var_12_3 = arg_12_0.cellSize.width - 40
	local var_12_4 = table.nums(arg_12_3.groupCost)

	for iter_12_0, iter_12_1 in ipairs(arg_12_3.groupCost) do
		local var_12_5 = figure.createHeader({
			isName = false,
			inTeam = false,
			noTypeImage = false,
			itemId = iter_12_1.masterID,
			type = ItemType.eMaster,
			count = iter_12_1.needCount
		})

		var_12_5:setScale(0.9)
		var_12_5:setPosition(var_12_3, arg_12_0.cellSize.height / 2 + 13)
		var_12_0:addChild(var_12_5)

		if iter_12_0 < var_12_4 then
			local var_12_6 = display.newSprite("uilocal/xunfang/xunfang_text_012.png", var_12_3 - 50, arg_12_0.cellSize.height / 2 + 13)

			var_12_6:setScale(0.8)
			var_12_0:addChild(var_12_6)
		end

		local var_12_7 = getItemQuality(ItemType.eMaster, iter_12_1.masterID)

		addLabelWithColorSize(var_12_0, getItemName(ItemType.eMaster, iter_12_1.masterID), getQualityColor(var_12_7), 18, CCPoint(0.5, 0), CCPoint(var_12_3, 3))

		var_12_3 = var_12_3 - 100
	end

	return var_12_0
end

function var_0_2.createActiveMaster(arg_13_0, arg_13_1)
	if arg_13_0.isActivity == true then
		if arg_13_0.isInTujian == true then
			return
		end

		local var_13_0 = display.newSprite("uilocal/xunfang/xunfang_text_020.png", 555, 130)

		arg_13_1:addChild(var_13_0)

		local var_13_1 = CCSize(216, 30)
		local var_13_2 = display.newScale9Sprite("ui/xunfang/xunfang_045.png", 445, 95, CCSize(var_13_1.width - 10, var_13_1.height))
		local var_13_3 = display.newScale9Sprite("ui/xunfang/xunfang_045.png", 665, 95, CCSize(var_13_1.width + 10, var_13_1.height))

		arg_13_1:addChild(var_13_2)
		arg_13_1:addChild(var_13_3)

		local var_13_4 = Player.learnExp
		local var_13_5 = arg_13_0.masterItem.needLearnExp
		local var_13_6 = string.lf("兑换需要授业值:%s %s/%s", var_13_5 <= var_13_4 and "#00FF00" or "#FF0000", var_13_4, var_13_5)

		addLabelWithColorSize(var_13_2, string.lf("分解可得授业值: #00FF00%s", arg_13_0.masterItem.resolveLearnExp), ccc3(247, 211, 91), 17, CCPoint(0, 0.5), CCPoint(0, var_13_1.height / 2))

		arg_13_0.textLabel = addLabelWithColorSize(var_13_3, var_13_6, ccc3(247, 211, 91), 17, CCPoint(0, 0.5), CCPoint(0, var_13_1.height / 2))

		local var_13_7 = ui.newControlButton({
			disabledImage = "ui/common/common_115.png",
			titleImage = "uilocal/xunfang/xunfang_text_017.png",
			normalImage = "ui/common/common_115.png",
			position = CCPoint(445, 40),
			clickAction = function(arg_14_0, arg_14_1)
				local var_14_0 = MasterHelper:getMasterCount(arg_13_0.masterId)

				if var_14_0 == nil or var_14_0 == 0 then
					showFlashNotice(string.lf("上仙，该卡牌已经消耗完了~~"))

					return
				end

				arg_13_0.requestType = var_0_1.typeOfResolve

				arg_13_0.activeMasterRequest:request(arg_13_0.masterId, 0, 1)
			end
		})
		local var_13_8 = ui.newControlButton({
			disabledImage = "ui/common/common_115.png",
			titleImage = "uilocal/xunfang/xunfang_text_018.png",
			normalImage = "ui/common/common_115.png",
			position = CCPoint(665, 40),
			clickAction = function(arg_15_0, arg_15_1)
				if var_13_4 < var_13_5 then
					showFlashNotice(string.lf("上仙，您的授业值不足哦~~"))

					return
				end

				arg_13_0.requestType = var_0_1.typeOfExchange

				arg_13_0.activeMasterRequest:request(0, arg_13_0.masterId, 1)
			end
		})

		arg_13_1:addChild(var_13_7)
		arg_13_1:addChild(var_13_8)
	else
		local var_13_9 = display.newSprite("uilocal/xunfang/xunfang_text_015.png", 555, 130)

		arg_13_1:addChild(var_13_9)

		local var_13_10 = CCSize(400, 30)
		local var_13_11 = display.newScale9Sprite("ui/xunfang/xunfang_045.png", 555, 95, var_13_10)

		arg_13_1:addChild(var_13_11)

		local var_13_12 = Player.learnExp
		local var_13_13 = arg_13_0.masterItem.needLearnExp
		local var_13_14 = string.lf("激活需要授业值:%s %s/%s", var_13_13 <= var_13_12 and "#00FF00" or "#FF0000", var_13_12, var_13_13)

		arg_13_0.textLabel = addLabelWithColorSize(var_13_11, var_13_14, ccc3(247, 211, 91), 20, CCPoint(0.5, 0.5), CCPoint(var_13_10.width / 2, var_13_10.height / 2))

		local var_13_15 = ui.newControlButton({
			disabledImage = "ui/common/common_115.png",
			titleImage = "uilocal/xunfang/xunfang_text_013.png",
			normalImage = "ui/common/common_115.png",
			position = CCPoint(555, 40),
			clickAction = function(arg_16_0, arg_16_1)
				if var_13_12 < var_13_13 then
					showFlashNotice(string.lf("上仙，您的授业值不足哦~~"))

					return
				end

				arg_13_0.requestType = var_0_1.typeOfActive

				arg_13_0.activeMasterRequest:request(0, arg_13_0.masterId, 1)
			end
		})

		arg_13_1:addChild(var_13_15)
	end
end

return var_0_2
