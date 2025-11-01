-- LEX Host - Futuristik All-in-one
-- Generated/Modified: 01/11/2025 (versi kustom untuk user)
-- Place this LocalScript in StarterGui
-- ⚠️ USE AT YOUR OWN RISK ⚠️

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local HttpGet = game.HttpGet or function(self, url) return game:HttpGet(url) end -- compatibility

-- MAIN data
local LexHost = {}
LexHost.Version = "2.5.1-futuristic"
LexHost.Enabled = {
    Fly = false,
    Speed = false,
    Noclip = false,
    ESP = false,
    AutoFarm = false,
    AirWalk = false,
}
LexHost.FlySpeed = 45
LexHost.SpeedMultiplier = 2

-- quick instance creator
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

-- ---------- SCRIPT LIST (sesuaikan sesuai input user) ----------
local scriptList = {
    {name = "ATIN NEW", url = "https://pastebin.com/raw/iw5xHtvD"},
    {name = "YAHAYUK NEW", url = "https://pastebin.com/raw/UK8nspn0"},
    {name = "WKSPEDISI ANTARTIKA NEW", url = "https://pastebin.com/raw/mqEjFxVj"},
    {name = "MOUNT YNTKTS NEW", url = "https://pastebin.com/raw/k0bc5h4m"},
    {name = "SAKAHAYNG", url = "https://pastebin.com/raw/zishUBsB"},
    {name = "STECU NEW", url = "https://pastebin.com/raw/VdUnM88V"},
    {name = "BALI HOT EXPEDITION", url = "https://pastebin.com/raw/e82WGJas"},
    {name = "MOUNT KOMANG", url = "https://pastebin.com/raw/QYcyGtMR"},
    {name = "MOUNT PRAMBANAN", url = "https://pastebin.com/raw/GysqQgpx"},
    {name = "MOUNT MONO", url = "https://pastebin.com/raw/Ha8qwDeB"},
    {name = "MOUNT SUMBING", url = "https://pastebin.com/raw/FqQwFJLe"},
    {name = "MOUNT GEMI", url = "https://pastebin.com/raw/516Y0aw1"},
    {name = "MOUNT KOHARU", url = "https://pastebin.com/raw/Rs6hy7xx"},
}

-- CLEAN previous UI
local existing = PlayerGui:FindFirstChild("LEX_HOST_GUI")
if existing then existing:Destroy() end

-- ROOT ScreenGui
local screenGui = new("ScreenGui", {Parent = PlayerGui, Name = "LEX_HOST_GUI", ResetOnSpawn = false})
screenGui.IgnoreGuiInset = true

-- LX LOGO (kotak kecil di pojok kanan bawah) - selalu tampil
local lxButton = new("TextButton", {
    Parent = screenGui,
    Name = "LXButton",
    Size = UDim2.new(0,52,0,52),
    Position = UDim2.new(1,-76,1,-96),
    AnchorPoint = Vector2.new(0,0),
    BackgroundColor3 = Color3.fromRGB(10,12,20),
    Text = "LX",
    Font = Enum.Font.GothamBold,
    TextSize = 20,
    TextColor3 = Color3.fromRGB(230,245,255),
    BorderSizePixel = 0
})
new("UICorner", {Parent = lxButton, CornerRadius = UDim.new(0,10)})
local lxStroke = new("UIStroke", {Parent = lxButton, Thickness = 2, Color = Color3.fromRGB(40,150,255)})
local lxGlow = new("ImageLabel", {Parent = lxButton, BackgroundTransparency = 1, Size = UDim2.new(1.6,0,1.6,0), Position = UDim2.new(-0.3,-0, -0.3,0), Image = "", ZIndex = 0}) -- placeholder for visual layering

