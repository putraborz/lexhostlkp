--// LEX Host v3 - Cyber Neon Transparent Edition
--// Made by LEX Dev
--// Fully Functional & Enhanced Version

local LEXHost = Instance.new("ScreenGui", game.CoreGui)
LEXHost.Name = "LEXHost"
LEXHost.ResetOnSpawn = false

-- Logo Image Button (Draggable Toggle Button)
local LogoButton = Instance.new("ImageButton", LEXHost)
LogoButton.Image = "rbxassetid://89824085338530"
LogoButton.Position = UDim2.new(0.5, -40, 0.05, 0)
LogoButton.Size = UDim2.new(0, 80, 0, 80)
LogoButton.BackgroundColor3 = Color3.fromRGB(10, 20, 40)
LogoButton.BackgroundTransparency = 0.3
LogoButton.BorderSizePixel = 0
LogoButton.AutoButtonColor = false
LogoButton.ZIndex = 10
LogoButton.Active = true
LogoButton.Draggable = true
LogoButton.ScaleType = Enum.ScaleType.Fit
local LogoCorner = Instance.new("UICorner", LogoButton)
LogoCorner.CornerRadius = UDim.new(0, 12)
local LogoStroke = Instance.new("UIStroke", LogoButton)
LogoStroke.Color = Color3.fromRGB(0, 200, 255)
LogoStroke.Thickness = 2.5

-- Glow effect untuk logo
LogoButton.MouseEnter:Connect(function()
	LogoButton.ImageColor3 = Color3.fromRGB(150, 255, 255)
	LogoStroke.Thickness = 3.5
end)
LogoButton.MouseLeave:Connect(function()
	LogoButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
	LogoStroke.Thickness = 2.5
end)

local MainFrame = Instance.new("Frame")
MainFrame.Parent = LEXHost
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 680, 0, 450)
MainFrame.BackgroundColor3 = Color3.fromRGB(5, 10, 25)
MainFrame.BackgroundTransparency = 0.15
MainFrame.Visible = true
MainFrame.ClipsDescendants = true
local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 15)
local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.fromRGB(0, 180, 255)
Stroke.Thickness = 3

-- Shadow effect
local Shadow = Instance.new("ImageLabel", MainFrame)
Shadow.Name = "Shadow"
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.Size = UDim2.new(1, 30, 1, 30)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://6014261993"
Shadow.ImageColor3 = Color3.fromRGB(0, 150, 255)
Shadow.ImageTransparency = 0.7
Shadow.ZIndex = -1

-- Topbar
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundColor3 = Color3.fromRGB(10, 15, 35)
TopBar.BackgroundTransparency = 0.2
local TopCorner = Instance.new("UICorner", TopBar)
TopCorner.CornerRadius = UDim.new(0, 15)

-- Logo Image di TopBar
local LX = Instance.new("ImageLabel", TopBar)
LX.Image = "rbxassetid://89824085338530"
LX.Position = UDim2.new(0, 10, 0, 5)
LX.Size = UDim2.new(0, 40, 0, 40)
LX.BackgroundTransparency = 1
LX.ScaleType = Enum.ScaleType.Fit

local Title = Instance.new("TextLabel", TopBar)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 60, 0, 0)
Title.Size = UDim2.new(0.5, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "LEX Host v3 - Vip Edition"
Title.TextColor3 = Color3.fromRGB(0, 190, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Minimize & Close
local MinBtn = Instance.new("TextButton", TopBar)
MinBtn.Text = "−"
MinBtn.Size = UDim2.new(0, 35, 0, 35)
MinBtn.Position = UDim2.new(1, -85, 0.5, -17.5)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 20
MinBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
MinBtn.TextColor3 = Color3.fromRGB(0, 200, 255)
MinBtn.BorderSizePixel = 0
local MinCorner = Instance.new("UICorner", MinBtn)
MinCorner.CornerRadius = UDim.new(0, 8)
MinBtn.MouseEnter:Connect(function() MinBtn.BackgroundColor3 = Color3.fromRGB(30, 45, 70) end)
MinBtn.MouseLeave:Connect(function() MinBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 50) end)

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Text = "✕"
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -40, 0.5, -17.5)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 20, 20)
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.BorderSizePixel = 0
local CloseCorner = Instance.new("UICorner", CloseBtn)
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseBtn.MouseEnter:Connect(function() CloseBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 30) end)
CloseBtn.MouseLeave:Connect(function() CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 20, 20) end)

