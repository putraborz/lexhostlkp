-- LEX Host - Futuristic All-in-one (Fix: stable minimize + scroll + LX tengah-atas)
-- Generated/Modified: fixed by assistant
-- Place this LocalScript in StarterGui (LocalScript environment)
-- ⚠️ USE AT YOUR OWN RISK ⚠️

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- MAIN data
local LexHost = {}
LexHost.Version = "2.5.1-futuristic-fixed"

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

-- ---------- SCRIPT LIST ----------
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

-- Remove previous UI if exists
local existing = PlayerGui:FindFirstChild("LEX_HOST_GUI")
if existing then existing:Destroy() end

-- ROOT ScreenGui
local screenGui = new("ScreenGui", {Parent = PlayerGui, Name = "LEX_HOST_GUI", ResetOnSpawn = false})
screenGui.IgnoreGuiInset = true

-- LX LOGO (SEKARANG: tengah atas)
local lxButton = new("TextButton", {
    Parent = screenGui,
    Name = "LXButton",
    Size = UDim2.new(0,64,0,44),
    AnchorPoint = Vector2.new(0.5,0),
    Position = UDim2.new(0.5, 0, 0, 10), -- tengah atas, offset 10px
    BackgroundColor3 = Color3.fromRGB(8,12,20),
    Text = "LX",
    Font = Enum.Font.GothamBold,
    TextSize = 20,
    TextColor3 = Color3.fromRGB(230,245,255),
    BorderSizePixel = 0,
    ZIndex = 9999
})
new("UICorner", {Parent = lxButton, CornerRadius = UDim.new(0,8)})
local lxStroke = new("UIStroke", {Parent = lxButton, Thickness = 2, Color = Color3.fromRGB(40,150,255)})
lxButton.AutoButtonColor = false

-- MAIN PANEL (hidden initially)
local main = new("Frame", {
    Parent = screenGui,
    Name = "LEXHost_Main",
    AnchorPoint = Vector2.new(0.5,0.5),
    Position = UDim2.new(0.5,0,0.5,0),
    Size = UDim2.new(0,540,0,420),
    BackgroundColor3 = Color3.fromRGB(6,12,20),
    BorderSizePixel = 0,
    Visible = false,
    ZIndex = 9998
})
new("UICorner", {Parent = main, CornerRadius = UDim.new(0,14)})
local mainStroke = new("UIStroke", {Parent = main, Color = Color3.fromRGB(50,140,255), Thickness = 1.5})
local mainAccent = new("Frame", {Parent = main, Size = UDim2.new(1,0,0,4), Position = UDim2.new(0,0,0,0), BackgroundColor3 = Color3.fromRGB(50,140,255)})
mainAccent.ZIndex = 9999

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

-- helper to clear right content (but keep persistent modesScroll if exists)
local function clearRight()
    for _, c in pairs(right:GetChildren()) do
        if c.Name ~= "ModesScroll" and not c:IsA("UIListLayout") then
            pcall(function() c:Destroy() end)
        end
    end
end

-- create persistent ScrollingFrame for Modes (so scroll state preserved)
local function ensureModesScroll()
    local existing = right:FindFirstChild("ModesScroll")
    if existing and existing:IsA("ScrollingFrame") then
        return existing
    end
    local scr = new("ScrollingFrame", {
        Parent = right,
        Name = "ModesScroll",
        Position = UDim2.new(0,8,0,84),
        Size = UDim2.new(1,-16,1,-92),
        CanvasSize = UDim2.new(0,0,0,0),
        ScrollBarThickness = 8,
        BackgroundTransparency = 1
    })
    local layout = new("UIListLayout", {Parent = scr})
    layout.Padding = UDim.new(0,10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    -- auto-update canvas size when content changes
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scr.CanvasSize = UDim2.new(0,0,0, layout.AbsoluteContentSize.Y + 12)
    end)
    return scr
end

