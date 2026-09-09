require("data.taskType")

GameFeatures = {
	eCS = 35,
	eTianming = 37,
	eXiaohuoban1 = 30,
	eFuBen = 18,
	ePK = 25,
	eDuelFight = 36,
	eQiShuHealth = 7,
	eFriend = 26,
	eXiaohuoban2 = 31,
	eQiShuNew = 8,
	eTransport = 20,
	eXiaohuoban4 = 33,
	eTower = 19,
	eHeroTrain = 4,
	eTeamHero6 = 3,
	eXiaohuoban8 = 43,
	eGuild = 34,
	eSlave4 = 24,
	eTeamHero4 = 1,
	eXiaohuoban3 = 32,
	eXiaohuoban5 = 39,
	eEquipInherit = 5,
	eSlave2 = 22,
	eXiaohuoban6 = 40,
	eSlave3 = 23,
	eWorldBoss = 41,
	eXiaohuoban7 = 42,
	eMysticStore = 28,
	eRefine = 27,
	eShenQi = 29,
	eSlave1 = 21,
	eTeamHero5 = 2,
	eEquipInlay = 6,
	eXunfang = 38
}

local var_0_0 = 200

GameFeaturesLevel = {
	[GameFeatures.eTeamHero4] = {
		displayBg = "ui/home/home_032.png",
		level = 10,
		taskEntryType = TaskEntryType.eEntryBattleHero,
		name = string.lf("第4主将上阵"),
		desc = string.lf("上仙，您可以上阵第四个主将啦！")
	},
	[GameFeatures.eTeamHero5] = {
		displayBg = "ui/home/home_032.png",
		level = 15,
		taskEntryType = TaskEntryType.eEntryBattleHero,
		name = string.lf("第5主将上阵"),
		desc = string.lf("上仙，您可以上阵第五个主将啦！")
	},
	[GameFeatures.eTeamHero6] = {
		displayBg = "ui/home/home_032.png",
		level = 25,
		taskEntryType = TaskEntryType.eEntryBattleHero,
		name = string.lf("第6主将上阵"),
		desc = string.lf("上仙，您可以上阵第六个主将啦！")
	},
	[GameFeatures.eHeroTrain] = {
		displayBg = "ui/home/home_058.png",
		level = 21,
		taskEntryType = TaskEntryType.eEntryHeroTrain,
		name = string.lf("主将培养"),
		desc = string.lf("上仙，您可以培养您的主将啦！")
	},
	[GameFeatures.eEquipInherit] = {
		displayBg = "ui/home/home_030.png",
		level = 40,
		taskEntryType = TaskEntryType.eEntryTalismanRecast,
		name = string.lf("装备重铸"),
		desc = string.lf("上仙，快去重铸一下您的装备品质吧！")
	},
	[GameFeatures.eEquipInlay] = {
		displayBg = "ui/home/home_030.png",
		level = 30,
		taskEntryType = TaskEntryType.eEntryTalismanFeed,
		name = string.lf("装备喂灵"),
		desc = string.lf("上仙，您可以使用装备喂灵功能了哟！喂灵之后的装备有很多特殊效果，快去看看吧！")
	},
	[GameFeatures.eQiShuHealth] = {
		displayBg = "ui/home/home_013.png",
		level = 35,
		taskEntryType = TaskEntryType.eEntryTechnologyMagic,
		name = string.lf("天书洞"),
		desc = string.lf("上仙，天书洞已经为您开放了，快去看看吧！")
	},
	[GameFeatures.eQiShuNew] = {
		displayBg = "ui/home/home_013.png",
		level = 38,
		taskEntryType = TaskEntryType.eEntryTechnologyMagic,
		name = string.lf("新奇术开放"),
		desc = string.lf("上仙，您已经可以学习天书洞更高级的功法了，快去看看吧！")
	},
	[GameFeatures.eFuBen] = {
		displayBg = "ui/home/home_011.png",
		level = 15,
		taskEntryType = TaskEntryType.eEntryCopy,
		name = string.lf("十二元辰殿"),
		desc = string.lf("上仙，十二元辰殿已经为您开放了，快去挑战一下吧！")
	},
	[GameFeatures.eTower] = {
		displayBg = "ui/home/home_016.png",
		level = 18,
		taskEntryType = TaskEntryType.eEntryTower,
		name = string.lf("通天塔"),
		desc = string.lf("神秘的通天塔之中封印着各种实力强大的妖怪，塔内各层分布着许多宝箱，上仙快去看看吧！")
	},
	[GameFeatures.eTransport] = {
		displayBg = "ui/home/home_015.png",
		level = 12,
		taskEntryType = TaskEntryType.eEntryTransport,
		name = string.lf("运镖"),
		desc = string.lf("天马镖局最近正在招募镖师，薪水丰厚，上仙快带上您的仙友一块去看看吧！")
	},
	[GameFeatures.eSlave1] = {
		displayBg = "ui/home/home_014.png",
		level = 20,
		taskEntryType = TaskEntryType.eEntryDarkhouseCapture,
		name = string.lf("小黑屋1号笼"),
		desc = string.lf("上仙，小黑屋功能已经为您开放了，您要是看谁不顺眼就把他抓进去给您做苦力吧！")
	},
	[GameFeatures.eSlave2] = {
		displayBg = "ui/home/home_014.png",
		level = 22,
		taskEntryType = TaskEntryType.eEntryDarkhouseCapture,
		name = string.lf("小黑屋2号笼"),
		desc = string.lf("由于上仙您的仇人太多，一间牢房可能不够使用，所以再送您一间牢房吧！")
	},
	[GameFeatures.eSlave3] = {
		displayBg = "ui/home/home_014.png",
		level = 24,
		taskEntryType = TaskEntryType.eEntryDarkhouseCapture,
		name = string.lf("小黑屋3号笼"),
		desc = string.lf("天庭有旨，赐上仙一把天牢钥匙，帮助天牢抓捕逃犯，钦此！")
	},
	[GameFeatures.eSlave4] = {
		displayBg = "ui/home/home_014.png",
		level = 27,
		taskEntryType = TaskEntryType.eEntryDarkhouseCapture,
		name = string.lf("小黑屋4号笼"),
		desc = string.lf("天庭有旨，上仙法力高强，刚正不阿，再赐予一把天牢钥匙，掌管天牢大小事宜！")
	},
	[GameFeatures.ePK] = {
		displayBg = "ui/home/home_014.png",
		level = 9,
		taskEntryType = TaskEntryType.eEntryDuelDefeat,
		name = string.lf("争霸"),
		desc = string.lf("上仙，您已经获得了竞技场的入场卷，快去争夺排名获取奖励吧！")
	},
	[GameFeatures.eFriend] = {
		displayBg = "ui/home/home_033.png",
		level = 12,
		taskEntryType = TaskEntryType.eEntryFriend,
		name = string.lf("好友"),
		desc = string.lf("上仙的实力已经得到了仙友们的一致认可，快去结识几个仙友一同征战三界吧！")
	},
	[GameFeatures.eRefine] = {
		displayBg = "ui/home/home_063.png",
		level = 11,
		taskEntryType = TaskEntryType.eRefining,
		name = string.lf("炼化炉"),
		desc = string.lf("上仙，遇到不用的装备和主将就来我这儿炼化了吧，也可以到我这儿重生装备和主将噢！")
	},
	[GameFeatures.eMysticStore] = {
		displayBg = "ui/enhance/enhance_012.png",
		level = 11,
		taskEntryType = TaskEntryType.eMysterystore,
		name = string.lf("神秘商店"),
		desc = string.lf("上仙，我这儿出售各种珍奇装备和主将，可以用魂玉或元宝到我这儿来购买噢！")
	},
	[GameFeatures.eShenQi] = {
		displayBg = "ui/home/home_014.png",
		level = 25,
		taskEntryType = TaskEntryType.eShenQi,
		name = string.lf("神器殿"),
		desc = string.lf("上仙，您已经解锁了封印的神器，快来神器殿强化您的神器吧！")
	},
	[GameFeatures.eXiaohuoban1] = {
		displayBg = "ui/home/home_032.png",
		level = 28,
		taskEntryType = TaskEntryType.eGuideXiaohuoban,
		name = string.lf("第一个小伙伴"),
		desc = string.lf("上仙快来招募您的第一个小伙伴吧！")
	},
	[GameFeatures.eXiaohuoban2] = {
		displayBg = "ui/home/home_032.png",
		level = 33,
		taskEntryType = TaskEntryType.eGuideXiaohuoban,
		name = string.lf("第二个小伙伴"),
		desc = string.lf("上仙快来招募您的第二个小伙伴吧！")
	},
	[GameFeatures.eXiaohuoban3] = {
		displayBg = "ui/home/home_032.png",
		level = 38,
		taskEntryType = TaskEntryType.eGuideXiaohuoban,
		name = string.lf("第三个小伙伴"),
		desc = string.lf("上仙快来招募您的第三个小伙伴吧！")
	},
	[GameFeatures.eXiaohuoban4] = {
		displayBg = "ui/home/home_032.png",
		level = 43,
		taskEntryType = TaskEntryType.eGuideXiaohuoban,
		name = string.lf("第四个小伙伴"),
		desc = string.lf("上仙快来招募您的第四个小伙伴吧！")
	},
	[GameFeatures.eXiaohuoban5] = {
		displayBg = "ui/home/home_032.png",
		level = 46,
		taskEntryType = TaskEntryType.eGuideXiaohuoban,
		name = string.lf("第五个小伙伴"),
		desc = string.lf("上仙快来招募您的第五个小伙伴吧！")
	},
	[GameFeatures.eXiaohuoban6] = {
		displayBg = "ui/home/home_032.png",
		level = 49,
		taskEntryType = TaskEntryType.eGuideXiaohuoban,
		name = string.lf("第六个小伙伴"),
		desc = string.lf("上仙快来招募您的第六个小伙伴吧！")
	},
	[GameFeatures.eXiaohuoban7] = {
		displayBg = "ui/home/home_032.png",
		level = 52,
		taskEntryType = TaskEntryType.eGuideXiaohuoban,
		name = string.lf("第七个小伙伴"),
		desc = string.lf("上仙快来招募您的第七个小伙伴吧！")
	},
	[GameFeatures.eXiaohuoban8] = {
		displayBg = "ui/home/home_032.png",
		level = 55,
		taskEntryType = TaskEntryType.eGuideXiaohuoban,
		name = string.lf("第八个小伙伴"),
		desc = string.lf("上仙快来招募您的第八个小伙伴吧！")
	},
	[GameFeatures.eGuild] = {
		displayBg = "ui/home/home_068.png",
		level = 26,
		name = string.lf("仙盟"),
		desc = string.lf("你的实力获得各大仙盟的注意，各大盟主已经呈递邀请函邀请您加入仙盟！")
	},
	[GameFeatures.eCS] = {
		displayBg = "ui/home/home_014.png",
		level = 14,
		taskEntryType = TaskEntryType.eGuideXianMoZhengBa,
		name = string.lf("仙魔争霸"),
		desc = string.lf("上仙您已经获得了仙魔争霸的参赛资格，快去看看吧！")
	},
	[GameFeatures.eDuelFight] = {
		displayBg = "ui/home/home_014.png",
		level = 41,
		name = string.lf("大闹天宫"),
		desc = string.lf("上仙您已经获得了大闹天宫的参赛资格，快去看看吧！")
	},
	[GameFeatures.eTianming] = {
		displayBg = "ui/home/home_070.png",
		level = 40,
		name = string.lf("天命"),
		desc = string.lf("上仙天命系统已开启，快去看看吧！")
	},
	[GameFeatures.eXunfang] = {
		displayBg = "ui/home/home_072.png",
		level = 45,
		name = string.lf("寻访"),
		desc = string.lf("上仙寻访系统已开启，快去看看吧！")
	},
	[GameFeatures.eWorldBoss] = {
		displayBg = "ui/home/home_071.png",
		level = 10,
		name = string.lf("妖王洞穴"),
		desc = string.lf("上仙妖王洞穴已开启，快去看看吧！")
	}
}

function getLevelNewFeatureList(arg_1_0)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in pairs(GameFeaturesLevel) do
		if iter_1_1.level == arg_1_0 then
			table.insert(var_1_0, iter_1_1)
		end
	end

	return var_1_0
end

function getMaxFeatureLevel()
	local var_2_0 = 1

	for iter_2_0, iter_2_1 in pairs(GameFeaturesLevel) do
		if var_2_0 < iter_2_1.level and iter_2_1.level < var_0_0 then
			var_2_0 = iter_2_1.level
		end
	end

	return var_2_0
end

function getLevelNextFeatureList(arg_3_0)
	local var_3_0 = getMaxFeatureLevel()

	for iter_3_0, iter_3_1 in pairs(GameFeaturesLevel) do
		if arg_3_0 < iter_3_1.level and var_3_0 > iter_3_1.level then
			var_3_0 = iter_3_1.level
		end
	end

	return var_3_0, getLevelNewFeatureList(var_3_0)
end
