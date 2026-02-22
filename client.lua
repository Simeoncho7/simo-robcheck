local QBCore = exports['qb-core']:GetCoreObject()

local Robberies = {
    { name = "Store Robbery", requiredCops = 1 },
    { name = "Fleeca Bank",    requiredCops = 3 },
    { name = "Jewelry Store",  requiredCops = 5 },
    { name = "Pacific Bank",   requiredCops = 8 },
}

local PedModel = `a_m_m_og_boss_01` 
local PedCoords = vec4(1185.1, -1337.76, 34.92, 203.22)

local function openRobberyMenu()
    local currentCops = lib.callback.await('robcheck:server:getCops', false)
    local menuOptions = {}

    for _, data in ipairs(Robberies) do
        local hasEnough = currentCops >= data.requiredCops
        
        table.insert(menuOptions, {
            title = data.name,
            description = hasEnough and "Ready to hit." or "Too much heat in the area.",
            icon = hasEnough and "check" or "xmark",
            iconColor = hasEnough and "#2ecc71" or "#e74c3c",
            onSelect = function()
                if hasEnough then
                    lib.notify({ title = 'Intel', description = 'The job is clear.', type = 'success' })
                else
                    lib.notify({ title = 'Intel', description = 'No chance right now.', type = 'error' })
                end
            end
        })
    end

    lib.registerContext({
        id = 'robbery_intel_menu',
        title = 'Street Intel',
        options = menuOptions
    })
    lib.showContext('robbery_intel_menu')
end

CreateThread(function()
    RequestModel(PedModel)
    while not HasModelLoaded(PedModel) do Wait(0) end

    local npc = CreatePed(4, PedModel, PedCoords.x, PedCoords.y, PedCoords.z - 1.0, PedCoords.w, false, false)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)

    exports.ox_target:addLocalEntity(npc, {
        {
            name = 'rob_intel_ped',
            icon = 'fa-solid fa-user-secret',
            label = 'Talk to the Boss',
            onSelect = function()
                openRobberyMenu()
            end
        }
    })
end)