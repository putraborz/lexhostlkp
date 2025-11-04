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

-- Animation Functions
local function CreateTween(obj, info, props)
	return TweenService:Create(obj, info, props)
end

local function PulseAnimation(obj)
	spawn(function()
		while obj and obj.Parent do
			CreateTween(obj, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
				ImageColor3 = Color3.fromRGB(100, 220, 255)
			}):Play()
			wait(0.8)
			CreateTween(obj, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
				ImageColor3 = Color3.fromRGB(255, 255, 255)
			}):Play()
			wait(0.8)
		end
	end)
end

local function FloatAnimation(obj)
	spawn(function()
		local originalPos = obj.Position
		while obj and obj.Parent do
			CreateTween(obj, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
				Position = UDim2.new(originalPos.X.Scale, originalPos.X.Offset, originalPos.Y.Scale, originalPos.Y.Offset - 5)
			}):Play()
			wait(2)
			CreateTween(obj, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
				Position = originalPos
			}):Play()
			wait(2)
		end
	end)
end

local LEXHost = Instance.new("ScreenGui", game.CoreGui)
LEXHost.Name = "LEXHost"
LEXHost.ResetOnSpawn = false

-- Logo Button with enhanced animations
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

-- Animated Gradient for Logo
local LogoGradient = Instance.new("UIGradient", LogoButton)
LogoGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 220, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 255))
}
LogoGradient.Rotation = 45

-- Rotate gradient animation
spawn(function()
	while LogoButton and LogoButton.Parent do
		for i = 0, 360, 2 do
			if not LogoButton or not LogoButton.Parent then break end
			LogoGradient.Rotation = i
			wait(0.03)
		end
	end
end)

-- Pulse animation for logo
PulseAnimation(LogoButton)

LogoButton.MouseEnter:Connect(function()
	CreateTween(LogoButton, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Size = UDim2.new(0, (isMobile and 50 or 80) * 1.15, 0, (isMobile and 50 or 80) * 1.15),
		ImageColor3 = Color3.fromRGB(150, 255, 255)
	}):Play()
	CreateTween(LogoStroke, TweenInfo.new(0.3), {
		Thickness = isMobile and 3 or 4
	}):Play()
end)

LogoButton.MouseLeave:Connect(function()
	CreateTween(LogoButton, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
		Size = UIConfig.Logo.Size,
		ImageColor3 = Color3.fromRGB(255, 255, 255)
	}):Play()
	CreateTween(LogoStroke, TweenInfo.new(0.3), {
		Thickness = isMobile and 2 or 2.5
	}):Play()
end)

-- Main Frame with entrance animation
local MainFrame = Instance.new("Frame")
MainFrame.Parent = LEXHost
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 1.5, 0)
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

-- Animated gradient border effect
spawn(function()
	while Stroke and Stroke.Parent do
		for hue = 0, 1, 0.01 do
			if not Stroke or not Stroke.Parent then break end
			Stroke.Color = Color3.fromHSV(hue, 0.8, 1)
			wait(0.05)
		end
	end
end)

-- Enhanced Shadow with glow effect
local Shadow = Instance.new("ImageLabel", MainFrame)
Shadow.Name = "Shadow"
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.Size = UDim2.new(1, isMobile and 30 or 40, 1, isMobile and 30 or 40)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://6014261993"
Shadow.ImageColor3 = Color3.fromRGB(0, 150, 255)
Shadow.ImageTransparency = 0.5
Shadow.ZIndex = -1

-- Pulsing shadow effect
spawn(function()
	while Shadow and Shadow.Parent do
		CreateTween(Shadow, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			ImageTransparency = 0.3,
			Size = UDim2.new(1, isMobile and 35 or 50, 1, isMobile and 35 or 50)
		}):Play()
		wait(1.5)
		CreateTween(Shadow, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			ImageTransparency = 0.7,
			Size = UDim2.new(1, isMobile and 30 or 40, 1, isMobile and 30 or 40)
		}):Play()
		wait(1.5)
	end
end)

