require("network.ServerListRequest")

local var_0_0 = class("ServerListScene", function()
	return display.newScene("ServerListScene")
end)

function var_0_0.ctor(arg_2_0)
	local function var_2_0()
		arg_2_0.serverData = arg_2_0.serverListRequest:getServerData()
		arg_2_0.showServerData = clone(arg_2_0.serverData)

		arg_2_0.serverTableView:reloadData()
		arg_2_0:createLastServerButtons()
	end

	arg_2_0.serverListRequest = ServerListRequest:new(arg_2_0)

	arg_2_0.serverListRequest:setResponseNormalHandler(var_2_0)
	arg_2_0.serverListRequest:requestServerList(EditionConfig.__OnlineServerAddr)

	arg_2_0.node = display.newNode()
end

function var_0_0.onEnter(arg_4_0)
	arg_4_0.bgSprite = display.newSprite("ui/server/server_010.png")

	arg_4_0.bgSprite:setPosition(display.cx, display.cy)
	arg_4_0.bgSprite:setScale(Adapter.MinScale)
	arg_4_0:addChild(arg_4_0.bgSprite)

	local function var_4_0(arg_5_0, arg_5_1)
		arg_4_0:backTouchChoosedServer()
	end

	local var_4_1 = ui.newControlButton({
		normalImage = "ui/server/server_009.png",
		position = ccp(115, 577),
		clickAction = var_4_0
	})

	arg_4_0.bgSprite:addChild(var_4_1)

	arg_4_0.lastServerList = LocalData:getLastServerList()
	arg_4_0.lastServerCount = arg_4_0.lastServerList and table.getn(arg_4_0.lastServerList) or 0
	arg_4_0.recommendServerList = {}

	arg_4_0:createRequestServerTableView()
end

function var_0_0.backTouchChoosedServer(arg_6_0, arg_6_1)
	dump(arg_6_1, "serverInfo")

	if arg_6_1 then
		Player:setServerInfo(arg_6_1)
	end

	game.enterStartGameScene({
		thirdLogin = IPlatform:instance():getConfig("ThridLogin") == "True"
	})
end

function var_0_0.createLastServerButtons(arg_7_0)
	local function var_7_0(arg_8_0, arg_8_1)
		arg_7_0:backTouchChoosedServer(arg_7_0.serverData[arg_8_1.tag])
	end

	local var_7_1 = {}
	local var_7_2 = {}
	local var_7_3

	if arg_7_0.lastServerCount > 0 then
		local var_7_4 = {
			"ui/server/server_002.png",
			"ui/server/server_003.png"
		}
		local var_7_5 = {
			"ui/server/server_005.png",
			"ui/server/server_006.png"
		}

		for iter_7_0 = 1, arg_7_0.lastServerCount do
			local var_7_6 = 1

			for iter_7_1, iter_7_2 in ipairs(arg_7_0.serverData) do
				if iter_7_2.ServerID == arg_7_0.lastServerList[iter_7_0] then
					var_7_6 = iter_7_1

					break
				end
			end

			local var_7_7 = var_7_5[iter_7_0]

			if arg_7_0.serverData[var_7_6].State == ServerStateType.eMaintain then
				var_7_7 = "ui/server/server_000.png"
			end

			local var_7_8 = ui.newControlButton({
				normalImage = var_7_7,
				position = ccp((iter_7_0 - 1) % 2 * 440 + 226, 498),
				clickAction = var_7_0
			})

			arg_7_0.bgSprite:addChild(var_7_8)

			local var_7_9 = display.newSprite(var_7_4[iter_7_0], 40, 38)

			var_7_8:addChild(var_7_9)

			local var_7_10 = arg_7_0.serverData[var_7_6].ServerName
			local var_7_11 = ui.newTTFLabel({
				y = 39,
				x = 85,
				text = var_7_10,
				font = _FONT_DEFAULT,
				size = Adapter.FontSize(24),
				color = ccc3(222, 255, 255),
				align = ui.TEXT_ALIGN_LEFT
			})

			var_7_8:addChild(var_7_11)

			var_7_8.tag = var_7_6

			var_7_8:setVisible(true)

			var_7_1[iter_7_0] = var_7_8
		end
	end

	local var_7_12 = arg_7_0.lastServerCount > 0 and 410 or 498

	for iter_7_3, iter_7_4 in ipairs(arg_7_0.serverData) do
		if iter_7_4.State == ServerStateType.eRecommend then
			table.insert(arg_7_0.recommendServerList, iter_7_4)
		end
	end

	local var_7_13 = table.getn(arg_7_0.recommendServerList)

	for iter_7_5 = 1, var_7_13 do
		local var_7_14 = "ui/server/server_004.png"

		if arg_7_0.recommendServerList[iter_7_5].State == ServerStateType.eMaintain then
			var_7_14 = "ui/server/server_000.png"
		end

		local var_7_15 = ui.newControlButton({
			normalImage = var_7_14,
			position = ccp((iter_7_5 - 1) % 2 * 440 + 226, var_7_12 - math.floor((iter_7_5 - 1) / 2) * 85),
			clickAction = var_7_0
		})

		arg_7_0.bgSprite:addChild(var_7_15)

		local var_7_16 = ui.newTTFLabel({
			y = 39,
			x = 85,
			text = arg_7_0.recommendServerList[iter_7_5].ServerName,
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(24),
			color = ccc3(222, 255, 255),
			align = ui.TEXT_ALIGN_LEFT
		})

		var_7_15:addChild(var_7_16)

		local var_7_17 = display.newSprite("ui/server/server_001.png", 40, 38)

		var_7_15:addChild(var_7_17)

		var_7_15.tag = iter_7_5

		var_7_15:setVisible(true)

		var_7_2[iter_7_5] = var_7_15
	end

	local function var_7_18()
		for iter_9_0, iter_9_1 in ipairs(var_7_2) do
			iter_9_1:setVisible(false)
		end

		for iter_9_2, iter_9_3 in ipairs(var_7_1) do
			iter_9_3:setVisible(false)
		end

		serverMoreButton:setVisible(false)
		arg_7_0.serverTableView:setVisible(true)
	end

	local var_7_19 = "ui/server/server_004.png"

	serverMoreButton = ui.newControlButton({
		normalImage = var_7_19,
		position = ccp(var_7_13 % 2 * 440 + 226, var_7_12 - math.floor(var_7_13 / 2) * 85),
		clickAction = var_7_18
	})

	arg_7_0.bgSprite:addChild(serverMoreButton)

	local var_7_20 = ui.newTTFLabel({
		y = 39,
		x = 85,
		text = string.lf("更多服务器"),
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(24),
		color = ccc3(222, 255, 255),
		align = ui.TEXT_ALIGN_LEFT
	})

	serverMoreButton:addChild(var_7_20)
	serverMoreButton:setVisible(true)
