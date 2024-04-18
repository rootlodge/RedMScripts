--------------------------------------------------------------------------------
----------------------------------- RootLodge -----------------------------------
--------------------------------------------------------------------------------
-- The City name does nothing! this is just a visual reference.
-- x, y, z are the coordinates where the menu will be displayed.
-- Keep in mind if you change these, they may be overwritten with new updates & could cause issues. 
-- iF CHANGING, make sure to revert to the original values and save the changed ones before updating.
--------------------------------------------------------------------------------
Config = {}
Config.locale = 'en'
Config.DevMode = true
Config.CheckForUpdates = true
Config.AIcompanionBlip = true -- NOT USED YET

-- DO NOT RECOMMEND BELOW 3 SO PEOPLE HAVE A CHANCE!
Config.HowManyWagons = 5
Config.isAbandonedWagonsVisible = false
Config.isWagonBlipVisible = true

Config.WagonSpawnLocations = {
  { x = -274.8, y = 805.5, z = 119.3, h = 340.36 },
}

Config.Wagons = {
    -- Bandit Wagons
    BanditWagons = {
        { Model = 'wagon05x', Name = 'Bandit Wagon', Label = 'Bandit Wagon' },
        { Model = 'wagon05x', Name = 'Bandit Wagon', Label = 'Bandit Wagon' },
        { Model = 'wagon05x', Name = 'Bandit Wagon', Label = 'Bandit Wagon' },
        { Model = 'wagon05x', Name = 'Bandit Wagon', Label = 'Bandit Wagon' },
        { Model = 'wagon05x', Name = 'Bandit Wagon', Label = 'Bandit Wagon' },
    },
    -- Civilian Wagons
    CivilianWagons = {
        { Model = 'wagon05x', Name = 'Civilian Wagon', Label = 'Civilian Wagon' },
        { Model = 'wagon05x', Name = 'Civilian Wagon', Label = 'Civilian Wagon' },
        { Model = 'wagon05x', Name = 'Civilian Wagon', Label = 'Civilian Wagon' },
        { Model = 'wagon05x', Name = 'Civilian Wagon', Label = 'Civilian Wagon' },
        { Model = 'wagon05x', Name = 'Civilian Wagon', Label = 'Civilian Wagon' },
    },
    -- High Society Wagons
    HighSocietyWagons = {
        { Model = 'wagon05x', Name = 'High Society Wagon', Label = 'High Society Wagon' },
        { Model = 'wagon05x', Name = 'High Society Wagon', Label = 'High Society Wagon' },
        { Model = 'wagon05x', Name = 'High Society Wagon', Label = 'High Society Wagon' },
        { Model = 'wagon05x', Name = 'High Society Wagon', Label = 'High Society Wagon' },
        { Model = 'wagon05x', Name = 'High Society Wagon', Label = 'High Society Wagon' },
    },
}

Config.PedsInWagons = {
    "A_M_M_GriSurvivalist_01",
}

Config.LootItems = {
    { Item = 'goldbar', Name = 'Gold Bar', Label = 'Gold Bar', Weight = 10, Description = 'A bar of gold', Value = 500 },
    { Item = 'goldcoin', Name = 'Gold Coin', Label = 'Gold Coin', Weight = 0.01, Description = 'A gold coin', Value = 50 },
    { Item = 'goldwatch', Name = 'Gold Watch', Label = 'Gold Watch', Weight = 0.5, Description = 'A gold watch', Value = 100 },
    { Item = 'goldnecklace', Name = 'Gold Necklace', Label = 'Gold Necklace', Weight = 0.5, Description = 'A gold necklace', Value = 100 },
    { Item = 'goldring', Name = 'Gold Ring', Label = 'Gold Ring', Weight = 0.1, Description = 'A gold ring', Value = 50 },
    { Item = 'goldtooth', Name = 'Gold Tooth', Label = 'Gold Tooth', Weight = 0.01, Description = 'A gold tooth', Value = 10 },
    { Item = 'goldnugget', Name = 'Gold Nugget', Label = 'Gold Nugget', Weight = 0.01, Description = 'A gold nugget', Value = 10 },
}