-- Animated particles background
local function CreateParticle(parent)
	local particle = Instance.new("Frame", parent)
	particle.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
	particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
	particle.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
	particle.BackgroundTransparency = math.random(50, 80) / 100
	particle.BorderSizePixel = 0
	particle.ZIndex = 1
	
	local corner = Instance.new("UICorner", particle)
	corner.CornerRadius = UDim.new(1, 0)
	
	spawn(function()
		while particle and particle.Parent do
			local targetY = particle.Position.Y.Scale - 0.3
			if targetY < -0.1 then targetY = 1.1 end
			CreateTween(particle, TweenInfo.new(math.random(3, 6), Enum.EasingStyle.Linear), {
				Position = UDim2.new(particle.Position.X.Scale, 0, targetY, 0)
			}):Play()
			wait(math.random(3, 6))
		end
	end)
	
	return particle
end

-- Create multiple particles
for i = 1, (isMobile and 15 or 25) do
	CreateParticle(MainFrame)
end

-- Topbar with gradient
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, UIConfig.TopBar)
TopBar.BackgroundColor3 = Color3.fromRGB(10, 15, 35)
TopBar.BackgroundTransparency = 0.2

local TopCorner = Instance.new("UICorner", TopBar)
TopCorner.CornerRadius = UDim.new(0, isMobile and 10 or 15)

local TopGradient = Instance.new("UIGradient", TopBar)
TopGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 15, 35)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 25, 50))
}
TopGradient.Rotation = 90

-- Logo Image in TopBar with float effect
local LX = Instance.new("ImageLabel", TopBar)
LX.Image = "rbxassetid://93847535906931"
LX.Position = UDim2.new(0, isMobile and 5 or 10, 0, isMobile and 5 or 5)
LX.Size = UDim2.new(0, isMobile and 30 or 40, 0, isMobile and 30 or 40)
LX.BackgroundTransparency = 1
LX.ScaleType = Enum.ScaleType.Fit
LX.ZIndex = 2

FloatAnimation(LX)

-- Title with typing animation effect
local Title = Instance.new("TextLabel", TopBar)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, isMobile and 40 or 60, 0, 0)
Title.Size = UDim2.new(0.5, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = ""
Title.TextColor3 = Color3.fromRGB(0, 190, 255)
Title.TextSize = UIConfig.TextSize.Title
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 2

local fullText = isMobile and "LEX Host v3" or "LEX Host v3 - Vip Edition"
spawn(function()
	for i = 1, #fullText do
		Title.Text = string.sub(fullText, 1, i)
		wait(0.05)
	end
end)

-- Minimize & Close buttons with enhanced animations
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
MinBtn.ZIndex = 2

local MinCorner = Instance.new("UICorner", MinBtn)
MinCorner.CornerRadius = UDim.new(0, isMobile and 6 or 8)

MinBtn.MouseEnter:Connect(function()
	CreateTween(MinBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
		BackgroundColor3 = Color3.fromRGB(30, 45, 70),
		Size = UDim2.new(0, btnSize * 1.1, 0, btnSize * 1.1)
	}):Play()
	CreateTween(MinBtn, TweenInfo.new(0.2), {
		TextColor3 = Color3.fromRGB(100, 255, 255)
	}):Play()
end)

MinBtn.MouseLeave:Connect(function()
	CreateTween(MinBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
		BackgroundColor3 = Color3.fromRGB(20, 30, 50),
		Size = UDim2.new(0, btnSize, 0, btnSize)
	}):Play()
	CreateTween(MinBtn, TweenInfo.new(0.2), {
		TextColor3 = Color3.fromRGB(0, 200, 255)
	}):Play()
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
CloseBtn.ZIndex = 2

local CloseCorner = Instance.new("UICorner", CloseBtn)
CloseCorner.CornerRadius = UDim.new(0, isMobile and 6 or 8)

CloseBtn.MouseEnter:Connect(function()
	CreateTween(CloseBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
		BackgroundColor3 = Color3.fromRGB(80, 30, 30),
		Size = UDim2.new(0, btnSize * 1.1, 0, btnSize * 1.1),
		Rotation = 90
	}):Play()
	CreateTween(CloseBtn, TweenInfo.new(0.2), {
		TextColor3 = Color3.fromRGB(255, 150, 150)
	}):Play()
end)

CloseBtn.MouseLeave:Connect(function()
	CreateTween(CloseBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
		BackgroundColor3 = Color3.fromRGB(50, 20, 20),
		Size = UDim2.new(0, btnSize, 0, btnSize),
		Rotation = 0
	}):Play()
	CreateTween(CloseBtn, TweenInfo.new(0.2), {
		TextColor3 = Color3.fromRGB(255, 80, 80)
	}):Play()
