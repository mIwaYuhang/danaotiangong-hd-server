require("base.define")
require("network.ChampionShipRequest")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = {
	typeOfRank = 1,
	typeOfReward = 2
}
local var_0_2 = "ui/PK/PK_021.png"
local var_0_3 = "ui/PK/PK_022.png"
local var_0_4 = 1
local var_0_5 = 1
local var_0_6 = 10
local var_0_7 = {
	[daoTypes.typeOfRen] = {
		posY = 440,
		selected = false,
		text = string.lf("人道（1 级-40级）")
	},
	[daoTypes.typeOfDi] = {
		posY = 360,
		selected = false,
		text = string.lf("地道（41级-70级）")
	},
	[daoTypes.typeOfTian] = {
		posY = 280,
		selected = false,
		text = string.lf("天道（71级以上）")
	}
}

local function var_0_8(arg_1_0)
	local var_1_0 = arg_1_0 ~= nil and table.nums(arg_1_0) or 0

	if var_1_0 <= var_0_6 then
		return 1
	else
		return math.ceil(var_1_0 / var_0_6)
	end
end

local var_0_9 = class("CSRankScene", function()
	return display.newScene("CSRankScene")
end)

function var_0_9.ctor(arg_3_0, arg_3_1)
	arg_3_0.defaultPage = arg_3_1 ~= nil and arg_3_1.defaultPage ~= nil and arg_3_1.defaultPage or var_0_1.typeOfReward
	arg_3_0.defaultType = arg_3_1 ~= nil and arg_3_1.defaultType ~= nil and arg_3_1.defaultType or daoTypes.typeOfRen
	var_0_4 = 1
	var_0_5 = 1
	var_0_7 = {
		[daoTypes.typeOfRen] = {
			selected = false,
			posY = 440,
			text = string.lf("人道（1 级-40级）")
		},
		[daoTypes.typeOfDi] = {
			selected = false,
			posY = 360,
			text = string.lf("地道（41级-70级）")
		},
		[daoTypes.typeOfTian] = {
			selected = false,
			posY = 280,
			text = string.lf("天道（71级以上）")
		}
	}
	arg_3_0.rankList = {}
	arg_3_0.rewardList = {}

	arg_3_0:initRequests()
end

function var_0_9.onEnter(arg_4_0)
	local var_4_0 = require("scenes.CommonBgLayer").new({
		titleSprite = "uilocal/PK/PK_text_025.png",
		returnAction = function()
			game.enterCSHomeScene()
		end
	})
	local var_4_1 = var_4_0:getBackgroundSprite()
	local var_4_2 = var_4_1:getContentSize()

	arg_4_0:addChild(var_4_0)

	local var_4_3 = display.newScale9Sprite("ui/common/common_050.png", var_4_2.width / 2 - 2, var_4_2.height / 2 - 30, CCSize(var_4_2.width - 10, var_4_2.height - 70))

	var_4_1:addChild(var_4_3)

	arg_4_0.bgSprite = var_4_1
	arg_4_0.bgSize = var_4_2
	arg_4_0.lastUpdateLabel = addLabelWithColorSize(arg_4_0.bgSprite, "", ccc3(247, 211, 91), 20, CCPoint(0, 0), CCPoint(20, arg_4_0.bgSize.height - 118))

	arg_4_0:addButtons()
	arg_4_0:addTabPages()
end

function var_0_9.initRequests(arg_6_0)
	local function var_6_0()
		local var_7_0 = arg_6_0.rankInfoRequest.restable

		arg_6_0.lastUpdateLabel:setString(string.lf("最后更新时间: #FFFFFF%s", var_7_0.lastUpdateTime))
		arg_6_0.myRankLabel:setString(var_7_0.playerRank ~= nil and var_7_0.playerRank or 0)

		var_0_7[arg_6_0.currType].rankList = var_7_0.playerInfos

		table.sort(var_0_7[arg_6_0.currType].rankList, function(arg_8_0, arg_8_1)
			if arg_8_0.rank == arg_8_1.rank then
				return arg_8_0.battlePower > arg_8_1.battlePower
			else
				return arg_8_0.rank < arg_8_1.rank
			end
		end)

		var_0_5 = var_0_8(var_0_7[arg_6_0.currType].rankList)

		arg_6_0:showOneRankPage(arg_6_0.currType, 1)
	end

	local function var_6_1(arg_9_0)
		print("state = " .. arg_9_0)
	end

	arg_6_0.rankInfoRequest = XMRankInfoRequest:new()

	arg_6_0.rankInfoRequest:setResponseNormalHandler(var_6_0)

	local function var_6_2()
		local var_10_0 = arg_6_0.rewardInfoRequest.restable

		arg_6_0.rewardList = var_10_0.rankRewardInfos

		table.sort(arg_6_0.rewardList, function(arg_11_0, arg_11_1)
			return arg_11_0.rank < arg_11_1.rank
		end)

		var_0_7[arg_6_0.currType].rewardList = arg_6_0.rewardList

		arg_6_0.rewardLayer.tableView:reloadData(arg_6_0.rewardList)
	end

	arg_6_0.rewardInfoRequest = XMRankRewardInfoRequest:new()

	arg_6_0.rewardInfoRequest:setResponseNormalHandler(var_6_2)
