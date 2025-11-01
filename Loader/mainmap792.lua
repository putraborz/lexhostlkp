-- LEX HOST VIP - Advanced Roblox Script
-- Generated: 01/11/2025, 10:31:17
-- Website: lexhostvip.com

-- ============================================
-- CONFIGURATION
-- ============================================

-- Fly Configuration
local FLY_ENABLED = true
local FLY_SPEED = 50

-- Speed Configuration
local SPEED_ENABLED = true
local WALK_SPEED = 100
local JUMP_POWER = 100

-- Noclip Configuration
local NOCLIP_ENABLED = true

-- ESP Configuration
local ESP_ENABLED = true
local ESP_SHOW_NAMES = true
local ESP_SHOW_DISTANCE = true

-- Teleport Configuration
local TELEPORT_ENABLED = true
local TELEPORT_LOCATION = "spawn"

-- Weather Configuration
local WEATHER_ENABLED = true
local WEATHER_TYPE = "clear"

-- Remove Parts Configuration
local REMOVE_PARTS_ENABLED = true
local PARTS_TO_REMOVE = {}

-- Infinite Jump Configuration
local INFINITE_JUMP_ENABLED = true

-- Auto Farm Configuration
local AUTO_FARM_ENABLED = true

-- Anti-Ban Configuration
local ANTI_BAN_ENABLED = true

-- ============================================
-- CORE FUNCTIONS
-- ============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Fly Function
local flying = false
local flyConnection

local function startFlying()
    flying = true
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyVelocity.Parent = RootPart

    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.CFrame = RootPart.CFrame
    bodyGyro.Parent = RootPart

    flyConnection = RunService.Heartbeat:Connect(function()
        if flying then
            local direction = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction = direction + Workspace.CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction = direction - Workspace.CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction = direction - Workspace.CurrentCamera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction = direction + Workspace.CurrentCamera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction = direction + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then direction = direction - Vector3.new(0, 1, 0) end
            bodyVelocity.Velocity = direction * FLY_SPEED
            bodyGyro.CFrame = Workspace.CurrentCamera.CFrame
        end
    end)
end

if FLY_ENABLED then
    startFlying()
    print("[LEX HOST VIP] Fly enabled - Speed: " .. FLY_SPEED)
end

-- Speed Function
if SPEED_ENABLED then
    Humanoid.WalkSpeed = WALK_SPEED
    Humanoid.JumpPower = JUMP_POWER
    print("[LEX HOST VIP] Speed enabled - Walk: " .. WALK_SPEED .. " Jump: " .. JUMP_POWER)
end

-- Noclip Function
if NOCLIP_ENABLED then
    RunService.Stepped:Connect(function()
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end)
    print("[LEX HOST VIP] Noclip enabled")
end

-- ESP Function
if ESP_ENABLED then
    local function createESP(player)
        if player.Character and player ~= LocalPlayer then
            local highlight = Instance.new("Highlight")
            highlight.FillColor = Color3.fromRGB(0, 255, 255)
            highlight.OutlineColor = Color3.fromRGB(255, 0, 255)
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
            highlight.Parent = player.Character
            
            if ESP_SHOW_NAMES then
                local billboard = Instance.new("BillboardGui")
                billboard.Adornee = player.Character:WaitForChild("Head")
                billboard.Size = UDim2.new(0, 100, 0, 50)
                billboard.StudsOffset = Vector3.new(0, 3, 0)
                billboard.AlwaysOnTop = true
                
                local nameLabel = Instance.new("TextLabel")
                nameLabel.Text = player.Name
                nameLabel.Size = UDim2.new(1, 0, 1, 0)
                nameLabel.BackgroundTransparency = 1
                nameLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
                nameLabel.TextStrokeTransparency = 0.5
                nameLabel.Parent = billboard
                billboard.Parent = player.Character:WaitForChild("Head")
            end
        end
    end
    
    for _, player in pairs(Players:GetPlayers()) do
        createESP(player)
    end
    Players.PlayerAdded:Connect(createESP)
    print("[LEX HOST VIP] ESP enabled")
end

