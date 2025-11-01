-- 🔮 LEX HOST VIP — PolossMVP-style (Full UI)
-- Features: Fly (UI toggle + speed), Speed Slider, God Mode, Noclip, Jump Power, Teleport to Player, Hide/Show, Sidebar, Blur, Neon FX, Sound, Animations
-- Author: ChatGPT (customized for you)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

-- safety: wait character/humanoid
local function getChar()
    return player.Character or player.CharacterAdded:Wait()
end
local function getHumanoid()
    return getChar():WaitForChild("Humanoid")
end

-- remove old UI
if game.CoreGui:FindFirstChild("LEXHostVIP_UI") then
    game.CoreGui:FindFirstChild("LEXHostVIP_UI"):Destroy()
end

-- optional background blur (affects whole scene). create if not exists
local blur = Lighting:FindFirstChild("LEXHostVIP_Blur")
if not blur then
    blur = Instance.new("BlurEffect")
    blur.Name = "LEXHostVIP_Blur"
    blur.Size = 0
    blur.Parent = Lighting
end

-- sound fx
local soundParent = workspace
local clickSound = Instance.new("Sound")
clickSound.Name = "LexClick"
clickSound.SoundId = "rbxassetid://5869292539" -- neon click - change if needed
clickSound.Volume = 1
clickSound.Parent = soundParent

local function playClick()
    pcall(function() clickSound:Play() end)
end

-- create ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "LEXHostVIP_UI"
gui.ResetOnSpawn = false
gui.Enabled = true
gui.Parent = game.CoreGui

-- MAIN CONTAINER (glass-like)
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 520, 0, 360)
main.Position = UDim2.new(0.5, -260, 0.5, -180)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(20, 16, 30)
main.BackgroundTransparency = 0.12
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 18)

-- neon stroke
local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(170, 95, 255)
stroke.Thickness = 3
stroke.Transparency = 0.36

-- translucent blur panel (ImageLabel used as blurry glass)
local glass = Instance.new("ImageLabel", main)
glass.Name = "Glass"
glass.Size = UDim2.new(1, -12, 1, -12)
glass.Position = UDim2.new(0, 6, 0, 6)
glass.BackgroundTransparency = 1
glass.Image = "rbxassetid://3570695787" -- white square
glass.ImageColor3 = Color3.fromRGB(18,14,26)
glass.ScaleType = Enum.ScaleType.Slice
glass.SliceCenter = Rect.new(100,100,100,100)
glass.ImageTransparency = 0.2
Instance.new("UICorner", glass).CornerRadius = UDim.new(0, 16)

-- Title bar (top)
local titleBar = Instance.new("Frame", glass)
titleBar.Size = UDim2.new(1, 0, 0, 52)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundTransparency = 0.25
titleBar.BackgroundColor3 = Color3.fromRGB(45, 30, 75)
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 12)

