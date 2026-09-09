require("base.notification")

local var_0_0 = {
	string.lf("人界"),
	string.lf("地界"),
	string.lf("天界"),
	(string.lf("重天"))
}
local var_0_1 = {
	string.lf("太清"),
	string.lf("玉清"),
	(string.lf("上清"))
}

function getZSQTypeName(arg_1_0)
	return var_0_0[arg_1_0]
end

function getZSQRankName(arg_2_0)
	return var_0_1[arg_2_0]
end

function matchEmailAddress(arg_3_0)
	return #arg_3_0 > 0 and not not arg_3_0:match("^[%w+%.%-_]+@[%w+%.%-_]+%.%a%a+$")
end

function matchPhoneNumber(arg_4_0)
	return #arg_4_0 > 0 and not not arg_4_0:match("^[1-9]%d%d%d%d%d%d%d%d%d%d$")
end

function matchValidedString(arg_5_0)
	if IPlatform:instance():getConfig("Channel") == "ZSY_VN" then
		return #arg_5_0 > 0 and not string.match(arg_5_0, "[^%w]+")
	else
		return #arg_5_0 > 0 and not arg_5_0:match("[ %c%%'\"]+")
	end
end

function string.asciilen(arg_6_0)
	local var_6_0 = {
		0,
		192,
		224,
		240,
		248,
		252
	}
	local var_6_1 = #var_6_0
	local var_6_2 = 0
	local var_6_3 = 0
	local var_6_4 = 0
	local var_6_5 = #arg_6_0
	local var_6_6 = 0

	while var_6_5 > 0 do
		local var_6_7, var_6_8, var_6_9 = 1, var_6_1, string.byte(arg_6_0, -var_6_5)

		while var_6_0[var_6_8] do
			if var_6_9 >= var_6_0[var_6_8] then
				var_6_5 = var_6_5 - var_6_8

				break
			end

			var_6_8 = var_6_8 - 1
		end

		var_6_2 = var_6_2 + (var_6_8 == 1 and 1 or 2)
	end

	return var_6_2
end

function math.showDecimal(arg_7_0, arg_7_1)
	local var_7_0 = math.pow(10, arg_7_1)
	local var_7_1 = arg_7_0 * var_7_0
	local var_7_2 = math.floor(var_7_1)

	if var_7_1 - var_7_2 >= 0.5 then
		var_7_2 = var_7_2 + 1
	end

	return var_7_2 / var_7_0
end

