local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local qitkot = library.new("QitKot - Discord.gg/Scripts", 5013109572)

local LP = game.Players.LocalPlayer
-- themes
local themes = {
	Background = Color3.fromRGB(24, 24, 24),
	Glow = Color3.fromRGB(0, 0, 0),
	Accent = Color3.fromRGB(10, 10, 10),
	LightContrast = Color3.fromRGB(20, 20, 20),
	DarkContrast = Color3.fromRGB(14, 14, 14),  
	TextColor = Color3.fromRGB(255, 255, 255)
}

local p_1 = qitkot:addPage("Main", 5012544693)
local s_1 = p_1:addSection("Main")
local s_2 = p_1:addSection("Player")

s_1:addButton(
    "Redeem All Hidden Codes (around map)",
    function()
        
local Codes = {
    "AnotherBlock",
    "PlantWalls",
    "BoostOnSign",
    "TreasureBoost",
    "GrassWall",
    "AnotherBoost",
    "BtrBoost"
}

local RedeemEvent = game:GetService("ReplicatedStorage").Events.CodeRedem
  for _, event in pairs(Codes) do
      wait(0.3)
      RedeemEvent:InvokeServer(event)
    end   
end)


s_1:addButton(
    "Redeem Daily Star Boost",
    function()
    
    local StarBoostEvent = game:GetService("ReplicatedStorage").Events.ClaimFreeBoostStar
    wait(0.3)
        StarBoostEvent:FireServer()    
end)


local walkspeed = 16
LP.Character.Humanoid.Died:connect(function()
    LP.CharacterAdded:connect(function()
        repeat wait() until LP.Character:FindFirstChild("Humanoid")
        LP.Character.Humanoid.WalkSpeed = walkspeed
    end)
end)

s_1:addButton(
"Remove Level Barriers", 
function()

    for i,v in pairs(game.Workspace:GetChildren()) do
        for i,v in pairs(v:GetChildren()) do
            if v:FindFirstChildOfClass("TouchTransmitter") and v:FindFirstChildOfClass("SurfaceGui") then
                v:Destroy()
            end
        end
    end
end)

s_2:addSlider(
    "WalkSpeed",
    16,
    16,
    125,
    function(v)
        walkspeed = v
        LP.Character.Humanoid.WalkSpeed = walkspeed
end)

s_2:addButton(
    "Fly (X)",
    function()
        local plr = game.Players.LocalPlayer
    local mouse = plr:GetMouse()

    localplayer = plr

    if workspace:FindFirstChild("Core") then
        workspace.Core:Destroy()
    end

    local Core = Instance.new("Part")
    Core.Name = "Core"
    Core.Size = Vector3.new(0.05, 0.05, 0.05)

    spawn(function()
        Core.Parent = workspace
        local Weld = Instance.new("Weld", Core)
        Weld.Part0 = Core
        Weld.Part1 = localplayer.Character.LowerTorso
        Weld.C0 = CFrame.new(0, 0, 0)
    end)

    workspace:WaitForChild("Core")

    local torso = workspace.Core
    flying = true
    local speed=7.5
    local keys={a=false,d=false,w=false,s=false}
    local e1
    local e2
    local function start()
        local pos = Instance.new("BodyPosition",torso)
        local gyro = Instance.new("BodyGyro",torso)
        pos.Name="EPIXPOS"
        pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
        pos.position = torso.Position
        gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        gyro.cframe = torso.CFrame
        repeat
            wait()
            localplayer.Character.Humanoid.PlatformStand=true
            local new=gyro.cframe - gyro.cframe.p + pos.position
            if not keys.w and not keys.s and not keys.a and not keys.d then
                speed=7.5
            end
            if keys.w then
                new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                speed=speed+0
            end
            if keys.s then
                new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                speed=speed+0
            end
            if keys.d then
                new = new * CFrame.new(speed,0,0)
                speed=speed+0
            end
            if keys.a then
                new = new * CFrame.new(-speed,0,0)
                speed=speed+0
            end
            if speed>3.2 then
                speed=7.5
            end
            pos.position=new.p
            if keys.w then
                gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
            elseif keys.s then
                gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
            else
                gyro.cframe = workspace.CurrentCamera.CoordinateFrame
            end
        until flying == false
        if gyro then gyro:Destroy() end
        if pos then pos:Destroy() end
        flying=false
        localplayer.Character.Humanoid.PlatformStand=false
        speed=7.5
    end
    e1=mouse.KeyDown:connect(function(key)
        if not torso or not torso.Parent then flying=false e1:disconnect() e2:disconnect() return end
        if key=="w" then
            keys.w=true
        elseif key=="s" then
            keys.s=true
        elseif key=="a" then
            keys.a=true
        elseif key=="d" then
            keys.d=true
        elseif key=="x" then
            if flying==true then
                flying=false
            else
                flying=true
                start()
            end
        end
    end)
    e2=mouse.KeyUp:connect(function(key)
        if key=="w" then
            keys.w=false
        elseif key=="s" then
            keys.s=false
        elseif key=="a" then
            keys.a=false
        elseif key=="d" then
            keys.d=false
        end
    end)
    start()
end)

s_2:addButton(
    "Headless (Client Sided)",
    function()
        game.Players.LocalPlayer.Character.Head.Transparency = 1
        game.Players.LocalPlayer.Character.Head.Transparency = 1
        for i,v in pairs(game.Players.LocalPlayer.Character.Head:GetChildren()) do
        if (v:IsA("Decal")) then
        v.Transparency = 1
       end
    end
end)

s_2:addButton(
    "Korblox (Client Sided)",
    function()
     local chr = LP.Character
     chr.RightLowerLeg.MeshId = "902942093"
     chr.RightLowerLeg.Transparency = "1"
     chr.RightUpperLeg.MeshId = "http://www.roblox.com/asset/?id=902942096"
     chr.RightUpperLeg.TextureID = "http://roblox.com/asset/?id=902843398"
     chr.RightFoot.MeshId = "902942089"
     chr.RightFoot.Transparency = "1"
end)

--// PAGE 2

local p_2 = qitkot:addPage("Others", 5012544693)
local s_3 = p_2:addSection("Comming Soon 😉")

--// PAGE 3

local p_3 = qitkot:addPage("Settings", 5012544693)
local s_4 = p_3:addSection("Settings/Themes")

s_4:addKeybind("Toggle Keybind", Enum.KeyCode.V, function()
	qitkot:toggle()
end)

for theme, color in pairs(themes) do -- all in one theme changer, i know, im cool
	s_4:addColorPicker(theme, color, function(color3)
		qitkot:setTheme(theme, color3)
	end)
end

-- load
qitkot:SelectPage(venyx.pages[1], true)
