require("network.XunfangRequest")

local var_0_0 = require("base.cache")
local var_0_1 = class("XFBaishiLayer", function()
	return CCLayerColor:create(ccc4(10, 10, 10, 210), display.width, display.height)
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		return true
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.pageType = arg_2_1 and arg_2_1.pageType and arg_2_1.pageType or MasterType.eLand
	arg_2_0.callback = arg_2_1 and arg_2_1.callback and arg_2_1.callback or nil

	local var_2_0 = display.newSprite("ui/xunfang/xunfang_002.png")

	var_2_0:setScale(Adapter.MinScale)
	var_2_0:setPosition(ccp(display.cx, display.cy))
	arg_2_0:addChild(var_2_0)

	arg_2_0.bgSprite = var_2_0
	arg_2_0.bgSize = var_2_0:getContentSize()
	arg_2_0.itemTable = {}
	arg_2_0.frontAttrList = {}
	arg_2_0.backAttrList = {}

	local var_2_1 = {
		[MasterType.eLand] = "uilocal/xunfang/xunfang_text_007.png",
		[MasterType.eDemon] = "uilocal/xunfang/xunfang_text_008.png",
		[MasterType.eHeaven] = "uilocal/xunfang/xunfang_text_009.png",
		[MasterType.eOutHeaven] = "uilocal/xunfang/xunfang_text_010.png"
	}
	local var_2_2 = display.newSprite(var_2_1[arg_2_0.pageType], arg_2_0.bgSize.width / 2, arg_2_0.bgSize.height - 36)

	var_2_0:addChild(var_2_2)

	local var_2_3 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		position = CCPoint(arg_2_0.bgSize.width - 28, arg_2_0.bgSize.height - 36),
		clickAction = function()
			arg_2_0:removeFromParentAndCleanup(true)
		end
	})

	var_2_3:setTouchPriority(-1)
	var_2_0:addChild(var_2_3)
	arg_2_0:initRequests()
	arg_2_0.getApprenticeInfoRequest:request(arg_2_0.pageType)
	arg_2_0:createTable()
	arg_2_0:showAttributes()
end

function var_0_1.dataItemSort(arg_5_0)
	table.sort(arg_5_0.itemTable, function(arg_6_0, arg_6_1)
		local var_6_0 = false
		local var_6_1 = false

		if MasterHelper:getMasterCount(arg_6_0.Consume[1].ID) ~= nil and MasterHelper:getMasterCount(arg_6_0.Consume[2].ID) ~= nil and MasterHelper:getMasterCount(arg_6_0.Consume[3].ID) ~= nil and MasterHelper:getMasterCount(arg_6_0.Consume[1].ID) >= arg_6_0.Consume[1].Count and MasterHelper:getMasterCount(arg_6_0.Consume[2].ID) >= arg_6_0.Consume[2].Count and MasterHelper:getMasterCount(arg_6_0.Consume[3].ID) >= arg_6_0.Consume[3].Count then
			var_6_0 = true
		end

		if MasterHelper:getMasterCount(arg_6_1.Consume[1].ID) ~= nil and MasterHelper:getMasterCount(arg_6_1.Consume[2].ID) ~= nil and MasterHelper:getMasterCount(arg_6_1.Consume[3].ID) ~= nil and MasterHelper:getMasterCount(arg_6_1.Consume[1].ID) >= arg_6_1.Consume[1].Count and MasterHelper:getMasterCount(arg_6_1.Consume[2].ID) >= arg_6_1.Consume[2].Count and MasterHelper:getMasterCount(arg_6_1.Consume[3].ID) >= arg_6_1.Consume[3].Count then
			var_6_1 = true
		end

		return not var_6_0 and var_6_1
	end)
end

