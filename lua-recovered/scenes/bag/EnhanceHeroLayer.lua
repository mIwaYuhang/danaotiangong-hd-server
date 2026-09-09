local var_0_0 = class("EnhanceHeroLayer", function()
	return display.newLayer()
end)
local var_0_1
local var_0_2 = 0
local var_0_3
local var_0_4
local var_0_5 = {
	tagPageAttr = 1,
	tagPageSpell = 2,
	tagPageTrain = 3,
	tagPageRebirth = 4
}

var_0_0.ePagesBattle = 1
var_0_0.ePagesPlayerTeam = 2
var_0_0.ePagesFriendTeam = 3

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.pagesType = arg_2_1.pagesType or var_0_0.ePagesPlayerTeam
	arg_2_0.team = arg_2_1.team or Player.team
	arg_2_0.partnerTeam = arg_2_1.partnerTeam or Player.partnerTeam
	arg_2_0.curIndex = arg_2_1.curIndex and arg_2_1.curIndex or -1

	arg_2_0:refreshLayer(arg_2_1)
end

function var_0_0.refreshLayer(arg_3_0, arg_3_1)
	arg_3_0:removeAllChildrenWithCleanup(true)

	arg_3_0.curIndex = arg_3_1.curIndex
	arg_3_0.isShowRebirth = arg_3_1.isShowRebirth or false
	var_0_1 = arg_3_1.heroItem
	var_0_3 = arg_3_1.callback

	if var_0_1 == nil then
		return
	end

	arg_3_0:showTabButtons()

	if arg_3_0.redPointSprite then
		local var_3_0 = figure.heroCanRebirth(var_0_1.heroId, var_0_1.level, var_0_1.rebirthCount)

		arg_3_0.redPointSprite:setVisible(var_3_0)
	end
end

function var_0_0.refreshHeroItem(arg_4_0, arg_4_1)
	var_0_1 = arg_4_1.heroItem
	var_0_3 = arg_4_1.callback or var_0_3
	arg_4_0.curIndex = arg_4_1.curIndex
	arg_4_0.isShowRebirth = arg_4_1.isShowRebirth or false
	arg_4_0.curIndex = arg_4_1.curIndex and arg_4_1.curIndex or -1

	if var_0_4 then
		var_0_4:refreshLayer({
			heroItem = var_0_1,
			curIndex = arg_4_0.curIndex
		})
	end

	if arg_4_0.redPointSprite then
		local var_4_0 = figure.heroCanRebirth(var_0_1.heroId, var_0_1.level, var_0_1.rebirthCount)

		arg_4_0.redPointSprite:setVisible(var_4_0)
	end
end

