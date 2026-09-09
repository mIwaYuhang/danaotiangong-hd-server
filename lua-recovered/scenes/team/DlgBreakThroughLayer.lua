require("base.figure")

local var_0_0 = class("DlgBreakThroughLayer", function()
	return CCLayerColor:create(ccc4(10, 10, 10, 160))
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	local var_2_0 = display.newScale9Sprite("ui/common/common_116.png")

	arg_2_0.bgSize = CCSize(850, 500)

	var_2_0:setPreferredSize(arg_2_0.bgSize)
	var_2_0:setScale(Adapter.MinScale)
	var_2_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_0:setPosition(display.cx, display.cy)
	arg_2_0:addChild(var_2_0)

	arg_2_0.background = CCNode:create()

	arg_2_0.background:setContentSize(arg_2_0.bgSize)
	var_2_0:addChild(arg_2_0.background)
	arg_2_0:refreshLayer(arg_2_1)
end

function var_0_0.refreshLayer(arg_4_0, arg_4_1)
	arg_4_0.background:removeAllChildrenWithCleanup(true)

	arg_4_0.closeCallback = arg_4_1.closeCallback
	arg_4_0.oldHero = arg_4_1.oldHero
	arg_4_0.newHero = arg_4_1.newHero

	arg_4_0:showOldHero(arg_4_0.oldHero)
	arg_4_0:showNewHero(arg_4_0.newHero)

	local var_4_0 = display.newSprite("ui/team/team_076.png")

	var_4_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_4_0:setPosition(arg_4_0.bgSize.width / 2, arg_4_0.bgSize.height * 2 / 3)
	arg_4_0.background:addChild(var_4_0)

	local var_4_1 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		text = string.lf("确定"),
		textColor = ColorTable.eTitleButton_Normal2,
		fontSize = ColorTable.eTitleButton_FontSize2,
		position = ccp(arg_4_0.bgSize.width / 2, 40),
		clickAction = function(arg_5_0, arg_5_1)
			if arg_4_0.closeCallback then
				arg_4_0.closeCallback()
			end

			arg_4_0:removeFromParentAndCleanup(true)
		end
	})

	arg_4_0.background:addChild(var_4_1)

	local function var_4_2(...)
		if Player:getTroMaxStep() == NSStep.ZhanYi6Reward then
			GuideLayer:showNewbieGuideLayer(nil, arg_4_0.background, 19, function()
				if arg_4_0.closeCallback then
					arg_4_0.closeCallback()
				end

				arg_4_0:removeFromParentAndCleanup(true)

				return true
			end, nil, nil, true)
		end
	end

	local var_4_3 = arg_4_0:showHeroTuPoEffect(function(...)
		local var_8_0 = arg_4_0:showHeroTuPoEffect(var_4_2, true)

		var_8_0:setPosition(ccp(arg_4_0.bgSize.width * 0.8, arg_4_0.bgSize.height * 0.7))
		arg_4_0.background:addChild(var_8_0)
	end)

	var_4_3:setPosition(ccp(arg_4_0.bgSize.width * 0.2, arg_4_0.bgSize.height * 0.7))
	arg_4_0.background:addChild(var_4_3)
end

