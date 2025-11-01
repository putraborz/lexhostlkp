-- LEX Host v3 - Cyber Neon Blue (Full functional)
-- Put this LocalScript into StarterGui
-- Use at your own risk.

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- UTIL
local function new(class, props)
    local o = Instance.new(class)
    if props then
        for k,v in pairs(props) do
            if k == "Parent" then o.Parent = v else o[k] = v end
        end
    end
    return o
end

-- MAIN FEATURES (gameplay helpers)
local LexHost = {}
LexHost.Version = "3.0-cyber"
LexHost.Enabled = { Fly=false, Speed=false, Noclip=false, ESP=false, AutoFarm=false, AirWalk=false }
LexHost.FlySpeed = 45
LexHost.SpeedMultiplier = 2
LexHost.OriginalWalkSpeed = nil

-- references (character)
local function getChar()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function getHumanoid()
    local char = LocalPlayer.Character
    if char then return char:FindFirstChildOfClass("Humanoid") end
end

local function getRoot()
    local char = LocalPlayer.Character
    if char then return char:FindFirstChild("HumanoidRootPart") end
end

-- FLY
do
    local bv, bg, conn
    function LexHost.ToggleFly(state)
        state = (state == nil) and not LexHost.Enabled.Fly or state
        LexHost.Enabled.Fly = state
        local root = getRoot()
        if state then
            if not root then return end
            bv = Instance.new("BodyVelocity"); bv.Name="LEX_FLY_BV"; bv.MaxForce = Vector3.new(9e9,9e9,9e9); bv.Parent = root
            bg = Instance.new("BodyGyro"); bg.Name="LEX_FLY_BG"; bg.MaxTorque = Vector3.new(9e9,9e9,9e9); bg.P = 9e9; bg.Parent = root
            conn = RunService.Heartbeat:Connect(function()
                if not LexHost.Enabled.Fly then return end
                local cam = Workspace.CurrentCamera
                if not cam or not root then return end
                local mv = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then mv = mv + cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then mv = mv - cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then mv = mv - cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then mv = mv + cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then mv = mv + Vector3.new(0,1,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then mv = mv - Vector3.new(0,1,0) end
                if mv.Magnitude > 0 then
                    root.LEX_FLY_BV.Velocity = mv.Unit * LexHost.FlySpeed
                else
                    root.LEX_FLY_BV.Velocity = Vector3.new(0,0,0)
                end
                if root:FindFirstChild("LEX_FLY_BG") and cam then
                    root.LEX_FLY_BG.CFrame = cam.CFrame
                end
            end)
        else
            if conn then conn:Disconnect(); conn = nil end
            if bv and bv.Parent then bv:Destroy() end
            if bg and bg.Parent then bg:Destroy() end
        end
    end
end

-- SPEED
do
    function LexHost.ToggleSpeed(state)
        state = (state == nil) and not LexHost.Enabled.Speed or state
        LexHost.Enabled.Speed = state
        local hum = getHumanoid()
        if not LexHost.OriginalWalkSpeed and hum then LexHost.OriginalWalkSpeed = hum.WalkSpeed end
        if hum then
            if LexHost.Enabled.Speed then hum.WalkSpeed = (LexHost.OriginalWalkSpeed or 16) * LexHost.SpeedMultiplier
            else hum.WalkSpeed = (LexHost.OriginalWalkSpeed or 16) end
        end
    end
    function LexHost.SetSpeedMultiplier(v)
        LexHost.SpeedMultiplier = v or 2
        if LexHost.Enabled.Speed then
            local hum = getHumanoid()
            if hum then hum.WalkSpeed = (LexHost.OriginalWalkSpeed or 16) * LexHost.SpeedMultiplier end
        end
    end
end

-- NOCLIP
do
    function LexHost.ToggleNoclip(state)
        state = (state == nil) and not LexHost.Enabled.Noclip or state
        LexHost.Enabled.Noclip = state
    end
    RunService.Stepped:Connect(function()
        if LexHost.Enabled.Noclip then
            local char = LocalPlayer.Character
            if char then
                for _,p in pairs(char:GetDescendants()) do
                    if p:IsA("BasePart") then
                        p.CanCollide = false
                    end
                end
            end
        end
    end)
end

-- AIRWALK
do
    local bv,bg,conn, targetY
    local function setNoclip(bool)
        local char = LocalPlayer.Character
        if char then
            for _,p in pairs(char:GetDescendants()) do
                if p:IsA("BasePart") then
                    p.CanCollide = not bool
                end
            end
        end
    end
    function LexHost.ToggleAirWalk(state)
        state = (state == nil) and not LexHost.Enabled.AirWalk or state
        LexHost.Enabled.AirWalk = state
        local root = getRoot()
        if state then
            if not root then return end
            targetY = root.Position.Y
            setNoclip(true)
            bv = Instance.new("BodyVelocity"); bv.Name="LEX_AW_BV"; bv.MaxForce = Vector3.new(9e9,9e9,9e9); bv.Parent = root
            bg = Instance.new("BodyGyro"); bg.Name="LEX_AW_BG"; bg.MaxTorque = Vector3.new(9e9,9e9,9e9); bg.P = 9e8; bg.Parent = root
            conn = RunService.Heartbeat:Connect(function()
                if not LexHost.Enabled.AirWalk then return end
                local cam = Workspace.CurrentCamera
                if not cam or not root then return end
                local mv = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then mv = mv + cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then mv = mv - cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then mv = mv - cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then mv = mv + cam.CFrame.RightVector end
                mv = Vector3.new(mv.X,0,mv.Z)
                local speed = LexHost.FlySpeed
                if LexHost.Enabled.Speed then speed = speed * (LexHost.SpeedMultiplier/2) end
                if mv.Magnitude > 0 then
                    bv.Velocity = mv.Unit * speed
                else
                    bv.Velocity = Vector3.new(0,0,0)
                end
                local dy = targetY - root.Position.Y
                local vy = math.clamp(dy * 8, -50, 50)
                bv.Velocity = Vector3.new(bv.Velocity.X, vy, bv.Velocity.Z)
                if bg and Workspace.CurrentCamera then
                    bg.CFrame = CFrame.new(root.Position, root.Position + Workspace.CurrentCamera.CFrame.LookVector)
                end
            end)
        else
            if conn then conn:Disconnect(); conn=nil end
            if bv and bv.Parent then bv:Destroy() end
            if bg and bg.Parent then bg:Destroy() end
            setNoclip(false)
        end
    end
end

-- CLICK TELEPORT
function LexHost.ClickTeleport()
    local mouse = LocalPlayer:GetMouse()
    if mouse and mouse.Target and mouse.Hit then
        pcall(function() local root = getRoot(); if root then root.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0,3,0)) end end)
    end
