--// LEX Host v3 - Enhanced Cyber Neon Edition
--// Made by LEX Dev
--// Features: Mount, Clone Avatar, Speed Input, Fly, Draggable Logo

local LEXHost = Instance.new("ScreenGui", game.CoreGui)
LEXHost.Name = "LEXHost"
LEXHost.ResetOnSpawn = false

-- Logo LX (Draggable Toggle Button)
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

-- Draggable Logo
local UIS = game:GetService("UserInputService")
local draggingLogo, logoStartPos, logoStartDrag
LogoButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingLogo = true
		logoStartDrag = input.Position
		logoStartPos = LogoButton.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				draggingLogo = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if draggingLogo and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - logoStartDrag
		LogoButton.Position = UDim2.new(
			logoStartPos.X.Scale, 
			logoStartPos.X.Offset + delta.X, 
			logoStartPos.Y.Scale, 
			logoStartPos.Y.Offset + delta.Y
		)
	end
end)

local MainFrame = Instance.new("Frame")
MainFrame.Parent = LEXHost
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 700, 0, 480)
MainFrame.BackgroundColor3 = Color3.fromRGB(5, 10, 25)
MainFrame.BackgroundTransparency = 0.25
MainFrame.Visible = true
local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 15)
local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.fromRGB(0, 180, 255)
Stroke.Thickness = 2.5

-- Gradient Background
local Gradient = Instance.new("UIGradient", MainFrame)
Gradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(5, 10, 25)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 20, 40))
}
Gradient.Rotation = 45

-- Topbar
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(10, 15, 35)
TopBar.BackgroundTransparency = 0.3
local TopCorner = Instance.new("UICorner", TopBar)
TopCorner.CornerRadius = UDim.new(0, 15)

local LX = Instance.new("TextLabel", TopBar)
LX.Text = "⚡ LX"
LX.Font = Enum.Font.GothamBlack
LX.TextSize = 26
LX.TextColor3 = Color3.fromRGB(0, 220, 255)
LX.Position = UDim2.new(0, 15, 0, 0)
LX.Size = UDim2.new(0, 60, 1, 0)
LX.BackgroundTransparency = 1
LX.TextXAlignment = Enum.TextXAlignment.Left

local Title = Instance.new("TextLabel", TopBar)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 80, 0, 0)
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "LEX Host v3 - Enhanced Edition"
Title.TextColor3 = Color3.fromRGB(0, 190, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

local MinBtn = Instance.new("TextButton", TopBar)
MinBtn.Text = "_"
MinBtn.Size = UDim2.new(0, 35, 0, 35)
MinBtn.Position = UDim2.new(1, -80, 0.5, -17.5)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 20
MinBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
MinBtn.TextColor3 = Color3.fromRGB(0, 200, 255)
MinBtn.BorderSizePixel = 0
local MinCorner = Instance.new("UICorner", MinBtn)
MinCorner.CornerRadius = UDim.new(0, 8)

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Text = "✕"
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -40, 0.5, -17.5)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.BorderSizePixel = 0
local CloseCorner = Instance.new("UICorner", CloseBtn)
CloseCorner.CornerRadius = UDim.new(0, 8)

-- Sidebar
local Side = Instance.new("Frame", MainFrame)
Side.Position = UDim2.new(0, 0, 0, 45)
Side.Size = UDim2.new(0, 160, 1, -45)
Side.BackgroundColor3 = Color3.fromRGB(8, 15, 35)
Side.BackgroundTransparency = 0.3
Side.BorderSizePixel = 0
local SideCorner = Instance.new("UICorner", Side)
SideCorner.CornerRadius = UDim.new(0, 15)

local Tabs = {"🏠 Home", "🐎 Mount", "🚀 Movement", "🔧 Utilities", "ℹ️ Info"}
local TabNames = {"Home", "Mount", "Movement", "Utilities", "Info"}
local Buttons = {}

