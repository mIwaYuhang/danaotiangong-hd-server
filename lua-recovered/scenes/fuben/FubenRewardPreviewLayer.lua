require("network.FubenRequest")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = require("base.cache")
local var_0_2 = class("FubenRewardPreviewLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

function var_0_2.ctor(arg_2_0, arg_2_1)
	arg_2_0:setColor(display.COLOR_BLACK)
	arg_2_0:setOpacity(120)

	local function var_2_0(arg_3_0, arg_3_1, arg_3_2)
		return true
	end

	arg_2_0:addTouchEventListener(var_2_0, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	local var_2_1 = require("scenes.CommonBgLayer").new({
		closeButtonNormalImage = "ui/common/btn_closed.png",
		isHideBgSprite = true,
		closeButtonPosition = ccp(916, 575),
		returnAction = function()
			arg_2_0:removeFromParentAndCleanup(true)
		end
	})

	arg_2_0:addChild(var_2_1)

	local var_2_2 = var_2_1:getBackgroundSprite()

	arg_2_0.bgSprite = display.newSprite("ui/fuben/fuben_34.png", 480, 311)

	var_2_2:addChild(arg_2_0.bgSprite)

	local var_2_3 = display.newSprite("uilocal/fuben/fuben_text_006.png", 469, 580)

	var_2_2:addChild(var_2_3)
	arg_2_0:showDropList()
	arg_2_0:initRequests()

	local var_2_4 = var_0_1.get("GetPreviewInfoRequest")

	if var_2_4 == nil then
		arg_2_0.previewInfoRequest:request()
	else
		arg_2_0.tableview:reloadData(var_2_4)
	end
end

function var_0_2.createDropItem(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = display.newSprite("ui/fuben/fuben_33.png", 0, 0)

	var_5_0:setAnchorPoint(ccp(0, 0))

	local var_5_1 = arg_5_3.CopyID
	local var_5_2 = display.newSprite("ui/fuben/fuben_004.png", 125, 100)

	var_5_0:addChild(var_5_2)

	local var_5_3 = display.newSprite("ui/fuben/" .. FubenData[var_5_1].headImage, 60, 60)

	var_5_2:addChild(var_5_3)

	local var_5_4 = display.newSprite("uilocal/fuben/" .. FubenData[var_5_1].nameImage, 60, -10)

	var_5_2:addChild(var_5_4)

	local var_5_5 = 240

	for iter_5_0, iter_5_1 in ipairs(arg_5_3.Preview) do
		local var_5_6 = {
			isName = true,
			type = iter_5_1.Type,
			itemId = iter_5_1.ID or 0,
			nameColor = ccc3(0, 0, 0),
			count = iter_5_1.Count,
			clickAction = function()
				var_0_0.tipshandler(iter_5_1)
			end
		}
		local var_5_7 = figure.createHeader(var_5_6)

		var_5_7:setPosition(var_5_5 + iter_5_0 * 100, 110)
		var_5_0:addChild(var_5_7)
	end

	return var_5_0
end

function var_0_2.showDropList(arg_7_0)
	local var_7_0 = {
		reverse = true,
		direction = kCCScrollViewDirectionVertical,
		size = CCSize(935, 500),
		sizehandler = function(arg_8_0, arg_8_1)
			return CCSize(935, 182)
		end,
		cellhandler = handler(arg_7_0, arg_7_0.createDropItem)
	}

	arg_7_0.tableview = createTableView(var_7_0)

	arg_7_0.tableview:setPosition(-10, 13)
	arg_7_0.bgSprite:addChild(arg_7_0.tableview)
end

function var_0_2.initRequests(arg_9_0)
	local function var_9_0()
		local var_10_0 = arg_9_0.previewInfoRequest:getDropList()

		var_0_1.set("GetPreviewInfoRequest", var_10_0)
		arg_9_0.tableview:reloadData(var_10_0)
	end

	arg_9_0.previewInfoRequest = GetPreviewInfoRequest:new()

	arg_9_0.previewInfoRequest:setResponseNormalHandler(var_9_0)
end

return var_0_2