local titleLabel = Instance.new("TextLabel", titleBar)
titleLabel.Size = UDim2.new(0.6, 0, 1, 0)
titleLabel.Position = UDim2.new(0.03, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🔮  LEX HOST VIP"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 20
titleLabel.TextColor3 = Color3.new(1,1,1)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- small MVP badge (decorative)
local mvpBadge = Instance.new("TextLabel", titleBar)
mvpBadge.Size = UDim2.new(0, 80, 0, 28)
mvpBadge.Position = UDim2.new(0.66, 0, 0.14, 0)
mvpBadge.BackgroundColor3 = Color3.fromRGB(255, 200, 80)
mvpBadge.Text = "VIP"
mvpBadge.Font = Enum.Font.GothamBold
mvpBadge.TextSize = 14
mvpBadge.TextColor3 = Color3.fromRGB(30,30,30)
Instance.new("UICorner", mvpBadge).CornerRadius = UDim.new(0, 12)

-- top-right controls: minimize & close & hide toggle
local btnClose = Instance.new("TextButton", titleBar)
btnClose.Size = UDim2.new(0,36,0,30)
btnClose.Position = UDim2.new(1,-44,0,10)
btnClose.Text = "✖"
btnClose.Font = Enum.Font.GothamBold
btnClose.TextSize = 18
btnClose.BackgroundColor3 = Color3.fromRGB(190,60,80)
btnClose.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", btnClose).CornerRadius = UDim.new(0,8)

local btnMin = Instance.new("TextButton", titleBar)
btnMin.Size = UDim2.new(0,36,0,30)
btnMin.Position = UDim2.new(1,-88,0,10)
btnMin.Text = "_"
btnMin.Font = Enum.Font.GothamBold
btnMin.TextSize = 18
btnMin.BackgroundColor3 = Color3.fromRGB(120,120,140)
btnMin.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", btnMin).CornerRadius = UDim.new(0,8)

-- Hide icon (small)
local hideBtn = Instance.new("TextButton", titleBar)
hideBtn.Size = UDim2.new(0,28,0,28)
hideBtn.Position = UDim2.new(1,-132,0,10)
hideBtn.Text = "◐"
hideBtn.Font = Enum.Font.GothamBold
hideBtn.TextSize = 16
hideBtn.BackgroundColor3 = Color3.fromRGB(85,85,110)
hideBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", hideBtn).CornerRadius = UDim.new(0,8)

-- left sidebar (icons)
local sidebar = Instance.new("Frame", glass)
sidebar.Size = UDim2.new(0, 88, 1, -64)
sidebar.Position = UDim2.new(0, 8, 0, 56)
sidebar.BackgroundTransparency = 1

local sbLayout = Instance.new("UIListLayout", sidebar)
sbLayout.Padding = UDim.new(0, 12)
sbLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
sbLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- helper to make icon buttons
local function makeIcon(text, tooltip)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0,64,0,64)
    b.BackgroundColor3 = Color3.fromRGB(30,25,45)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 22
    b.TextColor3 = Color3.new(1,1,1)
    b.AutoButtonColor = true
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,14)
    local s = Instance.new("UIStroke", b)
    s.Color = Color3.fromRGB(170,95,255)
    s.Thickness = 1.5
    s.Transparency = 0.5
    return b
end

-- create sidebar icons (Main, Movement, Utility, Settings)
local iconMain = makeIcon("🏠")
iconMain.Parent = sidebar
local iconMove = makeIcon("🕹")
iconMove.Parent = sidebar
local iconUtils = makeIcon("🛠")
iconUtils.Parent = sidebar
local iconSet = makeIcon("⚙")
iconSet.Parent = sidebar

-- main content holder (to right of sidebar)
local content = Instance.new("Frame", glass)
content.Size = UDim2.new(1, -112, 1, -72)
content.Position = UDim2.new(0, 104, 0, 56)
content.BackgroundTransparency = 1

local contentLayout = Instance.new("UIListLayout", content)
contentLayout.Padding = UDim.new(0, 12)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- ---------- CONTENT PANELS ----------
-- helper to create panels
local function createPanel(title)
    local p = Instance.new("Frame")
    p.Size = UDim2.new(1, -24, 0, 220)
    p.BackgroundTransparency = 1
    local card = Instance.new("Frame", p)
    card.Size = UDim2.new(1,0,1,0)
    card.BackgroundColor3 = Color3.fromRGB(28, 24, 40)
    card.BackgroundTransparency = 0.1
    card.BorderSizePixel = 0
    Instance.new("UICorner", card).CornerRadius = UDim.new(0,12)
    local header = Instance.new("TextLabel", card)
    header.Size = UDim2.new(1, -20, 0, 28)
    header.Position = UDim2.new(0,10,0,8)
    header.BackgroundTransparency = 1
    header.Text = title
    header.Font = Enum.Font.GothamBold
    header.TextSize = 16
    header.TextColor3 = Color3.fromRGB(220,220,255)
    return p, card
end

