--[[
              [Client-Sided] — Product

Forces fullscreen by repeatedly toggling it, modifies UI behavior,
and restricts user interaction (mouse, camera, GUI elements).

This may cause screen flickering, UI glitches, or temporary lag
depending on the client performance.

If issues occur, close end Roblox task via Task Manager.

]]

--// [SERVICES]

if not cloneref then return print('[Noryn] — Security Issue!') end
local UserInputService = cloneref(game:GetService('UserInputService'))
local RunService = cloneref(game:GetService('RunService'))
local GuiService = cloneref(game:GetService('GuiService'))
local CoreGui = cloneref(game:GetService('CoreGui'))
local Players = cloneref(game:GetService('Players'))
local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId

--// [ORIGIN]

local PC = UserInputService.KeyboardEnabled and UserInputService.MouseEnabled
local Date = DateTime.now():FormatLocalTime('M/D/YYYY', 'en-us')
local Roblox_Gui = CoreGui:FindFirstChild('RobloxGui')

--// [MAIN]

if not PC then return print(`[Not Supported] ({PC})`) end
local function Take_Down()
    local Success, err = pcall(function()
        GuiService:ToggleFullscreen()
    end)
    if not Success then
        print(`Found: {err}`)
    end
end

if Roblox_Gui then
    local Shield = Roblox_Gui:FindFirstChild('SettingsClippingShield')
    if not Shield then return end
    Shield:Destroy()
else
    LocalPlayer:Kick('#DLNS')
end

pcall(function()
    RunService.Heartbeat:Connect(function()
        for i = 1, 100 do 
            UserInputService.MouseIconEnabled = false
            LocalPlayer.CameraMaxZoomDistance = 0
            if GuiService then --[[
                                 --// [You can remove this part (if GuiService then), 
                                      or add "if not UserSettings().GameSettings:InFullScreen() then"
                                 ]]
                Take_Down()
            end
        end
    end)
end)

--// [CREDITS]

print(string.format([[%s | %s

███╗░░██╗░█████╗░██████╗░██╗░░░██╗███╗░░██╗
████╗░██║██╔══██╗██╔══██╗╚██╗░██╔╝████╗░██║
██╔██╗██║██║░░██║██████╔╝░╚████╔╝░██╔██╗██║
██║╚████║██║░░██║██╔══██╗░░╚██╔╝░░██║╚████║
██║░╚███║╚█████╔╝██║░░██║░░░██║░░░██║░╚███║
╚═╝░░╚══╝░╚════╝░╚═╝░░╚═╝░░░╚═╝░░╚══╝░░░░░
]], PlaceId, Date))
warn('© dsc.gg/getnoryn')
