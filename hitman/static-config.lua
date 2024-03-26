-- THIS WILL NOT UPDATE VIA THE AUTO UPDATER
-- THIS CONTAINS THE CONFIGURATION FOR THINGS YOU DON'T WANT OVERWRITTEN

Config.Payment = {
  Money = {
    BPK = true,        -- true = Pay per kill  |  false = fixed amount per kill
    Min = 5,           -- Minimal money value a player can get per kill.
    Max = 7,           -- Maximum money value a player can get per kill
    Static = 10        -- Fixed value of money per bounty kill
  },
--------------------------------------------------------------------------------
  XP = {
    XPK = true,       -- true = XP per kill  |  false = fixed amount per kill
    Min = 25,         -- Minimal XP value a player can get per kill.
    Max = 75,         -- Maximum XP value a player can get per kill
    Static = 50        -- Fixed value of XP per bounty kill
  }
}
