require("base.figure")
require("data.guild")

local var_0_0 = require("base.cache")
local var_0_1 = {
	typeOfPalace = 3,
	typeOfHall = 1,
	typeOfBoss = 2,
	typeOfStore = 5
}
local var_0_2 = class("GuildUpgrateScene", function()
	return display.newScene("GuildUpgrateScene")
end)

function var_0_2.ctor(arg_2_0, arg_2_1)
	local var_2_0 = require("scenes.CommonBgLayer").new({
		titleSprite = "uilocal/guild/guild_text_029.png",
		returnAction = function(arg_3_0, arg_3_1)
			game.enterGuildHallScene()
		end
	})

	arg_2_0:addChild(var_2_0)

	local var_2_1 = var_2_0:getBackgroundSprite()

	arg_2_0.bgSprite = CCLayerColor:create(ccc4(0, 0, 0, 0))

	arg_2_0.bgSprite:setContentSize(var_2_1:getContentSize())
	var_2_1:addChild(arg_2_0.bgSprite)

	local var_2_2 = createPlayerAttrNode({
		ItemType.eGold,
		ItemType.eCoin
	})

	var_2_2:setPosition(490, 578)
	var_2_1:addChild(var_2_2)

	local var_2_3 = var_0_0.get("GetPlayerGuildInfoRequest")

	arg_2_0.coinLabel = addLabelWithColorSize(var_2_1, string.lf("当前仙盟贡献:#00FF00%s          #F7D35B仙盟人数: #00FF00%s/%s", var_2_3.CurUnionCoin, var_2_3.MemberCount, var_2_3.MaxMemberCount), ccc3(247, 211, 91), 20, CCPoint(0, 0), CCPoint(20, 540))
	arg_2_0.itemTable = {
		[var_0_1.typeOfHall] = {
			Image = "ui/guild/guild_066.png",
			textImage = "uilocal/guild/guild_text_032.png",
			Tag = var_0_1.typeOfHall,
			Position = CCPoint(243, 449),
			Text = string.lf("和仙盟等级一致，它决定了其他建筑的等级上限。")
		},
		[var_0_1.typeOfBoss] = {
			Image = "ui/guild/guild_068.png",
			textImage = "uilocal/guild/guild_text_003.png",
			Tag = var_0_1.typeOfBoss,
			Position = CCPoint(717, 449),
			Text = string.lf("等级越高，开放的魔族boss就越多。")
		},
		[var_0_1.typeOfPalace] = {
			Image = "ui/guild/guild_077.png",
			textImage = "uilocal/guild/guild_text_001.png",
			Tag = var_0_1.typeOfPalace,
			Position = CCPoint(243, 272),
			Text = string.lf("等级越高，可以获得的收益就越多。")
		},
		[var_0_1.typeOfStore] = {
			Image = "ui/guild/guild_069.png",
			textImage = "uilocal/guild/guild_text_004.png",
			Tag = var_0_1.typeOfStore,
			Position = CCPoint(717, 272),
			Text = string.lf("等级越高，可以购买的物品就越多。")
		}
	}

	arg_2_0:reloadLayer()
	arg_2_0:initRequests()
	arg_2_0.buildInfoRequest:request()
end

