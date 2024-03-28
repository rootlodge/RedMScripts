-- Root Lodge Hit Contracts
local VORPcore = {}
TriggerEvent("getCore", function(core) VORPcore = core end)
function Wait(args) Citizen.Wait(args) end

local VORPutils = {}
TriggerEvent("getUtils", function(utils)
    VORPutils = utils
end)

local Models = {
  "MP_CHU_ROB_MILLESANI_MALES_01", "mp_dr_u_m_m_MISTAKENBOUNTIES_01", "A_M_M_BynSurvivalist_01", "U_M_O_BlWPoliceChief_01",
  "A_M_M_HtlRoughTravellers_01", "A_M_M_JamesonGuard_01", "A_M_M_MOONSHINERS_01", "A_M_M_RkrFancyTravellers_01", "A_M_M_SkpPrisoner_01", "A_M_O_SDUpperClass_01", "CS_exconfedsleader_01",
  "CS_NbxPoliceChiefFormal", "G_M_O_UniExConfeds_01", "S_M_M_Army_01", "RE_WEALTHYCOUPLE_MALES_01"
}

local Wagons = {}

local Weapons = {
  0x772C8DD6, 0x169F59F7, 0xDB21AC8C, 0x6DFA071B,
  0xF5175BA1, 0xD2718D48, 0x797FBF5, 0x772C8DD6,
  0x7BBD1FF6, 0x63F46DE6, 0xA84762EC, 0xDDF7BC1E,
  0x20D13FF, 0x1765A8F8, 0x657065D6, 0x8580C63E,
  0x95B24592, 0x31B7B9FE, 0x88A855C, 0x1C02870C,
  0x28950C71, 0x6DFA071B
}

RegisterNetEvent('RootLodge:HitContracts:C:SetUpMission')
RegisterNetEvent('RootLodge:HitContracts:C:ResetTotalKills')

TotalKilled = 0
local ArrayTargets = {}
local CreateNPC = {}
local NPCx, NPCy, NPCz = 0, 0, 0
local InMission = false
local TotalEnemies = 0
local SearchingBodies = false
local GPSToBodyIsSet = false
local SaveGuard = false
local GPStoSDboardactive = false

--local unashedblip = 'blip_mp_attack_target'
--local hashedblip = GetHashKey(unashedblip)
--BlipAddForEntity(hashedblip, rawpeds)

AddEventHandler('RootLodge:HitContracts:C:SetUpMission', function()
  -- Make sure this script does not execute twice.
  SaveGuard = true
  


  -- Stop the user
  if alwaysfalse and not alwaystrue then Notify("Something has went terribly wrong. Please contact the server administrator!", 1000) return end

    -- Get a random target/contract ID
    local rLoc = Contracts[math.random(#Contracts)]
    -- Get all NPCs associated with this ID
    for k, v in pairs(Contracts) do
      if v.ID == rLoc.ID then
        TotalEnemies = TotalEnemies + 1
        -- Get a random model for this NPC
        local rModel = GetHashKey(Models[math.random(#Models)])
        RequestModel(rModel)
        if not HasModelLoaded(rModel) then RequestModel(rModel) end
        while not HasModelLoaded(rModel) do Wait(1) end
        -- Spawn the NPC with a random loadout
        local rWeapon = Weapons[math.random(#Weapons)]
        CreateNPC[k] = CreatePed(rModel, v.Coords.x, v.Coords.y, v.Coords.z, true, true, true, true)
        Citizen.InvokeNative(0x283978A15512B2FE, CreateNPC[k], true)
        --Citizen.InvokeNative(0x23f74c2fda6e7c61, 639638961, CreateNPC[k])
        addBlipForCoords("GROUP OF TARGETS", 1366733613, v.Coords.x, v.Coords.y, v.Coords.z)
        NPCx, NPCy, NPCz = v.x, v.y, v.z
        GiveWeaponToPed_2(CreateNPC[k], rWeapon, 50, true, true, 1, false, 0.5, 1.0, 1.0, true, 0, 0)
        SetCurrentPedWeapon(CreateNPC[k], rWeapon, true)
        TaskCombatPed(CreateNPC[k], PlayerPedId())
        ArrayTargets[k] = CreateNPC[k]
      end
    end

    Wait(1000)
    CenterBottomNotify('Your target has been located. Check your map!', 5000)
    Wait(2000)
    CenterBottomNotify('We need them dead, not alive! But Dead!', 5000)
    InMission = true
    SaveGuard = false
    while InMission do Wait(1)
      for k, v in pairs(ArrayTargets) do

        if not GPSToBodyIsSet then
          GPSToBodyIsSet = true
          StartGpsMultiRoute(6, true, true)
          local npcCoords = GetEntityCoords(ArrayTargets[k])
          AddPointToGpsMultiRoute(npcCoords.x, npcCoords.y, npcCoords.z)
          SetGpsMultiRouteRender(true)
        end

        if IsEntityDead(v) then
          local eCoords = GetEntityCoords(ArrayTargets[k])

          if ArrayTargets[k] ~= nil then
            TotalEnemies = TotalEnemies - 1
            TotalKilled = TotalKilled + 1
            ArrayTargets[k] = nil
            if TotalEnemies == 0 then
              SetGpsMultiRouteRender(false)
              CenterBottomNotify('You managed to kill all targets', 5000)
              SearchingBodies = true
              Wait(5000)
              CenterBottomNotify('Search the body for evidence to confirm the kill!', 5000)
              while SearchingBodies do Wait(1)
                local playerped = PlayerPedId()
                local pCoords = GetEntityCoords(playerped)
                local dist = GetDistanceBetweenCoords(pCoords, eCoords)
                local E = IsControlJustReleased(1, Config.Keys['E'])

                -- If close to killed target pick up evidence and head back.
                if (dist <= 5) and E then
                  Wait(2000)
                  StopMission()
                  GPStoBoards()
                  Wait(3000)
                  CenterBottomNotify('Bring the evidence to the nearest handler!', 5000)
                  MissionStatus = true
                  SearchingBodies = false
                end
              end
            end
          end
        end

        if IsPlayerDead() then
          CenterBottomNotify('You have lost your target!', 4000)
          MissionStatus = false
          StopMission()
          TotalKilled = 0
          ArrayTargets = {}
          CreateNPC = {}
        end
      end
    end
  end)

  function StopMission()
    InMission = false
    MissionStatus = false
    ClearGpsMultiRoute()
    SetGpsMultiRouteRender(false)
    for k, v in pairs(CreateNPC) do DeletePed(v) Wait(500) end
    table.remove{CreateNPC} table.remove{ArrayTargets}
  end

  function GPStoBoards ()
    bb2 = Config.HandlerLocations[2]
    StartGpsMultiRoute(6, true, true)
    AddPointToGpsMultiRoute(bb2.x, bb2.y, bb2.z)
    SetGpsMultiRouteRender(true)
    GPStoSDboardactive = true
  end

  AddEventHandler('RootLodge:HitContracts:C:ResetTotalKills', function()
    TotalKilled = 0
  end)