end

-- ESP (basic)
do
    local espConnections = {}
    function LexHost.ToggleESP(state)
        state = (state == nil) and not LexHost.Enabled.ESP or state
        LexHost.Enabled.ESP = state
        if state then
            for _,p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then
                    local function attach(char)
                        if not char then return end
                        local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
                        if hrp:FindFirstChild("LEX_ESP_GUI") then return end
                        local billboard = Instance.new("BillboardGui", hrp)
                        billboard.Name = "LEX_ESP_GUI"; billboard.Size=UDim2.new(0,120,0,50); billboard.StudsOffset=Vector3.new(0,3,0); billboard.AlwaysOnTop=true
                        local frame = Instance.new("Frame", billboard); frame.Size=UDim2.new(1,0,1,0); frame.BackgroundTransparency=1
                        local nameLabel = Instance.new("TextLabel", frame); nameLabel.Size=UDim2.new(1,0,0,22); nameLabel.BackgroundTransparency=1; nameLabel.Font=Enum.Font.GothamBold; nameLabel.TextScaled=true; nameLabel.TextColor3=Color3.fromRGB(190,230,255); nameLabel.Text = p.Name
                        local highlight = Instance.new("Highlight", char); highlight.Name="LEX_HL"; highlight.FillColor=Color3.fromRGB(120,160,255); highlight.OutlineColor=Color3.fromRGB(30,110,230); highlight.FillTransparency=0.6
                        local hb = RunService.Heartbeat:Connect(function()
                            if not hrp then return end
                        end)
                        table.insert(espConnections, hb)
                    end
                    if p.Character then attach(p.Character) end
                    p.CharacterAdded:Connect(attach)
                end
            end
        else
            for _,c in pairs(espConnections) do if c then c:Disconnect() end end
            espConnections = {}
            for _,p in pairs(Players:GetPlayers()) do
                if p.Character then
                    for _,v in pairs(p.Character:GetDescendants()) do
                        if v.Name == "LEX_ESP_GUI" or v.Name == "LEX_HL" then pcall(function() v:Destroy() end) end
                    end
                end
            end
        end
    end
