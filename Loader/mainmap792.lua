-- LEX VIP - Ocean Edition (All-in-one)
-- Generated: 01/11/2025
-- Place this LocalScript in StarterGui (or execute in a LocalScript environment)
-- ⚠️ USE AT YOUR OWN RISK ⚠️

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Main table
local LexHost = {}
LexHost.Version = "2.5.0"
LexHost.Enabled = {
    Fly = false,
    Speed = false,
    Noclip = false,
    ESP = false,
    AutoFarm = false,
}
LexHost.FlySpeed = 45
LexHost.SpeedMultiplier = 2
LexHost.OriginalSpeed = Humanoid.WalkSpeed

-- Utility: quick instance creator
local function new(class, props)
    local o = Instance.new(class)
    if props then
        for k,v in pairs(props) do
            if k == "Parent" then
                o.Parent = v
            else
                o[k] = v
            end
        end
    end
    return o
end

-- ---------- Feature Logic (UI-only control) ----------

-- FLY (uses BodyVelocity + BodyGyro)
do
    local bodyVelocity, bodyGyro, conn
    function LexHost.ToggleFly(state)
        -- state = true/false or nil to toggle
        if state == nil then state = not LexHost.Enabled.Fly end
        LexHost.Enabled.Fly = state
        if state then
            -- create controllers
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Name = "LexFly"
            bodyVelocity.MaxForce = Vector3.new(9e9,9e9,9e9)
            bodyVelocity.Velocity = Vector3.new(0,0,0)
            bodyVelocity.Parent = RootPart

            bodyGyro = Instance.new("BodyGyro")
            bodyGyro.Name = "LexGyro"
            bodyGyro.MaxTorque = Vector3.new(9e9,9e9,9e9)
            bodyGyro.P = 9e9
            bodyGyro.Parent = RootPart

            conn = RunService.Heartbeat:Connect(function()
                if not LexHost.Enabled.Fly then return end
                local cam = Workspace.CurrentCamera
                if not cam then return end
                local mv = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then mv = mv + cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then mv = mv - cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then mv = mv - cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then mv = mv + cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then mv = mv + Vector3.new(0,1,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then mv = mv - Vector3.new(0,1,0) end

                if RootPart:FindFirstChild("LexFly") then
                    if mv.Magnitude > 0 then
                        RootPart.LexFly.Velocity = mv.Unit * LexHost.FlySpeed
                    else
                        RootPart.LexFly.Velocity = Vector3.new(0,0,0)
                    end
                end
                if RootPart:FindFirstChild("LexGyro") and cam then
                    RootPart.LexGyro.CFrame = cam.CFrame
                end
            end)
        else
            if conn then conn:Disconnect(); conn = nil end
            if bodyVelocity and bodyVelocity.Parent then bodyVelocity:Destroy() end
            if bodyGyro and bodyGyro.Parent then bodyGyro:Destroy() end
        end
    end
end

-- SPEED (WalkSpeed multiplier)
do
    function LexHost.ToggleSpeed(state)
        if state == nil then state = not LexHost.Enabled.Speed end
        LexHost.Enabled.Speed = state
        if state then
            Humanoid.WalkSpeed = LexHost.OriginalSpeed * LexHost.SpeedMultiplier
        else
            Humanoid.WalkSpeed = LexHost.OriginalSpeed
        end
    end
    function LexHost.SetSpeedMultiplier(val)
        LexHost.SpeedMultiplier = val
        if LexHost.Enabled.Speed then
            Humanoid.WalkSpeed = LexHost.OriginalSpeed * LexHost.SpeedMultiplier
        end
    end
end

-- NOCLIP
do
    LexHost.ToggleNoclip = function(state)
        if state == nil then state = not LexHost.Enabled.Noclip end
        LexHost.Enabled.Noclip = state
        -- behavior enforced in Stepped
    end
    RunService.Stepped:Connect(function()
        if LexHost.Enabled.Noclip and Character and Character.Parent then
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

-- CLICK TELEPORT (teleport to mouse hit)
do
    local mouse = LocalPlayer:GetMouse()
    function LexHost.ClickTeleport()
        if mouse and mouse.Target and mouse.Hit then
            pcall(function()
                RootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0,3,0))
            end)
        end
    end