-- MAIN PANEL (hidden initially)
local main = new("Frame", {
    Parent = screenGui,
    Name = "LEXHost_Main",
    AnchorPoint = Vector2.new(0.5,0.5),
    Position = UDim2.new(0.5,0,0.5,0),
    Size = UDim2.new(0,540,0,420),
    BackgroundColor3 = Color3.fromRGB(6,12,20),
    BorderSizePixel = 0,
    Visible = false
})
new("UICorner", {Parent = main, CornerRadius = UDim.new(0,14)})
local mainStroke = new("UIStroke", {Parent = main, Color = Color3.fromRGB(50,140,255), Thickness = 1.5})
local mainAccent = new("Frame", {Parent = main, Size = UDim2.new(1,0,0,4), Position = UDim2.new(0,0,0,0), BackgroundColor3 = Color3.fromRGB(50,140,255)})
mainAccent.ZIndex = 2

-- TOP BAR (drag area)
local topBar = new("Frame", {Parent = main, Size = UDim2.new(1,0,0,56), BackgroundTransparency = 1})
local title = new("TextLabel", {
    Parent = topBar,
    Position = UDim2.new(0,18,0,8),
    Size = UDim2.new(0.6,0,0,28),
    BackgroundTransparency = 1,
    Text = "LEX Host",
    Font = Enum.Font.GothamBold,
    TextSize = 20,
    TextColor3 = Color3.fromRGB(210,235,255),
    TextXAlignment = Enum.TextXAlignment.Left
})
local subtitle = new("TextLabel", {
    Parent = topBar,
    Position = UDim2.new(0,18,0,28),
    Size = UDim2.new(0.6,0,0,20),
    BackgroundTransparency = 1,
    Text = "Futuristic • v"..LexHost.Version,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextColor3 = Color3.fromRGB(150,190,230),
    TextXAlignment = Enum.TextXAlignment.Left
})

-- Right top control buttons
local btnClose = new("TextButton", {
    Parent = topBar, Size = UDim2.new(0,36,0,28), Position = UDim2.new(1,-48,0,14),
    BackgroundColor3 = Color3.fromRGB(200,70,70), Text = "X", Font = Enum.Font.GothamBold, TextSize = 16, TextColor3 = Color3.fromRGB(255,255,255)
})
new("UICorner", {Parent = btnClose, CornerRadius = UDim.new(0,6)})
local btnMin = new("TextButton", {
    Parent = topBar, Size = UDim2.new(0,36,0,28), Position = UDim2.new(1,-92,0,14),
    BackgroundColor3 = Color3.fromRGB(20,90,170), Text = "_", Font = Enum.Font.GothamBold, TextSize = 20, TextColor3 = Color3.fromRGB(255,255,255)
})
new("UICorner", {Parent = btnMin, CornerRadius = UDim.new(0,6)})

-- BODY (left nav + right content)
local body = new("Frame", {Parent = main, Position = UDim2.new(0,12,0,64), Size = UDim2.new(1,-24,1,-76), BackgroundTransparency = 1})

-- LEFT NAV
local left = new("Frame", {Parent = body, Size = UDim2.new(0,160,1,0), BackgroundTransparency = 1})
new("Frame", {Parent = left, Size = UDim2.new(1,0,1,0), BackgroundColor3 = Color3.fromRGB(8,16,30), BorderSizePixel = 0})
new("UICorner", {Parent = left, CornerRadius = UDim.new(0,10)})

local menuList = {
    {Key="Home", Label="Home"},
    {Key="Modes", Label="Modes"},
    {Key="Movement", Label="Movement"},
    {Key="Utilities", Label="Utilities"},
    {Key="Info", Label="Info"},
}
local menuButtons = {}
for i, data in ipairs(menuList) do
    local btn = new("TextButton", {
        Parent = left,
        Size = UDim2.new(1, -24, 0, 46),
        Position = UDim2.new(0,12,0, 12 + (i-1)*56),
        BackgroundColor3 = Color3.fromRGB(12,26,48),
        Text = data.Label,
        Font = Enum.Font.Gotham,
        TextSize = 15,
        TextColor3 = Color3.fromRGB(210,230,255),
        BorderSizePixel = 0
    })
    new("UICorner", {Parent = btn, CornerRadius = UDim.new(0,8)})
    menuButtons[data.Key] = btn