end

-- FULLBRIGHT
function LexHost.EnableFullbright()
    pcall(function()
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
    end)
end
LexHost.EnableFullbright()

-- AUTO FARM (simple touch)
do
    RunService.Heartbeat:Connect(function()
        if LexHost.Enabled.AutoFarm then
            pcall(function()
                local root = getRoot()
                if not root then return end
                for _,obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and obj.Name then
                        local n = obj.Name:lower()
                        if n:find("coin") or n:find("gem") or n:find("collect") then
                            pcall(function()
                                firetouchinterest(root, obj, 0)
                                task.wait(0.06)
                                firetouchinterest(root, obj, 1)
                            end)
                        end
                    end
                end
            end)
        end
    end)
end

-- REMOVE PARTS
function LexHost.RemovePartsByNames(names)
    if type(names) ~= "table" then return end
    for _,obj in pairs(Workspace:GetDescendants()) do
        local ok, nm = pcall(function() return tostring(obj.Name):lower() end)
        if ok and nm then
            for _,target in pairs(names) do
                if nm == target or string.find(nm, target) then
                    pcall(function() obj:Destroy() end)
                end
            end
        end
    end
end

-- END FEATURES ----------------------------------------------------

-- UI BUILD -------------------------------------------------------
-- cleanup previous
local old = PlayerGui:FindFirstChild("LEX_HOST_GUI")
if old then old:Destroy() end

local screenGui = new("ScreenGui", {Parent = PlayerGui, Name = "LEX_HOST_GUI", ResetOnSpawn = false})
screenGui.IgnoreGuiInset = true

-- floating LX logo (tengah atas)
local lx = new("TextButton", {
    Parent = screenGui,
    Name = "LXLogo",
    Size = UDim2.new(0,72,0,38),
    Position = UDim2.new(0.5, 0, 0, 8),
    AnchorPoint = Vector2.new(0.5,0),
    BackgroundColor3 = Color3.fromRGB(10,8,24),
    Text = "LX",
    Font = Enum.Font.GothamBold,
    TextSize = 20,
    TextColor3 = Color3.fromRGB(170,200,255),
    BorderSizePixel = 0,
    ZIndex = 10000,
})
new("UICorner", {Parent = lx, CornerRadius = UDim.new(0,8)})
local lxStroke = new("UIStroke", {Parent = lx, Color = Color3.fromRGB(80,140,255), Thickness = 2})
lx.AutoButtonColor = false

-- main window
local main = new("Frame", {
    Parent = screenGui,
    Name = "MainWindow",
    Size = UDim2.new(0,560,0,420),
    Position = UDim2.new(0.5,0,0.5,0),
    AnchorPoint = Vector2.new(0.5,0.5),
    BackgroundColor3 = Color3.fromRGB(6,10,18),
    BorderSizePixel = 0,
    Visible = false,
    ZIndex = 9999
})
new("UICorner", {Parent = main, CornerRadius = UDim.new(0,14)})
local mainStroke = new("UIStroke", {Parent = main, Color = Color3.fromRGB(140,70,255), Thickness = 2}) -- neon accent
local topAccent = new("Frame", {Parent = main, Size = UDim2.new(1,0,0,6), Position = UDim2.new(0,0,0,0), BackgroundColor3 = Color3.fromRGB(40,120,255)})
topAccent.ZIndex = 10000

