local usingVorp = true
VORPinv = exports.vorp_inventory

function AddItem(source, item, amount)
    -- Directly add item to inventory using VORP
    exports['vorp_inventory']:addItem(source, item, amount)
end

function RemoveItem(source, item, amount)
    -- Directly remove item from inventory using VORP
    local itemData = exports['vorp_inventory']:getItem(source, item)
    if itemData then
        exports['vorp_inventory']:subItem(source, item, amount)
    end
end

function GetItemAmount(source, name)
    -- Get the amount of an item a user has using VORP
    local itemData = exports['vorp_inventory']:getItem(source, name)
    if itemData then
        return itemData.amount
    end
    return 0
end

function GiveMoney(source, count)
    -- Give money to a character using VORP
    local Character = VorpCore.getUser(source).getUsedCharacter
    if Character then
        Character.addCurrency(0, count)
    end
end

-- Registering a command to test adding items
RegisterCommand('testscript', function(source, args, rawCommand)
    -- Adds items directly to a player's inventory
    exports['vorp_inventory']:addItem(source, 'goldcoin', 2)
    exports['vorp_inventory']:addItem(source, 'goldbar', 2)
end, true) -- Ensure this command is restricted properly for admin use or testing
