HeroTeamInfo = {}

local var_0_0 = 400 * Adapter.MinScale
local var_0_1 = 10

local function var_0_2(arg_1_0)
	arg_1_0:setUserObject(arg_1_0)
end

function HeroTeamInfo.create(arg_2_0, arg_2_1)
	local var_2_0 = display.newScale9Sprite("ui/common/common_050.png")

	arg_2_1.parent:addChild(var_2_0)

	local var_2_1, var_2_2 = arg_2_0:createTeamName(arg_2_1.heroId)

	var_2_0:addChild(var_2_1)

	local var_2_3 = CCSprite:create("ui/common/common_100.png")

	var_2_3:setScale(Adapter.MinScale)
	var_2_0:addChild(var_2_3)

	local var_2_4, var_2_5 = arg_2_0:createTeamAttr(arg_2_1.heroId)

	var_2_0:addChild(var_2_4)

	local var_2_6 = CCSprite:create("ui/common/common_100.png")

	var_2_6:setScale(Adapter.MinScale)
	var_2_0:addChild(var_2_6)

	local var_2_7, var_2_8 = arg_2_0:createTeamSkill(arg_2_1.heroId, skillattack)

	var_2_0:addChild(var_2_7)

	local var_2_9 = var_2_3:getTextureRect().size.height
	local var_2_10 = var_2_8 + var_2_5 + var_2_2 + var_0_1 * 2 + var_2_9 * 2

	var_2_0:setPreferredSize(CCSizeMake(var_0_0, var_2_10))
	var_2_1:setPosition(var_0_0 / 2, var_2_8 + var_2_5 + var_0_1 + var_2_9 * 2)
	var_2_3:setPosition(var_0_0 / 2, var_2_8 + var_2_5 + var_0_1 + var_2_9 + var_2_9 / 2)
	var_2_4:setPosition(var_0_0 / 2, var_2_8 + var_2_5 / 2 + var_0_1 + var_2_9)
	var_2_6:setPosition(var_0_0 / 2, var_2_8 + var_0_1 + var_2_9 / 2)
	var_2_7:setPosition(var_0_0 / 2, var_0_1)

	return var_2_0, var_0_0, var_2_10
end

function HeroTeamInfo.createTeamName(arg_3_0, arg_3_1)
	local var_3_0 = BaseHeros[arg_3_1]
	local var_3_1 = CCLabelTTF:create("【" .. HeroProfessionNames[var_3_0.profession] .. "】" .. var_3_0.name, _FONT_DEFAULT, Adapter.FontSize(35))

	var_0_2(var_3_1)
	var_3_1:setColor(getQualityColor(var_3_0.quality))
	var_3_1:setAnchorPoint(ccp(0.5, 0))

	local var_3_2 = CCLabelTTF:create("的小队", _FONT_DEFAULT, Adapter.FontSize(25))

	var_0_2(var_3_2)
	var_3_2:setColor(ccc3(253, 207, 10))
	var_3_2:setAnchorPoint(ccp(0.5, 0))

	local var_3_3 = CCNode:create()

	var_3_3:addChild(var_3_1)
	var_3_3:addChild(var_3_2)

	local var_3_4 = var_3_1:getTextureRect().size.width
	local var_3_5 = var_3_2:getTextureRect().size.width
	local var_3_6 = (var_3_4 + var_3_5 + 10) / 2

	var_3_1:setPosition(var_3_4 / 2 - var_3_6, 0)
	var_3_2:setPosition(-var_3_5 / 2 + var_3_6, 0)

	return var_3_3, var_3_1:getTextureRect().size.height
end

