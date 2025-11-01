-- // LEX Host v3 - Cyber Futuristic Blue (Transparent Edition)
-- // Made by LEX Dev (Futuristic Edition)
-- // Fully Functional UI with Scroll & Neon Effects

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local MinimizeButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local LXLogo = Instance.new("TextLabel")
local SideBar = Instance.new("Frame")
local Buttons = {}
local ContentFrame = Instance.new("Frame")

ScreenGui.Name = "LEXHost"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = 0.25
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 600, 0, 400)

local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.fromRGB(0, 140, 255)
Stroke.Thickness = 2
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local Corner = Instance.new("UICorner", MainFrame)
Corner.CornerRadius = UDim.new(0, 12)

-- Top Bar
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
TopBar.BackgroundTransparency = 0.4
TopBar.Size = UDim2.new(1, 0, 0, 40)

local TopStroke = Instance.new("UIStroke", TopBar)
TopStroke.Color = Color3.fromRGB(0, 170, 255)
TopStroke.Thickness = 1

Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(0.5, 0, 1, 0)
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "LEX Host - Cyber Futuristic v3.0"
Title.TextColor3 = Color3.fromRGB(0, 170, 255)
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left

MinimizeButton.Parent = TopBar
MinimizeButton.Text = "-"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(0.9, 0, 0.1, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
MinimizeButton.TextColor3 = Color3.fromRGB(0, 200, 255)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 18

CloseButton.Parent = TopBar
CloseButton.Text = "X"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(0.95, 0, 0.1, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(60, 10, 10)
CloseButton.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18

LXLogo.Parent = ScreenGui
LXLogo.Text = "LX"
LXLogo.Font = Enum.Font.GothamBlack
LXLogo.TextSize = 24
LXLogo.TextColor3 = Color3.fromRGB(180, 220, 255)
LXLogo.Position = UDim2.new(0.5, -25, 0.05, 0)
LXLogo.Size = UDim2.new(0, 50, 0, 30)
LXLogo.BackgroundTransparency = 1

-- Sidebar
SideBar.Name = "SideBar"
SideBar.Parent = MainFrame
SideBar.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
SideBar.BackgroundTransparency = 0.4
SideBar.Size = UDim2.new(0, 130, 1, -40)
SideBar.Position = UDim2.new(0, 0, 0, 40)

local sideCorner = Instance.new("UICorner", SideBar)
sideCorner.CornerRadius = UDim.new(0, 8)

local buttonNames = {"Home", "Modes", "Movement", "Utilities", "Info"}
for i, name in ipairs(buttonNames) do
	local btn = Instance.new("TextButton")
	btn.Parent = SideBar
	btn.Text = name
	btn.Size = UDim2.new(1, -10, 0, 40)
	btn.Position = UDim2.new(0, 5, 0, (i - 1) * 45 + 10)
	btn.BackgroundColor3 = Color3.fromRGB(15, 20, 40)
	btn.TextColor3 = Color3.fromRGB(0, 170, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.AutoButtonColor = false

	local stroke = Instance.new("UIStroke", btn)
	stroke.Color = Color3.fromRGB(0, 170, 255)
	stroke.Thickness = 1

	local corner = Instance.new("UICorner", btn)
	corner.CornerRadius = UDim.new(0, 6)

	btn.MouseEnter:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(25, 35, 60)
	end)
	btn.MouseLeave:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(15, 20, 40)
	end)

	Buttons[name] = btn
end

-- Content Area
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 140, 0, 50)
ContentFrame.Size = UDim2.new(1, -150, 1, -60)

-- Scrollable Gunung List
local ScrollFrame = Instance.new("ScrollingFrame", ContentFrame)
ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
ScrollFrame.Visible = false

local gunungList = {
	"ATIN NEW","YAHAYUK NEW","WKSPEDISI ANTARTIKA NEW","MOUNT YNTKTS NEW",
	"SAKAHAYNG","STECU NEW","BALI HOT EXPEDITION","MOUNT KOMANG",
	"MOUNT PRAMBANAN","MOUNT MONO","MOUNT SUMBING","MOUNT GEMI","MOUNT KOHARU"
}

for i, g in ipairs(gunungList) do
	local btn = Instance.new("TextButton")
	btn.Parent = ScrollFrame
	btn.Size = UDim2.new(1, -10, 0, 35)
	btn.Position = UDim2.new(0, 5, 0, (i - 1) * 40)
	btn.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
	btn.Text = g
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.TextColor3 = Color3.fromRGB(0, 170, 255)

	local s = Instance.new("UIStroke", btn)
	s.Color = Color3.fromRGB(0, 140, 255)
	s.Thickness = 1

	local c = Instance.new("UICorner", btn)
	c.CornerRadius = UDim.new(0, 5)

	btn.MouseButton1Click:Connect(function()
		loadstring(game:HttpGet("https://pastebin.com/raw/"..({
			["ATIN NEW"]="iw5xHtvD",["YAHAYUK NEW"]="UK8nspn0",
			["WKSPEDISI ANTARTIKA NEW"]="mqEjFxVj",["MOUNT YNTKTS NEW"]="k0bc5h4m",
			["SAKAHAYNG"]="zishUBsB",["STECU NEW"]="VdUnM88V",
			["BALI HOT EXPEDITION"]="e82WGJas",["MOUNT KOMANG"]="QYcyGtMR",
			["MOUNT PRAMBANAN"]="GysqQgpx",["MOUNT MONO"]="Ha8qwDeB",
			["MOUNT SUMBING"]="FqQwFJLe",["MOUNT GEMI"]="516Y0aw1",
			["MOUNT KOHARU"]="Rs6hy7xx"
		})[g]))()
	end)
end

-- Button Functions
local function showTab(name)
	for _, child in pairs(ContentFrame:GetChildren()) do
		child.Visible = false
	end
	if name == "Modes" then
		ScrollFrame.Visible = true
	else
		local t = Instance.new("TextLabel", ContentFrame)
		t.BackgroundTransparency = 1
		t.Text = "Menu: "..name.." sedang dikembangkan..."
		t.TextColor3 = Color3.fromRGB(0, 170, 255)
		t.Font = Enum.Font.GothamBold
		t.TextSize = 16
		t.Size = UDim2.new(1, 0, 1, 0)
	end
end

for name, btn in pairs(Buttons) do
	btn.MouseButton1Click:Connect(function()
		showTab(name)
	end)
end

-- Minimize & Close
MinimizeButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)
CloseButton.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

-- Draggable
local UIS = game:GetService("UserInputService")
local dragToggle, dragInput, dragStart, startPos

TopBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragToggle = true
		dragStart = input.Position
		startPos = MainFrame.Position
	end
end)

TopBar.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragToggle = false
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragToggle and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)
