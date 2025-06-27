local QBCore = exports['qb-core']:GetCoreObject()

if Config.UseQBCORECreateUsableItem then
    QBCore.Functions.CreateUseableItem('turtlewax', function(source, item)
        TriggerClientEvent('alpha-turtlewax:client:useTurtleWax', source)
    end)
end
