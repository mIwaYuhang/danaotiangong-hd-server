local var_0_0 = class("PageIndicator", function()
	return display.newLayer()
end)
local var_0_1 = "ui/common/common_047.png"
local var_0_2 = "ui/common/common_048.png"
local var_0_3 = 5

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.pageCount = arg_2_1.pageCount
	arg_2_0.pageCurrent = arg_2_1.pageCurrent

	if arg_2_0.pageCurrent == nil then
		arg_2_0.pageCurrent = 1
	end

	arg_2_0.positionY = arg_2_1.positionY
	arg_2_0.pageWidth = arg_2_1.pageWidth
	arg_2_0.pageSpace = arg_2_1.pageSpace

	if arg_2_0.pageSpace == nil then
		arg_2_0.pageSpace = 20
	end

	local var_2_0 = CCSprite:create(var_0_2):getTextureRect().size.width
	local var_2_1 = (arg_2_0.pageWidth - var_0_3 * var_2_0 - (var_0_3 - 1) * arg_2_0.pageSpace) / 2

	if arg_2_0._leftMore == nil then
		arg_2_0._leftMore = display.newSprite("ui/common/common_111.png", var_2_1 - 20, arg_2_0.positionY + 8)

		arg_2_0._leftMore:setFlipX(true)
		arg_2_0:addChild(arg_2_0._leftMore, 1)
	end

	if arg_2_0._rightMore == nil then
		arg_2_0._rightMore = display.newSprite("ui/common/common_111.png", arg_2_0.pageWidth - var_2_1 + 20, arg_2_0.positionY + 8)

		arg_2_0:addChild(arg_2_0._rightMore, 1)
	end

	arg_2_0:addPageIndicators()
end

function var_0_0.addPageIndicators(arg_3_0)
	arg_3_0.indicatorList = {}

	local var_3_0 = CCSprite:create(var_0_2):getTextureRect().size.width
	local var_3_1 = arg_3_0.pageCount > var_0_3 and var_0_3 or arg_3_0.pageCount
	local var_3_2 = (arg_3_0.pageWidth - var_3_1 * var_3_0 - (var_3_1 - 1) * arg_3_0.pageSpace) / 2

	arg_3_0._leftMore:setVisible(arg_3_0.pageCurrent > var_0_3 and true or false)
	arg_3_0._rightMore:setVisible(math.ceil(arg_3_0.pageCurrent / var_0_3) < math.ceil(arg_3_0.pageCount / var_0_3) and true or false)

	for iter_3_0 = 1, var_3_1 do
		local var_3_3 = arg_3_0.pageCurrent % var_0_3

		if var_3_3 == 0 then
			var_3_3 = var_0_3
		end

		local var_3_4 = CCSprite:create(iter_3_0 == var_3_3 and var_0_2 or var_0_1)
		local var_3_5 = var_3_2 + var_3_0 / 2 + (var_3_0 + arg_3_0.pageSpace) * (iter_3_0 - 1)

		var_3_4:setTag(iter_3_0)
		var_3_4:setAnchorPoint(CCPoint(0.5, 0))
		var_3_4:setPosition(CCPoint(var_3_5, arg_3_0.positionY))
		arg_3_0:addChild(var_3_4, 1)
		table.insert(arg_3_0.indicatorList, var_3_4)
	end
end

function var_0_0.updateIndicator(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= nil and arg_4_1 ~= arg_4_0.pageCount then
		arg_4_0.pageCount = arg_4_1
		arg_4_0.pageCurrent = arg_4_2

		for iter_4_0, iter_4_1 in pairs(arg_4_0.indicatorList) do
			iter_4_1:removeFromParentAndCleanup(true)
		end

		arg_4_0:addPageIndicators()
	else
		if arg_4_0.pageCurrent == arg_4_2 then
			return
		end

		arg_4_0._leftMore:setVisible(arg_4_2 > var_0_3 and true or false)
		arg_4_0._rightMore:setVisible(math.ceil(arg_4_2 / var_0_3) < math.ceil(arg_4_0.pageCount / var_0_3) and true or false)

		local var_4_0 = arg_4_2 % var_0_3

		if var_4_0 == 0 then
			var_4_0 = var_0_3
		end

		for iter_4_2, iter_4_3 in pairs(arg_4_0.indicatorList) do
			iter_4_3:setTexture(CCTextureCache:sharedTextureCache():addImage(iter_4_3:getTag() == var_4_0 and var_0_2 or var_0_1))
		end

		arg_4_0.pageCurrent = arg_4_2
	end
end

return var_0_0
