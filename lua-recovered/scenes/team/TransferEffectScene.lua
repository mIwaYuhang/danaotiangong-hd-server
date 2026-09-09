require("base.functions")
require("network.PropRequest")
require("scenes.enhance.RefineScene")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("TransferEffectScene", function()
	return display.newScene("TransferEffectScene")
end)

TransferEffectType = {
	eTeamInherit = 2,
	eEnhanceInherit = 3
}

function getNeedExpWithLevel(arg_2_0, arg_2_1)
	local var_2_0 = (arg_2_0 * ({
		[QualityType.eGreen] = 1,
		[QualityType.eBlue] = 1.05,
		[QualityType.ePurple] = 1.1,
		[QualityType.eOrange] = 1.15
	})[arg_2_1] + 5)^2.4

	return math.round(var_2_0)
end

function calcLevelWithAddExp(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_1 + arg_3_2
	local var_3_1 = getNeedExpWithLevel(arg_3_0, arg_3_3)

	if var_3_0 < var_3_1 then
		return arg_3_0, var_3_0, var_3_1
	end

	return calcLevelWithAddExp(arg_3_0 + 1, 0, var_3_0 - var_3_1, arg_3_3)
end

function var_0_1.ctor(arg_4_0, arg_4_1)
	arg_4_0.heroIndex = arg_4_1.heroIndex
	arg_4_0.changeType = arg_4_1.changeType
	arg_4_0.isTouchable = arg_4_1.isTouchable
	arg_4_0.curHeroInfo = arg_4_1.heroInfo

	local var_4_0 = display.newSprite("ui/team/team_122.jpg", display.cx, display.cy)

	var_4_0:setScale(Adapter.AutoScaleY)
	arg_4_0:addChild(var_4_0)

	arg_4_0.bgSprite = var_4_0
	arg_4_0.bgSize = var_4_0:getContentSize()

	local var_4_1 = CCSprite:create("ui/common/common_061.png"):getTextureRect().size
	local var_4_2 = ui.newControlButton({
		normalImage = "ui/common/common_061.png",
		size = Adapter.MinSize(var_4_1.width, var_4_1.height),
		position = Adapter.AutoPos(900, 600),
		clickAction = function()
			arg_4_0:closePage()
		end
	})

	arg_4_0:addChild(var_4_2)
	arg_4_0:initChangeRequests()

	arg_4_0.heroIndexTable = {}

	local var_4_3 = 1

	if arg_4_0.isTouchable == false then
		table.insert(arg_4_0.heroIndexTable, 1)
	else
		for iter_4_0, iter_4_1 in ipairs(Player.team.groupList) do
			if iter_4_1.heroId > 0 then
				table.insert(arg_4_0.heroIndexTable, iter_4_0)
			end
		end
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_0.heroIndexTable) do
		if iter_4_3 == arg_4_0.heroIndex then
			var_4_3 = iter_4_2
		end
	end

	arg_4_0:showUIInfo()
	arg_4_0:showHeroSliderLayer(var_4_3)
	GuideLayer:stepDone(TaskEntryType.eHeroPractice, 3)
	GuideLayer:showGuideLayer(arg_4_0, arg_4_0, TaskEntryType.eHeroPractice, 4, nil, true)
	GuideLayer:showGuideLayer(arg_4_0, arg_4_0, TaskEntryType.eHeroTransfer, 1, nil, true)
end

