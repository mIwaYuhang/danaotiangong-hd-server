require("scenes.battle.BattleData")
require("scenes.battle.EffectConfig")

local var_0_0 = class("BattleWeather", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)
local var_0_1 = 60
local var_0_2 = 0.2
local var_0_3 = 50 * Adapter.MinScale

local function var_0_4()
	if math.random(0, 1) > 0.5 then
		return true
	end

	return false
end

local function var_0_5(arg_3_0)
	local var_3_0 = math.random(1, #TimeFrameConfig[arg_3_0].probType)

	for iter_3_0, iter_3_1 in pairs(TimeFrameConfig[arg_3_0].probType) do
		if var_3_0 == iter_3_0 then
			return iter_3_1
		end
	end
end

eTimeFrameType = {
	midnight = 2,
	midday = 1
}
eWeatherType = {
	thundershower = 3,
	cloudy = 5,
	fog = 4,
	sunniness = 1,
	rainy = 2
}
TimeFrameConfig = {
	[eTimeFrameType.midday] = {
		probType = {
			eWeatherType.sunniness,
			eWeatherType.rainy,
			eWeatherType.fog,
			eWeatherType.cloudy
		},
		color = {
			[eWeatherType.sunniness] = ccc3(255, 255, 255),
			[eWeatherType.fog] = ccc3(255, 255, 255),
			[eWeatherType.rainy] = ccc3(102, 137, 170),
			[eWeatherType.cloudy] = ccc3(102, 137, 170)
		},
		alpha = {
			[eWeatherType.sunniness] = 0,
			[eWeatherType.rainy] = 0.1,
			[eWeatherType.fog] = 0,
			[eWeatherType.cloudy] = 0.1
		}
	},
	[eTimeFrameType.midnight] = {
		probType = {
			eWeatherType.sunniness,
			eWeatherType.rainy,
			eWeatherType.cloudy,
			eWeatherType.thundershower
		},
		color = {
			[eWeatherType.sunniness] = ccc3(0, 0, 0),
			[eWeatherType.thundershower] = ccc3(0, 0, 0),
			[eWeatherType.rainy] = ccc3(0, 0, 0),
			[eWeatherType.cloudy] = ccc3(0, 0, 0)
		},
		alpha = {
			[eWeatherType.sunniness] = 0.4,
			[eWeatherType.thundershower] = 0.5,
			[eWeatherType.rainy] = 0.5,
			[eWeatherType.cloudy] = 0.5
		}
	}
}
WeatherConfig = {
	[eWeatherType.sunniness] = {
		create = function(arg_4_0, arg_4_1)
			return
		end,
		fadeto = function(arg_5_0, arg_5_1, arg_5_2)
			arg_5_2()
		end
	},
	[eWeatherType.rainy] = {
		create = function(arg_6_0, arg_6_1)
			return (createParticleEffect("ui/battle/BattleParticle/rain1.plist", CCPoint(display.cx, display.height + Adapter.MinScale * 100), arg_6_0))
		end,
		fadeto = function(arg_7_0, arg_7_1, arg_7_2)
			local var_7_0 = CCArray:create()

			arg_7_0.currentWeather:stopSystem()
			var_7_0:addObject(CCDelayTime:create(2))
			var_7_0:addObject(CCCallFunc:create(function()
				arg_7_0.currentWeather:removeFromParentAndCleanup(true)
				arg_7_2()
			end))
			arg_7_0.currentWeather:runAction(CCSequence:create(var_7_0))
		end
	},
	[eWeatherType.thundershower] = {
		create = function(arg_9_0, arg_9_1)
			local var_9_0 = createParticleEffect("ui/battle/BattleParticle/rain2.plist", CCPoint(display.cx + Adapter.MinScale * 100, display.height + Adapter.MinScale * 100), arg_9_0)
			local var_9_1 = 0

			local function var_9_2(arg_10_0)
				var_9_1 = var_9_1 + arg_10_0

				if var_9_1 > 5 then
					var_9_1 = 0

					local var_10_0 = TimeFrameConfig[arg_9_1].alpha[eWeatherType.thundershower] * 255
					local var_10_1 = TimeFrameConfig[arg_9_1].color[eWeatherType.thundershower]

					if var_0_4() then
						local var_10_2 = CCArray:create()

						var_10_2:addObject(CCCallFunc:create(function()
							arg_9_0:setOpacity(100)
							arg_9_0:setColor(ccc3(255, 255, 255))
						end))

						if var_0_4() then
							var_10_2:addObject(CCDelayTime:create(0.2))
							var_10_2:addObject(CCCallFunc:create(function()
								arg_9_0:setOpacity(var_10_0)
								arg_9_0:setColor(var_10_1)
							end))
							var_10_2:addObject(CCDelayTime:create(0.1))
							var_10_2:addObject(CCCallFunc:create(function()
								arg_9_0:setOpacity(100)
								arg_9_0:setColor(ccc3(255, 255, 255))
							end))
						end

						var_10_2:addObject(CCCallFunc:create(function()
							arg_9_0:runAction(CCFadeTo:create(0.5, var_10_0))
							arg_9_0:runAction(CCTintTo:create(0.5, var_10_1.r, var_10_1.g, var_10_1.b))
						end))
						arg_9_0:runAction(CCSequence:create(var_10_2))
					end
				end
			end

			arg_9_0:registFunction(eWeatherType.thundershower, var_9_2)

			return var_9_0
		end,
		fadeto = function(arg_15_0, arg_15_1, arg_15_2)
			arg_15_0:removeFunction(eWeatherType.thundershower)
			arg_15_0.currentWeather:stopSystem()

			local var_15_0 = CCArray:create()

			var_15_0:addObject(CCDelayTime:create(2))
			var_15_0:addObject(CCCallFunc:create(function()
				arg_15_0.currentWeather:removeFromParentAndCleanup(true)
				arg_15_2()
			end))
			arg_15_0.currentWeather:runAction(CCSequence:create(var_15_0))
		end
	},
	[eWeatherType.fog] = {
		create = function(arg_17_0, arg_17_1)
			local var_17_0 = ScrollSprite:create(var_0_3, 0, "ui/transport/transport_cloud.png")

			var_17_0:setAnchorPoint(ccp(0, 0.5))
			var_17_0:setScaleX(Adapter.AutoScaleX)
			var_17_0:setScaleY(Adapter.AutoScaleY)
			var_17_0:setPosition(ccp(0, display.cy))
			arg_17_0:addChild(var_17_0)
			var_17_0:setOpacity(0)
			var_17_0:runAction(CCFadeIn:create(2))

			return var_17_0
		end,
		fadeto = function(arg_18_0, arg_18_1, arg_18_2)
			local var_18_0 = CCArray:create()

			var_18_0:addObject(CCFadeOut:create(2))
			var_18_0:addObject(CCCallFunc:create(function()
				arg_18_0.currentWeather:removeFromParentAndCleanup(true)
				arg_18_2()
			end))
			arg_18_0.currentWeather:runAction(CCSequence:create(var_18_0))
		end
	},
	[eWeatherType.cloudy] = {
		create = function(arg_20_0, arg_20_1)
			return
		end,
		fadeto = function(arg_21_0, arg_21_1, arg_21_2)
			arg_21_2()
		end
	}
}

function var_0_0.ctor(arg_22_0)
	arg_22_0.currentWeather = nil
	arg_22_0.currentTime = nil
	arg_22_0.cWeatherType = nil
end

function var_0_0.fadeBack(arg_23_0, arg_23_1)
	local var_23_0 = CCArray:create()
	local var_23_1 = CCFadeTo:create(var_0_1 / 3, var_0_2 * 255)
	local var_23_2 = CCTintTo:create(var_0_1 / 3, 0, 0, 0)

	var_23_0:addObject(var_23_2)
	arg_23_0:runAction(var_23_1)
	var_23_0:addObject(CCCallFunc:create(arg_23_1))
	arg_23_0:runAction(CCSequence:create(var_23_0))
end

function var_0_0.check(arg_24_0, arg_24_1, arg_24_2)
	if TimeFrameConfig[arg_24_1] then
		for iter_24_0, iter_24_1 in pairs(TimeFrameConfig[arg_24_1].probType) do
			if arg_24_2 == iter_24_1 then
				return true
			end
		end
	end

	dump("BUG")

	return false
end

function var_0_0.create(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if arg_25_0:check(arg_25_1, arg_25_2) then
		arg_25_0:setColor(ccc3(0, 0, 0))
		arg_25_0:setOpacity(var_0_2 * 255)

		local var_25_0 = CCArray:create()
		local var_25_1 = TimeFrameConfig[arg_25_1].color[arg_25_2]
		local var_25_2 = TimeFrameConfig[arg_25_1].alpha[arg_25_2]
		local var_25_3 = CCFadeTo:create(var_0_1 / 3, var_25_2 * 255)
		local var_25_4 = CCTintTo:create(var_0_1 / 3, var_25_1.r, var_25_1.g, var_25_1.b)

		arg_25_0:runAction(var_25_3)
		var_25_0:addObject(var_25_4)
		var_25_0:addObject(CCDelayTime:create(var_0_1 / 3))
		var_25_0:addObject(CCCallFunc:create(function()
			arg_25_0:fadeBack(arg_25_3)
		end))
		arg_25_0:runAction(CCSequence:create(var_25_0))

		arg_25_0.currentWeather = WeatherConfig[arg_25_2].create(arg_25_0, arg_25_1)
	end
end

function var_0_0.fadeTo(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if arg_27_0:check(arg_27_1, arg_27_2) then
		local var_27_0 = CCArray:create()
		local var_27_1 = TimeFrameConfig[arg_27_1].color[arg_27_2]
		local var_27_2 = TimeFrameConfig[arg_27_1].alpha[arg_27_2]
		local var_27_3 = CCFadeTo:create(var_0_1 / 3, var_27_2 * 255)
		local var_27_4 = CCTintTo:create(var_0_1 / 3, var_27_1.r, var_27_1.g, var_27_1.b)

		arg_27_0:runAction(var_27_3)
		var_27_0:addObject(var_27_4)
		var_27_0:addObject(CCDelayTime:create(var_0_1 / 3))
		var_27_0:addObject(CCCallFunc:create(function()
			arg_27_0:fadeBack(arg_27_3)
		end))
		arg_27_0:runAction(CCSequence:create(var_27_0))
		WeatherConfig[arg_27_0.cWeatherType].fadeto(arg_27_0, arg_27_0.currentTime, function()
			arg_27_0.cWeatherType = arg_27_2
			arg_27_0.currentTime = arg_27_1
			arg_27_0.currentWeather = WeatherConfig[arg_27_2].create(arg_27_0, arg_27_1)
		end)
	end
end

function var_0_0.nextTime(arg_30_0, arg_30_1)
	if arg_30_1 == eTimeFrameType.midday then
		return eTimeFrameType.midnight
	elseif arg_30_1 == eTimeFrameType.midnight then
		return eTimeFrameType.midday
	end
end

function var_0_0.loop(arg_31_0)
	local var_31_0 = arg_31_0:nextTime(arg_31_0.currentTime)
	local var_31_1 = var_0_5(var_31_0)

	arg_31_0:checkName(var_31_1)
	arg_31_0:fadeTo(var_31_0, var_31_1, function()
		arg_31_0:loop()
	end)
end

function var_0_0.manager(arg_33_0, arg_33_1)
	arg_33_0.currentTime = math.random(1, #eTimeFrameType)
	arg_33_0.cWeatherType = var_0_5(arg_33_0.currentTime)

	arg_33_0:checkName(arg_33_0.cWeatherType)
	arg_33_0:create(arg_33_0.currentTime, arg_33_0.cWeatherType, function()
		arg_33_0:loop()
	end)

	local function var_33_0(arg_35_0)
		if arg_33_0.funcList then
			for iter_35_0, iter_35_1 in pairs(arg_33_0.funcList) do
				iter_35_1.func(arg_35_0)
			end
		end
	end

	arg_33_0:scheduleUpdate(var_33_0)
end

function var_0_0.registFunction(arg_36_0, arg_36_1, arg_36_2)
	if not arg_36_0.funcList then
		arg_36_0.funcList = {}
	end

	local var_36_0 = {
		id = arg_36_1,
		func = arg_36_2
	}

	table.insert(arg_36_0.funcList, var_36_0)
end

function var_0_0.removeFunction(arg_37_0, arg_37_1)
	if arg_37_0.funcList then
		for iter_37_0, iter_37_1 in pairs(arg_37_0.funcList) do
			if iter_37_1.id == arg_37_1 then
				arg_37_0.funcList[iter_37_0] = nil

				break
			end
		end
	end
end

function var_0_0.checkName(arg_38_0, arg_38_1)
	if arg_38_1 == eWeatherType.sunniness then
		dump("阳光")
	elseif arg_38_1 == eWeatherType.rainy then
		dump("阴雨")
	elseif arg_38_1 == eWeatherType.thundershower then
		dump("雷雨")
	elseif arg_38_1 == eWeatherType.fog then
		dump("浓雾")
	elseif arg_38_1 == eWeatherType.cloudy then
		dump("阴天")
	else
		dump("BUG")
	end
end

function var_0_0.isAllowAnim(arg_39_0)
	if arg_39_0.cWeatherType == eWeatherType.rainy or arg_39_0.cWeatherType == eWeatherType.thundershower then
		return false
	end

	return true
end

function var_0_0.updateCloudSpeed(arg_40_0, arg_40_1)
	if arg_40_0.cWeatherType == eWeatherType.fog then
		arg_40_0.currentWeather:setScrollSpeedX(var_0_3 + arg_40_1)
	end
end

return var_0_0
