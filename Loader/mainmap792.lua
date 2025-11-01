--// LEX Host v3 - Cyber Neon Transparent Edition
--// Made by LEX Dev
--// Fully Functional & Scrollable Menu

local LEXHost = Instance.new("ScreenGui", game.CoreGui)
LEXHost.Name = "LEXHost"
LEXHost.ResetOnSpawn = false

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

-- Logo LX (Fixed - sekarang muncul di TopBar)
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

-- Minimize & Close
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

-- Variables untuk fitur
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- HOME PAGE
local HomePage = Instance.new("ScrollingFrame", Content)
HomePage.Name = "Home"
HomePage.Size = UDim2.new(1, 0, 1, 0)
HomePage.BackgroundTransparency = 1
HomePage.BorderSizePixel = 0
HomePage.ScrollBarThickness = 6
HomePage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
HomePage.CanvasSize = UDim2.new(0, 0, 0, 300)
HomePage.Visible = false

local HomeTitle = Instance.new("TextLabel", HomePage)
HomeTitle.BackgroundTransparency = 1
HomeTitle.Size = UDim2.new(1, 0, 0, 40)
HomeTitle.Font = Enum.Font.GothamBold
HomeTitle.Text = "Welcome to LEX Host v3"
HomeTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
HomeTitle.TextSize = 20

local HomeDesc = Instance.new("TextLabel", HomePage)
HomeDesc.BackgroundTransparency = 1
HomeDesc.Position = UDim2.new(0, 0, 0, 50)
HomeDesc.Size = UDim2.new(1, 0, 0, 200)
HomeDesc.Font = Enum.Font.Gotham
HomeDesc.Text = "Premium Exploit GUI\n\n✓ Multiple Game Modes\n✓ Movement Scripts\n✓ Teleport Features\n✓ Player Utilities\n\nSelect a tab to begin!"
HomeDesc.TextColor3 = Color3.fromRGB(150, 200, 255)
HomeDesc.TextSize = 14
HomeDesc.TextYAlignment = Enum.TextYAlignment.Top

-- MODES PAGE (Scrollable)
local ModesPage = Instance.new("ScrollingFrame", Content)
ModesPage.Name = "Modes"
ModesPage.Size = UDim2.new(1, 0, 1, 0)
ModesPage.CanvasSize = UDim2.new(0, 0, 2, 0)
ModesPage.ScrollBarThickness = 6
ModesPage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
ModesPage.BackgroundTransparency = 1
ModesPage.BorderSizePixel = 0
ModesPage.Visible = false

local Gunung = {
	"ATIN NEW","YAHAYUK NEW","WKSPEDISI ANTARTIKA NEW","MOUNT YNTKTS NEW",
	"SAKAHAYNG","STECU NEW","BALI HOT EXPEDITION","MOUNT KOMANG",
	"MOUNT PRAMBANAN","MOUNT MONO","MOUNT SUMBING","MOUNT GEMI","MOUNT KOHARU"
}

for i, name in ipairs(Gunung) do
	local btn = Instance.new("TextButton", ModesPage)
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

-- MOVEMENT PAGE
local MovementPage = Instance.new("ScrollingFrame", Content)
MovementPage.Name = "Movement"
MovementPage.Size = UDim2.new(1, 0, 1, 0)
MovementPage.BackgroundTransparency = 1
MovementPage.BorderSizePixel = 0
MovementPage.ScrollBarThickness = 6
MovementPage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
MovementPage.CanvasSize = UDim2.new(0, 0, 0, 400)
MovementPage.Visible = false

-- Speed Slider
local SpeedLabel = Instance.new("TextLabel", MovementPage)
SpeedLabel.Position = UDim2.new(0, 5, 0, 10)
SpeedLabel.Size = UDim2.new(1, -10, 0, 30)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "WalkSpeed: 16"
SpeedLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.TextSize = 14

local SpeedSlider = Instance.new("Frame", MovementPage)
SpeedSlider.Position = UDim2.new(0, 5, 0, 45)
SpeedSlider.Size = UDim2.new(1, -10, 0, 20)
SpeedSlider.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
local SpeedCorner = Instance.new("UICorner", SpeedSlider)

local SpeedFill = Instance.new("Frame", SpeedSlider)
SpeedFill.Size = UDim2.new(0.5, 0, 1, 0)
SpeedFill.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
Instance.new("UICorner", SpeedFill)

-- Jump Power Slider
local JumpLabel = Instance.new("TextLabel", MovementPage)
JumpLabel.Position = UDim2.new(0, 5, 0, 80)
JumpLabel.Size = UDim2.new(1, -10, 0, 30)
JumpLabel.BackgroundTransparency = 1
JumpLabel.Text = "JumpPower: 50"
JumpLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
JumpLabel.Font = Enum.Font.GothamBold
JumpLabel.TextSize = 14

