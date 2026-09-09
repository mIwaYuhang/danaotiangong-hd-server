require("base.functions")

FriendRequest = NetworkRequest:new()
FriendRequest.timeoutOperate = TimeoutOperation.eRetry
FriendRequest.eFriendList = 1
FriendRequest.eRequestList = 2
FriendRequest.eRecommendList = 3
FriendRequest.eRequest = 4
FriendRequest.eConsent = 5
FriendRequest.eDelete = 6
FriendRequest.eRefuse = 7
FriendRequest.ePresentInfo = 8
FriendRequest.eSendPresent = 9
FriendRequest.eGetPresent = 10
FriendRequest.eGetBackBatch = 11

function FriendRequest.friendList(arg_1_0)
	local var_1_0 = string.format(ServerUrl.UserFriends, Player.userId)

	arg_1_0.state = FriendRequest.eFriendList

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function FriendRequest.requestFriend(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2 = arg_2_2 or ""

	if #arg_2_2 > 0 then
		arg_2_2 = stringBase64AndUrlEncode(arg_2_2)
	end

	local var_2_0 = string.format(ServerUrl.AddFriend, Player.userId, arg_2_1)

	arg_2_0.state = FriendRequest.eRequest
	arg_2_0.friendId = arg_2_1

	arg_2_0:startHttpRequest(var_2_0, true, {
		message = arg_2_2
	}, true)
end

function FriendRequest.sendFriend(arg_3_0, arg_3_1, arg_3_2)
	arg_3_2 = arg_3_2 or ""

	if #arg_3_2 > 0 then
		arg_3_2 = stringBase64AndUrlEncode(arg_3_2)
	end

	local var_3_0 = string.format(ServerUrl.ContactFriend, Player.userId, arg_3_1)

	arg_3_0.state = FriendRequest.eRequest

	arg_3_0:startHttpRequest(var_3_0, true, {
		message = arg_3_2
	}, true)
end

function FriendRequest.deleteFriend(arg_4_0, arg_4_1)
	local var_4_0 = string.format(ServerUrl.DeleteFriend, Player.userId, arg_4_1)

	arg_4_0.state = FriendRequest.eDelete
	arg_4_0.friendId = arg_4_1

	arg_4_0:startHttpRequest(var_4_0, false, nil, true)
end

function FriendRequest.requestList(arg_5_0)
	local var_5_0 = string.format(ServerUrl.RequestFriends, Player.userId)

	arg_5_0.state = FriendRequest.eRequestList

	arg_5_0:startHttpRequest(var_5_0, false, nil, true)
end

function FriendRequest.consentRequest(arg_6_0, arg_6_1)
	local var_6_0 = string.format(ServerUrl.ConsentFriend, Player.userId, arg_6_1)

	arg_6_0.state = FriendRequest.eConsent
	arg_6_0.friendId = arg_6_1

	arg_6_0:startHttpRequest(var_6_0, false, nil, true)
end

function FriendRequest.refuseRequest(arg_7_0, arg_7_1)
	local var_7_0 = string.format(ServerUrl.RefuseFriend, Player.userId, arg_7_1)

	arg_7_0.state = FriendRequest.eRefuse
	arg_7_0.friendId = arg_7_1

	arg_7_0:startHttpRequest(var_7_0, false, nil, true)
end

function FriendRequest.recommendList(arg_8_0, arg_8_1, arg_8_2)
	arg_8_1 = arg_8_1 or ""

	if #arg_8_1 > 0 then
		arg_8_1 = stringBase64AndUrlEncode(arg_8_1)
	end

	arg_8_2 = arg_8_2 and tostring(arg_8_2) or ""

	local var_8_0 = string.format(ServerUrl.RecommendFriends, Player.userId, arg_8_1, arg_8_2)

	arg_8_0.state = FriendRequest.eRecommendList

	arg_8_0:startHttpRequest(var_8_0, false, nil, true)
end

function FriendRequest.presentInfo(arg_9_0)
	local var_9_0 = string.format(ServerUrl.PresentInfo, Player.userId)

	arg_9_0.state = FriendRequest.ePresentInfo

	arg_9_0:startHttpRequest(var_9_0, false, nil, true)
end

function FriendRequest.sendPresent(arg_10_0, arg_10_1)
	local var_10_0 = string.format(ServerUrl.sendPresent, Player.userId, arg_10_1)

	arg_10_0.state = FriendRequest.eSendPresent
	arg_10_0.friendId = arg_10_1

	arg_10_0:startHttpRequest(var_10_0, false, nil, true)
end

function FriendRequest.getPresent(arg_11_0, arg_11_1)
	local var_11_0 = string.format(ServerUrl.getPresent, Player.userId, arg_11_1)

	arg_11_0.state = FriendRequest.eGetPresent
	arg_11_0.friendId = arg_11_1

	arg_11_0:startHttpRequest(var_11_0, false, nil, true)
end

function FriendRequest.getBackBatch(arg_12_0)
	local var_12_0 = string.format(ServerUrl.getBackBatch, Player.userId)

	arg_12_0.state = FriendRequest.eGetBackBatch

	arg_12_0:startHttpRequest(var_12_0, false, nil, true)
end

function FriendRequest.getResponseContent(arg_13_0)
	return arg_13_0.state, arg_13_0.restable
end

function FriendRequest.parseJsonValue(arg_14_0, arg_14_1)
	arg_14_0.restable = arg_14_1
end
