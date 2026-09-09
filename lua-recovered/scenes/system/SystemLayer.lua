local var_0_0 = class("SystemLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

function var_0_0.ctor(arg_2_0)
	local function var_2_0(arg_3_0, arg_3_1, arg_3_2)
		return true
	end

	arg_2_0:addTouchEventListener(var_2_0, false, 1, true)
	arg_2_0:setTouchEnabled(true)
	arg_2_0:setColor(display.COLOR_BLACK)
	arg_2_0:setOpacity(191.25)
	arg_2_0:showSystemInfo()
end

function var_0_0.showSystemInfo(arg_4_0)
	arg_4_0:removeAllChildrenWithCleanup(true)

	local var_4_0
	local var_4_1 = CCFileUtils:sharedFileUtils():fullPathForFilename("PartnerSystemLayer.json")

	if io.exists(var_4_1) then
		var_4_0 = io.readfile(var_4_1)
	end

	local var_4_2 = json.decode(var_4_0) or {}
	local var_4_3 = 3

	if not var_4_2.noLogout then
		var_4_3 = var_4_3 + 1
	end

	if var_4_2.gameCenter then
		var_4_3 = var_4_3 + table.getn(var_4_2.gameCenter)
	end

	local var_4_4 = CCSize(580, 396)
	local var_4_5 = CCSize(551, 247)
	local var_4_6 = 186
	local var_4_7 = 0

	if var_4_3 > 4 then
		var_4_4 = CCSize(580, 546)
		var_4_5 = CCSize(551, 397)
		var_4_6 = 261
		var_4_7 = 150
	end

	local var_4_8 = {
		"system_015.png",
		"system_016.png",
		"system_017.png",
		"system_018.png",
		"system_020.png"
	}
	local var_4_9 = display.newScale9Sprite("ui/system/system_014.png")

	var_4_9:setPreferredSize(var_4_4)
	var_4_9:align(display.CENTER, display.cx, display.cy)
	var_4_9:setScale(Adapter.MinScale)
	arg_4_0:addChild(var_4_9)

	local var_4_10 = display.newSprite("uilocal/system/system_text_002.png")

	var_4_10:align(display.LEFT_CENTER, 20, var_4_4.height - 28)
	var_4_9:addChild(var_4_10)

	local var_4_11 = display.newScale9Sprite("ui/system/system_013.png")

	var_4_11:setPreferredSize(var_4_5)
	var_4_11:align(display.CENTER, 289, var_4_6)
	var_4_9:addChild(var_4_11)

	local function var_4_12()
		arg_4_0:removeFromParent()
	end

	local var_4_13 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		position = ccp(540, var_4_4.height - 28),
		clickAction = var_4_12
	})

	var_4_9:addChild(var_4_13)

	local var_4_14 = {
		"ui/system/system_009.png",
		"ui/system/system_012.png"
	}
	local var_4_15 = {
		string.lf("游戏设置"),
		string.lf("游戏图鉴")
	}
	local var_4_16 = {
		function()
			local function var_6_0(arg_7_0)
				var_4_9:setVisible(arg_7_0)
			end

			local function var_6_1()
				var_6_0(true)
			end

			local var_6_2 = require("scenes.system.OptionVolumeLayer").new({
				callback = var_6_1
			})

			arg_4_0:addChild(var_6_2, 1)
			var_6_0(false)
		end,
		function()
			game.enterTujianScene()
		end
	}

	if not var_4_2.noLogout then
		table.insert(var_4_14, "ui/system/system_010.png")
		table.insert(var_4_15, string.lf("账号切换"))
		table.insert(var_4_16, function()
			arg_4_0:showRestartLayer()
		end)
	end

	local var_4_17 = var_4_2.gameCenter or {}

	dump(var_4_17, "gameCenterTable")

	for iter_4_0, iter_4_1 in pairs(var_4_17) do
		table.insert(var_4_14, iter_4_1.image)
		table.insert(var_4_15, iter_4_1.text)
		table.insert(var_4_16, function()
			IPlatform:instance():gameCenter(iter_4_1.centerID)
		end)
	end

	for iter_4_2, iter_4_3 in ipairs(var_4_14) do
		local var_4_18 = (iter_4_2 - 1) % 4
		local var_4_19 = math.ceil(iter_4_2 / 4) - 1
		local var_4_20 = 130 * var_4_18 + 92
		local var_4_21 = ui.newControlButton({
			normalImage = iter_4_3,
			clickAction = var_4_16[iter_4_2],
			position = ccp(var_4_20, 230 - var_4_19 * 150 + var_4_7)
		})

		var_4_9:addChild(var_4_21)
		var_4_21:setScaleX(1)

		local var_4_22 = ui.newTTFLabel({
			text = var_4_15[iter_4_2],
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(24),
			align = ui.TEXT_ALIGN_CENTER,
			x = var_4_20,
			y = 150 - var_4_19 * 150 + var_4_7,
			color = display.COLOR_BLACK
		})

		var_4_9:addChild(var_4_22)
	end
