--[[
    Fisch Auto Farm Script - AUTO RUNNING VERSION
    Version: 1.0.1
    Author: putraborz
    Repository: https://github.com/putraborz/lexhostlkp
    
    ⚠️ WARNING: Use at your own risk!
]]

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

-- Variables
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Configuration dengan status running
_G.FischConfig = {
    AutoCast = true,
    AutoReel = true,
    AutoShake = true,
    AutoSell = false,
    CastPower = 100,
    AntiAFK = true,
    Delay = 0.5
}

-- Running Status (untuk kontrol loop)
local Running = {
    AutoCast = false,
    AutoReel = false,
    AutoSell = false
}

-- Anti AFK
if _G.FischConfig.AntiAFK then
    player.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end

-- Notification Function
local function notify(title, text, duration)
    game.StarterGui:SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = duration or 3;
    })
end

-- Get Fishing Tool
local function getTool()
    return character:FindFirstChildOfClass("Tool") or player.Backpack:FindFirstChildOfClass("Tool")
end

-- Equip Tool
local function equipTool()
    local tool = player.Backpack:FindFirstChildOfClass("Tool")
    if tool then
        character.Humanoid:EquipTool(tool)
        wait(0.3)
        return true
    end
    return false
end

-- AUTO CAST FUNCTION (dengan kontrol loop)
local function startAutoCast()
    if Running.AutoCast then return end -- Cegah multiple loop
    Running.AutoCast = true
    
    notify("Auto Cast", "Started!", 2)
    
    spawn(function()
        while Running.AutoCast and _G.FischConfig.AutoCast do
            local success, err = pcall(function()
                local tool = getTool()
                
                if not tool then
                    wait(1)
                    return
                end
                
                -- Equip jika belum di-equip
                if not character:FindFirstChildOfClass("Tool") then
                    equipTool()
                    wait(0.5)
                end
                
                tool = character:FindFirstChildOfClass("Tool")
                if tool and tool:FindFirstChild("events") then
                    local castEvent = tool.events:FindFirstChild("cast")
                    if castEvent then
                        castEvent:FireServer(_G.FischConfig.CastPower, 1)
                        print("🎣 Casting rod...")
                        wait(3) -- Wait setelah cast
                    end
                end
            end)
            
            if not success then
                warn("Cast Error:", err)
            end
            
            wait(_G.FischConfig.Delay)
        end
        
        Running.AutoCast = false
        notify("Auto Cast", "Stopped!", 2)
    end)
end

local function stopAutoCast()
    Running.AutoCast = false
    _G.FischConfig.AutoCast = false
end

-- AUTO REEL FUNCTION (dengan kontrol loop)
local function startAutoReel()
    if Running.AutoReel then return end
    Running.AutoReel = true
    
    notify("Auto Reel", "Started!", 2)
    
    spawn(function()
        while Running.AutoReel and _G.FischConfig.AutoReel do
            local success, err = pcall(function()
                local playerGui = player:WaitForChild("PlayerGui")
                local shakeUI = playerGui:FindFirstChild("shakeui")
                
                if shakeUI and shakeUI.Enabled then
                    local tool = character:FindFirstChildOfClass("Tool")
                    
                    if tool and tool:FindFirstChild("events") then
                        -- Auto Shake (spam shake untuk menang minigame)
                        if _G.FischConfig.AutoShake then
                            local shakeEvent = tool.events:FindFirstChild("shake")
                            if shakeEvent then
                                for i = 1, 15 do
                                    shakeEvent:FireServer()
                                    wait(0.03)
                                end
                                print("🔄 Shaking...")
                            end
                        end
                        
                        -- Auto Reel (tarik ikan)
                        wait(0.1)
                        local reelEvent = tool.events:FindFirstChild("reel")
                        if reelEvent then
                            reelEvent:FireServer(100, true)
                            print("✅ Reeling fish!")
                            wait(1)
                        end
                    end
                end
            end)
            
            if not success then
                warn("Reel Error:", err)
            end
            
            wait(0.1)
        end
        
        Running.AutoReel = false
        notify("Auto Reel", "Stopped!", 2)
    end)
end

local function stopAutoReel()
    Running.AutoReel = false
    _G.FischConfig.AutoReel = false
end

-- AUTO SELL FUNCTION (dengan kontrol loop)
local function startAutoSell()
    if Running.AutoSell then return end
    Running.AutoSell = true
    
    notify("Auto Sell", "Started!", 2)
    
    spawn(function()
        while Running.AutoSell and _G.FischConfig.AutoSell do
            local success, err = pcall(function()
                -- Cari NPC Merchant
                local merchant = workspace:FindFirstChild("world")
                if merchant then
                    merchant = merchant:FindFirstChild("npcs")
                    if merchant then
                        merchant = merchant:FindFirstChild("Marc Merchant")
                    end
                end
                
                if merchant and merchant:FindFirstChild("HumanoidRootPart") then
                    local originalPos = character.HumanoidRootPart.CFrame
                    
                    -- Teleport ke merchant
                    character.HumanoidRootPart.CFrame = merchant.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                    wait(0.5)
                    
                    -- Trigger sell
                    local sellEvent = ReplicatedStorage:FindFirstChild("events")
                    if sellEvent then
                        sellEvent = sellEvent:FindFirstChild("sell")
                        if sellEvent then
                            sellEvent:FireServer()
                            print("💰 Selling fish...")
                        end
                    end
                    
                    wait(1)
                    
                    -- Kembali ke posisi awal
                    character.HumanoidRootPart.CFrame = originalPos
                    print("↩️ Returned to fishing spot")
                end
            end)
            
            if not success then
                warn("Sell Error:", err)
            end
            
            wait(120) -- Sell setiap 2 menit
        end
        
        Running.AutoSell = false
        notify("Auto Sell", "Stopped!", 2)
    end)
