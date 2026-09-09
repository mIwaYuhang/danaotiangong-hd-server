require("network.TeamRequest")
require("network.ZSZZRequest")
require("scenes.team.TeamScene")

OthersTeamHelper = {}
OthersTeamHelper.eDataFromPK = 1
OthersTeamHelper.eDataFromTower = 2
OthersTeamHelper.eDataFromFriend = 3
OthersTeamHelper.eDataFromCSRank = 4
OthersTeamHelper.eDataFromCSGamble = 5
OthersTeamHelper.eDataFromGuildMember = 6
OthersTeamHelper.eDataFromGuildRequest = 7
OthersTeamHelper.eDataFromDuelRank = 8
OthersTeamHelper.eDataFromWorldBossHome = 9
OthersTeamHelper.eDataFromWorldBossBattle = 10
OthersTeamHelper.eDataFromZSZZ = 11
OthersTeamHelper.eDataFromZSQ = 12
OthersTeamHelper.eDataFromPHB = 13

function OthersTeamHelper.checkOthersTeam(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.teamDataFrom = arg_1_3
	arg_1_0.teamDataParams = arg_1_4
	arg_1_0.checkName = arg_1_2

	if arg_1_0.othersTeamRequest == nil then
		local function var_1_0()
			local var_2_0 = {
				[OthersTeamHelper.eDataFromPK] = game.enterPKScene,
				[OthersTeamHelper.eDataFromTower] = game.enterTowerScene,
				[OthersTeamHelper.eDataFromFriend] = game.enterFriendScene,
				[OthersTeamHelper.eDataFromCSRank] = game.enterCSRankScene,
				[OthersTeamHelper.eDataFromCSGamble] = game.enterCSGambleScene,
				[OthersTeamHelper.eDataFromGuildMember] = game.enterGuildMemberScene,
				[OthersTeamHelper.eDataFromGuildRequest] = game.enterGuildRequestScene,
				[OthersTeamHelper.eDataFromDuelRank] = game.enterDuelRankScene,
				[OthersTeamHelper.eDataFromWorldBossHome] = game.enterWorldBossHomeScene,
				[OthersTeamHelper.eDataFromWorldBossBattle] = game.enterWorldBossBattleScene,
				[OthersTeamHelper.eDataFromZSZZ] = game.enterZSZZHomeScene,
				[OthersTeamHelper.eDataFromZSQ] = game.enterZSQHomeScene,
				[OthersTeamHelper.eDataFromPHB] = game.enterHomeScene
			}

			print(arg_1_0.teamDataFrom)

			if arg_1_0.teamDataFrom and var_2_0[arg_1_0.teamDataFrom] then
				if arg_1_0.teamDataParams then
					var_2_0[arg_1_0.teamDataFrom](arg_1_0.teamDataParams)
				else
					var_2_0[arg_1_0.teamDataFrom]()
				end
			else
				game.enterHomeScene()
			end
		end

		local function var_1_1()
			local var_3_0, var_3_1, var_3_2 = arg_1_0.othersTeamRequest:getPlayerTeamAndPartnerTeam()

			require("base.cache").set("team_attributeAddition", var_3_2)
			game.enterTeamScene({
				team = var_3_0,
				partnerTeam = var_3_1,
				dataType = TeamDataType.eTeamOthers,
				returnAction = var_1_0,
				playerName = arg_1_0.checkName
			})
		end

		arg_1_0.othersTeamRequest = PlayerTeamRequest:new()

		arg_1_0.othersTeamRequest:setResponseNormalHandler(var_1_1)
	end

	if arg_1_0.teamDataFrom == OthersTeamHelper.eDataFromZSZZ then
		arg_1_0.othersTeamRequest:requestZSZZ(arg_1_1, arg_1_5)
	else
		arg_1_0.othersTeamRequest:request(arg_1_1)
	end
end
