require("data.localdata")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = class("OptionVolumeLayer", function()
	return display.newLayer()
end)
local var_0_2
local var_0_3 = "ui/common/common_028.png"
local var_0_4 = "ui/common/common_029.png"

function var_0_1.ctor(arg_2_0, arg_2_1)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.nodeSize = CCSize(565, 400)
	arg_2_0.bgSprite = display.newScale9Sprite("ui/common/common_056.png")

	arg_2_0.bgSprite:setContentSize(arg_2_0.nodeSize)
	arg_2_0.bgSprite:align(display.CENTER, display.cx, display.cy)
	arg_2_0.bgSprite:setScale(Adapter.MinScale)
	arg_2_0:addChild(arg_2_0.bgSprite)

	local var_2_0 = display.newSprite("uilocal/system/system_text_002.png")

	var_2_0:setAnchorPoint(CCPoint(0, 1))
	var_2_0:setPosition(CCPoint(20, arg_2_0.nodeSize.height + 10))
	arg_2_0.bgSprite:addChild(var_2_0)

	local var_2_1 = display.newScale9Sprite("ui/system/system_013.png")

	var_2_1:setContentSize(CCSize(551, 280))
	var_2_1:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_1:setPosition(CCPoint(arg_2_0.nodeSize.width / 2, arg_2_0.nodeSize.height / 2))
	arg_2_0.bgSprite:addChild(var_2_1)

	local var_2_2 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		position = ccp(arg_2_0.nodeSize.width - 15, arg_2_0.nodeSize.height - 15),
		clickAction = function(arg_4_0, arg_4_1)
			arg_2_0:removeSelfAndSaveSetting()
		end
	})

	arg_2_0.bgSprite:addChild(var_2_2)

	if arg_2_1.callback then
		var_0_2 = arg_2_1.callback
	end

	arg_2_0:showOptions(var_2_1)
end

function var_0_1.showOptions(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getContentSize()
	local var_5_1 = LocalData:getSetting()

	arg_5_0.checkboxTags = {
		tagPush = 3,
		tagGameEffect = 5,
		tagMuteGE = 2,
		tagBackMusic = 4,
		tagMuteBM = 1
	}
	arg_5_0.checkboxGroups = {
		{
			x = 150,
			y = 225,
			tag = arg_5_0.checkboxTags.tagMuteBM,
			checked = not var_5_1.musicEnabled
		},
		{
			x = 400,
			y = 225,
			tag = arg_5_0.checkboxTags.tagMuteGE,
			checked = not var_5_1.effectEnabled
		},
		{
			x = 150,
			y = 50,
			tag = arg_5_0.checkboxTags.tagPush,
			checked = var_5_1.pushEnabled
		}
	}

	addLabelWithColorSize(arg_5_1, string.lf("关闭音乐"), ccc3(0, 0, 0), 20, CCPoint(1, 0.5), CCPoint(120, 225))
	addLabelWithColorSize(arg_5_1, string.lf("关闭音效"), ccc3(0, 0, 0), 20, CCPoint(1, 0.5), CCPoint(370, 225))
	addLabelWithColorSize(arg_5_1, string.lf("消息推送"), ccc3(0, 0, 0), 20, CCPoint(1, 0.5), CCPoint(120, 50))
	arg_5_0:addCheckbox(arg_5_1)
	addLabelWithColorSize(arg_5_1, string.lf("音乐"), ccc3(0, 0, 0), 20, CCPoint(1, 0.5), CCPoint(120, 160))

	arg_5_0.sliderMusic = arg_5_0:addCtrlSlider(arg_5_1, CCPoint(345, 160), arg_5_0.checkboxTags.tagMuteBM)

	arg_5_0.sliderMusic:setVolumeValue(arg_5_0.checkboxTags.tagMuteBM, var_5_1.musicVolume)
	addLabelWithColorSize(arg_5_1, string.lf("音效"), ccc3(0, 0, 0), 20, CCPoint(1, 0.5), CCPoint(120, 100))

	arg_5_0.sliderEffect = arg_5_0:addCtrlSlider(arg_5_1, CCPoint(345, 100), arg_5_0.checkboxTags.tagMuteGE)

	arg_5_0.sliderEffect:setVolumeValue(arg_5_0.checkboxTags.tagMuteGE, var_5_1.effectVolume)

	local var_5_2 = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		highlightedImage = "ui/common/common_019.png",
		text = string.lf("恢复默认"),
		textColor = ColorTable.eTitleButton_Normal2,
		fontSize = ColorTable.eTitleButton_FontSize2,
		anchorPoint = CCPoint(0.5, 0.5),
		position = CCPoint(var_5_0.width * 0.3, 30),
		clickAction = function(arg_6_0, arg_6_1)
			LocalData:restoreSetting()

			local var_6_0 = LocalData:getSetting()

			arg_5_0.sliderMusic:setVolumeValue(arg_5_0.checkboxTags.tagMuteBM, var_6_0.musicVolume)
			arg_5_0.sliderEffect:setVolumeValue(arg_5_0.checkboxTags.tagMuteGE, var_6_0.effectVolume)
			arg_5_0:setCheckBoxEnabled(arg_5_0.checkboxTags.tagMuteBM, not var_6_0.musicEnabled)
			arg_5_0:setCheckBoxEnabled(arg_5_0.checkboxTags.tagMuteGE, not var_6_0.effectEnabled)
			arg_5_0:setCheckBoxEnabled(arg_5_0.checkboxTags.tagPush, var_6_0.pushEnabled)
		end
	})
	local var_5_3 = ui.newControlButton({
		normalImage = "ui/common/common_019.png",
		highlightedImage = "ui/common/common_019.png",
		text = string.lf("确定"),
		textColor = ColorTable.eTitleButton_Normal2,
		fontSize = ColorTable.eTitleButton_FontSize2,
		anchorPoint = CCPoint(0.5, 0.5),
		position = CCPoint(var_5_0.width * 0.7, 30),
		clickAction = handler(arg_5_0, arg_5_0.removeSelfAndSaveSetting)
	})

	arg_5_0.bgSprite:addChild(var_5_2)
	arg_5_0.bgSprite:addChild(var_5_3)