end

-- ESP (Billboards + Highlight)
do
    local espConnections = {}
    local function addESPTo(player)
        if player == LocalPlayer then return end
        local function attach(character)
            if not character then return end
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            if hrp:FindFirstChild("LEX_ESP_GUI") then return end

            local billboard = Instance.new("BillboardGui")
            billboard.Name = "LEX_ESP_GUI"
            billboard.Size = UDim2.new(0,120,0,50)
            billboard.StudsOffset = Vector3.new(0,3,0)
            billboard.AlwaysOnTop = true
            billboard.Parent = hrp

            local frame = Instance.new("Frame", billboard)
            frame.Size = UDim2.new(1,0,1,0)
            frame.BackgroundTransparency = 1

            local nameLabel = Instance.new("TextLabel", frame)
            nameLabel.Size = UDim2.new(1,0,0.5,0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = player.Name
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.TextScaled = true
            nameLabel.TextColor3 = Color3.fromRGB(200,240,255)

            local distLabel = Instance.new("TextLabel", frame)
            distLabel.Size = UDim2.new(1,0,0.5,0)
            distLabel.Position = UDim2.new(0,0,0.5,0)
            distLabel.BackgroundTransparency = 1
            distLabel.Font = Enum.Font.Gotham
            distLabel.TextScaled = true
            distLabel.TextColor3 = Color3.fromRGB(170,230,220)

            local highlight = Instance.new("Highlight", character)
            highlight.Name = "LEX_HIGHLIGHT"
            highlight.FillColor = Color3.fromRGB(120,170,255)
            highlight.OutlineColor = Color3.fromRGB(20,120,255)
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0

            local hb = RunService.Heartbeat:Connect(function()
                if hrp and RootPart then
                    local d = (hrp.Position - RootPart.Position).Magnitude
                    distLabel.Text = math.floor(d) .. "m"
                end
            end)
            table.insert(espConnections, hb)
        end

        if player.Character then attach(player.Character) end
        player.CharacterAdded:Connect(attach)
    end

    function LexHost.ToggleESP(state)
        if state == nil then state = not LexHost.Enabled.ESP end
        LexHost.Enabled.ESP = state
        if state then
            for _, p in pairs(Players:GetPlayers()) do addESPTo(p) end
            Players.PlayerAdded:Connect(addESPTo)
        else
            -- cleanup
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character then
                    for _, v in pairs(p.Character:GetDescendants()) do
                        if v.Name == "LEX_ESP_GUI" or v.Name == "LEX_HIGHLIGHT" then
                            pcall(function() v:Destroy() end)
                        end
                    end
                end
            end
            for _, c in pairs(espConnections) do
                if c then c:Disconnect() end
            end
            espConnections = {}
        end
    end
end

-- FULLBRIGHT & WEATHER
do
    function LexHost.EnableFullbright()
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
    end
    LexHost.EnableFullbright()
end

-- REMOVE TEXTURES (one-time)
spawn(function()
    for _, obj in pairs(Workspace:GetDescendants()) do
        pcall(function()
            if obj:IsA("Decal") or obj:IsA("Texture") then obj:Destroy() end
            if obj:IsA("BasePart") then obj.Material = Enum.Material.SmoothPlastic end
        end)
    end
end)

-- GOD MODE
do
    local function enableGod()
        Humanoid.MaxHealth = math.huge
        Humanoid.Health = math.huge
    end
    enableGod()
    Humanoid.HealthChanged:Connect(function(h)
        if h < math.huge then
            Humanoid.Health = math.huge
        end
    end)
end

-- INFINITE JUMP
UserInputService.JumpRequest:Connect(function()
    pcall(function() Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end)
end)

-- AUTO FARM (collect by name)
do
    local function autoCollect()
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name and (string.find(obj.Name:lower(),"coin") or string.find(obj.Name:lower(),"gem") or string.find(obj.Name:lower(),"collect")) then
                if obj.CanCollide then
                    pcall(function()
                        firetouchinterest(RootPart, obj, 0)
                        task.wait(0.06)
                        firetouchinterest(RootPart, obj, 1)
                    end)
                end
            end
        end
    end
    RunService.Heartbeat:Connect(function()
        if LexHost.Enabled.AutoFarm then
            pcall(autoCollect)
        end
    end)
end

-- REMOVE PARTS FUNCTION
function LexHost.RemovePartsByNames(names)
    if type(names) ~= "table" then return end
    for _, obj in pairs(Workspace:GetDescendants()) do
        local ok, nm = pcall(function() return obj.Name:lower() end)
        if ok and nm then
            for _, target in pairs(names) do
                if nm == target or string.find(nm, target) then
                    pcall(function() obj:Destroy() end)
                end
            end
        end
    end
end

-- ---------- UI (500x400 center, blue ocean theme) ----------

-- Cleanup any existing UI with same name
local existing = PlayerGui:FindFirstChild("LEX_VIP_UI")
if existing then existing:Destroy() end

-- Blur effect in Lighting (shared)
local blur = Lighting:FindFirstChild("LEX_VIP_Blur")
if not blur then
    blur = Instance.new("BlurEffect")
    blur.Name = "LEX_VIP_Blur"
    blur.Size = 0
    blur.Parent = Lighting
end

-- ScreenGui
local screenGui = new("ScreenGui", {Parent = PlayerGui, Name = "LEX_VIP_UI", ResetOnSpawn = false})
screenGui.IgnoreGuiInset = true

-- Main frame container
local main = new("Frame", {
    Parent = screenGui,
    Name = "Main",
    AnchorPoint = Vector2.new(0.5,0.5),
    Position = UDim2.new(0.5, 0.5, 0.5, 0),
    Size = UDim2.new(0,500,0,400),
    BackgroundColor3 = Color3.fromRGB(18, 32, 61), -- deep navy base
    BorderSizePixel = 0,
})
new("UICorner", {Parent = main, CornerRadius = UDim.new(0,12)})
new("UIStroke", {Parent = main, Color = Color3.fromRGB(35,85,160), Thickness = 1})

-- Top bar (title + buttons)
local topBar = new("Frame", {Parent = main, Size = UDim2.new(1,0,0,56), BackgroundTransparency = 1})
local title = new("TextLabel", {
    Parent = topBar,
    Position = UDim2.new(0,18,0,12),
    Size = UDim2.new(0.6,0,0,32),
    BackgroundTransparency = 1,
    Text = "LEX VIP",
    Font = Enum.Font.GothamBold,
    TextSize = 20,
    TextColor3 = Color3.fromRGB(200,230,255),
    TextXAlignment = Enum.TextXAlignment.Left
})
local subtitle = new("TextLabel", {
    Parent = topBar,
    Position = UDim2.new(0,18,0,30),
    Size = UDim2.new(0.6,0,0,18),
    BackgroundTransparency = 1,
    Text = "LEX HOST VIP  •  v"..LexHost.Version,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextColor3 = Color3.fromRGB(150,190,230),
    TextXAlignment = Enum.TextXAlignment.Left
})

-- Close & Minimize
local btnClose = new("TextButton", {
    Parent = topBar, Size = UDim2.new(0,36,0,28), Position = UDim2.new(1,-48,0,14),
    BackgroundColor3 = Color3.fromRGB(220,70,70), Text = "X", Font = Enum.Font.GothamBold, TextSize = 16, TextColor3 = Color3.fromRGB(255,255,255)
})
new("UICorner", {Parent = btnClose, CornerRadius = UDim.new(0,6)})
local btnMin = new("TextButton", {
    Parent = topBar, Size = UDim2.new(0,36,0,28), Position = UDim2.new(1,-92,0,14),
    BackgroundColor3 = Color3.fromRGB(45,95,170), Text = "-", Font = Enum.Font.GothamBold, TextSize = 18, TextColor3 = Color3.fromRGB(255,255,255)
})
new("UICorner", {Parent = btnMin, CornerRadius = UDim.new(0,6)})

-- Body layout
local body = new("Frame", {Parent = main, Position = UDim2.new(0,12,0,64), Size = UDim2.new(1,-24,1,-76), BackgroundTransparency = 1})

-- Left menu
local left = new("Frame", {Parent = body, Size = UDim2.new(0,140,1,0), BackgroundTransparency = 1})
new("Frame", {Parent = left, Size = UDim2.new(1,0,1,0), BackgroundColor3 = Color3.fromRGB(12,24,46), BorderSizePixel = 0})
new("UICorner", {Parent = left, CornerRadius = UDim.new(0,10)})

-- Right content area
local right = new("Frame", {Parent = body, Size = UDim2.new(1, -156, 1, 0), Position = UDim2.new(0,150,0,0), BackgroundTransparency = 1})

-- Menu buttons (Left)
local menuList = {
    {Key="Home", Label="Home"},
    {Key="Movement", Label="Movement"},
    {Key="Utilities", Label="Utilities"},
    {Key="World", Label="World"},
    {Key="Misc", Label="Misc"},
}
local menuButtons = {}
for i, data in ipairs(menuList) do
    local btn = new("TextButton", {
        Parent = left,
        Size = UDim2.new(1, -24, 0, 46),
        Position = UDim2.new(0,12,0, 12 + (i-1)*56),
        BackgroundColor3 = Color3.fromRGB(18,40,72),
        Text = data.Label,
        Font = Enum.Font.Gotham,
        TextSize = 15,
        TextColor3 = Color3.fromRGB(210,230,255)
    })
    new("UICorner", {Parent = btn, CornerRadius = UDim.new(0,8)})
    menuButtons[data.Key] = btn
end

-- Helpers to clear right area
local function clearRight()
    for _, c in pairs(right:GetChildren()) do
        if not c:IsA("UIListLayout") then pcall(function() c:Destroy() end) end
    end
end

-- Small UI widget constructors
local function makeToggle(parent, labelText, initial, onChange)
    local cont = new("Frame", {Parent = parent, Size = UDim2.new(1, -12, 0, 44), BackgroundTransparency = 1})
    local lbl = new("TextLabel", {Parent = cont, Size = UDim2.new(0.7,0,1,0), BackgroundTransparency = 1, Text = labelText, Font = Enum.Font.Gotham, TextSize = 15, TextColor3 = Color3.fromRGB(220,240,255), TextXAlignment = Enum.TextXAlignment.Left})
    local btn = new("TextButton", {Parent = cont, Size = UDim2.new(0,70,0,30), Position = UDim2.new(1,-74,0.5,-15), BackgroundColor3 = initial and Color3.fromRGB(70,200,255) or Color3.fromRGB(70,70,90), Text = initial and "ON" or "OFF", Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = Color3.fromRGB(10,10,20)})
    new("UICorner", {Parent = btn, CornerRadius = UDim.new(0,8)})
    btn.MouseButton1Click:Connect(function()
        local newState = not (btn.Text == "ON")
        btn.Text = newState and "ON" or "OFF"
        btn.BackgroundColor3 = newState and Color3.fromRGB(70,200,255) or Color3.fromRGB(70,70,90)
        pcall(onChange, newState)
    end)
    return cont
end

local function makeSlider(parent, labelText, minv, maxv, initial, onChange)
    local cont = new("Frame", {Parent = parent, Size = UDim2.new(1, -12, 0, 62), BackgroundTransparency = 1})
    new("TextLabel", {Parent = cont, Position = UDim2.new(0,0,0,0), Size = UDim2.new(0.6,0,0,0), BackgroundTransparency = 1})
    local lbl = new("TextLabel", {Parent = cont, Position = UDim2.new(0,0,0,0), Size = UDim2.new(0.6,0,0,22), BackgroundTransparency = 1, Text = labelText, Font = Enum.Font.Gotham, TextSize = 14, TextColor3 = Color3.fromRGB(210,230,255), TextXAlignment = Enum.TextXAlignment.Left})
    local valLbl = new("TextLabel", {Parent = cont, Position = UDim2.new(0.6,0,0,0), Size = UDim2.new(0.4,-12,0,22), BackgroundTransparency = 1, Text = tostring(initial), Font = Enum.Font.Gotham, TextSize = 14, TextColor3 = Color3.fromRGB(180,210,235), TextXAlignment = Enum.TextXAlignment.Right})
    local bar = new("Frame", {Parent = cont, Position = UDim2.new(0,6,0,28), Size = UDim2.new(1,-12,0,14), BackgroundColor3 = Color3.fromRGB(23,44,76)})
    new("UICorner", {Parent = bar, CornerRadius = UDim.new(0,8)})
    local fill = new("Frame", {Parent = bar, Size = UDim2.new((initial-minv)/(maxv-minv),0,1,0), BackgroundColor3 = Color3.fromRGB(70,150,255)})
    new("UICorner", {Parent = fill, CornerRadius = UDim.new(0,8)})
    local dragging = false
    local function update(x)
        local rel = math.clamp(x - bar.AbsolutePosition.X, 0, bar.AbsoluteSize.X)
        local ratio = rel / bar.AbsoluteSize.X
        fill.Size = UDim2.new(ratio,0,1,0)
        local val = math.floor((minv + (maxv-minv)*ratio)*100)/100
        valLbl.Text = tostring(val)
        pcall(onChange, val)
    end
    bar.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            update(inp.Position.X)
        end
    end)
    bar.InputChanged:Connect(function(inp)
        if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
            update(inp.Position.X)
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    return cont
end

-- Build pages
local function showHome()
    clearRight()
    new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,6), Size = UDim2.new(1,-16,0,28), BackgroundTransparency = 1, Text = "Welcome to LEX VIP", Font = Enum.Font.GothamBold, TextSize = 18, TextColor3 = Color3.fromRGB(220,240,255)})
    new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,42), Size = UDim2.new(1,-16,0,48), BackgroundTransparency = 1, Text = "Ocean Edition — centralized control panel for LEX HOST VIP features. Use toggles and sliders to control behavior. Minimize to hide the panel.", Font = Enum.Font.Gotham, TextSize = 13, TextColor3 = Color3.fromRGB(170,200,230), TextWrapped = true})
