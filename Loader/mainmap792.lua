local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local UIConfig = {
	Logo = isMobile and {
		Size = UDim2.new(0, 50, 0, 50),
		Position = UDim2.new(0.5, -25, 0.02, 0)
	} or {
		Size = UDim2.new(0, 80, 0, 80),
		Position = UDim2.new(0.5, -40, 0.05, 0)
	},
	MainFrame = isMobile and {
		Size = UDim2.new(0, 340, 0, 480),
		SidebarWidth = 100
	} or {
		Size = UDim2.new(0, 680, 0, 450),
		SidebarWidth = 160
	},
	TopBar = isMobile and 40 or 50,
	ButtonSize = isMobile and 30 or 40,
	TextSize = {
		Title = isMobile and 14 or 18,
		Button = isMobile and 11 or 14,
		Normal = isMobile and 12 or 14
	}
}

local LEXHost = Instance.new("ScreenGui", game.CoreGui)
LEXHost.Name = "LEXHost"
LEXHost.ResetOnSpawn = false

-- Logo Button dengan animasi
local LogoButton = Instance.new("ImageButton", LEXHost)
LogoButton.Image = "rbxassetid://93847535906931"
LogoButton.Position = UIConfig.Logo.Position
LogoButton.Size = UIConfig.Logo.Size
LogoButton.BackgroundColor3 = Color3.fromRGB(10, 20, 40)
LogoButton.BackgroundTransparency = 0.3
LogoButton.BorderSizePixel = 0
LogoButton.AutoButtonColor = false
LogoButton.ZIndex = 10
LogoButton.Active = true
LogoButton.Draggable = true
LogoButton.ScaleType = Enum.ScaleType.Fit

local LogoCorner = Instance.new("UICorner", LogoButton)
LogoCorner.CornerRadius = UDim.new(0, isMobile and 8 or 12)

local LogoStroke = Instance.new("UIStroke", LogoButton)
LogoStroke.Color = Color3.fromRGB(0, 200, 255)
LogoStroke.Thickness = isMobile and 2 or 2.5

-- Gradient untuk logo
local LogoGradient = Instance.new("UIGradient", LogoButton)
LogoGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 200))
}
LogoGradient.Rotation = 45

-- Animasi rotasi gradient
spawn(function()
	while wait(0.05) do
		LogoGradient.Rotation = (LogoGradient.Rotation + 2) % 360
	end
end)

-- Glow effect untuk logo
LogoButton.MouseEnter:Connect(function()
	TweenService:Create(LogoButton, TweenInfo.new(0.3), {ImageColor3 = Color3.fromRGB(150, 255, 255)}):Play()
	TweenService:Create(LogoStroke, TweenInfo.new(0.3), {Thickness = isMobile and 3 or 4}):Play()
end)
LogoButton.MouseLeave:Connect(function()
	TweenService:Create(LogoButton, TweenInfo.new(0.3), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(LogoStroke, TweenInfo.new(0.3), {Thickness = isMobile and 2 or 2.5}):Play()
end)

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Parent = LEXHost
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UIConfig.MainFrame.Size
MainFrame.BackgroundColor3 = Color3.fromRGB(5, 10, 25)
MainFrame.BackgroundTransparency = 0.15
MainFrame.Visible = true
MainFrame.ClipsDescendants = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, isMobile and 10 or 15)

local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.fromRGB(0, 180, 255)
Stroke.Thickness = isMobile and 2 or 3

-- Gradient animasi untuk border
local StrokeGradient = Instance.new("UIGradient", Stroke)
StrokeGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 255))
}
spawn(function()
	while wait(0.03) do
		StrokeGradient.Rotation = (StrokeGradient.Rotation + 3) % 360
	end
end)

-- Shadow effect
local Shadow = Instance.new("ImageLabel", MainFrame)
Shadow.Name = "Shadow"
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.Size = UDim2.new(1, isMobile and 20 or 30, 1, isMobile and 20 or 30)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://6014261993"
Shadow.ImageColor3 = Color3.fromRGB(0, 150, 255)
Shadow.ImageTransparency = 0.7
Shadow.ZIndex = -1

-- Topbar
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, UIConfig.TopBar)
TopBar.BackgroundColor3 = Color3.fromRGB(10, 15, 35)
TopBar.BackgroundTransparency = 0.2
local TopCorner = Instance.new("UICorner", TopBar)
TopCorner.CornerRadius = UDim.new(0, isMobile and 10 or 15)

-- Gradient untuk topbar
local TopGradient = Instance.new("UIGradient", TopBar)
TopGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 15, 35)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 25, 50))
}

