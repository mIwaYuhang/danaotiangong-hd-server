require("data.player")
require("network.FubenRequest")
require("scenes.battle.BattleOperator")

local var_0_0 = require("base.cache")
local var_0_1 = require("scenes.PK.PKMarqueeLayer")
local var_0_2 = {
	tagFinalWin = 3,
	tagSixLoop = 2,
	tagThreeLoop = 1
}
local var_0_3 = {
	[MasterType.eLand] = {
		"taishanglaojun",
		"yuanshitianzun",
		"tongtianjiaozhu"
	},
	[MasterType.eDemon] = {
		"taishanglaojun",
		"yuanshitianzun",
		"tongtianjiaozhu"
	},
	[MasterType.eHeaven] = {
		"taishanglaojun",
		"yuanshitianzun",
		"tongtianjiaozhu"
	}
}
local var_0_4 = {
	[var_0_2.tagThreeLoop] = {
		[0] = "ui/fuben/zsq_baoxiang_001.png",
		"ui/fuben/zsq_baoxiang_006.png"
	},
	[var_0_2.tagSixLoop] = {
		[0] = "ui/fuben/zsq_baoxiang_002.png",
		"ui/fuben/zsq_baoxiang_005.png"
	},
	[var_0_2.tagFinalWin] = {
		[0] = "ui/fuben/zsq_baoxiang_003.png",
		"ui/fuben/zsq_baoxiang_004.png"
	}
}
local var_0_5 = class("ZSQHomeScene", function()
	return display.newScene("ZSQHomeScene")
end)