-- Panel: Main (overview)
local panelMain, panelMainCard = createPanel("Main")
panelMain.Parent = content

local welcome = Instance.new("TextLabel", panelMainCard)
welcome.Size = UDim2.new(1, -28, 0, 110)
welcome.Position = UDim2.new(0,14,0,44)
welcome.BackgroundTransparency = 1
welcome.Text = "Welcome, " .. (player.Name or "Player") .. ".\nLEX HOST VIP — PolossMVP style UI."
welcome.TextColor3 = Color3.fromRGB(230,230,255)
welcome.TextWrapped = true
welcome.Font = Enum.Font.Gotham
welcome.TextSize = 15
welcome.TextXAlignment = Enum.TextXAlignment.Left

-- Panel: Movement (fly, speed, jump)
local panelMove, panelMoveCard = createPanel("Movement")
panelMove.Parent = content

-- Fly toggle with UI speed input
local flyLabel = Instance.new("TextLabel", panelMoveCard)
flyLabel.Size = UDim2.new(0.45, 0, 0, 28)
flyLabel.Position = UDim2.new(0, 12, 0, 42)
flyLabel.BackgroundTransparency = 1
flyLabel.Text = "Fly:"
flyLabel.Font = Enum.Font.GothamBold
flyLabel.TextSize = 14
flyLabel.TextColor3 = Color3.fromRGB(240,240,255)
flyLabel.TextXAlignment = Enum.TextXAlignment.Left

local flyToggle = Instance.new("TextButton", panelMoveCard)
flyToggle.Size = UDim2.new(0.38, 0, 0, 28)
flyToggle.Position = UDim2.new(0.5, 0, 0, 40)
flyToggle.Text = "OFF"
flyToggle.Font = Enum.Font.GothamBold
flyToggle.TextSize = 14
flyToggle.BackgroundColor3 = Color3.fromRGB(90,80,150)
flyToggle.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", flyToggle).CornerRadius = UDim.new(0,8)

local flySpeedLabel = Instance.new("TextLabel", panelMoveCard)
flySpeedLabel.Size = UDim2.new(0.45,0,0,22)
flySpeedLabel.Position = UDim2.new(0,12,0,78)
flySpeedLabel.BackgroundTransparency = 1
flySpeedLabel.Text = "Fly Speed: 80"
flySpeedLabel.Font = Enum.Font.Gotham
flySpeedLabel.TextSize = 13
flySpeedLabel.TextColor3 = Color3.fromRGB(220,220,255)
flySpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local flySpeedBox = Instance.new("TextBox", panelMoveCard)
flySpeedBox.Size = UDim2.new(0.25,0,0,24)
flySpeedBox.Position = UDim2.new(0.5, 8, 0, 76)
flySpeedBox.Text = "80"
flySpeedBox.ClearTextOnFocus = false
flySpeedBox.Font = Enum.Font.Gotham
flySpeedBox.TextSize = 14
flySpeedBox.BackgroundColor3 = Color3.fromRGB(40,35,70)
flySpeedBox.TextColor3 = Color3.fromRGB(250,250,255)
Instance.new("UICorner", flySpeedBox).CornerRadius = UDim.new(0,6)

-- Speed slider
local speedLabel = Instance.new("TextLabel", panelMoveCard)
speedLabel.Size = UDim2.new(0.9,0,0,22)
speedLabel.Position = UDim2.new(0.05,0,0,112)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Walk Speed: 16"
speedLabel.Font = Enum.Font.Gotham
speedLabel.TextSize = 14
speedLabel.TextColor3 = Color3.fromRGB(220,220,255)
speedLabel.TextXAlignment = Enum.TextXAlignment.Left

local sliderBg = Instance.new("Frame", panelMoveCard)
sliderBg.Size = UDim2.new(0.9,0,0,14)
sliderBg.Position = UDim2.new(0.05,0,0,136)
sliderBg.BackgroundColor3 = Color3.fromRGB(55,40,95)
sliderBg.BorderSizePixel = 0
Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1,0)