end)

-- Sidebar with gradient
local Side = Instance.new("Frame", MainFrame)
Side.Position = UDim2.new(0, 0, 0, UIConfig.TopBar)
Side.Size = UDim2.new(0, UIConfig.MainFrame.SidebarWidth, 1, -UIConfig.TopBar)
Side.BackgroundColor3 = Color3.fromRGB(8, 15, 35)
Side.BackgroundTransparency = 0.3
Side.BorderSizePixel = 0
Side.ZIndex = 2

local SideGradient = Instance.new("UIGradient", Side)
SideGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 15, 35)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 20, 45))
}
SideGradient.Rotation = 90

-- Enhanced Tab Buttons with animations
local Tabs = {"Home","Mount","Movement","Utilities","Clone","Parts","Server","Donate","Info"}
local Buttons = {}
local buttonHeight = isMobile and 32 or 40
local buttonSpacing = isMobile and 36 or 45

for i, v in ipairs(Tabs) do
	local B = Instance.new("TextButton", Side)
	B.Text = v
	B.Size = UDim2.new(1, isMobile and -10 or -15, 0, buttonHeight)
	B.Position = UDim2.new(0, isMobile and 5 or 7.5, 0, (i - 1) * buttonSpacing + (isMobile and 5 or 10))
	B.BackgroundColor3 = Color3.fromRGB(15, 25, 50)
	B.TextColor3 = Color3.fromRGB(0, 200, 255)
	B.Font = Enum.Font.GothamBold
	B.TextSize = UIConfig.TextSize.Button
	B.AutoButtonColor = false
	B.BorderSizePixel = 0
	B.ZIndex = 3
	B.BackgroundTransparency = 0.3
	
	-- Gradient for buttons
	local BGradient = Instance.new("UIGradient", B)
	BGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 25, 50)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 35, 70))
	}
	BGradient.Rotation = 45
	
	local s = Instance.new("UIStroke", B)
	s.Color = Color3.fromRGB(0, 190, 255)
	s.Thickness = isMobile and 1.5 or 2
	s.Transparency = 0.5
	
	local c = Instance.new("UICorner", B)
	c.CornerRadius = UDim.new(0, isMobile and 6 or 10)
	
	-- Entrance animation with delay
	B.Size = UDim2.new(0, 0, 0, buttonHeight)
	spawn(function()
		wait(i * 0.05)
		CreateTween(B, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.new(1, isMobile and -10 or -15, 0, buttonHeight)
		}):Play()
	end)
	
	B.MouseEnter:Connect(function()
		CreateTween(B, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
			BackgroundColor3 = Color3.fromRGB(25, 40, 80),
			BackgroundTransparency = 0
		}):Play()
		CreateTween(s, TweenInfo.new(0.3), {
			Thickness = isMobile and 2.5 or 3,
			Transparency = 0
		}):Play()
		CreateTween(B, TweenInfo.new(0.3), {
			TextColor3 = Color3.fromRGB(100, 255, 255),
			Size = UDim2.new(1, isMobile and -5 or -10, 0, buttonHeight)
		}):Play()
	end)
	
	B.MouseLeave:Connect(function()
		CreateTween(B, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
			BackgroundColor3 = Color3.fromRGB(15, 25, 50),
			BackgroundTransparency = 0.3
		}):Play()
		CreateTween(s, TweenInfo.new(0.3), {
			Thickness = isMobile and 1.5 or 2,
			Transparency = 0.5
		}):Play()
		CreateTween(B, TweenInfo.new(0.3), {
			TextColor3 = Color3.fromRGB(0, 200, 255),
			Size = UDim2.new(1, isMobile and -10 or -15, 0, buttonHeight)
		}):Play()
	end)
	
	Buttons[v] = B
end

-- Content Area
local contentMargin = isMobile and 5 or 10
local Content = Instance.new("Frame", MainFrame)
Content.Position = UDim2.new(0, UIConfig.MainFrame.SidebarWidth + contentMargin, 0, UIConfig.TopBar + contentMargin)
Content.Size = UDim2.new(1, -(UIConfig.MainFrame.SidebarWidth + contentMargin*2), 1, -(UIConfig.TopBar + contentMargin*2))
Content.BackgroundTransparency = 1
Content.ZIndex = 2

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