function var_0_5.ctor(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or {}

	local var_2_0 = display.newSprite("ui/fuben/zsq_002.jpg", display.cx, display.cy)

	var_2_0:setScale(Adapter.AutoScaleY)
	arg_2_0:addChild(var_2_0)

	arg_2_0.bgSprite = var_2_0
	arg_2_0.bgSize = var_2_0:getContentSize()
	arg_2_0.myDaoType = Player.level > 70 and MasterType.eHeaven or Player.level > 40 and MasterType.eDemon or MasterType.eLand
	arg_2_0.infoList = {
		[MasterType.eLand] = {},
		[MasterType.eDemon] = {},
		[MasterType.eHeaven] = {}
	}
	arg_2_0.logList = {}
	arg_2_0.layerType = nil

	if arg_2_1 ~= nil and arg_2_1.defaultType ~= nil then
		arg_2_0.layerType = arg_2_1.defaultType
	else
		arg_2_0.layerType = arg_2_0.myDaoType
	end

	local var_2_1 = var_0_0.get("ZSQ_LastLayerType")

	if var_2_1 ~= nil then
		arg_2_0.layerType = var_2_1

		var_0_0.set("ZSQ_LastLayerType", nil)
	end

	local var_2_2 = CCSprite:create("ui/common/common_061.png"):getTextureRect().size
	local var_2_3 = ui.newControlButton({
		normalImage = "ui/common/common_061.png",
		size = Adapter.MinSize(var_2_2.width, var_2_2.height),
		position = Adapter.AutoPos(900, 600),
		clickAction = arg_2_1.returnAction or function()
			game.enterHomeScene({
				showSubLayer = ShowSubLayerType.ePKHome
			})
		end
	})

	arg_2_0:addChild(var_2_3)

	local var_2_4 = CCSprite:create("ui/enhance/enhance_015.png"):getTextureRect().size
	local var_2_5 = ui.newControlButton({
		normalImage = "ui/enhance/enhance_015.png",
		anchorPoint = CCPoint(0.5, 0.5),
		size = Adapter.MinSize(var_2_4.width, var_2_4.height),
		position = Adapter.AutoPos(900, 520),
		clickAction = function()
			local var_4_0 = require("scenes.enhance.DlgRuleLayer").new({
				ruleType = DlgRuleType.ruleSanqing
			})

			CCDirector:sharedDirector():getRunningScene():addChild(var_4_0)
		end
	})

	arg_2_0:addChild(var_2_5)

	local var_2_6 = display.newSprite("uilocal/home/home_text_029.png")

	var_2_6:setAnchorPoint(CCPoint(0.5, 1))
	var_2_6:setPosition(Adapter.AutoPos(430, 600))
	var_2_6:setScale(Adapter.MinScale)
	arg_2_0:addChild(var_2_6)

	local var_2_7 = var_2_6:getContentSize()
	local var_2_8 = CCLabelAtlas:create(tostring(Player.team.battlePower), "ui/home/home_000_small.png", 22, 33, 48, 6)

	var_2_8:setAnchorPoint(ccp(0, 0.5))
	var_2_8:setPosition(var_2_7.width, var_2_7.height / 2)
	var_2_6:addChild(var_2_8)
	arg_2_0:initRequests()
	arg_2_0.rotateInfoRequest:request()
	arg_2_0:showLeftButton()
	arg_2_0:showBottomButton()

	local var_2_9 = arg_2_0:createHeroList()

	var_2_9:setPosition(235, 120)
	var_2_0:addChild(var_2_9)
end

function var_0_5.initRequests(arg_5_0)
	local function var_5_0()
		local var_6_0 = arg_5_0.sanqingInfoRequest.restable

		if var_6_0 ~= nil then
			local var_6_1 = {}

			for iter_6_0 = 1, 3 do
				local var_6_2 = false

				for iter_6_1, iter_6_2 in pairs(var_6_0.sanqings) do
					if iter_6_2.rank == iter_6_0 then
						var_6_1[iter_6_0] = iter_6_2
						var_6_2 = true

						break
					end
				end

				if var_6_2 == false then
					local var_6_3 = var_0_3[arg_5_0.layerType][iter_6_0]
					local var_6_4

					for iter_6_3, iter_6_4 in pairs(BaseHeros) do
						if iter_6_4.animation == var_6_3 then
							var_6_4 = iter_6_3

							break
						end
					end

					var_6_1[iter_6_0] = {
						rank = iter_6_0,
						avatarID = var_6_4
					}
				end
			end

			var_6_0.sanqings = var_6_1
			arg_5_0.infoList[arg_5_0.layerType] = var_6_0

			arg_5_0.tableView:reloadData(var_6_1)
			arg_5_0:refreshChest(var_6_0.chests)
		end
	end

	arg_5_0.sanqingInfoRequest = ZSQGetSanqingInfoRequest:new()

	arg_5_0.sanqingInfoRequest:setResponseNormalHandler(var_5_0)

	local function var_5_1()
		local var_7_0 = arg_5_0.rotateInfoRequest.restable

		if var_7_0 == nil or table.nums(var_7_0) == 0 then
			return
		end

		local var_7_1 = var_0_1.new()

		var_7_1:init(CCPoint(arg_5_0.bgSize.width / 2, arg_5_0.bgSize.height - 20), CCSize(600, 32))

		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			var_7_1:addNotice({
				string = iter_7_1.content,
				repeatNumber = iter_7_1.time
			})
		end

		arg_5_0.bgSprite:addChild(var_7_1)
		var_7_1:start()
	end

	arg_5_0.rotateInfoRequest = ZSQRotateInfoRequest:new()

	arg_5_0.rotateInfoRequest:setResponseNormalHandler(var_5_1)
end

function var_0_5.showLeftButton(arg_8_0)
	local var_8_0 = {
		{
			normalImage = "ui/worldmap/worldmap_009.png",
			tag = MasterType.eLand,
			position = Adapter.AutoPos(60, 450)
		},
		{
			normalImage = "ui/worldmap/worldmap_008.png",
			tag = MasterType.eDemon,
			position = Adapter.AutoPos(60, 330)
		},
		{
			normalImage = "ui/worldmap/worldmap_010.png",
			tag = MasterType.eHeaven,
			position = Adapter.AutoPos(60, 210)
		}
	}

	local function var_8_1(arg_9_0)
		local var_9_0

		for iter_9_0, iter_9_1 in pairs(var_8_0) do
			if iter_9_1.tag == arg_9_0 then
				var_9_0 = iter_9_1.position

				break
			end
		end

		return var_9_0
	end

	table.foreach(var_8_0, function(arg_10_0, arg_10_1)
		arg_10_1.size = Adapter.MinSize(93, 79)

		function arg_10_1.clickAction()
			arg_8_0:showLayerByType(arg_10_1.tag, arg_10_1.position)
		end

		local var_10_0 = ui.newControlButton(arg_10_1)

		arg_8_0:addChild(var_10_0)
		addLabelWithColorSize(var_10_0, getZSQTypeName(arg_10_1.tag), ccc3(219, 219, 112), 20, ccp(0.5, 0.5), ccp(arg_10_1.size.width / 2, 0), _FONT_LISU)
	end)

	local var_8_2 = arg_8_0.layerType

	if var_8_2 ~= nil then
		arg_8_0.layerType = nil

		arg_8_0:showLayerByType(var_8_2, var_8_1(var_8_2))
	else
		arg_8_0:showLayerByType(MasterType.eLand, var_8_1(MasterType.eLand))
	end
end

function var_0_5.showBottomButton(arg_12_0)
	local var_12_0 = {
		{
			extImage = "ui/fuben/zsq_005.png",
			tag = var_0_2.tagThreeLoop,
			titleText = string.lf("坚持2回合"),
			position = Adapter.AutoPos(240, 70),
			extOffset = Adapter.AutoPos(125, 0)
		},
		{
			extImage = "ui/fuben/zsq_005.png",
			tag = var_0_2.tagSixLoop,
			titleText = string.lf("坚持4回合"),
			position = Adapter.AutoPos(480, 70),
			extOffset = Adapter.AutoPos(125, 0)
		},
		{
			tag = var_0_2.tagFinalWin,
			titleText = string.lf("获得胜利"),
			position = Adapter.AutoPos(720, 70)
		}
	}

	arg_12_0.chestList = {}

	table.foreach(var_12_0, function(arg_13_0, arg_13_1)
		local var_13_0 = var_0_4[arg_13_1.tag][0]

		arg_13_1.normalImage = var_13_0
		arg_13_1.highlightedImage = var_13_0
		arg_13_1.size = Adapter.MinSize(100, 100)

		function arg_13_1.clickAction()
			local var_14_0 = arg_12_0.infoList[arg_12_0.layerType].chests[arg_13_1.tag].chest
			local var_14_1 = arg_13_1.titleText .. string.lf("的奖励")
			local var_14_2 = require("scenes.enhance.DlgResultLayer").new({
				titleText = var_14_1,
				rewardList = var_14_0
			})

			CCDirector:sharedDirector():getRunningScene():addChild(var_14_2, DefaultZOrder.ePopupLayer)
		end

		local var_13_1 = ui.newControlButton(arg_13_1)

		arg_12_0:addChild(var_13_1)
		addLabelWithColorSize(arg_12_0, arg_13_1.titleText, ccc3(0, 255, 0), 20, CCPoint(0.5, 1), CCPoint(arg_13_1.position.x, arg_13_1.position.y - Adapter.AutoPosY(45)))

		if arg_13_1.extImage and arg_13_1.extOffset then
			local var_13_2 = display.newSprite(arg_13_1.extImage)

			var_13_2:setPosition(arg_13_1.position.x + arg_13_1.extOffset.x, arg_13_1.position.y + arg_13_1.extOffset.y)
			var_13_2:setScale(Adapter.MinScale)
			arg_12_0:addChild(var_13_2)
		end

		arg_12_0.chestList[arg_13_1.tag] = var_13_1
	end)
end

function var_0_5.refreshChest(arg_15_0, arg_15_1)
	if arg_15_1 == nil or table.nums(arg_15_1) == 0 then
		return
	end

	for iter_15_0, iter_15_1 in pairs(arg_15_1) do
		local var_15_0 = arg_15_0.chestList[iter_15_1.type]
		local var_15_1 = var_0_4[iter_15_1.type][iter_15_1.state]

		var_15_0:setBackgroundSpriteForState(CCScale9Sprite:create(var_15_1), CCControlStateNormal)
		var_15_0:setBackgroundSpriteForState(CCScale9Sprite:create(var_15_1), CCControlStateHighlighted)
	end

	local var_15_2 = var_0_0.get("ZSQ_LastChestList")

	if var_15_2 ~= nil then
		local var_15_3 = {}

		for iter_15_2, iter_15_3 in ipairs(var_15_2) do
			local var_15_4 = arg_15_1[iter_15_2]

			if iter_15_3.state ~= var_15_4.state then
				for iter_15_4, iter_15_5 in pairs(var_15_4.chest) do
					table.insert(var_15_3, iter_15_5)
				end
			end
		end

		if table.nums(var_15_3) > 0 then
			local var_15_5 = require("scenes.enhance.DlgResultLayer").new({
				titleText = string.lf("您获得了以下奖励"),
				rewardList = var_15_3
			})

			arg_15_0:addChild(var_15_5, DefaultZOrder.ePopupLayer + 1)
		end

		var_0_0.set("ZSQ_LastChestList", nil)
	end
end

function var_0_5.createHeroList(arg_16_0)
	local var_16_0 = CCSize(800, 450)
	local var_16_1 = CCLayerColor:create(ccc4(255, 0, 0, 0))

	var_16_1:setContentSize(var_16_0)

	local var_16_2 = CCSize(230, 450)
	local var_16_3 = createTableView({
		reverse = false,
		direction = kCCScrollViewDirectionHorizontal,
		size = var_16_0,
		dataset = {},
		sizehandler = function(arg_17_0, arg_17_1)
			return var_16_2
		end,
		cellhandler = handler(arg_16_0, arg_16_0.createHeroCell)
	})

	var_16_3:setPosition(0, 0)
	var_16_3:setTouchEnabled(false)
	var_16_1:addChild(var_16_3)

	arg_16_0.tableView = var_16_3

	return var_16_1
end

function var_0_5.createHeroCell(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = CCSize(230, 450)
	local var_18_1 = CCLayerColor:create(ccc4(100, 0, 0, 0))

	var_18_1:setContentSize(var_18_0)

	local var_18_2 = display.newSprite("ui/fuben/zsq_006.png", var_18_0.width / 2, 0)

	var_18_2:setAnchorPoint(CCPoint(0.5, 0))
	var_18_2:setScale(0.9)
	var_18_1:addChild(var_18_2)

	local var_18_weapon = arg_18_3.weaponId or arg_18_3.WeaponId

	if not var_18_weapon or var_18_weapon == 0 then
		var_18_weapon = getHeroGroupWeaponId(arg_18_3.avatarID)
	end

	local var_18_3 = {
		isViewQuality = false,
		isViewBaseInfo = false,
		platTable = false,
		scale = 0.8,
		figId = arg_18_3.avatarID,
		equipId = var_18_weapon,
		pinjie = arg_18_3.pinJie or arg_18_3.PinJie or EquipPinjieType.eShengPin,
		rebirthCount = arg_18_3.rebirthCount or arg_18_3.BreakthroughCount or 0,
		clickAction = function()
			if arg_18_3.playerID ~= nil then
				local var_19_0 = require("scenes.fuben.ZSQLogLayer").new({
					playerId = arg_18_3.playerID,
					playerName = arg_18_3.name,
					avatarId = arg_18_3.avatarID
				})

				arg_18_0:addChild(var_19_0, DefaultZOrder.ePopupLayer)
			else
				showFlashNotice(string.lf("该位置暂无日志信息"))
			end
		end
	}
	local var_18_4 = figure.createHero(var_18_3)

	var_18_4:setPosition(var_18_0.width / 2 + 10, 110)
	var_18_1:addChild(var_18_4)

	local var_18_5 = getZSQTypeName(arg_18_0.layerType) .. " - " .. getZSQRankName(arg_18_3.rank)

	addLabelWithColorSize(var_18_1, var_18_5, ccc3(0, 255, 0), 22, CCPoint(0.5, 0), CCPoint(var_18_0.width / 2, 0))

	if arg_18_3.name ~= nil then
		addLabelWithColorSize(var_18_1, arg_18_3.name, ccc3(247, 211, 91), 20, CCPoint(0.5, 0.5), CCPoint(var_18_0.width / 2, 88))
	end

	if arg_18_3.battlePower ~= nil then
		addLabelWithColorSize(var_18_1, string.lf("战力: %s", arg_18_3.battlePower), ccc3(247, 211, 91), 18, CCPoint(0.5, 0.5), CCPoint(var_18_0.width / 2, 40))
	end

	if arg_18_3.unionName ~= nil then
		addLabelWithColorSize(var_18_1, "【" .. arg_18_3.unionName .. "】", ccc3(247, 211, 91), 18, CCPoint(0.5, 0.5), CCPoint(var_18_0.width / 2, 63))
	elseif arg_18_3.name ~= nil then
		addLabelWithColorSize(var_18_1, string.lf("散修"), ccc3(247, 91, 0), 18, CCPoint(0.5, 0.5), CCPoint(var_18_0.width / 2, 63))
	end

	if arg_18_3.continueWinTime ~= nil then
		local var_18_6 = display.newSprite("ui/PK/PK_006.png", var_18_0.width / 2 + 20, 400)

		var_18_1:addChild(var_18_6)
		addLabelWithColorSize(var_18_6, arg_18_3.continueWinTime, ccc3(247, 247, 247), 25, CCPoint(0.5, 0), CCPoint(45, 12))
	end

	if arg_18_0.myDaoType == arg_18_0.layerType then
		local var_18_7 = ui.newControlButton({
			normalImage = "uilocal/fuben/zsq_text_001.png",
			position = CCPoint(var_18_0.width / 2 + 75, 155),
			clickAction = function()
				local var_20_0 = os.date("*t").wday

				if var_20_0 == 1 or var_20_0 == 7 then
					ui.showMessageBox({
						text = string.lf("上仙，战三清在周六和周日不开放，速速前往参加诸神之战吧~"),
						title1 = string.lf("诸神之战"),
						title2 = string.lf("取消"),
						action1 = function()
							game.enterZSZZHomeScene()
						end
					})

					return
				end

				if arg_18_0.myDaoType ~= arg_18_0.layerType then
					local var_20_1 = string.lf("您不在") .. getZSQTypeName(arg_18_0.layerType) .. string.lf("，无法挑战")

					showFlashNotice(var_20_1)

					return
				end

				local var_20_2 = arg_18_0.infoList[arg_18_0.layerType]
				local var_20_3 = false

				for iter_20_0, iter_20_1 in pairs(var_20_2.sanqings) do
					if iter_20_1.playerID == Player.userId then
						var_20_3 = true

						break
					end
				end

				if var_20_3 == true then
					showFlashNotice(string.lf("您已经占领了宝座，不能继续挑战"))

					return
				end

				local function var_20_4(arg_22_0, arg_22_1)
					game.enterZSQHomeScene()
				end

				var_0_0.set("ZSQ_LastLayerType", arg_18_0.layerType)
				var_0_0.set("ZSQ_LastChestList", var_20_2.chests)
				BattleOperator:startBattle(eBattleType.ZSQFight, {
					fType = arg_18_0.layerType,
					fRank = arg_18_3.rank
				}, var_20_4)
			end
		})

		var_18_1:addChild(var_18_7)
	end

	return var_18_1
end

function var_0_5.showLayerByType(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0.layerType ~= nil and arg_23_0.layerType == arg_23_1 then
		return
	end

	arg_23_0.layerType = arg_23_1

	;(function(arg_24_0)
		if not arg_23_0.mFlashLightSprite then
			display.addSpriteFramesWithFile("ui/map/ui_baoxiang.plist", "ui/map/ui_baoxiang.png")

			local var_24_0 = display.newSprite("#ui_baoxiang_01.png")
			local var_24_1 = display.newFrames("ui_baoxiang_0%d.png", 1, 5)
			local var_24_2 = display.newAnimation(var_24_1, 0.1)

			var_24_0:setScale(Adapter.MinScale)
			var_24_0:runAction(CCRepeatForever:create(CCAnimate:create(var_24_2)))
			arg_23_0:addChild(var_24_0, 1)

			arg_23_0.mFlashLightSprite = var_24_0
		end

		arg_23_0.mFlashLightSprite:setPosition(arg_24_0)
	end)(arg_23_2)
	arg_23_0:setWorldType(arg_23_1)

	local var_23_0 = arg_23_0.infoList[arg_23_1]

	if var_23_0 == nil or var_23_0.sanqings == nil or var_23_0.chests == nil then
		arg_23_0.sanqingInfoRequest:request(arg_23_1)
	else
		arg_23_0.tableView:reloadData(var_23_0.sanqings)
		arg_23_0:refreshChest(var_23_0.chests)
	end
end

function var_0_5.setWorldType(arg_25_0, arg_25_1)
	arg_25_0.worldType = arg_25_1

	if arg_25_0.wordSprite then
		arg_25_0.wordSprite:removeFromParentAndCleanup(true)

		arg_25_0.wordSprite = nil
	end

	local var_25_0 = "xunfang_text_021.png"

	if arg_25_1 == MasterType.eLand then
		var_25_0 = "xunfang_text_021.png"
	elseif arg_25_1 == MasterType.eDemon then
		var_25_0 = "xunfang_text_022.png"
	elseif arg_25_1 == MasterType.eHeaven then
		var_25_0 = "xunfang_text_023.png"
	elseif arg_25_1 == MasterType.eOutHeaven then
		var_25_0 = "xunfang_text_024.png"
	end

	arg_25_0.wordSprite = display.newSprite("uilocal/xunfang/" .. var_25_0)

	arg_25_0.wordSprite:setPosition(Adapter.AutoPos(100, 580))
	arg_25_0.wordSprite:setScale(Adapter.MinScale)
	arg_25_0:addChild(arg_25_0.wordSprite)
end

return var_0_5