local JumpSlider = Instance.new("Frame", MovementPage)
JumpSlider.Position = UDim2.new(0, 5, 0, 115)
JumpSlider.Size = UDim2.new(1, -10, 0, 20)
JumpSlider.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
Instance.new("UICorner", JumpSlider)

local JumpFill = Instance.new("Frame", JumpSlider)
JumpFill.Size = UDim2.new(0.5, 0, 1, 0)
JumpFill.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
Instance.new("UICorner", JumpFill)

-- Fly Button
local FlyBtn = Instance.new("TextButton", MovementPage)
FlyBtn.Position = UDim2.new(0, 5, 0, 150)
FlyBtn.Size = UDim2.new(1, -10, 0, 40)
FlyBtn.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
FlyBtn.Text = "Fly: OFF"
FlyBtn.Font = Enum.Font.GothamBold
FlyBtn.TextSize = 14
FlyBtn.TextColor3 = Color3.fromRGB(0, 190, 255)
Instance.new("UIStroke", FlyBtn).Color = Color3.fromRGB(0, 160, 255)
Instance.new("UICorner", FlyBtn)

local flying = false
FlyBtn.MouseButton1Click:Connect(function()
	flying = not flying
	FlyBtn.Text = flying and "Fly: ON" or "Fly: OFF"
	-- Basic fly script
	if flying then
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local speed = 50
		
		local function fly()
			local bg = Instance.new("BodyGyro", character.HumanoidRootPart)
			bg.P = 9e4
			bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
			bg.cframe = character.HumanoidRootPart.CFrame
			local bv = Instance.new("BodyVelocity", character.HumanoidRootPart)
			bv.velocity = Vector3.new(0, 0.1, 0)
			bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
			
			repeat wait()
				if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
					bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f + ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * 0.2, 0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * speed
				else
					bv.velocity = Vector3.new(0, 0.1, 0)
				end
				bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame
			until not flying
			
			bg:Destroy()
			bv:Destroy()
		end
		fly()
	end
end)

-- Noclip Button
local NoclipBtn = Instance.new("TextButton", MovementPage)
NoclipBtn.Position = UDim2.new(0, 5, 0, 200)
NoclipBtn.Size = UDim2.new(1, -10, 0, 40)
NoclipBtn.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
NoclipBtn.Text = "Noclip: OFF"
NoclipBtn.Font = Enum.Font.GothamBold
NoclipBtn.TextSize = 14
NoclipBtn.TextColor3 = Color3.fromRGB(0, 190, 255)
Instance.new("UIStroke", NoclipBtn).Color = Color3.fromRGB(0, 160, 255)
Instance.new("UICorner", NoclipBtn)

local noclip = false
NoclipBtn.MouseButton1Click:Connect(function()
	noclip = not noclip
	NoclipBtn.Text = noclip and "Noclip: ON" or "Noclip: OFF"
end)

