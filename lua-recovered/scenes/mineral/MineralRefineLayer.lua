require("base.figure")
require("network.MineralRequest")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = require("scenes.ToolLayer")
local var_0_2 = {
	typeOfSrc = 1,
	typeOfDst = 2
}
local var_0_3 = class("MineralRefineLayer", function()
	return CCScale9Sprite:create("ui/friend/friend_003.png")
end)

function var_0_3.ctor(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1 and arg_2_1.layerSize and arg_2_1.layerSize or CCSize(920, 508)

	arg_2_0:setPreferredSize(var_2_0)

	arg_2_0.gParent = arg_2_1.gparent
	arg_2_0.size = var_2_0
	arg_2_0.container = arg_2_0
	arg_2_0.itemList = {
		{
			type = var_0_2.typeOfSrc
		},
		{
			type = var_0_2.typeOfSrc
		},
		{
			type = var_0_2.typeOfSrc
		},
		{
			type = var_0_2.typeOfDst
		}
	}

	arg_2_0:initRequest()
	arg_2_0:onEnterAlias()
end

function var_0_3.initRequest(arg_3_0)
	local function var_3_0()
		local var_4_0 = arg_3_0.refineRequest.restable
		local var_4_1 = 0

		local function var_4_2()
			var_4_1 = var_4_1 - 1

			if var_4_1 > 0 then
				return
			end

			for iter_5_0, iter_5_1 in pairs(arg_3_0.itemList) do
				if iter_5_1.item ~= nil or iter_5_1.type == var_0_2.typeOfDst then
					if iter_5_1.type == var_0_2.typeOfSrc then
						MineralHelper:delItem({
							iter_5_1.item
						})

						iter_5_1.item = nil

						arg_3_0:setMineralItem(iter_5_1)
					elseif var_4_0.Gems ~= nil and var_4_0.Gems[1] ~= nil then
						iter_5_1.item = var_4_0.Gems[1]

						arg_3_0:setMineralItem(iter_5_1)
					else
						showFlashNotice(string.lf("上仙，合成失败了，请再接再厉吧~~"))
					end
				end
			end

			arg_3_0.bagLayer:reloadBagLayer(nil)
			arg_3_0:resetRefineInfo()
		end

		for iter_4_0, iter_4_1 in pairs(arg_3_0.itemList) do
			if iter_4_1.item ~= nil or iter_4_1.type == var_0_2.typeOfDst then
				var_4_1 = var_4_1 + 1

				local var_4_3 = iter_4_1.node:getContentSize()
				local var_4_4 = CCSkeletonAnimation:createWithFile("effectAni/ui_zhuangbeiqianghua.json", "effectAni/ui_zhuangbeiqianghua.atlas", 1)

				var_4_4:setAnimation("animation", false, 0)
				var_4_4:setPosition(CCPoint(var_4_3.width / 2, var_4_3.height / 2))
				iter_4_1.node:addChild(var_4_4, 1)
				var_4_4:addAnimationAction("animation", 1, CCCallFunc:create(var_4_2), AAT_Percent)
			end
		end

		arg_3_0.btnAutoAdd:setEnabled(true)
	end

	arg_3_0.refineRequest = MineralRefineRequest:new()

	arg_3_0.refineRequest:setResponseNormalHandler(var_3_0)

	local function var_3_1()
		local var_6_0 = arg_3_0.autoPutAllRequest.restable

		for iter_6_0, iter_6_1 in pairs(arg_3_0.itemList) do
			if iter_6_1.type == var_0_2.typeOfSrc and iter_6_1.item ~= nil then
				arg_3_0.bagLayer:addItem(iter_6_1.item)
			end
		end

		local var_6_1

		for iter_6_2, iter_6_3 in ipairs(var_6_0) do
			local var_6_2 = arg_3_0.bagLayer:findItem(iter_6_3)

			if var_6_1 == nil then
				var_6_1 = var_6_2.level
			end

			arg_3_0.bagLayer:delItem(var_6_2)

			arg_3_0.itemList[iter_6_2].item = var_6_2

			arg_3_0:setMineralItem(arg_3_0.itemList[iter_6_2])
		end

		arg_3_0.bagLayer:reloadData(var_6_1)
		arg_3_0:resetRefineInfo()
		arg_3_0.btnAutoAdd:setEnabled(true)
	end

	arg_3_0.autoPutAllRequest = MineralPutAllRequest:new()

	arg_3_0.autoPutAllRequest:setResponseNormalHandler(var_3_1)

	local function var_3_2()
		local var_7_0 = arg_3_0.allRefineRequest.restable

		MineralHelper:delItem(var_7_0.Consume)

		if var_7_0.Gems ~= nil then
			arg_3_0.gParent:addChild(require("scenes.mineral.MineralGetGemLayer").new({
				parent = arg_3_0,
				data = var_7_0.Gems,
				textTitle = string.lf("本次共消耗%s个低级宝石", table.maxn(var_7_0.Consume))
			}))
		end

		arg_3_0.bagLayer:reloadBagLayer(nil)
		arg_3_0.btnAllRefine:setEnabled(true)
		arg_3_0.btnAutoAdd:setEnabled(true)
	end

	local function var_3_3()
		arg_3_0.btnAllRefine:setEnabled(true)
		arg_3_0.btnAutoAdd:setEnabled(true)
	end

	arg_3_0.allRefineRequest = MineralRefineAllRequest:new()

	arg_3_0.allRefineRequest:setResponseNormalHandler(var_3_2)
	arg_3_0.allRefineRequest:setResponseExceptionHandler(var_3_3)
end

function var_0_3.onEnterAlias(arg_9_0)
	local var_9_0 = arg_9_0.size
	local var_9_1 = arg_9_0.container
	local var_9_2 = display.newSprite("ui/mineral/mineral_08.jpg", 5, var_9_0.height / 2)
	local var_9_3 = var_9_2:getContentSize()

	var_9_2:setAnchorPoint(CCPoint(0, 0.5))
	var_9_1:addChild(var_9_2)

	arg_9_0.bgSprite = var_9_2

	addLabelWithColorSize(var_9_2, string.lf("3个同类型的宝石，100%可以合成得到更高级的宝石"), ccc3(196, 151, 79), 18, CCPoint(0.5, 0.5), CCPoint(var_9_3.width / 2, 467))
	addLabelWithColorSize(var_9_2, string.lf("不同类型的宝石，随机概率得到更高级的宝石类型"), ccc3(196, 151, 79), 18, CCPoint(0.5, 0.5), CCPoint(var_9_3.width / 2, 442))

	arg_9_0.ratioLabel = addLabelWithColorSize(var_9_2, string.lf("成功率:%d%%", 0), ccc3(247, 247, 247), 20, CCPoint(0.5, 0.5), CCPoint(var_9_3.width / 2, 90))
	arg_9_0.btnAllRefine = ui.newControlButton({
		disabledImage = "ui/common/common_080.png",
		normalImage = "ui/common/common_019.png",
		text = string.lf("一键合成"),
		textColor = ColorTable.eTitleButton_Normal2,
		fontSize = ColorTable.eTitleButton_FontSize2,
		anchorPoint = CCPoint(0.5, 0),
		position = CCPoint(var_9_3.width / 2 - 160, 10),
		clickAction = function()
			ui.showMessageBox({
				animate = "spring",
				type = "dialog",
				text = string.lf("背包内符合条件的1~3级宝石将会自动被合成为随机的4级宝石；如果需要指定形状的宝石，建议手动合成。"),
				title1 = string.lf("合成"),
				title2 = string.lf("取消"),
				action1 = function()
					arg_9_0.btnAllRefine:setEnabled(false)
					arg_9_0.btnAutoAdd:setEnabled(false)
					arg_9_0.btnRefine:setEnabled(false)

					for iter_11_0, iter_11_1 in pairs(arg_9_0.itemList) do
						if iter_11_1.item ~= nil then
							iter_11_1.item = nil

							arg_9_0:setMineralItem(iter_11_1)
						end
					end

					arg_9_0.allRefineRequest:request()
				end,
				action2 = function()
					return
				end
			})
		end
	})
	arg_9_0.btnAutoAdd = ui.newControlButton({
		disabledImage = "ui/common/common_080.png",
		normalImage = "ui/common/common_019.png",
		text = string.lf("一键放入"),
		textColor = ColorTable.eTitleButton_Normal2,
		fontSize = ColorTable.eTitleButton_FontSize2,
		anchorPoint = CCPoint(0.5, 0),
		position = CCPoint(var_9_3.width / 2, 10),
		clickAction = function()
			local var_13_0 = true

			for iter_13_0, iter_13_1 in pairs(arg_9_0.itemList) do
				if iter_13_1.type == var_0_2.typeOfSrc and iter_13_1.item == nil then
					var_13_0 = false

					break
				end
			end

			if var_13_0 == true then
				showFlashNotice(string.lf("上仙，合成材料已满，请立刻开始合成吧~~"))

				return
			end

			if MineralHelper:isEmpty() == true then
				showFlashNotice(string.lf("上仙，包裹已空，请立刻去采矿收集宝石吧~~"))

				return
			end

			arg_9_0.btnAutoAdd:setEnabled(false)
			arg_9_0.autoPutAllRequest:request()
		end
	})
	arg_9_0.btnRefine = ui.newControlButton({
		disabledImage = "ui/common/common_080.png",
		normalImage = "ui/common/common_019.png",
		text = string.lf("合成"),
		textColor = ColorTable.eTitleButton_Normal2,
		fontSize = ColorTable.eTitleButton_FontSize2,
		anchorPoint = CCPoint(0.5, 0),
		position = CCPoint(var_9_3.width / 2 + 160, 10),
		clickAction = function()
			local var_14_0
			local var_14_1 = 0

			for iter_14_0, iter_14_1 in pairs(arg_9_0.itemList) do
				if iter_14_1.type == var_0_2.typeOfSrc and iter_14_1.item ~= nil then
					if var_14_0 == nil then
						var_14_0 = iter_14_1.item.id
					else
						var_14_0 = var_14_0 .. "," .. iter_14_1.item.id
					end

					var_14_1 = var_14_1 + 1
				end
			end

			if var_14_1 < 2 or var_14_0 == nil then
				showFlashNotice(string.lf("上仙，您的合成材料不足哦~~"))

				return
			end

			arg_9_0.btnAutoAdd:setEnabled(false)
			arg_9_0.btnRefine:setEnabled(false)
			arg_9_0.refineRequest:request(var_14_0)
		end
	})

	arg_9_0.btnRefine:setEnabled(false)
	var_9_2:addChild(arg_9_0.btnAllRefine)
	var_9_2:addChild(arg_9_0.btnAutoAdd)
	var_9_2:addChild(arg_9_0.btnRefine)

	arg_9_0.itemList[1].position = CCPoint(var_9_3.width / 2 - 7, var_9_3.height / 2 + 130)
	arg_9_0.itemList[2].position = CCPoint(var_9_3.width / 2 - 117, var_9_3.height / 2 - 60)
	arg_9_0.itemList[3].position = CCPoint(var_9_3.width / 2 + 103, var_9_3.height / 2 - 60)
	arg_9_0.itemList[4].position = CCPoint(var_9_3.width / 2 - 7, var_9_3.height / 2 + 15)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.itemList) do
		arg_9_0:setMineralItem(iter_9_1)
	end

	arg_9_0.bagLayer = require("scenes.mineral.MineralBagLayer").new({
		showEnterAnimation = false,
		tipsButtonItems = {
			{
				text = string.lf("合成"),
				callback = function(arg_15_0)
					if arg_15_0.item == nil then
						return
					end

					if arg_9_0:haveEmptyPlace() == nil then
						showFlashNotice(string.lf("上仙，合成材料已满，请立刻开始合成吧~~"))

						return
					end

					local var_15_0 = arg_9_0.bagLayer.lastClickNode

					var_15_0:setEnabled(false)
					arg_9_0:addToStove(arg_15_0.item, CCPoint(var_15_0:getPositionX() + 511, var_15_0:getPositionY() + 80))
				end
			}
		}
	})

	var_9_1:addChild(arg_9_0.bagLayer, 1)
