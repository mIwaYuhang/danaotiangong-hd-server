require("data.MasterHelper")

local var_0_0 = require("base.cache")
local var_0_1 = class("XFTujianLayer", function()
	return CCLayerColor:create(ccc4(10, 10, 10, 210), display.width, display.height)
end)
local var_0_2 = 0

local function var_0_3(arg_2_0)
	local var_2_0 = MasterHelper:getAllMasterList(arg_2_0)
	local var_2_1 = {}
	local var_2_2 = {}

	var_0_2 = table.nums(var_2_0)

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		iter_2_1.masterId = iter_2_0

		table.insert(var_2_1, iter_2_1)
	end

	table.sort(var_2_1, function(arg_3_0, arg_3_1)
		return arg_3_0.masterId < arg_3_1.masterId
	end)

	local var_2_3 = 0
	local var_2_4 = {}

	local function var_2_5()
		table.insert(var_2_2, var_2_4)

		var_2_3 = 0
		var_2_4 = {}
	end

	for iter_2_2, iter_2_3 in ipairs(var_2_1) do
		table.insert(var_2_4, iter_2_3)

		var_2_3 = var_2_3 + 1

		if var_2_3 == 4 then
			var_2_5()
		end
	end

	if table.nums(var_2_4) > 0 then
		var_2_5()
	end

	return var_2_2
end

function var_0_1.ctor(arg_5_0, arg_5_1)
	arg_5_0:addTouchEventListener(function(arg_6_0, arg_6_1, arg_6_2)
		return true
	end, false, 1, true)
	arg_5_0:setTouchEnabled(true)

	local var_5_0 = display.newSprite("ui/xunfang/xunfang_002.png")

	var_5_0:setScale(Adapter.MinScale)
	var_5_0:setPosition(ccp(display.cx, display.cy))
	arg_5_0:addChild(var_5_0)

	var_0_2 = 0
	arg_5_0.bgSprite = var_5_0
	arg_5_0.bgSize = var_5_0:getContentSize()
	arg_5_0.masterList = {}

	local var_5_1 = display.newSprite("uilocal/xunfang/xunfang_text_011.png", arg_5_0.bgSize.width / 2, arg_5_0.bgSize.height - 36)

	var_5_0:addChild(var_5_1)

	local var_5_2 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		position = CCPoint(arg_5_0.bgSize.width - 28, arg_5_0.bgSize.height - 36),
		clickAction = function()
			arg_5_0:removeFromParentAndCleanup(true)
		end
	})

	var_5_0:addChild(var_5_2)

	arg_5_0.callback = arg_5_1 and arg_5_1.callback and arg_5_1.callback or nil
	arg_5_0.defaultLandType = arg_5_1 and arg_5_1.pageType and arg_5_1.pageType or MasterType.eLand

	if arg_5_1 and arg_5_1.defaultMasterId then
		local var_5_3 = arg_5_1.defaultMasterId

		arg_5_0.defaultLandType = BaseMasters[var_5_3].type

		arg_5_0:showMasterDetail(var_5_3, nil)
	end

	arg_5_0:createTable()
	arg_5_0:createProgressBar()
	arg_5_0:createButton()
end

function var_0_1.createTable(arg_8_0)
	arg_8_0.cellSize = CCSize(736, 235)

	local var_8_0 = createTableView({
		reverse = true,
		size = CCSize(736, 410),
		direction = kCCScrollViewDirectionVertical,
		dataset = arg_8_0.masterList,
		sizehandler = function(arg_9_0, arg_9_1)
			return arg_8_0.cellSize
		end,
		cellhandler = handler(arg_8_0, arg_8_0.createTableCell)
	})

	var_8_0:setAnchorPoint(CCPoint(0, 0))
	var_8_0:setPosition((arg_8_0.bgSize.width - 736) / 2, 70)
	arg_8_0.bgSprite:addChild(var_8_0)

	arg_8_0.tableview = var_8_0
end

