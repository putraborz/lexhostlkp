-- LEX HOST VIP — Studio Edition (Safe / Dev-only)
-- Theme: Ungu Neon (Solid dark, no blur)
-- Fitur (client-side/testing only):
--  • UI polossMVP-style (sidebar, neon)
--  • Fly (client freecam — tidak memodifikasi humanoid)
--  • Speed slider (mengubah Humanoid.WalkSpeed pada client saat testing)
--  • God Mode (client-side visible only: sets local humanoid health to very large locally)
--  • Hilangkan Part (klik -> local hide menggunakan LocalTransparencyModifier)
--  • Ambil Part (klik -> clone to ReplicatedStorage/LEXHost_CollectedParts_DEV)
--  • Hide/Show menu, sound FX, theme swatches
--
-- NOTE: Jangan gunakan ini untuk cheat online; script ini dibuat untuk development/testing di Roblox Studio.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Create collection folder in ReplicatedStorage (dev-only)
local collectionFolder = ReplicatedStorage:FindFirstChild("LEXHost_CollectedParts_DEV")
if not collectionFolder then
    collectionFolder = Instance.new("Folder")
    collectionFolder.Name = "LEXHost_CollectedParts_DEV"
    collectionFolder.Parent = ReplicatedStorage
end

-- safety helper
local function getHumanoid()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:FindFirstChildOfClass("Humanoid")
end

-- Remove old GUI if present
if game.CoreGui:FindFirstChild("LEXHostVIP_UI") then
    game.CoreGui:FindFirstChild("LEXHostVIP_UI"):Destroy()
end

-- ---------------------------
-- Sound FX (dev-only)
-- ---------------------------
local SoundService = game:GetService("SoundService")
local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://5869292539" -- soft neon click (replace if you want)
clickSound.Volume = 0.9
clickSound.Parent = SoundService
local function playClick()
    pcall(function() clickSound:Play() end)
end

-- ---------------------------
-- Build UI
-- ---------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LEXHostVIP_UI"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui
screenGui.IgnoreGuiInset = true

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 520, 0, 360)
main.Position = UDim2.new(0.5, -260, 0.5, -180)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(20, 16, 30) -- solid dark
main.BackgroundTransparency = 0.12
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 18)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(165,115,255)
stroke.Thickness = 3
stroke.Transparency = 0.34

-- glass (decor)
local glass = Instance.new("ImageLabel", main)
glass.Size = UDim2.new(1, -12, 1, -12)
glass.Position = UDim2.new(0, 6, 0, 6)
glass.BackgroundTransparency = 1
glass.Image = "rbxassetid://3570695787"
glass.ImageColor3 = Color3.fromRGB(18,14,26)
glass.ScaleType = Enum.ScaleType.Slice
glass.SliceCenter = Rect.new(100,100,100,100)
glass.ImageTransparency = 0.2
Instance.new("UICorner", glass).CornerRadius = UDim.new(0, 16)

-- Title
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

-- Top-right controls
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

-- Hide small toggle
local hideBtn = Instance.new("TextButton", titleBar)
hideBtn.Size = UDim2.new(0,28,0,28)
hideBtn.Position = UDim2.new(1,-132,0,10)
hideBtn.Text = "◐"
hideBtn.Font = Enum.Font.GothamBold
hideBtn.TextSize = 16
hideBtn.BackgroundColor3 = Color3.fromRGB(85,85,110)
hideBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", hideBtn).CornerRadius = UDim.new(0,8)

-- Sidebar
local sidebar = Instance.new("Frame", glass)
sidebar.Size = UDim2.new(0, 88, 1, -64)
sidebar.Position = UDim2.new(0, 8, 0, 56)
sidebar.BackgroundTransparency = 1

local sbLayout = Instance.new("UIListLayout", sidebar)
sbLayout.Padding = UDim.new(0, 12)
sbLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
sbLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function makeIcon(text)
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
    s.Color = Color3.fromRGB(165,115,255)
    s.Thickness = 1.5
    s.Transparency = 0.5
    return b
