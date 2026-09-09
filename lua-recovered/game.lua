require("framework.init")
require("framework.shortcodes")
require("framework.cc.init")
require("config")
require("base.define")
require("base.localized")

game = class("game", cc.mvc.AppBase)
game.runningTable = {}
game.isReplaceing = false
game.homeOffset = ccp(0, 0)
game.currentBGM = nil

local var_0_0 = 0.3

function game.ctor(arg_1_0)
	game.super.ctor(arg_1_0, "shenmo", "")
end

function game.requireFiles()
	require("base.functions")
	require("data.audio")
	require("data.hero")
	require("data.npc")
	require("data.item")
	require("data.map")
	require("data.localdata")
	require("base.request")
	require("data.equip")
	require("data.feature")
	require("data.EquipHelper")
	require("data.MineralHelper")
	require("data.tianming")
	require("data.TianmingHelper")
	require("data.master")
	require("data.MasterHelper")
	require("data.TransportFriendsHelper")

	if device.platform == "ios" then
		require("data.StoreIAP")
	end
end

function game.run(arg_3_0)
	Adapter.init()
	Localized:initLocalized("localized.txt")
	game.requireFiles()
	LocalData:readLocalData()

	local var_3_0 = IPlatform:instance():getConfig("SdkAudioSwitch")

	if var_3_0 ~= "" then
		if var_3_0 == "true" then
			LocalData:setMusicEnabled(true)
		elseif var_3_0 == "false" then
			LocalData:setMusicEnabled(false)
		end
	end

	NetworkMediator:initCommunicationEncode("shenmo" .. "_moqikaka_" .. "shenmo")

	local var_3_1 = IPlatform:instance():getConfig("ThridLogo")

	if var_3_1 ~= "" then
		local var_3_2 = CCFileUtils:sharedFileUtils():fullPathForFilename(var_3_1)

		if io.exists(var_3_2) then
			game.enterThirdLogoScene({
				thirdLogo = var_3_1
			})

			return
		end
	end

	playGameBackgroundMusic(_IDLE_GAME_MUSIC_HOME)
	game.restartGameEntry(false)
end

function game.restartGameEntry(arg_4_0)
	local var_4_0 = IPlatform:instance():getConfig("ThridLogin") == "True"

	if arg_4_0 == nil or arg_4_0 == true then
		Player:init()
		IPlatform:instance():cpInfo("logout", json.encode({}))
	end

	game.enterStartGameScene({
		thirdLogin = var_4_0
	})
end