function var_0_0.showHeroTuPoEffect(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = "effectAni/buff_bianshen.json"
	local var_9_1 = "effectAni/buff_bianshen.atlas"

	if arg_9_2 == true then
		var_9_0, var_9_1 = "effectAni/buff_tupo.json", "effectAni/buff_tupo.atlas"
	end

	local var_9_2 = CCSkeletonAnimation:createWithFile(var_9_0, var_9_1, 1)

	var_9_2:setToSetupPose()
	var_9_2:setAnimation("animation", false, 0)
	var_9_2:setTest(0.7142857142857143, false, false, true)
	var_9_2:addAnimationAction("animation", 1, CCCallFunc:create(arg_9_1), AAT_Percent)

	return var_9_2
end

function var_0_0.showOldHero(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.heroId
	local var_10_1 = {
		isViewQuality = true,
		isViewBaseInfo = false,
		scale = 0.7,
		figId = var_10_0,
		equipId = getHeroGroupWeaponId(var_10_0),
		pinjie = EquipPinjieType.eShengPin,
		rebirthCount = arg_10_1.rebirthCount
	}
	local var_10_2 = figure.createHero(var_10_1)

	var_10_2:setAnchorPoint(CCPoint(0.5, 0.5))
	var_10_2:setPosition(arg_10_0.bgSize.width * 0.2, arg_10_0.bgSize.height * 0.3)
	arg_10_0.background:addChild(var_10_2)

	local var_10_3 = BaseHeros[var_10_0]
	local var_10_4 = string.format("【%s】%s+%d", HeroProfessionNames[var_10_3.profession], var_10_3.name, arg_10_1.rebirthCount)
	local var_10_5 = ui.newTTFLabelWithOutline({
		text = var_10_4,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(25),
		align = ui.TEXT_ALIGN_CENTER,
		color = getQualityColor(var_10_3.quality)
	})

	var_10_5:setAnchorPoint(CCPoint(0.5, 0))
	var_10_5:setPosition(arg_10_0.bgSize.width * 0.2, arg_10_0.bgSize.height - 30)
	arg_10_0.background:addChild(var_10_5)
end

function var_0_0.showNewHero(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.heroId
	local var_11_1 = {
		isViewQuality = true,
		isViewBaseInfo = false,
		scale = 0.7,
		figId = var_11_0,
		equipId = getHeroGroupWeaponId(var_11_0),
		pinjie = EquipPinjieType.eShengPin,
		rebirthCount = arg_11_1.rebirthCount
	}
	local var_11_2 = figure.createHero(var_11_1)

	var_11_2:setAnchorPoint(CCPoint(0.5, 0.5))
	var_11_2:setPosition(arg_11_0.bgSize.width * 0.8, arg_11_0.bgSize.height * 0.3)
	arg_11_0.background:addChild(var_11_2)

	local var_11_3 = BaseHeros[var_11_0]
	local var_11_4 = string.format("【%s】%s+%d", HeroProfessionNames[var_11_3.profession], var_11_3.name, arg_11_1.rebirthCount)
	local var_11_5 = ui.newTTFLabelWithOutline({
		text = var_11_4,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(25),
		align = ui.TEXT_ALIGN_CENTER,
		color = getQualityColor(var_11_3.quality)
	})

	var_11_5:setAnchorPoint(CCPoint(0.5, 0))
	var_11_5:setPosition(arg_11_0.bgSize.width * 0.8, arg_11_0.bgSize.height - 30)
	arg_11_0.background:addChild(var_11_5)

	local var_11_6 = var_0_0.addRebirthDescHandler(arg_11_1.rebirthCount, var_11_0, 260)

	var_11_6:setPosition(ccp(300, 200))
	arg_11_0.background:addChild(var_11_6)
end

function var_0_0.addRebirthDescHandler(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = display.newNode()

	local function var_12_1(arg_13_0)
		local var_13_0 = string.gsub(arg_13_0, "%{.-%}", function(arg_14_0)
			local var_14_0 = string.sub(arg_14_0, 2, string.len(arg_14_0) - 1)

			return "#4BE914" .. var_14_0 .. "#F7D35B"
		end)

		if string.byte(arg_13_0, -1) == 125 then
			var_13_0 = string.sub(var_13_0, 1, string.len(var_13_0) - 7)
		end

		return var_13_0
	end

	local var_12_2 = 0

	if arg_12_0 > 0 then
		local var_12_3 = getHeroCurrentRebirthCountAttrs(arg_12_1, arg_12_0)
		local var_12_4 = var_12_3.desc

		if arg_12_2 == nil then
			local var_12_5 = {
				var_12_4.attrDescList1,
				var_12_4.attrDescList2
			}

			for iter_12_0, iter_12_1 in ipairs(var_12_5) do
				for iter_12_2, iter_12_3 in ipairs(iter_12_1) do
					local var_12_6 = (iter_12_2 - 1) % 3 * 135
					local var_12_7 = -math.floor((iter_12_2 - 1) / 3) * 25 + var_12_2

					addLabelWithColorSize(var_12_0, var_12_1(iter_12_3), ccc3(247, 211, 91), 20, ccp(0, 1), ccp(var_12_6, var_12_7))
				end

				local var_12_8 = table.getn(iter_12_1)

				var_12_2 = var_12_2 - math.floor((var_12_8 + 2) / 3) * 25
			end
		elseif var_12_4.attrDescList2 then
			local var_12_9 = var_12_1(table.concat(var_12_4.attrDescList2, ", "))
			local var_12_10 = Platform.getStringDrawHeight({
				fontSize = 20,
				text = var_12_9,
				fontName = _FONT_DEFAULT,
				width = arg_12_2
			})
			local var_12_11 = ui.newTTFLabel({
				text = var_12_9,
				font = _FONT_DEFAULT,
				size = Adapter.FontSize(20),
				align = ui.TEXT_ALIGN_LEFT,
				color = ccc3(247, 211, 91),
				dimensions = CCSize(arg_12_2, var_12_10)
			})

			var_12_11:setAnchorPoint(ccp(0, 1))
			var_12_11:setPosition(0, var_12_2)
			var_12_0:addChild(var_12_11)

			var_12_2 = var_12_2 - var_12_10 - 2
		end

		local function var_12_12(arg_15_0, arg_15_1)
			if string.find(arg_15_0, "{") then
				return (string.gsub(arg_15_0, "%{.-%}", function(arg_16_0)
					local var_16_0 = string.sub(arg_16_0, 2, string.len(arg_16_0) - 1)
					local var_16_1 = "math.showDecimal(" .. var_16_0 .. ", 2)"
					local var_16_2 = "function getRebirthRageSkillFinalValue(rn) return tostring(" .. var_16_1 .. ") end"

					loadstring(var_16_2)()

					return getRebirthRageSkillFinalValue(arg_15_1)
				end))
			end

			return arg_15_0
		end

		if table.getn(var_12_4) >= 1 then
			for iter_12_4 = 1, table.getn(var_12_4) do
				if string.find(var_12_4[iter_12_4], "@") == 1 then
					local var_12_13 = string.sub(var_12_4[iter_12_4], 2)

					if arg_12_2 == nil then
						addLabelWithColorSize(var_12_0, var_12_12(var_12_13, arg_12_0), ccc3(247, 133, 0), 22, ccp(0, 1), ccp(0, var_12_2), _FONT_LISU)

						var_12_2 = var_12_2 - 25
					else
						local var_12_14 = Platform.getStringDrawHeight({
							fontSize = 22,
							text = var_12_13,
							fontName = _FONT_DEFAULT,
							width = arg_12_2
						})
						local var_12_15 = ui.newTTFLabel({
							text = var_12_13,
							font = _FONT_LISU,
							size = Adapter.FontSize(22),
							align = ui.TEXT_ALIGN_LEFT,
							color = ccc3(247, 133, 0),
							dimensions = CCSize(arg_12_2, var_12_14)
						})

						var_12_15:setAnchorPoint(ccp(0, 1))
						var_12_15:setPosition(0, var_12_2)
						var_12_0:addChild(var_12_15)

						var_12_2 = var_12_2 - var_12_14 - 2
					end
				else
					local var_12_16 = arg_12_2 or 360
					local var_12_17 = var_12_1(var_12_4[iter_12_4])
					local var_12_18 = Platform.getStringDrawHeight({
						fontSize = 20,
						text = var_12_17,
						fontName = _FONT_DEFAULT,
						width = var_12_16
					})
					local var_12_19 = ui.newTTFLabel({
						x = 0,
						text = var_12_17,
						font = _FONT_DEFAULT,
						size = Adapter.FontSize(20),
						color = ccc3(247, 211, 91),
						align = ui.TEXT_ALIGN_LEFT,
						dimensions = CCSize(var_12_16, var_12_18),
						y = var_12_2
					})

					var_12_19:setAnchorPoint(ccp(0.5, 1))
					var_12_0:addChild(var_12_19)

					var_12_2 = var_12_2 - var_12_18 - 2
				end
			end
		end

		if var_12_3.dobyChanged == true and arg_12_2 == nil then
			local var_12_20 = display.newSprite("ui/tower/tower_033.png", 335, -97)

			var_12_0:addChild(var_12_20)

			local var_12_21 = var_12_20:getContentSize()

			addLabelWithColorSize(var_12_20, string.lf("进阶变身"), ccc3(247, 211, 91), 20, ccp(0.5, 0.5), ccp(var_12_21.width / 2, var_12_21.height / 2))
		end
	else
		addLabelWithColorSize(var_12_0, string.lf("上仙，请收集进阶所需材料\n进阶后，主将能力将获得大幅度提升!"), ccc3(247, 211, 91), 20, ccp(0, 1), ccp(0, var_12_2))
	end

	return var_12_0, math.abs(var_12_2)
end

return var_0_0
