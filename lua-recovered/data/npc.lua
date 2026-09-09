BaseNPCs = {}

local var_0_0 = 15

for iter_0_0 = 1, var_0_0 do
	require(string.format("data.npcs.npc%d", iter_0_0))
	table.merge(BaseNPCs, _G[string.format("BaseNPCs%d", iter_0_0)])
end
