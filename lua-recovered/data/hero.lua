BattleAttrsType = {
	eBaoJi = 8,
	eNormalAttack = 2,
	eGlobal = 99,
	eGeDang = 11,
	ePoJi = 10,
	eRenXing = 9,
	eSpeed = 12,
	eMingZhong = 6,
	eSkillAttack = 4,
	eNormalDefense = 3,
	eSkillDefense = 5,
	eHealth = 1,
	eShanBi = 7
}
BattleAttrsName = {
	string.lf("血量"),
	string.lf("普攻"),
	string.lf("普防"),
	string.lf("法攻"),
	string.lf("法防"),
	string.lf("命中"),
	string.lf("闪避"),
	string.lf("暴击"),
	string.lf("韧性"),
	string.lf("破击"),
	string.lf("格挡"),
	string.lf("速度"),
	[99] = string.lf("全属性")
}
RebirthNames = {
	[0] = string.lf("凡胎"),
	string.lf("炼体"),
	string.lf("炼气"),
	string.lf("筑基"),
	string.lf("灵寂"),
	string.lf("结丹"),
	string.lf("元婴"),
	string.lf("离合"),
	string.lf("分神"),
	string.lf("化神"),
	string.lf("炼虚"),
	string.lf("合体"),
	string.lf("大乘"),
	string.lf("渡劫"),
	(string.lf("真仙"))
}
QualityType = {
	eWhite = 6,
	eRed = 7,
	eGreen = 1,
	eOrange = 4,
	ePurple = 3,
	eNone = 5,
	eBlue = 2
}
QualityNames = {
	[6] = string.lf("白色"),
	[2] = string.lf("蓝色"),
	string.lf("绿色"),
	[5] = string.lf("无色"),
	[3] = string.lf("紫色"),
	[7] = string.lf("红色"),
	[4] = string.lf("橙色")
}
HeroProfession = {
	eWarrior = 2,
	eMage = 3,
	eNone = 4,
	eCommander = 1
}
HeroProfessionNames = {
	[4] = string.lf("通用"),
	string.lf("御士"),
	string.lf("战神"),
	(string.lf("法师"))
}
BaseHeros = {
	[501] = {
		mana = 96,
		name = "藤蔓魂",
		talentId = 10001,
		baoji = 0,
		renxing = 0,
		normaldefense = 25,
		desc = "妖娆无比的山中妖灵，传说为美女形象，只要缠住路人，那此人就再也无法逃脱，最终元神被一点点的吸干殆尽，但是做个风流鬼也是不错",
		skillattack = 141,
		mingzhong = 0,
		physical = 61,
		skillId = 2,
		poji = 0,
		headerImage = "small_tengmanhun.png",
		skilldefense = 49,
		strength = 97,
		shanbi = 0,
		rating = 3,
		pianXiang = "偏防御、单体",
		dropChapterId = 0,
		normalattack = 71,
		agility = 45,
		animation = "xiee_shudaji",
		gedang = 0,
		soulCount = 2,
		health = 368,
		soulId = 5010,
		profession = HeroProfession.eCommander,
		quality = QualityType.eGreen,
		groupAttrs = {
			{
				addType = 99,
				name = "手有余香",
				factor = 0.1,
				heroList = {
					401
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 30,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{20%}",
					"1级初阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+30}",
						"基础战力值{+69}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 45,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【雨韧】提升至1级：",
					"战斗中增加韧性{40}点。",
					attrDescList1 = {
						"潜力点{+35}",
						"基础战力值{+90}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【断魂刺】提升5级：",
					"断魂刺对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+40}",
						"基础战力值{+93}"
					}
				}
			},
			{
				soulCount = 10,
				soulId = 5010,
				mateCount = 75,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+45}",
						"基础战力值{+97}"
					},
					attrDescList2 = {
						"命中{+18}",
						"韧性{+27}",
						"格挡{+42}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 5010,
				mateCount = 95,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{40%}",
					"2级初阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+65}",
						"基础战力值{+60}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 5010,
				mateCount = 115,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【雨韧】提升至2级：",
					"战斗中增加韧性{215}点。",
					attrDescList1 = {
						"潜力点{+70}",
						"基础战力值{+41}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 5010,
				mateCount = 135,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【断魂刺】提升5级：",
					"断魂刺对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+41}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 5010,
				mateCount = 155,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+42}"
					},
					attrDescList2 = {
						"闪避{+48}",
						"韧性{+60}",
						"破击{+15}",
						"格挡{+32}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 5010,
				mateCount = 180,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{60%}",
					"3级初阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+42}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 5010,
				mateCount = 205,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【雨韧】提升至3级：",
					"战斗中增加韧性{435}点。",
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+22}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 5010,
				mateCount = 230,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【断魂刺】提升5级：",
					"断魂刺对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+110}",
						"基础战力值{+22}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 5010,
				mateCount = 255,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+115}",
						"基础战力值{+44}"
					},
					attrDescList2 = {
						"命中{+28}",
						"暴击{+10}",
						"韧性{+89}",
						"格挡{+66}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 5010,
				mateCount = 95,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+70}",
					"@怒气法术【断魂刺】提升1级：",
					"断魂刺对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {}
	},
	[502] = {
		mana = 99,
		name = "兽王",
		talentId = 10003,
		baoji = 0,
		renxing = 0,
		normaldefense = 27,
		desc = "百兽之王，大到熊虎狮蟒，小到蛇虫鼠蚁都对其敬畏有加，传说是一只可以通灵作法的大老虎，不仅威猛无比，还通晓天地自然的道理",
		skillattack = 138,
		mingzhong = 0,
		physical = 55,
		skillId = 2,
		poji = 0,
		headerImage = "small_shouwang.png",
		skilldefense = 53,
		strength = 99,
		shanbi = 0,
		rating = 3,
		pianXiang = "偏防御、单体",
		dropChapterId = 0,
		normalattack = 69,
		agility = 40,
		animation = "yinghu_renwangfuxi",
		gedang = 0,
		soulCount = 3,
		health = 332,
		soulId = 5020,
		profession = HeroProfession.eCommander,
		quality = QualityType.eGreen,
		groupAttrs = {
			{
				addType = 99,
				name = "白骨利刃",
				factor = 0.1,
				heroList = {
					402
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 30,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{20%}",
					"1级初阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+30}",
						"基础战力值{+69}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 45,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【君威】提升至1级：",
					"战斗中增加格挡{40}点。",
					attrDescList1 = {
						"潜力点{+35}",
						"基础战力值{+90}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【断魂刺】提升5级：",
					"断魂刺对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+40}",
						"基础战力值{+93}"
					}
				}
			},
			{
				soulCount = 10,
				soulId = 5020,
				mateCount = 75,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+45}",
						"基础战力值{+97}"
					},
					attrDescList2 = {
						"韧性{+35}",
						"破击{+18}",
						"格挡{+35}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 5020,
				mateCount = 95,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{40%}",
					"2级初阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+65}",
						"基础战力值{+60}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 5020,
				mateCount = 115,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【君威】提升至2级：",
					"战斗中增加格挡{215}点。",
					attrDescList1 = {
						"潜力点{+70}",
						"基础战力值{+41}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 5020,
				mateCount = 135,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【断魂刺】提升5级：",
					"断魂刺对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+41}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 5020,
				mateCount = 155,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+42}"
					},
					attrDescList2 = {
						"闪避{+32}",
						"韧性{+46}",
						"破击{+16}",
						"格挡{+63}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 5020,
				mateCount = 180,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{60%}",
					"3级初阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+42}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 5020,
				mateCount = 205,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【君威】提升至3级：",
					"战斗中增加格挡{435}点。",
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+22}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 5020,
				mateCount = 230,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【断魂刺】提升5级：",
					"断魂刺对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+110}",
						"基础战力值{+22}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 5020,
				mateCount = 255,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+115}",
						"基础战力值{+44}"
					},
					attrDescList2 = {
						"命中{+10}",
						"暴击{+10}",
						"韧性{+90}",
						"格挡{+89}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 5020,
				mateCount = 95,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+70}",
					"@怒气法术【断魂刺】提升1级：",
					"断魂刺对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {}
	},
	[503] = {
		mana = 93,
		name = "绿毛妖",
		talentId = 10006,
		baoji = 0,
		renxing = 0,
		normaldefense = 24,
		desc = "毛妖中的大妖怪，率领诸多毛色的小妖纵横山野，因毛色不同能力各有不同，但均不可小觑",
		skillattack = 144,
		mingzhong = 0,
		physical = 48,
		skillId = 4,
		poji = 0,
		headerImage = "small_lvmaoyao.png",
		skilldefense = 45,
		strength = 103,
		shanbi = 0,
		rating = 3,
		pianXiang = "偏物攻、单体",
		dropChapterId = 0,
		normalattack = 83,
		agility = 52,
		animation = "guailishu_longxuhu_lv",
		gedang = 0,
		soulCount = 1,
		health = 290,
		soulId = 5030,
		profession = HeroProfession.eWarrior,
		quality = QualityType.eGreen,
		groupAttrs = {
			{
				addType = 99,
				name = "群妖聚义",
				factor = 0.1,
				heroList = {
					403
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 30,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{20%}",
					"1级初阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+30}",
						"基础战力值{+69}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 45,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【蛟爪】提升至1级：",
					"战斗中增加破击{40}点。",
					attrDescList1 = {
						"潜力点{+35}",
						"基础战力值{+90}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【破天一击】提升5级：",
					"破天一击对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+40}",
						"基础战力值{+93}"
					}
				}
			},
			{
				soulCount = 10,
				soulId = 5030,
				mateCount = 75,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+45}",
						"基础战力值{+97}"
					},
					attrDescList2 = {
						"命中{+44}",
						"暴击{+27}",
						"破击{+17}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 5030,
				mateCount = 95,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{40%}",
					"2级初阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+65}",
						"基础战力值{+60}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 5030,
				mateCount = 115,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【蛟爪】提升至2级：",
					"战斗中增加破击{230}点。",
					attrDescList1 = {
						"潜力点{+70}",
						"基础战力值{+41}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 5030,
				mateCount = 135,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【破天一击】提升5级：",
					"破天一击对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+41}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 5030,
				mateCount = 155,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+42}"
					},
					attrDescList2 = {
						"命中{+47}",
						"暴击{+15}",
						"破击{+62}",
						"格挡{+31}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 5030,
				mateCount = 180,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{60%}",
					"3级初阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+42}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 5030,
				mateCount = 205,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【蛟爪】提升至3级：",
					"战斗中增加破击{470}点。",
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+22}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 5030,
				mateCount = 230,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【破天一击】提升5级：",
					"破天一击对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+110}",
						"基础战力值{+22}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 5030,
				mateCount = 255,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+115}",
						"基础战力值{+44}"
					},
					attrDescList2 = {
						"命中{+74}",
						"闪避{+19}",
						"韧性{+20}",
						"破击{+79}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 5030,
				mateCount = 95,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+70}",
					"@怒气法术【破天一击】提升1级：",
					"破天一击对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {}
	},
	[504] = {
		mana = 90,
		name = "蛮王",
		talentId = 10005,
		baoji = 0,
		renxing = 0,
		normaldefense = 25,
		desc = "蛮荒之地的霸主，很少在中原地区出现，但在外域地区却极为常见，在属于自己领地，他能够调动一切力量作战，极为强悍",
		skillattack = 142,
		mingzhong = 0,
		physical = 51,
		skillId = 4,
		poji = 0,
		headerImage = "small_manwang.png",
		skilldefense = 42,
		strength = 110,
		shanbi = 0,
		rating = 3,
		pianXiang = "偏物攻、单体",
		dropChapterId = 0,
		normalattack = 90,
		agility = 49,
		animation = "yeshou_chiyou_hong",
		gedang = 0,
		soulCount = 2,
		health = 303,
		soulId = 5040,
		profession = HeroProfession.eWarrior,
		quality = QualityType.eGreen,
		groupAttrs = {
			{
				addType = 99,
				name = "人兽合一",
				factor = 0.1,
				heroList = {
					404
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 30,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{20%}",
					"1级初阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+30}",
						"基础战力值{+69}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 45,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【精准】提升至1级：",
					"战斗中增加命中{35}点。",
					attrDescList1 = {
						"潜力点{+35}",
						"基础战力值{+90}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【破天一击】提升5级：",
					"破天一击对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+40}",
						"基础战力值{+93}"
					}
				}
			},
			{
				soulCount = 10,
				soulId = 5040,
				mateCount = 75,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+45}",
						"基础战力值{+97}"
					},
					attrDescList2 = {
						"命中{+17}",
						"暴击{+43}",
						"破击{+25}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 5040,
				mateCount = 95,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{40%}",
					"2级初阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+65}",
						"基础战力值{+60}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 5040,
				mateCount = 115,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【精准】提升至2级：",
					"战斗中增加命中{200}点。",
					attrDescList1 = {
						"潜力点{+70}",
						"基础战力值{+41}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 5040,
				mateCount = 135,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【破天一击】提升5级：",
					"破天一击对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+41}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 5040,
				mateCount = 155,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+42}"
					},
					attrDescList2 = {
						"命中{+61}",
						"闪避{+30}",
						"暴击{+45}",
						"破击{+15}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 5040,
				mateCount = 180,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{60%}",
					"3级初阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+42}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 5040,
				mateCount = 205,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【精准】提升至3级：",
					"战斗中增加命中{405}点",
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+22}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 5040,
				mateCount = 230,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【破天一击】提升5级：",
					"破天一击对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+110}",
						"基础战力值{+22}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 5040,
				mateCount = 255,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+115}",
						"基础战力值{+44}"
					},
					attrDescList2 = {
						"命中{+50}",
						"暴击{+77}",
						"韧性{+19}",
						"破击{+48}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 5040,
				mateCount = 95,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+70}",
					"@怒气法术【破天一击】提升1级：",
					"破天一击对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {}
	},
	[505] = {
		mana = 115,
		name = "修仙道童",
		talentId = 10007,
		baoji = 0,
		renxing = 0,
		normaldefense = 25,
		desc = "学习道术的小道童，拥有一定的仙法道术，希望有一日可以位列仙班，时常因为自己的学业无法精进而感到苦恼",
		skillattack = 176,
		mingzhong = 0,
		physical = 43,
		skillId = 6,
		poji = 0,
		headerImage = "small_xiuxiandaotong.png",
		skilldefense = 56,
		strength = 104,
		shanbi = 0,
		rating = 3,
		pianXiang = "偏法攻、单体",
		dropChapterId = 0,
		normalattack = 80,
		agility = 47,
		animation = "xiaodaotongjia_tangchanglaojun_he",
		gedang = 0,
		soulCount = 1,
		health = 257,
		soulId = 5050,
		profession = HeroProfession.eMage,
		quality = QualityType.eGreen,
		groupAttrs = {
			{
				addType = 99,
				name = "采花小道",
				factor = 0.1,
				heroList = {
					405
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 30,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{20%}",
					"1级初阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+30}",
						"基础战力值{+69}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 45,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【天威】提升至1级：",
					"战斗开始时增加怒气{20}点。",
					attrDescList1 = {
						"潜力点{+35}",
						"基础战力值{+90}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【心炎诀】提升5级：",
					"心炎诀对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+40}",
						"基础战力值{+93}"
					}
				}
			},
			{
				soulCount = 10,
				soulId = 5050,
				mateCount = 75,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+45}",
						"基础战力值{+97}"
					},
					attrDescList2 = {
						"命中{+18}",
						"暴击{+25}",
						"破击{+45}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 5050,
				mateCount = 95,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{40%}",
					"2级初阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+65}",
						"基础战力值{+60}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 5050,
				mateCount = 115,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【天威】提升至2级：",
					"战斗开始时增加怒气{50}点。",
					attrDescList1 = {
						"潜力点{+70}",
						"基础战力值{+41}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 5050,
				mateCount = 135,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【心炎诀】提升5级：",
					"心炎诀对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+41}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 5050,
				mateCount = 155,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+42}"
					},
					attrDescList2 = {
						"命中{+48}",
						"闪避{+16}",
						"暴击{+31}",
						"破击{+63}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 5050,
				mateCount = 180,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{60%}",
					"3级初阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+42}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 5050,
				mateCount = 205,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【天威】提升至3级：",
					"战斗开始时增加怒气{100}点",
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+22}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 5050,
				mateCount = 230,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【心炎诀】提升5级：",
					"心炎诀对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+110}",
						"基础战力值{+22}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 5050,
				mateCount = 255,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+115}",
						"基础战力值{+44}"
					},
					attrDescList2 = {
						"命中{+28}",
						"暴击{+40}",
						"韧性{+38}",
						"破击{+88}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 5050,
				mateCount = 95,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+70}",
					"@怒气法术【心炎诀】提升1级：",
					"心炎诀对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {}
	},
	[506] = {
		mana = 115,
		name = "求佛沙弥",
		talentId = 10009,
		baoji = 0,
		renxing = 0,
		normaldefense = 26,
		desc = "学习佛学的小和尚，拥有一定的佛法力量，最大的愿望是有一天可以朝拜如来佛，每天都把如来佛的照片膜拜一千次",
		skillattack = 188,
		mingzhong = 0,
		physical = 42,
		skillId = 6,
		poji = 0,
		headerImage = "small_qiufoshami.png",
		skilldefense = 52,
		strength = 101,
		shanbi = 0,
		rating = 3,
		pianXiang = "偏法攻、单体",
		dropChapterId = 0,
		normalattack = 74,
		agility = 48,
		animation = "xiaoheshang_lan",
		gedang = 0,
		soulCount = 3,
		health = 254,
		soulId = 5060,
		profession = HeroProfession.eMage,
		quality = QualityType.eGreen,
		groupAttrs = {
			{
				addType = 99,
				name = "佛法无边",
				factor = 0.1,
				heroList = {
					406
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 30,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{20%}",
					"1级初阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+30}",
						"基础战力值{+69}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 45,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【花雨】提升至1级：",
					"战斗中增加闪避{33}点。",
					attrDescList1 = {
						"潜力点{+35}",
						"基础战力值{+90}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【心炎诀】提升5级：",
					"心炎诀对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+40}",
						"基础战力值{+93}"
					}
				}
			},
			{
				soulCount = 10,
				soulId = 5060,
				mateCount = 75,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+45}",
						"基础战力值{+97}"
					},
					attrDescList2 = {
						"命中{+17}",
						"暴击{+44}",
						"破击{+26}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 5060,
				mateCount = 95,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{40%}",
					"2级初阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+65}",
						"基础战力值{+60}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 5060,
				mateCount = 115,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【花雨】提升至2级：",
					"战斗中增加韧性{185}点。",
					attrDescList1 = {
						"潜力点{+70}",
						"基础战力值{+41}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 5060,
				mateCount = 135,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【心炎诀】提升5级：",
					"心炎诀对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+41}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 5060,
				mateCount = 155,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+42}"
					},
					attrDescList2 = {
						"命中{+63}",
						"闪避{+48}",
						"暴击{+15}",
						"破击{+32}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 5060,
				mateCount = 180,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{60%}",
					"3级初阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+42}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 5060,
				mateCount = 205,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【花雨】提升至3级：",
					"战斗中增加韧性{380}点。",
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+22}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 5060,
				mateCount = 230,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【心炎诀】提升5级：",
					"心炎诀对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+110}",
						"基础战力值{+22}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 5060,
				mateCount = 255,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+115}",
						"基础战力值{+44}"
					},
					attrDescList2 = {
						"命中{+70}",
						"暴击{+90}",
						"韧性{+9}",
						"破击{+30}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 5060,
				mateCount = 95,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+70}",
					"@怒气法术【心炎诀】提升1级：",
					"心炎诀对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {}
	},
	[401] = {
		mana = 137,
		name = "女儿国王",
		talentId = 10003,
		baoji = 0,
		renxing = 0,
		normaldefense = 35,
		desc = "虽然面貌端庄秀丽，体态妖娆丰腴。但却是连个男妃都没有可怜国王，好不容易看上个男人还是个和尚…堪称西游最屌丝的白富美。",
		skillattack = 200,
		mingzhong = 0,
		physical = 74,
		skillId = 2,
		poji = 0,
		headerImage = "small_nverguoguowang.png",
		skilldefense = 70,
		strength = 137,
		shanbi = 0,
		rating = 4,
		pianXiang = "偏防御、单体",
		dropChapterId = 0,
		normalattack = 100,
		agility = 61,
		animation = "nverguoguowang",
		gedang = 0,
		soulCount = 8,
		health = 443,
		soulId = 4010,
		profession = HeroProfession.eCommander,
		quality = QualityType.eBlue,
		groupAttrs = {
			{
				addType = 99,
				name = "手有余香",
				factor = 0.1,
				heroList = {
					501
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 40,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{20%}",
					"1级初阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+40}",
						"基础战力值{+92}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【君威】提升至1级：",
					"战斗中增加格挡{40}点。",
					attrDescList1 = {
						"潜力点{+50}",
						"基础战力值{+119}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 80,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【断魂刺】提升5级：",
					"断魂刺对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+124}"
					}
				}
			},
			{
				soulCount = 12,
				soulId = 4010,
				mateCount = 100,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+70}",
						"基础战力值{+129}"
					},
					attrDescList2 = {
						"命中{+23}",
						"韧性{+33}",
						"格挡{+55}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 4010,
				mateCount = 130,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{40%}",
					"2级初阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+80}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 4010,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【君威】提升至2级：",
					"战斗中增加格挡{215}点。",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+54}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 4010,
				mateCount = 190,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【断魂刺】提升5级：",
					"断魂刺对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+110}",
						"基础战力值{+55}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 4010,
				mateCount = 220,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+56}"
					},
					attrDescList2 = {
						"闪避{+65}",
						"韧性{+82}",
						"破击{+21}",
						"格挡{+43}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 4010,
				mateCount = 260,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{60%}",
					"3级初阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+56}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 4010,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【君威】提升至3级：",
					"战斗中增加格挡{435}点。",
					attrDescList1 = {
						"潜力点{+150}",
						"基础战力值{+29}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 4010,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【断魂刺】提升5级：",
					"断魂刺对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+160}",
						"基础战力值{+29}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 4010,
				mateCount = 380,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+170}",
						"基础战力值{+58}"
					},
					attrDescList2 = {
						"命中{+40}",
						"暴击{+13}",
						"韧性{+116}",
						"格挡{+93}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 4010,
				mateCount = 130,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+100}",
					"@怒气法术【断魂刺】提升1级：",
					"断魂刺对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 74,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 39,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 192,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[402] = {
		mana = 140,
		name = "白骨精",
		talentId = 10002,
		baoji = 0,
		renxing = 0,
		normaldefense = 38,
		desc = "高智商有勇有谋型妖怪，舍身堵抢眼，成功逼走孙悟空，拆散了取经团队。这种对唐僧锲而不舍的精神非常值得其他妖怪学习。",
		skillattack = 194,
		mingzhong = 0,
		physical = 75,
		skillId = 3,
		poji = 0,
		headerImage = "small_baigujing.png",
		skilldefense = 75,
		strength = 140,
		shanbi = 0,
		rating = 4,
		pianXiang = "偏防御、单体",
		dropChapterId = 0,
		normalattack = 97,
		agility = 55,
		animation = "baigujing",
		gedang = 0,
		soulCount = 8,
		health = 447,
		soulId = 4020,
		profession = HeroProfession.eCommander,
		quality = QualityType.eBlue,
		groupAttrs = {
			{
				addType = 99,
				name = "白骨利刃",
				factor = 0.1,
				heroList = {
					502
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 40,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{20%}",
					"1级初阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+40}",
						"基础战力值{+92}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【骨盾】提升至1级：",
					"初次被攻击{100%}格挡。",
					attrDescList1 = {
						"潜力点{+50}",
						"基础战力值{+119}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 80,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【生肌术】提升5级：",
					"生肌术可回复目标生命值提升{5%}",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+124}"
					}
				}
			},
			{
				soulCount = 12,
				soulId = 4020,
				mateCount = 100,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+70}",
						"基础战力值{+129}"
					},
					attrDescList2 = {
						"韧性{+48}",
						"破击{+22}",
						"格挡{+47}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 4020,
				mateCount = 130,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{40%}",
					"2级初阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+80}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 4020,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【骨盾】提升至2级：",
					"初次被攻击{100%}格挡，且有{80%}概率格挡第二次攻击。",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+54}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 4020,
				mateCount = 190,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【生肌术】提升5级：",
					"生肌术可回复目标生命值提升{5%}",
					attrDescList1 = {
						"潜力点{+110}",
						"基础战力值{+55}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 4020,
				mateCount = 220,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+56}"
					},
					attrDescList2 = {
						"闪避{+40}",
						"韧性{+64}",
						"破击{+21}",
						"格挡{+83}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 4020,
				mateCount = 260,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{60%}",
					"3级初阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+56}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 4020,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【骨盾】提升至3级：",
					"初次被攻击{100%}格挡，且有{80%}、{50%}概率格挡第二次、第三次攻击。",
					attrDescList1 = {
						"潜力点{+150}",
						"基础战力值{+29}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 4020,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【生肌术】提升5级：",
					"生肌术可回复目标生命值提升{5%}",
					attrDescList1 = {
						"潜力点{+160}",
						"基础战力值{+29}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 4020,
				mateCount = 380,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+170}",
						"基础战力值{+58}"
					},
					attrDescList2 = {
						"命中{+13}",
						"暴击{+13}",
						"韧性{+114}",
						"格挡{+110}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 4020,
				mateCount = 130,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+100}",
					"@怒气法术【生肌术】提升1级：",
					"生肌术可回复目标生命值提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 73,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 38,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 193,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[403] = {
		mana = 123,
		name = "蛟魔王",
		talentId = 10006,
		baoji = 0,
		renxing = 0,
		normaldefense = 32,
		desc = "孙悟空的结拜兄弟七大圣之一,本是水中得道蛟龙一条，号复海大圣。有一帮实力强悍的小伙伴，日子过得是逍遥快活…",
		skillattack = 190,
		mingzhong = 0,
		physical = 70,
		skillId = 4,
		poji = 0,
		headerImage = "small_jiaomowang.png",
		skilldefense = 60,
		strength = 137,
		shanbi = 0,
		rating = 4,
		pianXiang = "偏物攻、单体",
		dropChapterId = 0,
		normalattack = 110,
		agility = 75,
		animation = "jiaomowang",
		gedang = 0,
		soulCount = 5,
		health = 417,
		soulId = 4030,
		profession = HeroProfession.eWarrior,
		quality = QualityType.eBlue,
		groupAttrs = {
			{
				addType = 99,
				name = "群妖聚义",
				factor = 0.1,
				heroList = {
					503
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 40,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{20%}",
					"1级初阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+40}",
						"基础战力值{+92}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【蛟爪】提升至1级：",
					"战斗中增加破击{40}点。",
					attrDescList1 = {
						"潜力点{+50}",
						"基础战力值{+119}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 80,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【破天一击】提升5级：",
					"破天一击对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+124}"
					}
				}
			},
			{
				soulCount = 12,
				soulId = 4030,
				mateCount = 100,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+70}",
						"基础战力值{+129}"
					},
					attrDescList2 = {
						"命中{+58}",
						"暴击{+35}",
						"破击{+23}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 4030,
				mateCount = 130,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{40%}",
					"2级初阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+80}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 4030,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【蛟爪】提升至2级：",
					"战斗中增加破击{230}点。",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+54}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 4030,
				mateCount = 190,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【破天一击】提升5级：",
					"破天一击对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+110}",
						"基础战力值{+55}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 4030,
				mateCount = 220,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+56}"
					},
					attrDescList2 = {
						"命中{+60}",
						"暴击{+22}",
						"破击{+83}",
						"格挡{+41}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 4030,
				mateCount = 260,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{60%}",
					"3级初阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+56}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 4030,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【蛟爪】提升至3级：",
					"战斗中增加破击{470}点。",
					attrDescList1 = {
						"潜力点{+150}",
						"基础战力值{+29}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 4030,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【破天一击】提升5级：",
					"破天一击对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+160}",
						"基础战力值{+29}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 4030,
				mateCount = 380,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+170}",
						"基础战力值{+58}"
					},
					attrDescList2 = {
						"命中{+102}",
						"闪避{+26}",
						"韧性{+27}",
						"破击{+101}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 4030,
				mateCount = 130,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+100}",
					"@怒气法术【破天一击】提升1级：",
					"破天一击对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 4,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 130,
				attrValue = 15,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 195,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[404] = {
		mana = 129,
		name = "龙须虎",
		talentId = 10005,
		baoji = 0,
		renxing = 0,
		normaldefense = 36,
		desc = "在封神大战中是屡建奇功，但是最后被巨人邬文化所杀。体型硕大，长的像虎又像龙,属奇珍异兽款,动物园都见不到的。",
		skillattack = 204,
		mingzhong = 0,
		physical = 66,
		skillId = 5,
		poji = 0,
		headerImage = "small_longxuhu.png",
		skilldefense = 61,
		strength = 158,
		shanbi = 0,
		rating = 4,
		pianXiang = "偏物攻、一列",
		dropChapterId = 0,
		normalattack = 129,
		agility = 68,
		animation = "longxuhuse",
		gedang = 0,
		soulCount = 6,
		health = 393,
		soulId = 4040,
		profession = HeroProfession.eWarrior,
		quality = QualityType.eBlue,
		groupAttrs = {
			{
				addType = 99,
				name = "人兽合一",
				factor = 0.1,
				heroList = {
					504
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 40,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{20%}",
					"1级初阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+40}",
						"基础战力值{+92}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【精准】提升至1级：",
					"战斗中增加命中{35}点。",
					attrDescList1 = {
						"潜力点{+50}",
						"基础战力值{+119}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 80,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【长虹贯日】提升5级：",
					"长虹贯日对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+124}"
					}
				}
			},
			{
				soulCount = 12,
				soulId = 4040,
				mateCount = 100,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+70}",
						"基础战力值{+129}"
					},
					attrDescList2 = {
						"命中{+22}",
						"暴击{+60}",
						"破击{+34}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 4040,
				mateCount = 130,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{40%}",
					"2级初阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+80}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 4040,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【精准】提升至2级：",
					"战斗中增加命中{200}点。",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+54}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 4040,
				mateCount = 190,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【长虹贯日】提升5级：",
					"长虹贯日对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+110}",
						"基础战力值{+55}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 4040,
				mateCount = 220,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+56}"
					},
					attrDescList2 = {
						"命中{+80}",
						"闪避{+40}",
						"暴击{+62}",
						"破击{+21}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 4040,
				mateCount = 260,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{60%}",
					"3级初阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+56}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 4040,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【精准】提升至3级：",
					"战斗中增加命中{405}点",
					attrDescList1 = {
						"潜力点{+150}",
						"基础战力值{+29}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 4040,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【长虹贯日】提升5级：",
					"长虹贯日对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+160}",
						"基础战力值{+29}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 4040,
				mateCount = 380,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+170}",
						"基础战力值{+58}"
					},
					attrDescList2 = {
						"命中{+63}",
						"暴击{+104}",
						"韧性{+25}",
						"破击{+63}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 4040,
				mateCount = 130,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+100}",
					"@怒气法术【长虹贯日】提升1级：",
					"长虹贯日对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 41,
				attrValue = 25,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 131,
				attrValue = 10,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 196,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[405] = {
		mana = 145,
		name = "百花仙子",
		talentId = 10009,
		baoji = 0,
		renxing = 0,
		normaldefense = 32,
		desc = "掌管天上人间百种花卉，美丽异常，后因触犯天条让百花一齐开放被贬人间，却等到了缘分，演了一出美丽的《镜花缘》。",
		skillattack = 222,
		mingzhong = 0,
		physical = 59,
		skillId = 7,
		poji = 0,
		headerImage = "small_baihuaxianzi.png",
		skilldefense = 71,
		strength = 131,
		shanbi = 0,
		rating = 4,
		pianXiang = "偏治疗、单奶",
		dropChapterId = 0,
		normalattack = 101,
		agility = 67,
		animation = "baihuaxianzi",
		gedang = 0,
		soulCount = 7,
		health = 354,
		soulId = 4050,
		profession = HeroProfession.eMage,
		quality = QualityType.eBlue,
		groupAttrs = {
			{
				addType = 99,
				name = "采花小道",
				factor = 0.1,
				heroList = {
					505
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 40,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{20%}",
					"1级初阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+40}",
						"基础战力值{+92}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【花雨】提升至1级：",
					"战斗中增加闪避{33}点。",
					attrDescList1 = {
						"潜力点{+50}",
						"基础战力值{+119}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 80,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【百花诀】提升5级：",
					"百花诀可回复目标生命值提升{5%}",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+124}"
					}
				}
			},
			{
				soulCount = 12,
				soulId = 4050,
				mateCount = 100,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+70}",
						"基础战力值{+129}"
					},
					attrDescList2 = {
						"命中{+22}",
						"暴击{+33}",
						"破击{+57}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 4050,
				mateCount = 130,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{40%}",
					"2级初阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+80}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 4050,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【花雨】提升至2级：",
					"战斗中增加韧性{185}点。",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+54}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 4050,
				mateCount = 190,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【百花诀】提升5级：",
					"百花诀可回复目标生命值提升{5%}",
					attrDescList1 = {
						"潜力点{+110}",
						"基础战力值{+55}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 4050,
				mateCount = 220,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+56}"
					},
					attrDescList2 = {
						"命中{+65}",
						"闪避{+20}",
						"暴击{+41}",
						"破击{+86}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 4050,
				mateCount = 260,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{60%}",
					"3级初阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+56}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 4050,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【花雨】提升至3级：",
					"战斗中增加韧性{380}点。",
					attrDescList1 = {
						"潜力点{+150}",
						"基础战力值{+29}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 4050,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【百花诀】提升5级：",
					"百花诀可回复目标生命值提升{5%}",
					attrDescList1 = {
						"潜力点{+160}",
						"基础战力值{+29}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 4050,
				mateCount = 380,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+170}",
						"基础战力值{+58}"
					},
					attrDescList2 = {
						"命中{+38}",
						"暴击{+52}",
						"韧性{+50}",
						"破击{+119}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 4050,
				mateCount = 130,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+100}",
					"@怒气法术【百花诀】提升1级：",
					"百花诀可回复目标生命值提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 74,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 2,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 198,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[406] = {
		mana = 153,
		name = "日值功曹",
		talentId = 10007,
		baoji = 0,
		renxing = 0,
		normaldefense = 35,
		desc = "待人和蔼真诚，工作细致负责。因工作原因，每天的大事都得记录，导致一年到头都没有休假。真是一个尽职尽责的模范公务员。",
		skillattack = 250,
		mingzhong = 0,
		physical = 60,
		skillId = 6,
		poji = 0,
		headerImage = "small_rizhigongcao.png",
		skilldefense = 69,
		strength = 135,
		shanbi = 0,
		rating = 4,
		pianXiang = "偏法攻、单体",
		dropChapterId = 0,
		normalattack = 99,
		agility = 68,
		animation = "zhiniangongcao",
		gedang = 0,
		soulCount = 5,
		health = 362,
		soulId = 4060,
		profession = HeroProfession.eMage,
		quality = QualityType.eBlue,
		groupAttrs = {
			{
				addType = 99,
				name = "佛法无边",
				factor = 0.1,
				heroList = {
					506
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 40,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{20%}",
					"1级初阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+40}",
						"基础战力值{+92}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【天威】提升至1级：",
					"战斗开始时增加怒气{20}点。",
					attrDescList1 = {
						"潜力点{+50}",
						"基础战力值{+119}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 80,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【心炎诀】提升5级：",
					"心炎诀对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+124}"
					}
				}
			},
			{
				soulCount = 12,
				soulId = 4060,
				mateCount = 100,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+70}",
						"基础战力值{+129}"
					},
					attrDescList2 = {
						"命中{+23}",
						"暴击{+58}",
						"破击{+34}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 4060,
				mateCount = 130,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{40%}",
					"2级初阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+80}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 4060,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【天威】提升至2级：",
					"战斗开始时增加怒气{50}点。",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+54}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 4060,
				mateCount = 190,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【心炎诀】提升5级：",
					"心炎诀对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+110}",
						"基础战力值{+55}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 4060,
				mateCount = 220,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+56}"
					},
					attrDescList2 = {
						"命中{+85}",
						"闪避{+65}",
						"暴击{+20}",
						"破击{+42}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 4060,
				mateCount = 260,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{60%}",
					"3级初阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+56}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 4060,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【天威】提升至3级：",
					"战斗开始时增加怒气{100}点",
					attrDescList1 = {
						"潜力点{+150}",
						"基础战力值{+29}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 4060,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【心炎诀】提升5级：",
					"心炎诀对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+160}",
						"基础战力值{+29}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 4060,
				mateCount = 380,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+170}",
						"基础战力值{+58}"
					},
					attrDescList2 = {
						"命中{+92}",
						"暴击{+113}",
						"韧性{+13}",
						"破击{+38}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 4060,
				mateCount = 130,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+100}",
					"@怒气法术【心炎诀】提升1级：",
					"心炎诀对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 70,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 6,
				attrValue = 25,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 199,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[301] = {
		mana = 160,
		name = "苏妲己",
		talentId = 10010,
		baoji = 0,
		renxing = 0,
		normaldefense = 43,
		desc = "四大妖姬之一，九尾狐狸精的化身。生得花容月貌，看一眼就飘飘欲仙的那种，不过道行也够深，是个有实力的花瓶。",
		skillattack = 223,
		mingzhong = 0,
		physical = 89,
		skillId = 9,
		poji = 0,
		headerImage = "small_sudaji.png",
		skilldefense = 86,
		strength = 161,
		shanbi = 0,
		rating = 5,
		pianXiang = "偏物攻、前排",
		dropChapterId = 10069,
		normalattack = 112,
		agility = 67,
		animation = "sudaji",
		gedang = 0,
		soulCount = 17,
		health = 535,
		soulId = 3010,
		profession = HeroProfession.eCommander,
		quality = QualityType.ePurple,
		groupAttrs = {
			{
				addType = 99,
				name = "妖鬼当道",
				factor = 0.1,
				heroList = {
					302
				}
			},
			{
				addType = 99,
				name = "鬼王狐魅",
				factor = 0.1,
				heroList = {
					303
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 50,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{20%}",
					"1级中阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+115}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 75,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【魅惑】提升至1级：",
					"首次被攻击{100%}闪避。",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+149}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 100,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【红鸾帐】提升5级：",
					"红鸾帐可将目标攻击力加成值提升{5%}",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+155}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 3010,
				mateCount = 125,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+161}"
					},
					attrDescList2 = {
						"韧性{+60}",
						"破击{+28}",
						"格挡{+60}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 3010,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{40%}",
					"2级中阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+125}",
						"基础战力值{+167}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 3010,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【魅惑】提升至2级：",
					"首次被攻击{100%}闪避，且有{50%}概率闪避第二次攻击。",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+172}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 3010,
				mateCount = 240,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【红鸾帐】提升5级：",
					"红鸾帐可将目标攻击力加成值提升{5%}",
					attrDescList1 = {
						"潜力点{+155}",
						"基础战力值{+178}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 3010,
				mateCount = 280,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+175}",
						"基础战力值{+184}"
					},
					attrDescList2 = {
						"闪避{+53}",
						"韧性{+75}",
						"破击{+27}",
						"格挡{+100}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 3010,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{60%}",
					"3级中阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+195}",
						"基础战力值{+190}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 3010,
				mateCount = 400,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【魅惑】提升至3级：",
					"首次被攻击{100%}闪避，且有{50%}、{30%}概率闪避第二次、第三次攻击。",
					attrDescList1 = {
						"潜力点{+210}",
						"基础战力值{+196}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 3010,
				mateCount = 460,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【红鸾帐】提升5级：",
					"红鸾帐可将目标攻击力加成值提升{5%}",
					attrDescList1 = {
						"潜力点{+225}",
						"基础战力值{+201}"
					}
				}
			},
			{
				soulCount = 46,
				soulId = 3010,
				mateCount = 520,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+207}"
					},
					attrDescList2 = {
						"命中{+15}",
						"暴击{+15}",
						"韧性{+147}",
						"格挡{+149}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 3010,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+150}",
					"@怒气法术【红鸾帐】提升1级：",
					"红鸾帐可将目标攻击力加成值提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 77,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 44,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 19,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 143,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 111,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 181,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[302] = {
		mana = 154,
		name = "钟馗",
		talentId = 10013,
		baoji = 0,
		renxing = 0,
		normaldefense = 39,
		desc = "驱鬼大神，为人耿直忠正，虽生得豹头环眼，铁面虬鬓，相貌奇异；然而却是个才华横溢、满腹经纶的人物，平素正气浩然，刚直不阿。",
		skillattack = 225,
		mingzhong = 0,
		physical = 95,
		skillId = 8,
		poji = 0,
		headerImage = "small_zhongkui.png",
		skilldefense = 79,
		strength = 153,
		shanbi = 0,
		rating = 5,
		pianXiang = "偏防御、后排增益",
		dropChapterId = 0,
		normalattack = 112,
		agility = 77,
		animation = "zhongkui",
		gedang = 0,
		soulCount = 16,
		health = 568,
		soulId = 3020,
		profession = HeroProfession.eCommander,
		quality = QualityType.ePurple,
		groupAttrs = {
			{
				addType = 99,
				name = "妖鬼当道",
				factor = 0.1,
				heroList = {
					301
				}
			},
			{
				addType = 99,
				name = "捉放九尾",
				factor = 0.1,
				heroList = {
					304
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 50,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{20%}",
					"1级中阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+115}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 75,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【驱邪】提升至1级：",
					"{30%}概率异常状态附加失败。",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+149}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 100,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【五鬼动】提升5级：",
					"五鬼动对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+155}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 3020,
				mateCount = 125,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+161}"
					},
					attrDescList2 = {
						"命中{+29}",
						"韧性{+43}",
						"格挡{+72}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 3020,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{40%}",
					"2级中阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+125}",
						"基础战力值{+167}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 3020,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【驱邪】提升至2级：",
					"{50%}概率异常状态附加失败。",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+172}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 3020,
				mateCount = 240,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【五鬼动】提升5级：",
					"五鬼动对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+155}",
						"基础战力值{+178}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 3020,
				mateCount = 280,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+175}",
						"基础战力值{+184}"
					},
					attrDescList2 = {
						"闪避{+76}",
						"韧性{+101}",
						"破击{+26}",
						"格挡{+54}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 3020,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{60%}",
					"3级中阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+195}",
						"基础战力值{+190}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 3020,
				mateCount = 400,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【驱邪】提升至3级：",
					"{70%}概率异常状态附加失败。",
					attrDescList1 = {
						"潜力点{+210}",
						"基础战力值{+196}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 3020,
				mateCount = 460,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【五鬼动】提升5级：",
					"五鬼动对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+225}",
						"基础战力值{+201}"
					}
				}
			},
			{
				soulCount = 46,
				soulId = 3020,
				mateCount = 520,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+207}"
					},
					attrDescList2 = {
						"命中{+48}",
						"暴击{+15}",
						"韧性{+149}",
						"格挡{+111}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 3020,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+150}",
					"@怒气法术【五鬼动】提升1级：",
					"五鬼动对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 79,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 47,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 14,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 136,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 107,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 182,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[303] = {
		mana = 160,
		name = "阎罗王",
		talentId = 10014,
		baoji = 0,
		renxing = 0,
		normaldefense = 43,
		desc = "十殿阎王之一，本来是第一殿当老大的，结果因为心软放人还阳，收不到钱于是被调至第五殿。看来司法公正是不容侵犯的。",
		skillattack = 223,
		mingzhong = 0,
		physical = 97,
		skillId = 10,
		poji = 0,
		headerImage = "small_yanluowang.png",
		skilldefense = 86,
		strength = 160,
		shanbi = 0,
		rating = 5,
		pianXiang = "偏攻击、一列",
		dropChapterId = 0,
		normalattack = 111,
		agility = 68,
		animation = "yanluowang",
		gedang = 0,
		soulCount = 16,
		health = 580,
		soulId = 3030,
		profession = HeroProfession.eCommander,
		quality = QualityType.ePurple,
		groupAttrs = {
			{
				addType = 99,
				name = "鬼王狐魅",
				factor = 0.1,
				heroList = {
					301
				}
			},
			{
				addType = 99,
				name = "宫门镇鬼",
				factor = 0.1,
				heroList = {
					305
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 50,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{20%}",
					"1级中阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+115}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 75,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【鬼铠】提升至1级：",
					"当前生命值大于攻击方生命值时，敌方造成的普通伤害减少{20%}。",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+149}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 100,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【百鬼行】提升5级：",
					"百鬼行对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+155}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 3030,
				mateCount = 125,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+161}"
					},
					attrDescList2 = {
						"韧性{+59}",
						"破击{+30}",
						"格挡{+58}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 3030,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{40%}",
					"2级中阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+125}",
						"基础战力值{+167}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 3030,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【鬼铠】提升至2级：",
					"当前生命值大于攻击方生命值时，敌方造成的普通伤害减少{30%}。",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+172}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 3030,
				mateCount = 240,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【百鬼行】提升5级：",
					"百鬼行对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+155}",
						"基础战力值{+178}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 3030,
				mateCount = 280,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+175}",
						"基础战力值{+184}"
					},
					attrDescList2 = {
						"闪避{+52}",
						"韧性{+78}",
						"破击{+26}",
						"格挡{+101}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 3030,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{60%}",
					"3级中阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+195}",
						"基础战力值{+190}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 3030,
				mateCount = 400,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【鬼铠】提升至3级：",
					"当前生命值大于攻击方生命值时，敌方造成的普通伤害减少{40%}。",
					attrDescList1 = {
						"潜力点{+210}",
						"基础战力值{+196}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 3030,
				mateCount = 460,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【百鬼行】提升5级：",
					"百鬼行对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+225}",
						"基础战力值{+201}"
					}
				}
			},
			{
				soulCount = 46,
				soulId = 3030,
				mateCount = 520,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+207}"
					},
					attrDescList2 = {
						"命中{+16}",
						"暴击{+17}",
						"韧性{+150}",
						"格挡{+144}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 3030,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+150}",
					"@怒气法术【百鬼行】提升1级：",
					"百鬼行对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 80,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 49,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 9,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 138,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 113,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 183,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[304] = {
		mana = 185,
		name = "九尾狐狸精",
		talentId = 10060,
		baoji = 0,
		renxing = 0,
		normaldefense = 42,
		desc = "俗话说，九尾狐出，乃世间将有大乱之象。想想也是，各个都漂亮的祸国殃民，惊天动地的，想不乱也不是一件简单的事。",
		skillattack = 303,
		mingzhong = 0,
		physical = 76,
		skillId = 38,
		poji = 0,
		headerImage = "small_jiuweihulijing.png",
		skilldefense = 84,
		strength = 164,
		shanbi = 0,
		rating = 5,
		pianXiang = "偏治疗、奶三人",
		dropChapterId = 0,
		normalattack = 120,
		agility = 85,
		animation = "jiuweihulijin",
		gedang = 0,
		soulCount = 16,
		health = 456,
		soulId = 3040,
		profession = HeroProfession.eMage,
		quality = QualityType.ePurple,
		groupAttrs = {
			{
				addType = 99,
				name = "义结金兰",
				factor = 0.1,
				heroList = {
					306
				}
			},
			{
				addType = 99,
				name = "捉放九尾",
				factor = 0.1,
				heroList = {
					302
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 50,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{20%}",
					"1级中阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+115}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 75,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【迷魅】提升至1级：",
					"发动技能攻击时，有{50%}的概率降低敌方怒气值{80}点。",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+149}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 100,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【多情诀】提升5级：",
					"多情诀可回复目标生命值提升{5%}",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+155}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 3040,
				mateCount = 125,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+161}"
					},
					attrDescList2 = {
						"命中{+28}",
						"暴击{+73}",
						"破击{+43}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 3040,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{40%}",
					"2级中阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+125}",
						"基础战力值{+167}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 3040,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【迷魅】提升至2级：",
					"发动技能攻击时，有{80%}的概率降低敌方怒气值{80}点。",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+172}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 3040,
				mateCount = 240,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【多情诀】提升5级：",
					"多情诀可回复目标生命值提升{5%}",
					attrDescList1 = {
						"潜力点{+155}",
						"基础战力值{+178}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 3040,
				mateCount = 280,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+175}",
						"基础战力值{+184}"
					},
					attrDescList2 = {
						"命中{+102}",
						"闪避{+78}",
						"暴击{+25}",
						"破击{+50}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 3040,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{60%}",
					"3级中阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+195}",
						"基础战力值{+190}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 3040,
				mateCount = 400,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【迷魅】提升至3级：",
					"发动技能攻击时，有{100%}的概率降低敌方怒气值{80}点。",
					attrDescList1 = {
						"潜力点{+210}",
						"基础战力值{+196}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 3040,
				mateCount = 460,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【多情诀】提升5级：",
					"多情诀可回复目标生命值提升{5%}",
					attrDescList1 = {
						"潜力点{+225}",
						"基础战力值{+201}"
					}
				}
			},
			{
				soulCount = 46,
				soulId = 3040,
				mateCount = 520,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+207}"
					},
					attrDescList2 = {
						"命中{+115}",
						"暴击{+149}",
						"韧性{+16}",
						"破击{+48}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 3040,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+150}",
					"@怒气法术【多情诀】提升1级：",
					"多情诀可回复目标生命值提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 77,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 53,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 15,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 135,
				attrValue = 10,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 114,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 184,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[305] = {
		mana = 183,
		name = "昴日星官",
		talentId = 10023,
		baoji = 0,
		renxing = 0,
		normaldefense = 42,
		desc = "毗蓝婆菩萨的儿子，本相是大公鸡，嗓门巨好，自身实力也非常出众。唐僧被蝎子精困住时，两嗓子便吼毙妖怪，堪称西游好声音…",
		skillattack = 300,
		mingzhong = 0,
		physical = 73,
		skillId = 17,
		poji = 0,
		headerImage = "small_maorixingguan.png",
		skilldefense = 83,
		strength = 163,
		shanbi = 0,
		rating = 5,
		pianXiang = "偏法攻、后排",
		dropChapterId = 10049,
		normalattack = 119,
		agility = 81,
		animation = "maorixingguan",
		gedang = 0,
		soulCount = 15,
		health = 439,
		soulId = 3050,
		profession = HeroProfession.eMage,
		quality = QualityType.ePurple,
		groupAttrs = {
			{
				addType = 99,
				name = "夜观天象",
				factor = 0.1,
				heroList = {
					307
				}
			},
			{
				addType = 99,
				name = "宫门镇鬼",
				factor = 0.1,
				heroList = {
					303
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 50,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{20%}",
					"1级中阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+115}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 75,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【白炎】提升至1级：",
					"攻击时增加的怒气数量提升{15}点。",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+149}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 100,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【九阳诀】提升5级：",
					"九阳诀对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+155}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 3050,
				mateCount = 125,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+161}"
					},
					attrDescList2 = {
						"命中{+28}",
						"暴击{+74}",
						"破击{+43}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 3050,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{40%}",
					"2级中阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+125}",
						"基础战力值{+167}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 3050,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【白炎】提升至2级：",
					"攻击时增加的怒气数量提升{20}点。",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+172}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 3050,
				mateCount = 240,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【九阳诀】提升5级：",
					"九阳诀对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+155}",
						"基础战力值{+178}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 3050,
				mateCount = 280,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+175}",
						"基础战力值{+184}"
					},
					attrDescList2 = {
						"命中{+103}",
						"闪避{+80}",
						"暴击{+27}",
						"破击{+51}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 3050,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{60%}",
					"3级中阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+195}",
						"基础战力值{+190}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 3050,
				mateCount = 400,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【白炎】提升至3级：",
					"攻击时增加的怒气数量提升{25}点。",
					attrDescList1 = {
						"潜力点{+210}",
						"基础战力值{+196}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 3050,
				mateCount = 460,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【九阳诀】提升5级：",
					"九阳诀对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+225}",
						"基础战力值{+201}"
					}
				}
			},
			{
				soulCount = 46,
				soulId = 3050,
				mateCount = 520,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+207}"
					},
					attrDescList2 = {
						"命中{+111}",
						"暴击{+143}",
						"韧性{+16}",
						"破击{+47}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 3050,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+150}",
					"@怒气法术【九阳诀】提升1级：",
					"九阳诀对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 78,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 52,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 16,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 140,
				attrValue = 10,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 107,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 185,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[306] = {
		mana = 188,
		name = "紫霞仙子",
		talentId = 10020,
		baoji = 0,
		renxing = 0,
		normaldefense = 43,
		desc = "紫霞仙子原是如来佛祖的灯芯，为了寻找自己的爱情不顾一切私下凡间，当紫青宝剑被拔出鞘的那刻起就注定了她悲剧的一生！",
		skillattack = 308,
		mingzhong = 0,
		physical = 69,
		skillId = 20,
		poji = 0,
		headerImage = "small_change.png",
		skilldefense = 85,
		strength = 167,
		shanbi = 0,
		rating = 6,
		pianXiang = "偏法攻、随机",
		dropChapterId = 10059,
		normalattack = 122,
		agility = 84,
		animation = "changer",
		gedang = 0,
		soulCount = 20,
		health = 413,
		soulId = 3060,
		profession = HeroProfession.eMage,
		quality = QualityType.ePurple,
		groupAttrs = {
			{
				addType = 99,
				name = "义结金兰",
				factor = 0.1,
				heroList = {
					304
				}
			},
			{
				addType = 99,
				name = "占卜之术",
				factor = 0.1,
				heroList = {
					307
				}
			},
			{
				addType = 99,
				name = "人妖仙魔",
				factor = 0.15,
				heroList = {
					110,
					105
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 50,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{20%}",
					"1级中阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+115}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 75,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【映月】提升至1级：",
					"当被攻击死亡时，攻击方也会受到{30%}法术伤害，此伤害无法被防御。",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+149}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 100,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【寒月诀】提升5级：",
					"寒月诀对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+155}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 3060,
				mateCount = 125,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+161}"
					},
					attrDescList2 = {
						"命中{+28}",
						"暴击{+75}",
						"破击{+43}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 3060,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{40%}",
					"2级中阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+125}",
						"基础战力值{+167}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 3060,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【映月】提升至2级：",
					"当被攻击死亡时，攻击方也会受到{40%}法术伤害，此伤害无法被防御。",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+172}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 3060,
				mateCount = 240,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【寒月诀】提升5级：",
					"寒月诀对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+155}",
						"基础战力值{+178}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 3060,
				mateCount = 280,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+175}",
						"基础战力值{+184}"
					},
					attrDescList2 = {
						"命中{+104}",
						"闪避{+78}",
						"暴击{+26}",
						"破击{+52}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 3060,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{60%}",
					"3级中阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+195}",
						"基础战力值{+190}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 3060,
				mateCount = 400,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【映月】提升至3级：",
					"当被攻击死亡时，攻击方也会受到{50%}法术伤害，此伤害无法被防御。",
					attrDescList1 = {
						"潜力点{+210}",
						"基础战力值{+196}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 3060,
				mateCount = 460,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【寒月诀】提升5级：",
					"寒月诀对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+225}",
						"基础战力值{+201}"
					}
				}
			},
			{
				soulCount = 46,
				soulId = 3060,
				mateCount = 520,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+207}"
					},
					attrDescList2 = {
						"命中{+113}",
						"暴击{+144}",
						"韧性{+16}",
						"破击{+49}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 3060,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+150}",
					"@怒气法术【寒月诀】提升1级：",
					"寒月诀对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 83,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 54,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 7,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 140,
				attrValue = 10,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 110,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 186,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[307] = {
		mana = 169,
		name = "袁守诚",
		talentId = 10019,
		baoji = 0,
		renxing = 0,
		normaldefense = 37,
		desc = "四大天师袁天罡的叔叔，相貌稀奇，仪容秀丽。是个晓天文、知地理的神术士，曾和公职人员泾河龙王打赌，终致龙性命不保。",
		skillattack = 259,
		mingzhong = 0,
		physical = 78,
		skillId = 18,
		poji = 0,
		headerImage = "small_yuanshoucheng.png",
		skilldefense = 83,
		strength = 153,
		shanbi = 0,
		rating = 5,
		pianXiang = "偏治疗、单奶",
		dropChapterId = 0,
		normalattack = 118,
		agility = 81,
		animation = "yuanshoucheng",
		gedang = 0,
		soulCount = 15,
		health = 466,
		soulId = 3070,
		profession = HeroProfession.eMage,
		quality = QualityType.ePurple,
		groupAttrs = {
			{
				addType = 99,
				name = "占卜之术",
				factor = 0.1,
				heroList = {
					306
				}
			},
			{
				addType = 99,
				name = "夜观天象",
				factor = 0.1,
				heroList = {
					305
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 50,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{20%}",
					"1级中阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+115}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 75,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【掐算】提升至1级：",
					"{100%}免疫前两次攻击。",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+149}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 100,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【天机诀】提升5级：",
					"天机诀可回复目标生命值提升5%，并提升防御力加成值5%",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+155}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 3070,
				mateCount = 125,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+161}"
					},
					attrDescList2 = {
						"命中{+29}",
						"暴击{+42}",
						"破击{+73}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 3070,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{40%}",
					"2级中阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+125}",
						"基础战力值{+167}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 3070,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【掐算】提升至2级：",
					"{100%}免疫前两次攻击，{80%}概率免疫第三次针对自己的技能攻击。",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+172}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 3070,
				mateCount = 240,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【天机诀】提升5级：",
					"天机诀可回复目标生命值提升5%，并提升防御力加成值5%",
					attrDescList1 = {
						"潜力点{+155}",
						"基础战力值{+178}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 3070,
				mateCount = 280,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+175}",
						"基础战力值{+184}"
					},
					attrDescList2 = {
						"命中{+81}",
						"闪避{+25}",
						"暴击{+51}",
						"破击{+101}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 3070,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{60%}",
					"3级中阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+195}",
						"基础战力值{+190}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 3070,
				mateCount = 400,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【掐算】提升至3级：",
					"{100%}免疫前两次攻击，{80%}概率免疫第三次针对自己的技能攻击，{50%}概率免疫第四次针对自己的技能攻击。",
					attrDescList1 = {
						"潜力点{+210}",
						"基础战力值{+196}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 3070,
				mateCount = 460,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【天机诀】提升5级：",
					"天机诀可回复目标生命值提升5%，并提升防御力加成值5%",
					attrDescList1 = {
						"潜力点{+225}",
						"基础战力值{+201}"
					}
				}
			},
			{
				soulCount = 46,
				soulId = 3070,
				mateCount = 520,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+207}"
					},
					attrDescList2 = {
						"命中{+46}",
						"暴击{+66}",
						"韧性{+63}",
						"破击{+144}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 3070,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+150}",
					"@怒气法术【天机诀】提升1级：",
					"天机诀可回复目标生命值提升1%，并提升防御力加成值1%"
				}
			}
		},
		groupEquips = {
			{
				equipId = 82,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 48,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 16,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 137,
				attrValue = 15,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 109,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 187,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[308] = {
		mana = 154,
		name = "巨灵神",
		talentId = 10041,
		baoji = 0,
		renxing = 0,
		normaldefense = 40,
		desc = "托塔天王手下的一员猛将，南天门万年不变的守门神。使用的兵器是件宣花板斧，舞动起沉重的宣花板斧，就象凤凰穿花，灵巧无比。",
		skillattack = 238,
		mingzhong = 0,
		physical = 83,
		skillId = 39,
		poji = 0,
		headerImage = "small_julingshen.png",
		skilldefense = 75,
		strength = 171,
		shanbi = 0,
		rating = 5,
		pianXiang = "偏物攻、后排",
		dropChapterId = 0,
		normalattack = 138,
		agility = 92,
		animation = "julingsheng",
		gedang = 0,
		soulCount = 17,
		health = 500,
		soulId = 3080,
		profession = HeroProfession.eWarrior,
		quality = QualityType.ePurple,
		groupAttrs = {
			{
				addType = 99,
				name = "雷霆万钧",
				factor = 0.1,
				heroList = {
					310
				}
			},
			{
				addType = 99,
				name = "九头之语",
				factor = 0.1,
				heroList = {
					309
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 50,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{20%}",
					"1级中阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+115}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 75,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【威压】提升至1级：",
					"发动普通攻击时，有{50%}的概率降低敌方{25}点怒气值。",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+149}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 100,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【震地一击】提升5级：",
					"震地一击对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+155}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 3080,
				mateCount = 125,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+161}"
					},
					attrDescList2 = {
						"命中{+74}",
						"暴击{+44}",
						"破击{+30}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 3080,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{40%}",
					"2级中阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+125}",
						"基础战力值{+167}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 3080,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【威压】提升至2级：",
					"发动普通攻击时，有{80%}的概率降低敌方{45}点怒气值。",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+172}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 3080,
				mateCount = 240,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【震地一击】提升5级：",
					"震地一击对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+155}",
						"基础战力值{+178}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 3080,
				mateCount = 280,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+175}",
						"基础战力值{+184}"
					},
					attrDescList2 = {
						"命中{+77}",
						"暴击{+25}",
						"破击{+107}",
						"格挡{+53}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 3080,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{60%}",
					"3级中阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+195}",
						"基础战力值{+190}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 3080,
				mateCount = 400,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【威压】提升至3级：",
					"发动普通攻击时，有{100%}的概率降低敌方{55}点怒气值。",
					attrDescList1 = {
						"潜力点{+210}",
						"基础战力值{+196}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 3080,
				mateCount = 460,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【震地一击】提升5级：",
					"震地一击对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+225}",
						"基础战力值{+201}"
					}
				}
			},
			{
				soulCount = 46,
				soulId = 3080,
				mateCount = 520,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+207}"
					},
					attrDescList2 = {
						"命中{+132}",
						"闪避{+31}",
						"韧性{+32}",
						"破击{+124}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 3080,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+150}",
					"@怒气法术【震地一击】提升1级：",
					"震地一击对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 80,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 50,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 15,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 136,
				attrValue = 15,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 109,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 188,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[309] = {
		mana = 160,
		name = "九头虫",
		talentId = 10018,
		baoji = 0,
		renxing = 0,
		normaldefense = 41,
		desc = "万圣老龙王的女婿，结婚前没摸清底细等当了驸马才知万圣龙王没钱，不得已跟新婚媳妇一起干上盗宝的勾当，一路偷到了凌霄殿。",
		skillattack = 247,
		mingzhong = 0,
		physical = 80,
		skillId = 15,
		poji = 0,
		headerImage = "small_jiutouchong.png",
		skilldefense = 78,
		strength = 178,
		shanbi = 0,
		rating = 5,
		pianXiang = "偏物攻、斩杀",
		dropChapterId = 0,
		normalattack = 143,
		agility = 92,
		animation = "jiutouchong",
		gedang = 0,
		soulCount = 15,
		health = 482,
		soulId = 3090,
		profession = HeroProfession.eWarrior,
		quality = QualityType.ePurple,
		groupAttrs = {
			{
				addType = 99,
				name = "九头之语",
				factor = 0.1,
				heroList = {
					308
				}
			},
			{
				addType = 99,
				name = "九雷之霆",
				factor = 0.1,
				heroList = {
					310
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 50,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{20%}",
					"1级中阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+115}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 75,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【补击】提升至1级：",
					"普通攻击时敌方如果闪避，可再发动一次攻击，如第二次攻击被闪避不能再次生效。",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+149}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 100,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【九头断魄】提升5级：",
					"九头断魄对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+155}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 3090,
				mateCount = 125,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+161}"
					},
					attrDescList2 = {
						"命中{+76}",
						"暴击{+42}",
						"破击{+29}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 3090,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{40%}",
					"2级中阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+125}",
						"基础战力值{+167}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 3090,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【补击】提升至2级：",
					"普通攻击时敌方如果闪避，可再发动一次攻击，攻击力提升{20%}，如第二次攻击被闪避不能再次生效。",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+172}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 3090,
				mateCount = 240,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【九头断魄】提升5级：",
					"九头断魄对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+155}",
						"基础战力值{+178}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 3090,
				mateCount = 280,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+175}",
						"基础战力值{+184}"
					},
					attrDescList2 = {
						"命中{+75}",
						"暴击{+27}",
						"破击{+99}",
						"格挡{+52}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 3090,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{60%}",
					"3级中阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+195}",
						"基础战力值{+190}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 3090,
				mateCount = 400,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【补击】提升至3级：",
					"普通攻击时敌方如果闪避，可再发动一次攻击，攻击力提升{40%}，如第二次攻击被闪避不能再次生效。",
					attrDescList1 = {
						"潜力点{+210}",
						"基础战力值{+196}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 3090,
				mateCount = 460,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【九头断魄】提升5级：",
					"九头断魄对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+225}",
						"基础战力值{+201}"
					}
				}
			},
			{
				soulCount = 46,
				soulId = 3090,
				mateCount = 520,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+207}"
					},
					attrDescList2 = {
						"命中{+126}",
						"闪避{+31}",
						"韧性{+32}",
						"破击{+133}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 3090,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+150}",
					"@怒气法术【九头断魄】提升1级：",
					"九头断魄对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 84,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 47,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 14,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 138,
				attrValue = 15,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 121,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 189,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[310] = {
		mana = 150,
		name = "雷震子",
		talentId = 10040,
		baoji = 0,
		renxing = 0,
		normaldefense = 42,
		desc = "哪吒的小伙伴,一副雷公嘴不说，还有一对奇怪的翅膀。虽然长相虽然不过关,不过实力强悍，在封神大战中屡建奇功。",
		skillattack = 237,
		mingzhong = 0,
		physical = 83,
		skillId = 37,
		poji = 0,
		headerImage = "small_leizhenzi.png",
		skilldefense = 71,
		strength = 183,
		shanbi = 0,
		rating = 5,
		pianXiang = "偏物攻、前排",
		dropChapterId = 0,
		normalattack = 150,
		agility = 90,
		animation = "leizhenzi",
		gedang = 0,
		soulCount = 17,
		health = 500,
		soulId = 3100,
		profession = HeroProfession.eWarrior,
		quality = QualityType.ePurple,
		groupAttrs = {
			{
				addType = 99,
				name = "九雷之霆",
				factor = 0.1,
				heroList = {
					309
				}
			},
			{
				addType = 99,
				name = "雷霆万钧",
				factor = 0.1,
				heroList = {
					308
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 50,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{20%}",
					"1级中阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+115}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 75,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【天怒】提升至1级：",
					"普通攻击时，如当前怒气值大于攻击目标当前怒气值，造成的伤害提高{30%}。",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+149}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 100,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【天罚神雷】提升5级：",
					"天罚神雷对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+155}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 3100,
				mateCount = 125,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+161}"
					},
					attrDescList2 = {
						"命中{+29}",
						"暴击{+73}",
						"破击{+43}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 3100,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{40%}",
					"2级中阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+125}",
						"基础战力值{+167}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 3100,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【天怒】提升至2级：",
					"普通攻击时，如当前怒气值大于攻击目标当前怒气值，造成的伤害提高{40%}。",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+172}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 3100,
				mateCount = 240,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【天罚神雷】提升5级：",
					"天罚神雷对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+155}",
						"基础战力值{+178}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 3100,
				mateCount = 280,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+175}",
						"基础战力值{+184}"
					},
					attrDescList2 = {
						"命中{+104}",
						"闪避{+53}",
						"暴击{+74}",
						"破击{+26}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 3100,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{60%}",
					"3级中阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+195}",
						"基础战力值{+190}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 3100,
				mateCount = 400,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【天怒】提升至3级：",
					"普通攻击时，如当前怒气值大于攻击目标当前怒气值，造成的伤害提高{50%}。",
					attrDescList1 = {
						"潜力点{+210}",
						"基础战力值{+196}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 3100,
				mateCount = 460,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【天罚神雷】提升5级：",
					"天罚神雷对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+225}",
						"基础战力值{+201}"
					}
				}
			},
			{
				soulCount = 46,
				soulId = 3100,
				mateCount = 520,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+207}"
					},
					attrDescList2 = {
						"命中{+80}",
						"暴击{+134}",
						"韧性{+31}",
						"破击{+82}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 3100,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+150}",
					"@怒气法术【天罚神雷】提升1级：",
					"天罚神雷对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 89,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 49,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 7,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 137,
				attrValue = 15,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 113,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 190,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[311] = {
		mana = 147,
		name = "金刚战神",
		talentId = 10016,
		baoji = 0,
		renxing = 0,
		normaldefense = 41,
		desc = "听名字就知道是专门为战斗而生的绝对主角，百战百胜，杀敌破阵所向披靡。可惜长相过于粗犷豪迈，导致一直没有娶到老婆。",
		skillattack = 233,
		mingzhong = 0,
		physical = 77,
		skillId = 16,
		poji = 0,
		headerImage = "small_jingangzhanshen.png",
		skilldefense = 69,
		strength = 180,
		shanbi = 0,
		rating = 5,
		pianXiang = "偏物攻、降怒",
		dropChapterId = 0,
		normalattack = 147,
		agility = 91,
		animation = "jingangzhanshen",
		gedang = 0,
		soulCount = 15,
		health = 463,
		soulId = 3110,
		profession = HeroProfession.eWarrior,
		quality = QualityType.ePurple,
		groupAttrs = {
			{
				addType = 99,
				name = "如有神助",
				factor = 0.1,
				heroList = {
					201
				}
			},
			{
				addType = 99,
				name = "万夫莫敌",
				factor = 0.1,
				heroList = {
					310
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 50,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{20%}",
					"1级中阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+115}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 75,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【怒目】提升至1级：",
					"被攻击时增加的怒气数量提升{5}点。",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+149}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 100,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【红莲业火】提升5级：",
					"红莲业火对敌方造成的法术伤害提升{5%}，并提升减少的怒气值{5}点",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+155}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 3110,
				mateCount = 125,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+161}"
					},
					attrDescList2 = {
						"命中{+29}",
						"暴击{+71}",
						"破击{+44}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 3110,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{40%}",
					"2级中阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+125}",
						"基础战力值{+167}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 3110,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【怒目】提升至2级：",
					"被攻击时增加的怒气数量提升{10}点。",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+172}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 3110,
				mateCount = 240,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【红莲业火】提升5级：",
					"红莲业火对敌方造成的法术伤害提升{5%}，并提升减少的怒气值{5}点",
					attrDescList1 = {
						"潜力点{+155}",
						"基础战力值{+178}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 3110,
				mateCount = 280,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+175}",
						"基础战力值{+184}"
					},
					attrDescList2 = {
						"命中{+103}",
						"闪避{+54}",
						"暴击{+75}",
						"破击{+26}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 3110,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{60%}",
					"3级中阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+195}",
						"基础战力值{+190}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 3110,
				mateCount = 400,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【怒目】提升至3级：",
					"被攻击时增加的怒气数量提升{15}点。",
					attrDescList1 = {
						"潜力点{+210}",
						"基础战力值{+196}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 3110,
				mateCount = 460,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【红莲业火】提升5级：",
					"红莲业火对敌方造成的法术伤害提升{5%}，并提升减少的怒气值{5}点",
					attrDescList1 = {
						"潜力点{+225}",
						"基础战力值{+201}"
					}
				}
			},
			{
				soulCount = 46,
				soulId = 3110,
				mateCount = 520,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+207}"
					},
					attrDescList2 = {
						"命中{+81}",
						"暴击{+130}",
						"韧性{+31}",
						"破击{+80}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 3110,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+150}",
					"@怒气法术【红莲业火】提升1级：",
					"红莲业火对敌方造成的法术伤害提升{1%}，并提升减少的怒气值{1}点"
				}
			}
		},
		groupEquips = {
			{
				equipId = 91,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 57,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 9,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 139,
				attrValue = 15,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 112,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 191,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[201] = {
		mana = 155,
		name = "唐太宗",
		talentId = 10025,
		baoji = 0,
		renxing = 0,
		normaldefense = 40,
		desc = "唐王朝最高领导人，气质儒雅相貌英俊，非常重视文化教育产业，为弘扬佛法，派三藏法师去西天取经，是三藏法师在人界的强力后盾。",
		skillattack = 226,
		mingzhong = 0,
		physical = 101,
		skillId = 23,
		poji = 0,
		headerImage = "small_tangtaizong.png",
		skilldefense = 79,
		strength = 155,
		shanbi = 0,
		rating = 6,
		pianXiang = "偏防御、加怒",
		dropChapterId = 0,
		normalattack = 113,
		agility = 77,
		animation = "tangminghuang",
		gedang = 0,
		soulCount = 17,
		health = 603,
		soulId = 2010,
		profession = HeroProfession.eCommander,
		quality = QualityType.ePurple,
		groupAttrs = {
			{
				addType = 99,
				name = "君臣有序",
				factor = 0.1,
				heroList = {
					202
				}
			},
			{
				addType = 99,
				name = "如有神助",
				factor = 0.1,
				heroList = {
					311
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 50,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{20%}",
					"1级中阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+115}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 75,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【驾崩】提升至1级：",
					"当被攻击死亡后，我方随机两个武将怒气全满。",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+149}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 100,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【天子怒】提升5级：",
					"天子怒可将目标怒气值增加点数提升{5}点",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+155}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 2010,
				mateCount = 125,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+161}"
					},
					attrDescList2 = {
						"命中{+30}",
						"韧性{+42}",
						"格挡{+71}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2010,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{40%}",
					"2级中阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+125}",
						"基础战力值{+167}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 2010,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【驾崩】提升至2级：",
					"当被攻击死亡后，我方随机两个武将怒气全满且在1回合内提升{30}%攻击力。",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+172}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 2010,
				mateCount = 240,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【天子怒】提升5级：",
					"天子怒可将目标怒气值增加点数提升{5}点",
					attrDescList1 = {
						"潜力点{+155}",
						"基础战力值{+178}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 2010,
				mateCount = 280,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+175}",
						"基础战力值{+184}"
					},
					attrDescList2 = {
						"闪避{+75}",
						"韧性{+105}",
						"破击{+25}",
						"格挡{+54}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 2010,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{60%}",
					"3级中阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+195}",
						"基础战力值{+190}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 2010,
				mateCount = 400,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【驾崩】提升至3级：",
					"当被攻击死亡后，我方随机两个武将怒气全满且在1回合内提升{50}%攻击力。",
					attrDescList1 = {
						"潜力点{+210}",
						"基础战力值{+196}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 2010,
				mateCount = 460,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【天子怒】提升5级：",
					"天子怒可将目标怒气值增加点数提升{5}点",
					attrDescList1 = {
						"潜力点{+225}",
						"基础战力值{+201}"
					}
				}
			},
			{
				soulCount = 46,
				soulId = 2010,
				mateCount = 520,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+207}"
					},
					attrDescList2 = {
						"命中{+46}",
						"暴击{+17}",
						"韧性{+146}",
						"格挡{+110}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2010,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+150}",
					"@怒气法术【天子怒】提升1级：",
					"天子怒可将目标怒气值增加点数提升{1}点"
				}
			}
		},
		groupEquips = {
			{
				equipId = 85,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 52,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 17,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 147,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 118,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 169,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[202] = {
		mana = 160,
		name = "闻太师",
		talentId = 10011,
		baoji = 0,
		renxing = 0,
		normaldefense = 43,
		desc = "文武双全，擅长行军，是商朝军队最重要的人物之一。可惜站错队，耽误了前程，出来混，能打是次要的，关键要跟对人。",
		skillattack = 222,
		mingzhong = 0,
		physical = 91,
		skillId = 40,
		poji = 0,
		headerImage = "small_wentaishi.png",
		skilldefense = 86,
		strength = 160,
		shanbi = 0,
		rating = 6,
		pianXiang = "偏防御、加防",
		dropChapterId = 0,
		normalattack = 111,
		agility = 70,
		animation = "wentaishi",
		gedang = 0,
		soulCount = 18,
		health = 543,
		soulId = 2020,
		profession = HeroProfession.eCommander,
		quality = QualityType.ePurple,
		groupAttrs = {
			{
				addType = 99,
				name = "君臣有序",
				factor = 0.1,
				heroList = {
					201
				}
			},
			{
				addType = 99,
				name = "泰山北斗",
				factor = 0.1,
				heroList = {
					203
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 50,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{20%}",
					"1级中阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+115}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 75,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【化生】提升至1级：",
					"每次被攻击后，{10%}概率回复生命值。",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+149}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 100,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【千军驭】提升5级：",
					"提升{5%}防御效果，并提升{5%}的韧性加成概率及加成值",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+155}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 2020,
				mateCount = 125,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+161}"
					},
					attrDescList2 = {
						"韧性{+56}",
						"破击{+28}",
						"格挡{+57}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2020,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{40%}",
					"2级中阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+125}",
						"基础战力值{+167}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 2020,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【化生】提升至2级：",
					"每次被攻击后，{20%}概率回复生命值。",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+172}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 2020,
				mateCount = 240,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【千军驭】提升5级：",
					"提升{5%}防御效果，并提升{5%}的韧性加成概率及加成值",
					attrDescList1 = {
						"潜力点{+155}",
						"基础战力值{+178}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 2020,
				mateCount = 280,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+175}",
						"基础战力值{+184}"
					},
					attrDescList2 = {
						"闪避{+53}",
						"韧性{+76}",
						"破击{+27}",
						"格挡{+100}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 2020,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{60%}",
					"3级中阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+195}",
						"基础战力值{+190}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 2020,
				mateCount = 400,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【化生】提升至3级：",
					"每次被攻击后，{30%}概率回复生命值。",
					attrDescList1 = {
						"潜力点{+210}",
						"基础战力值{+196}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 2020,
				mateCount = 460,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【千军驭】提升5级：",
					"提升{5%}防御效果，并提升{5%}的韧性加成概率及加成值",
					attrDescList1 = {
						"潜力点{+225}",
						"基础战力值{+201}"
					}
				}
			},
			{
				soulCount = 46,
				soulId = 2020,
				mateCount = 520,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+207}"
					},
					attrDescList2 = {
						"命中{+15}",
						"暴击{+15}",
						"韧性{+145}",
						"格挡{+148}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2020,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+150}",
					"@怒气法术【千军驭】提升1级：",
					"提升{1%}防御效果，并提升{1%}的韧性加成概率及加成值"
				}
			}
		},
		groupEquips = {
			{
				equipId = 86,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 56,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 25,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 151,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 119,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 170,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[203] = {
		mana = 173,
		name = "姜子牙",
		talentId = 10026,
		baoji = 0,
		renxing = 0,
		normaldefense = 46,
		desc = "钓鱼钓出来个最高军事统帅，诸家学者皆追他为本家人物，被尊为“百家宗师”。堪称古往今来最成功的钓鱼老大爷。",
		skillattack = 240,
		mingzhong = 0,
		physical = 86,
		skillId = 22,
		poji = 0,
		headerImage = "small_jiangziya.png",
		skilldefense = 93,
		strength = 173,
		shanbi = 0,
		rating = 6,
		pianXiang = "偏攻击、前排降怒",
		dropChapterId = 0,
		normalattack = 120,
		agility = 65,
		animation = "jiangziya",
		gedang = 0,
		soulCount = 20,
		health = 513,
		soulId = 2030,
		profession = HeroProfession.eCommander,
		quality = QualityType.ePurple,
		groupAttrs = {
			{
				addType = 99,
				name = "泰山北斗",
				factor = 0.1,
				heroList = {
					202
				}
			},
			{
				addType = 99,
				name = "辅车相依",
				factor = 0.1,
				heroList = {
					204
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 50,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{20%}",
					"1级中阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+115}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 75,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【借命】提升至1级：",
					"生命值为0时，获得一次不死的机会，生命值保留1点。",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+149}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 100,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【封神击】提升5级：",
					"法术伤害提升{5%}，并提升减少的怒气值{5}点",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+155}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 2030,
				mateCount = 125,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+161}"
					},
					attrDescList2 = {
						"韧性{+59}",
						"破击{+28}",
						"格挡{+58}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2030,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{40%}",
					"2级中阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+125}",
						"基础战力值{+167}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 2030,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【借命】提升至2级：",
					"生命值为0时，获得一次不死的机会，生命值恢复至上限的一半。",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+172}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 2030,
				mateCount = 240,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【封神击】提升5级：",
					"法术伤害提升{5%}，并提升减少的怒气值{5}点",
					attrDescList1 = {
						"潜力点{+155}",
						"基础战力值{+178}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 2030,
				mateCount = 280,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+175}",
						"基础战力值{+184}"
					},
					attrDescList2 = {
						"闪避{+52}",
						"韧性{+79}",
						"破击{+26}",
						"格挡{+108}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 2030,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{60%}",
					"3级中阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+195}",
						"基础战力值{+190}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 2030,
				mateCount = 400,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【借命】提升至3级：",
					"生命值为0时，获得一次不死的机会，生命值恢复至上限的一半,{50%}概率第二次仍不会死亡，生命值保留1点。",
					attrDescList1 = {
						"潜力点{+210}",
						"基础战力值{+196}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 2030,
				mateCount = 460,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【封神击】提升5级：",
					"法术伤害提升{5%}，并提升减少的怒气值{5}点",
					attrDescList1 = {
						"潜力点{+225}",
						"基础战力值{+201}"
					}
				}
			},
			{
				soulCount = 46,
				soulId = 2030,
				mateCount = 520,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+207}"
					},
					attrDescList2 = {
						"命中{+16}",
						"暴击{+16}",
						"韧性{+141}",
						"格挡{+145}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2030,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+150}",
					"@怒气法术【封神击】提升1级：",
					"法术伤害提升{1%}，并提升减少的怒气值{1}点"
				}
			}
		},
		groupEquips = {
			{
				equipId = 84,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 56,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 17,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 145,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 118,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 171,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[204] = {
		mana = 159,
		name = "牛魔王",
		talentId = 10024,
		baoji = 0,
		renxing = 0,
		normaldefense = 43,
		desc = "与悟空同为大圣，占山为王坐拥丰厚资产，先后两位夫人都是白富美，儿子从小自立为王，和谐一家被拆只因没借东西给取经四人组…",
		skillattack = 221,
		mingzhong = 0,
		physical = 96,
		skillId = 24,
		poji = 0,
		headerImage = "small_niumowang.png",
		skilldefense = 85,
		strength = 158,
		shanbi = 0,
		rating = 6,
		pianXiang = "偏防御、一列降攻",
		dropChapterId = 20029,
		normalattack = 110,
		agility = 64,
		animation = "niumowang",
		gedang = 0,
		soulCount = 20,
		health = 574,
		soulId = 2040,
		profession = HeroProfession.eCommander,
		quality = QualityType.ePurple,
		groupAttrs = {
			{
				addType = 99,
				name = "二圣伏牛",
				factor = 0.15,
				heroList = {
					103,
					104
				}
			},
			{
				addType = 99,
				name = "辅车相依",
				factor = 0.1,
				heroList = {
					203
				}
			},
			{
				addType = 99,
				name = "雷音伪佛",
				factor = 0.1,
				heroList = {
					205
				}
			},
			{
				addType = 99,
				name = "牛不羡仙",
				factor = 0.1,
				heroList = {
					128
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 50,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{20%}",
					"1级中阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+115}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 75,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【厚皮】提升至1级：",
					"当本人生命值不小于上限的{60%}时，防御力提高{30%}。",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+149}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 100,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【牛魔劲】提升5级：",
					"法术伤害提升{5%},并提升降低的攻击力加成{5%}",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+155}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 2040,
				mateCount = 125,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+161}"
					},
					attrDescList2 = {
						"韧性{+59}",
						"破击{+29}",
						"格挡{+60}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2040,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{40%}",
					"2级中阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+125}",
						"基础战力值{+167}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 2040,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【厚皮】提升至2级：",
					"当本人生命值不小于上限的{55%}时，防御力提高{40%}。",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+172}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 2040,
				mateCount = 240,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【牛魔劲】提升5级：",
					"法术伤害提升{5%},并提升降低的攻击力加成{5%}",
					attrDescList1 = {
						"潜力点{+155}",
						"基础战力值{+178}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 2040,
				mateCount = 280,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+175}",
						"基础战力值{+184}"
					},
					attrDescList2 = {
						"闪避{+54}",
						"韧性{+79}",
						"破击{+26}",
						"格挡{+105}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 2040,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{60%}",
					"3级中阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+195}",
						"基础战力值{+190}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 2040,
				mateCount = 400,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【厚皮】提升至3级：",
					"当本人生命值不小于上限的{50%}时，防御力提高{50%}。",
					attrDescList1 = {
						"潜力点{+210}",
						"基础战力值{+196}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 2040,
				mateCount = 460,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【牛魔劲】提升5级：",
					"法术伤害提升{5%},并提升降低的攻击力加成{5%}",
					attrDescList1 = {
						"潜力点{+225}",
						"基础战力值{+201}"
					}
				}
			},
			{
				soulCount = 46,
				soulId = 2040,
				mateCount = 520,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+207}"
					},
					attrDescList2 = {
						"命中{+15}",
						"暴击{+17}",
						"韧性{+149}",
						"格挡{+150}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2040,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+150}",
					"@怒气法术【牛魔劲】提升1级：",
					"法术伤害提升{1%},并提升降低的攻击力加成{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 92,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 59,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 20,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 144,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 120,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 172,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[205] = {
		mana = 159,
		name = "黄眉大王",
		talentId = 10012,
		baoji = 0,
		renxing = 0,
		normaldefense = 41,
		desc = "本来是给弥勒佛敲钟的小职员，却偷了佛祖的宝贝想伪装成总boss，骗术高明道法高深，可惜天网恢恢疏而不漏，被弥勒佛降服。",
		skillattack = 232,
		mingzhong = 0,
		physical = 102,
		skillId = 41,
		poji = 0,
		headerImage = "small_huangmeidawang.png",
		skilldefense = 81,
		strength = 159,
		shanbi = 0,
		rating = 6,
		pianXiang = "偏防御、后排减命中",
		dropChapterId = 20019,
		normalattack = 116,
		agility = 76,
		animation = "huangmeidawang",
		gedang = 0,
		soulCount = 20,
		health = 614,
		soulId = 2050,
		profession = HeroProfession.eCommander,
		quality = QualityType.ePurple,
		groupAttrs = {
			{
				addType = 99,
				name = "雷音伪佛",
				factor = 0.1,
				heroList = {
					204
				}
			},
			{
				addType = 99,
				name = "大鹏作乱",
				factor = 0.1,
				heroList = {
					206
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 50,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{20%}",
					"1级中阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+115}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 75,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【金钹】提升至1级：",
					"{50%}免疫一次群体攻击技能。",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+149}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 100,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【黄沙障】提升5级：",
					"法术伤害提升{5%}，并提升{5%}的命中加成概率及{5%}的加成值",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+155}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 2050,
				mateCount = 125,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+161}"
					},
					attrDescList2 = {
						"命中{+30}",
						"韧性{+44}",
						"格挡{+72}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2050,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{40%}",
					"2级中阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+125}",
						"基础战力值{+167}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 2050,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【金钹】提升至2级：",
					"{60%}免疫第一次群体攻击技能，且有{10%}概率免疫第二次群体攻击技能。",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+172}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 2050,
				mateCount = 240,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【黄沙障】提升5级：",
					"法术伤害提升{5%}，并提升{5%}的命中加成概率及{5%}的加成值",
					attrDescList1 = {
						"潜力点{+155}",
						"基础战力值{+178}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 2050,
				mateCount = 280,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+175}",
						"基础战力值{+184}"
					},
					attrDescList2 = {
						"闪避{+77}",
						"韧性{+105}",
						"破击{+25}",
						"格挡{+51}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 2050,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{60%}",
					"3级中阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+195}",
						"基础战力值{+190}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 2050,
				mateCount = 400,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【金钹】提升至3级：",
					"{70%}免疫第一次群体攻击技能，且有{10%}、{5%}概率免疫第二次、第三次群体攻击技能。",
					attrDescList1 = {
						"潜力点{+210}",
						"基础战力值{+196}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 2050,
				mateCount = 460,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【黄沙障】提升5级：",
					"法术伤害提升{5%}，并提升{5%}的命中加成概率及{5%}的加成值",
					attrDescList1 = {
						"潜力点{+225}",
						"基础战力值{+201}"
					}
				}
			},
			{
				soulCount = 46,
				soulId = 2050,
				mateCount = 520,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+207}"
					},
					attrDescList2 = {
						"命中{+49}",
						"暴击{+15}",
						"韧性{+142}",
						"格挡{+111}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2050,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+150}",
					"@怒气法术【黄沙障】提升1级：",
					"法术伤害提升{1%}，并提升{1%}的命中加成概率及{1%}的加成值"
				}
			}
		},
		groupEquips = {
			{
				equipId = 86,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 60,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 25,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 147,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 116,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 173,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[206] = {
		mana = 162,
		name = "金翅大鹏雕",
		talentId = 10029,
		baoji = 0,
		renxing = 0,
		normaldefense = 41,
		desc = "狮驼城联合创始人兼CEO，与孙悟空实力不相上下，为了唐僧肉得罪了自己的高官侄子如来佛祖，结果反倒当上公务员…",
		skillattack = 249,
		mingzhong = 0,
		physical = 79,
		skillId = 26,
		poji = 0,
		headerImage = "small_jinchidapengdiao.png",
		skilldefense = 79,
		strength = 179,
		shanbi = 0,
		rating = 6,
		pianXiang = "偏攻击、前排降防",
		dropChapterId = 10109,
		normalattack = 144,
		agility = 93,
		animation = "jinchidapengdiao",
		gedang = 0,
		soulCount = 20,
		health = 476,
		soulId = 2060,
		profession = HeroProfession.eWarrior,
		quality = QualityType.ePurple,
		groupAttrs = {
			{
				addType = 99,
				name = "二郎射雕",
				factor = 0.1,
				heroList = {
					207
				}
			},
			{
				addType = 99,
				name = "大鹏作乱",
				factor = 0.1,
				heroList = {
					205
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 50,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{20%}",
					"1级中阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+115}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 75,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【急速】提升至1级：",
					"发动普通攻击后，有{40%}的概率再发动一次普通攻击。",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+149}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 100,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【千羽破甲】提升5级：",
					"法术伤害提升{5%},并提升降低的防御力加成{5%}",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+155}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 2060,
				mateCount = 125,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+161}"
					},
					attrDescList2 = {
						"命中{+71}",
						"暴击{+44}",
						"破击{+28}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2060,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{40%}",
					"2级中阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+125}",
						"基础战力值{+167}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 2060,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【急速】提升至2级：",
					"发动普通攻击后，有{60%}的概率再发动一次普通攻击。",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+172}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 2060,
				mateCount = 240,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【千羽破甲】提升5级：",
					"法术伤害提升{5%},并提升降低的防御力加成{5%}",
					attrDescList1 = {
						"潜力点{+155}",
						"基础战力值{+178}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 2060,
				mateCount = 280,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+175}",
						"基础战力值{+184}"
					},
					attrDescList2 = {
						"命中{+77}",
						"暴击{+26}",
						"破击{+102}",
						"格挡{+50}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 2060,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{60%}",
					"3级中阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+195}",
						"基础战力值{+190}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 2060,
				mateCount = 400,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【急速】提升至3级：",
					"发动普通攻击后，有{80%}的概率再发动一次普通攻击。",
					attrDescList1 = {
						"潜力点{+210}",
						"基础战力值{+196}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 2060,
				mateCount = 460,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【千羽破甲】提升5级：",
					"法术伤害提升{5%},并提升降低的防御力加成{5%}",
					attrDescList1 = {
						"潜力点{+225}",
						"基础战力值{+201}"
					}
				}
			},
			{
				soulCount = 46,
				soulId = 2060,
				mateCount = 520,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+207}"
					},
					attrDescList2 = {
						"命中{+129}",
						"闪避{+32}",
						"韧性{+33}",
						"破击{+133}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2060,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+150}",
					"@怒气法术【千羽破甲】提升1级：",
					"法术伤害提升{1%},并提升降低的防御力加成{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 90,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 55,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 21,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 148,
				attrValue = 15,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 115,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 174,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[207] = {
		mana = 143,
		name = "二郎神",
		talentId = 10043,
		baoji = 0,
		renxing = 0,
		normaldefense = 40,
		desc = "作为玉帝的外甥，本应是个天天享乐的标准富二代，却甘愿下界为民除妖。养有名犬哮天，堪称最尽忠职守的勤劳官二代。",
		skillattack = 227,
		mingzhong = 0,
		physical = 80,
		skillId = 42,
		poji = 0,
		headerImage = "small_erlangshen.png",
		skilldefense = 68,
		strength = 176,
		shanbi = 0,
		rating = 6,
		pianXiang = "偏攻击、百分比攻击",
		dropChapterId = 10089,
		normalattack = 144,
		agility = 88,
		animation = "erlangshen",
		gedang = 0,
		soulCount = 18,
		health = 477,
		soulId = 2070,
		profession = HeroProfession.eWarrior,
		quality = QualityType.ePurple,
		groupAttrs = {
			{
				addType = 99,
				name = "二郎射雕",
				factor = 0.1,
				heroList = {
					206
				}
			},
			{
				addType = 99,
				name = "神猴斗法",
				factor = 0.1,
				heroList = {
					208
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 50,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{20%}",
					"1级中阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+115}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 75,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【束缚】提升至1级：",
					"每次攻击敌方后,可降低敌方{5%}的速度。",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+149}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 100,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【破邪法瞳】提升5级：",
					"破邪法瞳对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+155}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 2070,
				mateCount = 125,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+161}"
					},
					attrDescList2 = {
						"命中{+30}",
						"暴击{+71}",
						"破击{+44}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2070,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{40%}",
					"2级中阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+125}",
						"基础战力值{+167}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 2070,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【束缚】提升至2级：",
					"每次攻击敌方后,可降低敌方{10%}的速度。",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+172}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 2070,
				mateCount = 240,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【破邪法瞳】提升5级：",
					"破邪法瞳对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+155}",
						"基础战力值{+178}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 2070,
				mateCount = 280,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+175}",
						"基础战力值{+184}"
					},
					attrDescList2 = {
						"命中{+105}",
						"闪避{+53}",
						"暴击{+75}",
						"破击{+26}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 2070,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{60%}",
					"3级中阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+195}",
						"基础战力值{+190}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 2070,
				mateCount = 400,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【束缚】提升至3级：",
					"每次攻击敌方后,可降低敌方{15%}的速度。",
					attrDescList1 = {
						"潜力点{+210}",
						"基础战力值{+196}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 2070,
				mateCount = 460,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【破邪法瞳】提升5级：",
					"破邪法瞳对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+225}",
						"基础战力值{+201}"
					}
				}
			},
			{
				soulCount = 46,
				soulId = 2070,
				mateCount = 520,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+207}"
					},
					attrDescList2 = {
						"命中{+78}",
						"暴击{+129}",
						"韧性{+31}",
						"破击{+79}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2070,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+150}",
					"@怒气法术【破邪法瞳】提升1级：",
					"破邪法瞳对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 87,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 58,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 22,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 149,
				attrValue = 15,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 117,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 175,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[208] = {
		mana = 145,
		name = "孙悟空",
		talentId = 10028,
		baoji = 0,
		renxing = 0,
		normaldefense = 40,
		desc = "出身低微，创业于花果山，两上天庭当官，后为了西天取经崇高理想勇于献身，尝尽一路艰辛。这是一个孤儿的奋斗传奇！",
		skillattack = 230,
		mingzhong = 0,
		physical = 74,
		skillId = 25,
		poji = 0,
		headerImage = "small_sunwukong.png",
		skilldefense = 69,
		strength = 177,
		shanbi = 0,
		rating = 6,
		pianXiang = "偏攻击、全体",
		dropChapterId = 10099,
		normalattack = 145,
		agility = 89,
		animation = "sunwukong",
		gedang = 0,
		soulCount = 20,
		health = 445,
		soulId = 2080,
		profession = HeroProfession.eWarrior,
		quality = QualityType.ePurple,
		groupAttrs = {
			{
				addType = 99,
				name = "神猴斗法",
				factor = 0.1,
				heroList = {
					207
				}
			},
			{
				addType = 99,
				name = "定海神针",
				factor = 0.1,
				heroList = {
					209
				}
			},
			{
				addType = 99,
				name = "海神山石",
				factor = 0.15,
				heroList = {
					104,
					110
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 50,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{20%}",
					"1级中阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+115}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 75,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【斗战】提升至1级：",
					"当本人生命值小于上限的{30%}时，攻击力提升{50%}。",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+149}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 100,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【化身无穷】提升5级：",
					"化身无穷对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+155}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 2080,
				mateCount = 125,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+161}"
					},
					attrDescList2 = {
						"命中{+29}",
						"暴击{+70}",
						"破击{+45}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2080,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{40%}",
					"2级中阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+125}",
						"基础战力值{+167}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 2080,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【斗战】提升至2级：",
					"当本人生命值小于上限的{35%}时，攻击力提升{55%}。",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+172}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 2080,
				mateCount = 240,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【化身无穷】提升5级：",
					"化身无穷对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+155}",
						"基础战力值{+178}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 2080,
				mateCount = 280,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+175}",
						"基础战力值{+184}"
					},
					attrDescList2 = {
						"命中{+108}",
						"闪避{+52}",
						"暴击{+76}",
						"破击{+26}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 2080,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{60%}",
					"3级中阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+195}",
						"基础战力值{+190}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 2080,
				mateCount = 400,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【斗战】提升至3级：",
					"当本人生命值小于上限的{40%}时，攻击力提升{60%}。",
					attrDescList1 = {
						"潜力点{+210}",
						"基础战力值{+196}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 2080,
				mateCount = 460,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【化身无穷】提升5级：",
					"化身无穷对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+225}",
						"基础战力值{+201}"
					}
				}
			},
			{
				soulCount = 46,
				soulId = 2080,
				mateCount = 520,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+207}"
					},
					attrDescList2 = {
						"命中{+78}",
						"暴击{+130}",
						"韧性{+31}",
						"破击{+79}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2080,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+150}",
					"@怒气法术【化身无穷】提升1级：",
					"化身无穷对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 87,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 55,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 18,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 146,
				attrValue = 15,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 115,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 176,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[209] = {
		mana = 155,
		name = "东海龙王",
		talentId = 10042,
		baoji = 0,
		renxing = 0,
		normaldefense = 40,
		desc = "四海龙王之首,掌管天下江海湖泊，能呼风唤雨，布云施雨。翻江倒海，上天下地更是不在话下，是个不好惹的主。",
		skillattack = 239,
		mingzhong = 0,
		physical = 84,
		skillId = 45,
		poji = 0,
		headerImage = "small_longshen.png",
		skilldefense = 75,
		strength = 171,
		shanbi = 0,
		rating = 6,
		pianXiang = "偏攻击、后排降攻",
		dropChapterId = 0,
		normalattack = 138,
		agility = 87,
		animation = "longshen",
		gedang = 0,
		soulCount = 20,
		health = 503,
		soulId = 2090,
		profession = HeroProfession.eWarrior,
		quality = QualityType.ePurple,
		groupAttrs = {
			{
				addType = 99,
				name = "定海神针",
				factor = 0.1,
				heroList = {
					208
				}
			},
			{
				addType = 99,
				name = "护身神龙",
				factor = 0.1,
				heroList = {
					210
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 50,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{20%}",
					"1级中阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+115}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 75,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【吞噬】提升至1级：",
					"每杀死一个目标，将直接回复自身生命上限的{30%}。",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+149}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 100,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【翻江倒海】提升5级：",
					"法术伤害提升{5%}，并提升降低概率{5%}及降低的攻击力加成{5%}",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+155}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 2090,
				mateCount = 125,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+161}"
					},
					attrDescList2 = {
						"命中{+71}",
						"暴击{+42}",
						"破击{+29}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2090,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{40%}",
					"2级中阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+125}",
						"基础战力值{+167}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 2090,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【吞噬】提升至2级：",
					"每杀死一个目标，将直接回复自身生命上限的{40%}。",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+172}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 2090,
				mateCount = 240,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【翻江倒海】提升5级：",
					"法术伤害提升{5%}，并提升降低概率{5%}及降低的攻击力加成{5%}",
					attrDescList1 = {
						"潜力点{+155}",
						"基础战力值{+178}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 2090,
				mateCount = 280,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+175}",
						"基础战力值{+184}"
					},
					attrDescList2 = {
						"命中{+80}",
						"暴击{+26}",
						"破击{+108}",
						"格挡{+53}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 2090,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{60%}",
					"3级中阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+195}",
						"基础战力值{+190}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 2090,
				mateCount = 400,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【吞噬】提升至3级：",
					"每杀死一个目标，将直接回复自身生命上限的{50%}。",
					attrDescList1 = {
						"潜力点{+210}",
						"基础战力值{+196}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 2090,
				mateCount = 460,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【翻江倒海】提升5级：",
					"法术伤害提升{5%}，并提升降低概率{5%}及降低的攻击力加成{5%}",
					attrDescList1 = {
						"潜力点{+225}",
						"基础战力值{+201}"
					}
				}
			},
			{
				soulCount = 46,
				soulId = 2090,
				mateCount = 520,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+207}"
					},
					attrDescList2 = {
						"命中{+126}",
						"闪避{+32}",
						"韧性{+32}",
						"破击{+127}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2090,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+150}",
					"@怒气法术【翻江倒海】提升1级：",
					"法术伤害提升{1%}，并提升降低概率{1%}及降低的攻击力加成{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 88,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 61,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 24,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 144,
				attrValue = 15,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 121,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 177,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[210] = {
		mana = 196,
		name = "王母娘娘",
		talentId = 10030,
		baoji = 0,
		renxing = 0,
		normaldefense = 44,
		desc = "在天界地位崇高，与东华帝君一起管理天界众多仙人。也是天庭妇女委员会主任，监管民政和计划生育工作。是玉帝的绯闻女友。",
		skillattack = 320,
		mingzhong = 0,
		physical = 74,
		skillId = 28,
		poji = 0,
		headerImage = "small_wangmuniangniang.png",
		skilldefense = 89,
		strength = 174,
		shanbi = 0,
		rating = 6,
		pianXiang = "偏治疗、奶三人、增益",
		dropChapterId = 10079,
		normalattack = 127,
		agility = 83,
		animation = "wangmuniangniang",
		gedang = 0,
		soulCount = 20,
		health = 443,
		soulId = 2100,
		profession = HeroProfession.eMage,
		quality = QualityType.ePurple,
		groupAttrs = {
			{
				addType = 99,
				name = "护身神龙",
				factor = 0.1,
				heroList = {
					209
				}
			},
			{
				addType = 99,
				name = "母仪天下",
				factor = 0.1,
				heroList = {
					211
				}
			},
			{
				addType = 99,
				name = "各司其职",
				factor = 0.1,
				heroList = {
					101
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 50,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{20%}",
					"1级中阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+115}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 75,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【续命】提升至1级：",
					"若治疗使目标生命达到上限，可少量提高其生命上限的{5%}。",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+149}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 100,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【瑶池诀】提升5级：",
					"回复生命值提升{5%}，并提升{5%}的闪避加成概率及{5%}的加成值",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+155}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 2100,
				mateCount = 125,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+161}"
					},
					attrDescList2 = {
						"命中{+28}",
						"暴击{+75}",
						"破击{+42}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2100,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{40%}",
					"2级中阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+125}",
						"基础战力值{+167}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 2100,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【续命】提升至2级：",
					"若治疗使目标生命达到上限，可少量提高其生命上限的{10%}。",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+172}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 2100,
				mateCount = 240,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【瑶池诀】提升5级：",
					"回复生命值提升{5%}，并提升{5%}的闪避加成概率及{5%}的加成值",
					attrDescList1 = {
						"潜力点{+155}",
						"基础战力值{+178}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 2100,
				mateCount = 280,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+175}",
						"基础战力值{+184}"
					},
					attrDescList2 = {
						"命中{+108}",
						"闪避{+75}",
						"暴击{+25}",
						"破击{+51}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 2100,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{60%}",
					"3级中阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+195}",
						"基础战力值{+190}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 2100,
				mateCount = 400,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【续命】提升至3级：",
					"若治疗使目标生命达到上限，可少量提高其生命上限的{15%}。",
					attrDescList1 = {
						"潜力点{+210}",
						"基础战力值{+196}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 2100,
				mateCount = 460,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【瑶池诀】提升5级：",
					"回复生命值提升{5%}，并提升{5%}的闪避加成概率及{5%}的加成值",
					attrDescList1 = {
						"潜力点{+225}",
						"基础战力值{+201}"
					}
				}
			},
			{
				soulCount = 46,
				soulId = 2100,
				mateCount = 520,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+207}"
					},
					attrDescList2 = {
						"命中{+112}",
						"暴击{+140}",
						"韧性{+15}",
						"破击{+48}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2100,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+150}",
					"@怒气法术【瑶池诀】提升1级：",
					"回复生命值提升{1%}，并提升{1%}的闪避加成概率及{1%}的加成值"
				}
			}
		},
		groupEquips = {
			{
				equipId = 93,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 53,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 20,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 145,
				attrValue = 10,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 122,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 178,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[211] = {
		mana = 177,
		name = "托塔天王",
		talentId = 10044,
		baoji = 0,
		renxing = 0,
		normaldefense = 39,
		desc = "著名童星哪吒的父亲，因长年累月手托宝塔不换姿势而得托塔天王之美名，但是手肘也因此患上了关节炎。真是敬业的好男人。",
		skillattack = 272,
		mingzhong = 0,
		physical = 72,
		skillId = 44,
		poji = 0,
		headerImage = "small_tuotatianwang.png",
		skilldefense = 86,
		strength = 161,
		shanbi = 0,
		rating = 6,
		pianXiang = "偏法攻、后排、降怒",
		dropChapterId = 0,
		normalattack = 124,
		agility = 87,
		animation = "tuotatianwang",
		gedang = 0,
		soulCount = 20,
		health = 429,
		soulId = 2110,
		profession = HeroProfession.eMage,
		quality = QualityType.ePurple,
		groupAttrs = {
			{
				addType = 99,
				name = "母仪天下",
				factor = 0.1,
				heroList = {
					210
				}
			},
			{
				addType = 99,
				name = "同袍同泽",
				factor = 0.1,
				heroList = {
					212
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 50,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{20%}",
					"1级中阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+115}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 75,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【承天】提升至1级：",
					"普通攻击有{50%}的概率无视顺序，直接攻击敌方生命最少的目标。",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+149}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 100,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【威震诀】提升5级：",
					"威震诀对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+155}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 2110,
				mateCount = 125,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+161}"
					},
					attrDescList2 = {
						"命中{+30}",
						"暴击{+43}",
						"破击{+72}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2110,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{40%}",
					"2级中阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+125}",
						"基础战力值{+167}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 2110,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【承天】提升至2级：",
					"普通攻击有{75%}的概率无视顺序，直接攻击敌方生命最少的目标。",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+172}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 2110,
				mateCount = 240,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【威震诀】提升5级：",
					"威震诀对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+155}",
						"基础战力值{+178}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 2110,
				mateCount = 280,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+175}",
						"基础战力值{+184}"
					},
					attrDescList2 = {
						"命中{+74}",
						"闪避{+25}",
						"暴击{+52}",
						"破击{+108}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 2110,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{60%}",
					"3级中阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+195}",
						"基础战力值{+190}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 2110,
				mateCount = 400,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【承天】提升至3级：",
					"普通攻击有{100%}的概率无视顺序，直接攻击敌方生命最少的目标。",
					attrDescList1 = {
						"潜力点{+210}",
						"基础战力值{+196}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 2110,
				mateCount = 460,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【威震诀】提升5级：",
					"威震诀对敌方造成的法术伤害提升{5%}",
					attrDescList1 = {
						"潜力点{+225}",
						"基础战力值{+201}"
					}
				}
			},
			{
				soulCount = 46,
				soulId = 2110,
				mateCount = 520,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+207}"
					},
					attrDescList2 = {
						"命中{+49}",
						"暴击{+65}",
						"韧性{+63}",
						"破击{+148}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2110,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+150}",
					"@怒气法术【威震诀】提升1级：",
					"威震诀对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 92,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 58,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 26,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 150,
				attrValue = 15,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 120,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 179,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[212] = {
		mana = 169,
		name = "何仙姑",
		talentId = 10022,
		baoji = 0,
		renxing = 0,
		normaldefense = 37,
		desc = "八仙中唯一的女性,传说在十三岁时在入山采茶时遇见一位道士。道士给她吃了一个桃子，从此不饥不渴，洞知人事休咎。",
		skillattack = 260,
		mingzhong = 0,
		physical = 76,
		skillId = 43,
		poji = 0,
		headerImage = "small_hexiangu.png",
		skilldefense = 83,
		strength = 153,
		shanbi = 0,
		rating = 6,
		pianXiang = "偏治疗、奶三人、增益",
		dropChapterId = 0,
		normalattack = 118,
		agility = 79,
		animation = "hexiangu",
		gedang = 0,
		soulCount = 18,
		health = 456,
		soulId = 2120,
		profession = HeroProfession.eMage,
		quality = QualityType.ePurple,
		groupAttrs = {
			{
				addType = 99,
				name = "同袍同泽",
				factor = 0.1,
				heroList = {
					211
				}
			},
			{
				addType = 99,
				name = "八仙过海",
				factor = 0.1,
				heroList = {
					209
				}
			},
			{
				addType = 99,
				name = "美女野兽",
				factor = 0.1,
				heroList = {
					112
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 50,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{20%}",
					"1级中阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+60}",
						"基础战力值{+115}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 75,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【青莲】提升至1级：",
					"当被攻击死亡时，我方其他全部武将生命值回复{30%}。",
					attrDescList1 = {
						"潜力点{+75}",
						"基础战力值{+149}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 100,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【莲生诀】提升5级：",
					"回复生命值提升{5%}，并提升{5%}的闪避加成概率及{5%}的格挡加成值",
					attrDescList1 = {
						"潜力点{+90}",
						"基础战力值{+155}"
					}
				}
			},
			{
				soulCount = 14,
				soulId = 2120,
				mateCount = 125,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+105}",
						"基础战力值{+161}"
					},
					attrDescList2 = {
						"命中{+29}",
						"暴击{+43}",
						"破击{+75}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2120,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{40%}",
					"2级中阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+125}",
						"基础战力值{+167}"
					}
				}
			},
			{
				soulCount = 22,
				soulId = 2120,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【青莲】提升至2级：",
					"当被攻击死亡时，我方其他全部武将生命值回复{40%}。",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+172}"
					}
				}
			},
			{
				soulCount = 26,
				soulId = 2120,
				mateCount = 240,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【莲生诀】提升5级：",
					"回复生命值提升{5%}，并提升{5%}的闪避加成概率及{5%}的格挡加成值",
					attrDescList1 = {
						"潜力点{+155}",
						"基础战力值{+178}"
					}
				}
			},
			{
				soulCount = 30,
				soulId = 2120,
				mateCount = 280,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+175}",
						"基础战力值{+184}"
					},
					attrDescList2 = {
						"命中{+79}",
						"闪避{+27}",
						"暴击{+51}",
						"破击{+107}"
					}
				}
			},
			{
				soulCount = 34,
				soulId = 2120,
				mateCount = 340,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{60%}",
					"3级中阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+195}",
						"基础战力值{+190}"
					}
				}
			},
			{
				soulCount = 38,
				soulId = 2120,
				mateCount = 400,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【青莲】提升至3级：",
					"当被攻击死亡时，我方其他全部武将生命值回复{50%}。",
					attrDescList1 = {
						"潜力点{+210}",
						"基础战力值{+196}"
					}
				}
			},
			{
				soulCount = 42,
				soulId = 2120,
				mateCount = 460,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【莲生诀】提升5级：",
					"回复生命值提升{5%}，并提升{5%}的闪避加成概率及{5%}的格挡加成值",
					attrDescList1 = {
						"潜力点{+225}",
						"基础战力值{+201}"
					}
				}
			},
			{
				soulCount = 46,
				soulId = 2120,
				mateCount = 520,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+207}"
					},
					attrDescList2 = {
						"命中{+50}",
						"暴击{+61}",
						"韧性{+65}",
						"破击{+146}"
					}
				}
			},
			{
				soulCount = 18,
				soulId = 2120,
				mateCount = 160,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+150}",
					"@怒气法术【莲生诀】提升1级：",
					"回复生命值提升{1%}，并提升{1%}的闪避加成概率及{1%}的格挡加成值"
				}
			}
		},
		groupEquips = {
			{
				equipId = 93,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 54,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 23,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 145,
				attrValue = 15,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 118,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 180,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[101] = {
		mana = 225,
		name = "玉皇大帝",
		talentId = 10045,
		baoji = 0,
		renxing = 0,
		normaldefense = 60,
		desc = "统领天地人三界神灵，地位至高无上。作为三界家喻户晓的名人，经常传说他与西王母的绯闻。不过他与西王母真的不是夫妻",
		skillattack = 313,
		mingzhong = 0,
		physical = 127,
		skillId = 31,
		poji = 0,
		headerImage = "small_yuhuangdadi.png",
		skilldefense = 121,
		strength = 224,
		shanbi = 0,
		rating = 8,
		pianXiang = "偏防御、全体、移除增益",
		dropChapterId = 30039,
		normalattack = 156,
		agility = 90,
		animation = "yuhuangdadi",
		gedang = 0,
		soulCount = 38,
		health = 762,
		soulId = 1010,
		profession = HeroProfession.eCommander,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "侄门互守",
				factor = 0.1,
				heroList = {
					102
				}
			},
			{
				addType = 99,
				name = "轮回转世",
				factor = 0.1,
				heroList = {
					110
				}
			},
			{
				addType = 99,
				name = "道家巨擎",
				factor = 0.15,
				heroList = {
					103,
					108
				}
			},
			{
				addType = 99,
				name = "接班人",
				factor = 0.15,
				heroList = {
					123
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+161}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【帝运】提升至1级：",
					"每次攻击敌方后,自身直接回复{5%}生命值。",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+209}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【至尊令】提升5级：",
					"法术伤害提升{15%}，并提升{5%}的状态解除加成率",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+217}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1010,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{15%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+225}"
					},
					attrDescList2 = {
						"韧性{+84}",
						"破击{+40}",
						"格挡{+81}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1010,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+233}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1010,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【帝运】提升至2级：",
					"每次攻击敌方后,自身直接回复{10%}生命值。",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+241}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1010,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【至尊令】提升5级：",
					"法术伤害提升{15%}，并提升{5%}的状态解除加成率",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+249}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1010,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+257}"
					},
					attrDescList2 = {
						"闪避{+75}",
						"韧性{+113}",
						"破击{+36}",
						"格挡{+142}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1010,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+266}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1010,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【帝运】提升至3级：",
					"每次攻击敌方后,自身直接回复{20%}生命值。",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+274}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1010,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【至尊令】提升5级：",
					"法术伤害提升{15%}，并提升{5%}的状态解除加成率",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+282}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1010,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{45%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+290}"
					},
					attrDescList2 = {
						"命中{+23}",
						"暴击{+23}",
						"韧性{+206}",
						"格挡{+199}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1010,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【至尊令】提升1级：",
					"法术伤害提升{1%}，并提升{1%}的状态解除加成率"
				}
			}
		},
		groupEquips = {
			{
				equipId = 95,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 68,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 35,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 155,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 125,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 159,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[102] = {
		mana = 224,
		name = "人王伏羲",
		talentId = 10034,
		baoji = 0,
		renxing = 0,
		normaldefense = 57,
		desc = "人类杰出代表，他根据天地万物的变化，发明创造了占卜八卦，是中华民族人文始祖。被三界管委会颁发特殊贡献奖，封人王称号。",
		skillattack = 327,
		mingzhong = 0,
		physical = 129,
		skillId = 32,
		poji = 0,
		headerImage = "small_renwangfuxi.png",
		skilldefense = 115,
		strength = 224,
		shanbi = 0,
		rating = 8,
		pianXiang = "偏防御、单体、沉默",
		dropChapterId = 30079,
		normalattack = 164,
		agility = 100,
		animation = "renwangfuxi",
		gedang = 0,
		soulCount = 38,
		health = 776,
		soulId = 1020,
		profession = HeroProfession.eCommander,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "伏羲九针",
				factor = 0.1,
				heroList = {
					107
				}
			},
			{
				addType = 99,
				name = "侄门互守",
				factor = 0.1,
				heroList = {
					101
				}
			},
			{
				addType = 99,
				name = "诸神之战",
				factor = 0.2,
				heroList = {
					110,
					109,
					105
				}
			},
			{
				addType = 99,
				name = "人王猴王",
				factor = 0.15,
				heroList = {
					112
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+161}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【推演】提升至1级：",
					"每次被攻击后，增加自身防御力的{3%}直至死亡。",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+209}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【阴阳道】提升5级：",
					"阴阳道对敌方造成的法术伤害提升{15%}",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+217}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1020,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{15%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+225}"
					},
					attrDescList2 = {
						"命中{+39}",
						"韧性{+62}",
						"格挡{+102}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1020,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+233}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1020,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【推演】提升至2级：",
					"每次被攻击后，增加自身防御力的{5%}直至死亡。",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+241}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1020,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【阴阳道】提升5级：",
					"阴阳道对敌方造成的法术伤害提升{15%}",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+249}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1020,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+257}"
					},
					attrDescList2 = {
						"闪避{+110}",
						"韧性{+142}",
						"破击{+35}",
						"格挡{+71}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1020,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+266}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1020,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【推演】提升至3级：",
					"每次被攻击后，增加自身防御力的{8%}直至死亡。",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+274}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1020,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【阴阳道】提升5级：",
					"阴阳道对敌方造成的法术伤害提升{15%}",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+282}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1020,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{45%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+290}"
					},
					attrDescList2 = {
						"命中{+66}",
						"暴击{+22}",
						"韧性{+202}",
						"格挡{+150}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1020,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【阴阳道】提升1级：",
					"阴阳道对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 96,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 64,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 28,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 153,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 123,
				attrValue = 15,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 160,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[103] = {
		mana = 195,
		name = "镇元子",
		talentId = 10046,
		baoji = 0,
		renxing = 0,
		normaldefense = 50,
		desc = "地仙之祖，用珍贵的人参果宴招待了取经四人组。不但不计较孙悟空毁了人参果树，还与孙悟空结拜为兄弟，颇具大仙风范。",
		skillattack = 285,
		mingzhong = 0,
		physical = 120,
		skillId = 46,
		poji = 0,
		headerImage = "small_zhenyuanzi.png",
		skilldefense = 100,
		strength = 196,
		shanbi = 0,
		rating = 7,
		pianXiang = "偏防御、奶前排、加防",
		dropChapterId = 20039,
		normalattack = 143,
		agility = 90,
		animation = "zhenyuanzi",
		gedang = 0,
		soulCount = 35,
		health = 720,
		soulId = 1030,
		profession = HeroProfession.eCommander,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "天地人和",
				factor = 0.1,
				heroList = {
					104
				}
			},
			{
				addType = 99,
				name = "正邪两极",
				factor = 0.1,
				heroList = {
					109
				}
			},
			{
				addType = 99,
				name = "道家巨擎",
				factor = 0.15,
				heroList = {
					101,
					108
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+138}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【地仙】提升至1级：",
					"每次被攻击后,都能提升自身{30%}的格挡值,并降低对方{5%}破击。",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+179}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【百果宴】提升5级：",
					"回复生命值提升{10%}，并提升防御力加成值{5%}",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+186}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1030,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{10%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+193}"
					},
					attrDescList2 = {
						"命中{+34}",
						"韧性{+50}",
						"格挡{+88}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1030,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+200}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1030,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【地仙】提升至2级：",
					"每次被攻击后,都能提升自身{40%}的格挡值,并降低对方{10%}破击。",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+207}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1030,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【百果宴】提升5级：",
					"回复生命值提升{10%}，并提升防御力加成值{5%}",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+214}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1030,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{20%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+221}"
					},
					attrDescList2 = {
						"闪避{+94}",
						"韧性{+124}",
						"破击{+30}",
						"格挡{+64}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1030,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+228}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1030,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【地仙】提升至3级：",
					"每次被攻击后,都能提升自身{50%}的格挡值,并降低对方{15%}破击。",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+235}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1030,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【百果宴】提升5级：",
					"回复生命值提升{10%}，并提升防御力加成值{5%}",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+242}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1030,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+249}"
					},
					attrDescList2 = {
						"命中{+56}",
						"暴击{+19}",
						"韧性{+177}",
						"格挡{+137}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1030,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【百果宴】提升1级：",
					"回复生命值提升{1%}，并提升防御力加成值{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 97,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 62,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 32,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 153,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 126,
				attrValue = 15,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 161,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[104] = {
		mana = 227,
		name = "通天教主",
		talentId = 10037,
		baoji = 0,
		renxing = 0,
		normaldefense = 50,
		desc = "鸿钧老祖的爱徒，又是截教教主，那是号令天下，莫敢不从。执混沌钟，镇压鸿蒙世界，掌诛仙剑阵，主宰天道杀伐。",
		skillattack = 349,
		mingzhong = 0,
		physical = 90,
		skillId = 36,
		poji = 0,
		headerImage = "small_tongtianjiaozhu.png",
		skilldefense = 111,
		strength = 207,
		shanbi = 0,
		rating = 7,
		pianXiang = "偏治疗、奶三人、转移异常",
		dropChapterId = 20049,
		normalattack = 159,
		agility = 102,
		animation = "tongtianjiaozhu",
		gedang = 0,
		soulCount = 35,
		health = 541,
		soulId = 1040,
		profession = HeroProfession.eMage,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "天地人和",
				factor = 0.1,
				heroList = {
					103
				}
			},
			{
				addType = 99,
				name = "通天女娲",
				factor = 0.1,
				heroList = {
					105
				}
			},
			{
				addType = 99,
				name = "轮回转世",
				factor = 0.15,
				heroList = {
					107,
					106
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+138}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【返本】提升至1级：",
					"当敌方当前生命值小于上限的{15%}时，有{20%}的概率普通攻击可直接秒杀对方。",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+179}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【通天诀】提升5级：",
					"通天诀可回复目标生命值提升{10%}",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+186}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1040,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{10%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+193}"
					},
					attrDescList2 = {
						"命中{+34}",
						"暴击{+50}",
						"破击{+85}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1040,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+200}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1040,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【返本】提升至2级：",
					"当敌方当前生命值小于上限的{20%}时，有{25%}的概率普通攻击可直接秒杀对方。",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+207}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1040,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【通天诀】提升5级：",
					"通天诀可回复目标生命值提升{10%}",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+214}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1040,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{20%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+221}"
					},
					attrDescList2 = {
						"命中{+92}",
						"闪避{+32}",
						"暴击{+63}",
						"破击{+124}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1040,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+228}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1040,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【返本】提升至3级：",
					"当敌方当前生命值小于上限的{25%}时，有{30%}的概率普通攻击可直接秒杀对方。",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+235}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1040,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【通天诀】提升5级：",
					"通天诀可回复目标生命值提升{10%}",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+242}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1040,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+249}"
					},
					attrDescList2 = {
						"命中{+58}",
						"暴击{+74}",
						"韧性{+79}",
						"破击{+180}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1040,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【通天诀】提升1级：",
					"通天诀可回复目标生命值提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 99,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 65,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 36,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 157,
				attrValue = 15,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 124,
				attrValue = 25,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 162,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[105] = {
		mana = 213,
		name = "女娲娘娘",
		talentId = 10038,
		baoji = 0,
		renxing = 0,
		normaldefense = 48,
		desc = "人王伏羲的妻子，还没完全解决树叶遮体的走光问题，就先补了天上的窟窿并创造了无数人类，是东方圣母。舍小家为大家的典范！",
		skillattack = 349,
		mingzhong = 0,
		physical = 80,
		skillId = 35,
		poji = 0,
		headerImage = "small_nvwaniangniang.png",
		skilldefense = 97,
		strength = 189,
		shanbi = 0,
		rating = 7,
		pianXiang = "偏治疗、奶全体、解除异常",
		dropChapterId = 20059,
		normalattack = 138,
		agility = 100,
		animation = "nvwaniangniang",
		gedang = 0,
		soulCount = 35,
		health = 482,
		soulId = 1050,
		profession = HeroProfession.eMage,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "通天女娲",
				factor = 0.1,
				heroList = {
					104
				}
			},
			{
				addType = 99,
				name = "天地通拓",
				factor = 0.1,
				heroList = {
					108
				}
			},
			{
				addType = 99,
				name = "诸神之战",
				factor = 0.2,
				heroList = {
					102,
					110,
					109
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+138}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【诛仙】提升至1级：",
					"杀死敌方后，死者周围的目标都会受到{33%}法术伤害。",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+179}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【补天诀】提升5级：",
					"回复生命值提升{10%}，并提升{5%}的状态解除加成概率",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+186}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1050,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{10%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+193}"
					},
					attrDescList2 = {
						"命中{+36}",
						"暴击{+85}",
						"破击{+51}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1050,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+200}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1050,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【诛仙】提升至2级：",
					"杀死敌方后，死者周围的目标都会受到{36%}法术伤害。",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+207}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1050,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【补天诀】提升5级：",
					"回复生命值提升{10%}，并提升{5%}的状态解除加成概率",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+214}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1050,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{20%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+221}"
					},
					attrDescList2 = {
						"命中{+126}",
						"闪避{+93}",
						"暴击{+31}",
						"破击{+61}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1050,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+228}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1050,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【诛仙】提升至3级：",
					"杀死敌方后，死者周围的目标都会受到{40%}法术伤害。",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+235}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1050,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【补天诀】提升5级：",
					"回复生命值提升{10%}，并提升{5%}的状态解除加成概率",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+242}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1050,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+249}"
					},
					attrDescList2 = {
						"命中{+137}",
						"暴击{+171}",
						"韧性{+20}",
						"破击{+56}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1050,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【补天诀】提升1级：",
					"回复生命值提升{1%}，并提升{1%}的状态解除加成概率"
				}
			}
		},
		groupEquips = {
			{
				equipId = 94,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 64,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 30,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 154,
				attrValue = 10,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 125,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 163,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[106] = {
		mana = 203,
		name = "太上老君",
		talentId = 10032,
		baoji = 0,
		renxing = 0,
		normaldefense = 46,
		desc = "道教首席执行官，为人宅心仁厚、与世无争，每天的乐趣就是炼制金丹。当然，老君一身的实力用它身上无数的顶级法宝就可证明。",
		skillattack = 332,
		mingzhong = 0,
		physical = 85,
		skillId = 49,
		poji = 0,
		headerImage = "small_taishanglaojun.png",
		skilldefense = 92,
		strength = 181,
		shanbi = 0,
		rating = 7,
		pianXiang = "偏攻击、三人、降防",
		dropChapterId = 20069,
		normalattack = 132,
		agility = 98,
		animation = "taishanglaojun",
		gedang = 0,
		soulCount = 35,
		health = 508,
		soulId = 1060,
		profession = HeroProfession.eMage,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "镇压魔头",
				factor = 0.1,
				heroList = {
					109
				}
			},
			{
				addType = 99,
				name = "二清显圣",
				factor = 0.1,
				heroList = {
					108
				}
			},
			{
				addType = 99,
				name = "元神护道",
				factor = 0.15,
				heroList = {
					104,
					107
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+138}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【天道】提升至1级：",
					"受到普通攻击后，有{50%}的概率发动一次反击。",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+179}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【百炼诀】提升5级：",
					"法术伤害提升{10%},并提升降低的防御力加成{5%}",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+186}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1060,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{10%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+193}"
					},
					attrDescList2 = {
						"命中{+34}",
						"暴击{+87}",
						"破击{+53}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1060,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+200}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1060,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【天道】提升至2级：",
					"受到普通攻击后，有{75%}的概率发动一次反击。",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+207}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1060,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【百炼诀】提升5级：",
					"法术伤害提升{10%},并提升降低的防御力加成{5%}",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+214}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1060,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{20%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+221}"
					},
					attrDescList2 = {
						"命中{+125}",
						"闪避{+94}",
						"暴击{+32}",
						"破击{+62}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1060,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+228}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1060,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【天道】提升至3级：",
					"受到普通攻击后，有{100%}的概率发动一次反击。",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+235}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1060,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【百炼诀】提升5级：",
					"法术伤害提升{10%},并提升降低的防御力加成{5%}",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+242}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1060,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+249}"
					},
					attrDescList2 = {
						"命中{+131}",
						"暴击{+171}",
						"韧性{+20}",
						"破击{+58}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1060,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【百炼诀】提升1级：",
					"法术伤害提升{1%},并提升降低的防御力加成{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 97,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 63,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 29,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 154,
				attrValue = 10,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 127,
				attrValue = 25,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 164,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[107] = {
		mana = 241,
		name = "菩提祖师",
		talentId = 10047,
		baoji = 0,
		renxing = 0,
		normaldefense = 53,
		desc = "孙悟空首位师傅，相传是佛祖的师弟，因教导猴子无方，在大闹天宫后，转交给如来佛祖！不敢相信实力这么强横的大神住在山沟沟里。",
		skillattack = 370,
		mingzhong = 0,
		physical = 105,
		skillId = 48,
		poji = 0,
		headerImage = "small_putizushi.png",
		skilldefense = 118,
		strength = 218,
		shanbi = 0,
		rating = 8,
		pianXiang = "偏攻击、全体、概率沉默",
		dropChapterId = 30059,
		normalattack = 168,
		agility = 113,
		animation = "putizhushi",
		gedang = 0,
		soulCount = 38,
		health = 629,
		soulId = 1070,
		profession = HeroProfession.eMage,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "伏羲九针",
				factor = 0.1,
				heroList = {
					102
				}
			},
			{
				addType = 99,
				name = "传艺之恩",
				factor = 0.1,
				heroList = {
					110
				}
			},
			{
				addType = 99,
				name = "元神护道",
				factor = 0.2,
				heroList = {
					104,
					106,
					109
				}
			},
			{
				addType = 99,
				name = "第一师傅",
				factor = 0.15,
				heroList = {
					112
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+161}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【妙法】提升至1级：",
					"每次攻击敌方后，提升自身{10%}速度及{10%}暴击率。",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+209}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【七宝诀】提升5级：",
					"法术伤害提升{15%}，并提升{5%}的沉默加成率",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+217}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1070,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{15%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+225}"
					},
					attrDescList2 = {
						"命中{+40}",
						"暴击{+62}",
						"破击{+104}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1070,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+233}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1070,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【妙法】提升至2级：",
					"每次攻击敌方后，提升自身{20%}速度及{20%}暴击率。",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+241}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1070,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【七宝诀】提升5级：",
					"法术伤害提升{15%}，并提升{5%}的沉默加成率",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+249}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1070,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+257}"
					},
					attrDescList2 = {
						"命中{+112}",
						"闪避{+36}",
						"暴击{+71}",
						"破击{+142}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1070,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+266}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1070,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【妙法】提升至3级：",
					"每次攻击敌方后，提升自身{30%}速度及{30%}暴击率。",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+274}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1070,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【七宝诀】提升5级：",
					"法术伤害提升{15%}，并提升{5%}的沉默加成率",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+282}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1070,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{45%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+290}"
					},
					attrDescList2 = {
						"命中{+67}",
						"暴击{+90}",
						"韧性{+90}",
						"破击{+198}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1070,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【七宝诀】提升1级：",
					"法术伤害提升{1%}，并提升{1%}的沉默加成率"
				}
			}
		},
		groupEquips = {
			{
				equipId = 99,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 65,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 33,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 154,
				attrValue = 15,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 125,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 165,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[108] = {
		mana = 208,
		name = "元始天尊",
		talentId = 10035,
		baoji = 0,
		renxing = 0,
		normaldefense = 53,
		desc = "传说中的‘三清’之首，是鸿钧老祖门下的得意弟子。作为阐教创始人，拥有无边法力，逆天法宝也是数不胜数，是绝对实力派的代表。",
		skillattack = 321,
		mingzhong = 0,
		physical = 119,
		skillId = 34,
		poji = 0,
		headerImage = "small_yuanshitianzun.png",
		skilldefense = 101,
		strength = 231,
		shanbi = 0,
		rating = 8,
		pianXiang = "偏攻击、后排、概率沉默",
		dropChapterId = 30089,
		normalattack = 186,
		agility = 129,
		animation = "yuanshitianzun",
		gedang = 0,
		soulCount = 38,
		health = 715,
		soulId = 1080,
		profession = HeroProfession.eWarrior,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "二清显圣",
				factor = 0.1,
				heroList = {
					106
				}
			},
			{
				addType = 99,
				name = "天地通拓",
				factor = 0.1,
				heroList = {
					105
				}
			},
			{
				addType = 99,
				name = "道家巨擎",
				factor = 0.15,
				heroList = {
					101,
					103
				}
			},
			{
				addType = 99,
				name = "开天辟地",
				factor = 0.15,
				heroList = {
					123
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+161}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【无量】提升至1级：",
					"每次发动攻击后，增加自身攻击力的{15%}直至死亡。",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+209}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【封镇八荒】提升5级：",
					"法术伤害提升{15%}，并提升{5%}的沉默加成概率",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+217}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1080,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{15%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+225}"
					},
					attrDescList2 = {
						"命中{+100}",
						"暴击{+60}",
						"破击{+41}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1080,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+233}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1080,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【无量】提升至2级：",
					"每次发动攻击后，增加自身攻击力的{20%}直至死亡。",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+241}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1080,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【封镇八荒】提升5级：",
					"法术伤害提升{15%}，并提升{5%}的沉默加成概率",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+249}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1080,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+257}"
					},
					attrDescList2 = {
						"命中{+108}",
						"暴击{+36}",
						"破击{+148}",
						"格挡{+73}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1080,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+266}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1080,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【无量】提升至3级：",
					"每次发动攻击后，增加自身攻击力的{25%}直至死亡。",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+274}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1080,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【封镇八荒】提升5级：",
					"法术伤害提升{15%}，并提升{5%}的沉默加成概率",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+282}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1080,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{45%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+290}"
					},
					attrDescList2 = {
						"命中{+174}",
						"闪避{+44}",
						"韧性{+44}",
						"破击{+181}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1080,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【封镇八荒】提升1级：",
					"法术伤害提升{1%}，并提升{1%}的沉默加成概率"
				}
			}
		},
		groupEquips = {
			{
				equipId = 95,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 62,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 28,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 155,
				attrValue = 25,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 123,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 166,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[109] = {
		mana = 224,
		name = "九界魔尊",
		talentId = 10036,
		baoji = 0,
		renxing = 0,
		normaldefense = 62,
		desc = "魔族最高指挥官，掌管九界之内所有妖魔，走哪都摆出一副国家领导人的架势，看来有派头是领导的专精天赋技能啊。",
		skillattack = 355,
		mingzhong = 0,
		physical = 103,
		skillId = 33,
		poji = 0,
		headerImage = "small_jiujiemozun.png",
		skilldefense = 106,
		strength = 274,
		shanbi = 0,
		rating = 8,
		pianXiang = "偏攻击、单体、概率昏迷",
		dropChapterId = 0,
		normalattack = 224,
		agility = 126,
		animation = "jiujiemozun",
		gedang = 0,
		soulCount = 38,
		health = 616,
		soulId = 1090,
		profession = HeroProfession.eWarrior,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "镇压魔头",
				factor = 0.1,
				heroList = {
					106
				}
			},
			{
				addType = 99,
				name = "正邪两极",
				factor = 0.1,
				heroList = {
					103
				}
			},
			{
				addType = 99,
				name = "诸神之战",
				factor = 0.2,
				heroList = {
					110,
					102,
					105
				}
			},
			{
				addType = 99,
				name = "带你去吃",
				factor = 0.15,
				heroList = {
					122
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+161}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【连斩】提升至1级：",
					"若攻击将对方杀死，可再发动一次普通攻击，并使本次攻击力上升{5%}。",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+209}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【初开混沌】提升5级：",
					"法术伤害提升{15%}，并提升{5%}的昏迷加成概率",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+217}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1090,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{15%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+225}"
					},
					attrDescList2 = {
						"命中{+40}",
						"暴击{+102}",
						"破击{+60}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1090,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+233}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1090,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【连斩】提升至2级：",
					"若攻击将对方杀死，可再发动一次普通攻击，并使本次攻击力上升{10%}。",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+241}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1090,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【初开混沌】提升5级：",
					"法术伤害提升{15%}，并提升{5%}的昏迷加成概率",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+249}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1090,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+257}"
					},
					attrDescList2 = {
						"命中{+149}",
						"闪避{+75}",
						"暴击{+110}",
						"破击{+37}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1090,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+266}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1090,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【连斩】提升至3级：",
					"若攻击将对方杀死，可再发动一次普通攻击，并使本次攻击力上升{15%}。",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+274}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1090,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【初开混沌】提升5级：",
					"法术伤害提升{15%}，并提升{5%}的昏迷加成概率",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+282}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1090,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{45%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+290}"
					},
					attrDescList2 = {
						"命中{+114}",
						"暴击{+183}",
						"韧性{+46}",
						"破击{+113}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1090,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【初开混沌】提升1级：",
					"法术伤害提升{1%}，并提升{1%}的昏迷加成概率"
				}
			}
		},
		groupEquips = {
			{
				equipId = 98,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 66,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 31,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 153,
				attrValue = 15,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 124,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 167,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[110] = {
		mana = 189,
		name = "蚩尤",
		talentId = 10048,
		baoji = 0,
		renxing = 0,
		normaldefense = 49,
		desc = "九黎部落首领，武力值到达顶峰的勇猛人物。也是苗族相传的远祖之一。是中国神话中的武战神，能把炎帝打败的棘手角色。",
		skillattack = 291,
		mingzhong = 0,
		physical = 108,
		skillId = 47,
		poji = 0,
		headerImage = "small_chiyou.png",
		skilldefense = 92,
		strength = 210,
		shanbi = 0,
		rating = 7,
		pianXiang = "偏攻击、全体、概率降暴",
		dropChapterId = 20079,
		normalattack = 169,
		agility = 106,
		animation = "chiyou",
		gedang = 0,
		soulCount = 35,
		health = 647,
		soulId = 1100,
		profession = HeroProfession.eWarrior,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "传艺之恩",
				factor = 0.1,
				heroList = {
					107
				}
			},
			{
				addType = 99,
				name = "轮回转世",
				factor = 0.1,
				heroList = {
					101
				}
			},
			{
				addType = 99,
				name = "诸神之战",
				factor = 0.2,
				heroList = {
					102,
					109,
					105
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+138}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【魔噬】提升至1级：",
					"普通攻击同时减少敌方生命上限的{5%}。",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+179}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【怒战九黎】提升5级：",
					"法术伤害提升{10%}，提升减益概率{5%}，并提升降低的暴击值加成{5%}",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+186}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1100,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{10%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+193}"
					},
					attrDescList2 = {
						"命中{+89}",
						"暴击{+51}",
						"破击{+36}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1100,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+200}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1100,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【魔噬】提升至2级：",
					"普通攻击同时减少敌方生命上限的{8%}。",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+207}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1100,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【怒战九黎】提升5级：",
					"法术伤害提升{10%}，提升减益概率{5%}，并提升降低的暴击值加成{5%}",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+214}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1100,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{20%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+221}"
					},
					attrDescList2 = {
						"命中{+95}",
						"暴击{+31}",
						"破击{+128}",
						"格挡{+61}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1100,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+228}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1100,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【魔噬】提升至3级：",
					"普通攻击同时减少敌方生命上限的{10%}。",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+235}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1100,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【怒战九黎】提升5级：",
					"法术伤害提升{10%}，提升减益概率{5%}，并提升降低的暴击值加成{5%}",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+242}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1100,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+249}"
					},
					attrDescList2 = {
						"命中{+158}",
						"闪避{+39}",
						"韧性{+38}",
						"破击{+151}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1100,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【怒战九黎】提升1级：",
					"法术伤害提升{1%}，提升减益概率{1%}，并提升降低的暴击值加成{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 100,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 63,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 34,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 156,
				attrValue = 25,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 124,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 168,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[111] = {
		mana = 220,
		name = "二郎真君",
		talentId = 10049,
		baoji = 0,
		renxing = 0,
		normaldefense = 61,
		desc = "岁月炼人心，曾经的勤劳官二代也敌不过权之一字的诱惑，竟生觊觎帝位之心，从此天庭暗潮汹涌，再掀波澜。",
		skillattack = 349,
		mingzhong = 0,
		physical = 112,
		skillId = 50,
		poji = 0,
		headerImage = "small_erlangzhenjun.png",
		skilldefense = 104,
		strength = 269,
		shanbi = 0,
		rating = 8,
		pianXiang = "偏攻击、全体、概率降怒",
		dropChapterId = 0,
		normalattack = 220,
		agility = 118,
		animation = "erlangzhenjun",
		gedang = 0,
		soulCount = 36,
		health = 672,
		soulId = 1110,
		profession = HeroProfession.eWarrior,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "代守天门",
				factor = 0.1,
				heroList = {
					101
				}
			},
			{
				addType = 99,
				name = "亦正亦邪",
				factor = 0.1,
				heroList = {
					110
				}
			},
			{
				addType = 99,
				name = "师从三清",
				factor = 0.15,
				heroList = {
					104,
					106
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+161}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【血战】提升至1级：",
					"每次攻击敌方后，提升自身{20}%命中及{20}%破击。",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+209}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【力掌乾坤】提升5级：",
					"法术伤害提升{15%}，并提升{5%}的怒气削减概率",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+217}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1110,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{15%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+225}"
					},
					attrDescList2 = {
						"命中{+40}",
						"暴击{+99}",
						"破击{+62}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1110,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+233}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1110,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【血战】提升至2级：",
					"每次攻击敌方后，提升自身{30}%命中及{30}%破击。",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+241}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1110,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【力掌乾坤】提升5级：",
					"法术伤害提升{15%}，并提升{5%}的怒气削减概率",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+249}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1110,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+257}"
					},
					attrDescList2 = {
						"命中{+147}",
						"闪避{+75}",
						"暴击{+107}",
						"破击{+36}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1110,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+266}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1110,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【血战】提升至3级：",
					"每次攻击敌方后，提升自身{40}%命中及{40}%破击。",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+274}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1110,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【力掌乾坤】提升5级：",
					"法术伤害提升{15%}，并提升{5%}的怒气削减概率",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+282}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1110,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{45%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+290}"
					},
					attrDescList2 = {
						"命中{+112}",
						"暴击{+176}",
						"韧性{+46}",
						"破击{+114}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1110,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【力掌乾坤】提升1级：",
					"法术伤害提升{1%}，并提升{1%}的怒气削减概率"
				}
			}
		},
		groupEquips = {
			{
				equipId = 100,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 62,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 32,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 156,
				attrValue = 15,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 126,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 201,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[112] = {
		mana = 214,
		name = "齐天大圣",
		talentId = 10055,
		baoji = 0,
		renxing = 0,
		normaldefense = 59,
		desc = "天庭居然只给了悟空一个小小的弼马温来做，知道真相的悟空相当愤怒，回到花果山准备自己大干一番，自封齐天大圣。",
		skillattack = 339,
		mingzhong = 0,
		physical = 108,
		skillId = 56,
		poji = 0,
		headerImage = "small_qitiandashen.png",
		skilldefense = 101,
		strength = 262,
		shanbi = 0,
		rating = 8,
		pianXiang = "偏攻击、后排、概率昏迷",
		dropChapterId = 30109,
		normalattack = 214,
		agility = 120,
		animation = "qitiandasheng",
		gedang = 0,
		soulCount = 38,
		health = 647,
		soulId = 1120,
		profession = HeroProfession.eWarrior,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "义结金兰",
				factor = 0.1,
				heroList = {
					118
				}
			},
			{
				addType = 99,
				name = "忘年之交",
				factor = 0.1,
				heroList = {
					119
				}
			},
			{
				addType = 99,
				name = "第一师傅",
				factor = 0.2,
				heroList = {
					107
				}
			},
			{
				addType = 99,
				name = "取经小队",
				factor = 0.2,
				heroList = {
					121,
					113,
					114
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+161}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【棍影】提升至1级：",
					"每次普通攻击，对同排相邻单位造成{30}%的额外伤害",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+209}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【佛火证道】提升5级：",
					"佛火证道对敌方造成的法术伤害提升{15%}，并提升{5%}的昏迷概率",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+217}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1120,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{15%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+225}"
					},
					attrDescList2 = {
						"命中{+40}",
						"暴击{+104}",
						"破击{+62}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1120,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+233}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1120,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【棍影】提升至2级：",
					"每次普通攻击，对同排相邻单位造成{40}%的额外伤害",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+241}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1120,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【佛火证道】提升5级：",
					"佛火证道对敌方造成的法术伤害提升{15%}，并提升{5%}的昏迷概率",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+249}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1120,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+257}"
					},
					attrDescList2 = {
						"命中{+148}",
						"闪避{+71}",
						"暴击{+108}",
						"破击{+37}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1120,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+266}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1120,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【棍影】提升至3级：",
					"每次普通攻击，对同排相邻单位造成{50}%的额外伤害",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+274}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1120,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【佛火证道】提升5级：",
					"佛火证道对敌方造成的法术伤害提升{15%}，并提升{5%}的昏迷概率",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+282}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1120,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{45%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+290}"
					},
					attrDescList2 = {
						"命中{+112}",
						"暴击{+181}",
						"韧性{+46}",
						"破击{+115}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1120,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【佛火证道】提升1级：",
					"佛火证道对敌方造成的法术伤害提升{1%}，并提升{1%}的昏迷概率"
				}
			}
		},
		groupEquips = {
			{
				equipId = 208,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 216,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 203,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 227,
				attrValue = 15,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 220,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 234,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[113] = {
		mana = 180,
		name = "天蓬元帅",
		talentId = 10053,
		baoji = 0,
		renxing = 0,
		normaldefense = 46,
		desc = "天庭掌管水军的最高统帅，只因酒后调戏嫦娥，被罚下界却又投错猪胎，真是史上代价最大的酒后闹事。",
		skillattack = 277,
		mingzhong = 0,
		physical = 99,
		skillId = 54,
		poji = 0,
		headerImage = "small_tianpengyuanshuai.png",
		skilldefense = 87,
		strength = 199,
		shanbi = 0,
		rating = 7,
		pianXiang = "偏攻击、斩杀三人、降防",
		dropChapterId = 20089,
		normalattack = 160,
		agility = 109,
		animation = "tianpengyuanshuai",
		gedang = 0,
		soulCount = 36,
		health = 594,
		soulId = 1130,
		profession = HeroProfession.eWarrior,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "好像认识",
				factor = 0.1,
				heroList = {
					120
				}
			},
			{
				addType = 99,
				name = "远古近今",
				factor = 0.1,
				heroList = {
					116
				}
			},
			{
				addType = 99,
				name = "取经小队",
				factor = 0.2,
				heroList = {
					121,
					112,
					114
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+138}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【贪食】提升至1级：",
					"每次接受治疗后，防御力提升{5}%。",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+179}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【九齿夺命】提升5级：",
					"九齿夺命对敌方造成的法术伤害提升{10%}，并提升{5%}的防御削弱值",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+186}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1130,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{10%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+193}"
					},
					attrDescList2 = {
						"命中{+85}",
						"暴击{+52}",
						"破击{+35}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1130,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+200}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1130,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【贪食】提升至2级：",
					"每次接受治疗后，防御力提升{8}%。",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+207}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1130,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【九齿夺命】提升5级：",
					"九齿夺命对敌方造成的法术伤害提升{10%}，并提升{5%}的防御削弱值",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+214}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1130,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{20%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+221}"
					},
					attrDescList2 = {
						"命中{+94}",
						"暴击{+32}",
						"破击{+124}",
						"格挡{+62}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1130,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+228}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1130,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【贪食】提升至3级：",
					"每次接受治疗后，防御力提升{10}%。",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+235}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1130,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【九齿夺命】提升5级：",
					"九齿夺命对敌方造成的法术伤害提升{10%}，并提升{5%}的防御削弱值",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+242}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1130,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+249}"
					},
					attrDescList2 = {
						"命中{+155}",
						"闪避{+38}",
						"韧性{+39}",
						"破击{+157}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1130,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【九齿夺命】提升1级：",
					"九齿夺命对敌方造成的法术伤害提升{1%}，并提升{1%}的防御削弱值"
				}
			}
		},
		groupEquips = {
			{
				equipId = 211,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 217,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 203,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 229,
				attrValue = 25,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 220,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 235,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[114] = {
		mana = 188,
		name = "卷帘大将",
		talentId = 10054,
		baoji = 0,
		renxing = 0,
		normaldefense = 48,
		desc = "玉皇大帝身前的看守武将，为人忠厚老实，却因不小心打碎了玉帝喜爱的琉璃盏，被贬下界当起了妖怪。",
		skillattack = 290,
		mingzhong = 0,
		physical = 103,
		skillId = 55,
		poji = 0,
		headerImage = "small_junliandajiang.png",
		skilldefense = 92,
		strength = 209,
		shanbi = 0,
		rating = 7,
		pianXiang = "偏攻击、单体、降攻减怒",
		dropChapterId = 20099,
		normalattack = 168,
		agility = 108,
		animation = "juanliandajiang",
		gedang = 0,
		soulCount = 35,
		health = 617,
		soulId = 1140,
		profession = HeroProfession.eWarrior,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "你牵着我",
				factor = 0.1,
				heroList = {
					115
				}
			},
			{
				addType = 99,
				name = "隔壁邻居",
				factor = 0.1,
				heroList = {
					120
				}
			},
			{
				addType = 99,
				name = "取经小队",
				factor = 0.2,
				heroList = {
					112,
					113,
					121
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+138}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【刀圭】提升至1级：",
					"每杀死一个目标后，普攻法攻提升{10}%。",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+179}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【降魔一击】提升5级：",
					"降魔一击对敌方造成的法术伤害提升{10%}，并提升{5%}的攻击削弱值",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+186}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1140,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{10%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+193}"
					},
					attrDescList2 = {
						"命中{+87}",
						"暴击{+53}",
						"破击{+36}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1140,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+200}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1140,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【刀圭】提升至2级：",
					"每杀死一个目标后，普攻法攻提升{20}%。",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+207}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1140,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【降魔一击】提升5级：",
					"降魔一击对敌方造成的法术伤害提升{10%}，并提升{5%}的攻击削弱值",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+214}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1140,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{20%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+221}"
					},
					attrDescList2 = {
						"命中{+95}",
						"暴击{+31}",
						"破击{+125}",
						"格挡{+61}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1140,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+228}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1140,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【刀圭】提升至3级：",
					"每杀死一个目标后，普攻法攻提升{30}%。",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+235}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1140,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【降魔一击】提升5级：",
					"降魔一击对敌方造成的法术伤害提升{10%}，并提升{5%}的攻击削弱值",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+242}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1140,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+249}"
					},
					attrDescList2 = {
						"命中{+155}",
						"闪避{+39}",
						"韧性{+38}",
						"破击{+155}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1140,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【降魔一击】提升1级：",
					"降魔一击对敌方造成的法术伤害提升{1%}，并提升{1%}的攻击削弱值"
				}
			}
		},
		groupEquips = {
			{
				equipId = 212,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 218,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 205,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 226,
				attrValue = 25,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 223,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 239,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[115] = {
		mana = 207,
		name = "八部天龙",
		talentId = 10057,
		baoji = 0,
		renxing = 0,
		normaldefense = 56,
		desc = "本是西海龙三太子，意外烧了玉帝赐予的夜明珠，又吃了玄奘的坐骑白马，只得变作马身驮着玄奘西去。",
		skillattack = 288,
		mingzhong = 0,
		physical = 112,
		skillId = 58,
		poji = 0,
		headerImage = "small_babutianlong.png",
		skilldefense = 111,
		strength = 207,
		shanbi = 0,
		rating = 7,
		pianXiang = "偏防御、治疗单体、解除异常",
		dropChapterId = 20109,
		normalattack = 144,
		agility = 81,
		animation = "baibutianlong",
		gedang = 0,
		soulCount = 35,
		health = 674,
		soulId = 1150,
		profession = HeroProfession.eCommander,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "你牵着我",
				factor = 0.1,
				heroList = {
					114
				}
			},
			{
				addType = 99,
				name = "你骑着我",
				factor = 0.1,
				heroList = {
					121
				}
			},
			{
				addType = 99,
				name = "远古渊源",
				factor = 0.15,
				heroList = {
					119,
					117
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+138}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【龙怒】提升至1级：",
					"每次增加自己{10}%暴击，降低对方{10}%韧性",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+179}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【护龙魂】提升5级：",
					"回复生命值提升{10%}，并提升{5%}的闪避加成概率及{5%}的加成值",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+186}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1150,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{10%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+193}"
					},
					attrDescList2 = {
						"韧性{+70}",
						"破击{+35}",
						"格挡{+71}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1150,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+200}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1150,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【龙怒】提升至2级：",
					"每次增加自己{20}%暴击，降低对方{20}%韧性",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+207}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1150,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【护龙魂】提升5级：",
					"回复生命值提升{10%}，并提升{5%}的闪避加成概率及{5%}的加成值",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+214}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1150,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{20%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+221}"
					},
					attrDescList2 = {
						"闪避{+63}",
						"韧性{+93}",
						"破击{+32}",
						"格挡{+123}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1150,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+228}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1150,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【龙怒】提升至3级：",
					"每次增加自己{30}%暴击，降低对方{30}%韧性",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+235}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1150,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【护龙魂】提升5级：",
					"回复生命值提升{10%}，并提升{5%}的闪避加成概率及{5%}的加成值",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+242}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1150,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+249}"
					},
					attrDescList2 = {
						"命中{+19}",
						"暴击{+19}",
						"韧性{+173}",
						"格挡{+168}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1150,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【护龙魂】提升1级：",
					"回复生命值提升{1%}，并提升{1%}的闪避加成概率及{1%}的加成值"
				}
			}
		},
		groupEquips = {
			{
				equipId = 213,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 219,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 206,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 227,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 222,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 233,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[116] = {
		mana = 244,
		name = "轩辕黄帝",
		talentId = 10058,
		baoji = 0,
		renxing = 0,
		normaldefense = 65,
		desc = "古华夏部落联盟首领，中国远古时代华夏民族的共主， 涿鹿之战打败了蚩尤部落，维持了对黄河中原地区的统治。",
		skillattack = 339,
		mingzhong = 0,
		physical = 125,
		skillId = 59,
		poji = 0,
		headerImage = "small_xuanyuanhuangdi.png",
		skilldefense = 131,
		strength = 243,
		shanbi = 0,
		rating = 8,
		pianXiang = "偏防御、全体、概率降攻",
		dropChapterId = 30069,
		normalattack = 169,
		agility = 93,
		animation = "xuanyuanhuangdi",
		gedang = 0,
		soulCount = 38,
		health = 750,
		soulId = 1160,
		profession = HeroProfession.eCommander,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "炎黄盟约",
				factor = 0.1,
				heroList = {
					117
				}
			},
			{
				addType = 99,
				name = "远古近今",
				factor = 0.1,
				heroList = {
					113
				}
			},
			{
				addType = 99,
				name = "假装认识",
				factor = 0.15,
				heroList = {
					118,
					120
				}
			},
			{
				addType = 99,
				name = "地界智者",
				factor = 0.15,
				heroList = {
					107
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+161}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【反震】提升至1级：",
					"受到普攻伤害时，反馈受到伤害的10%给对方，并获得相应的治疗",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+209}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【轩辕道】提升5级：",
					"轩辕道对敌方造成的法术伤害提升{15%}，降防概率提升{5%}",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+217}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1160,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{15%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+225}"
					},
					attrDescList2 = {
						"韧性{+83}",
						"破击{+40}",
						"格挡{+81}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1160,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+233}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1160,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【反震】提升至2级：",
					"受到普攻伤害时，反馈受到伤害的15%给对方，并获得相应的治疗",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+241}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1160,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【轩辕道】提升5级：",
					"轩辕道对敌方造成的法术伤害提升{15%}，降防概率提升{5%}",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+249}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1160,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+257}"
					},
					attrDescList2 = {
						"闪避{+71}",
						"韧性{+107}",
						"破击{+36}",
						"格挡{+148}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1160,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+266}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1160,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【反震】提升至3级：",
					"受到普攻伤害时，反馈受到伤害的20%给对方，并获得相应的治疗",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+274}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1160,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【轩辕道】提升5级：",
					"轩辕道对敌方造成的法术伤害提升{15%}，降防概率提升{5%}",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+282}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1160,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{45%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+290}"
					},
					attrDescList2 = {
						"命中{+23}",
						"暴击{+23}",
						"韧性{+203}",
						"格挡{+200}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1160,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【轩辕道】提升1级：",
					"轩辕道对敌方造成的法术伤害提升{1%}，降防概率提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 208,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 216,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 204,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 226,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 222,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 240,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[117] = {
		mana = 231,
		name = "神农炎帝",
		talentId = 10059,
		baoji = 0,
		renxing = 0,
		normaldefense = 59,
		desc = "神农部落的首领，专心传授农耕技巧，亲自尝试各种植物用来辨别药性，真是古代统治者的楷模。",
		skillattack = 337,
		mingzhong = 0,
		physical = 142,
		skillId = 60,
		poji = 0,
		headerImage = "small_shengnongyandi.png",
		skilldefense = 118,
		strength = 231,
		shanbi = 0,
		rating = 8,
		pianXiang = "偏防御、单体、沉默",
		dropChapterId = 30049,
		normalattack = 169,
		agility = 108,
		animation = "shennongyandi",
		gedang = 0,
		soulCount = 38,
		health = 854,
		soulId = 1170,
		profession = HeroProfession.eCommander,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "炎黄盟约",
				factor = 0.1,
				heroList = {
					116
				}
			},
			{
				addType = 99,
				name = "两宗圣人",
				factor = 0.1,
				heroList = {
					121
				}
			},
			{
				addType = 99,
				name = "假装认识",
				factor = 0.15,
				heroList = {
					119,
					115
				}
			},
			{
				addType = 99,
				name = "高祖之盟",
				factor = 0.15,
				heroList = {
					124
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+161}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【百草】提升至1级：",
					"生命值为0时，获得一次不死机会，同时吸取敌方生命回复自身生命上限{20}%",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+209}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【神农击】提升5级：",
					"神农击对敌方造成的法术伤害提升{15%}",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+217}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1170,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{15%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+225}"
					},
					attrDescList2 = {
						"命中{+41}",
						"韧性{+62}",
						"格挡{+101}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1170,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+233}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1170,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【百草】提升至2级：",
					"生命值为0时，获得一次不死机会，同时吸取敌方生命回复自身生命上限{30}%",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+241}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1170,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【神农击】提升5级：",
					"神农击对敌方造成的法术伤害提升{15%}",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+249}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1170,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+257}"
					},
					attrDescList2 = {
						"闪避{+110}",
						"韧性{+148}",
						"破击{+36}",
						"格挡{+72}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1170,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+266}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1170,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【百草】提升至3级：",
					"生命值为0时，获得一次不死机会，同时吸取敌方生命回复自身生命上限{50}%",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+274}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1170,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【神农击】提升5级：",
					"神农击对敌方造成的法术伤害提升{15%}",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+282}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1170,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{45%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+290}"
					},
					attrDescList2 = {
						"命中{+66}",
						"暴击{+23}",
						"韧性{+201}",
						"格挡{+158}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1170,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【神农击】提升1级：",
					"神农击对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 210,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 214,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 204,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 226,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 221,
				attrValue = 15,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 241,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[118] = {
		mana = 210,
		name = "平天大圣",
		talentId = 10056,
		baoji = 0,
		renxing = 0,
		normaldefense = 56,
		desc = "在获得魔界首领的职位后就一直不甘于天界的统治，使计策利用悟空和二郎神，妄图颠覆玉帝，成为三界之主。",
		skillattack = 292,
		mingzhong = 0,
		physical = 112,
		skillId = 57,
		poji = 0,
		headerImage = "small_pingtiandashen.png",
		skilldefense = 113,
		strength = 210,
		shanbi = 0,
		rating = 7,
		pianXiang = "偏防御、全体、概率降闪",
		dropChapterId = 30019,
		normalattack = 146,
		agility = 80,
		animation = "pingtiandashen",
		gedang = 0,
		soulCount = 36,
		health = 669,
		soulId = 1180,
		profession = HeroProfession.eCommander,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "义结金兰",
				factor = 0.1,
				heroList = {
					112
				}
			},
			{
				addType = 99,
				name = "吹笛牧牛",
				factor = 0.1,
				heroList = {
					119
				}
			},
			{
				addType = 99,
				name = "假装认识",
				factor = 0.15,
				heroList = {
					116,
					120
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+138}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【平天】提升至1级：",
					"发动攻击时，敌方怒气的增长值减少{60}%",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+179}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【铁蹄怒】提升5级：",
					"铁蹄怒对敌方造成的法术伤害提升{10%}，并提升{5%}的闪避削弱概率及削弱值",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+186}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1180,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{10%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+193}"
					},
					attrDescList2 = {
						"韧性{+69}",
						"破击{+36}",
						"格挡{+71}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1180,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+200}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1180,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【平天】提升至2级：",
					"发动攻击时，敌方怒气的增长值减少{80}%",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+207}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1180,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【铁蹄怒】提升5级：",
					"铁蹄怒对敌方造成的法术伤害提升{10%}，并提升{5%}的闪避削弱概率及削弱值",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+214}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1180,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{20%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+221}"
					},
					attrDescList2 = {
						"闪避{+61}",
						"韧性{+92}",
						"破击{+31}",
						"格挡{+124}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1180,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+228}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1180,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【平天】提升至3级：",
					"发动攻击时，敌方不增加怒气",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+235}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1180,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【铁蹄怒】提升5级：",
					"铁蹄怒对敌方造成的法术伤害提升{10%}，并提升{5%}的闪避削弱概率及削弱值",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+242}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1180,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+249}"
					},
					attrDescList2 = {
						"命中{+19}",
						"暴击{+20}",
						"韧性{+169}",
						"格挡{+175}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1180,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【铁蹄怒】提升1级：",
					"铁蹄怒对敌方造成的法术伤害提升{1%}，并提升{1%}的闪避削弱概率及削弱值"
				}
			}
		},
		groupEquips = {
			{
				equipId = 208,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 215,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 207,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 230,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 224,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 236,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[119] = {
		mana = 211,
		name = "太白金星",
		talentId = 10050,
		baoji = 0,
		renxing = 0,
		normaldefense = 47,
		desc = "天庭的丞相，为人和善，负责发布各种玉帝的指令，人人都非常尊敬他，可是这次到花果山却栽了个大跟头。",
		skillattack = 324,
		mingzhong = 0,
		physical = 88,
		skillId = 51,
		poji = 0,
		headerImage = "small_taibaijinxing.png",
		skilldefense = 103,
		strength = 191,
		shanbi = 0,
		rating = 7,
		pianXiang = "偏治疗、奶三人、解除异常",
		dropChapterId = 30029,
		normalattack = 147,
		agility = 98,
		animation = "taibaijinxing",
		gedang = 0,
		soulCount = 35,
		health = 527,
		soulId = 1190,
		profession = HeroProfession.eMage,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "吹笛牧牛",
				factor = 0.1,
				heroList = {
					118
				}
			},
			{
				addType = 99,
				name = "忘年之交",
				factor = 0.1,
				heroList = {
					112
				}
			},
			{
				addType = 99,
				name = "远古渊源",
				factor = 0.15,
				heroList = {
					115,
					117
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+138}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【启明】提升至1级：",
					"普通攻击敌方生命值最少目标，如杀死目标，回复自身生命上限的{20}%。",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+179}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【清心诀】提升5级：",
					"清心诀回复的生命值提升{10%}",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+186}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1190,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{10%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+193}"
					},
					attrDescList2 = {
						"命中{+36}",
						"暴击{+51}",
						"破击{+87}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1190,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+200}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1190,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【启明】提升至2级：",
					"普通攻击敌方生命值最少目标，如杀死目标，回复自身生命上限的{30}%。",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+207}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1190,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【清心诀】提升5级：",
					"清心诀回复的生命值提升{10%}",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+214}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1190,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{20%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+221}"
					},
					attrDescList2 = {
						"命中{+92}",
						"闪避{+32}",
						"暴击{+62}",
						"破击{+128}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1190,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+228}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1190,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【启明】提升至3级：",
					"普通攻击敌方生命值最少目标，如杀死目标，回复自身生命上限的{40}%",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+235}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1190,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【清心诀】提升5级：",
					"清心诀回复的生命值提升{10%}",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+242}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1190,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+249}"
					},
					attrDescList2 = {
						"命中{+56}",
						"暴击{+78}",
						"韧性{+76}",
						"破击{+173}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1190,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【清心诀】提升1级：",
					"清心诀回复的生命值提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 210,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 214,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 202,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 231,
				attrValue = 15,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 225,
				attrValue = 25,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 238,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[120] = {
		mana = 252,
		name = "地藏王",
		talentId = 10051,
		baoji = 0,
		renxing = 0,
		normaldefense = 57,
		desc = "地府的最高掌权者，为人低调和善，法力高深莫测，在三界五行中只有他的坐骑谛听和佛祖能够分辨出六耳猕猴。",
		skillattack = 412,
		mingzhong = 0,
		physical = 102,
		skillId = 52,
		poji = 0,
		headerImage = "small_dizhangwang.png",
		skilldefense = 114,
		strength = 223,
		shanbi = 0,
		rating = 8,
		pianXiang = "偏攻击、前排、概率封治疗",
		dropChapterId = 0,
		normalattack = 163,
		agility = 120,
		animation = "dizhangwang",
		gedang = 0,
		soulCount = 38,
		health = 610,
		soulId = 1200,
		profession = HeroProfession.eMage,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "好像认识",
				factor = 0.1,
				heroList = {
					113
				}
			},
			{
				addType = 99,
				name = "隔壁邻居",
				factor = 0.1,
				heroList = {
					114
				}
			},
			{
				addType = 99,
				name = "地狱使者",
				factor = 0.15,
				heroList = {
					122
				}
			},
			{
				addType = 99,
				name = "假装认识",
				factor = 0.15,
				heroList = {
					116,
					118
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+161}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【静虑】提升至1级：",
					"普通攻击时，有{60}%的概率给敌方附加断续状态，持续1回合。",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+209}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【安忍诀】提升5级：",
					"安忍诀对敌方造成的法术伤害提升{15%}",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+217}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1200,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{15%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+225}"
					},
					attrDescList2 = {
						"命中{+40}",
						"暴击{+102}",
						"破击{+60}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1200,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+233}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1200,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【静虑】提升至2级：",
					"普通攻击时，有{80}%的概率给敌方附加断续状态，持续1回合。",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+241}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1200,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【安忍诀】提升5级：",
					"安忍诀对敌方造成的法术伤害提升{15%}",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+249}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1200,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+257}"
					},
					attrDescList2 = {
						"命中{+143}",
						"闪避{+108}",
						"暴击{+37}",
						"破击{+73}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1200,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+266}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1200,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【静虑】提升至3级：",
					"普通攻击时，有{100}%的概率给敌方附加断续状态，持续1回合。",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+274}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1200,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【安忍诀】提升5级：",
					"安忍诀对敌方造成的法术伤害提升{15%}",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+282}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1200,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{45%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+290}"
					},
					attrDescList2 = {
						"命中{+161}",
						"暴击{+207}",
						"韧性{+23}",
						"破击{+68}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1200,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【安忍诀】提升1级：",
					"安忍诀对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 209,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 215,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 202,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 228,
				attrValue = 10,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 220,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 237,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[121] = {
		mana = 247,
		name = "玄奘法师",
		talentId = 10052,
		baoji = 0,
		renxing = 0,
		normaldefense = 55,
		desc = "佛祖弟子金蝉子转世，从小就命运多舛，励志要西去求取大乘佛法真经，据说吃了他可以长生不老，很受妖怪的喜欢。",
		skillattack = 379,
		mingzhong = 0,
		physical = 107,
		skillId = 53,
		poji = 0,
		headerImage = "small_sanzhangfashi.png",
		skilldefense = 121,
		strength = 224,
		shanbi = 0,
		rating = 8,
		pianXiang = "偏治疗、奶全体、加防回怒",
		dropChapterId = 30099,
		normalattack = 172,
		agility = 115,
		animation = "sanzhangfashi",
		gedang = 0,
		soulCount = 38,
		health = 643,
		soulId = 1210,
		profession = HeroProfession.eMage,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "两宗圣人",
				factor = 0.1,
				heroList = {
					117
				}
			},
			{
				addType = 99,
				name = "你骑着我",
				factor = 0.1,
				heroList = {
					115
				}
			},
			{
				addType = 99,
				name = "取经小队",
				factor = 0.2,
				heroList = {
					112,
					113,
					114
				}
			},
			{
				addType = 99,
				name = "心系苍生",
				factor = 0.15,
				heroList = {
					124
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+161}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【佛光】提升至1级：",
					"受到法术攻击时，伤害值有{20}%概率降为1点。",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+209}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【慈悲诀】提升5级：",
					"回复生命值提升{15%}，并提升{5%}的防御加成值",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+217}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1210,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{15%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+225}"
					},
					attrDescList2 = {
						"命中{+39}",
						"暴击{+61}",
						"破击{+99}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1210,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+233}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1210,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【佛光】提升至2级：",
					"受到法术攻击时，伤害值有{30}%概率降为1点。",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+241}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1210,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【慈悲诀】提升5级：",
					"回复生命值提升{15%}，并提升{5%}的防御加成值",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+249}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1210,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+257}"
					},
					attrDescList2 = {
						"命中{+111}",
						"闪避{+37}",
						"暴击{+72}",
						"破击{+143}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1210,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+266}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1210,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【佛光】提升至3级：",
					"受到法术攻击时，伤害值有{40}%概率降为1点。",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+274}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1210,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【慈悲诀】提升5级：",
					"回复生命值提升{15%}，并提升{5%}的防御加成值",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+282}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1210,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{45%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+290}"
					},
					attrDescList2 = {
						"命中{+69}",
						"暴击{+91}",
						"韧性{+89}",
						"破击{+201}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1210,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【慈悲诀】提升1级：",
					"回复生命值提升{1%}，并提升{1%}的防御加成值"
				}
			}
		},
		groupEquips = {
			{
				equipId = 209,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 214,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 202,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 228,
				attrValue = 15,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 221,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 232,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[122] = {
		mana = 247,
		name = "饕餮",
		talentId = 10065,
		baoji = 0,
		renxing = 0,
		normaldefense = 56,
		desc = "传说中的恶兽，十分贪吃而且性格贪婪，经常吞噬百姓的牲畜给百姓造成难以挽回的损失，所以他的名声不太好。",
		skillattack = 404,
		mingzhong = 0,
		physical = 101,
		skillId = 61,
		poji = 0,
		headerImage = "small_taotie.png",
		skilldefense = 112,
		strength = 219,
		shanbi = 0,
		rating = 8,
		pianXiang = "偏攻击、全体、概率降防",
		dropChapterId = 0,
		normalattack = 160,
		agility = 108,
		animation = "taotie",
		gedang = 0,
		soulCount = 38,
		health = 607,
		soulId = 1220,
		profession = HeroProfession.eMage,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "我不吃你",
				factor = 0.1,
				heroList = {
					123
				}
			},
			{
				addType = 99,
				name = "看你填海",
				factor = 0.1,
				heroList = {
					127
				}
			},
			{
				addType = 99,
				name = "上古众神",
				factor = 0.2,
				heroList = {
					126,
					130,
					131
				}
			},
			{
				addType = 99,
				name = "一起去吃",
				factor = 0.2,
				heroList = {
					120,
					109
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+161}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【盛宴】提升至1级：",
					"{100}%免疫一次群体攻击技能",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+209}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【恐惧咆哮】提升5级：",
					"恐惧咆哮对敌方造成的法术伤害提升{15%}，并提升{5%}的防御削弱值",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+217}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1220,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{15%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+225}"
					},
					attrDescList2 = {
						"命中{+42}",
						"暴击{+104}",
						"破击{+61}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1220,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+233}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1220,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【盛宴】提升至2级：",
					"{100}%免疫第一次群体攻击技能，且有{10}%概率免疫第二次群体攻击技能",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+241}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1220,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【恐惧咆哮】提升5级：",
					"恐惧咆哮对敌方造成的法术伤害提升{15%}，并提升{5%}的防御削弱值",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+249}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1220,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+257}"
					},
					attrDescList2 = {
						"命中{+145}",
						"闪避{+108}",
						"暴击{+36}",
						"破击{+75}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1220,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+266}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1220,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【盛宴】提升至3级：",
					"{100}%免疫第一次群体攻击技能，且有{10}%、{5}%概率免疫第二次、第三次群体攻击技能",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+274}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1220,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【恐惧咆哮】提升5级：",
					"恐惧咆哮对敌方造成的法术伤害提升{15%}，并提升{5%}的防御削弱值",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+282}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1220,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{45%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+290}"
					},
					attrDescList2 = {
						"命中{+155}",
						"暴击{+202}",
						"韧性{+23}",
						"破击{+69}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1220,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【恐惧咆哮】提升1级：",
					"恐惧咆哮对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 249,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 255,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 242,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 267,
				attrValue = 15,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 260,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 272,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[123] = {
		mana = 206,
		name = "盘古",
		talentId = 10063,
		baoji = 0,
		renxing = 0,
		normaldefense = 57,
		desc = "远古时期，天地一片混沌，混沌之中的巨人盘古用斧子劈开了混沌，才有了天地万物，人们称他为开天辟地第一神。",
		skillattack = 326,
		mingzhong = 0,
		physical = 109,
		skillId = 62,
		poji = 0,
		headerImage = "small_pangu.png",
		skilldefense = 97,
		strength = 252,
		shanbi = 0,
		rating = 8,
		pianXiang = "偏攻击、后排、概率减怒",
		dropChapterId = 40049,
		normalattack = 206,
		agility = 120,
		animation = "pangu",
		gedang = 0,
		soulCount = 38,
		health = 653,
		soulId = 1230,
		profession = HeroProfession.eWarrior,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "进化论",
				factor = 0.1,
				heroList = {
					125
				}
			},
			{
				addType = 99,
				name = "我不吃你",
				factor = 0.1,
				heroList = {
					122
				}
			},
			{
				addType = 99,
				name = "盘古有训",
				factor = 0.15,
				heroList = {
					128,
					127
				}
			},
			{
				addType = 99,
				name = "开天创世",
				factor = 0.15,
				heroList = {
					102
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+161}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【重击】提升至1级：",
					"普通攻击时，有30%的概率使敌方昏迷，持续1回合",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+209}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【开天地】提升5级：",
					"开天地对敌方造成的法术伤害提升{15%}，并提升{5%}的降怒概率",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+217}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1230,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{15%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+225}"
					},
					attrDescList2 = {
						"命中{+41}",
						"暴击{+99}",
						"破击{+63}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1230,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+233}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1230,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【重击】提升至2级：",
					"普通攻击时，有40%的概率使敌方昏迷，持续1回合",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+241}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1230,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【开天地】提升5级：",
					"开天地对敌方造成的法术伤害提升{15%}，并提升{5%}的降怒概率",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+249}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1230,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+257}"
					},
					attrDescList2 = {
						"命中{+144}",
						"闪避{+72}",
						"暴击{+109}",
						"破击{+37}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1230,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+266}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1230,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【重击】提升至3级：",
					"普通攻击时，有50%的概率使敌方昏迷，持续1回合",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+274}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1230,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【开天地】提升5级：",
					"开天地对敌方造成的法术伤害提升{15%}，并提升{5%}的降怒概率",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+282}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1230,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{45%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+290}"
					},
					attrDescList2 = {
						"命中{+109}",
						"暴击{+187}",
						"韧性{+47}",
						"破击{+117}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1230,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【开天地】提升1级：",
					"开天地对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 248,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 256,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 242,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 266,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 262,
				attrValue = 15,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 273,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[124] = {
		mana = 212,
		name = "大禹王",
		talentId = 10061,
		baoji = 0,
		renxing = 0,
		normaldefense = 59,
		desc = "夏朝的开国君主，曾接替父亲治理黄河，三过家门而不入，最后治水成功，将天下划分为九州，因此得到舜的看重，传位与他。",
		skillattack = 336,
		mingzhong = 0,
		physical = 114,
		skillId = 63,
		poji = 0,
		headerImage = "small_dayuwang.png",
		skilldefense = 100,
		strength = 259,
		shanbi = 0,
		rating = 8,
		pianXiang = "偏攻击、竖排、概率昏迷",
		dropChapterId = 40039,
		normalattack = 212,
		agility = 120,
		animation = "dayu",
		gedang = 0,
		soulCount = 38,
		health = 682,
		soulId = 1240,
		profession = HeroProfession.eWarrior,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "治不了你",
				factor = 0.1,
				heroList = {
					130
				}
			},
			{
				addType = 99,
				name = "远古世仇",
				factor = 0.1,
				heroList = {
					126
				}
			},
			{
				addType = 99,
				name = "看我治水",
				factor = 0.15,
				heroList = {
					129,
					125
				}
			},
			{
				addType = 99,
				name = "绝对崇拜",
				factor = 0.15,
				heroList = {
					102
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+161}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【仁德】提升至1级：",
					"每次发动攻击后，增加自身攻击力的{15}%，最多75%直至死亡",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+209}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【治水诀】提升5级：",
					"治水诀对敌方造成的法术伤害提升{15%}，并提升{5%}的昏迷概率",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+217}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1240,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{15%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+225}"
					},
					attrDescList2 = {
						"命中{+39}",
						"暴击{+101}",
						"破击{+63}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1240,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+233}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1240,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【仁德】提升至2级：",
					"每次发动攻击后，增加自身攻击力的{20}%，最多75%直至死亡",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+241}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1240,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【治水诀】提升5级：",
					"治水诀对敌方造成的法术伤害提升{15%}，并提升{5%}的昏迷概率",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+249}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1240,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+257}"
					},
					attrDescList2 = {
						"命中{+144}",
						"闪避{+70}",
						"暴击{+112}",
						"破击{+36}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1240,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+266}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1240,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【仁德】提升至3级：",
					"每次发动攻击后，增加自身攻击力的{25}%，最多75%直至死亡",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+274}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1240,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【治水诀】提升5级：",
					"治水诀对敌方造成的法术伤害提升{15%}，并提升{5%}的昏迷概率",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+282}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1240,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{45%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+290}"
					},
					attrDescList2 = {
						"命中{+108}",
						"暴击{+181}",
						"韧性{+44}",
						"破击{+110}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1240,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【治水诀】提升1级：",
					"治水诀对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 248,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 255,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 243,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 266,
				attrValue = 25,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 262,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 274,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[125] = {
		mana = 183,
		name = "六耳猕猴",
		talentId = 10062,
		baoji = 0,
		renxing = 0,
		normaldefense = 47,
		desc = "善聆听，知前后，万物皆明。跑去模仿孙悟空，想自己去取经。可惜猜中了开头却没猜中结尾。",
		skillattack = 282,
		mingzhong = 0,
		physical = 102,
		skillId = 64,
		poji = 0,
		headerImage = "small_liuermihou1.png",
		skilldefense = 89,
		strength = 203,
		shanbi = 0,
		rating = 7,
		pianXiang = "偏攻击、单体、降防减怒",
		dropChapterId = 30019,
		normalattack = 163,
		agility = 110,
		animation = "liuermihou",
		gedang = 0,
		soulCount = 35,
		health = 614,
		soulId = 1250,
		profession = HeroProfession.eWarrior,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "假小叔子",
				factor = 0.1,
				heroList = {
					131
				}
			},
			{
				addType = 99,
				name = "进化论",
				factor = 0.1,
				heroList = {
					123
				}
			},
			{
				addType = 99,
				name = "看我治水",
				factor = 0.15,
				heroList = {
					129,
					124
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+138}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【化形】提升至1级：",
					"每杀死一个目标后，普攻法攻提升20%",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+179}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【猴王击】提升5级：",
					"猴王击对敌方造成的法术伤害提升{10%}，降防概率提升{5%}",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+186}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1250,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{10%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+193}"
					},
					attrDescList2 = {
						"命中{+85}",
						"暴击{+53}",
						"破击{+36}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1250,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+200}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1250,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【化形】提升至2级：",
					"每杀死一个目标后，普攻法攻提升25%",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+207}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1250,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【猴王击】提升5级：",
					"猴王击对敌方造成的法术伤害提升{10%}，降防概率提升{5%}",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+214}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1250,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{20%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+221}"
					},
					attrDescList2 = {
						"命中{+93}",
						"暴击{+32}",
						"破击{+121}",
						"格挡{+64}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1250,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+228}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1250,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【化形】提升至3级：",
					"每杀死一个目标后，普攻法攻提升30%",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+235}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1250,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【猴王击】提升5级：",
					"猴王击对敌方造成的法术伤害提升{10%}，降防概率提升{5%}",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+242}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1250,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+249}"
					},
					attrDescList2 = {
						"命中{+159}",
						"闪避{+38}",
						"韧性{+38}",
						"破击{+159}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1250,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【猴王击】提升1级：",
					"猴王击对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 248,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 254,
				attrValue = 10,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 242,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalAttack
			},
			{
				equipId = 266,
				attrValue = 25,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 261,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 275,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[126] = {
		mana = 174,
		name = "刑天",
		talentId = 10064,
		baoji = 0,
		renxing = 0,
		normaldefense = 48,
		desc = "炎帝部落的战神，曾经以一己之力战胜了黄帝的几位大将，后被黄帝使计斩下头颅埋入山中，悲愤的刑天以双乳为眼，肚脐为口，战斗不止。",
		skillattack = 275,
		mingzhong = 0,
		physical = 96,
		skillId = 65,
		poji = 0,
		headerImage = "small_xingtian.png",
		skilldefense = 82,
		strength = 213,
		shanbi = 0,
		rating = 7,
		pianXiang = "偏攻击、斩杀、概率沉默",
		dropChapterId = 30029,
		normalattack = 174,
		agility = 104,
		animation = "xingtian",
		gedang = 0,
		soulCount = 36,
		health = 574,
		soulId = 1260,
		profession = HeroProfession.eWarrior,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "远古世仇",
				factor = 0.1,
				heroList = {
					124
				}
			},
			{
				addType = 99,
				name = "终于倒下",
				factor = 0.1,
				heroList = {
					128
				}
			},
			{
				addType = 99,
				name = "上古众神",
				factor = 0.2,
				heroList = {
					130,
					122,
					131
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+138}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【狂暴】提升至1级：",
					"生命值每损失5%，攻击力提升{10}%，最多100%直至死亡",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+179}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【舞干戚】提升5级：",
					"舞干戚对敌方造成的法术伤害提升{10%}，并提升{5%}的昏迷概率",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+186}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1260,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{10%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+193}"
					},
					attrDescList2 = {
						"命中{+35}",
						"暴击{+85}",
						"破击{+54}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1260,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+200}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1260,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【狂暴】提升至2级：",
					"生命值每损失5%，攻击力提升{15}%，最多100%直至死亡",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+207}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1260,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【舞干戚】提升5级：",
					"舞干戚对敌方造成的法术伤害提升{10%}，并提升{5%}的昏迷概率",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+214}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1260,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{20%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+221}"
					},
					attrDescList2 = {
						"命中{+126}",
						"闪避{+64}",
						"暴击{+93}",
						"破击{+32}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1260,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于法师的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+228}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1260,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【狂暴】提升至3级：",
					"生命值每损失5%，攻击力提升{20}%，最多100%直至死亡",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+235}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1260,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【舞干戚】提升5级：",
					"舞干戚对敌方造成的法术伤害提升{10%}，并提升{5%}的昏迷概率",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+242}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1260,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+249}"
					},
					attrDescList2 = {
						"命中{+98}",
						"暴击{+152}",
						"韧性{+38}",
						"破击{+93}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1260,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【舞干戚】提升1级：",
					"舞干戚对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 251,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 256,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 245,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 269,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 260,
				attrValue = 15,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 276,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[127] = {
		mana = 197,
		name = "精卫",
		talentId = 10070,
		baoji = 0,
		renxing = 0,
		normaldefense = 50,
		desc = "炎帝的小女儿，一位美丽的女神，到东海游玩时不幸溺水，化为了一只精卫鸟，每天都要口衔一颗石子投入东海，誓要将东海填平。",
		skillattack = 288,
		mingzhong = 0,
		physical = 116,
		skillId = 66,
		poji = 0,
		headerImage = "small_jingwei.png",
		skilldefense = 101,
		strength = 197,
		shanbi = 0,
		rating = 7,
		pianXiang = "偏防御、奶前排、加闪加韧",
		dropChapterId = 20109,
		normalattack = 144,
		agility = 85,
		animation = "jinwei",
		gedang = 0,
		soulCount = 35,
		health = 696,
		soulId = 1270,
		profession = HeroProfession.eCommander,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "以水为媒",
				factor = 0.1,
				heroList = {
					129
				}
			},
			{
				addType = 99,
				name = "看你填海",
				factor = 0.1,
				heroList = {
					122
				}
			},
			{
				addType = 99,
				name = "盘古有训",
				factor = 0.15,
				heroList = {
					128,
					123
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+138}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【余浪】提升至1级：",
					"当被攻击死亡时，我方其他全部武将生命值回复{40}%",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+179}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【填海诀】提升5级：",
					"填海诀回复的血量提升{10%}，增加闪避和韧性的概率提升{5%}",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+186}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1270,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{10%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+193}"
					},
					attrDescList2 = {
						"命中{+35}",
						"韧性{+50}",
						"格挡{+84}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1270,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+200}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1270,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【余浪】提升至2级：",
					"当被攻击死亡时，我方其他全部武将生命值回复{50}%",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+207}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1270,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【填海诀】提升5级：",
					"填海诀回复的血量提升{10%}，增加闪避和韧性的概率提升{5%}",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+214}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1270,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{20%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+221}"
					},
					attrDescList2 = {
						"闪避{+94}",
						"韧性{+128}",
						"破击{+32}",
						"格挡{+62}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1270,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+228}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1270,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【余浪】提升至3级：",
					"当被攻击死亡时，我方其他全部武将生命值回复{60}%",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+235}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1270,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【填海诀】提升5级：",
					"填海诀回复的血量提升{10%}，增加闪避和韧性的概率提升{5%}",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+242}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1270,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+249}"
					},
					attrDescList2 = {
						"命中{+57}",
						"暴击{+19}",
						"韧性{+168}",
						"格挡{+136}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1270,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【填海诀】提升1级：",
					"填海诀回复的血量提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 252,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 257,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 246,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 270,
				attrValue = 15,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 263,
				attrValue = 25,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 277,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[128] = {
		mana = 256,
		name = "九天玄女",
		talentId = 10067,
		baoji = 0,
		renxing = 0,
		normaldefense = 58,
		desc = "中国上古神话中的战争女神，曾传授黄帝兵法，帮助黄帝打败了蚩尤，一统华夏。她本体原为一只玄鸟，后来生下契为商朝始祖。",
		skillattack = 419,
		mingzhong = 0,
		physical = 106,
		skillId = 67,
		poji = 0,
		headerImage = "small_jiutianxuannv.png",
		skilldefense = 116,
		strength = 227,
		shanbi = 0,
		rating = 8,
		pianXiang = "偏治疗、奶全体、解除异常",
		dropChapterId = 40019,
		normalattack = 166,
		agility = 109,
		animation = "jiutianxuannv",
		gedang = 0,
		soulCount = 38,
		health = 634,
		soulId = 1280,
		profession = HeroProfession.eMage,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "美如画",
				factor = 0.1,
				heroList = {
					130
				}
			},
			{
				addType = 99,
				name = "终于倒下",
				factor = 0.1,
				heroList = {
					126
				}
			},
			{
				addType = 99,
				name = "盘古有训",
				factor = 0.15,
				heroList = {
					127,
					123
				}
			},
			{
				addType = 99,
				name = "养生之道",
				factor = 0.15,
				heroList = {
					116
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+161}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【玄鸟】提升至1级：",
					"生命值为0时，获得一次不死机会，同时吸取敌方生命回复自身生命上限20%",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+209}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【奇门遁甲】提升5级：",
					"奇门遁甲回复的血量提升{15%}，解除异常状态的概率提升{5%}",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+217}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1280,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{15%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+225}"
					},
					attrDescList2 = {
						"命中{+40}",
						"暴击{+102}",
						"破击{+63}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1280,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+233}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1280,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【玄鸟】提升至2级：",
					"生命值为0时，获得一次不死机会，同时吸取敌方生命回复自身生命上限30%",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+241}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1280,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【奇门遁甲】提升5级：",
					"奇门遁甲回复的血量提升{15%}，解除异常状态的概率提升{5%}",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+249}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1280,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+257}"
					},
					attrDescList2 = {
						"命中{+151}",
						"闪避{+107}",
						"暴击{+37}",
						"破击{+72}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1280,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+266}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1280,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【玄鸟】提升至3级：",
					"生命值为0时，首次不死，同时吸取敌方生命回复自身生命上限50%，第二次仍可保留1点生命不死",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+274}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1280,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【奇门遁甲】提升5级：",
					"奇门遁甲回复的血量提升{15%}，解除异常状态的概率提升{5%}",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+282}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1280,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{45%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+290}"
					},
					attrDescList2 = {
						"命中{+159}",
						"暴击{+205}",
						"韧性{+23}",
						"破击{+69}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1280,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【奇门遁甲】提升1级：",
					"奇门遁甲回复的血量提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 249,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 254,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 243,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 267,
				attrValue = 10,
				attrType = BattleAttrsType.eSpeed
			},
			{
				equipId = 261,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillAttack
			},
			{
				equipId = 278,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[129] = {
		mana = 207,
		name = "共工",
		talentId = 10068,
		baoji = 0,
		renxing = 0,
		normaldefense = 53,
		desc = "中国古代神话中的水神，掌控洪水，与火神祝融不合，屡战不胜，遂心生怒火，撞断不周山，导致天塌下来半边，后来才有女娲炼石补天。",
		skillattack = 303,
		mingzhong = 0,
		physical = 114,
		skillId = 68,
		poji = 0,
		headerImage = "small_gonggong.png",
		skilldefense = 106,
		strength = 208,
		shanbi = 0,
		rating = 7,
		pianXiang = "偏防御、全体、概率降闪",
		dropChapterId = 20089,
		normalattack = 152,
		agility = 84,
		animation = "gonggong",
		gedang = 0,
		soulCount = 35,
		health = 686,
		soulId = 1290,
		profession = HeroProfession.eCommander,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "以水为媒",
				factor = 0.1,
				heroList = {
					127
				}
			},
			{
				addType = 99,
				name = "灭火小队",
				factor = 0.1,
				heroList = {
					131
				}
			},
			{
				addType = 99,
				name = "看我治水",
				factor = 0.15,
				heroList = {
					124,
					125
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+138}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【水德】提升至1级：",
					"发动攻击时，降低敌方怒气增加值60%",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+179}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【天柱折】提升5级：",
					"天柱折对敌方造成的法术伤害提升{10%}，降低闪避的概率提升{5%}",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+186}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1290,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{10%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+193}"
					},
					attrDescList2 = {
						"命中{+33}",
						"韧性{+54}",
						"格挡{+84}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1290,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+200}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1290,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【水德】提升至2级：",
					"发动攻击时，降低敌方怒气增加值80%",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+207}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1290,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【天柱折】提升5级：",
					"天柱折对敌方造成的法术伤害提升{10%}，降低闪避的概率提升{5%}",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+214}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1290,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{20%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+221}"
					},
					attrDescList2 = {
						"闪避{+93}",
						"韧性{+129}",
						"破击{+32}",
						"格挡{+65}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1290,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+228}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1290,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【水德】提升至3级：",
					"发动攻击时，敌方不增加怒气",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+235}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1290,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【天柱折】提升5级：",
					"天柱折对敌方造成的法术伤害提升{10%}，降低闪避的概率提升{5%}",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+242}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1290,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+249}"
					},
					attrDescList2 = {
						"命中{+55}",
						"暴击{+19}",
						"韧性{+177}",
						"格挡{+139}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1290,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【天柱折】提升1级：",
					"天柱折对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 250,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 258,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 247,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 268,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 264,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 279,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[130] = {
		mana = 250,
		name = "洛神",
		talentId = 10069,
		baoji = 0,
		renxing = 0,
		normaldefense = 67,
		desc = "洛神，又名宓妃，中国远古神话传说中的女神。乃伏羲氏之女，因迷恋洛河两岸的美丽景色，降临人间，来到洛阳居住。",
		skillattack = 348,
		mingzhong = 0,
		physical = 128,
		skillId = 69,
		poji = 0,
		headerImage = "small_luoshen.png",
		skilldefense = 134,
		strength = 250,
		shanbi = 0,
		rating = 8,
		pianXiang = "偏防御、奶自身、加防",
		dropChapterId = 40029,
		normalattack = 174,
		agility = 90,
		animation = "luoshen",
		gedang = 0,
		soulCount = 38,
		health = 766,
		soulId = 1300,
		profession = HeroProfession.eCommander,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "治不了你",
				factor = 0.1,
				heroList = {
					124
				}
			},
			{
				addType = 99,
				name = "美如画",
				factor = 0.1,
				heroList = {
					128
				}
			},
			{
				addType = 99,
				name = "上古众神",
				factor = 0.2,
				heroList = {
					126,
					122,
					131
				}
			},
			{
				addType = 99,
				name = "贪恋人间",
				factor = 0.15,
				heroList = {
					116
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+161}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【蔽月】提升至1级：",
					"{100}%为队友承受第一次致命伤害并至少保留1点生命值",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+209}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【流风回雪】提升5级：",
					"流风回雪回复血量提升{15%}，防御值增加提升{5%}",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+217}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1300,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{15%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+225}"
					},
					attrDescList2 = {
						"韧性{+80}",
						"破击{+42}",
						"格挡{+81}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1300,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+233}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1300,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【蔽月】提升至2级：",
					"{100}%为队友承受第一次致命伤害并至少保留1点生命值，且有{30}%概率为队友承受第二次致命伤害并至少保留1点生命值",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+241}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1300,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【流风回雪】提升5级：",
					"流风回雪回复血量提升{15%}，防御值增加提升{5%}",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+249}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1300,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+257}"
					},
					attrDescList2 = {
						"闪避{+74}",
						"韧性{+113}",
						"破击{+38}",
						"格挡{+148}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1300,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于战神的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+266}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1300,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【蔽月】提升至3级：",
					"{100}%为队友承受第一次致命伤害并至少保留1点生命值，且有{30}%、{10}%概率为队友承受第二次、第三次致命伤害并至少保留1点生命值",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+274}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1300,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【流风回雪】提升5级：",
					"流风回雪回复血量提升{15%}，防御值增加提升{5%}",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+282}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1300,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{45%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+290}"
					},
					attrDescList2 = {
						"命中{+23}",
						"暴击{+22}",
						"韧性{+205}",
						"格挡{+204}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1300,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【流风回雪】提升1级：",
					"流风回雪回复血量提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 250,
				attrValue = 20,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 254,
				attrValue = 15,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 244,
				attrValue = 10,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 268,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 260,
				attrValue = 15,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 280,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	},
	[131] = {
		mana = 226,
		name = "铁扇公主",
		talentId = 10066,
		baoji = 0,
		renxing = 0,
		normaldefense = 50,
		desc = "得道的仙人，长得漂亮俊俏，与牛魔王是结发夫妻，生有一子红孩儿，拥有法宝芭蕉扇，据说太上老君也有一个芭蕉扇。",
		skillattack = 347,
		mingzhong = 0,
		physical = 83,
		skillId = 70,
		poji = 0,
		headerImage = "small_tieshangognzhu.png",
		skilldefense = 110,
		strength = 205,
		shanbi = 0,
		rating = 7,
		pianXiang = "偏攻击、全体、降闪降韧",
		dropChapterId = 20099,
		normalattack = 158,
		agility = 102,
		animation = "tieshangongzhu",
		gedang = 0,
		soulCount = 35,
		health = 498,
		soulId = 1310,
		profession = HeroProfession.eMage,
		quality = QualityType.eOrange,
		groupAttrs = {
			{
				addType = 99,
				name = "灭火小队",
				factor = 0.1,
				heroList = {
					129
				}
			},
			{
				addType = 99,
				name = "假小叔子",
				factor = 0.1,
				heroList = {
					125
				}
			},
			{
				addType = 99,
				name = "上古众神",
				factor = 0.2,
				heroList = {
					130,
					126,
					122
				}
			}
		},
		rebirthList = {
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 60,
				talentDescIndex = 0,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{20%}",
					"1级高阶狂化，战斗中少量提升主将属性",
					attrDescList1 = {
						"潜力点{+80}",
						"基础战力值{+138}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 90,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@天赋法术【扇风】提升至1级：",
					"每次被攻击后，增加自身{10}%的速度和20点怒气",
					attrDescList1 = {
						"潜力点{+100}",
						"基础战力值{+179}"
					}
				}
			},
			{
				dobyChanged = false,
				animation = "dengji1",
				mateCount = 120,
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"@怒气法术【芭蕉扇】提升5级：",
					"芭蕉扇对敌方造成的法术伤害提升{10%}，降低闪避和韧性的概率提升{5%}",
					attrDescList1 = {
						"潜力点{+120}",
						"基础战力值{+186}"
					}
				}
			},
			{
				soulCount = 16,
				soulId = 1310,
				mateCount = 150,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{10%}",
					attrDescList1 = {
						"潜力点{+140}",
						"基础战力值{+193}"
					},
					attrDescList2 = {
						"命中{+34}",
						"暴击{+51}",
						"破击{+84}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1310,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 1,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{40%}",
					"2级高阶狂化，战斗中中量提升主将属性",
					attrDescList1 = {
						"潜力点{+180}",
						"基础战力值{+200}"
					}
				}
			},
			{
				soulCount = 24,
				soulId = 1310,
				mateCount = 250,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@天赋法术【扇风】提升至2级：",
					"每次被攻击后，增加自身{20}%的速度和30点怒气",
					attrDescList1 = {
						"潜力点{+200}",
						"基础战力值{+207}"
					}
				}
			},
			{
				soulCount = 28,
				soulId = 1310,
				mateCount = 300,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"@怒气法术【芭蕉扇】提升5级：",
					"芭蕉扇对敌方造成的法术伤害提升{10%}，降低闪避和韧性的概率提升{5%}",
					attrDescList1 = {
						"潜力点{+220}",
						"基础战力值{+214}"
					}
				}
			},
			{
				soulCount = 32,
				soulId = 1310,
				mateCount = 350,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{20%}",
					attrDescList1 = {
						"潜力点{+240}",
						"基础战力值{+221}"
					},
					attrDescList2 = {
						"命中{+91}",
						"闪避{+31}",
						"暴击{+60}",
						"破击{+124}"
					}
				}
			},
			{
				soulCount = 36,
				soulId = 1310,
				mateCount = 430,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 2,
				mateId = 200125,
				desc = {
					"对于御士的克制效果提升至{60%}",
					"3级高阶狂化，战斗中大量提升主将属性",
					attrDescList1 = {
						"潜力点{+280}",
						"基础战力值{+228}"
					}
				}
			},
			{
				soulCount = 40,
				soulId = 1310,
				mateCount = 510,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@天赋法术【扇风】提升至3级：",
					"每次被攻击后，增加自身{30}%的速度和40点怒气",
					attrDescList1 = {
						"潜力点{+300}",
						"基础战力值{+235}"
					}
				}
			},
			{
				soulCount = 44,
				soulId = 1310,
				mateCount = 590,
				dobyChanged = false,
				animation = "dengji1",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"@怒气法术【芭蕉扇】提升5级：",
					"芭蕉扇对敌方造成的法术伤害提升{10%}，降低闪避和韧性的概率提升{5%}",
					attrDescList1 = {
						"潜力点{+320}",
						"基础战力值{+242}"
					}
				}
			},
			{
				soulCount = 48,
				soulId = 1310,
				mateCount = 670,
				dobyChanged = true,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"职业被克制效果降低{30%}",
					attrDescList1 = {
						"潜力点{+340}",
						"基础战力值{+249}"
					},
					attrDescList2 = {
						"命中{+59}",
						"暴击{+77}",
						"韧性{+80}",
						"破击{+170}"
					}
				}
			},
			{
				soulCount = 20,
				soulId = 1310,
				mateCount = 200,
				dobyChanged = false,
				animation = "dengji2",
				talentDescIndex = 3,
				mateId = 200125,
				desc = {
					"潜力点{+220}",
					"@怒气法术【芭蕉扇】提升1级：",
					"芭蕉扇对敌方造成的法术伤害提升{1%}"
				}
			}
		},
		groupEquips = {
			{
				equipId = 253,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 259,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 244,
				attrValue = 15,
				attrType = BattleAttrsType.eSkillDefense
			},
			{
				equipId = 271,
				attrValue = 20,
				attrType = BattleAttrsType.eNormalDefense
			},
			{
				equipId = 265,
				attrValue = 10,
				attrType = BattleAttrsType.eHealth
			},
			{
				equipId = 281,
				attrValue = 10,
				attrType = BattleAttrsType.eGlobal
			}
		}
	}
}
SkillType = {
	eTalent = 3,
	eNormal = 1,
	eRage = 2
}
BaseSkills = {
	{
		name = "普通攻击",
		skillNameImage = "",
		headerImage = "",
		desc = "技能描述，暂缺",
		type = SkillType.eNormal,
		quality = QualityType.eNone
	},
	{
		name = "断魂刺",
		skillNameImage = "battle_text_012.png",
		headerImage = "skill_2.png",
		desc = "对敌方单体造成{100+1*(sl-1)}%法攻伤害",
		type = SkillType.eRage,
		quality = QualityType.eGreen
	},
	{
		name = "生肌术",
		skillNameImage = "battle_text_013.png",
		headerImage = "skill_3.png",
		desc = "回复自身生命（{75+1*(sl-1)}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.eGreen
	},
	{
		name = "破天一击",
		skillNameImage = "battle_text_014.png",
		headerImage = "skill_4.png",
		desc = "对敌方单人造成{100+1*(sl-1)}%法攻伤害",
		type = SkillType.eRage,
		quality = QualityType.eGreen
	},
	{
		name = "长虹贯日",
		skillNameImage = "battle_text_015.png",
		headerImage = "skill_5.png",
		desc = "对敌方一列目标造成{0.8*(100+1*(sl-1))}%法攻伤害",
		type = SkillType.eRage,
		quality = QualityType.eGreen
	},
	{
		name = "心炎诀",
		skillNameImage = "battle_text_016.png",
		headerImage = "skill_3.png",
		desc = "对敌方单人造成{100+1*(sl-1)}%法攻伤害",
		type = SkillType.eRage,
		quality = QualityType.eGreen
	},
	{
		name = "百花诀",
		skillNameImage = "battle_text_017.png",
		headerImage = "skill_5.png",
		desc = "回复生命值损失最多的单位血量（{75+1*(sl-1)}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.eGreen
	},
	{
		name = "五鬼动",
		skillNameImage = "battle_text_018.png",
		headerImage = "skill_8.png",
		desc = "增加2回合后排普攻（{0.09*(100+1*(sl-1))}%法攻）和法攻（{0.18*(100+1*(sl-1))}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.eBlue
	},
	{
		name = "红鸾帐",
		skillNameImage = "battle_text_019.png",
		headerImage = "skill_9.png",
		desc = "对敌方前排造成{0.75*(100+1*(sl-1))}%法攻伤害",
		type = SkillType.eRage,
		quality = QualityType.eBlue
	},
	{
		name = "百鬼行",
		skillNameImage = "battle_text_020.png",
		headerImage = "skill_10.png",
		desc = "对敌方横排造成{0.80*(100+1*(sl-1))}%法攻伤害",
		type = SkillType.eRage,
		quality = QualityType.eBlue
	},
	{
		name = "冲冠怒",
		skillNameImage = "battle_text_021.png",
		headerImage = "skill_11.png",
		desc = "增加我方两名主将{30+1*(sl-1)}点怒气值",
		type = SkillType.eRage,
		quality = QualityType.eBlue
	},
	{
		name = "玄元击",
		skillNameImage = "battle_text_022.png",
		headerImage = "skill_8.png",
		desc = "对敌方生命值最多的单位造成{100+1*(sl-1)}%法攻伤害",
		type = SkillType.eRage,
		quality = QualityType.eBlue
	},
	{
		name = "横扫千军",
		skillNameImage = "battle_text_023.png",
		headerImage = "skill_9.png",
		desc = "对敌方前排造成{0.75*({100+1*(sl-1))}%法攻伤害",
		type = SkillType.eRage,
		quality = QualityType.eBlue
	},
	{
		name = "四海潮涌",
		skillNameImage = "battle_text_024.png",
		headerImage = "skill_10.png",
		desc = "对后排敌人造成{0.75*(100+1*(sl-1))}%法攻伤害",
		type = SkillType.eRage,
		quality = QualityType.eBlue
	},
	{
		name = "九头断魄",
		skillNameImage = "battle_text_025.png",
		headerImage = "skill_11.png",
		desc = "对敌方生命值最少的单位造成{100+1*(sl-1)}%法攻伤害",
		type = SkillType.eRage,
		quality = QualityType.eBlue
	},
	{
		name = "红莲业火",
		skillNameImage = "battle_text_026.png",
		headerImage = "skill_8.png",
		desc = "对敌方单人造成{100+1*(sl-1)}%法攻伤害，并降低敌方{40+1*(sl-1)}点怒气值",
		type = SkillType.eRage,
		quality = QualityType.eBlue
	},
	{
		name = "九阳诀",
		skillNameImage = "battle_text_027.png",
		headerImage = "skill_9.png",
		desc = "对敌方后排造成{0.75*(100+1*(sl-1))}%法攻伤害",
		type = SkillType.eRage,
		quality = QualityType.eBlue
	},
	{
		name = "天机诀",
		skillNameImage = "battle_text_028.png",
		headerImage = "skill_10.png",
		desc = "治疗我方生命值损失最多的单位血量（{0.75*(100+1*(sl-1))}%法攻），并增加其2回合普防（{0.11*(100+1*(sl-1))}%法攻）和法防（{0.22*(100+1*(sl-1))}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.eBlue
	},
	{
		name = "雨荷诀",
		skillNameImage = "battle_text_029.png",
		headerImage = "skill_11.png",
		desc = "治疗我方生命值损失最多的3个单位血量（{0.55*(100+1*(sl-1))}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.eBlue
	},
	{
		name = "寒月诀",
		skillNameImage = "battle_text_030.png",
		headerImage = "skill_8.png",
		desc = "对敌方随机2~3个目标造成{0.78*(100+1*(sl-1))}%法攻伤害",
		type = SkillType.eRage,
		quality = QualityType.eBlue
	},
	{
		name = "镇塔诀",
		skillNameImage = "battle_text_031.png",
		headerImage = "skill_9.png",
		desc = "增加前排2回合普防（{0.11*(100+1*(sl-1))}%法攻）和法防（{0.22*(100+1*(sl-1))}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.eBlue
	},
	{
		name = "封神击",
		skillNameImage = "battle_text_032.png",
		headerImage = "skill_22.png",
		desc = "对敌方前排单位造成{0.75*(100+1*(sl-1))}%法攻伤害，并减低{30*(1+0.01*(sl-1))}点怒气值",
		type = SkillType.eRage,
		quality = QualityType.ePurple
	},
	{
		name = "天子怒",
		skillNameImage = "battle_text_033.png",
		headerImage = "skill_23.png",
		desc = "增加我方全体{20*(1+0.01*(sl-1))}点怒气值",
		type = SkillType.eRage,
		quality = QualityType.ePurple
	},
	{
		name = "牛魔劲",
		skillNameImage = "battle_text_034.png",
		headerImage = "skill_24.png",
		desc = "对敌方一列单位造成{0.8*(100+1*(sl-1))}%法攻伤害，并降低其2回合普攻（{0.08*(100+1*(sl-1))}%法攻）和法攻（{0.17*(100+1*(sl-1))}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.ePurple
	},
	{
		name = "化身无穷",
		skillNameImage = "battle_text_035.png",
		headerImage = "skill_25.png",
		desc = "对敌方全体造成{0.5*(100+1*(sl-1))}%法攻伤害",
		type = SkillType.eRage,
		quality = QualityType.ePurple
	},
	{
		name = "千羽破甲",
		skillNameImage = "battle_text_036.png",
		headerImage = "skill_26.png",
		desc = "对敌方前排造成{0.75*(100+1*(sl-1))}%法攻伤害，并有{50*(1+0.01*(sl-1))}%的概率降低3回合普防（{0.06*(100+1*(sl-1))}%）和法防（{0.11*(100+1*(sl-1))}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.ePurple
	},
	{
		name = "九黎战魂",
		skillNameImage = "battle_text_037.png",
		headerImage = "skill_27.png",
		desc = "有50%概率直接造成敌人当前生命25%的伤害,当技能伤害超出敌方生命的25%时,造成{100+1*(sl-1)}%法攻伤害",
		type = SkillType.eRage,
		quality = QualityType.ePurple
	},
	{
		name = "瑶池诀",
		skillNameImage = "battle_text_038.png",
		headerImage = "skill_28.png",
		desc = "治疗生命值损失最多的3个单位血量（{0.55*(100+1*(sl-1))}%法攻），并有{50*(1+(sl-1)*0.01)}%概率增加2回合闪避（{(100+1*(sl-1))/32}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.ePurple
	},
	{
		name = "菩提诀",
		skillNameImage = "battle_text_039.png",
		headerImage = "skill_29.png",
		desc = "治疗生命值损失最多的3个单位血量（{0.55*(100+1*(sl-1))}%法攻），并有{49+1*sl}%概率增加3回合格挡（{(100+1*(sl-1))/28}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.ePurple
	},
	{
		name = "化气诀",
		skillNameImage = "battle_text_040.png",
		headerImage = "skill_30.png",
		desc = "对敌方后排造成{0.75*(100+1*(sl-1))}%法攻伤害，并降低其{30+1*(sl-1)}点怒气值",
		type = SkillType.eRage,
		quality = QualityType.ePurple
	},
	{
		name = "至尊令",
		skillNameImage = "battle_text_041.png",
		headerImage = "skill_31.png",
		desc = "对敌方全体造成{0.65*(100+3*(sl-1))}%法攻伤害，并有{0.5*(100+1*(sl-1))}%的概率解除敌方的加成状态",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "阴阳道",
		skillNameImage = "battle_text_042.png",
		headerImage = "skill_32.png",
		desc = "攻击敌方单个目标，造成{1.35*(100+3*(sl-1))}%法攻伤害的同时恢复自身等量的血量",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "初开混沌",
		skillNameImage = "battle_text_043.png",
		headerImage = "skill_33.png",
		desc = "对敌方单人造成{1.35*(100+3*(sl-1))}%法攻伤害，并有{0.5*(100+1*(sl-1))}%的概率使目标陷入昏迷1回合",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "封镇八荒",
		skillNameImage = "battle_text_044.png",
		headerImage = "skill_34.png",
		desc = "对敌方后排造成{(100+3*(sl-1))*1}%法攻伤害，并有{0.5*(100+1*(sl-1))}%的概率使目标陷入沉默状态3回合",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "补天诀",
		skillNameImage = "battle_text_045.png",
		headerImage = "skill_35.png",
		desc = "恢复全体血量（{0.55*(100+2*(sl-1))}%法攻），并有{0.5*(100+1*(sl-1))}%的概率解除我方所中异常状态",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "通天诀",
		skillNameImage = "battle_text_046.png",
		headerImage = "skill_36.png",
		desc = "治疗生命值损失最多的3个单位血量（{0.8*(100+2*(sl-1))}%法攻），并随机解除一个异常状态，转移给敌方",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	[10001] = {
		name = "雨韧",
		skillNameImage = "battle_text_116.png",
		headerImage = "skill_10001.png",
		type = SkillType.eTalent,
		quality = QualityType.eGreen,
		desc = {
			"战斗中增加韧性{40}点。",
			"战斗中增加韧性{215}点。",
			"战斗中增加韧性{435}点。"
		}
	},
	[10002] = {
		name = "骨盾",
		skillNameImage = "battle_text_117.png",
		headerImage = "skill_10002.png",
		type = SkillType.eTalent,
		quality = QualityType.eGreen,
		desc = {
			"初次被攻击{100}%格挡。",
			"初次被攻击{100}%格挡，且有{80}%概率格挡第二次攻击。",
			"初次被攻击{100}%格挡，且有{80}%、{50}%概率格挡第二次、第三次攻击。"
		}
	},
	[10003] = {
		name = "君威",
		skillNameImage = "battle_text_118.png",
		headerImage = "skill_10003.png",
		type = SkillType.eTalent,
		quality = QualityType.eGreen,
		desc = {
			"战斗中增加格挡{40}点。",
			"战斗中增加格挡{215}点。",
			"战斗中增加格挡{435}点。"
		}
	},
	[10004] = {
		name = "雷暴",
		skillNameImage = "battle_text_119.png",
		headerImage = "skill_10004.png",
		type = SkillType.eTalent,
		quality = QualityType.eGreen,
		desc = {
			"初次攻击{100}%暴击攻击。",
			"初次攻击{100}%暴击攻击，且有{80}%概率使第二次攻击暴击。",
			"初次攻击{100}%暴击攻击，且有{80}%、{50}%概率使第二次、第三次攻击暴击。"
		}
	},
	[10005] = {
		name = "精准",
		skillNameImage = "battle_text_120.png",
		headerImage = "skill_10001.png",
		type = SkillType.eTalent,
		quality = QualityType.eGreen,
		desc = {
			"战斗中增加命中{35}点。",
			"战斗中增加命中{200}点。",
			"战斗中增加命中{405}点"
		}
	},
	[10006] = {
		name = "蛟爪",
		skillNameImage = "battle_text_121.png",
		headerImage = "skill_10002.png",
		type = SkillType.eTalent,
		quality = QualityType.eGreen,
		desc = {
			"战斗中增加破击{40}点。",
			"战斗中增加破击{230}点。",
			"战斗中增加破击{470}点。"
		}
	},
	[10007] = {
		name = "天威",
		skillNameImage = "battle_text_122.png",
		headerImage = "skill_10003.png",
		type = SkillType.eTalent,
		quality = QualityType.eGreen,
		desc = {
			"战斗开始时增加怒气{20}点。",
			"战斗开始时增加怒气{50}点。",
			"战斗开始时增加怒气{100}点"
		}
	},
	[10008] = {
		name = "魅击",
		skillNameImage = "battle_text_123.png",
		headerImage = "skill_10004.png",
		type = SkillType.eTalent,
		quality = QualityType.eGreen,
		desc = {
			"战斗中增加暴击{35}点。",
			"战斗中增加暴击{230}点。",
			"战斗中增加暴击{470}点"
		}
	},
	[10009] = {
		name = "花雨",
		skillNameImage = "battle_text_124.png",
		headerImage = "skill_10001.png",
		type = SkillType.eTalent,
		quality = QualityType.eGreen,
		desc = {
			"战斗中增加闪避{33}点。",
			"战斗中增加韧性{185}点。",
			"战斗中增加韧性{380}点。"
		}
	},
	[10010] = {
		name = "魅惑",
		skillNameImage = "battle_text_125.png",
		headerImage = "skill_10010.png",
		type = SkillType.eTalent,
		quality = QualityType.eBlue,
		desc = {
			"首次被攻击{100}%闪避。",
			"首次被攻击{100}%闪避，且有{50}%概率闪避第二次攻击。",
			"首次被攻击{100}%闪避，且有{50}%、{30}%概率闪避第二次、第三次攻击。"
		}
	},
	[10011] = {
		name = "化生",
		skillNameImage = "battle_text_126.png",
		headerImage = "skill_10011.png",
		type = SkillType.eTalent,
		quality = QualityType.eBlue,
		desc = {
			"每次被攻击后，{10}%概率回复生命值。",
			"每次被攻击后，{20}%概率回复生命值。",
			"每次被攻击后，{30}%概率回复生命值。"
		}
	},
	[10012] = {
		name = "金钹",
		skillNameImage = "battle_text_127.png",
		headerImage = "skill_10012.png",
		type = SkillType.eTalent,
		quality = QualityType.eBlue,
		desc = {
			"{50}%免疫一次群体攻击技能。",
			"{60}%免疫第一次群体攻击技能，且有{10}%概率免疫第二次群体攻击技能。",
			"{70}%免疫第一次群体攻击技能，且有{10}%、{5}%概率免疫第二次、第三次群体攻击技能。"
		}
	},
	[10013] = {
		name = "驱邪",
		skillNameImage = "battle_text_128.png",
		headerImage = "skill_10013.png",
		type = SkillType.eTalent,
		quality = QualityType.eBlue,
		desc = {
			"{30}%概率异常状态附加失败。",
			"{50}%概率异常状态附加失败。",
			"{70}%概率异常状态附加失败。"
		}
	},
	[10014] = {
		name = "鬼铠",
		skillNameImage = "battle_text_129.png",
		headerImage = "skill_10010.png",
		type = SkillType.eTalent,
		quality = QualityType.eBlue,
		desc = {
			"当前生命值大于攻击方生命值时，敌方造成的普通伤害减少{20}%。",
			"当前生命值大于攻击方生命值时，敌方造成的普通伤害减少{30}%。",
			"当前生命值大于攻击方生命值时，敌方造成的普通伤害减少{40}%。"
		}
	},
	[10015] = {
		name = "寒涛",
		skillNameImage = "battle_text_130.png",
		headerImage = "skill_10011.png",
		type = SkillType.eTalent,
		quality = QualityType.eBlue,
		desc = {
			"发动普通攻击时，有{50}%的概率降低敌方{25}点怒气值。",
			"发动普通攻击时，有{80}%的概率降低敌方{40}点怒气值。",
			"发动普通攻击时，有{100}%的概率降低敌方{55}点怒气值。"
		}
	},
	[10016] = {
		name = "怒目",
		skillNameImage = "battle_text_131.png",
		headerImage = "skill_10012.png",
		type = SkillType.eTalent,
		quality = QualityType.eBlue,
		desc = {
			"被攻击时增加的怒气数量提升{5}点。",
			"被攻击时增加的怒气数量提升{10}点。",
			"被攻击时增加的怒气数量提升{15}点。"
		}
	},
	[10017] = {
		name = "威势",
		skillNameImage = "battle_text_132.png",
		headerImage = "skill_10013.png",
		type = SkillType.eTalent,
		quality = QualityType.eBlue,
		desc = {
			"普通攻击时，如当前怒气值大于攻击目标当前怒气值，造成的伤害提高{30}%。",
			"普通攻击时，如当前怒气值大于攻击目标当前怒气值，造成的伤害提高{40}%。",
			"普通攻击时，如当前怒气值大于攻击目标当前怒气值，造成的伤害提高{50}%。"
		}
	},
	[10018] = {
		name = "补击",
		skillNameImage = "battle_text_133.png",
		headerImage = "skill_10010.png",
		type = SkillType.eTalent,
		quality = QualityType.eBlue,
		desc = {
			"普通攻击时敌方如果闪避，可再发动一次攻击",
			"普通攻击时敌方如果闪避，可再发动一次攻击，攻击力提升{20}%",
			"普通攻击时敌方如果闪避，可再发动一次攻击，攻击力提升{40}%"
		}
	},
	[10019] = {
		name = "掐算",
		skillNameImage = "battle_text_134.png",
		headerImage = "skill_10011.png",
		type = SkillType.eTalent,
		quality = QualityType.eBlue,
		desc = {
			"{100}%免疫前两次技能攻击。",
			"{100}%免疫前两次技能攻击，{80}%概率免疫第三次针对自己的技能攻击。",
			"{100}%免疫前两次技能攻击，{80}%概率免疫第三次针对自己的技能攻击，{50}%概率免疫第四次针对自己的技能攻击。"
		}
	},
	[10020] = {
		name = "映月",
		skillNameImage = "battle_text_135.png",
		headerImage = "skill_10012.png",
		type = SkillType.eTalent,
		quality = QualityType.eBlue,
		desc = {
			"当被攻击死亡时，攻击方也会受到{30}%的法攻伤害，此伤害无法被防御。",
			"当被攻击死亡时，攻击方也会受到{40}%的法攻伤害，此伤害无法被防御。",
			"当被攻击死亡时，攻击方也会受到{50}%的法攻伤害，此伤害无法被防御。"
		}
	},
	[10021] = {
		name = "封印",
		skillNameImage = "battle_text_136.png",
		headerImage = "skill_10013.png",
		type = SkillType.eTalent,
		quality = QualityType.eBlue,
		desc = {
			"发动技能攻击时，有{50%}的概率降低敌方怒气值{80}点。",
			"发动技能攻击时，有{80%}的概率降低敌方怒气值{80}点。",
			"发动技能攻击时，有{100%}的概率降低敌方怒气值{80}点。"
		}
	},
	[10022] = {
		name = "青莲",
		skillNameImage = "battle_text_137.png",
		headerImage = "skill_10010.png",
		type = SkillType.eTalent,
		quality = QualityType.eBlue,
		desc = {
			"当被攻击死亡时，我方其他全部武将生命值回复{30}%。",
			"当被攻击死亡时，我方其他全部武将生命值回复{40}%。",
			"当被攻击死亡时，我方其他全部武将生命值回复{50}%。"
		}
	},
	[10023] = {
		name = "白炎",
		skillNameImage = "battle_text_138.png",
		headerImage = "skill_10011.png",
		type = SkillType.eTalent,
		quality = QualityType.eBlue,
		desc = {
			"攻击时增加的怒气数量提升{15}点。",
			"攻击时增加的怒气数量提升{20}点。",
			"攻击时增加的怒气数量提升{25}点。"
		}
	},
	[10024] = {
		name = "厚皮",
		skillNameImage = "battle_text_139.png",
		headerImage = "skill_10024.png",
		type = SkillType.eTalent,
		quality = QualityType.ePurple,
		desc = {
			"当本人生命值不小于上限的{60}%时，防御力提高{30}%。",
			"当本人生命值不小于上限的{55}%时，防御力提高{40}%。",
			"当本人生命值不小于上限的{50}%时，防御力提高{50}%。"
		}
	},
	[10025] = {
		name = "驾崩",
		skillNameImage = "battle_text_140.png",
		headerImage = "skill_10025.png",
		type = SkillType.eTalent,
		quality = QualityType.ePurple,
		desc = {
			"当被攻击死亡后，我方随机两个武将怒气全满。",
			"当被攻击死亡后，我方随机两个武将怒气全满且在1回合内提升{30}%攻击力。",
			"当被攻击死亡后，我方随机两个武将怒气全满且在1回合内提升{50}%攻击力。"
		}
	},
	[10026] = {
		name = "借命",
		skillNameImage = "battle_text_141.png",
		headerImage = "skill_10026.png",
		type = SkillType.eTalent,
		quality = QualityType.ePurple,
		desc = {
			"生命值为0时，获得一次不死的机会，生命值保留1点。",
			"生命值为0时，获得一次不死的机会，生命值恢复至上限的一半。",
			"生命值为0时，获得一次不死的机会，生命值恢复至上限的一半,{50}%概率第二次仍不会死亡，生命值保留1点。"
		}
	},
	[10027] = {
		name = "吞天",
		skillNameImage = "battle_text_142.png",
		headerImage = "skill_10027.png",
		type = SkillType.eTalent,
		quality = QualityType.ePurple,
		desc = {
			"每杀死一个目标，将直接回复自身生命上限的{30}%。",
			"每杀死一个目标，将直接回复自身生命上限的{40}%。",
			"每杀死一个目标，将直接回复自身生命上限的{50}%。"
		}
	},
	[10028] = {
		name = "斗战",
		skillNameImage = "battle_text_143.png",
		headerImage = "skill_10028.png",
		type = SkillType.eTalent,
		quality = QualityType.ePurple,
		desc = {
			"当本人生命值小于上限的{30%}时，攻击力提升{50}%。",
			"当本人生命值小于上限的{35%}时，攻击力提升{55}%。",
			"当本人生命值小于上限的{40%}时，攻击力提升{60}%。"
		}
	},
	[10029] = {
		name = "急速",
		skillNameImage = "battle_text_144.png",
		headerImage = "skill_10029.png",
		type = SkillType.eTalent,
		quality = QualityType.ePurple,
		desc = {
			"发动普通攻击后，有{40}%的概率再发动一次普通攻击。",
			"发动普通攻击后，有{60}%的概率再发动一次普通攻击。",
			"发动普通攻击后，有{80}%的概率再发动一次普通攻击。"
		}
	},
	[10030] = {
		name = "续命",
		skillNameImage = "battle_text_145.png",
		headerImage = "skill_10030.png",
		type = SkillType.eTalent,
		quality = QualityType.ePurple,
		desc = {
			"若治疗使目标生命达到上限，可少量提高其生命上限的{5}%。",
			"若治疗使目标生命达到上限，可少量提高其生命上限的{10}%。",
			"若治疗使目标生命达到上限，可少量提高其生命上限的{15}%。"
		}
	},
	[10031] = {
		name = "破虚",
		skillNameImage = "battle_text_146.png",
		headerImage = "skill_10031.png",
		type = SkillType.eTalent,
		quality = QualityType.ePurple,
		desc = {
			"普通攻击有{50}%的概率无视顺序，直接攻击敌方生命最少的目标。",
			"普通攻击有{75}%的概率无视顺序，直接攻击敌方生命最少的目标。",
			"普通攻击有{100}%的概率无视顺序，直接攻击敌方生命最少的目标。"
		}
	},
	[10032] = {
		name = "天道",
		skillNameImage = "battle_text_147.png",
		headerImage = "skill_10032.png",
		type = SkillType.eTalent,
		quality = QualityType.ePurple,
		desc = {
			"受到普通攻击后，有{50}%的概率发动一次反击。",
			"受到普通攻击后，有{75}%的概率发动一次反击。",
			"受到普通攻击后，有{100}%的概率发动一次反击。"
		}
	},
	[10033] = {
		name = "敕令",
		skillNameImage = "battle_text_148.png",
		headerImage = "skill_10033.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"每次普通攻击减少敌方生命上限的{5}%。",
			"每次普通攻击减少敌方生命上限的{8}%。",
			"每次普通攻击减少敌方生命上限的{10}%。"
		}
	},
	[10034] = {
		name = "推演",
		skillNameImage = "battle_text_149.png",
		headerImage = "skill_10034.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"每次被攻击后，增加自身防御力的{10}%，最多60%直至死亡。",
			"每次被攻击后，增加自身防御力的{12}%，最多60%直至死亡。",
			"每次被攻击后，增加自身防御力的{15}%，最多60%直至死亡。"
		}
	},
	[10035] = {
		name = "无量",
		skillNameImage = "battle_text_150.png",
		headerImage = "skill_10035.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"每次发动攻击后，增加自身攻击力的{15}%，最多75%直至死亡。",
			"每次发动攻击后，增加自身攻击力的{20}%，最多75%直至死亡。",
			"每次发动攻击后，增加自身攻击力的{25}%，最多75%直至死亡。"
		}
	},
	[10036] = {
		name = "连斩",
		skillNameImage = "battle_text_151.png",
		headerImage = "skill_10036.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"若攻击将对方杀死，可再发动一次普通攻击，并使本次攻击力上升{5}%。",
			"若攻击将对方杀死，可再发动一次普通攻击，并使本次攻击力上升{10}%。",
			"若攻击将对方杀死，可再发动一次普通攻击，并使本次攻击力上升{15}%。"
		}
	},
	[10037] = {
		name = "返本",
		skillNameImage = "battle_text_152.png",
		headerImage = "skill_10037.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"当敌方当前生命值小于上限的{15}%时，有{20}%的概率普通攻击可直接秒杀对方。",
			"当敌方当前生命值小于上限的{20}%时，有{25}%的概率普通攻击可直接秒杀对方。",
			"当敌方当前生命值小于上限的{25}%时，有{30}%的概率普通攻击可直接秒杀对方。"
		}
	},
	[10038] = {
		name = "诛仙",
		skillNameImage = "battle_text_153.png",
		headerImage = "skill_10038.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"杀死敌方后，死者周围的目标都会受到{33}%的法攻伤害。",
			"杀死敌方后，死者周围的目标都会受到{36}%的法攻伤害。",
			"杀死敌方后，死者周围的目标都会受到{40}%的法攻伤害。"
		}
	},
	{
		name = "天罚神雷",
		skillNameImage = "battle_text_078.png",
		headerImage = "skill_10.png",
		desc = "对敌方前排造成{(100+1*(sl-1))*0.75}%法攻伤害",
		type = SkillType.eRage,
		quality = QualityType.eBlue
	},
	{
		name = "多情诀",
		skillNameImage = "battle_text_079.png",
		headerImage = "skill_11.png",
		desc = "治疗生命值损失最多的3个单位的血量（{0.55*(100+1*(sl-1))}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.eBlue
	},
	{
		name = "震地一击",
		skillNameImage = "battle_text_080.png",
		headerImage = "skill_8.png",
		desc = "震击地面，对敌方后排造成{(100+1*(sl-1))*0.75}%法攻伤害",
		type = SkillType.eRage,
		quality = QualityType.eBlue
	},
	{
		name = "千军驭",
		skillNameImage = "battle_text_081.png",
		headerImage = "skill_40.png",
		desc = "增加前排2回合普防（{0.06*(100+1*(sl-1))}%法攻）与法防（{0.11*(100+1*(sl-1))}%法攻），并有{0.5*(100+1*(sl-1))}%的概率增加2回合韧性（{(100+10*(sl-1))/28}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.ePurple
	},
	{
		name = "黄沙障",
		skillNameImage = "battle_text_082.png",
		headerImage = "skill_41.png",
		desc = "对敌方后排造成{(100+1*(sl-1))*0.75}%法攻伤害，并有{0.5*(100+1*(sl-1))}%概率降低2回合命中（{(100+1*(sl-1))/28}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.ePurple
	},
	{
		name = "破邪法瞳",
		skillNameImage = "battle_text_083.png",
		headerImage = "skill_42.png",
		desc = "有50%概率直接造成敌人当前生命25%的伤害,当技能伤害超出敌方生命的25%时,造成{100+1*(sl-1)}%法攻伤害",
		type = SkillType.eRage,
		quality = QualityType.ePurple
	},
	{
		name = "莲生诀",
		skillNameImage = "battle_text_084.png",
		headerImage = "skill_43.png",
		desc = "治疗生命值损失最多的3个单位血量（{0.55*(100+1*(sl-1))}%法攻)，并有{0.5*(100+1*(sl-1))}%概率增加3回合格挡（{(100+1*(sl-1))/28}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.ePurple
	},
	{
		name = "威震诀",
		skillNameImage = "battle_text_085.png",
		headerImage = "skill_44.png",
		desc = "对敌方后排造成{(100+1*(sl-1))*0.75}%法攻伤害，并降低其{30*(1+(sl-1)*0.01)}点怒气值",
		type = SkillType.eRage,
		quality = QualityType.ePurple
	},
	{
		name = "翻江倒海",
		skillNameImage = "battle_text_086.png",
		headerImage = "skill_45.png",
		desc = "对敌方后排造成{(100+1*(sl-1))*0.75}%法攻伤害，并有{0.5*(100+1*(sl-1))}%概率降低2回合普攻（{0.07*(100+1*(sl-1))}%法攻）和法攻（{0.16*(100+1*(sl-1))}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.ePurple
	},
	{
		name = "百果宴",
		skillNameImage = "battle_text_087.png",
		headerImage = "skill_46.png",
		desc = "回复前排血量（{0.8*(100+2*(sl-1))}%法攻），并增加普防（{0.01*(100+1*(sl-1))}%法攻）和法防（{0.02*(100+1*(sl-1))}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "怒战九黎",
		skillNameImage = "battle_text_088.png",
		headerImage = "skill_47.png",
		desc = "使敌方全体受到{(100+2*(sl-1))*0.65}%法攻伤害，并有{20*(1+(sl-1)*0.01)}%概率降低3回合暴击（{(100+1*(sl-1))/28}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "七宝诀",
		skillNameImage = "battle_text_089.png",
		headerImage = "skill_48.png",
		desc = "对敌方全体造成{(100+3*(sl-1))*0.65}%法攻伤害，并有{0.2*(100+1*(sl-1))}%概率使其沉默3回合",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "百炼诀",
		skillNameImage = "battle_text_090.png",
		headerImage = "skill_49.png",
		desc = "对敌方生命值最多的3个单位造成{(100+2*(sl-1))*1}%法攻伤害，并降低普防（{0.01*(100+1*(sl-1))}%法攻）和法防（{0.02*(100+1*(sl-1))}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	[10039] = {
		name = "迷魅",
		skillNameImage = "battle_text_154.png",
		headerImage = "skill_10012.png",
		type = SkillType.eTalent,
		quality = QualityType.eBlue,
		desc = {
			"发动技能攻击时，有{50}%的概率降低敌方怒气值80点。",
			"发动技能攻击时，有{80}%的概率降低敌方怒气值80点。",
			"发动技能攻击时，有{100}%的概率降低敌方怒气值80点。"
		}
	},
	[10040] = {
		name = "天怒",
		skillNameImage = "battle_text_155.png",
		headerImage = "skill_10013.png",
		type = SkillType.eTalent,
		quality = QualityType.eBlue,
		desc = {
			"普通攻击时，如当前怒气值大于攻击目标当前怒气值，造成的伤害提高{30}%。",
			"普通攻击时，如当前怒气值大于攻击目标当前怒气值，造成的伤害提高{40}%。",
			"普通攻击时，如当前怒气值大于攻击目标当前怒气值，造成的伤害提高{50}%。"
		}
	},
	[10041] = {
		name = "威压",
		skillNameImage = "battle_text_156.png",
		headerImage = "skill_10010.png",
		type = SkillType.eTalent,
		quality = QualityType.eBlue,
		desc = {
			"发动普通攻击时，有{50}%的概率降低敌方{25}点怒气值。",
			"发动普通攻击时，有{80}%的概率降低敌方{45}点怒气值。",
			"发动普通攻击时，有{100}%的概率降低敌方{55}点怒气值。"
		}
	},
	[10042] = {
		name = "吞噬",
		skillNameImage = "battle_text_157.png",
		headerImage = "skill_10042.png",
		type = SkillType.eTalent,
		quality = QualityType.ePurple,
		desc = {
			"每杀死一个目标，将直接回复自身生命上限的{30}%。",
			"每杀死一个目标，将直接回复自身生命上限的{40}%。",
			"每杀死一个目标，将直接回复自身生命上限的{50}%。"
		}
	},
	[10043] = {
		name = "束缚",
		skillNameImage = "battle_text_158.png",
		headerImage = "skill_10043.png",
		type = SkillType.eTalent,
		quality = QualityType.ePurple,
		desc = {
			"每次攻击敌方后,可降低敌方{5}%的速度。",
			"每次攻击敌方后,可降低敌方{10}%的速度。",
			"每次攻击敌方后,可降低敌方{15}%的速度。"
		}
	},
	[10044] = {
		name = "承天",
		skillNameImage = "battle_text_159.png",
		headerImage = "skill_10044.png",
		type = SkillType.eTalent,
		quality = QualityType.ePurple,
		desc = {
			"普通攻击有{50}%的概率无视顺序，直接攻击敌方生命最少的目标。",
			"普通攻击有{75}%的概率无视顺序，直接攻击敌方生命最少的目标。",
			"普通攻击有{100}%的概率无视顺序，直接攻击敌方生命最少的目标。"
		}
	},
	[10045] = {
		name = "帝运",
		skillNameImage = "battle_text_160.png",
		headerImage = "skill_10045.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"每次攻击敌方后,自身直接回复{15}%生命值。",
			"每次攻击敌方后,自身直接回复{20}%生命值。",
			"每次攻击敌方后,自身直接回复{25}%生命值。"
		}
	},
	[10046] = {
		name = "地仙",
		skillNameImage = "battle_text_161.png",
		headerImage = "skill_10046.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"每次被攻击后,都能提升自身{30}%的格挡值,并降低对方{5%}破击。",
			"每次被攻击后,都能提升自身{40}%的格挡值,并降低对方{10%}破击。",
			"每次被攻击后,都能提升自身{50}%的格挡值,并降低对方{15%}破击。"
		}
	},
	[10047] = {
		name = "妙法",
		skillNameImage = "battle_text_162.png",
		headerImage = "skill_10047.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"每次攻击敌方后，提升自身{10}%速度及{15}点怒气值。",
			"每次攻击敌方后，提升自身{20}%速度及{20}点怒气值。",
			"每次攻击敌方后，提升自身{30}%速度及{25}点怒气值。"
		}
	},
	[10048] = {
		name = "魔噬",
		skillNameImage = "battle_text_163.png",
		headerImage = "skill_10048.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"普通攻击同时减少敌方生命上限的{10}%。",
			"普通攻击同时减少敌方生命上限的{12}%。",
			"普通攻击同时减少敌方生命上限的{15}%。"
		}
	},
	[10049] = {
		name = "血战",
		skillNameImage = "battle_text_208.png",
		headerImage = "skill_10049.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"每次攻击敌方后，提升自身{20}%命中及{20}%破击。",
			"每次攻击敌方后，提升自身{30}%命中及{30}%破击。",
			"每次攻击敌方后，提升自身{40}%命中及{40}%破击。"
		}
	},
	{
		name = "力掌乾坤",
		skillNameImage = "battle_text_207.png",
		headerImage = "skill_50.png",
		desc = "使敌方全体受到{(100+3*(sl-1))*0.65}%法攻伤害，并有{20*(1+(sl-1)*0.01)}%概率降低敌方30点怒气",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "清心诀",
		skillNameImage = "battle_text_221.png",
		headerImage = "skill_51.png",
		desc = "治疗生命值损失最多的3个单位血量（{0.8*(100+2*(sl-1))}%法攻），并解除每单位一个异常状态",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "安忍诀",
		skillNameImage = "battle_text_222.png",
		headerImage = "skill_52.png",
		desc = "对敌方前排造成{(100+3*(sl-1))*1}%法攻伤害，并有{20*(1+(sl-1)*0.01)}%概率使目标陷入断续状态，持续1回合",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "慈悲诀",
		skillNameImage = "battle_text_223.png",
		headerImage = "skill_53.png",
		desc = "恢复全体血量（{0.55*(100+3*(sl-1))}%法攻），增加2回合普防（{0.03*(100+1*(sl-1))}%法攻）与法防（{0.06*(100+1*(sl-1))}%法攻），并有{19+1*sl}%的概率增加20点怒气值",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "九齿夺命",
		skillNameImage = "battle_text_224.png",
		headerImage = "skill_54.png",
		desc = "对敌方生命值最少的3个单位造成{(100+2*(sl-1))*1}%法攻伤害，并降低普防（{0.01*(100+1*(sl-1))}%法攻）和法防（{0.02*(100+1*(sl-1))}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "降魔一击",
		skillNameImage = "battle_text_225.png",
		headerImage = "skill_55.png",
		desc = "对生命最多单位造成{1.35*(100+2*(sl-1))}%法攻伤害，降低2回合普攻（{0.07*(100+1*(sl-1))}%法攻）法攻（{0.16*(100+1*(sl-1))}%法攻）和30点怒气",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "佛火证道",
		skillNameImage = "battle_text_226.png",
		headerImage = "skill_56.png",
		desc = "对敌方后排造成{(100+3*(sl-1))*1}%法攻伤害，并有{0.25*(100+1*(sl-1))}%的概率使目标陷入昏迷状态1回合",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "铁蹄怒",
		skillNameImage = "battle_text_227.png",
		headerImage = "skill_57.png",
		desc = "使敌方全体受到{(100+2*(sl-1))*0.65}%法攻伤害，并有{19+1*sl}%概率降低3回合闪避（{(100+1*(sl-1))/28}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "护龙魂",
		skillNameImage = "battle_text_228.png",
		headerImage = "skill_58.png",
		desc = "治疗损血最多单位血量（{(100+2*(sl-1))*1.1}%法攻），解除全部异常状态，有{19+1*sl}%概率增加3回合闪避（{(100+1*(sl-1))*0.1}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "轩辕道",
		skillNameImage = "battle_text_229.png",
		headerImage = "skill_59.png",
		desc = "使敌方全体受到{(100+3*(sl-1))*0.65}%法攻伤害，并有{19+1*sl}%概率降低普防（{0.02*(100+1*(sl-1))}%法攻）和法防（{0.04*(100+1*(sl-1))}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "神农击",
		skillNameImage = "battle_text_230.png",
		headerImage = "skill_60.png",
		desc = "对敌方随机1个目标造成{(100+3*(sl-1))*1.35}%法攻伤害，并使目标陷入沉默状态3回合",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	[10050] = {
		name = "启明",
		skillNameImage = "battle_text_211.png",
		headerImage = "skill_10050.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"普通攻击敌方生命值最少目标，如杀死目标，回复自身生命上限的20%",
			"普通攻击敌方生命值最少目标，如杀死目标，回复自身生命上限的30%",
			"普通攻击敌方生命值最少目标，如杀死目标，回复自身生命上限的40%"
		}
	},
	[10051] = {
		name = "静虑",
		skillNameImage = "battle_text_212.png",
		headerImage = "skill_10051.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"普通攻击时，有60%的概率给敌方附加断续状态，持续1回合",
			"普通攻击时，有80%的概率给敌方附加断续状态，持续1回合",
			"普通攻击时，有100%的概率给敌方附加断续状态，持续1回合"
		}
	},
	[10052] = {
		name = "佛光",
		skillNameImage = "battle_text_213.png",
		headerImage = "skill_10052.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"受到法术攻击时，伤害值有20%概率降为1点",
			"受到法术攻击时，伤害值有30%概率降为1点",
			"受到法术攻击时，伤害值有40%概率降为1点"
		}
	},
	[10053] = {
		name = "贪食",
		skillNameImage = "battle_text_214.png",
		headerImage = "skill_10053.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"每次接受治疗后，防御力提升15%，最多60%",
			"每次接受治疗后，防御力提升20%，最多60%",
			"每次接受治疗后，防御力提升25%，最多60%"
		}
	},
	[10054] = {
		name = "刀圭",
		skillNameImage = "battle_text_215.png",
		headerImage = "skill_10054.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"每杀死一个目标后，普攻法攻提升20%",
			"每杀死一个目标后，普攻法攻提升25%",
			"每杀死一个目标后，普攻法攻提升30%"
		}
	},
	[10055] = {
		name = "棍影",
		skillNameImage = "battle_text_216.png",
		headerImage = "skill_10055.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"每次普通攻击，对同排相邻单位造成30%的额外伤害",
			"每次普通攻击，对同排相邻单位造成40%的额外伤害",
			"每次普通攻击，对同排相邻单位造成50%的额外伤害"
		}
	},
	[10056] = {
		name = "平天",
		skillNameImage = "battle_text_217.png",
		headerImage = "skill_10056.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"发动攻击时，降低敌方怒气增加值60%",
			"发动攻击时，降低敌方怒气增加值80%",
			"发动攻击时，敌方不增加怒气"
		}
	},
	[10057] = {
		name = "龙怒",
		skillNameImage = "battle_text_218.png",
		headerImage = "skill_10057.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"每次被攻击增加自己10%暴击，降低对方10%韧性",
			"每次被攻击增加自己20%暴击，降低对方20%韧性",
			"每次被攻击增加自己30%暴击，降低对方30%韧性"
		}
	},
	[10058] = {
		name = "反震",
		skillNameImage = "battle_text_219.png",
		headerImage = "skill_10058.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"受到普攻伤害时，反馈受到伤害的10%并获得相应的治疗",
			"受到普攻伤害时，反馈受到伤害的15%并获得相应的治疗",
			"受到普攻伤害时，反馈受到伤害的20%并获得相应的治疗"
		}
	},
	[10059] = {
		name = "百草",
		skillNameImage = "battle_text_220.png",
		headerImage = "skill_10059.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"生命值为0时，获得一次不死机会，同时吸取敌方生命回复自身生命上限20%",
			"生命值为0时，获得一次不死机会，同时吸取敌方生命回复自身生命上限30%",
			"生命值为0时，首次不死，同时吸取敌方生命回复自身生命上限50%，第二次仍可保留1点生命不死"
		}
	},
	[10060] = {
		name = "妖媚",
		skillNameImage = "",
		headerImage = "skill_10060.png",
		type = SkillType.eTalent,
		quality = QualityType.eBlue,
		desc = {
			"发动技能攻击时，有{50}%的概率增加我方怒气值80点。",
			"发动技能攻击时，有{80}%的概率增加我方怒气值80点。",
			"发动技能攻击时，有{100}%的概率增加我方怒气值80点。"
		}
	},
	{
		name = "恐惧咆哮",
		skillNameImage = "battle_text_244.png",
		headerImage = "skill_61.png",
		desc = "使敌方全体受到{(100+3*(sl-1))*0.65}%法攻伤害，并有{19+1*sl}%概率降低普防（{0.02*(100+1*(sl-1))}%法攻）和法防（{0.04*(100+1*(sl-1))}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "开天地",
		skillNameImage = "battle_text_242.png",
		headerImage = "skill_62.png",
		desc = "对敌方后排造成{(100+3*(sl-1))*1}%法攻伤害，并有{0.5*(100+1*(sl-1))}%概率降低敌方40点怒气",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "治水诀",
		skillNameImage = "battle_text_240.png",
		headerImage = "skill_63.png",
		desc = "对敌方一列单位造成{(100+3*(sl-1))*1}%法攻伤害，并有{0.4*(100+1*(sl-1))}%的概率使目标陷入昏迷状态1回合",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "猴王击",
		skillNameImage = "battle_text_241.png",
		headerImage = "skill_64.png",
		desc = "对生命最多单位造成{1.35*(100+2*(sl-1))}%法攻伤害，并有{19+1*sl}%概率降低普防（{0.02*(100+1*(sl-1))}%法攻）法防（{0.04*(100+1*(sl-1))}%法攻）和30点怒气",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "舞干戚",
		skillNameImage = "battle_text_243.png",
		headerImage = "skill_65.png",
		desc = "对敌方生命值最少的单位造成{(100+2*(sl-1))*1}%法攻伤害，并有{0.4*(100+1*(sl-1))}%的概率使目标陷入昏迷状态1回合",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "填海诀",
		skillNameImage = "battle_text_249.png",
		headerImage = "skill_66.png",
		desc = "回复前排血量（{0.8*(100+2*(sl-1))}%法攻），并有{50*(1+(sl-1)*0.01)}%概率增加其{60*(1+(sl-1)*0.02)}%闪避和{60*(1+(sl-1)*0.02)}%韧性，持续两回合",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "奇门遁甲",
		skillNameImage = "battle_text_246.png",
		headerImage = "skill_67.png",
		desc = "恢复全体血量（{0.55*(100+3*(sl-1))}%法攻），并有{0.5*(100+1*(sl-1))}%的概率解除我方所中异常状态",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "天柱折",
		skillNameImage = "battle_text_247.png",
		headerImage = "skill_68.png",
		desc = "使敌方全体受到{(100+2*(sl-1))*0.65}%法攻伤害，并有{19+1*sl}%概率降低其{70}%闪避，持续3回合",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "流风回雪",
		skillNameImage = "battle_text_248.png",
		headerImage = "skill_69.png",
		desc = "恢复自身法攻{1.35*(100+3*(sl-1))}%的血量同时增加普防（{0.01*(100+1*(sl-1))}%法攻）和法防（{0.02*(100+1*(sl-1))}%法攻）",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	{
		name = "芭蕉扇",
		skillNameImage = "battle_text_245.png",
		headerImage = "skill_70.png",
		desc = "使敌方全体受到{(100+2*(sl-1))*0.65}%法攻伤害，并有{19+1*sl}%概率降低其{50}%闪避和{50}%韧性，持续3回合",
		type = SkillType.eRage,
		quality = QualityType.eOrange
	},
	[10061] = {
		name = "仁德",
		skillNameImage = "battle_text_250.png",
		headerImage = "skill_10061.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"每次发动攻击后，增加自身攻击力的{15}%，最多75%直至死亡。",
			"每次发动攻击后，增加自身攻击力的{20}%，最多75%直至死亡。",
			"每次发动攻击后，增加自身攻击力的{25}%，最多75%直至死亡。"
		}
	},
	[10062] = {
		name = "化形",
		skillNameImage = "battle_text_251.png",
		headerImage = "skill_10062.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"每杀死一个目标后，普攻法攻提升20%",
			"每杀死一个目标后，普攻法攻提升25%",
			"每杀死一个目标后，普攻法攻提升30%"
		}
	},
	[10063] = {
		name = "重击",
		skillNameImage = "battle_text_252.png",
		headerImage = "skill_10063.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"普通攻击时，有30%的概率使敌方昏迷，持续1回合",
			"普通攻击时，有40%的概率使敌方昏迷，持续1回合",
			"普通攻击时，有50%的概率使敌方昏迷，持续1回合"
		}
	},
	[10064] = {
		name = "狂暴",
		skillNameImage = "battle_text_253.png",
		headerImage = "skill_10064.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"生命值每损失5%，攻击力提升{10}%，最多100%直至死亡。",
			"生命值每损失5%，攻击力提升{15}%，最多100%直至死亡。",
			"生命值每损失5%，攻击力提升{20}%，最多100%直至死亡。"
		}
	},
	[10065] = {
		name = "盛宴",
		skillNameImage = "battle_text_254.png",
		headerImage = "skill_10065.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"{100}%免疫一次群体攻击技能。",
			"{100}%免疫第一次群体攻击技能，且有{10}%概率免疫第二次群体攻击技能。",
			"{100}%免疫第一次群体攻击技能，且有{10}%、{5}%概率免疫第二次、第三次群体攻击技能。"
		}
	},
	[10066] = {
		name = "扇风",
		skillNameImage = "battle_text_255.png",
		headerImage = "skill_10066.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"每次被攻击后，增加自身{10}%的速度和20点怒气。",
			"每次被攻击后，增加自身{20}%的速度和30点怒气。",
			"每次被攻击后，增加自身{30}%的速度和40点怒气。"
		}
	},
	[10067] = {
		name = "玄鸟",
		skillNameImage = "battle_text_256.png",
		headerImage = "skill_10067.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"生命值为0时，获得一次不死机会，同时吸取敌方生命回复自身生命上限20%",
			"生命值为0时，获得一次不死机会，同时吸取敌方生命回复自身生命上限30%",
			"生命值为0时，首次不死，同时吸取敌方生命回复自身生命上限50%，第二次仍可保留1点生命不死"
		}
	},
	[10068] = {
		name = "水德",
		skillNameImage = "battle_text_257.png",
		headerImage = "skill_10068.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"发动攻击时，降低敌方怒气增加值60%",
			"发动攻击时，降低敌方怒气增加值80%",
			"发动攻击时，敌方不增加怒气"
		}
	},
	[10069] = {
		name = "蔽月",
		skillNameImage = "battle_text_258.png",
		headerImage = "skill_10069.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"{100}%为队友承受第一次致命伤害并至少保留1点生命值。",
			"{100}%为队友承受第一次致命伤害并至少保留1点生命值，且有{30}%概率为队友承受第二次致命伤害并至少保留1点生命值。",
			"{100}%为队友承受第一次致命伤害并至少保留1点生命值，且有{30}%、{10}%概率为队友承受第二次、第三次致命伤害并至少保留1点生命值。"
		}
	},
	[10070] = {
		name = "余浪",
		skillNameImage = "battle_text_259.png",
		headerImage = "skill_10070.png",
		type = SkillType.eTalent,
		quality = QualityType.eOrange,
		desc = {
			"当被攻击死亡时，我方其他全部武将生命值回复{40}%。",
			"当被攻击死亡时，我方其他全部武将生命值回复{50}%。",
			"当被攻击死亡时，我方其他全部武将生命值回复{60}%。"
		}
	}
}
