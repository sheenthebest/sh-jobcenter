if GetResourceState('ND_Core') ~= 'started' then return end

function SetJob(src, job)
    local Player = exports.ND_Core:getPlayer(src)
    Player.setJob(job, 0)
end