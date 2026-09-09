Notification = {
	_notifyTable = {}
}

function Notification.registerObserver(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if not arg_1_0._notifyTable[arg_1_3] then
		arg_1_0._notifyTable[arg_1_3] = {}
	end

	for iter_1_0, iter_1_1 in ipairs(arg_1_0._notifyTable[arg_1_3]) do
		if iter_1_1.node == arg_1_1 then
			return
		end
	end

	table.insert(arg_1_0._notifyTable[arg_1_3], {
		node = arg_1_1,
		func = arg_1_2
	})
end

function Notification.unregisterObserver(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0._notifyTable[arg_2_2] then
		for iter_2_0, iter_2_1 in ipairs(arg_2_0._notifyTable[arg_2_2]) do
			if arg_2_1 == iter_2_1.node then
				table.remove(arg_2_0._notifyTable[arg_2_2], iter_2_0)

				break
			end
		end
	end
end

function Notification.postNotification(arg_3_0, arg_3_1)
	if arg_3_0._notifyTable[arg_3_1] then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0._notifyTable[arg_3_1]) do
			iter_3_1.func(iter_3_1.node)
		end
	end
end
