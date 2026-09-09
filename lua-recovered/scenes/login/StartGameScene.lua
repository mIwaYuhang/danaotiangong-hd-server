require("data.player")
require("network.ServerListRequest")
require("network.AccountRequest")
require("network.PlayerRequest")
require("scenes.login.AccountLoginScene")

local var_0_0 = require("scenes.home.AnnouncementScene")
local var_0_1 = class("StartGameScene", function()
	return display.newScene("StartGameScene")
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	local var_2_0 = display.newSprite("ui/account/account_009.jpg")

	var_2_0:setPosition(display.cx, display.cy)
	var_2_0:setScale(Adapter.AutoScaleY)
	arg_2_0:addChild(var_2_0)

	arg_2_0.isThirdLogin = arg_2_1 and arg_2_1.thirdLogin or false

	if EditionConfig.__LoginMode == "local" then
		arg_2_0.isThirdLogin = false
		-- Always exchange the current local ticket before requesting role data.
		-- Do not clear it here: account login returns through this constructor.
		arg_2_0.hasPlayerInfo = false
	elseif Player.userId and Player.serverInfo then
		arg_2_0.hasPlayerInfo = true
	else
		arg_2_0.hasPlayerInfo = false
	end
end

function var_0_1.chooseServerInit(arg_3_0, ...)
	local function var_3_0()
		local var_4_0 = arg_3_0.serverListRequest:getServerData()[1]

		if var_4_0 then
			Player:setServerInfo(var_4_0)
			arg_3_0.serverNameLabel:setString(var_4_0.ServerName)
		end
	end

	arg_3_0.serverListRequest = ServerListRequest:new(arg_3_0)

	arg_3_0.serverListRequest:setResponseNormalHandler(var_3_0)

	local function var_3_1()
		arg_3_0.thirdLoginRequest:requestThirdLogin(json.encode({
			sessionId = Player.thirdUserId
		}), EditionConfig.__PartnerID, Player.serverInfo.ServerID)
	end

	arg_3_0.accountRequest = AccountRequest:new(arg_3_0)

	arg_3_0.accountRequest:setResponseNormalHandler(var_3_1)

	local function var_3_2()
		LocalData:addLastServerName(Player.serverInfo.ServerID)
		arg_3_0.playerRequest:requestPlayerInfo(Player.userId)
	end

	arg_3_0.thirdLoginRequest = ThirdLoginRequest:new(arg_3_0)

	arg_3_0.thirdLoginRequest:setResponseNormalHandler(var_3_2)
	arg_3_0:chooseServerDisplay()
end

function var_0_1.delayCallSetButtonEnable(arg_7_0)
	arg_7_0.startButton:setEnabled(true)
end

function var_0_1.chooseServerDisplay(arg_8_0, ...)
	local function var_8_0(arg_9_0, arg_9_1)
		game.enterServerListScene()
	end

	local var_8_1 = ui.newControlButton({
		normalImage = "ui/account/account_012.png",
		position = Adapter.AutoPos(494, 209),
		clickAction = var_8_0,
		scaleX = Adapter.AutoScaleY,
		scaleY = Adapter.AutoScaleY
	})

	arg_8_0:addChild(var_8_1)

	arg_8_0.serverNameLabel = ui.newTTFLabel({
		text = "",
		x = Adapter.AutoPosY(240),
		y = Adapter.AutoPosY(23),
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(22),
		dimensions = Adapter.HCellSize(500, 40),
		align = ui.TEXT_ALIGN_CENTER,
		valign = ui.TEXT_VALIGN_CENTER,
		color = ccc3(255, 255, 255)
	})

	var_8_1:addChild(arg_8_0.serverNameLabel)

	if Player.serverInfo then
		arg_8_0.serverNameLabel:setString(Player.serverInfo.ServerName)
	else
		arg_8_0.serverListRequest:requestServerList(EditionConfig.__OnlineServerAddr)
	end

	local var_8_2 = display.newSprite("ui/account/account_014.png", Adapter.AutoPosY(401), Adapter.AutoPosY(25))

	var_8_2:setScale(Adapter.AutoScaleY)
	var_8_1:addChild(var_8_2)

	local var_8_3 = display.newSprite("uilocal/account/account_text_1.png", Adapter.AutoPosY(52), Adapter.AutoPosY(25))

	var_8_3:setScale(Adapter.AutoScaleY)
	var_8_1:addChild(var_8_3)

	local function var_8_4(arg_10_0, arg_10_1)
		game.enterAccountLoginScene()
	end

	if arg_8_0.isThirdLogin == false then
		local var_8_5 = ui.newControlButton({
			normalImage = "ui/account/account_012.png",
			position = Adapter.AutoPos(494, 139),
			clickAction = var_8_4,
			scaleX = Adapter.AutoScaleY,
			scaleY = Adapter.AutoScaleY
		})

		arg_8_0:addChild(var_8_5)

		arg_8_0.accountLabel = ui.newTTFLabel({
			text = string.lf("可不用账号立刻开始游戏"),
			x = Adapter.AutoPosY(233),
			y = Adapter.AutoPosY(23),
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(22),
			dimensions = Adapter.HCellSize(500, 40),
			align = ui.TEXT_ALIGN_CENTER,
			valign = ui.TEXT_VALIGN_CENTER,
			color = ccc3(255, 255, 255)
		})

		var_8_5:addChild(arg_8_0.accountLabel)

		local var_8_6 = display.newSprite("ui/account/account_014.png", Adapter.AutoPosY(401), Adapter.AutoPosY(25))

		var_8_6:setScale(Adapter.AutoScaleY)
		var_8_5:addChild(var_8_6)

		local var_8_7 = display.newSprite("uilocal/account/account_text_2.png", Adapter.AutoPosY(52), Adapter.AutoPosY(25))

		var_8_7:setScale(Adapter.AutoScaleY)
		var_8_5:addChild(var_8_7)

		if Player.account and Player.thirdUserId then
			arg_8_0.accountLabel:setString(Player.account)
		end
	end

	local function var_8_8(arg_11_0, arg_11_1)
		if not Player.serverInfo then
			ui.showMessageBox({
				text = string.lf("区服信息尚未加载，请稍后重试或选择区服。"),
				parent = arg_8_0
			})
			return
		end

		arg_8_0.startButton:setEnabled(false)

		local var_11_0 = CCArray:create()

		var_11_0:addObject(CCDelayTime:create(0.8))
		var_11_0:addObject(CCCallFunc:create(handler(arg_8_0, arg_8_0.delayCallSetButtonEnable)))
		arg_8_0:runAction(CCSequence:create(var_11_0))

		if Player.serverInfo.State == ServerStateType.eMaintain then
			ui.showMessageBox({
				text = string.lf("系统维护中，请耐心等待,:)"),
				action1 = function(arg_12_0, arg_12_1)
					game.enterServerListScene()
				end
			})
		else
			if arg_8_0.isThirdLogin == false then
				if Player.thirdUserId then
					arg_8_0.thirdLoginRequest:requestThirdLogin(json.encode({
						sessionId = Player.thirdUserId
					}), EditionConfig.__PartnerID, Player.serverInfo.ServerID)
				else
					arg_8_0.accountRequest:requestDefaultLogin()
				end
			else
				IPlatform:instance():login()
			end

			LocalData:saveLoginServerInfo()
		end
	end

	local function var_8_9(arg_13_0)
		if IPlatform:instance():getConfig("Channel") == "mengcheng" then
			local var_13_0 = json.decode(arg_13_0)
			local var_13_1 = json.decode(var_13_0.servers)

			for iter_13_0, iter_13_1 in ipairs(var_13_1) do
				echoInfo("code: %s | ServerID: %s", iter_13_1.code, Player.serverInfo.ServerID)

				if tonumber(iter_13_1.code) == Player.serverInfo.ServerID then
					echoInfo("proxy bef: %s", Player.serverInfo.ServerUrl)

					Player.serverInfo.ServerUrl = iter_13_1.host .. ":" .. iter_13_1.port

					LocalData:saveLoginServerInfo()
					echoInfo("proxy end: %s", Player.serverInfo.ServerUrl)

					var_13_0.servers = nil
					arg_13_0 = json.encode(var_13_0)

					break
				end
			end
		end

		arg_8_0.thirdLoginRequest:requestThirdLogin(arg_13_0, EditionConfig.__PartnerID, Player.serverInfo.ServerID)
	end

	if EditionConfig.__LoginMode ~= "local" then
		IPlatform:instance():AddLuaCallBack(Lua_CallBackType_LogOut, game.restartGameEntry)
		IPlatform:instance():AddLuaCallBack(Lua_CallBackType_Login, var_8_9)
	end

	arg_8_0.startButton = ui.newControlButton({
		normalImage = "ui/account/account_013.png",
		position = Adapter.AutoPos(503, 51),
		clickAction = var_8_8,
		scaleX = Adapter.AutoScaleY,
		scaleY = Adapter.AutoScaleY
	})

	arg_8_0:addChild(arg_8_0.startButton)
end

function var_0_1.onEnter(arg_14_0)
	local function var_14_0()
		if Player:getTroMaxStep() < 26 then
			game.enterHomeScene()
		else
			game.enterAnnouncementScene()
		end

		local var_15_0 = Player.systemOpenControllers.IsShowAdvertisement

		if var_15_0 and var_15_0 > 0 then
			Platform.showAdmob()
		end
	end

	local function var_14_1(arg_16_0)
		local function var_16_0()
			game.enterNicknameScene()
		end

		local var_16_1 = IPlatform:instance():getConfig("Channel")

		if (var_16_1 == "zsy_ysb" or var_16_1 == "ZSY_VN") and arg_16_0 == NetworkState.NoNickName then
			game.enterNicknameScene()
		elseif var_16_1 ~= "zsy_ysb" and arg_16_0 == NetworkState.NoNickName then
			game.enterFilmScene({
				callback = var_16_0
			})
		end
	end

	arg_14_0.playerRequest = PlayerRequest:new(arg_14_0)

	arg_14_0.playerRequest:setResponseNormalHandler(var_14_0)
	arg_14_0.playerRequest:setResponseExceptionHandler(var_14_1)

	if arg_14_0.hasPlayerInfo and arg_14_0.isThirdLogin == false then
		arg_14_0.playerRequest:requestPlayerInfo(Player.userId)
	else
		arg_14_0:chooseServerInit()
	end
end

return var_0_1
