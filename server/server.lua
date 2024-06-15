lib.callback.register('sh-jobcenter:ApplyJob', function(source, job)
    local src = source

    -- you can write some security check here

    SetJob(src, job)
    return true
end)