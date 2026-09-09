require("base.request")

LuckyDiskInfoRequest = NetworkRequest:new()
LuckyDiskInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function LuckyDiskInfoRequest.request(arg_1_0)
	local var_1_0 = string.format(ServerUrl.LuckyDiskInfo, Player.userId)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function LuckyDiskInfoRequest.parseJsonValue(arg_2_0, arg_2_1)
	arg_2_0.restable = arg_2_1
end

LuckyDiskSeekRequest = NetworkRequest:new()

function LuckyDiskSeekRequest.request(arg_3_0, arg_3_1)
	local var_3_0 = string.format(ServerUrl.LuckyDiskSeek, Player.userId, arg_3_1 ~= nil and tostring(arg_3_1) or 0)

	return arg_3_0:startHttpRequestWithParams({
		manualGlobal = true,
		url = var_3_0
	})
end

function LuckyDiskSeekRequest.parseJsonValue(arg_4_0, arg_4_1)
	arg_4_0.restable = arg_4_1
end

LuckyDiskRefreshRequest = NetworkRequest:new()

function LuckyDiskRefreshRequest.request(arg_5_0)
	local var_5_0 = string.format(ServerUrl.LuckyDiskRefresh, Player.userId)

	arg_5_0:startHttpRequest(var_5_0, false, nil, true)
end

function LuckyDiskRefreshRequest.parseJsonValue(arg_6_0, arg_6_1)
	arg_6_0.restable = arg_6_1
end

LuckydiskRewardRequest = NetworkRequest:new()

function LuckydiskRewardRequest.request(arg_7_0, arg_7_1)
	local var_7_0 = string.format(ServerUrl.LuckydiskReward, Player.userId, tostring(arg_7_1))

	arg_7_0:startHttpRequest(var_7_0, false, nil, true)
end

function LuckydiskRewardRequest.parseJsonValue(arg_8_0, arg_8_1)
	arg_8_0.restable = arg_8_1
end

LingZhiRequest = NetworkRequest:new()
LingZhiRequest.eList = 1
LingZhiRequest.eRefresh = 2
LingZhiRequest.eCall = 3
LingZhiRequest.eUse = 4

function LingZhiRequest.requestLingZhiList(arg_9_0)
	local var_9_0 = string.format(ServerUrl.LingZhiList, Player.userId)

	arg_9_0.timeoutOperate = TimeoutOperation.eRetry
	arg_9_0.state = LingZhiRequest.eList

	arg_9_0:startHttpRequest(var_9_0, false, nil, true)
end

function LingZhiRequest.requestRefreshLingZhi(arg_10_0)
	local var_10_0 = string.format(ServerUrl.RefreshLingZhi, Player.userId)

	arg_10_0.timeoutOperate = TimeoutOperation.eExcep
	arg_10_0.state = LingZhiRequest.eRefresh

	arg_10_0:startHttpRequest(var_10_0, false, nil, true)
end

function LingZhiRequest.requestCallLingZhi(arg_11_0, arg_11_1)
	local var_11_0 = string.format(ServerUrl.CallLingZhi, Player.userId, arg_11_1)

	arg_11_0.timeoutOperate = TimeoutOperation.eExcep
	arg_11_0.state = LingZhiRequest.eCall

	arg_11_0:startHttpRequest(var_11_0, false, nil, true)
end