end

function var_0_1.setCheckBoxEnabled(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == arg_7_0.checkboxTags.tagMuteBM then
		LocalData:setMusicEnabled(not arg_7_2)

		if arg_7_2 == false and isGameBackgroundMusicPlaying() == false then
			playGameBackgroundMusic(_IDLE_GAME_MUSIC_HOME)
		elseif arg_7_2 == true then
			stopGameBackgroundMusic()
		end
	elseif arg_7_1 == arg_7_0.checkboxTags.tagMuteGE then
		LocalData:setEffectEnabled(not arg_7_2)
	elseif arg_7_1 == arg_7_0.checkboxTags.tagPush then
		LocalData:setPushEnabled(arg_7_2)
	end

	arg_7_0:setCheckStatusByTag(arg_7_1, arg_7_2)
end

function var_0_1.addCheckbox(arg_8_0, arg_8_1)
	local var_8_0 = ui.newMenu({})

	local function var_8_1(arg_9_0, arg_9_1)
		for iter_9_0, iter_9_1 in pairs(arg_8_0.checkboxGroups) do
			if iter_9_0 == arg_9_0 then
				arg_8_0:setCheckBoxEnabled(iter_9_1.tag, not iter_9_1.checked)

				break
			end
		end
	end

	for iter_8_0, iter_8_1 in pairs(arg_8_0.checkboxGroups) do
		iter_8_1.listener = var_8_1
		iter_8_1.image = var_0_3

		local var_8_2 = ui.newImageMenuItem(iter_8_1)

		var_8_2:setAnchorPoint(CCPoint(0, 0.5))

		local var_8_3 = display.newSprite(var_0_4)

		var_8_3:setAnchorPoint(CCPoint(0, 0))
		var_8_3:setPosition(CCPoint(0, 0))
		var_8_3:setVisible(iter_8_1.checked)
		var_8_2:addChild(var_8_3)

		iter_8_1.ctrlName = var_8_3

		var_8_0:addChild(var_8_2)
	end

	arg_8_1:addChild(var_8_0)
end

function var_0_1.setCheckStatusByTag(arg_10_0, arg_10_1, arg_10_2)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.checkboxGroups) do
		if arg_10_1 == iter_10_1.tag then
			iter_10_1.checked = arg_10_2

			iter_10_1.ctrlName:setVisible(iter_10_1.checked)

			break
		end
	end
end

function var_0_1.addCtrlSlider(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local function var_11_0(arg_12_0, arg_12_1)
		if arg_12_1 < 0 or arg_12_1 > 100 then
			return
		end

		if arg_12_0 == arg_11_0.checkboxTags.tagMuteBM then
			LocalData:setMusicVolume(arg_12_1)
		else
			LocalData:setEffectVolume(arg_12_1)
		end
	end

	local var_11_1 = var_0_0.createSliderNode(101, function(arg_13_0, arg_13_1)
		var_11_0(arg_11_3, arg_13_1 - 1)
	end)

	var_11_1:setAnchorPoint(CCPoint(0.5, 0.5))
	var_11_1:setPosition(arg_11_2)
	arg_11_1:addChild(var_11_1)

	function var_11_1.setVolumeValue(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_2 >= 0 and arg_14_2 <= 100 then
			arg_14_0:setValue(arg_14_2 + 1)
		end
	end

	local var_11_2 = ui.newControlButton({
		normalImage = "ui/system/system_007.png",
		anchorPoint = CCPoint(0.5, 0.5),
		position = ccp(arg_11_2.x - 175, arg_11_2.y),
		clickAction = function()
			local var_15_0 = var_11_1:getValue() - 1

			if var_15_0 >= 0 and var_15_0 <= 100 then
				var_11_1:setVolumeValue(arg_11_3, var_15_0 - 1)
			end
		end
	})
	local var_11_3 = ui.newControlButton({
		normalImage = "ui/system/system_005.png",
		anchorPoint = CCPoint(0.5, 0.5),
		position = ccp(arg_11_2.x + 175, arg_11_2.y),
		clickAction = function()
			local var_16_0 = var_11_1:getValue() - 1

			if var_16_0 >= 0 and var_16_0 <= 100 then
				var_11_1:setVolumeValue(arg_11_3, var_16_0 + 1)
			end
		end
	})

	arg_11_1:addChild(var_11_2)
	arg_11_1:addChild(var_11_3)

	return var_11_1
end

function var_0_1.removeSelfAndSaveSetting(arg_17_0, arg_17_1, arg_17_2)
	LocalData:saveLocalData()
	arg_17_0:removeFromParentAndCleanup(true)

	if var_0_2 then
		var_0_2()
	end
end

return var_0_1
