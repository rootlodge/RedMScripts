--------------------------------------------------------------------------------
----------------------------------- RootLodge -----------------------------------
--------------------------------------------------------------------------------
-- Here you can add all HandlerLocations Menu locations.
-- The City name does nothing! this is just a visual reference.
-- x, y, z are the coordinates where the menu will be displayed.
-- Keep in mind if you change these, they may be overwritten with new updates & could cause issues. 
-- iF CHANGING, make sure to revert to the original values and save the changed ones before updating.
--------------------------------------------------------------------------------
Config = {}
Config.locale = 'en'
Config.DevMode = true
Config.CheckForUpdates = true

Config.HandlerLocations = {
  { City = 'Valentine Handler', x = -276.86, y = 921.46, z = 128.31, h = 320.54, model = 'A_M_M_BlWUpperClass_01', scenario = 'WORLD_HUMAN_SHOPKEEPER'},
  { City = 'Saint Denis Handler', x = -270.1, y = 937.18, z = 131.71, h = 335.46, model = 'A_M_M_BiVFancyTravellers_01', scenario = 'WORLD_HUMAN_SHOPKEEPER'},
  { City = 'Blackwater Handler', x = -254.71, y = 905.19, z = 127.45, h = 86.27, model = 'A_M_M_GriSurvivalist_01', scenario = 'WORLD_HUMAN_SHOPKEEPER'},
  -- { City = 'New Austin Handler', x = -274.8, y = 805.5, z = 119.3, h = 340.36, model = 'A_M_M_GriSurvivalist_01', scenario = 'WORLD_HUMAN_SHOPKEEPER'},
}

--Config.HandlerLocations = {
  --{ City = 'Saint Denis Handler', x = 2706.23, y = -1907.66, z = 47.89, h = 313.7, model = 'A_M_M_BiVFancyTravellers_01', scenario = 'WORLD_HUMAN_SHOPKEEPER'},
  --{ City = 'Blackwater Handler', x = -886.24, y = -1084.86, z = 59.32, h = 126.15, model = 'A_M_M_GriSurvivalist_01', scenario = 'WORLD_HUMAN_SHOPKEEPER'},
  -- { City = 'New Austin Handler', x = -274.8, y = 805.5, z = 119.3, h = 340.36, model = 'A_M_M_GriSurvivalist_01', scenario = 'WORLD_HUMAN_SHOPKEEPER'},
--}
-- Config.HandlerNPC removed, now part of Config.HandlerLocations


