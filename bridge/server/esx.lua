if GetResourceState('es_extended') ~= 'started' then return end

local ESX = exports['es_extended']:getSharedObject()

function SetJob(src, job)
    local Player = ESX.GetPlayerFromId(src)
    Player.setJob(job, 0)
end