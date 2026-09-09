require("base.serverurl")
require("scenes.battle.BattleAudio")
require("scenes.GuideLayer")
require("scenes.battle.BattleSetup")
require("scenes.battle.BattleData")

BattleOperator = {}
eBattleType = {
	ShenqiRevenge = 14,
	ShenqiPVE = 12,
	ShenqiRobFragment = 15,
	ShenqiReport = 13,
	ChampionShip = 10,
	ZSZZBattleRecord = 21,
	DuleFightRival = 18,
	Challenge = 7,
	DarkHouseSave = 4,
	shijieBOSS = 17,
	ShenqiPVP = 11,
	ZSQFight = 20,
	BattleCopy = 8,
	Transport = 6,
	DarkHouseCatch = 3,
	guildBOSS = 16,
	guildKing = 22,
	DuleRevenge = 19,
	DarkHouseRevolt = 5,
	Guider = 9,
	Towr = 2,
	Map = 1
}

local function var_0_0()
	local var_1_0 = {
		"buzhoushan_3.jpg",
		"donghailonggong_3.jpg",
		"kuloushan_3.jpg",
		"luofudong_3.jpg",
		"nanhaiputuo_3.jpg",
		"qingqiu_3.jpg",
		"yaochi_3.jpg",
		"zhongnanshan_3.jpg"
	}

	return "ui/battle/bgPic/" .. var_1_0[math.random(1, #var_1_0)]
end

local function var_0_1(arg_2_0)
	return "ui/battle/bgPic/" .. arg_2_0[math.random(1, #arg_2_0)]
end

local function var_0_2(...)
	local var_3_0 = {
		{
			"busihuoshan_1.jpg",
			"busihuoshan_2.jpg"
		},
		{
			"buzhoushan_1.jpg",
			"buzhoushan_2.jpg",
			"buzhoushan_3.jpg"
		},
		{
			"donghailonggong_1.jpg",
			"donghailonggong_2.jpg",
			"donghailonggong_3.jpg"
		},
		{
			"kuloushan_1.jpg",
			"kuloushan_2.jpg",
			"kuloushan_3.jpg"
		},
		{
			"kunlun_1.jpg",
			"kunlun_2.jpg"
		},
		{
			"lingxiaotiangong_1.jpg",
			"lingxiaotiangong_2.jpg"
		},
		{
			"luofudong_1.jpg",
			"luofudong_2.jpg",
			"luofudong_3.jpg"
		},
		{
			"nanhaiputuo_1.jpg",
			"nanhaiputuo_2.jpg",
			"nanhaiputuo_3.jpg"
		},
		{
			"qingqiu_1.jpg",
			"qingqiu_2.jpg",
			"qingqiu_3.jpg"
		},
		{
			"shangqingjing_1.jpg",
			"shangqingjing_2.jpg"
		},
		{
			"shituoling_1.jpg",
			"shituoling_2.jpg"
		},
		{
			"taixuhuanjing_1.jpg",
			"taixuhuanjing_2.jpg"
		},
		{
			"yaochi_1.jpg",
			"yaochi_2.jpg",
			"yaochi_3.jpg"
		},
		{
			"youmingjie_1.jpg",
			"youmingjie_2.jpg"
		},
		{
			"zhongnanshan_1.jpg",
			"zhongnanshan_2.jpg",
			"zhongnanshan_3.jpg"
		}
	}
	local var_3_1 = var_3_0[math.random(1, #var_3_0)]

	if #var_3_1 == 3 then
		return {
			circlePic = {
				"ui/battle/bgPic/" .. var_3_1[1],
				"ui/battle/bgPic/" .. var_3_1[2]
			},
			finalPic = "ui/battle/bgPic/" .. var_3_1[3]
		}
	else
		return {
			circlePic = {
				"ui/battle/bgPic/" .. var_3_1[1],
				"ui/battle/bgPic/" .. var_3_1[2]
			},
			finalPic = "ui/battle/bgPic/" .. var_3_1[2]
		}
	end
end

function BattleOperator.startBattle(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.battleType = arg_4_1
	arg_4_0.battleCallback = arg_4_3
	arg_4_2.type = arg_4_1
	arg_4_2.callback = arg_4_3
	arg_4_0.params = arg_4_2

	local var_4_0
	local var_4_1
	local var_4_2
	local var_4_3
	local var_4_4
	local var_4_5
	local var_4_6
	local var_4_7
	local var_4_8 = false
	local var_4_9 = true
	local var_4_10
	local var_4_11 = ""

	BattleAudio:Sound_preloadEffect()

	if arg_4_1 == eBattleType.Map then
		if BaseStages[arg_4_2.id].chatMessageBegin and BaseStages[arg_4_2.id].chatMessageBegin ~= "" then
			var_4_5 = {}

			local var_4_12 = arg_4_0:lua_string_split(BaseStages[arg_4_2.id].chatMessageBegin, ";")

			for iter_4_0, iter_4_1 in pairs(var_4_12) do
				if iter_4_1 ~= "" then
					local var_4_13 = {}
					local var_4_14 = arg_4_0:lua_string_split(iter_4_1, "|")

					if #var_4_14 ~= 3 then
						dump("------------------剧情对话不完整-------------------")
					end

					var_4_13.npcId = var_4_14[1]
					var_4_13.name = var_4_14[2]
					var_4_13.content = var_4_14[3]

					table.insert(var_4_5, var_4_13)
				end
			end
		end

		if BaseStages[arg_4_2.id].chatMessageEnd and BaseStages[arg_4_2.id].chatMessageEnd ~= "" then
			var_4_6 = {}

			local var_4_15 = arg_4_0:lua_string_split(BaseStages[arg_4_2.id].chatMessageEnd, ";")

			for iter_4_2, iter_4_3 in pairs(var_4_15) do
				if iter_4_3 ~= "" then
					local var_4_16 = {}
					local var_4_17 = arg_4_0:lua_string_split(iter_4_3, "|")

					if #var_4_17 ~= 3 then
						dump("------------------剧情对话不完整-------------------")
					end

					var_4_16.npcId = var_4_17[1]
					var_4_16.name = var_4_17[2]
					var_4_16.content = var_4_17[3]

					table.insert(var_4_6, var_4_16)
				end
			end
		end

		var_4_0 = {
			playerComming = true
		}

		local function var_4_18(arg_5_0)
			return "ui/battle/bgPic/" .. arg_5_0
		end

		var_4_1 = {
			circlePic = {
				var_4_18(BaseStages[arg_4_2.id].battleImage1),
				var_4_18(BaseStages[arg_4_2.id].battleImage2)
			},
			finalPic = var_4_18(BaseStages[arg_4_2.id].bossImage)
		}
		var_4_4 = arg_4_0:lua_string_split(BaseStages[arg_4_2.id].battleName, ",")
		var_4_2 = string.format(ServerUrl.MapBattle, Player.userId, arg_4_2.id)
		arg_4_0.cpId = arg_4_2.id
		var_4_7 = false

		local var_4_19 = 0

		for iter_4_4, iter_4_5 in ipairs(Player.taskInfo.Point) do
			if arg_4_2.id == iter_4_5.PID then
				local var_4_20 = iter_4_5.Star
			end
		end

		var_4_9 = false
		var_4_11 = arg_4_2.diffculty or 1
	elseif arg_4_1 == eBattleType.Towr then
		var_4_0 = {}
		var_4_1 = {
			finalPic = "ui/battle/bgPic/tongtianta.jpg"
		}
		var_4_4 = TowerNPCHeaders[arg_4_2.floor + 1][arg_4_2.type].name
		var_4_2 = string.format(ServerUrl.TowerBattle, Player.userId, arg_4_2.towertype)
		var_4_7 = true
		var_4_10 = {
			arg_4_1 == arg_4_1,
			count = arg_4_2.type
		}
		var_4_9 = false
	elseif arg_4_1 == eBattleType.DarkHouseCatch then
		var_4_0 = {
			enemyComming = true
		}
		var_4_1 = {
			finalPic = var_0_1({
				"zhuanuli_1.jpg",
				"zhuanuli_2.jpg",
				"zhuanuli_3.jpg"
			})
		}
		var_4_4 = string.lf("抓俘虏")
		vip = 1
		var_4_2 = string.format(ServerUrl.DarkHouseCatchBattle, Player.userId, arg_4_2.location, arg_4_2.capturePlayerID, 0)
		var_4_7 = true
	elseif arg_4_1 == eBattleType.DarkHouseSave then
		var_4_0 = {
			enemyComming = true
		}
		var_4_1 = {
			finalPic = var_0_1({
				"zhuanuli_1.jpg",
				"zhuanuli_2.jpg",
				"zhuanuli_3.jpg"
			})
		}
		var_4_4 = string.lf("解救")
		var_4_2 = string.format(ServerUrl.DarkHouseSaveBattle, Player.userId, arg_4_2.friendID)
		var_4_7 = true
	elseif arg_4_1 == eBattleType.DarkHouseRevolt then
		var_4_0 = {
			enemyComming = true
		}
		var_4_1 = {
			finalPic = var_0_1({
				"zhuanuli_1.jpg",
				"zhuanuli_2.jpg",
				"zhuanuli_3.jpg"
			})
		}
		var_4_4 = string.lf("反抗")
		var_4_2 = string.format(ServerUrl.DarkHouseRevoltBattle, Player.userId)
		var_4_7 = true
	elseif arg_4_1 == eBattleType.Transport then
		var_4_0 = {
			enemyComming = true
		}
		var_4_1 = {
			finalPic = "ui/battle/bgPic/yunbiao.jpg"
		}
		var_4_4 = string.lf("劫镖")

		local var_4_21 = ""

		for iter_4_6 = 1, #arg_4_2.friendIds do
			if iter_4_6 < #arg_4_2.friendIds then
				var_4_21 = var_4_21 .. arg_4_2.friendIds[iter_4_6] .. ","
			else
				var_4_21 = var_4_21 .. arg_4_2.friendIds[iter_4_6]
			end
		end

		var_4_2 = string.format(ServerUrl.TransportRob, Player.userId, arg_4_2.enemyid, var_4_21)
		var_4_7 = true
	elseif arg_4_1 == eBattleType.Challenge then
		var_4_0 = {
			enemyComming = true
		}
		var_4_1 = {
			finalPic = var_0_1({
				"jingjichang_1.jpg",
				"jingjichang_2.jpg"
			})
		}
		var_4_4 = string.lf("挑战")
		var_4_2 = string.format(ServerUrl.ChallengePlayer, Player.userId, arg_4_2.rank)
		var_4_7 = true
	elseif arg_4_1 == eBattleType.BattleCopy then
		var_4_0 = {}
		var_4_1 = {
			finalPic = "ui/battle/bgPic/fuben.jpg"
		}
		var_4_4 = arg_4_0:lua_string_split(FubenData[arg_4_2.copyId].battleName, ",")
		var_4_2 = string.format(ServerUrl.BattleCopy, Player.userId, arg_4_2.copyId)
		var_4_7 = false
		var_4_9 = false
		var_4_10 = {
			arg_4_1 == arg_4_1,
			count = arg_4_2.star
		}
	elseif arg_4_1 == eBattleType.ChampionShip then
		var_4_0 = {}
		var_4_1 = {
			finalPic = "ui/battle/bgPic/fuben.jpg"
		}
		var_4_4 = string.lf("仙魔争霸")

		local var_4_22 = require("base.cache").get("cs-dao")

		var_4_2 = string.format(ServerUrl.XMBattleInfo, Player.userId, arg_4_2.attackPlayerID, arg_4_2.defendPlayerID, var_4_22)
		var_4_7 = true
	elseif arg_4_1 == eBattleType.ShenqiPVP then
		var_4_0 = {
			enemyComming = true
		}
		var_4_1 = {
			finalPic = "ui/battle/bgPic/fuben.jpg"
		}
		var_4_4 = string.lf("仙魔争霸")
		var_4_2 = string.format(ServerUrl.ArtifactChallgePlayer, Player.userId, arg_4_2.beChallengedPlayerID, arg_4_2.degree)
		var_4_7 = true
	elseif arg_4_1 == eBattleType.ShenqiPVE then
		var_4_0 = {
			enemyComming = true
		}
		var_4_1 = {
			finalPic = "ui/battle/bgPic/fuben.jpg"
		}
		var_4_4 = string.lf("仙魔争霸")
		var_4_2 = string.format(ServerUrl.ChallengeArtifact, Player.userId, arg_4_2.step)
		var_4_7 = true
	elseif arg_4_1 == eBattleType.ShenqiReport then
		var_4_0 = {
			enemyComming = true
		}
		var_4_1 = {
			finalPic = "ui/battle/bgPic/fuben.jpg"
		}
		var_4_4 = string.lf("仙魔争霸")
		var_4_2 = string.format(ServerUrl.ArtifactBattle, Player.userId, arg_4_2.id)
		var_4_7 = true
	elseif arg_4_1 == eBattleType.ShenqiRevenge then
		var_4_0 = {
			enemyComming = true
		}
		var_4_1 = {
			finalPic = "ui/battle/bgPic/fuben.jpg"
		}
		var_4_4 = string.lf("神器复仇")
		var_4_2 = string.format(ServerUrl.Revenge, Player.userId, arg_4_2.id)
		var_4_7 = true
	elseif arg_4_1 == eBattleType.ShenqiRobFragment then
		var_4_0 = {
			enemyComming = true
		}
		var_4_1 = {
			finalPic = "ui/battle/bgPic/fuben.jpg"
		}
		var_4_4 = string.lf("神器抢夺")
		var_4_2 = string.format(ServerUrl.RobFragment, Player.userId, arg_4_2.fragmentId, arg_4_2.playerId, tostring(arg_4_2.robType))
		var_4_7 = true
	elseif arg_4_1 == eBattleType.guildBOSS then
		var_4_0 = {}
		var_4_1 = {
			finalPic = "ui/battle/bgPic/fuben.jpg"
		}
		var_4_4 = "BOSS"
		var_4_2 = string.format(ServerUrl.UnionDemonChallenge, Player.userId, arg_4_2.demonID, arg_4_2.battleType)
		var_4_7 = true
		var_4_9 = false
	elseif arg_4_1 == eBattleType.guildKing then
		var_4_0 = {}
		var_4_1 = {
			finalPic = "ui/battle/bgPic/fuben.jpg"
		}
		var_4_4 = "King"
		var_4_2 = string.format(ServerUrl.UnionDemonKingChallenge, Player.userId, arg_4_2.demonID, arg_4_2.battleType)
		var_4_7 = true
		var_4_9 = false
	elseif arg_4_1 == eBattleType.shijieBOSS then
		var_4_0 = {}
		var_4_1 = {
			finalPic = "ui/battle/bgPic/fuben.jpg"
		}
		var_4_4 = "BOSS"
		var_4_2 = string.format(ServerUrl.WorldBossChallenge, Player.userId, arg_4_2.battleType, arg_4_2.bossId)
		var_4_7 = true
		var_4_9 = false
	elseif arg_4_1 == eBattleType.Guider then
		var_4_0 = {}
		var_4_1 = {
			finalPic = "ui/battle/bgPic/fuben.jpg"
		}
		var_4_4 = string.lf("魔尊幻象")
		var_4_7 = false
		var_4_8 = true
		var_4_9 = false
	elseif arg_4_1 == eBattleType.DuleFightRival then
		var_4_0 = {
			enemyComming = true
		}
		var_4_1 = {
			finalPic = var_0_1({
				"jingjichang_1.jpg",
				"jingjichang_2.jpg"
			})
		}
		var_4_4 = string.lf("比武")
		var_4_2 = string.format(ServerUrl.DuelFight, Player.userId, arg_4_2.rivalID)
		var_4_7 = true
	elseif arg_4_1 == eBattleType.DuleRevenge then
		var_4_0 = {
			enemyComming = true
		}
		var_4_1 = {
			finalPic = var_0_1({
				"jingjichang_1.jpg",
				"jingjichang_2.jpg"
			})
		}
		var_4_4 = string.lf("大闹天宫复仇")
		var_4_2 = string.format(ServerUrl.DuelRevenge, Player.userId, arg_4_2.enemyId)
		var_4_7 = true
	elseif arg_4_1 == eBattleType.ZSQFight then
		var_4_0 = {
			enemyComming = true
		}
		var_4_1 = {
			finalPic = var_0_1({
				"jingjichang_1.jpg",
				"jingjichang_2.jpg"
			})
		}
		var_4_4 = string.lf("战三清")
		var_4_2 = string.format(ServerUrl.ZSQFight, Player.userId, arg_4_2.fType, arg_4_2.fRank)
		var_4_7 = true
	elseif arg_4_1 == eBattleType.ZSZZBattleRecord then
		var_4_0 = {}
		var_4_1 = {
			finalPic = var_0_1({
				"jingjichang_1.jpg",
				"jingjichang_2.jpg"
			})
		}
		var_4_4 = string.lf("诸神之战")
		var_4_2 = string.format(ServerUrl.ZSZZBattleRecord, Player.userId, arg_4_2.recordID)
	else
		print("没有该战斗类型！")
	end

	local var_4_23 = handler(arg_4_0, arg_4_0.BattleResult)

	game.enterBattleScene({
		comming = var_4_0,
		battleBG = var_4_1,
		params = var_4_2,
		battleResult = var_4_23,
		udata = arg_4_2.userData and arg_4_2.userData or nil,
		battlename = var_4_4,
		chatBegin = var_4_5,
		chatEnd = var_4_6,
		guider = var_4_8,
		canSkip = var_4_9,
		skipParams = var_4_10,
		type = arg_4_1,
		diffculty = var_4_11
	}):setControl(var_4_7)
end

function BattleOperator.BattleResult(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	stopGameBackgroundMusic()
	BattleAudio:Sound_releaseEffect()

	if arg_6_1 then
		BattleAudio:Sound_playEffect(BattleAudio.schedule_sucess)
	else
		BattleAudio:Sound_playEffect(BattleAudio.schedule_failed)
	end

	local var_6_0 = arg_6_0.params

	var_6_0.result = arg_6_1
	var_6_0.data = arg_6_3

	if arg_6_0.battleType == eBattleType.Map then
		local var_6_1 = arg_6_0.cpId

		if arg_6_1 then
			local function var_6_2()
				if arg_6_0.battleCallback then
					arg_6_0.battleCallback(arg_6_1, arg_6_3, var_6_1)
				end
			end

			local var_6_3 = require("scenes.map.BattleCompleteLayer").new({
				stageId = var_6_1,
				callback = var_6_2
			})

			arg_6_2.uiLayer:buttonVisible(false)
			arg_6_2:addChild(var_6_3, 11)

			arg_6_2.lvlCompliteLayer = var_6_3
		else
			var_6_0.stageId = arg_6_0.cpId

			local var_6_4 = require("scenes.PK.PKCompleteLayer").new(var_6_0)

			arg_6_2:addChild(var_6_4, 11)
		end
	elseif arg_6_0.battleType == eBattleType.Guider then
		GuideLayer:saveTrioMaxStep(1, function()
			if arg_6_0.battleCallback then
				arg_6_0.battleCallback(arg_6_1, arg_6_3, stageId)
			end
		end)
	elseif arg_6_0.battleType == eBattleType.guildBOSS then
		var_6_0.parentScene = arg_6_2

		local var_6_5 = require("scenes.guild.GuildResurgenceLayer").new(var_6_0)

		arg_6_2:addChild(var_6_5, 11)
	elseif arg_6_0.battleType == eBattleType.guildKing then
		var_6_0.parentScene = arg_6_2

		local var_6_6 = require("scenes.guild.GuildResurgenceLayer").new(var_6_0)

		arg_6_2:addChild(var_6_6, 11)
	elseif arg_6_0.battleType == eBattleType.ShenqiRobFragment then
		if var_6_0.result then
			var_6_0.battleType = eBattleType.ShenqiRobFragment

			local var_6_7 = require("scenes.shenqi.ShenqiRewardLayer").new(var_6_0)

			arg_6_2:addChild(var_6_7, 11)
		else
			local var_6_8 = require("scenes.PK.PKCompleteLayer").new(var_6_0)

			arg_6_2:addChild(var_6_8, 11)
		end
	elseif arg_6_0.battleType == eBattleType.DuleFightRival or arg_6_0.battleType == eBattleType.DuleRevenge then
		if var_6_0.result then
			var_6_0.battleType = eBattleType.DuleFightRival

			local var_6_9 = require("scenes.shenqi.ShenqiRewardLayer").new(var_6_0)

			arg_6_2:addChild(var_6_9, 11)
			print("战斗胜利显示翻牌界面")
		else
			local var_6_10 = require("scenes.PK.PKCompleteLayer").new(var_6_0)

			arg_6_2:addChild(var_6_10, 11)
		end
	elseif arg_6_0.battleType == eBattleType.shijieBOSS then
		arg_6_2:addChild(require("scenes.worldboss.WorldBossBattleResultLayer").new(var_6_0), 11)
	else
		local var_6_11 = require("scenes.PK.PKCompleteLayer").new(var_6_0)

		arg_6_2:addChild(var_6_11, 11)
	end

	if arg_6_0.battleType ~= eBattleType.Guider then
		Player:manualChangeGlobalAttrs(arg_6_4)
	end
end

function BattleOperator.lua_string_split(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {}

	while true do
		local var_9_1 = string.find(arg_9_1, arg_9_2)

		if not var_9_1 then
			var_9_0[#var_9_0 + 1] = arg_9_1

			break
		end

		local var_9_2 = string.sub(arg_9_1, 1, var_9_1 - 1)

		var_9_0[#var_9_0 + 1] = var_9_2
		arg_9_1 = string.sub(arg_9_1, var_9_1 + 1, #arg_9_1)
	end

	return var_9_0
end

return BattleOperator