end

function var_0_9.addRankLayer(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1:getContentSize()
	local var_12_1 = display.newSprite("ui/PK/PK_027.jpg", var_12_0.width / 2, var_12_0.height / 2)

	arg_12_1:addChild(var_12_1)
	addLabelWithColorSize(var_12_1, string.lf("排名"), ccc3(247, 211, 91), 25, CCPoint(0, 0), CCPoint(23, var_12_0.height - 45))
	addLabelWithColorSize(var_12_1, string.lf("名字"), ccc3(247, 211, 91), 25, CCPoint(0, 0), CCPoint(140, var_12_0.height - 45))
	addLabelWithColorSize(var_12_1, string.lf("等级"), ccc3(247, 211, 91), 25, CCPoint(0, 0), CCPoint(276, var_12_0.height - 45))
	addLabelWithColorSize(var_12_1, string.lf("战力"), ccc3(247, 211, 91), 25, CCPoint(0, 0), CCPoint(418, var_12_0.height - 45))
	addLabelWithColorSize(var_12_1, string.lf("阵容"), ccc3(247, 211, 91), 25, CCPoint(0, 0), CCPoint(552, var_12_0.height - 45))

	local var_12_2 = display.newSprite("ui/PK/PK_029.png", 180, 50)
	local var_12_3 = display.newSprite("ui/PK/PK_029.png", 465, 50)

	var_12_1:addChild(var_12_2)
	var_12_1:addChild(var_12_3)

	local var_12_4 = var_12_2:getContentSize()

	addLabelWithColorSize(var_12_1, string.lf("我的排名"), ccc3(255, 255, 255), 25, CCPoint(0, 0), CCPoint(20, 35))

	arg_12_0.myRankLabel = addLabelWithColorSize(var_12_2, "0", ccc3(247, 211, 91), 22, CCPoint(0.5, 0.5), CCPoint(var_12_4.width / 2, var_12_4.height / 2))
	arg_12_0.curPagLabel = addLabelWithColorSize(var_12_3, var_0_4 .. "/" .. var_0_5, ccc3(247, 211, 91), 22, CCPoint(0.5, 0.5), CCPoint(var_12_4.width / 2, var_12_4.height / 2))

	local var_12_5 = ui.newControlButton({
		fontSize = 22,
		normalImage = "ui/PK/PK_028.png",
		text = string.lf("上一页"),
		position = CCPoint(355, 51),
		clickAction = function()
			if var_0_4 == 1 then
				showFlashNotice(string.lf("上仙，已经是第一页了"))

				return
			end

			arg_12_0:showOneRankPage(arg_12_0.currType, var_0_4 - 1)
		end
	})
	local var_12_6 = ui.newControlButton({
		fontSize = 22,
		normalImage = "ui/PK/PK_028.png",
		text = string.lf("下一页"),
		position = CCPoint(575, 51),
		clickAction = function()
			if var_0_4 == var_0_5 then
				showFlashNotice(string.lf("上仙，没有更多数据了"))

				return
			end

			arg_12_0:showOneRankPage(arg_12_0.currType, var_0_4 + 1)
		end
	})

	var_12_5:setTouchPriority(-1)
	var_12_6:setTouchPriority(-1)
	var_12_1:addChild(var_12_5, 2)
	var_12_1:addChild(var_12_6, 2)

	arg_12_0.rankCellSize = CCSize(var_12_0.width, 56)

	local var_12_7 = createTableView({
		reverse = true,
		size = CCSize(var_12_0.width, 337),
		direction = kCCScrollViewDirectionVertical,
		dataset = arg_12_0.rankList,
		sizehandler = function(arg_15_0, arg_15_1)
			return arg_12_0.rankCellSize
		end,
		cellhandler = handler(arg_12_0, arg_12_0.showRankCell)
	})

	var_12_7:setPosition(0, 101)
	var_12_1:addChild(var_12_7)

	var_12_1.tableView = var_12_7

	return var_12_1
end

function var_0_9.addRewardLayer(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1:getContentSize()
	local var_16_1 = display.newScale9Sprite("ui/common/common_116.png", var_16_0.width / 2, var_16_0.height / 2, var_16_0)

	arg_16_1:addChild(var_16_1)

	arg_16_0.rewardCellSize = CCSize(var_16_0.width, 174)

	local var_16_2 = createTableView({
		reverse = true,
		size = CCSize(var_16_0.width, var_16_0.height - 12),
		direction = kCCScrollViewDirectionVertical,
		dataset = arg_16_0.rewardList,
		sizehandler = function(arg_17_0, arg_17_1)
			return arg_16_0.rewardCellSize
		end,
		cellhandler = handler(arg_16_0, arg_16_0.showRewardCell)
	})

	var_16_2:setPosition(0, 6)
	var_16_1:addChild(var_16_2)

	var_16_1.tableView = var_16_2

	return var_16_1
end

function var_0_9.addTabPages(arg_18_0)
	local var_18_0 = {
		{
			isDefault = false,
			titleSize = 25,
			tag = var_0_1.typeOfReward,
			x = arg_18_0.bgSize.width - 600,
			titleText = string.lf("奖励")
		},
		{
			isDefault = false,
			titleSize = 25,
			tag = var_0_1.typeOfRank,
			x = arg_18_0.bgSize.width - 420,
			titleText = string.lf("排名")
		}
	}

	for iter_18_0, iter_18_1 in pairs(var_18_0) do
		if arg_18_0.defaultPage == iter_18_1.tag then
			iter_18_1.isDefault = true
		end
	end

	local function var_18_1(arg_19_0)
		arg_18_0.currPage = arg_19_0

		if arg_19_0 == var_0_1.typeOfRank then
			if arg_18_0.rewardLayer ~= nil then
				arg_18_0.rewardLayer:setVisible(false)
			end

			if arg_18_0.rankLayer == nil then
				arg_18_0.rankLayer = arg_18_0:addRankLayer(arg_18_0.tabParent)
			end

			arg_18_0.rankLayer:setVisible(true)
		else
			if arg_18_0.rankLayer ~= nil then
				arg_18_0.rankLayer:setVisible(false)
			end

			if arg_18_0.rewardLayer == nil then
				arg_18_0.rewardLayer = arg_18_0:addRewardLayer(arg_18_0.tabParent)
			end

			arg_18_0.rewardLayer:setVisible(true)
		end
	end

	local function var_18_2(arg_20_0)
		var_18_1(arg_20_0)
		arg_18_0:onRankButtonClicked(arg_18_0.currType)
	end

	local function var_18_3(arg_21_0, arg_21_1)
		arg_18_0.tabParent = arg_21_0

		var_18_1(arg_21_1)
		arg_18_0:onRankButtonClicked(arg_18_0.defaultType)
	end

	local var_18_4 = require("scenes.TabLayer").new({
		disabledImage = "ui/common/common_023_2.png",
		selectedImage = "ui/common/common_023.png",
		normalImage = "ui/common/common_022.png",
		size = CCSize(638, 488),
		point = CCPoint(305, 20),
		config = var_18_0,
		cellHandler = var_18_3,
		changedHandler = var_18_2
	})

	arg_18_0.bgSprite:addChild(var_18_4)
end

function var_0_9.addButtons(arg_22_0)
	local var_22_0 = display.newSprite("ui/PK/PK_026.jpg", 15, 20)

	var_22_0:setAnchorPoint(CCPoint(0, 0))
	arg_22_0.bgSprite:addChild(var_22_0)

	local var_22_1 = var_22_0:getContentSize()

	for iter_22_0, iter_22_1 in ipairs(var_0_7) do
		local var_22_2 = ui.newControlButton({
			fontSize = 22,
			normalImage = var_0_2,
			size = CCSize(250, 67),
			text = iter_22_1.text,
			position = CCPoint(var_22_1.width / 2, iter_22_1.posY),
			clickAction = function()
				arg_22_0:onRankButtonClicked(iter_22_0)
			end
		})

		iter_22_1.button = var_22_2

		var_22_0:addChild(var_22_2)
	end
end

function var_0_9.showRankCell(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = display.newSprite(arg_24_2 % 2 == 0 and "ui/PK/PK_023.png" or "ui/PK/PK_024.png", arg_24_0.rankCellSize.width / 2, arg_24_0.rankCellSize.height / 2)
	local var_24_1 = var_24_0:getContentSize()

	local function var_24_2(arg_25_0)
		if arg_25_0 <= 4 then
			return string.lf("第%d名", arg_25_0)
		else
			return string.lf("%d强", arg_25_0)
		end
	end

	local var_24_3 = arg_24_3.playerID == Player.userId and ccc3(0, 255, 0) or ccc3(247, 211, 91)

	addLabelWithColorSize(var_24_0, var_24_2(arg_24_3.rank), var_24_3, 20, CCPoint(0.5, 0.5), CCPoint(45, var_24_1.height / 2))
	addLabelWithColorSize(var_24_0, arg_24_3.name, var_24_3, 20, CCPoint(0.5, 0.5), CCPoint(170, var_24_1.height / 2))
	addLabelWithColorSize(var_24_0, "Lv." .. arg_24_3.level, var_24_3, 20, CCPoint(0.5, 0.5), CCPoint(300, var_24_1.height / 2))
	addLabelWithColorSize(var_24_0, arg_24_3.battlePower, var_24_3, 20, CCPoint(0.5, 0.5), CCPoint(440, var_24_1.height / 2))

	local var_24_4 = ui.newControlButton({
		fontSize = 22,
		normalImage = "ui/PK/PK_025.png",
		text = string.lf("阵容"),
		position = CCPoint(575, var_24_1.height / 2),
		clickAction = function()
			OthersTeamHelper:checkOthersTeam(arg_24_3.playerID, arg_24_3.name, OthersTeamHelper.eDataFromCSRank, {
				defaultPage = var_0_1.typeOfRank,
				defaultType = arg_24_0.currType
			})
		end
	})

	var_24_0:addChild(var_24_4, 1)

	return var_24_0
end

function var_0_9.showRewardCell(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = display.newSprite("ui/PK/PK_030.jpg", arg_27_0.rewardCellSize.width / 2, arg_27_0.rewardCellSize.height / 2)
	local var_27_1 = var_27_0:getContentSize()

	local function var_27_2(arg_28_0)
		if arg_28_0 == 1 then
			return "uilocal/PK/PK_text_012.png"
		elseif arg_28_0 == 2 then
			return "uilocal/PK/PK_text_013.png"
		elseif arg_28_0 == 3 then
			return "uilocal/PK/PK_text_014.png"
		elseif arg_28_0 == 4 then
			return "uilocal/PK/PK_text_029.png"
		elseif arg_28_0 >= 5 and arg_28_0 <= 8 then
			return "uilocal/PK/PK_text_015.png"
		elseif arg_28_0 >= 9 and arg_28_0 <= 16 then
			return "uilocal/PK/PK_text_016.png"
		elseif arg_28_0 >= 17 and arg_28_0 <= 32 then
			return "uilocal/PK/PK_text_017.png"
		elseif arg_28_0 >= 33 and arg_28_0 <= 64 then
			return "uilocal/PK/PK_text_018.png"
		elseif arg_28_0 >= 65 and arg_28_0 <= 128 then
			return "uilocal/PK/PK_text_019.png"
		elseif arg_28_0 >= 129 and arg_28_0 <= 256 then
			return "uilocal/PK/PK_text_020.png"
		else
			return nil
		end
	end

	local var_27_3 = display.newSprite(var_27_2(arg_27_3.rank), 105, var_27_1.height / 2)

	var_27_3:setAnchorPoint(CCPoint(0.5, 0.5))
	var_27_0:addChild(var_27_3)

	local var_27_4 = CCSize(var_27_1.height - 50, var_27_1.height - 30)
	local var_27_5 = createTableView({
		reverse = true,
		size = CCSize(var_27_1.width - 200, var_27_1.height - 10),
		direction = kCCScrollViewDirectionHorizontal,
		dataset = arg_27_3.reward,
		sizehandler = function(arg_29_0, arg_29_1)
			return var_27_4
		end,
		cellhandler = function(arg_30_0, arg_30_1, arg_30_2)
			local var_30_0 = CCLayerColor:create(ccc4(0, 0, 0, 0))

			var_30_0:setContentSize(var_27_4)

			local var_30_1

			if arg_30_2.Type == ItemType.eHero or arg_30_2.Type == ItemType.eSoul or arg_30_2.Type == ItemType.eEquip or arg_30_2.Type == ItemType.eFragment or arg_30_2.Type == ItemType.eProp then
				function var_30_1()
					var_0_0.tipshandler(arg_30_2)
				end
			end

			local var_30_2 = figure.createHeader({
				isName = false,
				inTeam = false,
				itemId = arg_30_2.ID ~= nil and arg_30_2.ID or 0,
				type = arg_30_2.Type,
				count = arg_30_2.Count,
				clickAction = var_30_1
			})

			var_30_2:setAnchorPoint(CCPoint(0.5, 0.5))
			var_30_2:setPosition(var_27_4.width / 2, var_27_4.height / 2 + 10)
			var_30_0:addChild(var_30_2)

			local var_30_3 = getQualityColor(getItemQuality(arg_30_2.Type, arg_30_2.ID))

			addLabelWithColorSize(var_30_0, getItemName(arg_30_2.Type, arg_30_2.ID), var_30_3, 20, CCPoint(0.5, 0), CCPoint(var_27_4.width / 2, 10))

			return var_30_0
		end
	})

	var_27_5:setPosition(190, 15)
	var_27_0:addChild(var_27_5)

	return var_27_0
end

function var_0_9.onRankButtonClicked(arg_32_0, arg_32_1)
	for iter_32_0, iter_32_1 in ipairs(var_0_7) do
		if arg_32_1 == iter_32_0 then
			iter_32_1.button:setBackgroundSpriteForState(CCScale9Sprite:create(var_0_3), CCControlStateNormal)
			iter_32_1.button:setBackgroundSpriteForState(CCScale9Sprite:create(var_0_3), CCControlStateHighlighted)

			iter_32_1.selected = true
		elseif iter_32_1.selected == true then
			iter_32_1.button:setBackgroundSpriteForState(CCScale9Sprite:create(var_0_2), CCControlStateNormal)
			iter_32_1.button:setBackgroundSpriteForState(CCScale9Sprite:create(var_0_2), CCControlStateHighlighted)

			iter_32_1.selected = false
		end
	end

	arg_32_0.currType = arg_32_1

	if arg_32_0.currPage == var_0_1.typeOfRank then
		var_0_5 = var_0_8(var_0_7[arg_32_1].rankList)

		arg_32_0:showOneRankPage(arg_32_1, 1)
	else
		arg_32_0.rewardList = {}

		if var_0_7[arg_32_1].rewardList ~= nil then
			arg_32_0.rewardList = var_0_7[arg_32_1].rewardList
		else
			arg_32_0.rewardInfoRequest:request(arg_32_1)
		end

		arg_32_0.rewardLayer.tableView:reloadData(arg_32_0.rewardList)
	end
end

function var_0_9.showOneRankPage(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_0.currPage ~= var_0_1.typeOfRank then
		return
	end

	if arg_33_2 == 0 or arg_33_2 > var_0_5 then
		return
	end

	arg_33_0.rankList = {}

	if var_0_7[arg_33_1].rankList ~= nil then
		for iter_33_0, iter_33_1 in ipairs(var_0_7[arg_33_1].rankList) do
			if iter_33_0 > var_0_6 * (arg_33_2 - 1) and iter_33_0 <= var_0_6 * arg_33_2 then
				table.insert(arg_33_0.rankList, iter_33_1)
			end
		end
	else
		arg_33_0.rankInfoRequest:request(arg_33_1)
	end

	var_0_4 = arg_33_2

	arg_33_0.rankLayer.tableView:reloadData(arg_33_0.rankList)
	arg_33_0.curPagLabel:setString(var_0_4 .. "/" .. var_0_5)
end

return var_0_9