function var_0_2.initRequests(arg_4_0)
	local function var_4_0()
		local var_5_0 = arg_4_0.buildInfoRequest.restable

		for iter_5_0, iter_5_1 in pairs(var_5_0) do
			arg_4_0.itemTable[iter_5_1.Type].Data = iter_5_1
		end

		arg_4_0:reloadLayer()
	end

	arg_4_0.buildInfoRequest = GuildBuildInfoRequest:new()

	arg_4_0.buildInfoRequest:setResponseNormalHandler(var_4_0)

	local function var_4_1()
		local var_6_0 = display.newNode()

		var_6_0:setScale(Adapter.MinScale)
		var_6_0:setPosition(display.cx, display.cy)
		arg_4_0:addChild(var_6_0)
		showFlashImage({
			image = "uilocal/shenqi/shenqi_text_012.png",
			scale = 1,
			parent = var_6_0,
			position = CCPoint(0, 0),
			callback = function()
				var_6_0:removeFromParent()
			end
		})

		local var_6_1 = arg_4_0.buildUpgradeRequest.restable
		local var_6_2 = var_0_0.get("GetPlayerGuildInfoRequest")
		local var_6_3 = arg_4_0.itemTable[var_6_1.Type]

		var_6_2.CurUnionCoin = var_6_2.CurUnionCoin - var_6_3.Data.NextNeedCoin

		if var_6_1.Type == var_0_1.typeOfHall then
			var_6_2.UnionLv = var_6_1.Level
			var_6_2.MaxMemberCount = arg_4_0.MaxMember or var_6_2.MaxMemberCount

			arg_4_0.coinLabel:setString(string.lf("当前仙盟贡献:#00FF00%s          #F7D35B仙盟人数: #00FF00%s/%s", var_6_2.CurUnionCoin, var_6_2.MemberCount, arg_4_0.MaxMember))

			arg_4_0.MaxMember = nil
		elseif var_6_1.Type == var_0_1.typeOfBoss then
			var_6_2.BossCaveLv = var_6_1.Level

			arg_4_0.coinLabel:setString(string.lf("当前仙盟贡献:#00FF00%s          #F7D35B仙盟人数: #00FF00%s/%s", var_6_2.CurUnionCoin, var_6_2.MemberCount, var_6_2.MaxMemberCount))
		elseif var_6_1.Type == var_0_1.typeOfPalace then
			var_6_2.HallLv = var_6_1.Level

			arg_4_0.coinLabel:setString(string.lf("当前仙盟贡献:#00FF00%s          #F7D35B仙盟人数: #00FF00%s/%s", var_6_2.CurUnionCoin, var_6_2.MemberCount, var_6_2.MaxMemberCount))
		elseif var_6_1.Type == var_0_1.typeOfStore then
			var_6_2.ShopLv = var_6_1.Level

			arg_4_0.coinLabel:setString(string.lf("当前仙盟贡献:#00FF00%s          #F7D35B仙盟人数: #00FF00%s/%s", var_6_2.CurUnionCoin, var_6_2.MemberCount, var_6_2.MaxMemberCount))
		end

		var_0_0.set("GetPlayerGuildInfoRequest", var_6_2)

		arg_4_0.itemTable[var_6_1.Type].Data = var_6_1

		arg_4_0:reloadLayer()
	end

	arg_4_0.buildUpgradeRequest = GuildBuildUpgradeRequest:new()

	arg_4_0.buildUpgradeRequest:setResponseNormalHandler(var_4_1)
end