end

local iconMain = makeIcon("🏠"); iconMain.Parent = sidebar
local iconMove = makeIcon("🕹"); iconMove.Parent = sidebar
local iconUtil = makeIcon("🛠"); iconUtil.Parent = sidebar
local iconSet = makeIcon("⚙"); iconSet.Parent = sidebar

-- Content area
local content = Instance.new("Frame", glass)
content.Size = UDim2.new(1, -112, 1, -72)
content.Position = UDim2.new(0, 104, 0, 56)
content.BackgroundTransparency = 1

local contentLayout = Instance.new("UIListLayout", content)
contentLayout.Padding = UDim.new(0, 12)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Panel helper
local function createPanel(title)
    local p = Instance.new("Frame")
    p.Size = UDim2.new(1, -24, 0, 220)
    p.BackgroundTransparency = 1
    local card = Instance.new("Frame", p)
    card.Size = UDim2.new(1,0,1,0)
    card.BackgroundColor3 = Color3.fromRGB(28, 24, 40)
    card.BackgroundTransparency = 0.1
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

-- Panels
local panelMain, panelMainCard = createPanel("Main"); panelMain.Parent = content
local panelMove, panelMoveCard = createPanel("Movement"); panelMove.Parent = content
local panelUtil, panelUtilCard = createPanel("Utilities"); panelUtil.Parent = content
local panelSet, panelSetCard = createPanel("Settings"); panelSet.Parent = content

-- Populate Movement panel (Fly, FlySpeed, WalkSpeed slider, JumpPower)
local flyLabel = Instance.new("TextLabel", panelMoveCard)
flyLabel.Size = UDim2.new(0.45, 0, 0, 28); flyLabel.Position = UDim2.new(0, 12, 0, 42)
flyLabel.BackgroundTransparency = 1; flyLabel.Text = "Fly:"; flyLabel.Font = Enum.Font.GothamBold; flyLabel.TextColor3 = Color3.fromRGB(240,240,255)

local flyToggle = Instance.new("TextButton", panelMoveCard)
flyToggle.Size = UDim2.new(0.38, 0, 0, 28); flyToggle.Position = UDim2.new(0.5, 0, 0, 40)
flyToggle.Text = "OFF"; flyToggle.Font = Enum.Font.GothamBold; Instance.new("UICorner", flyToggle).CornerRadius = UDim.new(0,8)
flyToggle.BackgroundColor3 = Color3.fromRGB(90,80,150); flyToggle.TextColor3 = Color3.new(1,1,1)

local flySpeedLabel = Instance.new("TextLabel", panelMoveCard)
flySpeedLabel.Size = UDim2.new(0.45,0,0,22); flySpeedLabel.Position = UDim2.new(0,12,0,78)
flySpeedLabel.BackgroundTransparency = 1; flySpeedLabel.Text = "Fly Speed: 80"; flySpeedLabel.Font = Enum.Font.Gotham; flySpeedLabel.TextColor3 = Color3.fromRGB(220,220,255)

local flySpeedBox = Instance.new("TextBox", panelMoveCard)
flySpeedBox.Size = UDim2.new(0.25,0,0,24); flySpeedBox.Position = UDim2.new(0.5, 8, 0, 76)
flySpeedBox.Text = "80"; flySpeedBox.ClearTextOnFocus = false; flySpeedBox.Font = Enum.Font.Gotham

local speedLabel = Instance.new("TextLabel", panelMoveCard)
speedLabel.Size = UDim2.new(0.9,0,0,22); speedLabel.Position = UDim2.new(0.05,0,0,112)
speedLabel.BackgroundTransparency = 1; speedLabel.Text = "Walk Speed: 16"; speedLabel.Font = Enum.Font.Gotham; speedLabel.TextColor3 = Color3.fromRGB(220,220,255)