function var_0_1.initRequests(arg_7_0)
	local function var_7_0()
		local var_8_0 = arg_7_0.getApprenticeInfoRequest.restable

		arg_7_0.itemTable = var_8_0.ApprenticeList

		arg_7_0:dataItemSort()
		arg_7_0.tableview:reloadData(arg_7_0.itemTable)

		if arg_7_0.itemTable == nil or table.nums(arg_7_0.itemTable) == 0 then
			arg_7_0.noImageFlag:setVisible(true)
		end

		arg_7_0.frontAttrList = var_8_0.Front
		arg_7_0.backAttrList = var_8_0.Back

		arg_7_0:showAttributes()
	end

	arg_7_0.getApprenticeInfoRequest = GetApprenticeInfoRequest:new()

	arg_7_0.getApprenticeInfoRequest:setResponseNormalHandler(var_7_0)

	local function var_7_1()
		showFlashImage({
			image = "uilocal/enhance/enhance_txt_007.png",
			scale = 0.8,
			parent = arg_7_0.bgSprite,
			position = CCPoint(arg_7_0.bgSize.width / 2, arg_7_0.bgSize.height / 2),
			callback = function()
				local var_10_0 = var_0_0.get("XunfangInfoRequest")
				local var_10_1 = var_10_0.ApprenticeProgress[arg_7_0.pageType]

				var_10_1.ApprenticedCount = var_10_1.ApprenticedCount + 1

				var_0_0.set("XunfangInfoRequest", var_10_0)

				if arg_7_0.currId ~= nil then
					for iter_10_0, iter_10_1 in ipairs(arg_7_0.itemTable) do
						if arg_7_0.currId == iter_10_1.ID then
							arg_7_0:addAttrToList(iter_10_1.AddTargetEnum, iter_10_1.AddAttrEnum, iter_10_1.AddValue)
							arg_7_0:showAttributes()
							table.remove(arg_7_0.itemTable, iter_10_0)

							break
						end
					end

					arg_7_0.currId = nil
				end

				arg_7_0:dataItemSort()
				arg_7_0.tableview:reloadData(arg_7_0.itemTable)
				arg_7_0:AddButtonLight()

				if arg_7_0.itemTable == nil or table.nums(arg_7_0.itemTable) == 0 then
					arg_7_0.noImageFlag:setVisible(true)
				end

				if arg_7_0.callback then
					arg_7_0.callback()
				end
			end
		})
	end

	arg_7_0.toBeApprenticeRequest = ToBeApprenticeRequest:new()

	arg_7_0.toBeApprenticeRequest:setResponseNormalHandler(var_7_1)
end

function var_0_1.AddButtonLight(arg_11_0)
	arg_11_0.isLight = false

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.itemTable) do
		if MasterHelper:getMasterCount(iter_11_1.Consume[1].ID) ~= nil and MasterHelper:getMasterCount(iter_11_1.Consume[2].ID) ~= nil and MasterHelper:getMasterCount(iter_11_1.Consume[3].ID) ~= nil and MasterHelper:getMasterCount(iter_11_1.Consume[1].ID) >= iter_11_1.Consume[1].Count and MasterHelper:getMasterCount(iter_11_1.Consume[2].ID) >= iter_11_1.Consume[2].Count and MasterHelper:getMasterCount(iter_11_1.Consume[3].ID) >= iter_11_1.Consume[3].Count then
			arg_11_0.isLight = true
		end
	end

	local var_11_0 = var_0_0.get("XunfangInfoRequest")
	local var_11_1 = var_11_0.ApprenticeProgress[arg_11_0.pageType]

	if arg_11_0.isLight then
		var_11_1.IsHaveApprentice = true
	else
		var_11_1.IsHaveApprentice = false
	end

	var_0_0.set("XunfangInfoRequest", var_11_0)
end

function var_0_1.createTable(arg_12_0)
	arg_12_0.cellSize = CCSize(736, 120)

	local var_12_0 = createTableView({
		reverse = false,
		size = CCSize(736, 360),
		direction = kCCScrollViewDirectionVertical,
		dataset = arg_12_0.itemTable,
		sizehandler = function(arg_13_0, arg_13_1)
			return arg_12_0.cellSize
		end,
		cellhandler = handler(arg_12_0, arg_12_0.createTableCell)
	})

	var_12_0:setAnchorPoint(CCPoint(0, 0))
	var_12_0:setPosition((arg_12_0.bgSize.width - 736) / 2, 180)
	arg_12_0.bgSprite:addChild(var_12_0)

	arg_12_0.tableview = var_12_0

	local var_12_1 = display.newSprite("uilocal/xunfang/xunfang_text_028.png", arg_12_0.bgSize.width / 2, arg_12_0.bgSize.height / 2 + 50)

	var_12_1:setVisible(false)
	arg_12_0.bgSprite:addChild(var_12_1)

	arg_12_0.noImageFlag = var_12_1
