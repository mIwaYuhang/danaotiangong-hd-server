function BattleAudio.Sound_preloadEffect(arg_1_0)
	return
end

function BattleAudio.Sound_releaseEffect(arg_2_0)
	return
end

function BattleAudio.Sound_playEffect(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 == "" then
		return
	end

	playEffect(arg_3_1, arg_3_2)
end

function BattleAudio.Sound_stopEffect(arg_4_0, arg_4_1)
	SimpleAudioEngine:sharedEngine():stopEffect(arg_4_1)
end

function BattleAudio.stopAll(arg_5_0)
	SimpleAudioEngine:sharedEngine():stopAllEffects()
	arg_5_0:Sound_stopBG()
end