end

local function showMovement()
    clearRight()
    new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,6), Size = UDim2.new(1,-16,0,28), BackgroundTransparency = 1, Text = "Movement", Font = Enum.Font.GothamBold, TextSize = 16, TextColor3 = Color3.fromRGB(220,240,255)})
    local fly = makeToggle(right, "Fly (uses WASD + Space/Shift while Fly enabled)", LexHost.Enabled.Fly, function(state) LexHost.ToggleFly(state) end)
    fly.Parent = right
    local noclip = makeToggle(right, "Noclip", LexHost.Enabled.Noclip, function(state) LexHost.ToggleNoclip(state) end)
    noclip.Parent = right
    local speedToggle = makeToggle(right, "Speed Hack", LexHost.Enabled.Speed, function(state) LexHost.ToggleSpeed(state) end)
    speedToggle.Parent = right
    local speedSlider = makeSlider(right, "Speed Multiplier", 1, 12, LexHost.SpeedMultiplier, function(val) LexHost.SetSpeedMultiplier(val) end)
    speedSlider.Parent = right

    local tpBtn = new("TextButton", {Parent = right, Position = UDim2.new(0,8,0,220), Size = UDim2.new(1,-16,0,40), BackgroundColor3 = Color3.fromRGB(55,110,210), Text = "Click Teleport (use mouse)", Font = Enum.Font.GothamBold, TextSize = 16, TextColor3 = Color3.fromRGB(255,255,255)})
    new("UICorner", {Parent = tpBtn, CornerRadius = UDim.new(0,8)})
    tpBtn.MouseButton1Click:Connect(function() LexHost.ClickTeleport() end)