for i, v in ipairs(Tabs) do
	local B = Instance.new("TextButton", Side)
	B.Name = TabNames[i]
	B.Text = v
	B.Size = UDim2.new(1, -16, 0, 45)
	B.Position = UDim2.new(0, 8, 0, (i - 1) * 50 + 10)
	B.BackgroundColor3 = Color3.fromRGB(15, 25, 50)
	B.TextColor3 = Color3.fromRGB(0, 200, 255)
	B.Font = Enum.Font.GothamBold
	B.TextSize = 15
	B.AutoButtonColor = false
	B.BorderSizePixel = 0
	local s = Instance.new("UIStroke", B)
	s.Color = Color3.fromRGB(0, 190, 255)
	s.Thickness = 1.5
	s.Transparency = 0.5
	local bc = Instance.new("UICorner", B)
	bc.CornerRadius = UDim.new(0, 10)
	
	B.MouseEnter:Connect(function()
		B.BackgroundColor3 = Color3.fromRGB(20, 40, 80)
		s.Transparency = 0
	end)
	B.MouseLeave:Connect(function()
		B.BackgroundColor3 = Color3.fromRGB(15, 25, 50)
		s.Transparency = 0.5
	end)
	Buttons[TabNames[i]] = B
end

-- Content Area
local Content = Instance.new("Frame", MainFrame)
Content.Position = UDim2.new(0, 170, 0, 55)
Content.Size = UDim2.new(1, -180, 1, -65)
Content.BackgroundTransparency = 1

-- Variables
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Create Pages
local function CreatePage(name)
	local Page = Instance.new("ScrollingFrame", Content)
	Page.Name = name
	Page.Size = UDim2.new(1, 0, 1, 0)
	Page.BackgroundTransparency = 1
	Page.BorderSizePixel = 0
	Page.ScrollBarThickness = 8
	Page.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
	Page.CanvasSize = UDim2.new(0, 0, 0, 0)
	Page.Visible = false
	Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	return Page
end

local HomePage = CreatePage("Home")
local MountPage = CreatePage("Mount")
local MovementPage = CreatePage("Movement")
local UtilitiesPage = CreatePage("Utilities")
local InfoPage = CreatePage("Info")

-- Helper Functions
local function CreateButton(parent, text, position, callback)
	local btn = Instance.new("TextButton", parent)
	btn.Text = text
	btn.Size = UDim2.new(0, 200, 0, 40)
	btn.Position = position
	btn.BackgroundColor3 = Color3.fromRGB(15, 30, 60)
	btn.TextColor3 = Color3.fromRGB(0, 220, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.BorderSizePixel = 0
	local corner = Instance.new("UICorner", btn)
	corner.CornerRadius = UDim.new(0, 10)
	local stroke = Instance.new("UIStroke", btn)
	stroke.Color = Color3.fromRGB(0, 200, 255)
	stroke.Thickness = 2
	
	btn.MouseEnter:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(25, 50, 90)
	end)
	btn.MouseLeave:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(15, 30, 60)
	end)
	
	if callback then
		btn.MouseButton1Click:Connect(callback)
	end
	
	return btn
end

