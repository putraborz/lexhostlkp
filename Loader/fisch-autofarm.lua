--[[
    Fisch Auto Farm Script
    Version: 1.0.0
    Author: putraborz
    Repository: https://github.com/putraborz/lexhostlkp
    
    ⚠️ WARNING: Use at your own risk!
    This script may violate Roblox Terms of Service
]]

-- Anti-Detection
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Variables
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Configuration
_G.FischConfig = {
    AutoFish = true,
    AutoCast = true,
    AutoReel = true,
    AutoShake = true,
    AutoSell = false,
    CastPower = 100,
    AntiAFK = true,
    SafeMode = true,
    Delay = 0.5
}

-- Load Config from URL (optional)
pcall(function()
    local config = game:HttpGet("https://raw.githubusercontent.com/putraborz/lexhostlkp/main/Loader/fisch-config.lua")
    loadstring(config)()
end)

-- Anti AFK
if _G.FischConfig.AntiAFK then
    local vu = game:GetService("VirtualUser")
    player.Idled:connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end

-- Functions
local function notify(title, text, duration)
    game.StarterGui:SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = duration or 5;
    })
end

local function getTool()
    return character:FindFirstChildOfClass("Tool") or player.Backpack:FindFirstChildOfClass("Tool")
end

local function equipTool()
    local tool = player.Backpack:FindFirstChildOfClass("Tool")
    if tool then
        character.Humanoid:EquipTool(tool)
        wait(0.3)
    end
end

-- Auto Cast Function
local function autoCast()
    spawn(function()
        while _G.FischConfig.AutoCast and wait(_G.FischConfig.Delay) do
            pcall(function()
                local tool = getTool()
                if tool and tool:FindFirstChild("events") then
                    if not character:FindFirstChildOfClass("Tool") then
                        equipTool()
                        wait(0.5)
                    end
                    
                    local castEvent = tool.events:FindFirstChild("cast")
                    if castEvent then
                        castEvent:FireServer(_G.FischConfig.CastPower, 1)
                        wait(2)
                    end
                end
            end)
        end
    end)
end

-- Auto Reel Function
local function autoReel()
    spawn(function()
        while _G.FischConfig.AutoReel and wait(0.1) do
            pcall(function()
                local playerGui = player:WaitForChild("PlayerGui")
                local shakeUI = playerGui:FindFirstChild("shakeui")
                
                if shakeUI and shakeUI.Enabled then
                    local tool = getTool()
                    if tool and tool:FindFirstChild("events") then
                        -- Auto Shake
                        if _G.FischConfig.AutoShake then
                            local shakeEvent = tool.events:FindFirstChild("shake")
                            if shakeEvent then
                                for i = 1, 10 do
                                    shakeEvent:FireServer()
                                    wait(0.05)
                                end
                            end
                        end
                        
                        -- Auto Reel
                        local reelEvent = tool.events:FindFirstChild("reel")
                        if reelEvent then
                            reelEvent:FireServer(100, true)
                        end
                    end
                end
            end)
        end
    end)
end

-- Auto Sell Function
local function autoSell()
    spawn(function()
        while _G.FischConfig.AutoSell and wait(60) do
            pcall(function()
                -- Teleport to sell location
                local sellLocation = workspace:FindFirstChild("world"):FindFirstChild("npcs"):FindFirstChild("Marc Merchant")
                if sellLocation then
                    local originalPos = humanoidRootPart.CFrame
                    humanoidRootPart.CFrame = sellLocation.HumanoidRootPart.CFrame
                    wait(1)
                    
                    -- Trigger sell event
                    local sellEvent = ReplicatedStorage:FindFirstChild("events"):FindFirstChild("sell")
                    if sellEvent then
                        sellEvent:FireServer()
                    end
                    
                    wait(2)
                    humanoidRootPart.CFrame = originalPos
                end
            end)
        end
    end)
end

-- GUI Creation
local function createGUI()
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local AutoCastBtn = Instance.new("TextButton")
    local AutoReelBtn = Instance.new("TextButton")
    local AutoSellBtn = Instance.new("TextButton")
    local CloseBtn = Instance.new("TextButton")
    local UICorner = Instance.new("UICorner")

    ScreenGui.Name = "FischAutoFarm"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
    MainFrame.Size = UDim2.new(0, 300, 0, 250)
    MainFrame.Active = true
    MainFrame.Draggable = true

    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Title.BorderSizePixel = 0
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "Fisch Auto Farm v1.0"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16

    local function createButton(name, text, position, callback)
        local btn = Instance.new("TextButton")
        btn.Name = name
        btn.Parent = MainFrame
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        btn.BorderSizePixel = 0
        btn.Position = position
        btn.Size = UDim2.new(0, 260, 0, 35)
        btn.Font = Enum.Font.Gotham
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 14
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = btn
        
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    AutoCastBtn = createButton("AutoCast", "Auto Cast: ON", UDim2.new(0, 20, 0, 60), function()
        _G.FischConfig.AutoCast = not _G.FischConfig.AutoCast
        AutoCastBtn.Text = "Auto Cast: " .. (_G.FischConfig.AutoCast and "ON" or "OFF")
        AutoCastBtn.BackgroundColor3 = _G.FischConfig.AutoCast and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
    end)

    AutoReelBtn = createButton("AutoReel", "Auto Reel: ON", UDim2.new(0, 20, 0, 105), function()
        _G.FischConfig.AutoReel = not _G.FischConfig.AutoReel
        AutoReelBtn.Text = "Auto Reel: " .. (_G.FischConfig.AutoReel and "ON" or "OFF")
        AutoReelBtn.BackgroundColor3 = _G.FischConfig.AutoReel and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
    end)

    AutoSellBtn = createButton("AutoSell", "Auto Sell: OFF", UDim2.new(0, 20, 0, 150), function()
        _G.FischConfig.AutoSell = not _G.FischConfig.AutoSell
        AutoSellBtn.Text = "Auto Sell: " .. (_G.FischConfig.AutoSell and "ON" or "OFF")
        AutoSellBtn.BackgroundColor3 = _G.FischConfig.AutoSell and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
    end)

    CloseBtn = createButton("Close", "Close", UDim2.new(0, 20, 0, 195), function()
        ScreenGui:Destroy()
    end)

    -- Set initial colors
    AutoCastBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    AutoReelBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    AutoSellBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
end

-- Initialize
notify("Fisch Auto Farm", "Script loaded successfully!", 5)
createGUI()
autoCast()
autoReel()
autoSell()

print("╔═══════════════════════════════╗")
print("║   Fisch Auto Farm Loaded!    ║")
print("║   Version: 1.0.0             ║")
print("║   By: putraborz              ║")
print("╚═══════════════════════════════╝")
