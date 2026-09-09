require("base.figure")
require("network.SlaveRequest")
require("network.TransportRequest")
require("network.GuildRequest")
require("scenes.battle.BattleOperator")
require("network.DuelRequest")

DlgReportType = {
	reportShenqi = 4,
	reportBiwu = 6,
	reportPK = 3,
	reportTransport = 2,
	reportGuildXm = 5,
	reportSlave = 1
}

local var_0_0 = class("DlgReportLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or {}

	addBlackLayer(arg_2_0)

	arg_2_0._closecallback = arg_2_1.closecallback

	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	local var_2_0 = display.newScale9Sprite("ui/common/common_040.png")

	arg_2_0.bgSize = CCSize(560, 480)

	var_2_0:setPreferredSize(arg_2_0.bgSize)
	var_2_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_0:setPosition(CCPoint(display.cx, display.cy))
	var_2_0:setScale(Adapter.MinScale)
	arg_2_0:addChild(var_2_0)

	arg_2_0.background = CCLayerColor:create(ccc4(0, 0, 0, 0))

	arg_2_0.background:setContentSize(arg_2_0.bgSize)
	var_2_0:addChild(arg_2_0.background)

	local var_2_1 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		highlightedImage = "ui/common/btn_closed.png",
		position = CCPoint(arg_2_0.bgSize.width - 30, arg_2_0.bgSize.height - 25),
		clickAction = function()
			if arg_2_0._closecallback then
				arg_2_0._closecallback()
			end

			arg_2_0:removeFromParentAndCleanup(true)
		end
	})

	var_2_0:addChild(var_2_1)

	local var_2_2 = display.newSprite("ui/common/common_044.png")

	var_2_2:setAnchorPoint(CCPoint(0.5, 0))
	var_2_2:setPosition(CCPoint(arg_2_0.bgSize.width / 2, 10))
	arg_2_0.background:addChild(var_2_2)

	arg_2_0.reportList = {}

	arg_2_0:initRequests()

	arg_2_0.type = arg_2_1.type

	local var_2_3 = arg_2_1.type
	local var_2_4
	local var_2_5

	if var_2_3 == DlgReportType.reportSlave then
		var_2_4 = "uilocal/slave/slave_text_003.png"

		arg_2_0.slaveReportRequest:request()
	elseif var_2_3 == DlgReportType.reportTransport then
		var_2_5 = string.lf("运镖日志")

		arg_2_0.transportLogRequest:request(1)
	elseif var_2_3 == DlgReportType.reportPK then
		var_2_4 = "uilocal/slave/slave_text_003.png"
	elseif var_2_3 == DlgReportType.reportShenqi then
		var_2_5 = string.lf("抢夺战报")

		arg_2_0:handleShenqiReport(arg_2_1)
	elseif var_2_3 == DlgReportType.reportGuildXm then
		var_2_5 = string.lf("捐献日志")

		arg_2_0.guildLogListRequest:request(1)
	elseif var_2_3 == DlgReportType.reportBiwu then
		var_2_5 = string.lf("比武战报")

		arg_2_0.duelFightLogRequest:request()
	end

	if var_2_5 then
		addLabelWithColorSize(var_2_0, var_2_5, ccc3(255, 191, 111), 30, ccp(0, 0.5), ccp(45, 452), _FONT_LISU)
	elseif var_2_4 then
		local var_2_6 = display.newSprite(var_2_4)

		var_2_6:setAnchorPoint(CCPoint(0, 1))
		var_2_6:setPosition(30, arg_2_0.bgSize.height + 10)
		var_2_0:addChild(var_2_6)
	end
end

