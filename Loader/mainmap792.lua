-- 🧠 LEX HOST UI v2.7 Stable
-- Fix Bug + Full Gunung List Sync
-- By: Putra Botz | Style: Classic Stable

if game.CoreGui:FindFirstChild("LEXHostUI") then
	game.CoreGui:FindFirstChild("LEXHostUI"):Destroy()
end

local UIS = game:GetService("UserInputService")
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "LEXHostUI"
gui.ResetOnSpawn = false

-- Tombol Toggle (LX)
local toggle = Instance.new("TextButton", gui)
toggle.Size = UDim2.new(0, 60, 0, 60)
toggle.Position = UDim2.new(1, -80, 1, -80)
toggle.AnchorPoint = Vector2.new(1, 1)
toggle.Text = "LX"
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 22
toggle.TextColor3 = Color3.fromRGB(0, 255, 255)
toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
toggle.BorderSizePixel = 0
Instance.new("UICorner", toggle).CornerRadius = UDim.new(1, 0)

-- Frame utama
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 400, 0, 520)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
main.Visible = false
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 45)
title.Text = "LEX HOST"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(0, 255, 255)
title.TextSize = 26
title.BackgroundTransparency = 1

-- Scroll frame
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1, -20, 1, -130)
scroll.Position = UDim2.new(0, 10, 0, 60)
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 5
scroll.BackgroundTransparency = 1
local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 6)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- List Gunung (sinkron dengan data terbaru)
local scripts = {
	["ATIN NEW"] = "https://pastebin.com/raw/iw5xHtvD",
	["YAHAYUK NEW"] = "https://pastebin.com/raw/UK8nspn0",
	["WKSPEDISI ANTARTIKA NEW"] = "https://pastebin.com/raw/mqEjFxVj",
	["MOUNT YNTKTS NEW"] = "https://pastebin.com/raw/k0bc5h4m",
	["SAKAHAYNG"] = "https://pastebin.com/raw/zishUBsB",
	["STECU NEW"] = "https://pastebin.com/raw/VdUnM88V",
	["BALI HOT EXPEDITION"] = "https://pastebin.com/raw/e82WGJas",
	["MOUNT KOMANG"] = "https://pastebin.com/raw/QYcyGtMR",
	["MOUNT PRAMBANAN"] = "https://pastebin.com/raw/GysqQgpx",
	["MOUNT MONO"] = "https://pastebin.com/raw/Ha8qwDeB",
	["MOUNT SUMBING"] = "https://pastebin.com/raw/FqQwFJLe",
	["MOUNT GEMI"] = "https://pastebin.com/raw/516Y0aw1",
	["MOUNT KOHARU"] = "https://pastebin.com/raw/Rs6hy7xx"
}

-- Buat tombol dari daftar di atas
local function makeButton(name, link)
	local b = Instance.new("TextButton", scroll)
	b.Size = UDim2.new(0.9, 0, 0, 35)
	b.Text = name
	b.Font = Enum.Font.GothamBold
	b.TextSize = 16
	b.TextColor3 = Color3.fromRGB(0, 255, 255)
	b.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	b.AutoButtonColor = false
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
	b.MouseButton1Click:Connect(function()
		loadstring(game:HttpGet(link))()
	end)
end

for n, l in pairs(scripts) do makeButton(n, l) end

-- Tombol bawah
local bottom = Instance.new("Frame", main)
bottom.Size = UDim2.new(1, -20, 0, 50)
bottom.Position = UDim2.new(0, 10, 1, -60)
bottom.BackgroundTransparency = 1
local layout2 = Instance.new("UIListLayout", bottom)
layout2.FillDirection = Enum.FillDirection.Horizontal
layout2.Padding = UDim.new(0, 8)
layout2.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function makeSmallButton(txt)
	local b = Instance.new("TextButton", bottom)
	b.Size = UDim2.new(0.3, 0, 1, 0)
	b.Text = txt
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.TextColor3 = Color3.fromRGB(0, 255, 255)
	b.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
	return b
end

local refresh = makeSmallButton("🔁 Refresh")
local exit = makeSmallButton("❌ Exit")
local info = makeSmallButton("🧠 Info")

refresh.MouseButton1Click:Connect(function()
	for _, v in pairs(scroll:GetChildren()) do
		if v:IsA("TextButton") then v:Destroy() end
	end
	for n, l in pairs(scripts) do makeButton(n, l) end
end)

exit.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

info.MouseButton1Click:Connect(function()
	game.StarterGui:SetCore("SendNotification", {
		Title = "LEX HOST UI",
		Text = "Stable v2.7 | Fixed Drag + Minimize Bug",
		Duration = 5
	})
end)

-- Sistem drag
local dragging, dragInput, dragStart, startPos
local function update(input)
	local delta = input.Position - dragStart
	main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
		startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)

main.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then update(input) end
end)

-- Sistem minimize fix
local open = false
toggle.MouseButton1Click:Connect(function()
	open = not open
	if open then
		main.Visible = true
		main.Position = UDim2.new(0.5, 0, 0.5, 0)
	else
		main.Visible = false
	end
end)

print("✅ LEX Host v2.7 Loaded | Bug Fixed | List Synced")