function var_0_1.initChangeRequests(arg_6_0)
	local function var_6_0()
		local var_7_0 = arg_6_0.heroUpdateRequest.restable
		local var_7_1 = arg_6_0.heroLayer:getCurrentIndex()
		local var_7_2 = arg_6_0.heroIndexTable[var_7_1]
		local var_7_3 = Player.team.groupList[var_7_2]

		if arg_6_0.curHeroInfo then
			var_7_3 = Player:getOwnedFigure(arg_6_0.curHeroInfo.heroId)
		end

		local var_7_4 = BaseHeros[var_7_3.heroId].quality
		local var_7_5 = calcLevelWithAddExp(var_7_3.level, var_7_3.curExp, Player.heroExpPool, var_7_4)
		local var_7_6

		if var_7_5 > var_7_3.level then
			var_7_6 = var_7_5 > Player.level and string.lf("#FF0000%s级(玩家等级限制为%s级)", var_7_5, Player.level) or string.lf("%s级", var_7_5)
		else
			var_7_6 = string.lf("#FF0000不够升级")
		end

		arg_6_0.poolExpLabel:setString(Player.heroExpPool)
		arg_6_0.updateToLabel:setString(var_7_6)
		arg_6_0:refreshHeroInfo(var_7_1)

		local var_7_7 = CCSkeletonAnimation:createWithFile("effectAni/ui_shengji.json", "effectAni/ui_shengji.atlas", 1)

		var_7_7:setAnimation("animation", false, 0)
		var_7_7:setPosition(display.cx, display.cy + 120)
		arg_6_0:addChild(var_7_7, DefaultZOrder.ePopupLayer)
	end

	arg_6_0.heroUpdateRequest = HeroUpdateLevelRequest:new(arg_6_0)

	arg_6_0.heroUpdateRequest:setResponseNormalHandler(var_6_0)
end

function var_0_1.showHeroSliderLayer(arg_8_0, arg_8_1)
	local function var_8_0(arg_9_0, arg_9_1)
		local var_9_0 = arg_8_0.heroIndexTable[arg_9_1]
		local var_9_1 = Player.team.groupList[var_9_0]

		if arg_8_0.curHeroInfo then
			var_9_1 = Player:getOwnedFigure(arg_8_0.curHeroInfo.heroId)
		end

		local var_9_2 = var_9_1.heroId
		local var_9_3 = var_9_1.rebirthCount
		local var_9_4 = {
			isViewQuality = false,
			platTable = false,
			isViewBaseInfo = false,
			figId = var_9_2,
			equipId = getHeroGroupWeaponId(var_9_2),
			pinjie = EquipPinjieType.eShengPin,
			scale = Adapter.MinScale,
			rebirthCount = var_9_3,
			clickAction = function()
				local var_10_0 = require("scenes.team.BaseHeroInfoLayer").new({
					id = var_9_2
				})

				display.getRunningScene():addChild(var_10_0)
			end
		}
		local var_9_5 = figure.createHero(var_9_4)

		var_9_5:setPosition(Adapter.MinPos(300, 20))
		arg_9_0:addChild(var_9_5)
	end

	local function var_8_1(arg_11_0)
		arg_8_0:refreshHeroInfo(arg_11_0)

		arg_8_0.heroIndex = arg_8_0.heroIndexTable[arg_11_0]
	end

	arg_8_0.heroLayer = require("scenes.SliderLayer").new({
		size = Adapter.MinSize(600, 400),
		point = ccp(display.cx - 300 * Adapter.MinScale, 250 * Adapter.AutoScaleY),
		numberHandler = function()
			return #arg_8_0.heroIndexTable
		end,
		changedHandler = var_8_1,
		cellHandler = var_8_0,
		direction = SliderDirection.eHorizontal
	})

	arg_8_0.heroLayer:reloadData(arg_8_1)
	arg_8_0:addChild(arg_8_0.heroLayer)
end