local sliderBg = Instance.new("Frame", panelMoveCard)
sliderBg.Size = UDim2.new(0.9,0,0,14); sliderBg.Position = UDim2.new(0.05,0,0,136)
sliderBg.BackgroundColor3 = Color3.fromRGB(55,40,95); sliderBg.BorderSizePixel = 0; Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1,0)

local sliderFill = Instance.new("Frame", sliderBg)
sliderFill.Size = UDim2.new(0.1,0,1,0); sliderFill.BackgroundColor3 = Color3.fromRGB(165,115,255); Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1,0)

local jpLabel = Instance.new("TextLabel", panelMoveCard)
jpLabel.Size = UDim2.new(0.45,0,0,22); jpLabel.Position = UDim2.new(0,12,0,160)
jpLabel.BackgroundTransparency = 1; jpLabel.Text = "Jump Power: 50"; jpLabel.Font = Enum.Font.Gotham

local jpBox = Instance.new("TextBox", panelMoveCard)
jpBox.Size = UDim2.new(0.25,0,0,24); jpBox.Position = UDim2.new(0.5, 8, 0, 158)
jpBox.Text = "50"; jpBox.Font = Enum.Font.Gotham

-- Utilities: god, noclip, teleport, remove/collect mode status
local godBtn = Instance.new("TextButton", panelUtilCard)
godBtn.Size = UDim2.new(0.45,0,0,36); godBtn.Position = UDim2.new(0.05,0,0,28)
godBtn.Text = "God: OFF"; godBtn.Font = Enum.Font.GothamBold; Instance.new("UICorner", godBtn).CornerRadius = UDim.new(0,8)
godBtn.BackgroundColor3 = Color3.fromRGB(110,70,140); godBtn.TextColor3 = Color3.new(1,1,1)

local noclipBtn = Instance.new("TextButton", panelUtilCard)
noclipBtn.Size = UDim2.new(0.45,0,0,36); noclipBtn.Position = UDim2.new(0.5,8,0,28)
noclipBtn.Text = "Noclip: OFF"; noclipBtn.Font = Enum.Font.GothamBold; Instance.new("UICorner", noclipBtn).CornerRadius = UDim.new(0,8)
noclipBtn.BackgroundColor3 = Color3.fromRGB(100,100,120); noclipBtn.TextColor3 = Color3.new(1,1,1)

-- Remove / Grab modes (click to activate; next click a part will be processed)
local modeLabel = Instance.new("TextLabel", panelUtilCard)
modeLabel.Size = UDim2.new(1,0,0,20); modeLabel.Position = UDim2.new(0,12,0,76); modeLabel.BackgroundTransparency = 1
modeLabel.Text = "Click Mode: None"; modeLabel.Font = Enum.Font.Gotham; modeLabel.TextColor3 = Color3.fromRGB(220,220,255)

local removeBtn = Instance.new("TextButton", panelUtilCard)
removeBtn.Size = UDim2.new(0.45,0,0,32); removeBtn.Position = UDim2.new(0.05,0,0,104)
removeBtn.Text = "Remove (Local)"; removeBtn.Font = Enum.Font.GothamBold; Instance.new("UICorner", removeBtn).CornerRadius = UDim.new(0,8)
removeBtn.BackgroundColor3 = Color3.fromRGB(160,70,110); removeBtn.TextColor3 = Color3.new(1,1,1)

local grabBtn = Instance.new("TextButton", panelUtilCard)
grabBtn.Size = UDim2.new(0.45,0,0,32); grabBtn.Position = UDim2.new(0.5,8,0,104)
grabBtn.Text = "Grab (Clone)"; grabBtn.Font = Enum.Font.GothamBold; Instance.new("UICorner", grabBtn).CornerRadius = UDim.new(0,8)
grabBtn.BackgroundColor3 = Color3.fromRGB(120,90,180); grabBtn.TextColor3 = Color3.new(1,1,1)