end

function var_0_1.createTableCell(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = CCLayerColor:create(ccc4(0, 0, 0, 0))

	var_14_0:setContentSize(arg_14_0.cellSize)

	local var_14_1 = display.newSprite("ui/xunfang/xunfang_004.png", arg_14_0.cellSize.width / 2, 5)

	var_14_0:addChild(var_14_1)

	local var_14_2 = 100
	local var_14_3 = 40
	local var_14_4 = 100
	local var_14_5 = table.nums(arg_14_3.Consume)
	local var_14_6 = true

	for iter_14_0, iter_14_1 in ipairs(arg_14_3.Consume) do
		local var_14_7 = MasterHelper:getMasterCount(iter_14_1.ID)
		local var_14_8 = figure.createHeader({
			isName = false,
			count = 0,
			inTeam = false,
			noTypeImage = false,
			itemId = iter_14_1.ID,
			type = iter_14_1.Type,
			clickAction = function()
				if var_14_7 == nil then
					ui.showMessageBox({
						text = string.lf("上仙，该主将尚未激活，是否现在就去图鉴页面将其激活？"),
						title1 = string.lf("取消"),
						title2 = string.lf("去激活"),
						action2 = function()
							arg_14_0:removeFromParentAndCleanup(true)

							local var_16_0 = require("scenes.xunfang.XFTujianLayer").new({
								defaultMasterId = iter_14_1.ID
							})

							display.getRunningScene():addChild(var_16_0, DefaultZOrder.ePopupLayer)
						end
					})
				else
					local function var_15_0(arg_17_0)
						local var_17_0

						if arg_14_1 - arg_14_2 >= 3 then
							var_17_0 = arg_14_0.tableview:getContentOffset()
						end

						arg_14_0:dataItemSort()
						arg_14_0.tableview:reloadData()
						arg_14_0:AddButtonLight()
						arg_14_0.callback()

						if var_17_0 ~= nil then
							arg_14_0.tableview:setContentOffset(var_17_0)
						end
					end

					local var_15_1 = require("scenes.xunfang.DlgActiveMasterLayer").new({
						isActivity = true,
						isInTujian = false,
						masterId = iter_14_1.ID,
						closeAction = var_15_0
					})

					arg_14_0:addChild(var_15_1, DefaultZOrder.ePopupLayer)
				end
			end
		})

		var_14_8:setPosition(var_14_4, arg_14_0.cellSize.height / 2 + 20)
		var_14_0:addChild(var_14_8)

		if iter_14_0 < var_14_5 then
			local var_14_9 = display.newSprite("uilocal/xunfang/xunfang_text_012.png", var_14_4 + var_14_2 / 2 + var_14_3, arg_14_0.cellSize.height / 2 + 20)

			var_14_0:addChild(var_14_9)
		end

		local var_14_10 = getItemQuality(iter_14_1.Type, iter_14_1.ID)
		local var_14_11

		if var_14_7 == nil then
			var_14_11 = string.lf("%s(未激活)", getItemName(iter_14_1.Type, iter_14_1.ID))

			var_14_8:setHeaderOpacity(140)

			if var_14_6 == true then
				var_14_6 = false
			end
		else
			var_14_11 = string.format("%s(%d/%d)", getItemName(iter_14_1.Type, iter_14_1.ID), var_14_7, iter_14_1.Count)

			if var_14_6 == true then
				var_14_6 = var_14_7 >= iter_14_1.Count
			end
		end

		addLabelWithColorSize(var_14_0, var_14_11, getQualityColor(var_14_10), 18, CCPoint(0.5, 0.5), CCPoint(var_14_4, 22))

		var_14_4 = var_14_4 + var_14_2 + var_14_3 * 2
	end

	local var_14_12 = ui.newControlButton({
		disabledImage = "ui/xunfang/xunfang_046.png",
		titleImage = "uilocal/xunfang/xunfang_text_002.png",
		normalImage = "ui/xunfang/xunfang_009.png",
		position = CCPoint(arg_14_0.cellSize.width * 0.88, arg_14_0.cellSize.height / 2 + 25),
		clickAction = function()
			if var_14_6 == false then
				showFlashNotice("拜师所需的卡牌不足")

				return
			end

			arg_14_0.currId = arg_14_3.ID

			arg_14_0.toBeApprenticeRequest:request(arg_14_3.ID)
		end
	})

	var_14_12:setEnabled(var_14_6)
	var_14_0:addChild(var_14_12)

	if var_14_6 then
		local var_14_13 = var_14_12:getContentSize()
		local var_14_14 = CCSkeletonAnimation:createWithFile("ui/xunfang/ui_baishi.json", "ui/xunfang/ui_baishi.atlas", 1)

		var_14_14:setAnimation("animation", true, 0)
		var_14_14:setScale(1.35)
		var_14_14:setTest(0.8, false, false, true)
		var_14_14:setPosition(var_14_13.width / 2, var_14_13.height / 2 + 4)
		var_14_12:addChild(var_14_14, 100)
	end

	local var_14_15 = string.lf("%s%s+%d", addTargetList[arg_14_3.AddTargetEnum], BattleAttrsName[arg_14_3.AddAttrEnum], arg_14_3.AddValue)

	addLabelWithColorSize(var_14_0, var_14_15, ccc3(0, 255, 0), 20, CCPoint(0.5, 0.5), CCPoint(arg_14_0.cellSize.width * 0.88, 40))

	return var_14_0
end

function var_0_1.showAttributes(arg_19_0)
	if arg_19_0.attrLayer == nil then
		arg_19_0.attrLayer = display.newSprite("ui/xunfang/xunfang_003.png", arg_19_0.bgSize.width / 2, 10)

		arg_19_0.attrLayer:setAnchorPoint(CCPoint(0.5, 0))
		arg_19_0.bgSprite:addChild(arg_19_0.attrLayer)
	end

	arg_19_0.attrLayer:removeAllChildrenWithCleanup(true)

	local var_19_0 = arg_19_0.attrLayer:getContentSize().width
	local var_19_1 = 0
	local var_19_2 = 30
	local var_19_3 = 90

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.frontAttrList) do
		local var_19_4 = string.lf("%s#00FF00+%d", BattleAttrsName[iter_19_1.AddAttrEnum], iter_19_1.AddValue)

		if iter_19_0 % 2 == 0 then
			addLabelWithColorSize(arg_19_0.attrLayer, var_19_4, ccc3(247, 211, 91), 18, CCPoint(0, 0.5), CCPoint(var_19_0 * 0.25, var_19_3))

			var_19_3 = var_19_3 - 30
		else
			addLabelWithColorSize(arg_19_0.attrLayer, var_19_4, ccc3(247, 211, 91), 18, CCPoint(0, 0.5), CCPoint(var_19_0 * 0.05, var_19_3))
		end
	end

	local var_19_5 = 90

	for iter_19_2, iter_19_3 in ipairs(arg_19_0.backAttrList) do
		local var_19_6 = string.lf("%s#00FF00+%d", BattleAttrsName[iter_19_3.AddAttrEnum], iter_19_3.AddValue)

		if iter_19_2 % 2 == 0 then
			addLabelWithColorSize(arg_19_0.attrLayer, var_19_6, ccc3(247, 211, 91), 18, CCPoint(0, 0.5), CCPoint(var_19_0 * 0.82, var_19_5))

			var_19_5 = var_19_5 - 30
		else
			addLabelWithColorSize(arg_19_0.attrLayer, var_19_6, ccc3(247, 211, 91), 18, CCPoint(0, 0.5), CCPoint(var_19_0 * 0.62, var_19_5))
		end
	end
end

function var_0_1.addAttrToList(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local function var_20_0(arg_21_0, arg_21_1, arg_21_2)
		local var_21_0 = arg_21_2 == true and arg_20_0.frontAttrList or arg_20_0.backAttrList

		for iter_21_0, iter_21_1 in ipairs(var_21_0) do
			if iter_21_1.AddAttrEnum == arg_21_0 then
				iter_21_1.AddValue = iter_21_1.AddValue + arg_21_1

				break
			end
		end
	end

	if arg_20_1 == 0 then
		var_20_0(arg_20_2, arg_20_3, true)
	elseif arg_20_1 == 1 then
		var_20_0(arg_20_2, arg_20_3, false)
	else
		var_20_0(arg_20_2, arg_20_3, true)
		var_20_0(arg_20_2, arg_20_3, false)
	end
end

return var_0_1