function game.enterThirdLogoScene(arg_5_0)
	game.replaceScene(require("scenes.ThirdLogoScene").new(arg_5_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterThirdLogoScene2(arg_6_0)
	game.replaceScene(require("scenes.ThirdLogoScene2").new(arg_6_0), "CCTransitionCrossFade", var_0_0)
end

function game.onEnterBackground(arg_7_0)
	local var_7_0 = LocalData:getSetting()

	if var_7_0.musicEnabled == true then
		SimpleAudioEngine:sharedEngine():pauseBackgroundMusic()
	end

	if var_7_0.pushEnabled == true then
		SimpleAudioEngine:sharedEngine():pauseAllEffects()
	end

	local var_7_1 = LocalData:getSetting()

	setLocalNotifyEnabled(var_7_1.pushEnabled and 1 or 0)

	if var_7_1.pushEnabled == true then
		if Player.userId then
			if Player.powerRestoreTotalTime > 0 then
				addLocalNotification(string.lf("上仙, 体力已满, 是不是还有很多三星宝箱没拿呢？快来吧!"), Player.powerRestoreTotalTime)
			end

			local var_7_2 = os.date("*t", os.time())
			local var_7_3 = 0
			local var_7_4 = clone(var_7_2)

			var_7_4.min = 0
			var_7_4.sec = 0

			if var_7_4.hour < 12 then
				var_7_4.hour = 12
				var_7_3 = os.time(var_7_4) - os.time(var_7_2)
			elseif var_7_4.hour < 18 then
				var_7_4.hour = 18
				var_7_3 = os.time(var_7_4) - os.time(var_7_2)
			else
				var_7_4.hour = 12
				var_7_3 = os.time(var_7_4) - os.time(var_7_2) + 86400
			end

			if var_7_3 > 0 then
				addLocalNotification(string.lf("上仙, 仙女们已经把天女散花准备好了, 提着篮子来接吧!"), var_7_3)
			end

			if Player.xmPushTime > 0 then
				addLocalNotification(string.lf("上仙，仙魔争霸马上就要开始了，快快上线看看你的战将们进到多少强了吧!"), Player.xmPushTime)
			end

			if Player.bpTime > 0 then
				addLocalNotification(string.lf("上仙，新的一届大闹天宫开始了哦，快上线抽检分组大闹天宫吧~"), Player.bpTime)
			end

			if Player.rpTime > 0 then
				addLocalNotification(string.lf("上仙，大闹天宫马上就要结算奖励了，战将们都想再排名高一点呢~"), Player.rpTime)
			end

			var_7_4.hour = 12

			local var_7_5 = os.time(var_7_4) - os.time(var_7_2) + (6 - var_7_4.wday) * 3600 * 24

			if var_7_5 > 0 then
				addLocalNotification(string.lf("上仙，诸神之战可以下注押宝了，来试试手气吧~"), var_7_5)
			end

			var_7_4.hour = 19

			local var_7_6 = 7

			if var_7_4.wday == 0 then
				var_7_6 = 0
			end

			local var_7_7 = os.time(var_7_4) - os.time(var_7_2) + (var_7_6 - var_7_4.wday) * 3600 * 24

			if var_7_7 > 0 then
				addLocalNotification(string.lf("上仙，诸神之战开打了，来看看谁是全服第一吧~"), var_7_7)
			end
		end

		addLocalNotification(string.lf("上仙, 我们好想你, 战将们已经饥渴难耐了!"), 172800)
	end
end

function game.onEnterForeground(arg_8_0)
	local var_8_0 = LocalData:getSetting()

	if var_8_0.musicEnabled == true then
		SimpleAudioEngine:sharedEngine():resumeBackgroundMusic()
	end

	if var_8_0.pushEnabled == true then
		SimpleAudioEngine:sharedEngine():resumeAllEffects()
	end

	IPlatform:instance():resume()
	Player:scheduleNotify()
end

function game.addNodeToRunningScene(arg_9_0)
	(arg_9_0.scene or CCDirector:sharedDirector():getRunningScene()):addChild(arg_9_0.layer, arg_9_0.zOrder or 0)

	return arg_9_0.layer
end

function game.addNodeToRunningSceneWithAutoCreate(arg_10_0)
	arg_10_0.zOrder = arg_10_0.zOrder or 0
	arg_10_0.justOnce = arg_10_0.justOnce or false

	local var_10_0 = display.getRunningScene()

	if var_10_0 and game.isReplaceing == false then
		local var_10_1 = game.newRunningNode(arg_10_0.ctorFunc, arg_10_0.data, arg_10_0.zOrder, arg_10_0.ignoreScenes, false)

		var_10_0:addChild(var_10_1, arg_10_0.zOrder)

		if arg_10_0.justOnce == true then
			game.runningTable[arg_10_0.ctorFunc] = nil
		end
	else
		game.runningTable[arg_10_0.ctorFunc] = {
			data = arg_10_0.data,
			order = arg_10_0.zOrder,
			hideScenes = arg_10_0.ignoreScenes,
			once = arg_10_0.justOnce
		}
	end
end

function game.newRunningNode(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	game.deleteRunningNode(arg_11_0)

	local var_11_0 = arg_11_0(arg_11_1)

	var_11_0:setNodeEventEnabled(true)

	function var_11_0.onExit(arg_12_0)
		for iter_12_0, iter_12_1 in pairs(game.runningTable) do
			if iter_12_0 == arg_11_0 and game.runningTable[iter_12_0] then
				game.runningTable[iter_12_0].node = nil

				break
			end
		end

		if arg_12_0.onOrignExit then
			arg_12_0.onOrignExit(arg_12_0)
		end
	end

	game.runningTable[arg_11_0] = {
		node = var_11_0,
		data = arg_11_1,
		order = arg_11_2,
		hideScenes = arg_11_3,
		once = arg_11_4
	}

	return var_11_0
end

function game.reloadRunningNode(arg_13_0, arg_13_1)
	local var_13_0 = game.runningTable[arg_13_0]

	if var_13_0 and arg_13_1 and var_13_0.node and type(var_13_0.node.reloadNode) == "function" then
		var_13_0.node:reloadNode(arg_13_1)

		var_13_0.data = arg_13_1
	end
end

function game.deleteRunningNode(arg_14_0)
	local var_14_0 = game.runningTable[arg_14_0]

	if var_14_0 then
		if var_14_0.node then
			var_14_0.node:removeFromParent()
		end

		game.runningTable[arg_14_0] = nil
	end
end

function game.isFuncRunningNode(arg_15_0)
	return game.runningTable[arg_15_0] ~= nil
end

function game.replaceScene(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.__cname

	local function var_16_1(arg_17_0)
		for iter_17_0, iter_17_1 in pairs(game.runningTable) do
			if iter_17_1.once == arg_17_0 then
				local var_17_0 = false

				if iter_17_1.hideScenes and table.nums(iter_17_1.hideScenes) then
					for iter_17_2, iter_17_3 in ipairs(iter_17_1.hideScenes) do
						if var_16_0 == iter_17_3 then
							var_17_0 = true

							break
						end
					end
				end

				if var_17_0 == false then
					local var_17_1 = game.newRunningNode(iter_17_0, iter_17_1.data, iter_17_1.order, iter_17_1.hideScenes, iter_17_1.once)

					arg_16_0:addChild(var_17_1, iter_17_1.order)

					if arg_17_0 == true then
						game.runningTable[iter_17_0] = nil
					end
				end
			end
		end
	end

	local var_16_2 = CCDirector:sharedDirector():getRunningScene()

	if var_16_2 then
		game.isReplaceing = true

		NetworkMediator:setServerSceneName((var_16_2.__cname or "") .. "|" .. var_16_0)
		var_16_1(false)

		local var_16_3 = var_16_2.onExit

		function var_16_2.onExit(arg_18_0)
			var_16_1(true)

			game.isReplaceing = false

			var_16_3(arg_18_0)
		end
	else
		var_16_1(false)
	end

	display.replaceScene(arg_16_0, arg_16_1, arg_16_2)

	if var_16_0 == "BattleScene" then
		if not game.currentBGM or game.currentBGM ~= _IDLE_GAME_MUSIC_BATTLE1 and game.currentBGM ~= _IDLE_GAME_MUSIC_BATTLE2 then
			local var_16_4 = math.random(2)

			if var_16_4 == 1 then
				var_16_4 = _IDLE_GAME_MUSIC_BATTLE1
			else
				var_16_4 = _IDLE_GAME_MUSIC_BATTLE2
			end

			game.currentBGM = var_16_4

			playGameBackgroundMusic(game.currentBGM)
		end
	elseif var_16_0 == "OpeningAnimationScene" or var_16_0 == "ActivityScene" then
		if not game.currentBGM or game.currentBGM ~= _IDLE_GAME_MUSIC_GUIDER then
			game.currentBGM = _IDLE_GAME_MUSIC_GUIDER

			playGameBackgroundMusic(game.currentBGM)
		end
	elseif var_16_0 == "MapChapterScene" or var_16_0 == "MapWorldScene" then
		if not game.currentBGM or game.currentBGM ~= _IDLE_GAME_MUSIC_MAP then
			game.currentBGM = _IDLE_GAME_MUSIC_MAP

			playGameBackgroundMusic(game.currentBGM)
		end
	elseif var_16_0 == "StartGameScene" or var_16_0 == "ServerListScene" then
		if not game.currentBGM or game.currentBGM ~= _IDLE_GAME_MUSIC_STARTGAME then
			game.currentBGM = _IDLE_GAME_MUSIC_STARTGAME

			playGameBackgroundMusic(game.currentBGM)
		end
	elseif not game.currentBGM or game.currentBGM ~= _IDLE_GAME_MUSIC_HOME then
		game.currentBGM = _IDLE_GAME_MUSIC_HOME

		playGameBackgroundMusic(game.currentBGM)
	end
end

function game.enterHomeScene(arg_19_0)
	if Player:getTroMaxStep() == 0 then
		require("scenes.battle.BattleOperator"):startBattle(eBattleType.Guider, {}, function(...)
			game.enterHomeScene()
		end)

		return
	end

	game.replaceScene(require("scenes.home.HomeScene").new(arg_19_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterMapWorldScene(arg_21_0)
	game.replaceScene(require("scenes.map.MapWorldScene").new(arg_21_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterMapChapterScene(arg_22_0)
	game.replaceScene(require("scenes.map.MapChapterScene").new(arg_22_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterStartGameScene(arg_23_0)
	local var_23_0 = require("scenes.login.StartGameScene").new(arg_23_0)

	game.replaceScene(var_23_0, "CCTransitionCrossFade", var_0_0)

	return var_23_0
end

function game.enterServerListScene(arg_24_0)
	local var_24_0 = require("scenes.login.ServerListScene").new(arg_24_0)

	game.replaceScene(var_24_0, "CCTransitionCrossFade", var_0_0)

	return var_24_0
end

function game.enterNicknameScene(arg_25_0)
	game.replaceScene(require("scenes.login.NicknameScene").new(arg_25_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterTeamScene(arg_26_0)
	game.replaceScene(require("scenes.team.TeamScene").new(arg_26_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterMailScene(arg_27_0)
	game.replaceScene(require("scenes.mail.MailScene").new(arg_27_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterChangeFigureScene(arg_28_0)
	game.replaceScene(require("scenes.team.ChangeFigureScene").new(arg_28_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterTransferEffectScene(arg_29_0)
	game.replaceScene(require("scenes.team.TransferEffectScene").new(arg_29_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterAccountLoginScene(arg_30_0)
	game.replaceScene(require("scenes.login.AccountLoginScene").new(arg_30_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterRegisterAccountScene(arg_31_0)
	game.replaceScene(require("scenes.login.RegisterAccountScene").new(arg_31_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterChangePasswordScene(arg_32_0)
	game.replaceScene(require("scenes.login.ChangePasswordScene").new(arg_32_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterResetPasswordScene(arg_33_0)
	game.replaceScene(require("scenes.login.ResetPasswordScene").new(arg_33_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterResetPasswordSucessScene(arg_34_0)
	game.replaceScene(require("scenes.login.ResetPasswordSucessScene").new(arg_34_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterFormationScene(arg_35_0)
	game.replaceScene(require("scenes.team.FormationScene").new(arg_35_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterBagScene(arg_36_0)
	game.replaceScene(require("scenes.bag.BagScene").new(arg_36_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterEnhanceScene(arg_37_0)
	game.replaceScene(require("scenes.enhance.EnhanceScene").new(arg_37_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterRefineScene(arg_38_0)
	local var_38_0 = GameFeaturesLevel[GameFeatures.eRefine].level

	if var_38_0 > Player.level then
		showFlashNotice(string.lf("您尚未达到%d级，无法进入炼化炉。", var_38_0))

		return
	end

	game.replaceScene(require("scenes.enhance.RefineScene").new(arg_38_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterCheckUpdateScene(arg_39_0)
	game.replaceScene(require("scenes.login.CheckUpdateScene").new(arg_39_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterStoreScene(arg_40_0)
	game.replaceScene(require("scenes.store.StoreScene").new(arg_40_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterStoreRechargeScene(arg_41_0)
	game.replaceScene(require("scenes.store.StoreRechargeScene").new(arg_41_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterFriendScene(arg_42_0)
	local var_42_0 = GameFeaturesLevel[GameFeatures.eFriend].level

	if var_42_0 > Player.level then
		showFlashNotice(string.lf("您尚未达到%d级，无法进入好友。", var_42_0))

		return
	end

	game.replaceScene(require("scenes.friend.FriendScene").new(arg_42_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterBattleScene(arg_43_0)
	local var_43_0 = require("scenes.battle.BattleScene").new(arg_43_0)

	game.replaceScene(var_43_0, "CCTransitionCrossFade", var_0_0)

	return var_43_0
end

function game.enterTujianScene(arg_44_0)
	game.replaceScene(require("scenes.system.TujianScene").new(arg_44_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterTransportScene(arg_45_0)
	local var_45_0 = GameFeaturesLevel[GameFeatures.eTransport].level

	if var_45_0 > Player.level then
		showFlashNotice(string.lf("您尚未达到%d级，无法进入运镖。", var_45_0))

		return
	end

	game.replaceScene(require("scenes.transport.TransportScene").new(arg_45_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterActivityScene(arg_46_0)
	game.replaceScene(require("scenes.activity.ActivityScene").new(arg_46_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterZhaoCaiFuScene(arg_47_0)
	game.replaceScene(require("scenes.zhaocaifu.ZhaoCaiFuScene").new(arg_47_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterTSCaveScene(arg_48_0)
	local var_48_0 = GameFeaturesLevel[GameFeatures.eQiShuHealth].level

	if var_48_0 > Player.level then
		showFlashNotice(string.lf("您尚未达到%d级，无法进入奇术。", var_48_0))

		return
	end

	game.replaceScene(require("scenes.qishu.TSCaveScene").new(arg_48_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterQiShuScene(arg_49_0)
	game.replaceScene(require("scenes.qishu.QiShuScene").new(arg_49_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterTianmingScene(arg_50_0)
	game.replaceScene(require("scenes.tianming.TianmingScene").new(arg_50_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterTianmingRecruitScene(arg_51_0)
	if Player.level < GameFeaturesLevel[GameFeatures.eTianming].level then
		showFlashNotice(string.lf("您尚未达到%d级，无法打开天命。", GameFeaturesLevel[GameFeatures.eTianming].level))

		return
	end

	game.replaceScene(require("scenes.tianming.TianmingRecruitScene").new(arg_51_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterPKScene(arg_52_0)
	local var_52_0 = GameFeaturesLevel[GameFeatures.ePK].level

	if var_52_0 > Player.level then
		showFlashNotice(string.lf("您尚未达到%d级，无法进入竞技场。", var_52_0))

		return
	end

	game.replaceScene(require("scenes.PK.PKScene").new(arg_52_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterCSBattleScene(arg_53_0)
	game.replaceScene(require("scenes.PK.CSBattleScene").new(arg_53_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterCSGambleScene(arg_54_0)
	game.replaceScene(require("scenes.PK.CSGambleScene").new(arg_54_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterMysticStoreScene(arg_55_0)
	local var_55_0 = GameFeaturesLevel[GameFeatures.eMysticStore].level
	local var_55_1 = GameFeaturesLevel[GameFeatures.eMysticStore].name

	if var_55_0 > Player.level then
		showFlashNotice(string.lf("您尚未达到%d级，无法进入%s。", var_55_0, var_55_1))

		return
	end

	game.replaceScene(require("scenes.store.MysticStoreScene").new(arg_55_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterGuildMemberScene(arg_56_0)
	game.replaceScene(require("scenes.guild.GuildMemberScene").new(arg_56_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterGuildPersonnelScene(arg_57_0)
	game.replaceScene(require("scenes.guild.GuildPersonnelScene").new(arg_57_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterGuildBossPreviewScene(arg_58_0)
	game.replaceScene(require("scenes.guild.GuildBossPreviewScene").new(arg_58_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterGuildRequestScene(arg_59_0)
	game.replaceScene(require("scenes.guild.GuildRequestScene").new(arg_59_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterSlaveScene(arg_60_0)
	local var_60_0 = GameFeaturesLevel[GameFeatures.eSlave1].level

	if var_60_0 > Player.level then
		showFlashNotice(string.lf("您尚未达到%d级，无法进入小黑屋。", var_60_0))

		return
	end

	game.replaceScene(require("scenes.slave.SlaveScene").new(arg_60_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterTowerFloorScene(arg_61_0)
	local var_61_0 = GameFeaturesLevel[GameFeatures.eTower].level
	local var_61_1 = GameFeaturesLevel[GameFeatures.eTower].name

	if var_61_0 > Player.level then
		showFlashNotice(string.lf("您尚未达到%d级，无法进入%s。", var_61_0, var_61_1))

		return
	end

	game.replaceScene(require("scenes.Tower.TowerFloorScene").new(arg_61_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterFubenIndexScene(arg_62_0)
	local var_62_0 = GameFeaturesLevel[GameFeatures.eFuBen].level
	local var_62_1 = GameFeaturesLevel[GameFeatures.eFuBen].name

	if var_62_0 > Player.level then
		showFlashNotice(string.lf("您尚未达到%d级，无法进入%s。", var_62_0, var_62_1))

		return
	end

	game.replaceScene(require("scenes.fuben.FubenIndexScene").new(arg_62_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterPlutusScene(arg_63_0)
	game.replaceScene(require("scenes.activity.PlutusScene").new(arg_63_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterAnnouncementScene(arg_64_0)
	game.replaceScene(require("scenes.home.AnnouncementScene").new(arg_64_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterHeroScene(arg_65_0)
	game.replaceScene(require("scenes.bag.HeroScene").new(arg_65_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterFilmScene(arg_66_0)
	game.replaceScene(require("scenes.login.OpeningAnimationScene").new(arg_66_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterCSHomeScene(arg_67_0)
	local var_67_0 = GameFeaturesLevel[GameFeatures.eCS].level
	local var_67_1 = GameFeaturesLevel[GameFeatures.eCS].name

	if var_67_0 > Player.level then
		showFlashNotice(string.lf("您尚未达到%d级，无法进入%s。", var_67_0, var_67_1))

		return
	end

	game.replaceScene(require("scenes.PK.CSHomeScene").new(arg_67_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterCSRankScene(arg_68_0)
	game.replaceScene(require("scenes.PK.CSRankScene").new(arg_68_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterShenqiScene(arg_69_0)
	local var_69_0 = GameFeaturesLevel[GameFeatures.eShenQi].level
	local var_69_1 = GameFeaturesLevel[GameFeatures.eShenQi].name

	if var_69_0 > Player.level then
		showFlashNotice(string.lf("您尚未达到%d级，无法进入%s。", var_69_0, var_69_1))

		return
	end

	game.replaceScene(require("scenes.shenqi.ShenqiScene").new(arg_69_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterGuildHomeScene(arg_70_0)
	local var_70_0 = GameFeaturesLevel[GameFeatures.eGuild].level
	local var_70_1 = GameFeaturesLevel[GameFeatures.eGuild].name

	if var_70_0 > Player.level then
		showFlashNotice(string.lf("您尚未达到%d级，无法进入%s。", var_70_0, var_70_1))

		return
	end

	if Player.isHaveGuild == false then
		showFlashNotice(string.lf("您尚未加入任何仙盟。"))

		return
	end

	game.replaceScene(require("scenes.guild.GuildHomeScene").new(arg_70_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterGuildStoreScene(arg_71_0)
	game.replaceScene(require("scenes.guild.GuildStoreScene").new(arg_71_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterGuildPalaceScene(arg_72_0)
	game.replaceScene(require("scenes.guild.GuildPalaceScene").new(arg_72_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterGuildMapScene(arg_73_0)
	game.replaceScene(require("scenes.guild.GuildMapScene").new(arg_73_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterGuildPeachScene(arg_74_0)
	game.replaceScene(require("scenes.guild.GuildPeachScene").new(arg_74_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterGuildUpgradeScene(arg_75_0)
	game.replaceScene(require("scenes.guild.GuildUpgrateScene").new(arg_75_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterGuildHallScene(arg_76_0)
	game.replaceScene(require("scenes.guild.GuildHallScene").new(arg_76_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterDuelRankScene(arg_77_0)
	local var_77_0 = GameFeaturesLevel[GameFeatures.eDuelFight].level
	local var_77_1 = GameFeaturesLevel[GameFeatures.eDuelFight].name

	if var_77_0 > Player.level then
		return showFlashNotice(string.lf("您尚未达到%d级，无法进入%s。", var_77_0, var_77_1))
	end

	game.replaceScene(require("scenes.duel.DuelRankScene").new(arg_77_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterWorldBossHomeScene(arg_78_0)
	local var_78_0 = GameFeaturesLevel[GameFeatures.eWorldBoss].level
	local var_78_1 = GameFeaturesLevel[GameFeatures.eWorldBoss].name

	if var_78_0 > Player.level then
		return showFlashNotice(string.lf("您尚未达到%d级，无法进入%s。", var_78_0, var_78_1))
	end

	game.replaceScene(require("scenes.worldboss.WorldBossHomeScene").new(arg_78_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterWorldBossBattleScene(arg_79_0)
	game.replaceScene(require("scenes.worldboss.WorldBossBattleScene").new(arg_79_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterXunfangScene(arg_80_0)
	local var_80_0 = GameFeaturesLevel[GameFeatures.eXunfang].level
	local var_80_1 = GameFeaturesLevel[GameFeatures.eXunfang].name

	if var_80_0 > Player.level then
		return showFlashNotice(string.lf("您尚未达到%d级，无法进入%s。", var_80_0, var_80_1))
	end

	game.replaceScene(require("scenes.xunfang.XunfangScene").new(arg_80_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterZSQHomeScene(arg_81_0)
	game.replaceScene(require("scenes.fuben.ZSQHomeScene").new(arg_81_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterZSZZFightScene(arg_82_0)
	game.replaceScene(require("scenes.fuben.ZSZZFightScene").new(arg_82_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterZSZZHomeScene(arg_83_0)
	game.replaceScene(require("scenes.fuben.ZSZZHomeScene").new(arg_83_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterZSZZGambleScene(arg_84_0)
	game.replaceScene(require("scenes.fuben.ZSZZGambleScene").new(arg_84_0), "CCTransitionCrossFade", var_0_0)
end

function game.enterMineralScene(arg_85_0)
	game.replaceScene(require("scenes.mineral.MineralHomeScene").new(arg_85_0), "CCTransitionCrossFade", var_0_0)
end

return game