-- Teleport field in Utilities (dev-only)
local tpLabel = Instance.new("TextLabel", panelUtilCard)
tpLabel.Size = UDim2.new(0.9,0,0,20); tpLabel.Position = UDim2.new(0.05,0,0,144); tpLabel.BackgroundTransparency = 1
tpLabel.Text = "Teleport to player (dev-only):"; tpLabel.Font = Enum.Font.Gotham; tpLabel.TextColor3 = Color3.fromRGB(220,220,255)

local tpBox = Instance.new("TextBox", panelUtilCard)
tpBox.Size = UDim2.new(0.65,0,0,28); tpBox.Position = UDim2.new(0.05,0,0,168); tpBox.Text = ""; tpBox.Font = Enum.Font.Gotham
local tpBtn = Instance.new("TextButton", panelUtilCard)
tpBtn.Size = UDim2.new(0.28,0,0,28); tpBtn.Position = UDim2.new(0.72,0,0,168); tpBtn.Text = "TP"; tpBtn.Font = Enum.Font.GothamBold; Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0,6)

-- Settings: theme swatches & hide
local themeLabel = Instance.new("TextLabel", panelSetCard)
themeLabel.Size = UDim2.new(1,0,0,24); themeLabel.Position = UDim2.new(0,12,0,10); themeLabel.BackgroundTransparency = 1
themeLabel.Text = "Theme:"; themeLabel.Font = Enum.Font.GothamBold; themeLabel.TextColor3 = Color3.fromRGB(220,220,255)

local swContainer = Instance.new("Frame", panelSetCard)
swContainer.Size = UDim2.new(1, -24, 0, 46); swContainer.Position = UDim2.new(0,12,0,38); swContainer.BackgroundTransparency = 1

local function makeSwatch(color, posX)
    local s = Instance.new("TextButton", swContainer)
    s.Size = UDim2.new(0,46,0,36)
    s.Position = UDim2.new(0, posX, 0, 0)
    s.BackgroundColor3 = color
    s.Text = ""
    Instance.new("UICorner", s).CornerRadius = UDim.new(0,8)
    return s
end

local sw1 = makeSwatch(Color3.fromRGB(165,115,255), 0) -- purple
local sw2 = makeSwatch(Color3.fromRGB(255,120,90), 0.11) -- pink/orange
local sw3 = makeSwatch(Color3.fromRGB(60,180,255), 0.22) -- blue
local sw4 = makeSwatch(Color3.fromRGB(90,220,150), 0.33) -- green

-- mini toggle
local miniBtn = Instance.new("TextButton")
miniBtn.Size = UDim2.new(0,48,0,48); miniBtn.Position = UDim2.new(0, 12, 1, -64)
miniBtn.BackgroundColor3 = Color3.fromRGB(45,40,70); miniBtn.Text = "LEX"; miniBtn.Font = Enum.Font.GothamBold; miniBtn.TextColor3 = Color3.new(1,1,1)
miniBtn.Parent = screenGui; Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(0,12)

-- ---------------------------
-- State
-- ---------------------------
local state = {
    flyMode = false,     -- freecam
    flySpeed = 80,
    walkSpeed = 16,
    jumpPower = 50,
    god = false,
    noclip = false,
    clickMode = "None",  -- "None" | "Remove" | "Grab"
    hidden = false
}

-- Apply initial values
pcall(function()
    local hum = getHumanoid()
    if hum then
        hum.WalkSpeed = state.walkSpeed
        hum.JumpPower = state.jumpPower
    end
end)

-- ---------------------------
-- Freecam (client-only)
-- ---------------------------
-- Implementation: when flyMode ON, we enable a script-controlled Camera that moves with WASD/Space/Ctrl.
-- This does NOT move the character; it's purely camera. Safe for Studio testing.
local freecam = {
    enabled = false,
    camera = workspace.CurrentCamera,
    pos = workspace.CurrentCamera and workspace.CurrentCamera.CFrame or CFrame.new(0,5,0)
}
local camConn

