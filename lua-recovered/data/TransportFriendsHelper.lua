TransportFriendsHelper = {
	_transportFriendsListDate = 0,
	_transportRobFriendsListDate = 0
}

function TransportFriendsHelper.getTransportFriends(arg_1_0, arg_1_1)
	arg_1_0._transportFriendsListCallback = arg_1_1

	if arg_1_0._transportFriendsList ~= nil then
		arg_1_0._transportFriendsListCallback(arg_1_0._transportFriendsList)
	else
		arg_1_0:requestFriendsList(false)
	end
end

function TransportFriendsHelper.getTransportRobFriends(arg_2_0, arg_2_1)
	arg_2_0._transportRobFriendsListCallback = arg_2_1

	if arg_2_0._transportRobFriendsList ~= nil then
		arg_2_0._transportRobFriendsListCallback(arg_2_0._transportRobFriendsList)
	else
		arg_2_0:requestFriendsList(true)
	end
end

function TransportFriendsHelper.createNetworkRequest(arg_3_0)
	if arg_3_0.transportFriendsRequist == nil then
		print("TransportFriendsHelper:transportFriendsRequist")

		local function var_3_0()
			print("responseTransportFriendsSuccess")

			arg_3_0._transportFriendsList = arg_3_0.transportFriendsRequist:getTransportFriends()

			arg_3_0._transportFriendsListCallback(arg_3_0._transportFriendsList)

			arg_3_0._transportFriendsList = nil
		end

		local function var_3_1(arg_5_0)
			return
		end

		arg_3_0.transportFriendsRequist = TransportFriendsRequest:new()

		arg_3_0.transportFriendsRequist:setResponseNormalHandler(var_3_0)
		arg_3_0.transportFriendsRequist:setResponseExceptionHandler(var_3_1)
	end

	if arg_3_0.transportRobFriendsRequist == nil then
		print("TransportFriendsHelper:transportRobFriendsRequist")

		local function var_3_2()
			print("responseRobFriendsSuccess")

			arg_3_0._transportRobFriendsList = arg_3_0.transportRobFriendsRequist:getTransportRobFriends()

			arg_3_0._transportRobFriendsListCallback(arg_3_0._transportRobFriendsList)

			arg_3_0._transportRobFriendsList = nil
		end

		local function var_3_3(arg_7_0)
			return
		end

		arg_3_0.transportRobFriendsRequist = TransportRobFriendsRequest:new()

		arg_3_0.transportRobFriendsRequist:setResponseNormalHandler(var_3_2)
		arg_3_0.transportRobFriendsRequist:setResponseExceptionHandler(var_3_3)
	end
end

function TransportFriendsHelper.requestFriendsList(arg_8_0, arg_8_1)
	arg_8_0:createNetworkRequest()

	if arg_8_1 == true then
		arg_8_0.transportRobFriendsRequist:request()
	else
		arg_8_0.transportFriendsRequist:request()
	end
end

function TransportFriendsHelper.clear(arg_9_0)
	arg_9_0._transportFriendsList = nil
	arg_9_0._transportRobFriendsList = nil
end
