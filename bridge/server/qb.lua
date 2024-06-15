if GetResourceState('qb-core') ~= 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()

function SetJob(src, job)
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.SetJob(job, 0)
end