local sliderFill = Instance.new("Frame", sliderBg)
sliderFill.Size = UDim2.new(0.1,0,1,0)
sliderFill.BackgroundColor3 = Color3.fromRGB(165,115,255)
Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1,0)

-- Jump power control (textbox)
local jpLabel = Instance.new("TextLabel", panelMoveCard)
jpLabel.Size = UDim2.new(0.45,0,0,22)
jpLabel.Position = UDim2.new(0,12,0,160)
jpLabel.BackgroundTransparency = 1
jpLabel.Text = "Jump Power: 50"
jpLabel.Font = Enum.Font.Gotham
jpLabel.TextSize = 13
jpLabel.TextColor3 = Color3.fromRGB(220,220,255)

local jpBox = Instance.new("TextBox", panelMoveCard)
jpBox.Size = UDim2.new(0.25,0,0,24)
jpBox.Position = UDim2.new(0.5, 8, 0, 158)
jpBox.Text = "50"
jpBox.Font = Enum.Font.Gotham
jpBox.TextSize = 14
jpBox.BackgroundColor3 = Color3.fromRGB(40,35,70)
jpBox.TextColor3 = Color3.fromRGB(250,250,255)
Instance.new("UICorner", jpBox).CornerRadius = UDim.new(0,6)

-- Panel: Utilities (god, noclip, teleport)
local panelUtil, panelUtilCard = createPanel("Utilities")
panelUtil.Parent = content

local godBtn = Instance.new("TextButton", panelUtilCard)
godBtn.Size = UDim2.new(0.45,0,0,36)
godBtn.Position = UDim2.new(0.05,0,0,28)
godBtn.Text = "God Mode: OFF"
godBtn.Font = Enum.Font.GothamBold
godBtn.TextSize = 14
godBtn.BackgroundColor3 = Color3.fromRGB(110,70,140)
godBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", godBtn).CornerRadius = UDim.new(0,8)

local noclipBtn = Instance.new("TextButton", panelUtilCard)
noclipBtn.Size = UDim2.new(0.45,0,0,36)
noclipBtn.Position = UDim2.new(0.5,8,0,28)
noclipBtn.Text = "Noclip: OFF"
noclipBtn.Font = Enum.Font.GothamBold
noclipBtn.TextSize = 14
noclipBtn.BackgroundColor3 = Color3.fromRGB(100,100,120)
noclipBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", noclipBtn).CornerRadius = UDim.new(0,8)

-- Teleport dropdown and button
local tpLabel = Instance.new("TextLabel", panelUtilCard)
tpLabel.Size = UDim2.new(0.9,0,0,22)
tpLabel.Position = UDim2.new(0.05,0,0,80)
tpLabel.BackgroundTransparency = 1
tpLabel.Text = "Teleport To Player:"
tpLabel.Font = Enum.Font.Gotham
tpLabel.TextSize = 13
tpLabel.TextColor3 = Color3.fromRGB(220,220,255)
tpLabel.TextXAlignment = Enum.TextXAlignment.Left

local tpHolder = Instance.new("Frame", panelUtilCard)
tpHolder.Size = UDim2.new(0.9,0,0,34)
tpHolder.Position = UDim2.new(0.05,0,0,106)
tpHolder.BackgroundTransparency = 1

local tpDropdown = Instance.new("TextBox", tpHolder)
tpDropdown.Size = UDim2.new(0.65,0,1,0)
tpDropdown.Position = UDim2.new(0,0,0,0)
tpDropdown.Text = ""
tpDropdown.PlaceholderText = "Type player name..."
tpDropdown.Font = Enum.Font.Gotham
tpDropdown.TextSize = 14
tpDropdown.BackgroundColor3 = Color3.fromRGB(38,34,50)
tpDropdown.TextColor3 = Color3.fromRGB(245,245,255)
Instance.new("UICorner", tpDropdown).CornerRadius = UDim.new(0,6)