-- Logo Image di TopBar
local LX = Instance.new("ImageLabel", TopBar)
LX.Image = "rbxassetid://93847535906931"
LX.Position = UDim2.new(0, isMobile and 5 or 10, 0, isMobile and 5 or 5)
LX.Size = UDim2.new(0, isMobile and 30 or 40, 0, isMobile and 30 or 40)
LX.BackgroundTransparency = 1
LX.ScaleType = Enum.ScaleType.Fit

local Title = Instance.new("TextLabel", TopBar)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, isMobile and 40 or 60, 0, 0)
Title.Size = UDim2.new(0.5, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = isMobile and "LEX Host v3" or "LEX Host v3 - Vip Edition"
Title.TextColor3 = Color3.fromRGB(0, 190, 255)
Title.TextSize = UIConfig.TextSize.Title
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Minimize & Close dengan animasi
local btnSize = isMobile and 28 or 35
local MinBtn = Instance.new("TextButton", TopBar)
MinBtn.Text = "−"
MinBtn.Size = UDim2.new(0, btnSize, 0, btnSize)
MinBtn.Position = UDim2.new(1, isMobile and -65 or -85, 0.5, -btnSize/2)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = isMobile and 16 or 20
MinBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
MinBtn.TextColor3 = Color3.fromRGB(0, 200, 255)
MinBtn.BorderSizePixel = 0
local MinCorner = Instance.new("UICorner", MinBtn)
MinCorner.CornerRadius = UDim.new(0, isMobile and 6 or 8)
MinBtn.MouseEnter:Connect(function() 
	TweenService:Create(MinBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 45, 70)}):Play()
end)
MinBtn.MouseLeave:Connect(function() 
	TweenService:Create(MinBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 30, 50)}):Play()
end)

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Text = "✕"
CloseBtn.Size = UDim2.new(0, btnSize, 0, btnSize)
CloseBtn.Position = UDim2.new(1, isMobile and -32 or -40, 0.5, -btnSize/2)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = isMobile and 14 or 18
CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 20, 20)
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.BorderSizePixel = 0
local CloseCorner = Instance.new("UICorner", CloseBtn)
CloseCorner.CornerRadius = UDim.new(0, isMobile and 6 or 8)
CloseBtn.MouseEnter:Connect(function() 
	TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 30, 30)}):Play()
end)
CloseBtn.MouseLeave:Connect(function() 
	TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 20, 20)}):Play()
end)

-- Sidebar dengan ScrollingFrame
local Side = Instance.new("ScrollingFrame", MainFrame)
Side.Position = UDim2.new(0, 0, 0, UIConfig.TopBar)
Side.Size = UDim2.new(0, UIConfig.MainFrame.SidebarWidth, 1, -UIConfig.TopBar)
Side.BackgroundColor3 = Color3.fromRGB(8, 15, 35)
Side.BackgroundTransparency = 0.3
Side.BorderSizePixel = 0
Side.ScrollBarThickness = isMobile and 4 or 6
Side.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
Side.CanvasSize = UDim2.new(0, 0, 0, 0) -- Will be calculated

-- Gradient untuk sidebar
local SideGradient = Instance.new("UIGradient", Side)
SideGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 15, 35)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 20, 45))
}
SideGradient.Rotation = 90

local Tabs = {"Home","Mount","Movement","Utilities","Clone","Parts","Parts2","Server","Donate","Info"}
local Buttons = {}
local buttonHeight = isMobile and 35 or 42
local buttonSpacing = isMobile and 5 or 8
local totalHeight = 0