end

function var_0_0.showRestartLayer(arg_12_0)
	arg_12_0:removeAllChildrenWithCleanup(true)

	arg_12_0.restartSprite = display.newSprite("ui/system/system_014.png")

	arg_12_0.restartSprite:align(display.CENTER, display.cx, display.cy)
	arg_12_0.restartSprite:setScaleY(Adapter.MinScale)
	arg_12_0.restartSprite:setScaleX(Adapter.MinScale)
	arg_12_0:addChild(arg_12_0.restartSprite)

	local var_12_0 = display.newSprite("uilocal/system/system_text_002.png")

	var_12_0:align(display.LEFT_CENTER, 20, 368)
	arg_12_0.restartSprite:addChild(var_12_0)
	var_12_0:setScaleX(1)

	local var_12_1 = display.newSprite("ui/system/system_013.png")

	var_12_1:align(display.CENTER, 289, 186)
	arg_12_0.restartSprite:addChild(var_12_1)

	local function var_12_2()
		arg_12_0.restartSprite:removeFromParent()
		arg_12_0:showSystemInfo()
	end

	local var_12_3 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		position = ccp(540, 368),
		clickAction = var_12_2
	})

	arg_12_0.restartSprite:addChild(var_12_3)
	var_12_3:setScaleX(1)

	local function var_12_4()
		if IPlatform:instance():getConfig("ThridLogin") == "True" then
			IPlatform:instance():logout()
		else
			game.restartGameEntry()
		end
	end

	local var_12_5 = {
		{
			fontSize = 20,
			y = 270,
			x = 60,
			title = string.lf("所在服务器:%s", Player.serverInfo.ServerName),
			color = ccc3(188, 42, 18),
			size = CCSize(350, 40)
		},
		{
			fontSize = 20,
			y = 230,
			x = 60,
			title = string.lf("资源号:%s", NetworkMediator.resversion),
			color = ccc3(188, 42, 18),
			size = CCSize(350, 40)
		},
		{
			fontSize = 20,
			y = 190,
			x = 60,
			title = string.lf("角色ID:%s", Player.playerPromoterId),
			color = ccc3(188, 42, 18),
			size = CCSize(350, 40)
		}
	}

	for iter_12_0 = 1, #var_12_5 do
		local var_12_6 = var_12_5[iter_12_0]
		local var_12_7 = ui.newTTFLabel({
			text = var_12_6.title,
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(var_12_6.fontSize),
			color = var_12_6.color,
			align = ui.TEXT_ALIGN_LEFT,
			valign = ui.TEXT_VALIGN_CENTER,
			dimensions = var_12_6.size,
			x = var_12_6.x,
			y = var_12_6.y
		})

		arg_12_0.restartSprite:addChild(var_12_7)
		Adapter.NodeAbsScale(var_12_7)
	end

	if tonumber(EditionConfig.__Version) >= 115 then
		local var_12_8 = ui.newControlButton({
			normalImage = "ui/common/common_019.png",
			fontSize = 22,
			clickAction = function(arg_15_0, arg_15_1)
				ui.showMessageBox({
					text = string.lf("清理缓存后需要重新更新补丁包，是否清理？"),
					title1 = string.lf("确定"),
					action1 = function(...)
						luaDeleteDirExcept(EditionConfig.__ResourceUpdaterDir, EditionConfig.__UserData)
						LocalData:saveResourceID(0)
						NetworkMediator:setRequestResVersion(0)
						showFlashNotice(string.lf("清理缓存完成！"))
					end,
					title2 = string.lf("取消")
				})
			end,
			fontName = _FONT_LISU,
			position = ccp(120, 140),
			text = string.lf("清理缓存"),
			textColor = ColorTable.eTitleTabButton_Selected
		})

		arg_12_0.restartSprite:addChild(var_12_8, 1)
	end

	local var_12_9 = ui.newControlButton({
		fontSize = 22,
		disabledImage = "ui/common/common_019.png",
		normalImage = "ui/common/common_019.png",
		highlightedImage = "ui/common/common_019.png",
		clickAction = var_12_4,
		fontName = _FONT_LISU,
		position = ccp(290, 32),
		text = string.lf("确认切换"),
		textColor = ColorTable.eTitleTabButton_Selected
	})

	arg_12_0.restartSprite:addChild(var_12_9, 1)
end

return var_0_0
