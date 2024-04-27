-- Function to process items and insert into the database
function processItems(items, category)
    for _, itemData in ipairs(items) do
        exports.oxmysql:execute("INSERT INTO items (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES (@item, @label, @limit, @can_remove, 'item_standard', @usable, @desc) ON DUPLICATE KEY UPDATE label=@label, `limit`=@limit, can_remove=@can_remove, type='item_standard', usable=@usable, `desc`=@desc", {
            ['@item'] = itemData.Item,
            ['@label'] = itemData.Label,
            ['@limit'] = itemData.Limit,
            ['@can_remove'] = itemData.CanRemove,
            ['@usable'] = itemData.Usable,
            ['@desc'] = itemData.Description
        })
    end
end

-- Main thread to run the script
Citizen.CreateThread(function()
    --process each category of items
    processItems(Config.BankLootItems, 'Bank')
    processItems(Config.OilLootItems, 'Oil')
    processItems(Config.CivilianLootItems, 'Civilian')

    print("All items have been processed and added/updated in the database.")
end)