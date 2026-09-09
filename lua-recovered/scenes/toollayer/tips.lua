local var_0_0 = require("scenes.toollayer.herobase")
local var_0_1 = require("scenes.toollayer.equipbase")
local var_0_2 = require("scenes.toollayer.tianmingbase")
local var_0_3 = require("scenes.toollayer.ctrl")
local var_0_4 = require("scenes.toollayer.layer")
local var_0_5 = {
	createTianmingTips = function(arg_1_0)
		local var_1_0 = arg_1_0.type
		local var_1_1 = arg_1_0.id
		local var_1_2 = arg_1_0.data

		if var_1_2 then
			if var_1_2.destinyID then
				var_1_1 = var_1_2.destinyID
			else
				var_1_0, var_1_1 = var_1_2.Type, var_1_2.ID
				var_1_2 = false
			end
		else
			var_1_2 = false
			var_1_1 = arg_1_0.id
		end

		arg_1_0.prefer = var_0_4.ePreferRight

		local var_1_3 = var_0_4.new(arg_1_0)
		local var_1_4 = var_0_2.new({
			type = var_1_0,
			id = var_1_1,
			player = var_1_2,
			heroId = arg_1_0.heroId
		})
		local var_1_5 = var_1_4.model
		local var_1_6 = var_1_4.qualityColor

		var_1_3:addNode(var_1_4:createAvatarTitle())
		var_1_3:addSeparator()
		var_1_3:addNode(var_1_4:createAttrNode())

		local var_1_7 = var_1_4:getCompareTianming()

		if var_1_7 then
			local var_1_8 = var_1_3:attach()

			var_1_8:addNode(var_1_7:createAvatarTitle())
			var_1_8:addSeparator()
			var_1_8:addNode(var_1_7:createAttrNode())
		end

		return var_1_3
	end,
	createPropInfoTips = function(arg_2_0)
		local var_2_0 = arg_2_0.data
		local var_2_1 = arg_2_0.type
		local var_2_2 = arg_2_0.id

		var_2_1 = var_2_1 or ItemType.eProp
		arg_2_0.title = {
			node = var_0_3.createAvatarTitle(var_2_0)
		}

		local var_2_3 = var_0_4.new(arg_2_0)
		local var_2_4 = CCSize(300, 120)
		local var_2_5 = var_0_3.newNode()

		if var_2_1 == ItemType.eVIPLevel then
			local var_2_6 = getItemName(var_2_1, var_2_2) .. var_2_0.Count
			local var_2_7 = var_0_3.newLabel({
				text = string.lf("领取以后直接成为#E4BD05%s#EFDFB5，享受#E4BD05%s#EFDFB5的所有权限！", var_2_6, var_2_6),
				dimensions = CCSize(260, 0),
				valign = ui.TEXT_ALIGN_CENTER,
				color = ccc3(239, 223, 181)
			})

			var_2_7:setAnchorPoint(ccp(0.5, 1))
			var_2_7:setPosition(var_2_4.width / 2, 60)
			var_2_5:addChild(var_2_7)

			var_2_4.height = var_2_4.height - 40
		else
			local var_2_8 = getItemBaseData(var_2_1, var_2_2)
			local var_2_9 = var_0_3.newLabel({
				text = string.lf("出售价格："),
				color = ccc3(239, 223, 181)
			})
			local var_2_10 = {
				type = ItemType.eCoin,
				value = var_2_8.sellPrice,
				color = ccc3(239, 223, 181)
			}
			local var_2_11 = createItemCountNode(var_2_10)

			var_2_9:align(display.LEFT_CENTER, 20, 100)
			var_2_11:setPosition(130, 100)
			var_2_5:addChild(var_2_9)
			var_2_5:addChild(var_2_11)

			local var_2_12 = var_0_3.newLabel({
				text = var_2_8.desc,
				color = ccc3(239, 223, 181),
				dimensions = CCSize(260, 0),
				valign = ui.TEXT_ALIGN_CENTER
			})

			var_2_12:setAnchorPoint(ccp(0.5, 1))
			var_2_12:setPosition(var_2_4.width / 2, 80)
			var_2_5:addChild(var_2_12)
		end

		var_2_5:setContentSize(var_2_4)
		var_2_3:addNode(var_2_5)

		return var_2_3
	end,
	createTeamHeroTips = function(arg_3_0)
		local var_3_0 = var_0_0.new({
			player = true,
			id = arg_3_0.id
		})
		local var_3_1 = var_3_0.model
		local var_3_2 = var_3_0.qualityColor
		local var_3_3 = arg_3_0.callback
		local var_3_4
		local var_3_5
		local var_3_6
		local var_3_7 = string.lf("【%s】%s  %d级", HeroProfessionNames[var_3_1.profession], var_3_1.name, var_3_1.level or 1)

		arg_3_0.title = {
			size = 22,
			text = var_3_7,
			color = var_3_2
		}
		arg_3_0.prefer = var_0_4.ePreferRight
		arg_3_0.touchable = true

		local var_3_8 = var_0_4.new(arg_3_0)
		local var_3_9 = var_3_0:createGroupEquips()

		var_3_8:addNode(var_3_9)

		if var_3_3 then
			var_3_8:addAction({
				text = string.lf("升级"),
				callback = function(arg_4_0, arg_4_1)
					var_3_3(false, arg_4_1)
					var_3_8:removeFromParent()
				end
			})
			var_3_8:addAction({
				text = string.lf("更换"),
				callback = function(arg_5_0, arg_5_1)
					var_3_3(true, arg_5_1)
					var_3_8:removeFromParent()
				end
			})
		end

		return var_3_8
	end,
	createTuJianHeroTips = function(arg_6_0)
		local var_6_0 = var_0_0.new({
			id = arg_6_0.id,
			player = arg_6_0.player
		})
		local var_6_1 = var_6_0.model
		local var_6_2 = var_6_0.qualityColor
		local var_6_3 = arg_6_0.callback
		local var_6_4 = string.lf("【%s】%s  %d级", HeroProfessionNames[var_6_1.profession], var_6_1.name, var_6_1.level or 1)

		arg_6_0.title = {
			size = 22,
			text = var_6_4,
			color = var_6_2
		}
		arg_6_0.prefer = var_0_4.ePreferRight
		arg_6_0.touchable = true

		local var_6_5 = var_0_4.new(arg_6_0)
		local var_6_6 = var_6_0:createAttrNode()

		var_6_5:addNode({
			node = var_6_6,
			align = display.CENTER
		})
		var_6_5:addSeparator()

		local var_6_7 = var_6_0:createInfoNode()

		var_6_5:addNode({
			node = var_6_7,
			align = display.CENTER
		})
		var_6_5:addAction({
			text = string.lf("法术"),
			callback = function(arg_7_0, arg_7_1)
				var_6_7:toggle(true)
			end
		})
		var_6_5:addAction({
			text = string.lf("套装"),
			callback = function(arg_8_0, arg_8_1)
				var_6_7:toggle(false)
			end
		})

		return var_6_5
	end,
	createTeamEquipTips = function(arg_9_0)
		local var_9_0 = arg_9_0.type
		local var_9_1 = arg_9_0.id
		local var_9_2 = arg_9_0.data

		if var_9_2 then
			if var_9_2.equipId then
				var_9_1 = var_9_2.equipId
			else
				var_9_0, var_9_1 = var_9_2.Type, var_9_2.ID
				var_9_2 = false
			end
		else
			var_9_2 = false
			var_9_1 = arg_9_0.id
		end

		local var_9_3 = var_0_1.new({
			type = var_9_0,
			id = var_9_1,
			player = var_9_2,
			heroId = arg_9_0.heroId
		})
		local var_9_4 = var_9_3.model
		local var_9_5 = var_9_3.qualityColor

		arg_9_0.prefer = var_0_4.ePreferRight

		local var_9_6 = var_0_4.new(arg_9_0)

		var_9_6:addNode(var_9_3:createAvatarTitle())
		var_9_6:addSeparator()

		if var_9_4.equipId == 0 then
			local var_9_7 = var_9_3:createFragmentDesc()

			var_9_6:addNode(var_9_7)

			return var_9_6
		end

		local var_9_8 = var_9_3:createOwnedHeroNode()

		var_9_6:addNode(var_9_8)

		local var_9_9 = var_9_3:createMineralNode()

		var_9_6:addNode(var_9_9)

		local var_9_10 = var_9_3:createAttrNode()

		var_9_6:addNode(var_9_10)

		local var_9_11 = var_9_3:getCompareEquip()

		if var_9_11 then
			local var_9_12 = var_9_6:attach()

			var_9_12:addNode(var_9_11:createAvatarTitle())
			var_9_12:addSeparator()

			local var_9_13 = var_9_11:createOwnedHeroNode()

			var_9_12:addNode(var_9_13)

			local var_9_14 = var_9_11:createMineralNode()

			var_9_12:addNode(var_9_14)

			local var_9_15 = var_9_11:createAttrNode()

			var_9_12:addNode(var_9_15)
		end

		return var_9_6
	end,
	createTujianEquipTips = function(arg_10_0)
		local var_10_0
		local var_10_1

		if arg_10_0.data then
			var_10_1 = arg_10_0.data
			var_10_0 = var_10_1.equipId
		else
			var_10_1 = false
			var_10_0 = arg_10_0.id
		end

		local var_10_2 = var_0_1.new({
			id = var_10_0,
			player = var_10_1,
			heroId = arg_10_0.heroId
		})
		local var_10_3 = var_10_2.model
		local var_10_4 = var_10_2.qualityColor

		if var_10_3.pinJie then
			local var_10_5 = var_10_2:createPinJieTitle()

			arg_10_0.title = {
				node = var_10_5
			}
		else
			local var_10_6 = var_10_3.name

			if var_10_3.profession == HeroProfession.eNone then
				var_10_6 = string.lf("%s(通用)", var_10_6)
			else
				var_10_6 = var_10_6 .. "(" .. HeroProfessionNames[var_10_3.profession] .. ")"
			end

			arg_10_0.title = {
				size = 22,
				text = var_10_6,
				color = var_10_4
			}
		end

		arg_10_0.prefer = var_0_4.ePreferRight

		local var_10_7 = var_0_4.new(arg_10_0)

		if var_10_3.pinJie then
			local var_10_8 = var_10_2:createOwnedHeroNode()

			var_10_7:addNode(var_10_8)

			local var_10_9 = var_10_2:createMineralNode()

			var_10_7:addNode(var_10_9)
		end

		local var_10_10 = var_10_2:createAttrNode()

		var_10_7:addNode(var_10_10)

		return var_10_7
	end,
	createRewardTips = function(arg_11_0)
		local var_11_0 = arg_11_0.rewards

		if not var_11_0 or #var_11_0 < 1 then
			return
		end

		local var_11_1 = var_0_4.new(arg_11_0)
		local var_11_2 = {
			false,
			true,
			true,
			false
		}
		local var_11_3 = var_0_3.createRewardNode(var_11_0, var_11_2, 20)

		var_11_1:addNode(var_11_3)

		return var_11_1
	end
}
local var_0_6 = {
	eShowReward = var_0_5.createRewardTips,
	eShowTeamHero = var_0_5.createTeamHeroTips,
	eShowTujianHero = var_0_5.createTuJianHeroTips,
	eShowTeamEquip = var_0_5.createTeamEquipTips,
	eShowTujianEquip = var_0_5.createTujianEquipTips,
	eShowPropInfo = var_0_5.createPropInfoTips,
	eShowTianming = var_0_5.createTianmingTips
}

for iter_0_0, iter_0_1 in pairs(var_0_6) do
	var_0_4.__register(var_0_4.eTypeTips, var_0_4[iter_0_0], iter_0_1)
end