function var_0_0.showTabButtons(arg_5_0)
	local var_5_0

	if arg_5_0.pagesType == var_0_0.ePagesBattle then
		var_5_0 = {
			tabMenuWidth = 105,
			selectedImage = "ui/common/common_034.png",
			normalImage = "ui/common/common_035.png",
			tabMenuOffset = 65,
			titleTable = {
				string.lf("属性"),
				string.lf("法术"),
				string.lf("培养"),
				string.lf("进阶")
			}
		}
	else
		var_5_0 = {
			tabMenuWidth = 140,
			selectedImage = "ui/common/common_023.png",
			normalImage = "ui/common/common_022.png",
			tabMenuOffset = 80,
			titleTable = {
				string.lf("属性"),
				string.lf("法术信息"),
				string.lf("主将培养"),
				string.lf("主将进阶")
			}
		}
	end

	local var_5_1 = {}
	local var_5_2 = var_5_0.tabMenuOffset

	if arg_5_0.pagesType == var_0_0.ePagesBattle then
		var_5_1[var_0_5.tagPageAttr] = {
			isDefault = false,
			tag = var_0_5.tagPageAttr,
			x = var_5_2,
			titleText = var_5_0.titleTable[1]
		}
		var_5_2 = var_5_2 + var_5_0.tabMenuWidth
	end

	var_5_1[var_0_5.tagPageSpell] = {
		isDefault = false,
		tag = var_0_5.tagPageSpell,
		x = var_5_2,
		titleText = var_5_0.titleTable[2]
	}

	if arg_5_0.pagesType ~= var_0_0.ePagesFriendTeam then
		local var_5_3 = var_5_2 + var_5_0.tabMenuWidth

		var_5_1[var_0_5.tagPageRebirth] = {
			isDefault = false,
			tag = var_0_5.tagPageRebirth,
			x = var_5_3,
			titleText = var_5_0.titleTable[4]
		}

		if Player.level >= GameFeaturesLevel[GameFeatures.eHeroTrain].level then
			local var_5_4 = var_5_3 + var_5_0.tabMenuWidth

			var_5_1[var_0_5.tagPageTrain] = {
				isDefault = false,
				tag = var_0_5.tagPageTrain,
				x = var_5_4,
				titleText = var_5_0.titleTable[3]
			}
		end
	else
		local var_5_5 = require("base.cache").get("team_attributeAddition")
		local var_5_6 = ui.newControlButton({
			fontSize = 25,
			normalImage = "ui/common/common_110.png",
			text = string.lf("属性加成"),
			position = CCPoint(800, 547),
			clickAction = function()
				arg_5_0:onClick(var_5_5)
			end
		})

		arg_5_0:addChild(var_5_6, 1)

		if var_5_5 == nil then
			var_5_6:setVisible(false)
		else
			var_5_6:setVisible(true)
		end
	end

	local var_5_7 = var_0_5.tagPageSpell

	if arg_5_0.pagesType == var_0_0.ePagesBattle then
		if var_0_2 > 0 then
			var_5_7 = var_0_2
		else
			var_5_7 = var_0_5.tagPageAttr
		end
	end

	if Player:getTroMaxStep() == NSStep.ZhanYi6Reward or arg_5_0.isShowRebirth == true then
		var_5_7 = var_0_5.tagPageRebirth
	end

	var_5_1[var_5_7].isDefault = true

	local function var_5_8(arg_7_0, arg_7_1)
		if arg_5_0.pagesType == var_0_0.ePagesBattle == true then
			var_0_2 = arg_7_1
		end

		if arg_7_1 == var_0_5.tagPageAttr then
			arg_5_0:showHeroAttr(arg_7_0)
		elseif arg_7_1 == var_0_5.tagPageSpell then
			arg_5_0:showHeroSpell(arg_7_0)
		elseif arg_7_1 == var_0_5.tagPageTrain then
			arg_5_0:showHeroTrain(arg_7_0)
		elseif arg_7_1 == var_0_5.tagPageRebirth then
			arg_5_0:showHeroRebirth(arg_7_0)
		end
	end

	arg_5_0.tabLayer = require("scenes.TabLayer").new({
		normalImage = var_5_0.normalImage,
		selectedImage = var_5_0.selectedImage,
		size = CCSize(445, 510),
		point = CCPoint(503, 7),
		config = var_5_1,
		cellHandler = var_5_8
	})

	arg_5_0:addChild(arg_5_0.tabLayer, 1)

	local var_5_9 = arg_5_0.tabLayer:getTabItems()

	for iter_5_0, iter_5_1 in pairs(var_5_9) do
		if iter_5_1:getTag() == var_0_5.tagPageRebirth then
			local var_5_10 = iter_5_1:getPreferredSize()
			local var_5_11 = ui.createRedPoint({
				scale = 0.7,
				parent = iter_5_1,
				position = ccp(var_5_10.width * 0.85, var_5_10.height * 0.9)
			})

			var_5_11:setVisible(false)

			arg_5_0.redPointSprite = var_5_11

			break
		end
	end
end

function var_0_0.onClick(arg_8_0, arg_8_1)
	if arg_8_1 == nil then
		return
	else
		local var_8_0 = require("scenes.team.HeroAdditionLayer").new(arg_8_1)

		display.getRunningScene():addChild(var_8_0)
	end
end

function var_0_0.showHeroAttr(arg_9_0, arg_9_1)
	local var_9_0 = require("scenes.bag.HeroEnhanceInfoLayer").new({
		heroItem = var_0_1
	})

	arg_9_1:addChild(var_9_0)

	var_0_4 = var_9_0
end

function var_0_0.showHeroSpell(arg_10_0, arg_10_1)
	local var_10_0 = require("scenes.team.HeroSpellInfoLayer").new({
		heroItem = var_0_1,
		size = CCSize(445, 510),
		team = arg_10_0.team,
		partnerTeam = arg_10_0.partnerTeam,
		curIndex = arg_10_0.curIndex
	})

	arg_10_1:addChild(var_10_0)

	var_0_4 = var_10_0
end

function var_0_0.showHeroTrain(arg_11_0, arg_11_1)
	local function var_11_0(arg_12_0)
		var_0_3(var_0_1.heroId)
	end

	local var_11_1 = require("scenes.team.HeroTrainLayer").new({
		heroItem = var_0_1,
		callback = var_11_0,
		size = CCSize(445, 510)
	})

	arg_11_1:addChild(var_11_1)

	var_0_4 = var_11_1
end

function var_0_0.showHeroRebirth(arg_13_0, arg_13_1)
	local function var_13_0(arg_14_0)
		var_0_3(var_0_1.heroId)
	end

	local var_13_1 = require("scenes.team.HeroRebirthLayer").new({
		curIndex = arg_13_0.curIndex,
		teamScene = arg_13_0.teamScene,
		heroItem = var_0_1,
		callback = var_13_0,
		size = CCSize(445, 510)
	})

	arg_13_0.heroRebirthLayer = var_13_1

	arg_13_1:addChild(var_13_1)

	var_0_4 = var_13_1
end

return var_0_0