-- topbar (drag)
local topBar = new("Frame", {Parent = main, Size = UDim2.new(1,0,0,56), BackgroundTransparency = 1})
local title = new("TextLabel", {Parent = topBar, Position = UDim2.new(0,18,0,8), Size = UDim2.new(0.6,0,0,28), BackgroundTransparency = 1, Text = "LEX Host", Font = Enum.Font.GothamBold, TextSize = 20, TextColor3 = Color3.fromRGB(200,230,255), TextXAlignment = Enum.TextXAlignment.Left})
local subtitle = new("TextLabel", {Parent = topBar, Position = UDim2.new(0,18,0,28), Size = UDim2.new(0.6,0,0,18), BackgroundTransparency = 1, Text = "Cyber • v"..LexHost.Version, Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = Color3.fromRGB(150,190,230), TextXAlignment = Enum.TextXAlignment.Left})

-- control buttons
local btnMin = new("TextButton", {Parent = topBar, Size = UDim2.new(0,38,0,30), Position = UDim2.new(1,-100,0,12), BackgroundColor3 = Color3.fromRGB(20,110,220), Text = "-", Font = Enum.Font.GothamBold, TextSize = 20, TextColor3 = Color3.fromRGB(255,255,255)})
new("UICorner",{Parent=btnMin, CornerRadius = UDim.new(0,6)})
local btnClose = new("TextButton", {Parent = topBar, Size = UDim2.new(0,38,0,30), Position = UDim2.new(1,-50,0,12), BackgroundColor3 = Color3.fromRGB(200,60,80), Text = "X", Font = Enum.Font.GothamBold, TextSize = 16, TextColor3 = Color3.fromRGB(255,255,255)})
new("UICorner",{Parent=btnClose, CornerRadius = UDim.new(0,6)})

-- body
local body = new("Frame", {Parent = main, Position = UDim2.new(0,12,0,64), Size = UDim2.new(1,-24,1,-76), BackgroundTransparency = 1})

-- left nav
local left = new("Frame",{Parent=body, Size=UDim2.new(0,160,1,0), BackgroundTransparency=1})
new("Frame",{Parent=left, Size=UDim2.new(1,0,1,0), BackgroundColor3=Color3.fromRGB(8,16,30)})
new("UICorner",{Parent=left, CornerRadius = UDim.new(0,10)})

local menuKeys = {"Home","Modes","Movement","Utilities","Info"}
local menuButtons = {}
for i,k in ipairs(menuKeys) do
    local btn = new("TextButton", {Parent = left, Size=UDim2.new(1,-24,0,46), Position=UDim2.new(0,12,0,12 + (i-1)*56), BackgroundColor3=Color3.fromRGB(12,26,48), Text=k, Font=Enum.Font.Gotham, TextSize=15, TextColor3=Color3.fromRGB(210,230,255), BorderSizePixel=0})
    new("UICorner",{Parent=btn, CornerRadius=UDim.new(0,8)})
    menuButtons[k] = btn
end

-- right content
local right = new("Frame",{Parent=body, Size=UDim2.new(1,-176,1,0), Position=UDim2.new(0,170,0,0), BackgroundTransparency=1})
new("UICorner",{Parent=right, CornerRadius = UDim.new(0,8)})

-- helpers
local function clearRight()
    for _,c in pairs(right:GetChildren()) do
        if c.Name ~= "ModesScroll" and not c:IsA("UIListLayout") then pcall(function() c:Destroy() end) end
    end
end

-- persistent modes scroll
local function ensureModesScroll()
    local existing = right:FindFirstChild("ModesScroll")
    if existing and existing:IsA("ScrollingFrame") then return existing end
    local scr = new("ScrollingFrame",{Parent=right, Name="ModesScroll", Position=UDim2.new(0,8,0,84), Size=UDim2.new(1,-16,1,-92), CanvasSize=UDim2.new(0,0,0,0), ScrollBarThickness=8, BackgroundTransparency=1})
    local layout = new("UIListLayout", {Parent = scr})
    layout.Padding = UDim.new(0,10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scr.CanvasSize = UDim2.new(0,0,0, layout.AbsoluteContentSize.Y + 12)
    end)
    return scr
end