local function startFreecam()
    if freecam.enabled then return end
    freecam.enabled = true
    local cam = workspace.CurrentCamera
    freecam.camera = cam
    freecam.pos = cam.CFrame
    cam.CameraType = Enum.CameraType.Scriptable

    camConn = RunService.RenderStepped:Connect(function(dt)
        local speed = state.flySpeed * (UIS:IsKeyDown(Enum.KeyCode.LeftShift) and 2 or 1)
        local move = Vector3.new(0,0,0)
        if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + freecam.pos.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then move = move - freecam.pos.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then move = move - freecam.pos.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + freecam.pos.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0,1,0) end
        if move.Magnitude > 0 then
            freecam.pos = freecam.pos + move.Unit * (speed * dt)
        end
        -- mouse look
        local mouseDelta = UIS:GetMouseLocation()
        -- simple rotation using MouseDelta is not trivial without ContextAction; keep the camera orientation as-is for stable dev testing.
        cam.CFrame = freecam.pos
    end)
end

local function stopFreecam()
    if not freecam.enabled then return end
    freecam.enabled = false
    if camConn then camConn:Disconnect(); camConn = nil end
    local cam = workspace.CurrentCamera
    if cam then
        cam.CameraType = Enum.CameraType.Custom
    end
end

-- Toggle Fly (freecam)
flyToggle.MouseButton1Click:Connect(function()
    playClick()
    state.flyMode = not state.flyMode
    flyToggle.Text = state.flyMode and "ON" or "OFF"
    if state.flyMode then
        startFreecam()
    else
        stopFreecam()
    end
end)

flySpeedBox.FocusLost:Connect(function()
    local v = tonumber(flySpeedBox.Text)
    if v and v > 0 and v <= 2000 then
        state.flySpeed = v
        flySpeedLabel.Text = "Fly Speed: "..v
    else
        flySpeedBox.Text = tostring(state.flySpeed)
    end
end)

-- Walk speed slider
local dragging = false
sliderBg.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        playClick()
    end
