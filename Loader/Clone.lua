-- Clone.lua - Avatar Cloning Module
local CloneModule = {}

function CloneModule.Initialize(ClonePage, player, character)
	
	local CloneTitle = Instance.new("TextLabel", ClonePage)
	CloneTitle.Size = UDim2.new(1, -10, 0, 40)
	CloneTitle.Position = UDim2.new(0, 5, 0, 10)
	CloneTitle.BackgroundTransparency = 1
	CloneTitle.Text = "🎭 Clone Player Avatar"
	CloneTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
	CloneTitle.Font = Enum.Font.GothamBold
	CloneTitle.TextSize = 20
	CloneTitle.TextXAlignment = Enum.TextXAlignment.Left

	local CloneDesc = Instance.new("TextLabel", ClonePage)
	CloneDesc.Size = UDim2.new(1, -10, 0, 30)
	CloneDesc.Position = UDim2.new(0, 5, 0, 55)
	CloneDesc.BackgroundTransparency = 1
	CloneDesc.Text = "Copy appearance by Username or DisplayName"
	CloneDesc.TextColor3 = Color3.fromRGB(150, 200, 255)
	CloneDesc.Font = Enum.Font.Gotham
	CloneDesc.TextSize = 14
	CloneDesc.TextXAlignment = Enum.TextXAlignment.Left

	-- Search by Username
	local UsernameLabel = Instance.new("TextLabel", ClonePage)
	UsernameLabel.Size = UDim2.new(1, -10, 0, 25)
	UsernameLabel.Position = UDim2.new(0, 5, 0, 100)
	UsernameLabel.BackgroundTransparency = 1
	UsernameLabel.Text = "🔹 Search by Username:"
	UsernameLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	UsernameLabel.Font = Enum.Font.GothamBold
	UsernameLabel.TextSize = 15
	UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left

	local UsernameBox = Instance.new("TextBox", ClonePage)
	UsernameBox.Size = UDim2.new(1, -10, 0, 40)
	UsernameBox.Position = UDim2.new(0, 5, 0, 130)
	UsernameBox.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
	UsernameBox.PlaceholderText = "Type username (e.g., Roblox)"
	UsernameBox.Text = ""
	UsernameBox.Font = Enum.Font.Gotham
	UsernameBox.TextSize = 14
	UsernameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	UsernameBox.BorderSizePixel = 0
	local UsernameCorner = Instance.new("UICorner", UsernameBox)
	UsernameCorner.CornerRadius = UDim.new(0, 8)
	local UsernameStroke = Instance.new("UIStroke", UsernameBox)
	UsernameStroke.Color = Color3.fromRGB(0, 160, 255)
	UsernameStroke.Thickness = 2

	-- Search by DisplayName
	local DisplayLabel = Instance.new("TextLabel", ClonePage)
	DisplayLabel.Size = UDim2.new(1, -10, 0, 25)
	DisplayLabel.Position = UDim2.new(0, 5, 0, 185)
	DisplayLabel.BackgroundTransparency = 1
	DisplayLabel.Text = "🔹 Search by DisplayName:"
	DisplayLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	DisplayLabel.Font = Enum.Font.GothamBold
	DisplayLabel.TextSize = 15
	DisplayLabel.TextXAlignment = Enum.TextXAlignment.Left

	local DisplayBox = Instance.new("TextBox", ClonePage)
	DisplayBox.Size = UDim2.new(1, -10, 0, 40)
	DisplayBox.Position = UDim2.new(0, 5, 0, 215)
	DisplayBox.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
	DisplayBox.PlaceholderText = "Type display name"
	DisplayBox.Text = ""
	DisplayBox.Font = Enum.Font.Gotham
	DisplayBox.TextSize = 14
	DisplayBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	DisplayBox.BorderSizePixel = 0
	local DisplayCorner = Instance.new("UICorner", DisplayBox)
	DisplayCorner.CornerRadius = UDim.new(0, 8)
	local DisplayStroke = Instance.new("UIStroke", DisplayBox)
	DisplayStroke.Color = Color3.fromRGB(0, 160, 255)
	DisplayStroke.Thickness = 2

	-- Clone Function
	local function CloneAvatar(targetPlayer)
		if not targetPlayer or not targetPlayer.Character then return false end
		
		local targetChar = targetPlayer.Character
		
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
		
		return true
	end

	-- Clone by Username Button
	local CloneUsernameBtn = Instance.new("TextButton", ClonePage)
	CloneUsernameBtn.Size = UDim2.new(1, -10, 0, 45)
	CloneUsernameBtn.Position = UDim2.new(0, 5, 0, 270)
	CloneUsernameBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
	CloneUsernameBtn.Text = "🎭 Clone by Username"
	CloneUsernameBtn.Font = Enum.Font.GothamBold
	CloneUsernameBtn.TextSize = 16
	CloneUsernameBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloneUsernameBtn.BorderSizePixel = 0
	local CloneUserCorner = Instance.new("UICorner", CloneUsernameBtn)
	CloneUserCorner.CornerRadius = UDim.new(0, 10)
	CloneUsernameBtn.MouseEnter:Connect(function() CloneUsernameBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 240) end)
	CloneUsernameBtn.MouseLeave:Connect(function() CloneUsernameBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200) end)

	CloneUsernameBtn.MouseButton1Click:Connect(function()
		local username = UsernameBox.Text
		if username ~= "" then
			for _, v in pairs(game.Players:GetPlayers()) do
				if v.Name:lower() == username:lower() or v.Name:lower():find(username:lower()) then
					if CloneAvatar(v) then
						CloneUsernameBtn.Text = "✅ Cloned: " .. v.Name
						wait(2)
						CloneUsernameBtn.Text = "🎭 Clone by Username"
					end
					return
				end
			end
			CloneUsernameBtn.Text = "❌ Player Not Found"
			wait(2)
			CloneUsernameBtn.Text = "🎭 Clone by Username"
		end
	end)

	-- Clone by DisplayName Button
	local CloneDisplayBtn = Instance.new("TextButton", ClonePage)
	CloneDisplayBtn.Size = UDim2.new(1, -10, 0, 45)
	CloneDisplayBtn.Position = UDim2.new(0, 5, 0, 325)
	CloneDisplayBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 200)
	CloneDisplayBtn.Text = "🎭 Clone by DisplayName"
	CloneDisplayBtn.Font = Enum.Font.GothamBold
	CloneDisplayBtn.TextSize = 16
	CloneDisplayBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloneDisplayBtn.BorderSizePixel = 0
	local CloneDispCorner = Instance.new("UICorner", CloneDisplayBtn)
	CloneDispCorner.CornerRadius = UDim.new(0, 10)
	CloneDisplayBtn.MouseEnter:Connect(function() CloneDisplayBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 240) end)
	CloneDisplayBtn.MouseLeave:Connect(function() CloneDisplayBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 200) end)

	CloneDisplayBtn.MouseButton1Click:Connect(function()
		local displayname = DisplayBox.Text
		if displayname ~= "" then
			for _, v in pairs(game.Players:GetPlayers()) do
				if v.DisplayName:lower() == displayname:lower() or v.DisplayName:lower():find(displayname:lower()) then
					if CloneAvatar(v) then
						CloneDisplayBtn.Text = "✅ Cloned: " .. v.DisplayName
						wait(2)
						CloneDisplayBtn.Text = "🎭 Clone by DisplayName"
					end
					return
				end
			end
			CloneDisplayBtn.Text = "❌ Player Not Found"
			wait(2)
			CloneDisplayBtn.Text = "🎭 Clone by DisplayName"
		end
	end)
end

return CloneModule
