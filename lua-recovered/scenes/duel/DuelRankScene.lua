require("base.figure")
require("network.DuelRequest")
require("scenes.battle.BattleOperator")
require("scenes.team.OthersTeamHelper")

local var_0_0 = require("scenes.toollayer.ctrl")
local var_0_1 = require("base.cache")
local var_0_2 = require("framework.scheduler")
local var_0_3 = {
	eXuan = 3,
	eHuang = 4,
	eDi = 2,
	eTian = 1
}
local var_0_4 = class("DuelRankScene", function()
	return display.newScene("DuelRankScene")
end)

function var_0_4.ctor(arg_2_0, arg_2_1)
	arg_2_0.mRankListData = {}
	arg_2_0.mRefreshCDTime = -1
	arg_2_0.mDuleTimesCDTime = -1
	arg_2_0.mDayCDTime = -1
	arg_2_0.mBigCDTime = -1

	arg_2_0:setUI()

	if not arg_2_1 then
		arg_2_0:requestDuelInfo()
	else
		arg_2_0:onResponseDuelInfo(arg_2_1)
	end

	arg_2_0:setTimer()
	GuideLayer:stepDone(TaskEntryType.eXianmoFight, 2)
	GuideLayer:showGuideLayer(arg_2_0, arg_2_0, TaskEntryType.eXianmoFight, 3, nil, true)
end

function var_0_4.onEnter(arg_3_0)
	return
end

function var_0_4.onExit(arg_4_0)
	arg_4_0:killTimer()
end

function var_0_4.setUI(arg_5_0)
	local var_5_0 = math.max(Adapter.WidthScale, Adapter.HeightScale)
	local var_5_1 = display.newSprite("ui/duel/duel_009.jpg", display.cx, display.cy)

	var_5_1:setScale(var_5_0)
	arg_5_0:addChild(var_5_1)

	local var_5_2 = display.newSprite("ui/duel/duel_001.png", 0, var_5_1:getContentSize().height / 2)

	var_5_2:setAnchorPoint(ccp(0, 0.5))
	var_5_1:addChild(var_5_2)

	local var_5_3 = Adapter.MinScale
	local var_5_4 = CCSizeMake(display.width / var_5_3, display.height / var_5_3)
	local var_5_5 = display.newNode()

	var_5_5:setContentSize(var_5_4)
	var_5_5:setAnchorPoint(ccp(0, 0))
	var_5_5:setScale(var_5_3)
	arg_5_0:addChild(var_5_5)

	arg_5_0.mContainerScale = var_5_3
	arg_5_0.mContainer = var_5_5
	arg_5_0.mContainerSize = var_5_4

	addLabelWithColorSize(var_5_5, string.lf("名次"), ccc3(255, 228, 155), 24, ccp(0, 0), ccp(20, var_5_4.height - 40))
	addLabelWithColorSize(var_5_5, string.lf("玩家信息"), ccc3(255, 228, 155), 24, ccp(0, 0), ccp(150, var_5_4.height - 40))

	local var_5_6 = ui.newControlButton({
		normalImage = "ui/common/common_070.png",
		clickAction = function()
			game.enterHomeScene({
				showSubLayer = 1
			})
		end
	})
	local var_5_7 = var_5_6:getContentSize()

	var_5_6:setPosition(var_5_4.width - var_5_7.width / 2, var_5_4.height - var_5_7.height / 2)
	var_5_5:addChild(var_5_6)

	arg_5_0.mGroupBtnsView = arg_5_0:createGroupBtns()

	arg_5_0.mGroupBtnsView:setAnchorPoint(ccp(0, 0))
	arg_5_0.mGroupBtnsView:setPosition(0, 20)
	var_5_5:addChild(arg_5_0.mGroupBtnsView)

	arg_5_0.mRankView = arg_5_0:createRankLayer(CCSize(arg_5_0.mContainerSize.width * 2 / 5, arg_5_0.mContainerSize.height))

	var_5_5:addChild(arg_5_0.mRankView)

	arg_5_0.mMyRankItem = arg_5_0:createMyRankItem(CCSize(arg_5_0.mContainerSize.width * 2 / 5, 90), true)

	arg_5_0.mMyRankItem:setAnchorPoint(ccp(0, 0))
	arg_5_0.mMyRankItem:setPosition(0, 110)
	var_5_5:addChild(arg_5_0.mMyRankItem)
	arg_5_0.mMyRankItem:setVisible(false)

	arg_5_0.mMyRankInfoView = arg_5_0:createMyRankInfoLayer()

	arg_5_0.mMyRankInfoView:setAnchorPoint(ccp(1, 1))
	arg_5_0.mMyRankInfoView:setPosition(var_5_4.width - var_5_7.width - 20, var_5_4.height - 10)
	var_5_5:addChild(arg_5_0.mMyRankInfoView)

	local var_5_8 = ui.newControlButton({
		normalImage = "ui/duel/duel_008.png",
		titleImage = "uilocal/duel/duel_text_007.png",
		position = ccp(var_5_4.width / 2 + 160, 30),
		clickAction = function()
			arg_5_0:requestRefreshRivalList()
		end
	})

	var_5_5:addChild(var_5_8)

	arg_5_0.mRefreshRivalBtn = var_5_8
	arg_5_0.mLabelRefreshCDTime = addLabelWithColorSize(var_5_5, "", ccc3(204, 204, 204), 20, ccp(0.5, 0), ccp(var_5_4.width / 2 + 160, 55))

	local var_5_9 = ui.newControlButton({
		highlightedImage = "ui/enhance/enhance_015.png",
		normalImage = "ui/enhance/enhance_015.png",
		textColor = ColorTable.eTitleButton_Normal,
		clickAction = handler(arg_5_0, arg_5_0.onDuelRulesBtnClicked),
		position = ccp(arg_5_0.mContainerSize.width - 160, arg_5_0.mContainerSize.height - 160),
		fontSize = ColorTable.eTitleButton_FontSize
	})

	var_5_5:addChild(var_5_9, 1)

	local var_5_10 = arg_5_0:createComonBtns()

	var_5_10:setAnchorPoint(ccp(1, 1))
	var_5_10:setPosition(var_5_4.width, var_5_4.height - var_5_7.height)
	var_5_5:addChild(var_5_10)

	arg_5_0.mRivalView = arg_5_0:createRivalsLayer()

	arg_5_0.mRivalView:setPosition(var_5_4.width / 2, 100)
	var_5_5:addChild(arg_5_0.mRivalView)
end

