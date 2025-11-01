-- LEX HOST VIP - Advanced Script Generator
-- Generated: 01/11/2025, 10:55:00
-- ⚠️ USE AT YOUR OWN RISK ⚠️

local LexHost = {}
LexHost.Version = "2.5.0"
LexHost.Enabled = {}

-- Get Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

print("[LEX HOST VIP] Script loaded successfully!")


-- FLY MODE
LexHost.Enabled.Fly = false
LexHost.FlySpeed = 45

local function toggleFly()
    LexHost.Enabled.Fly = not LexHost.Enabled.Fly
    if LexHost.Enabled.Fly then
        print("[LEX HOST] Fly: ENABLED")
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = RootPart
        bodyVelocity.Name = "LexFly"
        
        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.P = 9e9
        bodyGyro.Parent = RootPart
        bodyGyro.Name = "LexGyro"
        
        RunService.Heartbeat:Connect(function()
            if not LexHost.Enabled.Fly then return end
            local cam = Workspace.CurrentCamera
            local moveDirection = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveDirection = moveDirection + cam.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection - cam.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveDirection = moveDirection - cam.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + cam.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveDirection = moveDirection + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                moveDirection = moveDirection - Vector3.new(0, 1, 0)
            end
            
            if RootPart:FindFirstChild("LexFly") then
                RootPart.LexFly.Velocity = moveDirection.Unit * LexHost.FlySpeed
            end
            if RootPart:FindFirstChild("LexGyro") then
                RootPart.LexGyro.CFrame = cam.CFrame
            end
        end)
    else
        print("[LEX HOST] Fly: DISABLED")
        if RootPart:FindFirstChild("LexFly") then
            RootPart.LexFly:Destroy()
        end
        if RootPart:FindFirstChild("LexGyro") then
            RootPart.LexGyro:Destroy()
        end
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.X then
        toggleFly()
    end
end)

-- SPEED HACK
LexHost.Enabled.Speed = false
LexHost.SpeedMultiplier = 2
LexHost.OriginalSpeed = Humanoid.WalkSpeed

local function toggleSpeed()
    LexHost.Enabled.Speed = not LexHost.Enabled.Speed
    if LexHost.Enabled.Speed then
        print("[LEX HOST] Speed: ENABLED (" .. LexHost.SpeedMultiplier .. "x)")
        Humanoid.WalkSpeed = LexHost.OriginalSpeed * LexHost.SpeedMultiplier
    else
        print("[LEX HOST] Speed: DISABLED")
        Humanoid.WalkSpeed = LexHost.OriginalSpeed
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.C then
        toggleSpeed()
    end
end)

-- NOCLIP
LexHost.Enabled.Noclip = false

local function toggleNoclip()
    LexHost.Enabled.Noclip = not LexHost.Enabled.Noclip
    if LexHost.Enabled.Noclip then
        print("[LEX HOST] Noclip: ENABLED")
    else
        print("[LEX HOST] Noclip: DISABLED")
    end
end

RunService.Stepped:Connect(function()
    if LexHost.Enabled.Noclip then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.N then
        toggleNoclip()
    end
end)

-- CLICK TELEPORT
local Mouse = LocalPlayer:GetMouse()

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Q then
        if Mouse.Target then
            RootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0))
            print("[LEX HOST] Teleported to mouse position")
        end
    end
end)

