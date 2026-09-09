require("data.hero")

EquipType = {
	eNecklace = 5,
	eClothes = 4,
	eRing = 6,
	eAmulet = 2,
	eWeapon = 1,
	eHelmet = 3
}
EquipTypeNames = {
	string.lf("武器"),
	string.lf("灵符"),
	string.lf("头盔"),
	string.lf("衣服"),
	string.lf("项链"),
	(string.lf("戒指"))
}
EquipPinjieType = {
	eJiPin = 4,
	eJingPin = 3,
	eShengPin = 5,
	eFanPin = 1,
	eShangPin = 2
}
EquipPinjieNames = {
	string.lf("凡品"),
	[3] = string.lf("精品"),
	[4] = string.lf("极品"),
	[5] = string.lf("圣品"),
	(string.lf("上品"))
}
BaseEquips = {
	{
		profession = 4,
		quality = 1,
		name = "道士符",
		skillAttackMax = 171,
		heroExtra = 0,
		skillAttackGrowMax = 22.26,
		headerImage = "small_lingfu_01.png",
		equipType = EquipType.eAmulet,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eBaoJi
		}
	},
	{
		profession = 4,
		quality = 2,
		name = "净衣符",
		skillAttackMax = 203,
		heroExtra = 0,
		skillAttackGrowMax = 25.97,
		headerImage = "small_lingfu_02.png",
		equipType = EquipType.eAmulet,
		herosId = {
			405
		},
		feedAttrs = {
			BattleAttrsType.ePoJi,
			BattleAttrsType.eBaoJi
		}
	},
	{
		profession = 4,
		quality = 1,
		name = "巫咒符",
		skillAttackMax = 172,
		heroExtra = 0,
		skillAttackGrowMax = 23.42,
		headerImage = "small_lingfu_03.png",
		equipType = EquipType.eAmulet,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eMingZhong
		}
	},
	{
		profession = 4,
		quality = 2,
		name = "驭雷符",
		skillAttackMax = 220,
		heroExtra = 0,
		skillAttackGrowMax = 26.5,
		headerImage = "small_lingfu_04.png",
		equipType = EquipType.eAmulet,
		herosId = {
			403
		},
		feedAttrs = {
			BattleAttrsType.eBaoJi,
			BattleAttrsType.eMingZhong
		}
	},
	{
		profession = 4,
		quality = 1,
		name = "天师符",
		skillAttackMax = 176,
		heroExtra = 0,
		skillAttackGrowMax = 22.26,
		headerImage = "small_lingfu_01.png",
		equipType = EquipType.eAmulet,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.ePoJi
		}
	},
	{
		profession = 4,
		quality = 2,
		name = "大力符",
		skillAttackMax = 215,
		heroExtra = 0,
		skillAttackGrowMax = 26.5,
		headerImage = "small_lingfu_02.png",
		equipType = EquipType.eAmulet,
		herosId = {
			406
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi
		}
	},
	{
		quality = 3,
		name = "天灵符",
		skillAttackMax = 263,
		heroExtra = 0,
		skillAttackGrowMax = 30.11,
		headerImage = "small_tianlingfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			306,
			310
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 95,
				desc = "破击{+26},暴击{+27}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 191,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 286,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 7,
				equipCount = 1,
				mateCount = 280,
				skillattack = 381,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 7,
				equipCount = 2,
				mateCount = 360,
				skillattack = 476,
				desc = "装备主将自身法攻提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 7,
				equipCount = 2,
				mateCount = 440,
				skillattack = 572,
				desc = "破击{+88},暴击{+89},命中{+87}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 7,
				equipCount = 3,
				mateCount = 520,
				skillattack = 667,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	{
		profession = 4,
		quality = 2,
		name = "地灵符",
		skillAttackMax = 217,
		heroExtra = 0,
		skillAttackGrowMax = 27.03,
		headerImage = "small_lingfu_04.png",
		equipType = EquipType.eAmulet,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eBaoJi,
			BattleAttrsType.eMingZhong
		}
	},
	{
		quality = 3,
		name = "金灵符",
		skillAttackMax = 261,
		heroExtra = 0,
		skillAttackGrowMax = 30.7,
		headerImage = "small_jinlingfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			303,
			311
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 95,
				desc = "破击{+26},暴击{+27}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 191,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 286,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 9,
				equipCount = 1,
				mateCount = 280,
				skillattack = 381,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 9,
				equipCount = 2,
				mateCount = 360,
				skillattack = 476,
				desc = "装备主将自身法攻提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 9,
				equipCount = 2,
				mateCount = 440,
				skillattack = 572,
				desc = "破击{+90},暴击{+91},命中{+86}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 9,
				equipCount = 3,
				mateCount = 520,
				skillattack = 667,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	{
		profession = 4,
		quality = 2,
		name = "木灵符",
		skillAttackMax = 213,
		heroExtra = 0,
		skillAttackGrowMax = 27.29,
		headerImage = "small_lingfu_02.png",
		equipType = EquipType.eAmulet,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		}
	},
	{
		profession = 4,
		quality = 2,
		name = "水灵符",
		skillAttackMax = 211,
		heroExtra = 0,
		skillAttackGrowMax = 27.03,
		headerImage = "small_lingfu_03.png",
		equipType = EquipType.eAmulet,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eBaoJi,
			BattleAttrsType.eMingZhong
		}
	},
	{
		profession = 4,
		quality = 2,
		name = "火灵符",
		skillAttackMax = 207,
		heroExtra = 0,
		skillAttackGrowMax = 26.76,
		headerImage = "small_lingfu_04.png",
		equipType = EquipType.eAmulet,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.ePoJi
		}
	},
	{
		profession = 4,
		quality = 2,
		name = "土灵符",
		skillAttackMax = 203,
		heroExtra = 0,
		skillAttackGrowMax = 26.5,
		headerImage = "small_lingfu_01.png",
		equipType = EquipType.eAmulet,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		}
	},
	{
		quality = 3,
		name = "通灵符",
		skillAttackMax = 261,
		heroExtra = 0,
		skillAttackGrowMax = 29.21,
		headerImage = "small_tonglingfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			302,
			309
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 95,
				desc = "破击{+27},暴击{+26}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 191,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 286,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 14,
				equipCount = 1,
				mateCount = 280,
				skillattack = 381,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 14,
				equipCount = 2,
				mateCount = 360,
				skillattack = 476,
				desc = "装备主将自身法攻提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 14,
				equipCount = 2,
				mateCount = 440,
				skillattack = 572,
				desc = "破击{+90},暴击{+89},命中{+89}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 14,
				equipCount = 3,
				mateCount = 520,
				skillattack = 667,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	{
		quality = 3,
		name = "妖灵符",
		skillAttackMax = 256,
		heroExtra = 0,
		skillAttackGrowMax = 28.62,
		headerImage = "small_yaolingfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			304,
			308
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 95,
				desc = "破击{+27},暴击{+27}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 191,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 286,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 15,
				equipCount = 1,
				mateCount = 280,
				skillattack = 381,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 15,
				equipCount = 2,
				mateCount = 360,
				skillattack = 476,
				desc = "装备主将自身法攻提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 15,
				equipCount = 2,
				mateCount = 440,
				skillattack = 572,
				desc = "破击{+88},暴击{+91},命中{+91}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 15,
				equipCount = 3,
				mateCount = 520,
				skillattack = 667,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	{
		quality = 3,
		name = "元灵符",
		skillAttackMax = 245,
		heroExtra = 0,
		skillAttackGrowMax = 30.41,
		headerImage = "small_yuanlingfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			305,
			307
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 95,
				desc = "破击{+26},暴击{+26}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 191,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 286,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 16,
				equipCount = 1,
				mateCount = 280,
				skillattack = 381,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 16,
				equipCount = 2,
				mateCount = 360,
				skillattack = 476,
				desc = "装备主将自身法攻提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 16,
				equipCount = 2,
				mateCount = 440,
				skillattack = 572,
				desc = "破击{+86},暴击{+87},命中{+87}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 16,
				equipCount = 3,
				mateCount = 520,
				skillattack = 667,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	{
		quality = 3,
		name = "天尊符",
		skillAttackMax = 261,
		heroExtra = 0,
		skillAttackGrowMax = 29.81,
		headerImage = "small_tianzunfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			201,
			203
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 95,
				desc = "破击{+27},暴击{+26}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 191,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 286,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 17,
				equipCount = 1,
				mateCount = 280,
				skillattack = 381,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 17,
				equipCount = 2,
				mateCount = 360,
				skillattack = 476,
				desc = "装备主将自身法攻提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 17,
				equipCount = 2,
				mateCount = 440,
				skillattack = 572,
				desc = "破击{+88},暴击{+87},命中{+87}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 17,
				equipCount = 3,
				mateCount = 520,
				skillattack = 667,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	{
		quality = 3,
		name = "降魔符",
		skillAttackMax = 253,
		heroExtra = 0,
		skillAttackGrowMax = 28.92,
		headerImage = "small_xiangmofu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			208
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 95,
				desc = "破击{+26},暴击{+27}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 191,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 286,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 18,
				equipCount = 1,
				mateCount = 280,
				skillattack = 381,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 18,
				equipCount = 2,
				mateCount = 360,
				skillattack = 476,
				desc = "装备主将自身法攻提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 18,
				equipCount = 2,
				mateCount = 440,
				skillattack = 572,
				desc = "破击{+87},暴击{+88},命中{+89}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 18,
				equipCount = 3,
				mateCount = 520,
				skillattack = 667,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	{
		quality = 3,
		name = "噬魂符",
		skillAttackMax = 266,
		heroExtra = 0,
		skillAttackGrowMax = 30.7,
		headerImage = "small_shihunfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			301
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 95,
				desc = "破击{+26},暴击{+26}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 191,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 286,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 19,
				equipCount = 1,
				mateCount = 280,
				skillattack = 381,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 19,
				equipCount = 2,
				mateCount = 360,
				skillattack = 476,
				desc = "装备主将自身法攻提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 19,
				equipCount = 2,
				mateCount = 440,
				skillattack = 572,
				desc = "破击{+90},暴击{+91},命中{+88}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 19,
				equipCount = 3,
				mateCount = 520,
				skillattack = 667,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	{
		quality = 3,
		name = "观音符",
		skillAttackMax = 256,
		heroExtra = 0,
		skillAttackGrowMax = 29.21,
		headerImage = "small_guanyinfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			204,
			210
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 95,
				desc = "破击{+27},暴击{+26}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 191,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 286,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 20,
				equipCount = 1,
				mateCount = 280,
				skillattack = 381,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 20,
				equipCount = 2,
				mateCount = 360,
				skillattack = 476,
				desc = "装备主将自身法攻提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 20,
				equipCount = 2,
				mateCount = 440,
				skillattack = 572,
				desc = "破击{+90},暴击{+88},命中{+87}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 20,
				equipCount = 3,
				mateCount = 520,
				skillattack = 667,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	{
		quality = 3,
		name = "血魂符",
		skillAttackMax = 245,
		heroExtra = 0,
		skillAttackGrowMax = 31,
		headerImage = "small_xuehunfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			206
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 95,
				desc = "破击{+27},暴击{+27}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 191,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 286,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 21,
				equipCount = 1,
				mateCount = 280,
				skillattack = 381,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 21,
				equipCount = 2,
				mateCount = 360,
				skillattack = 476,
				desc = "装备主将自身法攻提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 21,
				equipCount = 2,
				mateCount = 440,
				skillattack = 572,
				desc = "破击{+90},暴击{+86},命中{+88}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 21,
				equipCount = 3,
				mateCount = 520,
				skillattack = 667,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	{
		quality = 3,
		name = "定妖符",
		skillAttackMax = 258,
		heroExtra = 0,
		skillAttackGrowMax = 29.81,
		headerImage = "small_dingyaofu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			207
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 95,
				desc = "破击{+27},暴击{+26}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 191,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 286,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 22,
				equipCount = 1,
				mateCount = 280,
				skillattack = 381,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 22,
				equipCount = 2,
				mateCount = 360,
				skillattack = 476,
				desc = "装备主将自身法攻提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 22,
				equipCount = 2,
				mateCount = 440,
				skillattack = 572,
				desc = "破击{+87},暴击{+90},命中{+90}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 22,
				equipCount = 3,
				mateCount = 520,
				skillattack = 667,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	{
		quality = 3,
		name = "聚魂符",
		skillAttackMax = 245,
		heroExtra = 0,
		skillAttackGrowMax = 28.92,
		headerImage = "small_juhunfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			212
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 95,
				desc = "破击{+27},暴击{+27}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 191,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 286,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 23,
				equipCount = 1,
				mateCount = 280,
				skillattack = 381,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 23,
				equipCount = 2,
				mateCount = 360,
				skillattack = 476,
				desc = "装备主将自身法攻提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 23,
				equipCount = 2,
				mateCount = 440,
				skillattack = 572,
				desc = "破击{+89},暴击{+91},命中{+89}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 23,
				equipCount = 3,
				mateCount = 520,
				skillattack = 667,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	{
		quality = 3,
		name = "龙王符",
		skillAttackMax = 256,
		heroExtra = 0,
		skillAttackGrowMax = 30.41,
		headerImage = "small_longwangfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			209
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 95,
				desc = "破击{+27},暴击{+26}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 191,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 286,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 24,
				equipCount = 1,
				mateCount = 280,
				skillattack = 381,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 24,
				equipCount = 2,
				mateCount = 360,
				skillattack = 476,
				desc = "装备主将自身法攻提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 24,
				equipCount = 2,
				mateCount = 440,
				skillattack = 572,
				desc = "破击{+91},暴击{+90},命中{+90}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 24,
				equipCount = 3,
				mateCount = 520,
				skillattack = 667,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	{
		quality = 3,
		name = "破军符",
		skillAttackMax = 266,
		heroExtra = 0,
		skillAttackGrowMax = 29.21,
		headerImage = "small_pojunfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			202,
			205
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 95,
				desc = "破击{+27},暴击{+26}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 191,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 286,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 25,
				equipCount = 1,
				mateCount = 280,
				skillattack = 381,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 25,
				equipCount = 2,
				mateCount = 360,
				skillattack = 476,
				desc = "装备主将自身法攻提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 25,
				equipCount = 2,
				mateCount = 440,
				skillattack = 572,
				desc = "破击{+89},暴击{+88},命中{+87}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 25,
				equipCount = 3,
				mateCount = 520,
				skillattack = 667,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	{
		quality = 3,
		name = "天王符",
		skillAttackMax = 253,
		heroExtra = 0,
		skillAttackGrowMax = 30.41,
		headerImage = "small_tianwangfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			211
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 95,
				desc = "破击{+27},暴击{+26}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 191,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 286,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 26,
				equipCount = 1,
				mateCount = 280,
				skillattack = 381,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 26,
				equipCount = 2,
				mateCount = 360,
				skillattack = 476,
				desc = "装备主将自身法攻提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 26,
				equipCount = 2,
				mateCount = 440,
				skillattack = 572,
				desc = "破击{+89},暴击{+87},命中{+89}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 26,
				equipCount = 3,
				mateCount = 520,
				skillattack = 667,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	{
		quality = 4,
		name = "盘古神符",
		skillAttackMax = 309,
		heroExtra = 0,
		skillAttackGrowMax = 34.73,
		headerImage = "small_pangushenfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 119,
				desc = "破击{+68},暴击{+65}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 238,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 357,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 27,
				equipCount = 1,
				mateCount = 680,
				skillattack = 476,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 27,
				equipCount = 1,
				mateCount = 840,
				skillattack = 595,
				desc = "装备主将自身法攻提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 27,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 714,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 27,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 834,
				desc = "破击{+194},暴击{+200},命中{+198}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 27,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 953,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 27,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 1072,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 27,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 1191,
				desc = "装备主将自身法攻提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	{
		quality = 4,
		name = "九天神符",
		skillAttackMax = 297,
		heroExtra = 0,
		skillAttackGrowMax = 36.5,
		headerImage = "small_jiutianshenfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			102,
			108
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 119,
				desc = "破击{+66},暴击{+69}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 238,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 357,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 28,
				equipCount = 1,
				mateCount = 680,
				skillattack = 476,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 28,
				equipCount = 1,
				mateCount = 840,
				skillattack = 595,
				desc = "装备主将自身法攻提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 28,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 714,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 28,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 834,
				desc = "破击{+201},暴击{+196},命中{+204}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 28,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 953,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 28,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 1072,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 28,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 1191,
				desc = "装备主将自身法攻提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	{
		quality = 4,
		name = "乾坤神符",
		skillAttackMax = 306,
		heroExtra = 0,
		skillAttackGrowMax = 34.73,
		headerImage = "small_qiankunshenfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			106
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 119,
				desc = "破击{+66},暴击{+67}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 238,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 357,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 29,
				equipCount = 1,
				mateCount = 680,
				skillattack = 476,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 29,
				equipCount = 1,
				mateCount = 840,
				skillattack = 595,
				desc = "装备主将自身法攻提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 29,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 714,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 29,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 834,
				desc = "破击{+195},暴击{+198},命中{+195}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 29,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 953,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 29,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 1072,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 29,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 1191,
				desc = "装备主将自身法攻提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	{
		quality = 4,
		name = "三清神符",
		skillAttackMax = 291,
		heroExtra = 0,
		skillAttackGrowMax = 36.15,
		headerImage = "small_sanqingshenfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			105
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 119,
				desc = "破击{+67},暴击{+67}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 238,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 357,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 30,
				equipCount = 1,
				mateCount = 680,
				skillattack = 476,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 30,
				equipCount = 1,
				mateCount = 840,
				skillattack = 595,
				desc = "装备主将自身法攻提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 30,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 714,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 30,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 834,
				desc = "破击{+198},暴击{+195},命中{+204}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 30,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 953,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 30,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 1072,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 30,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 1191,
				desc = "装备主将自身法攻提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	{
		quality = 4,
		name = "狂龙战符",
		skillAttackMax = 303,
		heroExtra = 0,
		skillAttackGrowMax = 34.73,
		headerImage = "small_kuanglongzhanfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			109
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 119,
				desc = "破击{+65},暴击{+69}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 238,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 357,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 31,
				equipCount = 1,
				mateCount = 680,
				skillattack = 476,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 31,
				equipCount = 1,
				mateCount = 840,
				skillattack = 595,
				desc = "装备主将自身法攻提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 31,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 714,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 31,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 834,
				desc = "破击{+195},暴击{+195},命中{+198}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 31,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 953,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 31,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 1072,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 31,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 1191,
				desc = "装备主将自身法攻提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	{
		quality = 4,
		name = "轩辕战符",
		skillAttackMax = 288,
		heroExtra = 0,
		skillAttackGrowMax = 36.15,
		headerImage = "small_xuanyuanzhanfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			103,
			111
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 119,
				desc = "破击{+68},暴击{+67}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 238,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 357,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 32,
				equipCount = 1,
				mateCount = 680,
				skillattack = 476,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 32,
				equipCount = 1,
				mateCount = 840,
				skillattack = 595,
				desc = "装备主将自身法攻提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 32,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 714,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 32,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 834,
				desc = "破击{+197},暴击{+196},命中{+204}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 32,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 953,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 32,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 1072,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 32,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 1191,
				desc = "装备主将自身法攻提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	{
		quality = 4,
		name = "万灵神符",
		skillAttackMax = 300,
		heroExtra = 0,
		skillAttackGrowMax = 34.38,
		headerImage = "small_wanlingshenfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			107
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 119,
				desc = "破击{+67},暴击{+68}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 238,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 357,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 33,
				equipCount = 1,
				mateCount = 680,
				skillattack = 476,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 33,
				equipCount = 1,
				mateCount = 840,
				skillattack = 595,
				desc = "装备主将自身法攻提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 33,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 714,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 33,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 834,
				desc = "破击{+200},暴击{+201},命中{+196}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 33,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 953,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 33,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 1072,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 33,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 1191,
				desc = "装备主将自身法攻提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	{
		quality = 4,
		name = "万妖鬼符",
		skillAttackMax = 309,
		heroExtra = 0,
		skillAttackGrowMax = 35.79,
		headerImage = "small_wanyaoguifu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			110
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 119,
				desc = "破击{+67},暴击{+68}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 238,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 357,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 34,
				equipCount = 1,
				mateCount = 680,
				skillattack = 476,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 34,
				equipCount = 1,
				mateCount = 840,
				skillattack = 595,
				desc = "装备主将自身法攻提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 34,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 714,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 34,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 834,
				desc = "破击{+199},暴击{+198},命中{+202}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 34,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 953,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 34,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 1072,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 34,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 1191,
				desc = "装备主将自身法攻提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	{
		quality = 4,
		name = "玉皇金符",
		skillAttackMax = 294,
		heroExtra = 0,
		skillAttackGrowMax = 34.02,
		headerImage = "small_yuhuangjinfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			101
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 119,
				desc = "破击{+68},暴击{+65}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 238,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 357,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 35,
				equipCount = 1,
				mateCount = 680,
				skillattack = 476,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 35,
				equipCount = 1,
				mateCount = 840,
				skillattack = 595,
				desc = "装备主将自身法攻提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 35,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 714,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 35,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 834,
				desc = "破击{+199},暴击{+197},命中{+204}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 35,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 953,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 35,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 1072,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 35,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 1191,
				desc = "装备主将自身法攻提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	{
		quality = 4,
		name = "弥罗真符",
		skillAttackMax = 303,
		heroExtra = 0,
		skillAttackGrowMax = 35.44,
		headerImage = "small_miluozhenfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			104
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 119,
				desc = "破击{+65},暴击{+66}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 238,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 357,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 36,
				equipCount = 1,
				mateCount = 680,
				skillattack = 476,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 36,
				equipCount = 1,
				mateCount = 840,
				skillattack = 595,
				desc = "装备主将自身法攻提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 36,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 714,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 36,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 834,
				desc = "破击{+200},暴击{+204},命中{+204}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 36,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 953,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 36,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 1072,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 36,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 1191,
				desc = "装备主将自身法攻提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[44] = {
		quality = 3,
		name = "珍珠汗衫",
		normalDefenseMax = 64,
		heroExtra = 0,
		normalDefenseGrowMax = 7.53,
		headerImage = "small_zhenzhuhanyi.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			301
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+27},韧性{+26}",
				mateCount = 100,
				normaldefense = 71,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				normaldefense = 143,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				normaldefense = 214,
				level = 45
			},
			{
				equipId = 44,
				equipCount = 1,
				mateCount = 280,
				normaldefense = 286,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 44,
				equipCount = 2,
				mateCount = 360,
				normaldefense = 357,
				desc = "装备主将自身普防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 44,
				equipCount = 2,
				mateCount = 440,
				normaldefense = 429,
				desc = "闪避{+87},韧性{+91},格挡{+87}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 44,
				equipCount = 3,
				mateCount = 520,
				normaldefense = 500,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[47] = {
		quality = 3,
		name = "天罡甲",
		normalDefenseMax = 63,
		heroExtra = 0,
		normalDefenseGrowMax = 7.6,
		headerImage = "small_tiangangjia.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			302,
			309
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+27},韧性{+27}",
				mateCount = 100,
				normaldefense = 71,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				normaldefense = 143,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				normaldefense = 214,
				level = 45
			},
			{
				equipId = 47,
				equipCount = 1,
				mateCount = 280,
				normaldefense = 286,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 47,
				equipCount = 2,
				mateCount = 360,
				normaldefense = 357,
				desc = "装备主将自身普防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 47,
				equipCount = 2,
				mateCount = 440,
				normaldefense = 429,
				desc = "闪避{+91},韧性{+88},格挡{+88}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 47,
				equipCount = 3,
				mateCount = 520,
				normaldefense = 500,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[48] = {
		quality = 3,
		name = "赤炎袍",
		normalDefenseMax = 65,
		heroExtra = 0,
		normalDefenseGrowMax = 7.15,
		headerImage = "small_chiyanpao.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			307
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+27},韧性{+27}",
				mateCount = 100,
				normaldefense = 71,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				normaldefense = 143,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				normaldefense = 214,
				level = 45
			},
			{
				equipId = 48,
				equipCount = 1,
				mateCount = 280,
				normaldefense = 286,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 48,
				equipCount = 2,
				mateCount = 360,
				normaldefense = 357,
				desc = "装备主将自身普防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 48,
				equipCount = 2,
				mateCount = 440,
				normaldefense = 429,
				desc = "闪避{+90},韧性{+86},格挡{+86}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 48,
				equipCount = 3,
				mateCount = 520,
				normaldefense = 500,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[49] = {
		quality = 3,
		name = "白银铠",
		normalDefenseMax = 61,
		heroExtra = 0,
		normalDefenseGrowMax = 7.45,
		headerImage = "small_baiyinkai.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			303,
			310
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+27},韧性{+26}",
				mateCount = 100,
				normaldefense = 71,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				normaldefense = 143,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				normaldefense = 214,
				level = 45
			},
			{
				equipId = 49,
				equipCount = 1,
				mateCount = 280,
				normaldefense = 286,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 49,
				equipCount = 2,
				mateCount = 360,
				normaldefense = 357,
				desc = "装备主将自身普防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 49,
				equipCount = 2,
				mateCount = 440,
				normaldefense = 429,
				desc = "闪避{+90},韧性{+87},格挡{+89}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 49,
				equipCount = 3,
				mateCount = 520,
				normaldefense = 500,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[50] = {
		quality = 3,
		name = "青云甲",
		normalDefenseMax = 63,
		heroExtra = 0,
		normalDefenseGrowMax = 7.68,
		headerImage = "small_qingyunjia.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			308
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+27},韧性{+26}",
				mateCount = 100,
				normaldefense = 71,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				normaldefense = 143,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				normaldefense = 214,
				level = 45
			},
			{
				equipId = 50,
				equipCount = 1,
				mateCount = 280,
				normaldefense = 286,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 50,
				equipCount = 2,
				mateCount = 360,
				normaldefense = 357,
				desc = "装备主将自身普防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 50,
				equipCount = 2,
				mateCount = 440,
				normaldefense = 429,
				desc = "闪避{+92},韧性{+91},格挡{+87}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 50,
				equipCount = 3,
				mateCount = 520,
				normaldefense = 500,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[52] = {
		quality = 3,
		name = "赭黄袍",
		normalDefenseMax = 66,
		heroExtra = 0,
		normalDefenseGrowMax = 7.45,
		headerImage = "small_zhehuangpao.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			201,
			305
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+27},韧性{+27}",
				mateCount = 100,
				normaldefense = 71,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				normaldefense = 143,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				normaldefense = 214,
				level = 45
			},
			{
				equipId = 52,
				equipCount = 1,
				mateCount = 280,
				normaldefense = 286,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 52,
				equipCount = 2,
				mateCount = 360,
				normaldefense = 357,
				desc = "装备主将自身普防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 52,
				equipCount = 2,
				mateCount = 440,
				normaldefense = 429,
				desc = "闪避{+89},韧性{+91},格挡{+89}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 52,
				equipCount = 3,
				mateCount = 520,
				normaldefense = 500,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[53] = {
		quality = 3,
		name = "七彩霓裳",
		normalDefenseMax = 62,
		heroExtra = 0,
		normalDefenseGrowMax = 7.68,
		headerImage = "small_qicainichang.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			210,
			304
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+26},韧性{+27}",
				mateCount = 100,
				normaldefense = 71,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				normaldefense = 143,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				normaldefense = 214,
				level = 45
			},
			{
				equipId = 53,
				equipCount = 1,
				mateCount = 280,
				normaldefense = 286,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 53,
				equipCount = 2,
				mateCount = 360,
				normaldefense = 357,
				desc = "装备主将自身普防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 53,
				equipCount = 2,
				mateCount = 440,
				normaldefense = 429,
				desc = "闪避{+87},韧性{+90},格挡{+90}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 53,
				equipCount = 3,
				mateCount = 520,
				normaldefense = 500,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[54] = {
		quality = 3,
		name = "五彩霞衣",
		normalDefenseMax = 63,
		heroExtra = 0,
		normalDefenseGrowMax = 7.23,
		headerImage = "small_wucaixiayi.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			212,
			306
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+27},韧性{+26}",
				mateCount = 100,
				normaldefense = 71,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				normaldefense = 143,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				normaldefense = 214,
				level = 45
			},
			{
				equipId = 54,
				equipCount = 1,
				mateCount = 280,
				normaldefense = 286,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 54,
				equipCount = 2,
				mateCount = 360,
				normaldefense = 357,
				desc = "装备主将自身普防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 54,
				equipCount = 2,
				mateCount = 440,
				normaldefense = 429,
				desc = "闪避{+87},韧性{+89},格挡{+89}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 54,
				equipCount = 3,
				mateCount = 520,
				normaldefense = 500,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[55] = {
		quality = 3,
		name = "龙鳞战甲",
		normalDefenseMax = 65,
		heroExtra = 0,
		normalDefenseGrowMax = 7.45,
		headerImage = "small_longlinzhanjia.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			208,
			206
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+26},韧性{+26}",
				mateCount = 100,
				normaldefense = 71,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				normaldefense = 143,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				normaldefense = 214,
				level = 45
			},
			{
				equipId = 55,
				equipCount = 1,
				mateCount = 280,
				normaldefense = 286,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 55,
				equipCount = 2,
				mateCount = 360,
				normaldefense = 357,
				desc = "装备主将自身普防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 55,
				equipCount = 2,
				mateCount = 440,
				normaldefense = 429,
				desc = "闪避{+86},韧性{+90},格挡{+88}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 55,
				equipCount = 3,
				mateCount = 520,
				normaldefense = 500,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[56] = {
		quality = 3,
		name = "七星宝衣",
		normalDefenseMax = 61,
		heroExtra = 0,
		normalDefenseGrowMax = 7.68,
		headerImage = "small_qixingbaoyi.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			202,
			203
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+27},韧性{+27}",
				mateCount = 100,
				normaldefense = 71,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				normaldefense = 143,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				normaldefense = 214,
				level = 45
			},
			{
				equipId = 56,
				equipCount = 1,
				mateCount = 280,
				normaldefense = 286,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 56,
				equipCount = 2,
				mateCount = 360,
				normaldefense = 357,
				desc = "装备主将自身普防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 56,
				equipCount = 2,
				mateCount = 440,
				normaldefense = 429,
				desc = "闪避{+88},韧性{+90},格挡{+88}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 56,
				equipCount = 3,
				mateCount = 520,
				normaldefense = 500,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[57] = {
		quality = 3,
		name = "九阳战甲",
		normalDefenseMax = 63,
		heroExtra = 0,
		normalDefenseGrowMax = 7.23,
		headerImage = "small_xiyangwushifu.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			311
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+27},韧性{+27}",
				mateCount = 100,
				normaldefense = 71,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				normaldefense = 143,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				normaldefense = 214,
				level = 45
			},
			{
				equipId = 57,
				equipCount = 1,
				mateCount = 280,
				normaldefense = 286,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 57,
				equipCount = 2,
				mateCount = 360,
				normaldefense = 357,
				desc = "装备主将自身普防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 57,
				equipCount = 2,
				mateCount = 440,
				normaldefense = 429,
				desc = "闪避{+91},韧性{+91},格挡{+88}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 57,
				equipCount = 3,
				mateCount = 520,
				normaldefense = 500,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[58] = {
		quality = 3,
		name = "天神战袍",
		normalDefenseMax = 65,
		heroExtra = 0,
		normalDefenseGrowMax = 7.45,
		headerImage = "small_tianshenzhanpao.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			207,
			211
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+26},韧性{+27}",
				mateCount = 100,
				normaldefense = 71,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				normaldefense = 143,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				normaldefense = 214,
				level = 45
			},
			{
				equipId = 58,
				equipCount = 1,
				mateCount = 280,
				normaldefense = 286,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 58,
				equipCount = 2,
				mateCount = 360,
				normaldefense = 357,
				desc = "装备主将自身普防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 58,
				equipCount = 2,
				mateCount = 440,
				normaldefense = 429,
				desc = "闪避{+88},韧性{+87},格挡{+91}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 58,
				equipCount = 3,
				mateCount = 520,
				normaldefense = 500,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[59] = {
		quality = 3,
		name = "金刚战甲",
		normalDefenseMax = 66,
		heroExtra = 0,
		normalDefenseGrowMax = 7.68,
		headerImage = "small_jingangzhanjia.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			204
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+27},韧性{+27}",
				mateCount = 100,
				normaldefense = 71,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				normaldefense = 143,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				normaldefense = 214,
				level = 45
			},
			{
				equipId = 59,
				equipCount = 1,
				mateCount = 280,
				normaldefense = 286,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 59,
				equipCount = 2,
				mateCount = 360,
				normaldefense = 357,
				desc = "装备主将自身普防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 59,
				equipCount = 2,
				mateCount = 440,
				normaldefense = 429,
				desc = "闪避{+88},韧性{+90},格挡{+90}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 59,
				equipCount = 3,
				mateCount = 520,
				normaldefense = 500,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[60] = {
		quality = 3,
		name = "九寒冰甲",
		normalDefenseMax = 62,
		heroExtra = 0,
		normalDefenseGrowMax = 7.15,
		headerImage = "small_jiuhanbingsijia.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			205
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+26},韧性{+26}",
				mateCount = 100,
				normaldefense = 71,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				normaldefense = 143,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				normaldefense = 214,
				level = 45
			},
			{
				equipId = 60,
				equipCount = 1,
				mateCount = 280,
				normaldefense = 286,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 60,
				equipCount = 2,
				mateCount = 360,
				normaldefense = 357,
				desc = "装备主将自身普防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 60,
				equipCount = 2,
				mateCount = 440,
				normaldefense = 429,
				desc = "闪避{+91},韧性{+89},格挡{+89}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 60,
				equipCount = 3,
				mateCount = 520,
				normaldefense = 500,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[61] = {
		quality = 3,
		name = "真龙战甲",
		normalDefenseMax = 63,
		heroExtra = 0,
		normalDefenseGrowMax = 7.38,
		headerImage = "small_zhenlongzhanjia.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			209
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+27},韧性{+26}",
				mateCount = 100,
				normaldefense = 71,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				normaldefense = 143,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				normaldefense = 214,
				level = 45
			},
			{
				equipId = 61,
				equipCount = 1,
				mateCount = 280,
				normaldefense = 286,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 61,
				equipCount = 2,
				mateCount = 360,
				normaldefense = 357,
				desc = "装备主将自身普防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 61,
				equipCount = 2,
				mateCount = 440,
				normaldefense = 429,
				desc = "闪避{+90},韧性{+91},格挡{+91}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 61,
				equipCount = 3,
				mateCount = 520,
				normaldefense = 500,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	{
		profession = 4,
		quality = 1,
		name = "夜行衣",
		normalDefenseMax = 46,
		heroExtra = 0,
		normalDefenseGrowMax = 6.03,
		headerImage = "small_buyi_01.png",
		equipType = EquipType.eClothes,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eRenXing
		}
	},
	[40] = {
		profession = 4,
		quality = 1,
		name = "逸尘衫",
		normalDefenseMax = 43,
		heroExtra = 0,
		normalDefenseGrowMax = 5.62,
		headerImage = "small_buyi_01.png",
		equipType = EquipType.eClothes,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eRenXing
		}
	},
	[42] = {
		profession = 4,
		quality = 1,
		name = "青铜甲",
		normalDefenseMax = 45,
		heroExtra = 0,
		normalDefenseGrowMax = 6.03,
		headerImage = "small_kuijia_01.png",
		equipType = EquipType.eClothes,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eShanBi
		}
	},
	{
		profession = 4,
		quality = 2,
		name = "天蚕衣",
		normalDefenseMax = 52,
		heroExtra = 0,
		normalDefenseGrowMax = 6.56,
		headerImage = "small_buyi_02.png",
		equipType = EquipType.eClothes,
		herosId = {
			402
		},
		feedAttrs = {
			BattleAttrsType.eGeDang,
			BattleAttrsType.eRenXing
		}
	},
	{
		profession = 4,
		quality = 2,
		name = "云锦袍",
		normalDefenseMax = 54,
		heroExtra = 0,
		normalDefenseGrowMax = 6.76,
		headerImage = "small_buyi_02.png",
		equipType = EquipType.eClothes,
		herosId = {
			401
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing
		}
	},
	[41] = {
		profession = 4,
		quality = 2,
		name = "锁子甲",
		normalDefenseMax = 52,
		heroExtra = 0,
		normalDefenseGrowMax = 6.69,
		headerImage = "small_kuijia_02.png",
		equipType = EquipType.eClothes,
		herosId = {
			404
		},
		feedAttrs = {
			BattleAttrsType.eGeDang,
			BattleAttrsType.eShanBi
		}
	},
	[43] = {
		profession = 4,
		quality = 2,
		name = "逍遥衫",
		normalDefenseMax = 51,
		heroExtra = 0,
		normalDefenseGrowMax = 6.49,
		headerImage = "small_buyi_02.png",
		equipType = EquipType.eClothes,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		}
	},
	[45] = {
		profession = 4,
		quality = 2,
		name = "玉露云衫",
		normalDefenseMax = 54,
		heroExtra = 0,
		normalDefenseGrowMax = 6.89,
		headerImage = "small_buyi_02.png",
		equipType = EquipType.eClothes,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eGeDang,
			BattleAttrsType.eShanBi
		}
	},
	[46] = {
		profession = 4,
		quality = 2,
		name = "天罗轻衫",
		normalDefenseMax = 51,
		heroExtra = 0,
		normalDefenseGrowMax = 6.56,
		headerImage = "small_buyi_02.png",
		equipType = EquipType.eClothes,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		}
	},
	[51] = {
		profession = 4,
		quality = 2,
		name = "飞云衫",
		normalDefenseMax = 53,
		heroExtra = 0,
		normalDefenseGrowMax = 6.43,
		headerImage = "small_buyi_02.png",
		equipType = EquipType.eClothes,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eGeDang,
			BattleAttrsType.eShanBi
		}
	},
	[62] = {
		quality = 4,
		name = "玄黄金甲",
		normalDefenseMax = 76,
		heroExtra = 0,
		normalDefenseGrowMax = 9.04,
		headerImage = "small_xuanhuangxuanjinjia.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			103,
			108,
			111
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+66},韧性{+66}",
				mateCount = 200,
				normaldefense = 89,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				normaldefense = 179,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				normaldefense = 268,
				level = 45
			},
			{
				equipId = 62,
				equipCount = 1,
				mateCount = 680,
				normaldefense = 357,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 62,
				equipCount = 1,
				mateCount = 840,
				normaldefense = 447,
				desc = "装备主将自身普防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 62,
				equipCount = 2,
				mateCount = 1000,
				normaldefense = 536,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 62,
				equipCount = 2,
				mateCount = 1160,
				normaldefense = 625,
				desc = "闪避{+201},韧性{+199},格挡{+204}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 62,
				equipCount = 3,
				mateCount = 1320,
				normaldefense = 714,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 62,
				equipCount = 3,
				mateCount = 1480,
				normaldefense = 804,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 62,
				equipCount = 4,
				mateCount = 1640,
				normaldefense = 893,
				desc = "装备主将自身普防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[63] = {
		quality = 4,
		name = "九霄云袍",
		normalDefenseMax = 78,
		heroExtra = 0,
		normalDefenseGrowMax = 8.51,
		headerImage = "small_jiuxiaotengyunpao.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			106,
			110
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+65},韧性{+68}",
				mateCount = 200,
				normaldefense = 89,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				normaldefense = 179,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				normaldefense = 268,
				level = 45
			},
			{
				equipId = 63,
				equipCount = 1,
				mateCount = 680,
				normaldefense = 357,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 63,
				equipCount = 1,
				mateCount = 840,
				normaldefense = 447,
				desc = "装备主将自身普防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 63,
				equipCount = 2,
				mateCount = 1000,
				normaldefense = 536,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 63,
				equipCount = 2,
				mateCount = 1160,
				normaldefense = 625,
				desc = "闪避{+204},韧性{+205},格挡{+196}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 63,
				equipCount = 3,
				mateCount = 1320,
				normaldefense = 714,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 63,
				equipCount = 3,
				mateCount = 1480,
				normaldefense = 804,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 63,
				equipCount = 4,
				mateCount = 1640,
				normaldefense = 893,
				desc = "装备主将自身普防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[64] = {
		quality = 4,
		name = "八卦法衣",
		normalDefenseMax = 73,
		heroExtra = 0,
		normalDefenseGrowMax = 8.68,
		headerImage = "small_baguazishouyi.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			102,
			105
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+66},韧性{+66}",
				mateCount = 200,
				normaldefense = 89,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				normaldefense = 179,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				normaldefense = 268,
				level = 45
			},
			{
				equipId = 64,
				equipCount = 1,
				mateCount = 680,
				normaldefense = 357,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 64,
				equipCount = 1,
				mateCount = 840,
				normaldefense = 447,
				desc = "装备主将自身普防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 64,
				equipCount = 2,
				mateCount = 1000,
				normaldefense = 536,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 64,
				equipCount = 2,
				mateCount = 1160,
				normaldefense = 625,
				desc = "闪避{+195},韧性{+199},格挡{+199}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 64,
				equipCount = 3,
				mateCount = 1320,
				normaldefense = 714,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 64,
				equipCount = 3,
				mateCount = 1480,
				normaldefense = 804,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 64,
				equipCount = 4,
				mateCount = 1640,
				normaldefense = 893,
				desc = "装备主将自身普防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[65] = {
		quality = 4,
		name = "无极道袍",
		normalDefenseMax = 75,
		heroExtra = 0,
		normalDefenseGrowMax = 8.95,
		headerImage = "small_taishangwujipao.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			104,
			107
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+69},韧性{+68}",
				mateCount = 200,
				normaldefense = 89,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				normaldefense = 179,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				normaldefense = 268,
				level = 45
			},
			{
				equipId = 65,
				equipCount = 1,
				mateCount = 680,
				normaldefense = 357,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 65,
				equipCount = 1,
				mateCount = 840,
				normaldefense = 447,
				desc = "装备主将自身普防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 65,
				equipCount = 2,
				mateCount = 1000,
				normaldefense = 536,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 65,
				equipCount = 2,
				mateCount = 1160,
				normaldefense = 625,
				desc = "闪避{+195},韧性{+204},格挡{+203}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 65,
				equipCount = 3,
				mateCount = 1320,
				normaldefense = 714,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 65,
				equipCount = 3,
				mateCount = 1480,
				normaldefense = 804,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 65,
				equipCount = 4,
				mateCount = 1640,
				normaldefense = 893,
				desc = "装备主将自身普防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[66] = {
		quality = 4,
		name = "冥界战铠",
		normalDefenseMax = 77,
		heroExtra = 0,
		normalDefenseGrowMax = 9.21,
		headerImage = "small_mingjiezhanshenkai.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			109
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+66},韧性{+67}",
				mateCount = 200,
				normaldefense = 89,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				normaldefense = 179,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				normaldefense = 268,
				level = 45
			},
			{
				equipId = 66,
				equipCount = 1,
				mateCount = 680,
				normaldefense = 357,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 66,
				equipCount = 1,
				mateCount = 840,
				normaldefense = 447,
				desc = "装备主将自身普防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 66,
				equipCount = 2,
				mateCount = 1000,
				normaldefense = 536,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 66,
				equipCount = 2,
				mateCount = 1160,
				normaldefense = 625,
				desc = "闪避{+202},韧性{+205},格挡{+196}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 66,
				equipCount = 3,
				mateCount = 1320,
				normaldefense = 714,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 66,
				equipCount = 3,
				mateCount = 1480,
				normaldefense = 804,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 66,
				equipCount = 4,
				mateCount = 1640,
				normaldefense = 893,
				desc = "装备主将自身普防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[67] = {
		quality = 4,
		name = "天尊神铠",
		normalDefenseMax = 78,
		heroExtra = 0,
		normalDefenseGrowMax = 8.59,
		headerImage = "small_tianzunyushenkai.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+66},韧性{+67}",
				mateCount = 200,
				normaldefense = 89,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				normaldefense = 179,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				normaldefense = 268,
				level = 45
			},
			{
				equipId = 67,
				equipCount = 1,
				mateCount = 680,
				normaldefense = 357,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 67,
				equipCount = 1,
				mateCount = 840,
				normaldefense = 447,
				desc = "装备主将自身普防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 67,
				equipCount = 2,
				mateCount = 1000,
				normaldefense = 536,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 67,
				equipCount = 2,
				mateCount = 1160,
				normaldefense = 625,
				desc = "闪避{+199},韧性{+194},格挡{+203}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 67,
				equipCount = 3,
				mateCount = 1320,
				normaldefense = 714,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 67,
				equipCount = 3,
				mateCount = 1480,
				normaldefense = 804,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 67,
				equipCount = 4,
				mateCount = 1640,
				normaldefense = 893,
				desc = "装备主将自身普防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[68] = {
		quality = 4,
		name = "九天帝袍",
		normalDefenseMax = 73,
		heroExtra = 0,
		normalDefenseGrowMax = 8.86,
		headerImage = "small_jiutiandiwangpao.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			101
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+66},韧性{+66}",
				mateCount = 200,
				normaldefense = 89,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				normaldefense = 179,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				normaldefense = 268,
				level = 45
			},
			{
				equipId = 68,
				equipCount = 1,
				mateCount = 680,
				normaldefense = 357,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 68,
				equipCount = 1,
				mateCount = 840,
				normaldefense = 447,
				desc = "装备主将自身普防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 68,
				equipCount = 2,
				mateCount = 1000,
				normaldefense = 536,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 68,
				equipCount = 2,
				mateCount = 1160,
				normaldefense = 625,
				desc = "闪避{+200},韧性{+203},格挡{+200}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 68,
				equipCount = 3,
				mateCount = 1320,
				normaldefense = 714,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 68,
				equipCount = 3,
				mateCount = 1480,
				normaldefense = 804,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 68,
				equipCount = 4,
				mateCount = 1640,
				normaldefense = 893,
				desc = "装备主将自身普防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[69] = {
		profession = 4,
		quality = 1,
		skillDefenseGrowMax = 11.94,
		skillDefenseMax = 89,
		heroExtra = 0,
		name = "锦帽",
		headerImage = "small_toukui_03.png",
		equipType = EquipType.eHelmet,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eRenXing
		}
	},
	[70] = {
		profession = 4,
		quality = 2,
		skillDefenseGrowMax = 12.72,
		skillDefenseMax = 108,
		heroExtra = 0,
		name = "狐皮帽",
		headerImage = "small_toukui_03.png",
		equipType = EquipType.eHelmet,
		herosId = {
			406
		},
		feedAttrs = {
			BattleAttrsType.eGeDang,
			BattleAttrsType.eRenXing
		}
	},
	[71] = {
		profession = 4,
		quality = 1,
		skillDefenseGrowMax = 11.48,
		skillDefenseMax = 92,
		heroExtra = 0,
		name = "明珠帽",
		headerImage = "small_toukui_03.png",
		equipType = EquipType.eHelmet,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eShanBi
		}
	},
	[72] = {
		profession = 4,
		quality = 1,
		skillDefenseGrowMax = 11.71,
		skillDefenseMax = 86,
		heroExtra = 0,
		name = "青铜盔",
		headerImage = "small_toukui_04.png",
		equipType = EquipType.eHelmet,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eRenXing
		}
	},
	[73] = {
		profession = 4,
		quality = 2,
		skillDefenseGrowMax = 13.78,
		skillDefenseMax = 105,
		heroExtra = 0,
		name = "乌木簪",
		headerImage = "small_toukui_01.png",
		equipType = EquipType.eHelmet,
		herosId = {
			402
		},
		feedAttrs = {
			BattleAttrsType.eGeDang,
			BattleAttrsType.eShanBi
		}
	},
	[74] = {
		profession = 4,
		quality = 2,
		skillDefenseGrowMax = 12.85,
		skillDefenseMax = 108,
		heroExtra = 0,
		name = "碧夜簪",
		headerImage = "small_toukui_01.png",
		equipType = EquipType.eHelmet,
		herosId = {
			401,
			405
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing
		}
	},
	[75] = {
		profession = 4,
		quality = 2,
		skillDefenseGrowMax = 13.25,
		skillDefenseMax = 110,
		heroExtra = 0,
		name = "逍遥盔",
		headerImage = "small_toukui_02.png",
		equipType = EquipType.eHelmet,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		}
	},
	[76] = {
		profession = 4,
		quality = 2,
		skillDefenseGrowMax = 13.51,
		skillDefenseMax = 102,
		heroExtra = 0,
		name = "天魁帽",
		headerImage = "small_toukui_04.png",
		equipType = EquipType.eHelmet,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eRenXing,
			BattleAttrsType.eShanBi
		}
	},
	[77] = {
		quality = 3,
		skillDefenseGrowMax = 15.5,
		skillDefenseMax = 127,
		heroExtra = 0,
		name = "幻星帽",
		headerImage = "small_huanxingmao.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			301,
			304
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+26},韧性{+27}",
				mateCount = 100,
				skilldefense = 143,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				skilldefense = 286,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				skilldefense = 429,
				level = 45
			},
			{
				equipId = 77,
				equipCount = 1,
				mateCount = 280,
				skilldefense = 572,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 77,
				equipCount = 2,
				mateCount = 360,
				skilldefense = 714,
				desc = "装备主将自身法防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 77,
				equipCount = 2,
				mateCount = 440,
				skilldefense = 857,
				desc = "闪避{+90},韧性{+86},格挡{+90}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 77,
				equipCount = 3,
				mateCount = 520,
				skilldefense = 1000,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[78] = {
		quality = 3,
		skillDefenseGrowMax = 14.46,
		skillDefenseMax = 129,
		heroExtra = 0,
		name = "太极帽",
		headerImage = "small_taijimao.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			305
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+27},韧性{+26}",
				mateCount = 100,
				skilldefense = 143,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				skilldefense = 286,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				skilldefense = 429,
				level = 45
			},
			{
				equipId = 78,
				equipCount = 1,
				mateCount = 280,
				skilldefense = 572,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 78,
				equipCount = 2,
				mateCount = 360,
				skilldefense = 714,
				desc = "装备主将自身法防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 78,
				equipCount = 2,
				mateCount = 440,
				skilldefense = 857,
				desc = "闪避{+88},韧性{+87},格挡{+91}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 78,
				equipCount = 3,
				mateCount = 520,
				skilldefense = 1000,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[79] = {
		quality = 3,
		skillDefenseGrowMax = 14.76,
		skillDefenseMax = 132,
		heroExtra = 0,
		name = "天师帽",
		headerImage = "small_tianshimao.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			302
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+27},韧性{+26}",
				mateCount = 100,
				skilldefense = 143,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				skilldefense = 286,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				skilldefense = 429,
				level = 45
			},
			{
				equipId = 79,
				equipCount = 1,
				mateCount = 280,
				skilldefense = 572,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 79,
				equipCount = 2,
				mateCount = 360,
				skilldefense = 714,
				desc = "装备主将自身法防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 79,
				equipCount = 2,
				mateCount = 440,
				skilldefense = 857,
				desc = "闪避{+89},韧性{+90},格挡{+88}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 79,
				equipCount = 3,
				mateCount = 520,
				skilldefense = 1000,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[80] = {
		quality = 3,
		skillDefenseGrowMax = 15.05,
		skillDefenseMax = 123,
		heroExtra = 0,
		name = "杀神盔",
		headerImage = "small_shashenkui.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			303,
			308
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+26},韧性{+26}",
				mateCount = 100,
				skilldefense = 143,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				skilldefense = 286,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				skilldefense = 429,
				level = 45
			},
			{
				equipId = 80,
				equipCount = 1,
				mateCount = 280,
				skilldefense = 572,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 80,
				equipCount = 2,
				mateCount = 360,
				skilldefense = 714,
				desc = "装备主将自身法防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 80,
				equipCount = 2,
				mateCount = 440,
				skilldefense = 857,
				desc = "闪避{+89},韧性{+91},格挡{+88}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 80,
				equipCount = 3,
				mateCount = 520,
				skilldefense = 1000,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[81] = {
		profession = 4,
		quality = 2,
		skillDefenseGrowMax = 13.78,
		skillDefenseMax = 103,
		heroExtra = 0,
		name = "白银冠",
		headerImage = "small_toukui_02.png",
		equipType = EquipType.eHelmet,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		}
	},
	[82] = {
		quality = 3,
		skillDefenseGrowMax = 14.46,
		skillDefenseMax = 128,
		heroExtra = 0,
		name = "通灵冠",
		headerImage = "small_tonglingguan.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			307
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+27},韧性{+27}",
				mateCount = 100,
				skilldefense = 143,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				skilldefense = 286,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				skilldefense = 429,
				level = 45
			},
			{
				equipId = 82,
				equipCount = 1,
				mateCount = 280,
				skilldefense = 572,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 82,
				equipCount = 2,
				mateCount = 360,
				skilldefense = 714,
				desc = "装备主将自身法防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 82,
				equipCount = 2,
				mateCount = 440,
				skilldefense = 857,
				desc = "闪避{+87},韧性{+91},格挡{+87}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 82,
				equipCount = 3,
				mateCount = 520,
				skilldefense = 1000,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[83] = {
		quality = 3,
		skillDefenseGrowMax = 14.76,
		skillDefenseMax = 130,
		heroExtra = 0,
		name = "飞云冠",
		headerImage = "small_feiyunguan.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			306
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+26},韧性{+26}",
				mateCount = 100,
				skilldefense = 143,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				skilldefense = 286,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				skilldefense = 429,
				level = 45
			},
			{
				equipId = 83,
				equipCount = 1,
				mateCount = 280,
				skilldefense = 572,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 83,
				equipCount = 2,
				mateCount = 360,
				skilldefense = 714,
				desc = "装备主将自身法防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 83,
				equipCount = 2,
				mateCount = 440,
				skilldefense = 857,
				desc = "闪避{+90},韧性{+91},格挡{+91}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 83,
				equipCount = 3,
				mateCount = 520,
				skilldefense = 1000,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[84] = {
		quality = 3,
		skillDefenseGrowMax = 15.2,
		skillDefenseMax = 133,
		heroExtra = 0,
		name = "紫金冠",
		headerImage = "small_zijinguan.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			203,
			309
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+26},韧性{+27}",
				mateCount = 100,
				skilldefense = 143,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				skilldefense = 286,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				skilldefense = 429,
				level = 45
			},
			{
				equipId = 84,
				equipCount = 1,
				mateCount = 280,
				skilldefense = 572,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 84,
				equipCount = 2,
				mateCount = 360,
				skilldefense = 714,
				desc = "装备主将自身法防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 84,
				equipCount = 2,
				mateCount = 440,
				skilldefense = 857,
				desc = "闪避{+87},韧性{+91},格挡{+89}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 84,
				equipCount = 3,
				mateCount = 520,
				skilldefense = 1000,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[85] = {
		quality = 3,
		skillDefenseGrowMax = 15.5,
		skillDefenseMax = 124,
		heroExtra = 0,
		name = "玉龙冠",
		headerImage = "small_yulongguan.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			201
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+27},韧性{+27}",
				mateCount = 100,
				skilldefense = 143,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				skilldefense = 286,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				skilldefense = 429,
				level = 45
			},
			{
				equipId = 85,
				equipCount = 1,
				mateCount = 280,
				skilldefense = 572,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 85,
				equipCount = 2,
				mateCount = 360,
				skilldefense = 714,
				desc = "装备主将自身法防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 85,
				equipCount = 2,
				mateCount = 440,
				skilldefense = 857,
				desc = "闪避{+88},韧性{+91},格挡{+89}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 85,
				equipCount = 3,
				mateCount = 520,
				skilldefense = 1000,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[86] = {
		quality = 3,
		skillDefenseGrowMax = 14.46,
		skillDefenseMax = 127,
		heroExtra = 0,
		name = "羲和冠",
		headerImage = "small_xiheguan.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			202,
			205
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+27},韧性{+27}",
				mateCount = 100,
				skilldefense = 143,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				skilldefense = 286,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				skilldefense = 429,
				level = 45
			},
			{
				equipId = 86,
				equipCount = 1,
				mateCount = 280,
				skilldefense = 572,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 86,
				equipCount = 2,
				mateCount = 360,
				skilldefense = 714,
				desc = "装备主将自身法防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 86,
				equipCount = 2,
				mateCount = 440,
				skilldefense = 857,
				desc = "闪避{+90},韧性{+87},格挡{+88}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 86,
				equipCount = 3,
				mateCount = 520,
				skilldefense = 1000,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[87] = {
		quality = 3,
		skillDefenseGrowMax = 14.76,
		skillDefenseMax = 129,
		heroExtra = 0,
		name = "大圣冠",
		headerImage = "small_dashengguan.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			207,
			208
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+26},韧性{+27}",
				mateCount = 100,
				skilldefense = 143,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				skilldefense = 286,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				skilldefense = 429,
				level = 45
			},
			{
				equipId = 87,
				equipCount = 1,
				mateCount = 280,
				skilldefense = 572,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 87,
				equipCount = 2,
				mateCount = 360,
				skilldefense = 714,
				desc = "装备主将自身法防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 87,
				equipCount = 2,
				mateCount = 440,
				skilldefense = 857,
				desc = "闪避{+90},韧性{+90},格挡{+87}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 87,
				equipCount = 3,
				mateCount = 520,
				skilldefense = 1000,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[88] = {
		quality = 3,
		skillDefenseGrowMax = 15.2,
		skillDefenseMax = 132,
		heroExtra = 0,
		name = "青龙冠",
		headerImage = "small_qinglongguan.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			209
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+27},韧性{+26}",
				mateCount = 100,
				skilldefense = 143,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				skilldefense = 286,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				skilldefense = 429,
				level = 45
			},
			{
				equipId = 88,
				equipCount = 1,
				mateCount = 280,
				skilldefense = 572,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 88,
				equipCount = 2,
				mateCount = 360,
				skilldefense = 714,
				desc = "装备主将自身法防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 88,
				equipCount = 2,
				mateCount = 440,
				skilldefense = 857,
				desc = "闪避{+90},韧性{+91},格挡{+89}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 88,
				equipCount = 3,
				mateCount = 520,
				skilldefense = 1000,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[89] = {
		quality = 3,
		skillDefenseGrowMax = 15.5,
		skillDefenseMax = 123,
		heroExtra = 0,
		name = "白虎冠",
		headerImage = "small_baihuguan.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			310
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+27},韧性{+27}",
				mateCount = 100,
				skilldefense = 143,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				skilldefense = 286,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				skilldefense = 429,
				level = 45
			},
			{
				equipId = 89,
				equipCount = 1,
				mateCount = 280,
				skilldefense = 572,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 89,
				equipCount = 2,
				mateCount = 360,
				skilldefense = 714,
				desc = "装备主将自身法防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 89,
				equipCount = 2,
				mateCount = 440,
				skilldefense = 857,
				desc = "闪避{+87},韧性{+87},格挡{+89}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 89,
				equipCount = 3,
				mateCount = 520,
				skilldefense = 1000,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[90] = {
		quality = 3,
		skillDefenseGrowMax = 14.46,
		skillDefenseMax = 125,
		heroExtra = 0,
		name = "朱雀冠",
		headerImage = "small_zhuqueguan.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			206
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+27},韧性{+27}",
				mateCount = 100,
				skilldefense = 143,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				skilldefense = 286,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				skilldefense = 429,
				level = 45
			},
			{
				equipId = 90,
				equipCount = 1,
				mateCount = 280,
				skilldefense = 572,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 90,
				equipCount = 2,
				mateCount = 360,
				skilldefense = 714,
				desc = "装备主将自身法防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 90,
				equipCount = 2,
				mateCount = 440,
				skilldefense = 857,
				desc = "闪避{+88},韧性{+87},格挡{+88}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 90,
				equipCount = 3,
				mateCount = 520,
				skilldefense = 1000,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[91] = {
		quality = 3,
		skillDefenseGrowMax = 14.76,
		skillDefenseMax = 127,
		heroExtra = 0,
		name = "玄武冠",
		headerImage = "small_xuanwuguan.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			311
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+27},韧性{+27}",
				mateCount = 100,
				skilldefense = 143,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				skilldefense = 286,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				skilldefense = 429,
				level = 45
			},
			{
				equipId = 91,
				equipCount = 1,
				mateCount = 280,
				skilldefense = 572,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 91,
				equipCount = 2,
				mateCount = 360,
				skilldefense = 714,
				desc = "装备主将自身法防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 91,
				equipCount = 2,
				mateCount = 440,
				skilldefense = 857,
				desc = "闪避{+88},韧性{+90},格挡{+87}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 91,
				equipCount = 3,
				mateCount = 520,
				skilldefense = 1000,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[92] = {
		quality = 3,
		skillDefenseGrowMax = 15.05,
		skillDefenseMax = 129,
		heroExtra = 0,
		name = "麒麟冠",
		headerImage = "small_qilinguan.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			204,
			211
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+26},韧性{+27}",
				mateCount = 100,
				skilldefense = 143,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				skilldefense = 286,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				skilldefense = 429,
				level = 45
			},
			{
				equipId = 92,
				equipCount = 1,
				mateCount = 280,
				skilldefense = 572,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 92,
				equipCount = 2,
				mateCount = 360,
				skilldefense = 714,
				desc = "装备主将自身法防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 92,
				equipCount = 2,
				mateCount = 440,
				skilldefense = 857,
				desc = "闪避{+87},韧性{+87},格挡{+89}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 92,
				equipCount = 3,
				mateCount = 520,
				skilldefense = 1000,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[93] = {
		quality = 3,
		skillDefenseGrowMax = 15.35,
		skillDefenseMax = 132,
		heroExtra = 0,
		name = "凤翅冠",
		headerImage = "small_fengchiguan.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			210,
			212
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+27},韧性{+27}",
				mateCount = 100,
				skilldefense = 143,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				skilldefense = 286,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				skilldefense = 429,
				level = 45
			},
			{
				equipId = 93,
				equipCount = 1,
				mateCount = 280,
				skilldefense = 572,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 93,
				equipCount = 2,
				mateCount = 360,
				skilldefense = 714,
				desc = "装备主将自身法防提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 93,
				equipCount = 2,
				mateCount = 440,
				skilldefense = 857,
				desc = "闪避{+87},韧性{+91},格挡{+89}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 93,
				equipCount = 3,
				mateCount = 520,
				skilldefense = 1000,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[94] = {
		quality = 4,
		skillDefenseGrowMax = 17.19,
		skillDefenseMax = 144,
		heroExtra = 0,
		name = "玄冥鬼冕",
		headerImage = "small_xuanmingshenxianmian.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			105
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+65},韧性{+67}",
				mateCount = 200,
				skilldefense = 179,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				skilldefense = 357,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				skilldefense = 536,
				level = 45
			},
			{
				equipId = 94,
				equipCount = 1,
				mateCount = 680,
				skilldefense = 714,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 94,
				equipCount = 1,
				mateCount = 840,
				skilldefense = 893,
				desc = "装备主将自身法防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 94,
				equipCount = 2,
				mateCount = 1000,
				skilldefense = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 94,
				equipCount = 2,
				mateCount = 1160,
				skilldefense = 1250,
				desc = "闪避{+194},韧性{+201},格挡{+200}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 94,
				equipCount = 3,
				mateCount = 1320,
				skilldefense = 1429,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 94,
				equipCount = 3,
				mateCount = 1480,
				skilldefense = 1608,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 94,
				equipCount = 4,
				mateCount = 1640,
				skilldefense = 1786,
				desc = "装备主将自身法防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[95] = {
		quality = 4,
		skillDefenseGrowMax = 17.54,
		skillDefenseMax = 147,
		heroExtra = 0,
		name = "九天帝冕",
		headerImage = "small_jiutiandiwangmian.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			101,
			108
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+66},韧性{+65}",
				mateCount = 200,
				skilldefense = 179,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				skilldefense = 357,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				skilldefense = 536,
				level = 45
			},
			{
				equipId = 95,
				equipCount = 1,
				mateCount = 680,
				skilldefense = 714,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 95,
				equipCount = 1,
				mateCount = 840,
				skilldefense = 893,
				desc = "装备主将自身法防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 95,
				equipCount = 2,
				mateCount = 1000,
				skilldefense = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 95,
				equipCount = 2,
				mateCount = 1160,
				skilldefense = 1250,
				desc = "闪避{+202},韧性{+198},格挡{+199}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 95,
				equipCount = 3,
				mateCount = 1320,
				skilldefense = 1429,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 95,
				equipCount = 3,
				mateCount = 1480,
				skilldefense = 1608,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 95,
				equipCount = 4,
				mateCount = 1640,
				skilldefense = 1786,
				desc = "装备主将自身法防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[96] = {
		quality = 4,
		skillDefenseGrowMax = 17.9,
		skillDefenseMax = 150,
		heroExtra = 0,
		name = "无极道冕",
		headerImage = "small_wujitianwangmian.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			102
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+65},韧性{+68}",
				mateCount = 200,
				skilldefense = 179,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				skilldefense = 357,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				skilldefense = 536,
				level = 45
			},
			{
				equipId = 96,
				equipCount = 1,
				mateCount = 680,
				skilldefense = 714,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 96,
				equipCount = 1,
				mateCount = 840,
				skilldefense = 893,
				desc = "装备主将自身法防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 96,
				equipCount = 2,
				mateCount = 1000,
				skilldefense = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 96,
				equipCount = 2,
				mateCount = 1160,
				skilldefense = 1250,
				desc = "闪避{+196},韧性{+194},格挡{+195}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 96,
				equipCount = 3,
				mateCount = 1320,
				skilldefense = 1429,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 96,
				equipCount = 3,
				mateCount = 1480,
				skilldefense = 1608,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 96,
				equipCount = 4,
				mateCount = 1640,
				skilldefense = 1786,
				desc = "装备主将自身法防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[97] = {
		quality = 4,
		skillDefenseGrowMax = 18.25,
		skillDefenseMax = 152,
		heroExtra = 0,
		name = "逍遥仙冕",
		headerImage = "small_xiaoyaotianxianmian.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			103,
			106
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+67},韧性{+66}",
				mateCount = 200,
				skilldefense = 179,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				skilldefense = 357,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				skilldefense = 536,
				level = 45
			},
			{
				equipId = 97,
				equipCount = 1,
				mateCount = 680,
				skilldefense = 714,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 97,
				equipCount = 1,
				mateCount = 840,
				skilldefense = 893,
				desc = "装备主将自身法防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 97,
				equipCount = 2,
				mateCount = 1000,
				skilldefense = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 97,
				equipCount = 2,
				mateCount = 1160,
				skilldefense = 1250,
				desc = "闪避{+205},韧性{+206},格挡{+202}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 97,
				equipCount = 3,
				mateCount = 1320,
				skilldefense = 1429,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 97,
				equipCount = 3,
				mateCount = 1480,
				skilldefense = 1608,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 97,
				equipCount = 4,
				mateCount = 1640,
				skilldefense = 1786,
				desc = "装备主将自身法防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[98] = {
		quality = 4,
		skillDefenseGrowMax = 17.01,
		skillDefenseMax = 155,
		heroExtra = 0,
		name = "修罗魔冕",
		headerImage = "small_mozunxiuluomian.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			109
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+68},韧性{+66}",
				mateCount = 200,
				skilldefense = 179,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				skilldefense = 357,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				skilldefense = 536,
				level = 45
			},
			{
				equipId = 98,
				equipCount = 1,
				mateCount = 680,
				skilldefense = 714,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 98,
				equipCount = 1,
				mateCount = 840,
				skilldefense = 893,
				desc = "装备主将自身法防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 98,
				equipCount = 2,
				mateCount = 1000,
				skilldefense = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 98,
				equipCount = 2,
				mateCount = 1160,
				skilldefense = 1250,
				desc = "闪避{+203},韧性{+203},格挡{+195}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 98,
				equipCount = 3,
				mateCount = 1320,
				skilldefense = 1429,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 98,
				equipCount = 3,
				mateCount = 1480,
				skilldefense = 1608,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 98,
				equipCount = 4,
				mateCount = 1640,
				skilldefense = 1786,
				desc = "装备主将自身法防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[99] = {
		quality = 4,
		skillDefenseGrowMax = 17.37,
		skillDefenseMax = 144,
		heroExtra = 0,
		name = "云霄天冕",
		headerImage = "small_tengyunchongtianmian.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			104,
			107
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+66},韧性{+68}",
				mateCount = 200,
				skilldefense = 179,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				skilldefense = 357,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				skilldefense = 536,
				level = 45
			},
			{
				equipId = 99,
				equipCount = 1,
				mateCount = 680,
				skilldefense = 714,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 99,
				equipCount = 1,
				mateCount = 840,
				skilldefense = 893,
				desc = "装备主将自身法防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 99,
				equipCount = 2,
				mateCount = 1000,
				skilldefense = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 99,
				equipCount = 2,
				mateCount = 1160,
				skilldefense = 1250,
				desc = "闪避{+199},韧性{+205},格挡{+195}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 99,
				equipCount = 3,
				mateCount = 1320,
				skilldefense = 1429,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 99,
				equipCount = 3,
				mateCount = 1480,
				skilldefense = 1608,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 99,
				equipCount = 4,
				mateCount = 1640,
				skilldefense = 1786,
				desc = "装备主将自身法防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[100] = {
		quality = 4,
		skillDefenseGrowMax = 17.72,
		skillDefenseMax = 146,
		heroExtra = 0,
		name = "万妖神冕",
		headerImage = "small_wanyaowanshenmian.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			110,
			111
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+67},韧性{+67}",
				mateCount = 200,
				skilldefense = 179,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				skilldefense = 357,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				skilldefense = 536,
				level = 45
			},
			{
				equipId = 100,
				equipCount = 1,
				mateCount = 680,
				skilldefense = 714,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 100,
				equipCount = 1,
				mateCount = 840,
				skilldefense = 893,
				desc = "装备主将自身法防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 100,
				equipCount = 2,
				mateCount = 1000,
				skilldefense = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 100,
				equipCount = 2,
				mateCount = 1160,
				skilldefense = 1250,
				desc = "闪避{+196},韧性{+198},格挡{+201}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 100,
				equipCount = 3,
				mateCount = 1320,
				skilldefense = 1429,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 100,
				equipCount = 3,
				mateCount = 1480,
				skilldefense = 1608,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 100,
				equipCount = 4,
				mateCount = 1640,
				skilldefense = 1786,
				desc = "装备主将自身法防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[101] = {
		profession = 4,
		quality = 1,
		healthGrowMax = 70.95,
		name = "青铜戒",
		heroExtra = 0,
		headerImage = "small_jiezhi_03.png",
		healthMax = 523,
		equipType = EquipType.eRing,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eGeDang
		}
	},
	[102] = {
		profession = 4,
		quality = 2,
		healthGrowMax = 82.67,
		name = "乌木戒",
		heroExtra = 0,
		headerImage = "small_jiezhi_03.png",
		healthMax = 633,
		equipType = EquipType.eRing,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing
		}
	},
	[103] = {
		profession = 4,
		quality = 2,
		healthGrowMax = 77.11,
		name = "檀香戒",
		heroExtra = 0,
		headerImage = "small_jiezhi_04.png",
		healthMax = 646,
		equipType = EquipType.eRing,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eGeDang,
			BattleAttrsType.eRenXing
		}
	},
	[104] = {
		profession = 4,
		quality = 1,
		healthGrowMax = 68.86,
		name = "铁戒指",
		heroExtra = 0,
		headerImage = "small_jiezhi_02.png",
		healthMax = 555,
		equipType = EquipType.eRing,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eRenXing
		}
	},
	[105] = {
		profession = 4,
		quality = 1,
		healthGrowMax = 70.25,
		name = "质石戒",
		heroExtra = 0,
		headerImage = "small_jiezhi_01.png",
		healthMax = 512,
		equipType = EquipType.eRing,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eShanBi
		}
	},
	[106] = {
		profession = 4,
		quality = 2,
		healthGrowMax = 81.88,
		name = "阴阳戒",
		heroExtra = 0,
		headerImage = "small_jiezhi_04.png",
		healthMax = 621,
		equipType = EquipType.eRing,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eGeDang
		}
	},
	[107] = {
		quality = 3,
		healthGrowMax = 85.85,
		name = "金光戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_jinguangjie.png",
		healthMax = 767,
		equipType = EquipType.eRing,
		herosId = {
			302,
			305
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				desc = "闪避{+26},格挡{+27}",
				mateCount = 100,
				health = 857,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				health = 1715,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				health = 2572,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 107,
				equipCount = 1,
				mateCount = 280,
				health = 3429,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 107,
				equipCount = 2,
				mateCount = 360,
				health = 4287,
				desc = "装备主将自身生命提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 107,
				equipCount = 2,
				mateCount = 440,
				health = 5144,
				desc = "闪避{+88},韧性{+88},格挡{+89}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 107,
				equipCount = 3,
				mateCount = 520,
				health = 6002,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[108] = {
		profession = 4,
		quality = 2,
		healthGrowMax = 77.9,
		name = "烂银戒",
		heroExtra = 0,
		headerImage = "small_jiezhi_02.png",
		healthMax = 640,
		equipType = EquipType.eRing,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eGeDang,
			BattleAttrsType.eRenXing
		}
	},
	[109] = {
		quality = 3,
		healthGrowMax = 89.43,
		name = "青云戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_qingyunjie.png",
		healthMax = 790,
		equipType = EquipType.eRing,
		herosId = {
			307,
			308
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				desc = "闪避{+26},格挡{+27}",
				mateCount = 100,
				health = 857,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				health = 1715,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				health = 2572,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 109,
				equipCount = 1,
				mateCount = 280,
				health = 3429,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 109,
				equipCount = 2,
				mateCount = 360,
				health = 4287,
				desc = "装备主将自身生命提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 109,
				equipCount = 2,
				mateCount = 440,
				health = 5144,
				desc = "闪避{+88},韧性{+87},格挡{+88}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 109,
				equipCount = 3,
				mateCount = 520,
				health = 6002,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[110] = {
		quality = 3,
		healthGrowMax = 91.22,
		name = "如意戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_ruyijie.png",
		healthMax = 736,
		equipType = EquipType.eRing,
		herosId = {
			306
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				desc = "闪避{+27},格挡{+27}",
				mateCount = 100,
				health = 857,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				health = 1715,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				health = 2572,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 110,
				equipCount = 1,
				mateCount = 280,
				health = 3429,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 110,
				equipCount = 2,
				mateCount = 360,
				health = 4287,
				desc = "装备主将自身生命提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 110,
				equipCount = 2,
				mateCount = 440,
				health = 5144,
				desc = "闪避{+89},韧性{+89},格挡{+91}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 110,
				equipCount = 3,
				mateCount = 520,
				health = 6002,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[111] = {
		quality = 3,
		healthGrowMax = 93.01,
		name = "玄女戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_xuannvjie.png",
		healthMax = 744,
		equipType = EquipType.eRing,
		herosId = {
			301
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				desc = "闪避{+26},格挡{+26}",
				mateCount = 100,
				health = 857,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				health = 1715,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				health = 2572,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 111,
				equipCount = 1,
				mateCount = 280,
				health = 3429,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 111,
				equipCount = 2,
				mateCount = 360,
				health = 4287,
				desc = "装备主将自身生命提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 111,
				equipCount = 2,
				mateCount = 440,
				health = 5144,
				desc = "闪避{+88},韧性{+88},格挡{+89}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 111,
				equipCount = 3,
				mateCount = 520,
				health = 6002,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[112] = {
		quality = 3,
		healthGrowMax = 86.75,
		name = "七宝戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_qibaojie.png",
		healthMax = 759,
		equipType = EquipType.eRing,
		herosId = {
			311
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				desc = "闪避{+26},格挡{+27}",
				mateCount = 100,
				health = 857,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				health = 1715,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				health = 2572,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 112,
				equipCount = 1,
				mateCount = 280,
				health = 3429,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 112,
				equipCount = 2,
				mateCount = 360,
				health = 4287,
				desc = "装备主将自身生命提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 112,
				equipCount = 2,
				mateCount = 440,
				health = 5144,
				desc = "闪避{+87},韧性{+91},格挡{+90}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 112,
				equipCount = 3,
				mateCount = 520,
				health = 6002,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[113] = {
		quality = 3,
		healthGrowMax = 87.64,
		name = "霹魂戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_pihunjie.png",
		healthMax = 774,
		equipType = EquipType.eRing,
		herosId = {
			303,
			310
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				desc = "闪避{+26},格挡{+27}",
				mateCount = 100,
				health = 857,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				health = 1715,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				health = 2572,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 113,
				equipCount = 1,
				mateCount = 280,
				health = 3429,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 113,
				equipCount = 2,
				mateCount = 360,
				health = 4287,
				desc = "装备主将自身生命提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 113,
				equipCount = 2,
				mateCount = 440,
				health = 5144,
				desc = "闪避{+91},韧性{+89},格挡{+90}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 113,
				equipCount = 3,
				mateCount = 520,
				health = 6002,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[114] = {
		quality = 3,
		healthGrowMax = 89.43,
		name = "金刚戒指",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_jingangjiezhi.png",
		healthMax = 782,
		equipType = EquipType.eRing,
		herosId = {
			304
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				desc = "闪避{+27},格挡{+26}",
				mateCount = 100,
				health = 857,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				health = 1715,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				health = 2572,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 114,
				equipCount = 1,
				mateCount = 280,
				health = 3429,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 114,
				equipCount = 2,
				mateCount = 360,
				health = 4287,
				desc = "装备主将自身生命提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 114,
				equipCount = 2,
				mateCount = 440,
				health = 5144,
				desc = "闪避{+90},韧性{+88},格挡{+88}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 114,
				equipCount = 3,
				mateCount = 520,
				health = 6002,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[115] = {
		quality = 3,
		healthGrowMax = 91.22,
		name = "回魂戒指",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_huihunjiezhi.png",
		healthMax = 797,
		equipType = EquipType.eRing,
		herosId = {
			206,
			208
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				desc = "闪避{+27},格挡{+26}",
				mateCount = 100,
				health = 857,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				health = 1715,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				health = 2572,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 115,
				equipCount = 1,
				mateCount = 280,
				health = 3429,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 115,
				equipCount = 2,
				mateCount = 360,
				health = 4287,
				desc = "装备主将自身生命提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 115,
				equipCount = 2,
				mateCount = 440,
				health = 5144,
				desc = "闪避{+91},韧性{+90},格挡{+91}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 115,
				equipCount = 3,
				mateCount = 520,
				health = 6002,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[116] = {
		quality = 3,
		healthGrowMax = 93.01,
		name = "定魂戒指",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_dinghunjiezhi.png",
		healthMax = 736,
		equipType = EquipType.eRing,
		herosId = {
			205
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				desc = "闪避{+26},格挡{+26}",
				mateCount = 100,
				health = 857,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				health = 1715,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				health = 2572,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 116,
				equipCount = 1,
				mateCount = 280,
				health = 3429,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 116,
				equipCount = 2,
				mateCount = 360,
				health = 4287,
				desc = "装备主将自身生命提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 116,
				equipCount = 2,
				mateCount = 440,
				health = 5144,
				desc = "闪避{+91},韧性{+88},格挡{+87}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 116,
				equipCount = 3,
				mateCount = 520,
				health = 6002,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[117] = {
		quality = 3,
		healthGrowMax = 86.75,
		name = "造血戒指",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_zaoxuejiezhi.png",
		healthMax = 751,
		equipType = EquipType.eRing,
		herosId = {
			207
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				desc = "闪避{+27},格挡{+26}",
				mateCount = 100,
				health = 857,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				health = 1715,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				health = 2572,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 117,
				equipCount = 1,
				mateCount = 280,
				health = 3429,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 117,
				equipCount = 2,
				mateCount = 360,
				health = 4287,
				desc = "装备主将自身生命提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 117,
				equipCount = 2,
				mateCount = 440,
				health = 5144,
				desc = "闪避{+92},韧性{+87},格挡{+89}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 117,
				equipCount = 3,
				mateCount = 520,
				health = 6002,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[118] = {
		quality = 3,
		healthGrowMax = 88.53,
		name = "九阳戒指",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_jiuyangjiezhi.png",
		healthMax = 767,
		equipType = EquipType.eRing,
		herosId = {
			201,
			203,
			212
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				desc = "闪避{+27},格挡{+27}",
				mateCount = 100,
				health = 857,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				health = 1715,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				health = 2572,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 118,
				equipCount = 1,
				mateCount = 280,
				health = 3429,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 118,
				equipCount = 2,
				mateCount = 360,
				health = 4287,
				desc = "装备主将自身生命提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 118,
				equipCount = 2,
				mateCount = 440,
				health = 5144,
				desc = "闪避{+89},韧性{+90},格挡{+90}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 118,
				equipCount = 3,
				mateCount = 520,
				health = 6002,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[119] = {
		quality = 3,
		healthGrowMax = 90.32,
		name = "天盾戒指",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_tiandunjiezhi.png",
		healthMax = 774,
		equipType = EquipType.eRing,
		herosId = {
			202
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				desc = "闪避{+27},格挡{+26}",
				mateCount = 100,
				health = 857,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				health = 1715,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				health = 2572,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 119,
				equipCount = 1,
				mateCount = 280,
				health = 3429,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 119,
				equipCount = 2,
				mateCount = 360,
				health = 4287,
				desc = "装备主将自身生命提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 119,
				equipCount = 2,
				mateCount = 440,
				health = 5144,
				desc = "闪避{+90},韧性{+88},格挡{+87}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 119,
				equipCount = 3,
				mateCount = 520,
				health = 6002,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[120] = {
		quality = 3,
		healthGrowMax = 91.22,
		name = "天雷戒指",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_tianleijiezhi.png",
		healthMax = 790,
		equipType = EquipType.eRing,
		herosId = {
			204,
			211
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				desc = "闪避{+27},格挡{+27}",
				mateCount = 100,
				health = 857,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				health = 1715,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				health = 2572,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 120,
				equipCount = 1,
				mateCount = 280,
				health = 3429,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 120,
				equipCount = 2,
				mateCount = 360,
				health = 4287,
				desc = "装备主将自身生命提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 120,
				equipCount = 2,
				mateCount = 440,
				health = 5144,
				desc = "闪避{+87},韧性{+91},格挡{+87}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 120,
				equipCount = 3,
				mateCount = 520,
				health = 6002,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[121] = {
		quality = 3,
		healthGrowMax = 93.01,
		name = "龙魂戒指",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_longhunjiezhi.png",
		healthMax = 797,
		equipType = EquipType.eRing,
		herosId = {
			309,
			209
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				desc = "闪避{+27},格挡{+26}",
				mateCount = 100,
				health = 857,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				health = 1715,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				health = 2572,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 121,
				equipCount = 1,
				mateCount = 280,
				health = 3429,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 121,
				equipCount = 2,
				mateCount = 360,
				health = 4287,
				desc = "装备主将自身生命提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 121,
				equipCount = 2,
				mateCount = 440,
				health = 5144,
				desc = "闪避{+87},韧性{+86},格挡{+88}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 121,
				equipCount = 3,
				mateCount = 520,
				health = 6002,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[122] = {
		quality = 3,
		healthGrowMax = 86.75,
		name = "诛仙戒指",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_zhuxianjiezhi.png",
		healthMax = 744,
		equipType = EquipType.eRing,
		herosId = {
			210
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				desc = "闪避{+26},格挡{+26}",
				mateCount = 100,
				health = 857,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低10点",
				mateCount = 140,
				health = 1715,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{8%}",
				mateCount = 200,
				health = 2572,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 122,
				equipCount = 1,
				mateCount = 280,
				health = 3429,
				desc = "战斗中被攻击最终伤害减少{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 122,
				equipCount = 2,
				mateCount = 360,
				health = 4287,
				desc = "装备主将自身生命提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 122,
				equipCount = 2,
				mateCount = 440,
				health = 5144,
				desc = "闪避{+87},韧性{+90},格挡{+87}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 122,
				equipCount = 3,
				mateCount = 520,
				health = 6002,
				desc = "职业被克制效果降低{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[123] = {
		quality = 4,
		healthGrowMax = 105.26,
		name = "混元神戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_hunyuanshenjie.png",
		healthMax = 882,
		equipType = EquipType.eRing,
		herosId = {
			102,
			108
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				desc = "闪避{+67},格挡{+66}",
				mateCount = 200,
				health = 1072,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				health = 2143,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				health = 3215,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 123,
				equipCount = 1,
				mateCount = 680,
				health = 4287,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 123,
				equipCount = 1,
				mateCount = 840,
				health = 5359,
				desc = "装备主将自身生命提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 123,
				equipCount = 2,
				mateCount = 1000,
				health = 6430,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 123,
				equipCount = 2,
				mateCount = 1160,
				health = 7502,
				desc = "闪避{+197},韧性{+198},格挡{+195}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 123,
				equipCount = 3,
				mateCount = 1320,
				health = 8574,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 123,
				equipCount = 3,
				mateCount = 1480,
				health = 9645,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 123,
				equipCount = 4,
				mateCount = 1640,
				health = 10717,
				desc = "装备主将自身生命提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[124] = {
		quality = 4,
		healthGrowMax = 107.38,
		name = "血牛神戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_xueniushenjie.png",
		healthMax = 900,
		equipType = EquipType.eRing,
		herosId = {
			104,
			110,
			109
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				desc = "闪避{+68},格挡{+68}",
				mateCount = 200,
				health = 1072,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				health = 2143,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				health = 3215,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 124,
				equipCount = 1,
				mateCount = 680,
				health = 4287,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 124,
				equipCount = 1,
				mateCount = 840,
				health = 5359,
				desc = "装备主将自身生命提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 124,
				equipCount = 2,
				mateCount = 1000,
				health = 6430,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 124,
				equipCount = 2,
				mateCount = 1160,
				health = 7502,
				desc = "闪避{+201},韧性{+197},格挡{+201}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 124,
				equipCount = 3,
				mateCount = 1320,
				health = 8574,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 124,
				equipCount = 3,
				mateCount = 1480,
				health = 9645,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 124,
				equipCount = 4,
				mateCount = 1640,
				health = 10717,
				desc = "装备主将自身生命提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[125] = {
		quality = 4,
		healthGrowMax = 108.45,
		name = "风火神戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_fenghuoshenjie.png",
		healthMax = 909,
		equipType = EquipType.eRing,
		herosId = {
			101,
			105,
			107
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				desc = "闪避{+65},格挡{+66}",
				mateCount = 200,
				health = 1072,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				health = 2143,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				health = 3215,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 125,
				equipCount = 1,
				mateCount = 680,
				health = 4287,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 125,
				equipCount = 1,
				mateCount = 840,
				health = 5359,
				desc = "装备主将自身生命提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 125,
				equipCount = 2,
				mateCount = 1000,
				health = 6430,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 125,
				equipCount = 2,
				mateCount = 1160,
				health = 7502,
				desc = "闪避{+197},韧性{+203},格挡{+195}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 125,
				equipCount = 3,
				mateCount = 1320,
				health = 8574,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 125,
				equipCount = 3,
				mateCount = 1480,
				health = 9645,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 125,
				equipCount = 4,
				mateCount = 1640,
				health = 10717,
				desc = "装备主将自身生命提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[126] = {
		quality = 4,
		healthGrowMax = 110.57,
		name = "天帝神戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_tiandishenjie.png",
		healthMax = 927,
		equipType = EquipType.eRing,
		herosId = {
			103,
			111
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				desc = "闪避{+67},格挡{+66}",
				mateCount = 200,
				health = 1072,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				health = 2143,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				health = 3215,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 126,
				equipCount = 1,
				mateCount = 680,
				health = 4287,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 126,
				equipCount = 1,
				mateCount = 840,
				health = 5359,
				desc = "装备主将自身生命提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 126,
				equipCount = 2,
				mateCount = 1000,
				health = 6430,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 126,
				equipCount = 2,
				mateCount = 1160,
				health = 7502,
				desc = "闪避{+204},韧性{+205},格挡{+194}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 126,
				equipCount = 3,
				mateCount = 1320,
				health = 8574,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 126,
				equipCount = 3,
				mateCount = 1480,
				health = 9645,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 126,
				equipCount = 4,
				mateCount = 1640,
				health = 10717,
				desc = "装备主将自身生命提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[127] = {
		quality = 4,
		healthGrowMax = 110.57,
		name = "归元神戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_guiyuanshenjie.png",
		healthMax = 936,
		equipType = EquipType.eRing,
		herosId = {
			106
		},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				desc = "闪避{+66},格挡{+65}",
				mateCount = 200,
				health = 1072,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				health = 2143,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				health = 3215,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 127,
				equipCount = 1,
				mateCount = 680,
				health = 4287,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 127,
				equipCount = 1,
				mateCount = 840,
				health = 5359,
				desc = "装备主将自身生命提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 127,
				equipCount = 2,
				mateCount = 1000,
				health = 6430,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 127,
				equipCount = 2,
				mateCount = 1160,
				health = 7502,
				desc = "闪避{+203},韧性{+200},格挡{+205}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 127,
				equipCount = 3,
				mateCount = 1320,
				health = 8574,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 127,
				equipCount = 3,
				mateCount = 1480,
				health = 9645,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 127,
				equipCount = 4,
				mateCount = 1640,
				health = 10717,
				desc = "装备主将自身生命提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[128] = {
		quality = 4,
		healthGrowMax = 104.19,
		name = "太极神戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_taijishenjie.png",
		healthMax = 873,
		equipType = EquipType.eRing,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				desc = "闪避{+68},格挡{+68}",
				mateCount = 200,
				health = 1072,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				health = 2143,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				health = 3215,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 128,
				equipCount = 1,
				mateCount = 680,
				health = 4287,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 128,
				equipCount = 1,
				mateCount = 840,
				health = 5359,
				desc = "装备主将自身生命提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 128,
				equipCount = 2,
				mateCount = 1000,
				health = 6430,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 128,
				equipCount = 2,
				mateCount = 1160,
				health = 7502,
				desc = "闪避{+205},韧性{+197},格挡{+199}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 128,
				equipCount = 3,
				mateCount = 1320,
				health = 8574,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 128,
				equipCount = 3,
				mateCount = 1480,
				health = 9645,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 128,
				equipCount = 4,
				mateCount = 1640,
				health = 10717,
				desc = "装备主将自身生命提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[129] = {
		quality = 4,
		healthGrowMax = 105.26,
		name = "开天神戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_kaitianshenjie.png",
		healthMax = 882,
		equipType = EquipType.eRing,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eShanBi,
			BattleAttrsType.eRenXing,
			BattleAttrsType.eGeDang
		},
		jieJiAttrs = {
			{
				desc = "闪避{+65},格挡{+66}",
				mateCount = 200,
				health = 1072,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				health = 2143,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				health = 3215,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 129,
				equipCount = 1,
				mateCount = 680,
				health = 4287,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 129,
				equipCount = 1,
				mateCount = 840,
				health = 5359,
				desc = "装备主将自身生命提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 129,
				equipCount = 2,
				mateCount = 1000,
				health = 6430,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 129,
				equipCount = 2,
				mateCount = 1160,
				health = 7502,
				desc = "闪避{+195},韧性{+204},格挡{+198}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 129,
				equipCount = 3,
				mateCount = 1320,
				health = 8574,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 129,
				equipCount = 3,
				mateCount = 1480,
				health = 9645,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 129,
				equipCount = 4,
				mateCount = 1640,
				health = 10717,
				desc = "装备主将自身生命提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[130] = {
		speedGrowMax = 13.38,
		quality = 2,
		name = "青铜链",
		speedMax = 106,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_xianglian01.png",
		equipType = EquipType.eNecklace,
		herosId = {
			403
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.ePoJi
		}
	},
	[131] = {
		speedGrowMax = 13.65,
		quality = 2,
		name = "青玉链",
		speedMax = 107,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_xianglian03.png",
		equipType = EquipType.eNecklace,
		herosId = {
			404
		},
		feedAttrs = {
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		}
	},
	[132] = {
		speedGrowMax = 12.06,
		quality = 1,
		name = "火石链",
		speedMax = 92,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_xianglian03.png",
		equipType = EquipType.eNecklace,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eBaoJi
		}
	},
	[133] = {
		speedGrowMax = 11.24,
		quality = 1,
		name = "木珠链",
		speedMax = 92,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_xianglian04.png",
		equipType = EquipType.eNecklace,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.ePoJi
		}
	},
	[134] = {
		speedGrowMax = 11.48,
		quality = 1,
		name = "香草链",
		speedMax = 86,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_xianglian04.png",
		equipType = EquipType.eNecklace,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eMingZhong
		}
	},
	[135] = {
		speedGrowMax = 15.05,
		quality = 3,
		name = "灵玉链",
		speedMax = 125,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_lingyulian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			304
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 143,
				desc = "命中{+26},暴击{+27}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				speed = 286,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				speed = 429,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 135,
				equipCount = 1,
				mateCount = 280,
				speed = 572,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 135,
				equipCount = 2,
				mateCount = 360,
				speed = 714,
				desc = "装备主将自身速度提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 135,
				equipCount = 2,
				mateCount = 440,
				speed = 857,
				desc = "破击{+90},暴击{+90},命中{+90}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 135,
				equipCount = 3,
				mateCount = 520,
				speed = 1000,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[136] = {
		speedGrowMax = 15.2,
		quality = 3,
		name = "御神链",
		speedMax = 128,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_yushenlian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			302,
			308
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 143,
				desc = "命中{+27},暴击{+26}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				speed = 286,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				speed = 429,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 136,
				equipCount = 1,
				mateCount = 280,
				speed = 572,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 136,
				equipCount = 2,
				mateCount = 360,
				speed = 714,
				desc = "装备主将自身速度提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 136,
				equipCount = 2,
				mateCount = 440,
				speed = 857,
				desc = "破击{+91},暴击{+88},命中{+88}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 136,
				equipCount = 3,
				mateCount = 520,
				speed = 1000,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[137] = {
		speedGrowMax = 15.5,
		quality = 3,
		name = "电光链",
		speedMax = 129,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_dianguanglian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			307,
			310
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 143,
				desc = "命中{+27},暴击{+27}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				speed = 286,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				speed = 429,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 137,
				equipCount = 1,
				mateCount = 280,
				speed = 572,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 137,
				equipCount = 2,
				mateCount = 360,
				speed = 714,
				desc = "装备主将自身速度提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 137,
				equipCount = 2,
				mateCount = 440,
				speed = 857,
				desc = "破击{+91},暴击{+89},命中{+88}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 137,
				equipCount = 3,
				mateCount = 520,
				speed = 1000,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[138] = {
		speedGrowMax = 14.46,
		quality = 3,
		name = "幽冥链",
		speedMax = 130,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_youminglian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			303,
			309
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 143,
				desc = "命中{+26},暴击{+27}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				speed = 286,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				speed = 429,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 138,
				equipCount = 1,
				mateCount = 280,
				speed = 572,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 138,
				equipCount = 2,
				mateCount = 360,
				speed = 714,
				desc = "装备主将自身速度提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 138,
				equipCount = 2,
				mateCount = 440,
				speed = 857,
				desc = "破击{+88},暴击{+87},命中{+88}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 138,
				equipCount = 3,
				mateCount = 520,
				speed = 1000,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[139] = {
		speedGrowMax = 14.61,
		quality = 3,
		name = "金丝链",
		speedMax = 133,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_jinsilian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			311
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 143,
				desc = "命中{+26},暴击{+27}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				speed = 286,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				speed = 429,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 139,
				equipCount = 1,
				mateCount = 280,
				speed = 572,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 139,
				equipCount = 2,
				mateCount = 360,
				speed = 714,
				desc = "装备主将自身速度提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 139,
				equipCount = 2,
				mateCount = 440,
				speed = 857,
				desc = "破击{+90},暴击{+90},命中{+91}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 139,
				equipCount = 3,
				mateCount = 520,
				speed = 1000,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[140] = {
		speedGrowMax = 14.9,
		quality = 3,
		name = "飞云链",
		speedMax = 123,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_feiyunlian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			305,
			306
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 143,
				desc = "命中{+26},暴击{+27}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				speed = 286,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				speed = 429,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 140,
				equipCount = 1,
				mateCount = 280,
				speed = 572,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 140,
				equipCount = 2,
				mateCount = 360,
				speed = 714,
				desc = "装备主将自身速度提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 140,
				equipCount = 2,
				mateCount = 440,
				speed = 857,
				desc = "破击{+88},暴击{+88},命中{+90}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 140,
				equipCount = 3,
				mateCount = 520,
				speed = 1000,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[141] = {
		speedGrowMax = 13.51,
		quality = 2,
		name = "仙女链",
		speedMax = 103,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_xianglian04.png",
		equipType = EquipType.eNecklace,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi
		}
	},
	[142] = {
		speedGrowMax = 13.65,
		quality = 2,
		name = "绝尘链",
		speedMax = 105,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_xianglian02.png",
		equipType = EquipType.eNecklace,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.ePoJi
		}
	},
	[143] = {
		speedGrowMax = 14.31,
		quality = 3,
		name = "摩诃项链",
		speedMax = 129,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_mohexianglian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			301
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 143,
				desc = "命中{+27},暴击{+27}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				speed = 286,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				speed = 429,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 143,
				equipCount = 1,
				mateCount = 280,
				speed = 572,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 143,
				equipCount = 2,
				mateCount = 360,
				speed = 714,
				desc = "装备主将自身速度提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 143,
				equipCount = 2,
				mateCount = 440,
				speed = 857,
				desc = "破击{+87},暴击{+87},命中{+87}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 143,
				equipCount = 3,
				mateCount = 520,
				speed = 1000,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[144] = {
		speedGrowMax = 14.46,
		quality = 3,
		name = "烛龙项链",
		speedMax = 130,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_zhulongxianglian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			204,
			209
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 143,
				desc = "命中{+26},暴击{+27}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				speed = 286,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				speed = 429,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 144,
				equipCount = 1,
				mateCount = 280,
				speed = 572,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 144,
				equipCount = 2,
				mateCount = 360,
				speed = 714,
				desc = "装备主将自身速度提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 144,
				equipCount = 2,
				mateCount = 440,
				speed = 857,
				desc = "破击{+87},暴击{+88},命中{+91}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 144,
				equipCount = 3,
				mateCount = 520,
				speed = 1000,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[145] = {
		speedGrowMax = 14.76,
		quality = 3,
		name = "灵心项链",
		speedMax = 132,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_lingxinxianglian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			203,
			210,
			212
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 143,
				desc = "命中{+26},暴击{+27}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				speed = 286,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				speed = 429,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 145,
				equipCount = 1,
				mateCount = 280,
				speed = 572,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 145,
				equipCount = 2,
				mateCount = 360,
				speed = 714,
				desc = "装备主将自身速度提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 145,
				equipCount = 2,
				mateCount = 440,
				speed = 857,
				desc = "破击{+91},暴击{+88},命中{+89}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 145,
				equipCount = 3,
				mateCount = 520,
				speed = 1000,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[146] = {
		speedGrowMax = 15.05,
		quality = 3,
		name = "轮回项链",
		speedMax = 123,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_lunhuixianglian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			208
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 143,
				desc = "命中{+27},暴击{+26}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				speed = 286,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				speed = 429,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 146,
				equipCount = 1,
				mateCount = 280,
				speed = 572,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 146,
				equipCount = 2,
				mateCount = 360,
				speed = 714,
				desc = "装备主将自身速度提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 146,
				equipCount = 2,
				mateCount = 440,
				speed = 857,
				desc = "破击{+91},暴击{+88},命中{+91}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 146,
				equipCount = 3,
				mateCount = 520,
				speed = 1000,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[147] = {
		speedGrowMax = 15.2,
		quality = 3,
		name = "游龙项链",
		speedMax = 124,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_youlongxianglian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			201,
			205
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 143,
				desc = "命中{+27},暴击{+26}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				speed = 286,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				speed = 429,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 147,
				equipCount = 1,
				mateCount = 280,
				speed = 572,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 147,
				equipCount = 2,
				mateCount = 360,
				speed = 714,
				desc = "装备主将自身速度提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 147,
				equipCount = 2,
				mateCount = 440,
				speed = 857,
				desc = "破击{+91},暴击{+91},命中{+88}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 147,
				equipCount = 3,
				mateCount = 520,
				speed = 1000,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[148] = {
		speedGrowMax = 15.5,
		quality = 3,
		name = "飞翔项链",
		speedMax = 125,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_feixiangxianglian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			206
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 143,
				desc = "命中{+27},暴击{+26}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				speed = 286,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				speed = 429,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 148,
				equipCount = 1,
				mateCount = 280,
				speed = 572,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 148,
				equipCount = 2,
				mateCount = 360,
				speed = 714,
				desc = "装备主将自身速度提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 148,
				equipCount = 2,
				mateCount = 440,
				speed = 857,
				desc = "破击{+87},暴击{+90},命中{+90}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 148,
				equipCount = 3,
				mateCount = 520,
				speed = 1000,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[149] = {
		speedGrowMax = 14.31,
		quality = 3,
		name = "极速项链",
		speedMax = 128,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_jisuxianglian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			207
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 143,
				desc = "命中{+27},暴击{+26}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				speed = 286,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				speed = 429,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 149,
				equipCount = 1,
				mateCount = 280,
				speed = 572,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 149,
				equipCount = 2,
				mateCount = 360,
				speed = 714,
				desc = "装备主将自身速度提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 149,
				equipCount = 2,
				mateCount = 440,
				speed = 857,
				desc = "破击{+91},暴击{+89},命中{+87}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 149,
				equipCount = 3,
				mateCount = 520,
				speed = 1000,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[150] = {
		speedGrowMax = 14.61,
		quality = 3,
		name = "风雷项链",
		speedMax = 129,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_fengleixianglian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			211
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 143,
				desc = "命中{+27},暴击{+26}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				speed = 286,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				speed = 429,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 150,
				equipCount = 1,
				mateCount = 280,
				speed = 572,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 150,
				equipCount = 2,
				mateCount = 360,
				speed = 714,
				desc = "装备主将自身速度提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 150,
				equipCount = 2,
				mateCount = 440,
				speed = 857,
				desc = "破击{+88},暴击{+87},命中{+89}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 150,
				equipCount = 3,
				mateCount = 520,
				speed = 1000,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[151] = {
		speedGrowMax = 14.9,
		quality = 3,
		name = "霹雳项链",
		speedMax = 130,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_pilixianglian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			202
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 143,
				desc = "命中{+26},暴击{+27}",
				mateCount = 100,
				mateId = 200128,
				level = 0
			},
			{
				speed = 286,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				mateId = 200128,
				level = 30
			},
			{
				speed = 429,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 151,
				equipCount = 1,
				mateCount = 280,
				speed = 572,
				desc = "战斗中最终伤害增加{5%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 151,
				equipCount = 2,
				mateCount = 360,
				speed = 714,
				desc = "装备主将自身速度提升{5%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 151,
				equipCount = 2,
				mateCount = 440,
				speed = 857,
				desc = "破击{+88},暴击{+87},命中{+91}",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 151,
				equipCount = 3,
				mateCount = 520,
				speed = 1000,
				desc = "职业克制效果提升{12%}",
				mateId = 200128,
				level = 105
			}
		}
	},
	[152] = {
		speedGrowMax = 17.9,
		quality = 4,
		name = "日月神链",
		speedMax = 156,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_riyueshenlian.png",
		equipType = EquipType.eNecklace,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 179,
				desc = "命中{+66},暴击{+68}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				speed = 357,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				speed = 536,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 152,
				equipCount = 1,
				mateCount = 680,
				speed = 714,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 152,
				equipCount = 1,
				mateCount = 840,
				speed = 893,
				desc = "装备主将自身速度提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 152,
				equipCount = 2,
				mateCount = 1000,
				speed = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 152,
				equipCount = 2,
				mateCount = 1160,
				speed = 1250,
				desc = "破击{+204},暴击{+200},命中{+195}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 152,
				equipCount = 3,
				mateCount = 1320,
				speed = 1429,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 152,
				equipCount = 3,
				mateCount = 1480,
				speed = 1608,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 152,
				equipCount = 4,
				mateCount = 1640,
				speed = 1786,
				desc = "装备主将自身速度提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[153] = {
		speedGrowMax = 18.25,
		quality = 4,
		name = "翻天神链",
		speedMax = 144,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_fantianshenlian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			102,
			103,
			109
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 179,
				desc = "命中{+67},暴击{+68}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				speed = 357,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				speed = 536,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 153,
				equipCount = 1,
				mateCount = 680,
				speed = 714,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 153,
				equipCount = 1,
				mateCount = 840,
				speed = 893,
				desc = "装备主将自身速度提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 153,
				equipCount = 2,
				mateCount = 1000,
				speed = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 153,
				equipCount = 2,
				mateCount = 1160,
				speed = 1250,
				desc = "破击{+203},暴击{+204},命中{+194}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 153,
				equipCount = 3,
				mateCount = 1320,
				speed = 1429,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 153,
				equipCount = 3,
				mateCount = 1480,
				speed = 1608,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 153,
				equipCount = 4,
				mateCount = 1640,
				speed = 1786,
				desc = "装备主将自身速度提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[154] = {
		speedGrowMax = 18.43,
		quality = 4,
		name = "翱翔神链",
		speedMax = 146,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_aoxiangshenlian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			105,
			106,
			107
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 179,
				desc = "命中{+65},暴击{+68}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				speed = 357,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				speed = 536,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 154,
				equipCount = 1,
				mateCount = 680,
				speed = 714,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 154,
				equipCount = 1,
				mateCount = 840,
				speed = 893,
				desc = "装备主将自身速度提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 154,
				equipCount = 2,
				mateCount = 1000,
				speed = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 154,
				equipCount = 2,
				mateCount = 1160,
				speed = 1250,
				desc = "破击{+206},暴击{+200},命中{+195}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 154,
				equipCount = 3,
				mateCount = 1320,
				speed = 1429,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 154,
				equipCount = 3,
				mateCount = 1480,
				speed = 1608,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 154,
				equipCount = 4,
				mateCount = 1640,
				speed = 1786,
				desc = "装备主将自身速度提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[155] = {
		speedGrowMax = 17.19,
		quality = 4,
		name = "瞬息神链",
		speedMax = 149,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_shuixishenlian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			108,
			101
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 179,
				desc = "命中{+68},暴击{+66}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				speed = 357,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				speed = 536,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 155,
				equipCount = 1,
				mateCount = 680,
				speed = 714,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 155,
				equipCount = 1,
				mateCount = 840,
				speed = 893,
				desc = "装备主将自身速度提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 155,
				equipCount = 2,
				mateCount = 1000,
				speed = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 155,
				equipCount = 2,
				mateCount = 1160,
				speed = 1250,
				desc = "破击{+203},暴击{+199},命中{+203}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 155,
				equipCount = 3,
				mateCount = 1320,
				speed = 1429,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 155,
				equipCount = 3,
				mateCount = 1480,
				speed = 1608,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 155,
				equipCount = 4,
				mateCount = 1640,
				speed = 1786,
				desc = "装备主将自身速度提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[156] = {
		speedGrowMax = 17.37,
		quality = 4,
		name = "鲲鹏神链",
		speedMax = 150,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_kunpengshenlian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			110,
			111
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 179,
				desc = "命中{+67},暴击{+65}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				speed = 357,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				speed = 536,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 156,
				equipCount = 1,
				mateCount = 680,
				speed = 714,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 156,
				equipCount = 1,
				mateCount = 840,
				speed = 893,
				desc = "装备主将自身速度提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 156,
				equipCount = 2,
				mateCount = 1000,
				speed = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 156,
				equipCount = 2,
				mateCount = 1160,
				speed = 1250,
				desc = "破击{+203},暴击{+199},命中{+201}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 156,
				equipCount = 3,
				mateCount = 1320,
				speed = 1429,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 156,
				equipCount = 3,
				mateCount = 1480,
				speed = 1608,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 156,
				equipCount = 4,
				mateCount = 1640,
				speed = 1786,
				desc = "装备主将自身速度提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[157] = {
		speedGrowMax = 17.72,
		quality = 4,
		name = "九天神链",
		speedMax = 152,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_jiutianshenlian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			104
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 179,
				desc = "命中{+65},暴击{+67}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				speed = 357,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				speed = 536,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 157,
				equipCount = 1,
				mateCount = 680,
				speed = 714,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 157,
				equipCount = 1,
				mateCount = 840,
				speed = 893,
				desc = "装备主将自身速度提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 157,
				equipCount = 2,
				mateCount = 1000,
				speed = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 157,
				equipCount = 2,
				mateCount = 1160,
				speed = 1250,
				desc = "破击{+196},暴击{+206},命中{+194}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 157,
				equipCount = 3,
				mateCount = 1320,
				speed = 1429,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 157,
				equipCount = 3,
				mateCount = 1480,
				speed = 1608,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 157,
				equipCount = 4,
				mateCount = 1640,
				speed = 1786,
				desc = "装备主将自身速度提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[158] = {
		speedGrowMax = 17.9,
		quality = 4,
		name = "天音神链",
		speedMax = 155,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_tianyinshenlian.png",
		equipType = EquipType.eNecklace,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 179,
				desc = "命中{+66},暴击{+67}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				speed = 357,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				speed = 536,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 158,
				equipCount = 1,
				mateCount = 680,
				speed = 714,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 158,
				equipCount = 1,
				mateCount = 840,
				speed = 893,
				desc = "装备主将自身速度提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 158,
				equipCount = 2,
				mateCount = 1000,
				speed = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 158,
				equipCount = 2,
				mateCount = 1160,
				speed = 1250,
				desc = "破击{+195},暴击{+194},命中{+204}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 158,
				equipCount = 3,
				mateCount = 1320,
				speed = 1429,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 158,
				equipCount = 3,
				mateCount = 1480,
				speed = 1608,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 158,
				equipCount = 4,
				mateCount = 1640,
				speed = 1786,
				desc = "装备主将自身速度提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[159] = {
		quality = 4,
		name = "天机策",
		skillAttackMax = 156,
		heroExtra = 0.1,
		headerImage = "small_tianjice.png",
		skillAttackGrowMax = 18.25,
		normalAttackGrowMax = 27.38,
		normalAttackMax = 234,
		profession = 1,
		equipType = EquipType.eWeapon,
		herosId = {
			101
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_tianjice.png"
		},
		jieJiAttrs = {
			{
				skillattack = 60,
				desc = "命中{+66},破击{+66}",
				mateCount = 200,
				normalattack = 179,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 119,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 357,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 179,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 536,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 159,
				equipCount = 1,
				mateCount = 680,
				skillattack = 238,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 714,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 159,
				equipCount = 1,
				mateCount = 840,
				skillattack = 298,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 893,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 159,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 357,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1072,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 159,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 417,
				desc = "破击{+205},暴击{+194},命中{+205}",
				normalattack = 1250,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 159,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 476,
				desc = "职业克制效果提升{15%}",
				normalattack = 1429,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 159,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 536,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1608,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 159,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 595,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1786,
				mateId = 200128,
				level = 150
			}
		}
	},
	[160] = {
		quality = 4,
		name = "伏羲剑",
		skillAttackMax = 144,
		heroExtra = 0.1,
		headerImage = "small_xuanyuanjian.png",
		skillAttackGrowMax = 18.43,
		normalAttackGrowMax = 27.64,
		normalAttackMax = 216,
		profession = 1,
		equipType = EquipType.eWeapon,
		herosId = {
			102
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_xuanyuanjian.png"
		},
		jieJiAttrs = {
			{
				skillattack = 60,
				desc = "命中{+65},破击{+67}",
				mateCount = 200,
				normalattack = 179,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 119,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 357,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 179,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 536,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 160,
				equipCount = 1,
				mateCount = 680,
				skillattack = 238,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 714,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 160,
				equipCount = 1,
				mateCount = 840,
				skillattack = 298,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 893,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 160,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 357,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1072,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 160,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 417,
				desc = "破击{+203},暴击{+199},命中{+196}",
				normalattack = 1250,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 160,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 476,
				desc = "职业克制效果提升{15%}",
				normalattack = 1429,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 160,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 536,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1608,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 160,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 595,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1786,
				mateId = 200128,
				level = 150
			}
		}
	},
	[161] = {
		quality = 4,
		name = "玄天剑",
		skillAttackMax = 147,
		heroExtra = 0.1,
		headerImage = "small_xuantianjian.png",
		skillAttackGrowMax = 17.19,
		normalAttackGrowMax = 25.78,
		normalAttackMax = 221,
		profession = 1,
		equipType = EquipType.eWeapon,
		herosId = {
			103
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_xuantianjian.png"
		},
		jieJiAttrs = {
			{
				skillattack = 60,
				desc = "命中{+65},破击{+68}",
				mateCount = 200,
				normalattack = 179,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 119,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 357,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 179,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 536,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 161,
				equipCount = 1,
				mateCount = 680,
				skillattack = 238,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 714,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 161,
				equipCount = 1,
				mateCount = 840,
				skillattack = 298,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 893,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 161,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 357,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1072,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 161,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 417,
				desc = "破击{+200},暴击{+202},命中{+203}",
				normalattack = 1250,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 161,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 476,
				desc = "职业克制效果提升{15%}",
				normalattack = 1429,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 161,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 536,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1608,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 161,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 595,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1786,
				mateId = 200128,
				level = 150
			}
		}
	},
	[162] = {
		quality = 4,
		name = "混元金斗",
		skillAttackMax = 170,
		heroExtra = 0.1,
		headerImage = "small_hunyuanjindou.png",
		skillAttackGrowMax = 19.85,
		normalAttackGrowMax = 24.81,
		normalAttackMax = 212,
		profession = 3,
		equipType = EquipType.eWeapon,
		herosId = {
			104
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_hunyuanjindou.png",
			"big_hunyuanjindou_f.png"
		},
		jieJiAttrs = {
			{
				skillattack = 68,
				desc = "命中{+65},破击{+68}",
				mateCount = 200,
				normalattack = 170,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 136,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 340,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 204,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 510,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 162,
				equipCount = 1,
				mateCount = 680,
				skillattack = 272,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 680,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 162,
				equipCount = 1,
				mateCount = 840,
				skillattack = 340,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 851,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 162,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 408,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1021,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 162,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 476,
				desc = "破击{+203},暴击{+199},命中{+202}",
				normalattack = 1191,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 162,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 544,
				desc = "职业克制效果提升{15%}",
				normalattack = 1361,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 162,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 612,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1531,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 162,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 680,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1701,
				mateId = 200128,
				level = 150
			}
		}
	},
	[163] = {
		quality = 4,
		name = "女娲石",
		skillAttackMax = 202,
		heroExtra = 0.1,
		headerImage = "small_nvwashi.png",
		skillAttackGrowMax = 23.9,
		normalAttackGrowMax = 23.49,
		normalAttackMax = 199,
		profession = 3,
		equipType = EquipType.eWeapon,
		herosId = {
			105
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_nvwashi.png",
			"big_nvwashi_f.png"
		},
		jieJiAttrs = {
			{
				skillattack = 80,
				desc = "命中{+67},破击{+68}",
				mateCount = 200,
				normalattack = 158,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 161,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 316,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 241,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 474,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 163,
				equipCount = 1,
				mateCount = 680,
				skillattack = 321,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 631,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 163,
				equipCount = 1,
				mateCount = 840,
				skillattack = 402,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 789,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 163,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 482,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 947,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 163,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 562,
				desc = "破击{+198},暴击{+199},命中{+197}",
				normalattack = 1105,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 163,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 642,
				desc = "职业克制效果提升{15%}",
				normalattack = 1263,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 163,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 723,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1421,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 163,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 803,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1578,
				mateId = 200128,
				level = 150
			}
		}
	},
	[164] = {
		quality = 4,
		name = "紫金葫芦",
		skillAttackMax = 204,
		heroExtra = 0.1,
		headerImage = "small_zijinhonghulu.png",
		skillAttackGrowMax = 24.14,
		normalAttackGrowMax = 23.72,
		normalAttackMax = 201,
		profession = 3,
		equipType = EquipType.eWeapon,
		herosId = {
			106
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_zijinhulu.png",
			"big_zijinhulu_f.png"
		},
		jieJiAttrs = {
			{
				skillattack = 80,
				desc = "命中{+65},破击{+68}",
				mateCount = 200,
				normalattack = 158,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 161,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 316,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 241,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 474,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 164,
				equipCount = 1,
				mateCount = 680,
				skillattack = 321,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 631,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 164,
				equipCount = 1,
				mateCount = 840,
				skillattack = 402,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 789,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 164,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 482,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 947,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 164,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 562,
				desc = "破击{+195},暴击{+203},命中{+203}",
				normalattack = 1105,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 164,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 642,
				desc = "职业克制效果提升{15%}",
				normalattack = 1263,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 164,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 723,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1421,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 164,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 803,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1578,
				mateId = 200128,
				level = 150
			}
		}
	},
	[165] = {
		quality = 4,
		name = "混沌青莲",
		skillAttackMax = 177,
		heroExtra = 0.1,
		headerImage = "small_hundunqinglian.png",
		skillAttackGrowMax = 20.86,
		normalAttackGrowMax = 26.07,
		normalAttackMax = 221,
		profession = 3,
		equipType = EquipType.eWeapon,
		herosId = {
			107
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_hundunqinnian.png",
			"big_hundunqinnian_f.png"
		},
		jieJiAttrs = {
			{
				skillattack = 68,
				desc = "命中{+67},破击{+66}",
				mateCount = 200,
				normalattack = 170,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 136,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 340,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 204,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 510,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 165,
				equipCount = 1,
				mateCount = 680,
				skillattack = 272,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 680,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 165,
				equipCount = 1,
				mateCount = 840,
				skillattack = 340,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 851,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 165,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 408,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1021,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 165,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 476,
				desc = "破击{+202},暴击{+203},命中{+204}",
				normalattack = 1191,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 165,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 544,
				desc = "职业克制效果提升{15%}",
				normalattack = 1361,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 165,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 612,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1531,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 165,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 680,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1701,
				mateId = 200128,
				level = 150
			}
		}
	},
	[166] = {
		quality = 4,
		name = "盘古幡",
		skillAttackMax = 122,
		heroExtra = 0.1,
		headerImage = "small_pangufan.png",
		skillAttackGrowMax = 14.38,
		normalAttackGrowMax = 29.67,
		normalAttackMax = 251,
		profession = 2,
		equipType = EquipType.eWeapon,
		herosId = {
			108
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_pangufan.png"
		},
		jieJiAttrs = {
			{
				skillattack = 46,
				desc = "命中{+67},破击{+66}",
				mateCount = 200,
				normalattack = 192,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 93,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 383,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 139,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 575,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 166,
				equipCount = 1,
				mateCount = 680,
				skillattack = 186,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 767,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 166,
				equipCount = 1,
				mateCount = 840,
				skillattack = 232,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 958,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 166,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 279,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1150,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 166,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 325,
				desc = "破击{+199},暴击{+205},命中{+198}",
				normalattack = 1342,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 166,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 372,
				desc = "职业克制效果提升{15%}",
				normalattack = 1533,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 166,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 418,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1725,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 166,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 465,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1917,
				mateId = 200128,
				level = 150
			}
		}
	},
	[167] = {
		quality = 4,
		name = "天魔战锤",
		skillAttackMax = 94,
		heroExtra = 0.1,
		headerImage = "small_tianmozhanchui.png",
		skillAttackGrowMax = 11.19,
		normalAttackGrowMax = 28.78,
		normalAttackMax = 241,
		profession = 2,
		equipType = EquipType.eWeapon,
		herosId = {
			109
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_tianmozhanchui.png"
		},
		jieJiAttrs = {
			{
				skillattack = 39,
				desc = "命中{+65},破击{+67}",
				mateCount = 200,
				normalattack = 199,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 78,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 399,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 116,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 598,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 167,
				equipCount = 1,
				mateCount = 680,
				skillattack = 155,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 798,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 167,
				equipCount = 1,
				mateCount = 840,
				skillattack = 194,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 997,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 167,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 233,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1196,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 167,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 271,
				desc = "破击{+197},暴击{+195},命中{+197}",
				normalattack = 1396,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 167,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 310,
				desc = "职业克制效果提升{15%}",
				normalattack = 1595,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 167,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 349,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1794,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 167,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 388,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1994,
				mateId = 200128,
				level = 150
			}
		}
	},
	[168] = {
		quality = 4,
		name = "乾坤帝斧",
		skillAttackMax = 112,
		heroExtra = 0.1,
		headerImage = "small_qiankundiwangfu.png",
		skillAttackGrowMax = 13.55,
		normalAttackGrowMax = 27.95,
		normalAttackMax = 232,
		profession = 2,
		equipType = EquipType.eWeapon,
		herosId = {
			110
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_qiankundiwangfu.png"
		},
		jieJiAttrs = {
			{
				skillattack = 46,
				desc = "命中{+67},破击{+65}",
				mateCount = 200,
				normalattack = 192,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 93,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 383,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 139,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 575,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 168,
				equipCount = 1,
				mateCount = 680,
				skillattack = 186,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 767,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 168,
				equipCount = 1,
				mateCount = 840,
				skillattack = 232,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 958,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 168,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 279,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1150,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 168,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 325,
				desc = "破击{+196},暴击{+196},命中{+197}",
				normalattack = 1342,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 168,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 372,
				desc = "职业克制效果提升{15%}",
				normalattack = 1533,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 168,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 418,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1725,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 168,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 465,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1917,
				mateId = 200128,
				level = 150
			}
		}
	},
	[178] = {
		quality = 3,
		name = "三宝如意",
		skillAttackMax = 172,
		heroExtra = 0.1,
		headerImage = "small_sanbaoyuruyi.png",
		skillAttackGrowMax = 20.91,
		normalAttackGrowMax = 20.55,
		normalAttackMax = 169,
		profession = 3,
		equipType = EquipType.eWeapon,
		herosId = {
			210
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_sanbaoyuruyi.png",
			"big_sanbaoyuruyi_f.png"
		},
		jieJiAttrs = {
			{
				skillattack = 64,
				desc = "命中{+26},破击{+27}",
				mateCount = 100,
				normalattack = 126,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 128,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				normalattack = 253,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 193,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				normalattack = 379,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 178,
				equipCount = 1,
				mateCount = 280,
				skillattack = 257,
				desc = "战斗中最终伤害增加{5%}",
				normalattack = 505,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 178,
				equipCount = 2,
				mateCount = 360,
				skillattack = 321,
				desc = "装备主将自身普攻提升{5%}",
				normalattack = 631,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 178,
				equipCount = 2,
				mateCount = 440,
				skillattack = 385,
				desc = "破击{+91},暴击{+88},命中{+88}",
				normalattack = 758,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 178,
				equipCount = 3,
				mateCount = 520,
				skillattack = 450,
				desc = "职业克制效果提升{12%}",
				normalattack = 884,
				mateId = 200128,
				level = 105
			}
		}
	},
	[179] = {
		quality = 3,
		name = "玲珑宝塔",
		skillAttackMax = 147,
		heroExtra = 0.1,
		headerImage = "small_linglongbaota.png",
		skillAttackGrowMax = 16.35,
		normalAttackGrowMax = 20.44,
		normalAttackMax = 184,
		profession = 3,
		equipType = EquipType.eWeapon,
		herosId = {
			211
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_linglongbaota.png",
			"big_linglongbaota_f.png"
		},
		jieJiAttrs = {
			{
				skillattack = 54,
				desc = "命中{+27},破击{+27}",
				mateCount = 100,
				normalattack = 136,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 109,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				normalattack = 272,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 163,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				normalattack = 408,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 179,
				equipCount = 1,
				mateCount = 280,
				skillattack = 218,
				desc = "战斗中最终伤害增加{5%}",
				normalattack = 544,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 179,
				equipCount = 2,
				mateCount = 360,
				skillattack = 272,
				desc = "装备主将自身普攻提升{5%}",
				normalattack = 680,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 179,
				equipCount = 2,
				mateCount = 440,
				skillattack = 327,
				desc = "破击{+86},暴击{+90},命中{+91}",
				normalattack = 817,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 179,
				equipCount = 3,
				mateCount = 520,
				skillattack = 381,
				desc = "职业克制效果提升{12%}",
				normalattack = 953,
				mateId = 200128,
				level = 105
			}
		}
	},
	[180] = {
		quality = 3,
		name = "金枝宝荷",
		skillAttackMax = 149,
		heroExtra = 0.1,
		headerImage = "small_jinzhibaohe.png",
		skillAttackGrowMax = 16.69,
		normalAttackGrowMax = 20.87,
		normalAttackMax = 186,
		profession = 3,
		equipType = EquipType.eWeapon,
		herosId = {
			212
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_jinzhibaohe.png",
			"big_jinzhibaohe_f.png"
		},
		jieJiAttrs = {
			{
				skillattack = 54,
				desc = "命中{+26},破击{+27}",
				mateCount = 100,
				normalattack = 136,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 109,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				normalattack = 272,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 163,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				normalattack = 408,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 180,
				equipCount = 1,
				mateCount = 280,
				skillattack = 218,
				desc = "战斗中最终伤害增加{5%}",
				normalattack = 544,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 180,
				equipCount = 2,
				mateCount = 360,
				skillattack = 272,
				desc = "装备主将自身普攻提升{5%}",
				normalattack = 680,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 180,
				equipCount = 2,
				mateCount = 440,
				skillattack = 327,
				desc = "破击{+88},暴击{+90},命中{+89}",
				normalattack = 817,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 180,
				equipCount = 3,
				mateCount = 520,
				skillattack = 381,
				desc = "职业克制效果提升{12%}",
				normalattack = 953,
				mateId = 200128,
				level = 105
			}
		}
	},
	[184] = {
		quality = 3,
		name = "幌金绳",
		skillAttackMax = 169,
		heroExtra = 0.1,
		headerImage = "small_huangjinsheng.png",
		skillAttackGrowMax = 20.71,
		normalAttackGrowMax = 20.35,
		normalAttackMax = 166,
		profession = 3,
		equipType = EquipType.eWeapon,
		herosId = {
			304
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_huangjinsheng.png",
			"big_huangjinsheng_f.png"
		},
		jieJiAttrs = {
			{
				skillattack = 64,
				desc = "命中{+27},破击{+27}",
				mateCount = 100,
				normalattack = 126,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 128,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				normalattack = 253,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 193,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				normalattack = 379,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 184,
				equipCount = 1,
				mateCount = 280,
				skillattack = 257,
				desc = "战斗中最终伤害增加{5%}",
				normalattack = 505,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 184,
				equipCount = 2,
				mateCount = 360,
				skillattack = 321,
				desc = "装备主将自身普攻提升{5%}",
				normalattack = 631,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 184,
				equipCount = 2,
				mateCount = 440,
				skillattack = 385,
				desc = "破击{+91},暴击{+91},命中{+86}",
				normalattack = 758,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 184,
				equipCount = 3,
				mateCount = 520,
				skillattack = 450,
				desc = "职业克制效果提升{12%}",
				normalattack = 884,
				mateId = 200128,
				level = 105
			}
		}
	},
	[185] = {
		quality = 3,
		name = "灵枢灯",
		skillAttackMax = 171,
		heroExtra = 0.1,
		headerImage = "small_lingjiudeng.png",
		skillAttackGrowMax = 19.3,
		normalAttackGrowMax = 18.97,
		normalAttackMax = 168,
		profession = 3,
		equipType = EquipType.eWeapon,
		herosId = {
			305
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_lingjiudeng.png",
			"big_lingjiudeng_f.png"
		},
		jieJiAttrs = {
			{
				skillattack = 64,
				desc = "命中{+27},破击{+26}",
				mateCount = 100,
				normalattack = 126,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 128,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				normalattack = 253,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 193,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				normalattack = 379,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 185,
				equipCount = 1,
				mateCount = 280,
				skillattack = 257,
				desc = "战斗中最终伤害增加{5%}",
				normalattack = 505,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 185,
				equipCount = 2,
				mateCount = 360,
				skillattack = 321,
				desc = "装备主将自身普攻提升{5%}",
				normalattack = 631,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 185,
				equipCount = 2,
				mateCount = 440,
				skillattack = 385,
				desc = "破击{+87},暴击{+90},命中{+90}",
				normalattack = 758,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 185,
				equipCount = 3,
				mateCount = 520,
				skillattack = 450,
				desc = "职业克制效果提升{12%}",
				normalattack = 884,
				mateId = 200128,
				level = 105
			}
		}
	},
	[186] = {
		quality = 3,
		name = "月光宝瓶",
		skillAttackMax = 172,
		heroExtra = 0.1,
		headerImage = "small_liuliyueguangping.png",
		skillAttackGrowMax = 19.5,
		normalAttackGrowMax = 19.16,
		normalAttackMax = 169,
		profession = 3,
		equipType = EquipType.eWeapon,
		herosId = {
			306
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_liuliyueguangping.png",
			"big_liuliyueguangping_f.png"
		},
		jieJiAttrs = {
			{
				skillattack = 64,
				desc = "命中{+26},破击{+27}",
				mateCount = 100,
				normalattack = 126,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 128,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				normalattack = 253,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 193,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				normalattack = 379,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 186,
				equipCount = 1,
				mateCount = 280,
				skillattack = 257,
				desc = "战斗中最终伤害增加{5%}",
				normalattack = 505,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 186,
				equipCount = 2,
				mateCount = 360,
				skillattack = 321,
				desc = "装备主将自身普攻提升{5%}",
				normalattack = 631,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 186,
				equipCount = 2,
				mateCount = 440,
				skillattack = 385,
				desc = "破击{+91},暴击{+89},命中{+91}",
				normalattack = 758,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 186,
				equipCount = 3,
				mateCount = 520,
				skillattack = 450,
				desc = "职业克制效果提升{12%}",
				normalattack = 884,
				mateId = 200128,
				level = 105
			}
		}
	},
	[187] = {
		quality = 3,
		name = "风火蒲团",
		skillAttackMax = 147,
		heroExtra = 0.1,
		headerImage = "small_fenghuoputuan.png",
		skillAttackGrowMax = 16.69,
		normalAttackGrowMax = 20.87,
		normalAttackMax = 184,
		profession = 3,
		equipType = EquipType.eWeapon,
		herosId = {
			307
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_fenghuoputuan.png",
			"big_fenghuoputuan_f.png"
		},
		jieJiAttrs = {
			{
				skillattack = 54,
				desc = "命中{+26},破击{+27}",
				mateCount = 100,
				normalattack = 136,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 109,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				normalattack = 272,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 163,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				normalattack = 408,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 187,
				equipCount = 1,
				mateCount = 280,
				skillattack = 218,
				desc = "战斗中最终伤害增加{5%}",
				normalattack = 544,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 187,
				equipCount = 2,
				mateCount = 360,
				skillattack = 272,
				desc = "装备主将自身普攻提升{5%}",
				normalattack = 680,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 187,
				equipCount = 2,
				mateCount = 440,
				skillattack = 327,
				desc = "破击{+90},暴击{+87},命中{+88}",
				normalattack = 817,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 187,
				equipCount = 3,
				mateCount = 520,
				skillattack = 381,
				desc = "职业克制效果提升{12%}",
				normalattack = 953,
				mateId = 200128,
				level = 105
			}
		}
	},
	[169] = {
		quality = 3,
		name = "至尊剑",
		skillAttackMax = 125,
		heroExtra = 0.1,
		headerImage = "small_zhizunjian.png",
		skillAttackGrowMax = 14.9,
		normalAttackGrowMax = 22.36,
		normalAttackMax = 188,
		profession = 1,
		equipType = EquipType.eWeapon,
		herosId = {
			201
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_zhizunjian.png"
		},
		jieJiAttrs = {
			{
				skillattack = 48,
				desc = "命中{+27},破击{+26}",
				mateCount = 100,
				normalattack = 143,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 95,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				normalattack = 286,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 143,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				normalattack = 429,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 169,
				equipCount = 1,
				mateCount = 280,
				skillattack = 191,
				desc = "战斗中最终伤害增加{5%}",
				normalattack = 572,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 169,
				equipCount = 2,
				mateCount = 360,
				skillattack = 238,
				desc = "装备主将自身普攻提升{5%}",
				normalattack = 714,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 169,
				equipCount = 2,
				mateCount = 440,
				skillattack = 286,
				desc = "破击{+89},暴击{+91},命中{+89}",
				normalattack = 857,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 169,
				equipCount = 3,
				mateCount = 520,
				skillattack = 333,
				desc = "职业克制效果提升{12%}",
				normalattack = 1000,
				mateId = 200128,
				level = 105
			}
		}
	},
	[170] = {
		quality = 3,
		name = "雌雄金鞭",
		skillAttackMax = 127,
		heroExtra = 0.1,
		headerImage = "small_cixiongjinbian.png",
		skillAttackGrowMax = 15.05,
		normalAttackGrowMax = 22.58,
		normalAttackMax = 190,
		profession = 1,
		equipType = EquipType.eWeapon,
		herosId = {
			202
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_cixiongdashenbian.png"
		},
		jieJiAttrs = {
			{
				skillattack = 48,
				desc = "命中{+27},破击{+26}",
				mateCount = 100,
				normalattack = 143,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 95,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				normalattack = 286,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 143,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				normalattack = 429,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 170,
				equipCount = 1,
				mateCount = 280,
				skillattack = 191,
				desc = "战斗中最终伤害增加{5%}",
				normalattack = 572,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 170,
				equipCount = 2,
				mateCount = 360,
				skillattack = 238,
				desc = "装备主将自身普攻提升{5%}",
				normalattack = 714,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 170,
				equipCount = 2,
				mateCount = 440,
				skillattack = 286,
				desc = "破击{+86},暴击{+89},命中{+91}",
				normalattack = 857,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 170,
				equipCount = 3,
				mateCount = 520,
				skillattack = 333,
				desc = "职业克制效果提升{12%}",
				normalattack = 1000,
				mateId = 200128,
				level = 105
			}
		}
	},
	[171] = {
		quality = 3,
		name = "打神鞭",
		skillAttackMax = 128,
		heroExtra = 0.1,
		headerImage = "small_dashenbian.png",
		skillAttackGrowMax = 15.35,
		normalAttackGrowMax = 23.03,
		normalAttackMax = 192,
		profession = 1,
		equipType = EquipType.eWeapon,
		herosId = {
			203
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_dashenbian.png"
		},
		jieJiAttrs = {
			{
				skillattack = 48,
				desc = "命中{+27},破击{+27}",
				mateCount = 100,
				normalattack = 143,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 95,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				normalattack = 286,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 143,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				normalattack = 429,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 171,
				equipCount = 1,
				mateCount = 280,
				skillattack = 191,
				desc = "战斗中最终伤害增加{5%}",
				normalattack = 572,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 171,
				equipCount = 2,
				mateCount = 360,
				skillattack = 238,
				desc = "装备主将自身普攻提升{5%}",
				normalattack = 714,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 171,
				equipCount = 2,
				mateCount = 440,
				skillattack = 286,
				desc = "破击{+88},暴击{+89},命中{+89}",
				normalattack = 857,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 171,
				equipCount = 3,
				mateCount = 520,
				skillattack = 333,
				desc = "职业克制效果提升{12%}",
				normalattack = 1000,
				mateId = 200128,
				level = 105
			}
		}
	},
	[172] = {
		quality = 3,
		name = "浑铁棍",
		skillAttackMax = 129,
		heroExtra = 0.1,
		headerImage = "small_huntiegun.png",
		skillAttackGrowMax = 15.5,
		normalAttackGrowMax = 23.25,
		normalAttackMax = 194,
		profession = 1,
		equipType = EquipType.eWeapon,
		herosId = {
			204
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_huntegun.png"
		},
		jieJiAttrs = {
			{
				skillattack = 48,
				desc = "命中{+27},破击{+27}",
				mateCount = 100,
				normalattack = 143,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 95,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				normalattack = 286,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 143,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				normalattack = 429,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 172,
				equipCount = 1,
				mateCount = 280,
				skillattack = 191,
				desc = "战斗中最终伤害增加{5%}",
				normalattack = 572,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 172,
				equipCount = 2,
				mateCount = 360,
				skillattack = 238,
				desc = "装备主将自身普攻提升{5%}",
				normalattack = 714,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 172,
				equipCount = 2,
				mateCount = 440,
				skillattack = 286,
				desc = "破击{+89},暴击{+89},命中{+91}",
				normalattack = 857,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 172,
				equipCount = 3,
				mateCount = 520,
				skillattack = 333,
				desc = "职业克制效果提升{12%}",
				normalattack = 1000,
				mateId = 200128,
				level = 105
			}
		}
	},
	[173] = {
		quality = 3,
		name = "玄元金尺",
		skillAttackMax = 132,
		heroExtra = 0.1,
		headerImage = "small_xuanyuanjinchi.png",
		skillAttackGrowMax = 14.46,
		normalAttackGrowMax = 21.69,
		normalAttackMax = 197,
		profession = 1,
		equipType = EquipType.eWeapon,
		herosId = {
			205
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_xuanyuanjinchi.png"
		},
		jieJiAttrs = {
			{
				skillattack = 48,
				desc = "命中{+27},破击{+27}",
				mateCount = 100,
				normalattack = 143,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 95,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				normalattack = 286,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 143,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				normalattack = 429,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 173,
				equipCount = 1,
				mateCount = 280,
				skillattack = 191,
				desc = "战斗中最终伤害增加{5%}",
				normalattack = 572,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 173,
				equipCount = 2,
				mateCount = 360,
				skillattack = 238,
				desc = "装备主将自身普攻提升{5%}",
				normalattack = 714,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 173,
				equipCount = 2,
				mateCount = 440,
				skillattack = 286,
				desc = "破击{+86},暴击{+86},命中{+90}",
				normalattack = 857,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 173,
				equipCount = 3,
				mateCount = 520,
				skillattack = 333,
				desc = "职业克制效果提升{12%}",
				normalattack = 1000,
				mateId = 200128,
				level = 105
			}
		}
	},
	[181] = {
		quality = 3,
		name = "招妖幡",
		skillAttackMax = 132,
		heroExtra = 0.1,
		headerImage = "small_zhaoyaofan.png",
		skillAttackGrowMax = 14.76,
		normalAttackGrowMax = 22.13,
		normalAttackMax = 197,
		profession = 1,
		equipType = EquipType.eWeapon,
		herosId = {
			301
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_zhaoyaofan.png"
		},
		jieJiAttrs = {
			{
				skillattack = 48,
				desc = "命中{+27},破击{+27}",
				mateCount = 100,
				normalattack = 143,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 95,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				normalattack = 286,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 143,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				normalattack = 429,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 181,
				equipCount = 1,
				mateCount = 280,
				skillattack = 191,
				desc = "战斗中最终伤害增加{5%}",
				normalattack = 572,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 181,
				equipCount = 2,
				mateCount = 360,
				skillattack = 238,
				desc = "装备主将自身普攻提升{5%}",
				normalattack = 714,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 181,
				equipCount = 2,
				mateCount = 440,
				skillattack = 286,
				desc = "破击{+89},暴击{+89},命中{+90}",
				normalattack = 857,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 181,
				equipCount = 3,
				mateCount = 520,
				skillattack = 333,
				desc = "职业克制效果提升{12%}",
				normalattack = 1000,
				mateId = 200128,
				level = 105
			}
		}
	},
	[182] = {
		quality = 3,
		name = "斩妖剑",
		skillAttackMax = 123,
		heroExtra = 0.1,
		headerImage = "small_zhanyaojian.png",
		skillAttackGrowMax = 14.9,
		normalAttackGrowMax = 22.36,
		normalAttackMax = 184,
		profession = 1,
		equipType = EquipType.eWeapon,
		herosId = {
			302
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_zhanyaojian.png"
		},
		jieJiAttrs = {
			{
				skillattack = 48,
				desc = "命中{+26},破击{+27}",
				mateCount = 100,
				normalattack = 143,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 95,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				normalattack = 286,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 143,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				normalattack = 429,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 182,
				equipCount = 1,
				mateCount = 280,
				skillattack = 191,
				desc = "战斗中最终伤害增加{5%}",
				normalattack = 572,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 182,
				equipCount = 2,
				mateCount = 360,
				skillattack = 238,
				desc = "装备主将自身普攻提升{5%}",
				normalattack = 714,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 182,
				equipCount = 2,
				mateCount = 440,
				skillattack = 286,
				desc = "破击{+87},暴击{+89},命中{+90}",
				normalattack = 857,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 182,
				equipCount = 3,
				mateCount = 520,
				skillattack = 333,
				desc = "职业克制效果提升{12%}",
				normalattack = 1000,
				mateId = 200128,
				level = 105
			}
		}
	},
	[183] = {
		quality = 3,
		name = "生死令",
		skillAttackMax = 124,
		heroExtra = 0.1,
		headerImage = "small_shengsiling.png",
		skillAttackGrowMax = 15.2,
		normalAttackGrowMax = 22.8,
		normalAttackMax = 186,
		profession = 1,
		equipType = EquipType.eWeapon,
		herosId = {
			303
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_shengsilin.png"
		},
		jieJiAttrs = {
			{
				skillattack = 48,
				desc = "命中{+26},破击{+27}",
				mateCount = 100,
				normalattack = 143,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 95,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				normalattack = 286,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 143,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				normalattack = 429,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 183,
				equipCount = 1,
				mateCount = 280,
				skillattack = 191,
				desc = "战斗中最终伤害增加{5%}",
				normalattack = 572,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 183,
				equipCount = 2,
				mateCount = 360,
				skillattack = 238,
				desc = "装备主将自身普攻提升{5%}",
				normalattack = 714,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 183,
				equipCount = 2,
				mateCount = 440,
				skillattack = 286,
				desc = "破击{+90},暴击{+90},命中{+86}",
				normalattack = 857,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 183,
				equipCount = 3,
				mateCount = 520,
				skillattack = 333,
				desc = "职业克制效果提升{12%}",
				normalattack = 1000,
				mateId = 200128,
				level = 105
			}
		}
	},
	[174] = {
		quality = 3,
		name = "方天神戟",
		skillAttackMax = 104,
		heroExtra = 0.1,
		headerImage = "small_fangtianshenji.png",
		skillAttackGrowMax = 11.4,
		normalAttackGrowMax = 23.51,
		normalAttackMax = 214,
		profession = 2,
		equipType = EquipType.eWeapon,
		herosId = {
			206
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_fangtianshenji.png"
		},
		jieJiAttrs = {
			{
				skillattack = 37,
				desc = "命中{+26},破击{+27}",
				mateCount = 100,
				normalattack = 153,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 74,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				normalattack = 307,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 112,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				normalattack = 460,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 174,
				equipCount = 1,
				mateCount = 280,
				skillattack = 149,
				desc = "战斗中最终伤害增加{5%}",
				normalattack = 613,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 174,
				equipCount = 2,
				mateCount = 360,
				skillattack = 186,
				desc = "装备主将自身普攻提升{5%}",
				normalattack = 767,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 174,
				equipCount = 2,
				mateCount = 440,
				skillattack = 223,
				desc = "破击{+89},暴击{+90},命中{+89}",
				normalattack = 920,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 174,
				equipCount = 3,
				mateCount = 520,
				skillattack = 260,
				desc = "职业克制效果提升{12%}",
				normalattack = 1073,
				mateId = 200128,
				level = 105
			}
		}
	},
	[175] = {
		quality = 3,
		name = "三尖枪",
		skillAttackMax = 80,
		heroExtra = 0.1,
		headerImage = "small_sanjianliangrenqiang.png",
		skillAttackGrowMax = 9.61,
		normalAttackGrowMax = 24.71,
		normalAttackMax = 205,
		profession = 2,
		equipType = EquipType.eWeapon,
		herosId = {
			207
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_sanjinlianrenqiang.png"
		},
		jieJiAttrs = {
			{
				skillattack = 31,
				desc = "命中{+27},破击{+27}",
				mateCount = 100,
				normalattack = 160,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 62,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				normalattack = 319,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 93,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				normalattack = 479,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 175,
				equipCount = 1,
				mateCount = 280,
				skillattack = 124,
				desc = "战斗中最终伤害增加{5%}",
				normalattack = 638,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 175,
				equipCount = 2,
				mateCount = 360,
				skillattack = 155,
				desc = "装备主将自身普攻提升{5%}",
				normalattack = 798,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 175,
				equipCount = 2,
				mateCount = 440,
				skillattack = 186,
				desc = "破击{+91},暴击{+88},命中{+88}",
				normalattack = 957,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 175,
				equipCount = 3,
				mateCount = 520,
				skillattack = 217,
				desc = "职业克制效果提升{12%}",
				normalattack = 1117,
				mateId = 200128,
				level = 105
			}
		}
	},
	[176] = {
		quality = 3,
		name = "金箍棒",
		skillAttackMax = 81,
		heroExtra = 0.1,
		headerImage = "small_ruyijingubang.png",
		skillAttackGrowMax = 9.8,
		normalAttackGrowMax = 25.21,
		normalAttackMax = 208,
		profession = 2,
		equipType = EquipType.eWeapon,
		herosId = {
			208
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_ruyijingubang.png"
		},
		jieJiAttrs = {
			{
				skillattack = 31,
				desc = "命中{+27},破击{+26}",
				mateCount = 100,
				normalattack = 160,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 62,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				normalattack = 319,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 93,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				normalattack = 479,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 176,
				equipCount = 1,
				mateCount = 280,
				skillattack = 124,
				desc = "战斗中最终伤害增加{5%}",
				normalattack = 638,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 176,
				equipCount = 2,
				mateCount = 360,
				skillattack = 155,
				desc = "装备主将自身普攻提升{5%}",
				normalattack = 798,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 176,
				equipCount = 2,
				mateCount = 440,
				skillattack = 186,
				desc = "破击{+91},暴击{+87},命中{+87}",
				normalattack = 957,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 176,
				equipCount = 3,
				mateCount = 520,
				skillattack = 217,
				desc = "职业克制效果提升{12%}",
				normalattack = 1117,
				mateId = 200128,
				level = 105
			}
		}
	},
	[177] = {
		quality = 3,
		name = "神龙戟",
		skillAttackMax = 99,
		heroExtra = 0.1,
		headerImage = "small_dinghaishenlongji.png",
		skillAttackGrowMax = 11.87,
		normalAttackGrowMax = 24.47,
		normalAttackMax = 204,
		profession = 2,
		equipType = EquipType.eWeapon,
		herosId = {
			209
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_dinghaishenlongji.png"
		},
		jieJiAttrs = {
			{
				skillattack = 37,
				desc = "命中{+26},破击{+26}",
				mateCount = 100,
				normalattack = 153,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 74,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				normalattack = 307,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 112,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				normalattack = 460,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 177,
				equipCount = 1,
				mateCount = 280,
				skillattack = 149,
				desc = "战斗中最终伤害增加{5%}",
				normalattack = 613,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 177,
				equipCount = 2,
				mateCount = 360,
				skillattack = 186,
				desc = "装备主将自身普攻提升{5%}",
				normalattack = 767,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 177,
				equipCount = 2,
				mateCount = 440,
				skillattack = 223,
				desc = "破击{+91},暴击{+86},命中{+87}",
				normalattack = 920,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 177,
				equipCount = 3,
				mateCount = 520,
				skillattack = 260,
				desc = "职业克制效果提升{12%}",
				normalattack = 1073,
				mateId = 200128,
				level = 105
			}
		}
	},
	[188] = {
		quality = 3,
		name = "宣花板斧",
		skillAttackMax = 103,
		heroExtra = 0.1,
		headerImage = "small_xuanhuabanfu.png",
		skillAttackGrowMax = 11.63,
		normalAttackGrowMax = 23.99,
		normalAttackMax = 212,
		profession = 2,
		equipType = EquipType.eWeapon,
		herosId = {
			308
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_xuanhuabanfu.png"
		},
		jieJiAttrs = {
			{
				skillattack = 37,
				desc = "命中{+26},破击{+27}",
				mateCount = 100,
				normalattack = 153,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 74,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				normalattack = 307,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 112,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				normalattack = 460,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 188,
				equipCount = 1,
				mateCount = 280,
				skillattack = 149,
				desc = "战斗中最终伤害增加{5%}",
				normalattack = 613,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 188,
				equipCount = 2,
				mateCount = 360,
				skillattack = 186,
				desc = "装备主将自身普攻提升{5%}",
				normalattack = 767,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 188,
				equipCount = 2,
				mateCount = 440,
				skillattack = 223,
				desc = "破击{+86},暴击{+91},命中{+86}",
				normalattack = 920,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 188,
				equipCount = 3,
				mateCount = 520,
				skillattack = 260,
				desc = "职业克制效果提升{12%}",
				normalattack = 1073,
				mateId = 200128,
				level = 105
			}
		}
	},
	[189] = {
		quality = 3,
		name = "月牙铲",
		skillAttackMax = 104,
		heroExtra = 0.1,
		headerImage = "small_yueyachan.png",
		skillAttackGrowMax = 11.75,
		normalAttackGrowMax = 24.23,
		normalAttackMax = 214,
		profession = 2,
		equipType = EquipType.eWeapon,
		herosId = {
			309
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_yueyachan.png"
		},
		jieJiAttrs = {
			{
				skillattack = 37,
				desc = "命中{+27},破击{+27}",
				mateCount = 100,
				normalattack = 153,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 74,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				normalattack = 307,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 112,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				normalattack = 460,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 189,
				equipCount = 1,
				mateCount = 280,
				skillattack = 149,
				desc = "战斗中最终伤害增加{5%}",
				normalattack = 613,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 189,
				equipCount = 2,
				mateCount = 360,
				skillattack = 186,
				desc = "装备主将自身普攻提升{5%}",
				normalattack = 767,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 189,
				equipCount = 2,
				mateCount = 440,
				skillattack = 223,
				desc = "破击{+91},暴击{+87},命中{+88}",
				normalattack = 920,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 189,
				equipCount = 3,
				mateCount = 520,
				skillattack = 260,
				desc = "职业克制效果提升{12%}",
				normalattack = 1073,
				mateId = 200128,
				level = 105
			}
		}
	},
	[190] = {
		quality = 3,
		name = "黄金棍",
		skillAttackMax = 80,
		heroExtra = 0.1,
		headerImage = "small_huangjingun.png",
		skillAttackGrowMax = 9.9,
		normalAttackGrowMax = 25.46,
		normalAttackMax = 205,
		profession = 2,
		equipType = EquipType.eWeapon,
		herosId = {
			310
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_huangjingun.png"
		},
		jieJiAttrs = {
			{
				skillattack = 31,
				desc = "命中{+26},破击{+27}",
				mateCount = 100,
				normalattack = 160,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 62,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				normalattack = 319,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 93,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				normalattack = 479,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 190,
				equipCount = 1,
				mateCount = 280,
				skillattack = 124,
				desc = "战斗中最终伤害增加{5%}",
				normalattack = 638,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 190,
				equipCount = 2,
				mateCount = 360,
				skillattack = 155,
				desc = "装备主将自身普攻提升{5%}",
				normalattack = 798,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 190,
				equipCount = 2,
				mateCount = 440,
				skillattack = 186,
				desc = "破击{+87},暴击{+90},命中{+88}",
				normalattack = 957,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 190,
				equipCount = 3,
				mateCount = 520,
				skillattack = 217,
				desc = "职业克制效果提升{12%}",
				normalattack = 1117,
				mateId = 200128,
				level = 105
			}
		}
	},
	[191] = {
		quality = 3,
		name = "金刚战杵",
		skillAttackMax = 81,
		heroExtra = 0.1,
		headerImage = "small_jingangfumochu.png",
		skillAttackGrowMax = 10.09,
		normalAttackGrowMax = 25.96,
		normalAttackMax = 208,
		profession = 2,
		equipType = EquipType.eWeapon,
		herosId = {
			311
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_jingangfumochu.png"
		},
		jieJiAttrs = {
			{
				skillattack = 31,
				desc = "命中{+26},破击{+26}",
				mateCount = 100,
				normalattack = 160,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 62,
				desc = "进入战斗时，初始怒气提升10点",
				mateCount = 140,
				normalattack = 319,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 93,
				desc = "职业克制效果提升{8%}",
				mateCount = 200,
				normalattack = 479,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 191,
				equipCount = 1,
				mateCount = 280,
				skillattack = 124,
				desc = "战斗中最终伤害增加{5%}",
				normalattack = 638,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 191,
				equipCount = 2,
				mateCount = 360,
				skillattack = 155,
				desc = "装备主将自身普攻提升{5%}",
				normalattack = 798,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 191,
				equipCount = 2,
				mateCount = 440,
				skillattack = 186,
				desc = "破击{+89},暴击{+90},命中{+89}",
				normalattack = 957,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 191,
				equipCount = 3,
				mateCount = 520,
				skillattack = 217,
				desc = "职业克制效果提升{12%}",
				normalattack = 1117,
				mateId = 200128,
				level = 105
			}
		}
	},
	[192] = {
		profession = 1,
		quality = 2,
		name = "飞烟剑",
		skillAttackMax = 103,
		heroExtra = 0.1,
		headerImage = "small_feiyanjian.png",
		skillAttackGrowMax = 12.72,
		normalAttackGrowMax = 19.08,
		normalAttackMax = 155,
		equipType = EquipType.eWeapon,
		herosId = {
			401
		},
		feedAttrs = {
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_feiyanjian.png"
		}
	},
	[193] = {
		profession = 1,
		quality = 2,
		name = "骷髅鬼杖",
		skillAttackMax = 105,
		heroExtra = 0.1,
		headerImage = "small_kuloushehunzhang.png",
		skillAttackGrowMax = 12.72,
		normalAttackGrowMax = 19.08,
		normalAttackMax = 157,
		equipType = EquipType.eWeapon,
		herosId = {
			402
		},
		feedAttrs = {
			BattleAttrsType.ePoJi,
			BattleAttrsType.eMingZhong
		},
		skin = {
			"big_kulousehunzhang.png"
		}
	},
	[194] = {
		profession = 1,
		quality = 1,
		name = "桃木剑",
		skillAttackMax = 90,
		heroExtra = 0,
		headerImage = "small_taomujian.png",
		skillAttackGrowMax = 11.36,
		normalAttackGrowMax = 17.04,
		normalAttackMax = 135,
		equipType = EquipType.eWeapon,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eMingZhong
		},
		skin = {
			"big_taomujian.png"
		}
	},
	[195] = {
		profession = 2,
		quality = 2,
		name = "翻江棍",
		skillAttackMax = 84,
		heroExtra = 0.1,
		headerImage = "small_fanjianggun.png",
		skillAttackGrowMax = 10.24,
		normalAttackGrowMax = 21.11,
		normalAttackMax = 173,
		equipType = EquipType.eWeapon,
		herosId = {
			403
		},
		feedAttrs = {
			BattleAttrsType.eBaoJi,
			BattleAttrsType.eMingZhong
		},
		skin = {
			"big_fanjinggun.png"
		}
	},
	[196] = {
		profession = 2,
		quality = 2,
		name = "龙魂锤",
		skillAttackMax = 71,
		heroExtra = 0.1,
		headerImage = "small_longhunchui.png",
		skillAttackGrowMax = 8.63,
		normalAttackGrowMax = 22.18,
		normalAttackMax = 182,
		equipType = EquipType.eWeapon,
		herosId = {
			404
		},
		feedAttrs = {
			BattleAttrsType.ePoJi,
			BattleAttrsType.eBaoJi
		},
		skin = {
			"big_longhunchui.png"
		}
	},
	[197] = {
		profession = 2,
		quality = 1,
		name = "伏海叉",
		skillAttackMax = 72,
		heroExtra = 0,
		headerImage = "small_fuhaicha.png",
		skillAttackGrowMax = 9.23,
		normalAttackGrowMax = 19.03,
		normalAttackMax = 149,
		equipType = EquipType.eWeapon,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eMingZhong
		},
		skin = {
			"big_fuhaicha.png"
		}
	},
	[198] = {
		profession = 3,
		quality = 2,
		name = "周天镜",
		skillAttackMax = 116,
		heroExtra = 0.1,
		headerImage = "small_zhoutianjing.png",
		skillAttackGrowMax = 15.6,
		normalAttackGrowMax = 19.49,
		normalAttackMax = 145,
		equipType = EquipType.eWeapon,
		herosId = {
			405
		},
		feedAttrs = {
			BattleAttrsType.eBaoJi,
			BattleAttrsType.eMingZhong
		},
		skin = {
			"big_zhoutianjina.png",
			"big_zhoutianjina_f.png"
		}
	},
	[199] = {
		profession = 3,
		quality = 2,
		name = "照妖镜",
		skillAttackMax = 138,
		heroExtra = 0.1,
		headerImage = "small_zhaoyaojing.png",
		skillAttackGrowMax = 18.59,
		normalAttackGrowMax = 18.26,
		normalAttackMax = 136,
		equipType = EquipType.eWeapon,
		herosId = {
			406
		},
		feedAttrs = {
			BattleAttrsType.ePoJi,
			BattleAttrsType.eMingZhong
		},
		skin = {
			"big_zhaoyaojing.png",
			"big_zhaoyaojing_f.png"
		}
	},
	[200] = {
		profession = 3,
		quality = 1,
		name = "雷火珠",
		skillAttackMax = 100,
		heroExtra = 0,
		headerImage = "small_leihuozhu.png",
		skillAttackGrowMax = 12.85,
		normalAttackGrowMax = 16.06,
		normalAttackMax = 124,
		equipType = EquipType.eWeapon,
		herosId = {},
		feedAttrs = {
			BattleAttrsType.eMingZhong
		},
		skin = {
			"big_leihuozhu.png",
			"big_leihuozhu_f.png"
		}
	},
	[201] = {
		quality = 4,
		name = "真君戟",
		skillAttackMax = 97,
		heroExtra = 0.1,
		headerImage = "small_zhenjunji.png",
		skillAttackGrowMax = 11.31,
		normalAttackGrowMax = 29.08,
		normalAttackMax = 249,
		profession = 2,
		equipType = EquipType.eWeapon,
		herosId = {
			111
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_zhenjunji.png"
		},
		jieJiAttrs = {
			{
				skillattack = 39,
				desc = "命中{+66},破击{+65}",
				mateCount = 200,
				normalattack = 199,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 78,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 399,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 116,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 598,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 201,
				equipCount = 1,
				mateCount = 680,
				skillattack = 155,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 798,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 201,
				equipCount = 1,
				mateCount = 840,
				skillattack = 194,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 997,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 201,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 233,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1196,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 201,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 271,
				desc = "破击{+198},暴击{+197},命中{+197}",
				normalattack = 1396,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 201,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 310,
				desc = "职业克制效果提升{15%}",
				normalattack = 1595,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 201,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 349,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1794,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 201,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 388,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1994,
				mateId = 200128,
				level = 150
			}
		}
	},
	[202] = {
		quality = 4,
		name = "凌波仙符",
		skillAttackMax = 303,
		heroExtra = 0,
		skillAttackGrowMax = 35.09,
		headerImage = "small_lingboxianfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			119,
			120,
			121
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 119,
				desc = "破击{+67},暴击{+65}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 238,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 357,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 202,
				equipCount = 1,
				mateCount = 680,
				skillattack = 476,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 202,
				equipCount = 1,
				mateCount = 840,
				skillattack = 595,
				desc = "装备主将自身法攻提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 202,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 714,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 202,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 834,
				desc = "破击{+198},暴击{+202},命中{+204}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 202,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 953,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 202,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 1072,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 202,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 1191,
				desc = "装备主将自身法攻提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[203] = {
		quality = 4,
		name = "真元神符",
		skillAttackMax = 306,
		heroExtra = 0,
		skillAttackGrowMax = 35.79,
		headerImage = "small_zhenyuanshenfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			112,
			113
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 119,
				desc = "破击{+68},暴击{+67}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 238,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 357,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 203,
				equipCount = 1,
				mateCount = 680,
				skillattack = 476,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 203,
				equipCount = 1,
				mateCount = 840,
				skillattack = 595,
				desc = "装备主将自身法攻提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 203,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 714,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 203,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 834,
				desc = "破击{+195},暴击{+194},命中{+197}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 203,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 953,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 203,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 1072,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 203,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 1191,
				desc = "装备主将自身法攻提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[204] = {
		quality = 4,
		name = "元阳仙符",
		skillAttackMax = 309,
		heroExtra = 0,
		skillAttackGrowMax = 36.15,
		headerImage = "small_yuanyangshenfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			116,
			117
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 119,
				desc = "破击{+68},暴击{+65}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 238,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 357,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 204,
				equipCount = 1,
				mateCount = 680,
				skillattack = 476,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 204,
				equipCount = 1,
				mateCount = 840,
				skillattack = 595,
				desc = "装备主将自身法攻提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 204,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 714,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 204,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 834,
				desc = "破击{+200},暴击{+199},命中{+196}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 204,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 953,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 204,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 1072,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 204,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 1191,
				desc = "装备主将自身法攻提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[205] = {
		quality = 4,
		name = "纯阳神符",
		skillAttackMax = 312,
		heroExtra = 0,
		skillAttackGrowMax = 36.5,
		headerImage = "small_chunyangshenfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			114
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 119,
				desc = "破击{+66},暴击{+65}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 238,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 357,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 205,
				equipCount = 1,
				mateCount = 680,
				skillattack = 476,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 205,
				equipCount = 1,
				mateCount = 840,
				skillattack = 595,
				desc = "装备主将自身法攻提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 205,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 714,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 205,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 834,
				desc = "破击{+195},暴击{+196},命中{+197}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 205,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 953,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 205,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 1072,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 205,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 1191,
				desc = "装备主将自身法攻提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[206] = {
		quality = 4,
		name = "瑶池仙符",
		skillAttackMax = 288,
		heroExtra = 0,
		skillAttackGrowMax = 34.02,
		headerImage = "small_yaochixianfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			115
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 119,
				desc = "破击{+68},暴击{+66}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 238,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 357,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 206,
				equipCount = 1,
				mateCount = 680,
				skillattack = 476,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 206,
				equipCount = 1,
				mateCount = 840,
				skillattack = 595,
				desc = "装备主将自身法攻提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 206,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 714,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 206,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 834,
				desc = "破击{+201},暴击{+198},命中{+201}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 206,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 953,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 206,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 1072,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 206,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 1191,
				desc = "装备主将自身法攻提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[207] = {
		quality = 4,
		name = "魑魅鬼符",
		skillAttackMax = 291,
		heroExtra = 0,
		skillAttackGrowMax = 34.38,
		headerImage = "small_chimeiguifu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			118
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 119,
				desc = "破击{+67},暴击{+68}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 238,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 357,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 207,
				equipCount = 1,
				mateCount = 680,
				skillattack = 476,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 207,
				equipCount = 1,
				mateCount = 840,
				skillattack = 595,
				desc = "装备主将自身法攻提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 207,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 714,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 207,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 834,
				desc = "破击{+198},暴击{+199},命中{+197}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 207,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 953,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 207,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 1072,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 207,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 1191,
				desc = "装备主将自身法攻提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[208] = {
		quality = 4,
		skillDefenseGrowMax = 17.37,
		skillDefenseMax = 147,
		heroExtra = 0,
		name = "鸾羽凤冠",
		headerImage = "small_luanyufengguan.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			112,
			116,
			118
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+65},韧性{+67}",
				mateCount = 200,
				skilldefense = 179,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				skilldefense = 357,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				skilldefense = 536,
				level = 45
			},
			{
				equipId = 208,
				equipCount = 1,
				mateCount = 680,
				skilldefense = 714,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 208,
				equipCount = 1,
				mateCount = 840,
				skilldefense = 893,
				desc = "装备主将自身法防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 208,
				equipCount = 2,
				mateCount = 1000,
				skilldefense = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 208,
				equipCount = 2,
				mateCount = 1160,
				skilldefense = 1250,
				desc = "闪避{+194},韧性{+199},格挡{+202}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 208,
				equipCount = 3,
				mateCount = 1320,
				skilldefense = 1429,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 208,
				equipCount = 3,
				mateCount = 1480,
				skilldefense = 1608,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 208,
				equipCount = 4,
				mateCount = 1640,
				skilldefense = 1786,
				desc = "装备主将自身法防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[209] = {
		quality = 4,
		skillDefenseGrowMax = 17.54,
		skillDefenseMax = 149,
		heroExtra = 0,
		name = "黑炎魔冠",
		headerImage = "small_heiyanmoguan.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			120,
			121
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+66},韧性{+68}",
				mateCount = 200,
				skilldefense = 179,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				skilldefense = 357,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				skilldefense = 536,
				level = 45
			},
			{
				equipId = 209,
				equipCount = 1,
				mateCount = 680,
				skilldefense = 714,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 209,
				equipCount = 1,
				mateCount = 840,
				skilldefense = 893,
				desc = "装备主将自身法防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 209,
				equipCount = 2,
				mateCount = 1000,
				skilldefense = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 209,
				equipCount = 2,
				mateCount = 1160,
				skilldefense = 1250,
				desc = "闪避{+200},韧性{+205},格挡{+205}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 209,
				equipCount = 3,
				mateCount = 1320,
				skilldefense = 1429,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 209,
				equipCount = 3,
				mateCount = 1480,
				skilldefense = 1608,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 209,
				equipCount = 4,
				mateCount = 1640,
				skilldefense = 1786,
				desc = "装备主将自身法防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[210] = {
		quality = 4,
		skillDefenseGrowMax = 17.9,
		skillDefenseMax = 150,
		heroExtra = 0,
		name = "珐琅鬼冕",
		headerImage = "small_falangguimian.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			117,
			119
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+65},韧性{+67}",
				mateCount = 200,
				skilldefense = 179,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				skilldefense = 357,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				skilldefense = 536,
				level = 45
			},
			{
				equipId = 210,
				equipCount = 1,
				mateCount = 680,
				skilldefense = 714,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 210,
				equipCount = 1,
				mateCount = 840,
				skilldefense = 893,
				desc = "装备主将自身法防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 210,
				equipCount = 2,
				mateCount = 1000,
				skilldefense = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 210,
				equipCount = 2,
				mateCount = 1160,
				skilldefense = 1250,
				desc = "闪避{+205},韧性{+204},格挡{+199}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 210,
				equipCount = 3,
				mateCount = 1320,
				skilldefense = 1429,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 210,
				equipCount = 3,
				mateCount = 1480,
				skilldefense = 1608,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 210,
				equipCount = 4,
				mateCount = 1640,
				skilldefense = 1786,
				desc = "装备主将自身法防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[211] = {
		quality = 4,
		skillDefenseGrowMax = 18.07,
		skillDefenseMax = 152,
		heroExtra = 0,
		name = "琉璃玉冠",
		headerImage = "small_liuliyuguan.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			113
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+66},韧性{+66}",
				mateCount = 200,
				skilldefense = 179,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				skilldefense = 357,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				skilldefense = 536,
				level = 45
			},
			{
				equipId = 211,
				equipCount = 1,
				mateCount = 680,
				skilldefense = 714,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 211,
				equipCount = 1,
				mateCount = 840,
				skilldefense = 893,
				desc = "装备主将自身法防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 211,
				equipCount = 2,
				mateCount = 1000,
				skilldefense = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 211,
				equipCount = 2,
				mateCount = 1160,
				skilldefense = 1250,
				desc = "闪避{+202},韧性{+203},格挡{+205}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 211,
				equipCount = 3,
				mateCount = 1320,
				skilldefense = 1429,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 211,
				equipCount = 3,
				mateCount = 1480,
				skilldefense = 1608,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 211,
				equipCount = 4,
				mateCount = 1640,
				skilldefense = 1786,
				desc = "装备主将自身法防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[212] = {
		quality = 4,
		skillDefenseGrowMax = 18.25,
		skillDefenseMax = 153,
		heroExtra = 0,
		name = "白玉龙冠",
		headerImage = "small_baiyulongguan.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			114
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+66},韧性{+68}",
				mateCount = 200,
				skilldefense = 179,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				skilldefense = 357,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				skilldefense = 536,
				level = 45
			},
			{
				equipId = 212,
				equipCount = 1,
				mateCount = 680,
				skilldefense = 714,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 212,
				equipCount = 1,
				mateCount = 840,
				skilldefense = 893,
				desc = "装备主将自身法防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 212,
				equipCount = 2,
				mateCount = 1000,
				skilldefense = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 212,
				equipCount = 2,
				mateCount = 1160,
				skilldefense = 1250,
				desc = "闪避{+196},韧性{+204},格挡{+204}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 212,
				equipCount = 3,
				mateCount = 1320,
				skilldefense = 1429,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 212,
				equipCount = 3,
				mateCount = 1480,
				skilldefense = 1608,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 212,
				equipCount = 4,
				mateCount = 1640,
				skilldefense = 1786,
				desc = "装备主将自身法防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[213] = {
		quality = 4,
		skillDefenseGrowMax = 18.43,
		skillDefenseMax = 156,
		heroExtra = 0,
		name = "流苏金簪",
		headerImage = "small_liusujinzan.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			115
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+65},韧性{+65}",
				mateCount = 200,
				skilldefense = 179,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				skilldefense = 357,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				skilldefense = 536,
				level = 45
			},
			{
				equipId = 213,
				equipCount = 1,
				mateCount = 680,
				skilldefense = 714,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 213,
				equipCount = 1,
				mateCount = 840,
				skilldefense = 893,
				desc = "装备主将自身法防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 213,
				equipCount = 2,
				mateCount = 1000,
				skilldefense = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 213,
				equipCount = 2,
				mateCount = 1160,
				skilldefense = 1250,
				desc = "闪避{+204},韧性{+204},格挡{+199}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 213,
				equipCount = 3,
				mateCount = 1320,
				skilldefense = 1429,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 213,
				equipCount = 3,
				mateCount = 1480,
				skilldefense = 1608,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 213,
				equipCount = 4,
				mateCount = 1640,
				skilldefense = 1786,
				desc = "装备主将自身法防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[214] = {
		quality = 4,
		name = "神谕披风",
		normalDefenseMax = 72,
		heroExtra = 0,
		normalDefenseGrowMax = 8.59,
		headerImage = "small_shenyupifeng.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			117,
			119,
			121
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+67},韧性{+66}",
				mateCount = 200,
				normaldefense = 89,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				normaldefense = 179,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				normaldefense = 268,
				level = 45
			},
			{
				equipId = 214,
				equipCount = 1,
				mateCount = 680,
				normaldefense = 357,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 214,
				equipCount = 1,
				mateCount = 840,
				normaldefense = 447,
				desc = "装备主将自身普防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 214,
				equipCount = 2,
				mateCount = 1000,
				normaldefense = 536,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 214,
				equipCount = 2,
				mateCount = 1160,
				normaldefense = 625,
				desc = "闪避{+195},韧性{+205},格挡{+206}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 214,
				equipCount = 3,
				mateCount = 1320,
				normaldefense = 714,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 214,
				equipCount = 3,
				mateCount = 1480,
				normaldefense = 804,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 214,
				equipCount = 4,
				mateCount = 1640,
				normaldefense = 893,
				desc = "装备主将自身普防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[215] = {
		quality = 4,
		name = "碧霞云衣",
		normalDefenseMax = 73,
		heroExtra = 0,
		normalDefenseGrowMax = 8.68,
		headerImage = "small_bixiayunyi.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			118,
			120
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+66},韧性{+65}",
				mateCount = 200,
				normaldefense = 89,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				normaldefense = 179,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				normaldefense = 268,
				level = 45
			},
			{
				equipId = 215,
				equipCount = 1,
				mateCount = 680,
				normaldefense = 357,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 215,
				equipCount = 1,
				mateCount = 840,
				normaldefense = 447,
				desc = "装备主将自身普防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 215,
				equipCount = 2,
				mateCount = 1000,
				normaldefense = 536,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 215,
				equipCount = 2,
				mateCount = 1160,
				normaldefense = 625,
				desc = "闪避{+202},韧性{+202},格挡{+200}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 215,
				equipCount = 3,
				mateCount = 1320,
				normaldefense = 714,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 215,
				equipCount = 3,
				mateCount = 1480,
				normaldefense = 804,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 215,
				equipCount = 4,
				mateCount = 1640,
				normaldefense = 893,
				desc = "装备主将自身普防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[216] = {
		quality = 4,
		name = "金丝鳞甲",
		normalDefenseMax = 74,
		heroExtra = 0,
		normalDefenseGrowMax = 8.77,
		headerImage = "small_jinsilinjia.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			112,
			116
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+65},韧性{+68}",
				mateCount = 200,
				normaldefense = 89,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				normaldefense = 179,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				normaldefense = 268,
				level = 45
			},
			{
				equipId = 216,
				equipCount = 1,
				mateCount = 680,
				normaldefense = 357,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 216,
				equipCount = 1,
				mateCount = 840,
				normaldefense = 447,
				desc = "装备主将自身普防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 216,
				equipCount = 2,
				mateCount = 1000,
				normaldefense = 536,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 216,
				equipCount = 2,
				mateCount = 1160,
				normaldefense = 625,
				desc = "闪避{+202},韧性{+197},格挡{+196}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 216,
				equipCount = 3,
				mateCount = 1320,
				normaldefense = 714,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 216,
				equipCount = 3,
				mateCount = 1480,
				normaldefense = 804,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 216,
				equipCount = 4,
				mateCount = 1640,
				normaldefense = 893,
				desc = "装备主将自身普防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[217] = {
		quality = 4,
		name = "金蚕披风",
		normalDefenseMax = 74,
		heroExtra = 0,
		normalDefenseGrowMax = 8.86,
		headerImage = "small_jincanpifeng.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			113
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+66},韧性{+67}",
				mateCount = 200,
				normaldefense = 89,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				normaldefense = 179,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				normaldefense = 268,
				level = 45
			},
			{
				equipId = 217,
				equipCount = 1,
				mateCount = 680,
				normaldefense = 357,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 217,
				equipCount = 1,
				mateCount = 840,
				normaldefense = 447,
				desc = "装备主将自身普防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 217,
				equipCount = 2,
				mateCount = 1000,
				normaldefense = 536,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 217,
				equipCount = 2,
				mateCount = 1160,
				normaldefense = 625,
				desc = "闪避{+206},韧性{+202},格挡{+195}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 217,
				equipCount = 3,
				mateCount = 1320,
				normaldefense = 714,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 217,
				equipCount = 3,
				mateCount = 1480,
				normaldefense = 804,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 217,
				equipCount = 4,
				mateCount = 1640,
				normaldefense = 893,
				desc = "装备主将自身普防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[218] = {
		quality = 4,
		name = "龙骨魔铠",
		normalDefenseMax = 75,
		heroExtra = 0,
		normalDefenseGrowMax = 9.04,
		headerImage = "small_longgumokai.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			114
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+66},韧性{+66}",
				mateCount = 200,
				normaldefense = 89,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				normaldefense = 179,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				normaldefense = 268,
				level = 45
			},
			{
				equipId = 218,
				equipCount = 1,
				mateCount = 680,
				normaldefense = 357,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 218,
				equipCount = 1,
				mateCount = 840,
				normaldefense = 447,
				desc = "装备主将自身普防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 218,
				equipCount = 2,
				mateCount = 1000,
				normaldefense = 536,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 218,
				equipCount = 2,
				mateCount = 1160,
				normaldefense = 625,
				desc = "闪避{+205},韧性{+202},格挡{+204}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 218,
				equipCount = 3,
				mateCount = 1320,
				normaldefense = 714,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 218,
				equipCount = 3,
				mateCount = 1480,
				normaldefense = 804,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 218,
				equipCount = 4,
				mateCount = 1640,
				normaldefense = 893,
				desc = "装备主将自身普防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[219] = {
		quality = 4,
		name = "凤翅彩衣",
		normalDefenseMax = 76,
		heroExtra = 0,
		normalDefenseGrowMax = 9.13,
		headerImage = "small_fengchicaiyi.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			115
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+68},韧性{+67}",
				mateCount = 200,
				normaldefense = 89,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				normaldefense = 179,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				normaldefense = 268,
				level = 45
			},
			{
				equipId = 219,
				equipCount = 1,
				mateCount = 680,
				normaldefense = 357,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 219,
				equipCount = 1,
				mateCount = 840,
				normaldefense = 447,
				desc = "装备主将自身普防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 219,
				equipCount = 2,
				mateCount = 1000,
				normaldefense = 536,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 219,
				equipCount = 2,
				mateCount = 1160,
				normaldefense = 625,
				desc = "闪避{+198},韧性{+203},格挡{+200}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 219,
				equipCount = 3,
				mateCount = 1320,
				normaldefense = 714,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 219,
				equipCount = 3,
				mateCount = 1480,
				normaldefense = 804,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 219,
				equipCount = 4,
				mateCount = 1640,
				normaldefense = 893,
				desc = "装备主将自身普防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[220] = {
		quality = 4,
		healthGrowMax = 110.57,
		name = "龙血魔戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_longxuemojie.png",
		healthMax = 918,
		equipType = EquipType.eRing,
		herosId = {
			112,
			113,
			120
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				desc = "闪避{+67},格挡{+65}",
				mateCount = 200,
				health = 1072,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				health = 2143,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				health = 3215,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 220,
				equipCount = 1,
				mateCount = 680,
				health = 4287,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 220,
				equipCount = 1,
				mateCount = 840,
				health = 5359,
				desc = "装备主将自身生命提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 220,
				equipCount = 2,
				mateCount = 1000,
				health = 6430,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 220,
				equipCount = 2,
				mateCount = 1160,
				health = 7502,
				desc = "闪避{+198},韧性{+200},格挡{+195}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 220,
				equipCount = 3,
				mateCount = 1320,
				health = 8574,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 220,
				equipCount = 3,
				mateCount = 1480,
				health = 9645,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 220,
				equipCount = 4,
				mateCount = 1640,
				health = 10717,
				desc = "装备主将自身生命提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[221] = {
		quality = 4,
		healthGrowMax = 102.07,
		name = "翡翠神戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_feicuishenjie.png",
		healthMax = 927,
		equipType = EquipType.eRing,
		herosId = {
			121,
			117
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				desc = "闪避{+69},格挡{+65}",
				mateCount = 200,
				health = 1072,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				health = 2143,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				health = 3215,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 221,
				equipCount = 1,
				mateCount = 680,
				health = 4287,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 221,
				equipCount = 1,
				mateCount = 840,
				health = 5359,
				desc = "装备主将自身生命提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 221,
				equipCount = 2,
				mateCount = 1000,
				health = 6430,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 221,
				equipCount = 2,
				mateCount = 1160,
				health = 7502,
				desc = "闪避{+200},韧性{+198},格挡{+202}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 221,
				equipCount = 3,
				mateCount = 1320,
				health = 8574,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 221,
				equipCount = 3,
				mateCount = 1480,
				health = 9645,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 221,
				equipCount = 4,
				mateCount = 1640,
				health = 10717,
				desc = "装备主将自身生命提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[222] = {
		quality = 4,
		healthGrowMax = 104.19,
		name = "冥灵魔戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_minglingmojie.png",
		healthMax = 936,
		equipType = EquipType.eRing,
		herosId = {
			115,
			116
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				desc = "闪避{+67},格挡{+65}",
				mateCount = 200,
				health = 1072,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				health = 2143,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				health = 3215,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 222,
				equipCount = 1,
				mateCount = 680,
				health = 4287,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 222,
				equipCount = 1,
				mateCount = 840,
				health = 5359,
				desc = "装备主将自身生命提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 222,
				equipCount = 2,
				mateCount = 1000,
				health = 6430,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 222,
				equipCount = 2,
				mateCount = 1160,
				health = 7502,
				desc = "闪避{+195},韧性{+203},格挡{+200}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 222,
				equipCount = 3,
				mateCount = 1320,
				health = 8574,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 222,
				equipCount = 3,
				mateCount = 1480,
				health = 9645,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 222,
				equipCount = 4,
				mateCount = 1640,
				health = 10717,
				desc = "装备主将自身生命提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[223] = {
		quality = 4,
		healthGrowMax = 105.26,
		name = "异界密戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_yijiemijie.png",
		healthMax = 864,
		equipType = EquipType.eRing,
		herosId = {
			114
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				desc = "闪避{+67},格挡{+65}",
				mateCount = 200,
				health = 1072,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				health = 2143,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				health = 3215,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 223,
				equipCount = 1,
				mateCount = 680,
				health = 4287,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 223,
				equipCount = 1,
				mateCount = 840,
				health = 5359,
				desc = "装备主将自身生命提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 223,
				equipCount = 2,
				mateCount = 1000,
				health = 6430,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 223,
				equipCount = 2,
				mateCount = 1160,
				health = 7502,
				desc = "闪避{+205},韧性{+205},格挡{+199}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 223,
				equipCount = 3,
				mateCount = 1320,
				health = 8574,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 223,
				equipCount = 3,
				mateCount = 1480,
				health = 9645,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 223,
				equipCount = 4,
				mateCount = 1640,
				health = 10717,
				desc = "装备主将自身生命提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[224] = {
		quality = 4,
		healthGrowMax = 106.32,
		name = "无极神戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_wujishenjie.png",
		healthMax = 873,
		equipType = EquipType.eRing,
		herosId = {
			118
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				desc = "闪避{+68},格挡{+66}",
				mateCount = 200,
				health = 1072,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				health = 2143,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				health = 3215,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 224,
				equipCount = 1,
				mateCount = 680,
				health = 4287,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 224,
				equipCount = 1,
				mateCount = 840,
				health = 5359,
				desc = "装备主将自身生命提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 224,
				equipCount = 2,
				mateCount = 1000,
				health = 6430,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 224,
				equipCount = 2,
				mateCount = 1160,
				health = 7502,
				desc = "闪避{+205},韧性{+194},格挡{+195}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 224,
				equipCount = 3,
				mateCount = 1320,
				health = 8574,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 224,
				equipCount = 3,
				mateCount = 1480,
				health = 9645,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 224,
				equipCount = 4,
				mateCount = 1640,
				health = 10717,
				desc = "装备主将自身生命提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[225] = {
		quality = 4,
		healthGrowMax = 107.38,
		name = "魍魉鬼戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_wangliangguijie.png",
		healthMax = 882,
		equipType = EquipType.eRing,
		herosId = {
			119
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				desc = "闪避{+68},格挡{+66}",
				mateCount = 200,
				health = 1072,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				health = 2143,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				health = 3215,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 225,
				equipCount = 1,
				mateCount = 680,
				health = 4287,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 225,
				equipCount = 1,
				mateCount = 840,
				health = 5359,
				desc = "装备主将自身生命提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 225,
				equipCount = 2,
				mateCount = 1000,
				health = 6430,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 225,
				equipCount = 2,
				mateCount = 1160,
				health = 7502,
				desc = "闪避{+200},韧性{+196},格挡{+195}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 225,
				equipCount = 3,
				mateCount = 1320,
				health = 8574,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 225,
				equipCount = 3,
				mateCount = 1480,
				health = 9645,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 225,
				equipCount = 4,
				mateCount = 1640,
				health = 10717,
				desc = "装备主将自身生命提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[226] = {
		speedGrowMax = 18.25,
		quality = 4,
		name = "玲珑宝链",
		speedMax = 149,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_lingluobaolian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			116,
			117,
			114
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 179,
				desc = "命中{+66},暴击{+67}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				speed = 357,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				speed = 536,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 226,
				equipCount = 1,
				mateCount = 680,
				speed = 714,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 226,
				equipCount = 1,
				mateCount = 840,
				speed = 893,
				desc = "装备主将自身速度提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 226,
				equipCount = 2,
				mateCount = 1000,
				speed = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 226,
				equipCount = 2,
				mateCount = 1160,
				speed = 1250,
				desc = "破击{+198},暴击{+204},命中{+205}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 226,
				equipCount = 3,
				mateCount = 1320,
				speed = 1429,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 226,
				equipCount = 3,
				mateCount = 1480,
				speed = 1608,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 226,
				equipCount = 4,
				mateCount = 1640,
				speed = 1786,
				desc = "装备主将自身速度提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[227] = {
		speedGrowMax = 18.43,
		quality = 4,
		name = "鬼牙项链",
		speedMax = 150,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_guiyaxianglian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			112,
			115
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 179,
				desc = "命中{+68},暴击{+65}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				speed = 357,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				speed = 536,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 227,
				equipCount = 1,
				mateCount = 680,
				speed = 714,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 227,
				equipCount = 1,
				mateCount = 840,
				speed = 893,
				desc = "装备主将自身速度提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 227,
				equipCount = 2,
				mateCount = 1000,
				speed = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 227,
				equipCount = 2,
				mateCount = 1160,
				speed = 1250,
				desc = "破击{+205},暴击{+201},命中{+201}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 227,
				equipCount = 3,
				mateCount = 1320,
				speed = 1429,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 227,
				equipCount = 3,
				mateCount = 1480,
				speed = 1608,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 227,
				equipCount = 4,
				mateCount = 1640,
				speed = 1786,
				desc = "装备主将自身速度提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[228] = {
		speedGrowMax = 17.01,
		quality = 4,
		name = "碧玺项链",
		speedMax = 152,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_bixixianglian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			120,
			121
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 179,
				desc = "命中{+67},暴击{+65}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				speed = 357,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				speed = 536,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 228,
				equipCount = 1,
				mateCount = 680,
				speed = 714,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 228,
				equipCount = 1,
				mateCount = 840,
				speed = 893,
				desc = "装备主将自身速度提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 228,
				equipCount = 2,
				mateCount = 1000,
				speed = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 228,
				equipCount = 2,
				mateCount = 1160,
				speed = 1250,
				desc = "破击{+199},暴击{+200},命中{+202}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 228,
				equipCount = 3,
				mateCount = 1320,
				speed = 1429,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 228,
				equipCount = 3,
				mateCount = 1480,
				speed = 1608,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 228,
				equipCount = 4,
				mateCount = 1640,
				speed = 1786,
				desc = "装备主将自身速度提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[229] = {
		speedGrowMax = 17.19,
		quality = 4,
		name = "混元神链",
		speedMax = 153,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_hunyuanshenlian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			113
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 179,
				desc = "命中{+67},暴击{+67}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				speed = 357,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				speed = 536,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 229,
				equipCount = 1,
				mateCount = 680,
				speed = 714,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 229,
				equipCount = 1,
				mateCount = 840,
				speed = 893,
				desc = "装备主将自身速度提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 229,
				equipCount = 2,
				mateCount = 1000,
				speed = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 229,
				equipCount = 2,
				mateCount = 1160,
				speed = 1250,
				desc = "破击{+197},暴击{+197},命中{+203}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 229,
				equipCount = 3,
				mateCount = 1320,
				speed = 1429,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 229,
				equipCount = 3,
				mateCount = 1480,
				speed = 1608,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 229,
				equipCount = 4,
				mateCount = 1640,
				speed = 1786,
				desc = "装备主将自身速度提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[230] = {
		speedGrowMax = 17.37,
		quality = 4,
		name = "刑天魔链",
		speedMax = 155,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_xingtianmolian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			118
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 179,
				desc = "命中{+65},暴击{+66}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				speed = 357,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				speed = 536,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 230,
				equipCount = 1,
				mateCount = 680,
				speed = 714,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 230,
				equipCount = 1,
				mateCount = 840,
				speed = 893,
				desc = "装备主将自身速度提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 230,
				equipCount = 2,
				mateCount = 1000,
				speed = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 230,
				equipCount = 2,
				mateCount = 1160,
				speed = 1250,
				desc = "破击{+205},暴击{+195},命中{+197}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 230,
				equipCount = 3,
				mateCount = 1320,
				speed = 1429,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 230,
				equipCount = 3,
				mateCount = 1480,
				speed = 1608,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 230,
				equipCount = 4,
				mateCount = 1640,
				speed = 1786,
				desc = "装备主将自身速度提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[231] = {
		speedGrowMax = 17.72,
		quality = 4,
		name = "翡翠璎珞",
		speedMax = 156,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_feicuiyingluo.png",
		equipType = EquipType.eNecklace,
		herosId = {
			119
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 179,
				desc = "命中{+66},暴击{+68}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				speed = 357,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				speed = 536,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 231,
				equipCount = 1,
				mateCount = 680,
				speed = 714,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 231,
				equipCount = 1,
				mateCount = 840,
				speed = 893,
				desc = "装备主将自身速度提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 231,
				equipCount = 2,
				mateCount = 1000,
				speed = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 231,
				equipCount = 2,
				mateCount = 1160,
				speed = 1250,
				desc = "破击{+198},暴击{+195},命中{+199}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 231,
				equipCount = 3,
				mateCount = 1320,
				speed = 1429,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 231,
				equipCount = 3,
				mateCount = 1480,
				speed = 1608,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 231,
				equipCount = 4,
				mateCount = 1640,
				speed = 1786,
				desc = "装备主将自身速度提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[232] = {
		quality = 4,
		name = "琉璃玉钵",
		skillAttackMax = 165,
		heroExtra = 0.1,
		headerImage = "small_liuliyubo.png",
		skillAttackGrowMax = 20.45,
		normalAttackGrowMax = 25.57,
		normalAttackMax = 206,
		profession = 3,
		equipType = EquipType.eWeapon,
		herosId = {
			121
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_liuliyubo.png",
			"big_liuliyubo_f.png"
		},
		jieJiAttrs = {
			{
				skillattack = 68,
				desc = "命中{+66},破击{+67}",
				mateCount = 200,
				normalattack = 170,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 136,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 340,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 204,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 510,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 232,
				equipCount = 1,
				mateCount = 680,
				skillattack = 272,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 680,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 232,
				equipCount = 1,
				mateCount = 840,
				skillattack = 340,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 851,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 232,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 408,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1021,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 232,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 476,
				desc = "破击{+201},暴击{+195},命中{+202}",
				normalattack = 1191,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 232,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 544,
				desc = "职业克制效果提升{15%}",
				normalattack = 1361,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 232,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 612,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1531,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 232,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 680,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1701,
				mateId = 200128,
				level = 150
			}
		}
	},
	[233] = {
		quality = 4,
		name = "干将莫邪",
		skillAttackMax = 146,
		heroExtra = 0.1,
		headerImage = "small_ganjiangmoye.png",
		skillAttackGrowMax = 18.07,
		normalAttackGrowMax = 27.11,
		normalAttackMax = 218,
		profession = 1,
		equipType = EquipType.eWeapon,
		herosId = {
			115
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_ganjiangmoye.png"
		},
		jieJiAttrs = {
			{
				skillattack = 60,
				desc = "命中{+66},破击{+66}",
				mateCount = 200,
				normalattack = 179,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 119,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 357,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 179,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 536,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 233,
				equipCount = 1,
				mateCount = 680,
				skillattack = 238,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 714,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 233,
				equipCount = 1,
				mateCount = 840,
				skillattack = 298,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 893,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 233,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 357,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1072,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 233,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 417,
				desc = "破击{+205},暴击{+198},命中{+204}",
				normalattack = 1250,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 233,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 476,
				desc = "职业克制效果提升{15%}",
				normalattack = 1429,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 233,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 536,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1608,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 233,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 595,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1786,
				mateId = 200128,
				level = 150
			}
		}
	},
	[234] = {
		quality = 4,
		name = "定海神针",
		skillAttackMax = 96,
		heroExtra = 0.1,
		headerImage = "small_jingubang.png",
		skillAttackGrowMax = 11.88,
		normalAttackGrowMax = 30.56,
		normalAttackMax = 246,
		profession = 2,
		equipType = EquipType.eWeapon,
		herosId = {
			112
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_jingubang.png"
		},
		jieJiAttrs = {
			{
				skillattack = 39,
				desc = "命中{+68},破击{+66}",
				mateCount = 200,
				normalattack = 199,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 78,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 399,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 116,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 598,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 234,
				equipCount = 1,
				mateCount = 680,
				skillattack = 155,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 798,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 234,
				equipCount = 1,
				mateCount = 840,
				skillattack = 194,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 997,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 234,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 233,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1196,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 234,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 271,
				desc = "破击{+204},暴击{+206},命中{+201}",
				normalattack = 1396,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 234,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 310,
				desc = "职业克制效果提升{15%}",
				normalattack = 1595,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 234,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 349,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1794,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 234,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 388,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1994,
				mateId = 200128,
				level = 150
			}
		}
	},
	[235] = {
		quality = 4,
		name = "九齿钉耙",
		skillAttackMax = 116,
		heroExtra = 0.1,
		headerImage = "small_jiuchidingpa.png",
		skillAttackGrowMax = 14.38,
		normalAttackGrowMax = 29.67,
		normalAttackMax = 239,
		profession = 2,
		equipType = EquipType.eWeapon,
		herosId = {
			113
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_jiuchidingpa.png"
		},
		jieJiAttrs = {
			{
				skillattack = 46,
				desc = "命中{+65},破击{+67}",
				mateCount = 200,
				normalattack = 192,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 93,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 383,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 139,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 575,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 235,
				equipCount = 1,
				mateCount = 680,
				skillattack = 186,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 767,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 235,
				equipCount = 1,
				mateCount = 840,
				skillattack = 232,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 958,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 235,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 279,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1150,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 235,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 325,
				desc = "破击{+201},暴击{+206},命中{+201}",
				normalattack = 1342,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 235,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 372,
				desc = "职业克制效果提升{15%}",
				normalattack = 1533,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 235,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 418,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1725,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 235,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 465,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1917,
				mateId = 200128,
				level = 150
			}
		}
	},
	[236] = {
		quality = 4,
		name = "九转神叉",
		skillAttackMax = 150,
		heroExtra = 0.1,
		headerImage = "small_jiuzhuanshencha.png",
		skillAttackGrowMax = 17.19,
		normalAttackGrowMax = 25.78,
		normalAttackMax = 225,
		profession = 1,
		equipType = EquipType.eWeapon,
		herosId = {
			118
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_jiuzhuanshencha.png"
		},
		jieJiAttrs = {
			{
				skillattack = 60,
				desc = "命中{+68},破击{+65}",
				mateCount = 200,
				normalattack = 179,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 119,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 357,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 179,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 536,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 236,
				equipCount = 1,
				mateCount = 680,
				skillattack = 238,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 714,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 236,
				equipCount = 1,
				mateCount = 840,
				skillattack = 298,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 893,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 236,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 357,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1072,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 236,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 417,
				desc = "破击{+195},暴击{+200},命中{+198}",
				normalattack = 1250,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 236,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 476,
				desc = "职业克制效果提升{15%}",
				normalattack = 1429,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 236,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 536,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1608,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 236,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 595,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1786,
				mateId = 200128,
				level = 150
			}
		}
	},
	[237] = {
		quality = 4,
		name = "佛光舍利",
		skillAttackMax = 204,
		heroExtra = 0.1,
		headerImage = "small_foguangsheli.png",
		skillAttackGrowMax = 23.42,
		normalAttackGrowMax = 23.02,
		normalAttackMax = 201,
		profession = 3,
		equipType = EquipType.eWeapon,
		herosId = {
			120
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_foguangsheli.png",
			"big_foguangsheli_f.png"
		},
		jieJiAttrs = {
			{
				skillattack = 80,
				desc = "命中{+66},破击{+68}",
				mateCount = 200,
				normalattack = 158,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 161,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 316,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 241,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 474,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 237,
				equipCount = 1,
				mateCount = 680,
				skillattack = 321,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 631,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 237,
				equipCount = 1,
				mateCount = 840,
				skillattack = 402,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 789,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 237,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 482,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 947,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 237,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 562,
				desc = "破击{+206},暴击{+204},命中{+204}",
				normalattack = 1105,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 237,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 642,
				desc = "职业克制效果提升{15%}",
				normalattack = 1263,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 237,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 723,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1421,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 237,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 803,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1578,
				mateId = 200128,
				level = 150
			}
		}
	},
	[238] = {
		quality = 4,
		name = "山河画卷",
		skillAttackMax = 175,
		heroExtra = 0.1,
		headerImage = "small_shanhehuajuan.png",
		skillAttackGrowMax = 20.05,
		normalAttackGrowMax = 25.06,
		normalAttackMax = 219,
		profession = 3,
		equipType = EquipType.eWeapon,
		herosId = {
			119
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_shanhehuajian.png",
			"big_shanhehuajian_f.png"
		},
		jieJiAttrs = {
			{
				skillattack = 68,
				desc = "命中{+66},破击{+67}",
				mateCount = 200,
				normalattack = 170,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 136,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 340,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 204,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 510,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 238,
				equipCount = 1,
				mateCount = 680,
				skillattack = 272,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 680,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 238,
				equipCount = 1,
				mateCount = 840,
				skillattack = 340,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 851,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 238,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 408,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1021,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 238,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 476,
				desc = "破击{+198},暴击{+195},命中{+204}",
				normalattack = 1191,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 238,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 544,
				desc = "职业克制效果提升{15%}",
				normalattack = 1361,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 238,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 612,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1531,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 238,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 680,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1701,
				mateId = 200128,
				level = 150
			}
		}
	},
	[239] = {
		quality = 4,
		name = "降妖宝杖",
		skillAttackMax = 121,
		heroExtra = 0.1,
		headerImage = "small_xiangyaobaozhang.png",
		skillAttackGrowMax = 13.83,
		normalAttackGrowMax = 28.53,
		normalAttackMax = 249,
		profession = 2,
		equipType = EquipType.eWeapon,
		herosId = {
			114
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_xiangyaobaozhang.png"
		},
		jieJiAttrs = {
			{
				skillattack = 46,
				desc = "命中{+68},破击{+66}",
				mateCount = 200,
				normalattack = 192,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 93,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 383,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 139,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 575,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 239,
				equipCount = 1,
				mateCount = 680,
				skillattack = 186,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 767,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 239,
				equipCount = 1,
				mateCount = 840,
				skillattack = 232,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 958,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 239,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 279,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1150,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 239,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 325,
				desc = "破击{+204},暴击{+199},命中{+201}",
				normalattack = 1342,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 239,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 372,
				desc = "职业克制效果提升{15%}",
				normalattack = 1533,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 239,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 418,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1725,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 239,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 465,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1917,
				mateId = 200128,
				level = 150
			}
		}
	},
	[240] = {
		quality = 4,
		name = "轩辕神剑",
		skillAttackMax = 156,
		heroExtra = 0.1,
		headerImage = "small_xuanyuanshenjian.png",
		skillAttackGrowMax = 17.9,
		normalAttackGrowMax = 26.85,
		normalAttackMax = 234,
		profession = 1,
		equipType = EquipType.eWeapon,
		herosId = {
			116
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_yuanyuanjian.png"
		},
		jieJiAttrs = {
			{
				skillattack = 60,
				desc = "命中{+65},破击{+65}",
				mateCount = 200,
				normalattack = 179,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 119,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 357,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 179,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 536,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 240,
				equipCount = 1,
				mateCount = 680,
				skillattack = 238,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 714,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 240,
				equipCount = 1,
				mateCount = 840,
				skillattack = 298,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 893,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 240,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 357,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1072,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 240,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 417,
				desc = "破击{+205},暴击{+195},命中{+205}",
				normalattack = 1250,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 240,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 476,
				desc = "职业克制效果提升{15%}",
				normalattack = 1429,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 240,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 536,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1608,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 240,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 595,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1786,
				mateId = 200128,
				level = 150
			}
		}
	},
	[241] = {
		quality = 4,
		name = "神农宝叉",
		skillAttackMax = 144,
		heroExtra = 0.1,
		headerImage = "small_shenlongbaocha.png",
		skillAttackGrowMax = 18.07,
		normalAttackGrowMax = 27.11,
		normalAttackMax = 216,
		profession = 1,
		equipType = EquipType.eWeapon,
		herosId = {
			117
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_shenlongbaocha.png"
		},
		jieJiAttrs = {
			{
				skillattack = 60,
				desc = "命中{+65},破击{+66}",
				mateCount = 200,
				normalattack = 179,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 119,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 357,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 179,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 536,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 241,
				equipCount = 1,
				mateCount = 680,
				skillattack = 238,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 714,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 241,
				equipCount = 1,
				mateCount = 840,
				skillattack = 298,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 893,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 241,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 357,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1072,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 241,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 417,
				desc = "破击{+201},暴击{+197},命中{+203}",
				normalattack = 1250,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 241,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 476,
				desc = "职业克制效果提升{15%}",
				normalattack = 1429,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 241,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 536,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1608,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 241,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 595,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1786,
				mateId = 200128,
				level = 150
			}
		}
	},
	[242] = {
		quality = 4,
		name = "轮转真符",
		skillAttackMax = 291,
		heroExtra = 0,
		skillAttackGrowMax = 36.86,
		headerImage = "small_zhuanlunfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			122,
			123,
			125
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 119,
				desc = "破击{+65},暴击{+66}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 238,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 357,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 242,
				equipCount = 1,
				mateCount = 680,
				skillattack = 476,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 242,
				equipCount = 1,
				mateCount = 840,
				skillattack = 595,
				desc = "装备主将自身法攻提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 242,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 714,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 242,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 834,
				desc = "破击{+200},暴击{+198},命中{+196}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 242,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 953,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 242,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 1072,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 242,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 1191,
				desc = "装备主将自身法攻提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[243] = {
		quality = 4,
		name = "诛仙战符",
		skillAttackMax = 294,
		heroExtra = 0,
		skillAttackGrowMax = 34.02,
		headerImage = "small_zhuxianzhanfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			124,
			128
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 119,
				desc = "破击{+66},暴击{+65}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 238,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 357,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 243,
				equipCount = 1,
				mateCount = 680,
				skillattack = 476,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 243,
				equipCount = 1,
				mateCount = 840,
				skillattack = 595,
				desc = "装备主将自身法攻提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 243,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 714,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 243,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 834,
				desc = "破击{+198},暴击{+195},命中{+195}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 243,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 953,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 243,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 1072,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 243,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 1191,
				desc = "装备主将自身法攻提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[244] = {
		quality = 4,
		name = "重玄水符",
		skillAttackMax = 297,
		heroExtra = 0,
		skillAttackGrowMax = 34.38,
		headerImage = "small_chongxuanshuifu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			130,
			131
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 119,
				desc = "破击{+68},暴击{+66}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 238,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 357,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 244,
				equipCount = 1,
				mateCount = 680,
				skillattack = 476,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 244,
				equipCount = 1,
				mateCount = 840,
				skillattack = 595,
				desc = "装备主将自身法攻提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 244,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 714,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 244,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 834,
				desc = "破击{+197},暴击{+200},命中{+204}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 244,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 953,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 244,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 1072,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 244,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 1191,
				desc = "装备主将自身法攻提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[245] = {
		quality = 4,
		name = "业火神符",
		skillAttackMax = 300,
		heroExtra = 0,
		skillAttackGrowMax = 34.73,
		headerImage = "small_yehuoshenfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			126
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 119,
				desc = "破击{+66},暴击{+68}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 238,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 357,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 245,
				equipCount = 1,
				mateCount = 680,
				skillattack = 476,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 245,
				equipCount = 1,
				mateCount = 840,
				skillattack = 595,
				desc = "装备主将自身法攻提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 245,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 714,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 245,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 834,
				desc = "破击{+203},暴击{+200},命中{+199}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 245,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 953,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 245,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 1072,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 245,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 1191,
				desc = "装备主将自身法攻提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[246] = {
		quality = 4,
		name = "九黎神符",
		skillAttackMax = 303,
		heroExtra = 0,
		skillAttackGrowMax = 35.09,
		headerImage = "small_jiulishenfu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			127
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 119,
				desc = "破击{+67},暴击{+66}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 238,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 357,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 246,
				equipCount = 1,
				mateCount = 680,
				skillattack = 476,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 246,
				equipCount = 1,
				mateCount = 840,
				skillattack = 595,
				desc = "装备主将自身法攻提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 246,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 714,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 246,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 834,
				desc = "破击{+197},暴击{+201},命中{+198}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 246,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 953,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 246,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 1072,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 246,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 1191,
				desc = "装备主将自身法攻提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[247] = {
		quality = 4,
		name = "蛮荒鬼符",
		skillAttackMax = 306,
		heroExtra = 0,
		skillAttackGrowMax = 35.44,
		headerImage = "small_manhuangguifu.png",
		profession = 4,
		equipType = EquipType.eAmulet,
		herosId = {
			129
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				skillattack = 119,
				desc = "破击{+66},暴击{+67}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 238,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 357,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 247,
				equipCount = 1,
				mateCount = 680,
				skillattack = 476,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 247,
				equipCount = 1,
				mateCount = 840,
				skillattack = 595,
				desc = "装备主将自身法攻提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 247,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 714,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 247,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 834,
				desc = "破击{+195},暴击{+204},命中{+196}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 247,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 953,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 247,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 1072,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 247,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 1191,
				desc = "装备主将自身法攻提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[248] = {
		quality = 4,
		skillDefenseGrowMax = 18.07,
		skillDefenseMax = 155,
		heroExtra = 0,
		name = "九黎魔冠",
		headerImage = "small_jiulimoguan.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			123,
			124,
			125
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+67},韧性{+67}",
				mateCount = 200,
				skilldefense = 179,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				skilldefense = 357,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				skilldefense = 536,
				level = 45
			},
			{
				equipId = 248,
				equipCount = 1,
				mateCount = 680,
				skilldefense = 714,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 248,
				equipCount = 1,
				mateCount = 840,
				skilldefense = 893,
				desc = "装备主将自身法防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 248,
				equipCount = 2,
				mateCount = 1000,
				skilldefense = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 248,
				equipCount = 2,
				mateCount = 1160,
				skilldefense = 1250,
				desc = "闪避{+198},韧性{+204},格挡{+204}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 248,
				equipCount = 3,
				mateCount = 1320,
				skilldefense = 1429,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 248,
				equipCount = 3,
				mateCount = 1480,
				skilldefense = 1608,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 248,
				equipCount = 4,
				mateCount = 1640,
				skilldefense = 1786,
				desc = "装备主将自身法防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[249] = {
		quality = 4,
		skillDefenseGrowMax = 18.25,
		skillDefenseMax = 156,
		heroExtra = 0,
		name = "碧玺金冠",
		headerImage = "small_bixijinguan.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			122,
			128
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+66},韧性{+68}",
				mateCount = 200,
				skilldefense = 179,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				skilldefense = 357,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				skilldefense = 536,
				level = 45
			},
			{
				equipId = 249,
				equipCount = 1,
				mateCount = 680,
				skilldefense = 714,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 249,
				equipCount = 1,
				mateCount = 840,
				skilldefense = 893,
				desc = "装备主将自身法防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 249,
				equipCount = 2,
				mateCount = 1000,
				skilldefense = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 249,
				equipCount = 2,
				mateCount = 1160,
				skilldefense = 1250,
				desc = "闪避{+204},韧性{+201},格挡{+200}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 249,
				equipCount = 3,
				mateCount = 1320,
				skilldefense = 1429,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 249,
				equipCount = 3,
				mateCount = 1480,
				skilldefense = 1608,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 249,
				equipCount = 4,
				mateCount = 1640,
				skilldefense = 1786,
				desc = "装备主将自身法防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[250] = {
		quality = 4,
		skillDefenseGrowMax = 18.43,
		skillDefenseMax = 144,
		heroExtra = 0,
		name = "三清道冠",
		headerImage = "small_sanqingdaoguan.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			129,
			130
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+68},韧性{+66}",
				mateCount = 200,
				skilldefense = 179,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				skilldefense = 357,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				skilldefense = 536,
				level = 45
			},
			{
				equipId = 250,
				equipCount = 1,
				mateCount = 680,
				skilldefense = 714,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 250,
				equipCount = 1,
				mateCount = 840,
				skilldefense = 893,
				desc = "装备主将自身法防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 250,
				equipCount = 2,
				mateCount = 1000,
				skilldefense = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 250,
				equipCount = 2,
				mateCount = 1160,
				skilldefense = 1250,
				desc = "闪避{+196},韧性{+196},格挡{+197}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 250,
				equipCount = 3,
				mateCount = 1320,
				skilldefense = 1429,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 250,
				equipCount = 3,
				mateCount = 1480,
				skilldefense = 1608,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 250,
				equipCount = 4,
				mateCount = 1640,
				skilldefense = 1786,
				desc = "装备主将自身法防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[251] = {
		quality = 4,
		skillDefenseGrowMax = 17.01,
		skillDefenseMax = 146,
		heroExtra = 0,
		name = "磐龙玉冠",
		headerImage = "small_panlongyuguan.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			126
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+66},韧性{+67}",
				mateCount = 200,
				skilldefense = 179,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				skilldefense = 357,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				skilldefense = 536,
				level = 45
			},
			{
				equipId = 251,
				equipCount = 1,
				mateCount = 680,
				skilldefense = 714,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 251,
				equipCount = 1,
				mateCount = 840,
				skilldefense = 893,
				desc = "装备主将自身法防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 251,
				equipCount = 2,
				mateCount = 1000,
				skilldefense = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 251,
				equipCount = 2,
				mateCount = 1160,
				skilldefense = 1250,
				desc = "闪避{+205},韧性{+198},格挡{+196}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 251,
				equipCount = 3,
				mateCount = 1320,
				skilldefense = 1429,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 251,
				equipCount = 3,
				mateCount = 1480,
				skilldefense = 1608,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 251,
				equipCount = 4,
				mateCount = 1640,
				skilldefense = 1786,
				desc = "装备主将自身法防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[252] = {
		quality = 4,
		skillDefenseGrowMax = 17.19,
		skillDefenseMax = 147,
		heroExtra = 0,
		name = "九霄羽冠",
		headerImage = "small_jiuxiaoyuguan.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			127
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+67},韧性{+68}",
				mateCount = 200,
				skilldefense = 179,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				skilldefense = 357,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				skilldefense = 536,
				level = 45
			},
			{
				equipId = 252,
				equipCount = 1,
				mateCount = 680,
				skilldefense = 714,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 252,
				equipCount = 1,
				mateCount = 840,
				skilldefense = 893,
				desc = "装备主将自身法防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 252,
				equipCount = 2,
				mateCount = 1000,
				skilldefense = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 252,
				equipCount = 2,
				mateCount = 1160,
				skilldefense = 1250,
				desc = "闪避{+201},韧性{+199},格挡{+197}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 252,
				equipCount = 3,
				mateCount = 1320,
				skilldefense = 1429,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 252,
				equipCount = 3,
				mateCount = 1480,
				skilldefense = 1608,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 252,
				equipCount = 4,
				mateCount = 1640,
				skilldefense = 1786,
				desc = "装备主将自身法防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[253] = {
		quality = 4,
		skillDefenseGrowMax = 17.37,
		skillDefenseMax = 149,
		heroExtra = 0,
		name = "紫金魔冕",
		headerImage = "small_zijinmomian.png",
		profession = 4,
		equipType = EquipType.eHelmet,
		herosId = {
			131
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "闪避{+67},韧性{+68}",
				mateCount = 200,
				skilldefense = 179,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				skilldefense = 357,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				skilldefense = 536,
				level = 45
			},
			{
				equipId = 253,
				equipCount = 1,
				mateCount = 680,
				skilldefense = 714,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 253,
				equipCount = 1,
				mateCount = 840,
				skilldefense = 893,
				desc = "装备主将自身法防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 253,
				equipCount = 2,
				mateCount = 1000,
				skilldefense = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 253,
				equipCount = 2,
				mateCount = 1160,
				skilldefense = 1250,
				desc = "闪避{+195},韧性{+206},格挡{+197}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 253,
				equipCount = 3,
				mateCount = 1320,
				skilldefense = 1429,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 253,
				equipCount = 3,
				mateCount = 1480,
				skilldefense = 1608,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 253,
				equipCount = 4,
				mateCount = 1640,
				skilldefense = 1786,
				desc = "装备主将自身法防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[254] = {
		quality = 4,
		name = "乾坤战袍",
		normalDefenseMax = 75,
		heroExtra = 0,
		normalDefenseGrowMax = 8.77,
		headerImage = "small_qiankunzhanpao.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			125,
			128,
			130
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+66},韧性{+66}",
				mateCount = 200,
				normaldefense = 89,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				normaldefense = 179,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				normaldefense = 268,
				level = 45
			},
			{
				equipId = 254,
				equipCount = 1,
				mateCount = 680,
				normaldefense = 357,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 254,
				equipCount = 1,
				mateCount = 840,
				normaldefense = 447,
				desc = "装备主将自身普防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 254,
				equipCount = 2,
				mateCount = 1000,
				normaldefense = 536,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 254,
				equipCount = 2,
				mateCount = 1160,
				normaldefense = 625,
				desc = "闪避{+205},韧性{+198},格挡{+202}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 254,
				equipCount = 3,
				mateCount = 1320,
				normaldefense = 714,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 254,
				equipCount = 3,
				mateCount = 1480,
				normaldefense = 804,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 254,
				equipCount = 4,
				mateCount = 1640,
				normaldefense = 893,
				desc = "装备主将自身普防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[255] = {
		quality = 4,
		name = "九黎战甲",
		normalDefenseMax = 76,
		heroExtra = 0,
		normalDefenseGrowMax = 8.86,
		headerImage = "small_jiulizhanjia.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			122,
			124
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+67},韧性{+67}",
				mateCount = 200,
				normaldefense = 89,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				normaldefense = 179,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				normaldefense = 268,
				level = 45
			},
			{
				equipId = 255,
				equipCount = 1,
				mateCount = 680,
				normaldefense = 357,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 255,
				equipCount = 1,
				mateCount = 840,
				normaldefense = 447,
				desc = "装备主将自身普防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 255,
				equipCount = 2,
				mateCount = 1000,
				normaldefense = 536,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 255,
				equipCount = 2,
				mateCount = 1160,
				normaldefense = 625,
				desc = "闪避{+195},韧性{+200},格挡{+199}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 255,
				equipCount = 3,
				mateCount = 1320,
				normaldefense = 714,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 255,
				equipCount = 3,
				mateCount = 1480,
				normaldefense = 804,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 255,
				equipCount = 4,
				mateCount = 1640,
				normaldefense = 893,
				desc = "装备主将自身普防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[256] = {
		quality = 4,
		name = "修罗魔铠",
		normalDefenseMax = 77,
		heroExtra = 0,
		normalDefenseGrowMax = 9.04,
		headerImage = "small_xiuluomogai.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			123,
			126
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+67},韧性{+67}",
				mateCount = 200,
				normaldefense = 89,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				normaldefense = 179,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				normaldefense = 268,
				level = 45
			},
			{
				equipId = 256,
				equipCount = 1,
				mateCount = 680,
				normaldefense = 357,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 256,
				equipCount = 1,
				mateCount = 840,
				normaldefense = 447,
				desc = "装备主将自身普防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 256,
				equipCount = 2,
				mateCount = 1000,
				normaldefense = 536,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 256,
				equipCount = 2,
				mateCount = 1160,
				normaldefense = 625,
				desc = "闪避{+205},韧性{+199},格挡{+200}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 256,
				equipCount = 3,
				mateCount = 1320,
				normaldefense = 714,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 256,
				equipCount = 3,
				mateCount = 1480,
				normaldefense = 804,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 256,
				equipCount = 4,
				mateCount = 1640,
				normaldefense = 893,
				desc = "装备主将自身普防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[257] = {
		quality = 4,
		name = "弥罗袈裟",
		normalDefenseMax = 77,
		heroExtra = 0,
		normalDefenseGrowMax = 9.13,
		headerImage = "small_miluojiasha.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			127
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+67},韧性{+66}",
				mateCount = 200,
				normaldefense = 89,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				normaldefense = 179,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				normaldefense = 268,
				level = 45
			},
			{
				equipId = 257,
				equipCount = 1,
				mateCount = 680,
				normaldefense = 357,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 257,
				equipCount = 1,
				mateCount = 840,
				normaldefense = 447,
				desc = "装备主将自身普防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 257,
				equipCount = 2,
				mateCount = 1000,
				normaldefense = 536,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 257,
				equipCount = 2,
				mateCount = 1160,
				normaldefense = 625,
				desc = "闪避{+195},韧性{+196},格挡{+196}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 257,
				equipCount = 3,
				mateCount = 1320,
				normaldefense = 714,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 257,
				equipCount = 3,
				mateCount = 1480,
				normaldefense = 804,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 257,
				equipCount = 4,
				mateCount = 1640,
				normaldefense = 893,
				desc = "装备主将自身普防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[258] = {
		quality = 4,
		name = "金缕玉衣",
		normalDefenseMax = 78,
		heroExtra = 0,
		normalDefenseGrowMax = 9.21,
		headerImage = "small_jinlvyuyi.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			129
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+67},韧性{+68}",
				mateCount = 200,
				normaldefense = 89,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				normaldefense = 179,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				normaldefense = 268,
				level = 45
			},
			{
				equipId = 258,
				equipCount = 1,
				mateCount = 680,
				normaldefense = 357,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 258,
				equipCount = 1,
				mateCount = 840,
				normaldefense = 447,
				desc = "装备主将自身普防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 258,
				equipCount = 2,
				mateCount = 1000,
				normaldefense = 536,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 258,
				equipCount = 2,
				mateCount = 1160,
				normaldefense = 625,
				desc = "闪避{+204},韧性{+196},格挡{+201}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 258,
				equipCount = 3,
				mateCount = 1320,
				normaldefense = 714,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 258,
				equipCount = 3,
				mateCount = 1480,
				normaldefense = 804,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 258,
				equipCount = 4,
				mateCount = 1640,
				normaldefense = 893,
				desc = "装备主将自身普防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[259] = {
		quality = 4,
		name = "炎火战铠",
		normalDefenseMax = 72,
		heroExtra = 0,
		normalDefenseGrowMax = 8.51,
		headerImage = "small_yanhuozhangai.png",
		profession = 4,
		equipType = EquipType.eClothes,
		herosId = {
			131
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				mateId = 200128,
				desc = "格挡{+68},韧性{+67}",
				mateCount = 200,
				normaldefense = 89,
				level = 0
			},
			{
				mateId = 200128,
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				normaldefense = 179,
				level = 30
			},
			{
				mateId = 200128,
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				normaldefense = 268,
				level = 45
			},
			{
				equipId = 259,
				equipCount = 1,
				mateCount = 680,
				normaldefense = 357,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 259,
				equipCount = 1,
				mateCount = 840,
				normaldefense = 447,
				desc = "装备主将自身普防提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 259,
				equipCount = 2,
				mateCount = 1000,
				normaldefense = 536,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 259,
				equipCount = 2,
				mateCount = 1160,
				normaldefense = 625,
				desc = "闪避{+205},韧性{+200},格挡{+195}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 259,
				equipCount = 3,
				mateCount = 1320,
				normaldefense = 714,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 259,
				equipCount = 3,
				mateCount = 1480,
				normaldefense = 804,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 259,
				equipCount = 4,
				mateCount = 1640,
				normaldefense = 893,
				desc = "装备主将自身普防提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[260] = {
		quality = 4,
		healthGrowMax = 103.13,
		name = "九黎魔戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_jiulimojie.png",
		healthMax = 864,
		equipType = EquipType.eRing,
		herosId = {
			122,
			126,
			130
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				desc = "闪避{+68},格挡{+66}",
				mateCount = 200,
				health = 1072,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				health = 2143,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				health = 3215,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 260,
				equipCount = 1,
				mateCount = 680,
				health = 4287,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 260,
				equipCount = 1,
				mateCount = 840,
				health = 5359,
				desc = "装备主将自身生命提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 260,
				equipCount = 2,
				mateCount = 1000,
				health = 6430,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 260,
				equipCount = 2,
				mateCount = 1160,
				health = 7502,
				desc = "闪避{+203},韧性{+200},格挡{+202}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 260,
				equipCount = 3,
				mateCount = 1320,
				health = 8574,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 260,
				equipCount = 3,
				mateCount = 1480,
				health = 9645,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 260,
				equipCount = 4,
				mateCount = 1640,
				health = 10717,
				desc = "装备主将自身生命提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[261] = {
		quality = 4,
		healthGrowMax = 104.19,
		name = "龙骨魂戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_longguhunjie.png",
		healthMax = 873,
		equipType = EquipType.eRing,
		herosId = {
			125,
			128
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				desc = "闪避{+67},格挡{+65}",
				mateCount = 200,
				health = 1072,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				health = 2143,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				health = 3215,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 261,
				equipCount = 1,
				mateCount = 680,
				health = 4287,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 261,
				equipCount = 1,
				mateCount = 840,
				health = 5359,
				desc = "装备主将自身生命提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 261,
				equipCount = 2,
				mateCount = 1000,
				health = 6430,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 261,
				equipCount = 2,
				mateCount = 1160,
				health = 7502,
				desc = "闪避{+198},韧性{+204},格挡{+194}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 261,
				equipCount = 3,
				mateCount = 1320,
				health = 8574,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 261,
				equipCount = 3,
				mateCount = 1480,
				health = 9645,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 261,
				equipCount = 4,
				mateCount = 1640,
				health = 10717,
				desc = "装备主将自身生命提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[262] = {
		quality = 4,
		healthGrowMax = 105.26,
		name = "琥珀神戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_huposhenjie.png",
		healthMax = 882,
		equipType = EquipType.eRing,
		herosId = {
			123,
			124
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				desc = "闪避{+65},格挡{+66}",
				mateCount = 200,
				health = 1072,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				health = 2143,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				health = 3215,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 262,
				equipCount = 1,
				mateCount = 680,
				health = 4287,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 262,
				equipCount = 1,
				mateCount = 840,
				health = 5359,
				desc = "装备主将自身生命提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 262,
				equipCount = 2,
				mateCount = 1000,
				health = 6430,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 262,
				equipCount = 2,
				mateCount = 1160,
				health = 7502,
				desc = "闪避{+206},韧性{+204},格挡{+194}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 262,
				equipCount = 3,
				mateCount = 1320,
				health = 8574,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 262,
				equipCount = 3,
				mateCount = 1480,
				health = 9645,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 262,
				equipCount = 4,
				mateCount = 1640,
				health = 10717,
				desc = "装备主将自身生命提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[263] = {
		quality = 4,
		healthGrowMax = 106.32,
		name = "琉璃玉戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_liuliyujie.png",
		healthMax = 891,
		equipType = EquipType.eRing,
		herosId = {
			127
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				desc = "闪避{+69},格挡{+68}",
				mateCount = 200,
				health = 1072,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				health = 2143,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				health = 3215,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 263,
				equipCount = 1,
				mateCount = 680,
				health = 4287,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 263,
				equipCount = 1,
				mateCount = 840,
				health = 5359,
				desc = "装备主将自身生命提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 263,
				equipCount = 2,
				mateCount = 1000,
				health = 6430,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 263,
				equipCount = 2,
				mateCount = 1160,
				health = 7502,
				desc = "闪避{+200},韧性{+196},格挡{+199}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 263,
				equipCount = 3,
				mateCount = 1320,
				health = 8574,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 263,
				equipCount = 3,
				mateCount = 1480,
				health = 9645,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 263,
				equipCount = 4,
				mateCount = 1640,
				health = 10717,
				desc = "装备主将自身生命提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[264] = {
		quality = 4,
		healthGrowMax = 108.45,
		name = "貔貅宝戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_pixiubaojie.png",
		healthMax = 891,
		equipType = EquipType.eRing,
		herosId = {
			129
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				desc = "闪避{+68},格挡{+66}",
				mateCount = 200,
				health = 1072,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				health = 2143,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				health = 3215,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 264,
				equipCount = 1,
				mateCount = 680,
				health = 4287,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 264,
				equipCount = 1,
				mateCount = 840,
				health = 5359,
				desc = "装备主将自身生命提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 264,
				equipCount = 2,
				mateCount = 1000,
				health = 6430,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 264,
				equipCount = 2,
				mateCount = 1160,
				health = 7502,
				desc = "闪避{+195},韧性{+197},格挡{+198}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 264,
				equipCount = 3,
				mateCount = 1320,
				health = 8574,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 264,
				equipCount = 3,
				mateCount = 1480,
				health = 9645,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 264,
				equipCount = 4,
				mateCount = 1640,
				health = 10717,
				desc = "装备主将自身生命提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[265] = {
		quality = 4,
		healthGrowMax = 109.51,
		name = "碧玺神戒",
		heroExtra = 0,
		profession = 4,
		headerImage = "small_bixishenjie.png",
		healthMax = 900,
		equipType = EquipType.eRing,
		herosId = {
			131
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				desc = "闪避{+68},格挡{+67}",
				mateCount = 200,
				health = 1072,
				mateId = 200128,
				level = 0
			},
			{
				desc = "进入战斗时，敌人初始怒气降低15点",
				mateCount = 360,
				health = 2143,
				mateId = 200128,
				level = 30
			},
			{
				desc = "职业被克制效果降低{10%}",
				mateCount = 520,
				health = 3215,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 265,
				equipCount = 1,
				mateCount = 680,
				health = 4287,
				desc = "战斗中被攻击最终伤害减少{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 265,
				equipCount = 1,
				mateCount = 840,
				health = 5359,
				desc = "装备主将自身生命提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 265,
				equipCount = 2,
				mateCount = 1000,
				health = 6430,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 265,
				equipCount = 2,
				mateCount = 1160,
				health = 7502,
				desc = "闪避{+205},韧性{+195},格挡{+198}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 265,
				equipCount = 3,
				mateCount = 1320,
				health = 8574,
				desc = "职业被克制效果降低{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 265,
				equipCount = 3,
				mateCount = 1480,
				health = 9645,
				desc = "战斗中被攻击最终伤害减少{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 265,
				equipCount = 4,
				mateCount = 1640,
				health = 10717,
				desc = "装备主将自身生命提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[266] = {
		speedGrowMax = 18.43,
		quality = 4,
		name = "九黎魔链",
		speedMax = 152,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_jiulimolian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			123,
			124,
			125
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 179,
				desc = "命中{+66},暴击{+65}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				speed = 357,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				speed = 536,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 266,
				equipCount = 1,
				mateCount = 680,
				speed = 714,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 266,
				equipCount = 1,
				mateCount = 840,
				speed = 893,
				desc = "装备主将自身速度提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 266,
				equipCount = 2,
				mateCount = 1000,
				speed = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 266,
				equipCount = 2,
				mateCount = 1160,
				speed = 1250,
				desc = "破击{+201},暴击{+199},命中{+199}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 266,
				equipCount = 3,
				mateCount = 1320,
				speed = 1429,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 266,
				equipCount = 3,
				mateCount = 1480,
				speed = 1608,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 266,
				equipCount = 4,
				mateCount = 1640,
				speed = 1786,
				desc = "装备主将自身速度提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[267] = {
		speedGrowMax = 17.01,
		quality = 4,
		name = "蛮荒锁链",
		speedMax = 153,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_manhuangsuolian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			122,
			128
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 179,
				desc = "命中{+66},暴击{+68}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				speed = 357,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				speed = 536,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 267,
				equipCount = 1,
				mateCount = 680,
				speed = 714,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 267,
				equipCount = 1,
				mateCount = 840,
				speed = 893,
				desc = "装备主将自身速度提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 267,
				equipCount = 2,
				mateCount = 1000,
				speed = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 267,
				equipCount = 2,
				mateCount = 1160,
				speed = 1250,
				desc = "破击{+201},暴击{+196},命中{+195}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 267,
				equipCount = 3,
				mateCount = 1320,
				speed = 1429,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 267,
				equipCount = 3,
				mateCount = 1480,
				speed = 1608,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 267,
				equipCount = 4,
				mateCount = 1640,
				speed = 1786,
				desc = "装备主将自身速度提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[268] = {
		speedGrowMax = 17.19,
		quality = 4,
		name = "骷髅魔链",
		speedMax = 155,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_kuloumolian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			129,
			130
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 179,
				desc = "命中{+68},暴击{+67}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				speed = 357,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				speed = 536,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 268,
				equipCount = 1,
				mateCount = 680,
				speed = 714,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 268,
				equipCount = 1,
				mateCount = 840,
				speed = 893,
				desc = "装备主将自身速度提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 268,
				equipCount = 2,
				mateCount = 1000,
				speed = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 268,
				equipCount = 2,
				mateCount = 1160,
				speed = 1250,
				desc = "破击{+200},暴击{+198},命中{+199}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 268,
				equipCount = 3,
				mateCount = 1320,
				speed = 1429,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 268,
				equipCount = 3,
				mateCount = 1480,
				speed = 1608,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 268,
				equipCount = 4,
				mateCount = 1640,
				speed = 1786,
				desc = "装备主将自身速度提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[269] = {
		speedGrowMax = 17.37,
		quality = 4,
		name = "无极神链",
		speedMax = 156,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_wujishenlian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			126
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 179,
				desc = "命中{+66},暴击{+67}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				speed = 357,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				speed = 536,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 269,
				equipCount = 1,
				mateCount = 680,
				speed = 714,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 269,
				equipCount = 1,
				mateCount = 840,
				speed = 893,
				desc = "装备主将自身速度提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 269,
				equipCount = 2,
				mateCount = 1000,
				speed = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 269,
				equipCount = 2,
				mateCount = 1160,
				speed = 1250,
				desc = "破击{+205},暴击{+194},命中{+203}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 269,
				equipCount = 3,
				mateCount = 1320,
				speed = 1429,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 269,
				equipCount = 3,
				mateCount = 1480,
				speed = 1608,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 269,
				equipCount = 4,
				mateCount = 1640,
				speed = 1786,
				desc = "装备主将自身速度提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[270] = {
		speedGrowMax = 17.54,
		quality = 4,
		name = "太极神链",
		speedMax = 144,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_taijishenlian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			127
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 179,
				desc = "命中{+68},暴击{+66}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				speed = 357,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				speed = 536,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 270,
				equipCount = 1,
				mateCount = 680,
				speed = 714,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 270,
				equipCount = 1,
				mateCount = 840,
				speed = 893,
				desc = "装备主将自身速度提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 270,
				equipCount = 2,
				mateCount = 1000,
				speed = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 270,
				equipCount = 2,
				mateCount = 1160,
				speed = 1250,
				desc = "破击{+206},暴击{+196},命中{+202}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 270,
				equipCount = 3,
				mateCount = 1320,
				speed = 1429,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 270,
				equipCount = 3,
				mateCount = 1480,
				speed = 1608,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 270,
				equipCount = 4,
				mateCount = 1640,
				speed = 1786,
				desc = "装备主将自身速度提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[271] = {
		speedGrowMax = 17.72,
		quality = 4,
		name = "九转神链",
		speedMax = 146,
		heroExtra = 0,
		profession = 4,
		headerImage = "small_jiuzhuanshenlian.png",
		equipType = EquipType.eNecklace,
		herosId = {
			131
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		jieJiAttrs = {
			{
				speed = 179,
				desc = "命中{+66},暴击{+65}",
				mateCount = 200,
				mateId = 200128,
				level = 0
			},
			{
				speed = 357,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				mateId = 200128,
				level = 30
			},
			{
				speed = 536,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 271,
				equipCount = 1,
				mateCount = 680,
				speed = 714,
				desc = "战斗中最终伤害增加{10%}",
				mateId = 200128,
				level = 60
			},
			{
				equipId = 271,
				equipCount = 1,
				mateCount = 840,
				speed = 893,
				desc = "装备主将自身速度提升{10%}",
				mateId = 200128,
				level = 75
			},
			{
				equipId = 271,
				equipCount = 2,
				mateCount = 1000,
				speed = 1072,
				desc = "装备后自身怒击法术等级+3",
				mateId = 200128,
				level = 90
			},
			{
				equipId = 271,
				equipCount = 2,
				mateCount = 1160,
				speed = 1250,
				desc = "破击{+198},暴击{+199},命中{+201}",
				mateId = 200128,
				level = 105
			},
			{
				equipId = 271,
				equipCount = 3,
				mateCount = 1320,
				speed = 1429,
				desc = "职业克制效果提升{15%}",
				mateId = 200128,
				level = 120
			},
			{
				equipId = 271,
				equipCount = 3,
				mateCount = 1480,
				speed = 1608,
				desc = "战斗中最终伤害增加{20%}",
				mateId = 200128,
				level = 135
			},
			{
				equipId = 271,
				equipCount = 4,
				mateCount = 1640,
				speed = 1786,
				desc = "装备主将自身速度提升{15%}",
				mateId = 200128,
				level = 150
			}
		}
	},
	[272] = {
		quality = 4,
		name = "神罚珠",
		skillAttackMax = 168,
		heroExtra = 0.1,
		headerImage = "small_shengfazhu.png",
		skillAttackGrowMax = 20.45,
		normalAttackGrowMax = 25.57,
		normalAttackMax = 210,
		profession = 3,
		equipType = EquipType.eWeapon,
		herosId = {
			122
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_shengfazhu.png",
			"big_shengfazhu_f.png"
		},
		jieJiAttrs = {
			{
				skillattack = 68,
				desc = "命中{+67},破击{+68}",
				mateCount = 200,
				normalattack = 170,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 136,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 340,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 204,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 510,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 272,
				equipCount = 1,
				mateCount = 680,
				skillattack = 272,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 680,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 272,
				equipCount = 1,
				mateCount = 840,
				skillattack = 340,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 851,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 272,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 408,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1021,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 272,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 476,
				desc = "破击{+205},暴击{+199},命中{+202}",
				normalattack = 1191,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 272,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 544,
				desc = "职业克制效果提升{15%}",
				normalattack = 1361,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 272,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 612,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1531,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 272,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 680,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1701,
				mateId = 200128,
				level = 150
			}
		}
	},
	[273] = {
		quality = 4,
		name = "开天斧",
		skillAttackMax = 97,
		heroExtra = 0.1,
		headerImage = "small_kuloushuangmianfu.png",
		skillAttackGrowMax = 11.77,
		normalAttackGrowMax = 30.26,
		normalAttackMax = 249,
		profession = 2,
		equipType = EquipType.eWeapon,
		herosId = {
			123
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_kuloushuangmianfu.png"
		},
		jieJiAttrs = {
			{
				skillattack = 39,
				desc = "命中{+66},破击{+69}",
				mateCount = 200,
				normalattack = 199,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 78,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 399,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 116,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 598,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 273,
				equipCount = 1,
				mateCount = 680,
				skillattack = 155,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 798,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 273,
				equipCount = 1,
				mateCount = 840,
				skillattack = 194,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 997,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 273,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 233,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1196,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 273,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 271,
				desc = "破击{+203},暴击{+195},命中{+203}",
				normalattack = 1396,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 273,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 310,
				desc = "职业克制效果提升{15%}",
				normalattack = 1595,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 273,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 349,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1794,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 273,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 388,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1994,
				mateId = 200128,
				level = 150
			}
		}
	},
	[274] = {
		quality = 4,
		name = "龙头镰",
		skillAttackMax = 117,
		heroExtra = 0.1,
		headerImage = "small_longtoushuangmianlian.png",
		skillAttackGrowMax = 14.25,
		normalAttackGrowMax = 29.38,
		normalAttackMax = 241,
		profession = 2,
		equipType = EquipType.eWeapon,
		herosId = {
			124
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_longtoushuangmianlian.png"
		},
		jieJiAttrs = {
			{
				skillattack = 46,
				desc = "命中{+68},破击{+67}",
				mateCount = 200,
				normalattack = 192,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 93,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 383,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 139,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 575,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 274,
				equipCount = 1,
				mateCount = 680,
				skillattack = 186,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 767,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 274,
				equipCount = 1,
				mateCount = 840,
				skillattack = 232,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 958,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 274,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 279,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1150,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 274,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 325,
				desc = "破击{+196},暴击{+198},命中{+200}",
				normalattack = 1342,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 274,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 372,
				desc = "职业克制效果提升{15%}",
				normalattack = 1533,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 274,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 418,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1725,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 274,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 465,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1917,
				mateId = 200128,
				level = 150
			}
		}
	},
	[275] = {
		quality = 4,
		name = "随心铁杆",
		skillAttackMax = 118,
		heroExtra = 0.1,
		headerImage = "small_suixingtiegangbing.png",
		skillAttackGrowMax = 13.28,
		normalAttackGrowMax = 27.38,
		normalAttackMax = 244,
		profession = 2,
		equipType = EquipType.eWeapon,
		herosId = {
			125
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_suixingtiegangbing.png"
		},
		jieJiAttrs = {
			{
				skillattack = 46,
				desc = "命中{+66},破击{+65}",
				mateCount = 200,
				normalattack = 192,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 93,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 383,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 139,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 575,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 275,
				equipCount = 1,
				mateCount = 680,
				skillattack = 186,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 767,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 275,
				equipCount = 1,
				mateCount = 840,
				skillattack = 232,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 958,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 275,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 279,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1150,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 275,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 325,
				desc = "破击{+202},暴击{+199},命中{+199}",
				normalattack = 1342,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 275,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 372,
				desc = "职业克制效果提升{15%}",
				normalattack = 1533,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 275,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 418,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1725,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 275,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 465,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1917,
				mateId = 200128,
				level = 150
			}
		}
	},
	[276] = {
		quality = 4,
		name = "战神戚",
		skillAttackMax = 100,
		heroExtra = 0.1,
		headerImage = "small_shuangmianfu.png",
		skillAttackGrowMax = 11.08,
		normalAttackGrowMax = 28.48,
		normalAttackMax = 256,
		profession = 2,
		equipType = EquipType.eWeapon,
		herosId = {
			126
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_shuangmianfu.png"
		},
		jieJiAttrs = {
			{
				skillattack = 39,
				desc = "命中{+67},破击{+66}",
				mateCount = 200,
				normalattack = 199,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 78,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 399,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 116,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 598,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 276,
				equipCount = 1,
				mateCount = 680,
				skillattack = 155,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 798,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 276,
				equipCount = 1,
				mateCount = 840,
				skillattack = 194,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 997,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 276,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 233,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1196,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 276,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 271,
				desc = "破击{+203},暴击{+202},命中{+205}",
				normalattack = 1396,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 276,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 310,
				desc = "职业克制效果提升{15%}",
				normalattack = 1595,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 276,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 349,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1794,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 276,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 388,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1994,
				mateId = 200128,
				level = 150
			}
		}
	},
	[277] = {
		quality = 4,
		name = "填海锤",
		skillAttackMax = 153,
		heroExtra = 0.1,
		headerImage = "small_tianhaichui.png",
		skillAttackGrowMax = 17.19,
		normalAttackGrowMax = 25.78,
		normalAttackMax = 230,
		profession = 1,
		equipType = EquipType.eWeapon,
		herosId = {
			127
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_tianhaichui.png"
		},
		jieJiAttrs = {
			{
				skillattack = 60,
				desc = "命中{+65},破击{+66}",
				mateCount = 200,
				normalattack = 179,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 119,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 357,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 179,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 536,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 277,
				equipCount = 1,
				mateCount = 680,
				skillattack = 238,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 714,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 277,
				equipCount = 1,
				mateCount = 840,
				skillattack = 298,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 893,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 277,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 357,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1072,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 277,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 417,
				desc = "破击{+203},暴击{+198},命中{+202}",
				normalattack = 1250,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 277,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 476,
				desc = "职业克制效果提升{15%}",
				normalattack = 1429,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 277,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 536,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1608,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 277,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 595,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1786,
				mateId = 200128,
				level = 150
			}
		}
	},
	[278] = {
		quality = 4,
		name = "世间百书",
		skillAttackMax = 208,
		heroExtra = 0.1,
		headerImage = "small_shijianbaishu.png",
		skillAttackGrowMax = 23.42,
		normalAttackGrowMax = 23.02,
		normalAttackMax = 205,
		profession = 3,
		equipType = EquipType.eWeapon,
		herosId = {
			128
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_shijianbaishu.png",
			"big_shijianbaishu_f.png"
		},
		jieJiAttrs = {
			{
				skillattack = 80,
				desc = "命中{+69},破击{+67}",
				mateCount = 200,
				normalattack = 158,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 161,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 316,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 241,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 474,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 278,
				equipCount = 1,
				mateCount = 680,
				skillattack = 321,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 631,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 278,
				equipCount = 1,
				mateCount = 840,
				skillattack = 402,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 789,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 278,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 482,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 947,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 278,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 562,
				desc = "破击{+194},暴击{+203},命中{+196}",
				normalattack = 1105,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 278,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 642,
				desc = "职业克制效果提升{15%}",
				normalattack = 1263,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 278,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 723,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1421,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 278,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 803,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1578,
				mateId = 200128,
				level = 150
			}
		}
	},
	[279] = {
		quality = 4,
		name = "御海剑",
		skillAttackMax = 156,
		heroExtra = 0.1,
		headerImage = "small_yuhaijian.png",
		skillAttackGrowMax = 17.54,
		normalAttackGrowMax = 26.31,
		normalAttackMax = 234,
		profession = 1,
		equipType = EquipType.eWeapon,
		herosId = {
			129
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_yuhaijian.png"
		},
		jieJiAttrs = {
			{
				skillattack = 60,
				desc = "命中{+67},破击{+67}",
				mateCount = 200,
				normalattack = 179,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 119,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 357,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 179,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 536,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 279,
				equipCount = 1,
				mateCount = 680,
				skillattack = 238,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 714,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 279,
				equipCount = 1,
				mateCount = 840,
				skillattack = 298,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 893,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 279,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 357,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1072,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 279,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 417,
				desc = "破击{+201},暴击{+204},命中{+205}",
				normalattack = 1250,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 279,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 476,
				desc = "职业克制效果提升{15%}",
				normalattack = 1429,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 279,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 536,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1608,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 279,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 595,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1786,
				mateId = 200128,
				level = 150
			}
		}
	},
	[280] = {
		quality = 4,
		name = "洛神赋",
		skillAttackMax = 144,
		heroExtra = 0.1,
		headerImage = "small_luoshenfu.png",
		skillAttackGrowMax = 17.72,
		normalAttackGrowMax = 26.58,
		normalAttackMax = 216,
		profession = 1,
		equipType = EquipType.eWeapon,
		herosId = {
			130
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_luoshenfu.png"
		},
		jieJiAttrs = {
			{
				skillattack = 60,
				desc = "命中{+68},破击{+66}",
				mateCount = 200,
				normalattack = 179,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 119,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 357,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 179,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 536,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 280,
				equipCount = 1,
				mateCount = 680,
				skillattack = 238,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 714,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 280,
				equipCount = 1,
				mateCount = 840,
				skillattack = 298,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 893,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 280,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 357,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1072,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 280,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 417,
				desc = "破击{+196},暴击{+202},命中{+198}",
				normalattack = 1250,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 280,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 476,
				desc = "职业克制效果提升{15%}",
				normalattack = 1429,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 280,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 536,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1608,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 280,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 595,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1786,
				mateId = 200128,
				level = 150
			}
		}
	},
	[281] = {
		quality = 4,
		name = "芭蕉扇",
		skillAttackMax = 166,
		heroExtra = 0.1,
		headerImage = "small_bajiaoshan.png",
		skillAttackGrowMax = 20.45,
		normalAttackGrowMax = 25.57,
		normalAttackMax = 208,
		profession = 3,
		equipType = EquipType.eWeapon,
		herosId = {
			131
		},
		feedAttrs = {
			BattleAttrsType.eMingZhong,
			BattleAttrsType.eBaoJi,
			BattleAttrsType.ePoJi
		},
		skin = {
			"big_bajiaoshan.png",
			"big_bajiaoshan_f.png"
		},
		jieJiAttrs = {
			{
				skillattack = 68,
				desc = "命中{+67},破击{+67}",
				mateCount = 200,
				normalattack = 170,
				mateId = 200128,
				level = 0
			},
			{
				skillattack = 136,
				desc = "进入战斗时，初始怒气提升15点",
				mateCount = 360,
				normalattack = 340,
				mateId = 200128,
				level = 30
			},
			{
				skillattack = 204,
				desc = "职业克制效果提升{10%}",
				mateCount = 520,
				normalattack = 510,
				mateId = 200128,
				level = 45
			},
			{
				equipId = 281,
				equipCount = 1,
				mateCount = 680,
				skillattack = 272,
				desc = "战斗中最终伤害增加{10%}",
				normalattack = 680,
				mateId = 200128,
				level = 60
			},
			{
				equipId = 281,
				equipCount = 1,
				mateCount = 840,
				skillattack = 340,
				desc = "装备主将自身普攻提升{10%}",
				normalattack = 851,
				mateId = 200128,
				level = 75
			},
			{
				equipId = 281,
				equipCount = 2,
				mateCount = 1000,
				skillattack = 408,
				desc = "装备后自身怒击法术等级+3",
				normalattack = 1021,
				mateId = 200128,
				level = 90
			},
			{
				equipId = 281,
				equipCount = 2,
				mateCount = 1160,
				skillattack = 476,
				desc = "破击{+205},暴击{+204},命中{+197}",
				normalattack = 1191,
				mateId = 200128,
				level = 105
			},
			{
				equipId = 281,
				equipCount = 3,
				mateCount = 1320,
				skillattack = 544,
				desc = "职业克制效果提升{15%}",
				normalattack = 1361,
				mateId = 200128,
				level = 120
			},
			{
				equipId = 281,
				equipCount = 3,
				mateCount = 1480,
				skillattack = 612,
				desc = "战斗中最终伤害增加{20%}",
				normalattack = 1531,
				mateId = 200128,
				level = 135
			},
			{
				equipId = 281,
				equipCount = 4,
				mateCount = 1640,
				skillattack = 680,
				desc = "装备主将自身普攻提升{15%}",
				normalattack = 1701,
				mateId = 200128,
				level = 150
			}
		}
	}
}
BaseFragments = {
	{
		equipId = 1,
		name = "道士符碎片",
		exchangeCount = 3,
		price = 420,
		quality = QualityType.eGreen
	},
	{
		equipId = 2,
		name = "净衣符碎片",
		exchangeCount = 5,
		price = 234,
		quality = QualityType.eBlue
	},
	{
		equipId = 3,
		name = "巫咒符碎片",
		exchangeCount = 3,
		price = 398,
		quality = QualityType.eGreen
	},
	{
		equipId = 4,
		name = "驭雷符碎片",
		exchangeCount = 5,
		price = 255,
		quality = QualityType.eBlue
	},
	{
		equipId = 5,
		name = "天师符碎片",
		exchangeCount = 3,
		price = 391,
		quality = QualityType.eGreen
	},
	{
		equipId = 6,
		name = "大力符碎片",
		exchangeCount = 5,
		price = 244,
		quality = QualityType.eBlue
	},
	{
		equipId = 7,
		name = "天灵符碎片",
		exchangeCount = 12,
		price = 200,
		quality = QualityType.ePurple
	},
	{
		equipId = 8,
		name = "地灵符碎片",
		exchangeCount = 5,
		price = 494,
		quality = QualityType.eBlue
	},
	{
		equipId = 9,
		name = "金灵符碎片",
		exchangeCount = 12,
		price = 201,
		quality = QualityType.ePurple
	},
	{
		equipId = 10,
		name = "木灵符碎片",
		exchangeCount = 5,
		price = 482,
		quality = QualityType.eBlue
	},
	{
		equipId = 11,
		name = "水灵符碎片",
		exchangeCount = 5,
		price = 486,
		quality = QualityType.eBlue
	},
	{
		equipId = 12,
		name = "火灵符碎片",
		exchangeCount = 5,
		price = 482,
		quality = QualityType.eBlue
	},
	{
		equipId = 13,
		name = "土灵符碎片",
		exchangeCount = 5,
		price = 493,
		quality = QualityType.eBlue
	},
	{
		equipId = 14,
		name = "通灵符碎片",
		exchangeCount = 12,
		price = 202,
		quality = QualityType.ePurple
	},
	{
		equipId = 15,
		name = "妖灵符碎片",
		exchangeCount = 12,
		price = 206,
		quality = QualityType.ePurple
	},
	{
		equipId = 16,
		name = "元灵符碎片",
		exchangeCount = 12,
		price = 205,
		quality = QualityType.ePurple
	},
	{
		equipId = 17,
		name = "天尊符碎片",
		exchangeCount = 12,
		price = 411,
		quality = QualityType.ePurple
	},
	{
		equipId = 18,
		name = "降魔符碎片",
		exchangeCount = 12,
		price = 406,
		quality = QualityType.ePurple
	},
	{
		equipId = 19,
		name = "噬魂符碎片",
		exchangeCount = 12,
		price = 404,
		quality = QualityType.ePurple
	},
	{
		equipId = 20,
		name = "观音符碎片",
		exchangeCount = 12,
		price = 409,
		quality = QualityType.ePurple
	},
	{
		equipId = 21,
		name = "血魂符碎片",
		exchangeCount = 12,
		price = 411,
		quality = QualityType.ePurple
	},
	{
		equipId = 22,
		name = "定妖符碎片",
		exchangeCount = 12,
		price = 402,
		quality = QualityType.ePurple
	},
	{
		equipId = 23,
		name = "聚魂符碎片",
		exchangeCount = 12,
		price = 402,
		quality = QualityType.ePurple
	},
	{
		equipId = 24,
		name = "龙王符碎片",
		exchangeCount = 12,
		price = 405,
		quality = QualityType.ePurple
	},
	{
		equipId = 25,
		name = "破军符碎片",
		exchangeCount = 12,
		price = 404,
		quality = QualityType.ePurple
	},
	{
		equipId = 26,
		name = "天王符碎片",
		exchangeCount = 12,
		price = 412,
		quality = QualityType.ePurple
	},
	{
		equipId = 27,
		name = "盘古神符碎片",
		exchangeCount = 16,
		price = 608,
		quality = QualityType.eOrange
	},
	{
		equipId = 28,
		name = "九天神符碎片",
		exchangeCount = 16,
		price = 603,
		quality = QualityType.eOrange
	},
	{
		equipId = 29,
		name = "乾坤神符碎片",
		exchangeCount = 16,
		price = 610,
		quality = QualityType.eOrange
	},
	{
		equipId = 30,
		name = "三清神符碎片",
		exchangeCount = 16,
		price = 602,
		quality = QualityType.eOrange
	},
	{
		equipId = 31,
		name = "狂龙战符碎片",
		exchangeCount = 16,
		price = 608,
		quality = QualityType.eOrange
	},
	{
		equipId = 32,
		name = "轩辕战符碎片",
		exchangeCount = 16,
		price = 607,
		quality = QualityType.eOrange
	},
	{
		equipId = 33,
		name = "万灵神符碎片",
		exchangeCount = 16,
		price = 607,
		quality = QualityType.eOrange
	},
	{
		equipId = 34,
		name = "万妖鬼符碎片",
		exchangeCount = 16,
		price = 613,
		quality = QualityType.eOrange
	},
	{
		equipId = 35,
		name = "玉皇金符碎片",
		exchangeCount = 16,
		price = 615,
		quality = QualityType.eOrange
	},
	{
		equipId = 36,
		name = "弥罗真符碎片",
		exchangeCount = 16,
		price = 613,
		quality = QualityType.eOrange
	},
	{
		equipId = 37,
		name = "夜行衣碎片",
		exchangeCount = 3,
		price = 905,
		quality = QualityType.eGreen
	},
	{
		equipId = 38,
		name = "天蚕衣碎片",
		exchangeCount = 5,
		price = 570,
		quality = QualityType.eBlue
	},
	{
		equipId = 39,
		name = "云锦袍碎片",
		exchangeCount = 5,
		price = 598,
		quality = QualityType.eBlue
	},
	{
		equipId = 40,
		name = "逸尘衫碎片",
		exchangeCount = 3,
		price = 906,
		quality = QualityType.eGreen
	},
	{
		equipId = 41,
		name = "锁子甲碎片",
		exchangeCount = 5,
		price = 558,
		quality = QualityType.eBlue
	},
	{
		equipId = 42,
		name = "青铜甲碎片",
		exchangeCount = 3,
		price = 964,
		quality = QualityType.eGreen
	},
	{
		equipId = 43,
		name = "逍遥衫碎片",
		exchangeCount = 5,
		price = 1105,
		quality = QualityType.eBlue
	},
	{
		equipId = 44,
		name = "珍珠汗衫碎片",
		exchangeCount = 12,
		price = 453,
		quality = QualityType.ePurple
	},
	{
		equipId = 45,
		name = "玉露云衫碎片",
		exchangeCount = 5,
		price = 1091,
		quality = QualityType.eBlue
	},
	{
		equipId = 46,
		name = "天罗轻衫碎片",
		exchangeCount = 5,
		price = 1102,
		quality = QualityType.eBlue
	},
	{
		equipId = 47,
		name = "天罡甲碎片",
		exchangeCount = 12,
		price = 454,
		quality = QualityType.ePurple
	},
	{
		equipId = 48,
		name = "赤炎袍碎片",
		exchangeCount = 12,
		price = 463,
		quality = QualityType.ePurple
	},
	{
		equipId = 49,
		name = "白银铠碎片",
		exchangeCount = 12,
		price = 456,
		quality = QualityType.ePurple
	},
	{
		equipId = 50,
		name = "青云甲碎片",
		exchangeCount = 12,
		price = 451,
		quality = QualityType.ePurple
	},
	{
		equipId = 51,
		name = "飞云衫碎片",
		exchangeCount = 5,
		price = 1097,
		quality = QualityType.eBlue
	},
	{
		equipId = 52,
		name = "赭黄袍碎片",
		exchangeCount = 12,
		price = 921,
		quality = QualityType.ePurple
	},
	{
		equipId = 53,
		name = "七彩霓裳碎片",
		exchangeCount = 12,
		price = 922,
		quality = QualityType.ePurple
	},
	{
		equipId = 54,
		name = "五彩霞衣碎片",
		exchangeCount = 12,
		price = 910,
		quality = QualityType.ePurple
	},
	{
		equipId = 55,
		name = "龙鳞战甲碎片",
		exchangeCount = 12,
		price = 915,
		quality = QualityType.ePurple
	},
	{
		equipId = 56,
		name = "七星宝衣碎片",
		exchangeCount = 12,
		price = 909,
		quality = QualityType.ePurple
	},
	{
		equipId = 57,
		name = "九阳战甲碎片",
		exchangeCount = 12,
		price = 922,
		quality = QualityType.ePurple
	},
	{
		equipId = 58,
		name = "天神战袍碎片",
		exchangeCount = 12,
		price = 918,
		quality = QualityType.ePurple
	},
	{
		equipId = 59,
		name = "金刚战甲碎片",
		exchangeCount = 12,
		price = 917,
		quality = QualityType.ePurple
	},
	{
		equipId = 60,
		name = "九寒冰甲碎片",
		exchangeCount = 12,
		price = 922,
		quality = QualityType.ePurple
	},
	{
		equipId = 61,
		name = "真龙战甲碎片",
		exchangeCount = 12,
		price = 906,
		quality = QualityType.ePurple
	},
	{
		equipId = 62,
		name = "玄黄金甲碎片",
		exchangeCount = 16,
		price = 1380,
		quality = QualityType.eOrange
	},
	{
		equipId = 63,
		name = "九霄云袍碎片",
		exchangeCount = 16,
		price = 1352,
		quality = QualityType.eOrange
	},
	{
		equipId = 64,
		name = "八卦法衣碎片",
		exchangeCount = 16,
		price = 1388,
		quality = QualityType.eOrange
	},
	{
		equipId = 65,
		name = "无极道袍碎片",
		exchangeCount = 16,
		price = 1385,
		quality = QualityType.eOrange
	},
	{
		equipId = 66,
		name = "冥界战铠碎片",
		exchangeCount = 16,
		price = 1369,
		quality = QualityType.eOrange
	},
	{
		equipId = 67,
		name = "天尊神铠碎片",
		exchangeCount = 16,
		price = 1376,
		quality = QualityType.eOrange
	},
	{
		equipId = 68,
		name = "九天帝袍碎片",
		exchangeCount = 16,
		price = 1365,
		quality = QualityType.eOrange
	},
	{
		equipId = 69,
		name = "锦帽碎片",
		exchangeCount = 3,
		price = 932,
		quality = QualityType.eGreen
	},
	{
		equipId = 70,
		name = "狐皮帽碎片",
		exchangeCount = 5,
		price = 567,
		quality = QualityType.eBlue
	},
	{
		equipId = 71,
		name = "明珠帽碎片",
		exchangeCount = 3,
		price = 976,
		quality = QualityType.eGreen
	},
	{
		equipId = 72,
		name = "青铜盔碎片",
		exchangeCount = 3,
		price = 916,
		quality = QualityType.eGreen
	},
	{
		equipId = 73,
		name = "乌木簪碎片",
		exchangeCount = 5,
		price = 563,
		quality = QualityType.eBlue
	},
	{
		equipId = 74,
		name = "碧夜簪碎片",
		exchangeCount = 5,
		price = 588,
		quality = QualityType.eBlue
	},
	{
		equipId = 75,
		name = "逍遥盔碎片",
		exchangeCount = 5,
		price = 1099,
		quality = QualityType.eBlue
	},
	{
		equipId = 76,
		name = "天魁帽碎片",
		exchangeCount = 5,
		price = 1096,
		quality = QualityType.eBlue
	},
	{
		equipId = 77,
		name = "幻星帽碎片",
		exchangeCount = 12,
		price = 462,
		quality = QualityType.ePurple
	},
	{
		equipId = 78,
		name = "太极帽碎片",
		exchangeCount = 12,
		price = 453,
		quality = QualityType.ePurple
	},
	{
		equipId = 79,
		name = "天师帽碎片",
		exchangeCount = 12,
		price = 459,
		quality = QualityType.ePurple
	},
	{
		equipId = 80,
		name = "杀神盔碎片",
		exchangeCount = 12,
		price = 460,
		quality = QualityType.ePurple
	},
	{
		equipId = 81,
		name = "白银冠碎片",
		exchangeCount = 5,
		price = 1096,
		quality = QualityType.eBlue
	},
	{
		equipId = 82,
		name = "通灵冠碎片",
		exchangeCount = 12,
		price = 461,
		quality = QualityType.ePurple
	},
	{
		equipId = 83,
		name = "飞云冠碎片",
		exchangeCount = 12,
		price = 452,
		quality = QualityType.ePurple
	},
	{
		equipId = 84,
		name = "紫金冠碎片",
		exchangeCount = 12,
		price = 921,
		quality = QualityType.ePurple
	},
	{
		equipId = 85,
		name = "玉龙冠碎片",
		exchangeCount = 12,
		price = 914,
		quality = QualityType.ePurple
	},
	{
		equipId = 86,
		name = "羲和冠碎片",
		exchangeCount = 12,
		price = 907,
		quality = QualityType.ePurple
	},
	{
		equipId = 87,
		name = "大圣冠碎片",
		exchangeCount = 12,
		price = 914,
		quality = QualityType.ePurple
	},
	{
		equipId = 88,
		name = "青龙冠碎片",
		exchangeCount = 12,
		price = 911,
		quality = QualityType.ePurple
	},
	{
		equipId = 89,
		name = "白虎冠碎片",
		exchangeCount = 12,
		price = 926,
		quality = QualityType.ePurple
	},
	{
		equipId = 90,
		name = "朱雀冠碎片",
		exchangeCount = 12,
		price = 915,
		quality = QualityType.ePurple
	},
	{
		equipId = 91,
		name = "玄武冠碎片",
		exchangeCount = 12,
		price = 901,
		quality = QualityType.ePurple
	},
	{
		equipId = 92,
		name = "麒麟冠碎片",
		exchangeCount = 12,
		price = 909,
		quality = QualityType.ePurple
	},
	{
		equipId = 93,
		name = "凤翅冠碎片",
		exchangeCount = 12,
		price = 924,
		quality = QualityType.ePurple
	},
	{
		equipId = 94,
		name = "玄冥鬼冕碎片",
		exchangeCount = 16,
		price = 1356,
		quality = QualityType.eOrange
	},
	{
		equipId = 95,
		name = "九天帝冕碎片",
		exchangeCount = 16,
		price = 1379,
		quality = QualityType.eOrange
	},
	{
		equipId = 96,
		name = "无极道冕碎片",
		exchangeCount = 16,
		price = 1379,
		quality = QualityType.eOrange
	},
	{
		equipId = 97,
		name = "逍遥仙冕碎片",
		exchangeCount = 16,
		price = 1373,
		quality = QualityType.eOrange
	},
	{
		equipId = 98,
		name = "修罗魔冕碎片",
		exchangeCount = 16,
		price = 1374,
		quality = QualityType.eOrange
	},
	{
		equipId = 99,
		name = "云霄天冕碎片",
		exchangeCount = 16,
		price = 1373,
		quality = QualityType.eOrange
	},
	{
		equipId = 100,
		name = "万妖神冕碎片",
		exchangeCount = 16,
		price = 1368,
		quality = QualityType.eOrange
	},
	{
		equipId = 101,
		name = "青铜戒碎片",
		exchangeCount = 3,
		price = 1278,
		quality = QualityType.eGreen
	},
	{
		equipId = 102,
		name = "乌木戒碎片",
		exchangeCount = 5,
		price = 763,
		quality = QualityType.eBlue
	},
	{
		equipId = 103,
		name = "檀香戒碎片",
		exchangeCount = 5,
		price = 760,
		quality = QualityType.eBlue
	},
	{
		equipId = 104,
		name = "铁戒指碎片",
		exchangeCount = 3,
		price = 1268,
		quality = QualityType.eGreen
	},
	{
		equipId = 105,
		name = "质石戒碎片",
		exchangeCount = 3,
		price = 1263,
		quality = QualityType.eGreen
	},
	{
		equipId = 106,
		name = "阴阳戒碎片",
		exchangeCount = 5,
		price = 1534,
		quality = QualityType.eBlue
	},
	{
		equipId = 107,
		name = "金光戒碎片",
		exchangeCount = 12,
		price = 627,
		quality = QualityType.ePurple
	},
	{
		equipId = 108,
		name = "烂银戒碎片",
		exchangeCount = 5,
		price = 1529,
		quality = QualityType.eBlue
	},
	{
		equipId = 109,
		name = "青云戒碎片",
		exchangeCount = 12,
		price = 642,
		quality = QualityType.ePurple
	},
	{
		equipId = 110,
		name = "如意戒碎片",
		exchangeCount = 12,
		price = 637,
		quality = QualityType.ePurple
	},
	{
		equipId = 111,
		name = "玄女戒碎片",
		exchangeCount = 12,
		price = 637,
		quality = QualityType.ePurple
	},
	{
		equipId = 112,
		name = "七宝戒碎片",
		exchangeCount = 12,
		price = 634,
		quality = QualityType.ePurple
	},
	{
		equipId = 113,
		name = "霹魂戒碎片",
		exchangeCount = 12,
		price = 635,
		quality = QualityType.ePurple
	},
	{
		equipId = 114,
		name = "金刚戒指碎片",
		exchangeCount = 12,
		price = 1254,
		quality = QualityType.ePurple
	},
	{
		equipId = 115,
		name = "回魂戒指碎片",
		exchangeCount = 12,
		price = 1265,
		quality = QualityType.ePurple
	},
	{
		equipId = 116,
		name = "定魂戒指碎片",
		exchangeCount = 12,
		price = 1271,
		quality = QualityType.ePurple
	},
	{
		equipId = 117,
		name = "造血戒指碎片",
		exchangeCount = 12,
		price = 1252,
		quality = QualityType.ePurple
	},
	{
		equipId = 118,
		name = "九阳戒指碎片",
		exchangeCount = 12,
		price = 1280,
		quality = QualityType.ePurple
	},
	{
		equipId = 119,
		name = "天盾戒指碎片",
		exchangeCount = 12,
		price = 1264,
		quality = QualityType.ePurple
	},
	{
		equipId = 120,
		name = "天雷戒指碎片",
		exchangeCount = 12,
		price = 1279,
		quality = QualityType.ePurple
	},
	{
		equipId = 121,
		name = "龙魂戒指碎片",
		exchangeCount = 12,
		price = 1286,
		quality = QualityType.ePurple
	},
	{
		equipId = 122,
		name = "诛仙戒指碎片",
		exchangeCount = 12,
		price = 1276,
		quality = QualityType.ePurple
	},
	{
		equipId = 123,
		name = "混元神戒碎片",
		exchangeCount = 16,
		price = 1923,
		quality = QualityType.eOrange
	},
	{
		equipId = 124,
		name = "血牛神戒碎片",
		exchangeCount = 16,
		price = 1922,
		quality = QualityType.eOrange
	},
	{
		equipId = 125,
		name = "风火神戒碎片",
		exchangeCount = 16,
		price = 1886,
		quality = QualityType.eOrange
	},
	{
		equipId = 126,
		name = "天帝神戒碎片",
		exchangeCount = 16,
		price = 1918,
		quality = QualityType.eOrange
	},
	{
		equipId = 127,
		name = "归元神戒碎片",
		exchangeCount = 16,
		price = 1915,
		quality = QualityType.eOrange
	},
	{
		equipId = 128,
		name = "太极神戒碎片",
		exchangeCount = 16,
		price = 1906,
		quality = QualityType.eOrange
	},
	{
		equipId = 129,
		name = "开天神戒碎片",
		exchangeCount = 16,
		price = 1911,
		quality = QualityType.eOrange
	},
	{
		equipId = 130,
		name = "青铜链碎片",
		exchangeCount = 5,
		price = 804,
		quality = QualityType.eBlue
	},
	{
		equipId = 131,
		name = "青玉链碎片",
		exchangeCount = 5,
		price = 783,
		quality = QualityType.eBlue
	},
	{
		equipId = 132,
		name = "火石链碎片",
		exchangeCount = 3,
		price = 1314,
		quality = QualityType.eGreen
	},
	{
		equipId = 133,
		name = "木珠链碎片",
		exchangeCount = 3,
		price = 1335,
		quality = QualityType.eGreen
	},
	{
		equipId = 134,
		name = "香草链碎片",
		exchangeCount = 3,
		price = 1340,
		quality = QualityType.eGreen
	},
	{
		equipId = 135,
		name = "灵玉链碎片",
		exchangeCount = 12,
		price = 665,
		quality = QualityType.ePurple
	},
	{
		equipId = 136,
		name = "御神链碎片",
		exchangeCount = 12,
		price = 654,
		quality = QualityType.ePurple
	},
	{
		equipId = 137,
		name = "电光链碎片",
		exchangeCount = 12,
		price = 657,
		quality = QualityType.ePurple
	},
	{
		equipId = 138,
		name = "幽冥链碎片",
		exchangeCount = 12,
		price = 664,
		quality = QualityType.ePurple
	},
	{
		equipId = 139,
		name = "金丝链碎片",
		exchangeCount = 12,
		price = 669,
		quality = QualityType.ePurple
	},
	{
		equipId = 140,
		name = "飞云链碎片",
		exchangeCount = 12,
		price = 665,
		quality = QualityType.ePurple
	},
	{
		equipId = 141,
		name = "仙女链碎片",
		exchangeCount = 5,
		price = 1585,
		quality = QualityType.eBlue
	},
	{
		equipId = 142,
		name = "绝尘链碎片",
		exchangeCount = 5,
		price = 1588,
		quality = QualityType.eBlue
	},
	{
		equipId = 143,
		name = "摩诃项链碎片",
		exchangeCount = 12,
		price = 1315,
		quality = QualityType.ePurple
	},
	{
		equipId = 144,
		name = "烛龙项链碎片",
		exchangeCount = 12,
		price = 1331,
		quality = QualityType.ePurple
	},
	{
		equipId = 145,
		name = "灵心项链碎片",
		exchangeCount = 12,
		price = 1317,
		quality = QualityType.ePurple
	},
	{
		equipId = 146,
		name = "轮回项链碎片",
		exchangeCount = 12,
		price = 1307,
		quality = QualityType.ePurple
	},
	{
		equipId = 147,
		name = "游龙项链碎片",
		exchangeCount = 12,
		price = 1326,
		quality = QualityType.ePurple
	},
	{
		equipId = 148,
		name = "飞翔项链碎片",
		exchangeCount = 12,
		price = 1325,
		quality = QualityType.ePurple
	},
	{
		equipId = 149,
		name = "极速项链碎片",
		exchangeCount = 12,
		price = 1329,
		quality = QualityType.ePurple
	},
	{
		equipId = 150,
		name = "风雷项链碎片",
		exchangeCount = 12,
		price = 1300,
		quality = QualityType.ePurple
	},
	{
		equipId = 151,
		name = "霹雳项链碎片",
		exchangeCount = 12,
		price = 1321,
		quality = QualityType.ePurple
	},
	{
		equipId = 152,
		name = "日月神链碎片",
		exchangeCount = 16,
		price = 1902,
		quality = QualityType.eOrange
	},
	{
		equipId = 153,
		name = "翻天神链碎片",
		exchangeCount = 16,
		price = 1895,
		quality = QualityType.eOrange
	},
	{
		equipId = 154,
		name = "翱翔神链碎片",
		exchangeCount = 16,
		price = 1905,
		quality = QualityType.eOrange
	},
	{
		equipId = 155,
		name = "瞬息神链碎片",
		exchangeCount = 16,
		price = 1910,
		quality = QualityType.eOrange
	},
	{
		equipId = 156,
		name = "鲲鹏神链碎片",
		exchangeCount = 16,
		price = 1902,
		quality = QualityType.eOrange
	},
	{
		equipId = 157,
		name = "九天神链碎片",
		exchangeCount = 16,
		price = 1892,
		quality = QualityType.eOrange
	},
	{
		equipId = 158,
		name = "天音神链碎片",
		exchangeCount = 16,
		price = 1899,
		quality = QualityType.eOrange
	},
	{
		equipId = 159,
		name = "天机策碎片",
		exchangeCount = 16,
		price = 1125,
		quality = QualityType.eOrange
	},
	{
		equipId = 160,
		name = "伏羲剑碎片",
		exchangeCount = 16,
		price = 1145,
		quality = QualityType.eOrange
	},
	{
		equipId = 161,
		name = "玄天剑碎片",
		exchangeCount = 16,
		price = 1157,
		quality = QualityType.eOrange
	},
	{
		equipId = 162,
		name = "混元金斗碎片",
		exchangeCount = 16,
		price = 1141,
		quality = QualityType.eOrange
	},
	{
		equipId = 163,
		name = "女娲石碎片",
		exchangeCount = 16,
		price = 1140,
		quality = QualityType.eOrange
	},
	{
		equipId = 164,
		name = "紫金葫芦碎片",
		exchangeCount = 16,
		price = 1133,
		quality = QualityType.eOrange
	},
	{
		equipId = 165,
		name = "混沌青莲碎片",
		exchangeCount = 16,
		price = 1142,
		quality = QualityType.eOrange
	},
	{
		equipId = 166,
		name = "盘古幡碎片",
		exchangeCount = 16,
		price = 1151,
		quality = QualityType.eOrange
	},
	{
		equipId = 167,
		name = "天魔战锤碎片",
		exchangeCount = 16,
		price = 1151,
		quality = QualityType.eOrange
	},
	{
		equipId = 168,
		name = "乾坤帝斧碎片",
		exchangeCount = 16,
		price = 1146,
		quality = QualityType.eOrange
	},
	{
		equipId = 169,
		name = "至尊剑碎片",
		exchangeCount = 12,
		price = 762,
		quality = QualityType.ePurple
	},
	{
		equipId = 170,
		name = "雌雄金鞭碎片",
		exchangeCount = 12,
		price = 758,
		quality = QualityType.ePurple
	},
	{
		equipId = 171,
		name = "打神鞭碎片",
		exchangeCount = 12,
		price = 765,
		quality = QualityType.ePurple
	},
	{
		equipId = 172,
		name = "浑铁棍碎片",
		exchangeCount = 12,
		price = 753,
		quality = QualityType.ePurple
	},
	{
		equipId = 173,
		name = "玄元金尺碎片",
		exchangeCount = 12,
		price = 762,
		quality = QualityType.ePurple
	},
	{
		equipId = 174,
		name = "方天神戟碎片",
		exchangeCount = 12,
		price = 759,
		quality = QualityType.ePurple
	},
	{
		equipId = 175,
		name = "三尖枪碎片",
		exchangeCount = 12,
		price = 770,
		quality = QualityType.ePurple
	},
	{
		equipId = 176,
		name = "金箍棒碎片",
		exchangeCount = 12,
		price = 760,
		quality = QualityType.ePurple
	},
	{
		equipId = 177,
		name = "神龙戟碎片",
		exchangeCount = 12,
		price = 767,
		quality = QualityType.ePurple
	},
	{
		equipId = 178,
		name = "三宝如意碎片",
		exchangeCount = 12,
		price = 753,
		quality = QualityType.ePurple
	},
	{
		equipId = 179,
		name = "玲珑宝塔碎片",
		exchangeCount = 12,
		price = 750,
		quality = QualityType.ePurple
	},
	{
		equipId = 180,
		name = "金枝宝荷碎片",
		exchangeCount = 12,
		price = 762,
		quality = QualityType.ePurple
	},
	{
		equipId = 181,
		name = "招妖幡碎片",
		exchangeCount = 12,
		price = 385,
		quality = QualityType.ePurple
	},
	{
		equipId = 182,
		name = "斩妖剑碎片",
		exchangeCount = 12,
		price = 376,
		quality = QualityType.ePurple
	},
	{
		equipId = 183,
		name = "生死令碎片",
		exchangeCount = 12,
		price = 384,
		quality = QualityType.ePurple
	},
	{
		equipId = 184,
		name = "幌金绳碎片",
		exchangeCount = 12,
		price = 375,
		quality = QualityType.ePurple
	},
	{
		equipId = 185,
		name = "灵枢灯碎片",
		exchangeCount = 12,
		price = 378,
		quality = QualityType.ePurple
	},
	{
		equipId = 186,
		name = "月光宝瓶碎片",
		exchangeCount = 12,
		price = 377,
		quality = QualityType.ePurple
	},
	{
		equipId = 187,
		name = "风火蒲团碎片",
		exchangeCount = 12,
		price = 376,
		quality = QualityType.ePurple
	},
	{
		equipId = 188,
		name = "宣花板斧碎片",
		exchangeCount = 12,
		price = 386,
		quality = QualityType.ePurple
	},
	{
		equipId = 189,
		name = "月牙铲碎片",
		exchangeCount = 12,
		price = 379,
		quality = QualityType.ePurple
	},
	{
		equipId = 190,
		name = "黄金棍碎片",
		exchangeCount = 12,
		price = 380,
		quality = QualityType.ePurple
	},
	{
		equipId = 191,
		name = "金刚战杵碎片",
		exchangeCount = 12,
		price = 386,
		quality = QualityType.ePurple
	},
	{
		equipId = 192,
		name = "飞烟剑碎片",
		exchangeCount = 5,
		price = 515,
		quality = QualityType.eBlue
	},
	{
		equipId = 193,
		name = "骷髅鬼杖碎片",
		exchangeCount = 5,
		price = 467,
		quality = QualityType.eBlue
	},
	{
		equipId = 194,
		name = "桃木剑碎片",
		exchangeCount = 3,
		price = 800,
		quality = QualityType.eGreen
	},
	{
		equipId = 195,
		name = "翻江棍碎片",
		exchangeCount = 5,
		price = 516,
		quality = QualityType.eBlue
	},
	{
		equipId = 196,
		name = "龙魂锤碎片",
		exchangeCount = 5,
		price = 470,
		quality = QualityType.eBlue
	},
	{
		equipId = 197,
		name = "伏海叉碎片",
		exchangeCount = 3,
		price = 796,
		quality = QualityType.eGreen
	},
	{
		equipId = 198,
		name = "周天镜碎片",
		exchangeCount = 5,
		price = 502,
		quality = QualityType.eBlue
	},
	{
		equipId = 199,
		name = "照妖镜碎片",
		exchangeCount = 5,
		price = 466,
		quality = QualityType.eBlue
	},
	{
		equipId = 200,
		name = "雷火珠碎片",
		exchangeCount = 3,
		price = 820,
		quality = QualityType.eGreen
	},
	[10000] = {
		equipId = 0,
		name = "丙级灵符碎片",
		exchangeCount = 5,
		headerImage = "small_partfu01.png",
		price = 320,
		quality = QualityType.eGreen,
		equipQuality = QualityType.eGreen,
		equipType = EquipType.eAmulet
	},
	[10001] = {
		equipId = 0,
		name = "丙级衣服碎片",
		exchangeCount = 5,
		headerImage = "small_partyi01.png",
		price = 720,
		quality = QualityType.eGreen,
		equipQuality = QualityType.eGreen,
		equipType = EquipType.eClothes
	},
	[10002] = {
		equipId = 0,
		name = "丙级头盔碎片",
		exchangeCount = 5,
		headerImage = "small_parttou01.png",
		price = 720,
		quality = QualityType.eGreen,
		equipQuality = QualityType.eGreen,
		equipType = EquipType.eHelmet
	},
	[10003] = {
		equipId = 0,
		name = "丙级戒指碎片",
		exchangeCount = 5,
		headerImage = "small_partjie01.png",
		price = 1000,
		quality = QualityType.eGreen,
		equipQuality = QualityType.eGreen,
		equipType = EquipType.eRing
	},
	[10004] = {
		equipId = 0,
		name = "丙级项链碎片",
		exchangeCount = 5,
		headerImage = "small_partxiang01.png",
		price = 1040,
		quality = QualityType.eGreen,
		equipQuality = QualityType.eGreen,
		equipType = EquipType.eNecklace
	},
	[10005] = {
		equipId = 0,
		name = "丙级武器碎片",
		exchangeCount = 5,
		headerImage = "small_partwu01.png",
		price = 600,
		quality = QualityType.eGreen,
		equipQuality = QualityType.eGreen,
		equipType = EquipType.eWeapon
	},
	[10006] = {
		equipId = 0,
		name = "乙级灵符碎片",
		exchangeCount = 8,
		headerImage = "small_partfu02.png",
		price = 640,
		quality = QualityType.eBlue,
		equipQuality = QualityType.eBlue,
		equipType = EquipType.eAmulet
	},
	[10007] = {
		equipId = 0,
		name = "乙级衣服碎片",
		exchangeCount = 8,
		headerImage = "small_partyi02.png",
		price = 1440,
		quality = QualityType.eBlue,
		equipQuality = QualityType.eBlue,
		equipType = EquipType.eClothes
	},
	[10008] = {
		equipId = 0,
		name = "乙级头盔碎片",
		exchangeCount = 8,
		headerImage = "small_parttou02.png",
		price = 1440,
		quality = QualityType.eBlue,
		equipQuality = QualityType.eBlue,
		equipType = EquipType.eHelmet
	},
	[10009] = {
		equipId = 0,
		name = "乙级戒指碎片",
		exchangeCount = 8,
		headerImage = "small_partjie02.png",
		price = 2000,
		quality = QualityType.eBlue,
		equipQuality = QualityType.eBlue,
		equipType = EquipType.eRing
	},
	[10010] = {
		equipId = 0,
		name = "乙级项链碎片",
		exchangeCount = 8,
		headerImage = "small_partxiang02.png",
		price = 2080,
		quality = QualityType.eBlue,
		equipQuality = QualityType.eBlue,
		equipType = EquipType.eNecklace
	},
	[10011] = {
		equipId = 0,
		name = "乙级武器碎片",
		exchangeCount = 8,
		headerImage = "small_partwu02.png",
		price = 1200,
		quality = QualityType.eBlue,
		equipQuality = QualityType.eBlue,
		equipType = EquipType.eWeapon
	},
	[10012] = {
		equipId = 0,
		name = "甲级灵符碎片",
		exchangeCount = 15,
		headerImage = "small_partfu03.png",
		price = 1280,
		quality = QualityType.ePurple,
		equipQuality = QualityType.ePurple,
		equipType = EquipType.eAmulet
	},
	[10013] = {
		equipId = 0,
		name = "甲级衣服碎片",
		exchangeCount = 15,
		headerImage = "small_partyi03.png",
		price = 2880,
		quality = QualityType.ePurple,
		equipQuality = QualityType.ePurple,
		equipType = EquipType.eClothes
	},
	[10014] = {
		equipId = 0,
		name = "甲级头盔碎片",
		exchangeCount = 15,
		headerImage = "small_parttou03.png",
		price = 2880,
		quality = QualityType.ePurple,
		equipQuality = QualityType.ePurple,
		equipType = EquipType.eHelmet
	},
	[10015] = {
		equipId = 0,
		name = "甲级戒指碎片",
		exchangeCount = 15,
		headerImage = "small_partjie03.png",
		price = 4000,
		quality = QualityType.ePurple,
		equipQuality = QualityType.ePurple,
		equipType = EquipType.eRing
	},
	[10016] = {
		equipId = 0,
		name = "甲级项链碎片",
		exchangeCount = 15,
		headerImage = "small_partxiang03.png",
		price = 4160,
		quality = QualityType.ePurple,
		equipQuality = QualityType.ePurple,
		equipType = EquipType.eNecklace
	},
	[10017] = {
		equipId = 0,
		name = "甲级武器碎片",
		exchangeCount = 15,
		headerImage = "small_partwu03.png",
		price = 2400,
		quality = QualityType.ePurple,
		equipQuality = QualityType.ePurple,
		equipType = EquipType.eWeapon
	},
	[10018] = {
		equipId = 0,
		name = "超级灵符碎片",
		exchangeCount = 20,
		headerImage = "small_partfu04.png",
		price = 2560,
		quality = QualityType.eOrange,
		equipQuality = QualityType.eOrange,
		equipType = EquipType.eAmulet
	},
	[10019] = {
		equipId = 0,
		name = "超级衣服碎片",
		exchangeCount = 20,
		headerImage = "small_partyi04.png",
		price = 5760,
		quality = QualityType.eOrange,
		equipQuality = QualityType.eOrange,
		equipType = EquipType.eClothes
	},
	[10020] = {
		equipId = 0,
		name = "超级头盔碎片",
		exchangeCount = 20,
		headerImage = "small_parttou04.png",
		price = 5760,
		quality = QualityType.eOrange,
		equipQuality = QualityType.eOrange,
		equipType = EquipType.eHelmet
	},
	[10021] = {
		equipId = 0,
		name = "超级戒指碎片",
		exchangeCount = 20,
		headerImage = "small_partjie04.png",
		price = 8000,
		quality = QualityType.eOrange,
		equipQuality = QualityType.eOrange,
		equipType = EquipType.eRing
	},
	[10022] = {
		equipId = 0,
		name = "超级项链碎片",
		exchangeCount = 20,
		headerImage = "small_partxiang04.png",
		price = 8320,
		quality = QualityType.eOrange,
		equipQuality = QualityType.eOrange,
		equipType = EquipType.eNecklace
	},
	[10023] = {
		equipId = 0,
		name = "超级武器碎片",
		exchangeCount = 20,
		headerImage = "small_partwu04.png",
		price = 4800,
		quality = QualityType.eOrange,
		equipQuality = QualityType.eOrange,
		equipType = EquipType.eWeapon
	},
	{
		equipId = 201,
		name = "真君戟碎片",
		exchangeCount = 16,
		price = 1144,
		quality = QualityType.eOrange
	},
	{
		equipId = 202,
		name = "凌波仙符碎片",
		exchangeCount = 16,
		price = 594,
		quality = QualityType.eOrange
	},
	{
		equipId = 203,
		name = "真元神符碎片",
		exchangeCount = 16,
		price = 582,
		quality = QualityType.eOrange
	},
	{
		equipId = 204,
		name = "元阳仙符碎片",
		exchangeCount = 16,
		price = 598,
		quality = QualityType.eOrange
	},
	{
		equipId = 205,
		name = "纯阳神符碎片",
		exchangeCount = 16,
		price = 599,
		quality = QualityType.eOrange
	},
	{
		equipId = 206,
		name = "瑶池仙符碎片",
		exchangeCount = 16,
		price = 598,
		quality = QualityType.eOrange
	},
	{
		equipId = 207,
		name = "魑魅鬼符碎片",
		exchangeCount = 16,
		price = 613,
		quality = QualityType.eOrange
	},
	{
		equipId = 208,
		name = "鸾羽凤冠碎片",
		exchangeCount = 16,
		price = 1341,
		quality = QualityType.eOrange
	},
	{
		equipId = 209,
		name = "黑炎魔冠碎片",
		exchangeCount = 16,
		price = 1359,
		quality = QualityType.eOrange
	},
	{
		equipId = 210,
		name = "珐琅鬼冕碎片",
		exchangeCount = 16,
		price = 1379,
		quality = QualityType.eOrange
	},
	{
		equipId = 211,
		name = "琉璃玉冠碎片",
		exchangeCount = 16,
		price = 1329,
		quality = QualityType.eOrange
	},
	{
		equipId = 212,
		name = "白玉龙冠碎片",
		exchangeCount = 16,
		price = 1318,
		quality = QualityType.eOrange
	},
	{
		equipId = 213,
		name = "流苏金簪碎片",
		exchangeCount = 16,
		price = 1345,
		quality = QualityType.eOrange
	},
	{
		equipId = 214,
		name = "神谕披风碎片",
		exchangeCount = 16,
		price = 1331,
		quality = QualityType.eOrange
	},
	{
		equipId = 215,
		name = "碧霞云衣碎片",
		exchangeCount = 16,
		price = 1373,
		quality = QualityType.eOrange
	},
	{
		equipId = 216,
		name = "金丝鳞甲碎片",
		exchangeCount = 16,
		price = 1354,
		quality = QualityType.eOrange
	},
	{
		equipId = 217,
		name = "金蚕披风碎片",
		exchangeCount = 16,
		price = 1348,
		quality = QualityType.eOrange
	},
	{
		equipId = 218,
		name = "龙骨魔铠碎片",
		exchangeCount = 16,
		price = 1366,
		quality = QualityType.eOrange
	},
	{
		equipId = 219,
		name = "凤翅彩衣碎片",
		exchangeCount = 16,
		price = 1312,
		quality = QualityType.eOrange
	},
	{
		equipId = 220,
		name = "龙血魔戒碎片",
		exchangeCount = 16,
		price = 1906,
		quality = QualityType.eOrange
	},
	{
		equipId = 221,
		name = "翡翠神戒碎片",
		exchangeCount = 16,
		price = 1899,
		quality = QualityType.eOrange
	},
	{
		equipId = 222,
		name = "冥灵魔戒碎片",
		exchangeCount = 16,
		price = 1822,
		quality = QualityType.eOrange
	},
	{
		equipId = 223,
		name = "异界密戒碎片",
		exchangeCount = 16,
		price = 1867,
		quality = QualityType.eOrange
	},
	{
		equipId = 224,
		name = "无极神戒碎片",
		exchangeCount = 16,
		price = 1851,
		quality = QualityType.eOrange
	},
	{
		equipId = 225,
		name = "魍魉鬼戒碎片",
		exchangeCount = 16,
		price = 1826,
		quality = QualityType.eOrange
	},
	{
		equipId = 226,
		name = "玲珑宝链碎片",
		exchangeCount = 16,
		price = 1975,
		quality = QualityType.eOrange
	},
	{
		equipId = 227,
		name = "鬼牙项链碎片",
		exchangeCount = 16,
		price = 1982,
		quality = QualityType.eOrange
	},
	{
		equipId = 228,
		name = "碧玺项链碎片",
		exchangeCount = 16,
		price = 1988,
		quality = QualityType.eOrange
	},
	{
		equipId = 229,
		name = "混元神链碎片",
		exchangeCount = 16,
		price = 1899,
		quality = QualityType.eOrange
	},
	{
		equipId = 230,
		name = "刑天魔链碎片",
		exchangeCount = 16,
		price = 1935,
		quality = QualityType.eOrange
	},
	{
		equipId = 231,
		name = "翡翠璎珞碎片",
		exchangeCount = 16,
		price = 1998,
		quality = QualityType.eOrange
	},
	{
		equipId = 232,
		name = "琉璃玉钵碎片",
		exchangeCount = 16,
		price = 1114,
		quality = QualityType.eOrange
	},
	{
		equipId = 233,
		name = "干将莫邪碎片",
		exchangeCount = 16,
		price = 1117,
		quality = QualityType.eOrange
	},
	{
		equipId = 234,
		name = "定海神针碎片",
		exchangeCount = 16,
		price = 1098,
		quality = QualityType.eOrange
	},
	{
		equipId = 235,
		name = "九齿钉耙碎片",
		exchangeCount = 16,
		price = 1140,
		quality = QualityType.eOrange
	},
	{
		equipId = 236,
		name = "九转神叉碎片",
		exchangeCount = 16,
		price = 1158,
		quality = QualityType.eOrange
	},
	{
		equipId = 237,
		name = "佛光舍利碎片",
		exchangeCount = 16,
		price = 1119,
		quality = QualityType.eOrange
	},
	{
		equipId = 238,
		name = "山河画卷碎片",
		exchangeCount = 16,
		price = 1100,
		quality = QualityType.eOrange
	},
	{
		equipId = 239,
		name = "降妖宝杖碎片",
		exchangeCount = 16,
		price = 1136,
		quality = QualityType.eOrange
	},
	{
		equipId = 240,
		name = "轩辕神剑碎片",
		exchangeCount = 16,
		price = 1127,
		quality = QualityType.eOrange
	},
	{
		equipId = 241,
		name = "神农宝叉碎片",
		exchangeCount = 16,
		price = 1122,
		quality = QualityType.eOrange
	},
	{
		equipId = 242,
		name = "轮转真符碎片",
		exchangeCount = 16,
		price = 1341,
		quality = QualityType.eOrange
	},
	{
		equipId = 243,
		name = "诛仙战符碎片",
		exchangeCount = 16,
		price = 1359,
		quality = QualityType.eOrange
	},
	{
		equipId = 244,
		name = "重玄水符碎片",
		exchangeCount = 16,
		price = 1379,
		quality = QualityType.eOrange
	},
	{
		equipId = 245,
		name = "业火神符碎片",
		exchangeCount = 16,
		price = 1329,
		quality = QualityType.eOrange
	},
	{
		equipId = 246,
		name = "九黎神符碎片",
		exchangeCount = 16,
		price = 1318,
		quality = QualityType.eOrange
	},
	{
		equipId = 247,
		name = "蛮荒鬼符碎片",
		exchangeCount = 16,
		price = 1345,
		quality = QualityType.eOrange
	},
	{
		equipId = 248,
		name = "九黎魔冠碎片",
		exchangeCount = 16,
		price = 1331,
		quality = QualityType.eOrange
	},
	{
		equipId = 249,
		name = "碧玺金冠碎片",
		exchangeCount = 16,
		price = 1373,
		quality = QualityType.eOrange
	},
	{
		equipId = 250,
		name = "三清道冠碎片",
		exchangeCount = 16,
		price = 1354,
		quality = QualityType.eOrange
	},
	{
		equipId = 251,
		name = "磐龙玉冠碎片",
		exchangeCount = 16,
		price = 1348,
		quality = QualityType.eOrange
	},
	{
		equipId = 252,
		name = "九霄羽冠碎片",
		exchangeCount = 16,
		price = 1366,
		quality = QualityType.eOrange
	},
	{
		equipId = 253,
		name = "紫金魔冕碎片",
		exchangeCount = 16,
		price = 1312,
		quality = QualityType.eOrange
	},
	{
		equipId = 254,
		name = "乾坤战袍碎片",
		exchangeCount = 16,
		price = 1906,
		quality = QualityType.eOrange
	},
	{
		equipId = 255,
		name = "九黎战甲碎片",
		exchangeCount = 16,
		price = 1899,
		quality = QualityType.eOrange
	},
	{
		equipId = 256,
		name = "修罗魔铠碎片",
		exchangeCount = 16,
		price = 1822,
		quality = QualityType.eOrange
	},
	{
		equipId = 257,
		name = "弥罗袈裟碎片",
		exchangeCount = 16,
		price = 1867,
		quality = QualityType.eOrange
	},
	{
		equipId = 258,
		name = "金缕玉衣碎片",
		exchangeCount = 16,
		price = 1851,
		quality = QualityType.eOrange
	},
	{
		equipId = 259,
		name = "炎火战铠碎片",
		exchangeCount = 16,
		price = 1826,
		quality = QualityType.eOrange
	},
	{
		equipId = 260,
		name = "九黎魔戒碎片",
		exchangeCount = 16,
		price = 1975,
		quality = QualityType.eOrange
	},
	{
		equipId = 261,
		name = "龙骨魂戒碎片",
		exchangeCount = 16,
		price = 1982,
		quality = QualityType.eOrange
	},
	{
		equipId = 262,
		name = "琥珀神戒碎片",
		exchangeCount = 16,
		price = 1988,
		quality = QualityType.eOrange
	},
	{
		equipId = 263,
		name = "琉璃玉戒碎片",
		exchangeCount = 16,
		price = 1899,
		quality = QualityType.eOrange
	},
	{
		equipId = 264,
		name = "貔貅宝戒碎片",
		exchangeCount = 16,
		price = 1935,
		quality = QualityType.eOrange
	},
	{
		equipId = 265,
		name = "碧玺神戒碎片",
		exchangeCount = 16,
		price = 1998,
		quality = QualityType.eOrange
	},
	{
		equipId = 266,
		name = "九黎魔链碎片",
		exchangeCount = 16,
		price = 1114,
		quality = QualityType.eOrange
	},
	{
		equipId = 267,
		name = "蛮荒锁链碎片",
		exchangeCount = 16,
		price = 1117,
		quality = QualityType.eOrange
	},
	{
		equipId = 268,
		name = "骷髅魔链碎片",
		exchangeCount = 16,
		price = 1098,
		quality = QualityType.eOrange
	},
	{
		equipId = 269,
		name = "无极神链碎片",
		exchangeCount = 16,
		price = 1140,
		quality = QualityType.eOrange
	},
	{
		equipId = 270,
		name = "太极神链碎片",
		exchangeCount = 16,
		price = 1158,
		quality = QualityType.eOrange
	},
	{
		equipId = 271,
		name = "九转神链碎片",
		exchangeCount = 16,
		price = 1119,
		quality = QualityType.eOrange
	},
	{
		equipId = 272,
		name = "神罚珠碎片",
		exchangeCount = 16,
		price = 1100,
		quality = QualityType.eOrange
	},
	{
		equipId = 273,
		name = "开天斧碎片",
		exchangeCount = 16,
		price = 1136,
		quality = QualityType.eOrange
	},
	{
		equipId = 274,
		name = "龙头镰碎片",
		exchangeCount = 16,
		price = 1127,
		quality = QualityType.eOrange
	},
	{
		equipId = 275,
		name = "随心铁杆碎片",
		exchangeCount = 16,
		price = 1122,
		quality = QualityType.eOrange
	},
	{
		equipId = 276,
		name = "战神戚碎片",
		exchangeCount = 16,
		price = 1341,
		quality = QualityType.eOrange
	},
	{
		equipId = 277,
		name = "填海锤碎片",
		exchangeCount = 16,
		price = 1359,
		quality = QualityType.eOrange
	},
	{
		equipId = 278,
		name = "世间百书碎片",
		exchangeCount = 16,
		price = 1379,
		quality = QualityType.eOrange
	},
	{
		equipId = 279,
		name = "御海剑碎片",
		exchangeCount = 16,
		price = 1329,
		quality = QualityType.eOrange
	},
	{
		equipId = 280,
		name = "洛神赋碎片",
		exchangeCount = 16,
		price = 1318,
		quality = QualityType.eOrange
	},
	{
		equipId = 281,
		name = "芭蕉扇碎片",
		exchangeCount = 16,
		price = 1345,
		quality = QualityType.eOrange
	}
}
