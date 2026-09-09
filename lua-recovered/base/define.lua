Adapter = {}

function Adapter.init()
	local var_1_0 = CCDirector:sharedDirector():getOpenGLView()

	if device.model == "ipad" and display.widthInPixels == 2048 and display.heightInPixels == 1536 then
		display.width = display.widthInPixels / 2
		display.height = display.heightInPixels / 2
	else
		display.width = display.widthInPixels
		display.height = display.heightInPixels
	end

	display.cx = display.width / 2
	display.cy = display.height / 2
	display.c_left = -display.width / 2
	display.c_right = display.width / 2
	display.c_top = display.height / 2
	display.c_bottom = -display.height / 2
	display.left = 0
	display.right = display.width
	display.top = display.height
	display.bottom = 0

	var_1_0:setDesignResolutionSize(display.width, display.height, kResolutionNoBorder)

	local var_1_1 = display.width / CONFIG_SCREEN_WIDTH
	local var_1_2 = display.height / CONFIG_SCREEN_HEIGHT
	local var_1_3 = var_1_2 < var_1_1 and var_1_2 or var_1_1

	if DEBUG > 1 then
		echoInfo("# new display.width            = %0.2f", display.width)
		echoInfo("# new display.height           = %0.2f", display.height)
		echoInfo("# new display.cx               = %0.2f", display.cx)
		echoInfo("# new display.cy               = %0.2f", display.cy)
		echoInfo("# new display.left             = %0.2f", display.left)
		echoInfo("# new display.right            = %0.2f", display.right)
		echoInfo("# new display.top              = %0.2f", display.top)
		echoInfo("# new display.bottom           = %0.2f", display.bottom)
		echoInfo("# new display.c_left           = %0.2f", display.c_left)
		echoInfo("# new display.c_right          = %0.2f", display.c_right)
		echoInfo("# new display.c_top            = %0.2f", display.c_top)
		echoInfo("# new display.c_bottom         = %0.2f", display.c_bottom)
		echoInfo("# Adapter scaleX = %0.2f, scaleY = %0.2f, minScale = %0.2f", var_1_1, var_1_2, var_1_3)
		echoInfo("# ")
	end

	Adapter.AutoScaleX = var_1_1
	Adapter.WidthScale = var_1_1
	Adapter.AutoScaleY = var_1_2
	Adapter.HeightScale = var_1_2
	Adapter.MinScale = var_1_3
end

function Adapter.AutoPosX(arg_2_0)
	return arg_2_0 * Adapter.AutoScaleX
end

Adapter.AutoWidth = Adapter.AutoPosX

function Adapter.AutoPosY(arg_3_0)
	return arg_3_0 * Adapter.AutoScaleY
end

Adapter.AutoHeight = Adapter.AutoPosY

function Adapter.AutoPos(arg_4_0, arg_4_1)
	return CCPoint(arg_4_0 * Adapter.AutoScaleX, arg_4_1 * Adapter.AutoScaleY)
end

function Adapter.AutoSize(arg_5_0, arg_5_1)
	return CCSize(arg_5_0 * Adapter.AutoScaleX, arg_5_1 * Adapter.AutoScaleY)
end

function Adapter.MinPosX(arg_6_0)
	return arg_6_0 * Adapter.MinScale
end

Adapter.MinWidth = Adapter.MinPosX

function Adapter.MinPosY(arg_7_0)
	return arg_7_0 * Adapter.MinScale
end

Adapter.MinHeight = Adapter.MinPosY

function Adapter.MinPos(arg_8_0, arg_8_1)
	return CCPoint(arg_8_0 * Adapter.MinScale, arg_8_1 * Adapter.MinScale)
end

function Adapter.MinSize(arg_9_0, arg_9_1)
	return CCSize(arg_9_0 * Adapter.MinScale, arg_9_1 * Adapter.MinScale)
end

function Adapter.WidthPos(arg_10_0, arg_10_1)
	return CCPoint(arg_10_0 * Adapter.AutoScaleX, arg_10_1 * Adapter.AutoScaleX)
end

function Adapter.WidthSize(arg_11_0, arg_11_1)
	return CCSize(arg_11_0 * Adapter.AutoScaleX, arg_11_1 * Adapter.AutoScaleX)
end

function Adapter.HCellPos(arg_12_0, arg_12_1)
	return CCPoint(arg_12_0 * Adapter.AutoScaleY, arg_12_1 * Adapter.AutoScaleY)
end

function Adapter.HCellSize(arg_13_0, arg_13_1)
	return CCSize(arg_13_0 * Adapter.AutoScaleY, arg_13_1 * Adapter.AutoScaleY)
end

_FONT_DEFAULT = "Helvetica"

local var_0_0 = IPlatform:instance():getConfig("Channel")

if var_0_0 == "ZSY_TW" then
	_FONT_PANGWA = _FONT_DEFAULT
	_FONT_LISU = _FONT_DEFAULT
elseif var_0_0 == "ZSY_VN" then
	_FONT_PANGWA = "Tahoma"
	_FONT_LISU = "Tahoma"
else
	_FONT_LISU = "FZLiBian-S02S.ttf"
	_FONT_PANGWA = "FZPangWa-M18S.ttf"
end

function Adapter.FontSize(arg_14_0)
	return arg_14_0 * Adapter.MinScale
end

function Adapter.NodeAbsScale(arg_15_0)
	return 1
end

_IDLE_GAME_MUSIC_HOME = "media/homeScenebackground.mp3"
_IDLE_GAME_MUSIC_GUIDER = "media/guiderBackground.mp3"
_IDLE_GAME_MUSIC_MAP = "media/mapBackground.mp3"
_IDLE_GAME_MUSIC_STARTGAME = "media/dntgstartgame.mp3"
_IDLE_GAME_MUSIC_BATTLE1 = "media/fightbackground1.mp3"
_IDLE_GAME_MUSIC_BATTLE2 = "media/fightbackground2.mp3"
math.max_num = 2147483647
GameMaxNum = {
	ePropPile = 999,
	eEquip = 300
}
ColorTable = {
	eTitleButton_FontSize = 24,
	eTitleButton_FontSize2 = 24,
	eTitleTabButton_Normal = ccc3(196, 151, 79),
	eTitleTabButton_Selected = ccc3(247, 238, 204),
	eTitleButton_Normal = ccc3(255, 255, 255),
	eTitleButton_Selected = ccc3(202, 202, 202),
	eTitleButton_Disabled = ccc3(30, 30, 30),
	eTitleButton_Normal2 = ccc3(255, 255, 255),
	eTitleButton_Selected2 = ccc3(202, 202, 202),
	eTitleButton_Disabled2 = ccc3(30, 30, 30),
	eHeroGrouped = ccc3(48, 161, 4)
}
DefaultZOrder = {
	eGameAnnounce = 100,
	eMsgBox = 126,
	ePopupLayer = 80,
	eMax = 127,
	eTaskReward = 81,
	eLevelUp = 99
}