-- make mode button
local function makeModeButton(parent, text, callback)
    local btn = new("TextButton", {Parent = parent, Size = UDim2.new(1,0,0,36), BackgroundColor3 = Color3.fromRGB(28,58,106), Text = text, Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = Color3.fromRGB(230,245,255), BorderSizePixel = 0})
    new("UICorner",{Parent=btn, CornerRadius=UDim.new(0,8)})
    btn.MouseEnter:Connect(function() pcall(function() btn.BackgroundColor3 = Color3.fromRGB(48,98,156) end) end)
    btn.MouseLeave:Connect(function() pcall(function() btn.BackgroundColor3 = Color3.fromRGB(28,58,106) end) end)
    btn.MouseButton1Click:Connect(function() pcall(callback) end)
    return btn
end

-- build pages
local function showHome()
    clearRight()
    new("TextLabel", {Parent = right, Position=UDim2.new(0,8,0,6), Size=UDim2.new(1,-16,0,28), BackgroundTransparency=1, Text="Welcome to LEX Host (Cyber Neon)", Font=Enum.Font.GothamBold, TextSize=18, TextColor3=Color3.fromRGB(220,240,255)})
    new("TextLabel", {Parent = right, Position=UDim2.new(0,8,0,42), Size=UDim2.new(1,-16,0,64), BackgroundTransparency=1, Text="Klik 'Modes' untuk melihat daftar Gunung. Semua tombol movement & utilities aktif.", Font=Enum.Font.Gotham, TextSize=13, TextColor3=Color3.fromRGB(170,200,230), TextWrapped=true})
end

local function showModeList()
    clearRight()
    new("TextLabel", {Parent = right, Position=UDim2.new(0,8,0,6), Size=UDim2.new(1,-16,0,28), BackgroundTransparency=1, Text="Modes / Gunung", Font=Enum.Font.GothamBold, TextSize=16, TextColor3=Color3.fromRGB(220,240,255)})
    new("TextLabel", {Parent = right, Position=UDim2.new(0,8,0,36), Size=UDim2.new(1,-16,0,36), BackgroundTransparency=1, Text="Klik salah satu untuk menjalankan skrip.", Font=Enum.Font.Gotham, TextSize=12, TextColor3=Color3.fromRGB(170,200,230), TextWrapped=true})
    local scr = ensureModesScroll()
    -- clear existing buttons
    for _,c in pairs(scr:GetChildren()) do if c:IsA("TextButton") then pcall(function() c:Destroy() end) end end
    -- populate from scriptList
    for _,it in ipairs(scriptList) do
        makeModeButton(scr, it.name, function()
            local ok, err = pcall(function()
                local s = game:HttpGet(it.url)
                local f = loadstring(s)
                if type(f) == "function" then f() else error("Invalid loadstring") end
            end)
            if not ok then
                -- show error for 3s
                local lbl = new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0, scr.AbsolutePosition.Y + scr.AbsoluteSize.Y + 8), Size = UDim2.new(1,-16,0,20), BackgroundTransparency=1, Text="Gagal run: "..tostring(err), Font=Enum.Font.Gotham, TextSize=12, TextColor3=Color3.fromRGB(255,180,180)})
                delay(3, function() if lbl and lbl.Parent then lbl:Destroy() end end)
            end
        end)
    end
end

