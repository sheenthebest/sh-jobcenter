-- Variables
local config = require 'config'
local isUIOpen = false
local textUIShown = false

-- Functions
local function OpenUI()
    if isUIOpen then return end
    
    isUIOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'SHOW_UI',
        jobs = config.jobs,
        texts = config.texts
    })
    
    if textUIShown then
        lib.hideTextUI()
        textUIShown = false
    end
end

local function CloseUI()
    if not isUIOpen then return end
    
    isUIOpen = false
    SetNuiFocus(false, false)
end

-- NUI Callbacks
RegisterNUICallback('CLOSE_UI', function(data, cb)
    CloseUI()
    cb('ok')
end)

RegisterNUICallback('APPLY_JOB', function(data, cb)
    if not data.name then
        cb('error')
        return
    end

    local result = lib.callback.await('sh-jobcenter:ApplyJob', false, data.name)
    cb('ok')
end)

-- Setup job center points
local function SetupJobCenters()
    for _, pos in ipairs(config.job_centers.locations) do
        local point = lib.points.new({
            coords = pos,
            distance = config.job_centers.radius
        })
        
        function point:onEnter()
            if not isUIOpen then
                lib.showTextUI(config.texts.open, {
                    position = "left-center",
                    icon = 'briefcase'
                })
                textUIShown = true
            end
        end
        
        function point:onExit()
            if textUIShown then
                lib.hideTextUI()
                textUIShown = false
            end
        end
        
        function point:nearby()
            if self.currentDistance < config.job_centers.radius then
                if IsControlJustReleased(0, 38) and not isUIOpen then
                    OpenUI()
                end
            end
        end
    end
end

-- Initialize
CreateThread(function()
    SetupJobCenters()
end)

-- Handler
AddEventHandler('onResourceStop', function(resourceName)
    if cache.resource ~= resourceName then return end
    if textUIShown then lib.hideTextUI() end
    if isUIOpen then CloseUI() end
end)