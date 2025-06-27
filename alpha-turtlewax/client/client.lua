local waxedVehicles = {}

if Config.DevCommand then
    RegisterCommand(Config.DirtyVehicleCommand, function()
        local coords = GetEntityCoords(cache.ped)
        local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, Config.DistanceCloseToVehicle, 0, 71)
        SetVehicleDirtLevel(vehicle, 15.0)
    end)
end

local function Notify(msg, type)
    if Config.Notify == "ox_lib" then
        lib.notify({ type = type, description = msg })
    elseif Config.Notify == "qbcore" then
        local QBCore = exports['qb-core']:GetCoreObject()
        QBCore.Functions.Notify(msg, type, 5000)
    end
end

RegisterNetEvent('alpha-turtlewax:client:useTurtleWax', function()
    local coords = GetEntityCoords(cache.ped)
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, Config.DistanceCloseToVehicle, 0, 71)

    if vehicle == 0 or not DoesEntityExist(vehicle) then
        Notify('No vehicle nearby!', 'error')
        return
    end

    local progressOpts = {
        duration = 5000,
        label = 'Applying Turtle Wax...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
        },
        anim = {
            dict = 'amb@world_human_maid_clean@',
            clip = 'base',
            flags = 1,
        },
        prop = {
            model = 'prop_sponge_01',
            bone = 28422,
            pos = vec3(0.0, 0.0, -0.01),
            rot = vec3(90.0, 0.0, 0.0),
        }
    }

    local success
    if Config.Progress == "ox-circle" then
        success = lib.progressCircle(progressOpts)
    elseif Config.Progress == "ox-bar" then
        success = lib.progressBar(progressOpts)
    end

    if success then
        Notify('Vehicle waxed! Protected from dirt for 30 mins.', 'success')

        local vehNet = VehToNet(vehicle)
        waxedVehicles[vehNet] = true

        CreateThread(function()
            local minutes = Config.TimeInMinutesWaxLasts
            for m = 1, minutes do
                for s = 59, 0, -1 do
                    if NetworkDoesNetworkIdExist(vehNet) then
                        local veh = NetToVeh(vehNet)
                        if DoesEntityExist(veh) then
                            SetVehicleDirtLevel(veh, 0.0)
                        end
                    end
                    if Config.DebugPrint then
                        print(('[Alpha Turtle Wax Debug] Time remaining: %02d:%02d (MM:SS)'):format(minutes - m, s))
                    end
                    Wait(1000)
                end
            end

            waxedVehicles[vehNet] = nil
            Notify('Wax has worn off. Your car can get dirty again.', 'info')

            if Config.DebugPrint then
                print('[TURTLEWAX DEBUG] Wax effect expired. Vehicle can now get dirty again.')
            end
        end)
    end
end)