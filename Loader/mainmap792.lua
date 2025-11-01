-- 🌌 LEX HOST VIP Neon Menu
-- by ChatGPT (Full Ready-to-Use)

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Hapus GUI lama jika ada
if game.CoreGui:FindFirstChild("LEXHostVIP_UI") then
    game.CoreGui:FindFirstChild("LEXHostVIP_UI"):Destroy()
end

-- 🧱 Buat GUI dasar
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LEXHostVIP_UI"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui

-- Frame utama
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 270)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -135)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 20, 40)
mainFrame.BackgroundTransparency = 0.15
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 18)

local stroke = Instance.new("UIStroke", mainFrame)
stroke.Color = Color3.fromRGB(150, 100, 255)
stroke.Thickness = 3
stroke.Transparency = 0.4

-- 🌟 Judul
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 0.2
title.BackgroundColor3 = Color3.fromRGB(60, 40, 100)
title.Font = Enum.Font.GothamBold
title.Text = "🔮 LEX HOST VIP"
title.TextScaled = true
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

-- Efek warna pelangi
local hue = 0
game:GetService("RunService").RenderStepped:Connect(function()
    hue = (hue + 1) % 360
    title.TextColor3 = Color3.fromHSV(hue / 360, 1, 1)
end)

-- Tombol close
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -38, 0, 6)
closeBtn.Text = "✖"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextScaled = true
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- 🧭 Container tombol menu
local menuContainer = Instance.new("Frame", mainFrame)
menuContainer.Size = UDim2.new(1, -20, 1, -60)
menuContainer.Position = UDim2.new(0, 10, 0, 50)
menuContainer.BackgroundTransparency = 1

-- Fungsi membuat tombol
local function makeButton(name, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = color
    btn.BackgroundTransparency = 0.1
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 1.5
    stroke.Transparency = 0.6
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- 🕹️ Tombol Menu
local layout = Instance.new("UIListLayout", menuContainer)
layout.Padding = UDim.new(0, 8)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Top

-- 🚀 Fly
local flyEnabled = false
local flyConn
menuContainer:WaitForChild("UIListLayout")
local flyBtn = makeButton("✈️ Fly", Color3.fromRGB(90, 90, 160), function()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    flyEnabled = not flyEnabled
    flyBtn.Text = flyEnabled and "🛑 Stop Fly" or "✈️ Fly"
    if flyEnabled then
        flyConn = game:GetService("RunService").Heartbeat:Connect(function()
            if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
            local move = Vector3.zero
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then move = move + hrp.CFrame.LookVector end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then move = move - hrp.CFrame.LookVector end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then move = move - hrp.CFrame.RightVector end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then move = move + hrp.CFrame.RightVector end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0, 1, 0) end
            hrp.Velocity = move * 100
        end)
    else
        if flyConn then flyConn:Disconnect() flyConn = nil end
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.Velocity = Vector3.zero
        end
    end
end)
flyBtn.Parent = menuContainer

-- ⚡ Speed
local speedEnabled = false
local normalWalk = 16
local boostedSpeed = 80
local speedBtn = makeButton("⚡ Speed", Color3.fromRGB(100, 130, 200), function()
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    speedEnabled = not speedEnabled
    humanoid.WalkSpeed = speedEnabled and boostedSpeed or normalWalk
    speedBtn.Text = speedEnabled and "🛑 Stop Speed" or "⚡ Speed"
end)
speedBtn.Parent = menuContainer

-- 🛡️ God Mode
local godEnabled = false
local godBtn = makeButton("🛡️ God Mode", Color3.fromRGB(120, 80, 150), function()
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    godEnabled = not godEnabled
    godBtn.Text = godEnabled and "🛑 Disable God Mode" or "🛡️ God Mode"
    if godEnabled then
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        humanoid.Health = math.huge
        humanoid.MaxHealth = math.huge
    else
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
        humanoid.Health = 100
        humanoid.MaxHealth = 100
    end
end)
godBtn.Parent = menuContainer

-- 🎞️ Replay System (memanggil fungsi Replay kamu)
local replayBtn = makeButton("🎬 Replay System", Color3.fromRGB(90, 60, 180), function()
    -- Jalankan sistem replay kamu di sini
    loadstring(game:HttpGet("https://raw.githubusercontent.com/putraborz/WataXMountAtin/refs/heads/main/Loader/10.lua"))()
end)
replayBtn.Parent = menuContainer

print("[LEX HOST VIP] Neon Menu Loaded Successfully!")