-- Enhanced Loading Screen with animations
local LoadingFrame = Instance.new("Frame", Content)
LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingFrame.BackgroundTransparency = 1
LoadingFrame.Visible = true
LoadingFrame.ZIndex = 3

-- Animated loading circle
local LoadingCircle = Instance.new("ImageLabel", LoadingFrame)
LoadingCircle.Size = UDim2.new(0, isMobile and 60 or 80, 0, isMobile and 60 or 80)
LoadingCircle.Position = UDim2.new(0.5, -(isMobile and 30 or 40), 0.3, 0)
LoadingCircle.BackgroundTransparency = 1
LoadingCircle.Image = "rbxassetid://4965945816"
LoadingCircle.ImageColor3 = Color3.fromRGB(0, 220, 255)

spawn(function()
	while LoadingCircle and LoadingCircle.Parent and LoadingFrame.Visible do
		CreateTween(LoadingCircle, TweenInfo.new(1, Enum.EasingStyle.Linear), {
			Rotation = 360
		}):Play()
		wait(1)
		LoadingCircle.Rotation = 0
	end
end)

local LoadingText = Instance.new("TextLabel", LoadingFrame)
LoadingText.Size = UDim2.new(1, 0, 0.2, 0)
LoadingText.Position = UDim2.new(0, 0, 0.45, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = isMobile and "⚡ Loading..." or "⚡ Loading LEX Host v3..."
LoadingText.TextColor3 = Color3.fromRGB(0, 220, 255)
LoadingText.Font = Enum.Font.GothamBold
LoadingText.TextSize = isMobile and 16 or 20
LoadingText.TextWrapped = true

-- Pulsing text effect
spawn(function()
	while LoadingText and LoadingText.Parent and LoadingFrame.Visible do
		CreateTween(LoadingText, TweenInfo.new(0.6, Enum.EasingStyle.Sine), {
			TextTransparency = 0.3
		}):Play()
		wait(0.6)
		CreateTween(LoadingText, TweenInfo.new(0.6, Enum.EasingStyle.Sine), {
			TextTransparency = 0
		}):Play()
		wait(0.6)
	end
end)

local LoadingDesc = Instance.new("TextLabel", LoadingFrame)
LoadingDesc.Size = UDim2.new(1, 0, 0.2, 0)
LoadingDesc.Position = UDim2.new(0, 0, 0.55, 0)
LoadingDesc.BackgroundTransparency = 1
LoadingDesc.Text = "Connecting..."
LoadingDesc.TextColor3 = Color3.fromRGB(150, 200, 255)
LoadingDesc.Font = Enum.Font.Gotham
LoadingDesc.TextSize = UIConfig.TextSize.Normal
LoadingDesc.TextWrapped = true

-- Progress bar
local ProgressBar = Instance.new("Frame", LoadingFrame)
ProgressBar.Size = UDim2.new(0.8, 0, 0, isMobile and 4 or 6)
ProgressBar.Position = UDim2.new(0.1, 0, 0.65, 0)
ProgressBar.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
ProgressBar.BorderSizePixel = 0

local ProgressCorner = Instance.new("UICorner", ProgressBar)
ProgressCorner.CornerRadius = UDim.new(1, 0)

local ProgressFill = Instance.new("Frame", ProgressBar)
ProgressFill.Size = UDim2.new(0, 0, 1, 0)
ProgressFill.BackgroundColor3 = Color3.fromRGB(0, 220, 255)
ProgressFill.BorderSizePixel = 0

local FillCorner = Instance.new("UICorner", ProgressFill)
FillCorner.CornerRadius = UDim.new(1, 0)

-- Enhanced scrolling pages with smooth scroll
local scrollBarSize = isMobile and 8 or 10

local function CreatePage(name, canvasHeight)
	local page = Instance.new("ScrollingFrame", Content)
	page.Name = name
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.ScrollBarThickness = scrollBarSize
	page.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
	page.CanvasSize = UDim2.new(0, 0, 0, canvasHeight)
	page.Visible = false
	page.ScrollingDirection = Enum.ScrollingDirection.Y
	page.ElasticBehavior = Enum.ElasticBehavior.Always
	page.ScrollingEnabled = true
	page.ZIndex = 2
	
	-- Smooth scroll effect
	page:GetPropertyChangedSignal("
