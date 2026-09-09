MailRequest = NetworkRequest:new()
MailRequest.timeoutOperate = TimeoutOperation.eRetry

function MailRequest.requestMailList(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = string.format(ServerUrl.GetMailList, arg_1_1, arg_1_2, arg_1_3)

	arg_1_0:startHttpRequest(var_1_0, false, nil, true)
end

function MailRequest.parseJsonValue(arg_2_0, arg_2_1)
	print("MailRequest:parseJsonValue")

	arg_2_0.mailData = arg_2_1
end

function MailRequest.getMailData(arg_3_0)
	return arg_3_0.mailData
end

GetMailInfoRequest = NetworkRequest:new()
GetMailInfoRequest.timeoutOperate = TimeoutOperation.eRetry

function GetMailInfoRequest.requestMailInfo(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = string.format(ServerUrl.GetMailInfo, arg_4_1, arg_4_2)

	arg_4_0:startHttpRequest(var_4_0, false, nil, true)
end

function GetMailInfoRequest.parseJsonValue(arg_5_0, arg_5_1)
	print("GetMailInfoRequest:parseJsonValue")

	arg_5_0.mailInfoData = arg_5_1
end

function GetMailInfoRequest.getMailInfoData(arg_6_0)
	return arg_6_0.mailInfoData
end

DeleteMailRequest = NetworkRequest:new()
DeleteMailRequest.timeoutOperate = TimeoutOperation.eRetry

function DeleteMailRequest.requestDeleteMail(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = string.format(ServerUrl.DeleteMail, arg_7_1, arg_7_2)

	arg_7_0:startHttpRequest(var_7_0, false, nil, true)
end

function DeleteMailRequest.parseJsonValue(arg_8_0, arg_8_1)
	return
end

DeleteAllMailRequest = NetworkRequest:new()
DeleteAllMailRequest.timeoutOperate = TimeoutOperation.eRetry

function DeleteAllMailRequest.requestDeleteAllMail(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = ""

	if arg_9_3 == true then
		var_9_0 = string.format(ServerUrl.DeleteAllMail, arg_9_1, arg_9_2)
	else
		var_9_0 = string.format(ServerUrl.DeleteAllReadMail, arg_9_1, arg_9_2)
	end

	arg_9_0:startHttpRequest(var_9_0, false, nil, true)
end

function DeleteAllMailRequest.parseJsonValue(arg_10_0, arg_10_1)
	return
end

SendMailRequest = NetworkRequest:new()
SendMailRequest.timeoutOperate = TimeoutOperation.eRetry

function SendMailRequest.sendMailToPlayer(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = stringBase64AndUrlEncode(arg_11_3)
	local var_11_1 = string.format(ServerUrl.SendMail, arg_11_1, arg_11_2)

	arg_11_0:startHttpRequest(var_11_1, true, {
		mailContent = var_11_0
	}, true)
end

function SendMailRequest.parseJsonValue(arg_12_0, arg_12_1)
	return
end

GetAnnouncementRequest = NetworkRequest:new()
GetAnnouncementRequest.timeoutOperate = TimeoutOperation.eRetry

function GetAnnouncementRequest.requestMailList(arg_13_0, arg_13_1)
	local var_13_0 = string.format(ServerUrl.GetAnnouncement, arg_13_1)

	arg_13_0:startHttpRequest(var_13_0, false, nil, true)
end

function GetAnnouncementRequest.parseJsonValue(arg_14_0, arg_14_1)
	print("GetAnnouncementRequest:parseJsonValue")

	arg_14_0.announcementData = arg_14_1
end

function GetAnnouncementRequest.getMailData(arg_15_0)
	return arg_15_0.announcementData
end

GetPlayerAccessoryRequest = NetworkRequest:new()

function GetPlayerAccessoryRequest.requestMailAccessory(arg_16_0, arg_16_1)
	local var_16_0 = string.format(ServerUrl.GetPlayerAccessory, Player.userId, arg_16_1)

	arg_16_0:startHttpRequest(var_16_0, false, nil, true)
end

function GetPlayerAccessoryRequest.parseJsonValue(arg_17_0, arg_17_1)
	return
end

AddBugRequest = NetworkRequest:new()
AddBugRequest.timeoutOperate = TimeoutOperation.eRetry

function AddBugRequest.requestAddBug(arg_18_0, arg_18_1)
	local var_18_0 = stringBase64AndUrlEncode(arg_18_1)
	local var_18_1 = string.format(ServerUrl.AddBug, Player.userId)

	arg_18_0:startHttpRequest(var_18_1, true, {
		BugConter = var_18_0
	}, true)
end

function AddBugRequest.parseJsonValue(arg_19_0, arg_19_1)
	return
end
