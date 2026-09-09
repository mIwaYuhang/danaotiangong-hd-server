BattleTransform = {}

function BattleTransform.trasform(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1.node.Skeleton
	local var_1_1 = CCArray:create()

	var_1_1:addObject(CCFadeOut:create(1 * BattleSpeed))
	var_1_1:addObject(CCCallFunc:create(function(...)
		var_1_0:removeFromParentAndCleanup(true)
	end))
	var_1_0:runAction(CCSequence:create(var_1_1))

	local var_1_2 = arg_1_0:createNewfigure(arg_1_1, 1)

	var_1_2:setOpacity(0)

	local var_1_3 = CCArray:create()

	var_1_3:addObject(CCFadeIn:create(1 * BattleSpeed))
	var_1_3:addObject(CCCallFunc:create(function(...)
		if arg_1_2 then
			arg_1_2()
		end
	end))
	var_1_2:runAction(CCSequence:create(var_1_3))
	arg_1_0:changebackPic()
end

function BattleTransform.createNewfigure(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = string.format("heroani/%s.json", arg_4_1.animation)
	local var_4_1 = string.format("heroani/%s.atlas", arg_4_1.animation)
	local var_4_2 = CCSkeletonAnimation:createWithFile(var_4_0, var_4_1, 1)

	var_4_2:setAnimation("daiji", true, 0)
	var_4_2:setPosition(0, (false and 260 or 160) * arg_4_2)
	arg_4_1.node:addChild(var_4_2, 0)
	var_4_2:setRotationY(180)

	arg_4_1.node.Skeleton = var_4_2

	local var_4_3 = {
		figureNode = arg_4_1.node,
		skinName = arg_4_1.skinName,
		equipId = arg_4_1.equipId,
		heroId = arg_4_1.node.viewParam.heroId,
		enemyId = arg_4_1.node.viewParam.enemyId,
		pinjie = arg_4_1.node.viewParam.pinjie,
		wing = arg_4_1.node.viewParam.wing
	}

	figure.setupFigure(var_4_3)

	arg_4_1.node.viewParam = var_4_3
	arg_4_1.node.trasformId = arg_4_1.animation
	arg_4_1.node.figureSize = arg_4_1.npcSize

	updateNodeSize(arg_4_1.node)

	return var_4_2
end

function BattleTransform.trasform_new(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0

	var_5_0 = BattleSkeleton:addEffect({
		effectName = "buff_bianshen",
		speed = 0.7,
		scale = 2,
		parent = arg_5_1.node,
		position = ccp(0, 230),
		callbacklist = {
			function()
				var_5_0:removeFromParentAndCleanup(true)
			end,
			1,
			AAT_Percent
		}
	})

	var_5_0:getParent():reorderChild(var_5_0, 10)

	local var_5_1 = arg_5_1.node.Skeleton
	local var_5_2 = CCArray:create()

	var_5_2:addObject(CCFadeOut:create(1 * BattleSpeed))
	var_5_2:addObject(CCCallFunc:create(function(...)
		var_5_1:removeFromParentAndCleanup(true)
	end))
	var_5_1:runAction(CCSequence:create(var_5_2))

	local var_5_3 = arg_5_0:createNewfigure_new(arg_5_1, 1)

	var_5_3:setOpacity(0)

	local var_5_4 = CCArray:create()

	var_5_4:addObject(CCFadeIn:create(1 * BattleSpeed))
	var_5_4:addObject(CCCallFunc:create(function(...)
		arg_5_1.node.name:setString(BaseNPCs[arg_5_1.npcId].name)

		if arg_5_2 then
			arg_5_2()
		end
	end))
	var_5_3:runAction(CCSequence:create(var_5_4))

	if arg_5_1.changePic then
		arg_5_0:changebackPic()
	end
end

function BattleTransform.createNewfigure_new(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = string.format("heroani/%s.json", BaseNPCs[arg_9_1.npcId].animation)
	local var_9_1 = string.format("heroani/%s.atlas", BaseNPCs[arg_9_1.npcId].animation)
	local var_9_2 = CCSkeletonAnimation:createWithFile(var_9_0, var_9_1, 1)

	var_9_2:setAnimation("daiji", true, 0)
	var_9_2:setPosition(0, (false and 260 or 160) * arg_9_2)
	var_9_2:setScale(arg_9_2)
	arg_9_1.node:addChild(var_9_2, 0)
	var_9_2:setRotationY(180)

	arg_9_1.node.Skeleton = var_9_2
	arg_9_1.node.npcId = arg_9_1.npcId

	local var_9_3 = {
		figureNode = arg_9_1.node,
		equipId = BaseNPCs[arg_9_1.npcId].equipId,
		enemyId = arg_9_1.node.viewParam.enemyId
	}

	figure.setupFigure(var_9_3)

	arg_9_1.node.viewParam = var_9_3
	arg_9_1.node.figureSize = arg_9_1.npcSize

	updateNodeSize(arg_9_1.node)
	BattleAudio:Sound_playEffect(BattleAudio.status_bianshen)

	return var_9_2
end

function BattleTransform.changebackPic(arg_10_0, ...)
	local function var_10_0()
		local var_11_0 = {
			"buzhoushan_3.jpg",
			"donghailonggong_3.jpg",
			"kuloushan_3.jpg",
			"luofudong_3.jpg",
			"nanhaiputuo_3.jpg",
			"qingqiu_3.jpg",
			"yaochi_3.jpg",
			"zhongnanshan_3.jpg"
		}

		return "ui/battle/bgPic/fuben_20.jpg"
	end

	local var_10_1 = CCSprite:create(var_10_0())

	var_10_1:setTag(1)
	var_10_1:setAnchorPoint(CCPoint(0, 0.5))
	var_10_1:setScale(Adapter.HeightScale)

	if BattleComming.bg_sprite then
		var_10_1:setPosition(BattleComming.bg_sprite:getPosition())
	else
		var_10_1:setPosition(BattleComming.bg_nextSprite:getPosition())
	end

	var_10_1:setOpacity(0)
	var_10_1:runAction(CCFadeIn:create(1 * BattleSpeed))

	if BattleComming.bg_sprite then
		BattleComming.bg_sprite:getParent():addChild(var_10_1, SceneZorder.eBackGroundPic)
	else
		BattleComming.bg_nextSprite:getParent():addChild(var_10_1, SceneZorder.eBackGroundPic)
	end

	local var_10_2 = CCArray:create()

	var_10_2:addObject(CCFadeOut:create(1 * BattleSpeed))
	var_10_2:addObject(CCCallFunc:create(function(...)
		if BattleComming.bg_sprite then
			BattleComming.bg_sprite:removeFromParentAndCleanup(true)

			BattleComming.bg_sprite = var_10_1
		else
			BattleComming.bg_nextSprite:removeFromParentAndCleanup(true)

			BattleComming.bg_nextSprite = var_10_1
		end
	end))

	if BattleComming.bg_sprite then
		BattleComming.bg_sprite:runAction(CCSequence:create(var_10_2))
	else
		BattleComming.bg_nextSprite:runAction(CCSequence:create(var_10_2))
	end
end

function BattleTransform.upgrade(arg_13_0, arg_13_1)
	BattleAudio:Sound_playEffect(BattleAudio.status_bianshen)

	local var_13_0 = arg_13_1.node.viewParam

	arg_13_1.node.viewParam.rebirthCount = arg_13_1.rebirthCount or arg_13_1.node.viewParam.rebirthCount
	arg_13_1.node.viewParam.pinjie = arg_13_1.pinjie or arg_13_1.node.viewParam.pinjie
	arg_13_1.node.figureSize = nodeHeroScale(arg_13_1.figureSize) or arg_13_1.node.figureSize
	arg_13_1.node.viewParam.equipId = arg_13_1.equipId or arg_13_1.node.viewParam.equipId

	updateNodeSize(arg_13_1.node)
	BattleSkeleton:refreshNode(arg_13_1.node)
end