end

function var_0_0.createRequestServerTableView(arg_10_0)
	local var_10_0 = 0

	if arg_10_0.lastServerCount == 0 then
		local var_10_1 = 88
	end

	local var_10_2 = CCSize(891, 88)

	local function var_10_3(arg_11_0)
		return var_10_2.height, var_10_2.width
	end

	local function var_10_4(arg_12_0)
		return arg_10_0.showServerData and math.round(#arg_10_0.showServerData / 2 + 0.1) or 0
	end

	local function var_10_5(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_0:cellAtIndex(arg_13_1)

		if var_13_0 == nil then
			var_13_0 = CCTableViewCell:new()

			local function var_13_1(arg_14_0, arg_14_1)
				arg_10_0:backTouchChoosedServer(arg_10_0.showServerData[arg_14_1.tag])
			end

			local var_13_2 = arg_10_0.showServerData[arg_13_1 * 2 + 2] and 2 or 1

			for iter_13_0 = 1, var_13_2 do
				local var_13_3 = arg_13_1 * 2 + iter_13_0
				local var_13_4 = arg_10_0.showServerData[var_13_3]
				local var_13_5 = "ui/server/server_004.png"

				if var_13_4.State == ServerStateType.eMaintain then
					var_13_5 = "ui/server/server_000.png"
				end

				local var_13_6 = ui.newControlButton({
					normalImage = var_13_5,
					position = ccp((iter_13_0 - 1) * 440 + 226, var_10_2.height / 2),
					clickAction = var_13_1
				})

				var_13_0:addChild(var_13_6)

				local var_13_7 = ui.newTTFLabel({
					y = 39,
					x = 85,
					text = var_13_4.ServerName,
					font = _FONT_DEFAULT,
					size = Adapter.FontSize(24),
					color = ccc3(222, 255, 255),
					align = ui.TEXT_ALIGN_LEFT
				})

				var_13_6:addChild(var_13_7)

				var_13_6.tag = var_13_3

				if var_13_4.State == ServerStateType.eFlow then
					local var_13_8 = display.newSprite("ui/server/server_007.png", 38, 42)

					var_13_6:addChild(var_13_8)
				elseif var_13_4.State == ServerStateType.eHot then
					local var_13_9 = display.newSprite("ui/server/server_008.png", 38, 42)

					var_13_6:addChild(var_13_9)
				elseif var_13_4.State == ServerStateType.eRecommend then
					local var_13_10 = display.newSprite("ui/server/server_001.png", 40, 38)

					var_13_6:addChild(var_13_10)
				end
			end
		end

		return var_13_0
	end

	arg_10_0.serverTableView = CCTableView:create(CCSize(display.width, display.height))

	arg_10_0.serverTableView:setVisible(false)
	arg_10_0.serverTableView:setViewSize(CCSize(891, 525))
	arg_10_0.serverTableView:setPosition(ccp(0, 17))
	arg_10_0.serverTableView:setVerticalFillOrder(kCCTableViewFillTopDown)
	arg_10_0.serverTableView:setDirection(kCCScrollViewDirectionVertical)
	arg_10_0.bgSprite:addChild(arg_10_0.serverTableView)
	arg_10_0.serverTableView:registerScriptHandler(var_10_3, CCTableView.kTableCellSizeForIndex)
	arg_10_0.serverTableView:registerScriptHandler(var_10_4, CCTableView.kNumberOfCellsInTableView)
	arg_10_0.serverTableView:registerScriptHandler(var_10_5, CCTableView.kTableCellSizeAtIndex)
end

return var_0_0