Config.Languages = {
  ['en'] = {
    ['menu_title'] = 'Hitman Information Board',
    ['menu_button'] = 'G',
    ['menu_text'] = 'Press ~g~G~s~ to start a mission',
    ['subtitles1'] = 'Hello there friend, I have a job for you.',
    ['subtitles2'] = 'I need you to take care of some people for me.',
    ['subtitles3'] = 'I will pay you handsomely for your services.',
    ['subtitles4'] = 'I will mark the location on your map.',
    ['subtitles5'] = 'Remember, dead not alive. Good luck!',
    ['subtitles6'] = 'By the way mister, I have lots of enemies.',
    ['subtitles7'] = 'You can stack contracts, but be careful.',
    ['subtitles8'] = 'If you die, you lose all contracts.',
    ['subtitles9'] = 'You managed to kill all targets.',
    ['subtitles10'] = 'Search the body for evidence,',
    ['subtitles11'] = 'and bring this back to the Hit Board!',
    ['subtitles12'] = 'Bring the evidence to the Hit Board in Saint Denis!',
  },
  ['fr'] = {
    ['menu_title'] = 'Tableau des contrats',
    ['menu_button'] = 'G',
    ['menu_text'] = 'Appuyez sur ~g~G~s~ pour commencer une mission',
    ['subtitles1'] = 'Bonjour mon ami, j\'ai un travail pour vous.',
    ['subtitles2'] = 'J\'ai besoin que vous vous occupiez de certaines personnes pour moi.',
    ['subtitles3'] = 'Je vous paierai généreusement pour vos services.',
    ['subtitles4'] = 'Je vais marquer l\'emplacement sur votre carte.',
    ['subtitles5'] = 'Rappelez-vous, mort pas vivant. Bonne chance!',
    ['subtitles6'] = 'Au fait monsieur, j\'ai beaucoup d\'ennemis.',
    ['subtitles7'] = 'Vous pouvez empiler les contrats, mais soyez prudent.',
    ['subtitles8'] = 'Si vous mourez, vous perdez tous les contrats.',
    ['subtitles9'] = 'Vous avez réussi à tuer toutes les cibles.',
    ['subtitles10'] = 'Recherchez le corps pour des preuves,',
    ['subtitles11'] = 'et ramenez cela au tableau des contrats!',
    ['subtitles12'] = 'Apportez les preuves au tableau des contrats à Saint Denis!',
  },
  ['de'] = {
    ['menu_title'] = 'Hitman Information Board',
    ['menu_button'] = 'G',
    ['menu_text'] = 'Drücken Sie ~g~G~s~, um eine Mission zu starten',
    ['subtitles1'] = 'Hallo mein Freund, ich habe einen Job für dich.',
    ['subtitles2'] = 'Ich brauche, dass du dich um einige Leute für mich kümmerst.',
    ['subtitles3'] = 'Ich werde dich großzügig für deine Dienste bezahlen.',
    ['subtitles4'] = 'Ich werde den Standort auf deiner Karte markieren.',
    ['subtitles5'] = 'Denk daran, tot nicht lebendig. Viel Glück!',
    ['subtitles6'] = 'Übrigens, Mister, ich habe viele Feinde.',
    ['subtitles7'] = 'Sie können Verträge stapeln, aber seien Sie vorsichtig.',
    ['subtitles8'] = 'Wenn du stirbst, verlierst du alle Verträge.',
    ['subtitles9'] = 'Sie haben es geschafft, alle Ziele zu töten.',
    ['subtitles10'] = 'Suchen Sie den Körper nach Beweisen,',
    ['subtitles11'] = 'und bringen Sie dies zurück zum Hit Board!',
    ['subtitles12'] = 'Bringen Sie die Beweise zum Hit Board in Saint Denis!',
  },
  ['es'] = {
    ['menu_title'] = 'Tablero de información de Hitman',
    ['menu_button'] = 'G',
    ['menu_text'] = 'Presiona ~g~G~s~ para comenzar una misión',
    ['subtitles1'] = 'Hola amigo, tengo un trabajo para ti.',
    ['subtitles2'] = 'Necesito que te ocupes de algunas personas por mí.',
    ['subtitles3'] = 'Te pagaré generosamente por tus servicios.',
    ['subtitles4'] = 'Marcaré la ubicación en tu mapa.',
    ['subtitles5'] = 'Recuerda, muerto no vivo. ¡Buena suerte!',
    ['subtitles6'] = 'Por cierto, señor, tengo muchos enemigos.',
    ['subtitles7'] = 'Puedes acumular contratos, pero ten cuidado.',
    ['subtitles8'] = 'Si mueres, pierdes todos los contratos.',
    ['subtitles9'] = 'Lograste matar a todos los objetivos.',
    ['subtitles10'] = '¡Busca el cuerpo en busca de evidencia,',
    ['subtitles11'] = 'y trae esto de vuelta al tablero de Hit!',
    ['subtitles12'] = '¡Lleve la evidencia al tablero de Hit en Saint Denis!',
  },
  ['ru'] = {
    ['menu_title'] = 'Доска объявлений наемников',
    ['menu_button'] = 'G',
    ['menu_text'] = 'Нажмите ~g~G~s~, чтобы начать миссию',
    ['subtitles1'] = 'Привет, друг, у меня для тебя работа.',
    ['subtitles2'] = 'Мне нужно, чтобы ты позаботился о некоторых людях для меня.',
    ['subtitles3'] = 'Я щедро заплачу вам за ваши услуги.',
    ['subtitles4'] = 'Я отмечу местоположение на вашей карте.',
    ['subtitles5'] = 'Помните, мертвый, не живой. Удачи!',
    ['subtitles6'] = 'Кстати, мистер, у меня много врагов.',
    ['subtitles7'] = 'Вы можете накапливать контракты, но будьте осторожны.',
    ['subtitles8'] = 'Если вы умрете, вы потеряете все контракты.',
    ['subtitles9'] = 'Вам удалось убить всех целей.',
    ['subtitles10'] = 'Ищите тело для доказательств,',
    ['subtitles11'] = 'и верните это на доску объявлений!',
    ['subtitles12'] = 'Принесите доказательства на доску объявлений в Сент-Дени!',
  },
  ['pl'] = {
    ['menu_title'] = 'Tablica ogłoszeń Hitmana',
    ['menu_button'] = 'G',
    ['menu_text'] = 'Naciśnij ~g~G~s~ aby rozpocząć misję',
    ['subtitles1'] = 'Cześć, przyjacielu, mam dla ciebie pracę.',
    ['subtitles2'] = 'Potrzebuję, abyś zajął się niektórymi ludźmi za mnie.',
    ['subtitles3'] = 'Zapłacę ci hojnie za twoje usługi.',
    ['subtitles4'] = 'Oznaczę lokalizację na twojej mapie.',
    ['subtitles5'] = 'Pamiętaj, martwy, nie żywy. Powodzenia!',
    ['subtitles6'] = 'A propos, panie, mam wielu wrogów.',
    ['subtitles7'] = 'Możesz gromadzić kontrakty, ale bądź ostrożny.',
    ['subtitles8'] = 'Jeśli umrzesz, stracisz wszystkie kontrakty.',
    ['subtitles9'] = 'Udało ci się zabić wszystkie cele.',
    ['subtitles10'] = 'Szukaj ciała w poszukiwaniu dowodów,',
    ['subtitles11'] = 'i przynieś to z powrotem na tablicę ogłoszeń!',
    ['subtitles12'] = 'Przynieś dowody na tablicę ogłoszeń w Saint Denis!',
  },
  ['es'] = {
    ['menu_title'] = 'Tablero de información de Hitman',
    ['menu_button'] = 'G',
    ['menu_text'] = 'Presiona ~g~G~s~ para comenzar una misión',
    ['subtitles1'] = 'Hola amigo, tengo un trabajo para ti.',
    ['subtitles2'] = 'Necesito que te ocupes de algunas personas por mí.',
    ['subtitles3'] = 'Te pagaré generosamente por tus servicios.',
    ['subtitles4'] = 'Marcaré la ubicación en tu mapa.',
    ['subtitles5'] = 'Recuerda, muerto no vivo. ¡Buena suerte!',
    ['subtitles6'] = 'Por cierto, señor, tengo muchos enemigos.',
    ['subtitles7'] = 'Puedes acumular contratos, pero ten cuidado.',
    ['subtitles8'] = 'Si mueres, pierdes todos los contratos.',
    ['subtitles9'] = 'Lograste matar a todos los objetivos.',
    ['subtitles10'] = '¡Busca el cuerpo en busca de evidencia,',
    ['subtitles11'] = 'y trae esto de vuelta al tablero de Hit!',
    ['subtitles12'] = '¡Lleve la evidencia al tablero de Hit en Saint Denis!',
  },
  -- Add more languages here
}

