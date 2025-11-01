-- Movement.lua - Enhanced Version with Fly Speed Control & Anti-Fall
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
	FlyLabel.Text = "✈️ Fly Mode (W/A/S/D, Space/Shift)"
	FlyLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	FlyLabel.Font = Enum.Font.GothamBold
	FlyLabel.TextSize = 16
	FlyLabel.TextXAlignment = Enum.TextXAlignment.Left

	-- Fly Speed Control
	local FlySpeedLabel = Instance.new("TextLabel", MovementPage)
	FlySpeedLabel.Position = UDim2.new(0, 5, 0, 290)
	FlySpeedLabel.Size = UDim2.new(1, -10, 0, 25)
	FlySpeedLabel.BackgroundTransparency = 1
	FlySpeedLabel.Text = "Fly Speed:"
	FlySpeedLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
	FlySpeedLabel.Font = Enum.Font.Gotham
	FlySpeedLabel.TextSize = 13
	FlySpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

	local FlySpeedBox = Instance.new("TextBox", MovementPage)
	FlySpeedBox.Position = UDim2.new(0, 5, 0, 320)
	FlySpeedBox.Size = UDim2.new(0.6, -10, 0, 40)
	FlySpeedBox.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
	FlySpeedBox.PlaceholderText = "Fly speed (10-500)"
	FlySpeedBox.Text = "50"
	FlySpeedBox.Font = Enum.Font.Gotham
	FlySpeedBox.TextSize = 15
	FlySpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	FlySpeedBox.BorderSizePixel = 0
	local FlySpeedCorner = Instance.new("UICorner", FlySpeedBox)
	FlySpeedCorner.CornerRadius = UDim.new(0, 8)
	local FlySpeedStroke = Instance.new("UIStroke", FlySpeedBox)
	FlySpeedStroke.Color = Color3.fromRGB(0, 160, 255)
	FlySpeedStroke.Thickness = 2

	local SetFlySpeedBtn = Instance.new("TextButton", MovementPage)
	SetFlySpeedBtn.Position = UDim2.new(0.6, 5, 0, 320)
	SetFlySpeedBtn.Size = UDim2.new(0.4, -10, 0, 40)
	SetFlySpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
	SetFlySpeedBtn.Text = "Set Fly Speed"
	SetFlySpeedBtn.Font = Enum.Font.GothamBold
	SetFlySpeedBtn.TextSize = 14
	SetFlySpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	SetFlySpeedBtn.BorderSizePixel = 0
	local SetFlySpeedCorner = Instance.new("UICorner", SetFlySpeedBtn)
	SetFlySpeedCorner.CornerRadius = UDim.new(0, 8)
	
	SetFlySpeedBtn.MouseEnter:Connect(function() SetFlySpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 240) end)
	SetFlySpeedBtn.MouseLeave:Connect(function() SetFlySpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200) end)

	local currentFlySpeed = 50

	SetFlySpeedBtn.MouseButton1Click:Connect(function()
		local speed = tonumber(FlySpeedBox.Text)
		if speed and speed >= 1 and speed <= 500 then
			currentFlySpeed = speed
			SetFlySpeedBtn.Text = "✓ Speed Set!"
			wait(1)
			SetFlySpeedBtn.Text = "Set Fly Speed"
		else
			SetFlySpeedBtn.Text = "Invalid!"
			wait(1)
			SetFlySpeedBtn.Text = "Set Fly Speed"
		end
	end)

	-- Fly Toggle Button
	local FlyBtn = Instance.new("TextButton", MovementPage)
	FlyBtn.Position = UDim2.new(0, 5, 0, 370)
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
	local BG, BV
	
	FlyBtn.MouseButton1Click:Connect(function()
		flying = not flying
		if flying then
			FlyBtn.Text = "🚀 Fly: ON (Speed: " .. currentFlySpeed .. ")"
			FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 50)
			FlyStroke.Color = Color3.fromRGB(0, 255, 100)
			
			-- Create fly components
			BG = Instance.new("BodyGyro")
			BG.P = 9e4
			BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
			BG.cframe = hrp.CFrame
			BG.Parent = hrp
			
			BV = Instance.new("BodyVelocity")
			BV.velocity = Vector3.new(0, 0, 0)
			BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
			BV.Parent = hrp
			
			-- Disable humanoid states for smoother fly
			humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
			humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
			humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, false)
			humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
			humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
			humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
			
			-- Fly loop
			flyConnection = game:GetService("RunService").Heartbeat:Connect(function()
				if not flying or not BG or not BV then return end
				
				local cam = workspace.CurrentCamera
				local moveDirection = Vector3.new(0, 0, 0)
				
				-- WASD Controls
				if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
					moveDirection = moveDirection + cam.CFrame.LookVector
				end
				if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
					moveDirection = moveDirection - cam.CFrame.LookVector
				end
				if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
					moveDirection = moveDirection - cam.CFrame.RightVector
				end
				if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
					moveDirection = moveDirection + cam.CFrame.RightVector
				end
				
				-- Space to go up, Shift to go down
				if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
					moveDirection = moveDirection + Vector3.new(0, 1, 0)
				end
				if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then
					moveDirection = moveDirection + Vector3.new(0, -1, 0)
				end
				
				-- Apply velocity and rotation
				if moveDirection.Magnitude > 0 then
					BV.velocity = moveDirection.Unit * currentFlySpeed
				else
					BV.velocity = Vector3.new(0, 0, 0)
				end
				
				BG.cframe = cam.CFrame
			end)
		else
			FlyBtn.Text = "🚀 Fly: OFF"
			FlyBtn.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
			FlyStroke.Color = Color3.fromRGB(0, 160, 255)
			
			-- Stop flying
			if flyConnection then
				flyConnection:Disconnect()
				flyConnection = nil
			end
			
			-- Remove fly components
			if BG then BG:Destroy() BG = nil end
			if BV then BV:Destroy() BV = nil end
			
			-- Re-enable humanoid states
			humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
			humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
			humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, true)
			humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
			humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
			humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
		end
	end)

	-- Anti-Fall / Infinite Platform Section
	local AntiFallLabel = Instance.new("TextLabel", MovementPage)
	AntiFallLabel.Position = UDim2.new(0, 5, 0, 435)
	AntiFallLabel.Size = UDim2.new(1, -10, 0, 30)
	AntiFallLabel.BackgroundTransparency = 1
	AntiFallLabel.Text = "🌊 Anti-Fall (Walk on Air)"
	AntiFallLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	AntiFallLabel.Font = Enum.Font.GothamBold
	AntiFallLabel.TextSize = 16
	AntiFallLabel.TextXAlignment = Enum.TextXAlignment.Left

	local AntiFallBtn = Instance.new("TextButton", MovementPage)
	AntiFallBtn.Position = UDim2.new(0, 5, 0, 470)
	AntiFallBtn.Size = UDim2.new(1, -10, 0, 45)
	AntiFallBtn.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
	AntiFallBtn.Text = "🌊 Anti-Fall: OFF"
	AntiFallBtn.Font = Enum.Font.GothamBold
	AntiFallBtn.TextSize = 16
	AntiFallBtn.TextColor3 = Color3.fromRGB(0, 190, 255)
	AntiFallBtn.BorderSizePixel = 0
	local AntiFallCorner = Instance.new("UICorner", AntiFallBtn)
	AntiFallCorner.CornerRadius = UDim.new(0, 10)
	local AntiFallStroke = Instance.new("UIStroke", AntiFallBtn)
	AntiFallStroke.Color = Color3.fromRGB(0, 160, 255)
	AntiFallStroke.Thickness = 2

	local antifallEnabled = false
	local antifallPart = nil
	local antifallConnection = nil

	AntiFallBtn.MouseButton1Click:Connect(function()
		antifallEnabled = not antifallEnabled
		
		if antifallEnabled then
			AntiFallBtn.Text = "🌊 Anti-Fall: ON"
			AntiFallBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 50)
			AntiFallStroke.Color = Color3.fromRGB(0, 255, 100)
			
			-- Create invisible platform
			antifallPart = Instance.new("Part")
			antifallPart.Name = "AntiFallPlatform"
			antifallPart.Size = Vector3.new(10, 1, 10)
			antifallPart.Anchored = true
			antifallPart.Transparency = 1
			antifallPart.CanCollide = true
			antifallPart.Material = Enum.Material.ForceField
			antifallPart.Parent = workspace
			
			-- Update platform position
			antifallConnection = game:GetService("RunService").Heartbeat:Connect(function()
				if antifallEnabled and antifallPart and hrp then
					-- Position platform slightly below player
					antifallPart.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y - 3.5, hrp.Position.Z)
				end
			end)
		else
			AntiFallBtn.Text = "🌊 Anti-Fall: OFF"
			AntiFallBtn.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
			AntiFallStroke.Color = Color3.fromRGB(0, 160, 255)
			
			-- Stop anti-fall
			if antifallConnection then
				antifallConnection:Disconnect()
				antifallConnection = nil
			end
			
			if antifallPart then
				antifallPart:Destroy()
				antifallPart = nil
			end
		end
	end)

	-- Noclip Section
	local NoclipLabel = Instance.new("TextLabel", MovementPage)
	NoclipLabel.Position = UDim2.new(0, 5, 0, 535)
	NoclipLabel.Size = UDim2.new(1, -10, 0, 30)
	NoclipLabel.BackgroundTransparency = 1
	NoclipLabel.Text = "👻 Noclip Mode (Walk Through Walls)"
	NoclipLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	NoclipLabel.Font = Enum.Font.GothamBold
	NoclipLabel.TextSize = 16
	NoclipLabel.TextXAlignment = Enum.TextXAlignment.Left

	local NoclipBtn = Instance.new("TextButton", MovementPage)
	NoclipBtn.Position = UDim2.new(0, 5, 0, 570)
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
	local noclipConnection
	
	NoclipBtn.MouseButton1Click:Connect(function()
		noclip = not noclip
		if noclip then
			NoclipBtn.Text = "👻 Noclip: ON"
			NoclipBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 50)
			NoclipStroke.Color = Color3.fromRGB(0, 255, 100)
			
			noclipConnection = game:GetService("RunService").Stepped:Connect(function()
				if noclip then
					for _, v in pairs(character:GetDescendants()) do
						if v:IsA("BasePart") then
							v.CanCollide = false
						end
					end
				end
			end)
		else
			NoclipBtn.Text = "👻 Noclip: OFF"
			NoclipBtn.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
			NoclipStroke.Color = Color3.fromRGB(0, 160, 255)
			
			if noclipConnection then
				noclipConnection:Disconnect()
				noclipConnection = nil
			end
			
			-- Re-enable collision
			for _, v in pairs(character:GetDescendants()) do
				if v:IsA("BasePart") then
					v.CanCollide = true
				end
			end
		end
	end)

	-- Infinite Jump Section
	local InfJumpLabel = Instance.new("TextLabel", MovementPage)
	InfJumpLabel.Position = UDim2.new(0, 5, 0, 635)
	InfJumpLabel.Size = UDim2.new(1, -10, 0, 30)
	InfJumpLabel.BackgroundTransparency = 1
	InfJumpLabel.Text = "🌟 Infinite Jump"
	InfJumpLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	InfJumpLabel.Font = Enum.Font.GothamBold
	InfJumpLabel.TextSize = 16
	InfJumpLabel.TextXAlignment = Enum.TextXAlignment.Left

	local InfJumpBtn = Instance.new("TextButton", MovementPage)
	InfJumpBtn.Position = UDim2.new(0, 5, 0, 670)
	InfJumpBtn.Size = UDim2.new(1, -10, 0, 45)
	InfJumpBtn.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
	InfJumpBtn.Text = "🌟 Infinite Jump: OFF"
	InfJumpBtn.Font = Enum.Font.GothamBold
	InfJumpBtn.TextSize = 16
	InfJumpBtn.TextColor3 = Color3.fromRGB(0, 190, 255)
	InfJumpBtn.BorderSizePixel = 0
	local InfJumpCorner = Instance.new("UICorner", InfJumpBtn)
	InfJumpCorner.CornerRadius = UDim.new(0, 10)
	local InfJumpStroke = Instance.new("UIStroke", InfJumpBtn)
	InfJumpStroke.Color = Color3.fromRGB(0, 160, 255)
	InfJumpStroke.Thickness = 2

	local infJump = false
	local infJumpConnection
	
	InfJumpBtn.MouseButton1Click:Connect(function()
		infJump = not infJump
		if infJump then
			InfJumpBtn.Text = "🌟 Infinite Jump: ON"
			InfJumpBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 50)
			InfJumpStroke.Color = Color3.fromRGB(0, 255, 100)
			
			infJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
				if infJump and humanoid then
					humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end)
		else
			InfJumpBtn.Text = "🌟 Infinite Jump: OFF"
			InfJumpBtn.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
			InfJumpStroke.Color = Color3.fromRGB(0, 160, 255)
			
			if infJumpConnection then
				infJumpConnection:Disconnect()
				infJumpConnection = nil
			end
		end
	end)

	-- Cleanup when character dies
	humanoid.Died:Connect(function()
		if flyConnection then flyConnection:Disconnect() end
		if BG then BG:Destroy() end
		if BV then BV:Destroy() end
		if antifallConnection then antifallConnection:Disconnect() end
		if antifallPart then antifallPart:Destroy() end
		if noclipConnection then noclipConnection:Disconnect() end
		if infJumpConnection then infJumpConnection:Disconnect() end
		
		flying = false
		antifallEnabled = false
		noclip = false
		infJump = false
	end)
	
	-- Set canvas size
	MovementPage.CanvasSize = UDim2.new(0, 0, 0, 730)
end

return MovementModule