end

local function showUtilities()
    clearRight()
    new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,6), Size = UDim2.new(1,-16,0,28), BackgroundTransparency = 1, Text = "Utilities", Font = Enum.Font.GothamBold, TextSize = 16, TextColor3 = Color3.fromRGB(220,240,255)})
    local esp = makeToggle(right, "ESP (billboards + highlight)", LexHost.Enabled.ESP, function(state) LexHost.ToggleESP(state) end)
    esp.Parent = right
    local full = makeToggle(right, "Fullbright (environment)", true, function(state) if state then LexHost.EnableFullbright() end end)
    full.Parent = right
    local god = makeToggle(right, "God Mode", true, function(state)
        if state then
            Humanoid.MaxHealth = math.huge; Humanoid.Health = math.huge
        else
            Humanoid.MaxHealth = 100; Humanoid.Health = 100
        end
    end)
    god.Parent = right
    local auto = makeToggle(right, "Auto Farm (collect items automatically)", LexHost.Enabled.AutoFarm, function(state) LexHost.Enabled.AutoFarm = state end)
    auto.Parent = right
end

local function showWorld()
    clearRight()
    new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,6), Size = UDim2.new(1,-16,0,28), BackgroundTransparency = 1, Text = "World Tools", Font = Enum.Font.GothamBold, TextSize = 16, TextColor3 = Color3.fromRGB(220,240,255)})
    new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,42), Size = UDim2.new(1,-16,0,36), BackgroundTransparency = 1, Text = "Enter part names (comma-separated). Example: wood,block,ladder", Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = Color3.fromRGB(170,200,230), TextWrapped = true})
    local input = new("TextBox", {Parent = right, Position = UDim2.new(0,8,0,86), Size = UDim2.new(1,-16,0,36), BackgroundColor3 = Color3.fromRGB(12,24,46), Text = "", Font = Enum.Font.Gotham, TextSize = 14, TextColor3 = Color3.fromRGB(220,240,255)})
    new("UICorner", {Parent = input, CornerRadius = UDim.new(0,8)})
    local remBtn = new("TextButton", {Parent = right, Position = UDim2.new(0,8,0,132), Size = UDim2.new(1,-16,0,36), BackgroundColor3 = Color3.fromRGB(180,60,60), Text = "Remove Parts", Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = Color3.fromRGB(255,255,255)})
    new("UICorner", {Parent = remBtn, CornerRadius = UDim.new(0,8)})
    remBtn.MouseButton1Click:Connect(function()
        local text = input.Text or ""
        if text == "" then
            -- quick feedback
            local tmp = new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,176), Size = UDim2.new(1,-16,0,24), BackgroundTransparency = 1, Text = "Enter names to remove.", Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = Color3.fromRGB(240,200,200)})
            delay(2, function() if tmp and tmp.Parent then tmp:Destroy() end end)
            return
        end
        local parts = {}
        for s in string.gmatch(text:lower(), "[^,]+") do
            s = s:match("^%s*(.-)%s*$")
            if #s > 0 then table.insert(parts, s) end
        end
        LexHost.RemovePartsByNames(parts)
        local ok = new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,176), Size = UDim2.new(1,-16,0,24), BackgroundTransparency = 1, Text = "Requested remove: "..table.concat(parts, ", "), Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = Color3.fromRGB(200,240,200)})
        delay(3, function() if ok and ok.Parent then ok:Destroy() end end)
    end)