local tpBtn = Instance.new("TextButton", tpHolder)
tpBtn.Size = UDim2.new(0.32,0,1,0)
tpBtn.Position = UDim2.new(0.68,10,0,0)
tpBtn.Text = "TP"
tpBtn.Font = Enum.Font.GothamBold
tpBtn.TextSize = 14
tpBtn.BackgroundColor3 = Color3.fromRGB(140,100,220)
tpBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0,6)

-- Panel: Settings (theme swatches & minimize shape)
local panelSet, panelSetCard = createPanel("Settings")
panelSet.Parent = content

local themeLabel = Instance.new("TextLabel", panelSetCard)
themeLabel.Size = UDim2.new(1,0,0,24)
themeLabel.Position = UDim2.new(0,12,0,10)
themeLabel.BackgroundTransparency = 1
themeLabel.Text = "Theme:"
themeLabel.Font = Enum.Font.GothamBold
themeLabel.TextSize = 14
themeLabel.TextColor3 = Color3.fromRGB(220,220,255)
themeLabel.TextXAlignment = Enum.TextXAlignment.Left

-- swatches
local swContainer = Instance.new("Frame", panelSetCard)
swContainer.Size = UDim2.new(1, -24, 0, 46)
swContainer.Position = UDim2.new(0,12,0,38)
swContainer.BackgroundTransparency = 1

local function makeSwatch(color)
    local s = Instance.new("TextButton", swContainer)
    s.Size = UDim2.new(0,46,0,36)
    s.BackgroundColor3 = color
    s.Text = ""
    Instance.new("UICorner", s).CornerRadius = UDim.new(0,8)
    return s
end

local sw1 = makeSwatch(Color3.fromRGB(165,115,255)) -- purple
sw1.Position = UDim2.new(0,0,0,0)
local sw2 = makeSwatch(Color3.fromRGB(255,120,90)) -- pink/orange
sw2.Position = UDim2.new(0,58,0,0)
local sw3 = makeSwatch(Color3.fromRGB(60,180,255)) -- blue
sw3.Position = UDim2.new(0,116,0,0)
local sw4 = makeSwatch(Color3.fromRGB(90,220,150)) -- green
sw4.Position = UDim2.new(0,174,0,0)

-- Hide/Show small toggle UI (corner)
local miniBtn = Instance.new("TextButton")
miniBtn.Name = "MiniToggle"
miniBtn.Size = UDim2.new(0,48,0,48)
miniBtn.Position = UDim2.new(0, 12, 1, -64)
miniBtn.AnchorPoint = Vector2.new(0,0)
miniBtn.BackgroundColor3 = Color3.fromRGB(45,40,70)
miniBtn.Text = "LEX"
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextSize = 13
miniBtn.TextColor3 = Color3.fromRGB(255,255,255)
miniBtn.Parent = gui
Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(0,12)
miniBtn.Visible = true

-- ---------- FUNCTIONAL LOGIC ----------
local state = {
    fly = false,
    flySpeed = 80,
    walkSpeed = 16,
    god = false,
    noclip = false,
    jumpPower = 50,
    hidden = false
}

-- apply initial humanoid values
local humanoid = getHumanoid()
humanoid.WalkSpeed = state.walkSpeed
humanoid.JumpPower = state.jumpPower

-- blur tween in
TweenService:Create(blur, TweenInfo.new(0.6, Enum.EasingStyle.Sine), {Size = 8}):Play()

-- FLY implementation (uses HRP.Velocity)
local flyConn
local function startFly()
    if flyConn then flyConn:Disconnect() flyConn = nil end
    flyConn = RunService.Heartbeat:Connect(function()
        if not state.fly then return end
        local char = getChar()
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local move = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then move += hrp.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then move -= hrp.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then move -= hrp.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then move += hrp.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0,1,0) end
        if hrp then
            hrp.Velocity = move.Unit ~= Vector3.zero and move.Unit * state.flySpeed or Vector3.zero
        end
    end)