for i, v in ipairs(Tabs) do
	local B = Instance.new("TextButton", Side)
	B.Text = "✦ " .. v
	B.Size = UDim2.new(1, isMobile and -10 or -15, 0, buttonHeight)
	B.Position = UDim2.new(0, isMobile and 5 or 7.5, 0, totalHeight + (isMobile and 5 or 10))
	B.BackgroundColor3 = Color3.fromRGB(15, 25, 50)
	B.TextColor3 = Color3.fromRGB(0, 200, 255)
	B.Font = Enum.Font.GothamBold
	B.TextSize = UIConfig.TextSize.Button
	B.AutoButtonColor = false
	B.BorderSizePixel = 0
	
	-- Stroke dengan gradient
	local s = Instance.new("UIStroke", B)
	s.Color = Color3.fromRGB(0, 190, 255)
	s.Thickness = isMobile and 1.5 or 2
	s.Transparency = 0.5
	
	local sGradient = Instance.new("UIGradient", s)
	sGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 200))
	}
	
	local c = Instance.new("UICorner", B)
	c.CornerRadius = UDim.new(0, isMobile and 8 or 10)
	
	-- Gradient background
	local bGradient = Instance.new("UIGradient", B)
	bGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 25, 50)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 35, 60))
	}
	bGradient.Rotation = 45
	
	B.MouseEnter:Connect(function() 
		TweenService:Create(B, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(25,40,80)}):Play()
		TweenService:Create(s, TweenInfo.new(0.3), {Thickness = isMobile and 2.5 or 3, Transparency = 0}):Play()
		B.TextSize = UIConfig.TextSize.Button + 1
	end)
	B.MouseLeave:Connect(function() 
		TweenService:Create(B, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(15,25,50)}):Play()
		TweenService:Create(s, TweenInfo.new(0.3), {Thickness = isMobile and 1.5 or 2, Transparency = 0.5}):Play()
		B.TextSize = UIConfig.TextSize.Button
	end)
	
	Buttons[v] = B
	totalHeight = totalHeight + buttonHeight + buttonSpacing
end

-- Set CanvasSize untuk sidebar
Side.CanvasSize = UDim2.new(0, 0, 0, totalHeight + (isMobile and 15 or 20))

-- Content Area
local contentMargin = isMobile and 5 or 10
local Content = Instance.new("Frame", MainFrame)
Content.Position = UDim2.new(0, UIConfig.MainFrame.SidebarWidth + contentMargin, 0, UIConfig.TopBar + contentMargin)
Content.Size = UDim2.new(1, -(UIConfig.MainFrame.SidebarWidth + contentMargin*2), 1, -(UIConfig.TopBar + contentMargin*2))
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
	Parts2 = "https://raw.githubusercontent.com/putraborz/lexhostlkp/refs/heads/main/Loader/Part2.lua",
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

-- Loading Screen dengan animasi
local LoadingFrame = Instance.new("Frame", Content)
LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingFrame.BackgroundTransparency = 1
LoadingFrame.Visible = true

local LoadingSpinner = Instance.new("ImageLabel", LoadingFrame)
LoadingSpinner.Size = UDim2.new(0, isMobile and 40 or 60, 0, isMobile and 40 or 60)
LoadingSpinner.Position = UDim2.new(0.5, isMobile and -20 or -30, 0.35, isMobile and -20 or -30)
LoadingSpinner.BackgroundTransparency = 1
LoadingSpinner.Image = "rbxassetid://106296997072730"
LoadingSpinner.ImageColor3 = Color3.fromRGB(0, 220, 255)

-- Animasi spinner
spawn(function()
	while LoadingFrame.Visible do
		LoadingSpinner.Rotation = (LoadingSpinner.Rotation + 5) % 360
		wait(0.03)
	end
end)