function HeroTeamInfo.createTeamAttr(arg_4_0, arg_4_1)
	local var_4_0

	for iter_4_0, iter_4_1 in ipairs(Player.team.groupList) do
		if iter_4_1.heroId == arg_4_1 then
			var_4_0 = iter_4_1

			break
		end
	end

	if var_4_0 then
		local var_4_1 = ((string.lf("等级 %d\n", var_4_0.level) .. string.lf("血量 %d\n", var_4_0.health)) .. string.lf("普攻 %d\n", var_4_0.normalAttack)) .. string.lf("法攻 %d", var_4_0.skillAttack)
		local var_4_2 = ((string.lf("进阶 +%d\n", var_4_0.rebirthCount) .. string.lf("普防 %d\n", var_4_0.speed)) .. string.lf("普防 %d\n", var_4_0.normalDefense)) .. string.lf("法防 %d", var_4_0.skillDefense)
		local var_4_3 = CCNode:create()
		local var_4_4 = CCLabelTTF:create(var_4_1, _FONT_DEFAULT, Adapter.FontSize(25))

		var_0_2(var_4_4)
		var_4_4:setColor(ccc3(247, 221, 132))
		var_4_4:setHorizontalAlignment(kCCTextAlignmentLeft)
		var_4_4:setPosition(var_0_0 / -5, 0)
		var_4_3:addChild(var_4_4)

		local var_4_5 = CCLabelTTF:create(var_4_2, _FONT_DEFAULT, Adapter.FontSize(25))

		var_0_2(var_4_5)
		var_4_5:setColor(ccc3(247, 221, 132))
		var_4_5:setHorizontalAlignment(kCCTextAlignmentLeft)
		var_4_5:setPosition(var_0_0 / 5, 0)
		var_4_3:addChild(var_4_5)

		return var_4_3, var_4_5:getTextureRect().size.height
	end
end

function HeroTeamInfo.createTeamSkill(arg_5_0, arg_5_1)
	local var_5_0

	for iter_5_0, iter_5_1 in ipairs(Player.team.groupList) do
		if iter_5_1.heroId == arg_5_1 then
			var_5_0 = iter_5_1

			break
		end
	end

	local var_5_1 = BaseHeros[arg_5_1]
	local var_5_2 = CCLabelTTF:create(string.lf("【怒气法术】：") .. BaseSkills[var_5_1.skillId].name, _FONT_DEFAULT, Adapter.FontSize(25))

	var_0_2(var_5_2)
	var_5_2:setDimensions(CCSize(var_0_0 - 50, 0))
	var_5_2:setColor(ccc3(253, 207, 10))
	var_5_2:setHorizontalAlignment(kCCTextAlignmentLeft)

	local var_5_3 = getHeroRageSkillDesc(var_5_1.skillId, var_5_0.rageSkillLevel, var_5_0.skillAttack, "#F7DD84")
	local var_5_4 = CCLabelTTF:create(var_5_3, _FONT_DEFAULT, Adapter.FontSize(25))

	var_0_2(var_5_4)
	var_5_4:setColor(ccc3(247, 221, 132))
	var_5_4:setHorizontalAlignment(kCCTextAlignmentLeft)
	var_5_4:setDimensions(CCSize(var_0_0 - 50, 0))

	local var_5_5 = CCLabelTTF:create(string.lf("【天赋法术】：") .. BaseSkills[var_5_1.talentId].name, _FONT_DEFAULT, Adapter.FontSize(25))

	var_0_2(var_5_5)
	var_5_5:setDimensions(CCSize(var_0_0 - 50, 0))
	var_5_5:setColor(ccc3(253, 207, 10))
	var_5_5:setHorizontalAlignment(kCCTextAlignmentLeft)

	local var_5_6

	if var_5_0.rebirthCount == 0 then
		var_5_6 = CCLabelTTF:create(string.lf("天赋技能未开启！"), _FONT_DEFAULT, Adapter.FontSize(25))
	else
		local var_5_7, var_5_8 = getHeroTalentSkillDesc(arg_5_1, var_5_0.rebirthCount, "#F7DD84")

		var_5_6 = CCLabelTTF:create(var_5_8, _FONT_DEFAULT, Adapter.FontSize(25))
	end

	var_0_2(var_5_6)
	var_5_6:setColor(ccc3(247, 221, 132))
	var_5_6:setHorizontalAlignment(kCCTextAlignmentLeft)
	var_5_6:setDimensions(CCSize(var_0_0 - 50, 0))

	local var_5_9 = CCNode:create()

	var_5_9:addChild(var_5_2)
	var_5_9:addChild(var_5_4)
	var_5_9:addChild(var_5_5)
	var_5_9:addChild(var_5_6)

	local var_5_10 = var_5_4:getTextureRect().size.height
	local var_5_11 = var_5_6:getTextureRect().size.height
	local var_5_12 = var_5_5:getTextureRect().size.height
	local var_5_13 = var_5_2:getTextureRect().size.height

	var_5_2:setPosition(0, var_5_11 + var_5_12 + var_5_10 + var_5_13 / 2)
	var_5_4:setPosition(0, var_5_11 + var_5_12 + var_5_10 / 2)
	var_5_5:setPosition(0, var_5_11 + var_5_12 / 2)
	var_5_6:setPosition(0, var_5_11 / 2)

	return var_5_9, var_5_11 + var_5_12 + var_5_10 + var_5_13
end
