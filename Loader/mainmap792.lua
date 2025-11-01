--// LEX Host - Futuristic v2.5.1
--// Made by ChatGPT (LEX UI Custom)

local LEX = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Close = Instance.new("TextButton")
local Minimize = Instance.new("TextButton")
local LeftMenu = Instance.new("Frame")
local Buttons = {}
local ContentFrame = Instance.new("Frame")
local Scroll = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

LEX.Name = "LEXHost"
LEX.Parent = game.CoreGui
LEX.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

--// Main Frame
MainFrame.Name = "MainFrame"
MainFrame.Parent = LEX
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 18, 35)
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = true
MainFrame.BackgroundTransparency = 0.1
MainFrame.ZIndex = 2

--// Title Bar
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 30, 55)
TitleBar.BorderSizePixel = 0

Title.Name = "Title"
Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(0, 250, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "LEX Host"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

Minimize.Name = "Minimize"
Minimize.Parent = TitleBar
Minimize.Size = UDim2.new(0, 30, 0, 25)
Minimize.Position = UDim2.new(1, -60, 0, 2)
Minimize.Text = "-"
Minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
Minimize.Font = Enum.Font.GothamBold
Minimize.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Minimize.TextSize = 18

Close.Name = "Close"
Close.Parent = TitleBar
Close.Size = UDim2.new(0, 30, 0, 25)
Close.Position = UDim2.new(1, -30, 0, 2)
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.Font = Enum.Font.GothamBold
Close.BackgroundColor3 = Color3.fromRGB(255, 0, 75)
Close.TextSize = 14

--// Left Menu
LeftMenu.Name = "LeftMenu"
LeftMenu.Parent = MainFrame
LeftMenu.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
LeftMenu.Position = UDim2.new(0, 0, 0, 30)
LeftMenu.Size = UDim2.new(0, 120, 1, -30)

local menuNames = {"Home", "Modes", "Movement", "Utilities", "Info"}

for i, name in ipairs(menuNames) do
	local btn = Instance.new("TextButton")
	btn.Parent = LeftMenu
	btn.Size = UDim2.new(1, 0, 0, 40)
	btn.Position = UDim2.new(0, 0, 0, (i - 1) * 42)
	btn.BackgroundColor3 = Color3.fromRGB(25, 35, 65)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.Text = name
	btn.BorderSizePixel = 0
	Buttons[name] = btn
end

--// Content Frame
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.Position = UDim2.new(0, 130, 0, 40)
ContentFrame.Size = UDim2.new(1, -140, 1, -50)
ContentFrame.BackgroundTransparency = 1

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = ContentFrame
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "Modes / Gunung"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

--// Scroll List
Scroll.Parent = ContentFrame
Scroll.Size = UDim2.new(1, 0, 1, -30)
Scroll.Position = UDim2.new(0, 0, 0, 30)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 1000)
Scroll.ScrollBarThickness = 6
Scroll.BackgroundTransparency = 1

UIListLayout.Parent = Scroll
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function makeButton(name, link)
	local btn = Instance.new("TextButton")
	btn.Parent = Scroll
	btn.Size = UDim2.new(1, 0, 0, 35)
	btn.BackgroundColor3 = Color3.fromRGB(0, 80, 180)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.Text = name
	btn.BorderSizePixel = 0
	btn.MouseButton1Click:Connect(function()
		loadstring(game:HttpGet(link))()
	end)
end

--// Mount list
local mounts = {
	{"ATIN NEW", "https://pastebin.com/raw/iw5xHtvD"},
	{"YAHAYUK NEW", "https://pastebin.com/raw/UK8nspn0"},
	{"WKSPEDISI ANTARTIKA NEW", "https://pastebin.com/raw/mqEjFxVj"},
	{"MOUNT YNTKTS NEW", "https://pastebin.com/raw/k0bc5h4m"},
	{"SAKAHAYNG", "https://pastebin.com/raw/zishUBsB"},
	{"STECU NEW", "https://pastebin.com/raw/VdUnM88V"},
	{"BALI HOT EXPEDITION", "https://pastebin.com/raw/e82WGJas"},
	{"MOUNT KOMANG", "https://pastebin.com/raw/QYcyGtMR"},
	{"MOUNT PRAMBANAN", "https://pastebin.com/raw/GysqQgpx"},
	{"MOUNT MONO", "https://pastebin.com/raw/Ha8qwDeB"},
	{"MOUNT SUMBING", "https://pastebin.com/raw/FqQwFJLe"},
	{"MOUNT GEMI", "https://pastebin.com/raw/516Y0aw1"},
	{"MOUNT KOHARU", "https://pastebin.com/raw/Rs6hy7xx"},
}

for _, v in pairs(mounts) do
	makeButton(v[1], v[2])
end

--// Functions
Close.MouseButton1Click:Connect(function()
	LEX:Destroy()
end)

local minimized = false
Minimize.MouseButton1Click:Connect(function()
	minimized = not minimized
	ContentFrame.Visible = not minimized
	LeftMenu.Visible = not minimized
end)