end

function var_0_3.addToStove(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == nil or arg_16_2 == nil then
		return
	end

	local var_16_0 = arg_16_0:haveEmptyPlace()

	if var_16_0 == nil then
		return
	end

	local var_16_1 = arg_16_0.itemList[var_16_0]

	var_16_1.item = arg_16_1

	arg_16_0.bagLayer:delItem(arg_16_1)
	arg_16_0.bagLayer:reloadData(arg_16_1.level)
	arg_16_0.btnRefine:setEnabled(false)

	local var_16_2 = figure.createMineralHeader({
		itemId = arg_16_1.gemProtoID or 0,
		level = arg_16_1.level
	})

	var_16_2:setPosition(arg_16_2)
	arg_16_0.container:addChild(var_16_2, 2)

	local var_16_3 = CCArray:create()

	var_16_3:addObject(CCMoveTo:create(0.5, CCPoint(var_16_1.position.x + 5, var_16_1.position.y + 6)))
	var_16_3:addObject(CCCallFunc:create(function()
		var_16_2:removeFromParentAndCleanup(true)
		arg_16_0:setMineralItem(var_16_1)
		arg_16_0:resetRefineInfo()
	end))
	var_16_2:runAction(CCSequence:create(var_16_3))
end

function var_0_3.removeFromStove(arg_18_0, arg_18_1)
	if arg_18_1 == nil or arg_18_1.item == nil then
		return
	end

	local var_18_0 = figure.createMineralHeader({
		itemId = arg_18_1.gemProtoID or 0,
		level = arg_18_1.level
	})

	var_18_0:setPosition(CCPoint(arg_18_1.position.x + 5, arg_18_1.position.y + 6))
	arg_18_0.container:addChild(var_18_0, 2)

	local var_18_1 = arg_18_1.item

	arg_18_1.item = nil

	arg_18_0:setMineralItem(arg_18_1)
	arg_18_0:resetRefineInfo()
	arg_18_0.btnRefine:setEnabled(false)

	local var_18_2 = CCArray:create()

	var_18_2:addObject(CCMoveTo:create(0.5, CCPoint(577, 395)))
	var_18_2:addObject(CCCallFunc:create(function()
		var_18_0:removeFromParentAndCleanup(true)

		local var_19_0

		arg_18_0.bagLayer:addItem(var_18_1)

		for iter_19_0, iter_19_1 in pairs(arg_18_0.itemList) do
			if iter_19_1.type == var_0_2.typeOfSrc and iter_19_1.item ~= nil then
				var_19_0 = iter_19_1.item.level

				break
			end
		end

		arg_18_0.bagLayer:reloadData(var_19_0)
		arg_18_0:resetRefineInfo()
	end))
	var_18_0:runAction(CCSequence:create(var_18_2))
end

function var_0_3.setMineralItem(arg_20_0, arg_20_1)
	if arg_20_1 == nil or arg_20_1.position == nil then
		return
	end

	if arg_20_1.node ~= nil then
		arg_20_1.node:removeFromParentAndCleanup(true)

		arg_20_1.node = nil
	end

	local var_20_0 = arg_20_1.item ~= nil and arg_20_1.item.gemProtoID ~= nil and arg_20_1.item.gemProtoID or 0
	local var_20_1

	var_20_1 = figure.createMineralHeader({
		itemId = var_20_0,
		level = arg_20_1.item ~= nil and arg_20_1.item.level or 1,
		clickAction = function()
			local var_21_0

			if arg_20_1.type == var_0_2.typeOfSrc then
				var_21_0 = {
					{
						text = string.lf("移除"),
						callback = function(arg_22_0)
							arg_20_0:removeFromStove(arg_20_1)
						end
					}
				}
			end

			require("scenes.mineral.MineralTipLayer").new({
				mineralItem = arg_20_1.item,
				node = var_20_1,
				buttonItems = var_21_0
			})
		end
	})

	var_20_1:setPosition(arg_20_1.position)
	arg_20_0.bgSprite:addChild(var_20_1)

	arg_20_1.node = var_20_1
end

function var_0_3.haveEmptyPlace(arg_23_0)
	local var_23_0

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.itemList) do
		if iter_23_1.type == var_0_2.typeOfSrc and iter_23_1.item == nil then
			var_23_0 = iter_23_0

			break
		end
	end

	return var_23_0
end

function var_0_3.resetRefineInfo(arg_24_0)
	local var_24_0 = 0

	for iter_24_0, iter_24_1 in pairs(arg_24_0.itemList) do
		if iter_24_1.type == var_0_2.typeOfSrc and iter_24_1.item ~= nil then
			var_24_0 = var_24_0 + 1
		end
	end

	if var_24_0 == 3 then
		arg_24_0.btnRefine:setEnabled(true)
		arg_24_0.ratioLabel:setString(string.lf("成功率:%d%%", 100))
	elseif var_24_0 == 2 then
		arg_24_0.btnRefine:setEnabled(true)
		arg_24_0.ratioLabel:setString(string.lf("成功率:%d%%", 50))
	else
		arg_24_0.btnRefine:setEnabled(false)
		arg_24_0.ratioLabel:setString(string.lf("成功率:%d%%", 0))
	end
end

return var_0_3
