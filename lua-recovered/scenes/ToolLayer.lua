local var_0_0 = require("scenes.toollayer.layer")

var_0_0.eShowPropBuy = 1
var_0_0.eShowPropSell = 2
var_0_0.eShowChallenge = 3
var_0_0.eShowSlaveCatch = 4
var_0_0.eShowReward = 5
var_0_0.eShowOpenFailed = 6
var_0_0.eShowChangeName = 7
var_0_0.eShowNoticeBox = 8
var_0_0.eShowEditBox = 9
var_0_0.eShowTeamHero = 10
var_0_0.eShowTeamEquip = 11
var_0_0.eShowTujianHero = 12
var_0_0.eShowTujianEquip = 13
var_0_0.eShowQualityFilter = 14
var_0_0.eShowFigureFilter = 15
var_0_0.eShowPropInfo = 16
var_0_0.eShowPowerEmpty = 17
var_0_0.eShowHeroList = 18
var_0_0.eShowEquipFeed = 19
var_0_0.eShowCSGamble = 20
var_0_0.eShowCSBattle = 21
var_0_0.eUseExpPill = 22
var_0_0.eShowTranportEmpty = 23
var_0_0.eShowShenqiSnatch = 24
var_0_0.eShowFuBenJieSuo = 25
var_0_0.eShowTianming = 26
var_0_0.eUsePotencyPill = 27
var_0_0.eShowGiftVolumeBuy = 28

require("scenes.toollayer.dialog")
require("scenes.toollayer.tips")
require("scenes.toollayer.toast")

function var_0_0.tipshandler(arg_1_0)
	local var_1_0 = ({
		[ItemType.eProp] = var_0_0.eShowPropInfo,
		[ItemType.eMate] = var_0_0.eShowPropInfo,
		[ItemType.eEquip] = var_0_0.eShowTeamEquip,
		[ItemType.eFragment] = var_0_0.eShowTeamEquip,
		[ItemType.eVIPLevel] = var_0_0.eShowPropInfo
	})[arg_1_0.Type]

	if arg_1_0.Type == ItemType.eHero or arg_1_0.Type == ItemType.eSoul then
		local var_1_1 = require("scenes.team.BaseHeroInfoLayer").new({
			type = arg_1_0.Type,
			id = arg_1_0.ID
		})

		display.getRunningScene():addChild(var_1_1)
	elseif var_1_0 then
		local var_1_2
		local var_1_3

		if var_1_0 == var_0_0.eShowTujianHero then
			var_1_2 = var_0_0.createDialog
		else
			var_1_2 = var_0_0.createTips
		end

		local var_1_4 = var_1_2({
			player = false,
			show = var_1_0,
			type = arg_1_0.Type,
			id = arg_1_0.ID,
			data = arg_1_0,
			align = display.CENTER
		})

		if var_1_0 ~= var_0_0.eShowTujianHero then
			var_1_4:addAction({
				text = string.lf("确定")
			})
		end

		var_1_4.margin = 0
		var_1_4.actionIn = var_0_0.popinLayer
		var_1_4.actionOut = var_0_0.popoutLayer

		var_1_4:show()
	end
end

return var_0_0
