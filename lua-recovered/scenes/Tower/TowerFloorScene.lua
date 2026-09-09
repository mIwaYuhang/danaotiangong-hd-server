require("network.TowerRequest")

local var_0_0 = class("TowerFloorScene", function()
	return display.newScene("TowerFloorScene")
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	local var_2_0 = display.newSprite("ui/tower/tower_044.jpg")

	var_2_0:align(display.BOTTOM_CENTER, display.cx, 0)
	var_2_0:setScaleX(Adapter.AutoScaleX)
	var_2_0:setScaleY(Adapter.AutoScaleY)
	arg_2_0:addChild(var_2_0)
	arg_2_0:createNetworkInterface()
	arg_2_0.towerInfoRequest:request(arg_2_0)

	arg_2_0.pramas = arg_2_1
end

function var_0_0.createNetworkInterface(arg_3_0)
	arg_3_0.towerInfoRequest = GetTowerInfoRequest:new(arg_3_0)

	local function var_3_0()
		local var_4_0 = arg_3_0.towerInfoRequest:getTowerInfo()

		arg_3_0._towerInfo = var_4_0

		if arg_3_0.pramas then
			arg_3_0.pramas.towerInfo.RemainTowerChallengeTime = var_4_0.RemainTowerChallengeTime
		end

		arg_3_0.pramas = arg_3_0.pramas or {
			donotRequest = true,
			towerInfo = var_4_0
		}
		arg_3_0.pramas.towerScene = arg_3_0

		local var_4_1 = require("scenes.Tower.TowerFloorLayer").new(arg_3_0.pramas)

		arg_3_0:addChild(var_4_1)
		GuideLayer:showMissionReward(arg_3_0, TaskType.eTaskTeaching, TaskEntryType.eEntryTower, 1)
	end

	local function var_3_1(arg_5_0)
		print("responseTowerInfoRequestFail")
	end

	arg_3_0.towerInfoRequest:setResponseNormalHandler(var_3_0)
	arg_3_0.towerInfoRequest:setResponseExceptionHandler(var_3_1)
end

return var_0_0
