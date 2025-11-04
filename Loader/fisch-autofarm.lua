--[[ 
    Fisch Auto Farm - FIXED v3.0 (UI kept)
    - Full Auto Cast / Reel / Shake
    - Faster reaction for short pulls
    - Handles RemoteEvent or RemoteFunction
    - Debounce safe
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Configuration
_G.FischSettings = {
    AutoCast = true,
    AutoReel = true,
    AutoShake = true,
    ShakeIntensity = 30,   -- jumlah shake saat minigame
    CastDelay = 0.35,      -- delay loop untuk cek kast (deteksi cepat)
    ReelTick = 0.02,       -- delay antar fire saat reel aktif (cepat)
    Debug = false
}

local isRunning = {
    casting = false,
    reeling = false,
    shaking = false
}

local function debug(...)
    if _G.FischSettings.Debug then
        print("[FISCH DEBUG]", ...)
    end
end

-- Utility: get current rod (Tool)
local function getRod()
    character = player.Character or player.CharacterAdded:Wait()
    local rod = character:FindFirstChildOfClass("Tool")
    if not rod then
        rod = player.Backpack:FindFirstChildOfClass("Tool")
    end
    return rod
end

-- Utility: equip rod if in backpack
local function equipRod()
    local rod = character:FindFirstChildOfClass("Tool") or player.Backpack:FindFirstChildOfClass("Tool")
    if rod and not character:FindFirstChildOfClass("Tool") then
        pcall(function()
            humanoid:EquipTool(rod)
        end)
        task.wait(0.25)
        debug("Equipped rod:", rod and rod.Name or "nil")
        return true
    end
    return (rod ~= nil)
end

-- Safe remote caller (handles RemoteEvent or RemoteFunction)
local function safeCallRemote(remote, ...)
    if not remote then return false end
    local ok, err = pcall(function()
        if remote:IsA("RemoteEvent") and remote.FireServer then
            remote:FireServer(...)
        elseif remote:IsA("RemoteFunction") and remote.InvokeServer then
            remote:InvokeServer(...)
        else
            -- fallback try FireServer
            if remote.FireServer then remote:FireServer(...) end
        end
    end)
    if not ok then
        debug("remote call failed:", err)
    end
    return ok
end

-- Detect fishing UI states
local function isFishing()
    local playerGui = player:FindFirstChild("PlayerGui")
    if not playerGui then return false, nil end

    local shakeUI = playerGui:FindFirstChild("shakeui")
    if shakeUI and (shakeUI.Enabled == true) then
        return true, "shake"
    end

    local reelUI = playerGui:FindFirstChild("reel")
    if reelUI and (reelUI.Enabled == true) then
        return true, "reel"
    end

    -- alternative bar
    local bar = playerGui:FindFirstChild("bar")
    if bar and (bar.Enabled == true) then
        return true, "bar"
    end

    return false, nil
end

-- AUTO CAST (fast, skip if already fishing)
local function AutoCast()
    if isRunning.casting then return end
    isRunning.casting = true

    spawn(function()
        while _G.FischSettings.AutoCast do
            pcall(function()
                local fishing, state = isFishing()
                if fishing then
                    -- already fishing, skip cast
                    debug("Skip cast, state:", state)
                else
                    -- ensure rod equipped
                    if not character:FindFirstChildOfClass("Tool") then
                        equipRod()
                        task.wait(0.18)
                    end

                    local rod = getRod()
                    if rod then
                        local events = rod:FindFirstChild("events")
                        if events then
                            local castEvent = events:FindFirstChild("cast") or events:FindFirstChildWhichIsA("RemoteEvent") or events:FindFirstChildWhichIsA("RemoteFunction")
                            if castEvent then
                                safeCallRemote(castEvent, 100, 1)
                                debug("Cast fired")
                                -- after cast, small wait to let server register
                                task.wait(0.6)
                            else
                                debug("No cast event in rod.events")
                            end
                        else
                            debug("Rod has no events folder")
                        end
                    else
                        debug("No rod found to cast")
                    end
                end
            end)
            task.wait(_G.FischSettings.CastDelay)
        end
        isRunning.casting = false
    end)
end

-- AUTO SHAKE (for minigame) - continuous while shake UI active
local function performShakeLoop()
    if isRunning.shaking then return end
    isRunning.shaking = true

    spawn(function()
        while _G.FischSettings.AutoShake do
            local playerGui = player:FindFirstChild("PlayerGui")
            local shakeUI = playerGui and playerGui:FindFirstChild("shakeui")
            if shakeUI and shakeUI.Enabled then
                -- do repeated shakes until shakeUI disabled
                local rod = getRod()
                if rod then
                    local events = rod:FindFirstChild("events")
                    local shakeRemote = events and (events:FindFirstChild("shake") or events:FindFirstChildWhichIsA("RemoteEvent") or events:FindFirstChildWhichIsA("RemoteFunction"))
                    if shakeRemote then
                        -- spam shakes quickly but bounded
                        for i = 1, _G.FischSettings.ShakeIntensity do
                            safeCallRemote(shakeRemote)
                            task.wait(0.01) -- very fast
                        end
                        debug("Shook:", _G.FischSettings.ShakeIntensity)
                    else
                        debug("No shake remote found")
                    end
                end
            end
            task.wait(0.05)
        end
        isRunning.shaking = false
    end)
end

-- AUTO REEL (fast reaction: spam reel while reel UI active)
local function AutoReel()
    if isRunning.reeling then return end
    isRunning.reeling = true

    spawn(function()
        while _G.FischSettings.AutoReel do
            pcall(function()
                local playerGui = player:FindFirstChild("PlayerGui")
                if not playerGui then return end

                -- Prioritize shake UI (minigame)
                local shakeUI = playerGui:FindFirstChild("shakeui")
                if shakeUI and shakeUI.Enabled and _G.FischSettings.AutoShake then
                    performShakeLoop()
                    -- small pause to allow shake loop to run
                    task.wait(0.08)
                end

                -- If reel UI active => spam reel event until it's gone
                local reelUI = playerGui:FindFirstChild("reel")
                if reelUI and reelUI.Enabled then
                    local rod = getRod()
                    if rod then
                        local events = rod:FindFirstChild("events")
                        local reelRemote = events and (events:FindFirstChild("reel") or events:FindFirstChildWhichIsA("RemoteEvent") or events:FindFirstChildWhichIsA("RemoteFunction"))
                        if reelRemote then
                            -- keep firing quickly while reel UI exists/enabled
                            repeat
                                safeCallRemote(reelRemote, 100, true)
                                task.wait(_G.FischSettings.ReelTick)
                                -- update reelUI in case it's disabled mid-loop
                                reelUI = playerGui:FindFirstChild("reel")
                            until not (reelUI and reelUI.Enabled) or not _G.FischSettings.AutoReel
                            debug("Reel loop ended")
                        else
                            debug("No reel remote found")
                        end
                    end
                end

                -- Backup: if there's a progress bar 'bar' active, attempt small shakes
                local bar = playerGui:FindFirstChild("bar")
                if bar and bar.Enabled then
                    performShakeLoop()
                end
            end)
            task.wait(0.02)
        end
        isRunning.reeling = false
    end)
end

-- Monitor rod events (for debugging)
local function MonitorRemotes()
    spawn(function()
        local rod = getRod()
        if not rod then return end
        local events = rod:FindFirstChild("events")
        if not events then return end
        for _, v in pairs(events:GetChildren()) do
            debug("Detected event in rod.events ->", v.Name, v.ClassName)
        end
    end)
end

-- GUI creation (kept, slightly improved)
local function CreateGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FischGUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game.CoreGui

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 300, 0, 320)
    MainFrame.Position = UDim2.new(0.4, 0, 0.3, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner", MainFrame)
    UICorner.CornerRadius = UDim.new(0,10)

    local Title = Instance.new("TextLabel", MainFrame)
    Title.Size = UDim2.new(1,0,0,40)
    Title.Position = UDim2.new(0,0,0,0)
    Title.BackgroundColor3 = Color3.fromRGB(25,25,25)
    Title.Text = "🎣 FISCH AUTO FARM"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextColor3 = Color3.new(1,1,1)

    local StatusText = Instance.new("TextLabel", MainFrame)
    StatusText.Name = "Status"
    StatusText.Position = UDim2.new(0,10,0,45)
    StatusText.Size = UDim2.new(1,-20,0,30)
    StatusText.BackgroundTransparency = 1
    StatusText.Font = Enum.Font.Gotham
    StatusText.TextSize = 13
    StatusText.TextXAlignment = Enum.TextXAlignment.Left
    StatusText.TextColor3 = Color3.fromRGB(0,255,0)
    StatusText.Text = "🟢 Status: Waiting for fish..."

    local function createButton(name, text, posY, defaultState, callback)
        local btn = Instance.new("TextButton", MainFrame)
        btn.Position = UDim2.new(0,15,0,posY)
        btn.Size = UDim2.new(0,270,0,40)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 14
        btn.BorderSizePixel = 0
        btn.TextColor3 = Color3.new(1,1,1)

        local corner = Instance.new("UICorner", btn)
        corner.CornerRadius = UDim.new(0,8)

        local isEnabled = defaultState
        local function updateBtn()
            btn.BackgroundColor3 = isEnabled and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
            btn.Text = text .. (isEnabled and " ✅" or " ❌")
        end
        updateBtn()

        btn.MouseButton1Click:Connect(function()
            isEnabled = not isEnabled
            updateBtn()
            callback(isEnabled)
        end)
        btn.Name = name
        return btn
    end

    createButton("AutoCast", "Auto Cast", 85, _G.FischSettings.AutoCast, function(state)
        _G.FischSettings.AutoCast = state
        if state then AutoCast() end
    end)

    createButton("AutoReel", "Auto Reel", 135, _G.FischSettings.AutoReel, function(state)
        _G.FischSettings.AutoReel = state
        if state then AutoReel() end
    end)

    createButton("AutoShake", "Auto Shake", 185, _G.FischSettings.AutoShake, function(state)
        _G.FischSettings.AutoShake = state
        if state then performShakeLoop() end
    end)

    local closeBtn = createButton("Close", "❌ CLOSE SCRIPT", 235, false, function()
        _G.FischSettings.AutoCast = false
        _G.FischSettings.AutoReel = false
        _G.FischSettings.AutoShake = false
        if ScreenGui and ScreenGui.Parent then
            ScreenGui:Destroy()
        end
    end)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)

    local infoText = Instance.new("TextLabel", MainFrame)
    infoText.Position = UDim2.new(0,10,0,285)
    infoText.Size = UDim2.new(1,-20,0,25)
    infoText.BackgroundTransparency = 1
    infoText.Font = Enum.Font.Gotham
    infoText.Text = "by @putraborz | v3.0 FIX"
    infoText.TextSize = 11
    infoText.TextColor3 = Color3.fromRGB(150,150,150)

    -- realtime status update
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
            task.wait(0.25)
        end
    end)
end

-- anti-afk
do
    local vu = game:GetService("VirtualUser")
    player.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end

-- init
task.wait(0.5)
equipRod()
CreateGUI()
MonitorRemotes()

if _G.FischSettings.AutoCast then AutoCast() end
if _G.FischSettings.AutoReel then AutoReel() end
if _G.FischSettings.AutoShake then performShakeLoop() end

print("FISCH AUTO FARM v3.0 FIX - Started")
