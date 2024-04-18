-- THIS WILL NOT UPDATE VIA THE AUTO UPDATER
-- THIS CONTAINS THE CONFIGURATION FOR THINGS YOU DON'T WANT OVERWRITTEN

Config.Payment = {
    Money = {
      BPK = true,        -- true = Pay per kill  |  false = fixed amount per kill
      Min = 5,           -- Minimal money value a player can get per kill.
      Max = 7,           -- Maximum money value a player can get per kill
      Static = 10        -- Fixed value of money per  kill
    },
  --------------------------------------------------------------------------------
    XP = {
      XPK = true,       -- true = XP per kill  |  false = fixed amount per kill
      Min = 5,         -- Minimal XP value a player can get per kill.
      Max = 25,         -- Maximum XP value a player can get per kill
      Static = 15        -- Fixed value of XP per kill
    },
    --------------------------------------------------------------------------------
    -- Config for how much loot you get from the lootwagons
    -- Value means the value of the item, not the amount of items
    Loot = {
      Min = 5,         -- Minimal loot **value** a player can get
      Max = 100,         -- Maximum loot **value** a player can get
    },
    -- Config for how much loot you get from the lootwagons
    -- This time the value means the amount of items, not the value of the items
    LootAmount = {
      Min = 3,         -- Minimal loot **amount** a player can get
      Max = 7,         -- Maximum loot **amount** a player can get
    }
}


  