game:GetService("RunService").Stepped:Connect(function()
	if noclip then
		for _, v in pairs(character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

-- UTILITIES PAGE
local UtilitiesPage = Instance.new("ScrollingFrame", Content)
UtilitiesPage.Name = "Utilities"
UtilitiesPage.Size = UDim2.new(1, 0, 1, 0)
UtilitiesPage.BackgroundTransparency = 1
UtilitiesPage.BorderSizePixel = 0
UtilitiesPage.ScrollBarThickness = 6
UtilitiesPage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
UtilitiesPage.CanvasSize = UDim2.new(0, 0, 0, 500)
UtilitiesPage.Visible = false

-- Teleport Section
local TeleportLabel = Instance.new("TextLabel", UtilitiesPage)
TeleportLabel.Position = UDim2.new(0, 5, 0, 10)
TeleportLabel.Size = UDim2.new(1, -10, 0, 30)
TeleportLabel.BackgroundTransparency = 1
TeleportLabel.Text = "Teleport to Player"
TeleportLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
TeleportLabel.Font = Enum.Font.GothamBold
TeleportLabel.TextSize = 16

local TeleportBox = Instance.new("TextBox", UtilitiesPage)
TeleportBox.Position = UDim2.new(0, 5, 0, 45)
TeleportBox.Size = UDim2.new(1, -10, 0, 35)
TeleportBox.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
TeleportBox.PlaceholderText = "Enter player name..."
TeleportBox.Text = ""
TeleportBox.Font = Enum.Font.Gotham
TeleportBox.TextSize = 14
TeleportBox.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", TeleportBox)

local TeleportBtn = Instance.new("TextButton", UtilitiesPage)
TeleportBtn.Position = UDim2.new(0, 5, 0, 85)
TeleportBtn.Size = UDim2.new(1, -10, 0, 40)
TeleportBtn.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
TeleportBtn.Text = "Teleport"
TeleportBtn.Font = Enum.Font.GothamBold
TeleportBtn.TextSize = 14
TeleportBtn.TextColor3 = Color3.fromRGB(0, 190, 255)
Instance.new("UIStroke", TeleportBtn).Color = Color3.fromRGB(0, 160, 255)
Instance.new("UICorner", TeleportBtn)

TeleportBtn.MouseButton1Click:Connect(function()
	local targetName = TeleportBox.Text
	for _, v in pairs(game.Players:GetPlayers()) do
		if v.Name:lower():find(targetName:lower()) and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
			character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
			break
		end
	end
end)

-- ESP Button
local ESPBtn = Instance.new("TextButton", UtilitiesPage)
ESPBtn.Position = UDim2.new(0, 5, 0, 140)
ESPBtn.Size = UDim2.new(1, -10, 0, 40)
ESPBtn.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
ESPBtn.Text = "ESP: OFF"
ESPBtn.Font = Enum.Font.GothamBold
ESPBtn.TextSize = 14
ESPBtn.TextColor3 = Color3.fromRGB(0, 190, 255)
Instance.new("UIStroke", ESPBtn).Color = Color3.fromRGB(0, 160, 255)
Instance.new("UICorner", ESPBtn)

local esp = false
ESPBtn.MouseButton1Click:Connect(function()
	esp = not esp
	ESPBtn.Text = esp and "ESP: ON" or "ESP: OFF"
	-- Basic ESP implementation
	for _, v in pairs(game.Players:GetPlayers()) do
		if v ~= player and v.Character then
			if esp then
				local highlight = Instance.new("Highlight", v.Character)
				highlight.FillColor = Color3.fromRGB(0, 200, 255)
				highlight.OutlineColor = Color3.fromRGB(0, 150, 255)
			else
				if v.Character:FindFirstChild("Highlight") then
					v.Character.Highlight:Destroy()
				end
			end
		end
	end
end)

-- FullBright Button
local BrightBtn = Instance.new("TextButton", UtilitiesPage)
BrightBtn.Position = UDim2.new(0, 5, 0, 190)
BrightBtn.Size = UDim2.new(1, -10, 0, 40)
BrightBtn.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
BrightBtn.Text = "FullBright: OFF"
BrightBtn.Font = Enum.Font.GothamBold
BrightBtn.TextSize = 14
BrightBtn.TextColor3 = Color3.fromRGB(0, 190, 255)
Instance.new("UIStroke", BrightBtn).Color = Color3.fromRGB(0, 160, 255)
Instance.new("UICorner", BrightBtn)

local bright = false
BrightBtn.MouseButton1Click:Connect(function()
	bright = not bright
	BrightBtn.Text = bright and "FullBright: ON" or "FullBright: OFF"
	if bright then
		game.Lighting.Brightness = 2
		game.Lighting.ClockTime = 14
		game.Lighting.FogEnd = 100000
		game.Lighting.GlobalShadows = false
		game.Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
	else
		game.Lighting.Brightness = 1
		game.Lighting.ClockTime = 12
		game.Lighting.FogEnd = 100000
		game.Lighting.GlobalShadows = true
		game.Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
	end
end)

-- INFO PAGE
local InfoPage = Instance.new("ScrollingFrame", Content)
InfoPage.Name = "Info"
InfoPage.Size = UDim2.new(1, 0, 1, 0)
InfoPage.BackgroundTransparency = 1
InfoPage.BorderSizePixel = 0
InfoPage.ScrollBarThickness = 6
InfoPage.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
InfoPage.CanvasSize = UDim2.new(0, 0, 0, 350)
InfoPage.Visible = false

local InfoTitle = Instance.new("TextLabel", InfoPage)
InfoTitle.BackgroundTransparency = 1
InfoTitle.Size = UDim2.new(1, 0, 0, 40)
InfoTitle.Font = Enum.Font.GothamBold
InfoTitle.Text = "About LEX Host v3"
InfoTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
InfoTitle.TextSize = 20

local InfoText = Instance.new("TextLabel", InfoPage)
InfoText.BackgroundTransparency = 1
InfoText.Position = UDim2.new(0, 0, 0, 50)
InfoText.Size = UDim2.new(1, 0, 0, 250)
InfoText.Font = Enum.Font.Gotham
InfoText.Text = [[Version: 3.0
Made by: LEX Dev

Features:
• Multiple game modes
• Advanced movement controls
• Player teleportation
• ESP & FullBright
• Noclip & Fly
• Customizable speeds

Credits:
LEX Development Team

Thank you for using LEX Host!]]
InfoText.TextColor3 = Color3.fromRGB(150, 200, 255)
InfoText.TextSize = 14
InfoText.TextYAlignment = Enum.TextYAlignment.Top

-- Tab System
local function ShowTab(tab)
	HomePage.Visible = false
	ModesPage.Visible = false
	MovementPage.Visible = false
	UtilitiesPage.Visible = false
	InfoPage.Visible = false
	
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

-- Show Home by default
ShowTab("Home")

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

print("LEX Host v3 loaded successfully!")