function var_0_0.handleShenqiReport(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.report

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_1 = {
			id = iter_5_1.id,
			time = getFormatCountDownTime(iter_5_1.time),
			content = string.lf("被 #EA8A1E%s#FFFFFF 掠夺了 %s 点神器碎片", iter_5_1.name, iter_5_1.soulValue)
		}

		table.insert(arg_5_0.reportList, var_5_1)
	end

	arg_5_0:refreshLayer()
end

function var_0_0.refreshLayer(arg_6_0, arg_6_1)
	arg_6_0.background:removeAllChildrenWithCleanup(true)
	arg_6_0:addTableView()
end

function var_0_0.initRequests(arg_7_0)
	local function var_7_0(arg_8_0)
		for iter_8_0, iter_8_1 in ipairs(arg_8_0) do
			local var_8_0 = {
				time = getFormatCountDownTime(iter_8_1.Times),
				content = getFullLogContent(iter_8_1.Content, iter_8_1.Type),
				TriggerPlayerId = iter_8_1.TriggerPlayerId or nil,
				isCanRevolt = iter_8_1.isCanRevolt or nil
			}

			table.insert(arg_7_0.reportList, var_8_0)
		end

		arg_7_0:refreshLayer()
	end

	local function var_7_1()
		if arg_7_0.slaveReportRequest.restable then
			var_7_0(arg_7_0.slaveReportRequest.restable)
		end
	end

	arg_7_0.slaveReportRequest = SlaveReportListRequest:new()

	arg_7_0.slaveReportRequest:setResponseNormalHandler(var_7_1)

	local function var_7_2()
		if arg_7_0.transportLogRequest.restable then
			var_7_0(arg_7_0.transportLogRequest.restable)
		end
	end

	arg_7_0.transportLogRequest = TransportLogRequest:new()

	arg_7_0.transportLogRequest:setResponseNormalHandler(var_7_2)

	local function var_7_3()
		local var_11_0 = arg_7_0.guildLogListRequest.restable

		if var_11_0 == nil or table.nums(var_11_0) == 0 then
			showFlashNotice(string.lf("暂无日志"))

			return
		end

		var_7_0(var_11_0)
	end

	if GuildLogListRequest then
		arg_7_0.guildLogListRequest = GuildLogListRequest:new()

		arg_7_0.guildLogListRequest:setResponseNormalHandler(var_7_3)
	end

	local function var_7_4()
		dump(arg_7_0.duelFightLogRequest.restable)

		if arg_7_0.duelFightLogRequest.restable then
			var_7_0(arg_7_0.duelFightLogRequest.restable)
		end
	end

	arg_7_0.duelFightLogRequest = DuelFightLogRequest:new()

	arg_7_0.duelFightLogRequest:setResponseNormalHandler(var_7_4)
end

function var_0_0.addTableView(arg_13_0)
	local var_13_0 = CCSize(arg_13_0.bgSize.width - 20, 100)

	if arg_13_0.type == DlgReportType.reportShenqi then
		var_13_0.height = 80
	end

	local var_13_1 = createTableView({
		reverse = true,
		size = CCSize(arg_13_0.bgSize.width - 20, 426),
		direction = kCCScrollViewDirectionVertical,
		dataset = arg_13_0.reportList,
		sizehandler = function(arg_14_0, arg_14_1)
			return var_13_0
		end,
		cellhandler = function(arg_15_0, arg_15_1, arg_15_2)
			local var_15_0 = CCSize(var_13_0.width, var_13_0.height - 6)
			local var_15_1 = display.newScale9Sprite("ui/team/team_093.png")

			var_15_1:setAnchorPoint(ccp(0, 0))
			var_15_1:setContentSize(var_15_0)
			addLabelWithColorSize(var_15_1, arg_15_2.time, ccc3(0, 225, 0), 20, CCPoint(1, 1), CCPoint(100, var_15_0.height))

			local var_15_2 = addLabelWithColorSize(var_15_1, arg_15_2.content, ccc3(255, 225, 255), 18, CCPoint(0, 1), CCPoint(120, var_15_0.height))

			var_15_2:setHorizontalAlignment(ui.TEXT_ALIGN_LEFT)
			var_15_2:setDimensions(CCSize(var_15_0.width - 120, var_15_0.height))

			if arg_13_0.type == DlgReportType.reportShenqi then
				local var_15_3 = ui.newControlButton({
					normalImage = "ui/common/common_073_2.png",
					scaleX = 0.8,
					scaleY = 0.8,
					text = string.lf("查看"),
					clickAction = function(arg_16_0, arg_16_1)
						BattleOperator:startBattle(eBattleType.ShenqiReport, {
							id = arg_15_2.id
						}, function(arg_17_0, arg_17_1)
							game.enterShenqiScene()
						end)
					end
				})

				var_15_3:setPosition(var_15_0.width - 60, var_15_0.height - 30)
				var_15_1:addChild(var_15_3)
			end

			return var_15_1
		end
	})

	var_13_1:setPosition(10, 4)
	arg_13_0.background:addChild(var_13_1)
end

return var_0_0