-- Teleport Function
if TELEPORT_ENABLED then
    local teleportLocations = {
        spawn = Vector3.new(0, 50, 0),
        center = Vector3.new(0, 50, 0),
        shop = Vector3.new(100, 50, 100),
        boss = Vector3.new(-100, 50, -100),
        secret = Vector3.new(200, 100, 200),
        checkpoint = RootPart.Position
    }
    
    if teleportLocations[TELEPORT_LOCATION] then
        RootPart.CFrame = CFrame.new(teleportLocations[TELEPORT_LOCATION])
        print("[LEX HOST VIP] Teleported to: " .. TELEPORT_LOCATION)
    end
end

-- Weather Function
if WEATHER_ENABLED then
    local weatherSettings = {
        clear = {Ambient = Color3.fromRGB(178, 178, 178), OutdoorAmbient = Color3.fromRGB(128, 128, 128)},
        rain = {Ambient = Color3.fromRGB(100, 100, 120), OutdoorAmbient = Color3.fromRGB(80, 80, 100)},
        snow = {Ambient = Color3.fromRGB(200, 200, 230), OutdoorAmbient = Color3.fromRGB(180, 180, 210)},
        fog = {Ambient = Color3.fromRGB(150, 150, 150), OutdoorAmbient = Color3.fromRGB(120, 120, 120), FogEnd = 200},
        thunderstorm = {Ambient = Color3.fromRGB(60, 60, 80), OutdoorAmbient = Color3.fromRGB(40, 40, 60)},
        sandstorm = {Ambient = Color3.fromRGB(200, 180, 140), OutdoorAmbient = Color3.fromRGB(180, 160, 120)}
    }
    
    if weatherSettings[WEATHER_TYPE] then
        for property, value in pairs(weatherSettings[WEATHER_TYPE]) do
            Lighting[property] = value
        end
        print("[LEX HOST VIP] Weather changed to: " .. WEATHER_TYPE)
    end
end

-- Remove Parts Function
if REMOVE_PARTS_ENABLED then
    for _, partName in pairs(PARTS_TO_REMOVE) do
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj.Name == partName and obj:IsA("BasePart") then
                obj:Destroy()
            end
        end
    end
    print("[LEX HOST VIP] Parts removed: " .. table.concat(PARTS_TO_REMOVE, ", "))
end

-- Infinite Jump Function
if INFINITE_JUMP_ENABLED then
    UserInputService.JumpRequest:Connect(function()
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end)
    print("[LEX HOST VIP] Infinite Jump enabled")
end

-- Auto Farm Function
if AUTO_FARM_ENABLED then
    spawn(function()
        while wait(1) do
            -- Auto-collect nearby items
            for _, item in pairs(Workspace:GetChildren()) do
                if item:IsA("Tool") or item:IsA("Model") and item:FindFirstChild("ClickDetector") then
                    local distance = (RootPart.Position - item:GetPivot().Position).Magnitude
                    if distance < 50 then
                        RootPart.CFrame = item:GetPivot()
                        wait(0.5)
                        if item:FindFirstChild("ClickDetector") then
                            fireclickdetector(item.ClickDetector)
                        end
                    end
                end
            end
        end
    end)
    print("[LEX HOST VIP] Auto Farm enabled")
end

-- Anti-Ban Function
if ANTI_BAN_ENABLED then
    -- Hook anti-cheat detection methods
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)
    
    mt.__namecall = newcclosure(function(...)
        local args = {...}
        local method = getnamecallmethod()
        
        if method == "Kick" or method == "FireServer" and tostring(args[1]) == "Ban" then
            return wait(9e9)
        end
        
        return oldNamecall(...)
    end)
    
    setreadonly(mt, true)
    print("[LEX HOST VIP] Anti-Ban protection enabled")
end

-- ============================================
-- SCRIPT LOADED
-- ============================================

print("========================================")
print("    LEX HOST VIP - Script Loaded")
print("    Features Active: 10")
print("    Fly, Speed, Noclip, ESP, Teleport, Weather, Remove Parts, Infinite Jump, Auto Farm, Anti-Ban")
print("    Visit: lexhostvip.com")
print("========================================")