end

local function stopFly()
    if flyConn then flyConn:Disconnect() flyConn = nil end
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.Velocity = Vector3.zero
    end
end

-- FLY UI bind
flyToggle.MouseButton1Click:Connect(function()
    playClick()
    state.fly = not state.fly
    flyToggle.Text = state.fly and "ON" or "OFF"
    if state.fly then
        startFly()
    else
        stopFly()
    end
end)

flySpeedBox.FocusLost:Connect(function(enter)
    local v = tonumber(flySpeedBox.Text)
    if v and v > 0 and v <= 1000 then
        state.flySpeed = v
        flySpeedLabel.Text = "Fly Speed: " .. tostring(v)
    else
        flySpeedBox.Text = tostring(state.flySpeed)
    end
end)

-- Speed slider behavior
local dragging = false
sliderBg.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        playClick()
    end
end)
UIS.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
UIS.InputChanged:Connect(function(inp)
    if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
        local x = math.clamp((inp.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
        sliderFill.Size = UDim2.new(x,0,1,0)
        local newSpeed = math.floor(16 + x * (120 - 16))
        state.walkSpeed = newSpeed
        pcall(function() getHumanoid().WalkSpeed = newSpeed end)
        speedLabel.Text = "Walk Speed: " .. newSpeed
    end
end)

-- Jump power
jpBox.FocusLost:Connect(function(enter)
    local v = tonumber(jpBox.Text)
    if v and v >= 10 and v <= 300 then
        state.jumpPower = v
        pcall(function() getHumanoid().JumpPower = v end)
        jpLabel.Text = "Jump Power: " .. tostring(v)
    else
        jpBox.Text = tostring(state.jumpPower)
    end
end)

-- GOD mode toggle
godBtn.MouseButton1Click:Connect(function()
    playClick()
    state.god = not state.god
    godBtn.Text = state.god and "God Mode: ON" or "God Mode: OFF"
    if state.god then
        local hum = getHumanoid()
        hum.MaxHealth = math.huge
        hum.Health = math.huge
        pcall(function() hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false) end)
    else
        local hum = getHumanoid()
        pcall(function() hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true) end)
        hum.MaxHealth = 100
        hum.Health = 100
    end
end)

-- Noclip toggle: set CanCollide false on all parts
local noclipConn
local function enableNoclip()
    if noclipConn then noclipConn:Disconnect() noclipConn = nil end
    noclipConn = RunService.Stepped:Connect(function()
        local char = getChar()
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end)
end
local function disableNoclip()
    if noclipConn then noclipConn:Disconnect() noclipConn = nil end
    local char = player.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

noclipBtn.MouseButton1Click:Connect(function()
    playClick()
    state.noclip = not state.noclip
    noclipBtn.Text = state.noclip and "Noclip: ON" or "Noclip: OFF"
    if state.noclip then enableNoclip() else disableNoclip() end
end)

-- Teleport logic
tpBtn.MouseButton1Click:Connect(function()
    playClick()
    local name = tpDropdown.Text:match("%S+")
    if not name or name == "" then return end
    local target
    for _, pl in pairs(Players:GetPlayers()) do
        if pl.Name:lower():find(name:lower()) or (pl.DisplayName and pl.DisplayName:lower():find(name:lower())) then
            target = pl
            break
        end
    end
    if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
        -- try exact match
        for _, pl in pairs(Players:GetPlayers()) do
            if pl.Name == name or pl.DisplayName == name then
                target = pl
                break
            end
        end
    end
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = target.Character.HumanoidRootPart
        local myChar = getChar()
        local myHrp = myChar:FindFirstChild("HumanoidRootPart")
        if myHrp then
            myHrp.CFrame = hrp.CFrame + Vector3.new(0,5,0)
        end
    end
end)

-- Theme swatches handler (adjust stroke colors)
local function setThemeColor(c)
    TweenService:Create(stroke, TweenInfo.new(0.3), {Color = c}):Play()
    -- button strokes etc. can be updated similarly if desired
