local var_0_0 = NetworkRequest:new()

var_0_0.timeoutOperate = TimeoutOperation.eNothing
var_0_0.waitType = WaitShowType.eHide

function parseNotifyRequestJsonValue(arg_1_0)
	Player:setDuelObject(arg_1_0.Duel)
	Player:setDarkHouse(arg_1_0.DarkHouse)
	Player:setMailCount(arg_1_0.MailCount)
	Player:setShenQiTimes(arg_1_0.ATimes)
	Player:setCSHaveTime(arg_1_0.XMHaveTime or -1)
	Player:setGuildStatus(arg_1_0.UnionStatus == 1)
	Player:setIsHaveGuild(arg_1_0.IfHaveUnion == 1)
	Player:setBiwuNXM(arg_1_0.NXM)
	Player:setSignMonthCount(arg_1_0.SignRewardShow or 0)
	Player:setSevenLoginCount(arg_1_0.SevenLoginShow or 0)
	Player:setLuckyDiskCount(arg_1_0.LuckydiskShow or 0)
	Player:setLingZhiCount(arg_1_0.PickganodermaShow or 0)
	Player:setSanHuaCount(arg_1_0.FairySendingFlowersShow or 0)
	Player:setActivityCenterCount(arg_1_0.ActivityCenterShow or 0)
	Player:setZhaoCaiFuCount(arg_1_0.LuckySymbolShow or 0)
	Player:setDailySalaryCount(arg_1_0.EverydayRewardShow or 0)
	Player:setHomeTaskCount(arg_1_0.MissionShow or 0)
	Player:setFirstRechargeCount(arg_1_0.FirstRechargeShow or 0)
	Player:setIsOpenDestiny(arg_1_0.IsOpenDestiny or 0)
	Player:setXMPushTime(arg_1_0.XMPushTime or 0)
	Player:setWorldBossTip(arg_1_0.IsWorldbossInActivity or 0)
	Player:setIsRichRankDisplay(arg_1_0.ConsumeRankShow or 0)
	Player:setIsJiFenRankDisplay(arg_1_0.ScoreRankShow or 0)
	Player:setDoubleExpTime(arg_1_0.HaveDoubleExpTime or 0)
	Player:setPowerRestoreTime(arg_1_0.ETime or 0)
	Player:setPower(arg_1_0.Energy or 0)
	Player:setTaskTenBattleRestoreTime(arg_1_0.MapBattleTenCDtime or 0)
	Player:setMysteryStoreAndStoreStatus(arg_1_0.Store, arg_1_0.MysteryStore)
	Player:setTransportState(arg_1_0.TransportState)
	Player:setFriendRequestCnt(arg_1_0.Friend or 0)
	Player:setLevelGiftStatus(arg_1_0.lgbs)
	Player:setGrowupStatus(arg_1_0.Growup)
	Player:setShowSuitProp(arg_1_0.IsShowSuitProp)
	Player:setGoldGodStatus(arg_1_0.FortuneKingsShow)
	Player:setBlackMarketStatus(arg_1_0.IVE)
end

function var_0_0.requestNotifyInfo(arg_2_0)
	local var_2_0 = string.format(ServerUrl.NotifyRequest, Player.userId)

	arg_2_0:startHttpRequest(var_2_0, false, nil, true)
end

function var_0_0.parseJsonValue(arg_3_0, arg_3_1)
	parseNotifyRequestJsonValue(arg_3_1)
end

return var_0_0
