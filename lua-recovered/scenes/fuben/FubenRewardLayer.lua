require("data.fuben")
require("network.FubenRequest")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = require("scenes.ToolLayer")
local var_0_2 = class("FubenRewardLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

function var_0_2.ctor(arg_2_0, arg_2_1)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.copyInfo = arg_2_1.copy
	arg_2_0.callBack = arg_2_1.callBack
	arg_2_0.starCount = arg_2_0.copyInfo.OpenCardNumber or 0
	arg_2_0.itemTable = {}

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.copyInfo.OpenCardReward) do
		local var_2_1 = {
			type = iter_2_1.Type,
			id = iter_2_1.ID,
			name = getItemName(iter_2_1.Type, iter_2_1.ID),
			count = iter_2_1.Count,
			price = iter_2_1.Cost,
			limit = iter_2_1.Last,
			location = iter_2_1.Location
		}

		table.insert(var_2_0, var_2_1)

		if #var_2_0 == 2 then
			table.insert(arg_2_0.itemTable, var_2_0)

			var_2_0 = {}
		end
	end

	if #var_2_0 > 0 then
		table.insert(arg_2_0.itemTable, var_2_0)
	end

	local var_2_2 = require("scenes.CommonBgLayer").new({
		titleSprite = "uilocal/fuben/fuben_text_005.png",
		returnAction = function()
			if arg_2_0.starCount > 0 then
				showFlashNotice(string.lf("您必须把星星花完才能退出！"))

				return
			end

			if arg_2_0.callBack then
				arg_2_0.callBack()
			end

			arg_2_0:removeFromParentAndCleanup(true)
		end
	})
	local var_2_3 = var_2_2:getBackgroundSprite()
	local var_2_4 = var_2_3:getContentSize()

	arg_2_0:addChild(var_2_2)

	local var_2_5 = display.newScale9Sprite("ui/store/store_032.jpg", 480, 5, CCSize(950, 570))

	var_2_5:setAnchorPoint(CCPoint(0.5, 0))
	var_2_3:addChild(var_2_5, 0)

	arg_2_0.bgSprite = var_2_3
	arg_2_0.bgSize = var_2_4

	local var_2_6 = display.newSprite("ui/common/common_077.png", arg_2_0.bgSize.width / 2 + 40, arg_2_0.bgSize.height - 35)

	var_2_6:setAnchorPoint(CCPoint(0, 0.5))
	arg_2_0.bgSprite:addChild(var_2_6)
	addLabelWithColorSize(arg_2_0.bgSprite, string.lf("提示: 星星可以通过挑战该副本获得。"), ccc3(255, 255, 255), 20, CCPoint(0.5, 0.5), CCPoint(arg_2_0.bgSize.width / 2, 30))

	local var_2_7 = addLabelWithColorSize(arg_2_0.bgSprite, string.lf("拥有"), ccc3(255, 255, 255), 20, CCPoint(0, 0.5), CCPoint(arg_2_0.bgSize.width / 2, arg_2_0.bgSize.height - 35))

	arg_2_0.starLabel = addLabelWithColorSize(arg_2_0.bgSprite, ": " .. arg_2_0.starCount, ccc3(255, 255, 255), 20, CCPoint(0, 0.5), CCPoint(arg_2_0.bgSize.width / 2 + 80, arg_2_0.bgSize.height - 35))

	if arg_2_0.starCount == 0 then
		var_2_6:setVisible(false)
		var_2_7:setVisible(false)
		arg_2_0.starLabel:setVisible(false)
	end

	local var_2_8 = arg_2_0:createPropView()

	var_2_8:setPosition(50, 65)
	var_2_3:addChild(var_2_8)
	arg_2_0:initRequests()
end

function var_0_2.initRequests(arg_5_0)
	local function var_5_0()
		if arg_5_0.openCardRequest.restable then
			arg_5_0.starCount = arg_5_0.openCardRequest.restable

			arg_5_0.starLabel:runAction(CCBlink:create(0.5, 2))
			arg_5_0.starLabel:setString(": " .. arg_5_0.starCount)

			if arg_5_0.currLocation ~= nil then
				for iter_6_0 = 1, table.nums(arg_5_0.itemTable) do
					local var_6_0 = arg_5_0.itemTable[iter_6_0]

					for iter_6_1, iter_6_2 in pairs(var_6_0) do
						if iter_6_2.location == arg_5_0.currLocation then
							iter_6_2.limit = iter_6_2.limit - 1

							break
						end
					end
				end

				arg_5_0.currLocation = nil
			end

			arg_5_0.tableview:reloadData()
			showFlashImage({
				image = "uilocal/enhance/enhance_txt_007.png",
				scale = 1,
				parent = arg_5_0.bgSprite,
				position = CCPoint(arg_5_0.bgSize.width / 2, arg_5_0.bgSize.height / 2),
				callback = function()
					return
				end
			})
		end
	end

	arg_5_0.openCardRequest = OpenCardRequest:new()

	arg_5_0.openCardRequest:setResponseNormalHandler(var_5_0)
end

function var_0_2.createPropView(arg_8_0)
	local var_8_0 = CCSize(850, 460)
	local var_8_1 = {
		direction = kCCScrollViewDirectionVertical,
		size = var_8_0,
		dataset = arg_8_0.itemTable,
		sizehandler = function(arg_9_0, arg_9_1)
			return CCSize(850, 156)
		end,
		cellhandler = handler(arg_8_0, arg_8_0.createPropList)
	}
	local var_8_2 = createTableView(var_8_1)

	var_8_2:setTouchEnabled(false)

	arg_8_0.tableview = var_8_2

	return var_8_2