end)
UIS.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
UIS.InputChanged:Connect(function(inp)
    if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
        local x = math.clamp((inp.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
        sliderFill.Size = UDim2.new(x,0,1,0)
        local newSpeed = math.floor(16 + x * (120 - 16))
        state.walkSpeed = newSpeed
        pcall(function() getHumanoid().WalkSpeed = newSpeed end)
        speedLabel.Text = "Walk Speed: "..newSpeed
    end
end)

-- Jump power textbox
jpBox.FocusLost:Connect(function()
    local v = tonumber(jpBox.Text)
    if v and v >= 0 and v <= 300 then
        state.jumpPower = v
        pcall(function() getHumanoid().JumpPower = v end)
        jpLabel.Text = "Jump Power: "..v
    else
        jpBox.Text = tostring(state.jumpPower)
    end
end)

-- God mode (client-side only)
godBtn.MouseButton1Click:Connect(function()
    playClick()
    state.god = not state.god
    godBtn.Text = state.god and "God: ON" or "God: OFF"
    -- client-side visual: keep humanoid health very high locally
    if state.god then
        local hum = getHumanoid()
        if hum then
            hum.MaxHealth = 1e9
            hum.Health = 1e9
        end
    else
        local hum = getHumanoid()
        if hum then
            hum.MaxHealth = 100
            hum.Health = 100
        end
    end
end)

-- Noclip (client-side): set all parts in character to CanCollide false locally
local noclipConn
local function enableNoclip()
    if noclipConn then noclipConn:Disconnect() noclipConn = nil end
    noclipConn = RunService.Stepped:Connect(function()
        local char = player.Character
        if not char then return end
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                -- store original Collide in Attribute if not present
                if part:GetAttribute("LEX_orig_CanCollide") == nil then
                    part:SetAttribute("LEX_orig_CanCollide", part.CanCollide)
                end
                part.CanCollide = false
            end
        end
    end)
end
local function disableNoclip()
    if noclipConn then noclipConn:Disconnect() noclipConn = nil end
    local char = player.Character
    if not char then return end
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            local orig = part:GetAttribute("LEX_orig_CanCollide")
            if orig ~= nil then part.CanCollide = orig; part:SetAttribute("LEX_orig_CanCollide", nil) end
        end
    end
end

noclipBtn.MouseButton1Click:Connect(function()
    playClick()
    state.noclip = not state.noclip
    noclipBtn.Text = state.noclip and "Noclip: ON" or "Noclip: OFF"
    if state.noclip then enableNoclip() else disableNoclip() end
end)

-- Teleport (dev-only)
tpBtn.MouseButton1Click:Connect(function()
    playClick()
    local name = tpBox.Text:match("%S+")
    if not name or name == "" then return end
    local target
    for _, pl in pairs(Players:GetPlayers()) do
        if pl.Name:lower():find(name:lower()) or (pl.DisplayName and pl.DisplayName:lower():find(name:lower())) then
            target = pl; break
        end
    end
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = target.Character.HumanoidRootPart
        local myHrp = (player.Character and player.Character:FindFirstChild("HumanoidRootPart"))
        if myHrp then myHrp.CFrame = hrp.CFrame + Vector3.new(0,5,0) end
    end
end)

-- ---------------------------
-- Click-based Remove / Grab (client-only safe)
-- ---------------------------
-- Mode toggles
removeBtn.MouseButton1Click:Connect(function()
    playClick()
    state.clickMode = (state.clickMode == "Remove") and "None" or "Remove"
    modeLabel.Text = "Click Mode: "..state.clickMode
end)
grabBtn.MouseButton1Click:Connect(function()
    playClick()
    state.clickMode = (state.clickMode == "Grab") and "None" or "Grab"
    modeLabel.Text = "Click Mode: "..state.clickMode
end)

-- Raycast on Mouse Button1
local mouse = player:GetMouse()
mouse.Button1Down:Connect(function()
    if state.clickMode == "None" then return end
    local target = mouse.Target -- advantage: easy reference
    if not target then return end
    -- ensure target is BasePart and not UI
    if not target:IsA("BasePart") then return end

    if state.clickMode == "Remove" then
        -- Use LocalTransparencyModifier to hide it locally (safe)
        -- store original in Attribute so we can restore later
        if target:GetAttribute("LEX_orig_LocalTransparency") == nil then
            target:SetAttribute("LEX_orig_LocalTransparency", target.LocalTransparencyModifier or 0)
        end
        target.LocalTransparencyModifier = 1
        -- optionally make non-collidable locally
        target:SetAttribute("LEX_orig_CanCollide", target.CanCollide)
        target.CanCollide = false
        playClick()
    elseif state.clickMode == "Grab" then
        -- clone part to ReplicatedStorage collection folder for dev inspection
        local ok, clone = pcall(function() return target:Clone() end)
        if ok and clone then
            clone.Name = target.Name .. "_LEXClone"
            clone.Parent = collectionFolder
            -- zero out network ownership problem: keep clones safe
            -- tag clone so dev knows it's a local/dev copy
            clone:SetAttribute("LEX_ClonedAt", os.time())
            playClick()
        end
    end
end)

-- Add a small label to show collection count
local collCountLabel = Instance.new("TextLabel", panelUtilCard)
collCountLabel.Size = UDim2.new(0.9,0,0,20)
collCountLabel.Position = UDim2.new(0.05,0,0,200)
collCountLabel.BackgroundTransparency = 1
collCountLabel.Text = "Collected: "..#collectionFolder:GetChildren()
collCountLabel.Font = Enum.Font.Gotham
collCountLabel.TextColor3 = Color3.fromRGB(220,220,255)

collectionFolder.ChildAdded:Connect(function() collCountLabel.Text = "Collected: "..#collectionFolder:GetChildren() end)
collectionFolder.ChildRemoved:Connect(function() collCountLabel.Text = "Collected: "..#collectionFolder:GetChildren() end)

-- ---------------------------
-- Theme swatches
-- ---------------------------
local function setTheme(c)
    TweenService:Create(stroke, TweenInfo.new(0.25), {Color = c}):Play()
    -- optionally update other UI strokes/colors
end
sw1.MouseButton1Click:Connect(function() playClick(); setTheme(Color3.fromRGB(165,115,255)) end)
sw2.MouseButton1Click:Connect(function() playClick(); setTheme(Color3.fromRGB(255,120,90)) end)
sw3.MouseButton1Click:Connect(function() playClick(); setTheme(Color3.fromRGB(60,180,255)) end)
sw4.MouseButton1Click:Connect(function() playClick(); setTheme(Color3.fromRGB(90,220,150)) end)

-- ---------------------------
-- Minimize / Hide behavior
-- ---------------------------
local minimized = false
btnMin.MouseButton1Click:Connect(function()
    playClick()
    if not minimized then
        TweenService:Create(main, TweenInfo.new(0.35), {Size = UDim2.new(0,260,0,64)}):Play()
        minimized = true
    else
        TweenService:Create(main, TweenInfo.new(0.35), {Size = UDim2.new(0,520,0,360)}):Play()
        minimized = false
    end
end)

hideBtn.MouseButton1Click:Connect(function()
    playClick()
    if not state.hidden then
        TweenService:Create(main, TweenInfo.new(0.35), {Position = UDim2.new(0.5, -260, 1.2, 0)}):Play()
        state.hidden = true
        miniBtn.Visible = true
    end
end)

miniBtn.MouseButton1Click:Connect(function()
    playClick()
    if state.hidden then
        TweenService:Create(main, TweenInfo.new(0.35), {Position = UDim2.new(0.5, -260, 0.5, -180)}):Play()
        state.hidden = false
    else
        TweenService:Create(main, TweenInfo.new(0.35), {Position = UDim2.new(0.5, -260, 1.2, 0)}):Play()
        state.hidden = true
    end
end)

-- Close
btnClose.MouseButton1Click:Connect(function()
    playClick()
    screenGui:Destroy()
end)

-- Sidebar navigation
iconMain.MouseButton1Click:Connect(function() playClick()
    for _, frame in pairs(content:GetChildren()) do if frame:IsA("Frame") then frame.Visible = false end end
    panelMain.Visible = true
end)
iconMove.MouseButton1Click:Connect(function() playClick()
    for _, frame in pairs(content:GetChildren()) do if frame:IsA("Frame") then frame.Visible = false end end
    panelMove.Visible = true
end)
iconUtil.MouseButton1Click:Connect(function() playClick()
    for _, frame in pairs(content:GetChildren()) do if frame:IsA("Frame") then frame.Visible = false end end
    panelUtil.Visible = true
end)
iconSet.MouseButton1Click:Connect(function() playClick()
    for _, frame in pairs(content:GetChildren()) do if frame:IsA("Frame") then frame.Visible = false end end
    panelSet.Visible = true
end)

-- default visible
for _, f in pairs(content:GetChildren()) do if f:IsA("Frame") then f.Visible = false end end
panelMove.Visible = true

-- Cleanup on character respawn (restore walk/jump & stop freecam)
player.CharacterAdded:Connect(function()
    task.delay(0.5, function()
        local hum = getHumanoid()
        if hum then
            pcall(function()
                hum.WalkSpeed = state.walkSpeed or 16
                hum.JumpPower = state.jumpPower or 50
            end)
        end
        stopFreecam()
        if state.noclip then enableNoclip() end
    end)
end)

print("[LEX HOST VIP — Studio Edition] Loaded (dev-only, safe).")