function var_0_1.showUIInfo(arg_13_0)
	local var_13_0 = Player.team.groupList[arg_13_0.heroIndex]

	if arg_13_0.curHeroInfo then
		var_13_0 = Player:getOwnedFigure(arg_13_0.curHeroInfo.heroId)
	end

	local var_13_1 = BaseHeros[var_13_0.heroId].quality
	local var_13_2 = display.newSprite("uilocal/team/team_text_042.png")

	var_13_2:setAnchorPoint(CCPoint(0, 1))
	var_13_2:setPosition(Adapter.AutoPos(20, 620))
	var_13_2:setScale(Adapter.MinScale)
	arg_13_0:addChild(var_13_2)

	local var_13_3 = calcLevelWithAddExp(var_13_0.level, var_13_0.curExp, Player.heroExpPool, var_13_1)
	local var_13_4 = var_13_2:getContentSize()
	local var_13_5

	if var_13_3 > var_13_0.level then
		var_13_5 = var_13_3 > Player.level and string.lf("#FF0000%s级(玩家等级限制为%s级)", var_13_3, Player.level) or string.lf("%s级", var_13_3)
	else
		var_13_5 = string.lf("#FF0000不够升级")
	end

	arg_13_0.poolExpLabel = addLabelWithColorSize(var_13_2, Player.heroExpPool, ccc3(255, 255, 0), 20, CCPoint(0, 0.5), CCPoint(var_13_4.width * 0.77, var_13_4.height * 0.75))
	arg_13_0.updateToLabel = addLabelWithColorSize(var_13_2, var_13_5, ccc3(255, 255, 0), 20, CCPoint(0, 0.5), CCPoint(var_13_4.width * 1, var_13_4.height * 0.23))

	arg_13_0:refreshHeroInfo()

	local var_13_6 = display.newSprite("uilocal/team/team_text_046.png")

	var_13_6:setPosition(Adapter.AutoPos(480, 200))
	var_13_6:setScale(Adapter.MinScale)
	arg_13_0:addChild(var_13_6)

	local var_13_7 = display.newSprite("uilocal/team/team_text_047.png")

	var_13_7:setPosition(Adapter.AutoPos(140, 345))
	var_13_7:setScale(Adapter.MinScale)
	arg_13_0:addChild(var_13_7)

	local var_13_8 = ui.newControlButton({
		highlightedImage = "ui/common/common_115.png",
		titleImage = "uilocal/team/team_text_043.png",
		normalImage = "ui/common/common_115.png",
		scaleX = Adapter.MinScale,
		scaleY = Adapter.MinScale,
		position = Adapter.AutoPos(140, 400),
		clickAction = function()
			if arg_13_0.isTouchable == false then
				arg_13_0.heroIndex = nil
			else
				var_13_0 = nil
			end

			game.enterRefineScene({
				defaultType = EnhanceType.eEquipRebirth,
				transferData = {
					heroIndex = arg_13_0.heroIndex,
					heroInfo = var_13_0,
					changeType = arg_13_0.changeType,
					isTouchable = arg_13_0.isTouchable
				}
			})
		end
	})
	local var_13_9 = display.newSprite("ui/team/team_087.png", Adapter.AutoPosX(display.cx + 200), Adapter.AutoPosY(display.cy + 80))

	arg_13_0:addChild(var_13_9)

	local var_13_10 = display.newSprite("ui/team/team_087.png", Adapter.AutoPosX(display.cx - 200), Adapter.AutoPosY(display.cy + 80))

	var_13_10:setFlipX(true)
	arg_13_0:addChild(var_13_10)

	local var_13_11 = ui.newControlButton({
		highlightedImage = "ui/common/common_110.png",
		titleImage = "uilocal/team/team_text_045.png",
		normalImage = "ui/common/common_110.png",
		scaleX = Adapter.MinScale,
		scaleY = Adapter.MinScale,
		position = Adapter.AutoPos(160, 100),
		clickAction = function()
			GuideLayer:removeGuideLayer(arg_13_0, TaskEntryType.eHeroPractice, 4)
			GuideLayer:stepDone(TaskEntryType.eHeroPractice, 4)

			local var_15_0 = arg_13_0.heroLayer:getCurrentIndex()
			local var_15_1 = arg_13_0.heroIndexTable[var_15_0]
			local var_15_2 = Player.team.groupList[var_15_1]

			if arg_13_0.curHeroInfo then
				var_15_2 = Player:getOwnedFigure(arg_13_0.curHeroInfo.heroId)
			end

			local var_15_3 = BaseHeros[var_15_2.heroId].quality

			if var_15_2.level >= Player.level then
				showFlashNotice(string.lf("主将等级不能超过玩家的等级"))

				return
			end

			if getNeedExpWithLevel(var_15_2.level, var_15_3) - var_15_2.curExp > Player.heroExpPool then
				showFlashNotice(string.lf("经验池内的剩余经验不够升1级"))

				return
			end

			local var_15_4 = var_15_2.heroId

			arg_13_0.heroUpdateRequest:request(var_15_4, 1)
		end
	})
	local var_13_12 = ui.newControlButton({
		highlightedImage = "ui/common/common_110.png",
		titleImage = "uilocal/team/team_text_044.png",
		normalImage = "ui/common/common_110.png",
		scaleX = Adapter.MinScale,
		scaleY = Adapter.MinScale,
		position = Adapter.AutoPos(800, 100),
		clickAction = function()
			local var_16_0 = arg_13_0.heroLayer:getCurrentIndex()
			local var_16_1 = arg_13_0.heroIndexTable[var_16_0]
			local var_16_2 = Player.team.groupList[var_16_1]

			if arg_13_0.curHeroInfo then
				var_16_2 = Player:getOwnedFigure(arg_13_0.curHeroInfo.heroId)
			end

			if var_16_2.level >= Player.level then
				showFlashNotice(string.lf("主将等级不能超过玩家的等级"))

				return
			end

			if Player.heroExpPool == 0 then
				showFlashNotice(string.lf("经验池内已经没有剩余经验"))

				return
			end

			local var_16_3 = var_16_2.heroId

			arg_13_0.heroUpdateRequest:request(var_16_3, -1)
		end
	})

	arg_13_0:addChild(var_13_8)
	arg_13_0:addChild(var_13_11)
	arg_13_0:addChild(var_13_12)
