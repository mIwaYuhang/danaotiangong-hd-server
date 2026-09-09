local var_0_0 = class("TabLayer", function()
	return display.newLayer()
end)
local var_0_1
local var_0_2 = ColorTable.eTitleTabButton_Normal
local var_0_3 = ColorTable.eTitleTabButton_Selected

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.normalImage = arg_2_1.normalImage
	arg_2_0.selectedImage = arg_2_1.selectedImage
	arg_2_0.disabledImage = arg_2_1.disabledImage
	arg_2_0.size = arg_2_1.size
	arg_2_0.point = arg_2_1.point
	arg_2_0.labelAnchorPoint = arg_2_1.labelAnchorPoint or ccp(0.5, 0.5)
	arg_2_0.config = arg_2_1.config
	arg_2_0.scaleX = arg_2_1.scaleX

	if arg_2_0.scaleX == nil then
		arg_2_0.scaleX = 1
	end

	arg_2_0.scaleY = arg_2_1.scaleY

	if arg_2_0.scaleY == nil then
		arg_2_0.scaleY = 1
	end

	arg_2_0.cellHandler = arg_2_1.cellHandler
	arg_2_0.changedHandler = arg_2_1.changedHandler
	arg_2_0.isVert = arg_2_1.isVert

	if arg_2_0.isVert == nil then
		arg_2_0.isVert = false
	end

	var_0_1 = CCSprite:create(arg_2_0.normalImage):getTextureRect().size

	if arg_2_0.isVert == true then
		arg_2_0:setContentSize(CCSize(arg_2_0.size.width + var_0_1.width, arg_2_0.size.height))
	else
		arg_2_0:setContentSize(CCSize(arg_2_0.size.width, arg_2_0.size.height + var_0_1.height))
	end

	arg_2_0:setPosition(arg_2_0.point)

	for iter_2_0, iter_2_1 in pairs(arg_2_0.config) do
		if iter_2_1.isDefault == true then
			arg_2_0.curPageTag = iter_2_1.tag

			break
		end
	end

	arg_2_0:addPageLayer()
	arg_2_0:addHeaders()
	arg_2_0.pageLayer:removeAllChildrenWithCleanup(true)
	arg_2_0.cellHandler(arg_2_0.pageLayer, arg_2_0.curPageTag)

	for iter_2_2, iter_2_3 in pairs(arg_2_0.menuItems) do
		if iter_2_3:getTag() == arg_2_0.curPageTag then
			iter_2_3.isSelected = true

			iter_2_3:setBackgroundSpriteForState(CCScale9Sprite:create(arg_2_0.config[arg_2_0.curPageTag].highlightedImage or arg_2_0.selectedImage), CCControlStateNormal)

			break
		end
	end
end

function var_0_0.addPageLayer(arg_3_0)
	arg_3_0.pageLayer = CCLayerColor:create()

	arg_3_0.pageLayer:setColor(ccc3(0, 0, 0))
	arg_3_0.pageLayer:setOpacity(0)
	arg_3_0.pageLayer:setContentSize(arg_3_0.size)
	arg_3_0.pageLayer:setAnchorPoint(CCPoint(0, 0))
	arg_3_0.pageLayer:setPosition(CCPoint(0, 0))
	arg_3_0.pageLayer:removeAllChildrenWithCleanup(true)
	arg_3_0:addChild(arg_3_0.pageLayer, 1)
end

function var_0_0.addHeaders(arg_4_0)
	arg_4_0.menuItems = {}

	local function var_4_0(arg_5_0, arg_5_1)
		local var_5_0 = tolua.cast(arg_5_1, "CCControlButton"):getTag()

		if arg_4_0.curPageTag ~= var_5_0 then
			arg_4_0:reloadLayer(var_5_0)
		end

		for iter_5_0, iter_5_1 in ipairs(arg_4_0.menuItems) do
			local var_5_1 = iter_5_1:getTag() == var_5_0 and var_0_3 or var_0_2

			iter_5_1:setTitleColorForState(var_5_1, CCControlStateNormal)
			iter_5_1:setTitleColorForState(var_5_1, CCControlStateHighlighted)
			iter_5_1:setTitleColorForState(var_5_1, CCControlStateDisabled)
			iter_5_1:getTitleLabelForState(CCControlStateNormal):setAnchorPoint(arg_4_0.labelAnchorPoint)
			iter_5_1:getTitleLabelForState(CCControlStateHighlighted):setAnchorPoint(arg_4_0.labelAnchorPoint)
			iter_5_1:getTitleLabelForState(CCControlStateDisabled):setAnchorPoint(arg_4_0.labelAnchorPoint)
		end
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0.config) do
		if iter_4_1.x == nil then
			iter_4_1.x = 0
		end

		if iter_4_1.y == nil then
			iter_4_1.y = arg_4_0.size.height
		end

		local var_4_1 = arg_4_0.curPageTag == iter_4_1.tag and var_0_3 or var_0_2
		local var_4_2 = {
			normalImage = iter_4_1.normalImage or arg_4_0.normalImage,
			highlightedImage = iter_4_1.highlightedImage or arg_4_0.selectedImage,
			disabledImage = iter_4_1.disabledImage or arg_4_0.disabledImage,
			text = iter_4_1.titleText,
			textColor = var_4_1,
			fontSize = iter_4_1.titleSize and iter_4_1.titleSize or 22,
			position = CCPoint(iter_4_1.x, iter_4_1.y),
			scaleX = arg_4_0.scaleX,
			scaleY = arg_4_0.scaleY,
			clickAction = var_4_0
		}

		if arg_4_0.isVert == true then
			var_4_2.anchorPoint = CCPoint(1, 0.5)
		else
			var_4_2.anchorPoint = CCPoint(0.5, 0)
		end

		local var_4_3 = ui.newControlButton(var_4_2)

		var_4_3:setTag(iter_4_1.tag)
		arg_4_0:addChild(var_4_3)
		var_4_3:getTitleLabelForState(CCControlStateNormal):setAnchorPoint(arg_4_0.labelAnchorPoint)
		var_4_3:getTitleLabelForState(CCControlStateHighlighted):setAnchorPoint(arg_4_0.labelAnchorPoint)
		var_4_3:getTitleLabelForState(CCControlStateDisabled):setAnchorPoint(arg_4_0.labelAnchorPoint)
		table.insert(arg_4_0.menuItems, var_4_3)
	end