end
sw1.MouseButton1Click:Connect(function() playClick(); setThemeColor(Color3.fromRGB(165,115,255)) end)
sw2.MouseButton1Click:Connect(function() playClick(); setThemeColor(Color3.fromRGB(255,120,90)) end)
sw3.MouseButton1Click:Connect(function() playClick(); setThemeColor(Color3.fromRGB(60,180,255)) end)
sw4.MouseButton1Click:Connect(function() playClick(); setThemeColor(Color3.fromRGB(90,220,150)) end)

-- minimize & close behavior
btnClose.MouseButton1Click:Connect(function()
    playClick()
    TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -260, 1.4, 0), BackgroundTransparency = 1}):Play()
    TweenService:Create(blur, TweenInfo.new(0.4), {Size = 0}):Play()
    task.delay(0.45, function() if gui then gui:Destroy() end end)
end)

btnMin.MouseButton1Click:Connect(function()
    playClick()
    -- minimize: hide content, reduce size
    if main.Size == UDim2.new(0,520,0,360) then
        TweenService:Create(main, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {Size = UDim2.new(0,260,0,64)}):Play()
    else
        TweenService:Create(main, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {Size = UDim2.new(0,520,0,360)}):Play()
    end
end)

-- hide/show using hideBtn & miniBtn
local function hideAll()
    if state.hidden then return end
    state.hidden = true
    playClick()
    TweenService:Create(main, TweenInfo.new(0.35), {Position = UDim2.new(0.5, -260, 1.2, 0)}):Play()
    TweenService:Create(blur, TweenInfo.new(0.3), {Size = 0}):Play()
    miniBtn.Visible = true
end
local function showAll()
    if not state.hidden then return end
    state.hidden = false
    playClick()
    TweenService:Create(main, TweenInfo.new(0.35), {Position = UDim2.new(0.5, -260, 0.5, -180)}):Play()
    TweenService:Create(blur, TweenInfo.new(0.35), {Size = 8}):Play()
    miniBtn.Visible = true
end

hideBtn.MouseButton1Click:Connect(function()
    hideAll()
end)
miniBtn.MouseButton1Click:Connect(function()
    if state.hidden then showAll() else hideAll() end
end)

-- Sidebar switching (simple show/hide panels)
iconMain.MouseButton1Click:Connect(function() playClick(); -- show only panelMain
    for _, c in pairs(content:GetChildren()) do if c:IsA("Frame") then c.Visible = false end end
    panelMain.Visible = true
end)
iconMove.MouseButton1Click:Connect(function() playClick();
    for _, c in pairs(content:GetChildren()) do if c:IsA("Frame") then c.Visible = false end end
    panelMove.Visible = true
end)
iconUtils.MouseButton1Click:Connect(function() playClick();
    for _, c in pairs(content:GetChildren()) do if c:IsA("Frame") then c.Visible = false end end
    panelUtil.Visible = true
end)
iconSet.MouseButton1Click:Connect(function() playClick();
    for _, c in pairs(content:GetChildren()) do if c:IsA("Frame") then c.Visible = false end end
    panelSet.Visible = true
end)

-- default show movement panel
for _, c in pairs(content:GetChildren()) do if c:IsA("Frame") then c.Visible = false end end
panelMove.Visible = true
panelMain.Visible = false
panelUtil.Visible = false
panelSet.Visible = false

-- cleanup on character respawn: re-apply walk/jump speed and disable fly/noclip if necessary
player.CharacterAdded:Connect(function(char)
    task.delay(0.5, function()
        pcall(function()
            getHumanoid().WalkSpeed = state.walkSpeed or 16
            getHumanoid().JumpPower = state.jumpPower or 50
        end)
        if state.noclip then enableNoclip() end
        if state.fly then startFly() end
    end)
end)

-- final ready message
print("[LEX HOST VIP] UI loaded (PolossMVP style).")