end

function var_0_2.createPropList(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = CCSize(850, 156)
	local var_10_1 = var_0_0.newNode()

	var_10_1:setContentSize(var_10_0)

	local var_10_2 = display.newScale9Sprite("ui/store/store_023.png")

	var_10_2:setContentSize(CCSize(var_10_0.width, 48))
	var_10_2:setPosition(var_10_0.width / 2, 13)
	var_10_1:addChild(var_10_2)

	local var_10_3
	local var_10_4 = 10
	local var_10_5 = 18

	for iter_10_0, iter_10_1 in ipairs(arg_10_3) do
		local var_10_6 = arg_10_0:createPropItem(iter_10_1)

		var_10_6:setPosition(var_10_4, var_10_5)
		var_10_1:addChild(var_10_6)

		var_10_4 = var_10_4 + 420
	end

	return var_10_1
end

function var_0_2.createPropItem(arg_11_0, arg_11_1)
	local var_11_0 = CCSize(420, 145)
	local var_11_1 = var_0_0.newNode()

	var_11_1:setContentSize(var_11_0)

	local function var_11_2(arg_12_0)
		local var_12_0
		local var_12_1 = 0
		local var_12_2 = true

		if arg_12_0.type == ItemType.eFragment then
			local var_12_3 = 0
			local var_12_4 = Player:getItemCount(arg_12_0.type, arg_12_0.id)
			local var_12_5 = BaseFragments[arg_12_0.id].exchangeCount

			var_12_0 = string.lf("(已拥有: %s/%s)", tostring(var_12_4), tostring(var_12_5))
		elseif arg_12_0.type == ItemType.eHero then
			local var_12_6 = Player:getItemCount(arg_12_0.type, arg_12_0.id)

			var_12_2 = var_12_6 < 1
			var_12_0 = var_12_6 > 0 and string.lf("(已拥有)") or string.lf("(未拥有)")
		elseif arg_12_0.type == ItemType.eSoul then
			local var_12_7 = Player:getItemCount(arg_12_0.type, arg_12_0.id)

			var_12_0 = string.lf("(已拥有: %s)", tostring(var_12_7))
		end

		return var_12_0, var_12_2
	end

	local var_11_3 = figure.createHeader({
		isName = false,
		inTeam = false,
		isStoreBkground = true,
		itemId = arg_11_1.id,
		type = arg_11_1.type,
		count = arg_11_1.count,
		clickAction = function()
			var_0_1.tipshandler({
				Type = arg_11_1.type,
				ID = arg_11_1.id,
				Count = arg_11_1.count
			})
		end
	})

	var_11_3:setPosition(75, var_11_0.height / 2)
	var_11_1:addChild(var_11_3)

	local var_11_4, var_11_5 = var_11_2(arg_11_1)

	if var_11_4 then
		local var_11_6 = var_0_0.newLabel({
			size = 20,
			text = var_11_4,
			font = _FONT_DEFAULT,
			color = ccc3(120, 230, 90)
		})

		var_11_6:setAnchorPoint(ccp(0, 0.5))
		var_11_6:setPosition(155, 40)
		var_11_1:addChild(var_11_6)

		var_11_1.desc = var_11_6
	end

	local var_11_7 = arg_11_1.name
	local var_11_8 = getItemQuality(arg_11_1.type, arg_11_1.id)
	local var_11_9 = getQualityColor(var_11_8)

	if arg_11_1.type ~= ItemType.eHero then
		var_11_7 = var_11_7 .. "x" .. arg_11_1.count
	end

	if arg_11_1.type == ItemType.eTrainPill then
		var_11_9.r = var_11_9.r + 50
		var_11_9.g = var_11_9.g + 50
		var_11_9.b = var_11_9.b + 20
	end

	local var_11_10 = var_0_0.newLabel({
		size = 24,
		outline = true,
		text = var_11_7,
		color = var_11_9
	})

	var_11_10:setAnchorPoint(ccp(0, 0.5))
	var_11_10:setPosition(155, 110)
	var_11_1:addChild(var_11_10)

	local var_11_11 = display.newSprite("ui/common/common_077.png", 195, 75)

	var_11_11:setAnchorPoint(CCPoint(0, 0.5))
	var_11_1:addChild(var_11_11)
	addLabelWithColorSize(var_11_1, string.lf("消耗"), ccc3(255, 255, 255), 20, CCPoint(0, 0.5), CCPoint(155, 75))
	addLabelWithColorSize(var_11_1, ": " .. arg_11_1.price, ccc3(255, 255, 255), 20, CCPoint(0, 0.5), CCPoint(235, 75))

	local var_11_12 = ui.newControlButton({
		normalImage = "ui/store/store_022.png",
		text = string.lf("购买"),
		fontSize = ColorTable.eTitleButton_FontSize,
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = function(arg_14_0, arg_14_1)
			if arg_11_0.starCount >= arg_11_1.price then
				arg_11_0.currLocation = arg_11_1.location

				arg_11_0.openCardRequest:request(arg_11_0.copyInfo.CopyID, arg_11_1.location)
			else
				showFlashNotice(string.lf("您的星星数量不足"))
			end
		end
	})

	var_11_12:setTitleColorForState(ccc3(120, 120, 120), CCControlStateDisabled)
	var_11_12:setPosition(365, var_11_0.height / 2)
	var_11_12:setEnabled(arg_11_1.limit > 0 and arg_11_0.starCount >= arg_11_1.price)
	var_11_1:addChild(var_11_12)

	return var_11_1
end

return var_0_2