end

-- RIGHT CONTENT
local right = new("Frame", {Parent = body, Size = UDim2.new(1, -176, 1, 0), Position = UDim2.new(0,170,0,0), BackgroundTransparency = 1})
new("UICorner", {Parent = right, CornerRadius = UDim.new(0,8)})

-- helpers
local function clearRight()
    for _, c in pairs(right:GetChildren()) do
        if not c:IsA("UIListLayout") then pcall(function() c:Destroy() end) end
    end
end

local function makeButton(parent, text, cb)
    local btn = new("TextButton", {Parent = parent, Size = UDim2.new(1,-16,0,40), Position = UDim2.new(0,8,0,0), BackgroundColor3 = Color3.fromRGB(30,64,110), Text = text, Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = Color3.fromRGB(255,255,255)})
    new("UICorner", {Parent = btn, CornerRadius = UDim.new(0,8)})
    btn.MouseButton1Click:Connect(function()
        pcall(cb)
    end)
    return btn
end

local function makeToggle(parent, labelText, initial, onChange)
    local cont = new("Frame", {Parent = parent, Size = UDim2.new(1, -12, 0, 44), BackgroundTransparency = 1})
    local lbl = new("TextLabel", {Parent = cont, Size = UDim2.new(0.65,0,1,0), BackgroundTransparency = 1, Text = labelText, Font = Enum.Font.Gotham, TextSize = 15, TextColor3 = Color3.fromRGB(220,240,255), TextXAlignment = Enum.TextXAlignment.Left})
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

-- PAGE BUILDERS
local function showHome()
    clearRight()
    new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,6), Size = UDim2.new(1,-16,0,28), BackgroundTransparency = 1, Text = "Welcome to LEX Host (Futuristic)", Font = Enum.Font.GothamBold, TextSize = 18, TextColor3 = Color3.fromRGB(220,240,255)})
    new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,42), Size = UDim2.new(1,-16,0,64), BackgroundTransparency = 1, Text = "Panel futuristik: klik mode pada tab 'Modes' untuk menjalankan skrip. Gunakan tombol LX di pojok untuk munculkan/ sembunyikan panel kapan saja.", Font = Enum.Font.Gotham, TextSize = 13, TextColor3 = Color3.fromRGB(170,200,230), TextWrapped = true})
    local refresh = makeButton(right, "Refresh Script List", function()
        -- recreate modes page if open
        if main.Visible then
            if menuButtons["Modes"] then menuButtons["Modes"]:CaptureFocus() end
            -- call refresh action
            showModeList()
        end
    end)
    refresh.Position = UDim2.new(0,8,0,120)
end

-- BUILD MODE LIST (dynamically from scriptList)
function showModeList()
    clearRight()
    new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,6), Size = UDim2.new(1,-16,0,28), BackgroundTransparency = 1, Text = "Modes / Gunung", Font = Enum.Font.GothamBold, TextSize = 16, TextColor3 = Color3.fromRGB(220,240,255)})
    new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,36), Size = UDim2.new(1,-16,0,40), BackgroundTransparency = 1, Text = "Klik salah satu untuk menjalankan skrip yang bersangkutan.", Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = Color3.fromRGB(170,200,230), TextWrapped = true})
    local y = 84
    for _, item in ipairs(scriptList) do
        local btn = new("TextButton", {Parent = right, Position = UDim2.new(0,8,0,y), Size = UDim2.new(1,-16,0,36), BackgroundColor3 = Color3.fromRGB(28,58,106), Text = item.name, Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = Color3.fromRGB(230,245,255)})
        new("UICorner", {Parent = btn, CornerRadius = UDim.new(0,8)})
        btn.MouseButton1Click:Connect(function()
            -- safety: pcall execute
            local ok, err = pcall(function()
                local s = game:HttpGet(item.url)
                local f = loadstring(s)
                if type(f) == "function" then
                    f()
                else
                    error("Invalid loadstring for "..item.name)
                end
            end)
            if not ok then
                -- show small temporary error label
                local lbl = new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,y+44), Size = UDim2.new(1,-16,0,20), BackgroundTransparency = 1, Text = "Gagal menjalankan: "..tostring(err), Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = Color3.fromRGB(255,180,180)})
                delay(3, function() if lbl and lbl.Parent then lbl:Destroy() end end)
            end
        end)
        y = y + 46
    end