function var_0_4.createRankLayer(arg_8_0, arg_8_1)
	local var_8_0 = display.newNode()
	local var_8_1 = {}
	local var_8_2
	local var_8_3 = arg_8_0:getImageSize("ui/duel/duel_004.png")

	local function var_8_4(arg_9_0)
		if not var_8_1[arg_9_0] then
			local var_9_0 = CCSizeMake(var_8_3.width - 50, arg_8_1.height - 150)
			local var_9_1 = 110

			if arg_8_0.mRankInfo.Type == arg_9_0 and arg_8_0.mRankInfo.CurRank > 10 then
				var_9_0.height = var_9_0.height - 100
				var_9_1 = 210
			end

			var_8_1[arg_9_0] = arg_8_0:createRankTableView(var_9_0, arg_8_0.mRankListData, arg_9_0)

			var_8_1[arg_9_0]:setAnchorPoint(ccp(0, 0))
			var_8_1[arg_9_0]:setPosition(0, var_9_1)
			var_8_0:addChild(var_8_1[arg_9_0])
		end
	end

	function var_8_0.reloadData(arg_10_0, arg_10_1, arg_10_2)
		var_8_4(arg_10_1)

		arg_8_0.mRankListData[arg_10_1] = arg_10_2

		var_8_1[arg_10_1]:reloadData()
	end

	function var_8_0.showRank(arg_11_0, arg_11_1)
		var_8_4(arg_11_1)

		if var_8_2 then
			var_8_2:setVisible(false)
		end

		var_8_2 = var_8_1[arg_11_1]

		var_8_2:setVisible(true)
		arg_8_0.mGroupBtnsView:disableButton(arg_11_1)

		return true
	end

	return var_8_0
end