end

local function showMisc()
    clearRight()
    new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,6), Size = UDim2.new(1,-16,0,28), BackgroundTransparency = 1, Text = "Misc", Font = Enum.Font.GothamBold, TextSize = 16, TextColor3 = Color3.fromRGB(220,240,255)})
    local blurToggle = makeToggle(right, "Background Blur (menu)", false, function(state)
        if state then
            -- tween blur in
            spawn(function()
                for i = blur.Size, 12, 1 do blur.Size = i; task.wait(0.01) end
            end)
        else
            spawn(function()
                for i = blur.Size, 0, -1 do blur.Size = i; task.wait(0.01) end
            end)
        end
    end)
    blurToggle.Parent = right

    local hideReplay = makeToggle(right, "Attempt hide 'Replay' GUIs (if any)", false, function(state)
        if state then
            for _, g in pairs(PlayerGui:GetChildren()) do
                local name = g.Name:lower()
                if name:find("replay") or name:find("record") then
                    pcall(function() g.Enabled = false end)
                end
            end
        else
            -- cannot reliably restore unknown third-party GUIs
            print("[LEX VIP] Replay hiding toggled OFF (manual restore may be required).")
        end
    end)
    hideReplay.Parent = right
end

-- Connect menu clicks
menuButtons["Home"].MouseButton1Click:Connect(showHome)
menuButtons["Movement"].MouseButton1Click:Connect(showMovement)
menuButtons["Utilities"].MouseButton1Click:Connect(showUtilities)
menuButtons["World"].MouseButton1Click:Connect(showWorld)
menuButtons["Misc"].MouseButton1Click:Connect(showMisc)

