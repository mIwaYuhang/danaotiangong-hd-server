NetworkState = {
	Unknow = 0,
	MQSuccess = 0,
	Success = 1
}
NetworkState.SystemHandler = {}
NetworkState.SystemHandler[99] = function(arg_1_0)
	if type(arg_1_0) == "string" then
		ui.showMessageBox({
			text = arg_1_0
		})
	end
end

local function var_0_0(arg_2_0)
	ui.showMessageBox({
		text = string.lf("系统错误(%d)，请重新登录！", arg_2_0),
		title1 = string.lf("确定"),
		action1 = function()
			game.restartGameEntry()
		end
	})
end

NetworkState.SystemHandler[-1001001] = function()
	var_0_0(-1001001)
end
NetworkState.SystemHandler[-1001002] = function()
	var_0_0(-1001002)
end
NetworkState.SystemHandler[-1001003] = function()
	var_0_0(-1001003)
end
NetworkState.SystemHandler[-1001007] = function()
	var_0_0(-1001007)
end
NetworkState.SystemHandler[-1001005] = function()
	ui.showMessageBox({
		text = string.lf("上仙，系统维护中，请耐心等待哦！：）"),
		action1 = function(...)
			Player:init()
			game.enterServerListScene()
		end
	})
end
NetworkState.SystemHandler[-1104005] = function(arg_10_0)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in pairs(arg_10_0.Result) do
		var_10_0 = var_10_0 + iter_10_1.Size
	end

	local var_10_1 = var_10_0 / 1024 / 1024

	ui.showMessageBox({
		text = string.lf("上仙，有%d个文件需要更新，共计%.1fM。", #arg_10_0.Result, var_10_1),
		action1 = function(...)
			Player:init()
			game.enterCheckUpdateScene({
				data = arg_10_0.Result
			})
		end
	})
end
NetworkState.SystemHandler[-1104001] = function(arg_12_0)
	ui.showMessageBox({
		text = string.lf("上仙，您的客户端版本需要升级！"),
		action1 = function(...)
			IPlatform:instance():OpenUrl(arg_12_0)
		end
	})
end
NetworkState.SystemHandler[-1108002] = function()
	isMoneyEnough(MoneyType.eGold, math.max_num)
end
NetworkState.SystemHandler[-1108001] = function()
	isMoneyEnough(MoneyType.eCoin, math.max_num)
end
NetworkState.SystemHandler[-1108006] = function()
	isConsumePropEnough(ItemType.ePower, math.max_num)
end
NetworkState.SystemHandler[-1117011] = function()
	isEquipCountNotMax(true)
end
NetworkState.SystemHandler[-1143010] = function()
	ui.showMessageBox({
		text = string.lf("上仙，仙盟不存在，无法再进行任何仙盟操作！"),
		action1 = function(...)
			game.enterHomeScene()
		end
	})
end
NetworkState.SystemHandler[-1157009] = function()
	showFlashNotice(string.lf("上仙，为了保证您的最大收益，请先收宝石！"), nil, nil, 3)
end
NetworkState.NoNickName = -1103002
NetworkState.NameAlreadyExists = -1103001
NetworkState.PlayerNotCharge = -1105004
NetworkState.ShenQiMateNotEnough = -1108005
NetworkState.TransportRobed = -1119005
NetworkState.ShenQiFragmentNull = -1139012
NetworkState.StarRewardFailed = -1106007
NetworkState.ZSZZBattleFailed = -1154013
NetworkState.ExceptionNames = {
	[0] = string.lf("未知错误"),
	[-1001004] = string.lf("非法字符"),
	[-1001006] = string.lf("数据库不存在该数据"),
	[-1001008] = string.lf("签名不正确"),
	[-1001009] = string.lf("不支持此功能"),
	[-1102001] = string.lf("玩家的账号不存在"),
	[-1102002] = string.lf("玩家的密码不正确"),
	[-1102003] = string.lf("玩家的账号不符合规则"),
	[-1102004] = string.lf("玩家的邮箱不符合规则"),
	[-1102005] = string.lf("玩家的账号绑定不匹配"),
	[-1102006] = string.lf("玩家的设备令牌不一致"),
	[-1102007] = string.lf("玩家的账号已经存在"),
	[-1102009] = string.lf("用户名和邮箱不匹配"),
	[-1102010] = string.lf("禁止登录"),
	[-1102011] = string.lf("账号系统异常"),
	[-1103003] = string.lf("玩家的角色不存在"),
	[-1103004] = string.lf("玩家的等级不够"),
	[-1103005] = string.lf("与玩家的等级相同"),
	[-1103006] = string.lf("VIP等级不够"),
	[-1103007] = string.lf("初始化第一个主将出错"),
	[-1105001] = string.lf("订单号重复"),
	[-1105002] = string.lf("商品不存在"),
	[-1105003] = string.lf("充值验证错误"),
	[-1105005] = string.lf("首充奖励已领取"),
	[-1105006] = string.lf("8日奖励已领取"),
	[-1105007] = string.lf("充值不足8日"),
	[-1106001] = string.lf("章节未开启"),
	[-1106002] = string.lf("战役地图已到最后"),
	[-1106003] = string.lf("战役今日挑战次数已用完"),
	[-1106004] = string.lf("该关卡从未战斗胜利过"),
	[-1106005] = string.lf("战斗十次时间冷却中"),
	[-1106006] = string.lf("不在战斗十次时间冷却中"),
	[NetworkState.StarRewardFailed] = string.lf("没有奖励可领取，或者已被领取"),
	[-1106008] = string.lf("该关卡不存在"),
	[-1106009] = string.lf("星级未开放"),
	[-1107001] = string.lf("未达到副本解锁条件"),
	[-1107002] = string.lf("免费次数已用完，需付费才可开启副本"),
	[-1107003] = string.lf("今日副本进入次数已用完"),
	[-1108003] = string.lf("卡牌不足"),
	[-1108004] = string.lf("碎片不足"),
	[-1108005] = string.lf("道具不足"),
	[-1108007] = string.lf("奖励格式有误"),
	[-1108008] = string.lf("培养丹不足"),
	[-1108009] = string.lf("修习点不足"),
	[-1108010] = string.lf("副将强化丹不足"),
	[-1108011] = string.lf("阅历不足"),
	[-1108012] = string.lf("荣誉不足"),
	[-1108013] = string.lf("装备不足"),
	[-1108014] = string.lf("装备重铸石不足"),
	[-1108015] = string.lf("魂玉不足"),
	[-1108016] = string.lf("威望不足"),
	[-1108018] = string.lf("天命不足"),
	[-1108020] = string.lf("天命经验不足"),
	[-1108021] = string.lf("天命碎片不足"),
	[-1108022] = string.lf("寻访卡牌不足"),
	[-1108023] = string.lf("寻访授业值不足"),
	[-1109000] = string.lf("玩家不存在该邮件"),
	[-1109001] = string.lf("邮件附件为空"),
	[-1109002] = string.lf("邮件已处理"),
	[-1109003] = string.lf("发送时间过短"),
	[-1109004] = string.lf("邮件附件格式不正常"),
	[-1110001] = string.lf("账号不存在"),
	[-1110002] = string.lf("卡牌正在战斗中"),
	[-1110003] = string.lf("卡牌已经到顶级"),
	[-1110004] = string.lf("玩家卡牌中主将不存在"),
	[-1110005] = string.lf("玩家卡牌中副将不存在"),
	[-1110006] = string.lf("玩家卡牌在编队中无法使用"),
	[-1110007] = string.lf("玩家卡牌等级超过了角色等级"),
	[-1110008] = string.lf("升级所需的经验不足"),
	[-1110009] = string.lf("经验池内已经没有剩余经验"),
	[-1111001] = string.lf("玩家队伍不存在"),
	[-1111002] = string.lf("玩家队伍中主将不存在"),
	[-1111003] = string.lf("玩家队伍中主将不能被卸载"),
	[-1111004] = string.lf("玩家队伍微博解锁已经成功过"),
	[-1111005] = string.lf("玩家队伍中副将已存在"),
	[-1012001] = string.lf("好友信息不存在"),
	[-1012002] = string.lf("玩家的好友数量已达上限"),
	[-1012003] = string.lf("好友数据有误"),
	[-1012004] = string.lf("对方的好友数量已达上限"),
	[-1012005] = string.lf("好友信息已存在"),
	[-1012006] = string.lf("好友验证已存在"),
	[-1149001] = string.lf("今日已赠送好友精力"),
	[-1149002] = string.lf("好友没有赠送精力"),
	[-1149003] = string.lf("领取达到最大次数"),
	[-1149004] = string.lf("精力值已满"),
	[-1149005] = string.lf("VIP等级不够"),
	[-1149006] = string.lf("VIP等级不够"),
	[-1113001] = string.lf("无法开启夺宝"),
	[-1114001] = string.lf("超过道具叠加数量"),
	[-1114002] = string.lf("招财符使用超限"),
	[-1114003] = string.lf("道具数量不足"),
	[-1114004] = string.lf("玩家没有该道具"),
	[-1114005] = string.lf("道具必须为将魂"),
	[-1114006] = string.lf("挑战令使用次数超限"),
	[-1114007] = string.lf("您的对应钥匙数量不够"),
	[-1114008] = string.lf("您的对应宝箱数量不够"),
	[-1114009] = string.lf("没有该道具的原型"),
	[-1114010] = string.lf("该道具的今日使用次数为0"),
	[-1114011] = string.lf("该道具的今日使用次数不够"),
	[-1114012] = string.lf("该道具的今日购买次数为0"),
	[-1114013] = string.lf("该道具的今日购买次数不够"),
	[-1114014] = string.lf("该道具不能购买"),
	[-1114015] = string.lf("没有达到购买此道具的条件"),
	[-1114016] = string.lf("达到购买此道具的玩家上限"),
	[-1114017] = string.lf("达到购买此道具的次数上限"),
	[-1114018] = string.lf("该道具类型未被处理"),
	[-1114019] = string.lf("副本解锁石头数量超过限制"),
	[-1115001] = string.lf("培养丹不足，抓奴隶可以获得大量培养丹哦"),
	[-1116001] = string.lf("玩家主将不存在"),
	[-1116002] = string.lf("玩家主将类型与武器专属职业不匹配"),
	[-1116003] = string.lf("主将进阶无效(配置不存在)"),
	[-1116004] = string.lf("主将等级不足"),
	[-1116005] = string.lf("该主将已存在"),
	[-1116006] = string.lf("奇术已达最大等级"),
	[-1116007] = string.lf("主将在编队中"),
	[-1116008] = string.lf("主将不在编队中"),
	[-1117001] = string.lf("玩家装备不存在"),
	[-1117002] = string.lf("玩家装备类型不匹配"),
	[-1117003] = string.lf("玩家装备重铸未开启（未达等级）"),
	[-1117004] = string.lf("玩家装备锻造银币不足"),
	[-1117005] = string.lf("玩家装备上阵中"),
	[-1117006] = string.lf("玩家装备已到达最大等级"),
	[-1117007] = string.lf("玩家装备属性已到达最大等级"),
	[-1117008] = string.lf("玩家装备等级不足"),
	[-1117009] = string.lf("该装备没有这个喂灵属性"),
	[-1117010] = string.lf("装备等级受角色等级限制"),
	[-1117012] = string.lf("该装备不能喂灵"),
	[-1117013] = string.lf("该装备需要的喂灵材料不足"),
	[-1117014] = string.lf("现有的同名装备需要重生后才能喂灵"),
	[-1117015] = string.lf("装备重铸锁定的品阶不正确"),
	[-1117016] = string.lf("喂灵使用的资源不正确"),
	[-1117017] = string.lf("喂灵使用的装备不存在"),
	[-1117018] = string.lf("喂灵使用的装备不满足条件"),
	[-1117019] = string.lf("只有橙色装备才能使用天外陨铁喂灵"),
	[-1117020] = string.lf("合成所用的资源数量不一致"),
	[-1117021] = string.lf("合成所用的资源必须为橙色"),
	[-1117022] = string.lf("您传递的合成参数有误"),
	[-1118001] = string.lf("副将等级超过了玩家等级"),
	[-1118002] = string.lf("副将已在编队中"),
	[-1118003] = string.lf("该副将已存在"),
	[-1119001] = string.lf("玩家上香超过次数"),
	[-1119002] = string.lf("玩家香火已达最大等级和最高经验"),
	[-1119003] = string.lf("玩家抢劫次数限制"),
	[-1119004] = string.lf("玩家运镖已结束"),
	[-1119005] = string.lf("此镖车已被人先下手为强了"),
	[-1119006] = string.lf("更新运镖数据失败"),
	[-1119007] = string.lf("上仙，您的运镖次数不足了噢~"),
	[-1119008] = string.lf("您的镖车已经是最高品质"),
	[-1120001] = string.lf("招财次数已达上限"),
	[-1121001] = string.lf("该位置已有俘虏"),
	[-1121002] = string.lf("今日已达最大抓捕次数"),
	[-1121003] = string.lf("好友没有被抓捕，或者已被解救"),
	[-1121004] = string.lf("解救好友的次数已达最大值"),
	[-1121005] = string.lf("玩家没有被抓捕，或者已被解救"),
	[-1121006] = string.lf("该位置尚未解锁"),
	[-1121007] = string.lf("该玩家被超级抓捕令所逮捕"),
	[-1121008] = string.lf("该玩家是你的主人，不能抓捕"),
	[-1122001] = string.lf("积分不足"),
	[-1122002] = string.lf("没有该爬塔层的数据"),
	[-1122003] = string.lf("已完成通天塔最高层"),
	[-1122004] = string.lf("无通天塔昨日排名"),
	[-1122005] = string.lf("无通天塔上周排名"),
	[-1122006] = string.lf("玩家处于战斗失败不能继续的状态"),
	[-1122007] = string.lf("没有复活次数"),
	[-1122008] = string.lf("凌晨重置登塔数据，请重新登塔"),
	[-1122009] = string.lf("非展示的Buff商店层数"),
	[-1122010] = string.lf("Buff已购买"),
	[-1122011] = string.lf("已达到最大购买次数"),
	[-1122012] = string.lf("奖励已被领取"),
	[-1122013] = string.lf("挑战已达最大次数"),
	[-1122014] = string.lf("购买Buff已达最大限制"),
	[-1122015] = string.lf("扫荡只能从第一层开始扫荡"),
	[-1122016] = string.lf("扫荡已经达到最大次数"),
	[-1123001] = string.lf("您的积分不足"),
	[-1123003] = string.lf("不存在该资源"),
	[-1123004] = string.lf("争霸排名错误"),
	[-1123005] = string.lf("争霸挑战次数不足"),
	[-1123006] = string.lf("争霸尚未解锁"),
	[-1123007] = string.lf("争霸兑换次数有限制"),
	[-1123008] = string.lf("暂时没有可领取的积分"),
	[-1124001] = string.lf("您今天已经签到了"),
	[-1124002] = string.lf("该签到奖励已被领取"),
	[-1124003] = string.lf("您的签到天数不够"),
	[-1125001] = string.lf("副本未解锁"),
	[-1125002] = string.lf("玩家该副本已完成"),
	[-1125003] = string.lf("该副本需要重置，请重新进入副本"),
	[-1125004] = string.lf("该玩家没有重置次数"),
	[-1125005] = string.lf("副本此牌已翻"),
	[-1125006] = string.lf("副本没有完成"),
	[-1125007] = string.lf("翻牌已达最大次数"),
	[-1125008] = string.lf("还有星星未被消耗完"),
	[-1125009] = string.lf("该副本的挑战次数已用完"),
	[-1125010] = string.lf("消耗的星星超过限度"),
	[-1125011] = string.lf("该物品的购买次数已用完"),
	[-1125012] = string.lf("该副本已经开放"),
	[-1125013] = string.lf("该副本尚未开放"),
	[-1126001] = string.lf("无奖励信息"),
	[-1126002] = string.lf("无活动礼包"),
	[-1126003] = string.lf("不满足领取活动礼包的条件"),
	[-1126004] = string.lf("礼包已被领取完"),
	[-1127001] = string.lf("您的抽取次数已用完"),
	[-1127002] = string.lf("该位置的卡牌已被收取"),
	[-1127003] = string.lf("抽取的卡牌已被收取"),
	[-1128001] = string.lf("您的幸运字数量不足"),
	[-1128002] = string.lf("您的探宝次数已不足"),
	[-1128003] = string.lf("今日的幸运轮盘探宝次数已用完"),
	[-1128004] = string.lf("今日的幸运轮盘刷新次数已用完"),
	[-1128005] = string.lf("幸运轮盘的此宝物已被兑换"),
	[-1129001] = string.lf("您已参与这次天女散花活动"),
	[-1129002] = string.lf("天女散花没在活动时间内"),
	[-1130001] = string.lf("您没有该灵芝"),
	[-1130002] = string.lf("服用灵芝已达最大次数"),
	[-1131001] = string.lf("奖励已被领取"),
	[-1132001] = string.lf("激活码不符合使用平台"),
	[-1132002] = string.lf("激活码无效"),
	[-1132003] = string.lf("激活码已被使用"),
	[-1132004] = string.lf("激活码限制了使用次数"),
	[-1132005] = string.lf("激活码配置错误"),
	[-1132006] = string.lf("激活码已经过期"),
	[-1133001] = string.lf("您的任务尚未完成"),
	[-1133002] = string.lf("您的任务奖励已被领取"),
	[-1134001] = string.lf("召唤副将列表已满"),
	[-1134002] = string.lf("该宝瓶不能被召唤"),
	[-1134003] = string.lf("没有可收取或转换灵力的副将"),
	[-1135001] = string.lf("您的翻牌次数为0"),
	[-1135002] = string.lf("此牌已翻"),
	[-1135003] = string.lf("卡牌已被全部翻完"),
	[-1136001] = string.lf("传入的主将不符合炼化要求"),
	[-1136002] = string.lf("魂魄数量不足"),
	[-1136003] = string.lf("魂魄数量不符合炼化要求"),
	[-1136004] = string.lf("传入的装备不符合炼化要求"),
	[-1136005] = string.lf("传入的碎片不符合炼化要求"),
	[-1137001] = string.lf("神秘商店的刷新次数已用完"),
	[-1137002] = string.lf("该物品已没有购买次数"),
	[-1138001] = string.lf("此玩家没有被膜拜的资格"),
	[-1138002] = string.lf("您与此玩家不在同一个分组内"),
	[-1138003] = string.lf("此玩家的今日被膜拜次数已用完"),
	[-1138004] = string.lf("该排行榜信息为空"),
	[-1138005] = string.lf("此玩家不在排行榜内，不能下注"),
	[-1138006] = string.lf("您没有对该排名的玩家下注"),
	[-1138007] = string.lf("您下注的玩家没有胜利"),
	[-1138008] = string.lf("赌注超过限制范围"),
	[-1138009] = string.lf("您不在排名范围内，无法领奖"),
	[-1138010] = string.lf("您已领取排名奖励"),
	[-1138011] = string.lf("没有仙魔战报的信息"),
	[-1138012] = string.lf("上一轮比赛没有正常进行"),
	[-1138013] = string.lf("您已领取赌注奖励"),
	[-1138014] = string.lf("比赛尚未结束，没有排行榜数据"),
	[-1138015] = string.lf("16强未打完，无法查看8强战报"),
	[-1139001] = string.lf("不能挑战该神器"),
	[-1139002] = string.lf("挑战玩家不存在"),
	[-1139003] = string.lf("挑战次数不足,不能挑战玩家"),
	[-1139004] = string.lf("没有战斗信息"),
	[-1139005] = string.lf("该属性未解锁"),
	[-1139006] = string.lf("没有此神器"),
	[-1139007] = string.lf("该玩家今天被抢夺次数已达到最大"),
	[-1139008] = string.lf("神器未解锁"),
	[-1139009] = string.lf("器魂未满"),
	[-1139010] = string.lf("您的等级不够，该神器未解锁"),
	[-1139011] = string.lf("该神器已达最高阶"),
	[-1139012] = string.lf("该玩家没有这个碎片"),
	[-1139013] = string.lf("玩家神器殿没有此碎片信息"),
	[-1139014] = string.lf("玩家神器殿被抢夺碎片和玩家神器等阶不一致"),
	[-1139015] = string.lf("碎片已达最大数量，不能抢夺"),
	[-1139003] = string.lf("抢夺次数不足"),
	[-1139016] = string.lf("已达到最大次数"),
	[-1122002] = string.lf("没有该爬塔层的数据"),
	[-1122017] = string.lf("扫荡只能从低于历史最高层的层数开始扫荡"),
	[-1122008] = string.lf("凌晨重置登塔数据，请重新登塔"),
	[-1144001] = string.lf("该珍品没有购买次数"),
	[-1144002] = string.lf("该商品没有购买次数"),
	[-1144003] = string.lf("建筑等级不足未开放"),
	[-1144004] = string.lf("价格需大于目前出价"),
	[-1144005] = string.lf("您已经出价"),
	[-1144006] = string.lf("竞价已结束"),
	[-1140001] = string.lf("没有该等级礼包原型"),
	[-1140002] = string.lf("未解锁"),
	[-1140003] = string.lf("该等级礼包已领取"),
	[-1141001] = string.lf("没有该等级成长配置"),
	[-1141002] = string.lf("未解锁"),
	[-1141003] = string.lf("该成长奖励已领取"),
	[-1141004] = string.lf("成长计划已购买"),
	[-1141005] = string.lf("成长计划还未购买"),
	[-1103006] = string.lf("玩家vip等级不够"),
	[-1145001] = string.lf("未达到领取条件,不可领取"),
	[-1145002] = string.lf("已领取"),
	[-1143001] = string.lf("仙盟未找到"),
	[-1143002] = string.lf("玩家已经拥有仙盟"),
	[-1143003] = string.lf("不满足创建条件"),
	[-1143004] = string.lf("今日膜拜已达最大次数"),
	[-1143005] = string.lf("雕像今日被膜拜已达最大次数"),
	[-1143006] = string.lf("仙盟成员已满"),
	[-1143007] = string.lf("同时申请数量已达上限"),
	[-1143008] = string.lf("上次离开仙盟时间尚未冷却"),
	[-1143009] = string.lf("您已申请该仙盟"),
	[-1143011] = string.lf("权限不足"),
	[-1143012] = string.lf("仙盟当前职位成员已满"),
	[-1143013] = string.lf("留言内容不能为空"),
	[-1143014] = string.lf("玩家不是盟主"),
	[-1143015] = string.lf("仙盟内还有其他玩家"),
	[-1143016] = string.lf("留言内容字数超出限制"),
	[-11430019] = string.lf("仙盟魔族挑战已达最大次数"),
	[-11430020] = string.lf("仙盟魔族挑战魔族已经死亡"),
	[-11430021] = string.lf("仙盟魔族挑战魔族未开放"),
	[-11430022] = string.lf("仙盟魔族复活已达最大次数"),
	[-11430023] = string.lf("盟主不能退出仙盟"),
	[-11430024] = string.lf("已达最大等级"),
	[-11430025] = string.lf("仙盟等级不够"),
	[-11430026] = string.lf("晶石不足"),
	[-11430027] = string.lf("玩家仙盟魔族无此魔族的挑战信息"),
	[-11430029] = string.lf("玩家仙盟魔族不在挑战中"),
	[-11430030] = string.lf("该条玩家仙盟申请不存在"),
	[-11430031] = string.lf("超过11级的仙盟不能被解散"),
	[-11430032] = string.lf("这个仙盟名称已被占用"),
	[-11430033] = string.lf("剩余仙盟晶石不足"),
	[-1147001] = string.lf("已抽签"),
	[-1147002] = string.lf("不是你的仇人"),
	[-1147004] = string.lf("该奖励已领取"),
	[-1147005] = string.lf("没有奖励配置"),
	[-1147006] = string.lf("还未开始比武,请12点再来参加"),
	[-1146001] = string.lf("猎命位置错误"),
	[-1146002] = string.lf("不能花元宝猎命"),
	[-1146003] = string.lf("猎命格子已满"),
	[-1146004] = string.lf("天命收取位置错误"),
	[-1146005] = string.lf("天命分解位置错误"),
	[-1146006] = string.lf("没有可以分解的天命"),
	[-1146007] = string.lf("天命没有这个兑换信息"),
	[-1146008] = string.lf("您的等级不够"),
	[-1146009] = string.lf("天命兑换数量有误"),
	[-1146010] = string.lf("您没有这个天命"),
	[-1146011] = string.lf("该天命已经上阵"),
	[-1146012] = string.lf("队伍里没有这个天命"),
	[-1146013] = string.lf("已经装备有相同类型的天命"),
	[-1146014] = string.lf("该天命对应的位置尚未解锁"),
	[-1146015] = string.lf("该天命不能上阵"),
	[-1146017] = string.lf("天命已经达到最大等级"),
	[-1146018] = string.lf("天命光环达到最大等级"),
	[-1146019] = string.lf("召唤天命达到最大次数"),
	[-1146020] = string.lf("天命光环位置错误"),
	[-114600011] = string.lf("玩家天命上阵中"),
	[-114600013] = string.lf("玩家天命队伍中的天命类型重复"),
	[-114600014] = string.lf("玩家天命队伍位置未解锁"),
	[-114600010] = string.lf("玩家没有此天命"),
	[-114600015] = string.lf("玩家此天命不能上阵"),
	[-114600017] = string.lf("天命达到最大等级"),
	[-1148001] = string.lf("交易信息不存在"),
	[-1148002] = string.lf("交易已结束"),
	[-1148003] = string.lf("交易数量不足"),
	[-1148004] = string.lf("交易条件不足"),
	[-1148005] = string.lf("交易已完成"),
	[-1150001] = string.lf("您已经领取过该礼包"),
	[-1150002] = string.lf("无效的邀请码(只可输入本服玩家邀请码)"),
	[-1150003] = string.lf("不可使用自己的邀请码"),
	[-1150004] = string.lf("该礼包不存在"),
	[-1150005] = string.lf("不可重复领取"),
	[-1150006] = string.lf("未达到领取条件"),
	[-1151001] = string.lf("Vip等级不足，不能使用预约"),
	[-1151002] = string.lf("战斗已打响,不可预约,赶紧去参战吧"),
	[-1151003] = string.lf("您已预约成功,请勿重复预约"),
	[-1151004] = string.lf("鼓舞已达上限"),
	[-1151005] = string.lf("Vip等级不足，不能使用自动战斗"),
	[-1151006] = string.lf("无战斗信息,不可复活"),
	[-1151007] = string.lf("无须复活"),
	[-1151008] = string.lf("BOSS已经死亡"),
	[-1151009] = string.lf("无此BOSS信息"),
	[-1151010] = string.lf("活动尚未开始或已结束"),
	[-1151011] = string.lf("正在活动期间"),
	[-1151012] = string.lf("已领取过奖励"),
	[-1151013] = string.lf("您已死亡，还在冷却中"),
	[-1151014] = string.lf("您不能自动战斗"),
	[-1152001] = string.lf("该卡牌尚未激活"),
	[-1152002] = string.lf("该卡牌已经满额"),
	[-1152003] = string.lf("这个卡牌不存在"),
	[-1152004] = string.lf("这个拜师组合不存在"),
	[-1152005] = string.lf("这个拜师组合已经参拜过了"),
	[-1152006] = string.lf("寻访令不足"),
	[-1153001] = string.lf("您已经占领了三清宝座，无法继续挑战"),
	[-1153002] = string.lf("您不在当前的三界，不能挑战"),
	[-1153003] = string.lf("您不在活动时间内，不能挑战"),
	[-1154001] = string.lf("您已经对当前界进行过鼓舞，不能重复鼓舞"),
	[-1154002] = string.lf("当前时段不可下注"),
	[-1154003] = string.lf("银币下注数量超过上限"),
	[-1154004] = string.lf("元宝下注数量超过上限"),
	[-1154005] = string.lf("当前时段不可进行鼓舞"),
	[-1154006] = string.lf("只可在您所在界下注"),
	[-1154007] = string.lf("只可在已下注界继续下注"),
	[-1154008] = string.lf("比赛进行中，不能领奖"),
	[-1154009] = string.lf("该奖励已领取或不存在"),
	[-1154011] = string.lf("您下注的玩家不存在"),
	[-1154012] = string.lf("您未闯入诸神之战，无相关战报"),
	[-1155001] = string.lf("您今日已领取月卡奖励"),
	[-1155002] = string.lf("倒计时还未结束，无法获得周卡"),
	[-1157001] = string.lf("相关宝石信息不存在"),
	[-1157002] = string.lf("相关宝石已经镶嵌到装备"),
	[-1157003] = string.lf("合成所需的材料宝石不足"),
	[-1157004] = string.lf("相关宝石已达最大等级"),
	[-1157005] = string.lf("宝石的等级不相等"),
	[-1157006] = string.lf("非橙色装备不能镶嵌宝石"),
	[-1157007] = string.lf("宝石只能镶嵌到对应类型的装备"),
	[-1157008] = string.lf("当前装备没有镶嵌宝石"),
	[-1157009] = string.lf("必须先收取再购买黄金锄头")
}
NetworkState.AccountNotExists = -1102001
NetworkState.PasswordError = -1001007
NetworkState.AccountAlreadyExists = -1102007

local function var_0_1()
	print("SDK系统错误")
end

NetworkState.SystemHandler[-1] = var_0_1
NetworkState.SystemHandler[-2] = var_0_1
NetworkState.SystemHandler[-99] = var_0_1
NetworkState.SystemHandler[-1102008] = function()
	ui.showMessageBox({
		text = string.lf("上仙，会话过期了哦，请重新登录！T.T"),
		title1 = string.lf("确定"),
		action1 = function()
			game.restartGameEntry()
		end
	})
end
NetworkState.SdkAccountNotRegistered = -1110001
NetworkState.SdkPasswordWrong = -1110002
NetworkState.SdkForbiddenLogin = -1110003
NetworkState.SdkAccountExists = -1110004
NetworkState.SdkAccountPasswordWrong = -1110005
NetworkState.SdkAccountWrong = -1110007
NetworkState.SdkEmailWrong = -1110008
ThirdNetworkState = {
	Unknow = 0,
	MQSuccess = 0
}
ThirdNetworkState.SystemHandler = {}
