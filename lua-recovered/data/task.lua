require("data.taskType")

InitHerosConfig = {
	{
		heroId = 101,
		nameSprite = "ui/account/account_020.png",
		perfectWeaponId = 0
	},
	{
		heroId = 112,
		nameSprite = "ui/account/account_021.png",
		perfectWeaponId = 0
	},
	{
		heroId = 128,
		nameSprite = "ui/account/account_018.png",
		perfectWeaponId = 0
	}
}
TaskArrowDirType = {
	eArrowDirRight = 4,
	eArrowDirDown = 2,
	eArrowDirUp = 1,
	eArrowDirLeft = 3
}
TaskArrowRotationAngle = {
	[TaskArrowDirType.eArrowDirUp] = -90,
	[TaskArrowDirType.eArrowDirDown] = 90,
	[TaskArrowDirType.eArrowDirLeft] = 180,
	[TaskArrowDirType.eArrowDirRight] = 0
}
TaskTextSpritePos = {
	[TaskArrowDirType.eArrowDirUp] = ccp(-28, 18),
	[TaskArrowDirType.eArrowDirDown] = ccp(-28, 18),
	[TaskArrowDirType.eArrowDirLeft] = ccp(-70, 20),
	[TaskArrowDirType.eArrowDirRight] = ccp(-70, 20)
}
TaskStatus = {
	eProcessing = 2,
	eCompleted = 3,
	eAcceptable = 1
}
TaskType = {
	eTaskPlotline = 2,
	eTaskCopy = 4,
	eTaskBranchline = 3,
	eTaskDaily = 5,
	eTaskTeaching = 1
}
TaskTypeOrder = {
	[TaskType.eTaskTeaching] = 2,
	[TaskType.eTaskPlotline] = 1,
	[TaskType.eTaskBranchline] = 3,
	[TaskType.eTaskCopy] = 4,
	[TaskType.eTaskDaily] = 5
}
TaskTypeNames = {
	[TaskType.eTaskTeaching] = string.lf("特"),
	[TaskType.eTaskPlotline] = string.lf("主"),
	[TaskType.eTaskBranchline] = string.lf("支"),
	[TaskType.eTaskCopy] = string.lf("副本"),
	[TaskType.eTaskDaily] = string.lf("日")
}
TaskEntryCheckPointType = {
	eNone = 0,
	eDoubleStarTreasureBox = 20,
	eFirstBattleThreeStar = 3,
	eFirstBattleDoubleStar = 2,
	eMax = 100,
	eThreeStarTreasureBox = 30,
	eTenStarTreasureBox = 10
}
TaskDisplayType = {
	[TaskEntryType.eEntryNpc] = 0,
	[TaskEntryType.eEntryTower] = 1,
	[TaskEntryType.eEntryTransport] = 1,
	[TaskEntryType.eEntryTechnologyMagic] = 0,
	[TaskEntryType.eEntrySacrifice] = 0,
	[TaskEntryType.eEntryDuelDefeat] = 1,
	[TaskEntryType.eEntryDuelRanking] = 1,
	[TaskEntryType.eEntryDarkhouseCapture] = 1,
	[TaskEntryType.eEntryDarkhouseBleedWhite] = 0,
	[TaskEntryType.eEntryFriend] = 0,
	[TaskEntryType.eEntryTalismanIntensify] = 0,
	[TaskEntryType.eEntryHeroSkill] = 0,
	[TaskEntryType.eEntryTalismanRecast] = 0,
	[TaskEntryType.eEntryTalismanFeed] = 0,
	[TaskEntryType.eEntryHeroBreakthrough] = 0,
	[TaskEntryType.eEntryHeroTrain] = 0,
	[TaskEntryType.eEntryViceheroIntenify] = 0,
	[TaskEntryType.eEntryBattleHero] = 1,
	[TaskEntryType.eEntryProtectTransport] = 1,
	[TaskEntryType.eEntryBattleVicehero] = 0,
	[TaskEntryType.eEntryFukatsuTemple] = 1,
	[TaskEntryType.eEntryCopy] = 1,
	[TaskEntryType.CheckPoint] = 1,
	[TaskEntryType.eMysterystore] = 0,
	[TaskEntryType.eRefining] = 0,
	[TaskEntryType.eZhaoJiang] = 1,
	[TaskEntryType.eShenQi] = 0,
	[TaskEntryType.eXianMeng] = 1,
	[TaskEntryType.eXianmoFight] = 0,
	[TaskEntryType.eHeroPractice] = 0,
	[TaskEntryType.eTransportRob] = 0,
	[TaskEntryType.eTianMing] = 0,
	[TaskEntryType.eTianMingGu] = 0,
	[TaskEntryType.eXunFangNormal] = 0
}
TaskEntryData = {
	[TaskEntryType.eEntryNpc] = {
		{
			isInMaskLayer = true,
			pos = ccp(Adapter.AutoPosY(141), Adapter.AutoPosY(341)),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(0, 0),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(400, 60),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eEntryTower] = {
		{
			isInMaskLayer = true,
			pos = ccp(display.cx - Adapter.AutoPosX(350), Adapter.AutoPosY(248)),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(480, 180),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(750, 226),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eEntryTransport] = {
		{
			isInMaskLayer = true,
			pos = ccp(Adapter.AutoPosY(1439), Adapter.AutoPosY(300)),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(105 * Adapter.WidthScale, 470 * Adapter.HeightScale),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(450, 70),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eEntryTechnologyMagic] = {
		{
			isInMaskLayer = true,
			pos = ccp(Adapter.AutoPosY(1117), Adapter.AutoPosY(292)),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(100, 0),
			arrowType = TaskArrowDirType.eArrowDirUp
		}
	},
	[TaskEntryType.eEntrySacrifice] = {
		{
			isInMaskLayer = true,
			pos = ccp(Adapter.AutoPosY(1700), Adapter.AutoPosY(341)),
			arrowType = TaskArrowDirType.eArrowDirRight
		},
		{
			pos = ccp(0, 0),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(100, 200),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eEntryDuelDefeat] = {
		{
			isInMaskLayer = true,
			pos = ccp(Adapter.AutoPosY(830), Adapter.AutoPosY(385)),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(170, 420),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(500, 440),
			arrowType = TaskArrowDirType.eArrowDirLeft
		}
	},
	[TaskEntryType.eEntryDuelRanking] = {
		{
			isInMaskLayer = true,
			pos = ccp(Adapter.AutoPosY(830), Adapter.AutoPosY(385)),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			isInMaskLayer = true,
			pos = ccp(170, 420),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(100, 200),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eEntryDarkhouseCapture] = {
		{
			isInMaskLayer = true,
			pos = ccp(Adapter.AutoPosY(830), Adapter.AutoPosY(385)),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(410, 420),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(110, 260),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(345, 350),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(382, 10),
			arrowType = TaskArrowDirType.eArrowDirUp
		}
	},
	[TaskEntryType.eEntryDarkhouseBleedWhite] = {
		{
			isInMaskLayer = true,
			pos = ccp(Adapter.AutoPosY(830), Adapter.AutoPosY(385)),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(410, 420),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eEntryFriend] = {
		{
			showPackButton = true,
			pos = Adapter.AutoPos(725, 100),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(850, 500),
			arrowType = TaskArrowDirType.eArrowDirUp
		},
		{
			pos = ccp(140, 135),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(180, 30),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eEntryTalismanIntensify] = {
		{
			pos = ccp(100, 200),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(100, 200),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eEntryHeroSkill] = {
		{
			showPackButton = true,
			pos = Adapter.AutoPos(365, 100),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(725, 490),
			arrowType = TaskArrowDirType.eArrowDirUp
		}
	},
	[TaskEntryType.eEntryTalismanRecast] = {
		{
			showPackButton = true,
			pos = Adapter.AutoPos(455, 100),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(865, 490),
			arrowType = TaskArrowDirType.eArrowDirUp
		}
	},
	[TaskEntryType.eEntryTalismanFeed] = {
		{
			showPackButton = true,
			pos = Adapter.AutoPos(455, 100),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(725, 490),
			arrowType = TaskArrowDirType.eArrowDirUp
		}
	},
	[TaskEntryType.eEntryHeroBreakthrough] = {
		{
			showPackButton = true,
			pos = Adapter.AutoPos(365, 100),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(725, 490),
			arrowType = TaskArrowDirType.eArrowDirUp
		}
	},
	[TaskEntryType.eEntryHeroTrain] = {
		{
			showPackButton = true,
			pos = Adapter.AutoPos(365, 100),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(865, 490),
			arrowType = TaskArrowDirType.eArrowDirUp
		}
	},
	[TaskEntryType.eEntryViceheroIntenify] = {
		{
			pos = ccp(100, 200),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(100, 200),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eEntryBattleHero] = {
		{
			showPackButton = true,
			pos = Adapter.AutoPos(365, 100),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(100, 125),
			arrowType = TaskArrowDirType.eArrowDirLeft
		},
		{
			pos = ccp(120, 80),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eEntryProtectTransport] = {
		{
			isInMaskLayer = true,
			pos = ccp(Adapter.AutoPosY(1439), Adapter.AutoPosY(300)),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eEntryBattleVicehero] = {
		{
			showPackButton = true,
			pos = Adapter.AutoPos(555, 100),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(415, 560),
			arrowType = TaskArrowDirType.eArrowDirUp
		},
		{
			pos = ccp(75, 475),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(0, 10),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(165, 480),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eEntryFukatsuTemple] = {
		{
			isInMaskLayer = true,
			pos = ccp(Adapter.AutoPosY(830), Adapter.AutoPosY(385)),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(660, 420),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(100, 200),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eEntryCopy] = {
		{
			isInMaskLayer = true,
			pos = ccp(Adapter.AutoPosY(336), Adapter.AutoPosY(468)),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(115, 380),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(480, 200),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(665, 0),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.CheckPoint] = {
		{
			isInMaskLayer = true,
			pos = ccp(Adapter.AutoPosY(595), Adapter.AutoPosY(232)),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(40, 120),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(500, 360),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eMysterystore] = {
		{
			pos = Adapter.AutoPos(840, 345),
			arrowType = TaskArrowDirType.eArrowDirRight
		}
	},
	[TaskEntryType.eRefining] = {
		{
			isInMaskLayer = true,
			pos = ccp(Adapter.AutoPosY(1650), Adapter.AutoPosY(341)),
			arrowType = TaskArrowDirType.eArrowDirRight
		},
		{
			pos = ccp(80, 80),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(500, 490),
			arrowType = TaskArrowDirType.eArrowDirLeft
		},
		{
			pos = ccp(730, 75),
			arrowType = TaskArrowDirType.eArrowDirUp
		}
	},
	[TaskEntryType.eZhaoJiang] = {
		{
			pos = Adapter.AutoPos(840, 460),
			arrowType = TaskArrowDirType.eArrowDirRight
		},
		{
			pos = ccp(146, 100),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eShenQi] = {
		{
			isInMaskLayer = true,
			pos = ccp(Adapter.AutoPosY(336), Adapter.AutoPosY(468)),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(510, 380),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(67, 110),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(60, 80),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(67, 110),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eXianMeng] = {
		{
			showPackButton = true,
			pos = Adapter.AutoPos(275, 100),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eXianmoFight] = {
		{
			isInMaskLayer = true,
			pos = ccp(Adapter.AutoPosY(830), Adapter.AutoPosY(385)),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(165, 200),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(display.cx, display.cy),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eHeroPractice] = {
		{
			showPackButton = true,
			pos = Adapter.AutoPos(365, 100),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(300, 300),
			arrowType = TaskArrowDirType.eArrowDirUp
		},
		{
			pos = ccp(475, 160),
			arrowType = TaskArrowDirType.eArrowDirUp
		},
		{
			pos = Adapter.AutoPos(160, 130),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eShowEverydayTask] = {
		{
			pos = Adapter.AutoPos(905, 500),
			arrowType = TaskArrowDirType.eArrowDirUp
		},
		{
			pos = ccp(646, 440),
			arrowType = TaskArrowDirType.eArrowDirRight
		}
	},
	[TaskEntryType.eGuideXianMoZhengBa] = {
		{
			isInMaskLayer = true,
			pos = ccp(Adapter.AutoPosY(830), Adapter.AutoPosY(385)),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(660, 420),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eGuideXiaohuoban] = {
		{
			showPackButton = true,
			pos = Adapter.AutoPos(365, 100),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(100, 125),
			arrowType = TaskArrowDirType.eArrowDirLeft
		},
		{
			pos = ccp(120, 80),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eTransportRob] = {
		{
			isInMaskLayer = true,
			pos = ccp(Adapter.AutoPosY(1439), Adapter.AutoPosY(300)),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(480 * Adapter.WidthScale, 400 * Adapter.HeightScale),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eTianMing] = {
		{
			isInMaskLayer = true,
			pos = ccp(Adapter.AutoPosY(336), Adapter.AutoPosY(468)),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(315, 380),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(0, 0),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(0, 0),
			arrowType = TaskArrowDirType.eArrowDirUp
		},
		{
			pos = ccp(0, 0),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(0, 0),
			arrowType = TaskArrowDirType.eArrowDirLeft
		},
		{
			pos = ccp(580, 400),
			arrowType = TaskArrowDirType.eArrowDirUp
		},
		{
			pos = ccp(0, 0),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eTianMingGu] = {
		{
			isInMaskLayer = true,
			pos = ccp(Adapter.AutoPosY(336), Adapter.AutoPosY(468)),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(315, 380),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(0, 0),
			arrowType = TaskArrowDirType.eArrowDirLeft
		},
		{
			pos = ccp(0, 0),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(630, 40),
			arrowType = TaskArrowDirType.eArrowDirRight
		}
	},
	[TaskEntryType.eXunFangNormal] = {
		{
			isInMaskLayer = true,
			pos = ccp(Adapter.AutoPosY(336), Adapter.AutoPosY(468)),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(705, 380),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(390, 160),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	},
	[TaskEntryType.eBaiShi] = {
		{
			isInMaskLayer = true,
			pos = ccp(Adapter.AutoPosY(336), Adapter.AutoPosY(468)),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(705, 380),
			arrowType = TaskArrowDirType.eArrowDirDown
		},
		{
			pos = ccp(810, 280),
			arrowType = TaskArrowDirType.eArrowDirRight
		}
	},
	[TaskEntryType.eHeroTransfer] = {
		{
			pos = Adapter.AutoPos(800, 130),
			arrowType = TaskArrowDirType.eArrowDirDown
		}
	}
}
NSStep = {
	ZhanYi4Reward = 12,
	ZhanYi3 = 9,
	ZhanYi2 = 8,
	ZhanYi4 = 10,
	DuanZao1 = 17,
	ZhanYi5 = 21,
	TempStepID = 27,
	XuanJiang = 1,
	ZhanYi6 = 22,
	ZhanYi6Reward = 23,
	ZhuJiangJinjie = 26,
	HuanZhuangbei = 15,
	DuanZao2 = 19,
	ZhanYi1 = 7,
	ZhaoJiang = 5
}
NewbieTaskData = {
	{
		text = string.lf("上仙，在这里可以招到更给力的小伙伴哦"),
		textPos = ccp(480, 350),
		arrowType = TaskArrowDirType.eArrowDirDown,
		arrowPos = Adapter.AutoPos(900, 458),
		buttonSize = CCSize(200, 120)
	},
	{
		text = string.lf("点击招募一个给力的小伙伴吧，并且过段时间都能免费一次哦"),
		textPos = ccp(480, 350),
		arrowType = TaskArrowDirType.eArrowDirDown,
		arrowPos = ccp(780, 60),
		buttonSize = CCSize(200, 130)
	},
	{
		text = string.lf("恭喜上仙获得第一个仙将，大闹天宫需要积攒实力"),
		textPos = ccp(480, 160),
		arrowType = TaskArrowDirType.eArrowDirUp,
		arrowPos = Adapter.AutoPos(880, 570),
		buttonSize = CCSize(200, 130)
	},
	{
		text = string.lf("得到了小伙伴，怎么能让他空虚寂寞冷，点阵容让他上阵吧"),
		textPos = ccp(480, 350),
		arrowType = TaskArrowDirType.eArrowDirDown,
		arrowPos = Adapter.AutoPos(360, 60),
		buttonSize = CCSize(130, 130)
	},
	{
		text = string.lf("更换成功，让我们去战役看看这些仙将的本事吧"),
		textPos = ccp(480, 160),
		arrowType = TaskArrowDirType.eArrowDirRight,
		arrowPos = ccp(900, 590),
		buttonSize = CCSize(200, 130)
	},
	{
		text = string.lf("这里是提升实力让上仙变得更牛的地方哦"),
		textPos = ccp(480, 450),
		arrowType = TaskArrowDirType.eArrowDirRight,
		arrowPos = ccp(595, 232),
		buttonSize = CCSize(220, 300)
	},
	{
		text = string.lf("快来试试仙将们的本事吧，挑战的战役越多提升越快哦"),
		textPos = Adapter.AutoPos(480, 160),
		arrowType = TaskArrowDirType.eArrowDirLeft,
		arrowPos = Adapter.HCellPos(BaseStages[10010].imagePos[1], BaseStages[10010].imagePos[2]),
		buttonSize = CCSize(200, 200)
	},
	{
		text = string.lf("第二个节点"),
		textPos = Adapter.AutoPos(480, 450),
		arrowType = TaskArrowDirType.eArrowDirLeft,
		arrowPos = Adapter.HCellPos(BaseStages[10011].imagePos[1], BaseStages[10011].imagePos[2]),
		buttonSize = CCSize(200, 200)
	},
	{
		text = string.lf("第三个节点"),
		textPos = Adapter.AutoPos(480, 160),
		arrowType = TaskArrowDirType.eArrowDirLeft,
		arrowPos = Adapter.HCellPos(BaseStages[10012].imagePos[1], BaseStages[10012].imagePos[2]),
		buttonSize = CCSize(200, 200)
	},
	{
		text = string.lf("第四个节点"),
		textPos = Adapter.AutoPos(480, 160),
		arrowType = TaskArrowDirType.eArrowDirRight,
		arrowPos = Adapter.HCellPos(BaseStages[10013].imagePos[1], BaseStages[10013].imagePos[2]),
		buttonSize = CCSize(200, 200)
	},
	{
		text = string.lf("很好，不知不觉就打到这里了，是不是有点乏力了，来看看我们获得什么奖励刺激下上仙的小心脏吧"),
		textPos = ccp(480, 160),
		arrowType = TaskArrowDirType.eArrowDirRight,
		arrowPos = Adapter.AutoPos(850, 550),
		buttonSize = CCSize(200, 200)
	},
	{
		text = string.lf("打完战役以后，在这可以获得大量主线战役的奖励哦，这次貌似给的是一件看起来很牛的武器呢"),
		textPos = ccp(480, 160),
		arrowType = TaskArrowDirType.eArrowDirUp,
		arrowPos = ccp(646, 400),
		buttonSize = CCSize(200, 200)
	},
	{
		text = string.lf("领取以后又来新的主线任务了，先别急着看奖励，我们打完这场说不定还有意外惊喜呢"),
		textPos = ccp(480, 160),
		arrowType = TaskArrowDirType.eArrowDirRight,
		arrowPos = ccp(646, 400),
		buttonSize = CCSize(200, 200)
	},
	{
		text = string.lf("上仙，试试把这个战役打完会怎么样呢？嘻嘻嘻嘻嘻嘻"),
		textPos = ccp(480, 480),
		arrowType = TaskArrowDirType.eArrowDirRight,
		arrowPos = Adapter.HCellPos(BaseStages[10014].imagePos[1] - 300, BaseStages[10014].imagePos[2]),
		buttonSize = CCSize(200, 200)
	},
	[140] = {
		text = string.lf("上仙，换了装备也要进阶才能体现战力最大化哦，打完这个节点凑点进阶的必需品吧···"),
		textPos = ccp(480, 480),
		arrowType = TaskArrowDirType.eArrowDirRight,
		arrowPos = Adapter.HCellPos(BaseStages[10015].imagePos[1] - 520 + 960, BaseStages[10015].imagePos[2]),
		buttonSize = CCSize(200, 200)
	},
	{
		text = string.lf("指向任务"),
		textPos = ccp(480, 160),
		arrowType = TaskArrowDirType.eArrowDirRight,
		arrowPos = Adapter.AutoPos(850, 550),
		buttonSize = CCSize(200, 200)
	},
	{
		text = string.lf("看吧，这就是刚说的神秘奖品哦，获得的这些东西，我们可以让仙将变的更强更霸气，挑战天庭指日可待！"),
		textPos = ccp(480, 160),
		arrowType = TaskArrowDirType.eArrowDirUp,
		arrowPos = ccp(646, 400),
		buttonSize = CCSize(200, 200)
	},
	{
		text = string.lf("让我们去阵容看看刚获得的那些奖品怎么样让仙将变的更强吧"),
		textPos = ccp(480, 350),
		arrowType = TaskArrowDirType.eArrowDirDown,
		arrowPos = Adapter.AutoPos(360, 60),
		buttonSize = CCSize(130, 130)
	},
	{
		text = string.lf("进阶仙将，可以改变仙将品质和外形，进阶越高仙将越霸气哦"),
		textPos = ccp(480, 160),
		arrowType = TaskArrowDirType.eArrowDirUp,
		arrowPos = ccp(225, 320),
		buttonSize = CCSize(200, 130)
	},
	[180] = {
		text = string.lf("上仙，每个主将进阶之前都可以查看下他进阶后的相关效果哦"),
		textPos = ccp(480, 160),
		arrowType = TaskArrowDirType.eArrowDirUp,
		arrowPos = ccp(385, 478),
		buttonSize = CCSize(200, 130)
	},
	[181] = {
		text = string.lf("关闭进阶预览"),
		textPos = ccp(480, 160),
		arrowType = TaskArrowDirType.eArrowDirUp,
		arrowPos = ccp(858, 578),
		buttonSize = CCSize(200, 130)
	},
	{
		text = string.lf("看，仙将变了呢，是不是更霸气了，不同的仙将变化造型也不同呢，所以上仙在平时得注意收集相应仙将魂魄哦"),
		textPos = ccp(480, 450),
		arrowType = TaskArrowDirType.eArrowDirDown,
		arrowPos = ccp(425, 50),
		buttonSize = CCSize(130, 130)
	},
	[190] = {
		text = string.lf("上仙，去试试进阶后的主将的威力吧"),
		textPos = ccp(480, 350),
		arrowType = TaskArrowDirType.eArrowDirRight,
		arrowPos = ccp(410, 590),
		buttonSize = CCSize(130, 130)
	},
	{
		text = string.lf("好了，仙话说的好，仙靠金装，有了好外表，装备也是高富帅仙人的唯一体现呢"),
		textPos = ccp(480, 250),
		arrowType = TaskArrowDirType.eArrowDirDown,
		arrowPos = ccp(165, 440),
		buttonSize = CCSize(150, 120)
	},
	{
		text = string.lf("点击装备，让我们装上看看区别吧"),
		textPos = ccp(480, 250),
		arrowType = TaskArrowDirType.eArrowDirDown,
		arrowPos = ccp(70, 430),
		buttonSize = CCSize(150, 120)
	},
	{
		text = string.lf("这里没有剧情对话框"),
		textPos = ccp(480, 550),
		arrowType = TaskArrowDirType.eArrowDirUp,
		arrowPos = ccp(160, 40),
		buttonSize = CCSize(130, 130)
	},
	{
		text = string.lf("上仙，是不是一下就高大上了，不过光有外表没有实力，也是金玉其外呢，点击装备，增加实力"),
		textPos = ccp(480, 250),
		arrowType = TaskArrowDirType.eArrowDirDown,
		arrowPos = ccp(165, 440),
		buttonSize = CCSize(200, 200)
	},
	{
		text = string.lf("锻造不会失败哦，而且还会暴击，说不定一下就到满级了呢，那样的实力才能配这么牛的外表嘛"),
		textPos = ccp(480, 450),
		arrowType = TaskArrowDirType.eArrowDirDown,
		arrowPos = ccp(629, 70),
		buttonSize = CCSize(130, 130)
	},
	{
		text = string.lf("上仙手气真好，直接暴击了，再试试"),
		textPos = ccp(480, 450),
		arrowType = TaskArrowDirType.eArrowDirDown,
		arrowPos = ccp(829, 70),
		buttonSize = CCSize(130, 130)
	},
	{
		text = string.lf("点击[换将]按钮"),
		textPos = ccp(480, 450),
		arrowType = TaskArrowDirType.eArrowDirLeft,
		arrowPos = ccp(100, 80),
		buttonSize = CCSize(130, 200)
	},
	{
		text = string.lf("点击换将，可以更换小伙伴，快点把刚招募的小伙伴上阵吧"),
		textPos = ccp(480, 450),
		arrowType = TaskArrowDirType.eArrowDirLeft,
		arrowPos = ccp(225, 40),
		buttonSize = CCSize(200, 130)
	},
	[270] = {
		text = string.lf("恭喜上仙获得高级主将，快点把刚招募的小伙伴上阵吧"),
		textPos = ccp(480, 250),
		arrowType = TaskArrowDirType.eArrowDirRight,
		arrowPos = ccp(260, 580),
		buttonSize = CCSize(200, 130)
	},
	[271] = {
		text = string.lf("快点把刚招募的小伙伴上阵吧"),
		textPos = ccp(480, 350),
		arrowType = TaskArrowDirType.eArrowDirDown,
		arrowPos = Adapter.AutoPos(360, 60),
		buttonSize = CCSize(130, 130)
	},
	{
		text = string.lf("换将时使用"),
		textPos = ccp(480, 450),
		arrowType = TaskArrowDirType.eArrowDirLeft,
		arrowPos = ccp(130, 63),
		buttonSize = CCSize(130, 130)
	},
	{
		text = string.lf("好了，现在去试试装备锻造后的威力吧"),
		textPos = ccp(480, 160),
		arrowType = TaskArrowDirType.eArrowDirRight,
		arrowPos = ccp(900, 590),
		buttonSize = CCSize(200, 130)
	},
	{
		text = string.lf("接下来再去把主将升级吧"),
		textPos = ccp(480, 160),
		arrowType = TaskArrowDirType.eArrowDirUp,
		arrowPos = ccp(300, 400),
		buttonSize = CCSize(200, 300)
	},
	[300] = {
		text = string.lf("点击升级"),
		textPos = ccp(480, 160),
		arrowType = TaskArrowDirType.eArrowDirDown,
		arrowPos = ccp(475, 168),
		buttonSize = CCSize(200, 130)
	}
}