-- Default page
showHome()

-- Make main draggable (from topBar)
do
    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    topBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then update(input) end
    end)
end

-- Minimize / close behavior (with animations)
local minimized = false
local stub
btnClose.MouseButton1Click:Connect(function()
    pcall(function() screenGui:Destroy() end)
    if blur and blur.Parent then blur.Size = 0 end
end)
btnMin.MouseButton1Click:Connect(function()
    if not minimized then
        -- minimize: animate shrink + hide contents
        local shrink = TweenService:Create(main, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 220, 0, 46)})
        shrink:Play()
        for _, child in pairs(main:GetChildren()) do
            if child ~= topBar then
                child.Visible = false
            end
        end
        minimized = true
        -- create stub to restore
        if not stub or not stub.Parent then
            stub = new("TextButton", {Parent = screenGui, Size = UDim2.new(0,160,0,38), Position = UDim2.new(0.5,-80,0.9,0), AnchorPoint = Vector2.new(0.5,0.5), BackgroundColor3 = Color3.fromRGB(20,40,75), Text = "LEX VIP (Click to restore)", Font = Enum.Font.Gotham, TextSize = 14, TextColor3 = Color3.fromRGB(210,230,255)})
            new("UICorner", {Parent = stub, CornerRadius = UDim.new(0,8)})
            stub.MouseButton1Click:Connect(function()
                local expand = TweenService:Create(main, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0,500,0,400)})
                expand:Play()
                for _, child in pairs(main:GetChildren()) do child.Visible = true end
                minimized = false
                if stub and stub.Parent then stub:Destroy(); stub = nil end
            end)
        end
    else
        -- restore
        if stub and stub.Parent then stub:Destroy(); stub = nil end
        local expand = TweenService:Create(main, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0,500,0,400)})
        expand:Play()
        for _, child in pairs(main:GetChildren()) do child.Visible = true end
        minimized = false
    end
end)

-- Open animation + blur fade-in
do
    main.Position = UDim2.new(0.5, 0, -0.5, 0)
    main.Visible = true
    local t1 = TweenService:Create(main, TweenInfo.new(0.33, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0.5, 0)})
    t1:Play()
    -- blur tween
    spawn(function()
        for i=0,12,1 do blur.Size = i; task.wait(0.01) end
    end)
end

-- Final prints
print("[LEX VIP] UI loaded. Version: "..LexHost.Version)