local LoadingText = Instance.new("TextLabel", LoadingFrame)
LoadingText.Size = UDim2.new(1, 0, 0.3, 0)
LoadingText.Position = UDim2.new(0, 0, 0.5, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = isMobile and "⚡ Loading..." or "⚡ Loading LEX Host v3..."
LoadingText.TextColor3 = Color3.fromRGB(0, 220, 255)
LoadingText.Font = Enum.Font.GothamBold
LoadingText.TextSize = isMobile and 16 or 20
LoadingText.TextWrapped = true

local LoadingDesc = Instance.new("TextLabel", LoadingFrame)
LoadingDesc.Size = UDim2.new(1, 0, 0.2, 0)
LoadingDesc.Position = UDim2.new(0, 0, 0.6, 0)
LoadingDesc.BackgroundTransparency = 1
LoadingDesc.Text = "Connecting..."
LoadingDesc.TextColor3 = Color3.fromRGB(150, 200, 255)
LoadingDesc.Font = Enum.Font.Gotham
LoadingDesc.TextSize = UIConfig.TextSize.Normal
LoadingDesc.TextWrapped = true

-- Create Pages
local scrollBarSize = isMobile and 6 or 8
local HomePage = Instance.new("ScrollingFrame", Content)
HomePage.Name = "Home"
HomePage.Size = UDim2.new(1, 0, 1, 0)
HomePage.BackgroundTransparency = 1
HomePage.BorderSizePixel = 0
HomePage.ScrollBarThickness = scrollBarSize
HomePage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
HomePage.CanvasSize = UDim2.new(0, 0, 0, 300)
HomePage.Visible = false

local MountPage = Instance.new("ScrollingFrame", Content)
MountPage.Name = "Mount"
MountPage.Size = UDim2.new(1, 0, 1, 0)
MountPage.CanvasSize = UDim2.new(0, 0, 2, 0)
MountPage.ScrollBarThickness = scrollBarSize
MountPage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
MountPage.BackgroundTransparency = 1
MountPage.BorderSizePixel = 0
MountPage.Visible = false

local MovementPage = Instance.new("ScrollingFrame", Content)
MovementPage.Name = "Movement"
MovementPage.Size = UDim2.new(1, 0, 1, 0)
MovementPage.BackgroundTransparency = 1
MovementPage.BorderSizePixel = 0
MovementPage.ScrollBarThickness = scrollBarSize
MovementPage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
MovementPage.CanvasSize = UDim2.new(0, 0, 0, 500)
MovementPage.Visible = false

local UtilitiesPage = Instance.new("ScrollingFrame", Content)
UtilitiesPage.Name = "Utilities"
UtilitiesPage.Size = UDim2.new(1, 0, 1, 0)
UtilitiesPage.BackgroundTransparency = 1
UtilitiesPage.BorderSizePixel = 0
UtilitiesPage.ScrollBarThickness = scrollBarSize
UtilitiesPage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
UtilitiesPage.CanvasSize = UDim2.new(0, 0, 0, 600)
UtilitiesPage.Visible = false

local ClonePage = Instance.new("ScrollingFrame", Content)
ClonePage.Name = "Clone"
ClonePage.Size = UDim2.new(1, 0, 1, 0)
ClonePage.BackgroundTransparency = 1
ClonePage.BorderSizePixel = 0
ClonePage.ScrollBarThickness = scrollBarSize
ClonePage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
ClonePage.CanvasSize = UDim2.new(0, 0, 0, 400)
ClonePage.Visible = false

local PartsPage = Instance.new("ScrollingFrame", Content)
PartsPage.Name = "Parts"
PartsPage.Size = UDim2.new(1, 0, 1, 0)
PartsPage.BackgroundTransparency = 1
PartsPage.BorderSizePixel = 0
PartsPage.ScrollBarThickness = scrollBarSize
PartsPage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
PartsPage.CanvasSize = UDim2.new(0, 0, 0, 500)
PartsPage.Visible = false

local PartsPage = Instance.new("ScrollingFrame", Content)
PartsPage.Name = "Parts2"
PartsPage.Size = UDim2.new(1, 0, 1, 0)
PartsPage.BackgroundTransparency = 1
PartsPage.BorderSizePixel = 0
PartsPage.ScrollBarThickness = scrollBarSize
PartsPage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
PartsPage.CanvasSize = UDim2.new(0, 0, 0, 500)
PartsPage.Visible = false

local ServerPage = Instance.new("ScrollingFrame", Content)
ServerPage.Name = "Server"
ServerPage.Size = UDim2.new(1, 0, 1, 0)
ServerPage.BackgroundTransparency = 1
ServerPage.BorderSizePixel = 0
ServerPage.ScrollBarThickness = scrollBarSize
ServerPage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
ServerPage.CanvasSize = UDim2.new(0, 0, 0, 500)
ServerPage.Visible = false

local DonatePage = Instance.new("ScrollingFrame", Content)
DonatePage.Name = "Donate"
DonatePage.Size = UDim2.new(1, 0, 1, 0)
DonatePage.BackgroundTransparency = 1
DonatePage.BorderSizePixel = 0
DonatePage.ScrollBarThickness = scrollBarSize
DonatePage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
DonatePage.CanvasSize = UDim2.new(0, 0, 0, 300)
DonatePage.Visible = false

local InfoPage = Instance.new("ScrollingFrame", Content)
InfoPage.Name = "Info"
InfoPage.Size = UDim2.new(1, 0, 1, 0)
InfoPage.BackgroundTransparency = 1
InfoPage.BorderSizePixel = 0
InfoPage.ScrollBarThickness = scrollBarSize
InfoPage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
InfoPage.CanvasSize = UDim2.new(0, 0, 0, 350)
InfoPage.Visible = false

-- Load Modules from GitHub
spawn(function()
	wait(0.5)
	LoadingDesc.Text = isMobile and "Loading..." or "Loading Home module..."
	local HomeModule = LoadModule("Home")
	if HomeModule then HomeModule.Initialize(HomePage) end
	
	wait(0.3)
	LoadingDesc.Text = isMobile and "Loading..." or "Loading Mount module..."
	local MountModule = LoadModule("Mount")
	if MountModule then MountModule.Initialize(MountPage) end
	
	wait(0.3)
	LoadingDesc.Text = isMobile and "Loading..." or "Loading Movement module..."
	local MovementModule = LoadModule("Movement")
	if MovementModule then MovementModule.Initialize(MovementPage, player, character) end
	
	wait(0.3)
	LoadingDesc.Text = isMobile and "Loading..." or "Loading Utilities module..."
	local UtilitiesModule = LoadModule("Utilities")
	if UtilitiesModule then UtilitiesModule.Initialize(UtilitiesPage, player, character) end
	
	wait(0.3)
	LoadingDesc.Text = isMobile and "Loading..." or "Loading Clone module..."
	local CloneModule = LoadModule("Clone")
	if CloneModule then CloneModule.Initialize(ClonePage, player, character) end
	
	wait(0.3)
	LoadingDesc.Text = isMobile and "Loading..." or "Loading Parts module..."
	local PartsModule = LoadModule("Parts")
	if PartsModule then PartsModule.Initialize(PartsPage, player, character) end

	wait(0.3)
	LoadingDesc.Text = isMobile and "Loading..." or "Loading Parts module..."
	local PartsModule = LoadModule("Parts2")
	if PartsModule then PartsModule.Initialize(PartsPage, player, character) end
	
	wait(0.3)
	LoadingDesc.Text = isMobile and "Loading..." or "Loading Server module..."
	local ServerModule = LoadModule("Server")
	if ServerModule then ServerModule.Initialize(ServerPage, player) end
	
	wait(0.3)
	LoadingDesc.Text = isMobile and "Loading..." or "Loading Donate module..."
	local DonateModule = LoadModule("Donate")
	if DonateModule then DonateModule.Initialize(DonatePage) end
	
	wait(0.3)
	LoadingDesc.Text = isMobile and "Loading..." or "Loading Info module..."
	local InfoModule = LoadModule("Info")
	if InfoModule then InfoModule.Initialize(InfoPage) end
	
	LoadingFrame.Visible = false
	HomePage.Visible = true
end)

-- Tab System dengan animasi
local currentTab = nil
local function ShowTab(tab)
	-- Fade out current
	if currentTab then
		TweenService:Create(currentTab, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
		wait(0.1)
		currentTab.Visible = false
	end
	
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
	
	local newTab
	if tab == "Home" then
		newTab = HomePage
	elseif tab == "Mount" then
		newTab = MountPage
	elseif tab == "Movement" then
		newTab = MovementPage
	elseif tab == "Utilities" then
		newTab = UtilitiesPage
	elseif tab == "Clone" then
		newTab = ClonePage
	elseif tab == "Parts" then
		newTab = PartsPage
		elseif tab == "Parts2" then
		newTab = Parts2Page
	elseif tab == "Server" then
		newTab = ServerPage
	elseif tab == "Donate" then
		newTab = DonatePage
	elseif tab == "Info" then
		newTab = InfoPage
	end
	
	if newTab then
		newTab.Visible = true
		currentTab = newTab
	end
end

for n, b in pairs(Buttons) do
	b.MouseButton1Click:Connect(function() 
		ShowTab(n)
	end)
end

-- Logo Button Toggle
LogoButton.MouseButton1Click:Connect(function()
	if MainFrame.Visible then
		TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
		wait(0.3)
		MainFrame.Visible = false
		MainFrame.Size = UIConfig.MainFrame.Size
	else
		MainFrame.Size = UDim2.new(0, 0, 0, 0)
		MainFrame.Visible = true
		TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UIConfig.MainFrame.Size}):Play()
	end
end)

-- Minimize
MinBtn.MouseButton1Click:Connect(function()
	TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
	wait(0.3)
	MainFrame.Visible = false
	MainFrame.Size = UIConfig.MainFrame.Size
end)

-- Close
CloseBtn.MouseButton1Click:Connect(function()
	TweenService:Create(MainFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
	TweenService:Create(LogoButton, TweenInfo.new(0.3), {BackgroundTransparency = 1, ImageTransparency = 1}):Play()
	wait(0.3)
	LEXHost:Destroy()
end)

-- Draggable MainFrame
local UIS = game:GetService("UserInputService")
local dragging, dragInput, startPos, startDrag
TopBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		startDrag = input.Position
		startPos = MainFrame.Position
	end
end)
TopBar.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)
UIS.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - startDrag
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

print("✅ LEX Host v3 loaded successfully! (Mobile Optimized: " .. tostring(isMobile) .. ")")
