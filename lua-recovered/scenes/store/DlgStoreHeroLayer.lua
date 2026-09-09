require("base.figure")

local var_0_0 = class("DlgStoreHeroLayer", function()
	return CCLayerColor:create(ccc4(0, 0, 0, 210))
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.closeCallback = arg_2_1.closeCallback

	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.background = CCNode:create()

	arg_2_0:addChild(arg_2_0.background)

	local var_2_0 = ui.newControlButton({
		normalImage = "ui/common/btn_closed.png",
		anchorPoint = CCPoint(1, 1),
		position = CCPoint(display.width - 50, display.height - 20),
		clickAction = function()
			if arg_2_0.closeCallback then
				arg_2_0.closeCallback()
			end

			arg_2_0:removeFromParentAndCleanup(true)
		end,
		scaleX = Adapter.MinScale,
		scaleY = Adapter.MinScale
	})

	arg_2_0:addChild(var_2_0)

	arg_2_0.repeatCallback = arg_2_1.repeatCallback

	arg_2_0:showHeroInfo(arg_2_1.heroData)
end

function var_0_0.showHeroInfo(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1.Reward) do
		if iter_5_1.Type == ItemType.eSoul or iter_5_1.Type == ItemType.eHero then
			arg_5_0.heroInfo = iter_5_1
		end
	end

	arg_5_0.needIngot = arg_5_1.NeedIngot

	arg_5_0.background:removeAllChildrenWithCleanup(true)

	local var_5_0

	if arg_5_0.heroInfo.Type == ItemType.eSoul then
		var_5_0 = BaseSouls[arg_5_0.heroInfo.ID].figureId
	else
		var_5_0 = arg_5_0.heroInfo.ID
	end

	local var_5_1 = BaseHeros[var_5_0]

	arg_5_0.reward = {}

	if table.maxn(arg_5_1.Reward) > 1 then
		for iter_5_2, iter_5_3 in ipairs(arg_5_1.Reward) do
			if iter_5_3.Type ~= ItemType.eSoul and iter_5_3.Type ~= ItemType.eHero then
				table.insert(arg_5_0.reward, iter_5_3)
			end
		end
	end

	if table.maxn(arg_5_0.reward) ~= 0 then
		local var_5_2 = require("scenes.store.ShowTaoTieRewardLayer").new({
			arg_5_0.reward
		})

		arg_5_0.background:addChild(var_5_2, 1)
	end

	local var_5_3 = {
		"store_hero_back_01.png",
		"store_hero_back_02.png",
		"store_hero_back_03.png",
		"store_hero_back_04.png"
	}
	local var_5_4 = display.newSprite("ui/store/" .. var_5_3[var_5_1.quality], display.cx, display.cy)

	var_5_4:setScale(2)
	arg_5_0.background:addChild(var_5_4)
	var_5_4:runAction(CCRepeatForever:create(CCRotateBy:create(2, 360)))

	local var_5_5 = getHeroGroupWeaponId(var_5_0)
	local var_5_6 = {
		isStarAction = true,
		starScale = 1.3,
		starImage = "ui/team/team_131.png",
		isViewBaseInfo = false,
		qualitySpaceWidth = 2,
		qualityOffsetY = 450,
		figId = var_5_0,
		equipId = var_5_5,
		pinjie = EquipPinjieType.eShengPin,
		scale = 0.8 * Adapter.MinScale,
		rebirthCount = arg_5_0.heroInfo.BreakthroughCount,
		clickAction = function()
			local var_6_0 = require("scenes.team.BaseHeroInfoLayer").new({
				id = var_5_0
			})

			display.getRunningScene():addChild(var_6_0)
		end
	}
	local var_5_7 = figure.createHero(var_5_6)

	var_5_7:setPosition(Adapter.AutoPos(480, 155))
	arg_5_0.background:addChild(var_5_7)

	local var_5_8 = display.newSprite(getProfessionIconImageName(var_5_1.profession), Adapter.AutoPosX(480), Adapter.AutoPosY(561))

	var_5_8:setScale(Adapter.MinScale)
	arg_5_0.background:addChild(var_5_8)
	addLabelWithColorSize(arg_5_0.background, string.lf("恭喜您获得: "), ccc3(227, 229, 100), 30, CCPoint(1, 0), Adapter.AutoPos(460, 540))
	addLabelWithColorSize(arg_5_0.background, var_5_1.name, getQualityColor(var_5_1.quality), 30, CCPoint(0, 0), Adapter.AutoPos(500, 540))

	if arg_5_0.heroInfo.Type == ItemType.eSoul then
		local var_5_9 = string.lf("您已拥有该主将，自动转化为%s个%s魂魄", arg_5_0.heroInfo.Count, var_5_1.name)

		addLabelWithColorSize(arg_5_0.background, var_5_9, ccc3(227, 229, 100), 25, CCPoint(0.5, 0), Adapter.AutoPos(480, 135))

		local var_5_10 = var_5_7:getContentSize()
		local var_5_11 = display.newSprite("uilocal/enhance/enhance_txt_002.png")

		var_5_11:setAnchorPoint(CCPoint(0.5, 0))
		var_5_11:setPosition(CCPoint(var_5_10.width / 2, 40))
		var_5_7:addChild(var_5_11)
	end

	if arg_5_0.repeatCallback then
		local var_5_12 = ui.newControlButton({
			normalImage = "ui/common/common_109.png",
			titleImage = "uilocal/store/store_text_020.png",
			size = CCSize(150, 60),
			anchorPoint = CCPoint(0.5, 0),
			position = Adapter.AutoPos(390, 50),
			clickAction = function()
				arg_5_0:removeFromParentAndCleanup(true)

				if arg_5_0.repeatCallback then
					arg_5_0.repeatCallback()
				end
			end,
			scaleX = Adapter.MinScale,
			scaleY = Adapter.MinScale
		})

		arg_5_0.background:addChild(var_5_12)

		local var_5_13 = createItemCountNode({
			type = ItemType.eGold,
			value = arg_5_0.needIngot,
			color = ccc3(255, 255, 0)
		})

		var_5_13:setAnchorPoint(CCPoint(0.5, 0))
		var_5_13:setPosition(Adapter.AutoPos(375, 40))
		var_5_13.itemSprite:setScale(Adapter.MinScale)
		arg_5_0.background:addChild(var_5_13)

		local var_5_14 = ui.newControlButton({
			normalImage = "ui/common/common_109.png",
			titleImage = "uilocal/store/store_text_023.png",
			size = CCSize(150, 60),
			anchorPoint = CCPoint(0.5, 0),
			position = Adapter.AutoPos(570, 50),
			clickAction = function()
				if arg_5_0.closeCallback then
					arg_5_0.closeCallback()
				end

				arg_5_0:removeFromParent()
			end,
			scaleX = Adapter.MinScale,
			scaleY = Adapter.MinScale
		})

		arg_5_0.background:addChild(var_5_14)

		if var_5_1.quality == QualityType.eOrange and IPlatform:instance():getConfig("Channel") ~= "ZSY_TW" then
			local var_5_15 = ui.newControlButton({
				normalImage = "uilocal/common/common_text_016.png",
				anchorPoint = CCPoint(0.5, 0),
				position = Adapter.AutoPos(200, 50),
				clickAction = function()
					if tonumber(EditionConfig.__Version) < 200 and IPlatform:instance():getConfig("Channel") ~= "ZSY_TW" then
						showFlashNotice(string.lf("该功能需要更新客户端后才能使用!"))
					else
						local var_9_0 = string.lf("超好玩“大闹天宫HD”里，我居然抽到了橙色品质主将！不想羡慕嫉妒恨，就来和我一起玩吧，海量神将大放送中")
						local var_9_1 = require("scenes.team.DlgShareLayer").new({
							shareText = var_9_0
						})

						display.getRunningScene():addChild(var_9_1, DefaultZOrder.eTaskReward)
					end
				end,
				scaleX = Adapter.MinScale,
				scaleY = Adapter.MinScale
			})

			arg_5_0.background:addChild(var_5_15)
		end
	end
end

return var_0_0
