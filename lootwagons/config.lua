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

Config.isBankWagonsEnabled = true -- DONE
Config.isOilWagonsEnabled = true -- DONE
Config.isCivilianWagonsEnabled = true -- DONE
Config.isHighSocietyWagonsEnabled = true -- DONE
Config.isMilitaryWagonsEnabled = true -- DONE
Config.isOutlawWagonsEnabled = true -- DONE

Config.AvoidWagonSpawnNearPlayer = true -- TO DO 


-- WE DO NOT RECOMMEND MORE THAN 3 WAGONS PER TYPE AS IT WILL BE TOO EASY TO FIND THEM
Config.WagonMaxSpawnAmount = {
    Bank = 1,
    Oil = 1,
    Civilian = 1,
    HighSociety = 1,
    Military = 1,
    Outlaw = 1,
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
    { WagonType = 'Bank', WagonName = 'Bank Wagon', WagonModel = 'wagon05x'}
    { WagonType = 'Oil', WagonName = 'Oil Wagon', WagonModel = 'wagon05x'},
    { WagonType = 'Civilian', WagonName = 'Civilian Wagon', WagonModel = 'wagon05x' },
    { WagonType = 'HighSociety', WagonName = 'High Society Wagon', WagonModel = 'wagon05x' },
    { WagonType = 'Military', WagonName = 'Military Wagon', WagonModel = 'armysupplywagon' },
    { WagonType = 'Outlaw', WagonName = 'Outlaw Wagon', WagonModel = 'wagon05x' },
}

Config.ExtraSupportWagons = {
    { WagonType = 'BankWagons', WagonName = 'Bank Wagon', WagonModel = 'wagon05x' },
}

Config.Horses = {
    { HorseType = 'Bank', HorseModel = 'A_C_Horse_AmericanPaint_Overo'}
    { HorseType = 'Oil', HorseModel = 'A_C_Horse_AmericanPaint_Greyovero' },
    { HorseType = 'Civilian', HorseModel = 'A_C_Horse_AmericanPaint_Overo' },
    { HorseType = 'HighSociety', HorseModel = 'A_C_Horse_AmericanPaint_Overo' },
    { HorseType = 'Military', HorseModel = 'A_C_Horse_AmericanPaint_Overo' },
    { HorseType = 'Outlaw', HorseModel = 'A_C_Horse_AmericanPaint_Overo' },
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

Config.PedsinBankWagons = {
    "A_M_M_Rancher_01",
}

Config.BankLootItems = {}
Config.OilLootItems = {}
Config.CivilianLootItems = {}

addItemsToConfig()

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

