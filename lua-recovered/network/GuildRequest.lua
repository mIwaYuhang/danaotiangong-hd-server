CreateGuildRequest = NetworkRequest:new()

function CreateGuildRequest.request(arg_1_0, arg_1_1)
	local var_1_0 = string.format(ServerUrl.CreateGuild, Player.userId, stringBase64AndUrlEncode(arg_1_1))

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function CreateGuildRequest.parseJsonValue(arg_2_0, arg_2_1)
	arg_2_0.restable = arg_2_1
end

function CreateGuildRequest.getResult(arg_3_0)
	return arg_3_0.restable
end

GetGuildConfigRequest = NetworkRequest:new()
GetGuildConfigRequest.timeoutOperate = TimeoutOperation.eRetry

function GetGuildConfigRequest.request(arg_4_0)
	local var_4_0 = string.format(ServerUrl.GetGuildConfig, Player.userId)

	arg_4_0:startHttpRequest(var_4_0, false, nil, true)
end

function GetGuildConfigRequest.parseJsonValue(arg_5_0, arg_5_1)
	arg_5_0.restable = arg_5_1
end

function GetGuildConfigRequest.getResult(arg_6_0)
	return arg_6_0.restable
end

GetGuildListRequest = NetworkRequest:new()
GetGuildListRequest.timeoutOperate = TimeoutOperation.eRetry

