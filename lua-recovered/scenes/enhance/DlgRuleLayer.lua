local var_0_0 = require("scenes.toollayer.ctrl")

DlgRuleType = {
	ruleRefine = 3,
	ruleXianmo = 1,
	ruleGuildLimit = 6,
	ruleDuel = 7,
	ruleSanqing = 10,
	ruleInspire = 11,
	ruleTower = 2,
	ruleZSZZGameble = 12,
	ruleGuildBoss = 5,
	ruleXunfang = 9,
	ruleTianming = 8,
	ruleMineral = 13,
	ruleShenqi = 4
}

local var_0_1 = class("DlgRuleLayer", function()
	return display.newLayer()
end)

function var_0_1.ctor(arg_2_0, arg_2_1)
	addBlackLayer(arg_2_0)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == "began" then
			return true
		end
	end, false, 1, true)
	arg_2_0:setTouchEnabled(true)

	arg_2_0.ruleType = arg_2_1 ~= nil and arg_2_1.ruleType ~= nil and arg_2_1.ruleType or DlgRuleType.ruleXianmo

	local var_2_0 = display.newSprite("ui/PK/PK_017.png")

	var_2_0:setScale(Adapter.MinScale)
	var_2_0:setAnchorPoint(CCPoint(0.5, 0.5))
	var_2_0:setPosition(display.cx, display.cy)
	arg_2_0:addChild(var_2_0)

	local var_2_1 = var_2_0:getContentSize()
	local var_2_2 = 1
	local var_2_3
	local var_2_4
	local var_2_5 = ""

	if arg_2_0.ruleType == DlgRuleType.ruleXianmo then
		var_2_3 = "uilocal/PK/PK_text_024.png"
		var_2_5 = string.lf("1, 仙魔争霸赛每3天举办一届\n2, 按照玩家等级，进入不同的大道和实力相近的玩家进行比拼\n3, 通过日常的PVP活动可以获得威望值，包括竞技场/抓奴隶/运镖等\n4, 威望值是玩家能否参加仙魔争霸赛的唯一标准，每个大道按照威望值排名，选取前512名玩家进行同场竞技\n5, 进入仙魔争霸赛的玩家，无论输赢都可获得大量奖励\n6, 未能进入仙魔争霸赛的玩家，可下注竞彩输赢，获得大量奖励")
	elseif arg_2_0.ruleType == DlgRuleType.ruleTower then
		var_2_3 = "uilocal/tower/tower_text_014.png"
		var_2_5 = string.lf("1, 每天可挑战通天塔三次\n2, 每层根据挑战难度不同，可获得相应积分\n3, 每战胜三层可增加一次BUFF兑换次数\n4, 可在BUFF商店中消耗积分和兑换次数兑换BUFF属性加成\n5, 每五层可根据获得的积分领取一次爬塔奖励\n6, 达到30级或VIP5后可获得扫荡的功能\n7, 扫荡消耗通天塔挑战次数")
	elseif arg_2_0.ruleType == DlgRuleType.ruleRefine then
		var_2_3 = "uilocal/enhance/enhance_txt_010.png"
		var_2_2 = 0.5
		var_2_5 = string.lf("1, 任意品质的未上阵主将或装备，以及魂魄均可进行炼化\n2, 主将大于1级，装备大于1级或喂灵大于0阶，才能进行重生\n3, 魂魄的数量必须达到合成主将的需求数量，才能进行炼化\n4, 主将/魂魄炼化后可得到魂玉，绿色/蓝色装备炼化后可得到银币，紫色/橙色装备炼化后可得到喂灵石\n5, 主将重生后，返还除了进阶丹之外的其他材料\n6, 高等级的主将或装备建议先进行重生，返回强化/进阶/重铸等消耗后再进行炼化，如果直接炼化将只有基础产出\n7, 魂玉可在神秘商店内购买各种稀缺宝物\n8, 蓝绿色主将或装备重生不花费元宝\n9, 用三个橙色装备可合成一个【天外陨铁】\n10, 【天外陨铁】可用于代替或者补充各种装备进行喂灵\n11, 已锻造或喂灵过的装备，建议先将其重生后再合成")
	elseif arg_2_0.ruleType == DlgRuleType.ruleShenqi then
		var_2_3 = "uilocal/shenqi/shenqi_text_004.png"
		var_2_5 = string.lf("1, 神器需要抢夺对应的碎片进行灌注；每次灌注满以后，神器升1级\n2, 神器达到10级后，如果满足下一阶神器的等级要求，神器会自动升阶\n3, 神器灌注的属性会加到所有上阵的主将身上\n4, 只能使用当前最高阶的神器\n5, 神器升阶以后，神器技能和基础属性都会提升；神器等阶越高，技能释放效果越强")
	elseif arg_2_0.ruleType == DlgRuleType.ruleGuildBoss then
		var_2_3 = "uilocal/guild/guild_text_045.png"
		var_2_5 = string.lf("1, 魔族boss的血量每7天恢复一次\n2, 魔族巢穴等级越高，开放的魔族boss就越多\n3, 前面的魔族boss打通后，才会开放后面的魔族boss，开放后即可任意挑战\n4, 单个玩家在每个魔族boss最多只能获得30%收益，请合理分配伤害，让其他成员也获得收益\n5, 每次挑战魔族boss的时候可以复活3次\n6, 玩家可以挑战已开放的任意魔族boss，每天最多3次\n7, 魔族boss死亡后随机掉落的道具会放在仙盟商店的【魔族宝物】里面\n8, 魔族宝物需要通过晶石竞拍获得，宝物倒计时结束以后，通过邮件发送给玩家\n9, 无人出价的宝物在倒计时结束后会消失，购买请趁早啊")
	elseif arg_2_0.ruleType == DlgRuleType.ruleGuildLimit then
		var_2_3 = "uilocal/guild/guild_text_045.png"
		var_2_5 = string.lf("仙盟主：11级仙盟之前，可以解散仙盟，可以提升长老/四护卫，可以审批，可以踢其他成员，可以分发仙盟晶石，编辑公告/宣言，升级建筑\n\n长老：可以提升四护卫，可以审批，可以踢其他成员，可以分发仙盟晶石，编辑公告/宣言，升级建筑")
	elseif arg_2_0.ruleType == DlgRuleType.ruleDuel then
		var_2_3 = "uilocal/duel/duel_text_013.png"
		var_2_5 = string.lf("1. 大闹天宫每3天进行一次比赛，需要手动抽签，按照天地玄黄随机分组\n2. 每战胜一次对手获得一次积分，3天内积分累计排名，排名越高奖励越多\n3. 比赛进行时，每晚23点。会根据排名进行一次奖励发放，第3天的23点，发放排名最终奖励，并且重置分组和积分，23点-24点之间无法比赛\n4. 挑战次数为10次，每1小时恢复一次，可以花费元宝购买次数，比赛重置后，次数会恢复到10次\n5. 积分奖励需要在【奖励】按钮中领取\n")
	elseif arg_2_0.ruleType == DlgRuleType.ruleTianming then
		var_2_3 = "uilocal/tianming/tianming_text_025.png"
		var_2_5 = string.lf("1. 天命的品质分为绿/蓝/紫/橙，品质越高，可增加的属性越强\n2. 通过分解不需要的天命可获得天命经验，已升级的天命分解以后，100%返还已消耗的天命经验\n3. 使用元宝直接点亮【角木蛟】，可额外获得一个天命碎片，并且很大几率点亮【亢金龙】\n4. 在猎命过程中可能获得【天命碎片】，天命碎片可用于兑换其他命格，也可以用于升级【天命蛊】\n5. 【天命蛊】的激活和升级需要消耗【天命碎片】，升级后可放置在任意的天命蛊位置，在对应的位置上，能够大量降低对方的法术效果\n")
	elseif arg_2_0.ruleType == DlgRuleType.ruleXunfang then
		var_2_3 = "uilocal/xunfang/xunfang_text_030.png"
		var_2_5 = string.lf("1. 人界/地界/天界/重天（暂未开放）分别在70/80/90/100级开启\n2. 可以使用免费次数和普通寻访令进行普通寻访，每次出一张师傅卡牌\n3. 可以使用高级寻访令和元宝进行高级寻访，每次出五张师傅卡牌\n4. 每获得一张新的师傅卡牌，可以获得属性加成，师傅卡牌的品质分为绿/蓝/紫/橙，卡牌品质越高，获得属性越多\n5. 凑齐一定数量的师傅卡牌可以到拜师中通过【拜师学艺】获得属性\n6. 寻访的属性和拜师的组合属性均加成在上阵的主将身上\n7. 寻访到多余的师傅卡牌将自动分解成【授业值】，授业值用于激活和兑换师傅卡牌\n")
	elseif arg_2_0.ruleType == DlgRuleType.ruleSanqing then
		var_2_3 = "uilocal/fuben/zsq_text_002.png"
		var_2_5 = string.lf("1. 战三清每周举办一次，周一至周五均可以参与活动\n2. 按照玩家的等级，进入不同的大道和实力相近的玩家进行比拼(人界1-40、地界41-70、天界71以上)\n3. 每个大道均有三个宝座，挑战宝座上的玩家获胜后，即可占领宝座\n4. 挑战宝座上的玩家达到一定条件即可获得宝箱奖励，每个宝箱在一天内只能被领取一次\n5. 三个宝箱开启条件分别为: 坚持2回合，坚持4回合，获得胜利。获得胜利将会自动打开其余两个宝箱\n6. 每周五24:00结算，最终占领宝座的玩家将有资格参加诸神之战\n")
	elseif arg_2_0.ruleType == DlgRuleType.ruleInspire then
		var_2_3 = "uilocal/fuben/zszz_text_048.png"
		var_2_5 = string.lf("1. 每个服选取9名玩家参加诸神之战（战三清每个道的前3名）\n2. 参加诸神之战的玩家分为天地人三道，通过击杀数进行排名\n3. 获得每个道冠军的服务器，全服可以获得一个礼包\n4. 可以对参加比赛的玩家进行下注，胜利以后获得奖金池内的奖金\n5. 每周1到5为选出参加诸神之战的玩家，周5晚上12点截取数据，战三清中每个道前三名参加对应的诸神之战\n6. 周六到周日晚7点之间，玩家可以进行鼓舞和下注，鼓舞后可以获得大量银币，鼓舞的玩家如果获得了前三，则会额外获得大量银币，7点到8点为筹备期，无法再进行鼓舞和下注，8点诸神之战正式开赛\n7. 当一个服务器中有多名玩家获得诸神之战前三名次，则只会发放1个诸神礼包，诸神礼包内容：橙卡包碎片*3，金钥匙*3，金箱子*3，50W银币\n")
	elseif arg_2_0.ruleType == DlgRuleType.ruleZSZZGameble then
		var_2_3 = "uilocal/fuben/zszz_text_033.png"
		var_2_5 = string.lf("1. 每个玩家只能在自己对应道上进行投资\n2. 如果所压的投资对象进入前三，会返还本金，而奖金按照非前三名下注的其他资金分配（例如总额1000，第一名300，第二名200，第三名100，未进前三的剩余400资金作为奖金乘以50%，25%，15%，再除以前三投资金的份数，即为前三名投资的玩家除开本金以外额外获得的奖金）\n3. 每个被下注的对象所接收的资金无上限\n4. 每个下注的玩家对同一个下注的对象资金有上限（每个道资金上限不同）\n5. 奖金通过比赛结束以后，在领奖界面领取\n6. 如所投对象没有进入前三，则资金不会退还，会作为投资前三玩家的资金奖励")
	elseif arg_2_0.ruleType == DlgRuleType.ruleMineral then
		var_2_3 = "uilocal/fuben/zszz_text_054.png"
		var_2_5 = string.lf("1. 宝石可以合成和镶嵌，合成不消耗其他资源\n2. 橙色装备才可以镶嵌孔对应形状的宝石:帽子(菱形), 衣服(正方形), 武器(圆形), 项链(月牙形), 戒指(长方形), 鞋子(星形)\n3. 每类宝石的最高等级为10级，低等级的宝石可以通过合成的方式升级为高级宝石\n4. 只有相同等级的宝石才能合成，同等级同类型宝石的100%可以得到更高等级的同类型宝石（3颗1级的正方形宝石可合成为1颗2级的正方形宝石）\n5. 同等级不同形状的宝石也能进行合成，但是合成以后的得到形状随机\n6. 如果只有2颗同等级宝石，也可以合成，规则和3颗一致，但是成功率只有50%，合成失败则宝石消失\n7. 一键合成功能可以把1~3级的宝石自动合成为高级宝石")
	end

	if arg_2_0.ruleType ~= DlgRuleType.ruleGuildLimit then
		local var_2_6 = display.newSprite(var_2_3)

		var_2_6:setScale(var_2_2)
		var_2_6:setPosition(var_2_1.width / 2, var_2_1.height - 10)
		var_2_0:addChild(var_2_6)
	end

	local var_2_7 = var_0_0.newLabel({
		text = var_2_5,
		font = _FONT_DEFAULT,
		size = Adapter.FontSize(22),
		color = ccc3(236, 222, 100),
		align = ui.TEXT_ALIGN_LEFT,
		valign = ui.TEXT_VALIGN_TOP,
		dimensions = CCSize(var_2_1.width - 100, 0)
	})
	local var_2_8 = CCSizeMake(var_2_1.width - 100, var_2_1.height - 125)
	local var_2_9 = var_2_7:getContentSize()

	var_2_9.height = var_2_9.height + 40

	if var_2_8.height > var_2_9.height then
		var_2_7:setPosition(ccp(0, var_2_8.height - var_2_9.height))

		var_2_9.height = var_2_8.height
	end

	local var_2_10 = CCScrollView:create(var_2_8)

	var_2_10:setContentSize(var_2_9)
	var_2_10:addChild(var_2_7)
	var_2_10:setDirection(kCCScrollViewDirectionVertical)
	var_2_10:setPosition(ccp(50, 89))
	var_2_10:setContentOffset(var_2_10:minContainerOffset())
	var_2_0:addChild(var_2_10)

	local var_2_11 = ui.newControlButton({
		fontSize = 25,
		normalImage = "ui/common/common_019.png",
		text = string.lf("确定"),
		anchorPoint = CCPoint(0.5, 0.5),
		position = CCPoint(var_2_1.width / 2, 50),
		clickAction = function()
			arg_2_0:removeFromParentAndCleanup(true)
		end
	})

	var_2_0:addChild(var_2_11)
end

return var_0_1
