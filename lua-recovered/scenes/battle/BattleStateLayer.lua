require("scenes.battle.BattleData")

local var_0_0 = class("BattleStateLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

function var_0_0.ctor(arg_2_0)
	return
end

StateLayerType = {
	string.lf("沉默"),
	string.lf("昏迷"),
	string.lf("降低普防"),
	string.lf("降低法防"),
	string.lf("降低普攻"),
	string.lf("降低法攻"),
	string.lf("降低攻击"),
	string.lf("降低防御"),
	string.lf("降低命中"),
	string.lf("降低闪避"),
	string.lf("降低暴击"),
	string.lf("降低韧性"),
	string.lf("降低格挡"),
	string.lf("降低破击"),
	[101] = string.lf("增加普攻"),
	[102] = string.lf("增加法攻"),
	[103] = string.lf("增加普防"),
	[104] = string.lf("增加法防"),
	[105] = string.lf("增加攻击"),
	[106] = string.lf("增加防御"),
	[107] = string.lf("增加命中"),
	[108] = string.lf("增加闪避"),
	[109] = string.lf("增加暴击"),
	[110] = string.lf("增加韧性"),
	[111] = string.lf("增加格挡"),
	[112] = string.lf("增加破击"),
	[201] = string.lf("断续")
}

function var_0_0.queryStateName(arg_3_0, arg_3_1)
	return string.format("uilocal/battle/buff/buff_text_%d.png", arg_3_1.type)
end

function var_0_0.queryStatePic(arg_4_0, arg_4_1)
	local var_4_0 = {
		string.lf("沉默"),
		string.lf("昏迷"),
		"buff_jiafangyu_1.png",
		"buff_jiafangyu_2.png",
		"buff_jiagongji_1.png",
		"buff_jiagongji_2.png",
		"buff_jiagongji_3.png",
		"buff_jiafangyu_3.png",
		"buff_mingzhong.png",
		"buff_shanbi.png",
		"buff_baoji.png",
		"buff_renxing.png",
		"buff_gedang.png",
		"buff_poji.png",
		[104] = "buff_jiafangyu_2.png",
		[109] = "buff_baoji.png",
		[108] = "buff_shanbi.png",
		[112] = "buff_poji.png",
		[111] = "buff_gedang.png",
		[101] = "buff_jiagongji_1.png",
		[107] = "buff_mingzhong.png",
		[110] = "buff_renxing.png",
		[102] = "buff_jiagongji_2.png",
		[106] = "buff_jiafangyu_3.png",
		[201] = "断续",
		[103] = "buff_jiafangyu_1.png",
		[105] = "buff_jiagongji_3.png"
	}
	local var_4_1
	local var_4_2 = arg_4_1.type < 101 and "ui/buff/buff_down.png" or "ui/buff/buff_up.png"

	return "ui/buff/" .. var_4_0[arg_4_1.type], var_4_2
end

function var_0_0.createState(arg_5_0, arg_5_1)
	local var_5_0
	local var_5_1, var_5_2 = arg_5_0:queryStatePic(arg_5_1)
	local var_5_3 = CCSprite:create(var_5_1)
	local var_5_4 = CCSprite:create(var_5_2)
	local var_5_5 = var_5_3:getTextureRect()

	var_5_4:setPosition(var_5_5.size.width / 2, var_5_5.size.height / 2)

	local var_5_6 = CCArray:create()

	var_5_6:addObject(CCRotateBy:create(0.5, 180))
	var_5_4:runAction(CCRepeatForever:create(CCSequence:create(var_5_6)))
	var_5_3:addChild(var_5_4)

	var_5_3.updown = var_5_4
	var_5_3.stateid = arg_5_1.id
	var_5_3.type = arg_5_1.type

	return var_5_3
end

function var_0_0.addIconAni(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_1.stateicon then
		arg_6_1.stateicon = {}
		arg_6_1.stateDataLayer = CCNode:create()

		arg_6_1.progressNode:addChild(arg_6_1.stateDataLayer)
	end

	local var_6_0

	var_6_0 = BattleSkeleton:addEffect({
		effectName = "buff_tongyi",
		parent = arg_6_1,
		position = ccp(0, 150),
		scale = originalScale(),
		callbacklist = {
			function(...)
				var_6_0:removeFromParentAndCleanup(true)
			end,
			1,
			AAT_Percent
		}
	})

	if arg_6_2.type == BattleStateType.eSilence then
		BattleAudio:Sound_playEffect(BattleAudio.status_chenmo)

		local var_6_1

		var_6_1 = BattleSkeleton:addEffect({
			effectName = "buff_chengmo",
			animation = "buff_chengmo_daji",
			parent = arg_6_1,
			position = ccp(0, 150),
			scale = originalScale(),
			callbacklist = {
				function(...)
					var_6_1:removeFromParentAndCleanup(true)

					local var_8_0 = BattleSkeleton:addEffect({
						effectName = "buff_chengmo",
						loop = true,
						animation = "buff_chengmo_xunhuan",
						parent = arg_6_1,
						position = ccp(0, 150),
						scale = originalScale()
					})

					var_8_0.class = true
					var_8_0.stateid = arg_6_2.id

					table.insert(arg_6_1.stateicon, var_8_0)
				end,
				1,
				AAT_Percent
			}
		})
	elseif arg_6_2.type == BattleStateType.eStun then
		BattleAudio:Sound_playEffect(BattleAudio.status_hunmi)

		local var_6_2 = BattleSkeleton:addEffect({
			effectName = "hunmi",
			loop = true,
			parent = arg_6_1,
			position = ccp(0, 330),
			scale = originalScale()
		})

		var_6_2:setOpacity(0)
		var_6_2:runAction(CCFadeIn:create(0.5 * BattleSpeed))

		var_6_2.class = true
		var_6_2.stateid = arg_6_2.id

		table.insert(arg_6_1.stateicon, var_6_2)
	elseif arg_6_2.type == BattleStateType.eDuanxu then
		BattleAudio:Sound_playEffect(BattleAudio.status_chenmo)

		local var_6_3

		var_6_3 = BattleSkeleton:addEffect({
			effectName = "buff_duanxu",
			animation = "buff_duanxu_daji",
			parent = arg_6_1,
			position = ccp(0, 150),
			scale = originalScale(),
			callbacklist = {
				function(...)
					var_6_3:removeFromParentAndCleanup(true)

					local var_9_0 = BattleSkeleton:addEffect({
						effectName = "buff_duanxu",
						loop = true,
						animation = "buff_duanxu_xunhuan",
						parent = arg_6_1,
						position = ccp(0, 150),
						scale = originalScale()
					})

					var_9_0.class = true
					var_9_0.stateid = arg_6_2.id

					table.insert(arg_6_1.stateicon, var_9_0)
				end,
				1,
				AAT_Percent
			}
		})
	else
		BattleAudio:Sound_playEffect(BattleAudio.status_buff_up)

		local var_6_4 = arg_6_0:createState(arg_6_2)

		var_6_4:setOpacity(0)
		var_6_4:runAction(CCFadeIn:create(0.5 * BattleSpeed))

		var_6_4.class = false

		arg_6_1.stateDataLayer:addChild(var_6_4)
		table.insert(arg_6_1.stateicon, var_6_4)
		arg_6_0:sortIcon(arg_6_1)
	end

	local var_6_5, var_6_6 = arg_6_1:getPosition()
	local var_6_7 = CCSprite:create(arg_6_0:queryStateName(arg_6_2))

	arg_6_0:addChild(var_6_7)
	var_6_7:setPosition(CCPoint(var_6_5, var_6_6 + 150 * arg_6_1:getScale()))

	local var_6_8 = CCArray:create()

	var_6_7:setScale(0.01)
	var_6_8:addObject(CCEaseElasticInOut:create(CCScaleTo:create(0.5 * BattleSpeed, 1 * Adapter.MinScale), 0.3 * Adapter.MinScale))
	var_6_8:addObject(CCDelayTime:create(0.4 * BattleSpeed))
	var_6_8:addObject(CCCallFunc:create(function(...)
		if arg_6_2.type < 3 or arg_6_2.type == 201 then
			-- block empty
		elseif arg_6_2.type >= 101 then
			var_6_7:runAction(CCMoveBy:create(0.7 * BattleSpeed, ccp(0, 50 * Adapter.MinScale)))
		else
			var_6_7:runAction(CCMoveBy:create(0.7 * BattleSpeed, ccp(0, -50 * Adapter.MinScale)))
		end
	end))
	var_6_8:addObject(CCFadeOut:create(0.3 * BattleSpeed))
	var_6_8:addObject(CCCallFunc:create(function()
		var_6_7:removeFromParentAndCleanup(true)
	end))
	var_6_7:runAction(CCSequence:create(var_6_8))
end

function var_0_0.deleteIconAni(arg_12_0, arg_12_1, arg_12_2)
	BattleAudio:Sound_playEffect(BattleAudio.status_buff_down)

	local var_12_0 = 0

	if arg_12_1.stateicon then
		for iter_12_0, iter_12_1 in pairs(arg_12_1.stateicon) do
			if not iter_12_1.class then
				var_12_0 = var_12_0 + 1
			end

			if iter_12_1.stateid == arg_12_2.id then
				if iter_12_1.class then
					local var_12_1 = CCArray:create()

					var_12_1:addObject(CCFadeOut:create(0.2 * BattleSpeed))
					var_12_1:addObject(CCCallFunc:create(function()
						iter_12_1:removeFromParentAndCleanup(true)
					end))
					iter_12_1:runAction(CCSequence:create(var_12_1))

					arg_12_1.stateicon[iter_12_0] = nil
				else
					local var_12_2 = CCArray:create()

					if var_12_0 - iter_12_0 <= 3 then
						var_12_2:addObject(CCFadeOut:create(0.2 * BattleSpeed))
					end

					var_12_2:addObject(CCCallFunc:create(function()
						iter_12_1:removeFromParentAndCleanup(true)
					end))
					iter_12_1:runAction(CCSequence:create(var_12_2))

					arg_12_1.stateicon[iter_12_0] = nil
				end
			end
		end
	end

	arg_12_0:sortIcon(arg_12_1)
end

function var_0_0.sortIcon(arg_15_0, arg_15_1)
	if arg_15_1.stateicon then
		local var_15_0 = 0

		for iter_15_0, iter_15_1 in pairs(arg_15_1.stateicon) do
			if not iter_15_1.class then
				var_15_0 = var_15_0 + 1
			end
		end

		local var_15_1 = 0

		for iter_15_2, iter_15_3 in pairs(arg_15_1.stateicon) do
			if not iter_15_3.class then
				if var_15_0 - var_15_1 <= 3 then
					iter_15_3:runAction(CCFadeIn:create(0.2 * BattleSpeed))
					iter_15_3.updown:runAction(CCFadeIn:create(0.2 * BattleSpeed))
				else
					iter_15_3:runAction(CCFadeOut:create(0.2 * BattleSpeed))
					iter_15_3.updown:runAction(CCFadeOut:create(0.2 * BattleSpeed))
				end

				iter_15_3:runAction(CCMoveTo:create(0.2 * BattleSpeed, CCPoint((arg_15_1.isHero and 30 or -30) + (var_15_0 - var_15_1 - 1) * (arg_15_1.isHero and -30 or 30), -20)))

				var_15_1 = var_15_1 + 1
			end
		end
	end
end

return var_0_0