local function showMovement()
    clearRight()
    new("TextLabel", {Parent = right, Position=UDim2.new(0,8,0,6), Size=UDim2.new(1,-16,0,28), BackgroundTransparency=1, Text="Movement", Font=Enum.Font.GothamBold, TextSize=16, TextColor3=Color3.fromRGB(220,240,255)})
    -- fly toggle
    local flyToggle = new("TextButton", {Parent = right, Position=UDim2.new(0,8,0,48), Size=UDim2.new(0.45,-12,0,36), Text="Fly: OFF", Font=Enum.Font.GothamBold, TextSize=14, BackgroundColor3=Color3.fromRGB(30,60,90), TextColor3=Color3.fromRGB(230,245,255)})
    new("UICorner",{Parent=flyToggle, CornerRadius=UDim.new(0,8)})
    flyToggle.MouseButton1Click:Connect(function()
        LexHost.ToggleFly()
        flyToggle.Text = "Fly: "..(LexHost.Enabled.Fly and "ON" or "OFF")
        flyToggle.BackgroundColor3 = LexHost.Enabled.Fly and Color3.fromRGB(40,140,220) or Color3.fromRGB(30,60,90)
    end)
    -- speed toggle & slider
    local speedToggle = new("TextButton", {Parent = right, Position=UDim2.new(0.55,0,0,48), Size=UDim2.new(0.45,-12,0,36), Text="Speed: OFF", Font=Enum.Font.GothamBold, TextSize=14, BackgroundColor3=Color3.fromRGB(30,60,90), TextColor3=Color3.fromRGB(230,245,255)})
    new("UICorner",{Parent=speedToggle, CornerRadius=UDim.new(0,8)})
    speedToggle.MouseButton1Click:Connect(function()
        LexHost.ToggleSpeed()
        speedToggle.Text = "Speed: "..(LexHost.Enabled.Speed and "ON" or "OFF")
        speedToggle.BackgroundColor3 = LexHost.Enabled.Speed and Color3.fromRGB(40,140,220) or Color3.fromRGB(30,60,90)
    end)
    local sliderBar = new("Frame", {Parent= right, Position = UDim2.new(0,8,0,100), Size = UDim2.new(1,-16,0,18), BackgroundColor3 = Color3.fromRGB(15,30,60)})
    new("UICorner",{Parent=sliderBar, CornerRadius=UDim.new(0,8)})
    local fill = new("Frame",{Parent=sliderBar, Size=UDim2.new( (LexHost.SpeedMultiplier-1)/(12-1), 0, 1,0), BackgroundColor3=Color3.fromRGB(40,140,220)})
    new("UICorner",{Parent=fill, CornerRadius=UDim.new(0,8)})
    sliderBar.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            local function upd(posX)
                local rel = math.clamp(posX - sliderBar.AbsolutePosition.X, 0, sliderBar.AbsoluteSize.X)
                local ratio = rel/sliderBar.AbsoluteSize.X
                fill.Size = UDim2.new(ratio,0,1,0)
                local val = 1 + (12-1)*ratio
                LexHost.SetSpeedMultiplier(math.floor(val*100)/100)
            end
            upd(inp.Position.X)
            local conn
            conn = UserInputService.InputChanged:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseMovement then upd(i.Position.X) end
            end)
            UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 and conn then conn:Disconnect(); conn=nil end
            end)
        end
    end)

    -- noclip and airwalk toggles
    local noclipBtn = new("TextButton",{Parent=right, Position=UDim2.new(0,8,0,132), Size=UDim2.new(0.45,-12,0,36), Text="Noclip: OFF", Font=Enum.Font.GothamBold, TextSize=14, BackgroundColor3=Color3.fromRGB(30,60,90), TextColor3=Color3.fromRGB(230,245,255)})
    new("UICorner",{Parent=noclipBtn, CornerRadius=UDim.new(0,8)})
    noclipBtn.MouseButton1Click:Connect(function()
        LexHost.ToggleNoclip()
        noclipBtn.Text = "Noclip: "..(LexHost.Enabled.Noclip and "ON" or "OFF")
        noclipBtn.BackgroundColor3 = LexHost.Enabled.Noclip and Color3.fromRGB(40,140,220) or Color3.fromRGB(30,60,90)
    end)

    local airBtn = new("TextButton",{Parent=right, Position=UDim2.new(0.55,0,0,132), Size=UDim2.new(0.45,-12,0,36), Text="AirWalk: OFF", Font=Enum.Font.GothamBold, TextSize=14, BackgroundColor3=Color3.fromRGB(30,60,90), TextColor3=Color3.fromRGB(230,245,255)})
    new("UICorner",{Parent=airBtn, CornerRadius=UDim.new(0,8)})
    airBtn.MouseButton1Click:Connect(function()
        LexHost.ToggleAirWalk()
        airBtn.Text = "AirWalk: "..(LexHost.Enabled.AirWalk and "ON" or "OFF")
        airBtn.BackgroundColor3 = LexHost.Enabled.AirWalk and Color3.fromRGB(40,140,220) or Color3.fromRGB(30,60,90)
    end)

    -- click teleport button
    local tpBtn = new("TextButton",{Parent=right, Position=UDim2.new(0,8,0,178), Size=UDim2.new(1,-16,0,36), Text="Click Teleport (use mouse)", Font=Enum.Font.GothamBold, TextSize=14, BackgroundColor3=Color3.fromRGB(45,100,200), TextColor3=Color3.fromRGB(255,255,255)})
    new("UICorner",{Parent=tpBtn, CornerRadius=UDim.new(0,8)})
    tpBtn.MouseButton1Click:Connect(function() LexHost.ClickTeleport() end)
