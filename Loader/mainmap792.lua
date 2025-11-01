--// LEX Host - Futuristic v2.5.2 (Full Fix)
--// Advanced GUI by ChatGPT

local LEX = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Close = Instance.new("TextButton")
local Minimize = Instance.new("TextButton")
local LeftMenu = Instance.new("Frame")
local ContentFrame = Instance.new("Frame")
local Scroll = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local Corner = Instance.new("UICorner")

LEX.Name = "LEXHost"
LEX.Parent = game.CoreGui
LEX.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

--// Main Frame
MainFrame.Name = "MainFrame"
MainFrame.Parent = LEX
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 15, 30)
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0

Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = MainFrame

--// Title Bar
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 25, 50)
TitleBar.BorderSizePixel = 0

Title.Name = "Title"
Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(0, 300, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "LEX Host  |  Futuristic v2.5.2"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

--// Buttons
Minimize.Name = "Minimize"
Minimize.Parent = TitleBar
Minimize.Size = UDim2.new(0, 30, 0, 25)
Minimize.Position = UDim2.new(1, -65, 0, 5)
Minimize.Text = "-"
Minimize.Font = Enum.Font.GothamBold
Minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
Minimize.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Minimize.TextSize = 18
Minimize.BorderSizePixel = 0

Close.Name = "Close"
Close.Parent = TitleBar
Close.Size = UDim2.new(0, 30, 0, 25)
Close.Position = UDim2.new(1, -30, 0, 5)
Close.Text = "X"
Close.Font = Enum.Font.GothamBold
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.BackgroundColor3 = Color3.fromRGB(255, 60, 90)
Close.TextSize = 14
Close.BorderSizePixel = 0

--// Left Menu
LeftMenu.Name = "LeftMenu"
LeftMenu.Parent = MainFrame
LeftMenu.BackgroundColor3 = Color3.fromRGB(15, 25, 50)
LeftMenu.Position = UDim2.new(0, 0, 0, 35)
LeftMenu.Size = UDim2.new(0, 120, 1, -35)

local menuNames = {"Home", "Modes", "Movement", "Utilities", "Info"}

for i, name in ipairs(menuNames) do
	local btn = Instance.new("TextButton")
	btn.Parent = LeftMenu
	btn.Size = UDim2.new(1, 0, 0, 40)
	btn.Position = UDim2.new(0, 0, 0, (i - 1) * 42)
	btn.BackgroundColor3 = Color3.fromRGB(25, 40, 70)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.Text = name
	btn.BorderSizePixel = 0
	
	btn.MouseEnter:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
	end)
	btn.MouseLeave:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(25, 40, 70)
	end)
end

--// Content Frame
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.Position = UDim2.new(0, 130, 0, 45)
ContentFrame.Size = UDim2.new(1, -140, 1, -55)
ContentFrame.BackgroundTransparency = 1

--// Title Text
local ModeTitle = Instance.new("TextLabel")
ModeTitle.Parent = ContentFrame
ModeTitle.Size = UDim2.new(1, 0, 0, 30)
ModeTitle.Font = Enum.Font.GothamBold
ModeTitle.Text = "Modes / Gunung"
ModeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
ModeTitle.TextSize = 16
ModeTitle.BackgroundTransparency = 1
ModeTitle.TextXAlignment = Enum.TextXAlignment.Left

local SubText = Instance.new("TextLabel")
SubText.Parent = ContentFrame
SubText.Size = UDim2.new(1, 0, 0, 20)
SubText.Position = UDim2.new(0, 0, 0, 25)
SubText.Font = Enum.Font.Gotham
SubText.Text = "Klik salah satu untuk menjalankan skrip yang bersangkutan."
SubText.TextColor3 = Color3.fromRGB(200, 200, 200)
SubText.TextSize = 12
SubText.BackgroundTransparency = 1
SubText.TextXAlignment = Enum.TextXAlignment.Left

--// Scroll Area
Scroll.Parent = ContentFrame
Scroll.Size = UDim2.new(1, 0, 1, -50)
Scroll.Position = UDim2.new(0, 0, 0, 50)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 700)
Scroll.ScrollBarThickness = 6
Scroll.BackgroundTransparency = 1

UIListLayout.Parent = Scroll
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function makeButton(name, link)
	local btn = Instance.new("TextButton")
	btn.Parent = Scroll
	btn.Size = UDim2.new(1, 0, 0, 35)
	btn.BackgroundColor3 = Color3.fromRGB(0, 90, 200)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.Text = name
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = false
	
	btn.MouseEnter:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(0, 130, 255)
	end)
	btn.MouseLeave:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(0, 90, 200)
	end)
	
	btn.MouseButton1Click:Connect(function()
		loadstring(game:HttpGet(link))()
	end)
end

--// Mount List
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
