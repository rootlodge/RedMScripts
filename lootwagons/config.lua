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

Config.AIRaidingCompanionBlip = true -- NOT USED YET
Config.AIRaidingCompanion = false -- NOT USED YET

Config.isAbandonedWagonsVisible = false -- TO DO
Config.isWagonBlipVisible = true -- DONE
Config.RivalWagonRaiders = true -- TO DO
Config.RivalWagonRaidersBlip = true -- TO DO

Config.isLootableWagonsTrap = true -- TO DO - Basically, a wagon (not all) that will have a trap for the player and the player will have to kill all of the enemies to loot the wagon

Config.isBankWagonsEnabled = true -- DONE
Config.isOilWagonsEnabled = true -- DONE
Config.isCivilianWagonsEnabled = true -- DONE
Config.isHighSocietyWagonsEnabled = true -- DONE
Config.isMilitaryWagonsEnabled = true -- DONE
Config.isOutlawWagonsEnabled = true -- DONE

Config.AvoidWagonSpawnNearPlayer = true -- TO DO 
Config.AvoidWagonSpawnNearPlayerDistance = 100 -- TO DO

Config.ShouldBePaidForWagonLoot = true -- this is if you want to pay the player for looting wagons on top of the loot they get
Config.MysteriousPersonSellingLocations = true -- TO DO
Config.MysteriousPersonSellingLocationsBlip = true -- TO DO
Config.MysteriousPersonBuysLoot = true -- TO DO
Config.LocalsCanBuyLoot = false -- TO DO

-- WE DO NOT RECOMMEND MORE THAN 2 WAGONS PER TYPE AS IT WILL BE TOO EASY TO FIND THEM

Config.WagonMaxSpawnAmount = {
    { WagonType = 'Bank', MaxAmount = 1 },
    { WagonType = 'Oil', MaxAmount = 1 },
    { WagonType = 'Civilian', MaxAmount = 1 },
    { WagonType = 'HighSociety', MaxAmount = 1 },
    { WagonType = 'Military', MaxAmount = 1 },
    { WagonType = 'Outlaw', MaxAmount = 1 },
}

Config.WagonSpawnTimer = {
    Bank = 1800, -- 30 minutes
    Oil = 1800, -- 30 minutes
    Civilian = 1800, -- 30 minutes
    HighSociety = 1800, -- 30 minutes
    Military = 1800, -- 30 minutes
    Outlaw = 1800, -- 30 minutes
}

Config.WagonSpawnLocations = {
    { x = -259.09, y = 787.88, z = 118.08, h = 194.15 },
    { x = -259.09, y = 787.88, z = 119.08, h = 194.15 },
    { x = -5651.17, y = -3597.95, z = -21.21, h = 91.16 },
    { x = -5548.13, y = -2530.77, z = -10.48, h = 348.58 },
    { x = -2476.13, y = -1297.48, z = 160.37, h = 283.96 },
    { x = 2956.06, y = 686.82, z = 48.55, h = 19.35 },
    { x = 2890.75, y = 2192.24, z = 157.25, h = 130.92 },
    { x = 813.95, y = -811.8, z = 59.07, h = 183.6 },
    { x = -902.44, y = 2703.84, z = 330.83, h = 83.11 },
    { x = 478.75, y = 525.35, z = 110.05, h = 161.45 }
}

Config.Wagons = {
    { WagonType = 'Bank', WagonName = 'Bank Wagon', WagonModel = 'wagon05x' },  -- Added comma
    { WagonType = 'Oil', WagonName = 'Oil Wagon', WagonModel = 'oilwagon01x' },  -- Added comma
    { WagonType = 'Civilian', WagonName = 'Civilian Wagon', WagonModel = 'buggy02' },  -- Added comma
    { WagonType = 'HighSociety', WagonName = 'High Society Wagon', WagonModel = 'coach4' },  -- Added comma
    { WagonType = 'Military', WagonName = 'Military Wagon', WagonModel = 'armysupplywagon' },  -- Added comma
    { WagonType = 'Outlaw', WagonName = 'Outlaw Wagon', WagonModel = 'wagonarmoured01x' },
}

Config.ExtraSupportWagons = {
    { WagonType = 'BankWagons', WagonName = 'Bank Wagon', WagonModel = 'wagon05x' },
}

Config.Horses = {
    { HorseType = 'Bank', HorseModel = 'A_C_Horse_AmericanPaint_Overo' },  -- Added comma
    { HorseType = 'Oil', HorseModel = 'A_C_Horse_AmericanPaint_Greyovero' },  -- Added comma
    { HorseType = 'Civilian', HorseModel = 'A_C_Horse_AmericanPaint_Overo' },  -- Added comma
    { HorseType = 'HighSociety', HorseModel = 'A_C_Horse_AmericanPaint_Overo' },  -- Added comma
    { HorseType = 'Military', HorseModel = 'A_C_Horse_AmericanPaint_Overo' },  -- Added comma
    { HorseType = 'Outlaw', HorseModel = 'A_C_Horse_AmericanPaint_Overo' },
}