end

local function showMovement()
    clearRight()
    new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,6), Size = UDim2.new(1,-16,0,28), BackgroundTransparency = 1, Text = "Movement", Font = Enum.Font.GothamBold, TextSize = 16, TextColor3 = Color3.fromRGB(220,240,255)})
    -- placeholders (actual movement functions should be in a separate section if desired)
    local fly = makeToggle(right, "Fly (enable/disable)", LexHost.Enabled.Fly, function(state) LexHost.Enabled.Fly = state end)
    fly.Position = UDim2.new(0,0,0,52)
    fly.Parent = right
    local speed = makeToggle(right, "Speed Hack", LexHost.Enabled.Speed, function(state) LexHost.Enabled.Speed = state end)
    speed.Position = UDim2.new(0,0,0,108)
    speed.Parent = right
    local speedSlider = makeSlider(right, "Speed Multiplier", 1, 12, LexHost.SpeedMultiplier, function(val) LexHost.SpeedMultiplier = val end)
    speedSlider.Position = UDim2.new(0,0,0,164)
    speedSlider.Parent = right
end

local function showUtilities()
    clearRight()
    new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,6), Size = UDim2.new(1,-16,0,28), BackgroundTransparency = 1, Text = "Utilities", Font = Enum.Font.GothamBold, TextSize = 16, TextColor3 = Color3.fromRGB(220,240,255)})
    local refreshBtn = makeButton(right, "Refresh Script List (rebuild Modes)", function() showModeList() end)
    refreshBtn.Position = UDim2.new(0,8,0,48)
    local remParts = makeButton(right, "Remove Parts by Name (World Tools)", function()
        -- prompt simple TextBox
        clearRight()
        new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,6), Size = UDim2.new(1,-16,0,28), BackgroundTransparency = 1, Text = "Remove Parts (masukkan nama, koma-separate)", Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = Color3.fromRGB(220,240,255)})
        local input = new("TextBox", {Parent = right, Position = UDim2.new(0,8,0,46), Size = UDim2.new(1,-16,0,36), BackgroundColor3 = Color3.fromRGB(12,24,46), Text = "", Font = Enum.Font.Gotham, TextSize = 14, TextColor3 = Color3.fromRGB(220,240,255)})
        new("UICorner", {Parent = input, CornerRadius = UDim.new(0,8)})
        local remBtn = makeButton(right, "Remove Now", function()
            local text = input.Text or ""
            if text == "" then return end
            local parts = {}
            for s in string.gmatch(text:lower(), "[^,]+") do
                s = s:match("^%s*(.-)%s*$")
                if #s > 0 then table.insert(parts, s) end
            end
            for _, obj in pairs(workspace:GetDescendants()) do
                pcall(function()
                    local nm = obj.Name:lower()
                    for _, t in pairs(parts) do
                        if nm == t or string.find(nm, t) then
                            pcall(function() obj:Destroy() end)
                        end
                    end
                end)
            end
            local ok = new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,140), Size = UDim2.new(1,-16,0,20), BackgroundTransparency = 1, Text = "Remove requested: "..table.concat(parts, ", "), Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = Color3.fromRGB(200,240,200)})
            delay(3, function() if ok and ok.Parent then ok:Destroy() end end)
        end)
        remBtn.Position = UDim2.new(0,8,0,92)
    end)
    remParts.Position = UDim2.new(0,8,0,96)
    remParts.Parent = right
