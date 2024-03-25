-- THIS WILL NOT UPDATE VIA THE AUTO UPDATER
-- THIS CONTAINS THE CONFIGURATION FOR THINGS YOU DON'T WANT OVERWRITTEN

-- Here you can choose how you want your UI to look like.
-- NOTE: That you can only have 1 enabled at the same time.
-- If 1 is set to [ true ] the other one needs to be [ false ]
--------------------------------------------------------------------------------
-- Same thing counts for the Themes. Only 1 can be activated at once!
--------------------------------------------------------------------------------
NUI = {
    Theme = { Dark = false, Red = true },
    Position = { Right = true, Left = false, Center = false }
  }
  
  --------------------------------------------------------------------------------
  Payment = {
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