local QBCore = exports['qb-core']:GetCoreObject()

lib.callback.register('robcheck:server:getCops', function(source)
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    
    for _, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    
    return amount
end)