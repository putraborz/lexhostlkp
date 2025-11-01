-- Movement.lua
local MovementModule = {}

function MovementModule.Initialize(MovementPage, player, character)
	-- Speed Label
	local SpeedLabel = Instance.new("TextLabel", MovementPage)
	SpeedLabel.Position = UDim2.new(0, 5, 0, 10)
	SpeedLabel.Size = UDim2.new(1, -10, 0, 30)
	SpeedLabel.BackgroundTransparency = 1
	SpeedLabel.Text = "WalkSpeed: 16"
	SpeedLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	SpeedLabel.Font = Enum.Font.GothamBold
	SpeedLabel.TextSize = 14

	-- Jump Label
	local JumpLabel = Instance.new("TextLabel", MovementPage)
	JumpLabel.Position = UDim2.new(0, 5, 0, 80)
	JumpLabel.Size = UDim2.new(1, -10, 0, 30)
	JumpLabel.BackgroundTransparency = 1
	JumpLabel.Text = "JumpPower: 50"
	JumpLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	JumpLabel.Font = Enum.Font.GothamBold
	JumpLabel.TextSize = 14

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
end

return MovementModule