end

local function showUtilities()
    clearRight()
    new("TextLabel", {Parent = right, Position=UDim2.new(0,8,0,6), Size=UDim2.new(1,-16,0,28), BackgroundTransparency=1, Text="Utilities", Font=Enum.Font.GothamBold, TextSize=16, TextColor3=Color3.fromRGB(220,240,255)})
    -- ESP toggle
    local espBtn = new("TextButton",{Parent=right, Position=UDim2.new(0,8,0,48), Size=UDim2.new(1,-16,0,36), Text="ESP: OFF", Font=Enum.Font.GothamBold, TextSize=14, BackgroundColor3=Color3.fromRGB(30,60,90), TextColor3=Color3.fromRGB(230,245,255)})
    new("UICorner",{Parent=espBtn, CornerRadius=UDim.new(0,8)})
    espBtn.MouseButton1Click:Connect(function()
        LexHost.ToggleESP()
        espBtn.Text = "ESP: "..(LexHost.Enabled.ESP and "ON" or "OFF")
        espBtn.BackgroundColor3 = LexHost.Enabled.ESP and Color3.fromRGB(40,140,220) or Color3.fromRGB(30,60,90)
    end)
    -- Fullbright
    local fbBtn = new("TextButton",{Parent=right, Position=UDim2.new(0,8,0,92), Size=UDim2.new(1,-16,0,36), Text="Fullbright", Font=Enum.Font.GothamBold, TextSize=14, BackgroundColor3=Color3.fromRGB(25,100,160), TextColor3=Color3.fromRGB(230,245,255)})
    new("UICorner",{Parent=fbBtn, CornerRadius=UDim.new(0,8)})
    fbBtn.MouseButton1Click:Connect(function() LexHost.EnableFullbright() end)
    -- AutoFarm
    local afBtn = new("TextButton",{Parent=right, Position=UDim2.new(0,8,0,136), Size=UDim2.new(1,-16,0,36), Text="AutoFarm: OFF", Font=Enum.Font.GothamBold, TextSize=14, BackgroundColor3=Color3.fromRGB(30,60,90), TextColor3=Color3.fromRGB(230,245,255)})
    new("UICorner",{Parent=afBtn, CornerRadius=UDim.new(0,8)})
    afBtn.MouseButton1Click:Connect(function()
        LexHost.Enabled.AutoFarm = not LexHost.Enabled.AutoFarm
        afBtn.Text = "AutoFarm: "..(LexHost.Enabled.AutoFarm and "ON" or "OFF")
        afBtn.BackgroundColor3 = LexHost.Enabled.AutoFarm and Color3.fromRGB(40,140,220) or Color3.fromRGB(30,60,90)
    end)
    -- Remove parts prompt
    local remLabel = new("TextLabel",{Parent=right, Position=UDim2.new(0,8,0,184), Size=UDim2.new(1,-16,0,20), BackgroundTransparency=1, Text="Hapus parts (koma-separate):", Font=Enum.Font.Gotham, TextSize=12, TextColor3=Color3.fromRGB(200,220,230)})
    local input = new("TextBox",{Parent=right, Position=UDim2.new(0,8,0,208), Size=UDim2.new(1,-16,0,30), BackgroundColor3=Color3.fromRGB(10,20,40), Text="", Font=Enum.Font.Gotham, TextSize=14, TextColor3=Color3.fromRGB(220,240,255)})
    new("UICorner",{Parent=input, CornerRadius=UDim.new(0,6)})
    local remBtn = new("TextButton",{Parent=right, Position=UDim2.new(0,8,0,248), Size=UDim2.new(1,-16,0,34), Text="Remove Now", Font=Enum.Font.GothamBold, TextSize=14, BackgroundColor3=Color3.fromRGB(180,60,60), TextColor3=Color3.fromRGB(255,255,255)})
    new("UICorner",{Parent=remBtn, CornerRadius=UDim.new(0,8)})
    remBtn.MouseButton1Click:Connect(function()
        local text = input.Text or ""
        if text == "" then return end
        local parts = {}
        for s in string.gmatch(text:lower(), "[^,]+") do
            s = s:match("^%s*(.-)%s*$")
            if #s>0 then table.insert(parts, s) end
        end
        LexHost.RemovePartsByNames(parts)
        local ok = new("TextLabel",{Parent=right, Position=UDim2.new(0,8,0,292), Size=UDim2.new(1,-16,0,20), BackgroundTransparency=1, Text="Requested remove: "..table.concat(parts,", "), Font=Enum.Font.Gotham, TextSize=12, TextColor3=Color3.fromRGB(200,240,200)})
        delay(3, function() if ok and ok.Parent then ok:Destroy() end end)
    end)
