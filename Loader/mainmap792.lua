--// LEX Host v3 - Cyber Neon Transparent Edition
--// Made by LEX Dev
--// Lightweight Version - Content loaded from GitHub

local LEXHost = Instance.new("ScreenGui", game.CoreGui)
LEXHost.Name = "LEXHost"
LEXHost.ResetOnSpawn = false

-- Logo LX Horizontal (Toggle Button)
local LogoButton = Instance.new("TextButton", LEXHost)
LogoButton.Text = "LX"
LogoButton.Font = Enum.Font.GothamBlack
LogoButton.TextSize = 32
LogoButton.TextColor3 = Color3.fromRGB(0, 220, 255)
LogoButton.Position = UDim2.new(0.5, -40, 0.05, 0)
LogoButton.Size = UDim2.new(0, 80, 0, 50)
LogoButton.BackgroundColor3 = Color3.fromRGB(10, 20, 40)
LogoButton.BackgroundTransparency = 0.3
LogoButton.BorderSizePixel = 0
LogoButton.AutoButtonColor = false
LogoButton.ZIndex = 10
local LogoCorner = Instance.new("UICorner", LogoButton)
LogoCorner.CornerRadius = UDim.new(0, 12)
local LogoStroke = Instance.new("UIStroke", LogoButton)
LogoStroke.Color = Color3.fromRGB(0, 200, 255)
LogoStroke.Thickness = 2.5

-- Glow effect untuk logo
LogoButton.MouseEnter:Connect(function()
	LogoButton.TextColor3 = Color3.fromRGB(100, 255, 255)
	LogoStroke.Thickness = 3
end)
LogoButton.MouseLeave:Connect(function()
	LogoButton.TextColor3 = Color3.fromRGB(0, 220, 255)
	LogoStroke.Thickness = 2.5
end)

local MainFrame = Instance.new("Frame")
MainFrame.Parent = LEXHost
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 620, 0, 400)
MainFrame.BackgroundColor3 = Color3.fromRGB(5, 10, 25)
MainFrame.BackgroundTransparency = 0.35
MainFrame.Visible = true
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

local LX = Instance.new("TextLabel", TopBar)
LX.Text = "LX"
LX.Font = Enum.Font.GothamBlack
LX.TextSize = 24
LX.TextColor3 = Color3.fromRGB(0, 200, 255)
LX.Position = UDim2.new(0, 10, 0, 0)
LX.Size = UDim2.new(0, 40, 1, 0)
LX.BackgroundTransparency = 1
LX.TextXAlignment = Enum.TextXAlignment.Center

