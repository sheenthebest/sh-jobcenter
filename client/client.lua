-- variables
local config = require 'config'

-- functions --
local function Draw3DText(x, y, z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = #(vec3(px,py,pz) - vec3(x,y,z))

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    
	if onScreen then
		SetTextScale(0.4, 0.4)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextDropShadow(0, 0, 0, 55)
		SetTextEdge(0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextCentre(1)
        SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end

-- main functions --
local function OpenUI()
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'SHOW_UI' })
end

-- NUI Callbacks --
RegisterNUICallback('CLOSE_UI', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('APPLY_JOB', function(data)
    if not data.name then return end

    local result = lib.callback.await('sh-jobcenter:ApplyJob', false, data.name)
end)

-- setup points --
local radius = config.job_centers.radius
local draw_distance = config.job_centers.draw_distance
for _, pos in each(config.job_centers.locations) do
    local point = lib.points.new({
        coords = pos,
        distance = draw_distance
    })
    
    function point:nearby()
        Draw3DText(self.coords.x, self.coords.y, self.coords.z, config.texts.open)

        if self.currentDistance < radius and IsControlJustReleased(0, 38) then
            OpenUI()
        end
    end
end