function var_0_2.reloadLayer(arg_8_0)
	arg_8_0.bgSprite:removeAllChildrenWithCleanup(true)

	local var_8_0 = var_0_0.get("GetPlayerGuildInfoRequest")
	local var_8_1 = var_8_0.CurUnionCoin

	for iter_8_0, iter_8_1 in pairs(arg_8_0.itemTable) do
		local var_8_2 = display.newSprite("ui/guild/guild_070.png", iter_8_1.Position.x, iter_8_1.Position.y)

		arg_8_0.bgSprite:addChild(var_8_2)

		local var_8_3 = var_8_2:getContentSize()
		local var_8_4 = display.newSprite(iter_8_1.Image, 100, var_8_3.height / 2 + 5)
		local var_8_5 = display.newSprite(iter_8_1.textImage, 100, 25)

		var_8_2:addChild(var_8_4)
		var_8_2:addChild(var_8_5)

		local var_8_6 = addLabelWithColorSize(var_8_2, iter_8_1.Text, ccc3(247, 211, 91), 20, CCPoint(0, 1), CCPoint(200, var_8_3.height - 10))

		var_8_6:setDimensions(CCSize(var_8_3.width - 210, var_8_3.height - 20))
		var_8_6:setHorizontalAlignment(kCCTextAlignmentLeft)
		var_8_6:setVerticalAlignment(kCCVerticalTextAlignmentTop)

		local var_8_7 = false

		if iter_8_1.Data ~= nil and table.nums(iter_8_1.Data) > 0 then
			local var_8_8 = display.newSprite("uilocal/guild/guild_text_030.png", 100, var_8_3.height - 30)

			var_8_8:setAnchorPoint(CCPoint(1, 0.5))
			var_8_2:addChild(var_8_8)

			local var_8_9 = CCLabelAtlas:create(iter_8_1.Data.Level, "uilocal/guild/guild_text_031.png", 17.2, 20, 48)

			var_8_9:setAnchorPoint(ccp(0, 0.5))
			var_8_9:setPosition(ccp(100, var_8_3.height - 30))
			var_8_2:addChild(var_8_9)

			if iter_8_1.Data.CurMember == nil and iter_8_1.Data.OpenUnionLv ~= nil then
				local var_8_10 = ""

				if arg_8_0.itemTable[var_0_1.typeOfHall].Data.Level < iter_8_1.Data.OpenUnionLv then
					var_8_10 = string.lf("升级需要: #FF0000仙盟大厅Lv%s", iter_8_1.Data.OpenUnionLv)
				else
					var_8_10 = string.lf("升级需要: #00FF00仙盟大厅Lv%s", iter_8_1.Data.OpenUnionLv)
				end

				addLabelWithColorSize(var_8_2, var_8_10, ccc3(192, 120, 74), 20, CCPoint(0, 1), CCPoint(200, 110))
			end

			if iter_8_1.Data.NextNeedCoin == nil then
				addLabelWithColorSize(var_8_2, iter_8_1.Data.Level > 0 and string.lf("#00FF00已满级") or string.lf("#FF0000暂未开放"), ccc3(192, 120, 74), 20, CCPoint(0, 1), CCPoint(200, 80))
			else
				local var_8_11 = "uilocal/guild/guild_text_028.png"
				local var_8_12 = true
				local var_8_13 = string.lf("升级需要贡献: #00FF00")

				if iter_8_1.Data.CurMember == nil then
					if var_8_1 < iter_8_1.Data.NextNeedCoin then
						var_8_11 = "uilocal/guild/guild_text_037.png"
						var_8_12, var_8_13 = false, string.lf("升级需要贡献: #FF0000")
					elseif iter_8_1.Data.OpenUnionLv ~= nil and arg_8_0.itemTable[var_0_1.typeOfHall].Data.Level < iter_8_1.Data.OpenUnionLv then
						var_8_11 = "uilocal/guild/guild_text_037.png"
						var_8_12, var_8_13 = false, string.lf("升级需要贡献: #00FF00")
					end
				else
					if var_8_1 < iter_8_1.Data.NextNeedCoin then
						var_8_11 = "uilocal/guild/guild_text_037.png"
						var_8_12, var_8_13 = false, string.lf("升级需要贡献: #FF0000")
					end

					if iter_8_1.Data.MaxMember then
						addLabelWithColorSize(var_8_2, string.lf("下级人数上限: %s", iter_8_1.Data.MaxMember), ccc3(192, 120, 74), 20, CCPoint(0, 1), CCPoint(200, 110))
					end
				end

				local var_8_14 = ui.newControlButton({
					normalImage = "ui/guild/guild_065.png",
					titleImage = var_8_11,
					position = CCPoint(330, 25),
					clickAction = function()
						if var_8_0.PositionId > GuildPositionId.eZhangLaoRight then
							showFlashNotice(string.lf("只有盟主和长老才有权限升级建筑"))

							return
						end

						if iter_8_1.Data.MaxMember then
							arg_8_0.MaxMember = iter_8_1.Data.MaxMember
						end

						arg_8_0.buildUpgradeRequest:request(iter_8_1.Tag)
					end
				})

				var_8_7 = var_8_7 or var_8_12

				var_8_14:setEnabled(var_8_12)
				var_8_2:addChild(var_8_14)
				addLabelWithColorSize(var_8_2, var_8_13 .. iter_8_1.Data.NextNeedCoin, ccc3(192, 120, 74), 20, CCPoint(0, 1), CCPoint(200, 80))
			end
		else
			addLabelWithColorSize(var_8_2, string.lf("#FF0000暂未开放"), ccc3(192, 120, 74), 20, CCPoint(0, 1), CCPoint(200, 80))
		end

		var_8_0.NotifyUnion.bUpgrade = var_8_7
	end
end

return var_0_2
