-- Looting Logic
-- Continually checks if the player is looting a wagon, and if they are, it will trigger the looting animation and the looting progress bar, also checks if the player is within the loot wagon


function OilWagonLoot()
    local lootItem = GetRandomOilLootItem()
    -- get random amount of loot items between 1 and 5
    local amount = math.random(1, 5)
    TriggerServerEvent('RootLodge:LootWagons:S:AddItem', lootItem, amount)
end