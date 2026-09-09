require("network.PlayerRequest")

local var_0_0 = class("CheckUpdateScene", function()
	return display.newScene("CheckUpdateScene")
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	local var_2_0 = display.newSprite("ui/account/account_009.jpg")

	var_2_0:setPosition(display.cx, display.cy)
	var_2_0:setScale(Adapter.AutoScaleY)
	arg_2_0:addChild(var_2_0)

	arg_2_0.bgSprite = arg_2_0
	arg_2_0.params = arg_2_1.data

	arg_2_0:updateInit()
end

function var_0_0.updateInit(arg_3_0)
	arg_3_0.fileTotalSize = 0
	arg_3_0.fileProgress = {}

	arg_3_0:createUpdateUI()
	arg_3_0:downloadFile(arg_3_0.params)
end

function var_0_0.createUpdateUI(arg_4_0)
	local var_4_0 = CCSprite:create("ui/common/bar_common_exp.png")

	var_4_0:setPosition(display.cx, 100)
	arg_4_0.bgSprite:addChild(var_4_0)
	var_4_0:setScale(2)

	local var_4_1 = CCSprite:create("ui/common/bar_common_hp.png")

	arg_4_0.expBar = CCProgressTimer:create(var_4_1)

	arg_4_0.expBar:setType(kCCProgressTimerTypeBar)
	arg_4_0.expBar:setMidpoint(CCPoint(0, 0))
	arg_4_0.expBar:setBarChangeRate(CCPoint(1, 0))
	arg_4_0.expBar:setPercentage(0)
	arg_4_0.expBar:setPosition(display.cx, 100)
	arg_4_0.bgSprite:addChild(arg_4_0.expBar)
	arg_4_0.expBar:setScale(2)

	arg_4_0.label_progress = CCLabelTTF:create("0%", _FONT_DEFAULT, Adapter.FontSize(35))

	arg_4_0.label_progress:setPosition(display.cx, 100)
	arg_4_0.bgSprite:addChild(arg_4_0.label_progress)

	local var_4_2 = display.newScale9Sprite("ui/common/common_064_2.png", display.cx, 200)

	var_4_2:setPreferredSize(CCSize(350, 60))
	arg_4_0.bgSprite:addChild(var_4_2)

	arg_4_0.label_state = CCLabelTTF:create("", _FONT_DEFAULT, Adapter.FontSize(35))

	arg_4_0.label_state:setAnchorPoint(ccp(1, 0.5))
	arg_4_0.label_state:setPosition(173, 33)
	arg_4_0.label_state:setColor(ccc3(255, 255, 255))
	var_4_2:addChild(arg_4_0.label_state)

	arg_4_0.lable_speed = CCLabelTTF:create("0Bps", _FONT_DEFAULT, Adapter.FontSize(35))

	arg_4_0.lable_speed:setAnchorPoint(ccp(0, 0.5))
	arg_4_0.lable_speed:setPosition(173, 33)
	var_4_2:addChild(arg_4_0.lable_speed)
end

function var_0_0.downloadFile(arg_5_0, arg_5_1)
	arg_5_0.updater = ResourceUpdater:new(EditionConfig.__ResourceUpdaterDir)

	table.foreach(arg_5_1, function(arg_6_0, arg_6_1)
		if tonumber(EditionConfig.__Version) >= 115 then
			arg_5_0.updater:addFile(arg_6_1.Url, arg_6_1.MD5, arg_6_1.ResourceVersionID)
		else
			arg_5_0.updater:addFile(arg_6_1.Url, arg_6_1.ResourceVersionID)
		end

		arg_5_0.fileTotalSize = arg_5_0.fileTotalSize + arg_6_1.Size
		arg_5_0.fileProgress[arg_6_0] = 0
	end)

	local function var_5_0(arg_7_0, arg_7_1)
		if arg_7_0 == "uncompress" then
			arg_5_0:onUncompress(arg_7_0, arg_7_1)
		elseif arg_7_0 == "finishDownload" then
			arg_5_0:onDownloadFinish()
		elseif arg_7_0 == "error" then
			arg_5_0:onError(arg_7_0, arg_7_1)
		elseif arg_7_0 == "progress" then
			arg_5_0:onDownload(arg_7_0, arg_7_1)
		elseif arg_7_0 == "success" then
			arg_5_0:onSuccess()
		elseif arg_7_0 == "finishCheckSum" then
			arg_5_0:onCheckSum()
		end
	end

	arg_5_0.updater:registerScriptHandler(var_5_0)

	if arg_5_0.updater.startUpdate then
		arg_5_0.updater:startUpdate()
	else
		arg_5_0.updater:update()
	end

	arg_5_0:schedule(handler(arg_5_0, arg_5_0.onSpeed), 1)
end

function var_0_0.getCurrentFileSize(arg_8_0)
	local var_8_0 = 0

	table.foreach(arg_8_0.fileProgress, function(arg_9_0, arg_9_1)
		var_8_0 = var_8_0 + arg_9_1
	end)

	return var_8_0
end

function var_0_0.onSpeed(arg_10_0)
	if arg_10_0.lastFileSize == nil then
		arg_10_0.lastFileSize = 0
	end

	local var_10_0 = arg_10_0:getCurrentFileSize()
	local var_10_1 = (var_10_0 - arg_10_0.lastFileSize) / 1

	arg_10_0.lastFileSize = var_10_0

	if var_10_1 / 1048576 >= 1 then
		local var_10_2 = var_10_1 / 1048576

		arg_10_0.lable_speed:setString(var_10_2 - var_10_2 % 0.01 .. "Mps")
	elseif var_10_1 / 1024 >= 1 then
		local var_10_3 = var_10_1 / 1024

		arg_10_0.lable_speed:setString(var_10_3 - var_10_3 % 0.01 .. "Kps")
	else
		arg_10_0.lable_speed:setString(var_10_1 - var_10_1 % 0.01 .. "Bps")
	end
end

function var_0_0.onDownload(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.label_state:setString(string.lf("下载中..."))

	arg_11_0.fileProgress[arg_11_2.tag] = arg_11_2.downBytes + arg_11_2.startPos

	local var_11_0 = arg_11_0:getCurrentFileSize()

	arg_11_0.expBar:setPercentage(var_11_0 / arg_11_0.fileTotalSize * 100)

	local var_11_1 = math.floor(var_11_0 / arg_11_0.fileTotalSize * 100)

	arg_11_0.label_progress:setString(var_11_1 .. "%")
end

function var_0_0.onSuccess(arg_12_0)
	arg_12_0.label_state:setString(string.lf("更新完成！"))
	arg_12_0:unscheduleUpdate()
	arg_12_0.lable_speed:setVisible(false)

	arg_12_0.updater = nil

	local var_12_0 = string.lf("上仙！您的更新完成了,请重新登录！")

	if IPlatform:instance():getConfig("Channel") == "91" or IPlatform:instance():getConfig("Channel") == "duoku" then
		var_12_0 = string.lf("上仙！您的更新完成了,请重新启动游戏！")
	end

	ui.showMessageBox({
		text = var_12_0,
		action1 = function(...)
			if device.platform == "android" and tonumber(EditionConfig.__Version) >= 114 then
				IPlatform:instance():cpInfo("restartGame", "{}")
			else
				Platform.exitGame()
			end
		end
	})
end

function var_0_0.onUncompress(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.label_state:setString(string.lf("解压version(%s)...", tostring(arg_14_2)))
	NetworkMediator:setRequestResVersion(arg_14_2)
	LocalData:saveResourceID(arg_14_2)
end

function var_0_0.onDownloadFinish(arg_15_0)
	arg_15_0.label_state:setString(string.lf("下载完成，解压中..."))
	arg_15_0.expBar:setPercentage(100)
	arg_15_0.label_progress:setString("100%")
end

function var_0_0.onCheckSum(arg_16_0)
	arg_16_0.label_state:setString("校验文件完成！")
end

function var_0_0.onError(arg_17_0, arg_17_1, arg_17_2)
	local function var_17_0(arg_18_0, arg_18_1)
		if arg_17_2.target and arg_18_1 ~= false then
			arg_17_0.updater:removeCache(arg_17_2.target)
		end

		arg_17_0.label_state:setString(arg_18_0)

		if tonumber(EditionConfig.__Version) >= 115 then
			ui.showMessageBox({
				text = arg_18_0,
				title1 = string.lf("重新下载"),
				action1 = function(...)
					game.enterCheckUpdateScene({
						data = arg_17_0.params
					})
				end,
				title2 = string.lf("清理缓存"),
				action2 = function()
					luaDeleteDirExcept(EditionConfig.__ResourceUpdaterDir, EditionConfig.__UserData)
					LocalData:saveResourceID(0)
					NetworkMediator:setRequestResVersion(0)
					game.restartGameEntry(false)
				end
			})
		else
			ui.showMessageBox({
				text = arg_18_0,
				title1 = string.lf("重新下载"),
				action1 = function(...)
					game.enterCheckUpdateScene({
						data = arg_17_0.params
					})
				end
			})
		end
	end

	if arg_17_2.type == "errorNetwork" then
		if arg_17_2.errorID == 33 then
			arg_17_0.updater:removeCache(arg_17_2.target)
		end

		var_17_0(string.lf("上仙您的更新失败了，请检查网络状况再重试，T.T"), false)
	elseif arg_17_2.type == "errorCreateFile" then
		var_17_0(string.lf("创建文件失败，存储空间可能不足!"))
	elseif arg_17_2.type == "errorUncompress" then
		var_17_0(string.lf("解压失败!"))
	elseif arg_17_2.type == "errorUnknown" then
		var_17_0(string.lf("未知错误!"))
	elseif arg_17_2.type == "errorCheckSum" then
		var_17_0(string.lf("校验文件失败!"))
	elseif arg_17_2.type == "errorZIPOpen" then
		var_17_0(string.lf("打开压缩包失败!"))
	elseif arg_17_2.type == "errorZIPInfo" then
		var_17_0(string.lf("读取压缩包文件信息失败!"))
	elseif arg_17_2.type == "errorFileDir" then
		var_17_0(string.lf("读取解压包中的文件失败!"))
	elseif arg_17_2.type == "errorFileCreate" then
		var_17_0(string.lf("解压中创建本地文件失败，存储空间可能不足!"))
	end
end

return var_0_0