local function CreateToggle(parent, text, position, callback)
	local frame = Instance.new("Frame", parent)
	frame.Size = UDim2.new(0, 250, 0, 50)
	frame.Position = position
	frame.BackgroundColor3 = Color3.fromRGB(15, 25, 50)
	frame.BorderSizePixel = 0
	local corner = Instance.new("UICorner", frame)
	corner.CornerRadius = UDim.new(0, 10)
	
	local label = Instance.new("TextLabel", frame)
	label.Text = text
	label.Size = UDim2.new(0.7, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.fromRGB(200, 220, 255)
	label.Font = Enum.Font.GothamBold
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Position = UDim2.new(0, 10, 0, 0)
	
	local toggle = Instance.new("TextButton", frame)
	toggle.Size = UDim2.new(0, 60, 0, 30)
	toggle.Position = UDim2.new(1, -70, 0.5, -15)
	toggle.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
	toggle.Text = "OFF"
	toggle.TextColor3 = Color3.fromRGB(255, 100, 100)
	toggle.Font = Enum.Font.GothamBold
	toggle.TextSize = 12
	toggle.BorderSizePixel = 0
	local toggleCorner = Instance.new("UICorner", toggle)
	toggleCorner.CornerRadius = UDim.new(0, 8)
	
	local enabled = false
	toggle.MouseButton1Click:Connect(function()
		enabled = not enabled
		if enabled then
			toggle.BackgroundColor3 = Color3.fromRGB(20, 60, 20)
			toggle.Text = "ON"
			toggle.TextColor3 = Color3.fromRGB(100, 255, 100)
		else
			toggle.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
			toggle.Text = "OFF"
			toggle.TextColor3 = Color3.fromRGB(255, 100, 100)
		end
		if callback then callback(enabled) end
	end)
	
	return toggle, frame
end

local function CreateTextBox(parent, placeholder, position)
	local box = Instance.new("TextBox", parent)
	box.Size = UDim2.new(0, 200, 0, 40)
	box.Position = position
	box.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
	box.TextColor3 = Color3.fromRGB(0, 220, 255)
	box.PlaceholderText = placeholder
	box.PlaceholderColor3 = Color3.fromRGB(100, 150, 200)
	box.Font = Enum.Font.Gotham
	box.TextSize = 14
	box.Text = ""
	box.BorderSizePixel = 0
	local corner = Instance.new("UICorner", box)
	corner.CornerRadius = UDim.new(0, 10)
	local stroke = Instance.new("UIStroke", box)
	stroke.Color = Color3.fromRGB(0, 150, 200)
	stroke.Thickness = 1.5
	return box
end

-- HOME PAGE
local HomeTitle = Instance.new("TextLabel", HomePage)
HomeTitle.Text = "✨ Welcome to LEX Host v3 ✨"
HomeTitle.Size = UDim2.new(1, 0, 0, 50)
HomeTitle.Position = UDim2.new(0, 0, 0, 10)
HomeTitle.BackgroundTransparency = 1
HomeTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
HomeTitle.Font = Enum.Font.GothamBlack
HomeTitle.TextSize = 24

local HomeDesc = Instance.new("TextLabel", HomePage)
HomeDesc.Text = "Enhanced Cyber Edition with Advanced Features\n\n🐎 Mount System\n🚀 Custom Speed & Fly\n👤 Clone Avatar\n🔧 Advanced Utilities"
HomeDesc.Size = UDim2.new(1, -20, 0, 150)
HomeDesc.Position = UDim2.new(0, 10, 0, 70)
HomeDesc.BackgroundTransparency = 1
HomeDesc.TextColor3 = Color3.fromRGB(150, 200, 255)
HomeDesc.Font = Enum.Font.Gotham
HomeDesc.TextSize = 14
HomeDesc.TextWrapped = true
HomeDesc.TextYAlignment = Enum.TextYAlignment.Top

-- MOUNT PAGE
local MountTitle = Instance.new("TextLabel", MountPage)
MountTitle.Text = "🐎 Mount System"
MountTitle.Size = UDim2.new(1, 0, 0, 40)
MountTitle.BackgroundTransparency = 1
MountTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
MountTitle.Font = Enum.Font.GothamBold
MountTitle.TextSize = 20

local MountInfo = Instance.new("TextLabel", MountPage)
MountInfo.Text = "Ride other players as mounts!"
MountInfo.Size = UDim2.new(1, 0, 0, 30)
MountInfo.Position = UDim2.new(0, 0, 0, 45)
MountInfo.BackgroundTransparency = 1
MountInfo.TextColor3 = Color3.fromRGB(150, 200, 255)
MountInfo.Font = Enum.Font.Gotham
MountInfo.TextSize = 12

local MountPlayerBox = CreateTextBox(MountPage, "Enter Player Name", UDim2.new(0, 10, 0, 85))
local MountPlayerBtn = CreateButton(MountPage, "🐎 Mount Player", UDim2.new(0, 220, 0, 85), function()
	local targetName = MountPlayerBox.Text
	for _, v in pairs(game.Players:GetPlayers()) do
		if v.Name:lower():find(targetName:lower()) and v.Character then
			local targetRoot = v.Character:FindFirstChild("HumanoidRootPart")
			if targetRoot then
				rootPart.CFrame = targetRoot.CFrame + Vector3.new(0, 2, 0)
				wait(0.1)
				-- Weld to player
				local weld = Instance.new("Weld")
				weld.Part0 = rootPart
				weld.Part1 = targetRoot
				weld.C0 = CFrame.new(0, 2, 0)
				weld.Parent = rootPart
			end
			break
		end
	end
end)

local UnmountBtn = CreateButton(MountPage, "Unmount", UDim2.new(0, 10, 0, 140), function()
	for _, v in pairs(rootPart:GetChildren()) do
		if v:IsA("Weld") then
			v:Destroy()
		end
	end
end)

-- MOVEMENT PAGE  
local MovTitle = Instance.new("TextLabel", MovementPage)
MovTitle.Text = "🚀 Movement Controls"
MovTitle.Size = UDim2.new(1, 0, 0, 40)
MovTitle.BackgroundTransparency = 1
MovTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
MovTitle.Font = Enum.Font.GothamBold
MovTitle.TextSize = 20

-- Speed Control
local SpeedLabel = Instance.new("TextLabel", MovementPage)
SpeedLabel.Text = "⚡ Custom Speed"
SpeedLabel.Size = UDim2.new(0, 150, 0, 40)
SpeedLabel.Position = UDim2.new(0, 10, 0, 50)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.TextSize = 14
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local SpeedBox = CreateTextBox(MovementPage, "Speed (16-500)", UDim2.new(0, 10, 0, 90))
local SetSpeedBtn = CreateButton(MovementPage, "Set Speed", UDim2.new(0, 220, 0, 90), function()
	local speed = tonumber(SpeedBox.Text)
	if speed then
		humanoid.WalkSpeed = speed
	end
end)

local ResetSpeedBtn = CreateButton(MovementPage, "Reset Speed", UDim2.new(0, 10, 0, 145), function()
	humanoid.WalkSpeed = 16
	SpeedBox.Text = ""
end)

-- Fly Control
local flyEnabled = false
local flySpeed = 50
local flyConnection

local FlyToggle, FlyFrame = CreateToggle(MovementPage, "✈️ Fly Mode", UDim2.new(0, 10, 0, 200), function(enabled)
	flyEnabled = enabled
	if enabled then
		local bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.Velocity = Vector3.new(0, 0, 0)
		bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
		bodyVelocity.Parent = rootPart
		
		local bodyGyro = Instance.new("BodyGyro")
		bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
		bodyGyro.Parent = rootPart
		
		flyConnection = game:GetService("RunService").RenderStepped:Connect(function()
			local cam = workspace.CurrentCamera
			local moveDirection = Vector3.new(0, 0, 0)
			
			if UIS:IsKeyDown(Enum.KeyCode.W) then
				moveDirection = moveDirection + (cam.CFrame.LookVector)
			end
			if UIS:IsKeyDown(Enum.KeyCode.S) then
				moveDirection = moveDirection - (cam.CFrame.LookVector)
			end
			if UIS:IsKeyDown(Enum.KeyCode.A) then
				moveDirection = moveDirection - (cam.CFrame.RightVector)
			end
			if UIS:IsKeyDown(Enum.KeyCode.D) then
				moveDirection = moveDirection + (cam.CFrame.RightVector)
			end
			if UIS:IsKeyDown(Enum.KeyCode.Space) then
				moveDirection = moveDirection + Vector3.new(0, 1, 0)
			end
			if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
				moveDirection = moveDirection - Vector3.new(0, 1, 0)
			end
			
			bodyVelocity.Velocity = moveDirection * flySpeed
			bodyGyro.CFrame = cam.CFrame
		end)
	else
		if flyConnection then
			flyConnection:Disconnect()
		end
		for _, v in pairs(rootPart:GetChildren()) do
			if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then
				v:Destroy()
			end
		end
	end
end)

local FlySpeedBox = CreateTextBox(MovementPage, "Fly Speed (10-200)", UDim2.new(0, 10, 0, 260))
local SetFlySpeedBtn = CreateButton(MovementPage, "Set Fly Speed", UDim2.new(0, 220, 0, 260), function()
	local speed = tonumber(FlySpeedBox.Text)
	if speed then
		flySpeed = speed
	end
end)

-- UTILITIES PAGE
local UtilTitle = Instance.new("TextLabel", UtilitiesPage)
UtilTitle.Text = "🔧 Utilities & Tools"
UtilTitle.Size = UDim2.new(1, 0, 0, 40)
UtilTitle.BackgroundTransparency = 1
UtilTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
UtilTitle.Font = Enum.Font.GothamBold
UtilTitle.TextSize = 20

-- Clone Avatar
local CloneLabel = Instance.new("TextLabel", UtilitiesPage)
CloneLabel.Text = "👤 Clone Player Avatar"
CloneLabel.Size = UDim2.new(1, 0, 0, 30)
CloneLabel.Position = UDim2.new(0, 10, 0, 50)
CloneLabel.BackgroundTransparency = 1
CloneLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
CloneLabel.Font = Enum.Font.GothamBold
CloneLabel.TextSize = 14
CloneLabel.TextXAlignment = Enum.TextXAlignment.Left

local ClonePlayerBox = CreateTextBox(UtilitiesPage, "Enter Player Name to Clone", UDim2.new(0, 10, 0, 85))
local CloneBtn = CreateButton(UtilitiesPage, "👤 Clone Avatar", UDim2.new(0, 220, 0, 85), function()
	local targetName = ClonePlayerBox.Text
	for _, v in pairs(game.Players:GetPlayers()) do
		if v.Name:lower():find(targetName:lower()) and v.Character then
			local userId = v.UserId
			
