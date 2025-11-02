-- Clone.lua - Enhanced Avatar Cloning Module
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
	CloneDesc.Text = "Clone appearance by Username or DisplayName (Advanced Method)"
	CloneDesc.TextColor3 = Color3.fromRGB(150, 200, 255)
	CloneDesc.Font = Enum.Font.Gotham
	CloneDesc.TextSize = 14
	CloneDesc.TextXAlignment = Enum.TextXAlignment.Left

	-- Advanced Clone Function
	local function safeApplyDescriptionToCharacter(character, humanoidDescription)
		if not character or not humanoidDescription then return false, "Character/Description nil" end
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local hrp = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
		if not humanoid then return false, "Humanoid not found" end
		
		-- Simpan state anchor sementara
		local anchoredParts = {}
		if hrp and hrp:IsA("BasePart") then
			anchoredParts[#anchoredParts+1] = hrp
			hrp.Anchored = true
		end
		
		local prevPlatformStand = humanoid.PlatformStand
		humanoid.PlatformStand = true
		
		local ok, err = pcall(function()
			humanoid:ApplyDescription(humanoidDescription)
		end)
		
		wait(0.15)
		humanoid.PlatformStand = prevPlatformStand
		
		for _, part in ipairs(anchoredParts) do
			if part and part:IsA("BasePart") then
				part.Anchored = false
			end
		end
		
		if not ok then
			return false, tostring(err)
		end
		
		return true
	end

	local function changeAvatarByUsername(targetUsername)
		local success, targetId = pcall(function()
			return game.Players:GetUserIdFromNameAsync(targetUsername)
		end)
		
		if not success or not targetId then
			return false, "User not found: " .. tostring(targetUsername)
		end
		
		local humanoidDescription
		local ok, err = pcall(function()
			humanoidDescription = game.Players:GetHumanoidDescriptionFromUserId(targetId)
		end)
		
		if not ok or not humanoidDescription then
			return false, "Failed to get description: " .. tostring(err)
		end
		
		local char = player.Character
		if not char or not char.Parent then
			return false, "Character not spawned"
		end
		
		local applied, reason = safeApplyDescriptionToCharacter(char, humanoidDescription)
		if not applied then
			return false, reason
		end
		
		return true
	end

	-- Search by Username
	local UsernameLabel = Instance.new("TextLabel", ClonePage)
	UsernameLabel.Size = UDim2.new(1, -10, 0, 25)
	UsernameLabel.Position = UDim2.new(0, 5, 0, 100)
	UsernameLabel.BackgroundTransparency = 1
	UsernameLabel.Text = "🔹 Clone by Username (Advanced)"
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

	-- Clone by Username Button
	local CloneUsernameBtn = Instance.new("TextButton", ClonePage)
	CloneUsernameBtn.Size = UDim2.new(1, -10, 0, 45)
	CloneUsernameBtn.Position = UDim2.new(0, 5, 0, 180)
	CloneUsernameBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
	CloneUsernameBtn.Text = "🎭 Clone Avatar (Advanced)"
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
			CloneUsernameBtn.Text = "⏳ Cloning..."
			CloneUsernameBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 0)
			
			local success, reason = changeAvatarByUsername(username)
			
			if success then
				CloneUsernameBtn.Text = "✅ Cloned: " .. username
				CloneUsernameBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
			else
				CloneUsernameBtn.Text = "❌ Failed"
				CloneUsernameBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
				warn("Clone Error: " .. tostring(reason))
			end
			
			wait(2)
			CloneUsernameBtn.Text = "🎭 Clone Avatar (Advanced)"
			CloneUsernameBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
		end
	end)

	-- Search by DisplayName (In-Server Players)
	local DisplayLabel = Instance.new("TextLabel", ClonePage)
	DisplayLabel.Size = UDim2.new(1, -10, 0, 25)
	DisplayLabel.Position = UDim2.new(0, 5, 0, 245)
	DisplayLabel.BackgroundTransparency = 1
	DisplayLabel.Text = "🔹 Clone by DisplayName (In-Server)"
	DisplayLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
	DisplayLabel.Font = Enum.Font.GothamBold
	DisplayLabel.TextSize = 15
	DisplayLabel.TextXAlignment = Enum.TextXAlignment.Left

	local DisplayBox = Instance.new("TextBox", ClonePage)
	DisplayBox.Size = UDim2.new(1, -10, 0, 40)
	DisplayBox.Position = UDim2.new(0, 5, 0, 275)
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
			CloneDisplayBtn.Text = "⏳ Searching..."
			CloneDisplayBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 0)
			
			local found = false
			for _, v in pairs(game.Players:GetPlayers()) do
				if v.DisplayName:lower():find(displayname:lower()) then
					local success, reason = changeAvatarByUsername(v.Name)
					if success then
						CloneDisplayBtn.Text = "✅ Cloned: " .. v.DisplayName
						CloneDisplayBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
					else
						CloneDisplayBtn.Text = "❌ Failed"
						CloneDisplayBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
					end
					found = true
					break
				end
			end
			
			if not found then
				CloneDisplayBtn.Text = "❌ Player Not Found"
				CloneDisplayBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
			end
			
			wait(2)
			CloneDisplayBtn.Text = "🎭 Clone by DisplayName"
			CloneDisplayBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 200)
		end
	end)
end

return CloneModule
