-- Utilities.lua
-- Upload file ini ke GitHub repository kamu

local UtilitiesModule = {}

function UtilitiesModule.Initialize(UtilitiesPage, player, character)
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

	-- Player List Container
	local PlayerListContainer = Instance.new("ScrollingFrame", UtilitiesPage)
	PlayerListContainer.Position = UDim2.new(0, 5, 0, 85)
	PlayerListContainer.Size = UDim2.new(1, -10, 0, 120)
	PlayerListContainer.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
	PlayerListContainer.BorderSizePixel = 0
	PlayerListContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
	PlayerListContainer.ScrollBarThickness = 8
	PlayerListContainer.ScrollBarImageColor3 = Color3.fromRGB(0, 160, 255)
	Instance.new("UICorner", PlayerListContainer)
	Instance.new("UIListLayout", PlayerListContainer).Padding = UDim.new(0, 5)

	local function UpdatePlayerList()
		PlayerListContainer:ClearAllChildren()
		local uiListLayout = Instance.new("UIListLayout", PlayerListContainer)
		uiListLayout.Padding = UDim.new(0, 5)

		for _, v in pairs(game.Players:GetPlayers()) do
			if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
				local PlayerButton = Instance.new("TextButton", PlayerListContainer)
				PlayerButton.Size = UDim2.new(1, -10, 0, 30)
				PlayerButton.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
				PlayerButton.Text = v.Name
				PlayerButton.Font = Enum.Font.Gotham
				PlayerButton.TextSize = 13
				PlayerButton.TextColor3 = Color3.fromRGB(0, 190, 255)
				Instance.new("UICorner", PlayerButton)
				Instance.new("UIStroke", PlayerButton).Color = Color3.fromRGB(0, 140, 220)

				PlayerButton.MouseButton1Click:Connect(function()
					TeleportBox.Text = v.Name
					if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
						character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
					end
				end)
			end
		end

		PlayerListContainer.CanvasSize = UDim2.new(0, 0, 0, uiListLayout.AbsoluteContentSize.Y + 10)
	end

	-- Update player list when players join/leave
	game.Players.PlayerAdded:Connect(UpdatePlayerList)
	game.Players.PlayerRemoving:Connect(UpdatePlayerList)

	-- Initial update
	UpdatePlayerList()

	local TeleportBtn = Instance.new("TextButton", UtilitiesPage)
	TeleportBtn.Position = UDim2.new(0, 5, 0, 210)
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

	-- Copy Avatar Section
	local AvatarLabel = Instance.new("TextLabel", UtilitiesPage)
	AvatarLabel.Position = UDim2.new(0, 5, 0, 260)
	AvatarLabel.Size = UDim2.new(1, -10, 0, 30)
	AvatarLabel.BackgroundTransparency = 1
	AvatarLabel.Text = "Copy Avatar"
	AvatarLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	AvatarLabel.Font = Enum.Font.GothamBold
	AvatarLabel.TextSize = 16

	local AvatarBox = Instance.new("TextBox", UtilitiesPage)
	AvatarBox.Position = UDim2.new(0, 5, 0, 295)
	AvatarBox.Size = UDim2.new(1, -10, 0, 35)
	AvatarBox.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
	AvatarBox.PlaceholderText = "Enter player name to copy..."
	AvatarBox.Text = ""
	AvatarBox.Font = Enum.Font.Gotham
	AvatarBox.TextSize = 14
	AvatarBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	Instance.new("UICorner", AvatarBox)

	local CopyAvatarBtn = Instance.new("TextButton", UtilitiesPage)
	CopyAvatarBtn.Position = UDim2.new(0, 5, 0, 335)
	CopyAvatarBtn.Size = UDim2.new(1, -10, 0, 40)
	CopyAvatarBtn.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
	CopyAvatarBtn.Text = "Copy Avatar"
	CopyAvatarBtn.Font = Enum.Font.GothamBold
	CopyAvatarBtn.TextSize = 14
	CopyAvatarBtn.TextColor3 = Color3.fromRGB(0, 190, 255)
	Instance.new("UIStroke", CopyAvatarBtn).Color = Color3.fromRGB(0, 160, 255)
	Instance.new("UICorner", CopyAvatarBtn)

	CopyAvatarBtn.MouseButton1Click:Connect(function()
		local targetName = AvatarBox.Text
		for _, v in pairs(game.Players:GetPlayers()) do
			if v.Name:lower():find(targetName:lower()) and v.Character then
				local targetChar = v.Character
				
				-- Remove current appearance
				for _, obj in pairs(character:GetChildren()) do
					if obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("ShirtGraphic") then
						obj:Destroy()
					elseif obj:IsA("Accessory") or obj:IsA("Hat") then
						obj:Destroy()
					end
				end
				
				-- Copy appearance from target
				for _, obj in pairs(targetChar:GetChildren()) do
					if obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("ShirtGraphic") then
						obj:Clone().Parent = character
					elseif obj:IsA("Accessory") or obj:IsA("Hat") then
						obj:Clone().Parent = character
					end
				end
				
				-- Copy body colors
				if targetChar:FindFirstChild("Body Colors") then
					local bc = character:FindFirstChild("Body Colors") or Instance.new("BodyColors", character)
					local tbc = targetChar["Body Colors"]
					bc.HeadColor = tbc.HeadColor
					bc.TorsoColor = tbc.TorsoColor
					bc.LeftArmColor = tbc.LeftArmColor
					bc.RightArmColor = tbc.RightArmColor
					bc.LeftLegColor = tbc.LeftLegColor
					bc.RightLegColor = tbc.RightLegColor
				end
				
				-- Copy face
				local head = character:FindFirstChild("Head")
				if head then
					local face = head:FindFirstChildOfClass("Decal")
					local targetHead = targetChar:FindFirstChild("Head")
					if targetHead then
						local targetFace = targetHead:FindFirstChildOfClass("Decal")
						if face and targetFace then
							face.Texture = targetFace.Texture
						end
					end
				end
				break
			end
		end
	end)

	-- ESP Button
	local ESPBtn = Instance.new("TextButton", UtilitiesPage)
	ESPBtn.Position = UDim2.new(0, 5, 0, 390)
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
		for _, v in pairs(game.Players:GetPlayers()) do
			if v ~= player and v.Character then
				if esp then
					if not v.Character:FindFirstChild("Highlight") then
						local highlight = Instance.new("Highlight", v.Character)
						highlight.FillColor = Color3.fromRGB(0, 200, 255)
						highlight.OutlineColor = Color3.fromRGB(0, 150, 255)
					end
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
	BrightBtn.Position = UDim2.new(0, 5, 0, 440)
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
end

return UtilitiesModule
