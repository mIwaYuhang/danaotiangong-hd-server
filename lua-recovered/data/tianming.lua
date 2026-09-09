TianMingUnlockLevel = {
	40,
	40,
	45,
	50,
	55,
	60
}
TianMingType = {
	eType7 = 7,
	eType3 = 3,
	eType4 = 4,
	eType5 = 5,
	eType1 = 1,
	eType6 = 6,
	eType2 = 2
}
TianMingTypeName = {
	[TianMingType.eType1] = string.lf("生命"),
	[TianMingType.eType2] = string.lf("物攻"),
	[TianMingType.eType3] = string.lf("物防"),
	[TianMingType.eType4] = string.lf("法攻"),
	[TianMingType.eType5] = string.lf("法防"),
	[TianMingType.eType6] = string.lf("敏捷"),
	[TianMingType.eType7] = string.lf("特殊")
}
BaseTianMingGus = {
	{
		normalDefense = 16,
		skillAttack = 100,
		name = "一级天命蛊",
		normalAttack = 50,
		image = "tianming_029.png",
		desc = "虚弱敌方阵容对应主将的技能效果10%（仅对玩家生效）",
		speed = 30,
		effectRatio = 0.1,
		needFragNum = 5,
		health = 200,
		skillDefense = 30
	},
	{
		normalDefense = 32,
		skillAttack = 200,
		name = "二级天命蛊",
		normalAttack = 100,
		image = "tianming_030.png",
		desc = "虚弱敌方阵容对应主将的技能效果15%（仅对玩家生效）",
		speed = 60,
		effectRatio = 0.15,
		needFragNum = 10,
		health = 400,
		skillDefense = 60
	},
	{
		normalDefense = 48,
		skillAttack = 300,
		name = "三级天命蛊",
		normalAttack = 150,
		image = "tianming_031.png",
		desc = "虚弱敌方阵容对应主将的技能效果20%（仅对玩家生效）",
		speed = 90,
		effectRatio = 0.2,
		needFragNum = 20,
		health = 600,
		skillDefense = 90
	},
	{
		normalDefense = 64,
		skillAttack = 400,
		name = "四级天命蛊",
		normalAttack = 200,
		image = "tianming_032.png",
		desc = "虚弱敌方阵容对应主将的技能效果25%（仅对玩家生效）",
		speed = 120,
		effectRatio = 0.25,
		needFragNum = 40,
		health = 800,
		skillDefense = 120
	},
	{
		normalDefense = 80,
		skillAttack = 500,
		name = "五级天命蛊",
		normalAttack = 250,
		image = "tianming_033.png",
		desc = "虚弱敌方阵容对应主将的技能效果30%（仅对玩家生效）",
		speed = 150,
		effectRatio = 0.3,
		needFragNum = 100,
		health = 1000,
		skillDefense = 150
	}
}
BaseTianMings = {
	[11] = {
		quality = 1,
		name = "梦离",
		exp = 10,
		headerImage = "small_tianming_038.png",
		type = TianMingType.eType1,
		upgradeData = {
			{
				upgradeExp = 40,
				health = 500
			},
			{
				upgradeExp = 40,
				health = 1000
			},
			{
				upgradeExp = 80,
				health = 1500
			},
			{
				upgradeExp = 160,
				health = 2000
			},
			{
				upgradeExp = 320,
				health = 2500
			},
			{
				upgradeExp = 640,
				health = 3000
			},
			{
				upgradeExp = 1280,
				health = 3500
			},
			{
				upgradeExp = 2560,
				health = 4000
			},
			{
				upgradeExp = 5120,
				health = 4500
			},
			{
				health = 5000
			}
		}
	},
	[12] = {
		quality = 1,
		name = "诛仙",
		exp = 10,
		headerImage = "small_tianming_039.png",
		type = TianMingType.eType2,
		upgradeData = {
			{
				upgradeExp = 40,
				normalAttack = 125
			},
			{
				upgradeExp = 40,
				normalAttack = 250
			},
			{
				upgradeExp = 80,
				normalAttack = 375
			},
			{
				upgradeExp = 160,
				normalAttack = 500
			},
			{
				upgradeExp = 320,
				normalAttack = 625
			},
			{
				upgradeExp = 640,
				normalAttack = 750
			},
			{
				upgradeExp = 1280,
				normalAttack = 875
			},
			{
				upgradeExp = 2560,
				normalAttack = 1000
			},
			{
				upgradeExp = 5120,
				normalAttack = 1125
			},
			{
				normalAttack = 1250
			}
		}
	},
	[13] = {
		quality = 1,
		name = "波磐",
		exp = 10,
		headerImage = "small_tianming_040.png",
		type = TianMingType.eType3,
		upgradeData = {
			{
				upgradeExp = 40,
				normalDefense = 40
			},
			{
				upgradeExp = 40,
				normalDefense = 80
			},
			{
				upgradeExp = 80,
				normalDefense = 120
			},
			{
				upgradeExp = 160,
				normalDefense = 160
			},
			{
				upgradeExp = 320,
				normalDefense = 200
			},
			{
				upgradeExp = 640,
				normalDefense = 240
			},
			{
				upgradeExp = 1280,
				normalDefense = 280
			},
			{
				upgradeExp = 2560,
				normalDefense = 320
			},
			{
				upgradeExp = 5120,
				normalDefense = 360
			},
			{
				normalDefense = 400
			}
		}
	},
	[14] = {
		quality = 1,
		name = "妖炎",
		exp = 10,
		headerImage = "small_tianming_056.png",
		type = TianMingType.eType4,
		upgradeData = {
			{
				upgradeExp = 40,
				skillAttack = 250
			},
			{
				upgradeExp = 40,
				skillAttack = 500
			},
			{
				upgradeExp = 80,
				skillAttack = 750
			},
			{
				upgradeExp = 160,
				skillAttack = 1000
			},
			{
				upgradeExp = 320,
				skillAttack = 1250
			},
			{
				upgradeExp = 640,
				skillAttack = 1500
			},
			{
				upgradeExp = 1280,
				skillAttack = 1750
			},
			{
				upgradeExp = 2560,
				skillAttack = 2000
			},
			{
				upgradeExp = 5120,
				skillAttack = 2250
			},
			{
				skillAttack = 2500
			}
		}
	},
	[15] = {
		quality = 1,
		name = "婆罗",
		exp = 10,
		headerImage = "small_tianming_057.png",
		type = TianMingType.eType5,
		upgradeData = {
			{
				upgradeExp = 40,
				skillDefense = 75
			},
			{
				upgradeExp = 40,
				skillDefense = 150
			},
			{
				upgradeExp = 80,
				skillDefense = 225
			},
			{
				upgradeExp = 160,
				skillDefense = 300
			},
			{
				upgradeExp = 320,
				skillDefense = 375
			},
			{
				upgradeExp = 640,
				skillDefense = 450
			},
			{
				upgradeExp = 1280,
				skillDefense = 525
			},
			{
				upgradeExp = 2560,
				skillDefense = 600
			},
			{
				upgradeExp = 5120,
				skillDefense = 675
			},
			{
				skillDefense = 750
			}
		}
	},
	[16] = {
		quality = 1,
		name = "华庭",
		exp = 10,
		headerImage = "small_tianming_058.png",
		type = TianMingType.eType6,
		upgradeData = {
			{
				speed = 75,
				upgradeExp = 40
			},
			{
				speed = 150,
				upgradeExp = 40
			},
			{
				speed = 225,
				upgradeExp = 80
			},
			{
				speed = 300,
				upgradeExp = 160
			},
			{
				speed = 375,
				upgradeExp = 320
			},
			{
				speed = 450,
				upgradeExp = 640
			},
			{
				speed = 525,
				upgradeExp = 1280
			},
			{
				speed = 600,
				upgradeExp = 2560
			},
			{
				speed = 675,
				upgradeExp = 5120
			},
			{
				speed = 750
			}
		}
	},
	[21] = {
		quality = 2,
		name = "颐养",
		exp = 20,
		headerImage = "small_tianming_035.png",
		type = TianMingType.eType1,
		upgradeData = {
			{
				poji = 50,
				upgradeExp = 80,
				health = 1000
			},
			{
				poji = 75,
				upgradeExp = 80,
				health = 1500
			},
			{
				poji = 100,
				upgradeExp = 160,
				health = 2000
			},
			{
				poji = 125,
				upgradeExp = 320,
				health = 2500
			},
			{
				poji = 150,
				upgradeExp = 640,
				health = 3000
			},
			{
				poji = 175,
				upgradeExp = 1280,
				health = 3500
			},
			{
				poji = 200,
				upgradeExp = 2560,
				health = 4000
			},
			{
				poji = 225,
				upgradeExp = 5120,
				health = 4500
			},
			{
				poji = 250,
				upgradeExp = 10240,
				health = 5000
			},
			{
				poji = 275,
				health = 5500
			}
		}
	},
	[22] = {
		quality = 2,
		name = "剑卜",
		exp = 20,
		headerImage = "small_tianming_036.png",
		type = TianMingType.eType2,
		upgradeData = {
			{
				upgradeExp = 80,
				normalAttack = 250,
				shanbi = 50
			},
			{
				upgradeExp = 80,
				normalAttack = 375,
				shanbi = 75
			},
			{
				upgradeExp = 160,
				normalAttack = 500,
				shanbi = 100
			},
			{
				upgradeExp = 320,
				normalAttack = 625,
				shanbi = 125
			},
			{
				upgradeExp = 640,
				normalAttack = 750,
				shanbi = 150
			},
			{
				upgradeExp = 1280,
				normalAttack = 875,
				shanbi = 175
			},
			{
				upgradeExp = 2560,
				normalAttack = 1000,
				shanbi = 200
			},
			{
				upgradeExp = 5120,
				normalAttack = 1125,
				shanbi = 225
			},
			{
				upgradeExp = 10240,
				normalAttack = 1250,
				shanbi = 250
			},
			{
				shanbi = 275,
				normalAttack = 1375
			}
		}
	},
	[23] = {
		quality = 2,
		name = "虎贲",
		exp = 20,
		headerImage = "small_tianming_037.png",
		type = TianMingType.eType3,
		upgradeData = {
			{
				upgradeExp = 80,
				baoji = 50,
				normalDefense = 80
			},
			{
				upgradeExp = 80,
				baoji = 75,
				normalDefense = 120
			},
			{
				upgradeExp = 160,
				baoji = 100,
				normalDefense = 160
			},
			{
				upgradeExp = 320,
				baoji = 125,
				normalDefense = 200
			},
			{
				upgradeExp = 640,
				baoji = 150,
				normalDefense = 240
			},
			{
				upgradeExp = 1280,
				baoji = 175,
				normalDefense = 280
			},
			{
				upgradeExp = 2560,
				baoji = 200,
				normalDefense = 320
			},
			{
				upgradeExp = 5120,
				baoji = 225,
				normalDefense = 360
			},
			{
				upgradeExp = 10240,
				baoji = 250,
				normalDefense = 400
			},
			{
				baoji = 275,
				normalDefense = 440
			}
		}
	},
	[24] = {
		quality = 2,
		name = "岩打",
		exp = 20,
		headerImage = "small_tianming_053.png",
		type = TianMingType.eType4,
		upgradeData = {
			{
				upgradeExp = 80,
				skillAttack = 500,
				renxing = 50
			},
			{
				upgradeExp = 80,
				skillAttack = 750,
				renxing = 75
			},
			{
				upgradeExp = 160,
				skillAttack = 1000,
				renxing = 100
			},
			{
				upgradeExp = 320,
				skillAttack = 1250,
				renxing = 125
			},
			{
				upgradeExp = 640,
				skillAttack = 1500,
				renxing = 150
			},
			{
				upgradeExp = 1280,
				skillAttack = 1750,
				renxing = 175
			},
			{
				upgradeExp = 2560,
				skillAttack = 2000,
				renxing = 200
			},
			{
				upgradeExp = 5120,
				skillAttack = 2250,
				renxing = 225
			},
			{
				upgradeExp = 10240,
				skillAttack = 2500,
				renxing = 250
			},
			{
				renxing = 275,
				skillAttack = 2750
			}
		}
	},
	[25] = {
		quality = 2,
		name = "散华",
		exp = 20,
		headerImage = "small_tianming_054.png",
		type = TianMingType.eType5,
		upgradeData = {
			{
				upgradeExp = 80,
				skillDefense = 150,
				mingzhong = 50
			},
			{
				upgradeExp = 80,
				skillDefense = 225,
				mingzhong = 75
			},
			{
				upgradeExp = 160,
				skillDefense = 300,
				mingzhong = 100
			},
			{
				upgradeExp = 320,
				skillDefense = 375,
				mingzhong = 125
			},
			{
				upgradeExp = 640,
				skillDefense = 450,
				mingzhong = 150
			},
			{
				upgradeExp = 1280,
				skillDefense = 525,
				mingzhong = 175
			},
			{
				upgradeExp = 2560,
				skillDefense = 600,
				mingzhong = 200
			},
			{
				upgradeExp = 5120,
				skillDefense = 675,
				mingzhong = 225
			},
			{
				upgradeExp = 10240,
				skillDefense = 750,
				mingzhong = 250
			},
			{
				mingzhong = 275,
				skillDefense = 825
			}
		}
	},
	[26] = {
		quality = 2,
		name = "破军",
		exp = 20,
		headerImage = "small_tianming_055.png",
		type = TianMingType.eType6,
		upgradeData = {
			{
				gedang = 50,
				upgradeExp = 80,
				speed = 150
			},
			{
				gedang = 75,
				upgradeExp = 80,
				speed = 225
			},
			{
				gedang = 100,
				upgradeExp = 160,
				speed = 300
			},
			{
				gedang = 125,
				upgradeExp = 320,
				speed = 375
			},
			{
				gedang = 150,
				upgradeExp = 640,
				speed = 450
			},
			{
				gedang = 175,
				upgradeExp = 1280,
				speed = 525
			},
			{
				gedang = 200,
				upgradeExp = 2560,
				speed = 600
			},
			{
				gedang = 225,
				upgradeExp = 5120,
				speed = 675
			},
			{
				gedang = 250,
				upgradeExp = 10240,
				speed = 750
			},
			{
				speed = 825,
				gedang = 275
			}
		}
	},
	[31] = {
		quality = 3,
		name = "万寿无疆",
		exp = 40,
		headerImage = "small_tianming_041.png",
		type = TianMingType.eType1,
		upgradeData = {
			{
				poji = 100,
				upgradeExp = 160,
				health = 2000
			},
			{
				poji = 150,
				upgradeExp = 160,
				health = 3000
			},
			{
				poji = 200,
				upgradeExp = 320,
				health = 4000
			},
			{
				poji = 250,
				upgradeExp = 640,
				health = 5000
			},
			{
				poji = 300,
				upgradeExp = 1280,
				health = 6000
			},
			{
				poji = 350,
				upgradeExp = 2560,
				health = 7000
			},
			{
				poji = 400,
				upgradeExp = 5120,
				health = 8000
			},
			{
				poji = 450,
				upgradeExp = 10240,
				health = 9000
			},
			{
				poji = 500,
				upgradeExp = 20480,
				health = 10000
			},
			{
				poji = 550,
				health = 11000
			}
		}
	},
	[32] = {
		quality = 3,
		name = "逢龙遇虎",
		exp = 40,
		headerImage = "small_tianming_042.png",
		type = TianMingType.eType2,
		upgradeData = {
			{
				upgradeExp = 160,
				normalAttack = 500,
				shanbi = 100
			},
			{
				upgradeExp = 160,
				normalAttack = 750,
				shanbi = 150
			},
			{
				upgradeExp = 320,
				normalAttack = 1000,
				shanbi = 200
			},
			{
				upgradeExp = 640,
				normalAttack = 1250,
				shanbi = 250
			},
			{
				upgradeExp = 1280,
				normalAttack = 1500,
				shanbi = 300
			},
			{
				upgradeExp = 2560,
				normalAttack = 1750,
				shanbi = 350
			},
			{
				upgradeExp = 5120,
				normalAttack = 2000,
				shanbi = 400
			},
			{
				upgradeExp = 10240,
				normalAttack = 2250,
				shanbi = 450
			},
			{
				upgradeExp = 20480,
				normalAttack = 2500,
				shanbi = 500
			},
			{
				shanbi = 550,
				normalAttack = 2750
			}
		}
	},
	[33] = {
		quality = 3,
		name = "霸者横栏",
		exp = 40,
		headerImage = "small_tianming_043.png",
		type = TianMingType.eType3,
		upgradeData = {
			{
				upgradeExp = 160,
				baoji = 100,
				normalDefense = 160
			},
			{
				upgradeExp = 160,
				baoji = 150,
				normalDefense = 240
			},
			{
				upgradeExp = 320,
				baoji = 200,
				normalDefense = 320
			},
			{
				upgradeExp = 640,
				baoji = 250,
				normalDefense = 400
			},
			{
				upgradeExp = 1280,
				baoji = 300,
				normalDefense = 480
			},
			{
				upgradeExp = 2560,
				baoji = 350,
				normalDefense = 560
			},
			{
				upgradeExp = 5120,
				baoji = 400,
				normalDefense = 640
			},
			{
				upgradeExp = 10240,
				baoji = 450,
				normalDefense = 720
			},
			{
				upgradeExp = 20480,
				baoji = 500,
				normalDefense = 800
			},
			{
				baoji = 550,
				normalDefense = 880
			}
		}
	},
	[34] = {
		quality = 3,
		name = "天地无用",
		exp = 40,
		headerImage = "small_tianming_059.png",
		type = TianMingType.eType4,
		upgradeData = {
			{
				upgradeExp = 160,
				skillAttack = 1000,
				renxing = 100
			},
			{
				upgradeExp = 160,
				skillAttack = 1500,
				renxing = 150
			},
			{
				upgradeExp = 320,
				skillAttack = 2000,
				renxing = 200
			},
			{
				upgradeExp = 640,
				skillAttack = 2500,
				renxing = 250
			},
			{
				upgradeExp = 1280,
				skillAttack = 3000,
				renxing = 300
			},
			{
				upgradeExp = 2560,
				skillAttack = 3500,
				renxing = 350
			},
			{
				upgradeExp = 5120,
				skillAttack = 4000,
				renxing = 400
			},
			{
				upgradeExp = 10240,
				skillAttack = 4500,
				renxing = 450
			},
			{
				upgradeExp = 20480,
				skillAttack = 5000,
				renxing = 500
			},
			{
				renxing = 550,
				skillAttack = 5500
			}
		}
	},
	[35] = {
		quality = 3,
		name = "百步穿扬",
		exp = 40,
		headerImage = "small_tianming_060.png",
		type = TianMingType.eType5,
		upgradeData = {
			{
				upgradeExp = 160,
				skillDefense = 300,
				mingzhong = 100
			},
			{
				upgradeExp = 160,
				skillDefense = 450,
				mingzhong = 150
			},
			{
				upgradeExp = 320,
				skillDefense = 600,
				mingzhong = 200
			},
			{
				upgradeExp = 640,
				skillDefense = 750,
				mingzhong = 250
			},
			{
				upgradeExp = 1280,
				skillDefense = 900,
				mingzhong = 300
			},
			{
				upgradeExp = 2560,
				skillDefense = 1050,
				mingzhong = 350
			},
			{
				upgradeExp = 5120,
				skillDefense = 1200,
				mingzhong = 400
			},
			{
				upgradeExp = 10240,
				skillDefense = 1350,
				mingzhong = 450
			},
			{
				upgradeExp = 20480,
				skillDefense = 1500,
				mingzhong = 500
			},
			{
				mingzhong = 550,
				skillDefense = 1650
			}
		}
	},
	[36] = {
		quality = 3,
		name = "一元复始",
		exp = 40,
		headerImage = "small_tianming_061.png",
		type = TianMingType.eType6,
		upgradeData = {
			{
				gedang = 100,
				upgradeExp = 160,
				speed = 300
			},
			{
				gedang = 150,
				upgradeExp = 160,
				speed = 450
			},
			{
				gedang = 200,
				upgradeExp = 320,
				speed = 600
			},
			{
				gedang = 250,
				upgradeExp = 640,
				speed = 750
			},
			{
				gedang = 300,
				upgradeExp = 1280,
				speed = 900
			},
			{
				gedang = 350,
				upgradeExp = 2560,
				speed = 1050
			},
			{
				gedang = 400,
				upgradeExp = 5120,
				speed = 1200
			},
			{
				gedang = 450,
				upgradeExp = 10240,
				speed = 1350
			},
			{
				gedang = 500,
				upgradeExp = 20480,
				speed = 1500
			},
			{
				speed = 1650,
				gedang = 550
			}
		}
	},
	[41] = {
		quality = 4,
		name = "破碎虚空",
		exp = 240,
		headerImage = "small_tianming_026.png",
		type = TianMingType.eType1,
		upgradeData = {
			{
				poji = 200,
				upgradeExp = 320,
				health = 4000
			},
			{
				poji = 300,
				upgradeExp = 320,
				health = 6000
			},
			{
				poji = 400,
				upgradeExp = 640,
				health = 8000
			},
			{
				poji = 500,
				upgradeExp = 1280,
				health = 10000
			},
			{
				poji = 600,
				upgradeExp = 2560,
				health = 12000
			},
			{
				poji = 700,
				upgradeExp = 5120,
				health = 14000
			},
			{
				poji = 800,
				upgradeExp = 10240,
				health = 16000
			},
			{
				poji = 900,
				upgradeExp = 20480,
				health = 18000
			},
			{
				poji = 1000,
				upgradeExp = 40960,
				health = 20000
			},
			{
				poji = 1100,
				health = 22000
			}
		}
	},
	[42] = {
		quality = 4,
		name = "叱咤风云",
		exp = 240,
		headerImage = "small_tianming_027.png",
		type = TianMingType.eType2,
		upgradeData = {
			{
				upgradeExp = 320,
				normalAttack = 1000,
				shanbi = 200
			},
			{
				upgradeExp = 320,
				normalAttack = 1500,
				shanbi = 300
			},
			{
				upgradeExp = 640,
				normalAttack = 2000,
				shanbi = 400
			},
			{
				upgradeExp = 1280,
				normalAttack = 2500,
				shanbi = 500
			},
			{
				upgradeExp = 2560,
				normalAttack = 3000,
				shanbi = 600
			},
			{
				upgradeExp = 5120,
				normalAttack = 3500,
				shanbi = 700
			},
			{
				upgradeExp = 10240,
				normalAttack = 4000,
				shanbi = 800
			},
			{
				upgradeExp = 20480,
				normalAttack = 4500,
				shanbi = 900
			},
			{
				upgradeExp = 40960,
				normalAttack = 5000,
				shanbi = 1000
			},
			{
				shanbi = 1100,
				normalAttack = 5500
			}
		}
	},
	[43] = {
		quality = 4,
		name = "大破坏神",
		exp = 240,
		headerImage = "small_tianming_028.png",
		type = TianMingType.eType3,
		upgradeData = {
			{
				upgradeExp = 320,
				baoji = 200,
				normalDefense = 320
			},
			{
				upgradeExp = 320,
				baoji = 300,
				normalDefense = 480
			},
			{
				upgradeExp = 640,
				baoji = 400,
				normalDefense = 640
			},
			{
				upgradeExp = 1280,
				baoji = 500,
				normalDefense = 800
			},
			{
				upgradeExp = 2560,
				baoji = 600,
				normalDefense = 960
			},
			{
				upgradeExp = 5120,
				baoji = 700,
				normalDefense = 1120
			},
			{
				upgradeExp = 10240,
				baoji = 800,
				normalDefense = 1280
			},
			{
				upgradeExp = 20480,
				baoji = 900,
				normalDefense = 1440
			},
			{
				upgradeExp = 40960,
				baoji = 1000,
				normalDefense = 1600
			},
			{
				baoji = 1100,
				normalDefense = 1760
			}
		}
	},
	[44] = {
		quality = 4,
		name = "国破境绝",
		exp = 240,
		headerImage = "small_tianming_044.png",
		type = TianMingType.eType4,
		upgradeData = {
			{
				upgradeExp = 320,
				skillAttack = 2000,
				renxing = 200
			},
			{
				upgradeExp = 320,
				skillAttack = 3000,
				renxing = 300
			},
			{
				upgradeExp = 640,
				skillAttack = 4000,
				renxing = 400
			},
			{
				upgradeExp = 1280,
				skillAttack = 5000,
				renxing = 500
			},
			{
				upgradeExp = 2560,
				skillAttack = 6000,
				renxing = 600
			},
			{
				upgradeExp = 5120,
				skillAttack = 7000,
				renxing = 700
			},
			{
				upgradeExp = 10240,
				skillAttack = 8000,
				renxing = 800
			},
			{
				upgradeExp = 20480,
				skillAttack = 9000,
				renxing = 900
			},
			{
				upgradeExp = 40960,
				skillAttack = 10000,
				renxing = 1000
			},
			{
				renxing = 1100,
				skillAttack = 11000
			}
		}
	},
	[45] = {
		quality = 4,
		name = "斗星转移",
		exp = 240,
		headerImage = "small_tianming_045.png",
		type = TianMingType.eType5,
		upgradeData = {
			{
				upgradeExp = 320,
				skillDefense = 600,
				mingzhong = 200
			},
			{
				upgradeExp = 320,
				skillDefense = 900,
				mingzhong = 300
			},
			{
				upgradeExp = 640,
				skillDefense = 1200,
				mingzhong = 400
			},
			{
				upgradeExp = 1280,
				skillDefense = 1500,
				mingzhong = 500
			},
			{
				upgradeExp = 2560,
				skillDefense = 1800,
				mingzhong = 600
			},
			{
				upgradeExp = 5120,
				skillDefense = 2100,
				mingzhong = 700
			},
			{
				upgradeExp = 10240,
				skillDefense = 2400,
				mingzhong = 800
			},
			{
				upgradeExp = 20480,
				skillDefense = 2700,
				mingzhong = 900
			},
			{
				upgradeExp = 40960,
				skillDefense = 3000,
				mingzhong = 1000
			},
			{
				mingzhong = 1100,
				skillDefense = 3300
			}
		}
	},
	[46] = {
		quality = 4,
		name = "轩辕剑体",
		exp = 240,
		headerImage = "small_tianming_046.png",
		type = TianMingType.eType6,
		upgradeData = {
			{
				gedang = 200,
				upgradeExp = 320,
				speed = 600
			},
			{
				gedang = 300,
				upgradeExp = 320,
				speed = 900
			},
			{
				gedang = 400,
				upgradeExp = 640,
				speed = 1200
			},
			{
				gedang = 500,
				upgradeExp = 1280,
				speed = 1500
			},
			{
				gedang = 600,
				upgradeExp = 2560,
				speed = 1800
			},
			{
				gedang = 700,
				upgradeExp = 5120,
				speed = 2100
			},
			{
				gedang = 800,
				upgradeExp = 10240,
				speed = 2400
			},
			{
				gedang = 900,
				upgradeExp = 20480,
				speed = 2700
			},
			{
				gedang = 1000,
				upgradeExp = 40960,
				speed = 3000
			},
			{
				speed = 3300,
				gedang = 1100
			}
		}
	},
	[17] = {
		quality = 1,
		name = "初级经验",
		exp = 40,
		headerImage = "small_tianming_066.png",
		type = TianMingType.eType7,
		upgradeData = {
			{
				upgradeExp = 40
			},
			{
				upgradeExp = 40
			},
			{
				upgradeExp = 80
			},
			{
				upgradeExp = 160
			},
			{
				upgradeExp = 320
			},
			{
				upgradeExp = 640
			},
			{
				upgradeExp = 1280
			},
			{
				upgradeExp = 2560
			},
			{
				upgradeExp = 5120
			},
			{}
		}
	},
	[27] = {
		quality = 2,
		name = "中级经验",
		exp = 80,
		headerImage = "small_tianming_065.png",
		type = TianMingType.eType7,
		upgradeData = {
			{
				upgradeExp = 80
			},
			{
				upgradeExp = 80
			},
			{
				upgradeExp = 160
			},
			{
				upgradeExp = 320
			},
			{
				upgradeExp = 640
			},
			{
				upgradeExp = 1280
			},
			{
				upgradeExp = 2560
			},
			{
				upgradeExp = 5120
			},
			{
				upgradeExp = 10240
			},
			{}
		}
	},
	[37] = {
		quality = 3,
		name = "高级经验",
		exp = 320,
		headerImage = "small_tianming_067.png",
		type = TianMingType.eType7,
		upgradeData = {
			{
				upgradeExp = 320
			},
			{
				upgradeExp = 320
			},
			{
				upgradeExp = 640
			},
			{
				upgradeExp = 1280
			},
			{
				upgradeExp = 2560
			},
			{
				upgradeExp = 5120
			},
			{
				upgradeExp = 10240
			},
			{
				upgradeExp = 20480
			},
			{
				upgradeExp = 40960
			},
			{}
		}
	},
	[47] = {
		quality = 4,
		name = "超级经验",
		exp = 1280,
		headerImage = "small_tianming_062.png",
		type = TianMingType.eType7,
		upgradeData = {
			{
				upgradeExp = 1280
			},
			{
				upgradeExp = 1280
			},
			{
				upgradeExp = 2560
			},
			{
				upgradeExp = 5120
			},
			{
				upgradeExp = 10240
			},
			{
				upgradeExp = 20480
			},
			{
				upgradeExp = 40960
			},
			{
				upgradeExp = 81920
			},
			{
				upgradeExp = 163840
			},
			{}
		}
	}
}