function LingZhiRequest.requestUseLingZhi(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = string.format(ServerUrl.UseLingZhi, Player.userId, arg_12_1, arg_12_2)

	arg_12_0.timeoutOperate = TimeoutOperation.eExcep
	arg_12_0.state = LingZhiRequest.eUse

	arg_12_0:startHttpRequest(var_12_0, false, nil, true)
end

function LingZhiRequest.getResponseContent(arg_13_0)
	return arg_13_0.state, arg_13_0.restable
end

function LingZhiRequest.parseJsonValue(arg_14_0, arg_14_1)
	arg_14_0.restable = arg_14_1
end

SevenLoginRewardRequest = NetworkRequest:new()
SevenLoginRewardRequest.eList = 1
SevenLoginRewardRequest.eReward = 2
SevenLoginRewardRequest.isNoticeReward = true

function SevenLoginRewardRequest.requestList(arg_15_0)
	local var_15_0 = string.format(ServerUrl.LoginRewardList, Player.userId)

	arg_15_0.timeoutOperate = TimeoutOperation.eRetry
	arg_15_0.state = SevenLoginRewardRequest.eList

	arg_15_0:startHttpRequest(var_15_0, false, nil, true)
end

function SevenLoginRewardRequest.requestReward(arg_16_0, arg_16_1)
	local var_16_0 = string.format(ServerUrl.GetSDHReward, Player.userId, arg_16_1)

	arg_16_0.timeoutOperate = TimeoutOperation.eExcep
	arg_16_0.state = SevenLoginRewardRequest.eReward

	arg_16_0:startHttpRequest(var_16_0, false, nil, true)
end

function SevenLoginRewardRequest.getResponseContent(arg_17_0)
	return arg_17_0.state, arg_17_0.restable
end

function SevenLoginRewardRequest.parseJsonValue(arg_18_0, arg_18_1)
	arg_18_0.restable = arg_18_1
end

SignMonthRequest = NetworkRequest:new()
SignMonthRequest.isNoticeReward = true
SignMonthRequest.eInfo = 1
SignMonthRequest.eSign = 2

function SignMonthRequest.requestInfo(arg_19_0)
	local var_19_0 = string.format(ServerUrl.GetSignInfo, Player.userId)

	arg_19_0.timeoutOperate = TimeoutOperation.eRetry
	arg_19_0.state = SignMonthRequest.eInfo

	arg_19_0:startHttpRequest(var_19_0, false, nil, true)
end

function SignMonthRequest.requestSign(arg_20_0)
	local var_20_0 = string.format(ServerUrl.SignToday, Player.userId)

	arg_20_0.timeoutOperate = TimeoutOperation.eExcep
	arg_20_0.state = SignMonthRequest.eSign

	arg_20_0:startHttpRequest(var_20_0, false, nil, true)
end

function SignMonthRequest.getResponseContent(arg_21_0)
	return arg_21_0.state, arg_21_0.restable
end

function SignMonthRequest.parseJsonValue(arg_22_0, arg_22_1)
	arg_22_0.restable = arg_22_1
end

FlowersInfoRequest = NetworkRequest:new()
FlowersInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function FlowersInfoRequest.request(arg_23_0)
	local var_23_0 = string.format(ServerUrl.FlowersInfo, Player.userId)

	arg_23_0:startHttpRequest(var_23_0, false, nil, true)
end

function FlowersInfoRequest.parseJsonValue(arg_24_0, arg_24_1)
	arg_24_0.restable = arg_24_1
end

FlowersUseRequest = NetworkRequest:new()

function FlowersUseRequest.request(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = string.format(ServerUrl.FlowersUse, Player.userId, tostring(arg_25_1), tostring(arg_25_2), tostring(arg_25_3))

	arg_25_0:startHttpRequest(var_25_0, false, nil, true)
end

function FlowersUseRequest.parseJsonValue(arg_26_0, arg_26_1)
	arg_26_0.restable = arg_26_1
end

ActivityGiftRequest = NetworkRequest:new()
ActivityGiftRequest.timeoutOperate = TimeoutOperation.eRetry

function ActivityGiftRequest.request(arg_27_0, arg_27_1)
	local var_27_0 = string.format(ServerUrl.ActivityGiftCode, Player.userId, arg_27_1)

	arg_27_0:startHttpRequest(var_27_0, false, nil, true)
end

function ActivityGiftRequest.parseJsonValue(arg_28_0, arg_28_1)
	arg_28_0.restable = arg_28_1
end

function ActivityGiftRequest.getGift(arg_29_0, arg_29_1)
	return arg_29_0.restable.Reward
end

ActivityLevelupGiftRequest = NetworkRequest:new()
ActivityLevelupGiftRequest.timeoutOperate = TimeoutOperation.eRetry

function ActivityLevelupGiftRequest.request(arg_30_0)
	local var_30_0 = string.format(ServerUrl.LevelupGiftBagInfo, Player.userId)

	arg_30_0:startHttpRequest(var_30_0, false, nil, true)
end

function ActivityLevelupGiftRequest.parseJsonValue(arg_31_0, arg_31_1)
	arg_31_0.restable = arg_31_1
end

function ActivityLevelupGiftRequest.getGiftTable(arg_32_0)
	return arg_32_0.restable
end

ActivityGetLevelupGiftRequest = NetworkRequest:new()
ActivityGetLevelupGiftRequest.timeoutOperate = TimeoutOperation.eRetry

function ActivityGetLevelupGiftRequest.request(arg_33_0, arg_33_1)
	arg_33_0.requestLevel = arg_33_1

	local var_33_0 = string.format(ServerUrl.GetLevelupGiftBag, Player.userId, tostring(arg_33_1))

	arg_33_0:startHttpRequest(var_33_0, false, nil, true)
end

function ActivityGetLevelupGiftRequest.parseJsonValue(arg_34_0, arg_34_1)
	arg_34_0.restable = arg_34_1
end

function ActivityGetLevelupGiftRequest.getRequestLevel(arg_35_0)
	return arg_35_0.requestLevel
end

ActivityGrowUpRewardInfoRequest = NetworkRequest:new()
ActivityGrowUpRewardInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function ActivityGrowUpRewardInfoRequest.request(arg_36_0)
	local var_36_0 = string.format(ServerUrl.GrowUpInfo, Player.userId)

	arg_36_0:startHttpRequest(var_36_0, false, nil, true)
end

function ActivityGrowUpRewardInfoRequest.parseJsonValue(arg_37_0, arg_37_1)
	arg_37_0.restable = arg_37_1
end

function ActivityGrowUpRewardInfoRequest.getGiftTable(arg_38_0)
	return arg_38_0.restable
end

ActivityGetGrowUpRewardBagRequest = NetworkRequest:new()
ActivityGetGrowUpRewardBagRequest.timeoutOperate = TimeoutOperation.eRetry

function ActivityGetGrowUpRewardBagRequest.request(arg_39_0, arg_39_1)
	arg_39_0.requestLevel = arg_39_1

	local var_39_0 = string.format(ServerUrl.GetGrowUpReward, Player.userId, tostring(arg_39_1))

	arg_39_0:startHttpRequest(var_39_0, false, nil, true)
end

function ActivityGetGrowUpRewardBagRequest.parseJsonValue(arg_40_0, arg_40_1)
	arg_40_0.restable = arg_40_1
end

function ActivityGetGrowUpRewardBagRequest.getRequestLevel(arg_41_0)
	return arg_41_0.requestLevel
end

ActivityBuyGrowUpPlanRequest = NetworkRequest:new()

function ActivityBuyGrowUpPlanRequest.request(arg_42_0)
	local var_42_0 = string.format(ServerUrl.BuyGrowUpPlan, Player.userId)

	arg_42_0:startHttpRequest(var_42_0, false, nil, true)
end

function ActivityBuyGrowUpPlanRequest.parseJsonValue(arg_43_0, arg_43_1)
	arg_43_0.restable = arg_43_1
end

ActivityGoldGodGetInfoRequest = NetworkRequest:new()
ActivityGoldGodGetInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function ActivityGoldGodGetInfoRequest.request(arg_44_0)
	local var_44_0 = string.format(ServerUrl.GetGoldGodInfo, Player.userId)

	arg_44_0:startHttpRequest(var_44_0, false, nil, true)
end

function ActivityGoldGodGetInfoRequest.parseJsonValue(arg_45_0, arg_45_1)
	arg_45_0.restable = arg_45_1
end

ActivityGoldGodGetRewardRequest = NetworkRequest:new()
ActivityGoldGodGetRewardRequest.timeoutOperate = TimeoutOperation.eRetry

function ActivityGoldGodGetRewardRequest.request(arg_46_0, arg_46_1)
	local var_46_0 = string.format(ServerUrl.GetGoldGodReward, Player.userId, arg_46_1)

	arg_46_0:startHttpRequest(var_46_0, false, nil, true)
end

function ActivityGoldGodGetRewardRequest.parseJsonValue(arg_47_0, arg_47_1)
	arg_47_0.restable = arg_47_1
end

ActivityWorkShopListRequest = NetworkRequest:new()
ActivityWorkShopListRequest.timeoutOperate = TimeoutOperation.eRetry

function ActivityWorkShopListRequest.request(arg_48_0, arg_48_1)
	local var_48_0 = string.format(ServerUrl.GetWorkShopInfo, Player.userId, arg_48_1)

	arg_48_0:startHttpRequest(var_48_0, false, nil, true)
end

function ActivityWorkShopListRequest.parseJsonValue(arg_49_0, arg_49_1)
	arg_49_0.restable = arg_49_1
end

ActivityWorkShopExchangeRequest = NetworkRequest:new()
ActivityWorkShopExchangeRequest.timeoutOperate = TimeoutOperation.eRetry

function ActivityWorkShopExchangeRequest.request(arg_50_0, arg_50_1)
	local var_50_0 = string.format(ServerUrl.WorkShopExchange, Player.userId, arg_50_1)

	arg_50_0:startHttpRequest(var_50_0, false, nil, true)
end

function ActivityWorkShopExchangeRequest.parseJsonValue(arg_51_0, arg_51_1)
	arg_51_0.restable = arg_51_1
end

SocialShareComplatedRequest = NetworkRequest:new()
SocialShareComplatedRequest.timeoutOperate = TimeoutOperation.eRetry
SocialShareComplatedRequest.isNoticeReward = true

function SocialShareComplatedRequest.request(arg_52_0)
	local var_52_0 = string.format(ServerUrl.SocialShareComplated, Player.userId)

	arg_52_0:startHttpRequest(var_52_0, false, nil, true)
end

function SocialShareComplatedRequest.parseJsonValue(arg_53_0, arg_53_1)
	arg_53_0.restable = arg_53_1
end

function SocialShareComplatedRequest.getRequestReward(arg_54_0)
	return arg_54_0.restable
end

ActivityFriendPromoter = NetworkRequest:new()
ActivityFriendPromoter.timeoutOperate = TimeoutOperation.eRetry

function ActivityFriendPromoter.request(arg_55_0, arg_55_1)
	local var_55_0 = string.format(ServerUrl.FriendPromoter, Player.userId, arg_55_1)

	arg_55_0:startHttpRequest(var_55_0, false, nil, true)
end

function ActivityFriendPromoter.parseJsonValue(arg_56_0, arg_56_1)
	arg_56_0.restable = arg_56_1
end

ActivityPromoteReward = NetworkRequest:new()
ActivityPromoteReward.timeoutOperate = TimeoutOperation.eRetry

function ActivityPromoteReward.request(arg_57_0)
	arg_57_0:startHttpRequest(string.format(ServerUrl.PromoteReward, Player.userId), false, nil, true)
end

function ActivityPromoteReward.parseJsonValue(arg_58_0, arg_58_1)
	arg_58_0.restable = arg_58_1
end

ActivityGetPromoteReward = NetworkRequest:new()
ActivityGetPromoteReward.timeoutOperate = TimeoutOperation.eRetry

function ActivityGetPromoteReward.request(arg_59_0, arg_59_1)
	local var_59_0 = string.format(ServerUrl.GetPromoterReward, Player.userId, arg_59_1)

	arg_59_0:startHttpRequest(var_59_0, false, nil, true)
end

function ActivityGetPromoteReward.parseJsonValue(arg_60_0, arg_60_1)
	arg_60_0.restable = arg_60_1
end

ActivityMonthInfoRequest = NetworkRequest:new()
ActivityMonthInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function ActivityMonthInfoRequest.request(arg_61_0)
	local var_61_0 = string.format(ServerUrl.GetMonthInfo, Player.userId)

	arg_61_0:startHttpRequest(var_61_0, false, nil, true)
end

function ActivityMonthInfoRequest.parseJsonValue(arg_62_0, arg_62_1)
	arg_62_0.restable = arg_62_1
end

ActivityMonthRewardRequest = NetworkRequest:new()
ActivityMonthRewardRequest.timeoutOperate = TimeoutOperation.eRetry

function ActivityMonthRewardRequest.request(arg_63_0)
	local var_63_0 = string.format(ServerUrl.GetMonthReward, Player.userId)

	arg_63_0:startHttpRequest(var_63_0, false, nil, true)
end

function ActivityMonthRewardRequest.parseJsonValue(arg_64_0, arg_64_1)
	arg_64_0.restable = arg_64_1
end

ActivityWeekRewardRequest = NetworkRequest:new()
ActivityWeekRewardRequest.timeoutOperate = TimeoutOperation.eRetry

function ActivityWeekRewardRequest.request(arg_65_0)
	local var_65_0 = string.format(ServerUrl.GetWeekReward, Player.userId)

	arg_65_0:startHttpRequest(var_65_0, false, nil, true)
end

function ActivityWeekRewardRequest.parseJsonValue(arg_66_0, arg_66_1)
	arg_66_0.restable = arg_66_1
end

ActivityChangeIngotRequest = NetworkRequest:new()
ActivityChangeIngotRequest.timeoutOperate = TimeoutOperation.eRetry

function ActivityChangeIngotRequest.request(arg_67_0, arg_67_1)
	local var_67_0 = string.format(ServerUrl.VolumeExchangeGold, Player.userId, arg_67_1)

	arg_67_0:startHttpRequest(var_67_0, false, nil, true)
end

function ActivityChangeIngotRequest.parseJsonValue(arg_68_0, arg_68_1)
	arg_68_0.restable = arg_68_1
end
