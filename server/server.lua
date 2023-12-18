local RSGCore = exports['rsg-core']:GetCoreObject()

-----------------------------------------------------------------------
-- version checker
-----------------------------------------------------------------------
local function versionCheckPrint(_type, log)
    local color = _type == 'success' and '^2' or '^1'

    print(('^5[' .. GetCurrentResourceName() .. ']%s %s^7'):format(color, log))
end

local function CheckVersion()
    PerformHttpRequest(
        --'https://raw.githubusercontent.com/Rexshack-RedM/rsg-witchdoctor/main/version.txt',
        'https://raw.githubusercontent.com/Andyauk/rsg-witchdoctor/main/version.txt', --temp update in
        function(err, text, headers)
            local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')

            if not text then
                versionCheckPrint('error', 'Currently unable to run a version check.')
                return
            end

            --versionCheckPrint('success', ('Current Version: %s'):format(currentVersion))
            --versionCheckPrint('success', ('Latest Version: %s'):format(text))

            if text == currentVersion then
                versionCheckPrint('success', 'You are running the latest version.')
            else
                versionCheckPrint(
                    'error',
                    ('You are currently running an outdated version, please update to version %s'):format(text)
                )
            end
        end
    )
end

-----------------------------------------------------------------------

--Money Check
RegisterNetEvent('rsg-witchdoctor:server:checkmoney')
AddEventHandler(
    'rsg-witchdoctor:server:checkmoney',
    function()
        local src = source
        local Player = RSGCore.Functions.GetPlayer(src)
        local cashBalance = Player.PlayerData.money['cash']
        local ReviveAmount = Config.ReviveAmount

        if cashBalance >= ReviveAmount then
            Player.Functions.RemoveMoney('cash', ReviveAmount)
            TriggerClientEvent('rsg-witchdoctor:client:startrevive', Player.PlayerData.source)
        else
            TriggerClientEvent('rsg-witchdoctor:client:notenoughmoney', Player.PlayerData.source)
        end
    end
)

--------------------------------------------------------------------------------------------------
-- start version check
--------------------------------------------------------------------------------------------------
CheckVersion()