Config.PedsInWagons = {
    "A_M_M_Rancher_01",
}

Config.PedsInWagonsBank = {
    "A_M_M_Rancher_01",
}

Config.PedsInWagonsOil = {
    "A_M_M_GriSurvivalist_01",
}

Config.PedsInWagonsCivilian = {
    "A_M_M_Rancher_01",
}

Config.PedsInWagonsHighSociety = {
    "A_M_M_Rancher_01",
}

Config.PedsInWagonsMilitary = {
    "A_M_M_Rancher_01",
}

Config.PedsInWagonsOutlaw = {
    "A_M_M_Rancher_01",
}

Config.BankLootItems = {
    { Item = 'goldbar', Name = 'Gold Bar', Label = 'Gold Bar', Weight = 10, Description = 'A bar of gold', Value = 500 },
    { Item = 'goldcoin', Name = 'Gold Coin', Label = 'Gold Coin', Weight = 0.01, Description = 'A gold coin', Value = 50 },
    { Item = 'goldwatch', Name = 'Gold Watch', Label = 'Gold Watch', Weight = 0.5, Description = 'A gold watch', Value = 100 },
    { Item = 'goldnecklace', Name = 'Gold Necklace', Label = 'Gold Necklace', Weight = 0.5, Description = 'A gold necklace', Value = 100 },
    { Item = 'goldring', Name = 'Gold Ring', Label = 'Gold Ring', Weight = 0.1, Description = 'A gold ring', Value = 50 },
    { Item = 'goldnugget', Name = 'Gold Nugget', Label = 'Gold Nugget', Weight = 0.01, Description = 'A gold nugget', Value = 10 },
    { Item = 'stolen_banknotes', Name = 'Stolen Banknotes', Label = 'Stolen Banknotes', Weight = 0.1, Description = 'Cash stolen from a bank or their armored convoy', Value = 100 },
    { Item = 'stolen_jewelry', Name = 'Stolen Jewelry', Label = 'Stolen Jewelry', Weight = 0.5, Description = 'Jewelry stolen from unsuspecting victims', Value = 200 },
}


Config.OilLootItems = {
    { Item = 'stolen_goldbar', Name = 'Stolen Gold Bar', Label = 'Stolen Gold Bar', Weight = 10, Description = 'A gold bar stolen from a vault', Value = 500 },
    { Item = 'stolen_cash', Name = 'Stolen Cash', Label = 'Stolen Cash', Weight = 0.1, Description = 'Cash stolen from unsuspecting victims', Value = 100 },
    { Item = 'oilbarrel', Name = 'Oil Barrel', Label = 'Oil Barrel', Weight = 10, Description = 'A barrel of oil', Value = 500 },
    { Item = 'oil_bonds', Name = 'Oil Bonds', Label = 'Oil Bonds', Weight = 0.1, Description = 'Bonds for the oil company', Value = 1000 },
}


Config.CivilianLootItems = {
    { Item = 'stolen_cash', Name = 'Stolen Cash', Label = 'Stolen Cash', Weight = 0.1, Description = 'Cash stolen from unsuspecting victims', Value = 100 },
    { Item = 'cannedfood', Name = 'Canned Food', Label = 'Canned Food', Weight = 0.5, Description = 'A can of food', Value = 10 },
    { Item = 'stolen_jewelry', Name = 'Stolen Jewelry', Label = 'Stolen Jewelry', Weight = 0.5, Description = 'Jewelry stolen from unsuspecting victims', Value = 200 },
    { Item = 'weapon_knife', Name = 'Knife', Label = 'Knife', Weight = 0.5, Description = 'A sharp knife', Value = 50 },
    { Item = 'stolen_diamond_ring', Name = 'Stolen Diamond Ring', Label = 'Stolen Diamond Ring', Weight = 0.5, Description = 'A diamond ring stolen from a wealthy victim', Value = 200 },
    { Item = 'diamond_necklace', Name = 'Diamond Necklace', Label = 'Diamond Necklace', Weight = 0.5, Description = 'A diamond necklace', Value = 200 },
    { Item = 'diamond_bracelet', Name = 'Diamond Bracelet', Label = 'Diamond Bracelet', Weight = 0.5, Description = 'A diamond bracelet', Value = 200 },
    { Item = 'diamond_earrings', Name = 'Diamond Earrings', Label = 'Diamond Earrings', Weight = 0.1, Description = 'A pair of diamond earrings', Value = 100 },
}