-- helper to create a styled button for modes
local function makeModeButton(parent, text, onClick)
    local btn = new("TextButton", {
        Parent = parent,
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = Color3.fromRGB(28,58,106),
        Text = text,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Color3.fromRGB(230,245,255),
        BorderSizePixel = 0
    })
    new("UICorner", {Parent = btn, CornerRadius = UDim.new(0,8)})
    btn.MouseButton1Click:Connect(function()
        pcall(onClick)
    end)
    return btn
end

-- PAGE BUILDERS
local function showHome()
    clearRight()
    local t1 = new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,6), Size = UDim2.new(1,-16,0,28), BackgroundTransparency = 1, Text = "Welcome to LEX Host (Futuristic)", Font = Enum.Font.GothamBold, TextSize = 18, TextColor3 = Color3.fromRGB(220,240,255)})
    local t2 = new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,42), Size = UDim2.new(1,-16,0,64), BackgroundTransparency = 1, Text = "Panel: klik 'Modes' untuk melihat daftar gunung. Gunakan tombol LX di atas untuk show/hide.", Font = Enum.Font.Gotham, TextSize = 13, TextColor3 = Color3.fromRGB(170,200,230), TextWrapped = true})
end

-- BUILD MODE LIST using persistent scrolling frame
local function showModeList()
    clearRight()
    local header = new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,6), Size = UDim2.new(1,-16,0,28), BackgroundTransparency = 1, Text = "Modes / Gunung", Font = Enum.Font.GothamBold, TextSize = 16, TextColor3 = Color3.fromRGB(220,240,255)})
    local sub = new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,36), Size = UDim2.new(1,-16,0,36), BackgroundTransparency = 1, Text = "Klik salah satu untuk menjalankan skrip yang bersangkutan.", Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = Color3.fromRGB(170,200,230), TextWrapped = true})
    local scr = ensureModesScroll()
    -- clear existing mode buttons inside scr
    for _,c in pairs(scr:GetChildren()) do
        if c:IsA("TextButton") then pcall(function() c:Destroy() end) end
    end
    -- populate
    for _, item in ipairs(scriptList) do
        makeModeButton(scr, item.name, function()
            -- safe pcall loadstring
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
                -- temporary error label
                local lbl = new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0, scr.Position.Y.Offset + scr.AbsoluteSize.Y + 8), Size = UDim2.new(1,-16,0,20), BackgroundTransparency = 1, Text = "Gagal menjalankan: "..tostring(err), Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = Color3.fromRGB(255,180,180)})
                delay(3, function() if lbl and lbl.Parent then lbl:Destroy() end end)
            end
        end)
    end
end

local function showMovement()
    clearRight()
    local t = new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,6), Size = UDim2.new(1,-16,0,28), BackgroundTransparency = 1, Text = "Movement", Font = Enum.Font.GothamBold, TextSize = 16, TextColor3 = Color3.fromRGB(220,240,255)})
    -- placeholders
    local fly = new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,46), Size = UDim2.new(1,-16,0,20), BackgroundTransparency = 1, Text = "Fly / AirWalk controls (use toggles in Utilities)", Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = Color3.fromRGB(180,200,220)})
end

