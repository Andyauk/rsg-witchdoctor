local RSGCore = exports['rsg-core']:GetCoreObject()

-- Prompt
Citizen.CreateThread(
    function()
        for k, v in pairs(Config.ReviveLocations) do
            exports['rsg-core']:createPrompt(
                v.Type,
                v.coords,
                Config.ReviveKey,
                'Get Help From The Witch Doctor ' .. v.name,
                {
                    type = 'server',
                    event = 'rsg-witchdoctor:server:checkmoney',
                    args = {}
                }
            )
            if v.showblip == true then
                local BlipPackage = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
                SetBlipSprite(BlipPackage, -924021303, 1)
                SetBlipScale(BlipPackage, 0.2)
                Citizen.InvokeNative(0x9CB1A1623062F402, BlipPackage, v.name)
            end
        end
    end
)

--Events
RegisterNetEvent('rsg-witchdoctor:client:startrevive')
AddEventHandler(
    'rsg-witchdoctor:client:startrevive',
    function()
        local revivetime = Config.WaitTime * 1000
        RSGCore.Functions.Progressbar(
            'search_register',
            'Getting Help',
            revivetime,
            false,
            true,
            {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true
            },
            {
                animDict = 'script_common@dead@male',
                anim = 'faceup_01',
                flags = 1
            },
            {},
            {},
            function()
                -- Done
                ClearPedTasks(PlayerPedId())
                TriggerEvent('rsg-medic:client:adminRevive')
                lib.notify({ title = 'Preparing', description = 'All better?', type = 'inform', duration = 5000 })
            end,
            function()
                ClearPedTasks(PlayerPedId())
            end
        )
    end
)

--Not enough cash notify
RegisterNetEvent('rsg-witchdoctor:client:notenoughmoney')
AddEventHandler(
    'rsg-witchdoctor:client:notenoughmoney',
    function()
        lib.notify({ title = 'Not Enough Cash', description = 'This practice is not free', type = 'Error', duration = 5000 })
    end
)