-- Sidebar
local Side = Instance.new("Frame", MainFrame)
Side.Position = UDim2.new(0, 0, 0, 50)
Side.Size = UDim2.new(0, 160, 1, -50)
Side.BackgroundColor3 = Color3.fromRGB(8, 15, 35)
Side.BackgroundTransparency = 0.3
Side.BorderSizePixel = 0

local Tabs = {"Home","Mount","Movement","Utilities","Clone","Parts","Server","Donate","Info"}
local Buttons = {}
for i, v in ipairs(Tabs) do
	local B = Instance.new("TextButton", Side)
	B.Text = v
	B.Size = UDim2.new(1, -15, 0, 40)
	B.Position = UDim2.new(0, 7.5, 0, (i - 1) * 45 + 10)
	B.BackgroundColor3 = Color3.fromRGB(15, 25, 50)
	B.TextColor3 = Color3.fromRGB(0, 200, 255)
	B.Font = Enum.Font.GothamBold
	B.TextSize = 14
	B.AutoButtonColor = false
	B.BorderSizePixel = 0
	local s = Instance.new("UIStroke", B)
	s.Color = Color3.fromRGB(0, 190, 255)
	s.Thickness = 2
	s.Transparency = 0.5
	local c = Instance.new("UICorner", B)
	c.CornerRadius = UDim.new(0, 10)
	B.MouseEnter:Connect(function() 
		B.BackgroundColor3 = Color3.fromRGB(25,40,80)
		s.Thickness = 2.5
		s.Transparency = 0
	end)
	B.MouseLeave:Connect(function() 
		B.BackgroundColor3 = Color3.fromRGB(15,25,50)
		s.Thickness = 2
		s.Transparency = 0.5
	end)
	Buttons[v] = B
end

-- Content Area
local Content = Instance.new("Frame", MainFrame)
Content.Position = UDim2.new(0, 170, 0, 60)
Content.Size = UDim2.new(1, -180, 1, -70)
Content.BackgroundTransparency = 1