end

local function stopAutoSell()
    Running.AutoSell = false
    _G.FischConfig.AutoSell = false
end

-- GUI Creation
local function createGUI()
    -- Hapus GUI lama jika ada
    if game.CoreGui:FindFirstChild("FischAutoFarm") then
        game.CoreGui.FischAutoFarm:Destroy()
    end
    
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local StatusLabel = Instance.new("TextLabel")
    local UICorner = Instance.new("UICorner")

    ScreenGui.Name = "FischAutoFarm"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
    MainFrame.Size = UDim2.new(0, 320, 0, 280)
    MainFrame.Active = true
    MainFrame.Draggable = true

    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame

    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Title.BorderSizePixel = 0
    Title.Size = UDim2.new(1, 0, 0, 45)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "🎣 Fisch Auto Farm v1.0.1"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 17
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = Title

    StatusLabel.Name = "StatusLabel"
    StatusLabel.Parent = MainFrame
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Position = UDim2.new(0, 0, 0, 45)
    StatusLabel.Size = UDim2.new(1, 0, 0, 25)
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.Text = "Status: Ready"
    StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    StatusLabel.TextSize = 12

    -- Button Creation Function
    local function createButton(name, text, position, isEnabled)
        local btn = Instance.new("TextButton")
        btn.Name = name
        btn.Parent = MainFrame
        btn.BackgroundColor3 = isEnabled and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(180, 0, 0)
        btn.BorderSizePixel = 0
        btn.Position = position
        btn.Size = UDim2.new(0, 280, 0, 38)
        btn.Font = Enum.Font.GothamBold
        btn.Text = text .. ": " .. (isEnabled and "✅ ON" or "❌ OFF")
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 14
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = btn
        
        return btn
    end

    -- Auto Cast Button
    local AutoCastBtn = createButton("AutoCast", "Auto Cast", UDim2.new(0, 20, 0, 80), true)
    AutoCastBtn.MouseButton1Click:Connect(function()
        if _G.FischConfig.AutoCast then
            stopAutoCast()
            AutoCastBtn.Text = "Auto Cast: ❌ OFF"
            AutoCastBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        else
            _G.FischConfig.AutoCast = true
            startAutoCast()
            AutoCastBtn.Text = "Auto Cast: ✅ ON"
            AutoCastBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        end
    end)

    -- Auto Reel Button
    local AutoReelBtn = createButton("AutoReel", "Auto Reel", UDim2.new(0, 20, 0, 128), true)
    AutoReelBtn.MouseButton1Click:Connect(function()
        if _G.FischConfig.AutoReel then
            stopAutoReel()
            AutoReelBtn.Text = "Auto Reel: ❌ OFF"
            AutoReelBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        else
            _G.FischConfig.AutoReel = true
            startAutoReel()
            AutoReelBtn.Text = "Auto Reel: ✅ ON"
            AutoReelBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        end
    end)

    -- Auto Sell Button
    local AutoSellBtn = createButton("AutoSell", "Auto Sell", UDim2.new(0, 20, 0, 176), false)
    AutoSellBtn.MouseButton1Click:Connect(function()
        if _G.FischConfig.AutoSell then
            stopAutoSell()
            AutoSellBtn.Text = "Auto Sell: ❌ OFF"
            AutoSellBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        else
            _G.FischConfig.AutoSell = true
            startAutoSell()
            AutoSellBtn.Text = "Auto Sell: ✅ ON"
            AutoSellBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        end
    end)

    -- Close Button
    local CloseBtn = createButton("Close", "❌ Close", UDim2.new(0, 20, 0, 224), false)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CloseBtn.MouseButton1Click:Connect(function()
        stopAutoCast()
        stopAutoReel()
        stopAutoSell()
        ScreenGui:Destroy()
        notify("Fisch Auto Farm", "Script stopped!", 3)
    end)
    
    -- Update Status Label setiap detik
    spawn(function()
        while ScreenGui.Parent do
            local activeCount = 0
            if Running.AutoCast then activeCount = activeCount + 1 end
            if Running.AutoReel then activeCount = activeCount + 1 end
            if Running.AutoSell then activeCount = activeCount + 1 end
            
            StatusLabel.Text = "Status: " .. activeCount .. " feature(s) active"
            StatusLabel.TextColor3 = activeCount > 0 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 165, 0)
            wait(1)
        end
    end)
end

-- Initialize Script
notify("Fisch Auto Farm", "Loading...", 2)
wait(0.5)
createGUI()

-- AUTO START fitur yang enabled
if _G.FischConfig.AutoCast then
    startAutoCast()
end

if _G.FischConfig.AutoReel then
    startAutoReel()
end

if _G.FischConfig.AutoSell then
    startAutoSell()
end

notify("Fisch Auto Farm", "✅ Loaded & Running!", 3)

print("╔═══════════════════════════════╗")
print("║   Fisch Auto Farm v1.0.1     ║")
print("║   AUTO RUNNING ENABLED!      ║")
print("║   By: putraborz              ║")
print("╚═══════════════════════════════╝")