local Title = Instance.new("TextLabel", TopBar)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 60, 0, 0)
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "LEX Host v3 - Cyber Neon UI"
Title.TextColor3 = Color3.fromRGB(0, 190, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

local MinBtn = Instance.new("TextButton", TopBar)
MinBtn.Text = "-"
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(0.88, 0, 0.13, 0)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 18
MinBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
MinBtn.TextColor3 = Color3.fromRGB(0, 200, 255)
Instance.new("UICorner", MinBtn)

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(0.94, 0, 0.13, 0)
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

-- Variables
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- GitHub URLs Configuration
local GITHUB_URLS = {
	Home = "https://raw.githubusercontent.com/putraborz/lexhostlkp/refs/heads/main/Loader/Home.lua",
	Modes = "https://raw.githubusercontent.com/putraborz/lexhostlkp/refs/heads/main/Loader/Modes.lua",
	Movement = "https://raw.githubusercontent.com/putraborz/lexhostlkp/refs/heads/main/Loader/Movement.lua",
	Utilities = "https://raw.githubusercontent.com/putraborz/lexhostlkp/refs/heads/main/Loader/Utilities.lua",
	Info = "https://raw.githubusercontent.com/putraborz/lexhostlkp/refs/heads/main/Loader/Info.lua"
}

-- Function to load from GitHub
local function LoadModule(moduleName)
	local url = GITHUB_URLS[moduleName]
	if not url then
		warn("Module " .. moduleName .. " not found in configuration")
		return nil
	end
	
	local success, result = pcall(function()
		return loadstring(game:HttpGet(url))()
	end)
	if success then
		return result
	else
		warn("Failed to load " .. moduleName .. ": " .. tostring(result))
		return nil
	end
end

-- Loading Screen
local LoadingFrame = Instance.new("Frame", Content)
LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingFrame.BackgroundTransparency = 1
LoadingFrame.Visible = true

local LoadingText = Instance.new("TextLabel", LoadingFrame)
LoadingText.Size = UDim2.new(1, 0, 1, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "Loading modules from GitHub..."
LoadingText.TextColor3 = Color3.fromRGB(0, 200, 255)
LoadingText.Font = Enum.Font.GothamBold
LoadingText.TextSize = 16

-- Create Pages
local HomePage = Instance.new("ScrollingFrame", Content)
HomePage.Name = "Home"
HomePage.Size = UDim2.new(1, 0, 1, 0)
HomePage.BackgroundTransparency = 1
HomePage.BorderSizePixel = 0
HomePage.ScrollBarThickness = 6
HomePage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
HomePage.CanvasSize = UDim2.new(0, 0, 0, 300)
HomePage.Visible = false

local ModesPage = Instance.new("ScrollingFrame", Content)
ModesPage.Name = "Modes"
ModesPage.Size = UDim2.new(1, 0, 1, 0)
ModesPage.CanvasSize = UDim2.new(0, 0, 2, 0)
ModesPage.ScrollBarThickness = 6
ModesPage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
ModesPage.BackgroundTransparency = 1
ModesPage.BorderSizePixel = 0
ModesPage.Visible = false

local MovementPage = Instance.new("ScrollingFrame", Content)
MovementPage.Name = "Movement"
MovementPage.Size = UDim2.new(1, 0, 1, 0)
MovementPage.BackgroundTransparency = 1
MovementPage.BorderSizePixel = 0
MovementPage.ScrollBarThickness = 6
MovementPage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
MovementPage.CanvasSize = UDim2.new(0, 0, 0, 400)
MovementPage.Visible = false

local UtilitiesPage = Instance.new("ScrollingFrame", Content)
UtilitiesPage.Name = "Utilities"
UtilitiesPage.Size = UDim2.new(1, 0, 1, 0)
UtilitiesPage.BackgroundTransparency = 1
UtilitiesPage.BorderSizePixel = 0
UtilitiesPage.ScrollBarThickness = 6
UtilitiesPage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
UtilitiesPage.CanvasSize = UDim2.new(0, 0, 0, 600)
UtilitiesPage.Visible = false

local InfoPage = Instance.new("ScrollingFrame", Content)
InfoPage.Name = "Info"
InfoPage.Size = UDim2.new(1, 0, 1, 0)
InfoPage.BackgroundTransparency = 1
InfoPage.BorderSizePixel = 0
InfoPage.ScrollBarThickness = 6
InfoPage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
InfoPage.CanvasSize = UDim2.new(0, 0, 0, 350)
InfoPage.Visible = false

-- Load Modules from GitHub
spawn(function()
	wait(0.5)
	
	-- Load Home Module
	local HomeModule = LoadModule("Home")
	if HomeModule then
		HomeModule.Initialize(HomePage)
	end
	
	-- Load Modes Module
	local ModesModule = LoadModule("Modes")
	if ModesModule then
		ModesModule.Initialize(ModesPage)
	end
	
	-- Load Movement Module
	local MovementModule = LoadModule("Movement")
	if MovementModule then
		MovementModule.Initialize(MovementPage, player, character)
	end
	
	-- Load Utilities Module
	local UtilitiesModule = LoadModule("Utilities")
	if UtilitiesModule then
		UtilitiesModule.Initialize(UtilitiesPage, player, character)
	end
	
	-- Load Info Module
	local InfoModule = LoadModule("Info")
	if InfoModule then
		InfoModule.Initialize(InfoPage)
	end
	
	-- Hide loading, show home
	LoadingFrame.Visible = false
	HomePage.Visible = true
end)

-- Tab System
local function ShowTab(tab)
	HomePage.Visible = false
	ModesPage.Visible = false
	MovementPage.Visible = false
	UtilitiesPage.Visible = false
	InfoPage.Visible = false
	LoadingFrame.Visible = false
	
	if tab == "Home" then
		HomePage.Visible = true
	elseif tab == "Modes" then
		ModesPage.Visible = true
	elseif tab == "Movement" then
		MovementPage.Visible = true
	elseif tab == "Utilities" then
		UtilitiesPage.Visible = true
	elseif tab == "Info" then
		InfoPage.Visible = true
	end
end

for n, b in pairs(Buttons) do
	b.MouseButton1Click:Connect(function() ShowTab(n) end)
end

-- Logo Button Toggle
LogoButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

-- Minimize
MinBtn.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
end)

-- Close
CloseBtn.MouseButton1Click:Connect(function()
	LEXHost:Destroy()
end)

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

print("LEX Host v3 loaded successfully!")
