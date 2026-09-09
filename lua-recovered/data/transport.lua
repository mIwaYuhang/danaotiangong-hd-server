HorseType = {
	PurpleHorse = 4,
	GreenHorse = 2,
	WhiteHorse = 1,
	CyanHorse = 3,
	GoldenHorse = 5
}
HorseTypeData = {
	[HorseType.WhiteHorse] = {
		horseImage = "ui/transport/transport_008.png",
		name = string.lf("木船")
	},
	[HorseType.GreenHorse] = {
		horseImage = "ui/transport/transport_007.png",
		name = string.lf("花船")
	},
	[HorseType.CyanHorse] = {
		horseImage = "ui/transport/transport_006.png",
		name = string.lf("虎船")
	},
	[HorseType.PurpleHorse] = {
		horseImage = "ui/transport/transport_005.png",
		name = string.lf("凤船")
	},
	[HorseType.GoldenHorse] = {
		horseImage = "ui/transport/transport_004.png",
		name = string.lf("龙船")
	}
}
TransportDest = {
	LeaveFireIsland = 2,
	LockGodPalace = 1
}
TransportDestData = {
	[TransportDest.LockGodPalace] = {
		transportSecond = 1200,
		ConsumeTime = 1,
		name = string.lf("锁仙殿")
	},
	[TransportDest.LeaveFireIsland] = {
		transportSecond = 1800,
		ConsumeTime = 2,
		name = string.lf("离火岛")
	}
}
TransportBlessInfo = {
	{
		AddKonwledge = 500,
		headImage = "ui/transport/transport_016.png",
		AddExp = 1000,
		BlessType = 4,
		BlessConsume = {
			Count = 5000,
			Type = 1
		},
		title = string.lf("十里香"),
		color = ccc3(40, 246, 45)
	},
	{
		AddKonwledge = 1000,
		headImage = "ui/transport/transport_017.png",
		AddExp = 3000,
		BlessType = 5,
		BlessConsume = {
			Count = 20,
			Type = 2
		},
		title = string.lf("百里香"),
		color = ccc3(44, 254, 254)
	},
	{
		AddKonwledge = 10000,
		headImage = "ui/transport/transport_018.png",
		AddExp = 5000,
		BlessType = 6,
		BlessConsume = {
			Count = 100,
			Type = 2
		},
		title = string.lf("千里香"),
		color = ccc3(216, 198, 48)
	}
}

function getFriendAddPower(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0 / arg_1_1 * 0.1

	if var_1_0 > 0.2 then
		var_1_0 = 0.2
	end

	if var_1_0 < 0.01 then
		var_1_0 = 0.01
	end

	return var_1_0 * 100
end