-- Variables
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- GitHub URLs Configuration
local GITHUB_URLS = {
	Home = "https://raw.githubusercontent.com/putraborz/lexhostlkp/refs/heads/main/Loader/Home.lua",
	Mount = "https://raw.githubusercontent.com/putraborz/lexhostlkp/refs/heads/main/Loader/Modes.lua",
	Movement = "https://raw.githubusercontent.com/putraborz/lexhostlkp/refs/heads/main/Loader/Movement.lua",
	Utilities = "https://raw.githubusercontent.com/putraborz/lexhostlkp/refs/heads/main/Loader/Utilities.lua",
	Clone = "https://raw.githubusercontent.com/putraborz/lexhostlkp/refs/heads/main/Loader/Clone.lua",
	Parts = "https://raw.githubusercontent.com/putraborz/lexhostlkp/refs/heads/main/Loader/Parts.lua",
	Server = "https://raw.githubusercontent.com/putraborz/lexhostlkp/refs/heads/main/Loader/Server.lua",
	Donate = "https://raw.githubusercontent.com/putraborz/lexhostlkp/refs/heads/main/Loader/Donate.lua",
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
LoadingText.Size = UDim2.new(1, 0, 0.3, 0)
LoadingText.Position = UDim2.new(0, 0, 0.35, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "⚡ Loading LEX Host v3..."
LoadingText.TextColor3 = Color3.fromRGB(0, 220, 255)
LoadingText.Font = Enum.Font.GothamBold
LoadingText.TextSize = 20

local LoadingDesc = Instance.new("TextLabel", LoadingFrame)
LoadingDesc.Size = UDim2.new(1, 0, 0.2, 0)
LoadingDesc.Position = UDim2.new(0, 0, 0.5, 0)
LoadingDesc.BackgroundTransparency = 1
LoadingDesc.Text = "Connecting to GitHub servers..."
LoadingDesc.TextColor3 = Color3.fromRGB(150, 200, 255)
LoadingDesc.Font = Enum.Font.Gotham
LoadingDesc.TextSize = 14

-- Create Pages
local HomePage = Instance.new("ScrollingFrame", Content)
HomePage.Name = "Home"
HomePage.Size = UDim2.new(1, 0, 1, 0)
HomePage.BackgroundTransparency = 1
HomePage.BorderSizePixel = 0
HomePage.ScrollBarThickness = 8
HomePage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
HomePage.CanvasSize = UDim2.new(0, 0, 0, 300)
HomePage.Visible = false

local MountPage = Instance.new("ScrollingFrame", Content)
MountPage.Name = "Mount"
MountPage.Size = UDim2.new(1, 0, 1, 0)
MountPage.CanvasSize = UDim2.new(0, 0, 2, 0)
MountPage.ScrollBarThickness = 8
MountPage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
MountPage.BackgroundTransparency = 1
MountPage.BorderSizePixel = 0
MountPage.Visible = false

local MovementPage = Instance.new("ScrollingFrame", Content)
MovementPage.Name = "Movement"
MovementPage.Size = UDim2.new(1, 0, 1, 0)
MovementPage.BackgroundTransparency = 1
MovementPage.BorderSizePixel = 0
MovementPage.ScrollBarThickness = 8
MovementPage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
MovementPage.CanvasSize = UDim2.new(0, 0, 0, 500)
MovementPage.Visible = false

local UtilitiesPage = Instance.new("ScrollingFrame", Content)
UtilitiesPage.Name = "Utilities"
UtilitiesPage.Size = UDim2.new(1, 0, 1, 0)
UtilitiesPage.BackgroundTransparency = 1
UtilitiesPage.BorderSizePixel = 0
UtilitiesPage.ScrollBarThickness = 8
UtilitiesPage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
UtilitiesPage.CanvasSize = UDim2.new(0, 0, 0, 600)
UtilitiesPage.Visible = false

local ClonePage = Instance.new("ScrollingFrame", Content)
ClonePage.Name = "Clone"
ClonePage.Size = UDim2.new(1, 0, 1, 0)
ClonePage.BackgroundTransparency = 1
ClonePage.BorderSizePixel = 0
ClonePage.ScrollBarThickness = 8
ClonePage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
ClonePage.CanvasSize = UDim2.new(0, 0, 0, 400)
ClonePage.Visible = false

local PartsPage = Instance.new("ScrollingFrame", Content)
PartsPage.Name = "Parts"
PartsPage.Size = UDim2.new(1, 0, 1, 0)
PartsPage.BackgroundTransparency = 1
PartsPage.BorderSizePixel = 0
PartsPage.ScrollBarThickness = 8
PartsPage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
PartsPage.CanvasSize = UDim2.new(0, 0, 0, 500)
PartsPage.Visible = false

local ServerPage = Instance.new("ScrollingFrame", Content)
ServerPage.Name = "Server"
ServerPage.Size = UDim2.new(1, 0, 1, 0)
ServerPage.BackgroundTransparency = 1
ServerPage.BorderSizePixel = 0
ServerPage.ScrollBarThickness = 8
ServerPage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
ServerPage.CanvasSize = UDim2.new(0, 0, 0, 500)
ServerPage.Visible = false

local DonatePage = Instance.new("ScrollingFrame", Content)
DonatePage.Name = "Donate"
DonatePage.Size = UDim2.new(1, 0, 1, 0)
DonatePage.BackgroundTransparency = 1
DonatePage.BorderSizePixel = 0
DonatePage.ScrollBarThickness = 8
DonatePage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
DonatePage.CanvasSize = UDim2.new(0, 0, 0, 300)
DonatePage.Visible = false

local InfoPage = Instance.new("ScrollingFrame", Content)
InfoPage.Name = "Info"
InfoPage.Size = UDim2.new(1, 0, 1, 0)
InfoPage.BackgroundTransparency = 1
InfoPage.BorderSizePixel = 0
InfoPage.ScrollBarThickness = 8
InfoPage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
InfoPage.CanvasSize = UDim2.new(0, 0, 0, 350)
InfoPage.Visible = false

-- Load Modules from GitHub
spawn(function()
	wait(0.5)
	LoadingDesc.Text = "Loading Home module..."
	local HomeModule = LoadModule("Home")
	if HomeModule then HomeModule.Initialize(HomePage) end
	
	wait(0.3)
	LoadingDesc.Text = "Loading Mount module..."
	local MountModule = LoadModule("Mount")
	if MountModule then MountModule.Initialize(MountPage) end
	
	wait(0.3)
	LoadingDesc.Text = "Loading Movement module..."
	local MovementModule = LoadModule("Movement")
	if MovementModule then MovementModule.Initialize(MovementPage, player, character) end
	
	wait(0.3)
	LoadingDesc.Text = "Loading Utilities module..."
	local UtilitiesModule = LoadModule("Utilities")
	if UtilitiesModule then UtilitiesModule.Initialize(UtilitiesPage, player, character) end
	
	wait(0.3)
	LoadingDesc.Text = "Loading Clone module..."
	local CloneModule = LoadModule("Clone")
	if CloneModule then CloneModule.Initialize(ClonePage, player, character) end
	
	wait(0.3)
	LoadingDesc.Text = "Loading Parts module..."
	local PartsModule = LoadModule("Parts")
	if PartsModule then PartsModule.Initialize(PartsPage, player, character) end
	
	wait(0.3)
	LoadingDesc.Text = "Loading Server module..."
	local ServerModule = LoadModule("Server")
	if ServerModule then ServerModule.Initialize(ServerPage, player) end
	
	wait(0.3)
	LoadingDesc.Text = "Loading Donate module..."
	local DonateModule = LoadModule("Donate")
	if DonateModule then DonateModule.Initialize(DonatePage) end
	
	wait(0.3)
	LoadingDesc.Text = "Loading Info module..."
	local InfoModule = LoadModule("Info")
	if InfoModule then InfoModule.Initialize(InfoPage) end
	
	LoadingFrame.Visible = false
	HomePage.Visible = true
end)

-- Tab System
local function ShowTab(tab)
	HomePage.Visible = false
	MountPage.Visible = false
	MovementPage.Visible = false
	UtilitiesPage.Visible = false
	ClonePage.Visible = false
	PartsPage.Visible = false
	ServerPage.Visible = false
	DonatePage.Visible = false
	InfoPage.Visible = false
	LoadingFrame.Visible = false
	
	if tab == "Home" then
		HomePage.Visible = true
	elseif tab == "Mount" then
		MountPage.Visible = true
	elseif tab == "Movement" then
		MovementPage.Visible = true
	elseif tab == "Utilities" then
		UtilitiesPage.Visible = true
	elseif tab == "Clone" then
		ClonePage.Visible = true
	elseif tab == "Parts" then
		PartsPage.Visible = true
	elseif tab == "Server" then
		ServerPage.Visible = true
	elseif tab == "Donate" then
		DonatePage.Visible = true
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

-- Draggable MainFrame
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

print("✅ LEX Host v3 loaded successfully!")