end

function var_0_1.refreshHeroInfo(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.heroIndexTable[arg_17_1] or arg_17_0.heroIndex
	local var_17_1 = Player.team.groupList[var_17_0]

	if arg_17_0.curHeroInfo then
		var_17_1 = Player:getOwnedFigure(arg_17_0.curHeroInfo.heroId)
	end

	local var_17_2 = var_17_1.heroId
	local var_17_3 = var_17_1.rebirthCount
	local var_17_4 = BaseHeros[var_17_1.heroId]
	local var_17_5 = var_17_4.quality
	local var_17_6 = string.format("【%s】%s", HeroProfessionNames[var_17_4.profession], var_17_4.name)

	if arg_17_0.heroNameLabel == nil then
		arg_17_0.heroNameLabel = addLabelWithColorSize(arg_17_0, "", getQualityColor(var_17_5), 25, CCPoint(0.5, 0.5), Adapter.AutoPos(480, 160))
	end

	arg_17_0.heroNameLabel:setString(var_17_6)

	if arg_17_0.heroJinjieLabel == nil then
		arg_17_0.heroJinjieLabel = addLabelWithColorSize(arg_17_0, "", ccc3(234, 206, 120), 20, CCPoint(0.5, 0.5), Adapter.AutoPos(480, 120))
	end

	arg_17_0.heroJinjieLabel:setString(string.lf("进阶阶段 #EBDD9E%s", RebirthNames[var_17_3 + 1] == nil and string.lf("已满级") or RebirthNames[var_17_3 + 1]))

	if arg_17_0.heroLevelLabel == nil then
		arg_17_0.heroLevelLabel = addLabelWithColorSize(arg_17_0, "", ccc3(234, 206, 120), 20, CCPoint(0.5, 0.5), Adapter.AutoPos(480, 90))
	end

	arg_17_0.heroLevelLabel:setString(string.lf("主将等级 #EBDD9E%s级", var_17_1.level))

	if arg_17_0.heroQianliLabel == nil then
		arg_17_0.heroQianliLabel = addLabelWithColorSize(arg_17_0, "", ccc3(234, 206, 120), 20, CCPoint(0.5, 0.5), Adapter.AutoPos(480, 60))
	end

	arg_17_0.heroQianliLabel:setString(string.lf("潜力        #EBDD9E%s", var_17_1.potency))

	local var_17_7 = getNeedExpWithLevel(var_17_1.level, var_17_5) - var_17_1.curExp

	if arg_17_0.remainExpLabel == nil then
		arg_17_0.remainExpLabel = addLabelWithColorSize(arg_17_0, "", ccc3(255, 255, 0), 20, CCPoint(0.5, 0.5), Adapter.AutoPos(480, 20))
	end

	arg_17_0.remainExpLabel:setString(string.lf("升级所需经验: %s", var_17_7))
end

function var_0_1.closePage(arg_18_0)
	if arg_18_0.changeType == TransferEffectType.eEnhanceInherit then
		game.enterHeroScene()
	else
		game.enterTeamScene({
			index = arg_18_0.heroIndex
		})
	end
end

return var_0_1
