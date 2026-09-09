require("network.StoreRequest")

local var_0_0 = require("scenes.ToolLayer")
local var_0_1 = class("FirstRechargeLayer", function()
	return display.newLayer()
end)

function var_0_1.ctor(arg_2_0)
	arg_2_0.nodeSize = CCSize(830, 545)
	arg_2_0.container = CCLayerColor:create(ccc4(0, 0, 0, 0))

	arg_2_0.container:setContentSize(arg_2_0.nodeSize)
	arg_2_0:addChild(arg_2_0.container)

	arg_2_0.RewardItemTable = {}

	local var_2_0 = display.newSprite("ui/activity/activity_080.jpg", arg_2_0.nodeSize.width / 2, arg_2_0.nodeSize.height / 2 + 12)

	arg_2_0.container:addChild(var_2_0)
	arg_2_0:initNetworkRequest()

	arg_2_0.rewardTableView = arg_2_0:createRewardTableView()

	arg_2_0.rewardTableView:setPosition(ccp(335, 135))
	arg_2_0.container:addChild(arg_2_0.rewardTableView)
	arg_2_0.rewardListRequest:request()

	arg_2_0.getButton = ui.newControlButton({
		normalImage = "ui/activity/activity_064.png",
		disabledImage = "ui/activity/activity_065.png",
		clickAction = function(arg_3_0, arg_3_1)
			arg_2_0.rewardRequest:request()
		end
	})

	arg_2_0.getButton:setPosition(542, 60)
	arg_2_0.container:addChild(arg_2_0.getButton)

	local var_2_1 = arg_2_0.getButton:getContentSize()
	local var_2_2 = "uilocal/activity/activity_text_031.png"
	local var_2_3 = display.newSprite(var_2_2)

	var_2_3:setPosition(var_2_1.width / 2, var_2_1.height / 2)
	arg_2_0.getButton:addChild(var_2_3)
end

function var_0_1.initNetworkRequest(arg_4_0)
	arg_4_0.rewardListRequest = GetFirstChargeRewardListRequest:new()

	local function var_4_0()
		arg_4_0.RewardItemTable = arg_4_0.rewardListRequest:getRewardList()

		arg_4_0.rewardTableView:reloadData()
	end

	local function var_4_1(arg_6_0)
		return
	end

	arg_4_0.rewardListRequest:setResponseNormalHandler(var_4_0)
	arg_4_0.rewardListRequest:setResponseExceptionHandler(var_4_1)

	arg_4_0.rewardRequest = GetFirstChargeRewardRequest:new()

	local function var_4_2()
		arg_4_0.getButton:setEnabled(false)
		Player:setFirstRechargeCount(0)
		ui.showMessageBox({
			text = string.lf("上仙！您的豪华奖励领取成功！请到阵容或装备中进行道具查看！")
		})
	end

	local function var_4_3(arg_8_0)
		if arg_8_0 == NetworkState.PlayerNotCharge then
			local function var_8_0()
				game.enterStoreRechargeScene()
			end

			ui.showMessageBox({
				text = string.lf("上仙！您还没有任何充值，请充值以后再来领取吧，"),
				title2 = string.lf("取消"),
				action1 = var_8_0
			})
		end
	end

	arg_4_0.rewardRequest:setResponseNormalHandler(var_4_2)
	arg_4_0.rewardRequest:setResponseExceptionHandler(var_4_3)
end

function var_0_1.createRewardTableView(arg_10_0)
	local var_10_0 = CCTableView:create(CCSize(450, 130))

	var_10_0:setPosition(308, 6)
	var_10_0:setViewSize(CCSize(450, 130))
	var_10_0:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_10_0:setDirection(kCCScrollViewDirectionHorizontal)

	local function var_10_1(arg_11_0)
		return 150, 110
	end

	local function var_10_2(arg_12_0)
		return #arg_10_0.RewardItemTable
	end

	local function var_10_3(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_0:cellAtIndex(arg_13_1)
		local var_13_1 = arg_13_1 + 1

		if var_13_0 == nil then
			var_13_0 = CCTableViewCell:new()

			local var_13_2 = arg_10_0.RewardItemTable[var_13_1].Type == ItemType.eEquip
			local var_13_3 = {
				isName = true,
				type = arg_10_0.RewardItemTable[var_13_1].Type,
				itemId = arg_10_0.RewardItemTable[var_13_1].ID or 0,
				isGroupHero = var_13_2,
				nameColor = ccc3(239, 232, 195),
				count = arg_10_0.RewardItemTable[var_13_1].Count,
				clickAction = function()
					print("显示获取奖励物品的 Tips ")
					var_0_0.tipshandler(arg_10_0.RewardItemTable[var_13_1])
				end
			}
			local var_13_4 = figure.createHeader(var_13_3)

			var_13_4:setAnchorPoint(CCPoint(0.5, 0.5))
			var_13_4:setPosition(55, 100)
			var_13_0:addChild(var_13_4)
		end

		return var_13_0
	end

	var_10_0:registerScriptHandler(var_10_1, CCTableView.kTableCellSizeForIndex)
	var_10_0:registerScriptHandler(var_10_2, CCTableView.kNumberOfCellsInTableView)
	var_10_0:registerScriptHandler(var_10_3, CCTableView.kTableCellSizeAtIndex)
	var_10_0:reloadData()

	return var_10_0
end

return var_0_1
