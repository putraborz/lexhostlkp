--[[
    Fisch Auto Farm - FIXED VERSION
    Version: 2.0.0
    Fully Working Auto Cast & Auto Reel
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Configuration
_G.FischSettings = {
    AutoCast = true,
    AutoReel = true,
    AutoShake = true,
    ShakeIntensity = 20,  -- Jumlah shake
    CastDelay = 0.5,
    ReelDelay = 0.05,
    Debug = true
}

local isRunning = {
    cast = false,
    reel = false
}

-- Notification
local function notify(text)
    game.StarterGui:SetCore("SendNotification", {
        Title = "🎣 Fisch Auto",
        Text = text,
        Duration = 3
    })
end

-- Debug Print
local function debug(...)
    if _G.FischSettings.Debug then
        print("[FISCH DEBUG]", ...)
    end
end

-- Get Current Rod
local function getRod()
    local rod = character:FindFirstChildOfClass("Tool")
    if not rod then
        rod = player.Backpack:FindFirstChildOfClass("Tool")
    end
    return rod
end

-- Equip Rod
local function equipRod()
    local rod = player.Backpack:FindFirstChildOfClass("Tool")
    if rod and not character:FindFirstChildOfClass("Tool") then
        humanoid:EquipTool(rod)
        task.wait(0.3)
        debug("Rod equipped:", rod.Name)
        return true
    end
    return false
end

-- Check if PlayerGui has active fishing UI
local function isFishing()
    local playerGui = player:WaitForChild("PlayerGui")
    
    -- Cek shake UI
    local shakeUI = playerGui:FindFirstChild("shakeui")
    if shakeUI and shakeUI.Enabled then
        return true, "shake"
    end
    
    -- Cek reel UI
    local reelUI = playerGui:FindFirstChild("reel")
    if reelUI and reelUI.Enabled then
        return true, "reel"
    end
    
    return false, nil
end

-- AUTO CAST (Lempar Kail)
local function AutoCast()
    spawn(function()
        while task.wait(_G.FischSettings.CastDelay) do
            if not _G.FischSettings.AutoCast then break end
            
            pcall(function()
                -- Cek jika sedang fishing, skip cast
                local fishing, state = isFishing()
                if fishing then
                    debug("Already fishing, state:", state)
                    return
                end
                
                -- Equip rod jika belum
                if not character:FindFirstChildOfClass("Tool") then
                    equipRod()
                    task.wait(0.5)
                end
                
                local rod = character:FindFirstChildOfClass("Tool")
                if not rod then
                    debug("No rod found!")
                    return
                end
                
                -- Cari cast event
                local events = rod:FindFirstChild("events")
                if events then
                    local castEvent = events:FindFirstChild("cast")
                    if castEvent then
                        -- Fire cast event
                        castEvent:FireServer(100, 1)
                        debug("✅ Cast executed!")
                        task.wait(2.5) -- Wait setelah cast
                    end
                end
            end)
        end
        debug("Auto Cast stopped")
    end)
end

-- AUTO SHAKE (Untuk minigame)
local function performShake()
    local rod = character:FindFirstChildOfClass("Tool")
    if not rod then return false end
    
    local events = rod:FindFirstChild("events")
    if not events then return false end
    
    local shakeEvent = events:FindFirstChild("shake")
    if not shakeEvent then return false end
    
    -- Spam shake dengan cepat
    for i = 1, _G.FischSettings.ShakeIntensity do
        shakeEvent:FireServer()
        task.wait(0.02)
    end
    
    debug("🔄 Shake performed:", _G.FischSettings.ShakeIntensity, "times")
    return true
end

-- AUTO REEL (Tarik Ikan)
local function AutoReel()
    spawn(function()
        while task.wait(_G.FischSettings.ReelDelay) do
            if not _G.FischSettings.AutoReel then break end
            
            pcall(function()
                local playerGui = player:WaitForChild("PlayerGui")
                
                -- Deteksi Shake UI (minigame)
                local shakeUI = playerGui:FindFirstChild("shakeui")
                if shakeUI and shakeUI.Enabled then
                    if _G.FischSettings.AutoShake then
                        performShake()
                        task.wait(0.1)
                    end
                end
                
                -- Deteksi Reel UI atau game progress
                local reelUI = playerGui:FindFirstChild("reel")
                if reelUI and reelUI.Enabled then
                    local rod = character:FindFirstChildOfClass("Tool")
                    if rod then
                        local events = rod:FindFirstChild("events")
                        if events then
                            local reelEvent = events:FindFirstChild("reel")
                            if reelEvent then
                                -- Fire reel event
                                reelEvent:FireServer(100, true)
                                debug("✅ Reel executed!")
                            end
                        end
                    end
                end
                
                -- Deteksi progress bar (alternative method)
                local fishingBar = playerGui:FindFirstChild("bar")
                if fishingBar and fishingBar.Enabled then
                    performShake()
                end
            end)
        end
        debug("Auto Reel stopped")
    end)
end

-- METODE ALTERNATIF: Monitor RemoteEvents
local function MonitorRemotes()
    spawn(function()
        local rod = getRod()
        if not rod then return end
        
        local events = rod:FindFirstChild("events")
        if not events then return end
        
        -- Monitor semua remote events
        for _, v in pairs(events:GetChildren()) do
            if v:IsA("RemoteEvent") then
                debug("Found event:", v.Name)
            end
        end
    end)
end

-- CREATE GUI
local function CreateGUI()
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local StatusText = Instance.new("TextLabel")
    
    ScreenGui.Name = "FischGUI"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.4, 0, 0.3, 0)
    MainFrame.Size = UDim2.new(0, 300, 0, 320)
    MainFrame.Active = true
    MainFrame.Draggable = true
    
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame
    
    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Title.BorderSizePixel = 0
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "🎣 FISCH AUTO FARM"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 10)
    titleCorner.Parent = Title
    
    StatusText.Name = "Status"
    StatusText.Parent = MainFrame
    StatusText.BackgroundTransparency = 1
    StatusText.Position = UDim2.new(0, 10, 0, 45)
    StatusText.Size = UDim2.new(1, -20, 0, 30)
    StatusText.Font = Enum.Font.Gotham
    StatusText.Text = "🟢 Status: Active & Running"
    StatusText.TextColor3 = Color3.fromRGB(0, 255, 0)
    StatusText.TextSize = 13
    StatusText.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Button function
    local function createButton(name, text, position, defaultState, callback)
        local btn = Instance.new("TextButton")
        local corner = Instance.new("UICorner")
        
        btn.Name = name
        btn.Parent = MainFrame
        btn.BackgroundColor3 = defaultState and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
        btn.BorderSizePixel = 0
        btn.Position = position
        btn.Size = UDim2.new(0, 270, 0, 40)
        btn.Font = Enum.Font.GothamBold
        btn.Text = text .. (defaultState and " ✅" or " ❌")
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 14
        
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = btn
        
        local isEnabled = defaultState
        btn.MouseButton1Click:Connect(function()
            isEnabled = not isEnabled
            btn.BackgroundColor3 = isEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
            btn.Text = text .. (isEnabled and " ✅" or " ❌")
            callback(isEnabled)
        end)
        
        return btn
    end
    
    -- Buttons
    createButton("AutoCast", "Auto Cast", UDim2.new(0, 15, 0, 85), true, function(state)
        _G.FischSettings.AutoCast = state
        if state then
            AutoCast()
            notify("Auto Cast: ON")
        else
            notify("Auto Cast: OFF")
        end
    end)
    
    createButton("AutoReel", "Auto Reel", UDim2.new(0, 15, 0, 135), true, function(state)
        _G.FischSettings.AutoReel = state
        if state then
            AutoReel()
            notify("Auto Reel: ON")
        else
            notify("Auto Reel: OFF")
        end
    end)
    
    createButton("AutoShake", "Auto Shake", UDim2.new(0, 15, 0, 185), true, function(state)
        _G.FischSettings.AutoShake = state
        notify("Auto Shake: " .. (state and "ON" or "OFF"))
    end)
    
    local closeBtn = createButton("Close", "❌ CLOSE SCRIPT", UDim2.new(0, 15, 0, 235), false, function()
        _G.FischSettings.AutoCast = false
        _G.FischSettings.AutoReel = false
        _G.FischSettings.AutoShake = false
        ScreenGui:Destroy()
        notify("Script Stopped!")
    end)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    
    -- Info Text
    local infoText = Instance.new("TextLabel")
    infoText.Parent = MainFrame
    infoText.BackgroundTransparency = 1
    infoText.Position = UDim2.new(0, 10, 0, 285)
    infoText.Size = UDim2.new(1, -20, 0, 25)
    infoText.Font = Enum.Font.Gotham
    infoText.Text = "by @putraborz | v2.0"
    infoText.TextColor3 = Color3.fromRGB(150, 150, 150)
    infoText.TextSize = 11
    
    -- Real-time status update
    spawn(function()
        while ScreenGui.Parent do
            local fishing, state = isFishing()
            if fishing then
                StatusText.Text = "🎣 Fishing... (" .. (state or "active") .. ")"
                StatusText.TextColor3 = Color3.fromRGB(255, 255, 0)
            else
                StatusText.Text = "🟢 Status: Waiting for fish..."
                StatusText.TextColor3 = Color3.fromRGB(0, 255, 0)
            end
            task.wait(0.5)
        end
    end)
end

-- Anti-AFK
local vu = game:GetService("VirtualUser")
player.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- INITIALIZE
task.wait(1)
notify("Loading Fisch Auto Farm...")

-- Equip rod at start
equipRod()
task.wait(0.5)

-- Create GUI
CreateGUI()
MonitorRemotes()

-- Auto start features
if _G.FischSettings.AutoCast then
    AutoCast()
    debug("Auto Cast: Started")
end

if _G.FischSettings.AutoReel then
    AutoReel()
    debug("Auto Reel: Started")
end

notify("✅ Script Ready & Running!")

print("╔════════════════════════════╗")
print("║  FISCH AUTO FARM v2.0      ║")
print("║  Status: RUNNING           ║")
print("║  Auto Cast: ON             ║")
print("║  Auto Reel: ON             ║")
print("╚════════════════════════════╝")
