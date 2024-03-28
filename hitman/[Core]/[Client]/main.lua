--------------------------------------------------------------------------------
----------------------------------- RootLodge -----------------------------------
--------------------------------------------------------------------------------
local VORPcore = {}
TriggerEvent("getCore", function(core) VORPcore = core end)
function Wait(args) Citizen.Wait(args) end

local VORPutils = {}
TriggerEvent("getUtils", function(utils)
    VORPutils = utils
end)

--------------------------------------------------------------------------------
-- Varables
local InRange = false
local Location = nil
MissionStatus = false
local NPCHandlerConfig = Config.HandlerLocations
local rawbliparray = {}

-- Net Event Register
RegisterNetEvent('RootLodge:HitContracts:C:StartMission')
RegisterNetEvent('RootLodge:HitContracts:C:ShowPrompt')
--------------------------------------------------------------------------------
-- Core
--------------------------------------------------------------------------------

Citizen.CreateThread(function()
  for _, board in ipairs(Config.HandlerLocations) do
      local blipName = board.City
      local blipHash = GetHashKey("blip_summer_guard") -- Replace with your blip style
      local blip = VORPutils.Blips:SetBlip(blipName, 'blip_summer_guard', 0.2, board.x, board.y, board.z, vector3 or nil)
      local rawblip = blip:GetBlip()
      table.insert(rawbliparray, rawblip)
  end
end)

-- Check player disctance from coords.
Citizen.CreateThread(function()
  while true do Wait(2000)
    local playerped = PlayerPedId()
    local coords = GetEntityCoords(playerped)
    for k, npc in pairs(NPCHandlerConfig) do

      local dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, npc.x, npc.y, npc.z)

      if Location == nil and (dist <= 5) then Location = npc.City end
      if Location == npc.City then

        -- Set user if out of range
        if (dist > 5) and InRange then
          InRange = false
          Location = nil
          Wait(1000)
        end

        -- Set user if in range
        if (dist <= 5) and not InRange then
          InRange = true
          Location = npc.City
          TriggerEvent('RootLodge:HitContracts:C:StartMission')
          CenterBottomNotify('Proceed with caution', 5000)
        end
      end
    end
  end
end)


AddEventHandler('RootLodge:HitContracts:C:StartMission', function()
  local playerped = PlayerPedId()
  while InRange do 
      Wait(1) -- It's critical to have a short wait to prevent freezing.
      local coords = GetEntityCoords(playerped)
      --devdebug(MissionStatus)

      for _, v in pairs(Config.HandlerLocations) do
          local dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.x, v.y, v.z)

          if dist <= 4 then
              -- Checks if within 4 meters of the location.
              if MissionStatus then
                  DrawInfo('Press [ ~e~K~q~ ] to get paid', 0.5, 0.95, 0.75)
              else
                  DrawInfo('Press [ ~e~G~q~ ] to start a contract', 0.5, 0.95, 0.75)
              end
              
              -- Initiating the contract.
              if IsControlJustPressed(0, Config.Keys['G']) then
                  Location = nil
                  TriggerServerEvent('RootLodge:HitContracts:S:CheckCharacter')
                  simpleTopNotification('Contract Initiated', 'Proceed to targets urgently', 10000)
                  Wait(2000)
                  break -- Exit the loop to avoid multiple triggers.
              end

              -- Getting paid.
              if IsControlJustPressed(0, Config.Keys['K']) then
                --devdebug(MissionStatus)
                  if TotalKilled > 0 then
                      TriggerServerEvent('RootLodge:HitContracts:S:PayDay', TotalKilled)
                      TotalKilled = 0
                      Location = nil
                      SetGpsMultiRouteRender(false)
                      MissionStatus = false
                      CenterBottomNotify("You've been paid for your hard work, partner!", 5000)
                      Wait(2000)
                      break -- Exit the loop to avoid multiple triggers.
                  else
                      CenterBottomNotify("You've no recorded target excursions, partner!", 5000)
                  end
              end
          end
      end
  end
end)

local iamalwaystrue = true
-- Assuming npcSpawned is a table defined somewhere globally to track spawned NPCs
npcSpawned = {}

-- Main function to handle NPC spawning
function HandleNPCSpawning()
  for k, v in pairs(Config.HandlerLocations) do
    --devdebug(k .. " : " .. v)
    --devdebug(v.City, v.model, v.x, v.y, v.z, v.h, v.scenario)
    local ped = VORPutils.Peds:Create(v.model, v.x, v.y, v.z, v.h, 'world', false)
    local rawped = ped:GetPed()
    ped:CanBeDamaged(false)
    ped:CanBeMounted(false)
    Wait(500)
    ped:Invincible(true)
    Citizen.InvokeNative(0x283978A15512B2FE, rawped, true) -- SetRandomOutfitVariation
    Wait(200)
    SetEntityVisible(rawped, true)
    ped:ClearTasks()
    TaskStartScenarioAtPosition(rawped, v.scenario, v.x, v.y, v.z, v.h, -1, false)
    ped:Freeze(true)
    local cityName = v.City
    -- Initialize the table for the city if it does not exist
    table.insert(npcSpawned, rawped)
  end
end


AddEventHandler("RootLodge:HitContracts:C:ShowPrompt", function(msg)
  SetTextScale(0.5, 0.5)
  local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", msg, Citizen.ResultAsLong())
  Citizen.InvokeNative(0xFA233F8FE190514C, str)
  Citizen.InvokeNative(0xE9990552DEC71600)
end)

HandleNPCSpawning()

-- On reload of resource [DO NOT TOUCH]
AddEventHandler("onResourceStop", function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
      return
  end

  --for _, ped in ipairs(peds) do
    --ped:Remove()
  --end

  -- remove blips
  --for _, board in ipairs(rawbliparray) do
      --local blipName = board.City
      --RemoveBlip(blipName)
  --end

  -- Function to delete all spawned NPCs
  function DeleteSpawnedNPCs()
    for _, npc in ipairs(npcSpawned) do
        if DoesEntityExist(npc) then
            devdebug("Deleting NPC: " .. npc)         
            DeleteEntity(npc)
        end
    end
    -- Empty the npcSpawned table
    npcSpawned = {}
  end

  DeleteSpawnedNPCs()

  TotalEnemies = 0
  TotalKilled = 0
  SearchingBodies = false
  MissionStatus = false
  InMission = false
  Location = nil
  InRange = false

end)


function Beta()
  Notify('This feature is currently being build!')
  Notify('and will be released in a later version.')
end