Config.HighSocietyLootItems = {
    { Item = 'goldbar', Name = 'Gold Bar', Label = 'Gold Bar', Weight = 10, Description = 'A bar of gold', Value = 500 },
    { Item = 'goldcoin', Name = 'Gold Coin', Label = 'Gold Coin', Weight = 0.01, Description = 'A gold coin', Value = 50 },
    { Item = 'goldwatch', Name = 'Gold Watch', Label = 'Gold Watch', Weight = 0.5, Description = 'A gold watch', Value = 100 },
    { Item = 'goldnecklace', Name = 'Gold Necklace', Label = 'Gold Necklace', Weight = 0.5, Description = 'A gold necklace', Value = 100 },
    { Item = 'goldring', Name = 'Gold Ring', Label = 'Gold Ring', Weight = 0.1, Description = 'A gold ring', Value = 50 },
    { Item = 'goldtooth', Name = 'Gold Tooth', Label = 'Gold Tooth', Weight = 0.01, Description = 'A gold tooth', Value = 10 },
    { Item = 'goldnugget', Name = 'Gold Nugget', Label = 'Gold Nugget', Weight = 0.01, Description = 'A gold nugget', Value = 10 },
    { Item = 'stolen_cash', Name = 'Stolen Cash', Label = 'Stolen Cash', Weight = 0.1, Description = 'Cash stolen from unsuspecting victims', Value = 100 },
    { Item = 'stolen_jewelry', Name = 'Stolen Jewelry', Label = 'Stolen Jewelry', Weight = 0.5, Description = 'Jewelry stolen from unsuspecting victims', Value = 200 },
}

Config.MilitaryLootItems = {
    { Item = 'weapon_pistol', Name = 'Pistol', Label = 'Pistol', Weight = 2.0, Description = 'A standard pistol', Value = 500 },
    { Item = 'weapon_rifle', Name = 'Rifle', Label = 'Rifle', Weight = 5.0, Description = 'A standard rifle', Value = 1000 },
    { Item = 'weapon_shotgun', Name = 'Shotgun', Label = 'Shotgun', Weight = 5.0, Description = 'A standard shotgun', Value = 1000 },
    { Item = 'weapon_knife', Name = 'Knife', Label = 'Knife', Weight = 0.5, Description = 'A sharp knife', Value = 50 },
    { Item = 'weapon_machete', Name = 'Machete', Label = 'Machete', Weight = 1.0, Description = 'A large machete', Value = 100 },
    { Item = 'ammo_pistol', Name = 'Pistol Ammo', Label = 'Pistol Ammo', Weight = 0.1, Description = 'Ammo for a pistol', Value = 10 },
    { Item = 'ammo_rifle', Name = 'Rifle Ammo', Label = 'Rifle Ammo', Weight = 0.1, Description = 'Ammo for a rifle', Value = 10 },
    { Item = 'ammo_shotgun', Name = 'Shotgun Ammo', Label = 'Shotgun Ammo', Weight = 0.1, Description = 'Ammo for a shotgun', Value = 10 },
}

Config.OutlawLootItems = {
    -- outlaw items such as stolen cash, weapons, and jewelry
    { Item = 'stolen_cash', Name = 'Stolen Cash', Label = 'Stolen Cash', Weight = 0.1, Description = 'Cash stolen from unsuspecting victims', Value = 100 },
    { Item = 'stolen_jewelry', Name = 'Stolen Jewelry', Label = 'Stolen Jewelry', Weight = 0.5, Description = 'Jewelry stolen from unsuspecting victims', Value = 200 },
    { Item = 'weapon_pistol', Name = 'Pistol', Label = 'Pistol', Weight = 2.0, Description = 'A standard pistol', Value = 500 },
    { Item = 'weapon_rifle', Name = 'Rifle', Label = 'Rifle', Weight = 5.0, Description = 'A standard rifle', Value = 1000 },
    { Item = 'weapon_shotgun', Name = 'Shotgun', Label = 'Shotgun', Weight = 5.0, Description = 'A standard shotgun', Value = 1000 },
    { Item = 'weapon_knife', Name = 'Knife', Label = 'Knife', Weight = 0.5, Description = 'A sharp knife', Value = 50 },
    { Item = 'weapon_machete', Name = 'Machete', Label = 'Machete', Weight = 1.0, Description = 'A large machete', Value = 100 },
    { Item = 'stolen_goldbar', Name = 'Stolen Gold Bar', Label = 'Stolen Gold Bar', Weight = 10, Description = 'A gold bar stolen from a vault', Value = 500 },
    { Item = 'stolen_diamond_ring', Name = 'Stolen Diamond Ring', Label = 'Stolen Diamond Ring', Weight = 0.5, Description = 'A diamond ring stolen from a wealthy victim', Value = 200 },
    { Item = 'stolen_diamond_earrings', Name = 'Stolen Diamond Earrings', Label = 'Stolen Diamond Earrings', Weight = 0.1, Description = 'A pair of diamond earrings stolen from a wealthy victim', Value = 100 },
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