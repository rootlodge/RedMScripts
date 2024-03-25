local config = {
    pedFrequency = 32.0, -- Controls the amount of random peds walking/standing around (0.0 = None | 0.5 = Half as Many | 1.0 = Normal | 2.0 = Twice as Many)
    trafficFrequency = 32.0, -- Controls the amount of vehicles driving around and also controls the amount of parked vehicles (0.0 = None | 0.5 = Half as Many| 1.0 = Normal | 2.0 = Twice as Many)
    animalFrequency = 16.0, -- Controls the amount of animals walking/standing around (0.0 = None | 0.5 = Half as Many | 1.0 = Normal | 2.0 = Twice as Many)
}

-- Please do not edit below this line! --

print(GetCurrentResourceName() .. " by RootLodge Github loaded successfully.")
print(GetPedDensityMultiplier())

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        -- Ped Density
        SetAmbientHumanDensityMultiplierThisFrame(config.pedFrequency)
        SetAmbientPedDensityMultiplierThisFrame(config.pedFrequency)
        SetScenarioPedDensityMultiplierThisFrame(config.pedFrequency)
        SetScenarioHumanDensityMultiplierThisFrame(config.pedFrequency)
        SetScenarioPedDensityMultiplierThisFrame(config.pedFrequency) 
		-- Vehicle Density
        SetRandomVehicleDensityMultiplierThisFrame(config.trafficFrequency)
        SetParkedVehicleDensityMultiplierThisFrame(config.trafficFrequency)
        SetVehicleDensityMultiplierThisFrame(config.trafficFrequency)
        -- Animal Density
        SetAmbientAnimalDensityMultiplierThisFrame(config.animalFrequency)
        SetScenarioAnimalDensityThisFrame(config.animalFrequency)
    end 
end)