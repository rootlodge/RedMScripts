-- Function to process items and insert into the database
function processItems(items, category)
    for _, itemData in ipairs(items) do
        exports.oxmysql:execute("INSERT INTO items (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES (@item, @label, @limit, @can_remove, 'item_standard', @usable, @desc) ON DUPLICATE KEY UPDATE label=@label, `limit`=@limit, can_remove=@can_remove, type='item_standard', usable=@usable, `desc`=@desc", {
            ['@item'] = itemData.Item,
            ['@label'] = itemData.Label,
            ['@limit'] = '250',
            ['@can_remove'] = '1',
            ['@usable'] = '0',
            ['@desc'] = itemData.Description
        })
    end
end

-- on resource start, create the items table if it doesn't exist
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    processItems(Config.BankLootItems, 'Bank')
    processItems(Config.OilLootItems, 'Oil')
    processItems(Config.CivilianLootItems, 'Civilian')
    processItems(Config.MilitaryLootItems, 'Military')
    processItems(Config.HighSocietyLootItems, 'HighSociety')
    processItems(Config.OutlawLootItems, 'Outlaw')
    print('Items have been processed and inserted into the database.')
end)