function var_0_4.createRankTableView(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local function var_12_0()
		if not arg_12_2[arg_12_3] then
			return 0
		end

		return #arg_12_2[arg_12_3]
	end

	local var_12_1 = CCSizeMake(arg_12_1.width, 90)

	local function var_12_2()
		return var_12_1.height, var_12_1.width
	end

	local function var_12_3(arg_15_0, arg_15_1)
		local var_15_0 = arg_15_1 + 1
		local var_15_1 = arg_15_0:cellAtIndex(arg_15_1)

		if var_15_1 == nil then
			var_15_1 = CCTableViewCell:new()
		end

		var_15_1:removeAllChildrenWithCleanup(true)

		local var_15_2 = display.newSprite("ui/duel/duel_004.png")

		var_15_2:setAnchorPoint(ccp(0, 0))
		var_15_1:addChild(var_15_2)

		local var_15_3 = arg_12_2[arg_12_3][var_15_0]

		if var_15_3.PlayerID == Player.userId then
			local var_15_4 = display.newSprite("ui/PK/PK_005.png", 0, var_12_1.height / 2)

			var_15_4:setAnchorPoint(ccp(0, 0.5))
			var_15_4:setScaleX(0.8)
			var_15_4:setScaleY(1.1)
			var_15_1:addChild(var_15_4)
		end

		local var_15_5 = CCLabelAtlas:create(var_15_3.Rank, "uilocal/duel/duel_text_019.png", 30, 38, 48)

		var_15_5:setAnchorPoint(ccp(0.5, 0.5))
		var_15_5:setPosition(40, var_12_1.height / 2)
		var_15_1:addChild(var_15_5)

		local var_15_6 = arg_12_0:createHeaderView({
			id = var_15_3.PlayerID,
			name = var_15_3.PlayerName,
			AvatarID = var_15_3.AvatarID
		})

		var_15_6:setPosition(120, var_12_1.height / 2)
		var_15_1:addChild(var_15_6)
		addLabelWithColorSize(var_15_1, var_15_3.PlayerName, ccc3(212, 255, 155), 20, ccp(0, 0.5), ccp(170, var_12_1.height / 2 + 25))
		addLabelWithColorSize(var_15_1, string.lf("%d级", var_15_3.Lv), ccc3(212, 255, 155), 20, ccp(0, 0.5), ccp(170, var_12_1.height / 2))
		addLabelWithColorSize(var_15_1, string.lf("排名积分:%d分", var_15_3.FightScore), ccc3(212, 255, 155), 20, ccp(0, 0.5), ccp(170, var_12_1.height / 2 - 25))

		return var_15_1
	end

	local var_12_4 = CCTableView:create(arg_12_1)

	var_12_4:ignoreAnchorPointForPosition(false)
	var_12_4:setVerticalFillOrder(kCCTableViewFillTopDown)
	var_12_4:setDirection(kCCScrollViewDirectionVertical)
	var_12_4:registerScriptHandler(var_12_2, CCTableView.kTableCellSizeForIndex)
	var_12_4:registerScriptHandler(var_12_0, CCTableView.kNumberOfCellsInTableView)
	var_12_4:registerScriptHandler(var_12_3, CCTableView.kTableCellSizeAtIndex)

	return var_12_4
end

function var_0_4.createHeaderView(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_1.id
	local var_16_1 = arg_16_1.name
	local var_16_2 = arg_16_1.AvatarID or 401

	if var_16_2 == 0 then
		var_16_2 = 401
	end

	arg_16_2 = arg_16_2 or 1

	local var_16_3 = CCSize(82 * arg_16_2, 82 * arg_16_2)
	local var_16_4 = CCScale9Sprite:create("ui/common/bg_common.png")

	var_16_4:setPreferredSize(var_16_3)

	local var_16_5 = ui.newControlButton({
		scaleX = arg_16_2,
		scaleY = arg_16_2,
		normalImage = getItemHeaderImagePath(ItemType.eHero, var_16_2),
		clickAction = function()
			if not var_16_0 then
				return showFlashNotice(string.lf("暂时无法跳转，请稍候重试"))
			end

			if false and arg_16_3 then
				game.enterTeamScene({
					returnAction = game.enterDuelRankScene()
				})
			else
				OthersTeamHelper:checkOthersTeam(var_16_0, var_16_1, OthersTeamHelper.eDataFromDuelRank)
			end
		end
	})

	var_16_5:setPosition(var_16_3.width / 2, var_16_3.height / 2)
	var_16_4:addChild(var_16_5)

	return var_16_4
end

function var_0_4.createMyRankInfoLayer(arg_18_0)
	local var_18_0 = display.newNode()
	local var_18_1 = arg_18_0:getImageSize("ui/duel/duel_006.png")

	var_18_0:setContentSize(CCSizeMake(var_18_1.width * 2 + 30, var_18_1.height * 2 + 10))

	local var_18_2 = display.newBatchNode("ui/duel/duel_006.png")

	var_18_0:addChild(var_18_2)

	local var_18_3 = {
		ccp(0, 0),
		ccp(var_18_1.width + 5, 0),
		ccp(0, var_18_1.height + 10),
		ccp(var_18_1.width + 5, var_18_1.height + 10),
		ccp(0, -10 - var_18_1.height),
		(ccp(var_18_1.width + 5, -10 - var_18_1.height))
	}
	local var_18_4 = {}

	for iter_18_0 = 1, #var_18_3 do
		local var_18_5 = display.newSprite("ui/duel/duel_006.png", var_18_3[iter_18_0].x, var_18_3[iter_18_0].y)

		var_18_5:setAnchorPoint(ccp(0, 0))
		var_18_2:addChild(var_18_5)

		var_18_4[iter_18_0] = var_18_5
	end

	var_18_0.mDuelTimesLabel = addLabelWithColorSize(var_18_0, " ", ccc3(228, 228, 228), 20, ccp(0, 0), ccp(var_18_3[1].x + 45, var_18_3[1].y + 4))
	var_18_0.mRewardTimeLabel = addLabelWithColorSize(var_18_0, " ", ccc3(228, 228, 228), 20, ccp(0, 0), ccp(var_18_3[6].x + 45, var_18_3[6].y + 4))
	var_18_0.mScoreLabel = addLabelWithColorSize(var_18_0, " ", ccc3(228, 228, 228), 20, ccp(0, 0), ccp(var_18_3[3].x + 45, var_18_3[3].y + 4))
	var_18_0.mRankLabel = addLabelWithColorSize(var_18_0, " ", ccc3(228, 228, 228), 20, ccp(0, 0), ccp(var_18_3[4].x + 45, var_18_3[4].y + 4))
	var_18_0.mCDTimeLabel = addLabelWithColorSize(var_18_0, " ", ccc3(228, 228, 228), 20, ccp(0, 0), ccp(var_18_3[5].x + 45, var_18_3[5].y + 4))
	var_18_0.mBigCDTimeLabel = addLabelWithColorSize(var_18_0, " ", ccc3(228, 228, 228), 20, ccp(0, 0), ccp(var_18_3[2].x + 45, var_18_3[2].y + 4))

	function var_18_0.setDuelTimes(arg_19_0, arg_19_1, arg_19_2)
		var_18_0.mDuelTimesLabel:setString(string.lf("比赛次数:#00FC66%d/%d", arg_19_1 or 0, arg_19_2 or 0))
	end

	function var_18_0.setDayCDTime(arg_20_0, arg_20_1)
		if arg_20_1 > 0 then
			var_18_4[6]:setVisible(true)
			var_18_0.mRewardTimeLabel:setVisible(true)
			var_18_0.mRewardTimeLabel:setString(string.lf("领奖时间:#00FC66%s", formatTime(arg_20_1)))
		else
			var_18_4[6]:setVisible(false)
			var_18_0.mRewardTimeLabel:setVisible(false)
		end
	end

	function var_18_0.setScore(arg_21_0, arg_21_1)
		var_18_0.mScoreLabel:setString(string.lf("我的积分:#00FC66%d", arg_21_1 or 0))
	end

	function var_18_0.setRank(arg_22_0, arg_22_1)
		var_18_0.mRankLabel:setString(string.lf("当前排名:#00FC66%d", arg_22_1 or 0))
	end

	function var_18_0.setCDTime(arg_23_0, arg_23_1)
		if arg_23_1 > 0 then
			var_18_0.mCDTimeLabel:setVisible(true)
			var_18_4[5]:setVisible(true)
			var_18_0.mCDTimeLabel:setString(string.lf("恢复时间:#00FC66%s", formatTime(arg_23_1)))
		else
			var_18_4[5]:setVisible(false)
			var_18_0.mCDTimeLabel:setVisible(false)
		end
	end

	function var_18_0.setBigCDTime(arg_24_0, arg_24_1)
		if arg_24_1 > 0 then
			var_18_0.mBigCDTimeLabel:setString(string.lf("结束时间:#00FC66%s", formatTime(arg_24_1)))
		else
			var_18_0.mBigCDTimeLabel:setString(string.lf("结算中", formatTime(arg_24_1)))
		end
	end

	var_18_0:setDuelTimes(0, 0)
	var_18_0:setDayCDTime(0)
	var_18_0:setScore(0)
	var_18_0:setRank(0)
	var_18_0:setCDTime(0)
	var_18_0:setBigCDTime(0)

	return var_18_0
end

function var_0_4.createGroupBtns(arg_25_0)
	local var_25_0 = display.newNode()
	local var_25_1 = {
		[var_0_3.eTian] = {
			title = "uilocal/duel/duel_text_009.png"
		},
		[var_0_3.eDi] = {
			title = "uilocal/duel/duel_text_010.png"
		},
		[var_0_3.eXuan] = {
			title = "uilocal/duel/duel_text_011.png"
		},
		[var_0_3.eHuang] = {
			title = "uilocal/duel/duel_text_012.png"
		}
	}
	local var_25_2 = {}
	local var_25_3 = 25
	local var_25_4 = arg_25_0:getImageSize("ui/duel/duel_002.png")

	var_25_0:setContentSize(CCSizeMake((var_25_3 + var_25_4.width) * #var_25_1, var_25_4.height))

	for iter_25_0, iter_25_1 in pairs(var_25_1) do
		local var_25_5 = ui.newControlButton({
			disabledImage = "ui/duel/duel_002.png",
			normalImage = "ui/duel/duel_003.png",
			titleImage = iter_25_1.title,
			position = ccp(iter_25_0 * (var_25_3 + var_25_4.width) - var_25_4.width / 2, var_25_4.height / 2),
			clickAction = function()
				arg_25_0:onGroupBtnClicked(iter_25_0)
			end
		})

		var_25_0:addChild(var_25_5)

		var_25_2[iter_25_0] = var_25_5
	end

	local var_25_6

	function var_25_0.disableButton(arg_27_0, arg_27_1)
		if var_25_6 then
			var_25_6:setEnabled(true)
		end

		var_25_6 = var_25_2[arg_27_1]

		var_25_6:setEnabled(false)
	end

	local var_25_7 = display.newSprite("uilocal/duel/duel_text_001.png")

	var_25_0:addChild(var_25_7)

	function var_25_0.setJoinedGroup(arg_28_0, arg_28_1)
		local var_28_0 = ({
			[var_0_3.eTian] = ccp(10 + var_25_3, var_25_4.height - 3),
			[var_0_3.eDi] = ccp(10 + var_25_3 + var_25_4.width + var_25_3, var_25_4.height - 3),
			[var_0_3.eXuan] = ccp(10 + var_25_3 + (var_25_4.width + var_25_3) * 2, var_25_4.height - 3),
			[var_0_3.eHuang] = ccp(10 + var_25_3 + (var_25_4.width + var_25_3) * 3, var_25_4.height - 3)
		})[arg_28_1]

		if not var_28_0 then
			var_25_7:setVisible(false)
		else
			var_25_7:setVisible(true)
			var_25_7:setPosition(var_28_0)
		end
	end

	var_25_0:setJoinedGroup(0)

	return var_25_0
end

function var_0_4.createComonBtns(arg_29_0)
	local var_29_0 = display.newNode()
	local var_29_1 = {
		{
			img = "uilocal/duel/duel_text_004.png",
			action = handler(arg_29_0, arg_29_0.onGetRewardBtnClicked)
		},
		{
			img = "uilocal/duel/duel_text_005.png",
			action = handler(arg_29_0, arg_29_0.onDuelReportBtnClicked)
		},
		{
			img = "uilocal/duel/duel_text_006.png",
			action = handler(arg_29_0, arg_29_0.onDuelRewardRuleBtnClicked)
		}
	}
	local var_29_2 = arg_29_0:getImageSize("uilocal/duel/duel_text_004.png")
	local var_29_3 = CCSizeMake(var_29_2.width, var_29_2.height * #var_29_1)

	var_29_0:setContentSize(var_29_3)

	for iter_29_0, iter_29_1 in pairs(var_29_1) do
		local var_29_4 = ui.newControlButton({
			normalImage = iter_29_1.img,
			position = ccp(var_29_2.width / 2, var_29_3.height - var_29_2.height * iter_29_0 + var_29_2.height / 2),
			clickAction = iter_29_1.action
		})

		var_29_0:addChild(var_29_4)
	end

	return var_29_0
end

function var_0_4.createRivalsLayer(arg_30_0)
	local var_30_0 = display.newNode()
	local var_30_1 = {
		ccp(160, 200),
		ccp(0, 0),
		(ccp(320, 0))
	}
	local var_30_2 = {}

	function var_30_0.setRival(arg_31_0, arg_31_1, arg_31_2)
		if arg_31_1 < 1 or arg_31_1 > 3 then
			return
		end

		if not tolua.isnull(var_30_2[arg_31_1]) then
			var_30_2[arg_31_1]:removeFromParent()
		end

		local var_31_weapon = arg_31_2.WeaponId or arg_31_2.weaponId

		if not var_31_weapon or var_31_weapon == 0 then
			var_31_weapon = getHeroGroupWeaponId(arg_31_2.AvatarID)
		end

		var_30_2[arg_31_1] = figure.createHero({
			scale = 0.7,
			isViewQuality = false,
			platTable = false,
			figId = arg_31_2.AvatarID,
			equipId = var_31_weapon,
			pinjie = arg_31_2.PinJie or arg_31_2.pinJie or EquipPinjieType.eShengPin,
			rebirthCount = arg_31_2.rebirthCount or arg_31_2.BreakthroughCount or arg_31_2.RebirthCount or 0,
			clickAction = function()
				arg_30_0:onRivalHeroClicked(arg_31_2.PlayerID)
			end
		})

		var_30_2[arg_31_1]:setPosition(var_30_1[arg_31_1])
		arg_31_0:addChild(var_30_2[arg_31_1])

		local var_31_0

		if arg_31_2.IsHigh > 0 then
			var_31_0 = display.newSprite("uilocal/duel/duel_text_008.png")
		else
			var_31_0 = display.newSprite("uilocal/duel/duel_text_002.png")
		end

		var_31_0:setScale(1.4285714285714286)
		var_30_2[arg_31_1]:addChild(var_31_0)

		local var_31_1 = display.newSprite("ui/duel/duel_007.png", 0, -40)

		var_31_1:setScale(1.4285714285714286)
		var_30_2[arg_31_1]:addChild(var_31_1)

		local var_31_2 = string.format("Lv%d  %s", arg_31_2.Lv, arg_31_2.PlayerName)
		local var_31_3 = addLabelWithColorSize(var_30_2[arg_31_1], var_31_2, ccc3(228, 255, 235), 20, ccp(0.5, 0.5), ccp(0, -40))
	end

	return var_30_0
end

function var_0_4.createMyRankItem(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = display.newNode()

	var_33_0:setContentSize(arg_33_1)

	local var_33_1 = display.newSprite("ui/duel/duel_004.png")

	var_33_1:setAnchorPoint(ccp(0, 0))
	var_33_0:addChild(var_33_1)

	if arg_33_2 == true then
		local var_33_2 = display.newSprite("ui/PK/PK_005.png", 0, arg_33_1.height / 2)

		var_33_2:setAnchorPoint(ccp(0, 0.5))
		var_33_2:setScaleX(0.8)
		var_33_2:setScaleY(1.1)
		var_33_0:addChild(var_33_2)
	end

	local var_33_3 = display.newNode()

	var_33_0:addChild(var_33_3)

	local var_33_4 = arg_33_0:createHeaderView({
		id = Player.userId,
		name = Player.nickName
	}, 1, true)

	var_33_4:setPosition(120, arg_33_1.height / 2)
	var_33_3:addChild(var_33_4)

	local var_33_5 = addLabelWithColorSize(var_33_3, Player.nickName, ccc3(212, 255, 155), 20, ccp(0, 0.5), ccp(170, arg_33_1.height / 2 + 25))
	local var_33_6 = addLabelWithColorSize(var_33_3, string.lf("%d级", Player.level), ccc3(212, 255, 155), 20, ccp(0, 0.5), ccp(170, arg_33_1.height / 2))
	local var_33_7 = addLabelWithColorSize(var_33_3, string.lf("排名积分:%d分", 0), ccc3(212, 255, 155), 20, ccp(0, 0.5), ccp(170, arg_33_1.height / 2 - 25))

	function var_33_0.setName(arg_34_0, arg_34_1)
		var_33_5:setString(arg_34_1)
	end

	function var_33_0.setLevel(arg_35_0, arg_35_1)
		var_33_6:setString(string.lf("%d级", arg_35_1))
	end

	function var_33_0.setScore(arg_36_0, arg_36_1)
		var_33_7:setString(string.lf("排名积分:%d分", arg_36_1 or 0))
	end

	local var_33_8

	function var_33_0.setRank(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
		if tolua.isnull(var_33_8) then
			var_33_8 = CCLabelAtlas:create(tostring(arg_37_1), "uilocal/duel/duel_text_019.png", 30, 38, 48)

			arg_37_0:addChild(var_33_8)
		end

		local function var_37_0(arg_38_0)
			if arg_38_0 >= 100 then
				var_33_8:setScale(0.8)
				var_33_8:setAnchorPoint(ccp(0, 0.5))
				var_33_8:setPosition(15, arg_33_1.height / 2)
				var_33_3:setPosition(24 * (string.asciilen(tostring(arg_38_0)) - 2) - 15, 0)
			else
				var_33_8:setAnchorPoint(ccp(0.5, 0.5))
				var_33_8:setPosition(40, arg_33_1.height / 2)
				var_33_8:setScale(1)
				var_33_3:setPosition(0, 0)
			end
		end

		var_33_8:setString(tostring(arg_37_1))
		var_37_0(arg_37_1)

		arg_37_3 = arg_37_3 or 0.5

		if arg_37_2 then
			local var_37_1 = 0

			local function var_37_2(arg_39_0)
				var_37_1 = var_37_1 + arg_39_0

				if var_37_1 >= arg_37_3 then
					var_33_8:unscheduleUpdate()
					var_37_0(arg_37_2)

					return var_33_8:setString(arg_37_2)
				end

				local var_39_0 = math.floor(arg_37_1 + (arg_37_2 - arg_37_1) * var_37_1 / arg_37_3, 1)

				var_37_0(var_39_0)

				return var_33_8:setString(string.format("%d", var_39_0))
			end

			var_33_8:scheduleUpdate(var_37_2)
		end
	end

	function var_33_0.setHeader(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
		if not tolua.isnull(var_33_4) then
			var_33_4:removeFromParent()
		end

		var_33_4 = arg_33_0:createHeaderView({
			AvatarID = arg_40_1,
			name = arg_40_2 or Player.nickName,
			id = arg_40_3 or Player.userId
		}, 1, true)

		var_33_4:setPosition(120, arg_33_1.height / 2)
		var_33_3:addChild(var_33_4)
	end

	var_33_0:setHeader(Player.team.groupList[Player.headerTeamIndex].heroId)
	var_33_0:setRank(0)

	return var_33_0
end

function var_0_4.createChouQianLayer(arg_41_0)
	local var_41_0 = display.newColorLayer(ccc4(0, 0, 0, 160))

	var_41_0:setContentSize(arg_41_0.mContainerSize)

	local var_41_1 = ui.newControlButton({
		normalImage = "ui/common/common_070.png",
		clickAction = function()
			game.enterHomeScene()
		end
	})
	local var_41_2 = var_41_1:getContentSize()

	var_41_1:setPosition(arg_41_0.mContainerSize.width - var_41_2.width / 2, arg_41_0.mContainerSize.height - var_41_2.height / 2)
	var_41_0:addChild(var_41_1)

	local var_41_3 = display.newSprite("uilocal/duel/duel_text_020.png", arg_41_0.mContainerSize.width / 2 - 200, arg_41_0.mContainerSize.height / 2)

	var_41_0:addChild(var_41_3)

	local var_41_4 = CCSkeletonAnimation:createWithFile("uilocal/duel/ui_chouqian.json", "uilocal/duel/ui_chouqian.atlas", 1)

	var_41_4:setPosition(arg_41_0.mContainerSize.width / 2, arg_41_0.mContainerSize.height / 2 - 300)
	var_41_4:setAnchorPoint(ccp(0.5, 0))
	var_41_0:addChild(var_41_4)

	local var_41_5 = CCRect(arg_41_0.mContainerSize.width / 2 - 170, arg_41_0.mContainerSize.height / 2 - 300, 340, 320)
	local var_41_6 = true
	local var_41_7 = false

	var_41_0:addTouchEventListener(function(arg_43_0, arg_43_1, arg_43_2)
		local var_43_0 = ccp(arg_43_1 * arg_41_0.mContainerSize.width / display.width, arg_43_2 * arg_41_0.mContainerSize.height / display.height)

		if var_41_6 ~= true then
			return true
		end

		if arg_43_0 == "began" then
			var_41_7 = var_41_5:containsPoint(var_43_0)

			if var_41_7 == true then
				var_41_4:setScale(1.05)
			end
		elseif arg_43_0 == "ended" then
			if var_41_7 == true and var_41_5:containsPoint(var_43_0) then
				arg_41_0:onChouQianBtnClicked()
			end

			var_41_4:setScale(1)
		elseif arg_43_0 == "moved" then
			if var_41_7 and var_41_5:containsPoint(var_43_0) then
				var_41_4:setScale(1.05)
			else
				var_41_4:setScale(1)
			end
		end

		return true
	end, false, 1, true)
	var_41_0:setTouchEnabled(true)

	function var_41_0.showBoxBtn(arg_44_0, arg_44_1)
		var_41_6 = arg_44_1

		var_41_3:setVisible(arg_44_1)
		var_41_4:setVisible(arg_44_1)
	end

	return var_41_0
end

function var_0_4.getImageSize(arg_45_0, arg_45_1)
	return CCTextureCache:sharedTextureCache():addImage(arg_45_1):getContentSizeInPixels()
end

function var_0_4.setTimer(arg_46_0)
	if not arg_46_0.mRefreshCDTimerHandler then
		arg_46_0.mRefreshCDTimerHandler = var_0_2.scheduleGlobal(handler(arg_46_0, arg_46_0.onRefreshCDTimer), 1)
	end
end

function var_0_4.killTimer(arg_47_0, arg_47_1)
	if arg_47_0.mRefreshCDTimerHandler then
		var_0_2.unscheduleGlobal(arg_47_0.mRefreshCDTimerHandler)

		arg_47_0.mRefreshCDTimerHandler = nil
	end
end

function var_0_4.onRefreshCDTimer(arg_48_0)
	if arg_48_0.mRefreshCDTime and arg_48_0.mRefreshCDTime > 0 then
		arg_48_0.mLabelRefreshCDTime:setString(string.lf("%d秒", arg_48_0.mRefreshCDTime))

		arg_48_0.mRefreshCDTime = arg_48_0.mRefreshCDTime - 1
	else
		arg_48_0.mRefreshRivalBtn:setEnabled(true)
		arg_48_0.mLabelRefreshCDTime:setString("")
	end

	if arg_48_0.mDuleTimesCDTime and arg_48_0.mDuleTimesCDTime >= 0 then
		arg_48_0.mDuleTimesCDTime = arg_48_0.mDuleTimesCDTime - 1

		arg_48_0.mMyRankInfoView:setCDTime(arg_48_0.mDuleTimesCDTime)

		if arg_48_0.mDuleTimesCDTime < 0 then
			arg_48_0:requestDuelInfo()
		end
	end

	if arg_48_0.mDayCDTime and arg_48_0.mDayCDTime >= 0 then
		arg_48_0.mDayCDTime = arg_48_0.mDayCDTime - 1

		arg_48_0.mMyRankInfoView:setDayCDTime(arg_48_0.mDayCDTime)
	end

	if arg_48_0.mBigCDTime and arg_48_0.mBigCDTime >= 0 then
		arg_48_0.mBigCDTime = arg_48_0.mBigCDTime - 1

		arg_48_0.mMyRankInfoView:setBigCDTime(arg_48_0.mBigCDTime)
	end
end

function var_0_4.showRankChangeAction(arg_49_0, arg_49_1, arg_49_2)
	local function var_49_0(arg_50_0, arg_50_1)
		local function var_50_0(arg_51_0, arg_51_1)
			local var_51_0 = arg_49_0:createMyRankItem(CCSize(arg_49_0.mContainerSize.width * 2 / 5, 90), arg_51_1)

			var_51_0:setName(arg_51_0.name)
			var_51_0:setRank(arg_51_0.rank)
			var_51_0:setLevel(arg_51_0.level)
			var_51_0:setScore(arg_51_0.score)
			var_51_0:setHeader(arg_51_0.header, arg_51_0.name, arg_51_0.id)

			return var_51_0
		end

		local var_50_1 = arg_49_0:getImageSize("ui/duel/duel_004.png")
		local var_50_2 = CCSizeMake(var_50_1.width - 50, arg_49_0.mContainerSize.height - 150)
		local var_50_3 = display.newLayer()

		var_50_3:addTouchEventListener(function(arg_52_0, arg_52_1, arg_52_2)
			return false
		end, false, 1, true)
		var_50_3:setTouchEnabled(true)
		arg_49_0.mContainer:addChild(var_50_3)

		local var_50_4 = display.newNode()
		local var_50_5 = CCScrollView:create(var_50_2, var_50_4)

		var_50_5:setDirection(kCCScrollViewDirectionVertical)
		var_50_5:setPosition(0, 110)
		arg_49_0.mContainer:addChild(var_50_5)

		local var_50_6 = arg_50_0.CurRank
		local var_50_7 = arg_50_1.CurRank
		local var_50_8 = arg_49_0.mRankListData[arg_50_1.Type]
		local var_50_9 = #var_50_8 + (var_50_7 > 10 and 1 or 0)
		local var_50_10 = CCSizeMake(var_50_1.width - 50, 90 * var_50_9)

		var_50_4:setContentSize(var_50_10)

		local var_50_11 = {}

		for iter_50_0, iter_50_1 in ipairs(var_50_8) do
			if iter_50_1.PlayerID ~= Player.userId then
				local var_50_12 = var_50_0({
					name = iter_50_1.PlayerName,
					rank = iter_50_1.Rank,
					header = iter_50_1.AvatarID,
					score = iter_50_1.FightScore,
					level = iter_50_1.Lv,
					id = iter_50_1.PlayerID
				})
				local var_50_13 = (#var_50_8 - iter_50_1.Rank) * 90

				if var_50_7 > iter_50_1.Rank and var_50_7 <= 10 then
					var_50_13 = var_50_13 - 90
				end

				if var_50_7 < var_50_6 then
					if var_50_6 >= iter_50_1.Rank then
						var_50_13 = var_50_13 + 90
					end
				elseif var_50_6 > iter_50_1.Rank then
					var_50_13 = var_50_13 + 90
				end

				var_50_12:setAnchorPoint(ccp(0, 0))
				var_50_12:setPosition(0, var_50_13)
				var_50_4:addChild(var_50_12)
				table.insert(var_50_11, {
					item = var_50_12,
					rank = iter_50_1.Rank
				})
			end
		end

		local var_50_14 = Player.team.groupList[Player.headerTeamIndex].heroId
		local var_50_15 = var_50_0({
			name = Player.nickName,
			rank = arg_50_0.CurRank,
			header = var_50_14,
			score = arg_50_1.FightScore,
			level = Player.level,
			id = Player.userId
		}, true)

		var_50_15:setAnchorPoint(ccp(0, 0))
		var_50_15:setPosition(0, (var_50_9 - (var_50_6 > 10 and var_50_9 or var_50_6)) * 90)
		var_50_4:addChild(var_50_15)

		local var_50_16 = 0.8

		for iter_50_2, iter_50_3 in pairs(var_50_11) do
			if false and var_50_7 > 10 then
				if var_50_6 > iter_50_3.rank then
					transition.execute(iter_50_3.item, CCMoveBy:create(var_50_16, ccp(0, -90)))
				end
			elseif var_50_7 < var_50_6 then
				if var_50_6 >= iter_50_3.rank and var_50_7 < iter_50_3.rank or iter_50_3.rank == var_50_6 and var_50_6 == 10 then
					transition.execute(iter_50_3.item, CCMoveBy:create(var_50_16, ccp(0, -90)))
				end
			elseif var_50_6 <= iter_50_3.rank and var_50_7 > iter_50_3.rank then
				transition.execute(iter_50_3.item, CCMoveBy:create(var_50_16, ccp(0, 90)))
			end
		end

		local var_50_17 = 0

		local function var_50_18(arg_53_0)
			if arg_53_0 then
				var_50_3:unscheduleUpdate()
			end

			if var_50_17 == 0 then
				var_50_17 = 1
			elseif var_50_17 == 1 then
				var_50_3:removeFromParent()
				var_50_5:removeFromParent()
				arg_49_0.mRankView:setVisible(true)

				if var_50_7 > 10 then
					arg_49_0.mMyRankItem:setVisible(true)
				end
			end
		end

		local var_50_19 = (var_50_9 - (var_50_7 > 10 and 11 or var_50_7)) * 90
		local var_50_20 = 0
		local var_50_21
		local var_50_22 = var_50_2.height - var_50_10.height
		local var_50_23

		local function var_50_24(arg_54_0)
			local var_54_0 = var_50_5:getContentOffset()
			local var_54_1 = 0

			if var_50_21 then
				var_50_20 = var_50_20 + arg_54_0
				var_54_1 = var_50_21 + (var_50_22 - var_50_21) * var_50_20 / var_50_16
			else
				local var_54_2, var_54_3 = var_50_15:getPosition()

				var_54_1 = var_50_2.height / 2 - var_54_3 - 45
			end

			if arg_54_0 == -1 then
				var_50_3:scheduleUpdate(var_50_24)
			end

			if var_54_1 <= var_50_22 then
				var_54_1 = var_50_22

				if var_50_21 then
					var_50_18(true)
				end
			elseif var_54_1 > 0 then
				var_54_1 = 0
			end

			if not tolua.isnull(var_50_5) then
				var_50_5:setContentOffset(ccp(0, var_54_1))
			end
		end

		var_50_24(-1)
		transition.execute(var_50_15, CCMoveTo:create(var_50_16, ccp(0, var_50_19)), {
			onComplete = function()
				if var_50_7 > 10 then
					var_50_15:removeFromParentAndCleanup(false)
					var_50_15:setPosition(0, 110)
					var_50_3:addChild(var_50_15)
					var_50_4:setContentSize(CCSizeMake(var_50_10.width, var_50_10.height - 90))
					var_50_5:setViewSize(CCSizeMake(var_50_2.width, var_50_2.height - 90))
					var_50_5:setContentOffset(ccp(0, 0))
					var_50_5:setPosition(0, 200)

					var_50_21 = -90
					var_50_22 = var_50_22 - 90

					var_50_18()

					return
				end

				var_50_21 = var_50_5:getContentOffset().y

				var_50_18()
			end
		})
		var_50_15:setRank(var_50_6, var_50_7, var_50_16)
	end

	if arg_49_2.CurRank > 10 and arg_49_1.CurRank > 10 then
		arg_49_0.mRankView:setVisible(true)
		arg_49_0.mMyRankItem:setVisible(true)
		arg_49_0.mMyRankItem:setRank(arg_49_1.CurRank, arg_49_2.CurRank)
	else
		var_49_0(arg_49_1, arg_49_2)
	end
end

function var_0_4.onRivalHeroClicked(arg_56_0, arg_56_1)
	if arg_56_0.mRankInfo and arg_56_0.mRankInfo.HaveTime > 0 then
		return arg_56_0:requestFightRival(arg_56_1)
	end

	local function var_56_0(arg_57_0)
		if Player.curGold < arg_56_0.mRankInfo.IngotCost then
			ui.showMessageBox({
				text = string.lf("元宝不足，去充值吧！"),
				title1 = string.lf("取消"),
				title2 = string.lf("充值"),
				action2 = function()
					game.enterStoreRechargeScene({
						from = "DuelRankScene"
					})
				end
			})
		else
			return arg_56_0:requestFightRival(arg_57_0)
		end
	end

	local var_56_1 = var_0_1.get("DuelRankSceneHideNoTimesTip")

	if var_56_1 and var_56_1.isHideTip == true and var_56_1.cost == arg_56_0.mRankInfo.IngotCost then
		return var_56_0(arg_56_1)
	end

	local var_56_2 = display.newColorLayer(ccc4(0, 0, 0, 180))

	var_56_2:addTouchEventListener(function(arg_59_0, arg_59_1, arg_59_2)
		if arg_59_0 == "began" then
			return true
		end
	end, false, 1, true)
	var_56_2:setTouchEnabled(true)

	local var_56_3 = display.newSprite("ui/guild/guild_090.png", display.cx, display.cy)

	var_56_2:addChild(var_56_3)
	var_56_3:setScale(Adapter.MinScale)

	local var_56_4 = var_56_3:getContentSize()
	local var_56_5 = display.newSprite("uilocal/duel/duel_text_015.png", var_56_4.width / 2, var_56_4.height - 10)

	var_56_3:addChild(var_56_5)
	addLabelWithColorSize(var_56_3, string.lf("是否花费#FFD400%d元宝#D4D4D4挑战一次", arg_56_0.mRankInfo.IngotCost), ccc3(212, 212, 212), 22, ccp(0.5, 0), ccp(var_56_4.width / 2, var_56_4.height / 2 + 30)):setHorizontalAlignment(kCCTextAlignmentLeft)

	local var_56_6 = var_0_0.createCheckBox({
		text = string.lf("本次游戏不再提示"),
		textColor = ccc3(212, 212, 212)
	})

	var_56_6:setPosition(var_56_4.width / 2, var_56_4.height / 2 - 15)
	var_56_3:addChild(var_56_6)

	local var_56_7 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/guild/guild_text_036.png",
		position = ccp(var_56_4.width / 2 + 100, 40),
		clickAction = function()
			var_56_2:removeFromParent()
		end
	})

	var_56_3:addChild(var_56_7)

	local var_56_8 = ui.newControlButton({
		normalImage = "ui/common/common_115.png",
		titleImage = "uilocal/guild/guild_text_035.png",
		position = ccp(var_56_4.width / 2 - 100, 40),
		clickAction = function()
			var_56_2:removeFromParent()
			var_56_0(arg_56_1)
			var_0_1.set("DuelRankSceneHideNoTimesTip", {
				isHideTip = var_56_6:getCheckedState(),
				cost = arg_56_0.mRankInfo.IngotCost
			})
		end
	})

	var_56_3:addChild(var_56_8)
	arg_56_0:addChild(var_56_2)
end

function var_0_4.onGetRewardBtnClicked(arg_62_0)
	local var_62_0 = require("scenes.duel.DuelRewardLayer").new({})

	CCDirector:sharedDirector():getRunningScene():addChild(var_62_0)
end

function var_0_4.onDuelReportBtnClicked(arg_63_0)
	print("DuelRankScene:onDuelReportBtnClicked()")

	local var_63_0 = require("scenes.duel.DuelReportLayer").new({
		haveTime = arg_63_0.mRankInfo.HaveTime,
		goldCost = arg_63_0.mRankInfo.IngotCost
	})

	CCDirector:sharedDirector():getRunningScene():addChild(var_63_0, DefaultZOrder.ePopupLayer)
end

function var_0_4.onDuelRewardRuleBtnClicked(arg_64_0)
	local var_64_0 = require("scenes.duel.PreDuelRewardLayer").new({})

	CCDirector:sharedDirector():getRunningScene():addChild(var_64_0)
end

function var_0_4.onDuelRulesBtnClicked(arg_65_0)
	local var_65_0 = require("scenes.enhance.DlgRuleLayer").new({
		ruleType = DlgRuleType.ruleDuel
	})

	CCDirector:sharedDirector():getRunningScene():addChild(var_65_0)
end

function var_0_4.onGroupBtnClicked(arg_66_0, arg_66_1)
	if not arg_66_0.mRankListData[arg_66_1] then
		arg_66_0:requestRankList(arg_66_1)

		return
	else
		arg_66_0.mRankView:showRank(arg_66_1)
	end

	if arg_66_1 == arg_66_0.mRankInfo.Type and arg_66_0.mRankInfo.CurRank > 10 then
		arg_66_0.mMyRankItem:setVisible(true)
	else
		arg_66_0.mMyRankItem:setVisible(false)
	end
end

function var_0_4.onChouQianBtnClicked(arg_67_0)
	GuideLayer:removeGuideLayer(arg_67_0, TaskEntryType.eXianmoFight, 3)
	arg_67_0:requestChouQian()
end

function var_0_4.requestDuelInfo(arg_68_0)
	if not arg_68_0.mDuelInfoRequest then
		arg_68_0.mDuelInfoRequest = DuelInfoRequest:new()

		local function var_68_0()
			arg_68_0:onResponseDuelInfo(arg_68_0.mDuelInfoRequest.restable)
		end

		arg_68_0.mDuelInfoRequest:setResponseNormalHandler(var_68_0)
	end

	arg_68_0.mDuelInfoRequest:request()
end

function var_0_4.onResponseDuelInfo(arg_70_0, arg_70_1)
	if not arg_70_1 then
		return showFlashNotice(string.lf("暂未开放"))
	end

	if not tolua.isnull(arg_70_0.mChouQianView) then
		arg_70_0.mChouQianView:removeFromParent()
	end

	arg_70_0.mRankInfo = arg_70_1

	if arg_70_1.BeCanFight > 0 and arg_70_1.NoFight then
		arg_70_0.mChouQianView = arg_70_0:createChouQianLayer()

		arg_70_0.mContainer:addChild(arg_70_0.mChouQianView, 1)
		var_0_1.set("DuelRankSceneRankInfo", nil)
	elseif arg_70_1.CurRank then
		table.sort(arg_70_1.RankLst, function(arg_71_0, arg_71_1)
			return arg_71_0.Rank < arg_71_1.Rank
		end)

		local var_70_0 = var_0_1.get("DuelRankSceneRankInfo")

		if arg_70_1.BeCanFight == 0 then
			if not tolua.isnull(arg_70_0.mCanFightTips) then
				arg_70_0.mCanFightTips:removeFromParent()
			end

			arg_70_0.mCanFightTips = display.newSprite("uilocal/duel/duel_text_021.png", arg_70_0.mContainerSize.width - 350, arg_70_0.mContainerSize.height - 165)

			arg_70_0.mCanFightTips:setAnchorPoint(ccp(1, 0))
			arg_70_0.mContainer:addChild(arg_70_0.mCanFightTips)
		end

		for iter_70_0, iter_70_1 in pairs(arg_70_1.ChallengLst or {}) do
			arg_70_0.mRivalView:setRival(iter_70_0, iter_70_1)
		end

		Player:setBiwuCurrentTimes(arg_70_1.HaveTime)
		arg_70_0.mMyRankInfoView:setDuelTimes(arg_70_1.HaveTime, arg_70_1.TotalTime)
		arg_70_0.mMyRankInfoView:setScore(arg_70_1.FightScore)
		arg_70_0.mMyRankInfoView:setRank(arg_70_1.CurRank)

		arg_70_0.mDuleTimesCDTime = arg_70_1.RecoverTime or -1
		arg_70_0.mDayCDTime = arg_70_1.DayCountdown or -1
		arg_70_0.mBigCDTime = arg_70_1.BigCountdown or -1

		arg_70_0.mGroupBtnsView:setJoinedGroup(arg_70_1.Type)

		for iter_70_2, iter_70_3 in pairs(arg_70_1.RankLst) do
			if iter_70_3.PlayerID == Player.userId then
				arg_70_0.mMyRankItem:setHeader(iter_70_3.AvatarID)
				arg_70_0.mMyRankItem:setLevel(iter_70_3.Lv)
			end
		end

		arg_70_0.mMyRankItem:setScore(arg_70_1.FightScore)
		arg_70_0.mMyRankItem:setRank(arg_70_1.CurRank)

		if arg_70_1.CurRank <= 10 then
			arg_70_0.mMyRankItem:setVisible(false)
		else
			arg_70_0.mMyRankItem:setVisible(true)
		end

		arg_70_0.mRankListData[arg_70_1.Type] = arg_70_1.RankLst

		arg_70_0.mRankView:reloadData(arg_70_1.Type, arg_70_1.RankLst)
		arg_70_0.mRankView:showRank(arg_70_1.Type)
		var_0_1.set("DuelRankSceneRankInfo", arg_70_1)

		if var_70_0 and var_70_0.CurRank ~= arg_70_1.CurRank then
			arg_70_0.mMyRankItem:setVisible(false)
			arg_70_0.mRankView:setVisible(false)
			arg_70_0:showRankChangeAction(var_70_0, arg_70_1)
		end
	end
end

function var_0_4.requestFightRival(arg_72_0, arg_72_1)
	BattleOperator:startBattle(eBattleType.DuleFightRival, {
		rivalID = arg_72_1,
		oldRank = arg_72_0.mRankInfo.CurRank,
		oldScore = arg_72_0.mRankInfo.FightScore
	}, function(arg_73_0, arg_73_1)
		game.enterDuelRankScene(arg_73_1.XianMoFight)
	end)
end

function var_0_4.onResponseFightRival(arg_74_0, arg_74_1)
	if arg_74_1 and arg_74_1.BattleResult and arg_74_1.BattleResult.XianMoFight then
		return arg_74_0:onResponseDuelInfo(arg_74_1.BattleResult.XianMoFight)
	end
end

function var_0_4.requestRefreshRivalList(arg_75_0)
	if not arg_75_0.mRefreshRivalList then
		arg_75_0.mRefreshRivalList = DuelRefreshRivalRequest:new()

		local function var_75_0()
			for iter_76_0, iter_76_1 in pairs(arg_75_0.mRefreshRivalList.restable) do
				arg_75_0.mRivalView:setRival(iter_76_0, iter_76_1)
			end

			arg_75_0.mRefreshRivalBtn:setEnabled(false)

			arg_75_0.mRefreshCDTime = 10
		end

		arg_75_0.mRefreshRivalList:setResponseNormalHandler(var_75_0)
	end

	arg_75_0.mRefreshRivalList:request()
end

function var_0_4.requestRankList(arg_77_0, arg_77_1)
	if not arg_77_0.mRankListRequest then
		arg_77_0.mRankListRequest = DuelRankListRequest:new()

		local function var_77_0()
			arg_77_0.mRankView:reloadData(arg_77_0.mLastRequestRankType, arg_77_0.mRankListRequest.restable)
			arg_77_0:onGroupBtnClicked(arg_77_0.mLastRequestRankType)
		end

		arg_77_0.mRankListRequest:setResponseNormalHandler(var_77_0)
	end

	arg_77_0.mLastRequestRankType = arg_77_1

	arg_77_0.mRankListRequest:request(arg_77_1)
end

function var_0_4.requestChouQian(arg_79_0)
	if not arg_79_0.mChouQianRequest then
		arg_79_0.mChouQianRequest = DuelChouQianRequest:new()

		local function var_79_0()
			arg_79_0:onResponseChouQain(arg_79_0.mChouQianRequest.restable)
		end

		arg_79_0.mChouQianRequest:setResponseNormalHandler(var_79_0)

		local function var_79_1()
			arg_79_0.mChouQianView:showBoxBtn(true)
		end

		arg_79_0.mChouQianRequest:setResponseExceptionHandler(var_79_1)
	end

	arg_79_0.mChouQianView:showBoxBtn(false)
	arg_79_0.mChouQianRequest:request()
end

function var_0_4.onResponseChouQain(arg_82_0, arg_82_1)
	if not arg_82_1 then
		return showFlashNotice(string.lf("暂未开放"))
	end

	local var_82_0

	local function var_82_1()
		if not tolua.isnull(var_82_0) then
			var_82_0:removeFromParent()
		end

		local var_83_0 = display.newSprite("ui/guild/guild_090.png", arg_82_0.mContainerSize.width / 2, arg_82_0.mContainerSize.height / 2)

		arg_82_0.mChouQianView:addChild(var_83_0)

		local var_83_1 = var_83_0:getContentSize()
		local var_83_2 = {
			[var_0_3.eTian] = {
				img = "uilocal/duel/duel_text_009.png",
				text = string.lf("天")
			},
			[var_0_3.eDi] = {
				img = "uilocal/duel/duel_text_010.png",
				text = string.lf("地")
			},
			[var_0_3.eXuan] = {
				img = "uilocal/duel/duel_text_011.png",
				text = string.lf("玄")
			},
			[var_0_3.eHuang] = {
				img = "uilocal/duel/duel_text_012.png",
				text = string.lf("黄")
			}
		}

		addLabelWithColorSize(var_83_0, string.lf("恭喜您被分配到#FFD400%s#D4D4D4组", var_83_2[arg_82_1.Type].text), ccc3(212, 212, 212), 24, ccp(0.5, 1), ccp(var_83_1.width / 2, var_83_1.height - 20))

		local var_83_3 = display.newSprite(var_83_2[arg_82_1.Type].img, var_83_1.width / 2, var_83_1.height / 2)

		var_83_3:setScale(2)
		var_83_0:addChild(var_83_3)

		local var_83_4 = ui.newControlButton({
			normalImage = "ui/common/common_115.png",
			titleImage = "uilocal/guild/guild_text_035.png",
			position = ccp(var_83_1.width / 2, 40),
			clickAction = function()
				var_83_0:removeFromParent()

				local var_84_0 = display.newSprite(var_83_2[arg_82_1.Type].img, var_83_1.width / 2, var_83_1.height / 2)

				var_84_0:setScale(2)
				var_84_0:setPosition(arg_82_0.mContainerSize.width / 2, arg_82_0.mContainerSize.height / 2)
				arg_82_0.mChouQianView:addChild(var_84_0)

				local var_84_1, var_84_2 = arg_82_0.mGroupBtnsView:getPosition()
				local var_84_3 = 25
				local var_84_4 = arg_82_0:getImageSize("ui/duel/duel_002.png")
				local var_84_5 = ccp(arg_82_1.Type * (var_84_3 + var_84_4.width) - var_84_4.width / 2, var_84_4.height / 2)

				var_84_5.x = var_84_5.x + var_84_1
				var_84_5.y = var_84_5.y + var_84_2

				local var_84_6 = CCArray:create()

				var_84_6:addObject(CCMoveTo:create(0.7, var_84_5))
				var_84_6:addObject(CCScaleTo:create(0.5, 1))
				transition.execute(var_84_0, CCSpawn:create(var_84_6), {
					onComplete = function()
						arg_82_0:onResponseDuelInfo(arg_82_1)
					end
				})
			end
		})

		var_83_0:addChild(var_83_4)
	end

	local var_82_2 = {
		[var_0_3.eTian] = "tian",
		[var_0_3.eDi] = "di",
		[var_0_3.eXuan] = "xuan",
		[var_0_3.eHuang] = "huang"
	}

	local function var_82_3()
		transition.execute(arg_82_0.mContainer, transition.sequence({
			CCDelayTime:create(0.4)
		}), {
			onComplete = var_82_1
		})
	end

	var_82_0 = CCSkeletonAnimation:createWithFile("uilocal/duel/ui_chouqian.json", "uilocal/duel/ui_chouqian.atlas", 1)

	var_82_0:setAnimation(var_82_2[arg_82_1.Type], false, 0)
	var_82_0:setPosition(arg_82_0.mContainerSize.width / 2, arg_82_0.mContainerSize.height / 2 - 300)
	arg_82_0.mContainer:addChild(var_82_0, 100)
	var_82_0:addAnimationAction(var_82_2[arg_82_1.Type], 1, CCCallFunc:create(var_82_3), AAT_Percent)
end

return var_0_4