function var_0_1.createTableCell(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = CCLayerColor:create(ccc4(0, 0, 0, 0))

	var_10_0:setContentSize(arg_10_0.cellSize)

	local var_10_1 = 174
	local var_10_2 = 10
	local var_10_3 = var_10_2 / 2 + var_10_1 / 2

	for iter_10_0, iter_10_1 in ipairs(arg_10_3) do
		local var_10_4 = display.newSprite(MasterHelper:getBackImageByQuality(iter_10_1.quality, true), var_10_3, arg_10_0.cellSize.height / 2)

		var_10_0:addChild(var_10_4)

		local var_10_5 = var_10_4:getContentSize()
		local var_10_6 = "master/" .. iter_10_1.headerImage
		local var_10_7 = ui.newControlButton({
			scaleX = 0.8,
			scaleY = 0.8,
			normalImage = var_10_6,
			position = CCPoint(var_10_5.width / 2, var_10_5.height / 2),
			clickAction = function()
				arg_10_0:showMasterDetail(iter_10_1.masterId, arg_10_1 - arg_10_2)
			end
		})

		var_10_4:addChild(var_10_7)

		local var_10_8 = display.newSprite("ui/xunfang/xunfang_015.png", var_10_5.width / 2, 30)
		local var_10_9 = var_10_8:getContentSize()

		var_10_4:addChild(var_10_8)
		addLabelWithColorSize(var_10_8, iter_10_1.name, getQualityColor(iter_10_1.quality), 20, CCPoint(0.5, 0.5), CCPoint(var_10_9.width / 2, var_10_9.height / 2))

		if MasterHelper:getMasterCount(iter_10_1.masterId) == nil then
			var_10_7:setOpacity(170)
		else
			local var_10_10 = display.newSprite("uilocal/xunfang/xunfang_text_001.png", -15, var_10_5.height + 10)

			var_10_10:setAnchorPoint(CCPoint(0, 1))
			var_10_4:addChild(var_10_10)
		end

		var_10_3 = var_10_3 + var_10_1 + var_10_2
	end

	return var_10_0
end

function var_0_1.showMasterDetail(arg_12_0, arg_12_1, arg_12_2)
	local function var_12_0(arg_13_0)
		local var_13_0

		if arg_12_2 ~= nil and arg_12_2 >= 2 then
			var_13_0 = arg_12_0.tableview:getContentOffset()
		end

		arg_12_0.masterList = var_0_3(arg_12_0.curPageTag)

		arg_12_0.tableview:reloadData(arg_12_0.masterList)

		if var_13_0 ~= nil then
			arg_12_0.tableview:setContentOffset(var_13_0)
		end

		arg_12_0.progressBar:setProgressValue(1, MasterHelper:getActiveMasterOfType(arg_12_0.curPageTag), var_0_2)

		local var_13_1 = var_0_0.get("XunfangInfoRequest")
		local var_13_2 = var_13_1.AttrList[1]
		local var_13_3 = BaseMasters[arg_13_0]

		if var_13_3.improveProperty == var_13_2.AddAttrEnum then
			var_13_2.AddValue = var_13_2.AddValue + var_13_3.improveValue
		end

		var_0_0.set("XunfangInfoRequest", var_13_1)

		if arg_12_0.callback then
			arg_12_0.callback()
		end
	end

	local var_12_1 = true

	if MasterHelper:getMasterCount(arg_12_1) == nil then
		var_12_1 = false
	end

	local var_12_2 = require("scenes.xunfang.DlgActiveMasterLayer").new({
		isInTujian = true,
		masterId = arg_12_1,
		isActivity = var_12_1,
		closeAction = var_12_0
	})

	arg_12_0:addChild(var_12_2, DefaultZOrder.ePopupLayer)
end

function var_0_1.createProgressBar(arg_14_0)
	local var_14_0 = require("scenes.ProgressBar").new({
		backImage = "ui/xunfang/xunfang_024.png",
		curValue = 0,
		totalValue = 1,
		backSize = CCSize(416, 55),
		barImages = {
			"ui/xunfang/xunfang_023.png"
		},
		barSize = CCSize(388, 18),
		barPosition = ccp(-194, 0),
		labelColor = ccc3(255, 225, 255)
	})

	var_14_0:setPosition(arg_14_0.bgSize.width * 0.6, 30)
	arg_14_0.bgSprite:addChild(var_14_0)

	arg_14_0.progressBar = var_14_0

	addLabelWithColorSize(arg_14_0.bgSprite, string.lf("寻访进度"), ccc3(247, 211, 91), 25, CCPoint(0, 0.5), CCPoint(150, 30))
end

function var_0_1.createButton(arg_15_0)
	local var_15_0 = "ui/xunfang/xunfang_009.png"
	local var_15_1 = "ui/xunfang/xunfang_008.png"

	arg_15_0.curPageTag = MasterType.eAll
	arg_15_0.buttonList = {
		{
			TitleImg = "uilocal/xunfang/xunfang_text_003.png",
			tag = MasterType.eLand,
			Position = CCPoint(arg_15_0.bgSize.width * 0.16, arg_15_0.bgSize.height * 0.84)
		},
		{
			TitleImg = "uilocal/xunfang/xunfang_text_004.png",
			tag = MasterType.eDemon,
			Position = CCPoint(arg_15_0.bgSize.width * 0.38, arg_15_0.bgSize.height * 0.84)
		},
		{
			TitleImg = "uilocal/xunfang/xunfang_text_005.png",
			tag = MasterType.eHeaven,
			Position = CCPoint(arg_15_0.bgSize.width * 0.62, arg_15_0.bgSize.height * 0.84)
		},
		{
			TitleImg = "uilocal/xunfang/xunfang_text_006.png",
			tag = MasterType.eOutHeaven,
			Position = CCPoint(arg_15_0.bgSize.width * 0.84, arg_15_0.bgSize.height * 0.84)
		}
	}

	local function var_15_2(arg_16_0, arg_16_1)
		local var_16_0 = tolua.cast(arg_16_1, "CCControlButton"):getTag()

		if arg_15_0.curPageTag == var_16_0 then
			return
		end

		for iter_16_0, iter_16_1 in ipairs(arg_15_0.buttonList) do
			if iter_16_1.tag == arg_15_0.curPageTag then
				iter_16_1.button:setBackgroundSpriteForState(CCScale9Sprite:create(var_15_0), CCControlStateNormal)
				iter_16_1.button:setBackgroundSpriteForState(CCScale9Sprite:create(var_15_0), CCControlStateHighlighted)
			elseif iter_16_1.tag == var_16_0 then
				iter_16_1.button:setBackgroundSpriteForState(CCScale9Sprite:create(var_15_1), CCControlStateNormal)
				iter_16_1.button:setBackgroundSpriteForState(CCScale9Sprite:create(var_15_1), CCControlStateHighlighted)
			end
		end

		arg_15_0.curPageTag = var_16_0
		arg_15_0.masterList = var_0_3(var_16_0)

		arg_15_0.tableview:reloadData(arg_15_0.masterList)
		arg_15_0.progressBar:setProgressValue(1, MasterHelper:getActiveMasterOfType(arg_15_0.curPageTag), var_0_2)
	end

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.buttonList) do
		local var_15_3 = ui.newControlButton({
			normalImage = var_15_0,
			titleImage = iter_15_1.TitleImg,
			position = iter_15_1.Position,
			clickAction = var_15_2
		})

		var_15_3:setTag(iter_15_1.tag)
		var_15_3:setTouchPriority(-1)
		arg_15_0.bgSprite:addChild(var_15_3)

		iter_15_1.button = var_15_3

		if iter_15_1.tag == arg_15_0.defaultLandType then
			var_15_2(nil, var_15_3)
		end
	end
end

return var_0_1