local function showUtilities()
    clearRight()
    local t = new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,6), Size = UDim2.new(1,-16,0,28), BackgroundTransparency = 1, Text = "Utilities", Font = Enum.Font.GothamBold, TextSize = 16, TextColor3 = Color3.fromRGB(220,240,255)})
    local btnRefresh = makeModeButton(right, "Refresh Scripts List", function() showModeList() end)
    btnRefresh.Position = UDim2.new(0,8,0,48)
    local btnRemove = makeModeButton(right, "Remove Parts (world)", function()
        clearRight()
        local lbl = new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,6), Size = UDim2.new(1,-16,0,28), BackgroundTransparency = 1, Text = "Enter names (comma-separated) then press Remove", Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = Color3.fromRGB(200,220,230)})
        local input = new("TextBox", {Parent = right, Position = UDim2.new(0,8,0,46), Size = UDim2.new(1,-16,0,36), BackgroundColor3 = Color3.fromRGB(12,24,46), Text = "", Font = Enum.Font.Gotham, TextSize = 14, TextColor3 = Color3.fromRGB(220,240,255)})
        new("UICorner", {Parent = input, CornerRadius = UDim.new(0,8)})
        local remBtn = new("TextButton", {Parent = right, Position = UDim2.new(0,8,0,92), Size = UDim2.new(1,-16,0,36), BackgroundColor3 = Color3.fromRGB(180,60,60), Text = "Remove Now", Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = Color3.fromRGB(255,255,255)})
        new("UICorner", {Parent = remBtn, CornerRadius = UDim.new(0,8)})
        remBtn.MouseButton1Click:Connect(function()
            local text = input.Text or ""
            if text == "" then return end
            local parts = {}
            for s in string.gmatch(text:lower(), "[^,]+") do
                s = s:match("^%s*(.-)%s*$")
                if #s > 0 then table.insert(parts, s) end
            end
            for _, obj in pairs(workspace:GetDescendants()) do
                pcall(function()
                    local nm = tostring(obj.Name):lower()
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
    end)
end

local function showInfo()
    clearRight()
    new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,6), Size = UDim2.new(1,-16,0,28), BackgroundTransparency = 1, Text = "Info & Credits", Font = Enum.Font.GothamBold, TextSize = 16, TextColor3 = Color3.fromRGB(220,240,255)})
    new("TextLabel", {Parent = right, Position = UDim2.new(0,8,0,42), Size = UDim2.new(1,-16,0,120), BackgroundTransparency = 1, Text = "LEX Host - Futuristic UI\nVersi: "..LexHost.Version.."\n\nFeatures: Modes loader, stable minimize/restore, scrollable modes.\nUse at your own risk.", Font = Enum.Font.Gotham, TextSize = 13, TextColor3 = Color3.fromRGB(170,200,230), TextWrapped = true})
    local exitBtn = new("TextButton", {Parent = right, Position = UDim2.new(0,8,0,180), Size = UDim2.new(1,-16,0,36), BackgroundColor3 = Color3.fromRGB(180,60,60), Text = "Exit (Destroy GUI)", Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = Color3.fromRGB(255,255,255)})
    new("UICorner", {Parent = exitBtn, CornerRadius = UDim.new(0,8)})
    exitBtn.MouseButton1Click:Connect(function()
        if screenGui and screenGui.Parent then screenGui:Destroy() end
    end)
end

-- connect menus
menuButtons["Home"].MouseButton1Click:Connect(showHome)
menuButtons["Modes"].MouseButton1Click:Connect(function() showModeList() end)
menuButtons["Movement"].MouseButton1Click:Connect(showMovement)
menuButtons["Utilities"].MouseButton1Click:Connect(showUtilities)
menuButtons["Info"].MouseButton1Click:Connect(showInfo)

-- default
showHome()

-- DRAGGING MAIN from topBar (stable)
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

-- MINIMIZE / CLOSE BEHAVIOR (fixed: do not destroy children visibility/size)
btnMin.MouseButton1Click:Connect(function()
    -- simply hide main (preserve layout), LX remains for restore
    main.Visible = false
end)

-- Close button hides main (same behavior)
btnClose.MouseButton1Click:Connect(function()
    main.Visible = false
end)

-- LX Button toggles main visibility and recenters when showing
lxButton.MouseButton1Click:Connect(function()
    if main.Visible then
        main.Visible = false
    else
        main.Visible = true
        -- ensure center on show to avoid offscreen issues
        main.Position = UDim2.new(0.5, 0, 0.5, 0)
    end
end)

-- RGB / Glow effect for accents (animate hue) - safe pcall
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

print("[LEX Host] Fixed UI loaded. Versi: "..LexHost.Version)