-- ESP (Wallhack)
local function createESP(player)
    if player == LocalPlayer then return end
    
    local function addESPToCharacter(character)
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)
        if not humanoidRootPart then return end
        
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "LexESP"
        billboard.AlwaysOnTop = true
        billboard.Size = UDim2.new(0, 100, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.Parent = humanoidRootPart
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundTransparency = 1
        frame.Parent = billboard
        
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
        nameLabel.TextStrokeTransparency = 0.5
        nameLabel.Text = player.Name
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextScaled = true
        nameLabel.Parent = frame
        
        
        local distanceLabel = Instance.new("TextLabel")
        distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
        distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
        distanceLabel.BackgroundTransparency = 1
        distanceLabel.TextColor3 = Color3.fromRGB(0, 255, 204)
        distanceLabel.TextStrokeTransparency = 0.5
        distanceLabel.Font = Enum.Font.Gotham
        distanceLabel.TextScaled = true
        distanceLabel.Parent = frame
        
        RunService.Heartbeat:Connect(function()
            if humanoidRootPart and RootPart then
                local distance = (humanoidRootPart.Position - RootPart.Position).Magnitude
                distanceLabel.Text = math.floor(distance) .. "m"
            end
        end)
        
        -- Highlight
        local highlight = Instance.new("Highlight")
        highlight.Name = "LexHighlight"
        highlight.FillColor = Color3.fromRGB(138, 44, 226)
        highlight.OutlineColor = Color3.fromRGB(0, 255, 204)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Parent = character
    end
    
    if player.Character then
        addESPToCharacter(player.Character)
    end
    player.CharacterAdded:Connect(addESPToCharacter)
end

for _, player in pairs(Players:GetPlayers()) do
    createESP(player)
end

Players.PlayerAdded:Connect(createESP)
print("[LEX HOST] ESP: ENABLED")

-- FULLBRIGHT
Lighting.Brightness = 2
Lighting.ClockTime = 14
Lighting.FogEnd = 100000
Lighting.GlobalShadows = false
Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
print("[LEX HOST] Fullbright: ENABLED")

-- REMOVE TEXTURES
for _, obj in pairs(Workspace:GetDescendants()) do
    if obj:IsA("Decal") or obj:IsA("Texture") then
        obj:Destroy()
    end
    if obj:IsA("BasePart") then
        obj.Material = Enum.Material.SmoothPlastic
    end
end
print("[LEX HOST] Textures removed for better performance")

-- WEATHER CONTROL
Lighting.CloudCover = 0
Lighting.FogEnd = 100000
Lighting.ClockTime = 14
print("[LEX HOST] Weather set to Clear, Time: Day")

-- REMOVE FOG
Lighting.FogEnd = 100000
print("[LEX HOST] Fog removed")

-- REMOVE PARTS
local partsToRemove = {"wood", "block", "ladder"}

for _, partName in pairs(partsToRemove) do
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name == partName then
            obj:Destroy()
            print("[LEX HOST] Removed: " .. partName)
        end
    end
end

-- GOD MODE
Humanoid.MaxHealth = math.huge
Humanoid.Health = math.huge

Humanoid.HealthChanged:Connect(function(health)
    if health < math.huge then
        Humanoid.Health = math.huge
    end
end)

print("[LEX HOST] God Mode: ENABLED")

-- INFINITE JUMP
UserInputService.JumpRequest:Connect(function()
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
end)

print("[LEX HOST] Infinite Jump: ENABLED")

-- AUTO FARM
local function autoCollect()
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:lower():find("coin") or obj.Name:lower():find("gem") or obj.Name:lower():find("collect")) then
            if obj.CanCollide then
                firetouchinterest(RootPart, obj, 0)
                wait(0.1)
                firetouchinterest(RootPart, obj, 1)
            end
        end
    end
end

RunService.Heartbeat:Connect(function()
    autoCollect()
end)

print("[LEX HOST] Auto Farm: ENABLED")

-- UI CONFIGURATION
LexHost.UI = {}
LexHost.UI.Theme = "Dark"
LexHost.UI.Position = "Right"

print("[LEX HOST] UI Theme: " .. LexHost.UI.Theme)
print("[LEX HOST] UI Position: " .. LexHost.UI.Position)

-- Script End
print("[LEX HOST VIP] All features loaded successfully!")
print("[LEX HOST VIP] Press assigned keys to toggle features")
print("[LEX HOST VIP] Thank you for using LEX HOST VIP v" .. LexHost.Version)
