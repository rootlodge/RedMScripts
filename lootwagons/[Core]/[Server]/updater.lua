function Wait(args) Citizen.Wait(args) end
if Config.CheckForUpdates then
    local function VersionLog(_type, log)
        local color = _type == 'success' and '^2' or '^1'
        print(('^8[Loot Wagons]%s %s^7'):format(color, log))
    end

    local function CheckMenuVersion()
        PerformHttpRequest('https://raw.githubusercontent.com/rootlodge/RedMScripts/master/lootwagons.txt', function(err, text, headers)
            local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')
            if not text then
                VersionLog('error', 'Currently unable to run a version check.')
                return
            end
            VersionLog('success', ('Current Version: %s'):format(currentVersion))
            VersionLog('success', ('Latest Version: %s'):format(text))
            if text:gsub("%s+", "") == currentVersion:gsub("%s+", "") then
                VersionLog('success', 'You are running the latest version of Loot Wagons!')
            else
                VersionLog('error', ('You are currently running an outdated version of Loot Wagons, please update to version %s'):format(text))
            end
        end)
    end

    Wait(45000)
    CheckMenuVersion()
end