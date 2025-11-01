-- 🌌 LEX HOST FUTURISTIC UI v3.0
-- Author: Putra Botz
-- Theme: Neon Blue | Dragable | Animated | Futuristic

if game.CoreGui:FindFirstChild("LEXHostUI") then
	game.CoreGui:FindFirstChild("LEXHostUI"):Destroy()
end

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "LEXHostUI"
gui.ResetOnSpawn = false

-- Tombol Toggle (LX)
local toggle = Instance.new("TextButton", gui)
toggle.Size = UDim2.new(0,60,0,60)
toggle.Position = UDim2.new(1,-80,1,-80)
toggle.AnchorPoint = Vector2.new(1,1)
toggle.Text = "LX"
toggle.Font = Enum.Font.GothamBold
toggle.TextColor3 = Color3.fromRGB(0,255,255)
toggle.TextSize = 22
toggle.BackgroundColor3 = Color3.fromRGB(10,10,25)
toggle.BorderSizePixel = 0
Instance.new("UICorner", toggle).CornerRadius = UDim.new(1,0)
local glow = Instance.new("UIStroke", toggle)
glow.Color = Color3.fromRGB(0,255,255)
glow.Thickness = 2

-- Frame utama
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,420,0,520)
main.Position = UDim2.new(0.5,0,0.5,0)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = Color3.fromRGB(10,10,25)
main.BackgroundTransparency = 0.2
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)
local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = Color3.fromRGB(0,255,255)
mainStroke.Thickness = 2
main.Visible = false
main.Size = UDim2.new(0,380,0,470)

-- Dragging system
local dragging, dragInput, dragStart, startPos
local function update(input)
	local delta = input.Position - dragStart
	main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
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

-- Judul
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,50)
title.Text = "LEX HOST"
title.Font = Enum.Font.GothamBlack
title.TextColor3 = Color3.fromRGB(0,255,255)
title.TextSize = 28
title.BackgroundTransparency = 1

-- Scroll container
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1,-20,1,-120)
scroll.Position = UDim2.new(0,10,0,60)
scroll.CanvasSize = UDim2.new(0,0,0,0)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 4
local list = Instance.new("UIListLayout", scroll)
list.Padding = UDim.new(0,6)
list.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Script list
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

-- Fungsi tombol script
local function createButton(name, link)
	local b = Instance.new("TextButton", scroll)
	b.Size = UDim2.new(0.9, 0, 0, 35)
	b.Text = name
	b.Font = Enum.Font.GothamBold
	b.TextSize = 16
	b.TextColor3 = Color3.fromRGB(0,255,255)
	b.BackgroundColor3 = Color3.fromRGB(15,15,40)
	b.AutoButtonColor = false
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
	local s = Instance.new("UIStroke", b)
	s.Color = Color3.fromRGB(0,255,255)
	s.Thickness = 1
	b.MouseButton1Click:Connect(function()
		loadstring(game:HttpGet(link))()
	end)
end

for n,l in pairs(scripts) do createButton(n,l) end

-- Tombol bawah
local bottom = Instance.new("Frame", main)
bottom.Size = UDim2.new(1,-20,0,50)
bottom.Position = UDim2.new(0,10,1,-60)
bottom.BackgroundTransparency = 1
local bottomLayout = Instance.new("UIListLayout", bottom)
bottomLayout.FillDirection = Enum.FillDirection.Horizontal
bottomLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
bottomLayout.Padding = UDim.new(0,8)

local function makeSmallButton(text, color)
	local b = Instance.new("TextButton", bottom)
	b.Size = UDim2.new(0.3,0,1,0)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.TextColor3 = Color3.fromRGB(0,255,255)
	b.BackgroundColor3 = color
	b.BackgroundTransparency = 0.5
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
	return b
end

local refresh = makeSmallButton("🔁 Refresh", Color3.fromRGB(15,15,35))
local exit = makeSmallButton("❌ Exit", Color3.fromRGB(25,10,10))
local info = makeSmallButton("🧠 Info", Color3.fromRGB(10,25,25))

refresh.MouseButton1Click:Connect(function()
	for _,v in pairs(scroll:GetChildren()) do
		if v:IsA("TextButton") then v:Destroy() end
	end
	for n,l in pairs(scripts) do createButton(n,l) end
end)

exit.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

info.MouseButton1Click:Connect(function()
	game.StarterGui:SetCore("SendNotification", {
		Title = "LEX HOST FUTURISTIC";
		Text = "Created by Putra Botz | v3.0 | Smooth UI Ready";
		Duration = 5;
	})
end)

-- Animasi buka/tutup
local open = false
local tweenIn = TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	{Size = UDim2.new(0,420,0,520), BackgroundTransparency = 0.2})
local tweenOut = TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
	{Size = UDim2.new(0,380,0,470), BackgroundTransparency = 1})

toggle.MouseButton1Click:Connect(function()
	open = not open
	if open then
		main.Visible = true
		tweenIn:Play()
	else
		tweenOut:Play()
		task.wait(0.3)
		main.Visible = false
	end
end)

print("✅ LEX Host Futuristic UI v3.0 Loaded | Animated Edition")
