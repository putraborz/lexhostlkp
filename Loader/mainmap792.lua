-- 🌌 LEX HOST VIP v3 — Ultimate Neon Edition
-- Made by ChatGPT ✨
-- Fly + Speed Slider + God Mode + Neon Animation + Sound FX

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

-- Bersihkan GUI lama
if game.CoreGui:FindFirstChild("LEXHostVIP_UI") then
	game.CoreGui:FindFirstChild("LEXHostVIP_UI"):Destroy()
end

--------------------------------------------------
-- 🔊 Sound FX Neon
--------------------------------------------------
local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://5869292539" -- Soft neon click
clickSound.Volume = 1
clickSound.Parent = SoundService

local function playClick()
	task.spawn(function()
		clickSound:Play()
	end)
end

--------------------------------------------------
-- 🧱 GUI Utama
--------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "LEXHostVIP_UI"
gui.Parent = game.CoreGui
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false

-- Main frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 380, 0, 320)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -160)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
mainFrame.BorderSizePixel = 0
mainFrame.BackgroundTransparency = 1
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 20)

-- Glow Border
local stroke = Instance.new("UIStroke", mainFrame)
stroke.Color = Color3.fromRGB(160, 100, 255)
stroke.Thickness = 3
stroke.Transparency = 0.4

-- Animasi fade-in + bounce
mainFrame.Position = UDim2.new(0.5, -190, 1, 0)
TweenService:Create(mainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	Position = UDim2.new(0.5, -190, 0.5, -160),
	BackgroundTransparency = 0.1
}):Play()

-- Title bar
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundColor3 = Color3.fromRGB(40, 30, 80)
title.Text = "🔮 LEX HOST VIP"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

local hue = 0
RunService.RenderStepped:Connect(function()
	hue = (hue + 1) % 360
	title.TextColor3 = Color3.fromHSV(hue / 360, 0.9, 1)
	stroke.Color = Color3.fromHSV((hue / 360 + 0.2) % 1, 1, 1)
end)

-- Close button
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -42, 0, 6)
closeBtn.Text = "✖"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextScaled = true
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 60)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)
closeBtn.MouseButton1Click:Connect(function()
	playClick()
	TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Position = UDim2.new(0.5, -190, 1.5, 0),
		BackgroundTransparency = 1
	}):Play()
	task.wait(0.5)
	gui:Destroy()
end)

--------------------------------------------------
-- 📦 Container Menu
--------------------------------------------------
local menu = Instance.new("Frame", mainFrame)
menu.Size = UDim2.new(1, -30, 1, -70)
menu.Position = UDim2.new(0, 15, 0, 60)
menu.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", menu)
layout.Padding = UDim.new(0, 12)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Top

--------------------------------------------------
-- 🧩 Utility fungsi buat tombol neon
--------------------------------------------------
local function makeButton(text, color)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 45)
	btn.BackgroundColor3 = color
	btn.BackgroundTransparency = 0.1
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextScaled = true
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.AutoButtonColor = true
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
	local s = Instance.new("UIStroke", btn)
	s.Color = Color3.fromRGB(255, 255, 255)
	s.Thickness = 1.4
	s.Transparency = 0.5
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.05}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()
	end)
	return btn
end

--------------------------------------------------
-- ✈️ FLY SYSTEM
--------------------------------------------------
local flying = false
local flyConn
local flySpeed = 80

local flyBtn = makeButton("✈️ Fly: OFF", Color3.fromRGB(90, 80, 150))
flyBtn.Parent = menu
flyBtn.MouseButton1Click:Connect(function()
	playClick()
	flying = not flying
	flyBtn.Text = flying and "🛫 Fly: ON" or "✈️ Fly: OFF"
	if flying then
		local hrp = player.Character:WaitForChild("HumanoidRootPart")
		flyConn = RunService.Heartbeat:Connect(function()
			if not flying then return end
			local move = Vector3.zero
			if UIS:IsKeyDown(Enum.KeyCode.W) then move += hrp.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.S) then move -= hrp.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.A) then move -= hrp.CFrame.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.D) then move += hrp.CFrame.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0, 1, 0) end
			if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0, 1, 0) end
			hrp.Velocity = move * flySpeed
		end)
	else
		if flyConn then flyConn:Disconnect() flyConn = nil end
		if player.Character:FindFirstChild("HumanoidRootPart") then
			player.Character.HumanoidRootPart.Velocity = Vector3.zero
		end
	end
end)

--------------------------------------------------
-- ⚡ SPEED SLIDER
--------------------------------------------------
local speedFrame = Instance.new("Frame", menu)
speedFrame.Size = UDim2.new(1, 0, 0, 65)
speedFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 120)
speedFrame.BackgroundTransparency = 0.2
Instance.new("UICorner", speedFrame).CornerRadius = UDim.new(0, 12)

local label = Instance.new("TextLabel", speedFrame)
label.Size = UDim2.new(1, 0, 0.4, 0)
label.Position = UDim2.new(0, 0, 0, 4)
label.Text = "⚡ Speed: 16"
label.Font = Enum.Font.GothamBold
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.TextScaled = true
label.BackgroundTransparency = 1

local sliderBg = Instance.new("Frame", speedFrame)
sliderBg.Size = UDim2.new(0.9, 0, 0.2, 0)
sliderBg.Position = UDim2.new(0.05, 0, 0.65, 0)
sliderBg.BackgroundColor3 = Color3.fromRGB(90, 70, 160)
Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1, 0)

local fill = Instance.new("Frame", sliderBg)
fill.BackgroundColor3 = Color3.fromRGB(150, 120, 255)
fill.Size = UDim2.new(0.15, 0, 1, 0)
Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

local dragging = false
sliderBg.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		playClick()
	end
end)
UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
		fill.Size = UDim2.new(pos, 0, 1, 0)
		local newSpeed = math.floor(16 + pos * (120 - 16))
		humanoid.WalkSpeed = newSpeed
		label.Text = "⚡ Speed: " .. newSpeed
	end
end)

--------------------------------------------------
-- 🛡️ GOD MODE
--------------------------------------------------
local god = false
local godBtn = makeButton("🛡️ God Mode: OFF", Color3.fromRGB(110, 70, 140))
godBtn.Parent = menu
godBtn.MouseButton1Click:Connect(function()
	playClick()
	god = not god
	godBtn.Text = god and "🛡️ God Mode: ON" or "🛡️ God Mode: OFF"
	if god then
		humanoid.MaxHealth = math.huge
		humanoid.Health = math.huge
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
	else
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
		humanoid.MaxHealth = 100
		humanoid.Health = 100
	end
end)

--------------------------------------------------
print("[LEX HOST VIP v3] Ultimate Neon Menu loaded successfully.")
