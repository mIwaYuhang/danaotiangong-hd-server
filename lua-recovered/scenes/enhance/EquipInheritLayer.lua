local var_0_0 = class("EquipInheritLayer", function()
	return display.newLayer()
end)

function var_0_0.ctor(arg_2_0, arg_2_1)
	print("EquipInheritLayer:ctor")

	arg_2_0.bgSprite = CCScale9Sprite:create("ui/team/team_079.jpg")

	arg_2_0:addChild(arg_2_0.bgSprite)

	local var_2_0 = display.newSprite("ui/team/team_081.png", 229, 286)

	arg_2_0.bgSprite:addChild(var_2_0)
	arg_2_0:createProgressBar()

	arg_2_0.qualitySpriteTable = {
		{
			offSprite = "ui/team/team_088.png",
			onSprite = "ui/team/team_082.png",
			pos = ccp(90, 147)
		},
		{
			offSprite = "ui/team/team_089.png",
			onSprite = "ui/team/team_083.png",
			pos = ccp(55, 330)
		},
		{
			offSprite = "ui/team/team_090.png",
			onSprite = "ui/team/team_084.png",
			pos = ccp(218, 452)
		},
		{
			offSprite = "ui/team/team_091.png",
			onSprite = "ui/team/team_085.png",
			pos = ccp(388, 325)
		},
		{
			offSprite = "ui/team/team_092.png",
			onSprite = "ui/team/team_086.png",
			pos = ccp(356, 150)
		}
	}

	table.foreach(arg_2_0.qualitySpriteTable, function(arg_3_0, arg_3_1)
		local var_3_0 = display.newSprite(arg_3_1.offSprite)

		var_3_0:setPosition(arg_3_1.pos)
		arg_2_0.bgSprite:addChild(var_3_0)

		arg_2_0.qualitySpriteTable[arg_3_0].sprite = var_3_0
	end)
end

function var_0_0.createProgressBar(arg_4_0)
	local var_4_0 = display.newSprite("ui/team/team_080.png")

	var_4_0:setFlipY(true)
	var_4_0:setFlipX(true)
	var_4_0:setRotation(180)

	arg_4_0.progressBar = CCProgressTimer:create(var_4_0)

	arg_4_0.progressBar:setType(kCCProgressTimerTypeRadial)
	arg_4_0.progressBar:setRotation(180)
	arg_4_0.progressBar:setPosition(ccp(228, 286))
	arg_4_0.bgSprite:addChild(arg_4_0.progressBar)
end

function var_0_0.setProgressValue(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	print(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)

	local var_5_0 = {
		{
			endPercentage = 26,
			startPercentage = 15
		},
		{
			endPercentage = 45,
			startPercentage = 33
		},
		{
			endPercentage = 67,
			startPercentage = 53
		},
		{
			endPercentage = 85,
			startPercentage = 74
		},
		{
			endPercentage = 85,
			startPercentage = 85
		}
	}

	arg_5_0.pinJie = arg_5_1

	local var_5_1 = var_5_0[arg_5_1].startPercentage + (var_5_0[arg_5_1].endPercentage - var_5_0[arg_5_1].startPercentage) / 4 * arg_5_2

	if arg_5_3 == true then
		arg_5_0.progressBar:setPercentage(var_5_1)
		arg_5_0:updateQualitySprite(arg_5_1)

		return
	end

	if arg_5_4 ~= nil and arg_5_5 ~= nil then
		local var_5_2 = var_5_0[arg_5_4].startPercentage + (var_5_0[arg_5_4].endPercentage - var_5_0[arg_5_4].startPercentage) / 4 * arg_5_5

		arg_5_0.progressBar:setPercentage(var_5_2)
		arg_5_0:updateQualitySprite(arg_5_4)
	end

	local function var_5_3()
		if arg_5_4 < arg_5_1 then
			local var_6_0 = CCSkeletonAnimation:createWithFile("effectAni/ui_chongzhu.json", "effectAni/ui_chongzhu.atlas", 1)
			local var_6_1 = CCCallFunc:create(function()
				arg_5_0:updateQualitySprite()
				var_6_0:removeFromParentAndCleanup(true)
			end)

			var_6_0:setAnimation("animation", false, 0)
			var_6_0:setPosition(ccp(47, 47))
			var_6_0:addAnimationAction("animation", 1, var_6_1, AAT_Percent)
			arg_5_0.qualitySpriteTable[arg_5_1].sprite:addChild(var_6_0)
		else
			arg_5_0:updateQualitySprite()
		end
	end

	local var_5_4 = arg_5_0.progressBar:getPercentage()
	local var_5_5 = CCProgressFromTo:create(0.1, var_5_4, var_5_1)
	local var_5_6 = CCCallFunc:create(var_5_3)
	local var_5_7 = CCArray:create()

	var_5_7:addObject(var_5_5)
	var_5_7:addObject(var_5_6)
	arg_5_0.progressBar:runAction(CCSequence:create(var_5_7))
end

function var_0_0.updateQualitySprite(arg_8_0, arg_8_1)
	for iter_8_0 = 1, 5 do
		if iter_8_0 <= (arg_8_1 or arg_8_0.pinJie) then
			local var_8_0 = display.newSprite(arg_8_0.qualitySpriteTable[iter_8_0].onSprite)

			arg_8_0.qualitySpriteTable[iter_8_0].sprite:setTexture(var_8_0:getTexture())
		else
			local var_8_1 = display.newSprite(arg_8_0.qualitySpriteTable[iter_8_0].offSprite)

			arg_8_0.qualitySpriteTable[iter_8_0].sprite:setTexture(var_8_1:getTexture())
		end
	end
end

return var_0_0