function stringBase64AndUrlEncode(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0

	if arg_8_1 == nil or arg_8_1 == false then
		var_8_0 = crypto.encodeBase64(arg_8_0)
	end

	local function var_8_1(arg_9_0)
		local var_9_0 = string.byte(arg_9_0)

		if var_9_0 and var_9_0 > 0 then
			return "%" .. string.format("%02X", var_9_0)
		end
	end

	function urlencode(arg_10_0)
		arg_10_0 = string.gsub(tostring(arg_10_0), "\n", "\r\n")
		arg_10_0 = string.gsub(arg_10_0, "([^%w%.%- ])", var_8_1)

		return string.gsub(arg_10_0, " ", "+")
	end

	return (urlencode(var_8_0))
end

function getDateFromSeconds(arg_11_0)
	local var_11_0 = math.abs(arg_11_0)
	local var_11_1 = math.floor(var_11_0 % 60)
	local var_11_2 = math.floor(var_11_0 / 60 % 60)
	local var_11_3 = math.floor(var_11_0 / 60 / 60 % 24)

	return math.floor(var_11_0 / 60 / 60 / 24), var_11_3, var_11_2, var_11_1
end

function getFormatCountDownTime(arg_12_0)
	local var_12_0, var_12_1, var_12_2, var_12_3 = getDateFromSeconds(arg_12_0)

	if var_12_0 > 0 then
		return string.lf("%d天前", var_12_0)
	elseif var_12_1 > 0 then
		return string.lf("%d小时前", var_12_1)
	elseif var_12_2 > 0 then
		return string.lf("%d分钟前", var_12_2)
	elseif var_12_3 > 0 then
		return string.lf("%d秒前", var_12_3)
	else
		return string.lf("%d秒前", 1)
	end
end

function formatTime(arg_13_0, arg_13_1)
	arg_13_1 = arg_13_1 or {}

	local var_13_0 = arg_13_1.sep or ":"
	local var_13_1 = ""
	local var_13_2, var_13_3, var_13_4, var_13_5 = getDateFromSeconds(arg_13_0)

	if arg_13_1.day or var_13_2 > 0 then
		var_13_1 = var_13_1 .. string.lf("%s天 ", var_13_2)
	end

	var_13_3 = var_13_3 > 9 and tostring(var_13_3) or "0" .. var_13_3
	var_13_4 = var_13_4 > 9 and tostring(var_13_4) or "0" .. var_13_4
	var_13_5 = var_13_5 > 9 and tostring(var_13_5) or "0" .. var_13_5

	if arg_13_1.hour ~= false then
		var_13_1 = var_13_1 .. var_13_3 .. var_13_0
	end

	if arg_13_1.min ~= false then
		var_13_1 = var_13_1 .. var_13_4
	end

	if arg_13_1.sec ~= false then
		var_13_1 = var_13_1 .. var_13_0 .. var_13_5
	end

	return var_13_1
end

function convertColorToLabelString(arg_14_0)
	return string.format("#%02X%02X%02X", arg_14_0.r, arg_14_0.g, arg_14_0.b)
end

function getPinjieColor(arg_15_0, arg_15_1)
	local var_15_0

	if arg_15_0 == EquipPinjieType.eFanPin then
		var_15_0 = ccc3(104, 104, 104)
	elseif arg_15_0 == EquipPinjieType.eJingPin then
		var_15_0 = ccc3(57, 155, 11)
	elseif arg_15_0 == EquipPinjieType.eShangPin then
		var_15_0 = ccc3(10, 104, 147)
	elseif arg_15_0 == EquipPinjieType.eJiPin then
		var_15_0 = ccc3(135, 9, 141)
	elseif arg_15_0 == EquipPinjieType.eShengPin then
		var_15_0 = ccc3(189, 168, 50)
	else
		var_15_0 = ccc3(104, 104, 104)
	end

	if arg_15_1 then
		var_15_0 = string.format("#%02X%02X%02X", var_15_0.r, var_15_0.g, var_15_0.b)
	end

	return var_15_0
end

function getPinjieSmallImageName(arg_16_0)
	if arg_16_0 == EquipPinjieType.eFanPin then
		return "ui/common/pinjie_fan_small.png"
	elseif arg_16_0 == EquipPinjieType.eJingPin then
		return "ui/common/pinjie_jing_small.png"
	elseif arg_16_0 == EquipPinjieType.eShangPin then
		return "ui/common/pinjie_shang_small.png"
	elseif arg_16_0 == EquipPinjieType.eJiPin then
		return "ui/common/pinjie_ji_small.png"
	elseif arg_16_0 == EquipPinjieType.eShengPin then
		return "ui/common/pinjie_sheng_small.png"
	else
		return "ui/common/pinjie_fan_small.png"
	end
end

function getPinjieBigImageName(arg_17_0)
	if arg_17_0 == EquipPinjieType.eFanPin then
		return "ui/common/pinjie_fan_big.png"
	elseif arg_17_0 == EquipPinjieType.eJingPin then
		return "ui/common/pinjie_jing_big.png"
	elseif arg_17_0 == EquipPinjieType.eShangPin then
		return "ui/common/pinjie_shang_big.png"
	elseif arg_17_0 == EquipPinjieType.eJiPin then
		return "ui/common/pinjie_ji_big.png"
	elseif arg_17_0 == EquipPinjieType.eShengPin then
		return "ui/common/pinjie_sheng_big.png"
	else
		return "ui/common/pinjie_fan_big.png"
	end
end

function getProfessionIconImageName(arg_18_0)
	if arg_18_0 == HeroProfession.eCommander then
		return "uilocal/common/common_text_015.png"
	elseif arg_18_0 == HeroProfession.eWarrior then
		return "uilocal/common/common_text_013.png"
	elseif arg_18_0 == HeroProfession.eMage then
		return "uilocal/common/common_text_014.png"
	else
		return getProfessionIconImageName(HeroProfession.eCommander)
	end
end

QualityAttr = {
	eButton = 4,
	eImage = 3,
	eColor = 2,
	eBkgLevel = 7,
	eName = 1,
	eBkgRound = 6,
	eBkgStore = 8,
	eBkgNormal = 5
}

function getQualityAttribute(arg_19_0, arg_19_1)
	local var_19_0 = {
		[QualityType.eGreen] = {
			bkgRound = "ui/common/common_007.png",
			bkgNormal = "ui/common/common_002.png",
			image = "uilocal/common/common_text_004.png",
			bkgStore = "ui/store/store_028.png",
			bkgLevel = "ui/common/common_014.png",
			name = QualityNames[QualityType.eGreen],
			color = ccc3(39, 131, 3),
			button = {
				"ui/team/team_020.png",
				"ui/team/team_020.png"
			}
		},
		[QualityType.eBlue] = {
			bkgRound = "ui/common/common_008.png",
			bkgNormal = "ui/common/common_001.png",
			image = "uilocal/common/common_text_003.png",
			bkgStore = "ui/store/store_029.png",
			bkgLevel = "ui/common/common_013.png",
			name = QualityNames[QualityType.eBlue],
			color = ccc3(0, 90, 255),
			button = {
				"ui/team/team_019.png",
				"ui/team/team_019.png"
			}
		},
		[QualityType.ePurple] = {
			bkgRound = "ui/common/common_009.png",
			bkgNormal = "ui/common/common_003.png",
			image = "uilocal/common/common_text_002.png",
			bkgStore = "ui/store/store_030.png",
			bkgLevel = "ui/common/common_015.png",
			name = QualityNames[QualityType.ePurple],
			color = ccc3(186, 0, 255),
			button = {
				"ui/team/team_018.png",
				"ui/team/team_018.png"
			}
		},
		[QualityType.eOrange] = {
			bkgRound = "ui/common/common_010.png",
			bkgNormal = "ui/common/common_004.png",
			image = "uilocal/common/common_text_001.png",
			bkgStore = "ui/store/store_031.png",
			bkgLevel = "ui/common/common_016.png",
			name = QualityNames[QualityType.eOrange],
			color = ccc3(255, 216, 0),
			button = {
				"ui/team/team_017.png",
				"ui/team/team_017.png"
			}
		},
		[QualityType.eNone] = {
			bkgStore = "ui/store/store_028.png",
			bkgLevel = "ui/common/common_014.png",
			color = ccc3(255, 255, 64),
			button = {
				"ui/team/team_020.png",
				"ui/team/team_020.png"
			}
		},
		[QualityType.eWhite] = {
			bkgNormal = "ui/common/common_120.png",
			name = QualityNames[QualityType.eWhite],
			color = ccc3(255, 255, 255)
		},
		[QualityType.eRed] = {
			bkgRound = "ui/common/common_010.png",
			bkgNormal = "ui/common/common_004.png",
			image = "uilocal/common/common_text_001.png",
			bkgStore = "ui/store/store_031.png",
			bkgLevel = "ui/common/common_016.png",
			name = QualityNames[QualityType.eRed],
			color = ccc3(255, 0, 0),
			button = {
				"ui/team/team_017.png",
				"ui/team/team_017.png"
			}
		}
	}
	local var_19_1 = {
		"name",
		"color",
		"image",
		"button",
		"bkgNormal",
		"bkgRound",
		"bkgLevel",
		"bkgStore"
	}

	return var_19_0[arg_19_0][var_19_1[arg_19_1]]
end

function getQualityName(arg_20_0)
	return getQualityAttribute(arg_20_0, QualityAttr.eName)
end

function getQualityColor(arg_21_0, arg_21_1)
	if arg_21_0 < 1 then
		arg_21_0 = QualityType.eNone
	end

	local var_21_0 = getQualityAttribute(arg_21_0, QualityAttr.eColor)

	if arg_21_1 then
		var_21_0 = string.format("#%02X%02X%02X", var_21_0.r, var_21_0.g, var_21_0.b)
	end

	return var_21_0
end

function getQualityBgImageName(arg_22_0)
	return getQualityAttribute(arg_22_0, QualityAttr.eBkgNormal)
end

function getQualityRoundBgImageName(arg_23_0)
	return getQualityAttribute(arg_23_0, QualityAttr.eBkgRound)
end

function getQualityIconImageName(arg_24_0)
	return getQualityAttribute(arg_24_0, QualityAttr.eImage)
end

function getQualityButtonImage(arg_25_0)
	return getQualityAttribute(arg_25_0, QualityAttr.eButton)
end

function getItemLevelNumBgImage(arg_26_0)
	return getQualityAttribute(arg_26_0, QualityAttr.eBkgLevel)
end

function getQualityStoreImage(arg_27_0)
	return getQualityAttribute(arg_27_0, QualityAttr.eBkgStore)
end

function addQualityStar(arg_28_0)
	local var_28_0 = "ui/common/common_137.png"
	local var_28_1 = arg_28_0.quality + 1
	local var_28_2 = CCSprite:create(var_28_0):getTextureRect().size.width
	local var_28_3 = arg_28_0.space and arg_28_0.space or 10
	local var_28_4 = arg_28_0.scale and arg_28_0.scale or 1
	local var_28_5 = 0
	local var_28_6 = CCNode:create()

	for iter_28_0 = 1, var_28_1 do
		local var_28_7 = display.newSprite(var_28_0, var_28_5, 0)

		var_28_7:setAnchorPoint(CCPoint(0, 0))
		var_28_7:setScale(var_28_4)
		var_28_6:addChild(var_28_7)

		var_28_5 = var_28_5 + var_28_2 * var_28_4 + var_28_3
	end

	return var_28_6
end

ItemAttr = {
	eName = 1,
	eImage = 3,
	eQuality = 2,
	eBase = 0,
	eIcon = 4
}

function getItemAttribute(arg_29_0)
	local var_29_0 = {
		[ItemType.eSoul] = BaseSouls,
		[ItemType.eProp] = BaseProps,
		[ItemType.eMate] = BaseMates,
		[ItemType.eHero] = BaseHeros,
		[ItemType.eEquip] = BaseEquips,
		[ItemType.eFragment] = BaseFragments,
		[ItemType.eTianMing] = BaseTianMings,
		[ItemType.eMaster] = BaseMasters
	}
	local var_29_1 = arg_29_0.type
	local var_29_2 = arg_29_0.id
	local var_29_3 = arg_29_0.attr
	local var_29_4 = var_29_0[var_29_1]

	if var_29_3 == ItemAttr.eBase then
		if var_29_4 and var_29_4[var_29_2] then
			return setmetatable({}, {
				__metatable = false,
				__index = var_29_4[var_29_2],
				__newindex = function(arg_30_0, arg_30_1, arg_30_2)
					return
				end
			})
		end
	elseif var_29_3 == ItemAttr.eName then
		if var_29_4 then
			return var_29_2 > 0 and var_29_4[var_29_2].name or ""
		else
			local var_29_5 = {
				[ItemType.eCoin] = string.lf("银币"),
				[ItemType.eGold] = string.lf("元宝"),
				[ItemType.eEXP] = string.lf("经验值"),
				[ItemType.ePower] = string.lf("体力值"),
				[ItemType.eTrainPill] = string.lf("培养丹"),
				[ItemType.eTransportTimes] = string.lf("运骠次数"),
				[ItemType.eHonor] = string.lf("荣誉值"),
				[ItemType.eDoubleExpTime] = string.lf("双倍经验时间"),
				[ItemType.eKnowledge] = string.lf("阅历"),
				[ItemType.ePKScore] = string.lf("竞技场积分"),
				[ItemType.eEquipInheritPoint] = string.lf("重铸石"),
				[ItemType.eLuckyWord] = string.lf("幸运字"),
				[ItemType.eVIPLevel] = string.lf("VIP"),
				[ItemType.eSoulJade] = string.lf("魂玉"),
				[ItemType.ePrestige] = string.lf("威望"),
				[ItemType.eGuildCoin] = string.lf("晶石"),
				[ItemType.eHeroExp] = string.lf("主将经验"),
				[ItemType.eTianMingExp] = string.lf("天命经验"),
				[ItemType.eTianMingFrag] = string.lf("天命碎片"),
				[ItemType.eDuelScore] = string.lf("比赛积分")
			}

			return var_29_5[var_29_1] ~= nil and var_29_5[var_29_1] or ""
		end
	elseif var_29_3 == ItemAttr.eImage then
		if var_29_4 then
			if var_29_1 == ItemType.eMaster then
				return "master/" .. var_29_4[var_29_2].smallImage
			end

			if var_29_1 == ItemType.eSoul then
				var_29_2 = var_29_4[var_29_2].figureId
				var_29_4 = var_29_0[ItemType.eHero]
			end

			local var_29_6

			if var_29_1 == ItemType.eEquip or var_29_1 == ItemType.eFragment then
				var_29_6 = "equip/"

				if var_29_1 == ItemType.eFragment then
					local var_29_7 = var_29_4[var_29_2]

					if var_29_7.equipId > 0 then
						var_29_2 = var_29_7.equipId
						var_29_4 = var_29_0[ItemType.eEquip]
					end
				end
			else
				var_29_6 = (var_29_1 == ItemType.eProp or var_29_1 == ItemType.eMate) and "prop/" or var_29_1 == ItemType.eTianMing and "tianming/" or "header/"
			end

			return var_29_6 .. var_29_4[var_29_2].headerImage
		else
			return ({
				[ItemType.eCoin] = "prop/small_yinbia.png",
				[ItemType.eGold] = "prop/small_yuanbaoa.png",
				[ItemType.eEXP] = "prop/small_jingyantubiao.png",
				[ItemType.ePower] = "ui/common/common_058.png",
				[ItemType.eDoubleExpTime] = "ui/common/common_058.png",
				[ItemType.eKnowledge] = "prop/small_yuelizhi.png",
				[ItemType.eHonor] = "prop/small_rongyuzhi.png",
				[ItemType.eTrainPill] = "prop/small_peiyangdan.png",
				[ItemType.eEquipInheritPoint] = "prop/small_zhuzaoshi.png",
				[ItemType.eVIPLevel] = "prop/small_vip.png",
				[ItemType.eSoulJade] = "prop/small_hunyu.png",
				[ItemType.ePrestige] = "prop/small_weiwang.png",
				[ItemType.eGuildCoin] = "prop/small_jinshi.png",
				[ItemType.ePKScore] = "prop/small_jifen.png",
				[ItemType.eHeroExp] = "prop/small_jingyantubiao.png",
				[ItemType.eTianMingExp] = "tianming/small_tianming_064.png",
				[ItemType.eTianMingFrag] = "prop/small_tianming.png"
			})[var_29_1] or "prop/small_zhongjijianghunshi.png"
		end
	elseif var_29_3 == ItemAttr.eQuality then
		if var_29_4 then
			if var_29_1 == ItemType.eSoul then
				local var_29_8 = var_29_4[var_29_2]

				var_29_4 = var_29_0[ItemType.eHero]
				var_29_2 = var_29_8.figureId
			end

			return var_29_4[var_29_2].quality
		else
			return QualityType.eNone
		end
	elseif var_29_3 == ItemAttr.eIcon then
		if var_29_4 then
			if var_29_1 == ItemType.eProp or var_29_1 == ItemType.eMate then
				return "icon/" .. var_29_4[var_29_2].iconImage
			end
		else
			return ({
				[ItemType.eCoin] = "icon/icon_yinbia.png",
				[ItemType.eGold] = "icon/icon_yuanbaoa.png",
				[ItemType.eEXP] = "ui/common/common_124.png",
				[ItemType.ePower] = "ui/common/common_058.png",
				[ItemType.eDoubleExpTime] = "ui/common/common_058.png",
				[ItemType.eKnowledge] = "icon/icon_yuelizhi.png",
				[ItemType.eHonor] = "icon/icon_rongyuzhi.png",
				[ItemType.eTrainPill] = "icon/icon_peiyangdan.png",
				[ItemType.eEquipInheritPoint] = "icon/icon_zhuzaoshi.png",
				[ItemType.eSoulJade] = "icon/icon_hunyu.png",
				[ItemType.ePotency] = "ui/common/common_119.png",
				[ItemType.ePrestige] = "icon/icon_weiwang.png",
				[ItemType.eGuildCoin] = "icon/icon_xianmengbi.png",
				[ItemType.eHeroExp] = "icon/icon_jingyantubiao.png",
				[ItemType.eTianMingExp] = "icon/icon_tianming_064.png",
				[ItemType.eTianMingFrag] = "icon/icon_tianming.png",
				[ItemType.eLearnExp] = "icon/icon_shouyezhi.png"
			})[var_29_1]
		end
	end
end

function getItemBaseData(arg_31_0, arg_31_1)
	if arg_31_0 ~= nil and arg_31_0 == ItemType.eMineral then
		return BaseMineral[arg_31_1]
	end

	return getItemAttribute({
		type = arg_31_0,
		id = arg_31_1,
		attr = ItemAttr.eBase
	})
end

function getItemName(arg_32_0, arg_32_1)
	if arg_32_0 ~= nil and arg_32_0 == ItemType.eMineral then
		return BaseMineral[arg_32_1].name
	end

	return getItemAttribute({
		type = arg_32_0,
		id = arg_32_1,
		attr = ItemAttr.eName
	})
end

function getItemQuality(arg_33_0, arg_33_1)
	if arg_33_0 ~= nil and arg_33_0 == ItemType.eMineral then
		return 0
	end

	return getItemAttribute({
		type = arg_33_0,
		id = arg_33_1,
		attr = ItemAttr.eQuality
	})
end

function getItemHeaderImagePath(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_0 ~= nil and arg_34_0 == ItemType.eMineral then
		return figure.getMineralHeaderImage(arg_34_1, arg_34_2 or 1)
	end

	return getItemAttribute({
		type = arg_34_0,
		id = arg_34_1,
		attr = ItemAttr.eImage
	})
end

function getItemIconPath(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_0 ~= nil and arg_35_0 == ItemType.eMineral then
		return figure.getMineralIconImage(arg_35_1, arg_35_2 or 1)
	end

	return getItemAttribute({
		type = arg_35_0,
		id = arg_35_1,
		attr = ItemAttr.eIcon
	})
end

function showFlashNotice(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = require("scenes.FlashNotice").new(arg_36_0, arg_36_1, arg_36_2, arg_36_3)

	CCDirector:sharedDirector():getRunningScene():addChild(var_36_0, DefaultZOrder.eMax)
end

function showFlashText(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = ui.newTTFLabel({
		text = "",
		font = _FONT_DEFAULT,
		color = arg_37_2,
		size = Adapter.FontSize(22),
		align = ui.TEXT_ALIGN_CENTER,
		x = arg_37_3.x,
		y = arg_37_3.y
	})

	var_37_0:setAnchorPoint(CCPoint(0.5, 0))
	var_37_0:setString(arg_37_1)
	arg_37_0:addChild(var_37_0, DefaultZOrder.eMsgBox)
	Adapter.NodeAbsScale(var_37_0)

	local var_37_1 = CCArray:create()

	var_37_1:addObject(CCMoveBy:create(1.5, CCPoint(0, 30)))
	var_37_1:addObject(CCCallFunc:create(function()
		var_37_0:removeFromParentAndCleanup(true)
	end))
	var_37_0:runAction(CCSequence:create(var_37_1))
end

function showFlashImage(arg_39_0)
	if not arg_39_0.scale then
		arg_39_0.scale = 1
	end

	local var_39_0 = display.newSprite(arg_39_0.image)

	var_39_0:setAnchorPoint(CCPoint(0.5, 0))
	var_39_0:setPosition(arg_39_0.position)
	arg_39_0.parent:addChild(var_39_0, 128)

	if arg_39_0.addImage then
		local var_39_1 = display.newSprite(arg_39_0.addImage)

		var_39_1:setAnchorPoint(CCPoint(0.5, 0))
		var_39_1:setPosition(ccp(250, 0))
		var_39_0:addChild(var_39_1, 128)
		var_39_0:setPosition(arg_39_0.position.x - 50, arg_39_0.position.y)
	end

	local var_39_2 = CCArray:create()
	local var_39_3 = CCScaleTo:create(0.1, arg_39_0.scale + 0.5)
	local var_39_4 = CCScaleTo:create(0.1, arg_39_0.scale)

	var_39_2:addObject(var_39_3)
	var_39_2:addObject(var_39_4)
	var_39_2:addObject(CCMoveBy:create(0.5, CCPoint(0, 30)))
	var_39_2:addObject(CCCallFunc:create(function()
		var_39_0:removeFromParentAndCleanup(true)

		return arg_39_0.callback and arg_39_0.callback()
	end))
	var_39_0:runAction(CCSequence:create(var_39_2))
end

function getEquipAttrTypeList(arg_41_0)
	local var_41_0 = {}
	local var_41_1 = BaseEquips[arg_41_0].equipType

	if var_41_1 == EquipType.eWeapon then
		table.insert(var_41_0, BattleAttrsType.eNormalAttack)
		table.insert(var_41_0, BattleAttrsType.eSkillAttack)
	elseif var_41_1 == EquipType.eAmulet then
		table.insert(var_41_0, BattleAttrsType.eSkillAttack)
	elseif var_41_1 == EquipType.eHelmet then
		table.insert(var_41_0, BattleAttrsType.eSkillDefense)
	elseif var_41_1 == EquipType.eClothes then
		table.insert(var_41_0, BattleAttrsType.eNormalDefense)
	elseif var_41_1 == EquipType.eNecklace then
		table.insert(var_41_0, BattleAttrsType.eSpeed)
	elseif var_41_1 == EquipType.eRing then
		table.insert(var_41_0, BattleAttrsType.eHealth)
	end

	local var_41_2 = BaseEquips[arg_41_0].jieJiAttrs
	local var_41_3 = var_41_2 ~= nil and table.getn(var_41_2) > 0

	return var_41_0, var_41_3
end

function getHeroGroupWeaponId(arg_42_0)
	local var_42_0

	for iter_42_0, iter_42_1 in ipairs(BaseHeros[arg_42_0].groupEquips) do
		if BaseEquips[iter_42_1.equipId].equipType == EquipType.eWeapon then
			var_42_0 = iter_42_1.equipId

			break
		end
	end

	return var_42_0
end

function getEquipAttrValue(arg_43_0, arg_43_1)
	return arg_43_1[({
		[BattleAttrsType.eHealth] = "health",
		[BattleAttrsType.eNormalAttack] = "normalAttack",
		[BattleAttrsType.eNormalDefense] = "normalDefense",
		[BattleAttrsType.eSkillAttack] = "skillAttack",
		[BattleAttrsType.eSkillDefense] = "skillDefense",
		[BattleAttrsType.eMingZhong] = "mingzhong",
		[BattleAttrsType.eShanBi] = "shanbi",
		[BattleAttrsType.eBaoJi] = "baoji",
		[BattleAttrsType.eRenXing] = "renxing",
		[BattleAttrsType.ePoJi] = "poji",
		[BattleAttrsType.eGeDang] = "gedang",
		[BattleAttrsType.eSpeed] = "speed"
	})[arg_43_0]]
end

function getTianmingAttrList(arg_44_0)
	local var_44_0 = {
		[BattleAttrsType.eHealth] = "health",
		[BattleAttrsType.eNormalAttack] = "normalAttack",
		[BattleAttrsType.eNormalDefense] = "normalDefense",
		[BattleAttrsType.eSkillAttack] = "skillAttack",
		[BattleAttrsType.eSkillDefense] = "skillDefense",
		[BattleAttrsType.eMingZhong] = "mingzhong",
		[BattleAttrsType.eShanBi] = "shanbi",
		[BattleAttrsType.eBaoJi] = "baoji",
		[BattleAttrsType.eRenXing] = "renxing",
		[BattleAttrsType.ePoJi] = "poji",
		[BattleAttrsType.eGeDang] = "gedang",
		[BattleAttrsType.eSpeed] = "speed"
	}
	local var_44_1 = {}

	for iter_44_0, iter_44_1 in ipairs(var_44_0) do
		value = arg_44_0[iter_44_1]

		if value and value > 0 then
			table.insert(var_44_1, {
				name = BattleAttrsName[iter_44_0],
				type = iter_44_1
			})
		end
	end

	return var_44_1
end

function getHeroCurrentRebirthCountAttrs(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_1 > 14 and 14 or arg_45_1
	local var_45_1 = RebirthNames[var_45_0]
	local var_45_2 = arg_45_1 > 13 and 13 or arg_45_1

	return BaseHeros[arg_45_0].rebirthList[var_45_2], var_45_1
end

function getHeroRageSkillDesc(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	local var_46_0 = BaseSkills[arg_46_0].desc

	if string.find(var_46_0, "{") then
		return (string.gsub(var_46_0, "%{.-%}", function(arg_47_0)
			local var_47_0 = string.sub(arg_47_0, 2, string.len(arg_47_0) - 1)
			local var_47_1 = "math.showDecimal(" .. var_47_0 .. ", 2)"
			local var_47_2 = "function getHeroRageSkillFinalValue(sl, sa) return tostring(" .. var_47_1 .. ") end"

			loadstring(var_47_2)()

			return "#C72700" .. getHeroRageSkillFinalValue(arg_46_1, arg_46_2) .. (arg_46_3 or "#000000")
		end))
	else
		return var_46_0
	end
end

function getTalentSkillDesc(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = BaseSkills[arg_48_0].desc

	return (string.gsub(var_48_0[arg_48_1], "%{.-%}", function(arg_49_0)
		local var_49_0 = string.sub(arg_49_0, 2, string.len(arg_49_0) - 1)

		return "#C72700" .. var_49_0 .. (arg_48_2 or "#000000")
	end))
end

function getHeroTalentSkillDesc(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = ""
	local var_50_1 = ""
	local var_50_2 = BaseHeros[arg_50_0]
	local var_50_3 = BaseSkills[var_50_2.talentId].desc
	local var_50_4 = getHeroCurrentRebirthCountAttrs(arg_50_0, arg_50_1)
	local var_50_5 = var_50_4 and var_50_4.talentDescIndex or 0

	if var_50_5 == 0 then
		local var_50_6 = 1

		for iter_50_0, iter_50_1 in ipairs(var_50_2.rebirthList) do
			if iter_50_1.talentDescIndex >= 1 then
				var_50_6 = iter_50_0

				break
			end
		end

		var_50_0 = string.lf("未激活(+%d后激活)", var_50_6)
	elseif var_50_5 >= table.nums(var_50_3) then
		var_50_0 = string.lf("已满级")
	else
		var_50_0 = string.lf("%d级", var_50_5)
	end

	var_50_5 = var_50_5 > 0 and var_50_5 or 1

	local var_50_7 = getTalentSkillDesc(var_50_2.talentId, var_50_5, arg_50_2)

	return var_50_0, var_50_7
end

function getHeroMadSkillDesc(arg_51_0, arg_51_1)
	local var_51_0 = {
		string.lf("战斗开场时体型增加10%%并增加少量全属性"),
		string.lf("战斗开场时体型增加20%%并增加中量全属性"),
		string.lf("战斗开场时体型增加30%%并增加大量全属性")
	}
	local var_51_1 = string.lf("初阶狂化")
	local var_51_2 = "skillicon/skill_10061.png"

	if arg_51_1 >= QualityType.eOrange then
		var_51_1 = string.lf("高阶狂化")
		var_51_2 = "skillicon/skill_10049.png"
	elseif arg_51_1 == QualityType.ePurple then
		var_51_1 = string.lf("中阶狂化")
		var_51_2 = "skillicon/skill_10060.png"
	end

	if arg_51_0 and arg_51_0 > 0 then
		return var_51_0[arg_51_0], var_51_2, var_51_1
	end
end

function createTableView(arg_52_0)
	local var_52_0 = arg_52_0.size
	local var_52_1 = arg_52_0.filter
	local var_52_2 = arg_52_0.reverse
	local var_52_3 = arg_52_0.dataset
	local var_52_4 = arg_52_0.direction or kCCScrollViewDirectionHorizontal
	local var_52_5 = arg_52_0.touchhandler
	local var_52_6 = arg_52_0.sizehandler
	local var_52_7 = arg_52_0.numberhandler
	local var_52_8 = arg_52_0.cellhandler

	if var_52_2 ~= false then
		var_52_2 = true
	end

	local var_52_9 = display.ANCHOR_POINTS[display.LEFT_BOTTOM]
	local var_52_10 = CCTableView:create(var_52_0)

	var_52_10:setIgnoreAnchorPointForPosition(false)
	var_52_10:setAnchorPoint(var_52_9)
	var_52_10:setPosition(0, 0)
	var_52_10:setViewSize(var_52_0)
	var_52_10:setDirection(var_52_4)

	if var_52_5 then
		local function var_52_11(arg_53_0, arg_53_1)
			var_52_5(arg_53_0, arg_53_1)
		end

		var_52_10:registerScriptHandler(var_52_11, CCTableView.kTableCellTouched)
	end

	local function var_52_12(arg_54_0, arg_54_1)
		if var_52_6 then
			local var_54_0 = var_52_6(arg_54_0, arg_54_1)

			return var_54_0.height, var_54_0.width
		else
			return 0, 0
		end
	end

	var_52_10:registerScriptHandler(var_52_12, CCTableView.kTableCellSizeForIndex)

	local function var_52_13(arg_55_0)
		local var_55_0
		local var_55_1

		if var_52_7 then
			var_55_0 = var_52_7(arg_55_0, var_52_3)
		else
			local var_55_2 = var_52_1 and var_52_1(var_52_3) or var_52_3

			var_55_0 = var_55_2 and #var_55_2 or 0
		end

		return var_55_0
	end

	var_52_10:registerScriptHandler(var_52_13, CCTableView.kNumberOfCellsInTableView)

	local function var_52_14(arg_56_0, arg_56_1)
		local var_56_0 = arg_56_0:cellAtIndex(arg_56_1)

		if var_56_0 == nil then
			var_56_0 = CCTableViewCell:new()

			if var_52_8 then
				local var_56_1 = var_52_13(arg_56_0)
				local var_56_2 = 0
				local var_56_3 = 0
				local var_56_4
				local var_56_5
				local var_56_6

				if var_52_3 then
					local var_56_7 = var_52_1 and var_52_1(var_52_3) or var_52_3

					var_56_5 = var_56_7[var_52_2 and #var_56_7 - arg_56_1 or arg_56_1 + 1]
				end

				local var_56_8 = var_52_8(var_56_1, arg_56_1 + 1, var_56_5)

				var_56_0:addChild(var_56_8)
			end
		end

		return var_56_0
	end

	var_52_10:registerScriptHandler(var_52_14, CCTableView.kTableCellSizeAtIndex)
	var_52_10:reloadData()

	function var_52_10.reloadData(arg_57_0, arg_57_1, arg_57_2)
		if arg_57_1 then
			var_52_3 = arg_57_1
		end

		arg_57_2 = arg_57_2 and arg_57_0:getContentOffset()

		CCTableView.reloadData(arg_57_0)

		if arg_57_2 then
			arg_57_0:setContentOffset(arg_57_2)
		end
	end

	return var_52_10
end

function createMarkLabel(arg_58_0)
	local var_58_0 = arg_58_0.x or 30
	local var_58_1 = arg_58_0.y or 54
	local var_58_2 = arg_58_0.rotate or -50
	local var_58_3 = arg_58_0.background or "ui/common/common_076.png"
	local var_58_4
	local var_58_5 = display.newSprite(var_58_3)
	local var_58_6 = var_58_5:getContentSize()

	if arg_58_0.image then
		var_58_4 = display.newSprite(arg_58_0.image)
	else
		if not arg_58_0.size then
			arg_58_0.size = 18
		end

		if not arg_58_0.font then
			arg_58_0.font = _FONT_DEFAULT
		end

		if not arg_58_0.color then
			arg_58_0.color = ccc3(250, 230, 60)
		end

		arg_58_0.size = Adapter.FontSize(arg_58_0.size)
		var_58_4 = ui.newTTFLabel(arg_58_0)
	end

	var_58_4:setRotation(var_58_2)
	var_58_4:setPosition(var_58_0, var_58_1)
	var_58_5:addChild(var_58_4)

	var_58_5.title = var_58_4

	function var_58_5.setString(arg_59_0, arg_59_1)
		arg_59_0.title:setString(arg_59_1)
	end

	return var_58_5
end

function ui.newControlButton(arg_60_0)
	if not arg_60_0.normalImage then
		arg_60_0.normalImage = "icon/icon_yuanbaoa.png"

		return nil
	end

	local var_60_0

	if arg_60_0.text then
		local var_60_1 = arg_60_0.fontName or _FONT_PANGWA
		local var_60_2 = arg_60_0.fontSize or ColorTable.eTitleButton_FontSize
		local var_60_3 = arg_60_0.textColor or ColorTable.eTitleButton_Normal

		var_60_0 = CCControlButton:create(arg_60_0.text, var_60_1, Adapter.FontSize(var_60_2))

		var_60_0:setTitleColorForState(var_60_3, CCControlStateNormal)
		var_60_0:setTitleColorForState(var_60_3, CCControlStateHighlighted)
		var_60_0:setTitleColorForState(var_60_3, CCControlStateDisabled)

		if arg_60_0.isShadow == true then
			tolua.cast(var_60_0:getTitleLabel(), "CCLabelTTF"):enableShadow(CCSize(1.5, 1.5), 1, 1)
		end
	else
		var_60_0 = CCControlButton:create()
	end

	local var_60_4 = display.newScale9Sprite(arg_60_0.normalImage)

	var_60_0:setBackgroundSpriteForState(var_60_4, CCControlStateNormal)

	local var_60_5 = arg_60_0.size or var_60_4:getOriginalSize()
	local var_60_6 = CCSize(var_60_5.width * (arg_60_0.scaleX or 1), var_60_5.height * (arg_60_0.scaleY or 1))

	var_60_0:setPreferredSize(var_60_6)
	var_60_0:setPosition(arg_60_0.position or ccp(0, 0))

	local var_60_7 = arg_60_0.highlightedImage or arg_60_0.normalImage

	var_60_0:setBackgroundSpriteForState(CCScale9Sprite:create(var_60_7), CCControlStateHighlighted)

	if arg_60_0.disabledImage then
		var_60_0:setBackgroundSpriteForState(CCScale9Sprite:create(arg_60_0.disabledImage), CCControlStateDisabled)
	end

	if arg_60_0.anchorPoint then
		var_60_0:setAnchorPoint(arg_60_0.anchorPoint)
	end

	if arg_60_0.clickAction then
		var_60_0:addHandleOfControlEvent(function(arg_61_0, arg_61_1)
			arg_60_0.clickAudio = arg_60_0.clickAudio or ButtonAudio.normal

			if string.len(arg_60_0.clickAudio) > 0 then
				playEffect(arg_60_0.clickAudio)
			end

			arg_60_0.clickAction(arg_61_0, arg_61_1)
		end, CCControlEventTouchUpInside)
	end

	if arg_60_0.titleImage then
		local var_60_8 = display.newSprite(arg_60_0.titleImage)

		var_60_8:setScaleX(arg_60_0.scaleX or 1)
		var_60_8:setScaleY(arg_60_0.scaleY or 1)
		var_60_8:setAnchorPoint(ccp(0.5, 0.5))
		var_60_8:setPosition(ccp(var_60_6.width / 2, var_60_6.height / 2))
		var_60_0:addChild(var_60_8, 1)
	end

	var_60_0:setScaleAsSprite(arg_60_0.scaleAsSprite or true)

	function var_60_0.setLabelColorForAllStates(arg_62_0, arg_62_1)
		arg_62_0:setTitleColorForState(arg_62_1, CCControlStateNormal)
		arg_62_0:setTitleColorForState(arg_62_1, CCControlStateHighlighted)
		arg_62_0:setTitleColorForState(arg_62_1, CCControlStateDisabled)
	end

	var_60_0.setZoomOnTouchDown = var_60_0.setZoomOnTouchDown or function(arg_63_0)
		return
	end
	var_60_0.setLabelAnchorPoint = var_60_0.setLabelAnchorPoint or function(arg_64_0)
		return
	end

	return var_60_0
end

function ui.newEditBox(arg_65_0)
	local var_65_0 = arg_65_0.image
	local var_65_1 = arg_65_0.multiLines
	local var_65_2 = arg_65_0.imagePressed
	local var_65_3 = arg_65_0.imageDisabled
	local var_65_4 = arg_65_0.labelAlignment or kCCTextAlignmentLeft

	if type(var_65_0) == "string" then
		var_65_0 = display.newScale9Sprite(var_65_0)
	end

	if type(var_65_2) == "string" then
		var_65_2 = display.newScale9Sprite(var_65_2)
	end

	if type(var_65_3) == "string" then
		var_65_3 = display.newScale9Sprite(var_65_3)
	end

	local var_65_5 = CCEditBox:create(arg_65_0.size, var_65_1, var_65_0, var_65_2, var_65_3, var_65_4)

	if var_65_5 then
		CCNodeExtend.extend(var_65_5)

		arg_65_0.listener = arg_65_0.listener or function(arg_66_0, arg_66_1)
			return
		end

		var_65_5:addEditBoxEventListener(arg_65_0.listener)

		if arg_65_0.x and arg_65_0.y then
			var_65_5:setPosition(arg_65_0.x, arg_65_0.y)
		end

		if arg_65_0.fontSize then
			var_65_5:setFont(_FONT_DEFAULT, arg_65_0.fontSize)
		end

		if arg_65_0.fontColor then
			var_65_5:setFontColor(arg_65_0.fontColor)
		end
	end

	return var_65_5
end

function addLabelWithColorSize(arg_67_0, arg_67_1, arg_67_2, arg_67_3, arg_67_4, arg_67_5, arg_67_6)
	local var_67_0 = {
		text = "",
		font = arg_67_6 or _FONT_DEFAULT,
		size = Adapter.FontSize(arg_67_3),
		align = ui.TEXT_ALIGN_LEFT,
		color = arg_67_2,
		x = arg_67_5.x,
		y = arg_67_5.y
	}
	local var_67_1 = ui.newTTFLabel(var_67_0)

	var_67_1:setAnchorPoint(arg_67_4)
	var_67_1:setString(arg_67_1)
	arg_67_0:addChild(var_67_1)
	Adapter.NodeAbsScale(var_67_1)

	return var_67_1
end

function createNumberWidthBgSprite(arg_68_0, arg_68_1, arg_68_2, arg_68_3)
	arg_68_3 = arg_68_3 or 0

	local var_68_0 = CCNodeExtend.extend(CCNode:create())

	var_68_0.numSprite = CCSprite:create(arg_68_0)

	var_68_0:addChild(var_68_0.numSprite)

	local var_68_1 = CCTextureCache:sharedTextureCache():addImage(arg_68_0):getContentSize()

	arg_68_2 = arg_68_2 or var_68_1.height * 1 / 2
	var_68_0.numLabel = ui.newTTFLabel({
		y = 0,
		text = tostring(arg_68_1),
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(arg_68_2),
		align = ui.TEXT_ALIGN_CENTER,
		color = display.COLOR_WHITE,
		x = arg_68_3
	})

	var_68_0:addChild(var_68_0.numLabel)

	return var_68_0
end

function createHeroProgressBar(arg_69_0)
	local var_69_0 = CCNode:create()

	var_69_0.progressBar = require("scenes.ProgressBar").new({
		backImage = "ui/common/common_032.png",
		backSize = CCSize(330, 29),
		barSize = CCSize(288, 10),
		barImages = {
			"ui/common/common_031.png"
		},
		barPosition = ccp(-144, 0),
		curValue = arg_69_0.curExp,
		totalValue = arg_69_0.totalExp
	})

	var_69_0.progressBar:setPosition(ccp(163, -3))
	var_69_0:addChild(var_69_0.progressBar)

	if arg_69_0.clickAction then
		local var_69_1 = ui.newControlButton({
			normalImage = "uilocal/team/team_text_026.png",
			position = ccp(330, -3),
			clickAction = arg_69_0.clickAction
		})

		var_69_0:addChild(var_69_1)
	end

	var_69_0.levelNode = createNumberWidthBgSprite("ui/common/common_041.png", arg_69_0.level)

	var_69_0.levelNode.numSprite:setRotation(180)
	var_69_0:addChild(var_69_0.levelNode)

	return var_69_0
end

function ui.showMessageBox(arg_70_0)
	Platform.removeWebView()

	local function var_70_0()
		local var_71_0 = require("scenes.MessageBoxLayer").new(arg_70_0)

		var_71_0:setContentAndButtons(arg_70_0.text, arg_70_0.title1 or string.lf("确定"), arg_70_0.action1, arg_70_0.title2, arg_70_0.action2)

		return var_71_0
	end

	game.addNodeToRunningSceneWithAutoCreate({
		justOnce = true,
		ctorFunc = var_70_0,
		scene = arg_70_0.parent,
		zOrder = arg_70_0.zOrder or DefaultZOrder.eMsgBox
	})
end

function addObserverToNode(arg_72_0, arg_72_1, arg_72_2)
	if type(arg_72_2) == "string" then
		arg_72_2 = {
			arg_72_2
		}
	end

	arg_72_0:setNodeEventEnabled(true)

	arg_72_0.nofityTable = arg_72_0.nofityTable or {}

	local var_72_0 = {}

	for iter_72_0, iter_72_1 in ipairs(arg_72_2) do
		local var_72_1 = false

		for iter_72_2, iter_72_3 in ipairs(arg_72_0.nofityTable) do
			if iter_72_3 == iter_72_1 then
				var_72_1 = true

				break
			end
		end

		if var_72_1 == false then
			table.insert(var_72_0, iter_72_1)
		end
	end

	function arg_72_0.onEnter(arg_73_0)
		for iter_73_0, iter_73_1 in ipairs(var_72_0) do
			Notification:registerObserver(arg_73_0, arg_72_1, iter_73_1)
			table.insert(arg_73_0.nofityTable, iter_73_1)
		end

		if arg_73_0.onOrignEnter then
			arg_73_0.onOrignEnter(arg_73_0)
		end
	end

	function arg_72_0.onExit(arg_74_0)
		for iter_74_0, iter_74_1 in ipairs(arg_74_0.nofityTable) do
			Notification:unregisterObserver(arg_74_0, iter_74_1)
		end

		if arg_74_0.onOrignExit then
			arg_74_0.onOrignExit(arg_74_0)
		end
	end
end

function isMoneyEnough(arg_75_0, arg_75_1, arg_75_2)
	local var_75_0 = true

	if arg_75_0 == MoneyType.eCoin and arg_75_1 > Player.curCoin then
		var_75_0 = false

		ui.showMessageBox({
			text = string.lf("上仙，你的银币不足哦，战役或者招财神符都可以获得银币。"),
			title1 = string.lf("取消"),
			title2 = string.lf("前往"),
			action2 = function()
				game.enterZhaoCaiFuScene()
			end
		})
	elseif arg_75_0 == MoneyType.eGold and arg_75_1 > Player.curGold then
		var_75_0 = false

		ui.showMessageBox({
			text = string.lf("元宝不足，请考虑下商城充值吧！"),
			title1 = string.lf("取消"),
			title2 = string.lf("充值"),
			action2 = function()
				game.enterStoreRechargeScene({
					from = arg_75_2
				})
			end
		})
	end

	return var_75_0
end

function isConsumePropEnough(arg_78_0, arg_78_1)
	local var_78_0 = true

	if arg_78_0 == ItemType.ePower and arg_78_1 > Player.curPower then
		var_78_0 = false

		local var_78_1 = require("scenes.ToolLayer")

		var_78_1.createDialog({
			show = var_78_1.eShowPowerEmpty,
			callback = function(arg_79_0, arg_79_1)
				if arg_79_0 then
					print("成功使用体力丹")
				end
			end
		}):show()
	elseif arg_78_0 == ItemType.eHonor and arg_78_1 > Player.honor then
		var_78_0 = false

		ui.showMessageBox({
			text = string.lf("上仙，您的荣誉值不足，去竞技场挑战吧！"),
			title1 = string.lf("取消"),
			title2 = string.lf("挑战"),
			action2 = function()
				game.enterPkScene()
			end
		})
	elseif arg_78_0 == ItemType.eKnowledge and arg_78_1 > Player.knowledge then
		var_78_0 = false

		ui.showMessageBox({
			text = string.lf("上仙，您的阅历不足，去小黑屋抓捕奴隶吧！"),
			title1 = string.lf("取消"),
			title2 = string.lf("抓捕"),
			action2 = function()
				game.enterSlaveScene()
			end
		})
	end

	return var_78_0
end

function isEquipCountNotMax(arg_82_0)
	local var_82_0 = EquipHelper:getAllEquipCount() >= GameMaxNum.eEquip

	if var_82_0 == true or arg_82_0 == true then
		ui.showMessageBox({
			text = string.lf("上仙，您所拥有的装备数量已达上限，在进行炼化前，无法继续获得更多装备。T.T"),
			title1 = string.lf("取消"),
			title2 = string.lf("去炼化"),
			action2 = function()
				game.enterRefineScene({
					refineTag = ItemType.eEquip
				})
			end
		})
	end

	return not var_82_0
end

function createItemCountNode(arg_84_0)
	local var_84_0 = arg_84_0.carry or 999999
	local var_84_1 = arg_84_0.color or display.COLOR_WHITE

	arg_84_0.scale = arg_84_0.scale or 1

	local var_84_2 = CCNode:create()
	local var_84_3 = arg_84_0.value or 0
	local var_84_4 = arg_84_0.maxValue
	local var_84_5 = arg_84_0.valueOffset or 20 * arg_84_0.scale

	local function var_84_6(arg_85_0, arg_85_1)
		if arg_85_0 == ItemType.eCoin or arg_85_0 == ItemType.eGold then
			arg_85_1 = math.floor(arg_85_1)

			if arg_85_1 > var_84_0 then
				arg_85_1 = math.floor(arg_85_1 / 10000)

				return string.lf("%s万", arg_85_1)
			end
		end

		return tostring(arg_85_1)
	end

	var_84_2.itemSprite = display.newSprite(getItemIconPath(arg_84_0.type, nil))

	var_84_2.itemSprite:setScale(arg_84_0.scale)
	var_84_2:addChild(var_84_2.itemSprite)

	local var_84_7 = tostring(var_84_6(arg_84_0.type, var_84_3))
	local var_84_8 = {
		text = var_84_7,
		align = ui.TEXT_ALIGN_LEFT,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(20),
		color = var_84_1
	}

	if arg_84_0.isOutline then
		var_84_2.originalLabel = ui.newTTFLabelWithOutline(var_84_8)
	else
		var_84_2.originalLabel = ui.newTTFLabel(var_84_8)
	end

	var_84_2.originalLabel:setAnchorPoint(ccp(0, 0.5))
	var_84_2.originalLabel:setPosition(ccp(var_84_5, 0))
	var_84_2:addChild(var_84_2.originalLabel)

	local var_84_9 = arg_84_0.discount

	if var_84_9 and var_84_9 < 1 and var_84_9 > 0.4 then
		local var_84_10 = display.newSprite("ui/common/icon_del.png")
		local var_84_11 = var_84_2.originalLabel:getContentSize()

		var_84_10:setPosition(var_84_11.width / 2 + var_84_5, 0)
		var_84_2:addChild(var_84_10)

		local var_84_12 = math.floor(var_84_3 * var_84_9)
		local var_84_13 = {
			text = var_84_6(arg_84_0.type, var_84_12),
			align = ui.TEXT_ALIGN_LEFT,
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(20),
			color = var_84_1
		}

		if arg_84_0.isOutline then
			var_84_2.labelDiscount = ui.newTTFLabelWithOutline(var_84_13)
		else
			var_84_2.labelDiscount = ui.newTTFLabel(var_84_13)
		end

		var_84_2.labelDiscount:setAnchorPoint(ccp(0, 0.5))
		var_84_2.labelDiscount:setPosition(ccp(var_84_11.width + var_84_5 * 2, 0))
		var_84_2:addChild(var_84_2.labelDiscount)
	end

	function var_84_2.getValue(arg_86_0)
		return var_84_3, arg_84_0.type
	end

	function var_84_2.setValue(arg_87_0, arg_87_1, arg_87_2)
		local var_87_0 = var_84_6(arg_84_0.type, arg_87_1)

		if arg_87_2 or var_84_4 then
			var_84_4 = arg_87_2 or var_84_4
			var_87_0 = var_87_0 .. "/" .. tostring(var_84_4)
		end

		var_84_2.originalLabel:setString(var_87_0)

		if var_84_2.labelDiscount then
			local var_87_1 = arg_87_1 * var_84_9

			var_84_2.labelDiscount:setString(var_84_6(arg_84_0.type, var_87_1))
		end

		var_84_3 = arg_87_1
	end

	function var_84_2.setTimeValue(arg_88_0, arg_88_1, arg_88_2)
		local var_88_0 = formatTime(arg_88_2, {
			hour = true,
			min = true,
			sec = true
		})

		var_84_2.originalLabel:setString(arg_88_1 .. var_88_0)

		var_84_3 = arg_88_2
	end

	function var_84_2.setColor(arg_89_0, arg_89_1)
		var_84_2.originalLabel:setColor(arg_89_1)

		if var_84_2.labelDiscount then
			var_84_2.labelDiscount:setColor(arg_89_1)
		end
	end

	if arg_84_0.type == ItemType.eDoubleExpTime then
		var_84_2:setTimeValue(string.lf("双倍经验值: "), var_84_3)
	else
		var_84_2:setValue(var_84_3, var_84_4)
	end

	return var_84_2
end

function createPlayerAttrNode(arg_90_0, arg_90_1, arg_90_2, arg_90_3)
	local var_90_0 = 0
	local var_90_1 = 0
	local var_90_2 = arg_90_1 or 1
	local var_90_3 = CCNodeExtend.extend(CCNode:create())
	local var_90_4 = {
		[ItemType.eCoin] = "curCoin",
		[ItemType.eGold] = "curGold",
		[ItemType.eKnowledge] = "knowledge",
		[ItemType.eHonor] = "honor",
		[ItemType.ePrestige] = "prestige",
		[ItemType.ePower] = "curPower",
		[ItemType.eSoulJade] = "soulJade",
		[ItemType.eDoubleExpTime] = "doubleExpTime",
		[ItemType.eEquipInheritPoint] = "equipInheritPoint",
		[ItemType.eHeroExp] = "heroExpPool",
		[ItemType.eTianMingExp] = "tianMingExp",
		[ItemType.eTianMingFrag] = "tianMingFrag",
		[ItemType.eLearnExp] = "learnExp"
	}
	local var_90_5 = {
		[ItemType.eCoin] = PalyerEvents.eCoin,
		[ItemType.eGold] = PalyerEvents.eGold,
		[ItemType.eKnowledge] = PalyerEvents.eKnowLedge,
		[ItemType.eHonor] = PalyerEvents.eHonor,
		[ItemType.ePrestige] = PalyerEvents.ePrestige,
		[ItemType.ePower] = PalyerEvents.eCurPower,
		[ItemType.eSoulJade] = PalyerEvents.eSoulJade,
		[ItemType.eDoubleExpTime] = PalyerEvents.eDoubleExp,
		[ItemType.eEquipInheritPoint] = PalyerEvents.eEquipInheritPoint,
		[ItemType.eHeroExp] = PalyerEvents.eHeroExpPool,
		[ItemType.eTianMingExp] = PalyerEvents.eTianMingExp,
		[ItemType.eTianMingFrag] = PalyerEvents.eTianMingFrag,
		[ItemType.eLearnExp] = PalyerEvents.eLearnExp
	}

	local function var_90_6(arg_91_0)
		return Player[var_90_4[arg_91_0]] or 0
	end

	local var_90_7 = "ui/common/common_063.png"
	local var_90_8 = CCTextureCache:sharedTextureCache():addImage(var_90_7):getContentSize()
	local var_90_9 = var_90_2 * var_90_8.width

	if arg_90_2 == true then
		var_90_9 = 0
		var_90_1 = -(var_90_2 * var_90_8.height)
	end

	local var_90_10 = {}

	var_90_3.nodeTable = {}

	for iter_90_0, iter_90_1 in ipairs(arg_90_0) do
		local var_90_11 = var_90_7

		if iter_90_1 == ItemType.eGold then
			var_90_11 = "ui/common/common_062.png"
		end

		local var_90_12 = display.newSprite(var_90_11, 0, 0)

		var_90_12:setVisible(false)
		var_90_3:addChild(var_90_12)

		local var_90_13 = {
			valueOffset = 25,
			type = iter_90_1,
			value = var_90_6(iter_90_1),
			color = ccc3(239, 203, 139)
		}

		if iter_90_1 == ItemType.ePower then
			var_90_13.maxValue = Player.maxPower
		end

		local var_90_14 = createItemCountNode(var_90_13)

		var_90_14:setVisible(false)
		var_90_3:addChild(var_90_14)

		var_90_14.bgSprite = var_90_12
		var_90_3.nodeTable[iter_90_1] = var_90_14

		if var_90_5[iter_90_1] then
			table.insert(var_90_10, var_90_5[iter_90_1])
		end
	end

	local var_90_15 = arg_90_3 or {}

	function var_90_3.resetAttrsPosAndVisible(arg_92_0)
		local var_92_0 = clone(arg_90_0)
		local var_92_1 = {}

		for iter_92_0, iter_92_1 in ipairs(var_90_15) do
			for iter_92_2, iter_92_3 in ipairs(var_92_0) do
				if iter_92_1 == iter_92_3 and var_90_6(iter_92_1) == 0 then
					table.remove(var_92_0, iter_92_2)
					table.insert(var_92_1, iter_92_3)

					break
				end
			end
		end

		for iter_92_4, iter_92_5 in ipairs(var_92_0) do
			if arg_92_0.nodeTable[iter_92_5]:isVisible() == false or table.getn(var_92_1) > 0 then
				arg_92_0.nodeTable[iter_92_5]:setVisible(true)
				arg_92_0.nodeTable[iter_92_5].bgSprite:setVisible(true)
				arg_92_0.nodeTable[iter_92_5]:setPosition(ccp(var_90_9 * (iter_92_4 - 1) + 22, var_90_1 * (iter_92_4 - 1) + var_90_8.height / 2))
				arg_92_0.nodeTable[iter_92_5].bgSprite:setPosition(ccp(var_90_8.width / 2 + var_90_9 * (iter_92_4 - 1), var_90_1 * (iter_92_4 - 1) + var_90_8.height / 2))
			end
		end

		for iter_92_6, iter_92_7 in ipairs(var_92_1) do
			if arg_92_0.nodeTable[iter_92_7]:isVisible() == true then
				arg_92_0.nodeTable[iter_92_7]:setVisible(false)
				arg_92_0.nodeTable[iter_92_7].bgSprite:setVisible(false)
			end
		end
	end

	local function var_90_16(arg_93_0)
		for iter_93_0, iter_93_1 in ipairs(arg_90_0) do
			local var_93_0 = var_90_6(iter_93_1)
			local var_93_1 = arg_93_0.nodeTable[iter_93_1]:getValue()

			if var_93_1 ~= var_93_0 then
				if var_93_1 < var_93_0 then
					arg_93_0.nodeTable[iter_93_1]:runAction(CCBlink:create(0.5, 3))
				end

				if iter_93_1 == ItemType.ePower then
					arg_93_0.nodeTable[iter_93_1]:setValue(var_93_0, Player.maxPower)
				elseif iter_93_1 == ItemType.eDoubleExpTime then
					arg_93_0.nodeTable[iter_93_1]:setTimeValue(string.lf("双倍经验值: "), var_93_0)
					arg_93_0:resetAttrsPosAndVisible()
				else
					arg_93_0.nodeTable[iter_93_1]:setValue(var_93_0)
				end
			end
		end
	end

	addObserverToNode(var_90_3, var_90_16, var_90_10)
	var_90_3:resetAttrsPosAndVisible()

	return var_90_3
end

function playGameBackgroundMusic(arg_94_0, arg_94_1)
	if LocalData:getSetting().musicEnabled then
		if isGameBackgroundMusicPlaying() then
			stopGameBackgroundMusic()
		end

		SimpleAudioEngine:sharedEngine():playBackgroundMusic(arg_94_0, arg_94_1 or true)
	end
end

function isGameBackgroundMusicPlaying()
	return SimpleAudioEngine:sharedEngine():isBackgroundMusicPlaying()
end

function stopGameBackgroundMusic()
	SimpleAudioEngine:sharedEngine():stopBackgroundMusic(true)
end

function playEffect(arg_97_0, arg_97_1)
	if LocalData:getSetting().effectEnabled then
		local var_97_0 = arg_97_0

		if device.platform == "ios" or device.platform == "mac" then
			var_97_0 = string.format("media/%s.caf", arg_97_0)
		elseif device.platform == "android" then
			var_97_0 = string.format("media/%s.ogg", arg_97_0)
		end

		SimpleAudioEngine:sharedEngine():playEffect(var_97_0, arg_97_1 or false)
	end
end

function getFullLogContent(arg_98_0, arg_98_1)
	local var_98_0 = json.decode(arg_98_0)
	local var_98_1 = ""

	if var_98_0 == nil then
		return var_98_1
	end

	local function var_98_2(arg_99_0)
		return "#00FF00" .. getItemName(arg_99_0[1].Type, arg_99_0[1].ID) .. "x" .. arg_99_0[1].Count .. "#FFFFFF"
	end

	local function var_98_3(arg_100_0, arg_100_1)
		return "#00FF00" .. getZSQTypeName(arg_100_0) .. "-" .. getZSQRankName(arg_100_1) .. "#FFFFFF"
	end

	local function var_98_4(arg_101_0)
		if arg_101_0 == nil or #arg_101_0 == 0 then
			return ""
		else
			return string.lf("上的#00FF00%s#FFFFFF", arg_101_0)
		end
	end

	if arg_98_1 == 8 then
		var_98_1 = string.lf("#00FF00%s#FFFFFF经过潜心修炼，于九天争霸上连败8名高手，成为三界后起之秀!", var_98_0.PName)
	elseif arg_98_1 == 10 then
		var_98_1 = string.lf("#00FF00%s#FFFFFF经过潜心修炼，于九天争霸上连败10名高手，功力炉火纯青之境！", var_98_0.PName)
	elseif arg_98_1 == 15 then
		var_98_1 = string.lf("#00FF00%s#FFFFFF经过潜心修炼，于九天争霸上连败15名高手，功夫出神入化之境！", var_98_0.PName)
	elseif arg_98_1 == 20 then
		var_98_1 = string.lf("#00FF00%s#FFFFFF，这个神一般的名字在天际发出灿烂炫目的金色光芒，他刚刚上一鼓作气，连败20个竞技场中的高手，功力道行均已至登峰造极之化境，膜拜吧！", var_98_0.PName)
	elseif arg_98_1 == 30 then
		var_98_1 = string.lf("#00FF00%s#FFFFFF，这个神一般的名字在天际发出灿烂炫目的金色光芒，他刚刚上一鼓作气，连败30个竞技场中的高手，功力道行均已至登峰造极之化境，膜拜吧！", var_98_0.PName)
	elseif arg_98_1 == 101 then
		var_98_1 = string.lf("#00FF00%s#FFFFFF劫走您银币*#00FF00%d#FFFFFF。", var_98_0.PN, var_98_0.GD)
	elseif arg_98_1 == 102 then
		var_98_1 = string.lf("#00FF00%s#FFFFFF想劫您的镖车，被您疼揍一顿，灰溜溜的逃走了。", var_98_0.PN)
	elseif arg_98_1 == 103 then
		var_98_1 = string.lf("您成功将#00FF00%s#FFFFFF运到了#00FF00%s#FFFFFF获得银币*#00FF00%d#FFFFFF，还额外获得了#00FF00%s#FFFFFF。", var_98_0.HORSE, var_98_0.ADDR, var_98_0.GD, var_98_0.EXT)
	elseif arg_98_1 == 104 then
		var_98_1 = string.lf("您成功将#00FF00%s#FFFFFF运到了#00FF00%s#FFFFFF获得银币*#00FF00%d#FFFFFF。", var_98_0.HORSE, var_98_0.ADDR, var_98_0.GD)
	elseif arg_98_1 == 201 then
		var_98_1 = string.lf("您被#00FF00%s#FFFFFF击败并关进牢笼，成为对方的俘虏。", var_98_0.NowTPName)
	elseif arg_98_1 == 202 then
		var_98_1 = string.lf("很不幸，您的主人#00FF00%s#FFFFFF被#00FF00%s#FFFFFF打败，你成为#00FF00%s#FFFFFF的俘虏。", var_98_0.OldTP, var_98_0.NowTP, var_98_0.NowTP)
	elseif arg_98_1 == 203 then
		var_98_1 = string.lf("您辛勤的劳动让您的主人#00FF00%s#FFFFFF很满意，他释放了您。", var_98_0.NowTPName)
	elseif arg_98_1 == 204 then
		var_98_1 = string.lf("您的俘虏#00FF00%s#FFFFFF反抗（驱赶）了您，成功逃走。", var_98_0.NowTPName)
	elseif arg_98_1 == 205 then
		var_98_1 = string.lf("你的俘虏#00FF00%s#FFFFFF被#00FF00%s#FFFFFF抢走了。", var_98_0.OldTP, var_98_0.CT)
	elseif arg_98_1 == 206 then
		var_98_1 = string.lf("你的俘虏#00FF00%s#FFFFFF被他的好友#00FF00%s#FFFFFF解救了。", var_98_0.OldTP, var_98_0.CT)
	elseif arg_98_1 == 301 then
		var_98_1 = string.lf("好消息！在%s#00FF00%s#FFFFFF的带领下，大伙众志成城，本盟成功升级到了第#00FF00%s#FFFFFF级！加油！", var_98_0.PosN, var_98_0.PN, var_98_0.Lv)
	elseif arg_98_1 == 302 then
		var_98_1 = string.lf("%s#00FF00%s#FFFFFF升级了#00FF00%s#FFFFFF，该建筑等级+1，新的效果已经触发！", var_98_0.PosN, var_98_0.PN, var_98_0.BN)
	elseif arg_98_1 == 303 then
		var_98_1 = string.lf("#00FF00%s#FFFFFF消耗#00FF00%s#FFFFFF%s抢先购买了%s！", var_98_0.PN, var_98_0.Price, getItemName(var_98_0.PT), var_98_2(var_98_0.Reward))
	elseif arg_98_1 == 304 then
		var_98_1 = string.lf("#00FF00%s#FFFFFF消耗#00FF00%s#FFFFFF晶石竞拍到了%s！", var_98_0.PN, var_98_0.PCoin, var_98_2(var_98_0.Reward))
	elseif arg_98_1 == 305 then
		var_98_1 = string.lf("#00FF00%s#FFFFFF在仙魔神殿进行了一次捐献，仙盟获得#00FF00%s#FFFFFF贡献值！", var_98_0.PN, var_98_0.UCoin)
	elseif arg_98_1 == 306 then
		var_98_1 = string.lf("%s#00FF00%s#FFFFFF给#00FF00%s#FFFFFF发放了#00FF00%s#FFFFFF晶石，以表彰他为仙盟做出的卓越贡献！", var_98_0.PosN, var_98_0.PN, var_98_0.ToPN, var_98_0.Num)
	elseif arg_98_1 == 401 then
		var_98_1 = string.lf("你被#00FF00%s#FFFFFF抢夺了#00FF00%s#FFFFFF积分！", var_98_0.PN, var_98_0.Num)
	elseif arg_98_1 == 402 then
		var_98_1 = string.lf("#00FF00%s#FFFFFF想抢夺你的积分，你瞬间霸气侧漏，用王霸之气震退了他！", var_98_0.PN)
	elseif arg_98_1 == 403 then
		var_98_1 = string.lf("#00FF00%s#FFFFFF对你进行了复仇，你被抢走了#00FF00%s#FFFFFF积分！", var_98_0.PN, var_98_0.Num)
	elseif arg_98_1 == 404 then
		var_98_1 = string.lf("#00FF00%s#FFFFFF对你进行了复仇，但是他打不过你，夹着尾巴逃跑了！", var_98_0.PN)
	elseif arg_98_1 == 501 then
		var_98_1 = string.lf("#00FF00%s#FFFFFF挑战%s宝座%s，坚持了#00FF00%s#FFFFFF回合！", var_98_0.PN, var_98_3(var_98_0.G, var_98_0.R), var_98_4(var_98_0.SN), var_98_0.S)
	elseif arg_98_1 == 502 then
		var_98_1 = string.lf("#00FF00%s#FFFFFF挑战%s宝座%s，最终占领了%s宝座！", var_98_0.PN, var_98_3(var_98_0.G, var_98_0.R), var_98_4(var_98_0.SN), var_98_3(var_98_0.G, var_98_0.R))
	end

	return var_98_1
end

function createParticle(arg_102_0, arg_102_1, arg_102_2)
	local var_102_0 = CCParticleSystemQuad:create(arg_102_0)

	var_102_0:setStartSize(var_102_0:getStartSize() * Adapter.MinScale)
	var_102_0:setStartSizeVar(var_102_0:getStartSizeVar() * Adapter.MinScale)
	var_102_0:setEndSize(var_102_0:getEndSize() * Adapter.MinScale)
	var_102_0:setEndSizeVar(var_102_0:getEndSizeVar() * Adapter.MinScale)
	var_102_0:setSpeed(var_102_0:getSpeed() * Adapter.MinScale)
	var_102_0:setSpeedVar(var_102_0:getSpeedVar() * Adapter.MinScale)

	local var_102_1 = var_102_0:getPosVar()

	var_102_0:setPosVar(ccp(var_102_1.x * Adapter.MinScale, var_102_1.y * Adapter.MinScale))
	var_102_0:setScale(1 / arg_102_2:getScale())
	arg_102_2:addChild(var_102_0)
	var_102_0:setPosition(arg_102_1)

	return var_102_0
end

function createFrameAnimation(arg_103_0)
	local var_103_0 = CCSprite:create(arg_103_0.list[1])
	local var_103_1 = CCArray:create()

	for iter_103_0, iter_103_1 in pairs(arg_103_0.list) do
		local var_103_2 = CCSpriteFrame:create(iter_103_1, var_103_0:getTextureRect())

		var_103_1:addObject(var_103_2)
	end

	local var_103_3 = CCAnimation:createWithSpriteFrames(var_103_1, arg_103_0.delta)

	if arg_103_0.loop then
		if arg_103_0.callback then
			local var_103_4 = CCArray:create()

			var_103_4:addObject(CCAnimate:create(var_103_3))
			var_103_4:addObject(CCCallFunc:create(arg_103_0.callback))
			var_103_0:runAction(CCRepeatForever:create(CCSequence:create(var_103_4)))
		else
			var_103_0:runAction(CCRepeatForever:create(CCAnimate:create(var_103_3)))
		end
	else
		local var_103_5 = CCArray:create()

		var_103_5:addObject(CCAnimate:create(var_103_3))

		if arg_103_0.callback then
			var_103_5:addObject(CCCallFunc:create(arg_103_0.callback))
		end

		var_103_0:runAction(CCSequence:create(var_103_5))
	end

	return var_103_0
end

function getBattleAttrsIconName(arg_104_0)
	if arg_104_0 == BattleAttrsType.eHealth then
		return "ui/common/common_shengmingzhi.png"
	elseif arg_104_0 == BattleAttrsType.eNormalAttack then
		return "ui/common/common_pugong.png"
	elseif arg_104_0 == BattleAttrsType.eNormalDefense then
		return "ui/common/common_pufang.png"
	elseif arg_104_0 == BattleAttrsType.eSkillAttack then
		return "ui/common/common_fagong.png"
	elseif arg_104_0 == BattleAttrsType.eSkillDefense then
		return "ui/common/common_fafang.png"
	elseif arg_104_0 == BattleAttrsType.eMingZhong then
		return "ui/common/common_mingzhong.png"
	elseif arg_104_0 == BattleAttrsType.eShanBi then
		return "ui/common/common_shanbi.png"
	elseif arg_104_0 == BattleAttrsType.eBaoJi then
		return "ui/common/common_baoji.png"
	elseif arg_104_0 == BattleAttrsType.eRenXing then
		return "ui/common/common_kangbao.png"
	elseif arg_104_0 == BattleAttrsType.ePoJi then
		return "ui/common/common_poji.png"
	elseif arg_104_0 == BattleAttrsType.eGeDang then
		return "ui/common/common_gedang.png"
	elseif arg_104_0 == BattleAttrsType.eSpeed then
		return "ui/common/common_gedang.png"
	end
end

function addBlackLayer(arg_105_0)
	local var_105_0 = CCLayerColor:create(ccc4(10, 10, 10, 160), display.width, display.height)

	arg_105_0:addChild(var_105_0)
end

function addCloseButton(arg_106_0, arg_106_1)
	local function var_106_0()
		game.enterHomeScene()
	end

	local var_106_1 = ui.newControlButton({
		normalImage = "ui/common/common_061.png",
		position = ccp(display.width - 82 * Adapter.MinScale, display.height - 45 * Adapter.MinScale),
		clickAction = arg_106_1 or var_106_0,
		scaleX = Adapter.MinScale,
		scaleY = Adapter.MinScale
	})

	arg_106_0:addChild(var_106_1)
end

function setMissionStateAnimation(arg_108_0)
	if Player.missionData == nil or arg_108_0 == nil then
		return
	end

	local var_108_0 = false

	for iter_108_0, iter_108_1 in ipairs(Player.missionData) do
		if iter_108_1.state == TaskStatus.eCompleted then
			var_108_0 = true

			break
		end
	end

	if arg_108_0.animationNode == nil then
		local var_108_1 = arg_108_0:getContentSize()

		arg_108_0.animationNode = display.newNode()

		arg_108_0.animationNode:setPosition(ccp(var_108_1.width / 2, var_108_1.height / 2))
		arg_108_0:addChild(arg_108_0.animationNode)
	end

	if var_108_0 == false then
		arg_108_0.animationNode:removeAllChildren()
	else
		local var_108_2 = display.newSprite("ui/home/home_action_1.png")

		var_108_2:setScale(Adapter.MinScale)
		arg_108_0.animationNode:addChild(var_108_2)
		var_108_2:runAction(CCRepeatForever:create(CCRotateBy:create(0.2, 60)))
	end

	local var_108_3 = false

	if Player.level >= 10 then
		for iter_108_2, iter_108_3 in ipairs(Player.missionData) do
			if iter_108_3.type == TaskType.eTaskTeaching then
				var_108_3 = true

				break
			end
		end
	end

	if arg_108_0.teachTaskNode == nil then
		local var_108_4 = arg_108_0:getContentSize()

		arg_108_0.teachTaskNode = display.newNode()

		arg_108_0.teachTaskNode:setPosition(ccp(var_108_4.width * 0.75, var_108_4.height * 0.75))
		arg_108_0:addChild(arg_108_0.teachTaskNode)
	end

	if var_108_3 == true then
		local var_108_5 = display.newSprite("uilocal/home/home_text_026.png")

		var_108_5:setScale(Adapter.MinScale * 0.6)
		arg_108_0.teachTaskNode:addChild(var_108_5)

		local var_108_6 = CCArray:create()

		var_108_6:addObject(CCDelayTime:create(3))
		var_108_6:addObject(CCJumpBy:create(0.25, ccp(0, 0), Adapter.AutoPosY(15), 1))
		var_108_5:runAction(CCRepeatForever:create(CCSequence:create(var_108_6)))
	else
		arg_108_0.teachTaskNode:removeAllChildren()
	end
end

function getItemCanRecruit(arg_109_0)
	local var_109_0 = false

	if arg_109_0.Type == ItemType.eSoul then
		local var_109_1 = false
		local var_109_2 = BaseSouls[arg_109_0.ID].figureId

		for iter_109_0, iter_109_1 in pairs(Player.ownedHeros) do
			if iter_109_1.heroId == var_109_2 then
				var_109_1 = true

				break
			end
		end

		local var_109_3 = BaseHeros[var_109_2].soulCount

		var_109_0 = var_109_1 == false and var_109_3 <= arg_109_0.Count
	end

	return var_109_0
end

function getItemCanMixture(arg_110_0)
	local var_110_0 = false

	if arg_110_0.Type == ItemType.eFragment then
		local var_110_1 = BaseFragments[arg_110_0.ID]

		if arg_110_0.Count >= var_110_1.exchangeCount then
			var_110_0 = true
		end
	end

	return var_110_0
end

GlobalSortTypes = {
	sortByQualityDown = 2,
	sortByLevelUp = 3,
	sortByQualityUp = 1,
	sortByRecruit = 6,
	sortByInTeam = 5,
	sortByMixture = 7,
	sortByLevelDown = 4
}

function GlobalSortCallback(arg_111_0, arg_111_1, arg_111_2)
	local var_111_0 = getItemQuality(arg_111_0.Type, arg_111_0.ID)
	local var_111_1 = getItemQuality(arg_111_1.Type, arg_111_1.ID)

	if arg_111_2 == GlobalSortTypes.sortByQualityDown then
		if arg_111_0.Type == arg_111_1.Type then
			if var_111_0 == var_111_1 then
				if arg_111_0.detail ~= nil and arg_111_0.detail.level ~= nil and arg_111_1.detail ~= nil and arg_111_1.detail.level ~= nil then
					if arg_111_0.detail.level == arg_111_1.detail.level then
						return arg_111_0.ID > arg_111_1.ID
					else
						return arg_111_0.detail.level > arg_111_1.detail.level
					end
				else
					return arg_111_0.ID > arg_111_1.ID
				end
			else
				return var_111_1 < var_111_0
			end
		else
			return arg_111_0.Type > arg_111_1.Type
		end
	elseif arg_111_2 == GlobalSortTypes.sortByQualityUp then
		if arg_111_0.Type == arg_111_1.Type then
			if var_111_0 == var_111_1 then
				if arg_111_0.detail ~= nil and arg_111_0.detail.level ~= nil and arg_111_1.detail ~= nil and arg_111_1.detail.level ~= nil then
					if arg_111_0.detail.level == arg_111_1.detail.level then
						return arg_111_0.ID < arg_111_1.ID
					else
						return arg_111_0.detail.level < arg_111_1.detail.level
					end
				else
					return arg_111_0.ID < arg_111_1.ID
				end
			else
				return var_111_0 < var_111_1
			end
		else
			return arg_111_0.Type < arg_111_1.Type
		end
	elseif arg_111_2 == GlobalSortTypes.sortByLevelDown then
		if arg_111_0.Type == arg_111_1.Type then
			if arg_111_0.detail ~= nil and arg_111_0.detail.level ~= nil and arg_111_1.detail ~= nil and arg_111_1.detail.level ~= nil and arg_111_0.detail.level ~= arg_111_1.detail.level then
				return arg_111_0.detail.level > arg_111_1.detail.level
			elseif var_111_0 == var_111_1 then
				return arg_111_0.ID > arg_111_1.ID
			else
				return var_111_1 < var_111_0
			end
		else
			return arg_111_0.Type > arg_111_1.Type
		end
	elseif arg_111_2 == GlobalSortTypes.sortByLevelUp then
		if arg_111_0.Type == arg_111_1.Type then
			if arg_111_0.detail ~= nil and arg_111_0.detail.level ~= nil and arg_111_1.detail ~= nil and arg_111_1.detail.level ~= nil and arg_111_0.detail.level ~= arg_111_1.detail.level then
				return arg_111_0.detail.level < arg_111_1.detail.level
			elseif var_111_0 == var_111_1 then
				return arg_111_0.ID < arg_111_1.ID
			else
				return var_111_0 < var_111_1
			end
		else
			return arg_111_0.Type < arg_111_1.Type
		end
	elseif arg_111_2 == GlobalSortTypes.sortByInTeam then
		local var_111_2 = false
		local var_111_3 = false

		if arg_111_0.Type == ItemType.eHero then
			var_111_2 = Player:isHeroInPartnerTeam(arg_111_0.ID)
			var_111_3 = Player:isHeroInPartnerTeam(arg_111_1.ID)
		end

		local var_111_4 = arg_111_0.isInTeam ~= nil and (arg_111_0.isInTeam or var_111_2) or false
		local var_111_5 = arg_111_1.isInTeam ~= nil and (arg_111_1.isInTeam or var_111_3) or false

		if var_111_4 == true and var_111_5 == true or var_111_4 == false and var_111_5 == false then
			if var_111_0 == var_111_1 then
				if arg_111_0.detail ~= nil and arg_111_0.detail.level ~= nil and arg_111_1.detail ~= nil and arg_111_1.detail.level ~= nil then
					if arg_111_0.detail.level == arg_111_1.detail.level then
						return arg_111_0.ID > arg_111_1.ID
					else
						return arg_111_0.detail.level > arg_111_1.detail.level
					end
				else
					return arg_111_0.ID > arg_111_1.ID
				end
			else
				return var_111_1 < var_111_0
			end
		else
			return var_111_4 == true
		end
	elseif arg_111_2 == GlobalSortTypes.sortByRecruit then
		local var_111_6 = getItemCanRecruit(arg_111_0)
		local var_111_7 = getItemCanRecruit(arg_111_1)

		if var_111_6 == true and var_111_7 == true or var_111_6 == false and var_111_7 == false then
			if var_111_0 == var_111_1 then
				if arg_111_0.detail ~= nil and arg_111_0.detail.level ~= nil and arg_111_1.detail ~= nil and arg_111_1.detail.level ~= nil then
					if arg_111_0.detail.level == arg_111_1.detail.level then
						return arg_111_0.ID > arg_111_1.ID
					else
						return arg_111_0.detail.level > arg_111_1.detail.level
					end
				else
					return arg_111_0.ID > arg_111_1.ID
				end
			else
				return var_111_1 < var_111_0
			end
		else
			return var_111_6 == true
		end
	elseif arg_111_2 == GlobalSortTypes.sortByMixture then
		local var_111_8 = getItemCanMixture(arg_111_0)
		local var_111_9 = getItemCanMixture(arg_111_1)

		if var_111_8 == true and var_111_9 == true or var_111_8 == false and var_111_9 == false then
			if var_111_0 == var_111_1 then
				if arg_111_0.detail ~= nil and arg_111_0.detail.level ~= nil and arg_111_1.detail ~= nil and arg_111_1.detail.level ~= nil then
					if arg_111_0.detail.level == arg_111_1.detail.level then
						return arg_111_0.ID > arg_111_1.ID
					else
						return arg_111_0.detail.level > arg_111_1.detail.level
					end
				else
					return arg_111_0.ID > arg_111_1.ID
				end
			else
				return var_111_1 < var_111_0
			end
		else
			return var_111_8 == true
		end
	end
end

function findChapterLastStageStatus(arg_112_0)
	local var_112_0 = BaseStages[arg_112_0].chapterId
	local var_112_1 = arg_112_0
	local var_112_2 = arg_112_0

	while true do
		if BaseStages[var_112_2] == nil then
			break
		end

		if BaseStages[var_112_2].chapterId ~= var_112_0 then
			break
		else
			var_112_1 = var_112_2
		end

		var_112_2 = var_112_2 + 1
	end

	for iter_112_0, iter_112_1 in ipairs(Player.taskInfo.Point) do
		if iter_112_1.PID == var_112_1 then
			return iter_112_1
		end
	end

	return nil
end

function ui.createRedPoint(arg_113_0)
	local var_113_0 = display.newSprite("ui/common/common_112.png", arg_113_0.position.x, arg_113_0.position.y)

	var_113_0:setScale(arg_113_0.scale and arg_113_0.scale or 1)

	local var_113_1 = CCArray:create()

	var_113_1:addObject(CCDelayTime:create(3))
	var_113_1:addObject(CCJumpBy:create(0.25, ccp(0, 0), Adapter.AutoPosY(10), 1))
	var_113_0:runAction(CCRepeatForever:create(CCSequence:create(var_113_1)))
	arg_113_0.parent:addChild(var_113_0, DefaultZOrder.ePopupLayer)

	return var_113_0
end

function getShareEnabledTable(arg_114_0)
	local var_114_0 = {}
	local var_114_1
	local var_114_2 = CCFileUtils:sharedFileUtils():fullPathForFilename("PartnerSystemLayer.json")

	if io.exists(var_114_2) then
		var_114_1 = io.readfile(var_114_2)
	end

	local var_114_3 = json.decode(var_114_1) or {}

	if not var_114_3.noWeiBoShare then
		table.insert(var_114_0, {
			image = "ui/activity/activity_084.png",
			type = SHARE_TYPE_WEIBO
		})
	end

	if var_114_3.EnableWeiXinShare then
		table.insert(var_114_0, {
			image = "ui/activity/activity_083.png",
			type = SHARE_TYPE_WEIXIN
		})
	end

	local var_114_4 = var_114_3.exShare or {}

	for iter_114_0, iter_114_1 in pairs(var_114_4) do
		table.insert(var_114_0, {
			image = iter_114_1.image,
			type = iter_114_1.type
		})
	end

	return var_114_0
end