function GetGuildListRequest.request(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = string.format(ServerUrl.GetGuildList, Player.userId, arg_7_1, arg_7_2 or 20)

	arg_7_0:startHttpRequest(var_7_0, false, nil, true)
end

function GetGuildListRequest.parseJsonValue(arg_8_0, arg_8_1)
	arg_8_0.restable = arg_8_1
end

function GetGuildListRequest.getResult(arg_9_0)
	return arg_9_0.restable
end

GetPlayerGuildInfoRequest = NetworkRequest:new()
GetPlayerGuildInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function GetPlayerGuildInfoRequest.request(arg_10_0)
	local var_10_0 = string.format(ServerUrl.GetPlayerGuildInfo, Player.userId)

	arg_10_0:startHttpRequest(var_10_0, false, nil, true)
end

function GetPlayerGuildInfoRequest.parseJsonValue(arg_11_0, arg_11_1)
	arg_11_0.restable = arg_11_1
end

function GetPlayerGuildInfoRequest.getResult(arg_12_0)
	return arg_12_0.restable
end

GetHallInfoRequest = NetworkRequest:new()
GetHallInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function GetHallInfoRequest.request(arg_13_0)
	local var_13_0 = string.format(ServerUrl.GetHallInfo, Player.userId)

	arg_13_0:startHttpRequest(var_13_0, false, nil, true)
end

function GetHallInfoRequest.parseJsonValue(arg_14_0, arg_14_1)
	arg_14_0.restable = arg_14_1
end

GetPlayerUnionInfoRequest = NetworkRequest:new()

function GetPlayerUnionInfoRequest.request(arg_15_0)
	local var_15_0 = string.format(ServerUrl.GetPlayerUnionInfo, Player.userId)

	arg_15_0:startHttpRequest(var_15_0, false, nil, true)
end

function GetPlayerUnionInfoRequest.parseJsonValue(arg_16_0, arg_16_1)
	arg_16_0.restable = arg_16_1
end

JoinGuildRequest = NetworkRequest:new()
JoinGuildRequest.timeoutOperate = TimeoutOperation.eRetry

function JoinGuildRequest.request(arg_17_0, arg_17_1)
	local var_17_0 = string.format(ServerUrl.ApplyJoinGuild, Player.userId, arg_17_1, true)

	arg_17_0:startHttpRequest(var_17_0, false, nil, true)
end

function JoinGuildRequest.parseJsonValue(arg_18_0, arg_18_1)
	arg_18_0.restable = arg_18_1
end

function JoinGuildRequest.getResult(arg_19_0)
	return arg_19_0.restable
end

ApplyJoinListRequest = NetworkRequest:new()

function ApplyJoinListRequest.request(arg_20_0, arg_20_1)
	local var_20_0 = string.format(ServerUrl.ApplyJoinList, Player.userId, arg_20_1)

	arg_20_0:startHttpRequest(var_20_0, false, nil, true)
end

function ApplyJoinListRequest.parseJsonValue(arg_21_0, arg_21_1)
	arg_21_0.restable = arg_21_1
end

ApplyJoinUserRequest = NetworkRequest:new()

function ApplyJoinUserRequest.request(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = string.format(ServerUrl.ApplyJoinUser, Player.userId, arg_22_1, arg_22_2)

	arg_22_0:startHttpRequest(var_22_0, false, nil, true)
end

function ApplyJoinUserRequest.parseJsonValue(arg_23_0, arg_23_1)
	arg_23_0.restable = arg_23_1
end

GuildWorshipRequest = NetworkRequest:new()

function GuildWorshipRequest.request(arg_24_0, arg_24_1)
	local var_24_0 = string.format(ServerUrl.GuildWorship, Player.userId, tostring(arg_24_1))

	arg_24_0:startHttpRequest(var_24_0, false, nil, true)
end

function GuildWorshipRequest.parseJsonValue(arg_25_0, arg_25_1)
	arg_25_0.restable = arg_25_1
end

ChangeGuildPositionRequest = NetworkRequest:new()

function ChangeGuildPositionRequest.request(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = string.format(ServerUrl.ChangeGuildPosition, Player.userId, arg_26_1, tostring(arg_26_2))

	arg_26_0:startHttpRequest(var_26_0, false, nil, true)
end

function ChangeGuildPositionRequest.parseJsonValue(arg_27_0, arg_27_1)
	arg_27_0.restable = arg_27_1
end

ChangeGuildLeaderRequest = NetworkRequest:new()

function ChangeGuildLeaderRequest.request(arg_28_0, arg_28_1)
	local var_28_0 = string.format(ServerUrl.ChangeGuildLeader, Player.userId, arg_28_1)

	arg_28_0:startHttpRequest(var_28_0, false, nil, true)
end

function ChangeGuildLeaderRequest.parseJsonValue(arg_29_0, arg_29_1)
	arg_29_0.restable = arg_29_1
end

GuildLeaveRequest = NetworkRequest:new()

function GuildLeaveRequest.request(arg_30_0)
	local var_30_0 = string.format(ServerUrl.GuildLeave, Player.userId)

	arg_30_0:startHttpRequest(var_30_0, false, nil, true)
end

function GuildLeaveRequest.parseJsonValue(arg_31_0, arg_31_1)
	arg_31_0.restable = arg_31_1
end

GuildKickoutRequest = NetworkRequest:new()

function GuildKickoutRequest.request(arg_32_0, arg_32_1)
	local var_32_0 = string.format(ServerUrl.GuildKickout, Player.userId, arg_32_1)

	arg_32_0:startHttpRequest(var_32_0, false, nil, true)
end

function GuildKickoutRequest.parseJsonValue(arg_33_0, arg_33_1)
	arg_33_0.restable = arg_33_1
end

GuildDeleteRequest = NetworkRequest:new()

function GuildDeleteRequest.request(arg_34_0)
	local var_34_0 = string.format(ServerUrl.GuildDelete, Player.userId)

	arg_34_0:startHttpRequest(var_34_0, false, nil, true)
end

function GuildDeleteRequest.parseJsonValue(arg_35_0, arg_35_1)
	arg_35_0.restable = arg_35_1
end

ChangeApplyStatusRequest = NetworkRequest:new()

function ChangeApplyStatusRequest.request(arg_36_0, arg_36_1)
	local var_36_0 = string.format(ServerUrl.ChangeApplyStatus, Player.userId, tostring(arg_36_1))

	arg_36_0:startHttpRequest(var_36_0, false, nil, true)
end

function ChangeApplyStatusRequest.parseJsonValue(arg_37_0, arg_37_1)
	arg_37_0.restable = arg_37_1
end

GuildRequest = NetworkRequest:new()
GuildRequest.timeoutOperate = TimeoutOperation.eRetry
GuildRequest.eUserList = 1
GuildRequest.eJoinList = 2
GuildRequest.eDisband = 3
GuildRequest.eChange = 4
GuildRequest.eQuit = 5
GuildRequest.eKickOut = 6
GuildRequest.eBatch = 7
GuildRequest.eFriend = 8
GuildRequest.eJoin = 9
GuildRequest.eRefuse = 10
GuildRequest.eContact = 11
GuildRequest.eStatus = 12
GuildRequest.eDistribute = 13

function GuildRequest.requestUserList(arg_38_0)
	local var_38_0 = string.format(ServerUrl.GuildUserList, Player.userId)

	arg_38_0:startHttpRequest(var_38_0, false, nil, true)

	arg_38_0.state = GuildRequest.eUserList
end

function GuildRequest.requestJoinList(arg_39_0)
	local var_39_0 = string.format(ServerUrl.ApplyJoinList, Player.userId)

	arg_39_0:startHttpRequest(var_39_0, false, nil, true)

	arg_39_0.state = GuildRequest.eJoinList
end

function GuildRequest.requestDisband(arg_40_0)
	local var_40_0 = string.format(ServerUrl.GuildDelete, Player.userId)

	arg_40_0:startHttpRequest(var_40_0, false, nil, true)

	arg_40_0.state = GuildRequest.eDisband
end

function GuildRequest.requestQuit(arg_41_0)
	local var_41_0 = string.format(ServerUrl.GuildLeave, Player.userId)

	arg_41_0:startHttpRequest(var_41_0, false, nil, true)

	arg_41_0.state = GuildRequest.eQuit
end

function GuildRequest.requestStatus(arg_42_0, arg_42_1)
	local var_42_0 = string.format(ServerUrl.ChangeApplyStatus, Player.userId, arg_42_1 and 1 or 0)

	arg_42_0:startHttpRequest(var_42_0, false, nil, true)

	arg_42_0.state = GuildRequest.eStatus
end

function GuildRequest.requestChange(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = string.format(ServerUrl.ChangeGuildPosition, Player.userId, arg_43_1, arg_43_2)

	arg_43_0:startHttpRequest(var_43_0, false, nil, true)

	arg_43_0.state = GuildRequest.eChange
end

function GuildRequest.requestKickout(arg_44_0, arg_44_1)
	local var_44_0 = string.format(ServerUrl.GuildKickout, Player.userId, arg_44_1)

	arg_44_0:startHttpRequest(var_44_0, false, nil, true)

	arg_44_0.state = GuildRequest.eKickOut
end

function GuildRequest.requestJoin(arg_45_0, arg_45_1)
	local var_45_0 = string.format(ServerUrl.ApplyJoinUser, Player.userId, arg_45_1)

	arg_45_0:startHttpRequest(var_45_0, false, nil, true)

	arg_45_0.state = GuildRequest.eJoin
end

function GuildRequest.requestRefuse(arg_46_0, arg_46_1)
	local var_46_0 = string.format(ServerUrl.RefuseGuildApply, Player.userId, arg_46_1)

	arg_46_0:startHttpRequest(var_46_0, false, nil, true)

	arg_46_0.state = GuildRequest.eRefuse
end

function GuildRequest.requestBatch(arg_47_0, arg_47_1)
	local var_47_0

	if arg_47_1 then
		var_47_0 = string.format(ServerUrl.GuildOneKeyApply, Player.userId)
	else
		var_47_0 = string.format(ServerUrl.GuildOneKeyRefuse, Player.userId)
	end

	arg_47_0:startHttpRequest(var_47_0, false, nil, true)

	arg_47_0.state = GuildRequest.eBatch
end

function GuildRequest.requestFriend(arg_48_0, arg_48_1, arg_48_2)
	arg_48_2 = arg_48_2 or ""

	if #arg_48_2 > 0 then
		arg_48_2 = stringBase64AndUrlEncode(arg_48_2)
	end

	local var_48_0 = string.format(ServerUrl.AddFriend, Player.userId, arg_48_1)

	arg_48_0.state = GuildRequest.eFriend

	arg_48_0:startHttpRequest(var_48_0, true, {
		message = arg_48_2
	}, true)
end

function GuildRequest.requestContact(arg_49_0, arg_49_1, arg_49_2)
	arg_49_2 = arg_49_2 or ""

	if #arg_49_2 > 0 then
		arg_49_2 = stringBase64AndUrlEncode(arg_49_2)
	end

	local var_49_0 = string.format(ServerUrl.ContactFriend, Player.userId, arg_49_1)

	arg_49_0.state = GuildRequest.eContact

	arg_49_0:startHttpRequest(var_49_0, true, {
		message = arg_49_2
	}, true)
end

function GuildRequest.requestDistribute(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = type(arg_50_1)

	if var_50_0 == "table" then
		arg_50_1 = table.concat(arg_50_1, ",")
	elseif var_50_0 == "nil" then
		return
	end

	local var_50_1 = string.format(ServerUrl.GiveUnionCoin, Player.userId)

	arg_50_0:startHttpRequest(var_50_1, true, {
		playerIdList = arg_50_1,
		coinCount = arg_50_2
	}, true)

	arg_50_0.state = GuildRequest.eDistribute
end

function GuildRequest.parseJsonValue(arg_51_0, arg_51_1)
	arg_51_0.restable = arg_51_1

	if arg_51_0.state == GuildRequest.eQuit or arg_51_0.state == GuildRequest.eDisband then
		Player:setIsHaveGuild(false)
		Player:setGuildStatus(false)
	end
end

function GuildRequest.getResponseContent(arg_52_0)
	return arg_52_0.state, arg_52_0.restable
end

GetZhenpinRequest = NetworkRequest:new()
GetZhenpinRequest.timeoutOperate = TimeoutOperation.eRetry

function GetZhenpinRequest.requestZhenpinList(arg_53_0)
	local var_53_0 = string.format(ServerUrl.GetZhenpin, Player.userId)

	arg_53_0:startHttpRequest(var_53_0, false, nil, true)

	arg_53_0.state = GuildRequest.ePlayerList
end

function GetZhenpinRequest.parseJsonValue(arg_54_0, arg_54_1)
	arg_54_0.restable = arg_54_1
end

function GetZhenpinRequest.getZhenpinCoolTime(arg_55_0)
	return arg_55_0.restable.HaveTimes
end

function GetZhenpinRequest.getZhenpinList(arg_56_0)
	return arg_56_0.restable.ZhenPinLst
end

BuyZhenpinRequest = NetworkRequest:new()
BuyZhenpinRequest.timeoutOperate = TimeoutOperation.eRetry

function BuyZhenpinRequest.requestBuyZhenpin(arg_57_0, arg_57_1)
	local var_57_0 = string.format(ServerUrl.BuyZhenpin, Player.userId, arg_57_1)

	arg_57_0:startHttpRequest(var_57_0, false, nil, true)
end

function BuyZhenpinRequest.parseJsonValue(arg_58_0, arg_58_1)
	arg_58_0.restable = arg_58_1
end

function BuyZhenpinRequest.getBuyState(arg_59_0)
	return arg_59_0.restable
end

GetFixGoodRequest = NetworkRequest:new()
GetFixGoodRequest.timeoutOperate = TimeoutOperation.eRetry

function GetFixGoodRequest.requestFixGoodList(arg_60_0)
	local var_60_0 = string.format(ServerUrl.GetFixGood, Player.userId)

	arg_60_0:startHttpRequest(var_60_0, false, nil, true)
end

function GetFixGoodRequest.parseJsonValue(arg_61_0, arg_61_1)
	arg_61_0.restable = arg_61_1
end

function GetFixGoodRequest.getFixGoodList(arg_62_0)
	return arg_62_0.restable
end

BuyFixGoodsRequest = NetworkRequest:new()
BuyFixGoodsRequest.timeoutOperate = TimeoutOperation.eRetry

function BuyFixGoodsRequest.requestBuyFixGoods(arg_63_0, arg_63_1)
	local var_63_0 = string.format(ServerUrl.BuyFixGoods, Player.userId, arg_63_1)

	arg_63_0:startHttpRequest(var_63_0, false, nil, true)
end

function BuyFixGoodsRequest.parseJsonValue(arg_64_0, arg_64_1)
	arg_64_0.restable = arg_64_1
end

function BuyFixGoodsRequest.getBuyState(arg_65_0)
	return arg_65_0.restable
end

GetPreciousRequest = NetworkRequest:new()
GetPreciousRequest.timeoutOperate = TimeoutOperation.eRetry

function GetPreciousRequest.requestPreciousList(arg_66_0)
	local var_66_0 = string.format(ServerUrl.GetUnionStoreList, Player.userId)

	arg_66_0:startHttpRequest(var_66_0, false, nil, true)
end

function GetPreciousRequest.parseJsonValue(arg_67_0, arg_67_1)
	arg_67_0.restable = arg_67_1
end

function GetPreciousRequest.getPreciousList(arg_68_0)
	return arg_68_0.restable
end

BuyPreciousRequest = NetworkRequest:new()
BuyPreciousRequest.timeoutOperate = TimeoutOperation.eRetry

function BuyPreciousRequest.requestBuyPrecious(arg_69_0, arg_69_1, arg_69_2)
	local var_69_0 = string.format(ServerUrl.BuyUnionStore, Player.userId, arg_69_1, arg_69_2)

	arg_69_0:startHttpRequest(var_69_0, false, nil, true)
end

function BuyPreciousRequest.parseJsonValue(arg_70_0, arg_70_1)
	arg_70_0.restable = arg_70_1
end

UnionDemonListRequest = NetworkRequest:new()

function UnionDemonListRequest.requestDemonList(arg_71_0)
	local var_71_0 = string.format(ServerUrl.UnionDemonList, Player.userId)

	arg_71_0:startHttpRequest(var_71_0, false, nil, true)
end

function UnionDemonListRequest.parseJsonValue(arg_72_0, arg_72_1)
	arg_72_0.restable = arg_72_1
end

function UnionDemonListRequest.getDemonList(arg_73_0)
	return arg_73_0.restable
end

UnionDemonInfoRequest = NetworkRequest:new()

function UnionDemonInfoRequest.requestDemonInfo(arg_74_0, arg_74_1)
	local var_74_0 = string.format(ServerUrl.UnionDemonInfo, Player.userId, arg_74_1, 1)

	arg_74_0:startHttpRequest(var_74_0, false, nil, true)
end

function UnionDemonInfoRequest.parseJsonValue(arg_75_0, arg_75_1)
	arg_75_0.restable = arg_75_1
end

function UnionDemonInfoRequest.getDemonInfo(arg_76_0)
	return arg_76_0.restable
end

UnionDemonKingInfoRequest = NetworkRequest:new()

function UnionDemonKingInfoRequest.requestDemonInfo(arg_77_0, arg_77_1)
	local var_77_0 = string.format(ServerUrl.UnionDemonKingInfo, Player.userId, arg_77_1, 1)

	arg_77_0:startHttpRequest(var_77_0, false, nil, true)
end

function UnionDemonKingInfoRequest.parseJsonValue(arg_78_0, arg_78_1)
	arg_78_0.restable = arg_78_1
end

function UnionDemonKingInfoRequest.getDemonInfo(arg_79_0)
	return arg_79_0.restable
end

UnionDemonChallengeRequest = NetworkRequest:new()

function UnionDemonChallengeRequest.requestDemonChallenge(arg_80_0, arg_80_1, arg_80_2)
	local var_80_0 = string.format(ServerUrl.UnionDemonChallenge, Player.userId, arg_80_1, arg_80_2)

	arg_80_0:startHttpRequest(var_80_0, false, nil, true)
end

function UnionDemonChallengeRequest.parseJsonValue(arg_81_0, arg_81_1)
	arg_81_0.restable = arg_81_1
end

function UnionDemonChallengeRequest.getChallengeResult(arg_82_0)
	return arg_82_0.restable
end

UnionDemonResurgenceRequest = NetworkRequest:new()

function UnionDemonResurgenceRequest.requestDemonResurgence(arg_83_0, arg_83_1)
	local var_83_0 = string.format(ServerUrl.UnionDemonResurgence, Player.userId, arg_83_1)

	arg_83_0:startHttpRequest(var_83_0, false, nil, true)
end

function UnionDemonResurgenceRequest.parseJsonValue(arg_84_0, arg_84_1)
	arg_84_0.restable = arg_84_1
end

function UnionDemonResurgenceRequest.getResurgenceResult(arg_85_0)
	return arg_85_0.restable
end

UnionDemonKingResurgenceRequest = NetworkRequest:new()

function UnionDemonKingResurgenceRequest.requestDemonResurgence(arg_86_0, arg_86_1)
	local var_86_0 = string.format(ServerUrl.UnionDemonKingResurgence, Player.userId, arg_86_1)

	arg_86_0:startHttpRequest(var_86_0, false, nil, true)
end

function UnionDemonKingResurgenceRequest.parseJsonValue(arg_87_0, arg_87_1)
	arg_87_0.restable = arg_87_1
end

function UnionDemonKingResurgenceRequest.getResurgenceResult(arg_88_0)
	return arg_88_0.restable
end

UnionDemonGiveUpRequest = NetworkRequest:new()

function UnionDemonGiveUpRequest.requestDemonGiveUp(arg_89_0, arg_89_1)
	local var_89_0 = string.format(ServerUrl.UnionDemonGiveUp, Player.userId, arg_89_1)

	arg_89_0:startHttpRequest(var_89_0, false, nil, true)
end

function UnionDemonGiveUpRequest.parseJsonValue(arg_90_0, arg_90_1)
	arg_90_0.restable = arg_90_1
end

function UnionDemonGiveUpRequest.getGiveUpResult(arg_91_0)
	return arg_91_0.restable
end

UnionDemonKingGiveUpRequest = NetworkRequest:new()

function UnionDemonKingGiveUpRequest.requestDemonGiveUp(arg_92_0, arg_92_1)
	local var_92_0 = string.format(ServerUrl.UnionDemonKingGiveUp, Player.userId, arg_92_1)

	arg_92_0:startHttpRequest(var_92_0, false, nil, true)
end

function UnionDemonKingGiveUpRequest.parseJsonValue(arg_93_0, arg_93_1)
	arg_93_0.restable = arg_93_1
end

function UnionDemonKingGiveUpRequest.getGiveUpResult(arg_94_0)
	return arg_94_0.restable
end

GetGuildMsgBoardRequest = NetworkRequest:new()

function GetGuildMsgBoardRequest.request(arg_95_0)
	local var_95_0 = string.format(ServerUrl.GetGuildMsgBoard, Player.userId)

	arg_95_0:startHttpRequest(var_95_0, false, nil, true)
end

function GetGuildMsgBoardRequest.parseJsonValue(arg_96_0, arg_96_1)
	arg_96_0.restable = arg_96_1
end

SendGuildMsgBoardRequest = NetworkRequest:new()

function SendGuildMsgBoardRequest.request(arg_97_0, arg_97_1)
	local var_97_0 = string.format(ServerUrl.SendGuildMsgBoard, Player.userId, stringBase64AndUrlEncode(arg_97_1))

	arg_97_0:startHttpRequest(var_97_0, false, nil, true)
end

function SendGuildMsgBoardRequest.parseJsonValue(arg_98_0, arg_98_1)
	arg_98_0.restable = arg_98_1
end

UpdateGuildNoticeRequest = NetworkRequest:new()

function UpdateGuildNoticeRequest.request(arg_99_0, arg_99_1)
	local var_99_0 = string.format(ServerUrl.UpdateGuildNotice, Player.userId)

	arg_99_0:startHttpRequest(var_99_0, true, {
		notice = stringBase64AndUrlEncode(arg_99_1)
	}, true)
end

function UpdateGuildNoticeRequest.parseJsonValue(arg_100_0, arg_100_1)
	arg_100_0.restable = arg_100_1
end

UpdateGuildOutNoticeRequest = NetworkRequest:new()

function UpdateGuildOutNoticeRequest.request(arg_101_0, arg_101_1)
	local var_101_0 = string.format(ServerUrl.UpdateGuildOutNotice, Player.userId)

	arg_101_0:startHttpRequest(var_101_0, true, {
		outNotice = stringBase64AndUrlEncode(arg_101_1)
	}, true)
end

function UpdateGuildOutNoticeRequest.parseJsonValue(arg_102_0, arg_102_1)
	arg_102_0.restable = arg_102_1
end

RefuseGuildApplyRequest = NetworkRequest:new()

function RefuseGuildApplyRequest.request(arg_103_0, arg_103_1)
	local var_103_0 = string.format(ServerUrl.RefuseGuildApply, Player.userId, arg_103_1)

	arg_103_0:startHttpRequest(var_103_0, false, nil, true)
end

function RefuseGuildApplyRequest.parseJsonValue(arg_104_0, arg_104_1)
	arg_104_0.restable = arg_104_1
end

GuildOneKeyApplyRequest = NetworkRequest:new()

function GuildOneKeyApplyRequest.request(arg_105_0)
	local var_105_0 = string.format(ServerUrl.GuildOneKeyApply, Player.userId)

	arg_105_0:startHttpRequest(var_105_0, false, nil, true)
end

function GuildOneKeyApplyRequest.parseJsonValue(arg_106_0, arg_106_1)
	arg_106_0.restable = arg_106_1
end

GuildOneKeyRefuseRequest = NetworkRequest:new()

function GuildOneKeyRefuseRequest.request(arg_107_0)
	local var_107_0 = string.format(ServerUrl.GuildOneKeyRefuse, Player.userId)

	arg_107_0:startHttpRequest(var_107_0, false, nil, true)
end

function GuildOneKeyRefuseRequest.parseJsonValue(arg_108_0, arg_108_1)
	arg_108_0.restable = arg_108_1
end

GuildDemonListRequest = NetworkRequest:new()

function GuildDemonListRequest.request(arg_109_0)
	local var_109_0 = string.format(ServerUrl.UnionDemonList, Player.userId)

	arg_109_0:startHttpRequest(var_109_0, false, nil, true)
end

function GuildDemonListRequest.parseJsonValue(arg_110_0, arg_110_1)
	arg_110_0.restable = arg_110_1
end

function GuildDemonListRequest.getDemonListInfo(arg_111_0)
	return arg_111_0.restable
end

GuildBuildInfoRequest = NetworkRequest:new()

function GuildBuildInfoRequest.request(arg_112_0)
	local var_112_0 = string.format(ServerUrl.GuildBuildInfo, Player.userId)

	arg_112_0:startHttpRequest(var_112_0, false, nil, true)
end

function GuildBuildInfoRequest.parseJsonValue(arg_113_0, arg_113_1)
	arg_113_0.restable = arg_113_1
end

GuildBuildUpgradeRequest = NetworkRequest:new()

function GuildBuildUpgradeRequest.request(arg_114_0, arg_114_1)
	local var_114_0 = string.format(ServerUrl.GuildBuildUpgrade, Player.userId, tostring(arg_114_1))

	arg_114_0:startHttpRequest(var_114_0, false, nil, true)
end

function GuildBuildUpgradeRequest.parseJsonValue(arg_115_0, arg_115_1)
	arg_115_0.restable = arg_115_1
end

GuildLogListRequest = NetworkRequest:new()

function GuildLogListRequest.request(arg_116_0, arg_116_1)
	local var_116_0 = string.format(ServerUrl.GuildLogList, Player.userId, tostring(arg_116_1))

	arg_116_0:startHttpRequest(var_116_0, false, nil, true)
end

function GuildLogListRequest.parseJsonValue(arg_117_0, arg_117_1)
	arg_117_0.restable = arg_117_1
end

CancelApplyGuildRequest = NetworkRequest:new()

function CancelApplyGuildRequest.request(arg_118_0, arg_118_1)
	local var_118_0 = string.format(ServerUrl.CancelApplyGuild, Player.userId, arg_118_1)

	arg_118_0:startHttpRequest(var_118_0, false, nil, true)
end

function CancelApplyGuildRequest.parseJsonValue(arg_119_0, arg_119_1)
	arg_119_0.restable = retable
end

XianTaoInfoRequest = NetworkRequest:new()

function XianTaoInfoRequest.request(arg_120_0)
	local var_120_0 = string.format(ServerUrl.XianTaoInfo, Player.userId)

	arg_120_0:startHttpRequest(var_120_0, false, nil, true)
end

function XianTaoInfoRequest.parseJsonValue(arg_121_0, arg_121_1)
	arg_121_0.restable = arg_121_1
end

EatXianTaoRequest = NetworkRequest:new()

function EatXianTaoRequest.request(arg_122_0)
	local var_122_0 = string.format(ServerUrl.EatXianTao, Player.userId)

	arg_122_0:startHttpRequest(var_122_0, false, nil, true)
end

function EatXianTaoRequest.parseJsonValue(arg_123_0, arg_123_1)
	arg_123_0.restable = arg_123_1
end
