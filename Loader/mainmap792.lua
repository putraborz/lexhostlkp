--// LEX Host v3 - Cyber Neon Transparent Edition
--// Made by LEX Dev
--// Fully Functional & Scrollable Menu

local LEXHost = Instance.new("ScreenGui", game.CoreGui)
LEXHost.Name = "LEXHost"

local MainFrame = Instance.new("Frame")
MainFrame.Parent = LEXHost
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 620, 0, 400)
MainFrame.BackgroundColor3 = Color3.fromRGB(5, 10, 25)
MainFrame.BackgroundTransparency = 0.35
Instance.new("UICorner", MainFrame)
local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.fromRGB(0, 180, 255)
Stroke.Thickness = 2

-- Topbar
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(10, 15, 35)
TopBar.BackgroundTransparency = 0.4
Instance.new("UICorner", TopBar)

local Title = Instance.new("TextLabel", TopBar)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.03, 0, 0, 0)
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "LEX Host v3 - Cyber Neon UI"
Title.TextColor3 = Color3.fromRGB(0, 190, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Logo
local LX = Instance.new("TextLabel", LEXHost)
LX.Text = "LX"
LX.Font = Enum.Font.GothamBlack
LX.TextSize = 28
LX.TextColor3 = Color3.fromRGB(0, 200, 255)
LX.Position = UDim2.new(0.5, -20, 0.08, 0)
LX.BackgroundTransparency = 1

-- Minimize & Close
local MinBtn = Instance.new("TextButton", TopBar)
MinBtn.Text = "-"
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(0.88, 0, 0.1, 0)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 18
MinBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
MinBtn.TextColor3 = Color3.fromRGB(0, 200, 255)
Instance.new("UICorner", MinBtn)

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(0.94, 0, 0.1, 0)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
Instance.new("UICorner", CloseBtn)

-- Sidebar
local Side = Instance.new("Frame", MainFrame)
Side.Position = UDim2.new(0, 0, 0, 40)
Side.Size = UDim2.new(0, 140, 1, -40)
Side.BackgroundColor3 = Color3.fromRGB(8, 15, 35)
Side.BackgroundTransparency = 0.4
Instance.new("UICorner", Side)

local Tabs = {"Home","Modes","Movement","Utilities","Info"}
local Buttons = {}
for i, v in ipairs(Tabs) do
	local B = Instance.new("TextButton", Side)
	B.Text = v
	B.Size = UDim2.new(1, -10, 0, 40)
	B.Position = UDim2.new(0, 5, 0, (i - 1) * 45 + 10)
	B.BackgroundColor3 = Color3.fromRGB(15, 25, 50)
	B.TextColor3 = Color3.fromRGB(0, 200, 255)
	B.Font = Enum.Font.GothamBold
	B.TextSize = 14
	B.AutoButtonColor = false
	local s = Instance.new("UIStroke", B)
	s.Color = Color3.fromRGB(0, 190, 255)
	s.Thickness = 1
	Instance.new("UICorner", B)
	B.MouseEnter:Connect(function() B.BackgroundColor3 = Color3.fromRGB(20,35,70) end)
	B.MouseLeave:Connect(function() B.BackgroundColor3 = Color3.fromRGB(15,25,50) end)
	Buttons[v] = B
end

-- Content Area
local Content = Instance.new("Frame", MainFrame)
Content.Position = UDim2.new(0, 150, 0, 50)
Content.Size = UDim2.new(1, -160, 1, -60)
Content.BackgroundTransparency = 1

-- Scrollable "Modes" page
local Scroll = Instance.new("ScrollingFrame", Content)
Scroll.Size = UDim2.new(1, 0, 1, 0)
Scroll.CanvasSize = UDim2.new(0, 0, 2, 0)
Scroll.ScrollBarThickness = 6
Scroll.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
Scroll.Visible = false

local Gunung = {
"ATIN NEW","YAHAYUK NEW","WKSPEDISI ANTARTIKA NEW","MOUNT YNTKTS NEW",
"SAKAHAYNG","STECU NEW","BALI HOT EXPEDITION","MOUNT KOMANG",
"MOUNT PRAMBANAN","MOUNT MONO","MOUNT SUMBING","MOUNT GEMI","MOUNT KOHARU"
}

for i, name in ipairs(Gunung) do
	local btn = Instance.new("TextButton", Scroll)
	btn.Size = UDim2.new(1, -10, 0, 35)
	btn.Position = UDim2.new(0, 5, 0, (i - 1) * 40)
	btn.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
	btn.Text = name
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.TextColor3 = Color3.fromRGB(0, 190, 255)
	local s = Instance.new("UIStroke", btn)
	s.Color = Color3.fromRGB(0, 160, 255)
	s.Thickness = 1
	Instance.new("UICorner", btn)
	btn.MouseButton1Click:Connect(function()
		local ids = {
			["ATIN NEW"]="iw5xHtvD",["YAHAYUK NEW"]="UK8nspn0",
			["WKSPEDISI ANTARTIKA NEW"]="mqEjFxVj",["MOUNT YNTKTS NEW"]="k0bc5h4m",
			["SAKAHAYNG"]="zishUBsB",["STECU NEW"]="VdUnM88V",
			["BALI HOT EXPEDITION"]="e82WGJas",["MOUNT KOMANG"]="QYcyGtMR",
			["MOUNT PRAMBANAN"]="GysqQgpx",["MOUNT MONO"]="Ha8qwDeB",
			["MOUNT SUMBING"]="FqQwFJLe",["MOUNT GEMI"]="516Y0aw1",
			["MOUNT KOHARU"]="Rs6hy7xx"
		}
		loadstring(game:HttpGet("https://pastebin.com/raw/"..ids[name]))()
	end)
end

-- Tab System
local function ShowTab(tab)
	for _, c in pairs(Content:GetChildren()) do c.Visible = false end
	if tab == "Modes" then
		Scroll.Visible = true
	else
		local T = Instance.new("TextLabel", Content)
		T.BackgroundTransparency = 1
		T.Text = tab.." page under construction..."
		T.TextColor3 = Color3.fromRGB(0, 200, 255)
		T.Font = Enum.Font.GothamBold
		T.TextSize = 16
		T.Size = UDim2.new(1, 0, 1, 0)
	end
end

for n, b in pairs(Buttons) do
	b.MouseButton1Click:Connect(function() ShowTab(n) end)
end

-- Draggable
local UIS = game:GetService("UserInputService")
local dragging, dragInput, startPos, startDrag
TopBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		startDrag = input.Position
		startPos = MainFrame.Position
	end
end)
TopBar.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)
UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - startDrag
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Minimize & Close
MinBtn.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)
CloseBtn.MouseButton1Click:Connect(function()
	LEXHost:Destroy()
end)
