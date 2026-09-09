require("data.hero")
require("data.equip")
require("data.mineral")

figure = {}

function figure.createHero(arg_1_0)
	local var_1_0

	arg_1_0.scale = arg_1_0.scale or 1
	arg_1_0.platTable = arg_1_0.platTable == nil and true or arg_1_0.platTable
	arg_1_0.isViewQuality = arg_1_0.isViewQuality == nil and true or arg_1_0.isViewQuality
	arg_1_0.starImage = arg_1_0.starImage or "ui/team/team_131.png"

	local var_1_1 = CCNode:create()

	var_1_1:setScale(arg_1_0.scale)

	if arg_1_0.figId and BaseHeros[arg_1_0.figId] or not arg_1_0.figId and arg_1_0.enemyId or arg_1_0.transAnim then
		local var_1_2 = ""
		local var_1_3 = ""

		if not arg_1_0.figId and arg_1_0.enemyId then
			var_1_2 = string.format("heroani/%s.json", BaseNPCs[arg_1_0.enemyId].animation)
			var_1_3 = string.format("heroani/%s.atlas", BaseNPCs[arg_1_0.enemyId].animation)
			var_1_0 = BaseNPCs[arg_1_0.enemyId].haveWing
		elseif not arg_1_0.enemyId and arg_1_0.figId then
			var_1_2 = string.format("heroani/%s.json", BaseHeros[arg_1_0.figId].animation)
			var_1_3 = string.format("heroani/%s.atlas", BaseHeros[arg_1_0.figId].animation)
		elseif arg_1_0.transAnim then
			var_1_2 = string.format("heroani/%s.json", arg_1_0.transAnim)
			var_1_3 = string.format("heroani/%s.atlas", arg_1_0.transAnim)
		end

		if arg_1_0.platTable then
			local var_1_4 = {
				"plat_hero_green.png",
				"plat_hero_blue.png",
				"plat_hero_purple.png",
				"plat_hero_orange.png"
			}
			local var_1_5 = display.newSprite("ui/common/" .. var_1_4[BaseHeros[arg_1_0.figId].quality])

			var_1_5:setPosition(0, 76.9)
			var_1_5:setScale(1.538)
			var_1_1:addChild(var_1_5)
		end

		local var_1_6 = CCSkeletonAnimation:createWithFile(var_1_2, var_1_3, 1)

		var_1_6:setAnimation("daiji", true, 0)
		var_1_6:setPosition(0, arg_1_0.platTable and 260 or 160)
		var_1_1:addChild(var_1_6, 0)

		var_1_1.Skeleton = var_1_6
		var_1_1.heroId = arg_1_0.figId or arg_1_0.enemyId

		if arg_1_0.rotation then
			var_1_6:setRotationY(180)
		end

		if arg_1_0.opacity then
			var_1_6:setOpacity(arg_1_0.opacity)
		end

		if arg_1_0.clickAction then
			local var_1_7 = ui.newControlButton({
				normalImage = "ui/common/common_024.png",
				position = ccp(0, arg_1_0.platTable and 240 or 160),
				clickAction = arg_1_0.clickAction or function(arg_2_0, arg_2_1)
					return
				end,
				size = CCSize(250, 350)
			})

			var_1_7:setOpacity(0)
			var_1_1:addChild(var_1_7)

			if arg_1_0.touchDownAction then
				var_1_7:addHandleOfControlEvent(arg_1_0.touchDownAction, CCControlEventTouchDown)
			end

			if arg_1_0.touchCancelAction then
				var_1_7:addHandleOfControlEvent(arg_1_0.touchCancelAction, CCControlEventTouchUpOutside)
				var_1_7:addHandleOfControlEvent(arg_1_0.touchCancelAction, CCControlEventTouchCancel)
			end

			var_1_1.clickButton = var_1_7
		end

		if arg_1_0.isViewQuality then
			local var_1_8 = arg_1_0.starImage
			local var_1_9 = BaseHeros[arg_1_0.figId].quality + 1

			if arg_1_0.figId == 502 or arg_1_0.figId == 501 then
				var_1_9 = 1
			end

			local var_1_10 = CCTextureCache:sharedTextureCache():addImage(var_1_8):getContentSizeInPixels()
			local var_1_11 = arg_1_0.starScale or 1
			local var_1_12 = var_1_10.width * var_1_11
			local var_1_13 = arg_1_0.qualitySpaceWidth or 1
			local var_1_14 = {}
			local var_1_15 = var_1_9 * var_1_12 + (var_1_9 - 1) * var_1_13
			local var_1_16 = 0 - var_1_15 / 2 + var_1_12 / 2
			local var_1_17 = 0 + (arg_1_0.qualityOffsetY and arg_1_0.qualityOffsetY or 0)
			local var_1_18 = display.newSprite("ui/team/team_130.png", var_1_16 - var_1_12 / 2, var_1_17)

			var_1_18:setAnchorPoint(ccp(1, 0.5))
			var_1_18:setScale(var_1_11)
			var_1_1:addChild(var_1_18)

			local var_1_19 = display.newSprite("ui/team/team_129.png", var_1_16 + var_1_15 - var_1_12 / 2, var_1_17)

			var_1_19:setAnchorPoint(ccp(0, 0.5))
			var_1_19:setScale(var_1_11)
			var_1_1:addChild(var_1_19)

			for iter_1_0 = 1, var_1_9 do
				local var_1_20 = display.newSprite(var_1_8, var_1_16, var_1_17)

				if arg_1_0.isStarAction == true then
					var_1_20:setScale(12 * var_1_11)
					var_1_20:setVisible(false)
					var_1_20:setPosition(var_1_16, var_1_17 + 100)
					var_1_20:setOpacity(20)
				else
					var_1_20:setScale(var_1_11)
				end

				var_1_1:addChild(var_1_20)
				table.insert(var_1_14, {
					node = var_1_20,
					toPos = ccp(var_1_16, var_1_17),
					toScale = var_1_11
				})

				var_1_16 = var_1_16 + var_1_12 + var_1_13
			end

			function var_1_1.setStarsColor(arg_3_0, ...)
				for iter_3_0 = 1, #var_1_14 do
					var_1_14[iter_3_0].node:setColor(...)
				end

				var_1_18:setColor(...)
				var_1_19:setColor(...)
			end

			if arg_1_0.isStarAction == true and #var_1_14 > 0 then
				local var_1_21 = 0

				local function var_1_22()
					local var_4_0 = math.random(-2, 2)
					local var_4_1 = -var_4_0
					local var_4_2 = CCArray:create()

					var_4_2:addObject(CCMoveBy:create(0.02, ccp(var_4_0, var_4_0)))
					var_4_2:addObject(CCMoveBy:create(0.02, ccp(var_4_1, var_4_1)))
					var_4_2:addObject(CCMoveBy:create(0.02, ccp(var_4_0, var_4_1)))
					var_4_2:addObject(CCMoveBy:create(0.02, ccp(var_4_1, var_4_0)))
					var_1_1:runAction(CCSequence:create(var_4_2))
				end

				local function var_1_23(arg_5_0)
					var_1_21 = var_1_21 + 1

					if var_1_14[var_1_21] then
						var_1_14[var_1_21].node:setVisible(true)

						local var_5_0 = CCArray:create()

						if arg_5_0 and arg_5_0 > 0 then
							var_5_0:addObject(CCDelayTime:create(arg_5_0))
						end

						local var_5_1 = 0.3
						local var_5_2 = CCArray:create()

						var_5_2:addObject(CCEaseIn:create(CCScaleTo:create(var_5_1, var_1_14[var_1_21].toScale), 8))
						var_5_2:addObject(CCEaseIn:create(CCMoveTo:create(var_5_1, var_1_14[var_1_21].toPos), 8))
						var_5_2:addObject(CCEaseIn:create(CCFadeTo:create(var_5_1, 255), 8))

						local var_5_3 = CCSpawn:create(var_5_2)

						var_5_0:addObject(var_5_3)
						transition.execute(var_1_14[var_1_21].node, CCSequence:create(var_5_0), {
							onComplete = function()
								playEffect(ButtonAudio.equip_enhance)
								var_1_22()
								var_1_23()
							end
						})
					end
				end

				var_1_18:setOpacity(0)
				var_1_19:setOpacity(0)
				transition.execute(var_1_18, CCFadeTo:create(#var_1_14 * 0.3, 255))
				transition.execute(var_1_19, CCFadeTo:create(#var_1_14 * 0.3, 255))
				var_1_23(0.08)
			end
		end

		if not arg_1_0.rebirthCount or arg_1_0.rebirthCount <= 0 then
			arg_1_0.rebirthCount = 0
		end

		if arg_1_0.rebirthCount or arg_1_0.equipId then
			local var_1_24 = {
				figureNode = var_1_1,
				rebirthCount = arg_1_0.rebirthCount,
				equipId = arg_1_0.equipId,
				pinjie = arg_1_0.pinjie,
				wing = var_1_0
			}

			if arg_1_0.figId then
				var_1_24.heroId = arg_1_0.figId
			elseif arg_1_0.enemyId then
				var_1_24.enemyId = arg_1_0.enemyId
			end

			figure.setupFigure(var_1_24)
		end
	end

	return var_1_1
end

function figure.createHeader(arg_7_0)
	if arg_7_0 ~= nil and arg_7_0.type == ItemType.eMineral then
		return figure.createMineralHeader(arg_7_0)
	end

	local var_7_0 = CCNode:create()
	local var_7_1
	local var_7_2
	local var_7_3
	local var_7_4
	local var_7_5 = 0
	local var_7_6 = ({
		[ItemType.eSoul] = BaseSouls,
		[ItemType.eProp] = BaseProps,
		[ItemType.eMate] = BaseMates,
		[ItemType.eHero] = BaseHeros,
		[ItemType.eEquip] = BaseEquips,
		[ItemType.eFragment] = BaseFragments,
		[ItemType.eTianMing] = BaseTianMings,
		[ItemType.eMaster] = BaseMasters
	})[arg_7_0.type]

	if not arg_7_0.itemId then
		arg_7_0.itemId = 0
	elseif arg_7_0.itemId > 0 and var_7_6 and not var_7_6[arg_7_0.itemId] then
		arg_7_0.itemId = 0
	end

	if arg_7_0.itemId > 0 then
		var_7_1 = getItemHeaderImagePath(arg_7_0.type, arg_7_0.itemId)
		var_7_5 = getItemQuality(arg_7_0.type, arg_7_0.itemId)

		if arg_7_0.isStoreBkground and arg_7_0.isStoreBkground == true then
			var_7_2 = var_7_5 == 0 and "ui/store/store_028.png" or getQualityStoreImage(var_7_5)
		elseif arg_7_0.type == ItemType.eTianMing then
			var_7_2 = var_7_5 == 0 and "ui/common/common_011.png" or getQualityRoundBgImageName(var_7_5)
		else
			var_7_2 = var_7_5 == 0 and "ui/common/common_005.png" or getQualityBgImageName(var_7_5)
		end
	elseif arg_7_0.itemId < 0 then
		if arg_7_0.isXiaoHuoBan == true then
			var_7_1 = "ui/team/team_077.png"
		else
			var_7_1 = "ui/common/common_006.png"
		end
	else
		var_7_2 = "ui/common/common_005.png"

		if arg_7_0.type == ItemType.eHero or arg_7_0.type == ItemType.eSoul or arg_7_0.type == ItemType.eProp or arg_7_0.type == ItemType.eMate or arg_7_0.type == ItemType.eFragment or arg_7_0.type == 0 then
			var_7_1 = "ui/common/common_005.png"
		elseif arg_7_0.type == ItemType.eTianMing then
			var_7_1 = "ui/common/common_011.png"
			var_7_2 = nil
		elseif arg_7_0.type == ItemType.eEquip then
			local var_7_7 = {
				[EquipType.eWeapon] = "ui/team/zj_045.png",
				[EquipType.eAmulet] = "ui/team/zj_046.png",
				[EquipType.eHelmet] = "ui/team/zj_047.png",
				[EquipType.eClothes] = "ui/team/zj_048.png",
				[EquipType.eNecklace] = "ui/team/zj_049.png",
				[EquipType.eRing] = "ui/team/zj_050.png"
			}

			var_7_1 = arg_7_0.noTypeImage == true and "ui/common/common_005.png" or var_7_7[arg_7_0.equipType]
		elseif arg_7_0.type == ItemType.eMaster then
			var_7_1 = getItemHeaderImagePath(arg_7_0.type, arg_7_0.itemId)
		else
			var_7_1 = getItemHeaderImagePath(arg_7_0.type)
		end
	end

	if var_7_2 then
		var_7_0.qualitySprite = CCSprite:create(var_7_2)

		var_7_0:addChild(var_7_0.qualitySprite)
	end

	var_7_0.selectedSprite = CCSprite:create("ui/common/bg_choosed_cube.png")

	var_7_0:addChild(var_7_0.selectedSprite)
	var_7_0.selectedSprite:setVisible(arg_7_0.isSelected == true)

	local var_7_8 = "ui/common/common_006.png"
	local var_7_9 = CCSprite:create(var_7_8)

	var_7_9:setVisible(false)
	var_7_0:addChild(var_7_9)

	var_7_0.headerButton = ui.newControlButton({
		normalImage = var_7_1,
		clickAction = arg_7_0.clickAction
	})

	var_7_0.headerButton:setEnabled(arg_7_0.clickAction ~= nil)
	var_7_0:addChild(var_7_0.headerButton)

	if arg_7_0.isGroupHero == true then
		var_7_0.heroGroupSprite = display.newSprite("ui/team/team_aide_effect.png")

		local var_7_10 = CCArray:create()

		var_7_10:addObject(CCSpawn:createWithTwoActions(CCScaleTo:create(0, 0.3), CCFadeTo:create(0, 127.5)))
		var_7_10:addObject(CCSpawn:createWithTwoActions(CCScaleTo:create(0.4, 0.9), CCFadeTo:create(0.4, 255)))
		var_7_10:addObject(CCScaleTo:create(0.2, 1.15))
		var_7_10:addObject(CCSpawn:createWithTwoActions(CCScaleTo:create(0.4, 1.4), CCFadeTo:create(0.4, 0)))
		var_7_0.heroGroupSprite:runAction(CCRepeatForever:create(CCSequence:create(var_7_10)))
		var_7_0:addChild(var_7_0.heroGroupSprite)
	end

	if arg_7_0.type == ItemType.eTianMing and arg_7_0.itemId ~= 0 then
		local var_7_11 = var_7_6[arg_7_0.itemId].type
		local var_7_12 = var_7_6[arg_7_0.itemId].quality

		if var_7_11 ~= TianMingType.eType7 then
			local var_7_13 = {
				"mingge1",
				"mingge2",
				"mingge3",
				"mingge4",
				"mingge5",
				"mingge6"
			}
			local var_7_14 = {
				"lv",
				"lan",
				"zi",
				"cheng"
			}
			local var_7_15 = var_7_13[var_7_11] .. "_" .. var_7_14[var_7_12]

			var_7_0.tianmingEffect = CCSkeletonAnimation:createWithFile("effectAni/ui_mingge.json", "effectAni/ui_mingge.atlas", 1)

			var_7_0.tianmingEffect:setToSetupPose()
			var_7_0.tianmingEffect:setAnimation(var_7_15, true, 0)
			var_7_0.tianmingEffect:setPosition(0, 0)
			var_7_0:addChild(var_7_0.tianmingEffect)
		end
	end

	if arg_7_0.count and arg_7_0.count > 0 and arg_7_0.type ~= ItemType.eEquip then
		local function var_7_16(arg_8_0)
			arg_8_0 = math.floor(arg_8_0)

			if arg_8_0 > 10000 then
				arg_8_0 = math.floor(arg_8_0 / 10000)

				return string.lf("%s万", arg_8_0)
			end

			return tostring(arg_8_0)
		end

		var_7_0.numLabel = ui.newTTFLabel({
			y = -28,
			x = 25,
			text = tostring(var_7_16(arg_7_0.count)),
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(20),
			align = ui.TEXT_ALIGN_CENTER,
			color = arg_7_0.countColor or display.COLOR_WHITE
		})

		var_7_0:addChild(var_7_0.numLabel)
	end

	if arg_7_0.itemId > 0 and arg_7_0.level and arg_7_0.level >= 0 then
		var_7_0.levelNode = createNumberWidthBgSprite(getItemLevelNumBgImage(var_7_5), arg_7_0.level, 16, 5)

		var_7_0.levelNode:setPosition(ccp(25, 25))
		var_7_0:addChild(var_7_0.levelNode)
	end

	if arg_7_0.itemId > 0 and arg_7_0.inTeam == true then
		var_7_0.inTeamSprite = CCSprite:create("ui/enhance/enhance_002.png")

		var_7_0.inTeamSprite:setPosition(22, -26)
		var_7_0:addChild(var_7_0.inTeamSprite)
	end

	if arg_7_0.itemId > 0 and arg_7_0.inParternTeam == true then
		var_7_0.inParternTeamSprite = CCSprite:create("ui/common/common_126.png")

		var_7_0.inParternTeamSprite:setPosition(22, -26)
		var_7_0:addChild(var_7_0.inParternTeamSprite)
	end

	if arg_7_0.itemId > 0 and arg_7_0.recruitEnabled == true then
		var_7_0.inTeamSprite = CCSprite:create("ui/enhance/enhance_000.png")

		var_7_0.inTeamSprite:setPosition(22, -26)
		var_7_0:addChild(var_7_0.inTeamSprite)
	end

	if arg_7_0.itemId > 0 and arg_7_0.mixtureEnabled == true then
		var_7_0.inTeamSprite = CCSprite:create("ui/enhance/enhance_016.png")

		var_7_0.inTeamSprite:setPosition(-22, -26)
		var_7_0:addChild(var_7_0.inTeamSprite)
	end

	local var_7_17 = getItemName(arg_7_0.type, arg_7_0.itemId)

	if arg_7_0.isName == true and var_7_17 ~= nil then
		local var_7_18 = ccc3(188, 150, 78)

		if arg_7_0.qualityColor then
			var_7_18 = getQualityColor(var_7_5)
		elseif arg_7_0.nameColor then
			var_7_18 = arg_7_0.nameColor
		end

		var_7_0.nameLabel = ui.newTTFLabel({
			y = -53,
			x = 0,
			text = var_7_17,
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(20),
			align = ui.TEXT_ALIGN_CENTER,
			color = var_7_18
		})

		if IPlatform:instance():getConfig("Channel") == "ZSY_VN" then
			var_7_0.nameLabel:setFontSize(18)
		end

		var_7_0:addChild(var_7_0.nameLabel)
	end

	if arg_7_0.type == ItemType.eSoul then
		local var_7_19 = display.newSprite("ui/common/common_soul_small.png", -26, 2)

		var_7_0:addChild(var_7_19)
	elseif arg_7_0.type == ItemType.eFragment then
		local var_7_20 = display.newSprite("uilocal/common/common_text_011.png", -20, 26)

		var_7_0:addChild(var_7_20)
	elseif arg_7_0.type == ItemType.eHero and arg_7_0.itemId > 0 then
		local var_7_21 = display.newSprite(getProfessionIconImageName(BaseHeros[arg_7_0.itemId].profession), -22, -24)

		var_7_21:setScale(0.8)
		var_7_0:addChild(var_7_21)
	elseif arg_7_0.type == ItemType.eEquip and arg_7_0.itemId > 0 then
		if var_7_0.numLabel ~= nil then
			var_7_0.numLabel:setVisible(false)
		end

		if arg_7_0.equipJieji ~= nil then
			local var_7_22 = display.newSprite("ui/common/common_121.png", -24, -28)

			var_7_0:addChild(var_7_22)

			local var_7_23 = var_7_22:getContentSize()
			local var_7_24 = ui.newTTFLabel({
				text = "+" .. arg_7_0.equipJieji,
				font = _FONT_DEFAULT,
				size = Adapter.FontSize(16),
				align = ui.TEXT_ALIGN_CENTER,
				color = display.COLOR_WHITE,
				x = var_7_23.width / 2,
				y = var_7_23.height / 2
			})

			var_7_22:addChild(var_7_24)

			var_7_0.equipJiejiLabel = var_7_24
		end

		if arg_7_0.equipPinJie ~= nil and arg_7_0.equipPinJie > 0 then
			var_7_0.pinjieSprite = display.newSprite(getPinjieSmallImageName(arg_7_0.equipPinJie), -26, 26)

			var_7_0:addChild(var_7_0.pinjieSprite)
		end

		if arg_7_0.equipGem ~= nil and arg_7_0.equipGem.gemProtoID ~= nil and (arg_7_0.inTeam == nil or arg_7_0.inTeam == false) then
			var_7_0.gemSprite = display.newSprite(figure.getMineralIconImage(arg_7_0.equipGem.gemProtoID, arg_7_0.equipGem.level), 22, -26)

			var_7_0:addChild(var_7_0.gemSprite)
		end
	end

	if arg_7_0.isAttrUpgrade and arg_7_0.isAttrUpgrade == true then
		var_7_0.spriteLevelup = display.newSprite("ui/battle/battle_026.png", -40, 25)

		var_7_0:addChild(var_7_0.spriteLevelup)
	end

	function var_7_0.setNameLabelColor(arg_9_0, arg_9_1)
		arg_9_0.nameLabel:setFontFillColor(arg_9_1)
	end

	function var_7_0.setSelected(arg_10_0, arg_10_1)
		arg_10_0.selectedSprite:setVisible(arg_10_1)
	end

	function var_7_0.setHeaderOpacity(arg_11_0, arg_11_1)
		arg_11_0.qualitySprite:setOpacity(arg_11_1)
		arg_11_0.headerButton:setOpacity(arg_11_1)

		if arg_11_0.levelNode then
			arg_11_0.levelNode.numSprite:setOpacity(arg_11_1)
		end

		if arg_11_0.spriteLevelup then
			arg_11_0.spriteLevelup:setOpacity(arg_11_1)
		end

		if var_7_0.tianmingEffect then
			var_7_0.tianmingEffect:setOpacity(arg_11_1)
		end
	end

	function var_7_0.setLevel(arg_12_0, arg_12_1)
		arg_12_0.levelNode.numLabel:setString(tostring(arg_12_1))

		local var_12_0 = CCArray:create()
		local var_12_1 = CCScaleTo:create(0.2, 3)
		local var_12_2 = CCScaleTo:create(0.2, 1)

		var_12_0:addObject(var_12_1)
		var_12_0:addObject(var_12_2)
		arg_12_0.levelNode.numLabel:runAction(CCSequence:create(var_12_0))

		local var_12_3 = CCArray:create()
		local var_12_4 = CCScaleTo:create(0.2, 1.2)
		local var_12_5 = CCScaleTo:create(0.2, 1)

		var_12_3:addObject(var_12_4)
		var_12_3:addObject(var_12_5)
		arg_12_0.levelNode.numSprite:runAction(CCSequence:create(var_12_3))
	end

	function var_7_0.setEnabled(arg_13_0, arg_13_1)
		var_7_0.headerButton:setEnabled(arg_13_1)
		var_7_9:setVisible(not arg_13_1)
	end

	return var_7_0
end

function figure.getMineralIconImage(arg_14_0, arg_14_1)
	if arg_14_0 == nil or arg_14_0 == 0 then
		return nil
	end

	local var_14_0 = BaseMineral[arg_14_0].imageList[arg_14_1 or 1]

	if var_14_0.iconImage ~= nil and #var_14_0.iconImage > 0 then
		return "icon/" .. var_14_0.iconImage
	end
end

function figure.getMineralHeaderImage(arg_15_0, arg_15_1)
	if arg_15_0 == nil or arg_15_0 == 0 then
		return nil
	end

	local var_15_0 = BaseMineral[arg_15_0].imageList[arg_15_1 or 1]

	if var_15_0.headerImage ~= nil and #var_15_0.headerImage > 0 then
		return "prop/" .. var_15_0.headerImage
	end
end

function figure.getMineralBodyImage(arg_16_0, arg_16_1)
	if arg_16_0 == nil or arg_16_0 == 0 then
		return nil
	end

	local var_16_0 = BaseMineral[arg_16_0].imageList[arg_16_1 or 1]

	if var_16_0.bodyImage ~= nil and #var_16_0.bodyImage > 0 then
		return "body/" .. var_16_0.bodyImage
	end
end

function figure.createMineralHeader(arg_17_0)
	if arg_17_0 == nil or arg_17_0.itemId == nil then
		return
	end

	local var_17_0 = CCNode:create()
	local var_17_1 = "ui/common/common_002.png"
	local var_17_2 = arg_17_0.level or 1
	local var_17_3 = figure.getMineralHeaderImage(arg_17_0.itemId, var_17_2)

	var_17_0.qualitySprite = CCSprite:create(var_17_1)

	var_17_0:addChild(var_17_0.qualitySprite)

	var_17_0.selectedSprite = CCSprite:create("ui/common/bg_choosed_cube.png")

	var_17_0:addChild(var_17_0.selectedSprite)
	var_17_0.selectedSprite:setVisible(arg_17_0.isSelected ~= nil and arg_17_0.isSelected == true)

	if var_17_3 ~= nil and #var_17_3 > 0 then
		var_17_0.headerButton = ui.newControlButton({
			normalImage = var_17_3,
			clickAction = arg_17_0.clickAction
		})

		var_17_0.headerButton:setEnabled(arg_17_0.clickAction ~= nil)
		var_17_0:addChild(var_17_0.headerButton)
	end

	if arg_17_0.itemId > 0 and var_17_2 > 0 then
		var_17_0.levelNode = createNumberWidthBgSprite("ui/common/common_014.png", var_17_2, 16, 5)

		var_17_0.levelNode:setPosition(ccp(25, 25))
		var_17_0:addChild(var_17_0.levelNode)
	end

	if arg_17_0.itemId > 0 and arg_17_0.inTeam ~= nil and arg_17_0.inTeam == true then
		var_17_0.inTeamSprite = CCSprite:create("ui/enhance/enhance_002.png")

		var_17_0.inTeamSprite:setPosition(22, -26)
		var_17_0:addChild(var_17_0.inTeamSprite)
	end

	if arg_17_0.isName ~= nil and arg_17_0.isName == true then
		var_17_0.nameLabel = ui.newTTFLabel({
			y = -53,
			x = 0,
			text = BaseMineral[arg_17_0.itemId].name,
			font = _FONT_DEFAULT,
			color = arg_17_0.nameColor or ccc3(188, 150, 78),
			size = Adapter.FontSize(20),
			align = ui.TEXT_ALIGN_CENTER
		})

		var_17_0:addChild(var_17_0.nameLabel)
	end

	local var_17_4 = "ui/common/mask2.png"
	local var_17_5 = CCSprite:create(var_17_4)

	var_17_5:setVisible(false)
	var_17_0:addChild(var_17_5)

	function var_17_0.setSelected(arg_18_0, arg_18_1)
		arg_18_0.selectedSprite:setVisible(arg_18_1)
	end

	function var_17_0.setHeaderOpacity(arg_19_0, arg_19_1)
		if var_17_0.headerButton ~= nil then
			var_17_0.headerButton:setOpacity(arg_19_1)
		end

		var_17_0.qualitySprite:setOpacity(arg_19_1)
		var_17_0.levelNode.numSprite:setOpacity(arg_19_1)
	end

	function var_17_0.setEnabled(arg_20_0, arg_20_1)
		if var_17_0.headerButton ~= nil then
			var_17_0.headerButton:setEnabled(arg_20_1)
		end

		var_17_5:setVisible(not arg_20_1)
	end

	if arg_17_0.count and arg_17_0.count > 0 and arg_17_0.type ~= ItemType.eEquip then
		local function var_17_6(arg_21_0)
			arg_21_0 = math.floor(arg_21_0)

			if arg_21_0 > 10000 then
				arg_21_0 = math.floor(arg_21_0 / 10000)

				return string.lf("%s万", arg_21_0)
			end

			return tostring(arg_21_0)
		end

		var_17_0.numLabel = ui.newTTFLabel({
			y = -28,
			x = 25,
			text = tostring(var_17_6(arg_17_0.count)),
			font = _FONT_DEFAULT,
			size = Adapter.FontSize(20),
			align = ui.TEXT_ALIGN_CENTER,
			color = arg_17_0.countColor or display.COLOR_WHITE
		})

		var_17_0:addChild(var_17_0.numLabel)
	end

	return var_17_0
end

local function var_0_0(arg_22_0)
	local function var_22_0(arg_23_0, arg_23_1, arg_23_2)
		local var_23_0 = CCParticleSystemQuad:create(arg_23_0)
		local var_23_1 = 1

		var_23_0:setStartSize(var_23_0:getStartSize() * var_23_1)
		var_23_0:setStartSizeVar(var_23_0:getStartSizeVar() * var_23_1)
		var_23_0:setEndSize(var_23_0:getEndSize() * var_23_1)
		var_23_0:setEndSizeVar(var_23_0:getEndSizeVar() * var_23_1)
		var_23_0:setSpeed(var_23_0:getSpeed() * var_23_1)
		var_23_0:setSpeedVar(var_23_0:getSpeedVar() * var_23_1)

		local var_23_2 = var_23_0:getPosVar()

		var_23_0:setPosVar(ccp(var_23_2.x * var_23_1, var_23_2.y * var_23_1))
		var_23_0:setScale(var_23_0:getScale() * var_23_1)
		arg_23_2:addChild(var_23_0)
		var_23_0:setPosition(arg_23_1)
		var_23_0:setPositionType(kCCPositionTypeRelative)

		return var_23_0
	end

	if arg_22_0.profession == HeroProfession.eMage then
		local var_22_1 = 0
		local var_22_2 = getQualityColor(arg_22_0.quality)
		local var_22_3

		local function var_22_4(arg_24_0)
			var_22_1 = var_22_1 + arg_24_0

			if var_22_1 > 2 then
				var_22_1 = 0

				if not var_22_3 then
					local var_24_0 = var_22_0("ui/battle/BattleParticle/faqi_1.plist", ccp(0, 0), arg_22_0.parent, true)

					var_24_0:setStartColor(ccc4f(var_22_2.r / 255, var_22_2.g / 255, var_22_2.b / 255, 1))
					var_24_0:setEndColor(ccc4f(var_22_2.r / 255 / 2, var_22_2.g / 255 / 2, var_22_2.b / 255 / 2, 0))

					var_22_3 = var_24_0
				else
					var_22_3:resetSystem()
				end
			end
		end

		arg_22_0.parent:scheduleUpdate(var_22_4)

		local var_22_5 = var_22_0("ui/battle/BattleParticle/weaponStar.plist", ccp(0, -30), arg_22_0.parent, true)
		local var_22_6 = getQualityColor(arg_22_0.quality)

		var_22_5:setStartColor(ccc4f(var_22_6.r / 255, var_22_6.g / 255, var_22_6.b / 255, 1))
		var_22_5:setEndColor(ccc4f(var_22_6.r / 255 / 2, var_22_6.g / 255 / 2, var_22_6.b / 255 / 2, 0))

		return var_22_5
	elseif arg_22_0.profession == HeroProfession.eCommander then
		local var_22_7 = 0.068
		local var_22_8 = var_22_0("ui/battle/BattleParticle/duanbing_1.plist", ccp(0, -90), arg_22_0.parent, true)
		local var_22_9 = getQualityColor(arg_22_0.quality)

		var_22_8:setStartColor(ccc4f(var_22_9.r / 255 / 2, var_22_9.g / 255 / 2, var_22_9.b / 255 / 2, var_22_7 / 1.5))
		var_22_8:setEndColor(ccc4f(var_22_9.r / 255 / 2, var_22_9.g / 255 / 2, var_22_9.b / 255 / 2, var_22_7))

		return var_22_8
	elseif arg_22_0.profession == HeroProfession.eWarrior then
		local var_22_10 = var_22_0("ui/battle/BattleParticle/changbing_1.plist", ccp(0, 80), arg_22_0.parent, true)
		local var_22_11 = getQualityColor(arg_22_0.quality)

		var_22_10:setStartColor(ccc4f(var_22_11.r / 255, var_22_11.g / 255, var_22_11.b / 255, 0))
		var_22_10:setEndColor(ccc4f(var_22_11.r / 255 / 2, var_22_11.g / 255 / 2, var_22_11.b / 255 / 2, 0.31))

		return var_22_10
	end
end

local function var_0_1(arg_25_0, arg_25_1)
	return true
end

local function var_0_2(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in pairs(BaseEquips[arg_26_0].herosId) do
		if iter_26_1 == arg_26_1 then
			return true
		end
	end

	return false
end

function figure.setupFigure(arg_27_0)
	local var_27_0
	local var_27_1

	if arg_27_0.heroId then
		var_27_1 = BaseHeros[arg_27_0.heroId].profession

		if arg_27_0.rebirthCount and arg_27_0.rebirthCount > 0 then
			if arg_27_0.skinName then
				var_27_0 = arg_27_0.skinName
			else
				var_27_0 = getHeroCurrentRebirthCountAttrs(arg_27_0.heroId, arg_27_0.rebirthCount).animation
			end

			if not arg_27_0.figureNode.Skeleton.rebirthEffect then
				arg_27_0.figureNode.Skeleton.rebirthEffect = var_0_1(arg_27_0.figureNode, arg_27_0.rebirthCount)
			end
		elseif arg_27_0.skinName then
			var_27_0 = arg_27_0.skinName
		else
			var_27_0 = "dengji1"
		end

		arg_27_0.figureNode.Skeleton:setSkin(var_27_0)
		arg_27_0.figureNode.Skeleton:setToSetupPose()
	elseif arg_27_0.enemyId then
		if arg_27_0.skinName then
			var_27_0 = arg_27_0.skinName
		else
			var_27_0 = BaseNPCs[arg_27_0.enemyId].skinName

			if not var_27_0 or var_27_0 == "" then
				var_27_0 = "default"
			end
		end

		var_27_1 = BaseNPCs[arg_27_0.enemyId].profession

		arg_27_0.figureNode.Skeleton:setSkin(var_27_0)
		arg_27_0.figureNode.Skeleton:setToSetupPose()
	end

	local function var_27_2(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4)
		if arg_28_0:findAttachment("default", arg_28_2, arg_28_3) then
			arg_28_0:createAttachment("default", arg_28_2, arg_28_3, arg_28_4)
		end

		if arg_28_0:findAttachment(arg_28_1, arg_28_2, arg_28_3) then
			arg_28_0:createAttachment(arg_28_1, arg_28_2, arg_28_3, arg_28_4)

			return true
		end

		return false
	end

	local var_27_3

	if arg_27_0.equipId and arg_27_0.equipId == -1 then
		local var_27_4
		local var_27_5
		local var_27_6
		local var_27_7

		if var_27_1 == HeroProfession.eMage then
			local var_27_8 = "root_magicweapon"
			local var_27_9 = "root_magicweapon_f"

			var_27_6 = "weapon/weapon_none.png"

			local var_27_10 = "weapon/weapon_none.png"

			var_27_2(arg_27_0.figureNode.Skeleton, var_27_0, var_27_8, var_27_8, var_27_6)
			var_27_2(arg_27_0.figureNode.Skeleton, var_27_0, var_27_8, var_27_9, var_27_10)
			arg_27_0.figureNode.Skeleton:setAttachment(var_27_8, var_27_8)
		elseif var_27_1 == HeroProfession.eCommander then
			local var_27_11 = "root_weapon"

			var_27_6 = "weapon/weapon_none.png"

			arg_27_0.figureNode.Skeleton:createAttachment(var_27_0, var_27_11, var_27_11, var_27_6)
			arg_27_0.figureNode.Skeleton:setAttachment(var_27_11, var_27_11)
		elseif var_27_1 == HeroProfession.eWarrior then
			local var_27_12 = "root_longweapon"
			local var_27_13 = "root_longweapon_diji"

			var_27_6 = "weapon/weapon_none.png"

			local var_27_14 = "weapon/weapon_none.png"

			var_27_2(arg_27_0.figureNode.Skeleton, var_27_0, var_27_12, var_27_12, var_27_6)
			var_27_2(arg_27_0.figureNode.Skeleton, var_27_0, var_27_13, var_27_13, var_27_14)
			arg_27_0.figureNode.Skeleton:setAttachment(var_27_12, var_27_12)
			arg_27_0.figureNode.Skeleton:setAttachment(var_27_13, var_27_13)
		end

		if arg_27_0.figureNode.Skeleton.weaponEffect then
			local var_27_15 = arg_27_0.figureNode.Skeleton:getSlotNode(arg_27_0.figureNode.Skeleton.weaponEffect)

			arg_27_0.figureNode.Skeleton:releaseSoltNode(arg_27_0.figureNode.Skeleton.weaponEffect)
			var_27_15:removeFromParentAndCleanup(true)

			arg_27_0.figureNode.Skeleton.weaponEffect = nil
		end

		var_27_3 = var_27_6
	elseif arg_27_0.equipId and arg_27_0.equipId ~= 0 then
		local var_27_16 = BaseEquips[arg_27_0.equipId].skin

		var_27_1 = BaseEquips[arg_27_0.equipId].profession

		if var_27_16 then
			local var_27_17
			local var_27_18
			local var_27_19

			if var_27_1 == HeroProfession.eMage then
				var_27_17 = "root_magicweapon"

				local var_27_20 = "root_magicweapon_f"

				var_27_19 = "weapon/magicweapon/"

				var_27_2(arg_27_0.figureNode.Skeleton, var_27_0, var_27_17, var_27_17, var_27_19 .. var_27_16[1])
				var_27_2(arg_27_0.figureNode.Skeleton, var_27_0, var_27_17, var_27_20, var_27_19 .. var_27_16[2])
				arg_27_0.figureNode.Skeleton:setAttachment(var_27_17, var_27_17)
			elseif var_27_1 == HeroProfession.eCommander then
				var_27_17 = "root_weapon"
				var_27_19 = "weapon/weapon/"

				var_27_2(arg_27_0.figureNode.Skeleton, var_27_0, var_27_17, var_27_17, var_27_19 .. var_27_16[1])
				arg_27_0.figureNode.Skeleton:setAttachment(var_27_17, var_27_17)
			elseif var_27_1 == HeroProfession.eWarrior then
				var_27_17 = "root_longweapon"

				local var_27_21 = "root_longweapon_diji"

				var_27_19 = "weapon/longweapon/"

				local var_27_22 = var_27_2(arg_27_0.figureNode.Skeleton, var_27_0, var_27_21, var_27_21, var_27_19 .. var_27_16[1])

				var_27_2(arg_27_0.figureNode.Skeleton, var_27_0, var_27_17, var_27_17, var_27_19 .. var_27_16[1])
				arg_27_0.figureNode.Skeleton:setAttachment(var_27_17, var_27_17)
				arg_27_0.figureNode.Skeleton:setAttachment(var_27_21, var_27_21)

				local var_27_23 = arg_27_0.figureNode.Skeleton:getSlotNode(var_27_17)
				local var_27_24 = arg_27_0.figureNode.Skeleton:getSlotNode(var_27_21)

				var_27_17 = var_27_23 and var_27_17 or var_27_21
			end

			if arg_27_0.figureNode.Skeleton.weaponEffect and arg_27_0.figureNode.Skeleton.weaponEffect ~= var_27_17 then
				local var_27_25 = arg_27_0.figureNode.Skeleton:getSlotNode(arg_27_0.figureNode.Skeleton.weaponEffect)

				arg_27_0.figureNode.Skeleton:releaseSoltNode(arg_27_0.figureNode.Skeleton.weaponEffect)
				var_27_25:setVisible(false)

				arg_27_0.figureNode.Skeleton.weaponEffect = nil
			end

			if not arg_27_0.figureNode.Skeleton.weaponEffect and (arg_27_0.viewEffect or var_0_2(arg_27_0.equipId, arg_27_0.figureNode.heroId)) then
				arg_27_0.figureNode.Skeleton.weaponEffect = var_27_17

				var_0_0({
					quality = BaseEquips[arg_27_0.equipId].quality,
					profession = var_27_1,
					parent = arg_27_0.figureNode.Skeleton:getSlotNode(var_27_17),
					pinjie = arg_27_0.pinjie
				})
			end

			var_27_3 = var_27_19 .. var_27_16[1]
		end
	else
		if arg_27_0.enemyId then
			local var_27_26 = BaseNPCs[arg_27_0.enemyId].animation

			if var_27_26 == "npc_shitouren1" or var_27_26 == "npc_shitouren2" or var_27_26 == "npc_shitouren3" or var_27_26 == "npc_she1" or var_27_26 == "npc_she2" or var_27_26 == "npc_she3" then
				return
			end
		end

		local var_27_27
		local var_27_28
		local var_27_29
		local var_27_30

		if var_27_1 == HeroProfession.eMage then
			local var_27_31 = "root_magicweapon"
			local var_27_32 = "root_magicweapon_f"

			var_27_29 = "weapon/magicweapon/big_chushifabao.png"

			local var_27_33 = "weapon/magicweapon/big_chushifabao_f.png"

			var_27_2(arg_27_0.figureNode.Skeleton, var_27_0, var_27_31, var_27_31, var_27_29)
			var_27_2(arg_27_0.figureNode.Skeleton, var_27_0, var_27_31, var_27_32, var_27_33)
			arg_27_0.figureNode.Skeleton:setAttachment(var_27_31, var_27_31)
		elseif var_27_1 == HeroProfession.eCommander then
			local var_27_34 = "root_weapon"

			var_27_29 = "weapon/weapon/big_chushiduanbing.png"

			arg_27_0.figureNode.Skeleton:createAttachment(var_27_0, var_27_34, var_27_34, var_27_29)
			arg_27_0.figureNode.Skeleton:setAttachment(var_27_34, var_27_34)
		elseif var_27_1 == HeroProfession.eWarrior then
			local var_27_35 = "root_longweapon"
			local var_27_36 = "root_longweapon_diji"

			var_27_29 = "weapon/longweapon/big_chushichangbing.png"

			local var_27_37 = "weapon/longweapon/big_chushichangbing.png"

			var_27_2(arg_27_0.figureNode.Skeleton, var_27_0, var_27_35, var_27_35, var_27_29)
			var_27_2(arg_27_0.figureNode.Skeleton, var_27_0, var_27_36, var_27_36, var_27_37)
			arg_27_0.figureNode.Skeleton:setAttachment(var_27_35, var_27_35)
			arg_27_0.figureNode.Skeleton:setAttachment(var_27_36, var_27_36)
		end

		if arg_27_0.figureNode.Skeleton.weaponEffect then
			local var_27_38 = arg_27_0.figureNode.Skeleton:getSlotNode(arg_27_0.figureNode.Skeleton.weaponEffect)

			arg_27_0.figureNode.Skeleton:releaseSoltNode(arg_27_0.figureNode.Skeleton.weaponEffect)
			var_27_38:removeFromParentAndCleanup(true)

			arg_27_0.figureNode.Skeleton.weaponEffect = nil
		end

		var_27_3 = var_27_29
	end

	arg_27_0.figureNode.Skeleton.weaponPicPath = var_27_3

	if not arg_27_0.figureNode.wing and arg_27_0.wing then
		local var_27_39 = CCSkeletonAnimation:createWithFile("effectAni/chibang.json", "effectAni/chibang.atlas", 1)

		var_27_39:setToSetupPose()
		var_27_39:setAnimation("animation", true, 0)
		var_27_39:setPosition(ccp(-10, 70))

		local var_27_40 = arg_27_0.figureNode.Skeleton:getSlotNode("root_chest", -1) or arg_27_0.figureNode.Skeleton:getSlotNode("root_chest_diji", -1) or arg_27_0.figureNode.Skeleton:getSlotNode("root_head", -1) or arg_27_0.figureNode.Skeleton:getSlotNode("root_head_diji", -1)

		var_27_40:addChild(var_27_39)

		arg_27_0.figureNode.wing = var_27_40
	end
end

function figure.getRebirthNeedLevel(arg_29_0)
	return ({
		1,
		5,
		10,
		15,
		20,
		23,
		25,
		27,
		29,
		31,
		32,
		33,
		35
	})[arg_29_0] or 35 + (arg_29_0 - 13) * 5
end

function figure.heroCanRebirth(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = figure.getRebirthNeedLevel(arg_30_2 + 1)

	if BaseHeros[arg_30_0].quality == QualityType.eOrange and arg_30_2 >= 26 and arg_30_2 < 30 then
		var_30_0 = 100
	end

	if arg_30_1 < var_30_0 then
		return false
	end

	local var_30_1 = getHeroCurrentRebirthCountAttrs(arg_30_0, arg_30_2 + 1)

	if var_30_1 == nil then
		return false
	end

	local var_30_2 = var_30_1.soulId and var_30_1.soulCount or 0
	local var_30_3 = var_30_1 and var_30_1.mateCount or 0
	local var_30_4 = var_30_1.soulId and Player:getItemCount(ItemType.eSoul, var_30_1.soulId) or 0
	local var_30_5 = var_30_1 and Player:getItemCount(ItemType.eMate, var_30_1.mateId) or 0

	if var_30_2 > 0 and var_30_4 < var_30_2 then
		return false
	end

	if var_30_3 > 0 and var_30_5 < var_30_3 then
		return false
	end

	return true
end
