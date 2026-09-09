local function var_0_0(arg_1_0, arg_1_1)
	local var_1_0 = {}
	local var_1_1 = 0

	for iter_1_0, iter_1_1 in pairs(arg_1_1) do
		var_1_0[iter_1_0] = {}
		var_1_0[iter_1_0].bar = {}
		var_1_0[iter_1_0].effect = arg_1_0.effect
		var_1_0[iter_1_0].position = arg_1_0.position

		if iter_1_0 ~= #arg_1_1 then
			if arg_1_0.bar.health then
				var_1_0[iter_1_0].bar.health = math.ceil(arg_1_0.bar.health * iter_1_1)
			end

			var_1_1 = var_1_1 + var_1_0[iter_1_0].bar.health
		else
			if arg_1_0.bar.health then
				var_1_0[iter_1_0].bar.health = arg_1_0.bar.health - var_1_1
			end

			if arg_1_0.bar.rage then
				var_1_0[iter_1_0].bar.rage = arg_1_0.bar.rage
			end
		end
	end

	return var_1_0
end

local function var_0_1(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = var_0_0(arg_2_0, arg_2_1)

	for iter_2_0 = 1, #var_2_0 - 1 do
		arg_2_4:addObject(CCCallFunc:create(function()
			arg_2_3(var_2_0[iter_2_0], false)

			if arg_2_5 then
				arg_2_5()
			end
		end))
		arg_2_4:addObject(CCDelayTime:create(arg_2_2[iter_2_0] * BattleSpeed))
	end

	arg_2_4:addObject(CCCallFunc:create(function()
		arg_2_3(var_2_0[#var_2_0], true)

		if arg_2_5 then
			arg_2_5()
		end
	end))
	arg_2_4:addObject(CCDelayTime:create(arg_2_2[#arg_2_2] * BattleSpeed))
end

local function var_0_2(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	local var_5_0 = var_0_0(arg_5_0, arg_5_1)

	for iter_5_0 = 1, #var_5_0 - 1 do
		table.insert(arg_5_4, function()
			arg_5_3(var_5_0[iter_5_0], false)

			if arg_5_5 then
				arg_5_5()
			end
		end)
		table.insert(arg_5_4, arg_5_2[iter_5_0])
		table.insert(arg_5_4, AAT_Percent)
	end

	table.insert(arg_5_4, function()
		arg_5_3(var_5_0[#var_5_0], true)

		if arg_5_5 then
			arg_5_5()
		end
	end)
	table.insert(arg_5_4, arg_5_2[#arg_5_2])
	table.insert(arg_5_4, AAT_Percent)
end

local function var_0_3(arg_8_0, arg_8_1)
	if arg_8_1 then
		return BattleData.pos_Hero[arg_8_0].x - 50 * Adapter.MinScale
	else
		return BattleData.pos_Enemy[arg_8_0].x - 50 * Adapter.MinScale
	end
end

local function var_0_4(arg_9_0, arg_9_1)
	if arg_9_1 then
		return BattleData.pos_Hero[arg_9_0].x + 50 * Adapter.MinScale
	else
		return BattleData.pos_Enemy[arg_9_0].x + 50 * Adapter.MinScale
	end
end

local function var_0_5(arg_10_0, arg_10_1)
	if arg_10_1 then
		return BattleData.pos_Hero[arg_10_0].y + 60 * Adapter.MinScale
	else
		return BattleData.pos_Enemy[arg_10_0].y + 60 * Adapter.MinScale
	end
end

local function var_0_6(arg_11_0, arg_11_1)
	if arg_11_1 then
		return BattleData.pos_Hero[arg_11_0].y - 10 * Adapter.MinScale
	else
		return BattleData.pos_Enemy[arg_11_0].y - 10 * Adapter.MinScale
	end
end

local function var_0_7()
	local var_12_0 = true

	return {
		area = {
			ccp(var_0_3(4, var_12_0), var_0_5(1, var_12_0)),
			ccp(var_0_4(2, var_12_0), var_0_6(3, var_12_0))
		},
		pos = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	}
end

local function var_0_8()
	local var_13_0 = false

	return {
		area = {
			ccp(var_0_3(2, var_13_0), var_0_5(1, var_13_0)),
			ccp(var_0_4(4, var_13_0), var_0_6(3, var_13_0))
		},
		pos = {
			7,
			8,
			9,
			10,
			11,
			12
		}
	}
end

local function var_0_9()
	local var_14_0 = false

	return {
		area = {
			ccp(var_0_3(2, var_14_0), var_0_5(1, var_14_0)),
			ccp(var_0_4(1, var_14_0), var_0_6(3, var_14_0))
		},
		pos = {
			7,
			8,
			9
		}
	}
end

local function var_0_10()
	local var_15_0 = false

	return {
		area = {
			ccp(var_0_3(5, var_15_0), var_0_5(4, var_15_0)),
			ccp(var_0_4(4, var_15_0), var_0_6(6, var_15_0))
		},
		pos = {
			10,
			11,
			12
		}
	}
end

local function var_0_11()
	local var_16_0 = true

	return {
		area = {
			ccp(var_0_3(1, var_16_0), var_0_5(1, var_16_0)),
			ccp(var_0_4(2, var_16_0), var_0_6(3, var_16_0))
		},
		pos = {
			1,
			2,
			3
		}
	}
end

local function var_0_12()
	local var_17_0 = true

	return {
		area = {
			ccp(var_0_3(4, var_17_0), var_0_5(1, var_17_0)),
			ccp(var_0_4(5, var_17_0), var_0_6(3, var_17_0))
		},
		pos = {
			4,
			5,
			6
		}
	}
end

local function var_0_13(arg_18_0)
	local var_18_0 = true

	if arg_18_0 == 1 or arg_18_0 == 4 then
		return {
			ccp(var_0_3(4, var_18_0), var_0_5(4, var_18_0)),
			ccp(var_0_4(1, var_18_0), var_0_6(1, var_18_0))
		}
	elseif arg_18_0 == 2 or arg_18_0 == 5 then
		return {
			ccp(var_0_3(5, var_18_0), var_0_5(5, var_18_0)),
			ccp(var_0_4(2, var_18_0), var_0_6(2, var_18_0))
		}
	elseif arg_18_0 == 3 or arg_18_0 == 6 then
		return {
			ccp(var_0_3(6, var_18_0), var_0_5(6, var_18_0)),
			ccp(var_0_4(3, var_18_0), var_0_6(3, var_18_0))
		}
	end
end

local function var_0_14(arg_19_0)
	local var_19_0 = false

	if arg_19_0 == 7 or arg_19_0 == 10 then
		return {
			ccp(var_0_3(1, var_19_0), var_0_5(1, var_19_0)),
			ccp(var_0_4(4, var_19_0), var_0_6(4, var_19_0))
		}
	elseif arg_19_0 == 8 or arg_19_0 == 11 then
		return {
			ccp(var_0_3(2, var_19_0), var_0_5(2, var_19_0)),
			ccp(var_0_4(5, var_19_0), var_0_6(5, var_19_0))
		}
	elseif arg_19_0 == 9 or arg_19_0 == 12 then
		return {
			ccp(var_0_3(3, var_19_0), var_0_5(3, var_19_0)),
			ccp(var_0_4(6, var_19_0), var_0_6(6, var_19_0))
		}
	end
end

local function var_0_15(arg_20_0, arg_20_1)
	local var_20_0 = {}

	if arg_20_1 > table.nums(arg_20_0.pos) then
		local var_20_1 = arg_20_0.area[1]
		local var_20_2 = arg_20_0.area[2]
		local var_20_3 = math.abs(var_20_2.y - var_20_1.y) / arg_20_1

		for iter_20_0 = 1, arg_20_1 - table.nums(arg_20_0.pos) do
			local var_20_4 = ccp(var_20_1.x, var_20_1.y - (iter_20_0 - 1) * var_20_3)
			local var_20_5 = ccp(var_20_2.x, var_20_1.y - iter_20_0 * var_20_3)
			local var_20_6 = math.random(var_20_4.x, var_20_5.x)
			local var_20_7 = math.random(var_20_4.y, var_20_5.y)

			table.insert(var_20_0, ccp(var_20_6, var_20_7))
		end
	end

	for iter_20_1, iter_20_2 in pairs(arg_20_0.pos) do
		table.insert(var_20_0, BattleData:getPosition(iter_20_2))
	end

	for iter_20_3, iter_20_4 in pairs(var_20_0) do
		local var_20_8 = math.random(1, arg_20_1)

		var_20_0[iter_20_3], var_20_0[var_20_8] = var_20_0[var_20_8], var_20_0[iter_20_3]
	end

	return var_20_0
end

local function var_0_16(arg_21_0, arg_21_1)
	if arg_21_1 then
		if arg_21_1.y <= BattleData.pos_Hero[1].y and arg_21_1.y > BattleData.pos_Hero[2].y then
			arg_21_0:getParent():reorderChild(arg_21_0, 0)
		elseif arg_21_1.y <= BattleData.pos_Hero[2].y and arg_21_1.y > BattleData.pos_Hero[3].y then
			arg_21_0:getParent():reorderChild(arg_21_0, 1)
		elseif arg_21_1.y <= BattleData.pos_Hero[3].y then
			arg_21_0:getParent():reorderChild(arg_21_0, 2)
		else
			arg_21_0:getParent():reorderChild(arg_21_0, -1)
		end

		orderScale(arg_21_0, arg_21_1)
	else
		arg_21_0:getParent():reorderChild(arg_21_0, 3)
	end
end

local function var_0_17(arg_22_0, arg_22_1)
	local var_22_0
	local var_22_1

	if not arg_22_0 then
		if BattleData:HeroHasSecond() then
			var_22_0 = var_0_15(var_0_12(), arg_22_1)
		elseif BattleData:HeroHasFirst() then
			var_22_0 = var_0_15(var_0_11(), arg_22_1)
		else
			dump("--------ERROR---------")
		end

		var_22_1 = 180
	else
		if BattleData:EnemyHasSecond() then
			var_22_0 = var_0_15(var_0_10(), arg_22_1)
		elseif BattleData:EnemyHasFirst() then
			var_22_0 = var_0_15(var_0_9(), arg_22_1)
		else
			dump("--------ERROR---------")
		end

		var_22_1 = 0
	end

	return var_22_0, var_22_1
end

local function var_0_18(arg_23_0, arg_23_1)
	local var_23_0
	local var_23_1

	if not arg_23_0 then
		if BattleData:HeroHasFirst() then
			var_23_0 = var_0_15(var_0_11(), arg_23_1)
		elseif BattleData:HeroHasSecond() then
			var_23_0 = var_0_15(var_0_12(), arg_23_1)
		else
			dump("--------ERROR---------")
		end

		var_23_1 = 180
	else
		if BattleData:EnemyHasFirst() then
			var_23_0 = var_0_15(var_0_9(), arg_23_1)
		elseif BattleData:EnemyHasSecond() then
			var_23_0 = var_0_15(var_0_10(), arg_23_1)
		else
			dump("--------ERROR---------")
		end

		var_23_1 = 0
	end

	return var_23_0, var_23_1
end

local function var_0_19(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = CCArray:create()

	for iter_24_0, iter_24_1 in pairs(arg_24_0) do
		var_24_0:addObject(CCCallFunc:create(function(...)
			if iter_24_0 == #arg_24_0 then
				arg_24_1(iter_24_1, true)
			else
				arg_24_1(iter_24_1, false)
			end
		end))

		if not arg_24_2 then
			var_24_0:addObject(CCDelayTime:create(0.1 * BattleSpeed))
		end
	end

	CCDirector:sharedDirector():getRunningScene():runAction(CCSequence:create(var_24_0))
end

local function var_0_20(arg_26_0, arg_26_1, arg_26_2)
	for iter_26_0, iter_26_1 in pairs(arg_26_0) do
		if not BattleData:isTeam(arg_26_1, iter_26_1.position) then
			local var_26_0 = BattleData:getDisplayNode(iter_26_1.position)

			shakeVertical_allways(var_26_0, arg_26_2 or 10, 0.02)
		end
	end
end

local function var_0_21(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
	if not arg_27_4.list then
		function arg_27_4.list(...)
			return nil
		end
	end

	var_0_19(arg_27_0.affectList, function(arg_29_0, arg_29_1)
		local var_29_0 = BattleData:getDisplayNode(arg_29_0.position)
		local var_29_1 = originalScale() * (arg_27_4.scale or 1)
		local var_29_2

		var_29_2 = BattleSkeleton:addEffect({
			parent = var_29_0,
			effectName = arg_27_4.effectName,
			position = arg_27_4.point,
			callbacklist = {
				function(...)
					arg_27_1:getParent():setPosition(0, 0)
					arg_27_4.shake(arg_27_1:getParent(), 20)
					arg_27_2(arg_29_0, true, arg_27_5)

					if arg_27_4.sound then
						BattleAudio:Sound_playEffect(arg_27_4.sound)
					end
				end,
				arg_27_4.time,
				AAT_Percent,
				function()
					var_29_2:removeFromParentAndCleanup(true)

					if arg_29_1 then
						arg_27_3()
					end
				end,
				1,
				AAT_Percent,
				arg_27_4.list()
			},
			scale = var_29_1,
			speed = arg_27_4.speed
		})

		if var_29_0.isHero then
			var_29_2:setRotationY(180)
		end

		if BattleData:isTeam(arg_29_0.position, arg_27_0.position) then
			var_29_2:setVisible(false)
		end
	end)
end

testSkillId = 65
EffectConfig = {
	[4] = function(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
		BattleAudio:Sound_playEffect(BattleAudio.skill_potianyiji)

		local var_32_0 = {
			effectName = "changbing_lv_potianyiji",
			time = 0.75,
			point = ccp(0, 140),
			shake = shakeVertical
		}

		var_0_21(arg_32_0, arg_32_1, arg_32_2, arg_32_3, var_32_0)
	end,
	[30] = function(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
		BattleAudio:Sound_playEffect(BattleAudio.skill_huaqijue)

		local var_33_0 = BattleData:getDisplayNode(arg_33_0.position)
		local var_33_1 = {
			time = 0,
			effectName = "faqi_zi_huaqijue",
			scale = 1.1,
			point = ccp(var_33_0.isHero and -30 or 30, 10),
			shake = shakeVertical
		}

		var_0_21(arg_33_0, arg_33_1, arg_33_2, arg_33_3, var_33_1, true)
	end,
	[33] = function(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
		local var_34_0 = {
			time = 0.8,
			effectName = "changbing_cheng_chukaihundun",
			scale = 1.1,
			point = ccp(0, 130),
			shake = shakeVertical,
			list = function(...)
				return function(...)
					BattleAudio:Sound_playEffect(BattleAudio.skill_chukaihundun)
				end, 0.3, AAT_Percent
			end
		}

		var_0_21(arg_34_0, arg_34_1, arg_34_2, arg_34_3, var_34_0)
	end,
	[49] = function(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
		local var_37_0 = {
			time = 0.725,
			effectName = "faqi_cheng_bailianjue",
			scale = 1.3,
			point = ccp(0, 180),
			shake = shakeVertical,
			list = function(...)
				return function(...)
					BattleAudio:Sound_playEffect(BattleAudio.skill_bailianjue)
				end, 0.3, AAT_Percent
			end
		}

		var_0_21(arg_37_0, arg_37_1, arg_37_2, arg_37_3, var_37_0)
	end,
	[64] = function(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
		local var_40_0 = {
			time = 0.5,
			effectName = "changbing_zi_liuermihou",
			scale = 1.1,
			point = ccp(0, 20),
			shake = shakeHorizontal,
			list = function(...)
				return function(...)
					shakeVertical(arg_40_1:getParent(), 15)
					BattleAudio:Sound_playEffect(BattleAudio.skill_chukaihundun)
				end, 0.31, AAT_Percent
			end
		}

		var_0_21(arg_40_0, arg_40_1, arg_40_2, arg_40_3, var_40_0)
	end,
	[65] = function(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
		local var_43_0 = {
			time = 0.5,
			effectName = "changbing_zi_xingtian",
			scale = 1.1,
			point = ccp(0, 20),
			shake = shakeVertical,
			list = function(...)
				return function(...)
					BattleAudio:Sound_playEffect(BattleAudio.skill_chukaihundun)
				end, 0.3, AAT_Percent
			end
		}

		var_0_21(arg_43_0, arg_43_1, arg_43_2, arg_43_3, var_43_0)
	end,
	[20] = function(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
		local var_46_0 = BattleData:getDisplayNode(arg_46_0.position)
		local var_46_1 = {
			time = 0.2,
			effectName = "faqi_lan_hanyuejue",
			scale = 1.3,
			point = ccp(var_46_0.isHero and 20 or -20, 170),
			shake = shakeVertical,
			sound = BattleAudio.skill_hanyuejue2,
			list = function(...)
				return function(...)
					BattleAudio:Sound_playEffect(BattleAudio.skill_hanyuejue1)
				end, 2e-06, AAT_Percent
			end
		}

		var_0_21(arg_46_0, arg_46_1, arg_46_2, arg_46_3, var_46_1)
	end,
	[16] = function(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
		local var_49_0 = BattleData:getDisplayNode(arg_49_0.position)
		local var_49_1 = {
			time = 0.4,
			effectName = "changbing_lan_honglianyehuo",
			point = ccp(var_49_0.isHero and -20 or 20, 200),
			shake = shakeVertical,
			sound = BattleAudio.skill_honglianyehuo
		}

		var_0_21(arg_49_0, arg_49_1, arg_49_2, arg_49_3, var_49_1, true)
	end,
	[39] = function(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
		local var_50_0 = {
			time = 0.3870967741935484,
			effectName = "changbing_lan_zhendiyiji",
			scale = 1.3,
			point = ccp(0, 190),
			shake = shakeVertical,
			sound = BattleAudio.skill_zhendiyiji
		}

		var_0_21(arg_50_0, arg_50_1, arg_50_2, arg_50_3, var_50_0)
	end,
	[27] = function(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
		BattleAudio:Sound_playEffect(BattleAudio.skill_jiulizhanhun)

		local var_51_0 = {
			time = 0.43478260869565216,
			effectName = "changbing_zi_jiulizhanhun",
			scale = 1.2,
			point = ccp(0, 150),
			shake = shakeVertical
		}

		var_0_21(arg_51_0, arg_51_1, arg_51_2, arg_51_3, var_51_0)
	end,
	[42] = function(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
		local var_52_0 = {
			time = 0.7027027027027027,
			effectName = "changbing_zi_poxiefatong",
			scale = 1.3,
			point = ccp(0, 190),
			shake = shakeVertical,
			list = function(...)
				return function(...)
					BattleAudio:Sound_playEffect(BattleAudio.skill_poxiefatong)
				end, 0.21621621621621623, AAT_Percent
			end
		}

		var_0_21(arg_52_0, arg_52_1, arg_52_2, arg_52_3, var_52_0)
	end,
	[26] = function(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
		BattleAudio:Sound_playEffect(BattleAudio.skill_qianyupojian)

		local var_55_0 = BattleData:getDisplayNode(arg_55_0.position)
		local var_55_1 = {
			time = 0.6,
			effectName = "changbing_zi_qianyupojia",
			scale = 1.2,
			point = ccp(var_55_0.isHero and -50 or 50, 190),
			shake = shakeVertical,
			list = function(...)
				return function(...)
					arg_55_1:getParent():setPosition(0, 0)
					shakeVertical(arg_55_1:getParent(), 5)
				end, 0.2, AAT_Percent
			end
		}

		var_0_21(arg_55_0, arg_55_1, arg_55_2, arg_55_3, var_55_1)
	end,
	[12] = function(arg_58_0, arg_58_1, arg_58_2, arg_58_3)
		local var_58_0 = {
			time = 0.8,
			speed = 1.3,
			effectName = "duanbing_lan_xuanyuanji",
			scale = 1.4,
			point = ccp(0, 200),
			shake = shakeVertical,
			sound = BattleAudio.skill_xuanyuanji
		}

		var_0_21(arg_58_0, arg_58_1, arg_58_2, arg_58_3, var_58_0)
	end,
	[6] = function(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
		local var_59_0 = {
			time = 0.3,
			speed = 1,
			effectName = "faqi_lv_xinyanjue",
			point = ccp(0, 220),
			shake = shakeVertical,
			sound = BattleAudio.skill_xinyanjue
		}

		var_0_21(arg_59_0, arg_59_1, arg_59_2, arg_59_3, var_59_0)
	end,
	[34] = function(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
		BattleAudio:Sound_playEffect(BattleAudio.skill_fengzhenbahuang)

		local var_60_0 = {
			time = 0.3,
			effectName = "changbing_cheng_fengzhenbafang",
			scale = 1.2,
			point = ccp(0, 150),
			shake = shakeVertical
		}

		var_0_21(arg_60_0, arg_60_1, arg_60_2, arg_60_3, var_60_0)
	end,
	[15] = function(arg_61_0, arg_61_1, arg_61_2, arg_61_3)
		local var_61_0 = BattleData:getDisplayNode(arg_61_0.position)
		local var_61_1 = {
			time = 0.4,
			effectName = "changbing_lan_jiutouduanhun",
			scale = 1.5,
			point = ccp(var_61_0.isHero and 30 or -30, 150),
			shake = shakeVertical,
			sound = BattleAudio.skill_jiutouduanhun
		}

		var_0_21(arg_61_0, arg_61_1, arg_61_2, arg_61_3, var_61_1)
	end,
	[2] = function(arg_62_0, arg_62_1, arg_62_2, arg_62_3)
		local var_62_0 = {
			time = 0.5,
			effectName = "duanbing_lv_duanhunci",
			point = ccp(0, 140),
			shake = shakeVertical,
			sound = BattleAudio.skill_duanhunci
		}

		var_0_21(arg_62_0, arg_62_1, arg_62_2, arg_62_3, var_62_0)
	end,
	[44] = function(arg_63_0, arg_63_1, arg_63_2, arg_63_3)
		local var_63_0 = {
			time = 0.34615384615384615,
			effectName = "faqi_zi_weizhenjue",
			scale = 1.3,
			point = ccp(0, 190),
			shake = shakeVertical,
			sound = BattleAudio.skill_weizhenjue
		}

		var_0_21(arg_63_0, arg_63_1, arg_63_2, arg_63_3, var_63_0, true)
	end,
	[32] = function(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
		local var_64_0 = {
			time = 0.7,
			effectName = "duanbing_cheng_yinyangdao",
			scale = 1.1,
			point = ccp(0, 170),
			shake = shakeVertical,
			sound = BattleAudio.skill_yinyangdao
		}

		var_0_21(arg_64_0, arg_64_1, arg_64_2, arg_64_3, var_64_0)
	end,
	[22] = function(arg_65_0, arg_65_1, arg_65_2, arg_65_3)
		BattleAudio:Sound_playEffect(BattleAudio.skill_fengshenji1)

		local var_65_0 = {
			time = 0.7,
			effectName = "duanbing_zi_fengshenji",
			speed = 1.1,
			point = ccp(0, 150),
			shake = shakeHorizontal,
			list = function(...)
				return function(...)
					arg_65_1:getParent():setPosition(0, 0)
					shakeHorizontal(arg_65_1:getParent(), 5)
					BattleAudio:Sound_playEffect(BattleAudio.skill_fengshenji2)
				end, 0.3, AAT_Percent
			end
		}

		var_0_21(arg_65_0, arg_65_1, arg_65_2, arg_65_3, var_65_0, true)
	end,
	[60] = function(arg_68_0, arg_68_1, arg_68_2, arg_68_3)
		local var_68_0 = {
			time = 0.7,
			effectName = "duanbing_cheng_shennongji",
			speed = 1,
			point = ccp(0, 150),
			shake = shakeHorizontal,
			list = function(...)
				return function(...)
					arg_68_1:getParent():setPosition(0, 0)
					shakeHorizontal(arg_68_1:getParent(), 5)
					BattleAudio:Sound_playEffect(BattleAudio.skill_poxiefatong)
				end, 0.3, AAT_Percent
			end
		}

		var_0_21(arg_68_0, arg_68_1, arg_68_2, arg_68_3, var_68_0)
	end,
	[52] = function(arg_71_0, arg_71_1, arg_71_2, arg_71_3)
		BattleAudio:Sound_playEffect(BattleAudio.skill_fengshenji1)

		local var_71_0 = {
			time = 0.7,
			effectName = "faqi_cheng_anrenjue",
			speed = 1,
			point = ccp(0, 50),
			shake = shakeHorizontal,
			list = function(...)
				return function(...)
					arg_71_1:getParent():setPosition(0, 0)
					shakeHorizontal(arg_71_1:getParent(), 5)
					BattleAudio:Sound_playEffect(BattleAudio.skill_fengshenji2)
				end, 0.5, AAT_Percent
			end
		}

		var_0_21(arg_71_0, arg_71_1, arg_71_2, arg_71_3, var_71_0)
	end,
	[54] = function(arg_74_0, arg_74_1, arg_74_2, arg_74_3)
		BattleAudio:Sound_playEffect(BattleAudio.skill_hengsaoqianjun)

		local var_74_0 = {
			time = 0.7,
			effectName = "changbing_cheng_jiuchiduoming",
			scale = 1,
			point = ccp(0, 20),
			shake = shakeVertical
		}

		var_0_21(arg_74_0, arg_74_1, arg_74_2, arg_74_3, var_74_0)
	end,
	[55] = function(arg_75_0, arg_75_1, arg_75_2, arg_75_3)
		local var_75_0 = {
			time = 0.8,
			effectName = "changbing_cheng_xiangmoyiji",
			scale = 1,
			point = ccp(0, 20),
			shake = shakeVertical,
			list = function(...)
				return function(...)
					BattleAudio:Sound_playEffect(BattleAudio.skill_niumojin2)
				end, 0.5, AAT_Percent
			end
		}

		var_0_21(arg_75_0, arg_75_1, arg_75_2, arg_75_3, var_75_0, true)
	end,
	[13] = function(arg_78_0, arg_78_1, arg_78_2, arg_78_3)
		BattleAudio:Sound_playEffect(BattleAudio.skill_hengsaoqianjun)
		var_0_19(arg_78_0.affectList, function(arg_79_0, arg_79_1)
			local var_79_0 = "changbing_lan_henshaoqianjun"
			local var_79_1 = BattleData:getDisplayNode(arg_79_0.position)
			local var_79_2 = originalScale()
			local var_79_3 = ccp(0, 150)
			local var_79_4
			local var_79_5 = {
				function()
					if arg_79_1 then
						arg_78_3()
					end

					var_79_4:removeFromParentAndCleanup(true)
				end,
				1,
				AAT_Percent
			}

			var_0_2(arg_79_0, {
				0.2,
				0.3,
				0.5
			}, {
				0.1,
				0.3,
				0.6
			}, arg_78_2, var_79_5, function()
				arg_78_1:getParent():setPosition(0, 0)
				shakeVertical(arg_78_1:getParent(), 10)
			end)

			var_79_4 = BattleSkeleton:addEffect({
				parent = var_79_1,
				effectName = var_79_0,
				position = var_79_3,
				callbacklist = var_79_5,
				scale = var_79_2
			})

			if var_79_1.isHero then
				var_79_4:setRotationY(180)
			end
		end)
	end,
	[14] = function(arg_82_0, arg_82_1, arg_82_2, arg_82_3)
		BattleAudio:Sound_playEffect(BattleAudio.skill_sihaichaoyong)

		local var_82_0 = BattleData:getDisplayNode(arg_82_0.position)
		local var_82_1, var_82_2 = var_0_17(var_82_0.isHero, 12)
		local var_82_3 = CCArray:create()
		local var_82_4 = true

		for iter_82_0, iter_82_1 in pairs(var_82_1) do
			var_82_3:addObject(CCCallFunc:create(function()
				local var_83_0 = "changbing_lan_sihaichaoyong"
				local var_83_1 = 1 * Adapter.MinScale
				local var_83_2 = iter_82_1
				local var_83_3

				var_83_3 = BattleSkeleton:addEffect({
					parent = var_82_0:getParent(),
					effectName = var_83_0,
					position = ccp(var_83_2.x, var_83_2.y + 50 * Adapter.MinScale * orderScale_num(var_83_2)),
					callbacklist = {
						function()
							arg_82_1:getParent():setPosition(0, 0)
							shakeVertical(arg_82_1:getParent(), 3)

							if var_82_4 then
								var_82_4 = false

								var_0_20(arg_82_0.affectList, arg_82_0.position, 10)
							end
						end,
						0.55,
						AAT_Percent,
						function()
							var_83_3:removeFromParentAndCleanup(true)
						end,
						1,
						AAT_Percent
					},
					scale = var_83_1
				})

				var_83_3:setRotationY(var_82_2)
				var_0_16(var_83_3, iter_82_1)
			end))
			var_82_3:addObject(CCDelayTime:create(0.05 * BattleSpeed))
		end

		var_82_3:addObject(CCCallFunc:create(function()
			for iter_86_0, iter_86_1 in pairs(arg_82_0.affectList) do
				arg_82_2(iter_86_1, true)
			end

			arg_82_3()
		end))
		arg_82_1:runAction(CCSequence:create(var_82_3))
	end,
	[62] = function(arg_87_0, arg_87_1, arg_87_2, arg_87_3)
		BattleAudio:Sound_playEffect(BattleAudio.skill_sihaichaoyong)

		local var_87_0 = BattleData:getDisplayNode(arg_87_0.position)
		local var_87_1, var_87_2 = var_0_17(var_87_0.isHero, 12)
		local var_87_3 = CCArray:create()
		local var_87_4 = true

		for iter_87_0, iter_87_1 in pairs(var_87_1) do
			var_87_3:addObject(CCCallFunc:create(function()
				local var_88_0 = "changbing_zi_pangu"
				local var_88_1 = 1 * Adapter.MinScale
				local var_88_2 = iter_87_1
				local var_88_3

				var_88_3 = BattleSkeleton:addEffect({
					parent = var_87_0:getParent(),
					effectName = var_88_0,
					position = ccp(var_88_2.x, var_88_2.y),
					callbacklist = {
						function()
							arg_87_1:getParent():setPosition(0, 0)
							shakeVertical(arg_87_1:getParent(), 3)

							if var_87_4 then
								var_87_4 = false

								var_0_20(arg_87_0.affectList, arg_87_0.position, 10)
							end
						end,
						0.55,
						AAT_Percent,
						function()
							var_88_3:removeFromParentAndCleanup(true)
						end,
						1,
						AAT_Percent
					},
					scale = var_88_1
				})

				var_88_3:setRotationY(var_87_2)
				var_0_16(var_88_3, iter_87_1)
			end))
			var_87_3:addObject(CCDelayTime:create(0.05 * BattleSpeed))
		end

		var_87_3:addObject(CCCallFunc:create(function()
			for iter_91_0, iter_91_1 in pairs(arg_87_0.affectList) do
				arg_87_2(iter_91_1, true)
			end

			arg_87_3()
		end))
		arg_87_1:runAction(CCSequence:create(var_87_3))
	end,
	[17] = function(arg_92_0, arg_92_1, arg_92_2, arg_92_3)
		local var_92_0 = BattleData:getDisplayNode(arg_92_0.position)
		local var_92_1, var_92_2 = var_0_17(var_92_0.isHero, 12)
		local var_92_3 = CCArray:create()
		local var_92_4 = true

		for iter_92_0, iter_92_1 in pairs(var_92_1) do
			var_92_3:addObject(CCCallFunc:create(function()
				BattleAudio:Sound_playEffect(BattleAudio.skill_jiuyangjue)

				local var_93_0 = "faqi_lan_jiuyangjue"
				local var_93_1 = 1 * Adapter.MinScale
				local var_93_2 = ccp(iter_92_1.x, iter_92_1.y + 50 * Adapter.MinScale * orderScale_num(iter_92_1))
				local var_93_3

				var_93_3 = BattleSkeleton:addEffect({
					parent = var_92_0:getParent(),
					effectName = var_93_0,
					position = var_93_2,
					callbacklist = {
						function()
							arg_92_1:getParent():setPosition(0, 0)
							shakeVertical(arg_92_1:getParent(), 10, 0.02)

							if var_92_4 then
								var_92_4 = false

								var_0_20(arg_92_0.affectList, arg_92_0.position)
							end
						end,
						0.5,
						AAT_Percent,
						function()
							var_93_3:removeFromParentAndCleanup(true)
						end,
						1,
						AAT_Percent
					},
					scale = var_93_1
				})

				var_93_3:setRotationY(var_92_2)
				var_0_16(var_93_3, iter_92_1)
			end))
			var_92_3:addObject(CCDelayTime:create(0.05 * BattleSpeed))
		end

		var_92_3:addObject(CCCallFunc:create(function()
			for iter_96_0, iter_96_1 in pairs(arg_92_0.affectList) do
				arg_92_2(iter_96_1, true)
			end

			arg_92_3()
		end))
		arg_92_1:runAction(CCSequence:create(var_92_3))
	end,
	[56] = function(arg_97_0, arg_97_1, arg_97_2, arg_97_3)
		local var_97_0 = BattleData:getDisplayNode(arg_97_0.position)
		local var_97_1, var_97_2 = var_0_17(var_97_0.isHero, 12)
		local var_97_3 = CCArray:create()
		local var_97_4 = true

		for iter_97_0, iter_97_1 in pairs(var_97_1) do
			var_97_3:addObject(CCCallFunc:create(function()
				BattleAudio:Sound_playEffect(BattleAudio.skill_jiuyangjue)

				local var_98_0 = "changbing_cheng_fohuozhengdao"
				local var_98_1 = 1 * Adapter.MinScale
				local var_98_2 = ccp(iter_97_1.x, iter_97_1.y + 0 * Adapter.MinScale * orderScale_num(iter_97_1))
				local var_98_3

				var_98_3 = BattleSkeleton:addEffect({
					parent = var_97_0:getParent(),
					effectName = var_98_0,
					position = var_98_2,
					callbacklist = {
						function()
							arg_97_1:getParent():setPosition(0, 0)
							shakeVertical(arg_97_1:getParent(), 10, 0.02)

							if var_97_4 then
								var_97_4 = false

								var_0_20(arg_97_0.affectList, arg_97_0.position)
							end
						end,
						0.85,
						AAT_Percent,
						function()
							var_98_3:removeFromParentAndCleanup(true)
						end,
						1,
						AAT_Percent
					},
					scale = var_98_1
				})

				var_98_3:setRotationY(var_97_2)
				var_0_16(var_98_3, iter_97_1)
			end))
			var_97_3:addObject(CCDelayTime:create(0.05 * BattleSpeed))
		end

		var_97_3:addObject(CCCallFunc:create(function()
			for iter_101_0, iter_101_1 in pairs(arg_97_0.affectList) do
				arg_97_2(iter_101_1, true)
			end

			arg_97_3()
		end))
		arg_97_1:runAction(CCSequence:create(var_97_3))
	end,
	[45] = function(arg_102_0, arg_102_1, arg_102_2, arg_102_3)
		local var_102_0 = BattleData:getDisplayNode(arg_102_0.position)
		local var_102_1, var_102_2 = var_0_17(var_102_0.isHero, 10)
		local var_102_3 = true
		local var_102_4 = CCArray:create()

		for iter_102_0, iter_102_1 in pairs(var_102_1) do
			var_102_4:addObject(CCCallFunc:create(function()
				BattleAudio:Sound_playEffect(BattleAudio.skill_fanjiangdaohai)

				local var_103_0 = "changbing_zi_fanjiangdaohai"
				local var_103_1 = 1 * Adapter.MinScale
				local var_103_2 = ccp(iter_102_1.x, iter_102_1.y + 40 * Adapter.MinScale * orderScale_num(iter_102_1))
				local var_103_3

				var_103_3 = BattleSkeleton:addEffect({
					parent = var_102_0:getParent(),
					effectName = var_103_0,
					position = var_103_2,
					callbacklist = {
						function()
							arg_102_1:getParent():setPosition(0, 0)
							shakeVertical(arg_102_1:getParent(), 10)

							if var_102_3 then
								var_102_3 = false

								var_0_20(arg_102_0.affectList, arg_102_0.position)
							end
						end,
						0.5,
						AAT_Percent,
						function()
							var_103_3:removeFromParentAndCleanup(true)
						end,
						1,
						AAT_Percent
					},
					scale = var_103_1
				})

				var_103_3:setRotationY(var_102_2)
				var_0_16(var_103_3, iter_102_1)
			end))
			var_102_4:addObject(CCDelayTime:create(0.1 * BattleSpeed))
		end

		var_102_4:addObject(CCCallFunc:create(function()
			for iter_106_0, iter_106_1 in pairs(arg_102_0.affectList) do
				arg_102_2(iter_106_1, true)
			end

			arg_102_3()
		end))
		arg_102_1:runAction(CCSequence:create(var_102_4))
	end,
	[68] = function(arg_107_0, arg_107_1, arg_107_2, arg_107_3)
		local var_107_0 = BattleData:getDisplayNode(arg_107_0.position)
		local var_107_1
		local var_107_2
		local var_107_3

		if var_107_0.isHero then
			var_107_1 = var_0_15(var_0_8(), 20)
			var_107_3 = 0
		else
			var_107_1 = var_0_15(var_0_7(), 20)
			var_107_3 = 180
		end

		local var_107_4 = true
		local var_107_5 = CCArray:create()

		for iter_107_0, iter_107_1 in pairs(var_107_1) do
			var_107_5:addObject(CCCallFunc:create(function()
				BattleAudio:Sound_playEffect(BattleAudio.skill_fanjiangdaohai)

				local var_108_0 = "changbing_zi_gonggong"
				local var_108_1 = 1 * Adapter.MinScale
				local var_108_2 = ccp(iter_107_1.x, iter_107_1.y + 40 * Adapter.MinScale * orderScale_num(iter_107_1))
				local var_108_3

				var_108_3 = BattleSkeleton:addEffect({
					parent = var_107_0:getParent(),
					effectName = var_108_0,
					position = var_108_2,
					callbacklist = {
						function()
							arg_107_1:getParent():setPosition(0, 0)
							shakeVertical(arg_107_1:getParent(), 10)

							if var_107_4 then
								var_107_4 = false

								var_0_20(arg_107_0.affectList, arg_107_0.position)
							end
						end,
						0.5,
						AAT_Percent,
						function()
							var_108_3:removeFromParentAndCleanup(true)
						end,
						1,
						AAT_Percent
					},
					scale = var_108_1
				})

				var_108_3:setRotationY(var_107_3)
				var_0_16(var_108_3, iter_107_1)
			end))
			var_107_5:addObject(CCDelayTime:create(0.05 * BattleSpeed))
		end

		var_107_5:addObject(CCCallFunc:create(function()
			for iter_111_0, iter_111_1 in pairs(arg_107_0.affectList) do
				arg_107_2(iter_111_1, true)
			end

			arg_107_3()
		end))
		arg_107_1:runAction(CCSequence:create(var_107_5))
	end,
	[61] = function(arg_112_0, arg_112_1, arg_112_2, arg_112_3)
		local var_112_0 = BattleData:getDisplayNode(arg_112_0.position)
		local var_112_1
		local var_112_2
		local var_112_3

		if var_112_0.isHero then
			var_112_1 = var_0_15(var_0_8(), 20)
			var_112_3 = 0
		else
			var_112_1 = var_0_15(var_0_7(), 20)
			var_112_3 = 180
		end

		local var_112_4 = true
		local var_112_5 = CCArray:create()

		for iter_112_0, iter_112_1 in pairs(var_112_1) do
			var_112_5:addObject(CCCallFunc:create(function()
				BattleAudio:Sound_playEffect(BattleAudio.skill_fanjiangdaohai)

				local var_113_0 = "fashi_zi_taotie"
				local var_113_1 = 1 * Adapter.MinScale
				local var_113_2 = ccp(iter_112_1.x, iter_112_1.y + 20 * Adapter.MinScale * orderScale_num(iter_112_1))
				local var_113_3

				var_113_3 = BattleSkeleton:addEffect({
					parent = var_112_0:getParent(),
					effectName = var_113_0,
					position = var_113_2,
					callbacklist = {
						function()
							arg_112_1:getParent():setPosition(0, 0)
							shakeVertical(arg_112_1:getParent(), 10)

							if var_112_4 then
								var_112_4 = false

								var_0_20(arg_112_0.affectList, arg_112_0.position)
							end
						end,
						0.5,
						AAT_Percent,
						function()
							var_113_3:removeFromParentAndCleanup(true)
						end,
						1,
						AAT_Percent
					},
					scale = var_113_1
				})

				var_113_3:setRotationY(var_112_3)
				var_0_16(var_113_3, iter_112_1)
			end))
			var_112_5:addObject(CCDelayTime:create(0.05 * BattleSpeed))
		end

		var_112_5:addObject(CCCallFunc:create(function()
			for iter_116_0, iter_116_1 in pairs(arg_112_0.affectList) do
				arg_112_2(iter_116_1, true)
			end

			arg_112_3()
		end))
		arg_112_1:runAction(CCSequence:create(var_112_5))
	end,
	[70] = function(arg_117_0, arg_117_1, arg_117_2, arg_117_3)
		local var_117_0 = BattleData:getDisplayNode(arg_117_0.position)
		local var_117_1
		local var_117_2
		local var_117_3

		if var_117_0.isHero then
			var_117_1 = var_0_15(var_0_8(), 20)
			var_117_3 = 0
		else
			var_117_1 = var_0_15(var_0_7(), 20)
			var_117_3 = 180
		end

		local var_117_4 = true
		local var_117_5 = CCArray:create()

		for iter_117_0, iter_117_1 in pairs(var_117_1) do
			var_117_5:addObject(CCCallFunc:create(function()
				BattleAudio:Sound_playEffect(BattleAudio.skill_fanjiangdaohai)

				local var_118_0 = "fashi_zi_tieshangongzhu"
				local var_118_1 = 1 * Adapter.MinScale
				local var_118_2 = ccp(iter_117_1.x, iter_117_1.y + 1 * Adapter.MinScale * orderScale_num(iter_117_1))
				local var_118_3

				var_118_3 = BattleSkeleton:addEffect({
					parent = var_117_0:getParent(),
					effectName = var_118_0,
					position = var_118_2,
					callbacklist = {
						function()
							arg_117_1:getParent():setPosition(0, 0)
							shakeVertical(arg_117_1:getParent(), 10)

							if var_117_4 then
								var_117_4 = false

								var_0_20(arg_117_0.affectList, arg_117_0.position)
							end
						end,
						0.5,
						AAT_Percent,
						function()
							var_118_3:removeFromParentAndCleanup(true)
						end,
						1,
						AAT_Percent
					},
					scale = var_118_1
				})

				var_118_3:setRotationY(var_117_3)
				var_0_16(var_118_3, iter_117_1)
			end))
			var_117_5:addObject(CCDelayTime:create(0.05 * BattleSpeed))
		end

		var_117_5:addObject(CCCallFunc:create(function()
			for iter_121_0, iter_121_1 in pairs(arg_117_0.affectList) do
				arg_117_2(iter_121_1, true)
			end

			arg_117_3()
		end))
		arg_117_1:runAction(CCSequence:create(var_117_5))
	end,
	[41] = function(arg_122_0, arg_122_1, arg_122_2, arg_122_3)
		local var_122_0 = BattleData:getDisplayNode(arg_122_0.position)
		local var_122_1, var_122_2 = var_0_17(var_122_0.isHero, 8)
		local var_122_3 = true
		local var_122_4 = CCArray:create()

		for iter_122_0, iter_122_1 in pairs(var_122_1) do
			var_122_4:addObject(CCCallFunc:create(function()
				BattleAudio:Sound_playEffect(BattleAudio.skill_huangshazhang)

				local var_123_0 = "duanbing_zi_huashazhang"
				local var_123_1 = 1 * Adapter.MinScale
				local var_123_2 = ccp(iter_122_1.x, iter_122_1.y + 60 * Adapter.MinScale * orderScale_num(iter_122_1))
				local var_123_3

				var_123_3 = BattleSkeleton:addEffect({
					parent = var_122_0:getParent(),
					effectName = var_123_0,
					position = var_123_2,
					callbacklist = {
						function()
							arg_122_1:getParent():setPosition(0, 0)
							shakeVertical(arg_122_1:getParent(), 10)

							if var_122_3 then
								var_122_3 = false

								var_0_20(arg_122_0.affectList, arg_122_0.position)
							end
						end,
						0.5,
						AAT_Percent,
						function()
							var_123_3:removeFromParentAndCleanup(true)
						end,
						1,
						AAT_Percent
					},
					scale = var_123_1
				})

				var_123_3:setRotationY(var_122_2)
				var_0_16(var_123_3, iter_122_1)
			end))
			var_122_4:addObject(CCDelayTime:create(0.1 * BattleSpeed))
		end

		var_122_4:addObject(CCCallFunc:create(function()
			for iter_126_0, iter_126_1 in pairs(arg_122_0.affectList) do
				arg_122_2(iter_126_1, true)
			end

			arg_122_3()
		end))
		arg_122_1:runAction(CCSequence:create(var_122_4))
	end,
	[37] = function(arg_127_0, arg_127_1, arg_127_2, arg_127_3)
		local var_127_0 = BattleData:getDisplayNode(arg_127_0.position)
		local var_127_1, var_127_2 = var_0_18(var_127_0.isHero, 12)
		local var_127_3 = true
		local var_127_4 = CCArray:create()

		for iter_127_0, iter_127_1 in pairs(var_127_1) do
			var_127_4:addObject(CCCallFunc:create(function()
				BattleAudio:Sound_playEffect(BattleAudio.skill_tianfashenlei)

				local var_128_0 = "changbing_lan_tianfashenlei"
				local var_128_1 = 1.2 * Adapter.MinScale
				local var_128_2 = ccp(iter_127_1.x, iter_127_1.y + 60 * Adapter.MinScale * orderScale_num(iter_127_1))
				local var_128_3

				var_128_3 = BattleSkeleton:addEffect({
					parent = var_127_0:getParent(),
					effectName = var_128_0,
					position = var_128_2,
					callbacklist = {
						function()
							arg_127_1:getParent():setPosition(0, 0)
							shakeVertical(arg_127_1:getParent(), 10)

							if var_127_3 then
								var_127_3 = false

								var_0_20(arg_127_0.affectList, arg_127_0.position)
							end
						end,
						0.5,
						AAT_Percent,
						function()
							var_128_3:removeFromParentAndCleanup(true)
						end,
						1,
						AAT_Percent
					},
					scale = var_128_1
				})

				var_128_3:setRotationY(var_127_2)
				var_0_16(var_128_3, iter_127_1)
			end))
			var_127_4:addObject(CCDelayTime:create(0.1 * BattleSpeed))
		end

		var_127_4:addObject(CCCallFunc:create(function()
			for iter_131_0, iter_131_1 in pairs(arg_127_0.affectList) do
				arg_127_2(iter_131_1, true)
			end

			arg_127_3()
		end))
		arg_127_1:runAction(CCSequence:create(var_127_4))
	end,
	[9] = function(arg_132_0, arg_132_1, arg_132_2, arg_132_3)
		local var_132_0 = BattleData:getDisplayNode(arg_132_0.position)
		local var_132_1, var_132_2 = var_0_18(var_132_0.isHero, 8)
		local var_132_3 = CCArray:create()
		local var_132_4 = true

		for iter_132_0, iter_132_1 in pairs(var_132_1) do
			var_132_3:addObject(CCCallFunc:create(function()
				BattleAudio:Sound_playEffect(BattleAudio.skill_wuguidong)

				local var_133_0 = "duanbing_lan_wuguidong"
				local var_133_1 = 1 * Adapter.MinScale
				local var_133_2 = ccp(iter_132_1.x, iter_132_1.y + 40 * Adapter.MinScale * orderScale_num(iter_132_1))
				local var_133_3

				var_133_3 = BattleSkeleton:addEffect({
					parent = var_132_0:getParent(),
					effectName = var_133_0,
					position = var_133_2,
					callbacklist = {
						function()
							arg_132_1:getParent():setPosition(0, 0)
							shakeVertical(arg_132_1:getParent(), 10)

							if var_132_4 then
								var_132_4 = false

								var_0_20(arg_132_0.affectList, arg_132_0.position)
							end
						end,
						0.5,
						AAT_Percent,
						function()
							var_133_3:removeFromParentAndCleanup(true)
						end,
						1,
						AAT_Percent
					},
					scale = var_133_1
				})

				var_133_3:setRotationY(var_132_2)
				var_0_16(var_133_3, iter_132_1)
			end))
			var_132_3:addObject(CCDelayTime:create(0.1 * BattleSpeed))
		end

		var_132_3:addObject(CCDelayTime:create(0.2 * BattleSpeed))
		var_132_3:addObject(CCCallFunc:create(function()
			for iter_136_0, iter_136_1 in pairs(arg_132_0.affectList) do
				arg_132_2(iter_136_1, true)
			end

			arg_132_3()
		end))
		arg_132_1:runAction(CCSequence:create(var_132_3))
	end,
	[47] = function(arg_137_0, arg_137_1, arg_137_2, arg_137_3)
		local var_137_0 = BattleData:getDisplayNode(arg_137_0.position)
		local var_137_1
		local var_137_2
		local var_137_3

		if var_137_0.isHero then
			var_137_1 = var_0_15(var_0_8(), 13)
			var_137_3 = 0
		else
			var_137_1 = var_0_15(var_0_7(), 13)
			var_137_3 = 180
		end

		local var_137_4 = CCArray:create()
		local var_137_5 = true

		for iter_137_0, iter_137_1 in pairs(var_137_1) do
			var_137_4:addObject(CCCallFunc:create(function()
				BattleAudio:Sound_playEffect(BattleAudio.skill_nuzhanjiuli)

				local var_138_0 = "changbing_cheng_nuzhanjiuli"
				local var_138_1 = 1 * Adapter.MinScale
				local var_138_2 = ccp(iter_137_1.x, iter_137_1.y + 60 * Adapter.MinScale * orderScale_num(iter_137_1))
				local var_138_3

				var_138_3 = BattleSkeleton:addEffect({
					parent = var_137_0:getParent(),
					effectName = var_138_0,
					position = var_138_2,
					callbacklist = {
						function()
							arg_137_1:getParent():setPosition(0, 0)
							shakeVertical(arg_137_1:getParent(), 10, 0.02)

							if var_137_5 then
								var_137_5 = false

								var_0_20(arg_137_0.affectList, arg_137_0.position)
							end
						end,
						0.5,
						AAT_Percent,
						function()
							var_138_3:removeFromParentAndCleanup(true)
						end,
						1,
						AAT_Percent
					},
					scale = var_138_1
				})

				var_138_3:setRotationY(var_137_3)
				var_0_16(var_138_3, iter_137_1)
			end))
			var_137_4:addObject(CCDelayTime:create(0.08 * BattleSpeed))
		end

		var_137_4:addObject(CCCallFunc:create(function()
			for iter_141_0, iter_141_1 in pairs(arg_137_0.affectList) do
				arg_137_2(iter_141_1, true)
			end

			arg_137_3()
		end))
		arg_137_1:runAction(CCSequence:create(var_137_4))
	end,
	[31] = function(arg_142_0, arg_142_1, arg_142_2, arg_142_3)
		local var_142_0 = BattleData:getDisplayNode(arg_142_0.position)
		local var_142_1
		local var_142_2
		local var_142_3

		if var_142_0.isHero then
			var_142_1 = var_0_15(var_0_8(), 8)
			var_142_3 = 0
		else
			var_142_1 = var_0_15(var_0_7(), 8)
			var_142_3 = 180
		end

		local var_142_4 = CCArray:create()
		local var_142_5 = true

		for iter_142_0, iter_142_1 in pairs(var_142_1) do
			var_142_4:addObject(CCCallFunc:create(function()
				local var_143_0 = "duanbing_cheng_zhizunling"
				local var_143_1 = 1.15 * Adapter.MinScale
				local var_143_2 = ccp(iter_142_1.x, iter_142_1.y + 60 * Adapter.MinScale * orderScale_num(iter_142_1))
				local var_143_3

				var_143_3 = BattleSkeleton:addEffect({
					parent = var_142_0:getParent(),
					effectName = var_143_0,
					position = var_143_2,
					callbacklist = {
						function()
							arg_142_1:getParent():setPosition(0, 0)
							shakeVertical(arg_142_1:getParent(), 10)
							BattleAudio:Sound_playEffect(BattleAudio.skill_zhizunling)

							if var_142_5 then
								var_142_5 = false

								var_0_20(arg_142_0.affectList, arg_142_0.position)
							end
						end,
						0.2,
						AAT_Percent,
						function()
							var_143_3:removeFromParentAndCleanup(true)
						end,
						1,
						AAT_Percent
					},
					scale = var_143_1
				})

				var_143_3:setRotationY(var_142_3)
				var_0_16(var_143_3, iter_142_1)
			end))
			var_142_4:addObject(CCDelayTime:create(0.13 * BattleSpeed))
		end

		var_142_4:addObject(CCCallFunc:create(function()
			for iter_146_0, iter_146_1 in pairs(arg_142_0.affectList) do
				arg_142_2(iter_146_1, true)
			end

			arg_142_3()
		end))
		arg_142_1:runAction(CCSequence:create(var_142_4))
	end,
	[48] = function(arg_147_0, arg_147_1, arg_147_2, arg_147_3)
		BattleAudio:Sound_playEffect(BattleAudio.skill_qibaojue1)

		local var_147_0 = BattleData:getDisplayNode(arg_147_0.position)

		local function var_147_1()
			local var_148_0
			local var_148_1
			local var_148_2

			if var_147_0.isHero then
				var_148_0 = var_0_15(var_0_8(), 20)
				var_148_2 = 0
			else
				var_148_0 = var_0_15(var_0_7(), 20)
				var_148_2 = 180
			end

			local var_148_3 = CCArray:create()
			local var_148_4 = true

			for iter_148_0, iter_148_1 in pairs(var_148_0) do
				var_148_3:addObject(CCCallFunc:create(function()
					if iter_148_0 < 6 then
						BattleAudio:Sound_playEffect(BattleAudio.skill_qibaojue2)
					end

					local var_149_0 = "faqi_cheng_qibaojue"
					local var_149_1 = 1 * Adapter.MinScale
					local var_149_2 = ccp(iter_148_1.x, iter_148_1.y + 60 * Adapter.MinScale * orderScale_num(iter_148_1))
					local var_149_3

					var_149_3 = BattleSkeleton:addEffect({
						speed = 0.9,
						animation = "bao",
						parent = var_147_0:getParent(),
						effectName = var_149_0,
						position = var_149_2,
						callbacklist = {
							function()
								arg_147_1:getParent():setPosition(0, 0)
								shakeVertical(arg_147_1:getParent(), 10, 0.01)

								if var_148_4 then
									var_148_4 = false

									var_0_20(arg_147_0.affectList, arg_147_0.position)
								end
							end,
							0.5,
							AAT_Percent,
							function()
								var_149_3:removeFromParentAndCleanup(true)
							end,
							1,
							AAT_Percent
						},
						scale = var_149_1
					})

					var_149_3:setRotationY(var_148_2)
					var_0_16(var_149_3, iter_148_1)
				end))
				var_148_3:addObject(CCDelayTime:create(0.05 * BattleSpeed))
			end

			var_148_3:addObject(CCCallFunc:create(function()
				for iter_152_0, iter_152_1 in pairs(arg_147_0.affectList) do
					arg_147_2(iter_152_1, true)
				end

				arg_147_3()
			end))
			arg_147_1:runAction(CCSequence:create(var_148_3))
		end

		local var_147_2 = "faqi_cheng_qibaojue"
		local var_147_3 = 1 * Adapter.MinScale
		local var_147_4

		if var_147_0.isHero then
			var_147_4 = var_0_8()
			var_147_4 = ccp((var_147_4.area[1].x + var_147_4.area[2].x) / 2, (var_147_4.area[1].y + var_147_4.area[2].y) / 2)
		else
			var_147_4 = var_0_7()
			var_147_4 = ccp((var_147_4.area[1].x + var_147_4.area[2].x) / 2, (var_147_4.area[1].y + var_147_4.area[2].y) / 2)
		end

		local var_147_5

		var_147_5 = BattleSkeleton:addEffect({
			animation = "kongbao",
			parent = var_147_0:getParent(),
			effectName = var_147_2,
			position = ccp(var_147_4.x, var_147_4.y + 300 * Adapter.MinScale),
			callbacklist = {
				function()
					var_147_1()
				end,
				0.5,
				AAT_Percent,
				function()
					var_147_5:removeFromParentAndCleanup(true)
				end,
				1,
				AAT_Percent
			},
			scale = var_147_3
		})
	end,
	[24] = function(arg_155_0, arg_155_1, arg_155_2, arg_155_3)
		BattleAudio:Sound_playEffect(BattleAudio.skill_niumojin1)

		local var_155_0 = BattleData:getDisplayNode(arg_155_0.position)
		local var_155_1 = 100

		for iter_155_0, iter_155_1 in pairs(arg_155_0.affectList) do
			if var_155_1 > iter_155_1.position then
				var_155_1 = iter_155_1.position
			end
		end

		if var_155_1 <= 6 and var_155_1 > 3 then
			var_155_1 = var_155_1 - 3
		elseif var_155_1 >= 7 and var_155_1 >= 10 then
			var_155_1 = var_155_1 - 3
		end

		local var_155_2 = "duanbing_zi_niumojin"
		local var_155_3 = 1.3 * Adapter.MinScale
		local var_155_4 = BattleData:getPosition(var_155_1)
		local var_155_5

		var_155_5 = BattleSkeleton:addEffect({
			animation = "duanbing_zi_niumojin_niutou",
			parent = var_155_0:getParent(),
			effectName = var_155_2,
			position = ccp(var_155_4.x, var_155_4.y + 70 * Adapter.MinScale * orderScale_num(var_155_4)),
			callbacklist = {
				function()
					for iter_156_0, iter_156_1 in pairs(arg_155_0.affectList) do
						if iter_156_1.position == var_155_1 then
							arg_155_1:getParent():setPosition(0, 0)
							shakeVertical(arg_155_1:getParent(), 10)
							arg_155_2(iter_156_1, true)
							BattleAudio:Sound_playEffect(BattleAudio.skill_niumojin2)

							local var_156_0 = "duanbing_zi_niumojin"
							local var_156_1 = 1.5 * originalScale()
							local var_156_2 = ccp(0, 110)
							local var_156_3

							var_156_3 = BattleSkeleton:addEffect({
								animation = "duanbing_zi_niumojin_bao",
								parent = BattleData:getDisplayNode(iter_156_1.position),
								effectName = var_156_0,
								position = var_156_2,
								callbacklist = {
									function()
										var_156_3:removeFromParentAndCleanup(true)
									end,
									1,
									AAT_Percent
								},
								scale = var_156_1
							})
						end
					end
				end,
				0.4,
				AAT_Percent,
				function()
					for iter_158_0, iter_158_1 in pairs(arg_155_0.affectList) do
						if iter_158_1.position == var_155_1 + 3 then
							arg_155_1:getParent():setPosition(0, 0)
							shakeVertical(arg_155_1:getParent(), 10)
							arg_155_2(iter_158_1, true)
							BattleAudio:Sound_playEffect(BattleAudio.skill_niumojin2)

							local var_158_0 = "duanbing_zi_niumojin"
							local var_158_1 = 1.5 * originalScale()
							local var_158_2 = ccp(0, 110)
							local var_158_3

							var_158_3 = BattleSkeleton:addEffect({
								animation = "duanbing_zi_niumojin_bao",
								parent = BattleData:getDisplayNode(iter_158_1.position),
								effectName = var_158_0,
								position = var_158_2,
								callbacklist = {
									function()
										var_158_3:removeFromParentAndCleanup(true)
									end,
									1,
									AAT_Percent
								},
								scale = var_158_1
							})
						end
					end
				end,
				0.5,
				AAT_Percent,
				function()
					var_155_5:removeFromParentAndCleanup(true)
					arg_155_3()
				end,
				1,
				AAT_Percent
			},
			scale = var_155_3
		})

		if not var_155_0.isHero then
			var_155_5:setRotationY(180)
		end

		var_0_16(var_155_5, var_155_4)
	end,
	[10] = function(arg_161_0, arg_161_1, arg_161_2, arg_161_3)
		BattleAudio:Sound_playEffect(BattleAudio.skill_baiguixing1)

		local var_161_0 = BattleData:getDisplayNode(arg_161_0.position)
		local var_161_1 = 100

		for iter_161_0, iter_161_1 in pairs(arg_161_0.affectList) do
			if var_161_1 > iter_161_1.position then
				var_161_1 = iter_161_1.position
			end
		end

		if var_161_1 <= 6 and var_161_1 > 3 then
			var_161_1 = var_161_1 - 3
		elseif var_161_1 >= 7 and var_161_1 >= 10 then
			var_161_1 = var_161_1 - 3
		end

		local var_161_2 = "duanbing_lan_baiguixing"
		local var_161_3 = 1 * Adapter.MinScale
		local var_161_4 = BattleData:getPosition(var_161_1)
		local var_161_5

		var_161_5 = BattleSkeleton:addEffect({
			animation = "duanbing_lan_baiguixing_qiu",
			parent = var_161_0:getParent(),
			effectName = var_161_2,
			position = ccp(var_161_4.x, var_161_4.y + 60 * Adapter.MinScale * orderScale_num(var_161_4)),
			callbacklist = {
				function()
					for iter_162_0, iter_162_1 in pairs(arg_161_0.affectList) do
						if iter_162_1.position == var_161_1 then
							arg_161_1:getParent():setPosition(0, 0)
							shakeVertical(arg_161_1:getParent(), 10)
							arg_161_2(iter_162_1, true)
							BattleAudio:Sound_playEffect(BattleAudio.skill_baiguixing2)

							local var_162_0 = "duanbing_lan_baiguixing"
							local var_162_1 = originalScale()
							local var_162_2 = ccp(0, 140)
							local var_162_3

							var_162_3 = BattleSkeleton:addEffect({
								animation = "duanbing_lan_baiguixing_bao",
								parent = BattleData:getDisplayNode(iter_162_1.position),
								effectName = var_162_0,
								position = var_162_2,
								callbacklist = {
									function()
										var_162_3:removeFromParentAndCleanup(true)
									end,
									1,
									AAT_Percent
								},
								scale = var_162_1
							})
						end
					end
				end,
				0.8,
				AAT_Percent,
				function()
					for iter_164_0, iter_164_1 in pairs(arg_161_0.affectList) do
						if iter_164_1.position == var_161_1 + 3 then
							arg_161_1:getParent():setPosition(0, 0)
							shakeVertical(arg_161_1:getParent(), 10)
							arg_161_2(iter_164_1, true)
							BattleAudio:Sound_playEffect(BattleAudio.skill_baiguixing2)

							local var_164_0 = "duanbing_lan_baiguixing"
							local var_164_1 = originalScale()
							local var_164_2 = ccp(0, 140)
							local var_164_3

							var_164_3 = BattleSkeleton:addEffect({
								animation = "duanbing_lan_baiguixing_bao",
								parent = BattleData:getDisplayNode(iter_164_1.position),
								effectName = var_164_0,
								position = var_164_2,
								callbacklist = {
									function()
										var_164_3:removeFromParentAndCleanup(true)
									end,
									1,
									AAT_Percent
								},
								scale = var_164_1
							})
						end
					end
				end,
				0.9,
				AAT_Percent,
				function()
					var_161_5:removeFromParentAndCleanup(true)
					arg_161_3()
				end,
				1,
				AAT_Percent
			},
			scale = var_161_3
		})

		if not var_161_0.isHero then
			var_161_5:setRotationY(180)
		end

		var_0_16(var_161_5, var_161_4)
	end,
	[63] = function(arg_167_0, arg_167_1, arg_167_2, arg_167_3)
		BattleAudio:Sound_playEffect(BattleAudio.skill_hengsaoqianjun)
		var_0_19(arg_167_0.affectList, function(arg_168_0, arg_168_1)
			local var_168_0 = "changbing_zi_dayu"
			local var_168_1 = BattleData:getDisplayNode(arg_168_0.position)
			local var_168_2 = originalScale()
			local var_168_3 = ccp(0, 150)
			local var_168_4
			local var_168_5 = {
				function()
					if arg_168_1 then
						arg_167_3()
					end

					var_168_4:removeFromParentAndCleanup(true)
				end,
				1,
				AAT_Percent,
				function()
					arg_167_1:getParent():setPosition(0, 0)
					shakeVertical(arg_167_1:getParent(), 10)
					arg_167_2(arg_168_0, true)
				end,
				0.6,
				AAT_Percent
			}

			var_168_4 = BattleSkeleton:addEffect({
				animation = "daji",
				parent = var_168_1,
				effectName = var_168_0,
				position = var_168_3,
				callbacklist = var_168_5,
				scale = var_168_2
			})

			if var_168_1.isHero then
				var_168_4:setRotationY(180)
			end
		end)
	end,
	[5] = function(arg_171_0, arg_171_1, arg_171_2, arg_171_3)
		BattleAudio:Sound_playEffect(BattleAudio.skill_changhongguanyue1)

		local var_171_0 = BattleData:getDisplayNode(arg_171_0.position)

		local function var_171_1()
			local var_172_0
			local var_172_1
			local var_172_4

			if var_171_0.isHero then
				local var_172_2 = var_0_14(arg_171_0.affectList[1].position)

				var_172_2[1].x = var_172_2[1].x - 150 * Adapter.MinScale
				var_172_2[2].x = var_172_2[2].x - 150 * Adapter.MinScale
				var_172_2[1].y = var_172_2[1].y + 80 * Adapter.MinScale
				var_172_2[2].y = var_172_2[2].y - 80 * Adapter.MinScale

				local var_172_3 = {
					area = var_172_2,
					pos = {}
				}

				var_172_0 = var_0_15(var_172_3, 14)
				var_172_4 = 0
			else
				local var_172_5 = var_0_13(arg_171_0.affectList[1].position)

				var_172_5[1].x = var_172_5[1].x + 150 * Adapter.MinScale
				var_172_5[2].x = var_172_5[2].x + 150 * Adapter.MinScale
				var_172_5[1].y = var_172_5[1].y + 80 * Adapter.MinScale
				var_172_5[2].y = var_172_5[2].y - 80 * Adapter.MinScale

				local var_172_6 = {
					area = var_172_5,
					pos = {}
				}

				var_172_0 = var_0_15(var_172_6, 14)
				var_172_4 = 180
			end

			local var_172_7 = CCArray:create()

			for iter_172_0, iter_172_1 in pairs(var_172_0) do
				var_172_7:addObject(CCCallFunc:create(function()
					local var_173_0 = "changbing_lv_changhaoguanri"
					local var_173_1 = 1 * Adapter.MinScale
					local var_173_2 = ccp(iter_172_1.x, iter_172_1.y + 90 * Adapter.MinScale * orderScale_num(iter_172_1))
					local var_173_3

					var_173_3 = BattleSkeleton:addEffect({
						parent = var_171_0:getParent(),
						effectName = var_173_0,
						position = var_173_2,
						callbacklist = {
							function()
								arg_171_1:getParent():setPosition(0, 0)
								shakeVertical(arg_171_1:getParent(), 10)
								BattleAudio:Sound_playEffect(BattleAudio.skill_changhongguanyue2)
							end,
							0.5,
							AAT_Percent,
							function()
								var_173_3:removeFromParentAndCleanup(true)
							end,
							1,
							AAT_Percent
						},
						scale = var_173_1,
						animation = "changbing_lv_changhaoguanri_jian_0" .. math.random(1, 3)
					})

					var_173_3:setRotationY(var_172_4)
					var_0_16(var_173_3)
				end))

				if math.random(0, 1) == 1 then
					var_172_7:addObject(CCDelayTime:create(0.04 * BattleSpeed))
				end
			end

			var_172_7:addObject(CCCallFunc:create(function()
				for iter_176_0, iter_176_1 in pairs(arg_171_0.affectList) do
					arg_171_2(iter_176_1, true)
				end

				arg_171_3()
			end))
			arg_171_1:runAction(CCSequence:create(var_172_7))
		end

		local var_171_2 = 100

		for iter_171_0, iter_171_1 in pairs(arg_171_0.affectList) do
			if var_171_2 > iter_171_1.position then
				var_171_2 = iter_171_1.position
			end
		end

		if var_171_2 <= 6 and var_171_2 > 3 then
			var_171_2 = var_171_2 - 3
		elseif var_171_2 >= 7 and var_171_2 >= 10 then
			var_171_2 = var_171_2 - 3
		end

		local var_171_3 = "changbing_lv_changhaoguanri"
		local var_171_4 = 1 * Adapter.MinScale
		local var_171_5 = BattleData:getPosition(var_171_2)
		local var_171_6

		var_171_6 = BattleSkeleton:addEffect({
			animation = "changbing_lv_changhaoguanri_gong",
			parent = var_171_0:getParent(),
			effectName = var_171_3,
			position = ccp(var_171_5.x + (var_171_0.isHero and -100 or 100) * Adapter.MinScale * orderScale_num(var_171_5), var_171_5.y + 120 * Adapter.MinScale * orderScale_num(var_171_5)),
			callbacklist = {
				function(...)
					var_171_1()
				end,
				0.4,
				AAT_Percent,
				function(...)
					var_0_20(arg_171_0.affectList, arg_171_0.position)
				end,
				0.5,
				AAT_Percent,
				function()
					var_171_6:removeFromParentAndCleanup(true)
				end,
				1,
				AAT_Percent
			},
			scale = var_171_4
		})

		if not var_171_0.isHero then
			var_171_6:setRotationY(180)
		end
	end,
	[25] = function(arg_180_0, arg_180_1, arg_180_2, arg_180_3)
		local var_180_0 = BattleData:getDisplayNode(arg_180_0.position)

		BattleAudio:Sound_playEffect(BattleAudio.skill_huashenwuqiong1)

		local var_180_1 = CCArray:create()

		for iter_180_0 = 1, 6 do
			var_180_1:addObject(CCCallFunc:create(function(...)
				BattleAudio:Sound_playEffect(BattleAudio.skill_huashenwuqiong2)

				local var_181_0 = "changbing_zi_huashenwuqiong"
				local var_181_1 = Adapter.MinScale
				local var_181_2 = BattleData:getPosition(var_180_0.isHero and 8 or 2)
				local var_181_3

				var_181_3 = BattleSkeleton:addEffect({
					parent = arg_180_1,
					effectName = var_181_0,
					position = ccp(var_181_2.x, var_181_2.y + Adapter.MinScale * 80),
					callbacklist = {
						function()
							arg_180_1:getParent():setPosition(0, 0)
							shakeVertical(arg_180_1:getParent(), 10)

							if iter_180_0 == 6 then
								for iter_182_0, iter_182_1 in pairs(arg_180_0.affectList) do
									arg_180_2(iter_182_1, true)
								end

								arg_180_3()
							end
						end,
						0.8,
						AAT_Percent,
						function()
							var_181_3:removeFromParentAndCleanup(true)
						end,
						1,
						AAT_Percent
					},
					scale = var_181_1,
					animation = "niao0" .. iter_180_0
				})

				if not var_180_0.isHero then
					var_181_3:setRotationY(180)
				end
			end))
			var_180_1:addObject(CCDelayTime:create(0.15 * BattleSpeed))
		end

		arg_180_1:runAction(CCSequence:create(var_180_1))
	end,
	[50] = function(arg_184_0, arg_184_1, arg_184_2, arg_184_3)
		BattleAudio:Sound_playEffect(BattleAudio.skill_herundong1)

		local var_184_0 = BattleData:getDisplayNode(arg_184_0.position)
		local var_184_1
		local var_184_2
		local var_184_3

		if var_184_0.isHero then
			var_184_1 = var_0_15(var_0_8(), 15)
			var_184_3 = 0
		else
			var_184_1 = var_0_15(var_0_7(), 15)
			var_184_3 = 180
		end

		if isHero then
			table.sort(var_184_1, function(arg_185_0, arg_185_1)
				return arg_185_0.x > arg_185_1.x
			end)
		else
			table.sort(var_184_1, function(arg_186_0, arg_186_1)
				return arg_186_0.x < arg_186_1.x
			end)
		end

		local var_184_4 = CCArray:create()
		local var_184_5 = true

		for iter_184_0, iter_184_1 in pairs(var_184_1) do
			var_184_4:addObject(CCCallFunc:create(function()
				BattleAudio:Sound_playEffect(BattleAudio.skill_herundong2)

				local var_187_0 = "herundong"
				local var_187_1 = 1 * Adapter.MinScale
				local var_187_2 = ccp(iter_184_1.x, iter_184_1.y + 60 * Adapter.MinScale * orderScale_num(iter_184_1))
				local var_187_3

				var_187_3 = BattleSkeleton:addEffect({
					speed = 1,
					parent = var_184_0:getParent(),
					effectName = var_187_0,
					position = var_187_2,
					callbacklist = {
						function()
							arg_184_1:getParent():setPosition(0, 0)
							shakeVertical(arg_184_1:getParent(), 20, 0.03)

							if var_184_5 then
								var_184_5 = false

								var_0_20(arg_184_0.affectList, arg_184_0.position)
							end
						end,
						0.5,
						AAT_Percent,
						function()
							var_187_3:removeFromParentAndCleanup(true)
						end,
						1,
						AAT_Percent
					},
					scale = var_187_1
				})

				var_187_3:setRotationY(var_184_3)
				var_0_16(var_187_3, iter_184_1)
			end))
			var_184_4:addObject(CCDelayTime:create(0.05 * BattleSpeed))
		end

		var_184_4:addObject(CCCallFunc:create(function()
			for iter_190_0, iter_190_1 in pairs(arg_184_0.affectList) do
				arg_184_2(iter_190_1, true)
			end

			arg_184_3()
		end))
		arg_184_1:runAction(CCSequence:create(var_184_4))
	end,
	[57] = function(arg_191_0, arg_191_1, arg_191_2, arg_191_3)
		BattleAudio:Sound_playEffect(BattleAudio.skill_niumojin1)

		local var_191_0 = BattleData:getDisplayNode(arg_191_0.position)
		local var_191_1 = "duanbing_cheng_tieniu"
		local var_191_2 = 1.3 * Adapter.MinScale
		local var_191_3

		var_191_3 = BattleSkeleton:addEffect({
			animation = "duanbing_cheng_tieniu_niutou",
			parent = var_191_0:getParent(),
			effectName = var_191_1,
			position = Adapter.AutoPos(480, 320),
			callbacklist = {
				function()
					for iter_192_0, iter_192_1 in pairs(arg_191_0.affectList) do
						if var_191_0.isHero and iter_192_1.position > 6 and iter_192_1.position < 10 or not var_191_0.isHero and iter_192_1.position > 0 and iter_192_1.position < 4 then
							arg_191_1:getParent():setPosition(0, 0)
							shakeVertical(arg_191_1:getParent(), 10)
							arg_191_2(iter_192_1, true)
							BattleAudio:Sound_playEffect(BattleAudio.skill_niumojin2)

							local var_192_0 = "duanbing_cheng_tieniu"
							local var_192_1 = 1.5 * originalScale()
							local var_192_2 = ccp(0, 110)
							local var_192_3

							var_192_3 = BattleSkeleton:addEffect({
								animation = "duanbing_cheng_tieniu_bao",
								parent = BattleData:getDisplayNode(iter_192_1.position),
								effectName = var_192_0,
								position = var_192_2,
								callbacklist = {
									function()
										var_192_3:removeFromParentAndCleanup(true)
									end,
									1,
									AAT_Percent
								},
								scale = var_192_1
							})
						end
					end
				end,
				0.4,
				AAT_Percent,
				function()
					for iter_194_0, iter_194_1 in pairs(arg_191_0.affectList) do
						if var_191_0.isHero and iter_194_1.position > 9 and iter_194_1.position < 13 or not var_191_0.isHero and iter_194_1.position > 3 and iter_194_1.position < 7 then
							arg_191_1:getParent():setPosition(0, 0)
							shakeVertical(arg_191_1:getParent(), 10)
							arg_191_2(iter_194_1, true)
							BattleAudio:Sound_playEffect(BattleAudio.skill_niumojin2)

							local var_194_0 = "duanbing_cheng_tieniu"
							local var_194_1 = 1.5 * originalScale()
							local var_194_2 = ccp(0, 110)
							local var_194_3

							var_194_3 = BattleSkeleton:addEffect({
								animation = "duanbing_cheng_tieniu_bao",
								parent = BattleData:getDisplayNode(iter_194_1.position),
								effectName = var_194_0,
								position = var_194_2,
								callbacklist = {
									function()
										var_194_3:removeFromParentAndCleanup(true)
									end,
									1,
									AAT_Percent
								},
								scale = var_194_1
							})
						end
					end
				end,
				0.5,
				AAT_Percent,
				function()
					var_191_3:removeFromParentAndCleanup(true)
					arg_191_3()
				end,
				1,
				AAT_Percent
			},
			scale = var_191_2
		})

		if not var_191_0.isHero then
			var_191_3:setRotationY(180)
		end

		var_0_16(var_191_3, point)
	end,
	[59] = function(arg_197_0, arg_197_1, arg_197_2, arg_197_3)
		local var_197_0 = BattleData:getDisplayNode(arg_197_0.position)
		local var_197_1
		local var_197_2
		local var_197_3

		if var_197_0.isHero then
			var_197_1 = var_0_15(var_0_8(), 15)
			var_197_3 = 0
		else
			var_197_1 = var_0_15(var_0_7(), 15)
			var_197_3 = 180
		end

		local var_197_4 = CCArray:create()
		local var_197_5 = true

		for iter_197_0, iter_197_1 in pairs(var_197_1) do
			var_197_4:addObject(CCCallFunc:create(function()
				local var_198_0 = "duanbing_cheng_xuanyuandao"
				local var_198_1 = 1.15 * Adapter.MinScale
				local var_198_2 = ccp(iter_197_1.x, iter_197_1.y + 5 * Adapter.MinScale * orderScale_num(iter_197_1))
				local var_198_3

				var_198_3 = BattleSkeleton:addEffect({
					parent = var_197_0:getParent(),
					effectName = var_198_0,
					position = var_198_2,
					callbacklist = {
						function()
							arg_197_1:getParent():setPosition(0, 0)
							shakeVertical(arg_197_1:getParent(), 10)
							BattleAudio:Sound_playEffect(BattleAudio.skill_zhizunling)
						end,
						0.8,
						AAT_Percent,
						function()
							var_198_3:removeFromParentAndCleanup(true)
						end,
						1,
						AAT_Percent
					},
					scale = var_198_1
				})

				var_198_3:setRotationY(var_197_3)
				var_0_16(var_198_3, iter_197_1)
			end))
			var_197_4:addObject(CCDelayTime:create(0.05 * BattleSpeed))
		end

		var_197_4:addObject(CCCallFunc:create(function()
			for iter_201_0, iter_201_1 in pairs(arg_197_0.affectList) do
				arg_197_2(iter_201_1, true)
			end

			arg_197_3()
		end))
		arg_197_1:runAction(CCSequence:create(var_197_4))
	end
}

local function var_0_22(arg_202_0, arg_202_1, arg_202_2, arg_202_3)
	var_0_19(arg_202_0.affectList, function(arg_203_0, arg_203_1)
		local var_203_0 = BattleData:getDisplayNode(arg_203_0.position)
		local var_203_1 = "jiaxue"
		local var_203_2 = originalScale()
		local var_203_3 = ccp(0, 150)
		local var_203_4

		var_203_4 = BattleSkeleton:addEffect({
			parent = var_203_0,
			effectName = var_203_1,
			position = var_203_3,
			callbacklist = {
				function(...)
					BattleAudio:Sound_playEffect(BattleAudio.status_huifu)
					arg_202_2(arg_203_0, true)
				end,
				0,
				AAT_Percent,
				function()
					var_203_4:removeFromParentAndCleanup(true)

					if arg_203_1 then
						arg_202_3()
					end
				end,
				0.2,
				AAT_Percent
			},
			scale = var_203_2
		})
	end, true)
end

local function var_0_23(arg_206_0, arg_206_1, arg_206_2, arg_206_3)
	var_0_19(arg_206_0.affectList, function(arg_207_0, arg_207_1)
		arg_206_2(arg_207_0, true, true)

		if arg_207_1 then
			arg_206_3()
		end
	end, true)
end

function isRecoverSkill(arg_208_0)
	local var_208_0 = {
		3,
		7,
		18,
		19,
		28,
		29,
		35,
		36,
		38,
		43,
		46,
		51,
		53,
		58
	}

	for iter_208_0, iter_208_1 in pairs(var_208_0) do
		if iter_208_1 == arg_208_0 then
			return true
		end
	end

	local var_208_1 = {
		11,
		22,
		23
	}

	for iter_208_2, iter_208_3 in pairs(var_208_1) do
		if iter_208_3 == arg_208_0 then
			return true
		end
	end

	return false
end

EffectConfig[3] = var_0_22
EffectConfig[7] = var_0_22
EffectConfig[18] = var_0_22
EffectConfig[19] = var_0_22
EffectConfig[28] = var_0_22
EffectConfig[29] = var_0_22
EffectConfig[35] = var_0_22
EffectConfig[36] = var_0_22
EffectConfig[38] = var_0_22
EffectConfig[43] = var_0_22
EffectConfig[46] = var_0_22
EffectConfig[51] = var_0_22
EffectConfig[53] = var_0_22
EffectConfig[58] = var_0_22
EffectConfig[66] = var_0_22
EffectConfig[67] = var_0_22
EffectConfig[69] = var_0_22
EffectConfig[11] = var_0_23
EffectConfig[23] = var_0_23
EffectConfig[8] = var_0_23
EffectConfig[21] = var_0_23
EffectConfig[40] = var_0_23

local function var_0_24(arg_209_0)
	if arg_209_0 <= 6 then
		return true
	else
		return false
	end
end

shenqiConfig = {
	function(arg_210_0, arg_210_1, arg_210_2, arg_210_3, arg_210_4)
		local var_210_0 = {}
		local var_210_1 = 0
		local var_210_2 = var_0_24(arg_210_1.position)

		if arg_210_0 == BattleCarrier.eYuruyi1 then
			if var_210_2 then
				for iter_210_0 = 1, 3 do
					var_210_0[var_210_1 + 1] = ccp(400 + iter_210_0 * 200, 350 + (3 - iter_210_0) * 0)
					var_210_0[var_210_1 + 2] = ccp(400 + iter_210_0 * 200, 100 + (3 - iter_210_0) * 20)
					var_210_1 = iter_210_0 * 2
				end
			else
				for iter_210_1 = 1, 3 do
					var_210_0[var_210_1 + 1] = ccp(540 - iter_210_1 * 200, 350 + (3 - iter_210_1) * 0)
					var_210_0[var_210_1 + 2] = ccp(540 - iter_210_1 * 200, 100 + (3 - iter_210_1) * 20)
					var_210_1 = iter_210_1 * 2
				end
			end
		elseif var_210_2 then
			for iter_210_2 = 1, 5 do
				var_210_0[var_210_1 + 1] = ccp(400 + iter_210_2 * 100, 460 + (3 - iter_210_2) * 0)
				var_210_0[var_210_1 + 2] = ccp(400 + iter_210_2 * 100, 260 + (3 - iter_210_2) * 10)
				var_210_0[var_210_1 + 3] = ccp(400 + iter_210_2 * 100, 60 + (3 - iter_210_2) * 30)
				var_210_1 = iter_210_2 * 3
			end
		else
			for iter_210_3 = 1, 5 do
				var_210_0[var_210_1 + 1] = ccp(540 - iter_210_3 * 150, 460 + (3 - iter_210_3) * 0)
				var_210_0[var_210_1 + 2] = ccp(540 - iter_210_3 * 150, 260 + (3 - iter_210_3) * 10)
				var_210_0[var_210_1 + 3] = ccp(540 - iter_210_3 * 150, 60 + (3 - iter_210_3) * 30)
				var_210_1 = iter_210_3 * 3
			end
		end

		local function var_210_3()
			local var_211_0 = CCArray:create()
			local var_211_1 = true

			for iter_211_0, iter_211_1 in pairs(var_210_0) do
				var_211_0:addObject(CCCallFunc:create(function()
					local var_212_0 = 1 * Adapter.MinScale
					local var_212_1 = Adapter.AutoPos(iter_211_1.x, iter_211_1.y)
					local var_212_2

					var_212_2 = BattleSkeleton:addEffect({
						effectName = "zuoqi_yuruyi",
						speed = 1,
						animation = "baozha",
						parent = arg_210_2,
						position = var_212_1,
						skin = arg_210_0 == BattleCarrier.eYuruyi1 and "yuruyi_diji" or "yuruyi_gaoji",
						callbacklist = {
							function()
								arg_210_2:getParent():setPosition(0, 0)
								shakeHorizontal(arg_210_2:getParent(), 40, 0.03)
								BattleAudio:Sound_playEffect(BattleAudio.shenqi_yuruyi1)

								if var_211_1 then
									var_211_1 = false

									var_0_20(arg_210_1.affectList, arg_210_1.position)
								end
							end,
							0.5,
							AAT_Percent,
							function()
								var_212_2:removeFromParentAndCleanup(true)
							end,
							1,
							AAT_Percent
						},
						scale = var_212_0
					})
				end))
				var_211_0:addObject(CCDelayTime:create(0.07 * BattleSpeed))
			end

			var_211_0:addObject(CCCallFunc:create(function()
				for iter_215_0, iter_215_1 in pairs(arg_210_1.affectList) do
					arg_210_3(iter_215_1, true)
				end

				arg_210_4()
			end))
			arg_210_2:runAction(CCSequence:create(var_211_0))
		end

		local var_210_4 = 1 * Adapter.MinScale
		local var_210_5

		var_210_5 = BattleSkeleton:addEffect({
			effectName = "zuoqi_yuruyi",
			speed = 1,
			animation = "daji",
			parent = arg_210_2,
			position = var_210_2 and Adapter.AutoPos(800, 100) or Adapter.AutoPos(160, 100),
			skin = arg_210_0 == BattleCarrier.eYuruyi1 and "yuruyi_diji" or "yuruyi_gaoji",
			callbacklist = {
				function()
					arg_210_2:getParent():setPosition(0, 0)
					shakeVertical(arg_210_2:getParent(), 40, 0.03)
					var_210_3()
					BattleAudio:Sound_playEffect(BattleAudio.shenqi_yuruyi1)
				end,
				0.2,
				AAT_Percent,
				function()
					var_210_5:removeFromParentAndCleanup(true)
				end,
				1,
				AAT_Percent
			},
			scale = var_210_4
		})

		if not var_210_2 then
			var_210_5:setRotationY(180)
		end
	end,
	function(arg_218_0, arg_218_1, arg_218_2, arg_218_3, arg_218_4)
		local var_218_0
		local var_218_1 = var_0_24(arg_218_1.position)

		if arg_218_0 == BattleCarrier.eJian1 then
			if var_218_1 then
				var_218_0 = var_0_8()
			else
				var_218_0 = var_0_7()
			end
		elseif var_218_1 then
			var_218_0 = {
				area = {
					Adapter.AutoPos(480, 300),
					Adapter.AutoPos(1000, -100)
				},
				pos = {}
			}
		else
			var_218_0 = {
				area = {
					Adapter.AutoPos(-100, 300),
					Adapter.AutoPos(480, -100)
				},
				pos = {}
			}
		end

		local var_218_2 = var_0_15(var_218_0, arg_218_0 == BattleCarrier.eJian1 and 6 or 20)

		table.sort(var_218_2, function(arg_219_0, arg_219_1)
			return arg_219_0.y > arg_219_1.y
		end)
		;(function()
			local var_220_0 = CCArray:create()
			local var_220_1 = true

			for iter_220_0, iter_220_1 in pairs(var_218_2) do
				var_220_0:addObject(CCCallFunc:create(function()
					BattleAudio:Sound_playEffect(BattleAudio.shenqi_jian1)

					local var_221_0 = "zuoqi_jian"
					local var_221_1 = math.random(8, 10) / 10 * Adapter.MinScale
					local var_221_2 = ccp(iter_220_1.x, iter_220_1.y)
					local var_221_3

					var_221_3 = BattleSkeleton:addEffect({
						parent = arg_218_2,
						effectName = var_221_0,
						position = var_221_2,
						skin = arg_218_0 == BattleCarrier.eJian1 and "diji" or "gaoji",
						callbacklist = {
							function()
								arg_218_2:getParent():setPosition(0, 0)
								shakeVertical(arg_218_2:getParent(), 30, 0.02)
								BattleAudio:Sound_playEffect(BattleAudio.shenqi_jian2)
							end,
							0.5,
							AAT_Percent,
							function()
								var_221_3:removeFromParentAndCleanup(true)
							end,
							1,
							AAT_Percent
						},
						scale = var_221_1
					})

					if not var_218_1 then
						var_221_3:setRotationY(180)
					end

					var_221_3:setZOrder(iter_220_0)
				end))
				var_220_0:addObject(CCDelayTime:create(0.05 * BattleSpeed))
			end

			var_220_0:addObject(CCCallFunc:create(function()
				for iter_224_0, iter_224_1 in pairs(arg_218_1.affectList) do
					arg_218_3(iter_224_1, true)
				end

				arg_218_4()
			end))
			arg_218_2:runAction(CCSequence:create(var_220_0))
		end)()
	end,
	function(arg_225_0, arg_225_1, arg_225_2, arg_225_3, arg_225_4)
		local var_225_0
		local var_225_1 = var_0_24(arg_225_1.position)

		if arg_225_0 == BattleCarrier.eHulu1 then
			if var_225_1 then
				var_225_0 = var_0_8()
			else
				var_225_0 = var_0_7()
			end
		elseif var_225_1 then
			var_225_0 = {
				area = {
					Adapter.AutoPos(480, 300),
					Adapter.AutoPos(960, -50)
				},
				pos = {}
			}
		else
			var_225_0 = {
				area = {
					Adapter.AutoPos(0, 300),
					Adapter.AutoPos(480, -50)
				},
				pos = {}
			}
		end

		local var_225_2 = var_0_15(var_225_0, arg_225_0 == BattleCarrier.eHulu1 and 5 or 20)

		table.sort(var_225_2, function(arg_226_0, arg_226_1)
			return arg_226_0.y > arg_226_1.y
		end)

		local function var_225_3()
			local var_227_0 = CCArray:create()
			local var_227_1 = true

			for iter_227_0, iter_227_1 in pairs(var_225_2) do
				var_227_0:addObject(CCCallFunc:create(function()
					BattleAudio:Sound_playEffect(BattleAudio.shenqi_hulu)

					local var_228_0 = "zuoqi_hulu"
					local var_228_1 = 1 * Adapter.MinScale
					local var_228_2 = ccp(iter_227_1.x, iter_227_1.y)
					local var_228_3

					var_228_3 = BattleSkeleton:addEffect({
						speed = 1,
						animation = "dianbao",
						parent = arg_225_2,
						effectName = var_228_0,
						position = var_228_2,
						skin = arg_225_0 == BattleCarrier.eHulu1 and "hulu_diji" or "hulu_gaoji",
						callbacklist = {
							function()
								arg_225_2:getParent():setPosition(0, 0)
								shakeVertical(arg_225_2:getParent(), 40, 0.03)

								if var_227_1 then
									var_227_1 = false

									var_0_20(arg_225_1.affectList, arg_225_1.position)
								end
							end,
							0.5,
							AAT_Percent,
							function()
								var_228_3:removeFromParentAndCleanup(true)
							end,
							1,
							AAT_Percent
						},
						scale = var_228_1
					})

					var_228_3:setZOrder(iter_227_0)
				end))
				var_227_0:addObject(CCDelayTime:create(0.05 * BattleSpeed))
			end

			var_227_0:addObject(CCCallFunc:create(function()
				for iter_231_0, iter_231_1 in pairs(arg_225_1.affectList) do
					arg_225_3(iter_231_1, true)
				end

				arg_225_4()
			end))
			arg_225_2:runAction(CCSequence:create(var_227_0))
		end

		local var_225_4 = 1 * Adapter.MinScale
		local var_225_5

		var_225_5 = BattleSkeleton:addEffect({
			effectName = "zuoqi_hulu",
			speed = 1,
			animation = "tuyun",
			parent = arg_225_2,
			position = var_225_1 and Adapter.AutoPos(800, 0) or Adapter.AutoPos(160, 0),
			skin = arg_225_0 == BattleCarrier.eHulu1 and "hulu_diji" or "hulu_gaoji",
			callbacklist = {
				function()
					arg_225_2:getParent():setPosition(0, 0)
					var_225_3()
				end,
				0.3,
				AAT_Percent,
				function()
					var_225_5:removeFromParentAndCleanup(true)
				end,
				1,
				AAT_Percent
			},
			scale = var_225_4
		})

		var_225_5:setZOrder(1000)

		if not var_225_1 then
			var_225_5:setRotationY(180)
		end
	end,
	function(arg_234_0, arg_234_1, arg_234_2, arg_234_3, arg_234_4)
		local var_234_0
		local var_234_1 = var_0_24(arg_234_1.position)

		if var_234_1 then
			var_234_0 = {
				area = {
					ccp(480, 500),
					ccp(960, 0)
				},
				pos = {}
			}
		else
			var_234_0 = {
				area = {
					ccp(0, 500),
					ccp(480, 0)
				},
				pos = {}
			}
		end

		local var_234_2 = var_0_15(var_234_0, arg_234_0 == BattleCarrier.eBajiaoshan1 and 2 or 15)

		if var_234_1 then
			table.sort(var_234_2, function(arg_235_0, arg_235_1)
				return arg_235_0.x < arg_235_1.x
			end)
		else
			table.sort(var_234_2, function(arg_236_0, arg_236_1)
				return arg_236_0.x > arg_236_1.x
			end)
		end

		local function var_234_3()
			BattleAudio:Sound_playEffect(BattleAudio.shenqi_bajiaoshan2)

			local var_237_0 = CCArray:create()
			local var_237_1 = true

			for iter_237_0, iter_237_1 in pairs(var_234_2) do
				var_237_0:addObject(CCCallFunc:create(function()
					local var_238_0 = "zuoqi_bajiaoshan"
					local var_238_1 = 1 * Adapter.MinScale
					local var_238_2 = Adapter.AutoPos(iter_237_1.x, iter_237_1.y)
					local var_238_3

					var_238_3 = BattleSkeleton:addEffect({
						speed = 1,
						animation = "feng",
						parent = arg_234_2,
						effectName = var_238_0,
						position = var_238_2,
						skin = arg_234_0 == BattleCarrier.eBajiaoshan1 and "bajiaoshan_diji" or "bajiaoshan_gaoji",
						callbacklist = {
							function()
								arg_234_2:getParent():setPosition(0, 0)
								shakeHorizontal(arg_234_2:getParent(), 40, 0.03)

								if var_237_1 then
									var_237_1 = false

									var_0_20(arg_234_1.affectList, arg_234_1.position)
								end

								BattleAudio:Sound_playEffect(BattleAudio.shenqi_bajiaoshan3)
							end,
							0.2,
							AAT_Percent,
							function()
								var_238_3:removeFromParentAndCleanup(true)
							end,
							1,
							AAT_Percent
						},
						scale = var_238_1
					})

					var_238_3:setZOrder(-1)
				end))
				var_237_0:addObject(CCDelayTime:create(0.05 * BattleSpeed))
			end

			var_237_0:addObject(CCCallFunc:create(function()
				for iter_241_0, iter_241_1 in pairs(arg_234_1.affectList) do
					arg_234_3(iter_241_1, true)
				end

				arg_234_4()
			end))
			arg_234_2:runAction(CCSequence:create(var_237_0))
		end

		BattleAudio:Sound_playEffect(BattleAudio.shenqi_bajiaoshan1)

		local var_234_4 = 1 * Adapter.MinScale
		local var_234_5

		var_234_5 = BattleSkeleton:addEffect({
			effectName = "zuoqi_bajiaoshan",
			speed = 1,
			animation = "shanzi",
			parent = arg_234_2,
			position = var_234_1 and Adapter.AutoPos(700, 0) or Adapter.AutoPos(300, 0),
			skin = arg_234_0 == BattleCarrier.eBajiaoshan1 and "bajiaoshan_diji" or "bajiaoshan_gaoji",
			callbacklist = {
				function()
					arg_234_2:getParent():setPosition(0, 0)
					var_234_3()
				end,
				0.9,
				AAT_Percent,
				function()
					var_234_5:removeFromParentAndCleanup(true)
				end,
				1,
				AAT_Percent
			},
			scale = var_234_4
		})

		if not var_234_1 then
			var_234_5:setRotationY(180)
		end
	end,
	function(arg_244_0, arg_244_1, arg_244_2, arg_244_3, arg_244_4)
		local var_244_0
		local var_244_1 = var_0_24(arg_244_1.position)

		if var_244_1 then
			var_244_0 = {
				area = {
					ccp(480, 500),
					ccp(960, 0)
				},
				pos = {}
			}
		else
			var_244_0 = {
				area = {
					ccp(0, 500),
					ccp(480, 0)
				},
				pos = {}
			}
		end

		local var_244_2 = var_0_15(var_244_0, arg_244_0 == BattleCarrier.eYujingping1 and 5 or 15)

		local function var_244_3()
			local var_245_0 = CCArray:create()
			local var_245_1 = true

			for iter_245_0, iter_245_1 in pairs(var_244_2) do
				var_245_0:addObject(CCCallFunc:create(function()
					local var_246_0 = "zuoqi_yujingping"
					local var_246_1 = 1 * Adapter.MinScale
					local var_246_2 = Adapter.AutoPos(iter_245_1.x, iter_245_1.y)
					local var_246_3

					var_246_3 = BattleSkeleton:addEffect({
						speed = 1,
						animation = "baozha",
						parent = arg_244_2,
						effectName = var_246_0,
						position = var_246_2,
						skin = arg_244_0 == BattleCarrier.eYujingping1 and "yujingping_diji" or "yujingping_gaoji",
						callbacklist = {
							function()
								arg_244_2:getParent():setPosition(0, 0)
								shakeVertical(arg_244_2:getParent(), 40, 0.03)
								BattleAudio:Sound_playEffect(BattleAudio.shenqi_yujingping2)

								if var_245_1 then
									var_245_1 = false

									var_0_20(arg_244_1.affectList, arg_244_1.position)
								end
							end,
							0.5,
							AAT_Percent,
							function()
								var_246_3:removeFromParentAndCleanup(true)
							end,
							1,
							AAT_Percent
						},
						scale = var_246_1
					})
				end))
				var_245_0:addObject(CCDelayTime:create(0.05 * BattleSpeed))
			end

			var_245_0:addObject(CCCallFunc:create(function()
				for iter_249_0, iter_249_1 in pairs(arg_244_1.affectList) do
					arg_244_3(iter_249_1, true)
				end

				arg_244_4()
			end))
			arg_244_2:runAction(CCSequence:create(var_245_0))
		end

		local var_244_4 = true
		local var_244_5

		if arg_244_0 == BattleCarrier.eYujingping1 then
			var_244_5 = {
				ccp(300, 100),
				ccp(150, 250),
				ccp(330, 400)
			}
		else
			var_244_5 = {
				ccp(300, 300),
				ccp(150, 400),
				ccp(200, 500),
				ccp(410, 350),
				ccp(180, 50),
				ccp(350, 150),
				ccp(220, 220),
				ccp(330, 460)
			}
		end

		for iter_244_0, iter_244_1 in pairs(var_244_5) do
			if not var_244_1 then
				iter_244_1.x = 960 - iter_244_1.x
			end

			local var_244_6 = 1 * Adapter.MinScale
			local var_244_7

			var_244_7 = BattleSkeleton:addEffect({
				effectName = "zuoqi_yujingping",
				speed = 1,
				animation = "guang",
				parent = arg_244_2,
				position = Adapter.AutoPos(iter_244_1.x + (var_244_1 and -200 or 200), iter_244_1.y),
				skin = arg_244_0 == BattleCarrier.eYujingping1 and "yujingping_diji" or "yujingping_gaoji",
				callbacklist = {
					function()
						var_244_7:removeFromParentAndCleanup(true)
					end,
					1,
					AAT_Percent
				},
				scale = var_244_6
			})

			var_244_7:setAnimation("pingzi", true, 0)

			if not var_244_1 then
				var_244_7:setRotationY(180)
			end

			local var_244_8 = CCArray:create()

			var_244_8:addObject(CCDelayTime:create(math.random(0, 20) / 100 * BattleSpeed))
			var_244_8:addObject(CCMoveTo:create(0.2 * BattleSpeed, Adapter.AutoPos(iter_244_1.x, iter_244_1.y)))
			var_244_8:addObject(CCDelayTime:create(0.3 * BattleSpeed))
			var_244_8:addObject(CCCallFunc:create(function(...)
				BattleAudio:Sound_playEffect(BattleAudio.shenqi_yujingping1)
				var_244_7:setAnimation("guang", false, 0)
			end))
			var_244_8:addObject(CCDelayTime:create(0.2 * BattleSpeed))
			var_244_8:addObject(CCCallFunc:create(function(...)
				if var_244_4 then
					var_244_4 = false

					var_244_3()
				end
			end))
			var_244_7:runAction(CCSequence:create(var_244_8))
		end
	end
}
