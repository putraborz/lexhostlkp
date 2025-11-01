-- Movement.lua - Enhanced Version
local MovementModule = {}

function MovementModule.Initialize(MovementPage, player, character)
	local humanoid = character:WaitForChild("Humanoid")
	local hrp = character:WaitForChild("HumanoidRootPart")
	
	-- Title
	local Title = Instance.new("TextLabel", MovementPage)
	Title.Size = UDim2.new(1, -10, 0, 40)
	Title.Position = UDim2.new(0, 5, 0, 10)
	Title.BackgroundTransparency = 1
	Title.Text = "⚡ Movement Controls"
	Title.TextColor3 = Color3.fromRGB(0, 220, 255)
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 20
	Title.TextXAlignment = Enum.TextXAlignment.Left

	-- WalkSpeed Section
	local SpeedLabel = Instance.new("TextLabel", MovementPage)
	SpeedLabel.Position = UDim2.new(0, 5, 0, 65)
	SpeedLabel.Size = UDim2.new(1, -10, 0, 30)
	SpeedLabel.BackgroundTransparency = 1
	SpeedLabel.Text = "🏃 WalkSpeed Control"
	SpeedLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	SpeedLabel.Font = Enum.Font.GothamBold
	SpeedLabel.TextSize = 16
	SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

	local SpeedBox = Instance.new("TextBox", MovementPage)
	SpeedBox.Position = UDim2.new(0, 5, 0, 100)
	SpeedBox.Size = UDim2.new(0.6, -10, 0, 40)
	SpeedBox.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
	SpeedBox.PlaceholderText = "Enter speed (16-500)"
	SpeedBox.Text = "16"
	SpeedBox.Font = Enum.Font.Gotham
	SpeedBox.TextSize = 15
	SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	SpeedBox.BorderSizePixel = 0
	local SpeedCorner = Instance.new("UICorner", SpeedBox)
	SpeedCorner.CornerRadius = UDim.new(0, 8)
	local SpeedStroke = Instance.new("UIStroke", SpeedBox)
	SpeedStroke.Color = Color3.fromRGB(0, 160, 255)
	SpeedStroke.Thickness = 2

	local SpeedBtn = Instance.new("TextButton", MovementPage)
	SpeedBtn.Position = UDim2.new(0.6, 5, 0, 100)
	SpeedBtn.Size = UDim2.new(0.4, -10, 0, 40)
	SpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
	SpeedBtn.Text = "Set Speed"
	SpeedBtn.Font = Enum.Font.GothamBold
	SpeedBtn.TextSize = 14
	SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	SpeedBtn.BorderSizePixel = 0
	local SpeedBtnCorner = Instance.new("UICorner", SpeedBtn)
	SpeedBtnCorner.CornerRadius = UDim.new(0, 8)
	
	SpeedBtn.MouseEnter:Connect(function() SpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 240) end)
	SpeedBtn.MouseLeave:Connect(function() SpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200) end)
	
	SpeedBtn.MouseButton1Click:Connect(function()
		local speed = tonumber(SpeedBox.Text)
		if speed and speed >= 0 and speed <= 1000 then
			humanoid.WalkSpeed = speed
			SpeedBtn.Text = "✓ Applied!"
			wait(1)
			SpeedBtn.Text = "Set Speed"
		else
			SpeedBtn.Text = "Invalid!"
			wait(1)
			SpeedBtn.Text = "Set Speed"
		end
	end)

	-- JumpPower Section
	local JumpLabel = Instance.new("TextLabel", MovementPage)
	JumpLabel.Position = UDim2.new(0, 5, 0, 160)
	JumpLabel.Size = UDim2.new(1, -10, 0, 30)
	JumpLabel.BackgroundTransparency = 1
	JumpLabel.Text = "🦘 JumpPower Control"
	JumpLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	JumpLabel.Font = Enum.Font.GothamBold
	JumpLabel.TextSize = 16
	JumpLabel.TextXAlignment = Enum.TextXAlignment.Left

	local JumpBox = Instance.new("TextBox", MovementPage)
	JumpBox.Position = UDim2.new(0, 5, 0, 195)
	JumpBox.Size = UDim2.new(0.6, -10, 0, 40)
	JumpBox.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
	JumpBox.PlaceholderText = "Enter jump (50-500)"
	JumpBox.Text = "50"
	JumpBox.Font = Enum.Font.Gotham
	JumpBox.TextSize = 15
	JumpBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	JumpBox.BorderSizePixel = 0
	local JumpCorner = Instance.new("UICorner", JumpBox)
	JumpCorner.CornerRadius = UDim.new(0, 8)
	local JumpStroke = Instance.new("UIStroke", JumpBox)
	JumpStroke.Color = Color3.fromRGB(0, 160, 255)
	JumpStroke.Thickness = 2

	local JumpBtn = Instance.new("TextButton", MovementPage)
	JumpBtn.Position = UDim2.new(0.6, 5, 0, 195)
	JumpBtn.Size = UDim2.new(0.4, -10, 0, 40)
	JumpBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
	JumpBtn.Text = "Set Jump"
	JumpBtn.Font = Enum.Font.GothamBold
	JumpBtn.TextSize = 14
	JumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	JumpBtn.BorderSizePixel = 0
	local JumpBtnCorner = Instance.new("UICorner", JumpBtn)
	JumpBtnCorner.CornerRadius = UDim.new(0, 8)
	
	JumpBtn.MouseEnter:Connect(function() JumpBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 240) end)
	JumpBtn.MouseLeave:Connect(function() JumpBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200) end)
	
	JumpBtn.MouseButton1Click:Connect(function()
		local jump = tonumber(JumpBox.Text)
		if jump and jump >= 0 and jump <= 1000 then
			humanoid.JumpPower = jump
			JumpBtn.Text = "✓ Applied!"
			wait(1)
			JumpBtn.Text = "Set Jump"
		else
			JumpBtn.Text = "Invalid!"
			wait(1)
			JumpBtn.Text = "Set Jump"
		end
	end)

	-- Fly Section
	local FlyLabel = Instance.new("TextLabel", MovementPage)
	FlyLabel.Position = UDim2.new(0, 5, 0, 255)
	FlyLabel.Size = UDim2.new(1, -10, 0, 30)
	FlyLabel.BackgroundTransparency = 1
	FlyLabel.Text = "✈️ Fly Mode"
	FlyLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	FlyLabel.Font = Enum.Font.GothamBold
	FlyLabel.TextSize = 16
	FlyLabel.TextXAlignment = Enum.TextXAlignment.Left

	local FlyBtn = Instance.new("TextButton", MovementPage)
	FlyBtn.Position = UDim2.new(0, 5, 0, 290)
	FlyBtn.Size = UDim2.new(1, -10, 0, 45)
	FlyBtn.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
	FlyBtn.Text = "🚀 Fly: OFF"
	FlyBtn.Font = Enum.Font.GothamBold
	FlyBtn.TextSize = 16
	FlyBtn.TextColor3 = Color3.fromRGB(0, 190, 255)
	FlyBtn.BorderSizePixel = 0
	local FlyCorner = Instance.new("UICorner", FlyBtn)
	FlyCorner.CornerRadius = UDim.new(0, 10)
	local FlyStroke = Instance.new("UIStroke", FlyBtn)
	FlyStroke.Color = Color3.fromRGB(0, 160, 255)
	FlyStroke.Thickness = 2

	local flying = false
	local flyConnection
	
	FlyBtn.MouseButton1Click:Connect(function()
		flying = not flying
		if flying then
			FlyBtn.Text = "🚀 Fly: ON"
			FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 50)
			FlyStroke.Color = Color3.fromRGB(0, 255, 100)
			
			local BG = Instance.new("BodyGyro", hrp)
			local BV = Instance.new("BodyVelocity", hrp)
			BG.P = 9e4
			BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
			BG.cframe = hrp.CFrame
			BV.velocity = Vector3.new(0, 0, 0)
			BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
			
			local speed = 50
			flyConnection = game:GetService("RunService").Heartbeat:Connect(function()
				if not flying then return end
				
				local cam = workspace.CurrentCamera
				local moveDirection = Vector3.new(0, 0, 0)
				
				if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
					moveDirection = moveDirection + (cam.CFrame.LookVector)
				end
				if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
					moveDirection = moveDirection - (cam.CFrame.LookVector)
				end
				if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
					moveDirection = moveDirection - (cam.CFrame.RightVector)
				end
				if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
					moveDirection = moveDirection + (cam.CFrame.RightVector)
				end
				if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
					moveDirection = moveDirection + Vector3.new(0, 1, 0)
				end
				if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then
					moveDirection = moveDirection - Vector3.new(0, 1, 0)
				end
				
				BV.velocity = moveDirection.Unit * speed
				BG.cframe = cam.CFrame
			end)
		else
			FlyBtn.Text = "🚀 Fly: OFF"
			FlyBtn.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
			FlyStroke.Color = Color3.fromRGB(0, 160, 255)
			
			if flyConnection then
				flyConnection:Disconnect()
			end
			for _, v in pairs(hrp:GetChildren()) do
				if v:IsA("BodyGyro") or v:IsA("BodyVelocity") then
					v:Destroy()
				end
			end
		end
	end)

	-- Noclip Section
	local NoclipLabel = Instance.new("TextLabel", MovementPage)
	NoclipLabel.Position = UDim2.new(0, 5, 0, 355)
	NoclipLabel.Size = UDim2.new(1, -10, 0, 30)
	NoclipLabel.BackgroundTransparency = 1
	NoclipLabel.Text = "👻 Noclip Mode"
	NoclipLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	NoclipLabel.Font = Enum.Font.GothamBold
	NoclipLabel.TextSize = 16
	NoclipLabel.TextXAlignment = Enum.TextXAlignment.Left

	local NoclipBtn = Instance.new("TextButton", MovementPage)
	NoclipBtn.Position = UDim2.new(0, 5, 0, 390)
	NoclipBtn.Size = UDim2.new(1, -10, 0, 45)
	NoclipBtn.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
	NoclipBtn.Text = "👻 Noclip: OFF"
	NoclipBtn.Font = Enum.Font.GothamBold
	NoclipBtn.TextSize = 16
	NoclipBtn.TextColor3 = Color3.fromRGB(0, 190, 255)
	NoclipBtn.BorderSizePixel = 0
	local NoclipCorner = Instance.new("UICorner", NoclipBtn)
	NoclipCorner.CornerRadius = UDim.new(0, 10)
	local NoclipStroke = Instance.new("UIStroke", NoclipBtn)
	NoclipStroke.Color = Color3.fromRGB(0, 160, 255)
	NoclipStroke.Thickness = 2

	local noclip = false
	NoclipBtn.MouseButton1Click:Connect(function()
		noclip = not noclip
		if noclip then
			NoclipBtn.Text = "👻 Noclip: ON"
			NoclipBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 50)
			NoclipStroke.Color = Color3.fromRGB(0, 255, 100)
		else
			NoclipBtn.Text = "👻 Noclip: OFF"
			NoclipBtn.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
			NoclipStroke.Color = Color3.fromRGB(0, 160, 255)
		end
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
end

return MovementModule
