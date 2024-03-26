--------------------------------------------------------------------------------
----------------------------------- RootLodge -----------------------------------
--------------------------------------------------------------------------------
local VORPcore = {}
TriggerEvent("getCore", function(core) VORPcore = core end)
function Wait(args) Citizen.Wait(args) end
--------------------------------------------------------------------------------
-- Varables
local InRange = false
local Location = nil

RegisterNetEvent('RootLodge:HitContracts:C:StartMission')
--------------------------------------------------------------------------------
-- Core
--------------------------------------------------------------------------------

function addBlipForCoords(blipname,bliphash,coords)
	local blip = Citizen.InvokeNative(0x554D9D53F696D002,1664425300, coords[1], coords[2], coords[3])
	SetBlipSprite(blip,bliphash,true)
	SetBlipScale(blip,0.2)
	Citizen.InvokeNative(0x9CB1A1623062F402, blip, blipname)
end


Citizen.CreateThread(function()
  for _, board in ipairs(Config.HandlerLocations) do
      local blipName = board.City
      local blipHash = GetHashKey("blip_summer_guard") -- Replace with your blip style
      addBlipForCoords(blipName, blipHash, {board.x, board.y, board.z})
  end
end)

-- Check player distance from coords.
Citizen.CreateThread(function()
  while true do 
    Wait(2000) -- Efficient loop with delay to reduce CPU usage
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local foundLocation = false -- Flag to track if we're in range of any location

    for k, v in pairs(Config.HandlerLocations) do
      local dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.x, v.y, v.z)

      if dist <= 5 then
        foundLocation = true -- We found a location within 5 meters
        if Location ~= v.City then
          Location = v.City -- Update Location to the current city if within range
          InRange = true
          TriggerEvent('RootLodge:HitContracts:C:StartMission')
        end
        Wait(200) -- Delay to reduce CPU usage
        break -- Exit the loop since we've processed the relevant location
      end
    end

    -- If we didn't find a location within range, reset Location and InRange
    if not foundLocation and (Location ~= nil or InRange) then
      Location = nil
      InRange = false
      -- No need to wait here since we're already at the end of the loop
    end
  end
end)

AddEventHandler('RootLodge:HitContracts:C:StartMission', function()
  local ped = PlayerPedId()
  while InRange do Wait(1)
    local coords = GetEntityCoords(ped)
    for k, v in pairs(Config.HandlerLocations) do
      local x, y, z = v.x, v.y, v.z
      local dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, x, y, z)
      
      if (dist <= 4) then
        if dist <= 4 then
        if IsControlJustPressed(0, Config.Keys['G']) then
          Location = nil
          TriggerServerEvent('RootLodge:HitContracts:S:CheckCharacter')
          simpleTopNotification('Contract Initiated', 'Proceed to targets urgently', 8000)
        end
      end

      if (dist <= 4) and IsControlJustPressed(0, Config.Keys['K']) then
        payment = true
        if payment and (TotalKilled > 0) then
          TriggerServerEvent('RootLodge:HitContracts:S:PayDay', TotalKilled)
          TotalKilled = 0
          SetGpsMultiRouteRender(false)
          Location = nil
          CenterBottomNotify("You've been paid for your hard work, partner!", 5000)
        elseif payment and (TotalKilled == 0) then
          Location = nil
          CenterBottomNotify("You've no recorded target excursions, partner!", 5000)
        end
      end
    end
  end
end)

local iamalwaystrue = true
local npcSpawned = {} -- Table to track spawned NPCs for each city

-- Function to spawn NPC for a given city
function SpawnNPC(cityName, npcName, locx, locy, locz, locw, scenarioTEXT)
    local pedHash = GetHashKey(npcName)
    RequestModel(pedHash)
    while not HasModelLoaded(pedHash) do
        Wait(100)
    end
    local spawnrec = CreatePed(pedHash, locx, locy, locz, locw, false, true, true, true)
    Wait(1000)
    Citizen.InvokeNative(0x283978A15512B2FE, spawnrec, true) -- SetRandomOutfitVariation
    Wait(100)
    --SetEntityNoCollisionEntity(PlayerPedId(), spawnrec, false)
    SetEntityCanBeDamaged(spawnrec, false)
    SetEntityInvincible(spawnrec, true)
    Wait(1000)
    FreezeEntityPosition(spawnrec, true)
    SetBlockingOfNonTemporaryEvents(spawnrec, true)
    SetEntityVisible(spawnrec, true)
    TaskStartScenarioAtPosition(spawnrec, scenarioTEXT, locx, locy, locz, locw, -1, 0, 1)
    npcSpawned[cityName] = true -- Mark NPC as spawned for this city
    Wait(500)
end

-- Main function to handle NPC spawning
function HandleNPCSpawning()
    for k, v in pairs(Config.HandlerLocations) do
        local locx, locy, locz = v.x, v.y, v.z

        local cityName = v.City
        if not npcSpawned[cityName] then
            for cityname, npcData in pairs(Config.HandlerNPC) do
                if cityname == cityName then
                    local locw = npcData.Heading or 0.0
                    local scenarioTEXT = npcData.Scenarios or 'WORLD_HUMAN_SHOPKEEPER'
                    Wait(200)
                    SpawnNPC(cityName, npcData.NPC, locx, locy, locz, locw, scenarioTEXT)
                    Wait(1000)
                    break -- Exit loop once NPC is spawned for this city
                end
            end
        end
    end
end

-- Trigger NPC spawning
Citizen.CreateThread(function()
    while true do
        Wait(200)
        HandleNPCSpawning()
    end
end)

function Beta()
  Notify('This feature is currently being build!')
  Notify('and will be released in a later version.')
end