--------------------------------------------------------------------------------
-- These are the NPC Contracts you can hunt. If you want to add
-- new location/mission, just add the coordinates on the list.
-- NOTE: that the IDs are what combines the enemies in a group.
-- If ID 1 is selected by the randomizer, all enemies with
-- ID 1 will be selected for the mission. The more enties
-- on the same ID, there more you have to kill per mission.
--------------------------------------------------------------------------------
Contracts  = {
  {ID = 1,  Coords = { x = -30.77,   y = 1226.8,   z = 172.92  }},
  {ID = 1,  Coords = { x = -33.77,   y = 1229.8,   z = 172.92  }},
  {ID = 2,  Coords = { x = 489.53,   y = 619.81,   z = 111.7   }},
  {ID = 2,  Coords = { x = 516.53,   y = 621.81,   z = 111.7   }},
  {ID = 2,  Coords = { x = 516.53,   y = 619.81,   z = 111.7   }},
  {ID = 3,  Coords = { x = -423.75,  y = 1736.52,  z = 216.56  }},
  {ID = 3,  Coords = { x = -413.31,  y = 1752.52,  z = 216.25  }},
  {ID = 3,  Coords = { x = -397.92,  y = 1726.46,  z = 216.43  }},
  {ID = 4,  Coords = { x = -29.9,    y = 1227.25,  z = 172.98  }},
  {ID = 4,  Coords = { x = -17.65,   y = 1230.56,  z = 173.26  }},
  {ID = 5,  Coords = { x = 201.13,   y = 1001.63,  z = 189.77  }},
  {ID = 5,  Coords = { x = 223.16,   y = 987.52,   z = 190.89  }},
  {ID = 6,  Coords = { x = -156.23,  y = 1491.12,  z = 116.16  }},
  {ID = 7,  Coords = { x = -689.1,   y = 1042.07,  z = 135.0   }},
  {ID = 8,  Coords = { x = -948.0,   y = 2171.54,  z = 342.11  }},
  {ID = 8,  Coords = { x = -967.86,  y = 2182.34,  z = 340.86  }},
  {ID = 9,  Coords = { x = -1020.68, y = 1690.35,  z = 244.33  }},
  {ID = 10, Coords = { x = -552.95,  y = 2703.03,  z = 320.42  }},
  {ID = 10, Coords = { x = -541.7,   y = 2670.44,  z = 319.09  }},
  {ID = 10, Coords = { x = -556.19,  y = 2708.72,  z = 320.42  }},
  {ID = 11, Coords = { x = -1962.41, y = 2159.86,  z = 327.58  }},
  {ID = 12, Coords = { x = -1632.56, y = 1229.4,   z = 352.09  }},
  {ID = 12, Coords = { x = -1625.73, y = 1252, 83, z = 348.51  }},
  {ID = 12, Coords = { x = -1634.14, y = 1214.69,  z = 352.5   }},
  {ID = 12, Coords = { x = -1648.31, y = 1247.34,  z = 351.08  }},
  {ID = 13, Coords = { x = -1492.04, y = 1248.68,  z = 314.49  }},
  {ID = 13, Coords = { x = -1508.15, y = 1247.45,  z = 313.72  }},
  {ID = 13, Coords = { x = -1505.53, y = 1247.58,  z = 313.76  }},
  {ID = 14, Coords = { x = -1085.23, y = 706.71,   z = 104.49  }},
  {ID = 15, Coords = { x = -815.71,  y = 352.22,   z = 98.09   }},
  {ID = 15, Coords = { x = -860.24,  y = 335.94,   z = 96.42   }},
  {ID = 16, Coords = { x = -613.34,  y = -26.31,   z = 85.98   }},
  {ID = 16, Coords = { x = -629.76,  y = -60.95,   z = 82.86   }},
  {ID = 17, Coords = { x = -362.68,  y = -122.4,   z = 51.18   }},
  {ID = 17, Coords = { x = -344.13,  y = -157.94,  z = 50.71   }},
  {ID = 17, Coords = { x = -327.29,  y = -149.8,   z = 51.08   }},
  {ID = 17, Coords = { x = -360.85,  y = -116.76,  z = 47.6    }},
  {ID = 18, Coords = { x = -61.14,   y = -393.23,  z = 72.21   }},
  {ID = 19, Coords = { x = 900.69,   y = 261.53,   z = 116.0   }},
  {ID = 20, Coords = { x = 1114.8,   y = 488.62,   z = 97.28   }},
  {ID = 20, Coords = { x = 1122.96,  y = 469.77,   z = 97.02   }},
  {ID = 20, Coords = { x = 1178.78,  y = 430.47,   z = 92.78   }},
  {ID = 21, Coords = { x = 769.29,   y = 874.3,    z = 120.95  }},
  {ID = 21, Coords = { x = 776.87,   y = 850.21,   z = 118.9   }}
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