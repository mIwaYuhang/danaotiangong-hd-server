local var_0_0 = class("BattlePreLayer", function()
	return CCNodeExtend.extend(CCLayerColor:create())
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.params = arg_2_1
	arg_2_0.preList = {}

	arg_2_0:preload()

	local var_2_0 = CCSprite:create("ui/battle/preload.jpg")

	var_2_0:setScaleX(Adapter.AutoScaleX)
	var_2_0:setScaleY(Adapter.AutoScaleY)
	var_2_0:setPosition(display.cx, display.cy)
	arg_2_0:addChild(var_2_0)

	arg_2_0.effect = var_2_0

	local var_2_1 = CCSprite:create("uilocal/battle/battle_text_166.png")

	var_2_1:setPosition(display.cx, display.cy)
	var_2_1:setScale(Adapter.MinScale)
	arg_2_0:addChild(var_2_1)

	local var_2_2 = CCArray:create()

	var_2_2:addObject(CCFadeOut:create(0.2))
	var_2_2:addObject(CCFadeIn:create(0.2))
	var_2_1:runAction(CCRepeatForever:create(CCSequence:create(var_2_2)))

	arg_2_0.label = var_2_1

	if device.platform ~= "mac" then
		CCSpriteFrameCache:sharedSpriteFrameCache():removeUnusedSpriteFrames()
		CCDirector:sharedDirector():purgeCachedData()
	end

	arg_2_0:setNodeEventEnabled(true)
end

function var_0_0.onEnter(arg_3_0, ...)
	local var_3_0 = #arg_3_0.preList
	local var_3_1 = arg_3_0.params.scene_target

	local function var_3_2()
		var_3_0 = var_3_0 - 1

		if var_3_0 == 0 then
			local var_4_0 = BattleSkeleton:addEffect({
				effectName = "ui_zhandoukaichang",
				speed = 2,
				animation = "animation",
				parent = arg_3_0,
				position = ccp(display.cx, display.cy),
				callbacklist = {
					function(...)
						arg_3_0.effect:removeFromParentAndCleanup(true)
						arg_3_0.label:removeFromParentAndCleanup(true)
					end,
					0,
					AAT_Percent,
					function()
						arg_3_0:removeFromParentAndCleanup(true)
						var_3_1:init()
					end,
					1,
					AAT_Percent
				}
			})

			var_4_0:setScaleX(Adapter.AutoScaleX)
			var_4_0:setScaleY(Adapter.AutoScaleY)
		end
	end

	for iter_3_0, iter_3_1 in pairs(arg_3_0.preList) do
		if iter_3_1 and iter_3_1 ~= "" then
			CCTextureCache:sharedTextureCache():addImageAsync(iter_3_1, var_3_2)
		end
	end
end

function var_0_0.preload(arg_7_0)
	if arg_7_0.params.battleBG.circlePic then
		for iter_7_0, iter_7_1 in pairs(arg_7_0.params.battleBG.circlePic) do
			table.insert(arg_7_0.preList, iter_7_1)
		end
	end

	if arg_7_0.params.battleBG.finalPic then
		table.insert(arg_7_0.preList, arg_7_0.params.battleBG.finalPic)
	end

	table.insert(arg_7_0.preList, "effectAni/buff_tongyi.png")
	table.insert(arg_7_0.preList, "effectAni/changbing_chufa.png")
	table.insert(arg_7_0.preList, "effectAni/changbing_pugong_01.png")
	table.insert(arg_7_0.preList, "effectAni/changbing_pugong_02.png")
	table.insert(arg_7_0.preList, "effectAni/duanbing_pugong_01-1.png")
	table.insert(arg_7_0.preList, "effectAni/duanbing_pugong_02-1.png")
	table.insert(arg_7_0.preList, "effectAni/duanbing_yinchang.png")
	table.insert(arg_7_0.preList, "effectAni/faqi_chufa.png")
	table.insert(arg_7_0.preList, "effectAni/faqi_pugong_01.png")
	table.insert(arg_7_0.preList, "effectAni/faqi_pugong_02_qiu.png")
	table.insert(arg_7_0.preList, "effectAni/faqi_pugong_02-1.png")
	table.insert(arg_7_0.preList, "effectAni/gedang.png")
	table.insert(arg_7_0.preList, "effectAni/teji_longweapon.png")
	table.insert(arg_7_0.preList, "effectAni/teji_magicweapon.png")
	table.insert(arg_7_0.preList, "effectAni/teji_weapon.png")
	table.insert(arg_7_0.preList, "uilocal/battle/battle_text_007.png")
	table.insert(arg_7_0.preList, "uilocal/battle/battle_text_008.png")
	table.insert(arg_7_0.preList, "uilocal/battle/battle_text_009.png")
	table.insert(arg_7_0.preList, "uilocal/battle/battle_text_010.png")
	table.insert(arg_7_0.preList, "uilocal/battle/battle_text_011.png")
	table.insert(arg_7_0.preList, "ui/battle/bg_startBattle.png")

	if arg_7_0.params.comming.playerComming then
		table.insert(arg_7_0.preList, queryCarrierFile(arg_7_0.params.comming.playerComming))
	end

	if arg_7_0.params.comming.enemyComming then
		table.insert(arg_7_0.preList, queryCarrierFile(arg_7_0.params.comming.enemyComming))
	end

	table.insert(arg_7_0.preList, "ui/battle/battle_017.png")
	table.insert(arg_7_0.preList, "ui/battle/bg_skill_1.png")
	table.insert(arg_7_0.preList, "ui/battle/bg_skill_2.png")
	table.insert(arg_7_0.preList, "ui/battle/bg_skill_3.png")
	table.insert(arg_7_0.preList, "ui/battle/bg_skill_4.png")
	table.insert(arg_7_0.preList, "ui/battle/bg_skill_01.png")
end

return var_0_0