Config.BanditLootItems {
    -- illegal items such as weapons, stolen jewelry, gold bars
    { Item = 'weapon_pistol', Name = 'Pistol', Label = 'Pistol', Weight = 2.0, Description = 'A standard pistol', Value = 500 },
    { Item = 'stolen_jewelry', Name = 'Stolen Jewelry', Label = 'Stolen Jewelry', Weight = 0.5, Description = 'Jewelry stolen from unsuspecting victims', Value = 200 },
    { Item = 'stolen_goldbar', Name = 'Stolen Gold Bar', Label = 'Stolen Gold Bar', Weight = 10, Description = 'A gold bar stolen from a vault', Value = 500 },
    { Item = 'stolen_cash', Name = 'Stolen Cash', Label = 'Stolen Cash', Weight = 0.1, Description = 'Cash stolen from unsuspecting victims', Value = 100 },
    { Item = 'weapon_knife', Name = 'Knife', Label = 'Knife', Weight = 0.5, Description = 'A sharp knife', Value = 50 },
    { Item = 'weapon_machete', Name = 'Machete', Label = 'Machete', Weight = 1.0, Description = 'A large machete', Value = 100 },
}


Config.CivilianLootItems {
    -- regular items that any civilian would have, with some stolen cash
    { Item = 'stolen_cash', Name = 'Stolen Cash', Label = 'Stolen Cash', Weight = 0.1, Description = 'Cash stolen from unsuspecting victims', Value = 100 },
    { Item = 'apple', Name = 'Apple', Label = 'Apple', Weight = 0.1, Description = 'A fresh apple', Value = 5 },
    { Item = 'bread', Name = 'Bread', Label = 'Bread', Weight = 0.5, Description = 'A loaf of bread', Value = 10 },
    { Item = 'water', Name = 'Water', Label = 'Water', Weight = 0.5, Description = 'A bottle of water', Value = 5 },
    { Item = 'cannedfood', Name = 'Canned Food', Label = 'Canned Food', Weight = 0.5, Description = 'A can of food', Value = 10 },
    { Item = 'stolen_jewelry', Name = 'Stolen Jewelry', Label = 'Stolen Jewelry', Weight = 0.5, Description = 'Jewelry stolen from unsuspecting victims', Value = 200 },
    { Item = 'weapon_knife', Name = 'Knife', Label = 'Knife', Weight = 0.5, Description = 'A sharp knife', Value = 50 },
}

--------------------------------------------------------------------------------
-------- Don't touch this!!! It can create a disturbance in the force! ---------
--------------------------------------------------------------------------------
Config.Keys = {
  -- Mouse buttons
  ["MOUSE1"] = 0x07CE1E61, ["MOUSE2"] = 0xF84FA74F, ["MOUSE3"] = 0xCEE12B50, ["MWUP"] = 0x3076E97C,
  -- keyboard
  ["A"] = 0x7065027D, ["B"] = 0x4CC0E2FE, ["C"] = 0x9959A6F0, ["D"] = 0xB4E465B4, ["E"] = 0xCEFD9220,
  ["F"] = 0xB2F377E8, ["G"] = 0x760A9C6F, ["H"] = 0x24978A28, ["I"] = 0xC1989F95, ["J"] = 0xF3830D8E,
  ["L"] = 0x80F28E95, ["M"] = 0xE31C6A41, ["N"] = 0x4BC9DABB, ["O"] = 0xF1301666, ["P"] = 0xD82E0BD2,
  ["Q"] = 0xDE794E3E, ["R"] = 0xE30CD707, ["S"] = 0xD27782E3, ["U"] = 0xD8F73058, ["V"] = 0x7F8D09B8,
  ["W"] = 0x8FD015D8, ["X"] = 0x8CC9CD42, ["Z"] = 0x26E9DC00, ["RIGHTBRACKET"] = 0xA5BDCD3C,
  ["LEFTBRACKET"] = 0x430593AA, ["CTRL"] = 0xDB096B85, ["TAB"] = 0xB238FE0B, ["SHIFT"] = 0x8FFC75D6,
  ["SPACEBAR"] = 0xD9D0E1C0, ["ENTER"] = 0xC7B5340A, ["BACKSPACE"] = 0x156F7119, ["LALT"] = 0x8AAA0AD4,
  ["DEL"] = 0x4AF4D473, ["PGUP"] = 0x446258B6, ["PGDN"] = 0x3C3DD371, ["F1"] = 0xA8E3F467,
  ["F4"] = 0x1F6D95E5, ["F6"] = 0x3C0A40F2, ["1"] = 0xE6F612E4, ["2"] = 0x1CE6D9EB, ["3"] = 0x4F49CC4C,
  ["4"] = 0x8F9F9E58, ["5"] = 0xAB62E997, ["6"] = 0xA1FDE2A6, ["7"] = 0xB03A913B, ["8"] = 0x42385422,
  ["DOWN"] = 0x05CA7C52, ["UP"] = 0x6319DB71, ["LEFT"] = 0xA65EBAB4, ["RIGHT"] = 0xDEB34313,
}

return Config