end

local function showInfo()
    clearRight()
    new("TextLabel",{Parent=right, Position=UDim2.new(0,8,0,6), Size=UDim2.new(1,-16,0,28), BackgroundTransparency=1, Text="Info & Credits", Font=Enum.Font.GothamBold, TextSize=16, TextColor3=Color3.fromRGB(220,240,255)})
    new("TextLabel",{Parent=right, Position=UDim2.new(0,8,0,42), Size=UDim2.new(1,-16,0,120), BackgroundTransparency=1, Text="LEX Host v3 (Cyber Neon)\nFeatures: Modes loader, Movement toggles, Utilities, Scrollable list, Stable minimize/restore.\nCreated by: Custom LEX Build", Font=Enum.Font.Gotham, TextSize=13, TextColor3=Color3.fromRGB(170,200,230), TextWrapped=true})
    local exitBtn = new("TextButton",{Parent=right, Position=UDim2.new(0,8,0,170), Size=UDim2.new(1,-16,0,36), BackgroundColor3=Color3.fromRGB(180,60,60), Text="Exit (Destroy GUI)", Font=Enum.Font.GothamBold, TextSize=14, TextColor3=Color3.fromRGB(255,255,255)})
    new("UICorner",{Parent=exitBtn, CornerRadius=UDim.new(0,8)})
    exitBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)
end

-- connect menu events
menuButtons["Home"].MouseButton1Click:Connect(showHome)
menuButtons["Modes"].MouseButton1Click:Connect(showModeList)
menuButtons["Movement"].MouseButton1Click:Connect(showMovement)
menuButtons["Utilities"].MouseButton1Click:Connect(showUtilities)
menuButtons["Info"].MouseButton1Click:Connect(showInfo)

-- default
showHome()

-- drag main from topBar
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

-- minimize / close behavior
btnMin.MouseButton1Click:Connect(function()
    main.Visible = false
end)
btnClose.MouseButton1Click:Connect(function()
    main.Visible = false
end)

-- LX logo shows/hides main and recenters
lx.MouseButton1Click:Connect(function()
    if main.Visible then
        main.Visible = false
    else
        main.Visible = true
        main.Position = UDim2.new(0.5,0,0.5,0)
    end
end)

-- small accent animation (neon pulse)
do
    spawn(function()
        local t=0
        while screenGui and screenGui.Parent do
            t = t + 0.03
            local pulse = 0.35 + 0.65 * (0.5 + 0.5*math.sin(t*2))
            pcall(function()
                mainStroke.Transparency = 0
                topAccent.BackgroundColor3 = Color3.fromHSV(0.6 + 0.05*math.sin(t), 0.9, 0.6 + 0.15*math.sin(t))
                lxStroke.Color = Color3.fromHSV(0.6 + 0.05*math.sin(t), 0.9, 0.7)
            end)
            task.wait(0.04)
        end
    end)
end

print("[LEX Host v3] UI loaded — Cyber Neon. Versi: "..LexHost.Version)