end

local function showInfo()
    clearRight()
    new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,6), Size = UDim2.new(1,-16,0,28), BackgroundTransparency = 1, Text = "Info & Credits", Font = Enum.Font.GothamBold, TextSize = 16, TextColor3 = Color3.fromRGB(220,240,255)})
    new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,42), Size = UDim2.new(1,-16,0,120), BackgroundTransparency = 1, Text = "LEX Host - Futuristic UI\nVersi: "..LexHost.Version.."\n\nFeatures: Modes loader, Movement toggles, Utilities, Remove parts, RGB accent.\n\nDesigner: LEX Host (custom build)\nUse at your own risk.", Font = Enum.Font.Gotham, TextSize = 13, TextColor3 = Color3.fromRGB(170,200,230), TextWrapped = true})
    local exitBtn = makeButton(right, "Exit (Tutup GUI)", function()
        if screenGui and screenGui.Parent then screenGui:Destroy() end
    end)
    exitBtn.Position = UDim2.new(0,8,0,180)
end

-- connect menus
menuButtons["Home"].MouseButton1Click:Connect(showHome)
menuButtons["Modes"].MouseButton1Click:Connect(function() showModeList() end)
menuButtons["Movement"].MouseButton1Click:Connect(showMovement)
menuButtons["Utilities"].MouseButton1Click:Connect(showUtilities)
menuButtons["Info"].MouseButton1Click:Connect(showInfo)

-- default page
showHome()

-- DRAGGING MAIN from topBar
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

-- MINIMIZE / CLOSE BEHAVIOR (adapted to LX button)
local minimized = false
btnMin.MouseButton1Click:Connect(function()
    if not minimized then
        local shrink = TweenService:Create(main, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 220, 0, 46)})
        shrink:Play()
        for _, child in pairs(main:GetChildren()) do
            if child ~= topBar then child.Visible = false end
        end
        minimized = true
    else
        local expand = TweenService:Create(main, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0,540,0,420)})
        expand:Play()
        for _, child in pairs(main:GetChildren()) do child.Visible = true end
        minimized = false
    end
end)

-- CHANGE btnClose to HIDE (so LX can restore). If user wants full destroy, Info->Exit available
btnClose.MouseButton1Click:Connect(function()
    main.Visible = false
end)

-- LX Button toggles main visibility (show/hide) and if hidden re-open
lxButton.MouseButton1Click:Connect(function()
    if main.Visible then
        main.Visible = false
    else
        main.Visible = true
        -- ensure main appears centered (or keep last position)
        -- animate in if first time visible
        if main.Size.X.Offset == 540 then
            main.Position = UDim2.new(0.5, 0, -0.5, 0)
            local t1 = TweenService:Create(main, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0.5, 0)})
            t1:Play()
        end
    end
end)

-- OPEN animation if user clicked LX for first time
-- (handled in lxButton connection above)

-- RGB / Glow effect for accents (animate hue)
do
    local t = 0
    spawn(function()
        while screenGui and screenGui.Parent do
            t = t + 0.015
            local r = (math.sin(t*1.2) * 0.5 + 0.5)
            local g = (math.sin(t*1.6 + 2) * 0.5 + 0.5)
            local b = (math.sin(t*1.1 + 4) * 0.5 + 0.5)
            local col = Color3.new(0.15 + 0.85*r, 0.15 + 0.85*g, 0.25 + 0.75*b)
            pcall(function()
                mainAccent.BackgroundColor3 = col
                mainStroke.Color = col
                lxStroke.Color = col
            end)
            wait(0.03)
        end
    end)
end

-- FINAL print
print("[LEX Host] UI siap. Versi: "..LexHost.Version)