end

function var_0_0.reloadLayer(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.menuItems) do
		if iter_6_1:getTag() == arg_6_1 then
			iter_6_1:setBackgroundSpriteForState(CCScale9Sprite:create(arg_6_0.config[arg_6_1].highlightedImage or arg_6_0.selectedImage), CCControlStateNormal)

			iter_6_1.isSelected = true

			local var_6_0 = false

			if arg_6_0.curPageTag ~= arg_6_1 and arg_6_0.changedHandler then
				arg_6_0.changedHandler(arg_6_1)

				var_6_0 = true
			elseif arg_6_0.curPageTag == arg_6_1 then
				for iter_6_2 = 1, arg_6_0.pageLayer:getChildrenCount() do
					local var_6_1 = arg_6_0.pageLayer:getChildren():objectAtIndex(iter_6_2 - 1)

					if var_6_1.reloadLayer then
						var_6_1:reloadLayer(arg_6_2)

						var_6_0 = true
					end
				end
			end

			if var_6_0 == false then
				arg_6_0.pageLayer:removeAllChildrenWithCleanup(true)
				arg_6_0.cellHandler(arg_6_0.pageLayer, arg_6_1)
			end
		elseif iter_6_1.isSelected == true then
			iter_6_1.isSelected = false

			iter_6_1:setBackgroundSpriteForState(CCScale9Sprite:create(arg_6_0.config[iter_6_1:getTag()].normalImage or arg_6_0.normalImage), CCControlStateNormal)
		end

		local var_6_2 = iter_6_1:getTag() == arg_6_1 and var_0_3 or var_0_2

		iter_6_1:setTitleColorForState(var_6_2, CCControlStateNormal)
		iter_6_1:setTitleColorForState(var_6_2, CCControlStateHighlighted)
		iter_6_1:setTitleColorForState(var_6_2, CCControlStateDisabled)
	end

	arg_6_0.curPageTag = arg_6_1
end

function var_0_0.getCurrentTag(arg_7_0)
	return arg_7_0.curPageTag
end

function var_0_0.enableTabs(arg_8_0, arg_8_1)
	local function var_8_0(arg_9_0, arg_9_1)
		for iter_9_0, iter_9_1 in pairs(arg_8_0.menuItems) do
			if iter_9_1:getTag() == arg_9_0 then
				iter_9_1:setEnabled(arg_9_1)

				break
			end
		end
	end

	for iter_8_0, iter_8_1 in pairs(arg_8_1) do
		var_8_0(iter_8_0, iter_8_1)
	end
end

function var_0_0.getTabItems(arg_10_0)
	return arg_10_0.menuItems
end

function var_0_0.getBubbleNumber(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.menuItems) do
		if iter_11_1:getTag() == arg_11_1 then
			if iter_11_1.bubbleNode == nil then
				return 0
			else
				return tonumber(iter_11_1.bubbleNode.numLabel:getString())
			end
		end
	end
end

function var_0_0.setBubbleNumber(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.menuItems) do
		if iter_12_1:getTag() == arg_12_1 then
			if arg_12_2 == 0 then
				if iter_12_1.bubbleNode then
					iter_12_1.bubbleNode:removeFromParentAndCleanup(true)

					iter_12_1.bubbleNode = nil
				end
			elseif iter_12_1.bubbleNode == nil then
				local var_12_0 = iter_12_1:getContentSize()

				iter_12_1.bubbleNode = createNumberWidthBgSprite("ui/common/common_074.png", arg_12_2)

				iter_12_1.bubbleNode:setPosition(var_12_0.width - 15, var_12_0.height - 15)
				iter_12_1:addChild(iter_12_1.bubbleNode, 1)
			else
				iter_12_1.bubbleNode.numLabel:setString(arg_12_2)
			end
		end
	end
end

return var_0_0
